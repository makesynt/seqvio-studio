<h1 align="center">Seqvio Studio</h1>

<p align="center"><strong>Make long-form video creation simpler.</strong></p>

<p align="center"><a href="https://github.com/makesynt/seqvio-studio/releases"><strong>Download</strong></a> · <a href="docs/USAGE.en.md">User guide</a> · <a href="docs/STYLE-PACKS.md">Style packs & customization</a> · <a href="README.md">简体中文</a></p>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/images/readme/hero-dark.png">
  <img src="docs/images/readme/hero-light.png" alt="Seqvio Studio — six selected styles: stickman, Bauhaus, flat explainers, blackboard, retro pixels and animated cinema" width="1200">
</picture>

Seqvio Studio is an AI-assisted desktop workspace for video creation, with 41 built-in visual styles. Connect OpenCode, Codex, or Antigravity to create scenes and animation, review keyframes, then generate narration and render locally.

## Keep control from first idea to final video

<picture>
  <source media="(max-width: 600px) and (prefers-color-scheme: dark)" srcset="docs/images/readme/workflow-en-dark-mobile.png">
  <source media="(max-width: 600px)" srcset="docs/images/readme/workflow-en-light-mobile.png">
  <source media="(prefers-color-scheme: dark)" srcset="docs/images/readme/workflow-en-dark.png">
  <img src="docs/images/readme/workflow-en-light.png" alt="Creative workflow: material and style → agent creation → your review and approval → local production and export; review changes and reuse valid outputs." width="1440">
</picture>

Describe revisions in the project conversation, review the affected scenes, then regenerate. Interrupted production can resume from saved progress. [User guide](docs/USAGE.en.md)

## Featured styles

Six styles in one compilation, with original audio.

https://github.com/user-attachments/assets/3c18f0a6-96c7-45c5-8655-aabd8625d4b1

<table>
<tr>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/motion-stickman-d1d73606e2309436.mp4"><img src="docs/images/styles/motion-stickman.webp" alt="Stickman animation" width="432"></a><br><strong>Stickman animation</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/motion-stickman-d1d73606e2309436.mp4">Full sample</a></td>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/bauhaus-041e1caad83c2189.mp4"><img src="docs/images/styles/bauhaus.webp" alt="Bauhaus geometry" width="432"></a><br><strong>Bauhaus geometry</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/bauhaus-041e1caad83c2189.mp4">Full sample</a></td>
</tr>
<tr>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/kurzgesagt-flat-09edc2b324906276.mp4"><img src="docs/images/styles/kurzgesagt-flat.webp" alt="Flat explainers" width="432"></a><br><strong>Flat explainers</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/kurzgesagt-flat-09edc2b324906276.mp4">Full sample</a></td>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/blackboard-aec096e78f7d2298.mp4"><img src="docs/images/styles/blackboard.webp" alt="Hand-drawn blackboard" width="432"></a><br><strong>Hand-drawn blackboard</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/blackboard-aec096e78f7d2298.mp4">Full sample</a></td>
</tr>
<tr>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/pixel-1f26cb412eb9dc1f.mp4"><img src="docs/images/styles/pixel.webp" alt="Retro pixel art" width="432"></a><br><strong>Retro pixel art</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/pixel-1f26cb412eb9dc1f.mp4">Full sample</a></td>
<td align="center"><a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/cinematic-light-38aa59501dc45dd9.mp4"><img src="docs/images/styles/cinematic-light.webp" alt="Animated cinema" width="432"></a><br><strong>Animated cinema</strong> · <a href="https://github.com/makesynt/seqvio-studio/releases/download/style-samples-v1/cinematic-light-38aa59501dc45dd9.mp4">Full sample</a></td>
</tr>
</table>

[Browse all samples](https://github.com/makesynt/seqvio-studio/releases/tag/style-samples-v1) · [Download style packs](docs/STYLE-PACKS.md) · [Sample and music credits](docs/SHOWCASE-CREDITS.md)

<details>
<summary>See the actual app: style library</summary>

![The actual Seqvio Studio style library, shown in Chinese](docs/images/style-library.png)

</details>

## Download and install

A **Windows x64 preview** is available. macOS and Linux installers are not yet published.

1. Open [Releases](https://github.com/makesynt/seqvio-studio/releases) and select a **Seqvio Studio application release**. Download the installer and `SHA256SUMS.txt` from Assets, verify, then install. The auto-generated Source code archives are not installers.
2. Install and sign in to a supported agent CLI (OpenCode, Codex, or Antigravity), with working model access and quota.
3. Launch the app, configure the agent, create a project, and choose a style. Follow the prompts to create and review your video. [Full walkthrough](docs/USAGE.en.md)

<details>
<summary>Verify the installer</summary>

Run in the download directory and compare the result with `SHA256SUMS.txt` from the same release:

```powershell
Get-FileHash -Algorithm SHA256 .\Seqvio-Studio-*-Setup.exe
```

Unsigned builds may trigger Windows security prompts. Check the release notes for signing status.

</details>

The installer includes the rendering runtime, FFmpeg/ffprobe, built-in styles, and default fonts. Full samples, extra fonts, and optional Chrome are downloaded as needed and cached for offline reuse. Agent models and online speech require separate setup and usually need a network connection.

## Style pack downloads and customization

Built-in styles are ready to use. To customize them:

1. Download an individual pack or collection from the [style-pack release](https://github.com/makesynt/seqvio-studio/releases/tag/style-packs-v1). Extract collections first to get the individual pack ZIPs.
2. Extract a pack and edit its rules, palette, typography, motion, or assets. You can also follow the format to build your own pack.
3. Set the ID and version as described in the [style-pack guide](docs/STYLE-PACKS.md), repackage, and import through Style library → My styles → Import style package (风格库 → 我的风格 → 导入风格包).

## Data and privacy

Projects and outputs stay on your device. References, prompts, and review images may be sent to your selected model; online speech sends narration to its provider. Back up project directories and their assets together.

## Licenses and feedback

FFmpeg/ffprobe are bundled under GPL-3.0-or-later. Find their licenses and corresponding source links under Settings → About & diagnostics → Third-party licenses and source (第三方许可与源码), and in the application release notes. Other components follow their bundled licenses.

Report problems in [Issues](https://github.com/makesynt/seqvio-studio/issues) with the app version, OS, and reproduction steps. Remove credentials and private material.

## References and acknowledgements

Seqvio Studio builds on [Seqvio](https://github.com/makesynt/seqvio), maintained by the same author, for scene composition, timing, quality checks, and rendering.

Parts of the art-style and animation implementation draw inspiration from the design and implementation of [huashu-art-motion](https://github.com/alchaincyf/huashu-art-motion) by alchaincyf (花叔·花生). Thanks to the author for sharing their work as open source.

<details>
<summary>More open-source projects and their roles</summary>

| Project | Role |
| --- | --- |
| [Electron](https://github.com/electron/electron) / [Chromium](https://www.chromium.org/) | Desktop runtime and browser rendering foundation. |
| [React](https://github.com/react/react) / [Three.js](https://github.com/mrdoob/three.js) | Authored scene components and local 3D visuals. |
| [Rough.js](https://github.com/rough-stuff/rough) | Sketch-style strokes and whiteboard drawing. |
| [Excalidraw](https://github.com/excalidraw/excalidraw) | Whiteboard visual references and the Virgil font. |
| [FFmpeg](https://ffmpeg.org/) | Media probing, audio/video codecs, mixing, and assembly. |
| [Puppeteer](https://github.com/puppeteer/puppeteer) / [esbuild](https://github.com/evanw/esbuild) | Browser automation and scene compilation/bundling. |
| [Shiki](https://github.com/shikijs/shiki) / [Dagre](https://github.com/dagrejs/dagre) | Syntax highlighting and graph layout. |
| [Acorn](https://github.com/acornjs/acorn) / [Ajv](https://github.com/ajv-validator/ajv) / [yauzl](https://github.com/thejoshwolfe/yauzl) | Syntax parsing, data validation, and ZIP reading. |
| [OpenCode](https://github.com/anomalyco/opencode) / [Codex CLI](https://github.com/openai/codex) | Optional local creation-agent integrations; install and configure them separately. |
| [Inter](https://github.com/rsms/inter) / [Noto fonts](https://github.com/notofonts) | UI and multilingual typography. |

</details>

Fonts, assets, and third-party components retain their own licenses. These acknowledgements do not replace the notices distributed with each release.
