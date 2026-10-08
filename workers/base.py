"""Tool adapter interface + registry (Phase 0, stdlib only).

The core never invokes an external tool directly: every tool sits
behind an adapter declaring name/version, wrapped tool/version,
input/output schemas, and execution limits. Phase 1 binds this to
Celery tasks and plugin.yaml subprocess isolation.
"""
from abc import ABC, abstractmethod


class AdapterError(RuntimeError):
    pass


REQUIRED_MANIFEST_KEYS = ("name", "version", "sdk_version", "tool",
                          "runtime", "license")


class ToolAdapter(ABC):
    """One wrapped tool: metadata + a single run entrypoint."""

    name = ""
    version = ""
    tool_name = ""
    tool_version = ""
    input_schema = {}
    output_schema = {}
    limits = {}

    @abstractmethod
    def run(self, payload):
        """Execute with a JSON-able payload; return JSON-able output."""

    def describe(self):
        return {
            "name": self.name,
            "version": self.version,
            "tool": {"name": self.tool_name,
                     "version": self.tool_version},
            "limits": dict(self.limits),
        }


class AdapterRegistry:
    """Manifest-validated adapter registry (fail-closed)."""

    def __init__(self):
        self._adapters = {}

    def register(self, manifest, adapter):
        missing = [key for key in REQUIRED_MANIFEST_KEYS
                   if key not in (manifest or {})]
        if missing:
            raise AdapterError("manifest lacks %s" % ", ".join(missing))
        if not isinstance(adapter, ToolAdapter):
            raise AdapterError("adapter must subclass ToolAdapter")
        if manifest["sdk_version"] != "1.0.0":
            raise AdapterError("unsupported sdk_version %r" % (
                manifest.get("sdk_version"),))
        name = manifest["name"]
        if name in self._adapters:
            raise AdapterError("duplicate adapter %r" % name)
        self._adapters[name] = (dict(manifest), adapter)
        return name

    def get(self, name):
        try:
            return self._adapters[name][1]
        except KeyError:
            raise AdapterError("unknown adapter %r" % (name,)) from None

    def manifest(self, name):
        try:
            return dict(self._adapters[name][0])
        except KeyError:
            raise AdapterError("unknown adapter %r" % (name,)) from None

    def names(self):
        return sorted(self._adapters)
