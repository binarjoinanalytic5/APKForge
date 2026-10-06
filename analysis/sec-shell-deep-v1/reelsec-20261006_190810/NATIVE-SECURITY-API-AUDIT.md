# Native Security API Audit

- ANativeWindow_fromSurface: FOUND
- ANativeWindow_setUsage: NOT_FOUND
- ANativeWindow_setBuffersGeometry: NOT_FOUND
- AHardwareBuffer: NOT_FOUND
- AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT: NOT_FOUND
- GRALLOC_USAGE_PROTECTED: NOT_FOUND
- EGL_PROTECTED_CONTENT: NOT_FOUND
- EGL_EXT_protected_content: NOT_FOUND
- AMediaCodec_configure: NOT_FOUND
- MediaCodec.setOutputSurface: NOT_FOUND
- SurfaceControl: NOT_FOUND
- setSecure: NOT_FOUND

Rule: names/imports are indicators, not execution proof.
