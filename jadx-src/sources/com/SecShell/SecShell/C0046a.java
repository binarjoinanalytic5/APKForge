package com.SecShell.SecShell;

import android.os.Build;
import dalvik.system.DexFile;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ListIterator;
import java.util.zip.ZipFile;

/* JADX INFO: renamed from: com.SecShell.SecShell.a */
/* JADX INFO: loaded from: classes.dex */
public class C0046a {

    /* JADX INFO: renamed from: a */
    private static ArrayList<DexFile> f564a = new ArrayList<>();

    /* JADX INFO: renamed from: com.SecShell.SecShell.a$a */
    private static final class a {
        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: a */
        static /* synthetic */ void m189a(ClassLoader classLoader, List list, File file) throws Exception {
            try {
                int[] iArr = new int[0];
                m191b(classLoader, list, file);
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: a */
        private static Object[] m190a(Object obj, ArrayList<File> arrayList, File file) throws Exception {
            try {
                int[] iArr = new int[0];
                return (Object[]) C0046a.m177a(obj, "makeDexElements", new Class[]{ArrayList.class, File.class}).invoke(obj, arrayList, file);
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: b */
        private static void m191b(ClassLoader classLoader, List<File> list, File file) throws Exception {
            try {
                int[] iArr = new int[0];
                Object obj = C0046a.m176a((Object) classLoader, "pathList").get(classLoader);
                C0046a.m183a(obj, "dexElements", m190a(obj, (ArrayList<File>) new ArrayList(list), file));
            } catch (Exception ex1) {
                throw ex1;
            }
        }
    }

    /* JADX INFO: renamed from: com.SecShell.SecShell.a$b */
    private static final class b {
        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: a */
        static /* synthetic */ void m192a(ClassLoader classLoader, List list, File file) throws Exception {
            try {
                int[] iArr = new int[0];
                m194b(classLoader, list, file);
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: a */
        static /* synthetic */ Object[] m193a(Object obj, ArrayList arrayList, File file, ArrayList arrayList2) throws Exception {
            try {
                int[] iArr = new int[0];
                return m195b(obj, arrayList, file, arrayList2);
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: b */
        private static void m194b(ClassLoader classLoader, List<File> list, File file) throws Exception {
            IOException[] iOExceptionArr;
            try {
                int[] iArr = new int[0];
                Object obj = C0046a.m176a((Object) classLoader, "pathList").get(classLoader);
                ArrayList<IOException> arrayList = new ArrayList();
                C0046a.m184a(obj, "dexElements", m195b(obj, new ArrayList(list), file, arrayList), Build.VERSION.SDK_INT < 28);
                if (arrayList.size() > 0) {
                    for (IOException iOException : arrayList) {
                    }
                    Field fieldM176a = C0046a.m176a(obj, "dexElementsSuppressedExceptions");
                    IOException[] iOExceptionArr2 = (IOException[]) fieldM176a.get(obj);
                    if (iOExceptionArr2 == null) {
                        iOExceptionArr = (IOException[]) arrayList.toArray(new IOException[arrayList.size()]);
                    } else {
                        IOException[] iOExceptionArr3 = new IOException[arrayList.size() + iOExceptionArr2.length];
                        arrayList.toArray(iOExceptionArr3);
                        System.arraycopy(iOExceptionArr2, 0, iOExceptionArr3, arrayList.size(), iOExceptionArr2.length);
                        iOExceptionArr = iOExceptionArr3;
                    }
                    fieldM176a.set(obj, iOExceptionArr);
                }
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: b */
        private static Object[] m195b(Object obj, ArrayList<File> arrayList, File file, ArrayList<IOException> arrayList2) throws Exception {
            Method methodM177a;
            try {
                int[] iArr = new int[0];
                try {
                    methodM177a = C0046a.m177a(obj, "makeDexElements", new Class[]{ArrayList.class, File.class, ArrayList.class});
                } catch (Exception unused) {
                    methodM177a = null;
                }
                if (methodM177a == null) {
                    try {
                        methodM177a = C0046a.m177a(obj, "makePathElements", new Class[]{List.class, File.class, List.class});
                    } catch (Exception unused2) {
                    }
                }
                return (Object[]) methodM177a.invoke(obj, arrayList, file, arrayList2);
            } catch (Exception ex1) {
                throw ex1;
            }
        }
    }

    /* JADX INFO: renamed from: com.SecShell.SecShell.a$c */
    private static final class c {
        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: a */
        static /* synthetic */ void m196a(ClassLoader classLoader, List list) throws Exception {
            try {
                int[] iArr = new int[0];
                m197b(classLoader, list);
            } catch (Exception ex1) {
                throw ex1;
            }
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        /* JADX INFO: renamed from: b */
        private static void m197b(ClassLoader classLoader, List<File> list) throws Exception {
            try {
                int[] iArr = new int[0];
                int size = list.size();
                Field fieldM176a = C0046a.m176a((Object) classLoader, "path");
                StringBuilder sb = new StringBuilder((String) fieldM176a.get(classLoader));
                String[] strArr = new String[size];
                File[] fileArr = new File[size];
                ZipFile[] zipFileArr = new ZipFile[size];
                DexFile[] dexFileArr = new DexFile[size];
                ListIterator<File> listIterator = list.listIterator();
                while (listIterator.hasNext()) {
                    File next = listIterator.next();
                    String absolutePath = next.getAbsolutePath();
                    sb.append(':');
                    sb.append(absolutePath);
                    int iPreviousIndex = listIterator.previousIndex();
                    strArr[iPreviousIndex] = absolutePath;
                    fileArr[iPreviousIndex] = next;
                    zipFileArr[iPreviousIndex] = new ZipFile(next);
                    dexFileArr[iPreviousIndex] = DexFile.loadDex(absolutePath, absolutePath.replace(".jar", ".dex"), 0);
                }
                fieldM176a.set(classLoader, sb.toString());
                C0046a.m183a(classLoader, "mPaths", strArr);
                C0046a.m183a(classLoader, "mFiles", fileArr);
                C0046a.m183a(classLoader, "mZips", zipFileArr);
                C0046a.m183a(classLoader, "mDexs", dexFileArr);
            } catch (Exception ex1) {
                throw ex1;
            }
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    static /* synthetic */ Field m176a(Object obj, String str) throws Exception {
        try {
            int[] iArr = new int[0];
            return m185b(obj, str);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    static /* synthetic */ Method m177a(Object obj, String str, Class[] clsArr) throws Exception {
        try {
            int[] iArr = new int[0];
            return m186b(obj, str, (Class<?>[]) clsArr);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    private static void m178a(ClassLoader classLoader, File file, List<File> list, boolean z) throws Exception {
        try {
            int[] iArr = new int[0];
            if (list.isEmpty()) {
                return;
            }
            if (z && (Build.VERSION.RELEASE.equals("P") || Build.VERSION.SDK_INT >= 28)) {
                m179a(classLoader, list.get(0).getAbsolutePath());
                return;
            }
            int i = Build.VERSION.SDK_INT;
            if (i >= 19) {
                b.m192a(classLoader, list, file);
            } else if (i >= 14) {
                a.m189a(classLoader, list, file);
            } else {
                c.m196a(classLoader, list);
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    private static void m179a(ClassLoader classLoader, String str) throws Exception {
        IOException[] iOExceptionArr;
        try {
            int[] iArr = new int[0];
            Object obj = m185b(classLoader, "pathList").get(classLoader);
            ArrayList<IOException> arrayList = new ArrayList();
            m188b(obj, "dexElements", C0045H.m155e(obj, arrayList, str), false);
            if (arrayList.size() > 0) {
                for (IOException iOException : arrayList) {
                }
                Field fieldM185b = m185b(obj, "dexElementsSuppressedExceptions");
                IOException[] iOExceptionArr2 = (IOException[]) fieldM185b.get(obj);
                if (iOExceptionArr2 == null) {
                    iOExceptionArr = (IOException[]) arrayList.toArray(new IOException[arrayList.size()]);
                } else {
                    IOException[] iOExceptionArr3 = new IOException[arrayList.size() + iOExceptionArr2.length];
                    arrayList.toArray(iOExceptionArr3);
                    System.arraycopy(iOExceptionArr2, 0, iOExceptionArr3, arrayList.size(), iOExceptionArr2.length);
                    iOExceptionArr = iOExceptionArr3;
                }
                fieldM185b.set(obj, iOExceptionArr);
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    public static void m180a(ClassLoader classLoader, String str, String str2) {
        try {
            int[] iArr = new int[0];
            m181a(classLoader, str, str2, true);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    public static void m181a(ClassLoader classLoader, String str, String str2, boolean z) {
        try {
            int[] iArr = new int[0];
            try {
                m178a(classLoader, new File(str2), (List<File>) Arrays.asList(new File(str)), z);
            } catch (Exception unused) {
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    public static void m182a(Object obj) {
        try {
            int[] iArr = new int[0];
            try {
                ArrayList arrayList = new ArrayList();
                Field fieldM185b = m185b(obj, "dexElements");
                for (Object obj2 : (Object[]) fieldM185b.get(obj)) {
                    DexFile dexFile = (DexFile) m185b(obj2, "dexFile").get(obj2);
                    if (dexFile != null) {
                        arrayList.add(new File(dexFile.getName()));
                        f564a.add(dexFile);
                    }
                }
                fieldM185b.set(obj, b.m193a(obj, arrayList, null, new ArrayList()));
            } catch (Exception unused) {
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    static /* synthetic */ void m183a(Object obj, String str, Object[] objArr) throws Exception {
        try {
            int[] iArr = new int[0];
            m187b(obj, str, objArr);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    static /* synthetic */ void m184a(Object obj, String str, Object[] objArr, boolean z) throws Exception {
        try {
            int[] iArr = new int[0];
            m188b(obj, str, objArr, z);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 2, instructions: 2 */
    /* JADX INFO: renamed from: b */
    private static Field m185b(Object obj, String str) throws Exception {
        try {
            int[] iArr = new int[0];
            for (Class<?> superclass = obj.getClass(); superclass != null; superclass = superclass.getSuperclass()) {
                try {
                    Field declaredField = superclass.getDeclaredField(str);
                    if (!declaredField.isAccessible()) {
                        declaredField.setAccessible(true);
                    }
                    return declaredField;
                } catch (NoSuchFieldException unused) {
                }
            }
            Exception ex1 = new NoSuchFieldException("Field " + str + " not found in " + obj.getClass());
            throw ex1;
        } catch (Exception ex2) {
            throw ex2;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 2, instructions: 2 */
    /* JADX INFO: renamed from: b */
    private static Method m186b(Object obj, String str, Class<?>... clsArr) throws Exception {
        try {
            int[] iArr = new int[0];
            for (Class<?> superclass = obj.getClass(); superclass != null; superclass = superclass.getSuperclass()) {
                try {
                    Method declaredMethod = superclass.getDeclaredMethod(str, clsArr);
                    if (!declaredMethod.isAccessible()) {
                        declaredMethod.setAccessible(true);
                    }
                    return declaredMethod;
                } catch (NoSuchMethodException unused) {
                }
            }
            Exception ex1 = new NoSuchMethodException("Method " + str + " with parameters " + Arrays.asList(clsArr) + " not found in " + obj.getClass());
            throw ex1;
        } catch (Exception ex2) {
            throw ex2;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: b */
    private static void m187b(Object obj, String str, Object[] objArr) throws Exception {
        try {
            int[] iArr = new int[0];
            m188b(obj, str, objArr, true);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: b */
    private static void m188b(Object obj, String str, Object[] objArr, boolean z) throws Exception {
        try {
            int[] iArr = new int[0];
            Field fieldM185b = m185b(obj, str);
            Object[] objArr2 = (Object[]) fieldM185b.get(obj);
            Object[] objArr3 = (Object[]) Array.newInstance(objArr2.getClass().getComponentType(), objArr2.length + objArr.length);
            if (z) {
                System.arraycopy(objArr2, 0, objArr3, objArr.length, objArr2.length);
                System.arraycopy(objArr, 0, objArr3, 0, objArr.length);
            } else {
                System.arraycopy(objArr2, 0, objArr3, 0, objArr2.length);
                System.arraycopy(objArr, 0, objArr3, objArr2.length, objArr.length);
            }
            fieldM185b.set(obj, objArr3);
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
