"""Adaptive bootstrap engine: detect once, plan, reuse, recover.

Stdlib only. Every module is importable on its own and every
detector accepts injectable inputs so unit tests never touch the
real machine or the real network.
"""

ENGINE_VERSION = "2.0.0"
