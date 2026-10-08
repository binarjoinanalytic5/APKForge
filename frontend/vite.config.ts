import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// Phase 1: dev proxies API + WS to the local backend; production
// serves the built SPA from the same origin as the API.
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 5173,
    proxy: {
      '/api': 'http://127.0.0.1:8000',
    },
  },
})
