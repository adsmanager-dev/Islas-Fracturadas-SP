import assert from "node:assert/strict";
import { mkdtemp, mkdir, readFile, rm, symlink, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { manifestFor, MAX_IMAGE_BYTES, MediaWorkspace, safeOutputStem } from "../src/workspace.js";

async function fixture(): Promise<string> {
  const root = await mkdtemp(path.join(os.tmpdir(), "if-media-test-"));
  await mkdir(path.join(root, "art", "identity"), { recursive: true });
  await mkdir(path.join(root, "asset", "reference"), { recursive: true });
  await mkdir(path.join(root, "production", "media", "drafts"), { recursive: true });
  await writeFile(path.join(root, "AGENTS.md"), "# fixture\n", "utf8");
  return root;
}

test("safeOutputStem acepta nombres simples y rechaza recorridos", () => {
  assert.equal(safeOutputStem("emblema-v1.png"), "emblema-v1");
  assert.throws(() => safeOutputStem("../fuera"), /output_name/);
  assert.throws(() => safeOutputStem("sub/carpeta"), /output_name/);
});

test("resolveInput limita raíces, extensiones y rutas absolutas", async () => {
  const root = await fixture();
  try {
    const source = path.join(root, "art", "identity", "emblema.svg");
    await writeFile(source, "<svg/>", "utf8");
    const workspace = await MediaWorkspace.open(root);
    assert.equal(await workspace.resolveInput("art/identity/emblema.svg", [".svg"], 1024), source);
    await assert.rejects(() => workspace.resolveInput("AGENTS.md", [".md"], 1024), /fuera de las raíces/);
    await assert.rejects(() => workspace.resolveInput("../fuera.svg", [".svg"], 1024), /salir del proyecto/);
    await assert.rejects(() => workspace.resolveInput(source, [".svg"], 1024), /relativa/);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("resolveInput rechaza enlaces que escapan del proyecto cuando el sistema los permite", async (t) => {
  const root = await fixture();
  const outside = await mkdtemp(path.join(os.tmpdir(), "if-media-outside-"));
  try {
    const outsideFile = path.join(outside, "escape.svg");
    const link = path.join(root, "art", "identity", "escape.svg");
    await writeFile(outsideFile, "<svg/>", "utf8");
    try {
      await symlink(outsideFile, link, "file");
    } catch {
      t.skip("Windows no permite crear el enlace simbólico en este entorno.");
      return;
    }
    const workspace = await MediaWorkspace.open(root);
    await assert.rejects(() => workspace.resolveInput("art/identity/escape.svg", [".svg"], 1024), /enlace/);
  } finally {
    await rm(root, { recursive: true, force: true });
    await rm(outside, { recursive: true, force: true });
  }
});

test("manifiesto y auditoría conservan trazabilidad sin secretos", async () => {
  const root = await fixture();
  try {
    const source = path.join(root, "production", "media", "drafts", "asset.png");
    const bytes = Buffer.from("png-fixture");
    await writeFile(source, bytes);
    const workspace = await MediaWorkspace.open(root);
    const manifest = manifestFor(workspace, source, bytes, "proposal", {
      kind: "generated",
      provider: "test",
      model: "test-image",
      license: "test-only",
      prompt: "una isla",
      description: null,
      source_paths: []
    });
    const manifestPath = await workspace.writeManifest(manifest);
    const stored = JSON.parse(await readFile(manifestPath, "utf8")) as typeof manifest;
    assert.equal(stored.sha256, manifest.sha256);
    assert.equal(stored.path, "production/media/drafts/asset.png");
    const repeatedPath = await workspace.writeManifest({ ...manifest, created_at: "2099-01-01T00:00:00.000Z" });
    assert.equal(repeatedPath, manifestPath);
    await assert.rejects(
      () => workspace.writeManifest({ ...manifest, created_at: "2099-01-01T00:00:00.000Z", origin: { ...manifest.origin, license: "different" } }),
      /manifiesto inmutable distinto/
    );
    await workspace.appendAudit("test", "ok", { api_key: "secret", prompt: "private", prompt_sha256: "allowed" });
    const audit = await readFile(path.join(workspace.auditRoot, `${new Date().toISOString().slice(0, 10)}.jsonl`), "utf8");
    assert.doesNotMatch(audit, /secret|private/);
    assert.match(audit, /prompt_sha256/);
    await assert.rejects(() => workspace.writeNewFile(path.join(workspace.draftsRoot, "too-large.png"), Buffer.alloc(MAX_IMAGE_BYTES + 1)), /límite|salida/);
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});
