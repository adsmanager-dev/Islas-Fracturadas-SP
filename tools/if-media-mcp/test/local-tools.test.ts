import assert from "node:assert/strict";
import { copyFile, mkdtemp, mkdir, readFile, rm, symlink, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import sharp from "sharp";
import { findResvg, findSqfvm, findVtracer } from "../src/executables.js";
import { MediaService, resolveMissionWorkspaceSource } from "../src/server.js";
import { MediaWorkspace } from "../src/workspace.js";

async function fixture(): Promise<string> {
  const root = await mkdtemp(path.join(os.tmpdir(), "if-media-local-tools-"));
  await mkdir(path.join(root, "art", "identity"), { recursive: true });
  await writeFile(path.join(root, "AGENTS.md"), "# fixture\n", "utf8");
  return root;
}

test("media_render_preview", async (t) => {
  const resvg = await findResvg();
  const root = await fixture();
  try {
    await writeFile(
      path.join(root, "art", "identity", "fixture.svg"),
      '<svg xmlns="http://www.w3.org/2000/svg" width="128" height="128"><rect width="128" height="128" fill="#191411"/></svg>',
      "utf8"
    );
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    if (!resvg) {
      await assert.rejects(
        () => service.renderPreview({ input_path: "art/identity/fixture.svg", output_name: "fixture", sizes: [32, 64, 128] }),
        /resvg/
      );
      t.diagnostic("resvg no está instalado en este entorno; se comprobó solo el mensaje de error.");
      return;
    }
    const result = await service.renderPreview({ input_path: "art/identity/fixture.svg", output_name: "fixture", sizes: [32, 64, 128] });
    const payload = JSON.parse((result.content[0] as { text: string }).text) as { previews: Array<{ size: number; path: string }> };
    assert.equal(payload.previews.length, 3);
    for (const preview of payload.previews) {
      const metadata = await sharp(path.join(root, preview.path)).metadata();
      assert.equal(metadata.width, preview.size);
      assert.equal(metadata.height, preview.size);
    }
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("media_vectorize_raster", async (t) => {
  const vtracer = await findVtracer();
  const root = await fixture();
  try {
    const png = path.join(root, "art", "identity", "fixture.png");
    await sharp({ create: { width: 64, height: 64, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
      .png()
      .toFile(png);
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    if (!vtracer) {
      await assert.rejects(
        () => service.vectorizeRaster({ input_path: "art/identity/fixture.png", output_name: "fixture", preset: "bw" }),
        /VTracer/
      );
      t.diagnostic("VTracer no está instalado en este entorno; se comprobó solo el mensaje de error.");
      return;
    }
    const result = await service.vectorizeRaster({ input_path: "art/identity/fixture.png", output_name: "fixture", preset: "bw" });
    const payload = JSON.parse((result.content[0] as { text: string }).text) as { path: string };
    const svg = await readFile(path.join(root, payload.path), "utf8");
    assert.match(svg, /<svg/);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("arma_test", async (t) => {
  const sqfvm = await findSqfvm();
  const root = await fixture();
  try {
    await mkdir(path.join(root, "IslasFracturadas.Altis"), { recursive: true });
    await writeFile(path.join(root, "IslasFracturadas.Altis", "ok.sqf"), 'private _x = 1 + 1;\n', "utf8");
    await writeFile(path.join(root, "IslasFracturadas.Altis", "bad.sqf"), 'private _x = 1 +;\n', "utf8");
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    if (!sqfvm) {
      await assert.rejects(
        () => service.testSqf({ input_path: "IslasFracturadas.Altis/ok.sqf" }),
        /SQF-VM/
      );
      t.diagnostic("SQF-VM no está instalado en este entorno; se comprobó solo el mensaje de error.");
      return;
    }
    const ok = await service.testSqf({ input_path: "IslasFracturadas.Altis/ok.sqf" });
    const okPayload = JSON.parse((ok.content[0] as { text: string }).text) as { ok: boolean; exit_code: number };
    assert.equal(okPayload.ok, true);
    assert.equal(okPayload.exit_code, 0);

    const bad = await service.testSqf({ input_path: "IslasFracturadas.Altis/bad.sqf" });
    const badPayload = JSON.parse((bad.content[0] as { text: string }).text) as { ok: boolean; exit_code: number; output: string };
    assert.equal(badPayload.ok, false);
    assert.match(badPayload.output, /Parse Error/);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("arma_read_rpt", async () => {
  const rptDir = await mktempRptDir();
  const previous = process.env.IF_ARMA3_RPT_DIR;
  process.env.IF_ARMA3_RPT_DIR = rptDir;
  try {
    const root = await fixture();
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    const result = await service.readLatestRpt({ tail_kb: 512 });
    const payload = JSON.parse((result.content[0] as { text: string }).text) as {
      error_lines: string[];
      warning_lines: string[];
    };
    assert.deepEqual(payload.error_lines, ["Error in expression: something broke"]);
    assert.deepEqual(payload.warning_lines, ["Warning Message: deprecated command"]);
    await rm(root, { recursive: true, force: true });
  } finally {
    if (previous === undefined) delete process.env.IF_ARMA3_RPT_DIR;
    else process.env.IF_ARMA3_RPT_DIR = previous;
    await rm(rptDir, { recursive: true, force: true });
  }
});

test("arma_sqm_compare_workspace separa metadatos editoriales de cambios funcionales", async (t) => {
  const root = await fixture();
  const missionsRoot = await mkdtemp(path.join(os.tmpdir(), "if-arma-missions-"));
  const previousMissionsDir = process.env.IF_ARMA3_MISSIONS_DIR;
  process.env.IF_ARMA3_MISSIONS_DIR = missionsRoot;
  try {
    const missionDir = path.join(root, "IslasFracturadas.Altis");
    const editorDir = path.join(missionsRoot, "IslasFracturadas.Altis");
    const scriptsDir = path.join(root, "tools", "if-media-mcp", "scripts");
    await Promise.all([
      mkdir(missionDir, { recursive: true }),
      mkdir(editorDir, { recursive: true }),
      mkdir(scriptsDir, { recursive: true })
    ]);
    const repoSqm = 'version=54;class EditorData{class Camera{pos[]={1,2,3};};};class Mission{class Entities{items=1;class Item0{dataType="Logic";id=7;position[]={100,5,200};};};};';
    const editorSqm = repoSqm.replace("pos[]={1,2,3}", "pos[]={4,5,6}");
    await Promise.all([
      writeFile(path.join(missionDir, "mission.sqm"), repoSqm, "utf8"),
      writeFile(path.join(editorDir, "mission.sqm"), editorSqm, "utf8"),
      copyFile(path.resolve("scripts", "sqm_compare.py"), path.join(scriptsDir, "sqm_compare.py")),
      copyFile(path.resolve("scripts", "arma_class_io.py"), path.join(scriptsDir, "arma_class_io.py"))
    ]);
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    const result = await service.compareMissionSqmWorkspace({
      mission_sqm_path: "IslasFracturadas.Altis/mission.sqm",
      mission_folder: "IslasFracturadas.Altis"
    });
    const payload = JSON.parse((result.content[0] as { text: string }).text) as {
      functional_equal: boolean;
      difference_count: number;
      counts_by_classification: Record<string, number>;
      json: string;
    };
    assert.equal(payload.functional_equal, true);
    assert.equal(payload.difference_count, 3);
    assert.equal(payload.counts_by_classification.CAMERA_METADATA, 3);
    const detail = JSON.parse(await readFile(path.join(root, payload.json), "utf8")) as { differences: unknown[] };
    assert.equal(detail.differences.length, 3);
  } finally {
    if (previousMissionsDir === undefined) delete process.env.IF_ARMA3_MISSIONS_DIR;
    else process.env.IF_ARMA3_MISSIONS_DIR = previousMissionsDir;
    await rm(root, { recursive: true, force: true });
    await rm(missionsRoot, { recursive: true, force: true });
  }
});

test("arma_sqm_add_layer aplica solo una Layer raíz validada sobre un fixture", async () => {
  const root = await fixture();
  try {
    const missionDir = path.join(root, "IslasFracturadas.Altis");
    const scriptsDir = path.join(root, "tools", "if-media-mcp", "scripts");
    await Promise.all([
      mkdir(missionDir, { recursive: true }),
      mkdir(scriptsDir, { recursive: true })
    ]);
    const sourceSqm = [
      "version=54;",
      "class EditorData{class ItemIDProvider{nextID=104;};};",
      'class Mission{class Entities{items=1;class Item0{dataType="Logic";id=7;position[]={100,5,200};};};};'
    ].join("");
    const missionPath = path.join(missionDir, "mission.sqm");
    await Promise.all([
      writeFile(missionPath, sourceSqm, "utf8"),
      copyFile(path.resolve("scripts", "sqm_patch.py"), path.join(scriptsDir, "sqm_patch.py")),
      copyFile(path.resolve("scripts", "arma_class_io.py"), path.join(scriptsDir, "arma_class_io.py")),
      copyFile(path.resolve("scripts", "sqm_inspect.py"), path.join(scriptsDir, "sqm_inspect.py"))
    ]);
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);

    const result = await service.addMissionSqmLayer({
      mission_sqm_path: "IslasFracturadas.Altis/mission.sqm",
      layer_name: "IF_04_ROADS_AND_ROUTES",
      atl_offset: 0,
      confirmation: "PATCH_MISSION_SQM_APPROVED"
    });
    const payload = JSON.parse((result.content[0] as { text: string }).text) as {
      applied: boolean;
      layer_name: string;
      entities_before: number;
      entities_after: number;
      root_items_before: number;
      root_items_after: number;
      next_id_before: number;
      next_id_after: number;
      backup: string;
    };
    const patched = await readFile(missionPath, "utf8");
    assert.equal(payload.applied, true);
    assert.equal(payload.layer_name, "IF_04_ROADS_AND_ROUTES");
    assert.equal(payload.entities_after, payload.entities_before + 1);
    assert.equal(payload.root_items_after, payload.root_items_before + 1);
    assert.equal(payload.next_id_before, 104);
    assert.equal(payload.next_id_after, 104);
    assert.match(patched, /items=2;/);
    assert.match(patched, /dataType="Layer";/);
    assert.match(patched, /name="IF_04_ROADS_AND_ROUTES";/);
    assert.equal(await readFile(path.join(root, payload.backup), "utf8"), sourceSqm);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("resolveMissionWorkspaceSource rechaza escapes por enlace", async (t) => {
  const missionsRoot = await mkdtemp(path.join(os.tmpdir(), "if-arma-root-"));
  const outside = await mkdtemp(path.join(os.tmpdir(), "if-arma-outside-"));
  try {
    await writeFile(path.join(outside, "mission.sqm"), "version=54;", "utf8");
    try {
      await symlink(outside, path.join(missionsRoot, "Escaped.Altis"), "junction");
    } catch (error) {
      const code = (error as NodeJS.ErrnoException).code;
      if (code === "EPERM" || code === "EACCES") {
        t.skip("El entorno no permite crear junctions para probar el escape por ruta real.");
        return;
      }
      throw error;
    }
    await assert.rejects(
      () => resolveMissionWorkspaceSource(missionsRoot, "Escaped.Altis"),
      /sale de la carpeta permitida mediante un enlace o junction/
    );
  } finally {
    await rm(missionsRoot, { recursive: true, force: true });
    await rm(outside, { recursive: true, force: true });
  }
});

async function mktempRptDir(): Promise<string> {
  const dir = await mkdtemp(path.join(os.tmpdir(), "if-media-rpt-"));
  await writeFile(
    path.join(dir, "arma3_2026-08-07.rpt"),
    "Normal line\nError in expression: something broke\nWarning Message: deprecated command\n",
    "utf8"
  );
  return dir;
}
