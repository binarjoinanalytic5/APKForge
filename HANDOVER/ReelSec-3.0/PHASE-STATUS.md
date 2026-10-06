# ReelSec 3.0 — Phase Status

## Current pipeline

`campaign APK -> SHA-256 -> capability matrix -> Apktool backend -> isolated decode -> decode validation -> decoded inventory -> decoded target -> provenance -> static analysis -> proof gate -> SecShell instrumentation plan`

## Instrumentation stage

A controlled instrumentation backend is now present.

It deliberately separates planning, mutation, build/signing, deployment, runtime observation, and proof.

The campaign emits `INSTRUMENTATION-PLAN.json`. The plan is non-mutating and records whether the known SecShell `AW.smali` / `System.loadLibrary("SecShell")` anchor was found inside the decoded APK.

A Termux preflight helper records ADB/Frida capability and explicitly marks whether Frida Gadget is required. It does not install software or alter the original APK.

## Termux testing contract

`original.apk (immutable) -> decode -> inventory -> instrumentation plan -> build instrumented copy -> sign/verify -> install on test device -> observe -> classify evidence`

No runtime result from an instrumented build may be labeled as original-APK runtime proof.

## Verification

The repository CI definition includes the instrumentation backend tests, but GitHub has not exposed a workflow run/status for the branch head. Tests remain pending actual execution.

## Completed in this stage

The campaign can now prepare an isolated decoded working tree under the campaign output. The builder refuses to overwrite an existing work tree and records its source root and manifest hash in `INSTRUMENTED-COPY-MANIFEST.json`. The original decoded tree remains untouched.

The actual mutation helper is deliberately separate from the copy operation and is not invoked automatically yet. This keeps copy creation, mutation, build/signing, and runtime proof as independent evidence gates.

## Completed in this stage

A signing and verification gate is now present for the isolated build artifact. It requires an explicit `apksigner` capability and an explicit test keystore via `REELSEC_TEST_KEYSTORE`; it never signs `original.apk`. The signed APK is a separate artifact and receives its own SHA-256 identity record in `SIGN-VERIFY.json`.

If the signer or test keystore is unavailable, the campaign records `BLOCKED_OR_FAILED` rather than treating the unsigned APK as ready for device deployment.

## Completed in this stage

A guarded ADB deployment gate is now present. Deployment requires a successfully verified signed artifact and an explicit `REELSEC_TEST_DEVICE` serial. The gate performs an ADB state check before installation and records the artifact SHA-256 and install command in `ADB-DEPLOY.json`.

The gate has no path that installs `original.apk`; it only accepts the signed artifact produced by the signing stage.

## Completed in this stage

A passive runtime evidence capture layer is now connected to the campaign. It records ADB state, package path, process observation, and a bounded logcat snapshot, all bound to the signed artifact SHA-256 and explicit device serial.

Captured evidence is classified as `OBSERVED` with `causal_proof=false`. This is intentional: a logcat/process snapshot alone does not prove that the target native function executed or caused screenshot behavior.

## Next engineering gate

Frida Gadget observation planning is now present for the instrumented artifact. Target runtime observations validate module + offset, and vtable dispatch observations validate the complete tuple `vtable=0x717e60`, `slot=0x108`, `target=0x27a510`. These remain observational evidence and do not claim causality.

## Next engineering gate

Connect actual Gadget hook-event ingestion to these validators, then correlate target/vtable events with a bounded behavioral observation. Only the instrumented artifact may receive this observation hook; original-APK proof remains a separate evidence class.

## Phone / Termux validation — 2026-10-06

The Android test environment was validated on a Samsung SM-N986U running Android 13 / SDK 33 / arm64-v8a.

Validated capabilities:
- Python 3.14.6: usable.
- Java 21.0.12 in Termux: usable.
- ADB 1.0.41 / Android platform-tools 37.0.0-android: usable; a test device is connected over ADB TCP.
- Apktool 2.7.0-dirty: usable through the standalone Java classpath backend in the Ubuntu PRoot rootfs.
- `proot-distro`: usable with Debian and Ubuntu containers.
- Frida 17.22.2: available in Debian PRoot. Direct jailed-Android spawn previously classified as `FRIDA_GADGET_REQUIRED`.
- `apksigner`, `zipalign`, `jarsigner`, `unzip`: present. `zip` is not present.
- `original.apk` remains immutable.

The phone checkout itself is intentionally dirty with investigation outputs and local edits. The remote bootstrap path was therefore hardened so it can materialize the complete remote ReelSec Python package into a temporary staging tree and execute it without stashing, resetting, rebasing, merging, or overwriting the local investigation tree.

## Source synchronization correction

The phone had been pinned to a report branch commit where only the legacy `reelsec.py` existed locally. ReelSec 3.0 components were present on PR #5 but not on the phone's local refs.

PR #5 was merged into `main` at `6907c95fe42273e40da93953be7e89af99e58815` after:
- fixing the proof-gate test's missing `UNPROVEN` import;
- adding final instrumented-proof classifier coverage;
- simplifying CI discovery to compile all ReelSec Python modules and discover all `test_*.py` tests;
- fixing dirty-tree bootstrap staging so sibling ReelSec modules resolve correctly.

The subsequent bootstrap fix is committed on `main` at `d9d9f749f73becb4a32b0c057dfb4edeebb61e71`.

## Immediate phone gate

Run the remote bootstrap entrypoint from the current checkout:

`cd ~/apk-lab/ReelShort-v4.2.00 && git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk`

This route is expected to preserve local investigation changes while executing the current `main` ReelSec 3.0 package. The first required evidence gates are capability resolution, Apktool backend selection, isolated decode, decoded inventory, and input provenance. Build/sign/install/runtime stages remain independently gated by their required explicit test configuration.

