import axios from 'axios'
import { ref } from 'vue'

export const api = axios.create({ baseURL: '' })

export function setToken(token: string): void {
  if (token) {
    api.defaults.headers.common['Authorization'] = 'Bearer ' + token
  } else {
    delete api.defaults.headers.common['Authorization']
  }
}

export interface Project {
  id: string
  name: string
  created_at: string
}

export interface Job {
  job_id: string
  project_id: string
  kind: string
  status: string
  error: string | null
  created_at: string
}

export async function register(username: string, password: string) {
  const r = await api.post('/api/v1/auth/register', { username, password })
  return r.data as { access_token: string }
}

export async function login(username: string, password: string) {
  const r = await api.post('/api/v1/auth/login', { username, password })
  return r.data as { access_token: string }
}

export async function listProjects(): Promise<Project[]> {
  const r = await api.get('/api/v1/projects')
  return r.data as Project[]
}

export async function createProject(name: string): Promise<Project> {
  const r = await api.post('/api/v1/projects', { name })
  return r.data as Project
}

export async function deleteProject(id: string): Promise<void> {
  await api.delete('/api/v1/projects/' + id)
}

export async function uploadApk(projectId: string, file: File): Promise<Job> {
  const form = new FormData()
  form.append('file', file, file.name)
  const r = await api.post('/api/v1/projects/' + projectId + '/upload', form)
  return r.data as Job
}

export async function startJob(
  projectId: string,
  action: 'decompile' | 'analyze' | 'rebuild' | 'sign',
  body: Record<string, unknown> = {},
): Promise<Job> {
  const r = await api.post('/api/v1/projects/' + projectId + '/' + action, body)
  return r.data as Job
}

export async function getJob(jobId: string): Promise<Job> {
  const r = await api.get('/api/v1/jobs/' + jobId)
  return r.data as Job
}

export async function getLogs(jobId: string): Promise<string[]> {
  const r = await api.get('/api/v1/jobs/' + jobId + '/logs')
  return (r.data as { lines: string[] }).lines
}

export async function downloadBlob(projectId: string): Promise<Blob> {
  const r = await api.get('/api/v1/projects/' + projectId + '/download', {
    responseType: 'blob',
  })
  return r.data as Blob
}

export interface SetupState {
  initialized: boolean
}

export interface SetupAdminInput {
  username: string
  password: string
  display_name?: string
  email?: string
}

export interface SetupAdminDone {
  username: string
  role: string
  access_token: string
  token_type: string
}

export async function setupStatus(): Promise<SetupState> {
  const r = await api.get('/api/v1/setup/status')
  return r.data as SetupState
}

export async function setupAdmin(
  input: SetupAdminInput,
): Promise<SetupAdminDone> {
  const r = await api.post('/api/v1/setup/admin', input)
  return r.data as SetupAdminDone
}

export function wsUrl(jobId: string, token: string): string {
  const proto = window.location.protocol === 'https:' ? 'wss' : 'ws'
  const host =
    window.location.host || window.location.hostname + ':5173'
  return (
    proto +
    '://' +
    host +
    '/api/v1/ws/jobs/' +
    jobId +
    '?token=' +
    encodeURIComponent(token)
  )
}


// ---- shared UI signals (no store imports: avoids cycles) ----

export const maintenanceMode = ref(false)
export const maintenanceMessage = ref('')
export const updateRequired = ref(false)

api.interceptors.response.use(
  (r) => {
    if (r.headers && r.headers['x-update-required'] === '1') {
      updateRequired.value = true
    } else if (r.headers && 'x-update-required' in r.headers === false) {
      // header absent: leave the flag to the updates store
    }
    return r
  },
  (e) => {
    const code = e && e.response && e.response.status
    const body = (e && e.response && e.response.data) || {}
    if (code === 503 && body.code === 'MAINTENANCE') {
      maintenanceMode.value = true
      maintenanceMessage.value = body.message || ''
    }
    if (
      e &&
      e.response &&
      e.response.headers &&
      e.response.headers['x-update-required'] === '1'
    ) {
      updateRequired.value = true
    }
    return Promise.reject(e)
  },
)

export function clearMaintenance(): void {
  maintenanceMode.value = false
  maintenanceMessage.value = ''
}

// ---- updates ----
export interface UpdateCurrent {
  version: string
  version_code: number
  channel: string
}

export interface UpdateManifest {
  latest_version: string
  version_code: number
  minimum_supported_version: string | null
  release_type: string
  channel: string
  mandatory: boolean
  security_update: boolean
  release_date: string | null
  published_at: string | null
  artifact_kind: string
  download_url: string | null
  artifact_ref: string | null
  checksum: string | null
  signature: string | null
  size_bytes: number | null
  release_notes: string[]
  breaking_changes: string[]
  security_notes: string[]
  migration_required: boolean
  restart_required: boolean
}

export type UpdateStatus =
  | 'NO_UPDATE'
  | 'UPDATE_AVAILABLE'
  | 'MANDATORY_UPDATE'

export interface CheckResult {
  status: UpdateStatus
  current_version: string
  latest_version: string | null
  channel: string
  mandatory: boolean
  security_update: boolean
  release_notes: string[]
  maintenance: { active: boolean; message: string }
}

export async function getUpdateCurrent(): Promise<UpdateCurrent> {
  const r = await api.get('/api/v1/updates/current')
  return r.data as UpdateCurrent
}

export async function checkUpdates(
  currentVersion: string,
  channel?: string,
): Promise<CheckResult> {
  const r = await api.post('/api/v1/updates/check', {
    current_version: currentVersion,
    channel,
  })
  return r.data as CheckResult
}

export async function getManifest(
  channel?: string,
  etag?: string,
): Promise<{ notModified: boolean; manifest?: UpdateManifest; etag?: string }> {
  try {
    const r = await api.get('/api/v1/updates/manifest', {
      params: channel ? { channel } : {},
      headers: etag ? { 'If-None-Match': etag } : {},
    })
    return {
      notModified: false,
      manifest: r.data as UpdateManifest,
      etag: r.headers.etag as string | undefined,
    }
  } catch (e: unknown) {
    const code =
      (e as { response?: { status?: number } }).response?.status
    if (code === 304) return { notModified: true }
    throw e
  }
}

// ---- notifications ----
export interface NotificationItem {
  id: string
  ntype: string
  title: string
  message: string
  severity: string
  created_at: string
  read: boolean
}

export interface NotificationPrefs {
  system_updates: boolean
  security_alerts: boolean
  feature_updates: boolean
  announcements: boolean
  maintenance: boolean
}

export async function listNotifications(): Promise<{
  notifications: NotificationItem[]
  unread: number
}> {
  const r = await api.get('/api/v1/notifications')
  return r.data as {
    notifications: NotificationItem[]
    unread: number
  }
}

export async function markNotification(
  id: string,
  read: boolean,
): Promise<void> {
  await api.post('/api/v1/notifications/' + id + '/read', { read })
}

export async function getPrefs(): Promise<NotificationPrefs> {
  const r = await api.get('/api/v1/notifications/prefs')
  return (r.data as { prefs: NotificationPrefs }).prefs
}

export async function setPrefs(
  prefs: Partial<NotificationPrefs>,
): Promise<NotificationPrefs> {
  const r = await api.put('/api/v1/notifications/prefs', { prefs })
  return (r.data as { prefs: NotificationPrefs }).prefs
}

export async function broadcastNotification(body: {
  ntype: string
  title: string
  message: string
  severity?: string
}): Promise<NotificationItem> {
  const r = await api.post('/api/v1/notifications/broadcast', body)
  return r.data as NotificationItem
}

export async function deleteNotification(id: string): Promise<void> {
  await api.delete('/api/v1/notifications/' + id)
}

// ---- admin: releases / maintenance / channel / backups ----
export interface Release {
  id: string
  version: string
  version_code: number
  release_type: string
  channel: string
  status: string
  minimum_supported_version: string | null
  mandatory: boolean
  security_update: boolean
  artifact_kind: string
  download_url: string | null
  artifact_ref: string | null
  size_bytes: number | null
  release_notes: string[]
  release_date: string | null
  published_at: string | null
  created_by: string
}

export async function listReleases(): Promise<Release[]> {
  const r = await api.get('/api/v1/admin/releases')
  return r.data as Release[]
}

export async function createRelease(
  body: Record<string, unknown>,
): Promise<Release> {
  const r = await api.post('/api/v1/admin/releases', body)
  return r.data as Release
}

export async function validateRelease(id: string): Promise<Release> {
  const r = await api.post('/api/v1/admin/releases/' + id + '/validate')
  return r.data as Release
}

export async function publishRelease(id: string): Promise<Release> {
  const r = await api.post('/api/v1/admin/releases/' + id + '/publish')
  return r.data as Release
}

export async function unpublishRelease(id: string): Promise<Release> {
  const r = await api.post('/api/v1/admin/releases/' + id + '/unpublish')
  return r.data as Release
}

export async function releaseHistory(): Promise<Release[]> {
  const r = await api.get('/api/v1/admin/releases/history')
  return r.data as Release[]
}

export async function getMaintenance(): Promise<{
  active: boolean
  message: string
}> {
  const r = await api.get('/api/v1/admin/maintenance')
  return r.data as { active: boolean; message: string }
}

export async function setMaintenance(
  active: boolean,
  message: string,
): Promise<{ active: boolean; message: string }> {
  const r = await api.put('/api/v1/admin/maintenance', {
    active,
    message,
  })
  return r.data as { active: boolean; message: string }
}

export async function getChannel(): Promise<{ channel: string }> {
  const r = await api.get('/api/v1/admin/channel')
  return r.data as { channel: string }
}

export async function setChannel(
  channel: string,
): Promise<{ channel: string }> {
  const r = await api.put('/api/v1/admin/channel', { channel })
  return r.data as { channel: string }
}

export interface BackupEntry {
  id: string
  created_at: string
  version_from: string
  version_to: string
  rollback_command: string
}

export async function listBackups(): Promise<BackupEntry[]> {
  const r = await api.get('/api/v1/admin/backups')
  return (r.data as { backups: BackupEntry[] }).backups
}

export interface ApplyResult {
  state: string
  run_id: string
  version_from: string
  version_to: string
  started_at: string
  log: string
}

export async function applyUpdate(
  version?: string,
): Promise<ApplyResult> {
  const r = await api.post('/api/v1/admin/updates/apply', { version })
  return r.data as ApplyResult
}

export interface LocalStatus {
  state: string
  run_id: string | null
  version_from?: string | null
  version_to?: string | null
  error?: string
  locked?: boolean
}

export async function localUpdateStatus(): Promise<LocalStatus> {
  const r = await api.get('/api/v1/admin/updates/local-status')
  return r.data as LocalStatus
}
