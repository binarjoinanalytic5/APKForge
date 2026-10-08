"""Runner tests: reports for success and every failure mode."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from workers.base import AdapterError, ToolAdapter
from workers.runner import Runner


class OkAdapter(ToolAdapter):
    name = "ok"
    version = "1.0.0"
    tool_name = "t"
    tool_version = "1"
    limits = {"timeout_s": 5, "memory_mb": 64, "cpu": 0.5,
              "network": "none"}

    def run(self, payload):
        assert payload["_limits"]["timeout_s"] == 5
        return {"out_dir": "/tmp/x", "log_lines": ["did work"]}


class BoomAdapter(OkAdapter):
    name = "boom"

    def run(self, payload):
        raise AdapterError("tool exploded")


class WeirdAdapter(OkAdapter):
    name = "weird"

    def run(self, payload):
        raise ValueError("not an adapter error")


class ShapeAdapter(OkAdapter):
    name = "shape"

    def run(self, payload):
        return ["not", "a", "dict"]


def test_success_report():
    report = Runner().run_job("decompile", OkAdapter(),
                              {"job_id": "job-1"})
    assert report["status"] == "succeeded"
    assert report["output"] == {"out_dir": "/tmp/x"}
    assert any("did work" in line for line in report["log_lines"])
    assert report["trace"]["plugin"] == "ok"
    assert report["duration_s"] >= 0


def test_adapter_error_report():
    report = Runner().run_job("decompile", BoomAdapter(), {})
    assert report["status"] == "failed"
    assert report["error"] == "tool exploded"


def test_unexpected_error_fails_closed():
    report = Runner().run_job("decompile", WeirdAdapter(), {})
    assert report["status"] == "failed"
    assert "unexpected" in report["error"]


def test_malformed_output_rejected():
    report = Runner().run_job("decompile", ShapeAdapter(), {})
    assert report["status"] == "failed"
    assert "malformed" in report["error"]
