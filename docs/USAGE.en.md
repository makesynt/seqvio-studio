# Seqvio Studio user guide

[Home](../README.en.md) · [简体中文](USAGE.zh-CN.md)

This guide covers the **0.1.0 unsigned Windows x64 preview**. Chinese UI labels are included where useful. No validated macOS installer is currently published.

## Installation and first launch

Download the setup EXE and SHA256SUMS.txt from **Assets** in the [v0.1.0 release](https://github.com/makesynt/seqvio-studio/releases/tag/v0.1.0). In the download directory, run:

```powershell
Get-FileHash -Algorithm SHA256 .\Seqvio-Studio-0.1.0-win-x64-Setup.exe
```

Compare the result with the checksum file from the same release. The installer is approximately 188.8 MB; unpacked application files total about 562.4 MB. Leave additional space for projects, audio, video, and download caches. Installer size alone is not the disk-space requirement.

Run the setup program, choose a directory, and launch the app from the desktop or Start menu. The installer includes the application runtime and media tools. Seqvio itself does not require a separate Node.js, npm, Python, or FFmpeg installation; your chosen agent CLI may have its own installation requirements.

This build is unsigned. Windows may show an unknown-publisher or “Windows protected your PC” warning. After verifying the source, whether you can proceed depends on the options and security policies on your device. Smart App Control or enterprise policies may block execution. Record the exact warning instead of treating a failure to launch as a rendering issue. See [Microsoft's SmartScreen documentation](https://learn.microsoft.com/windows/apps/package-and-deploy/smartscreen-reputation).

## Configure a creation engine

Choose one engine; you do not need all three:

| Engine | Preparation | Official setup documentation |
| --- | --- | --- |
| OpenCode | Local `opencode` CLI, working provider/model, and credentials | [OpenCode docs](https://opencode.ai/docs/) |
| Codex | Local `codex` CLI, authentication, and model access | [Codex CLI docs](https://developers.openai.com/codex/cli/) |
| Antigravity | Official `agy` CLI, authentication, and an available model | [Antigravity CLI docs](https://antigravity.google/docs/getting-started?tab=cli) |

The Windows desktop app must be able to locate the native CLI executable. First verify in a terminal that your selected CLI starts, is authenticated, and can access a model. Then restart Seqvio. A browser account or a chat login in another app does not necessarily configure the corresponding CLI.

Open **Settings → Engines & connections** (引擎与连接), choose the engine, refresh/select an available model, and check the connection. Leaving the model blank uses the local default. A connection check does not prove that the model is accessible or that the account has quota. Follow the actual provider error if a task fails after a successful check.

For a nonstandard CLI location, set `OPENCODE_CMD`, `CODEX_CMD`, or `ANTIGRAVITY_CMD` in the environment used to launch Seqvio, pointing to the corresponding native executable. Do not paste credentials into the creative brief or reference material.

## Choose a style and voice

### Style library

The [style-pack catalog](STYLE-PACKS.md) offers 41 importable ZIPs and an all-packs collection. The app already bundles these styles. For personal copies, download an individual ZIP and use Custom → Import style package (自定义 → 导入风格包). Extract the collection before importing its ZIPs one at a time.

Browse the 41 built-in styles. Covers and silent short loops are bundled. Opening a full sample downloads only that video, verifies it, and caches it. Silent hover loops are intentional, not a voiceover failure.

The first full-sample preview needs access to GitHub Releases. Retry after interruptions; downloads support resume. Completed samples play offline. Remove a sample in its preview, or clear all sample caches under **Settings → Storage**. The next preview after removal needs another download.

Use the selected style to start creation. Import personal styles as supported Skill directories or ZIP packages. After completing a video, extract and review its style rules, save a reusable style, and export it for sharing. Changes to one project do not automatically change the style library.

### Voiceover

Choose a method in the project's style and voice settings (风格与配音):

| Method | Suitable for | Preparation |
| --- | --- | --- |
| Windows system speech | Testing the workflow or local offline voiceover | A system voice installed on your PC |
| No voiceover | Silent visuals, music-only work, or later audio editing | No online speech service |
| MiniMax API | Online system/custom voices available to your account | Matching China/international API key, voice, and quota |
| Self-hosted CosyVoice | Your own speech service and reference voice | Reachable service URL, required reference audio, and service configuration |
| Edge TTS, OpenAI, ElevenLabs | Other supported speech-service integrations | Each service's dependencies, credentials, and network access; verify availability yourself |

For MiniMax, select the China or international region, enter the matching API key, and save the settings. Use a model and `voice_id` available to your account. The app does not automatically switch regions. Online requests may incur charges; check provider-side usage after failures or cancellation too.

Visual timing uses the actual synthesized audio duration. Subtitle and within-sentence phrase timings are currently estimates, not word-level speech recognition or forced alignment.

## Create your first video

### 1. Supply a brief and references

On the home page, enter a topic or paste a script, attach files/links, and select the style, target duration, and engine. Start with a short project. For example:

> Create an approximately 45-second explainer for office workers who are new to AI. Explain how an AI knowledge base helps find company information, using a technical-diagram style. Cover three steps: ask a question, retrieve relevant material, and generate an answer with citations. Keep each scene's narration short, avoid overstating capabilities, and end with a reminder to verify the sources.

This is a sample brief, not a guaranteed output. Generated content and final duration depend on the model, revisions, and actual voiceover. Attach only material you intend the selected model to process.

### 2. Review the outline

After creation begins, the agent proposes a central argument, structure, and time budget. Review the outline (制作草案), request changes in the conversation, and confirm when ready. Resolve missing or unreadable source material before proceeding.

### 3. Review scenes and narration

Review each scene's narration, visual intent, and steps. Correct facts and wording before confirming. The full narration is assembled from the approved scene narration; reviewing only the original input script is insufficient.

### 4. Inspect keyframes and output settings

Generate static keyframes and inspect text, composition, assets, whiteboard content, and visual steps. Choose **16:9 landscape / 9:16 portrait** and **720p / 1080p**. If the format changes, wait for updated previews and review them again.

Read quality findings and approve the current project state. Reviewing one scene does not necessarily approve the full video. If production requests confirmation, return to the relevant review action. Changes to narration, visuals, style, or output settings may invalidate affected approvals and require another review.

### 5. Produce, preview, and export

Continue with voiceover and scene rendering. Wait for assembly, play the result, and check audio, pacing, subtitles, and the ending before exporting.

The current default output is **H.264/AAC MP4 at 24 fps**. Export **SRT/VTT** subtitles separately as needed; separate subtitles are not automatically burned into the picture. Bundled x265 capability does not add an H.265 export control to the current interface.

## Revise an existing video

- **Natural-language changes**: request a change to a scene in the workspace, review updated content/keyframes, then produce the revision. Valid unchanged outputs are reused.
- **Element editing** (元素编辑): select a generated code scene and edit supported text, images, SVG, position, size, color, layers, visibility timing, and 2D animation. Save and review affected visuals again.
- **Timeline editing** (时间线剪辑): trim, split, and reorder video/image clips; add music, sound effects, text/image overlays; adjust volume and fades. Music can duck under narration.
- **Check the actual edit**: save the edit and generate an edit preview (预览剪辑) before producing the final cut (生成成片). The source-clip player does not show all overlays and mixing effects in real time.

Element editing covers supported 2D nodes, not every arbitrary third-party component or internal Canvas/WebGL object. The whole-video editor currently uses a sequential video track, timed overlays, and multiple audio tracks. It does not include every professional editor feature, such as cross-dissolves, color grading, waveform editing, or freely overlapping video tracks. Imported video is not automatically transcribed into subtitles.

## Downloads, offline use, and recovery

The default renderer uses bundled Electron, so a separate Chrome download is unnecessary. If needed for compatibility, switch the video renderer to Chrome under engine/connection settings and prepare its runtime component. Regenerate and review previews after switching.

Windows includes FFmpeg/ffprobe. Virgil, Long Cang, and UI fonts work offline. The other five whiteboard fonts download and verify on first use. A failed download preserves the project and reports the error; retry when connectivity returns. Missing optional fonts must be downloaded before offline use. Bundled default fonts do not mean every style resource has already been cached.

Runtime-component settings support offline mode and importing an offline cache. This controls component acquisition only; it does not make online models or cloud speech work offline. Samples, fonts, and components have separate caches. Offline mode cannot replace missing downloads. If GitHub or an upstream host is unavailable, use completed caches or the runtime-component offline import feature.

After cancellation or interruption, reopen the local project and resume from the saved stage. Valid completed outputs are retained. Inspect the failing stage and diagnostics before starting over or deleting the project. Keep enough free disk space for project, audio, and video caches.

## Troubleshooting

| Symptom | Action |
| --- | --- |
| No creation engine after installation | Install/authenticate a local CLI, configure a model, restart Seqvio, and check the connection |
| Connection check passes but a task fails | Check provider errors, account/model access, network, and quota; startup success is not inference success |
| Production asks for approval | Return to the current outline, scene, or keyframe review and approve the current version |
| Sample/font download fails | Restore connectivity and retry; completed verified caches can be reused offline |
| Voiceover fails or is silent | Check the method, voice, service URL/region, and credentials; try Windows system speech to verify the local pipeline |
| GPU is not selected | Hardware may be unavailable, unsupported for the job, or slower than CPU; automatic CPU use is expected in these cases |
| First export is slow | Initial compilation, speech, asset preparation, and GPU probes add overhead; later work can reuse valid caches |
| Edit preview lacks overlays/mixing | Save and generate an edit preview instead of viewing only the source clip |
| Downloaded a Source code ZIP | Return to release Assets and download the installer ending in Setup.exe |

## Backups, licenses, and feedback

Projects and outputs live on your computer. Back up the project directory and related assets. An exported plan or subtitle file does not replace a full project backup. Avoid deleting internal scene/cache files to resolve an unidentified error.

Open **Settings → About & diagnostics → Third-party licenses and source** (第三方许可与源码) for bundled notices. FFmpeg/ffprobe corresponding source and build records are in the [source v2 release](https://github.com/makesynt/seqvio-studio/releases/tag/ffmpeg-seqvio-source-v2).

For [Issues](https://github.com/makesynt/seqvio-studio/issues), include the app version, Windows version, engine/model, failing stage, exact error, and minimal reproduction steps. Remove API keys, tokens, and private material from screenshots, logs, or project excerpts before posting.
