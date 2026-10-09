"""Tool inventory: every tool probed exactly once per run.

Classification axes (spec section 4):
  role:   REQUIRED / OPTIONAL / PHASE_DEPENDENT / NOT_APPLICABLE
  status: AVAILABLE / MISSING / OUTDATED / INCOMPATIBLE / BROKEN
"""
from __future__ import annotations

import os
import re
import shutil
import subprocess
import sys
import time

ROLES = ("REQUIRED", "OPTIONAL", "PHASE_DEPENDENT",
         "NOT_APPLICABLE")
STATUSES = ("AVAILABLE", "MISSING", "OUTDATED", "INCOMPATIBLE",
            "BROKEN")

_KIND_TO_ROLE = {"required": "REQUIRED", "optional": "OPTIONAL",
                 "not-needed-phase1": "PHASE_DEPENDENT"}


def parse_version(text):
    match = re.search(r"(\d+)\.(\d+)(?:\.(\d+))?", text or "")
    if not match:
        return None
    return tuple(int(group or 0) for group in match.groups())


def role_of(kind):
    return _KIND_TO_ROLE.get(kind, "OPTIONAL")


def _run_version(argv, timeout=10):
    try:
        proc = subprocess.run(
            argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            timeout=timeout, text=True, errors="replace")
    except (OSError, subprocess.TimeoutExpired):
        return None, -1
    return parse_version(proc.stdout), proc.returncode


def probe(spec, env=None, timeout=10):
    """Probe one tool once. Never raises for missing tools."""
    name = spec["tool"]
    started = time.time()
    if name == "python3":
        version = tuple(sys.version_info[:3])
        return {"tool": name, "path": sys.executable,
                "detected": version,
                "detected_text": ".".join(
                    str(part) for part in version),
                "returncode": 0,
                "elapsed_ms": int((time.time() - started) * 1000)}
    if name == "pip":
        version, code = _run_version(
            [sys.executable, "-m", "pip", "--version"],
            timeout=timeout)
    else:
        path = shutil.which(name)
        if path is None:
            extra = (spec.get("detect") or [name])[0]
            path = shutil.which(extra) if extra != name else None
        if path is None:
            return {"tool": name, "path": None, "detected": None,
                    "detected_text": None, "returncode": -1,
                    "elapsed_ms": int((time.time() - started)
                                      * 1000)}
        version, code = _run_version(spec.get("detect") or [name],
                                     timeout=timeout)
    text = ".".join(str(part) for part in version) \
        if version else None
    return {"tool": name,
            "path": sys.executable if name == "pip"
            else shutil.which(name),
            "detected": version, "detected_text": text,
            "returncode": code,
            "elapsed_ms": int((time.time() - started) * 1000)}


def classify(spec, probed, platform_name=None, libc=None):
    """Status for one probed tool (pure)."""
    if platform_name and platform_name in (
            spec.get("not_on") or ()):
        return "NOT_APPLICABLE"
    need_libc = spec.get("needs_libc")
    if need_libc and libc and libc != need_libc:
        return "INCOMPATIBLE"
    if probed.get("path") is None:
        return "MISSING"
    version = probed.get("detected")
    if version is None and probed.get("returncode") != 0:
        return "BROKEN"
    minimum = spec.get("min")
    if version is not None and minimum is not None \
            and tuple(version) < tuple(minimum):
        return "OUTDATED"
    return "AVAILABLE"


def inventory(specs, fp=None, env=None):
    """Probe every spec exactly once; return classified rows."""
    platform_name = None
    libc = None
    if fp is not None:
        platform_name = "android-termux" if fp.get("termux") \
            else None
        libc = fp.get("libc")
    rows = []
    for spec in specs:
        probed = probe(spec, env=env)
        rows.append({
            "tool": spec["tool"], "role": role_of(spec["kind"]),
            "status": classify(spec, probed, platform_name, libc),
            "want": spec.get("want", ""),
            "detected": probed["detected_text"] or "-",
            "path": probed["path"],
            "min": ".".join(str(part) for part in spec["min"])
            if spec.get("min") else None,
            "method": spec.get("method", ""),
            "source": spec.get("source", ""),
            "elapsed_ms": probed["elapsed_ms"]})
    return rows


def summarize(rows):
    required = [row for row in rows
                if row["role"] == "REQUIRED"]
    return {
        "required_missing": [
            row["tool"] for row in required
            if row["status"] != "AVAILABLE"],
        "required_broken": [
            row["tool"] for row in required
            if row["status"] in ("BROKEN", "INCOMPATIBLE")],
        "optional_missing": [
            row["tool"] for row in rows
            if row["role"] == "OPTIONAL"
            and row["status"] == "MISSING"],
        "not_applicable": [
            row["tool"] for row in rows
            if row["status"] == "NOT_APPLICABLE"],
    }
