<template>
  <Card class="card">
    <template #title>إعداد المسؤول الأول</template>
    <template #content>
      <p>هذه أول مرة يعمل فيها النظام — أنشئ حساب المالك:</p>
      <div class="row">
        <InputText v-model="username" placeholder="اسم المستخدم" />
        <InputText v-model="displayName" placeholder="الاسم الكامل (اختياري)" />
        <InputText v-model="email" placeholder="البريد (اختياري)" />
      </div>
      <div class="row" style="margin-top: 0.5rem">
        <Password v-model="password" placeholder="كلمة المرور (12+ حرفًا)" :feedback="false" />
        <Password v-model="confirm" placeholder="تأكيد كلمة المرور" :feedback="false" />
        <Button label="إنشاء المسؤول" @click="submit" />
      </div>
      <p v-if="error">
        <Message severity="error" :closable="false">{{ error }}</Message>
      </p>
      <p><small>لا توجد بيانات دخول افتراضية — بعد الإنشاء تُغلَق هذه الصفحة نهائيًا.</small></p>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'
import { setupAdmin } from '../api/client'

const emit = defineEmits<{ done: [token: string, username: string] }>()
const username = ref('')
const displayName = ref('')
const email = ref('')
const password = ref('')
const confirm = ref('')
const error = ref('')

async function submit(): Promise<void> {
  error.value = ''
  if (password.value !== confirm.value) {
    error.value = 'كلمتا المرور غير متطابقتين.'
    return
  }
  try {
    const data = await setupAdmin({
      username: username.value.trim(),
      password: password.value,
      display_name: displayName.value.trim() || undefined,
      email: email.value.trim() || undefined,
    })
    emit('done', data.access_token, data.username)
  } catch (e) {
    if (axios.isAxiosError(e) && e.response?.status === 403) {
      error.value = 'النظام مهيأ مسبقًا — سجّل الدخول بحسابك.'
    } else {
      error.value = 'فشل الإنشاء — تحقق من البيانات (12+ حرفًا لكلمة المرور).'
    }
  }
}
</script>
