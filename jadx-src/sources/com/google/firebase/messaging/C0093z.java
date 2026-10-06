package com.google.firebase.messaging;

import android.content.SharedPreferences;
import android.text.TextUtils;
import java.lang.ref.WeakReference;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.regex.Pattern;

/* JADX INFO: renamed from: com.google.firebase.messaging.z */
/* JADX INFO: loaded from: classes.dex */
public final class C0093z {

    /* JADX INFO: renamed from: d */
    public static WeakReference f772d;

    /* JADX INFO: renamed from: a */
    public final SharedPreferences f773a;

    /* JADX INFO: renamed from: b */
    public C0089v f774b;

    /* JADX INFO: renamed from: c */
    public final ScheduledThreadPoolExecutor f775c;

    public C0093z(SharedPreferences sharedPreferences, ScheduledThreadPoolExecutor scheduledThreadPoolExecutor) {
        this.f775c = scheduledThreadPoolExecutor;
        this.f773a = sharedPreferences;
    }

    /* JADX INFO: renamed from: a */
    public final synchronized C0092y m313a() {
        C0092y c0092y;
        String strM306l = this.f774b.m306l();
        Pattern pattern = C0092y.f768d;
        c0092y = null;
        if (!TextUtils.isEmpty(strM306l)) {
            String[] strArrSplit = strM306l.split("!", -1);
            if (strArrSplit.length == 2) {
                c0092y = new C0092y(strArrSplit[0], strArrSplit[1]);
            }
        }
        return c0092y;
    }

    /* JADX INFO: renamed from: b */
    public final synchronized void m314b() {
        this.f774b = C0089v.m295h(this.f773a, this.f775c);
    }

    /* JADX INFO: renamed from: c */
    public final synchronized void m315c(C0092y c0092y) {
        this.f774b.m307m(c0092y.f771c);
    }
}
