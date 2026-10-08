import { defineStore } from 'pinia'
import { ref } from 'vue'
import {
  getPrefs,
  listNotifications,
  markNotification,
  setPrefs,
  type NotificationItem,
  type NotificationPrefs,
} from '../api/client'

const POLL_EVERY_MS = 60 * 1000

export const useNotifications = defineStore('notifications', () => {
  const items = ref<NotificationItem[]>([])
  const unread = ref(0)
  const prefs = ref<NotificationPrefs | null>(null)
  const loading = ref(false)
  let timer: number | null = null

  async function refresh(): Promise<void> {
    loading.value = true
    try {
      const data = await listNotifications()
      items.value = data.notifications
      unread.value = data.unread
      prefs.value = await getPrefs()
    } finally {
      loading.value = false
    }
  }

  async function mark(id: string, read: boolean): Promise<void> {
    await markNotification(id, read)
    const found = items.value.find((n) => n.id === id)
    if (found) found.read = read
    unread.value = items.value.filter((n) => !n.read).length
  }

  async function savePrefs(
    patch: Partial<NotificationPrefs>,
  ): Promise<void> {
    prefs.value = await setPrefs(patch)
    await refresh()
  }

  function startPolling(): void {
    refresh()
    if (timer !== null) return
    timer = window.setInterval(() => {
      listNotifications()
        .then((data) => {
          items.value = data.notifications
          unread.value = data.unread
        })
        .catch(() => {
          // polling is silent; manual refresh shows errors
        })
    }, POLL_EVERY_MS)
  }

  return { items, unread, prefs, loading, refresh, mark, savePrefs, startPolling }
})
