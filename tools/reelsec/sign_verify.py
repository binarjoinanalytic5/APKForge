#!/usr/bin/env python3
"""Signing and identity gate for ReelSec test artifacts.

This module never signs the original APK. It requires an explicit isolated
artifact and an explicit signing backend/key configuration.
"""
import hashlib
import json
import subprocess
from pathlib import Path


class SignVerifyError(RuntimeError):
    pass


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def sign_command(apksigner, unsigned_apk, signed_apk, keystore, alias):
    for value, name in (
        (apksigner, "apksigner"), (unsigned_apk, "unsigned APK"),
        (signed_apk, "signed APK"), (keystore, "keystore"), (alias, "alias"),
    ):
        if not value:
            raise SignVerifyError("%s is required" % name)
    return [
        str(apksigner), "sign", "--ks", str(keystore),
        "--ks-key-alias", str(alias), "--out", str(signed_apk),
        str(unsigned_apk),
    ]


def verify_command(apksigner, signed_apk):
    if not apksigner or not signed_apk:
        raise SignVerifyError("apksigner and signed APK are required")
    return [str(apksigner), "verify", "--verbose", str(signed_apk)]


def artifact_identity(unsigned_apk, signed_apk):
    unsigned = Path(unsigned_apk).resolve()
    signed = Path(signed_apk).resolve()
    if not unsigned.is_file():
        raise SignVerifyError("unsigned artifact is missing")
    if not signed.is_file():
        raise SignVerifyError("signed artifact is missing")
    if unsigned == signed:
        raise SignVerifyError("signed artifact must be separate from unsigned artifact")
    return {
        "unsigned_path": str(unsigned),
        "unsigned_sha256": sha256_file(unsigned),
        "signed_path": str(signed),
        "signed_sha256": sha256_file(signed),
        "original_mutation": False,
    }


def run_checked(command, timeout=300):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    if proc.returncode:
        raise SignVerifyError(
            "command failed (%s): %s\n%s" %
            (proc.returncode, " ".join(command), proc.stdout[-4000:])
        )
    return proc.stdout


def write_sign_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
