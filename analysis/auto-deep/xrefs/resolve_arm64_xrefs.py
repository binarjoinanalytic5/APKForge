from pathlib import Path
import struct,re

lib=Path("apktool-src/lib/arm64-v8a/libsaasCorePlayer.so")
out=Path("analysis/auto-deep/xrefs/confirmed-arm64-xrefs.txt")

targets={
0x5a0623:"onCaptureScreen",
0x5a0625:"onCaptureScreen",
0x5a3059:"CaptureScreen",
0x5a338c:"nativeOnCaptureScreen",
0x5a3394:"nativeOnCaptureScreen",
0x5a611f:"apsaraCaptureScreen",
0x5a6125:"apsaraCaptureScreen",
0x5a42a6:"enableProjection",
0x59da85:"mEnableProjection",
0x5bc62e:"setForceInsecureDecoder",
0x5bb312:"ContentProtection",
}

TEXT_VA=0x0e08c0
TEXT_OFF=0x0e08c0
TEXT_SIZE=0x4bca78

data=lib.read_bytes()
res=[]

def sext(v,bits):
    sign=1<<(bits-1)
    return v-(1<<bits) if v&sign else v

def adrp_target(ins,pc):
    if (ins & 0x9f000000)!=0x90000000:
        return None
    immlo=(ins>>29)&3
    immhi=(ins>>5)&0x7ffff
    imm=sext((immhi<<2)|immlo,21)<<12
    return (pc & ~0xfff)+imm

def add_target(ins,base):
    if (ins & 0xffc00000)!=0x91000000:
        return None
    if ((ins>>31)&1)!=1:
        return None
    if ((ins>>22)&1)!=0:
        return None
    sh=(ins>>22)&1
    imm12=(ins>>10)&0xfff
    return base+(imm12<<(12 if sh else 0))

for off in range(TEXT_OFF,TEXT_OFF+TEXT_SIZE-4,4):
    ins=struct.unpack_from("<I",data,off)[0]
    pc=TEXT_VA+(off-TEXT_OFF)
    page=adrp_target(ins,pc)
    if page is None:
        continue
    for j in (4,8,12,16):
        if off+j+4>len(data):
            continue
        ins2=struct.unpack_from("<I",data,off+j)[0]
        target=add_target(ins2,page)
        if target in targets:
            res.append(
                f"TEXT_VA=0x{pc:x} FILE_OFF=0x{off:x} "
                f"TARGET=0x{target:x} NAME={targets[target]} "
                f"ADRP=0x{ins:08x} ADD=0x{ins2:08x}"
            )

out.parent.mkdir(parents=True,exist_ok=True)
out.write_text(
"ARM64 CONFIRMED ADRP+ADD REFERENCES\n"
"===================================\n"+
("\n".join(res) if res else "NO_CONFIRMED_ADRP_ADD_XREFS\n"),
encoding="utf-8")
print(out)
print(f"confirmed={len(res)}")
