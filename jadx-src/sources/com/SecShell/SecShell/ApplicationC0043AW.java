package com.SecShell.SecShell;

import android.annotation.TargetApi;
import android.app.Application;
import android.content.Context;
import androidx.constraintlayout.widget.ConstraintLayout;

/* JADX INFO: renamed from: com.SecShell.SecShell.AW */
/* JADX INFO: loaded from: classes.dex */
public class ApplicationC0043AW extends Application {

    /* JADX INFO: renamed from: a */
    private static Application f558a = null;

    /* JADX INFO: renamed from: b */
    private static Application f559b = null;

    /* JADX INFO: renamed from: c */
    private static boolean f560c = false;

    /* JADX INFO: renamed from: d */
    public static String f561d = "true";

    /* JADX INFO: renamed from: mC */
    private static Context f562mC;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    public static void m150a() throws Exception {
        Application application;
        try {
            int[] iArr = new int[0];
            if (f560c || (application = f558a) == null) {
                return;
            }
            f560c = true;
            C0045H.m152bb(f562mC, f559b, application);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.content.ContextWrapper
    protected void attachBaseContext(Context context) throws Exception {
        try {
            int[] iArr = new int[0];
            f562mC = context;
            System.loadLibrary(C0045H.is_x86_byso() ? "SecShell-x86" : "SecShell");
            f559b = this;
            super.attachBaseContext(context);
            try {
                if (!"".equals(C0045H.APPNAME) && (C0045H.m175q() == 0 || C0045H.m170mu() == 0)) {
                    f558a = (Application) getClassLoader().loadClass(C0045H.APPNAME).newInstance();
                }
            } catch (Exception unused) {
                f558a = null;
            }
            C0045H.attach(f558a, context);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.content.ContextWrapper, android.content.Context
    public Context getApplicationContext() throws Exception {
        try {
            int[] iArr = new int[0];
            Application application = f558a;
            return application != null ? application : super.getApplicationContext();
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.Application
    public void onCreate() throws Exception {
        try {
            int[] iArr = new int[0];
            m150a();
            super.onCreate();
            Application application = f558a;
            if (application != null) {
                C0045H.attach(application, null);
                f558a.onCreate();
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.Application
    @TargetApi(ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_TO_TOP_OF)
    public void registerActivityLifecycleCallbacks(Application.ActivityLifecycleCallbacks activityLifecycleCallbacks) throws Exception {
        try {
            int[] iArr = new int[0];
            super.registerActivityLifecycleCallbacks(activityLifecycleCallbacks);
            Application application = f558a;
            if (application != null) {
                application.registerActivityLifecycleCallbacks(activityLifecycleCallbacks);
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
