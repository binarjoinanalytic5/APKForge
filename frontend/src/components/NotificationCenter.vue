<template>
  <span class="bell">
    <Button
      icon="pi pi-bell"
      text
      rounded
      aria-label="الإشعارات"
      @click="open = !open"
    />
    <Badge v-if="notes.unread > 0" :value="notes.unread" severity="danger" />
  </span>
  <Card v-if="open" class="panel">
    <template #title>الإشعارات</template>
    <template #content>
      <div class="row">
        <Button label="تحديث" severity="secondary" @click="notes.refresh()" />
      </div>
      <p v-if="!notes.items.length">لا توجد إشعارات.</p>
      <div v-for="n in notes.items" :key="n.id" class="note">
        <Message
          :severity="sev(n.severity)"
          :closable="false"
          :class="{ unread: !n.read }"
        >
          <strong>{{ n.title }}</strong>
          <Tag :value="n.ntype" severity="info" />
          <div>{{ n.message }}</div>
          <small>{{ n.created_at }}</small>
        </Message>
        <div class="row">
          <Button
            v-if="!n.read"
            label="تعليم كمقروء"
            link
            @click="notes.mark(n.id, true)"
          />
          <Button v-else label="تعليم كغير مقروء" link @click="notes.mark(n.id, false)" />
          <Button
            v-if="session.role === 'admin'"
            label="حذف"
            link
            severity="danger"
            @click="remove(n.id)"
          />
        </div>
      </div>
      <h4>التفضيلات</h4>
      <p><small>التنبيهات الحرجة تصل دائمًا ولا يمكن كتمها.</small></p>
      <div v-if="notes.prefs" class="prefs">
        <label>
          <Checkbox v-model="notes.prefs.system_updates" :binary="true" @change="save" />
          تحديثات النظام
        </label>
        <label>
          <Checkbox v-model="notes.prefs.security_alerts" :binary="true" @change="save" />
          تنبيهات الأمان
        </label>
        <label>
          <Checkbox v-model="notes.prefs.feature_updates" :binary="true" @change="save" />
          المزايا الجديدة
        </label>
        <label>
          <Checkbox v-model="notes.prefs.announcements" :binary="true" @change="save" />
          الإعلانات العامة
        </label>
        <label>
          <Checkbox v-model="notes.prefs.maintenance" :binary="true" @change="save" />
          تنبيهات الصيانة
        </label>
      </div>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useSession } from '../stores/session'
import { useNotifications } from '../stores/notifications'
import { deleteNotification } from '../api/client'

const session = useSession()
const notes = useNotifications()
const open = ref(false)

function sev(level: string): string {
  if (level === 'critical') return 'error'
  if (level === 'important') return 'warn'
  return 'info'
}

async function remove(id: string): Promise<void> {
  if (!window.confirm('حذف هذا الإشعار للجميع؟')) return
  await deleteNotification(id)
  await notes.refresh()
}

async function save(): Promise<void> {
  if (notes.prefs) await notes.savePrefs({ ...notes.prefs })
}
</script>

<style scoped>
.bell {
  position: relative;
  display: inline-flex;
  align-items: center;
}
.panel {
  position: absolute;
  top: 3rem;
  inset-inline-end: 1rem;
  width: min(26rem, 90vw);
  max-height: 70vh;
  overflow: auto;
  z-index: 50;
}
.note {
  margin-bottom: 0.75rem;
}
.unread {
  border-inline-start: 4px solid var(--primary-color, #3b82f6);
}
.prefs label {
  display: flex;
  gap: 0.5rem;
  align-items: center;
  margin-bottom: 0.4rem;
}
.row {
  display: flex;
  gap: 0.5rem;
  align-items: center;
  margin-bottom: 0.5rem;
  flex-wrap: wrap;
}
</style>
