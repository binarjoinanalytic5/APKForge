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
