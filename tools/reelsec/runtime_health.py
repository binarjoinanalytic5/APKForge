"""ReelSec runtime health: artifact crash gate + crash classification + baseline comparison.

Root-cause mandate (2026-10-07): the instrumented test artifact of
com.newleaf.app.android.victor was observed to crash repeatedly at startup
(dumpsys activity exit-info: reason=5 APP CRASH(NATIVE) status=6, plus
reason=4 APP CRASH(EXCEPTION); process death after MainActivity). The old
platform masked this as READY -> CAPTURED -> RUNTIME_PROBE_TIMEOUT, which
misattributed an artifact runtime integrity failure to the probe window.

This module makes artifact health a FIRST-CLASS GATE:

    Install -> Launch -> Process Health Gate -> Crash Detection
          -> Baseline/Artifact Comparison -> (only then) Module/Probe/Target

Principles:
* ApplicationExitInfo (`dumpsys activity exit-info`) is the primary,
  non-root source for process-death diagnosis.
* Never wait for a probe timeout to discover a crash.
* Never invent a crash cause: unknown stays CRASH_CAUSE_UNKNOWN.
* Never suppress, bypass, or mask a crash; this module only OBSERVES and
  CLASSIFIES. It never patches, disables protection, or mutates APKs.
* Baseline vs instrumented comparison separates instrumentation regression
  from a baseline (application-level) runtime failure.
"""

import hashlib
import re
import time
import zipfile
from pathlib import Path

SCHEMA = "runtime-health-1"

# ApplicationExitInfo reason codes (android.app.ApplicationExitInfo).
EXIT_INFO_REASONS = {
    0: "UNKNOWN", 1: "EXIT_SELF", 2: "SIGNALED", 3: "LOW_MEMORY",
    4: "APP_CRASH_EXCEPTION", 5: "APP_CRASH_NATIVE", 6: "ANR",
    7: "INITIALIZATION_FAILURE", 8: "PERMISSION_CHANGE",
    9: "EXCESSIVE_RESOURCE_USAGE", 10: "USER_REQUESTED", 11: "USER_STOPPED",
    12: "DEPENDENCY_DIED", 13: "OTHER", 14: "FREEZER",
    15: "PACKAGE_STATE_CHANGE", 16: "PACKAGE_UPDATED",
}

# Crash classification vocabulary (required minimum).
NATIVE_CRASH = "NATIVE_CRASH"
JAVA_EXCEPTION = "JAVA_EXCEPTION"
PROCESS_KILLED = "PROCESS_KILLED"
ANR = "ANR"
STARTUP_FAILURE = "STARTUP_FAILURE"
PACKAGE_NOT_PRESENT = "PACKAGE_NOT_PRESENT"
PROCESS_NOT_OBSERVED = "PROCESS_NOT_OBSERVED"
MODULE_NOT_OBSERVED = "MODULE_NOT_OBSERVED"
PROBE_ATTACH_FAILED = "PROBE_ATTACH_FAILED"
TARGET_NOT_EXECUTED = "TARGET_NOT_EXECUTED"
HEALTHY = "HEALTHY"

CAUSE_UNKNOWN = "CRASH_CAUSE_UNKNOWN"

# Regression verdicts (requirement 4).
REGRESSION_CONFIRMED = "INSTRUMENTATION_REGRESSION_CONFIRMED"
BASELINE_RUNTIME_FAILURE = "BASELINE_RUNTIME_FAILURE"
BOTH_START_OK = "BOTH_START_OK"
BASELINE_CRASH_INSTRUMENTED_OK = "BASELINE_CRASH_INSTRUMENTED_OK"
NOT_COMPARABLE = "NOT_COMPARABLE"

CONF_HIGH = "HIGH"
CONF_MEDIUM = "MEDIUM"
CONF_LOW = "LOW"
CONF_NONE = "NONE"

REASON_CODE_ARTIFACT_CRASH = "RUNTIME_ARTIFACT_CRASH"
REASON_CODE_INTEGRITY = "ARTIFACT_INTEGRITY_FAILURE"

_FATAL_RE = re.compile(r"Fatal signal\s+(\d+)\s+\((SIG[A-Z0-9]+)\)", re.I)
_FRAME_RE = re.compile(
    r"#\d{2}\s+pc\s+([0-9a-fA-F]+)\s+(\S+?\.so)(?:!\S+)?(?:\s+\(([^)]*)\))?")
_ABORT_RE = re.compile(r"Abort message:\s*'?(.*?)'?\s*$")
_EXIT_PKG_RE = re.compile(r"Package\s+\[([^\]]+)\]")
_EXIT_FIELD_RE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*[:=]\s*(.*)$")
_REASON_RE = re.compile(r"reason=(\d+)(?:\s*\((.+)\))?\s*$")


def parse_exit_info(text):
    """Parse `dumpsys activity exit-info <pkg>` output into structured entries.

    Recognized lines: 'Package [name]', then indented 'KEY: value' /
    'key=value' fields (UID, PID, Timestamp, reason=N (NAME), status=N,
    importance, description, trace, ...). User is derived from UID
    (Android uid = user * 100000 + appid).
    """
    entries = []
    current = None
    for line in (text or "").splitlines():
        m = _EXIT_PKG_RE.search(line)
        if m:
            current = {"package": m.group(1), "user": None, "uid": None,
                       "pid": None, "timestamp": None, "reason_code": None,
                       "reason_name": None, "status": None, "importance": None,
                       "description": None, "trace": None, "raw": []}
            entries.append(current)
            continue
        if current is None:
            continue
        current["raw"].append(line.strip()[:200])
        fm = _EXIT_FIELD_RE.match(line)
        if not fm:
            continue
        key, value = fm.group(1), fm.group(2).strip()
        low = key.lower()
        if low == "uid":
            try:
                current["uid"] = int(value.split()[0])
                current["user"] = current["uid"] // 100000
            except ValueError:
                pass
        elif low == "pid":
            try:
                current["pid"] = int(value.split()[0])
            except ValueError:
                pass
        elif low == "timestamp":
            current["timestamp"] = value
        elif low == "reason":
            rm = _REASON_RE.search(value) or _REASON_RE.search("reason=" + value)
            if rm:
                current["reason_code"] = int(rm.group(1))
                current["reason_name"] = (rm.group(2) or "").strip() or \
                    EXIT_INFO_REASONS.get(current["reason_code"])
            else:
                current["reason_name"] = value
        elif low == "status":
            try:
                current["status"] = int(value.split()[0])
            except ValueError:
                current["status"] = value
        elif low == "importance":
            current["importance"] = value
        elif low == "description":
            current["description"] = value[:500]
        elif low == "trace":
            current["trace"] = value[:300]
    for e in entries:
        if e["reason_code"] is not None and not e["reason_name"]:
            e["reason_name"] = EXIT_INFO_REASONS.get(e["reason_code"])
    return entries


def _entry_key(e):
    return (e.get("uid"), e.get("pid"), e.get("timestamp"),
            e.get("reason_code"), e.get("status"))


def new_exit_entries(pre_entries, post_entries):
    """Exit-info entries that appeared after the pre-launch snapshot.

    Set-difference keyed by (uid, pid, timestamp, reason, status) so stale
    crashes from earlier sessions can never trigger the gate, regardless of
    device clock skew.
    """
    seen = {_entry_key(e) for e in (pre_entries or [])}
    return [e for e in (post_entries or []) if _entry_key(e) not in seen]


def parse_tombstone_logcat(text, package=None):
    """Extract crash forensics from logcat (crash buffer / DEBUG tombstone echo).

    Non-root source. Returns fatal signals, backtrace frames (index, pc,
    library basename, symbol), abort messages, and whether the crash lines
    are associated with the target package.
    """
    fatal_signal = None
    fatal_status = None
    frames = []
    abort_message = None
    pid = tid = None
    thread_name = None
    package_lines = []
    fatal_lines = []
    truncated = package[-15:] if package and len(package) > 15 else package
    for line in (text or "").splitlines():
        stripped = line.strip()
        fm = _FATAL_RE.search(stripped)
        if fm:
            fatal_lines.append(stripped[:240])
            if fatal_signal is None:
                fatal_signal = fm.group(2)
                fatal_status = fm.group(1)
            if package and (package in stripped or (truncated and truncated in stripped)):
                package_lines.append(stripped[:240])
        frm = _FRAME_RE.search(stripped)
        if frm:
            lib = frm.group(2)
            if "!" in lib:
                lib = lib.split("!")[-1]
            frames.append({
                "pc": frm.group(1),
                "library": lib.rsplit("/", 1)[-1],
                "library_path": frm.group(2),
                "symbol": (frm.group(3) or "").strip() or None,
            })
        am = _ABORT_RE.search(stripped)
        if am and abort_message is None:
            abort_message = am.group(1)[:300]
        pm = re.search(r"pid:\s*(\d+),\s*tid:\s*(\d+),\s*name:\s*(\S+)", stripped)
        if pm:
            pid, tid, thread_name = int(pm.group(1)), int(pm.group(2)), pm.group(3)
            if package and package in stripped:
                package_lines.append(stripped[:240])
        elif package and package in stripped:
            package_lines.append(stripped[:240])
    associated = bool(package_lines) or (
        bool(package) and thread_name and (
            package in thread_name or (truncated and truncated in thread_name)))
    return {
        "fatal_signal": fatal_signal,
        "fatal_status": fatal_status,
        "fatal_lines": fatal_lines[:5],
        "backtrace_frames": frames[:40],
        "abort_message": abort_message,
        "pid": pid,
        "tid": tid,
        "thread_name": thread_name,
        "package_associated": associated,
        "package_matched_lines": package_lines[:10],
    }


def classify_crash(package, exit_entries, tombstone, process_observed,
                   pids=None, package_present=True, stage="PROCESS_HEALTH_GATE"):
    """Deterministic crash classification from collected evidence.

    Returns a dict with the required audit fields: crash_class, confidence,
    reason, evidence_source, timestamp, pid, user, package, stage.
    Priority: ApplicationExitInfo (authoritative) > logcat tombstone >
    process observation. Never invents a class when evidence is absent.
    """
    pids = pids or []
    base = {"package": package, "stage": stage, "timestamp": None, "pid": None,
            "user": None, "crash_class": None, "confidence": CONF_NONE,
            "reason": None, "evidence_source": None, "exit_reason_code": None,
            "exit_reason_name": None, "exit_status": None}
    if not package_present:
        base.update(crash_class=PACKAGE_NOT_PRESENT, confidence=CONF_HIGH,
                    reason="pm path reports no installed package",
                    evidence_source="adb:pm path")
        return base

    crash_entry = None
    for e in exit_entries or []:
        if e.get("reason_code") in (5, 4, 6, 7, 2):
            crash_entry = e
            break
        if e.get("reason_code") in (3, 12, 13) and crash_entry is None:
            crash_entry = e
    if crash_entry is not None:
        code = crash_entry.get("reason_code")
        cls = {5: NATIVE_CRASH, 4: JAVA_EXCEPTION, 6: ANR,
               7: STARTUP_FAILURE}.get(code)
        if cls is None:
            cls = PROCESS_KILLED
        base.update(
            crash_class=cls, confidence=CONF_HIGH,
            reason="ApplicationExitInfo reason=%s (%s)" % (
                code, crash_entry.get("reason_name") or EXIT_INFO_REASONS.get(code)),
            evidence_source="adb:dumpsys activity exit-info (ApplicationExitInfo)",
            timestamp=crash_entry.get("timestamp"), pid=crash_entry.get("pid"),
            user=crash_entry.get("user"),
            exit_reason_code=code, exit_reason_name=crash_entry.get("reason_name"),
            exit_status=crash_entry.get("status"),
        )
        if crash_entry.get("trace"):
            base["tombstone_path"] = crash_entry["trace"]
        return base

    if tombstone and tombstone.get("fatal_signal") and tombstone.get("package_associated"):
        base.update(
            crash_class=NATIVE_CRASH, confidence=CONF_MEDIUM,
            reason="fatal signal %s in logcat associated with package" %
                   tombstone["fatal_signal"],
            evidence_source="adb:logcat -b crash (tombstone echo)",
            pid=tombstone.get("pid"),
        )
        return base

    if not process_observed:
        base.update(
            crash_class=PROCESS_NOT_OBSERVED, confidence=CONF_MEDIUM,
            reason="launch invoked but no process observed in bounded window; "
                   "no exit-info entry and no fatal signal captured",
            evidence_source="adb:ps polling + exit-info + logcat",
        )
        return base

    base.update(crash_class=HEALTHY, confidence=CONF_MEDIUM,
                reason="process observed alive; no new crash exit-info entry "
                       "and no package-associated fatal signal",
                evidence_source="adb:ps polling + exit-info + logcat")
    if pids:
        base["pid"] = pids[0]
    return base


def identify_crash_cause(classification, tombstone=None, maps_text=None,
                         frida_events=None, exit_entries=None):
    """Attribute the crash to a library/cause using only available sources.

    Never depends on /data/tombstones being readable (non-root devices).
    If attribution is impossible: CRASH_CAUSE_UNKNOWN with the searched
    source list. Never invents a cause.
    """
    searched = []
    evidence = []
    tombstone = tombstone or {}
    cause = CAUSE_UNKNOWN
    fault_library = None
    confidence = CONF_NONE

    if tombstone.get("backtrace_frames"):
        searched.append("logcat backtrace frames")
        first = tombstone["backtrace_frames"][0]
        fault_library = first["library"]
        evidence.append("first backtrace frame: #%s pc %s in %s" % (
            "00", first["pc"], first["library_path"]))
        if tombstone.get("package_associated"):
            cause = "NATIVE_LIBRARY:%s" % fault_library
            confidence = CONF_HIGH
        else:
            cause = "NATIVE_LIBRARY:%s" % fault_library
            confidence = CONF_MEDIUM
            evidence.append("crash lines not explicitly package-associated; "
                            "attribution downgraded to MEDIUM")
    elif tombstone.get("fatal_signal"):
        searched.append("logcat fatal signal")
        evidence.append("fatal signal %s captured without backtrace frames" %
                        tombstone["fatal_signal"])
        cause = "NATIVE_SIGNAL:%s" % tombstone["fatal_signal"]
        confidence = CONF_LOW

    if tombstone.get("abort_message"):
        searched.append("logcat abort message")
        evidence.append("abort message: %s" % tombstone["abort_message"])
        if cause == CAUSE_UNKNOWN:
            cause = "NATIVE_ABORT"
            confidence = CONF_LOW

    for e in exit_entries or []:
        if e.get("trace"):
            searched.append("ApplicationExitInfo trace field")
            evidence.append("tombstone recorded at %s (not read; non-root)" %
                            e["trace"])
            break

    if maps_text:
        searched.append("/proc/<pid>/maps (alive window)")
        libs = sorted({ln.split()[-1].rsplit("/", 1)[-1]
                       for ln in maps_text.splitlines()
                       if ln.strip().endswith(".so")})
        evidence.append("loaded native modules during life: %s" %
                        (", ".join(libs[:30]) or "none"))
    else:
        searched.append("/proc/<pid>/maps (unavailable without privilege)")

    if frida_events:
        searched.append("frida observation (pre-crash)")
        observed = [ev.get("module") for ev in frida_events
                    if ev.get("event") == "MODULE_OBSERVED"]
        evidence.append("modules observed before crash: %s" %
                        (", ".join(str(m) for m in observed) or "none"))

    if not searched:
        searched.append("no crash sources available")

    return {
        "cause": cause,
        "fault_library": fault_library,
        "confidence": confidence,
        "evidence": evidence[:15],
        "searched_sources": searched,
    }


def query_exit_info(runner, adb, serial, package):
    rc, out = runner([adb, "-s", serial, "shell", "dumpsys", "activity",
                      "exit-info", package], timeout=30)
    return {
        "entries": parse_exit_info(out) if rc == 0 else [],
        "returncode": rc,
        "source": "adb:dumpsys activity exit-info %s" % package,
        "available": rc == 0,
    }


def _launch_package(runner, adb, serial, package):
    started = time.time()
    rc, out = runner([adb, "-s", serial, "shell", "monkey", "-p", package,
                      "-c", "android.intent.category.LAUNCHER", "1"], timeout=20)
    return rc, (out or "")[-2000:], started


def _poll_process(runner, adb, serial, package, observe_s, interval=1.0):
    deadline = time.time() + observe_s
    first_seen = last_seen = None
    pids = []
    attempts = 0
    while time.time() < deadline:
        attempts += 1
        rc, out = runner([adb, "-s", serial, "shell", "ps", "-A"], timeout=20)
        pids = []
        for line in (out or "").splitlines():
            parts = line.split()
            if len(parts) >= 9 and parts[-1] == package:
                try:
                    pids.append(int(parts[1]))
                except ValueError:
                    pass
        now = time.time()
        if pids:
            if first_seen is None:
                first_seen = now
            last_seen = now
        time.sleep(interval)
    alive_at_exit = bool(pids)
    alive_ms = int((last_seen - first_seen) * 1000) if first_seen else 0
    return {"pids": pids, "observed": first_seen is not None,
            "alive_ms": alive_ms, "alive_at_exit": alive_at_exit,
            "poll_attempts": attempts}


def assess_startup(runner, adb, serial, package, label="instrumented",
                   launch=True, observe_s=8, interval=1.0, pre_entries=None):
    """Process Health Gate: launch, observe bounded, classify death.

    Returns the RUNTIME-HEALTH record (requirement 9). Read-only against the
    device except the launch itself. Never retries unboundedly, never
    suppresses crashes, never waits for a probe timeout.
    """
    started = time.time()
    if pre_entries is None:
        pre = query_exit_info(runner, adb, serial, package)
    else:
        pre = {"entries": pre_entries, "available": True, "returncode": 0,
               "source": "caller-provided snapshot"}

    launch_rc = launch_output = None
    if launch:
        launch_rc, launch_output, _ = _launch_package(runner, adb, serial, package)

    proc = _poll_process(runner, adb, serial, package, observe_s, interval)

    post = query_exit_info(runner, adb, serial, package)
    fresh = new_exit_entries(pre.get("entries"), post.get("entries"))

    rc, crash_text = runner([adb, "-s", serial, "logcat", "-b", "crash", "-d",
                             "-t", "400"], timeout=40)
    tombstone = parse_tombstone_logcat(crash_text, package) if rc == 0 else \
        parse_tombstone_logcat("", package)
    tombstone["source"] = "adb:logcat -b crash -d -t 400" if rc == 0 else \
        "crash buffer unavailable (rc=%s)" % rc

    maps_text = None
    if proc["pids"]:
        mrc, mout = runner([adb, "-s", serial, "shell", "cat",
                            "/proc/%d/maps" % proc["pids"][0]], timeout=15)
        if mrc == 0 and mout:
            maps_text = mout[-20000:]

    classification = classify_crash(package, fresh, tombstone, proc["observed"],
                                    pids=proc["pids"])
    cause = identify_crash_cause(classification, tombstone=tombstone,
                                 maps_text=maps_text, exit_entries=fresh)

    crashed = classification["crash_class"] in (NATIVE_CRASH, JAVA_EXCEPTION,
                                                ANR, STARTUP_FAILURE,
                                                PROCESS_KILLED)
    if classification["crash_class"] == PACKAGE_NOT_PRESENT:
        startup = "PACKAGE_NOT_PRESENT"
    elif crashed:
        startup = "CRASH"
    elif classification["crash_class"] == PROCESS_NOT_OBSERVED:
        startup = "NOT_STARTED"
    else:
        startup = "PASS"

    health = {
        "schema_version": SCHEMA,
        "package": package,
        "artifact_type": "INSTRUMENTED_TEST_ARTIFACT" if label == "instrumented"
                         else "ORIGINAL_APK" if label == "original" else label,
        "startup": startup,
        "process_observed": proc["observed"],
        "process_alive_ms": proc["alive_ms"],
        "process_alive_at_exit": proc["alive_at_exit"],
        "pids": proc["pids"],
        "launch_returncode": launch_rc,
        "exit_reason": ("reason=%s (%s)" % (
            classification["exit_reason_code"], classification["exit_reason_name"])
            if classification.get("exit_reason_code") is not None else None),
        "exit_status": classification.get("exit_status"),
        "crash_class": classification["crash_class"],
        "crash_source": classification["evidence_source"],
        "crash_cause": cause["cause"],
        "crash_cause_library": cause["fault_library"],
        "crash_cause_confidence": cause["confidence"],
        "classification": classification,
        "cause_analysis": cause,
        "runtime_probe_allowed": startup == "PASS",
        "elapsed_ms": int((time.time() - started) * 1000),
        "evidence": {
            "exit_info_pre_count": len(pre.get("entries") or []),
            "exit_info_new_entries": fresh[:10],
            "exit_info_source": post.get("source"),
            "tombstone": tombstone,
            "maps_captured": bool(maps_text),
        },
    }
    return health


def static_artifact_profile(apk_path, manifest_decoder=None):
    """Read-only static profile of an APK for baseline comparison."""
    apk = Path(apk_path)
    prof = {"artifact": str(apk), "exists": apk.is_file(), "package": None,
            "abis": [], "native_libs": [], "signature_blocks": False,
            "sha256": None, "size_bytes": None}
    if not apk.is_file():
        return prof
    h = hashlib.sha256()
    with apk.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    prof["sha256"] = h.hexdigest()
    prof["size_bytes"] = apk.stat().st_size
    try:
        with zipfile.ZipFile(apk) as zf:
            names = zf.namelist()
            prof["native_libs"] = sorted(n for n in names
                                         if n.startswith("lib/") and n.endswith(".so"))
            prof["abis"] = sorted({n.split("/")[1] for n in prof["native_libs"]
                                   if len(n.split("/")) >= 3})
            prof["signature_blocks"] = any(
                n.upper().startswith("META-INF/") and
                n.upper().endswith((".RSA", ".DSA", ".EC")) for n in names)
            if manifest_decoder is not None:
                try:
                    data = zf.read("AndroidManifest.xml")
                    prof["package"] = manifest_decoder(data)
                except Exception:
                    pass
    except zipfile.BadZipFile as exc:
        prof["zip_error"] = str(exc)
    return prof


def compare_artifacts(baseline_health, instrumented_health,
                      baseline_profile=None, instrumented_profile=None):
    """Baseline vs instrumented runtime+static comparison (requirement 4).

    ORIGINAL_STARTUP=PASS + INSTRUMENTED_STARTUP=CRASH =>
    INSTRUMENTATION_REGRESSION_CONFIRMED. Both crash =>
    BASELINE_RUNTIME_FAILURE (never attributed to ReelSec).
    """
    def _s(h):
        return (h or {}).get("startup")
    bs, ins = _s(baseline_health), _s(instrumented_health)
    if bs is None or ins is None:
        status = NOT_COMPARABLE
        note = "missing health record: %s" % (
            "baseline" if bs is None else "instrumented")
    elif bs == "PASS" and ins == "CRASH":
        status = REGRESSION_CONFIRMED
        note = ("original artifact starts cleanly while the instrumented "
                "artifact crashes: regression introduced by instrumentation "
                "(see INSTRUMENTATION-IMPACT.json for change linkage)")
    elif bs == "CRASH" and ins == "CRASH":
        status = BASELINE_RUNTIME_FAILURE
        note = ("both artifacts crash: baseline runtime failure; NOT "
                "attributed to ReelSec instrumentation")
    elif bs == "PASS" and ins == "PASS":
        status = BOTH_START_OK
        note = "both artifacts start cleanly"
    elif bs == "CRASH" and ins == "PASS":
        status = BASELINE_CRASH_INSTRUMENTED_OK
        note = "baseline crashes but instrumented artifact starts: record and investigate baseline"
    else:
        status = NOT_COMPARABLE
        note = "non-crash startup states: baseline=%s instrumented=%s" % (bs, ins)

    diff = {}
    if baseline_profile and instrumented_profile:
        bl = set(baseline_profile.get("native_libs") or [])
        il = set(instrumented_profile.get("native_libs") or [])
        diff = {
            "package_same": (baseline_profile.get("package") ==
                             instrumented_profile.get("package")),
            "baseline_package": baseline_profile.get("package"),
            "instrumented_package": instrumented_profile.get("package"),
            "abis_baseline": baseline_profile.get("abis"),
            "abis_instrumented": instrumented_profile.get("abis"),
            "missing_in_instrumented": sorted(bl - il),
            "added_in_instrumented": sorted(il - bl),
            "lib_count_baseline": len(bl),
            "lib_count_instrumented": len(il),
        }
    return {
        "schema_version": SCHEMA,
        "regression_status": status,
        "attribution_note": note,
        "baseline": {
            "startup": bs,
            "crash_class": (baseline_health or {}).get("crash_class"),
            "crash_cause": (baseline_health or {}).get("crash_cause"),
            "exit_reason": (baseline_health or {}).get("exit_reason"),
            "process_alive_ms": (baseline_health or {}).get("process_alive_ms"),
        },
        "instrumented": {
            "startup": ins,
            "crash_class": (instrumented_health or {}).get("crash_class"),
            "crash_cause": (instrumented_health or {}).get("crash_cause"),
            "exit_reason": (instrumented_health or {}).get("exit_reason"),
            "process_alive_ms": (instrumented_health or {}).get("process_alive_ms"),
        },
        "profile_diff": diff,
    }


def runtime_verdict(baseline_health, instrumented_health, comparison=None,
                    runtime_probe=None, probe_allowed=None):
    """Compact autonomous verdict (requirement 12)."""
    comparison = comparison or compare_artifacts(baseline_health, instrumented_health)
    ih = instrumented_health or {}
    if probe_allowed is None:
        probe_allowed = ih.get("runtime_probe_allowed")
    proof = "NOT_RUN"
    if runtime_probe:
        st = runtime_probe.get("status")
        if st == "PROVEN_RUNTIME_TARGET_DISPATCH":
            proof = "TARGET_OBSERVED"
        elif st == "RUNTIME_ARTIFACT_CRASH":
            proof = "BLOCKED_BY_ARTIFACT_CRASH"
        elif st in ("RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED",
                    "RUNTIME_TARGET_NOT_OBSERVED"):
            proof = "NOT_OBSERVED"
        else:
            proof = st or "NOT_RUN"

    if ih.get("startup") == "CRASH":
        if comparison["regression_status"] == REGRESSION_CONFIRMED:
            next_action = ("Instrumentation regression confirmed: review "
                           "INSTRUMENTATION-IMPACT.json change linkage; do NOT "
                           "run further probe rounds until the injected "
                           "loader/gadget change set is reduced or rebuilt.")
        elif comparison["regression_status"] == BASELINE_RUNTIME_FAILURE:
            next_action = ("Baseline runtime failure: the unmodified original "
                           "also crashes on this device/build; do not attribute "
                           "to ReelSec. Record device/build constraints; runtime "
                           "proof remains blocked.")
        else:
            next_action = ("Artifact crash without baseline comparison: run the "
                           "gated baseline round (REELSEC_ALLOW_TEST_DEVICE_"
                           "UNINSTALL=1) to attribute the failure.")
    elif probe_allowed is False:
        next_action = "Runtime probe blocked: %s" % ih.get("crash_class")
    elif proof in ("NOT_RUN", "NOT_OBSERVED"):
        next_action = "Artifact healthy: bounded runtime probe is permitted."
    else:
        next_action = "Runtime proof recorded; evaluate evidence gate."

    return {
        "schema_version": SCHEMA,
        "ORIGINAL_RUNTIME": (baseline_health or {}).get("startup") or "NOT_RUN",
        "INSTRUMENTED_RUNTIME": ih.get("startup") or "NOT_RUN",
        "CRASH_CLASS": ih.get("crash_class"),
        "CRASH_CAUSE": ih.get("crash_cause"),
        "CRASH_CAUSE_CONFIDENCE": ih.get("crash_cause_confidence"),
        "REGRESSION_STATUS": comparison["regression_status"],
        "RUNTIME_PROOF_STATUS": proof,
        "runtime_probe_allowed": bool(probe_allowed),
        "NEXT_ACTION": next_action,
    }
