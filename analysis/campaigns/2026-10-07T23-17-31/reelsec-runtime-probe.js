
const TARGET_OFFSET = ptr("0x27a510");
const TARGET_VTABLE = ptr("0x717e60");
const TARGET_SLOT = 264;
const MODULE_NAME = "libsaasCorePlayer.so";
const WINDOW_MS = 12000;
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
send({event: "READY", package: "com.newleaf.app.android.victor", module: MODULE_NAME,
      target_offset: TARGET_OFFSET.toString()});
setTimeout(function () {
  send({event: "TIMEOUT_WINDOW_COMPLETE", target_seen: targetSeen});
}, WINDOW_MS);
