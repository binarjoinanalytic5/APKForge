package com.google.firebase.crashlytics.ndk;

import android.util.Log;
import androidx.datastore.preferences.core.h;
import java.io.IOException;
import java.util.HashMap;
import org.json.JSONObject;
import sf.p1;

/* JADX INFO: renamed from: com.google.firebase.crashlytics.ndk.b */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0057b {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ ag.b f627a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ String f628b;

    /* JADX INFO: renamed from: c */
    public final /* synthetic */ long f629c;

    /* JADX INFO: renamed from: d */
    public final /* synthetic */ p1 f630d;

    public /* synthetic */ C0057b(ag.b bVar, String str, long j, p1 p1Var) {
        this.f627a = bVar;
        this.f628b = str;
        this.f629c = j;
        this.f630d = p1Var;
    }

    /* JADX INFO: renamed from: a */
    public final void m217a() {
        long j = this.f629c;
        p1 p1Var = this.f630d;
        ag.a aVar = this.f627a.a;
        vf.c cVar = aVar.c;
        String str = this.f628b;
        try {
            String canonicalPath = cVar.f(str).getCanonicalPath();
            if (((JniNativeApi) aVar.b).m215b(aVar.a.getAssets(), canonicalPath)) {
                aVar.getClass();
                HashMap mapV = h.v("session_id", str, "generator", "Crashlytics Android SDK/19.4.0");
                mapV.put("started_at_seconds", Long.valueOf(j));
                ag.a.f(aVar.c, str, new JSONObject(mapV).toString(), "session.json");
                aVar.d(str, p1Var.a);
                aVar.g(str, p1Var.b);
                aVar.e(str, p1Var.c);
            }
        } catch (IOException e) {
            Log.e("FirebaseCrashlytics", "Error initializing Crashlytics NDK", e);
        }
    }
}
