import { spawn } from "node:child_process";
import { access } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import sharp from "sharp";

// tools/if-media-mcp/dist/executables.js -> tools/if-media-mcp/bin
// Carpeta ignorada por Git para binarios locales de HEMTT/resvg/VTracer: mantiene todas las
// dependencias del MCP dentro de su propia carpeta, sin tocar PATH ni variables del sistema.
function packageBinDir(): string {
  return path.join(path.dirname(fileURLToPath(import.meta.url)), "..", "bin");
}

export interface Rasterizer {
  name: "inkscape" | "magick" | "rsvg" | "sharp";
  executable: string;
}

async function fileExists(candidate: string | undefined): Promise<string | null> {
  if (!candidate) return null;
  try {
    await access(candidate);
    return candidate;
  } catch {
    return null;
  }
}

export async function locateOnPath(command: string): Promise<string | null> {
  return await new Promise((resolve) => {
    const child = spawn("where.exe", [command], { windowsHide: true, shell: false });
    let stdout = "";
    child.stdout.on("data", (chunk: Buffer) => { stdout += chunk.toString("utf8"); });
    child.on("error", () => resolve(null));
    child.on("close", (code) => {
      const first = stdout.split(/\r?\n/).map((line) => line.trim()).find(Boolean);
      resolve(code === 0 && first ? first : null);
    });
  });
}

export async function findRasterizer(): Promise<Rasterizer | null> {
  const userProfile = process.env.USERPROFILE;
  const inkscapeCandidates = [
    process.env.IF_INKSCAPE,
    userProfile ? path.join(userProfile, "scoop", "apps", "inkscape", "current", "bin", "inkscape.com") : undefined,
    "C:\\Program Files\\Inkscape\\bin\\inkscape.com"
  ];
  for (const candidate of inkscapeCandidates) {
    const found = await fileExists(candidate);
    if (found) return { name: "inkscape", executable: found };
  }
  const inkscape = await locateOnPath("inkscape");
  if (inkscape) return { name: "inkscape", executable: inkscape };
  const magick = await locateOnPath("magick");
  if (magick) return { name: "magick", executable: magick };
  const rsvg = await locateOnPath("rsvg-convert");
  if (rsvg) return { name: "rsvg", executable: rsvg };
  return { name: "sharp", executable: process.execPath };
}

export async function findImageToPaa(): Promise<string | null> {
  const candidates = [
    process.env.IF_ARMA3_TOOLS ? path.join(process.env.IF_ARMA3_TOOLS, "ImageToPAA", "ImageToPAA.exe") : undefined,
    process.env.IF_ARMA3_TOOLS ? path.join(process.env.IF_ARMA3_TOOLS, "ImageToPAA.exe") : undefined,
    process.env["ProgramFiles(x86)"] ? path.join(process.env["ProgramFiles(x86)"]!, "Steam", "steamapps", "common", "Arma 3 Tools", "ImageToPAA", "ImageToPAA.exe") : undefined,
    process.env.ProgramFiles ? path.join(process.env.ProgramFiles, "Steam", "steamapps", "common", "Arma 3 Tools", "ImageToPAA", "ImageToPAA.exe") : undefined
  ];
  for (const candidate of candidates) {
    const found = await fileExists(candidate);
    if (found) return found;
  }
  return await locateOnPath("ImageToPAA.exe");
}

export async function findPowerShell(): Promise<string | null> {
  return (await locateOnPath("pwsh.exe")) ?? (await locateOnPath("powershell.exe"));
}

export async function findHemtt(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_HEMTT);
  if (fromEnv) return fromEnv;
  const vendored = await fileExists(path.join(packageBinDir(), "hemtt.exe"));
  if (vendored) return vendored;
  return await locateOnPath("hemtt.exe") ?? await locateOnPath("hemtt");
}

export async function findResvg(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_RESVG);
  if (fromEnv) return fromEnv;
  const vendored = await fileExists(path.join(packageBinDir(), "resvg.exe"));
  if (vendored) return vendored;
  return await locateOnPath("resvg.exe") ?? await locateOnPath("resvg");
}

export async function findVtracer(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_VTRACER);
  if (fromEnv) return fromEnv;
  const vendored = await fileExists(path.join(packageBinDir(), "vtracer.exe"));
  if (vendored) return vendored;
  return await locateOnPath("vtracer.exe") ?? await locateOnPath("vtracer");
}

export async function findSqfvm(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_SQFVM);
  if (fromEnv) return fromEnv;
  const vendored = await fileExists(path.join(packageBinDir(), "sqfvm.exe"));
  if (vendored) return vendored;
  return await locateOnPath("sqfvm.exe") ?? await locateOnPath("sqfvm");
}

export async function findD2(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_D2);
  if (fromEnv) return fromEnv;
  const vendored = await fileExists(path.join(packageBinDir(), "d2.exe"));
  if (vendored) return vendored;
  return await locateOnPath("d2.exe") ?? await locateOnPath("d2");
}

export async function findGraphPython(): Promise<string | null> {
  const fromEnv = await fileExists(process.env.IF_GRAPH_PYTHON);
  if (fromEnv) return fromEnv;
  const packageRoot = path.join(packageBinDir(), "..");
  const vendored = await fileExists(path.join(packageRoot, ".venv", "Scripts", "python.exe"));
  if (vendored) return vendored;
  return await locateOnPath("python.exe") ?? await locateOnPath("python");
}

export interface CommandResult {
  code: number;
  stdout: string;
  stderr: string;
}

export async function runCommand(executable: string, args: readonly string[], timeoutMs = 120_000): Promise<CommandResult> {
  return await new Promise((resolve, reject) => {
    const child = spawn(executable, [...args], { windowsHide: true, shell: false });
    let stdout = "";
    let stderr = "";
    const collect = (current: string, chunk: Buffer): string => `${current}${chunk.toString("utf8")}`.slice(-65_536);
    child.stdout.on("data", (chunk: Buffer) => { stdout = collect(stdout, chunk); });
    child.stderr.on("data", (chunk: Buffer) => { stderr = collect(stderr, chunk); });
    const timer = setTimeout(() => {
      child.kill();
      reject(new Error(`El proceso superó ${timeoutMs} ms.`));
    }, timeoutMs);
    child.on("error", (error) => {
      clearTimeout(timer);
      reject(error);
    });
    child.on("close", (code) => {
      clearTimeout(timer);
      resolve({ code: code ?? -1, stdout, stderr });
    });
  });
}

export async function rasterizeSvg(rasterizer: Rasterizer, source: string, target: string, size: number): Promise<CommandResult> {
  if (rasterizer.name === "sharp") {
    try {
      await sharp(source)
        .resize(size, size, { fit: "contain", background: { r: 0, g: 0, b: 0, alpha: 0 } })
        .png()
        .toFile(target);
      return { code: 0, stdout: `sharp: ${size}x${size}`, stderr: "" };
    } catch (error) {
      return { code: 1, stdout: "", stderr: error instanceof Error ? error.message : String(error) };
    }
  }
  if (rasterizer.name === "inkscape") {
    return await runCommand(rasterizer.executable, [source, "--export-type=png", `--export-filename=${target}`, `--export-width=${size}`, `--export-height=${size}`]);
  }
  if (rasterizer.name === "magick") {
    return await runCommand(rasterizer.executable, ["-background", "none", "-density", "384", source, "-resize", `${size}x${size}`, target]);
  }
  return await runCommand(rasterizer.executable, ["-w", String(size), "-h", String(size), "-o", target, source]);
}

export async function renderPreviewWithResvg(resvgExecutable: string, source: string, target: string, size: number): Promise<CommandResult> {
  return await runCommand(resvgExecutable, [source, target, "--width", String(size), "--height", String(size)]);
}

export async function vectorizeWithVtracer(
  vtracerExecutable: string,
  source: string,
  target: string,
  preset: "bw" | "poster" | "photo"
): Promise<CommandResult> {
  return await runCommand(vtracerExecutable, ["--input", source, "--output", target, "--preset", preset]);
}

export async function runSqfTest(sqfvmExecutable: string, source: string, timeoutMs = 30_000): Promise<CommandResult> {
  return await runCommand(sqfvmExecutable, ["-a", "--no-spawn-player", "--input-sqf", source], timeoutMs);
}
