#!/usr/bin/env python3
"""Tests for the guarded L4 behavioral capture producer."""
import struct
import tempfile
import unittest
import zlib
from pathlib import Path

from behavior_capture import analyze_frame, capture_behavior, png_max_channel


def make_png(width, height, rgb, filter_type=0):
    """Synthetic 8-bit RGB PNG with a uniform pixel color."""
    row = bytes(filter_type.to_bytes(1, "big")) + bytes(rgb) * width
    raw = row * height

    def chunk(ctype, data):
        return (struct.pack(">I", len(data)) + ctype + data +
                struct.pack(">I", zlib.crc32(ctype + data) & 0xFFFFFFFF))
    ihdr = struct.pack(">IIBBBBB", width, height, 8, 2, 0, 0, 0)
    return (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) +
            chunk(b"IDAT", zlib.compress(raw)) + chunk(b"IEND", b""))


class PngAnalyzerTests(unittest.TestCase):
    def test_black_frame_is_uniform_dark(self):
        data = make_png(8, 8, (0, 0, 0))
        analysis = analyze_frame(data)
        self.assertTrue(analysis["analyzable"])
        self.assertTrue(analysis["uniform_dark"])
        self.assertEqual(analysis["max_channel"], 0)

    def test_bright_frame_is_not_dark(self):
        analysis = analyze_frame(make_png(8, 8, (200, 120, 40)))
        self.assertTrue(analysis["analyzable"])
        self.assertFalse(analysis["uniform_dark"])
        self.assertEqual(analysis["max_channel"], 200)

    def test_filtered_scanlines_are_decoded(self):
        # filter type 2 (Up) with black rows still decodes to zero
        data = make_png(4, 4, (0, 0, 0), filter_type=2)
        self.assertEqual(png_max_channel(data), 0)

    def test_invalid_input_is_not_analyzable(self):
        self.assertIsNone(png_max_channel(b"not a png"))
        self.assertFalse(analyze_frame(b"")["analyzable"])


class CaptureBehaviorTests(unittest.TestCase):
    def _runner(self, png_payload, foreground="com.newleaf.app.android.victor"):
        def runner(cmd, timeout=60, binary=False):
            joined = " ".join(cmd)
            if "dumpsys activity" in joined:
                return 0, "topResumedActivity: ActivityRecord{%s}" % foreground
            if "screencap" in joined:
                if png_payload is None:
                    return 1, b""
                return 0, png_payload
            return 1, ""
        return runner

    def test_black_frame_with_playback_confirmation_is_protected(self):
        record = capture_behavior(
            "/adb", "s1", "com.newleaf.app.android.victor",
            artifact_sha256="aa" * 32, playback_confirmed=True,
            runner=self._runner(make_png(8, 8, (0, 0, 0))))
        self.assertTrue(record["screenshot_attempted"])
        self.assertEqual(record["capture_result"], "ALL_BLACK_FRAME")
        self.assertTrue(record["secure_content_protected"])
        self.assertTrue(record["session_bound"])
        self.assertTrue(record["read_only"])

    def test_black_frame_without_playback_confirmation_stays_unknown(self):
        record = capture_behavior(
            "/adb", "s1", "com.x", artifact_sha256="aa" * 32,
            playback_confirmed=False,
            runner=self._runner(make_png(8, 8, (0, 0, 0))))
        self.assertEqual(record["capture_result"], "ALL_BLACK_FRAME")
        self.assertIsNone(record["secure_content_protected"])

    def test_visible_content_is_not_protected(self):
        record = capture_behavior(
            "/adb", "s1", "com.x", artifact_sha256="aa" * 32,
            playback_confirmed=True,
            runner=self._runner(make_png(8, 8, (255, 255, 255))))
        self.assertEqual(record["capture_result"], "CONTENT_VISIBLE")
        self.assertFalse(record["secure_content_protected"])

    def test_capture_failure_is_recorded_not_guessed(self):
        record = capture_behavior(
            "/adb", "s1", "com.x", artifact_sha256="aa" * 32,
            runner=self._runner(None))
        self.assertTrue(record["screenshot_attempted"])
        self.assertEqual(record["capture_result"], "CAPTURE_FAILED")
        self.assertIsNone(record["secure_content_protected"])
        self.assertFalse(record["session_bound"])

    def test_session_not_bound_when_foreground_is_other_app(self):
        record = capture_behavior(
            "/adb", "s1", "com.x", artifact_sha256="aa" * 32,
            playback_confirmed=True,
            runner=self._runner(make_png(8, 8, (0, 0, 0)), foreground="com.other.app"))
        self.assertFalse(record["foreground_is_target"])
        self.assertFalse(record["session_bound"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
