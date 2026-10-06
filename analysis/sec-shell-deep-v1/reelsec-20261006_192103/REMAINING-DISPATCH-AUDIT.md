# Remaining Dispatch Audit

Goal: prove or disprove a concrete C++ object -> vptr -> +0x108 -> indirect call path.
Full disassembly return code: 0
Candidate +0x108 indirect dispatches: 376
JNI-like +0x108 candidates: 271
Proven-object C++ +0x108 candidates: 12
Unresolved candidates: 93
Direct BL to 0x27a510: 0

Classification rule:
- JNI_LIKELY requires the observed JNIEnv-style receiver handoff (mov x0, x19) around the +0x108 dispatch.
- PROVEN_CXX_OBJECT requires an object-vptr predecessor without that JNI receiver pattern.
- UNRESOLVED requires manual/data-flow reconstruction.

## 0xf8bf8
Classification: UNRESOLVED
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f8bec: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8bf0: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8bf4: 910f9042     	add	x2, x2, #0x3e4
   f8bf8: f9408508     	ldr	x8, [x8, #0x108]
   f8bfc: 910fcc63     	add	x3, x3, #0x3f3
   f8c00: aa1403e0     	mov	x0, x20
   f8c04: aa1703e1     	mov	x1, x23
   f8c08: d63f0100     	blr	x8

## 0xf8c48
Classification: UNRESOLVED
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f8c3c: f94057e1     	ldr	x1, [sp, #0xa8]
   f8c40: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8c44: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8c48: f9408508     	ldr	x8, [x8, #0x108]
   f8c4c: 91102042     	add	x2, x2, #0x408
   f8c50: 91105c63     	add	x3, x3, #0x417
   f8c54: aa1403e0     	mov	x0, x20
   f8c58: d63f0100     	blr	x8

## 0xf8d4c
Classification: UNRESOLVED
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f8d40: f94047e1     	ldr	x1, [sp, #0x88]
   f8d44: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8d48: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8d4c: f9408508     	ldr	x8, [x8, #0x108]
   f8d50: 9111e042     	add	x2, x2, #0x478
   f8d54: 91121063     	add	x3, x3, #0x484
   f8d58: aa1403e0     	mov	x0, x20
   f8d5c: d63f0100     	blr	x8

## 0xf8e10
Classification: UNRESOLVED
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f8e04: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8e08: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8e0c: 9113a442     	add	x2, x2, #0x4e9
   f8e10: f9408508     	ldr	x8, [x8, #0x108]
   f8e14: 9113c063     	add	x3, x3, #0x4f0
   f8e18: aa1403e0     	mov	x0, x20
   f8e1c: aa1603e1     	mov	x1, x22
   f8e20: d63f0100     	blr	x8

## 0xf8e48
Classification: UNRESOLVED
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f8e3c: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8e40: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8e44: 9113d842     	add	x2, x2, #0x4f6
   f8e48: f9408508     	ldr	x8, [x8, #0x108]
   f8e4c: 91121063     	add	x3, x3, #0x484
   f8e50: aa1403e0     	mov	x0, x20
   f8e54: aa1603e1     	mov	x1, x22
   f8e58: d63f0100     	blr	x8

## 0xf96c0
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f96b4: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f96b8: 90002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f96bc: aa0003e1     	mov	x1, x0
   f96c0: f9408508     	ldr	x8, [x8, #0x108]
   f96c4: 91141042     	add	x2, x2, #0x504
   f96c8: 91142c63     	add	x3, x3, #0x50b
   f96cc: aa1303e0     	mov	x0, x19
   f96d0: d63f0100     	blr	x8

## 0xf971c
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f9710: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9714: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9718: 91145842     	add	x2, x2, #0x516
   f971c: f9408508     	ldr	x8, [x8, #0x108]
   f9720: aa1303e0     	mov	x0, x19
   f9724: aa1403e3     	mov	x3, x20
   f9728: d63f0100     	blr	x8
   f972c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf9744
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f9738: f9459ac1     	ldr	x1, [x22, #0xb30]
   f973c: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9740: 91149c42     	add	x2, x2, #0x527
   f9744: f9408508     	ldr	x8, [x8, #0x108]
   f9748: aa1303e0     	mov	x0, x19
   f974c: aa1403e3     	mov	x3, x20
   f9750: d63f0100     	blr	x8
   f9754: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf976c
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f9760: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9764: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9768: 9114d042     	add	x2, x2, #0x534
   f976c: f9408508     	ldr	x8, [x8, #0x108]
   f9770: aa1303e0     	mov	x0, x19
   f9774: aa1403e3     	mov	x3, x20
   f9778: d63f0100     	blr	x8
   f977c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf9794
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f9788: f9459ac1     	ldr	x1, [x22, #0xb30]
   f978c: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9790: 90002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f9794: f9408508     	ldr	x8, [x8, #0x108]
   f9798: 9114f442     	add	x2, x2, #0x53d
   f979c: 91152c63     	add	x3, x3, #0x54b
   f97a0: aa1303e0     	mov	x0, x19
   f97a4: d63f0100     	blr	x8

## 0xf97c0
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f97b4: f9459ac1     	ldr	x1, [x22, #0xb30]
   f97b8: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f97bc: 91153c42     	add	x2, x2, #0x54f
   f97c0: f9408508     	ldr	x8, [x8, #0x108]
   f97c4: aa1303e0     	mov	x0, x19
   f97c8: aa1403e3     	mov	x3, x20
   f97cc: d63f0100     	blr	x8
   f97d0: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf9818
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f980c: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9810: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9814: 9115dc42     	add	x2, x2, #0x577
   f9818: f9408508     	ldr	x8, [x8, #0x108]
   f981c: aa1303e0     	mov	x0, x19
   f9820: aa1403e3     	mov	x3, x20
   f9824: d63f0100     	blr	x8
   f9828: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf9840
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f9834: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9838: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f983c: 91161042     	add	x2, x2, #0x584
   f9840: f9408508     	ldr	x8, [x8, #0x108]
   f9844: aa1303e0     	mov	x0, x19
   f9848: aa1403e3     	mov	x3, x20
   f984c: d63f0100     	blr	x8
   f9850: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xf9868
Classification: JNI_LIKELY
Function: 00000000000f8964 <JNI_OnUnload>:
ASM:
   f985c: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9860: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9864: 91163442     	add	x2, x2, #0x58d
   f9868: f9408508     	ldr	x8, [x8, #0x108]
   f986c: aa1303e0     	mov	x0, x19
   f9870: aa1403e3     	mov	x3, x20
   f9874: d63f0100     	blr	x8
   f9878: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 0xfa204
Classification: JNI_LIKELY
Function: 00000000000fa194 <_ZN13JavaTrackInfo4initEP7_JNIEnv>:
ASM:
   fa1f8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa1fc: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fa200: aa0003e1     	mov	x1, x0
   fa204: f9408508     	ldr	x8, [x8, #0x108]
   fa208: 91141042     	add	x2, x2, #0x504
   fa20c: 91142c63     	add	x3, x3, #0x50b
   fa210: aa1303e0     	mov	x0, x19
   fa214: d63f0100     	blr	x8

## 0xfa28c
Classification: JNI_LIKELY
Function: 00000000000fa194 <_ZN13JavaTrackInfo4initEP7_JNIEnv>:
ASM:
   fa280: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa284: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa288: 91175442     	add	x2, x2, #0x5d5
   fa28c: f9408508     	ldr	x8, [x8, #0x108]
   fa290: aa1303e0     	mov	x0, x19
   fa294: aa1403e3     	mov	x3, x20
   fa298: d63f0100     	blr	x8
   fa29c: f9000b00     	str	x0, [x24, #0x10]

## 0xfa2b0
Classification: JNI_LIKELY
Function: 00000000000fa194 <_ZN13JavaTrackInfo4initEP7_JNIEnv>:
ASM:
   fa2a4: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa2a8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa2ac: 91179442     	add	x2, x2, #0x5e5
   fa2b0: f9408508     	ldr	x8, [x8, #0x108]
   fa2b4: aa1303e0     	mov	x0, x19
   fa2b8: aa1503e3     	mov	x3, x21
   fa2bc: d63f0100     	blr	x8
   fa2c0: f9000f00     	str	x0, [x24, #0x18]

## 0xfaf04
Classification: JNI_LIKELY
Function: 00000000000fae98 <_ZN13JavaMediaInfo4initEP7_JNIEnv>:
ASM:
   faef8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faefc: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf00: aa0003e1     	mov	x1, x0
   faf04: f9408508     	ldr	x8, [x8, #0x108]
   faf08: 91141042     	add	x2, x2, #0x504
   faf0c: 91142c63     	add	x3, x3, #0x50b
   faf10: aa1303e0     	mov	x0, x19
   faf14: d63f0100     	blr	x8

## 0xfaf30
Classification: JNI_LIKELY
Function: 00000000000fae98 <_ZN13JavaMediaInfo4initEP7_JNIEnv>:
ASM:
   faf24: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf28: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf2c: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf30: f9408508     	ldr	x8, [x8, #0x108]
   faf34: 911bf842     	add	x2, x2, #0x6fe
   faf38: 911c3063     	add	x3, x3, #0x70c
   faf3c: aa1303e0     	mov	x0, x19
   faf40: d63f0100     	blr	x8

## 0xfaf5c
Classification: JNI_LIKELY
Function: 00000000000fae98 <_ZN13JavaMediaInfo4initEP7_JNIEnv>:
ASM:
   faf50: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf54: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf58: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf5c: f9408508     	ldr	x8, [x8, #0x108]
   faf60: 911ce842     	add	x2, x2, #0x73a
   faf64: 911d3063     	add	x3, x3, #0x74c
   faf68: aa1303e0     	mov	x0, x19
   faf6c: d63f0100     	blr	x8

## 0xfaf88
Classification: JNI_LIKELY
Function: 00000000000fae98 <_ZN13JavaMediaInfo4initEP7_JNIEnv>:
ASM:
   faf7c: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf80: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf84: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf88: f9408508     	ldr	x8, [x8, #0x108]
   faf8c: 911d8842     	add	x2, x2, #0x762
   faf90: 911dcc63     	add	x3, x3, #0x773
   faf94: aa1303e0     	mov	x0, x19
   faf98: d63f0100     	blr	x8

## 0xfc0a0
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fc094: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc098: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc09c: aa0003e1     	mov	x1, x0
   fc0a0: f9408508     	ldr	x8, [x8, #0x108]
   fc0a4: 91141042     	add	x2, x2, #0x504
   fc0a8: 91142c63     	add	x3, x3, #0x50b
   fc0ac: aa1303e0     	mov	x0, x19
   fc0b0: d63f0100     	blr	x8

## 0xfc0cc
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fc0c0: f9465ea1     	ldr	x1, [x21, #0xcb8]
   fc0c4: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc0c8: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc0cc: f9408508     	ldr	x8, [x8, #0x108]
   fc0d0: 91207442     	add	x2, x2, #0x81d
   fc0d4: 91208463     	add	x3, x3, #0x821
   fc0d8: aa1303e0     	mov	x0, x19
   fc0dc: d63f0100     	blr	x8

## 0xfc4f4
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fc4e8: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc4ec: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc4f0: aa0003e1     	mov	x1, x0
   fc4f4: f9408508     	ldr	x8, [x8, #0x108]
   fc4f8: 91141042     	add	x2, x2, #0x504
   fc4fc: 91142c63     	add	x3, x3, #0x50b
   fc500: aa1303e0     	mov	x0, x19
   fc504: d63f0100     	blr	x8

## 0xfc524
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fc518: f9466ae1     	ldr	x1, [x23, #0xcd0]
   fc51c: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc520: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc524: f9408508     	ldr	x8, [x8, #0x108]
   fc528: 9121c042     	add	x2, x2, #0x870
   fc52c: 91220463     	add	x3, x3, #0x881
   fc530: aa1303e0     	mov	x0, x19
   fc534: d63f0100     	blr	x8

## 0xfc54c
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fc540: f9466ae1     	ldr	x1, [x23, #0xcd0]
   fc544: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc548: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc54c: f9408508     	ldr	x8, [x8, #0x108]
   fc550: 91225c42     	add	x2, x2, #0x897
   fc554: 9122a063     	add	x3, x3, #0x8a8
   fc558: aa1303e0     	mov	x0, x19
   fc55c: d63f0100     	blr	x8

## 0xfdb5c
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fdb50: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdb54: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdb58: aa0003e1     	mov	x1, x0
   fdb5c: f9408508     	ldr	x8, [x8, #0x108]
   fdb60: 91141042     	add	x2, x2, #0x504
   fdb64: 91142c63     	add	x3, x3, #0x50b
   fdb68: aa1303e0     	mov	x0, x19
   fdb6c: d63f0100     	blr	x8

## 0xfdb88
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fdb7c: f946fae1     	ldr	x1, [x23, #0xdf0]
   fdb80: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdb84: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdb88: f9408508     	ldr	x8, [x8, #0x108]
   fdb8c: 9121c042     	add	x2, x2, #0x870
   fdb90: 91220463     	add	x3, x3, #0x881
   fdb94: aa1303e0     	mov	x0, x19
   fdb98: d63f0100     	blr	x8

## 0xfdbb4
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fdba8: f946fae1     	ldr	x1, [x23, #0xdf0]
   fdbac: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdbb0: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdbb4: f9408508     	ldr	x8, [x8, #0x108]
   fdbb8: 91225c42     	add	x2, x2, #0x897
   fdbbc: 9122a063     	add	x3, x3, #0x8a8
   fdbc0: aa1303e0     	mov	x0, x19
   fdbc4: d63f0100     	blr	x8

## 0xfe5a8
Classification: JNI_LIKELY
Function: 00000000000fb490 <_ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject>:
ASM:
   fe59c: f00024e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fe5a0: f00024e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fe5a4: aa0003e1     	mov	x1, x0
   fe5a8: f9408508     	ldr	x8, [x8, #0x108]
   fe5ac: 91141042     	add	x2, x2, #0x504
   fe5b0: 91142c63     	add	x3, x3, #0x50b
   fe5b4: aa1303e0     	mov	x0, x19
   fe5b8: d63f0100     	blr	x8

## 0x1024c0
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1024b4: f00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1024b8: f00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1024bc: aa0003e1     	mov	x1, x0
  1024c0: f9408508     	ldr	x8, [x8, #0x108]
  1024c4: 91141042     	add	x2, x2, #0x504
  1024c8: 91142c63     	add	x3, x3, #0x50b
  1024cc: aa1303e0     	mov	x0, x19
  1024d0: d63f0100     	blr	x8

## 0x10251c
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  102510: f9478ee1     	ldr	x1, [x23, #0xf18]
  102514: 900024e2     	adrp	x2, 0x59e000
  102518: 9125a442     	add	x2, x2, #0x969
  10251c: f9408508     	ldr	x8, [x8, #0x108]
  102520: aa1303e0     	mov	x0, x19
  102524: aa1403e3     	mov	x3, x20
  102528: d63f0100     	blr	x8
  10252c: f9001300     	str	x0, [x24, #0x20]

## 0x102598
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  10258c: f9478ee1     	ldr	x1, [x23, #0xf18]
  102590: 900024e2     	adrp	x2, 0x59e000
  102594: 9126b042     	add	x2, x2, #0x9ac
  102598: f9408508     	ldr	x8, [x8, #0x108]
  10259c: aa1303e0     	mov	x0, x19
  1025a0: aa1403e3     	mov	x3, x20
  1025a4: d63f0100     	blr	x8
  1025a8: f9001f00     	str	x0, [x24, #0x38]

## 0x1025bc
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1025b0: f9478ee1     	ldr	x1, [x23, #0xf18]
  1025b4: 900024e2     	adrp	x2, 0x59e000
  1025b8: 900024e3     	adrp	x3, 0x59e000
  1025bc: f9408508     	ldr	x8, [x8, #0x108]
  1025c0: 9126f442     	add	x2, x2, #0x9bd
  1025c4: 91272063     	add	x3, x3, #0x9c8
  1025c8: aa1303e0     	mov	x0, x19
  1025cc: d63f0100     	blr	x8

## 0x1025e4
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1025d8: f9478ee1     	ldr	x1, [x23, #0xf18]
  1025dc: 900024e2     	adrp	x2, 0x59e000
  1025e0: 900024e3     	adrp	x3, 0x59e000
  1025e4: f9408508     	ldr	x8, [x8, #0x108]
  1025e8: 91274442     	add	x2, x2, #0x9d1
  1025ec: 9127a863     	add	x3, x3, #0x9ea
  1025f0: aa1303e0     	mov	x0, x19
  1025f4: d63f0100     	blr	x8

## 0x10260c
Classification: JNI_LIKELY
Function: 00000000000ff1c0 <_ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  102600: f9478ee1     	ldr	x1, [x23, #0xf18]
  102604: 900024e2     	adrp	x2, 0x59e000
  102608: 9127c042     	add	x2, x2, #0x9f0
  10260c: f9408508     	ldr	x8, [x8, #0x108]
  102610: aa1303e0     	mov	x0, x19
  102614: aa1503e3     	mov	x3, x21
  102618: d63f0100     	blr	x8
  10261c: f9000700     	str	x0, [x24, #0x8]

## 0x1041dc
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  1041d0: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1041d4: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1041d8: aa0003e1     	mov	x1, x0
  1041dc: f9408508     	ldr	x8, [x8, #0x108]
  1041e0: 91141042     	add	x2, x2, #0x504
  1041e4: 91142c63     	add	x3, x3, #0x50b
  1041e8: aa1303e0     	mov	x0, x19
  1041ec: d63f0100     	blr	x8

## 0x104c64
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  104c58: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  104c5c: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104c60: aa0003e1     	mov	x1, x0
  104c64: f9408508     	ldr	x8, [x8, #0x108]
  104c68: 91141042     	add	x2, x2, #0x504
  104c6c: 91142c63     	add	x3, x3, #0x50b
  104c70: aa1303e0     	mov	x0, x19
  104c74: d63f0100     	blr	x8

## 0x104c90
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  104c84: f9408ac1     	ldr	x1, [x22, #0x110]
  104c88: d00024c2     	adrp	x2, 0x59e000
  104c8c: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104c90: f9408508     	ldr	x8, [x8, #0x108]
  104c94: 91384c42     	add	x2, x2, #0xe13
  104c98: 9138e063     	add	x3, x3, #0xe38
  104c9c: aa1303e0     	mov	x0, x19
  104ca0: d63f0100     	blr	x8

## 0x104cbc
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  104cb0: f9408ac1     	ldr	x1, [x22, #0x110]
  104cb4: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  104cb8: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104cbc: f9408508     	ldr	x8, [x8, #0x108]
  104cc0: 9116ec42     	add	x2, x2, #0x5bb
  104cc4: 91170c63     	add	x3, x3, #0x5c3
  104cc8: aa1303e0     	mov	x0, x19
  104ccc: d63f0100     	blr	x8

## 0x104ce8
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  104cdc: f9408ac1     	ldr	x1, [x22, #0x110]
  104ce0: d00024c2     	adrp	x2, 0x59e000
  104ce4: d00024c3     	adrp	x3, 0x59e000
  104ce8: f9408508     	ldr	x8, [x8, #0x108]
  104cec: 91387442     	add	x2, x2, #0xe1d
  104cf0: 91389c63     	add	x3, x3, #0xe27
  104cf4: aa1303e0     	mov	x0, x19
  104cf8: d63f0100     	blr	x8

## 0x104d14
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  104d08: f9408ac1     	ldr	x1, [x22, #0x110]
  104d0c: d00024c2     	adrp	x2, 0x59e000
  104d10: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104d14: f9408508     	ldr	x8, [x8, #0x108]
  104d18: 9138f042     	add	x2, x2, #0xe3c
  104d1c: 91174463     	add	x3, x3, #0x5d1
  104d20: aa1303e0     	mov	x0, x19
  104d24: d63f0100     	blr	x8

## 0x105478
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10546c: f85803a1     	ldur	x1, [x29, #-0x80]
  105470: b00024c2     	adrp	x2, 0x59e000
  105474: 900024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  105478: f9408508     	ldr	x8, [x8, #0x108]
  10547c: 913bfc42     	add	x2, x2, #0xeff
  105480: 911d3063     	add	x3, x3, #0x74c
  105484: aa1303e0     	mov	x0, x19
  105488: d63f0100     	blr	x8

## 0x105da4
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  105d98: 900024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  105d9c: 900024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  105da0: aa0003e1     	mov	x1, x0
  105da4: f9408508     	ldr	x8, [x8, #0x108]
  105da8: 91141042     	add	x2, x2, #0x504
  105dac: 91142c63     	add	x3, x3, #0x50b
  105db0: aa1303e0     	mov	x0, x19
  105db4: d63f0100     	blr	x8

## 0x10623c
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  106230: f00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  106234: f00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  106238: aa0003e1     	mov	x1, x0
  10623c: f9408508     	ldr	x8, [x8, #0x108]
  106240: 91141042     	add	x2, x2, #0x504
  106244: 91142c63     	add	x3, x3, #0x50b
  106248: aa1303e0     	mov	x0, x19
  10624c: d63f0100     	blr	x8

## 0x10743c
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  107430: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  107434: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  107438: aa0003e1     	mov	x1, x0
  10743c: f9408508     	ldr	x8, [x8, #0x108]
  107440: 91141042     	add	x2, x2, #0x504
  107444: 91142c63     	add	x3, x3, #0x50b
  107448: aa1303e0     	mov	x0, x19
  10744c: d63f0100     	blr	x8

## 0x1078fc
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  1078f0: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1078f4: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1078f8: aa0003e1     	mov	x1, x0
  1078fc: f9408508     	ldr	x8, [x8, #0x108]
  107900: 91141042     	add	x2, x2, #0x504
  107904: 91142c63     	add	x3, x3, #0x50b
  107908: aa1303e0     	mov	x0, x19
  10790c: d63f0100     	blr	x8

## 0x107eec
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  107ee0: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  107ee4: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  107ee8: aa0003e1     	mov	x1, x0
  107eec: f9408508     	ldr	x8, [x8, #0x108]
  107ef0: 91141042     	add	x2, x2, #0x504
  107ef4: 91142c63     	add	x3, x3, #0x50b
  107ef8: aa1303e0     	mov	x0, x19
  107efc: d63f0100     	blr	x8

## 0x107fa0
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  107f94: f94252c1     	ldr	x1, [x22, #0x4a0]
  107f98: 900024c2     	adrp	x2, 0x59f000
  107f9c: 910f7042     	add	x2, x2, #0x3dc
  107fa0: f9408508     	ldr	x8, [x8, #0x108]
  107fa4: aa1303e0     	mov	x0, x19
  107fa8: aa1403e3     	mov	x3, x20
  107fac: d63f0100     	blr	x8
  107fb0: b00031c8     	adrp	x8, 0x740000

## 0x108008
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  107ffc: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  108000: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108004: aa0003e1     	mov	x1, x0
  108008: f9408508     	ldr	x8, [x8, #0x108]
  10800c: 91141042     	add	x2, x2, #0x504
  108010: 91142c63     	add	x3, x3, #0x50b
  108014: aa1303e0     	mov	x0, x19
  108018: d63f0100     	blr	x8

## 0x10852c
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  108520: b00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  108524: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108528: aa0003e1     	mov	x1, x0
  10852c: f9408508     	ldr	x8, [x8, #0x108]
  108530: 91141042     	add	x2, x2, #0x504
  108534: 91142c63     	add	x3, x3, #0x50b
  108538: aa1303e0     	mov	x0, x19
  10853c: d63f0100     	blr	x8

## 0x108588
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10857c: f942bec1     	ldr	x1, [x22, #0x578]
  108580: f00024a2     	adrp	x2, 0x59f000
  108584: 91134442     	add	x2, x2, #0x4d1
  108588: f9408508     	ldr	x8, [x8, #0x108]
  10858c: aa1303e0     	mov	x0, x19
  108590: aa1403e3     	mov	x3, x20
  108594: d63f0100     	blr	x8
  108598: 900031c8     	adrp	x8, 0x740000

## 0x1085b0
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  1085a4: f942bec1     	ldr	x1, [x22, #0x578]
  1085a8: f00024a2     	adrp	x2, 0x59f000
  1085ac: 91137442     	add	x2, x2, #0x4dd
  1085b0: f9408508     	ldr	x8, [x8, #0x108]
  1085b4: aa1303e0     	mov	x0, x19
  1085b8: aa1403e3     	mov	x3, x20
  1085bc: d63f0100     	blr	x8
  1085c0: 900031c8     	adrp	x8, 0x740000

## 0x108608
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  1085fc: f942bec1     	ldr	x1, [x22, #0x578]
  108600: f00024a2     	adrp	x2, 0x59f000
  108604: 9113e842     	add	x2, x2, #0x4fa
  108608: f9408508     	ldr	x8, [x8, #0x108]
  10860c: aa1303e0     	mov	x0, x19
  108610: aa1403e3     	mov	x3, x20
  108614: d63f0100     	blr	x8
  108618: 900031c8     	adrp	x8, 0x740000

## 0x108630
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  108624: f942bec1     	ldr	x1, [x22, #0x578]
  108628: f00024a2     	adrp	x2, 0x59f000
  10862c: 91141842     	add	x2, x2, #0x506
  108630: f9408508     	ldr	x8, [x8, #0x108]
  108634: aa1303e0     	mov	x0, x19
  108638: aa1403e3     	mov	x3, x20
  10863c: d63f0100     	blr	x8
  108640: 900031c8     	adrp	x8, 0x740000

## 0x108ba0
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  108b94: f94053e1     	ldr	x1, [sp, #0xa0]
  108b98: d00024a2     	adrp	x2, 0x59e000
  108b9c: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108ba0: f9408508     	ldr	x8, [x8, #0x108]
  108ba4: 913bfc42     	add	x2, x2, #0xeff
  108ba8: 911d3063     	add	x3, x3, #0x74c
  108bac: aa1303e0     	mov	x0, x19
  108bb0: d63f0100     	blr	x8

## 0x10b134
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10b128: d0002482     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  10b12c: 900024a3     	adrp	x3, 0x59f000
  10b130: 91141042     	add	x2, x2, #0x504
  10b134: f9408508     	ldr	x8, [x8, #0x108]
  10b138: 91165863     	add	x3, x3, #0x596
  10b13c: aa1303e0     	mov	x0, x19
  10b140: aa1403e1     	mov	x1, x20
  10b144: d63f0100     	blr	x8

## 0x10b438
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10b42c: 900024a2     	adrp	x2, 0x59f000
  10b430: f0002483     	adrp	x3, 0x59e000
  10b434: aa0003e1     	mov	x1, x0
  10b438: f9408508     	ldr	x8, [x8, #0x108]
  10b43c: 91192442     	add	x2, x2, #0x649
  10b440: 913ad063     	add	x3, x3, #0xeb4
  10b444: aa1303e0     	mov	x0, x19
  10b448: d63f0100     	blr	x8

## 0x10b488
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10b47c: 900024a2     	adrp	x2, 0x59f000
  10b480: 900024a3     	adrp	x3, 0x59f000
  10b484: aa0003e1     	mov	x1, x0
  10b488: f9408508     	ldr	x8, [x8, #0x108]
  10b48c: 91194842     	add	x2, x2, #0x652
  10b490: 91196c63     	add	x3, x3, #0x65b
  10b494: aa1303e0     	mov	x0, x19
  10b498: d63f0100     	blr	x8

## 0x10b548
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10b53c: aa0003f4     	mov	x20, x0
  10b540: 900024a2     	adrp	x2, 0x59f000
  10b544: 911aa842     	add	x2, x2, #0x6aa
  10b548: f9408508     	ldr	x8, [x8, #0x108]
  10b54c: aa1303e0     	mov	x0, x19
  10b550: aa1403e1     	mov	x1, x20
  10b554: aa1603e3     	mov	x3, x22
  10b558: d63f0100     	blr	x8

## 0x10b56c
Classification: JNI_LIKELY
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10b560: 900024a2     	adrp	x2, 0x59f000
  10b564: aa0003f8     	mov	x24, x0
  10b568: 91154042     	add	x2, x2, #0x550
  10b56c: f9408508     	ldr	x8, [x8, #0x108]
  10b570: aa1303e0     	mov	x0, x19
  10b574: aa1403e1     	mov	x1, x20
  10b578: aa1603e3     	mov	x3, x22
  10b57c: d63f0100     	blr	x8

## 0x10dba0
Classification: UNRESOLVED
Function: 0000000000103bc8 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi>:
ASM:
  10db94: b0000001     	adrp	x1, 0x10e000 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi+0xa438>
  10db98: 9105c021     	add	x1, x1, #0x170
  10db9c: aa1403e0     	mov	x0, x20
  10dba0: f9408508     	ldr	x8, [x8, #0x108]
  10dba4: aa1303e2     	mov	x2, x19
  10dba8: d63f0100     	blr	x8
  10dbac: 90003008     	adrp	x8, 0x70d000 <_ZTVNSt6__ndk115basic_stringbufIcNS_11char_traitsIcEENS_9allocatorIcEEEE+0x40>
  10dbb0: 91356108     	add	x8, x8, #0xd58

## 0x1129bc
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1129b0: d0002462     	adrp	x2, 0x5a0000
  1129b4: 90002463     	adrp	x3, 0x59e000
  1129b8: aa0003e1     	mov	x1, x0
  1129bc: f9408508     	ldr	x8, [x8, #0x108]
  1129c0: 9109c842     	add	x2, x2, #0x272
  1129c4: 9130dc63     	add	x3, x3, #0xc37
  1129c8: aa1303e0     	mov	x0, x19
  1129cc: d63f0100     	blr	x8

## 0x1129ec
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1129e0: f9439721     	ldr	x1, [x25, #0x728]
  1129e4: d0002462     	adrp	x2, 0x5a0000
  1129e8: d0002463     	adrp	x3, 0x5a0000
  1129ec: f9408508     	ldr	x8, [x8, #0x108]
  1129f0: 9109e842     	add	x2, x2, #0x27a
  1129f4: 910a0863     	add	x3, x3, #0x282
  1129f8: aa1303e0     	mov	x0, x19
  1129fc: d63f0100     	blr	x8

## 0x112a40
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112a34: f9439721     	ldr	x1, [x25, #0x728]
  112a38: d0002462     	adrp	x2, 0x5a0000
  112a3c: 910ad442     	add	x2, x2, #0x2b5
  112a40: f9408508     	ldr	x8, [x8, #0x108]
  112a44: aa1303e0     	mov	x0, x19
  112a48: aa1403e3     	mov	x3, x20
  112a4c: d63f0100     	blr	x8
  112a50: f9000f40     	str	x0, [x26, #0x18]

## 0x112a64
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112a58: f9439721     	ldr	x1, [x25, #0x728]
  112a5c: d0002462     	adrp	x2, 0x5a0000
  112a60: 910b0042     	add	x2, x2, #0x2c0
  112a64: f9408508     	ldr	x8, [x8, #0x108]
  112a68: aa1303e0     	mov	x0, x19
  112a6c: aa1403e3     	mov	x3, x20
  112a70: d63f0100     	blr	x8
  112a74: f9001340     	str	x0, [x26, #0x20]

## 0x112a88
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112a7c: f9439721     	ldr	x1, [x25, #0x728]
  112a80: d0002462     	adrp	x2, 0x5a0000
  112a84: 910b3442     	add	x2, x2, #0x2cd
  112a88: f9408508     	ldr	x8, [x8, #0x108]
  112a8c: aa1303e0     	mov	x0, x19
  112a90: aa1403e3     	mov	x3, x20
  112a94: d63f0100     	blr	x8
  112a98: f9001740     	str	x0, [x26, #0x28]

## 0x112ad8
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112acc: f9439721     	ldr	x1, [x25, #0x728]
  112ad0: d0002462     	adrp	x2, 0x5a0000
  112ad4: 910bd842     	add	x2, x2, #0x2f6
  112ad8: f9408508     	ldr	x8, [x8, #0x108]
  112adc: aa1303e0     	mov	x0, x19
  112ae0: aa1503e3     	mov	x3, x21
  112ae4: d63f0100     	blr	x8
  112ae8: f9009f40     	str	x0, [x26, #0x138]

## 0x112afc
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112af0: f9439721     	ldr	x1, [x25, #0x728]
  112af4: d0002462     	adrp	x2, 0x5a0000
  112af8: 910c1842     	add	x2, x2, #0x306
  112afc: f9408508     	ldr	x8, [x8, #0x108]
  112b00: aa1303e0     	mov	x0, x19
  112b04: aa1503e3     	mov	x3, x21
  112b08: d63f0100     	blr	x8
  112b0c: f900a340     	str	x0, [x26, #0x140]

## 0x112b20
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112b14: f9439721     	ldr	x1, [x25, #0x728]
  112b18: d0002462     	adrp	x2, 0x5a0000
  112b1c: 910c5c42     	add	x2, x2, #0x317
  112b20: f9408508     	ldr	x8, [x8, #0x108]
  112b24: aa1303e0     	mov	x0, x19
  112b28: aa1403e3     	mov	x3, x20
  112b2c: d63f0100     	blr	x8
  112b30: f9001b40     	str	x0, [x26, #0x30]

## 0x112b44
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112b38: f9439721     	ldr	x1, [x25, #0x728]
  112b3c: d0002462     	adrp	x2, 0x5a0000
  112b40: d0002463     	adrp	x3, 0x5a0000
  112b44: f9408508     	ldr	x8, [x8, #0x108]
  112b48: 910c9442     	add	x2, x2, #0x325
  112b4c: 910cd063     	add	x3, x3, #0x334
  112b50: aa1303e0     	mov	x0, x19
  112b54: d63f0100     	blr	x8

## 0x112b6c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112b60: f9439721     	ldr	x1, [x25, #0x728]
  112b64: d0002462     	adrp	x2, 0x5a0000
  112b68: 910d7842     	add	x2, x2, #0x35e
  112b6c: f9408508     	ldr	x8, [x8, #0x108]
  112b70: aa1303e0     	mov	x0, x19
  112b74: aa1403e3     	mov	x3, x20
  112b78: d63f0100     	blr	x8
  112b7c: f9001f40     	str	x0, [x26, #0x38]

## 0x112b90
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112b84: f9439721     	ldr	x1, [x25, #0x728]
  112b88: d0002462     	adrp	x2, 0x5a0000
  112b8c: d0002463     	adrp	x3, 0x5a0000
  112b90: f9408508     	ldr	x8, [x8, #0x108]
  112b94: 910db442     	add	x2, x2, #0x36d
  112b98: 910df063     	add	x3, x3, #0x37c
  112b9c: aa1303e0     	mov	x0, x19
  112ba0: d63f0100     	blr	x8

## 0x112be4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112bd8: f9439721     	ldr	x1, [x25, #0x728]
  112bdc: d0002462     	adrp	x2, 0x5a0000
  112be0: 910e5442     	add	x2, x2, #0x395
  112be4: f9408508     	ldr	x8, [x8, #0x108]
  112be8: aa1303e0     	mov	x0, x19
  112bec: aa1603e3     	mov	x3, x22
  112bf0: d63f0100     	blr	x8
  112bf4: f9002f40     	str	x0, [x26, #0x58]

## 0x112c08
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112bfc: f9439721     	ldr	x1, [x25, #0x728]
  112c00: d0002462     	adrp	x2, 0x5a0000
  112c04: 910eb442     	add	x2, x2, #0x3ad
  112c08: f9408508     	ldr	x8, [x8, #0x108]
  112c0c: aa1303e0     	mov	x0, x19
  112c10: aa1603e3     	mov	x3, x22
  112c14: d63f0100     	blr	x8
  112c18: f9003340     	str	x0, [x26, #0x60]

## 0x112c84
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112c78: f9439721     	ldr	x1, [x25, #0x728]
  112c7c: d0002462     	adrp	x2, 0x5a0000
  112c80: 91102c42     	add	x2, x2, #0x40b
  112c84: f9408508     	ldr	x8, [x8, #0x108]
  112c88: aa1303e0     	mov	x0, x19
  112c8c: aa1703e3     	mov	x3, x23
  112c90: d63f0100     	blr	x8
  112c94: f9004340     	str	x0, [x26, #0x80]

## 0x112ca8
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112c9c: f9439721     	ldr	x1, [x25, #0x728]
  112ca0: d0002462     	adrp	x2, 0x5a0000
  112ca4: d0002463     	adrp	x3, 0x5a0000
  112ca8: f9408508     	ldr	x8, [x8, #0x108]
  112cac: 91107842     	add	x2, x2, #0x41e
  112cb0: 9110c463     	add	x3, x3, #0x431
  112cb4: aa1303e0     	mov	x0, x19
  112cb8: d63f0100     	blr	x8

## 0x112cd0
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112cc4: f9439721     	ldr	x1, [x25, #0x728]
  112cc8: d0002462     	adrp	x2, 0x5a0000
  112ccc: 91117c42     	add	x2, x2, #0x45f
  112cd0: f9408508     	ldr	x8, [x8, #0x108]
  112cd4: aa1303e0     	mov	x0, x19
  112cd8: aa1503e3     	mov	x3, x21
  112cdc: d63f0100     	blr	x8
  112ce0: f9004f40     	str	x0, [x26, #0x98]

## 0x112cf4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112ce8: f9439721     	ldr	x1, [x25, #0x728]
  112cec: d0002462     	adrp	x2, 0x5a0000
  112cf0: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112cf4: f9408508     	ldr	x8, [x8, #0x108]
  112cf8: 9111c042     	add	x2, x2, #0x470
  112cfc: 91152c63     	add	x3, x3, #0x54b
  112d00: aa1303e0     	mov	x0, x19
  112d04: d63f0100     	blr	x8

## 0x112d20
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112d14: f9439721     	ldr	x1, [x25, #0x728]
  112d18: d0002462     	adrp	x2, 0x5a0000
  112d1c: 91120442     	add	x2, x2, #0x481
  112d20: f9408508     	ldr	x8, [x8, #0x108]
  112d24: aa1303e0     	mov	x0, x19
  112d28: aa1403e3     	mov	x3, x20
  112d2c: d63f0100     	blr	x8
  112d30: f9005340     	str	x0, [x26, #0xa0]

## 0x112d44
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112d38: f9439721     	ldr	x1, [x25, #0x728]
  112d3c: d0002462     	adrp	x2, 0x5a0000
  112d40: d0002463     	adrp	x3, 0x5a0000
  112d44: f9408508     	ldr	x8, [x8, #0x108]
  112d48: 91124842     	add	x2, x2, #0x492
  112d4c: 91129063     	add	x3, x3, #0x4a4
  112d50: aa1303e0     	mov	x0, x19
  112d54: d63f0100     	blr	x8

## 0x112d6c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112d60: f9439721     	ldr	x1, [x25, #0x728]
  112d64: d0002462     	adrp	x2, 0x5a0000
  112d68: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112d6c: f9408508     	ldr	x8, [x8, #0x108]
  112d70: 9112a442     	add	x2, x2, #0x4a9
  112d74: 91170c63     	add	x3, x3, #0x5c3
  112d78: aa1303e0     	mov	x0, x19
  112d7c: d63f0100     	blr	x8

## 0x112d94
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112d88: f9439721     	ldr	x1, [x25, #0x728]
  112d8c: d0002462     	adrp	x2, 0x5a0000
  112d90: 9112e842     	add	x2, x2, #0x4ba
  112d94: f9408508     	ldr	x8, [x8, #0x108]
  112d98: aa1303e0     	mov	x0, x19
  112d9c: aa1403e3     	mov	x3, x20
  112da0: d63f0100     	blr	x8
  112da4: f9005f40     	str	x0, [x26, #0xb8]

## 0x112db8
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112dac: f9439721     	ldr	x1, [x25, #0x728]
  112db0: d0002462     	adrp	x2, 0x5a0000
  112db4: d0002463     	adrp	x3, 0x5a0000
  112db8: f9408508     	ldr	x8, [x8, #0x108]
  112dbc: 91132442     	add	x2, x2, #0x4c9
  112dc0: 91136063     	add	x3, x3, #0x4d8
  112dc4: aa1303e0     	mov	x0, x19
  112dc8: d63f0100     	blr	x8

## 0x112de0
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112dd4: f9439721     	ldr	x1, [x25, #0x728]
  112dd8: d0002462     	adrp	x2, 0x5a0000
  112ddc: d0002463     	adrp	x3, 0x5a0000
  112de0: f9408508     	ldr	x8, [x8, #0x108]
  112de4: 91142442     	add	x2, x2, #0x509
  112de8: 91147063     	add	x3, x3, #0x51c
  112dec: aa1303e0     	mov	x0, x19
  112df0: d63f0100     	blr	x8

## 0x112e08
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112dfc: f9439721     	ldr	x1, [x25, #0x728]
  112e00: d0002462     	adrp	x2, 0x5a0000
  112e04: 91157042     	add	x2, x2, #0x55c
  112e08: f9408508     	ldr	x8, [x8, #0x108]
  112e0c: aa1303e0     	mov	x0, x19
  112e10: aa1603e3     	mov	x3, x22
  112e14: d63f0100     	blr	x8
  112e18: f9006b40     	str	x0, [x26, #0xd0]

## 0x112e2c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112e20: f9439721     	ldr	x1, [x25, #0x728]
  112e24: d0002462     	adrp	x2, 0x5a0000
  112e28: d0002463     	adrp	x3, 0x5a0000
  112e2c: f9408508     	ldr	x8, [x8, #0x108]
  112e30: 9115bc42     	add	x2, x2, #0x56f
  112e34: 9115fc63     	add	x3, x3, #0x57f
  112e38: aa1303e0     	mov	x0, x19
  112e3c: d63f0100     	blr	x8

## 0x112e54
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112e48: f9439721     	ldr	x1, [x25, #0x728]
  112e4c: d0002462     	adrp	x2, 0x5a0000
  112e50: d0002463     	adrp	x3, 0x5a0000
  112e54: f9408508     	ldr	x8, [x8, #0x108]
  112e58: 91161442     	add	x2, x2, #0x585
  112e5c: 91166c63     	add	x3, x3, #0x59b
  112e60: aa1303e0     	mov	x0, x19
  112e64: d63f0100     	blr	x8

## 0x112e7c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112e70: f9439721     	ldr	x1, [x25, #0x728]
  112e74: d0002462     	adrp	x2, 0x5a0000
  112e78: b0002463     	adrp	x3, 0x59f000
  112e7c: f9408508     	ldr	x8, [x8, #0x108]
  112e80: 91172042     	add	x2, x2, #0x5c8
  112e84: 911de063     	add	x3, x3, #0x778
  112e88: aa1303e0     	mov	x0, x19
  112e8c: d63f0100     	blr	x8

## 0x112ea4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112e98: f9439721     	ldr	x1, [x25, #0x728]
  112e9c: d0002462     	adrp	x2, 0x5a0000
  112ea0: 90002463     	adrp	x3, 0x59e000
  112ea4: f9408508     	ldr	x8, [x8, #0x108]
  112ea8: 91178042     	add	x2, x2, #0x5e0
  112eac: 91272063     	add	x3, x3, #0x9c8
  112eb0: aa1303e0     	mov	x0, x19
  112eb4: d63f0100     	blr	x8

## 0x112ecc
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112ec0: f9439721     	ldr	x1, [x25, #0x728]
  112ec4: d0002462     	adrp	x2, 0x5a0000
  112ec8: 9117c842     	add	x2, x2, #0x5f2
  112ecc: f9408508     	ldr	x8, [x8, #0x108]
  112ed0: aa1303e0     	mov	x0, x19
  112ed4: aa1503e3     	mov	x3, x21
  112ed8: d63f0100     	blr	x8
  112edc: f9007f40     	str	x0, [x26, #0xf8]

## 0x112ef0
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112ee4: f9439721     	ldr	x1, [x25, #0x728]
  112ee8: d0002462     	adrp	x2, 0x5a0000
  112eec: 91182c42     	add	x2, x2, #0x60b
  112ef0: f9408508     	ldr	x8, [x8, #0x108]
  112ef4: aa1303e0     	mov	x0, x19
  112ef8: aa1503e3     	mov	x3, x21
  112efc: d63f0100     	blr	x8
  112f00: f9008340     	str	x0, [x26, #0x100]

## 0x112f14
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112f08: f9439721     	ldr	x1, [x25, #0x728]
  112f0c: d0002462     	adrp	x2, 0x5a0000
  112f10: d0002463     	adrp	x3, 0x5a0000
  112f14: f9408508     	ldr	x8, [x8, #0x108]
  112f18: 91188c42     	add	x2, x2, #0x623
  112f1c: 9118cc63     	add	x3, x3, #0x633
  112f20: aa1303e0     	mov	x0, x19
  112f24: d63f0100     	blr	x8

## 0x112f3c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112f30: f9439721     	ldr	x1, [x25, #0x728]
  112f34: d0002462     	adrp	x2, 0x5a0000
  112f38: 9118ec42     	add	x2, x2, #0x63b
  112f3c: f9408508     	ldr	x8, [x8, #0x108]
  112f40: aa1303e0     	mov	x0, x19
  112f44: aa1403e3     	mov	x3, x20
  112f48: d63f0100     	blr	x8
  112f4c: f9003b40     	str	x0, [x26, #0x70]

## 0x112fb4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112fa8: f9439721     	ldr	x1, [x25, #0x728]
  112fac: d0002462     	adrp	x2, 0x5a0000
  112fb0: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112fb4: f9408508     	ldr	x8, [x8, #0x108]
  112fb8: 911ac442     	add	x2, x2, #0x6b1
  112fbc: 9138e063     	add	x3, x3, #0xe38
  112fc0: aa1303e0     	mov	x0, x19
  112fc4: d63f0100     	blr	x8

## 0x113008
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  112ffc: f9439721     	ldr	x1, [x25, #0x728]
  113000: b0002462     	adrp	x2, 0x5a0000
  113004: 911bc042     	add	x2, x2, #0x6f0
  113008: f9408508     	ldr	x8, [x8, #0x108]
  11300c: aa1303e0     	mov	x0, x19
  113010: aa1503e3     	mov	x3, x21
  113014: d63f0100     	blr	x8
  113018: f9009740     	str	x0, [x26, #0x128]

## 0x113058
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11304c: f9439721     	ldr	x1, [x25, #0x728]
  113050: b0002462     	adrp	x2, 0x5a0000
  113054: 911c6042     	add	x2, x2, #0x718
  113058: f9408508     	ldr	x8, [x8, #0x108]
  11305c: aa1303e0     	mov	x0, x19
  113060: aa1503e3     	mov	x3, x21
  113064: d63f0100     	blr	x8
  113068: f900ab40     	str	x0, [x26, #0x150]

## 0x11307c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  113070: f9439721     	ldr	x1, [x25, #0x728]
  113074: b0002462     	adrp	x2, 0x5a0000
  113078: d0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  11307c: f9408508     	ldr	x8, [x8, #0x108]
  113080: 911ce042     	add	x2, x2, #0x738
  113084: 91158463     	add	x3, x3, #0x561
  113088: aa1303e0     	mov	x0, x19
  11308c: d63f0100     	blr	x8

## 0x1130a4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  113098: f9439721     	ldr	x1, [x25, #0x728]
  11309c: b0002462     	adrp	x2, 0x5a0000
  1130a0: 911d1442     	add	x2, x2, #0x745
  1130a4: f9408508     	ldr	x8, [x8, #0x108]
  1130a8: aa1303e0     	mov	x0, x19
  1130ac: aa1403e3     	mov	x3, x20
  1130b0: d63f0100     	blr	x8
  1130b4: f900b340     	str	x0, [x26, #0x160]

## 0x113348
Classification: UNRESOLVED
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11333c: f85b83a1     	ldur	x1, [x29, #-0x48]
  113340: b0002462     	adrp	x2, 0x5a0000
  113344: b0002463     	adrp	x3, 0x5a0000
  113348: f9408508     	ldr	x8, [x8, #0x108]
  11334c: 911eb042     	add	x2, x2, #0x7ac
  113350: 911ed463     	add	x3, x3, #0x7b5
  113354: aa1403e0     	mov	x0, x20
  113358: d63f0100     	blr	x8

## 0x113394
Classification: UNRESOLVED
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  113388: f85983a1     	ldur	x1, [x29, #-0x68]
  11338c: b0002462     	adrp	x2, 0x5a0000
  113390: d0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  113394: f9408508     	ldr	x8, [x8, #0x108]
  113398: 911f2442     	add	x2, x2, #0x7c9
  11339c: 910fcc63     	add	x3, x3, #0x3f3
  1133a0: aa1403e0     	mov	x0, x20
  1133a4: d63f0100     	blr	x8

## 0x11e608
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11e5fc: f0002402     	adrp	x2, 0x5a1000
  11e600: f0002403     	adrp	x3, 0x5a1000
  11e604: aa0003e1     	mov	x1, x0
  11e608: f9408508     	ldr	x8, [x8, #0x108]
  11e60c: 911a4842     	add	x2, x2, #0x692
  11e610: 911a6063     	add	x3, x3, #0x698
  11e614: aa1303e0     	mov	x0, x19
  11e618: d63f0100     	blr	x8

## 0x11e634
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11e628: f94496a1     	ldr	x1, [x21, #0x928]
  11e62c: f0002402     	adrp	x2, 0x5a1000
  11e630: f0002403     	adrp	x3, 0x5a1000
  11e634: f9408508     	ldr	x8, [x8, #0x108]
  11e638: 911a7842     	add	x2, x2, #0x69e
  11e63c: 911a9063     	add	x3, x3, #0x6a4
  11e640: aa1303e0     	mov	x0, x19
  11e644: d63f0100     	blr	x8

## 0x11e660
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11e654: f94496a1     	ldr	x1, [x21, #0x928]
  11e658: f0002402     	adrp	x2, 0x5a1000
  11e65c: f0002403     	adrp	x3, 0x5a1000
  11e660: f9408508     	ldr	x8, [x8, #0x108]
  11e664: 911aa842     	add	x2, x2, #0x6aa
  11e668: 911af463     	add	x3, x3, #0x6bd
  11e66c: aa1303e0     	mov	x0, x19
  11e670: d63f0100     	blr	x8

## 0x11f9b8
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11f9ac: d0002402     	adrp	x2, 0x5a1000
  11f9b0: b0002403     	adrp	x3, 0x5a0000
  11f9b4: aa0003e1     	mov	x1, x0
  11f9b8: f9408508     	ldr	x8, [x8, #0x108]
  11f9bc: 91266442     	add	x2, x2, #0x999
  11f9c0: 910bc463     	add	x3, x3, #0x2f1
  11f9c4: aa1303e0     	mov	x0, x19
  11f9c8: d63f0100     	blr	x8

## 0x11f9e4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  11f9d8: f944b2a1     	ldr	x1, [x21, #0x960]
  11f9dc: d0002402     	adrp	x2, 0x5a1000
  11f9e0: d00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  11f9e4: f9408508     	ldr	x8, [x8, #0x108]
  11f9e8: 9126b842     	add	x2, x2, #0x9ae
  11f9ec: 91152c63     	add	x3, x3, #0x54b
  11f9f0: aa1303e0     	mov	x0, x19
  11f9f4: d63f0100     	blr	x8

## 0x120370
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120364: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120368: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12036c: aa0003e1     	mov	x1, x0
  120370: f9408508     	ldr	x8, [x8, #0x108]
  120374: 91141042     	add	x2, x2, #0x504
  120378: 91142c63     	add	x3, x3, #0x50b
  12037c: aa1303e0     	mov	x0, x19
  120380: d63f0100     	blr	x8

## 0x1203cc
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1203c0: f944cee1     	ldr	x1, [x23, #0x998]
  1203c4: b0002402     	adrp	x2, 0x5a1000
  1203c8: 91320842     	add	x2, x2, #0xc82
  1203cc: f9408508     	ldr	x8, [x8, #0x108]
  1203d0: aa1303e0     	mov	x0, x19
  1203d4: aa1403e3     	mov	x3, x20
  1203d8: d63f0100     	blr	x8
  1203dc: 90003108     	adrp	x8, 0x740000

## 0x1203f4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1203e8: f944cee1     	ldr	x1, [x23, #0x998]
  1203ec: b0002402     	adrp	x2, 0x5a1000
  1203f0: 91324442     	add	x2, x2, #0xc91
  1203f4: f9408508     	ldr	x8, [x8, #0x108]
  1203f8: aa1303e0     	mov	x0, x19
  1203fc: aa1403e3     	mov	x3, x20
  120400: d63f0100     	blr	x8
  120404: 90003108     	adrp	x8, 0x740000

## 0x12044c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120440: f944cee1     	ldr	x1, [x23, #0x998]
  120444: b0002402     	adrp	x2, 0x5a1000
  120448: 9132d442     	add	x2, x2, #0xcb5
  12044c: f9408508     	ldr	x8, [x8, #0x108]
  120450: aa1303e0     	mov	x0, x19
  120454: aa1503e3     	mov	x3, x21
  120458: d63f0100     	blr	x8
  12045c: 90003108     	adrp	x8, 0x740000

## 0x120474
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120468: f944cee1     	ldr	x1, [x23, #0x998]
  12046c: b0002402     	adrp	x2, 0x5a1000
  120470: 91331042     	add	x2, x2, #0xcc4
  120474: f9408508     	ldr	x8, [x8, #0x108]
  120478: aa1303e0     	mov	x0, x19
  12047c: aa1503e3     	mov	x3, x21
  120480: d63f0100     	blr	x8
  120484: 90003108     	adrp	x8, 0x740000

## 0x12049c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120490: f944cee1     	ldr	x1, [x23, #0x998]
  120494: b0002402     	adrp	x2, 0x5a1000
  120498: 91335c42     	add	x2, x2, #0xcd7
  12049c: f9408508     	ldr	x8, [x8, #0x108]
  1204a0: aa1303e0     	mov	x0, x19
  1204a4: aa1403e3     	mov	x3, x20
  1204a8: d63f0100     	blr	x8
  1204ac: 90003108     	adrp	x8, 0x740000

## 0x1204c4
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1204b8: f944cee1     	ldr	x1, [x23, #0x998]
  1204bc: b0002402     	adrp	x2, 0x5a1000
  1204c0: 91338442     	add	x2, x2, #0xce1
  1204c4: f9408508     	ldr	x8, [x8, #0x108]
  1204c8: aa1303e0     	mov	x0, x19
  1204cc: aa1403e3     	mov	x3, x20
  1204d0: d63f0100     	blr	x8
  1204d4: 90003108     	adrp	x8, 0x740000

## 0x12098c
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120980: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120984: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120988: aa0003e1     	mov	x1, x0
  12098c: f9408508     	ldr	x8, [x8, #0x108]
  120990: 91141042     	add	x2, x2, #0x504
  120994: 91142c63     	add	x3, x3, #0x50b
  120998: aa1303e0     	mov	x0, x19
  12099c: d63f0100     	blr	x8

## 0x1209e8
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  1209dc: f944f6c1     	ldr	x1, [x22, #0x9e8]
  1209e0: b0002402     	adrp	x2, 0x5a1000
  1209e4: 91338442     	add	x2, x2, #0xce1
  1209e8: f9408508     	ldr	x8, [x8, #0x108]
  1209ec: aa1303e0     	mov	x0, x19
  1209f0: aa1403e3     	mov	x3, x20
  1209f4: d63f0100     	blr	x8
  1209f8: 90003108     	adrp	x8, 0x740000

## 0x120a10
Classification: JNI_LIKELY
Function: 000000000010f158 <_ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_>:
ASM:
  120a04: f944f6c1     	ldr	x1, [x22, #0x9e8]
  120a08: b0002402     	adrp	x2, 0x5a1000
  120a0c: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120a10: f9408508     	ldr	x8, [x8, #0x108]
  120a14: 91346c42     	add	x2, x2, #0xd1b
  120a18: 91158463     	add	x3, x3, #0x561
  120a1c: aa1303e0     	mov	x0, x19
  120a20: d63f0100     	blr	x8

## 0x120c38
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120c2c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c30: b0002402     	adrp	x2, 0x5a1000
  120c34: 9131c442     	add	x2, x2, #0xc71
  120c38: f9408508     	ldr	x8, [x8, #0x108]
  120c3c: aa1303e0     	mov	x0, x19
  120c40: aa1403e3     	mov	x3, x20
  120c44: d63f0100     	blr	x8
  120c48: f9000700     	str	x0, [x24, #0x8]

## 0x120c5c
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120c50: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c54: b0002402     	adrp	x2, 0x5a1000
  120c58: 91320842     	add	x2, x2, #0xc82
  120c5c: f9408508     	ldr	x8, [x8, #0x108]
  120c60: aa1303e0     	mov	x0, x19
  120c64: aa1403e3     	mov	x3, x20
  120c68: d63f0100     	blr	x8
  120c6c: f9000b00     	str	x0, [x24, #0x10]

## 0x120c80
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120c74: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c78: b0002402     	adrp	x2, 0x5a1000
  120c7c: 91324442     	add	x2, x2, #0xc91
  120c80: f9408508     	ldr	x8, [x8, #0x108]
  120c84: aa1303e0     	mov	x0, x19
  120c88: aa1403e3     	mov	x3, x20
  120c8c: d63f0100     	blr	x8
  120c90: f9000f00     	str	x0, [x24, #0x18]

## 0x120ca4
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120c98: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c9c: b0002402     	adrp	x2, 0x5a1000
  120ca0: 91335c42     	add	x2, x2, #0xcd7
  120ca4: f9408508     	ldr	x8, [x8, #0x108]
  120ca8: aa1303e0     	mov	x0, x19
  120cac: aa1403e3     	mov	x3, x20
  120cb0: d63f0100     	blr	x8
  120cb4: f9001300     	str	x0, [x24, #0x20]

## 0x120cc8
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120cbc: f9450ae1     	ldr	x1, [x23, #0xa10]
  120cc0: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120cc4: 91149c42     	add	x2, x2, #0x527
  120cc8: f9408508     	ldr	x8, [x8, #0x108]
  120ccc: aa1303e0     	mov	x0, x19
  120cd0: aa1403e3     	mov	x3, x20
  120cd4: d63f0100     	blr	x8
  120cd8: f9001700     	str	x0, [x24, #0x28]

## 0x120cec
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120ce0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ce4: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120ce8: 9114d042     	add	x2, x2, #0x534
  120cec: f9408508     	ldr	x8, [x8, #0x108]
  120cf0: aa1303e0     	mov	x0, x19
  120cf4: aa1403e3     	mov	x3, x20
  120cf8: d63f0100     	blr	x8
  120cfc: f9001b00     	str	x0, [x24, #0x30]

## 0x120d10
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120d04: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d08: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120d0c: 91153c42     	add	x2, x2, #0x54f
  120d10: f9408508     	ldr	x8, [x8, #0x108]
  120d14: aa1303e0     	mov	x0, x19
  120d18: aa1403e3     	mov	x3, x20
  120d1c: d63f0100     	blr	x8
  120d20: f9001f00     	str	x0, [x24, #0x38]

## 0x120d34
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120d28: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d2c: b0002402     	adrp	x2, 0x5a1000
  120d30: 91338442     	add	x2, x2, #0xce1
  120d34: f9408508     	ldr	x8, [x8, #0x108]
  120d38: aa1303e0     	mov	x0, x19
  120d3c: aa1403e3     	mov	x3, x20
  120d40: d63f0100     	blr	x8
  120d44: f9002b00     	str	x0, [x24, #0x50]

## 0x120d58
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120d4c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d50: b0002402     	adrp	x2, 0x5a1000
  120d54: 91355042     	add	x2, x2, #0xd54
  120d58: f9408508     	ldr	x8, [x8, #0x108]
  120d5c: aa1303e0     	mov	x0, x19
  120d60: aa1403e3     	mov	x3, x20
  120d64: d63f0100     	blr	x8
  120d68: f9002f00     	str	x0, [x24, #0x58]

## 0x120da8
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120d9c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120da0: b0002402     	adrp	x2, 0x5a1000
  120da4: 9135f042     	add	x2, x2, #0xd7c
  120da8: f9408508     	ldr	x8, [x8, #0x108]
  120dac: aa1303e0     	mov	x0, x19
  120db0: aa1503e3     	mov	x3, x21
  120db4: d63f0100     	blr	x8
  120db8: f9002300     	str	x0, [x24, #0x40]

## 0x120dcc
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120dc0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120dc4: b0002402     	adrp	x2, 0x5a1000
  120dc8: 91362c42     	add	x2, x2, #0xd8b
  120dcc: f9408508     	ldr	x8, [x8, #0x108]
  120dd0: aa1303e0     	mov	x0, x19
  120dd4: aa1403e3     	mov	x3, x20
  120dd8: d63f0100     	blr	x8
  120ddc: f9002700     	str	x0, [x24, #0x48]

## 0x120df0
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120de4: f9450ae1     	ldr	x1, [x23, #0xa10]
  120de8: b0002402     	adrp	x2, 0x5a1000
  120dec: 91366442     	add	x2, x2, #0xd99
  120df0: f9408508     	ldr	x8, [x8, #0x108]
  120df4: aa1303e0     	mov	x0, x19
  120df8: aa1403e3     	mov	x3, x20
  120dfc: d63f0100     	blr	x8
  120e00: f9003700     	str	x0, [x24, #0x68]

## 0x120e14
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120e08: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e0c: b0002402     	adrp	x2, 0x5a1000
  120e10: 9136a842     	add	x2, x2, #0xdaa
  120e14: f9408508     	ldr	x8, [x8, #0x108]
  120e18: aa1303e0     	mov	x0, x19
  120e1c: aa1403e3     	mov	x3, x20
  120e20: d63f0100     	blr	x8
  120e24: f9003b00     	str	x0, [x24, #0x70]

## 0x120e38
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120e2c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e30: b0002402     	adrp	x2, 0x5a1000
  120e34: 9136ec42     	add	x2, x2, #0xdbb
  120e38: f9408508     	ldr	x8, [x8, #0x108]
  120e3c: aa1303e0     	mov	x0, x19
  120e40: aa1403e3     	mov	x3, x20
  120e44: d63f0100     	blr	x8
  120e48: f9003f00     	str	x0, [x24, #0x78]

## 0x120e5c
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120e50: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e54: b0002402     	adrp	x2, 0x5a1000
  120e58: 91373042     	add	x2, x2, #0xdcc
  120e5c: f9408508     	ldr	x8, [x8, #0x108]
  120e60: aa1303e0     	mov	x0, x19
  120e64: aa1403e3     	mov	x3, x20
  120e68: d63f0100     	blr	x8
  120e6c: f9004300     	str	x0, [x24, #0x80]

## 0x120e80
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120e74: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e78: b0002402     	adrp	x2, 0x5a1000
  120e7c: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120e80: f9408508     	ldr	x8, [x8, #0x108]
  120e84: 91377442     	add	x2, x2, #0xddd
  120e88: 91152c63     	add	x3, x3, #0x54b
  120e8c: aa1303e0     	mov	x0, x19
  120e90: d63f0100     	blr	x8

## 0x120ea8
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120e9c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ea0: b0002402     	adrp	x2, 0x5a1000
  120ea4: 9137b042     	add	x2, x2, #0xdec
  120ea8: f9408508     	ldr	x8, [x8, #0x108]
  120eac: aa1303e0     	mov	x0, x19
  120eb0: aa1403e3     	mov	x3, x20
  120eb4: d63f0100     	blr	x8
  120eb8: f9004b00     	str	x0, [x24, #0x90]

## 0x120ecc
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120ec0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ec4: b0002402     	adrp	x2, 0x5a1000
  120ec8: 9137e042     	add	x2, x2, #0xdf8
  120ecc: f9408508     	ldr	x8, [x8, #0x108]
  120ed0: aa1303e0     	mov	x0, x19
  120ed4: aa1403e3     	mov	x3, x20
  120ed8: d63f0100     	blr	x8
  120edc: f9004f00     	str	x0, [x24, #0x98]

## 0x120ef0
Classification: JNI_LIKELY
Function: 0000000000120b94 <_ZN10JavaVidSts4initEP7_JNIEnv>:
ASM:
  120ee4: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ee8: b0002402     	adrp	x2, 0x5a1000
  120eec: 91384c42     	add	x2, x2, #0xe13
  120ef0: f9408508     	ldr	x8, [x8, #0x108]
  120ef4: aa1303e0     	mov	x0, x19
  120ef8: aa1403e3     	mov	x3, x20
  120efc: d63f0100     	blr	x8
  120f00: f9005300     	str	x0, [x24, #0xa0]

## 0x1218d0
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  1218c4: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1218c8: 900023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1218cc: aa0003e1     	mov	x1, x0
  1218d0: f9408508     	ldr	x8, [x8, #0x108]
  1218d4: 91141042     	add	x2, x2, #0x504
  1218d8: 91142c63     	add	x3, x3, #0x50b
  1218dc: aa1303e0     	mov	x0, x19
  1218e0: d63f0100     	blr	x8

## 0x121930
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121924: f94566e1     	ldr	x1, [x23, #0xac8]
  121928: 90002402     	adrp	x2, 0x5a1000
  12192c: 91343c42     	add	x2, x2, #0xd0f
  121930: f9408508     	ldr	x8, [x8, #0x108]
  121934: aa1303e0     	mov	x0, x19
  121938: aa1403e3     	mov	x3, x20
  12193c: d63f0100     	blr	x8
  121940: f9000700     	str	x0, [x24, #0x8]

## 0x121954
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121948: f94566e1     	ldr	x1, [x23, #0xac8]
  12194c: 90002402     	adrp	x2, 0x5a1000
  121950: 91335c42     	add	x2, x2, #0xcd7
  121954: f9408508     	ldr	x8, [x8, #0x108]
  121958: aa1303e0     	mov	x0, x19
  12195c: aa1403e3     	mov	x3, x20
  121960: d63f0100     	blr	x8
  121964: f9000b00     	str	x0, [x24, #0x10]

## 0x1219a8
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  12199c: f94566e1     	ldr	x1, [x23, #0xac8]
  1219a0: 90002402     	adrp	x2, 0x5a1000
  1219a4: 91346c42     	add	x2, x2, #0xd1b
  1219a8: f9408508     	ldr	x8, [x8, #0x108]
  1219ac: aa1303e0     	mov	x0, x19
  1219b0: aa1503e3     	mov	x3, x21
  1219b4: d63f0100     	blr	x8
  1219b8: f00030e8     	adrp	x8, 0x740000

## 0x1219d0
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  1219c4: f94566e1     	ldr	x1, [x23, #0xac8]
  1219c8: 90002402     	adrp	x2, 0x5a1000
  1219cc: 91395442     	add	x2, x2, #0xe55
  1219d0: f9408508     	ldr	x8, [x8, #0x108]
  1219d4: aa1303e0     	mov	x0, x19
  1219d8: aa1503e3     	mov	x3, x21
  1219dc: d63f0100     	blr	x8
  1219e0: f00030e8     	adrp	x8, 0x740000

## 0x1219f8
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  1219ec: f94566e1     	ldr	x1, [x23, #0xac8]
  1219f0: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1219f4: 91149c42     	add	x2, x2, #0x527
  1219f8: f9408508     	ldr	x8, [x8, #0x108]
  1219fc: aa1303e0     	mov	x0, x19
  121a00: aa1403e3     	mov	x3, x20
  121a04: d63f0100     	blr	x8
  121a08: f9000f00     	str	x0, [x24, #0x18]

## 0x121a1c
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121a10: f94566e1     	ldr	x1, [x23, #0xac8]
  121a14: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  121a18: 9114d042     	add	x2, x2, #0x534
  121a1c: f9408508     	ldr	x8, [x8, #0x108]
  121a20: aa1303e0     	mov	x0, x19
  121a24: aa1403e3     	mov	x3, x20
  121a28: d63f0100     	blr	x8
  121a2c: f9001300     	str	x0, [x24, #0x20]

## 0x121a40
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121a34: f94566e1     	ldr	x1, [x23, #0xac8]
  121a38: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  121a3c: 91153c42     	add	x2, x2, #0x54f
  121a40: f9408508     	ldr	x8, [x8, #0x108]
  121a44: aa1303e0     	mov	x0, x19
  121a48: aa1403e3     	mov	x3, x20
  121a4c: d63f0100     	blr	x8
  121a50: f9001700     	str	x0, [x24, #0x28]

## 0x121a90
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121a84: f94566e1     	ldr	x1, [x23, #0xac8]
  121a88: 90002402     	adrp	x2, 0x5a1000
  121a8c: 91362c42     	add	x2, x2, #0xd8b
  121a90: f9408508     	ldr	x8, [x8, #0x108]
  121a94: aa1303e0     	mov	x0, x19
  121a98: aa1403e3     	mov	x3, x20
  121a9c: d63f0100     	blr	x8
  121aa0: f9001f00     	str	x0, [x24, #0x38]

## 0x121ab4
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121aa8: f94566e1     	ldr	x1, [x23, #0xac8]
  121aac: 90002402     	adrp	x2, 0x5a1000
  121ab0: 91338442     	add	x2, x2, #0xce1
  121ab4: f9408508     	ldr	x8, [x8, #0x108]
  121ab8: aa1303e0     	mov	x0, x19
  121abc: aa1403e3     	mov	x3, x20
  121ac0: d63f0100     	blr	x8
  121ac4: f9002300     	str	x0, [x24, #0x40]

## 0x121ad8
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121acc: f94566e1     	ldr	x1, [x23, #0xac8]
  121ad0: 90002402     	adrp	x2, 0x5a1000
  121ad4: 91355042     	add	x2, x2, #0xd54
  121ad8: f9408508     	ldr	x8, [x8, #0x108]
  121adc: aa1303e0     	mov	x0, x19
  121ae0: aa1403e3     	mov	x3, x20
  121ae4: d63f0100     	blr	x8
  121ae8: f9002700     	str	x0, [x24, #0x48]

## 0x121afc
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121af0: f94566e1     	ldr	x1, [x23, #0xac8]
  121af4: 90002402     	adrp	x2, 0x5a1000
  121af8: 91359442     	add	x2, x2, #0xd65
  121afc: f9408508     	ldr	x8, [x8, #0x108]
  121b00: aa1303e0     	mov	x0, x19
  121b04: aa1503e3     	mov	x3, x21
  121b08: d63f0100     	blr	x8
  121b0c: f9002b00     	str	x0, [x24, #0x50]

## 0x121b20
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121b14: f94566e1     	ldr	x1, [x23, #0xac8]
  121b18: 90002402     	adrp	x2, 0x5a1000
  121b1c: 91366442     	add	x2, x2, #0xd99
  121b20: f9408508     	ldr	x8, [x8, #0x108]
  121b24: aa1303e0     	mov	x0, x19
  121b28: aa1403e3     	mov	x3, x20
  121b2c: d63f0100     	blr	x8
  121b30: f9002f00     	str	x0, [x24, #0x58]

## 0x121b44
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121b38: f94566e1     	ldr	x1, [x23, #0xac8]
  121b3c: 90002402     	adrp	x2, 0x5a1000
  121b40: 9136a842     	add	x2, x2, #0xdaa
  121b44: f9408508     	ldr	x8, [x8, #0x108]
  121b48: aa1303e0     	mov	x0, x19
  121b4c: aa1403e3     	mov	x3, x20
  121b50: d63f0100     	blr	x8
  121b54: f9003300     	str	x0, [x24, #0x60]

## 0x121b68
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121b5c: f94566e1     	ldr	x1, [x23, #0xac8]
  121b60: 90002402     	adrp	x2, 0x5a1000
  121b64: 9136ec42     	add	x2, x2, #0xdbb
  121b68: f9408508     	ldr	x8, [x8, #0x108]
  121b6c: aa1303e0     	mov	x0, x19
  121b70: aa1403e3     	mov	x3, x20
  121b74: d63f0100     	blr	x8
  121b78: f9003700     	str	x0, [x24, #0x68]

## 0x121b8c
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121b80: f94566e1     	ldr	x1, [x23, #0xac8]
  121b84: 90002402     	adrp	x2, 0x5a1000
  121b88: 91373042     	add	x2, x2, #0xdcc
  121b8c: f9408508     	ldr	x8, [x8, #0x108]
  121b90: aa1303e0     	mov	x0, x19
  121b94: aa1403e3     	mov	x3, x20
  121b98: d63f0100     	blr	x8
  121b9c: f9003b00     	str	x0, [x24, #0x70]

## 0x121bb0
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121ba4: f94566e1     	ldr	x1, [x23, #0xac8]
  121ba8: 90002402     	adrp	x2, 0x5a1000
  121bac: 900023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  121bb0: f9408508     	ldr	x8, [x8, #0x108]
  121bb4: 91377442     	add	x2, x2, #0xddd
  121bb8: 91152c63     	add	x3, x3, #0x54b
  121bbc: aa1303e0     	mov	x0, x19
  121bc0: d63f0100     	blr	x8

## 0x121bd8
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121bcc: f94566e1     	ldr	x1, [x23, #0xac8]
  121bd0: 90002402     	adrp	x2, 0x5a1000
  121bd4: 9137b042     	add	x2, x2, #0xdec
  121bd8: f9408508     	ldr	x8, [x8, #0x108]
  121bdc: aa1303e0     	mov	x0, x19
  121be0: aa1403e3     	mov	x3, x20
  121be4: d63f0100     	blr	x8
  121be8: f9004300     	str	x0, [x24, #0x80]

## 0x121bfc
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121bf0: f94566e1     	ldr	x1, [x23, #0xac8]
  121bf4: 90002402     	adrp	x2, 0x5a1000
  121bf8: 9137e042     	add	x2, x2, #0xdf8
  121bfc: f9408508     	ldr	x8, [x8, #0x108]
  121c00: aa1303e0     	mov	x0, x19
  121c04: aa1403e3     	mov	x3, x20
  121c08: d63f0100     	blr	x8
  121c0c: f9004700     	str	x0, [x24, #0x88]

## 0x121c20
Classification: JNI_LIKELY
Function: 0000000000121860 <_ZN11JavaVidAuth4initEP7_JNIEnv>:
ASM:
  121c14: f94566e1     	ldr	x1, [x23, #0xac8]
  121c18: 90002402     	adrp	x2, 0x5a1000
  121c1c: 91384c42     	add	x2, x2, #0xe13
  121c20: f9408508     	ldr	x8, [x8, #0x108]
  121c24: aa1303e0     	mov	x0, x19
  121c28: aa1403e3     	mov	x3, x20
  121c2c: d63f0100     	blr	x8
  121c30: f9004b00     	str	x0, [x24, #0x90]

## 0x1226b0
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1226a4: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226a8: f00023e2     	adrp	x2, 0x5a1000
  1226ac: 9131c442     	add	x2, x2, #0xc71
  1226b0: f9408508     	ldr	x8, [x8, #0x108]
  1226b4: aa1303e0     	mov	x0, x19
  1226b8: aa1403e3     	mov	x3, x20
  1226bc: d63f0100     	blr	x8
  1226c0: f9000ee0     	str	x0, [x23, #0x18]

## 0x1226d4
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1226c8: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226cc: f00023e2     	adrp	x2, 0x5a1000
  1226d0: 91320842     	add	x2, x2, #0xc82
  1226d4: f9408508     	ldr	x8, [x8, #0x108]
  1226d8: aa1303e0     	mov	x0, x19
  1226dc: aa1403e3     	mov	x3, x20
  1226e0: d63f0100     	blr	x8
  1226e4: f90006e0     	str	x0, [x23, #0x8]

## 0x1226f8
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1226ec: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226f0: f00023e2     	adrp	x2, 0x5a1000
  1226f4: 91324442     	add	x2, x2, #0xc91
  1226f8: f9408508     	ldr	x8, [x8, #0x108]
  1226fc: aa1303e0     	mov	x0, x19
  122700: aa1403e3     	mov	x3, x20
  122704: d63f0100     	blr	x8
  122708: f9000ae0     	str	x0, [x23, #0x10]

## 0x12271c
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  122710: f945c6c1     	ldr	x1, [x22, #0xb88]
  122714: f00023e2     	adrp	x2, 0x5a1000
  122718: 91335c42     	add	x2, x2, #0xcd7
  12271c: f9408508     	ldr	x8, [x8, #0x108]
  122720: aa1303e0     	mov	x0, x19
  122724: aa1403e3     	mov	x3, x20
  122728: d63f0100     	blr	x8
  12272c: f9001ee0     	str	x0, [x23, #0x38]

## 0x122740
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  122734: f945c6c1     	ldr	x1, [x22, #0xb88]
  122738: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  12273c: 91149c42     	add	x2, x2, #0x527
  122740: f9408508     	ldr	x8, [x8, #0x108]
  122744: aa1303e0     	mov	x0, x19
  122748: aa1403e3     	mov	x3, x20
  12274c: d63f0100     	blr	x8
  122750: f90022e0     	str	x0, [x23, #0x40]

## 0x122764
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  122758: f945c6c1     	ldr	x1, [x22, #0xb88]
  12275c: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  122760: 9114d042     	add	x2, x2, #0x534
  122764: f9408508     	ldr	x8, [x8, #0x108]
  122768: aa1303e0     	mov	x0, x19
  12276c: aa1403e3     	mov	x3, x20
  122770: d63f0100     	blr	x8
  122774: f90026e0     	str	x0, [x23, #0x48]

## 0x122788
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  12277c: f945c6c1     	ldr	x1, [x22, #0xb88]
  122780: f00023e2     	adrp	x2, 0x5a1000
  122784: 913a2c42     	add	x2, x2, #0xe8b
  122788: f9408508     	ldr	x8, [x8, #0x108]
  12278c: aa1303e0     	mov	x0, x19
  122790: aa1403e3     	mov	x3, x20
  122794: d63f0100     	blr	x8
  122798: f90012e0     	str	x0, [x23, #0x20]

## 0x1227ac
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1227a0: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227a4: f00023e2     	adrp	x2, 0x5a1000
  1227a8: 913a6442     	add	x2, x2, #0xe99
  1227ac: f9408508     	ldr	x8, [x8, #0x108]
  1227b0: aa1303e0     	mov	x0, x19
  1227b4: aa1403e3     	mov	x3, x20
  1227b8: d63f0100     	blr	x8
  1227bc: f90016e0     	str	x0, [x23, #0x28]

## 0x1227d0
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1227c4: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227c8: f00023e2     	adrp	x2, 0x5a1000
  1227cc: 913a9442     	add	x2, x2, #0xea5
  1227d0: f9408508     	ldr	x8, [x8, #0x108]
  1227d4: aa1303e0     	mov	x0, x19
  1227d8: aa1403e3     	mov	x3, x20
  1227dc: d63f0100     	blr	x8
  1227e0: f9001ae0     	str	x0, [x23, #0x30]

## 0x1227f4
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  1227e8: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227ec: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1227f0: 91153c42     	add	x2, x2, #0x54f
  1227f4: f9408508     	ldr	x8, [x8, #0x108]
  1227f8: aa1303e0     	mov	x0, x19
  1227fc: aa1403e3     	mov	x3, x20
  122800: d63f0100     	blr	x8
  122804: f9002ae0     	str	x0, [x23, #0x50]

## 0x122818
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  12280c: f945c6c1     	ldr	x1, [x22, #0xb88]
  122810: f00023e2     	adrp	x2, 0x5a1000
  122814: b00023e3     	adrp	x3, 0x59f000
  122818: f9408508     	ldr	x8, [x8, #0x108]
  12281c: 9135f042     	add	x2, x2, #0xd7c
  122820: 911a3463     	add	x3, x3, #0x68d
  122824: aa1303e0     	mov	x0, x19
  122828: d63f0100     	blr	x8

## 0x122840
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  122834: f945c6c1     	ldr	x1, [x22, #0xb88]
  122838: f00023e2     	adrp	x2, 0x5a1000
  12283c: 91338442     	add	x2, x2, #0xce1
  122840: f9408508     	ldr	x8, [x8, #0x108]
  122844: aa1303e0     	mov	x0, x19
  122848: aa1403e3     	mov	x3, x20
  12284c: d63f0100     	blr	x8
  122850: f90032e0     	str	x0, [x23, #0x60]

## 0x122864
Classification: JNI_LIKELY
Function: 00000000001224a0 <_ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource>:
ASM:
  122858: f945c6c1     	ldr	x1, [x22, #0xb88]
  12285c: f00023e2     	adrp	x2, 0x5a1000
  122860: 91355042     	add	x2, x2, #0xd54
  122864: f9408508     	ldr	x8, [x8, #0x108]
  122868: aa1303e0     	mov	x0, x19
  12286c: aa1403e3     	mov	x3, x20
  122870: d63f0100     	blr	x8
  122874: f90036e0     	str	x0, [x23, #0x68]

## 0x123058
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  12304c: f94602c1     	ldr	x1, [x22, #0xc00]
  123050: d00023e2     	adrp	x2, 0x5a1000
  123054: 91320842     	add	x2, x2, #0xc82
  123058: f9408508     	ldr	x8, [x8, #0x108]
  12305c: aa1303e0     	mov	x0, x19
  123060: aa1403e3     	mov	x3, x20
  123064: d63f0100     	blr	x8
  123068: b00030e8     	adrp	x8, 0x740000

## 0x123080
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123074: f94602c1     	ldr	x1, [x22, #0xc00]
  123078: d00023e2     	adrp	x2, 0x5a1000
  12307c: 91324442     	add	x2, x2, #0xc91
  123080: f9408508     	ldr	x8, [x8, #0x108]
  123084: aa1303e0     	mov	x0, x19
  123088: aa1403e3     	mov	x3, x20
  12308c: d63f0100     	blr	x8
  123090: b00030e8     	adrp	x8, 0x740000

## 0x1230a8
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  12309c: f94602c1     	ldr	x1, [x22, #0xc00]
  1230a0: d00023e2     	adrp	x2, 0x5a1000
  1230a4: 91335c42     	add	x2, x2, #0xcd7
  1230a8: f9408508     	ldr	x8, [x8, #0x108]
  1230ac: aa1303e0     	mov	x0, x19
  1230b0: aa1403e3     	mov	x3, x20
  1230b4: d63f0100     	blr	x8
  1230b8: b00030e8     	adrp	x8, 0x740000

## 0x1230d0
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  1230c4: f94602c1     	ldr	x1, [x22, #0xc00]
  1230c8: d00023e2     	adrp	x2, 0x5a1000
  1230cc: d00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1230d0: f9408508     	ldr	x8, [x8, #0x108]
  1230d4: 913b5042     	add	x2, x2, #0xed4
  1230d8: 91174463     	add	x3, x3, #0x5d1
  1230dc: aa1303e0     	mov	x0, x19
  1230e0: d63f0100     	blr	x8

## 0x1230fc
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  1230f0: f94602c1     	ldr	x1, [x22, #0xc00]
  1230f4: d00023e2     	adrp	x2, 0x5a1000
  1230f8: 913bac42     	add	x2, x2, #0xeeb
  1230fc: f9408508     	ldr	x8, [x8, #0x108]
  123100: aa1303e0     	mov	x0, x19
  123104: aa1403e3     	mov	x3, x20
  123108: d63f0100     	blr	x8
  12310c: b00030e8     	adrp	x8, 0x740000

## 0x123124
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123118: f94602c1     	ldr	x1, [x22, #0xc00]
  12311c: d00023e2     	adrp	x2, 0x5a1000
  123120: 913bc842     	add	x2, x2, #0xef2
  123124: f9408508     	ldr	x8, [x8, #0x108]
  123128: aa1303e0     	mov	x0, x19
  12312c: aa1403e3     	mov	x3, x20
  123130: d63f0100     	blr	x8
  123134: b00030e8     	adrp	x8, 0x740000

## 0x12314c
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123140: f94602c1     	ldr	x1, [x22, #0xc00]
  123144: d00023e2     	adrp	x2, 0x5a1000
  123148: 913bf042     	add	x2, x2, #0xefc
  12314c: f9408508     	ldr	x8, [x8, #0x108]
  123150: aa1303e0     	mov	x0, x19
  123154: aa1403e3     	mov	x3, x20
  123158: d63f0100     	blr	x8
  12315c: b00030e8     	adrp	x8, 0x740000

## 0x123174
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123168: f94602c1     	ldr	x1, [x22, #0xc00]
  12316c: d00023e2     	adrp	x2, 0x5a1000
  123170: 913c0c42     	add	x2, x2, #0xf03
  123174: f9408508     	ldr	x8, [x8, #0x108]
  123178: aa1303e0     	mov	x0, x19
  12317c: aa1403e3     	mov	x3, x20
  123180: d63f0100     	blr	x8
  123184: b00030e8     	adrp	x8, 0x740000

## 0x12319c
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123190: f94602c1     	ldr	x1, [x22, #0xc00]
  123194: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  123198: 91149c42     	add	x2, x2, #0x527
  12319c: f9408508     	ldr	x8, [x8, #0x108]
  1231a0: aa1303e0     	mov	x0, x19
  1231a4: aa1403e3     	mov	x3, x20
  1231a8: d63f0100     	blr	x8
  1231ac: b00030e8     	adrp	x8, 0x740000

## 0x1231c4
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  1231b8: f94602c1     	ldr	x1, [x22, #0xc00]
  1231bc: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1231c0: 9114d042     	add	x2, x2, #0x534
  1231c4: f9408508     	ldr	x8, [x8, #0x108]
  1231c8: aa1303e0     	mov	x0, x19
  1231cc: aa1403e3     	mov	x3, x20
  1231d0: d63f0100     	blr	x8
  1231d4: b00030e8     	adrp	x8, 0x740000

## 0x1231ec
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  1231e0: f94602c1     	ldr	x1, [x22, #0xc00]
  1231e4: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1231e8: 91153c42     	add	x2, x2, #0x54f
  1231ec: f9408508     	ldr	x8, [x8, #0x108]
  1231f0: aa1303e0     	mov	x0, x19
  1231f4: aa1403e3     	mov	x3, x20
  1231f8: d63f0100     	blr	x8
  1231fc: b00030e8     	adrp	x8, 0x740000

## 0x123214
Classification: JNI_LIKELY
Function: 0000000000122fbc <_ZN11JavaLiveSts4initEP7_JNIEnv>:
ASM:
  123208: f94602c1     	ldr	x1, [x22, #0xc00]
  12320c: d00023e2     	adrp	x2, 0x5a1000
  123210: 900023e3     	adrp	x3, 0x59f000
  123214: f9408508     	ldr	x8, [x8, #0x108]
  123218: 9135f042     	add	x2, x2, #0xd7c
  12321c: 911a3463     	add	x3, x3, #0x68d
  123220: aa1303e0     	mov	x0, x19
  123224: d63f0100     	blr	x8

## 0x1236e0
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  1236d4: 910fce94     	add	x20, x20, #0x3f3
  1236d8: 91149c42     	add	x2, x2, #0x527
  1236dc: aa1303e0     	mov	x0, x19
  1236e0: f9408508     	ldr	x8, [x8, #0x108]
  1236e4: aa1403e3     	mov	x3, x20
  1236e8: d63f0100     	blr	x8
  1236ec: 90003088     	adrp	x8, 0x733000
  1236f0: f9467d08     	ldr	x8, [x8, #0xcf8]

## 0x123710
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  123704: f9400268     	ldr	x8, [x19]
  123708: aa1303e0     	mov	x0, x19
  12370c: aa1403e3     	mov	x3, x20
  123710: f9408508     	ldr	x8, [x8, #0x108]
  123714: d63f0100     	blr	x8
  123718: 90003088     	adrp	x8, 0x733000
  12371c: f9468108     	ldr	x8, [x8, #0xd00]
  123720: f94002c1     	ldr	x1, [x22]

## 0x12373c
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  123730: f9400268     	ldr	x8, [x19]
  123734: aa1303e0     	mov	x0, x19
  123738: aa1403e3     	mov	x3, x20
  12373c: f9408508     	ldr	x8, [x8, #0x108]
  123740: d63f0100     	blr	x8
  123744: 90003088     	adrp	x8, 0x733000
  123748: f9468508     	ldr	x8, [x8, #0xd08]
  12374c: f94002c1     	ldr	x1, [x22]

## 0x12376c
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  123760: 9135f042     	add	x2, x2, #0xd7c
  123764: 911a3463     	add	x3, x3, #0x68d
  123768: aa1303e0     	mov	x0, x19
  12376c: f9408508     	ldr	x8, [x8, #0x108]
  123770: d63f0100     	blr	x8
  123774: 90003088     	adrp	x8, 0x733000
  123778: f9468908     	ldr	x8, [x8, #0xd10]
  12377c: 900023e1     	adrp	x1, 0x59f000

## 0x1237d4
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  1237c8: 9109c442     	add	x2, x2, #0x271
  1237cc: 91174463     	add	x3, x3, #0x5d1
  1237d0: aa1303e0     	mov	x0, x19
  1237d4: f9408508     	ldr	x8, [x8, #0x108]
  1237d8: d63f0100     	blr	x8
  1237dc: 90003088     	adrp	x8, 0x733000
  1237e0: f9469108     	ldr	x8, [x8, #0xd20]
  1237e4: f9400281     	ldr	x1, [x20]

## 0x123804
Classification: PROVEN_CXX_OBJECT
Function: 0000000000123544 <_ZN12JavaVodAsset4initEP7_JNIEnv>:
ASM:
  1237f8: 913b1842     	add	x2, x2, #0xec6
  1237fc: 91189463     	add	x3, x3, #0x625
  123800: aa1303e0     	mov	x0, x19
  123804: f9408508     	ldr	x8, [x8, #0x108]
  123808: d63f0100     	blr	x8
  12380c: 90003088     	adrp	x8, 0x733000
  123810: f9469508     	ldr	x8, [x8, #0xd28]
  123814: f9000100     	str	x0, [x8]

## 0x124988
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  12497c: b00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  124980: b00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  124984: aa0003e1     	mov	x1, x0
  124988: f9408508     	ldr	x8, [x8, #0x108]
  12498c: 91141042     	add	x2, x2, #0x504
  124990: 91158463     	add	x3, x3, #0x561
  124994: aa1303e0     	mov	x0, x19
  124998: d63f0100     	blr	x8

## 0x1249e4
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  1249d8: f9467381     	ldr	x1, [x28, #0xce0]
  1249dc: b00023e2     	adrp	x2, 0x5a1000
  1249e0: 913efc42     	add	x2, x2, #0xfbf
  1249e4: f9408508     	ldr	x8, [x8, #0x108]
  1249e8: aa1303e0     	mov	x0, x19
  1249ec: aa1403e3     	mov	x3, x20
  1249f0: d63f0100     	blr	x8
  1249f4: f9000b60     	str	x0, [x27, #0x10]

## 0x124a08
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  1249fc: f9467381     	ldr	x1, [x28, #0xce0]
  124a00: b00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  124a04: 9114d042     	add	x2, x2, #0x534
  124a08: f9408508     	ldr	x8, [x8, #0x108]
  124a0c: aa1303e0     	mov	x0, x19
  124a10: aa1403e3     	mov	x3, x20
  124a14: d63f0100     	blr	x8
  124a18: f9000f60     	str	x0, [x27, #0x18]

## 0x124a2c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124a20: f9467381     	ldr	x1, [x28, #0xce0]
  124a24: b00023e2     	adrp	x2, 0x5a1000
  124a28: 913f2842     	add	x2, x2, #0xfca
  124a2c: f9408508     	ldr	x8, [x8, #0x108]
  124a30: aa1303e0     	mov	x0, x19
  124a34: aa1403e3     	mov	x3, x20
  124a38: d63f0100     	blr	x8
  124a3c: f9001360     	str	x0, [x27, #0x20]

## 0x124a50
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124a44: f9467381     	ldr	x1, [x28, #0xce0]
  124a48: b00023e2     	adrp	x2, 0x5a1000
  124a4c: 913f5842     	add	x2, x2, #0xfd6
  124a50: f9408508     	ldr	x8, [x8, #0x108]
  124a54: aa1303e0     	mov	x0, x19
  124a58: aa1403e3     	mov	x3, x20
  124a5c: d63f0100     	blr	x8
  124a60: f9001760     	str	x0, [x27, #0x28]

## 0x124a74
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124a68: f9467381     	ldr	x1, [x28, #0xce0]
  124a6c: b00023f6     	adrp	x22, 0x5a1000
  124a70: 913f9ed6     	add	x22, x22, #0xfe7
  124a74: f9408508     	ldr	x8, [x8, #0x108]
  124a78: aa1303e0     	mov	x0, x19
  124a7c: aa1603e2     	mov	x2, x22
  124a80: aa1403e3     	mov	x3, x20
  124a84: d63f0100     	blr	x8

## 0x124a9c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124a90: f9467381     	ldr	x1, [x28, #0xce0]
  124a94: b00023f7     	adrp	x23, 0x5a1000
  124a98: 913fdef7     	add	x23, x23, #0xff7
  124a9c: f9408508     	ldr	x8, [x8, #0x108]
  124aa0: aa1303e0     	mov	x0, x19
  124aa4: aa1703e2     	mov	x2, x23
  124aa8: aa1403e3     	mov	x3, x20
  124aac: d63f0100     	blr	x8

## 0x124ac4
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124ab8: f9467381     	ldr	x1, [x28, #0xce0]
  124abc: d00023e2     	adrp	x2, 0x5a2000
  124ac0: 91000442     	add	x2, x2, #0x1
  124ac4: f9408508     	ldr	x8, [x8, #0x108]
  124ac8: aa1303e0     	mov	x0, x19
  124acc: aa1403e3     	mov	x3, x20
  124ad0: d63f0100     	blr	x8
  124ad4: f9002360     	str	x0, [x27, #0x40]

## 0x124b18
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124b0c: f9467381     	ldr	x1, [x28, #0xce0]
  124b10: d00023e2     	adrp	x2, 0x5a2000
  124b14: 91006842     	add	x2, x2, #0x1a
  124b18: f9408508     	ldr	x8, [x8, #0x108]
  124b1c: aa1303e0     	mov	x0, x19
  124b20: aa1403e3     	mov	x3, x20
  124b24: d63f0100     	blr	x8
  124b28: f9002b60     	str	x0, [x27, #0x50]

## 0x124b68
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124b5c: f9467381     	ldr	x1, [x28, #0xce0]
  124b60: d00023e2     	adrp	x2, 0x5a2000
  124b64: 91013042     	add	x2, x2, #0x4c
  124b68: f9408508     	ldr	x8, [x8, #0x108]
  124b6c: aa1303e0     	mov	x0, x19
  124b70: aa1503e3     	mov	x3, x21
  124b74: d63f0100     	blr	x8
  124b78: d00023e2     	adrp	x2, 0x5a2000

## 0x124bbc
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124bb0: b00023e2     	adrp	x2, 0x5a1000
  124bb4: aa0003e1     	mov	x1, x0
  124bb8: 913bac42     	add	x2, x2, #0xeeb
  124bbc: f9408508     	ldr	x8, [x8, #0x108]
  124bc0: aa1303e0     	mov	x0, x19
  124bc4: aa1403e3     	mov	x3, x20
  124bc8: d63f0100     	blr	x8
  124bcc: d00023e2     	adrp	x2, 0x5a2000

## 0x124c10
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124c04: d00023e2     	adrp	x2, 0x5a2000
  124c08: aa0003e1     	mov	x1, x0
  124c0c: 91032442     	add	x2, x2, #0xc9
  124c10: f9408508     	ldr	x8, [x8, #0x108]
  124c14: aa1303e0     	mov	x0, x19
  124c18: aa1403e3     	mov	x3, x20
  124c1c: d63f0100     	blr	x8
  124c20: f9003b60     	str	x0, [x27, #0x70]

## 0x124c34
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124c28: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c2c: d00023e2     	adrp	x2, 0x5a2000
  124c30: 91034c42     	add	x2, x2, #0xd3
  124c34: f9408508     	ldr	x8, [x8, #0x108]
  124c38: aa1303e0     	mov	x0, x19
  124c3c: aa1403e3     	mov	x3, x20
  124c40: d63f0100     	blr	x8
  124c44: f9003f60     	str	x0, [x27, #0x78]

## 0x124c58
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124c4c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c50: d00023e2     	adrp	x2, 0x5a2000
  124c54: 91038442     	add	x2, x2, #0xe1
  124c58: f9408508     	ldr	x8, [x8, #0x108]
  124c5c: aa1303e0     	mov	x0, x19
  124c60: aa1403e3     	mov	x3, x20
  124c64: d63f0100     	blr	x8
  124c68: f9004360     	str	x0, [x27, #0x80]

## 0x124c7c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124c70: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c74: d00023e2     	adrp	x2, 0x5a2000
  124c78: 9103d442     	add	x2, x2, #0xf5
  124c7c: f9408508     	ldr	x8, [x8, #0x108]
  124c80: aa1303e0     	mov	x0, x19
  124c84: aa1403e3     	mov	x3, x20
  124c88: d63f0100     	blr	x8
  124c8c: f9004760     	str	x0, [x27, #0x88]

## 0x124ccc
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124cc0: f9467b81     	ldr	x1, [x28, #0xcf0]
  124cc4: d00023e2     	adrp	x2, 0x5a2000
  124cc8: 91044c42     	add	x2, x2, #0x113
  124ccc: f9408508     	ldr	x8, [x8, #0x108]
  124cd0: aa1303e0     	mov	x0, x19
  124cd4: aa1403e3     	mov	x3, x20
  124cd8: d63f0100     	blr	x8
  124cdc: f9004f60     	str	x0, [x27, #0x98]

## 0x124cf0
Classification: PROVEN_CXX_OBJECT
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124ce4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124ce8: aa1303e0     	mov	x0, x19
  124cec: aa1603e2     	mov	x2, x22
  124cf0: f9408508     	ldr	x8, [x8, #0x108]
  124cf4: aa1403e3     	mov	x3, x20
  124cf8: d63f0100     	blr	x8
  124cfc: f9005360     	str	x0, [x27, #0xa0]
  124d00: f9400268     	ldr	x8, [x19]

## 0x124d10
Classification: PROVEN_CXX_OBJECT
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124d04: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d08: aa1303e0     	mov	x0, x19
  124d0c: aa1703e2     	mov	x2, x23
  124d10: f9408508     	ldr	x8, [x8, #0x108]
  124d14: aa1403e3     	mov	x3, x20
  124d18: d63f0100     	blr	x8
  124d1c: f9005760     	str	x0, [x27, #0xa8]
  124d20: f9400268     	ldr	x8, [x19]

## 0x124d30
Classification: PROVEN_CXX_OBJECT
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124d24: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d28: aa1303e0     	mov	x0, x19
  124d2c: aa1803e2     	mov	x2, x24
  124d30: f9408508     	ldr	x8, [x8, #0x108]
  124d34: aa1903e3     	mov	x3, x25
  124d38: d63f0100     	blr	x8
  124d3c: f9005b60     	str	x0, [x27, #0xb0]
  124d40: f9400268     	ldr	x8, [x19]

## 0x124d50
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124d44: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d48: d00023e2     	adrp	x2, 0x5a2000
  124d4c: 91047842     	add	x2, x2, #0x11e
  124d50: f9408508     	ldr	x8, [x8, #0x108]
  124d54: aa1303e0     	mov	x0, x19
  124d58: aa1403e3     	mov	x3, x20
  124d5c: d63f0100     	blr	x8
  124d60: f9005f60     	str	x0, [x27, #0xb8]

## 0x124d74
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124d68: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d6c: d00023e2     	adrp	x2, 0x5a2000
  124d70: 91049c42     	add	x2, x2, #0x127
  124d74: f9408508     	ldr	x8, [x8, #0x108]
  124d78: aa1303e0     	mov	x0, x19
  124d7c: aa1503e3     	mov	x3, x21
  124d80: d63f0100     	blr	x8
  124d84: f9006360     	str	x0, [x27, #0xc0]

## 0x124d98
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124d8c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d90: d00023e2     	adrp	x2, 0x5a2000
  124d94: 9104c842     	add	x2, x2, #0x132
  124d98: f9408508     	ldr	x8, [x8, #0x108]
  124d9c: aa1303e0     	mov	x0, x19
  124da0: aa1403e3     	mov	x3, x20
  124da4: d63f0100     	blr	x8
  124da8: f9006760     	str	x0, [x27, #0xc8]

## 0x124dbc
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124db0: f9467b81     	ldr	x1, [x28, #0xcf0]
  124db4: d00023e2     	adrp	x2, 0x5a2000
  124db8: 91050442     	add	x2, x2, #0x141
  124dbc: f9408508     	ldr	x8, [x8, #0x108]
  124dc0: aa1303e0     	mov	x0, x19
  124dc4: aa1503e3     	mov	x3, x21
  124dc8: d63f0100     	blr	x8
  124dcc: f9006b60     	str	x0, [x27, #0xd0]

## 0x124de0
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124dd4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124dd8: d00023e2     	adrp	x2, 0x5a2000
  124ddc: 91052842     	add	x2, x2, #0x14a
  124de0: f9408508     	ldr	x8, [x8, #0x108]
  124de4: aa1303e0     	mov	x0, x19
  124de8: aa1503e3     	mov	x3, x21
  124dec: d63f0100     	blr	x8
  124df0: f9006f60     	str	x0, [x27, #0xd8]

## 0x124e04
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124df8: f9467b81     	ldr	x1, [x28, #0xcf0]
  124dfc: d00023e2     	adrp	x2, 0x5a2000
  124e00: d00023e3     	adrp	x3, 0x5a2000
  124e04: f9408508     	ldr	x8, [x8, #0x108]
  124e08: 91054442     	add	x2, x2, #0x151
  124e0c: 91057063     	add	x3, x3, #0x15c
  124e10: aa1303e0     	mov	x0, x19
  124e14: d63f0100     	blr	x8

## 0x124e2c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124e20: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e24: d00023e2     	adrp	x2, 0x5a2000
  124e28: b00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  124e2c: f9408508     	ldr	x8, [x8, #0x108]
  124e30: 91058042     	add	x2, x2, #0x160
  124e34: 91152c63     	add	x3, x3, #0x54b
  124e38: aa1303e0     	mov	x0, x19
  124e3c: d63f0100     	blr	x8

## 0x124e54
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124e48: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e4c: d00023e2     	adrp	x2, 0x5a2000
  124e50: 9105a042     	add	x2, x2, #0x168
  124e54: f9408508     	ldr	x8, [x8, #0x108]
  124e58: aa1303e0     	mov	x0, x19
  124e5c: aa1403e3     	mov	x3, x20
  124e60: d63f0100     	blr	x8
  124e64: f9007b60     	str	x0, [x27, #0xf0]

## 0x124e78
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124e6c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e70: d00023e2     	adrp	x2, 0x5a2000
  124e74: 9105d842     	add	x2, x2, #0x176
  124e78: f9408508     	ldr	x8, [x8, #0x108]
  124e7c: aa1303e0     	mov	x0, x19
  124e80: aa1403e3     	mov	x3, x20
  124e84: d63f0100     	blr	x8
  124e88: f9007f60     	str	x0, [x27, #0xf8]

## 0x124e9c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124e90: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e94: d00023e2     	adrp	x2, 0x5a2000
  124e98: 91060c42     	add	x2, x2, #0x183
  124e9c: f9408508     	ldr	x8, [x8, #0x108]
  124ea0: aa1303e0     	mov	x0, x19
  124ea4: aa1403e3     	mov	x3, x20
  124ea8: d63f0100     	blr	x8
  124eac: f9008360     	str	x0, [x27, #0x100]

## 0x124ec0
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124eb4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124eb8: d00023e2     	adrp	x2, 0x5a2000
  124ebc: 91062c42     	add	x2, x2, #0x18b
  124ec0: f9408508     	ldr	x8, [x8, #0x108]
  124ec4: aa1303e0     	mov	x0, x19
  124ec8: aa1403e3     	mov	x3, x20
  124ecc: d63f0100     	blr	x8
  124ed0: f9008760     	str	x0, [x27, #0x108]

## 0x124ee4
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124ed8: f9467b81     	ldr	x1, [x28, #0xcf0]
  124edc: d00023e2     	adrp	x2, 0x5a2000
  124ee0: 91066042     	add	x2, x2, #0x198
  124ee4: f9408508     	ldr	x8, [x8, #0x108]
  124ee8: aa1303e0     	mov	x0, x19
  124eec: aa1403e3     	mov	x3, x20
  124ef0: d63f0100     	blr	x8
  124ef4: f9008b60     	str	x0, [x27, #0x110]

## 0x124f08
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124efc: f9467b81     	ldr	x1, [x28, #0xcf0]
  124f00: d00023e2     	adrp	x2, 0x5a2000
  124f04: 91069c42     	add	x2, x2, #0x1a7
  124f08: f9408508     	ldr	x8, [x8, #0x108]
  124f0c: aa1303e0     	mov	x0, x19
  124f10: aa1503e3     	mov	x3, x21
  124f14: d63f0100     	blr	x8
  124f18: f00023c2     	adrp	x2, 0x59f000

## 0x124f5c
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124f50: f00023c2     	adrp	x2, 0x59f000
  124f54: aa0003e1     	mov	x1, x0
  124f58: 9109c442     	add	x2, x2, #0x271
  124f5c: f9408508     	ldr	x8, [x8, #0x108]
  124f60: aa1303e0     	mov	x0, x19
  124f64: aa1503e3     	mov	x3, x21
  124f68: d63f0100     	blr	x8
  124f6c: f9009360     	str	x0, [x27, #0x120]

## 0x124f80
Classification: JNI_LIKELY
Function: 0000000000124910 <_ZN15JavaVodPlayInfo4initEP7_JNIEnv>:
ASM:
  124f74: f9467e81     	ldr	x1, [x20, #0xcf8]
  124f78: d00023c2     	adrp	x2, 0x59e000
  124f7c: f00023c3     	adrp	x3, 0x59f000
  124f80: f9408508     	ldr	x8, [x8, #0x108]
  124f84: 913b1842     	add	x2, x2, #0xec6
  124f88: 91189463     	add	x3, x3, #0x625
  124f8c: aa1303e0     	mov	x0, x19
  124f90: d63f0100     	blr	x8

## 0x1278d8
Classification: JNI_LIKELY
Function: 00000000001266ec <_ZN15JavaVodPlayInfo9convertToEP7_JNIEnvRK11VodPlayInfo>:
ASM:
  1278cc: d00023a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1278d0: d00023a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1278d4: aa0003e1     	mov	x1, x0
  1278d8: f9408508     	ldr	x8, [x8, #0x108]
  1278dc: 91141042     	add	x2, x2, #0x504
  1278e0: 91142c63     	add	x3, x3, #0x50b
  1278e4: aa1303e0     	mov	x0, x19
  1278e8: d63f0100     	blr	x8

## 0x127ea4
Classification: JNI_LIKELY
Function: 0000000000127bac <_ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_>:
ASM:
  127e98: d00023a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  127e9c: d00023a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  127ea0: aa0003e1     	mov	x1, x0
  127ea4: f9408508     	ldr	x8, [x8, #0x108]
  127ea8: 91141042     	add	x2, x2, #0x504
  127eac: 91142c63     	add	x3, x3, #0x50b
  127eb0: aa1303e0     	mov	x0, x19
  127eb4: d63f0100     	blr	x8

## 0x128fac
Classification: JNI_LIKELY
Function: 0000000000127bac <_ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_>:
ASM:
  128fa0: f94762c1     	ldr	x1, [x22, #0xec0]
  128fa4: d00023c2     	adrp	x2, 0x5a2000
  128fa8: 91198042     	add	x2, x2, #0x660
  128fac: f9408508     	ldr	x8, [x8, #0x108]
  128fb0: aa1303e0     	mov	x0, x19
  128fb4: aa1403e3     	mov	x3, x20
  128fb8: d63f0100     	blr	x8
  128fbc: 900030c8     	adrp	x8, 0x740000

## 0x128fd4
Classification: JNI_LIKELY
Function: 0000000000127bac <_ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_>:
ASM:
  128fc8: f94762c1     	ldr	x1, [x22, #0xec0]
  128fcc: d00023c2     	adrp	x2, 0x5a2000
  128fd0: d00023c3     	adrp	x3, 0x5a2000
  128fd4: f9408508     	ldr	x8, [x8, #0x108]
  128fd8: 9119d442     	add	x2, x2, #0x675
  128fdc: 911a1863     	add	x3, x3, #0x686
  128fe0: aa1303e0     	mov	x0, x19
  128fe4: d63f0100     	blr	x8

## 0x129000
Classification: JNI_LIKELY
Function: 0000000000127bac <_ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_>:
ASM:
  128ff4: f94762c1     	ldr	x1, [x22, #0xec0]
  128ff8: d00023c2     	adrp	x2, 0x5a2000
  128ffc: 900023c3     	adrp	x3, 0x5a0000
  129000: f9408508     	ldr	x8, [x8, #0x108]
  129004: 911ab042     	add	x2, x2, #0x6ac
  129008: 911ab063     	add	x3, x3, #0x6ac
  12900c: aa1303e0     	mov	x0, x19
  129010: d63f0100     	blr	x8

## 0x12cf14
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12cf08: b0002382     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  12cf0c: b0002383     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12cf10: aa0003e1     	mov	x1, x0
  12cf14: f9408508     	ldr	x8, [x8, #0x108]
  12cf18: 91141042     	add	x2, x2, #0x504
  12cf1c: 91142c63     	add	x3, x3, #0x50b
  12cf20: aa1303e0     	mov	x0, x19
  12cf24: d63f0100     	blr	x8

## 0x12cf6c
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12cf60: f940baa1     	ldr	x1, [x21, #0x170]
  12cf64: d00023a2     	adrp	x2, 0x5a2000
  12cf68: d00023a3     	adrp	x3, 0x5a2000
  12cf6c: f9408508     	ldr	x8, [x8, #0x108]
  12cf70: 91344042     	add	x2, x2, #0xd10
  12cf74: 91345c63     	add	x3, x3, #0xd17
  12cf78: aa1303e0     	mov	x0, x19
  12cf7c: d63f0100     	blr	x8

## 0x12cf94
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12cf88: f940baa1     	ldr	x1, [x21, #0x170]
  12cf8c: d00023a2     	adrp	x2, 0x5a2000
  12cf90: b0002383     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12cf94: f9408508     	ldr	x8, [x8, #0x108]
  12cf98: 91350c42     	add	x2, x2, #0xd43
  12cf9c: 91158463     	add	x3, x3, #0x561
  12cfa0: aa1303e0     	mov	x0, x19
  12cfa4: d63f0100     	blr	x8

## 0x12cfbc
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12cfb0: f940baa1     	ldr	x1, [x21, #0x170]
  12cfb4: d00023a2     	adrp	x2, 0x5a2000
  12cfb8: d00023a3     	adrp	x3, 0x5a2000
  12cfbc: f9408508     	ldr	x8, [x8, #0x108]
  12cfc0: 91353042     	add	x2, x2, #0xd4c
  12cfc4: 91355463     	add	x3, x3, #0xd55
  12cfc8: aa1303e0     	mov	x0, x19
  12cfcc: d63f0100     	blr	x8

## 0x12cfe4
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12cfd8: f940baa1     	ldr	x1, [x21, #0x170]
  12cfdc: d00023a2     	adrp	x2, 0x5a2000
  12cfe0: d0002383     	adrp	x3, 0x59e000
  12cfe4: f9408508     	ldr	x8, [x8, #0x108]
  12cfe8: 9135b042     	add	x2, x2, #0xd6c
  12cfec: 91305863     	add	x3, x3, #0xc16
  12cff0: aa1303e0     	mov	x0, x19
  12cff4: d63f0100     	blr	x8

## 0x12d00c
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d000: f940baa1     	ldr	x1, [x21, #0x170]
  12d004: b00023a2     	adrp	x2, 0x5a2000
  12d008: 900023a3     	adrp	x3, 0x5a1000
  12d00c: f9408508     	ldr	x8, [x8, #0x108]
  12d010: 9135d442     	add	x2, x2, #0xd75
  12d014: 91293863     	add	x3, x3, #0xa4e
  12d018: aa1303e0     	mov	x0, x19
  12d01c: d63f0100     	blr	x8

## 0x12d034
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d028: f940baa1     	ldr	x1, [x21, #0x170]
  12d02c: b00023a2     	adrp	x2, 0x5a2000
  12d030: b0002383     	adrp	x3, 0x59e000
  12d034: f9408508     	ldr	x8, [x8, #0x108]
  12d038: 9135f842     	add	x2, x2, #0xd7e
  12d03c: 911bbc63     	add	x3, x3, #0x6ef
  12d040: aa1303e0     	mov	x0, x19
  12d044: d63f0100     	blr	x8

## 0x12d05c
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d050: f940baa1     	ldr	x1, [x21, #0x170]
  12d054: b00023a2     	adrp	x2, 0x5a2000
  12d058: b00023a3     	adrp	x3, 0x5a2000
  12d05c: f9408508     	ldr	x8, [x8, #0x108]
  12d060: 91361c42     	add	x2, x2, #0xd87
  12d064: 91364463     	add	x3, x3, #0xd91
  12d068: aa1303e0     	mov	x0, x19
  12d06c: d63f0100     	blr	x8

## 0x12d084
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d078: f940baa1     	ldr	x1, [x21, #0x170]
  12d07c: b00023a2     	adrp	x2, 0x5a2000
  12d080: b00023a3     	adrp	x3, 0x5a2000
  12d084: f9408508     	ldr	x8, [x8, #0x108]
  12d088: 9136a042     	add	x2, x2, #0xda8
  12d08c: 9136c863     	add	x3, x3, #0xdb2
  12d090: aa1303e0     	mov	x0, x19
  12d094: d63f0100     	blr	x8

## 0x12d0ac
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d0a0: f940baa1     	ldr	x1, [x21, #0x170]
  12d0a4: b00023a2     	adrp	x2, 0x5a2000
  12d0a8: b00023a3     	adrp	x3, 0x5a2000
  12d0ac: f9408508     	ldr	x8, [x8, #0x108]
  12d0b0: 91372442     	add	x2, x2, #0xdc9
  12d0b4: 91374c63     	add	x3, x3, #0xdd3
  12d0b8: aa1303e0     	mov	x0, x19
  12d0bc: d63f0100     	blr	x8

## 0x12d0d4
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d0c8: f940baa1     	ldr	x1, [x21, #0x170]
  12d0cc: b00023a2     	adrp	x2, 0x5a2000
  12d0d0: b00023a3     	adrp	x3, 0x5a2000
  12d0d4: f9408508     	ldr	x8, [x8, #0x108]
  12d0d8: 9137a842     	add	x2, x2, #0xdea
  12d0dc: 9137d063     	add	x3, x3, #0xdf4
  12d0e0: aa1303e0     	mov	x0, x19
  12d0e4: d63f0100     	blr	x8

## 0x12d0fc
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d0f0: f940baa1     	ldr	x1, [x21, #0x170]
  12d0f4: b00023a2     	adrp	x2, 0x5a2000
  12d0f8: b00023a3     	adrp	x3, 0x5a2000
  12d0fc: f9408508     	ldr	x8, [x8, #0x108]
  12d100: 91383042     	add	x2, x2, #0xe0c
  12d104: 91385863     	add	x3, x3, #0xe16
  12d108: aa1303e0     	mov	x0, x19
  12d10c: d63f0100     	blr	x8

## 0x12d124
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d118: f940baa1     	ldr	x1, [x21, #0x170]
  12d11c: b00023a2     	adrp	x2, 0x5a2000
  12d120: b00023a3     	adrp	x3, 0x5a2000
  12d124: f9408508     	ldr	x8, [x8, #0x108]
  12d128: 9138b442     	add	x2, x2, #0xe2d
  12d12c: 9138d863     	add	x3, x3, #0xe36
  12d130: aa1303e0     	mov	x0, x19
  12d134: d63f0100     	blr	x8

## 0x12d14c
Classification: JNI_LIKELY
Function: 000000000012c2f4 <_ZN6Cicada18MediaPreloadConfigaSEOS0_>:
ASM:
  12d140: f940baa1     	ldr	x1, [x21, #0x170]
  12d144: b00023a2     	adrp	x2, 0x5a2000
  12d148: b00023a3     	adrp	x3, 0x5a2000
  12d14c: f9408508     	ldr	x8, [x8, #0x108]
  12d150: 91397842     	add	x2, x2, #0xe5e
  12d154: 9139a063     	add	x3, x3, #0xe68
  12d158: aa1303e0     	mov	x0, x19
  12d15c: d63f0100     	blr	x8

## 0x143c90
Classification: UNRESOLVED
Function: 000000000013ee20 <_ZN17AvaliablePlayInfoaSEOS_>:
ASM:
  143c84: f9400008     	ldr	x8, [x0]
  143c88: 910fcc63     	add	x3, x3, #0x3f3
  143c8c: aa1403e1     	mov	x1, x20
  143c90: f9408508     	ldr	x8, [x8, #0x108]
  143c94: d63f0100     	blr	x8
  143c98: aa0003e2     	mov	x2, x0
  143c9c: b4000f00     	cbz	x0, 0x143e7c <_ZN17AvaliablePlayInfoaSEOS_+0x505c>
  143ca0: f94037e0     	ldr	x0, [sp, #0x68]

## 0x195838
Classification: UNRESOLVED
Function: 000000000018dee0 <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE>:
ASM:
  19582c: f9400008     	ldr	x8, [x0]
  195830: 910fcc63     	add	x3, x3, #0x3f3
  195834: aa1403e1     	mov	x1, x20
  195838: f9408508     	ldr	x8, [x8, #0x108]
  19583c: d63f0100     	blr	x8
  195840: aa0003e2     	mov	x2, x0
  195844: b4000f00     	cbz	x0, 0x195a24 <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE+0x7b44>
  195848: f9403fe0     	ldr	x0, [sp, #0x78]

## 0x197e20
Classification: UNRESOLVED
Function: 000000000018dee0 <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE>:
ASM:
  197e14: 320003e2     	orr	w2, wzr, #0x1
  197e18: 2a1803e1     	mov	w1, w24
  197e1c: f9400008     	ldr	x8, [x0]
  197e20: f9408508     	ldr	x8, [x8, #0x108]
  197e24: d63f0100     	blr	x8
  197e28: f9405a60     	ldr	x0, [x19, #0xb0]
  197e2c: 2a1803e1     	mov	w1, w24
  197e30: f9400008     	ldr	x8, [x0]

## 0x19cba0
Classification: UNRESOLVED
Function: 00000000001994b4 <_ZN19MediaLoaderErrorMap11getErrorMsgEi>:
ASM:
  19cb94: f9400008     	ldr	x8, [x0]
  19cb98: 910fcc63     	add	x3, x3, #0x3f3
  19cb9c: aa1603e1     	mov	x1, x22
  19cba0: f9408508     	ldr	x8, [x8, #0x108]
  19cba4: d63f0100     	blr	x8
  19cba8: aa0003e2     	mov	x2, x0
  19cbac: b4000f00     	cbz	x0, 0x19cd8c <_ZN19MediaLoaderErrorMap11getErrorMsgEi+0x38d8>
  19cbb0: f85803a0     	ldur	x0, [x29, #-0x80]

## 0x1a3314
Classification: UNRESOLVED
Function: 00000000001a3104 <_ZN6Cicada30AnalyticsReporterForDownloaderC2Ev>:
ASM:
  1a3308: f9400008     	ldr	x8, [x0]
  1a330c: 910fcc63     	add	x3, x3, #0x3f3
  1a3310: aa1403e1     	mov	x1, x20
  1a3314: f9408508     	ldr	x8, [x8, #0x108]
  1a3318: d63f0100     	blr	x8
  1a331c: aa0003e2     	mov	x2, x0
  1a3320: b4000f00     	cbz	x0, 0x1a3500 <_ZN6Cicada30AnalyticsReporterForDownloaderC2Ev+0x3fc>
  1a3324: f94037e0     	ldr	x0, [sp, #0x68]

## 0x1cb8ac
Classification: UNRESOLVED
Function: 00000000001cb698 <_ZN10PopRequest15getPublicParamsERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE>:
ASM:
  1cb8a0: f9400008     	ldr	x8, [x0]
  1cb8a4: 910fcc63     	add	x3, x3, #0x3f3
  1cb8a8: aa1403e1     	mov	x1, x20
  1cb8ac: f9408508     	ldr	x8, [x8, #0x108]
  1cb8b0: d63f0100     	blr	x8
  1cb8b4: aa0003e2     	mov	x2, x0
  1cb8b8: b4000f00     	cbz	x0, 0x1cba98 <_ZN10PopRequest15getPublicParamsERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE+0x400>
  1cb8bc: f85883a0     	ldur	x0, [x29, #-0x78]

## 0x1ed658
Classification: UNRESOLVED
Function: 00000000001dd710 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv>:
ASM:
  1ed64c: b40000a0     	cbz	x0, 0x1ed660 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv+0xff50>
  1ed650: f9400008     	ldr	x8, [x0]
  1ed654: aa1303e1     	mov	x1, x19
  1ed658: f9408508     	ldr	x8, [x8, #0x108]
  1ed65c: d63f0100     	blr	x8
  1ed660: f94006d6     	ldr	x22, [x22, #0x8]
  1ed664: eb16029f     	cmp	x20, x22
  1ed668: 54ffff01     	b.ne	0x1ed648 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv+0xff38>

## 0x1f767c
Classification: UNRESOLVED
Function: 00000000001f4384 <_ZN6Cicada14globalSettings16getIpResolveTypeEv>:
ASM:
  1f7670: f9400008     	ldr	x8, [x0]
  1f7674: 910fcc63     	add	x3, x3, #0x3f3
  1f7678: aa1403e1     	mov	x1, x20
  1f767c: f9408508     	ldr	x8, [x8, #0x108]
  1f7680: d63f0100     	blr	x8
  1f7684: aa0003e2     	mov	x2, x0
  1f7688: b40021a0     	cbz	x0, 0x1f7abc <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x3738>
  1f768c: f85883a0     	ldur	x0, [x29, #-0x78]

## 0x1f95ac
Classification: UNRESOLVED
Function: 00000000001f4384 <_ZN6Cicada14globalSettings16getIpResolveTypeEv>:
ASM:
  1f95a0: f9400100     	ldr	x0, [x8]
  1f95a4: b4000120     	cbz	x0, 0x1f95c8 <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x5244>
  1f95a8: f9400008     	ldr	x8, [x0]
  1f95ac: f9408508     	ldr	x8, [x8, #0x108]
  1f95b0: d63f0100     	blr	x8
  1f95b4: f9401668     	ldr	x8, [x19, #0x28]
  1f95b8: f94007e9     	ldr	x9, [sp, #0x8]
  1f95bc: eb09011f     	cmp	x8, x9

## 0x20a9fc
Classification: JNI_LIKELY
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  20a9f0: 12800001     	mov	w1, #-0x1               // =-1
  20a9f4: 910083e2     	add	x2, sp, #0x20
  20a9f8: 910023e3     	add	x3, sp, #0x8
  20a9fc: f9408508     	ldr	x8, [x8, #0x108]
  20aa00: aa1303e0     	mov	x0, x19
  20aa04: d63f0100     	blr	x8
  20aa08: aa0003f5     	mov	x21, x0
  20aa0c: 910023e0     	add	x0, sp, #0x8

## 0x20aa84
Classification: PROVEN_CXX_OBJECT
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  20aa78: 12800001     	mov	w1, #-0x1               // =-1
  20aa7c: 910083e2     	add	x2, sp, #0x20
  20aa80: aa1303e0     	mov	x0, x19
  20aa84: f9408508     	ldr	x8, [x8, #0x108]
  20aa88: aa1503e3     	mov	x3, x21
  20aa8c: d63f0100     	blr	x8
  20aa90: aa0003f5     	mov	x21, x0
  20aa94: 910083e0     	add	x0, sp, #0x20

## 0x2106d4
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  2106c8: 12800001     	mov	w1, #-0x1               // =-1
  2106cc: d10383a2     	sub	x2, x29, #0xe0
  2106d0: d10403a3     	sub	x3, x29, #0x100
  2106d4: f9408508     	ldr	x8, [x8, #0x108]
  2106d8: aa1c03e0     	mov	x0, x28
  2106dc: d63f0100     	blr	x8
  2106e0: aa0003e3     	mov	x3, x0
  2106e4: 52800122     	mov	w2, #0x9                // =9

## 0x210760
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  210754: 12800001     	mov	w1, #-0x1               // =-1
  210758: d10383a2     	sub	x2, x29, #0xe0
  21075c: d10403a3     	sub	x3, x29, #0x100
  210760: f9408508     	ldr	x8, [x8, #0x108]
  210764: aa1c03e0     	mov	x0, x28
  210768: d63f0100     	blr	x8
  21076c: aa0003e3     	mov	x3, x0
  210770: 52800142     	mov	w2, #0xa                // =10

## 0x2150b8
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  2150ac: 12800001     	mov	w1, #-0x1               // =-1
  2150b0: 910083e2     	add	x2, sp, #0x20
  2150b4: 910023e3     	add	x3, sp, #0x8
  2150b8: f9408508     	ldr	x8, [x8, #0x108]
  2150bc: aa1503e0     	mov	x0, x21
  2150c0: d63f0100     	blr	x8
  2150c4: aa0003f5     	mov	x21, x0
  2150c8: 910023e0     	add	x0, sp, #0x8

## 0x215130
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  215124: 12800001     	mov	w1, #-0x1               // =-1
  215128: 910083e2     	add	x2, sp, #0x20
  21512c: 910023e3     	add	x3, sp, #0x8
  215130: f9408508     	ldr	x8, [x8, #0x108]
  215134: aa1703e0     	mov	x0, x23
  215138: d63f0100     	blr	x8
  21513c: aa0003f7     	mov	x23, x0
  215140: 910023e0     	add	x0, sp, #0x8

## 0x2151a8
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  21519c: 12800001     	mov	w1, #-0x1               // =-1
  2151a0: 910083e2     	add	x2, sp, #0x20
  2151a4: 910023e3     	add	x3, sp, #0x8
  2151a8: f9408508     	ldr	x8, [x8, #0x108]
  2151ac: aa1803e0     	mov	x0, x24
  2151b0: d63f0100     	blr	x8
  2151b4: aa0003f8     	mov	x24, x0
  2151b8: 910023e0     	add	x0, sp, #0x8

## 0x215220
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  215214: 12800001     	mov	w1, #-0x1               // =-1
  215218: 910083e2     	add	x2, sp, #0x20
  21521c: 910023e3     	add	x3, sp, #0x8
  215220: f9408508     	ldr	x8, [x8, #0x108]
  215224: aa1903e0     	mov	x0, x25
  215228: d63f0100     	blr	x8
  21522c: aa0003f6     	mov	x22, x0
  215230: 910023e0     	add	x0, sp, #0x8

## 0x21bbd0
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  21bbc4: b9422661     	ldr	w1, [x19, #0x224]
  21bbc8: 3948c262     	ldrb	w2, [x19, #0x230]
  21bbcc: f9400008     	ldr	x8, [x0]
  21bbd0: f9408508     	ldr	x8, [x8, #0x108]
  21bbd4: d63f0100     	blr	x8
  21bbd8: 3961ca68     	ldrb	w8, [x19, #0x872]
  21bbdc: 34000108     	cbz	w8, 0x21bbfc <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f10>
  21bbe0: b0001c41     	adrp	x1, 0x5a4000

## 0x21bc30
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  21bc24: f9400008     	ldr	x8, [x0]
  21bc28: 12001c21     	and	w1, w1, #0xff
  21bc2c: 2a1f03e2     	mov	w2, wzr
  21bc30: f9408508     	ldr	x8, [x8, #0x108]
  21bc34: d63f0100     	blr	x8
  21bc38: f9403660     	ldr	x0, [x19, #0x68]
  21bc3c: 39486261     	ldrb	w1, [x19, #0x218]
  21bc40: 1400000f     	b	0x21bc7c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f90>

## 0x21bc6c
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  21bc60: 1400002e     	b	0x21bd18 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x1802c>
  21bc64: f9400008     	ldr	x8, [x0]
  21bc68: 2a1f03e2     	mov	w2, wzr
  21bc6c: f9408508     	ldr	x8, [x8, #0x108]
  21bc70: d63f0100     	blr	x8
  21bc74: f9403660     	ldr	x0, [x19, #0x68]
  21bc78: b9421a61     	ldr	w1, [x19, #0x218]
  21bc7c: f9400008     	ldr	x8, [x0]

## 0x233b90
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  233b84: f100035f     	cmp	x26, #0x0
  233b88: 1a9f07e2     	cset	w2, ne
  233b8c: f9400008     	ldr	x8, [x0]
  233b90: f9408508     	ldr	x8, [x8, #0x108]
  233b94: d63f0100     	blr	x8
  233b98: f9400328     	ldr	x8, [x25]
  233b9c: b9421901     	ldr	w1, [x8, #0x218]
  233ba0: 37f80101     	tbnz	w1, #0x1f, 0x233bc0 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2fed4>

## 0x233bb4
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  233ba8: f100035f     	cmp	x26, #0x0
  233bac: 1a9f07e2     	cset	w2, ne
  233bb0: f9400008     	ldr	x8, [x0]
  233bb4: f9408508     	ldr	x8, [x8, #0x108]
  233bb8: d63f0100     	blr	x8
  233bbc: f9400328     	ldr	x8, [x25]
  233bc0: 320003e9     	orr	w9, wzr, #0x1
  233bc4: 3921d109     	strb	w9, [x8, #0x874]

## 0x233e6c
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  233e60: 2a1403e2     	mov	w2, w20
  233e64: f9403500     	ldr	x0, [x8, #0x68]
  233e68: f9400008     	ldr	x8, [x0]
  233e6c: f9408508     	ldr	x8, [x8, #0x108]
  233e70: d63f0100     	blr	x8
  233e74: 17ffff86     	b	0x233c8c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2ffa0>
  233e78: b240fbe9     	orr	x9, xzr, #0x7fffffffffffffff
  233e7c: f901c909     	str	x9, [x8, #0x390]

## 0x2341c4
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  2341b8: 1a9f07e2     	cset	w2, ne
  2341bc: 2a1303e1     	mov	w1, w19
  2341c0: f9400008     	ldr	x8, [x0]
  2341c4: f9408508     	ldr	x8, [x8, #0x108]
  2341c8: d63f0100     	blr	x8
  2341cc: f9400328     	ldr	x8, [x25]
  2341d0: 2a1303e1     	mov	w1, w19
  2341d4: f9403500     	ldr	x0, [x8, #0x68]

## 0x2345ac
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  2345a0: 2a1f03e2     	mov	w2, wzr
  2345a4: f9403500     	ldr	x0, [x8, #0x68]
  2345a8: f9400008     	ldr	x8, [x0]
  2345ac: f9408508     	ldr	x8, [x8, #0x108]
  2345b0: d63f0100     	blr	x8
  2345b4: f9400668     	ldr	x8, [x19, #0x8]
  2345b8: 12000282     	and	w2, w20, #0x1
  2345bc: 2a1603e1     	mov	w1, w22

## 0x2345c8
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  2345bc: 2a1603e1     	mov	w1, w22
  2345c0: f9403500     	ldr	x0, [x8, #0x68]
  2345c4: f9400008     	ldr	x8, [x0]
  2345c8: f9408508     	ldr	x8, [x8, #0x108]
  2345cc: d63f0100     	blr	x8
  2345d0: f9400668     	ldr	x8, [x19, #0x8]
  2345d4: 2a1503e1     	mov	w1, w21
  2345d8: 2a1603e2     	mov	w2, w22

## 0x239f94
Classification: UNRESOLVED
Function: 0000000000203cec <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE>:
ASM:
  239f88: 12000262     	and	w2, w19, #0x1
  239f8c: aa1503e0     	mov	x0, x21
  239f90: 2a1403e1     	mov	w1, w20
  239f94: f9408508     	ldr	x8, [x8, #0x108]
  239f98: d63f0100     	blr	x8
  239f9c: f94016e8     	ldr	x8, [x23, #0x28]
  239fa0: f9400fe9     	ldr	x9, [sp, #0x18]
  239fa4: eb09011f     	cmp	x8, x9

## 0x241330
Classification: UNRESOLVED
Function: 00000000002412bc <_ZN6Cicada15demuxer_service16GetPropertyInt64EiRKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEES9_>:
ASM:
  241324: 2a1503e1     	mov	w1, w21
  241328: aa1403e2     	mov	x2, x20
  24132c: aa1303e3     	mov	x3, x19
  241330: f9408508     	ldr	x8, [x8, #0x108]
  241334: d63f0100     	blr	x8
  241338: f94016e8     	ldr	x8, [x23, #0x28]
  24133c: f94007e9     	ldr	x9, [sp, #0x8]
  241340: eb09011f     	cmp	x8, x9

## 0x250288
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  25027c: 12001ed9     	and	w25, w22, #0xff
  250280: b4000200     	cbz	x0, 0x2502c0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x5fcc>
  250284: f9400008     	ldr	x8, [x0]
  250288: f9408508     	ldr	x8, [x8, #0x108]
  25028c: d63f0100     	blr	x8
  250290: 6b19001f     	cmp	w0, w25
  250294: 54000661     	b.ne	0x250360 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x606c>
  250298: 320007e8     	orr	w8, wzr, #0x3

## 0x250510
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  250504: f94002e8     	ldr	x8, [x23]
  250508: f9400100     	ldr	x0, [x8]
  25050c: f9400008     	ldr	x8, [x0]
  250510: f9408508     	ldr	x8, [x8, #0x108]
  250514: d63f0100     	blr	x8
  250518: b0001b41     	adrp	x1, 0x5b9000
  25051c: 2a0003e3     	mov	w3, w0
  250520: 321c07e0     	orr	w0, wzr, #0x30

## 0x250734
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  250728: f9400b08     	ldr	x8, [x24, #0x10]
  25072c: f9400100     	ldr	x0, [x8]
  250730: f9400008     	ldr	x8, [x0]
  250734: f9408508     	ldr	x8, [x8, #0x108]
  250738: d63f0100     	blr	x8
  25073c: f94002e8     	ldr	x8, [x23]
  250740: b9401509     	ldr	w9, [x8, #0x14]
  250744: 6b09001f     	cmp	w0, w9

## 0x250798
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  25078c: f94002e8     	ldr	x8, [x23]
  250790: f9400100     	ldr	x0, [x8]
  250794: f9400008     	ldr	x8, [x0]
  250798: f9408508     	ldr	x8, [x8, #0x108]
  25079c: d63f0100     	blr	x8
  2507a0: f94002e8     	ldr	x8, [x23]
  2507a4: b0001b41     	adrp	x1, 0x5b9000
  2507a8: d0001b42     	adrp	x2, 0x5ba000

## 0x250bfc
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  250bf0: f9400ac8     	ldr	x8, [x22, #0x10]
  250bf4: f9400100     	ldr	x0, [x8]
  250bf8: f9400008     	ldr	x8, [x0]
  250bfc: f9408508     	ldr	x8, [x8, #0x108]
  250c00: d63f0100     	blr	x8
  250c04: 6b14001f     	cmp	w0, w20
  250c08: 540000c0     	b.eq	0x250c20 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x692c>
  250c0c: f94006d6     	ldr	x22, [x22, #0x8]

## 0x250ef8
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  250eec: f9400b08     	ldr	x8, [x24, #0x10]
  250ef0: f9400100     	ldr	x0, [x8]
  250ef4: f9400008     	ldr	x8, [x0]
  250ef8: f9408508     	ldr	x8, [x8, #0x108]
  250efc: d63f0100     	blr	x8
  250f00: 6b15001f     	cmp	w0, w21
  250f04: 91002308     	add	x8, x24, #0x8
  250f08: 54fffec1     	b.ne	0x250ee0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6bec>

## 0x251124
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251118: f9400ac8     	ldr	x8, [x22, #0x10]
  25111c: f9400100     	ldr	x0, [x8]
  251120: f9400008     	ldr	x8, [x0]
  251124: f9408508     	ldr	x8, [x8, #0x108]
  251128: d63f0100     	blr	x8
  25112c: 6b13001f     	cmp	w0, w19
  251130: 910022c8     	add	x8, x22, #0x8
  251134: 54fffec1     	b.ne	0x25110c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6e18>

## 0x251204
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  2511f8: f9400a88     	ldr	x8, [x20, #0x10]
  2511fc: f9400100     	ldr	x0, [x8]
  251200: f9400008     	ldr	x8, [x0]
  251204: f9408508     	ldr	x8, [x8, #0x108]
  251208: d63f0100     	blr	x8
  25120c: 6b13001f     	cmp	w0, w19
  251210: 91002288     	add	x8, x20, #0x8
  251214: 54fffec1     	b.ne	0x2511ec <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6ef8>

## 0x251324
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251318: f9400aa8     	ldr	x8, [x21, #0x10]
  25131c: f9400100     	ldr	x0, [x8]
  251320: f9400008     	ldr	x8, [x0]
  251324: f9408508     	ldr	x8, [x8, #0x108]
  251328: d63f0100     	blr	x8
  25132c: 6b14001f     	cmp	w0, w20
  251330: 910022a8     	add	x8, x21, #0x8
  251334: 54fffec1     	b.ne	0x25130c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7018>

## 0x251548
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  25153c: 34000289     	cbz	w9, 0x25158c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7298>
  251540: f9400100     	ldr	x0, [x8]
  251544: f9400008     	ldr	x8, [x0]
  251548: f9408508     	ldr	x8, [x8, #0x108]
  25154c: d63f0100     	blr	x8
  251550: f94002a8     	ldr	x8, [x21]
  251554: 2a0003e1     	mov	w1, w0
  251558: aa1503e0     	mov	x0, x21

## 0x2515ac
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  2515a0: f9400b08     	ldr	x8, [x24, #0x10]
  2515a4: f9400100     	ldr	x0, [x8]
  2515a8: f9400008     	ldr	x8, [x0]
  2515ac: f9408508     	ldr	x8, [x8, #0x108]
  2515b0: d63f0100     	blr	x8
  2515b4: 6b16001f     	cmp	w0, w22
  2515b8: 54000400     	b.eq	0x251638 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7344>
  2515bc: f9400718     	ldr	x24, [x24, #0x8]

## 0x251744
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251738: f9400b68     	ldr	x8, [x27, #0x10]
  25173c: f9400100     	ldr	x0, [x8]
  251740: f9400008     	ldr	x8, [x0]
  251744: f9408508     	ldr	x8, [x8, #0x108]
  251748: d63f0100     	blr	x8
  25174c: 3100041f     	cmn	w0, #0x1
  251750: 54000220     	b.eq	0x251794 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x74a0>
  251754: 321c07e0     	orr	w0, wzr, #0x30

## 0x251810
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251804: 17ffffe5     	b	0x251798 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x74a4>
  251808: f9400100     	ldr	x0, [x8]
  25180c: f9400008     	ldr	x8, [x0]
  251810: f9408508     	ldr	x8, [x8, #0x108]
  251814: d63f0100     	blr	x8
  251818: f94002a8     	ldr	x8, [x21]
  25181c: 2a0003e1     	mov	w1, w0
  251820: aa1503e0     	mov	x0, x21

## 0x25186c
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251860: f9400ae8     	ldr	x8, [x23, #0x10]
  251864: f9400100     	ldr	x0, [x8]
  251868: f9400008     	ldr	x8, [x0]
  25186c: f9408508     	ldr	x8, [x8, #0x108]
  251870: d63f0100     	blr	x8
  251874: 6b16001f     	cmp	w0, w22
  251878: 540000a0     	b.eq	0x25188c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7598>
  25187c: f94006f7     	ldr	x23, [x23, #0x8]

## 0x251910
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251904: f9400aa8     	ldr	x8, [x21, #0x10]
  251908: f9400100     	ldr	x0, [x8]
  25190c: f9400008     	ldr	x8, [x0]
  251910: f9408508     	ldr	x8, [x8, #0x108]
  251914: d63f0100     	blr	x8
  251918: 6b14001f     	cmp	w0, w20
  25191c: 910022a8     	add	x8, x21, #0x8
  251920: 54fffec1     	b.ne	0x2518f8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7604>

## 0x2519c0
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  2519b4: f9400ac8     	ldr	x8, [x22, #0x10]
  2519b8: f9400100     	ldr	x0, [x8]
  2519bc: f9400008     	ldr	x8, [x0]
  2519c0: f9408508     	ldr	x8, [x8, #0x108]
  2519c4: d63f0100     	blr	x8
  2519c8: 6b13001f     	cmp	w0, w19
  2519cc: 910022c8     	add	x8, x22, #0x8
  2519d0: 54fffec1     	b.ne	0x2519a8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x76b4>

## 0x251aec
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251ae0: f9400ac8     	ldr	x8, [x22, #0x10]
  251ae4: f9400100     	ldr	x0, [x8]
  251ae8: f9400008     	ldr	x8, [x0]
  251aec: f9408508     	ldr	x8, [x8, #0x108]
  251af0: d63f0100     	blr	x8
  251af4: 6b13001f     	cmp	w0, w19
  251af8: 910022c8     	add	x8, x22, #0x8
  251afc: 54fffec1     	b.ne	0x251ad4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x77e0>

## 0x251c80
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  251c74: f9400ac8     	ldr	x8, [x22, #0x10]
  251c78: f9400100     	ldr	x0, [x8]
  251c7c: f9400008     	ldr	x8, [x0]
  251c80: f9408508     	ldr	x8, [x8, #0x108]
  251c84: d63f0100     	blr	x8
  251c88: 6b13001f     	cmp	w0, w19
  251c8c: 910022c8     	add	x8, x22, #0x8
  251c90: 54fffec1     	b.ne	0x251c68 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7974>

## 0x267bdc
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  267bd0: 12001ed9     	and	w25, w22, #0xff
  267bd4: b4000200     	cbz	x0, 0x267c14 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1d920>
  267bd8: f9400008     	ldr	x8, [x0]
  267bdc: f9408508     	ldr	x8, [x8, #0x108]
  267be0: d63f0100     	blr	x8
  267be4: 6b19001f     	cmp	w0, w25
  267be8: 54000661     	b.ne	0x267cb4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1d9c0>
  267bec: 320007e8     	orr	w8, wzr, #0x3

## 0x267e68
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  267e5c: f9400b88     	ldr	x8, [x28, #0x10]
  267e60: f9400100     	ldr	x0, [x8]
  267e64: f9400008     	ldr	x8, [x0]
  267e68: f9408508     	ldr	x8, [x8, #0x108]
  267e6c: d63f0100     	blr	x8
  267e70: 2a0003e3     	mov	w3, w0
  267e74: 321c07e0     	orr	w0, wzr, #0x30
  267e78: aa1703e1     	mov	x1, x23

## 0x268074
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268068: f9400ac8     	ldr	x8, [x22, #0x10]
  26806c: f9400100     	ldr	x0, [x8]
  268070: f9400008     	ldr	x8, [x0]
  268074: f9408508     	ldr	x8, [x8, #0x108]
  268078: d63f0100     	blr	x8
  26807c: b9416e68     	ldr	w8, [x19, #0x16c]
  268080: 6b08001f     	cmp	w0, w8
  268084: 1a9f17f7     	cset	w23, eq

## 0x268174
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268168: f9400aa8     	ldr	x8, [x21, #0x10]
  26816c: f9400100     	ldr	x0, [x8]
  268170: f9400008     	ldr	x8, [x0]
  268174: f9408508     	ldr	x8, [x8, #0x108]
  268178: d63f0100     	blr	x8
  26817c: f9400b88     	ldr	x8, [x28, #0x10]
  268180: b9401509     	ldr	w9, [x8, #0x14]
  268184: 6b09001f     	cmp	w0, w9

## 0x268314
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268308: f9400b88     	ldr	x8, [x28, #0x10]
  26830c: f9400100     	ldr	x0, [x8]
  268310: f9400008     	ldr	x8, [x0]
  268314: f9408508     	ldr	x8, [x8, #0x108]
  268318: d63f0100     	blr	x8
  26831c: f9400b88     	ldr	x8, [x28, #0x10]
  268320: f0001a81     	adrp	x1, 0x5bb000
  268324: d0001a82     	adrp	x2, 0x5ba000

## 0x268410
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268404: f9400ae8     	ldr	x8, [x23, #0x10]
  268408: f9400100     	ldr	x0, [x8]
  26840c: f9400008     	ldr	x8, [x0]
  268410: f9408508     	ldr	x8, [x8, #0x108]
  268414: d63f0100     	blr	x8
  268418: 6b14001f     	cmp	w0, w20
  26841c: 540000c0     	b.eq	0x268434 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e140>
  268420: f94006f7     	ldr	x23, [x23, #0x8]

## 0x268590
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268584: f9400b08     	ldr	x8, [x24, #0x10]
  268588: f9400100     	ldr	x0, [x8]
  26858c: f9400008     	ldr	x8, [x0]
  268590: f9408508     	ldr	x8, [x8, #0x108]
  268594: d63f0100     	blr	x8
  268598: 6b15001f     	cmp	w0, w21
  26859c: 91002308     	add	x8, x24, #0x8
  2685a0: 54fffec1     	b.ne	0x268578 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e284>

## 0x268648
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  26863c: f9400ac8     	ldr	x8, [x22, #0x10]
  268640: f9400100     	ldr	x0, [x8]
  268644: f9400008     	ldr	x8, [x0]
  268648: f9408508     	ldr	x8, [x8, #0x108]
  26864c: d63f0100     	blr	x8
  268650: 6b13001f     	cmp	w0, w19
  268654: 910022c8     	add	x8, x22, #0x8
  268658: 54fffec1     	b.ne	0x268630 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e33c>

## 0x268718
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  26870c: f9400ac8     	ldr	x8, [x22, #0x10]
  268710: f9400100     	ldr	x0, [x8]
  268714: f9400008     	ldr	x8, [x0]
  268718: f9408508     	ldr	x8, [x8, #0x108]
  26871c: d63f0100     	blr	x8
  268720: 6b14001f     	cmp	w0, w20
  268724: 910022c8     	add	x8, x22, #0x8
  268728: 54fffec1     	b.ne	0x268700 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e40c>

## 0x268864
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268858: f9400aa8     	ldr	x8, [x21, #0x10]
  26885c: f9400100     	ldr	x0, [x8]
  268860: f9400008     	ldr	x8, [x0]
  268864: f9408508     	ldr	x8, [x8, #0x108]
  268868: d63f0100     	blr	x8
  26886c: 6b14001f     	cmp	w0, w20
  268870: 910022a8     	add	x8, x21, #0x8
  268874: 54fffec1     	b.ne	0x26884c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e558>

## 0x268a88
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268a7c: 34000289     	cbz	w9, 0x268acc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e7d8>
  268a80: f9400100     	ldr	x0, [x8]
  268a84: f9400008     	ldr	x8, [x0]
  268a88: f9408508     	ldr	x8, [x8, #0x108]
  268a8c: d63f0100     	blr	x8
  268a90: f94002a8     	ldr	x8, [x21]
  268a94: 2a0003e1     	mov	w1, w0
  268a98: aa1503e0     	mov	x0, x21

## 0x268aec
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268ae0: f9400b08     	ldr	x8, [x24, #0x10]
  268ae4: f9400100     	ldr	x0, [x8]
  268ae8: f9400008     	ldr	x8, [x0]
  268aec: f9408508     	ldr	x8, [x8, #0x108]
  268af0: d63f0100     	blr	x8
  268af4: 6b16001f     	cmp	w0, w22
  268af8: 54000400     	b.eq	0x268b78 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e884>
  268afc: f9400718     	ldr	x24, [x24, #0x8]

## 0x268c84
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268c78: f9400b68     	ldr	x8, [x27, #0x10]
  268c7c: f9400100     	ldr	x0, [x8]
  268c80: f9400008     	ldr	x8, [x0]
  268c84: f9408508     	ldr	x8, [x8, #0x108]
  268c88: d63f0100     	blr	x8
  268c8c: 3100041f     	cmn	w0, #0x1
  268c90: 54000220     	b.eq	0x268cd4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e9e0>
  268c94: 321c07e0     	orr	w0, wzr, #0x30

## 0x268d50
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268d44: 17ffffe5     	b	0x268cd8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e9e4>
  268d48: f9400100     	ldr	x0, [x8]
  268d4c: f9400008     	ldr	x8, [x0]
  268d50: f9408508     	ldr	x8, [x8, #0x108]
  268d54: d63f0100     	blr	x8
  268d58: f94002a8     	ldr	x8, [x21]
  268d5c: 2a0003e1     	mov	w1, w0
  268d60: aa1503e0     	mov	x0, x21

## 0x268dac
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268da0: f9400ae8     	ldr	x8, [x23, #0x10]
  268da4: f9400100     	ldr	x0, [x8]
  268da8: f9400008     	ldr	x8, [x0]
  268dac: f9408508     	ldr	x8, [x8, #0x108]
  268db0: d63f0100     	blr	x8
  268db4: 6b16001f     	cmp	w0, w22
  268db8: 540000a0     	b.eq	0x268dcc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ead8>
  268dbc: f94006f7     	ldr	x23, [x23, #0x8]

## 0x268e50
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268e44: f9400aa8     	ldr	x8, [x21, #0x10]
  268e48: f9400100     	ldr	x0, [x8]
  268e4c: f9400008     	ldr	x8, [x0]
  268e50: f9408508     	ldr	x8, [x8, #0x108]
  268e54: d63f0100     	blr	x8
  268e58: 6b14001f     	cmp	w0, w20
  268e5c: 910022a8     	add	x8, x21, #0x8
  268e60: 54fffec1     	b.ne	0x268e38 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1eb44>

## 0x268f00
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  268ef4: f9400ac8     	ldr	x8, [x22, #0x10]
  268ef8: f9400100     	ldr	x0, [x8]
  268efc: f9400008     	ldr	x8, [x0]
  268f00: f9408508     	ldr	x8, [x8, #0x108]
  268f04: d63f0100     	blr	x8
  268f08: 6b13001f     	cmp	w0, w19
  268f0c: 910022c8     	add	x8, x22, #0x8
  268f10: 54fffec1     	b.ne	0x268ee8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ebf4>

## 0x26902c
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  269020: f9400ac8     	ldr	x8, [x22, #0x10]
  269024: f9400100     	ldr	x0, [x8]
  269028: f9400008     	ldr	x8, [x0]
  26902c: f9408508     	ldr	x8, [x8, #0x108]
  269030: d63f0100     	blr	x8
  269034: 6b13001f     	cmp	w0, w19
  269038: 910022c8     	add	x8, x22, #0x8
  26903c: 54fffec1     	b.ne	0x269014 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ed20>

## 0x269140
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  269134: f9400ac8     	ldr	x8, [x22, #0x10]
  269138: f9400100     	ldr	x0, [x8]
  26913c: f9400008     	ldr	x8, [x0]
  269140: f9408508     	ldr	x8, [x8, #0x108]
  269144: d63f0100     	blr	x8
  269148: 6b13001f     	cmp	w0, w19
  26914c: 910022c8     	add	x8, x22, #0x8
  269150: 54fffec1     	b.ne	0x269128 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ee34>

## 0x269240
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  269234: f9400ac8     	ldr	x8, [x22, #0x10]
  269238: f9400100     	ldr	x0, [x8]
  26923c: f9400008     	ldr	x8, [x0]
  269240: f9408508     	ldr	x8, [x8, #0x108]
  269244: d63f0100     	blr	x8
  269248: 6b13001f     	cmp	w0, w19
  26924c: 910022c8     	add	x8, x22, #0x8
  269250: 54fffec1     	b.ne	0x269228 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ef34>

## 0x2693f0
Classification: UNRESOLVED
Function: 000000000024a2f4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_>:
ASM:
  2693e4: f9400ac8     	ldr	x8, [x22, #0x10]
  2693e8: f9400100     	ldr	x0, [x8]
  2693ec: f9400008     	ldr	x8, [x0]
  2693f0: f9408508     	ldr	x8, [x8, #0x108]
  2693f4: d63f0100     	blr	x8
  2693f8: b9416e68     	ldr	w8, [x19, #0x16c]
  2693fc: 6b08001f     	cmp	w0, w8
  269400: 540001c1     	b.ne	0x269438 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1f144>

## 0x275744
Classification: PROVEN_CXX_OBJECT
Function: 0000000000271d1c <_ZN6Cicada3hls10TagFactory15createTagByNameERKNSt6__ndk112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEESA_>:
ASM:
  275738: f9002ff4     	str	x20, [sp, #0x58]
  27573c: f9400268     	ldr	x8, [x19]
  275740: aa1303e0     	mov	x0, x19
  275744: f9408508     	ldr	x8, [x8, #0x108]
  275748: d63f0100     	blr	x8
  27574c: 510006a8     	sub	w8, w21, #0x1
  275750: 71000d1f     	cmp	w8, #0x3
  275754: b9006be0     	str	w0, [sp, #0x68]

## 0x27af18
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27af0c: f0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27af10: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af14: aa0003e1     	mov	x1, x0
  27af18: f9408508     	ldr	x8, [x8, #0x108]
  27af1c: 91141042     	add	x2, x2, #0x504
  27af20: 91142c63     	add	x3, x3, #0x50b
  27af24: aa1303e0     	mov	x0, x19
  27af28: d63f0100     	blr	x8

## 0x27af44
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27af38: f94132c1     	ldr	x1, [x22, #0x260]
  27af3c: d0001a02     	adrp	x2, 0x5bc000
  27af40: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af44: f9408508     	ldr	x8, [x8, #0x108]
  27af48: 9117d842     	add	x2, x2, #0x5f6
  27af4c: 9138e063     	add	x3, x3, #0xe38
  27af50: aa1303e0     	mov	x0, x19
  27af54: d63f0100     	blr	x8

## 0x27af70
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27af64: f94132c1     	ldr	x1, [x22, #0x260]
  27af68: d0001a02     	adrp	x2, 0x5bc000
  27af6c: d0001a03     	adrp	x3, 0x5bc000
  27af70: f9408508     	ldr	x8, [x8, #0x108]
  27af74: 91182c42     	add	x2, x2, #0x60b
  27af78: 91185863     	add	x3, x3, #0x616
  27af7c: aa1303e0     	mov	x0, x19
  27af80: d63f0100     	blr	x8

## 0x27af9c
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27af90: f94132c1     	ldr	x1, [x22, #0x260]
  27af94: d0001a02     	adrp	x2, 0x5bc000
  27af98: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af9c: f9408508     	ldr	x8, [x8, #0x108]
  27afa0: 9118b842     	add	x2, x2, #0x62e
  27afa4: 9139c463     	add	x3, x3, #0xe71
  27afa8: aa1303e0     	mov	x0, x19
  27afac: d63f0100     	blr	x8

## 0x27afc8
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27afbc: f94132c1     	ldr	x1, [x22, #0x260]
  27afc0: d0001a02     	adrp	x2, 0x5bc000
  27afc4: d0001a03     	adrp	x3, 0x5bc000
  27afc8: f9408508     	ldr	x8, [x8, #0x108]
  27afcc: 91191842     	add	x2, x2, #0x646
  27afd0: 91195463     	add	x3, x3, #0x655
  27afd4: aa1303e0     	mov	x0, x19
  27afd8: d63f0100     	blr	x8

## 0x27aff4
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27afe8: f94132c1     	ldr	x1, [x22, #0x260]
  27afec: d0001a02     	adrp	x2, 0x5bc000
  27aff0: d0001a03     	adrp	x3, 0x5bc000
  27aff4: f9408508     	ldr	x8, [x8, #0x108]
  27aff8: 911a0442     	add	x2, x2, #0x681
  27affc: 911a4063     	add	x3, x3, #0x690
  27b000: aa1303e0     	mov	x0, x19
  27b004: d63f0100     	blr	x8

## 0x27b050
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b044: f94132c1     	ldr	x1, [x22, #0x260]
  27b048: b00019e2     	adrp	x2, 0x5b8000
  27b04c: 91146042     	add	x2, x2, #0x518
  27b050: f9408508     	ldr	x8, [x8, #0x108]
  27b054: aa1303e0     	mov	x0, x19
  27b058: aa1403e3     	mov	x3, x20
  27b05c: d63f0100     	blr	x8
  27b060: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x27b078
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b06c: f94132c1     	ldr	x1, [x22, #0x260]
  27b070: b00019e2     	adrp	x2, 0x5b8000
  27b074: 9111a042     	add	x2, x2, #0x468
  27b078: f9408508     	ldr	x8, [x8, #0x108]
  27b07c: aa1303e0     	mov	x0, x19
  27b080: aa1403e3     	mov	x3, x20
  27b084: d63f0100     	blr	x8
  27b088: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x27b0a0
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b094: f94132c1     	ldr	x1, [x22, #0x260]
  27b098: d0001962     	adrp	x2, 0x5a9000
  27b09c: 91166042     	add	x2, x2, #0x598
  27b0a0: f9408508     	ldr	x8, [x8, #0x108]
  27b0a4: aa1303e0     	mov	x0, x19
  27b0a8: aa1403e3     	mov	x3, x20
  27b0ac: d63f0100     	blr	x8
  27b0b0: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x27b0c8
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b0bc: f94132c1     	ldr	x1, [x22, #0x260]
  27b0c0: b0001a02     	adrp	x2, 0x5bc000
  27b0c4: b0001a03     	adrp	x3, 0x5bc000
  27b0c8: f9408508     	ldr	x8, [x8, #0x108]
  27b0cc: 911aa442     	add	x2, x2, #0x6a9
  27b0d0: 911af463     	add	x3, x3, #0x6bd
  27b0d4: aa1303e0     	mov	x0, x19
  27b0d8: d63f0100     	blr	x8

## 0x27b124
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b118: f94132c1     	ldr	x1, [x22, #0x260]
  27b11c: b0001a02     	adrp	x2, 0x5bc000
  27b120: b0001a03     	adrp	x3, 0x5bc000
  27b124: f9408508     	ldr	x8, [x8, #0x108]
  27b128: 911b8042     	add	x2, x2, #0x6e0
  27b12c: 911bc463     	add	x3, x3, #0x6f1
  27b130: aa1303e0     	mov	x0, x19
  27b134: d63f0100     	blr	x8

## 0x27b150
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b144: f94132c1     	ldr	x1, [x22, #0x260]
  27b148: b0001a02     	adrp	x2, 0x5bc000
  27b14c: b0001a03     	adrp	x3, 0x5bc000
  27b150: f9408508     	ldr	x8, [x8, #0x108]
  27b154: 911be842     	add	x2, x2, #0x6fa
  27b158: 911c4463     	add	x3, x3, #0x711
  27b15c: aa1303e0     	mov	x0, x19
  27b160: d63f0100     	blr	x8

## 0x27b17c
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b170: f94132c1     	ldr	x1, [x22, #0x260]
  27b174: b0001a02     	adrp	x2, 0x5bc000
  27b178: 911cb042     	add	x2, x2, #0x72c
  27b17c: f9408508     	ldr	x8, [x8, #0x108]
  27b180: aa1303e0     	mov	x0, x19
  27b184: aa1403e3     	mov	x3, x20
  27b188: d63f0100     	blr	x8
  27b18c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x27b1d8
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b1cc: f94132c1     	ldr	x1, [x22, #0x260]
  27b1d0: b0001a02     	adrp	x2, 0x5bc000
  27b1d4: 911d6442     	add	x2, x2, #0x759
  27b1d8: f9408508     	ldr	x8, [x8, #0x108]
  27b1dc: aa1303e0     	mov	x0, x19
  27b1e0: aa1403e3     	mov	x3, x20
  27b1e4: d63f0100     	blr	x8
  27b1e8: f90006e0     	str	x0, [x23, #0x8]

## 0x27b1fc
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b1f0: f94132c1     	ldr	x1, [x22, #0x260]
  27b1f4: b0001a02     	adrp	x2, 0x5bc000
  27b1f8: f0001903     	adrp	x3, 0x59e000
  27b1fc: f9408508     	ldr	x8, [x8, #0x108]
  27b200: 911d9842     	add	x2, x2, #0x766
  27b204: 91389c63     	add	x3, x3, #0xe27
  27b208: aa1303e0     	mov	x0, x19
  27b20c: d63f0100     	blr	x8

## 0x27b228
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27b21c: f94132c1     	ldr	x1, [x22, #0x260]
  27b220: b0001a02     	adrp	x2, 0x5bc000
  27b224: f0001923     	adrp	x3, 0x5a2000
  27b228: f9408508     	ldr	x8, [x8, #0x108]
  27b22c: 911dd442     	add	x2, x2, #0x775
  27b230: 91192863     	add	x3, x3, #0x64a
  27b234: aa1303e0     	mov	x0, x19
  27b238: d63f0100     	blr	x8

## 0x27c860
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27c854: b0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27c858: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c85c: aa0003e1     	mov	x1, x0
  27c860: f9408508     	ldr	x8, [x8, #0x108]
  27c864: 91141042     	add	x2, x2, #0x504
  27c868: 91142c63     	add	x3, x3, #0x50b
  27c86c: aa1303e0     	mov	x0, x19
  27c870: d63f0100     	blr	x8

## 0x27c88c
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27c880: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c884: 90001a02     	adrp	x2, 0x5bc000
  27c888: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c88c: f9408508     	ldr	x8, [x8, #0x108]
  27c890: 9123fc42     	add	x2, x2, #0x8ff
  27c894: 91158463     	add	x3, x3, #0x561
  27c898: aa1303e0     	mov	x0, x19
  27c89c: d63f0100     	blr	x8

## 0x27c940
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27c934: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c938: 90001a02     	adrp	x2, 0x5bc000
  27c93c: 9124cc42     	add	x2, x2, #0x933
  27c940: f9408508     	ldr	x8, [x8, #0x108]
  27c944: aa1303e0     	mov	x0, x19
  27c948: aa1403e3     	mov	x3, x20
  27c94c: d63f0100     	blr	x8
  27c950: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x27c968
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27c95c: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c960: 90001a02     	adrp	x2, 0x5bc000
  27c964: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c968: f9408508     	ldr	x8, [x8, #0x108]
  27c96c: 9124e442     	add	x2, x2, #0x939
  27c970: 9138e063     	add	x3, x3, #0xe38
  27c974: aa1303e0     	mov	x0, x19
  27c978: d63f0100     	blr	x8

## 0x27c9d4
Classification: JNI_LIKELY
Function: 00000000002783f4 <_ZN18codecPluginManager13dummyFunctionEv>:
ASM:
  27c9c8: b0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27c9cc: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c9d0: aa0003e1     	mov	x1, x0
  27c9d4: f9408508     	ldr	x8, [x8, #0x108]
  27c9d8: 91141042     	add	x2, x2, #0x504
  27c9dc: 91142c63     	add	x3, x3, #0x50b
  27c9e0: aa1303e0     	mov	x0, x19
  27c9e4: d63f0100     	blr	x8

## 0x27ea90
Classification: UNRESOLVED
Function: 000000000027ea70 <_ZN13ActiveDecoder14updateMetaDataEPK11Stream_meta>:
ASM:
  27ea84: f9401668     	ldr	x8, [x19, #0x28]
  27ea88: f90007e8     	str	x8, [sp, #0x8]
  27ea8c: f9400008     	ldr	x8, [x0]
  27ea90: f9408508     	ldr	x8, [x8, #0x108]
  27ea94: d63f0100     	blr	x8
  27ea98: f9401668     	ldr	x8, [x19, #0x28]
  27ea9c: f94007e9     	ldr	x9, [sp, #0x8]
  27eaa0: eb09011f     	cmp	x8, x9

## 0x27fcf8
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27fcec: d00018e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27fcf0: b00019e3     	adrp	x3, 0x5bc000
  27fcf4: 91141042     	add	x2, x2, #0x504
  27fcf8: f9408508     	ldr	x8, [x8, #0x108]
  27fcfc: 91391063     	add	x3, x3, #0xe44
  27fd00: aa1403e0     	mov	x0, x20
  27fd04: aa1503e1     	mov	x1, x21
  27fd08: d63f0100     	blr	x8

## 0x27fe5c
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27fe50: b00019e2     	adrp	x2, 0x5bc000
  27fe54: b00019e3     	adrp	x3, 0x5bc000
  27fe58: 913a6842     	add	x2, x2, #0xe9a
  27fe5c: f9408508     	ldr	x8, [x8, #0x108]
  27fe60: 913aa863     	add	x3, x3, #0xeaa
  27fe64: aa1403e0     	mov	x0, x20
  27fe68: aa1503e1     	mov	x1, x21
  27fe6c: d63f0100     	blr	x8

## 0x27feb0
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27fea4: b0001962     	adrp	x2, 0x5ac000
  27fea8: 91239442     	add	x2, x2, #0x8e5
  27feac: aa1403e0     	mov	x0, x20
  27feb0: f9408508     	ldr	x8, [x8, #0x108]
  27feb4: aa1503e1     	mov	x1, x21
  27feb8: aa1603e3     	mov	x3, x22
  27febc: d63f0100     	blr	x8
  27fec0: f900a660     	str	x0, [x19, #0x148]

## 0x27fed4
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27fec8: b00019c2     	adrp	x2, 0x5b8000
  27fecc: 91146042     	add	x2, x2, #0x518
  27fed0: aa1403e0     	mov	x0, x20
  27fed4: f9408508     	ldr	x8, [x8, #0x108]
  27fed8: aa1503e1     	mov	x1, x21
  27fedc: aa1603e3     	mov	x3, x22
  27fee0: d63f0100     	blr	x8
  27fee4: f900aa60     	str	x0, [x19, #0x150]

## 0x27fef8
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27feec: b00019c2     	adrp	x2, 0x5b8000
  27fef0: 9111a042     	add	x2, x2, #0x468
  27fef4: aa1403e0     	mov	x0, x20
  27fef8: f9408508     	ldr	x8, [x8, #0x108]
  27fefc: aa1503e1     	mov	x1, x21
  27ff00: aa1603e3     	mov	x3, x22
  27ff04: d63f0100     	blr	x8
  27ff08: f900ae60     	str	x0, [x19, #0x158]

## 0x27ff48
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27ff3c: b00019e2     	adrp	x2, 0x5bc000
  27ff40: 913b0842     	add	x2, x2, #0xec2
  27ff44: aa1403e0     	mov	x0, x20
  27ff48: f9408508     	ldr	x8, [x8, #0x108]
  27ff4c: aa1503e1     	mov	x1, x21
  27ff50: aa1703e3     	mov	x3, x23
  27ff54: d63f0100     	blr	x8
  27ff58: f900be60     	str	x0, [x19, #0x178]

## 0x27ff6c
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27ff60: b00019e2     	adrp	x2, 0x5bc000
  27ff64: b00019e3     	adrp	x3, 0x5bc000
  27ff68: 913b6842     	add	x2, x2, #0xeda
  27ff6c: f9408508     	ldr	x8, [x8, #0x108]
  27ff70: 913b8063     	add	x3, x3, #0xee0
  27ff74: aa1403e0     	mov	x0, x20
  27ff78: aa1503e1     	mov	x1, x21
  27ff7c: d63f0100     	blr	x8

## 0x27ff94
Classification: UNRESOLVED
Function: 000000000027f518 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE>:
ASM:
  27ff88: d0001942     	adrp	x2, 0x5a9000
  27ff8c: 91166042     	add	x2, x2, #0x598
  27ff90: aa1403e0     	mov	x0, x20
  27ff94: f9408508     	ldr	x8, [x8, #0x108]
  27ff98: aa1503e1     	mov	x1, x21
  27ff9c: aa1603e3     	mov	x3, x22
  27ffa0: d63f0100     	blr	x8
  27ffa4: 2a1f03f4     	mov	w20, wzr

## 0x284f54
Classification: JNI_LIKELY
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  284f48: b00018d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  284f4c: b00018c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  284f50: 91142e94     	add	x20, x20, #0x50b
  284f54: f9408508     	ldr	x8, [x8, #0x108]
  284f58: 91141042     	add	x2, x2, #0x504
  284f5c: aa1303e0     	mov	x0, x19
  284f60: aa1403e3     	mov	x3, x20
  284f64: d63f0100     	blr	x8

## 0x284f80
Classification: JNI_LIKELY
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  284f74: f94382c1     	ldr	x1, [x22, #0x700]
  284f78: b00019c2     	adrp	x2, 0x5bd000
  284f7c: b00019c3     	adrp	x3, 0x5bd000
  284f80: f9408508     	ldr	x8, [x8, #0x108]
  284f84: 9115b042     	add	x2, x2, #0x56c
  284f88: 9115e863     	add	x3, x3, #0x57a
  284f8c: aa1303e0     	mov	x0, x19
  284f90: d63f0100     	blr	x8

## 0x284fac
Classification: JNI_LIKELY
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  284fa0: f94382c1     	ldr	x1, [x22, #0x700]
  284fa4: b00019c2     	adrp	x2, 0x5bd000
  284fa8: 91165442     	add	x2, x2, #0x595
  284fac: f9408508     	ldr	x8, [x8, #0x108]
  284fb0: aa1303e0     	mov	x0, x19
  284fb4: aa1403e3     	mov	x3, x20
  284fb8: d63f0100     	blr	x8
  284fbc: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 0x284fd4
Classification: JNI_LIKELY
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  284fc8: f94382c1     	ldr	x1, [x22, #0x700]
  284fcc: b00019c2     	adrp	x2, 0x5bd000
  284fd0: d00018c3     	adrp	x3, 0x59e000
  284fd4: f9408508     	ldr	x8, [x8, #0x108]
  284fd8: 91169042     	add	x2, x2, #0x5a4
  284fdc: 9127a863     	add	x3, x3, #0x9ea
  284fe0: aa1303e0     	mov	x0, x19
  284fe4: d63f0100     	blr	x8

## 0x285000
Classification: JNI_LIKELY
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  284ff4: f94382c1     	ldr	x1, [x22, #0x700]
  284ff8: b00019c2     	adrp	x2, 0x5bd000
  284ffc: 9116dc42     	add	x2, x2, #0x5b7
  285000: f9408508     	ldr	x8, [x8, #0x108]
  285004: aa1303e0     	mov	x0, x19
  285008: aa1403e3     	mov	x3, x20
  28500c: d63f0100     	blr	x8
  285010: d00024c8     	adrp	x8, 0x71f000 <_ZTIN6Cicada12avAESEncryptE+0x340>

## 0x2872a0
Classification: PROVEN_CXX_OBJECT
Function: 0000000000284ea4 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl>:
ASM:
  287294: f9400268     	ldr	x8, [x19]
  287298: 910003e1     	mov	x1, sp
  28729c: aa1303e0     	mov	x0, x19
  2872a0: f9408508     	ldr	x8, [x8, #0x108]
  2872a4: d63f0100     	blr	x8
  2872a8: 910003e0     	mov	x0, sp
  2872ac: 97fdfddf     	bl	0x206a28 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2d3c>
  2872b0: 3946aa68     	ldrb	w8, [x19, #0x1aa]

## 0x292e58
Classification: JNI_LIKELY
Function: 00000000002925b8 <_ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE>:
ASM:
  292e4c: f0001842     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  292e50: d0001863     	adrp	x3, 0x5a0000
  292e54: aa0003e1     	mov	x1, x0
  292e58: f9408508     	ldr	x8, [x8, #0x108]
  292e5c: 91141042     	add	x2, x2, #0x504
  292e60: 910bc463     	add	x3, x3, #0x2f1
  292e64: aa1303e0     	mov	x0, x19
  292e68: d63f0100     	blr	x8

## 0x292e84
Classification: JNI_LIKELY
Function: 00000000002925b8 <_ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE>:
ASM:
  292e78: f94646a1     	ldr	x1, [x21, #0xc88]
  292e7c: 90001962     	adrp	x2, 0x5be000
  292e80: 90001963     	adrp	x3, 0x5be000
  292e84: f9408508     	ldr	x8, [x8, #0x108]
  292e88: 9128d042     	add	x2, x2, #0xa34
  292e8c: 91290c63     	add	x3, x3, #0xa43
  292e90: aa1303e0     	mov	x0, x19
  292e94: d63f0100     	blr	x8

## 0x292eb0
Classification: JNI_LIKELY
Function: 00000000002925b8 <_ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE>:
ASM:
  292ea4: f94646a1     	ldr	x1, [x21, #0xc88]
  292ea8: 90001962     	adrp	x2, 0x5be000
  292eac: f0001843     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  292eb0: f9408508     	ldr	x8, [x8, #0x108]
  292eb4: 912a3c42     	add	x2, x2, #0xa8f
  292eb8: 91142c63     	add	x3, x3, #0x50b
  292ebc: aa1303e0     	mov	x0, x19
  292ec0: d63f0100     	blr	x8

## 0x292edc
Classification: JNI_LIKELY
Function: 00000000002925b8 <_ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE>:
ASM:
  292ed0: f94646a1     	ldr	x1, [x21, #0xc88]
  292ed4: 90001962     	adrp	x2, 0x5be000
  292ed8: b0001863     	adrp	x3, 0x59f000
  292edc: f9408508     	ldr	x8, [x8, #0x108]
  292ee0: 912a7842     	add	x2, x2, #0xa9e
  292ee4: 911a3463     	add	x3, x3, #0x68d
  292ee8: aa1303e0     	mov	x0, x19
  292eec: d63f0100     	blr	x8

## 0x2b14cc
Classification: JNI_LIKELY
Function: 00000000002a9984 <_ZN8AfString10trimStringERNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE>:
ASM:
  2b14c0: 90001762     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2b14c4: 90001763     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2b14c8: aa0003e1     	mov	x1, x0
  2b14cc: f9408508     	ldr	x8, [x8, #0x108]
  2b14d0: 91141042     	add	x2, x2, #0x504
  2b14d4: 91142c63     	add	x3, x3, #0x50b
  2b14d8: aa1303e0     	mov	x0, x19
  2b14dc: d63f0100     	blr	x8

## 0x2c23d8
Classification: JNI_LIKELY
Function: 00000000002bb7b0 <_ZN8FileCntl15openFileForReadEv>:
ASM:
  2c23cc: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c23d0: f00016c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2c23d4: f00016c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2c23d8: f9408508     	ldr	x8, [x8, #0x108]
  2c23dc: 91156842     	add	x2, x2, #0x55a
  2c23e0: 91158463     	add	x3, x3, #0x561
  2c23e4: aa1303e0     	mov	x0, x19
  2c23e8: d63f0100     	blr	x8

## 0x2c2404
Classification: JNI_LIKELY
Function: 00000000002bb7b0 <_ZN8FileCntl15openFileForReadEv>:
ASM:
  2c23f8: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c23fc: f00017e2     	adrp	x2, 0x5c1000
  2c2400: f00017e3     	adrp	x3, 0x5c1000
  2c2404: f9408508     	ldr	x8, [x8, #0x108]
  2c2408: 913ba042     	add	x2, x2, #0xee8
  2c240c: 913bb463     	add	x3, x3, #0xeed
  2c2410: aa1303e0     	mov	x0, x19
  2c2414: d63f0100     	blr	x8

## 0x2c2430
Classification: JNI_LIKELY
Function: 00000000002bb7b0 <_ZN8FileCntl15openFileForReadEv>:
ASM:
  2c2424: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2428: f00017e2     	adrp	x2, 0x5c1000
  2c242c: f00016e3     	adrp	x3, 0x5a1000
  2c2430: f9408508     	ldr	x8, [x8, #0x108]
  2c2434: 913bc842     	add	x2, x2, #0xef2
  2c2438: 911a6063     	add	x3, x3, #0x698
  2c243c: aa1303e0     	mov	x0, x19
  2c2440: d63f0100     	blr	x8

## 0x2c245c
Classification: JNI_LIKELY
Function: 00000000002bb7b0 <_ZN8FileCntl15openFileForReadEv>:
ASM:
  2c2450: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2454: d0001702     	adrp	x2, 0x5a4000
  2c2458: f00016e3     	adrp	x3, 0x5a1000
  2c245c: f9408508     	ldr	x8, [x8, #0x108]
  2c2460: 913dac42     	add	x2, x2, #0xf6b
  2c2464: 911a9063     	add	x3, x3, #0x6a4
  2c2468: aa1303e0     	mov	x0, x19
  2c246c: d63f0100     	blr	x8

## 0x2c2488
Classification: JNI_LIKELY
Function: 00000000002bb7b0 <_ZN8FileCntl15openFileForReadEv>:
ASM:
  2c247c: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2480: d00017a2     	adrp	x2, 0x5b8000
  2c2484: 91117042     	add	x2, x2, #0x45c
  2c2488: f9408508     	ldr	x8, [x8, #0x108]
  2c248c: aa1303e0     	mov	x0, x19
  2c2490: aa1403e3     	mov	x3, x20
  2c2494: d63f0100     	blr	x8
  2c2498: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 0x2fbe5c
Classification: JNI_LIKELY
Function: 00000000002fb788 <_ZN17GetStringUTFChars8getCharsEv>:
ASM:
  2fbe50: d0001502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2fbe54: d0001503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2fbe58: aa0003e1     	mov	x1, x0
  2fbe5c: f9408508     	ldr	x8, [x8, #0x108]
  2fbe60: 91141042     	add	x2, x2, #0x504
  2fbe64: 91142c63     	add	x3, x3, #0x50b
  2fbe68: aa1303e0     	mov	x0, x19
  2fbe6c: d63f0100     	blr	x8

## 0x2fbe88
Classification: JNI_LIKELY
Function: 00000000002fb788 <_ZN17GetStringUTFChars8getCharsEv>:
ASM:
  2fbe7c: f944bea1     	ldr	x1, [x21, #0x978]
  2fbe80: 90001522     	adrp	x2, 0x59f000
  2fbe84: 90001523     	adrp	x3, 0x59f000
  2fbe88: f9408508     	ldr	x8, [x8, #0x108]
  2fbe8c: 911b1442     	add	x2, x2, #0x6c5
  2fbe90: 911b2463     	add	x3, x3, #0x6c9
  2fbe94: aa1303e0     	mov	x0, x19
  2fbe98: d63f0100     	blr	x8

## 0x2fbfdc
Classification: JNI_LIKELY
Function: 00000000002fb788 <_ZN17GetStringUTFChars8getCharsEv>:
ASM:
  2fbfd0: d0001502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2fbfd4: d0001503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2fbfd8: aa0003e1     	mov	x1, x0
  2fbfdc: f9408508     	ldr	x8, [x8, #0x108]
  2fbfe0: 91141042     	add	x2, x2, #0x504
  2fbfe4: 91142c63     	add	x3, x3, #0x50b
  2fbfe8: aa1303e0     	mov	x0, x19
  2fbfec: d63f0100     	blr	x8

## 0x2fc008
Classification: JNI_LIKELY
Function: 00000000002fb788 <_ZN17GetStringUTFChars8getCharsEv>:
ASM:
  2fbffc: f944caa1     	ldr	x1, [x21, #0x990]
  2fc000: f0001502     	adrp	x2, 0x59f000
  2fc004: f0001503     	adrp	x3, 0x59f000
  2fc008: f9408508     	ldr	x8, [x8, #0x108]
  2fc00c: 911b7c42     	add	x2, x2, #0x6df
  2fc010: 911b8c63     	add	x3, x3, #0x6e3
  2fc014: aa1303e0     	mov	x0, x19
  2fc018: d63f0100     	blr	x8

## 0x35b5c0
Classification: UNRESOLVED
Function: 000000000035a5bc <_ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm>:
ASM:
  35b5b4: d0001362     	adrp	x2, 0x5c9000
  35b5b8: 90001223     	adrp	x3, 0x59f000
  35b5bc: 911f6c42     	add	x2, x2, #0x7db
  35b5c0: f9408508     	ldr	x8, [x8, #0x108]
  35b5c4: 91204463     	add	x3, x3, #0x811
  35b5c8: aa1603e1     	mov	x1, x22
  35b5cc: d63f0100     	blr	x8
  35b5d0: aa0003f7     	mov	x23, x0

## 0x4bc890
Classification: UNRESOLVED
Function: 00000000004bc060 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring>:
ASM:
  4bc884: d0000922     	adrp	x2, 0x5e2000
  4bc888: d0000923     	adrp	x3, 0x5e2000
  4bc88c: 911dfc42     	add	x2, x2, #0x77f
  4bc890: f9408508     	ldr	x8, [x8, #0x108]
  4bc894: 911e2063     	add	x3, x3, #0x788
  4bc898: aa1503e0     	mov	x0, x21
  4bc89c: aa1403e1     	mov	x1, x20
  4bc8a0: d63f0100     	blr	x8

## 0x4bc8b8
Classification: UNRESOLVED
Function: 00000000004bc060 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring>:
ASM:
  4bc8ac: d0000922     	adrp	x2, 0x5e2000
  4bc8b0: 911e9442     	add	x2, x2, #0x7a5
  4bc8b4: aa1503e0     	mov	x0, x21
  4bc8b8: f9408508     	ldr	x8, [x8, #0x108]
  4bc8bc: aa1403e1     	mov	x1, x20
  4bc8c0: aa1703e3     	mov	x3, x23
  4bc8c4: d63f0100     	blr	x8
  4bc8c8: f9002e60     	str	x0, [x19, #0x58]

## 0x4bc8dc
Classification: UNRESOLVED
Function: 00000000004bc060 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring>:
ASM:
  4bc8d0: d0000922     	adrp	x2, 0x5e2000
  4bc8d4: 911ec042     	add	x2, x2, #0x7b0
  4bc8d8: aa1503e0     	mov	x0, x21
  4bc8dc: f9408508     	ldr	x8, [x8, #0x108]
  4bc8e0: aa1403e1     	mov	x1, x20
  4bc8e4: aa1703e3     	mov	x3, x23
  4bc8e8: d63f0100     	blr	x8
  4bc8ec: f9003260     	str	x0, [x19, #0x60]

## 0x4bc900
Classification: UNRESOLVED
Function: 00000000004bc060 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring>:
ASM:
  4bc8f4: d0000922     	adrp	x2, 0x5e2000
  4bc8f8: 911edc42     	add	x2, x2, #0x7b7
  4bc8fc: aa1503e0     	mov	x0, x21
  4bc900: f9408508     	ldr	x8, [x8, #0x108]
  4bc904: aa1403e1     	mov	x1, x20
  4bc908: aa1703e3     	mov	x3, x23
  4bc90c: d63f0100     	blr	x8
  4bc910: f9003660     	str	x0, [x19, #0x68]

## 0x4bc924
Classification: UNRESOLVED
Function: 00000000004bc060 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring>:
ASM:
  4bc918: d0000922     	adrp	x2, 0x5e2000
  4bc91c: d0000923     	adrp	x3, 0x5e2000
  4bc920: 911f0042     	add	x2, x2, #0x7c0
  4bc924: f9408508     	ldr	x8, [x8, #0x108]
  4bc928: 911f3c63     	add	x3, x3, #0x7cf
  4bc92c: aa1503e0     	mov	x0, x21
  4bc930: aa1403e1     	mov	x1, x20
  4bc934: d63f0100     	blr	x8

## 0x515aec
Classification: UNRESOLVED
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  515ae0: b0000482     	adrp	x2, 0x5a6000
  515ae4: 90000443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  515ae8: 91129842     	add	x2, x2, #0x4a6
  515aec: f9408508     	ldr	x8, [x8, #0x108]
  515af0: 910fcc63     	add	x3, x3, #0x3f3
  515af4: aa1303e1     	mov	x1, x19
  515af8: d63f0100     	blr	x8
  515afc: f9000ae0     	str	x0, [x23, #0x10]

## 0x535ea8
Classification: UNRESOLVED
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  535e9c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535ea0: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535ea4: 9113a442     	add	x2, x2, #0x4e9
  535ea8: f9408508     	ldr	x8, [x8, #0x108]
  535eac: 9113c063     	add	x3, x3, #0x4f0
  535eb0: aa1403e0     	mov	x0, x20
  535eb4: aa1503e1     	mov	x1, x21
  535eb8: d63f0100     	blr	x8

## 0x535f58
Classification: UNRESOLVED
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  535f4c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535f50: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535f54: 9113d842     	add	x2, x2, #0x4f6
  535f58: f9408508     	ldr	x8, [x8, #0x108]
  535f5c: aa1403e0     	mov	x0, x20
  535f60: aa1503e1     	mov	x1, x21
  535f64: 91121063     	add	x3, x3, #0x484
  535f68: d63f0100     	blr	x8

## 0x536340
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  536334: aa0003f7     	mov	x23, x0
  536338: 90000382     	adrp	x2, 0x5a6000
  53633c: 91129842     	add	x2, x2, #0x4a6
  536340: f9408508     	ldr	x8, [x8, #0x108]
  536344: aa1303e0     	mov	x0, x19
  536348: aa1703e1     	mov	x1, x23
  53634c: aa1b03e3     	mov	x3, x27
  536350: d63f0100     	blr	x8

## 0x536cc8
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  536cbc: f0000582     	adrp	x2, 0x5e9000
  536cc0: 90000343     	adrp	x3, 0x59e000
  536cc4: 91395c42     	add	x2, x2, #0xe57
  536cc8: f9408508     	ldr	x8, [x8, #0x108]
  536ccc: 91325463     	add	x3, x3, #0xc95
  536cd0: aa1303e0     	mov	x0, x19
  536cd4: aa1603e1     	mov	x1, x22
  536cd8: d63f0100     	blr	x8

## 0x536d08
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  536cfc: f0000582     	adrp	x2, 0x5e9000
  536d00: f0000583     	adrp	x3, 0x5e9000
  536d04: 913a1042     	add	x2, x2, #0xe84
  536d08: f9408508     	ldr	x8, [x8, #0x108]
  536d0c: 913a6463     	add	x3, x3, #0xe99
  536d10: aa1303e0     	mov	x0, x19
  536d14: aa1703e1     	mov	x1, x23
  536d18: d63f0100     	blr	x8

## 0x536d48
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  536d3c: f0000582     	adrp	x2, 0x5e9000
  536d40: f0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  536d44: 913b6042     	add	x2, x2, #0xed8
  536d48: f9408508     	ldr	x8, [x8, #0x108]
  536d4c: 91174463     	add	x3, x3, #0x5d1
  536d50: aa1303e0     	mov	x0, x19
  536d54: aa1403e1     	mov	x1, x20
  536d58: d63f0100     	blr	x8

## 0x537fbc
Classification: UNRESOLVED
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  537fb0: f0000582     	adrp	x2, 0x5ea000
  537fb4: f0000583     	adrp	x3, 0x5ea000
  537fb8: 91037442     	add	x2, x2, #0xdd
  537fbc: f9408508     	ldr	x8, [x8, #0x108]
  537fc0: 9103a863     	add	x3, x3, #0xea
  537fc4: aa1403e0     	mov	x0, x20
  537fc8: aa1703e1     	mov	x1, x23
  537fcc: d63f0100     	blr	x8

## 0x537ffc
Classification: UNRESOLVED
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  537ff0: f0000582     	adrp	x2, 0x5ea000
  537ff4: f0000583     	adrp	x3, 0x5ea000
  537ff8: 9104a842     	add	x2, x2, #0x12a
  537ffc: f9408508     	ldr	x8, [x8, #0x108]
  538000: 9104ec63     	add	x3, x3, #0x13b
  538004: aa1403e0     	mov	x0, x20
  538008: aa1703e1     	mov	x1, x23
  53800c: d63f0100     	blr	x8

## 0x5384cc
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  5384c0: d0000582     	adrp	x2, 0x5ea000
  5384c4: d0000583     	adrp	x3, 0x5ea000
  5384c8: 91072442     	add	x2, x2, #0x1c9
  5384cc: f9408508     	ldr	x8, [x8, #0x108]
  5384d0: 91076863     	add	x3, x3, #0x1da
  5384d4: aa1303e0     	mov	x0, x19
  5384d8: aa1703e1     	mov	x1, x23
  5384dc: d63f0100     	blr	x8

## 0x53850c
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  538500: b0000322     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  538504: b0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  538508: 91141042     	add	x2, x2, #0x504
  53850c: f9408508     	ldr	x8, [x8, #0x108]
  538510: 91158463     	add	x3, x3, #0x561
  538514: aa1303e0     	mov	x0, x19
  538518: aa1603e1     	mov	x1, x22
  53851c: d63f0100     	blr	x8

## 0x53854c
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  538540: d0000582     	adrp	x2, 0x5ea000
  538544: d0000343     	adrp	x3, 0x5a2000
  538548: 9109a842     	add	x2, x2, #0x26a
  53854c: f9408508     	ldr	x8, [x8, #0x108]
  538550: 91374c63     	add	x3, x3, #0xdd3
  538554: aa1303e0     	mov	x0, x19
  538558: aa1803e1     	mov	x1, x24
  53855c: d63f0100     	blr	x8

## 0x5397c8
Classification: JNI_LIKELY
Function: 00000000004f28d8 <_ZN3mpf7CasBaseD2Ev>:
ASM:
  5397bc: 90000482     	adrp	x2, 0x5c9000
  5397c0: 90000483     	adrp	x3, 0x5c9000
  5397c4: 91004c42     	add	x2, x2, #0x13
  5397c8: f9408508     	ldr	x8, [x8, #0x108]
  5397cc: 91008863     	add	x3, x3, #0x22
  5397d0: aa1303e0     	mov	x0, x19
  5397d4: aa1403e1     	mov	x1, x20
  5397d8: d63f0100     	blr	x8

RESULT: PROVEN_CXX_RUNTIME_DISPATCH_CANDIDATE_FOUND

This is a static scan. It cannot prove runtime execution/non-execution by itself.
