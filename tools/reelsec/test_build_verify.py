import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from build_verify import (
    BuildVerifyError,
    apktool_build_command,
    verify_artifact,
    verify_native_library_packaging,
    zipalign_command,
    zipalign_verify_command,
)


class BuildVerifyTests(unittest.TestCase):
    def test_standalone_build_command(self):
        cmd = apktool_build_command(
            {"backend": "java-classpath", "path": "/usr/bin/java", "classpath": "/x/*"},
            "/tmp/decoded", "/tmp/out.apk",
        )
        self.assertEqual(cmd[:4], ["/usr/bin/java", "-cp", "/x/*", "brut.apktool.Main"])
        self.assertEqual(cmd[-4:], ["b", "/tmp/decoded", "-o", "/tmp/out.apk"])

    def test_cli_build_command(self):
        cmd = apktool_build_command(
            {"backend": "cli", "path": "/usr/bin/apktool"},
            "/tmp/decoded", "/tmp/out.apk",
        )
        self.assertEqual(cmd, ["/usr/bin/apktool", "b", "/tmp/decoded", "-o", "/tmp/out.apk"])

    def test_zipalign_command(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "in.apk"
            apk.write_bytes(b"x")
            cmd = zipalign_command("/usr/bin/zipalign", apk, Path(tmp) / "out.apk")
            self.assertEqual(
                cmd,
                ["/usr/bin/zipalign", "-P", "16", "-f", "-v", "4",
                 str(apk.resolve()), str((Path(tmp) / "out.apk").resolve())],
            )

    def test_zipalign_verify_command(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "in.apk"
            apk.write_bytes(b"x")
            cmd = zipalign_verify_command("/usr/bin/zipalign", apk)
            self.assertEqual(
                cmd,
                ["/usr/bin/zipalign", "-c", "-P", "16", "-v", "4",
                 str(apk.resolve())],
            )

    def test_native_library_packaging_rejects_compressed_so(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "test.apk"
            import zipfile
            with zipfile.ZipFile(apk, "w", compression=zipfile.ZIP_DEFLATED) as zf:
                zf.writestr("lib/arm64-v8a/libfrida-gadget.so", b"ELF")
            with self.assertRaises(BuildVerifyError):
                verify_native_library_packaging(apk)

    def test_native_library_packaging_accepts_stored_so(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "test.apk"
            import zipfile
            with zipfile.ZipFile(apk, "w", compression=zipfile.ZIP_STORED) as zf:
                zf.writestr("lib/arm64-v8a/libfrida-gadget.so", b"ELF")
            result = verify_native_library_packaging(apk)
            self.assertEqual(result["status"], "NATIVE_LIBRARIES_UNCOMPRESSED")

    def test_verify_artifact(self):
        with tempfile.TemporaryDirectory() as tmp:
            apk = Path(tmp) / "test.apk"
            apk.write_bytes(b"not-a-real-apk-but-nonempty")
            result = verify_artifact(apk)
            self.assertEqual(result["status"], "BUILT")
            self.assertEqual(result["size"], apk.stat().st_size)

    def test_missing_artifact(self):
        with self.assertRaises(BuildVerifyError):
            verify_artifact("/no/such/artifact.apk")


if __name__ == "__main__":
    unittest.main(verbosity=2)
