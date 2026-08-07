import { mkdir, realpath } from "node:fs/promises";
import path from "node:path";
import sharp from "sharp";

const ALLOWED_SIZES = new Set([32, 64, 128, 256, 512, 1024, 2048]);

function argument(name: string): string {
  const index = process.argv.indexOf(name);
  const value = index >= 0 ? process.argv[index + 1] : undefined;
  if (!value) throw new Error(`Falta ${name}.`);
  return value;
}

function isInside(parent: string, candidate: string): boolean {
  const relative = path.relative(parent, candidate);
  return relative === "" || (!relative.startsWith(`..${path.sep}`) && relative !== ".." && !path.isAbsolute(relative));
}

async function main(): Promise<void> {
  const projectRoot = await realpath(path.resolve(argument("--project-root")));
  const artRoot = await realpath(path.join(projectRoot, "art"));
  const input = await realpath(path.resolve(argument("--input")));
  const output = path.resolve(argument("--output"));
  const exportRoot = path.join(artRoot, "export");
  const size = Number.parseInt(argument("--size"), 10);

  if (!isInside(artRoot, input) || path.extname(input).toLowerCase() !== ".svg") {
    throw new Error("La entrada debe ser un SVG dentro de art/.");
  }
  if (!isInside(exportRoot, output) || path.extname(output).toLowerCase() !== ".png") {
    throw new Error("La salida debe ser un PNG dentro de art/export/.");
  }
  if (!ALLOWED_SIZES.has(size)) {
    throw new Error("El tamaño debe ser una potencia de dos admitida.");
  }

  await mkdir(exportRoot, { recursive: true });
  const realExportRoot = await realpath(exportRoot);
  if (!isInside(projectRoot, realExportRoot) || path.resolve(exportRoot).toLowerCase() !== path.resolve(realExportRoot).toLowerCase()) {
    throw new Error("art/export usa un enlace o sale del proyecto.");
  }

  const info = await sharp(input)
    .resize(size, size, { fit: "contain", background: { r: 0, g: 0, b: 0, alpha: 0 } })
    .png()
    .toFile(output);
  if (info.width !== size || info.height !== size) {
    throw new Error(`Dimensiones inesperadas: ${info.width}x${info.height}.`);
  }
}

main().catch((error: unknown) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exitCode = 1;
});
