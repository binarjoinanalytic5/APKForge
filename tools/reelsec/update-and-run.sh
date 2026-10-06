#!/usr/bin/env bash
set -u
ROOT="$(git rev-parse --show-toplevel)" || exit 1
cd "$ROOT" || exit 1
# Synchronize without destroying local investigation work. If branches diverge, create a local merge commit.
git fetch origin main || exit 1
if ! git merge --ff-only origin/main >/dev/null 2>&1; then
  git merge --no-edit origin/main || exit 1
fi
chmod +x tools/reelsec/reelsec.py
exec python3 tools/reelsec/reelsec.py "$@"
