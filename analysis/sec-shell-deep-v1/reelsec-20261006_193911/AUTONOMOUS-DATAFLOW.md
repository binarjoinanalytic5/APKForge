# Autonomous Dataflow Proof

Target vtable address-point: 0x717e60
Target slot: 0x717f68 (+0x108)
Target function: 0x27a510

Constructor call sites resolved from machine code: 4
Candidate dispatches analysed: 473
PROVEN target data-flow: 0
C++ vptr candidates still unresolved: 354

The analyzer never treats x19 naming alone as proof.

## f8bb4 — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8b94: aa1403e1     	mov	x1, x20
   f8b98: aa1603e2     	mov	x2, x22
   f8b9c: f81a03a8     	stur	x8, [x29, #-0x60]
   f8ba0: 94080a87     	bl	0x2fb5bc <_ZN12NewStringUTF9getStringEv+0x8>
   f8ba4: f9400288     	ldr	x8, [x20]
   f8ba8: f9406ff7     	ldr	x23, [sp, #0xd8]
   f8bac: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8bb0: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8bb4: f9408508     	ldr	x8, [x8, #0x108]
   f8bb8: 910eb042     	add	x2, x2, #0x3ac
   f8bbc: 910ef863     	add	x3, x3, #0x3be
   f8bc0: aa1403e0     	mov	x0, x20
   f8bc4: aa1703e1     	mov	x1, x23
   f8bc8: d63f0100     	blr	x8

## f8bf8 — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8bd8: aa1603e2     	mov	x2, x22
   f8bdc: 94080a9e     	bl	0x2fb654 <_ZN12NewStringUTF9getStringEv+0xa0>
   f8be0: f9406bf5     	ldr	x21, [sp, #0xd0]
   f8be4: b4001ef5     	cbz	x21, 0xf8fc0 <JNI_OnUnload+0x65c>
   f8be8: f9400288     	ldr	x8, [x20]
   f8bec: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8bf0: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8bf4: 910f9042     	add	x2, x2, #0x3e4
   f8bf8: f9408508     	ldr	x8, [x8, #0x108]
   f8bfc: 910fcc63     	add	x3, x3, #0x3f3
   f8c00: aa1403e0     	mov	x0, x20
   f8c04: aa1703e1     	mov	x1, x23
   f8c08: d63f0100     	blr	x8
   f8c0c: aa0003e3     	mov	x3, x0

## f8c48 — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8c28: 9102a3e0     	add	x0, sp, #0xa8
   f8c2c: aa1403e1     	mov	x1, x20
   f8c30: aa1503e2     	mov	x2, x21
   f8c34: 94080a62     	bl	0x2fb5bc <_ZN12NewStringUTF9getStringEv+0x8>
   f8c38: f9400288     	ldr	x8, [x20]
   f8c3c: f94057e1     	ldr	x1, [sp, #0xa8]
   f8c40: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8c44: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8c48: f9408508     	ldr	x8, [x8, #0x108]
   f8c4c: 91102042     	add	x2, x2, #0x408
   f8c50: 91105c63     	add	x3, x3, #0x417
   f8c54: aa1403e0     	mov	x0, x20
   f8c58: d63f0100     	blr	x8
   f8c5c: aa0003e2     	mov	x2, x0

## f8d4c — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8d2c: 910223e0     	add	x0, sp, #0x88
   f8d30: aa1403e1     	mov	x1, x20
   f8d34: aa1503e2     	mov	x2, x21
   f8d38: 94080a21     	bl	0x2fb5bc <_ZN12NewStringUTF9getStringEv+0x8>
   f8d3c: f9400288     	ldr	x8, [x20]
   f8d40: f94047e1     	ldr	x1, [sp, #0x88]
   f8d44: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8d48: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8d4c: f9408508     	ldr	x8, [x8, #0x108]
   f8d50: 9111e042     	add	x2, x2, #0x478
   f8d54: 91121063     	add	x3, x3, #0x484
   f8d58: aa1403e0     	mov	x0, x20
   f8d5c: d63f0100     	blr	x8
   f8d60: aa0003e3     	mov	x3, x0

## f8e10 — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8df0: aa1703e2     	mov	x2, x23
   f8df4: 940000eb     	bl	0xf91a0 <JNI_OnUnload+0x83c>
   f8df8: aa0003f7     	mov	x23, x0
   f8dfc: b4001000     	cbz	x0, 0xf8ffc <JNI_OnUnload+0x698>
   f8e00: f9400288     	ldr	x8, [x20]
   f8e04: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8e08: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8e0c: 9113a442     	add	x2, x2, #0x4e9
   f8e10: f9408508     	ldr	x8, [x8, #0x108]
   f8e14: 9113c063     	add	x3, x3, #0x4f0
   f8e18: aa1403e0     	mov	x0, x20
   f8e1c: aa1603e1     	mov	x1, x22
   f8e20: d63f0100     	blr	x8
   f8e24: aa0003e2     	mov	x2, x0

## f8e48 — UNRESOLVED_0x108_DATAFLOW
Function: JNI_OnUnload
Basis: no target-vtable provenance established
ASM:
   f8e28: aa1403e0     	mov	x0, x20
   f8e2c: aa1703e1     	mov	x1, x23
   f8e30: aa1503e3     	mov	x3, x21
   f8e34: 94000102     	bl	0xf923c <JNI_OnUnload+0x8d8>
   f8e38: f9400288     	ldr	x8, [x20]
   f8e3c: b0002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f8e40: b0002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f8e44: 9113d842     	add	x2, x2, #0x4f6
   f8e48: f9408508     	ldr	x8, [x8, #0x108]
   f8e4c: 91121063     	add	x3, x3, #0x484
   f8e50: aa1403e0     	mov	x0, x20
   f8e54: aa1603e1     	mov	x1, x22
   f8e58: d63f0100     	blr	x8
   f8e5c: aa0003e3     	mov	x3, x0

## f96c0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f96a0: aa1303e0     	mov	x0, x19
   f96a4: f9405508     	ldr	x8, [x8, #0xa8]
   f96a8: d63f0100     	blr	x8
   f96ac: f9059ac0     	str	x0, [x22, #0xb30]
   f96b0: f9400268     	ldr	x8, [x19]
   f96b4: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f96b8: 90002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f96bc: aa0003e1     	mov	x1, x0
   f96c0: f9408508     	ldr	x8, [x8, #0x108]
   f96c4: 91141042     	add	x2, x2, #0x504
   f96c8: 91142c63     	add	x3, x3, #0x50b
   f96cc: aa1303e0     	mov	x0, x19
   f96d0: d63f0100     	blr	x8
   f96d4: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## f96ec — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f96cc: aa1303e0     	mov	x0, x19
   f96d0: d63f0100     	blr	x8
   f96d4: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f96d8: f905b500     	str	x0, [x8, #0xb68]
   f96dc: f9400268     	ldr	x8, [x19]
   f96e0: f9459ac1     	ldr	x1, [x22, #0xb30]
   f96e4: 90002534     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
   f96e8: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f96ec: f9408508     	ldr	x8, [x8, #0x108]
   f96f0: 910fce94     	add	x20, x20, #0x3f3
   f96f4: 91143c42     	add	x2, x2, #0x50f
   f96f8: aa1303e0     	mov	x0, x19
   f96fc: aa1403e3     	mov	x3, x20
   f9700: d63f0100     	blr	x8

## f971c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f96fc: aa1403e3     	mov	x3, x20
   f9700: d63f0100     	blr	x8
   f9704: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9708: f9059d00     	str	x0, [x8, #0xb38]
   f970c: f9400268     	ldr	x8, [x19]
   f9710: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9714: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9718: 91145842     	add	x2, x2, #0x516
   f971c: f9408508     	ldr	x8, [x8, #0x108]
   f9720: aa1303e0     	mov	x0, x19
   f9724: aa1403e3     	mov	x3, x20
   f9728: d63f0100     	blr	x8
   f972c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9730: f905a100     	str	x0, [x8, #0xb40]

## f9744 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f9724: aa1403e3     	mov	x3, x20
   f9728: d63f0100     	blr	x8
   f972c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9730: f905a100     	str	x0, [x8, #0xb40]
   f9734: f9400268     	ldr	x8, [x19]
   f9738: f9459ac1     	ldr	x1, [x22, #0xb30]
   f973c: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9740: 91149c42     	add	x2, x2, #0x527
   f9744: f9408508     	ldr	x8, [x8, #0x108]
   f9748: aa1303e0     	mov	x0, x19
   f974c: aa1403e3     	mov	x3, x20
   f9750: d63f0100     	blr	x8
   f9754: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9758: f905a500     	str	x0, [x8, #0xb48]

## f976c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f974c: aa1403e3     	mov	x3, x20
   f9750: d63f0100     	blr	x8
   f9754: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9758: f905a500     	str	x0, [x8, #0xb48]
   f975c: f9400268     	ldr	x8, [x19]
   f9760: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9764: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9768: 9114d042     	add	x2, x2, #0x534
   f976c: f9408508     	ldr	x8, [x8, #0x108]
   f9770: aa1303e0     	mov	x0, x19
   f9774: aa1403e3     	mov	x3, x20
   f9778: d63f0100     	blr	x8
   f977c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9780: f905a900     	str	x0, [x8, #0xb50]

## f9794 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f9774: aa1403e3     	mov	x3, x20
   f9778: d63f0100     	blr	x8
   f977c: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9780: f905a900     	str	x0, [x8, #0xb50]
   f9784: f9400268     	ldr	x8, [x19]
   f9788: f9459ac1     	ldr	x1, [x22, #0xb30]
   f978c: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9790: 90002523     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   f9794: f9408508     	ldr	x8, [x8, #0x108]
   f9798: 9114f442     	add	x2, x2, #0x53d
   f979c: 91152c63     	add	x3, x3, #0x54b
   f97a0: aa1303e0     	mov	x0, x19
   f97a4: d63f0100     	blr	x8
   f97a8: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## f97c0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f97a0: aa1303e0     	mov	x0, x19
   f97a4: d63f0100     	blr	x8
   f97a8: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f97ac: f905ad00     	str	x0, [x8, #0xb58]
   f97b0: f9400268     	ldr	x8, [x19]
   f97b4: f9459ac1     	ldr	x1, [x22, #0xb30]
   f97b8: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f97bc: 91153c42     	add	x2, x2, #0x54f
   f97c0: f9408508     	ldr	x8, [x8, #0x108]
   f97c4: aa1303e0     	mov	x0, x19
   f97c8: aa1403e3     	mov	x3, x20
   f97cc: d63f0100     	blr	x8
   f97d0: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f97d4: f905b100     	str	x0, [x8, #0xb60]

## f97e8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f97c8: aa1403e3     	mov	x3, x20
   f97cc: d63f0100     	blr	x8
   f97d0: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f97d4: f905b100     	str	x0, [x8, #0xb60]
   f97d8: f9400268     	ldr	x8, [x19]
   f97dc: f9459ac1     	ldr	x1, [x22, #0xb30]
   f97e0: 90002534     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
   f97e4: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f97e8: f9408508     	ldr	x8, [x8, #0x108]
   f97ec: 91158694     	add	x20, x20, #0x561
   f97f0: 91156842     	add	x2, x2, #0x55a
   f97f4: aa1303e0     	mov	x0, x19
   f97f8: aa1403e3     	mov	x3, x20
   f97fc: d63f0100     	blr	x8

## f9818 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f97f8: aa1403e3     	mov	x3, x20
   f97fc: d63f0100     	blr	x8
   f9800: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9804: f905b900     	str	x0, [x8, #0xb70]
   f9808: f9400268     	ldr	x8, [x19]
   f980c: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9810: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9814: 9115dc42     	add	x2, x2, #0x577
   f9818: f9408508     	ldr	x8, [x8, #0x108]
   f981c: aa1303e0     	mov	x0, x19
   f9820: aa1403e3     	mov	x3, x20
   f9824: d63f0100     	blr	x8
   f9828: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f982c: f905bd00     	str	x0, [x8, #0xb78]

## f9840 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f9820: aa1403e3     	mov	x3, x20
   f9824: d63f0100     	blr	x8
   f9828: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f982c: f905bd00     	str	x0, [x8, #0xb78]
   f9830: f9400268     	ldr	x8, [x19]
   f9834: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9838: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f983c: 91161042     	add	x2, x2, #0x584
   f9840: f9408508     	ldr	x8, [x8, #0x108]
   f9844: aa1303e0     	mov	x0, x19
   f9848: aa1403e3     	mov	x3, x20
   f984c: d63f0100     	blr	x8
   f9850: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9854: f905c100     	str	x0, [x8, #0xb80]

## f9868 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: JNI_OnUnload
Basis: object-vptr load found but constructor provenance is not established
ASM:
   f9848: aa1403e3     	mov	x3, x20
   f984c: d63f0100     	blr	x8
   f9850: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f9854: f905c100     	str	x0, [x8, #0xb80]
   f9858: f9400268     	ldr	x8, [x19]
   f985c: f9459ac1     	ldr	x1, [x22, #0xb30]
   f9860: 90002522     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   f9864: 91163442     	add	x2, x2, #0x58d
   f9868: f9408508     	ldr	x8, [x8, #0x108]
   f986c: aa1303e0     	mov	x0, x19
   f9870: aa1403e3     	mov	x3, x20
   f9874: d63f0100     	blr	x8
   f9878: d0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   f987c: f905c500     	str	x0, [x8, #0xb88]

## fa204 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaTrackInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fa1e4: aa1303e0     	mov	x0, x19
   fa1e8: f9405508     	ldr	x8, [x8, #0xa8]
   fa1ec: d63f0100     	blr	x8
   fa1f0: f905d2e0     	str	x0, [x23, #0xba0]
   fa1f4: f9400268     	ldr	x8, [x19]
   fa1f8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa1fc: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fa200: aa0003e1     	mov	x1, x0
   fa204: f9408508     	ldr	x8, [x8, #0x108]
   fa208: 91141042     	add	x2, x2, #0x504
   fa20c: 91142c63     	add	x3, x3, #0x50b
   fa210: aa1303e0     	mov	x0, x19
   fa214: d63f0100     	blr	x8
   fa218: b0003238     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fa234 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaTrackInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fa214: d63f0100     	blr	x8
   fa218: b0003238     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>
   fa21c: 912ec318     	add	x24, x24, #0xbb0
   fa220: f9000300     	str	x0, [x24]
   fa224: f9400268     	ldr	x8, [x19]
   fa228: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa22c: f0002514     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
   fa230: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa234: f9408508     	ldr	x8, [x8, #0x108]
   fa238: 91170e94     	add	x20, x20, #0x5c3
   fa23c: 9116ec42     	add	x2, x2, #0x5bb
   fa240: aa1303e0     	mov	x0, x19
   fa244: aa1403e3     	mov	x3, x20
   fa248: d63f0100     	blr	x8

## fa260 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaTrackInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fa240: aa1303e0     	mov	x0, x19
   fa244: aa1403e3     	mov	x3, x20
   fa248: d63f0100     	blr	x8
   fa24c: f9000700     	str	x0, [x24, #0x8]
   fa250: f9400268     	ldr	x8, [x19]
   fa254: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa258: f0002515     	adrp	x21, 0x59d000 <__cxa_demangle+0x182b4>
   fa25c: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa260: f9408508     	ldr	x8, [x8, #0x108]
   fa264: 911746b5     	add	x21, x21, #0x5d1
   fa268: 91172042     	add	x2, x2, #0x5c8
   fa26c: aa1303e0     	mov	x0, x19
   fa270: aa1503e3     	mov	x3, x21
   fa274: d63f0100     	blr	x8

## fa28c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaTrackInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fa26c: aa1303e0     	mov	x0, x19
   fa270: aa1503e3     	mov	x3, x21
   fa274: d63f0100     	blr	x8
   fa278: f9001300     	str	x0, [x24, #0x20]
   fa27c: f9400268     	ldr	x8, [x19]
   fa280: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa284: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa288: 91175442     	add	x2, x2, #0x5d5
   fa28c: f9408508     	ldr	x8, [x8, #0x108]
   fa290: aa1303e0     	mov	x0, x19
   fa294: aa1403e3     	mov	x3, x20
   fa298: d63f0100     	blr	x8
   fa29c: f9000b00     	str	x0, [x24, #0x10]
   fa2a0: f9400268     	ldr	x8, [x19]

## fa2b0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaTrackInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fa290: aa1303e0     	mov	x0, x19
   fa294: aa1403e3     	mov	x3, x20
   fa298: d63f0100     	blr	x8
   fa29c: f9000b00     	str	x0, [x24, #0x10]
   fa2a0: f9400268     	ldr	x8, [x19]
   fa2a4: f945d2e1     	ldr	x1, [x23, #0xba0]
   fa2a8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fa2ac: 91179442     	add	x2, x2, #0x5e5
   fa2b0: f9408508     	ldr	x8, [x8, #0x108]
   fa2b4: aa1303e0     	mov	x0, x19
   fa2b8: aa1503e3     	mov	x3, x21
   fa2bc: d63f0100     	blr	x8
   fa2c0: f9000f00     	str	x0, [x24, #0x18]
   fa2c4: f9400268     	ldr	x8, [x19]

## faf04 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   faee4: aa1303e0     	mov	x0, x19
   faee8: f9405508     	ldr	x8, [x8, #0xa8]
   faeec: d63f0100     	blr	x8
   faef0: f9062ac0     	str	x0, [x22, #0xc50]
   faef4: f9400268     	ldr	x8, [x19]
   faef8: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faefc: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf00: aa0003e1     	mov	x1, x0
   faf04: f9408508     	ldr	x8, [x8, #0x108]
   faf08: 91141042     	add	x2, x2, #0x504
   faf0c: 91142c63     	add	x3, x3, #0x50b
   faf10: aa1303e0     	mov	x0, x19
   faf14: d63f0100     	blr	x8
   faf18: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## faf30 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   faf10: aa1303e0     	mov	x0, x19
   faf14: d63f0100     	blr	x8
   faf18: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   faf1c: f9062d00     	str	x0, [x8, #0xc58]
   faf20: f9400268     	ldr	x8, [x19]
   faf24: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf28: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf2c: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf30: f9408508     	ldr	x8, [x8, #0x108]
   faf34: 911bf842     	add	x2, x2, #0x6fe
   faf38: 911c3063     	add	x3, x3, #0x70c
   faf3c: aa1303e0     	mov	x0, x19
   faf40: d63f0100     	blr	x8
   faf44: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## faf5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   faf3c: aa1303e0     	mov	x0, x19
   faf40: d63f0100     	blr	x8
   faf44: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   faf48: f9063100     	str	x0, [x8, #0xc60]
   faf4c: f9400268     	ldr	x8, [x19]
   faf50: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf54: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf58: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf5c: f9408508     	ldr	x8, [x8, #0x108]
   faf60: 911ce842     	add	x2, x2, #0x73a
   faf64: 911d3063     	add	x3, x3, #0x74c
   faf68: aa1303e0     	mov	x0, x19
   faf6c: d63f0100     	blr	x8
   faf70: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## faf88 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
   faf68: aa1303e0     	mov	x0, x19
   faf6c: d63f0100     	blr	x8
   faf70: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   faf74: f9063500     	str	x0, [x8, #0xc68]
   faf78: f9400268     	ldr	x8, [x19]
   faf7c: f9462ac1     	ldr	x1, [x22, #0xc50]
   faf80: f0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   faf84: f0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   faf88: f9408508     	ldr	x8, [x8, #0x108]
   faf8c: 911d8842     	add	x2, x2, #0x762
   faf90: 911dcc63     	add	x3, x3, #0x773
   faf94: aa1303e0     	mov	x0, x19
   faf98: d63f0100     	blr	x8
   faf9c: b0003228     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fc0a0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fc080: aa1303e0     	mov	x0, x19
   fc084: f9405508     	ldr	x8, [x8, #0xa8]
   fc088: d63f0100     	blr	x8
   fc08c: f9065ea0     	str	x0, [x21, #0xcb8]
   fc090: f9400268     	ldr	x8, [x19]
   fc094: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc098: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc09c: aa0003e1     	mov	x1, x0
   fc0a0: f9408508     	ldr	x8, [x8, #0x108]
   fc0a4: 91141042     	add	x2, x2, #0x504
   fc0a8: 91142c63     	add	x3, x3, #0x50b
   fc0ac: aa1303e0     	mov	x0, x19
   fc0b0: d63f0100     	blr	x8
   fc0b4: f0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fc0cc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fc0ac: aa1303e0     	mov	x0, x19
   fc0b0: d63f0100     	blr	x8
   fc0b4: f0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   fc0b8: f9066100     	str	x0, [x8, #0xcc0]
   fc0bc: f9400268     	ldr	x8, [x19]
   fc0c0: f9465ea1     	ldr	x1, [x21, #0xcb8]
   fc0c4: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc0c8: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc0cc: f9408508     	ldr	x8, [x8, #0x108]
   fc0d0: 91207442     	add	x2, x2, #0x81d
   fc0d4: 91208463     	add	x3, x3, #0x821
   fc0d8: aa1303e0     	mov	x0, x19
   fc0dc: d63f0100     	blr	x8
   fc0e0: f0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fc4f4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fc4d4: aa1303e0     	mov	x0, x19
   fc4d8: f9405508     	ldr	x8, [x8, #0xa8]
   fc4dc: d63f0100     	blr	x8
   fc4e0: f9066ae0     	str	x0, [x23, #0xcd0]
   fc4e4: f9400268     	ldr	x8, [x19]
   fc4e8: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc4ec: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc4f0: aa0003e1     	mov	x1, x0
   fc4f4: f9408508     	ldr	x8, [x8, #0x108]
   fc4f8: 91141042     	add	x2, x2, #0x504
   fc4fc: 91142c63     	add	x3, x3, #0x50b
   fc500: aa1303e0     	mov	x0, x19
   fc504: d63f0100     	blr	x8
   fc508: f0003218     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fc524 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fc504: d63f0100     	blr	x8
   fc508: f0003218     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>
   fc50c: 91338318     	add	x24, x24, #0xce0
   fc510: f9000300     	str	x0, [x24]
   fc514: f9400268     	ldr	x8, [x19]
   fc518: f9466ae1     	ldr	x1, [x23, #0xcd0]
   fc51c: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc520: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc524: f9408508     	ldr	x8, [x8, #0x108]
   fc528: 9121c042     	add	x2, x2, #0x870
   fc52c: 91220463     	add	x3, x3, #0x881
   fc530: aa1303e0     	mov	x0, x19
   fc534: d63f0100     	blr	x8
   fc538: f9000700     	str	x0, [x24, #0x8]

## fc54c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fc52c: 91220463     	add	x3, x3, #0x881
   fc530: aa1303e0     	mov	x0, x19
   fc534: d63f0100     	blr	x8
   fc538: f9000700     	str	x0, [x24, #0x8]
   fc53c: f9400268     	ldr	x8, [x19]
   fc540: f9466ae1     	ldr	x1, [x23, #0xcd0]
   fc544: b0002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fc548: b0002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fc54c: f9408508     	ldr	x8, [x8, #0x108]
   fc550: 91225c42     	add	x2, x2, #0x897
   fc554: 9122a063     	add	x3, x3, #0x8a8
   fc558: aa1303e0     	mov	x0, x19
   fc55c: d63f0100     	blr	x8
   fc560: f9000b00     	str	x0, [x24, #0x10]

## fdb5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fdb3c: aa1303e0     	mov	x0, x19
   fdb40: f9405508     	ldr	x8, [x8, #0xa8]
   fdb44: d63f0100     	blr	x8
   fdb48: f906fae0     	str	x0, [x23, #0xdf0]
   fdb4c: f9400268     	ldr	x8, [x19]
   fdb50: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdb54: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdb58: aa0003e1     	mov	x1, x0
   fdb5c: f9408508     	ldr	x8, [x8, #0x108]
   fdb60: 91141042     	add	x2, x2, #0x504
   fdb64: 91142c63     	add	x3, x3, #0x50b
   fdb68: aa1303e0     	mov	x0, x19
   fdb6c: d63f0100     	blr	x8
   fdb70: d0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fdb88 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fdb68: aa1303e0     	mov	x0, x19
   fdb6c: d63f0100     	blr	x8
   fdb70: d0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   fdb74: f906fd00     	str	x0, [x8, #0xdf8]
   fdb78: f9400268     	ldr	x8, [x19]
   fdb7c: f946fae1     	ldr	x1, [x23, #0xdf0]
   fdb80: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdb84: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdb88: f9408508     	ldr	x8, [x8, #0x108]
   fdb8c: 9121c042     	add	x2, x2, #0x870
   fdb90: 91220463     	add	x3, x3, #0x881
   fdb94: aa1303e0     	mov	x0, x19
   fdb98: d63f0100     	blr	x8
   fdb9c: d0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fdbb4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fdb94: aa1303e0     	mov	x0, x19
   fdb98: d63f0100     	blr	x8
   fdb9c: d0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>
   fdba0: f9070100     	str	x0, [x8, #0xe00]
   fdba4: f9400268     	ldr	x8, [x19]
   fdba8: f946fae1     	ldr	x1, [x23, #0xdf0]
   fdbac: 90002502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fdbb0: 90002503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fdbb4: f9408508     	ldr	x8, [x8, #0x108]
   fdbb8: 91225c42     	add	x2, x2, #0x897
   fdbbc: 9122a063     	add	x3, x3, #0x8a8
   fdbc0: aa1303e0     	mov	x0, x19
   fdbc4: d63f0100     	blr	x8
   fdbc8: d0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## fe01c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: no target-vtable provenance established
ASM:
   fdffc: aa1403e0     	mov	x0, x20
   fe000: aa1603e1     	mov	x1, x22
   fe004: f9407d08     	ldr	x8, [x8, #0xf8]
   fe008: d63f0100     	blr	x8
   fe00c: f9400288     	ldr	x8, [x20]
   fe010: aa0003f7     	mov	x23, x0
   fe014: f00024e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fe018: f00024e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fe01c: f9408508     	ldr	x8, [x8, #0x108]
   fe020: 912f8442     	add	x2, x2, #0xbe1
   fe024: 91174463     	add	x3, x3, #0x5d1
   fe028: aa1403e0     	mov	x0, x20
   fe02c: aa1703e1     	mov	x1, x23
   fe030: d63f0100     	blr	x8

## fe5a8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN13JavaMediaInfo15convertToStreamEP7_JNIEnvP8_jobject
Basis: object-vptr load found but constructor provenance is not established
ASM:
   fe588: aa1303e0     	mov	x0, x19
   fe58c: f9405508     	ldr	x8, [x8, #0xa8]
   fe590: d63f0100     	blr	x8
   fe594: f9073ec0     	str	x0, [x22, #0xe78]
   fe598: f9400268     	ldr	x8, [x19]
   fe59c: f00024e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
   fe5a0: f00024e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
   fe5a4: aa0003e1     	mov	x1, x0
   fe5a8: f9408508     	ldr	x8, [x8, #0x108]
   fe5ac: 91141042     	add	x2, x2, #0x504
   fe5b0: 91142c63     	add	x3, x3, #0x50b
   fe5b4: aa1303e0     	mov	x0, x19
   fe5b8: d63f0100     	blr	x8
   fe5bc: b0003208     	adrp	x8, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 100864 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  100844: aa1303e0     	mov	x0, x19
  100848: aa1603e1     	mov	x1, x22
  10084c: f9407d08     	ldr	x8, [x8, #0xf8]
  100850: d63f0100     	blr	x8
  100854: f9400268     	ldr	x8, [x19]
  100858: aa0003f7     	mov	x23, x0
  10085c: b00024e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  100860: b00024e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  100864: f9408508     	ldr	x8, [x8, #0x108]
  100868: 912f8442     	add	x2, x2, #0xbe1
  10086c: 91174463     	add	x3, x3, #0x5d1
  100870: aa1303e0     	mov	x0, x19
  100874: aa1703e1     	mov	x1, x23
  100878: d63f0100     	blr	x8

## 1024c0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1024a0: aa1303e0     	mov	x0, x19
  1024a4: f9405508     	ldr	x8, [x8, #0xa8]
  1024a8: d63f0100     	blr	x8
  1024ac: f9078ee0     	str	x0, [x23, #0xf18]
  1024b0: f9400268     	ldr	x8, [x19]
  1024b4: f00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1024b8: f00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1024bc: aa0003e1     	mov	x1, x0
  1024c0: f9408508     	ldr	x8, [x8, #0x108]
  1024c4: 91141042     	add	x2, x2, #0x504
  1024c8: 91142c63     	add	x3, x3, #0x50b
  1024cc: aa1303e0     	mov	x0, x19
  1024d0: d63f0100     	blr	x8
  1024d4: b00031f8     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>

## 1024f0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1024d0: d63f0100     	blr	x8
  1024d4: b00031f8     	adrp	x24, 0x73f000 <fafedeca4bfe0021e+0x5460>
  1024d8: 913c8318     	add	x24, x24, #0xf20
  1024dc: f9000300     	str	x0, [x24]
  1024e0: f9400268     	ldr	x8, [x19]
  1024e4: f9478ee1     	ldr	x1, [x23, #0xf18]
  1024e8: 900024f4     	adrp	x20, 0x59e000
  1024ec: 900024e2     	adrp	x2, 0x59e000
  1024f0: f9408508     	ldr	x8, [x8, #0x108]
  1024f4: 91258a94     	add	x20, x20, #0x962
  1024f8: 91255442     	add	x2, x2, #0x955
  1024fc: aa1303e0     	mov	x0, x19
  102500: aa1403e3     	mov	x3, x20
  102504: d63f0100     	blr	x8

## 10251c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1024fc: aa1303e0     	mov	x0, x19
  102500: aa1403e3     	mov	x3, x20
  102504: d63f0100     	blr	x8
  102508: f9000f00     	str	x0, [x24, #0x18]
  10250c: f9400268     	ldr	x8, [x19]
  102510: f9478ee1     	ldr	x1, [x23, #0xf18]
  102514: 900024e2     	adrp	x2, 0x59e000
  102518: 9125a442     	add	x2, x2, #0x969
  10251c: f9408508     	ldr	x8, [x8, #0x108]
  102520: aa1303e0     	mov	x0, x19
  102524: aa1403e3     	mov	x3, x20
  102528: d63f0100     	blr	x8
  10252c: f9001300     	str	x0, [x24, #0x20]
  102530: f9400268     	ldr	x8, [x19]

## 102540 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  102520: aa1303e0     	mov	x0, x19
  102524: aa1403e3     	mov	x3, x20
  102528: d63f0100     	blr	x8
  10252c: f9001300     	str	x0, [x24, #0x20]
  102530: f9400268     	ldr	x8, [x19]
  102534: f9478ee1     	ldr	x1, [x23, #0xf18]
  102538: 900024f4     	adrp	x20, 0x59e000
  10253c: 900024e2     	adrp	x2, 0x59e000
  102540: f9408508     	ldr	x8, [x8, #0x108]
  102544: 91261e94     	add	x20, x20, #0x987
  102548: 9125d842     	add	x2, x2, #0x976
  10254c: aa1303e0     	mov	x0, x19
  102550: aa1403e3     	mov	x3, x20
  102554: d63f0100     	blr	x8

## 10256c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10254c: aa1303e0     	mov	x0, x19
  102550: aa1403e3     	mov	x3, x20
  102554: d63f0100     	blr	x8
  102558: f9001700     	str	x0, [x24, #0x28]
  10255c: f9400268     	ldr	x8, [x19]
  102560: f9478ee1     	ldr	x1, [x23, #0xf18]
  102564: 900024f5     	adrp	x21, 0x59e000
  102568: 900024e2     	adrp	x2, 0x59e000
  10256c: f9408508     	ldr	x8, [x8, #0x108]
  102570: 91269ab5     	add	x21, x21, #0x9a6
  102574: 91263442     	add	x2, x2, #0x98d
  102578: aa1303e0     	mov	x0, x19
  10257c: aa1503e3     	mov	x3, x21
  102580: d63f0100     	blr	x8

## 102598 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  102578: aa1303e0     	mov	x0, x19
  10257c: aa1503e3     	mov	x3, x21
  102580: d63f0100     	blr	x8
  102584: f9001b00     	str	x0, [x24, #0x30]
  102588: f9400268     	ldr	x8, [x19]
  10258c: f9478ee1     	ldr	x1, [x23, #0xf18]
  102590: 900024e2     	adrp	x2, 0x59e000
  102594: 9126b042     	add	x2, x2, #0x9ac
  102598: f9408508     	ldr	x8, [x8, #0x108]
  10259c: aa1303e0     	mov	x0, x19
  1025a0: aa1403e3     	mov	x3, x20
  1025a4: d63f0100     	blr	x8
  1025a8: f9001f00     	str	x0, [x24, #0x38]
  1025ac: f9400268     	ldr	x8, [x19]

## 1025bc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10259c: aa1303e0     	mov	x0, x19
  1025a0: aa1403e3     	mov	x3, x20
  1025a4: d63f0100     	blr	x8
  1025a8: f9001f00     	str	x0, [x24, #0x38]
  1025ac: f9400268     	ldr	x8, [x19]
  1025b0: f9478ee1     	ldr	x1, [x23, #0xf18]
  1025b4: 900024e2     	adrp	x2, 0x59e000
  1025b8: 900024e3     	adrp	x3, 0x59e000
  1025bc: f9408508     	ldr	x8, [x8, #0x108]
  1025c0: 9126f442     	add	x2, x2, #0x9bd
  1025c4: 91272063     	add	x3, x3, #0x9c8
  1025c8: aa1303e0     	mov	x0, x19
  1025cc: d63f0100     	blr	x8
  1025d0: f9002300     	str	x0, [x24, #0x40]

## 1025e4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1025c4: 91272063     	add	x3, x3, #0x9c8
  1025c8: aa1303e0     	mov	x0, x19
  1025cc: d63f0100     	blr	x8
  1025d0: f9002300     	str	x0, [x24, #0x40]
  1025d4: f9400268     	ldr	x8, [x19]
  1025d8: f9478ee1     	ldr	x1, [x23, #0xf18]
  1025dc: 900024e2     	adrp	x2, 0x59e000
  1025e0: 900024e3     	adrp	x3, 0x59e000
  1025e4: f9408508     	ldr	x8, [x8, #0x108]
  1025e8: 91274442     	add	x2, x2, #0x9d1
  1025ec: 9127a863     	add	x3, x3, #0x9ea
  1025f0: aa1303e0     	mov	x0, x19
  1025f4: d63f0100     	blr	x8
  1025f8: f9000b00     	str	x0, [x24, #0x10]

## 10260c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIiEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1025ec: 9127a863     	add	x3, x3, #0x9ea
  1025f0: aa1303e0     	mov	x0, x19
  1025f4: d63f0100     	blr	x8
  1025f8: f9000b00     	str	x0, [x24, #0x10]
  1025fc: f9400268     	ldr	x8, [x19]
  102600: f9478ee1     	ldr	x1, [x23, #0xf18]
  102604: 900024e2     	adrp	x2, 0x59e000
  102608: 9127c042     	add	x2, x2, #0x9f0
  10260c: f9408508     	ldr	x8, [x8, #0x108]
  102610: aa1303e0     	mov	x0, x19
  102614: aa1503e3     	mov	x3, x21
  102618: d63f0100     	blr	x8
  10261c: f9000700     	str	x0, [x24, #0x8]
  102620: f9400268     	ldr	x8, [x19]

## 1041dc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1041bc: aa1303e0     	mov	x0, x19
  1041c0: f9405508     	ldr	x8, [x8, #0xa8]
  1041c4: d63f0100     	blr	x8
  1041c8: f90022e0     	str	x0, [x23, #0x40]
  1041cc: f9400268     	ldr	x8, [x19]
  1041d0: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1041d4: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1041d8: aa0003e1     	mov	x1, x0
  1041dc: f9408508     	ldr	x8, [x8, #0x108]
  1041e0: 91141042     	add	x2, x2, #0x504
  1041e4: 91142c63     	add	x3, x3, #0x50b
  1041e8: aa1303e0     	mov	x0, x19
  1041ec: d63f0100     	blr	x8
  1041f0: 900031f8     	adrp	x24, 0x740000

## 104c64 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  104c44: aa1303e0     	mov	x0, x19
  104c48: f9405508     	ldr	x8, [x8, #0xa8]
  104c4c: d63f0100     	blr	x8
  104c50: f9008ac0     	str	x0, [x22, #0x110]
  104c54: f9400268     	ldr	x8, [x19]
  104c58: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  104c5c: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104c60: aa0003e1     	mov	x1, x0
  104c64: f9408508     	ldr	x8, [x8, #0x108]
  104c68: 91141042     	add	x2, x2, #0x504
  104c6c: 91142c63     	add	x3, x3, #0x50b
  104c70: aa1303e0     	mov	x0, x19
  104c74: d63f0100     	blr	x8
  104c78: 900031e8     	adrp	x8, 0x740000

## 104c90 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  104c70: aa1303e0     	mov	x0, x19
  104c74: d63f0100     	blr	x8
  104c78: 900031e8     	adrp	x8, 0x740000
  104c7c: f9008d00     	str	x0, [x8, #0x118]
  104c80: f9400268     	ldr	x8, [x19]
  104c84: f9408ac1     	ldr	x1, [x22, #0x110]
  104c88: d00024c2     	adrp	x2, 0x59e000
  104c8c: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104c90: f9408508     	ldr	x8, [x8, #0x108]
  104c94: 91384c42     	add	x2, x2, #0xe13
  104c98: 9138e063     	add	x3, x3, #0xe38
  104c9c: aa1303e0     	mov	x0, x19
  104ca0: d63f0100     	blr	x8
  104ca4: 900031e8     	adrp	x8, 0x740000

## 104cbc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  104c9c: aa1303e0     	mov	x0, x19
  104ca0: d63f0100     	blr	x8
  104ca4: 900031e8     	adrp	x8, 0x740000
  104ca8: f9009100     	str	x0, [x8, #0x120]
  104cac: f9400268     	ldr	x8, [x19]
  104cb0: f9408ac1     	ldr	x1, [x22, #0x110]
  104cb4: b00024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  104cb8: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104cbc: f9408508     	ldr	x8, [x8, #0x108]
  104cc0: 9116ec42     	add	x2, x2, #0x5bb
  104cc4: 91170c63     	add	x3, x3, #0x5c3
  104cc8: aa1303e0     	mov	x0, x19
  104ccc: d63f0100     	blr	x8
  104cd0: 900031e8     	adrp	x8, 0x740000

## 104ce8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  104cc8: aa1303e0     	mov	x0, x19
  104ccc: d63f0100     	blr	x8
  104cd0: 900031e8     	adrp	x8, 0x740000
  104cd4: f9009500     	str	x0, [x8, #0x128]
  104cd8: f9400268     	ldr	x8, [x19]
  104cdc: f9408ac1     	ldr	x1, [x22, #0x110]
  104ce0: d00024c2     	adrp	x2, 0x59e000
  104ce4: d00024c3     	adrp	x3, 0x59e000
  104ce8: f9408508     	ldr	x8, [x8, #0x108]
  104cec: 91387442     	add	x2, x2, #0xe1d
  104cf0: 91389c63     	add	x3, x3, #0xe27
  104cf4: aa1303e0     	mov	x0, x19
  104cf8: d63f0100     	blr	x8
  104cfc: 900031e8     	adrp	x8, 0x740000

## 104d14 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  104cf4: aa1303e0     	mov	x0, x19
  104cf8: d63f0100     	blr	x8
  104cfc: 900031e8     	adrp	x8, 0x740000
  104d00: f9009900     	str	x0, [x8, #0x130]
  104d04: f9400268     	ldr	x8, [x19]
  104d08: f9408ac1     	ldr	x1, [x22, #0x110]
  104d0c: d00024c2     	adrp	x2, 0x59e000
  104d10: b00024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  104d14: f9408508     	ldr	x8, [x8, #0x108]
  104d18: 9138f042     	add	x2, x2, #0xe3c
  104d1c: 91174463     	add	x3, x3, #0x5d1
  104d20: aa1303e0     	mov	x0, x19
  104d24: d63f0100     	blr	x8
  104d28: 900031e8     	adrp	x8, 0x740000

## 105478 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  105458: 913bc442     	add	x2, x2, #0xef1
  10545c: d10223a0     	sub	x0, x29, #0x88
  105460: aa1303e1     	mov	x1, x19
  105464: 9407d7cc     	bl	0x2fb394 <_ZN12JniException14clearExceptionEP7_JNIEnv+0x4c>
  105468: f9400268     	ldr	x8, [x19]
  10546c: f85803a1     	ldur	x1, [x29, #-0x80]
  105470: b00024c2     	adrp	x2, 0x59e000
  105474: 900024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  105478: f9408508     	ldr	x8, [x8, #0x108]
  10547c: 913bfc42     	add	x2, x2, #0xeff
  105480: 911d3063     	add	x3, x3, #0x74c
  105484: aa1303e0     	mov	x0, x19
  105488: d63f0100     	blr	x8
  10548c: aa0003e2     	mov	x2, x0

## 105da4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  105d84: aa1303e0     	mov	x0, x19
  105d88: f9405508     	ldr	x8, [x8, #0xa8]
  105d8c: d63f0100     	blr	x8
  105d90: f900bee0     	str	x0, [x23, #0x178]
  105d94: f9400268     	ldr	x8, [x19]
  105d98: 900024c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  105d9c: 900024c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  105da0: aa0003e1     	mov	x1, x0
  105da4: f9408508     	ldr	x8, [x8, #0x108]
  105da8: 91141042     	add	x2, x2, #0x504
  105dac: 91142c63     	add	x3, x3, #0x50b
  105db0: aa1303e0     	mov	x0, x19
  105db4: d63f0100     	blr	x8
  105db8: f00031c8     	adrp	x8, 0x740000

## 10623c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10621c: d63f0100     	blr	x8
  106220: d00031d8     	adrp	x24, 0x740000
  106224: 91074318     	add	x24, x24, #0x1d0
  106228: f9000300     	str	x0, [x24]
  10622c: f9400268     	ldr	x8, [x19]
  106230: f00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  106234: f00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  106238: aa0003e1     	mov	x1, x0
  10623c: f9408508     	ldr	x8, [x8, #0x108]
  106240: 91141042     	add	x2, x2, #0x504
  106244: 91142c63     	add	x3, x3, #0x50b
  106248: aa1303e0     	mov	x0, x19
  10624c: d63f0100     	blr	x8
  106250: f9000700     	str	x0, [x24, #0x8]

## 10743c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10741c: aa1303e0     	mov	x0, x19
  107420: f9405508     	ldr	x8, [x8, #0xa8]
  107424: d63f0100     	blr	x8
  107428: f9018f00     	str	x0, [x24, #0x318]
  10742c: f9400268     	ldr	x8, [x19]
  107430: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  107434: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  107438: aa0003e1     	mov	x1, x0
  10743c: f9408508     	ldr	x8, [x8, #0x108]
  107440: 91141042     	add	x2, x2, #0x504
  107444: 91142c63     	add	x3, x3, #0x50b
  107448: aa1303e0     	mov	x0, x19
  10744c: d63f0100     	blr	x8
  107450: b00031c8     	adrp	x8, 0x740000

## 1078fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1078dc: aa1303e0     	mov	x0, x19
  1078e0: f9405508     	ldr	x8, [x8, #0xa8]
  1078e4: d63f0100     	blr	x8
  1078e8: f901f300     	str	x0, [x24, #0x3e0]
  1078ec: f9400268     	ldr	x8, [x19]
  1078f0: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1078f4: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1078f8: aa0003e1     	mov	x1, x0
  1078fc: f9408508     	ldr	x8, [x8, #0x108]
  107900: 91141042     	add	x2, x2, #0x504
  107904: 91142c63     	add	x3, x3, #0x50b
  107908: aa1303e0     	mov	x0, x19
  10790c: d63f0100     	blr	x8
  107910: b00031c8     	adrp	x8, 0x740000

## 107eec — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  107ecc: aa1303e0     	mov	x0, x19
  107ed0: f9405508     	ldr	x8, [x8, #0xa8]
  107ed4: d63f0100     	blr	x8
  107ed8: f90252c0     	str	x0, [x22, #0x4a0]
  107edc: f9400268     	ldr	x8, [x19]
  107ee0: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  107ee4: d00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  107ee8: aa0003e1     	mov	x1, x0
  107eec: f9408508     	ldr	x8, [x8, #0x108]
  107ef0: 91141042     	add	x2, x2, #0x504
  107ef4: 91142c63     	add	x3, x3, #0x50b
  107ef8: aa1303e0     	mov	x0, x19
  107efc: d63f0100     	blr	x8
  107f00: b00031c8     	adrp	x8, 0x740000

## 107f70 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  107f50: aa1403e3     	mov	x3, x20
  107f54: d63f0100     	blr	x8
  107f58: b00031c8     	adrp	x8, 0x740000
  107f5c: f9025d00     	str	x0, [x8, #0x4b8]
  107f60: f9400268     	ldr	x8, [x19]
  107f64: f94252c1     	ldr	x1, [x22, #0x4a0]
  107f68: d00024b4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  107f6c: 900024c2     	adrp	x2, 0x59f000
  107f70: f9408508     	ldr	x8, [x8, #0x108]
  107f74: 9138e294     	add	x20, x20, #0xe38
  107f78: 910f3842     	add	x2, x2, #0x3ce
  107f7c: aa1303e0     	mov	x0, x19
  107f80: aa1403e3     	mov	x3, x20
  107f84: d63f0100     	blr	x8

## 107fa0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  107f80: aa1403e3     	mov	x3, x20
  107f84: d63f0100     	blr	x8
  107f88: b00031c8     	adrp	x8, 0x740000
  107f8c: f9026100     	str	x0, [x8, #0x4c0]
  107f90: f9400268     	ldr	x8, [x19]
  107f94: f94252c1     	ldr	x1, [x22, #0x4a0]
  107f98: 900024c2     	adrp	x2, 0x59f000
  107f9c: 910f7042     	add	x2, x2, #0x3dc
  107fa0: f9408508     	ldr	x8, [x8, #0x108]
  107fa4: aa1303e0     	mov	x0, x19
  107fa8: aa1403e3     	mov	x3, x20
  107fac: d63f0100     	blr	x8
  107fb0: b00031c8     	adrp	x8, 0x740000
  107fb4: f9026500     	str	x0, [x8, #0x4c8]

## 108008 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  107fe8: aa1303e0     	mov	x0, x19
  107fec: f9405508     	ldr	x8, [x8, #0xa8]
  107ff0: d63f0100     	blr	x8
  107ff4: f9026ac0     	str	x0, [x22, #0x4d0]
  107ff8: f9400268     	ldr	x8, [x19]
  107ffc: d00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  108000: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108004: aa0003e1     	mov	x1, x0
  108008: f9408508     	ldr	x8, [x8, #0x108]
  10800c: 91141042     	add	x2, x2, #0x504
  108010: 91142c63     	add	x3, x3, #0x50b
  108014: aa1303e0     	mov	x0, x19
  108018: d63f0100     	blr	x8
  10801c: 900031c8     	adrp	x8, 0x740000

## 10852c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10850c: aa1303e0     	mov	x0, x19
  108510: f9405508     	ldr	x8, [x8, #0xa8]
  108514: d63f0100     	blr	x8
  108518: f902bec0     	str	x0, [x22, #0x578]
  10851c: f9400268     	ldr	x8, [x19]
  108520: b00024a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  108524: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108528: aa0003e1     	mov	x1, x0
  10852c: f9408508     	ldr	x8, [x8, #0x108]
  108530: 91141042     	add	x2, x2, #0x504
  108534: 91142c63     	add	x3, x3, #0x50b
  108538: aa1303e0     	mov	x0, x19
  10853c: d63f0100     	blr	x8
  108540: 900031c8     	adrp	x8, 0x740000

## 108558 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108538: aa1303e0     	mov	x0, x19
  10853c: d63f0100     	blr	x8
  108540: 900031c8     	adrp	x8, 0x740000
  108544: f902c100     	str	x0, [x8, #0x580]
  108548: f9400268     	ldr	x8, [x19]
  10854c: f942bec1     	ldr	x1, [x22, #0x578]
  108550: b00024b4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  108554: f00024a2     	adrp	x2, 0x59f000
  108558: f9408508     	ldr	x8, [x8, #0x108]
  10855c: 9138e294     	add	x20, x20, #0xe38
  108560: 91130442     	add	x2, x2, #0x4c1
  108564: aa1303e0     	mov	x0, x19
  108568: aa1403e3     	mov	x3, x20
  10856c: d63f0100     	blr	x8

## 108588 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108568: aa1403e3     	mov	x3, x20
  10856c: d63f0100     	blr	x8
  108570: 900031c8     	adrp	x8, 0x740000
  108574: f902c500     	str	x0, [x8, #0x588]
  108578: f9400268     	ldr	x8, [x19]
  10857c: f942bec1     	ldr	x1, [x22, #0x578]
  108580: f00024a2     	adrp	x2, 0x59f000
  108584: 91134442     	add	x2, x2, #0x4d1
  108588: f9408508     	ldr	x8, [x8, #0x108]
  10858c: aa1303e0     	mov	x0, x19
  108590: aa1403e3     	mov	x3, x20
  108594: d63f0100     	blr	x8
  108598: 900031c8     	adrp	x8, 0x740000
  10859c: f902c900     	str	x0, [x8, #0x590]

## 1085b0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108590: aa1403e3     	mov	x3, x20
  108594: d63f0100     	blr	x8
  108598: 900031c8     	adrp	x8, 0x740000
  10859c: f902c900     	str	x0, [x8, #0x590]
  1085a0: f9400268     	ldr	x8, [x19]
  1085a4: f942bec1     	ldr	x1, [x22, #0x578]
  1085a8: f00024a2     	adrp	x2, 0x59f000
  1085ac: 91137442     	add	x2, x2, #0x4dd
  1085b0: f9408508     	ldr	x8, [x8, #0x108]
  1085b4: aa1303e0     	mov	x0, x19
  1085b8: aa1403e3     	mov	x3, x20
  1085bc: d63f0100     	blr	x8
  1085c0: 900031c8     	adrp	x8, 0x740000
  1085c4: f902cd00     	str	x0, [x8, #0x598]

## 1085d8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1085b8: aa1403e3     	mov	x3, x20
  1085bc: d63f0100     	blr	x8
  1085c0: 900031c8     	adrp	x8, 0x740000
  1085c4: f902cd00     	str	x0, [x8, #0x598]
  1085c8: f9400268     	ldr	x8, [x19]
  1085cc: f942bec1     	ldr	x1, [x22, #0x578]
  1085d0: d00024b4     	adrp	x20, 0x59e000
  1085d4: f00024a2     	adrp	x2, 0x59f000
  1085d8: f9408508     	ldr	x8, [x8, #0x108]
  1085dc: 91389e94     	add	x20, x20, #0xe27
  1085e0: 9113a842     	add	x2, x2, #0x4ea
  1085e4: aa1303e0     	mov	x0, x19
  1085e8: aa1403e3     	mov	x3, x20
  1085ec: d63f0100     	blr	x8

## 108608 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1085e8: aa1403e3     	mov	x3, x20
  1085ec: d63f0100     	blr	x8
  1085f0: 900031c8     	adrp	x8, 0x740000
  1085f4: f902d100     	str	x0, [x8, #0x5a0]
  1085f8: f9400268     	ldr	x8, [x19]
  1085fc: f942bec1     	ldr	x1, [x22, #0x578]
  108600: f00024a2     	adrp	x2, 0x59f000
  108604: 9113e842     	add	x2, x2, #0x4fa
  108608: f9408508     	ldr	x8, [x8, #0x108]
  10860c: aa1303e0     	mov	x0, x19
  108610: aa1403e3     	mov	x3, x20
  108614: d63f0100     	blr	x8
  108618: 900031c8     	adrp	x8, 0x740000
  10861c: f902d500     	str	x0, [x8, #0x5a8]

## 108630 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108610: aa1403e3     	mov	x3, x20
  108614: d63f0100     	blr	x8
  108618: 900031c8     	adrp	x8, 0x740000
  10861c: f902d500     	str	x0, [x8, #0x5a8]
  108620: f9400268     	ldr	x8, [x19]
  108624: f942bec1     	ldr	x1, [x22, #0x578]
  108628: f00024a2     	adrp	x2, 0x59f000
  10862c: 91141842     	add	x2, x2, #0x506
  108630: f9408508     	ldr	x8, [x8, #0x108]
  108634: aa1303e0     	mov	x0, x19
  108638: aa1403e3     	mov	x3, x20
  10863c: d63f0100     	blr	x8
  108640: 900031c8     	adrp	x8, 0x740000
  108644: f902d900     	str	x0, [x8, #0x5b0]

## 108b38 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108b18: 9102a3e0     	add	x0, sp, #0xa8
  108b1c: aa1303e1     	mov	x1, x19
  108b20: f9000be9     	str	x9, [sp, #0x10]
  108b24: 9407ca1c     	bl	0x2fb394 <_ZN12JniException14clearExceptionEP7_JNIEnv+0x4c>
  108b28: f9400268     	ldr	x8, [x19]
  108b2c: f9405bf5     	ldr	x21, [sp, #0xb0]
  108b30: d00024a2     	adrp	x2, 0x59e000
  108b34: d00024a3     	adrp	x3, 0x59e000
  108b38: f9408508     	ldr	x8, [x8, #0x108]
  108b3c: 913ab442     	add	x2, x2, #0xead
  108b40: 913ad063     	add	x3, x3, #0xeb4
  108b44: aa1303e0     	mov	x0, x19
  108b48: aa1503e1     	mov	x1, x21
  108b4c: d63f0100     	blr	x8

## 108b60 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108b40: 913ad063     	add	x3, x3, #0xeb4
  108b44: aa1303e0     	mov	x0, x19
  108b48: aa1503e1     	mov	x1, x21
  108b4c: d63f0100     	blr	x8
  108b50: f9400268     	ldr	x8, [x19]
  108b54: d00024a2     	adrp	x2, 0x59e000
  108b58: d00024a3     	adrp	x3, 0x59e000
  108b5c: aa0003f6     	mov	x22, x0
  108b60: f9408508     	ldr	x8, [x8, #0x108]
  108b64: 913b1842     	add	x2, x2, #0xec6
  108b68: 913b2863     	add	x3, x3, #0xeca
  108b6c: aa1303e0     	mov	x0, x19
  108b70: aa1503e1     	mov	x1, x21
  108b74: d63f0100     	blr	x8

## 108ba0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  108b80: 913bc442     	add	x2, x2, #0xef1
  108b84: 910263e0     	add	x0, sp, #0x98
  108b88: aa1303e1     	mov	x1, x19
  108b8c: 9407ca02     	bl	0x2fb394 <_ZN12JniException14clearExceptionEP7_JNIEnv+0x4c>
  108b90: f9400268     	ldr	x8, [x19]
  108b94: f94053e1     	ldr	x1, [sp, #0xa0]
  108b98: d00024a2     	adrp	x2, 0x59e000
  108b9c: b00024a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  108ba0: f9408508     	ldr	x8, [x8, #0x108]
  108ba4: 913bfc42     	add	x2, x2, #0xeff
  108ba8: 911d3063     	add	x3, x3, #0x74c
  108bac: aa1303e0     	mov	x0, x19
  108bb0: d63f0100     	blr	x8
  108bb4: f9402fe1     	ldr	x1, [sp, #0x58]

## 10b058 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b038: aa1303e0     	mov	x0, x19
  10b03c: aa1403e1     	mov	x1, x20
  10b040: f9407d08     	ldr	x8, [x8, #0xf8]
  10b044: d63f0100     	blr	x8
  10b048: f9400268     	ldr	x8, [x19]
  10b04c: aa0003f5     	mov	x21, x0
  10b050: 900024a2     	adrp	x2, 0x59f000
  10b054: d0002483     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  10b058: f9408508     	ldr	x8, [x8, #0x108]
  10b05c: 91154042     	add	x2, x2, #0x550
  10b060: 91174463     	add	x3, x3, #0x5d1
  10b064: aa1303e0     	mov	x0, x19
  10b068: aa1503e1     	mov	x1, x21
  10b06c: d63f0100     	blr	x8

## 10b134 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b114: f9401908     	ldr	x8, [x8, #0x30]
  10b118: d63f0100     	blr	x8
  10b11c: aa0003f4     	mov	x20, x0
  10b120: b4000600     	cbz	x0, 0x10b1e0 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi+0x7618>
  10b124: f9400268     	ldr	x8, [x19]
  10b128: d0002482     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  10b12c: 900024a3     	adrp	x3, 0x59f000
  10b130: 91141042     	add	x2, x2, #0x504
  10b134: f9408508     	ldr	x8, [x8, #0x108]
  10b138: 91165863     	add	x3, x3, #0x596
  10b13c: aa1303e0     	mov	x0, x19
  10b140: aa1403e1     	mov	x1, x20
  10b144: d63f0100     	blr	x8
  10b148: aa0003f7     	mov	x23, x0

## 10b274 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b254: f9400008     	ldr	x8, [x0]
  10b258: aa0003f3     	mov	x19, x0
  10b25c: f9401908     	ldr	x8, [x8, #0x30]
  10b260: d63f0100     	blr	x8
  10b264: f9400268     	ldr	x8, [x19]
  10b268: aa0003f6     	mov	x22, x0
  10b26c: 900024a2     	adrp	x2, 0x59f000
  10b270: d0002483     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  10b274: f9408508     	ldr	x8, [x8, #0x108]
  10b278: 9109c442     	add	x2, x2, #0x271
  10b27c: 91174463     	add	x3, x3, #0x5d1
  10b280: aa1303e0     	mov	x0, x19
  10b284: aa1603e1     	mov	x1, x22
  10b288: d63f0100     	blr	x8

## 10b29c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b27c: 91174463     	add	x3, x3, #0x5d1
  10b280: aa1303e0     	mov	x0, x19
  10b284: aa1603e1     	mov	x1, x22
  10b288: d63f0100     	blr	x8
  10b28c: f9400268     	ldr	x8, [x19]
  10b290: f0002482     	adrp	x2, 0x59e000
  10b294: 900024a3     	adrp	x3, 0x59f000
  10b298: aa0003f7     	mov	x23, x0
  10b29c: f9408508     	ldr	x8, [x8, #0x108]
  10b2a0: 913b1842     	add	x2, x2, #0xec6
  10b2a4: 91189463     	add	x3, x3, #0x625
  10b2a8: aa1303e0     	mov	x0, x19
  10b2ac: aa1603e1     	mov	x1, x22
  10b2b0: d63f0100     	blr	x8

## 10b438 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b418: 9118ec21     	add	x1, x1, #0x63b
  10b41c: aa0003f3     	mov	x19, x0
  10b420: f9401908     	ldr	x8, [x8, #0x30]
  10b424: d63f0100     	blr	x8
  10b428: f9400268     	ldr	x8, [x19]
  10b42c: 900024a2     	adrp	x2, 0x59f000
  10b430: f0002483     	adrp	x3, 0x59e000
  10b434: aa0003e1     	mov	x1, x0
  10b438: f9408508     	ldr	x8, [x8, #0x108]
  10b43c: 91192442     	add	x2, x2, #0x649
  10b440: 913ad063     	add	x3, x3, #0xeb4
  10b444: aa1303e0     	mov	x0, x19
  10b448: d63f0100     	blr	x8
  10b44c: aa0003e2     	mov	x2, x0

## 10b488 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b468: 913bc421     	add	x1, x1, #0xef1
  10b46c: f9401908     	ldr	x8, [x8, #0x30]
  10b470: aa1303e0     	mov	x0, x19
  10b474: d63f0100     	blr	x8
  10b478: f9400268     	ldr	x8, [x19]
  10b47c: 900024a2     	adrp	x2, 0x59f000
  10b480: 900024a3     	adrp	x3, 0x59f000
  10b484: aa0003e1     	mov	x1, x0
  10b488: f9408508     	ldr	x8, [x8, #0x108]
  10b48c: 91194842     	add	x2, x2, #0x652
  10b490: 91196c63     	add	x3, x3, #0x65b
  10b494: aa1303e0     	mov	x0, x19
  10b498: d63f0100     	blr	x8
  10b49c: aa0003e2     	mov	x2, x0

## 10b4d8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b4b8: 9119c821     	add	x1, x1, #0x672
  10b4bc: f9401908     	ldr	x8, [x8, #0x30]
  10b4c0: aa1303e0     	mov	x0, x19
  10b4c4: d63f0100     	blr	x8
  10b4c8: f9400268     	ldr	x8, [x19]
  10b4cc: aa0003f4     	mov	x20, x0
  10b4d0: 900024a2     	adrp	x2, 0x59f000
  10b4d4: 900024a3     	adrp	x3, 0x59f000
  10b4d8: f9408508     	ldr	x8, [x8, #0x108]
  10b4dc: 911a1442     	add	x2, x2, #0x685
  10b4e0: 911a3463     	add	x3, x3, #0x68d
  10b4e4: aa1303e0     	mov	x0, x19
  10b4e8: aa1403e1     	mov	x1, x20
  10b4ec: d63f0100     	blr	x8

## 10b548 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b528: 911a5821     	add	x1, x1, #0x696
  10b52c: f9401908     	ldr	x8, [x8, #0x30]
  10b530: aa1303e0     	mov	x0, x19
  10b534: d63f0100     	blr	x8
  10b538: f9400268     	ldr	x8, [x19]
  10b53c: aa0003f4     	mov	x20, x0
  10b540: 900024a2     	adrp	x2, 0x59f000
  10b544: 911aa842     	add	x2, x2, #0x6aa
  10b548: f9408508     	ldr	x8, [x8, #0x108]
  10b54c: aa1303e0     	mov	x0, x19
  10b550: aa1403e1     	mov	x1, x20
  10b554: aa1603e3     	mov	x3, x22
  10b558: d63f0100     	blr	x8
  10b55c: f9400268     	ldr	x8, [x19]

## 10b56c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10b54c: aa1303e0     	mov	x0, x19
  10b550: aa1403e1     	mov	x1, x20
  10b554: aa1603e3     	mov	x3, x22
  10b558: d63f0100     	blr	x8
  10b55c: f9400268     	ldr	x8, [x19]
  10b560: 900024a2     	adrp	x2, 0x59f000
  10b564: aa0003f8     	mov	x24, x0
  10b568: 91154042     	add	x2, x2, #0x550
  10b56c: f9408508     	ldr	x8, [x8, #0x108]
  10b570: aa1303e0     	mov	x0, x19
  10b574: aa1403e1     	mov	x1, x20
  10b578: aa1603e3     	mov	x3, x22
  10b57c: d63f0100     	blr	x8
  10b580: aa0003f9     	mov	x25, x0

## 10ba70 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10ba50: aa0003e2     	mov	x2, x0
  10ba54: aa1303e0     	mov	x0, x19
  10ba58: aa1603e1     	mov	x1, x22
  10ba5c: 97ffb90e     	bl	0xf9e94 <JNI_OnUnload+0x1530>
  10ba60: f9400268     	ldr	x8, [x19]
  10ba64: 900024a2     	adrp	x2, 0x59f000
  10ba68: 900024a3     	adrp	x3, 0x59f000
  10ba6c: aa0003f4     	mov	x20, x0
  10ba70: f9408508     	ldr	x8, [x8, #0x108]
  10ba74: 911b1442     	add	x2, x2, #0x6c5
  10ba78: 911b2463     	add	x3, x3, #0x6c9
  10ba7c: aa1303e0     	mov	x0, x19
  10ba80: aa1603e1     	mov	x1, x22
  10ba84: d63f0100     	blr	x8

## 10bbdc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: object-vptr load found but constructor provenance is not established
ASM:
  10bbbc: aa0003e2     	mov	x2, x0
  10bbc0: aa1303e0     	mov	x0, x19
  10bbc4: aa1603e1     	mov	x1, x22
  10bbc8: 97ffb8b3     	bl	0xf9e94 <JNI_OnUnload+0x1530>
  10bbcc: f9400268     	ldr	x8, [x19]
  10bbd0: 900024a2     	adrp	x2, 0x59f000
  10bbd4: 900024a3     	adrp	x3, 0x59f000
  10bbd8: aa0003f4     	mov	x20, x0
  10bbdc: f9408508     	ldr	x8, [x8, #0x108]
  10bbe0: 911b7c42     	add	x2, x2, #0x6df
  10bbe4: 911b8c63     	add	x3, x3, #0x6e3
  10bbe8: aa1303e0     	mov	x0, x19
  10bbec: aa1603e1     	mov	x1, x22
  10bbf0: d63f0100     	blr	x8

## 10dba0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi
Basis: no target-vtable provenance established
ASM:
  10db80: 91009021     	add	x1, x1, #0x24
  10db84: aa1403e0     	mov	x0, x20
  10db88: f9411508     	ldr	x8, [x8, #0x228]
  10db8c: d63f0100     	blr	x8
  10db90: f9400288     	ldr	x8, [x20]
  10db94: b0000001     	adrp	x1, 0x10e000 <_ZN10JavaLogger17java_SetLogOptionEP7_JNIEnvP7_jclassP8_jstringi+0xa438>
  10db98: 9105c021     	add	x1, x1, #0x170
  10db9c: aa1403e0     	mov	x0, x20
  10dba0: f9408508     	ldr	x8, [x8, #0x108]
  10dba4: aa1303e2     	mov	x2, x19
  10dba8: d63f0100     	blr	x8
  10dbac: 90003008     	adrp	x8, 0x70d000 <_ZTVNSt6__ndk115basic_stringbufIcNS_11char_traitsIcEENS_9allocatorIcEEEE+0x40>
  10dbb0: 91356108     	add	x8, x8, #0xd58
  10dbb4: 91004108     	add	x8, x8, #0x10

## 1129bc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11299c: aa1303e0     	mov	x0, x19
  1129a0: f9405508     	ldr	x8, [x8, #0xa8]
  1129a4: d63f0100     	blr	x8
  1129a8: f9039720     	str	x0, [x25, #0x728]
  1129ac: f9400268     	ldr	x8, [x19]
  1129b0: d0002462     	adrp	x2, 0x5a0000
  1129b4: 90002463     	adrp	x3, 0x59e000
  1129b8: aa0003e1     	mov	x1, x0
  1129bc: f9408508     	ldr	x8, [x8, #0x108]
  1129c0: 9109c842     	add	x2, x2, #0x272
  1129c4: 9130dc63     	add	x3, x3, #0xc37
  1129c8: aa1303e0     	mov	x0, x19
  1129cc: d63f0100     	blr	x8
  1129d0: d000317a     	adrp	x26, 0x740000

## 1129ec — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1129cc: d63f0100     	blr	x8
  1129d0: d000317a     	adrp	x26, 0x740000
  1129d4: 911d835a     	add	x26, x26, #0x760
  1129d8: f9000340     	str	x0, [x26]
  1129dc: f9400268     	ldr	x8, [x19]
  1129e0: f9439721     	ldr	x1, [x25, #0x728]
  1129e4: d0002462     	adrp	x2, 0x5a0000
  1129e8: d0002463     	adrp	x3, 0x5a0000
  1129ec: f9408508     	ldr	x8, [x8, #0x108]
  1129f0: 9109e842     	add	x2, x2, #0x27a
  1129f4: 910a0863     	add	x3, x3, #0x282
  1129f8: aa1303e0     	mov	x0, x19
  1129fc: d63f0100     	blr	x8
  112a00: f9000740     	str	x0, [x26, #0x8]

## 112a14 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1129f4: 910a0863     	add	x3, x3, #0x282
  1129f8: aa1303e0     	mov	x0, x19
  1129fc: d63f0100     	blr	x8
  112a00: f9000740     	str	x0, [x26, #0x8]
  112a04: f9400268     	ldr	x8, [x19]
  112a08: f9439721     	ldr	x1, [x25, #0x728]
  112a0c: f0002454     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  112a10: d0002462     	adrp	x2, 0x5a0000
  112a14: f9408508     	ldr	x8, [x8, #0x108]
  112a18: 91142e94     	add	x20, x20, #0x50b
  112a1c: 910aac42     	add	x2, x2, #0x2ab
  112a20: aa1303e0     	mov	x0, x19
  112a24: aa1403e3     	mov	x3, x20
  112a28: d63f0100     	blr	x8

## 112a40 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112a20: aa1303e0     	mov	x0, x19
  112a24: aa1403e3     	mov	x3, x20
  112a28: d63f0100     	blr	x8
  112a2c: f9000b40     	str	x0, [x26, #0x10]
  112a30: f9400268     	ldr	x8, [x19]
  112a34: f9439721     	ldr	x1, [x25, #0x728]
  112a38: d0002462     	adrp	x2, 0x5a0000
  112a3c: 910ad442     	add	x2, x2, #0x2b5
  112a40: f9408508     	ldr	x8, [x8, #0x108]
  112a44: aa1303e0     	mov	x0, x19
  112a48: aa1403e3     	mov	x3, x20
  112a4c: d63f0100     	blr	x8
  112a50: f9000f40     	str	x0, [x26, #0x18]
  112a54: f9400268     	ldr	x8, [x19]

## 112a64 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112a44: aa1303e0     	mov	x0, x19
  112a48: aa1403e3     	mov	x3, x20
  112a4c: d63f0100     	blr	x8
  112a50: f9000f40     	str	x0, [x26, #0x18]
  112a54: f9400268     	ldr	x8, [x19]
  112a58: f9439721     	ldr	x1, [x25, #0x728]
  112a5c: d0002462     	adrp	x2, 0x5a0000
  112a60: 910b0042     	add	x2, x2, #0x2c0
  112a64: f9408508     	ldr	x8, [x8, #0x108]
  112a68: aa1303e0     	mov	x0, x19
  112a6c: aa1403e3     	mov	x3, x20
  112a70: d63f0100     	blr	x8
  112a74: f9001340     	str	x0, [x26, #0x20]
  112a78: f9400268     	ldr	x8, [x19]

## 112a88 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112a68: aa1303e0     	mov	x0, x19
  112a6c: aa1403e3     	mov	x3, x20
  112a70: d63f0100     	blr	x8
  112a74: f9001340     	str	x0, [x26, #0x20]
  112a78: f9400268     	ldr	x8, [x19]
  112a7c: f9439721     	ldr	x1, [x25, #0x728]
  112a80: d0002462     	adrp	x2, 0x5a0000
  112a84: 910b3442     	add	x2, x2, #0x2cd
  112a88: f9408508     	ldr	x8, [x8, #0x108]
  112a8c: aa1303e0     	mov	x0, x19
  112a90: aa1403e3     	mov	x3, x20
  112a94: d63f0100     	blr	x8
  112a98: f9001740     	str	x0, [x26, #0x28]
  112a9c: f9400268     	ldr	x8, [x19]

## 112aac — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112a8c: aa1303e0     	mov	x0, x19
  112a90: aa1403e3     	mov	x3, x20
  112a94: d63f0100     	blr	x8
  112a98: f9001740     	str	x0, [x26, #0x28]
  112a9c: f9400268     	ldr	x8, [x19]
  112aa0: f9439721     	ldr	x1, [x25, #0x728]
  112aa4: d0002475     	adrp	x21, 0x5a0000
  112aa8: d0002462     	adrp	x2, 0x5a0000
  112aac: f9408508     	ldr	x8, [x8, #0x108]
  112ab0: 910bc6b5     	add	x21, x21, #0x2f1
  112ab4: 910b6842     	add	x2, x2, #0x2da
  112ab8: aa1303e0     	mov	x0, x19
  112abc: aa1503e3     	mov	x3, x21
  112ac0: d63f0100     	blr	x8

## 112ad8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112ab8: aa1303e0     	mov	x0, x19
  112abc: aa1503e3     	mov	x3, x21
  112ac0: d63f0100     	blr	x8
  112ac4: f9009b40     	str	x0, [x26, #0x130]
  112ac8: f9400268     	ldr	x8, [x19]
  112acc: f9439721     	ldr	x1, [x25, #0x728]
  112ad0: d0002462     	adrp	x2, 0x5a0000
  112ad4: 910bd842     	add	x2, x2, #0x2f6
  112ad8: f9408508     	ldr	x8, [x8, #0x108]
  112adc: aa1303e0     	mov	x0, x19
  112ae0: aa1503e3     	mov	x3, x21
  112ae4: d63f0100     	blr	x8
  112ae8: f9009f40     	str	x0, [x26, #0x138]
  112aec: f9400268     	ldr	x8, [x19]

## 112afc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112adc: aa1303e0     	mov	x0, x19
  112ae0: aa1503e3     	mov	x3, x21
  112ae4: d63f0100     	blr	x8
  112ae8: f9009f40     	str	x0, [x26, #0x138]
  112aec: f9400268     	ldr	x8, [x19]
  112af0: f9439721     	ldr	x1, [x25, #0x728]
  112af4: d0002462     	adrp	x2, 0x5a0000
  112af8: 910c1842     	add	x2, x2, #0x306
  112afc: f9408508     	ldr	x8, [x8, #0x108]
  112b00: aa1303e0     	mov	x0, x19
  112b04: aa1503e3     	mov	x3, x21
  112b08: d63f0100     	blr	x8
  112b0c: f900a340     	str	x0, [x26, #0x140]
  112b10: f9400268     	ldr	x8, [x19]

## 112b20 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112b00: aa1303e0     	mov	x0, x19
  112b04: aa1503e3     	mov	x3, x21
  112b08: d63f0100     	blr	x8
  112b0c: f900a340     	str	x0, [x26, #0x140]
  112b10: f9400268     	ldr	x8, [x19]
  112b14: f9439721     	ldr	x1, [x25, #0x728]
  112b18: d0002462     	adrp	x2, 0x5a0000
  112b1c: 910c5c42     	add	x2, x2, #0x317
  112b20: f9408508     	ldr	x8, [x8, #0x108]
  112b24: aa1303e0     	mov	x0, x19
  112b28: aa1403e3     	mov	x3, x20
  112b2c: d63f0100     	blr	x8
  112b30: f9001b40     	str	x0, [x26, #0x30]
  112b34: f9400268     	ldr	x8, [x19]

## 112b44 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112b24: aa1303e0     	mov	x0, x19
  112b28: aa1403e3     	mov	x3, x20
  112b2c: d63f0100     	blr	x8
  112b30: f9001b40     	str	x0, [x26, #0x30]
  112b34: f9400268     	ldr	x8, [x19]
  112b38: f9439721     	ldr	x1, [x25, #0x728]
  112b3c: d0002462     	adrp	x2, 0x5a0000
  112b40: d0002463     	adrp	x3, 0x5a0000
  112b44: f9408508     	ldr	x8, [x8, #0x108]
  112b48: 910c9442     	add	x2, x2, #0x325
  112b4c: 910cd063     	add	x3, x3, #0x334
  112b50: aa1303e0     	mov	x0, x19
  112b54: d63f0100     	blr	x8
  112b58: f9002340     	str	x0, [x26, #0x40]

## 112b6c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112b4c: 910cd063     	add	x3, x3, #0x334
  112b50: aa1303e0     	mov	x0, x19
  112b54: d63f0100     	blr	x8
  112b58: f9002340     	str	x0, [x26, #0x40]
  112b5c: f9400268     	ldr	x8, [x19]
  112b60: f9439721     	ldr	x1, [x25, #0x728]
  112b64: d0002462     	adrp	x2, 0x5a0000
  112b68: 910d7842     	add	x2, x2, #0x35e
  112b6c: f9408508     	ldr	x8, [x8, #0x108]
  112b70: aa1303e0     	mov	x0, x19
  112b74: aa1403e3     	mov	x3, x20
  112b78: d63f0100     	blr	x8
  112b7c: f9001f40     	str	x0, [x26, #0x38]
  112b80: f9400268     	ldr	x8, [x19]

## 112b90 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112b70: aa1303e0     	mov	x0, x19
  112b74: aa1403e3     	mov	x3, x20
  112b78: d63f0100     	blr	x8
  112b7c: f9001f40     	str	x0, [x26, #0x38]
  112b80: f9400268     	ldr	x8, [x19]
  112b84: f9439721     	ldr	x1, [x25, #0x728]
  112b88: d0002462     	adrp	x2, 0x5a0000
  112b8c: d0002463     	adrp	x3, 0x5a0000
  112b90: f9408508     	ldr	x8, [x8, #0x108]
  112b94: 910db442     	add	x2, x2, #0x36d
  112b98: 910df063     	add	x3, x3, #0x37c
  112b9c: aa1303e0     	mov	x0, x19
  112ba0: d63f0100     	blr	x8
  112ba4: f9002740     	str	x0, [x26, #0x48]

## 112bb8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112b98: 910df063     	add	x3, x3, #0x37c
  112b9c: aa1303e0     	mov	x0, x19
  112ba0: d63f0100     	blr	x8
  112ba4: f9002740     	str	x0, [x26, #0x48]
  112ba8: f9400268     	ldr	x8, [x19]
  112bac: f9439721     	ldr	x1, [x25, #0x728]
  112bb0: 90002476     	adrp	x22, 0x59e000
  112bb4: d0002462     	adrp	x2, 0x5a0000
  112bb8: f9408508     	ldr	x8, [x8, #0x108]
  112bbc: 911b0ed6     	add	x22, x22, #0x6c3
  112bc0: 910e0842     	add	x2, x2, #0x382
  112bc4: aa1303e0     	mov	x0, x19
  112bc8: aa1603e3     	mov	x3, x22
  112bcc: d63f0100     	blr	x8

## 112be4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112bc4: aa1303e0     	mov	x0, x19
  112bc8: aa1603e3     	mov	x3, x22
  112bcc: d63f0100     	blr	x8
  112bd0: f9002b40     	str	x0, [x26, #0x50]
  112bd4: f9400268     	ldr	x8, [x19]
  112bd8: f9439721     	ldr	x1, [x25, #0x728]
  112bdc: d0002462     	adrp	x2, 0x5a0000
  112be0: 910e5442     	add	x2, x2, #0x395
  112be4: f9408508     	ldr	x8, [x8, #0x108]
  112be8: aa1303e0     	mov	x0, x19
  112bec: aa1603e3     	mov	x3, x22
  112bf0: d63f0100     	blr	x8
  112bf4: f9002f40     	str	x0, [x26, #0x58]
  112bf8: f9400268     	ldr	x8, [x19]

## 112c08 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112be8: aa1303e0     	mov	x0, x19
  112bec: aa1603e3     	mov	x3, x22
  112bf0: d63f0100     	blr	x8
  112bf4: f9002f40     	str	x0, [x26, #0x58]
  112bf8: f9400268     	ldr	x8, [x19]
  112bfc: f9439721     	ldr	x1, [x25, #0x728]
  112c00: d0002462     	adrp	x2, 0x5a0000
  112c04: 910eb442     	add	x2, x2, #0x3ad
  112c08: f9408508     	ldr	x8, [x8, #0x108]
  112c0c: aa1303e0     	mov	x0, x19
  112c10: aa1603e3     	mov	x3, x22
  112c14: d63f0100     	blr	x8
  112c18: f9003340     	str	x0, [x26, #0x60]
  112c1c: f9400268     	ldr	x8, [x19]

## 112c2c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112c0c: aa1303e0     	mov	x0, x19
  112c10: aa1603e3     	mov	x3, x22
  112c14: d63f0100     	blr	x8
  112c18: f9003340     	str	x0, [x26, #0x60]
  112c1c: f9400268     	ldr	x8, [x19]
  112c20: f9439721     	ldr	x1, [x25, #0x728]
  112c24: 90002476     	adrp	x22, 0x59e000
  112c28: d0002462     	adrp	x2, 0x5a0000
  112c2c: f9408508     	ldr	x8, [x8, #0x108]
  112c30: 911b6ad6     	add	x22, x22, #0x6da
  112c34: 910ef842     	add	x2, x2, #0x3be
  112c38: aa1303e0     	mov	x0, x19
  112c3c: aa1603e3     	mov	x3, x22
  112c40: d63f0100     	blr	x8

## 112c58 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112c38: aa1303e0     	mov	x0, x19
  112c3c: aa1603e3     	mov	x3, x22
  112c40: d63f0100     	blr	x8
  112c44: f9003740     	str	x0, [x26, #0x68]
  112c48: f9400268     	ldr	x8, [x19]
  112c4c: f9439721     	ldr	x1, [x25, #0x728]
  112c50: d0002477     	adrp	x23, 0x5a0000
  112c54: d0002462     	adrp	x2, 0x5a0000
  112c58: f9408508     	ldr	x8, [x8, #0x108]
  112c5c: 910f7af7     	add	x23, x23, #0x3de
  112c60: 910f3842     	add	x2, x2, #0x3ce
  112c64: aa1303e0     	mov	x0, x19
  112c68: aa1703e3     	mov	x3, x23
  112c6c: d63f0100     	blr	x8

## 112c84 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112c64: aa1303e0     	mov	x0, x19
  112c68: aa1703e3     	mov	x3, x23
  112c6c: d63f0100     	blr	x8
  112c70: f9003f40     	str	x0, [x26, #0x78]
  112c74: f9400268     	ldr	x8, [x19]
  112c78: f9439721     	ldr	x1, [x25, #0x728]
  112c7c: d0002462     	adrp	x2, 0x5a0000
  112c80: 91102c42     	add	x2, x2, #0x40b
  112c84: f9408508     	ldr	x8, [x8, #0x108]
  112c88: aa1303e0     	mov	x0, x19
  112c8c: aa1703e3     	mov	x3, x23
  112c90: d63f0100     	blr	x8
  112c94: f9004340     	str	x0, [x26, #0x80]
  112c98: f9400268     	ldr	x8, [x19]

## 112ca8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112c88: aa1303e0     	mov	x0, x19
  112c8c: aa1703e3     	mov	x3, x23
  112c90: d63f0100     	blr	x8
  112c94: f9004340     	str	x0, [x26, #0x80]
  112c98: f9400268     	ldr	x8, [x19]
  112c9c: f9439721     	ldr	x1, [x25, #0x728]
  112ca0: d0002462     	adrp	x2, 0x5a0000
  112ca4: d0002463     	adrp	x3, 0x5a0000
  112ca8: f9408508     	ldr	x8, [x8, #0x108]
  112cac: 91107842     	add	x2, x2, #0x41e
  112cb0: 9110c463     	add	x3, x3, #0x431
  112cb4: aa1303e0     	mov	x0, x19
  112cb8: d63f0100     	blr	x8
  112cbc: f9004740     	str	x0, [x26, #0x88]

## 112cd0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112cb0: 9110c463     	add	x3, x3, #0x431
  112cb4: aa1303e0     	mov	x0, x19
  112cb8: d63f0100     	blr	x8
  112cbc: f9004740     	str	x0, [x26, #0x88]
  112cc0: f9400268     	ldr	x8, [x19]
  112cc4: f9439721     	ldr	x1, [x25, #0x728]
  112cc8: d0002462     	adrp	x2, 0x5a0000
  112ccc: 91117c42     	add	x2, x2, #0x45f
  112cd0: f9408508     	ldr	x8, [x8, #0x108]
  112cd4: aa1303e0     	mov	x0, x19
  112cd8: aa1503e3     	mov	x3, x21
  112cdc: d63f0100     	blr	x8
  112ce0: f9004f40     	str	x0, [x26, #0x98]
  112ce4: f9400268     	ldr	x8, [x19]

## 112cf4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112cd4: aa1303e0     	mov	x0, x19
  112cd8: aa1503e3     	mov	x3, x21
  112cdc: d63f0100     	blr	x8
  112ce0: f9004f40     	str	x0, [x26, #0x98]
  112ce4: f9400268     	ldr	x8, [x19]
  112ce8: f9439721     	ldr	x1, [x25, #0x728]
  112cec: d0002462     	adrp	x2, 0x5a0000
  112cf0: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112cf4: f9408508     	ldr	x8, [x8, #0x108]
  112cf8: 9111c042     	add	x2, x2, #0x470
  112cfc: 91152c63     	add	x3, x3, #0x54b
  112d00: aa1303e0     	mov	x0, x19
  112d04: d63f0100     	blr	x8
  112d08: d0003168     	adrp	x8, 0x740000

## 112d20 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112d00: aa1303e0     	mov	x0, x19
  112d04: d63f0100     	blr	x8
  112d08: d0003168     	adrp	x8, 0x740000
  112d0c: f9039900     	str	x0, [x8, #0x730]
  112d10: f9400268     	ldr	x8, [x19]
  112d14: f9439721     	ldr	x1, [x25, #0x728]
  112d18: d0002462     	adrp	x2, 0x5a0000
  112d1c: 91120442     	add	x2, x2, #0x481
  112d20: f9408508     	ldr	x8, [x8, #0x108]
  112d24: aa1303e0     	mov	x0, x19
  112d28: aa1403e3     	mov	x3, x20
  112d2c: d63f0100     	blr	x8
  112d30: f9005340     	str	x0, [x26, #0xa0]
  112d34: f9400268     	ldr	x8, [x19]

## 112d44 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112d24: aa1303e0     	mov	x0, x19
  112d28: aa1403e3     	mov	x3, x20
  112d2c: d63f0100     	blr	x8
  112d30: f9005340     	str	x0, [x26, #0xa0]
  112d34: f9400268     	ldr	x8, [x19]
  112d38: f9439721     	ldr	x1, [x25, #0x728]
  112d3c: d0002462     	adrp	x2, 0x5a0000
  112d40: d0002463     	adrp	x3, 0x5a0000
  112d44: f9408508     	ldr	x8, [x8, #0x108]
  112d48: 91124842     	add	x2, x2, #0x492
  112d4c: 91129063     	add	x3, x3, #0x4a4
  112d50: aa1303e0     	mov	x0, x19
  112d54: d63f0100     	blr	x8
  112d58: f9005740     	str	x0, [x26, #0xa8]

## 112d6c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112d4c: 91129063     	add	x3, x3, #0x4a4
  112d50: aa1303e0     	mov	x0, x19
  112d54: d63f0100     	blr	x8
  112d58: f9005740     	str	x0, [x26, #0xa8]
  112d5c: f9400268     	ldr	x8, [x19]
  112d60: f9439721     	ldr	x1, [x25, #0x728]
  112d64: d0002462     	adrp	x2, 0x5a0000
  112d68: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112d6c: f9408508     	ldr	x8, [x8, #0x108]
  112d70: 9112a442     	add	x2, x2, #0x4a9
  112d74: 91170c63     	add	x3, x3, #0x5c3
  112d78: aa1303e0     	mov	x0, x19
  112d7c: d63f0100     	blr	x8
  112d80: f9005b40     	str	x0, [x26, #0xb0]

## 112d94 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112d74: 91170c63     	add	x3, x3, #0x5c3
  112d78: aa1303e0     	mov	x0, x19
  112d7c: d63f0100     	blr	x8
  112d80: f9005b40     	str	x0, [x26, #0xb0]
  112d84: f9400268     	ldr	x8, [x19]
  112d88: f9439721     	ldr	x1, [x25, #0x728]
  112d8c: d0002462     	adrp	x2, 0x5a0000
  112d90: 9112e842     	add	x2, x2, #0x4ba
  112d94: f9408508     	ldr	x8, [x8, #0x108]
  112d98: aa1303e0     	mov	x0, x19
  112d9c: aa1403e3     	mov	x3, x20
  112da0: d63f0100     	blr	x8
  112da4: f9005f40     	str	x0, [x26, #0xb8]
  112da8: f9400268     	ldr	x8, [x19]

## 112db8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112d98: aa1303e0     	mov	x0, x19
  112d9c: aa1403e3     	mov	x3, x20
  112da0: d63f0100     	blr	x8
  112da4: f9005f40     	str	x0, [x26, #0xb8]
  112da8: f9400268     	ldr	x8, [x19]
  112dac: f9439721     	ldr	x1, [x25, #0x728]
  112db0: d0002462     	adrp	x2, 0x5a0000
  112db4: d0002463     	adrp	x3, 0x5a0000
  112db8: f9408508     	ldr	x8, [x8, #0x108]
  112dbc: 91132442     	add	x2, x2, #0x4c9
  112dc0: 91136063     	add	x3, x3, #0x4d8
  112dc4: aa1303e0     	mov	x0, x19
  112dc8: d63f0100     	blr	x8
  112dcc: f9006340     	str	x0, [x26, #0xc0]

## 112de0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112dc0: 91136063     	add	x3, x3, #0x4d8
  112dc4: aa1303e0     	mov	x0, x19
  112dc8: d63f0100     	blr	x8
  112dcc: f9006340     	str	x0, [x26, #0xc0]
  112dd0: f9400268     	ldr	x8, [x19]
  112dd4: f9439721     	ldr	x1, [x25, #0x728]
  112dd8: d0002462     	adrp	x2, 0x5a0000
  112ddc: d0002463     	adrp	x3, 0x5a0000
  112de0: f9408508     	ldr	x8, [x8, #0x108]
  112de4: 91142442     	add	x2, x2, #0x509
  112de8: 91147063     	add	x3, x3, #0x51c
  112dec: aa1303e0     	mov	x0, x19
  112df0: d63f0100     	blr	x8
  112df4: f9006740     	str	x0, [x26, #0xc8]

## 112e08 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112de8: 91147063     	add	x3, x3, #0x51c
  112dec: aa1303e0     	mov	x0, x19
  112df0: d63f0100     	blr	x8
  112df4: f9006740     	str	x0, [x26, #0xc8]
  112df8: f9400268     	ldr	x8, [x19]
  112dfc: f9439721     	ldr	x1, [x25, #0x728]
  112e00: d0002462     	adrp	x2, 0x5a0000
  112e04: 91157042     	add	x2, x2, #0x55c
  112e08: f9408508     	ldr	x8, [x8, #0x108]
  112e0c: aa1303e0     	mov	x0, x19
  112e10: aa1603e3     	mov	x3, x22
  112e14: d63f0100     	blr	x8
  112e18: f9006b40     	str	x0, [x26, #0xd0]
  112e1c: f9400268     	ldr	x8, [x19]

## 112e2c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112e0c: aa1303e0     	mov	x0, x19
  112e10: aa1603e3     	mov	x3, x22
  112e14: d63f0100     	blr	x8
  112e18: f9006b40     	str	x0, [x26, #0xd0]
  112e1c: f9400268     	ldr	x8, [x19]
  112e20: f9439721     	ldr	x1, [x25, #0x728]
  112e24: d0002462     	adrp	x2, 0x5a0000
  112e28: d0002463     	adrp	x3, 0x5a0000
  112e2c: f9408508     	ldr	x8, [x8, #0x108]
  112e30: 9115bc42     	add	x2, x2, #0x56f
  112e34: 9115fc63     	add	x3, x3, #0x57f
  112e38: aa1303e0     	mov	x0, x19
  112e3c: d63f0100     	blr	x8
  112e40: f9006f40     	str	x0, [x26, #0xd8]

## 112e54 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112e34: 9115fc63     	add	x3, x3, #0x57f
  112e38: aa1303e0     	mov	x0, x19
  112e3c: d63f0100     	blr	x8
  112e40: f9006f40     	str	x0, [x26, #0xd8]
  112e44: f9400268     	ldr	x8, [x19]
  112e48: f9439721     	ldr	x1, [x25, #0x728]
  112e4c: d0002462     	adrp	x2, 0x5a0000
  112e50: d0002463     	adrp	x3, 0x5a0000
  112e54: f9408508     	ldr	x8, [x8, #0x108]
  112e58: 91161442     	add	x2, x2, #0x585
  112e5c: 91166c63     	add	x3, x3, #0x59b
  112e60: aa1303e0     	mov	x0, x19
  112e64: d63f0100     	blr	x8
  112e68: f9007340     	str	x0, [x26, #0xe0]

## 112e7c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112e5c: 91166c63     	add	x3, x3, #0x59b
  112e60: aa1303e0     	mov	x0, x19
  112e64: d63f0100     	blr	x8
  112e68: f9007340     	str	x0, [x26, #0xe0]
  112e6c: f9400268     	ldr	x8, [x19]
  112e70: f9439721     	ldr	x1, [x25, #0x728]
  112e74: d0002462     	adrp	x2, 0x5a0000
  112e78: b0002463     	adrp	x3, 0x59f000
  112e7c: f9408508     	ldr	x8, [x8, #0x108]
  112e80: 91172042     	add	x2, x2, #0x5c8
  112e84: 911de063     	add	x3, x3, #0x778
  112e88: aa1303e0     	mov	x0, x19
  112e8c: d63f0100     	blr	x8
  112e90: f9007740     	str	x0, [x26, #0xe8]

## 112ea4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112e84: 911de063     	add	x3, x3, #0x778
  112e88: aa1303e0     	mov	x0, x19
  112e8c: d63f0100     	blr	x8
  112e90: f9007740     	str	x0, [x26, #0xe8]
  112e94: f9400268     	ldr	x8, [x19]
  112e98: f9439721     	ldr	x1, [x25, #0x728]
  112e9c: d0002462     	adrp	x2, 0x5a0000
  112ea0: 90002463     	adrp	x3, 0x59e000
  112ea4: f9408508     	ldr	x8, [x8, #0x108]
  112ea8: 91178042     	add	x2, x2, #0x5e0
  112eac: 91272063     	add	x3, x3, #0x9c8
  112eb0: aa1303e0     	mov	x0, x19
  112eb4: d63f0100     	blr	x8
  112eb8: f9007b40     	str	x0, [x26, #0xf0]

## 112ecc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112eac: 91272063     	add	x3, x3, #0x9c8
  112eb0: aa1303e0     	mov	x0, x19
  112eb4: d63f0100     	blr	x8
  112eb8: f9007b40     	str	x0, [x26, #0xf0]
  112ebc: f9400268     	ldr	x8, [x19]
  112ec0: f9439721     	ldr	x1, [x25, #0x728]
  112ec4: d0002462     	adrp	x2, 0x5a0000
  112ec8: 9117c842     	add	x2, x2, #0x5f2
  112ecc: f9408508     	ldr	x8, [x8, #0x108]
  112ed0: aa1303e0     	mov	x0, x19
  112ed4: aa1503e3     	mov	x3, x21
  112ed8: d63f0100     	blr	x8
  112edc: f9007f40     	str	x0, [x26, #0xf8]
  112ee0: f9400268     	ldr	x8, [x19]

## 112ef0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112ed0: aa1303e0     	mov	x0, x19
  112ed4: aa1503e3     	mov	x3, x21
  112ed8: d63f0100     	blr	x8
  112edc: f9007f40     	str	x0, [x26, #0xf8]
  112ee0: f9400268     	ldr	x8, [x19]
  112ee4: f9439721     	ldr	x1, [x25, #0x728]
  112ee8: d0002462     	adrp	x2, 0x5a0000
  112eec: 91182c42     	add	x2, x2, #0x60b
  112ef0: f9408508     	ldr	x8, [x8, #0x108]
  112ef4: aa1303e0     	mov	x0, x19
  112ef8: aa1503e3     	mov	x3, x21
  112efc: d63f0100     	blr	x8
  112f00: f9008340     	str	x0, [x26, #0x100]
  112f04: f9400268     	ldr	x8, [x19]

## 112f14 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112ef4: aa1303e0     	mov	x0, x19
  112ef8: aa1503e3     	mov	x3, x21
  112efc: d63f0100     	blr	x8
  112f00: f9008340     	str	x0, [x26, #0x100]
  112f04: f9400268     	ldr	x8, [x19]
  112f08: f9439721     	ldr	x1, [x25, #0x728]
  112f0c: d0002462     	adrp	x2, 0x5a0000
  112f10: d0002463     	adrp	x3, 0x5a0000
  112f14: f9408508     	ldr	x8, [x8, #0x108]
  112f18: 91188c42     	add	x2, x2, #0x623
  112f1c: 9118cc63     	add	x3, x3, #0x633
  112f20: aa1303e0     	mov	x0, x19
  112f24: d63f0100     	blr	x8
  112f28: f9004b40     	str	x0, [x26, #0x90]

## 112f3c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112f1c: 9118cc63     	add	x3, x3, #0x633
  112f20: aa1303e0     	mov	x0, x19
  112f24: d63f0100     	blr	x8
  112f28: f9004b40     	str	x0, [x26, #0x90]
  112f2c: f9400268     	ldr	x8, [x19]
  112f30: f9439721     	ldr	x1, [x25, #0x728]
  112f34: d0002462     	adrp	x2, 0x5a0000
  112f38: 9118ec42     	add	x2, x2, #0x63b
  112f3c: f9408508     	ldr	x8, [x8, #0x108]
  112f40: aa1303e0     	mov	x0, x19
  112f44: aa1403e3     	mov	x3, x20
  112f48: d63f0100     	blr	x8
  112f4c: f9003b40     	str	x0, [x26, #0x70]
  112f50: f9400268     	ldr	x8, [x19]

## 112f88 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112f68: 91197c63     	add	x3, x3, #0x65f
  112f6c: aa1303e0     	mov	x0, x19
  112f70: d63f0100     	blr	x8
  112f74: f9008740     	str	x0, [x26, #0x108]
  112f78: f9400268     	ldr	x8, [x19]
  112f7c: f9439721     	ldr	x1, [x25, #0x728]
  112f80: d0002474     	adrp	x20, 0x5a0000
  112f84: d0002462     	adrp	x2, 0x5a0000
  112f88: f9408508     	ldr	x8, [x8, #0x108]
  112f8c: 911ab294     	add	x20, x20, #0x6ac
  112f90: 911a6042     	add	x2, x2, #0x698
  112f94: aa1303e0     	mov	x0, x19
  112f98: aa1403e3     	mov	x3, x20
  112f9c: d63f0100     	blr	x8

## 112fb4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112f94: aa1303e0     	mov	x0, x19
  112f98: aa1403e3     	mov	x3, x20
  112f9c: d63f0100     	blr	x8
  112fa0: f9008b40     	str	x0, [x26, #0x110]
  112fa4: f9400268     	ldr	x8, [x19]
  112fa8: f9439721     	ldr	x1, [x25, #0x728]
  112fac: d0002462     	adrp	x2, 0x5a0000
  112fb0: f0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  112fb4: f9408508     	ldr	x8, [x8, #0x108]
  112fb8: 911ac442     	add	x2, x2, #0x6b1
  112fbc: 9138e063     	add	x3, x3, #0xe38
  112fc0: aa1303e0     	mov	x0, x19
  112fc4: d63f0100     	blr	x8
  112fc8: f9008f40     	str	x0, [x26, #0x118]

## 112fdc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112fbc: 9138e063     	add	x3, x3, #0xe38
  112fc0: aa1303e0     	mov	x0, x19
  112fc4: d63f0100     	blr	x8
  112fc8: f9008f40     	str	x0, [x26, #0x118]
  112fcc: f9400268     	ldr	x8, [x19]
  112fd0: f9439721     	ldr	x1, [x25, #0x728]
  112fd4: d0002475     	adrp	x21, 0x5a0000
  112fd8: d0002462     	adrp	x2, 0x5a0000
  112fdc: f9408508     	ldr	x8, [x8, #0x108]
  112fe0: 911b5eb5     	add	x21, x21, #0x6d7
  112fe4: 911b1842     	add	x2, x2, #0x6c6
  112fe8: aa1303e0     	mov	x0, x19
  112fec: aa1503e3     	mov	x3, x21
  112ff0: d63f0100     	blr	x8

## 113008 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  112fe8: aa1303e0     	mov	x0, x19
  112fec: aa1503e3     	mov	x3, x21
  112ff0: d63f0100     	blr	x8
  112ff4: f9009340     	str	x0, [x26, #0x120]
  112ff8: f9400268     	ldr	x8, [x19]
  112ffc: f9439721     	ldr	x1, [x25, #0x728]
  113000: b0002462     	adrp	x2, 0x5a0000
  113004: 911bc042     	add	x2, x2, #0x6f0
  113008: f9408508     	ldr	x8, [x8, #0x108]
  11300c: aa1303e0     	mov	x0, x19
  113010: aa1503e3     	mov	x3, x21
  113014: d63f0100     	blr	x8
  113018: f9009740     	str	x0, [x26, #0x128]
  11301c: f9400268     	ldr	x8, [x19]

## 11302c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11300c: aa1303e0     	mov	x0, x19
  113010: aa1503e3     	mov	x3, x21
  113014: d63f0100     	blr	x8
  113018: f9009740     	str	x0, [x26, #0x128]
  11301c: f9400268     	ldr	x8, [x19]
  113020: f9439721     	ldr	x1, [x25, #0x728]
  113024: 90002475     	adrp	x21, 0x59f000
  113028: b0002462     	adrp	x2, 0x5a0000
  11302c: f9408508     	ldr	x8, [x8, #0x108]
  113030: 911b26b5     	add	x21, x21, #0x6c9
  113034: 911bec42     	add	x2, x2, #0x6fb
  113038: aa1303e0     	mov	x0, x19
  11303c: aa1503e3     	mov	x3, x21
  113040: d63f0100     	blr	x8

## 113058 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  113038: aa1303e0     	mov	x0, x19
  11303c: aa1503e3     	mov	x3, x21
  113040: d63f0100     	blr	x8
  113044: f900a740     	str	x0, [x26, #0x148]
  113048: f9400268     	ldr	x8, [x19]
  11304c: f9439721     	ldr	x1, [x25, #0x728]
  113050: b0002462     	adrp	x2, 0x5a0000
  113054: 911c6042     	add	x2, x2, #0x718
  113058: f9408508     	ldr	x8, [x8, #0x108]
  11305c: aa1303e0     	mov	x0, x19
  113060: aa1503e3     	mov	x3, x21
  113064: d63f0100     	blr	x8
  113068: f900ab40     	str	x0, [x26, #0x150]
  11306c: f9400268     	ldr	x8, [x19]

## 11307c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11305c: aa1303e0     	mov	x0, x19
  113060: aa1503e3     	mov	x3, x21
  113064: d63f0100     	blr	x8
  113068: f900ab40     	str	x0, [x26, #0x150]
  11306c: f9400268     	ldr	x8, [x19]
  113070: f9439721     	ldr	x1, [x25, #0x728]
  113074: b0002462     	adrp	x2, 0x5a0000
  113078: d0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  11307c: f9408508     	ldr	x8, [x8, #0x108]
  113080: 911ce042     	add	x2, x2, #0x738
  113084: 91158463     	add	x3, x3, #0x561
  113088: aa1303e0     	mov	x0, x19
  11308c: d63f0100     	blr	x8
  113090: f900af40     	str	x0, [x26, #0x158]

## 1130a4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  113084: 91158463     	add	x3, x3, #0x561
  113088: aa1303e0     	mov	x0, x19
  11308c: d63f0100     	blr	x8
  113090: f900af40     	str	x0, [x26, #0x158]
  113094: f9400268     	ldr	x8, [x19]
  113098: f9439721     	ldr	x1, [x25, #0x728]
  11309c: b0002462     	adrp	x2, 0x5a0000
  1130a0: 911d1442     	add	x2, x2, #0x745
  1130a4: f9408508     	ldr	x8, [x8, #0x108]
  1130a8: aa1303e0     	mov	x0, x19
  1130ac: aa1403e3     	mov	x3, x20
  1130b0: d63f0100     	blr	x8
  1130b4: f900b340     	str	x0, [x26, #0x160]
  1130b8: aa1303e0     	mov	x0, x19

## 113348 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: no target-vtable provenance established
ASM:
  113328: aa1403e1     	mov	x1, x20
  11332c: aa1503e2     	mov	x2, x21
  113330: f81c83a8     	stur	x8, [x29, #-0x38]
  113334: 9407a0a2     	bl	0x2fb5bc <_ZN12NewStringUTF9getStringEv+0x8>
  113338: f9400288     	ldr	x8, [x20]
  11333c: f85b83a1     	ldur	x1, [x29, #-0x48]
  113340: b0002462     	adrp	x2, 0x5a0000
  113344: b0002463     	adrp	x3, 0x5a0000
  113348: f9408508     	ldr	x8, [x8, #0x108]
  11334c: 911eb042     	add	x2, x2, #0x7ac
  113350: 911ed463     	add	x3, x3, #0x7b5
  113354: aa1403e0     	mov	x0, x20
  113358: d63f0100     	blr	x8
  11335c: aa0003e3     	mov	x3, x0

## 113394 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: no target-vtable provenance established
ASM:
  113374: d101a3a0     	sub	x0, x29, #0x68
  113378: aa1403e1     	mov	x1, x20
  11337c: aa1503e2     	mov	x2, x21
  113380: 9407a08f     	bl	0x2fb5bc <_ZN12NewStringUTF9getStringEv+0x8>
  113384: f9400288     	ldr	x8, [x20]
  113388: f85983a1     	ldur	x1, [x29, #-0x68]
  11338c: b0002462     	adrp	x2, 0x5a0000
  113390: d0002443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  113394: f9408508     	ldr	x8, [x8, #0x108]
  113398: 911f2442     	add	x2, x2, #0x7c9
  11339c: 910fcc63     	add	x3, x3, #0x3f3
  1133a0: aa1403e0     	mov	x0, x20
  1133a4: d63f0100     	blr	x8
  1133a8: aa0003e3     	mov	x3, x0

## 11e608 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11e5e8: aa1303e0     	mov	x0, x19
  11e5ec: f9405508     	ldr	x8, [x8, #0xa8]
  11e5f0: d63f0100     	blr	x8
  11e5f4: f90496a0     	str	x0, [x21, #0x928]
  11e5f8: f9400268     	ldr	x8, [x19]
  11e5fc: f0002402     	adrp	x2, 0x5a1000
  11e600: f0002403     	adrp	x3, 0x5a1000
  11e604: aa0003e1     	mov	x1, x0
  11e608: f9408508     	ldr	x8, [x8, #0x108]
  11e60c: 911a4842     	add	x2, x2, #0x692
  11e610: 911a6063     	add	x3, x3, #0x698
  11e614: aa1303e0     	mov	x0, x19
  11e618: d63f0100     	blr	x8
  11e61c: d0003108     	adrp	x8, 0x740000

## 11e634 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11e614: aa1303e0     	mov	x0, x19
  11e618: d63f0100     	blr	x8
  11e61c: d0003108     	adrp	x8, 0x740000
  11e620: f9049900     	str	x0, [x8, #0x930]
  11e624: f9400268     	ldr	x8, [x19]
  11e628: f94496a1     	ldr	x1, [x21, #0x928]
  11e62c: f0002402     	adrp	x2, 0x5a1000
  11e630: f0002403     	adrp	x3, 0x5a1000
  11e634: f9408508     	ldr	x8, [x8, #0x108]
  11e638: 911a7842     	add	x2, x2, #0x69e
  11e63c: 911a9063     	add	x3, x3, #0x6a4
  11e640: aa1303e0     	mov	x0, x19
  11e644: d63f0100     	blr	x8
  11e648: d0003108     	adrp	x8, 0x740000

## 11e660 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11e640: aa1303e0     	mov	x0, x19
  11e644: d63f0100     	blr	x8
  11e648: d0003108     	adrp	x8, 0x740000
  11e64c: f9049d00     	str	x0, [x8, #0x938]
  11e650: f9400268     	ldr	x8, [x19]
  11e654: f94496a1     	ldr	x1, [x21, #0x928]
  11e658: f0002402     	adrp	x2, 0x5a1000
  11e65c: f0002403     	adrp	x3, 0x5a1000
  11e660: f9408508     	ldr	x8, [x8, #0x108]
  11e664: 911aa842     	add	x2, x2, #0x6aa
  11e668: 911af463     	add	x3, x3, #0x6bd
  11e66c: aa1303e0     	mov	x0, x19
  11e670: d63f0100     	blr	x8
  11e674: d0003108     	adrp	x8, 0x740000

## 11f9b8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11f998: aa1303e0     	mov	x0, x19
  11f99c: f9405508     	ldr	x8, [x8, #0xa8]
  11f9a0: d63f0100     	blr	x8
  11f9a4: f904b2a0     	str	x0, [x21, #0x960]
  11f9a8: f9400268     	ldr	x8, [x19]
  11f9ac: d0002402     	adrp	x2, 0x5a1000
  11f9b0: b0002403     	adrp	x3, 0x5a0000
  11f9b4: aa0003e1     	mov	x1, x0
  11f9b8: f9408508     	ldr	x8, [x8, #0x108]
  11f9bc: 91266442     	add	x2, x2, #0x999
  11f9c0: 910bc463     	add	x3, x3, #0x2f1
  11f9c4: aa1303e0     	mov	x0, x19
  11f9c8: d63f0100     	blr	x8
  11f9cc: b0003108     	adrp	x8, 0x740000

## 11f9e4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  11f9c4: aa1303e0     	mov	x0, x19
  11f9c8: d63f0100     	blr	x8
  11f9cc: b0003108     	adrp	x8, 0x740000
  11f9d0: f904b500     	str	x0, [x8, #0x968]
  11f9d4: f9400268     	ldr	x8, [x19]
  11f9d8: f944b2a1     	ldr	x1, [x21, #0x960]
  11f9dc: d0002402     	adrp	x2, 0x5a1000
  11f9e0: d00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  11f9e4: f9408508     	ldr	x8, [x8, #0x108]
  11f9e8: 9126b842     	add	x2, x2, #0x9ae
  11f9ec: 91152c63     	add	x3, x3, #0x54b
  11f9f0: aa1303e0     	mov	x0, x19
  11f9f4: d63f0100     	blr	x8
  11f9f8: b0003108     	adrp	x8, 0x740000

## 120370 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120350: aa1303e0     	mov	x0, x19
  120354: f9405508     	ldr	x8, [x8, #0xa8]
  120358: d63f0100     	blr	x8
  12035c: f904cee0     	str	x0, [x23, #0x998]
  120360: f9400268     	ldr	x8, [x19]
  120364: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120368: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12036c: aa0003e1     	mov	x1, x0
  120370: f9408508     	ldr	x8, [x8, #0x108]
  120374: 91141042     	add	x2, x2, #0x504
  120378: 91142c63     	add	x3, x3, #0x50b
  12037c: aa1303e0     	mov	x0, x19
  120380: d63f0100     	blr	x8
  120384: 90003108     	adrp	x8, 0x740000

## 12039c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12037c: aa1303e0     	mov	x0, x19
  120380: d63f0100     	blr	x8
  120384: 90003108     	adrp	x8, 0x740000
  120388: f904d100     	str	x0, [x8, #0x9a0]
  12038c: f9400268     	ldr	x8, [x19]
  120390: f944cee1     	ldr	x1, [x23, #0x998]
  120394: b00023f4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  120398: b0002402     	adrp	x2, 0x5a1000
  12039c: f9408508     	ldr	x8, [x8, #0x108]
  1203a0: 910fce94     	add	x20, x20, #0x3f3
  1203a4: 9131c442     	add	x2, x2, #0xc71
  1203a8: aa1303e0     	mov	x0, x19
  1203ac: aa1403e3     	mov	x3, x20
  1203b0: d63f0100     	blr	x8

## 1203cc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1203ac: aa1403e3     	mov	x3, x20
  1203b0: d63f0100     	blr	x8
  1203b4: 90003108     	adrp	x8, 0x740000
  1203b8: f904d500     	str	x0, [x8, #0x9a8]
  1203bc: f9400268     	ldr	x8, [x19]
  1203c0: f944cee1     	ldr	x1, [x23, #0x998]
  1203c4: b0002402     	adrp	x2, 0x5a1000
  1203c8: 91320842     	add	x2, x2, #0xc82
  1203cc: f9408508     	ldr	x8, [x8, #0x108]
  1203d0: aa1303e0     	mov	x0, x19
  1203d4: aa1403e3     	mov	x3, x20
  1203d8: d63f0100     	blr	x8
  1203dc: 90003108     	adrp	x8, 0x740000
  1203e0: f904d900     	str	x0, [x8, #0x9b0]

## 1203f4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1203d4: aa1403e3     	mov	x3, x20
  1203d8: d63f0100     	blr	x8
  1203dc: 90003108     	adrp	x8, 0x740000
  1203e0: f904d900     	str	x0, [x8, #0x9b0]
  1203e4: f9400268     	ldr	x8, [x19]
  1203e8: f944cee1     	ldr	x1, [x23, #0x998]
  1203ec: b0002402     	adrp	x2, 0x5a1000
  1203f0: 91324442     	add	x2, x2, #0xc91
  1203f4: f9408508     	ldr	x8, [x8, #0x108]
  1203f8: aa1303e0     	mov	x0, x19
  1203fc: aa1403e3     	mov	x3, x20
  120400: d63f0100     	blr	x8
  120404: 90003108     	adrp	x8, 0x740000
  120408: f904dd00     	str	x0, [x8, #0x9b8]

## 12041c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1203fc: aa1403e3     	mov	x3, x20
  120400: d63f0100     	blr	x8
  120404: 90003108     	adrp	x8, 0x740000
  120408: f904dd00     	str	x0, [x8, #0x9b8]
  12040c: f9400268     	ldr	x8, [x19]
  120410: f944cee1     	ldr	x1, [x23, #0x998]
  120414: b00023f5     	adrp	x21, 0x59d000 <__cxa_demangle+0x182b4>
  120418: b0002402     	adrp	x2, 0x5a1000
  12041c: f9408508     	ldr	x8, [x8, #0x108]
  120420: 911586b5     	add	x21, x21, #0x561
  120424: 91329042     	add	x2, x2, #0xca4
  120428: aa1303e0     	mov	x0, x19
  12042c: aa1503e3     	mov	x3, x21
  120430: d63f0100     	blr	x8

## 12044c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12042c: aa1503e3     	mov	x3, x21
  120430: d63f0100     	blr	x8
  120434: 90003108     	adrp	x8, 0x740000
  120438: f904e100     	str	x0, [x8, #0x9c0]
  12043c: f9400268     	ldr	x8, [x19]
  120440: f944cee1     	ldr	x1, [x23, #0x998]
  120444: b0002402     	adrp	x2, 0x5a1000
  120448: 9132d442     	add	x2, x2, #0xcb5
  12044c: f9408508     	ldr	x8, [x8, #0x108]
  120450: aa1303e0     	mov	x0, x19
  120454: aa1503e3     	mov	x3, x21
  120458: d63f0100     	blr	x8
  12045c: 90003108     	adrp	x8, 0x740000
  120460: f904e500     	str	x0, [x8, #0x9c8]

## 120474 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120454: aa1503e3     	mov	x3, x21
  120458: d63f0100     	blr	x8
  12045c: 90003108     	adrp	x8, 0x740000
  120460: f904e500     	str	x0, [x8, #0x9c8]
  120464: f9400268     	ldr	x8, [x19]
  120468: f944cee1     	ldr	x1, [x23, #0x998]
  12046c: b0002402     	adrp	x2, 0x5a1000
  120470: 91331042     	add	x2, x2, #0xcc4
  120474: f9408508     	ldr	x8, [x8, #0x108]
  120478: aa1303e0     	mov	x0, x19
  12047c: aa1503e3     	mov	x3, x21
  120480: d63f0100     	blr	x8
  120484: 90003108     	adrp	x8, 0x740000
  120488: f904e900     	str	x0, [x8, #0x9d0]

## 12049c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12047c: aa1503e3     	mov	x3, x21
  120480: d63f0100     	blr	x8
  120484: 90003108     	adrp	x8, 0x740000
  120488: f904e900     	str	x0, [x8, #0x9d0]
  12048c: f9400268     	ldr	x8, [x19]
  120490: f944cee1     	ldr	x1, [x23, #0x998]
  120494: b0002402     	adrp	x2, 0x5a1000
  120498: 91335c42     	add	x2, x2, #0xcd7
  12049c: f9408508     	ldr	x8, [x8, #0x108]
  1204a0: aa1303e0     	mov	x0, x19
  1204a4: aa1403e3     	mov	x3, x20
  1204a8: d63f0100     	blr	x8
  1204ac: 90003108     	adrp	x8, 0x740000
  1204b0: f904ed00     	str	x0, [x8, #0x9d8]

## 1204c4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1204a4: aa1403e3     	mov	x3, x20
  1204a8: d63f0100     	blr	x8
  1204ac: 90003108     	adrp	x8, 0x740000
  1204b0: f904ed00     	str	x0, [x8, #0x9d8]
  1204b4: f9400268     	ldr	x8, [x19]
  1204b8: f944cee1     	ldr	x1, [x23, #0x998]
  1204bc: b0002402     	adrp	x2, 0x5a1000
  1204c0: 91338442     	add	x2, x2, #0xce1
  1204c4: f9408508     	ldr	x8, [x8, #0x108]
  1204c8: aa1303e0     	mov	x0, x19
  1204cc: aa1403e3     	mov	x3, x20
  1204d0: d63f0100     	blr	x8
  1204d4: 90003108     	adrp	x8, 0x740000
  1204d8: f904f100     	str	x0, [x8, #0x9e0]

## 12098c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12096c: aa1303e0     	mov	x0, x19
  120970: f9405508     	ldr	x8, [x8, #0xa8]
  120974: d63f0100     	blr	x8
  120978: f904f6c0     	str	x0, [x22, #0x9e8]
  12097c: f9400268     	ldr	x8, [x19]
  120980: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120984: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120988: aa0003e1     	mov	x1, x0
  12098c: f9408508     	ldr	x8, [x8, #0x108]
  120990: 91141042     	add	x2, x2, #0x504
  120994: 91142c63     	add	x3, x3, #0x50b
  120998: aa1303e0     	mov	x0, x19
  12099c: d63f0100     	blr	x8
  1209a0: 90003108     	adrp	x8, 0x740000

## 1209b8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120998: aa1303e0     	mov	x0, x19
  12099c: d63f0100     	blr	x8
  1209a0: 90003108     	adrp	x8, 0x740000
  1209a4: f904f900     	str	x0, [x8, #0x9f0]
  1209a8: f9400268     	ldr	x8, [x19]
  1209ac: f944f6c1     	ldr	x1, [x22, #0x9e8]
  1209b0: b00023f4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  1209b4: b0002402     	adrp	x2, 0x5a1000
  1209b8: f9408508     	ldr	x8, [x8, #0x108]
  1209bc: 910fce94     	add	x20, x20, #0x3f3
  1209c0: 91343c42     	add	x2, x2, #0xd0f
  1209c4: aa1303e0     	mov	x0, x19
  1209c8: aa1403e3     	mov	x3, x20
  1209cc: d63f0100     	blr	x8

## 1209e8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1209c8: aa1403e3     	mov	x3, x20
  1209cc: d63f0100     	blr	x8
  1209d0: 90003108     	adrp	x8, 0x740000
  1209d4: f904fd00     	str	x0, [x8, #0x9f8]
  1209d8: f9400268     	ldr	x8, [x19]
  1209dc: f944f6c1     	ldr	x1, [x22, #0x9e8]
  1209e0: b0002402     	adrp	x2, 0x5a1000
  1209e4: 91338442     	add	x2, x2, #0xce1
  1209e8: f9408508     	ldr	x8, [x8, #0x108]
  1209ec: aa1303e0     	mov	x0, x19
  1209f0: aa1403e3     	mov	x3, x20
  1209f4: d63f0100     	blr	x8
  1209f8: 90003108     	adrp	x8, 0x740000
  1209fc: f9050100     	str	x0, [x8, #0xa00]

## 120a10 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString9to_stringIlEENSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEET_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1209f0: aa1403e3     	mov	x3, x20
  1209f4: d63f0100     	blr	x8
  1209f8: 90003108     	adrp	x8, 0x740000
  1209fc: f9050100     	str	x0, [x8, #0xa00]
  120a00: f9400268     	ldr	x8, [x19]
  120a04: f944f6c1     	ldr	x1, [x22, #0x9e8]
  120a08: b0002402     	adrp	x2, 0x5a1000
  120a0c: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120a10: f9408508     	ldr	x8, [x8, #0x108]
  120a14: 91346c42     	add	x2, x2, #0xd1b
  120a18: 91158463     	add	x3, x3, #0x561
  120a1c: aa1303e0     	mov	x0, x19
  120a20: d63f0100     	blr	x8
  120a24: 90003108     	adrp	x8, 0x740000

## 120c04 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120be4: aa1303e0     	mov	x0, x19
  120be8: f9405508     	ldr	x8, [x8, #0xa8]
  120bec: d63f0100     	blr	x8
  120bf0: f9050ae0     	str	x0, [x23, #0xa10]
  120bf4: f9400268     	ldr	x8, [x19]
  120bf8: b00023f4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  120bfc: b0002402     	adrp	x2, 0x5a1000
  120c00: 910fce94     	add	x20, x20, #0x3f3
  120c04: f9408508     	ldr	x8, [x8, #0x108]
  120c08: aa0003e1     	mov	x1, x0
  120c0c: 91353442     	add	x2, x2, #0xd4d
  120c10: aa1303e0     	mov	x0, x19
  120c14: aa1403e3     	mov	x3, x20
  120c18: d63f0100     	blr	x8

## 120c38 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120c18: d63f0100     	blr	x8
  120c1c: 90003118     	adrp	x24, 0x740000
  120c20: 91288318     	add	x24, x24, #0xa20
  120c24: f9000300     	str	x0, [x24]
  120c28: f9400268     	ldr	x8, [x19]
  120c2c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c30: b0002402     	adrp	x2, 0x5a1000
  120c34: 9131c442     	add	x2, x2, #0xc71
  120c38: f9408508     	ldr	x8, [x8, #0x108]
  120c3c: aa1303e0     	mov	x0, x19
  120c40: aa1403e3     	mov	x3, x20
  120c44: d63f0100     	blr	x8
  120c48: f9000700     	str	x0, [x24, #0x8]
  120c4c: f9400268     	ldr	x8, [x19]

## 120c5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120c3c: aa1303e0     	mov	x0, x19
  120c40: aa1403e3     	mov	x3, x20
  120c44: d63f0100     	blr	x8
  120c48: f9000700     	str	x0, [x24, #0x8]
  120c4c: f9400268     	ldr	x8, [x19]
  120c50: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c54: b0002402     	adrp	x2, 0x5a1000
  120c58: 91320842     	add	x2, x2, #0xc82
  120c5c: f9408508     	ldr	x8, [x8, #0x108]
  120c60: aa1303e0     	mov	x0, x19
  120c64: aa1403e3     	mov	x3, x20
  120c68: d63f0100     	blr	x8
  120c6c: f9000b00     	str	x0, [x24, #0x10]
  120c70: f9400268     	ldr	x8, [x19]

## 120c80 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120c60: aa1303e0     	mov	x0, x19
  120c64: aa1403e3     	mov	x3, x20
  120c68: d63f0100     	blr	x8
  120c6c: f9000b00     	str	x0, [x24, #0x10]
  120c70: f9400268     	ldr	x8, [x19]
  120c74: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c78: b0002402     	adrp	x2, 0x5a1000
  120c7c: 91324442     	add	x2, x2, #0xc91
  120c80: f9408508     	ldr	x8, [x8, #0x108]
  120c84: aa1303e0     	mov	x0, x19
  120c88: aa1403e3     	mov	x3, x20
  120c8c: d63f0100     	blr	x8
  120c90: f9000f00     	str	x0, [x24, #0x18]
  120c94: f9400268     	ldr	x8, [x19]

## 120ca4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120c84: aa1303e0     	mov	x0, x19
  120c88: aa1403e3     	mov	x3, x20
  120c8c: d63f0100     	blr	x8
  120c90: f9000f00     	str	x0, [x24, #0x18]
  120c94: f9400268     	ldr	x8, [x19]
  120c98: f9450ae1     	ldr	x1, [x23, #0xa10]
  120c9c: b0002402     	adrp	x2, 0x5a1000
  120ca0: 91335c42     	add	x2, x2, #0xcd7
  120ca4: f9408508     	ldr	x8, [x8, #0x108]
  120ca8: aa1303e0     	mov	x0, x19
  120cac: aa1403e3     	mov	x3, x20
  120cb0: d63f0100     	blr	x8
  120cb4: f9001300     	str	x0, [x24, #0x20]
  120cb8: f9400268     	ldr	x8, [x19]

## 120cc8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120ca8: aa1303e0     	mov	x0, x19
  120cac: aa1403e3     	mov	x3, x20
  120cb0: d63f0100     	blr	x8
  120cb4: f9001300     	str	x0, [x24, #0x20]
  120cb8: f9400268     	ldr	x8, [x19]
  120cbc: f9450ae1     	ldr	x1, [x23, #0xa10]
  120cc0: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120cc4: 91149c42     	add	x2, x2, #0x527
  120cc8: f9408508     	ldr	x8, [x8, #0x108]
  120ccc: aa1303e0     	mov	x0, x19
  120cd0: aa1403e3     	mov	x3, x20
  120cd4: d63f0100     	blr	x8
  120cd8: f9001700     	str	x0, [x24, #0x28]
  120cdc: f9400268     	ldr	x8, [x19]

## 120cec — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120ccc: aa1303e0     	mov	x0, x19
  120cd0: aa1403e3     	mov	x3, x20
  120cd4: d63f0100     	blr	x8
  120cd8: f9001700     	str	x0, [x24, #0x28]
  120cdc: f9400268     	ldr	x8, [x19]
  120ce0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ce4: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120ce8: 9114d042     	add	x2, x2, #0x534
  120cec: f9408508     	ldr	x8, [x8, #0x108]
  120cf0: aa1303e0     	mov	x0, x19
  120cf4: aa1403e3     	mov	x3, x20
  120cf8: d63f0100     	blr	x8
  120cfc: f9001b00     	str	x0, [x24, #0x30]
  120d00: f9400268     	ldr	x8, [x19]

## 120d10 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120cf0: aa1303e0     	mov	x0, x19
  120cf4: aa1403e3     	mov	x3, x20
  120cf8: d63f0100     	blr	x8
  120cfc: f9001b00     	str	x0, [x24, #0x30]
  120d00: f9400268     	ldr	x8, [x19]
  120d04: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d08: b00023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  120d0c: 91153c42     	add	x2, x2, #0x54f
  120d10: f9408508     	ldr	x8, [x8, #0x108]
  120d14: aa1303e0     	mov	x0, x19
  120d18: aa1403e3     	mov	x3, x20
  120d1c: d63f0100     	blr	x8
  120d20: f9001f00     	str	x0, [x24, #0x38]
  120d24: f9400268     	ldr	x8, [x19]

## 120d34 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120d14: aa1303e0     	mov	x0, x19
  120d18: aa1403e3     	mov	x3, x20
  120d1c: d63f0100     	blr	x8
  120d20: f9001f00     	str	x0, [x24, #0x38]
  120d24: f9400268     	ldr	x8, [x19]
  120d28: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d2c: b0002402     	adrp	x2, 0x5a1000
  120d30: 91338442     	add	x2, x2, #0xce1
  120d34: f9408508     	ldr	x8, [x8, #0x108]
  120d38: aa1303e0     	mov	x0, x19
  120d3c: aa1403e3     	mov	x3, x20
  120d40: d63f0100     	blr	x8
  120d44: f9002b00     	str	x0, [x24, #0x50]
  120d48: f9400268     	ldr	x8, [x19]

## 120d58 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120d38: aa1303e0     	mov	x0, x19
  120d3c: aa1403e3     	mov	x3, x20
  120d40: d63f0100     	blr	x8
  120d44: f9002b00     	str	x0, [x24, #0x50]
  120d48: f9400268     	ldr	x8, [x19]
  120d4c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d50: b0002402     	adrp	x2, 0x5a1000
  120d54: 91355042     	add	x2, x2, #0xd54
  120d58: f9408508     	ldr	x8, [x8, #0x108]
  120d5c: aa1303e0     	mov	x0, x19
  120d60: aa1403e3     	mov	x3, x20
  120d64: d63f0100     	blr	x8
  120d68: f9002f00     	str	x0, [x24, #0x58]
  120d6c: f9400268     	ldr	x8, [x19]

## 120d7c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120d5c: aa1303e0     	mov	x0, x19
  120d60: aa1403e3     	mov	x3, x20
  120d64: d63f0100     	blr	x8
  120d68: f9002f00     	str	x0, [x24, #0x58]
  120d6c: f9400268     	ldr	x8, [x19]
  120d70: f9450ae1     	ldr	x1, [x23, #0xa10]
  120d74: f00023f5     	adrp	x21, 0x59f000
  120d78: b0002402     	adrp	x2, 0x5a1000
  120d7c: f9408508     	ldr	x8, [x8, #0x108]
  120d80: 911a36b5     	add	x21, x21, #0x68d
  120d84: 91359442     	add	x2, x2, #0xd65
  120d88: aa1303e0     	mov	x0, x19
  120d8c: aa1503e3     	mov	x3, x21
  120d90: d63f0100     	blr	x8

## 120da8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120d88: aa1303e0     	mov	x0, x19
  120d8c: aa1503e3     	mov	x3, x21
  120d90: d63f0100     	blr	x8
  120d94: f9003300     	str	x0, [x24, #0x60]
  120d98: f9400268     	ldr	x8, [x19]
  120d9c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120da0: b0002402     	adrp	x2, 0x5a1000
  120da4: 9135f042     	add	x2, x2, #0xd7c
  120da8: f9408508     	ldr	x8, [x8, #0x108]
  120dac: aa1303e0     	mov	x0, x19
  120db0: aa1503e3     	mov	x3, x21
  120db4: d63f0100     	blr	x8
  120db8: f9002300     	str	x0, [x24, #0x40]
  120dbc: f9400268     	ldr	x8, [x19]

## 120dcc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120dac: aa1303e0     	mov	x0, x19
  120db0: aa1503e3     	mov	x3, x21
  120db4: d63f0100     	blr	x8
  120db8: f9002300     	str	x0, [x24, #0x40]
  120dbc: f9400268     	ldr	x8, [x19]
  120dc0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120dc4: b0002402     	adrp	x2, 0x5a1000
  120dc8: 91362c42     	add	x2, x2, #0xd8b
  120dcc: f9408508     	ldr	x8, [x8, #0x108]
  120dd0: aa1303e0     	mov	x0, x19
  120dd4: aa1403e3     	mov	x3, x20
  120dd8: d63f0100     	blr	x8
  120ddc: f9002700     	str	x0, [x24, #0x48]
  120de0: f9400268     	ldr	x8, [x19]

## 120df0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120dd0: aa1303e0     	mov	x0, x19
  120dd4: aa1403e3     	mov	x3, x20
  120dd8: d63f0100     	blr	x8
  120ddc: f9002700     	str	x0, [x24, #0x48]
  120de0: f9400268     	ldr	x8, [x19]
  120de4: f9450ae1     	ldr	x1, [x23, #0xa10]
  120de8: b0002402     	adrp	x2, 0x5a1000
  120dec: 91366442     	add	x2, x2, #0xd99
  120df0: f9408508     	ldr	x8, [x8, #0x108]
  120df4: aa1303e0     	mov	x0, x19
  120df8: aa1403e3     	mov	x3, x20
  120dfc: d63f0100     	blr	x8
  120e00: f9003700     	str	x0, [x24, #0x68]
  120e04: f9400268     	ldr	x8, [x19]

## 120e14 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120df4: aa1303e0     	mov	x0, x19
  120df8: aa1403e3     	mov	x3, x20
  120dfc: d63f0100     	blr	x8
  120e00: f9003700     	str	x0, [x24, #0x68]
  120e04: f9400268     	ldr	x8, [x19]
  120e08: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e0c: b0002402     	adrp	x2, 0x5a1000
  120e10: 9136a842     	add	x2, x2, #0xdaa
  120e14: f9408508     	ldr	x8, [x8, #0x108]
  120e18: aa1303e0     	mov	x0, x19
  120e1c: aa1403e3     	mov	x3, x20
  120e20: d63f0100     	blr	x8
  120e24: f9003b00     	str	x0, [x24, #0x70]
  120e28: f9400268     	ldr	x8, [x19]

## 120e38 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120e18: aa1303e0     	mov	x0, x19
  120e1c: aa1403e3     	mov	x3, x20
  120e20: d63f0100     	blr	x8
  120e24: f9003b00     	str	x0, [x24, #0x70]
  120e28: f9400268     	ldr	x8, [x19]
  120e2c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e30: b0002402     	adrp	x2, 0x5a1000
  120e34: 9136ec42     	add	x2, x2, #0xdbb
  120e38: f9408508     	ldr	x8, [x8, #0x108]
  120e3c: aa1303e0     	mov	x0, x19
  120e40: aa1403e3     	mov	x3, x20
  120e44: d63f0100     	blr	x8
  120e48: f9003f00     	str	x0, [x24, #0x78]
  120e4c: f9400268     	ldr	x8, [x19]

## 120e5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120e3c: aa1303e0     	mov	x0, x19
  120e40: aa1403e3     	mov	x3, x20
  120e44: d63f0100     	blr	x8
  120e48: f9003f00     	str	x0, [x24, #0x78]
  120e4c: f9400268     	ldr	x8, [x19]
  120e50: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e54: b0002402     	adrp	x2, 0x5a1000
  120e58: 91373042     	add	x2, x2, #0xdcc
  120e5c: f9408508     	ldr	x8, [x8, #0x108]
  120e60: aa1303e0     	mov	x0, x19
  120e64: aa1403e3     	mov	x3, x20
  120e68: d63f0100     	blr	x8
  120e6c: f9004300     	str	x0, [x24, #0x80]
  120e70: f9400268     	ldr	x8, [x19]

## 120e80 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120e60: aa1303e0     	mov	x0, x19
  120e64: aa1403e3     	mov	x3, x20
  120e68: d63f0100     	blr	x8
  120e6c: f9004300     	str	x0, [x24, #0x80]
  120e70: f9400268     	ldr	x8, [x19]
  120e74: f9450ae1     	ldr	x1, [x23, #0xa10]
  120e78: b0002402     	adrp	x2, 0x5a1000
  120e7c: b00023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  120e80: f9408508     	ldr	x8, [x8, #0x108]
  120e84: 91377442     	add	x2, x2, #0xddd
  120e88: 91152c63     	add	x3, x3, #0x54b
  120e8c: aa1303e0     	mov	x0, x19
  120e90: d63f0100     	blr	x8
  120e94: f9004700     	str	x0, [x24, #0x88]

## 120ea8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120e88: 91152c63     	add	x3, x3, #0x54b
  120e8c: aa1303e0     	mov	x0, x19
  120e90: d63f0100     	blr	x8
  120e94: f9004700     	str	x0, [x24, #0x88]
  120e98: f9400268     	ldr	x8, [x19]
  120e9c: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ea0: b0002402     	adrp	x2, 0x5a1000
  120ea4: 9137b042     	add	x2, x2, #0xdec
  120ea8: f9408508     	ldr	x8, [x8, #0x108]
  120eac: aa1303e0     	mov	x0, x19
  120eb0: aa1403e3     	mov	x3, x20
  120eb4: d63f0100     	blr	x8
  120eb8: f9004b00     	str	x0, [x24, #0x90]
  120ebc: f9400268     	ldr	x8, [x19]

## 120ecc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120eac: aa1303e0     	mov	x0, x19
  120eb0: aa1403e3     	mov	x3, x20
  120eb4: d63f0100     	blr	x8
  120eb8: f9004b00     	str	x0, [x24, #0x90]
  120ebc: f9400268     	ldr	x8, [x19]
  120ec0: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ec4: b0002402     	adrp	x2, 0x5a1000
  120ec8: 9137e042     	add	x2, x2, #0xdf8
  120ecc: f9408508     	ldr	x8, [x8, #0x108]
  120ed0: aa1303e0     	mov	x0, x19
  120ed4: aa1403e3     	mov	x3, x20
  120ed8: d63f0100     	blr	x8
  120edc: f9004f00     	str	x0, [x24, #0x98]
  120ee0: f9400268     	ldr	x8, [x19]

## 120ef0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN10JavaVidSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  120ed0: aa1303e0     	mov	x0, x19
  120ed4: aa1403e3     	mov	x3, x20
  120ed8: d63f0100     	blr	x8
  120edc: f9004f00     	str	x0, [x24, #0x98]
  120ee0: f9400268     	ldr	x8, [x19]
  120ee4: f9450ae1     	ldr	x1, [x23, #0xa10]
  120ee8: b0002402     	adrp	x2, 0x5a1000
  120eec: 91384c42     	add	x2, x2, #0xe13
  120ef0: f9408508     	ldr	x8, [x8, #0x108]
  120ef4: aa1303e0     	mov	x0, x19
  120ef8: aa1403e3     	mov	x3, x20
  120efc: d63f0100     	blr	x8
  120f00: f9005300     	str	x0, [x24, #0xa0]
  120f04: 910023e0     	add	x0, sp, #0x8

## 1218d0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1218b0: aa1303e0     	mov	x0, x19
  1218b4: f9405508     	ldr	x8, [x8, #0xa8]
  1218b8: d63f0100     	blr	x8
  1218bc: f90566e0     	str	x0, [x23, #0xac8]
  1218c0: f9400268     	ldr	x8, [x19]
  1218c4: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1218c8: 900023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1218cc: aa0003e1     	mov	x1, x0
  1218d0: f9408508     	ldr	x8, [x8, #0x108]
  1218d4: 91141042     	add	x2, x2, #0x504
  1218d8: 91142c63     	add	x3, x3, #0x50b
  1218dc: aa1303e0     	mov	x0, x19
  1218e0: d63f0100     	blr	x8
  1218e4: f00030e8     	adrp	x8, 0x740000

## 1218fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1218dc: aa1303e0     	mov	x0, x19
  1218e0: d63f0100     	blr	x8
  1218e4: f00030e8     	adrp	x8, 0x740000
  1218e8: f9056900     	str	x0, [x8, #0xad0]
  1218ec: f9400268     	ldr	x8, [x19]
  1218f0: f94566e1     	ldr	x1, [x23, #0xac8]
  1218f4: 900023f4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  1218f8: 90002402     	adrp	x2, 0x5a1000
  1218fc: f9408508     	ldr	x8, [x8, #0x108]
  121900: 910fce94     	add	x20, x20, #0x3f3
  121904: 91353442     	add	x2, x2, #0xd4d
  121908: aa1303e0     	mov	x0, x19
  12190c: aa1403e3     	mov	x3, x20
  121910: d63f0100     	blr	x8

## 121930 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121910: d63f0100     	blr	x8
  121914: f00030f8     	adrp	x24, 0x740000
  121918: 912bc318     	add	x24, x24, #0xaf0
  12191c: f9000300     	str	x0, [x24]
  121920: f9400268     	ldr	x8, [x19]
  121924: f94566e1     	ldr	x1, [x23, #0xac8]
  121928: 90002402     	adrp	x2, 0x5a1000
  12192c: 91343c42     	add	x2, x2, #0xd0f
  121930: f9408508     	ldr	x8, [x8, #0x108]
  121934: aa1303e0     	mov	x0, x19
  121938: aa1403e3     	mov	x3, x20
  12193c: d63f0100     	blr	x8
  121940: f9000700     	str	x0, [x24, #0x8]
  121944: f9400268     	ldr	x8, [x19]

## 121954 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121934: aa1303e0     	mov	x0, x19
  121938: aa1403e3     	mov	x3, x20
  12193c: d63f0100     	blr	x8
  121940: f9000700     	str	x0, [x24, #0x8]
  121944: f9400268     	ldr	x8, [x19]
  121948: f94566e1     	ldr	x1, [x23, #0xac8]
  12194c: 90002402     	adrp	x2, 0x5a1000
  121950: 91335c42     	add	x2, x2, #0xcd7
  121954: f9408508     	ldr	x8, [x8, #0x108]
  121958: aa1303e0     	mov	x0, x19
  12195c: aa1403e3     	mov	x3, x20
  121960: d63f0100     	blr	x8
  121964: f9000b00     	str	x0, [x24, #0x10]
  121968: f9400268     	ldr	x8, [x19]

## 121978 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121958: aa1303e0     	mov	x0, x19
  12195c: aa1403e3     	mov	x3, x20
  121960: d63f0100     	blr	x8
  121964: f9000b00     	str	x0, [x24, #0x10]
  121968: f9400268     	ldr	x8, [x19]
  12196c: f94566e1     	ldr	x1, [x23, #0xac8]
  121970: 900023f5     	adrp	x21, 0x59d000 <__cxa_demangle+0x182b4>
  121974: 90002402     	adrp	x2, 0x5a1000
  121978: f9408508     	ldr	x8, [x8, #0x108]
  12197c: 911586b5     	add	x21, x21, #0x561
  121980: 91393842     	add	x2, x2, #0xe4e
  121984: aa1303e0     	mov	x0, x19
  121988: aa1503e3     	mov	x3, x21
  12198c: d63f0100     	blr	x8

## 1219a8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121988: aa1503e3     	mov	x3, x21
  12198c: d63f0100     	blr	x8
  121990: f00030e8     	adrp	x8, 0x740000
  121994: f9056d00     	str	x0, [x8, #0xad8]
  121998: f9400268     	ldr	x8, [x19]
  12199c: f94566e1     	ldr	x1, [x23, #0xac8]
  1219a0: 90002402     	adrp	x2, 0x5a1000
  1219a4: 91346c42     	add	x2, x2, #0xd1b
  1219a8: f9408508     	ldr	x8, [x8, #0x108]
  1219ac: aa1303e0     	mov	x0, x19
  1219b0: aa1503e3     	mov	x3, x21
  1219b4: d63f0100     	blr	x8
  1219b8: f00030e8     	adrp	x8, 0x740000
  1219bc: f9057100     	str	x0, [x8, #0xae0]

## 1219d0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1219b0: aa1503e3     	mov	x3, x21
  1219b4: d63f0100     	blr	x8
  1219b8: f00030e8     	adrp	x8, 0x740000
  1219bc: f9057100     	str	x0, [x8, #0xae0]
  1219c0: f9400268     	ldr	x8, [x19]
  1219c4: f94566e1     	ldr	x1, [x23, #0xac8]
  1219c8: 90002402     	adrp	x2, 0x5a1000
  1219cc: 91395442     	add	x2, x2, #0xe55
  1219d0: f9408508     	ldr	x8, [x8, #0x108]
  1219d4: aa1303e0     	mov	x0, x19
  1219d8: aa1503e3     	mov	x3, x21
  1219dc: d63f0100     	blr	x8
  1219e0: f00030e8     	adrp	x8, 0x740000
  1219e4: f9057500     	str	x0, [x8, #0xae8]

## 1219f8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1219d8: aa1503e3     	mov	x3, x21
  1219dc: d63f0100     	blr	x8
  1219e0: f00030e8     	adrp	x8, 0x740000
  1219e4: f9057500     	str	x0, [x8, #0xae8]
  1219e8: f9400268     	ldr	x8, [x19]
  1219ec: f94566e1     	ldr	x1, [x23, #0xac8]
  1219f0: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1219f4: 91149c42     	add	x2, x2, #0x527
  1219f8: f9408508     	ldr	x8, [x8, #0x108]
  1219fc: aa1303e0     	mov	x0, x19
  121a00: aa1403e3     	mov	x3, x20
  121a04: d63f0100     	blr	x8
  121a08: f9000f00     	str	x0, [x24, #0x18]
  121a0c: f9400268     	ldr	x8, [x19]

## 121a1c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1219fc: aa1303e0     	mov	x0, x19
  121a00: aa1403e3     	mov	x3, x20
  121a04: d63f0100     	blr	x8
  121a08: f9000f00     	str	x0, [x24, #0x18]
  121a0c: f9400268     	ldr	x8, [x19]
  121a10: f94566e1     	ldr	x1, [x23, #0xac8]
  121a14: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  121a18: 9114d042     	add	x2, x2, #0x534
  121a1c: f9408508     	ldr	x8, [x8, #0x108]
  121a20: aa1303e0     	mov	x0, x19
  121a24: aa1403e3     	mov	x3, x20
  121a28: d63f0100     	blr	x8
  121a2c: f9001300     	str	x0, [x24, #0x20]
  121a30: f9400268     	ldr	x8, [x19]

## 121a40 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121a20: aa1303e0     	mov	x0, x19
  121a24: aa1403e3     	mov	x3, x20
  121a28: d63f0100     	blr	x8
  121a2c: f9001300     	str	x0, [x24, #0x20]
  121a30: f9400268     	ldr	x8, [x19]
  121a34: f94566e1     	ldr	x1, [x23, #0xac8]
  121a38: 900023e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  121a3c: 91153c42     	add	x2, x2, #0x54f
  121a40: f9408508     	ldr	x8, [x8, #0x108]
  121a44: aa1303e0     	mov	x0, x19
  121a48: aa1403e3     	mov	x3, x20
  121a4c: d63f0100     	blr	x8
  121a50: f9001700     	str	x0, [x24, #0x28]
  121a54: f9400268     	ldr	x8, [x19]

## 121a64 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121a44: aa1303e0     	mov	x0, x19
  121a48: aa1403e3     	mov	x3, x20
  121a4c: d63f0100     	blr	x8
  121a50: f9001700     	str	x0, [x24, #0x28]
  121a54: f9400268     	ldr	x8, [x19]
  121a58: f94566e1     	ldr	x1, [x23, #0xac8]
  121a5c: d00023f5     	adrp	x21, 0x59f000
  121a60: 90002402     	adrp	x2, 0x5a1000
  121a64: f9408508     	ldr	x8, [x8, #0x108]
  121a68: 911a36b5     	add	x21, x21, #0x68d
  121a6c: 9135f042     	add	x2, x2, #0xd7c
  121a70: aa1303e0     	mov	x0, x19
  121a74: aa1503e3     	mov	x3, x21
  121a78: d63f0100     	blr	x8

## 121a90 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121a70: aa1303e0     	mov	x0, x19
  121a74: aa1503e3     	mov	x3, x21
  121a78: d63f0100     	blr	x8
  121a7c: f9001b00     	str	x0, [x24, #0x30]
  121a80: f9400268     	ldr	x8, [x19]
  121a84: f94566e1     	ldr	x1, [x23, #0xac8]
  121a88: 90002402     	adrp	x2, 0x5a1000
  121a8c: 91362c42     	add	x2, x2, #0xd8b
  121a90: f9408508     	ldr	x8, [x8, #0x108]
  121a94: aa1303e0     	mov	x0, x19
  121a98: aa1403e3     	mov	x3, x20
  121a9c: d63f0100     	blr	x8
  121aa0: f9001f00     	str	x0, [x24, #0x38]
  121aa4: f9400268     	ldr	x8, [x19]

## 121ab4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121a94: aa1303e0     	mov	x0, x19
  121a98: aa1403e3     	mov	x3, x20
  121a9c: d63f0100     	blr	x8
  121aa0: f9001f00     	str	x0, [x24, #0x38]
  121aa4: f9400268     	ldr	x8, [x19]
  121aa8: f94566e1     	ldr	x1, [x23, #0xac8]
  121aac: 90002402     	adrp	x2, 0x5a1000
  121ab0: 91338442     	add	x2, x2, #0xce1
  121ab4: f9408508     	ldr	x8, [x8, #0x108]
  121ab8: aa1303e0     	mov	x0, x19
  121abc: aa1403e3     	mov	x3, x20
  121ac0: d63f0100     	blr	x8
  121ac4: f9002300     	str	x0, [x24, #0x40]
  121ac8: f9400268     	ldr	x8, [x19]

## 121ad8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121ab8: aa1303e0     	mov	x0, x19
  121abc: aa1403e3     	mov	x3, x20
  121ac0: d63f0100     	blr	x8
  121ac4: f9002300     	str	x0, [x24, #0x40]
  121ac8: f9400268     	ldr	x8, [x19]
  121acc: f94566e1     	ldr	x1, [x23, #0xac8]
  121ad0: 90002402     	adrp	x2, 0x5a1000
  121ad4: 91355042     	add	x2, x2, #0xd54
  121ad8: f9408508     	ldr	x8, [x8, #0x108]
  121adc: aa1303e0     	mov	x0, x19
  121ae0: aa1403e3     	mov	x3, x20
  121ae4: d63f0100     	blr	x8
  121ae8: f9002700     	str	x0, [x24, #0x48]
  121aec: f9400268     	ldr	x8, [x19]

## 121afc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121adc: aa1303e0     	mov	x0, x19
  121ae0: aa1403e3     	mov	x3, x20
  121ae4: d63f0100     	blr	x8
  121ae8: f9002700     	str	x0, [x24, #0x48]
  121aec: f9400268     	ldr	x8, [x19]
  121af0: f94566e1     	ldr	x1, [x23, #0xac8]
  121af4: 90002402     	adrp	x2, 0x5a1000
  121af8: 91359442     	add	x2, x2, #0xd65
  121afc: f9408508     	ldr	x8, [x8, #0x108]
  121b00: aa1303e0     	mov	x0, x19
  121b04: aa1503e3     	mov	x3, x21
  121b08: d63f0100     	blr	x8
  121b0c: f9002b00     	str	x0, [x24, #0x50]
  121b10: f9400268     	ldr	x8, [x19]

## 121b20 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121b00: aa1303e0     	mov	x0, x19
  121b04: aa1503e3     	mov	x3, x21
  121b08: d63f0100     	blr	x8
  121b0c: f9002b00     	str	x0, [x24, #0x50]
  121b10: f9400268     	ldr	x8, [x19]
  121b14: f94566e1     	ldr	x1, [x23, #0xac8]
  121b18: 90002402     	adrp	x2, 0x5a1000
  121b1c: 91366442     	add	x2, x2, #0xd99
  121b20: f9408508     	ldr	x8, [x8, #0x108]
  121b24: aa1303e0     	mov	x0, x19
  121b28: aa1403e3     	mov	x3, x20
  121b2c: d63f0100     	blr	x8
  121b30: f9002f00     	str	x0, [x24, #0x58]
  121b34: f9400268     	ldr	x8, [x19]

## 121b44 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121b24: aa1303e0     	mov	x0, x19
  121b28: aa1403e3     	mov	x3, x20
  121b2c: d63f0100     	blr	x8
  121b30: f9002f00     	str	x0, [x24, #0x58]
  121b34: f9400268     	ldr	x8, [x19]
  121b38: f94566e1     	ldr	x1, [x23, #0xac8]
  121b3c: 90002402     	adrp	x2, 0x5a1000
  121b40: 9136a842     	add	x2, x2, #0xdaa
  121b44: f9408508     	ldr	x8, [x8, #0x108]
  121b48: aa1303e0     	mov	x0, x19
  121b4c: aa1403e3     	mov	x3, x20
  121b50: d63f0100     	blr	x8
  121b54: f9003300     	str	x0, [x24, #0x60]
  121b58: f9400268     	ldr	x8, [x19]

## 121b68 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121b48: aa1303e0     	mov	x0, x19
  121b4c: aa1403e3     	mov	x3, x20
  121b50: d63f0100     	blr	x8
  121b54: f9003300     	str	x0, [x24, #0x60]
  121b58: f9400268     	ldr	x8, [x19]
  121b5c: f94566e1     	ldr	x1, [x23, #0xac8]
  121b60: 90002402     	adrp	x2, 0x5a1000
  121b64: 9136ec42     	add	x2, x2, #0xdbb
  121b68: f9408508     	ldr	x8, [x8, #0x108]
  121b6c: aa1303e0     	mov	x0, x19
  121b70: aa1403e3     	mov	x3, x20
  121b74: d63f0100     	blr	x8
  121b78: f9003700     	str	x0, [x24, #0x68]
  121b7c: f9400268     	ldr	x8, [x19]

## 121b8c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121b6c: aa1303e0     	mov	x0, x19
  121b70: aa1403e3     	mov	x3, x20
  121b74: d63f0100     	blr	x8
  121b78: f9003700     	str	x0, [x24, #0x68]
  121b7c: f9400268     	ldr	x8, [x19]
  121b80: f94566e1     	ldr	x1, [x23, #0xac8]
  121b84: 90002402     	adrp	x2, 0x5a1000
  121b88: 91373042     	add	x2, x2, #0xdcc
  121b8c: f9408508     	ldr	x8, [x8, #0x108]
  121b90: aa1303e0     	mov	x0, x19
  121b94: aa1403e3     	mov	x3, x20
  121b98: d63f0100     	blr	x8
  121b9c: f9003b00     	str	x0, [x24, #0x70]
  121ba0: f9400268     	ldr	x8, [x19]

## 121bb0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121b90: aa1303e0     	mov	x0, x19
  121b94: aa1403e3     	mov	x3, x20
  121b98: d63f0100     	blr	x8
  121b9c: f9003b00     	str	x0, [x24, #0x70]
  121ba0: f9400268     	ldr	x8, [x19]
  121ba4: f94566e1     	ldr	x1, [x23, #0xac8]
  121ba8: 90002402     	adrp	x2, 0x5a1000
  121bac: 900023e3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  121bb0: f9408508     	ldr	x8, [x8, #0x108]
  121bb4: 91377442     	add	x2, x2, #0xddd
  121bb8: 91152c63     	add	x3, x3, #0x54b
  121bbc: aa1303e0     	mov	x0, x19
  121bc0: d63f0100     	blr	x8
  121bc4: f9003f00     	str	x0, [x24, #0x78]

## 121bd8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121bb8: 91152c63     	add	x3, x3, #0x54b
  121bbc: aa1303e0     	mov	x0, x19
  121bc0: d63f0100     	blr	x8
  121bc4: f9003f00     	str	x0, [x24, #0x78]
  121bc8: f9400268     	ldr	x8, [x19]
  121bcc: f94566e1     	ldr	x1, [x23, #0xac8]
  121bd0: 90002402     	adrp	x2, 0x5a1000
  121bd4: 9137b042     	add	x2, x2, #0xdec
  121bd8: f9408508     	ldr	x8, [x8, #0x108]
  121bdc: aa1303e0     	mov	x0, x19
  121be0: aa1403e3     	mov	x3, x20
  121be4: d63f0100     	blr	x8
  121be8: f9004300     	str	x0, [x24, #0x80]
  121bec: f9400268     	ldr	x8, [x19]

## 121bfc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121bdc: aa1303e0     	mov	x0, x19
  121be0: aa1403e3     	mov	x3, x20
  121be4: d63f0100     	blr	x8
  121be8: f9004300     	str	x0, [x24, #0x80]
  121bec: f9400268     	ldr	x8, [x19]
  121bf0: f94566e1     	ldr	x1, [x23, #0xac8]
  121bf4: 90002402     	adrp	x2, 0x5a1000
  121bf8: 9137e042     	add	x2, x2, #0xdf8
  121bfc: f9408508     	ldr	x8, [x8, #0x108]
  121c00: aa1303e0     	mov	x0, x19
  121c04: aa1403e3     	mov	x3, x20
  121c08: d63f0100     	blr	x8
  121c0c: f9004700     	str	x0, [x24, #0x88]
  121c10: f9400268     	ldr	x8, [x19]

## 121c20 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  121c00: aa1303e0     	mov	x0, x19
  121c04: aa1403e3     	mov	x3, x20
  121c08: d63f0100     	blr	x8
  121c0c: f9004700     	str	x0, [x24, #0x88]
  121c10: f9400268     	ldr	x8, [x19]
  121c14: f94566e1     	ldr	x1, [x23, #0xac8]
  121c18: 90002402     	adrp	x2, 0x5a1000
  121c1c: 91384c42     	add	x2, x2, #0xe13
  121c20: f9408508     	ldr	x8, [x8, #0x108]
  121c24: aa1303e0     	mov	x0, x19
  121c28: aa1403e3     	mov	x3, x20
  121c2c: d63f0100     	blr	x8
  121c30: f9004b00     	str	x0, [x24, #0x90]
  121c34: 910023e0     	add	x0, sp, #0x8

## 12267c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12265c: aa1303e0     	mov	x0, x19
  122660: f9405508     	ldr	x8, [x8, #0xa8]
  122664: d63f0100     	blr	x8
  122668: f905c6c0     	str	x0, [x22, #0xb88]
  12266c: f9400268     	ldr	x8, [x19]
  122670: f00023d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  122674: f00023e2     	adrp	x2, 0x5a1000
  122678: 910fce94     	add	x20, x20, #0x3f3
  12267c: f9408508     	ldr	x8, [x8, #0x108]
  122680: aa0003e1     	mov	x1, x0
  122684: 913a0042     	add	x2, x2, #0xe80
  122688: aa1303e0     	mov	x0, x19
  12268c: aa1403e3     	mov	x3, x20
  122690: d63f0100     	blr	x8

## 1226b0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122690: d63f0100     	blr	x8
  122694: d00030f7     	adrp	x23, 0x740000
  122698: 912e42f7     	add	x23, x23, #0xb90
  12269c: f90002e0     	str	x0, [x23]
  1226a0: f9400268     	ldr	x8, [x19]
  1226a4: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226a8: f00023e2     	adrp	x2, 0x5a1000
  1226ac: 9131c442     	add	x2, x2, #0xc71
  1226b0: f9408508     	ldr	x8, [x8, #0x108]
  1226b4: aa1303e0     	mov	x0, x19
  1226b8: aa1403e3     	mov	x3, x20
  1226bc: d63f0100     	blr	x8
  1226c0: f9000ee0     	str	x0, [x23, #0x18]
  1226c4: f9400268     	ldr	x8, [x19]

## 1226d4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1226b4: aa1303e0     	mov	x0, x19
  1226b8: aa1403e3     	mov	x3, x20
  1226bc: d63f0100     	blr	x8
  1226c0: f9000ee0     	str	x0, [x23, #0x18]
  1226c4: f9400268     	ldr	x8, [x19]
  1226c8: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226cc: f00023e2     	adrp	x2, 0x5a1000
  1226d0: 91320842     	add	x2, x2, #0xc82
  1226d4: f9408508     	ldr	x8, [x8, #0x108]
  1226d8: aa1303e0     	mov	x0, x19
  1226dc: aa1403e3     	mov	x3, x20
  1226e0: d63f0100     	blr	x8
  1226e4: f90006e0     	str	x0, [x23, #0x8]
  1226e8: f9400268     	ldr	x8, [x19]

## 1226f8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1226d8: aa1303e0     	mov	x0, x19
  1226dc: aa1403e3     	mov	x3, x20
  1226e0: d63f0100     	blr	x8
  1226e4: f90006e0     	str	x0, [x23, #0x8]
  1226e8: f9400268     	ldr	x8, [x19]
  1226ec: f945c6c1     	ldr	x1, [x22, #0xb88]
  1226f0: f00023e2     	adrp	x2, 0x5a1000
  1226f4: 91324442     	add	x2, x2, #0xc91
  1226f8: f9408508     	ldr	x8, [x8, #0x108]
  1226fc: aa1303e0     	mov	x0, x19
  122700: aa1403e3     	mov	x3, x20
  122704: d63f0100     	blr	x8
  122708: f9000ae0     	str	x0, [x23, #0x10]
  12270c: f9400268     	ldr	x8, [x19]

## 12271c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1226fc: aa1303e0     	mov	x0, x19
  122700: aa1403e3     	mov	x3, x20
  122704: d63f0100     	blr	x8
  122708: f9000ae0     	str	x0, [x23, #0x10]
  12270c: f9400268     	ldr	x8, [x19]
  122710: f945c6c1     	ldr	x1, [x22, #0xb88]
  122714: f00023e2     	adrp	x2, 0x5a1000
  122718: 91335c42     	add	x2, x2, #0xcd7
  12271c: f9408508     	ldr	x8, [x8, #0x108]
  122720: aa1303e0     	mov	x0, x19
  122724: aa1403e3     	mov	x3, x20
  122728: d63f0100     	blr	x8
  12272c: f9001ee0     	str	x0, [x23, #0x38]
  122730: f9400268     	ldr	x8, [x19]

## 122740 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122720: aa1303e0     	mov	x0, x19
  122724: aa1403e3     	mov	x3, x20
  122728: d63f0100     	blr	x8
  12272c: f9001ee0     	str	x0, [x23, #0x38]
  122730: f9400268     	ldr	x8, [x19]
  122734: f945c6c1     	ldr	x1, [x22, #0xb88]
  122738: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  12273c: 91149c42     	add	x2, x2, #0x527
  122740: f9408508     	ldr	x8, [x8, #0x108]
  122744: aa1303e0     	mov	x0, x19
  122748: aa1403e3     	mov	x3, x20
  12274c: d63f0100     	blr	x8
  122750: f90022e0     	str	x0, [x23, #0x40]
  122754: f9400268     	ldr	x8, [x19]

## 122764 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122744: aa1303e0     	mov	x0, x19
  122748: aa1403e3     	mov	x3, x20
  12274c: d63f0100     	blr	x8
  122750: f90022e0     	str	x0, [x23, #0x40]
  122754: f9400268     	ldr	x8, [x19]
  122758: f945c6c1     	ldr	x1, [x22, #0xb88]
  12275c: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  122760: 9114d042     	add	x2, x2, #0x534
  122764: f9408508     	ldr	x8, [x8, #0x108]
  122768: aa1303e0     	mov	x0, x19
  12276c: aa1403e3     	mov	x3, x20
  122770: d63f0100     	blr	x8
  122774: f90026e0     	str	x0, [x23, #0x48]
  122778: f9400268     	ldr	x8, [x19]

## 122788 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122768: aa1303e0     	mov	x0, x19
  12276c: aa1403e3     	mov	x3, x20
  122770: d63f0100     	blr	x8
  122774: f90026e0     	str	x0, [x23, #0x48]
  122778: f9400268     	ldr	x8, [x19]
  12277c: f945c6c1     	ldr	x1, [x22, #0xb88]
  122780: f00023e2     	adrp	x2, 0x5a1000
  122784: 913a2c42     	add	x2, x2, #0xe8b
  122788: f9408508     	ldr	x8, [x8, #0x108]
  12278c: aa1303e0     	mov	x0, x19
  122790: aa1403e3     	mov	x3, x20
  122794: d63f0100     	blr	x8
  122798: f90012e0     	str	x0, [x23, #0x20]
  12279c: f9400268     	ldr	x8, [x19]

## 1227ac — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12278c: aa1303e0     	mov	x0, x19
  122790: aa1403e3     	mov	x3, x20
  122794: d63f0100     	blr	x8
  122798: f90012e0     	str	x0, [x23, #0x20]
  12279c: f9400268     	ldr	x8, [x19]
  1227a0: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227a4: f00023e2     	adrp	x2, 0x5a1000
  1227a8: 913a6442     	add	x2, x2, #0xe99
  1227ac: f9408508     	ldr	x8, [x8, #0x108]
  1227b0: aa1303e0     	mov	x0, x19
  1227b4: aa1403e3     	mov	x3, x20
  1227b8: d63f0100     	blr	x8
  1227bc: f90016e0     	str	x0, [x23, #0x28]
  1227c0: f9400268     	ldr	x8, [x19]

## 1227d0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1227b0: aa1303e0     	mov	x0, x19
  1227b4: aa1403e3     	mov	x3, x20
  1227b8: d63f0100     	blr	x8
  1227bc: f90016e0     	str	x0, [x23, #0x28]
  1227c0: f9400268     	ldr	x8, [x19]
  1227c4: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227c8: f00023e2     	adrp	x2, 0x5a1000
  1227cc: 913a9442     	add	x2, x2, #0xea5
  1227d0: f9408508     	ldr	x8, [x8, #0x108]
  1227d4: aa1303e0     	mov	x0, x19
  1227d8: aa1403e3     	mov	x3, x20
  1227dc: d63f0100     	blr	x8
  1227e0: f9001ae0     	str	x0, [x23, #0x30]
  1227e4: f9400268     	ldr	x8, [x19]

## 1227f4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1227d4: aa1303e0     	mov	x0, x19
  1227d8: aa1403e3     	mov	x3, x20
  1227dc: d63f0100     	blr	x8
  1227e0: f9001ae0     	str	x0, [x23, #0x30]
  1227e4: f9400268     	ldr	x8, [x19]
  1227e8: f945c6c1     	ldr	x1, [x22, #0xb88]
  1227ec: f00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1227f0: 91153c42     	add	x2, x2, #0x54f
  1227f4: f9408508     	ldr	x8, [x8, #0x108]
  1227f8: aa1303e0     	mov	x0, x19
  1227fc: aa1403e3     	mov	x3, x20
  122800: d63f0100     	blr	x8
  122804: f9002ae0     	str	x0, [x23, #0x50]
  122808: f9400268     	ldr	x8, [x19]

## 122818 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1227f8: aa1303e0     	mov	x0, x19
  1227fc: aa1403e3     	mov	x3, x20
  122800: d63f0100     	blr	x8
  122804: f9002ae0     	str	x0, [x23, #0x50]
  122808: f9400268     	ldr	x8, [x19]
  12280c: f945c6c1     	ldr	x1, [x22, #0xb88]
  122810: f00023e2     	adrp	x2, 0x5a1000
  122814: b00023e3     	adrp	x3, 0x59f000
  122818: f9408508     	ldr	x8, [x8, #0x108]
  12281c: 9135f042     	add	x2, x2, #0xd7c
  122820: 911a3463     	add	x3, x3, #0x68d
  122824: aa1303e0     	mov	x0, x19
  122828: d63f0100     	blr	x8
  12282c: f9002ee0     	str	x0, [x23, #0x58]

## 122840 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122820: 911a3463     	add	x3, x3, #0x68d
  122824: aa1303e0     	mov	x0, x19
  122828: d63f0100     	blr	x8
  12282c: f9002ee0     	str	x0, [x23, #0x58]
  122830: f9400268     	ldr	x8, [x19]
  122834: f945c6c1     	ldr	x1, [x22, #0xb88]
  122838: f00023e2     	adrp	x2, 0x5a1000
  12283c: 91338442     	add	x2, x2, #0xce1
  122840: f9408508     	ldr	x8, [x8, #0x108]
  122844: aa1303e0     	mov	x0, x19
  122848: aa1403e3     	mov	x3, x20
  12284c: d63f0100     	blr	x8
  122850: f90032e0     	str	x0, [x23, #0x60]
  122854: f9400268     	ldr	x8, [x19]

## 122864 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaVidAuth9convertToEP7_JNIEnvRK13VidAuthSource
Basis: object-vptr load found but constructor provenance is not established
ASM:
  122844: aa1303e0     	mov	x0, x19
  122848: aa1403e3     	mov	x3, x20
  12284c: d63f0100     	blr	x8
  122850: f90032e0     	str	x0, [x23, #0x60]
  122854: f9400268     	ldr	x8, [x19]
  122858: f945c6c1     	ldr	x1, [x22, #0xb88]
  12285c: f00023e2     	adrp	x2, 0x5a1000
  122860: 91355042     	add	x2, x2, #0xd54
  122864: f9408508     	ldr	x8, [x8, #0x108]
  122868: aa1303e0     	mov	x0, x19
  12286c: aa1403e3     	mov	x3, x20
  122870: d63f0100     	blr	x8
  122874: f90036e0     	str	x0, [x23, #0x68]
  122878: 910023e0     	add	x0, sp, #0x8

## 123028 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123008: aa1303e0     	mov	x0, x19
  12300c: f9405508     	ldr	x8, [x8, #0xa8]
  123010: d63f0100     	blr	x8
  123014: f90602c0     	str	x0, [x22, #0xc00]
  123018: f9400268     	ldr	x8, [x19]
  12301c: d00023d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  123020: d00023e2     	adrp	x2, 0x5a1000
  123024: 910fce94     	add	x20, x20, #0x3f3
  123028: f9408508     	ldr	x8, [x8, #0x108]
  12302c: aa0003e1     	mov	x1, x0
  123030: 9131c442     	add	x2, x2, #0xc71
  123034: aa1303e0     	mov	x0, x19
  123038: aa1403e3     	mov	x3, x20
  12303c: d63f0100     	blr	x8

## 123058 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123038: aa1403e3     	mov	x3, x20
  12303c: d63f0100     	blr	x8
  123040: b00030e8     	adrp	x8, 0x740000
  123044: f9061900     	str	x0, [x8, #0xc30]
  123048: f9400268     	ldr	x8, [x19]
  12304c: f94602c1     	ldr	x1, [x22, #0xc00]
  123050: d00023e2     	adrp	x2, 0x5a1000
  123054: 91320842     	add	x2, x2, #0xc82
  123058: f9408508     	ldr	x8, [x8, #0x108]
  12305c: aa1303e0     	mov	x0, x19
  123060: aa1403e3     	mov	x3, x20
  123064: d63f0100     	blr	x8
  123068: b00030e8     	adrp	x8, 0x740000
  12306c: f9061d00     	str	x0, [x8, #0xc38]

## 123080 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123060: aa1403e3     	mov	x3, x20
  123064: d63f0100     	blr	x8
  123068: b00030e8     	adrp	x8, 0x740000
  12306c: f9061d00     	str	x0, [x8, #0xc38]
  123070: f9400268     	ldr	x8, [x19]
  123074: f94602c1     	ldr	x1, [x22, #0xc00]
  123078: d00023e2     	adrp	x2, 0x5a1000
  12307c: 91324442     	add	x2, x2, #0xc91
  123080: f9408508     	ldr	x8, [x8, #0x108]
  123084: aa1303e0     	mov	x0, x19
  123088: aa1403e3     	mov	x3, x20
  12308c: d63f0100     	blr	x8
  123090: b00030e8     	adrp	x8, 0x740000
  123094: f9062100     	str	x0, [x8, #0xc40]

## 1230a8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123088: aa1403e3     	mov	x3, x20
  12308c: d63f0100     	blr	x8
  123090: b00030e8     	adrp	x8, 0x740000
  123094: f9062100     	str	x0, [x8, #0xc40]
  123098: f9400268     	ldr	x8, [x19]
  12309c: f94602c1     	ldr	x1, [x22, #0xc00]
  1230a0: d00023e2     	adrp	x2, 0x5a1000
  1230a4: 91335c42     	add	x2, x2, #0xcd7
  1230a8: f9408508     	ldr	x8, [x8, #0x108]
  1230ac: aa1303e0     	mov	x0, x19
  1230b0: aa1403e3     	mov	x3, x20
  1230b4: d63f0100     	blr	x8
  1230b8: b00030e8     	adrp	x8, 0x740000
  1230bc: f9062500     	str	x0, [x8, #0xc48]

## 1230d0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1230b0: aa1403e3     	mov	x3, x20
  1230b4: d63f0100     	blr	x8
  1230b8: b00030e8     	adrp	x8, 0x740000
  1230bc: f9062500     	str	x0, [x8, #0xc48]
  1230c0: f9400268     	ldr	x8, [x19]
  1230c4: f94602c1     	ldr	x1, [x22, #0xc00]
  1230c8: d00023e2     	adrp	x2, 0x5a1000
  1230cc: d00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1230d0: f9408508     	ldr	x8, [x8, #0x108]
  1230d4: 913b5042     	add	x2, x2, #0xed4
  1230d8: 91174463     	add	x3, x3, #0x5d1
  1230dc: aa1303e0     	mov	x0, x19
  1230e0: d63f0100     	blr	x8
  1230e4: b00030e8     	adrp	x8, 0x740000

## 1230fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1230dc: aa1303e0     	mov	x0, x19
  1230e0: d63f0100     	blr	x8
  1230e4: b00030e8     	adrp	x8, 0x740000
  1230e8: f9061500     	str	x0, [x8, #0xc28]
  1230ec: f9400268     	ldr	x8, [x19]
  1230f0: f94602c1     	ldr	x1, [x22, #0xc00]
  1230f4: d00023e2     	adrp	x2, 0x5a1000
  1230f8: 913bac42     	add	x2, x2, #0xeeb
  1230fc: f9408508     	ldr	x8, [x8, #0x108]
  123100: aa1303e0     	mov	x0, x19
  123104: aa1403e3     	mov	x3, x20
  123108: d63f0100     	blr	x8
  12310c: b00030e8     	adrp	x8, 0x740000
  123110: f9060500     	str	x0, [x8, #0xc08]

## 123124 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123104: aa1403e3     	mov	x3, x20
  123108: d63f0100     	blr	x8
  12310c: b00030e8     	adrp	x8, 0x740000
  123110: f9060500     	str	x0, [x8, #0xc08]
  123114: f9400268     	ldr	x8, [x19]
  123118: f94602c1     	ldr	x1, [x22, #0xc00]
  12311c: d00023e2     	adrp	x2, 0x5a1000
  123120: 913bc842     	add	x2, x2, #0xef2
  123124: f9408508     	ldr	x8, [x8, #0x108]
  123128: aa1303e0     	mov	x0, x19
  12312c: aa1403e3     	mov	x3, x20
  123130: d63f0100     	blr	x8
  123134: b00030e8     	adrp	x8, 0x740000
  123138: f9060900     	str	x0, [x8, #0xc10]

## 12314c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12312c: aa1403e3     	mov	x3, x20
  123130: d63f0100     	blr	x8
  123134: b00030e8     	adrp	x8, 0x740000
  123138: f9060900     	str	x0, [x8, #0xc10]
  12313c: f9400268     	ldr	x8, [x19]
  123140: f94602c1     	ldr	x1, [x22, #0xc00]
  123144: d00023e2     	adrp	x2, 0x5a1000
  123148: 913bf042     	add	x2, x2, #0xefc
  12314c: f9408508     	ldr	x8, [x8, #0x108]
  123150: aa1303e0     	mov	x0, x19
  123154: aa1403e3     	mov	x3, x20
  123158: d63f0100     	blr	x8
  12315c: b00030e8     	adrp	x8, 0x740000
  123160: f9060d00     	str	x0, [x8, #0xc18]

## 123174 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  123154: aa1403e3     	mov	x3, x20
  123158: d63f0100     	blr	x8
  12315c: b00030e8     	adrp	x8, 0x740000
  123160: f9060d00     	str	x0, [x8, #0xc18]
  123164: f9400268     	ldr	x8, [x19]
  123168: f94602c1     	ldr	x1, [x22, #0xc00]
  12316c: d00023e2     	adrp	x2, 0x5a1000
  123170: 913c0c42     	add	x2, x2, #0xf03
  123174: f9408508     	ldr	x8, [x8, #0x108]
  123178: aa1303e0     	mov	x0, x19
  12317c: aa1403e3     	mov	x3, x20
  123180: d63f0100     	blr	x8
  123184: b00030e8     	adrp	x8, 0x740000
  123188: f9061100     	str	x0, [x8, #0xc20]

## 12319c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12317c: aa1403e3     	mov	x3, x20
  123180: d63f0100     	blr	x8
  123184: b00030e8     	adrp	x8, 0x740000
  123188: f9061100     	str	x0, [x8, #0xc20]
  12318c: f9400268     	ldr	x8, [x19]
  123190: f94602c1     	ldr	x1, [x22, #0xc00]
  123194: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  123198: 91149c42     	add	x2, x2, #0x527
  12319c: f9408508     	ldr	x8, [x8, #0x108]
  1231a0: aa1303e0     	mov	x0, x19
  1231a4: aa1403e3     	mov	x3, x20
  1231a8: d63f0100     	blr	x8
  1231ac: b00030e8     	adrp	x8, 0x740000
  1231b0: f9062900     	str	x0, [x8, #0xc50]

## 1231c4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1231a4: aa1403e3     	mov	x3, x20
  1231a8: d63f0100     	blr	x8
  1231ac: b00030e8     	adrp	x8, 0x740000
  1231b0: f9062900     	str	x0, [x8, #0xc50]
  1231b4: f9400268     	ldr	x8, [x19]
  1231b8: f94602c1     	ldr	x1, [x22, #0xc00]
  1231bc: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1231c0: 9114d042     	add	x2, x2, #0x534
  1231c4: f9408508     	ldr	x8, [x8, #0x108]
  1231c8: aa1303e0     	mov	x0, x19
  1231cc: aa1403e3     	mov	x3, x20
  1231d0: d63f0100     	blr	x8
  1231d4: b00030e8     	adrp	x8, 0x740000
  1231d8: f9062d00     	str	x0, [x8, #0xc58]

## 1231ec — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1231cc: aa1403e3     	mov	x3, x20
  1231d0: d63f0100     	blr	x8
  1231d4: b00030e8     	adrp	x8, 0x740000
  1231d8: f9062d00     	str	x0, [x8, #0xc58]
  1231dc: f9400268     	ldr	x8, [x19]
  1231e0: f94602c1     	ldr	x1, [x22, #0xc00]
  1231e4: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1231e8: 91153c42     	add	x2, x2, #0x54f
  1231ec: f9408508     	ldr	x8, [x8, #0x108]
  1231f0: aa1303e0     	mov	x0, x19
  1231f4: aa1403e3     	mov	x3, x20
  1231f8: d63f0100     	blr	x8
  1231fc: b00030e8     	adrp	x8, 0x740000
  123200: f9063100     	str	x0, [x8, #0xc60]

## 123214 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN11JavaLiveSts4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1231f4: aa1403e3     	mov	x3, x20
  1231f8: d63f0100     	blr	x8
  1231fc: b00030e8     	adrp	x8, 0x740000
  123200: f9063100     	str	x0, [x8, #0xc60]
  123204: f9400268     	ldr	x8, [x19]
  123208: f94602c1     	ldr	x1, [x22, #0xc00]
  12320c: d00023e2     	adrp	x2, 0x5a1000
  123210: 900023e3     	adrp	x3, 0x59f000
  123214: f9408508     	ldr	x8, [x8, #0x108]
  123218: 9135f042     	add	x2, x2, #0xd7c
  12321c: 911a3463     	add	x3, x3, #0x68d
  123220: aa1303e0     	mov	x0, x19
  123224: d63f0100     	blr	x8
  123228: b00030e8     	adrp	x8, 0x740000

## 1236e0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1236c0: f94002c1     	ldr	x1, [x22]
  1236c4: d00023d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  1236c8: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1236cc: f9000100     	str	x0, [x8]
  1236d0: f9400268     	ldr	x8, [x19]
  1236d4: 910fce94     	add	x20, x20, #0x3f3
  1236d8: 91149c42     	add	x2, x2, #0x527
  1236dc: aa1303e0     	mov	x0, x19
  1236e0: f9408508     	ldr	x8, [x8, #0x108]
  1236e4: aa1403e3     	mov	x3, x20
  1236e8: d63f0100     	blr	x8
  1236ec: 90003088     	adrp	x8, 0x733000
  1236f0: f9467d08     	ldr	x8, [x8, #0xcf8]
  1236f4: f94002c1     	ldr	x1, [x22]

## 123710 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1236f0: f9467d08     	ldr	x8, [x8, #0xcf8]
  1236f4: f94002c1     	ldr	x1, [x22]
  1236f8: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1236fc: 9114d042     	add	x2, x2, #0x534
  123700: f9000100     	str	x0, [x8]
  123704: f9400268     	ldr	x8, [x19]
  123708: aa1303e0     	mov	x0, x19
  12370c: aa1403e3     	mov	x3, x20
  123710: f9408508     	ldr	x8, [x8, #0x108]
  123714: d63f0100     	blr	x8
  123718: 90003088     	adrp	x8, 0x733000
  12371c: f9468108     	ldr	x8, [x8, #0xd00]
  123720: f94002c1     	ldr	x1, [x22]
  123724: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>

## 12373c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12371c: f9468108     	ldr	x8, [x8, #0xd00]
  123720: f94002c1     	ldr	x1, [x22]
  123724: d00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  123728: 91153c42     	add	x2, x2, #0x54f
  12372c: f9000100     	str	x0, [x8]
  123730: f9400268     	ldr	x8, [x19]
  123734: aa1303e0     	mov	x0, x19
  123738: aa1403e3     	mov	x3, x20
  12373c: f9408508     	ldr	x8, [x8, #0x108]
  123740: d63f0100     	blr	x8
  123744: 90003088     	adrp	x8, 0x733000
  123748: f9468508     	ldr	x8, [x8, #0xd08]
  12374c: f94002c1     	ldr	x1, [x22]
  123750: d00023e2     	adrp	x2, 0x5a1000

## 12376c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12374c: f94002c1     	ldr	x1, [x22]
  123750: d00023e2     	adrp	x2, 0x5a1000
  123754: 900023e3     	adrp	x3, 0x59f000
  123758: f9000100     	str	x0, [x8]
  12375c: f9400268     	ldr	x8, [x19]
  123760: 9135f042     	add	x2, x2, #0xd7c
  123764: 911a3463     	add	x3, x3, #0x68d
  123768: aa1303e0     	mov	x0, x19
  12376c: f9408508     	ldr	x8, [x8, #0x108]
  123770: d63f0100     	blr	x8
  123774: 90003088     	adrp	x8, 0x733000
  123778: f9468908     	ldr	x8, [x8, #0xd10]
  12377c: 900023e1     	adrp	x1, 0x59f000
  123780: 91185821     	add	x1, x1, #0x616

## 1237d4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1237b4: 900023e2     	adrp	x2, 0x59f000
  1237b8: d00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1237bc: aa0003e1     	mov	x1, x0
  1237c0: f9000280     	str	x0, [x20]
  1237c4: f9400268     	ldr	x8, [x19]
  1237c8: 9109c442     	add	x2, x2, #0x271
  1237cc: 91174463     	add	x3, x3, #0x5d1
  1237d0: aa1303e0     	mov	x0, x19
  1237d4: f9408508     	ldr	x8, [x8, #0x108]
  1237d8: d63f0100     	blr	x8
  1237dc: 90003088     	adrp	x8, 0x733000
  1237e0: f9469108     	ldr	x8, [x8, #0xd20]
  1237e4: f9400281     	ldr	x1, [x20]
  1237e8: f00023c2     	adrp	x2, 0x59e000

## 123804 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN12JavaVodAsset4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1237e4: f9400281     	ldr	x1, [x20]
  1237e8: f00023c2     	adrp	x2, 0x59e000
  1237ec: 900023e3     	adrp	x3, 0x59f000
  1237f0: f9000100     	str	x0, [x8]
  1237f4: f9400268     	ldr	x8, [x19]
  1237f8: 913b1842     	add	x2, x2, #0xec6
  1237fc: 91189463     	add	x3, x3, #0x625
  123800: aa1303e0     	mov	x0, x19
  123804: f9408508     	ldr	x8, [x8, #0x108]
  123808: d63f0100     	blr	x8
  12380c: 90003088     	adrp	x8, 0x733000
  123810: f9469508     	ldr	x8, [x8, #0xd28]
  123814: f9000100     	str	x0, [x8]
  123818: f94016a8     	ldr	x8, [x21, #0x28]

## 124988 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124968: aa1303e0     	mov	x0, x19
  12496c: f9405508     	ldr	x8, [x8, #0xa8]
  124970: d63f0100     	blr	x8
  124974: f9067380     	str	x0, [x28, #0xce0]
  124978: f9400268     	ldr	x8, [x19]
  12497c: b00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  124980: b00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  124984: aa0003e1     	mov	x1, x0
  124988: f9408508     	ldr	x8, [x8, #0x108]
  12498c: 91141042     	add	x2, x2, #0x504
  124990: 91158463     	add	x3, x3, #0x561
  124994: aa1303e0     	mov	x0, x19
  124998: d63f0100     	blr	x8
  12499c: 900030fb     	adrp	x27, 0x740000

## 1249b8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124998: d63f0100     	blr	x8
  12499c: 900030fb     	adrp	x27, 0x740000
  1249a0: 9134037b     	add	x27, x27, #0xd00
  1249a4: f9000360     	str	x0, [x27]
  1249a8: f9400268     	ldr	x8, [x19]
  1249ac: f9467381     	ldr	x1, [x28, #0xce0]
  1249b0: b00023d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  1249b4: b00023e2     	adrp	x2, 0x5a1000
  1249b8: f9408508     	ldr	x8, [x8, #0x108]
  1249bc: 910fce94     	add	x20, x20, #0x3f3
  1249c0: 913ec842     	add	x2, x2, #0xfb2
  1249c4: aa1303e0     	mov	x0, x19
  1249c8: aa1403e3     	mov	x3, x20
  1249cc: d63f0100     	blr	x8

## 1249e4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1249c4: aa1303e0     	mov	x0, x19
  1249c8: aa1403e3     	mov	x3, x20
  1249cc: d63f0100     	blr	x8
  1249d0: f9000760     	str	x0, [x27, #0x8]
  1249d4: f9400268     	ldr	x8, [x19]
  1249d8: f9467381     	ldr	x1, [x28, #0xce0]
  1249dc: b00023e2     	adrp	x2, 0x5a1000
  1249e0: 913efc42     	add	x2, x2, #0xfbf
  1249e4: f9408508     	ldr	x8, [x8, #0x108]
  1249e8: aa1303e0     	mov	x0, x19
  1249ec: aa1403e3     	mov	x3, x20
  1249f0: d63f0100     	blr	x8
  1249f4: f9000b60     	str	x0, [x27, #0x10]
  1249f8: f9400268     	ldr	x8, [x19]

## 124a08 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1249e8: aa1303e0     	mov	x0, x19
  1249ec: aa1403e3     	mov	x3, x20
  1249f0: d63f0100     	blr	x8
  1249f4: f9000b60     	str	x0, [x27, #0x10]
  1249f8: f9400268     	ldr	x8, [x19]
  1249fc: f9467381     	ldr	x1, [x28, #0xce0]
  124a00: b00023c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  124a04: 9114d042     	add	x2, x2, #0x534
  124a08: f9408508     	ldr	x8, [x8, #0x108]
  124a0c: aa1303e0     	mov	x0, x19
  124a10: aa1403e3     	mov	x3, x20
  124a14: d63f0100     	blr	x8
  124a18: f9000f60     	str	x0, [x27, #0x18]
  124a1c: f9400268     	ldr	x8, [x19]

## 124a2c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124a0c: aa1303e0     	mov	x0, x19
  124a10: aa1403e3     	mov	x3, x20
  124a14: d63f0100     	blr	x8
  124a18: f9000f60     	str	x0, [x27, #0x18]
  124a1c: f9400268     	ldr	x8, [x19]
  124a20: f9467381     	ldr	x1, [x28, #0xce0]
  124a24: b00023e2     	adrp	x2, 0x5a1000
  124a28: 913f2842     	add	x2, x2, #0xfca
  124a2c: f9408508     	ldr	x8, [x8, #0x108]
  124a30: aa1303e0     	mov	x0, x19
  124a34: aa1403e3     	mov	x3, x20
  124a38: d63f0100     	blr	x8
  124a3c: f9001360     	str	x0, [x27, #0x20]
  124a40: f9400268     	ldr	x8, [x19]

## 124a50 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124a30: aa1303e0     	mov	x0, x19
  124a34: aa1403e3     	mov	x3, x20
  124a38: d63f0100     	blr	x8
  124a3c: f9001360     	str	x0, [x27, #0x20]
  124a40: f9400268     	ldr	x8, [x19]
  124a44: f9467381     	ldr	x1, [x28, #0xce0]
  124a48: b00023e2     	adrp	x2, 0x5a1000
  124a4c: 913f5842     	add	x2, x2, #0xfd6
  124a50: f9408508     	ldr	x8, [x8, #0x108]
  124a54: aa1303e0     	mov	x0, x19
  124a58: aa1403e3     	mov	x3, x20
  124a5c: d63f0100     	blr	x8
  124a60: f9001760     	str	x0, [x27, #0x28]
  124a64: f9400268     	ldr	x8, [x19]

## 124a74 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124a54: aa1303e0     	mov	x0, x19
  124a58: aa1403e3     	mov	x3, x20
  124a5c: d63f0100     	blr	x8
  124a60: f9001760     	str	x0, [x27, #0x28]
  124a64: f9400268     	ldr	x8, [x19]
  124a68: f9467381     	ldr	x1, [x28, #0xce0]
  124a6c: b00023f6     	adrp	x22, 0x5a1000
  124a70: 913f9ed6     	add	x22, x22, #0xfe7
  124a74: f9408508     	ldr	x8, [x8, #0x108]
  124a78: aa1303e0     	mov	x0, x19
  124a7c: aa1603e2     	mov	x2, x22
  124a80: aa1403e3     	mov	x3, x20
  124a84: d63f0100     	blr	x8
  124a88: f9001b60     	str	x0, [x27, #0x30]

## 124a9c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124a7c: aa1603e2     	mov	x2, x22
  124a80: aa1403e3     	mov	x3, x20
  124a84: d63f0100     	blr	x8
  124a88: f9001b60     	str	x0, [x27, #0x30]
  124a8c: f9400268     	ldr	x8, [x19]
  124a90: f9467381     	ldr	x1, [x28, #0xce0]
  124a94: b00023f7     	adrp	x23, 0x5a1000
  124a98: 913fdef7     	add	x23, x23, #0xff7
  124a9c: f9408508     	ldr	x8, [x8, #0x108]
  124aa0: aa1303e0     	mov	x0, x19
  124aa4: aa1703e2     	mov	x2, x23
  124aa8: aa1403e3     	mov	x3, x20
  124aac: d63f0100     	blr	x8
  124ab0: f9001f60     	str	x0, [x27, #0x38]

## 124ac4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124aa4: aa1703e2     	mov	x2, x23
  124aa8: aa1403e3     	mov	x3, x20
  124aac: d63f0100     	blr	x8
  124ab0: f9001f60     	str	x0, [x27, #0x38]
  124ab4: f9400268     	ldr	x8, [x19]
  124ab8: f9467381     	ldr	x1, [x28, #0xce0]
  124abc: d00023e2     	adrp	x2, 0x5a2000
  124ac0: 91000442     	add	x2, x2, #0x1
  124ac4: f9408508     	ldr	x8, [x8, #0x108]
  124ac8: aa1303e0     	mov	x0, x19
  124acc: aa1403e3     	mov	x3, x20
  124ad0: d63f0100     	blr	x8
  124ad4: f9002360     	str	x0, [x27, #0x40]
  124ad8: f9400268     	ldr	x8, [x19]

## 124b18 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124af8: aa1803e2     	mov	x2, x24
  124afc: aa1903e3     	mov	x3, x25
  124b00: d63f0100     	blr	x8
  124b04: f9002760     	str	x0, [x27, #0x48]
  124b08: f9400268     	ldr	x8, [x19]
  124b0c: f9467381     	ldr	x1, [x28, #0xce0]
  124b10: d00023e2     	adrp	x2, 0x5a2000
  124b14: 91006842     	add	x2, x2, #0x1a
  124b18: f9408508     	ldr	x8, [x8, #0x108]
  124b1c: aa1303e0     	mov	x0, x19
  124b20: aa1403e3     	mov	x3, x20
  124b24: d63f0100     	blr	x8
  124b28: f9002b60     	str	x0, [x27, #0x50]
  124b2c: f9400268     	ldr	x8, [x19]

## 124b3c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124b1c: aa1303e0     	mov	x0, x19
  124b20: aa1403e3     	mov	x3, x20
  124b24: d63f0100     	blr	x8
  124b28: f9002b60     	str	x0, [x27, #0x50]
  124b2c: f9400268     	ldr	x8, [x19]
  124b30: f9467381     	ldr	x1, [x28, #0xce0]
  124b34: d00023f5     	adrp	x21, 0x5a2000
  124b38: d00023e2     	adrp	x2, 0x5a2000
  124b3c: f9408508     	ldr	x8, [x8, #0x108]
  124b40: 9100e6b5     	add	x21, x21, #0x39
  124b44: 9100a042     	add	x2, x2, #0x28
  124b48: aa1303e0     	mov	x0, x19
  124b4c: aa1503e3     	mov	x3, x21
  124b50: d63f0100     	blr	x8

## 124b68 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124b48: aa1303e0     	mov	x0, x19
  124b4c: aa1503e3     	mov	x3, x21
  124b50: d63f0100     	blr	x8
  124b54: f9002f60     	str	x0, [x27, #0x58]
  124b58: f9400268     	ldr	x8, [x19]
  124b5c: f9467381     	ldr	x1, [x28, #0xce0]
  124b60: d00023e2     	adrp	x2, 0x5a2000
  124b64: 91013042     	add	x2, x2, #0x4c
  124b68: f9408508     	ldr	x8, [x8, #0x108]
  124b6c: aa1303e0     	mov	x0, x19
  124b70: aa1503e3     	mov	x3, x21
  124b74: d63f0100     	blr	x8
  124b78: d00023e2     	adrp	x2, 0x5a2000
  124b7c: f9003360     	str	x0, [x27, #0x60]

## 124bbc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124b9c: f9405508     	ldr	x8, [x8, #0xa8]
  124ba0: d63f0100     	blr	x8
  124ba4: 900030e8     	adrp	x8, 0x740000
  124ba8: f9067500     	str	x0, [x8, #0xce8]
  124bac: f9400268     	ldr	x8, [x19]
  124bb0: b00023e2     	adrp	x2, 0x5a1000
  124bb4: aa0003e1     	mov	x1, x0
  124bb8: 913bac42     	add	x2, x2, #0xeeb
  124bbc: f9408508     	ldr	x8, [x8, #0x108]
  124bc0: aa1303e0     	mov	x0, x19
  124bc4: aa1403e3     	mov	x3, x20
  124bc8: d63f0100     	blr	x8
  124bcc: d00023e2     	adrp	x2, 0x5a2000
  124bd0: f9003760     	str	x0, [x27, #0x68]

## 124c10 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124bf0: f9405508     	ldr	x8, [x8, #0xa8]
  124bf4: d63f0100     	blr	x8
  124bf8: 900030fc     	adrp	x28, 0x740000
  124bfc: f9067b80     	str	x0, [x28, #0xcf0]
  124c00: f9400268     	ldr	x8, [x19]
  124c04: d00023e2     	adrp	x2, 0x5a2000
  124c08: aa0003e1     	mov	x1, x0
  124c0c: 91032442     	add	x2, x2, #0xc9
  124c10: f9408508     	ldr	x8, [x8, #0x108]
  124c14: aa1303e0     	mov	x0, x19
  124c18: aa1403e3     	mov	x3, x20
  124c1c: d63f0100     	blr	x8
  124c20: f9003b60     	str	x0, [x27, #0x70]
  124c24: f9400268     	ldr	x8, [x19]

## 124c34 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124c14: aa1303e0     	mov	x0, x19
  124c18: aa1403e3     	mov	x3, x20
  124c1c: d63f0100     	blr	x8
  124c20: f9003b60     	str	x0, [x27, #0x70]
  124c24: f9400268     	ldr	x8, [x19]
  124c28: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c2c: d00023e2     	adrp	x2, 0x5a2000
  124c30: 91034c42     	add	x2, x2, #0xd3
  124c34: f9408508     	ldr	x8, [x8, #0x108]
  124c38: aa1303e0     	mov	x0, x19
  124c3c: aa1403e3     	mov	x3, x20
  124c40: d63f0100     	blr	x8
  124c44: f9003f60     	str	x0, [x27, #0x78]
  124c48: f9400268     	ldr	x8, [x19]

## 124c58 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124c38: aa1303e0     	mov	x0, x19
  124c3c: aa1403e3     	mov	x3, x20
  124c40: d63f0100     	blr	x8
  124c44: f9003f60     	str	x0, [x27, #0x78]
  124c48: f9400268     	ldr	x8, [x19]
  124c4c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c50: d00023e2     	adrp	x2, 0x5a2000
  124c54: 91038442     	add	x2, x2, #0xe1
  124c58: f9408508     	ldr	x8, [x8, #0x108]
  124c5c: aa1303e0     	mov	x0, x19
  124c60: aa1403e3     	mov	x3, x20
  124c64: d63f0100     	blr	x8
  124c68: f9004360     	str	x0, [x27, #0x80]
  124c6c: f9400268     	ldr	x8, [x19]

## 124c7c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124c5c: aa1303e0     	mov	x0, x19
  124c60: aa1403e3     	mov	x3, x20
  124c64: d63f0100     	blr	x8
  124c68: f9004360     	str	x0, [x27, #0x80]
  124c6c: f9400268     	ldr	x8, [x19]
  124c70: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c74: d00023e2     	adrp	x2, 0x5a2000
  124c78: 9103d442     	add	x2, x2, #0xf5
  124c7c: f9408508     	ldr	x8, [x8, #0x108]
  124c80: aa1303e0     	mov	x0, x19
  124c84: aa1403e3     	mov	x3, x20
  124c88: d63f0100     	blr	x8
  124c8c: f9004760     	str	x0, [x27, #0x88]
  124c90: f9400268     	ldr	x8, [x19]

## 124ca0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124c80: aa1303e0     	mov	x0, x19
  124c84: aa1403e3     	mov	x3, x20
  124c88: d63f0100     	blr	x8
  124c8c: f9004760     	str	x0, [x27, #0x88]
  124c90: f9400268     	ldr	x8, [x19]
  124c94: f9467b81     	ldr	x1, [x28, #0xcf0]
  124c98: b00023d5     	adrp	x21, 0x59d000 <__cxa_demangle+0x182b4>
  124c9c: d00023e2     	adrp	x2, 0x5a2000
  124ca0: f9408508     	ldr	x8, [x8, #0x108]
  124ca4: 911746b5     	add	x21, x21, #0x5d1
  124ca8: 91042442     	add	x2, x2, #0x109
  124cac: aa1303e0     	mov	x0, x19
  124cb0: aa1503e3     	mov	x3, x21
  124cb4: d63f0100     	blr	x8

## 124ccc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124cac: aa1303e0     	mov	x0, x19
  124cb0: aa1503e3     	mov	x3, x21
  124cb4: d63f0100     	blr	x8
  124cb8: f9004b60     	str	x0, [x27, #0x90]
  124cbc: f9400268     	ldr	x8, [x19]
  124cc0: f9467b81     	ldr	x1, [x28, #0xcf0]
  124cc4: d00023e2     	adrp	x2, 0x5a2000
  124cc8: 91044c42     	add	x2, x2, #0x113
  124ccc: f9408508     	ldr	x8, [x8, #0x108]
  124cd0: aa1303e0     	mov	x0, x19
  124cd4: aa1403e3     	mov	x3, x20
  124cd8: d63f0100     	blr	x8
  124cdc: f9004f60     	str	x0, [x27, #0x98]
  124ce0: f9400268     	ldr	x8, [x19]

## 124cf0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124cd0: aa1303e0     	mov	x0, x19
  124cd4: aa1403e3     	mov	x3, x20
  124cd8: d63f0100     	blr	x8
  124cdc: f9004f60     	str	x0, [x27, #0x98]
  124ce0: f9400268     	ldr	x8, [x19]
  124ce4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124ce8: aa1303e0     	mov	x0, x19
  124cec: aa1603e2     	mov	x2, x22
  124cf0: f9408508     	ldr	x8, [x8, #0x108]
  124cf4: aa1403e3     	mov	x3, x20
  124cf8: d63f0100     	blr	x8
  124cfc: f9005360     	str	x0, [x27, #0xa0]
  124d00: f9400268     	ldr	x8, [x19]
  124d04: f9467b81     	ldr	x1, [x28, #0xcf0]

## 124d10 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124cf0: f9408508     	ldr	x8, [x8, #0x108]
  124cf4: aa1403e3     	mov	x3, x20
  124cf8: d63f0100     	blr	x8
  124cfc: f9005360     	str	x0, [x27, #0xa0]
  124d00: f9400268     	ldr	x8, [x19]
  124d04: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d08: aa1303e0     	mov	x0, x19
  124d0c: aa1703e2     	mov	x2, x23
  124d10: f9408508     	ldr	x8, [x8, #0x108]
  124d14: aa1403e3     	mov	x3, x20
  124d18: d63f0100     	blr	x8
  124d1c: f9005760     	str	x0, [x27, #0xa8]
  124d20: f9400268     	ldr	x8, [x19]
  124d24: f9467b81     	ldr	x1, [x28, #0xcf0]

## 124d30 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124d10: f9408508     	ldr	x8, [x8, #0x108]
  124d14: aa1403e3     	mov	x3, x20
  124d18: d63f0100     	blr	x8
  124d1c: f9005760     	str	x0, [x27, #0xa8]
  124d20: f9400268     	ldr	x8, [x19]
  124d24: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d28: aa1303e0     	mov	x0, x19
  124d2c: aa1803e2     	mov	x2, x24
  124d30: f9408508     	ldr	x8, [x8, #0x108]
  124d34: aa1903e3     	mov	x3, x25
  124d38: d63f0100     	blr	x8
  124d3c: f9005b60     	str	x0, [x27, #0xb0]
  124d40: f9400268     	ldr	x8, [x19]
  124d44: f9467b81     	ldr	x1, [x28, #0xcf0]

## 124d50 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124d30: f9408508     	ldr	x8, [x8, #0x108]
  124d34: aa1903e3     	mov	x3, x25
  124d38: d63f0100     	blr	x8
  124d3c: f9005b60     	str	x0, [x27, #0xb0]
  124d40: f9400268     	ldr	x8, [x19]
  124d44: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d48: d00023e2     	adrp	x2, 0x5a2000
  124d4c: 91047842     	add	x2, x2, #0x11e
  124d50: f9408508     	ldr	x8, [x8, #0x108]
  124d54: aa1303e0     	mov	x0, x19
  124d58: aa1403e3     	mov	x3, x20
  124d5c: d63f0100     	blr	x8
  124d60: f9005f60     	str	x0, [x27, #0xb8]
  124d64: f9400268     	ldr	x8, [x19]

## 124d74 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124d54: aa1303e0     	mov	x0, x19
  124d58: aa1403e3     	mov	x3, x20
  124d5c: d63f0100     	blr	x8
  124d60: f9005f60     	str	x0, [x27, #0xb8]
  124d64: f9400268     	ldr	x8, [x19]
  124d68: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d6c: d00023e2     	adrp	x2, 0x5a2000
  124d70: 91049c42     	add	x2, x2, #0x127
  124d74: f9408508     	ldr	x8, [x8, #0x108]
  124d78: aa1303e0     	mov	x0, x19
  124d7c: aa1503e3     	mov	x3, x21
  124d80: d63f0100     	blr	x8
  124d84: f9006360     	str	x0, [x27, #0xc0]
  124d88: f9400268     	ldr	x8, [x19]

## 124d98 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124d78: aa1303e0     	mov	x0, x19
  124d7c: aa1503e3     	mov	x3, x21
  124d80: d63f0100     	blr	x8
  124d84: f9006360     	str	x0, [x27, #0xc0]
  124d88: f9400268     	ldr	x8, [x19]
  124d8c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124d90: d00023e2     	adrp	x2, 0x5a2000
  124d94: 9104c842     	add	x2, x2, #0x132
  124d98: f9408508     	ldr	x8, [x8, #0x108]
  124d9c: aa1303e0     	mov	x0, x19
  124da0: aa1403e3     	mov	x3, x20
  124da4: d63f0100     	blr	x8
  124da8: f9006760     	str	x0, [x27, #0xc8]
  124dac: f9400268     	ldr	x8, [x19]

## 124dbc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124d9c: aa1303e0     	mov	x0, x19
  124da0: aa1403e3     	mov	x3, x20
  124da4: d63f0100     	blr	x8
  124da8: f9006760     	str	x0, [x27, #0xc8]
  124dac: f9400268     	ldr	x8, [x19]
  124db0: f9467b81     	ldr	x1, [x28, #0xcf0]
  124db4: d00023e2     	adrp	x2, 0x5a2000
  124db8: 91050442     	add	x2, x2, #0x141
  124dbc: f9408508     	ldr	x8, [x8, #0x108]
  124dc0: aa1303e0     	mov	x0, x19
  124dc4: aa1503e3     	mov	x3, x21
  124dc8: d63f0100     	blr	x8
  124dcc: f9006b60     	str	x0, [x27, #0xd0]
  124dd0: f9400268     	ldr	x8, [x19]

## 124de0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124dc0: aa1303e0     	mov	x0, x19
  124dc4: aa1503e3     	mov	x3, x21
  124dc8: d63f0100     	blr	x8
  124dcc: f9006b60     	str	x0, [x27, #0xd0]
  124dd0: f9400268     	ldr	x8, [x19]
  124dd4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124dd8: d00023e2     	adrp	x2, 0x5a2000
  124ddc: 91052842     	add	x2, x2, #0x14a
  124de0: f9408508     	ldr	x8, [x8, #0x108]
  124de4: aa1303e0     	mov	x0, x19
  124de8: aa1503e3     	mov	x3, x21
  124dec: d63f0100     	blr	x8
  124df0: f9006f60     	str	x0, [x27, #0xd8]
  124df4: f9400268     	ldr	x8, [x19]

## 124e04 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124de4: aa1303e0     	mov	x0, x19
  124de8: aa1503e3     	mov	x3, x21
  124dec: d63f0100     	blr	x8
  124df0: f9006f60     	str	x0, [x27, #0xd8]
  124df4: f9400268     	ldr	x8, [x19]
  124df8: f9467b81     	ldr	x1, [x28, #0xcf0]
  124dfc: d00023e2     	adrp	x2, 0x5a2000
  124e00: d00023e3     	adrp	x3, 0x5a2000
  124e04: f9408508     	ldr	x8, [x8, #0x108]
  124e08: 91054442     	add	x2, x2, #0x151
  124e0c: 91057063     	add	x3, x3, #0x15c
  124e10: aa1303e0     	mov	x0, x19
  124e14: d63f0100     	blr	x8
  124e18: f9007360     	str	x0, [x27, #0xe0]

## 124e2c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124e0c: 91057063     	add	x3, x3, #0x15c
  124e10: aa1303e0     	mov	x0, x19
  124e14: d63f0100     	blr	x8
  124e18: f9007360     	str	x0, [x27, #0xe0]
  124e1c: f9400268     	ldr	x8, [x19]
  124e20: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e24: d00023e2     	adrp	x2, 0x5a2000
  124e28: b00023c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  124e2c: f9408508     	ldr	x8, [x8, #0x108]
  124e30: 91058042     	add	x2, x2, #0x160
  124e34: 91152c63     	add	x3, x3, #0x54b
  124e38: aa1303e0     	mov	x0, x19
  124e3c: d63f0100     	blr	x8
  124e40: f9007760     	str	x0, [x27, #0xe8]

## 124e54 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124e34: 91152c63     	add	x3, x3, #0x54b
  124e38: aa1303e0     	mov	x0, x19
  124e3c: d63f0100     	blr	x8
  124e40: f9007760     	str	x0, [x27, #0xe8]
  124e44: f9400268     	ldr	x8, [x19]
  124e48: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e4c: d00023e2     	adrp	x2, 0x5a2000
  124e50: 9105a042     	add	x2, x2, #0x168
  124e54: f9408508     	ldr	x8, [x8, #0x108]
  124e58: aa1303e0     	mov	x0, x19
  124e5c: aa1403e3     	mov	x3, x20
  124e60: d63f0100     	blr	x8
  124e64: f9007b60     	str	x0, [x27, #0xf0]
  124e68: f9400268     	ldr	x8, [x19]

## 124e78 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124e58: aa1303e0     	mov	x0, x19
  124e5c: aa1403e3     	mov	x3, x20
  124e60: d63f0100     	blr	x8
  124e64: f9007b60     	str	x0, [x27, #0xf0]
  124e68: f9400268     	ldr	x8, [x19]
  124e6c: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e70: d00023e2     	adrp	x2, 0x5a2000
  124e74: 9105d842     	add	x2, x2, #0x176
  124e78: f9408508     	ldr	x8, [x8, #0x108]
  124e7c: aa1303e0     	mov	x0, x19
  124e80: aa1403e3     	mov	x3, x20
  124e84: d63f0100     	blr	x8
  124e88: f9007f60     	str	x0, [x27, #0xf8]
  124e8c: f9400268     	ldr	x8, [x19]

## 124e9c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124e7c: aa1303e0     	mov	x0, x19
  124e80: aa1403e3     	mov	x3, x20
  124e84: d63f0100     	blr	x8
  124e88: f9007f60     	str	x0, [x27, #0xf8]
  124e8c: f9400268     	ldr	x8, [x19]
  124e90: f9467b81     	ldr	x1, [x28, #0xcf0]
  124e94: d00023e2     	adrp	x2, 0x5a2000
  124e98: 91060c42     	add	x2, x2, #0x183
  124e9c: f9408508     	ldr	x8, [x8, #0x108]
  124ea0: aa1303e0     	mov	x0, x19
  124ea4: aa1403e3     	mov	x3, x20
  124ea8: d63f0100     	blr	x8
  124eac: f9008360     	str	x0, [x27, #0x100]
  124eb0: f9400268     	ldr	x8, [x19]

## 124ec0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124ea0: aa1303e0     	mov	x0, x19
  124ea4: aa1403e3     	mov	x3, x20
  124ea8: d63f0100     	blr	x8
  124eac: f9008360     	str	x0, [x27, #0x100]
  124eb0: f9400268     	ldr	x8, [x19]
  124eb4: f9467b81     	ldr	x1, [x28, #0xcf0]
  124eb8: d00023e2     	adrp	x2, 0x5a2000
  124ebc: 91062c42     	add	x2, x2, #0x18b
  124ec0: f9408508     	ldr	x8, [x8, #0x108]
  124ec4: aa1303e0     	mov	x0, x19
  124ec8: aa1403e3     	mov	x3, x20
  124ecc: d63f0100     	blr	x8
  124ed0: f9008760     	str	x0, [x27, #0x108]
  124ed4: f9400268     	ldr	x8, [x19]

## 124ee4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124ec4: aa1303e0     	mov	x0, x19
  124ec8: aa1403e3     	mov	x3, x20
  124ecc: d63f0100     	blr	x8
  124ed0: f9008760     	str	x0, [x27, #0x108]
  124ed4: f9400268     	ldr	x8, [x19]
  124ed8: f9467b81     	ldr	x1, [x28, #0xcf0]
  124edc: d00023e2     	adrp	x2, 0x5a2000
  124ee0: 91066042     	add	x2, x2, #0x198
  124ee4: f9408508     	ldr	x8, [x8, #0x108]
  124ee8: aa1303e0     	mov	x0, x19
  124eec: aa1403e3     	mov	x3, x20
  124ef0: d63f0100     	blr	x8
  124ef4: f9008b60     	str	x0, [x27, #0x110]
  124ef8: f9400268     	ldr	x8, [x19]

## 124f08 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124ee8: aa1303e0     	mov	x0, x19
  124eec: aa1403e3     	mov	x3, x20
  124ef0: d63f0100     	blr	x8
  124ef4: f9008b60     	str	x0, [x27, #0x110]
  124ef8: f9400268     	ldr	x8, [x19]
  124efc: f9467b81     	ldr	x1, [x28, #0xcf0]
  124f00: d00023e2     	adrp	x2, 0x5a2000
  124f04: 91069c42     	add	x2, x2, #0x1a7
  124f08: f9408508     	ldr	x8, [x8, #0x108]
  124f0c: aa1303e0     	mov	x0, x19
  124f10: aa1503e3     	mov	x3, x21
  124f14: d63f0100     	blr	x8
  124f18: f00023c2     	adrp	x2, 0x59f000
  124f1c: f9008f60     	str	x0, [x27, #0x118]

## 124f5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124f3c: f9405508     	ldr	x8, [x8, #0xa8]
  124f40: d63f0100     	blr	x8
  124f44: 900030f4     	adrp	x20, 0x740000
  124f48: f9067e80     	str	x0, [x20, #0xcf8]
  124f4c: f9400268     	ldr	x8, [x19]
  124f50: f00023c2     	adrp	x2, 0x59f000
  124f54: aa0003e1     	mov	x1, x0
  124f58: 9109c442     	add	x2, x2, #0x271
  124f5c: f9408508     	ldr	x8, [x8, #0x108]
  124f60: aa1303e0     	mov	x0, x19
  124f64: aa1503e3     	mov	x3, x21
  124f68: d63f0100     	blr	x8
  124f6c: f9009360     	str	x0, [x27, #0x120]
  124f70: f9400268     	ldr	x8, [x19]

## 124f80 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo4initEP7_JNIEnv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  124f60: aa1303e0     	mov	x0, x19
  124f64: aa1503e3     	mov	x3, x21
  124f68: d63f0100     	blr	x8
  124f6c: f9009360     	str	x0, [x27, #0x120]
  124f70: f9400268     	ldr	x8, [x19]
  124f74: f9467e81     	ldr	x1, [x20, #0xcf8]
  124f78: d00023c2     	adrp	x2, 0x59e000
  124f7c: f00023c3     	adrp	x3, 0x59f000
  124f80: f9408508     	ldr	x8, [x8, #0x108]
  124f84: 913b1842     	add	x2, x2, #0xec6
  124f88: 91189463     	add	x3, x3, #0x625
  124f8c: aa1303e0     	mov	x0, x19
  124f90: d63f0100     	blr	x8
  124f94: f9009760     	str	x0, [x27, #0x128]

## 1278d8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN15JavaVodPlayInfo9convertToEP7_JNIEnvRK11VodPlayInfo
Basis: object-vptr load found but constructor provenance is not established
ASM:
  1278b8: aa1303e0     	mov	x0, x19
  1278bc: f9405508     	ldr	x8, [x8, #0xa8]
  1278c0: d63f0100     	blr	x8
  1278c4: f90726a0     	str	x0, [x21, #0xe48]
  1278c8: f9400268     	ldr	x8, [x19]
  1278cc: d00023a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  1278d0: d00023a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1278d4: aa0003e1     	mov	x1, x0
  1278d8: f9408508     	ldr	x8, [x8, #0x108]
  1278dc: 91141042     	add	x2, x2, #0x504
  1278e0: 91142c63     	add	x3, x3, #0x50b
  1278e4: aa1303e0     	mov	x0, x19
  1278e8: d63f0100     	blr	x8
  1278ec: b00030c8     	adrp	x8, 0x740000

## 127ea4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  127e84: aa1303e0     	mov	x0, x19
  127e88: f9405508     	ldr	x8, [x8, #0xa8]
  127e8c: d63f0100     	blr	x8
  127e90: f90732c0     	str	x0, [x22, #0xe60]
  127e94: f9400268     	ldr	x8, [x19]
  127e98: d00023a2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  127e9c: d00023a3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  127ea0: aa0003e1     	mov	x1, x0
  127ea4: f9408508     	ldr	x8, [x8, #0x108]
  127ea8: 91141042     	add	x2, x2, #0x504
  127eac: 91142c63     	add	x3, x3, #0x50b
  127eb0: aa1303e0     	mov	x0, x19
  127eb4: d63f0100     	blr	x8
  127eb8: b00030c8     	adrp	x8, 0x740000

## 128f7c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  128f5c: aa1303e0     	mov	x0, x19
  128f60: f9405508     	ldr	x8, [x8, #0xa8]
  128f64: d63f0100     	blr	x8
  128f68: f90762c0     	str	x0, [x22, #0xec0]
  128f6c: f9400268     	ldr	x8, [x19]
  128f70: d00023d4     	adrp	x20, 0x5a2000
  128f74: d00023c2     	adrp	x2, 0x5a2000
  128f78: 91192a94     	add	x20, x20, #0x64a
  128f7c: f9408508     	ldr	x8, [x8, #0x108]
  128f80: aa0003e1     	mov	x1, x0
  128f84: 9118d842     	add	x2, x2, #0x636
  128f88: aa1303e0     	mov	x0, x19
  128f8c: aa1403e3     	mov	x3, x20
  128f90: d63f0100     	blr	x8

## 128fac — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  128f8c: aa1403e3     	mov	x3, x20
  128f90: d63f0100     	blr	x8
  128f94: 900030c8     	adrp	x8, 0x740000
  128f98: f9076500     	str	x0, [x8, #0xec8]
  128f9c: f9400268     	ldr	x8, [x19]
  128fa0: f94762c1     	ldr	x1, [x22, #0xec0]
  128fa4: d00023c2     	adrp	x2, 0x5a2000
  128fa8: 91198042     	add	x2, x2, #0x660
  128fac: f9408508     	ldr	x8, [x8, #0x108]
  128fb0: aa1303e0     	mov	x0, x19
  128fb4: aa1403e3     	mov	x3, x20
  128fb8: d63f0100     	blr	x8
  128fbc: 900030c8     	adrp	x8, 0x740000
  128fc0: f9076900     	str	x0, [x8, #0xed0]

## 128fd4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  128fb4: aa1403e3     	mov	x3, x20
  128fb8: d63f0100     	blr	x8
  128fbc: 900030c8     	adrp	x8, 0x740000
  128fc0: f9076900     	str	x0, [x8, #0xed0]
  128fc4: f9400268     	ldr	x8, [x19]
  128fc8: f94762c1     	ldr	x1, [x22, #0xec0]
  128fcc: d00023c2     	adrp	x2, 0x5a2000
  128fd0: d00023c3     	adrp	x3, 0x5a2000
  128fd4: f9408508     	ldr	x8, [x8, #0x108]
  128fd8: 9119d442     	add	x2, x2, #0x675
  128fdc: 911a1863     	add	x3, x3, #0x686
  128fe0: aa1303e0     	mov	x0, x19
  128fe4: d63f0100     	blr	x8
  128fe8: 900030c8     	adrp	x8, 0x740000

## 129000 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN19JavaThumbnailHelper22Java_GetThumbnailInfosEP7_JNIEnvP7_jclassP8_jstringS5_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  128fe0: aa1303e0     	mov	x0, x19
  128fe4: d63f0100     	blr	x8
  128fe8: 900030c8     	adrp	x8, 0x740000
  128fec: f9076d00     	str	x0, [x8, #0xed8]
  128ff0: f9400268     	ldr	x8, [x19]
  128ff4: f94762c1     	ldr	x1, [x22, #0xec0]
  128ff8: d00023c2     	adrp	x2, 0x5a2000
  128ffc: 900023c3     	adrp	x3, 0x5a0000
  129000: f9408508     	ldr	x8, [x8, #0x108]
  129004: 911ab042     	add	x2, x2, #0x6ac
  129008: 911ab063     	add	x3, x3, #0x6ac
  12900c: aa1303e0     	mov	x0, x19
  129010: d63f0100     	blr	x8
  129014: f00030a8     	adrp	x8, 0x740000

## 12cf14 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cef4: aa1303e0     	mov	x0, x19
  12cef8: f9405508     	ldr	x8, [x8, #0xa8]
  12cefc: d63f0100     	blr	x8
  12cf00: f900baa0     	str	x0, [x21, #0x170]
  12cf04: f9400268     	ldr	x8, [x19]
  12cf08: b0002382     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  12cf0c: b0002383     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12cf10: aa0003e1     	mov	x1, x0
  12cf14: f9408508     	ldr	x8, [x8, #0x108]
  12cf18: 91141042     	add	x2, x2, #0x504
  12cf1c: 91142c63     	add	x3, x3, #0x50b
  12cf20: aa1303e0     	mov	x0, x19
  12cf24: d63f0100     	blr	x8
  12cf28: b00030b6     	adrp	x22, 0x741000 <_ZN12JavaVodAsset16gListGetMethodIDE+0x328>

## 12cf6c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cf4c: 91339463     	add	x3, x3, #0xce5
  12cf50: aa1303e0     	mov	x0, x19
  12cf54: d63f0100     	blr	x8
  12cf58: f90006c0     	str	x0, [x22, #0x8]
  12cf5c: f9400268     	ldr	x8, [x19]
  12cf60: f940baa1     	ldr	x1, [x21, #0x170]
  12cf64: d00023a2     	adrp	x2, 0x5a2000
  12cf68: d00023a3     	adrp	x3, 0x5a2000
  12cf6c: f9408508     	ldr	x8, [x8, #0x108]
  12cf70: 91344042     	add	x2, x2, #0xd10
  12cf74: 91345c63     	add	x3, x3, #0xd17
  12cf78: aa1303e0     	mov	x0, x19
  12cf7c: d63f0100     	blr	x8
  12cf80: f9000ac0     	str	x0, [x22, #0x10]

## 12cf94 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cf74: 91345c63     	add	x3, x3, #0xd17
  12cf78: aa1303e0     	mov	x0, x19
  12cf7c: d63f0100     	blr	x8
  12cf80: f9000ac0     	str	x0, [x22, #0x10]
  12cf84: f9400268     	ldr	x8, [x19]
  12cf88: f940baa1     	ldr	x1, [x21, #0x170]
  12cf8c: d00023a2     	adrp	x2, 0x5a2000
  12cf90: b0002383     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  12cf94: f9408508     	ldr	x8, [x8, #0x108]
  12cf98: 91350c42     	add	x2, x2, #0xd43
  12cf9c: 91158463     	add	x3, x3, #0x561
  12cfa0: aa1303e0     	mov	x0, x19
  12cfa4: d63f0100     	blr	x8
  12cfa8: f9000ec0     	str	x0, [x22, #0x18]

## 12cfbc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cf9c: 91158463     	add	x3, x3, #0x561
  12cfa0: aa1303e0     	mov	x0, x19
  12cfa4: d63f0100     	blr	x8
  12cfa8: f9000ec0     	str	x0, [x22, #0x18]
  12cfac: f9400268     	ldr	x8, [x19]
  12cfb0: f940baa1     	ldr	x1, [x21, #0x170]
  12cfb4: d00023a2     	adrp	x2, 0x5a2000
  12cfb8: d00023a3     	adrp	x3, 0x5a2000
  12cfbc: f9408508     	ldr	x8, [x8, #0x108]
  12cfc0: 91353042     	add	x2, x2, #0xd4c
  12cfc4: 91355463     	add	x3, x3, #0xd55
  12cfc8: aa1303e0     	mov	x0, x19
  12cfcc: d63f0100     	blr	x8
  12cfd0: f90012c0     	str	x0, [x22, #0x20]

## 12cfe4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cfc4: 91355463     	add	x3, x3, #0xd55
  12cfc8: aa1303e0     	mov	x0, x19
  12cfcc: d63f0100     	blr	x8
  12cfd0: f90012c0     	str	x0, [x22, #0x20]
  12cfd4: f9400268     	ldr	x8, [x19]
  12cfd8: f940baa1     	ldr	x1, [x21, #0x170]
  12cfdc: d00023a2     	adrp	x2, 0x5a2000
  12cfe0: d0002383     	adrp	x3, 0x59e000
  12cfe4: f9408508     	ldr	x8, [x8, #0x108]
  12cfe8: 9135b042     	add	x2, x2, #0xd6c
  12cfec: 91305863     	add	x3, x3, #0xc16
  12cff0: aa1303e0     	mov	x0, x19
  12cff4: d63f0100     	blr	x8
  12cff8: f90016c0     	str	x0, [x22, #0x28]

## 12d00c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12cfec: 91305863     	add	x3, x3, #0xc16
  12cff0: aa1303e0     	mov	x0, x19
  12cff4: d63f0100     	blr	x8
  12cff8: f90016c0     	str	x0, [x22, #0x28]
  12cffc: f9400268     	ldr	x8, [x19]
  12d000: f940baa1     	ldr	x1, [x21, #0x170]
  12d004: b00023a2     	adrp	x2, 0x5a2000
  12d008: 900023a3     	adrp	x3, 0x5a1000
  12d00c: f9408508     	ldr	x8, [x8, #0x108]
  12d010: 9135d442     	add	x2, x2, #0xd75
  12d014: 91293863     	add	x3, x3, #0xa4e
  12d018: aa1303e0     	mov	x0, x19
  12d01c: d63f0100     	blr	x8
  12d020: f9001ac0     	str	x0, [x22, #0x30]

## 12d034 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d014: 91293863     	add	x3, x3, #0xa4e
  12d018: aa1303e0     	mov	x0, x19
  12d01c: d63f0100     	blr	x8
  12d020: f9001ac0     	str	x0, [x22, #0x30]
  12d024: f9400268     	ldr	x8, [x19]
  12d028: f940baa1     	ldr	x1, [x21, #0x170]
  12d02c: b00023a2     	adrp	x2, 0x5a2000
  12d030: b0002383     	adrp	x3, 0x59e000
  12d034: f9408508     	ldr	x8, [x8, #0x108]
  12d038: 9135f842     	add	x2, x2, #0xd7e
  12d03c: 911bbc63     	add	x3, x3, #0x6ef
  12d040: aa1303e0     	mov	x0, x19
  12d044: d63f0100     	blr	x8
  12d048: f9001ec0     	str	x0, [x22, #0x38]

## 12d05c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d03c: 911bbc63     	add	x3, x3, #0x6ef
  12d040: aa1303e0     	mov	x0, x19
  12d044: d63f0100     	blr	x8
  12d048: f9001ec0     	str	x0, [x22, #0x38]
  12d04c: f9400268     	ldr	x8, [x19]
  12d050: f940baa1     	ldr	x1, [x21, #0x170]
  12d054: b00023a2     	adrp	x2, 0x5a2000
  12d058: b00023a3     	adrp	x3, 0x5a2000
  12d05c: f9408508     	ldr	x8, [x8, #0x108]
  12d060: 91361c42     	add	x2, x2, #0xd87
  12d064: 91364463     	add	x3, x3, #0xd91
  12d068: aa1303e0     	mov	x0, x19
  12d06c: d63f0100     	blr	x8
  12d070: f90022c0     	str	x0, [x22, #0x40]

## 12d084 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d064: 91364463     	add	x3, x3, #0xd91
  12d068: aa1303e0     	mov	x0, x19
  12d06c: d63f0100     	blr	x8
  12d070: f90022c0     	str	x0, [x22, #0x40]
  12d074: f9400268     	ldr	x8, [x19]
  12d078: f940baa1     	ldr	x1, [x21, #0x170]
  12d07c: b00023a2     	adrp	x2, 0x5a2000
  12d080: b00023a3     	adrp	x3, 0x5a2000
  12d084: f9408508     	ldr	x8, [x8, #0x108]
  12d088: 9136a042     	add	x2, x2, #0xda8
  12d08c: 9136c863     	add	x3, x3, #0xdb2
  12d090: aa1303e0     	mov	x0, x19
  12d094: d63f0100     	blr	x8
  12d098: f90026c0     	str	x0, [x22, #0x48]

## 12d0ac — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d08c: 9136c863     	add	x3, x3, #0xdb2
  12d090: aa1303e0     	mov	x0, x19
  12d094: d63f0100     	blr	x8
  12d098: f90026c0     	str	x0, [x22, #0x48]
  12d09c: f9400268     	ldr	x8, [x19]
  12d0a0: f940baa1     	ldr	x1, [x21, #0x170]
  12d0a4: b00023a2     	adrp	x2, 0x5a2000
  12d0a8: b00023a3     	adrp	x3, 0x5a2000
  12d0ac: f9408508     	ldr	x8, [x8, #0x108]
  12d0b0: 91372442     	add	x2, x2, #0xdc9
  12d0b4: 91374c63     	add	x3, x3, #0xdd3
  12d0b8: aa1303e0     	mov	x0, x19
  12d0bc: d63f0100     	blr	x8
  12d0c0: f9002ac0     	str	x0, [x22, #0x50]

## 12d0d4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d0b4: 91374c63     	add	x3, x3, #0xdd3
  12d0b8: aa1303e0     	mov	x0, x19
  12d0bc: d63f0100     	blr	x8
  12d0c0: f9002ac0     	str	x0, [x22, #0x50]
  12d0c4: f9400268     	ldr	x8, [x19]
  12d0c8: f940baa1     	ldr	x1, [x21, #0x170]
  12d0cc: b00023a2     	adrp	x2, 0x5a2000
  12d0d0: b00023a3     	adrp	x3, 0x5a2000
  12d0d4: f9408508     	ldr	x8, [x8, #0x108]
  12d0d8: 9137a842     	add	x2, x2, #0xdea
  12d0dc: 9137d063     	add	x3, x3, #0xdf4
  12d0e0: aa1303e0     	mov	x0, x19
  12d0e4: d63f0100     	blr	x8
  12d0e8: f9002ec0     	str	x0, [x22, #0x58]

## 12d0fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d0dc: 9137d063     	add	x3, x3, #0xdf4
  12d0e0: aa1303e0     	mov	x0, x19
  12d0e4: d63f0100     	blr	x8
  12d0e8: f9002ec0     	str	x0, [x22, #0x58]
  12d0ec: f9400268     	ldr	x8, [x19]
  12d0f0: f940baa1     	ldr	x1, [x21, #0x170]
  12d0f4: b00023a2     	adrp	x2, 0x5a2000
  12d0f8: b00023a3     	adrp	x3, 0x5a2000
  12d0fc: f9408508     	ldr	x8, [x8, #0x108]
  12d100: 91383042     	add	x2, x2, #0xe0c
  12d104: 91385863     	add	x3, x3, #0xe16
  12d108: aa1303e0     	mov	x0, x19
  12d10c: d63f0100     	blr	x8
  12d110: f90032c0     	str	x0, [x22, #0x60]

## 12d124 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d104: 91385863     	add	x3, x3, #0xe16
  12d108: aa1303e0     	mov	x0, x19
  12d10c: d63f0100     	blr	x8
  12d110: f90032c0     	str	x0, [x22, #0x60]
  12d114: f9400268     	ldr	x8, [x19]
  12d118: f940baa1     	ldr	x1, [x21, #0x170]
  12d11c: b00023a2     	adrp	x2, 0x5a2000
  12d120: b00023a3     	adrp	x3, 0x5a2000
  12d124: f9408508     	ldr	x8, [x8, #0x108]
  12d128: 9138b442     	add	x2, x2, #0xe2d
  12d12c: 9138d863     	add	x3, x3, #0xe36
  12d130: aa1303e0     	mov	x0, x19
  12d134: d63f0100     	blr	x8
  12d138: f90036c0     	str	x0, [x22, #0x68]

## 12d14c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada18MediaPreloadConfigaSEOS0_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  12d12c: 9138d863     	add	x3, x3, #0xe36
  12d130: aa1303e0     	mov	x0, x19
  12d134: d63f0100     	blr	x8
  12d138: f90036c0     	str	x0, [x22, #0x68]
  12d13c: f9400268     	ldr	x8, [x19]
  12d140: f940baa1     	ldr	x1, [x21, #0x170]
  12d144: b00023a2     	adrp	x2, 0x5a2000
  12d148: b00023a3     	adrp	x3, 0x5a2000
  12d14c: f9408508     	ldr	x8, [x8, #0x108]
  12d150: 91397842     	add	x2, x2, #0xe5e
  12d154: 9139a063     	add	x3, x3, #0xe68
  12d158: aa1303e0     	mov	x0, x19
  12d15c: d63f0100     	blr	x8
  12d160: f9003ac0     	str	x0, [x22, #0x70]

## 143c90 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN17AvaliablePlayInfoaSEOS_
Basis: no target-vtable provenance established
ASM:
  143c70: b4000980     	cbz	x0, 0x143da0 <_ZN17AvaliablePlayInfoaSEOS_+0x4f80>
  143c74: f94037e0     	ldr	x0, [sp, #0x68]
  143c78: f0002302     	adrp	x2, 0x5a6000
  143c7c: d00022c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  143c80: 91129842     	add	x2, x2, #0x4a6
  143c84: f9400008     	ldr	x8, [x0]
  143c88: 910fcc63     	add	x3, x3, #0x3f3
  143c8c: aa1403e1     	mov	x1, x20
  143c90: f9408508     	ldr	x8, [x8, #0x108]
  143c94: d63f0100     	blr	x8
  143c98: aa0003e2     	mov	x2, x0
  143c9c: b4000f00     	cbz	x0, 0x143e7c <_ZN17AvaliablePlayInfoaSEOS_+0x505c>
  143ca0: f94037e0     	ldr	x0, [sp, #0x68]
  143ca4: aa1503e1     	mov	x1, x21

## 195838 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE
Basis: no target-vtable provenance established
ASM:
  195818: b4000980     	cbz	x0, 0x195948 <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE+0x7a68>
  19581c: f9403fe0     	ldr	x0, [sp, #0x78]
  195820: b0002082     	adrp	x2, 0x5a6000
  195824: 90002043     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  195828: 91129842     	add	x2, x2, #0x4a6
  19582c: f9400008     	ldr	x8, [x0]
  195830: 910fcc63     	add	x3, x3, #0x3f3
  195834: aa1403e1     	mov	x1, x20
  195838: f9408508     	ldr	x8, [x8, #0x108]
  19583c: d63f0100     	blr	x8
  195840: aa0003e2     	mov	x2, x0
  195844: b4000f00     	cbz	x0, 0x195a24 <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE+0x7b44>
  195848: f9403fe0     	ldr	x0, [sp, #0x78]
  19584c: aa1503e1     	mov	x1, x21

## 197e20 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE
Basis: no target-vtable provenance established
ASM:
  197e00: 3909c668     	strb	w8, [x19, #0x271]
  197e04: 97fd181f     	bl	0xdde80 <__log_print@plt>
  197e08: 3100071f     	cmn	w24, #0x1
  197e0c: 54004600     	b.eq	0x1986cc <_ZN11FfmpegMuxer14addSourceMetasENSt6__ndk13mapINS0_12basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEES7_NS0_4lessIS7_EENS5_INS0_4pairIKS7_S7_EEEEEE+0xa7ec>
  197e10: f9405a60     	ldr	x0, [x19, #0xb0]
  197e14: 320003e2     	orr	w2, wzr, #0x1
  197e18: 2a1803e1     	mov	w1, w24
  197e1c: f9400008     	ldr	x8, [x0]
  197e20: f9408508     	ldr	x8, [x8, #0x108]
  197e24: d63f0100     	blr	x8
  197e28: f9405a60     	ldr	x0, [x19, #0xb0]
  197e2c: 2a1803e1     	mov	w1, w24
  197e30: f9400008     	ldr	x8, [x0]
  197e34: f9407d08     	ldr	x8, [x8, #0xf8]

## 19cba0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN19MediaLoaderErrorMap11getErrorMsgEi
Basis: no target-vtable provenance established
ASM:
  19cb80: b4000980     	cbz	x0, 0x19ccb0 <_ZN19MediaLoaderErrorMap11getErrorMsgEi+0x37fc>
  19cb84: f85803a0     	ldur	x0, [x29, #-0x80]
  19cb88: d0002042     	adrp	x2, 0x5a6000
  19cb8c: b0002003     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  19cb90: 91129842     	add	x2, x2, #0x4a6
  19cb94: f9400008     	ldr	x8, [x0]
  19cb98: 910fcc63     	add	x3, x3, #0x3f3
  19cb9c: aa1603e1     	mov	x1, x22
  19cba0: f9408508     	ldr	x8, [x8, #0x108]
  19cba4: d63f0100     	blr	x8
  19cba8: aa0003e2     	mov	x2, x0
  19cbac: b4000f00     	cbz	x0, 0x19cd8c <_ZN19MediaLoaderErrorMap11getErrorMsgEi+0x38d8>
  19cbb0: f85803a0     	ldur	x0, [x29, #-0x80]
  19cbb4: aa1703e1     	mov	x1, x23

## 1a3314 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada30AnalyticsReporterForDownloaderC2Ev
Basis: no target-vtable provenance established
ASM:
  1a32f4: b4000980     	cbz	x0, 0x1a3424 <_ZN6Cicada30AnalyticsReporterForDownloaderC2Ev+0x320>
  1a32f8: f94037e0     	ldr	x0, [sp, #0x68]
  1a32fc: f0002002     	adrp	x2, 0x5a6000
  1a3300: d0001fc3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1a3304: 91129842     	add	x2, x2, #0x4a6
  1a3308: f9400008     	ldr	x8, [x0]
  1a330c: 910fcc63     	add	x3, x3, #0x3f3
  1a3310: aa1403e1     	mov	x1, x20
  1a3314: f9408508     	ldr	x8, [x8, #0x108]
  1a3318: d63f0100     	blr	x8
  1a331c: aa0003e2     	mov	x2, x0
  1a3320: b4000f00     	cbz	x0, 0x1a3500 <_ZN6Cicada30AnalyticsReporterForDownloaderC2Ev+0x3fc>
  1a3324: f94037e0     	ldr	x0, [sp, #0x68]
  1a3328: aa1503e1     	mov	x1, x21

## 1cb8ac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN10PopRequest15getPublicParamsERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  1cb88c: b4000980     	cbz	x0, 0x1cb9bc <_ZN10PopRequest15getPublicParamsERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE+0x324>
  1cb890: f85883a0     	ldur	x0, [x29, #-0x78]
  1cb894: f0001ec2     	adrp	x2, 0x5a6000
  1cb898: d0001e83     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1cb89c: 91129842     	add	x2, x2, #0x4a6
  1cb8a0: f9400008     	ldr	x8, [x0]
  1cb8a4: 910fcc63     	add	x3, x3, #0x3f3
  1cb8a8: aa1403e1     	mov	x1, x20
  1cb8ac: f9408508     	ldr	x8, [x8, #0x108]
  1cb8b0: d63f0100     	blr	x8
  1cb8b4: aa0003e2     	mov	x2, x0
  1cb8b8: b4000f00     	cbz	x0, 0x1cba98 <_ZN10PopRequest15getPublicParamsERKNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE+0x400>
  1cb8bc: f85883a0     	ldur	x0, [x29, #-0x78]
  1cb8c0: aa1503e1     	mov	x1, x21

## 1ed658 — UNRESOLVED_0x108_DATAFLOW
Function: _ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv
Basis: no target-vtable provenance established
ASM:
  1ed638: f9016909     	str	x9, [x8, #0x2d0]
  1ed63c: f9401e96     	ldr	x22, [x20, #0x38]
  1ed640: 9100c294     	add	x20, x20, #0x30
  1ed644: 14000008     	b	0x1ed664 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv+0xff54>
  1ed648: f9400ac0     	ldr	x0, [x22, #0x10]
  1ed64c: b40000a0     	cbz	x0, 0x1ed660 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv+0xff50>
  1ed650: f9400008     	ldr	x8, [x0]
  1ed654: aa1303e1     	mov	x1, x19
  1ed658: f9408508     	ldr	x8, [x8, #0x108]
  1ed65c: d63f0100     	blr	x8
  1ed660: f94006d6     	ldr	x22, [x22, #0x8]
  1ed664: eb16029f     	cmp	x20, x22
  1ed668: 54ffff01     	b.ne	0x1ed648 <_ZNK17AvaliablePlayInfo23droppedPlayInfoToStringEv+0xff38>
  1ed66c: f94016a8     	ldr	x8, [x21, #0x28]

## 1f767c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada14globalSettings16getIpResolveTypeEv
Basis: no target-vtable provenance established
ASM:
  1f765c: b40009a0     	cbz	x0, 0x1f7790 <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x340c>
  1f7660: f85883a0     	ldur	x0, [x29, #-0x78]
  1f7664: f0001d62     	adrp	x2, 0x5a6000
  1f7668: d0001d23     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  1f766c: 91129842     	add	x2, x2, #0x4a6
  1f7670: f9400008     	ldr	x8, [x0]
  1f7674: 910fcc63     	add	x3, x3, #0x3f3
  1f7678: aa1403e1     	mov	x1, x20
  1f767c: f9408508     	ldr	x8, [x8, #0x108]
  1f7680: d63f0100     	blr	x8
  1f7684: aa0003e2     	mov	x2, x0
  1f7688: b40021a0     	cbz	x0, 0x1f7abc <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x3738>
  1f768c: f85883a0     	ldur	x0, [x29, #-0x78]
  1f7690: aa1503e1     	mov	x1, x21

## 1f95ac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada14globalSettings16getIpResolveTypeEv
Basis: no target-vtable provenance established
ASM:
  1f958c: 910083fd     	add	x29, sp, #0x20
  1f9590: d53bd053     	mrs	x19, TPIDR_EL0
  1f9594: f9401668     	ldr	x8, [x19, #0x28]
  1f9598: f90007e8     	str	x8, [sp, #0x8]
  1f959c: f9400808     	ldr	x8, [x0, #0x10]
  1f95a0: f9400100     	ldr	x0, [x8]
  1f95a4: b4000120     	cbz	x0, 0x1f95c8 <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x5244>
  1f95a8: f9400008     	ldr	x8, [x0]
  1f95ac: f9408508     	ldr	x8, [x8, #0x108]
  1f95b0: d63f0100     	blr	x8
  1f95b4: f9401668     	ldr	x8, [x19, #0x28]
  1f95b8: f94007e9     	ldr	x9, [sp, #0x8]
  1f95bc: eb09011f     	cmp	x8, x9
  1f95c0: 540000e0     	b.eq	0x1f95dc <_ZN6Cicada14globalSettings16getIpResolveTypeEv+0x5258>

## 20a9fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  20a9dc: aa1f03e2     	mov	x2, xzr
  20a9e0: a900ffff     	stp	xzr, xzr, [sp, #0x8]
  20a9e4: f9000fff     	str	xzr, [sp, #0x18]
  20a9e8: 97fbba3c     	bl	0xf92d8 <JNI_OnUnload+0x974>
  20a9ec: f9400268     	ldr	x8, [x19]
  20a9f0: 12800001     	mov	w1, #-0x1               // =-1
  20a9f4: 910083e2     	add	x2, sp, #0x20
  20a9f8: 910023e3     	add	x3, sp, #0x8
  20a9fc: f9408508     	ldr	x8, [x8, #0x108]
  20aa00: aa1303e0     	mov	x0, x19
  20aa04: d63f0100     	blr	x8
  20aa08: aa0003f5     	mov	x21, x0
  20aa0c: 910023e0     	add	x0, sp, #0x8
  20aa10: 97fbb701     	bl	0xf8614 <.text+0x17d54>

## 20aa84 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  20aa64: 528002a2     	mov	w2, #0x15               // =21
  20aa68: a9027fff     	stp	xzr, xzr, [sp, #0x20]
  20aa6c: f9001bff     	str	xzr, [sp, #0x30]
  20aa70: 97fbba1a     	bl	0xf92d8 <JNI_OnUnload+0x974>
  20aa74: f9400268     	ldr	x8, [x19]
  20aa78: 12800001     	mov	w1, #-0x1               // =-1
  20aa7c: 910083e2     	add	x2, sp, #0x20
  20aa80: aa1303e0     	mov	x0, x19
  20aa84: f9408508     	ldr	x8, [x8, #0x108]
  20aa88: aa1503e3     	mov	x3, x21
  20aa8c: d63f0100     	blr	x8
  20aa90: aa0003f5     	mov	x21, x0
  20aa94: 910083e0     	add	x0, sp, #0x20
  20aa98: 97fbb6df     	bl	0xf8614 <.text+0x17d54>

## 2106d4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  2106b4: aa1f03e2     	mov	x2, xzr
  2106b8: a9307fbf     	stp	xzr, xzr, [x29, #-0x100]
  2106bc: f81103bf     	stur	xzr, [x29, #-0xf0]
  2106c0: 97fba306     	bl	0xf92d8 <JNI_OnUnload+0x974>
  2106c4: f9400388     	ldr	x8, [x28]
  2106c8: 12800001     	mov	w1, #-0x1               // =-1
  2106cc: d10383a2     	sub	x2, x29, #0xe0
  2106d0: d10403a3     	sub	x3, x29, #0x100
  2106d4: f9408508     	ldr	x8, [x8, #0x108]
  2106d8: aa1c03e0     	mov	x0, x28
  2106dc: d63f0100     	blr	x8
  2106e0: aa0003e3     	mov	x3, x0
  2106e4: 52800122     	mov	w2, #0x9                // =9
  2106e8: aa1b03e0     	mov	x0, x27

## 210760 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  210740: aa1f03e2     	mov	x2, xzr
  210744: a9307fbf     	stp	xzr, xzr, [x29, #-0x100]
  210748: f81103bf     	stur	xzr, [x29, #-0xf0]
  21074c: 97fba2e3     	bl	0xf92d8 <JNI_OnUnload+0x974>
  210750: f9400388     	ldr	x8, [x28]
  210754: 12800001     	mov	w1, #-0x1               // =-1
  210758: d10383a2     	sub	x2, x29, #0xe0
  21075c: d10403a3     	sub	x3, x29, #0x100
  210760: f9408508     	ldr	x8, [x8, #0x108]
  210764: aa1c03e0     	mov	x0, x28
  210768: d63f0100     	blr	x8
  21076c: aa0003e3     	mov	x3, x0
  210770: 52800142     	mov	w2, #0xa                // =10
  210774: aa1b03e0     	mov	x0, x27

## 2150b8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  215098: aa1f03e2     	mov	x2, xzr
  21509c: a900ffff     	stp	xzr, xzr, [sp, #0x8]
  2150a0: f9000fff     	str	xzr, [sp, #0x18]
  2150a4: 97fb908d     	bl	0xf92d8 <JNI_OnUnload+0x974>
  2150a8: f94002a8     	ldr	x8, [x21]
  2150ac: 12800001     	mov	w1, #-0x1               // =-1
  2150b0: 910083e2     	add	x2, sp, #0x20
  2150b4: 910023e3     	add	x3, sp, #0x8
  2150b8: f9408508     	ldr	x8, [x8, #0x108]
  2150bc: aa1503e0     	mov	x0, x21
  2150c0: d63f0100     	blr	x8
  2150c4: aa0003f5     	mov	x21, x0
  2150c8: 910023e0     	add	x0, sp, #0x8
  2150cc: 97fb8d52     	bl	0xf8614 <.text+0x17d54>

## 215130 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  215110: aa1f03e2     	mov	x2, xzr
  215114: a900ffff     	stp	xzr, xzr, [sp, #0x8]
  215118: f9000fff     	str	xzr, [sp, #0x18]
  21511c: 97fb906f     	bl	0xf92d8 <JNI_OnUnload+0x974>
  215120: f94002e8     	ldr	x8, [x23]
  215124: 12800001     	mov	w1, #-0x1               // =-1
  215128: 910083e2     	add	x2, sp, #0x20
  21512c: 910023e3     	add	x3, sp, #0x8
  215130: f9408508     	ldr	x8, [x8, #0x108]
  215134: aa1703e0     	mov	x0, x23
  215138: d63f0100     	blr	x8
  21513c: aa0003f7     	mov	x23, x0
  215140: 910023e0     	add	x0, sp, #0x8
  215144: 97fb8d34     	bl	0xf8614 <.text+0x17d54>

## 2151a8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  215188: aa1f03e2     	mov	x2, xzr
  21518c: a900ffff     	stp	xzr, xzr, [sp, #0x8]
  215190: f9000fff     	str	xzr, [sp, #0x18]
  215194: 97fb9051     	bl	0xf92d8 <JNI_OnUnload+0x974>
  215198: f9400308     	ldr	x8, [x24]
  21519c: 12800001     	mov	w1, #-0x1               // =-1
  2151a0: 910083e2     	add	x2, sp, #0x20
  2151a4: 910023e3     	add	x3, sp, #0x8
  2151a8: f9408508     	ldr	x8, [x8, #0x108]
  2151ac: aa1803e0     	mov	x0, x24
  2151b0: d63f0100     	blr	x8
  2151b4: aa0003f8     	mov	x24, x0
  2151b8: 910023e0     	add	x0, sp, #0x8
  2151bc: 97fb8d16     	bl	0xf8614 <.text+0x17d54>

## 215220 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  215200: aa1f03e2     	mov	x2, xzr
  215204: a900ffff     	stp	xzr, xzr, [sp, #0x8]
  215208: f9000fff     	str	xzr, [sp, #0x18]
  21520c: 97fb9033     	bl	0xf92d8 <JNI_OnUnload+0x974>
  215210: f9400328     	ldr	x8, [x25]
  215214: 12800001     	mov	w1, #-0x1               // =-1
  215218: 910083e2     	add	x2, sp, #0x20
  21521c: 910023e3     	add	x3, sp, #0x8
  215220: f9408508     	ldr	x8, [x8, #0x108]
  215224: aa1903e0     	mov	x0, x25
  215228: d63f0100     	blr	x8
  21522c: aa0003f6     	mov	x22, x0
  215230: 910023e0     	add	x0, sp, #0x8
  215234: 97fb8cf8     	bl	0xf8614 <.text+0x17d54>

## 21bbd0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  21bbb0: 321c07e0     	orr	w0, wzr, #0x30
  21bbb4: aa1403e3     	mov	x3, x20
  21bbb8: f90007e8     	str	x8, [sp, #0x8]
  21bbbc: 97fb08b1     	bl	0xdde80 <__log_print@plt>
  21bbc0: f9403660     	ldr	x0, [x19, #0x68]
  21bbc4: b9422661     	ldr	w1, [x19, #0x224]
  21bbc8: 3948c262     	ldrb	w2, [x19, #0x230]
  21bbcc: f9400008     	ldr	x8, [x0]
  21bbd0: f9408508     	ldr	x8, [x8, #0x108]
  21bbd4: d63f0100     	blr	x8
  21bbd8: 3961ca68     	ldrb	w8, [x19, #0x872]
  21bbdc: 34000108     	cbz	w8, 0x21bbfc <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f10>
  21bbe0: b0001c41     	adrp	x1, 0x5a4000
  21bbe4: f0001ca2     	adrp	x2, 0x5b2000

## 21bc30 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  21bc10: 37f801a0     	tbnz	w0, #0x1f, 0x21bc44 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f58>
  21bc14: 394f8a68     	ldrb	w8, [x19, #0x3e2]
  21bc18: f9403660     	ldr	x0, [x19, #0x68]
  21bc1c: b9421a61     	ldr	w1, [x19, #0x218]
  21bc20: 34000228     	cbz	w8, 0x21bc64 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f78>
  21bc24: f9400008     	ldr	x8, [x0]
  21bc28: 12001c21     	and	w1, w1, #0xff
  21bc2c: 2a1f03e2     	mov	w2, wzr
  21bc30: f9408508     	ldr	x8, [x8, #0x108]
  21bc34: d63f0100     	blr	x8
  21bc38: f9403660     	ldr	x0, [x19, #0x68]
  21bc3c: 39486261     	ldrb	w1, [x19, #0x218]
  21bc40: 1400000f     	b	0x21bc7c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x17f90>
  21bc44: b9421a63     	ldr	w3, [x19, #0x218]

## 21bc6c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  21bc4c: f0001ca2     	adrp	x2, 0x5b2000
  21bc50: 9136f821     	add	x1, x1, #0xdbe
  21bc54: 9116b442     	add	x2, x2, #0x5ad
  21bc58: 321c07e0     	orr	w0, wzr, #0x30
  21bc5c: 97fb0889     	bl	0xdde80 <__log_print@plt>
  21bc60: 1400002e     	b	0x21bd18 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x1802c>
  21bc64: f9400008     	ldr	x8, [x0]
  21bc68: 2a1f03e2     	mov	w2, wzr
  21bc6c: f9408508     	ldr	x8, [x8, #0x108]
  21bc70: d63f0100     	blr	x8
  21bc74: f9403660     	ldr	x0, [x19, #0x68]
  21bc78: b9421a61     	ldr	w1, [x19, #0x218]
  21bc7c: f9400008     	ldr	x8, [x0]
  21bc80: f9408108     	ldr	x8, [x8, #0x100]

## 233b90 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  233b70: 321d07e0     	orr	w0, wzr, #0x18
  233b74: 14000029     	b	0x233c18 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2ff2c>
  233b78: b9421d01     	ldr	w1, [x8, #0x21c]
  233b7c: 37f80101     	tbnz	w1, #0x1f, 0x233b9c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2feb0>
  233b80: f9403500     	ldr	x0, [x8, #0x68]
  233b84: f100035f     	cmp	x26, #0x0
  233b88: 1a9f07e2     	cset	w2, ne
  233b8c: f9400008     	ldr	x8, [x0]
  233b90: f9408508     	ldr	x8, [x8, #0x108]
  233b94: d63f0100     	blr	x8
  233b98: f9400328     	ldr	x8, [x25]
  233b9c: b9421901     	ldr	w1, [x8, #0x218]
  233ba0: 37f80101     	tbnz	w1, #0x1f, 0x233bc0 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2fed4>
  233ba4: f9403500     	ldr	x0, [x8, #0x68]

## 233bb4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  233b94: d63f0100     	blr	x8
  233b98: f9400328     	ldr	x8, [x25]
  233b9c: b9421901     	ldr	w1, [x8, #0x218]
  233ba0: 37f80101     	tbnz	w1, #0x1f, 0x233bc0 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2fed4>
  233ba4: f9403500     	ldr	x0, [x8, #0x68]
  233ba8: f100035f     	cmp	x26, #0x0
  233bac: 1a9f07e2     	cset	w2, ne
  233bb0: f9400008     	ldr	x8, [x0]
  233bb4: f9408508     	ldr	x8, [x8, #0x108]
  233bb8: d63f0100     	blr	x8
  233bbc: f9400328     	ldr	x8, [x25]
  233bc0: 320003e9     	orr	w9, wzr, #0x1
  233bc4: 3921d109     	strb	w9, [x8, #0x874]
  233bc8: 14000031     	b	0x233c8c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2ffa0>

## 233e6c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  233e4c: 321c07e0     	orr	w0, wzr, #0x30
  233e50: 1a9f07f4     	cset	w20, ne
  233e54: 97faa80b     	bl	0xdde80 <__log_print@plt>
  233e58: f9400328     	ldr	x8, [x25]
  233e5c: 2a1303e1     	mov	w1, w19
  233e60: 2a1403e2     	mov	w2, w20
  233e64: f9403500     	ldr	x0, [x8, #0x68]
  233e68: f9400008     	ldr	x8, [x0]
  233e6c: f9408508     	ldr	x8, [x8, #0x108]
  233e70: d63f0100     	blr	x8
  233e74: 17ffff86     	b	0x233c8c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2ffa0>
  233e78: b240fbe9     	orr	x9, xzr, #0x7fffffffffffffff
  233e7c: f901c909     	str	x9, [x8, #0x390]
  233e80: 390f211f     	strb	wzr, [x8, #0x3c8]

## 2341c4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  2341a4: 321c03e0     	orr	w0, wzr, #0x10
  2341a8: 2a1303e3     	mov	w3, w19
  2341ac: 17fffe9c     	b	0x233c1c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2ff30>
  2341b0: f9403500     	ldr	x0, [x8, #0x68]
  2341b4: f100035f     	cmp	x26, #0x0
  2341b8: 1a9f07e2     	cset	w2, ne
  2341bc: 2a1303e1     	mov	w1, w19
  2341c0: f9400008     	ldr	x8, [x0]
  2341c4: f9408508     	ldr	x8, [x8, #0x108]
  2341c8: d63f0100     	blr	x8
  2341cc: f9400328     	ldr	x8, [x25]
  2341d0: 2a1303e1     	mov	w1, w19
  2341d4: f9403500     	ldr	x0, [x8, #0x68]
  2341d8: f9400008     	ldr	x8, [x0]

## 2345ac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  23458c: 9130cc42     	add	x2, x2, #0xc33
  234590: 321b03e0     	orr	w0, wzr, #0x20
  234594: 97faa63b     	bl	0xdde80 <__log_print@plt>
  234598: f9400668     	ldr	x8, [x19, #0x8]
  23459c: 2a1503e1     	mov	w1, w21
  2345a0: 2a1f03e2     	mov	w2, wzr
  2345a4: f9403500     	ldr	x0, [x8, #0x68]
  2345a8: f9400008     	ldr	x8, [x0]
  2345ac: f9408508     	ldr	x8, [x8, #0x108]
  2345b0: d63f0100     	blr	x8
  2345b4: f9400668     	ldr	x8, [x19, #0x8]
  2345b8: 12000282     	and	w2, w20, #0x1
  2345bc: 2a1603e1     	mov	w1, w22
  2345c0: f9403500     	ldr	x0, [x8, #0x68]

## 2345c8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  2345a8: f9400008     	ldr	x8, [x0]
  2345ac: f9408508     	ldr	x8, [x8, #0x108]
  2345b0: d63f0100     	blr	x8
  2345b4: f9400668     	ldr	x8, [x19, #0x8]
  2345b8: 12000282     	and	w2, w20, #0x1
  2345bc: 2a1603e1     	mov	w1, w22
  2345c0: f9403500     	ldr	x0, [x8, #0x68]
  2345c4: f9400008     	ldr	x8, [x0]
  2345c8: f9408508     	ldr	x8, [x8, #0x108]
  2345cc: d63f0100     	blr	x8
  2345d0: f9400668     	ldr	x8, [x19, #0x8]
  2345d4: 2a1503e1     	mov	w1, w21
  2345d8: 2a1603e2     	mov	w2, w22
  2345dc: f9403500     	ldr	x0, [x8, #0x68]

## 239f94 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE
Basis: no target-vtable provenance established
ASM:
  239f74: aa0003f5     	mov	x21, x0
  239f78: 910003e0     	mov	x0, sp
  239f7c: 97faf9a6     	bl	0xf8614 <.text+0x17d54>
  239f80: b40000f5     	cbz	x21, 0x239f9c <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x362b0>
  239f84: f94002a8     	ldr	x8, [x21]
  239f88: 12000262     	and	w2, w19, #0x1
  239f8c: aa1503e0     	mov	x0, x21
  239f90: 2a1403e1     	mov	w1, w20
  239f94: f9408508     	ldr	x8, [x8, #0x108]
  239f98: d63f0100     	blr	x8
  239f9c: f94016e8     	ldr	x8, [x23, #0x28]
  239fa0: f9400fe9     	ldr	x9, [sp, #0x18]
  239fa4: eb09011f     	cmp	x8, x9
  239fa8: 540000e1     	b.ne	0x239fc4 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x362d8>

## 241330 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada15demuxer_service16GetPropertyInt64EiRKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEES9_
Basis: no target-vtable provenance established
ASM:
  241310: f90007e8     	str	x8, [sp, #0x8]
  241314: 97fa72db     	bl	0xdde80 <__log_print@plt>
  241318: f9400ac0     	ldr	x0, [x22, #0x10]
  24131c: b4000180     	cbz	x0, 0x24134c <_ZN6Cicada15demuxer_service16GetPropertyInt64EiRKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEES9_+0x90>
  241320: f9400008     	ldr	x8, [x0]
  241324: 2a1503e1     	mov	w1, w21
  241328: aa1403e2     	mov	x2, x20
  24132c: aa1303e3     	mov	x3, x19
  241330: f9408508     	ldr	x8, [x8, #0x108]
  241334: d63f0100     	blr	x8
  241338: f94016e8     	ldr	x8, [x23, #0x28]
  24133c: f94007e9     	ldr	x9, [sp, #0x8]
  241340: eb09011f     	cmp	x8, x9
  241344: 540000e0     	b.eq	0x241360 <_ZN6Cicada15demuxer_service16GetPropertyInt64EiRKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEES9_+0xa4>

## 250288 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  250268: 97fa2262     	bl	0xd8bf0 <memset@plt>
  25026c: 12800008     	mov	w8, #-0x1               // =-1
  250270: b9000268     	str	w8, [x19]
  250274: f940a6e0     	ldr	x0, [x23, #0x148]
  250278: 13107ed5     	asr	w21, w22, #16
  25027c: 12001ed9     	and	w25, w22, #0xff
  250280: b4000200     	cbz	x0, 0x2502c0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x5fcc>
  250284: f9400008     	ldr	x8, [x0]
  250288: f9408508     	ldr	x8, [x8, #0x108]
  25028c: d63f0100     	blr	x8
  250290: 6b19001f     	cmp	w0, w25
  250294: 54000661     	b.ne	0x250360 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x606c>
  250298: 320007e8     	orr	w8, wzr, #0x3
  25029c: b9000268     	str	w8, [x19]

## 250510 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2504f0: f9403529     	ldr	x9, [x9, #0x68]
  2504f4: d63f0120     	blr	x9
  2504f8: b9000819     	str	w25, [x0, #0x8]
  2504fc: 14000012     	b	0x250544 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6250>
  250500: 35000eb9     	cbnz	w25, 0x2506d4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x63e0>
  250504: f94002e8     	ldr	x8, [x23]
  250508: f9400100     	ldr	x0, [x8]
  25050c: f9400008     	ldr	x8, [x0]
  250510: f9408508     	ldr	x8, [x8, #0x108]
  250514: d63f0100     	blr	x8
  250518: b0001b41     	adrp	x1, 0x5b9000
  25051c: 2a0003e3     	mov	w3, w0
  250520: 321c07e0     	orr	w0, wzr, #0x30
  250524: 913e6421     	add	x1, x1, #0xf99

## 250734 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  250714: d63f0100     	blr	x8
  250718: f94002e8     	ldr	x8, [x23]
  25071c: 3900411f     	strb	wzr, [x8, #0x10]
  250720: f9409e78     	ldr	x24, [x19, #0x138]
  250724: 1400000b     	b	0x250750 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x645c>
  250728: f9400b08     	ldr	x8, [x24, #0x10]
  25072c: f9400100     	ldr	x0, [x8]
  250730: f9400008     	ldr	x8, [x0]
  250734: f9408508     	ldr	x8, [x8, #0x108]
  250738: d63f0100     	blr	x8
  25073c: f94002e8     	ldr	x8, [x23]
  250740: b9401509     	ldr	w9, [x8, #0x14]
  250744: 6b09001f     	cmp	w0, w9
  250748: 540006a0     	b.eq	0x25081c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6528>

## 250798 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  250778: f9400269     	ldr	x9, [x19]
  25077c: aa1303e0     	mov	x0, x19
  250780: b9401501     	ldr	w1, [x8, #0x14]
  250784: f9402528     	ldr	x8, [x9, #0x48]
  250788: d63f0100     	blr	x8
  25078c: f94002e8     	ldr	x8, [x23]
  250790: f9400100     	ldr	x0, [x8]
  250794: f9400008     	ldr	x8, [x0]
  250798: f9408508     	ldr	x8, [x8, #0x108]
  25079c: d63f0100     	blr	x8
  2507a0: f94002e8     	ldr	x8, [x23]
  2507a4: b0001b41     	adrp	x1, 0x5b9000
  2507a8: d0001b42     	adrp	x2, 0x5ba000
  2507ac: 2a0003e3     	mov	w3, w0

## 250bfc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  250bdc: f9400100     	ldr	x0, [x8]
  250be0: f900a660     	str	x0, [x19, #0x148]
  250be4: 1400003d     	b	0x250cd8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x69e4>
  250be8: 9104c277     	add	x23, x19, #0x130
  250bec: 14000009     	b	0x250c10 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x691c>
  250bf0: f9400ac8     	ldr	x8, [x22, #0x10]
  250bf4: f9400100     	ldr	x0, [x8]
  250bf8: f9400008     	ldr	x8, [x0]
  250bfc: f9408508     	ldr	x8, [x8, #0x108]
  250c00: d63f0100     	blr	x8
  250c04: 6b14001f     	cmp	w0, w20
  250c08: 540000c0     	b.eq	0x250c20 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x692c>
  250c0c: f94006d6     	ldr	x22, [x22, #0x8]
  250c10: eb1602ff     	cmp	x23, x22

## 250ef8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  250ed8: 9104e2c8     	add	x8, x22, #0x138
  250edc: 9104c2d6     	add	x22, x22, #0x130
  250ee0: f9400118     	ldr	x24, [x8]
  250ee4: eb1802df     	cmp	x22, x24
  250ee8: 540001e0     	b.eq	0x250f24 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6c30>
  250eec: f9400b08     	ldr	x8, [x24, #0x10]
  250ef0: f9400100     	ldr	x0, [x8]
  250ef4: f9400008     	ldr	x8, [x0]
  250ef8: f9408508     	ldr	x8, [x8, #0x108]
  250efc: d63f0100     	blr	x8
  250f00: 6b15001f     	cmp	w0, w21
  250f04: 91002308     	add	x8, x24, #0x8
  250f08: 54fffec1     	b.ne	0x250ee0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6bec>
  250f0c: f9400b08     	ldr	x8, [x24, #0x10]

## 251124 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251104: 9104c015     	add	x21, x0, #0x130
  251108: f90007e9     	str	x9, [sp, #0x8]
  25110c: f9400116     	ldr	x22, [x8]
  251110: eb1602bf     	cmp	x21, x22
  251114: 54000220     	b.eq	0x251158 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6e64>
  251118: f9400ac8     	ldr	x8, [x22, #0x10]
  25111c: f9400100     	ldr	x0, [x8]
  251120: f9400008     	ldr	x8, [x0]
  251124: f9408508     	ldr	x8, [x8, #0x108]
  251128: d63f0100     	blr	x8
  25112c: 6b13001f     	cmp	w0, w19
  251130: 910022c8     	add	x8, x22, #0x8
  251134: 54fffec1     	b.ne	0x25110c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6e18>
  251138: f9400ac8     	ldr	x8, [x22, #0x10]

## 251204 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2511e4: 9104e288     	add	x8, x20, #0x138
  2511e8: 9104c296     	add	x22, x20, #0x130
  2511ec: f9400114     	ldr	x20, [x8]
  2511f0: eb1402df     	cmp	x22, x20
  2511f4: 540003e0     	b.eq	0x251270 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6f7c>
  2511f8: f9400a88     	ldr	x8, [x20, #0x10]
  2511fc: f9400100     	ldr	x0, [x8]
  251200: f9400008     	ldr	x8, [x0]
  251204: f9408508     	ldr	x8, [x8, #0x108]
  251208: d63f0100     	blr	x8
  25120c: 6b13001f     	cmp	w0, w19
  251210: 91002288     	add	x8, x20, #0x8
  251214: 54fffec1     	b.ne	0x2511ec <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x6ef8>
  251218: f9400a88     	ldr	x8, [x20, #0x10]

## 251324 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251304: 9104e2a8     	add	x8, x21, #0x138
  251308: 9104c2b6     	add	x22, x21, #0x130
  25130c: f9400115     	ldr	x21, [x8]
  251310: eb1502df     	cmp	x22, x21
  251314: 540002a0     	b.eq	0x251368 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7074>
  251318: f9400aa8     	ldr	x8, [x21, #0x10]
  25131c: f9400100     	ldr	x0, [x8]
  251320: f9400008     	ldr	x8, [x0]
  251324: f9408508     	ldr	x8, [x8, #0x108]
  251328: d63f0100     	blr	x8
  25132c: 6b14001f     	cmp	w0, w20
  251330: 910022a8     	add	x8, x21, #0x8
  251334: 54fffec1     	b.ne	0x25130c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7018>
  251338: f9400aa8     	ldr	x8, [x21, #0x10]

## 251548 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251528: eb18035f     	cmp	x26, x24
  25152c: 540007e0     	b.eq	0x251628 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7334>
  251530: 12800016     	mov	w22, #-0x1              // =-1
  251534: f9400b08     	ldr	x8, [x24, #0x10]
  251538: 39404509     	ldrb	w9, [x8, #0x11]
  25153c: 34000289     	cbz	w9, 0x25158c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7298>
  251540: f9400100     	ldr	x0, [x8]
  251544: f9400008     	ldr	x8, [x0]
  251548: f9408508     	ldr	x8, [x8, #0x108]
  25154c: d63f0100     	blr	x8
  251550: f94002a8     	ldr	x8, [x21]
  251554: 2a0003e1     	mov	w1, w0
  251558: aa1503e0     	mov	x0, x21
  25155c: f9402908     	ldr	x8, [x8, #0x50]

## 2515ac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  25158c: f9400718     	ldr	x24, [x24, #0x8]
  251590: eb18035f     	cmp	x26, x24
  251594: 54fffd01     	b.ne	0x251534 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7240>
  251598: f9409eb8     	ldr	x24, [x21, #0x138]
  25159c: 14000023     	b	0x251628 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7334>
  2515a0: f9400b08     	ldr	x8, [x24, #0x10]
  2515a4: f9400100     	ldr	x0, [x8]
  2515a8: f9400008     	ldr	x8, [x0]
  2515ac: f9408508     	ldr	x8, [x8, #0x108]
  2515b0: d63f0100     	blr	x8
  2515b4: 6b16001f     	cmp	w0, w22
  2515b8: 54000400     	b.eq	0x251638 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7344>
  2515bc: f9400718     	ldr	x24, [x24, #0x8]
  2515c0: eb18035f     	cmp	x26, x24

## 251744 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251724: f9400008     	ldr	x8, [x0]
  251728: f9403108     	ldr	x8, [x8, #0x60]
  25172c: d63f0100     	blr	x8
  251730: aa0003f8     	mov	x24, x0
  251734: b7f80660     	tbnz	x0, #0x3f, 0x251800 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x750c>
  251738: f9400b68     	ldr	x8, [x27, #0x10]
  25173c: f9400100     	ldr	x0, [x8]
  251740: f9400008     	ldr	x8, [x0]
  251744: f9408508     	ldr	x8, [x8, #0x108]
  251748: d63f0100     	blr	x8
  25174c: 3100041f     	cmn	w0, #0x1
  251750: 54000220     	b.eq	0x251794 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x74a0>
  251754: 321c07e0     	orr	w0, wzr, #0x30
  251758: aa1503e1     	mov	x1, x21

## 251810 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2517f0: f9400718     	ldr	x24, [x24, #0x8]
  2517f4: eb18035f     	cmp	x26, x24
  2517f8: 54ffff01     	b.ne	0x2517d8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x74e4>
  2517fc: 14000021     	b	0x251880 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x758c>
  251800: 92800000     	mov	x0, #-0x1               // =-1
  251804: 17ffffe5     	b	0x251798 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x74a4>
  251808: f9400100     	ldr	x0, [x8]
  25180c: f9400008     	ldr	x8, [x0]
  251810: f9408508     	ldr	x8, [x8, #0x108]
  251814: d63f0100     	blr	x8
  251818: f94002a8     	ldr	x8, [x21]
  25181c: 2a0003e1     	mov	w1, w0
  251820: aa1503e0     	mov	x0, x21
  251824: f9402908     	ldr	x8, [x8, #0x50]

## 25186c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  25184c: 12800009     	mov	w9, #-0x1               // =-1
  251850: b9001509     	str	w9, [x8, #0x14]
  251854: 3900451f     	strb	wzr, [x8, #0x11]
  251858: f9409eb7     	ldr	x23, [x21, #0x138]
  25185c: 14000009     	b	0x251880 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x758c>
  251860: f9400ae8     	ldr	x8, [x23, #0x10]
  251864: f9400100     	ldr	x0, [x8]
  251868: f9400008     	ldr	x8, [x0]
  25186c: f9408508     	ldr	x8, [x8, #0x108]
  251870: d63f0100     	blr	x8
  251874: 6b16001f     	cmp	w0, w22
  251878: 540000a0     	b.eq	0x25188c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7598>
  25187c: f94006f7     	ldr	x23, [x23, #0x8]
  251880: eb17035f     	cmp	x26, x23

## 251910 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2518f0: 9104e2a8     	add	x8, x21, #0x138
  2518f4: 9104c2b7     	add	x23, x21, #0x130
  2518f8: f9400115     	ldr	x21, [x8]
  2518fc: eb1502ff     	cmp	x23, x21
  251900: 54000260     	b.eq	0x25194c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7658>
  251904: f9400aa8     	ldr	x8, [x21, #0x10]
  251908: f9400100     	ldr	x0, [x8]
  25190c: f9400008     	ldr	x8, [x0]
  251910: f9408508     	ldr	x8, [x8, #0x108]
  251914: d63f0100     	blr	x8
  251918: 6b14001f     	cmp	w0, w20
  25191c: 910022a8     	add	x8, x21, #0x8
  251920: 54fffec1     	b.ne	0x2518f8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7604>
  251924: f9400aa8     	ldr	x8, [x21, #0x10]

## 2519c0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2519a0: 9104c015     	add	x21, x0, #0x130
  2519a4: f90007e9     	str	x9, [sp, #0x8]
  2519a8: f9400116     	ldr	x22, [x8]
  2519ac: eb1602bf     	cmp	x21, x22
  2519b0: 54000260     	b.eq	0x2519fc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7708>
  2519b4: f9400ac8     	ldr	x8, [x22, #0x10]
  2519b8: f9400100     	ldr	x0, [x8]
  2519bc: f9400008     	ldr	x8, [x0]
  2519c0: f9408508     	ldr	x8, [x8, #0x108]
  2519c4: d63f0100     	blr	x8
  2519c8: 6b13001f     	cmp	w0, w19
  2519cc: 910022c8     	add	x8, x22, #0x8
  2519d0: 54fffec1     	b.ne	0x2519a8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x76b4>
  2519d4: f9400ac8     	ldr	x8, [x22, #0x10]

## 251aec — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251acc: 9104c015     	add	x21, x0, #0x130
  251ad0: f90007e9     	str	x9, [sp, #0x8]
  251ad4: f9400116     	ldr	x22, [x8]
  251ad8: eb1602bf     	cmp	x21, x22
  251adc: 54000220     	b.eq	0x251b20 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x782c>
  251ae0: f9400ac8     	ldr	x8, [x22, #0x10]
  251ae4: f9400100     	ldr	x0, [x8]
  251ae8: f9400008     	ldr	x8, [x0]
  251aec: f9408508     	ldr	x8, [x8, #0x108]
  251af0: d63f0100     	blr	x8
  251af4: 6b13001f     	cmp	w0, w19
  251af8: 910022c8     	add	x8, x22, #0x8
  251afc: 54fffec1     	b.ne	0x251ad4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x77e0>
  251b00: f9400ac8     	ldr	x8, [x22, #0x10]

## 251c80 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  251c60: 9104e008     	add	x8, x0, #0x138
  251c64: 9104c015     	add	x21, x0, #0x130
  251c68: f9400116     	ldr	x22, [x8]
  251c6c: eb1602bf     	cmp	x21, x22
  251c70: 540002a0     	b.eq	0x251cc4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x79d0>
  251c74: f9400ac8     	ldr	x8, [x22, #0x10]
  251c78: f9400100     	ldr	x0, [x8]
  251c7c: f9400008     	ldr	x8, [x0]
  251c80: f9408508     	ldr	x8, [x8, #0x108]
  251c84: d63f0100     	blr	x8
  251c88: 6b13001f     	cmp	w0, w19
  251c8c: 910022c8     	add	x8, x22, #0x8
  251c90: 54fffec1     	b.ne	0x251c68 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x7974>
  251c94: f9400ac8     	ldr	x8, [x22, #0x10]

## 267bdc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  267bbc: 97f9c40d     	bl	0xd8bf0 <memset@plt>
  267bc0: 12800008     	mov	w8, #-0x1               // =-1
  267bc4: b9000268     	str	w8, [x19]
  267bc8: f940a6e0     	ldr	x0, [x23, #0x148]
  267bcc: 13107ed5     	asr	w21, w22, #16
  267bd0: 12001ed9     	and	w25, w22, #0xff
  267bd4: b4000200     	cbz	x0, 0x267c14 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1d920>
  267bd8: f9400008     	ldr	x8, [x0]
  267bdc: f9408508     	ldr	x8, [x8, #0x108]
  267be0: d63f0100     	blr	x8
  267be4: 6b19001f     	cmp	w0, w25
  267be8: 54000661     	b.ne	0x267cb4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1d9c0>
  267bec: 320007e8     	orr	w8, wzr, #0x3
  267bf0: b9000268     	str	w8, [x19]

## 267e68 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  267e48: f9403529     	ldr	x9, [x9, #0x68]
  267e4c: d63f0120     	blr	x9
  267e50: b9000819     	str	w25, [x0, #0x8]
  267e54: 14000011     	b	0x267e98 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1dba4>
  267e58: 35001619     	cbnz	w25, 0x268118 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1de24>
  267e5c: f9400b88     	ldr	x8, [x28, #0x10]
  267e60: f9400100     	ldr	x0, [x8]
  267e64: f9400008     	ldr	x8, [x0]
  267e68: f9408508     	ldr	x8, [x8, #0x108]
  267e6c: d63f0100     	blr	x8
  267e70: 2a0003e3     	mov	w3, w0
  267e74: 321c07e0     	orr	w0, wzr, #0x30
  267e78: aa1703e1     	mov	x1, x23
  267e7c: aa1803e2     	mov	x2, x24

## 268074 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268054: f9400100     	ldr	x0, [x8]
  268058: f9400008     	ldr	x8, [x0]
  26805c: f9406108     	ldr	x8, [x8, #0xc0]
  268060: d63f0100     	blr	x8
  268064: 35000120     	cbnz	w0, 0x268088 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1dd94>
  268068: f9400ac8     	ldr	x8, [x22, #0x10]
  26806c: f9400100     	ldr	x0, [x8]
  268070: f9400008     	ldr	x8, [x0]
  268074: f9408508     	ldr	x8, [x8, #0x108]
  268078: d63f0100     	blr	x8
  26807c: b9416e68     	ldr	w8, [x19, #0x16c]
  268080: 6b08001f     	cmp	w0, w8
  268084: 1a9f17f7     	cset	w23, eq
  268088: f94006d6     	ldr	x22, [x22, #0x8]

## 268174 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268154: d63f0100     	blr	x8
  268158: f9400b88     	ldr	x8, [x28, #0x10]
  26815c: 3900411f     	strb	wzr, [x8, #0x10]
  268160: f9409e75     	ldr	x21, [x19, #0x138]
  268164: 1400000b     	b	0x268190 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1de9c>
  268168: f9400aa8     	ldr	x8, [x21, #0x10]
  26816c: f9400100     	ldr	x0, [x8]
  268170: f9400008     	ldr	x8, [x0]
  268174: f9408508     	ldr	x8, [x8, #0x108]
  268178: d63f0100     	blr	x8
  26817c: f9400b88     	ldr	x8, [x28, #0x10]
  268180: b9401509     	ldr	w9, [x8, #0x14]
  268184: 6b09001f     	cmp	w0, w9
  268188: 540003e0     	b.eq	0x268204 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1df10>

## 268314 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2682f4: f9400269     	ldr	x9, [x19]
  2682f8: aa1303e0     	mov	x0, x19
  2682fc: b9401501     	ldr	w1, [x8, #0x14]
  268300: f9402528     	ldr	x8, [x9, #0x48]
  268304: d63f0100     	blr	x8
  268308: f9400b88     	ldr	x8, [x28, #0x10]
  26830c: f9400100     	ldr	x0, [x8]
  268310: f9400008     	ldr	x8, [x0]
  268314: f9408508     	ldr	x8, [x8, #0x108]
  268318: d63f0100     	blr	x8
  26831c: f9400b88     	ldr	x8, [x28, #0x10]
  268320: f0001a81     	adrp	x1, 0x5bb000
  268324: d0001a82     	adrp	x2, 0x5ba000
  268328: 2a0003e3     	mov	w3, w0

## 268410 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2683f0: f9400100     	ldr	x0, [x8]
  2683f4: f900a660     	str	x0, [x19, #0x148]
  2683f8: 14000043     	b	0x268504 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e210>
  2683fc: 9104c275     	add	x21, x19, #0x130
  268400: 14000009     	b	0x268424 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e130>
  268404: f9400ae8     	ldr	x8, [x23, #0x10]
  268408: f9400100     	ldr	x0, [x8]
  26840c: f9400008     	ldr	x8, [x0]
  268410: f9408508     	ldr	x8, [x8, #0x108]
  268414: d63f0100     	blr	x8
  268418: 6b14001f     	cmp	w0, w20
  26841c: 540000c0     	b.eq	0x268434 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e140>
  268420: f94006f7     	ldr	x23, [x23, #0x8]
  268424: eb1702bf     	cmp	x21, x23

## 268590 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268570: 9104c017     	add	x23, x0, #0x130
  268574: f90007e9     	str	x9, [sp, #0x8]
  268578: f9400118     	ldr	x24, [x8]
  26857c: eb1802ff     	cmp	x23, x24
  268580: 540001e0     	b.eq	0x2685bc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e2c8>
  268584: f9400b08     	ldr	x8, [x24, #0x10]
  268588: f9400100     	ldr	x0, [x8]
  26858c: f9400008     	ldr	x8, [x0]
  268590: f9408508     	ldr	x8, [x8, #0x108]
  268594: d63f0100     	blr	x8
  268598: 6b15001f     	cmp	w0, w21
  26859c: 91002308     	add	x8, x24, #0x8
  2685a0: 54fffec1     	b.ne	0x268578 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e284>
  2685a4: f9400b08     	ldr	x8, [x24, #0x10]

## 268648 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268628: 9104c015     	add	x21, x0, #0x130
  26862c: f90007e9     	str	x9, [sp, #0x8]
  268630: f9400116     	ldr	x22, [x8]
  268634: eb1602bf     	cmp	x21, x22
  268638: 54000220     	b.eq	0x26867c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e388>
  26863c: f9400ac8     	ldr	x8, [x22, #0x10]
  268640: f9400100     	ldr	x0, [x8]
  268644: f9400008     	ldr	x8, [x0]
  268648: f9408508     	ldr	x8, [x8, #0x108]
  26864c: d63f0100     	blr	x8
  268650: 6b13001f     	cmp	w0, w19
  268654: 910022c8     	add	x8, x22, #0x8
  268658: 54fffec1     	b.ne	0x268630 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e33c>
  26865c: f9400ac8     	ldr	x8, [x22, #0x10]

## 268718 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2686f8: 9104e268     	add	x8, x19, #0x138
  2686fc: 9104c277     	add	x23, x19, #0x130
  268700: f9400116     	ldr	x22, [x8]
  268704: eb1602ff     	cmp	x23, x22
  268708: 54000520     	b.eq	0x2687ac <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e4b8>
  26870c: f9400ac8     	ldr	x8, [x22, #0x10]
  268710: f9400100     	ldr	x0, [x8]
  268714: f9400008     	ldr	x8, [x0]
  268718: f9408508     	ldr	x8, [x8, #0x108]
  26871c: d63f0100     	blr	x8
  268720: 6b14001f     	cmp	w0, w20
  268724: 910022c8     	add	x8, x22, #0x8
  268728: 54fffec1     	b.ne	0x268700 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e40c>
  26872c: f9400ac8     	ldr	x8, [x22, #0x10]

## 268864 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268844: 9104e2a8     	add	x8, x21, #0x138
  268848: 9104c2b6     	add	x22, x21, #0x130
  26884c: f9400115     	ldr	x21, [x8]
  268850: eb1502df     	cmp	x22, x21
  268854: 540002a0     	b.eq	0x2688a8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e5b4>
  268858: f9400aa8     	ldr	x8, [x21, #0x10]
  26885c: f9400100     	ldr	x0, [x8]
  268860: f9400008     	ldr	x8, [x0]
  268864: f9408508     	ldr	x8, [x8, #0x108]
  268868: d63f0100     	blr	x8
  26886c: 6b14001f     	cmp	w0, w20
  268870: 910022a8     	add	x8, x21, #0x8
  268874: 54fffec1     	b.ne	0x26884c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e558>
  268878: f9400aa8     	ldr	x8, [x21, #0x10]

## 268a88 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268a68: eb18035f     	cmp	x26, x24
  268a6c: 540007e0     	b.eq	0x268b68 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e874>
  268a70: 12800016     	mov	w22, #-0x1              // =-1
  268a74: f9400b08     	ldr	x8, [x24, #0x10]
  268a78: 39404509     	ldrb	w9, [x8, #0x11]
  268a7c: 34000289     	cbz	w9, 0x268acc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e7d8>
  268a80: f9400100     	ldr	x0, [x8]
  268a84: f9400008     	ldr	x8, [x0]
  268a88: f9408508     	ldr	x8, [x8, #0x108]
  268a8c: d63f0100     	blr	x8
  268a90: f94002a8     	ldr	x8, [x21]
  268a94: 2a0003e1     	mov	w1, w0
  268a98: aa1503e0     	mov	x0, x21
  268a9c: f9402908     	ldr	x8, [x8, #0x50]

## 268aec — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268acc: f9400718     	ldr	x24, [x24, #0x8]
  268ad0: eb18035f     	cmp	x26, x24
  268ad4: 54fffd01     	b.ne	0x268a74 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e780>
  268ad8: f9409eb8     	ldr	x24, [x21, #0x138]
  268adc: 14000023     	b	0x268b68 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e874>
  268ae0: f9400b08     	ldr	x8, [x24, #0x10]
  268ae4: f9400100     	ldr	x0, [x8]
  268ae8: f9400008     	ldr	x8, [x0]
  268aec: f9408508     	ldr	x8, [x8, #0x108]
  268af0: d63f0100     	blr	x8
  268af4: 6b16001f     	cmp	w0, w22
  268af8: 54000400     	b.eq	0x268b78 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e884>
  268afc: f9400718     	ldr	x24, [x24, #0x8]
  268b00: eb18035f     	cmp	x26, x24

## 268c84 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268c64: f9400008     	ldr	x8, [x0]
  268c68: f9403108     	ldr	x8, [x8, #0x60]
  268c6c: d63f0100     	blr	x8
  268c70: aa0003f8     	mov	x24, x0
  268c74: b7f80660     	tbnz	x0, #0x3f, 0x268d40 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ea4c>
  268c78: f9400b68     	ldr	x8, [x27, #0x10]
  268c7c: f9400100     	ldr	x0, [x8]
  268c80: f9400008     	ldr	x8, [x0]
  268c84: f9408508     	ldr	x8, [x8, #0x108]
  268c88: d63f0100     	blr	x8
  268c8c: 3100041f     	cmn	w0, #0x1
  268c90: 54000220     	b.eq	0x268cd4 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e9e0>
  268c94: 321c07e0     	orr	w0, wzr, #0x30
  268c98: aa1503e1     	mov	x1, x21

## 268d50 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268d30: f9400718     	ldr	x24, [x24, #0x8]
  268d34: eb18035f     	cmp	x26, x24
  268d38: 54ffff01     	b.ne	0x268d18 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ea24>
  268d3c: 14000021     	b	0x268dc0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1eacc>
  268d40: 92800000     	mov	x0, #-0x1               // =-1
  268d44: 17ffffe5     	b	0x268cd8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1e9e4>
  268d48: f9400100     	ldr	x0, [x8]
  268d4c: f9400008     	ldr	x8, [x0]
  268d50: f9408508     	ldr	x8, [x8, #0x108]
  268d54: d63f0100     	blr	x8
  268d58: f94002a8     	ldr	x8, [x21]
  268d5c: 2a0003e1     	mov	w1, w0
  268d60: aa1503e0     	mov	x0, x21
  268d64: f9402908     	ldr	x8, [x8, #0x50]

## 268dac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268d8c: 12800009     	mov	w9, #-0x1               // =-1
  268d90: b9001509     	str	w9, [x8, #0x14]
  268d94: 3900451f     	strb	wzr, [x8, #0x11]
  268d98: f9409eb7     	ldr	x23, [x21, #0x138]
  268d9c: 14000009     	b	0x268dc0 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1eacc>
  268da0: f9400ae8     	ldr	x8, [x23, #0x10]
  268da4: f9400100     	ldr	x0, [x8]
  268da8: f9400008     	ldr	x8, [x0]
  268dac: f9408508     	ldr	x8, [x8, #0x108]
  268db0: d63f0100     	blr	x8
  268db4: 6b16001f     	cmp	w0, w22
  268db8: 540000a0     	b.eq	0x268dcc <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ead8>
  268dbc: f94006f7     	ldr	x23, [x23, #0x8]
  268dc0: eb17035f     	cmp	x26, x23

## 268e50 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268e30: 9104e2a8     	add	x8, x21, #0x138
  268e34: 9104c2b7     	add	x23, x21, #0x130
  268e38: f9400115     	ldr	x21, [x8]
  268e3c: eb1502ff     	cmp	x23, x21
  268e40: 54000260     	b.eq	0x268e8c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1eb98>
  268e44: f9400aa8     	ldr	x8, [x21, #0x10]
  268e48: f9400100     	ldr	x0, [x8]
  268e4c: f9400008     	ldr	x8, [x0]
  268e50: f9408508     	ldr	x8, [x8, #0x108]
  268e54: d63f0100     	blr	x8
  268e58: 6b14001f     	cmp	w0, w20
  268e5c: 910022a8     	add	x8, x21, #0x8
  268e60: 54fffec1     	b.ne	0x268e38 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1eb44>
  268e64: f9400aa8     	ldr	x8, [x21, #0x10]

## 268f00 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  268ee0: 9104c015     	add	x21, x0, #0x130
  268ee4: f90007e9     	str	x9, [sp, #0x8]
  268ee8: f9400116     	ldr	x22, [x8]
  268eec: eb1602bf     	cmp	x21, x22
  268ef0: 54000260     	b.eq	0x268f3c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ec48>
  268ef4: f9400ac8     	ldr	x8, [x22, #0x10]
  268ef8: f9400100     	ldr	x0, [x8]
  268efc: f9400008     	ldr	x8, [x0]
  268f00: f9408508     	ldr	x8, [x8, #0x108]
  268f04: d63f0100     	blr	x8
  268f08: 6b13001f     	cmp	w0, w19
  268f0c: 910022c8     	add	x8, x22, #0x8
  268f10: 54fffec1     	b.ne	0x268ee8 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ebf4>
  268f14: f9400ac8     	ldr	x8, [x22, #0x10]

## 26902c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  26900c: 9104c015     	add	x21, x0, #0x130
  269010: f90007e9     	str	x9, [sp, #0x8]
  269014: f9400116     	ldr	x22, [x8]
  269018: eb1602bf     	cmp	x21, x22
  26901c: 54000220     	b.eq	0x269060 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ed6c>
  269020: f9400ac8     	ldr	x8, [x22, #0x10]
  269024: f9400100     	ldr	x0, [x8]
  269028: f9400008     	ldr	x8, [x0]
  26902c: f9408508     	ldr	x8, [x8, #0x108]
  269030: d63f0100     	blr	x8
  269034: 6b13001f     	cmp	w0, w19
  269038: 910022c8     	add	x8, x22, #0x8
  26903c: 54fffec1     	b.ne	0x269014 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ed20>
  269040: f9400ac8     	ldr	x8, [x22, #0x10]

## 269140 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  269120: 9104c015     	add	x21, x0, #0x130
  269124: f90007e9     	str	x9, [sp, #0x8]
  269128: f9400116     	ldr	x22, [x8]
  26912c: eb1602bf     	cmp	x21, x22
  269130: 54000220     	b.eq	0x269174 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ee80>
  269134: f9400ac8     	ldr	x8, [x22, #0x10]
  269138: f9400100     	ldr	x0, [x8]
  26913c: f9400008     	ldr	x8, [x0]
  269140: f9408508     	ldr	x8, [x8, #0x108]
  269144: d63f0100     	blr	x8
  269148: 6b13001f     	cmp	w0, w19
  26914c: 910022c8     	add	x8, x22, #0x8
  269150: 54fffec1     	b.ne	0x269128 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ee34>
  269154: f9400ac8     	ldr	x8, [x22, #0x10]

## 269240 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  269220: 9104e008     	add	x8, x0, #0x138
  269224: 9104c015     	add	x21, x0, #0x130
  269228: f9400116     	ldr	x22, [x8]
  26922c: eb1602bf     	cmp	x21, x22
  269230: 540002a0     	b.eq	0x269284 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ef90>
  269234: f9400ac8     	ldr	x8, [x22, #0x10]
  269238: f9400100     	ldr	x0, [x8]
  26923c: f9400008     	ldr	x8, [x0]
  269240: f9408508     	ldr	x8, [x8, #0x108]
  269244: d63f0100     	blr	x8
  269248: 6b13001f     	cmp	w0, w19
  26924c: 910022c8     	add	x8, x22, #0x8
  269250: 54fffec1     	b.ne	0x269228 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1ef34>
  269254: f9400ac8     	ldr	x8, [x22, #0x10]

## 2693f0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_
Basis: no target-vtable provenance established
ASM:
  2693d0: 7100051f     	cmp	w8, #0x1
  2693d4: 5400038b     	b.lt	0x269444 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1f150>
  2693d8: f9409e76     	ldr	x22, [x19, #0x138]
  2693dc: 9104c277     	add	x23, x19, #0x130
  2693e0: 14000017     	b	0x26943c <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1f148>
  2693e4: f9400ac8     	ldr	x8, [x22, #0x10]
  2693e8: f9400100     	ldr	x0, [x8]
  2693ec: f9400008     	ldr	x8, [x0]
  2693f0: f9408508     	ldr	x8, [x8, #0x108]
  2693f4: d63f0100     	blr	x8
  2693f8: b9416e68     	ldr	w8, [x19, #0x16c]
  2693fc: 6b08001f     	cmp	w0, w8
  269400: 540001c1     	b.ne	0x269438 <_ZN6Cicada12avAESEncrypt7encryptEPhPKhiS1_+0x1f144>
  269404: f9400ac8     	ldr	x8, [x22, #0x10]

## 275744 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada3hls10TagFactory15createTagByNameERKNSt6__ndk112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEESA_
Basis: object-vptr load found but constructor provenance is not established
ASM:
  275724: f9400268     	ldr	x8, [x19]
  275728: aa1303e0     	mov	x0, x19
  27572c: f9406108     	ldr	x8, [x8, #0xc0]
  275730: d63f0100     	blr	x8
  275734: b900a3e0     	str	w0, [sp, #0xa0]
  275738: f9002ff4     	str	x20, [sp, #0x58]
  27573c: f9400268     	ldr	x8, [x19]
  275740: aa1303e0     	mov	x0, x19
  275744: f9408508     	ldr	x8, [x8, #0x108]
  275748: d63f0100     	blr	x8
  27574c: 510006a8     	sub	w8, w21, #0x1
  275750: 71000d1f     	cmp	w8, #0x3
  275754: b9006be0     	str	w0, [sp, #0x68]
  275758: 540012c8     	b.hi	0x2759b0 <_ZN6Cicada3hls10TagFactory15createTagByNameERKNSt6__ndk112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEESA_+0x3c94>

## 27af18 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27aef8: aa1303e0     	mov	x0, x19
  27aefc: f9405508     	ldr	x8, [x8, #0xa8]
  27af00: d63f0100     	blr	x8
  27af04: f90132c0     	str	x0, [x22, #0x260]
  27af08: f9400268     	ldr	x8, [x19]
  27af0c: f0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27af10: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af14: aa0003e1     	mov	x1, x0
  27af18: f9408508     	ldr	x8, [x8, #0x108]
  27af1c: 91141042     	add	x2, x2, #0x504
  27af20: 91142c63     	add	x3, x3, #0x50b
  27af24: aa1303e0     	mov	x0, x19
  27af28: d63f0100     	blr	x8
  27af2c: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27af44 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27af24: aa1303e0     	mov	x0, x19
  27af28: d63f0100     	blr	x8
  27af2c: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af30: f9013500     	str	x0, [x8, #0x268]
  27af34: f9400268     	ldr	x8, [x19]
  27af38: f94132c1     	ldr	x1, [x22, #0x260]
  27af3c: d0001a02     	adrp	x2, 0x5bc000
  27af40: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af44: f9408508     	ldr	x8, [x8, #0x108]
  27af48: 9117d842     	add	x2, x2, #0x5f6
  27af4c: 9138e063     	add	x3, x3, #0xe38
  27af50: aa1303e0     	mov	x0, x19
  27af54: d63f0100     	blr	x8
  27af58: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27af70 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27af50: aa1303e0     	mov	x0, x19
  27af54: d63f0100     	blr	x8
  27af58: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af5c: f9013900     	str	x0, [x8, #0x270]
  27af60: f9400268     	ldr	x8, [x19]
  27af64: f94132c1     	ldr	x1, [x22, #0x260]
  27af68: d0001a02     	adrp	x2, 0x5bc000
  27af6c: d0001a03     	adrp	x3, 0x5bc000
  27af70: f9408508     	ldr	x8, [x8, #0x108]
  27af74: 91182c42     	add	x2, x2, #0x60b
  27af78: 91185863     	add	x3, x3, #0x616
  27af7c: aa1303e0     	mov	x0, x19
  27af80: d63f0100     	blr	x8
  27af84: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27af9c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27af7c: aa1303e0     	mov	x0, x19
  27af80: d63f0100     	blr	x8
  27af84: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af88: f9013d00     	str	x0, [x8, #0x278]
  27af8c: f9400268     	ldr	x8, [x19]
  27af90: f94132c1     	ldr	x1, [x22, #0x260]
  27af94: d0001a02     	adrp	x2, 0x5bc000
  27af98: f0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27af9c: f9408508     	ldr	x8, [x8, #0x108]
  27afa0: 9118b842     	add	x2, x2, #0x62e
  27afa4: 9139c463     	add	x3, x3, #0xe71
  27afa8: aa1303e0     	mov	x0, x19
  27afac: d63f0100     	blr	x8
  27afb0: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27afc8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27afa8: aa1303e0     	mov	x0, x19
  27afac: d63f0100     	blr	x8
  27afb0: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27afb4: f9014100     	str	x0, [x8, #0x280]
  27afb8: f9400268     	ldr	x8, [x19]
  27afbc: f94132c1     	ldr	x1, [x22, #0x260]
  27afc0: d0001a02     	adrp	x2, 0x5bc000
  27afc4: d0001a03     	adrp	x3, 0x5bc000
  27afc8: f9408508     	ldr	x8, [x8, #0x108]
  27afcc: 91191842     	add	x2, x2, #0x646
  27afd0: 91195463     	add	x3, x3, #0x655
  27afd4: aa1303e0     	mov	x0, x19
  27afd8: d63f0100     	blr	x8
  27afdc: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27aff4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27afd4: aa1303e0     	mov	x0, x19
  27afd8: d63f0100     	blr	x8
  27afdc: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27afe0: f9014500     	str	x0, [x8, #0x288]
  27afe4: f9400268     	ldr	x8, [x19]
  27afe8: f94132c1     	ldr	x1, [x22, #0x260]
  27afec: d0001a02     	adrp	x2, 0x5bc000
  27aff0: d0001a03     	adrp	x3, 0x5bc000
  27aff4: f9408508     	ldr	x8, [x8, #0x108]
  27aff8: 911a0442     	add	x2, x2, #0x681
  27affc: 911a4063     	add	x3, x3, #0x690
  27b000: aa1303e0     	mov	x0, x19
  27b004: d63f0100     	blr	x8
  27b008: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27b020 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b000: aa1303e0     	mov	x0, x19
  27b004: d63f0100     	blr	x8
  27b008: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b00c: f9014900     	str	x0, [x8, #0x290]
  27b010: f9400268     	ldr	x8, [x19]
  27b014: f94132c1     	ldr	x1, [x22, #0x260]
  27b018: d0001914     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  27b01c: b00019e2     	adrp	x2, 0x5b8000
  27b020: f9408508     	ldr	x8, [x8, #0x108]
  27b024: 91174694     	add	x20, x20, #0x5d1
  27b028: 91118842     	add	x2, x2, #0x462
  27b02c: aa1303e0     	mov	x0, x19
  27b030: aa1403e3     	mov	x3, x20
  27b034: d63f0100     	blr	x8

## 27b050 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b030: aa1403e3     	mov	x3, x20
  27b034: d63f0100     	blr	x8
  27b038: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b03c: f9014d00     	str	x0, [x8, #0x298]
  27b040: f9400268     	ldr	x8, [x19]
  27b044: f94132c1     	ldr	x1, [x22, #0x260]
  27b048: b00019e2     	adrp	x2, 0x5b8000
  27b04c: 91146042     	add	x2, x2, #0x518
  27b050: f9408508     	ldr	x8, [x8, #0x108]
  27b054: aa1303e0     	mov	x0, x19
  27b058: aa1403e3     	mov	x3, x20
  27b05c: d63f0100     	blr	x8
  27b060: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b064: f9015100     	str	x0, [x8, #0x2a0]

## 27b078 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b058: aa1403e3     	mov	x3, x20
  27b05c: d63f0100     	blr	x8
  27b060: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b064: f9015100     	str	x0, [x8, #0x2a0]
  27b068: f9400268     	ldr	x8, [x19]
  27b06c: f94132c1     	ldr	x1, [x22, #0x260]
  27b070: b00019e2     	adrp	x2, 0x5b8000
  27b074: 9111a042     	add	x2, x2, #0x468
  27b078: f9408508     	ldr	x8, [x8, #0x108]
  27b07c: aa1303e0     	mov	x0, x19
  27b080: aa1403e3     	mov	x3, x20
  27b084: d63f0100     	blr	x8
  27b088: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b08c: f9015500     	str	x0, [x8, #0x2a8]

## 27b0a0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b080: aa1403e3     	mov	x3, x20
  27b084: d63f0100     	blr	x8
  27b088: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b08c: f9015500     	str	x0, [x8, #0x2a8]
  27b090: f9400268     	ldr	x8, [x19]
  27b094: f94132c1     	ldr	x1, [x22, #0x260]
  27b098: d0001962     	adrp	x2, 0x5a9000
  27b09c: 91166042     	add	x2, x2, #0x598
  27b0a0: f9408508     	ldr	x8, [x8, #0x108]
  27b0a4: aa1303e0     	mov	x0, x19
  27b0a8: aa1403e3     	mov	x3, x20
  27b0ac: d63f0100     	blr	x8
  27b0b0: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b0b4: f9015900     	str	x0, [x8, #0x2b0]

## 27b0c8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b0a8: aa1403e3     	mov	x3, x20
  27b0ac: d63f0100     	blr	x8
  27b0b0: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b0b4: f9015900     	str	x0, [x8, #0x2b0]
  27b0b8: f9400268     	ldr	x8, [x19]
  27b0bc: f94132c1     	ldr	x1, [x22, #0x260]
  27b0c0: b0001a02     	adrp	x2, 0x5bc000
  27b0c4: b0001a03     	adrp	x3, 0x5bc000
  27b0c8: f9408508     	ldr	x8, [x8, #0x108]
  27b0cc: 911aa442     	add	x2, x2, #0x6a9
  27b0d0: 911af463     	add	x3, x3, #0x6bd
  27b0d4: aa1303e0     	mov	x0, x19
  27b0d8: d63f0100     	blr	x8
  27b0dc: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27b0f4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b0d4: aa1303e0     	mov	x0, x19
  27b0d8: d63f0100     	blr	x8
  27b0dc: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b0e0: f9015d00     	str	x0, [x8, #0x2b8]
  27b0e4: f9400268     	ldr	x8, [x19]
  27b0e8: f94132c1     	ldr	x1, [x22, #0x260]
  27b0ec: b0001a14     	adrp	x20, 0x5bc000
  27b0f0: b0001a02     	adrp	x2, 0x5bc000
  27b0f4: f9408508     	ldr	x8, [x8, #0x108]
  27b0f8: 911b6e94     	add	x20, x20, #0x6db
  27b0fc: 911b0c42     	add	x2, x2, #0x6c3
  27b100: aa1303e0     	mov	x0, x19
  27b104: aa1403e3     	mov	x3, x20
  27b108: d63f0100     	blr	x8

## 27b124 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b104: aa1403e3     	mov	x3, x20
  27b108: d63f0100     	blr	x8
  27b10c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b110: f9016100     	str	x0, [x8, #0x2c0]
  27b114: f9400268     	ldr	x8, [x19]
  27b118: f94132c1     	ldr	x1, [x22, #0x260]
  27b11c: b0001a02     	adrp	x2, 0x5bc000
  27b120: b0001a03     	adrp	x3, 0x5bc000
  27b124: f9408508     	ldr	x8, [x8, #0x108]
  27b128: 911b8042     	add	x2, x2, #0x6e0
  27b12c: 911bc463     	add	x3, x3, #0x6f1
  27b130: aa1303e0     	mov	x0, x19
  27b134: d63f0100     	blr	x8
  27b138: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27b150 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b130: aa1303e0     	mov	x0, x19
  27b134: d63f0100     	blr	x8
  27b138: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b13c: f9016500     	str	x0, [x8, #0x2c8]
  27b140: f9400268     	ldr	x8, [x19]
  27b144: f94132c1     	ldr	x1, [x22, #0x260]
  27b148: b0001a02     	adrp	x2, 0x5bc000
  27b14c: b0001a03     	adrp	x3, 0x5bc000
  27b150: f9408508     	ldr	x8, [x8, #0x108]
  27b154: 911be842     	add	x2, x2, #0x6fa
  27b158: 911c4463     	add	x3, x3, #0x711
  27b15c: aa1303e0     	mov	x0, x19
  27b160: d63f0100     	blr	x8
  27b164: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27b17c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b15c: aa1303e0     	mov	x0, x19
  27b160: d63f0100     	blr	x8
  27b164: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b168: f9016900     	str	x0, [x8, #0x2d0]
  27b16c: f9400268     	ldr	x8, [x19]
  27b170: f94132c1     	ldr	x1, [x22, #0x260]
  27b174: b0001a02     	adrp	x2, 0x5bc000
  27b178: 911cb042     	add	x2, x2, #0x72c
  27b17c: f9408508     	ldr	x8, [x8, #0x108]
  27b180: aa1303e0     	mov	x0, x19
  27b184: aa1403e3     	mov	x3, x20
  27b188: d63f0100     	blr	x8
  27b18c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b190: f9016d00     	str	x0, [x8, #0x2d8]

## 27b1a4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b184: aa1403e3     	mov	x3, x20
  27b188: d63f0100     	blr	x8
  27b18c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b190: f9016d00     	str	x0, [x8, #0x2d8]
  27b194: f9400268     	ldr	x8, [x19]
  27b198: f94132c1     	ldr	x1, [x22, #0x260]
  27b19c: 90001934     	adrp	x20, 0x59f000
  27b1a0: b0001a02     	adrp	x2, 0x5bc000
  27b1a4: f9408508     	ldr	x8, [x8, #0x108]
  27b1a8: 91189694     	add	x20, x20, #0x625
  27b1ac: 911d1442     	add	x2, x2, #0x745
  27b1b0: aa1303e0     	mov	x0, x19
  27b1b4: aa1403e3     	mov	x3, x20
  27b1b8: d63f0100     	blr	x8

## 27b1d8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b1b8: d63f0100     	blr	x8
  27b1bc: f0002677     	adrp	x23, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b1c0: 910bc2f7     	add	x23, x23, #0x2f0
  27b1c4: f90002e0     	str	x0, [x23]
  27b1c8: f9400268     	ldr	x8, [x19]
  27b1cc: f94132c1     	ldr	x1, [x22, #0x260]
  27b1d0: b0001a02     	adrp	x2, 0x5bc000
  27b1d4: 911d6442     	add	x2, x2, #0x759
  27b1d8: f9408508     	ldr	x8, [x8, #0x108]
  27b1dc: aa1303e0     	mov	x0, x19
  27b1e0: aa1403e3     	mov	x3, x20
  27b1e4: d63f0100     	blr	x8
  27b1e8: f90006e0     	str	x0, [x23, #0x8]
  27b1ec: f9400268     	ldr	x8, [x19]

## 27b1fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b1dc: aa1303e0     	mov	x0, x19
  27b1e0: aa1403e3     	mov	x3, x20
  27b1e4: d63f0100     	blr	x8
  27b1e8: f90006e0     	str	x0, [x23, #0x8]
  27b1ec: f9400268     	ldr	x8, [x19]
  27b1f0: f94132c1     	ldr	x1, [x22, #0x260]
  27b1f4: b0001a02     	adrp	x2, 0x5bc000
  27b1f8: f0001903     	adrp	x3, 0x59e000
  27b1fc: f9408508     	ldr	x8, [x8, #0x108]
  27b200: 911d9842     	add	x2, x2, #0x766
  27b204: 91389c63     	add	x3, x3, #0xe27
  27b208: aa1303e0     	mov	x0, x19
  27b20c: d63f0100     	blr	x8
  27b210: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27b228 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27b208: aa1303e0     	mov	x0, x19
  27b20c: d63f0100     	blr	x8
  27b210: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b214: f9017100     	str	x0, [x8, #0x2e0]
  27b218: f9400268     	ldr	x8, [x19]
  27b21c: f94132c1     	ldr	x1, [x22, #0x260]
  27b220: b0001a02     	adrp	x2, 0x5bc000
  27b224: f0001923     	adrp	x3, 0x5a2000
  27b228: f9408508     	ldr	x8, [x8, #0x108]
  27b22c: 911dd442     	add	x2, x2, #0x775
  27b230: 91192863     	add	x3, x3, #0x64a
  27b234: aa1303e0     	mov	x0, x19
  27b238: d63f0100     	blr	x8
  27b23c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27c860 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c840: aa1303e0     	mov	x0, x19
  27c844: f9405508     	ldr	x8, [x8, #0xa8]
  27c848: d63f0100     	blr	x8
  27c84c: f901dac0     	str	x0, [x22, #0x3b0]
  27c850: f9400268     	ldr	x8, [x19]
  27c854: b0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27c858: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c85c: aa0003e1     	mov	x1, x0
  27c860: f9408508     	ldr	x8, [x8, #0x108]
  27c864: 91141042     	add	x2, x2, #0x504
  27c868: 91142c63     	add	x3, x3, #0x50b
  27c86c: aa1303e0     	mov	x0, x19
  27c870: d63f0100     	blr	x8
  27c874: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27c88c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c86c: aa1303e0     	mov	x0, x19
  27c870: d63f0100     	blr	x8
  27c874: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27c878: f901dd00     	str	x0, [x8, #0x3b8]
  27c87c: f9400268     	ldr	x8, [x19]
  27c880: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c884: 90001a02     	adrp	x2, 0x5bc000
  27c888: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c88c: f9408508     	ldr	x8, [x8, #0x108]
  27c890: 9123fc42     	add	x2, x2, #0x8ff
  27c894: 91158463     	add	x3, x3, #0x561
  27c898: aa1303e0     	mov	x0, x19
  27c89c: d63f0100     	blr	x8
  27c8a0: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27c910 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c8f0: aa1403e3     	mov	x3, x20
  27c8f4: d63f0100     	blr	x8
  27c8f8: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27c8fc: f901e500     	str	x0, [x8, #0x3c8]
  27c900: f9400268     	ldr	x8, [x19]
  27c904: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c908: b0001914     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  27c90c: 90001a02     	adrp	x2, 0x5bc000
  27c910: f9408508     	ldr	x8, [x8, #0x108]
  27c914: 9113c294     	add	x20, x20, #0x4f0
  27c918: 9124a842     	add	x2, x2, #0x92a
  27c91c: aa1303e0     	mov	x0, x19
  27c920: aa1403e3     	mov	x3, x20
  27c924: d63f0100     	blr	x8

## 27c940 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c920: aa1403e3     	mov	x3, x20
  27c924: d63f0100     	blr	x8
  27c928: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27c92c: f901ed00     	str	x0, [x8, #0x3d8]
  27c930: f9400268     	ldr	x8, [x19]
  27c934: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c938: 90001a02     	adrp	x2, 0x5bc000
  27c93c: 9124cc42     	add	x2, x2, #0x933
  27c940: f9408508     	ldr	x8, [x8, #0x108]
  27c944: aa1303e0     	mov	x0, x19
  27c948: aa1403e3     	mov	x3, x20
  27c94c: d63f0100     	blr	x8
  27c950: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27c954: f901f100     	str	x0, [x8, #0x3e0]

## 27c968 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c948: aa1403e3     	mov	x3, x20
  27c94c: d63f0100     	blr	x8
  27c950: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27c954: f901f100     	str	x0, [x8, #0x3e0]
  27c958: f9400268     	ldr	x8, [x19]
  27c95c: f941dac1     	ldr	x1, [x22, #0x3b0]
  27c960: 90001a02     	adrp	x2, 0x5bc000
  27c964: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c968: f9408508     	ldr	x8, [x8, #0x108]
  27c96c: 9124e442     	add	x2, x2, #0x939
  27c970: 9138e063     	add	x3, x3, #0xe38
  27c974: aa1303e0     	mov	x0, x19
  27c978: d63f0100     	blr	x8
  27c97c: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27c9d4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN18codecPluginManager13dummyFunctionEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  27c9b4: aa1303e0     	mov	x0, x19
  27c9b8: f9405508     	ldr	x8, [x8, #0xa8]
  27c9bc: d63f0100     	blr	x8
  27c9c0: f901fac0     	str	x0, [x22, #0x3f0]
  27c9c4: f9400268     	ldr	x8, [x19]
  27c9c8: b0001902     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27c9cc: b0001903     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  27c9d0: aa0003e1     	mov	x1, x0
  27c9d4: f9408508     	ldr	x8, [x8, #0x108]
  27c9d8: 91141042     	add	x2, x2, #0x504
  27c9dc: 91142c63     	add	x3, x3, #0x50b
  27c9e0: aa1303e0     	mov	x0, x19
  27c9e4: d63f0100     	blr	x8
  27c9e8: d0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 27ea90 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN13ActiveDecoder14updateMetaDataEPK11Stream_meta
Basis: no target-vtable provenance established
ASM:
  27ea70: d100c3ff     	sub	sp, sp, #0x30
  27ea74: f9000bf3     	str	x19, [sp, #0x10]
  27ea78: a9027bfd     	stp	x29, x30, [sp, #0x20]
  27ea7c: 910083fd     	add	x29, sp, #0x20
  27ea80: d53bd053     	mrs	x19, TPIDR_EL0
  27ea84: f9401668     	ldr	x8, [x19, #0x28]
  27ea88: f90007e8     	str	x8, [sp, #0x8]
  27ea8c: f9400008     	ldr	x8, [x0]
  27ea90: f9408508     	ldr	x8, [x8, #0x108]
  27ea94: d63f0100     	blr	x8
  27ea98: f9401668     	ldr	x8, [x19, #0x28]
  27ea9c: f94007e9     	ldr	x9, [sp, #0x8]
  27eaa0: eb09011f     	cmp	x8, x9
  27eaa4: 540000a1     	b.ne	0x27eab8 <_ZN13ActiveDecoder14updateMetaDataEPK11Stream_meta+0x48>

## 27fcf8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fcd8: 2a1603e4     	mov	w4, w22
  27fcdc: 94000106     	bl	0x2800f4 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE+0xbdc>
  27fce0: 2a0003f7     	mov	w23, w0
  27fce4: 37f805a0     	tbnz	w0, #0x1f, 0x27fd98 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE+0x880>
  27fce8: f9400288     	ldr	x8, [x20]
  27fcec: d00018e2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  27fcf0: b00019e3     	adrp	x3, 0x5bc000
  27fcf4: 91141042     	add	x2, x2, #0x504
  27fcf8: f9408508     	ldr	x8, [x8, #0x108]
  27fcfc: 91391063     	add	x3, x3, #0xe44
  27fd00: aa1403e0     	mov	x0, x20
  27fd04: aa1503e1     	mov	x1, x21
  27fd08: d63f0100     	blr	x8
  27fd0c: aa0003f8     	mov	x24, x0

## 27fe5c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fe3c: aa1803e1     	mov	x1, x24
  27fe40: f9405508     	ldr	x8, [x8, #0xa8]
  27fe44: d63f0100     	blr	x8
  27fe48: f9009a60     	str	x0, [x19, #0x130]
  27fe4c: f9400288     	ldr	x8, [x20]
  27fe50: b00019e2     	adrp	x2, 0x5bc000
  27fe54: b00019e3     	adrp	x3, 0x5bc000
  27fe58: 913a6842     	add	x2, x2, #0xe9a
  27fe5c: f9408508     	ldr	x8, [x8, #0x108]
  27fe60: 913aa863     	add	x3, x3, #0xeaa
  27fe64: aa1403e0     	mov	x0, x20
  27fe68: aa1503e1     	mov	x1, x21
  27fe6c: d63f0100     	blr	x8
  27fe70: f900b660     	str	x0, [x19, #0x168]

## 27fe84 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fe64: aa1403e0     	mov	x0, x20
  27fe68: aa1503e1     	mov	x1, x21
  27fe6c: d63f0100     	blr	x8
  27fe70: f900b660     	str	x0, [x19, #0x168]
  27fe74: f9400288     	ldr	x8, [x20]
  27fe78: d00018f6     	adrp	x22, 0x59d000 <__cxa_demangle+0x182b4>
  27fe7c: b00019e2     	adrp	x2, 0x5bc000
  27fe80: 91142ed6     	add	x22, x22, #0x50b
  27fe84: f9408508     	ldr	x8, [x8, #0x108]
  27fe88: 913ac042     	add	x2, x2, #0xeb0
  27fe8c: aa1403e0     	mov	x0, x20
  27fe90: aa1503e1     	mov	x1, x21
  27fe94: aa1603e3     	mov	x3, x22
  27fe98: d63f0100     	blr	x8

## 27feb0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fe90: aa1503e1     	mov	x1, x21
  27fe94: aa1603e3     	mov	x3, x22
  27fe98: d63f0100     	blr	x8
  27fe9c: f900a260     	str	x0, [x19, #0x140]
  27fea0: f9400288     	ldr	x8, [x20]
  27fea4: b0001962     	adrp	x2, 0x5ac000
  27fea8: 91239442     	add	x2, x2, #0x8e5
  27feac: aa1403e0     	mov	x0, x20
  27feb0: f9408508     	ldr	x8, [x8, #0x108]
  27feb4: aa1503e1     	mov	x1, x21
  27feb8: aa1603e3     	mov	x3, x22
  27febc: d63f0100     	blr	x8
  27fec0: f900a660     	str	x0, [x19, #0x148]
  27fec4: f9400288     	ldr	x8, [x20]

## 27fed4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27feb4: aa1503e1     	mov	x1, x21
  27feb8: aa1603e3     	mov	x3, x22
  27febc: d63f0100     	blr	x8
  27fec0: f900a660     	str	x0, [x19, #0x148]
  27fec4: f9400288     	ldr	x8, [x20]
  27fec8: b00019c2     	adrp	x2, 0x5b8000
  27fecc: 91146042     	add	x2, x2, #0x518
  27fed0: aa1403e0     	mov	x0, x20
  27fed4: f9408508     	ldr	x8, [x8, #0x108]
  27fed8: aa1503e1     	mov	x1, x21
  27fedc: aa1603e3     	mov	x3, x22
  27fee0: d63f0100     	blr	x8
  27fee4: f900aa60     	str	x0, [x19, #0x150]
  27fee8: f9400288     	ldr	x8, [x20]

## 27fef8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fed8: aa1503e1     	mov	x1, x21
  27fedc: aa1603e3     	mov	x3, x22
  27fee0: d63f0100     	blr	x8
  27fee4: f900aa60     	str	x0, [x19, #0x150]
  27fee8: f9400288     	ldr	x8, [x20]
  27feec: b00019c2     	adrp	x2, 0x5b8000
  27fef0: 9111a042     	add	x2, x2, #0x468
  27fef4: aa1403e0     	mov	x0, x20
  27fef8: f9408508     	ldr	x8, [x8, #0x108]
  27fefc: aa1503e1     	mov	x1, x21
  27ff00: aa1603e3     	mov	x3, x22
  27ff04: d63f0100     	blr	x8
  27ff08: f900ae60     	str	x0, [x19, #0x158]
  27ff0c: f9400288     	ldr	x8, [x20]

## 27ff1c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27fefc: aa1503e1     	mov	x1, x21
  27ff00: aa1603e3     	mov	x3, x22
  27ff04: d63f0100     	blr	x8
  27ff08: f900ae60     	str	x0, [x19, #0x158]
  27ff0c: f9400288     	ldr	x8, [x20]
  27ff10: d00018f7     	adrp	x23, 0x59d000 <__cxa_demangle+0x182b4>
  27ff14: b00019e2     	adrp	x2, 0x5bc000
  27ff18: 911746f7     	add	x23, x23, #0x5d1
  27ff1c: f9408508     	ldr	x8, [x8, #0x108]
  27ff20: 913ad442     	add	x2, x2, #0xeb5
  27ff24: aa1403e0     	mov	x0, x20
  27ff28: aa1503e1     	mov	x1, x21
  27ff2c: aa1703e3     	mov	x3, x23
  27ff30: d63f0100     	blr	x8

## 27ff48 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27ff28: aa1503e1     	mov	x1, x21
  27ff2c: aa1703e3     	mov	x3, x23
  27ff30: d63f0100     	blr	x8
  27ff34: f900ba60     	str	x0, [x19, #0x170]
  27ff38: f9400288     	ldr	x8, [x20]
  27ff3c: b00019e2     	adrp	x2, 0x5bc000
  27ff40: 913b0842     	add	x2, x2, #0xec2
  27ff44: aa1403e0     	mov	x0, x20
  27ff48: f9408508     	ldr	x8, [x8, #0x108]
  27ff4c: aa1503e1     	mov	x1, x21
  27ff50: aa1703e3     	mov	x3, x23
  27ff54: d63f0100     	blr	x8
  27ff58: f900be60     	str	x0, [x19, #0x178]
  27ff5c: f9400288     	ldr	x8, [x20]

## 27ff6c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27ff4c: aa1503e1     	mov	x1, x21
  27ff50: aa1703e3     	mov	x3, x23
  27ff54: d63f0100     	blr	x8
  27ff58: f900be60     	str	x0, [x19, #0x178]
  27ff5c: f9400288     	ldr	x8, [x20]
  27ff60: b00019e2     	adrp	x2, 0x5bc000
  27ff64: b00019e3     	adrp	x3, 0x5bc000
  27ff68: 913b6842     	add	x2, x2, #0xeda
  27ff6c: f9408508     	ldr	x8, [x8, #0x108]
  27ff70: 913b8063     	add	x3, x3, #0xee0
  27ff74: aa1403e0     	mov	x0, x20
  27ff78: aa1503e1     	mov	x1, x21
  27ff7c: d63f0100     	blr	x8
  27ff80: f9009e60     	str	x0, [x19, #0x138]

## 27ff94 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
Basis: no target-vtable provenance established
ASM:
  27ff74: aa1403e0     	mov	x0, x20
  27ff78: aa1503e1     	mov	x1, x21
  27ff7c: d63f0100     	blr	x8
  27ff80: f9009e60     	str	x0, [x19, #0x138]
  27ff84: f9400288     	ldr	x8, [x20]
  27ff88: d0001942     	adrp	x2, 0x5a9000
  27ff8c: 91166042     	add	x2, x2, #0x598
  27ff90: aa1403e0     	mov	x0, x20
  27ff94: f9408508     	ldr	x8, [x8, #0x108]
  27ff98: aa1503e1     	mov	x1, x21
  27ff9c: aa1603e3     	mov	x3, x22
  27ffa0: d63f0100     	blr	x8
  27ffa4: 2a1f03f4     	mov	w20, wzr
  27ffa8: f900b260     	str	x0, [x19, #0x160]

## 284f54 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  284f34: f9405d08     	ldr	x8, [x8, #0xb8]
  284f38: d63f0100     	blr	x8
  284f3c: f94382c1     	ldr	x1, [x22, #0x700]
  284f40: b4000921     	cbz	x1, 0x285064 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl+0x1c0>
  284f44: f9400268     	ldr	x8, [x19]
  284f48: b00018d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  284f4c: b00018c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  284f50: 91142e94     	add	x20, x20, #0x50b
  284f54: f9408508     	ldr	x8, [x8, #0x108]
  284f58: 91141042     	add	x2, x2, #0x504
  284f5c: aa1303e0     	mov	x0, x19
  284f60: aa1403e3     	mov	x3, x20
  284f64: d63f0100     	blr	x8
  284f68: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 284f80 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  284f60: aa1403e3     	mov	x3, x20
  284f64: d63f0100     	blr	x8
  284f68: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  284f6c: f9038d00     	str	x0, [x8, #0x718]
  284f70: f9400268     	ldr	x8, [x19]
  284f74: f94382c1     	ldr	x1, [x22, #0x700]
  284f78: b00019c2     	adrp	x2, 0x5bd000
  284f7c: b00019c3     	adrp	x3, 0x5bd000
  284f80: f9408508     	ldr	x8, [x8, #0x108]
  284f84: 9115b042     	add	x2, x2, #0x56c
  284f88: 9115e863     	add	x3, x3, #0x57a
  284f8c: aa1303e0     	mov	x0, x19
  284f90: d63f0100     	blr	x8
  284f94: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 284fac — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  284f8c: aa1303e0     	mov	x0, x19
  284f90: d63f0100     	blr	x8
  284f94: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  284f98: f9039100     	str	x0, [x8, #0x720]
  284f9c: f9400268     	ldr	x8, [x19]
  284fa0: f94382c1     	ldr	x1, [x22, #0x700]
  284fa4: b00019c2     	adrp	x2, 0x5bd000
  284fa8: 91165442     	add	x2, x2, #0x595
  284fac: f9408508     	ldr	x8, [x8, #0x108]
  284fb0: aa1303e0     	mov	x0, x19
  284fb4: aa1403e3     	mov	x3, x20
  284fb8: d63f0100     	blr	x8
  284fbc: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  284fc0: f9038500     	str	x0, [x8, #0x708]

## 284fd4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  284fb4: aa1403e3     	mov	x3, x20
  284fb8: d63f0100     	blr	x8
  284fbc: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  284fc0: f9038500     	str	x0, [x8, #0x708]
  284fc4: f9400268     	ldr	x8, [x19]
  284fc8: f94382c1     	ldr	x1, [x22, #0x700]
  284fcc: b00019c2     	adrp	x2, 0x5bd000
  284fd0: d00018c3     	adrp	x3, 0x59e000
  284fd4: f9408508     	ldr	x8, [x8, #0x108]
  284fd8: 91169042     	add	x2, x2, #0x5a4
  284fdc: 9127a863     	add	x3, x3, #0x9ea
  284fe0: aa1303e0     	mov	x0, x19
  284fe4: d63f0100     	blr	x8
  284fe8: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 285000 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  284fe0: aa1303e0     	mov	x0, x19
  284fe4: d63f0100     	blr	x8
  284fe8: d0002628     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  284fec: f9038900     	str	x0, [x8, #0x710]
  284ff0: f9400268     	ldr	x8, [x19]
  284ff4: f94382c1     	ldr	x1, [x22, #0x700]
  284ff8: b00019c2     	adrp	x2, 0x5bd000
  284ffc: 9116dc42     	add	x2, x2, #0x5b7
  285000: f9408508     	ldr	x8, [x8, #0x108]
  285004: aa1303e0     	mov	x0, x19
  285008: aa1403e3     	mov	x3, x20
  28500c: d63f0100     	blr	x8
  285010: d00024c8     	adrp	x8, 0x71f000 <_ZTIN6Cicada12avAESEncryptE+0x340>
  285014: 911ca108     	add	x8, x8, #0x728

## 2872a0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl
Basis: object-vptr load found but constructor provenance is not established
ASM:
  287280: 36000189     	tbz	w9, #0x0, 0x2872b0 <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl+0x240c>
  287284: 9106c261     	add	x1, x19, #0x1b0
  287288: 910003e0     	mov	x0, sp
  28728c: 089ffd1f     	stlrb	wzr, [x8]
  287290: 97ffee0e     	bl	0x282ac8 <_ZN6Cicada12ICodecPlugin12setCodecNameERKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE+0x35b0>
  287294: f9400268     	ldr	x8, [x19]
  287298: 910003e1     	mov	x1, sp
  28729c: aa1303e0     	mov	x0, x19
  2872a0: f9408508     	ldr	x8, [x8, #0x108]
  2872a4: d63f0100     	blr	x8
  2872a8: 910003e0     	mov	x0, sp
  2872ac: 97fdfddf     	bl	0x206a28 <_ZN6Cicada21CicadaPlayerPrototype6createEPKNS_7optionsE+0x2d3c>
  2872b0: 3946aa68     	ldrb	w8, [x19, #0x1aa]
  2872b4: 340000c8     	cbz	w8, 0x2872cc <_ZN6Cicada19jniOnFrameAvailableEP7_JNIEnvP7_jclassl+0x2428>

## 292e58 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  292e38: aa1303e0     	mov	x0, x19
  292e3c: f9405508     	ldr	x8, [x8, #0xa8]
  292e40: d63f0100     	blr	x8
  292e44: f90646a0     	str	x0, [x21, #0xc88]
  292e48: f9400268     	ldr	x8, [x19]
  292e4c: f0001842     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  292e50: d0001863     	adrp	x3, 0x5a0000
  292e54: aa0003e1     	mov	x1, x0
  292e58: f9408508     	ldr	x8, [x8, #0x108]
  292e5c: 91141042     	add	x2, x2, #0x504
  292e60: 910bc463     	add	x3, x3, #0x2f1
  292e64: aa1303e0     	mov	x0, x19
  292e68: d63f0100     	blr	x8
  292e6c: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 292e84 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  292e64: aa1303e0     	mov	x0, x19
  292e68: d63f0100     	blr	x8
  292e6c: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  292e70: f9064900     	str	x0, [x8, #0xc90]
  292e74: f9400268     	ldr	x8, [x19]
  292e78: f94646a1     	ldr	x1, [x21, #0xc88]
  292e7c: 90001962     	adrp	x2, 0x5be000
  292e80: 90001963     	adrp	x3, 0x5be000
  292e84: f9408508     	ldr	x8, [x8, #0x108]
  292e88: 9128d042     	add	x2, x2, #0xa34
  292e8c: 91290c63     	add	x3, x3, #0xa43
  292e90: aa1303e0     	mov	x0, x19
  292e94: d63f0100     	blr	x8
  292e98: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 292eb0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  292e90: aa1303e0     	mov	x0, x19
  292e94: d63f0100     	blr	x8
  292e98: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  292e9c: f9065100     	str	x0, [x8, #0xca0]
  292ea0: f9400268     	ldr	x8, [x19]
  292ea4: f94646a1     	ldr	x1, [x21, #0xc88]
  292ea8: 90001962     	adrp	x2, 0x5be000
  292eac: f0001843     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  292eb0: f9408508     	ldr	x8, [x8, #0x108]
  292eb4: 912a3c42     	add	x2, x2, #0xa8f
  292eb8: 91142c63     	add	x3, x3, #0x50b
  292ebc: aa1303e0     	mov	x0, x19
  292ec0: d63f0100     	blr	x8
  292ec4: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 292edc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  292ebc: aa1303e0     	mov	x0, x19
  292ec0: d63f0100     	blr	x8
  292ec4: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  292ec8: f9064d00     	str	x0, [x8, #0xc98]
  292ecc: f9400268     	ldr	x8, [x19]
  292ed0: f94646a1     	ldr	x1, [x21, #0xc88]
  292ed4: 90001962     	adrp	x2, 0x5be000
  292ed8: b0001863     	adrp	x3, 0x59f000
  292edc: f9408508     	ldr	x8, [x8, #0x108]
  292ee0: 912a7842     	add	x2, x2, #0xa9e
  292ee4: 911a3463     	add	x3, x3, #0x68d
  292ee8: aa1303e0     	mov	x0, x19
  292eec: d63f0100     	blr	x8
  292ef0: 900025c8     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>

## 2b14cc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8AfString10trimStringERNSt6__ndk112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2b14ac: aa1303e0     	mov	x0, x19
  2b14b0: f9405508     	ldr	x8, [x8, #0xa8]
  2b14b4: d63f0100     	blr	x8
  2b14b8: f9037ac0     	str	x0, [x22, #0x6f0]
  2b14bc: f9400268     	ldr	x8, [x19]
  2b14c0: 90001762     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2b14c4: 90001763     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2b14c8: aa0003e1     	mov	x1, x0
  2b14cc: f9408508     	ldr	x8, [x8, #0x108]
  2b14d0: 91141042     	add	x2, x2, #0x504
  2b14d4: 91142c63     	add	x3, x3, #0x50b
  2b14d8: aa1303e0     	mov	x0, x19
  2b14dc: d63f0100     	blr	x8
  2b14e0: d00024c8     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 2c23a8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c2388: aa1303e0     	mov	x0, x19
  2c238c: f9405508     	ldr	x8, [x8, #0xa8]
  2c2390: d63f0100     	blr	x8
  2c2394: f9059ac0     	str	x0, [x22, #0xb30]
  2c2398: f9400268     	ldr	x8, [x19]
  2c239c: f00016d4     	adrp	x20, 0x59d000 <__cxa_demangle+0x182b4>
  2c23a0: f00016c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2c23a4: 91142e94     	add	x20, x20, #0x50b
  2c23a8: f9408508     	ldr	x8, [x8, #0x108]
  2c23ac: aa0003e1     	mov	x1, x0
  2c23b0: 91141042     	add	x2, x2, #0x504
  2c23b4: aa1303e0     	mov	x0, x19
  2c23b8: aa1403e3     	mov	x3, x20
  2c23bc: d63f0100     	blr	x8

## 2c23d8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c23b8: aa1403e3     	mov	x3, x20
  2c23bc: d63f0100     	blr	x8
  2c23c0: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c23c4: f9059d00     	str	x0, [x8, #0xb38]
  2c23c8: f9400268     	ldr	x8, [x19]
  2c23cc: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c23d0: f00016c2     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2c23d4: f00016c3     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2c23d8: f9408508     	ldr	x8, [x8, #0x108]
  2c23dc: 91156842     	add	x2, x2, #0x55a
  2c23e0: 91158463     	add	x3, x3, #0x561
  2c23e4: aa1303e0     	mov	x0, x19
  2c23e8: d63f0100     	blr	x8
  2c23ec: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 2c2404 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c23e4: aa1303e0     	mov	x0, x19
  2c23e8: d63f0100     	blr	x8
  2c23ec: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c23f0: f905a100     	str	x0, [x8, #0xb40]
  2c23f4: f9400268     	ldr	x8, [x19]
  2c23f8: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c23fc: f00017e2     	adrp	x2, 0x5c1000
  2c2400: f00017e3     	adrp	x3, 0x5c1000
  2c2404: f9408508     	ldr	x8, [x8, #0x108]
  2c2408: 913ba042     	add	x2, x2, #0xee8
  2c240c: 913bb463     	add	x3, x3, #0xeed
  2c2410: aa1303e0     	mov	x0, x19
  2c2414: d63f0100     	blr	x8
  2c2418: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 2c2430 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c2410: aa1303e0     	mov	x0, x19
  2c2414: d63f0100     	blr	x8
  2c2418: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c241c: f905a500     	str	x0, [x8, #0xb48]
  2c2420: f9400268     	ldr	x8, [x19]
  2c2424: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2428: f00017e2     	adrp	x2, 0x5c1000
  2c242c: f00016e3     	adrp	x3, 0x5a1000
  2c2430: f9408508     	ldr	x8, [x8, #0x108]
  2c2434: 913bc842     	add	x2, x2, #0xef2
  2c2438: 911a6063     	add	x3, x3, #0x698
  2c243c: aa1303e0     	mov	x0, x19
  2c2440: d63f0100     	blr	x8
  2c2444: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 2c245c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c243c: aa1303e0     	mov	x0, x19
  2c2440: d63f0100     	blr	x8
  2c2444: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c2448: f905ad00     	str	x0, [x8, #0xb58]
  2c244c: f9400268     	ldr	x8, [x19]
  2c2450: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2454: d0001702     	adrp	x2, 0x5a4000
  2c2458: f00016e3     	adrp	x3, 0x5a1000
  2c245c: f9408508     	ldr	x8, [x8, #0x108]
  2c2460: 913dac42     	add	x2, x2, #0xf6b
  2c2464: 911a9063     	add	x3, x3, #0x6a4
  2c2468: aa1303e0     	mov	x0, x19
  2c246c: d63f0100     	blr	x8
  2c2470: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>

## 2c2488 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN8FileCntl15openFileForReadEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2c2468: aa1303e0     	mov	x0, x19
  2c246c: d63f0100     	blr	x8
  2c2470: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c2474: f905b100     	str	x0, [x8, #0xb60]
  2c2478: f9400268     	ldr	x8, [x19]
  2c247c: f9459ac1     	ldr	x1, [x22, #0xb30]
  2c2480: d00017a2     	adrp	x2, 0x5b8000
  2c2484: 91117042     	add	x2, x2, #0x45c
  2c2488: f9408508     	ldr	x8, [x8, #0x108]
  2c248c: aa1303e0     	mov	x0, x19
  2c2490: aa1403e3     	mov	x3, x20
  2c2494: d63f0100     	blr	x8
  2c2498: b0002448     	adrp	x8, 0x74b000 <_ZN19dataSourcePrototype9_nextSlotE+0x98>
  2c249c: f905a900     	str	x0, [x8, #0xb50]

## 2fbad4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: no target-vtable provenance established
ASM:
  2fbab4: 910163e0     	add	x0, sp, #0x58
  2fbab8: aa1403e1     	mov	x1, x20
  2fbabc: f81b83a8     	stur	x8, [x29, #-0x48]
  2fbac0: 97fffe35     	bl	0x2fb394 <_ZN12JniException14clearExceptionEP7_JNIEnv+0x4c>
  2fbac4: f9400288     	ldr	x8, [x20]
  2fbac8: f94033f6     	ldr	x22, [sp, #0x60]
  2fbacc: d0001502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2fbad0: d0001503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2fbad4: f9408508     	ldr	x8, [x8, #0x108]
  2fbad8: 91141042     	add	x2, x2, #0x504
  2fbadc: 91142c63     	add	x3, x3, #0x50b
  2fbae0: aa1403e0     	mov	x0, x20
  2fbae4: aa1603e1     	mov	x1, x22
  2fbae8: d63f0100     	blr	x8

## 2fbafc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: no target-vtable provenance established
ASM:
  2fbadc: 91142c63     	add	x3, x3, #0x50b
  2fbae0: aa1403e0     	mov	x0, x20
  2fbae4: aa1603e1     	mov	x1, x22
  2fbae8: d63f0100     	blr	x8
  2fbaec: f9400288     	ldr	x8, [x20]
  2fbaf0: 90001522     	adrp	x2, 0x59f000
  2fbaf4: 90001523     	adrp	x3, 0x59f000
  2fbaf8: aa0003f7     	mov	x23, x0
  2fbafc: f9408508     	ldr	x8, [x8, #0x108]
  2fbb00: 911b7c42     	add	x2, x2, #0x6df
  2fbb04: 911b8c63     	add	x3, x3, #0x6e3
  2fbb08: aa1403e0     	mov	x0, x20
  2fbb0c: aa1603e1     	mov	x1, x22
  2fbb10: d63f0100     	blr	x8

## 2fbe5c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2fbe3c: aa1303e0     	mov	x0, x19
  2fbe40: f9405508     	ldr	x8, [x8, #0xa8]
  2fbe44: d63f0100     	blr	x8
  2fbe48: f904bea0     	str	x0, [x21, #0x978]
  2fbe4c: f9400268     	ldr	x8, [x19]
  2fbe50: d0001502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2fbe54: d0001503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2fbe58: aa0003e1     	mov	x1, x0
  2fbe5c: f9408508     	ldr	x8, [x8, #0x108]
  2fbe60: 91141042     	add	x2, x2, #0x504
  2fbe64: 91142c63     	add	x3, x3, #0x50b
  2fbe68: aa1303e0     	mov	x0, x19
  2fbe6c: d63f0100     	blr	x8
  2fbe70: d0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>

## 2fbe88 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2fbe68: aa1303e0     	mov	x0, x19
  2fbe6c: d63f0100     	blr	x8
  2fbe70: d0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>
  2fbe74: f904c100     	str	x0, [x8, #0x980]
  2fbe78: f9400268     	ldr	x8, [x19]
  2fbe7c: f944bea1     	ldr	x1, [x21, #0x978]
  2fbe80: 90001522     	adrp	x2, 0x59f000
  2fbe84: 90001523     	adrp	x3, 0x59f000
  2fbe88: f9408508     	ldr	x8, [x8, #0x108]
  2fbe8c: 911b1442     	add	x2, x2, #0x6c5
  2fbe90: 911b2463     	add	x3, x3, #0x6c9
  2fbe94: aa1303e0     	mov	x0, x19
  2fbe98: d63f0100     	blr	x8
  2fbe9c: d0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>

## 2fbfdc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2fbfbc: aa1303e0     	mov	x0, x19
  2fbfc0: f9405508     	ldr	x8, [x8, #0xa8]
  2fbfc4: d63f0100     	blr	x8
  2fbfc8: f904caa0     	str	x0, [x21, #0x990]
  2fbfcc: f9400268     	ldr	x8, [x19]
  2fbfd0: d0001502     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  2fbfd4: d0001503     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  2fbfd8: aa0003e1     	mov	x1, x0
  2fbfdc: f9408508     	ldr	x8, [x8, #0x108]
  2fbfe0: 91141042     	add	x2, x2, #0x504
  2fbfe4: 91142c63     	add	x3, x3, #0x50b
  2fbfe8: aa1303e0     	mov	x0, x19
  2fbfec: d63f0100     	blr	x8
  2fbff0: d0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>

## 2fc008 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN17GetStringUTFChars8getCharsEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  2fbfe8: aa1303e0     	mov	x0, x19
  2fbfec: d63f0100     	blr	x8
  2fbff0: d0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>
  2fbff4: f904cd00     	str	x0, [x8, #0x998]
  2fbff8: f9400268     	ldr	x8, [x19]
  2fbffc: f944caa1     	ldr	x1, [x21, #0x990]
  2fc000: f0001502     	adrp	x2, 0x59f000
  2fc004: f0001503     	adrp	x3, 0x59f000
  2fc008: f9408508     	ldr	x8, [x8, #0x108]
  2fc00c: 911b7c42     	add	x2, x2, #0x6df
  2fc010: 911b8c63     	add	x3, x3, #0x6e3
  2fc014: aa1303e0     	mov	x0, x19
  2fc018: d63f0100     	blr	x8
  2fc01c: b0002288     	adrp	x8, 0x74d000 <_ZN19dataSourcePrototype9_nextSlotE+0x2098>

## 33a4f0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33a4d0: aa0003e2     	mov	x2, x0
  33a4d4: aa1303e0     	mov	x0, x19
  33a4d8: aa1403e1     	mov	x1, x20
  33a4dc: 97f6fb31     	bl	0xf91a0 <JNI_OnUnload+0x83c>
  33a4e0: f9400268     	ldr	x8, [x19]
  33a4e4: f0001462     	adrp	x2, 0x5c9000
  33a4e8: f0001463     	adrp	x3, 0x5c9000
  33a4ec: aa0003f5     	mov	x21, x0
  33a4f0: f9408508     	ldr	x8, [x8, #0x108]
  33a4f4: 91004c42     	add	x2, x2, #0x13
  33a4f8: 91008863     	add	x3, x3, #0x22
  33a4fc: aa1303e0     	mov	x0, x19
  33a500: aa1403e1     	mov	x1, x20
  33a504: d63f0100     	blr	x8

## 33b0a4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33b084: 9100f821     	add	x1, x1, #0x3e
  33b088: aa0003f4     	mov	x20, x0
  33b08c: f9401908     	ldr	x8, [x8, #0x30]
  33b090: d63f0100     	blr	x8
  33b094: f9400288     	ldr	x8, [x20]
  33b098: aa0003f6     	mov	x22, x0
  33b09c: d0001462     	adrp	x2, 0x5c9000
  33b0a0: d0001463     	adrp	x3, 0x5c9000
  33b0a4: f9408508     	ldr	x8, [x8, #0x108]
  33b0a8: 91026442     	add	x2, x2, #0x99
  33b0ac: 91029463     	add	x3, x3, #0xa5
  33b0b0: aa1403e0     	mov	x0, x20
  33b0b4: aa1603e1     	mov	x1, x22
  33b0b8: d63f0100     	blr	x8

## 33b0f8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33b0d8: 9102d821     	add	x1, x1, #0xb6
  33b0dc: f9401908     	ldr	x8, [x8, #0x30]
  33b0e0: aa1403e0     	mov	x0, x20
  33b0e4: d63f0100     	blr	x8
  33b0e8: f9400288     	ldr	x8, [x20]
  33b0ec: aa0003f7     	mov	x23, x0
  33b0f0: d0001462     	adrp	x2, 0x5c9000
  33b0f4: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33b0f8: f9408508     	ldr	x8, [x8, #0x108]
  33b0fc: 91030c42     	add	x2, x2, #0xc3
  33b100: 910fcc63     	add	x3, x3, #0x3f3
  33b104: aa1403e0     	mov	x0, x20
  33b108: aa1703e1     	mov	x1, x23
  33b10c: d63f0100     	blr	x8

## 33b24c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b22c: 9100f821     	add	x1, x1, #0x3e
  33b230: aa1303e0     	mov	x0, x19
  33b234: f9401908     	ldr	x8, [x8, #0x30]
  33b238: d63f0100     	blr	x8
  33b23c: f9400268     	ldr	x8, [x19]
  33b240: aa0003f7     	mov	x23, x0
  33b244: d0001462     	adrp	x2, 0x5c9000
  33b248: d0001463     	adrp	x3, 0x5c9000
  33b24c: f9408508     	ldr	x8, [x8, #0x108]
  33b250: 910b7042     	add	x2, x2, #0x2dc
  33b254: 910b9863     	add	x3, x3, #0x2e6
  33b258: aa1303e0     	mov	x0, x19
  33b25c: aa1703e1     	mov	x1, x23
  33b260: d63f0100     	blr	x8

## 33b584 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b564: 9100f821     	add	x1, x1, #0x3e
  33b568: aa0003f3     	mov	x19, x0
  33b56c: f9401908     	ldr	x8, [x8, #0x30]
  33b570: d63f0100     	blr	x8
  33b574: f9400268     	ldr	x8, [x19]
  33b578: aa0003f5     	mov	x21, x0
  33b57c: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33b580: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33b584: f9408508     	ldr	x8, [x8, #0x108]
  33b588: 910eb042     	add	x2, x2, #0x3ac
  33b58c: 910ef863     	add	x3, x3, #0x3be
  33b590: aa1303e0     	mov	x0, x19
  33b594: aa1503e1     	mov	x1, x21
  33b598: d63f0100     	blr	x8

## 33b5bc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b59c: aa0003e2     	mov	x2, x0
  33b5a0: aa1303e0     	mov	x0, x19
  33b5a4: aa1403e1     	mov	x1, x20
  33b5a8: 97f6f6d7     	bl	0xf9104 <JNI_OnUnload+0x7a0>
  33b5ac: f9400268     	ldr	x8, [x19]
  33b5b0: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33b5b4: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33b5b8: aa0003f6     	mov	x22, x0
  33b5bc: f9408508     	ldr	x8, [x8, #0x108]
  33b5c0: 910f9042     	add	x2, x2, #0x3e4
  33b5c4: 910fcc63     	add	x3, x3, #0x3f3
  33b5c8: aa1303e0     	mov	x0, x19
  33b5cc: aa1503e1     	mov	x1, x21
  33b5d0: d63f0100     	blr	x8

## 33b624 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b604: 91015821     	add	x1, x1, #0x56
  33b608: aa1303e0     	mov	x0, x19
  33b60c: f9401908     	ldr	x8, [x8, #0x30]
  33b610: d63f0100     	blr	x8
  33b614: f9400268     	ldr	x8, [x19]
  33b618: aa0003f5     	mov	x21, x0
  33b61c: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33b620: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33b624: f9408508     	ldr	x8, [x8, #0x108]
  33b628: 91102042     	add	x2, x2, #0x408
  33b62c: 91105c63     	add	x3, x3, #0x417
  33b630: aa1303e0     	mov	x0, x19
  33b634: aa1503e1     	mov	x1, x21
  33b638: d63f0100     	blr	x8

## 33b980 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b960: aa0003e2     	mov	x2, x0
  33b964: aa1303e0     	mov	x0, x19
  33b968: aa1503e1     	mov	x1, x21
  33b96c: 97f6f60d     	bl	0xf91a0 <JNI_OnUnload+0x83c>
  33b970: f9400268     	ldr	x8, [x19]
  33b974: d0001462     	adrp	x2, 0x5c9000
  33b978: d0001463     	adrp	x3, 0x5c9000
  33b97c: aa0003f6     	mov	x22, x0
  33b980: f9408508     	ldr	x8, [x8, #0x108]
  33b984: 91004c42     	add	x2, x2, #0x13
  33b988: 91008863     	add	x3, x3, #0x22
  33b98c: aa1303e0     	mov	x0, x19
  33b990: aa1503e1     	mov	x1, x21
  33b994: d63f0100     	blr	x8

## 33b9fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33b9dc: 9100f821     	add	x1, x1, #0x3e
  33b9e0: aa1303e0     	mov	x0, x19
  33b9e4: f9401908     	ldr	x8, [x8, #0x30]
  33b9e8: d63f0100     	blr	x8
  33b9ec: f9400268     	ldr	x8, [x19]
  33b9f0: aa0003f5     	mov	x21, x0
  33b9f4: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33b9f8: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33b9fc: f9408508     	ldr	x8, [x8, #0x108]
  33ba00: 910f9042     	add	x2, x2, #0x3e4
  33ba04: 910fcc63     	add	x3, x3, #0x3f3
  33ba08: aa1303e0     	mov	x0, x19
  33ba0c: aa1503e1     	mov	x1, x21
  33ba10: d63f0100     	blr	x8

## 33bafc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: object-vptr load found but constructor provenance is not established
ASM:
  33badc: aa0003e2     	mov	x2, x0
  33bae0: aa1303e0     	mov	x0, x19
  33bae4: aa1503e1     	mov	x1, x21
  33bae8: 97f6f5ae     	bl	0xf91a0 <JNI_OnUnload+0x83c>
  33baec: f9400268     	ldr	x8, [x19]
  33baf0: f0001342     	adrp	x2, 0x5a6000
  33baf4: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33baf8: aa0003f6     	mov	x22, x0
  33bafc: f9408508     	ldr	x8, [x8, #0x108]
  33bb00: 91129842     	add	x2, x2, #0x4a6
  33bb04: 910fcc63     	add	x3, x3, #0x3f3
  33bb08: aa1303e0     	mov	x0, x19
  33bb0c: aa1503e1     	mov	x1, x21
  33bb10: d63f0100     	blr	x8

## 33bbe0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33bbc0: aa0003f4     	mov	x20, x0
  33bbc4: aa0803f3     	mov	x19, x8
  33bbc8: f9401929     	ldr	x9, [x9, #0x30]
  33bbcc: d63f0120     	blr	x9
  33bbd0: f9400288     	ldr	x8, [x20]
  33bbd4: aa0003f5     	mov	x21, x0
  33bbd8: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33bbdc: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33bbe0: f9408508     	ldr	x8, [x8, #0x108]
  33bbe4: 910f9042     	add	x2, x2, #0x3e4
  33bbe8: 910fcc63     	add	x3, x3, #0x3f3
  33bbec: aa1403e0     	mov	x0, x20
  33bbf0: aa1503e1     	mov	x1, x21
  33bbf4: d63f0100     	blr	x8

## 33bc18 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33bbf8: aa0003e2     	mov	x2, x0
  33bbfc: aa1403e0     	mov	x0, x20
  33bc00: aa1703e1     	mov	x1, x23
  33bc04: 97f6f540     	bl	0xf9104 <JNI_OnUnload+0x7a0>
  33bc08: f9400288     	ldr	x8, [x20]
  33bc0c: d0001302     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  33bc10: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33bc14: aa0003f6     	mov	x22, x0
  33bc18: f9408508     	ldr	x8, [x8, #0x108]
  33bc1c: 910eb042     	add	x2, x2, #0x3ac
  33bc20: 910ef863     	add	x3, x3, #0x3be
  33bc24: aa1403e0     	mov	x0, x20
  33bc28: aa1503e1     	mov	x1, x21
  33bc2c: d63f0100     	blr	x8

## 33bcac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33bc8c: aa1403e0     	mov	x0, x20
  33bc90: aa1903e1     	mov	x1, x25
  33bc94: f9425908     	ldr	x8, [x8, #0x4b0]
  33bc98: d63f0100     	blr	x8
  33bc9c: f9400288     	ldr	x8, [x20]
  33bca0: d0001462     	adrp	x2, 0x5c9000
  33bca4: d0001463     	adrp	x3, 0x5c9000
  33bca8: 2a0003f7     	mov	w23, w0
  33bcac: f9408508     	ldr	x8, [x8, #0x108]
  33bcb0: 9103c842     	add	x2, x2, #0xf2
  33bcb4: 91041463     	add	x3, x3, #0x105
  33bcb8: aa1403e0     	mov	x0, x20
  33bcbc: aa1903e1     	mov	x1, x25
  33bcc0: d63f0100     	blr	x8

## 33be68 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase10build_info21GetAIOTargetShortNameEv
Basis: no target-vtable provenance established
ASM:
  33be48: aa1403e0     	mov	x0, x20
  33be4c: aa1503e1     	mov	x1, x21
  33be50: f9407d08     	ldr	x8, [x8, #0xf8]
  33be54: d63f0100     	blr	x8
  33be58: f9400288     	ldr	x8, [x20]
  33be5c: d0001462     	adrp	x2, 0x5c9000
  33be60: d0001303     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  33be64: aa0003e1     	mov	x1, x0
  33be68: f9408508     	ldr	x8, [x8, #0x108]
  33be6c: 91077c42     	add	x2, x2, #0x1df
  33be70: 913a3063     	add	x3, x3, #0xe8c
  33be74: aa1403e0     	mov	x0, x20
  33be78: f90013e1     	str	x1, [sp, #0x20]
  33be7c: d63f0100     	blr	x8

## 35ac8c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35ac6c: aa1303e0     	mov	x0, x19
  35ac70: 7200015f     	tst	w10, #0x1
  35ac74: 9a891561     	csinc	x1, x11, x9, ne
  35ac78: d63f0100     	blr	x8
  35ac7c: f9400268     	ldr	x8, [x19]
  35ac80: aa0003f5     	mov	x21, x0
  35ac84: f0001362     	adrp	x2, 0x5c9000
  35ac88: b0001223     	adrp	x3, 0x59f000
  35ac8c: f9408508     	ldr	x8, [x8, #0x108]
  35ac90: 911f6c42     	add	x2, x2, #0x7db
  35ac94: 91204463     	add	x3, x3, #0x811
  35ac98: aa1303e0     	mov	x0, x19
  35ac9c: aa1503e1     	mov	x1, x21
  35aca0: d63f0100     	blr	x8

## 35af60 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35af40: 7200015f     	tst	w10, #0x1
  35af44: 9a891561     	csinc	x1, x11, x9, ne
  35af48: aa1303e0     	mov	x0, x19
  35af4c: d63f0100     	blr	x8
  35af50: f9400268     	ldr	x8, [x19]
  35af54: aa0003f6     	mov	x22, x0
  35af58: f0001362     	adrp	x2, 0x5c9000
  35af5c: b0001223     	adrp	x3, 0x59f000
  35af60: f9408508     	ldr	x8, [x8, #0x108]
  35af64: 911fa842     	add	x2, x2, #0x7ea
  35af68: 91204463     	add	x3, x3, #0x811
  35af6c: aa1303e0     	mov	x0, x19
  35af70: aa1603e1     	mov	x1, x22
  35af74: d63f0100     	blr	x8

## 35b5c0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: no target-vtable provenance established
ASM:
  35b5a0: 94077925     	bl	0x539a34 <_ZN3mpf7CasBaseD2Ev+0x4715c>
  35b5a4: aa0003f6     	mov	x22, x0
  35b5a8: 910023e0     	add	x0, sp, #0x8
  35b5ac: 940777a2     	bl	0x539434 <_ZN3mpf7CasBaseD2Ev+0x46b5c>
  35b5b0: f9400008     	ldr	x8, [x0]
  35b5b4: d0001362     	adrp	x2, 0x5c9000
  35b5b8: 90001223     	adrp	x3, 0x59f000
  35b5bc: 911f6c42     	add	x2, x2, #0x7db
  35b5c0: f9408508     	ldr	x8, [x8, #0x108]
  35b5c4: 91204463     	add	x3, x3, #0x811
  35b5c8: aa1603e1     	mov	x1, x22
  35b5cc: d63f0100     	blr	x8
  35b5d0: aa0003f7     	mov	x23, x0
  35b5d4: 910023e0     	add	x0, sp, #0x8

## 35c0d4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: no target-vtable provenance established
ASM:
  35c0b4: aa0003e2     	mov	x2, x0
  35c0b8: aa1503e0     	mov	x0, x21
  35c0bc: aa1603e1     	mov	x1, x22
  35c0c0: 97f67438     	bl	0xf91a0 <JNI_OnUnload+0x83c>
  35c0c4: f94002a8     	ldr	x8, [x21]
  35c0c8: b0001362     	adrp	x2, 0x5c9000
  35c0cc: b0001363     	adrp	x3, 0x5c9000
  35c0d0: aa0003f7     	mov	x23, x0
  35c0d4: f9408508     	ldr	x8, [x8, #0x108]
  35c0d8: 91004c42     	add	x2, x2, #0x13
  35c0dc: 91008863     	add	x3, x3, #0x22
  35c0e0: aa1503e0     	mov	x0, x21
  35c0e4: aa1603e1     	mov	x1, x22
  35c0e8: d63f0100     	blr	x8

## 35c198 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35c178: 9100f821     	add	x1, x1, #0x3e
  35c17c: aa1303e0     	mov	x0, x19
  35c180: f9401908     	ldr	x8, [x8, #0x30]
  35c184: d63f0100     	blr	x8
  35c188: f9400268     	ldr	x8, [x19]
  35c18c: aa0003f5     	mov	x21, x0
  35c190: b0001202     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  35c194: b0001203     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  35c198: f9408508     	ldr	x8, [x8, #0x108]
  35c19c: 910f9042     	add	x2, x2, #0x3e4
  35c1a0: 910fcc63     	add	x3, x3, #0x3f3
  35c1a4: aa1303e0     	mov	x0, x19
  35c1a8: aa1503e1     	mov	x1, x21
  35c1ac: d63f0100     	blr	x8

## 35c1d0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35c1b0: aa0003e2     	mov	x2, x0
  35c1b4: aa1303e0     	mov	x0, x19
  35c1b8: aa1403e1     	mov	x1, x20
  35c1bc: 97f673d2     	bl	0xf9104 <JNI_OnUnload+0x7a0>
  35c1c0: f9400268     	ldr	x8, [x19]
  35c1c4: b0001202     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  35c1c8: b0001203     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  35c1cc: aa0003f7     	mov	x23, x0
  35c1d0: f9408508     	ldr	x8, [x8, #0x108]
  35c1d4: 910eb042     	add	x2, x2, #0x3ac
  35c1d8: 910ef863     	add	x3, x3, #0x3be
  35c1dc: aa1303e0     	mov	x0, x19
  35c1e0: aa1503e1     	mov	x1, x21
  35c1e4: d63f0100     	blr	x8

## 35c264 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35c244: aa1303e0     	mov	x0, x19
  35c248: aa1903e1     	mov	x1, x25
  35c24c: f9425908     	ldr	x8, [x8, #0x4b0]
  35c250: d63f0100     	blr	x8
  35c254: f9400268     	ldr	x8, [x19]
  35c258: b0001362     	adrp	x2, 0x5c9000
  35c25c: b0001363     	adrp	x3, 0x5c9000
  35c260: 2a0003f6     	mov	w22, w0
  35c264: f9408508     	ldr	x8, [x8, #0x108]
  35c268: 9103c842     	add	x2, x2, #0xf2
  35c26c: 91041463     	add	x3, x3, #0x105
  35c270: aa1303e0     	mov	x0, x19
  35c274: aa1903e1     	mov	x1, x25
  35c278: d63f0100     	blr	x8

## 35c408 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3rts6Base6415DecodeFromArrayEPKcmiPNSt6__ndk16vectorIhNS3_9allocatorIhEEEEPm
Basis: object-vptr load found but constructor provenance is not established
ASM:
  35c3e8: aa1303e0     	mov	x0, x19
  35c3ec: aa1403e1     	mov	x1, x20
  35c3f0: f9407d08     	ldr	x8, [x8, #0xf8]
  35c3f4: d63f0100     	blr	x8
  35c3f8: f9400268     	ldr	x8, [x19]
  35c3fc: aa0003f5     	mov	x21, x0
  35c400: b0001362     	adrp	x2, 0x5c9000
  35c404: b0001203     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  35c408: f9408508     	ldr	x8, [x8, #0x108]
  35c40c: 91077c42     	add	x2, x2, #0x1df
  35c410: 913a3063     	add	x3, x3, #0xe8c
  35c414: aa1303e0     	mov	x0, x19
  35c418: aa1503e1     	mov	x1, x21
  35c41c: d63f0100     	blr	x8

## 4bc83c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc81c: f9435d08     	ldr	x8, [x8, #0x6b8]
  4bc820: aa1403e1     	mov	x1, x20
  4bc824: d63f0100     	blr	x8
  4bc828: 37f80b60     	tbnz	w0, #0x1f, 0x4bc994 <_ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring+0x934>
  4bc82c: f94002a8     	ldr	x8, [x21]
  4bc830: b0000717     	adrp	x23, 0x59d000 <__cxa_demangle+0x182b4>
  4bc834: b0000702     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  4bc838: 91142ef7     	add	x23, x23, #0x50b
  4bc83c: f9408508     	ldr	x8, [x8, #0x108]
  4bc840: 91141042     	add	x2, x2, #0x504
  4bc844: aa1503e0     	mov	x0, x21
  4bc848: aa1403e1     	mov	x1, x20
  4bc84c: aa1703e3     	mov	x3, x23
  4bc850: d63f0100     	blr	x8

## 4bc890 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc870: aa1603e1     	mov	x1, x22
  4bc874: f9405508     	ldr	x8, [x8, #0xa8]
  4bc878: d63f0100     	blr	x8
  4bc87c: f9002660     	str	x0, [x19, #0x48]
  4bc880: f94002a8     	ldr	x8, [x21]
  4bc884: d0000922     	adrp	x2, 0x5e2000
  4bc888: d0000923     	adrp	x3, 0x5e2000
  4bc88c: 911dfc42     	add	x2, x2, #0x77f
  4bc890: f9408508     	ldr	x8, [x8, #0x108]
  4bc894: 911e2063     	add	x3, x3, #0x788
  4bc898: aa1503e0     	mov	x0, x21
  4bc89c: aa1403e1     	mov	x1, x20
  4bc8a0: d63f0100     	blr	x8
  4bc8a4: f9002a60     	str	x0, [x19, #0x50]

## 4bc8b8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc898: aa1503e0     	mov	x0, x21
  4bc89c: aa1403e1     	mov	x1, x20
  4bc8a0: d63f0100     	blr	x8
  4bc8a4: f9002a60     	str	x0, [x19, #0x50]
  4bc8a8: f94002a8     	ldr	x8, [x21]
  4bc8ac: d0000922     	adrp	x2, 0x5e2000
  4bc8b0: 911e9442     	add	x2, x2, #0x7a5
  4bc8b4: aa1503e0     	mov	x0, x21
  4bc8b8: f9408508     	ldr	x8, [x8, #0x108]
  4bc8bc: aa1403e1     	mov	x1, x20
  4bc8c0: aa1703e3     	mov	x3, x23
  4bc8c4: d63f0100     	blr	x8
  4bc8c8: f9002e60     	str	x0, [x19, #0x58]
  4bc8cc: f94002a8     	ldr	x8, [x21]

## 4bc8dc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc8bc: aa1403e1     	mov	x1, x20
  4bc8c0: aa1703e3     	mov	x3, x23
  4bc8c4: d63f0100     	blr	x8
  4bc8c8: f9002e60     	str	x0, [x19, #0x58]
  4bc8cc: f94002a8     	ldr	x8, [x21]
  4bc8d0: d0000922     	adrp	x2, 0x5e2000
  4bc8d4: 911ec042     	add	x2, x2, #0x7b0
  4bc8d8: aa1503e0     	mov	x0, x21
  4bc8dc: f9408508     	ldr	x8, [x8, #0x108]
  4bc8e0: aa1403e1     	mov	x1, x20
  4bc8e4: aa1703e3     	mov	x3, x23
  4bc8e8: d63f0100     	blr	x8
  4bc8ec: f9003260     	str	x0, [x19, #0x60]
  4bc8f0: f94002a8     	ldr	x8, [x21]

## 4bc900 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc8e0: aa1403e1     	mov	x1, x20
  4bc8e4: aa1703e3     	mov	x3, x23
  4bc8e8: d63f0100     	blr	x8
  4bc8ec: f9003260     	str	x0, [x19, #0x60]
  4bc8f0: f94002a8     	ldr	x8, [x21]
  4bc8f4: d0000922     	adrp	x2, 0x5e2000
  4bc8f8: 911edc42     	add	x2, x2, #0x7b7
  4bc8fc: aa1503e0     	mov	x0, x21
  4bc900: f9408508     	ldr	x8, [x8, #0x108]
  4bc904: aa1403e1     	mov	x1, x20
  4bc908: aa1703e3     	mov	x3, x23
  4bc90c: d63f0100     	blr	x8
  4bc910: f9003660     	str	x0, [x19, #0x68]
  4bc914: f94002a8     	ldr	x8, [x21]

## 4bc924 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN6avbase5crash26onLastCrashNativeTombstoneEP7_JNIEnvP8_jobjectP8_jstring
Basis: no target-vtable provenance established
ASM:
  4bc904: aa1403e1     	mov	x1, x20
  4bc908: aa1703e3     	mov	x3, x23
  4bc90c: d63f0100     	blr	x8
  4bc910: f9003660     	str	x0, [x19, #0x68]
  4bc914: f94002a8     	ldr	x8, [x21]
  4bc918: d0000922     	adrp	x2, 0x5e2000
  4bc91c: d0000923     	adrp	x3, 0x5e2000
  4bc920: 911f0042     	add	x2, x2, #0x7c0
  4bc924: f9408508     	ldr	x8, [x8, #0x108]
  4bc928: 911f3c63     	add	x3, x3, #0x7cf
  4bc92c: aa1503e0     	mov	x0, x21
  4bc930: aa1403e1     	mov	x1, x20
  4bc934: d63f0100     	blr	x8
  4bc938: f9003a60     	str	x0, [x19, #0x70]

## 515aec — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  515acc: 97ef0c25     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  515ad0: 34fff480     	cbz	w0, 0x515960 <_ZN3mpf7CasBaseD2Ev+0x23088>
  515ad4: 910063e0     	add	x0, sp, #0x18
  515ad8: 94008c79     	bl	0x538cbc <_ZN3mpf7CasBaseD2Ev+0x463e4>
  515adc: f9400008     	ldr	x8, [x0]
  515ae0: b0000482     	adrp	x2, 0x5a6000
  515ae4: 90000443     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  515ae8: 91129842     	add	x2, x2, #0x4a6
  515aec: f9408508     	ldr	x8, [x8, #0x108]
  515af0: 910fcc63     	add	x3, x3, #0x3f3
  515af4: aa1303e1     	mov	x1, x19
  515af8: d63f0100     	blr	x8
  515afc: f9000ae0     	str	x0, [x23, #0x10]
  515b00: 910062e0     	add	x0, x23, #0x18

## 535478 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535458: 9100f821     	add	x1, x1, #0x3e
  53545c: aa0003f4     	mov	x20, x0
  535460: f9401908     	ldr	x8, [x8, #0x30]
  535464: d63f0100     	blr	x8
  535468: f9400288     	ldr	x8, [x20]
  53546c: aa0003f5     	mov	x21, x0
  535470: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535474: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535478: f9408508     	ldr	x8, [x8, #0x108]
  53547c: 910f9042     	add	x2, x2, #0x3e4
  535480: 910fcc63     	add	x3, x3, #0x3f3
  535484: aa1403e0     	mov	x0, x20
  535488: aa1503e1     	mov	x1, x21
  53548c: d63f0100     	blr	x8

## 535800 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  5357e0: 9100f821     	add	x1, x1, #0x3e
  5357e4: aa0003f4     	mov	x20, x0
  5357e8: f9401908     	ldr	x8, [x8, #0x30]
  5357ec: d63f0100     	blr	x8
  5357f0: f9400288     	ldr	x8, [x20]
  5357f4: aa0003f6     	mov	x22, x0
  5357f8: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  5357fc: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535800: f9408508     	ldr	x8, [x8, #0x108]
  535804: 910eb042     	add	x2, x2, #0x3ac
  535808: 910ef863     	add	x3, x3, #0x3be
  53580c: aa1403e0     	mov	x0, x20
  535810: aa1603e1     	mov	x1, x22
  535814: d63f0100     	blr	x8

## 535828 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535808: 910ef863     	add	x3, x3, #0x3be
  53580c: aa1403e0     	mov	x0, x20
  535810: aa1603e1     	mov	x1, x22
  535814: d63f0100     	blr	x8
  535818: f9400288     	ldr	x8, [x20]
  53581c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535820: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535824: aa0003f7     	mov	x23, x0
  535828: f9408508     	ldr	x8, [x8, #0x108]
  53582c: 910f9042     	add	x2, x2, #0x3e4
  535830: 910fcc63     	add	x3, x3, #0x3f3
  535834: aa1403e0     	mov	x0, x20
  535838: aa1603e1     	mov	x1, x22
  53583c: d63f0100     	blr	x8

## 53587c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  53585c: aa1403e0     	mov	x0, x20
  535860: aa1703e1     	mov	x1, x23
  535864: f9407d08     	ldr	x8, [x8, #0xf8]
  535868: d63f0100     	blr	x8
  53586c: f9400288     	ldr	x8, [x20]
  535870: aa0003f9     	mov	x25, x0
  535874: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535878: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  53587c: f9408508     	ldr	x8, [x8, #0x108]
  535880: 91102042     	add	x2, x2, #0x408
  535884: 91105c63     	add	x3, x3, #0x417
  535888: aa1403e0     	mov	x0, x20
  53588c: aa1903e1     	mov	x1, x25
  535890: d63f0100     	blr	x8

## 535bf4 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535bd4: 9100f821     	add	x1, x1, #0x3e
  535bd8: aa0003f4     	mov	x20, x0
  535bdc: f9401908     	ldr	x8, [x8, #0x30]
  535be0: d63f0100     	blr	x8
  535be4: f9400288     	ldr	x8, [x20]
  535be8: aa0003f6     	mov	x22, x0
  535bec: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535bf0: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535bf4: f9408508     	ldr	x8, [x8, #0x108]
  535bf8: 910eb042     	add	x2, x2, #0x3ac
  535bfc: 910ef863     	add	x3, x3, #0x3be
  535c00: aa1403e0     	mov	x0, x20
  535c04: aa1603e1     	mov	x1, x22
  535c08: d63f0100     	blr	x8

## 535c44 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535c24: aa1403e0     	mov	x0, x20
  535c28: aa1803e1     	mov	x1, x24
  535c2c: f9407d08     	ldr	x8, [x8, #0xf8]
  535c30: d63f0100     	blr	x8
  535c34: f9400288     	ldr	x8, [x20]
  535c38: aa0003f9     	mov	x25, x0
  535c3c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535c40: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535c44: f9408508     	ldr	x8, [x8, #0x108]
  535c48: 91102042     	add	x2, x2, #0x408
  535c4c: 91105c63     	add	x3, x3, #0x417
  535c50: aa1403e0     	mov	x0, x20
  535c54: aa1903e1     	mov	x1, x25
  535c58: d63f0100     	blr	x8

## 535c6c — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535c4c: 91105c63     	add	x3, x3, #0x417
  535c50: aa1403e0     	mov	x0, x20
  535c54: aa1903e1     	mov	x1, x25
  535c58: d63f0100     	blr	x8
  535c5c: f9400288     	ldr	x8, [x20]
  535c60: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535c64: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535c68: aa0003f7     	mov	x23, x0
  535c6c: f9408508     	ldr	x8, [x8, #0x108]
  535c70: 910f9042     	add	x2, x2, #0x3e4
  535c74: 910fcc63     	add	x3, x3, #0x3f3
  535c78: aa1403e0     	mov	x0, x20
  535c7c: aa1603e1     	mov	x1, x22
  535c80: d63f0100     	blr	x8

## 535de0 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535dc0: aa1403e0     	mov	x0, x20
  535dc4: aa1b03e1     	mov	x1, x27
  535dc8: f9407d08     	ldr	x8, [x8, #0xf8]
  535dcc: d63f0100     	blr	x8
  535dd0: f9400288     	ldr	x8, [x20]
  535dd4: aa0003fc     	mov	x28, x0
  535dd8: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535ddc: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535de0: f9408508     	ldr	x8, [x8, #0x108]
  535de4: 9111e042     	add	x2, x2, #0x478
  535de8: 91121063     	add	x3, x3, #0x484
  535dec: aa1403e0     	mov	x0, x20
  535df0: aa1c03e1     	mov	x1, x28
  535df4: d63f0100     	blr	x8

## 535ea8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535e88: aa1403e0     	mov	x0, x20
  535e8c: aa1803e1     	mov	x1, x24
  535e90: f9405d08     	ldr	x8, [x8, #0xb8]
  535e94: d63f0100     	blr	x8
  535e98: f9400288     	ldr	x8, [x20]
  535e9c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535ea0: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535ea4: 9113a442     	add	x2, x2, #0x4e9
  535ea8: f9408508     	ldr	x8, [x8, #0x108]
  535eac: 9113c063     	add	x3, x3, #0x4f0
  535eb0: aa1403e0     	mov	x0, x20
  535eb4: aa1503e1     	mov	x1, x21
  535eb8: d63f0100     	blr	x8
  535ebc: aa0003e2     	mov	x2, x0

## 535f58 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  535f38: aa1403e0     	mov	x0, x20
  535f3c: aa1903e1     	mov	x1, x25
  535f40: f9405d08     	ldr	x8, [x8, #0xb8]
  535f44: d63f0100     	blr	x8
  535f48: f9400288     	ldr	x8, [x20]
  535f4c: 90000342     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  535f50: 90000343     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  535f54: 9113d842     	add	x2, x2, #0x4f6
  535f58: f9408508     	ldr	x8, [x8, #0x108]
  535f5c: aa1403e0     	mov	x0, x20
  535f60: aa1503e1     	mov	x1, x21
  535f64: 91121063     	add	x3, x3, #0x484
  535f68: d63f0100     	blr	x8
  535f6c: aa0003e2     	mov	x2, x0

## 536264 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536244: 9100f821     	add	x1, x1, #0x3e
  536248: aa0003f3     	mov	x19, x0
  53624c: f9401908     	ldr	x8, [x8, #0x30]
  536250: d63f0100     	blr	x8
  536254: f9400268     	ldr	x8, [x19]
  536258: aa0003f5     	mov	x21, x0
  53625c: f0000322     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  536260: f0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  536264: f9408508     	ldr	x8, [x8, #0x108]
  536268: 910eb042     	add	x2, x2, #0x3ac
  53626c: 910ef863     	add	x3, x3, #0x3be
  536270: aa1303e0     	mov	x0, x19
  536274: aa1503e1     	mov	x1, x21
  536278: d63f0100     	blr	x8

## 5362d4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5362b4: 91015821     	add	x1, x1, #0x56
  5362b8: f9401908     	ldr	x8, [x8, #0x30]
  5362bc: aa1303e0     	mov	x0, x19
  5362c0: d63f0100     	blr	x8
  5362c4: f9400268     	ldr	x8, [x19]
  5362c8: aa0003f6     	mov	x22, x0
  5362cc: f0000482     	adrp	x2, 0x5c9000
  5362d0: f0000483     	adrp	x3, 0x5c9000
  5362d4: f9408508     	ldr	x8, [x8, #0x108]
  5362d8: 9103c842     	add	x2, x2, #0xf2
  5362dc: 91041463     	add	x3, x3, #0x105
  5362e0: aa1303e0     	mov	x0, x19
  5362e4: aa1603e1     	mov	x1, x22
  5362e8: d63f0100     	blr	x8

## 5362fc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5362dc: 91041463     	add	x3, x3, #0x105
  5362e0: aa1303e0     	mov	x0, x19
  5362e4: aa1603e1     	mov	x1, x22
  5362e8: d63f0100     	blr	x8
  5362ec: f9400268     	ldr	x8, [x19]
  5362f0: f0000582     	adrp	x2, 0x5e9000
  5362f4: f0000583     	adrp	x3, 0x5e9000
  5362f8: aa0003fa     	mov	x26, x0
  5362fc: f9408508     	ldr	x8, [x8, #0x108]
  536300: 913d6842     	add	x2, x2, #0xf5a
  536304: 913db863     	add	x3, x3, #0xf6e
  536308: aa1303e0     	mov	x0, x19
  53630c: aa1603e1     	mov	x1, x22
  536310: d63f0100     	blr	x8

## 536340 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536320: 913eb421     	add	x1, x1, #0xfad
  536324: f9401908     	ldr	x8, [x8, #0x30]
  536328: aa1303e0     	mov	x0, x19
  53632c: d63f0100     	blr	x8
  536330: f9400268     	ldr	x8, [x19]
  536334: aa0003f7     	mov	x23, x0
  536338: 90000382     	adrp	x2, 0x5a6000
  53633c: 91129842     	add	x2, x2, #0x4a6
  536340: f9408508     	ldr	x8, [x8, #0x108]
  536344: aa1303e0     	mov	x0, x19
  536348: aa1703e1     	mov	x1, x23
  53634c: aa1b03e3     	mov	x3, x27
  536350: d63f0100     	blr	x8
  536354: aa0003fb     	mov	x27, x0

## 536678 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536658: 91182463     	add	x3, x3, #0x609
  53665c: aa1303e0     	mov	x0, x19
  536660: aa1803e1     	mov	x1, x24
  536664: d63f0100     	blr	x8
  536668: f9400268     	ldr	x8, [x19]
  53666c: f0000582     	adrp	x2, 0x5e9000
  536670: 90000343     	adrp	x3, 0x59e000
  536674: aa0003fb     	mov	x27, x0
  536678: f9408508     	ldr	x8, [x8, #0x108]
  53667c: 91395c42     	add	x2, x2, #0xe57
  536680: 91325463     	add	x3, x3, #0xc95
  536684: aa1303e0     	mov	x0, x19
  536688: aa1803e1     	mov	x1, x24
  53668c: d63f0100     	blr	x8

## 5366bc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  53669c: 9139a021     	add	x1, x1, #0xe68
  5366a0: f9401908     	ldr	x8, [x8, #0x30]
  5366a4: aa1303e0     	mov	x0, x19
  5366a8: d63f0100     	blr	x8
  5366ac: f9400268     	ldr	x8, [x19]
  5366b0: f0000582     	adrp	x2, 0x5e9000
  5366b4: f0000583     	adrp	x3, 0x5e9000
  5366b8: aa0003e1     	mov	x1, x0
  5366bc: f9408508     	ldr	x8, [x8, #0x108]
  5366c0: 913f1042     	add	x2, x2, #0xfc4
  5366c4: 913f7c63     	add	x3, x3, #0xfdf
  5366c8: aa1303e0     	mov	x0, x19
  5366cc: f9000be1     	str	x1, [sp, #0x10]
  5366d0: d63f0100     	blr	x8

## 536cc8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536ca8: 97ee87b6     	bl	0xd8b80 <__cxa_guard_release@plt>
  536cac: 17ffff5f     	b	0x536a28 <_ZN3mpf7CasBaseD2Ev+0x44150>
  536cb0: 97ee87ac     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  536cb4: 34ffec00     	cbz	w0, 0x536a34 <_ZN3mpf7CasBaseD2Ev+0x4415c>
  536cb8: f9400268     	ldr	x8, [x19]
  536cbc: f0000582     	adrp	x2, 0x5e9000
  536cc0: 90000343     	adrp	x3, 0x59e000
  536cc4: 91395c42     	add	x2, x2, #0xe57
  536cc8: f9408508     	ldr	x8, [x8, #0x108]
  536ccc: 91325463     	add	x3, x3, #0xc95
  536cd0: aa1303e0     	mov	x0, x19
  536cd4: aa1603e1     	mov	x1, x22
  536cd8: d63f0100     	blr	x8
  536cdc: f9001f60     	str	x0, [x27, #0x38]

## 536d08 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536ce8: 17ffff53     	b	0x536a34 <_ZN3mpf7CasBaseD2Ev+0x4415c>
  536cec: aa0803e0     	mov	x0, x8
  536cf0: 97ee879c     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  536cf4: 34ffeb40     	cbz	w0, 0x536a5c <_ZN3mpf7CasBaseD2Ev+0x44184>
  536cf8: f9400268     	ldr	x8, [x19]
  536cfc: f0000582     	adrp	x2, 0x5e9000
  536d00: f0000583     	adrp	x3, 0x5e9000
  536d04: 913a1042     	add	x2, x2, #0xe84
  536d08: f9408508     	ldr	x8, [x8, #0x108]
  536d0c: 913a6463     	add	x3, x3, #0xe99
  536d10: aa1303e0     	mov	x0, x19
  536d14: aa1703e1     	mov	x1, x23
  536d18: d63f0100     	blr	x8
  536d1c: f9002760     	str	x0, [x27, #0x48]

## 536d48 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536d28: 17ffff4d     	b	0x536a5c <_ZN3mpf7CasBaseD2Ev+0x44184>
  536d2c: aa0803e0     	mov	x0, x8
  536d30: 97ee878c     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  536d34: 34ffea80     	cbz	w0, 0x536a84 <_ZN3mpf7CasBaseD2Ev+0x441ac>
  536d38: f9400268     	ldr	x8, [x19]
  536d3c: f0000582     	adrp	x2, 0x5e9000
  536d40: f0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  536d44: 913b6042     	add	x2, x2, #0xed8
  536d48: f9408508     	ldr	x8, [x8, #0x108]
  536d4c: 91174463     	add	x3, x3, #0x5d1
  536d50: aa1303e0     	mov	x0, x19
  536d54: aa1403e1     	mov	x1, x20
  536d58: d63f0100     	blr	x8
  536d5c: f9002f60     	str	x0, [x27, #0x58]

## 536e1c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536dfc: 91182463     	add	x3, x3, #0x609
  536e00: aa1303e0     	mov	x0, x19
  536e04: aa1403e1     	mov	x1, x20
  536e08: d63f0100     	blr	x8
  536e0c: f9400268     	ldr	x8, [x19]
  536e10: f0000582     	adrp	x2, 0x5e9000
  536e14: 90000343     	adrp	x3, 0x59e000
  536e18: aa0003f8     	mov	x24, x0
  536e1c: f9408508     	ldr	x8, [x8, #0x108]
  536e20: 91395c42     	add	x2, x2, #0xe57
  536e24: 91325463     	add	x3, x3, #0xc95
  536e28: aa1303e0     	mov	x0, x19
  536e2c: aa1403e1     	mov	x1, x20
  536e30: d63f0100     	blr	x8

## 536e60 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536e40: 9139a021     	add	x1, x1, #0xe68
  536e44: f9401908     	ldr	x8, [x8, #0x30]
  536e48: aa1303e0     	mov	x0, x19
  536e4c: d63f0100     	blr	x8
  536e50: f9400268     	ldr	x8, [x19]
  536e54: f0000582     	adrp	x2, 0x5e9000
  536e58: f0000583     	adrp	x3, 0x5e9000
  536e5c: aa0003e1     	mov	x1, x0
  536e60: f9408508     	ldr	x8, [x8, #0x108]
  536e64: 913b9042     	add	x2, x2, #0xee4
  536e68: 913bc863     	add	x3, x3, #0xef2
  536e6c: aa1303e0     	mov	x0, x19
  536e70: f9000be1     	str	x1, [sp, #0x10]
  536e74: d63f0100     	blr	x8

## 536ea4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  536e84: 913c7821     	add	x1, x1, #0xf1e
  536e88: f9401908     	ldr	x8, [x8, #0x30]
  536e8c: aa1303e0     	mov	x0, x19
  536e90: d63f0100     	blr	x8
  536e94: f9400268     	ldr	x8, [x19]
  536e98: aa0003f6     	mov	x22, x0
  536e9c: f0000322     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  536ea0: f0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  536ea4: f9408508     	ldr	x8, [x8, #0x108]
  536ea8: 91141042     	add	x2, x2, #0x504
  536eac: 91142c63     	add	x3, x3, #0x50b
  536eb0: aa1303e0     	mov	x0, x19
  536eb4: aa1603e1     	mov	x1, x22
  536eb8: d63f0100     	blr	x8

## 537fbc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  537f9c: d65f03c0     	ret
  537fa0: aa0803e0     	mov	x0, x8
  537fa4: 97ee82ef     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  537fa8: 34fff200     	cbz	w0, 0x537de8 <_ZN3mpf7CasBaseD2Ev+0x45510>
  537fac: f9400288     	ldr	x8, [x20]
  537fb0: f0000582     	adrp	x2, 0x5ea000
  537fb4: f0000583     	adrp	x3, 0x5ea000
  537fb8: 91037442     	add	x2, x2, #0xdd
  537fbc: f9408508     	ldr	x8, [x8, #0x108]
  537fc0: 9103a863     	add	x3, x3, #0xea
  537fc4: aa1403e0     	mov	x0, x20
  537fc8: aa1703e1     	mov	x1, x23
  537fcc: d63f0100     	blr	x8
  537fd0: f9001320     	str	x0, [x25, #0x20]

## 537ffc — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  537fdc: 17ffff83     	b	0x537de8 <_ZN3mpf7CasBaseD2Ev+0x45510>
  537fe0: aa0803e0     	mov	x0, x8
  537fe4: 97ee82df     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  537fe8: 34fff2a0     	cbz	w0, 0x537e3c <_ZN3mpf7CasBaseD2Ev+0x45564>
  537fec: f9400288     	ldr	x8, [x20]
  537ff0: f0000582     	adrp	x2, 0x5ea000
  537ff4: f0000583     	adrp	x3, 0x5ea000
  537ff8: 9104a842     	add	x2, x2, #0x12a
  537ffc: f9408508     	ldr	x8, [x8, #0x108]
  538000: 9104ec63     	add	x3, x3, #0x13b
  538004: aa1403e0     	mov	x0, x20
  538008: aa1703e1     	mov	x1, x23
  53800c: d63f0100     	blr	x8
  538010: f9001b20     	str	x0, [x25, #0x30]

## 5384cc — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5384ac: d65f03c0     	ret
  5384b0: aa0803e0     	mov	x0, x8
  5384b4: 97ee81ab     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  5384b8: 34ffea40     	cbz	w0, 0x538200 <_ZN3mpf7CasBaseD2Ev+0x45928>
  5384bc: f9400268     	ldr	x8, [x19]
  5384c0: d0000582     	adrp	x2, 0x5ea000
  5384c4: d0000583     	adrp	x3, 0x5ea000
  5384c8: 91072442     	add	x2, x2, #0x1c9
  5384cc: f9408508     	ldr	x8, [x8, #0x108]
  5384d0: 91076863     	add	x3, x3, #0x1da
  5384d4: aa1303e0     	mov	x0, x19
  5384d8: aa1703e1     	mov	x1, x23
  5384dc: d63f0100     	blr	x8
  5384e0: f90042a0     	str	x0, [x21, #0x80]

## 53850c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5384ec: 17ffff45     	b	0x538200 <_ZN3mpf7CasBaseD2Ev+0x45928>
  5384f0: aa0803e0     	mov	x0, x8
  5384f4: 97ee819b     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  5384f8: 34ffe980     	cbz	w0, 0x538228 <_ZN3mpf7CasBaseD2Ev+0x45950>
  5384fc: f9400268     	ldr	x8, [x19]
  538500: b0000322     	adrp	x2, 0x59d000 <__cxa_demangle+0x182b4>
  538504: b0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  538508: 91141042     	add	x2, x2, #0x504
  53850c: f9408508     	ldr	x8, [x8, #0x108]
  538510: 91158463     	add	x3, x3, #0x561
  538514: aa1303e0     	mov	x0, x19
  538518: aa1603e1     	mov	x1, x22
  53851c: d63f0100     	blr	x8
  538520: f9004aa0     	str	x0, [x21, #0x90]

## 53854c — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  53852c: 17ffff3f     	b	0x538228 <_ZN3mpf7CasBaseD2Ev+0x45950>
  538530: aa0803e0     	mov	x0, x8
  538534: 97ee818b     	bl	0xd8b60 <__cxa_guard_acquire@plt>
  538538: 34ffe8c0     	cbz	w0, 0x538250 <_ZN3mpf7CasBaseD2Ev+0x45978>
  53853c: f9400268     	ldr	x8, [x19]
  538540: d0000582     	adrp	x2, 0x5ea000
  538544: d0000343     	adrp	x3, 0x5a2000
  538548: 9109a842     	add	x2, x2, #0x26a
  53854c: f9408508     	ldr	x8, [x8, #0x108]
  538550: 91374c63     	add	x3, x3, #0xdd3
  538554: aa1303e0     	mov	x0, x19
  538558: aa1803e1     	mov	x1, x24
  53855c: d63f0100     	blr	x8
  538560: f90052a0     	str	x0, [x21, #0xa0]

## 5386ac — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  53868c: 9100f821     	add	x1, x1, #0x3e
  538690: aa1403e0     	mov	x0, x20
  538694: f9401908     	ldr	x8, [x8, #0x30]
  538698: d63f0100     	blr	x8
  53869c: f9400288     	ldr	x8, [x20]
  5386a0: aa0003f6     	mov	x22, x0
  5386a4: b0000482     	adrp	x2, 0x5c9000
  5386a8: b0000483     	adrp	x3, 0x5c9000
  5386ac: f9408508     	ldr	x8, [x8, #0x108]
  5386b0: 91026442     	add	x2, x2, #0x99
  5386b4: 91029463     	add	x3, x3, #0xa5
  5386b8: aa1403e0     	mov	x0, x20
  5386bc: aa1603e1     	mov	x1, x22
  5386c0: d63f0100     	blr	x8

## 538700 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  5386e0: 9102d821     	add	x1, x1, #0xb6
  5386e4: f9401908     	ldr	x8, [x8, #0x30]
  5386e8: aa1403e0     	mov	x0, x20
  5386ec: d63f0100     	blr	x8
  5386f0: f9400288     	ldr	x8, [x20]
  5386f4: aa0003f7     	mov	x23, x0
  5386f8: b0000482     	adrp	x2, 0x5c9000
  5386fc: b0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  538700: f9408508     	ldr	x8, [x8, #0x108]
  538704: 91030c42     	add	x2, x2, #0xc3
  538708: 910fcc63     	add	x3, x3, #0x3f3
  53870c: aa1403e0     	mov	x0, x20
  538710: aa1703e1     	mov	x1, x23
  538714: d63f0100     	blr	x8

## 5389d8 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  5389b8: 9100f821     	add	x1, x1, #0x3e
  5389bc: aa1403e0     	mov	x0, x20
  5389c0: f9401908     	ldr	x8, [x8, #0x30]
  5389c4: d63f0100     	blr	x8
  5389c8: f9400288     	ldr	x8, [x20]
  5389cc: aa0003f5     	mov	x21, x0
  5389d0: d0000582     	adrp	x2, 0x5ea000
  5389d4: d0000583     	adrp	x3, 0x5ea000
  5389d8: f9408508     	ldr	x8, [x8, #0x108]
  5389dc: 910b2442     	add	x2, x2, #0x2c9
  5389e0: 910b7463     	add	x3, x3, #0x2dd
  5389e4: aa1403e0     	mov	x0, x20
  5389e8: aa1503e1     	mov	x1, x21
  5389ec: d63f0100     	blr	x8

## 538a90 — UNRESOLVED_0x108_DATAFLOW
Function: _ZN3mpf7CasBaseD2Ev
Basis: no target-vtable provenance established
ASM:
  538a70: 9102d821     	add	x1, x1, #0xb6
  538a74: aa1403e0     	mov	x0, x20
  538a78: f9401908     	ldr	x8, [x8, #0x30]
  538a7c: d63f0100     	blr	x8
  538a80: f9400288     	ldr	x8, [x20]
  538a84: aa0003f7     	mov	x23, x0
  538a88: b0000482     	adrp	x2, 0x5c9000
  538a8c: b0000323     	adrp	x3, 0x59d000 <__cxa_demangle+0x182b4>
  538a90: f9408508     	ldr	x8, [x8, #0x108]
  538a94: 91030c42     	add	x2, x2, #0xc3
  538a98: 910fcc63     	add	x3, x3, #0x3f3
  538a9c: aa1403e0     	mov	x0, x20
  538aa0: aa1703e1     	mov	x1, x23
  538aa4: d63f0100     	blr	x8

## 5396c4 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5396a4: aa1303e0     	mov	x0, x19
  5396a8: aa1403e1     	mov	x1, x20
  5396ac: f9407d08     	ldr	x8, [x8, #0xf8]
  5396b0: d63f0100     	blr	x8
  5396b4: f9400268     	ldr	x8, [x19]
  5396b8: aa0003f5     	mov	x21, x0
  5396bc: b0000582     	adrp	x2, 0x5ea000
  5396c0: b0000583     	adrp	x3, 0x5ea000
  5396c4: f9408508     	ldr	x8, [x8, #0x108]
  5396c8: 91110042     	add	x2, x2, #0x440
  5396cc: 91113c63     	add	x3, x3, #0x44f
  5396d0: aa1303e0     	mov	x0, x19
  5396d4: aa1503e1     	mov	x1, x21
  5396d8: d63f0100     	blr	x8

## 5397c8 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  5397a8: aa1403e1     	mov	x1, x20
  5397ac: 97eefe7d     	bl	0xf91a0 <JNI_OnUnload+0x83c>
  5397b0: aa0003f5     	mov	x21, x0
  5397b4: b4000460     	cbz	x0, 0x539840 <_ZN3mpf7CasBaseD2Ev+0x46f68>
  5397b8: f9400268     	ldr	x8, [x19]
  5397bc: 90000482     	adrp	x2, 0x5c9000
  5397c0: 90000483     	adrp	x3, 0x5c9000
  5397c4: 91004c42     	add	x2, x2, #0x13
  5397c8: f9408508     	ldr	x8, [x8, #0x108]
  5397cc: 91008863     	add	x3, x3, #0x22
  5397d0: aa1303e0     	mov	x0, x19
  5397d4: aa1403e1     	mov	x1, x20
  5397d8: d63f0100     	blr	x8
  5397dc: aa0003e2     	mov	x2, x0

## 5399b0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  539990: 9100f821     	add	x1, x1, #0x3e
  539994: aa1303e0     	mov	x0, x19
  539998: f9401908     	ldr	x8, [x8, #0x30]
  53999c: d63f0100     	blr	x8
  5399a0: f9400268     	ldr	x8, [x19]
  5399a4: aa0003f5     	mov	x21, x0
  5399a8: 90000482     	adrp	x2, 0x5c9000
  5399ac: 90000483     	adrp	x3, 0x5c9000
  5399b0: f9408508     	ldr	x8, [x8, #0x108]
  5399b4: 910b7042     	add	x2, x2, #0x2dc
  5399b8: 910b9863     	add	x3, x3, #0x2e6
  5399bc: aa1303e0     	mov	x0, x19
  5399c0: aa1503e1     	mov	x1, x21
  5399c4: d63f0100     	blr	x8

## 539aa0 — CXX_VPTR_DATAFLOW_UNRESOLVED
Function: _ZN3mpf7CasBaseD2Ev
Basis: object-vptr load found but constructor provenance is not established
ASM:
  539a80: 9116b821     	add	x1, x1, #0x5ae
  539a84: aa1303e0     	mov	x0, x19
  539a88: f9401908     	ldr	x8, [x8, #0x30]
  539a8c: d63f0100     	blr	x8
  539a90: f9400268     	ldr	x8, [x19]
  539a94: aa0003f7     	mov	x23, x0
  539a98: b0000582     	adrp	x2, 0x5ea000
  539a9c: b0000583     	adrp	x3, 0x5ea000
  539aa0: f9408508     	ldr	x8, [x8, #0x108]
  539aa4: 91171042     	add	x2, x2, #0x5c4
  539aa8: 91173863     	add	x3, x3, #0x5ce
  539aac: aa1303e0     	mov	x0, x19
  539ab0: aa1703e1     	mov	x1, x23
  539ab4: d63f0100     	blr	x8

RESULT: NO_PROVEN_TARGET_VTABLE_DATAFLOW_FOUND

Static data-flow is distinct from runtime execution.
