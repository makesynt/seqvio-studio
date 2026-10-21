#!/usr/bin/env python3
import hashlib,io,json,pathlib,sys,tarfile,time,urllib.request

def select_amf_headers(data):
    out=io.BytesIO()
    with tarfile.open(fileobj=io.BytesIO(data),mode='r:*') as source, tarfile.open(fileobj=out,mode='w',format=tarfile.USTAR_FORMAT) as target:
        selected=[]
        for item in source:
            if not item.isfile(): continue
            rel=item.name.split('/',1)[1] if '/' in item.name else ''
            if rel.startswith('amf/public/include/') or rel.lower() in ['license.txt','license','readme.md']:
                selected.append((rel,source.extractfile(item).read()))
        if not any(name.endswith('core/Factory.h') for name,_ in selected): raise SystemExit('AMF header selection incomplete')
        for name,body in sorted(selected):
            info=tarfile.TarInfo('amf-headers-1.4.36/'+name);info.size=len(body);info.mode=0o644;info.mtime=0
            target.addfile(info,io.BytesIO(body))
    return out.getvalue()

def main():
    base=pathlib.Path(__file__).resolve().parent
    lock=json.loads((base/'versions.lock.json').read_text())
    root=pathlib.Path(sys.argv[1]) if len(sys.argv)>1 else base.parent/'sources'
    root.mkdir(parents=True,exist_ok=True)
    for spec in lock['sources']:
        target=root/spec['archive']
        if not target.exists():
            request=urllib.request.Request(spec['url'],headers={'User-Agent':'Seqvio-FFmpeg-source-build'})
            for attempt in range(5):
                try:
                    print('FETCH',spec['name'],'attempt',attempt+1,flush=True)
                    with urllib.request.urlopen(request,timeout=300) as response: data=response.read()
                    break
                except (OSError,TimeoutError) as error:
                    if attempt==4:raise
                    print('RETRY',spec['name'],type(error).__name__,flush=True)
                    time.sleep(2**attempt)
            if spec.get('selection')=='amf-public-headers-v1':
                upstream=spec['upstreamArchive']
                if len(data)!=upstream['size'] or hashlib.sha256(data).hexdigest()!=upstream['sha256']:raise SystemExit('Upstream AMF archive checksum mismatch')
                data=select_amf_headers(data)
            target.write_bytes(data)
        data=target.read_bytes()
        if len(data)!=spec['size'] or hashlib.sha256(data).hexdigest()!=spec['sha256']:raise SystemExit('Source checksum mismatch: '+spec['name'])
        print('VERIFIED',spec['name'],spec['sha256'],flush=True)
if __name__=='__main__':main()
