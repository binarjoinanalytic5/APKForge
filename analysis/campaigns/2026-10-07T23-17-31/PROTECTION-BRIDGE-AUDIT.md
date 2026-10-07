# Protection Bridge Audit

Critical pointer: 0x27a510

Indicators found in target ELF:
- queueSecureInputBuffer: FOUND
- setOutputSurface: FOUND
- setForceInsecureDecoder: FOUND
- ANativeWindow: FOUND
- EGL: FOUND
- GRALLOC: NOT_FOUND
- AHardwareBuffer: NOT_FOUND
- FLAG_SECURE: NOT_FOUND
- MediaProjection: NOT_FOUND
- createVirtualDisplay: NOT_FOUND
- screenshot: NOT_FOUND
- recording: FOUND

Rule: indicator presence is not execution proof.
Next proof step: inspect the critical function body and its outgoing call targets.
Important: 0x108 is classified as JNI GetMethodID index 33 by the observed call signature; it must not be assumed to be an ActiveDecoder C++ vtable slot.
