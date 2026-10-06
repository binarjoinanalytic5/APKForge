const TARGET_OFFSET = ptr("0x27a510");
const TARGET_VTABLE = ptr("0x717e60");
const TARGET_SLOT = 0x108;
const MODULE_NAME = "libsaasCorePlayer.so";
function hookModule(m) {
  try {
    const target = m.base.add(TARGET_OFFSET);
    Interceptor.attach(target, {
      onEnter(args) {
        let vptr = ptr("0x0");
        let slot = ptr("0x0");
        try { vptr = args[0].readPointer(); } catch (_) {}
        try { slot = vptr.add(TARGET_SLOT).readPointer(); } catch (_) {}
        send({event:"TARGET_FUNCTION_ENTER",module:m.name,base:m.base.toString(),
          pc:this.context.pc.toString(),object:args[0].toString(),vptr:vptr.toString(),
          slot:slot.toString(),expected_vptr:TARGET_VTABLE.toString(),
          expected_slot:ptr("0x27a510").toString(),return_address:this.returnAddress.toString(),
          target_vptr_match:vptr.equals(TARGET_VTABLE),
          target_slot_match:slot.equals(ptr("0x27a510"))});
      }
    });
    send({event:"HOOK_INSTALLED",module:m.name,base:m.base.toString(),target:target.toString()});
    return true;
  } catch(e) { send({event:"HOOK_ERROR",module:m.name,error:String(e)}); return false; }
}
let installed=false;
const existing=Process.findModuleByName(MODULE_NAME);
if(existing) installed=hookModule(existing);
if(!installed) Process.attachModuleObserver({onAdded(module){
  if(!installed && module.name===MODULE_NAME) installed=hookModule(module);
}});
send({event:"READY",package:"UNKNOWN",module:MODULE_NAME,target_offset:TARGET_OFFSET.toString()});
setTimeout(()=>{send({event:"TIMEOUT_WINDOW_COMPLETE"});Interceptor.detachAll();},12000);
