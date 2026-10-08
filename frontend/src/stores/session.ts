import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import { setToken } from '../api/client'

export const useSession = defineStore('session', () => {
  const token = ref(localStorage.getItem('apkforge-token') || '')
  const username = ref(localStorage.getItem('apkforge-user') || '')

  function login(t: string, u: string): void {
    token.value = t
    username.value = u
    localStorage.setItem('apkforge-token', t)
    localStorage.setItem('apkforge-user', u)
    setToken(t)
  }

  function logout(): void {
    token.value = ''
    username.value = ''
    localStorage.removeItem('apkforge-token')
    localStorage.removeItem('apkforge-user')
    setToken('')
  }

  const role = computed(() => {
    try {
      const payload = token.value.split('.')[1]
      const body = JSON.parse(window.atob(payload))
      return (body.role as string) || 'viewer'
    } catch {
      return 'viewer'
    }
  })

  setToken(token.value)
  return { token, username, role, login, logout }
})
