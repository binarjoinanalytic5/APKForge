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

Narrowing inside B (the rebuild delta proved sufficient): B splits into
sub-arms that separate the apktool rebuild from page alignment:

* Arm B1 — apktool rebuild WITHOUT zipalign + re-signing, zero
  mutations. Crash delta against A isolates the raw rebuild.
* Arm B2 — apktool rebuild WITH 16 KiB page alignment + re-signing,
  zero mutations (same construction as B). Crash delta against B1
  isolates alignment.

Every arm installs with `adb install -r` only (never uninstall,
never clear-data) and is bound by post-install byte + certificate
identity before any launch is assessed. Arms that fail to install or
to verify identity are BLOCKED, never assessed, and the decision
degrades to INCONCLUSIVE rather than guessing.

Decision rules (evaluated in order; planned scope decides what counts
as missing — unplanned arms never force INCONCLUSIVE):
* A unusable            -> INCONCLUSIVE (no baseline, nothing attributable)
* A crashed             -> NOT_REELSEC_CAUSE (the original itself crashes;
                           ReelSec changes are excluded as the cause)
* A healthy, B1 crashed (B2 not healthy)
                        -> REBUILD_SUFFICES (alignment not required)
* A healthy, B1 crashed, B2 healthy
                        -> INCONCLUSIVE/ALIGNMENT_ORDER_ANOMALY
* A healthy, B1 healthy, B2 crashed
                        -> ALIGNMENT_CANDIDATE
* A healthy, B crashed (no B1/B2 narrowing)
                        -> REPACKAGING_SIGNING_CANDIDATE
* A+B healthy, C crashed -> TELEMETRY_PROBE_CANDIDATE
* all in-scope arms healthy -> NO_CRASH_REPRODUCED
Generic "instrumentation" is never named as the cause: candidates always
name the specific separated delta. No decision is final until its
comparison arms complete — missing arms degrade to INCONCLUSIVE.
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
ARM_B1 = "B1"
ARM_B2 = "B2"
ARM_C = "C"
ARMS = (ARM_A, ARM_B, ARM_C)
NARROW_ARMS = (ARM_B1, ARM_B2)
ALL_ARMS = (ARM_A, ARM_B, ARM_B1, ARM_B2, ARM_C)

ARM_DESCRIPTIONS = {
    ARM_A: "original APK test-signed with the isolated test key; no rebuild, no mutation",
    ARM_B: "apktool rebuild + re-signing, zero mutations (no probe, no Gadget)",
    ARM_B1: "apktool rebuild WITHOUT page alignment + re-signing, zero mutations (no probe, no Gadget)",
    ARM_B2: "apktool rebuild WITH 16 KiB page alignment + re-signing, zero mutations (no probe, no Gadget)",
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
REBUILD_SUFFICES = "REBUILD_SUFFICES"
ALIGNMENT_CANDIDATE = "ALIGNMENT_CANDIDATE"
TELEMETRY_PROBE_CANDIDATE = "TELEMETRY_PROBE_CANDIDATE"
NO_CRASH_REPRODUCED = "NO_CRASH_REPRODUCED"
INCONCLUSIVE = "INCONCLUSIVE"

REGRESSION_SUSPECTED = "SUSPECTED_NOT_PROVEN"
REGRESSION_NOT_ESTABLISHED = "NOT_ESTABLISHED"


def plan_matrix(env=None):
    """Select the isolation arms to run (fail-closed).

    REELSEC_ISOLATION_MATRIX holds the arm tokens (default "ABC";
    subsets such as "AB" rerun part of the matrix; "AB1B2" runs the
    rebuild narrowing). B splits into B1 (rebuild without alignment)
    and B2 (rebuild with alignment). Unknown tokens or an empty
    selection raise IsolationError. Gadget is refused outright: the
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
    index = 0
    while index < len(raw):
        letter = raw[index]
        if letter.isspace():
            index += 1
            continue
        if letter not in ARMS:
            raise IsolationError(
                "unknown %s arm %r: expected A, B, B1, B2, C"
                % (MATRIX_ENV, letter))
        token = letter
        if letter == ARM_B and index + 1 < len(raw) \
                and raw[index + 1] in ("1", "2"):
            token = "B" + raw[index + 1]
            index += 1
        if token not in arms:
            arms.append(token)
        index += 1
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
    if arm not in ALL_ARMS:
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
    crashed = [letter for letter in ALL_ARMS
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


def _lowered(note):
    return "; " + note[0].lower() + note[1:] if note else ""


def decide_isolation(arms, planned=None):
    """Apply the isolation decision rules to recorded arms.

    `arms` maps arm letters to build_arm_record outputs; `planned` is
    the arm scope the run intended (default ABC). Only in-scope arms
    count as missing — unplanned arms never force INCONCLUSIVE, though
    their recorded evidence still participates. Returns the
    ISOLATION-DECISION document.
    """
    arms = arms or {}
    for letter in arms:
        if letter not in ALL_ARMS:
            raise IsolationError("unknown isolation arm %r" % (letter,))
    if not arms:
        raise IsolationError("no isolation arms recorded; nothing to decide")
    scope = list(planned) if planned is not None else list(ARMS)
    for letter in scope:
        if letter not in ALL_ARMS:
            raise IsolationError(
                "unknown planned isolation arm %r" % (letter,))
    if not scope:
        raise IsolationError("isolation scope selects no arms")
    signatures, signatures_equal, sig_note = _signatures_note(arms)
    states = {letter: ((arms.get(letter) or {}).get("status")
                       or "NOT_RUN")
              for letter in ALL_ARMS}
    base = {"schema_version": SCHEMA_DECISION,
            "planned_arms": scope,
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
                  for letter in (ARM_B, ARM_B1, ARM_B2, ARM_C)
                  if states[letter] in ASSESSABLE_ARM_STATES}
        anomaly = any(state == ARM_HEALTHY for state in others.values())
        detail = ("arm A (test-signed original, no rebuild) crashed with "
                  "signature %s: the original itself fails, so ReelSec "
                  "changes are excluded as the cause"
                  % (crash_signature(arm_a) or "unresolved"))
        detail += _lowered(sig_note)
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
                              "page alignment",
                              "LOG_I_PROBE telemetry probe", "Frida Gadget"],
                    next_action=("The cause is outside ReelSec changes: "
                                 "investigate the original app build, the "
                                 "device/OS/ROM, or install state. Do not "
                                 "modify instrumentation to chase this "
                                 "crash."))
    # Narrowing slot: B1 is the unaligned rebuild; B2 (or B, identically
    # constructed) is the aligned rebuild.
    arm_b1 = _usable(arms, ARM_B1)
    arm_b2 = _usable(arms, ARM_B2)
    arm_b = _usable(arms, ARM_B)
    b2eff = arm_b2 if arm_b2 is not None else arm_b
    b2eff_name = ("arm B2" if arm_b2 is not None
                  else "arm B (same construction as B2)")

    def _narrowing_detail(template, **kwargs):
        detail = template % kwargs
        detail += _lowered(sig_note)
        return detail

    if arm_b1 is not None and arm_b1["status"] == ARM_CRASHED \
            and b2eff is not None and b2eff["status"] == ARM_HEALTHY:
        return dict(base, status=INCONCLUSIVE,
                    reason="ALIGNMENT_ORDER_ANOMALY",
                    detail=_narrowing_detail(
                        "arm B1 (rebuild WITHOUT alignment) crashed but "
                        "%(aligned)s ran healthy: alignment seemingly "
                        "suppresses the crash — suspect install-order "
                        "effects, device-side state, or flakiness rather "
                        "than a stable causal delta; no narrowing claim "
                        "is made",
                        aligned=b2eff_name),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Re-run the narrowing with reversed arm "
                                 "order (B2 before B1) on the same "
                                 "device/session before any causal claim."))
    if arm_b1 is not None and arm_b1["status"] == ARM_CRASHED:
        return dict(base, status=REBUILD_SUFFICES,
                    reason="UNALIGNED_REBUILD_CRASHES",
                    detail=_narrowing_detail(
                        "arm A healthy, arm B1 (rebuild WITHOUT alignment, "
                        "zero mutations) crashed with signature %(sig)s: "
                        "page alignment is NOT required for the crash — "
                        "the apktool rebuild delta alone suffices; the "
                        "telemetry probe is excluded",
                        sig=(crash_signature(arm_b1) or "unresolved")),
                    regression=REGRESSION_SUSPECTED,
                    candidates=["apktool rebuild (repacked content, "
                                "manifest/resources handling, compression, "
                                "entry ordering, signature-block layout)",
                                "re-signing with the isolated test key"],
                    excluded=["page alignment as a necessary cause",
                              "LOG_I_PROBE telemetry probe",
                              "Frida Gadget"],
                    next_action=("Narrow inside the rebuild: inspect "
                                 "ISOLATION-ARTIFACT-DIFF.json for the "
                                 "A-to-B1 entry/section changes and re-run "
                                 "the matrix after each narrowing. Do not "
                                 "blame alignment or the probe."))
    if arm_b1 is not None and arm_b1["status"] == ARM_HEALTHY \
            and b2eff is not None and b2eff["status"] == ARM_CRASHED:
        return dict(base, status=ALIGNMENT_CANDIDATE,
                    reason="ALIGNED_REBUILD_CRASHES",
                    detail=_narrowing_detail(
                        "arm A healthy, arm B1 (rebuild WITHOUT alignment) "
                        "healthy, %(aligned)s crashed with signature "
                        "%(sig)s: only the page-alignment delta remains; "
                        "alignment is the candidate",
                        aligned=b2eff_name,
                        sig=(crash_signature(b2eff) or "unresolved")),
                    regression=REGRESSION_SUSPECTED,
                    candidates=["zipalign 16 KiB page alignment (load "
                                "addresses and layout of mapped segments)"],
                    excluded=["unaligned apktool rebuild alone",
                              "LOG_I_PROBE telemetry probe",
                              "Frida Gadget"],
                    next_action=("Vary the alignment (4 KiB vs 16 KiB, "
                                 "align-vs-copy) and re-run B1/B2 on the "
                                 "same device/session: B2 must track the "
                                 "alignment change while B1 stays healthy."))
    if arm_b1 is not None and arm_b1["status"] == ARM_HEALTHY \
            and b2eff is None \
            and (ARM_B2 in scope or ARM_B in scope):
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_B2_MISSING",
                    detail=("arm A and arm B1 (rebuild WITHOUT alignment) "
                            "are healthy, but no aligned rebuild ran "
                            "(B2=%s, B=%s): the alignment delta is "
                            "untested" % (states[ARM_B2], states[ARM_B])),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm B2 (rebuild WITH 16 KiB page "
                                 "alignment, zero mutations) on the same "
                                 "device/session before any causal claim."))
    if arm_b1 is None and ARM_B1 in scope and b2eff is not None \
            and b2eff["status"] != ARM_CRASHED:
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_B1_MISSING",
                    detail=("arm A is healthy but arm B1 (rebuild WITHOUT "
                            "alignment) is %s: the raw rebuild delta is "
                            "untested, so alignment cannot be separated"
                            % states[ARM_B1]),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm B1 (rebuild WITHOUT page "
                                 "alignment, zero mutations) on the same "
                                 "device/session before any causal claim."))
    # B-slot: B, else B2 as the identically-constructed substitute.
    arm_beff = arm_b if arm_b is not None else arm_b2
    beff_name = ("arm B" if arm_b is not None else "arm B2")
    if arm_beff is not None and arm_beff["status"] == ARM_CRASHED:
        detail = ("arm A healthy, %s (rebuild + re-sign, zero "
                  "mutations) crashed with signature %s: the "
                  "repackaging/signing delta suffices for the crash; the "
                  "telemetry probe is excluded"
                  % (beff_name,
                     crash_signature(arm_beff) or "unresolved"))
        if ARM_B1 in scope and states[ARM_B1] not in \
                ASSESSABLE_ARM_STATES:
            detail += ("; arm B1 is %s — run it to separate alignment "
                       "from the raw rebuild" % states[ARM_B1])
        detail += _lowered(sig_note)
        return dict(base, status=REPACKAGING_SIGNING_CANDIDATE,
                    reason="REBUILD_DELTA_SUFFICES",
                    detail=detail,
                    regression=REGRESSION_SUSPECTED,
                    candidates=["apktool rebuild + zipalign",
                                "re-signing with the isolated test key"],
                    excluded=["LOG_I_PROBE telemetry probe",
                              "Frida Gadget"],
                    next_action=("Narrow the repackaging delta: run arms "
                                 "B1/B2 to separate alignment from the raw "
                                 "rebuild, and inspect "
                                 "ISOLATION-ARTIFACT-DIFF.json (entries, "
                                 "compression, alignment, "
                                 "manifest/resources handling). Do not "
                                 "blame the telemetry probe."))
    arm_c = _usable(arms, ARM_C)
    b_healthy = arm_beff is not None \
        and arm_beff["status"] == ARM_HEALTHY
    if b_healthy and arm_c is not None \
            and arm_c["status"] == ARM_CRASHED:
        detail = ("arms A and %s healthy, arm C (rebuild + LOG_I_PROBE "
                  "probe) crashed with signature %s: only the probe "
                  "delta remains; the telemetry probe is the candidate"
                  % (beff_name,
                     crash_signature(arm_c) or "unresolved"))
        detail += _lowered(sig_note)
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
    if b_healthy and ARM_C in scope and arm_c is None:
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_C_MISSING",
                    detail=("arms A and %s are healthy but arm C (rebuild "
                            "+ probe) is %s: the probe delta is untested"
                            % (beff_name, states[ARM_C])),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm C (rebuild + LOG_I_PROBE "
                                 "telemetry probe, no Gadget) on the same "
                                 "device/session before any causal claim."))
    if not b_healthy and (ARM_B in scope or ARM_B2 in scope):
        missing = ARM_B if ARM_B in scope else ARM_B2
        return dict(base, status=INCONCLUSIVE,
                    reason="INCONCLUSIVE_B_MISSING",
                    detail=("arm A is healthy but no aligned rebuild ran "
                            "(B=%s, B2=%s): repackaging cannot be "
                            "separated from the probe"
                            % (states[ARM_B], states[ARM_B2])),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=["Frida Gadget"],
                    next_action=("Run arm B (rebuild + re-sign with zero "
                                 "mutations) on the same device/session "
                                 "before any causal claim."))
    healthy_scope = [letter for letter in scope
                     if states.get(letter) == ARM_HEALTHY]
    if len(healthy_scope) == len(scope):
        # Non-reproduction is a claim over the whole comparison: it is
        # only established when a full discriminating set ran (the
        # outer matrix A+B+C or the narrowing A+B1+B2). An all-healthy
        # strict subset stays INCONCLUSIVE — the untested arms might
        # still crash.
        complete = set((ARM_A, ARM_B, ARM_C)) <= set(scope) \
            or set((ARM_A, ARM_B1, ARM_B2)) <= set(scope)
        if not complete:
            return dict(
                base, status=INCONCLUSIVE,
                reason="INCONCLUSIVE_SCOPE_PARTIAL",
                detail=("planned arms %s all ran healthy, but the "
                        "planned scope is a partial comparison (full "
                        "matrix is A+B+C, full narrowing is A+B1+B2): "
                        "non-reproduction is NOT established"
                        % ", ".join(scope)),
                regression=REGRESSION_NOT_ESTABLISHED,
                candidates=[], excluded=[],
                next_action=("Run the remaining arms of the full matrix "
                             "or the full narrowing on the same "
                             "device/session: an all-healthy subset "
                             "alone concludes nothing."))
        return dict(base, status=NO_CRASH_REPRODUCED,
                    reason="ALL_ARMS_HEALTHY",
                    detail=("in-scope arms %s all ran healthy: the crash "
                            "did not reproduce in this matrix; no delta "
                            "is implicated" % ", ".join(scope)),
                    regression=REGRESSION_NOT_ESTABLISHED,
                    candidates=[], excluded=[],
                    next_action=("The crash did not reproduce: lengthen the "
                                 "observation window, vary device state, or "
                                 "re-run; do not change instrumentation to "
                                 "chase a non-reproducing crash."))
    first_missing = next(
        (letter for letter in scope
         if states.get(letter) not in ASSESSABLE_ARM_STATES),
        None)
    return dict(base, status=INCONCLUSIVE,
                reason="INCONCLUSIVE_%s_MISSING" % (first_missing or "ARM",),
                detail=("arm %s is %s: the comparison cannot complete "
                        "without it"
                        % (first_missing, states.get(first_missing))),
                regression=REGRESSION_NOT_ESTABLISHED,
                candidates=[], excluded=[],
                next_action=("Re-run the matrix with arm %s completing "
                             "install, identity, and assessment on the "
                             "same device/session." % first_missing))
