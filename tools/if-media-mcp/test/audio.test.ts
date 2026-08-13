import assert from "node:assert/strict";
import { mkdtemp, mkdir, readFile, rm, stat, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { findFfmpeg, findFfprobe, runCommand } from "../src/executables.js";
import { MediaService } from "../src/server.js";
import { MediaWorkspace, sha256 } from "../src/workspace.js";

async function audioFixture(): Promise<{ root: string; source: string } | null> {
  const [ffmpeg, ffprobe] = await Promise.all([findFfmpeg(), findFfprobe()]);
  if (!ffmpeg || !ffprobe) return null;
  const root = await mkdtemp(path.join(os.tmpdir(), "if-media-audio-"));
  const sourceDir = path.join(root, "IslasFracturadas.Altis", "assets", "music");
  await mkdir(sourceDir, { recursive: true });
  await mkdir(path.join(root, "art"), { recursive: true });
  await writeFile(path.join(root, "AGENTS.md"), "# fixture\n", "utf8");
  const source = path.join(sourceDir, "fixture.mp3");
  const generated = await runCommand(ffmpeg, [
    "-hide_banner", "-y",
    "-f", "lavfi", "-i", "anullsrc=r=48000:cl=stereo:d=0.6",
    "-f", "lavfi", "-i", "sine=frequency=440:sample_rate=48000:duration=1.2",
    "-filter_complex", "[1:a]pan=stereo|c0=c0|c1=c0[tone];[0:a][tone]concat=n=2:v=0:a=1[out]",
    "-map", "[out]", "-c:a", "libmp3lame", "-q:a", "4", source
  ], 60_000);
  if (generated.code !== 0) {
    await rm(root, { recursive: true, force: true });
    throw new Error(generated.stderr || generated.stdout);
  }
  return { root, source };
}

test("pipeline de audio local acepta MP3 y produce solo borradores trazables", async (t) => {
  const fixture = await audioFixture();
  if (!fixture) {
    t.skip("FFmpeg/ffprobe no están instalados; la disponibilidad queda cubierta por media_status.");
    return;
  }
  try {
    const workspace = await MediaWorkspace.open(fixture.root);
    const service = new MediaService(workspace);
    const relativeSource = "IslasFracturadas.Altis/assets/music/fixture.mp3";
    const sourceBefore = await readFile(fixture.source);
    const sourceHashBefore = sha256(sourceBefore);

    const probeResult = await service.probeMedia({ input_path: relativeSource });
    const probe = JSON.parse((probeResult.content[0] as { text: string }).text) as { format: { durationSeconds: number }; audioStreams: Array<{ codec: string }> };
    assert.equal(probe.audioStreams[0]?.codec, "mp3");
    assert.ok(probe.format.durationSeconds > 1.5);

    const quality = await service.analyzeAudioQuality({ input_path: relativeSource, output_name: "fixture" });
    const qualityPayload = JSON.parse((quality.content[0] as { text: string }).text) as { path: string };
    assert.match(qualityPayload.path, /^production\/media\/drafts\/audio-test\//);

    const silence = await service.detectAudioSilence({ input_path: relativeSource, output_name: "fixture", noise_db: -45, min_duration: 0.2 });
    const silencePayload = JSON.parse((silence.content[0] as { text: string }).text) as { intervalCount: number };
    assert.ok(silencePayload.intervalCount >= 1);

    const waveform = await service.renderAudioWaveform({ input_path: relativeSource, output_name: "fixture", width: 640, height: 240, color: "8FA5B8" });
    const waveformPayload = JSON.parse((waveform.content[0] as { text: string }).text) as { path: string };
    assert.match(waveformPayload.path, /^production\/media\/drafts\/audio-test\//);
    assert.doesNotMatch(waveformPayload.path, /\/runtime\//);
    assert.ok((await stat(path.join(fixture.root, waveformPayload.path))).size > 0);

    const converted = await service.convertAudioArmaOgg({ input_path: relativeSource, output_name: "fixture_runtime", profile: "music_high", normalize: false });
    const convertedPayload = JSON.parse((converted.content[0] as { text: string }).text) as { path: string; manifest: string };
    assert.equal(path.extname(convertedPayload.path), ".ogg");
    assert.match(convertedPayload.path, /^production\/media\/drafts\/audio-test\//);
    assert.doesNotMatch(convertedPayload.path, /\/runtime\//);
    const manifest = JSON.parse(await readFile(path.join(fixture.root, convertedPayload.manifest), "utf8")) as { sourceSha256: string; codec: string; metadataPolicy: string };
    assert.equal(manifest.sourceSha256, sourceHashBefore);
    assert.equal(manifest.codec, "vorbis");
    assert.match(manifest.metadataPolicy, /stripped/);

    await assert.rejects(
      service.convertAudioArmaOgg({ input_path: relativeSource, output_name: "fixture_runtime", profile: "music_high", normalize: false }),
      /no será sobrescrita/
    );

    const validated = await service.validateAudioRuntime({ input_path: convertedPayload.path, source_path: relativeSource });
    const validatedPayload = JSON.parse((validated.content[0] as { text: string }).text) as { technicallyValid: boolean; status: string };
    assert.equal(validatedPayload.technicallyValid, true);
    assert.equal(validatedPayload.status, "IMPLEMENTED_CANDIDATE_NOT_PROVEN_IN_ARMA");
    assert.equal(sha256(await readFile(fixture.source)), sourceHashBefore);
  } finally {
    await rm(fixture.root, { recursive: true, force: true });
  }
});