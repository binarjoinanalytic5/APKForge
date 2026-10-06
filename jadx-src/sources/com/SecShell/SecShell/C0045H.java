package com.SecShell.SecShell;

import android.app.Application;
import android.content.Context;
import android.content.ServiceConnection;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

/* JADX INFO: renamed from: com.SecShell.SecShell.H */
/* JADX INFO: loaded from: classes.dex */
public class C0045H {
    public static String ACFNAME = "androidx.core.app.CoreComponentFactory";
    public static String APPNAME = "com.coocoo.CooCooAppShell";
    public static String HAVEX86 = "###HAVEX86###";
    public static String ISMPAAS = "###MPAAS###";
    public static String PKGNAME = "com.newleaf.app.android.victor";

    /* JADX INFO: renamed from: cl */
    public static ClassLoader f563cl;
    private static final Messenger mMessenger = new Messenger(new a());
    private static Messenger mService = null;
    private static ServiceConnection sConnection = new ServiceConnectionC0047b();

    /* JADX INFO: renamed from: com.SecShell.SecShell.H$a */
    static class a extends Handler {
        a() {
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        @Override // android.os.Handler
        public void handleMessage(Message message) throws Exception {
            try {
                int[] iArr = new int[0];
                if (message.what != 1000) {
                    super.handleMessage(message);
                } else {
                    C0045H.m174p();
                }
            } catch (Exception ex1) {
                throw ex1;
            }
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    static /* synthetic */ Messenger access$000() throws Exception {
        try {
            int[] iArr = new int[0];
            return mService;
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    static /* synthetic */ Messenger access$002(Messenger messenger) throws Exception {
        try {
            int[] iArr = new int[0];
            mService = messenger;
            return messenger;
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    static /* synthetic */ Messenger access$100() throws Exception {
        try {
            int[] iArr = new int[0];
            return mMessenger;
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    public static native void attach(Application application, Context context);

    /* JADX INFO: renamed from: b */
    public static native void m151b(Context context, Application application);

    /* JADX INFO: renamed from: bb */
    public static native void m152bb(Context context, Application application, Application application2);

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static int bytes2int(byte[] bArr) throws Exception {
        try {
            int[] iArr = new int[0];
            return bArr[3] | ((((((0 | bArr[0]) << 8) | bArr[1]) << 8) | bArr[2]) << 8);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: c */
    public static native void m153c();

    /* JADX INFO: renamed from: d */
    public static native String m154d(String str);

    /* JADX INFO: renamed from: e */
    public static native Object[] m155e(Object obj, List<IOException> list, String str);

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: f */
    public static void m156f(ClassLoader classLoader, String str, String str2) throws Exception {
        try {
            int[] iArr = new int[0];
            C0046a.m180a(classLoader, str, str2);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: f */
    public static final native String[] m157f();

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: ff */
    public static void m158ff(ClassLoader classLoader, String str, String str2) throws Exception {
        try {
            int[] iArr = new int[0];
            C0046a.m181a(classLoader, str, str2, false);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: g */
    public static void m159g(Object obj) throws Exception {
        try {
            int[] iArr = new int[0];
            C0046a.m182a(obj);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: g */
    public static final native String[] m160g();

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: h */
    public static Object m161h(ClassLoader classLoader) throws Exception {
        try {
            int[] iArr = new int[0];
            return new C0048c(":", classLoader);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: h */
    public static final native String[] m162h();

    /* JADX INFO: renamed from: i */
    public static native void m163i();

    /* JADX WARN: Code duplicated, block: B:50:0x006e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static boolean is_x86_byso() throws Exception {
        Exception ex1;
        FileInputStream fileInputStream;
        Exception ex2;
        try {
            int[] iArr = new int[0];
            if (HAVEX86.equalsIgnoreCase("true")) {
                return false;
            }
            FileInputStream fileInputStream2 = null;
            byte[] bArr = new byte[20];
            try {
                try {
                    fileInputStream = new FileInputStream("/system/lib/libc.so");
                    try {
                        fileInputStream.read(bArr);
                        int iBytes2int = bytes2int(new byte[]{0, 0, bArr[19], bArr[18]});
                        boolean z = iBytes2int == 3 || iBytes2int == 6 || iBytes2int == 7;
                        try {
                            fileInputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        return z;
                    } catch (Exception e2) {
                        ex2 = e2;
                        ex2.printStackTrace();
                        if (fileInputStream != null) {
                            try {
                                fileInputStream.close();
                            } catch (IOException e3) {
                                e3.printStackTrace();
                            }
                        }
                        return false;
                    }
                } catch (Throwable th) {
                    ex1 = th;
                    if (0 != 0) {
                        try {
                            fileInputStream2.close();
                        } catch (IOException e4) {
                            e4.printStackTrace();
                        }
                    }
                    throw ex1;
                }
            } catch (Exception e5) {
                fileInputStream = null;
                ex2 = e5;
            } catch (Throwable th2) {
                ex1 = th2;
                if (0 != 0) {
                    fileInputStream2.close();
                }
                throw ex1;
            }
        } catch (Exception ex3) {
            throw ex3;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: j */
    public static boolean m164j(Context context) throws Exception {
        try {
            int[] iArr = new int[0];
            return new com.SecShell.SecShell.r.b(context).h();
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: j */
    public static final native String[] m165j();

    /* JADX INFO: renamed from: k */
    public static final native String m166k();

    /* JADX INFO: renamed from: l */
    public static final native String m167l();

    /* JADX INFO: renamed from: m */
    public static final native String m168m();

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: m */
    public static String[] m169m(String[] strArr, String str) throws Exception {
        try {
            int[] iArr = new int[0];
            String[] strArr2 = new String[(strArr != null ? strArr.length : 0) + 1];
            if (strArr == null) {
                strArr2[0] = str;
            } else {
                System.arraycopy(strArr, 0, strArr2, 0, strArr.length);
                strArr2[strArr2.length - 1] = str;
            }
            return strArr2;
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: mu */
    public static final native int m170mu();

    /* JADX INFO: renamed from: n */
    public static final native String[] m171n();

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: ns */
    public static void m172ns(String str) throws Exception {
        try {
            int[] iArr = new int[0];
            try {
                Class<?> cls = Class.forName("android.app.ResourcesManager");
                Method declaredMethod = cls.getDeclaredMethod("getInstance", new Class[0]);
                declaredMethod.setAccessible(true);
                Object objInvoke = declaredMethod.invoke(cls, new Object[0]);
                Field declaredField = cls.getDeclaredField("mResourceImpls");
                declaredField.setAccessible(true);
                for (Object obj : ((Map) declaredField.get(objInvoke)).keySet()) {
                    Field declaredField2 = Class.forName("android.content.res.ResourcesKey").getDeclaredField("mSplitResDirs");
                    declaredField2.setAccessible(true);
                    declaredField2.set(obj, m169m((String[]) declaredField2.get(obj), str));
                }
            } catch (Exception unused) {
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX INFO: renamed from: o */
    public static final native int m173o(Context context);

    /* JADX INFO: renamed from: p */
    public static final native void m174p();

    /* JADX INFO: renamed from: q */
    public static final native int m175q();

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static void stub() throws Exception {
        try {
            int[] iArr = new int[0];
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
