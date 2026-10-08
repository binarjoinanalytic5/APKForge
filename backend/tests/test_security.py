"""Unit tests: hashing + JWT round-trips (stdlib core)."""
import time

import pytest

from app.core.security import (AuthError, create_token, hash_password,
                               resolve_key, verify_password,
                               verify_token)

KEY = "unit-test-key-0123456789abcdef-XYZ!!"


def test_password_roundtrip_and_wrong():
    stored = hash_password("correct-horse-12345")
    assert stored.startswith("pbkdf2$")
    assert verify_password("correct-horse-12345", stored) is True
    assert verify_password("wrong-password-1", stored) is False
    assert verify_password("", stored) is False
    assert verify_password("correct-horse-12345", "garbage") is False


def test_password_minimum_length():
    with pytest.raises(AuthError):
        hash_password("too-short")


def test_token_roundtrip():
    token = create_token("alice", "admin", KEY)
    payload = verify_token(token, KEY)
    assert payload["sub"] == "alice"
    assert payload["role"] == "admin"
    assert payload["exp"] > payload["iat"]


def test_token_tamper_rejected():
    token = create_token("alice", "admin", KEY)
    head, body, sig = token.split(".")
    with pytest.raises(AuthError):
        verify_token(token[:-1] + ("A" if sig[-1] != "A" else "B"),
                     KEY)
    with pytest.raises(AuthError):
        verify_token(token, KEY + "wrong")


def test_token_expiry_rejected():
    token = create_token("alice", "admin", KEY, ttl_s=-1)
    with pytest.raises(AuthError):
        verify_token(token, KEY)


def test_malformed_tokens_rejected():
    for bad in ("", "a.b", "a.b.c.d", "not-a-token"):
        with pytest.raises(AuthError):
            verify_token(bad, KEY)


def test_resolve_key_requires_32_chars(monkeypatch):
    monkeypatch.delenv("APKFORGE_KEY", raising=False)
    with pytest.raises(AuthError):
        resolve_key()
    with pytest.raises(AuthError):
        resolve_key("short")
    assert resolve_key(KEY) == KEY
    monkeypatch.setenv("APKFORGE_KEY", KEY)
    assert resolve_key() == KEY
