# ReelSec

Professional read-only native security evidence collector for ReelShort v4.2.00.

## Update and run

    git pull --ff-only origin main
    chmod +x tools/reelsec/reelsec.py tools/reelsec/update-and-run.sh
    ./tools/reelsec/update-and-run.sh

## Direct run

    python3 tools/reelsec/reelsec.py

## Exact ELF

    python3 tools/reelsec/reelsec.py --elf /path/to/libsaasCorePlayer.so

## Current proof target

Resolves the ActiveDecoder vtable path and reads the raw function pointer at virtual address 0x717f68 directly from the ELF. Reports are timestamped and stored under analysis/sec-shell-deep-v1/.

The tool never modifies, patches, injects into, signs, or rebuilds the APK.


## Capture protection detection

Read-only discovery of screenshot/recording protection indicators
(schema `capture-detection-3`):

    # decoded apktool tree
    python3 tools/reelsec/capture_detector.py /path/to/decoded-apk \
        -o CAPTURE-DETECTION.json -m CAPTURE-DETECTION.md

    # APK file directly (in-memory container scan; nothing is extracted)
    python3 tools/reelsec/capture_detector.py ./original.apk \
        -o CAPTURE-DETECTION.json -m CAPTURE-DETECTION.md

The campaign automatically emits `CAPTURE-DETECTION.json` beside its report.

V3 detection layers:

- **APK/ZIP container mode** — entry inventory, per-entry native string scan,
  packed DEX detection inside entries, packer detection from entry names and
  the binary AndroidManifest string pool (ASCII + UTF-16LE). Read-only: no
  extraction to disk.
- **ELF .dynsym extraction** — dynamic symbols of native libraries are
  classified (`NATIVE_SYMBOLS`), distinguishing imports from defined exports
  via `symbol_defined` (e.g. imported `AMediaDrm_createByUUID` is a confirmed
  DRM API usage fact; an exported `nativeOnCaptureScreen` JNI symbol is a
  confirmed callback surface fact).
- **Noise classification** — hits inside well-known third-party SDK paths are
  flagged `noise=true` with a reason and excluded from category counts;
  downstream they are tiered `UNRELATED`. Evidence is never deleted.
- **Anti-tamper families** — `family` tag per hit (frida/xposed/magisk/ptrace/root).
- **Smali FLAG_SECURE heuristic** — obfuscated code that loads `0x2000` into a
  register and applies it via `addFlags`/`setFlags`/`or-int` in a bounded line
  window. A bare `0x2000` constant alone is never reported.
- **Packer / hardening shell detection** — SecShell, Bangcle/SecNeo, Qihoo
  Jiagu, Tencent Legu, Ali Mobisec, Ijiami, KiwiSec.
- **Hidden DEX payload discovery** — detection only; payloads are never
  extracted or decrypted.
- **Native string classification** — DRM, DRM security levels,
  protected-content buffers, capture callbacks, capture binaries,
  anti-instrumentation strings.

## Evidence report (tiered findings + causal chain gate)

    python3 tools/reelsec/evidence_report.py \
        --detection CAPTURE-DETECTION.json \
        [--campaign analysis/sec-shell-deep-v1/reelsec-XXXX] \
        -o EVIDENCE-REPORT.json -m EVIDENCE-REPORT.md

The campaign automatically emits `EVIDENCE-REPORT.json`/`.md` after the
runtime stage, linking static, native and runtime findings in an evidence
graph.

Evidence tiers (strict):

- `CONFIRMED` — structural/byte-level facts (hashes, packer signatures, string
  or symbol presence). Presence only, never behavior.
- `INDICATOR` — security-relevant by inference; execution not established.
- `NOT_PROVEN` — causal/behavioral claims without a completed chain.
- `UNRELATED` — third-party/noise context.

Causal claim "the app blocks screenshots/recording" requires ALL four links
CONFIRMED:

1. `L1_MECHANISM_IDENTIFIED_STATIC`
2. `L2_TARGET_PROVENANCE_ESTABLISHED` (hash binding to the exact APK)
3. `L3_RUNTIME_EXECUTION_OBSERVED` (probe events tied to the artifact)
4. `L4_CAPTURE_BLOCK_BEHAVIOR_OBSERVED` (bounded behavioral observation via a
   `BEHAVIOR-CAPTURE.json` record: `screenshot_attempted`,
   `secure_content_protected`, `session_bound`)

Any incomplete chain yields verdict `NOT_PROVEN` with the missing links
enumerated.

**Important:** indicator presence is not execution or causal proof. These
tools do not patch, disable, inject, sign, or rebuild the APK.


## Evidence boundary

The capture detector is deliberately evidence-gated. Strong static indicators are discovery signals only; DRM/native capture strings are contextual signals. No static hit is treated as proof of execution or causality. Causal status requires runtime observation tied to the exact artifact, matching code-path provenance, and an observable security decision or capture behavior.


## Optional open-source analysis adapters

ReelSec can optionally use installed open-source analyzers without making them
hard dependencies:

    python3 tools/reelsec/optional_adapters.py /path/to/decoded-apk \
      --elf /path/to/libsaasCorePlayer.so \
      --adapters auto -o OPTIONAL-ADAPTERS.json

The campaign also runs the adapters automatically in read-only mode and writes
`OPTIONAL-ADAPTERS.json`. Select a subset with:

    python3 tools/reelsec/reelsec.py campaign ./original.apk \
      --adapters mobsfscan,radare2

Supported adapters:

- **mobsfscan** — static source-pattern analysis when installed.
- **radare2** — native ELF header/symbol inventory when an ELF is available.
- **JADX** — optional APK/DEX decompilation into a disposable analysis directory.
- **MobSF** — availability/version discovery; server upload/orchestration remains external.
- **objection** — availability/version discovery; runtime observation stays in ReelSec's guarded path.

Adapters are optional and missing tools are reported as `UNAVAILABLE`, not as
campaign failures. Adapter output is evidence only and never causal proof.
No adapter patches, disables protections, injects hooks, signs, or rebuilds the
input APK.

## Runtime diagnostics (staged lifecycle + reason codes)

`RUNTIME-PROBE.json` now records an auditable stage chain instead of a single
opaque timeout:

    ADB_CONNECTED -> PACKAGE_RESOLVED -> PACKAGE_PRESENT ->
    APP_LAUNCH_ATTEMPTED -> PROCESS_OBSERVED -> TARGET_PROCESS_CONFIRMED ->
    PROBE_ATTACHED -> MODULE_WAIT_STARTED -> MODULE_OBSERVED ->
    TARGET_RESOLUTION -> TARGET_OBSERVED

Each stage records status, timestamp, reason code, source, elapsed time, and
pid where available. `lifecycle.reason_code` names the deepest failing layer:
`APP_NOT_STARTED` (A), `TARGET_PROCESS_NOT_OBSERVED` (B),
`TARGET_MODULE_NOT_OBSERVED` (C), `PROBE_ATTACH_FAILED` (D),
`TARGET_NOT_EXECUTED_BEFORE_TIMEOUT` (E), `TARGET_OBSERVED` (F),
`PROBE_TIMEOUT_AFTER_VALID_ATTACH` (G), plus pre-launch codes
(`ADB_NO_ONLINE_DEVICE`, `PACKAGE_NOT_INSTALLED`).

Environment knobs: `REELSEC_PROBE_WINDOW_MS` (probe window, default 12000),
`REELSEC_ZIPALIGN` (optional alignment verifier path).

Install diagnostics: pre-install preflight (uncompressed native libs,
page alignment, ABI compatibility) and post-install verification
(`pm path` + versionCode) are recorded in `ADB-DEPLOY.json`; failures carry
explicit reason codes (e.g. `NATIVE_LIB_EXTRACTION_FAILED`).

## Native Crash Gate (artifact runtime integrity)

A `PROCESS_HEALTH_GATE` stage runs BEFORE any Frida work: the installed
artifact is launched, the process is observed bounded, and
`ApplicationExitInfo` (`dumpsys activity exit-info`) plus the crash logcat
buffer are consulted (delta-based, so stale crashes never trigger it). A
crash fails the round immediately as `RUNTIME_ARTIFACT_CRASH` — never as a
probe timeout — and downstream stages are recorded SKIP.

Outputs: `RUNTIME-HEALTH.json` (startup/exit_reason/crash_class/crash_cause/
runtime_probe_allowed, all auditable), `BASELINE-RUNTIME.json` (gated
original-vs-instrumented comparison: `INSTRUMENTATION_REGRESSION_CONFIRMED`
vs `BASELINE_RUNTIME_FAILURE`), `ARTIFACT-INTEGRITY.json` (signing/package/
expected-.so/compression/installed identity gate), `INSTRUMENTATION-IMPACT.json`
(change-to-artifact linkage with strict attribution rules), and
`RUNTIME-VERDICT.json` (ORIGINAL_RUNTIME / INSTRUMENTED_RUNTIME / CRASH_CLASS /
CRASH_CAUSE / REGRESSION_STATUS / RUNTIME_PROOF_STATUS / NEXT_ACTION).

The evidence gate enforces `RUNTIME_VALIDITY = BLOCKED_BY_ARTIFACT_CRASH`:
L3/L4 can never be CONFIRMED while the artifact under test crashes.
Unknown crash causes stay `CRASH_CAUSE_UNKNOWN` and are never attributed.
Environment knobs: `REELSEC_HEALTH_WINDOW_MS` (health observation window,
default 8000), `REELSEC_BASELINE_RUNTIME` (0 disables the gated baseline
round). SCREENSHOT_BLOCKING remains NOT_PROVEN.

## Guarded behavioral capture (L4 producer, opt-in)

`REELSEC_BEHAVIOR_CAPTURE=1` enables one bounded user-level `screencap`
observation after Stage 12, producing `BEHAVIOR-CAPTURE.json` per the
evidence-report contract. `secure_content_protected=true` additionally
requires `REELSEC_BEHAVIOR_PLAYBACK_CONFIRMED=1` (explicit operator
confirmation that protected playback was active). Observation only: no
hooks, no protection modification, no circumvention.

**Important:** `TARGET_OBSERVED` proves a runtime layer only (L3). It is
never behavioral proof; L4 requires the independent behavioral record.
