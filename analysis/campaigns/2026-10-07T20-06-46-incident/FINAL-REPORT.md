# ReelSec Incident Record — 2026-10-07

## Classification

**SAFETY/DESIGN FAILURE — DESTRUCTIVE BASELINE UNINSTALL**

This round is recorded as a failure of the ReelSec platform's safety design,
**not** as a ReelShort application failure. No campaign is re-run.

## What happened

The baseline runtime round executed destructive uninstalls of the test
package (`com.newleaf.app.android.victor`) on the device under the sole
authority of the environment variable `REELSEC_ALLOW_TEST_DEVICE_UNINSTALL=1`.
The application package was removed from the device as a side effect of a
diagnostic round. A blanket environment flag proved to be an insufficient
authorization boundary for a destructive operation.

## Why this is a design failure, not an app failure

* The uninstall was requested by ReelSec's own baseline logic.
* The gate protecting it was a single environment variable — reversible,
  invisible to audit, not bound to a package, user, device, or time window.
* The platform continued the campaign and only surfaced the consequence
  after the fact. The tool did not know when to stop.

## Scientific status (unchanged)

| Link | Status |
|---|---|
| L1 | CONFIRMED |
| L2 | INDICATOR |
| L3 | NOT_PROVEN |
| L4 | NOT_PROVEN |
| SCREENSHOT_BLOCKING | **NOT_PROVEN** |

## Remediation (implemented in this commit)

1. `safety_gate.py` — destructive operations are **DENY by default in code**:
   `UNINSTALL`, `CLEAR_DATA`, `REMOVE_PACKAGE`, `FACTORY_RESET`
   (FACTORY_RESET is never executable, even with authorization).
2. Authorization is a **hash-bound, exact-match, time-bounded document**
   (`destructive-auth-1`): operation + package + user + device serial +
   issued/expires (max 15 min TTL) + authorized_by + reason. Environment
   variables are violations, never authorizations.
3. Every destructive operation passes the full chain:
   gate → package match → user match → device identity → pre-operation
   snapshot → authorization → operation → post-operation verification →
   audit record. Blocks are audited too (`SAFETY-AUDIT.jsonl`).
4. `orchestrator.doctor` blocks the entire platform while any blanket
   destructive flag is set:

       SAFETY: BLOCKED
       REASON: destructive uninstall permission enabled
       No package was modified.
       No runtime campaign executed.

5. `run_baseline_runtime` and the stage-10 signature-mismatch path route
   every uninstall through `safety_gate.execute_destructive`.
6. `test_safety_gate.py` — 20 regression tests make this incident scenario
   structurally impossible (the exact scenario is asserted: platform
   refuses, no uninstall command is ever issued).

## Platform status after remediation

The autonomous pipeline (`reelsec doctor` → safety gate → campaign
orchestrator → collectors → evidence aggregator → git publisher → final
report) is in force. Campaign evidence lands in
`analysis/campaigns/<timestamp>/` with `MANIFEST.json` (SHA-256 per file),
`FINAL-VERDICT.json`, and `FINAL-REPORT.md`, and is published automatically
(`PUBLISH_COMMIT` reported).
