<template>
  <Card class="card">
    <template #title>{{ mode === 'login' ? 'تسجيل الدخول' : 'حساب جديد' }}</template>
    <template #content>
      <div class="row">
        <InputText v-model="username" placeholder="اسم المستخدم" />
        <Password v-model="password" placeholder="كلمة المرور (12+ حرفًا)" :feedback="false" />
        <Button :label="mode === 'login' ? 'دخول' : 'إنشاء'" @click="submit" />
      </div>
      <p v-if="error">
        <Message severity="error" :closable="false">{{ error }}</Message>
      </p>
      <p>
        <Button
          :label="mode === 'login' ? 'ليس لديك حساب؟ سجّل' : 'لديك حساب؟ ادخل'"
          link
          @click="mode = mode === 'login' ? 'register' : 'login'"
        />
      </p>
      <p><small>أول حساب يُنشَأ على الخادم يصبح مديرًا تلقائيًا.</small></p>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { login as apiLogin, register as apiRegister } from '../api/client'
import { useSession } from '../stores/session'

const emit = defineEmits<{ done: [] }>()
const session = useSession()
const mode = ref<'login' | 'register'>('login')
const username = ref('')
const password = ref('')
const error = ref('')

async function submit(): Promise<void> {
  error.value = ''
  try {
    const fn = mode.value === 'login' ? apiLogin : apiRegister
    const data = await fn(username.value.trim(), password.value)
    session.login(data.access_token, username.value.trim())
    emit('done')
  } catch (e) {
    error.value = 'فشل الدخول — تحقق من البيانات والخادم.'
  }
}
</script>
