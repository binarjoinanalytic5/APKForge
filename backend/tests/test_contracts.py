"""Phase-0 contract gates: frozen versions must not drift.

Validates docs/openapi.yaml (structure + frozen version + required
operations), docs/plugin.schema.json against the reference plugin, and
infra/frontend descriptors. stdlib + pyyaml only (no network needed).
"""
import json
import re
import sys
from pathlib import Path

import pytest
import yaml

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.version import (  # noqa: E402
    API_VERSION,
    OPENAPI_VERSION,
    PLUGIN_SDK_VERSION,
)

REQUIRED_PATHS = {
    "/health": ["get"],
    "/auth/login": ["post"],
    "/auth/register": ["post"],
    "/projects": ["get", "post"],
    "/projects/{id}": ["get", "delete"],
    "/projects/{id}/upload": ["post"],
    "/projects/{id}/decompile": ["post"],
    "/projects/{id}/analyze": ["post"],
    "/projects/{id}/rebuild": ["post"],
    "/projects/{id}/sign": ["post"],
    "/projects/{id}/download": ["get"],
    "/jobs/{job_id}": ["get"],
    "/jobs/{job_id}/logs": ["get"],
}


def _load_openapi():
    with open(ROOT / "docs" / "openapi.yaml", encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def test_openapi_parses_and_freezes_v1():
    spec = _load_openapi()
    assert spec["openapi"].startswith("3.0.")
    assert spec["info"]["version"] == "1.0.0"
    assert spec["x-frozen"] is True
    assert spec["x-contract-version"] == "1.0.0"
    assert spec["x-contract-version"] == OPENAPI_VERSION == API_VERSION


def test_openapi_covers_required_operations():
    paths = _load_openapi()["paths"]
    for path, methods in REQUIRED_PATHS.items():
        assert path in paths, "missing path %s" % path
        for method in methods:
            op = paths[path].get(method)
            assert op is not None, "missing %s %s" % (method, path)
            assert op.get("operationId"), "missing operationId %s %s" % (
                method, path)
            assert op.get("responses"), "missing responses %s %s" % (
                method, path)


def test_openapi_schemas_resolve():
    spec = _load_openapi()
    text = json.dumps(spec)
    for match in set(re.findall(r"#/components/schemas/([A-Za-z0-9_]+)",
                                text)):
        assert match in spec["components"]["schemas"], \
            "unresolved schema %s" % match


class _MiniValidator:
    """JSON-Schema subset validator (no third-party deps).

    Supports the keywords used by docs/plugin.schema.json: type,
    required, properties, items, enum, const, pattern, minLength,
    minimum, maximum, minItems. Anything else fails closed.
    """

    def __init__(self):
        self.errors = []

    def validate(self, schema, value, where="$"):
        kind = schema.get("type")
        if "const" in schema and value != schema["const"]:
            self.errors.append("%s: expected const %r" % (where,
                                                          schema["const"]))
        if "enum" in schema and value not in schema["enum"]:
            self.errors.append("%s: not in enum" % where)
        if kind == "object":
            if not isinstance(value, dict):
                self.errors.append("%s: expected object" % where)
                return
            for key in schema.get("required", []):
                if key not in value:
                    self.errors.append("%s: missing %r" % (where, key))
            for key, sub in schema.get("properties", {}).items():
                if key in value:
                    self.validate(sub, value[key], "%s.%s" % (where, key))
        elif kind == "array":
            if not isinstance(value, list):
                self.errors.append("%s: expected array" % where)
                return
            if "minItems" in schema and len(value) < schema["minItems"]:
                self.errors.append("%s: too few items" % where)
            for index, item in enumerate(value):
                self.validate(schema.get("items", {}), item,
                              "%s[%d]" % (where, index))
        elif kind == "string":
            if not isinstance(value, str):
                self.errors.append("%s: expected string" % where)
                return
            if "minLength" in schema and len(value) < schema["minLength"]:
                self.errors.append("%s: too short" % where)
            if "pattern" in schema and not re.search(schema["pattern"],
                                                     value):
                self.errors.append("%s: pattern mismatch" % where)
        elif kind == "integer":
            if not isinstance(value, int) or isinstance(value, bool):
                self.errors.append("%s: expected integer" % where)
                return
            self._bounds(schema, value, where)
        elif kind == "number":
            if not isinstance(value, (int, float)) \
                    or isinstance(value, bool):
                self.errors.append("%s: expected number" % where)
                return
            self._bounds(schema, value, where)
        elif kind == "boolean":
            if not isinstance(value, bool):
                self.errors.append("%s: expected boolean" % where)
        elif kind is not None:
            self.errors.append("%s: unsupported type %r" % (where, kind))

    def _bounds(self, schema, value, where):
        if "minimum" in schema and value < schema["minimum"]:
            self.errors.append("%s: below minimum" % where)
        if "maximum" in schema and value > schema["maximum"]:
            self.errors.append("%s: above maximum" % where)


def _load_plugin_schema():
    with open(ROOT / "docs" / "plugin.schema.json",
              encoding="utf-8") as handle:
        return json.load(handle)


def _load_example_manifest():
    with open(ROOT / "plugins" / "_example" / "plugin.yaml",
              encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def test_reference_plugin_validates():
    schema = _load_plugin_schema()
    checker = _MiniValidator()
    checker.validate(schema, _load_example_manifest())
    assert checker.errors == []
    assert _load_example_manifest()["sdk_version"] == PLUGIN_SDK_VERSION


def test_invalid_manifests_rejected():
    schema = _load_plugin_schema()
    base = _load_example_manifest()
    bad_names = dict(base)
    del bad_names["name"]
    bad_sdk = dict(base, sdk_version="2.0.0")
    bad_timeout = dict(base)
    bad_timeout["runtime"] = dict(base["runtime"], timeout_s=99999)
    for manifest in (bad_names, bad_sdk, bad_timeout, {}, "nope"):
        checker = _MiniValidator()
        checker.validate(schema, manifest)
        assert checker.errors, "accepted invalid manifest %r" % (manifest,)


def test_compose_defines_platform():
    with open(ROOT / "infra" / "compose.yaml",
              encoding="utf-8") as handle:
        compose = yaml.safe_load(handle)
    services = compose.get("services", {})
    for name in ("db", "redis", "s3", "api", "worker"):
        assert name in services, "missing service %s" % name
    for name, service in services.items():
        image = service.get("image", "")
        if image.endswith(":latest"):
            # The single documented Phase-0 waiver (see compose.yaml).
            assert name == "s3", "unpinned image on %s" % name


def test_frontend_descriptor_parses():
    with open(ROOT / "frontend" / "package.json",
              encoding="utf-8") as handle:
        package = json.load(handle)
    assert package["name"] == "apkforge-web"
    assert package["private"] is True
    assert "build" in package["scripts"]


def test_no_secrets_in_skeleton():
    text = ""
    # Note: backend/tests itself is excluded — the token blocklist must
    # live somewhere, and this file is that somewhere.
    for path in list((ROOT / "backend" / "app").rglob("*.py")) + \
            list((ROOT / "workers").rglob("*.py")) + \
            [ROOT / "infra" / "compose.yaml",
             ROOT / "docs" / "openapi.yaml"]:
        text += path.read_text(encoding="utf-8")
    lowered = text.lower()
    for token in ("password=", "passwd=", "secret=", "api_key=", "apikey=",
                  "aws_secret", "ghp_", "private_key"):
        assert token not in lowered, "suspect token %s" % token


if __name__ == "__main__":
    raise SystemExit(pytest.main([__file__, "-q"]))
