<template>
  <Card class="card">
    <template #title>المشاريع</template>
    <template #content>
      <div class="row">
        <InputText v-model="name" placeholder="اسم مشروع جديد" />
        <Button label="إنشاء" @click="create" />
        <Button label="تحديث" severity="secondary" @click="refresh" />
      </div>
      <p v-if="error">
        <Message severity="error" :closable="false">{{ error }}</Message>
      </p>
      <DataTable :value="projects" :loading="loading">
        <Column field="name" header="الاسم"></Column>
        <Column field="id" header="المعرف"></Column>
        <Column field="created_at" header="أُنشئ"></Column>
        <Column header="إجراءات">
          <template #body="slot">
            <Button label="فتح" link @click="open(slot.data.id)" />
            <Button label="حذف" link severity="danger" @click="remove(slot.data.id)" />
          </template>
        </Column>
      </DataTable>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import {
  createProject,
  deleteProject,
  listProjects,
  type Project,
} from '../api/client'

const emit = defineEmits<{ open: [id: string] }>()
const projects = ref<Project[]>([])
const name = ref('')
const error = ref('')
const loading = ref(false)

async function refresh(): Promise<void> {
  loading.value = true
  error.value = ''
  try {
    projects.value = await listProjects()
  } catch (e) {
    error.value = 'تعذر جلب المشاريع.'
  } finally {
    loading.value = false
  }
}

async function create(): Promise<void> {
  if (!name.value.trim()) return
  try {
    await createProject(name.value.trim())
    name.value = ''
    await refresh()
  } catch (e) {
    error.value = 'تعذر إنشاء المشروع (تحقق من الصلاحيات).'
  }
}

async function remove(id: string): Promise<void> {
  if (!window.confirm('حذف المشروع ' + id + '؟')) return
  try {
    await deleteProject(id)
    await refresh()
  } catch (e) {
    error.value = 'تعذر الحذف.'
  }
}

function open(id: string): void {
  emit('open', id)
}

onMounted(refresh)
</script>
