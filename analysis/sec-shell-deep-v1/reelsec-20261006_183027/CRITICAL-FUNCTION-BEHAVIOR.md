# Critical Function Behavior

Function: 0x27a510
Body extraction: from the recovered prologue to the first return.

Calls:
  27a544: 97f9796f     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a568: 97f97982     	bl	0xd8b70 <_Znwm@plt>
  27a570: 97fff7af     	bl	0x27842c <_ZN18codecPluginManager13dummyFunctionEv+0x38>
  27a598: 97f9795a     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a5dc: 97fff889     	bl	0x278800 <_ZN18codecPluginManager13dummyFunctionEv+0x40c>
  27a604: 97f9793f     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a630: 9401935a     	bl	0x2df398 <_ZN6Cicada8UrlUtils9url_splitEPciS1_iS1_iPiS1_iPKc+0x14>
  27a63c: 97f99599     	bl	0xdfca0 <_ZN6Cicada19DrmHandlerPrototype9isSupportEPKNS_7DrmInfoE@plt>
  27a67c: 97f97921     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a6a0: 97ffffaa     	bl	0x27a548 <_ZN18codecPluginManager13dummyFunctionEv+0x2154>
  27a6c4: 97f9790f     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a6e8: 97ffffad     	bl	0x27a59c <_ZN18codecPluginManager13dummyFunctionEv+0x21a8>
  27a710: 97f978fc     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a734: 97ffffb5     	bl	0x27a608 <_ZN18codecPluginManager13dummyFunctionEv+0x2214>
  27a75c: 97f978e9     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a780: 9400000a     	bl	0x27a7a8 <_ZN18codecPluginManager13dummyFunctionEv+0x23b4>
  27a7a4: 97f978d7     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a7dc: 97fffff3     	bl	0x27a7a8 <_ZN18codecPluginManager13dummyFunctionEv+0x23b4>
  27a7e8: 97fffff0     	bl	0x27a7a8 <_ZN18codecPluginManager13dummyFunctionEv+0x23b4>
  27a7f0: 97f978d4     	bl	0xd8b40 <_ZdlPv@plt>
  27a818: 97f978ba     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a880: 94000036     	bl	0x27a958 <_ZN18codecPluginManager13dummyFunctionEv+0x2564>
  27a888: 97f978ae     	bl	0xd8b40 <_ZdlPv@plt>
  27a890: 97f978ac     	bl	0xd8b40 <_ZdlPv@plt>
  27a8c8: 97f9788e     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a920: 97f97888     	bl	0xd8b40 <_ZdlPv@plt>
  27a954: 97f9786b     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a97c: 97f97919     	bl	0xd8de0 <free@plt>
  27a984: 97f9f724     	bl	0xf8614 <.text+0x17d54>
  27a9a8: 97f97856     	bl	0xd8b00 <__stack_chk_fail@plt>
  27a9d8: 97ffff74     	bl	0x27a7a8 <_ZN18codecPluginManager13dummyFunctionEv+0x23b4>
  27aa0c: 97f9783d     	bl	0xd8b00 <__stack_chk_fail@plt>

Security-related instructions/text:
NONE

Classification: NO_SECURITY_OPERATION_OBSERVED
This is body-local evidence only; it does not prove Screenshot blocking.
