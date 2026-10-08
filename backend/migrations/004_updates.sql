-- 004_updates: releases, notifications, reads, preferences.
CREATE TABLE IF NOT EXISTS releases (
    id TEXT PRIMARY KEY,
    version TEXT NOT NULL,
    version_code INTEGER NOT NULL,
    release_type TEXT NOT NULL,
    channel TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'draft',
    minimum_supported_version TEXT NOT NULL,
    mandatory INTEGER NOT NULL DEFAULT 0,
    security_update INTEGER NOT NULL DEFAULT 0,
    artifact_kind TEXT NOT NULL,
    download_url TEXT,
    artifact_ref TEXT,
    checksum TEXT,
    signature TEXT,
    size_bytes INTEGER NOT NULL DEFAULT 0,
    release_notes TEXT NOT NULL DEFAULT '[]',
    breaking_changes TEXT NOT NULL DEFAULT '[]',
    security_notes TEXT NOT NULL DEFAULT '',
    migration_required INTEGER NOT NULL DEFAULT 0,
    restart_required INTEGER NOT NULL DEFAULT 1,
    release_date TEXT,
    published_at TEXT,
    created_by TEXT NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_releases_version
    ON releases (version);
CREATE INDEX IF NOT EXISTS idx_releases_channel_status
    ON releases (channel, status);
CREATE TABLE IF NOT EXISTS notifications (
    id TEXT PRIMARY KEY,
    ntype TEXT NOT NULL,
    severity TEXT NOT NULL DEFAULT 'info',
    priority INTEGER NOT NULL DEFAULT 1,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    action TEXT NOT NULL DEFAULT '{}',
    target TEXT NOT NULL DEFAULT 'all',
    created_at TEXT NOT NULL,
    expires_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_notifications_target
    ON notifications (target, created_at);
CREATE TABLE IF NOT EXISTS notification_reads (
    notification_id TEXT NOT NULL,
    username TEXT NOT NULL,
    read_at TEXT NOT NULL,
    PRIMARY KEY (notification_id, username)
);
CREATE TABLE IF NOT EXISTS notification_prefs (
    username TEXT PRIMARY KEY,
    prefs TEXT NOT NULL DEFAULT '{}',
    updated_at TEXT NOT NULL
);
