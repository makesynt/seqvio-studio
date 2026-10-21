<img src="docs/images/seqvio-mark.svg" width="64" alt="Seqvio Studio 标识">

# Seqvio Studio

**长视频创作，化繁为简。**

简体中文 · [English](README.en.md)

[下载安装](https://github.com/makesynt/seqvio-studio/releases/tag/v0.1.0) · [完整使用指南](docs/USAGE.zh-CN.md) · [风格包下载](docs/STYLE-PACKS.md) · [风格样片](https://github.com/makesynt/seqvio-studio/releases/tag/style-samples-v1)

Seqvio Studio 是一款本地桌面视频创作工作台。输入主题、资料或完整稿件，连接你自己的 OpenCode、Codex 或 Antigravity，逐步完成内容规划、分镜与旁白、画面编写、关键帧审阅、配音和视频导出。

Agent 按所选风格编写画面和动画，Seqvio 引擎负责场景编译、配音时间映射、质检与渲染。你可以在关键阶段确认内容，制作后继续修改单个场景，并复用仍然有效的产物。

![Seqvio Studio 风格库实际界面](docs/images/style-library.png)

## 主要功能

- **从资料到视频**：用主题、粘贴的稿件、链接或本地资料开始，先确认制作草案，再审阅分镜与旁白。
- **41 套内置风格**：技术图解、手绘白板、手绘笔记、黑板、扁平科普、动态文字、拼贴等；支持导入和导出风格 Skill 包，也可从完成的视频提炼个人风格。
- **代码驱动的画面与动画**：组合文字、图片、DOM、SVG、Canvas 和 Three.js，支持本地三维画面，不依赖生成式视频模型完成逐帧渲染。
- **配音与字幕**：Windows 系统语音可本地使用；可配置 MiniMax、自托管 CosyVoice 等语音服务，也可不配音。导出 MP4 和独立 SRT/VTT 字幕。
- **可审阅、可恢复的制作流程**：生成关键帧、检查画面，再确认制作；取消或中断后保留检查点，修改时增量制作。
- **元素与时间线编辑**：调整受支持的文字、图片、SVG、二维图层和动画；剪辑工作台提供裁剪、分割、重排、配乐、音效、文字及图片覆盖图层。
- **本地渲染与自适应 GPU**：默认复用 Electron 的 Chromium；适合时选择更快的可用 GPU 编解码路径，失败回退 CPU。可切换到 Chrome 兼容后端。

## 下载与安装

当前公开版本为 **0.1.0 Windows x64 未签名测试版**。macOS 安装包尚未发布；Windows 的验证结果不代表 macOS 已验证。

1. 打开 [v0.1.0 Releases](https://github.com/makesynt/seqvio-studio/releases/tag/v0.1.0)。
2. 在 **Assets** 下载 [`Seqvio-Studio-0.1.0-win-x64-Setup.exe`](https://github.com/makesynt/seqvio-studio/releases/download/v0.1.0/Seqvio-Studio-0.1.0-win-x64-Setup.exe)，约 **188.8 MB**。
3. 同时下载 [`SHA256SUMS.txt`](https://github.com/makesynt/seqvio-studio/releases/download/v0.1.0/SHA256SUMS.txt)，核对文件后运行安装程序，选择安装目录。
4. 从桌面或开始菜单启动 **Seqvio Studio**，按下方步骤配置创作引擎。

PowerShell 校验命令：

```powershell
Get-FileHash -Algorithm SHA256 .\Seqvio-Studio-0.1.0-win-x64-Setup.exe
```

此版本安装包的 SHA-256：

```text
9f4b58131b5f5f1f597f531e7f3357a0eb2df0134fa8d5caa00cd95181809d2d
```

测试版没有代码签名，Windows 可能显示未知发布者或 SmartScreen 提示，部分设备的安全策略会阻止运行。只在确认来源和校验值后，使用系统允许的方式继续安装。详见[安装与常见问题](docs/USAGE.zh-CN.md#安装与首次启动)。

GitHub 自动生成的 **Source code (zip/tar.gz)** 是本分发仓库的快照，不是安装包。本仓库提供产品文档、安装版本、样片和第三方构建资料；不包含完整桌面应用的开发工程，不能通过克隆本仓库再执行 `npm install` 来启动应用。

## 安装包包含什么

| 项目 | 提供方式 |
| --- | --- |
| 桌面应用、Electron 与默认 Chromium 渲染后端 | 随安装包提供 |
| FFmpeg 8.1.3 source v2 与 ffprobe | 随 Windows 安装包提供，可离线使用 |
| 41 套风格、封面与静音短循环预览 | 随安装包提供 |
| 界面字体 Inter、Noto Sans SC；默认白板字体 Virgil、Long Cang | 随安装包提供，可离线使用 |
| 完整风格样片 | 首次预览时从本仓库 GitHub Releases 下载，校验并缓存 |
| 小赖、悠哉、霞鹜文楷轻便版、刘建毛草、志莽行 | 首次使用时下载并缓存 |
| 可选 Chrome 兼容渲染后端 | 使用时按需准备，默认渲染无需单独安装 Chrome |
| OpenCode / Codex / Antigravity CLI、模型账号与额度 | 用户自行安装并配置，任选一个可用引擎 |
| 云端配音或自托管 CosyVoice | 用户自行准备服务及凭据；Windows 系统配音无需云服务 |

随包媒体工具包含 x265、Windows GPU 编解码及多种音频库。**当前导出界面仍以 H.264/AAC MP4 为默认输出**，包含 x265 不代表增加了 H.265 导出选项。GPU 是否启用取决于设备、驱动及实际速度，首次探测有额外开销。

### 下载与导入风格包

[41 套风格包目录与说明](docs/STYLE-PACKS.md)提供单包及[全量合集下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/seqvio-style-packs-v1-all.zip)（约 13.9 MB）。合集先解压，再逐个导入其中的风格 ZIP；单包可在“自定义 → 导入风格包”直接选择。安装版已内置这些风格，通常无需重复导入。下载包使用 `custom-` ID 的个人副本，不覆盖内置风格；更多版本与冲突处理见目录说明。

## 第一次制作视频

1. **配置引擎**：先在本机安装并登录一个受支持的 CLI；打开 **设置 → 引擎与连接**，选择引擎和可用模型，执行“检测连接”。检测成功仅表示 CLI 可启动，还需确保模型可访问且有额度。
2. **给出创作说明**：在首页输入主题、受众、目标时长和重点，添加需要的资料，选择视觉风格并开始创作。
3. **确认制作草案**：检查核心观点、章节结构和时长预算，可通过会话修改后再确认。
4. **审阅分镜与旁白**：逐镜检查旁白、画面意图和步骤；在“风格与配音”中选择声音或无配音。
5. **审阅关键帧**：生成静态画面，选择横屏/竖屏、720p/1080p，检查更新后的预览及质检提醒，并完成整体确认。
6. **制作与导出**：生成配音和场景视频，预览合成结果，再导出 MP4 与所需字幕文件。
7. **继续修改**：在创作台修改单镜，或使用“元素编辑”“时间线剪辑”；重新检查受影响画面，制作更新版本。

第一次可用 30–60 秒的小项目熟悉流程。完整操作、示例创作说明、配音设置、缓存和恢复见[中文使用指南](docs/USAGE.zh-CN.md)。

## 离线使用与数据

下载完成的样片和可选字体可从缓存离线使用；随包字体、媒体工具以及已有素材的本地渲染无需联网。样片下载支持校验、断点续传和重试，可在预览中清理单个样片，或在 **设置 → 存储** 清理样片缓存。

本地渲染不等于模型离线：AI 创作使用所选 CLI 配置的模型服务；云端配音也需要网络。创作资料、提示词、风格参考图及审图关键帧可能作为任务输入交给所选模型；旁白会交给所选在线配音服务。请按自己的数据和费用要求选择服务。项目与制作产物保存在本机，备份时应同时保留项目文件及相关素材。

## 许可、源码与反馈

安装后的 **设置 → 关于与诊断 → 第三方许可与源码** 提供本地许可及源码入口。FFmpeg/ffprobe 以独立工具随包分发，许可为 GPL-3.0-or-later；完整对应源码、依赖、构建脚本和记录见 [FFmpeg source v2 Release](https://github.com/makesynt/seqvio-studio/releases/tag/ffmpeg-seqvio-source-v2)。其他第三方组件遵循各自许可证。

反馈问题请使用 [Issues](https://github.com/makesynt/seqvio-studio/issues)，附应用版本、操作系统、所选引擎和复现步骤；提交前移除密钥和私人资料。当前安装版已验证安装/卸载、本地配音、双后端渲染和导出；NVIDIA、AMD 与 macOS 尚未完成实机验证。测试版仍在持续完善。
