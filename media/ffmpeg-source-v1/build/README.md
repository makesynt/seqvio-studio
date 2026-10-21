# Seqvio verified Windows FFmpeg source build

Builds FFmpeg 8.1.3 from fixed source archives with x264, zlib, FreeType, HarfBuzz, FriBidi, libass LAME and dav1d. All nine input archives are pinned by SHA-256 in versions.lock.json.

The build runs on Ubuntu 24.04 using MinGW-w64 and produces independent Windows x64 ffmpeg.exe / ffprobe.exe tools. Windows SChannel supplies HTTPS; H.264/AAC, PNG frames, audio manipulation, drawtext and subtitle filters are retained. Unused third-party hardware and codec libraries from the previous Gyan build are not part of this build.

Run bash build/build.sh. Put the eight archives under sources/ for an application-source-offline rebuild; fetch-sources.py verifies them and only downloads missing files. Compiler/build tools are platform prerequisites documented in workflow.yml. No local source patches are applied.

The build exports matching source and binary hashes, original licenses, configure output, toolchain package versions and build logs. The corresponding-source archive includes the exact input archives and build scripts. General-purpose compiler/build tools and Windows system libraries are outside the archive.

The workflow verifies all source archives before compiling inside a network namespace with networking disabled. It proves that the declared application/library source closure is sufficient for this build. AV1 software decoding is retained through dav1d.
