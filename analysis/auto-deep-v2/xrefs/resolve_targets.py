#!/usr/bin/env python3

import re
import sys

DIS = sys.argv[1]
TARGETS = sys.argv[2]
OUT = sys.argv[3]

RX = re.compile(
    r'^\s*([0-9a-fA-F]+):\s+'
    r'([0-9a-fA-F]{8})\s+'
    r'(.+?)\s*$'
)

ins = []

with open(DIS, "r", encoding="utf-8", errors="replace") as f:
    for line in f:
        m = RX.match(line)
        if not m:
            continue

        va = int(m.group(1), 16)
        word = int(m.group(2), 16)
        text = m.group(3).strip()

        ins.append((va, word, text))

targets = {}

with open(TARGETS, "r", encoding="utf-8") as f:
    for line in f:
        p = line.rstrip("\n").split("\t")

        if len(p) >= 3 and p[0].startswith("0x"):
            targets[int(p[0], 16)] = p[2]

by_va = {a: i for i, (a, _, _) in enumerate(ins)}

def sx(v, bits):
    sign = 1 << (bits - 1)
    return v - (1 << bits) if v & sign else v

def adrp_target(pc, w):
    if (w & 0x9f000000) != 0x90000000:
        return None

    immlo = (w >> 29) & 0x3
    immhi = (w >> 5) & 0x7ffff

    imm21 = (immhi << 2) | immlo
    imm21 = sx(imm21, 21)

    return (pc & ~0xfff) + (imm21 << 12)

def adr_target(pc, w):
    if (w & 0x9f000000) != 0x10000000:
        return None

    immlo = (w >> 29) & 0x3
    immhi = (w >> 5) & 0x7ffff

    imm21 = (immhi << 2) | immlo
    imm21 = sx(imm21, 21)

    return pc + imm21

def add_imm(w):
    # ADD (immediate), 64-bit
    if (w & 0xffc00000) != 0x91000000:
        return None

    rn = (w >> 5) & 31
    rd = w & 31
    imm12 = (w >> 10) & 0xfff
    shift = (w >> 22) & 3

    if shift == 1:
        imm12 <<= 12
    elif shift != 0:
        return None

    return rn, rd, imm12

def ldr_literal_target(pc, w):
    # LDR Xt, label
    if (w & 0x3b000000) != 0x58000000:
        return None

    imm19 = (w >> 5) & 0x7ffff
    imm19 = sx(imm19, 19)

    return pc + (imm19 << 2)

hits = []

for i, (va, w, text) in enumerate(ins):

    # --------------------------------------------------------
    # ADRP + ADD
    # --------------------------------------------------------

    t = adrp_target(va, w)

    if t is not None:
        rd = w & 31

        for j in range(1, 5):
            if i + j >= len(ins):
                break

            va2, w2, text2 = ins[i + j]
            a = add_imm(w2)

            if a is None:
                continue

            rn, rd2, imm = a

            if rn != rd or rd2 != rd:
                continue

            final = t + imm

            if final in targets:
                hits.append({
                    "target": final,
                    "name": targets[final],
                    "xref": va,
                    "method": f"ADRP+ADD@+0x{va2-va:x}",
                    "detail": f"{text} || {text2}"
                })

    # --------------------------------------------------------
    # ADR
    # --------------------------------------------------------

    t = adr_target(va, w)

    if t is not None and t in targets:
        hits.append({
            "target": t,
            "name": targets[t],
            "xref": va,
            "method": "ADR",
            "detail": text
        })

    # --------------------------------------------------------
    # LDR literal
    # --------------------------------------------------------

    t = ldr_literal_target(va, w)

    if t is not None and t in targets:
        hits.append({
            "target": t,
            "name": targets[t],
            "xref": va,
            "method": "LDR-LITERAL",
            "detail": text
        })

# Deduplicate
seen = set()
unique = []

for h in hits:
    k = (
        h["target"],
        h["xref"],
        h["method"],
        h["name"]
    )

    if k in seen:
        continue

    seen.add(k)
    unique.append(h)

unique.sort(key=lambda x: (x["target"], x["xref"]))

with open(OUT, "w", encoding="utf-8") as f:
    f.write("============================================================\n")
    f.write("CONFIRMED ARM64 XREFS\n")
    f.write("============================================================\n")
    f.write(f"confirmed={len(unique)}\n\n")

    for h in unique:
        f.write(f"TARGET : 0x{h['target']:x}\n")
        f.write(f"NAME   : {h['name']}\n")
        f.write(f"XREF   : 0x{h['xref']:x}\n")
        f.write(f"METHOD : {h['method']}\n")
        f.write(f"CODE   : {h['detail']}\n")
        f.write("\n")
