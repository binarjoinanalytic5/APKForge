package com.google.firebase.sessions;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.os.Build;
import android.os.Process;
import androidx.appcompat.widget.w0;
import androidx.credentials.playservices.controllers.CreatePublicKeyCredential.PublicKeyCredentialControllerUtility$GetGMSVersion$;
import com.facebook.internal.h1;
import com.google.android.gms.common.util.ProcessUtils;
import java.util.Iterator;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.a0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0096a0 {

    /* JADX INFO: renamed from: a */
    public static final C0096a0 f787a = new C0096a0();

    /* JADX INFO: renamed from: b */
    public static final w0 f788b;

    static {
        fg.d dVar = new fg.d();
        dVar.a(C0143z.class, C0110g.f842a);
        dVar.a(C0107e0.class, C0112h.f846a);
        dVar.a(C0114i.class, C0106e.f825a);
        dVar.a(C0100b.class, C0104d.f813a);
        dVar.a(C0095a.class, C0102c.f799a);
        dVar.a(C0127p.class, C0108f.f836a);
        dVar.d = true;
        w0 w0Var = new w0(dVar, 23);
        Intrinsics.checkNotNullExpressionValue(w0Var, "JsonDataEncoderBuilder()…lues(true)\n      .build()");
        f788b = w0Var;
    }

    /* JADX INFO: renamed from: a */
    public static C0100b m322a(ef.h hVar) {
        Object next;
        String myProcessName;
        Intrinsics.checkNotNullParameter(hVar, "firebaseApp");
        hVar.a();
        Context context = hVar.a;
        Intrinsics.checkNotNullExpressionValue(context, "firebaseApp.applicationContext");
        String packageName = context.getPackageName();
        PackageInfo packageInfo = context.getPackageManager().getPackageInfo(packageName, 0);
        String strValueOf = Build.VERSION.SDK_INT >= 28 ? String.valueOf(PublicKeyCredentialControllerUtility$GetGMSVersion$.ExternalSyntheticApiModelOutline0.m(packageInfo)) : String.valueOf(packageInfo.versionCode);
        hVar.a();
        String str = hVar.c.b;
        Intrinsics.checkNotNullExpressionValue(str, "firebaseApp.options.applicationId");
        String str2 = Build.MODEL;
        Intrinsics.checkNotNullExpressionValue(str2, "MODEL");
        String str3 = Build.VERSION.RELEASE;
        Intrinsics.checkNotNullExpressionValue(str3, "RELEASE");
        LogEnvironment logEnvironment = LogEnvironment.LOG_ENVIRONMENT_PROD;
        Intrinsics.checkNotNullExpressionValue(packageName, "packageName");
        String str4 = packageInfo.versionName;
        String str5 = str4 == null ? strValueOf : str4;
        String str6 = Build.MANUFACTURER;
        Intrinsics.checkNotNullExpressionValue(str6, "MANUFACTURER");
        hVar.a();
        Intrinsics.checkNotNullExpressionValue(context, "firebaseApp.applicationContext");
        Intrinsics.checkNotNullParameter(context, "context");
        int iMyPid = Process.myPid();
        Iterator it = h1.E(context).iterator();
        do {
            if (!it.hasNext()) {
                next = null;
                break;
            }
            next = it.next();
        } while (((C0127p) next).f878b != iMyPid);
        C0127p c0127p = (C0127p) next;
        if (c0127p == null) {
            int i = Build.VERSION.SDK_INT;
            if (i >= 33) {
                myProcessName = androidx.appcompat.app.c0.l();
                Intrinsics.checkNotNullExpressionValue(myProcessName, "myProcessName()");
            } else if ((i < 28 || (myProcessName = androidx.activity.z.i()) == null) && (myProcessName = ProcessUtils.getMyProcessName()) == null) {
                myProcessName = "";
            }
            c0127p = new C0127p(iMyPid, 0, myProcessName, false);
        }
        hVar.a();
        Intrinsics.checkNotNullExpressionValue(context, "firebaseApp.applicationContext");
        return new C0100b(str, str2, str3, logEnvironment, new C0095a(packageName, str5, strValueOf, str6, c0127p, h1.E(context)));
    }
}
