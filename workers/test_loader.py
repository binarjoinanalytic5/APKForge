"""Plugin discovery tests (tmp plugin roots, no real tools)."""
import sys
from pathlib import Path

WORKERS = Path(__file__).resolve().parent
sys.path.insert(0, str(WORKERS))
sys.path.insert(0, str(WORKERS.parent))

import pytest

from workers.base import AdapterError
from workers.loader import load_plugins

ADAPTER_SRC = """import sys
from pathlib import Path
sys.path.insert(0, str(Path(%r).parent))
from workers.base import ToolAdapter


class Adapter(ToolAdapter):
    name = %r
    version = "0.1.0"
    tool_name = "fake"
    tool_version = "0"

    def run(self, payload):
        return {"echo": payload}
"""

MANIFEST_SRC = """name: %s
version: 0.1.0
sdk_version: 1.0.0
license: Apache-2.0
tool: {name: fake, version: "0"}
runtime: {command: [run], timeout_s: 30, memory_mb: 128,
  cpu: 0.5, network: none}
"""


def _plugin(root, dirname, name=None):
    directory = root / dirname
    directory.mkdir()
    (directory / "plugin.yaml").write_text(
        MANIFEST_SRC % (name or dirname))
    (directory / "adapter.py").write_text(
        ADAPTER_SRC % (str(WORKERS), name or dirname))
    return directory


def test_discovers_and_binds_limits(tmp_path):
    root = tmp_path / "plugins"
    root.mkdir()
    _plugin(root, "probe")
    registry = load_plugins(root)
    assert registry.names() == ["probe"]
    adapter = registry.get("probe")
    assert adapter.limits["timeout_s"] == 30
    assert adapter.limits["network"] == "none"
    assert adapter.run({"a": 1}) == {"echo": {"a": 1}}
    assert adapter.manifest["name"] == "probe"


def test_underscore_dirs_skipped(tmp_path):
    root = tmp_path / "plugins"
    root.mkdir()
    _plugin(root, "_example", name="should-skip")
    _plugin(root, "real")
    assert load_plugins(root).names() == ["real"]


def test_invalid_manifest_rejected(tmp_path):
    root = tmp_path / "plugins"
    root.mkdir()
    directory = _plugin(root, "broken")
    (directory / "plugin.yaml").write_text("name: broken\n")
    with pytest.raises(AdapterError):
        load_plugins(root)


def test_missing_adapter_rejected(tmp_path):
    root = tmp_path / "plugins"
    root.mkdir()
    directory = _plugin(root, "noadapter")
    (directory / "adapter.py").unlink()
    with pytest.raises(AdapterError):
        load_plugins(root)


def test_name_mismatch_and_duplicates_rejected(tmp_path):
    root = tmp_path / "plugins"
    root.mkdir()
    _plugin(root, "dir-a", name="same")
    _plugin(root, "dir-b", name="same")
    with pytest.raises(AdapterError):
        load_plugins(root)
    root2 = tmp_path / "plugins2"
    root2.mkdir()
    _plugin(root2, "dir-c", name="other")
    (root2 / "dir-c" / "adapter.py").write_text(
        ADAPTER_SRC % (str(WORKERS), "different"))
    with pytest.raises(AdapterError):
        load_plugins(root2)


def test_missing_root_rejected(tmp_path):
    with pytest.raises(AdapterError):
        load_plugins(tmp_path / "nope")
