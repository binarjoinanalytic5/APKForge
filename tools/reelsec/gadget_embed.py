#!/usr/bin/env python3
"""Opt-in Frida Gadget embedding for isolated ReelSec instrumentation trees."""
import hashlib
import json
import re
import shutil
from pathlib import Path


class GadgetEmbedError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def _reserve_registers(text, anchor, count=2):
    starts = list(re.finditer(r"(?m)^[ \t]*\.method\b", text[:anchor.start()]))
    if not starts:
        raise GadgetEmbedError("containing method not found")
    start = starts[-1].start()
    end = re.search(r"(?m)^[ \t]*\.end method\b", text[anchor.end():])
    if not end:
        raise GadgetEmbedError("containing method end not found")
    method_end = anchor.end() + end.start()
    block = text[start:method_end]
    m = re.search(r"(?m)^(?P<p>[ \t]*)\.locals[ \t]+(?P<n>\d+)[ \t]*$", block)
    if m:
        base = int(m.group("n"))
        block = block[:m.start()] + m.group("p") + ".locals " + str(base + count) + block[m.end():]
    else:
        m = re.search(r"(?m)^(?P<p>[ \t]*)\.registers[ \t]+(?P<n>\d+)[ \t]*$", block)
        if not m:
            raise GadgetEmbedError("method register declaration not found")
        base = int(m.group("n"))
        block = block[:m.start()] + m.group("p") + ".registers " + str(base + count) + block[m.end():]
    return text[:start] + block + text[method_end:], base


def embed_frida_gadget(work_dir, target_smali, gadget_path, abi="arm64-v8a", port=27042):
    work = Path(work_dir).resolve()
    target = Path(target_smali).resolve()
    gadget = Path(gadget_path).expanduser().resolve()
    if not gadget.is_file():
        raise GadgetEmbedError("REELSEC_FRIDA_GADGET not found: %s" % gadget)
    try:
        target.relative_to(work)
    except ValueError:
        raise GadgetEmbedError("target is outside isolated instrumentation tree")

    lib_dir = work / "lib" / abi
    lib_dir.mkdir(parents=True, exist_ok=True)
    dst = lib_dir / "libfrida-gadget.so"
    shutil.copy2(gadget, dst)

    config = {
        "interaction": {
            "type": "listen",
            "address": "127.0.0.1",
            "port": int(port),
            "on_load": "resume",
        },
        "teardown": "minimal",
    }
    config_path = lib_dir / "libfrida-gadget.config.so"
    config_path.write_text(json.dumps(config, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    text = target.read_text(encoding="utf-8", errors="replace")
    if "ReelSec-Gadget-Load" in text:
        raise GadgetEmbedError("Gadget load marker already exists")
    pattern = re.compile(
        r"^(?P<i>[ \t]*)invoke-static[ \t]+\{[^}]+\},[ \t]*"
        r"Ljava/lang/System;->loadLibrary\(Ljava/lang/String;\)V[ \t]*$",
        re.MULTILINE,
    )
    match = pattern.search(text)
    if not match:
        raise GadgetEmbedError("loadLibrary anchor not found")

    updated, reg = _reserve_registers(text, match, count=2)
    match = pattern.search(updated)
    indent = match.group("i")
    replacement = (
        match.group(0).rstrip() + "\n"
        + indent + 'const-string v%d, "frida-gadget"\n' % reg
        + indent + 'invoke-static {v%d}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V\n' % reg
        + indent + 'const-string v%d, "ReelSec-Gadget-Load"\n' % reg
        + indent + 'const-string v%d, "loaded"\n' % (reg + 1)
        + indent + 'invoke-static {v%d, v%d}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I' % (reg, reg + 1)
    )
    target.write_text(updated[:match.start()] + replacement + updated[match.end():], encoding="utf-8")

    manifest_path = work / "INSTRUMENTED-COPY-MANIFEST.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest["status"] = "MUTATED"
    manifest.setdefault("mutations", []).append({
        "type": "FRIDA_GADGET_EMBED",
        "file": str(target.relative_to(work)),
        "library": str(dst.relative_to(work)),
        "library_sha256": sha256_file(dst),
        "config": str(config_path.relative_to(work)),
        "abi": abi,
        "listen": "127.0.0.1:%d" % int(port),
        "purpose": "guarded_runtime_observation",
        "original_apk_untouched": True,
    })
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return manifest
