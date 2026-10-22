# 风格包下载与自定义 / Style pack downloads and customization

[中文首页](../README.md) · [English home](../README.en.md) · [Release](https://github.com/makesynt/seqvio-studio/releases/tag/style-packs-v1)

[下载全部 41 套 / Download all 41 packs](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/seqvio-style-packs-v1-all.zip)（13.9 MB） · [SHA-256](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/SHA256SUMS.txt) · [Manifest](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/manifest.json)

## 中文

这些包是 Seqvio Studio 0.1.0 随包 41 套风格的可导入个人副本。安装版已内置原风格，通常无需重复导入；本发布用于备份、分享和外部修改后重新导入。

1. 下载下表中的单个 ZIP；或下载合集并先解压。
2. 打开“风格库 → 我的风格 → 导入风格包”，选择一个风格 ZIP；使用合集时，先解压并取出所需的单包 ZIP。
3. 导入后在“我的风格”中预览和使用。风格视频样片仍由 [style-samples-v1](https://github.com/makesynt/seqvio-studio/releases/tag/style-samples-v1) 单独提供。
4. 包使用应用正式导出规则：保留风格内容，ID 改为 `custom-...`、版本为 `1`，避免覆盖内置 `builtin-...`。下表的“来源版本”是原内置包版本，不是导入副本版本。
5. 相同包重复导入会复用已有版本。同 ID/版本但内容不同会拒绝导入；若已修改同名个人包，请先备份，在包外增加版本或更换 ID，保留自己的修改。

包含 SKILL.md、配置、规则、抽象范例、声明的参考资料及图片/字体、原有许可。参考源码作为文档，不作为插件执行；部分参考素材仅含视觉小样或依赖说明，不是完整样片原工程。导入包不会安装模型、语音服务或新渲染器，不保证自动复现样片。资源使用遵循包内原有说明和许可证。

## English

These are importable personal copies of the 41 styles bundled with Seqvio Studio 0.1.0. Existing installations already have the originals; importing again is optional. This release supports backup, sharing, and editing packages outside the app before reimporting.

1. Download an individual ZIP below, or download and extract the collection.
2. Open Style library → My styles → Import style package (风格库 → 我的风格 → 导入风格包) and select one style ZIP. For a collection, extract it first and choose an individual pack ZIP.
3. Find the copy under My styles (我的风格). Full sample videos remain separate in [style-samples-v1](https://github.com/makesynt/seqvio-studio/releases/tag/style-samples-v1).
4. Packs follow the app export action: preserve style content, use `custom-...` IDs and version `1`, and leave reserved built-ins untouched. Source version below refers to the original built-in package.
5. Identical imports reuse an existing version. Different content with the same ID/version is rejected. Back up modified personal styles, then increase the version or choose another ID outside the app rather than replacing your work.

Each pack preserves SKILL.md, configuration, rules, abstract examples, declared references/images/fonts, and existing notices. Reference source is documentation, not an executable plugin. Some references contain only thumbnails or dependency notes, not complete sample-production projects. Packs do not install models, speech services, or a renderer, and do not guarantee an exact showcase reproduction. Follow the original asset/license notices.

## 在现有包基础上自定义

1. 下载并解压一个风格 ZIP；也可先解压全量合集，再解压其中选中的单包。
2. 修改 `SKILL.md` 中的制作方法、`rules.json` 的规则和可选的 `examples.json`；在 `style.json` 中调整现有能力支持的配色、排版、布局与动效。需要图片或字体时，将文件放入 `assets/` 并声明。
3. 设置自己的 `id` 和 `name`，同步更新 `profile.id` 与 `profile.label`，以及 SKILL frontmatter 的 name/description。不要使用保留的 `builtin-` 前缀。
4. 保留已有 ID 时，每次修改包内容都增加整数 `version`。相同 ID/版本只有内容完全一致才会复用，否则应用拒绝导入。
5. 将单个风格目录的内容压缩为 ZIP（根目录直接含 style.json，或只有一个外层包目录），通过“风格库 → 我的风格 → 导入风格包”导入并用短项目验证。保留资源的原有许可与版权说明。

## 参考格式制作自己的风格包

可以从空目录自建，也可下载本页“技术图解”作为完整、可导入的字段参考；无需先创建视频。目录结构如下：

```text
my-style/
  SKILL.md
  style.json
  rules.json
  examples.json              # 可选 / optional
  references/design.md       # 可选，声明后随包提供
  assets/image.webp          # 可选，声明后随包提供
  assets/font.woff2          # 可选，声明后随包提供
  LICENSE.txt                # 按所含内容需要保留 / as applicable
```

| 文件 / File | 格式要点 / Format requirements |
| --- | --- |
| SKILL.md | YAML frontmatter 含合法的小写连字符 name 和非空 description；正文写通用制作方法。 / Valid lowercase hyphenated name and nonempty description in YAML frontmatter; reusable authoring guidance in the body. |
| style.json | `format: seqvio-style-skill`、`schemaVersion: 1`，合法 id、正整数 version、name，以及完整的 profile、visual 等配置。rulesFile 必须指向实际规则文件。 / Declare the format/schema, ID, positive integer version, name, complete profile/visual configuration, and a rulesFile pointing to the actual rules file. |
| rules.json | 规则数组，每项含 id、scope、text；scope 使用 all、whiteboard、diagram、code 或 three。 / Array of rules with id, scope, and text; use a supported scope. |
| examples.json | 可选的抽象范例数组；使用 kind、description，不放整片旁白或项目私人资料。通过 examplesFile 声明。 / Optional abstract examples using kind/description, declared with examplesFile. |
| references/ | 参考文档以 Markdown 提供，并在 references 中声明；较长参考可使用 load: on-demand。 / Declare Markdown references; use load: on-demand for longer reference material. |
| assets/ | 图片/字体需在 assets 中声明唯一 id、kind、相对 path；字体还须声明 family。 / Declare each image/font with a unique id, kind, and relative path; fonts also require family. |

导入包最多 24 MiB、160 个文件；路径必须相对包目录，不接受目录穿越、符号链接或可执行脚本。修改应使用当前应用支持的风格与渲染字段；包不是安装新插件的方式。修改与导入的更完整操作见[中文使用指南](USAGE.zh-CN.md)。

## Customize an existing pack

Extract one style ZIP. Edit the authoring guidance in SKILL.md, rules, optional abstract examples, and supported palette/typography/layout/motion settings in style.json. Add declared assets and retain their notices. Choose your own ID/name, update profile.id/profile.label and SKILL frontmatter, or increase the integer version if retaining an existing ID. Never use the reserved builtin- prefix. ZIP only that package and import it through Style library → My styles → Import style package, then check it with a short project. Identical reimports reuse a version; conflicting content with the same ID/version is rejected.

## Create your own package from the format

Start with an empty directory using the structure/table above, or use the Technical diagram pack as a complete importable example of the configuration fields. Include SKILL.md, style.json, and the declared rules file; add examples, references, and assets only as needed and declare them correctly. A partial style.json with missing profile/visual fields is not a working package. No completed video is required to create a package outside the app.

Limits are 24 MiB and 160 files per pack. Paths must be relative; traversal, symbolic links, and executable scripts are rejected. Use fields/capabilities supported by the app: style packs do not install renderer plugins. See the [English user guide](USAGE.en.md) for the workflow.

## 单包下载 / Individual downloads

所有导入副本版本均为 1 / All importable copies are version 1.

| 名称 / Name | ID | 来源版本 / Source version | ZIP |
| --- | --- | ---: | --- |
| 包豪斯构成 | `custom-bauhaus` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-bauhaus-v1.zip) · 89.3 KiB |
| 手绘黑板 | `custom-blackboard` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-blackboard-v1.zip) · 33.7 KiB |
| 蓝色时期 | `custom-blue-period` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-blue-period-v1.zip) · 152.2 KiB |
| 动画电影光影 | `custom-cinematic-light` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-cinematic-light-v1.zip) · 146.3 KiB |
| 手绘白板 | `custom-clean-board` | 4 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-clean-board-v1.zip) · 35.7 KiB |
| 构成主义海报 | `custom-constructivism` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-constructivism-v1.zip) · 108.2 KiB |
| 立体主义 | `custom-cubism` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-cubism-v1.zip) · 114.5 KiB |
| 超现实流形 | `custom-dali` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-dali-v1.zip) · 291.4 KiB |
| 律动粗线 | `custom-haring` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-haring-v1.zip) · 124.2 KiB |
| 硬边光影 | `custom-hopper` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-hopper-v1.zip) · 209.3 KiB |
| 印象派 | `custom-impressionism` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-impressionism-v1.zip) · 423.8 KiB |
| 动态文字 | `custom-kinetic-type` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-kinetic-type-v1.zip) · 86.7 KiB |
| 银河漫画 | `custom-kirby` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-kirby-v1.zip) · 176.7 KiB |
| Kurzgesagt 扁平 | `custom-kurzgesagt-flat` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-kurzgesagt-flat-v1.zip) · 108.9 KiB |
| 波点空间 | `custom-kusama` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-kusama-v1.zip) · 153.8 KiB |
| 马蒂斯剪纸 | `custom-matisse` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-matisse-v1.zip) · 116.0 KiB |
| 莫奈水面 | `custom-monet` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-monet-v1.zip) · 189.4 KiB |
| 8bit 像素复古街机 | `custom-motion-arcade` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-arcade-v1.zip) · 48.4 KiB |
| 拼贴动画（逐字稿驱动） | `custom-motion-collage` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-collage-v1.zip) · 148.0 KiB |
| 极简赛博动画 | `custom-motion-cyber` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-cyber-v1.zip) · 88.4 KiB |
| 平面插画律动 MV | `custom-motion-dance` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-dance-v1.zip) · 113.0 KiB |
| 16bit 像素情绪回忆 | `custom-motion-memory` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-memory-v1.zip) · 110.7 KiB |
| 孟菲斯风科普视频 | `custom-motion-memphis` | 2 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-memphis-v1.zip) · 210.0 KiB |
| 超现实摄影拼贴 | `custom-motion-photo` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-photo-v1.zip) · 151.5 KiB |
| 海报觉醒 | `custom-motion-poster` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-poster-v1.zip) · 114.9 KiB |
| 火柴人科普与叙事 | `custom-motion-stickman` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-stickman-v1.zip) · 103.4 KiB |
| 超现实波普概念影像 | `custom-motion-surreal-pop` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-surreal-pop-v1.zip) · 113.9 KiB |
| 手绘旅行 VLOG | `custom-motion-travel` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-motion-travel-v1.zip) · 123.8 KiB |
| 表现主义 | `custom-munch` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-munch-v1.zip) · 191.5 KiB |
| 新艺术曲线 | `custom-nouveau` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-nouveau-v1.zip) · 106.9 KiB |
| 8-bit 像素 | `custom-pixel` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-pixel-v1.zip) · 101.0 KiB |
| 波普网点 | `custom-pop` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-pop-v1.zip) · 219.6 KiB |
| 梵高流场 | `custom-postimp` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-postimp-v1.zip) · 415.8 KiB |
| 产品发布 | `custom-product-demo` | 4 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-product-demo-v1.zip) · 7767.6 KiB |
| 复古 CGI | `custom-raytrace` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-raytrace-v1.zip) · 145.1 KiB |
| 明暗聚光 | `custom-rembrandt` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-rembrandt-v1.zip) · 117.2 KiB |
| 复古橡皮管 | `custom-rubberhose` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-rubberhose-v1.zip) · 122.4 KiB |
| 技术推演 | `custom-tech` | 4 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-tech-v1.zip) · 98.6 KiB |
| 蒸汽波霓虹 | `custom-vaporwave` | 3 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-vaporwave-v1.zip) · 135.9 KiB |
| Vox 风格 | `custom-vox` | 4 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-vox-v1.zip) · 242.8 KiB |
| 课堂手绘 | `custom-warm` | 4 | [Download / 下载](https://github.com/makesynt/seqvio-studio/releases/download/style-packs-v1/custom-warm-v1.zip) · 32.6 KiB |

## 校验与兼容 / Verification and compatibility

使用同一 Release 的 SHA256SUMS.txt 校验下载文件。manifest.json 记录名称、ID、来源版本、单包大小、SHA-256 与包内容哈希。GitHub 自动生成的 Source code ZIP/TAR 是分发仓库快照，不能替代上面命名的风格 ZIP。

Use SHA256SUMS.txt from the same release to verify downloads. manifest.json records names, IDs, source versions, sizes, SHA-256, and package hashes. GitHub-generated Source code archives are distribution-repository snapshots, not the named style ZIPs above.

发布验证 / Release validation: 41/41 imports, 41/41 identical reimports, and 41/41 export round trips with the published application loader; reference files and assets preserved. Existing style-package regression: 5/5 passed.
