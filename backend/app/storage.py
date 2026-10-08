"""Blob storage behind an interface (Phase 1: local disk backend).

Content-addressed (SHA-256) so every artifact is self-verifying. The S3
backend (SeaweedFS) implements the same interface in Phase 2.
"""
import hashlib
import shutil
from abc import ABC, abstractmethod
from pathlib import Path


class BlobStore(ABC):
    @abstractmethod
    def put_bytes(self, data, *, name):
        """Store bytes; return {sha256, size, name}."""

    @abstractmethod
    def put_file(self, path, *, name):
        """Store a file without loading it fully; return the record."""

    @abstractmethod
    def get_bytes(self, sha256):
        """Return bytes or raise BlobMissing."""

    @abstractmethod
    def path_for(self, sha256):
        """Local path of the blob (backend-local runs)."""


class BlobMissing(FileNotFoundError):
    pass


class LocalBlobStore(BlobStore):
    def __init__(self, root):
        self.root = Path(root)
        (self.root / "sha256").mkdir(parents=True, exist_ok=True)

    def _path(self, sha256):
        if not sha256 or len(sha256) != 64 or any(
                ch not in "0123456789abcdef" for ch in sha256):
            raise BlobMissing("invalid digest")
        return self.root / "sha256" / sha256[:2] / sha256[2:]

    def put_bytes(self, data, *, name):
        digest = hashlib.sha256(bytes(data)).hexdigest()
        target = self._path(digest)
        target.parent.mkdir(parents=True, exist_ok=True)
        if not target.is_file():
            target.write_bytes(bytes(data))
        return {"sha256": digest, "size": len(data), "name": name}

    def put_file(self, path, *, name):
        digest = hashlib.sha256()
        with open(path, "rb") as handle:
            for chunk in iter(lambda: handle.read(65536), b""):
                digest.update(chunk)
        hexdigest = digest.hexdigest()
        target = self._path(hexdigest)
        target.parent.mkdir(parents=True, exist_ok=True)
        if not target.is_file():
            shutil.copyfile(path, target)
        return {"sha256": hexdigest, "size": target.stat().st_size,
                "name": name}

    def get_bytes(self, sha256):
        target = self._path(sha256)
        if not target.is_file():
            raise BlobMissing(sha256)
        return target.read_bytes()

    def path_for(self, sha256):
        target = self._path(sha256)
        if not target.is_file():
            raise BlobMissing(sha256)
        return str(target)
