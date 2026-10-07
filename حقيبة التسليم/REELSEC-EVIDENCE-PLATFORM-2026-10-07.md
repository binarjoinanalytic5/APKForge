# ReelSec — Evidence Platform Handover
## Session update — 2026-10-07 (detector v3 + tiered evidence platform)

**Repository:** binarjoinanalytic5/ReelShort-v4.2.00-analysis
**Branch:** main
**Baseline before this session:** cb3862b (84/84 tests OK)

## 1. What was built this session

### 1.1 Capture detector v3 (`tools/reelsec/capture_detector.py`, schema `capture-detection-3`)
- **APK container mode**: `capture_detector.py ./original.apk` now works
  directly — in-memory ZIP scan (entry inventory, native string scan, packed
  DEX detection, packer detection from entry names + binary AndroidManifest
  string pool in ASCII and UTF-16LE). Nothing is extracted to disk.
- **ELF .dynsym extraction**: real dynamic symbol parsing (ELF32/64, LE/BE).
  Symbols are classified into the indicator table as `NATIVE_SYMBOLS` with a
  `symbol_defined` flag distinguishing imports from defined exports.
- **Noise classification**: third-party SDK paths are flagged `noise=true`
  with a reason and excluded from category counts (tiered `UNRELATED`
  downstream). Evidence is never deleted, only classified.
- **Anti-tamper families**: per-hit `family` tag (frida/xposed/magisk/ptrace/root).
- v2 capabilities retained (FLAG_SECURE smali heuristic, packers, hidden DEX,
  protected-content/DRM classes, mechanism summary, evidence_policy).

### 1.2 Evidence platform (`tools/reelsec/evidence_report.py`, schema `evidence-report-1`)
- Strict tiers: **CONFIRMED / INDICATOR / NOT_PROVEN / UNRELATED**.
- **Evidence graph** linking artifacts ↔ findings ↔ mechanisms ↔ chain links,
  with runtime evidence (`RUNTIME-PROBE.json`) wired into L3 via `INFORMS`.
- **Causal chain gate** for the claim "the app blocks screenshots/recording":
  L1 mechanism identified (static) → L2 provenance (hash binding) →
  L3 runtime execution observed → L4 capture-block behavior observed
  (`BEHAVIOR-CAPTURE.json` contract: `screenshot_attempted`,
  `secure_content_protected`, `session_bound`).
  Verdict is CONFIRMED **only** when all four links are CONFIRMED.
- Campaign integration: `EVIDENCE-REPORT.json`/`.md` are emitted
  automatically after Stage 12 (runtime evidence).
- CLI for manual runs (documented in `tools/reelsec/README.md`).

### 1.3 Regression tests
- `test_capture_detector.py`: 11 tests (heuristic ±, noise classification,
  packers, hidden DEX, native strings, ELF dynsym fixture, APK container
  fixture, read-only contract).
- `test_evidence_report.py`: 7 tests, including the two-directional gate:
  incomplete chain → `NOT_PROVEN`; complete synthetic chain → `CONFIRMED`;
  runtime-without-behavior stays `NOT_PROVEN` (no premature causal proof).
- Suite total: **94/94 OK** via `python -m unittest discover -s tools/reelsec`.

## 2. Real-run results (decoded tree of the target APK, `apktool-src`)

Report directory: `analysis/evidence-platform-20261007/`
(`CAPTURE-DETECTION.json/.md`, `EVIDENCE-REPORT.json/.md`)

- Verdict: `PACKED_STATIC_ANALYSIS_LIMITED` (SecShell confirmed:
  `manifest:com.secshell.` + `native_lib:libsecshell-x86.so`).
- New confirmed API-usage facts from .dynsym of `libsaasCorePlayer.so`:
  imports `AMediaDrm_createByUUID`, `AMediaDrm_getPropertyByteArray`,
  `AMediaDrm_getPropertyString`, `AMediaDrm_release` (NDK DRM API usage),
  and `ptrace` (anti-debug surface). `defined:false` = imports.
- Capture surface: `nativeOnCaptureScreen` / `gj_NativePlayer_onCaptureScreen`
  / `onCaptureScreen` strings (INDICATOR tier).
- Tier counts: CONFIRMED 1 (packer structure) / INDICATOR 6 / NOT_PROVEN 1
  (the causal claim) / UNRELATED 1 (third-party noise).
- Causal chain: **NOT_PROVEN** —
  L1 CONFIRMED (capture-specific static surface identified),
  L2/L3/L4 NOT_PROVEN (no hash binding without the APK file, no runtime
  probe evidence, no behavioral capture record).

## 3. Phone execution (next operator step)

```bash
cd ~/apk-lab/ReelShort-v4.2.00
git fetch origin main && git merge --ff-only origin/main

# 1) detector v3 directly on the APK (container mode):
python3 tools/reelsec/capture_detector.py ./original.apk \
    -o CAPTURE-DETECTION.json -m CAPTURE-DETECTION.md

# 2) tiered evidence report (optionally bind a campaign directory):
python3 tools/reelsec/evidence_report.py \
    --detection CAPTURE-DETECTION.json \
    --campaign analysis/sec-shell-deep-v1/<latest-campaign> \
    -o EVIDENCE-REPORT.json -m EVIDENCE-REPORT.md
```

Container mode records `input_sha256`; when it equals the campaign's
`target-sha256.txt`, L2 becomes CONFIRMED. L3 requires a runtime probe with
`runtime_matches > 0`; L4 requires a bounded behavioral capture record. The
platform never emits a causal proof before the chain completes.

## 4. Boundaries preserved (unchanged policy)

Read-only detection/classification only:
- no bypass of protections, no DRM disabling, no FLAG_SECURE patching,
  no hooks aimed at defeating protection;
- `causal_proof` is emitted only by the four-link gate;
- hidden DEX payloads are detected, never extracted or decrypted;
- original APK is never modified.

## 5. Known limitations / next engineering gates

- L4 has no collector yet: `BEHAVIOR-CAPTURE.json` is a defined contract
  without a producer. The next runtime stage may add a bounded, guarded
  behavioral observer; until then L4 stays NOT_PROVEN by design.
- Decoded-tree scans have no container hash (L2 needs the APK file or a
  campaign provenance record).
- `.dynsym` covers dynamic symbols only; stripped local functions remain
  out of scope by design (no disassembly claims).
