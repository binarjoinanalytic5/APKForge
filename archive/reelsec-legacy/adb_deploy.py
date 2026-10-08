#!/usr/bin/env python3
"""Guarded deployment of ReelSec test artifacts to an explicit Android device."""
import hashlib
import json
import re
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
     "existing package is signed with a different certificate; the "
     "non-destructive install path stops here — replacing the installed "
     "package requires an explicit hash-bound destructive authorization "
     "document (REELSEC_DESTRUCTIVE_AUTH), never a blanket env flag"),
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


def package_state_snapshot(adb, serial, package, runner=None):
    """READ-ONLY package-state snapshot around an install (timeline truth).

    Captures the fields that prove WHAT the install changed: codePath,
    uid, versionName, installed users (a dual-app profile is user 95 of
    the SAME package, not a separate APK), and the PackageManager
    firstInstallTime/lastUpdateTime stamps. Missing fields stay None.
    """
    runner = runner or _default_runner
    rc, out = runner([adb, "-s", serial, "shell", "dumpsys", "package",
                      package], timeout=30)
    text = out if rc == 0 else ""

    def _one(pattern):
        m = re.search(pattern, text or "")
        return m.group(1) if m else None

    users = sorted({int(m.group(1)) for m in re.finditer(
        r"User (\d+):[^\n]*installed=true", text or "")})
    return {
        "present": bool(_one(r"codePath=(\S+)")),
        "code_path": _one(r"codePath=(\S+)"),
        "uid": _one(r"userId=(\d+)"),
        "version_name": _one(r"versionName=(\S+)"),
        "users_installed": users,
        "first_install_time": (_one(r"firstInstallTime=(.+)") or "").strip()
                              or None,
        "last_update_time": (_one(r"lastUpdateTime=(.+)") or "").strip()
                            or None,
        "source": "adb:dumpsys package %s" % package,
    }


def build_install_semantics(before, after):
    """Explicit replacement semantics for the shared-APK install model.

    Android keeps ONE base.apk per package shared by ALL users (user 0 and
    the dual-app user 95). `adb install -r` therefore REPLACES the build
    for every user at once — the original and the instrumented artifact
    can never coexist. This record makes that structural fact auditable
    and forbids the misleading reading of post-replacement crashes:
    whatever crashes after this point — on any user, including the
    dual-app profile — is the NEW artifact, never the replaced build.
    """
    before = before or {}
    after = after or {}
    replaced = bool(before.get("present"))
    users = after.get("users_installed") or before.get("users_installed") or []
    return {
        "mode": "REPLACE_SHARED_APK" if replaced else "FRESH_INSTALL",
        "replaced_existing_build": replaced,
        "shared_apk_users": users,
        "code_path_before": before.get("code_path"),
        "code_path_after": after.get("code_path"),
        "last_update_time_before": before.get("last_update_time"),
        "last_update_time_after": after.get("last_update_time"),
        "guard": (
            "Android keeps ONE base.apk per package shared by all users "
            "(e.g. user 0 and dual-app user %s). This install %s that "
            "single shared APK for ALL listed users at once: after this "
            "point every launch on ANY user runs the NEW artifact. "
            "Crashes observed after this point — on any user, including "
            "the dual-app profile — belong to the NEW artifact and are "
            "NEVER evidence that the replaced build crashes by itself."
            % (", ".join(str(u) for u in users) if users else "N",
               "REPLACED" if replaced else "installed")),
    }



def artifact_integrity_gate(apk_path, runner=None, adb=None, serial=None,
                            package=None, expected_so=None, apksigner=None,
                            manifest_decoder=None, preflight=None):
    """Artifact Integrity Gate (pre-runtime). Read-only.

    Verifies, without modifying anything: signing presence (META-INF blocks +
    optional apksigner verify), package identity, expected native library
    presence, native library compression, alignment/ABI (reuses the preflight
    report when supplied), installed path identity via pm path, and installed
    versionCode. Any FAIL blocks runtime; the caller must not proceed to the
    process health gate or the probe on failure.
    """
    import zipfile
    runner = runner or _default_runner
    apk = Path(apk_path)
    gate = {"artifact": str(apk), "checks": {}, "status": "PASS"}
    if not apk.is_file():
        return {"artifact": str(apk), "checks": {}, "status": "ARTIFACT_MISSING"}
    try:
        with zipfile.ZipFile(apk) as zf:
            names = zf.namelist()
            sig = [n for n in names if n.upper().startswith("META-INF/")
                   and n.upper().endswith((".RSA", ".DSA", ".EC"))]
            gate["checks"]["signing_present"] = {
                "status": "PASS" if sig else "FAIL",
                "signature_blocks": sig[:5],
            }
            so_entries = sorted(n for n in names
                                if n.startswith("lib/") and n.endswith(".so"))
            compressed = [n for n in so_entries
                          if zf.getinfo(n).compress_type != zipfile.ZIP_STORED]
            gate["checks"]["native_libs_uncompressed"] = {
                "status": "FAIL" if compressed else "PASS",
                "so_count": len(so_entries),
                "compressed_entries": compressed[:20],
            }
            if expected_so is not None:
                have = {n.rsplit("/", 1)[-1] for n in so_entries}
                missing = sorted(set(expected_so) - have)
                gate["checks"]["expected_native_libs"] = {
                    "status": "FAIL" if missing else "PASS",
                    "expected": sorted(expected_so),
                    "missing": missing,
                }
            if manifest_decoder is not None and package:
                # package_identity is three-state. A PROVEN mismatch (decoder
                # read a different package) blocks; an UNVERIFIABLE identity
                # (decoder error or no result — e.g. apktool-rebuilt manifests
                # our minimal AXML decoder cannot parse) is recorded and does
                # NOT block: identity is enforced by the install itself and by
                # post-install verification, never assumed from a decode
                # failure.
                try:
                    decoded = manifest_decoder(zf.read("AndroidManifest.xml"))
                except Exception as exc:
                    decoded = None
                    gate["checks"]["package_identity"] = {
                        "status": "UNVERIFIED",
                        "reason": "manifest decoder error: %s" % str(exc)[:200],
                        "expected_package": package}
                else:
                    if not decoded:
                        gate["checks"]["package_identity"] = {
                            "status": "UNVERIFIED",
                            "reason": ("manifest package unreadable by the "
                                       "built-in decoder (no result); identity "
                                       "will be verified at install and "
                                       "post-install"),
                            "expected_package": package}
                    else:
                        gate["checks"]["package_identity"] = {
                            "status": "PASS" if decoded == package else "FAIL",
                            "expected_package": package,
                            "decoded_package": decoded,
                        }
    except zipfile.BadZipFile as exc:
        return {"artifact": str(apk),
                "checks": {"zip_parse": {"status": "FAIL", "error": str(exc)}},
                "status": "ARTIFACT_INVALID_ZIP"}

    if apksigner:
        rc, out = runner([str(apksigner), "verify", "--verbose", str(apk)],
                         timeout=120)
        gate["checks"]["apksigner_verify"] = {
            "status": "PASS" if rc == 0 else "FAIL",
            "returncode": rc,
            "output_tail": (out or "")[-1200:],
        }
    else:
        gate["checks"]["apksigner_verify"] = {
            "status": "SKIPPED", "reason": "apksigner not provided"}

    if preflight:
        gate["checks"]["preflight_alignment_abi"] = {
            "status": "PASS" if preflight.get("status") == "PASS" else "FAIL",
            "preflight_status": preflight.get("status"),
        }

    if adb and serial and package:
        # installed_identity is three-state. This gate runs BEFORE install:
        # "package not currently installed" is the normal fresh-install path,
        # NOT an integrity failure — blocking it would make first installs
        # impossible. FAIL is reserved for a proven installed-identity
        # contradiction (pm path answers for the package but the recorded
        # installed identity is inconsistent).
        installed = verify_installed_package(adb, serial, package, runner=runner)
        if installed.get("present"):
            inconsistent = bool(installed.get("version_code") is None
                                and not installed.get("installed_path"))
            gate["checks"]["installed_identity"] = {
                "status": "FAIL" if inconsistent else "PASS",
                "installed_path": installed.get("installed_path"),
                "version_code": installed.get("version_code"),
                "reason": ("installed identity inconsistent: pm path matched "
                           "but no install record readable") if inconsistent
                          else None,
            }
        else:
            gate["checks"]["installed_identity"] = {
                "status": "NOT_INSTALLED",
                "installed_path": None,
                "version_code": None,
                "reason": ("package not currently installed; fresh-install "
                           "path (non-blocking; post-install verification "
                           "will confirm identity)"),
            }

    for check in gate["checks"].values():
        if check.get("status") == "FAIL":
            gate["status"] = "INTEGRITY_FAILED"
            break
    return gate


def deploy_readiness(*, sign_status=None, artifact_path=None,
                     artifact_sha256=None, certificate_sha256=None,
                     apksigner_path=None, keystore_path=None, test_package=None):
    """Pure install-readiness gate: every upstream fact must be present.

    No subprocesses, no device access. Any missing fact blocks the deploy
    with an explicit reason instead of a futile install attempt.
    """
    checks = {
        "signed_verified": {
            "status": "PASS" if sign_status == "SIGNED_VERIFIED" else "FAIL",
            "sign_status": sign_status},
        "artifact_present": {
            "status": ("PASS" if artifact_path
                       and Path(str(artifact_path)).is_file() else "FAIL"),
            "artifact": str(artifact_path) if artifact_path else None},
        "artifact_sha256_recorded": {
            "status": "PASS" if artifact_sha256 else "FAIL"},
        "certificate_recorded": {
            "status": "PASS" if certificate_sha256 else "FAIL",
            "certificate_sha256": certificate_sha256},
        "apksigner_available": {
            "status": "PASS" if apksigner_path else "FAIL",
            "path": str(apksigner_path) if apksigner_path else None},
        "keystore_present": {
            "status": ("PASS" if keystore_path
                       and Path(str(keystore_path)).is_file() else "FAIL"),
            "path": str(keystore_path) if keystore_path else None},
        "test_package_resolved": {
            "status": "PASS" if test_package else "FAIL",
            "package": test_package},
    }
    failed = [name for name, check in checks.items()
              if check.get("status") == "FAIL"]
    return {"checks": checks, "failed": failed,
            "ready": not failed,
            "status": "READY" if not failed else "NOT_READY"}


def _installed_base_apk(adb, serial, package, runner, tmp_dir=None):
    """Pull the currently installed base.apk to a temp file (read-only).

    Returns (temp_path_or_None, installed_path_or_None, error_or_None).
    The caller owns cleanup of the temp file.
    """
    import tempfile
    rc, out = runner([adb, "-s", serial, "shell", "pm", "path", package],
                     timeout=20)
    installed = None
    for line in (out or "").splitlines():
        if line.startswith("package:"):
            installed = line.split(":", 1)[1].strip()
            break
    if not installed:
        return None, None, None
    tmp = tempfile.NamedTemporaryFile(prefix="reelsec-installed-",
                                      suffix=".apk", dir=tmp_dir,
                                      delete=False)
    tmp.close()
    rc, out = runner([adb, "-s", serial, "pull", installed, tmp.name],
                     timeout=180)
    if rc != 0:
        try:
            Path(tmp.name).unlink()
        except OSError:
            pass
        return None, installed, "adb pull failed (rc=%s): %s" % (
            rc, (out or "")[-500:])
    return tmp.name, installed, None


def _apk_certificate_sha256(apksigner, apk_path, runner):
    """Signer certificate SHA-256 of an APK via apksigner (no password)."""
    from sign_verify import parse_apksigner_certificates
    rc, out = runner([str(apksigner), "verify", "--print-certs",
                      str(apk_path)], timeout=120)
    if rc != 0:
        return None, "apksigner verify --print-certs failed (rc=%s)" % rc
    digests = parse_apksigner_certificates(out)
    if not digests:
        return None, "no signer certificate digest in apksigner output"
    return digests[0], None


def check_install_compatibility(*, adb, serial, package, artifact_cert_sha256,
                                artifact_version_code=None, apksigner=None,
                                runner=None, tmp_dir=None):
    """Compatibility gate: can this artifact replace the installed build?

    Compares the artifact signer certificate against the on-device build
    (pulled read-only) and checks versionCode downgrade. A mismatch blocks
    the deploy with an explicit reason; uninstall/clear-data are never
    triggered here — that path requires an explicit hash-bound
    authorization document handled by the caller.
    """
    runner = runner or _default_runner
    record = {"package": package,
              "artifact": {"certificate_sha256": artifact_cert_sha256,
                           "version_code": artifact_version_code},
              "installed": None, "compatible": False,
              "mode": None, "reason_code": None, "reason": None}
    if not package:
        record.update(reason_code="PACKAGE_UNRESOLVED",
                      reason="test package unresolved; refusing install")
        return record
    if not artifact_cert_sha256:
        record.update(reason_code="ARTIFACT_CERT_UNKNOWN",
                      reason="artifact signer certificate unrecorded; refusing install")
        return record
    if not apksigner:
        record.update(reason_code="APKSIGNER_UNAVAILABLE",
                      reason="apksigner unavailable; cannot verify installed identity")
        return record
    pulled, installed_path, pull_error = _installed_base_apk(
        adb, serial, package, runner, tmp_dir=tmp_dir)
    if pull_error:
        record.update(reason_code="COMPATIBILITY_UNVERIFIED", reason=pull_error)
        return record
    if not pulled:
        record.update(compatible=True, mode="FRESH_INSTALL",
                      reason_code="NOT_INSTALLED",
                      reason="package not installed; fresh install path")
        return record
    try:
        installed_cert, cert_error = _apk_certificate_sha256(
            apksigner, pulled, runner)
        if cert_error:
            record.update(reason_code="COMPATIBILITY_UNVERIFIED",
                          reason=cert_error)
            record["installed"] = {"installed_path": installed_path}
            return record
        installed_version = None
        rc, out = runner([adb, "-s", serial, "shell", "dumpsys",
                          "package", package], timeout=30)
        if rc == 0:
            for line in (out or "").splitlines():
                if "versionCode=" in line:
                    installed_version = line.split(
                        "versionCode=", 1)[1].split()[0].strip()
                    break
        record["installed"] = {"installed_path": installed_path,
                               "certificate_sha256": installed_cert,
                               "version_code": installed_version}
        if installed_cert != (artifact_cert_sha256 or "").lower():
            record.update(
                reason_code="SIGNATURE_MISMATCH",
                reason=("installed build is signed with a different "
                        "certificate; non-destructive replace is impossible "
                        "without an explicit hash-bound destructive "
                        "authorization document"))
            return record
        try:
            downgrade = (artifact_version_code is not None
                         and installed_version is not None
                         and int(str(artifact_version_code))
                         < int(str(installed_version)))
        except (TypeError, ValueError):
            downgrade = False
        if downgrade:
            record.update(
                reason_code="VERSION_DOWNGRADE",
                reason=("artifact versionCode %s is lower than installed %s"
                        % (artifact_version_code, installed_version)))
            return record
        record.update(compatible=True, mode="REPLACE_INSTALL",
                      reason_code="SIGNATURE_MATCH",
                      reason=("signer certificate matches the installed "
                              "build; non-destructive replace permitted"))
        return record
    finally:
        try:
            Path(pulled).unlink()
        except OSError:
            pass


def _sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def verify_installed_artifact_identity(*, adb, serial, package,
                                       expected_cert_sha256, apksigner,
                                       expected_sha256=None,
                                       runner=None, tmp_dir=None):
    """Post-install identity: is the on-device build OUR artifact?

    Pulls the installed base.apk read-only and compares its bytes
    (SHA-256, when an expected digest is supplied) and its signer
    certificate against the signed artifact. A mismatch blocks runtime:
    evidence about the wrong build is worse than no evidence.
    """
    runner = runner or _default_runner
    record = {"package": package,
              "expected_sha256": expected_sha256,
              "installed_sha256": None,
              "expected_certificate_sha256": expected_cert_sha256,
              "installed_certificate_sha256": None,
              "installed_path": None, "identity": "UNVERIFIED",
              "reason": None}
    if not expected_cert_sha256:
        record["reason"] = "expected certificate unrecorded"
        return record
    pulled, installed_path, pull_error = _installed_base_apk(
        adb, serial, package, runner, tmp_dir=tmp_dir)
    record["installed_path"] = installed_path
    if pull_error:
        record["reason"] = pull_error
        return record
    if not pulled:
        record["reason"] = "package not present after install"
        return record
    try:
        try:
            installed_sha = _sha256_file(pulled)
        except OSError as exc:
            record["reason"] = "cannot hash pulled apk: %s" % exc
            return record
        record["installed_sha256"] = installed_sha
        if expected_sha256 and installed_sha != expected_sha256.lower():
            record["identity"] = "MISMATCH"
            record["reason"] = ("installed bytes differ from the signed "
                                "artifact (SHA-256 mismatch); runtime blocked")
            return record
        installed_cert, cert_error = _apk_certificate_sha256(
            apksigner, pulled, runner)
        if cert_error:
            record["reason"] = cert_error
            return record
        record["installed_certificate_sha256"] = installed_cert
        if installed_cert == (expected_cert_sha256 or "").lower():
            record["identity"] = "MATCH"
            record["reason"] = ("installed bytes and signer certificate "
                                "match the signed artifact"
                                if expected_sha256 else
                                "installed signer certificate matches the "
                                "signed artifact")
        else:
            record["identity"] = "MISMATCH"
            record["reason"] = ("installed signer certificate differs from "
                                "the signed artifact; runtime blocked")
        return record
    finally:
        try:
            Path(pulled).unlink()
        except OSError:
            pass


def write_deploy_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p
