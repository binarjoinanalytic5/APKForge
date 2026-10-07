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
EXPECTED_SHA256="$(curl -fsSL -H 'Accept: application/vnd.github+json' -H 'User-Agent: ReelSec-Gadget-Fetcher' "$API" | python -c 'import json,sys; name=sys.argv[1]; obj=json.load(sys.stdin); digests=[a.get("digest","") for a in obj.get("assets",[]) if a.get("name")==name]; d=digests[0] if digests else ""; print(d.split(":",1)[1] if d.startswith("sha256:") else ""); sys.exit(0 if d.startswith("sha256:") else 1)' "$ASSET")"

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
machine = struct.unpack_from("<H", data, 18)[0]
expected_class = {"arm64": 2, "arm": 1, "x86": 1, "x86_64": 2}[arch]
expected = {"arm64": 183, "arm": 40, "x86": 3, "x86_64": 62}[arch]
if data[4] != expected_class:
    raise SystemExit("Gadget ELF class mismatch: got %s expected %s" % (data[4], expected_class))
if machine != expected:
    raise SystemExit("Gadget machine mismatch: got %s expected %s" % (machine, expected))
print("ELF_OK arch=%s machine=%s" % (arch, machine))
PY

SHA256="$(sha256sum "$SO" | awk '{print $1}')"
echo "GADGET=$SO"
echo "GADGET_SHA256=$SHA256"
echo "GADGET_ABI=$ABI"
echo "GADGET_VERSION=$VERSION"
