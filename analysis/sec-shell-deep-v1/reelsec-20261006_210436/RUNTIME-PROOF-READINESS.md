# Runtime Proof Readiness

Package: com.newleaf.app.android.victor
Native module: libsaasCorePlayer.so
Target offset: 0x27a510
Expected vptr: 0x717e60
Expected slot result: 0x27a510

Status: FRIDA_PROBE_FAILED
Reason: Frida runtime probe exited non-zero

ADB and Frida client discovery are reported independently. The probe is observational and does not replace or mutate the target. Runtime proof requires a target entry event with both the expected vptr and expected slot result.
