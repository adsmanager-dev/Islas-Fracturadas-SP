import assert from "node:assert/strict";
import { mkdtemp, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import sharp from "sharp";
import { findResvg, findSqfvm, findVtracer } from "../src/executables.js";
import { MediaService } from "../src/server.js";
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

async function mktempRptDir(): Promise<string> {
  const dir = await mkdtemp(path.join(os.tmpdir(), "if-media-rpt-"));
  await writeFile(
    path.join(dir, "arma3_2026-08-07.rpt"),
    "Normal line\nError in expression: something broke\nWarning Message: deprecated command\n",
    "utf8"
  );
  return dir;
}
