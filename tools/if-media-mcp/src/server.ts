import { access, open, readFile, readdir, stat, unlink, writeFile } from "node:fs/promises";
import path from "node:path";
import { McpServer } from "@modelcontextprotocol/server";
import OpenAI, { toFile } from "openai";
import * as z from "zod/v4";
import {
  findGraphPython,
  findHemtt,
  findImageToPaa,
  findPowerShell,
  findRasterizer,
  findResvg,
  findSqfvm,
  findVtracer,
  rasterizeSvg,
  renderPreviewWithResvg,
  runCommand,
  runSqfTest,
  vectorizeWithVtracer
} from "./executables.js";
import {
  manifestFor,
  MAX_IMAGE_BYTES,
  MAX_MASK_BYTES,
  MAX_SQF_BYTES,
  MAX_SVG_BYTES,
  MediaWorkspace,
  mediaTypeFor,
  sha256,
  type AssetManifest
} from "./workspace.js";

const IMAGE_EXTENSIONS = [".png", ".jpg", ".jpeg", ".webp"] as const;
const OUTPUT_FORMATS = ["png", "jpeg", "webp"] as const;
const IMAGE_SIZES = ["1024x1024", "1536x1024", "1024x1536"] as const;
const TEXTURE_SIZES = [64, 128, 256, 512, 1024, 2048] as const;
const PREVIEW_SIZES = [32, 64, 128, 256] as const;
const VTRACER_PRESETS = ["bw", "poster", "photo"] as const;
const MODEL_ALLOWLIST = new Set(["gpt-image-2", "gpt-image-2-2026-04-21"]);
const REMOTE_MODES = new Set(["auto", "disabled"]);
const textureSizeSchema = z.union([
  z.literal(64),
  z.literal(128),
  z.literal(256),
  z.literal(512),
  z.literal(1024),
  z.literal(2048)
]);
const previewSizeSchema = z.union([
  z.literal(32),
  z.literal(64),
  z.literal(128),
  z.literal(256)
]);

type OutputFormat = typeof OUTPUT_FORMATS[number];

function textResult(payload: Record<string, unknown>) {
  return { content: [{ type: "text" as const, text: JSON.stringify(payload, null, 2) }] };
}

function errorResult(error: unknown) {
  const message = error instanceof Error ? error.message : String(error);
  return {
    isError: true,
    content: [{ type: "text" as const, text: message.slice(0, 2_000) }]
  };
}

function modelName(): string {
  const model = process.env.IF_MEDIA_OPENAI_MODEL || "gpt-image-2";
  if (!MODEL_ALLOWLIST.has(model)) {
    throw new Error(`IF_MEDIA_OPENAI_MODEL no permitido: ${model}.`);
  }
  return model;
}

async function requireAbsent(target: string, workspace: MediaWorkspace): Promise<void> {
  await access(target).then(
    () => { throw new Error(`La salida ya existe y no será sobrescrita: ${workspace.relative(target)}.`); },
    () => undefined
  );
}

function remoteMode(): "auto" | "disabled" {
  const mode = process.env.IF_MEDIA_REMOTE_MODE?.trim().toLowerCase() || "auto";
  if (!REMOTE_MODES.has(mode)) {
    throw new Error(`IF_MEDIA_REMOTE_MODE no permitido: ${mode}. Usa auto o disabled.`);
  }
  return mode as "auto" | "disabled";
}

function requireApiKey(): string {
  if (remoteMode() === "disabled") {
    throw new Error("Generación remota desactivada por IF_MEDIA_REMOTE_MODE. En Codex usa el generador de imágenes nativo; el MCP conserva el procesamiento y la procedencia local.");
  }
  const key = process.env.OPENAI_API_KEY?.trim();
  if (!key) {
    throw new Error("Falta OPENAI_API_KEY en el entorno del proceso MCP. No se ha realizado ninguna llamada ni generado coste.");
  }
  return key;
}

function imageData(response: { data?: Array<{ b64_json?: string }> }): { base64: string; bytes: Buffer } {
  const base64 = response.data?.[0]?.b64_json;
  if (!base64 || !/^[A-Za-z0-9+/=\r\n]+$/.test(base64)) {
    throw new Error("El proveedor no devolvió una imagen base64 válida.");
  }
  const bytes = Buffer.from(base64, "base64");
  if (bytes.byteLength === 0 || bytes.byteLength > MAX_IMAGE_BYTES) {
    throw new Error(`La imagen devuelta supera el límite local de ${MAX_IMAGE_BYTES} bytes o está vacía.`);
  }
  return { base64, bytes };
}

class ApiRateLimiter {
  private readonly timestamps: number[] = [];
  private readonly maxCalls: number;

  constructor(private readonly windowMs = 60_000) {
    const requested = Number.parseInt(process.env.IF_MEDIA_MAX_API_CALLS || "5", 10);
    this.maxCalls = Number.isFinite(requested) ? Math.min(Math.max(requested, 1), 20) : 5;
  }

  consume(): void {
    const now = Date.now();
    while (this.timestamps.length > 0 && this.timestamps[0]! <= now - this.windowMs) {
      this.timestamps.shift();
    }
    if (this.timestamps.length >= this.maxCalls) {
      throw new Error(`Límite local alcanzado: ${this.maxCalls} llamadas de imagen por minuto.`);
    }
    this.timestamps.push(now);
  }
}

export class MediaService {
  readonly workspace: MediaWorkspace;
  private readonly limiter = new ApiRateLimiter();

  constructor(workspace: MediaWorkspace) {
    this.workspace = workspace;
  }

  private async persistOutput(target: string, data: Buffer, manifest: AssetManifest): Promise<string> {
    await this.workspace.writeNewFile(target, data);
    try {
      return await this.workspace.writeManifest(manifest);
    } catch (error) {
      await unlink(target).catch(() => undefined);
      throw error;
    }
  }

  async status(): Promise<Record<string, unknown>> {
    const [rasterizer, imageToPaa, hemtt, resvg, vtracer, sqfvm, powerShell] = await Promise.all([
      findRasterizer(),
      findImageToPaa(),
      findHemtt(),
      findResvg(),
      findVtracer(),
      findSqfvm(),
      findPowerShell()
    ]);
    const blockers: string[] = [];
    const configuredModel = process.env.IF_MEDIA_OPENAI_MODEL || "gpt-image-2";
    const configuredRemoteMode = process.env.IF_MEDIA_REMOTE_MODE?.trim().toLowerCase() || "auto";
    const remoteModeValid = REMOTE_MODES.has(configuredRemoteMode);
    const remoteEnabled = configuredRemoteMode === "auto";
    if (!remoteModeValid) blockers.push(`IF_MEDIA_REMOTE_MODE no permitido: ${configuredRemoteMode}.`);
    if (remoteEnabled && !process.env.OPENAI_API_KEY?.trim()) blockers.push("OPENAI_API_KEY no configurada: generación y edición remotas no disponibles.");
    if (remoteEnabled && !MODEL_ALLOWLIST.has(configuredModel)) blockers.push(`IF_MEDIA_OPENAI_MODEL no permitido: ${configuredModel}.`);
    if (!rasterizer) blockers.push("Rasterizador SVG no encontrado: instala Inkscape y reinicia VS Code.");
    if (!imageToPaa && !hemtt) blockers.push("Ni ImageToPAA ni HEMTT encontrados: instala Arma 3 Tools (Steam appid 233800), o HEMTT (github.com/BrettMayson/HEMTT) como alternativa sin Steam, y define IF_ARMA3_TOOLS/IF_HEMTT si no está en PATH.");
    if (!resvg) blockers.push("resvg no encontrado: media_render_preview no disponible hasta instalar resvg (github.com/linebender/resvg) o definir IF_RESVG.");
    if (!vtracer) blockers.push("VTracer no encontrado: media_vectorize_raster no disponible hasta instalar VTracer (github.com/visioncortex/vtracer) o definir IF_VTRACER.");
    if (!sqfvm) blockers.push("SQF-VM no encontrado: arma_test no disponible hasta instalar SQF-VM (github.com/SQFvm/runtime) o definir IF_SQFVM.");
    return {
      project_root: this.workspace.projectRoot,
      drafts_root: this.workspace.relative(this.workspace.draftsRoot),
      manifests_root: this.workspace.relative(this.workspace.manifestsRoot),
      remote_mode: configuredRemoteMode,
      remote_generation: remoteEnabled && remoteModeValid
        ? (process.env.OPENAI_API_KEY?.trim() ? "ready" : "blocked")
        : "disabled_by_configuration",
      provider: remoteEnabled ? "openai" : "none",
      model: configuredModel,
      api_key_configured: Boolean(process.env.OPENAI_API_KEY?.trim()),
      rasterizer,
      image_to_paa: imageToPaa,
      hemtt,
      resvg,
      vtracer,
      sqfvm,
      powershell: powerShell,
      blockers
    };
  }

  async generate(input: {
    prompt: string;
    output_name: string;
    size: typeof IMAGE_SIZES[number];
    quality: "auto" | "low" | "medium" | "high";
    background: "auto" | "opaque";
    output_format: OutputFormat;
  }) {
    const target = await this.workspace.draftPath(input.output_name, input.output_format);
    await requireAbsent(target, this.workspace);
    const key = requireApiKey();
    this.limiter.consume();
    const model = modelName();
    const promptHash = sha256(input.prompt);
    try {
      const client = new OpenAI({ apiKey: key });
      const response = await client.images.generate({
        model,
        prompt: input.prompt,
        n: 1,
        size: input.size,
        quality: input.quality,
        background: input.background,
        output_format: input.output_format
      });
      const { base64, bytes } = imageData(response);
      const manifest = manifestFor(this.workspace, target, bytes, "proposal", {
        kind: "generated",
        provider: "OpenAI",
        model,
        license: "OpenAI API terms applicable at generation time",
        prompt: input.prompt,
        description: null,
        source_paths: []
      });
      const manifestPath = await this.persistOutput(target, bytes, manifest);
      await this.workspace.appendAudit("media_generate", "ok", { asset_id: manifest.asset_id, prompt_sha256: promptHash });
      return {
        content: [
          { type: "text" as const, text: JSON.stringify({ path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256, status: manifest.status }, null, 2) },
          { type: "image" as const, data: base64, mimeType: mediaTypeFor(`.${input.output_format}`) }
        ]
      };
    } catch (error) {
      await this.workspace.appendAudit("media_generate", "error", { prompt_sha256: promptHash });
      throw error;
    }
  }

  async edit(input: {
    input_path: string;
    mask_path?: string | undefined;
    prompt: string;
    output_name: string;
    size: typeof IMAGE_SIZES[number];
    quality: "auto" | "low" | "medium" | "high";
    background: "auto" | "opaque";
    output_format: OutputFormat;
    input_fidelity: "low" | "high";
  }) {
    const inputPath = await this.workspace.resolveInput(input.input_path, IMAGE_EXTENSIONS, MAX_IMAGE_BYTES);
    const maskPath = input.mask_path
      ? await this.workspace.resolveInput(input.mask_path, [".png"], MAX_MASK_BYTES)
      : undefined;
    const target = await this.workspace.draftPath(input.output_name, input.output_format);
    await requireAbsent(target, this.workspace);
    const key = requireApiKey();
    this.limiter.consume();
    const model = modelName();
    const promptHash = sha256(input.prompt);
    try {
      const imageBytes = await readFile(inputPath);
      const image = await toFile(imageBytes, path.basename(inputPath), { type: mediaTypeFor(path.extname(inputPath)) });
      const mask = maskPath
        ? await toFile(await readFile(maskPath), path.basename(maskPath), { type: "image/png" })
        : undefined;
      const client = new OpenAI({ apiKey: key });
      const response = await client.images.edit({
        model,
        image,
        ...(mask ? { mask } : {}),
        prompt: input.prompt,
        n: 1,
        size: input.size,
        quality: input.quality,
        background: input.background,
        output_format: input.output_format,
        input_fidelity: input.input_fidelity
      });
      const generated = imageData(response);
      const sourcePaths = [this.workspace.relative(inputPath), ...(maskPath ? [this.workspace.relative(maskPath)] : [])];
      const manifest = manifestFor(this.workspace, target, generated.bytes, "proposal", {
        kind: "edited",
        provider: "OpenAI",
        model,
        license: "OpenAI API terms applicable at generation time",
        prompt: input.prompt,
        description: null,
        source_paths: sourcePaths
      });
      const manifestPath = await this.persistOutput(target, generated.bytes, manifest);
      await this.workspace.appendAudit("media_edit", "ok", { asset_id: manifest.asset_id, prompt_sha256: promptHash });
      return {
        content: [
          { type: "text" as const, text: JSON.stringify({ path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256, status: manifest.status }, null, 2) },
          { type: "image" as const, data: generated.base64, mimeType: mediaTypeFor(`.${input.output_format}`) }
        ]
      };
    } catch (error) {
      await this.workspace.appendAudit("media_edit", "error", { prompt_sha256: promptHash });
      throw error;
    }
  }

  async registerProvenance(input: {
    input_path: string;
    origin_kind: "original" | "third_party" | "generated";
    provider?: string | undefined;
    model?: string | undefined;
    license: string;
    prompt?: string | undefined;
    description?: string | undefined;
  }) {
    const maxBytes = input.input_path.toLowerCase().endsWith(".svg") ? MAX_SVG_BYTES : MAX_IMAGE_BYTES;
    const source = await this.workspace.resolveInput(input.input_path, [...IMAGE_EXTENSIONS, ".svg"], maxBytes);
    const data = await readFile(source);
    const manifest = manifestFor(this.workspace, source, data, input.origin_kind === "third_party" ? "reference" : "proposal", {
      kind: input.origin_kind,
      provider: input.provider ?? null,
      model: input.model ?? null,
      license: input.license,
      prompt: input.prompt ?? null,
      description: input.description ?? null,
      source_paths: []
    });
    const manifestPath = await this.workspace.writeManifest(manifest);
    await this.workspace.appendAudit("media_register_provenance", "ok", { asset_id: manifest.asset_id });
    return textResult({ path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256, status: manifest.status });
  }

  async rasterize(input: { input_path: string; output_name: string; size: typeof TEXTURE_SIZES[number] }) {
    const source = await this.workspace.resolveInput(input.input_path, [".svg"], MAX_SVG_BYTES);
    const rasterizer = await findRasterizer();
    if (!rasterizer) throw new Error("No hay rasterizador SVG. Instala Inkscape o define IF_INKSCAPE.");
    const target = await this.workspace.draftPath(input.output_name, "png");
    await requireAbsent(target, this.workspace);
    const result = await rasterizeSvg(rasterizer, source, target, input.size);
    if (result.code !== 0) throw new Error(`Falló ${rasterizer.name}: ${result.stderr || result.stdout}`);
    const data = await readFile(target);
    const manifest = manifestFor(this.workspace, target, data, "built", {
      kind: "rasterized",
      provider: "local",
      model: rasterizer.name,
      license: "Derivado de fuente del proyecto; hereda sus condiciones",
      prompt: null,
      description: `Rasterizado ${input.size}x${input.size}`,
      source_paths: [this.workspace.relative(source)]
    });
    let manifestPath: string;
    try {
      manifestPath = await this.workspace.writeManifest(manifest);
    } catch (error) {
      await unlink(target).catch(() => undefined);
      throw error;
    }
    await this.workspace.appendAudit("media_rasterize_svg", "ok", { asset_id: manifest.asset_id });
    return textResult({ path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256, rasterizer: rasterizer.name });
  }

  async renderPreview(input: { input_path: string; output_name: string; sizes: ReadonlyArray<typeof PREVIEW_SIZES[number]> }) {
    const source = await this.workspace.resolveInput(input.input_path, [".svg"], MAX_SVG_BYTES);
    const resvg = await findResvg();
    if (!resvg) throw new Error("No hay resvg instalado. Define IF_RESVG o añade resvg al PATH (github.com/linebender/resvg).");
    const previews: Array<{ size: number; path: string; manifest: string; sha256: string }> = [];
    for (const size of input.sizes) {
      const target = await this.workspace.draftPath(`${input.output_name}_${size}`, "png");
      await requireAbsent(target, this.workspace);
      const result = await renderPreviewWithResvg(resvg, source, target, size);
      if (result.code !== 0) throw new Error(`Falló resvg a ${size}px: ${result.stderr || result.stdout}`);
      const data = await readFile(target);
      const manifest = manifestFor(this.workspace, target, data, "built", {
        kind: "rasterized",
        provider: "local",
        model: "resvg",
        license: "Derivado de fuente del proyecto; hereda sus condiciones",
        prompt: null,
        description: `Previsualización de legibilidad ${size}x${size}, generada para la verificación visual humana pendiente (no la sustituye).`,
        source_paths: [this.workspace.relative(source)]
      });
      let manifestPath: string;
      try {
        manifestPath = await this.workspace.writeManifest(manifest);
      } catch (error) {
        await unlink(target).catch(() => undefined);
        throw error;
      }
      previews.push({ size, path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256 });
    }
    await this.workspace.appendAudit("media_render_preview", "ok", { count: previews.length });
    return textResult({ previews, note: "Revisa manualmente la legibilidad en cada tamaño; esta herramienta no sustituye la verificación visual humana." });
  }

  async vectorizeRaster(input: { input_path: string; output_name: string; preset: typeof VTRACER_PRESETS[number] }) {
    const source = await this.workspace.resolveInput(input.input_path, IMAGE_EXTENSIONS, MAX_IMAGE_BYTES);
    const vtracer = await findVtracer();
    if (!vtracer) throw new Error("No hay VTracer instalado. Define IF_VTRACER o añade vtracer al PATH (github.com/visioncortex/vtracer).");
    const target = await this.workspace.draftPath(input.output_name, "svg");
    await requireAbsent(target, this.workspace);
    const result = await vectorizeWithVtracer(vtracer, source, target, input.preset);
    if (result.code !== 0) throw new Error(`Falló vtracer: ${result.stderr || result.stdout}`);
    const data = await readFile(target);
    const manifest = manifestFor(this.workspace, target, data, "proposal", {
      kind: "vectorized",
      provider: "local",
      model: `vtracer:${input.preset}`,
      license: "Derivado de fuente del proyecto; hereda sus condiciones",
      prompt: null,
      description: `Vectorizado desde ${this.workspace.relative(source)}. La fuente debe ser original de Islas Fracturadas (dibujo propio o textura procedural); nunca la salida de un generador de imágenes por IA.`,
      source_paths: [this.workspace.relative(source)]
    });
    let manifestPath: string;
    try {
      manifestPath = await this.workspace.writeManifest(manifest);
    } catch (error) {
      await unlink(target).catch(() => undefined);
      throw error;
    }
    await this.workspace.appendAudit("media_vectorize_raster", "ok", { asset_id: manifest.asset_id });
    return textResult({ path: manifest.path, manifest: this.workspace.relative(manifestPath), sha256: manifest.sha256 });
  }

  async testSqf(input: { input_path: string }) {
    const source = await this.workspace.resolveInput(input.input_path, [".sqf"], MAX_SQF_BYTES);
    const sqfvm = await findSqfvm();
    if (!sqfvm) throw new Error("No hay SQF-VM instalado. Define IF_SQFVM o añade sqfvm al PATH (github.com/SQFvm/runtime).");
    const result = await runSqfTest(sqfvm, source);
    const ok = result.code === 0;
    await this.workspace.appendAudit("arma_test", ok ? "ok" : "error", { input: this.workspace.relative(source), exit_code: result.code });
    return textResult({
      ok,
      exit_code: result.code,
      output: `${result.stdout}\n${result.stderr}`.trim().slice(0, 4_000),
      note: "SQF-VM ejecuta el script fuera de Arma 3; no sustituye la prueba en el motor real ni en 3DEN."
    });
  }

  async graphCalls(input: { cfgfunctions_path: string; output_name: string }) {
    const cfgfunctionsSource = await this.workspace.resolveInput(input.cfgfunctions_path, [".hpp", ".cpp", ".ext"], MAX_SQF_BYTES);
    const python = await findGraphPython();
    if (!python) throw new Error("No hay Python disponible para sqf_graph.py. Crea tools/if-media-mcp/.venv (python -m venv .venv; pip install armaclass) o define IF_GRAPH_PYTHON.");
    const hemtt = await findHemtt();
    const altisRoot = path.join(this.workspace.projectRoot, "IslasFracturadas.Altis");
    const scriptPath = path.join(this.workspace.projectRoot, "tools", "if-media-mcp", "scripts", "sqf_graph.py");
    const jsonTarget = await this.workspace.draftPath(`${input.output_name}_graph`, "svg").then((p) => p.replace(/\.svg$/, ".json"));
    const d2Target = jsonTarget.replace(/\.json$/, ".d2");
    await requireAbsent(jsonTarget, this.workspace);
    const args = [
      scriptPath,
      "--altis-root", altisRoot,
      "--cfgfunctions", cfgfunctionsSource,
      "--output-json", jsonTarget,
      "--output-d2", d2Target
    ];
    if (hemtt) args.push("--hemtt", hemtt);
    const result = await runCommand(python, args, 60_000);
    if (result.code !== 0) throw new Error(`sqf_graph.py falló: ${result.stderr || result.stdout}`);
    await unlink(d2Target).catch(() => undefined);

    const data = JSON.parse(await readFile(jsonTarget, "utf8")) as {
      nodes: string[]; edges: unknown[]; dynamic_calls: unknown[]; unresolved_names: string[]; missing_files: string[];
    };
    await this.workspace.appendAudit("arma_graph_calls", "ok", {});
    return textResult({
      json: this.workspace.relative(jsonTarget),
      nodes: data.nodes.length,
      static_edges: data.edges.length,
      dynamic_calls: data.dynamic_calls.length,
      unresolved_names: data.unresolved_names,
      missing_files: data.missing_files,
      note: "Grafo heurístico basado en tokenización propia, no en el compilador real de Arma. Lee el JSON completo (nodes/edges/dynamic_calls/function_registry) para consultar relaciones; las llamadas dinámicas (variables, macros, remoteExec no literal) van aparte en 'dynamic_calls', nunca se ocultan ni se inventan como resueltas."
    });
  }

  async inspectMissionSqm(input: { mission_sqm_path: string; name_filter?: string | undefined }) {
    const missionSource = await this.workspace.resolveInput(input.mission_sqm_path, [".sqm"], MAX_SQF_BYTES * 20);
    const python = await findGraphPython();
    if (!python) throw new Error("No hay Python disponible para sqm_inspect.py. Crea tools/if-media-mcp/.venv (python -m venv .venv; pip install armaclass) o define IF_GRAPH_PYTHON.");
    const hemtt = await findHemtt();
    const scriptPath = path.join(this.workspace.projectRoot, "tools", "if-media-mcp", "scripts", "sqm_inspect.py");
    const jsonTarget = await this.workspace.draftPath("mission_sqm_inspect", "svg").then((p) => p.replace(/\.svg$/, ".json"));
    await unlink(jsonTarget).catch(() => undefined);
    const args = [scriptPath, "--mission-sqm", missionSource, "--output-json", jsonTarget];
    if (hemtt) args.push("--hemtt", hemtt);
    if (input.name_filter) args.push("--name-filter", input.name_filter);
    const result = await runCommand(python, args, 60_000);
    if (result.code !== 0) throw new Error(`sqm_inspect.py falló: ${result.stderr || result.stdout}`);

    const data = JSON.parse(await readFile(jsonTarget, "utf8")) as { summary: Record<string, unknown> };
    await this.workspace.appendAudit("arma_sqm_inspect", "ok", {});
    return textResult({
      json: this.workspace.relative(jsonTarget),
      summary: data.summary,
      note: "Solo lectura de mission.sqm; nunca escribe nada. Lee el JSON completo para la lista aplanada de entidades (posición, classname, bando, nombre, init)."
    });
  }

  async patchMissionSqm(input: {
    mission_sqm_path: string;
    entity_id: number;
    field: "position" | "angles";
    values: [number, number, number];
    confirmation: "PATCH_MISSION_SQM_APPROVED";
  }) {
    const missionSource = await this.workspace.resolveInput(input.mission_sqm_path, [".sqm"], MAX_SQF_BYTES * 20);
    const python = await findGraphPython();
    if (!python) throw new Error("No hay Python disponible para sqm_patch.py. Crea tools/if-media-mcp/.venv con armaclass instalado o define IF_GRAPH_PYTHON.");
    const hemtt = await findHemtt();
    const scriptPath = path.join(this.workspace.projectRoot, "tools", "if-media-mcp", "scripts", "sqm_patch.py");
    const draftTarget = await this.workspace.draftPath(`sqm_patch_${input.entity_id}_${Date.now()}`, "svg").then((p) => p.replace(/\.svg$/, ".sqm"));
    const backupDir = path.join(this.workspace.projectRoot, "production", "media", "drafts", "mission_sqm_backups");
    const args = [
      scriptPath,
      "--mission-sqm", missionSource,
      "--entity-id", String(input.entity_id),
      "--field", input.field,
      "--values", input.values.join(","),
      "--draft-output", draftTarget,
      "--backup-dir", backupDir
    ];
    if (hemtt) args.push("--hemtt", hemtt);
    const result = await runCommand(python, args, 60_000);
    const parsed = JSON.parse(result.stdout.trim() || "{}") as {
      ok?: boolean; error?: string; backup_path?: string; draft_path?: string;
      entities_before?: number; entities_after?: number; unrelated_entities_changed?: string[];
      old_values?: number[] | null; new_values?: number[];
    };
    if (result.code !== 0 || !parsed.ok) {
      await this.workspace.appendAudit("arma_sqm_patch", "blocked", { entity_id: input.entity_id, reason: parsed.error || result.stderr });
      throw new Error(`Parche rechazado, mission.sqm NO fue tocado: ${parsed.error || result.stderr || result.stdout}`);
    }

    // Solo si la validación (round-trip, mismo nº de entidades, cero cambios ajenos)
    // pasó Y se dio la confirmación explícita, se copia el borrador ya validado sobre
    // el mission.sqm real. El backup ya existe en disco antes de este paso.
    const patchedText = await readFile(parsed.draft_path!, "utf8");
    await writeFile(missionSource, patchedText, { encoding: "utf8" });

    await this.workspace.appendAudit("arma_sqm_patch", "ok", { entity_id: input.entity_id, field: input.field });
    return textResult({
      applied: true,
      entity_id: input.entity_id,
      field: input.field,
      old_values: parsed.old_values ?? null,
      new_values: parsed.new_values,
      backup: this.workspace.relative(parsed.backup_path!),
      entities_before: parsed.entities_before,
      entities_after: parsed.entities_after,
      note: "mission.sqm fue modificado quirúrgicamente (solo esta entidad cambió, verificado por round-trip). Backup del original guardado. ABRE Y COMPRUEBA la misión en 3DEN/Arma 3 antes de darla por buena — esta herramienta no sustituye esa verificación."
    });
  }

  async readLatestRpt(input: { tail_kb: number }) {
    const rptDir = process.env.IF_ARMA3_RPT_DIR || (process.env.LOCALAPPDATA ? path.join(process.env.LOCALAPPDATA, "Arma 3") : undefined);
    if (!rptDir) throw new Error("No se pudo determinar la carpeta de RPT. Define IF_ARMA3_RPT_DIR.");
    let entries: string[];
    try {
      entries = (await readdir(rptDir)).filter((name) => name.toLowerCase().endsWith(".rpt"));
    } catch {
      throw new Error(`No se encontró la carpeta de RPT: ${rptDir}. Define IF_ARMA3_RPT_DIR si Arma 3 guarda los registros en otra ruta.`);
    }
    if (entries.length === 0) throw new Error(`No hay archivos .rpt en ${rptDir}. Ejecuta la misión en Arma 3 primero.`);
    const withStats = await Promise.all(entries.map(async (name) => {
      const full = path.join(rptDir, name);
      const info = await stat(full);
      return { full, name, mtimeMs: info.mtimeMs, size: info.size };
    }));
    withStats.sort((a, b) => b.mtimeMs - a.mtimeMs);
    const latest = withStats[0]!;
    const tailBytes = Math.min(input.tail_kb * 1024, latest.size);
    const buffer = Buffer.alloc(tailBytes);
    const handle = await open(latest.full, "r");
    try {
      await handle.read(buffer, 0, tailBytes, Math.max(0, latest.size - tailBytes));
    } finally {
      await handle.close();
    }
    const text = buffer.toString("utf8");
    const lines = text.split(/\r?\n/);
    const errorLines = lines.filter((line) => /error/i.test(line));
    const warningLines = lines.filter((line) => /warning/i.test(line));
    return textResult({
      rpt_path: latest.full,
      modified_at: new Date(latest.mtimeMs).toISOString(),
      size_bytes: latest.size,
      read_tail_bytes: tailBytes,
      truncated: tailBytes < latest.size,
      error_lines: errorLines.slice(-200),
      warning_lines: warningLines.slice(-200),
      note: "Lectura de solo texto de un RPT existente; no sustituye ejecutar y revisar la misión en Arma 3/3DEN."
    });
  }

  async buildIdentity(input: { confirmation: "BUILD_APPROVED_IDENTITY"; size: typeof TEXTURE_SIZES[number] }) {
    const [rasterizer, imageToPaa, hemtt, powerShell] = await Promise.all([findRasterizer(), findImageToPaa(), findHemtt(), findPowerShell()]);
    const hasPaaTool = Boolean(imageToPaa) || Boolean(hemtt);
    if (!rasterizer || !hasPaaTool || !powerShell) {
      await this.workspace.appendAudit("media_build_identity", "blocked", { rasterizer: Boolean(rasterizer), image_to_paa: Boolean(imageToPaa), hemtt: Boolean(hemtt), powershell: Boolean(powerShell) });
      throw new Error("Compilación bloqueada: se requieren rasterizador, un conversor PAA (ImageToPAA o HEMTT) y PowerShell. Ejecuta media_status para ver el detalle.");
    }
    const script = path.join(this.workspace.projectRoot, "tools", "Build-Assets.ps1");
    const result = await runCommand(powerShell, ["-NoProfile", "-NonInteractive", "-File", script, "-Size", String(input.size)], 180_000);
    if (result.code !== 0) {
      await this.workspace.appendAudit("media_build_identity", "error", { exit_code: result.code });
      throw new Error(`Build-Assets.ps1 falló (${result.code}): ${result.stderr || result.stdout}`);
    }
    const outputDir = path.join(this.workspace.projectRoot, "IslasFracturadas.Altis", "ui", "insignia");
    const paaFiles = (await readdir(outputDir)).filter((name) => name.toLowerCase().endsWith(".paa")).sort();
    await this.workspace.appendAudit("media_build_identity", "ok", { paa_count: paaFiles.length });
    return textResult({ paa_files: paaFiles, output: this.workspace.relative(outputDir), build_log: `${result.stdout}\n${result.stderr}`.trim() });
  }
}

export function createMediaServer(service: MediaService): McpServer {
  const server = new McpServer({ name: "if-media", version: "0.1.0" }, { capabilities: { tools: {} } });

  server.registerTool("media_status", {
    title: "Estado del entorno visual",
    description: "Comprueba proveedor, modelo, rasterizador, ImageToPAA y rutas sin exponer secretos.",
    inputSchema: z.object({}),
    annotations: { readOnlyHint: true, destructiveHint: false, idempotentHint: true, openWorldHint: false }
  }, async () => textResult(await service.status()));

  server.registerTool("media_generate", {
    title: "Generar borrador visual",
    description: "Genera una imagen con OpenAI; consume API y escribe solo en production/media/drafts con manifiesto PROPUESTA.",
    inputSchema: z.object({
      prompt: z.string().min(1).max(32_000),
      output_name: z.string().min(1).max(68),
      size: z.enum(IMAGE_SIZES).default("1024x1024"),
      quality: z.enum(["auto", "low", "medium", "high"]).default("medium"),
      background: z.enum(["auto", "opaque"]).default("auto"),
      output_format: z.enum(OUTPUT_FORMATS).default("png")
    }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: true }
  }, async (input) => {
    try { return await service.generate(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_edit", {
    title: "Editar borrador visual",
    description: "Edita una imagen permitida con OpenAI; consume API y conserva fuente y prompt en un manifiesto nuevo.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260),
      mask_path: z.string().min(1).max(260).optional(),
      prompt: z.string().min(1).max(32_000),
      output_name: z.string().min(1).max(68),
      size: z.enum(IMAGE_SIZES).default("1024x1024"),
      quality: z.enum(["auto", "low", "medium", "high"]).default("medium"),
      background: z.enum(["auto", "opaque"]).default("auto"),
      output_format: z.enum(OUTPUT_FORMATS).default("png"),
      input_fidelity: z.enum(["low", "high"]).default("high")
    }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: true }
  }, async (input) => {
    try { return await service.edit(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_register_provenance", {
    title: "Registrar procedencia visual",
    description: "Crea un manifiesto inmutable para una imagen o SVG existente; nunca concede aprobación automáticamente.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260),
      origin_kind: z.enum(["original", "third_party", "generated"]),
      provider: z.string().min(1).max(120).optional(),
      model: z.string().min(1).max(120).optional(),
      license: z.string().min(1).max(500),
      prompt: z.string().min(1).max(32_000).optional(),
      description: z.string().min(1).max(2_000).optional()
    }).refine((value) => Boolean(value.prompt || value.description), { message: "Indica prompt o description." }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: true, openWorldHint: false }
  }, async (input) => {
    try { return await service.registerProvenance(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_rasterize_svg", {
    title: "Rasterizar SVG",
    description: "Convierte un SVG permitido a PNG de potencia de dos dentro de borradores, sin tocar la misión.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260),
      output_name: z.string().min(1).max(68),
      size: textureSizeSchema.default(128)
    }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.rasterize(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_render_preview", {
    title: "Previsualizar legibilidad SVG",
    description: "Renderiza un SVG permitido a PNG con resvg en varios tamaños (32/64/128/256) para la verificación visual humana de legibilidad. No sustituye esa revisión.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260),
      output_name: z.string().min(1).max(60),
      sizes: z.array(previewSizeSchema).min(1).max(4).default([32, 64, 128])
    }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.renderPreview(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_vectorize_raster", {
    title: "Vectorizar raster con VTracer",
    description: "Convierte una imagen raster permitida a SVG con VTracer. La fuente debe ser original de Islas Fracturadas (dibujo propio, escaneo o textura procedural); nunca la salida de un generador de imágenes por IA — exige confirmarlo explícitamente.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260),
      output_name: z.string().min(1).max(60),
      preset: z.enum(VTRACER_PRESETS).default("bw"),
      confirms_original_source: z.literal(true)
    }),
    annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.vectorizeRaster(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("arma_test", {
    title: "Probar SQF fuera de Arma 3",
    description: "Ejecuta un .sqf de IslasFracturadas.Altis con SQF-VM (sin abrir el juego). Solo lectura del script; no escribe nada. No sustituye la prueba en Arma 3/3DEN.",
    inputSchema: z.object({
      input_path: z.string().min(1).max(260)
    }),
    annotations: { readOnlyHint: true, destructiveHint: false, idempotentHint: true, openWorldHint: false }
  }, async (input) => {
    try { return await service.testSqf(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("arma_read_rpt", {
    title: "Leer el último RPT de Arma 3",
    description: "Lee el archivo .rpt más reciente (carpeta de perfil de Arma 3 o IF_ARMA3_RPT_DIR) y extrae líneas con 'error'/'warning'. Solo lectura; no sustituye revisar la misión en Arma 3/3DEN.",
    inputSchema: z.object({
      tail_kb: z.number().int().min(16).max(4096).default(512)
    }),
    annotations: { readOnlyHint: true, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.readLatestRpt(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("arma_graph_calls", {
    title: "Grafo de llamadas SQF",
    description: "Construye un grafo heurístico de llamadas entre funciones IF_fnc_* a partir de CfgFunctions y tokenización propia de los .sqf (no un compilador real de Arma). Marca aparte las llamadas dinámicas (variables, macros) en vez de ocultarlas o inventar resoluciones. Solo lectura sobre IslasFracturadas.Altis.",
    inputSchema: z.object({
      cfgfunctions_path: z.string().min(1).max(260).default("IslasFracturadas.Altis/cfg/CfgFunctions.hpp"),
      output_name: z.string().min(1).max(60)
    }),
    annotations: { readOnlyHint: true, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.graphCalls(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("arma_sqm_inspect", {
    title: "Inspeccionar mission.sqm",
    description: "Lee mission.sqm (deraprifica con HEMTT si está binarizado) y devuelve un resumen: entidades por tipo/bando, entidades con nombre de variable (buscables) y con init. Solo lectura, nunca escribe nada. Excepción registrada en AGENTS.md 2026-08-08; la escritura estructurada requiere una herramienta separada con backup y validación.",
    inputSchema: z.object({
      mission_sqm_path: z.string().min(1).max(260).default("IslasFracturadas.Altis/mission.sqm"),
      name_filter: z.string().min(1).max(120).optional()
    }),
    annotations: { readOnlyHint: true, destructiveHint: false, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.inspectMissionSqm(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("arma_sqm_patch", {
    title: "Mover/rotar una entidad en mission.sqm",
    description: "Parche quirúrgico: cambia SOLO position[] o angles[] de una entidad existente (localizada por su id nativo, único). No añade ni borra entidades. Crea backup automático antes de tocar el archivo, valida por round-trip (mismo nº de entidades, cero cambios en otras entidades) y solo entonces aplica. Excepción de AGENTS.md 2026-08-08: abre y comprueba la misión en 3DEN/Arma 3 después — esta herramienta no sustituye esa verificación.",
    inputSchema: z.object({
      mission_sqm_path: z.string().min(1).max(260).default("IslasFracturadas.Altis/mission.sqm"),
      entity_id: z.number().int().nonnegative(),
      field: z.enum(["position", "angles"]),
      values: z.tuple([z.number(), z.number(), z.number()]),
      confirmation: z.literal("PATCH_MISSION_SQM_APPROVED")
    }),
    annotations: { readOnlyHint: false, destructiveHint: true, idempotentHint: false, openWorldHint: false }
  }, async (input) => {
    try { return await service.patchMissionSqm(input); } catch (error) { return errorResult(error); }
  });

  server.registerTool("media_build_identity", {
    title: "Construir identidad aprobada",
    description: "Convierte los SVG de identidad a PNG/PAA. Sobrescribe derivados y exige confirmación literal más todas las dependencias.",
    inputSchema: z.object({
      confirmation: z.literal("BUILD_APPROVED_IDENTITY"),
      size: textureSizeSchema.default(128)
    }),
    annotations: { readOnlyHint: false, destructiveHint: true, idempotentHint: true, openWorldHint: false }
  }, async (input) => {
    try { return await service.buildIdentity(input); } catch (error) { return errorResult(error); }
  });

  return server;
}
