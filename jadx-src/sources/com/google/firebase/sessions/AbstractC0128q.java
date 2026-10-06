package com.google.firebase.sessions;

import android.os.Build;
import android.util.Base64;
import com.google.android.gms.common.util.ProcessUtils;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.q */
/* JADX INFO: loaded from: classes.dex */
public abstract class AbstractC0128q {

    /* JADX INFO: renamed from: a */
    public static final String f881a;

    /* JADX INFO: renamed from: b */
    public static final String f882b;

    static {
        String myProcessName;
        int i = Build.VERSION.SDK_INT;
        if (i >= 33) {
            myProcessName = androidx.appcompat.app.c0.l();
            Intrinsics.checkNotNullExpressionValue(myProcessName, "myProcessName()");
        } else if ((i < 28 || (myProcessName = androidx.activity.z.i()) == null) && (myProcessName = ProcessUtils.getMyProcessName()) == null) {
            myProcessName = "";
        }
        String strEncodeToString = Base64.encodeToString(wakotl.text.v.n(myProcessName), 10);
        f881a = a1.a.o("firebase_session_", strEncodeToString, "_data");
        f882b = a1.a.o("firebase_session_", strEncodeToString, "_settings");
    }
}
