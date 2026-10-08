#!/usr/bin/env python3
"""Signing and identity gate for ReelSec test artifacts.

This module never signs the original APK. It requires an explicit isolated
artifact and an explicit signing backend/key configuration.

For unattended signing, apksigner password input must come from environment
variables so the subprocess never blocks on stdin. Password values themselves
are never embedded in commands or manifests.
"""
import hashlib
import json
import os
import re
import secrets
import shutil
import subprocess
import tempfile
import time
from pathlib import Path


class SignVerifyError(RuntimeError):
    pass


KEYSTORE_PASSWORD_ENV = "REELSEC_TEST_KEYSTORE_PASSWORD"
KEY_PASSWORD_ENV = "REELSEC_TEST_KEY_PASSWORD"
KEYSTORE_ENV = "REELSEC_TEST_KEYSTORE"
KEYSTORE_DIR_ENV = "REELSEC_TEST_KEYSTORE_DIR"
KEY_ALIAS_ENV = "REELSEC_TEST_KEY_ALIAS"
DEFAULT_KEY_ALIAS = "reelsec-test"
BOOTSTRAP_KEYSTORE_NAME = "reelsec-test.p12"
BOOTSTRAP_PASSWORD_NAME = ".password"
BOOTSTRAP_META_NAME = "keystore-meta.json"
DEFAULT_KEYSTORE_DIRNAME = ".reelsec/keystores"


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def _password_ref(env_name):
    value = os.environ.get(env_name)
    if not value:
        raise SignVerifyError(
            "%s unavailable; unattended signing requires an explicit password environment variable"
            % env_name
        )
    return "env:" + env_name


def sign_command(apksigner, unsigned_apk, signed_apk, keystore, alias,
                 keystore_password_env=KEYSTORE_PASSWORD_ENV,
                 key_password_env=KEY_PASSWORD_ENV):
    for value, name in (
        (apksigner, "apksigner"), (unsigned_apk, "unsigned APK"),
        (signed_apk, "signed APK"), (keystore, "keystore"), (alias, "alias"),
        (keystore_password_env, "keystore password environment variable"),
        (key_password_env, "key password environment variable"),
    ):
        if not value:
            raise SignVerifyError("%s is required" % name)

    ks_pass = _password_ref(keystore_password_env)
    key_pass = _password_ref(key_password_env)
    return [
        str(apksigner), "sign",
        "--ks", str(keystore),
        "--ks-key-alias", str(alias),
        "--ks-pass", ks_pass,
        "--key-pass", key_pass,
        "--out", str(signed_apk),
        str(unsigned_apk),
    ]


def verify_command(apksigner, signed_apk):
    if not apksigner or not signed_apk:
        raise SignVerifyError("apksigner and signed APK are required")
    return [str(apksigner), "verify", "--verbose", str(signed_apk)]


def artifact_identity(unsigned_apk, signed_apk):
    unsigned = Path(unsigned_apk).resolve()
    signed = Path(signed_apk).resolve()
    if not unsigned.is_file():
        raise SignVerifyError("unsigned artifact is missing")
    if not signed.is_file():
        raise SignVerifyError("signed artifact is missing")
    if unsigned == signed:
        raise SignVerifyError("signed artifact must be separate from unsigned artifact")
    return {
        "unsigned_path": str(unsigned),
        "unsigned_sha256": sha256_file(unsigned),
        "signed_path": str(signed),
        "signed_sha256": sha256_file(signed),
        "original_mutation": False,
    }


def run_checked(command, timeout=300):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    if proc.returncode:
        raise SignVerifyError(
            "command failed (%s): %s\n%s" %
            (proc.returncode, " ".join(command), proc.stdout[-4000:])
        )
    return proc.stdout


def write_sign_manifest(path, data):
    p = Path(path).resolve()
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return p


# --- Self-contained test-keystore bootstrap ----------------------------------
#
# The platform must never stall on a missing REELSEC_TEST_KEYSTORE. When no
# explicit keystore is configured, the bootstrap creates a LOCAL test-only
# PKCS#12 keystore OUTSIDE the git checkout (never inside the campaign
# output, which is published). Passwords travel via environment references
# only: they never appear in command arguments, artifacts, or logs.
# The original APK is never signed and never modified by this module.

def scrub_secrets(text, secrets_values):
    """Replace known secret values with a placeholder (log hygiene)."""
    redacted = text or ""
    for secret in secrets_values or []:
        if secret:
            redacted = redacted.replace(secret, "***REDACTED***")
    return redacted


def default_keystore_dir(env=None):
    values = env if env is not None else os.environ
    override = (values.get(KEYSTORE_DIR_ENV) or "").strip()
    if override:
        return Path(override).expanduser()
    return Path.home() / DEFAULT_KEYSTORE_DIRNAME


def refuse_inside_repo(path, repo_root):
    """Fail closed when a keystore path would land inside the checkout."""
    candidate = Path(path).expanduser().resolve()
    root = Path(repo_root).expanduser().resolve() if repo_root else None
    if root is not None:
        try:
            candidate.relative_to(root)
        except ValueError:
            return candidate
        raise SignVerifyError(
            "test keystore must live outside the git checkout (refused %s)"
            % candidate)
    return candidate


def plan_test_keystore(env=None, repo_root=None):
    """Decide how the campaign obtains its test keystore (no subprocesses).

    Returns {"action": "USE_EXPLICIT" | "BOOTSTRAP", ...}. An explicit but
    missing keystore is a hard error, never a silent bootstrap.
    """
    values = env if env is not None else os.environ
    explicit = (values.get(KEYSTORE_ENV) or "").strip()
    alias = (values.get(KEY_ALIAS_ENV) or "").strip() or DEFAULT_KEY_ALIAS
    if explicit:
        candidate = Path(explicit).expanduser()
        if not candidate.is_file():
            raise SignVerifyError(
                "explicit %s is missing: %s" % (KEYSTORE_ENV, candidate))
        return {"action": "USE_EXPLICIT", "keystore": str(candidate),
                "alias": alias, "bootstrapped": False,
                "backend": "user-provided"}
    target = refuse_inside_repo(default_keystore_dir(values) / BOOTSTRAP_KEYSTORE_NAME,
                                repo_root)
    return {"action": "BOOTSTRAP", "keystore": str(target), "alias": alias,
            "bootstrapped": True, "backend": "openssl-pkcs12",
            "keystore_dir": str(target.parent)}


def _default_runner(command, timeout=120):
    proc = subprocess.run(
        command, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=timeout, check=False,
    )
    return proc.returncode, (proc.stdout or "")


def bootstrap_test_keystore(keystore_path, *, alias=DEFAULT_KEY_ALIAS,
                            openssl=None, runner=None, env=None):
    """Create (or validate an existing) local test PKCS#12 keystore.

    Generation uses openssl only, with `-passout env:...`, so no password
    ever enters a command argument. The password is generated randomly,
    stored 0600 beside the keystore, and placed into the process
    environment for the apksigner `env:` references. Returns a record
    WITHOUT password values.
    """
    values = env if env is not None else os.environ
    runner = runner or _default_runner
    openssl = openssl or shutil.which("openssl")
    if not openssl:
        raise SignVerifyError(
            "openssl unavailable; cannot bootstrap a test keystore "
            "without putting passwords in command arguments")
    target = Path(keystore_path).expanduser().resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    try:
        os.chmod(target.parent, 0o700)
    except OSError:
        pass
    password_file = target.parent / BOOTSTRAP_PASSWORD_NAME
    password = (values.get(KEYSTORE_PASSWORD_ENV) or "").strip()
    if target.is_file():
        if not password and password_file.is_file():
            password = password_file.read_text(encoding="utf-8").strip()
        if not password:
            raise SignVerifyError(
                "bootstrapped keystore exists but no password is available "
                "(%s unset and password file missing)" % KEYSTORE_PASSWORD_ENV)
        values[KEYSTORE_PASSWORD_ENV] = password
        values[KEY_PASSWORD_ENV] = values.get(KEY_PASSWORD_ENV) or password
        valid = validate_pkcs12(target, alias=alias, openssl=openssl,
                                runner=runner, env=values)
        if not valid.get("valid"):
            raise SignVerifyError(
                "existing bootstrapped keystore failed validation: %s"
                % valid.get("reason"))
        meta_path = target.parent / BOOTSTRAP_META_NAME
        if meta_path.is_file():
            try:
                meta_fp = (json.loads(meta_path.read_text(encoding="utf-8"))
                           .get("certificate_sha256"))
            except (OSError, ValueError):
                meta_fp = None
            live_fp = valid.get("certificate_sha256")
            if meta_fp and live_fp and meta_fp != live_fp:
                raise SignVerifyError(
                    "existing bootstrapped keystore file changed under a "
                    "reused path (live certificate differs from "
                    "keystore-meta.json); refusing reuse")
        return {"keystore": str(target), "alias": alias,
                "bootstrapped": False, "reused": True,
                "backend": "openssl-pkcs12",
                "certificate_sha256": valid.get("certificate_sha256")}
    if not password:
        password = secrets.token_urlsafe(32)
    values[KEYSTORE_PASSWORD_ENV] = password
    values[KEY_PASSWORD_ENV] = values.get(KEY_PASSWORD_ENV) or password
    key_pem = target.parent / ".bootstrap-key.pem"
    cert_pem = target.parent / ".bootstrap-cert.pem"
    try:
        steps = [
            ([str(openssl), "genrsa", "-out", str(key_pem), "2048"],
             "openssl genrsa failed"),
            ([str(openssl), "req", "-new", "-x509", "-key", str(key_pem),
              "-out", str(cert_pem), "-days", "10950", "-subj",
              "/CN=ReelSec Test Key/OU=ReelSec Test/O=ReelSec"],
             "openssl req failed"),
            ([str(openssl), "pkcs12", "-export", "-inkey", str(key_pem),
              "-in", str(cert_pem), "-out", str(target), "-name", alias,
              "-passout", "env:" + KEYSTORE_PASSWORD_ENV],
             "openssl pkcs12 export failed"),
        ]
        for command, failure in steps:
            rc, out = runner(command, timeout=120)
            if rc != 0:
                raise SignVerifyError(
                    "%s (rc=%s): %s" % (
                        failure, rc,
                        scrub_secrets((out or "")[-2000:], [password])))
        cert_sha256 = None
        rc, out = runner([str(openssl), "x509", "-in", str(cert_pem),
                          "-noout", "-fingerprint", "-sha256"], timeout=30)
        if rc == 0:
            match = re.search(r"SHA256 Fingerprint=([0-9A-Fa-f:]+)",
                                out or "", re.IGNORECASE)
            if match:
                cert_sha256 = match.group(1).replace(":", "").lower()
        os.chmod(target, 0o600)
        password_file.write_text(password, encoding="utf-8")
        os.chmod(password_file, 0o600)
        (target.parent / BOOTSTRAP_META_NAME).write_text(
            json.dumps({"alias": alias, "backend": "openssl-pkcs12",
                        "test_only": True, "created_at_epoch": time.time(),
                        "certificate_sha256": cert_sha256,
                        "note": ("local test key; never used for store "
                                 "releases; never committed to git")},
                       indent=2, sort_keys=True) + "\n",
            encoding="utf-8")
    except Exception:
        for partial in (target, key_pem, cert_pem):
            try:
                if partial.is_file():
                    partial.unlink()
            except OSError:
                pass
        raise
    finally:
        for temp in (key_pem, cert_pem):
            try:
                if temp.is_file():
                    temp.unlink()
            except OSError:
                pass
    return {"keystore": str(target), "alias": alias,
            "bootstrapped": True, "reused": False,
            "backend": "openssl-pkcs12",
            "certificate_sha256": cert_sha256}


def pkcs12_decode(keystore_path, *, openssl, runner, env):
    """Decode a PKCS#12 keystore's certificate bags (password via env only).

    Returns (returncode, output). The decode uses `-nodes -nokeys`, so the
    output carries the stable `friendlyName:` bag-attribute headers plus
    the public certificate PEM blocks, and never any private key
    material. `-info -noout` is deliberately NOT used: on OpenSSL 3.x it
    reports bag types but never prints friendlyName, so it cannot
    validate aliases at all (2026-10-08 incident: every keystore failed
    the alias check while signing itself worked).
    """
    values = env if env is not None else os.environ
    target = Path(keystore_path).expanduser()
    password = (values.get(KEYSTORE_PASSWORD_ENV) or "").strip()
    if not password:
        return 2, ""
    return runner([str(openssl), "pkcs12", "-in", str(target),
                   "-passin", "env:" + KEYSTORE_PASSWORD_ENV,
                   "-nodes", "-nokeys"], timeout=60)


def pkcs12_bag_names(decode_output):
    """Alias names from decoded PKCS#12 bag headers (robust parse)."""
    names = set()
    for line in (decode_output or "").splitlines():
        match = re.match(r"\s*friendlyName\s*:\s*(\S(?:.*\S)?)\s*$", line,
                         re.IGNORECASE)
        if match:
            names.add(match.group(1).strip())
    return sorted(names)


def pkcs12_first_certificate(decode_output):
    """First PEM certificate block from decoded PKCS#12 output (or None)."""
    match = re.search(
        r"-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----",
        decode_output or "", re.DOTALL)
    return match.group(0) + "\n" if match else None


def validate_pkcs12(keystore_path, *, alias=None, openssl=None,
                    runner=None, env=None):
    """Validate a PKCS#12 keystore password (and alias) without argv secrets.

    Password validity is the binary `-noout` returncode; aliases come from
    the decoded certificate-bag headers; the certificate SHA-256 comes
    from `x509 -fingerprint` over the decoded PEM (best effort, recorded
    for reuse-time identity cross-checks).
    """
    values = env if env is not None else os.environ
    runner = runner or _default_runner
    openssl = openssl or shutil.which("openssl")
    target = Path(keystore_path).expanduser()
    if not target.is_file():
        return {"valid": False, "reason": "keystore file missing"}
    password = (values.get(KEYSTORE_PASSWORD_ENV) or "").strip()
    if not password:
        return {"valid": False,
                "reason": "%s unset" % KEYSTORE_PASSWORD_ENV}
    if not openssl:
        return {"valid": False, "reason": "openssl unavailable"}
    rc, _out = runner([str(openssl), "pkcs12", "-in", str(target),
                       "-noout", "-passin",
                       "env:" + KEYSTORE_PASSWORD_ENV],
                      timeout=60)
    if rc != 0:
        return {"valid": False,
                "reason": "pkcs12 password rejected (rc=%s)" % rc}
    record = {"valid": True, "password": "VALID"}
    rc, decoded = pkcs12_decode(target, openssl=openssl, runner=runner,
                                env=values)
    if rc != 0:
        record["valid"] = False
        record["reason"] = ("pkcs12 decode failed (rc=%s); keystore "
                            "unreadable with the configured password" % rc)
        return record
    record["aliases"] = pkcs12_bag_names(decoded)
    if alias and alias not in record["aliases"]:
        record["valid"] = False
        record["reason"] = ("alias %r not present in keystore (found: %s)"
                            % (alias, record["aliases"] or "none"))
        return record
    fingerprint = None
    pem = pkcs12_first_certificate(decoded)
    if pem:
        fd, tmp = tempfile.mkstemp(prefix="reelsec-p12cert-",
                                   suffix=".pem")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as handle:
                handle.write(pem)
            rc, out = runner([str(openssl), "x509", "-in", tmp,
                              "-noout", "-fingerprint", "-sha256"],
                             timeout=30)
            if rc == 0:
                match = re.search(r"SHA256 Fingerprint=([0-9A-Fa-f:]+)",
                                  out or "", re.IGNORECASE)
                if match:
                    fingerprint = match.group(1).replace(":", "").lower()
        finally:
            try:
                os.unlink(tmp)
            except OSError:
                pass
    record["certificate_sha256"] = fingerprint
    return record


def signing_preflight(*, apksigner, keystore, alias, openssl=None,
                      runner=None, env=None):
    """Real preflight before any sign attempt (passwords stay in env)."""
    values = env if env is not None else os.environ
    runner = runner or _default_runner
    checks = {}
    checks["apksigner_present"] = {
        "status": "PASS" if apksigner else "FAIL",
        "path": str(apksigner) if apksigner else None}
    if apksigner:
        rc, out = runner([str(apksigner), "--version"], timeout=30)
        checks["apksigner_works"] = {
            "status": "PASS" if rc == 0 else "FAIL",
            "returncode": rc,
            "version": ((out or "").strip().splitlines() or [None])[0]}
    else:
        checks["apksigner_works"] = {"status": "FAIL",
                                     "reason": "apksigner missing"}
    target = Path(str(keystore)).expanduser() if keystore else None
    checks["keystore_present"] = {
        "status": ("PASS" if target and target.is_file() else "FAIL"),
        "path": str(target) if target else None}
    checks["keystore_nonempty"] = {
        "status": ("PASS" if target and target.is_file()
                   and target.stat().st_size > 0 else "FAIL")}
    checks["password_envs_set"] = {
        "status": ("PASS" if (values.get(KEYSTORE_PASSWORD_ENV)
                              and values.get(KEY_PASSWORD_ENV)) else "FAIL"),
        "keystore_password_env": KEYSTORE_PASSWORD_ENV,
        "key_password_env": KEY_PASSWORD_ENV}
    suffix = (target.suffix.lower() if target else "")
    if suffix in (".p12", ".pfx") and target and target.is_file():
        if openssl or shutil.which("openssl"):
            valid = validate_pkcs12(target, alias=alias,
                                    openssl=openssl or shutil.which("openssl"),
                                    runner=runner, env=values)
            checks["pkcs12_password_valid"] = {
                "status": "PASS" if valid.get("valid") else "FAIL",
                "reason": None if valid.get("valid") else valid.get("reason")}
            if valid.get("aliases") is not None:
                checks["pkcs12_alias_present"] = {
                    "status": ("PASS" if alias in (valid.get("aliases") or [])
                               else "FAIL"),
                    "alias": alias, "aliases": valid.get("aliases"),
                    "certificate_sha256": valid.get("certificate_sha256")}
        else:
            checks["pkcs12_password_valid"] = {
                "status": "SKIPPED", "reason": "openssl unavailable"}
    else:
        checks["pkcs12_password_valid"] = {
            "status": "SKIPPED",
            "reason": "non-PKCS12 keystore; apksigner sign is the validator"}
    failed = [name for name, check in checks.items()
              if check.get("status") == "FAIL"]
    return {"checks": checks,
            "status": "READY" if not failed else "NOT_READY",
            "failed": failed}


def verify_certs_command(apksigner, signed_apk):
    """apksigner verify that also prints signer certificates (no password)."""
    if not apksigner or not signed_apk:
        raise SignVerifyError("apksigner and signed APK are required")
    return [str(apksigner), "verify", "--print-certs", str(signed_apk)]


def parse_apksigner_certificates(output):
    """Extract signer certificate SHA-256 digests from apksigner output."""
    digests = []
    for match in re.finditer(
            r"certificate SHA-256 digest:\s*([0-9A-Fa-f:]+)", output or ""):
        digests.append(match.group(1).replace(":", "").lower())
    return digests
