#!/usr/bin/env bash
set -u
set -o pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: Not inside ReelShort git repository."
  exit 1
}
cd "$ROOT" || exit 1

# Single safe entrypoint. bootstrap-run.sh handles remote-tool selection and
# never merges, resets, rebases, stashes, or overwrites a dirty/diverged checkout.
exec bash tools/reelsec/bootstrap-run.sh "$@"
