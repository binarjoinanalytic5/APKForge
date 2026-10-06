# ReelSec 3.0 — Phase Status

## Current state

The capability/decode gate is implemented on branch `reelsec-3.0-capability-integration`.

Pipeline now:

`campaign APK -> SHA-256 -> capability matrix -> Apktool backend selection -> isolated decode -> decode validation -> decoded input inventory -> decoded native target selection -> existing ELF analysis`

## Implemented

- Capability resolver distinguishes usable tools from mere command presence.
- Apktool backend selection supports CLI and standalone Java classpath fallback.
- Campaign mode decodes into an isolated `decoded-apk/` directory.
- Decode logs are retained as `reelsec-apktool.log`.
- Decode states are explicit: `DECODED`, `FAILED`, `FAILED_VALIDATION`, `BLOCKED`.
- `DECODED-INPUT-INVENTORY.json` records manifest, Smali roots/counts, native libraries, and DEX files.
- Campaign analysis now prefers native ELF files extracted from the decoded APK; repository-root analysis remains the fallback when decoded input is unavailable.
- Regression coverage was added for CLI/standalone backend selection and decoded inventory, including multidex Smali roots.
- CI workflow includes the new regression test.

## Verification limitation

GitHub currently reports no workflow runs and no status checks for the latest branch commit. Therefore tests are **not claimed as passed** yet.

## Security proof boundary

Nothing in this phase proves screenshot blocking. The existing conservative conclusions remain unchanged:

- native target `0x27a510` is not proven to execute on the original APK;
- `0x717f68` / `+0x108` must not be treated as a C++ vtable slot solely from the observed JNI pattern;
- `NO_SECURITY_OPERATION_OBSERVED` remains the body-local classification;
- runtime proof remains blocked by the jailed-Android Frida/Gadget condition until an appropriate instrumentation backend exists.

## Next engineering gate

Feed the decoded Smali/native inventory into the existing static-analysis stages with explicit source provenance, then build the controlled instrumentation backend. Do not merge or relabel runtime conclusions until executable evidence exists.
