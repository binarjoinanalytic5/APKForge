<template>
  <div class="topbar">
    <strong>APKForge</strong>
    <span>منصة هندسة APK</span>
    <span class="spacer"></span>
    <span v-if="session.username">{{ session.username }}</span>
    <Button v-if="session.token" label="خروج" link @click="quit" />
  </div>
  <div class="page">
    <LoginView v-if="!session.token" @done="goProjects" />
    <ProjectsView
      v-else-if="!projectId"
      @open="projectId = $event"
    />
    <ProjectView v-else :project-id="projectId" @back="projectId = ''" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useSession } from './stores/session'
import LoginView from './views/LoginView.vue'
import ProjectsView from './views/ProjectsView.vue'
import ProjectView from './views/ProjectView.vue'

const session = useSession()
const projectId = ref('')

function quit(): void {
  projectId.value = ''
  session.logout()
}

function goProjects(): void {
  projectId.value = ''
}
</script>
