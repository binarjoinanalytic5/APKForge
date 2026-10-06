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
    method_matches = list(re.finditer(r"(?m)^[ 	]*\.method\b", text[:anchor_match.start()]))
    method_start = method_matches[-1].start() if method_matches else -1
    if method_start < 0:
        raise InstrumentedCopyError("containing .method declaration not found")
    end_match = re.search(r"(?m)^[ 	]*\.end method\b", text[anchor_match.end():])
    if not end_match:
        raise InstrumentedCopyError("containing .end method declaration not found")
    method_end = anchor_match.end() + end_match.start()
    block = text[method_start:method_end]

    locals_match = re.search(
        r"(?m)^(?P<prefix>[ 	]*)\.locals[ 	]+(?P<count>\d+)[ 	]*$",
        block,
    )
    if locals_match:
        base = int(locals_match.group("count"))
        replacement = locals_match.group("prefix") + ".locals " + str(base + count)
        block = block[:locals_match.start()] + replacement + block[locals_match.end():]
    else:
        registers_match = re.search(
            r"(?m)^(?P<prefix>[ 	]*)\.registers[ 	]+(?P<count>\d+)[ 	]*$",
            block,
        )
        if not registers_match:
            raise InstrumentedCopyError("method register declaration not found")
        base = int(registers_match.group("count"))
        replacement = registers_match.group("prefix") + ".registers " + str(base + count)
        block = block[:registers_match.start()] + replacement + block[registers_match.end():]
    return text[:method_start] + block + text[method_end:], base


def apply_text_probe(work_dir, target_smali):
    """Inject a harmless Log.i telemetry marker after the SecShell loadLibrary call.

    This is telemetry-only and never mutates the original APK.
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

    pattern = re.compile(
        r"^(?P<indent>[ 	]*)invoke-static[ 	]+\{(?P<registers>[^}]+)\},[ 	]*"
        r"Ljava/lang/System;->loadLibrary\(Ljava/lang/String;\)V[ 	]*$",
        re.MULTILINE,
    )
    match = pattern.search(text)
    if not match:
        raise InstrumentedCopyError("expected SecShell loadLibrary Smali invoke not found")

    original_registers = [x.strip() for x in match.group("registers").split(",") if x.strip()]
    updated, register_base = _reserve_probe_registers_in_method(text, match, 2)
    match = pattern.search(updated)
    if not match:
        raise InstrumentedCopyError("SecShell loadLibrary anchor disappeared after register update")

    probe_v0 = register_base
    probe_v1 = register_base + 1
    indent = match.group("indent")
    replacement = (
        match.group(0).rstrip() + "\n"
        + indent + 'const-string v%d, "ReelSec-Instrumentation"\n' % probe_v0
        + indent + 'const-string v%d, "SecShell loadLibrary reached"\n' % probe_v1
        + indent + 'invoke-static {v%d, v%d}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I'
          % (probe_v0, probe_v1)
    )
    updated = updated[:match.start()] + replacement + updated[match.end():]
    target.write_text(updated, encoding="utf-8")

    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    if not manifest_path.is_file():
        raise InstrumentedCopyError("instrumented copy manifest missing")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["status"] = "MUTATED"
    manifest["mutations"].append({
        "file": str(target.relative_to(work)),
        "type": "LOG_I_PROBE",
        "anchor": "Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V",
        "purpose": "telemetry_only",
        "registers_added": 2,
        "log_tag": "ReelSec-Instrumentation",
        "log_message": "SecShell loadLibrary reached",
        "matched_registers": original_registers,
    })
    manifest_path.write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return manifest



