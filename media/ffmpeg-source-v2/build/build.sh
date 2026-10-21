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
export GIT_CEILING_DIRECTORIES="$WORK"
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

cmake_cross() {
 cmake -G Ninja -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_PROCESSOR=x86_64 -DCMAKE_C_COMPILER="$CC" -DCMAKE_CXX_COMPILER="$CXX" -DCMAKE_RC_COMPILER="$RC" -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_PREFIX_PATH="$PREFIX" -DCMAKE_FIND_ROOT_PATH="$PREFIX" -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF "$@"
}
X265=$(cat "$WORK/x265.path")
for depth in 12 10; do
 cmake_cross -S "$X265/source" -B "$WORK/x265-$depth" -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DENABLE_LIBNUMA=OFF -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DMAIN12=$([ "$depth" = 12 ] && echo ON || echo OFF)
 cmake --build "$WORK/x265-$depth" -j "$JOBS"
done
mkdir -p "$WORK/x265-8"
cp "$WORK/x265-10/libx265.a" "$WORK/x265-8/libx265_main10.a"
cp "$WORK/x265-12/libx265.a" "$WORK/x265-8/libx265_main12.a"
cmake_cross -S "$X265/source" -B "$WORK/x265-8" -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DENABLE_LIBNUMA=OFF -DLINKED_10BIT=ON -DLINKED_12BIT=ON '-DEXTRA_LIB=x265_main10.a;x265_main12.a' -DEXTRA_LINK_FLAGS="-L$WORK/x265-8"
cmake --build "$WORK/x265-8" -j "$JOBS"
cmake --install "$WORK/x265-8"
cd "$WORK/x265-8";mv libx265.a libx265_main.a
"$AR" -M <<EOF
CREATE libx265.a
ADDLIB libx265_main.a
ADDLIB libx265_main10.a
ADDLIB libx265_main12.a
SAVE
END
EOF
cp libx265.a "$PREFIX/lib/libx265.a"
cat > "$PREFIX/lib/pkgconfig/x265.pc" <<EOF
prefix=$PREFIX
libdir=$PREFIX/lib
includedir=$PREFIX/include
Name: x265
Description: H.265/HEVC multilib encoder
Version: 4.1
Libs: -L$PREFIX/lib -lx265
Libs.private: -lstdc++ -lwinpthread
Cflags: -I$PREFIX/include
EOF
cd "$(cat "$WORK/nv-codec-headers.path")";make PREFIX="$PREFIX" install
mkdir -p "$PREFIX/include/AMF";cp -R "$(cat "$WORK/amf.path")/amf/public/include/." "$PREFIX/include/AMF/"
cmake_cross -S "$(cat "$WORK/libvpl.path")" -B "$WORK/libvpl-out" -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF -DINSTALL_EXAMPLES=OFF -DBUILD_EXPERIMENTAL=OFF
cmake --build "$WORK/libvpl-out" -j "$JOBS";cmake --install "$WORK/libvpl-out"
for name in ogg vorbis speex opus opencore-amr vo-amrwbenc; do
 cd "$(cat "$WORK/$name.path")"
 ./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --disable-doc --disable-extra-programs
 make -j"$JOBS";make install
done
cd "$(cat "$WORK/gsm.path")"
make -j"$JOBS" lib/libgsm.a CC="$CC" AR="$AR" RANLIB="$RANLIB" CFLAGS='-c -O2 -DNeedFunctionPrototypes=1 -DWAV49 -I./inc'
mkdir -p "$PREFIX/include/gsm";cp inc/gsm.h "$PREFIX/include/gsm.h";cp inc/gsm.h "$PREFIX/include/gsm/gsm.h";cp lib/libgsm.a "$PREFIX/lib/"
cmake_cross -S "$(cat "$WORK/gme.path")" -B "$WORK/gme-out" -DGME_BUILD_SHARED=OFF -DGME_BUILD_STATIC=ON -DGME_BUILD_TESTING=OFF -DGME_BUILD_EXAMPLES=OFF -DGME_ZLIB=ON
cmake --build "$WORK/gme-out" -j "$JOBS";cmake --install "$WORK/gme-out"
cd "$(cat "$WORK/openmpt.path")"
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --enable-static --disable-shared --disable-openmpt123 --disable-tests --disable-examples --without-mpg123 --without-sndfile --without-portaudio --without-portaudiocpp --without-pulseaudio
make -j"$JOBS";make install
cd "$(cat "$WORK/rubberband.path")"
meson setup out --wrap-mode=nodownload --cross-file "$BUILD/cross.ini" --prefix "$PREFIX" --libdir lib --buildtype release -Dfft=builtin -Dresampler=builtin -Dcmdline=disabled -Dtests=disabled -Djni=disabled -Dladspa=disabled -Dlv2=disabled -Dvamp=disabled
ninja -C out -j"$JOBS";ninja -C out install

cd "$(cat "$WORK/ffmpeg.path")"
./configure --prefix="$PREFIX" --target-os=mingw32 --arch=x86_64 --enable-cross-compile --cross-prefix=x86_64-w64-mingw32- --cc="$CC" --cxx="$CXX" --pkg-config=pkg-config --pkg-config-flags=--static --enable-gpl --enable-version3 --enable-static --disable-shared --disable-autodetect --disable-debug --disable-doc --disable-ffplay --enable-schannel --enable-zlib --enable-libx264 --enable-libx265 --enable-libvpl --enable-amf --disable-filter=amf_capture --enable-ffnvcodec --enable-cuda --enable-cuvid --enable-nvdec --enable-nvenc --enable-d3d11va --enable-dxva2 --enable-libopus --enable-libvorbis --enable-libspeex --enable-libgsm --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvo-amrwbenc --enable-libgme --enable-libopenmpt --enable-librubberband --enable-libdav1d --enable-libfreetype --enable-libharfbuzz --enable-libfribidi --enable-libass --enable-libmp3lame --extra-version=seqvio-source-v2 --extra-cflags="-I$PREFIX/include" --extra-ldflags="-L$PREFIX/lib -static -static-libgcc -static-libstdc++" --extra-libs="-lstdc++ -lwinpthread -lws2_32"
make -j"$JOBS"
cp ffmpeg.exe ffprobe.exe "$ARTIFACTS/"
cp config.h config_components.h ffbuild/config.mak "$ARTIFACTS/"
cp "$WORK/build.log" "$ARTIFACTS/build.log"
dpkg-query -W gcc-mingw-w64-x86-64-posix g++-mingw-w64-x86-64-posix mingw-w64-x86-64-dev binutils-mingw-w64-x86-64 meson ninja-build nasm python3 > "$ARTIFACTS/toolchain-packages.txt"
python3 "$BUILD/package.py"
