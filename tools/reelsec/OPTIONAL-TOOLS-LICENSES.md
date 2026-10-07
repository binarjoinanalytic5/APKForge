# Optional open-source tool inventory

ReelSec invokes these tools as external adapters; their source is not copied into the ReelSec implementation.

| Tool | Role | License | Integration mode |
|---|---|---|---|
| MobSF / mobsfscan | Android source/static security patterns | MobSF: GPL-3.0; mobsfscan: LGPL-3.0 | External command / availability |
| radare2 | Native ELF reverse-engineering inventory | LGPL-3.0 (plugins may differ) | External command |
| JADX | DEX/APK Java-oriented decompilation | GPL-3.0 | External command, disposable output |
| objection | Frida-powered runtime exploration | GPL-3.0 | Availability only in this phase |

Licensing is based on each project's repository metadata/license. The adapter layer does not redistribute or embed these projects.

Evidence policy: external-tool output is advisory evidence. It is never treated as causal proof of screenshot/recording protection. Missing tools are reported as UNAVAILABLE.

Safety boundary: adapters are read-only. They do not disable protections, patch the target APK, inject bypass hooks, sign artifacts, or modify the input.
