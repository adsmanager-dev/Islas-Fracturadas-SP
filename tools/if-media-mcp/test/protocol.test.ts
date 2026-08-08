import assert from "node:assert/strict";
import { mkdtemp, mkdir, rm, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { Client } from "@modelcontextprotocol/client";
import { InMemoryTransport } from "@modelcontextprotocol/server";
import { createMediaServer, MediaService } from "../src/server.js";
import { MediaWorkspace } from "../src/workspace.js";

test("el servidor enumera herramientas y respeta el modo remoto desactivado", async () => {
  const root = await mkdtemp(path.join(os.tmpdir(), "if-media-protocol-"));
  const previousKey = process.env.OPENAI_API_KEY;
  const previousRemoteMode = process.env.IF_MEDIA_REMOTE_MODE;
  delete process.env.OPENAI_API_KEY;
  process.env.IF_MEDIA_REMOTE_MODE = "disabled";
  await mkdir(path.join(root, "art"), { recursive: true });
  await writeFile(path.join(root, "AGENTS.md"), "# fixture\n", "utf8");
  const workspace = await MediaWorkspace.open(root);
  const server = createMediaServer(new MediaService(workspace));
  const client = new Client({ name: "if-media-test", version: "1.0.0" });
  const [clientTransport, serverTransport] = InMemoryTransport.createLinkedPair();

  try {
    await Promise.all([server.connect(serverTransport), client.connect(clientTransport)]);
    const listed = await client.listTools();
    assert.deepEqual(listed.tools.map((tool) => tool.name).sort(), [
      "arma_graph_calls",
      "arma_read_rpt",
      "arma_sqm_add_object",
      "arma_sqm_inspect",
      "arma_sqm_patch",
      "arma_test",
      "media_build_identity",
      "media_edit",
      "media_generate",
      "media_rasterize_svg",
      "media_register_provenance",
      "media_render_preview",
      "media_status",
      "media_vectorize_raster"
    ]);

    const status = await client.callTool({ name: "media_status", arguments: {} });
    assert.equal(status.isError, undefined);
    assert.match(JSON.stringify(status.content), /api_key_configured/);
    assert.match(JSON.stringify(status.content), /disabled_by_configuration/);
    assert.doesNotMatch(JSON.stringify(status.content), /OPENAI_API_KEY no configurada/);

    const generated = await client.callTool({
      name: "media_generate",
      arguments: { prompt: "test", output_name: "must-not-exist" }
    });
    assert.equal(generated.isError, true);
    assert.match(JSON.stringify(generated.content), /Generación remota desactivada/);
  } finally {
    await client.close().catch(() => undefined);
    await server.close().catch(() => undefined);
    if (previousKey === undefined) delete process.env.OPENAI_API_KEY;
    else process.env.OPENAI_API_KEY = previousKey;
    if (previousRemoteMode === undefined) delete process.env.IF_MEDIA_REMOTE_MODE;
    else process.env.IF_MEDIA_REMOTE_MODE = previousRemoteMode;
    await rm(root, { recursive: true, force: true });
  }
});
