<img src="docs/images/seqvio-mark.svg" width="64" alt="Seqvio Studio logo">

# Seqvio Studio

**Make long-form video creation simpler.**

[简体中文](README.md) · English

[Download](https://github.com/makesynt/seqvio-studio/releases/tag/v0.1.0) · [User guide](docs/USAGE.en.md) · [Style samples](https://github.com/makesynt/seqvio-studio/releases/tag/style-samples-v1)

Seqvio Studio is a local desktop workspace for creating videos. Start with a topic, reference material, or a complete script. Connect your own OpenCode, Codex, or Antigravity installation, then work through an outline, scenes and narration, visual authoring, keyframe review, voiceover, and video export.

The agent writes visuals and animation using the selected style. The Seqvio engine compiles scenes, maps visuals to voiceover timing, checks quality, and renders the result. Review and approve the important stages, revise individual scenes, and reuse outputs that remain valid.

![The Seqvio Studio style library, shown in the Chinese interface](docs/images/style-library.png)

## Features

- **Reference material to video**: begin with a topic, pasted script, links, or local files; review the outline before approving scenes and narration.
- **41 built-in styles**: technical diagrams, whiteboards, handwritten notes, blackboards, flat explainers, kinetic type, collage, and more. Import/export style Skill packages, or extract a reusable style from a completed video.
- **Code-driven visuals and animation**: combine text, images, DOM, SVG, Canvas, and Three.js. Render 3D scenes locally without requiring a generative video model for frame rendering.
- **Voiceover and subtitles**: use Windows system speech locally, configure services such as MiniMax or self-hosted CosyVoice, or choose no voiceover. Export MP4 and separate SRT/VTT subtitles.
- **Review and recovery**: inspect keyframes and quality findings before production; keep checkpoints after cancellation or interruption, and rebuild only affected outputs.
- **Element and timeline editing**: edit supported text, images, SVG, 2D layers, and animation. Trim, split, reorder, and mix clips with music, sound effects, text, and image overlays.
- **Local rendering and adaptive GPU use**: reuse Electron's Chromium by default. Select an available hardware codec when suitable and faster, with CPU fallback on failure. An optional Chrome backend is available for compatibility.

## Download and install

The current public release is **0.1.0, an unsigned Windows x64 preview**. A macOS installer has not been released; Windows validation does not establish macOS compatibility.

1. Open the [v0.1.0 release](https://github.com/makesynt/seqvio-studio/releases/tag/v0.1.0).
2. Under **Assets**, download [`Seqvio-Studio-0.1.0-win-x64-Setup.exe`](https://github.com/makesynt/seqvio-studio/releases/download/v0.1.0/Seqvio-Studio-0.1.0-win-x64-Setup.exe), approximately **188.8 MB**.
3. Download [`SHA256SUMS.txt`](https://github.com/makesynt/seqvio-studio/releases/download/v0.1.0/SHA256SUMS.txt), verify the installer, then run it and choose an installation directory.
4. Launch **Seqvio Studio** from the desktop or Start menu, then configure a creation engine as described below.

Verify the file in PowerShell:

```powershell
Get-FileHash -Algorithm SHA256 .\Seqvio-Studio-0.1.0-win-x64-Setup.exe
```

Installer SHA-256 for this release:

```text
9f4b58131b5f5f1f597f531e7f3357a0eb2df0134fa8d5caa00cd95181809d2d
```

This preview is not code signed. Windows may show an unknown-publisher or SmartScreen warning, and some device policies may block it. Confirm the download source and checksum before proceeding through any options allowed by your system. See [installation and troubleshooting](docs/USAGE.en.md#installation-and-first-launch).

GitHub's automatically generated **Source code (zip/tar.gz)** downloads are snapshots of this distribution repository, not installers. This repository hosts product documentation, releases, samples, and third-party build material. It does not contain the complete desktop application development project; cloning it and running `npm install` will not launch the app.

## What is included?

| Component | Delivery |
| --- | --- |
| Desktop app, Electron, and the default Chromium rendering backend | Included in the installer |
| FFmpeg 8.1.3 source v2 and ffprobe | Included in the Windows installer; available offline |
| 41 styles, covers, and silent short preview loops | Included in the installer |
| Inter and Noto Sans SC UI fonts; Virgil and Long Cang default whiteboard fonts | Included; available offline |
| Full style sample videos | Downloaded from this repository's GitHub Releases on first preview, verified, and cached |
| Xiaolai, Yozai, LXGW WenKai Lite, Liu Jian Mao Cao, and Zhi Mang Xing fonts | Downloaded and cached when first used |
| Optional Chrome compatibility backend | Prepared on demand; the default renderer does not require a separate Chrome installation |
| OpenCode / Codex / Antigravity CLI, model account, and quota | Install and configure your own; one working engine is sufficient |
| Cloud voiceover or a self-hosted CosyVoice service | Supply your own service and credentials; Windows system speech needs no cloud service |

The bundled media tools include x265, Windows hardware codecs, and multiple audio libraries. **The export interface still defaults to H.264/AAC MP4**; including x265 does not add an H.265 export option. GPU selection depends on hardware, drivers, and measured speed. Initial capability probing adds overhead.

## Create your first video

1. **Connect an engine.** Install and authenticate a supported CLI on your computer. Open **Settings → Engines & connections** (引擎与连接), choose an engine and an available model, then check the connection. A successful check only confirms that the CLI starts; model access and quota are still required.
2. **Describe the video.** Enter the topic, audience, target duration, and key points on the home page. Attach reference material, select a visual style, and start creation.
3. **Approve the outline.** Review the central argument, section structure, and time budget. Request changes in the conversation before confirming.
4. **Review scenes and narration.** Check each scene's voiceover, visual intent, and steps. Choose a voice or no voiceover under style and voice settings (风格与配音).
5. **Review keyframes.** Generate static previews, choose landscape/portrait and 720p/1080p, inspect the updated frames and quality findings, then approve the current output.
6. **Produce and export.** Generate voiceover and scene videos, preview the assembled result, and export the MP4 and any required subtitle files.
7. **Revise.** Change one scene in the workspace or use element editing (元素编辑) and timeline editing (时间线剪辑). Review affected visuals again and produce the updated version.

Start with a 30–60 second project to learn the workflow. See the [English user guide](docs/USAGE.en.md) for a sample brief, voice configuration, editing, caching, and recovery.

## Offline use and data

Downloaded samples and optional fonts can be reused offline. Bundled fonts, media tools, and local rendering of already-prepared scenes and assets do not need an internet connection. Sample downloads support verification, resume, and retries. Remove an individual sample in its preview, or clear sample caches under **Settings → Storage**.

Local rendering does not make model inference offline. AI creation uses the model service configured through your selected CLI; cloud voiceover also needs network access. Reference material, prompts, style reference images, and review keyframes may be passed to the selected model as task inputs. Narration is sent to your selected online voice service. Choose services according to your data and cost requirements. Projects and outputs are stored locally; include project files and related assets in backups.

## Licenses, source, and feedback

Open **Settings → About & diagnostics → Third-party licenses and source** (第三方许可与源码) for local notices and source links. FFmpeg/ffprobe are distributed as separate tools under GPL-3.0-or-later. Their complete corresponding source, dependencies, build scripts, and records are available in the [FFmpeg source v2 release](https://github.com/makesynt/seqvio-studio/releases/tag/ffmpeg-seqvio-source-v2). Other third-party components retain their respective licenses.

Report problems in [Issues](https://github.com/makesynt/seqvio-studio/issues), including the app version, OS, engine, and reproduction steps. Remove credentials and private material before posting. The current installer has been checked for installation/uninstallation, local speech, both rendering backends, and export. Physical NVIDIA/AMD hardware and macOS have not yet been validated. This preview is under active development.
