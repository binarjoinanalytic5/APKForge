# ReelSec 3.0 — Phase Status

## Current pipeline

`campaign APK -> SHA-256 -> capability matrix -> Apktool backend -> isolated decode -> decode validation -> decoded inventory -> decoded target -> provenance -> existing static ELF analysis -> conservative proof gate`

## Completed in this phase

- Decoded APK contents are inventoried deterministically.
- Native targets are selected from the decoded APK whenever decoding is ready.
- Repository-root ELF discovery is explicitly marked as fallback.
- `INPUT-PROVENANCE.json` binds the target to the APK hash and analysis root.
- Targets outside the selected analysis root are explicitly classified as `OUTSIDE_ANALYSIS_ROOT`.
- A proof gate separates `PROVEN_STATIC`, `PROVEN_RUNTIME_ORIGINAL`, `PROVEN_ON_INSTRUMENTED_BUILD`, `OBSERVED`, `UNPROVEN`, and `BLOCKED`.
- Screenshot-blocking claims require the complete causal chain: screenshot event, relevant path, target execution, behavioral effect, timing correlation, alternatives considered, and runtime proof.
- Regression tests cover provenance and conservative proof-state transitions.

## Verification

GitHub has not exposed an actual workflow run/status for the branch head in the observed repository state. Tests therefore remain **pending external execution**, not “passed”.

## Security boundary

The existing findings remain unchanged. Static vtable/function relationships do not prove screenshot blocking or original-runtime execution. The jailed Android Frida condition still requires a Gadget/equivalent instrumentation backend before runtime proof can be attempted.

## Next gate

Build the controlled instrumentation backend around the existing SecShell injection point, with evidence capture and explicit separation between original-APK and instrumented-build observations.
