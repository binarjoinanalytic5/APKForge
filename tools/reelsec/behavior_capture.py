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

SCHEMA = "behavior-capture-1"
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
    """One bounded screencap observation bound to the session/artifact."""
    runner = runner or _default_runner
    record = {
        "schema_version": SCHEMA,
        "timestamp_epoch": time.time(),
        "read_only": True,
        "package": package,
        "serial": serial,
        "artifact_sha256": artifact_sha256,
        "screenshot_attempted": False,
        "capture_result": None,
        "frame_analysis": None,
        "playback_confirmed": bool(playback_confirmed),
        "secure_content_protected": None,
        "session_bound": False,
        "boundary": ("user-level screencap observation only; no hooks, no "
                     "protection modification, no circumvention attempt"),
    }
    # foreground check (evidence that the test package is the visible app)
    rc, out = runner([adb, "-s", serial, "shell",
                      "dumpsys activity activities | grep -m1 topResumedActivity"],
                     timeout=20)
    record["foreground"] = (out or "").strip()[:300]
    record["foreground_is_target"] = bool(package and package in (out or ""))

    record["screenshot_attempted"] = True
    rc, png = runner([adb, "-s", serial, "exec-out", "screencap", "-p"],
                     timeout=30, binary=True)
    if rc != 0 or not png or not png.startswith(b"\x89PNG"):
        record["capture_result"] = "CAPTURE_FAILED"
        return record

    analysis = analyze_frame(png)
    record["frame_analysis"] = analysis
    if not analysis["analyzable"]:
        record["capture_result"] = "FRAME_NOT_ANALYZABLE"
        return record
    record["capture_result"] = "ALL_BLACK_FRAME" if analysis["uniform_dark"] else "CONTENT_VISIBLE"
    if analysis["uniform_dark"] and playback_confirmed:
        record["secure_content_protected"] = True
    elif not analysis["uniform_dark"]:
        record["secure_content_protected"] = False
    # else: dark frame without playback confirmation -> semantics unknown (None)
    record["session_bound"] = bool(artifact_sha256 and record["foreground_is_target"])
    return record
