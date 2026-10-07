# ReelSec — Gadget Execution Path

## Implemented
The campaign now has an opt-in isolated Frida Gadget path.

### New capability
Set:
- `REELSEC_FRIDA_GADGET=/absolute/path/to/frida-gadget-android-arm64.so`
- `REELSEC_FRIDA_GADGET_ABI=arm64-v8a` (default)
- `REELSEC_FRIDA_GADGET_PORT=27042` (default)
- `REELSEC_USE_GADGET=1`

ReelSec then:
1. copies the Gadget into the isolated instrumented APK only;
2. creates a loopback Gadget listen configuration;
3. injects `System.loadLibrary("frida-gadget")` into the discovered SecShell Application anchor;
4. signs/verifies the resulting APK;
5. deploys it only through the guarded test-device path;
6. forwards the Gadget TCP port with ADB;
7. launches the test package;
8. runs the existing target probe through the Gadget transport;
9. removes the ADB forward after the bounded observation window.

The original APK remains untouched.

## Commits
- `d7f8197a999a52be0fed8f4609de00a66a9dc2c9` — isolated Gadget embedder.
- `0595a17ec016c7adf2c85530fc2bad149b717320` — campaign wiring.
- `2811d690185be5f0608f0ab0e8210abd5145f79a` — Gadget embedding regression test.

## Proof boundary
A Gadget connection alone is not proof. The existing runtime probe only advances the native target proof when it observes:
- module `libsaasCorePlayer.so`;
- target offset `0x27a510`;
- expected vptr `0x717e60`;
- expected slot `+0x108` resolving to `0x27a510`.

Screenshot/recording protection remains a separate behavioral gate.

## Operator command
After placing the matching arm64 Frida Gadget binary on the Termux host:

```bash
export REELSEC_FRIDA_GADGET="$HOME/path/to/frida-gadget-android-arm64.so"
export REELSEC_FRIDA_GADGET_ABI=arm64-v8a
export REELSEC_FRIDA_GADGET_PORT=27042
export REELSEC_USE_GADGET=1
export REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1

cd ~/apk-lab/ReelShort-v4.2.00 && \
git fetch origin main && \
git show origin/main:tools/reelsec/bootstrap-run.sh | bash -s -- campaign ./original.apk
```

If the Gadget binary is absent, the campaign must not pretend the runtime proof succeeded; it should remain on the existing `FRIDA_GADGET_REQUIRED` boundary.


## Latest execution result — 2026-10-07 02:59

The Gadget path was requested, but the operator value was still the documentation placeholder:

`$HOME/path/to/frida-gadget-android-arm64.so`

Campaign `20261007_025929-30334` therefore stopped the isolated instrumentation stage with:

`REELSEC_FRIDA_GADGET not found: /data/data/com.termux/files/home/path/to/frida-gadget-android-arm64.so`

This is an operator-input failure, not runtime evidence. The campaign correctly did **not** claim target execution.

## Hardening applied after that run

- `REELSEC_USE_GADGET=1` now explicitly requires `REELSEC_FRIDA_GADGET` to point to an existing file; the runtime probe returns `GADGET_BINARY_REQUIRED` instead of silently degrading to a timeout.
- Gadget embedding is now truly opt-in through `REELSEC_USE_GADGET`; merely setting a path does not enable embedding.
- Smali injection now reserves two registers and uses separate tag/message registers for the `Log.i` telemetry marker.
- `test_gadget_embed.py` now checks register allocation, Gadget config, and isolated mutation behavior.

Latest implementation commits:
- `3f525c772d72d511392ab63fb7fe23319f8f10e5`
- `2ae795bcd81a6b4399c5720c3df2a4e2b7c9ac4d`
- `89b1e4737b6508c815964fca3c866067482678e9`
- `a6977b034c540c4df808325db3455c645e8a2433`
- `b63cfe3344435dce62cef6a73b9571e4e6b4bb77`

## Next operator gate

Do not run another campaign with the placeholder path. Use the repository fetcher so the Gadget version follows the installed Frida CLI:

`bash tools/reelsec/fetch_frida_gadget.sh`

Then export the printed path, for example:

`export REELSEC_FRIDA_GADGET="$HOME/apk-lab/reelsec-gadget/frida-gadget-<version>-android-arm64.so"`

The fetcher verifies ELF64 and the requested architecture before the file is used. The Android Gadget is a shared library intended for embedding into the target application, and Frida documents the loopback Listen mode used by this campaign. citeturn668280search1turn668280search4

The official Frida release page currently lists 17.22.2 as the latest release (released October 5, 2026). The fetcher intentionally follows the locally installed CLI version rather than silently changing the analysis toolchain. citeturn305384view0

Keep `original.apk` unchanged.
