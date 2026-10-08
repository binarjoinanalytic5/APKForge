<template>
  <div class="topbar">
    <strong>APKForge</strong>
    <span>منصة هندسة APK</span>
    <span class="spacer"></span>
    <span v-if="session.username">{{ session.username }}</span>
    <Button v-if="session.token" label="خروج" link @click="quit" />
  </div>
  <div class="page">
    <Card v-if="backendDown" class="card">
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
    <ProjectsView
      v-else-if="!projectId"
      @open="projectId = $event"
    />
    <ProjectView v-else :project-id="projectId" @back="projectId = ''" />
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useSession } from './stores/session'
import { setupStatus } from './api/client'
import LoginView from './views/LoginView.vue'
import ProjectsView from './views/ProjectsView.vue'
import ProjectView from './views/ProjectView.vue'
import SetupView from './views/SetupView.vue'

const session = useSession()
const projectId = ref('')
const initialized = ref<boolean | null>(null)
const backendDown = ref(false)

async function boot(): Promise<void> {
  backendDown.value = false
  try {
    const state = await setupStatus()
    initialized.value = state.initialized
  } catch (e) {
    backendDown.value = true
  }
}

function quit(): void {
  projectId.value = ''
  session.logout()
}

function goProjects(): void {
  projectId.value = ''
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
