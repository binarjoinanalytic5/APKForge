"""Compatibility matrix + Python dependency preflight (stdlib).

Decides BEFORE pip runs whether each requirement has an artifact
this interpreter can actually install on this platform. On
Termux/bionic only pure-Python wheels are pip-installable (plus
android-tagged wheels from an explicitly allowlisted index, which
are advisory-only and never auto-installed); native code needs the
system toolchain (``pkg install clang`` / ``rust``).
"""
from __future__ import annotations

import hashlib
import json
import time
import urllib.error
import urllib.request
from pathlib import Path

# package -> build toolchain when no compatible wheel exists.
NATIVE_INDEX = {
    "pydantic-core": {"build": ["rust"]},
    "cryptography": {"build": ["rust"]},
    "orjson": {"build": ["rust"]},
    "tokenizers": {"build": ["rust"]},
    "watchfiles": {"build": ["rust"]},
    "uvloop": {"build": ["c"]},
    "httptools": {"build": ["c"]},
    "numpy": {"build": ["c"]},
    "pillow": {"build": ["c"]},
    "lxml": {"build": ["c"]},
    "bcrypt": {"build": ["c"]},
    "psutil": {"build": ["c"]},
    "cffi": {"build": ["c"]},
    "pyyaml": {"build": ["c-optional"]},
    "markupsafe": {"build": ["c-optional"]},
}


def native_languages(name):
    """Build languages a requirement may need (set of str)."""
    key = (name or "").lower().replace("_", "-")
    key = key.split(";")[0].split("[")[0].strip()
    return set(NATIVE_INDEX.get(key, {}).get("build", []))

# extra -> native-ish deps it pulls (for build-needs detection).
KNOWN_EXTRAS = {
    "uvicorn": {"standard": ["uvloop", "httptools", "watchfiles",
                             "websockets"]},
}

VERDICTS = ("WHEEL_OK", "NEEDS_BUILD", "NO_ARTIFACT",
            "PYTHON_INCOMPATIBLE", "UNKNOWN")


def normalize(name):
    return name.strip().lower().replace("_", "-")


def parse_requirement_line(line):
    """Parse one requirements line (stdlib, no packaging needed)."""
    line = line.strip()
    if not line or line.startswith("#"):
        return None
    if line.startswith(("-r ", "--requirement")):
        return {"include": line.split(None, 1)[1].strip()}
    if line.startswith(("-e ", "--editable", "-c ", "--constraint",
                        "-f ", "--find-links", "-i ", "--index-url",
                        "--extra-index-url")):
        return {"skipped": line}
    marker = None
    if ";" in line:
        line, _, marker = line.partition(";")
        marker = marker.strip()
    line = line.strip()
    extras = []
    if "[" in line and "]" in line:
        head, _, rest = line.partition("[")
        extras = [item.strip() for item in
                  rest.partition("]")[0].split(",") if item.strip()]
        line = (head + rest.partition("]")[2]).strip()
    name, spec = line, ""
    for index, char in enumerate(line):
        if char in "<>=!~ ":
            name, spec = line[:index].strip(), line[index:].strip()
            break
    if not name:
        return None
    return {"name": normalize(name), "extras": extras,
            "spec": spec, "marker": marker or None, "raw": line}


def parse_requirements(path, _seen=None):
    """Parse a requirements file (-r includes expanded)."""
    path = Path(path)
    if _seen is None:
        _seen = set()
    key = str(path.resolve()) if path.exists() else str(path)
    if key in _seen:
        return []
    _seen.add(key)
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return [{"error": "unreadable: %s" % path}]
    reqs = []
    for line in text.splitlines():
        parsed = parse_requirement_line(line)
        if parsed is None or "skipped" in parsed:
            continue
        if "include" in parsed:
            reqs.extend(parse_requirements(
                path.parent / parsed["include"], _seen))
            continue
        if "error" in parsed:
            reqs.append(parsed)
            continue
        reqs.append(parsed)
    return reqs


def expand_extras(reqs):
    """Add synthetic reqs for known native extra deps."""
    out = list(reqs)
    for req in reqs:
        known = KNOWN_EXTRAS.get(req.get("name", ""), {})
        for extra in req.get("extras", []):
            for dep in known.get(extra, []):
                out.append({"name": normalize(dep), "extras": [],
                            "spec": "", "marker": None,
                            "via": "%s[%s]" % (req["name"], extra)})
    return out


def interpreter_tag(python_version):
    parts = str(python_version or "").split(".")
    try:
        major, minor = int(parts[0]), int(parts[1])
    except (IndexError, ValueError):
        return "cp310", (3, 10)
    return "cp%d%d" % (major, minor), (major, minor)


def parse_wheel_filename(filename):
    """Split a .whl name into python/abi/platform tag sets."""
    if not filename.endswith(".whl"):
        return None
    parts = filename[:-4].split("-")
    if len(parts) < 5:
        return None
    python_tag, abi_tag, plat_tag = parts[-3], parts[-2], parts[-1]
    return {"python": python_tag.split("."),
            "abi": abi_tag.split("."),
            "platform": plat_tag.split(".")}


def _machine_matches(machine, plat):
    machine = (machine or "").lower()
    if machine in ("x86_64", "amd64"):
        return plat.endswith("x86_64") or plat.endswith("amd64") \
            or plat == "win_amd64"
    if machine in ("aarch64", "arm64"):
        return plat.endswith("aarch64") or plat.endswith("arm64") \
            or "universal2" in plat
    if machine.startswith("armv7"):
        return "armv7l" in plat
    return machine in plat


def _is_android(fp):
    if fp.get("termux") or fp.get("libc") == "bionic":
        return True
    return "android" in (fp.get("os") or "").lower()


# Allowlisted external Android wheel indexes (advisory only).
# Empty by default: no external source is ever consulted unless an
# operator explicitly lists one here. Each entry:
# {"name":..., "index_url": "https://.../simple",
#  "packages": ["pydantic-core", ...]}.
ANDROID_WHEEL_SOURCES = ()


def _simple_index_files(html):
    import re
    from urllib.parse import unquote
    found = []
    for href in re.findall(r'href="([^"]+)"', html or ""):
        link, _, frag = href.partition("#")
        sha = frag[len("sha256="):] \
            if frag.startswith("sha256=") else None
        name = unquote(link.rsplit("/", 1)[-1])
        if name.endswith(".whl") and all(
                name != item[0] for item in found):
            found.append((name, sha))
    return found


def android_wheel_candidates(package, version, interpreter,
                             machine, sources=None):
    """Advisory-only lookup in allowlisted Android wheel indexes.

    Only allowlisted https indexes holding an explicitly listed
    package are queried. A filename qualifies only with the running
    cpXY ABI (or abi3), a native (non-none) ABI, and an android_
    platform tag matching this arch. Returns [{filename, sha256,
    source}]; advisory only, nothing installs anything.
    """
    package = normalize(package)
    found = []
    entries = ANDROID_WHEEL_SOURCES if sources is None else sources
    for source in entries:
        index = (source.get("index_url") or "").rstrip("/")
        if not index.startswith("https://"):
            continue
        allowed = [normalize(item)
                   for item in source.get("packages", [])]
        if package not in allowed:
            continue
        try:
            request = urllib.request.Request(
                "%s/%s/" % (index, package),
                headers={"User-Agent": "apkforge-bootstrap/2.0"})
            with urllib.request.urlopen(request,
                                        timeout=20) as response:
                html = response.read().decode("utf-8", "replace")
        except (urllib.error.URLError, TimeoutError, OSError,
                ValueError):
            continue
        for filename, sha256 in _simple_index_files(html):
            parts = filename[:-4].split("-")
            if normalize(parts[0].replace("_", "-")) != package:
                continue
            if version and len(parts) > 1 and parts[1] != version:
                continue
            parsed = parse_wheel_filename(filename)
            if parsed is None or "none" in parsed["abi"]:
                continue
            if interpreter not in parsed["abi"] \
                    and "abi3" not in parsed["abi"]:
                continue
            pytags = parsed["python"]
            if interpreter not in pytags and not (
                    "abi3" in parsed["abi"] and any(
                        tag.startswith("cp3") for tag in pytags)):
                continue
            if not any(plat.startswith("android_")
                       and _machine_matches(machine, plat)
                       for plat in parsed["platform"]):
                continue
            found.append({"filename": filename, "sha256": sha256,
                          "source": source.get("name", "?")})
    return found


# Specialized recovery source: prebuilt pydantic-core wheels for
# Android/Termux (CI-built, digest-pinned). Consulted ONLY by the
# android_prebuilt_wheel strategy for pydantic-core -- never as a
# general index, never for other packages.
ANDROID_PYDANTIC_CORE_REPO = "Eutalix/android-pydantic-core"
ANDROID_MIN_API = 24


def spec_satisfied(spec, version):
    """True when version satisfies a spec (comma-AND clauses)."""
    spec = (spec or "").strip()
    if not spec:
        return True
    current = _version_key(version)
    for clause in spec.split(","):
        clause = clause.strip().replace(" ", "")
        if not clause:
            continue
        matched = False
        for operator in ("===", "==", "~=", ">=", "<=", "!=",
                         ">", "<"):
            if not clause.startswith(operator):
                continue
            matched = True
            want = _version_key(clause[len(operator):])
            if operator in ("==", "===") and current != want:
                return False
            if operator == "!=" and current == want:
                return False
            if operator == ">=" and current < want:
                return False
            if operator == "<=" and current > want:
                return False
            if operator == ">" and current <= want:
                return False
            if operator == "<" and current >= want:
                return False
            if operator == "~=":
                nums = clause[len(operator):].split(".")
                try:
                    ints = [int(part) for part in nums]
                except ValueError:
                    return False
                if len(ints) >= 2:
                    upper = tuple(ints[:-2] + [ints[-2] + 1])
                else:
                    upper = (ints[0] + 1,)
                if current < want or current >= upper:
                    return False
            break
        if not matched:
            if current != _version_key(clause):
                return False
    return True


def dep_spec(dep):
    """(name, spec) from a requires_dist entry (markers dropped)."""
    head = (dep or "").split(";")[0].strip()
    for index, char in enumerate(head):
        if char in "<>~=!":
            return normalize(head[:index]), head[index:].strip()
    parts = head.split()
    if len(parts) > 1:
        return normalize(parts[0]), " ".join(parts[1:])
    return normalize(head), ""


def pydantic_for_core(core_version, cache_dir=None, limit=30):
    """Newest pydantic release accepting this core (or None).

    Scans pydantic releases newest-first and returns the first
    whose pydantic-core constraint is satisfied by core_version,
    so a verified prebuilt wheel can be pinned together with a
    compatible pydantic instead of being replaced by the
    resolver. Pure metadata reads (cached); None when nothing
    matches or the index is unreachable.
    """
    try:
        versions = pypi_versions("pydantic", cache_dir=cache_dir)
    except Exception:
        return None
    for version in (versions or [])[:limit]:
        try:
            meta = pypi_release("pydantic", version,
                                cache_dir=cache_dir)
        except Exception:
            continue
        if not meta:
            continue
        for dep in meta.get("requires_dist", []) or []:
            name, wanted = dep_spec(dep)
            if name == "pydantic-core" and spec_satisfied(
                    wanted, core_version):
                return version
    return None


def android_arch_aliases(machine):
    """Accepted android arch tokens for this machine."""
    machine = (machine or "").lower()
    if machine in ("x86_64", "amd64"):
        return {"x86_64"}
    if machine in ("aarch64", "arm64", "arm64_v8a"):
        return {"aarch64", "arm64", "arm64_v8a"}
    if machine.startswith("armv7") or machine == "armeabi_v7a":
        return {"armv7l", "armeabi_v7a"}
    if machine in ("x86", "i686", "i386"):
        return {"x86", "i686"}
    return {machine}


def parse_android_tag(plat):
    """(api:int|None, arch:str|None) from android_<api>_<arch>."""
    parts = (plat or "").split("_")
    if len(parts) < 3 or parts[0] != "android" \
            or not parts[1].isdigit():
        return None, None
    return int(parts[1]), "_".join(parts[2:])


def _http_bytes(url, timeout=30):
    request = urllib.request.Request(
        url, headers={"User-Agent": "apkforge-bootstrap/2.0"})
    with urllib.request.urlopen(request, timeout=timeout) as resp:
        return resp.read()


def fetch_github_releases(repo, cache_dir=None, ttl=86400,
                          timeout=20, fetcher=None):
    """Reduced release metadata (cached; [] when unreachable).

    [{tag, assets:[{name, url, digest, size}]}]. fetcher(url)->bytes
    is injectable for tests.
    """
    path = None
    if cache_dir is not None:
        path = Path(cache_dir) / "android-wheels" / (
            "%s.json" % repo.replace("/", "-"))
        if path.is_file():
            try:
                cached = json.loads(path.read_text(
                    encoding="utf-8"))
            except ValueError:
                cached = None
            if cached and time.time() - cached.get(
                    "fetched_at", 0) < ttl:
                return cached.get("releases", [])
    fetch = fetcher or (lambda url: _http_bytes(url,
                                                 timeout=timeout))
    try:
        payload = json.loads(fetch(
            "https://api.github.com/repos/%s/releases?per_page=30"
            % repo).decode("utf-8"))
    except Exception:
        return []
    if not isinstance(payload, list):
        return []
    reduced = [{"tag": item.get("tag_name", ""),
                "assets": [{"name": asset.get("name", ""),
                            "url": asset.get(
                                "browser_download_url", ""),
                            "digest": asset.get("digest", ""),
                            "size": asset.get("size", 0)}
                           for asset in item.get("assets", [])]}
               for item in payload]
    if path is not None:
        try:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(
                {"releases": reduced,
                 "fetched_at": time.time()}), encoding="utf-8")
        except OSError:
            pass
    return reduced


def _checksum_for(assets, filename, fetcher):
    """sha256 from a release checksum file (None when absent)."""
    for asset in assets:
        lowered = asset.get("name", "").lower()
        if lowered not in ("sha256sums", "sha256sums.txt",
                           "checksums.txt", "checksums-sha256.txt") \
                and not lowered.endswith(".sha256"):
            continue
        url = asset.get("url", "")
        if not url:
            continue
        try:
            text = fetcher(url).decode("utf-8", "replace")
        except Exception:
            continue
        for line in text.splitlines():
            bits = line.strip().split()
            if len(bits) >= 2 and bits[-1].lstrip("*") == filename:
                digest = bits[0].strip().lower()
                if len(digest) == 64 and all(
                        char in "0123456789abcdef"
                        for char in digest):
                    return digest
    return None


def resolve_android_wheel(constraint, interpreter, machine,
                          device_api, cache_dir=None,
                          fetcher=None,
                          repo=ANDROID_PYDANTIC_CORE_REPO,
                          min_api=ANDROID_MIN_API,
                          releases=None):
    """Pick a verified pydantic-core android wheel.

    Returns (candidate|None, reason). candidate: {filename,
    version, url, sha256, source, api, arch}. releases injectable
    for tests (skips fetch). Absence of a trusted digest rejects.
    """
    if device_api is None:
        return None, "device android api unknown; cannot " \
            "verify min-api"
    if releases is None:
        releases = fetch_github_releases(
            repo, cache_dir=cache_dir, fetcher=fetcher)
    if not releases:
        return None, "release metadata unreachable for %s" % repo
    aliases = android_arch_aliases(machine)
    flat = {item.replace("_", "") for item in aliases}
    prefix = "https://github.com/%s/releases/download/" % repo
    fetch = fetcher or (lambda url: _http_bytes(url,
                                                 timeout=20))
    matches = []
    skipped = {}

    def drop(reason):
        skipped[reason] = skipped.get(reason, 0) + 1

    for release in releases:
        assets = release.get("assets", [])
        for asset in assets:
            name = asset.get("name", "")
            if not name.endswith(".whl"):
                continue
            if normalize(name[:-4].split("-")[0].replace(
                    "_", "-")) != "pydantic-core":
                continue
            parts = name[:-4].split("-")
            version = parts[1] if len(parts) > 1 else ""
            if not spec_satisfied(constraint, version):
                drop("version %s violates %s" % (
                    version, constraint or "constraint"))
                continue
            parsed = parse_wheel_filename(name)
            if parsed is None:
                drop("unparseable filename")
                continue
            if "none" in parsed["abi"]:
                drop("pure-python wheel (pypi covers it)")
                continue
            if interpreter not in parsed["abi"] \
                    and "abi3" not in parsed["abi"]:
                drop("abi mismatch (need %s)" % interpreter)
                continue
            pytags = parsed["python"]
            if interpreter not in pytags and not (
                    "abi3" in parsed["abi"] and any(
                        tag.startswith("cp3")
                        for tag in pytags)):
                drop("python tag mismatch (need %s)"
                     % interpreter)
                continue
            hits = [parse_android_tag(plat)
                    for plat in parsed["platform"]]
            hits = [(api, arch) for api, arch in hits
                    if api is not None]
            if not hits:
                drop("no android platform tag")
                continue
            api, arch = hits[0]
            if arch not in aliases \
                    and arch.replace("_", "") not in flat:
                drop("arch %s not this device (%s)" % (
                    arch, machine))
                continue
            if api < min_api or api > device_api:
                drop("android api %d outside [%d, device %d]"
                     % (api, min_api, device_api))
                continue
            url = asset.get("url", "")
            if not url.startswith(prefix):
                drop("download url outside %s" % repo)
                continue
            sha = None
            digest = asset.get("digest", "")
            if digest.startswith("sha256:") \
                    and len(digest) == 71:
                sha = digest[len("sha256:"):]
            if sha is None:
                sha = _checksum_for(assets, name, fetch)
            if sha is None:
                drop("no trusted sha256 (no digest, no "
                     "checksum file)")
                continue
            matches.append({"filename": name, "version": version,
                            "url": url, "sha256": sha,
                            "source": "%s@%s" % (
                                repo, release.get("tag", "?")),
                            "api": api, "arch": arch})
    if not matches:
        detail = ", ".join("%s x%d" % (reason, count)
                           for reason, count in sorted(
                               skipped.items()))
        return None, "no compatible asset (%s)" % (
            detail or "no wheel assets")
    matches.sort(key=lambda item: _version_key(item["version"]),
                 reverse=True)
    return matches[0], "ok"


def fetch_verified_wheel(url, expected_sha, dest_path,
                         fetcher=None, timeout=300,
                         max_bytes=100 * 1024 * 1024):
    """Download url to dest (reuse cached), verified by sha256.

    Returns (path|None, reason). A mismatch deletes the file and
    rejects; nothing unverified is ever returned.
    """
    dest = Path(dest_path)
    if dest.is_file():
        try:
            data = dest.read_bytes()
        except OSError:
            data = b""
        if data and hashlib.sha256(data).hexdigest() == \
                expected_sha:
            return str(dest), "cached verified copy reused"
        try:
            dest.unlink()
        except OSError:
            pass
    fetch = fetcher or (lambda link: _http_bytes(
        link, timeout=timeout))
    try:
        data = fetch(url)
    except Exception as exc:
        return None, "download failed: %s" % exc
    if len(data) > max_bytes:
        return None, "download exceeds %d bytes" % max_bytes
    if hashlib.sha256(data).hexdigest() != expected_sha:
        return None, "sha256 mismatch: file rejected"
    try:
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
    except OSError as exc:
        return None, "cannot cache wheel: %s" % exc
    return str(dest), "downloaded and verified"


def wheel_matches(parsed, interpreter, version_tuple, fp):
    """True if this wheel installs on this interpreter+platform."""
    if parsed is None:
        return False
    machine = fp.get("arch_machine", "")
    system = (fp.get("os") or "").lower()
    py_ok = False
    for tag in parsed["python"]:
        if tag in (interpreter, "py3", "py2.py3", "py2"):
            py_ok = True
        elif tag.startswith("cp3") and tag[3:].isdigit():
            py_ok = py_ok or int(tag[3:]) <= version_tuple[1] \
                and "abi3" in parsed["abi"]
    if not py_ok:
        return False
    if "none" not in parsed["abi"] and interpreter not in [
            tag for tag in parsed["abi"]] and \
            "abi3" not in parsed["abi"]:
        # cpXY abi must equal the running interpreter.
        if not any(tag == interpreter for tag in parsed["abi"]):
            return False
    if _is_android(fp):
        if parsed["platform"] == ["any"] \
                and parsed["abi"] == ["none"]:
            return True
        # glibc linux wheels never install on bionic, even when the
        # arch name matches; only android-tagged wheels qualify.
        for plat in parsed["platform"]:
            if plat.startswith("android_") \
                    and _machine_matches(machine, plat):
                return True
        return False
    for plat in parsed["platform"]:
        if plat == "any" and parsed["abi"] == ["none"]:
            return True
        if system == "linux" and (
                plat.startswith("manylinux") or
                plat.startswith("musllinux")) \
                and _machine_matches(machine, plat):
            return True
        if system == "darwin" and plat.startswith("macosx") \
                and _machine_matches(machine, plat):
            return True
        if system == "windows" and plat.startswith("win") \
                and _machine_matches(machine, plat):
            return True
        if system == "linux" and plat.startswith("linux_") \
                and _machine_matches(machine, plat):
            return True
    return False


def _cache_path(cache_dir, package):
    return Path(cache_dir) / "pypi" / ("%s.json" % normalize(package))


def pypi_release(package, version=None, cache_dir=None,
                 ttl=86400, timeout=20):
    """PyPI file list for a package (cached; None when unreachable).

    Returns {"version":..., "requires_python":...,
             "files":[{filename,yanked}], "stale":bool} or None.
    """
    package = normalize(package)
    cached = None
    if cache_dir is not None:
        path = _cache_path(cache_dir, package)
        if path.is_file():
            try:
                cached = json.loads(path.read_text(
                    encoding="utf-8"))
            except ValueError:
                cached = None
            if cached and time.time() - cached.get(
                    "fetched_at", 0) < ttl and (
                    version is None or
                    cached.get("version") == version):
                cached["stale"] = False
                return cached
    url = "https://pypi.org/pypi/%s/%s/json" % (
        package, version) if version else \
        "https://pypi.org/pypi/%s/json" % package
    try:
        request = urllib.request.Request(
            url, headers={"User-Agent": "apkforge-bootstrap/2.0"})
        with urllib.request.urlopen(request,
                                    timeout=timeout) as response:
            payload = json.loads(response.read().decode("utf-8"))
    except (urllib.error.URLError, TimeoutError, OSError,
            ValueError):
        if cached is not None:
            cached["stale"] = True
            return cached
        return None
    info = payload.get("info", {})
    result = {"version": info.get("version", version or ""),
              "requires_python": info.get("requires_python"),
              "requires_dist": info.get("requires_dist", []),
              "files": [{"filename": item.get("filename", ""),
                         "yanked": bool(item.get("yanked")),
                         "sha256": item.get("digests", {}).get(
                             "sha256")}
                        for item in payload.get("urls", [])],
              "fetched_at": time.time(), "stale": False}
    if cache_dir is not None:
        try:
            path = _cache_path(cache_dir, package)
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(result), encoding="utf-8")
        except OSError:
            pass
    return result


def _stable_version(text):
    import re
    if not re.match(r"^\d+(\.\d+)*$", (text or "").strip()):
        return False
    return True


def _version_key(text):
    try:
        return tuple(int(part) for part in text.split("."))
    except ValueError:
        return (0,)


def pypi_versions(package, cache_dir=None, ttl=86400, timeout=20):
    """Stable release versions, newest first (cached; [] offline)."""
    package = normalize(package)
    if cache_dir is not None:
        path = Path(cache_dir) / ("%s-versions.json" % package)
        if path.is_file():
            try:
                cached = json.loads(path.read_text(
                    encoding="utf-8"))
            except ValueError:
                cached = None
            if cached and time.time() - cached.get(
                    "fetched_at", 0) < ttl:
                return cached.get("versions", [])
    url = "https://pypi.org/pypi/%s/json" % package
    try:
        request = urllib.request.Request(
            url, headers={"User-Agent": "apkforge-bootstrap/2.0"})
        with urllib.request.urlopen(request,
                                    timeout=timeout) as response:
            payload = json.loads(response.read().decode("utf-8"))
    except (urllib.error.URLError, TimeoutError, OSError,
            ValueError):
        return []
    releases = payload.get("releases", {})
    versions = sorted(
        (version for version, files in releases.items()
         if files and _stable_version(version)),
        key=_version_key, reverse=True)
    if cache_dir is not None:
        try:
            path = Path(cache_dir) / ("%s-versions.json" % package)
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(
                {"versions": versions, "fetched_at": time.time()}),
                encoding="utf-8")
        except OSError:
            pass
    return versions


def compatible_versions(package, fp, cache_dir=None, limit=6):
    """Newest releases with per-version install verdicts here."""
    package = normalize(package)
    cache = cache_dir

    def fetch(name, version=None):
        return pypi_release(name, version, cache_dir=cache)

    out = []
    for version in pypi_versions(package, cache_dir)[:limit]:
        release = fetch(package, version)
        if not release:
            continue
        verdict = assess_package(
            {"name": package, "spec": "==%s" % version,
             "extras": [], "marker": "",
             "raw": "%s==%s" % (package, version)}, fp, fetch)
        verdict["release_files"] = len(release.get("files", []))
        out.append(verdict)
    return out


def _bounds_ok(requires_python, version_tuple):
    if not requires_python:
        return True
    current = version_tuple[0] * 100 + version_tuple[1]
    for clause in requires_python.split(","):
        clause = clause.strip().replace(" ", "")
        for operator in (">=", "<=", "==", ">", "<", "~="):
            if clause.startswith(operator):
                rest = clause[len(operator):]
                parts = rest.split(".")
                try:
                    want = int(parts[0]) * 100 + int(
                        parts[1] if len(parts) > 1 else 0)
                except ValueError:
                    return True
                if operator == ">=" and current < want:
                    return False
                if operator == ">" and current <= want:
                    return False
                if operator == "<=" and current > want:
                    return False
                if operator == "<" and current >= want:
                    return False
                if operator == "==" and current != want:
                    return False
                break
    return True


def pinned_version(spec):
    """Exact == pin from a spec string, else None."""
    for clause in (spec or "").split(","):
        clause = clause.strip()
        if clause.startswith("==") and "*" not in clause:
            return clause[2:].strip()
    return None


def assess_package(req, fp, pypi_fn=None):
    """Verdict for one requirement (pure given pypi_fn)."""
    name = normalize(req.get("name", ""))
    native = NATIVE_INDEX.get(name, {})
    interpreter, version_tuple = interpreter_tag(
        fp.get("python_version", ""))
    fetch = pypi_fn or (lambda package, version=None:
                        pypi_release(package, version))
    release = fetch(name, pinned_version(req.get("spec", "")))
    verdict = {"package": name, "requested": req.get("spec", ""),
               "via": req.get("via"), "status": "UNKNOWN",
               "version": None, "build": list(native.get(
                   "build", [])), "notes": [],
               "source": "pypi", "wheel": None,
               "external_android_wheels": []}
    if release is None:
        verdict["notes"].append(
            "pypi unreachable and nothing cached")
        return verdict
    verdict["version"] = release.get("version")
    if not _bounds_ok(release.get("requires_python"),
                      version_tuple):
        verdict["status"] = "PYTHON_INCOMPATIBLE"
        verdict["notes"].append("requires-python %s vs %s" % (
            release.get("requires_python"),
            fp.get("python_version", "?")))
        return verdict
    wheels = [item for item in release.get("files", [])
              if item.get("filename", "").endswith(".whl")
              and not item.get("yanked")]
    for item in wheels:
        parsed = parse_wheel_filename(item["filename"])
        if wheel_matches(parsed, interpreter, version_tuple, fp):
            verdict["status"] = "WHEEL_OK"
            verdict["wheel"] = {
                "filename": item["filename"],
                "sha256": item.get("sha256"),
                "source": "pypi"}
            return verdict
    if _is_android(fp):
        linux_wheels = [
            item for item in wheels
            if any(tag.split("_")[0] in ("manylinux",
                                         "musllinux", "linux")
                   for tag in (parse_wheel_filename(
                       item["filename"]) or {}).get(
                       "platform", []))]
        if linux_wheels:
            verdict["notes"].append(
                "%d linux-tagged wheel(s) rejected on android "
                "(bionic, not glibc)" % len(linux_wheels))
        external = android_wheel_candidates(
            name, verdict["version"], interpreter,
            fp.get("arch_machine", ""))
        verdict["external_android_wheels"] = external
        if external:
            verdict["notes"].append(
                "%d allowlisted external android wheel(s) "
                "listed (advisory only, never auto-installed)"
                % len(external))
    sdists = [item for item in release.get("files", [])
              if item.get("filename", "").endswith(
                  (".tar.gz", ".zip")) and not item.get("yanked")]
    if sdists:
        verdict["status"] = "NEEDS_BUILD"
        if not verdict["build"]:
            verdict["build"] = ["unknown-toolchain"]
            verdict["notes"].append(
                "sdist-only; toolchain unknown")
        return verdict
    if not release.get("files"):
        verdict["status"] = "UNKNOWN"
        verdict["notes"].append("no files listed")
        return verdict
    verdict["status"] = "NO_ARTIFACT"
    verdict["notes"].append(
        "%d files, none installable here"
        % len(release.get("files", [])))
    return verdict


def preflight(requirements_path, fp, profile=None,
              cache_dir=None, pypi_fn=None):
    """Full preflight: verdicts + blockers + warnings."""
    fetch = pypi_fn
    if fetch is None and cache_dir is not None:
        cache = cache_dir

        def fetch(package, version=None):
            return pypi_release(package, version,
                                cache_dir=cache)
    reqs = expand_extras(parse_requirements(requirements_path))
    report = {"packages": [], "blockers": [], "warnings": [],
              "offline": False}
    profile = profile or {}
    for req in reqs:
        if "error" in req:
            report["blockers"].append(req["error"])
            continue
        verdict = assess_package(req, fp, fetch)
        report["packages"].append(verdict)
        if verdict["status"] == "UNKNOWN":
            report["offline"] = True
    termux = bool(fp.get("termux"))
    for verdict in report["packages"]:
        status = verdict["status"]
        if status == "PYTHON_INCOMPATIBLE":
            report["blockers"].append(
                "%s %s: incompatible with Python %s" % (
                    verdict["package"],
                    verdict["requested"] or verdict["version"],
                    fp.get("python_version", "?")))
        elif status == "NEEDS_BUILD":
            langs = verdict["build"]
            missing = [lang for lang in langs
                       if lang == "rust"
                       and not profile.get("compiler_rust")
                       or lang == "c"
                       and not profile.get("compiler_c")]
            pkg_cmd = "pkg install" if termux else \
                "%s <toolchain>" % (
                    profile.get("package_manager")
                    or "system package manager")
            if missing:
                report["blockers"].append(
                    "%s %s: no compatible wheel; needs %s "
                    "(missing here; e.g. %s)" % (
                        verdict["package"],
                        verdict["version"] or verdict["requested"],
                        "+".join(missing), pkg_cmd))
            else:
                report["warnings"].append(
                    "%s %s: source build (%s toolchain present)"
                    % (verdict["package"],
                       verdict["version"] or "", "+".join(langs)))
        elif status == "NO_ARTIFACT":
            report["blockers"].append(
                "%s: published files exist but none install "
                "on %s/%s" % (
                    verdict["package"],
                    "android-termux" if termux
                    else fp.get("os_id", "?"),
                    fp.get("arch_machine", "?")))
    if report["offline"]:
        report["warnings"].append(
            "pypi unreachable for some packages; pip will try, "
            "recovery will catch failures")
    return report


def strip_known_extras(text):
    """Drop KNOWN_EXTRAS extras (documented minimal fallback).

    Only extras the matrix knows (native-heavy, performance-only)
    are stripped; unknown extras are kept verbatim.
    """
    out = []
    for raw in (text or "").splitlines():
        line, hash_mark, comment = raw.partition("#")
        parsed = parse_requirement_line(line)
        if not parsed or "name" not in parsed:
            out.append(raw)
            continue
        known = KNOWN_EXTRAS.get(parsed["name"], {})
        keep = [extra for extra in parsed.get("extras", [])
                if extra not in known]
        if len(keep) == len(parsed.get("extras", [])):
            out.append(raw)
            continue
        rebuilt = parsed["name"]
        if keep:
            rebuilt += "[%s]" % ",".join(keep)
        rebuilt += parsed.get("spec", "")
        if parsed.get("marker"):
            rebuilt += "; %s" % parsed["marker"]
        if hash_mark:
            rebuilt += " #%s" % comment
        out.append(rebuilt)
    return "\n".join(out) + ("\n" if text.endswith("\n") else "")
