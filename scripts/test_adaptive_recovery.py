"""Adaptive recovery tests (canned failure logs, tmp ledger)."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import recovery as R  # noqa: E402

PYDANTIC_TERMUX = """
Collecting pydantic-core==2.33.2 (from pydantic>=2.6)
  Downloading pydantic_core-2.33.2.tar.gz (394 kB)
  Installing build dependencies ... done
  Getting requirements to build wheel ... done
  Preparing metadata (pyproject.toml) ... error
  error: subprocess-exited-with-error
  × Preparing metadata (pyproject.toml) did not run successfully.
  ╰─> [8 lines of output]
      + maturin pep517 write-dist-info --metadata-directory /tmp/x
      💥 maturin failed
        Caused by: cargo not found; install the Rust toolchain
      [end of output]
  note: This error originates from a subprocess.
error: metadata-generation-failed
× Encountered error while generating package metadata.
╰─> See above for output.
note: This is an issue with the package mentioned above, not pip.
"""


def test_pydantic_core_is_build_resolution_not_pip_failure():
    result = R.classify_failure(PYDANTIC_TERMUX)
    assert result["category"] == "RUST_MISSING"
    assert result["package"] == "pydantic-core"
    assert "rust" in result["root_cause"].lower()


def test_classifier_matrix():
    cases = [
        ("ReadTimeoutError: HTTPSConnectionPool read timed out",
         "NETWORK_FAILURE"),
        ("socket.gaierror: [Errno -2] Name or service not known",
         "DNS_FAILURE"),
        ("npm ERR! code EAI_AGAIN", "DNS_FAILURE"),
        ("Could not find a version that satisfies foo==9\n"
         "from versions: 1.0, 2.0", "VERSION_INCOMPATIBILITY"),
        ("ERROR: Could not find a version that satisfies the "
         "requirement pkgx>=9 (from versions: none)",
         "PACKAGE_NOT_FOUND"),
        ("Could not find a version that satisfies nosuchpkg",
         "PACKAGE_NOT_FOUND"),
        ("ERROR: No matching distribution found for numpy==1.0",
         "WHEEL_UNAVAILABLE"),
        ("error: metadata-generation-failed\n× Failed to build "
         "cryptography", "BUILD_TOOL_MISSING"),
        ("fatal error: Python.h: No such file or directory",
         "COMPILER_MISSING"),
        ("gcc: not found", "COMPILER_MISSING"),
        ("Ignored: requires-python >=3.9,<3.14", "PYTHON_INCOMPATIBILITY"),
        ("PermissionError: [Errno 13] Permission denied",
         "PERMISSION_FAILURE"),
        ("OSError: [Errno 28] No space left on device", "DISK_SPACE"),
        ("something totally unfamiliar happened", "UNKNOWN"),
    ]
    for log, category in cases:
        assert R.classify_failure(log)["category"] == category, log


def test_package_extraction():
    assert R.classify_failure(
        "Failed to build `uvloop==0.21`")["package"] == "uvloop"
    assert R.classify_failure(
        "ERROR: No matching distribution found for numpy==1.0"
    )["package"] == "numpy"


def test_ledger_refuses_identical_retry(tmp_path):
    ledger = R.Ledger(tmp_path / "ledger.jsonl")
    sig = R.failure_signature("DEPENDENCIES", "RUST_MISSING",
                              "pydantic-core", "toolchain", "abc")
    assert ledger.attempted("DEPENDENCIES", sig, "toolchain") is False
    ledger.record("DEPENDENCIES", sig, "toolchain", "pkg install rust",
                  "abc", "failed", "still no rustc")
    assert ledger.attempted("DEPENDENCIES", sig, "toolchain") is True
    assert ledger.attempted("DEPENDENCIES", sig, "other") is False
    assert len(ledger.attempts_for("DEPENDENCIES")) == 1
    broken = R.Ledger(tmp_path / "broken.jsonl")
    (tmp_path / "broken.jsonl").write_text("not json\n",
                                           encoding="utf-8")
    assert broken.attempted("x", "y", "z") is False


def test_diagnostic_blocks():
    info = {"step": "DEPENDENCIES", "package": "pydantic-core",
            "version": "2.33.2", "python": "3.14.6",
            "platform": "android-termux", "arch": "aarch64",
            "method": "pip install -r requirements.txt",
            "category": "RUST_MISSING",
            "root_cause": "rust toolchain missing",
            "command": "pip install -r requirements.txt",
            "evidence": ["maturin failed"],
            "alternatives": ["pkg install rust"],
            "attempts": ["native", "toolchain"],
            "next_strategy": "provision rust via pkg"}
    block = R.full_diagnostic(info)
    for label in ("FAILED STEP", "PACKAGE", "PYTHON", "PLATFORM",
                  "CATEGORY", "ROOT CAUSE", "EVIDENCE",
                  "ALTERNATIVES", "ATTEMPTS", "NEXT"):
        assert label in block
    report = R.exhausted_report(
        {"root_cause": "x", "step": "DEPENDENCIES",
         "package": "p", "category": "RUST_MISSING",
         "tried": [{"strategy": "s", "result": "failed"}],
         "required": "rust", "next_action": "pkg install rust"})
    assert "AUTO-RECOVERY EXHAUSTED" in report
    assert "Do NOT re-run the same command" in report


def test_action_classes():
    assert R.action_class("download") == "SAFE"
    assert R.action_class("venv_create") == "SAFE"
    assert R.action_class("toolchain_install") == "CAUTION"
    assert R.action_class("venv_recreate") == "CAUTION"
    assert R.action_class("db_delete") == "DESTRUCTIVE"
