# Capture protection detection (read-only)

Verdict: **PACKED_STATIC_ANALYSIS_LIMITED**

An app-hardening shell is present: the real application code is encrypted and only materializes at runtime, so Java-layer protection (e.g. FLAG_SECURE) cannot be fully enumerated from static files alone.

Files scanned: 3050, files with hits: 100

## Mechanisms

| Layer | Mechanism | Confidence | Evidence |
|---|---|---|---|
| JAVA_CAPTURE_CALLBACKS | SCREEN_CAPTURE_CALLBACKS | MEDIUM | 5 |
| DRM | DRM_PROTECTION_STRINGS | MEDIUM | 62 |
| NATIVE_BUFFERS | PROTECTED_CONTENT_BUFFERS | MEDIUM | 8 |
| NATIVE_STRINGS | CAPTURE_RELATED_STRINGS | LOW_INDICATOR | 21 |
| NATIVE_SYMBOLS | CAPTURE_RELATED_EXPORTED_SYMBOLS | MEDIUM | 11 |
| TAMPER | ANTI_INSTRUMENTATION_STRINGS | LOW_INDICATOR | 167 |
| PACKER | APP_HARDENING_SHELL | HIGH_STRUCTURAL | 2 |

## Packers

- **SecShell**: manifest:com.secshell., native_lib:libsecshell-x86.so

Indicators only: causal_proof=false. This tool never patches or disables anything.
