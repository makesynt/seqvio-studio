#!/usr/bin/env python3
import gzip,hashlib,json,os,pathlib,re,shutil,subprocess,tarfile
root=pathlib.Path(__file__).resolve().parent.parent
build=root/'build';work=root/'work';out=root/'artifacts'
lock=json.loads((build/'versions.lock.json').read_text())
def sha(data): return hashlib.sha256(data).hexdigest()
source={'schemaVersion':1,'buildId':lock['buildId'],'platform':'win32-x64','ffmpegVersion':lock['ffmpegVersion'],'license':'GPL-3.0-or-later','sources':lock['sources'],'applicationDependenciesComplete':True,'patches':[],'buildRepository':'https://github.com/makesynt/seqvio-studio','buildCommit':os.environ.get('GITHUB_SHA'),'workflowRun':os.environ.get('GITHUB_SERVER_URL','https://github.com')+'/'+os.environ.get('GITHUB_REPOSITORY','makesynt/seqvio-studio')+'/actions/runs/'+os.environ.get('GITHUB_RUN_ID','local'),'toolchainPackages':(out/'toolchain-packages.txt').read_text(),'systemComponents':'Unmodified compiler/build tools and Windows system libraries are not embedded in this source archive. Runtime notices are included below; GCC runtime exceptions and permissive MinGW-w64 runtime terms apply.'}
licenses=[]
files={'ffmpeg':['COPYING.GPLv3','LICENSE.md'],'x264':['COPYING'],'zlib':['LICENSE'],'freetype':['docs/FTL.TXT','docs/GPLv2.TXT','docs/LICENSE.TXT'],'harfbuzz':['COPYING'],'fribidi':['COPYING'],'libass':['COPYING'],'lame':['COPYING']}
for spec in lock['sources']:
    archive=root/'sources'/spec['archive']
    if sha(archive.read_bytes())!=spec['sha256']: raise SystemExit('Source changed '+spec['name'])
    src=pathlib.Path((work/(spec['name']+'.path')).read_text())
    text=[]
    for name in files[spec['name']]:
        file=src/name
        if file.exists():text.append(name+'\n'+file.read_text(errors='replace'))
    if not text: raise SystemExit('Missing license '+spec['name'])
    licenses.append('\n\n===== '+spec['name']+' '+spec['version']+' =====\n'+'\n'.join(text))
for pkg in ['mingw-w64-x86-64-dev','gcc-mingw-w64-x86-64-posix-runtime']:
    file=pathlib.Path('/usr/share/doc')/pkg/'copyright'
    if file.exists():licenses.append('\n\n===== Toolchain runtime: '+pkg+' =====\n'+file.read_text(errors='replace'))
(out/'LICENSE.ffmpeg').write_text('Seqvio distributed FFmpeg and statically linked component notices.\n'+''.join(licenses))
source['binaries']=[]
for name in ['ffmpeg','ffprobe']:
    binary=out/(name+'.exe');data=binary.read_bytes()
    imports=subprocess.check_output(['x86_64-w64-mingw32-objdump','-p',str(binary)],text=True)
    dlls=re.findall(r'DLL Name:\s*(\S+)',imports)
    if any(re.search(r'lib(?:gcc|stdc|winpthread)',dll,re.I) for dll in dlls):raise SystemExit('Unexpected compiler DLL dependency')
    source['binaries'].append({'name':binary.name,'size':len(data),'sha256':sha(data),'imports':dlls})
    with (out/(name+'-win32-x64.gz')).open('wb') as target:
        with gzip.GzipFile(filename='',mode='wb',fileobj=target,mtime=0,compresslevel=9) as compressed:compressed.write(data)
(out/'source-inventory.json').write_text(json.dumps(source,indent=2)+'\n')
readme='FFmpeg '+lock['ffmpegVersion']+' / Seqvio source build v1 (Windows x64)\n\nLicense: GPL-3.0-or-later. Independently executed CLI tools.\nSource and build scripts: https://github.com/makesynt/seqvio-studio/releases/tag/ffmpeg-seqvio-source-v1\nCorresponding application/dependency source archive: ffmpeg-seqvio-source-v1.tar.gz\nBuild commit: '+str(source['buildCommit'])+'\nWorkflow: '+source['workflowRun']+'\n\n'+(out/'toolchain-packages.txt').read_text()+'\nAll source hashes and the complete configure recipe are in source-inventory.json and the source archive. No local source patches were applied.\nWindows system DLLs and unmodified general-purpose compiler/build tools are excluded from the source archive.\n\nBinaries:\n'+json.dumps(source['binaries'],indent=2)+'\n'
(out/'README.ffmpeg').write_text(readme)
package=work/'source-package';package.mkdir(exist_ok=True)
shutil.copytree(build,package/'build',dirs_exist_ok=True)
shutil.copytree(root/'sources',package/'sources',dirs_exist_ok=True)
for name in ['source-inventory.json','toolchain-packages.txt','config.h','config_components.h','config.mak','LICENSE.ffmpeg','README.ffmpeg']:
    shutil.copy2(out/name,package/name)
shutil.copy2(work/'build.log',package/'build.log')
(package/'REBUILD.md').write_text('Install the Ubuntu 24.04 packages in build/workflow.yml, then run bash build/build.sh from this directory. All eight application/library source archives are included and hash-checked; a normal rebuild does not download these sources. The compiler/build tools are system prerequisites. Output binaries need not be bit-for-bit identical under a different toolchain.\n')
with tarfile.open(out/'ffmpeg-seqvio-source-v1.tar.gz','w:gz') as archive:archive.add(package,arcname='ffmpeg-seqvio-source-v1')
assets=[]
for file in sorted(out.iterdir()):
    if file.is_file(): assets.append({'name':file.name,'size':file.stat().st_size,'sha256':sha(file.read_bytes())})
(out/'artifact-inventory.json').write_text(json.dumps({'build':source,'assets':assets},indent=2)+'\n')
(out/'SHA256SUMS.txt').write_text(''.join(item['sha256']+'  '+item['name']+'\n' for item in assets))
print(json.dumps({'buildId':lock['buildId'],'binaries':source['binaries'],'sourceBytes':(out/'ffmpeg-seqvio-source-v1.tar.gz').stat().st_size}))
