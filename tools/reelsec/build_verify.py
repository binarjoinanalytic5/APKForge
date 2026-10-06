#!/usr/bin/env python3
"""Build/sign/verify gate for an isolated ReelSec artifact."""
import hashlib
import json
import subprocess
from pathlib import Path


class BuildVerifyError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def run_checked(command, cwd=None, timeout=300):
    proc = subprocess.run(
        command, cwd=str(cwd) if cwd else None,
        text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        timeout=timeout, check=False,
    )
    if proc.returncode:
        raise BuildVerifyError(
            "command failed (%s): %s\n%s" %
            (proc.returncode, " ".join(command), proc.stdout[-4000:])
        )
    return proc.stdout


def apktool_build_command(selection, decoded_root, output_apk):
    root = Path(decoded_root).resolve()
    output = Path(output_apk).resolve()
    backend = selection.get("backend")
    if backend == "cli":
        return [selection["path"], "b", str(root), "-o", str(output)]
    if backend == "java-classpath":
        java = selection.get("path")
        cp = selection.get("classpath")
        if not java or not cp:
            raise BuildVerifyError("standalone Apktool metadata incomplete")
        return [java, "-cp", cp, "brut.apktool.Main", "b", str(root), "-o", str(output)]
    raise BuildVerifyError("unsupported Apktool backend: %r" % backend)


def verify_artifact(path):
    apk = Path(path).resolve()
    if not apk.is_file():
        raise BuildVerifyError("built APK is missing")
    if apk.stat().st_size == 0:
        raise BuildVerifyError("built APK is empty")
    return {
        "status": "BUILT",
        "path": str(apk),
        "size": apk.stat().st_size,
        "sha256": sha256_file(apk),
    }


def write_build_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
