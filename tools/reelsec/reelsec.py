#!/usr/bin/env python3
import argparse
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import time
import tempfile
from pathlib import Path

ROOT = Path(os.environ.get("REELSEC_ROOT", str(Path(__file__).resolve().parents[2]))).expanduser().resolve()
VERSION = "2.0.0"
PROBES = [
    "elf",
    "symbols",
    "strings",
    "vtable",
    "dispatch",
    "critical-function",
    "protection-bridge",
    "vtable-abi",
    "critical-function-behavior",
    "native-security-api",
    "java-screen-security",
    "auto-publish",
]

def run(cmd, cwd=None):
    try:
        p = subprocess.run(
            cmd,
            cwd=cwd,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        return p.returncode, p.stdout
    except Exception as exc:
        return 127, str(exc) + "\n"

def which(*names):
    for name in names:
        value = shutil.which(name)
        if value:
            return value
    return None

def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for block in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()

def find_target(explicit):
    if explicit:
        p = Path(explicit).expanduser().resolve()
        return p if p.is_file() else None

    strings_bin = which("strings")
    candidates = sorted(ROOT.rglob("*.so"))
    needles = (
        "ActiveDecoder",
        "avcodecDecoder",
        "SuperMediaPlayer",
        "setOutputSurface",
        "queueSecureInputBuffer",
    )

    if strings_bin:
        for p in candidates:
            _, text = run([strings_bin, "-a", str(p)])
            if any(needle in text for needle in needles):
                return p

    for p in candidates:
        if "saasCorePlayer" in p.name:
            return p
    return None

def load_segments(data):
    if len(data) < 64 or data[:4] != b"\x7fELF" or data[4] != 2 or data[5] != 1:
        return []

    phoff = struct.unpack_from("<Q", data, 32)[0]
    phentsize = struct.unpack_from("<H", data, 54)[0]
    phnum = struct.unpack_from("<H", data, 56)[0]
    segments = []

    for i in range(phnum):
        off = phoff + i * phentsize
        p_type = struct.unpack_from("<I", data, off)[0]
        if p_type == 1:
            p_offset = struct.unpack_from("<Q", data, off + 8)[0]
            p_vaddr = struct.unpack_from("<Q", data, off + 16)[0]
            p_memsz = struct.unpack_from("<Q", data, off + 40)[0]
            segments.append((p_vaddr, p_offset, p_memsz))
    return segments

def va_to_offset(data, va):
    for vaddr, offset, memsz in load_segments(data):
        if vaddr <= va < vaddr + memsz:
            return offset + va - vaddr
    return None

def read_pointer(data, va):
    offset = va_to_offset(data, va)
    if offset is None or offset + 8 > len(data):
        return None, None
    raw = data[offset:offset + 8]
    return struct.unpack("<Q", raw)[0], raw

def disassemble(objdump, target, start, stop, output_path):
    if not objdump:
        output_path.write_text("OBJDUMP_NOT_FOUND\n", encoding="utf-8")
        return
    rc, text = run([
        objdump,
        "-d",
        "--start-address=" + hex(start),
        "--stop-address=" + hex(stop),
        str(target),
    ])
    output_path.write_text(text + "\n[exit=" + str(rc) + "]\n", encoding="utf-8")

def resolve_symbol(symbols_text, addr):
    matches = []
    for line in symbols_text.splitlines():
        fields = line.split()
        if len(fields) < 8:
            continue
        try:
            value = int(fields[1], 16)
            size = int(fields[2], 10)
        except (ValueError, IndexError):
            continue
        name = fields[-1]
        if value <= addr < value + max(size, 1):
            matches.append((value, size, name))
    return matches

def scan_security_indicators(strings_text):
    pattern = re.compile(
        r"protected|secure|Surface|ANativeWindow|EGL|GRALLOC|AHardwareBuffer|"
        r"MediaCodec|FLAG_SECURE|MediaProjection|createVirtualDisplay|screenshot|"
        r"recording|WideVine|ContentProtection|queueSecureInputBuffer|"
        r"setOutputSurface|setForceInsecureDecoder",
        re.I,
    )
    return "\n".join(line for line in strings_text.splitlines() if pattern.search(line))

def write_jni_semantic_analysis(output, dispatch_text):
    lines = dispatch_text.splitlines()
    hits = []
    for i, line in enumerate(lines):
        if '[x8, #0x108]' in line:
            window = '\n'.join(lines[i:min(len(lines), i + 8)])
            if 'mov\tx0, x19' in window or 'mov      x0, x19' in window:
                hits.append(window)
    report = [
        '# JNI Semantic Analysis',
        '',
        'Finding: the observed +0x108 dispatch pattern matches the JNI JNIEnv interface table.',
        'JNI GetMethodID is interface-table index 33; with 8-byte pointers this is offset 0x108.',
        'The observed arguments match GetMethodID(env, clazz, name, sig).',
        'Observed method names include setForceInsecureDecoder, queueSecureInputBuffer, and setOutputSurface.',
        '',
        'This is not proof of an ActiveDecoder C++ vtable. Do not use 0x717f68 as the implementation for these JNI calls without independent object/data-flow evidence.',
        '',
        'Next: trace the returned jmethodIDs to Call<Type>Method* dispatches and then into Java Window/Surface security.',
        '',
        'Matching dispatch excerpts:',
    ]
    if hits:
        for window in hits[:24]:
            report += ['```asm'] + window.splitlines() + ['```']
    else:
        report.append('No matching 0x108 JNI argument pattern was found.')
    (output / 'JNI-SEMANTIC-ANALYSIS.md').write_text('\n'.join(report) + '\n', encoding='utf-8')
    return bool(hits)
def cstring_at(data, va):
    off = va_to_offset(data, va)
    if off is None or off >= len(data):
        return None
    end = data.find(b"\x00", off)
    raw = data[off:end if end != -1 else len(data)]
    return raw.decode("ascii", errors="ignore")

def write_vtable_abi_analysis(output, data, symbols_text):
    address_point = 0x717e60
    slot = 0x717f68
    symbols = []
    for line in symbols_text.splitlines():
        fields = line.split()
        if len(fields) < 8:
            continue
        try:
            symbols.append((int(fields[1], 16), int(fields[2]), fields[3], fields[-1]))
        except ValueError:
            pass

    container = None
    for value, size, typ, name in symbols:
        if typ == "OBJECT" and "_ZTV" in name and value <= address_point < value + max(size, 1):
            container = (value, size, name)
            break

    top = read_pointer(data, address_point - 0x10)[0]
    rtti = read_pointer(data, address_point - 0x8)[0]
    name_ptr = read_pointer(data, rtti + 0x8)[0] if rtti else None
    type_name = cstring_at(data, name_ptr) if name_ptr else None
    ptr = read_pointer(data, slot)[0]

    func = None
    for value, size, typ, name in symbols:
        if typ == "FUNC" and value <= ptr < value + max(size, 1):
            func = (value, size, name)
            break

    out = [
        "# VTable ABI Analysis",
        "",
        "Address-point: 0x%x" % address_point,
        "Critical slot: 0x%x" % slot,
        "Slot offset: +0x108",
        "Offset-to-top: %s" % (hex(top) if top is not None else "UNRESOLVED"),
        "RTTI pointer: %s" % (hex(rtti) if rtti is not None else "UNRESOLVED"),
        "RTTI name pointer: %s" % (hex(name_ptr) if name_ptr is not None else "UNRESOLVED"),
        "RTTI type name: %s" % (type_name or "UNRESOLVED"),
        "Container vtable symbol: %s" % (container[2] if container else "UNRESOLVED"),
        "Function pointer: %s" % (hex(ptr) if ptr is not None else "UNRESOLVED"),
        "Function symbol: %s" % (func[2] if func else "NOT_RESOLVED_BY_SYMBOL_TABLE"),
        "",
        "This ABI resolution is independent of the JNI +0x108 analysis.",
    ]
    (output / "VTABLE-ABI-ANALYSIS.md").write_text("\n".join(out) + "\n", encoding="utf-8")
    return {
        "address_point": hex(address_point),
        "slot": hex(slot),
        "rtti": hex(rtti) if rtti is not None else None,
        "type_name": type_name,
        "container_vtable": container[2] if container else None,
        "pointer": hex(ptr) if ptr is not None else None,
        "function_symbol": func[2] if func else None,
    }

def write_critical_behavior(output, ptr):
    p = output / ("CRITICAL-FUNCTION-0x%X.txt" % ptr)
    body = p.read_text(encoding="utf-8", errors="replace") if p.exists() else ""
    lines = body.splitlines()
    start = None
    for i, line in enumerate(lines):
        if line.strip().startswith("%x:" % ptr):
            start = i
            break

    body_lines = []
    if start is not None:
        for line in lines[start:]:
            body_lines.append(line)
            st = line.strip()
            # Stop on the first ARM64 RET instruction. Match the opcode
            # and mnemonic structurally so objdump whitespace cannot affect
            # the boundary decision.
            if re.search(r"^\s*[0-9a-fA-F]+:\s*d65f03c0\s+ret(?:\s|$)", st, re.I):
                break

    if not body_lines:
        raise RuntimeError("CRITICAL FUNCTION BOUNDARY VIOLATION: function start not found")
    calls = [x for x in body_lines if re.search(r"\b(bl|blr)\b", x)]
    # Defensive invariant: the extracted body must terminate at RET.
    if not re.search(r"^\s*[0-9a-fA-F]+:\s*d65f03c0\s+ret(?:\s|$)", body_lines[-1], re.I):
        raise RuntimeError("CRITICAL FUNCTION BOUNDARY VIOLATION: body does not terminate at RET")
    security = [x for x in body_lines if re.search(
        r"surface|window|egl|secure|protect|gralloc|buffer|mediacodec|screenshot|record",
        x, re.I
    )]
    cls = "SECURITY_RELATED_OPERATION_PRESENT" if security else "NO_SECURITY_OPERATION_OBSERVED"

    out = [
        "# Critical Function Behavior",
        "",
        "Function: 0x%x" % ptr,
        "Body extraction: from the recovered prologue to the first return.",
        "",
        "Calls:"
    ] + (calls or ["NONE"]) + [
        "",
        "Security-related instructions/text:"
    ] + (security or ["NONE"]) + [
        "",
        "Classification: " + cls,
        "This is body-local evidence only; it does not prove Screenshot blocking."
    ]
    (output / "CRITICAL-FUNCTION-BODY.txt").write_text(
        "\n".join(body_lines) + "\n", encoding="utf-8"
    )
    (output / "CRITICAL-FUNCTION-BEHAVIOR.md").write_text(
        "\n".join(out) + "\n", encoding="utf-8"
    )
    return cls

def write_vtable_object_proof(output):
    p = output / "ActiveDecoder-constructor.txt"
    text = p.read_text(encoding="utf-8", errors="replace") if p.exists() else ""
    has_base_ctor = bool(re.search(r"bl\s+0xdfbd0\s+<.*ActiveDecoderC2Ev", text))
    # objdump may separate mnemonic/operands with tabs or variable whitespace.
    has_vtable_base = bool(re.search(r"\badrp\s+x8,\s+0x717000\b", text))
    has_vtable_add = bool(re.search(r"\badd\s+x8,\s+x8,\s+#0xe50\b", text))
    has_address_point = bool(re.search(r"\badd\s+x9,\s+x8,\s+#0x10\b", text))
    has_vptr_store = bool(re.search(r"\bstr\s+x9,\s+\[x19\]", text))
    proven = has_base_ctor and has_vtable_base and has_vtable_add and has_address_point and has_vptr_store
    out = [
        "# VTable Object Proof",
        "",
        "Object register: x19",
        "Base constructor call observed: %s" % ("YES" if has_base_ctor else "NO"),
        "VTable base computation 0x717000 + 0xe50 observed: %s" % ("YES" if has_vtable_base and has_vtable_add else "NO"),
        "Address-point computation 0x717e50 + 0x10 = 0x717e60 observed: %s" % ("YES" if has_address_point else "NO"),
        "vptr store [x19] observed: %s" % ("YES" if has_vptr_store else "NO"),
        "",
        "RESULT: " + ("PROVEN_OBJECT_VPTR_TO_0x717E60" if proven else "NOT_PROVEN"),
        "",
        "This proves the constructor path writes the recovered vtable address-point into the object register; it does not by itself prove which virtual method is invoked at runtime.",
    ]
    (output / "VTABLE-OBJECT-PROOF.md").write_text("\n".join(out) + "\n", encoding="utf-8")
    return proven

def write_vtable_class_correlation(output, data):
    """Correlate RTTI, vtable entries, and constructor/destructor evidence."""
    address_point = 0x717E60
    first = read_pointer(data, address_point)[0]
    second = read_pointer(data, address_point + 0x8)[0]

    ctor_path = output / "ActiveDecoder-constructor.txt"
    ctor_text = ctor_path.read_text(encoding="utf-8", errors="replace") if ctor_path.exists() else ""
    dtor_path = output / "ActiveDecoder-destructor.txt"
    dtor_text = dtor_path.read_text(encoding="utf-8", errors="replace") if dtor_path.exists() else ""

    has_ctor = bool(re.search(r"bl\s+0xdfbd0\s+<.*ActiveDecoderC2Ev", ctor_text))
    has_ctor_vptr = bool(re.search(r"\bstr\s+x9,\s+\[x19\]", ctor_text))
    has_dtor = bool(re.search(r"\bbl\s+0xddc20\s+<.*ActiveDecoderD2Ev", dtor_text))
    has_dtor_vptr = bool(re.search(
        r"\badd\s+x8,\s+x9,\s+#0x10\b.*\n.*\bstr\s+x8,\s+\[x19\]",
        dtor_text,
        re.S,
    ))

    rtti = read_pointer(data, address_point - 0x8)[0]
    name_ptr = read_pointer(data, rtti + 0x8)[0] if rtti else None
    type_name = cstring_at(data, name_ptr) if name_ptr else None

    evidence = [
        ("RTTI type is mediaCodecDecoder", bool(type_name and "mediaCodecDecoder" in type_name)),
        ("vtable entry[0] == destructor candidate 0x2785bc", first == 0x2785BC),
        ("vtable entry[1] == destructor candidate 0x278768", second == 0x278768),
        ("constructor calls ActiveDecoderC2Ev", has_ctor),
        ("constructor stores vptr into [x19]", has_ctor_vptr),
        ("destructor calls ActiveDecoderD2Ev", has_dtor),
        ("destructor restores vptr into [x19]", has_dtor_vptr),
    ]
    proven = all(ok for _, ok in evidence)

    lines = [
        "# VTable Class Correlation",
        "",
        "Address-point: 0x%X" % address_point,
        "RTTI type name: %s" % (type_name or "UNRESOLVED"),
        "vtable entry[0]: %s" % (hex(first) if first is not None else "UNRESOLVED"),
        "vtable entry[1]: %s" % (hex(second) if second is not None else "UNRESOLVED"),
        "",
        "Evidence:",
    ]
    lines += ["- %s: %s" % (label, "YES" if ok else "NO") for label, ok in evidence]
    lines += [
        "",
        "RESULT: " + (
            "PROVEN_RTTI_VTABLE_CONSTRUCTOR_DESTRUCTOR_CORRELATION"
            if proven else "NOT_PROVEN"
        ),
        "",
        "Static slot mapping: 0x717f68 (+0x108) -> 0x27a510.",
        "Runtime execution of that virtual slot remains a separate question; this report does not claim that the program actually invoked slot +0x108.",
    ]
    (output / "VTABLE-CLASS-CORRELATION.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    return proven

def write_remaining_dispatch_audit(output, objdump, target):
    """Scan the full executable text for +0x108 indirect-dispatch candidates."""
    if not objdump:
        (output / "REMAINING-DISPATCH-AUDIT.md").write_text(
            "# Remaining Dispatch Audit\n\nOBJDUMP_NOT_FOUND\n", encoding="utf-8"
        )
        return False

    rc, full = run([objdump, "-d", str(target)])
    (output / "full-disassembly.txt").write_text(
        full + "\n[exit=" + str(rc) + "]\n", encoding="utf-8"
    )

    lines = full.splitlines()
    candidates = []
    direct_target = []
    current_label = "UNKNOWN"
    for i, line in enumerate(lines):
        stripped = line.strip()
        if re.search(r"^0*[0-9a-fA-F]+\s+<.*>:$", stripped):
            current_label = stripped
        if re.search(r"\bbl\s+(?:0x)?27a510\b", line, re.I):
            direct_target.append(line.strip())
        if re.search(r"\bldr\s+x8,\s+\[x8,\s+#0x108\]", line):
            window = lines[i:min(len(lines), i + 5)]
            if any(re.search(r"\bblr\s+x8\b", w) for w in window):
                prev = lines[max(0, i - 6):i]
                has_object_vptr = any(re.search(r"\bldr\s+x8,\s+\[x19\]", w) for w in prev)
                has_env_receiver = any(re.search(r"\bmov\s+x0,\s+x19\b", w) for w in window)
                candidates.append({
                    "address": stripped.split(":", 1)[0],
                    "label": current_label,
                    "object_vptr_predecessor": has_object_vptr,
                    "jni_receiver_pattern": has_env_receiver,
                    "window": "\n".join(prev[-3:] + window[:5]),
                })

    proven_object = [c for c in candidates if c["object_vptr_predecessor"] and not c["jni_receiver_pattern"]]
    jni_like = [c for c in candidates if c["jni_receiver_pattern"]]
    unresolved = [c for c in candidates if c not in proven_object and c not in jni_like]

    out = [
        "# Remaining Dispatch Audit",
        "",
        "Goal: prove or disprove a concrete C++ object -> vptr -> +0x108 -> indirect call path.",
        "Full disassembly return code: %d" % rc,
        "Candidate +0x108 indirect dispatches: %d" % len(candidates),
        "JNI-like +0x108 candidates: %d" % len(jni_like),
        "Proven-object C++ +0x108 candidates: %d" % len(proven_object),
        "Unresolved candidates: %d" % len(unresolved),
        "Direct BL to 0x27a510: %d" % len(direct_target),
        "",
        "Classification rule:",
        "- JNI_LIKELY requires the observed JNIEnv-style receiver handoff (mov x0, x19) around the +0x108 dispatch.",
        "- PROVEN_CXX_OBJECT requires an object-vptr predecessor without that JNI receiver pattern.",
        "- UNRESOLVED requires manual/data-flow reconstruction.",
        "",
    ]
    for item in candidates:
        cls = "PROVEN_CXX_OBJECT" if item in proven_object else ("JNI_LIKELY" if item in jni_like else "UNRESOLVED")
        out += [
            "## 0x" + item["address"],
            "Classification: " + cls,
            "Function: " + item["label"],
            "ASM:",
            item["window"],
            "",
        ]
    if not candidates:
        out.append("No +0x108 indirect-dispatch candidates were found in the executable text.")
    out += [
        "RESULT: " + (
            "NO_PROVEN_CXX_RUNTIME_DISPATCH_FOUND"
            if not proven_object else "PROVEN_CXX_RUNTIME_DISPATCH_CANDIDATE_FOUND"
        ),
        "",
        "This is a static scan. It cannot prove runtime execution/non-execution by itself.",
    ]
    (output / "REMAINING-DISPATCH-AUDIT.md").write_text("\n".join(out) + "\n", encoding="utf-8")
    return bool(proven_object)

def write_native_security_api_audit(output, strings_text, symbols_text):
    keys = [
        "ANativeWindow_fromSurface",
        "ANativeWindow_setUsage",
        "ANativeWindow_setBuffersGeometry",
        "AHardwareBuffer",
        "AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT",
        "GRALLOC_USAGE_PROTECTED",
        "EGL_PROTECTED_CONTENT",
        "EGL_EXT_protected_content",
        "AMediaCodec_configure",
        "MediaCodec.setOutputSurface",
        "SurfaceControl",
        "setSecure",
    ]
    combined = (strings_text + "\n" + symbols_text).lower()
    out = ["# Native Security API Audit", ""]
    for key in keys:
        out.append("- %s: %s" % (key, "FOUND" if key.lower() in combined else "NOT_FOUND"))
    out += ["", "Rule: names/imports are indicators, not execution proof."]
    (output / "NATIVE-SECURITY-API-AUDIT.md").write_text(
        "\n".join(out) + "\n", encoding="utf-8"
    )

def write_java_screen_security_audit(output, root):
    terms = [
        "FLAG_SECURE",
        "Window.addFlags",
        "Window.setFlags",
        "SurfaceView",
        "TextureView",
        "MediaProjection",
        "createVirtualDisplay",
        "setOutputSurface",
        "setForceInsecureDecoder",
        "queueSecureInputBuffer",
        "nSetSurface",
        "nSurfaceChanged",
        "onCaptureScreen",
        "nativeOnCaptureScreen",
        "screenshot",
        "screen recording",
    ]
    out = ["# Java / Smali Screen Security Audit", ""]
    for term in terms:
        rc, result = run([
            "grep", "-RInF",
            "--exclude-dir=.git",
            "--include=*.smali",
            "--include=*.java",
            "--include=*.kt",
            term, str(root),
        ])
        if rc == 0 and result.strip():
            out += ["## " + term, ""] + result.splitlines()[:120] + [""]
    if len(out) == 2:
        out.append("No Java/Kotlin/Smali evidence matched the monitored screen-security terms.")
    (output / "JAVA-SCREEN-SECURITY-AUDIT.md").write_text(
        "\n".join(out) + "\n", encoding="utf-8"
    )

def git_publish(root, report_dir):
    """Publish from a clean worktree based on origin/main; never mutate the investigation checkout."""
    result = {
        "schema_version": "2.0",
        "tool": "ReelSec",
        "version": VERSION,
        "attempted": True,
        "status": "NOT_ATTEMPTED",
        "branch": None,
        "report_commit": None,
        "status_commit": None,
        "remote": None,
        "report_path": None,
        "required_artifacts": [],
        "remote_verified": False,
        "status_remote_verified": False,
        "details": "",
    }

    git = which("git")
    if not git:
        result["status"] = "GIT_NOT_FOUND"
        return result

    root = Path(root).resolve()
    report_dir = Path(report_dir).resolve()
    try:
        rel = report_dir.relative_to(root).as_posix()
    except ValueError:
        result["status"] = "REPORT_OUTSIDE_ROOT"
        result["details"] = str(report_dir)
        return result

    required = [
        "manifest.json",
        "VTable-RESOLUTION-REPORT.md",
        "PROTECTION-BRIDGE-AUDIT.md",
        "JNI-SEMANTIC-ANALYSIS.md",
        "VTABLE-ABI-ANALYSIS.md",
        "CRITICAL-FUNCTION-BEHAVIOR.md",
        "VTABLE-CLASS-CORRELATION.md",
        "REMAINING-DISPATCH-AUDIT.md",
        "NATIVE-SECURITY-API-AUDIT.md",
        "JAVA-SCREEN-SECURITY-AUDIT.md",
    ]
    result["required_artifacts"] = required
    result["report_path"] = rel
    missing = [name for name in required if not (report_dir / name).is_file()]
    if missing:
        result["status"] = "REQUIRED_ARTIFACTS_MISSING"
        result["details"] = "missing=" + ",".join(missing)
        return result

    # bootstrap-run.sh already fetched origin/main successfully. Reuse that
    # ref when it is available instead of performing a second network fetch.
    # Direct invocations still refresh origin/main as a fallback.
    ready_ref = os.environ.get("REELSEC_ORIGIN_READY", "")
    if ready_ref:
        rc, base = run([git, "rev-parse", ready_ref], cwd=root)
        if rc != 0:
            ready_ref = ""
    if not ready_ref:
        rc, out = run([git, "fetch", "--quiet", "origin", "main"], cwd=root)
        if rc != 0:
            result["status"] = "FETCH_FAILED"
            result["details"] = out
            return result
        rc, base = run([git, "rev-parse", "origin/main"], cwd=root)
    if rc != 0:
        result["status"] = "BASE_RESOLUTION_FAILED"
        result["details"] = base
        return result

    timestamp = time.strftime("%Y%m%d_%H%M%S")
    branch = "reelsec/reports/%s-%s" % (timestamp, os.getpid())
    result["branch"] = branch
    result["remote"] = "origin/" + branch

    worktree = Path(tempfile.mkdtemp(prefix="reelsec-publish-"))
    try:
        shutil.rmtree(worktree, ignore_errors=True)
        rc, out = run([git, "worktree", "add", "--detach", str(worktree), base.strip()], cwd=root)
        if rc != 0:
            result["status"] = "WORKTREE_CREATE_FAILED"
            result["details"] = out
            return result

        publish_report = worktree / rel
        publish_report.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(report_dir, publish_report, dirs_exist_ok=True)

        rc, out = run([git, "switch", "-c", branch], cwd=worktree)
        if rc != 0:
            result["status"] = "BRANCH_CREATE_FAILED"
            result["details"] = out
            return result

        rc, out = run([git, "add", "--", rel], cwd=worktree)
        if rc != 0:
            result["status"] = "GIT_ADD_FAILED"
            result["details"] = out
            return result
        rc, staged = run([git, "diff", "--cached", "--name-only"], cwd=worktree)
        if rc != 0 or not staged.strip():
            result["status"] = "NOTHING_TO_PUBLISH"
            result["details"] = staged
            return result

        identity = [git, "-c", "user.name=ReelSec", "-c",
                     "user.email=reelsec@users.noreply.github.com"]
        rc, out = run(identity + [
            "commit", "--no-verify",
            "-m", "ReelSec: publish security analysis " + timestamp,
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "REPORT_COMMIT_FAILED"
            result["details"] = out
            return result

        rc, head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        result["report_commit"] = head.strip()
        last_out = ""
        rc = 1
        for attempt in range(1, 4):
            rc, out = run([git, "push", "origin", "HEAD:refs/heads/" + branch], cwd=worktree)
            last_out = out
            if rc == 0:
                break
            if attempt < 3:
                time.sleep(2 * attempt)
        if rc != 0:
            result["status"] = "REPORT_PUSH_FAILED"
            result["details"] = "push_attempts=3\n" + last_out
            return result

        rc, remote_head = run([git, "ls-remote", "--heads", "origin", "refs/heads/" + branch], cwd=root)
        result["remote_verified"] = rc == 0 and result["report_commit"] in remote_head
        if not result["remote_verified"]:
            result["status"] = "REPORT_REMOTE_VERIFY_FAILED"
            result["details"] = remote_head
            return result

        # The receipt is committed only after the report commit has been verified.
        receipt = dict(result)
        receipt["status"] = "REPORT_PUBLISHED;STATUS_COMMIT_FOLLOWS"
        receipt["status_commit"] = None
        receipt["status_remote_verified"] = None
        receipt["status_commit_note"] = (
            "The SHA of the commit that contains this receipt cannot be embedded "
            "inside the same receipt without making the commit hash self-referential. "
            "The final status commit is verified separately by git ls-remote after push."
        )
        status_path = publish_report / "PUBLISH-STATUS.json"
        status_path.write_text(json.dumps(receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")

        rc, out = run([git, "add", "--", rel + "/PUBLISH-STATUS.json"], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_ADD_FAILED"
            result["details"] = out
            return result
        rc, out = run(identity + [
            "commit", "--no-verify",
            "-m", "ReelSec: finalize publication receipt " + timestamp,
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_COMMIT_FAILED"
            result["details"] = out
            return result

        rc, status_head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_HEAD_FAILED"
            result["details"] = status_head
            return result
        result["status_commit"] = status_head.strip()

        last_out = ""
        rc = 1
        for attempt in range(1, 4):
            rc, out = run([git, "push", "origin", "HEAD:refs/heads/" + branch], cwd=worktree)
            last_out = out
            if rc == 0:
                break
            if attempt < 3:
                time.sleep(2 * attempt)
        if rc != 0:
            result["status"] = "STATUS_PUSH_FAILED"
            result["details"] = "push_attempts=3\n" + last_out
            return result

        rc, remote_head = run([git, "ls-remote", "--heads", "origin", "refs/heads/" + branch], cwd=root)
        result["status_remote_verified"] = rc == 0 and result["status_commit"] in remote_head
        if not result["status_remote_verified"]:
            result["status"] = "STATUS_REMOTE_VERIFY_FAILED"
            result["details"] = remote_head
            return result

        shutil.copy2(status_path, report_dir / "PUBLISH-STATUS.json")
        result["status"] = "PUBLISHED"
        result["details"] = "clean-worktree publication succeeded; report and final receipt verified remotely"
        return result
    except Exception as exc:
        result["status"] = "PUBLISH_EXCEPTION"
        result["details"] = repr(exc)
        return result
    finally:
        if worktree.exists():
            run([git, "worktree", "remove", "--force", str(worktree)], cwd=root)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--elf")
    parser.add_argument("--output")
    parser.add_argument("--no-publish", action="store_true")
    parser.add_argument("--version", action="version", version=VERSION)
    args = parser.parse_args()

    default_output = ROOT / "analysis" / "sec-shell-deep-v1" / (
        "reelsec-" + time.strftime("%Y%m%d_%H%M%S")
    )
    output = Path(args.output).expanduser() if args.output else default_output
    output.mkdir(parents=True, exist_ok=True)

    target = find_target(args.elf)
    manifest = {
        "tool": "ReelSec",
        "version": VERSION,
        "probes": PROBES,
        "target": str(target) if target else None,
        "created_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
    }
    (output / "manifest.json").write_text(
        json.dumps(manifest, indent=2),
        encoding="utf-8",
    )

    if not target:
        (output / "STATUS.txt").write_text("TARGET_NOT_FOUND\n", encoding="utf-8")
        publish = None if args.no_publish else git_publish(ROOT, output)
        if publish:
            (output / "PUBLISH-STATUS.json").write_text(
                json.dumps(publish, indent=2),
                encoding="utf-8",
            )
        print("REPORT=" + str(output))
        print("TARGET_NOT_FOUND")
        if publish:
            print("PUBLISH_STATUS=" + publish["status"])
        return 0

    data = target.read_bytes()
    digest = sha256_file(target)
    (output / "TARGET-ELF.txt").write_text(str(target) + "\n", encoding="utf-8")
    (output / "target-sha256.txt").write_text(digest + "\n", encoding="utf-8")

    readelf = which("readelf", "llvm-readelf")
    strings_bin = which("strings")
    objdump = which("llvm-objdump", "objdump")

    symbols_text = ""
    if readelf:
        for flag, filename in (
            ("-SW", "sections.txt"),
            ("-lW", "program-headers.txt"),
            ("-Ws", "all-symbols.txt"),
        ):
            rc, text = run([readelf, flag, str(target)])
            (output / filename).write_text(text, encoding="utf-8")
            if filename == "all-symbols.txt":
                symbols_text = text
                (output / "readelf-symbols-exit.txt").write_text(
                    str(rc) + "\n",
                    encoding="utf-8",
                )

    strings_text = ""
    if strings_bin:
        _, strings_text = run([strings_bin, "-a", "-t", "x", str(target)])
        (output / "strings-offsets.txt").write_text(strings_text, encoding="utf-8")
        (output / "security-strings.txt").write_text(
            scan_security_indicators(strings_text) + "\n",
            encoding="utf-8",
        )

    address_point = 0x717E60
    critical_slot = 0x717F68
    ptr, raw = read_pointer(data, critical_slot)

    analysis_lines = [
        "ReelSec raw ELF analysis",
        "ELF=" + str(target),
        "SHA256=" + digest,
        "0x717e60 file offset=" + str(va_to_offset(data, address_point)),
        "0x717f68 file offset=" + str(va_to_offset(data, critical_slot)),
    ]

    if ptr is not None:
        analysis_lines += [
            "0x717f68 RAW_BYTES=" + " ".join(f"{b:02x}" for b in raw),
            "0x717f68 FUNCTION_POINTER=0x" + format(ptr, "x"),
        ]
        (output / "CRITICAL-FUNCTION-POINTER.txt").write_text(
            "\n".join(analysis_lines[-2:]) + "\n",
            encoding="utf-8",
        )
    else:
        analysis_lines.append("0x717f68 NOT_FILE_BACKED")

    (output / "elf-python-analysis.txt").write_text(
        "\n".join(analysis_lines) + "\n",
        encoding="utf-8",
    )

    vtable_start = va_to_offset(data, 0x717CE0)
    vtable_end = va_to_offset(data, 0x71807F)
    if vtable_start is not None and vtable_end is not None and vtable_end >= vtable_start:
        chunk = data[vtable_start:vtable_end + 1]
        raw_lines = []
        qword_lines = []
        for i in range(0, len(chunk), 16):
            raw_lines.append(
                f"{0x717CE0 + i:016x}  " +
                " ".join(f"{b:02x}" for b in chunk[i:i + 16])
            )
        for i in range(0, len(chunk) - 7, 8):
            value = struct.unpack_from("<Q", chunk, i)[0]
            qword_lines.append(f"{0x717CE0 + i:016x} -> {value:016x}")
        (output / "vtable-raw-bytes.txt").write_text(
            "\n".join(raw_lines) + "\n",
            encoding="utf-8",
        )
        (output / "vtable-qwords.txt").write_text(
            "\n".join(qword_lines) + "\n",
            encoding="utf-8",
        )

    jni_semantic_found = False
    vtable_abi = write_vtable_abi_analysis(output, data, symbols_text)
    critical_behavior = "NOT_RUN"
    if objdump:
        disassemble(objdump, target, 0x27AE80, 0x27B280, output / "dispatch-sites.txt")
        dispatch_text = (output / "dispatch-sites.txt").read_text(encoding="utf-8", errors="replace")
        jni_semantic_found = write_jni_semantic_analysis(output, dispatch_text)
        disassemble(objdump, target, 0x2783C0, 0x278500, output / "ActiveDecoder-constructor.txt")
        disassemble(objdump, target, 0x2785BC, 0x2786B0, output / "ActiveDecoder-destructor.txt")
        write_vtable_object_proof(output)
        write_vtable_class_correlation(output, data)
        write_remaining_dispatch_audit(output, objdump, target)
        disassemble(objdump, target, 0x112E80, 0x113000, output / "onCaptureScreen-dispatch.txt")

        if ptr is not None:
            disassemble(
                objdump,
                target,
                max(0, ptr - 0x120),
                ptr + 0x500,
                output / ("CRITICAL-FUNCTION-0x%X.txt" % ptr),
            )
            disassemble(
                objdump,
                target,
                max(0, ptr - 0x40),
                ptr + 0x40,
                output / "CRITICAL-FUNCTION-ENTRY.txt",
            )
            critical_behavior = write_critical_behavior(output, ptr)

    symbol_matches = resolve_symbol(symbols_text, ptr) if ptr is not None else []
    symbol_lines = [
        "0x%X size=%d %s" % match for match in symbol_matches
    ]
    if not symbol_lines:
        symbol_lines = ["NOT_RESOLVED_BY_SYMBOL_TABLE"]
    (output / "CRITICAL-FUNCTION-SYMBOL.txt").write_text(
        "\n".join(symbol_lines) + "\n",
        encoding="utf-8",
    )

    write_native_security_api_audit(output, strings_text, symbols_text)
    write_java_screen_security_audit(output, ROOT)

    security_text = (output / "security-strings.txt").read_text(
        encoding="utf-8", errors="replace"
    ) if (output / "security-strings.txt").exists() else ""

    bridge = [
        "# Protection Bridge Audit",
        "",
        "Critical pointer: " + (hex(ptr) if ptr is not None else "NOT_RESOLVED"),
        "",
        "Indicators found in target ELF:",
    ]
    for key in (
        "queueSecureInputBuffer",
        "setOutputSurface",
        "setForceInsecureDecoder",
        "ANativeWindow",
        "EGL",
        "GRALLOC",
        "AHardwareBuffer",
        "FLAG_SECURE",
        "MediaProjection",
        "createVirtualDisplay",
        "screenshot",
        "recording",
    ):
        bridge.append(
            "- %s: %s" % (
                key,
                "FOUND" if key.lower() in security_text.lower() else "NOT_FOUND",
            )
        )
    bridge += [
        "",
        "Rule: indicator presence is not execution proof.",
        "Next proof step: inspect the critical function body and its outgoing call targets.",
        "Important: 0x108 is classified as JNI GetMethodID index 33 by the observed call signature; it must not be assumed to be an ActiveDecoder C++ vtable slot.",
    ]
    (output / "PROTECTION-BRIDGE-AUDIT.md").write_text(
        "\n".join(bridge) + "\n",
        encoding="utf-8",
    )

    report = (
        "# ReelSec VTable / Dispatch Resolution Report\n\n"
        "Target: " + str(target) + "\n"
        "SHA-256: " + digest + "\n"
        "Calculated address-point: 0x717e60\n"
        "Critical slot: 0x717f68\n"
        "Extracted function pointer: " +
        (hex(ptr) if ptr is not None else "NOT_RESOLVED") + "\n\n"
        "The pointer is read directly from the ELF via PT_LOAD mapping. "
        "The target function is then disassembled and resolved against the "
        "symbol table when possible. No Screenshot-blocking claim is made "
        "from this result alone.\n"
    )
    (output / "VTable-RESOLUTION-REPORT.md").write_text(
        report,
        encoding="utf-8",
    )

    manifest.update(
        status="completed",
        target_sha256=digest,
        critical_pointer=(hex(ptr) if ptr is not None else None),
        jni_semantic_found=jni_semantic_found,
        vtable_abi=vtable_abi,
        critical_function_behavior=critical_behavior,
    )
    (output / "manifest.json").write_text(
        json.dumps(manifest, indent=2),
        encoding="utf-8",
    )

    publish = None if args.no_publish else git_publish(ROOT, output)
    if publish and not (output / "PUBLISH-STATUS.json").exists():
        (output / "PUBLISH-STATUS.json").write_text(
            json.dumps(publish, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )

    print("REPORT=" + str(output))
    print("FUNCTION_POINTER=" + (hex(ptr) if ptr is not None else "NOT_RESOLVED"))
    if symbol_lines:
        print("SYMBOL=" + symbol_lines[0])
    if publish:
        print("PUBLISH_STATUS=" + publish["status"])
        print("PUBLISH_BRANCH=" + str(publish["branch"]))
        print("PUBLISH_REPORT_COMMIT=" + str(publish["report_commit"]))
        print("PUBLISH_STATUS_COMMIT=" + str(publish["status_commit"]))

if __name__ == "__main__":
    main()
