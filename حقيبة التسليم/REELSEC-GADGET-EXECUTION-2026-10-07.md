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
