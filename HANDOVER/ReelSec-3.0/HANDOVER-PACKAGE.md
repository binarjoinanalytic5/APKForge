# ReelSec 3.0 — HANDOVER PACKAGE

## Project

Repository:
binarjoinanalytic5/ReelShort-v4.2.00-analysis

Local:
~/apk-lab/ReelShort-v4.2.00

Target:
ReelShort Android v4.2.00

APK:
original.apk

Package:
com.newleaf.app.android.victor

Date:
2026-10-06

---

# 1. IMPORTANT EXECUTIVE DECISION

DO NOT continue this investigation as a sequence of manual Termux commands.

The investigation exposed an architectural weakness in ReelSec:

The operator is currently being used as the integration layer for:
- Apktool
- Java
- ADB
- Frida
- Gadget
- APK rebuilding
- signing
- deployment
- runtime probing

This is NOT the desired architecture.

ReelSec itself must become the analysis laboratory.

The operator should eventually run a high-level command and ReelSec should:
1. discover the environment;
2. discover available tooling;
3. detect unusable tooling;
4. select fallback backends;
5. decode the APK;
6. analyze Smali/native code;
7. detect SecShell/packer conditions;
8. assess runtime capabilities;
9. build isolated runtime instrumentation when required;
10. rebuild/sign/verify an instrumented APK when appropriate;
11. deploy it;
12. run the runtime campaign;
13. collect evidence;
14. classify proof;
15. produce a complete report and handover package.

DO NOT perform a Big Rewrite.

Preserve the existing proven static-analysis engine and evolve it incrementally.

---

# 2. CURRENT SCIENTIFIC CONCLUSION

The current investigation has established a real static native relationship around:

Target function:
0x27a510

Target vtable address point:
0x717e60

Critical slot:
0x717f68

Slot offset:
+0x108

Pointer stored:
0x27a510

RTTI:
0x71f4d0

RTTI type:
N6Cicada17mediaCodecDecoderE

However:

THIS DOES NOT PROVE SCREENSHOT BLOCKING.

The target function itself was classified:

NO_SECURITY_OPERATION_OBSERVED

There is currently ZERO proven runtime execution of the target function on the original APK.

There is currently ZERO proof that the target function causes screenshot blocking.

---

# 3. TARGET ELF

Library:

libsaasCorePlayer.so

SHA-256:

a3b0c3fdc0817158cbbfaadb71fbcd608fe9835280bbf1defcb36c60090900e4

Critical function:

0x27a510

Symbol:

NOT_RESOLVED_BY_SYMBOL_TABLE

---

# 4. VTABLE EVIDENCE

Target address point:

0x717e60

Observed:

0x717e60 -> 0x2785bc
0x717e68 -> 0x278768

0x717f60 -> 0x27a4d4
0x717f68 -> 0x27a510
0x717f70 -> 0x27a548
0x717f78 -> 0x27a59c
0x717f80 -> 0x27a608

Critical relationship:

[0x717e60 + 0x108] => 0x27a510

This is strong static evidence.

It is NOT screenshot-blocking proof.

---

# 5. CRITICAL FUNCTION

Target:

0x27a510

Observed characteristics:
- short function;
- no observed BL;
- no observed BLR;
- no observed security-related operation;
- no observed screenshot-related operation.

Classification:

NO_SECURITY_OPERATION_OBSERVED

Therefore:

DO NOT label it:
- screenshot blocker;
- security function;
- anti-capture function;
- DRM enforcement function;

unless new independent evidence establishes this.

---

# 6. CONSTRUCTOR PROVENANCE

Constructor evidence:

0x278448: mov x19, x0
0x278450: bl 0xdfbd0 <_ZN13ActiveDecoderC2Ev@plt>
0x278454: adrp x8, 0x717000
0x278458: add x8, x8, #0xe50
0x27846c: add x9, x8, #0x10
0x27847c: str x9, [x19]

This proves:
- ActiveDecoderC2Ev is called;
- the analyzed path writes the address point 0x717e60 into [x19].

It does NOT prove the exact C++ inheritance/secondary-vtable relationship.

Current state:

TARGET_PROVENANCE_STATUS=DIFFERENT_ADDRESS_POINT

Remain conservative.

---

# 7. DESTRUCTOR

Observed:

0x2785bc: sub sp, sp, #0x50
...
0x2785dc: mov x19, x0
0x2785e0: adrp x9, 0x717000
0x2785e4: add x9, x9, #0xe50
0x2785f0: add x8, x9, #0x10
0x2785f4: str x8, [x19]
...
0x278678: mov x0, x19
0x278678: bl 0xddc20 <_ZN13ActiveDecoderD2Ev@plt>
0x2786a0: ret

Named ActiveDecoder vtable observed elsewhere around 0x718018.

Do not infer exact C++ hierarchy beyond proven evidence.

---

# 8. JNI FALSE POSITIVE DISCOVERY

A major false-positive class was identified.

Pattern:

ldr x8, [x19]
ldr x8, [x8, #0x108]
blr x8

0x108 / 8 = 33

This is consistent with JNI interface-table dispatch and must NOT automatically be classified as C++ object vtable dispatch.

Previous candidate count:

376 +0x108 indirect candidates

Previous classifier:
271 JNI-like
12 falsely classified PROVEN_CXX_OBJECT
93 unresolved

Manual review showed the 12 were JNI/unrelated.

Examples:

0x1236e0..0x123804
JavaVodAsset::init

0x124cf0..0x124d30
JavaVodPlayInfo::init

0x2872a0
Cicada::jniOnFrameAvailable

0x20aa84
CicadaPlayerPrototype::create

0x275744
Cicada::hls::TagFactory::createTagByName

ReelSec must remain conservative.

---

# 9. AUTONOMOUS CAMPAIGN STATE

Latest known values:

static_dataflow.candidates = 473

constructor_calls = 4

cxx_unresolved = 354

jni_excluded_count = 6

proven = 0

Truth rules:

1. Static target-slot mapping can be PROVEN when static evidence rules are satisfied.
2. Runtime execution can be PROVEN only when the runtime observation rule is satisfied.
3. Screenshot blocking must NEVER be inferred from pointer/vtable presence alone.

---

# 10. RUNTIME TARGET RULE

Runtime target:

Native module:
libsaasCorePlayer.so

Target:
0x27a510

Expected vptr:
0x717e60

Expected slot:
[vptr + 0x108] == 0x27a510

Runtime target dispatch may be classified PROVEN only when the target entry is actually observed and the expected vptr/slot relationship is simultaneously observed.

Pointer presence alone is insufficient.

---

# 11. ANDROID ENVIRONMENT

Device:

SM-N986U

Android:

13

ABI:

arm64-v8a

ADB:

/data/data/com.termux/files/usr/bin/adb

Device:

192.168.8.8:42025

ADB state:

device

Important:

Frida reports the Android device as type "usb" even though ADB is wireless.

Do not interpret this as physical USB evidence.

---

# 12. FRIDA ENVIRONMENT

Frida:

17.22.2

Available through Debian/PRoot.

Wrapper:

~/.local/bin/frida

Wrapper behavior:

proot-distro login debian -- /usr/local/bin/frida "$@"

Frida can enumerate the Android device.

---

# 13. FRIDA BLOCKER HISTORY

## 13.1 Old runtime problem

The original runtime launcher used:

--no-pause

Frida 17.22.2 does not support that option.

Fixed.

Commit:

1df424b9de47b08e1868dfc84cfa6cfbd1b4c72f

Message:

fix: update Frida runtime launcher for 17.x

Tests:
- py_compile PASS
- existing runtime regression tests PASS

---

## 13.2 ADB/client resolution

Runtime probing was hardened to use exact client paths discovered by preflight.

Commit:

b64b9fe0066e7a81bc29f24b0d8dc40f8626e3c9

Message:

fix: harden ReelSec runtime ADB and Frida client resolution

---

## 13.3 Jailed Android

After the Frida CLI fix, Frida successfully reached the Android device but failed to spawn the jailed application.

Exact failure:

need Gadget to attach on jailed Android; its default location is:
/root/.cache/frida/gadget-android-arm64.so

Therefore the blocker is:

FRIDA_GADGET_REQUIRED

This means:
- ADB works;
- Android device is visible;
- Frida client works;
- Frida reaches Android;
- external spawn is blocked by jailed Android restrictions.

It is NOT an ADB discovery failure.

---

# 14. GADGET CLASSIFICATION FIX

Added explicit classification:

FRIDA_GADGET_REQUIRED

Commit:

b6ee0ece2d54233d2f6dc3b6b08b6ac80cb35a24

Message:

fix: classify jailed Android Frida Gadget requirement

Regression test:

d49a23dde9e3520cb4e7d7d558d6446f43f09b6d

Message:

test: classify jailed Android Frida Gadget failure

No CI status checks were available.

Do not claim CI execution.

---

# 15. SECSHELL EVIDENCE

Manifest:

com.SecShell.SecShell.AW

Application:

com.SecShell.SecShell.AW

appComponentFactory:

com.SecShell.SecShell.AP

AW.smali extends:

android.app.Application

attachBaseContext contains:

System.loadLibrary("SecShell")

Then the protected application initialization continues.

Natural experimental injection point:

immediately after:

System.loadLibrary("SecShell")

and before normal application initialization.

Important:

This is an experimental instrumentation point.

It is NOT proof that:
- the app will accept modification;
- the injection is behaviorally equivalent;
- the protected app will run normally;
- screenshot behavior remains unchanged.

---

# 16. MANUAL GADGET WORK — WHY IT STOPPED

A temporary script was proposed:

/tmp/build-reelsec-gadget.sh

It was not present on the device.

A later attempt to create it was interrupted.

The operator then manually investigated Apktool.

This is precisely the workflow ReelSec must eliminate.

The new architecture must not require the operator to manually:
- find Apktool;
- decode APK;
- locate AW.smali;
- inject libraries;
- acquire Gadget;
- rebuild APK;
- sign APK;
- install APK;
- run Frida;
- interpret failures.

ReelSec must automate this.

---

# 17. APKTOOL ENVIRONMENT

Termux:

Java:
21.0.12

ADB:
available

apktool command:
exists

However, the apktool command is an apkmod wrapper.

It fails with:

proot error: '/usr/bin/env' not found

Reason:

$PREFIX/share/apkmod/

does not currently contain a usable extracted rootfs.

The wrapper expects:

/usr/bin/env

inside the apkmod root.

Therefore:

apktool wrapper = AVAILABLE BUT UNUSABLE

---

# 18. STANDALONE APKTOOL DISCOVERY

An Apktool installation exists inside Ubuntu proot-distro:

$PREFIX/var/lib/proot-distro/containers/ubuntu/rootfs/usr/share/apktool

Files include:

apktool-cli.jar
apktool-lib.jar
brut.apktool.jar
brut.j.common.jar
brut.j.dir.jar
brut.j.util.jar
apktool-2.7.0.jar

Dependencies discovered:

commons-cli-1.6.0.jar
commons-io-2.19.0.jar
guava-32.0.1-jre.jar
snakeyaml-2.5.jar
smali-2.5.2.git2771eae.jar
baksmali-2.5.2.git2771eae.jar
ANTLR jars

Correct classpath test:

ROOTFS="$PREFIX/var/lib/proot-distro/containers/ubuntu/rootfs"
APKTOOL_DIR="$ROOTFS/usr/share/apktool"
JAVA_DIR="$ROOTFS/usr/share/java"
CP="$APKTOOL_DIR/*:$JAVA_DIR/*"

java -cp "$CP" brut.apktool.Main --version

Result:

2.7.0-dirty

Important:

This is a locally packaged dirty build.

Do not represent it as an official clean Apktool 2.7.0 release.

At handover time the APK decode had NOT yet been completed through this backend.

---

# 19. ORIGINAL APK INTEGRITY

Target file:

./original.apk

It must remain immutable.

Never:
- overwrite it;
- sign it;
- inject into it;
- rebuild over it;
- install it as an instrumented build.

All modifications must use isolated working directories.

---

# 20. REQUIRED REELSEC 3.0 ARCHITECTURE

ReelSec must evolve into:

ReelSec
|
+-- Environment Discovery
|
+-- Capability Matrix
|
+-- Backend Registry
|
+-- APK Backend
|
+-- Smali Backend
|
+-- Native Backend
|
+-- Frida Backend
|
+-- Gadget Backend
|
+-- Build/Signing Backend
|
+-- ADB Backend
|
+-- Runtime Backend
|
+-- Evidence Ledger
|
+-- Proof Engine
|
+-- Campaign Orchestrator
|
+-- Reporting/Handover

---

# 21. BACKEND MODEL

## APK Backend

Possible backends:

1. apkmod wrapper
2. standalone Apktool CLI
3. future fallback

The orchestrator must test usability, not merely command existence.

Example:

apktool command exists
BUT
execution fails

Therefore:

available != usable

---

# 22. CAPABILITY MATRIX

ReelSec should produce:

CAPABILITY-MATRIX.json

Example:

{
  "java": {
    "available": true,
    "version": "21.0.12"
  },
  "adb": {
    "available": true
  },
  "apktool": {
    "wrapper": {
      "available": true,
      "usable": false
    },
    "standalone": {
      "available": true,
      "version": "2.7.0-dirty"
    }
  },
  "frida": {
    "available": true,
    "version": "17.22.2",
    "android_spawn": false,
    "reason": "FRIDA_GADGET_REQUIRED"
  }
}

The exact schema may evolve.

---

# 23. BACKEND FALLBACK RULE

Example:

apktool wrapper fails
|
v
standalone Apktool discovered
|
v
standalone backend selected
|
v
continue campaign

The campaign must not stop simply because the first backend failed.

Likewise:

Frida spawn unavailable
|
v
detect jailed Android
|
v
Gadget backend selected
|
v
verify Gadget
|
v
build isolated instrumented APK
|
v
deploy
|
v
runtime probe

---

# 24. GADGET BUILDER

ReelSec itself must manage Gadget.

Requirements:

- official artifact source;
- exact version pinning;
- ABI verification;
- SHA-256 verification;
- isolated artifact directory;
- original APK immutable;
- modified APK hash recorded;
- Gadget hash recorded;
- signing certificate fingerprint recorded;
- manifest diff;
- Smali diff;
- build log;
- rollback path.

No unverified Gadget binary may enter the pipeline.

---

# 25. INSTRUMENTED APK PIPELINE

Required:

original.apk
|
v
SHA-256
|
v
decode
|
v
packer/SecShell detection
|
v
instrumentation-point discovery
|
v
Gadget insertion
|
v
probe insertion
|
v
rebuild
|
v
zipalign
|
v
sign
|
v
signature verification
|
v
install
|
v
launch
|
v
Frida/Gadget connection
|
v
runtime observation
|
v
evidence
|
v
proof classification

Every stage must generate machine-readable status.

---

# 26. PROOF STATES

Recommended states:

PROVEN_STATIC

PROVEN_RUNTIME_ORIGINAL

PROVEN_ON_INSTRUMENTED_BUILD

OBSERVED

SUPPORTED

LIKELY

UNPROVEN

BLOCKED

FAILED

Do not use generic PROVEN when the evidence is tied only to an instrumented build.

---

# 27. SCREENSHOT-BLOCKING PROOF

Screenshot blocking requires a causal chain.

Minimum desired evidence:

1. Screenshot-related Android API/event observed.
2. Relevant native/component path reached.
3. Target function or mechanism executes.
4. Execution changes screenshot behavior/output.
5. Timing/correlation is established.
6. Alternative explanations are considered/excluded.

A vtable pointer alone does not establish any of this.

---

# 28. EVIDENCE LEDGER

Every claim should contain:

claim_id
evidence_type
artifact
artifact_hash
location
observation
interpretation
proof_state
confidence
independent_corroboration
limitations

Example:

{
  "claim": "slot +0x108 resolves to 0x27a510",
  "proof_state": "PROVEN_STATIC",
  "limitations": [
    "does not prove runtime execution",
    "does not prove screenshot blocking"
  ]
}

---

# 29. USER EXPERIENCE TARGET

The desired future workflow is approximately:

./tools/reelsec/reelsec.py campaign ./original.apk

Then ReelSec performs the complete campaign.

The operator should NOT have to manually solve dependency/tooling problems.

The tool should:
- discover;
- select;
- recover;
- continue;
- collect;
- classify;
- report.

Only true external blockers should require operator intervention.

---

# 30. NO BIG REWRITE

Do not replace all of reelsec.py.

First audit:
- current architecture;
- current preflight;
- runtime probe;
- campaign orchestrator;
- artifact generation;
- publication;
- tests.

Then add modular capabilities incrementally.

Every change must:
- have a plan;
- have tests;
- have a focused commit;
- preserve existing behavior;
- have rollback.

---

# 31. NEXT AGENT STARTING PROCEDURE

The new agent must begin with:

PHASE A — READ THIS HANDOVER

Do not ask the operator to repeat the investigation.

PHASE B — AUDIT CURRENT REELSEC

Inspect:
tools/reelsec/reelsec.py
tools/reelsec/bootstrap-run.sh
runtime probe generation
preflight
campaign orchestration
tests
publication

PHASE C — PRODUCE ARCHITECTURE PLAN

Before edits provide:
- current architecture map;
- backend insertion points;
- capability model;
- state machine;
- test plan;
- rollback plan.

PHASE D — IMPLEMENT ENVIRONMENT RESOLVER

First engineering target:

Detect:
- Java
- ADB
- Apktool wrappers
- standalone Apktool
- Frida
- Frida version
- Gadget capability
- device
- ABI
- signing tools
- zipalign
- Smali tooling

Distinguish:

AVAILABLE

USABLE

BROKEN

MISSING

BLOCKED

PHASE E — APK BACKEND

Implement automatic fallback.

PHASE F — RUNTIME/GADGET BACKEND

Implement jailed Android detection and Gadget workflow.

PHASE G — END-TO-END CAMPAIGN

Only after the above.

---

# 32. IMPORTANT DO-NOT-RUN ACTIONS

Do NOT:

git reset --hard

git clean -fd

delete analysis/

overwrite original.apk

blindly install modified APK

download an unverified Gadget

claim runtime proof from static pointers

claim screenshot blocking from the target function alone

claim CI executed when no CI status exists

claim original-runtime proof from an instrumented APK

---

# 33. EXISTING IMPORTANT COMMITS

d9773a20e4d78019084af0784ec1df1a2f3eec8a
Exact runtime environment blocker reporting.

66250e6d3d9a671e1bf0269933729b1b0177624a
Constructor provenance and vtable address-point correction.

2794a0444ea1a0b9bf3dec0fdcc97a45d817658f
Proof matrix update.

bd265318d620b91612604ee9e0c0321535498a2c
ReelSec 2.2.0:
- target provenance audit
- runtime preflight
- JNI exclusion
- campaign schema
- publication artifacts

2879158ee9914f2bb34a189703380a73b311dd69
Widened JNI lifecycle detection.

6d07efe041c0a9d85ae30c59acd01ed8c24df870
Automatic Debian/PRoot Frida fallback.

b64b9fe0066e7a81bc29f24b0d8dc40f8626e3c9
Runtime ADB/Frida client resolution.

1df424b9de47b08e1868dfc84cfa6cfbd1b4c72f
Frida 17.x launcher fix.

b6ee0ece2d54233d2f6dc3b6b08b6ac80cb35a24
Jailed Android Gadget classification.

d49a23dde9e3520cb4e7d7d558d6446f43f09b6d
Gadget classification regression test.

---

# 34. FINAL HANDOVER STATEMENT

The investigation is NOT COMPLETE.

What is proven:

A real static native vtable relationship exists:

0x717e60
+
0x108
=
0x717f68
->
0x27a510

The target native function exists and is associated with RTTI:

N6Cicada17mediaCodecDecoderE

The runtime environment is currently capable of reaching the Android device through ADB and Frida.

The runtime blocker is specifically:

FRIDA_GADGET_REQUIRED

What is NOT proven:

- target executes in original APK;
- target blocks screenshots;
- target performs security enforcement;
- target is the causal mechanism behind screenshot behavior.

The next engineering milestone is therefore:

REELSEC 3.0 AUTONOMOUS TOOLING

The goal is to make ReelSec itself discover and manage the entire analysis/runtime toolchain rather than making the operator act as the missing orchestration layer.

The next agent must begin with architecture audit and backend/capability design, not with another manual Apktool command.

END OF HANDOVER
