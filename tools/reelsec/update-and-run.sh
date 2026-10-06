#!/usr/bin/env bash
set -u
cd "$(git rev-parse --show-toplevel)" || exit 1
git pull --ff-only origin main || exit 1
chmod +x tools/reelsec/reelsec.py
exec python3 tools/reelsec/reelsec.py "$@"
