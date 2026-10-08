import axios from 'axios'

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
