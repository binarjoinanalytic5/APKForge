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

## Phone / Termux validation — 2026-10-06 23:01 — decode collision corrected

The first full campaign reached the environment resolver successfully, selected the standalone Apktool Java-classpath backend, and queried the connected ADB device successfully. The decode stage itself returned non-zero because the requested `decoded-apk` directory already existed; Apktool correctly refused to reuse it.

The old campaign behavior then fell back to the repository's pre-existing `apktool-src` tree. That fallback was unsafe for campaign provenance because it could make a report look like it analyzed `original.apk` while actually analyzing a previously prepared tree. The resulting run is therefore treated as a historical diagnostic, not as a valid decoded-APK campaign proof.

ReelSec `main` now:
- gives default campaign output directories a process-specific suffix to avoid same-second report collisions;
- refuses to overwrite non-empty decode directories;
- fails closed with `BLOCKED_DECODE_FAILED` when campaign decoding is unavailable;
- explicitly records `NO_REPOSITORY_ROOT_FALLBACK`;
- binds the Java/screen audit and runtime probe to the decoded campaign root when decode succeeds;
- records target-relative path and target SHA-256 in input provenance;
- treats a non-zero Apktool build return code as build failure instead of validating a potentially stale artifact;
- normalizes several JSON/text newline writers that had been emitting literal backslash sequences.

The previous campaign remains useful as a capability snapshot only: ADB was usable, Apktool standalone was selected, Frida connected but external spawn was blocked by jailed-Android restrictions, and the static data-flow count remained `473` candidates with `0` proven target data-flow paths.

## Next gate

The next run must produce a genuine `DECODED` result and `READY` inventory before any native target analysis is accepted. After that, the engineering sequence is: controlled telemetry mutation -> successful isolated build -> signing -> guarded deployment -> Frida Gadget observation/event ingestion -> target/vtable runtime validation -> bounded behavioral correlation. No instrumented observation will be promoted to original-APK runtime proof.
## Corrective runtime-campaign architecture — 2026-10-06 23:xx

ReelSec main now contains a second, explicitly labeled APK-content fallback:

`Apktool decode -> RAW_APK_ZIP_EXTRACTION -> native/static-only analysis`

The raw path uses Python ZIP extraction with path-traversal checks. It is not a decoded Smali tree and is never represented as `READY`; its inventory state is `READY_NATIVE_ONLY`. Therefore the native target can be analyzed from the supplied APK without pretending resource/Smali decoding succeeded, while instrumentation/build remains blocked until a real decoded tree exists.

The campaign now also propagates `main()` return codes via `SystemExit`, so a campaign blocker is visible to the bootstrap caller instead of being silently reported as exit 0.

Latest source commits:

- 1f20d754019e776221d541633bf8107438ac24cf — safe raw APK fallback + propagated campaign exit status.
- bcecd34ad55a75d4cb65575f42a82a30873fbdb5 — bootstrap entrypoint status documentation.

Source verification after the patch found no remaining known literal source-newline corruption in `reelsec.py`, and the entrypoint ends with `raise SystemExit(main())`.

The next phone run should therefore either:

`DECODED + READY` — continue to full Smali/native instrumentation pipeline;

or:

`DECODE_FAILED_RAW_FALLBACK + READY_NATIVE_ONLY` — continue honest native/static analysis while keeping instrumentation/build gated.

Only a real decoded tree can unlock the SecShell instrumentation/build stages.
## Live campaign UX — 2026-10-06

ReelSec campaign execution now records and renders live stage state rather than emitting only final key/value lines. The campaign has a 14-stage progress model with RUNNING and terminal PASS/FAIL/BLOCKED/SKIP states, persisted to PROGRESS.json.

The UI intentionally distinguishes a failed Apktool decode from a successful raw ZIP fallback: the decode stage remains FAIL while the raw/native analysis path may continue under READY_NATIVE_ONLY.

The aggregate terminal state is COMPLETED or COMPLETED_WITH_ISSUES for a completed campaign, and BLOCKED for an early campaign gate failure.

The latest UI correctness fix also repaired the campaign-blocker indentation defect that previously produced an IndentationError before progress initialization.

Latest ReelSec source commit: 25a42787ac07541ffaf0252ede1516b03d536d9f.
## Professional campaign status semantics — latest

Live progress is now rendered before and after each major stage. The progress renderer persists stage records in PROGRESS.json and the terminal aggregate distinguishes COMPLETED from COMPLETED_WITH_ISSUES.

The native/raw campaign run on 2026-10-06 proved the input binding for the supplied APK: input SHA-256 e67f2a69a108e5fb36f98eb6ca5fdd1030872f43d216b4163fb3e7c999deb278, raw extraction of 3885 files, one DEX, and 50 native libraries. The target lib/arm64-v8a/libsaasCorePlayer.so was inside the raw extraction root and hashed a3b0c3fdc0817158cbbfaadb71fbcd608fe9835280bbf1defcb36c60090900e4.

The same run exposed a runtime-discovery edge case: AndroidManifest.xml from the raw APK path is binary AXML, so text-only package discovery returned package_manifest missing. ReelSec main now contains an internal binary AXML string-pool/start-element parser and can recover the manifest package without an external aapt dependency.

The CLI now prints STAGE_SUMMARY=PASS:<n> FAIL:<n> BLOCKED:<n> SKIP:<n> and returns exit code 2 for COMPLETED_WITH_ISSUES while preserving the generated report. A clean COMPLETED campaign returns 0.

Latest source commit: 065d5adafe35299ba1178721136828b6992c8bfb.
## Apktool orchestration root-cause correction — 2026-10-06

The 23:27 campaign proved the live progress UX works, but also exposed why every decode attempt was failing: ReelSec created the `decoded-apk` destination before invoking Apktool. Apktool 2.7 then correctly rejected the already-existing destination.

This has now been corrected in `run_apktool_decode`: ReelSec only creates the parent directory and lets Apktool create the destination itself. A non-empty pre-existing destination is still refused, preserving prior evidence. Regression tests were added for both behaviors.

Latest source commit: 8fc7dbf73ffcc94d024603336abe89a82d36f135.
Regression-test commit: 21fd138d491344ae3c350cc89b85a431f87ffce7.

The next campaign run is therefore the first meaningful test of the actual Apktool decode path on `original.apk`. Expected possibilities:

`DECODED` -> continue to real Smali inventory and SecShell instrumentation;
`DECODE_FAILED_RAW_FALLBACK` -> Apktool has a genuine compatibility/input problem, and the raw fallback becomes the honest native-only path.

The previous raw-only run also showed 3885 extracted files, one DEX, and 50 native libraries bound to the supplied APK SHA-256. Runtime package discovery remains enhanced by binary AXML parsing plus an installed SDK-tool fallback.
## Long-operation observability correction — 2026-10-06

The 23:32 phone run exposed a UX gap: Apktool remained at `APK decode RUNNING` with no terminal output for more than five minutes. This did not prove a crash; the command wrapper buffered child output until process completion, so a live process looked identical to a hang.

ReelSec main now includes `run_with_heartbeat()` for long operations. Apktool decode writes its live output to an isolated log while ReelSec emits a 10-second heartbeat containing elapsed time, process liveness, and log size. The CLI therefore shows ongoing activity until completion, failure, or the 300-second timeout.

The progress renderer also computes percentage from completed stages, not from the stage currently running.

Latest source commit: 7f621067d11f2dce22997259cfcea83d11a0bb91.

Next validation: rerun the campaign. During APK decode there should now be periodic `[apktool] RUNNING elapsed=... process=alive ...` lines. A 300-second timeout will become an explicit failure instead of a silent wait.
## Measured in-stage progress — 2026-10-06

The phone run at 23:40 demonstrated that the long Apktool operation was alive: its log grew from 18,804 bytes at 10 seconds to 451,200 bytes at 220 seconds. The limitation was that the top-level percentage remained at the stage boundary, so the operator could not see progress inside stage 4.

ReelSec now distinguishes `overall campaign progress` from `stage progress`. For Apktool decode, stage progress is estimated from observed Apktool milestones and, during Baksmaling, from the DEX `class_defs_size` compared with generated Smali class files. The overall bar interpolates between completed stages using this measured stage estimate.

Example heartbeat shape:

`[#########-------------------] 31.4% 04/14 APK decode RUNNING elapsed=220s stage=64% phase=BAKSMALI detail=baksmali 4360/6730 classes ETA=...`

When an ETA cannot be derived safely, ReelSec reports `ETA=unknown` rather than inventing a time. Live progress is also persisted into `PROGRESS.json` with `current_progress_percent`, `current_phase`, `current_detail`, and `current_eta_seconds`.

Regression test added: `tools/reelsec/test_progress_estimate.py` (commit `2c1d212dec4eb63fc248c8b79770f37fbe308377`).

Latest source fix for measured progress: `1a8ca8d222cfe83e33545267d604d125bd9a211c`.

## Decode liveness hardening — 2026-10-06

The latest phone run confirms the measured progress path is active, but Apktool can remain on a single coarse milestone (`MANIFEST`) for a long time. ReelSec therefore does not invent a finer percentage when Apktool exposes no reliable sub-work unit. During long phases the heartbeat now reports process activity from Linux `/proc/<pid>/stat` CPU jiffies plus log-byte deltas, and persists that telemetry in `PROGRESS.json` as `current_activity` and `current_log_delta_bytes`.

The Apktool timeout was raised from 300s to 900s by default, with `REELSEC_APKTOOL_TIMEOUT` available as a per-run override. This prevents a slow but active decode from being misclassified as a failure solely because it crossed five minutes. The estimate remains explicitly separate from measured class-output progress during Baksmaling.

Relevant commits: `d240cc3e2344ae4240734fa237eb444aefaa0578` (source) and `46f1cfc004be9dfc70379ba14f0316daa0a2bc4f` (regression test).


## Decode Recovery — 2026-10-06

The campaign exposed a second, distinct decode failure: full Apktool resource decoding can spend the entire timeout in the resource phase and then force ReelSec into RAW-only analysis. RAW extraction is insufficient for the SecShell instrumentation path because it does not produce Smali.

ReelSec now retries a timed-out/failed full decode with a real Apktool decode using `-r` (resource decoding disabled) into a separate isolated `*-no-res` tree. This recovery is accepted only when a decoded `AndroidManifest.xml` and at least one `smali*` root are present. The tree is explicitly marked `DECODED_NO_RES`, `instrumentable_smali=true`, and `resources_decoded=false`; it is not mislabeled as a full resource decode.

Regression coverage was added for the full-decode-fails / no-res-recovery path.

Fix commit: `dbe0d8a33dd14d60e16553d915662cc3721160cf`
Regression-test commit: `2d0305f75e600a33391210f6dc46bd2cd3c334b7`


## Decode Strategy Correction — 2026-10-07

The first recovery implementation exposed a state-machine bug: `run_apktool_decode()` correctly returned `DECODED_NO_RES`, but campaign orchestration only accepted `DECODED`, causing a false blocked campaign. This is fixed: `DECODED_NO_RES` is now a valid instrumentable analysis root and is carried forward with explicit `resources_decoded=false` metadata.

The campaign default is now `REELSEC_DECODE_STRATEGY=no-res-first`. This avoids waiting through the known slow resource-decoding phase when the objective is SecShell/Smali instrumentation. The full resource decode remains available with `REELSEC_DECODE_STRATEGY=full-first`. Full decode and recovery timeouts are independently configurable through `REELSEC_APKTOOL_FULL_TIMEOUT` and `REELSEC_APKTOOL_RECOVERY_TIMEOUT`.

Fix commits: `3b9cfcb30ccae3df430b9ad80ba895ab3abf6b73`, `e49a97cd198441f673aaea2c435a45aa56dfbccb`
Regression coverage: `4d5e6b2a753494afc5acb4d2e9e3e9edd8699011`


## Instrumentation Execution Path — 2026-10-07

After the decode-state fix, Stage 7 was found to be copy-only: the campaign prepared an isolated tree but did not actually apply the planned SecShell probe. ReelSec now applies the telemetry probe to the copied `AW.smali` target before build. The probe reserves two local registers and emits a `Log.i` marker after the SecShell `System.loadLibrary` call. It is explicitly telemetry-only and does not disable or alter a security decision.

The original APK and decoded source remain untouched. The copied manifest records the mutation and target path; Stage 8 accepts the resulting `MUTATED` state.

Implementation commits: `e79f52519b3bfa1025ca7cda194decf8659db72f`, `eb7ff8336dde87855be693fa21387e6c90c3c27f`
Test-fixture correction: `83fa850a21ff3a73748faff57736adcab1bea200`


## SecShell Smali Anchor Parser Fix — 2026-10-07

The first no-res campaign reached a valid `READY` inventory but incorrectly blocked Stage 6 because the detector searched for the Java source spelling `System.loadLibrary` inside Smali. The actual Smali form is `Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`. The detector and mutation backend now parse that Smali invocation generically, independent of the source register name, and record the exact matched invoke as evidence.

Implementation: `58653f9c818ad5bc4f6d6bd48f0ab436124804eb`, `9a5f6bbebbe328fdddaa1b066d20d7332c53cb0d`
Regression coverage: `2434a4ae97da0e903c4757a79c7718162ecdf11d`


## Structural SecShell Discovery — 2026-10-07

The next campaign run showed `DECODED_NO_RES -> READY` correctly, but Stage 6 still blocked because discovery required a literal `AW.smali` filename. Historical evidence confirms the SecShell Application class exists, but filename-based discovery is unnecessarily brittle.

ReelSec now scans every `smali*` root and identifies candidates by structure/content: Android `Application` superclass, `attachBaseContext`, and a nearby `System.loadLibrary` call associated with `SecShell`. Candidate metadata records the class name, path, loadLibrary line, score, and discovery mode. The campaign no longer assumes the file is named `AW.smali`.

The telemetry probe was also hardened to locate the actual `System.loadLibrary` instruction register dynamically and reserve two safe local registers before inserting the Log.i marker.

Latest implementation commits: `9abc0a6c55a4ca0079691900d76fb9c68d66c6bc0`, `75caa4633eb8cc3569ec0cde1cf6e912fe75301f`, `df1f4cf4d8c98f604894ff21dfd8193b398af426`, `d84b5689d2f40991efd0cbd077f480a8e1ca602b`.
Regression coverage: `9bfeb10421decd959f5383713a15ffd6d9acc33b`, `240c3a5376dc75069954ff35ec2afb54a82291f1`.


## Smali Anchor Detection Root Cause — 2026-10-07

The 00:35 campaign confirmed that the no-resource decode path is healthy: Stage 04 = PASS and Stage 05 = READY. Stage 06 then blocked because the detector searched decoded Smali for the Java spelling `System.loadLibrary`. The actual application Smali contains the descriptor form `Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`, e.g. the known AW.attachBaseContext path.

The detector now matches the real Smali `invoke-static {registers}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V` form and records the matched registers. The mutation backend uses the same parser. Probe register allocation is method-local so a multi-method AW class cannot have a different method's register declaration modified accidentally.

Implementation: `58653f9c818ad5bc4f6d6bd48f0ab436124804eb`, `9a5f6bbebbe328fdddaa1b066d20d7332c53cb0d`, `584e8f86cc83d5226c4e2cf8a10d9c9cffa535cc`, `6bb958fb406b8b0d952936ca63c8eb17e36ab679`
Tests: `2434a4ae97da0e903c4757a79c7718162ecdf11d`, `1aca1b7bf6f94fc3dc5c5edb8951d3e4b8e1a439`
