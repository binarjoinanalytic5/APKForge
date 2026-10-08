"""Plugin discovery: plugins/*/plugin.yaml + adapter.py → registry.

Each plugin directory holds a validated manifest and an `adapter.py`
defining `Adapter(ToolAdapter)`. Directories starting with `_`
(`_example`) are documentation-only and skipped. The manifest is the
source of truth for limits: they are bound onto the adapter instance.
"""
import importlib.util
from pathlib import Path

from .base import AdapterError, AdapterRegistry, ToolAdapter
from .manifest import ManifestError, check_manifest, load_manifest


def _load_adapter_class(plugin_dir):
    module_path = Path(plugin_dir) / "adapter.py"
    if not module_path.is_file():
        raise AdapterError("plugin %s lacks adapter.py"
                           % Path(plugin_dir).name)
    name = "apkforge_plugin_%s" % Path(plugin_dir).name.replace("-", "_")
    spec = importlib.util.spec_from_file_location(name, module_path)
    module = importlib.util.module_from_spec(spec)
    try:
        spec.loader.exec_module(module)
    except Exception as exc:
        raise AdapterError("cannot import %s: %s" % (module_path, exc))
    cls = getattr(module, "Adapter", None)
    if not isinstance(cls, type) or not issubclass(cls, ToolAdapter):
        raise AdapterError("%s must define Adapter(ToolAdapter)"
                           % module_path)
    return cls


def load_plugins(plugins_root, registry=None):
    """Discover, validate, and register every plugin directory."""
    registry = registry if registry is not None else AdapterRegistry()
    root = Path(plugins_root)
    if not root.is_dir():
        raise AdapterError("plugins root missing: %s" % root)
    for manifest_path in sorted(root.glob("*/plugin.yaml")):
        if manifest_path.parent.name.startswith("_"):
            continue
        try:
            manifest = check_manifest(load_manifest(manifest_path))
        except ManifestError as exc:
            raise AdapterError("invalid manifest %s: %s"
                               % (manifest_path, exc))
        adapter = _load_adapter_class(manifest_path.parent)()
        if adapter.name != manifest["name"]:
            raise AdapterError(
                "adapter name %r != manifest %r"
                % (adapter.name, manifest["name"]))
        adapter.plugin_dir = str(manifest_path.parent)
        adapter.manifest = dict(manifest)
        adapter.limits = {
            key: manifest["runtime"][key]
            for key in ("timeout_s", "memory_mb", "cpu", "network")}
        registry.register(manifest, adapter)
    return registry
