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
    return adb_command(adb_path, serial, "install", "-r", "--no-incremental", str(apk))


def uninstall_command(adb_path, serial, package_name):
    if not package_name:
        raise AdbDeployError("package name is required")
    return adb_command(adb_path, serial, "uninstall", package_name)


def is_signature_mismatch_error(message):
    """Identify Android's update-signature rejection without broad matching."""
    lowered = (message or "").lower()
    return (
        "install_failed_update_incompatible" in lowered
        and "signatures do not match" in lowered
    )


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


# --- Install diagnostics -----------------------------------------------------

INSTALL_REASON_CODES = (
    ("failed to extract native libraries", "NATIVE_LIB_EXTRACTION_FAILED",
     "Android rejected native library extraction: verify page alignment "
     "(zipalign -P 16), uncompressed .so entries (extractNativeLibs=false "
     "requires STORED), and ABI match"),
    ("install_failed_update_incompatible", "SIGNATURE_MISMATCH",
     "existing package is signed with a different certificate; guarded "
     "uninstall requires REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1"),
    ("install_failed_insufficient_storage", "INSUFFICIENT_STORAGE",
     "device storage is insufficient for the instrumented artifact"),
    ("install_failed_version_downgrade", "VERSION_DOWNGRADE",
     "artifact versionCode is lower than the installed package"),
    ("install_failed_invalid_apk", "INVALID_APK",
     "package manager rejected the APK structure"),
    ("install_parse_failed", "APK_PARSE_FAILED",
     "APK could not be parsed; rebuild may be corrupt"),
    ("incremental installation not allowed", "INCREMENTAL_INSTALL_REJECTED",
     "device rejected incremental install; a streamed install follows or "
     "--no-incremental must be used"),
)


def diagnose_install_failure(message):
    """Classify an install failure into an explicit reason code + hint."""
    lowered = (message or "").lower()
    codes = []
    for needle, code, hint in INSTALL_REASON_CODES:
        if needle in lowered:
            codes.append({"reason_code": code, "hint": hint})
    if not codes:
        return {"reason_code": "INSTALL_FAILED_UNCLASSIFIED",
                "hint": "message did not match a known failure class; see raw output",
                "matches": []}
    return {"reason_code": codes[0]["reason_code"],
            "hint": codes[0]["hint"],
            "matches": codes}


def _default_runner(command, timeout=120):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    return proc.returncode, (proc.stdout or "")


def artifact_preflight_checks(apk_path, runner=None, zipalign=None,
                              adb=None, serial=None):
    """Read-only pre-install verification of the instrumented artifact.

    Checks: zip entries for uncompressed native libs, lib ABI directories,
    optional zipalign page-alignment verification, and device ABI
    compatibility. Never modifies the APK; never touches original.apk.
    """
    import zipfile
    runner = runner or _default_runner
    apk = Path(apk_path)
    report = {"artifact": str(apk), "checks": {}, "status": "PASS"}
    if not apk.is_file():
        return {"artifact": str(apk), "checks": {}, "status": "ARTIFACT_MISSING"}

    try:
        with zipfile.ZipFile(apk) as zf:
            so_entries = [i for i in zf.infolist()
                          if i.filename.startswith("lib/") and i.filename.endswith(".so")]
            compressed = [i.filename for i in so_entries if i.compress_type != zipfile.ZIP_STORED]
            abis = sorted({i.filename.split("/")[1] for i in so_entries
                           if len(i.filename.split("/")) >= 3})
            report["checks"]["native_libs_uncompressed"] = {
                "status": "FAIL" if compressed else "PASS",
                "so_count": len(so_entries),
                "compressed_entries": compressed[:20],
            }
            report["checks"]["abi_directories"] = {"status": "PASS", "abis": abis}
    except zipfile.BadZipFile as exc:
        return {"artifact": str(apk), "checks": {"zip_parse": {"status": "FAIL", "error": str(exc)}},
                "status": "ARTIFACT_INVALID_ZIP"}

    if zipalign:
        rc, out = runner([zipalign, "-c", "-P", "16", "-v", "4", str(apk)], timeout=180)
        report["checks"]["zipalign_page_alignment"] = {
            "status": "PASS" if rc == 0 else "FAIL",
            "command": [zipalign, "-c", "-P", "16", "-v", "4", str(apk)],
            "returncode": rc,
            "output_tail": (out or "")[-1500:],
        }
    else:
        report["checks"]["zipalign_page_alignment"] = {
            "status": "SKIPPED", "reason": "zipalign binary not provided"}

    if adb and serial:
        rc, out = runner([adb, "-s", serial, "shell", "getprop",
                          "ro.product.cpu.abilist"], timeout=20)
        abilist = (out or "").strip()
        compatible = None
        if abilist:
            device_abis = [a.strip() for a in abilist.split(",") if a.strip()]
            apk_abis = report["checks"]["abi_directories"].get("abis", [])
            compatible = bool(set(device_abis) & set(apk_abis)) if apk_abis else None
        report["checks"]["abi_compatibility"] = {
            "status": "PASS" if compatible else ("FAIL" if compatible is False else "SKIPPED"),
            "device_abilist": abilist or None,
            "apk_abis": report["checks"]["abi_directories"].get("abis", []),
            "compatible": compatible,
        }

    for check in report["checks"].values():
        if check.get("status") == "FAIL":
            report["status"] = "PREFLIGHT_FAILED"
            break
    return report


def verify_installed_package(adb, serial, package, runner=None):
    """Post-install verification: installed path + versionCode (read-only)."""
    runner = runner or _default_runner
    rc, out = runner([adb, "-s", serial, "shell", "pm", "path", package], timeout=20)
    path = None
    for line in (out or "").splitlines():
        if line.startswith("package:"):
            path = line.split(":", 1)[1].strip()
            break
    version_code = None
    rc2, out2 = runner([adb, "-s", serial, "shell", "dumpsys", "package", package],
                       timeout=30)
    for line in (out2 or "").splitlines():
        if "versionCode=" in line:
            version_code = line.split("versionCode=", 1)[1].split()[0].strip()
            break
    return {
        "present": bool(path),
        "installed_path": path,
        "version_code": version_code,
        "status": "VERIFIED_INSTALLED" if path else "NOT_PRESENT_AFTER_INSTALL",
    }



def write_deploy_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
