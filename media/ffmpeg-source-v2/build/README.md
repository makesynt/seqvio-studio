# Seqvio FFmpeg source build v2

Windows x64 FFmpeg 8.1.3, x264, x265 multilib, dav1d, NVIDIA NVENC/NVDEC, Intel VPL/QSV, AMD AMF and Windows D3D11VA/DXVA2, plus restored Opus, Vorbis/Ogg, Speex, GSM, AMR-NB/WB, GME, OpenMPT and Rubber Band.

The lock includes 23 application/dependency source inputs. AMF is an unchanged public-header and license subset reproducibly extracted from the pinned upstream SDK archive; unused SDK sample binaries are excluded. Other source archives are unmodified. Build scripts, source pins, generated configuration, licenses and hashes are included with the corresponding source archive. GPU runtime drivers are supplied by the operating-system/vendor driver installation; built-in support does not prove a usable hardware device. Application runtime probes and CPU fallback remain required.

Install the Ubuntu 24.04 packages in workflow.yml, fetch/verify sources, then run build.sh. After fetching, compilation runs in a network-disabled namespace. No nonfree FFmpeg flag, CUDA toolkit or vendor GPU runtime binary is redistributed.
