#!/usr/bin/env python3
"""Read-only screenshot/recording protection detector for decoded APKs.

This module only discovers and classifies indicators. It never patches, signs,
injects, or disables a protection mechanism.
"""
import argparse, hashlib, json, re, time
from pathlib import Path

PATTERNS = {
    "FLAG_SECURE": [r"FLAG_SECURE", r"0x00002000"],
    "MEDIA_PROJECTION": [r"MediaProjection", r"createVirtualDisplay", r"getMediaProjection"],
    "SCREEN_CAPTURE_CALLBACKS": [r"onCapturedContentVisibilityChanged", r"onScreenCapture", r"onCaptureScreen"],
    "SURFACE_SECURITY": [r"setSecure", r"setSecurityLayer", r"SECURE"],
    "DRM_PROTECTION": [r"MediaDrm", r"DrmSession", r"Widevine", r"ContentProtection", r"setForceInsecureDecoder"],
    "NATIVE_CAPTURE": [r"nativeOnCaptureScreen", r"captureScreen", r"screen.?capture", r"screenshot", r"recording", r"projection"],
}
TEXT_EXTS = {".smali", ".xml", ".txt", ".java", ".kt", ".c", ".cc", ".cpp", ".h", ".hpp"}
SO_EXT = ".so"

def sha256(path):
    h=hashlib.sha256()
    with open(path,"rb") as f:
        for b in iter(lambda:f.read(1024*1024),b""): h.update(b)
    return h.hexdigest()

def scan_text(path):
    try: text=path.read_text(encoding="utf-8",errors="replace")
    except OSError: return []
    hits=[]
    for category, pats in PATTERNS.items():
        for pat in pats:
            for m in re.finditer(pat,text,re.I):
                line=text.count("\n",0,m.start())+1
                sample=text.splitlines()[line-1].strip()[:240] if text.splitlines() else ""
                hits.append({"category":category,"pattern":pat,"line":line,"sample":sample})
    return hits

def scan_binary(path):
    try: data=path.read_bytes()
    except OSError: return []
    # Printable strings only; avoids disassembly claims.
    strings=[m.decode("latin1","ignore") for m in re.findall(rb"[ -~]{4,}",data)]
    hits=[]
    for category,pats in PATTERNS.items():
        for pat in pats:
            rx=re.compile(pat,re.I)
            for s in strings:
                if rx.search(s):
                    hits.append({"category":category,"pattern":pat,"string":s[:240]})
    return hits

def manifest_flags(root):
    p=root/"AndroidManifest.xml"
    out=[]
    if not p.exists(): return out
    try:
        root_xml=ET.parse(p).getroot()
    except Exception as e:
        return [{"category":"MANIFEST_PARSE","error":str(e)}]
    android_ns="{http://schemas.android.com/apk/res/android}"
    for elem in root_xml.iter():
        if elem.tag.endswith("activity") or elem.tag.endswith("application"):
            for k,v in elem.attrib.items():
                if k == android_ns+"allowBackup" and v.lower()=="false":
                    pass
    return out

def run(root):
    root=Path(root).resolve()
    if not root.is_dir(): raise SystemExit("analysis root does not exist")
    hits=[]
    files_scanned=0
    for p in sorted(root.rglob("*")):
        if not p.is_file(): continue
        if p.name.startswith("REELSEC-") or p.suffix in TEXT_EXTS:
            h=scan_text(p)
        elif p.suffix==SO_EXT:
            h=scan_binary(p)
        else:
            continue
        if h:
            hits.append({"file":str(p.relative_to(root)),"sha256":sha256(p),"hits":h})
        files_scanned+=1
    categories={}
    for item in hits:
        for h in item["hits"]:
            categories[h["category"]]=categories.get(h["category"],0)+1
    return {
        "schema_version":"capture-detection-1",
        "generated_at_epoch":time.time(),
        "root":str(root),
        "read_only":True,
        "files_scanned":files_scanned,
        "files_with_hits":len(hits),
        "category_counts":categories,
        "hits":hits,
        "causal_proof":False,
        "interpretation":"STATIC_INDICATORS_ONLY",
        "evidence_policy": {"strong_indicators":["FLAG_SECURE","MEDIA_PROJECTION","SCREEN_CAPTURE_CALLBACKS","SURFACE_SECURITY"],"context_indicators":["DRM_PROTECTION","NATIVE_CAPTURE"],"causal_proof_requires":["runtime observation tied to the exact artifact","provenance matching the target code path","observable security decision or capture behavior"]},
    }

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument("root")
    ap.add_argument("-o","--output")
    a=ap.parse_args()
    report=run(a.root)
    text=json.dumps(report,indent=2,sort_keys=True,ensure_ascii=False)+"\n"
    if a.output:
        Path(a.output).write_text(text,encoding="utf-8")
    else: print(text)

if __name__=="__main__": main()
