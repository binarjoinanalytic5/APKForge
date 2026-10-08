#!/usr/bin/env bash
set -u
set -o pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: Not inside ReelShort git repository."
  exit 1
}
cd "$ROOT" || exit 1

REMOTE="${REELSEC_REMOTE:-origin}"
BRANCH="${REELSEC_BRANCH:-main}"
TOOL="tools/reelsec/reelsec.py"
WRAPPER="tools/reelsec/update-and-run.sh"

git fetch "$REMOTE" "$BRANCH" || {
  echo "ERROR: git fetch failed."
  exit 1
}

# Never destroy or stash investigation work automatically.
STATUS="$(git status --porcelain 2>/dev/null)"
LOCAL="$(git rev-parse HEAD)"
REMOTE_SHA="$(git rev-parse "$REMOTE/$BRANCH")"
AHEAD="$(git rev-list --count "$REMOTE/$BRANCH"..HEAD 2>/dev/null || echo 0)"
BEHIND="$(git rev-list --count HEAD.."$REMOTE/$BRANCH" 2>/dev/null || echo 0)"

# Only fast-forward a completely clean checkout that is strictly behind.
# Divergence is not an error: run the newest remote tool without merging.
if [ -z "$STATUS" ] && [ "$AHEAD" = "0" ] && [ "$BEHIND" != "0" ]; then
  git merge --ff-only "$REMOTE/$BRANCH" >/dev/null 2>&1 || true
  LOCAL="$(git rev-parse HEAD)"
fi

# Clean and already synchronized: run the checked-out tool.
# The Python entrypoint must propagate its main() return code via SystemExit.
if [ "$LOCAL" = "$REMOTE_SHA" ] && [ -f "$TOOL" ]; then
  chmod +x "$TOOL" "$WRAPPER" 2>/dev/null || true
  # We already fetched origin/main above; tell ReelSec to reuse that ref so
  # one bootstrap invocation performs exactly one network fetch.
  REELSEC_ROOT="$ROOT" REELSEC_ORIGIN_READY="$REMOTE/$BRANCH" exec python3 "$TOOL" "$@"
fi

# Dirty/diverged tree: do not merge, reset, rebase, stash, or overwrite anything.
# Materialize the complete remote ReelSec Python package into an isolated
# temporary tree so sibling imports (environment.py, proof_gate.py, etc.)
# resolve correctly even though reelsec.py itself is executed from /tmp.
STAGE="$(mktemp -d -t reelsec-remote.XXXXXX)"
trap 'rm -rf "$STAGE"' EXIT

PY_FILES="$(git ls-tree -r --name-only "$REMOTE/$BRANCH" -- tools/reelsec | grep -E '\.py$' || true)"
if [ -z "$PY_FILES" ]; then
  echo "ERROR: No ReelSec Python modules found on $REMOTE/$BRANCH."
  exit 1
fi

while IFS= read -r REL; do
  [ -n "$REL" ] || continue
  DEST="$STAGE/$REL"
  mkdir -p "$(dirname "$DEST")"
  if ! git show "$REMOTE/$BRANCH:$REL" > "$DEST"; then
    echo "ERROR: Could not retrieve $REL from $REMOTE/$BRANCH."
    exit 1
  fi
done <<< "$PY_FILES"

chmod +x "$STAGE/$TOOL" 2>/dev/null || true
REELSEC_ROOT="$ROOT" REELSEC_ORIGIN_READY="$REMOTE/$BRANCH" \
  PYTHONPATH="$STAGE/tools/reelsec" python3 "$STAGE/$TOOL" "$@"
STATUS=$?

echo
echo "REELSEC_BOOTSTRAP_STATUS=$STATUS"
echo "LOCAL_CHANGES_PRESERVED=YES"
echo "REMOTE_TOOL_SOURCE=$REMOTE/$BRANCH:$TOOL"
echo "REMOTE_MODULE_STAGE=$STAGE"
exit "$STATUS"
