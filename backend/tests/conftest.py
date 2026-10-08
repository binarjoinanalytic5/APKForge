"""Phase-1 test bootstrap: env-first, isolated temp data roots.

Sets the signing key and a throwaway data directory BEFORE any app
module is imported (importing app.main without APKFORGE_KEY fails
closed, by design). API tests rebuild the app per-test with their own
tmp paths for full isolation.
"""
import os
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))
sys.path.insert(0, str(ROOT))

os.environ.setdefault("APKFORGE_KEY",
                      "phase1-test-key-0123456789abcdef-XYZ")
os.environ.setdefault("APKFORGE_DATA",
                      tempfile.mkdtemp(prefix="apkforge-test-data-"))
