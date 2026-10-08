-- 003_job_indexes: lookup indexes + constraints documentation.
-- (SQLite enforces PRIMARY KEY/UNIQUE/NOT NULL from 001; these cover
-- the hot read paths: project jobs, job status, project artifacts,
-- audit trail scans.)
CREATE INDEX IF NOT EXISTS idx_jobs_project ON jobs (project_id);
CREATE INDEX IF NOT EXISTS idx_jobs_status ON jobs (status);
CREATE INDEX IF NOT EXISTS idx_artifacts_project ON artifacts (project_id);
CREATE INDEX IF NOT EXISTS idx_audit_action ON audit (action);
CREATE INDEX IF NOT EXISTS idx_audit_ts ON audit (ts);
