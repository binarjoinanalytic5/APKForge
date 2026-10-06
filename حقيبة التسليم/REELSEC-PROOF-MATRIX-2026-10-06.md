# ReelSec Proof Matrix — 2026-10-06

## Scope

This document is the authoritative continuation matrix for the ReelShort v4.2.00 native/security investigation around:

- critical ELF pointer: 0x27a510
- recovered address-point: 0x717e60
- recovered slot: 0x717f68 (+0x108)
- RTTI: 0x71f4d0
- RTTI type name: N6Cicada17mediaCodecDecoderE

The investigation is static-first. No runtime-execution claim is accepted without runtime evidence.

## A. Proven findings

| Finding | Status | Evidence |
|---|---|---|
| Target ELF identified | PROVEN | ReelSec report records libsaasCorePlayer.so and SHA-256 a3b0c3fdc0817158cbbfaadb71fbcd608fe9835280bbf1defcb36c60090900e4 |
| Critical slot file-backed | PROVEN | PT_LOAD mapping reads 0x717f68 directly from ELF |
| Static slot value | PROVEN | 0x717f68 contains pointer 0x27a510 |
| RTTI pointer | PROVEN | 0x717e58 -> 0x71f4d0 |
| RTTI type string | PROVEN | 0x71f4d0 -> N6Cicada17mediaCodecDecoderE |
| Constructor vptr installation | PROVEN | 0x278450 calls ActiveDecoderC2Ev; 0x278454/0x278458 compute 0x717e50; 0x27846c computes 0x717e60; 0x27847c stores x9 to [x19] |
| Critical-function boundary | PROVEN | extracted body starts at 0x27a510 and stops at 0x27a540: d65f03c0 ret |
| Critical body has no calls | PROVEN | CRITICAL-FUNCTION-BEHAVIOR.md reports Calls: NONE |
| Critical body has no monitored security operation | PROVEN as body-local fact | no Surface/EGL/secure/buffer/screenshot operation in extracted body |
| JNI +0x108 pattern exists | PROVEN | repeated ldr x8,[x8,#0x108] + blr x8 sites with JNIEnv-style receiver |
| JNI semantic interpretation | PROVEN at semantic-pattern level | surrounding arguments match GetMethodID(env, clazz, name, sig); observed names include setForceInsecureDecoder, queueSecureInputBuffer, setOutputSurface |
| Static vtable entry chain | PROVEN | 0x717e60 -> 0x2785bc; 0x717e68 -> 0x278768; 0x717f68 -> 0x27a510 |

## B. Strong correlation findings

These are stronger than raw indicators but should remain separately labeled from runtime execution:

- 0x717e60 is installed as the object vptr in the ActiveDecoder constructor path.
- The same object layout contains RTTI naming mediaCodecDecoder.
- The first two address-point entries are destructor-like targets in the same object lifecycle region.
- The lifecycle path around 0x2785bc resets a vptr and calls ActiveDecoderD2Ev.
- The symbol table is known to be unreliable for exact function sizing in this region because of oversized dummyFunction coverage; RET/CFG evidence is preferred.

## C. Explicitly NOT proven

### C1. Runtime virtual dispatch to 0x27a510

Required chain:

object instance proven as mediaCodecDecoder
-> load vptr
-> prove vptr == 0x717e60 at the call site
-> load [vptr + 0x108]
-> obtain 0x27a510
-> blr
-> runtime execution observed or otherwise independently proven

Current status: NOT_PROVEN.

### C2. Screenshot blocking/security meaning of 0x27a510

Current status: NOT_PROVEN.

Reason: the body at 0x27a510 is only stack-canary bookkeeping and return. Security semantics, if any, would have to come from the caller/dispatch context.

### C3. Exact C++ class constructor identity from symbols alone

Current status: NOT_PROVEN as a symbol-identity claim.

Reason: ActiveDecoderC2Ev is explicitly called, while RTTI identifies mediaCodecDecoder. The investigation must not collapse these into one class name without inheritance/layout evidence.

## D. Known false-positive class

The following are JNI interface-table dispatches, not evidence of the C++ vtable slot:

- 0x27af18
- 0x27af44
- 0x27af70
- 0x27af9c
- 0x27afc8
- 0x27aff4
- 0x27b020
- 0x27b050
- 0x27b078
- 0x27b0a0
- 0x27b0c8
- 0x27b0f4
- 0x27b124
- 0x27b150
- 0x27b17c
- 0x27b1a4
- 0x27b1d8
- 0x27b1fc
- 0x27b228

Their common shape is consistent with JNIEnv/GetMethodID dispatch and they must not be mapped to 0x717f68 without independent object/data-flow proof.

## E. ReelSec corrections already completed

1. Critical body extraction now stops at the first ARM64 RET opcode/mnemonic.
2. CRITICAL-FUNCTION-BODY.txt records the exact extracted body separately from the raw disassembly window.
3. VTable object proof was hardened against objdump whitespace/tabs.
4. A regression test covers the whitespace case.
5. Destructor analysis is now collected in a dedicated ActiveDecoder-destructor.txt window.
6. VTable class correlation reads the constructor and destructor evidence separately.
7. A full-text Remaining Dispatch Audit scans for +0x108 indirect dispatch candidates rather than relying on one limited address window.
8. Publish verification requires REMAINING-DISPATCH-AUDIT.md.

Relevant commits:
- 189cd37a5944c9c8e614ed188029e1a4b29c7471
- 536f1a82836d55446a63db96a6db6d4bf56c1696
- cca00753c0521caf508861a1b76ac7f2296368ad
- 12b53963f3d2cd4efb06ef696ef60d0014adb03c
- 70a10717e6d3de221bb0625b747a512c8971152d

## F. Latest executed report before the newest scanner fix

Report:
analysis/sec-shell-deep-v1/reelsec-20261006_191348

Published branch:
reelsec/reports/20261006_191351-31711

Published report commit:
065572225ffb574e95580828fc56823b1d03ecff

That report correctly proved the object vptr, static slot mapping, critical-function boundary, and JNI pattern.

Its VTABLE-CLASS-CORRELATION.md still showed NOT_PROVEN because it looked for ActiveDecoderD2Ev inside the constructor-only disassembly window. That was an instrumentation/reporting defect, not a new binary finding. Commit 70a10717... separates the destructor window and fixes this.

## G. Immediate next proof run

Run the current main branch so the following new artifacts are generated:

- ActiveDecoder-destructor.txt
- VTABLE-CLASS-CORRELATION.md
- full-disassembly.txt
- REMAINING-DISPATCH-AUDIT.md

Command:

cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash

Expected decision points:

1. VTABLE-CLASS-CORRELATION must become PROVEN_RTTI_VTABLE_CONSTRUCTOR_DESTRUCTOR_CORRELATION if all lifecycle evidence matches.
2. REMAINING-DISPATCH-AUDIT must report the total +0x108 candidates and distinguish JNI-like from proven-object candidates.
3. A zero count of proven-object candidates means no static C++ object-dispatch proof has been found; it does not prove runtime non-execution.
4. Any unresolved candidate requires manual data-flow reconstruction before assigning 0x27a510.
5. Screenshot/security conclusion remains blocked until the dispatch/caller path is proven.

## H. Runtime proof gate

Static analysis is insufficient for the final execution claim.

A final runtime claim requires at least one of:

- instruction-level tracing showing the indirect call resolves to 0x27a510;
- debugger/watchpoint evidence showing vptr value 0x717e60 and slot load result 0x27a510 immediately before blr;
- equivalent runtime instrumentation with reproducible logs tied to the relevant playback/capture path.

Without such evidence, the correct status remains:
RUNTIME_DISPATCH = NOT_PROVEN
SCREENSHOT_BLOCKING = NOT_PROVEN
