# Target / VTable Provenance Audit

Target: 0x27a510
Target address-point: 0x717e60
RTTI type: N6Cicada17mediaCodecDecoderE
Named ActiveDecoder base address-point: 0x718028
Base relation: DIFFERENT_ADDRESS_POINT

The target address-point is NOT automatically classified as the ActiveDecoder base vtable.
Constructor post-base vptr installation is evidence of object initialization, not by itself proof of complete-object class identity or runtime dispatch.
Containing function symbol: NONE
Previous symbol: {'addr': 2589684, 'size': 56, 'type': 'FUNC', 'name': '_ZN18codecPluginManager13dummyFunctionEv'}
Next symbol: {'addr': 2608444, 'size': 88, 'type': 'FUNC', 'name': '_ZN14codecPrototype12addPrototypeEPS_'}
Target is an unnamed executable region between symbol boundaries.
