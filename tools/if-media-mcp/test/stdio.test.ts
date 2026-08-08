import assert from "node:assert/strict";
import path from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";
import { Client } from "@modelcontextprotocol/client";
import { StdioClientTransport } from "@modelcontextprotocol/client/stdio";

test("el artefacto compilado funciona por stdio", async () => {
  const packageRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
  const projectRoot = path.resolve(packageRoot, "..", "..");
  const client = new Client({ name: "if-media-stdio-test", version: "1.0.0" });
  const inheritedEnvironment = Object.fromEntries(
    Object.entries(process.env).filter((entry): entry is [string, string] => typeof entry[1] === "string")
  );
  const transport = new StdioClientTransport({
    command: process.execPath,
    args: [path.join(packageRoot, "dist", "index.js"), "--project-root", projectRoot],
    env: { ...inheritedEnvironment, OPENAI_API_KEY: "", IF_MEDIA_REMOTE_MODE: "disabled" }
  });

  try {
    await client.connect(transport);
    const listed = await client.listTools();
    assert.equal(listed.tools.length, 14);
    const result = await client.callTool({ name: "media_status", arguments: {} });
    assert.equal(result.isError, undefined);
    assert.match(JSON.stringify(result.content), /disabled_by_configuration/);
  } finally {
    await client.close().catch(() => undefined);
  }
});
