"""In-process adapter spawning the Apktool plugin subprocess."""
import json
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from workers.base import AdapterError, ToolAdapter  # noqa: E402


class Adapter(ToolAdapter):
    name = "apktool"
    version = "1.0.0"
    tool_name = "apktool"
    tool_version = "3.0.2"
    input_schema = {"type": "object"}
    output_schema = {"type": "object"}
    limits = {"timeout_s": 600, "memory_mb": 2048, "cpu": 2.0,
              "network": "none"}

    @property
    def _plugin_dir(self):
        return Path(getattr(self, "plugin_dir", None)
                    or Path(__file__).resolve().parent)

    def run(self, payload):
        if not isinstance(payload, dict):
            raise AdapterError("payload must be an object")
        timeout_s = (self.limits or {}).get("timeout_s", 600)
        argv = [sys.executable, str(self._plugin_dir / "run.py")]
        try:
            proc = subprocess.run(
                argv, input=json.dumps(payload), stdout=subprocess.PIPE,
                stderr=subprocess.PIPE, timeout=timeout_s, text=True,
                cwd=str(self._plugin_dir))
        except subprocess.TimeoutExpired:
            raise AdapterError(
                "plugin timed out after %ss" % timeout_s)
        if proc.returncode != 0:
            tail = "\n".join(proc.stderr.splitlines()[-8:])
            raise AdapterError("plugin failed (exit %d): %s"
                               % (proc.returncode, tail))
        try:
            output = json.loads(proc.stdout)
        except Exception as exc:
            raise AdapterError("plugin wrote invalid JSON: %s" % exc)
        if not isinstance(output, dict) or \
                output.get("status") != "ok":
            raise AdapterError("plugin error: %s"
                               % output.get("error", output))
        return output
