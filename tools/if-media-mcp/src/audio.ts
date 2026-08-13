import { createHash, randomUUID } from "node:crypto";
import { createReadStream } from "node:fs";
import { link, stat, unlink } from "node:fs/promises";
import path from "node:path";
import { findFfmpeg, findFfprobe, runCommand } from "./executables.js";
import { MAX_AUDIO_BYTES, MediaWorkspace, sha256 } from "./workspace.js";

export const AUDIO_EXTENSIONS = [".mp3", ".wav", ".flac", ".ogg"] as const;
export const AUDIO_PROFILES = ["music_standard", "music_high", "voice_mono"] as const;
const MAX_REPORT_BYTES = 5 * 1024 * 1024;

type AudioProfile = typeof AUDIO_PROFILES[number];

interface ProbeStream {
  index?: number;
  codec_type?: string;
  codec_name?: string;
  codec_long_name?: string;
  profile?: string;
  sample_fmt?: string;
  sample_rate?: string;
  channels?: number;
  channel_layout?: string;
  bit_rate?: string;
  duration?: string;
  tags?: Record<string, string>;
}

interface RawProbe {
  streams?: ProbeStream[];
  format?: {
    format_name?: string;
    format_long_name?: string;
    duration?: string;
    size?: string;
    bit_rate?: string;
    tags?: Record<string, string>;
  };
}

export interface AudioProbe {
  path: string;
  sha256: string;
  sizeBytes: number;
  format: {
    name: string | null;
    longName: string | null;
    durationSeconds: number | null;
    bitRate: number | null;
    tags: Record<string, string>;
  };
  audioStreams: Array<{
    index: number | null;
    codec: string | null;
    codecLongName: string | null;
    profile: string | null;
    sampleFormat: string | null;
    sampleRate: number | null;
    channels: number | null;
    channelLayout: string | null;
    bitRate: number | null;
    durationSeconds: number | null;
    tags: Record<string, string>;
  }>;
}

function finiteNumber(value: string | number | undefined): number | null {
  if (value === undefined || value === "N/A") return null;
  const parsed = typeof value === "number" ? value : Number.parseFloat(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function lastNumber(text: string, expression: RegExp): number | null {
  const matches = [...text.matchAll(expression)];
  const value = matches.at(-1)?.[1];
  return value === undefined ? null : finiteNumber(value);
}

async function sha256File(filePath: string): Promise<string> {
  return await new Promise((resolve, reject) => {
    const hash = createHash("sha256");
    const stream = createReadStream(filePath);
    stream.on("data", (chunk) => hash.update(chunk));
    stream.on("error", reject);
    stream.on("end", () => resolve(hash.digest("hex")));
  });
}

async function requireAudioTools(): Promise<{ ffmpeg: string; ffprobe: string }> {
  const [ffmpeg, ffprobe] = await Promise.all([findFfmpeg(), findFfprobe()]);
  if (!ffmpeg || !ffprobe) {
    throw new Error("FFmpeg/ffprobe no están disponibles. Coloca ffmpeg.exe y ffprobe.exe en tools/if-media-mcp/bin/ o define IF_FFMPEG e IF_FFPROBE.");
  }
  return { ffmpeg, ffprobe };
}

async function requireAbsent(target: string, workspace: MediaWorkspace): Promise<void> {
  try {
    await stat(target);
    throw new Error(`La salida ya existe y no será sobrescrita: ${workspace.relative(target)}.`);
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
  }
}

function temporaryOutputPath(target: string): string {
  const extension = path.extname(target);
  return `${target.slice(0, -extension.length)}.${randomUUID()}.tmp${extension}`;
}

async function publishExclusive(temporary: string, target: string, workspace: MediaWorkspace): Promise<void> {
  try {
    await link(temporary, target);
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code === "EEXIST") {
      throw new Error(`La salida ya existe y no será sobrescrita: ${workspace.relative(target)}.`);
    }
    throw error;
  }
}

async function writeJson(workspace: MediaWorkspace, target: string, payload: Record<string, unknown>): Promise<{ path: string; sha256: string }> {
  const bytes = Buffer.from(`${JSON.stringify(payload, null, 2)}\n`, "utf8");
  await workspace.writeNewFile(target, bytes, MAX_REPORT_BYTES);
  return { path: workspace.relative(target), sha256: sha256(bytes) };
}

async function ffmpegVersion(executable: string): Promise<string> {
  const result = await runCommand(executable, ["-version"], 15_000);
  if (result.code !== 0) return "unknown";
  return result.stdout.split(/\r?\n/, 1)[0]?.trim() || "unknown";
}

export class AudioService {
  constructor(private readonly workspace: MediaWorkspace) {}

  async probe(inputPath: string): Promise<AudioProbe> {
    const source = await this.workspace.resolveInput(inputPath, AUDIO_EXTENSIONS, MAX_AUDIO_BYTES);
    const { ffprobe } = await requireAudioTools();
    const result = await runCommand(ffprobe, [
      "-v", "error",
      "-show_format",
      "-show_streams",
      "-of", "json",
      source
    ], 120_000);
    if (result.code !== 0) throw new Error(`ffprobe no pudo inspeccionar el audio: ${result.stderr || result.stdout}`);

    let raw: RawProbe;
    try {
      raw = JSON.parse(result.stdout) as RawProbe;
    } catch {
      throw new Error("ffprobe devolvió JSON inválido.");
    }
    const audioStreams = (raw.streams ?? []).filter((stream) => stream.codec_type === "audio").map((stream) => ({
      index: finiteNumber(stream.index),
      codec: stream.codec_name ?? null,
      codecLongName: stream.codec_long_name ?? null,
      profile: stream.profile ?? null,
      sampleFormat: stream.sample_fmt ?? null,
      sampleRate: finiteNumber(stream.sample_rate),
      channels: finiteNumber(stream.channels),
      channelLayout: stream.channel_layout ?? null,
      bitRate: finiteNumber(stream.bit_rate),
      durationSeconds: finiteNumber(stream.duration),
      tags: stream.tags ?? {}
    }));
    if (audioStreams.length === 0) throw new Error("El archivo no contiene ningún stream de audio reconocible.");
    const metadata = await stat(source);
    return {
      path: this.workspace.relative(source),
      sha256: await sha256File(source),
      sizeBytes: metadata.size,
      format: {
        name: raw.format?.format_name ?? null,
        longName: raw.format?.format_long_name ?? null,
        durationSeconds: finiteNumber(raw.format?.duration),
        bitRate: finiteNumber(raw.format?.bit_rate),
        tags: raw.format?.tags ?? {}
      },
      audioStreams
    };
  }

  async analyzeQuality(input: { input_path: string; output_name: string }) {
    const source = await this.workspace.resolveInput(input.input_path, AUDIO_EXTENSIONS, MAX_AUDIO_BYTES);
    const target = await this.workspace.audioTestPath(input.output_name, "_quality.json");
    await requireAbsent(target, this.workspace);
    const { ffmpeg } = await requireAudioTools();
    const probe = await this.probe(input.input_path);
    const loudness = await runCommand(ffmpeg, [
      "-hide_banner", "-nostdin", "-nostats", "-i", source,
      "-filter_complex", "ebur128=peak=true:framelog=verbose",
      "-f", "null", "-"
    ], 300_000);
    if (loudness.code !== 0) throw new Error(`Falló el análisis EBU R128: ${loudness.stderr || loudness.stdout}`);
    const volume = await runCommand(ffmpeg, [
      "-hide_banner", "-nostdin", "-nostats", "-i", source,
      "-af", "volumedetect",
      "-f", "null", "-"
    ], 300_000);
    if (volume.code !== 0) throw new Error(`Falló el análisis de volumen: ${volume.stderr || volume.stdout}`);
    const eburText = `${loudness.stdout}\n${loudness.stderr}`;
    const volumeText = `${volume.stdout}\n${volume.stderr}`;
    const measured = {
      integratedLufs: lastNumber(eburText, /\bI:\s*(-?(?:inf|\d+(?:\.\d+)?))\s+LUFS/g),
      loudnessRangeLu: lastNumber(eburText, /\bLRA:\s*(-?(?:inf|\d+(?:\.\d+)?))\s+LU/g),
      truePeakDbfs: lastNumber(eburText, /\bPeak:\s*(-?(?:inf|\d+(?:\.\d+)?))\s+dBFS/g),
      meanVolumeDb: lastNumber(volumeText, /mean_volume:\s*(-?(?:inf|\d+(?:\.\d+)?))\s+dB/g),
      maxVolumeDb: lastNumber(volumeText, /max_volume:\s*(-?(?:inf|\d+(?:\.\d+)?))\s+dB/g)
    };
    const report = {
      schemaVersion: 1,
      analysisKind: "measured_ffmpeg_ebu_r128_and_volumedetect",
      source: probe,
      measured,
      assessment: {
        clippingRisk: measured.truePeakDbfs !== null ? measured.truePeakDbfs >= -0.1 : null,
        note: "clippingRisk es una evaluación técnica por umbral de true peak; no sustituye escucha crítica ni prueba en Arma 3."
      },
      generatedAt: new Date().toISOString()
    };
    const stored = await writeJson(this.workspace, target, report);
    await this.workspace.appendAudit("audio_analyze_quality", "ok", { source_sha256: probe.sha256, report_sha256: stored.sha256 });
    return { ...stored, measured, sourceSha256: probe.sha256 };
  }

  async detectSilence(input: { input_path: string; output_name: string; noise_db: number; min_duration: number }) {
    const source = await this.workspace.resolveInput(input.input_path, AUDIO_EXTENSIONS, MAX_AUDIO_BYTES);
    const target = await this.workspace.audioTestPath(input.output_name, "_silences.json");
    await requireAbsent(target, this.workspace);
    const { ffmpeg } = await requireAudioTools();
    const probe = await this.probe(input.input_path);
    const result = await runCommand(ffmpeg, [
      "-hide_banner", "-nostdin", "-nostats", "-i", source,
      "-af", `silencedetect=noise=${input.noise_db}dB:d=${input.min_duration}`,
      "-f", "null", "-"
    ], 300_000);
    if (result.code !== 0) throw new Error(`Falló silencedetect: ${result.stderr || result.stdout}`);
    const text = `${result.stdout}\n${result.stderr}`;
    const events = [...text.matchAll(/silence_(start|end):\s*([0-9.]+)(?:\s*\|\s*silence_duration:\s*([0-9.]+))?/g)];
    const intervals: Array<{ start: number; end: number; duration: number }> = [];
    let openStart: number | null = null;
    for (const event of events) {
      const timestamp = Number.parseFloat(event[2]!);
      if (event[1] === "start") {
        openStart = timestamp;
      } else {
        const duration = event[3] ? Number.parseFloat(event[3]) : (openStart === null ? 0 : timestamp - openStart);
        intervals.push({ start: openStart ?? Math.max(0, timestamp - duration), end: timestamp, duration });
        openStart = null;
      }
    }
    const totalDuration = probe.format.durationSeconds;
    if (openStart !== null && totalDuration !== null && totalDuration >= openStart) {
      intervals.push({ start: openStart, end: totalDuration, duration: totalDuration - openStart });
    }
    const report = {
      schemaVersion: 1,
      analysisKind: "measured_ffmpeg_silencedetect",
      sourcePath: probe.path,
      sourceSha256: probe.sha256,
      durationSeconds: totalDuration,
      parameters: { noiseDb: input.noise_db, minDurationSeconds: input.min_duration },
      intervals,
      generatedAt: new Date().toISOString()
    };
    const stored = await writeJson(this.workspace, target, report);
    await this.workspace.appendAudit("audio_detect_silence", "ok", { source_sha256: probe.sha256, interval_count: intervals.length });
    return { ...stored, sourceSha256: probe.sha256, intervalCount: intervals.length, intervals };
  }

  async renderWaveform(input: { input_path: string; output_name: string; width: number; height: number; color: string }) {
    const source = await this.workspace.resolveInput(input.input_path, AUDIO_EXTENSIONS, MAX_AUDIO_BYTES);
    const target = await this.workspace.audioTestPath(input.output_name, "_waveform.png");
    const temporaryTarget = temporaryOutputPath(target);
    await requireAbsent(target, this.workspace);
    const { ffmpeg } = await requireAudioTools();
    const probe = await this.probe(input.input_path);
    try {
      const result = await runCommand(ffmpeg, [
        "-hide_banner", "-nostdin", "-n", "-i", source,
        "-filter_complex", `aformat=channel_layouts=mono,showwavespic=s=${input.width}x${input.height}:colors=${input.color}:scale=sqrt`,
        "-frames:v", "1", temporaryTarget
      ], 300_000);
      if (result.code !== 0) throw new Error(`Falló showwavespic: ${result.stderr || result.stdout}`);
      const metadata = await stat(temporaryTarget);
      if (!metadata.isFile() || metadata.size <= 0 || metadata.size > MAX_REPORT_BYTES) {
        throw new Error("La waveform generada está vacía o supera el límite permitido.");
      }
      const hash = await sha256File(temporaryTarget);
      await publishExclusive(temporaryTarget, target, this.workspace);
      await this.workspace.appendAudit("audio_render_waveform", "ok", { source_sha256: probe.sha256, output_sha256: hash });
      return { path: this.workspace.relative(target), sha256: hash, width: input.width, height: input.height, sourceSha256: probe.sha256 };
    } finally {
      await unlink(temporaryTarget).catch(() => undefined);
    }
  }

  async convertArmaOgg(input: {
    input_path: string;
    output_name: string;
    profile: AudioProfile;
    normalize: boolean;
    start?: number | undefined;
    duration?: number | undefined;
  }) {
    const source = await this.workspace.resolveInput(input.input_path, AUDIO_EXTENSIONS, MAX_AUDIO_BYTES);
    const target = await this.workspace.audioTestPath(input.output_name, ".ogg");
    const temporaryTarget = temporaryOutputPath(target);
    const manifestTarget = await this.workspace.audioTestPath(input.output_name, ".manifest.json");
    await Promise.all([requireAbsent(target, this.workspace), requireAbsent(manifestTarget, this.workspace)]);
    const { ffmpeg } = await requireAudioTools();
    const sourceProbe = await this.probe(input.input_path);
    const profile = {
      music_standard: { quality: "4", channels: "2", sampleRate: "48000" },
      music_high: { quality: "6", channels: "2", sampleRate: "48000" },
      voice_mono: { quality: "4", channels: "1", sampleRate: "48000" }
    }[input.profile];
    const args = ["-hide_banner", "-nostdin", "-n"];
    if (input.start !== undefined) args.push("-ss", String(input.start));
    args.push("-i", source);
    if (input.duration !== undefined) args.push("-t", String(input.duration));
    args.push("-map", "0:a:0", "-vn", "-map_metadata", "-1");
    if (input.normalize) args.push("-af", "loudnorm=I=-16:TP=-1.5:LRA=11");
    args.push("-c:a", "libvorbis", "-q:a", profile.quality, "-ar", profile.sampleRate, "-ac", profile.channels, temporaryTarget);
    let published = false;
    try {
      const result = await runCommand(ffmpeg, args, 600_000);
      if (result.code !== 0) throw new Error(`Falló la conversión Vorbis/OGG: ${result.stderr || result.stdout}`);
      const outputMetadata = await stat(temporaryTarget);
      if (!outputMetadata.isFile() || outputMetadata.size <= 0 || outputMetadata.size > MAX_AUDIO_BYTES) {
        throw new Error("El OGG generado está vacío o supera el límite permitido.");
      }
      await publishExclusive(temporaryTarget, target, this.workspace);
      published = true;
      const outputProbe = await this.probe(this.workspace.relative(target));
      const manifest = {
        schemaVersion: 1,
        status: "CANDIDATE_NOT_ENGINE_TESTED",
        sourcePath: sourceProbe.path,
        sourceSha256: sourceProbe.sha256,
        sourceDuration: sourceProbe.format.durationSeconds,
        outputPath: outputProbe.path,
        outputSha256: outputProbe.sha256,
        outputDuration: outputProbe.format.durationSeconds,
        codec: outputProbe.audioStreams[0]?.codec ?? null,
        sampleRate: outputProbe.audioStreams[0]?.sampleRate ?? null,
        channels: outputProbe.audioStreams[0]?.channels ?? null,
        qualitySetting: `libvorbis:q=${profile.quality}`,
        profile: input.profile,
        normalized: input.normalize,
        trim: { start: input.start ?? 0, duration: input.duration ?? null },
        metadataPolicy: "stripped_to_avoid_unintended_spoilers_and_non_runtime_tags",
        ffmpegVersion: await ffmpegVersion(ffmpeg),
        generatedAt: new Date().toISOString()
      };
      const storedManifest = await writeJson(this.workspace, manifestTarget, manifest);
      await this.workspace.appendAudit("audio_convert_arma_ogg", "ok", { source_sha256: sourceProbe.sha256, output_sha256: outputProbe.sha256 });
      return { path: outputProbe.path, manifest: storedManifest.path, sha256: outputProbe.sha256, probe: outputProbe, status: manifest.status };
    } catch (error) {
      if (published) await unlink(target).catch(() => undefined);
      throw error;
    } finally {
      await unlink(temporaryTarget).catch(() => undefined);
    }
  }

  async validateRuntime(input: { input_path: string; source_path?: string | undefined }) {
    const candidate = await this.workspace.resolveInput(input.input_path, [".ogg"], MAX_AUDIO_BYTES);
    const { ffmpeg } = await requireAudioTools();
    const candidateProbe = await this.probe(input.input_path);
    const decode = await runCommand(ffmpeg, [
      "-hide_banner", "-nostdin", "-v", "error", "-xerror", "-i", candidate,
      "-map", "0:a:0", "-f", "null", "-"
    ], 600_000);
    const stream = candidateProbe.audioStreams[0];
    const checks = {
      decodeTest: decode.code === 0,
      oggContainer: candidateProbe.format.name?.split(",").includes("ogg") ?? false,
      vorbisCodec: stream?.codec === "vorbis",
      supportedChannels: stream?.channels !== null && stream?.channels !== undefined ? stream.channels >= 1 && stream.channels <= 2 : false,
      supportedSampleRate: stream?.sampleRate === 44_100 || stream?.sampleRate === 48_000,
      metadataStripped: Object.keys(candidateProbe.format.tags).length === 0
    };
    let sourceComparison: Record<string, unknown> | null = null;
    if (input.source_path) {
      const sourceProbe = await this.probe(input.source_path);
      const sourceDuration = sourceProbe.format.durationSeconds;
      const outputDuration = candidateProbe.format.durationSeconds;
      const difference = sourceDuration !== null && outputDuration !== null ? outputDuration - sourceDuration : null;
      sourceComparison = {
        sourcePath: sourceProbe.path,
        sourceSha256: sourceProbe.sha256,
        durationDifferenceSeconds: difference,
        durationWithinTolerance: difference !== null ? Math.abs(difference) <= 0.25 : null
      };
    }
    const technicallyValid = Object.values(checks).every(Boolean);
    await this.workspace.appendAudit("audio_validate_runtime", technicallyValid ? "ok" : "blocked", { candidate_sha256: candidateProbe.sha256 });
    return {
      technicallyValid,
      checks,
      candidate: candidateProbe,
      sourceComparison,
      decodeError: decode.code === 0 ? null : (decode.stderr || decode.stdout).slice(0, 2_000),
      status: technicallyValid ? "IMPLEMENTED_CANDIDATE_NOT_PROVEN_IN_ARMA" : "REJECTED_TECHNICALLY",
      note: "Esta validación comprueba contenedor, codec y decodificación con FFmpeg. No sustituye CfgMusic/playMusic ni permite declarar PROBADO sin ejecutar Arma 3 y revisar el RPT."
    };
  }
}