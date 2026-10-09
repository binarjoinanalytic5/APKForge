"""Adaptive compat tests (hermetic; canned PyPI fixtures)."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from adaptive import compat as C  # noqa: E402

LINUX = {"termux": False, "libc": "glibc",
         "arch_machine": "x86_64", "os": "Linux",
         "os_id": "ubuntu", "python_version": "3.13.1"}
TERMUX = {"termux": True, "libc": "bionic",
          "arch_machine": "aarch64", "os": "Linux",
          "os_id": "android-termux", "python_version": "3.14.6"}


def _release(version, filenames, requires_python=None):
    return {"version": version,
            "requires_python": requires_python,
            "files": [{"filename": name, "yanked": False}
                      for name in filenames]}


def _pypi(mapping):
    def fetch(package, version=None):
        return mapping.get(package)
    return fetch


def test_parse_requirements_with_include_and_markers(tmp_path):
    (tmp_path / "other.txt").write_text(
        "leaf==2.0\n", encoding="utf-8")
    main = tmp_path / "req.txt"
    main.write_text(
        "# comment\npydantic>=2.6\nuvicorn[standard]>=0.29\n"
        "-e .\ncond>=1; python_version > '3.8'\n-r other.txt\n",
        encoding="utf-8")
    reqs = C.parse_requirements(main)
    by_name = {req["name"]: req for req in reqs}
    assert by_name["pydantic"]["spec"] == ">=2.6"
    assert by_name["uvicorn"]["extras"] == ["standard"]
    assert by_name["uvicorn"]["spec"] == ">=0.29"
    assert by_name["cond"]["marker"] == "python_version > '3.8'"
    assert by_name["leaf"]["spec"] == "==2.0"
    assert len(reqs) == 4


def test_expand_extras_uvicorn_standard():
    reqs = C.expand_extras(
        [{"name": "uvicorn", "extras": ["standard"], "spec": "",
          "marker": None}])
    names = [req["name"] for req in reqs]
    for dep in ("uvloop", "httptools", "watchfiles",
                "websockets"):
        assert dep in names
    assert reqs[-1]["via"] == "uvicorn[standard]"


def test_wheel_filename_parsing():
    parsed = C.parse_wheel_filename(
        "pydantic_core-2.33.2-cp313-cp313-"
        "manylinux_2_17_x86_64.manylinux2014_x86_64.whl")
    assert parsed["python"] == ["cp313"]
    assert parsed["abi"] == ["cp313"]
    assert "manylinux_2_17_x86_64" in parsed["platform"]
    build = C.parse_wheel_filename("foo-1.0-2-py3-none-any.whl")
    assert build["python"] == ["py3"]
    assert build["platform"] == ["any"]
    assert C.parse_wheel_filename("foo-1.0.tar.gz") is None


def _match(filename, fp):
    interpreter, version = C.interpreter_tag(
        fp["python_version"])
    return C.wheel_matches(C.parse_wheel_filename(filename),
                           interpreter, version, fp)


def test_wheel_match_linux():
    assert _match("p-1-cp313-cp313-manylinux_2_17_x86_64.whl",
                  LINUX)
    assert _match("p-1-cp313-cp313-musllinux_1_1_x86_64.whl",
                  LINUX)
    assert _match("p-1-cp39-abi3-manylinux_2_17_x86_64.whl",
                  LINUX)
    assert _match("p-1-py3-none-any.whl", LINUX)
    assert not _match("p-1-cp312-cp312-manylinux_2_17_x86_64.whl",
                      LINUX)
    assert not _match(
        "p-1-cp313-cp313-manylinux_2_17_aarch64.whl", LINUX)
    assert not _match("p-1-cp313-cp313-win_amd64.whl", LINUX)
    assert not _match("p-1-cp39-cp39-manylinux_2_17_x86_64.whl",
                      LINUX)


def test_wheel_match_termux_pure_only():
    assert _match("p-1-py3-none-any.whl", TERMUX)
    assert not _match(
        "p-1-cp314-cp314-manylinux_2_17_aarch64.whl", TERMUX)
    assert not _match("p-1-cp314-cp314-linux_aarch64.whl",
                      TERMUX)


def test_abi3_bounded_by_interpreter():
    new_abi3 = "p-1-cp314-abi3-manylinux_2_17_x86_64.whl"
    assert not _match(new_abi3, LINUX)  # cp314 abi3 on cp313
    assert _match("p-1-cp313-cp313-win_amd64.whl", dict(
        LINUX, os="Windows", arch_machine="AMD64"))


def test_assess_verdicts():
    pypi = _pypi({
        "pure-pkg": _release("1.0", ["pure_pkg-1.0-py3-none-any.whl"]),
        "pydantic-core": _release(
            "2.33.2", ["pydantic_core-2.33.2-cp313-cp313-"
                       "manylinux_2_17_aarch64.whl",
                       "pydantic_core-2.33.2.tar.gz"]),
        "old-pkg": _release("0.5", ["old_pkg-0.5-py3-none-any.whl"],
                            requires_python=">=3.9,<3.14"),
        "win-only": _release("2.0", ["w-2.0-cp313-cp313-win_amd64.whl"]),
    })
    assert C.assess_package({"name": "pure-pkg", "spec": ""},
                            LINUX, pypi)["status"] == "WHEEL_OK"
    native = C.assess_package({"name": "pydantic-core",
                               "spec": ">=2.6"}, TERMUX, pypi)
    assert native["status"] == "NEEDS_BUILD"
    assert native["build"] == ["rust"]
    assert native["version"] == "2.33.2"
    assert C.assess_package({"name": "old-pkg", "spec": ""},
                            TERMUX, pypi)["status"] == \
        "PYTHON_INCOMPATIBLE"
    assert C.assess_package({"name": "win-only", "spec": ""},
                            LINUX, pypi)["status"] == "NO_ARTIFACT"
    assert C.assess_package({"name": "missing-pkg", "spec": ""},
                            LINUX, pypi)["status"] == "UNKNOWN"


def test_yanked_wheels_skipped():
    pypi = _pypi({"w": {"version": "1.0", "requires_python": None,
                        "files": [
                            {"filename": "w-1.0-py3-none-any.whl",
                             "yanked": True},
                            {"filename": "w-1.0.tar.gz",
                             "yanked": False}]}})
    verdict = C.assess_package({"name": "w", "spec": ""}, LINUX,
                               pypi)
    assert verdict["status"] == "NEEDS_BUILD"


def test_preflight_blockers_termux_without_toolchain(tmp_path):
    req = tmp_path / "req.txt"
    req.write_text("uvicorn[standard]>=0.29\npydantic>=2.6\n",
                   encoding="utf-8")
    pypi = _pypi({
        "uvicorn": _release("0.30",
                            ["uvicorn-0.30-py3-none-any.whl"]),
        "uvloop": _release("0.21", ["uvloop-0.21.tar.gz"]),
        "httptools": _release("0.6", ["httptools-0.6.tar.gz"]),
        "watchfiles": _release("0.22", ["watchfiles-0.22.tar.gz"]),
        "websockets": _release(
            "13.0", ["websockets-13.0-py3-none-any.whl"]),
        "pydantic": _release(
            "2.11", ["pydantic-2.11-py3-none-any.whl"]),
    })
    profile = {"compiler_c": False, "compiler_rust": False,
               "package_manager": "pkg"}
    report = C.preflight(req, TERMUX, profile, pypi_fn=pypi)
    assert report["blockers"], report
    joined = " ".join(report["blockers"])
    assert "rust" in joined and "pkg install" in joined
    profile_ok = {"compiler_c": True, "compiler_rust": True,
                  "package_manager": "pkg"}
    report_ok = C.preflight(req, TERMUX, profile_ok,
                            pypi_fn=pypi)
    assert report_ok["blockers"] == []
    assert report_ok["warnings"]


def test_strip_known_extras():
    text = ("uvicorn[standard]>=0.29\npydantic>=2.6  # core\n"
            "x[weird]>=1\n")
    stripped = C.strip_known_extras(text)
    assert stripped.splitlines()[0] == "uvicorn>=0.29"
    assert stripped.splitlines()[1] == "pydantic>=2.6  # core"
    assert stripped.splitlines()[2] == "x[weird]>=1"
