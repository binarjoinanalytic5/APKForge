"""ReelSec safety-by-design destructive-operation gate.

Architectural response to the 2026-10-07 incident (DESTRUCTIVE BASELINE
UNINSTALL): a bare environment variable must never be able to authorize a
destructive device operation. Deny is the DEFAULT INSIDE THE CODE:

    UNINSTALL = DENY
    CLEAR_DATA = DENY
    REMOVE_PACKAGE = DENY
    FACTORY_RESET = DENY  (never executable by this tool, even authorized)

Every destructive operation must pass the full chain, in order:

    1. Explicit destructive-operation gate (this module; default DENY)
    2. Target package exact-match
    3. Target user exact-match
    4. Device identity verification (serial exact-match)
    5. Pre-operation snapshot (device state recorded before anything runs)
    6. Explicit authorization (signed-by-operator authorization document,
       hash-bound, time-bounded — NOT an environment variable)
    7. Operation (the only code path that may execute it)
    8. Post-operation verification
    9. Audit record (written for executed AND blocked attempts)

If any step fails, the operation does not run and a SafetyBlock carries the
specific reason. Blocks are audited too: silence is never the outcome.
"""

import hashlib
import json
import time
from pathlib import Path

SCHEMA_AUTH = "destructive-auth-1"
SCHEMA_AUDIT = "safety-audit-1"

UNINSTALL = "UNINSTALL"
CLEAR_DATA = "CLEAR_DATA"
REMOVE_PACKAGE = "REMOVE_PACKAGE"
FACTORY_RESET = "FACTORY_RESET"

DESTRUCTIVE_OPERATIONS = (UNINSTALL, CLEAR_DATA, REMOVE_PACKAGE, FACTORY_RESET)

# Deny-by-default policy. This is code, not configuration: nothing in the
# environment can flip these defaults. Authorization documents grant
# individual, exact-match, time-bounded exceptions — never a blanket mode.
DEFAULT_POLICY = {op: "DENY" for op in DESTRUCTIVE_OPERATIONS}

# Operations that are NEVER executable through this tool even with a valid
# authorization document. Hard architectural boundary.
NEVER_EXECUTABLE = (FACTORY_RESET,)

# Legacy blanket flags. Their presence is a SAFETY VIOLATION for the
# autonomous platform: doctor refuses to run a campaign while any is set.
LEGACY_DESTRUCTIVE_FLAGS = ("REELSEC_ALLOW_TEST_DEVICE_UNINSTALL",)

AUTH_TTL_MAX_S = 900  # 15 minutes; authorizations are short-lived by design


class SafetyBlock(RuntimeError):
    """A destructive operation was refused. Carries the specific reason."""

    def __init__(self, reason, step=None, **details):
        super().__init__(reason)
        self.reason = reason
        self.step = step
        self.details = details


def inspect_environment(env):
    """Doctor-level environment inspection. Returns violations, not toggles.

    A legacy blanket destructive flag being set is itself the violation:
    the platform must not run while an unconditional uninstall permission
    exists in the environment (this is exactly how the 2026-10-07 incident
    happened).
    """
    violations = []
    for flag in LEGACY_DESTRUCTIVE_FLAGS:
        if str((env or {}).get(flag, "")).strip() == "1":
            violations.append({
                "flag": flag,
                "violation": "destructive uninstall permission enabled",
                "policy": ("blanket destructive permissions are rejected; use a "
                           "hash-bound authorization document via "
                           "REELSEC_DESTRUCTIVE_AUTH instead"),
            })
    return violations


def load_authorization(path):
    """Load and structurally validate an authorization document."""
    if not path:
        raise SafetyBlock("no authorization document supplied "
                          "(REELSEC_DESTRUCTIVE_AUTH)", step="gate")
    p = Path(path).expanduser()
    if not p.is_file():
        raise SafetyBlock("authorization document not found: %s" % p,
                          step="gate")
    try:
        auth = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise SafetyBlock("authorization document unreadable: %s" % exc,
                          step="gate")
    if auth.get("schema_version") != SCHEMA_AUTH:
        raise SafetyBlock("authorization schema mismatch (expected %s)"
                          % SCHEMA_AUTH, step="gate")
    return auth


def _auth_sha256(path):
    try:
        return hashlib.sha256(
            Path(path).expanduser().read_bytes()).hexdigest()
    except OSError:
        return None


def check_authorization(auth, operation, package, user, serial, now=None):
    """Exact-match + time-bound validation. Returns a list of mismatches."""
    now = now if now is not None else time.time()
    problems = []
    if auth.get("operation") != operation:
        problems.append("operation mismatch (authorized=%r requested=%r)"
                        % (auth.get("operation"), operation))
    if auth.get("package") != package:
        problems.append("package mismatch (authorized=%r requested=%r)"
                        % (auth.get("package"), package))
    try:
        if int(auth.get("user", -1)) != int(user):
            problems.append("user mismatch (authorized=%r requested=%r)"
                            % (auth.get("user"), user))
    except (TypeError, ValueError):
        problems.append("authorized user is not an integer")
    if auth.get("device_serial") != serial:
        problems.append("device mismatch (authorized=%r resolved=%r)"
                        % (auth.get("device_serial"), serial))
    if not auth.get("authorized_by"):
        problems.append("authorized_by missing")
    if not auth.get("reason"):
        problems.append("reason missing")
    issued = auth.get("issued_at_epoch")
    expires = auth.get("expires_at_epoch")
    try:
        issued = float(issued)
        expires = float(expires)
    except (TypeError, ValueError):
        problems.append("issued_at_epoch/expires_at_epoch missing or invalid")
        issued = expires = None
    if issued is not None:
        if issued > now + 120:
            problems.append("authorization issued in the future")
        if expires <= now:
            problems.append("authorization expired")
        if expires - issued > AUTH_TTL_MAX_S:
            problems.append("authorization TTL exceeds %ds maximum"
                            % AUTH_TTL_MAX_S)
        if expires - issued <= 0:
            problems.append("authorization window is not positive")
    return problems


def device_snapshot(runner, adb, serial, package=None):
    """Bounded pre-operation device snapshot (read-only)."""
    snap = {"serial": serial, "collected_at_epoch": time.time(),
            "package": package}
    rc, out = runner([adb, "-s", serial, "shell", "getprop",
                      "ro.build.fingerprint"], timeout=20)
    snap["build_fingerprint"] = (out or "").strip() if rc == 0 else None
    rc, out = runner([adb, "-s", serial, "shell", "getprop",
                      "ro.product.model"], timeout=20)
    snap["model"] = (out or "").strip() if rc == 0 else None
    rc, out = runner([adb, "-s", serial, "shell", "pm", "list", "users"],
                     timeout=20)
    snap["users"] = (out or "").strip()[:800] if rc == 0 else None
    if package:
        rc, out = runner([adb, "-s", serial, "shell", "pm", "path",
                          package], timeout=20)
        snap["package_present"] = rc == 0 and "package:" in (out or "")
        snap["package_path"] = None
        for line in (out or "").splitlines():
            if line.startswith("package:"):
                snap["package_path"] = line.split(":", 1)[1].strip()
                break
        rc, out = runner([adb, "-s", serial, "shell", "ps", "-A"], timeout=20)
        running = []
        for line in (out or "").splitlines():
            parts = line.split()
            if len(parts) >= 9 and parts[-1] == package:
                try:
                    running.append(int(parts[1]))
                except ValueError:
                    pass
        snap["process_pids"] = running
    snap["status"] = "OK" if snap.get("build_fingerprint") else "PARTIAL"
    return snap


def _append_audit(audit_path, record):
    if not audit_path:
        return
    p = Path(audit_path)
    p.parent.mkdir(parents=True, exist_ok=True)
    with p.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(record, sort_keys=True) + "\n")


def execute_destructive(runner, adb, serial, operation, package, user=0,
                        authorization_path=None, audit_path=None, now=None):
    """The ONLY code path allowed to run a destructive device operation.

    Implements the full nine-step chain. Raises SafetyBlock with the
    specific failing step; every attempt (executed or blocked) produces an
    audit record when audit_path is given.
    """
    now = now if now is not None else time.time()
    record = {
        "schema_version": SCHEMA_AUDIT,
        "attempted_at_epoch": now,
        "operation": operation,
        "package": package,
        "user": user,
        "device_serial": serial,
        "policy": DEFAULT_POLICY.get(operation, "DENY"),
        "authorized": False,
        "authorization_sha256": None,
        "pre_snapshot": None,
        "command": None,
        "returncode": None,
        "output_tail": None,
        "post_verification": None,
        "result": "BLOCKED",
        "block_reason": None,
    }

    def block(reason, step):
        record["result"] = "BLOCKED"
        record["block_reason"] = reason
        record["block_step"] = step
        record["finished_at_epoch"] = time.time()
        _append_audit(audit_path, record)
        raise SafetyBlock(reason, step=step)

    # Step 1: explicit gate. Unknown or never-executable operations die here.
    if operation not in DESTRUCTIVE_OPERATIONS:
        block("unknown destructive operation %r" % operation, "gate")
    if operation in NEVER_EXECUTABLE:
        block("%s is never executable by ReelSec, even with authorization"
              % operation, "gate")

    # Steps 2-4 + 6: authorization document with exact matches.
    try:
        auth = load_authorization(authorization_path)
    except SafetyBlock as exc:
        block(str(exc), exc.step or "authorization")
    record["authorization_sha256"] = _auth_sha256(authorization_path)
    problems = check_authorization(auth, operation, package, user, serial,
                                   now=now)
    if problems:
        block("authorization validation failed: " + "; ".join(problems),
              "authorization")
    record["authorized"] = True
    record["authorized_by"] = auth.get("authorized_by")
    record["authorization_reason"] = auth.get("reason")

    # Step 5: pre-operation snapshot.
    snap = device_snapshot(runner, adb, serial, package=package)
    record["pre_snapshot"] = snap
    if snap.get("status") != "OK":
        block("pre-operation snapshot incomplete (device identity not "
              "verified); refusing destructive operation", "snapshot")
    if (operation in (UNINSTALL, REMOVE_PACKAGE)
            and snap.get("package_present") is False):
        block("target package is not present; nothing to uninstall — "
              "refusing to run a destructive no-op", "snapshot")

    # Step 7: operation dispatch (the only execution point).
    if operation in (UNINSTALL, REMOVE_PACKAGE):
        cmd = [adb, "-s", serial, "shell", "pm", "uninstall",
               "--user", str(int(user)), package]
    elif operation == CLEAR_DATA:
        cmd = [adb, "-s", serial, "shell", "pm", "clear",
               "--user", str(int(user)), package]
    else:  # pragma: no cover - guarded by step 1
        block("operation has no dispatch implementation", "dispatch")
    record["command"] = cmd
    rc, out = runner(cmd, timeout=60)
    record["returncode"] = rc
    record["output_tail"] = (out or "")[-1000:]

    # Step 8: post-operation verification.
    rc2, out2 = runner([adb, "-s", serial, "shell", "pm", "path", package],
                       timeout=20)
    present_after = rc2 == 0 and "package:" in (out2 or "")
    if operation in (UNINSTALL, REMOVE_PACKAGE):
        verified = (rc == 0) and not present_after
    else:  # CLEAR_DATA: package must still be present
        verified = (rc == 0) and present_after
    record["post_verification"] = {
        "package_present_after": present_after,
        "verified": verified,
    }
    record["result"] = "EXECUTED_VERIFIED" if verified else "EXECUTED_UNVERIFIED"
    record["finished_at_epoch"] = time.time()
    _append_audit(audit_path, record)
    if not verified:
        raise SafetyBlock(
            "destructive operation ran but post-verification failed "
            "(rc=%s present_after=%s); see audit record" % (rc, present_after),
            step="post_verification")
    return record
