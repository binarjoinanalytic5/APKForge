<template>
  <Card class="card">
    <template #title>إدارة الإصدارات والتحديثات</template>
    <template #content>
      <p v-if="error">
        <Message severity="error" :closable="false">{{ error }}</Message>
      </p>
      <p v-if="notice">
        <Message severity="success" :closable="false">{{ notice }}</Message>
      </p>

      <h4>الإصدارات</h4>
      <div class="row">
        <Button label="تحديث" severity="secondary" @click="refresh" />
        <Button
          :label="showForm ? 'إخفاء النموذج' : 'إصدار جديد'"
          @click="showForm = !showForm"
        />
      </div>
      <div v-if="showForm" class="form">
        <div class="row">
          <InputText v-model="form.version" placeholder="الإصدار (1.2.0)" />
          <Dropdown
            v-model="form.release_type"
            :options="['MAJOR', 'MINOR', 'PATCH', 'HOTFIX']"
            placeholder="النوع"
          />
          <Dropdown
            v-model="form.channel"
            :options="['STABLE', 'BETA', 'DEV']"
            placeholder="القناة"
          />
          <InputText v-model="form.minimum_supported_version" placeholder="أدنى نسخة مدعومة" />
        </div>
        <div class="row">
          <Dropdown
            v-model="form.artifact_kind"
            :options="['bundle', 'git']"
            placeholder="نوع الحزمة"
          />
          <InputText
            v-if="form.artifact_kind === 'bundle'"
            v-model="form.download_url"
            placeholder="رابط التنزيل (https/file)"
            class="wide"
          />
          <InputText
            v-else
            v-model="form.artifact_ref"
            placeholder="مرجع git (sha/tag)"
            class="wide"
          />
        </div>
        <div v-if="form.artifact_kind === 'bundle'" class="row">
          <InputText v-model="form.checksum" placeholder="sha256" class="wide" />
          <InputText v-model="form.signature" placeholder="التوقيع (hmac)" class="wide" />
          <InputText v-model="form.size_bytes" placeholder="الحجم بالبايت" />
        </div>
        <div class="row">
          <label><Checkbox v-model="form.mandatory" :binary="true" /> إلزامي</label>
          <label><Checkbox v-model="form.security_update" :binary="true" /> أمني</label>
          <label><Checkbox v-model="form.migration_required" :binary="true" /> يحتاج ترحيلًا</label>
          <label><Checkbox v-model="form.restart_required" :binary="true" /> يحتاج إعادة تشغيل</label>
        </div>
        <div class="row">
          <Textarea
            v-model="form.release_notes"
            placeholder="ملاحظات الإصدار (سطر لكل ملاحظة)"
            rows="3"
            class="wide"
          />
        </div>
        <div class="row">
          <Button label="إنشاء كمسودة" @click="create" />
        </div>
      </div>
      <DataTable :value="releases" :loading="loading">
        <Column field="version" header="الإصدار"></Column>
        <Column field="channel" header="القناة"></Column>
        <Column field="release_type" header="النوع"></Column>
        <Column field="status" header="الحالة"></Column>
        <Column header="إجراءات">
          <template #body="slot">
            <Button
              v-if="slot.data.status === 'draft'"
              label="اعتماد"
              link
              @click="act(slot.data.id, 'validate')"
            />
            <Button
              v-if="slot.data.status === 'validated'"
              label="نشر"
              link
              @click="act(slot.data.id, 'publish')"
            />
            <Button
              v-if="slot.data.status === 'published'"
              label="سحب"
              link
              severity="danger"
              @click="act(slot.data.id, 'unpublish')"
            />
          </template>
        </Column>
      </DataTable>

      <h4>وضع الصيانة</h4>
      <div class="row">
        <label>
          <Checkbox v-model="maint.active" :binary="true" /> مفعّل
        </label>
        <InputText v-model="maint.message" placeholder="رسالة الصيانة" class="wide" />
        <Button label="حفظ" @click="saveMaint" />
      </div>

      <h4>القناة</h4>
      <div class="row">
        <Dropdown v-model="channel" :options="['STABLE', 'BETA', 'DEV']" />
        <Button label="حفظ القناة" @click="saveChannel" />
      </div>

      <h4>النسخ الاحتياطية</h4>
      <DataTable :value="backups">
        <Column field="id" header="المعرف"></Column>
        <Column field="version_from" header="من"></Column>
        <Column field="version_to" header="إلى"></Column>
        <Column field="created_at" header="أُنشئت"></Column>
        <Column field="rollback_command" header="أمر التراجع"></Column>
      </DataTable>

      <h4>بث إشعار</h4>
      <div class="row">
        <Dropdown v-model="cast.ntype" :options="NTYPES" placeholder="النوع" />
        <Dropdown v-model="cast.severity" :options="['info', 'important', 'critical']" />
        <InputText v-model="cast.title" placeholder="العنوان" class="wide" />
      </div>
      <div class="row">
        <Textarea v-model="cast.message" placeholder="النص" rows="2" class="wide" />
        <Button label="بث للجميع" @click="broadcast" />
      </div>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import {
  broadcastNotification,
  createRelease,
  getChannel,
  getMaintenance,
  listBackups,
  listReleases,
  publishRelease,
  setChannel,
  setMaintenance,
  unpublishRelease,
  validateRelease,
  type BackupEntry,
  type Release,
} from '../api/client'

const NTYPES = [
  'SYSTEM_ANNOUNCEMENT',
  'MAINTENANCE',
  'UPDATE_AVAILABLE',
  'MANDATORY_UPDATE',
  'SECURITY_UPDATE',
  'FEATURE_RELEASE',
]

const releases = ref<Release[]>([])
const backups = ref<BackupEntry[]>([])
const loading = ref(false)
const error = ref('')
const notice = ref('')
const showForm = ref(false)
const channel = ref('STABLE')
const maint = ref({ active: false, message: '' })
const form = ref({
  version: '',
  release_type: 'MINOR',
  channel: 'STABLE',
  minimum_supported_version: '',
  artifact_kind: 'bundle',
  download_url: '',
  artifact_ref: '',
  checksum: '',
  signature: '',
  size_bytes: '',
  mandatory: false,
  security_update: false,
  migration_required: false,
  restart_required: true,
  release_notes: '',
})
const cast = ref({
  ntype: 'SYSTEM_ANNOUNCEMENT',
  severity: 'info',
  title: '',
  message: '',
})

function fail(message: string): void {
  error.value = message
  notice.value = ''
}

function ok(message: string): void {
  notice.value = message
  error.value = ''
}

async function refresh(): Promise<void> {
  loading.value = true
  try {
    releases.value = await listReleases()
    backups.value = await listBackups()
    maint.value = await getMaintenance()
    channel.value = (await getChannel()).channel
  } catch {
    fail('تعذر جلب بيانات الإدارة.')
  } finally {
    loading.value = false
  }
}

async function create(): Promise<void> {
  const body: Record<string, unknown> = {
    version: form.value.version.trim(),
    release_type: form.value.release_type,
    channel: form.value.channel,
    artifact_kind: form.value.artifact_kind,
    mandatory: form.value.mandatory,
    security_update: form.value.security_update,
    migration_required: form.value.migration_required,
    restart_required: form.value.restart_required,
    release_notes: form.value.release_notes
      .split('\n')
      .map((l) => l.trim())
      .filter(Boolean),
  }
  if (form.value.minimum_supported_version.trim()) {
    body.minimum_supported_version = form.value.minimum_supported_version.trim()
  }
  if (form.value.artifact_kind === 'bundle') {
    body.download_url = form.value.download_url.trim()
    if (form.value.checksum.trim()) body.checksum = form.value.checksum.trim()
    if (form.value.signature.trim()) body.signature = form.value.signature.trim()
    if (form.value.size_bytes.trim()) {
      body.size_bytes = parseInt(form.value.size_bytes.trim(), 10)
    }
  } else {
    body.artifact_ref = form.value.artifact_ref.trim()
  }
  try {
    await createRelease(body)
    ok('أُنشئ الإصدار كمسودة.')
    form.value.version = ''
    await refresh()
  } catch {
    fail('تعذر إنشاء الإصدار (تحقق من الحقول).')
  }
}

async function act(id: string, op: 'validate' | 'publish' | 'unpublish'): Promise<void> {
  try {
    if (op === 'validate') await validateRelease(id)
    if (op === 'publish') {
      if (!window.confirm('نشر هذا الإصدار للجميع؟')) return
      await publishRelease(id)
    }
    if (op === 'unpublish') {
      if (!window.confirm('سحب هذا الإصدار؟')) return
      await unpublishRelease(id)
    }
    ok('تمت العملية بنجاح.')
    await refresh()
  } catch {
    fail('تعذرت العملية (قد تكون الحالة غير صالحة).')
  }
}

async function saveMaint(): Promise<void> {
  try {
    maint.value = await setMaintenance(maint.value.active, maint.value.message)
    ok('حُفظ وضع الصيانة.')
  } catch {
    fail('تعذر حفظ وضع الصيانة.')
  }
}

async function saveChannel(): Promise<void> {
  try {
    channel.value = (await setChannel(channel.value)).channel
    ok('حُفظت القناة.')
  } catch {
    fail('تعذر حفظ القناة.')
  }
}

async function broadcast(): Promise<void> {
  if (!cast.value.title.trim() || !cast.value.message.trim()) {
    fail('العنوان والنص مطلوبان للبث.')
    return
  }
  try {
    await broadcastNotification({
      ntype: cast.value.ntype,
      title: cast.value.title.trim(),
      message: cast.value.message.trim(),
      severity: cast.value.severity,
    })
    ok('تم البث للجميع.')
    cast.value.title = ''
    cast.value.message = ''
  } catch {
    fail('تعذر البث.')
  }
}

onMounted(refresh)
</script>

<style scoped>
.row {
  display: flex;
  gap: 0.5rem;
  align-items: center;
  margin-bottom: 0.75rem;
  flex-wrap: wrap;
}
.form {
  border: 1px solid #e5e7eb;
  border-radius: 0.5rem;
  padding: 0.75rem;
  margin-bottom: 0.75rem;
}
.wide {
  flex: 1 1 16rem;
}
label {
  display: inline-flex;
  gap: 0.4rem;
  align-items: center;
}
</style>
