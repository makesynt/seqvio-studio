#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
BUILD="$ROOT/build"
SOURCES="$ROOT/sources"
WORK="$ROOT/work"
PREFIX="$WORK/prefix"
ARTIFACTS="$ROOT/artifacts"
mkdir -p "$PREFIX" "$ARTIFACTS" "$WORK"
exec > >(tee "$WORK/build.log") 2>&1
python3 "$BUILD/fetch-sources.py" "$SOURCES"
python3 - "$BUILD/versions.lock.json" "$SOURCES" "$WORK" <<'PY'
import json,pathlib,sys,tarfile
lock=json.loads(pathlib.Path(sys.argv[1]).read_text())
for spec in lock['sources']:
    dest=pathlib.Path(sys.argv[3])/spec['name'];dest.mkdir(exist_ok=True)
    with tarfile.open(pathlib.Path(sys.argv[2])/spec['archive']) as archive:
        archive.extractall(dest,filter='data')
    roots=list(dest.iterdir())
    if len(roots)!=1 or not roots[0].is_dir(): raise SystemExit('Unexpected source root: '+spec['name'])
    (pathlib.Path(sys.argv[3])/(spec['name']+'.path')).write_text(str(roots[0]))
PY
export CC=x86_64-w64-mingw32-gcc-posix CXX=x86_64-w64-mingw32-g++-posix
export AR=x86_64-w64-mingw32-ar RANLIB=x86_64-w64-mingw32-ranlib
export STRIP=x86_64-w64-mingw32-strip RC=x86_64-w64-mingw32-windres
export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig" PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export LIBS="-lstdc++ -lwinpthread"
export CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-static -static-libgcc -static-libstdc++"
JOBS=$(nproc)
cd "$(cat "$WORK/zlib.path")"
CHOST=x86_64-w64-mingw32 ./configure --static --prefix="$PREFIX"
make -j"$JOBS"; make install
cd "$(cat "$WORK/dav1d.path")"
meson setup out --wrap-mode=nodownload --cross-file "$BUILD/cross.ini" --prefix "$PREFIX" --libdir lib --buildtype release -Denable_tools=false -Denable_tests=false
ninja -C out -j"$JOBS"; ninja -C out install
cd "$(cat "$WORK/x264.path")"
./configure --host=x86_64-w64-mingw32 --cross-prefix=x86_64-w64-mingw32- --prefix="$PREFIX" --enable-static --disable-cli --disable-opencl --enable-win32thread
make -j"$JOBS"; make install
cd "$(cat "$WORK/freetype.path")"
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --with-zlib=yes --with-bzip2=no --with-png=no --with-harfbuzz=no --with-brotli=no
make -j"$JOBS"; make install
cd "$(cat "$WORK/harfbuzz.path")"
meson setup out --wrap-mode=nodownload --cross-file "$BUILD/cross.ini" --prefix "$PREFIX" --libdir lib --buildtype release -Dtests=disabled -Ddocs=disabled -Dutilities=disabled -Dglib=disabled -Dgobject=disabled -Dcairo=disabled -Dicu=disabled -Dgraphite2=disabled -Dfreetype=enabled
ninja -C out -j"$JOBS"; ninja -C out install
cd "$(cat "$WORK/fribidi.path")"
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --disable-docs
make -j"$JOBS"; make install
cd "$(cat "$WORK/libass.path")"
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --disable-fontconfig --disable-require-system-font-provider
make -j"$JOBS"; make install
cd "$(cat "$WORK/lame.path")"
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --disable-frontend --disable-analyzer-hooks --disable-decoder
make -j"$JOBS"; make install
cd "$(cat "$WORK/ffmpeg.path")"
./configure --prefix="$PREFIX" --target-os=mingw32 --arch=x86_64 --enable-cross-compile --cross-prefix=x86_64-w64-mingw32- --cc="$CC" --cxx="$CXX" --pkg-config=pkg-config --pkg-config-flags=--static --enable-gpl --enable-version3 --enable-static --disable-shared --disable-autodetect --disable-debug --disable-doc --disable-ffplay --enable-schannel --enable-zlib --enable-libx264 --enable-libdav1d --enable-libfreetype --enable-libharfbuzz --enable-libfribidi --enable-libass --enable-libmp3lame --extra-version=seqvio-source-v1 --extra-cflags="-I$PREFIX/include" --extra-ldflags="-L$PREFIX/lib -static -static-libgcc -static-libstdc++" --extra-libs="-lstdc++ -lwinpthread -lws2_32"
make -j"$JOBS"
cp ffmpeg.exe ffprobe.exe "$ARTIFACTS/"
cp config.h config_components.h ffbuild/config.mak "$ARTIFACTS/"
cp "$WORK/build.log" "$ARTIFACTS/build.log"
dpkg-query -W gcc-mingw-w64-x86-64-posix g++-mingw-w64-x86-64-posix mingw-w64-x86-64-dev binutils-mingw-w64-x86-64 meson ninja-build nasm python3 > "$ARTIFACTS/toolchain-packages.txt"
python3 "$BUILD/package.py"
