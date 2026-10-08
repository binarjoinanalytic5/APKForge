import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import {
  checkUpdates,
  getManifest,
  getUpdateCurrent,
  updateRequired,
  type CheckResult,
  type UpdateCurrent,
  type UpdateManifest,
} from '../api/client'

const CACHE_KEY = 'apkforge-update-cache'
const AUTO_EVERY_MS = 30 * 60 * 1000

interface CacheShape {
  etag: string
  manifest: UpdateManifest | null
  checked_at: string
}

function loadCache(): CacheShape | null {
  try {
    const raw = localStorage.getItem(CACHE_KEY)
    if (!raw) return null
    return JSON.parse(raw) as CacheShape
  } catch {
    return null
  }
}

export const useUpdates = defineStore('updates', () => {
  const current = ref<UpdateCurrent | null>(null)
  const manifest = ref<UpdateManifest | null>(
    loadCache()?.manifest || null,
  )
  const check = ref<CheckResult | null>(null)
  const lastChecked = ref(loadCache()?.checked_at || '')
  const checking = ref(false)
  const error = ref('')
  let timer: number | null = null

  const mandatory = computed(
    () =>
      updateRequired.value ||
      check.value?.status === 'MANDATORY_UPDATE',
  )
  const available = computed(
    () => check.value?.status === 'UPDATE_AVAILABLE',
  )

  async function refreshCurrent(): Promise<void> {
    current.value = await getUpdateCurrent()
  }

  async function fullCheck(): Promise<void> {
    checking.value = true
    error.value = ''
    try {
      await refreshCurrent()
      const version = current.value?.version || ''
      const channel = current.value?.channel || 'STABLE'
      check.value = await checkUpdates(version, channel)
      const data = await getManifest(channel)
      if (!data.notModified && data.manifest) {
        manifest.value = data.manifest
        saveCache(data.etag || '', data.manifest)
      }
      lastChecked.value = new Date().toISOString()
      touchCache()
    } catch (e) {
      error.value = 'تعذر فحص التحديثات.'
    } finally {
      checking.value = false
    }
  }

  async function cachedCheck(): Promise<void> {
    // Used by the auto-check timer: honors ETag/304 so an
    // unchanged server costs almost nothing.
    const cached = loadCache()
    try {
      await refreshCurrent()
      const channel = current.value?.channel || 'STABLE'
      const data = await getManifest(channel, cached?.etag)
      lastChecked.value = new Date().toISOString()
      if (data.notModified) {
        touchCache()
        return
      }
      if (data.manifest) {
        manifest.value = data.manifest
        saveCache(data.etag || '', data.manifest)
        check.value = await checkUpdates(
          current.value?.version || '',
          channel,
        )
      }
    } catch {
      // auto-check never interrupts the user; manual check shows errors
    }
  }

  function saveCache(etag: string, data: UpdateManifest): void {
    const shape: CacheShape = {
      etag,
      manifest: data,
      checked_at: lastChecked.value,
    }
    try {
      localStorage.setItem(CACHE_KEY, JSON.stringify(shape))
    } catch {
      // storage full/blocked: caching is best-effort
    }
  }

  function touchCache(): void {
    const cached = loadCache()
    if (!cached) return
    cached.checked_at = lastChecked.value
    try {
      localStorage.setItem(CACHE_KEY, JSON.stringify(cached))
    } catch {
      // best-effort
    }
  }

  function startAutoCheck(): void {
    cachedCheck()
    if (timer !== null) return
    timer = window.setInterval(cachedCheck, AUTO_EVERY_MS)
  }

  return {
    current,
    manifest,
    check,
    lastChecked,
    checking,
    error,
    mandatory,
    available,
    refreshCurrent,
    fullCheck,
    cachedCheck,
    startAutoCheck,
  }
})
