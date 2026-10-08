<template>
  <Card class="card">
    <template #title>التحديثات</template>
    <template #content>
      <div class="row">
        <Button
          label="فحص الآن"
          :loading="updates.checking"
          @click="updates.fullCheck()"
        />
        <span v-if="updates.lastChecked">
          آخر فحص: {{ updates.lastChecked }}
        </span>
      </div>
      <p v-if="updates.error">
        <Message severity="error" :closable="false">
          {{ updates.error }}
        </Message>
      </p>
      <DataTable :value="rows">
        <Column field="k" header="البند"></Column>
        <Column field="v" header="القيمة"></Column>
      </DataTable>
      <p v-if="updates.mandatory">
        <Message severity="error" :closable="false">
          تحديث إلزامي متوفر — ثبّته في أقرب وقت ممكن.
        </Message>
      </p>
      <p v-else-if="updates.available">
        <Message severity="info" :closable="false">
          يوجد إصدار أحدث متاح.
        </Message>
      </p>
      <h4>ملاحظات الإصدار</h4>
      <ul v-if="notes.length">
        <li v-for="(note, i) in notes" :key="i">{{ note }}</li>
      </ul>
      <p v-else>لا توجد ملاحظات.</p>
      <div v-if="isAdmin" class="admin-apply">
        <h4>التثبيت</h4>
        <p>
          <small>
            الزر يشغّل المحرك نفسه الذي يشغّله الأمر
            <code>./apkforge update</code>
            (تنزيل قابل للاستئناف ← تحقق ← نسخ احتياطي ← تثبيت ←
            ترحيل ← إعادة تشغيل ← فحص صحة ← تراجع تلقائي عند الفشل).
          </small>
        </p>
        <div class="row">
          <Button
            label="تثبيت التحديث الآن"
            severity="danger"
            :loading="applying"
            :disabled="!canApply"
            @click="apply"
          />
          <Button
            label="تحديث الحالة"
            severity="secondary"
            @click="refreshRun"
          />
        </div>
        <p v-if="run">
          الحالة: <Tag :value="stateLabel(run.state)" :severity="stateSev(run.state)" />
          <span v-if="run.run_id"> ({{ run.run_id }})</span>
          <span v-if="run.version_from">
            {{ run.version_from }} ← {{ run.version_to }}
          </span>
        </p>
        <p v-if="run && run.error">
          <Message severity="error" :closable="false">
            {{ run.error }}
          </Message>
        </p>
        <p v-if="run && run.state === 'SUCCESS'">
          <Message severity="success" :closable="false">
            اكتمل التحديث. أعد تحميل الصفحة لرؤية الإصدار الجديد.
          </Message>
          <Button label="إعادة التحميل" @click="reload" />
        </p>
      </div>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useSession } from '../stores/session'
import { useUpdates } from '../stores/updates'
import {
  applyUpdate,
  localUpdateStatus,
  type LocalStatus,
} from '../api/client'

const session = useSession()
const updates = useUpdates()
const applying = ref(false)
const run = ref<LocalStatus | null>(null)

const isAdmin = computed(() => session.role === 'admin')

const rows = computed(() => [
  { k: 'الإصدار الحالي', v: updates.current?.version || '؟' },
  { k: 'القناة', v: updates.current?.channel || '؟' },
  { k: 'الأحدث', v: updates.manifest?.latest_version || updates.check?.latest_version || '؟' },
  { k: 'الحالة', v: statusLabel(updates.check?.status || '') },
  {
    k: 'الحجم',
    v: updates.manifest?.size_bytes
      ? Math.round((updates.manifest.size_bytes as number) / 1024) + 'KB'
      : '؟',
  },
  { k: 'التاريخ', v: updates.manifest?.release_date || '؟' },
])

const notes = computed(() => updates.manifest?.release_notes || updates.check?.release_notes || [])

const canApply = computed(
  () =>
    !applying.value &&
    (updates.check?.status === 'UPDATE_AVAILABLE' ||
      updates.check?.status === 'MANDATORY_UPDATE'),
)

function statusLabel(status: string): string {
  if (status === 'NO_UPDATE') return 'محدّث'
  if (status === 'UPDATE_AVAILABLE') return 'تحديث متاح'
  if (status === 'MANDATORY_UPDATE') return 'تحديث إلزامي'
  return 'لم يُفحص بعد'
}

const STATE_LABELS: Record<string, string> = {
  IDLE: 'خامل',
  STARTED: 'بدأ',
  CHECKED: 'تم الفحص',
  DOWNLOADING: 'جارٍ التنزيل',
  VERIFYING: 'جارٍ التحقق',
  BACKING_UP: 'جارٍ النسخ الاحتياطي',
  BACKED_UP: 'تم النسخ الاحتياطي',
  INSTALLING: 'جارٍ التثبيت',
  MIGRATING: 'جارٍ الترحيل',
  RESTARTING: 'جارٍ إعادة التشغيل',
  HEALTHY: 'سليم',
  SUCCESS: 'نجح',
  FAILED: 'فشل',
  ROLLING_BACK: 'جارٍ التراجع',
  ROLLED_BACK: 'تم التراجع',
  ROLLBACK_FAILED: 'فشل التراجع',
  NO_UPDATE: 'لا تحديث',
}

function stateLabel(state: string): string {
  return STATE_LABELS[state] || state
}

function stateSev(state: string): string {
  if (state === 'SUCCESS') return 'success'
  if (state === 'FAILED' || state === 'ROLLBACK_FAILED') return 'danger'
  if (state === 'ROLLED_BACK') return 'warning'
  return 'info'
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => window.setTimeout(resolve, ms))
}

async function refreshRun(): Promise<void> {
  try {
    run.value = await localUpdateStatus()
  } catch {
    // status endpoint is admin-only; ignore here
  }
}

async function apply(): Promise<void> {
  if (!window.confirm('تثبيت التحديث الآن؟ سيتوقف النظام مؤقتًا أثناء التثبيت.')) return
  applying.value = true
  try {
    const res = await applyUpdate()
    run.value = {
      state: res.state,
      run_id: res.run_id,
      version_from: res.version_from,
      version_to: res.version_to,
    }
    for (let i = 0; i < 120; i++) {
      await sleep(3000)
      try {
        run.value = await localUpdateStatus()
      } catch {
        // the API restarts mid-update; keep polling
        continue
      }
      if (
        run.value.state === 'SUCCESS' ||
        run.value.state === 'FAILED' ||
        run.value.state === 'ROLLED_BACK' ||
        run.value.state === 'ROLLBACK_FAILED'
      ) {
        break
      }
    }
    await updates.fullCheck()
  } catch (e) {
    updates.error = 'تعذر بدء التحديث.'
  } finally {
    applying.value = false
  }
}

function reload(): void {
  window.location.reload()
}

onMounted(async () => {
  if (!updates.current) await updates.fullCheck()
  if (isAdmin.value) await refreshRun()
})
</script>

<style scoped>
.row {
  display: flex;
  gap: 0.5rem;
  align-items: center;
  margin-bottom: 0.75rem;
  flex-wrap: wrap;
}
.admin-apply {
  margin-top: 1rem;
  border-top: 1px solid #e5e7eb;
  padding-top: 1rem;
}
</style>
