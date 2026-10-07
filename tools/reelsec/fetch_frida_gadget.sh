#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

ABI="${REELSEC_FRIDA_GADGET_ABI:-arm64-v8a}"
VERSION="${REELSEC_FRIDA_VERSION:-}"
OUT_DIR="${REELSEC_GADGET_DIR:-$HOME/apk-lab/reelsec-gadget}"

if [ -z "$VERSION" ]; then
  command -v frida >/dev/null 2>&1 || { echo "frida CLI not found; install frida-tools first" >&2; exit 2; }
  VERSION="$(frida --version | tr -d '[:space:]')"
fi

case "$ABI" in
  arm64-v8a) ARCH="arm64";;
  armeabi-v7a|armeabi) ARCH="arm";;
  x86) ARCH="x86";;
  x86_64) ARCH="x86_64";;
  *) echo "Unsupported REELSEC_FRIDA_GADGET_ABI: $ABI" >&2; exit 2;;
esac

command -v curl >/dev/null 2>&1 || { echo "curl is required" >&2; exit 2; }
command -v unxz >/dev/null 2>&1 || { echo "unxz is required; install xz-utils" >&2; exit 2; }

mkdir -p "$OUT_DIR"
TMP="$(mktemp "$OUT_DIR/.gadget.XXXXXX.xz")"
trap 'rm -f "$TMP"' EXIT

ASSET="frida-gadget-${VERSION}-android-${ARCH}.so.xz"
BASE="https://github.com/frida/frida/releases/download/$VERSION"
URL="$BASE/$ASSET"
SO="$OUT_DIR/frida-gadget-${VERSION}-android-${ARCH}.so"

API="https://api.github.com/repos/frida/frida/releases/tags/$VERSION"
EXPECTED_SHA256="$(curl -fsSL -H 'Accept: application/vnd.github+json' -H 'User-Agent: ReelSec-Gadget-Fetcher' "$API" | python - "$ASSET" <<'PY'
import json, sys
name = sys.argv[1]
obj = json.load(sys.stdin)
for asset in obj.get("assets", []):
    if asset.get("name") == name:
        digest = asset.get("digest") or ""
        if digest.startswith("sha256:"):
            print(digest.split(":", 1)[1])
            break
raise SystemExit("GitHub release asset digest not found for " + name)
PY
)"

echo "Fetching $URL"
curl -fL --retry 3 --retry-delay 1 -o "$TMP" "$URL"
DOWNLOADED_SHA256="$(sha256sum "$TMP" | awk '{print $1}')"
[ "$DOWNLOADED_SHA256" = "$EXPECTED_SHA256" ] || {
  echo "SHA-256 mismatch for $ASSET" >&2
  echo "expected=$EXPECTED_SHA256" >&2
  echo "actual=$DOWNLOADED_SHA256" >&2
  exit 3
}
unxz -f "$TMP"
mv "${TMP%.xz}" "$SO"
chmod 0644 "$SO"

python - "$SO" "$ARCH" <<'PY'
import struct, sys
path, arch = sys.argv[1:3]
data = open(path, "rb").read(64)
if data[:4] != b"\x7fELF":
    raise SystemExit("Downloaded file is not an ELF shared library")
if data[4] != 2:
    raise SystemExit("Downloaded Gadget is not ELF64")
machine = struct.unpack_from("<H", data, 18)[0]
expected = {"arm64": 183, "arm": 40, "x86": 3, "x86_64": 62}[arch]
if machine != expected:
    raise SystemExit("Gadget machine mismatch: got %s expected %s" % (machine, expected))
print("ELF_OK arch=%s machine=%s" % (arch, machine))
PY

SHA256="$(sha256sum "$SO" | awk '{print $1}')"
echo "GADGET=$SO"
echo "GADGET_SHA256=$SHA256"
echo "GADGET_ABI=$ABI"
echo "GADGET_VERSION=$VERSION"
