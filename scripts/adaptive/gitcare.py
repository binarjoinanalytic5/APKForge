"""Deep repository cleanup & git index recovery (stdlib).

Order for every operation: DETECT -> CLASSIFY -> REPORT ->
PROTECT -> CLEAN -> VERIFY. Source, config, governance, docs and
APK evidence are never deleted; history is never rewritten; a full
re-clone is never the first resort.
"""
from __future__ import annotations

import heapq
import json
import os
import shutil
import subprocess
import time
from pathlib import Path

REQUIRED_SOURCE = ("scripts/apkforge.py", "backend",
                   "frontend/src")

DISPOSABLE_SUFFIXES = {".pyc", ".pyo", ".part", ".tmp"}
DISPOSABLE_DIRS = {"__pycache__", ".pytest_cache", ".mypy_cache",
                   ".ruff_cache", ".hypothesis"}
DISPOSABLE_NAMES = {".DS_Store", "Thumbs.db"}
RUNTIME_KEEP = {"frontend/dist", ".venv", "node_modules"}

ARCHIVE_SUFFIXES = {".zip", ".tar", ".tgz", ".tar.gz", ".gz",
                    ".7z", ".rar", ".iso"}
APK_SUFFIXES = {".apk", ".aab", ".apks", ".xapk"}


class GitCareError(RuntimeError):
    pass


def _now():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


def git(root, *args, timeout=60):
    """Run git (never raises; returns code + combined output)."""
    try:
        proc = subprocess.run(
            ["git", "-C", str(root)] + list(args),
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            timeout=timeout, text=True, errors="replace")
    except (OSError, subprocess.TimeoutExpired) as exc:
        return -1, "git unavailable: %s" % exc
    return proc.returncode, proc.stdout


# -- classification ------------------------------------------------------------
def classify_path(path):
    """Classify a repo-relative path (pure)."""
    text = str(path).replace(os.sep, "/")
    name = text.rsplit("/", 1)[-1]
    lower = text.lower()
    if ".git/" in lower or lower == ".git":
        return "GIT"
    parts = set(lower.split("/"))
    if parts & {item.lower() for item in DISPOSABLE_DIRS}:
        return "CACHE"
    if name in DISPOSABLE_NAMES or lower.endswith(
            tuple(DISPOSABLE_SUFFIXES)):
        return "TEMP"
    if lower.startswith("node_modules/") or \
            "/node_modules/" in lower:
        return "DEPENDENCY_CACHE"
    if lower == ".venv" or lower.startswith(".venv/"):
        return "DEPENDENCY_CACHE"
    if lower.startswith(("tmp/", "temp/")) or \
            "/tmp/" in lower or name.startswith("tmp"):
        return "TEMP"
    if lower.startswith("logs/") or lower.endswith(".log"):
        return "LOG"
    if lower.endswith(tuple(APK_SUFFIXES)):
        return "APK"
    if lower.endswith(tuple(ARCHIVE_SUFFIXES)):
        return "ARCHIVE"
    if lower.endswith((".db", ".sqlite", ".sqlite3")):
        return "DATABASE"
    if lower.startswith((".governance/", "governance/")):
        return "GOVERNANCE"
    if lower.startswith(("docs/", "handover/")) or lower.endswith(
            (".md", ".rst", ".txt", ".adoc")):
        return "DOCUMENTATION"
    if lower in (".env", ".env.example") or lower.endswith(
            (".yaml", ".yml", ".toml", ".ini", ".cfg",
             ".json.example")) or "config" in lower:
        return "CONFIG"
    if lower.startswith("frontend/dist/") or lower.startswith(
            "build/") or lower == "build":
        return "BUILD_OUTPUT"
    if lower.endswith((".py", ".ts", ".vue", ".js", ".sh",
                       ".bat", ".java", ".kt", ".c", ".h",
                       ".rs")):
        return "SOURCE"
    return "UNKNOWN"


def disposable(reason_deep=False):
    """Categories safe to delete (deep adds backup litter)."""
    cats = {"TEMP", "CACHE"}
    if reason_deep:
        cats |= {"LITTER"}
    return cats


def is_litter(name):
    return name.endswith(("~", ".bak", ".orig", ".rej"))


# -- quick gate (runs on every boot; must be fast) -------------------------------
def quick_gate(root, anchors=REQUIRED_SOURCE):
    """Cheap health gate: OK | RECOVERY_REQUIRED | NOT_A_REPO."""
    root = Path(root)
    checks = []

    def check(name, ok, detail=""):
        checks.append({"name": name, "ok": bool(ok),
                       "detail": detail})
        return bool(ok)

    if not (root / ".git").exists():
        check("work-tree", False, "no .git directory")
        return {"verdict": "NOT_A_REPO", "checks": checks}
    code, out = git(root, "rev-parse", "--is-inside-work-tree",
                    timeout=15)
    if not check("work-tree", code == 0
                 and out.strip() == "true", out.strip()[:80]):
        return {"verdict": "RECOVERY_REQUIRED", "checks": checks}
    code, out = git(root, "rev-parse", "--show-toplevel",
                    timeout=15)
    check("toplevel", code == 0, out.strip()[:120])
    code, out = git(root, "branch", "--show-current", timeout=15)
    check("branch", True, out.strip()[:80] or "(detached)")
    code, out = git(root, "rev-parse", "--verify", "HEAD",
                    timeout=15)
    head_ok = check("head", code == 0, out.strip()[:40])
    index_path = root / ".git" / "index"
    check("index-file", index_path.is_file(),
          "%d bytes" % index_path.stat().st_size
          if index_path.is_file() else "absent")
    anchor = next((item for item in anchors
                   if (root / item).exists()), None)
    index_ok = False
    if anchor is not None:
        code, out = git(root, "ls-files", "--error-unmatch",
                        "--", anchor, timeout=30)
        index_ok = check("index", code == 0,
                         "anchor %s %s" % (
                             anchor, "tracked"
                             if code == 0 else out.strip()[:80]))
    else:
        index_ok = check("index", False, "no anchor file found")
    missing = [item for item in anchors
               if not (root / item).exists()]
    check("source", not missing,
          "missing: %s" % ", ".join(missing) if missing
          else "required source present")
    verdict = "OK" if (head_ok and index_ok and not missing) \
        else "RECOVERY_REQUIRED"
    return {"verdict": verdict, "checks": checks}


# -- size analysis ------------------------------------------------------------------
def _walk_sizes(root):
    """Walk worktree (never follows links); returns entries."""
    entries = []
    for current, _dirs, files in os.walk(root,
                                         followlinks=False):
        for name in files:
            full = Path(current) / name
            try:
                if full.is_symlink():
                    continue
                size = full.stat().st_size
            except OSError:
                continue
            entries.append((size, str(full.relative_to(root))))
    return entries


def size_report(root):
    """Worktree vs .git sizes, depth table, top files, large files."""
    root = Path(root)
    entries = _walk_sizes(root)
    total = sum(size for size, _ in entries)
    git_size = sum(size for size, rel in entries
                   if rel == ".git" or rel.startswith(".git/"))
    depth1 = {}
    for size, rel in entries:
        top = rel.split("/", 1)[0]
        depth1[top] = depth1.get(top, 0) + size
    top_files = heapq.nlargest(
        50, entries, key=lambda item: item[0])
    large = []
    for size, rel in entries:
        if size >= 10 * 1024 * 1024:
            large.append({"path": rel, "bytes": size,
                          "class": classify_path(rel)})
    large.sort(key=lambda item: item["bytes"], reverse=True)
    return {"total_bytes": total, "git_bytes": git_size,
            "worktree_bytes": total - git_size,
            "depth1": dict(sorted(depth1.items(),
                                  key=lambda kv: kv[1],
                                  reverse=True)[:20]),
            "top_files": [{"path": rel, "bytes": size}
                          for size, rel in top_files],
            "large_files": large,
            "file_count": len(entries)}


def tracked(path_root, rel):
    code, _ = git(path_root, "ls-files", "--error-unmatch",
                  "--", rel, timeout=30)
    return code == 0


def find_nested_git(root, max_depth=4):
    """Nested .git dirs / backup copies (bounded walk)."""
    root = Path(root)
    found = []
    stack = [(root, 0)]
    while stack:
        current, depth = stack.pop()
        if depth > max_depth:
            continue
        try:
            children = list(current.iterdir())
        except OSError:
            continue
        for child in children:
            if child.name == ".git" and current != root:
                found.append(str(child.relative_to(root)))
            elif child.name in (".git.old", ".git.backup",
                                ".git.bak"):
                found.append(str(child.relative_to(root)))
            elif child.is_dir() and not child.is_symlink() \
                    and child.name != ".git":
                stack.append((child, depth + 1))
    return sorted(found)


# -- full diagnosis ------------------------------------------------------------------
def diagnose(root, run_id, logs_root, fsck_timeout=300):
    """Full diagnosis + JSON artifact (read-only)."""
    root = Path(root)
    out_dir = Path(logs_root) / "git-recovery" / run_id
    out_dir.mkdir(parents=True, exist_ok=True)
    gate = quick_gate(root)
    report = {"run_id": run_id, "at": _now(), "root": str(root),
              "gate": gate, "git": {}, "sizes": {},
              "nested_git": [], "lfs": {}}
    code, out = git(root, "log", "-1", "--oneline", timeout=30)
    report["git"]["head"] = out.strip()[:120] if code == 0 \
        else "unknown: %s" % out.strip()[:80]
    code, out = git(root, "count-objects", "-vH", timeout=60)
    report["git"]["objects"] = out.strip() if code == 0 \
        else "unavailable"
    code, out = git(root, "rev-parse",
                    "--is-shallow-repository", timeout=15)
    report["git"]["shallow"] = out.strip() if code == 0 \
        else "unknown"
    code, out = git(root, "remote", "-v", timeout=15)
    remotes = []
    if code == 0:
        for line in out.splitlines():
            parts = line.split()
            if len(parts) >= 2 and "(fetch)" in line:
                remotes.append("%s %s" % (parts[0],
                                          "[url-redacted]"))
    report["git"]["remotes"] = remotes
    code, out = git(root, "status", "--porcelain=v1",
                    "--untracked-files=no", timeout=120)
    report["git"]["dirty_tracked"] = len(out.splitlines()) \
        if code == 0 else -1
    code, out = git(root, "fsck", "--full", "--no-progress",
                    timeout=fsck_timeout)
    report["git"]["fsck_code"] = code
    index_bad = any(check["name"] == "index"
                    and not check["ok"]
                    for check in gate["checks"])
    if code != 0 and index_bad:
        report["git"]["fsck_note"] = (
            "index unreadable, so this fsck reflects index "
            "state; object health is re-verified during "
            "repair (index removed first)")
    report["git"]["fsck"] = (out.strip().splitlines()[:30]
                             if code == 0 and out.strip()
                             else ([out.strip()[:2000]]
                                   if code != 0 else ["clean"]))
    report["nested_git"] = find_nested_git(root)
    lfs_probe = git(root, "lfs", "version", timeout=15)
    report["lfs"]["installed"] = lfs_probe[0] == 0
    if lfs_probe[0] == 0:
        code, out = git(root, "lfs", "ls-files", timeout=60)
        report["lfs"]["files"] = len(out.splitlines()) \
            if code == 0 and out.strip() else 0
    report["sizes"] = size_report(root)
    for item in report["sizes"]["large_files"]:
        item["tracked"] = tracked(root, item["path"])
    (out_dir / "diagnose.json").write_text(
        json.dumps(report, indent=2), encoding="utf-8")
    return report


# -- index repair (objects + history preserved) -----------------------------------------
def repair_index(root, run_id, logs_root):
    """Backup index, rebuild via reset, verify, fsck."""
    root = Path(root)
    steps = []
    index = root / ".git" / "index"
    backup = root / ".git" / ("index.backup.%s" % run_id)
    if index.is_file():
        shutil.copyfile(index, backup)
        steps.append("index backed up")
    else:
        steps.append("no index file (nothing to back up)")
    index.unlink(missing_ok=True)
    # fsck cannot pass with a broken index in place; with the
    # index removed it validates objects/history alone. This is
    # the fork: objects healthy -> rebuild; objects damaged ->
    # stop (different recovery path, never a blind reset).
    steps.append("index removed (backup kept)")
    code, out = git(root, "fsck", "--full", "--no-progress",
                    timeout=300)
    if code != 0:
        raise GitCareError(
            "object damage, not index-only: %s"
            % out.strip()[:500])
    steps.append("objects verified clean without index")
    code, out = git(root, "reset", "-q", timeout=300)
    if code != 0:
        raise GitCareError("git reset failed: %s"
                           % out.strip()[:300])
    steps.append("index rebuilt from HEAD (worktree untouched; "
                 "staged state reset)")
    for args in (("ls-files",), ("status", "--porcelain=v1",
                                 "--untracked-files=no"),
                 ("diff", "--quiet"), ("diff", "--cached",
                                       "--quiet")):
        code, out = git(root, *args, timeout=120)
        # diff --quiet exits 1 when differences exist: fine.
        ok = code in (0, 1) if args[0] == "diff" else code == 0
        if not ok:
            raise GitCareError("verify %s failed: %s"
                               % (" ".join(args),
                                  out.strip()[:200]))
    steps.append("verify: ls-files/status/diff clean")
    code, out = git(root, "fsck", "--full", "--no-progress",
                    timeout=300)
    steps.append("fsck: %s" % ("clean" if code == 0
                               else out.strip()[:300]))
    if code != 0:
        raise GitCareError("fsck still failing: %s"
                           % out.strip()[:300])
    out_dir = Path(logs_root) / "git-recovery" / run_id
    out_dir.mkdir(parents=True, exist_ok=True)
    payload = {"run_id": run_id, "at": _now(), "steps": steps,
               "backup": str(backup) if backup.is_file()
               else None}
    (out_dir / "repair.json").write_text(json.dumps(payload,
                                                    indent=2),
                                         encoding="utf-8")
    return payload


# -- safe cleanup (disposable only) ------------------------------------------------------
def _runtime_protected(rel):
    text = rel.replace(os.sep, "/")
    return any(text == keep or text.startswith(keep + "/")
               for keep in RUNTIME_KEEP)


def cleanup(root, run_id, logs_root, keep_logs=3, deep=False):
    """Delete disposable data only; report before/after."""
    root = Path(root)
    before = size_report(root)["total_bytes"]
    removed = []
    kept_logs = {}
    entries = sorted(_walk_sizes(root), key=lambda item: item[1])
    for size, rel in entries:
        if rel == ".git" or rel.startswith(".git/"):
            continue
        if _runtime_protected(rel):
            continue
        category = classify_path(rel)
        full = root / rel
        delete = category in disposable(deep)
        if deep and is_litter(rel.rsplit("/", 1)[-1]):
            delete = True
        if category == "LOG" and not delete:
            # keep newest few per directory, drop older runs.
            parent = rel.rpartition("/")[0]
            kept_logs.setdefault(parent, []).append(rel)
            continue
        if delete:
            try:
                full.unlink()
                removed.append({"path": rel, "bytes": size,
                                "class": category})
            except OSError:
                continue
    for _parent, rels in kept_logs.items():
        ordered = sorted(
            rels, key=lambda rel: (root / rel).stat().st_mtime
            if (root / rel).exists() else 0, reverse=True)
        for rel in ordered[keep_logs:]:
            full = root / rel
            try:
                size = full.stat().st_size
                full.unlink()
                removed.append({"path": rel, "bytes": size,
                                "class": "LOG"})
            except OSError:
                continue
    # prune newly-emptied disposable dirs (never source dirs).
    for current, dirs, files in os.walk(root, topdown=False,
                                        followlinks=False):
        if ".git" in Path(current).parts:
            continue
        name = os.path.basename(current)
        if name in DISPOSABLE_DIRS and not dirs and not files:
            try:
                os.rmdir(current)
            except OSError:
                pass
    after = size_report(root)["total_bytes"]
    payload = {"run_id": run_id, "at": _now(), "deep": deep,
               "before_bytes": before, "after_bytes": after,
               "reclaimed_bytes": before - after,
               "removed": removed,
               "removed_count": len(removed)}
    out_dir = Path(logs_root) / "git-recovery" / run_id
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "cleanup.json").write_text(json.dumps(payload,
                                                     indent=2),
                                          encoding="utf-8")
    return payload


def _mb(value):
    return "%.1fMB" % (value / (1024 * 1024))


def write_report(root, run_id, logs_root, diagnose_report=None,
                 cleanup_report=None):
    """Final markdown report (section 26 fields)."""
    root = Path(root)
    diagnose_report = diagnose_report or {}
    cleanup_report = cleanup_report or {}
    sizes = diagnose_report.get("sizes", {})
    gate = diagnose_report.get("gate", {})
    lines = ["# Repository cleanup report", "",
             "run: %s" % run_id, "at: %s" % _now(),
             "root: %s" % root, "",
             "## Verdict", "",
             "gate: %s" % gate.get("verdict", "unknown"), ""]
    if cleanup_report:
        lines += ["## Cleanup", "",
                  "before: %s" % _mb(cleanup_report.get(
                      "before_bytes", 0)),
                  "after: %s" % _mb(cleanup_report.get(
                      "after_bytes", 0)),
                  "reclaimed: %s (%d files)" % (
                      _mb(cleanup_report.get(
                          "reclaimed_bytes", 0)),
                      cleanup_report.get("removed_count", 0)),
                  ""]
    if sizes:
        lines += ["## Sizes", "",
                  "total: %s" % _mb(sizes.get("total_bytes",
                                              0)),
                  ".git: %s" % _mb(sizes.get("git_bytes", 0)),
                  "worktree: %s" % _mb(sizes.get(
                      "worktree_bytes", 0)),
                  "files: %d" % sizes.get("file_count", 0), "",
                  "### Top directories", ""]
        for name, size in (sizes.get("depth1") or {}).items():
            lines.append("- %s: %s" % (name, _mb(size)))
        lines += ["", "### Large files (>=10MB)", ""]
        for item in sizes.get("large_files", [])[:30]:
            lines.append("- %s (%s, %s, tracked=%s)" % (
                item["path"], _mb(item["bytes"]),
                item.get("class", "?"),
                item.get("tracked", "?")))
        if not sizes.get("large_files"):
            lines.append("none")
        lines.append("")
    git_info = diagnose_report.get("git", {})
    if git_info:
        lines += ["## Git", "",
                  "head: %s" % git_info.get("head", "?"),
                  "shallow: %s" % git_info.get("shallow", "?"),
                  "fsck: code %s" % git_info.get("fsck_code",
                                                 "?"),
                  "dirty tracked: %s" % git_info.get(
                      "dirty_tracked", "?"),
                  "remotes: %s" % ", ".join(
                      git_info.get("remotes", []) or ["none"]),
                  ""]
    lines += ["## LFS", "",
              "installed: %s" %
              diagnose_report.get("lfs", {}).get("installed",
                                                 "?"), "",
              "## Nested git", ""]
    nested = diagnose_report.get("nested_git", [])
    lines.append(", ".join(nested) if nested else "none")
    lines += ["", "## Guidance", "",
              "- Large tracked APK/archives/binaries do not "
              "belong in git history: prefer release assets, "
              "external artifact storage, or Git LFS for new "
              "files.",
              "- History surgery (filter-repo/BFG) rewrites "
              "commit IDs: never automatic; needs explicit "
              "approval.",
              "- If .git dominates the size, the cause is "
              "history, not the worktree: do not fix it by "
              "deleting worktree files.", ""]
    out_dir = Path(logs_root) / "git-recovery" / run_id
    out_dir.mkdir(parents=True, exist_ok=True)
    path = out_dir / "report.md"
    path.write_text("\n".join(lines), encoding="utf-8")
    return path


def auto(root, run_id, logs_root, say=None):
    """Gate -> diagnose -> repair(index-only) -> cleanup -> gate."""
    say = say or (lambda message: None)
    gate = quick_gate(root)
    say("git gate: %s" % gate["verdict"])
    if gate["verdict"] == "NOT_A_REPO":
        return {"verdict": "NOT_A_REPO", "actions": ["skip"]}
    actions = ["diagnose"]
    report = diagnose(root, run_id, logs_root)
    index_bad = any(check["name"] == "index"
                    and not check["ok"]
                    for check in gate["checks"])
    if gate["verdict"] == "RECOVERY_REQUIRED" and index_bad:
        say("index unreadable: rebuilding index (backup kept, "
            "objects verified first)")
        try:
            repair_index(root, run_id, logs_root)
            actions.append("repair-index")
        except GitCareError as exc:
            say("repair refused: %s" % exc)
            actions.append("repair-refused:%s" % str(exc)[:80])
    cleaned = cleanup(root, run_id, logs_root)
    actions.append("cleanup:%d" % cleaned["removed_count"])
    final = quick_gate(root)
    write_report(root, run_id, logs_root, report, cleaned)
    actions.append("report")
    return {"verdict": final["verdict"], "actions": actions,
            "report": report, "cleanup": cleaned}
