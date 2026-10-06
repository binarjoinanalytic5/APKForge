# VTable Class Correlation

Address-point: 0x717E60
RTTI type name: N6Cicada17mediaCodecDecoderE
vtable entry[0]: 0x2785bc
vtable entry[1]: 0x278768

Evidence:
- RTTI type is mediaCodecDecoder: YES
- vtable entry[0] is destructor candidate 0x2785bc: YES
- vtable entry[1] is destructor candidate 0x278768: YES
- constructor calls ActiveDecoderC2Ev: YES
- constructor stores vptr into [x19]: YES
- destructor calls ActiveDecoderD2Ev: NO

RESULT: NOT_PROVEN

Static slot mapping: 0x717f68 (+0x108) -> 0x27a510.
Runtime execution of that virtual slot remains a separate question; this report does not claim that the program actually invoked slot +0x108.
