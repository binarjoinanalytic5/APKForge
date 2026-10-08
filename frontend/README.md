# الواجهة (Vue 3 + TypeScript + Vite — المرحلة 1)

عربية RTL كاملة منذ اليوم الأول: دخول/تسجيل، مشاريع، رفع APK، بدء
المهام (Apktool/JADX)، سجل حي عبر WebSocket (بروتوكول `websocket.md`)،
تنزيل النتائج، ومخطط حالات (ECharts).

```sh
cd frontend
npm ci
npm run dev      # http://localhost:5173 (وكيل /api ← :8000)
npm run build    # فحص أنواع + بناء إنتاجي
```

البنية: `src/api/client.ts` (عميل REST) و`src/stores/session.ts`
(الرمز) و`src/views/` (الدخول/المشاريع/المشروع) — تنقل داخلي بلا
موجه في المرحلة 1.
