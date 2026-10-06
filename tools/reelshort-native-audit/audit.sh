#!/usr/bin/env bash
set +e
set +u
ROOT="$(cd "$(dirname "\${BASH_SOURCE[0]}")/../.." && pwd)"
TS="$(date +%Y%m%d_%H%M%S)"
OUT="$ROOT/analysis/sec-shell-deep-v1/vtable-resolution-$TS"
mkdir -p "$OUT"
exec > >(tee -a "$OUT/run.log") 2>&1
echo "ReelShort Native Audit"; echo "ROOT=$ROOT"; echo "OUT=$OUT"

STRINGS_BIN="$(command -v strings 2>/dev/null)"
READELF_BIN="$(command -v readelf 2>/dev/null || command -v llvm-readelf 2>/dev/null)"
OBJDUMP_BIN="$(command -v llvm-objdump 2>/dev/null || command -v objdump 2>/dev/null)"
printf 'strings=%s\nreadelf=%s\nobjdump=%s\n' "\${STRINGS_BIN:-MISSING}" "\${READELF_BIN:-MISSING}" "\${OBJDUMP_BIN:-MISSING}" > "$OUT/tools.txt"

find "$ROOT" -type f \( -name '*.so' -o -name '*.elf' \) 2>/dev/null | sort > "$OUT/all-elf-files.txt"
TARGET=""
while IFS= read -r f; do
  [ -n "$STRINGS_BIN" ] || break
  m="$("$STRINGS_BIN" -a "$f" 2>/dev/null | grep -E -m1 'ActiveDecoder|avcodecDecoder|SuperMediaPlayer|queueSecureInputBuffer|setOutputSurface|ContentProtection|WideVineDrmHandler' 2>/dev/null)"
  if [ -n "$m" ]; then TARGET="$f"; echo "MATCH=$m" > "$OUT/target-detection.txt"; break; fi
done < "$OUT/all-elf-files.txt"

if [ -z "$TARGET" ]; then
  echo "TARGET_NOT_FOUND" | tee "$OUT/TARGET-STATUS.txt"
else
  echo "$TARGET" | tee "$OUT/TARGET-ELF.txt"
  file "$TARGET" > "$OUT/target-file-info.txt" 2>&1
  sha256sum "$TARGET" > "$OUT/target-sha256.txt" 2>&1
fi

if [ -n "$TARGET" ] && [ -n "$READELF_BIN" ]; then
  "$READELF_BIN" -SW "$TARGET" > "$OUT/sections.txt" 2>&1
  "$READELF_BIN" -lW "$TARGET" > "$OUT/program-headers.txt" 2>&1
  "$READELF_BIN" -Ws "$TARGET" > "$OUT/all-symbols.txt" 2>&1
  grep -Ei 'ActiveDecoder|avcodecDecoder|SuperMediaPlayer|setOutputSurface|queueSecureInputBuffer|setForceInsecureDecoder|isProtected|setProtected|CaptureScreen|ANativeWindow|Surface' "$OUT/all-symbols.txt" > "$OUT/relevant-symbols.txt" 2>/dev/null
fi

if [ -n "$TARGET" ] && [ -n "$STRINGS_BIN" ]; then
  "$STRINGS_BIN" -a -t x "$TARGET" > "$OUT/strings-offsets.txt" 2>&1
  grep -Ei 'protected|secure|Surface|ANativeWindow|EGL|GRALLOC|AHardwareBuffer|MediaCodec|FLAG_SECURE|screenshot|screen.?capture|recording|WideVine|ContentProtection|queueSecureInputBuffer|setOutputSurface|setForceInsecureDecoder' "$OUT/strings-offsets.txt" > "$OUT/security-strings.txt" 2>/dev/null
fi

if [ -n "$TARGET" ]; then
python3 - "$TARGET" "$OUT" <<'PY'
import sys,struct,os,hashlib
p=sys.argv[1]; out=sys.argv[2]; d=open(p,'rb').read()
START,END,SLOT=0x717ce0,0x718080,0x717f68
def u16(o): return struct.unpack_from('<H',d,o)[0]
def u32(o): return struct.unpack_from('<I',d,o)[0]
def u64(o): return struct.unpack_from('<Q',d,o)[0]
with open(os.path.join(out,'elf-python-analysis.txt'),'w') as f:
    f.write(f'FILE={p}\nSIZE={len(d)}\nSHA256={hashlib.sha256(d).hexdigest()}\n')
    if d[:4]!=b'\x7fELF' or d[4]!=2 or d[5]!=1:
        f.write('UNSUPPORTED_OR_NOT_ELF\n'); raise SystemExit
    phoff,phentsz,phnum=u64(32),u16(54),u16(56)
    def vaoff(va):
        for i in range(phnum):
            o=phoff+i*phentsz
            if u32(o)==1:
                po,pv,pfs=u64(o+8),u64(o+16),u64(o+32)
                if pv<=va<pv+pfs: return po+(va-pv)
        return None
    for n,v in [('VTABLE_START',START),('ADDRESS_POINT',0x717e60),('CRITICAL_SLOT',SLOT),('VTABLE_END',END-1)]:
        f.write(f'{n}=VA:{v:#x} FILE_OFFSET:{vaoff(v)}\n')
    so=vaoff(SLOT); a=vaoff(START); b=vaoff(END-1)
    if so is None:
        f.write('CRITICAL_SLOT_NOT_FILE_BACKED\n'); raise SystemExit
    raw=d[so:so+8]; ptr=struct.unpack('<Q',raw)[0]
    text=f'VIRTUAL_ADDRESS=0x717f68\nFILE_OFFSET={so:#x}\nRAW_BYTES={" ".join(f"{x:02x}" for x in raw)}\nFUNCTION_POINTER={ptr:#x}\n'
    f.write(text)
    open(os.path.join(out,'CRITICAL-FUNCTION-POINTER.txt'),'w').write(text)
    if a is not None and b is not None:
        chunk=d[a:b+1]
        with open(os.path.join(out,'vtable-qwords.txt'),'w') as q:
            for i in range(0,len(chunk)-7,8):
                q.write(f'{START+i:016x} -> {struct.unpack_from("<Q",chunk,i)[0]:016x}\n')
PY
fi

if [ -n "$TARGET" ] && [ -n "$OBJDUMP_BIN" ]; then
  "$OBJDUMP_BIN" -d --start-address=0x27ae80 --stop-address=0x27b280 "$TARGET" > "$OUT/dispatch-sites.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x2783c0 --stop-address=0x278500 "$TARGET" > "$OUT/ActiveDecoder-constructor.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x27702c --stop-address=0x277370 "$TARGET" > "$OUT/avcodecDecoder-init_decoder.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x2777f4 --stop-address=0x277a90 "$TARGET" > "$OUT/avcodecDecoder-enqueue_decoder.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x27d02c --stop-address=0x27d13c "$TARGET" > "$OUT/ActiveDecoder-open.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x27d304 --stop-address=0x27d780 "$TARGET" > "$OUT/ActiveDecoder-decode_func.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x27dcf4 --stop-address=0x27dfc0 "$TARGET" > "$OUT/ActiveDecoder-thread_send_packet.txt" 2>&1
  "$OBJDUMP_BIN" -d --start-address=0x112e80 --stop-address=0x113000 "$TARGET" > "$OUT/onCaptureScreen-dispatch.txt" 2>&1
fi

cat > "$OUT/VTable-RESOLUTION-REPORT.md" <<EOF
# ReelShort Native VTable Resolution
Target slot: 0x717f68
Calculated path: ActiveDecoder object -> address-point ~= 0x717e60 -> +0x108 -> 0x717f68
Known dispatch sites: 0x27af94, 0x27b148, 0x27b220
The raw pointer must be extracted from the ELF before assigning a callee or Screenshot-blocking meaning.
Generated: $(date)
EOF

echo "REPORT=$OUT"
if [ -f "$OUT/CRITICAL-FUNCTION-POINTER.txt" ]; then cat "$OUT/CRITICAL-FUNCTION-POINTER.txt"; else echo "CRITICAL-FUNCTION-POINTER.txt NOT PRODUCED"; fi

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git add "$OUT" >/dev/null 2>&1
  git commit -m "analysis: automated native vtable audit" >/dev/null 2>&1
  branch="$(git branch --show-current 2>/dev/null)"
  if [ -n "$branch" ]; then git push origin "$branch" > "$OUT/git-push.txt" 2>&1; echo "GIT_PUSH_EXIT=$?" | tee "$OUT/GIT-STATUS.txt"; fi
fi
echo "FINISHED=$(date)"
exit 0
