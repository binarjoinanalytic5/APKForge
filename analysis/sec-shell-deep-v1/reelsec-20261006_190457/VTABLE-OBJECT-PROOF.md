# VTable Object Proof

Object register: x19
Base constructor call observed: YES
VTable base computation 0x717000 + 0xe50 observed: NO
Address-point computation 0x717e50 + 0x10 = 0x717e60 observed: NO
vptr store [x19] observed: NO

RESULT: NOT_PROVEN

This proves the constructor path writes the recovered vtable address-point into the object register; it does not by itself prove which virtual method is invoked at runtime.
