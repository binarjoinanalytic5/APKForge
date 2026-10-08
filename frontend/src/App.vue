<template>
  <div class="topbar">
    <strong>APKForge</strong>
    <span>منصة هندسة APK</span>
    <span v-if="session.token" class="nav">
      <Button label="المشاريع" link @click="go('projects')" />
      <Button label="التحديثات" link @click="go('updates')" />
      <Button
        v-if="session.role === 'admin'"
        label="إدارة التحديثات"
        link
        @click="go('admin')"
      />
    </span>
    <span class="spacer"></span>
    <NotificationCenter v-if="session.token" />
    <span v-if="session.username">{{ session.username }}</span>
    <Button v-if="session.token" label="خروج" link @click="quit" />
  </div>
  <div v-if="session.token && updates.mandatory" class="banner">
    <Message severity="error" :closable="false">
      تحديث إلزامي متوفر —
      <Button label="انتقال إلى التحديثات" link @click="go('updates')" />
    </Message>
  </div>
  <div class="page">
    <Card v-if="maintenanceMode" class="card">
      <template #title>النظام في وضع الصيانة</template>
      <template #content>
        <p>{{ maintenanceMessage || 'جارٍ إجراء صيانة. حاول لاحقًا.' }}</p>
        <Button label="إعادة المحاولة" @click="retry" />
      </template>
    </Card>
    <Card v-else-if="backendDown" class="card">
      <template #title>الخادم لا يستجيب</template>
      <template #content>
        <p>تعذر الوصول إلى الواجهة الخلفية. تأكد من تشغيلها ثم:</p>
        <Button label="إعادة المحاولة" @click="boot" />
      </template>
    </Card>
    <Card v-else-if="initialized === null" class="card">
      <template #content><p>جارٍ فحص حالة النظام…</p></template>
    </Card>
    <SetupView v-else-if="!initialized" @done="onSetupDone" />
    <LoginView v-else-if="!session.token" @done="goProjects" />
    <template v-else-if="view === 'projects'">
      <ProjectsView v-if="!projectId" @open="projectId = $event" />
      <ProjectView v-else :project-id="projectId" @back="projectId = ''" />
    </template>
    <UpdatesView v-else-if="view === 'updates'" />
    <AdminUpdatesView
      v-else-if="view === 'admin' && session.role === 'admin'"
    />
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useSession } from './stores/session'
import { useUpdates } from './stores/updates'
import { useNotifications } from './stores/notifications'
import {
  clearMaintenance,
  maintenanceMessage,
  maintenanceMode,
  setupStatus,
} from './api/client'
import LoginView from './views/LoginView.vue'
import ProjectsView from './views/ProjectsView.vue'
import ProjectView from './views/ProjectView.vue'
import SetupView from './views/SetupView.vue'
import UpdatesView from './views/UpdatesView.vue'
import AdminUpdatesView from './views/AdminUpdatesView.vue'
import NotificationCenter from './components/NotificationCenter.vue'

const session = useSession()
const updates = useUpdates()
const notes = useNotifications()
const projectId = ref('')
const view = ref<'projects' | 'updates' | 'admin'>('projects')
const initialized = ref<boolean | null>(null)
const backendDown = ref(false)

async function boot(): Promise<void> {
  backendDown.value = false
  try {
    const state = await setupStatus()
    initialized.value = state.initialized
    if (state.initialized && session.token) startLive()
  } catch (e) {
    backendDown.value = true
  }
}

function startLive(): void {
  updates.startAutoCheck()
  notes.startPolling()
}

function retry(): void {
  clearMaintenance()
  boot()
}

function quit(): void {
  projectId.value = ''
  view.value = 'projects'
  session.logout()
}

function go(target: 'projects' | 'updates' | 'admin'): void {
  projectId.value = ''
  view.value = target
}

function goProjects(): void {
  projectId.value = ''
  view.value = 'projects'
  startLive()
}

function onSetupDone(token: string, username: string): void {
  session.login(token, username)
  initialized.value = true
  if (window.location.hash === '#/admin/setup') {
    window.location.hash = ''
  }
  goProjects()
}

onMounted(boot)
</script>

<style scoped>
.nav {
  display: inline-flex;
  gap: 0.25rem;
  margin-inline-start: 1rem;
}
.banner {
  padding: 0.5rem 1rem 0 1rem;
}
</style>
