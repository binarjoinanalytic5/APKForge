#!/usr/bin/env python3
"""Guarded deployment of ReelSec test artifacts to an explicit Android device."""
import json
import subprocess
from pathlib import Path


class AdbDeployError(RuntimeError):
    pass


def adb_command(adb_path, serial, *args):
    if not adb_path:
        raise AdbDeployError("ADB path is required")
    if not serial:
        raise AdbDeployError("explicit test-device serial is required")
    return [str(adb_path), "-s", str(serial), *map(str, args)]


def install_command(adb_path, serial, signed_apk):
    apk = Path(signed_apk).resolve()
    if not apk.is_file():
        raise AdbDeployError("signed APK is missing")
    return adb_command(adb_path, serial, "install", "-r", str(apk))


def uninstall_command(adb_path, serial, package_name):
    if not package_name:
        raise AdbDeployError("package name is required")
    return adb_command(adb_path, serial, "uninstall", package_name)


def device_check_command(adb_path, serial):
    return adb_command(adb_path, serial, "get-state")


def run_checked(command, timeout=120):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    if proc.returncode:
        raise AdbDeployError(
            "ADB command failed (%s): %s\n%s" %
            (proc.returncode, " ".join(command), proc.stdout[-4000:])
        )
    return proc.stdout


def write_deploy_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
