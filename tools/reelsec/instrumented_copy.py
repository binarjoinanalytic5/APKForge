#!/usr/bin/env python3
"""Build an isolated decoded-APK copy for controlled instrumentation.

The original APK and original decoded tree are never modified by this module.
Only an explicit copied working tree may be changed.
"""
import hashlib
import json
import os
import re
from pathlib import Path
import shutil


class InstrumentedCopyError(RuntimeError):
    pass


# Causal-isolation experiment (2026-10-08): an explicit instrumentation mode
# that builds the instrumented tree WITHOUT Frida Gadget while keeping every
# other mutation (notably the LOG_I_PROBE telemetry marker) identical. The
# mode is selected with REELSEC_INSTRUMENT_MODE=no-gadget and is verified by
# finalize_no_gadget_manifest, which fails closed on ANY Gadget trace.
INSTRUMENT_MODES = ("standard", "no-gadget")
NO_GADGET_EXPERIMENT = "INSTRUMENTED_NO_GADGET"
GADGET_LIBRARY_NAMES = ("libfrida-gadget.so", "libfrida-gadget.config.so")
GADGET_SMALI_MARKERS = ("frida-gadget", "ReelSec-Gadget-Load")


def resolve_instrumentation_mode(env=None):
    """Resolve the instrumentation mode from the environment.

    Returns "standard" (default) or "no-gadget". Unknown values raise
    InstrumentedCopyError: a misconfigured isolation experiment must never
    run silently as something else.
    """
    values = env if env is not None else os.environ
    mode = str(values.get("REELSEC_INSTRUMENT_MODE", "standard")).strip().lower()
    if mode not in INSTRUMENT_MODES:
        raise InstrumentedCopyError(
            "unknown REELSEC_INSTRUMENT_MODE %r: expected one of %s"
            % (mode, ", ".join(INSTRUMENT_MODES))
        )
    return mode


def find_gadget_artifacts(work_dir):
    """Return a sorted list of Frida Gadget traces inside the work tree.

    An empty list means the tree is Gadget-free. Checks cover the native
    libraries, the Smali load markers, and the recorded mutations.
    """
    work = Path(work_dir).expanduser().resolve()
    violations = []
    if work.is_dir():
        for name in GADGET_LIBRARY_NAMES:
            for hit in sorted(work.rglob(name)):
                violations.append("file:%s" % hit.relative_to(work))
        for smali in sorted(work.rglob("*.smali")):
            try:
                text = smali.read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            for marker in GADGET_SMALI_MARKERS:
                if marker in text:
                    violations.append("smali:%s:marker:%s"
                                      % (smali.relative_to(work), marker))
    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    if manifest_path.is_file():
        try:
            manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        except ValueError:
            manifest = {}
        for mutation in manifest.get("mutations", []) or []:
            if isinstance(mutation, dict) and mutation.get("type") == "FRIDA_GADGET_EMBED":
                violations.append("mutation:FRIDA_GADGET_EMBED")
                break
    return sorted(set(violations))


def finalize_no_gadget_manifest(work_dir, gadget_requested=False,
                                gadget_source_ignored=None):
    """Verify and stamp a Gadget-free instrumented tree.

    Fails closed: raises InstrumentedCopyError when ANY Gadget artifact,
    marker, or recorded FRIDA_GADGET_EMBED mutation is present. On success
    the manifest carries the machine-readable isolation proof:
    GADGET_PRESENT=false, GADGET_SOURCE_ABSENT=true,
    original_apk_untouched=true. The stamp also records that causal
    attribution REQUIRES_TEMPORAL_COMPARISON: a healthy no-gadget run alone
    proves nothing about the cause of the Gadget-run crash.
    """
    work = Path(work_dir).expanduser().resolve()
    violations = find_gadget_artifacts(work)
    if violations:
        raise InstrumentedCopyError(
            "no-gadget experiment refused: Gadget traces present: %s"
            % ", ".join(violations)
        )
    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    if not manifest_path.is_file():
        raise InstrumentedCopyError("instrumented copy manifest missing")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["instrumentation_mode"] = "no-gadget"
    manifest["experiment"] = NO_GADGET_EXPERIMENT
    manifest["gadget_enabled"] = False
    manifest["GADGET_PRESENT"] = False
    manifest["GADGET_SOURCE_ABSENT"] = True
    manifest["original_apk_untouched"] = True
    manifest["gadget_refused_by_no_gadget_mode"] = bool(gadget_requested)
    if gadget_source_ignored:
        manifest["gadget_source_ignored"] = str(gadget_source_ignored)
    manifest["causal_attribution"] = "REQUIRES_TEMPORAL_COMPARISON"
    manifest["causal_attribution_note"] = (
        "A healthy INSTRUMENTED_NO_GADGET run alone establishes no causal "
        "claim about the Gadget-run crash. Attribution requires the "
        "session-bound temporal comparison against the Gadget baseline."
    )
    manifest_path.write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return manifest


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



