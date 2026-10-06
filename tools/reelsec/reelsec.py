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
from pathlib import Path

ROOT = Path(os.environ.get("REELSEC_ROOT", str(Path(__file__).resolve().parents[2]))).expanduser().resolve()
VERSION = "1.2.0"
PROBES = [
    "elf",
    "symbols",
    "strings",
    "vtable",
    "dispatch",
    "critical-function",
    "protection-bridge",
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

def git_publish(root, report_dir):
    result = {
        "attempted": True,
        "status": "NOT_ATTEMPTED",
        "branch": None,
        "commit": None,
        "remote": None,
        "details": "",
    }

    git = which("git")
    if not git:
        result["status"] = "GIT_NOT_FOUND"
        return result

    rel = report_dir.relative_to(root).as_posix()
    timestamp = time.strftime("%Y%m%d_%H%M%S")
    branch = "reelsec/reports/" + timestamp
    result["branch"] = branch

    rc, out = run([git, "status", "--porcelain"], cwd=root)
    if rc != 0:
        result["status"] = "GIT_STATUS_FAILED"
        result["details"] = out
        return result

    # Only stage the newly-created report directory. Never stage unrelated work.
    rc, out = run([git, "add", "--", rel], cwd=root)
    if rc != 0:
        result["status"] = "GIT_ADD_FAILED"
        result["details"] = out
        return result

    rc, staged = run([git, "diff", "--cached", "--name-only"], cwd=root)
    if rc != 0 or not staged.strip():
        result["status"] = "NOTHING_TO_PUBLISH"
        result["details"] = staged
        return result

    rc, out = run([
        git, "-c", "user.name=ReelSec", "-c", "user.email=reelsec@users.noreply.github.com",
        "commit", "--no-verify",
        "-m", "ReelSec: automated security analysis " + timestamp,
    ], cwd=root)
    if rc != 0:
        result["status"] = "GIT_COMMIT_FAILED"
        result["details"] = out
        return result

    rc, head = run([git, "rev-parse", "HEAD"], cwd=root)
    commit = head.strip()
    result["commit"] = commit

    # Push the report commit to a unique branch so an unrelated/divergent local
    # history can never overwrite origin/main.
    rc, out = run([
        git, "push", "-u", "origin",
        "HEAD:refs/heads/" + branch,
    ], cwd=root)
    if rc == 0:
        result["status"] = "PUBLISHED"
        result["remote"] = "origin/" + branch
        result["details"] = out
        return result

    result["status"] = "COMMITTED_PUSH_FAILED"
    result["details"] = out
    return result

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

    if objdump:
        disassemble(objdump, target, 0x27AE80, 0x27B280, output / "dispatch-sites.txt")
        disassemble(objdump, target, 0x2783C0, 0x278500, output / "ActiveDecoder-constructor.txt")
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
    ]
    (output / "PROTECTION-BRIDGE-AUDIT.md").write_text(
        "\n".join(bridge) + "\n",
        encoding="utf-8",
    )

    report = (
        "# ReelSec VTable Resolution Report\n\n"
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
    )
    (output / "manifest.json").write_text(
        json.dumps(manifest, indent=2),
        encoding="utf-8",
    )

    publish = None if args.no_publish else git_publish(ROOT, output)
    if publish:
        (output / "PUBLISH-STATUS.json").write_text(
            json.dumps(publish, indent=2),
            encoding="utf-8",
        )

        # Publish the status as a second ordinary commit. Never force-push.
        status_rel = (output / "PUBLISH-STATUS.json").relative_to(ROOT).as_posix()
        git_bin = which("git")
        run([git_bin, "add", "--", status_rel], cwd=ROOT)
        rc2, out2 = run([
            git_bin, "-c", "user.name=ReelSec", "-c", "user.email=reelsec@users.noreply.github.com",
            "commit", "--no-verify",
            "-m", "ReelSec: record publication status " + time.strftime("%Y%m%d_%H%M%S"),
        ], cwd=ROOT)
        if rc2 == 0:
            run([git_bin, "push", "origin", "HEAD:refs/heads/" + publish["branch"]], cwd=ROOT)

    print("REPORT=" + str(output))
    print("FUNCTION_POINTER=" + (hex(ptr) if ptr is not None else "NOT_RESOLVED"))
    if symbol_lines:
        print("SYMBOL=" + symbol_lines[0])
    if publish:
        print("PUBLISH_STATUS=" + publish["status"])
        print("PUBLISH_BRANCH=" + str(publish["branch"]))
        print("PUBLISH_COMMIT=" + str(publish["commit"]))

if __name__ == "__main__":
    main()
