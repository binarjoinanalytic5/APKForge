<template>
  <Button label="→ عودة للمشاريع" link @click="emit('back')" />
  <Card class="card">
    <template #title>المشروع {{ projectId }}</template>
    <template #content>
      <div class="row">
        <input type="file" accept=".apk" @change="pick" />
        <Button label="رفع APK" :disabled="!picked" @click="upload" />
        <Dropdown v-model="tool" :options="tools" placeholder="الأداة" />
        <Button label="فك التجميع" severity="secondary" @click="start('decompile')" />
      </div>
      <div class="row" style="margin-top: 0.5rem">
        <Button label="تحليل" severity="secondary" @click="start('analyze')" />
        <Button label="إعادة بناء" severity="secondary" @click="start('rebuild')" />
        <Button label="توقيع" severity="secondary" @click="start('sign')" />
        <Button label="تنزيل النتيجة" @click="download" />
      </div>
      <p v-if="notice">
        <Message severity="info" :closable="false">{{ notice }}</Message>
      </p>
      <p v-if="error">
        <Message severity="error" :closable="false">{{ error }}</Message>
      </p>
    </template>
  </Card>
  <Card v-if="job" class="card">
    <template #title>المهمة {{ job.job_id }} — {{ job.status }}</template>
    <template #content>
      <ProgressBar v-if="active" mode="indeterminate" />
      <p v-if="job.error"><small>{{ job.error }}</small></p>
      <div class="logs">{{ logText }}</div>
      <div class="row" style="margin-top: 0.5rem">
        <Button label="تحديث الحالة" severity="secondary" @click="poll" />
      </div>
    </template>
  </Card>
  <Card class="card">
    <template #title>حالات المهام</template>
    <template #content>
      <div ref="chartEl" style="height: 220px"></div>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from 'vue'
import * as echarts from 'echarts'
import {
  downloadBlob,
  getJob,
  getLogs,
  startJob,
  uploadApk,
  wsUrl,
  type Job,
} from '../api/client'
import { useSession } from '../stores/session'

const props = defineProps<{ projectId: string }>()
const emit = defineEmits<{ back: [] }>()
const session = useSession()

const picked = ref<File | null>(null)
const tool = ref('apktool')
const tools = ['apktool', 'jadx']
const job = ref<Job | null>(null)
const lines = ref<string[]>([])
const notice = ref('')
const error = ref('')
const chartEl = ref<HTMLDivElement | null>(null)
let chart: echarts.ECharts | null = null
let socket: WebSocket | null = null
const counts = ref<Record<string, number>>({})

const active = computed(
  () => !!job.value && ['queued', 'running'].includes(job.value.status),
)
const logText = computed(() =>
  lines.value.length ? lines.value.join('\n') : '(لا سجلات بعد)',
)

function pick(e: Event): void {
  const input = e.target as HTMLInputElement
  picked.value = input.files && input.files[0] ? input.files[0] : null
}

function fail(message: string): void {
  error.value = message
  notice.value = ''
}

async function upload(): Promise<void> {
  if (!picked.value) return
  error.value = ''
  try {
    const j = await uploadApk(props.projectId, picked.value)
    notice.value = 'رُفع الملف (مهمة ' + j.job_id + ').'
    track(j)
  } catch (e) {
    fail('فشل الرفع.')
  }
}

async function start(
  action: 'decompile' | 'analyze' | 'rebuild' | 'sign',
): Promise<void> {
  error.value = ''
  try {
    const body = action === 'decompile' ? { tool: tool.value } : {}
    const j = await startJob(props.projectId, action, body)
    notice.value = 'بدأت المهمة ' + j.job_id + '.'
    track(j)
    watch(j.job_id)
  } catch (e) {
    fail('فشل بدء المهمة.')
  }
}

function track(j: Job): void {
  job.value = j
  counts.value[j.status] = (counts.value[j.status] || 0) + 1
  draw()
}

async function poll(): Promise<void> {
  if (!job.value) return
  try {
    const j = await getJob(job.value.job_id)
    job.value = j
    lines.value = await getLogs(j.job_id)
  } catch (e) {
    fail('تعذر جلب الحالة.')
  }
}

async function download(): Promise<void> {
  try {
    const blob = await downloadBlob(props.projectId)
    const a = document.createElement('a')
    a.href = URL.createObjectURL(blob)
    a.download = props.projectId + '-result'
    a.click()
    URL.revokeObjectURL(a.href)
  } catch (e) {
    fail('لا نتيجة قابلة للتنزيل بعد.')
  }
}

function watch(jobId: string): void {
  closeSocket()
  try {
    socket = new WebSocket(wsUrl(jobId, session.token))
  } catch (e) {
    return
  }
  socket.onmessage = (e: MessageEvent) => {
    const frame = JSON.parse(String(e.data)) as {
      type: string
      line?: string
      status?: string
    }
    if (frame.type === 'log' && frame.line) {
      lines.value.push(frame.line)
    } else if (
      (frame.type === 'status' || frame.type === 'bye') &&
      frame.status &&
      job.value
    ) {
      job.value.status = frame.status
      if (frame.type === 'bye') closeSocket()
    }
  }
}

function closeSocket(): void {
  if (socket) {
    try {
      socket.close()
    } catch (e) {
      /* already closed */
    }
    socket = null
  }
}

function draw(): void {
  if (!chartEl.value) return
  if (!chart) chart = echarts.init(chartEl.value)
  const keys = Object.keys(counts.value)
  chart.setOption({
    xAxis: { type: 'category', data: keys.length ? keys : ['—'] },
    yAxis: { type: 'value' },
    series: [
      {
        type: 'bar',
        data: keys.length ? keys.map((k) => counts.value[k]) : [0],
      },
    ],
  })
}

onMounted(draw)
onUnmounted(closeSocket)
</script>
