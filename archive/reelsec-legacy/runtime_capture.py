#!/usr/bin/env python3
"""Passive runtime evidence capture for a ReelSec test artifact."""
import hashlib
import json
import subprocess
import time
from pathlib import Path


class RuntimeCaptureError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def adb_command(adb_path, serial, *args):
    if not adb_path or not serial:
        raise RuntimeCaptureError("ADB path and explicit device serial are required")
    return [str(adb_path), "-s", str(serial), *map(str, args)]


def run_capture(command, timeout=60):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    return {
        "command": command,
        "returncode": proc.returncode,
        "output": proc.stdout,
    }


def capture_snapshot(adb_path, serial, package_name):
    if not package_name:
        raise RuntimeCaptureError("package name is required")
    commands = {
        "state": adb_command(adb_path, serial, "get-state"),
        "package_path": adb_command(adb_path, serial, "shell", "pm", "path", package_name),
        "process": adb_command(
            adb_path, serial, "shell", "sh", "-c",
            "ps -A | grep -F %s || true" % package_name,
        ),
        "logcat_tail": adb_command(
            adb_path, serial, "logcat", "-d", "-t", "250", "-v", "threadtime",
        ),
    }
    return {
        "schema_version": 1,
        "captured_at_epoch": time.time(),
        "device_serial": serial,
        "package": package_name,
        "observations": {name: run_capture(cmd) for name, cmd in commands.items()},
    }


def bind_artifact(snapshot, artifact_path):
    artifact = Path(artifact_path).resolve()
    if not artifact.is_file():
        raise RuntimeCaptureError("artifact is missing")
    result = dict(snapshot)
    result["artifact"] = {
        "path": str(artifact),
        "sha256": sha256_file(artifact),
    }
    result["evidence_class"] = "OBSERVED"
    result["causal_proof"] = False
    return result


def write_snapshot(path, snapshot):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(snapshot, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
