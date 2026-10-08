"""Authentication primitives (stdlib only, no PyJWT needed).

PBKDF2-HMAC-SHA256 password hashing and HS256 JWTs. The signing key
comes from the ``APKFORGE_KEY`` environment variable (or an explicit
argument in tests); the process refuses to start without one.
"""
import base64
import hashlib
import hmac
import json
import os
import secrets
import time

KEY_ENV = "APKFORGE_KEY"
PBKDF2_ROUNDS = 210_000
TOKEN_TTL_S = 12 * 3600


class AuthError(RuntimeError):
    pass


def _b64url(data):
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode("ascii")


def _b64url_decode(text):
    pad = "=" * (-len(text) % 4)
    return base64.urlsafe_b64decode((text + pad).encode("ascii"))


def resolve_key(explicit=None):
    key = explicit or os.environ.get(KEY_ENV, "")
    if not key or len(key) < 32:
        raise AuthError(
            "signing key missing: set %s (>=32 chars)" % KEY_ENV)
    return key


def hash_password(password):
    if not password or len(password) < 12:
        raise AuthError("password must be at least 12 characters")
    salt = secrets.token_bytes(16)
    digest = hashlib.pbkdf2_hmac("sha256", password.encode("utf-8"),
                                 salt, PBKDF2_ROUNDS)
    return "pbkdf2$%d$%s$%s" % (PBKDF2_ROUNDS, _b64url(salt),
                                _b64url(digest))


def verify_password(password, stored):
    try:
        scheme, rounds, salt, digest = stored.split("$")
        assert scheme == "pbkdf2"
        expected = hashlib.pbkdf2_hmac(
            "sha256", (password or "").encode("utf-8"),
            _b64url_decode(salt), int(rounds))
    except Exception:
        return False
    return hmac.compare_digest(expected, _b64url_decode(digest))


def create_token(sub, role, key, ttl_s=TOKEN_TTL_S):
    header = _b64url(json.dumps({"alg": "HS256", "typ": "JWT"},
                                separators=(",", ":")).encode("utf-8"))
    now = int(time.time())
    body = _b64url(json.dumps(
        {"sub": sub, "role": role, "iat": now, "exp": now + ttl_s},
        separators=(",", ":")).encode("utf-8"))
    signing_input = ("%s.%s" % (header, body)).encode("ascii")
    signature = _b64url(hmac.new(key.encode("utf-8"), signing_input,
                                 hashlib.sha256).digest())
    return "%s.%s.%s" % (header, body, signature)


def verify_token(token, key):
    try:
        header_b64, body_b64, signature = token.split(".")
        signing_input = ("%s.%s" % (header_b64, body_b64)).encode("ascii")
        expected = _b64url(hmac.new(
            key.encode("utf-8"), signing_input,
            hashlib.sha256).digest())
        if not hmac.compare_digest(expected, signature):
            raise AuthError("bad signature")
        header = json.loads(_b64url_decode(header_b64))
        payload = json.loads(_b64url_decode(body_b64))
        if header.get("alg") != "HS256":
            raise AuthError("unexpected alg")
        if int(payload.get("exp", 0)) < int(time.time()):
            raise AuthError("token expired")
        if not payload.get("sub") or not payload.get("role"):
            raise AuthError("token lacks sub/role")
        return payload
    except AuthError:
        raise
    except Exception as exc:
        raise AuthError("malformed token: %s" % exc)
