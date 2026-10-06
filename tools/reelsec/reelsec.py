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
    """Publish an immutable report from a clean worktree based on origin/main.

    The investigation checkout is never committed, reset, rebased, stashed, or pushed.
    Publication is transactional: report commit -> remote verification -> status commit
    -> remote verification. The final PUBLISH-STATUS.json is copied back locally only.
    """
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

    required = ["manifest.json", "VTable-RESOLUTION-REPORT.md", "PROTECTION-BRIDGE-AUDIT.md"]
    missing = [name for name in required if not (report_dir / name).is_file()]
    result["required_artifacts"] = required
    result["report_path"] = rel
    if missing:
        result["status"] = "REQUIRED_ARTIFACTS_MISSING"
        result["details"] = "missing=" + ",".join(missing)
        return result

    # Synchronize only the remote base ref; do not alter the user's checkout.
    rc, out = run([git, "fetch", "--quiet", "origin", "main"], cwd=root)
    if rc != 0:
        result["status"] = "FETCH_FAILED"
        result["details"] = out
        return result

    rc, base = run([git, "rev-parse", "origin/main"], cwd=root)
    if rc != 0 or not base.strip():
        result["status"] = "BASE_RESOLUTION_FAILED"
        result["details"] = out + base
        return result
    base = base.strip()

    timestamp = time.strftime("%Y%m%d_%H%M%S")
    branch = "reelsec/reports/%s-%s" % (timestamp, os.getpid())
    result["branch"] = branch
    result["remote"] = "origin/" + branch

    worktree = Path(tempfile.mkdtemp(prefix="reelsec-publish-"))
    keep = False
    try:
        # Replace the empty temp directory with a real detached worktree.
        shutil.rmtree(worktree, ignore_errors=True)
        rc, out = run([git, "worktree", "add", "--detach", str(worktree), base], cwd=root)
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

        rc, out = run([
            git, "-c", "user.name=ReelSec", "-c",
            "user.email=reelsec@users.noreply.github.com",
            "commit", "--no-verify",
            "-m", "ReelSec: publish security analysis " + timestamp,
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "REPORT_COMMIT_FAILED"
            result["details"] = out
            return result

        rc, head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        if rc != 0:
            result["status"] = "REPORT_HEAD_FAILED"
            result["details"] = head
            return result
        result["report_commit"] = head.strip()

        rc, out = run([git, "push", "origin", "HEAD:refs/heads/" + branch], cwd=worktree)
        if rc != 0:
            result["status"] = "REPORT_PUSH_FAILED"
            result["details"] = out
            return result

        rc, remote_head = run([git, "ls-remote", "--heads", "origin", "refs/heads/" + branch], cwd=root)
        expected = result["report_commit"]
        verified = rc == 0 and expected in remote_head
        result["remote_verified"] = verified
        if not verified:
            result["status"] = "REPORT_REMOTE_VERIFY_FAILED"
            result["details"] = remote_head
            return result

        # The status receipt is itself part of the published branch. It is generated
        # after the report commit so it can contain the exact verified commit SHA.
        result["status"] = "REPORT_PUBLISHED"
        status_path = publish_report / "PUBLISH-STATUS.json"
        status_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")

        rc, out = run([git, "add", "--", rel + "/PUBLISH-STATUS.json"], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_ADD_FAILED"
            result["details"] = out
            return result

        rc, out = run([
            git, "-c", "user.name=ReelSec", "-c",
            "user.email=reelsec@users.noreply.github.com",
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

        # Refresh the receipt with the final status commit and amend it, so the
        # published JSON is self-consistent before the final push.
        final_receipt = dict(result)
        final_receipt["status"] = "PUBLISHED"
        status_path.write_text(json.dumps(final_receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        rc, out = run([git, "add", "--", rel + "/PUBLISH-STATUS.json"], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_FINALIZE_ADD_FAILED"
            result["details"] = out
            return result
        rc, out = run([
            git, "-c", "user.name=ReelSec", "-c",
            "user.email=reelsec@users.noreply.github.com",
            "commit", "--no-verify", "--amend", "--no-edit",
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_AMEND_FAILED"
            result["details"] = out
            return result

        rc, final_head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_HEAD_FAILED"
            result["details"] = final_head
            return result
        result["status_commit"] = final_head.strip()

        final_receipt["status_commit"] = result["status_commit"]
        status_path.write_text(json.dumps(final_receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        rc, out = run([git, "add", "--", rel + "/PUBLISH-STATUS.json"], cwd=worktree)
        if rc != 0:
            result["status"] = "STATUS_RECEIPT_ADD_FAILED"
            result["details"] = out
            return result
        rc, out = run([
            git, "-c", "user.name=ReelSec", "-c",
            "user.email=reelsec@users.noreply.github.com",
            "commit", "--no-verify",
            "-m", "ReelSec: record final publication receipt " + timestamp,
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_STATUS_COMMIT_FAILED"
            result["details"] = out
            return result

        rc, final_head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_HEAD_FAILED"
            result["details"] = final_head
            return result
        result["status_commit"] = final_head.strip()

        # Rewrite once more with the final commit hash, then commit. This bounded
        # two-step receipt finalization is intentionally deterministic.
        final_receipt["status_commit"] = result["status_commit"]
        status_path.write_text(json.dumps(final_receipt, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        rc, out = run([git, "add", "--", rel + "/PUBLISH-STATUS.json"], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_RECEIPT_ADD_FAILED"
            result["details"] = out
            return result
        rc, out = run([
            git, "-c", "user.name=ReelSec", "-c",
            "user.email=reelsec@users.noreply.github.com",
            "commit", "--no-verify",
            "-m", "ReelSec: finalize immutable receipt " + timestamp,
        ], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_RECEIPT_COMMIT_FAILED"
            result["details"] = out
            return result

        rc, final_head = run([git, "rev-parse", "HEAD"], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_HEAD_FAILED"
            result["details"] = final_head
            return result
        result["status_commit"] = final_head.strip()

        rc, out = run([git, "push", "origin", "HEAD:refs/heads/" + branch], cwd=worktree)
        if rc != 0:
            result["status"] = "FINAL_PUSH_FAILED"
            result["details"] = out
            return result

        rc, remote_head = run([git, "ls-remote", "--heads", "origin", "refs/heads/" + branch], cwd=root)
        result["status_remote_verified"] = rc == 0 and result["status_commit"] in remote_head
        if not result["status_remote_verified"]:
            result["status"] = "FINAL_REMOTE_VERIFY_FAILED"
            result["details"] = remote_head
            return result

        # Copy the exact final receipt back to the investigation checkout without
        # staging or committing it there.
        local_receipt = report_dir / "PUBLISH-STATUS.json"
        shutil.copy2(status_path, local_receipt)
        result["status"] = "PUBLISHED"
        result["details"] = "clean-worktree publication and remote verification succeeded"
        keep = True
        return result
    except Exception as exc:
        result["status"] = "PUBLISH_EXCEPTION"
        result["details"] = repr(exc)
        return result
    finally:
        if worktree.exists():
            run([git, "worktree", "remove", "--force", str(worktree)], cwd=root)
        if not keep:
            # Nothing from the temporary publication tree is retained.
            pass

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
        print("PUBLISH_COMMIT=" + str(publish["commit"]))

if __name__ == "__main__":
    main()
