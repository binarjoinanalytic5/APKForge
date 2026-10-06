package com.SecShell.SecShell;

import dalvik.system.PathClassLoader;

/* JADX INFO: renamed from: com.SecShell.SecShell.c */
/* JADX INFO: loaded from: classes.dex */
class C0048c extends PathClassLoader {

    /* JADX INFO: renamed from: a */
    private final ClassLoader f565a;

    public C0048c(String str, ClassLoader classLoader) {
        super(str, classLoader.getParent());
        this.f565a = classLoader;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // dalvik.system.BaseDexClassLoader, java.lang.ClassLoader
    public Class<?> findClass(String str) throws Exception {
        try {
            int[] iArr = new int[0];
            return ((str == null || !str.equals(C0045H.class.getName())) && (str == null || !str.equals(H1.class.getName()))) ? super.findClass(str) : this.f565a.loadClass(str);
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
