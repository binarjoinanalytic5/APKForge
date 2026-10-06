# JNI Semantic Analysis

Finding: the observed +0x108 dispatch pattern matches the JNI JNIEnv interface table.
JNI GetMethodID is interface-table index 33; with 8-byte pointers this is offset 0x108.
The observed arguments match GetMethodID(env, clazz, name, sig).
Observed method names include setForceInsecureDecoder, queueSecureInputBuffer, and setOutputSurface.

This is not proof of an ActiveDecoder C++ vtable. Do not use 0x717f68 as the implementation for these JNI calls without independent object/data-flow evidence.

Next: trace the returned jmethodIDs to Call<Type>Method* dispatches and then into Java Window/Surface security.

Matching dispatch excerpts:
```asm
  27af18: f9408508     	ldr	x8, [x8, #0x108]
  27af1c: 91141042     	add	x2, x2, #0x504
  27af20: 91142c63     	add	x3, x3, #0x50b
  27af24: aa1303e0     	mov	x0, x19
  27af28: d63f0100     	blr	x8
  27af2c: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af30: f9013500     	str	x0, [x8, #0x268]
  27af34: f9400268     	ldr	x8, [x19]
```
```asm
  27af44: f9408508     	ldr	x8, [x8, #0x108]
  27af48: 9117d842     	add	x2, x2, #0x5f6
  27af4c: 9138e063     	add	x3, x3, #0xe38
  27af50: aa1303e0     	mov	x0, x19
  27af54: d63f0100     	blr	x8
  27af58: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af5c: f9013900     	str	x0, [x8, #0x270]
  27af60: f9400268     	ldr	x8, [x19]
```
```asm
  27af70: f9408508     	ldr	x8, [x8, #0x108]
  27af74: 91182c42     	add	x2, x2, #0x60b
  27af78: 91185863     	add	x3, x3, #0x616
  27af7c: aa1303e0     	mov	x0, x19
  27af80: d63f0100     	blr	x8
  27af84: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27af88: f9013d00     	str	x0, [x8, #0x278]
  27af8c: f9400268     	ldr	x8, [x19]
```
```asm
  27af9c: f9408508     	ldr	x8, [x8, #0x108]
  27afa0: 9118b842     	add	x2, x2, #0x62e
  27afa4: 9139c463     	add	x3, x3, #0xe71
  27afa8: aa1303e0     	mov	x0, x19
  27afac: d63f0100     	blr	x8
  27afb0: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27afb4: f9014100     	str	x0, [x8, #0x280]
  27afb8: f9400268     	ldr	x8, [x19]
```
```asm
  27afc8: f9408508     	ldr	x8, [x8, #0x108]
  27afcc: 91191842     	add	x2, x2, #0x646
  27afd0: 91195463     	add	x3, x3, #0x655
  27afd4: aa1303e0     	mov	x0, x19
  27afd8: d63f0100     	blr	x8
  27afdc: 90002688     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27afe0: f9014500     	str	x0, [x8, #0x288]
  27afe4: f9400268     	ldr	x8, [x19]
```
```asm
  27aff4: f9408508     	ldr	x8, [x8, #0x108]
  27aff8: 911a0442     	add	x2, x2, #0x681
  27affc: 911a4063     	add	x3, x3, #0x690
  27b000: aa1303e0     	mov	x0, x19
  27b004: d63f0100     	blr	x8
  27b008: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b00c: f9014900     	str	x0, [x8, #0x290]
  27b010: f9400268     	ldr	x8, [x19]
```
```asm
  27b020: f9408508     	ldr	x8, [x8, #0x108]
  27b024: 91174694     	add	x20, x20, #0x5d1
  27b028: 91118842     	add	x2, x2, #0x462
  27b02c: aa1303e0     	mov	x0, x19
  27b030: aa1403e3     	mov	x3, x20
  27b034: d63f0100     	blr	x8
  27b038: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b03c: f9014d00     	str	x0, [x8, #0x298]
```
```asm
  27b050: f9408508     	ldr	x8, [x8, #0x108]
  27b054: aa1303e0     	mov	x0, x19
  27b058: aa1403e3     	mov	x3, x20
  27b05c: d63f0100     	blr	x8
  27b060: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b064: f9015100     	str	x0, [x8, #0x2a0]
  27b068: f9400268     	ldr	x8, [x19]
  27b06c: f94132c1     	ldr	x1, [x22, #0x260]
```
```asm
  27b078: f9408508     	ldr	x8, [x8, #0x108]
  27b07c: aa1303e0     	mov	x0, x19
  27b080: aa1403e3     	mov	x3, x20
  27b084: d63f0100     	blr	x8
  27b088: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b08c: f9015500     	str	x0, [x8, #0x2a8]
  27b090: f9400268     	ldr	x8, [x19]
  27b094: f94132c1     	ldr	x1, [x22, #0x260]
```
```asm
  27b0a0: f9408508     	ldr	x8, [x8, #0x108]
  27b0a4: aa1303e0     	mov	x0, x19
  27b0a8: aa1403e3     	mov	x3, x20
  27b0ac: d63f0100     	blr	x8
  27b0b0: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b0b4: f9015900     	str	x0, [x8, #0x2b0]
  27b0b8: f9400268     	ldr	x8, [x19]
  27b0bc: f94132c1     	ldr	x1, [x22, #0x260]
```
```asm
  27b0c8: f9408508     	ldr	x8, [x8, #0x108]
  27b0cc: 911aa442     	add	x2, x2, #0x6a9
  27b0d0: 911af463     	add	x3, x3, #0x6bd
  27b0d4: aa1303e0     	mov	x0, x19
  27b0d8: d63f0100     	blr	x8
  27b0dc: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b0e0: f9015d00     	str	x0, [x8, #0x2b8]
  27b0e4: f9400268     	ldr	x8, [x19]
```
```asm
  27b0f4: f9408508     	ldr	x8, [x8, #0x108]
  27b0f8: 911b6e94     	add	x20, x20, #0x6db
  27b0fc: 911b0c42     	add	x2, x2, #0x6c3
  27b100: aa1303e0     	mov	x0, x19
  27b104: aa1403e3     	mov	x3, x20
  27b108: d63f0100     	blr	x8
  27b10c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b110: f9016100     	str	x0, [x8, #0x2c0]
```
```asm
  27b124: f9408508     	ldr	x8, [x8, #0x108]
  27b128: 911b8042     	add	x2, x2, #0x6e0
  27b12c: 911bc463     	add	x3, x3, #0x6f1
  27b130: aa1303e0     	mov	x0, x19
  27b134: d63f0100     	blr	x8
  27b138: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b13c: f9016500     	str	x0, [x8, #0x2c8]
  27b140: f9400268     	ldr	x8, [x19]
```
```asm
  27b150: f9408508     	ldr	x8, [x8, #0x108]
  27b154: 911be842     	add	x2, x2, #0x6fa
  27b158: 911c4463     	add	x3, x3, #0x711
  27b15c: aa1303e0     	mov	x0, x19
  27b160: d63f0100     	blr	x8
  27b164: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b168: f9016900     	str	x0, [x8, #0x2d0]
  27b16c: f9400268     	ldr	x8, [x19]
```
```asm
  27b17c: f9408508     	ldr	x8, [x8, #0x108]
  27b180: aa1303e0     	mov	x0, x19
  27b184: aa1403e3     	mov	x3, x20
  27b188: d63f0100     	blr	x8
  27b18c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b190: f9016d00     	str	x0, [x8, #0x2d8]
  27b194: f9400268     	ldr	x8, [x19]
  27b198: f94132c1     	ldr	x1, [x22, #0x260]
```
```asm
  27b1a4: f9408508     	ldr	x8, [x8, #0x108]
  27b1a8: 91189694     	add	x20, x20, #0x625
  27b1ac: 911d1442     	add	x2, x2, #0x745
  27b1b0: aa1303e0     	mov	x0, x19
  27b1b4: aa1403e3     	mov	x3, x20
  27b1b8: d63f0100     	blr	x8
  27b1bc: f0002677     	adrp	x23, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b1c0: 910bc2f7     	add	x23, x23, #0x2f0
```
```asm
  27b1d8: f9408508     	ldr	x8, [x8, #0x108]
  27b1dc: aa1303e0     	mov	x0, x19
  27b1e0: aa1403e3     	mov	x3, x20
  27b1e4: d63f0100     	blr	x8
  27b1e8: f90006e0     	str	x0, [x23, #0x8]
  27b1ec: f9400268     	ldr	x8, [x19]
  27b1f0: f94132c1     	ldr	x1, [x22, #0x260]
  27b1f4: b0001a02     	adrp	x2, 0x5bc000
```
```asm
  27b1fc: f9408508     	ldr	x8, [x8, #0x108]
  27b200: 911d9842     	add	x2, x2, #0x766
  27b204: 91389c63     	add	x3, x3, #0xe27
  27b208: aa1303e0     	mov	x0, x19
  27b20c: d63f0100     	blr	x8
  27b210: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b214: f9017100     	str	x0, [x8, #0x2e0]
  27b218: f9400268     	ldr	x8, [x19]
```
```asm
  27b228: f9408508     	ldr	x8, [x8, #0x108]
  27b22c: 911dd442     	add	x2, x2, #0x775
  27b230: 91192863     	add	x3, x3, #0x64a
  27b234: aa1303e0     	mov	x0, x19
  27b238: d63f0100     	blr	x8
  27b23c: f0002668     	adrp	x8, 0x74a000 <_ZN18codecPluginManager14_nextCodecSlotE+0x2d0>
  27b240: f9017500     	str	x0, [x8, #0x2e8]
  27b244: 910023e0     	add	x0, sp, #0x8
```
