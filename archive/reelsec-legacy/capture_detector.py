#!/usr/bin/env python3
"""Read-only screenshot/recording protection detector for APKs and decoded trees.

This module only discovers and classifies indicators. It never patches, signs,
injects, or disables a protection mechanism.

Schema: capture-detection-3

Input modes:
- decoded APK directory (apktool tree) — smali/manifest/native analysis
- APK/ZIP file — in-memory container scan; nothing is extracted to disk

New in v3:
- APK/ZIP input mode: entry inventory, per-entry native string scan, packed
  DEX detection inside container entries, packer detection from entry names
  and from the binary AndroidManifest string pool (ASCII + UTF-16LE).
- ELF dynamic symbol table (.dynsym) extraction: exported symbols are
  classified against the same indicator table (NATIVE_SYMBOLS category).
- Noise classification: hits inside well-known third-party SDK paths are
  flagged noise=true (tiered UNRELATED downstream) with a reason.
- Anti-tamper family tagging (frida/xposed/magisk/ptrace/root).

New in v2 (retained):
- Smali FLAG_SECURE data-flow heuristic (0x2000 + addFlags/setFlags window).
- Packer / hardening shell detection from manifest, native lib and asset names.
- Hidden (packed) DEX payload discovery.
- Protected-content and DRM security-level string classes.
- Per-layer mechanism summary with verdict; evidence_policy contract.
"""
import argparse, hashlib, json, re, struct, time, zipfile
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

TAMPER_FAMILIES = {
    "frida": r"\bfrida\b",
    "xposed": r"xposed",
    "magisk": r"magisk",
    "ptrace": r"\bptrace\b|TracerPid",
    "root": r"\bsu\b|supolicy|superuser",
}

# Well-known third-party SDK paths. Hits here are usually unrelated to the
# app's own screen-protection logic and are flagged as noise (UNRELATED
# downstream). The flag never deletes evidence; it classifies relevance.
NOISE_PATH_PREFIXES = (
    "smali/com/google/firebase/", "smali/com/google/android/gms/",
    "smali/com/google/protobuf/", "smali/okhttp3/", "smali/okio/",
    "smali/kotlin/", "smali/kotlinx/", "smali/androidx/",
    "smali/com/facebook/", "smali/com/appsflyer/", "smali/com/adjust/",
    "smali/com/bumptech/", "smali/com/squareup/", "smali/com/airbnb/",
    "com/google/firebase/", "com/google/android/gms/", "com/google/protobuf/",
    "okhttp3/", "okio/", "kotlin/", "kotlinx/", "androidx/",
    "com/facebook/", "com/appsflyer/", "com/adjust/",
)
NOISE_REASON = "third-party SDK path; indicator context presumed unrelated to app screen protection"
NOISE_TEXT_EXTS = {".txt"}  # bundled data lists (e.g. public-suffix-list)

TEXT_EXTS = {".smali", ".xml", ".txt", ".java", ".kt", ".c", ".cc", ".cpp", ".h", ".hpp"}
SO_EXT = ".so"

MAX_TEXT_HITS_PER_FILE = 200
MAX_STRINGS_PER_PATTERN = 20
MAX_SYMBOLS_PER_FILE = 60
APK_ENTRY_READ_CAP = 24 * 1024 * 1024
APK_STRINGS_SCAN_CAP = 12 * 1024 * 1024

# --- Smali FLAG_SECURE data-flow heuristic ---------------------------------

SMALI_FLAG_LOAD = re.compile(r"const(?:/4|/16|/high16)?\s+(?:v|p)\d+,\s*(?:0x2000|#8192)\b")
SMALI_FLAG_USE = re.compile(r"->addFlags\(I\)V|->setFlags\(II\)V|or-int\b")
SMALI_LOAD_WINDOW_BEFORE = 6
SMALI_LOAD_WINDOW_AFTER = 8

def scan_smali_flag_secure_text(text):
    """Detect FLAG_SECURE even when the obfuscated Smali never names it.

    A bare 0x2000 constant is common noise (buffer sizes, bitmasks), so a hit
    requires a flag-application call in the bounded window around the load.
    """
    lines = text.splitlines()
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

def scan_smali_flag_secure(path):
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return []
    return scan_smali_flag_secure_text(text)

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

def detect_packers_from_container(manifest_bytes, entry_names):
    """Packer detection for APK/ZIP input: entry names + binary manifest pool."""
    findings = []
    manifest_lower_ascii = manifest_bytes.decode("latin1", "ignore").lower() if manifest_bytes else ""
    manifest_lower_u16 = manifest_bytes.decode("utf-16-le", "ignore").lower() if manifest_bytes else ""
    libs = {n.rsplit("/", 1)[-1].lower() for n in entry_names if n.startswith("lib/") and n.endswith(".so")}
    assets = {n[len("assets/"):].lower() for n in entry_names if n.startswith("assets/")}
    for packer, sig in PACKERS.items():
        evidence = []
        for prefix in sig["manifest"]:
            if prefix in manifest_lower_ascii or prefix in manifest_lower_u16:
                evidence.append("binary_manifest:" + prefix)
        for lib in sig["libs"]:
            for name in sorted(libs):
                if lib in name:
                    evidence.append("native_lib:" + name)
                    break
        for asset in sig["assets"]:
            for name in sorted(assets):
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

# --- ELF dynamic symbol extraction ------------------------------------------

SHT_DYNSYM = 11

def elf_dynamic_symbols(data):
    """Parse .dynsym/.dynstr of a little/big-endian ELF32/64. Read-only.

    Returns a list of {name, bind, type, defined}. Malformed input yields [].
    """
    try:
        if len(data) < 64 or data[:4] != b"\x7fELF":
            return []
        is64 = data[4] == 2
        en = "<" if data[5] == 1 else ">"
        if is64:
            e_shoff, = struct.unpack_from(en + "Q", data, 0x28)
            e_shentsize, = struct.unpack_from(en + "H", data, 0x3A)
            e_shnum, = struct.unpack_from(en + "H", data, 0x3C)
        else:
            e_shoff, = struct.unpack_from(en + "I", data, 0x20)
            e_shentsize, = struct.unpack_from(en + "H", data, 0x2E)
            e_shnum, = struct.unpack_from(en + "H", data, 0x30)
        if e_shnum == 0 or e_shentsize == 0 or e_shoff + e_shnum * e_shentsize > len(data):
            return []
        sections = []
        for i in range(e_shnum):
            off = e_shoff + i * e_shentsize
            sh_type, = struct.unpack_from(en + "I", data, off + 4)
            if is64:
                sh_offset, = struct.unpack_from(en + "Q", data, off + 0x18)
                sh_size, = struct.unpack_from(en + "Q", data, off + 0x20)
                sh_link, = struct.unpack_from(en + "I", data, off + 0x28)
                sh_entsize, = struct.unpack_from(en + "Q", data, off + 0x38)
            else:
                sh_offset, = struct.unpack_from(en + "I", data, off + 0x10)
                sh_size, = struct.unpack_from(en + "I", data, off + 0x14)
                sh_link, = struct.unpack_from(en + "I", data, off + 0x18)
                sh_entsize, = struct.unpack_from(en + "I", data, off + 0x24)
            sections.append((sh_type, sh_offset, sh_size, sh_link, sh_entsize))
        syms = []
        for sh_type, sh_offset, sh_size, sh_link, sh_entsize in sections:
            if sh_type != SHT_DYNSYM:
                continue
            if sh_link >= len(sections):
                continue
            str_off, str_size = sections[sh_link][1], sections[sh_link][2]
            if str_off + str_size > len(data):
                continue
            entsize = sh_entsize or (24 if is64 else 16)
            for so in range(sh_offset, sh_offset + sh_size, entsize):
                if so + entsize > len(data):
                    break
                st_name, = struct.unpack_from(en + "I", data, so)
                st_info = data[so + 4] if is64 else data[so + 12]
                st_shndx, = struct.unpack_from(en + "H", data, so + 6 if is64 else so + 0xE)
                if st_name == 0 or str_off + st_name >= len(data):
                    continue
                end = data.find(b"\0", str_off + st_name)
                if end == -1:
                    end = min(str_off + str_size, len(data))
                name = data[str_off + st_name:end].decode("latin1", "ignore")
                if name:
                    syms.append({
                        "name": name[:200],
                        "bind": st_info >> 4,
                        "type": st_info & 0xF,
                        "defined": st_shndx != 0,
                    })
        return syms[:MAX_SYMBOLS_PER_FILE * 10]
    except (struct.error, IndexError, ValueError):
        return []

def classify_symbols(symbols):
    hits = []
    seen = set()
    for sym in symbols:
        for category, pats in PATTERNS.items():
            for pat in pats:
                if re.search(pat, sym["name"], re.I) and sym["name"] not in seen:
                    seen.add(sym["name"])
                    hits.append({
                        "category": "NATIVE_SYMBOLS",
                        "pattern": pat,
                        "string": sym["name"],
                        "symbol_defined": sym["defined"],
                        "match_category": category,
                    })
    return hits[:MAX_SYMBOLS_PER_FILE]

# --- Generic scanners ---------------------------------------------------------

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for b in iter(lambda: f.read(1024 * 1024), b""):
            h.update(b)
    return h.hexdigest()

def sha256_bytes(data):
    return hashlib.sha256(data).hexdigest()

def is_noise_path(rel_posix):
    low = rel_posix.replace("\\", "/").lower()
    for prefix in NOISE_PATH_PREFIXES:
        if ("/" + prefix) in ("/" + low) or low.startswith(prefix):
            return True
    # smali_classesN/ variants
    m = re.match(r"smali_classes\d+/(.+)", low)
    if m:
        tail = m.group(1)
        for prefix in NOISE_PATH_PREFIXES:
            if tail.startswith(prefix):
                return True
    return False

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
                hit = {"category": category, "pattern": pat, "line": line, "sample": sample}
                if category == "TAMPER_RESISTANCE":
                    for fam, fpat in TAMPER_FAMILIES.items():
                        if re.search(fpat, sample, re.I):
                            hit["family"] = fam
                            break
                hits.append(hit)
    return hits

def scan_binary_bytes(data):
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
                hit = {"category": category, "pattern": pat, "string": s, "count": count}
                if category == "TAMPER_RESISTANCE":
                    for fam, fpat in TAMPER_FAMILIES.items():
                        if re.search(fpat, s, re.I):
                            hit["family"] = fam
                            break
                hits.append(hit)
    return hits

def scan_binary(path):
    try:
        data = path.read_bytes()
    except OSError:
        return []
    return scan_binary_bytes(data)

def scan_so_file(path):
    """String hits + dynamic symbol hits for a native library."""
    try:
        data = path.read_bytes()
    except OSError:
        return []
    hits = scan_binary_bytes(data)
    syms = elf_dynamic_symbols(data)
    hits.extend(classify_symbols(syms))
    return hits, len(syms)

# --- APK / ZIP container mode -------------------------------------------------

def scan_apk_container(path):
    """In-memory read-only scan of an APK/ZIP. Nothing is written to disk."""
    path = Path(path)
    data_sha = sha256(path)
    hits, hidden_dex, entry_inventory = [], [], {
        "entry_count": 0, "dex_entries": [], "lib_entries": [], "asset_count": 0,
    }
    manifest_bytes = b""
    entry_names = []
    with zipfile.ZipFile(path) as zf:
        infos = [i for i in zf.infolist() if not i.is_dir()]
        entry_inventory["entry_count"] = len(infos)
        entry_names = [i.filename for i in infos]
        for info in infos:
            name = info.filename
            low = name.lower()
            if low == "androidmanifest.xml":
                try:
                    manifest_bytes = zf.read(info)[:1024 * 1024]
                except Exception:
                    manifest_bytes = b""
                continue
            if low.endswith(".dex"):
                entry_inventory["dex_entries"].append(name)
                if not re.match(r"classes\d*\.dex$", name.rsplit("/", 1)[-1]):
                    try:
                        head = zf.read(info)[:16]
                    except Exception:
                        continue
                    if HIDDEN_DEX_RE.match(head):
                        hidden_dex.append({
                            "file": name, "offset": 0,
                            "magic": head[:8].decode("latin1", "ignore"),
                            "size": info.file_size,
                        })
                continue
            if low.startswith("lib/") and low.endswith(".so"):
                entry_inventory["lib_entries"].append(name)
                if info.file_size > APK_ENTRY_READ_CAP:
                    continue
                try:
                    data = zf.read(info)
                except Exception:
                    continue
                entry_hits = scan_binary_bytes(data[:APK_STRINGS_SCAN_CAP])
                entry_hits.extend(classify_symbols(elf_dynamic_symbols(data)))
                if entry_hits:
                    hits.append({
                        "file": name, "sha256": sha256_bytes(data), "hits": entry_hits,
                    })
                m = HIDDEN_DEX_RE.search(data[:4096])
                if m and m.start() != 0:
                    hidden_dex.append({
                        "file": name, "offset": m.start(),
                        "magic": data[m.start():m.start() + 8].decode("latin1", "ignore"),
                        "size": info.file_size,
                    })
                continue
            if low.startswith("assets/"):
                entry_inventory["asset_count"] += 1
                if info.file_size > APK_ENTRY_READ_CAP:
                    continue
                try:
                    data = zf.read(info)
                except Exception:
                    continue
                m = HIDDEN_DEX_RE.search(data)
                if m:
                    hidden_dex.append({
                        "file": name, "offset": m.start(),
                        "magic": data[m.start():m.start() + 8].decode("latin1", "ignore"),
                        "size": info.file_size,
                    })
    packers = detect_packers_from_container(manifest_bytes, entry_names)
    ctx = {"present": bool(manifest_bytes), "mode": "binary-string-pool"}
    summary = build_summary(aggregate_categories(hits), packers, hidden_dex, 0)
    return {
        "schema_version": "capture-detection-3",
        "generated_at_epoch": time.time(),
        "root": str(path.resolve()),
        "input_mode": "apk_container",
        "input_sha256": data_sha,
        "read_only": True,
        "files_scanned": entry_inventory["entry_count"],
        "files_with_hits": len(hits),
        "category_counts": aggregate_categories(hits),
        "manifest": ctx,
        "entry_inventory": entry_inventory,
        "packers": packers,
        "hidden_dex": hidden_dex[:HIDDEN_DEX_MAX_REPORT],
        "summary": summary,
        "hits": hits,
        "causal_proof": False,
        "interpretation": "STATIC_INDICATORS_ONLY",
        "evidence_policy": {"strong_indicators":["FLAG_SECURE","MEDIA_PROJECTION","SCREEN_CAPTURE_CALLBACKS","SURFACE_SECURITY"],"context_indicators":["DRM_PROTECTION","NATIVE_CAPTURE"],"causal_proof_requires":["runtime observation tied to the exact artifact","provenance matching the target code path","observable security decision or capture behavior"]},
    }

# --- Summary -------------------------------------------------------------------

def aggregate_categories(hits):
    categories = {}
    for item in hits:
        for h in item["hits"]:
            if h.get("noise"):
                continue
            categories[h["category"]] = categories.get(h["category"], 0) + 1
    return categories

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
    add("NATIVE_SYMBOLS", "CAPTURE_RELATED_EXPORTED_SYMBOLS", "MEDIUM", categories.get("NATIVE_SYMBOLS", 0))
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
    root_p = Path(root)
    if root_p.is_file():
        if root_p.suffix.lower() in (".apk", ".zip"):
            return scan_apk_container(root_p)
        raise SystemExit("file input must be an .apk or .zip container")
    root = root_p.expanduser().resolve()
    if not root.is_dir():
        raise SystemExit("analysis root does not exist")
    hits = []
    files_scanned = 0
    heuristic_count = 0
    noise_hits = 0
    for p in sorted(root.rglob("*")):
        if not p.is_file():
            continue
        rel = p.relative_to(root).as_posix()
        if p.name.startswith("REELSEC-") or p.suffix in TEXT_EXTS:
            noise = is_noise_path(rel) or (p.suffix in NOISE_TEXT_EXTS and "unknown/" in rel)
            h = scan_text(p)
            if p.suffix == ".smali":
                sh = scan_smali_flag_secure(p)
                if not noise:
                    heuristic_count += len(sh)
                h = sh + h
            if noise:
                for x in h:
                    x["noise"] = True
                    x["noise_reason"] = NOISE_REASON
                noise_hits += len(h)
        elif p.suffix == SO_EXT:
            h, _symcount = scan_so_file(p)
        else:
            continue
        if h:
            hits.append({"file": rel, "sha256": sha256(p), "hits": h})
        files_scanned += 1
    categories = aggregate_categories(hits)
    ctx = manifest_context(root)
    packers = detect_packers(root, ctx)
    hidden_dex = scan_hidden_dex(root)
    summary = build_summary(categories, packers, hidden_dex, heuristic_count)
    return {
        "schema_version": "capture-detection-3",
        "generated_at_epoch": time.time(),
        "root": str(root),
        "input_mode": "decoded_tree",
        "read_only": True,
        "files_scanned": files_scanned,
        "files_with_hits": len(hits),
        "noise_hits": noise_hits,
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
    ap.add_argument("root", help="decoded APK directory, or an .apk/.zip file (read-only container scan)")
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
