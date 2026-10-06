#!/usr/bin/env python3
"""Build an isolated decoded-APK copy for controlled instrumentation.

The original APK and original decoded tree are never modified by this module.
Only an explicit copied working tree may be changed.
"""
import hashlib
import json
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


def apply_text_probe(work_dir, target_smali):
    """Inject a harmless log marker immediately after SecShell loadLibrary.

    This is telemetry-only: it does not disable, bypass, or alter a security decision.
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
    anchor = 'invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V'
    marker = 'const-string v0, "ReelSec-Instrumentation"\n'
    if marker in text:
        raise InstrumentedCopyError("instrumentation marker already present")
    if anchor not in text:
        raise InstrumentedCopyError("expected SecShell loadLibrary anchor not found")

    replacement = anchor + "\n    " + marker.rstrip() + "\n"
    updated = text.replace(anchor, replacement, 1)
    target.write_text(updated, encoding="utf-8")

    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    if not manifest_path.is_file():
        raise InstrumentedCopyError("instrumented copy manifest missing")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["status"] = "MUTATED"
    manifest["mutations"].append({
        "file": str(target.relative_to(work)),
        "type": "TEXT_MARKER",
        "anchor": "System.loadLibrary(SecShell)",
        "purpose": "telemetry_only",
    })
    manifest_path.write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return manifest
