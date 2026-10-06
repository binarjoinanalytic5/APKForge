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


def devices_command(adb_path):
    """Return the command used to enumerate current ADB device records."""
    if not adb_path:
        raise AdbDeployError("ADB path is required")
    return [str(adb_path), "devices", "-l"]


def _parse_devices_output(output):
    """Parse only online ADB devices from `adb devices -l` output."""
    records = []
    for raw in (output or "").splitlines():
        line = raw.strip()
        if not line or line.lower().startswith("list of devices attached"):
            continue
        parts = line.split()
        if len(parts) < 2 or parts[1] != "device":
            continue
        attributes = {}
        for token in parts[2:]:
            if ":" not in token:
                continue
            key, value = token.split(":", 1)
            if key and value:
                attributes[key] = value
        records.append({
            "serial": parts[0],
            "state": parts[1],
            "attributes": attributes,
            "raw": line,
        })
    return records


def resolve_test_device(adb_path, configured_serial=None):
    """Resolve a safe test-device serial against the current ADB state.

    Explicit serials are preferred. If the configured serial is stale but the
    current ADB inventory contains exactly one online device, ReelSec may
    safely rebind to that single device and records the rebinding decision.
    Multiple online devices never trigger implicit selection.
    """
    requested = (configured_serial or "").strip()
    inventory_cmd = devices_command(adb_path)
    proc = subprocess.run(
        inventory_cmd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        timeout=30,
        check=False,
    )
    if proc.returncode:
        raise AdbDeployError(
            "ADB device inventory failed (%s): %s\n%s" %
            (proc.returncode, " ".join(inventory_cmd), (proc.stdout or "")[-4000:])
        )

    online = _parse_devices_output(proc.stdout)
    serials = [item["serial"] for item in online]

    if requested and requested.lower() != "auto":
        if requested in serials:
            return {
                "serial": requested,
                "requested_serial": requested,
                "resolution": "EXPLICIT_MATCH",
                "online_devices": serials,
                "inventory_command": inventory_cmd,
            }
        if len(online) == 1:
            selected = online[0]["serial"]
            return {
                "serial": selected,
                "requested_serial": requested,
                "resolution": "AUTO_REBOUND_SINGLE_ONLINE_DEVICE",
                "online_devices": serials,
                "inventory_command": inventory_cmd,
            }
        raise AdbDeployError(
            "configured test device %r is not online; current online devices=%s; "
            "refusing implicit selection when zero or multiple candidates exist"
            % (requested, serials)
        )

    if len(online) == 1:
        selected = online[0]["serial"]
        return {
            "serial": selected,
            "requested_serial": requested or None,
            "resolution": "AUTO_SINGLE_ONLINE_DEVICE",
            "online_devices": serials,
            "inventory_command": inventory_cmd,
        }
    raise AdbDeployError(
        "REELSEC_TEST_DEVICE=auto requires exactly one online device; "
        "current online devices=%s" % serials
    )


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
