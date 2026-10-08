#!/usr/bin/env python3
"""Guarded L4 behavioral capture producer (BEHAVIOR-CAPTURE.json).

Design contract (defined by evidence_report.py):
    {"screenshot_attempted": true,
     "secure_content_protected": true|false|null,
     "session_bound": true}

Semantics (strict):
- The producer performs ONE bounded, user-level `screencap` attempt through
  ADB — the same operation any user could trigger. It never injects hooks,
  never disables FLAG_SECURE/DRM, never modifies the app or the device
  outside the explicit test package scope.
- `secure_content_protected=true` requires BOTH:
    1. the captured frame is uniformly dark (secure layers render black), AND
    2. the operator explicitly confirms protected playback was active
       (REELSEC_BEHAVIOR_PLAYBACK_CONFIRMED=1). Without playback
       confirmation the semantic verdict stays null and L4 stays NOT_PROVEN.
- Opt-in only: REELSEC_BEHAVIOR_CAPTURE=1.

This module observes protection behavior; it does not test circumvention.
"""
import json
import struct
import time
import zlib

SCHEMA = "behavior-capture-2"
DARK_THRESHOLD = 16


def _paeth(a, b, c):
    p = a + b - c
    pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
    if pa <= pb and pa <= pc:
        return a
    if pb <= pc:
        return b
    return c


def png_max_channel(data):
    """Minimal PNG decoder (8-bit gray/RGB/RGBA, non-interlaced).

    Returns the maximum channel value over all pixels, or None when the PNG
    is unsupported/invalid. Standard scanline unfiltering (types 0-4).
    """
    try:
        if data[:8] != b"\x89PNG\r\n\x1a\n":
            return None
        pos = 8
        width = height = bitdepth = colortype = interlace = None
        idat = b""
        while pos + 8 <= len(data):
            length, = struct.unpack(">I", data[pos:pos + 4])
            ctype = data[pos + 4:pos + 8]
            chunk = data[pos + 8:pos + 8 + length]
            if ctype == b"IHDR":
                width, height, bitdepth, colortype, _comp, _filt, interlace = \
                    struct.unpack(">IIBBBBB", chunk[:13])
            elif ctype == b"IDAT":
                idat += chunk
            elif ctype == b"IEND":
                break
            pos += 12 + length
        if bitdepth != 8 or interlace != 0 or colortype not in (0, 2, 6):
            return None
        channels = {0: 1, 2: 3, 6: 4}[colortype]
        raw = zlib.decompress(idat)
        stride = width * channels
        expected = height * (stride + 1)
        if len(raw) < expected:
            return None
        prev = bytearray(stride)
        maxv = 0
        for y in range(height):
            row_start = y * (stride + 1)
            ftype = raw[row_start]
            line = bytearray(raw[row_start + 1:row_start + 1 + stride])
            if ftype == 1:
                for i in range(channels, stride):
                    line[i] = (line[i] + line[i - channels]) & 0xFF
            elif ftype == 2:
                for i in range(stride):
                    line[i] = (line[i] + prev[i]) & 0xFF
            elif ftype == 3:
                for i in range(stride):
                    left = line[i - channels] if i >= channels else 0
                    line[i] = (line[i] + ((left + prev[i]) >> 1)) & 0xFF
            elif ftype == 4:
                for i in range(stride):
                    a = line[i - channels] if i >= channels else 0
                    b = prev[i]
                    c = prev[i - channels] if i >= channels else 0
                    line[i] = (line[i] + _paeth(a, b, c)) & 0xFF
            elif ftype != 0:
                return None
            row_max = max(line) if stride else 0
            if row_max > maxv:
                maxv = row_max
            prev = line
        return maxv
    except (zlib.error, struct.error, IndexError, ValueError):
        return None


def analyze_frame(png_bytes, threshold=DARK_THRESHOLD):
    maxv = png_max_channel(png_bytes)
    if maxv is None:
        return {"analyzable": False, "uniform_dark": None, "max_channel": None}
    return {"analyzable": True, "uniform_dark": maxv <= threshold,
            "max_channel": maxv, "threshold": threshold}


def _default_runner(command, timeout=60, binary=False):
    import subprocess
    proc = subprocess.run(
        command, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT if not binary else subprocess.PIPE,
        timeout=timeout, check=False,
    )
    out = proc.stdout if binary else (proc.stdout or b"").decode("utf-8", "replace")
    return proc.returncode, out


def capture_behavior(adb, serial, package, artifact_sha256=None,
                     playback_confirmed=False, runner=None):
    """One bounded screencap observation bound to the session/artifact.

    The record is structured into four auditable layers so a reviewer can
    always tell what was observed on the device, what was assumed by the
    operator, what the program analyzed, and what the gate inferred:

    - device_observations : facts returned by the device (foreground dump,
      screencap exit code, capture size + SHA-256)
    - operator_inputs     : operator-supplied assumptions (playback
      confirmation) — explicitly NOT device observations
    - program_analysis    : what the analyzer computed from the frame
    - gate_inference      : the semantic verdict derived from the above
    """
    import hashlib
    runner = runner or _default_runner
    record = {
        "schema_version": SCHEMA,
        "timestamp_epoch": time.time(),
        "read_only": True,
        "device_observations": {
            "serial": serial,
            "package": package,
            "foreground_dump": None,
            "foreground_is_target": False,
            "screencap_attempted": False,
            "screencap_returncode": None,
            "screencap_bytes": None,
            "screencap_sha256": None,
        },
        "operator_inputs": {
            "playback_confirmed": bool(playback_confirmed),
            "note": ("operator-supplied assumption about protected playback; "
                     "not a device observation"),
        },
        "program_analysis": {
            "analyzable": False, "uniform_dark": None,
            "max_channel": None, "threshold": DARK_THRESHOLD,
        },
        "gate_inference": {
            "capture_result": None,
            "secure_content_protected": None,
            "rationale": None,
        },
        # top-level contract fields (consumed by evidence_report)
        "screenshot_attempted": False,
        "capture_result": None,
        "secure_content_protected": None,
        "session_bound": False,
        "artifact_sha256": artifact_sha256,
        "boundary": ("user-level screencap observation only; no hooks, no "
                     "protection modification, no circumvention attempt"),
    }
    obs = record["device_observations"]
    gate = record["gate_inference"]

    # foreground check (evidence that the test package is the visible app)
    rc, out = runner([adb, "-s", serial, "shell",
                      "dumpsys activity activities | grep -m1 topResumedActivity"],
                     timeout=20)
    obs["foreground_dump"] = (out or "").strip()[:300]
    obs["foreground_is_target"] = bool(package and package in (out or ""))
    record["foreground"] = obs["foreground_dump"]
    record["foreground_is_target"] = obs["foreground_is_target"]

    obs["screencap_attempted"] = True
    record["screenshot_attempted"] = True
    rc, png = runner([adb, "-s", serial, "exec-out", "screencap", "-p"],
                     timeout=30, binary=True)
    obs["screencap_returncode"] = rc
    if rc != 0 or not png or not png.startswith(b"\x89PNG"):
        gate["capture_result"] = "CAPTURE_FAILED"
        gate["rationale"] = ("screencap did not return a PNG; no frame "
                             "semantics can be inferred")
        record["capture_result"] = "CAPTURE_FAILED"
        return record
    obs["screencap_bytes"] = len(png)
    obs["screencap_sha256"] = hashlib.sha256(png).hexdigest()

    analysis = analyze_frame(png)
    record["program_analysis"] = {
        "analyzable": analysis["analyzable"],
        "uniform_dark": analysis["uniform_dark"],
        "max_channel": analysis["max_channel"],
        "threshold": analysis.get("threshold", DARK_THRESHOLD),
    }
    record["frame_analysis"] = analysis
    if not analysis["analyzable"]:
        gate["capture_result"] = "FRAME_NOT_ANALYZABLE"
        gate["rationale"] = "PNG could not be decoded; no frame semantics inferred"
        record["capture_result"] = "FRAME_NOT_ANALYZABLE"
        return record

    dark = bool(analysis["uniform_dark"])
    gate["capture_result"] = "ALL_BLACK_FRAME" if dark else "CONTENT_VISIBLE"
    record["capture_result"] = gate["capture_result"]
    if dark and playback_confirmed:
        gate["secure_content_protected"] = True
        gate["rationale"] = ("uniform dark frame observed while operator "
                             "confirmed protected playback was active")
    elif dark:
        gate["secure_content_protected"] = None
        gate["rationale"] = ("uniform dark frame observed but protected "
                             "playback was NOT confirmed; semantics undetermined "
                             "(idle/black screen is indistinguishable)")
    else:
        gate["secure_content_protected"] = False
        gate["rationale"] = ("visible (non-dark) frame captured; content was "
                             "not protected in this observation")
    record["secure_content_protected"] = gate["secure_content_protected"]
    record["session_bound"] = bool(artifact_sha256 and obs["foreground_is_target"])
    return record
