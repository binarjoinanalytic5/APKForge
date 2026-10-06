#!/usr/bin/env python3
"""Controlled instrumentation planning and evidence collection.

This module deliberately separates planning from APK mutation and runtime proof.
It is Termux-friendly and does not install tools or modify the original APK.
"""
import hashlib
import json
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


def plan_secshell_injection(decoded_root, application_smali):
    """Return a deterministic, non-mutating injection plan for SecShell AW.attachBaseContext."""
    root = Path(decoded_root).expanduser().resolve()
    target = Path(application_smali).expanduser().resolve()
    if not target.is_file():
        return {
            "status": INSTRUMENTATION_BLOCKED,
            "reason": "application Smali target is missing",
            "target": str(target),
        }
    try:
        target.relative_to(root)
    except ValueError:
        return {
            "status": INSTRUMENTATION_BLOCKED,
            "reason": "target is outside decoded APK root",
            "target": str(target),
        }

    text = target.read_text(encoding="utf-8", errors="replace")
    if "System.loadLibrary" not in text or "SecShell" not in text:
        return {
            "status": INSTRUMENTATION_BLOCKED,
            "reason": "SecShell loadLibrary anchor not found",
            "target": str(target),
        }

    return {
        "status": INSTRUMENTATION_READY,
        "mode": "NON_MUTATING_PLAN",
        "target": str(target),
        "anchor": 'System.loadLibrary("SecShell")',
        "placement": "immediately_after_loadLibrary_before_normal_application_init",
        "runtime_proof": False,
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
