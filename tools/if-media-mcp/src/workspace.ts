import { createHash } from "node:crypto";
import { access, appendFile, mkdir, readFile, realpath, stat, writeFile } from "node:fs/promises";
import path from "node:path";

export const MAX_IMAGE_BYTES = 25 * 1024 * 1024;
export const MAX_MASK_BYTES = 4 * 1024 * 1024;
export const MAX_SVG_BYTES = 5 * 1024 * 1024;

const INPUT_ROOTS = ["art", "asset/reference", "production/media/drafts", "production/media/approved", "IslasFracturadas.Altis"];
export const MAX_SQF_BYTES = 1 * 1024 * 1024;

export type ManifestStatus = "proposal" | "reference" | "built";

export interface AssetManifest {
  schema_version: 1;
  asset_id: string;
  path: string;
  sha256: string;
  media_type: string;
  created_at: string;
  status: ManifestStatus;
  approval_reference: null;
  origin: {
    kind: "generated" | "edited" | "original" | "third_party" | "rasterized" | "vectorized";
    provider: string | null;
    model: string | null;
    license: string;
    prompt: string | null;
    description: string | null;
    source_paths: string[];
  };
}

function isInside(parent: string, candidate: string): boolean {
  const relative = path.relative(parent, candidate);
  return relative === "" || (!relative.startsWith(`..${path.sep}`) && relative !== ".." && !path.isAbsolute(relative));
}

function samePath(left: string, right: string): boolean {
  return path.resolve(left).toLowerCase() === path.resolve(right).toLowerCase();
}

function normalizedRelative(value: string): string {
  if (value.includes("\0") || path.isAbsolute(value)) {
    throw new Error("La ruta debe ser relativa al proyecto.");
  }
  const normalized = path.normalize(value.replaceAll("/", path.sep));
  if (normalized === ".." || normalized.startsWith(`..${path.sep}`)) {
    throw new Error("La ruta no puede salir del proyecto.");
  }
  return normalized;
}

export function safeOutputStem(value: string): string {
  if (!/^[a-z0-9][a-z0-9._-]{0,63}$/i.test(value) || value === "." || value === "..") {
    throw new Error("output_name debe contener 1-64 caracteres alfanuméricos, punto, guion o guion bajo.");
  }
  return value.replace(/\.(png|jpe?g|webp)$/i, "");
}

export function sha256(data: Uint8Array | string): string {
  return createHash("sha256").update(data).digest("hex");
}

export class MediaWorkspace {
  readonly projectRoot: string;
  readonly draftsRoot: string;
  readonly manifestsRoot: string;
  readonly auditRoot: string;

  private constructor(projectRoot: string) {
    this.projectRoot = projectRoot;
    this.draftsRoot = path.join(projectRoot, "production", "media", "drafts");
    this.manifestsRoot = path.join(projectRoot, "production", "media", "manifests");
    this.auditRoot = path.join(projectRoot, "production", "media", "audit");
  }

  static async open(projectRoot: string): Promise<MediaWorkspace> {
    const resolved = await realpath(path.resolve(projectRoot));
    await access(path.join(resolved, "AGENTS.md"));
    await access(path.join(resolved, "art"));
    return new MediaWorkspace(resolved);
  }

  relative(absolutePath: string): string {
    return path.relative(this.projectRoot, absolutePath).replaceAll(path.sep, "/");
  }

  private async ensureStorageDirectory(directory: string): Promise<string> {
    await mkdir(directory, { recursive: true });
    const resolved = await realpath(directory);
    if (!isInside(this.projectRoot, resolved) || !samePath(directory, resolved)) {
      throw new Error(`El directorio de almacenamiento usa un enlace o sale del proyecto: ${this.relative(directory)}.`);
    }
    return resolved;
  }

  async resolveInput(relativePath: string, extensions: readonly string[], maxBytes: number): Promise<string> {
    const normalized = normalizedRelative(relativePath);
    const candidate = path.resolve(this.projectRoot, normalized);
    const lexicalAllowed = INPUT_ROOTS.some((root) => isInside(path.join(this.projectRoot, root), candidate));
    if (!lexicalAllowed) {
      throw new Error(`Ruta de entrada fuera de las raíces permitidas: ${relativePath}`);
    }

    const realCandidate = await realpath(candidate);
    let realAllowed = false;
    for (const root of INPUT_ROOTS) {
      try {
        const realRoot = await realpath(path.join(this.projectRoot, root));
        if (isInside(realRoot, realCandidate)) {
          realAllowed = true;
          break;
        }
      } catch {
        // Una raíz opcional ausente no autoriza la ruta.
      }
    }
    if (!realAllowed) {
      throw new Error("La ruta resuelta sale de las raíces permitidas mediante un enlace.");
    }

    const extension = path.extname(realCandidate).toLowerCase();
    if (!extensions.includes(extension)) {
      throw new Error(`Extensión no permitida: ${extension || "sin extensión"}.`);
    }
    const metadata = await stat(realCandidate);
    if (!metadata.isFile() || metadata.size > maxBytes) {
      throw new Error(`El archivo no es válido o supera ${maxBytes} bytes.`);
    }
    return realCandidate;
  }

  async draftPath(outputName: string, extension: "png" | "jpeg" | "webp" | "svg"): Promise<string> {
    const realDrafts = await this.ensureStorageDirectory(this.draftsRoot);
    return path.join(realDrafts, `${safeOutputStem(outputName)}.${extension}`);
  }

  async writeNewFile(target: string, data: Uint8Array): Promise<void> {
    if (data.byteLength === 0 || data.byteLength > MAX_IMAGE_BYTES) {
      throw new Error(`La salida debe contener entre 1 y ${MAX_IMAGE_BYTES} bytes.`);
    }
    await writeFile(target, data, { flag: "wx" });
  }

  async writeManifest(manifest: AssetManifest): Promise<string> {
    await this.ensureStorageDirectory(this.manifestsRoot);
    const pathHash = sha256(manifest.path).slice(0, 12);
    const target = path.join(this.manifestsRoot, `${manifest.sha256}-${pathHash}.json`);
    const serialized = `${JSON.stringify(manifest, null, 2)}\n`;
    try {
      await writeFile(target, serialized, { encoding: "utf8", flag: "wx" });
    } catch (error) {
      const code = (error as NodeJS.ErrnoException).code;
      if (code !== "EEXIST") throw error;
      const existing = await readFile(target, "utf8");
      const existingManifest = JSON.parse(existing) as AssetManifest;
      const comparableExisting = { ...existingManifest, created_at: manifest.created_at };
      if (JSON.stringify(comparableExisting) !== JSON.stringify(manifest)) {
        throw new Error(`Ya existe un manifiesto inmutable distinto para ${manifest.sha256}.`);
      }
    }
    return target;
  }

  async appendAudit(action: string, outcome: "ok" | "blocked" | "error", details: Record<string, unknown>): Promise<void> {
    await this.ensureStorageDirectory(this.auditRoot);
    const timestamp = new Date().toISOString();
    const day = timestamp.slice(0, 10);
    const safeDetails = Object.fromEntries(Object.entries(details).filter(([key]) => !/key|token|secret|prompt$/i.test(key)));
    await appendFile(path.join(this.auditRoot, `${day}.jsonl`), `${JSON.stringify({ timestamp, action, outcome, ...safeDetails })}\n`, "utf8");
  }
}

export function mediaTypeFor(extension: string): string {
  const types: Record<string, string> = {
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".webp": "image/webp",
    ".svg": "image/svg+xml"
  };
  const result = types[extension.toLowerCase()];
  if (!result) throw new Error(`Tipo de imagen no admitido: ${extension}.`);
  return result;
}

export function manifestFor(
  workspace: MediaWorkspace,
  absolutePath: string,
  data: Uint8Array,
  status: ManifestStatus,
  origin: AssetManifest["origin"]
): AssetManifest {
  const hash = sha256(data);
  return {
    schema_version: 1,
    asset_id: `sha256:${hash}`,
    path: workspace.relative(absolutePath),
    sha256: hash,
    media_type: mediaTypeFor(path.extname(absolutePath)),
    created_at: new Date().toISOString(),
    status,
    approval_reference: null,
    origin
  };
}
