# ReelSec — Handover Packet
## Session transfer — 2026-10-07

**Repository:** binarjoinanalytic5/ReelShort-v4.2.00-analysis  
**Branch:** main  
**Latest known implementation commit:** 71fa8d7215da7666f18de0a8367190894be375b5  
**Target APK:** original.apk  
**Package:** com.newleaf.app.android.victor  
**Version:** 4.2.00 / versionCode 4200

### 1. Mission
Continue the authorized defensive/security analysis of the APK and determine, with evidence rather than inference, the SecShell/native path and whether it participates in screenshot/display-protection behavior.

### 2. What is established
- Original APK SHA-256: `e67f2a69a108e5fb36f98eb6ca5fdd1030872f43d216b4163fb3e7c999deb278`.
- The APK decodes successfully in recovery mode with resources disabled; Smali is instrumentable.
- Native analysis located function-pointer address `0x27a510`.
- Symbol-table resolution did not resolve that address.
- RTTI/native evidence associated the relevant object/vtable path with `mediaCodecDecoder`.
- Runtime evidence from the unmodified app showed `libSecShell.so` loading successfully in the push-worker process.
- Runtime log evidence also showed an AppsFlyer `NoSuchMethodError` involving `AFc1fSDKI18582`, but the app continued initializing; do not treat this as proof of the screenshot mechanism.
- The app made normal network/configuration requests and initialized WebView/Widevine/native components.

### 3. Important runtime observation
The captured runtime log showed:
- main activity reached foreground;
- `libSecShell.so` loaded successfully;
- `libprotect.so` and other native libraries loaded;
- no fatal crash was established from the shown log;
- AppsFlyer class initialization failed with `NoSuchMethodError`:
  `AFc1fSDKI18582$AFa1zSDK.<init>(DefaultConstructorMarker)`.
This is a separate runtime compatibility signal and must be correlated before assigning causality.

### 4. Previous ReelSec campaign
Report:
`analysis/sec-shell-deep-v1/reelsec-20261007_020604-18581`

Result:
- PASS: 7
- BLOCKED: 1
- SKIP: 6
- FINAL_STATUS: COMPLETED_WITH_ISSUES
- TARGET_PROVENANCE_STATUS: DIFFERENT_ADDRESS_POINT
- FUNCTION_POINTER: `0x27a510`
- SYMBOL: NOT_RESOLVED_BY_SYMBOL_TABLE
- AUTONOMOUS_DATAFLOW_PROVEN: False
- RUNTIME_PROOF_STATUS: FRIDA_GADGET_REQUIRED

The blocker was Stage 06: structural discovery did not find the SecShell Application/loadLibrary anchor, so stages 07–12 were skipped.

### 5. Tooling changes since the previous campaign
The instrumentation backend was hardened to search the manifest-declared Application class and its Smali for `System.loadLibrary` / SecShell references instead of relying on the earlier narrow `AW.smali` assumption.

Regression coverage was added for the observed obfuscated Application shape (`ApplicationC0043AW`) and related diagnostics.

### 6. Next action — mandatory
Run the current remote bootstrap from a clean shell:

```bash
cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

Record the complete output and report directory.

### 7. Interpretation gate
Do NOT claim screenshot protection is proven merely because:
- `libSecShell.so` loads;
- `0x27a510` exists;
- an object is named `mediaCodecDecoder`;
- a Java/Smali class references SecShell;
- a runtime hook is possible.

Proof requires a reproducible chain connecting the native/managed control point to an observable security behavior, with provenance matching the exact APK/artifact under test.

### 8. Runtime proof boundary
The current campaign explicitly requires guarded Frida Gadget observation before autonomous runtime dataflow can be marked proven. Any future runtime experiment must preserve the original APK and isolate any instrumented artifact.

### 9. Existing handover/proof documents
See:
- `حقيبة التسليم/REELSEC-CONTINUATION-HANDOVER-2026-10-06.md`
- `حقيبة التسليم/REELSEC-PROOF-MATRIX-2026-10-06.md`

### 10. Session rule
The next agent/session should first read this file and the two documents above, inspect the current `tools/reelsec` implementation, then run the campaign. Do not restart the investigation from scratch and do not discard prior negative/uncertain findings.


## 11. Signing-gate findings — 2026-10-07 02:25 campaign
Campaign report:
`analysis/sec-shell-deep-v1/reelsec-20261007_022538-31232`

Stages 01–08 passed exactly as intended. Stage 09 no longer failed because of missing signer discovery: the capability-path compatibility fix allowed ReelSec to locate `apksigner` and the configured test keystore.

The new Stage 09 failure was:
- `apksigner` prompted for the keystore password on stdin;
- ReelSec runs the signer through a non-interactive subprocess;
- stdin therefore did not provide the password;
- `apksigner` returned `keystore password was incorrect`.

This is an automation/input-mode defect, not evidence that the keystore is invalid. The keystore was independently validated with `keytool -list` and contains alias `reelsec-test`.

## 12. Signing automation fix
Two implementation fixes are now on `main`:
- `9b15a5be2aaf727c5e31ef753581215e6ccfe0c7`: expose signing capabilities at the compatibility paths expected by ReelSec.
- `b4efbb269d087bcbf6d184e832d9ccd256752929`: make `sign_verify.py` use unattended password references.
- `13a327af6f8321e8cf6729cd4582ec00d7cf7066`: add regression coverage for unattended signing and ensure password values are not embedded in command arguments.

Required environment variables for the next campaign:
- `REELSEC_TEST_KEYSTORE`
- `REELSEC_TEST_KEY_ALIAS`
- `REELSEC_TEST_KEYSTORE_PASSWORD`
- `REELSEC_TEST_KEY_PASSWORD`

The last two variables must contain the passwords already configured for the isolated test keystore. Do not commit them or paste their values into repository files.

The generated signing command uses `env:REELSEC_TEST_...` references, so password values are not written into the command manifest.

## 13. Immediate next action
In the same Termux session, set the two password variables to the values used when the test keystore was created, then rerun the remote bootstrap:

```bash
export REELSEC_TEST_KEYSTORE_PASSWORD='[same keystore password used during keytool creation]'
export REELSEC_TEST_KEY_PASSWORD='[same private-key password used during keytool creation]'

cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

Do not regenerate the keystore unless a later verification proves it is corrupted. Do not alter `original.apk`.

## 14. Current proof boundary
After the signing fix, the expected progression is:
- Stage 09: `SIGNED_VERIFIED`
- Stage 10: install only the signed isolated artifact, using explicit `REELSEC_TEST_DEVICE`
- Stage 11: guarded Frida Gadget observation, if the package/device prerequisites are available
- Stage 12: bounded runtime evidence

Even after those stages pass, `0x27a510` remains a pointer/dataflow candidate until runtime evidence observes the expected vptr/slot chain. Screenshot protection must not be inferred from the pointer alone.


## 15. Campaign 2026-10-07 02:41 — ADB endpoint drift confirmed
Report:
`analysis/sec-shell-deep-v1/reelsec-20261007_024159-17548`

Observed host ADB inventory immediately before the campaign:
`192.168.8.8:32897    device`.

Campaign result:
- Stages 01–09 passed, including `SIGNED_VERIFIED`.
- Stage 10 failed because ReelSec still used the stale environment serial `192.168.8.8:39927`.
- Stage 11 remained `READY`.
- Stage 12 was `NOT_CAPTURED` because deployment did not complete.
- Stage 13 remained `dataflow_proven=False` with `FRIDA_GADGET_REQUIRED`.
- Final status: `COMPLETED_WITH_ISSUES`.
- Published report commit: `ac1bf2c83efec9d510e190fa6a02a7649e5486e4`.
- Published status commit: `bf3f989fac292c0f14a2aa641dbde9ae55e0e533`.

Root cause:
`tools/reelsec/reelsec.py` previously consumed `REELSEC_TEST_DEVICE` literally and did not reconcile it with the current ADB inventory. A wireless ADB reconnect can change the TCP endpoint even when the same test phone remains connected.

## 16. ADB endpoint-drift fix
Implementation commits on `main`:
- `2b71ecefc4b153ce3fc840f3ea315b10c2d19913`: add safe current-device resolution to `tools/reelsec/adb_deploy.py`.
- `c12276e7e6bc2e59e6398ec6058065345d7e6ab4`: make campaign Stage 10 resolve the device from the current ADB inventory before checking/installing.
- `4a4c216558386e16344306a7758b91f92fb565ef`: add regression tests to `tools/reelsec/test_adb_deploy.py`.

Resolution policy:
1. If `REELSEC_TEST_DEVICE` exactly matches one current online `device`, use it.
2. If the configured serial is stale and exactly one online `device` exists, automatically rebind to that sole device and record `AUTO_REBOUND_SINGLE_ONLINE_DEVICE`.
3. If zero or multiple online devices exist while the configured serial is stale, refuse implicit selection and fail safely.
4. `REELSEC_TEST_DEVICE=auto` is supported only when exactly one online device exists.

The deployment manifest now records:
`requested_serial`, `serial`, `device_resolution`, `online_devices`, and the current inventory command.

This fix is specifically for ADB endpoint drift. It does not weaken the proof boundary and does not establish screenshot/recording protection.

## 17. Immediate next campaign
Do NOT manually change `original.apk`.

Run the current remote bootstrap exactly as before:

```bash
cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

Expected Stage 10 behavior with the currently observed single online device:
- requested serial may be the stale `192.168.8.8:39927`;
- ReelSec should detect current `192.168.8.8:32897`;
- Stage 10 should use `192.168.8.8:32897` and record `AUTO_REBOUND_SINGLE_ONLINE_DEVICE`.

Success at Stage 10 is still only deployment evidence. Stage 12/runtime and the native proof gate remain the decisive next steps.


## 18. Campaign 2026-10-07 02:47 — ADB endpoint fixed; package-signature gate exposed
Report:
`analysis/sec-shell-deep-v1/reelsec-20261007_024703-21217`

Confirmed:
- Stage 10 selected the current online endpoint `192.168.8.8:32897`; the stale `39927` problem is fixed.
- The signed instrumented artifact was valid: Stage 09 `SIGNED_VERIFIED`.
- Android rejected the install with `INSTALL_FAILED_UPDATE_INCOMPATIBLE` because the already-installed `com.newleaf.app.android.victor` is signed by a different certificate.
- The initial incremental-install warning (`Incremental installation not allowed`) was followed by a normal streamed install attempt; the decisive failure is the signature mismatch.
- Stage 12 therefore remained `NOT_CAPTURED`.
- Native proof remains unchanged: `AUTONOMOUS_DATAFLOW_PROVEN=False`, `RUNTIME_PROOF_STATUS=FRIDA_GADGET_REQUIRED`.
- Published report commit: `66c2c41c72c32c5208e77d139535c02e21850442`.
- Published status commit: `3b844ba3b6035f6f785bbe5cccc144b1a82fafd9`.

## 19. Guarded reinstall fix
Implementation commits:
- `c603b305884ca9b1af6a1c04711fb112b3e093d2`: add precise signature-mismatch classification.
- `6cc873e9978132d34ec9f19c370cc2706c4a2135`: Stage 10 can retry after uninstalling the existing package, but **only** when `REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1` is explicitly set.
- `71fa8d7215da7666f18de0a8367190894be375b5`: regression test for the signature-mismatch classifier.

Safety rule:
- ReelSec never silently uninstalls an existing package.
- The uninstall path requires `REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1`.
- It also requires `REELSEC_TEST_PACKAGE`; the uninstall target is exactly that configured test package.
- The uninstall/reinstall mode is recorded in `ADB-DEPLOY.json`.
- This is a test-device installation concern and is independent from screenshot/recording proof.

## 20. Immediate next action
The next campaign should be run only on the intended explicit test device, with the guarded uninstall flag enabled so the tool can replace the differently-signed existing package:

```bash
export REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1

cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

Keep the existing signing/password environment variables unchanged. Do not modify `original.apk`.

Expected progression:
- Stage 09: `SIGNED_VERIFIED`
- Stage 10: uninstall existing same-package test install, then install isolated signed artifact
- Stage 12: `CAPTURED` if the instrumented application launches and the bounded runtime collector succeeds
- Stage 13 may still report `dataflow_proven=False`; only direct runtime observations can advance the proof gate.

Do not claim Screenshot/Recording protection from successful installation or Gadget readiness alone.
