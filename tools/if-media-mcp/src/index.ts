import { serveStdio } from "@modelcontextprotocol/server/stdio";
import { createMediaServer, MediaService } from "./server.js";
import { MediaWorkspace } from "./workspace.js";

function projectRootFromArgs(args: readonly string[]): string {
  const index = args.indexOf("--project-root");
  if (index === -1) return process.cwd();
  const value = args[index + 1];
  if (!value) throw new Error("--project-root requiere una ruta.");
  return value;
}

async function main(): Promise<void> {
  const workspace = await MediaWorkspace.open(projectRootFromArgs(process.argv.slice(2)));
  const service = new MediaService(workspace);
  serveStdio(() => createMediaServer(service), {
    onerror: (error) => console.error(`[if-media] ${error.message}`)
  });
}

main().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`[if-media] Error fatal: ${message}`);
  process.exitCode = 1;
});
