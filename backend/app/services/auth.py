"""Registration, login, and token verification (stdlib logic)."""
from ..core.rbac import ROLES, audit_record
from ..core.security import (AuthError, create_token, hash_password,
                             verify_password, verify_token)
from ..core.store import StoreError


class AuthService:
    def __init__(self, store, key):
        self.store = store
        self.key = key

    def register(self, username, password, role="viewer"):
        username = (username or "").strip()
        if len(username) < 3 or len(username) > 64:
            raise AuthError("username must be 3-64 characters")
        if role not in ROLES:
            raise AuthError("unknown role %r" % (role,))
        first = self.store.user_count() == 0
        if first:
            role = "admin"  # documented bootstrap rule
        elif role == "admin":
            raise AuthError("admin promotion needs an admin (Phase 2)")
        try:
            pw_hash = hash_password(password)
        except AuthError:
            raise AuthError("password must be at least 12 characters")
        try:
            self.store.create_user(username, pw_hash, role)
        except StoreError:
            raise AuthError("user exists") from None
        self.store.append_audit(audit_record(
            actor=username, action="auth.register", target=username,
            result="ok", detail={"role": role}))
        return {"access_token": create_token(sub=username, role=role,
                                             key=self.key),
                "token_type": "bearer"}

    def login(self, username, password):
        user = self.store.get_user(username or "")
        if not user or not verify_password(password or "",
                                           user["pw_hash"]):
            self.store.append_audit(audit_record(
                actor=username or "?", action="auth.login",
                target=username or "?", result="denied"))
            raise AuthError("invalid credentials")
        self.store.append_audit(audit_record(
            actor=username, action="auth.login", target=username,
            result="ok"))
        return {"access_token": create_token(
            sub=user["username"], role=user["role"], key=self.key),
            "token_type": "bearer"}

    def verify(self, token):
        payload = verify_token(token, self.key)
        user = self.store.get_user(payload["sub"])
        if not user:
            raise AuthError("unknown user")
        return {"sub": user["username"], "role": user["role"]}
