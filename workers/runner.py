"""Job runner: one adapter invocation with limits + a report.

The runner never guesses: adapter failures, timeouts, and malformed
outputs all become explicit `failed` reports with log lines. Success
requires a JSON-able dict output from the adapter.
"""
import time

from .base import AdapterError


class Runner:
    def __init__(self, default_timeout_s=600):
        self.default_timeout_s = default_timeout_s

    def run_job(self, kind, adapter, payload):
        started = time.monotonic()
        describe = adapter.describe()
        log_lines = ["runner: %s %s via %s (%s)" % (
            kind, payload.get("job_id", "?"), describe["name"],
            describe["tool"]["name"])]
        limits = {"timeout_s": self.default_timeout_s}
        limits.update(getattr(adapter, "limits", {}) or {})
        payload = dict(payload, _limits=limits)
        try:
            output = adapter.run(payload)
        except AdapterError as exc:
            log_lines.append("adapter error: %s" % exc)
            return self._report("failed", None, log_lines, started,
                                error=str(exc))
        except Exception as exc:  # fail closed, never crash the worker
            log_lines.append("unexpected error: %r" % exc)
            return self._report("failed", None, log_lines, started,
                                error="unexpected: %r" % exc)
        duration = time.monotonic() - started
        if not isinstance(output, dict):
            log_lines.append("adapter returned non-object output")
            return self._report("failed", None, log_lines, started,
                                error="malformed adapter output")
        log_lines.extend("plugin: %s" % line
                         for line in output.pop("log_lines", []))
        log_lines.append("runner: done in %.1fs" % duration)
        return {"status": "succeeded", "output": output,
                "log_lines": log_lines, "duration_s": round(duration, 2),
                "trace": {"plugin": describe["name"],
                          "plugin_version": describe["version"],
                          "tool": describe["tool"]}}

    def _report(self, status, output, log_lines, started, error):
        return {"status": status, "output": output,
                "log_lines": log_lines,
                "duration_s": round(time.monotonic() - started, 2),
                "error": error}
