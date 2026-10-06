#!/usr/bin/env python3
import argparse,hashlib,json,os,re,shutil,struct,subprocess,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
VERSION="1.1.0"
PROBES=["elf","symbols","strings","vtable","dispatch","critical-function","callgraph-context","protection-bridge"]
def run(c):
 try:
  p=subprocess.run(c,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,check=False); return p.returncode,p.stdout
 except Exception as e:return 127,str(e)+"\n"
def which(*n):
 for x in n:
  p=shutil.which(x)
  if p:return p
def sha(p):
 h=hashlib.sha256(); f=open(p,"rb")
 for b in iter(lambda:f.read(1048576),b""):h.update(b)
 f.close();return h.hexdigest()
def find_target(explicit):
 if explicit:
  p=Path(explicit).expanduser().resolve();return p if p.is_file() else None
 ss=which("strings"); cand=sorted(ROOT.rglob("*.so"))
 needles=("ActiveDecoder","avcodecDecoder","SuperMediaPlayer","setOutputSurface","queueSecureInputBuffer")
 if ss:
  for p in cand:
   _,s=run([ss,"-a",str(p)])
   if any(x in s for x in needles):return p
 for p in cand:
  if "saasCorePlayer" in p.name:return p
 return None
def segments(d):
 if d[:4]!=b"\x7fELF" or d[4]!=2 or d[5]!=1:return []
 phoff=struct.unpack_from("<Q",d,32)[0]; es=struct.unpack_from("<H",d,54)[0]; n=struct.unpack_from("<H",d,56)[0]; out=[]
 for i in range(n):
  o=phoff+i*es;t=struct.unpack_from("<I",d,o)[0]
  if t==1:out.append((struct.unpack_from("<Q",d,o+16)[0],struct.unpack_from("<Q",d,o+8)[0],struct.unpack_from("<Q",d,o+32)[0]))
 return out
def vaoff(d,va):
 for v,o,s in segments(d):
  if v<=va<v+s:return o+va-v
 return None
def dump(od,target,a,b,path):
 if not od:return
 rc,s=run([od,"-d","--start-address="+hex(a),"--stop-address="+hex(b),str(target)])
 path.write_text(s+"\n[exit="+str(rc)+"]\n",encoding="utf8")
\ndef symbol_context(symbols_text, addr):
 rows=[]
 for line in symbols_text.splitlines():
  m=re.search(r"^\\s*([0-9a-fA-F]+)\\s+([0-9]+)\\s+.*\\s+([A-Za-z_][^ ]*)\\s*$",line)
  if m:
   try:
    v=int(m.group(1),16); size=int(m.group(2))
    if v<=addr< v+max(size,1): rows.append((v,size,m.group(3)))
   except: pass
 return rows

def read_pointer(d,va):
 o=vaoff(d,va)
 if o is None or o+8>len(d): return None,None
 raw=d[o:o+8]; return struct.unpack("<Q",raw)[0],raw
def main():
 ap=argparse.ArgumentParser();ap.add_argument("--elf");ap.add_argument("--output");ap.add_argument("--version",action="version",version=VERSION);a=ap.parse_args()
 out=Path(a.output).expanduser() if a.output else ROOT/"analysis/sec-shell-deep-v1"/("reelsec-"+time.strftime("%Y%m%d_%H%M%S"));out.mkdir(parents=True,exist_ok=True)
 target=find_target(a.elf); manifest={"tool":"ReelSec","version":VERSION,"probes":PROBES,"target":str(target) if target else None}
 (out/"manifest.json").write_text(json.dumps(manifest,indent=2),encoding="utf8")
 if not target:
  (out/"STATUS.txt").write_text("TARGET_NOT_FOUND\n");print("TARGET_NOT_FOUND");return 0
 d=target.read_bytes(); digest=sha(target);(out/"TARGET-ELF.txt").write_text(str(target)+"\n");(out/"target-sha256.txt").write_text(digest+"\n")
 reade=which("readelf","llvm-readelf"); strings=which("strings"); od=which("llvm-objdump","objdump")
 if reade:
  for flag,name in [("-SW","sections.txt"),("-lW","program-headers.txt"),("-Ws","all-symbols.txt")]:run([reade,flag,str(target)]);rc,s=run([reade,flag,str(target)]);(out/name).write_text(s,encoding="utf8")
 if strings:
  _,s=run([strings,"-a","-t","x",str(target)]);(out/"strings-offsets.txt").write_text(s,encoding="utf8");(out/"security-strings.txt").write_text("\n".join(x for x in s.splitlines() if re.search("protected|secure|Surface|ANativeWindow|EGL|GRALLOC|AHardwareBuffer|MediaCodec|FLAG_SECURE|screenshot|recording|WideVine|ContentProtection|queueSecureInputBuffer|setOutputSurface|setForceInsecureDecoder",x,re.I)),encoding="utf8")
 s=vaoff(d,0x717ce0);e=vaoff(d,0x71807f);slot=vaoff(d,0x717f68); lines=["ReelSec raw ELF analysis","ELF="+str(target),"SHA256="+digest,"0x717e60 file offset="+str(vaoff(d,0x717e60)),"0x717f68 file offset="+str(slot)]
 if slot is not None and slot+8<=len(d):
  raw=d[slot:slot+8];ptr=struct.unpack("<Q",raw)[0];lines+=["0x717f68 RAW_BYTES="+" ".join(f"{x:02x}" for x in raw),"0x717f68 FUNCTION_POINTER=0x"+format(ptr,"x")];(out/"CRITICAL-FUNCTION-POINTER.txt").write_text("\n".join(lines[-2:])+"\n")
 else:ptr=None;lines.append("0x717f68 NOT_FILE_BACKED")
 (out/"elf-python-analysis.txt").write_text("\n".join(lines)+"\n")
 if s is not None and e is not None:
  chunk=d[s:e+1];(out/"vtable-raw-bytes.txt").write_text("\n".join(f"{0x717ce0+i:016x}  "+" ".join(f"{x:02x}" for x in chunk[i:i+16]) for i in range(0,len(chunk),16))+"\n");(out/"vtable-qwords.txt").write_text("\n".join(f"{0x717ce0+i:016x} -> {struct.unpack_from("<Q",chunk,i)[0]:016x}" for i in range(0,len(chunk)-7,8))+"\n")
 if od:
  dump(od,target,0x27ae80,0x27b280,out/"dispatch-sites.txt");dump(od,target,0x2783c0,0x278500,out/"ActiveDecoder-constructor.txt");dump(od,target,0x112e80,0x113000,out/"onCaptureScreen-dispatch.txt")
  if ptr is not None:
   dump(od,target,max(0,ptr-0x120),ptr+0x500,out/"CRITICAL-FUNCTION-0x%X.txt"%ptr)
   dump(od,target,max(0,ptr-0x40),ptr+0x40,out/"CRITICAL-FUNCTION-ENTRY.txt")
 # Resolve pointer against symbols and search direct references to its address/patterns.
 symtxt=(out/"all-symbols.txt").read_text(errors="replace") if (out/"all-symbols.txt").exists() else ""
 matches=symbol_context(symtxt,ptr) if ptr is not None else []
 (out/"CRITICAL-FUNCTION-SYMBOL.txt").write_text("\\n".join("%#x size=%d %s"%x for x in matches)+("\\n" if matches else "NOT_RESOLVED_BY_SYMBOL_TABLE\\n"),encoding="utf8")
 # Build a compact protection-bridge indicator report from actual collected evidence.
 sec=(out/"security-strings.txt").read_text(errors="replace") if (out/"security-strings.txt").exists() else ""
 bridge=["# Protection Bridge Audit","", "Critical pointer: "+(hex(ptr) if ptr is not None else "NOT_RESOLVED"),"", "Indicators found in target ELF:"]
 for k in ["queueSecureInputBuffer","setOutputSurface","setForceInsecureDecoder","ANativeWindow","EGL","GRALLOC","AHardwareBuffer","FLAG_SECURE","MediaProjection","createVirtualDisplay","screenshot","recording"]:
  bridge.append("- %s: %s"%(k,"FOUND" if k.lower() in sec.lower() else "NOT_FOUND"))
 bridge += ["","Rule: indicator presence is not execution proof. The critical function body and call targets must be inspected next."]
 (out/"PROTECTION-BRIDGE-AUDIT.md").write_text("\\n".join(bridge)+"\\n",encoding="utf8")
 report="# ReelSec VTable Resolution Report\n\nTarget: "+str(target)+"\nSHA-256: "+digest+"\nCalculated address-point: 0x717e60\nCritical slot: 0x717f68\nExtracted function pointer: "+(hex(ptr) if ptr is not None else "NOT_RESOLVED")+"\n\nThe pointer is read directly from the ELF via PT_LOAD mapping. The tool then disassembles the actual pointer target and resolves it against the symbol table when possible. No Screenshot-blocking claim is made from this result alone.\n"
 (out/"VTable-RESOLUTION-REPORT.md").write_text(report,encoding="utf8");manifest.update(status="completed",target_sha256=digest,critical_pointer=(hex(ptr) if ptr is not None else None));(out/"manifest.json").write_text(json.dumps(manifest,indent=2),encoding="utf8");print("REPORT="+str(out));print("FUNCTION_POINTER="+(hex(ptr) if ptr is not None else "NOT_RESOLVED"))
if __name__=="__main__":main()
