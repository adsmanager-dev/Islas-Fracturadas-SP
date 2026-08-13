import assert from "node:assert/strict";
import { mkdtemp, mkdir, rm, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import sharp from "sharp";
import { MediaService } from "../src/server.js";
import { MediaWorkspace } from "../src/workspace.js";

test("Sharp rasteriza un SVG a PNG cuadrado con manifiesto", async () => {
  const root = await mkdtemp(path.join(os.tmpdir(), "if-media-raster-"));
  try {
    await mkdir(path.join(root, "art", "identity"), { recursive: true });
    await writeFile(path.join(root, "AGENTS.md"), "# fixture\n", "utf8");
    await writeFile(
      path.join(root, "art", "identity", "fixture.svg"),
      '<svg xmlns="http://www.w3.org/2000/svg" width="128" height="128"><circle cx="64" cy="64" r="48" fill="#8FA5B8"/></svg>',
      "utf8"
    );
    const workspace = await MediaWorkspace.open(root);
    const service = new MediaService(workspace);
    const result = await service.rasterize({ input_path: "art/identity/fixture.svg", output_name: "fixture", size: 128 });
    assert.equal(result.content[0]?.type, "text");
    const metadata = await sharp(path.join(root, "production", "media", "drafts", "fixture.png")).metadata();
    assert.equal(metadata.width, 128);
    assert.equal(metadata.height, 128);
    assert.equal(metadata.hasAlpha, true);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});
