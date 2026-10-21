#!/usr/bin/env python3
import hashlib,json,pathlib,sys,urllib.request
base=pathlib.Path(__file__).resolve().parent
lock=json.loads((base/'versions.lock.json').read_text())
root=pathlib.Path(sys.argv[1]) if len(sys.argv)>1 else base.parent/'sources'
root.mkdir(parents=True,exist_ok=True)
for spec in lock['sources']:
    target=root/spec['archive']
    if not target.exists():
        request=urllib.request.Request(spec['url'],headers={'User-Agent':'Seqvio-FFmpeg-source-build'})
        with urllib.request.urlopen(request,timeout=180) as response,target.with_suffix(target.suffix+'.part').open('wb') as out:
            while chunk:=response.read(1024*1024): out.write(chunk)
        target.with_suffix(target.suffix+'.part').rename(target)
    data=target.read_bytes()
    if len(data)!=spec['size'] or hashlib.sha256(data).hexdigest()!=spec['sha256']:
        raise SystemExit('Source checksum mismatch: '+spec['name'])
    print('VERIFIED',spec['name'],spec['sha256'],flush=True)
