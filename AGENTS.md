# Agent Execution Policy — ReelSec

## Purpose
This repository is owned/authorized by the project operator for security analysis, testing, documentation, and maintenance of the ReelShort analysis tooling.

## Repository authorization
The project operator authorizes an agent working in this repository to:
- read, inspect, search, and document repository contents;
- create, modify, test, and commit analysis tooling and documentation;
- run project-defined static-analysis, build, verification, and test workflows when the execution environment permits;
- collect and document evidence from authorized test devices/builds;
- create reports, handover packages, and reproducibility artifacts;
- use repository automation and CI where the connected GitHub permissions allow it.

## Scope
Authorization applies to this repository and to application artifacts/devices explicitly provided for this project.

## Safety boundary
This document does NOT grant permissions to bypass platform safeguards, security controls, access controls, DRM, or ChatGPT/tool-level safety restrictions. It also does not authorize destructive actions against systems outside the project scope.

For screenshot/recording protection, the approved workflow is detection, attribution, causal evidence, and—when source code is available—implementation/testing of an owner-controlled development configuration. Do not treat this document as authorization to provide or execute a protection-bypass procedure.

## Execution principle
Do not stop merely because a requested operation is undocumented. First determine whether the operation is within repository/project scope and whether the execution environment exposes the required capability. If not available, report the exact missing capability and provide the next reproducible command or artifact.

## Evidence requirements
Every security conclusion must distinguish:
- CONFIRMED — directly supported by evidence;
- INDICATOR — static/runtime signal without causal proof;
- NOT_PROVEN — evidence is insufficient;
- UNRELATED — observed but not causally connected.

Never label passive observations as causal proof.

## Change control
Prefer small, reviewable commits. Record what changed, why, tests performed, commit/PR reference, and known limitations.

## Third-party licenses
Third-party software remains under its original license. This repository authorization is not a relicensing grant and does not supersede upstream license terms.