import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parent))

from sign_verify import (
    SignVerifyError,
    artifact_identity,
    bootstrap_test_keystore,
    parse_apksigner_certificates,
    plan_test_keystore,
    refuse_inside_repo,
    scrub_secrets,
    sign_command,
    signing_preflight,
    validate_pkcs12,
    verify_command,
)


class SignVerifyTests(unittest.TestCase):
    def test_sign_command_isolated(self):
        with mock.patch.dict(
            os.environ,
            {
                "REELSEC_TEST_KEYSTORE_PASSWORD": "store-secret",
                "REELSEC_TEST_KEY_PASSWORD": "key-secret",
            },
            clear=False,
        ):
            cmd = sign_command("/usr/bin/apksigner", "/tmp/u.apk", "/tmp/s.apk", "/tmp/test.jks", "test")
        self.assertEqual(cmd[0:2], ["/usr/bin/apksigner", "sign"])
        self.assertIn("/tmp/u.apk", cmd)
        self.assertIn("/tmp/s.apk", cmd)
        self.assertIn("--ks-pass", cmd)
        self.assertIn("env:REELSEC_TEST_KEYSTORE_PASSWORD", cmd)
        self.assertIn("--key-pass", cmd)
        self.assertIn("env:REELSEC_TEST_KEY_PASSWORD", cmd)
        self.assertNotIn("store-secret", cmd)
        self.assertNotIn("key-secret", cmd)

    def test_sign_command_requires_password_environment(self):
        with mock.patch.dict(
            os.environ,
            {
                "REELSEC_TEST_KEYSTORE_PASSWORD": "",
                "REELSEC_TEST_KEY_PASSWORD": "",
            },
            clear=False,
        ):
            with self.assertRaises(SignVerifyError):
                sign_command("/usr/bin/apksigner", "/tmp/u.apk", "/tmp/s.apk", "/tmp/test.jks", "test")

    def test_verify_command(self):
        self.assertEqual(
            verify_command("/usr/bin/apksigner", "/tmp/s.apk"),
            ["/usr/bin/apksigner", "verify", "--verbose", "/tmp/s.apk"],
        )

    def test_identity_requires_separate_artifacts(self):
        with tempfile.TemporaryDirectory() as tmp:
            u = Path(tmp) / "u.apk"
            s = Path(tmp) / "s.apk"
            u.write_bytes(b"unsigned")
            s.write_bytes(b"signed")
            result = artifact_identity(u, s)
            self.assertFalse(result["original_mutation"])
            self.assertNotEqual(result["unsigned_sha256"], result["signed_sha256"])

    def test_identity_rejects_same_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "a.apk"
            p.write_bytes(b"x")
            with self.assertRaises(SignVerifyError):
                artifact_identity(p, p)


class KeystoreBootstrapTests(unittest.TestCase):
    def test_plan_uses_explicit_keystore(self):
        with tempfile.TemporaryDirectory() as tmp:
            ks = Path(tmp) / "test.jks"
            ks.write_bytes(b"keystore")
            plan = plan_test_keystore(
                {"REELSEC_TEST_KEYSTORE": str(ks),
                 "REELSEC_TEST_KEY_ALIAS": "mine"})
            self.assertEqual(plan["action"], "USE_EXPLICIT")
            self.assertEqual(plan["alias"], "mine")
            self.assertFalse(plan["bootstrapped"])

    def test_plan_rejects_missing_explicit_keystore(self):
        with self.assertRaises(SignVerifyError):
            plan_test_keystore(
                {"REELSEC_TEST_KEYSTORE": "/no/such/keystore.jks"})

    def test_plan_requests_bootstrap_when_unset(self):
        with tempfile.TemporaryDirectory() as tmp:
            repo = Path(tmp) / "repo"
            repo.mkdir()
            plan = plan_test_keystore(
                {"REELSEC_TEST_KEYSTORE_DIR": str(Path(tmp) / "ks")},
                repo_root=repo)
            self.assertEqual(plan["action"], "BOOTSTRAP")
            self.assertTrue(plan["bootstrapped"])
            self.assertEqual(plan["backend"], "openssl-pkcs12")
            self.assertTrue(plan["keystore"].endswith(".p12"))

    def test_refuse_inside_repo(self):
        with tempfile.TemporaryDirectory() as tmp:
            repo = Path(tmp) / "repo"
            repo.mkdir()
            with self.assertRaises(SignVerifyError):
                refuse_inside_repo(repo / "out" / "test.p12", repo)
            outside = refuse_inside_repo(Path(tmp) / "ks" / "test.p12", repo)
            self.assertTrue(str(outside).endswith("test.p12"))

    def test_bootstrap_creates_keystore_without_argv_secrets(self):
        import stat
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "ks" / "reelsec-test.p12"
            commands = []

            def fake_openssl(cmd, timeout=120):
                commands.append(cmd)
                if cmd[1] == "genrsa":
                    Path(cmd[cmd.index("-out") + 1]).write_bytes(b"key")
                    return 0, ""
                if cmd[1] == "req":
                    Path(cmd[cmd.index("-out") + 1]).write_bytes(b"cert")
                    return 0, ""
                if cmd[1:3] == ["pkcs12", "-export"]:
                    Path(cmd[cmd.index("-out") + 1]).write_bytes(b"p12")
                    return 0, ""
                if cmd[1] == "x509":
                    return 0, "SHA256 Fingerprint=AA:BB:CC\n"
                return 1, "unexpected"

            env = {}
            record = bootstrap_test_keystore(
                target, alias="reelsec-test", openssl="/usr/bin/openssl",
                runner=fake_openssl, env=env)
            self.assertTrue(record["bootstrapped"])
            self.assertEqual(record["certificate_sha256"], "aabbcc")
            password = env["REELSEC_TEST_KEYSTORE_PASSWORD"]
            self.assertTrue(password)
            self.assertEqual(env["REELSEC_TEST_KEY_PASSWORD"], password)
            argv = " ".join(" ".join(c) for c in commands)
            self.assertNotIn(password, argv)
            self.assertIn("env:REELSEC_TEST_KEYSTORE_PASSWORD", argv)
            self.assertEqual(stat.S_IMODE(target.stat().st_mode), 0o600)
            pw_file = target.parent / ".password"
            self.assertEqual(stat.S_IMODE(pw_file.stat().st_mode), 0o600)
            self.assertEqual(pw_file.read_text(encoding="utf-8"), password)
            self.assertTrue((target.parent / "keystore-meta.json").is_file())
            self.assertFalse((target.parent / ".bootstrap-key.pem").exists())
            self.assertFalse((target.parent / ".bootstrap-cert.pem").exists())

    def test_bootstrap_requires_openssl(self):
        with tempfile.TemporaryDirectory() as tmp:
            with mock.patch("sign_verify.shutil.which", return_value=None):
                with self.assertRaises(SignVerifyError):
                    bootstrap_test_keystore(
                        Path(tmp) / "ks" / "reelsec-test.p12",
                        openssl=None, runner=lambda c, timeout=120: (0, ""),
                        env={})

    def test_bootstrap_reuses_existing_keystore(self):
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "ks" / "reelsec-test.p12"
            target.parent.mkdir(parents=True)
            target.write_bytes(b"p12")
            (target.parent / ".password").write_text("saved-secret",
                                                     encoding="utf-8")
            commands = []

            def fake_openssl(cmd, timeout=120):
                commands.append(cmd)
                if "-noout" in cmd and "-info" not in cmd:
                    return 0, ""
                if "-info" in cmd:
                    return 0, "Bag Attributes\n    friendlyName: reelsec-test\n"
                return 1, "unexpected"

            env = {}
            record = bootstrap_test_keystore(
                target, alias="reelsec-test", openssl="/usr/bin/openssl",
                runner=fake_openssl, env=env)
            self.assertFalse(record["bootstrapped"])
            self.assertTrue(record["reused"])
            self.assertEqual(env["REELSEC_TEST_KEYSTORE_PASSWORD"],
                             "saved-secret")
            self.assertFalse(any("-export" in c for c in commands))

    def test_bootstrap_rejects_invalid_reused_keystore(self):
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "ks" / "reelsec-test.p12"
            target.parent.mkdir(parents=True)
            target.write_bytes(b"p12")
            with self.assertRaises(SignVerifyError):
                bootstrap_test_keystore(
                    target, alias="reelsec-test", openssl="/usr/bin/openssl",
                    runner=lambda c, timeout=120: (1, "mac verify failure"),
                    env={"REELSEC_TEST_KEYSTORE_PASSWORD": "wrong"})

    def test_signing_preflight_ready(self):
        with tempfile.TemporaryDirectory() as tmp:
            ks = Path(tmp) / "test.p12"
            ks.write_bytes(b"p12")

            def fake(cmd, timeout=120):
                if cmd[0] == "/usr/bin/apksigner":
                    return 0, "0.9\n"
                if "-noout" in cmd and "-info" not in cmd:
                    return 0, ""
                if "-info" in cmd:
                    return 0, "Bag Attributes\n    friendlyName: reelsec-test\n"
                return 1, "unexpected"

            report = signing_preflight(
                apksigner="/usr/bin/apksigner", keystore=str(ks),
                alias="reelsec-test", openssl="/usr/bin/openssl",
                runner=fake,
                env={"REELSEC_TEST_KEYSTORE_PASSWORD": "s",
                     "REELSEC_TEST_KEY_PASSWORD": "k"})
            self.assertEqual(report["status"], "READY")
            self.assertEqual(report["failed"], [])

    def test_signing_preflight_detects_bad_password(self):
        with tempfile.TemporaryDirectory() as tmp:
            ks = Path(tmp) / "test.p12"
            ks.write_bytes(b"p12")

            def fake(cmd, timeout=120):
                if cmd[0] == "/usr/bin/apksigner":
                    return 0, "0.9\n"
                return 1, "mac verify failure"

            report = signing_preflight(
                apksigner="/usr/bin/apksigner", keystore=str(ks),
                alias="reelsec-test", openssl="/usr/bin/openssl",
                runner=fake,
                env={"REELSEC_TEST_KEYSTORE_PASSWORD": "bad",
                     "REELSEC_TEST_KEY_PASSWORD": "bad"})
            self.assertEqual(report["status"], "NOT_READY")
            self.assertIn("pkcs12_password_valid", report["failed"])

    def test_parse_apksigner_certificates(self):
        output = ("Signer #1 certificate DN: CN=ReelSec Test\n"
                  "Signer #1 certificate SHA-256 digest: AA:BB:cc:11\n"
                  "Signer #1 certificate SHA-1 digest: 00:11\n")
        self.assertEqual(parse_apksigner_certificates(output), ["aabbcc11"])
        self.assertEqual(parse_apksigner_certificates("no certs here"), [])

    def test_scrub_secrets(self):
        self.assertEqual(scrub_secrets("rc=1 hunter2 end", ["hunter2"]),
                         "rc=1 ***REDACTED*** end")
        self.assertEqual(scrub_secrets("clean", ["x"]), "clean")

    def test_validate_pkcs12_reports(self):
        with tempfile.TemporaryDirectory() as tmp:
            ks = Path(tmp) / "test.p12"
            ks.write_bytes(b"p12")
            env = {"REELSEC_TEST_KEYSTORE_PASSWORD": "s"}
            good = validate_pkcs12(
                ks, alias="reelsec-test", openssl="/usr/bin/openssl",
                runner=lambda c, timeout=60: (
                    (0, "") if "-info" not in c
                    else (0, "friendlyName: reelsec-test\n")),
                env=env)
            self.assertTrue(good["valid"])
            bad = validate_pkcs12(
                ks, alias="other", openssl="/usr/bin/openssl",
                runner=lambda c, timeout=60: (
                    (0, "") if "-info" not in c
                    else (0, "friendlyName: reelsec-test\n")),
                env=env)
            self.assertFalse(bad["valid"])
            self.assertIn("other", bad["reason"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
