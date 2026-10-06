#!/usr/bin/env python3
"""Controlled instrumentation planning and evidence collection.

This module deliberately separates planning from APK mutation and runtime proof.
It is Termux-friendly and does not install tools or modify the original APK.
"""
import hashlib
import json
import re
import shlex
from pathlib import Path


INSTRUMENTATION_PLANNED = "PLANNED"
INSTRUMENTATION_READY = "READY"
INSTRUMENTATION_BLOCKED = "BLOCKED"
INSTRUMENTATION_FAILED = "FAILED"


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def _smali_class_name(text):
    for line in text.splitlines():
        stripped = line.strip()
        if stripped.startswith(".class "):
            parts = stripped.split()
            if parts:
                name = parts[-1]
                return name[1:-1] if name.startswith("L") and name.endswith(";") else name
    return None


def _find_loadlibrary_anchor(text):
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if "Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V" not in line:
            continue
        window = "\n".join(lines[max(0, i - 12):i + 1])
        if "SecShell" in window:
            return i, line.strip()
    return None, None


def find_secshell_application(decoded_root):
    """Discover a SecShell Application structurally instead of trusting a filename."""
    root = Path(decoded_root).expanduser().resolve()
    if not root.is_dir():
        return []
    candidates = []
    for path in sorted(root.glob("smali*/**/*.smali")):
        try:
            text = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        lower = text.lower()
        if "loadlibrary(Ljava/lang/String;)V" not in lower or "secshell" not in lower:
            continue
        has_application = ".super Landroid/app/Application;" in text
        has_attach = "attachBaseContext" in text
        line_no, anchor = _find_loadlibrary_anchor(text)
        score = (
            100 if has_application else 0
        ) + (
            50 if has_attach else 0
        ) + (
            25 if "com/SecShell/SecShell/" in text else 0
        ) + (
            10 if "SecShell-x86" in text else 0
        )
        if line_no is not None:
            candidates.append({
                "path": str(path),
                "relative_path": str(path.relative_to(root)),
                "class_name": _smali_class_name(text),
                "score": score,
                "is_application": has_application,
                "has_attach_base_context": has_attach,
                "loadlibrary_line": line_no + 1,
                "loadlibrary_anchor": anchor,
            })
    return sorted(candidates, key=lambda x: (-x["score"], x["relative_path"]))


def plan_secshell_injection(decoded_root, application_smali=None):
    """Locate SecShell's Application/loadLibrary anchor without relying on AW.smali naming."""
    root = Path(decoded_root).expanduser().resolve()
    if not root.is_dir():
        return {
            "status": INSTRUMENTATION_BLOCKED,
            "reason": "decoded APK root is missing",
        }

    if application_smali:
        targets = [Path(application_smali).expanduser().resolve()]
        try:
            targets[0].relative_to(root)
        except ValueError:
            return {
                "status": INSTRUMENTATION_BLOCKED,
                "reason": "target is outside decoded APK root",
            }
    else:
        discovered = find_secshell_application(root)
        targets = [Path(item["path"]).resolve() for item in discovered]

    candidates = []
    for target in targets:
        if not target.is_file():
            continue
        text = target.read_text(encoding="utf-8", errors="replace")
        line_no, anchor = _find_loadlibrary_anchor(text)
        if line_no is None:
            continue
        has_application = ".super Landroid/app/Application;" in text
        has_attach = "attachBaseContext" in text
        if not (has_application and has_attach):
            continue
        candidates.append({
            "target": str(target),
            "class_name": _smali_class_name(text),
            "loadlibrary_line": line_no + 1,
            "loadlibrary_anchor": anchor,
            "is_application": True,
            "has_attach_base_context": True,
        })

    if not candidates:
        return {
            "status": INSTRUMENTATION_BLOCKED,
            "reason": "SecShell Application/loadLibrary anchor not found by structural discovery",
            "candidate_count": len(targets),
        }

    chosen = candidates[0]
    return {
        "status": INSTRUMENTATION_READY,
        "mode": "NON_MUTATING_PLAN",
        "target": chosen["target"],
        "class_name": chosen["class_name"],
        "loadlibrary_line": chosen["loadlibrary_line"],
        "loadlibrary_anchor": chosen["loadlibrary_anchor"],
        "anchor": 'System.loadLibrary("SecShell")',
        "placement": "immediately_after_loadLibrary_before_normal_application_init",
        "runtime_proof": False,
        "discovery": "STRUCTURAL_CONTENT",
        "candidate_count": len(candidates),
        "candidates": candidates,
    }


def build_termux_preflight(environment):
    """Describe host/device prerequisites without installing or changing anything."""
    tools = environment.get("tools", {}) if isinstance(environment, dict) else {}
    adb = tools.get("adb", {})
    frida = tools.get("frida", {})
    return {
        "status": "READY" if adb.get("status") in ("USABLE", "AVAILABLE") else "BLOCKED",
        "adb": adb.get("status", "UNKNOWN"),
        "frida": frida.get("status", "UNKNOWN"),
        "frida_backend": frida.get("backend"),
        "requires_gadget": frida.get("classification") == "FRIDA_GADGET_REQUIRED",
        "mutates_original_apk": False,
    }


def build_observation_command(adb_path, package_name, device=None):
    """Build a passive logcat observation command for later Termux execution."""
    cmd = [adb_path]
    if device:
        cmd += ["-s", device]
    cmd += ["logcat", "-v", "threadtime"]
    return {
        "command": cmd,
        "shell": " ".join(shlex.quote(x) for x in cmd),
        "package": package_name,
        "observation_only": True,
    }


def write_plan(path, plan):
    p = Path(path).expanduser().resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(plan, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
