"""Frozen contract versions (single source of truth in code).

Must match docs/openapi.yaml (info.version + x-contract-version) and
docs/plugin-sdk.md. The contract tests fail the build on any drift.
"""

API_VERSION = "1.0.0"
OPENAPI_VERSION = "1.0.0"
PLUGIN_SDK_VERSION = "1.0.0"
