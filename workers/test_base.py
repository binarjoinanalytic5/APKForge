"""Adapter interface tests (Phase 0, stdlib only)."""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

from base import AdapterError, AdapterRegistry, ToolAdapter


class EchoAdapter(ToolAdapter):
    name = "echo-probe"
    version = "0.1.0"
    tool_name = "example-echo"
    tool_version = "0.1.0"
    limits = {"timeout_s": 30, "memory_mb": 256, "cpu": 0.5,
              "network": "none"}

    def run(self, payload):
        if not isinstance(payload, dict):
            raise AdapterError("payload must be an object")
        return {"echo": payload, "adapter": self.describe()}


def _manifest(**over):
    manifest = {"name": "echo-probe", "version": "0.1.0",
                "sdk_version": "1.0.0",
                "tool": {"name": "example-echo", "version": "0.1.0"},
                "runtime": {"command": ["echo"], "timeout_s": 30,
                            "memory_mb": 256, "cpu": 0.5,
                            "network": "none"},
                "license": "Apache-2.0"}
    manifest.update(over)
    return manifest


def test_register_and_run_echo():
    registry = AdapterRegistry()
    registry.register(_manifest(), EchoAdapter())
    assert registry.names() == ["echo-probe"]
    out = registry.get("echo-probe").run({"ping": 1})
    assert out["echo"] == {"ping": 1}
    assert out["adapter"]["tool"]["name"] == "example-echo"


def test_manifest_validated_fail_closed():
    registry = AdapterRegistry()
    incomplete = _manifest()
    del incomplete["tool"]
    with pytest.raises(AdapterError):
        registry.register(incomplete, EchoAdapter())
    with pytest.raises(AdapterError):
        registry.register(_manifest(sdk_version="9.9.9"), EchoAdapter())
    with pytest.raises(AdapterError):
        registry.register(_manifest(), object())
    registry.register(_manifest(), EchoAdapter())
    with pytest.raises(AdapterError):
        registry.register(_manifest(), EchoAdapter())
    with pytest.raises(AdapterError):
        registry.get("missing")
