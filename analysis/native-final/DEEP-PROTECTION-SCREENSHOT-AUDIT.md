# DEEP PROTECTION / SCREEN-CAPTURE AUDIT
## ReelShort v4.2.00 — libsaasCorePlayer + libSecShell

- Analysis commit: d0ca71d05d62e798f9b54c025324e2c3bc07c256
- Target: ReelShort v4.2.00
- Primary native library: libsaasCorePlayer.so
- Secondary native/security library: libSecShell.so
- Audit focus: screenshot/capture restriction, protected media path, Surface routing, DRM/Widevine, JNI bridge, and negative evidence.

## Evidence policy

- PROVEN = directly supported by an ELF symbol, function boundary, relocation, or executable ARM64 instruction sequence.
- STRONG = multiple independent artifacts support the architecture, but one direct link is missing.
- PLAUSIBLE = technically consistent but not proven.
- NOT PROVEN = insufficient evidence.
- NEGATIVE IN CURRENT CORPUS = no matching artifact found in the current report corpus; not proof of absolute absence.

Important address rule:
0x5xxxxx values such as 0x5a3059/0x5a42a6/0x5bc775 are generally .rodata string addresses unless explicitly identified as ELF function symbols. They must not be presented as function entry points.

## 1. Native function anchors

From analysis/auto-deep/jni/symbols-filtered.txt:

- 0x27702c, size 840: _ZN6Cicada14avcodecDecoder12init_decoderEPK11Stream_metaPvmPKNS_7DrmInfoE
- 0x2777f4, size 668: _ZN6Cicada14avcodecDecoder15enqueue_decoderERNSt6__ndk110unique_ptrI9IAFPacketNS1_14default_deleteIS3_EEEE
- 0x277d304, size 1132: _ZN13ActiveDecoder11decode_funcEv
- 0x27d02c, size 272: _ZN13ActiveDecoder4openEPK11Stream_metaPvmPKN6Cicada7DrmInfoE
- 0x27da90, size 460: _ZN13ActiveDecoder8needDropEP9IAFPacket
- 0x27dcf4, size 704: _ZN13ActiveDecoder18thread_send_packetERNSt6__ndk110unique_ptrI9IAFPacketNS0_14default_deleteIS2_EEEE
- 0x27e038, size 360: _ZN13ActiveDecoder15thread_getFrameERNSt6__ndk110unique_ptrI8IAFFrameNS0_14default_deleteIS3_EEEE

Confirmed vtable objects:
- 0x717ce0, size 368: _ZTVN6Cicada14avcodecDecoderE
- 0x718018, size 288: _ZTV13ActiveDecoder

Meaning:
The native decoder and ActiveDecoder layers have real ELF function symbols with explicit boundaries/sizes.

## 2. DRM / Widevine — PROVEN

Native strings and symbols include:
- parseContentProtection
- ContentProtection
- setDrmInfo
- initDrmHandler failure/state messages
- WideVineDrmHandler
- com/cicada/player/utils/media/DrmSessionManager
- drm prepared OK
- drm requestKey
- queueSecureInputBuffer
- setOutputSurface
- bytes_of_protected_data
- setForceInsecureDecoder

Additional DRM-specific strings explicitly mention:
- WideVine decode errors
- forcing hardware decoder when tunnelRender or isWideVine
- TextureView causing DRM decoder-init problems on Android
- SurfaceView preferred for DRM content
- DRM-protected content requiring proper keys
- Widevine L1/L3 certification checks

Decoder symbols also take Cicada::DrmInfo pointers:
- avcodecDecoder::init_decoder
- ActiveDecoder::open
and the symbol inventory contains avcodecDecoder::is_drmSupport and DrmHandlerPrototype::isSupport.

Conclusion: ReelShort contains a native DRM/Widevine-aware playback architecture.
Status: PROVEN.

## 3. Protected media packet state — PROVEN; playback call-site NOT PROVEN

Actual C++ symbol names:
- _ZN9IAFPacket11isProtectedEv => IAFPacket::isProtected()
- _ZN10AVAFPacket11isProtectedEv => AVAFPacket::isProtected()
- _ZN10AVAFPacket12setProtectedEv => AVAFPacket::setProtected()

This proves that packet objects have a protected-state concept.

No exact executable XREF/call site to these mangled names was recovered in the current report corpus.

Therefore:
- protected packet state exists: PROVEN
- protected state is invoked on the observed playback path: NOT PROVEN
- protected state directly drives screenshot restriction: NOT PROVEN

## 4. Secure decoder/output operations — PROVEN as indirect-dispatch contexts

### setForceInsecureDecoder
At executable VA 0x27af94:
  27af90: ldr  x1, [x22, #0x260]
  27af94: adrp x2, 0x5bc000
  27af98: adrp x3, 0x59d000
  27af9c: ldr  x8, [x8, #0x108]
  27afa0: add  x2, x2, #0x62e
  27afa4: add  x3, x3, #0xe71
  27afa8: mov  x0, x19
  27afac: blr  x8
0x5bc62e is rodata string "setForceInsecureDecoder".

Status:
- executable indirect-dispatch context: PROVEN
- exact vtable callee mapping: NOT PROVEN

### queueSecureInputBuffer
At executable VA 0x27b148:
  27b140: ldr  x8, [x19]
  27b144: ldr  x1, [x22, #0x260]
  27b148: adrp x2, 0x5bc000
  27b14c: adrp x3, 0x5bc000
  27b150: ldr  x8, [x8, #0x108]
  27b154: add  x2, x2, #0x6fa
  27b158: add  x3, x3, #0x711
  27b15c: mov  x0, x19
  27b160: blr  x8
0x5bc6fa is rodata string "queueSecureInputBuffer".

Status:
- executable indirect-dispatch context: PROVEN
- exact vtable callee mapping: NOT PROVEN

### setOutputSurface
At executable VA 0x27b220:
  27b218: ldr  x8, [x19]
  27b21c: ldr  x1, [x22, #0x260]
  27b220: adrp x2, 0x5bc000
  27b224: adrp x3, 0x5a2000
  27b228: ldr  x8, [x8, #0x108]
  27b22c: add  x2, x2, #0x775
  27b230: add  x3, x3, #0x64a
  27b234: mov  x0, x19
  27b238: blr  x8
0x5bc775 is rodata string "setOutputSurface".

Status:
- executable indirect-dispatch context: PROVEN
- exact vtable callee mapping: NOT PROVEN

Critical structural observation:
The same [object]->[vtable+0x108] + blr x8 pattern also appears in an onCaptureScreen context at 0x112f14-0x112f24. Therefore vtable slot +0x108 cannot be assumed to uniquely mean setOutputSurface without object-type/vtable reconstruction.

## 5. Java Surface -> native Surface -> ANativeWindow -> EGL — PROVEN at architecture level

Native strings:
- com/cicada/player/utils/DecoderSurfaceTexture
- DecoderSurface
- createSurface
- (IJ)Landroid/view/Surface;
- AndroidSurfaceHandle
- AndroidSurfaceHandle: invalid params env=%p jSurface=%p
- AndroidSurfaceHandle: ANativeWindow_fromSurface returned null
- Output surface is null, not rendering!
- Native window handle is null!
- EGLContext CreateSurface mDisplay %p mConfig %p window %p
- eglCreateWindowSurface finally failed!
- eglCreateWindowSurface surface: %p

ELF import evidence:
- ANativeWindow_fromSurface
- ANativeWindow_getHeight / getWidth
- ANativeWindow_acquire / release
- eglCreatePbufferSurface
- eglCreateWindowSurface
- eglDestroySurface

A real createGLSurface failure branch exists around 0x282598-0x2825d8, including conditional virtual calls and __log_print.

Conclusion:
The native player has a genuine Android Surface/ANativeWindow/EGL rendering path.
Status: PROVEN.

What remains unproven:
The current corpus does not show a direct call-site sequence proving that protected-content usage bits/secure EGL attributes are attached to that Surface.

## 6. nSetSurface — name/signature PROVEN; implementation mapping NOT PROVEN

Embedded strings:
- 0x5a0841 nSetSurface
- 0x5a084d (Landroid/view/Surface;)V
- 0x5a0cbb nSurfaceChanged
- 0x4d7eb0 nSetSurface
- 0x4d7ebc (Landroid/view/Surface;)V
- 0x4d832a nSurfaceChanged

JNI_OnLoad is a real ELF function:
- 0x0f8664, size 768
JNI_OnUnload:
- 0x0f8964, size 504

No confirmed JNINativeMethod row mapping nSetSurface -> native address was found.

Status:
- nSetSurface name/signature: PROVEN
- native implementation address: NOT PROVEN
- registration row: NOT PROVEN

## 7. CaptureScreen — PROVEN as native capture; screenshot blocking NOT PROVEN

Native C++ symbol/closure evidence:
- 0x5f93f0: ...Cicada16SuperMediaPlayer13CaptureScreenEv...
- 0x5f9490: ...SuperMediaPlayer13CaptureScreenEv...

Real native capture exception:
- rodata 0x5bd2d6 = "captureScreen exception, frameWidth or frameHeight is 0"
- executable validation/log path around 0x281fd4-0x282000

Other capture/crash strings:
- onCaptureScreen
- nativeOnCaptureScreen
- apsaraCaptureScreen
- AliyunCorePlayer callback --> CaptureScreen(%ld,%ld)
- captureCrash
- crash monitor allow capture
- crashMonitor capture success / failed

Best-supported interpretation:
CaptureScreen is an internal frame/crash-capture capability. Its relationship to Android user screenshot denial is not established.

Status:
- CaptureScreen exists: PROVEN
- internal capture/crash role: STRONG
- blocks user screenshots: NOT PROVEN
- is the Android screenshot blocker: NOT PROVEN

## 8. enableProjection — PROVEN as player config; screenshot role NOT PROVEN

0x5a42a6 is rodata "enableProjection".
Executable references:
- 0x1fc3b0
- 0x1fcdd8
The 0x1fcdd8 use is inside _ZN6Cicada17MediaPlayerConfig15getModifyConfigERKS0_S2_.

Conclusion:
enableProjection is a real MediaPlayerConfig key.

Status:
- config key exists: PROVEN
- participates in player config logic: PROVEN
- blocks screenshots: NOT PROVEN
- equals Android secure-window handling: NOT PROVEN

## 9. libSecShell — separate anti-tamper/security layer

SecShell ELF report:
- ELF64/AArch64 shared object
- entry point 0x156b0
- executable and RW LOAD segments
- mprotect-related behavior

Java bridge:
com.SecShell.SecShell.H exposes many native methods, including attach(Application,Context), m151b, m152bb and additional opaque native methods.

Java layer also uses reflection:
- Class.getDeclaredMethod
- Method.setAccessible
- Method.invoke
- Class.getDeclaredField
- Field.setAccessible
- Field.get/set

Startup explicitly loads:
- SecShell
- SecShell-x86 where appropriate

Security names recovered:
- root_kill
- is_miuiinstaller_process
- is_magisk_check_process
- check_root
- find_dexfile
- hookFunAddr_read
- mprotect

No screenshot-specific primitive was found in the SecShell-focused current corpus:
- FLAG_SECURE: not found
- SurfaceControl: not found
- MediaProjection: not found
- secure Surface API: not found
- protected EGL attribute: not found

Conclusion:
SecShell is strongly evidenced as an anti-tamper/root/hook/loader layer.
Its role as the screenshot blocker is NOT PROVEN.

## 10. Negative evidence register

The current analysis corpus did not recover:
- android.view.Window FLAG_SECURE
- SurfaceControl
- setSecure
- GRALLOC_USAGE_PROTECTED
- USAGE_PROTECTED
- AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT
- EGL_PROTECTED_CONTENT
- EGL_EXT_protected_content
- ANativeWindow_setUsage
- ANativeWindow_setBuffersGeometry
- AMediaCodec
- AMediaCodec_configure
- MediaCodec.setOutputSurface
- MediaProjection
- createVirtualDisplay

Java/Smali security scans only surfaced unrelated Paint.setFlags / generated resource attr setFlags matches.

Interpretation:
These are negative findings for the current analysis corpus, not mathematical proof that an equivalent behavior cannot be encoded indirectly or in an unscanned binary/packed component.

## 11. Unrelated/decoy capture code

jadx-src/resources/assets/iads/index.js contains a browser canvas helper with:
- canvas.capture()
- drawImage()
- toDataURL()
- config.shouldCapture
- screenshotCaptureSuccess / screenshotCaptureFail

This is embedded advertising/web content and is not evidence of ReelShort's native DRM screenshot restriction.

Status: unrelated to the native DRM determination.

## 12. Consolidated architecture

PROVEN:
DRM / ContentProtection
 -> DrmInfo-aware decoder
 -> WideVine / DrmSessionManager
 -> secure-input decoder operation context
 -> output-surface operation context
 -> android.view.Surface signature
 -> AndroidSurfaceHandle
 -> ANativeWindow_fromSurface
 -> EGL rendering

PROVEN parallel control:
setForceInsecureDecoder operation context

PROVEN player configuration:
enableProjection

PROVEN separate security layer:
SecShell anti-tamper/root/hook/loader subsystem

UNPROVEN bridge:
protected packet state
 -> actual packet call-site
 -> secure/protected buffer or Surface attribute
 -> Android screenshot policy
 -> screenshot refusal/blank output

## 13. Proof matrix

| Claim | Status |
|---|---|
| Native DRM/Widevine support | PROVEN |
| Protected packet state exists | PROVEN |
| Protected packet state is used on playback path | NOT PROVEN |
| queueSecureInputBuffer operation context exists | PROVEN |
| setOutputSurface operation context exists | PROVEN |
| setForceInsecureDecoder operation context exists | PROVEN |
| vtable +0x108 uniquely identifies those methods | NOT PROVEN |
| Android Surface participates in native rendering | PROVEN |
| ANativeWindow_fromSurface import | PROVEN |
| EGL window-surface path | PROVEN |
| nSetSurface API name/signature | PROVEN |
| nSetSurface implementation/registration | NOT PROVEN |
| CaptureScreen native function | PROVEN |
| CaptureScreen is internal capture/crash-related | STRONG |
| CaptureScreen blocks Android screenshots | NOT PROVEN |
| enableProjection is player config | PROVEN |
| enableProjection blocks screenshots | NOT PROVEN |
| FLAG_SECURE explicit use | NEGATIVE IN CURRENT CORPUS |
| SurfaceControl secure call | NEGATIVE IN CURRENT CORPUS |
| protected gralloc/EGL attribute | NEGATIVE IN CURRENT CORPUS |
| SecShell anti-tamper/root/hook role | PROVEN |
| SecShell screenshot-blocking role | NOT PROVEN |

## 14. Remaining proof gaps

1. Reconstruct the concrete vtable/class object behind 0x27af94, 0x27b148 and 0x27b220.
2. Recover executable call-sites for IAFPacket::isProtected(), AVAFPacket::isProtected(), and AVAFPacket::setProtected().
3. Resolve the actual implementation/call targets of queueSecureInputBuffer and setOutputSurface.
4. Extract direct call-sites to ANativeWindow_fromSurface and eglCreateWindowSurface and inspect the argument-building instructions immediately before each call.
5. Map nSetSurface through JNI registration back to its native implementation.
6. Repeat equivalent protected-content searches across every ABI/native payload, including all SecShell variants.
7. Correlate static evidence with runtime outcomes separately for ordinary UI screenshot, video playback screenshot, screen recording, and crash/frame capture.

## 15. Final conclusion

The defensible conclusion at commit d0ca71d05d62e798f9b54c025324e2c3bc07c256 is:

ReelShort v4.2.00 contains a genuine native DRM/Widevine playback pipeline, protected-media packet concepts, secure-input decoding infrastructure, output-surface routing, Android Surface/ANativeWindow/EGL rendering, and a separate SecShell anti-tamper layer.

The evidence does NOT currently prove that CaptureScreen, enableProjection, nSetSurface, or any single observed vtable dispatch is the Android screenshot blocker.

The evidence also does NOT currently prove explicit FLAG_SECURE, SurfaceControl secure state, protected gralloc usage, or protected EGL configuration.

Therefore the statement "the screenshot blocker has been identified" is not justified by the current evidence. The architecture is substantially mapped, but the decisive protected-state -> secure-surface -> Android screenshot-policy bridge remains unproven.
