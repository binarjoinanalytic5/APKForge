#!/usr/bin/env python3
"""Read-only screenshot/recording protection detector for decoded APK trees.

This module only discovers and classifies indicators. It never patches, signs,
injects, or disables a protection mechanism.

Schema: capture-detection-2

New in v2:
- Smali data-flow heuristic for WindowManager FLAG_SECURE (0x2000 register
  load followed by addFlags/setFlags/or-int in a bounded line window).
- Packer / app-hardening shell detection (SecShell, Bangcle/SecNeo, Qihoo
  Jiagu, Tencent Legu, Ali Mobisec, Ijiami, KiwiSec) from the manifest,
  native library names, and asset names.
- Hidden (packed) DEX payload discovery inside assets/lib/unknown containers.
- Protected-content buffer and DRM security-level string classes.
- Structured per-layer mechanism summary with an overall verdict.
- Hit deduplication and sampling caps so reports stay bounded.
"""
import argparse, hashlib, json, re, time
from pathlib import Path
import xml.etree.ElementTree as ET

ANDROID_NS = "{http://schemas.android.com/apk/res/android}"

# Text/binary indicator table. Matching is case-insensitive. Patterns are
# intentionally conservative: indicator presence is not execution proof.
PATTERNS = {
    "FLAG_SECURE": [r"FLAG_SECURE"],
    "MEDIA_PROJECTION": [r"MediaProjection", r"createVirtualDisplay", r"getMediaProjection"],
    "SCREEN_CAPTURE_CALLBACKS": [
        r"onCapturedContentVisibilityChanged", r"onScreenCapture", r"onCaptureScreen",
        r"ScreenCaptureCallback", r"registerScreenCaptureCallback",
    ],
    "SURFACE_SECURITY": [r"setSecure\b", r"setSecurityLayer", r"SurfaceControl"],
    "DRM_PROTECTION": [
        r"MediaDrm", r"DrmSession", r"Widevine", r"edef8ba9", r"OEMCrypto",
        r"ContentProtection", r"setForceInsecureDecoder",
    ],
    "DRM_SECURITY_LEVEL": [r"HW_SECURE", r"SW_SECURE", r"securityLevel"],
    "PROTECTED_CONTENT": [
        r"GRALLOC_USAGE_PROTECTED", r"AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT",
        r"EGL_PROTECTED_CONTENT", r"PROTECTED_CONTENT", r"protected.?content",
        r"secure.?decoder",
    ],
    "NATIVE_CAPTURE": [
        r"nativeOnCaptureScreen", r"captureScreen", r"screen.?capture", r"screenshot",
        r"screencap", r"screenrecord", r"screen.?record",
    ],
    "TAMPER_RESISTANCE": [r"\bfrida\b", r"xposed", r"magisk", r"TracerPid", r"\bptrace\b"],
}

TEXT_EXTS = {".smali", ".xml", ".txt", ".java", ".kt", ".c", ".cc", ".cpp", ".h", ".hpp"}
SO_EXT = ".so"

MAX_TEXT_HITS_PER_FILE = 200
MAX_STRINGS_PER_PATTERN = 20

# --- Smali FLAG_SECURE data-flow heuristic ---------------------------------

SMALI_FLAG_LOAD = re.compile(r"const(?:/4|/16|/high16)?\s+(?:v|p)\d+,\s*(?:0x2000|#8192)\b")
SMALI_FLAG_USE = re.compile(r"->addFlags\(I\)V|->setFlags\(II\)V|or-int\b")
SMALI_LOAD_WINDOW_BEFORE = 6
SMALI_LOAD_WINDOW_AFTER = 8

def scan_smali_flag_secure(path):
    """Detect FLAG_SECURE even when the obfuscated Smali never names it.

    Obfuscated builds load the literal 0x2000 into a register and OR it into
    WindowManager.LayoutParams flags. A bare 0x2000 constant is common noise
    (buffer sizes, bitmasks), so a hit requires a flag-application call in the
    bounded window around the load.
    """
    try:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except OSError:
        return []
    hits = []
    for i, line in enumerate(lines):
        if not SMALI_FLAG_LOAD.search(line):
            continue
        lo = max(0, i - SMALI_LOAD_WINDOW_BEFORE)
        window = lines[lo:i + SMALI_LOAD_WINDOW_AFTER + 1]
        use = next((w for w in window if SMALI_FLAG_USE.search(w)), None)
        if use is not None:
            hits.append({
                "category": "FLAG_SECURE",
                "pattern": "SMALI_0x2000_FLAG_WINDOW",
                "line": i + 1,
                "sample": line.strip()[:240],
                "evidence": "HEURISTIC_WINDOW_MATCH",
                "use_sample": use.strip()[:240],
            })
    return hits

# --- Packer / hardening shell detection -------------------------------------

PACKERS = {
    "SecShell": {
        "manifest": ("com.seccell.", "com.secshell."),
        "libs": ("libsecshell",),
        "assets": ("secshell", "secdata"),
    },
    "Bangcle/SecNeo": {
        "manifest": ("com.secneo.", "com.bangcle."),
        "libs": ("libsecmain", "libdexhelper", "libsecexe"),
        "assets": ("bangcle", "secneo"),
    },
    "Qihoo Jiagu": {
        "manifest": ("com.qihoo.util", "com.qihoo360.replugin"),
        "libs": ("libjiagu",),
        "assets": ("jiagu",),
    },
    "Tencent Legu": {
        "manifest": ("com.tencent.stubshell",),
        "libs": ("libshell-super", "libtup", "libtosprotection", "libshella", "libshellx"),
        "assets": ("tosversion", "o0oo00o"),
    },
    "Ali Mobisec": {
        "manifest": ("com.ali.mobisecenhance",),
        "libs": ("libmobisec",),
        "assets": ("mobisec",),
    },
    "Ijiami": {
        "manifest": ("com.shell.superapplication", "s.h.e.l.l"),
        "libs": ("libexecmain",),
        "assets": ("ijiami",),
    },
    "KiwiSec": {
        "manifest": ("com.kiwisec",),
        "libs": ("libkiwisec",),
        "assets": ("kiwisec",),
    },
}

HIDDEN_DEX_RE = re.compile(rb"dex\n03[5-9]|dey\n036")
HIDDEN_DEX_SCAN_TOPS = {"assets", "lib", "unknown", "original"}
HIDDEN_DEX_SCAN_EXTS = {"", ".bin", ".dat", ".jar", ".dex", ".mp3", ".png", ".so"}
HIDDEN_DEX_MAX_SIZE = 64 * 1024 * 1024
HIDDEN_DEX_MAX_REPORT = 40

def manifest_context(root):
    p = root / "AndroidManifest.xml"
    ctx = {"present": False}
    if not p.exists():
        return ctx
    try:
        root_xml = ET.parse(p).getroot()
    except ET.ParseError as exc:
        return {"present": True, "parse_error": str(exc)}
    app = root_xml.find("application")
    ctx["present"] = True
    if app is not None:
        for key in ("name", "appComponentFactory", "extractNativeLibs", "debuggable"):
            v = app.get(ANDROID_NS + key)
            if v is not None:
                ctx[key] = v
    return ctx

def detect_packers(root, ctx):
    findings = []
    lib_names = set()
    lib_dir = root / "lib"
    if lib_dir.is_dir():
        lib_names = {p.name.lower() for p in lib_dir.rglob("*.so")}
    asset_names = set()
    assets_dir = root / "assets"
    if assets_dir.is_dir():
        asset_names = {
            str(p.relative_to(assets_dir)).lower().replace("\\", "/")
            for p in assets_dir.rglob("*") if p.is_file()
        }
    manifest_names = " ".join(
        str(ctx.get(k, "")) for k in ("name", "appComponentFactory")
    ).lower()
    for packer, sig in PACKERS.items():
        evidence = []
        for prefix in sig["manifest"]:
            if prefix in manifest_names:
                evidence.append("manifest:" + prefix)
        for lib in sig["libs"]:
            for name in sorted(lib_names):
                if lib in name:
                    evidence.append("native_lib:" + name)
                    break
        for asset in sig["assets"]:
            for name in sorted(asset_names):
                if asset in name:
                    evidence.append("asset:" + name)
                    break
        if evidence:
            findings.append({"packer": packer, "evidence": sorted(set(evidence))})
    return findings

def scan_hidden_dex(root):
    found = []
    for p in sorted(root.rglob("*")):
        if len(found) >= HIDDEN_DEX_MAX_REPORT:
            break
        if not p.is_file():
            continue
        rel = p.relative_to(root).as_posix()
        top = rel.split("/", 1)[0]
        in_payload_top = top in HIDDEN_DEX_SCAN_TOPS and "/" in rel
        if not in_payload_top and p.suffix not in HIDDEN_DEX_SCAN_EXTS:
            continue
        if p.suffix in TEXT_EXTS:
            continue
        try:
            if p.stat().st_size > HIDDEN_DEX_MAX_SIZE:
                continue
            data = p.read_bytes()
        except OSError:
            continue
        m = HIDDEN_DEX_RE.search(data)
        if m:
            found.append({
                "file": rel,
                "offset": m.start(),
                "magic": data[m.start():m.start() + 8].decode("latin1", "ignore"),
                "size": len(data),
            })
    return found

# --- Generic scanners --------------------------------------------------------

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for b in iter(lambda: f.read(1024 * 1024), b""):
            h.update(b)
    return h.hexdigest()

def scan_text(path):
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return []
    hits = []
    for category, pats in PATTERNS.items():
        for pat in pats:
            for m in re.finditer(pat, text, re.I):
                if len(hits) >= MAX_TEXT_HITS_PER_FILE:
                    return hits
                line = text.count("\n", 0, m.start()) + 1
                lines = text.splitlines()
                sample = lines[line - 1].strip()[:240] if lines else ""
                hits.append({"category": category, "pattern": pat, "line": line, "sample": sample})
    return hits

def scan_binary(path):
    try:
        data = path.read_bytes()
    except OSError:
        return []
    # Printable strings only; avoids disassembly claims.
    strings = [m.decode("latin1", "ignore") for m in re.findall(rb"[ -~]{4,}", data)]
    hits = []
    for category, pats in PATTERNS.items():
        for pat in pats:
            rx = re.compile(pat, re.I)
            seen = {}
            for s in strings:
                if rx.search(s):
                    seen[s[:240]] = seen.get(s[:240], 0) + 1
            for s, count in list(seen.items())[:MAX_STRINGS_PER_PATTERN]:
                hits.append({"category": category, "pattern": pat, "string": s, "count": count})
    return hits

# --- Summary -----------------------------------------------------------------

def build_summary(categories, packers, hidden_dex, heuristic_count):
    mechanisms = []

    def add(layer, mechanism, confidence, count):
        if count:
            mechanisms.append({
                "layer": layer, "mechanism": mechanism,
                "confidence": confidence, "evidence_count": count,
            })

    if heuristic_count:
        add("JAVA_UI", "WINDOW_FLAG_SECURE_SMALI_HEURISTIC", "MEDIUM_HEURISTIC", heuristic_count)
    literal_flag = categories.get("FLAG_SECURE", 0) - heuristic_count
    if literal_flag > 0:
        add("JAVA_UI", "FLAG_SECURE_REFERENCE", "MEDIUM", literal_flag)
    add("JAVA_MEDIA", "MEDIA_PROJECTION_API", "LOW_INDICATOR", categories.get("MEDIA_PROJECTION", 0))
    add("JAVA_CAPTURE_CALLBACKS", "SCREEN_CAPTURE_CALLBACKS", "MEDIUM",
        categories.get("SCREEN_CAPTURE_CALLBACKS", 0))
    add("NATIVE_SURFACE", "SECURE_SURFACE_API", "MEDIUM", categories.get("SURFACE_SECURITY", 0))
    drm = categories.get("DRM_PROTECTION", 0) + categories.get("DRM_SECURITY_LEVEL", 0)
    add("DRM", "DRM_PROTECTION_STRINGS", "MEDIUM", drm)
    add("NATIVE_BUFFERS", "PROTECTED_CONTENT_BUFFERS", "MEDIUM", categories.get("PROTECTED_CONTENT", 0))
    add("NATIVE_STRINGS", "CAPTURE_RELATED_STRINGS", "LOW_INDICATOR", categories.get("NATIVE_CAPTURE", 0))
    add("TAMPER", "ANTI_INSTRUMENTATION_STRINGS", "LOW_INDICATOR", categories.get("TAMPER_RESISTANCE", 0))
    add("PACKER", "APP_HARDENING_SHELL", "HIGH_STRUCTURAL", sum(len(p["evidence"]) for p in packers))
    add("PACKER", "HIDDEN_DEX_PAYLOAD", "HIGH_STRUCTURAL", len(hidden_dex))

    java_flag_secure = heuristic_count or literal_flag > 0
    if packers and not java_flag_secure:
        verdict = "PACKED_STATIC_ANALYSIS_LIMITED"
        note = ("An app-hardening shell is present: the real application code is encrypted "
                "and only materializes at runtime, so Java-layer protection (e.g. FLAG_SECURE) "
                "cannot be fully enumerated from static files alone.")
    elif java_flag_secure:
        verdict = "JAVA_LAYER_PROTECTION_INDICATED"
        note = "Window FLAG_SECURE style indicators were found in managed code."
    elif mechanisms:
        verdict = "INDICATORS_PRESENT"
        note = "Protection-related indicators exist but no single decisive mechanism was isolated."
    else:
        verdict = "NONE_FOUND"
        note = "No screenshot/recording protection indicators were found in the scanned tree."
    return {"mechanisms": mechanisms, "verdict": verdict, "note": note}

def run(root):
    root = Path(root).resolve()
    if not root.is_dir():
        raise SystemExit("analysis root does not exist")
    hits = []
    files_scanned = 0
    heuristic_count = 0
    for p in sorted(root.rglob("*")):
        if not p.is_file():
            continue
        if p.name.startswith("REELSEC-") or p.suffix in TEXT_EXTS:
            h = scan_text(p)
            if p.suffix == ".smali":
                sh = scan_smali_flag_secure(p)
                heuristic_count += len(sh)
                h = sh + h
        elif p.suffix == SO_EXT:
            h = scan_binary(p)
        else:
            continue
        if h:
            hits.append({"file": str(p.relative_to(root)), "sha256": sha256(p), "hits": h})
        files_scanned += 1
    categories = {}
    for item in hits:
        for h in item["hits"]:
            categories[h["category"]] = categories.get(h["category"], 0) + 1
    ctx = manifest_context(root)
    packers = detect_packers(root, ctx)
    hidden_dex = scan_hidden_dex(root)
    summary = build_summary(categories, packers, hidden_dex, heuristic_count)
    return {
        "schema_version": "capture-detection-2",
        "generated_at_epoch": time.time(),
        "root": str(root),
        "read_only": True,
        "files_scanned": files_scanned,
        "files_with_hits": len(hits),
        "category_counts": categories,
        "manifest": ctx,
        "packers": packers,
        "hidden_dex": hidden_dex,
        "summary": summary,
        "hits": hits,
        "causal_proof": False,
        "interpretation": "STATIC_INDICATORS_ONLY",
        "evidence_policy": {"strong_indicators":["FLAG_SECURE","MEDIA_PROJECTION","SCREEN_CAPTURE_CALLBACKS","SURFACE_SECURITY"],"context_indicators":["DRM_PROTECTION","NATIVE_CAPTURE"],"causal_proof_requires":["runtime observation tied to the exact artifact","provenance matching the target code path","observable security decision or capture behavior"]},
    }

def to_markdown(report):
    s = report["summary"]
    lines = [
        "# Capture protection detection (read-only)",
        "",
        "Verdict: **%s**" % s["verdict"],
        "",
        s["note"],
        "",
        "Files scanned: %d, files with hits: %d" % (report["files_scanned"], report["files_with_hits"]),
        "",
        "## Mechanisms",
        "",
        "| Layer | Mechanism | Confidence | Evidence |",
        "|---|---|---|---|",
    ]
    for m in s["mechanisms"]:
        lines.append("| %s | %s | %s | %d |" % (m["layer"], m["mechanism"], m["confidence"], m["evidence_count"]))
    if report["packers"]:
        lines += ["", "## Packers", ""]
        for p in report["packers"]:
            lines.append("- **%s**: %s" % (p["packer"], ", ".join(p["evidence"])))
    if report["hidden_dex"]:
        lines += ["", "## Hidden DEX payloads", ""]
        for d in report["hidden_dex"][:20]:
            lines.append("- `%s` offset=%d size=%d" % (d["file"], d["offset"], d["size"]))
    lines += ["", "Indicators only: causal_proof=false. This tool never patches or disables anything.", ""]
    return "\n".join(lines)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("root")
    ap.add_argument("-o", "--output")
    ap.add_argument("-m", "--markdown", help="also write a Markdown summary to this path")
    a = ap.parse_args()
    report = run(a.root)
    text = json.dumps(report, indent=2, sort_keys=True, ensure_ascii=False) + "\n"
    if a.output:
        Path(a.output).write_text(text, encoding="utf-8")
    else:
        print(text)
    if a.markdown:
        Path(a.markdown).write_text(to_markdown(report), encoding="utf-8")

if __name__ == "__main__":
    main()
