#!/usr/bin/env python3
"""A/B/C differential-isolation matrix for crash causation.

The no-gadget run proved Frida Gadget is not required for the crash, but a
single original-vs-instrumented differential cannot separate the remaining
deltas: apktool rebuild, re-signing, and the LOG_I_PROBE telemetry probe.
This module defines the three-arm experiment that separates them:

* Arm A — the untouched original, test-signed with the isolated test key.
  No apktool rebuild, no mutation of any kind.
* Arm B — apktool rebuild + re-signing with the SAME test key, zero
  mutations (no probe, no Gadget). Crash delta against A isolates
  repackaging/signing.
* Arm C — apktool rebuild + LOG_I_PROBE telemetry probe + re-signing,
  no Gadget. Crash delta against B isolates the probe.

Every arm installs with `adb install -r` only (never uninstall,
never clear-data) and is bound by post-install byte + certificate
identity before any launch is assessed. Arms that fail to install or
to verify identity are BLOCKED, never assessed, and the decision
degrades to INCONCLUSIVE rather than guessing.

Decision rules (evaluated in order):
* A unusable            -> INCONCLUSIVE (no baseline, nothing attributable)
* A crashed             -> NOT_REELSEC_CAUSE (the original itself crashes;
                           ReelSec changes are excluded as the cause)
* A healthy, B crashed  -> REPACKAGING_SIGNING_CANDIDATE
* A+B healthy, C crashed -> TELEMETRY_PROBE_CANDIDATE
* A+B+C healthy         -> NO_CRASH_REPRODUCED
A missing B or C degrades its rule to INCONCLUSIVE. Generic
"instrumentation" is never named as the cause: candidates always name
the specific separated delta.
"""
import os


class IsolationError(RuntimeError):
    pass


SCHEMA_ARM = "isolation-arm-1"
SCHEMA_DECISION = "isolation-decision-1"
MATRIX_ENV = "REELSEC_ISOLATION_MATRIX"
GADGET_ENV = "REELSEC_USE_GADGET"

ARM_A = "A"
ARM_B = "B"
ARM_C = "C"
ARMS = (ARM_A, ARM_B, ARM_C)

ARM_DESCRIPTIONS = {
    ARM_A: "original APK test-signed with the isolated test key; no rebuild, no mutation",
    ARM_B: "apktool rebuild + re-signing, zero mutations (no probe, no Gadget)",
    ARM_C: "apktool rebuild + LOG_I_PROBE telemetry probe + re-signing, no Gadget",
}

# Arm lifecycle states.
ARM_HEALTHY = "HEALTHY"
ARM_CRASHED = "CRASHED"
ARM_BLOCKED_INSTALL = "BLOCKED_INSTALL"
ARM_BLOCKED_IDENTITY = "BLOCKED_IDENTITY"
ARM_BLOCKED_ASSESS = "BLOCKED_ASSESS"
ASSESSABLE_ARM_STATES = (ARM_HEALTHY, ARM_CRASHED)

# Decision states.
NOT_REELSEC_CAUSE = "NOT_REELSEC_CAUSE"
REPACKAGING_SIGNING_CANDIDATE = "REPACKAGING_SIGNING_CANDIDATE"
TELEMETRY_PROBE_CANDIDATE = "TELEMETRY_PROBE_CANDIDATE"
NO_CRASH_REPRODUCED = "NO_CRASH_REPRODUCED"
INCONCLUSIVE = "INCONCLUSIVE"

REGRESSION_SUSPECTED = "SUSPECTED_NOT_PROVEN"
REGRESSION_NOT_ESTABLISHED = "NOT_ESTABLISHED"


def plan_matrix(env=None):
    """Select the isolation arms to run (fail-closed).

    REELSEC_ISOLATION_MATRIX holds the arm letters (default "ABC";
    subsets such as "AB" rerun part of the matrix). Unknown letters or an
    empty selection raise IsolationError. Gadget is refused outright: the
    matrix separates rebuild from probe, and Gadget belongs to neither
    delta at this stage.
    """
    values = env if env is not None else os.environ
    if str(values.get(GADGET_ENV, "")).strip().lower() in (
            "1", "true", "yes"):
        raise IsolationError(
            "isolation matrix refuses %s: Gadget is excluded from the "
            "rebuild-vs-probe differential at this stage" % GADGET_ENV)
    raw = str(values.get(MATRIX_ENV, "ABC") or "ABC").strip().upper()
    arms = []
    for letter in raw:
        if letter in ARMS and letter not in arms:
            arms.append(letter)
        elif letter not in ARMS and not letter.isspace():
            raise IsolationError(
                "unknown %s arm %r: expected letters from ABC"
                % (MATRIX_ENV, letter))
    if not arms:
        raise IsolationError(
            "%s selects no arms; nothing would be isolated" % MATRIX_ENV)
    return {"arms": arms, "source": MATRIX_ENV, "requested": raw,
            "descriptions": {arm: ARM_DESCRIPTIONS[arm] for arm in arms}}


def crash_signature(arm_record):
    """Comparable crash signature of an arm record (or None).

    signal|library|pc — enough to tell whether two arms failed the same
    way without merging their independent evidence.
    """
    crash = (arm_record or {}).get("crash") or {}
    signal = crash.get("fatal_signal")
    if not signal:
        return None
    return "%s|%s|%s" % (signal, crash.get("fault_library"),
                         crash.get("fault_pc"))


def build_arm_record(*, arm, artifact_sha256, certificate_sha256,
                     install, identity, assess):
    """Assemble one arm's isolation record from primitive outputs.

    `install` is {success, mode, output_tail}; `identity` is the
    post-install identity record (must read MATCH for assessment);
    `assess` is the assess_startup health dict (or None when the arm was
    never launched). Malformed inputs raise IsolationError; honest
    failures become BLOCKED_* states, never guesses.
    """
    if arm not in ARMS:
        raise IsolationError("unknown isolation arm %r" % (arm,))
    install = install or {}
    identity = identity or {}
    if "success" not in install:
        raise IsolationError(
            "arm %s: install result lacks a success flag" % arm)
    record = {
        "schema_version": SCHEMA_ARM,
        "arm": arm,
        "description": ARM_DESCRIPTIONS[arm],
        "artifact_sha256": artifact_sha256,
        "certificate_sha256": certificate_sha256,
        "install": {
            "success": bool(install.get("success")),
            "stage": install.get("stage") or "install",
            "mode": install.get("mode"),
            "output_tail": (install.get("output_tail") or "")[-1000:],
        },
        "post_install_identity": identity,
        "pids": None,
        "session_bound": None,
        "crash": {"fatal_signal": None, "fault_library": None,
                  "fault_pc": None, "abort_message_present": None},
        "startup": None,
        "startup_stage": None,
        "observed_ms": None,
    }
    if not install.get("success"):
        record["status"] = ARM_BLOCKED_INSTALL
        record["reason"] = ("%s failed; the arm was never assessed: %s"
                            % (install.get("stage") or "install",
                               (install.get("output_tail") or "")
                               [-500:] or "no output"))
        return record
    if identity.get("identity") != "MATCH":
        record["status"] = ARM_BLOCKED_IDENTITY
        record["reason"] = ("post-install identity %s: %s; the on-device "
                            "build is not this arm's artifact, so it was "
                            "never assessed"
                            % (identity.get("identity"),
                               identity.get("reason") or "unverified"))
        return record
    if not artifact_sha256 or not certificate_sha256:
        raise IsolationError(
            "arm %s: an installed arm must record artifact and "
            "certificate digests" % arm)
    health = assess or {}
    startup = health.get("startup")
    record["pids"] = health.get("pids")
    record["session_bound"] = health.get("crash_session_binding")
    artifact = health.get("crash_artifact") or {}
    fault = artifact.get("fault_location") or {}
    record["crash"] = {
        "fatal_signal": artifact.get("fatal_signal"),
        "fault_library": fault.get("library"),
        "fault_pc": fault.get("pc"),
        "abort_message_present": artifact.get("abort_message_present"),
    }
    record["startup"] = startup
    record["startup_stage"] = health.get("startup_stage")
    record["observed_ms"] = health.get("process_alive_ms")
    if startup == "PASS":
        record["status"] = ARM_HEALTHY
        record["reason"] = ("arm installed, identity MATCH, process ran "
                            "healthy in its observation window")
    elif startup == "CRASH":
        record["status"] = ARM_CRASHED
        record["reason"] = ("arm installed, identity MATCH, process "
                            "crashed: %s" % (crash_signature(record)
                                             or "unresolved signature"))
    else:
        record["status"] = ARM_BLOCKED_ASSESS
        record["reason"] = ("arm installed and identity MATCH, but no "
                            "startup verdict was established (startup=%s)"
                            % (startup,))
    return record


def _usable(arms, letter):
    record = (arms or {}).get(letter) or {}
    if record.get("status") in ASSESSABLE_ARM_STATES:
        return record
    return None


def _signatures_note(arms):
    crashed = [letter for letter in ARMS
               if ((arms or {}).get(letter) or {}).get("status")
               == ARM_CRASHED]
    signatures = {letter: crash_signature((arms or {}).get(letter))
                  for letter in crashed}
    known = {letter: sig for letter, sig in signatures.items() if sig}
    if len(known) < 2:
        return signatures, None, None
    equal = len(set(known.values())) == 1
    if equal:
        note = ("crashed arms share one crash signature (%s): the same "
                "failure across arms" % next(iter(set(known.values()))))
    else:
        note = ("crashed arms show DIFFERING crash signatures: each arm "
                "may have failed its own way; cross-arm linkage is weak")
    return signatures, equal, note


def decide_isolation(arms):
    """Apply the isolation decision rules to recorded arms.

    `arms` maps arm letters to build_arm_record outputs; absent letters
    were not run. Returns the ISOLATION-DECISION document. Missing arms
    degrade to INCONCLUSIVE — the decision never guesses across an
    unrun arm.
    """
    arms = arms or {}
    for letter in arms:
        if letter not in ARMS:
            raise IsolationError("unknown isolation arm %r" % (letter,))
    if not arms:
        raise IsolationError("no isolation arms recorded; nothing to decide")
    signatures, signatures_equal, sig_note = _signatures_note(arms)
    states = {letter: ((arms.get(letter) or {}).get("status")
                       or "NOT_RUN")
              for letter in ARMS}
    base = {"schema_version": SCHEMA_DECISION,
            "arm_states": states,
            "crash_signatures": signatures,
            "crash_signatures_equal": signatures_equal}

    arm_a = _usable(arms, ARM_A)
    if arm_a is None:
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_NO_BASELINE",
                    detail=("arm A (test-signed original) is %s: without a "
                            "valid original-side baseline nothing is "
                            "attributable" % states[ARM_A]),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=[],
                    next_action=("Establish arm A first: install the "
                                 "test-signed original with install -r "
                                 "only and record its startup. No causal "
                                 "claim is possible before that."))
    if arm_a["status"] == ARM_CRASHED:
        others = {letter: states[letter]
                  for letter in (ARM_B, ARM_C)
                  if states[letter] in ASSESSABLE_ARM_STATES}
        anomaly = any(state == ARM_HEALTHY for state in others.values())
        detail = ("arm A (test-signed original, no rebuild) crashed with "
                  "signature %s: the original itself fails, so ReelSec "
                  "changes are excluded as the cause"
                  % (crash_signature(arm_a) or "unresolved"))
        if sig_note:
            detail += "; " + sig_note[0].lower() + sig_note[1:]
        if anomaly:
            detail += ("; anomaly: a rebuild arm ran healthy while the "
                       "original crashed — suspect flakiness or "
                       "device-side state, still not instrumentation")
        return dict(base, status=NOT_REELSEC_CAUSE,
                    reason="ORIGINAL_CRASHES_UNMODIFIED",
                    detail=detail,
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[],
                    excluded=["apktool rebuild", "re-signing with test key",
                              "LOG_I_PROBE telemetry probe", "Frida Gadget"],
                    next_action=("The cause is outside ReelSec changes: "
                                 "investigate the original app build, the "
                                 "device/OS/ROM, or install state. Do not "
                                 "modify instrumentation to chase this "
                                 "crash."))
    arm_b = _usable(arms, ARM_B)
    if arm_b is None:
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_B_MISSING",
                    detail=("arm A is healthy but arm B (rebuild + "
                            "re-sign, no probe) is %s: repackaging cannot "
                            "be separated from the probe"
                            % states[ARM_B]),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm B (rebuild + re-sign with zero "
                                 "mutations) on the same device/session "
                                 "before any causal claim."))
    if arm_b["status"] == ARM_CRASHED:
        detail = ("arm A healthy, arm B (rebuild + re-sign, zero "
                  "mutations) crashed with signature %s: the "
                  "repackaging/signing delta suffices for the crash; the "
                  "telemetry probe is excluded"
                  % (crash_signature(arm_b) or "unresolved"))
        if sig_note:
            detail += "; " + sig_note[0].lower() + sig_note[1:]
        return dict(base, status=REPACKAGING_SIGNING_CANDIDATE,
                    reason="REBUILD_DELTA_SUFFICES",
                    detail=detail,
                    regression=REGRESSION_SUSPECTED,
                    candidates=["apktool rebuild + zipalign",
                                "re-signing with the isolated test key"],
                    excluded=["LOG_I_PROBE telemetry probe",
                              "Frida Gadget"],
                    next_action=("Narrow the repackaging delta: compare "
                                 "the rebuilt APK against the original "
                                 "(entries, compression, alignment, "
                                 "manifest/resources handling) and "
                                 "re-run the matrix after each narrowing. "
                                 "Do not blame the telemetry probe."))
    arm_c = _usable(arms, ARM_C)
    if arm_c is None:
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_C_MISSING",
                    detail=("arms A and B are healthy but arm C (rebuild "
                            "+ probe) is %s: the probe delta is untested"
                            % states[ARM_C]),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm C (rebuild + LOG_I_PROBE "
                                 "telemetry probe, no Gadget) on the same "
                                 "device/session before any causal claim."))
    if arm_c["status"] == ARM_CRASHED:
        detail = ("arms A and B healthy, arm C (rebuild + LOG_I_PROBE "
                  "probe) crashed with signature %s: only the probe "
                  "delta remains; the telemetry probe is the candidate"
                  % (crash_signature(arm_c) or "unresolved"))
        if sig_note:
            detail += "; " + sig_note[0].lower() + sig_note[1:]
        return dict(base, status=TELEMETRY_PROBE_CANDIDATE,
                    reason="PROBE_DELTA_ISOLATED",
                    detail=detail,
                    regression=REGRESSION_SUSPECTED,
                    candidates=["LOG_I_PROBE telemetry probe in "
                                "SecShell loader anchor"],
                    excluded=["apktool rebuild", "re-signing with test key",
                              "Frida Gadget"],
                    next_action=("Minimize the probe (fewer registers, "
                                 "later anchor, or probe-free rebuild) and "
                                 "re-run the matrix: arm C must turn "
                                 "healthy while A and B stay healthy."))
    return dict(base, status=NO_CRASH_REPRODUCED,
                reason="ALL_ARMS_HEALTHY",
                detail=("arms A, B, and C all ran healthy: the crash did "
                        "not reproduce in this matrix; no delta is "
                        "implicated"),
                regression=REGRESSION_NOT_ESTABLISHED,
                candidates=[], excluded=[],
                next_action=("The crash did not reproduce: lengthen the "
                             "observation window, vary device state, or "
                             "re-run; do not change instrumentation to "
                             "chase a non-reproducing crash."))
