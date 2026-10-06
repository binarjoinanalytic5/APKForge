#!/usr/bin/env python3
"""Build an isolated decoded-APK copy for controlled instrumentation.

The original APK and original decoded tree are never modified by this module.
Only an explicit copied working tree may be changed.
"""
import hashlib
import json
import re
from pathlib import Path
import shutil


class InstrumentedCopyError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def prepare_instrumented_copy(decoded_root, work_dir):
    source = Path(decoded_root).expanduser().resolve()
    work = Path(work_dir).expanduser().resolve()
    if not source.is_dir():
        raise InstrumentedCopyError("decoded root does not exist")
    if work == source:
        raise InstrumentedCopyError("instrumented work tree cannot equal decoded source")
    if work.exists():
        raise InstrumentedCopyError("instrumented work tree already exists; refusing overwrite")

    work.parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(source, work)

    manifest = {
        "schema_version": 1,
        "status": "COPIED",
        "source_root": str(source),
        "work_root": str(work),
        "source_manifest_sha256": None,
        "mutations": [],
    }
    source_manifest = source / "AndroidManifest.xml"
    if source_manifest.is_file():
        manifest["source_manifest_sha256"] = sha256_file(source_manifest)
    (work / "INSTRUMENTED-COPY-MANIFEST.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return manifest


def _reserve_probe_registers_in_method(text, anchor_match, count=2):
    """Reserve registers in the method that contains the matched loadLibrary call."""
    method_matches = list(re.finditer(r"(?m)^\\s*\\.method\\b", text[:anchor_match.start()]))
    method_start = method_matches[-1].start() if method_matches else -1
    if method_start < 0:
        raise InstrumentedCopyError("containing .method declaration not found")
    method_end_match = re.search(r"(?m)^\\s*\\.end method\\b", text[anchor_match.end():])
    if not method_end_match:
        raise InstrumentedCopyError("containing .end method declaration not found")
    method_end = anchor_match.end() + method_end_match.start()
    block = text[method_start:method_end]
    local_match = re.search(r"(?m)^(?P<prefix>\\s*)\\.locals\\s+(?P<count>\\d+)\\s*$", block)
    if local_match:
        base = int(local_match.group("count"))
        new_count = base + count
        replacement = (
            local_match.group("prefix") + ".locals " + str(new_count)
        )
        block = block[:local_match.start()] + replacement + block[local_match.end():]
    else:
        registers_match = re.search(r"(?m)^(?P<prefix>\\s*)\\.registers\\s+(?P<count>\\d+)\\s*$", block)
        if not registers_match:
            raise InstrumentedCopyError("method register declaration not found")
        base = int(registers_match.group("count"))
        new_count = base + count
        replacement = (
            registers_match.group("prefix") + ".registers " + str(new_count)
        )
        block = block[:registers_match.start()] + replacement + block[registers_match.end():]
    updated = text[:method_start] + block + text[method_end:]
    return updated, base




def apply_text_probe(work_dir, target_smali):
    """Inject a harmless Log.i telemetry marker immediately after SecShell loadLibrary.

    The probe only records that the SecShell library-load point was reached in
    the isolated artifact. It does not disable, bypass, or alter a security
    decision and never mutates the original APK.
    """
    work = Path(work_dir).expanduser().resolve()
    target = Path(target_smali).expanduser().resolve()
    try:
        target.relative_to(work)
    except ValueError:
        raise InstrumentedCopyError("target is outside instrumented work tree")
    if not target.is_file():
        raise InstrumentedCopyError("instrumentation target is missing")

    text = target.read_text(encoding="utf-8", errors="replace")
    if "ReelSec-Instrumentation" in text:
        raise InstrumentedCopyError("instrumentation marker already present")

    lines = text.splitlines()
    anchor_index = None
    anchor_line = None
    for i, line in enumerate(lines):
        if "Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V" in line:
            anchor_index = i
            anchor_line = line.strip()
            break
    if anchor_index is None:
        raise InstrumentedCopyError("System.loadLibrary anchor not found")

    updated, register_base = _reserve_probe_registers(text, 2)
    probe_lines = updated.splitlines()
    # Re-find the same anchor after register declaration expansion.
    anchor_index = next(
        (i for i, line in enumerate(probe_lines)
         if "Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V" in line),
        None,
    )
    if anchor_index is None:
        raise InstrumentedCopyError("System.loadLibrary anchor disappeared after register update")

    probe_v0 = register_base
    probe_v1 = register_base + 1
    probe_lines[anchor_index + 1:anchor_index + 1] = [
        '    const-string v%d, "ReelSec-Instrumentation"' % probe_v0,
        '    const-string v%d, "SecShell loadLibrary reached"' % probe_v1,
        '    invoke-static {v%d, v%d}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I'
        % (probe_v0, probe_v1),
    ]
    updated = "\n".join(probe_lines) + ("\n" if text.endswith("\n") else "")
    target.write_text(updated, encoding="utf-8")


    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    if not manifest_path.is_file():
        raise InstrumentedCopyError("instrumented copy manifest missing")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["status"] = "MUTATED"
    manifest["mutations"].append({
        "file": str(target.relative_to(work)),
        "type": "LOG_I_PROBE",
        "anchor": "System.loadLibrary(SecShell)",
        "purpose": "telemetry_only",
        "registers_added": 2,
        "log_tag": "ReelSec-Instrumentation",
        "log_message": "SecShell loadLibrary reached",
    })
    manifest_path.write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return manifest
