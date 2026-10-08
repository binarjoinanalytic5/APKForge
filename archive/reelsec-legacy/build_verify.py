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


def zipalign_command(zipalign, input_apk, output_apk, page_size_kb=16):
    """Build a modern zipalign command for APKs containing shared libraries.

    -P 16 aligns uncompressed .so files to a 16 KiB page boundary, which is
    suitable for both 16 KiB and 4 KiB Android devices.
    """
    if not zipalign:
        raise BuildVerifyError("zipalign path is required")
    source = Path(input_apk).resolve()
    target = Path(output_apk).resolve()
    if not source.is_file():
        raise BuildVerifyError("input APK for zipalign is missing")
    if source == target:
        raise BuildVerifyError("zipalign output must be separate from input APK")
    if int(page_size_kb) not in (4, 16, 64):
        raise BuildVerifyError("unsupported zipalign page size: %s" % page_size_kb)
    return [
        str(zipalign), "-P", str(int(page_size_kb)), "-f", "-v", "4",
        str(source), str(target),
    ]


def zipalign_verify_command(zipalign, apk, page_size_kb=16):
    """Build a read-only zipalign verification command."""
    if not zipalign:
        raise BuildVerifyError("zipalign path is required")
    target = Path(apk).resolve()
    if not target.is_file():
        raise BuildVerifyError("APK for zipalign verification is missing")
    if int(page_size_kb) not in (4, 16, 64):
        raise BuildVerifyError("unsupported zipalign page size: %s" % page_size_kb)
    return [
        str(zipalign), "-c", "-P", str(int(page_size_kb)), "-v", "4",
        str(target),
    ]


def verify_native_library_packaging(path):
    """Verify that APK native libraries are stored, not compressed.

    APKs using android:extractNativeLibs="false" must keep native shared
    libraries uncompressed. This check is intentionally independent of
    zipalign so a future APK build cannot reach ADB with an invalid package.
    """
    apk = Path(path).resolve()
    if not apk.is_file():
        raise BuildVerifyError("APK for native-library packaging verification is missing")
    import zipfile
    try:
        with zipfile.ZipFile(apk) as zf:
            native = [
                info for info in zf.infolist()
                if info.filename.startswith("lib/")
                and info.filename.endswith(".so")
                and not info.is_dir()
            ]
    except zipfile.BadZipFile as exc:
        raise BuildVerifyError("invalid APK zip container: %s" % exc) from exc

    compressed = [info.filename for info in native if info.compress_type != zipfile.ZIP_STORED]
    return {
        "status": "NATIVE_LIBRARIES_UNCOMPRESSED",
        "native_library_count": len(native),
        "compressed_native_libraries": compressed,
    } if not compressed else (_ for _ in ()).throw(
        BuildVerifyError(
            "compressed native libraries incompatible with extractNativeLibs=false: %s"
            % compressed[:20]
        )
    )


def plan_artifact_alignment(*, gadget_enabled=False, zipalign_available=False):
    """Decide whether the freshly built APK must pass through zipalign.

    Alignment is REQUIRED for every instrumented artifact whenever the
    zipalign binary is available: the deploy-stage preflight verifies 16
    KiB page alignment on the same host, so an unaligned build would be
    deterministically rejected (PREFLIGHT_FAILED) and the package would
    never reach the device (PACKAGE_NOT_INSTALLED / INSTRUMENTED_RUNTIME
    NOT_RUN). This bit the first no-gadget run, whose build skipped
    alignment because the step used to be gated on Gadget embedding.

    Gadget builds additionally refuse to proceed without zipalign.
    Non-Gadget builds without zipalign record the skip explicitly and
    continue; preflight skips the same check on the same host.

    Returns {"align": bool, "reason": str}.
    """
    if zipalign_available:
        return {
            "align": True,
            "reason": ("zipalign available: every instrumented artifact is "
                       "page-aligned before signing, with or without Gadget"),
        }
    if gadget_enabled:
        raise BuildVerifyError(
            "zipalign unavailable; Gadget APK requires native-library alignment")
    return {
        "align": False,
        "reason": ("zipalign unavailable; non-Gadget build continues "
                   "unaligned and preflight skips the alignment check"),
    }


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
