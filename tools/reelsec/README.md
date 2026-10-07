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

Read-only discovery of screenshot/recording protection indicators:

    python3 tools/reelsec/capture_detector.py /path/to/decoded-apk -o CAPTURE-DETECTION.json

The campaign automatically emits `CAPTURE-DETECTION.json` beside its report.
The detector classifies only static indicators such as `FLAG_SECURE`,
MediaProjection, capture callbacks, Surface security, DRM/native capture
strings, and native-library printable strings.

**Important:** indicator presence is not execution or causal proof. The detector
does not patch, disable, inject, sign, or rebuild the APK.


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
