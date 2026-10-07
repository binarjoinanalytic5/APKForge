#!/usr/bin/env python3
"""Staged runtime-probe lifecycle diagnostics (schema runtime-probe-lifecycle-1).

Turns the previously opaque RUNTIME_PROBE_TIMEOUT_NO_TARGET_OBSERVED into an
auditable stage chain:

    ADB_CONNECTED -> PACKAGE_RESOLVED -> PACKAGE_PRESENT ->
    APP_LAUNCH_ATTEMPTED -> PROCESS_OBSERVED -> TARGET_PROCESS_CONFIRMED ->
    MODULE_WAIT_STARTED -> MODULE_OBSERVED -> PROBE_ATTACHED ->
    TARGET_RESOLUTION -> TARGET_OBSERVED

Every stage records status, timestamp, reason code (on failure), source of
truth, and elapsed time. Reason codes separate the failure layers:

    ADB_UNAVAILABLE / ADB_NO_ONLINE_DEVICE / ADB_DEVICE_RESOLUTION_AMBIGUOUS
    PACKAGE_NAME_UNRESOLVED / PACKAGE_NOT_INSTALLED
    APP_NOT_STARTED                          (A)
    TARGET_PROCESS_NOT_OBSERVED              (B)
    TARGET_MODULE_NOT_OBSERVED               (C)
    PROBE_ATTACH_FAILED                      (D)
    TARGET_NOT_EXECUTED_BEFORE_TIMEOUT       (E)
    TARGET_OBSERVED                          (F)
    PROBE_TIMEOUT_AFTER_VALID_ATTACH         (G)

This module is observation-only: it launches the test package, watches
process/module state, and records evidence. It never patches, disables, or
bypasses any protection mechanism. TARGET_OBSERVED proves a runtime layer
only (L3); it is never behavioral proof (L4).
"""
import json
import time

SCHEMA = "runtime-probe-lifecycle-1"

# Reason codes (spec A-G plus pre-launch layers)
ADB_UNAVAILABLE = "ADB_UNAVAILABLE"
ADB_NO_ONLINE_DEVICE = "ADB_NO_ONLINE_DEVICE"
PACKAGE_NAME_UNRESOLVED = "PACKAGE_NAME_UNRESOLVED"
PACKAGE_NOT_INSTALLED = "PACKAGE_NOT_INSTALLED"
APP_NOT_STARTED = "APP_NOT_STARTED"                                    # A
TARGET_PROCESS_NOT_OBSERVED = "TARGET_PROCESS_NOT_OBSERVED"            # B
TARGET_MODULE_NOT_OBSERVED = "TARGET_MODULE_NOT_OBSERVED"              # C
PROBE_ATTACH_FAILED = "PROBE_ATTACH_FAILED"                            # D
TARGET_NOT_EXECUTED_BEFORE_TIMEOUT = "TARGET_NOT_EXECUTED_BEFORE_TIMEOUT"  # E
TARGET_OBSERVED = "TARGET_OBSERVED"                                    # F
PROBE_TIMEOUT_AFTER_VALID_ATTACH = "PROBE_TIMEOUT_AFTER_VALID_ATTACH"  # G

PASS, FAIL, SKIP, PENDING = "PASS", "FAIL", "SKIP", "PENDING"

RUNTIME_STAGE_ORDER = (
    "MODULE_WAIT_STARTED",
    "MODULE_OBSERVED",
    "PROBE_ATTACHED",
    "TARGET_RESOLUTION",
    "TARGET_OBSERVED",
)


def make_stage(name, status, reason_code=None, source=None, started=None, **fields):
    now = time.time()
    stage = {
        "stage": name,
        "status": status,
        "timestamp_epoch": now,
        "elapsed_ms": int((now - started) * 1000) if started else None,
        "source": source,
    }
    if reason_code:
        stage["reason_code"] = reason_code
    stage.update(fields)
    return stage


def build_probe_js(module_name, package, window_ms=12000,
                   target_offset="0x27a510", target_vtable="0x717e60",
                   target_slot=0x108):
    """Probe script using only documented Frida JS APIs.

    The previous script used Process.attachModuleObserver, which does not
    exist in the Frida JS API; when the target module was not yet loaded the
    script died with a TypeError before sending READY, producing empty events
    and an unexplained timeout. This version polls findModuleByName on an
    interval and reports every lifecycle transition as an event.
    """
    module_lit = json.dumps(module_name)
    package_lit = json.dumps(package or "UNKNOWN")
    return r'''
const TARGET_OFFSET = ptr("%(off)s");
const TARGET_VTABLE = ptr("%(vtable)s");
const TARGET_SLOT = %(slot)d;
const MODULE_NAME = %(module)s;
const WINDOW_MS = %(window)d;
let targetSeen = false;
send({event: "PROBE_ATTACHED", pid: Process.id, arch: Process.arch,
      platform: Process.platform, pointer_size: Process.pointerSize});
function hookModule(m) {
  try {
    const target = m.base.add(TARGET_OFFSET);
    Interceptor.attach(target, {
      onEnter(args) {
        let vptr = ptr("0x0");
        let slot = ptr("0x0");
        try { vptr = args[0].readPointer(); } catch (_) {}
        try { slot = vptr.add(TARGET_SLOT).readPointer(); } catch (_) {}
        targetSeen = true;
        send({event: "TARGET_FUNCTION_ENTER", module: m.name,
              base: m.base.toString(), pc: this.context.pc.toString(),
              object: args[0].toString(), vptr: vptr.toString(),
              slot: slot.toString(),
              expected_vptr: TARGET_VTABLE.toString(),
              expected_slot: TARGET_OFFSET.toString(),
              return_address: this.returnAddress.toString(),
              target_vptr_match: vptr.equals(TARGET_VTABLE),
              target_slot_match: slot.equals(TARGET_OFFSET)});
      }
    });
    send({event: "TARGET_RESOLUTION", module: m.name, base: m.base.toString(),
          target: target.toString(), hook: "INSTALLED"});
    return true;
  } catch (e) {
    send({event: "HOOK_ERROR", module: m.name, error: String(e)});
    return false;
  }
}
function tryObserveModule() {
  const m = Process.findModuleByName(MODULE_NAME);
  if (!m) return false;
  send({event: "MODULE_OBSERVED", module: m.name, base: m.base.toString(),
        size: m.size, path: m.path});
  hookModule(m);
  return true;
}
let observed = tryObserveModule();
if (!observed) {
  send({event: "MODULE_WAIT_STARTED", module: MODULE_NAME});
  const iv = setInterval(function () {
    if (!observed && tryObserveModule()) { observed = true; clearInterval(iv); }
  }, 250);
  setTimeout(function () { clearInterval(iv); }, Math.max(WINDOW_MS - 500, 500));
}
send({event: "READY", package: %(package)s, module: MODULE_NAME,
      target_offset: TARGET_OFFSET.toString()});
setTimeout(function () {
  send({event: "TIMEOUT_WINDOW_COMPLETE", target_seen: targetSeen});
}, WINDOW_MS);
''' % {
        "off": target_offset, "vtable": target_vtable, "slot": target_slot,
        "module": module_lit, "package": package_lit, "window": int(window_ms),
    }


def parse_probe_events(frida_output):
    events = []
    for line in (frida_output or "").splitlines():
        line = line.strip()
        if not line.startswith("{"):
            continue
        try:
            item = json.loads(line)
        except ValueError:
            continue
        if not isinstance(item, dict):
            continue
        payload = item.get("payload")
        if isinstance(payload, dict) and payload.get("event"):
            events.append(payload)
        elif item.get("event"):
            events.append(item)
    return events


def check_package_present(runner, adb, serial, package):
    """pm path + version lookup. Read-only device queries."""
    started = time.time()
    rc, out = runner([adb, "-s", serial, "shell", "pm", "path", package], timeout=20)
    path = None
    for line in (out or "").splitlines():
        if line.startswith("package:"):
            path = line.split(":", 1)[1].strip()
            break
    version = None
    rc2, out2 = runner([adb, "-s", serial, "shell", "dumpsys", "package", package],
                       timeout=30)
    for line in (out2 or "").splitlines():
        if "versionName=" in line:
            version = line.split("versionName=", 1)[1].split()[0].strip()
            break
    present = bool(path)
    stage = make_stage(
        "PACKAGE_PRESENT", PASS if present else FAIL,
        reason_code=None if present else PACKAGE_NOT_INSTALLED,
        source="adb:pm path %s" % package, started=started,
        package=package, installed_path=path, version_name=version,
        pm_returncode=rc,
    )
    return present, stage


def observe_process(runner, adb, serial, package, attempts=12, interval=1.0):
    """Bounded ps polling for the package process. Observation only."""
    started = time.time()
    pids = []
    observed = False
    last_output = ""
    for i in range(attempts):
        rc, out = runner([adb, "-s", serial, "shell", "ps", "-A"], timeout=20)
        last_output = (out or "")[-4000:]
        pids = []
        for line in (out or "").splitlines():
            parts = line.split()
            if len(parts) >= 9 and parts[-1] == package:
                try:
                    pids.append(int(parts[1]))
                except ValueError:
                    pass
        if pids:
            observed = True
            break
        if i + 1 < attempts:
            time.sleep(interval)
    stage = make_stage(
        "PROCESS_OBSERVED", PASS if observed else FAIL,
        reason_code=None if observed else TARGET_PROCESS_NOT_OBSERVED,
        source="adb:ps -A polling x%d" % attempts, started=started,
        package=package, pids=pids,
    )
    return observed, pids, stage


def derive_lifecycle(events, frida_rc=None, process_stage=None,
                     package_stage=None, launch=None, adb_stage=None,
                     window_completed=None):
    """Derive the runtime stage chain + reason code from collected evidence.

    events: parsed probe events. frida_rc: frida CLI exit code (124 = killed
    by bounded timeout). The derivation is pure: same inputs, same verdict.
    """
    stages = []
    if adb_stage:
        stages.append(adb_stage)
    if package_stage:
        stages.append(package_stage)
    if launch is not None:
        stages.append(launch)
    if process_stage:
        stages.append(process_stage)
        confirmed = process_stage["status"] == PASS
        stages.append(make_stage(
            "TARGET_PROCESS_CONFIRMED", PASS if confirmed else FAIL,
            reason_code=None if confirmed else TARGET_PROCESS_NOT_OBSERVED,
            source="derived:PROCESS_OBSERVED",
            pid=(process_stage.get("pids") or [None])[0],
            package=process_stage.get("package"),
        ))

    by_event = {}
    for e in events:
        by_event.setdefault(e.get("event"), []).append(e)

    attached = "PROBE_ATTACHED" in by_event
    module_wait = "MODULE_WAIT_STARTED" in by_event
    module_seen = "MODULE_OBSERVED" in by_event
    resolved = "TARGET_RESOLUTION" in by_event
    matches = [
        e for e in by_event.get("TARGET_FUNCTION_ENTER", [])
        if e.get("target_vptr_match") is True and e.get("target_slot_match") is True
    ]
    if window_completed is None:
        window_completed = bool(by_event.get("TIMEOUT_WINDOW_COMPLETE"))

    pid = None
    if by_event.get("PROBE_ATTACHED"):
        pid = by_event["PROBE_ATTACHED"][0].get("pid")

    stages.append(make_stage(
        "PROBE_ATTACHED", PASS if attached else FAIL,
        reason_code=None if attached else PROBE_ATTACH_FAILED,
        source="frida:event PROBE_ATTACHED", pid=pid,
    ))
    stages.append(make_stage(
        "MODULE_WAIT_STARTED", PASS if (module_wait or module_seen) else SKIP,
        source="frida:event MODULE_WAIT_STARTED",
    ))
    stages.append(make_stage(
        "MODULE_OBSERVED", PASS if module_seen else (FAIL if attached else SKIP),
        reason_code=TARGET_MODULE_NOT_OBSERVED if (attached and not module_seen) else None,
        source="frida:event MODULE_OBSERVED",
        module=(by_event.get("MODULE_OBSERVED") or [{}])[0].get("module"),
        base=(by_event.get("MODULE_OBSERVED") or [{}])[0].get("base"),
    ))
    stages.append(make_stage(
        "TARGET_RESOLUTION", PASS if resolved else (FAIL if module_seen else SKIP),
        source="frida:event TARGET_RESOLUTION",
        hook_error=(by_event.get("HOOK_ERROR") or [{}])[0].get("error"),
    ))
    stages.append(make_stage(
        "TARGET_OBSERVED", PASS if matches else (FAIL if resolved else SKIP),
        reason_code=None if matches else (
            TARGET_NOT_EXECUTED_BEFORE_TIMEOUT if resolved else None),
        source="frida:event TARGET_FUNCTION_ENTER (vptr+slot predicate)",
        match_count=len(matches),
    ))

    # Reason code: deepest failing layer wins. Order matters: a frida exit
    # code never masks an earlier layer failure (launch/package/adb).
    if matches:
        reason = TARGET_OBSERVED
    elif resolved or (attached and module_seen):
        reason = PROBE_TIMEOUT_AFTER_VALID_ATTACH if (
            frida_rc == 124 and not window_completed) else TARGET_NOT_EXECUTED_BEFORE_TIMEOUT
    elif attached:
        reason = TARGET_MODULE_NOT_OBSERVED
    elif process_stage is not None and process_stage["status"] != PASS:
        reason = TARGET_PROCESS_NOT_OBSERVED
    elif launch is not None and launch["status"] != PASS:
        reason = APP_NOT_STARTED
    elif package_stage is not None and package_stage["status"] != PASS:
        reason = PACKAGE_NOT_INSTALLED
    elif adb_stage is not None and adb_stage["status"] != PASS:
        reason = adb_stage.get("reason_code") or ADB_NO_ONLINE_DEVICE
    elif frida_rc is not None:
        reason = PROBE_ATTACH_FAILED
    else:
        reason = PACKAGE_NAME_UNRESOLVED

    lifecycle = {
        "process_observed": bool(process_stage and process_stage["status"] == PASS) or pid is not None,
        "pid": pid or (process_stage.get("pids") or [None])[0] if process_stage else pid,
        "module_observed": module_seen,
        "module": (by_event.get("MODULE_OBSERVED") or [{}])[0].get("module"),
        "probe_attached": attached,
        "target_resolution": resolved,
        "target_observed": bool(matches),
        "runtime_matches": len(matches),
        "reason_code": reason,
        "window_completed": window_completed,
        "frida_exit": frida_rc,
    }
    return {"schema_version": SCHEMA, "stages": stages,
            "lifecycle": lifecycle, "reason_code": reason}
