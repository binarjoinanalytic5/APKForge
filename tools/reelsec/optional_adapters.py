#!/usr/bin/env python3
"""Optional read-only adapters for established open-source Android analysis tools.

Adapters never patch, rebuild, sign, inject, or alter an APK. They only:
* detect installed toolchains;
* run bounded static/read-only commands when a suitable analysis root exists;
* preserve stdout/stderr and exit status as evidence.

Supported adapters:
- mobsfscan: static source-pattern scan when installed.
- radare2: ELF header/symbol inventory when an ELF is supplied.
- mobSF: availability/version only; server orchestration is intentionally external.
- objection: availability/version only; runtime observation remains under ReelSec's
  existing guarded instrumentation path.
"""
from __future__ import annotations

import json
import os
import shutil
import subprocess
from pathlib import Path
from typing import Dict, Iterable, List, Optional


ADAPTERS = ("mobsfscan", "radare2", "jadx", "mobsf", "objection")


def _which(names: Iterable[str]) -> Optional[str]:
    for name in names:
        path = shutil.which(name)
        if path:
            return path
    return None


def _run(cmd: List[str], timeout: int = 60) -> Dict:
    try:
        proc = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            errors="replace",
            timeout=timeout,
            check=False,
        )
        return {
            "status": "PASS" if proc.returncode == 0 else "FAILED",
            "returncode": proc.returncode,
            "command": cmd,
            "output": proc.stdout[-12000:],
        }
    except subprocess.TimeoutExpired as exc:
        return {
            "status": "TIMEOUT",
            "returncode": None,
            "command": cmd,
            "output": (exc.stdout or "")[-12000:] if isinstance(exc.stdout, str) else "",
        }
    except OSError as exc:
        return {"status": "FAILED", "returncode": None, "command": cmd, "error": str(exc)}


def _mobsfscan(root: Path) -> Dict:
    tool = _which(("mobsfscan",))
    if not tool:
        return {"status": "UNAVAILABLE", "tool": "mobsfscan"}
    result = _run([tool, "--version"])
    result["tool"] = "mobsfscan"
    if root.is_dir():
        scan = _run([tool, "--json", str(root)], timeout=180)
        result["scan"] = scan
    return result


def _radare2(elf: Optional[Path]) -> Dict:
    tool = _which(("r2", "radare2"))
    if not tool:
        return {"status": "UNAVAILABLE", "tool": "radare2"}
    result = _run([tool, "-v"])
    result["tool"] = "radare2"
    if elf and elf.is_file():
        # r2 -2qc executes analysis commands without modifying the input file.
        result["elf_inventory"] = _run(
            [tool, "-2", "-q", "-c", "iI;is", str(elf)], timeout=90
        )
    return result


def _jadx(apk: Optional[Path]) -> Dict:\n    tool = _which(("jadx",))\n    if not tool:\n        return {"status": "UNAVAILABLE", "tool": "jadx"}\n    result = _run([tool, "--version"])\n    result["tool"] = "jadx"\n    if apk and apk.is_file():\n        out = apk.parent / ".reelsec-jadx"\n        out.mkdir(parents=True, exist_ok=True)\n        # Decompile into a disposable workspace; input APK is never modified.\n        result["decompile"] = _run(\n            [tool, "-d", str(out), str(apk)], timeout=300\n        )\n        result["output_dir"] = str(out)\n    return result\n\n\ndef _availability(name: str, commands: Iterable[str]) -> Dict:
    tool = _which(commands)
    if not tool:
        return {"status": "UNAVAILABLE", "tool": name}
    result = _run([tool, "--version"])
    result["tool"] = name
    result["path"] = tool
    return result


def run(
    root: str | Path,
    *,
    elf: str | Path | None = None,
    requested: str = "auto",
    timeout: int = 180,
) -> Dict:
    """Run selected optional adapters and return a stable JSON evidence record."""
    root_path = Path(root).expanduser().resolve()
    elf_path = Path(elf).expanduser().resolve() if elf else None\n    apk_path = Path(os.environ["REELSEC_INPUT_APK"]).expanduser().resolve() if os.environ.get("REELSEC_INPUT_APK") else None
    names = list(ADAPTERS) if requested.strip().lower() in ("", "auto", "all") else [
        n.strip().lower() for n in requested.split(",") if n.strip()
    ]
    unknown = [n for n in names if n not in ADAPTERS]
    if unknown:
        raise ValueError("unknown adapters: " + ", ".join(sorted(set(unknown))))

    results = {}
    for name in names:
        if name == "mobsfscan":
            results[name] = _mobsfscan(root_path)
        elif name == "radare2":
            results[name] = _radare2(elf_path)
        elif name == "jadx":\n            results[name] = _jadx(apk_path)\n        elif name == "mobsf":
            results[name] = _availability("mobsf", ("mobsf", "mobsfconsole"))
        elif name == "objection":
            results[name] = _availability("objection", ("objection",))
    return {
        "schema_version": "reelsec-optional-adapters-1",
        "read_only": True,
        "root": str(root_path),
        "elf": str(elf_path) if elf_path else None,\n        "apk": str(apk_path) if apk_path else None,
        "requested": names,
        "results": results,
        "causal_proof": False,
        "interpretation": "OPTIONAL_TOOL_EVIDENCE_ONLY",
        "safety_boundary": (
            "Adapters do not patch, disable protections, inject hooks, sign, rebuild, "
            "or modify the input APK."
        ),
    }


def write_report(result: Dict, output: str | Path) -> Path:
    path = Path(output).expanduser().resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return path


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="ReelSec optional read-only tool adapters")
    parser.add_argument("root")
    parser.add_argument("--elf")
    parser.add_argument("--adapters", default="auto")
    parser.add_argument("-o", "--output", default="OPTIONAL-ADAPTERS.json")
    args = parser.parse_args()
    result = run(args.root, elf=args.elf, requested=args.adapters)
    write_report(result, args.output)
    print("REPORT=" + str(Path(args.output).expanduser().resolve()))
