package com.SecShell.SecShell;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AppComponentFactory;
import android.app.Application;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.ContentProvider;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.text.TextUtils;
import androidx.constraintlayout.widget.ConstraintLayout;

/* JADX INFO: renamed from: com.SecShell.SecShell.AP */
/* JADX INFO: loaded from: classes.dex */
@TargetApi(ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINED_HEIGHT)
public final class AppComponentFactoryC0042AP extends AppComponentFactory {

    /* JADX INFO: renamed from: a */
    private AppComponentFactory f557a = null;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    private synchronized AppComponentFactory m148a(ClassLoader classLoader) throws Exception {
        AppComponentFactory appComponentFactory;
        try {
            int[] iArr = new int[0];
            synchronized (this) {
                if (this.f557a == null && !TextUtils.isEmpty(C0045H.ACFNAME)) {
                    try {
                        this.f557a = (AppComponentFactory) classLoader.loadClass(C0045H.ACFNAME).newInstance();
                    } catch (Exception unused) {
                    }
                }
                appComponentFactory = this.f557a;
            }
            return appComponentFactory;
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /* JADX INFO: renamed from: a */
    public synchronized void m149a(AppComponentFactory appComponentFactory) throws Exception {
        try {
            int[] iArr = new int[0];
            synchronized (this) {
                this.f557a = appComponentFactory;
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    public Activity instantiateActivity(ClassLoader classLoader, String str, Intent intent) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateActivity(classLoader, str, intent);
                }
            }
            return super.instantiateActivity(classLoader, str, intent);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    public Application instantiateApplication(ClassLoader classLoader, String str) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateApplication(classLoader, str);
                }
            }
            return super.instantiateApplication(classLoader, str);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    @TargetApi(ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_BIAS)
    public ClassLoader instantiateClassLoader(ClassLoader classLoader, ApplicationInfo applicationInfo) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateClassLoader(classLoader, applicationInfo);
                }
            }
            return super.instantiateClassLoader(classLoader, applicationInfo);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    public ContentProvider instantiateProvider(ClassLoader classLoader, String str) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateProvider(classLoader, str);
                }
            }
            return super.instantiateProvider(classLoader, str);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    public BroadcastReceiver instantiateReceiver(ClassLoader classLoader, String str, Intent intent) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateReceiver(classLoader, str, intent);
                }
            }
            return super.instantiateReceiver(classLoader, str, intent);
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.app.AppComponentFactory
    public Service instantiateService(ClassLoader classLoader, String str, Intent intent) throws Exception {
        try {
            int[] iArr = new int[0];
            if (Boolean.parseBoolean(ApplicationC0043AW.f561d)) {
                AppComponentFactory appComponentFactoryM148a = m148a(classLoader);
                m149a(appComponentFactoryM148a);
                if (appComponentFactoryM148a != null) {
                    return appComponentFactoryM148a.instantiateService(classLoader, str, intent);
                }
            }
            return super.instantiateService(classLoader, str, intent);
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
