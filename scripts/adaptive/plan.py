"""Bootstrap plan: what exists, what will happen (pure).

Built from fingerprint + inventory + preflight, before anything is
installed. ``--plan`` prints it and changes nothing.
"""
from __future__ import annotations


def _step(identifier, title, action, detail=""):
    return {"id": identifier, "title": title, "action": action,
            "detail": detail}


def build_plan(fp, profile, inventory_rows, preflight, state,
               opts):
    """Assemble the ordered bootstrap plan (no side effects)."""
    steps = []
    downloads = []
    warnings = list((preflight or {}).get("warnings", []))
    may_fail = list((preflight or {}).get("blockers", []))
    plat = (profile or {}).get("platform", "?")
    steps.append(_step(
        "ENVIRONMENT", "Environment %s / %s" % (
            plat, fp.get("arch_machine", "?")), "VERIFY",
        "fingerprint %s" % fp.get("fingerprint_hash", "?")))
    for row in inventory_rows or []:
        title = "%s %s" % (row["tool"], row["detected"])
        if row["status"] == "AVAILABLE":
            steps.append(_step("TOOLS:" + row["tool"], title,
                               "REUSE", row.get("path") or ""))
        elif row["role"] == "REQUIRED":
            if row["status"] == "OUTDATED":
                steps.append(_step("TOOLS:" + row["tool"], title,
                                   "PROVISION",
                                   "too old; %s" % row.get(
                                       "method", "")))
            else:
                steps.append(_step("TOOLS:" + row["tool"],
                                   row["tool"] + " missing",
                                   "PROVISION",
                                   row.get("method", "")))
                downloads.append("%s (%s)" % (
                    row["tool"], row.get("source", "?")))
        elif row["tool"] == "apktool" and opts.get(
                "install_tools"):
            steps.append(_step("TOOLS:apktool", "apktool",
                               "PROVISION", row.get("method", "")))
            downloads.append("apktool jar (~18MB)")
        else:
            steps.append(_step(
                "TOOLS:" + row["tool"], title, "SKIP",
                "optional (%s)" % row["status"].lower()))
    state = state or {}
    if state.get("venv_valid"):
        steps.append(_step("RUNTIME", "Virtualenv", "REUSE",
                           ".venv verified"))
    elif state.get("venv_exists"):
        steps.append(_step("RUNTIME", "Virtualenv", "REPAIR",
                           "exists but invalid; repair or "
                           "recreate"))
    else:
        steps.append(_step("RUNTIME", "Virtualenv", "CREATE",
                           "project-local .venv"))
    direct = [item for item in (preflight or {}).get("packages", [])
              if not item.get("via")]
    need_build = [item for item in direct
                  if item.get("status") == "NEEDS_BUILD"]
    steps.append(_step(
        "DEPENDENCIES", "Backend deps (%d direct)" % len(direct),
        "INSTALL", "pip install -r backend/requirements.txt"
        + ("; %d need source builds" % len(need_build)
           if need_build else "")))
    toolchains = sorted({lang for item in need_build
                         for lang in item.get("build", [])
                         if lang in ("c", "rust")})
    manager = (profile or {}).get("package_manager")
    for lang in toolchains:
        steps.append(_step(
            "DEPENDENCIES:" + lang,
            "Toolchain (%s)" % lang, "PROVISION",
            "%s install %s" % (
                manager or "system package manager",
                {"c": "clang/gcc", "rust": "rust"}.get(lang,
                                                       lang))))
    if state.get("env_exists"):
        steps.append(_step("CONFIG", ".env", "VERIFY",
                           "validate, keep secrets"))
    else:
        steps.append(_step("CONFIG", ".env", "CREATE",
                           "generate + validate"))
    steps.append(_step(
        "DATABASE", "Database",
        "VERIFY" if state.get("db_exists") else "CREATE",
        "sqlite + migrations"))
    if opts.get("skip_build"):
        steps.append(_step("BUILD", "Frontend", "SKIP",
                           "--skip-build"))
    else:
        steps.append(_step("BUILD", "Frontend", "INSTALL",
                           "npm install + build"))
    steps.append(_step("SERVICES", "Services", "START",
                       "backend + frontend"))
    steps.append(_step("HEALTH", "Health + smoke", "VERIFY",
                       "api health, setup status"))
    if opts.get("offline"):
        warnings.append("offline: only cache + local tools; "
                        "network steps will block, not fail all")
    return {"steps": steps, "downloads": downloads,
            "warnings": warnings, "may_fail": may_fail}


def render_plan(plan):
    lines = ["BOOTSTRAP PLAN", ""]
    for step in plan.get("steps", []):
        lines.append("%-9s %-28s %s" % (
            step["action"], step["title"][:28],
            step["detail"][:80]))
    if plan.get("downloads"):
        lines.append("")
        lines.append("will download:")
        for item in plan["downloads"]:
            lines.append("  - %s" % item)
    if plan.get("may_fail"):
        lines.append("")
        lines.append("may fail (preflight):")
        for item in plan["may_fail"]:
            lines.append("  ! %s" % item)
    if plan.get("warnings"):
        lines.append("")
        lines.append("warnings:")
        for item in plan["warnings"]:
            lines.append("  * %s" % item)
    return "\n".join(lines)
