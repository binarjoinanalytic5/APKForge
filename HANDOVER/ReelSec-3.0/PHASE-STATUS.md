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

## Completed in this stage — 2026-10-07 (evidence platform)

Capture detector upgraded to schema `capture-detection-3`: APK/ZIP container
input mode (in-memory, read-only), ELF `.dynsym` symbol extraction with
import/export distinction, third-party noise classification (`UNRELATED`
downstream), and anti-tamper family tagging.

New `evidence_report.py` (schema `evidence-report-1`) produces strictly
tiered findings (CONFIRMED / INDICATOR / NOT_PROVEN / UNRELATED), an evidence
graph linking static, native and runtime findings, and a four-link causal
chain gate (mechanism identified → provenance → runtime execution →
capture-block behavior). A causal proof is emitted only when every link is
CONFIRMED. The campaign emits `EVIDENCE-REPORT.json/.md` after Stage 12.

Suite: 94/94 via `python -m unittest discover -s tools/reelsec`.
Real-run artifacts: `analysis/evidence-platform-20261007/` — verdict
`PACKED_STATIC_ANALYSIS_LIMITED`, causal chain `NOT_PROVEN` (L1 CONFIRMED,
L2–L4 NOT_PROVEN). Handover: `حقيبة التسليم/REELSEC-EVIDENCE-PLATFORM-2026-10-07.md`.

## Completed in this stage — 2026-10-07 (runtime diagnostics)

Runtime probe rebuilt around an auditable lifecycle: staged chain
(ADB -> PACKAGE -> PROCESS -> MODULE -> PROBE -> TARGET) with per-stage
status/timestamp/reason_code/source, reason codes A-G, and a corrected
probe script (the previous Process.attachModuleObserver call is not a
Frida API and silently killed the script, collapsing all failures into one
opaque timeout). Install diagnostics (preflight + failure classification +
post-install verification) and a guarded opt-in L4 behavioral capture
producer were added. Evidence gate unchanged: SCREENSHOT_BLOCKING remains
NOT_PROVEN. Suite: 128/128. Handover:
حقيبة التسليم/REELSEC-RUNTIME-DIAGNOSTICS-2026-10-07.md.

## 2026-10-07 — Native Crash Gate (artifact runtime integrity)

Device evidence established repeated startup crashes of the instrumented
test artifact (exit-info reason=5 APP CRASH(NATIVE) status=6, reason=4
APP CRASH(EXCEPTION), process death after MainActivity). Root-fix mandate
implemented: PROCESS_HEALTH_GATE before Frida (ApplicationExitInfo
delta + crash logcat + bounded ps), automatic crash classification
(NATIVE_CRASH/JAVA_EXCEPTION/PROCESS_KILLED/ANR/STARTUP_FAILURE/...),
non-root crash-cause identification (backtrace frames / abort message /
maps / frida pre-crash; CRASH_CAUSE_UNKNOWN never invented), gated
baseline-vs-instrumented comparison (INSTRUMENTATION_REGRESSION_CONFIRMED
vs BASELINE_RUNTIME_FAILURE), Artifact Integrity Gate pre-install,
INSTRUMENTATION-IMPACT.json linkage, RUNTIME-HEALTH/BASELINE-RUNTIME/
RUNTIME-VERDICT artifacts, and evidence-gate enforcement
(RUNTIME_VALIDITY = BLOCKED_BY_ARTIFACT_CRASH; L3/L4 unconfirmable during
artifact crash). 10-scenario regression matrix covered; no scenario may
degenerate into a misleading RUNTIME_PROBE_TIMEOUT. Suite: 166/166.
Scientific verdict unchanged: SCREENSHOT_BLOCKING = NOT_PROVEN.

## 2026-10-07 — Autonomous Evidence Platform + Safety-by-Design

Incident recorded: 2026-10-07 baseline round executed a destructive
uninstall under a bare env flag — filed as SAFETY/DESIGN FAILURE —
DESTRUCTIVE BASELINE UNINSTALL (analysis/campaigns/2026-10-07T20-06-46-
incident/), NOT a ReelShort failure; scientific verdict unchanged
(SCREENSHOT_BLOCKING = NOT_PROVEN). Architectural remediation implemented:
safety_gate.py (deny-by-default in code; hash-bound exact-match
time-bounded authorization documents; nine-step chain; audited blocks),
orchestrator.py (doctor blocks the platform on blanket destructive flags;
autonomous pipeline: campaign -> collectors -> aggregator -> git
publisher -> FINAL-VERDICT/FINAL-REPORT with PUBLISH_COMMIT),
collectors.py (10 uniform collector-1 envelopes), and all legacy uninstall
paths rerouted through the gate. Suite: 187/187, including 20 safety
regression tests that make the incident scenario structurally impossible.

## 2026-10-07 — Crash Collector Verification + Original-vs-Instrumented
## Crash Comparison (crash-comparison-1)

Verification round (commit bf5a80b, code-only, no campaign, no destructive
op): CRASH-ARTIFACT.json is written by write_runtime_probe (reelsec.py) and
BASELINE-CRASH-ARTIFACT.json by the gated run_baseline_runtime; every
collector-chain device command is read-only (dumpsys exit-info, monkey
launch, ps, logcat -b crash, /proc maps, pm path) — the only uninstall in
the flow goes through safety_gate with a hash-bound authorization
document. Two regression tests simulate the observed device crash
(SIGABRT, uid 10285/9510285, pid 14210, users 0/95, base.apk + 0x31e10)
against a crafted STORED-entry artifact and assert RESOLVED offset math,
PID/UID/APK-path/SHA bindings, and the no-cause-labeling guard.

New operational fact: BOTH the original and the instrumented artifact
crash on the device. Attribution rule hardened: a crash present in both
builds must NOT be attributed to instrumentation. Implemented
build_crash_comparison (crash-comparison-1): the two sides are compared
but never merged — each keeps its own package/user/UID/PID/APK-path/
artifact-SHA/timing bindings and its own independent base.apk+0x… offset
resolution (different builds; identity never assumed). Explicit statuses:
BOTH_CRASH / INSTRUMENTED_ONLY_CRASH / ORIGINAL_ONLY_CRASH; explicit
question answers (both SIGABRT? same fault location? same startup stage?
abort message captured on either side? does each artifact's own file
contain the offset?); attribution guards (BOTH_CRASH =>
instrumentation_regression NOT_ESTABLISHED, common cause device/OS/ROM or
app itself; INSTRUMENTED_ONLY => SUSPECTED_NOT_PROVEN). The comparison is
written automatically by both campaign rounds into CRASH-COMPARISON.json
and surfaced as CRASH_COMPARISON in RUNTIME-VERDICT.json. Suite: 213/213.
No campaign was run; no device-destructive operation was performed.
Scientific verdict unchanged: SCREENSHOT_BLOCKING = NOT_PROVEN.

## 2026-10-07 — Non-Destructive Original Baseline (no automatic uninstall)

Device fact: the baseline round never executed (CRASH-COMPARISON showed
Original: null) because the old design unconditionally routed a
pre-baseline uninstall through safety_gate; without a hash-bound
authorization document the round returned SAFETY_BLOCKED and the original
was never assessed.

Redesign: the baseline is NON-DESTRUCTIVE BY DESIGN. The test-signed
original and the instrumented artifact share the same isolated test
keystore, so the round now replace-installs the original via
'adb install -r' — no uninstall, no clear-data, no other package touched —
observes the startup, writes BASELINE-CRASH-ARTIFACT.json +
CRASH-COMPARISON.json, and intentionally leaves the original installed
(post_round NONE_NON_DESTRUCTIVE); the deploy stage then replaces it with
the instrumented artifact, also via 'adb install -r'.

Uninstall survives ONLY as an explicit fallback when a
differently-signed build occupies the package slot (replace install fails
with INSTALL_FAILED_UPDATE_INCOMPATIBLE / signature mismatch / version
downgrade): with a hash-bound authorization document
(REELSEC_DESTRUCTIVE_AUTH) the gated uninstall runs through safety_gate
(audited EXECUTED_VERIFIED); without one the round reports
BASELINE_BLOCKED_INCOMPATIBLE_INSTALL and touches nothing — never an
automatic uninstall. REELSEC_ALLOW_TEST_DEVICE_UNINSTALL remains a
doctor-blocking violation, not a solution.

Regression tests (3): baseline runs and produces the original-side crash
artifact + comparison with ZERO destructive commands and NO
authorization; incompatible install without authorization blocks with
nothing attempted and no app launch; incompatible install WITH
authorization falls back to the audited gated uninstall. Suite: 215/215.
No campaign was run. Scientific verdict unchanged:
SCREENSHOT_BLOCKING = NOT_PROVEN.

## 2026-10-07 — Working Control Round (installed original observed in place)

Operational fact: a clean ORIGINAL now runs on the device (installed from
Downloads) and NO destructive authorization will be granted. The
comparison stage was redesigned around a WORKING CONTROL: the currently
installed package is observed exactly where it is — no uninstall, no
clear-data, no re-install, no bypass, no destructive authorization.

New round `run_working_control_round` (working-control-1) collects
automatically, read-only: APK SHA-256 (on-device sha256sum), signing
certificate SHA-256 (dumpsys package), versionName/versionCode,
package/user/UID + installed users, codePath, primaryCpuAbi, then one
bounded observed launch (monkey + ps + ApplicationExitInfo + crash
logcat) yielding process/PID, startup lifetime, SIGABRT fault PC/library
and abort message when captured. `base.apk+0x…` offsets resolve against
the local original ONLY when hash-bound to the installed APK
(local_reference.matches_installed) — never assumed.

Platform order: the control round runs BEFORE any install stage; when
the control was observed (CONTROL_ASSESSED / CONTROL_CRASHED) the
install-based baseline round is SKIPPED
(BASELINE_SKIPPED_WORKING_CONTROL_PRESENT) so nothing is re-installed
over the control. When no package is installed the round launches
nothing and touches nothing (CONTROL_NOT_INSTALLED).

New document COMMON-CAUSE-COMPARISON.json (common-cause-comparison-1),
refreshed by both the control round and the probe round, with explicit
statuses: COMMON_CAUSE_BOTH_CRASH (MUST NOT be attributed to
instrumentation; common cause device/OS/ROM or app itself),
CONTROL_HEALTHY_INSTRUMENTED_CRASH (SUSPECTED_NOT_PROVEN),
CONTROL_ONLY_CRASH, CONTROL_HEALTHY_NO_INSTRUMENTED_EVIDENCE,
COMMON_CAUSE_INCOMPLETE (no claim without a control). RUNTIME-VERDICT.json
gains WORKING_CONTROL + COMMON_CAUSE_COMPARISON fields. Fixed integrity
note: the comparison MUST NOT upgrade SCREENSHOT_BLOCKING — it stays
NOT_PROVEN until the full causal chain is evidenced.

Suite: 230/230 (15 new regression tests: fingerprint completeness, zero
state-changing commands in every control path, hash-bound-only offset
resolution, all five comparison statuses, blanket-flag refusal, skip
logic). No campaign was run; no destructive operation performed.
Scientific verdict unchanged: SCREENSHOT_BLOCKING = NOT_PROVEN.

---

## 2026-10-08 — End-to-End Coherence Round (e2e-coherence-1)

Mission: make `reelsec.py platform ./original.apk` ONE coherent path —
Safety → Device → Original Control → Static → Instrumented Runtime →
A/B Comparison → Evidence Aggregation → Final Verdict → Git Publish —
before any new device run. Fixed root causes across all affected stages;
no old campaign or evidence was modified.

1) FINAL VERDICT AGGREGATION (confirmed bug, campaign
2026-10-07T22-06-53): `_final_verdict_logic` (orchestrator) now reads
WORKING-CONTROL.json + COMMON-CAUSE-COMPARISON.json FIRST. A completed
COMMON_CAUSE_BOTH_CRASH investigation is a VALID campaign:
final_verdict=NOT_PROVEN, runtime_status=COMMON_CAUSE_BOTH_CRASH,
regression_status=NOT_ESTABLISHED (never NOT_COMPARABLE), and the
legacy `ORIGINAL_RUNTIME=NOT_RUN` is recovered from the working control
(CONTROL_CRASHED→CRASH, CONTROL_ASSESSED→PASS). FINAL == RUNTIME ==
COMMON-CAUSE on runtime/regression status (requirement 17).

2) EXPLICIT STATE MACHINE (runtime_health.campaign_state_machine):
SAFETY_BLOCKED / NO_DEVICE / DEVICE_READY / CONTROL_NOT_INSTALLED /
CONTROL_HEALTHY / CONTROL_CRASHED / INSTRUMENTED_NOT_RUN /
INSTRUMENTED_HEALTHY / INSTRUMENTED_CRASHED / COMMON_CAUSE_BOTH_CRASH /
INSTRUMENTATION_ONLY_CRASH / ORIGINAL_ONLY_CRASH / COMPARISON_INCOMPLETE
/ CAUSAL_CHAIN_INCOMPLETE / PROVEN — every transition records a reason;
surfaced as CAMPAIGN_STATE in RUNTIME-VERDICT.json and
campaign_state(+transitions) in FINAL-VERDICT.json. No scattered
booleans decide the pipeline state anymore.

3) UNIFIED PER-SIDE SCHEMA: WORKING CONTROL and INSTRUMENTED sides now
share ONE field set (package, artifact_type, artifact_sha256,
installed_path, uid/uids/users, version, ABI, pids, startup,
lifetime_ms, fatal_signal, fault_library, fault_pc,
abort_message_present, exit_reason, logcat_evidence_lines). The
instrumented health gate now collects the same read-only identity
(dumpsys package + installed sha256sum). Unavailable ⇒ null, never
fabricated.

4) CRASH EVIDENCE: tombstone-only evidence (fatal_lines /
package_matched_lines, no ApplicationExitInfo entry) no longer collapses
to crash_instances=[] — a structured instance is synthesized from what
the tombstone actually contains and the record is classified
EVIDENCE_PRESENT_BUT_INSTANCE_INCOMPLETE (UID/user stay null); raw
evidence lines are preserved and incomplete parsing never upgrades a
scientific verdict.

5) APK OFFSET: an offset resolves ONLY when the installed APK SHA equals
the local artifact SHA (verified in assess_startup/build_crash_artifact);
mismatch ⇒ UNRESOLVED with reason. No nearest-symbol identity.

6) NEXT_ACTION PURGE: the legacy recommendation "run the gated baseline
round (REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1)" was removed from
runtime_verdict and the adb_deploy SIGNATURE_MISMATCH hint; the
aggregator additionally sanitizes any stale destructive NEXT_ACTION
(defense in depth). Destructive operations stay deny-by-default; the
hash-bound authorization document is the only path and is never
suggested automatically.

7) EXIT CODES: campaign exit now splits infrastructure failure (2:
NO_ONLINE_ANDROID_DEVICE, package unresolved, decode/artifact invalid)
from scientific incomplete (3: crash without original-side comparison,
no evidence report) from a VALID COMPLETED INVESTIGATION (0 — including
COMMON_CAUSE_BOTH_CRASH: an app crash with successful collection +
comparison is a scientific finding, never CAMPAIGN_EXIT_2).
run_platform maps these to COMPLETED / SCIENTIFIC_INCOMPLETE /
INFRASTRUCTURE_FAILURE.

8) PUBLISHER: PUSH_FAILED/PUBLISH_FAILED is recorded as
PUBLISH_FAILURE (infrastructure only; scientific and runtime verdicts
unaffected) — verdict fields are computed before publishing and are
never altered by a push result.

Scientific gate untouched: L1=CONFIRMED, L2=INDICATOR, L3/L4=NOT_PROVEN,
SCREENSHOT_BLOCKING=NOT_PROVEN; evidence_report.py L1–L4 logic unchanged.
No destructive operation anywhere; original.apk unmodified; no old
campaign rewritten.

Suite: 258/258 (28 new hermetic regression tests: state machine paths,
crash-instance synthesis, offset SHA binding, verdict aggregation for
both-crash/control-only/no-comparison, destructive-NEXT_ACTION purge,
exit-code classification, platform exit mapping, publisher failure
classification). No campaign was run in this round.

## 2026-10-08 — timeline-truth-1: session-bound crash attribution + real-timeline state machine

Field correction (user-verified) for campaign 2026-10-07T23-43-38: the
original ran NORMALLY after the platform installed it; crashes appeared
only after the instrumented install/run. Artifact forensics confirmed the
user and exposed the defect:

* BASELINE round 23:44:44–55 UTC: original (53e49f50…, uid 10813) process
  15683 alive at window exit, ZERO new exit-info entries — yet the health
  gate classified CRASH by attributing tombstone pid 30953 whose fatal
  line is timestamped 21:31 UTC (an EARLIER campaign's instrumented
  crash, hours old). `assess_startup` read the crash ring buffer once
  AFTER the window with no session binding.
* The SAME stale tombstone (pid 30953) had also fabricated
  CONTROL_CRASHED in campaigns 22-06-53 (pid 10332 alive at exit) and
  23-17-31 (pid 22058 alive at exit) — so COMMON_CAUSE_BOTH_CRASH in
  22-06-53 was built on a misattributed original-side crash.
* Instrumented round 23:45:42 UTC: genuine fresh crash (pid 18792,
  SIGABRT libc abort+168) after `install -r` UPDATE replaced the
  original (same package/uid/users [0,95] — replacement, never a dual
  instance; after replacement every launch runs the instrumented build).
* Crashes 23:45:23–29 UTC (pids 17891/18119/18238) fall BETWEEN the two
  observation windows: preserved in evidence, attributed to neither side.

Fixes (runtime_health.py / reelsec.py / orchestrator.py):

1) SESSION-BOUND ATTRIBUTION at collection: pre-launch crash-buffer
   snapshot + post-window diff — only lines that APPEARED after launch
   classify the session (BUFFER_DIFF). Fallbacks when the snapshot is
   unusable: PID_MATCH (tombstone pid observed this session),
   IN_WINDOW_DEATH, NO_PROCESS_OBSERVED. A process alive at window exit
   with zero new exit-info is NEVER crashed by a different pid's
   tombstone. Stale tombstones are preserved in evidence
   (crash_session_binding + raw parse), never deleted.
2) audit_startup_classification / audited_original_side: post-hoc audit
   of RECORDED documents — only an explicit contradiction (logcat-only
   CRASH + alive-at-exit + pid mismatch + no exit-info) is corrected to
   PASS, with annotations; documents are never rewritten.
3) State machine: new real-timeline states ORIGINAL_HEALTHY,
   ORIGINAL_CRASHED, INSTRUMENTED_INSTALLED (CAMPAIGN_STATES 15→18);
   CONTROL_NOT_INSTALLED reason now states it does NOT mean the original
   never ran; audited evidence outranks pre-audit BOTH_CRASH comparison
   documents (INSTRUMENTATION_ONLY_CRASH with audit reason).
4) runtime_verdict: audited views drive ORIGINAL_RUNTIME (+SOURCE),
   comparison recomputed on correction, BOTH_CRASH common-cause
   downgraded to CONTROL_HEALTHY_INSTRUMENTED_CRASH when the
   original-side crash was stale; STARTUP_AUDIT + recorded-status fields.
5) Aggregator: unwraps the device RUNTIME-HEALTH collector envelope
   (latent bug: enveloped startup read as None), corrects legacy
   ORIGINAL_RUNTIME=CRASH from the baseline audit, feeds baseline/deploy
   into the state machine; evidence files untouched.

Verified read-only against the real 23-43-38 artifacts: timeline =
CONTROL_NOT_INSTALLED → ORIGINAL_HEALTHY → INSTRUMENTED_INSTALLED →
INSTRUMENTED_CRASHED → INSTRUMENTATION_ONLY_CRASH;
ORIGINAL_RUNTIME=PASS, REGRESSION_STATUS=INSTRUMENTATION_REGRESSION_
CONFIRMED, runtime proof remains BLOCKED_BY_ARTIFACT_CRASH;
SCREENSHOT_BLOCKING stays NOT_PROVEN. Campaign dir git-clean afterwards.

No uninstall/reinstall anywhere; no evidence deleted; no campaign or
platform run executed this round. Suite: 277/277 (19 new hermetic tests:
stale-tombstone exclusion, BUFFER_DIFF/PID_MATCH binding, audit override
guards, ORIGINAL_HEALTHY→INSTRUMENTED_INSTALLED→INSTRUMENTED_CRASHED
sequence, legacy BOTH_CRASH correction, genuine both-crash preserved).

## 2026-10-08 — test-model-isolation-1: shared-APK replacement model + original-identity binding

Field model confirmed by the user: the dual-app profile is user 95 of the
SAME package (not a separate APK). `adb install -r` therefore REPLACES the
one shared base.apk for ALL users: the original and the instrumented
artifact can never coexist, and "both versions crash after the install"
means every post-replacement launch — on any user — ran the instrumented
build. The correct judgment is: ORIGINAL = HEALTHY (pre-replacement) /
INSTRUMENTED = CRASH (post-replacement); the previous
COMMON_CAUSE_BOTH_CRASH readings were artifacts of that replacement plus
stale crash-buffer attribution (fixed in timeline-truth-1).

Fixes (adb_deploy.py / runtime_health.py / reelsec.py / orchestrator.py):

1) package_state_snapshot + build_install_semantics: READ-ONLY dumpsys
   snapshots BEFORE/AFTER the install (codePath, uid, version, users,
   firstInstallTime/lastUpdateTime) recorded in ADB-DEPLOY.json as
   package_state_before/after + install_semantics
   (REPLACE_SHARED_APK vs FRESH_INSTALL, shared_apk_users, guard text:
   post-replacement crashes on ANY user belong to the NEW artifact and
   are NEVER evidence that the replaced build crashes by itself).
2) Original-identity binding: collect_working_control records
   identity.original_verification (installed bytes must be hash-bound to
   the local original). An unverified control (e.g. a leftover
   instrumented build of the same package) yields
   ORIGINAL_RUNTIME=IDENTITY_UNVERIFIED and the new state
   CONTROL_IDENTITY_UNVERIFIED — it establishes NOTHING about the
   original (no PASS, no CRASH).
3) Verdict/state machine: ORIGINAL_HEALTHY_BEFORE_INSTALL,
   INSTRUMENTED_CRASH_AFTER_INSTALL, REPLACED_SHARED_APK_USERS,
   REPLACEMENT_GUARD fields; INSTRUMENTED_INSTALLED transition names the
   replacement mode and the shared users.
4) Aggregator surfaces the same facts; legacy campaigns (deploy docs
   without install_semantics) degrade to null — never fabricated.

Verified read-only on the real 01-07-35 and 23-43-38 artifacts: both now
aggregate to ORIGINAL_HEALTHY_BEFORE_INSTALL=True,
INSTRUMENTED_CRASH_AFTER_INSTALL=True,
REGRESSION_STATUS=INSTRUMENTATION_REGRESSION_CONFIRMED, states
CONTROL_NOT_INSTALLED → ORIGINAL_HEALTHY → INSTRUMENTED_INSTALLED →
INSTRUMENTED_CRASHED → INSTRUMENTATION_ONLY_CRASH. Evidence untouched.

No uninstall/reinstall; no evidence deleted; no campaign run.
Suite: 285/285 (8 new hermetic tests: snapshot parsing incl. users
[0,95] + lastUpdateTime, replacement semantics, verdict judgment fields,
shared-users transition reason, unverified-identity guard end-to-end,
verified identity still counts, aggregation replacement facts).

## تجربة العزل بدون الأدوات — ٨ أكتوبر ٢٠٢٦

أُضيف مسار تعديل تجريبي صريح (`REELSEC_INSTRUMENT_MODE=no-gadget`) يبني
النسخة المعدلة بدون أي أثر لأدوات الرصد، مع إبقاء علامة القياس وبقية
المراحل كما هي. المسار يرفض التضمين حتى عند طلبه صراحةً، ويفشل مغلقًا
عند كشف أي مكتبة أو إعدادات أو علامة تحميل أو سجل تضمين، ويختم البيان
بالحقول: `GADGET_PRESENT=false` و`GADGET_SOURCE_ABSENT=true` و
`original_apk_untouched=true` و`experiment=INSTRUMENTED_NO_GADGET`، مع
قيد آلي بأن الإسناد السببي يتطلب المقارنة الزمنية.

الحالات الموثقة: `ORIGINAL_HEALTHY_BEFORE_INSTALL` ثم
`INSTRUMENTED_NO_GADGET`، ونتيجة التشغيل تُسجَّل لاحقًا بعد الخطوة
الواحدة على الهاتف. سلامة النسخة بدون الأدوات وحدها لا تثبت سبب
الانهيار قبل المقارنة الزمنية المرتبطة بالجلسة.

لا حملة جديدة ولا تثبيت ولا عمليات مدمرة في هذه الجولة، ولا artifact
مبني هنا؛ البناء يتم على الهاتف.
المجموعة: 295/295 (10 اختبارات انحدار جديدة لمسار العزل).
التفاصيل: حقيبة التسليم/تجربة-العزل-بدون-الأدوات-٢٠٢٦-١٠-٠٨.md.

## إصلاح محاذاة نسخة العزل — ٨ أكتوبر ٢٠٢٦

الجولة الأولى للحملة `2026-10-08T13-52-13` لم تصل إلى التشغيل:
`PACKAGE_NOT_INSTALLED` و`INSTRUMENTED_RUNTIME=NOT_RUN`. السبب الجذري:
مرحلة البناء كانت تحاذي النسخة فقط عند تضمين الأدوات، فرفض فحص ما
قبل النشر النسخة غير المحاذاة وأوقف النشر قبل التثبيت. الإصلاح يجعل
قرار المحاذاة صريحًا (`plan_artifact_alignment`): كل نسخة تُحاذى
وتُتحقق عند توفر الأداة، بغض النظر عن الأدوات.

لا حملة جديدة ولا تثبيت ولا عمليات مدمرة أثناء الإصلاح.
المجموعة: 301/301 (6 اختبارات انحدار جديدة للقرار والفحص).
إعادة التشغيل من الهاتف بأمر واحد بعد السحب (انظر وثيقة التجربة).

## إصلاح سلسلة التوقيع والنشر — ٨ أكتوبر ٢٠٢٦

حملة `2026-10-08T14-09-51`: البناء والمحاذاة ناجحان، والتوقيع محجوب
بغياب `REELSEC_TEST_KEYSTORE`، فتوقف النشر والتشغيل وظهر الحكم
`PACKAGE_NOT_INSTALLED` قناعًا للسبب الحقيقي. الإصلاح الجذري:
تجهيز شهادة اختبار ذاتي خارج المستودع عبر `openssl` دون كلمات مرور
في الوسائط أو السجلات؛ فحص توقيع حقيقي مع تسجيل بصمة الشهادة؛ بوابة
توافق تمنع التثبيت عند اختلاف التوقيع دون تفويض مدمر صريح؛ هوية ما
بعد التثبيت بمطابقة الشهادة؛ كتابة وثيقة النشر دائمًا؛ وحقل
`BLOCKED_BY` في الحكم يسمي المرحلة الحاجزة. حُسمت حزمة الاختبار
تلقائيًا من البيان عند غياب الإعداد الصريح.

لا حملة جديدة ولا عمليات مدمرة أثناء الإصلاح.
المجموعة: 332/332 (31 اختبار انحدار جديد).
التفاصيل: حقيبة التسليم/إصلاح-سلسلة-التوقيع-والنشر-٢٠٢٦-١٠-٠٨.md.
