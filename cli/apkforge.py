#!/usr/bin/env python3
"""APKForge CLI: thin stdlib client over the REST API (Phase 1).

Every command is a 1:1 REST call (plan §7.2) — no logic lives here.
Token resolution: --token flag > APKFORGE_TOKEN env > config file
(~/.config/apkforge/config.json). No raw keys on the command line:
signing takes a keystore *reference* only.
"""
import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

TERMINAL = ("succeeded", "failed", "cancelled")


class CLIError(RuntimeError):
    pass


def config_path():
    home = os.environ.get("HOME", os.path.expanduser("~"))
    return os.path.join(home, ".config", "apkforge", "config.json")


def load_config():
    try:
        with open(config_path(), encoding="utf-8") as handle:
            config = json.load(handle)
        return config if isinstance(config, dict) else {}
    except (OSError, ValueError):
        return {}


def save_config(base_url, token):
    path = config_path()
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as handle:
        json.dump({"base_url": base_url, "token": token}, handle)
    try:
        os.chmod(path, 0o600)
    except OSError:
        pass


def resolve_base_url(args):
    return (getattr(args, "base_url", None)
            or os.environ.get("APKFORGE_URL")
            or load_config().get("base_url")
            or "http://127.0.0.1:8000").rstrip("/")


def resolve_token(args):
    token = (getattr(args, "token", None)
             or os.environ.get("APKFORGE_TOKEN")
             or load_config().get("token"))
    if not token:
        raise CLIError("no token: run 'apkforge login' first")
    return token


def api(base_url, token, method, path, body=None, raw=None,
        content_type=None):
    url = base_url + path
    data = None
    headers = {}
    if token:
        headers["Authorization"] = "Bearer " + token
    if raw is not None:
        data = raw
        headers["Content-Type"] = content_type
    elif body is not None:
        data = json.dumps(body).encode("utf-8")
        headers["Content-Type"] = "application/json"
    request = urllib.request.Request(url, data=data, headers=headers,
                                     method=method)
    try:
        with urllib.request.urlopen(request,
                                    timeout=120) as response:
            payload = response.read()
            ctype = response.headers.get("Content-Type", "")
            if "application/json" in ctype:
                return json.loads(payload.decode("utf-8") or "{}")
            return payload
    except urllib.error.HTTPError as exc:
        detail = exc.read(2000).decode("utf-8", "replace")
        raise CLIError("HTTP %d %s: %s" % (exc.code, path,
                                           detail)) from None
    except urllib.error.URLError as exc:
        raise CLIError("cannot reach %s: %s" % (url, exc)) from None


def encode_multipart(fields, files):
    boundary = "----apkforge-%d" % int(time.time() * 1000)
    chunks = []
    for name, value in fields.items():
        chunks += ["--" + boundary,
                   'Content-Disposition: form-data; name="%s"' % name,
                   "", value]
    for name, (filename, content) in files.items():
        chunks += ["--" + boundary,
                   'Content-Disposition: form-data; name="%s"; '
                   'filename="%s"' % (name, filename),
                   "Content-Type: application/octet-stream", "",
                   content]
    body = b""
    for chunk in chunks:
        body += chunk.encode("utf-8") + b"\r\n" if isinstance(
            chunk, str) else chunk + b"\r\n"
    body += ("--" + boundary + "--\r\n").encode("utf-8")
    return body, "multipart/form-data; boundary=" + boundary


def wait_job(base_url, token, job_id, timeout):
    deadline = time.time() + timeout
    while True:
        job = api(base_url, token, "GET",
                  "/api/v1/jobs/" + job_id)
        if job["status"] in TERMINAL:
            return job
        if time.time() > deadline:
            raise CLIError("timed out waiting for " + job_id)
        time.sleep(1.0)


def cmd_login(args):
    base_url = resolve_base_url(args)
    if args.token:
        save_config(base_url, args.token)
        print(json.dumps({"saved": True, "base_url": base_url}))
        return
    if not args.username or not args.password:
        raise CLIError("login needs --token or --username + --password")
    result = api(base_url, None, "POST", "/api/v1/auth/login",
                 {"username": args.username,
                  "password": args.password})
    save_config(base_url, result["access_token"])
    print(json.dumps({"saved": True, "base_url": base_url}))


def cmd_register(args):
    base_url = resolve_base_url(args)
    result = api(base_url, None, "POST", "/api/v1/auth/register",
                 {"username": args.username,
                  "password": args.password})
    save_config(base_url, result["access_token"])
    print(json.dumps(result))


def cmd_project(args):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    if args.action == "create":
        print(json.dumps(api(base_url, token, "POST",
                             "/api/v1/projects",
                             {"name": args.name})))
    elif args.action == "list":
        print(json.dumps(api(base_url, token, "GET",
                             "/api/v1/projects")))
    elif args.action == "get":
        print(json.dumps(api(base_url, token, "GET",
                             "/api/v1/projects/" + args.project_id)))
    elif args.action == "delete":
        api(base_url, token, "DELETE",
            "/api/v1/projects/" + args.project_id)
        print(json.dumps({"deleted": args.project_id}))


def cmd_upload(args):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    with open(args.file, "rb") as handle:
        content = handle.read()
    body, ctype = encode_multipart(
        {}, {"file": (os.path.basename(args.file), content)})
    job = api(base_url, token, "POST",
              "/api/v1/projects/%s/upload" % args.project_id,
              raw=body, content_type=ctype)
    print(json.dumps(job))


def _start_and_maybe_wait(args, kind, path, body):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    job = api(base_url, token, "POST",
              "/api/v1/projects/%s/%s" % (args.project_id, path),
              body)
    if args.wait:
        job = wait_job(base_url, token, job["job_id"], args.timeout)
    print(json.dumps(job))


def cmd_decompile(args):
    body = {}
    if args.tool:
        body = {"tool": args.tool}
    _start_and_maybe_wait(args, "decompile", "decompile", body)


def cmd_analyze(args):
    body = {}
    if args.tool:
        body = {"tool": args.tool}
    _start_and_maybe_wait(args, "analyze", "analyze", body)


def cmd_rebuild(args):
    _start_and_maybe_wait(args, "rebuild", "rebuild", {})


def cmd_sign(args):
    body = {}
    if args.keystore_ref:
        body["keystore_ref"] = args.keystore_ref
    if args.schemes:
        body["schemes"] = args.schemes.split(",")
    _start_and_maybe_wait(args, "sign", "sign", body)


def cmd_job(args):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    job = api(base_url, token, "GET", "/api/v1/jobs/" + args.id)
    if args.follow:
        job = wait_job(base_url, token, args.id, args.timeout)
    print(json.dumps(job))


def cmd_logs(args):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    result = api(base_url, token, "GET",
                 "/api/v1/jobs/" + args.id + "/logs")
    for line in result.get("lines", []):
        print(line)


def cmd_download(args):
    base_url = resolve_base_url(args)
    token = resolve_token(args)
    blob = api(base_url, token, "GET",
               "/api/v1/projects/%s/download" % args.project_id)
    with open(args.output, "wb") as handle:
        handle.write(blob)
    print(json.dumps({"saved": args.output, "bytes": len(blob)}))


def build_parser():
    parser = argparse.ArgumentParser(prog="apkforge",
                                     description="APKForge CLI (REST)")
    parser.add_argument("--base-url", default=None)
    parser.add_argument("--token", default=None)
    sub = parser.add_subparsers(dest="command", required=True)

    login = sub.add_parser("login")
    login.add_argument("--token", default=None)
    login.add_argument("--username", default=None)
    login.add_argument("--password", default=None)
    login.add_argument("--base-url", default=None)
    login.set_defaults(func=cmd_login)

    register = sub.add_parser("register")
    register.add_argument("--username", required=True)
    register.add_argument("--password", required=True)
    register.add_argument("--base-url", default=None)
    register.set_defaults(func=cmd_register)

    project = sub.add_parser("project")
    project.add_argument("action",
                         choices=["create", "list", "get", "delete"])
    project.add_argument("--name", default=None)
    project.add_argument("--project-id", "--id", default=None)
    project.set_defaults(func=cmd_project)

    upload = sub.add_parser("upload")
    upload.add_argument("--project-id", "--id", required=True)
    upload.add_argument("--file", required=True)
    upload.set_defaults(func=cmd_upload)

    for name, func in (("decompile", cmd_decompile),
                       ("analyze", cmd_analyze)):
        cmd = sub.add_parser(name)
        cmd.add_argument("--project-id", "--id", required=True)
        cmd.add_argument("--tool", default=None)
        cmd.add_argument("--wait", action="store_true")
        cmd.add_argument("--timeout", type=int, default=600)
        cmd.set_defaults(func=func)

    rebuild = sub.add_parser("rebuild")
    rebuild.add_argument("--project-id", "--id", required=True)
    rebuild.add_argument("--wait", action="store_true")
    rebuild.add_argument("--timeout", type=int, default=600)
    rebuild.set_defaults(func=cmd_rebuild)

    sign = sub.add_parser("sign")
    sign.add_argument("--project-id", "--id", required=True)
    sign.add_argument("--keystore-ref", default=None)
    sign.add_argument("--schemes", default=None)
    sign.add_argument("--wait", action="store_true")
    sign.add_argument("--timeout", type=int, default=600)
    sign.set_defaults(func=cmd_sign)

    job = sub.add_parser("job")
    job.add_argument("--id", required=True)
    job.add_argument("--follow", action="store_true")
    job.add_argument("--timeout", type=int, default=600)
    job.set_defaults(func=cmd_job)

    logs = sub.add_parser("logs")
    logs.add_argument("--id", required=True)
    logs.set_defaults(func=cmd_logs)

    download = sub.add_parser("download")
    download.add_argument("--project-id", "--id", required=True)
    download.add_argument("--output", required=True)
    download.set_defaults(func=cmd_download)
    return parser


def main(argv=None):
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        args.func(args)
    except CLIError as exc:
        print("error: %s" % exc, file=sys.stderr)
        return 1
    except BrokenPipeError:
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
