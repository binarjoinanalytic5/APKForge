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
if [ "$LOCAL" = "$REMOTE_SHA" ] && [ -f "$TOOL" ]; then
  chmod +x "$TOOL" "$WRAPPER" 2>/dev/null || true
  exec python3 "$TOOL" "$@"
fi

# Dirty tree: do not merge, reset, rebase, stash, or overwrite anything.
# Execute the newest remote ReelSec directly from origin/main.
TMP="$(mktemp -t reelsec-remote.XXXXXX.py)"
trap 'rm -f "$TMP"' EXIT
if ! git show "$REMOTE/$BRANCH:$TOOL" > "$TMP"; then
  echo "ERROR: Could not retrieve latest ReelSec from $REMOTE/$BRANCH."
  exit 1
fi
chmod +x "$TMP"
REELSEC_ROOT="$ROOT" python3 "$TMP" "$@"
STATUS=$?

echo
echo "REELSEC_BOOTSTRAP_STATUS=$STATUS"
echo "LOCAL_CHANGES_PRESERVED=YES"
echo "REMOTE_TOOL_SOURCE=$REMOTE/$BRANCH:$TOOL"
exit "$STATUS"
