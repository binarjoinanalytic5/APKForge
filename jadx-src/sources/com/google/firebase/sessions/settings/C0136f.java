package com.google.firebase.sessions.settings;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import androidx.datastore.preferences.core.g;
import androidx.datastore.preferences.core.h;
import java.io.IOException;
import kotlinx.coroutines.g0;
import wakotl.Unit;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.settings.f */
/* JADX INFO: loaded from: classes.dex */
public final class C0136f {

    /* JADX INFO: renamed from: c */
    public static final androidx.datastore.preferences.core.e f901c = h.b("firebase_sessions_enabled", "name", "firebase_sessions_enabled");

    /* JADX INFO: renamed from: d */
    public static final androidx.datastore.preferences.core.e f902d = h.b("firebase_sessions_sampling_rate", "name", "firebase_sessions_sampling_rate");

    /* JADX INFO: renamed from: e */
    public static final androidx.datastore.preferences.core.e f903e = h.b("firebase_sessions_restart_timeout", "name", "firebase_sessions_restart_timeout");

    /* JADX INFO: renamed from: f */
    public static final androidx.datastore.preferences.core.e f904f = h.b("firebase_sessions_cache_duration", "name", "firebase_sessions_cache_duration");

    /* JADX INFO: renamed from: g */
    public static final androidx.datastore.preferences.core.e f905g = h.b("firebase_sessions_cache_updated_time", "name", "firebase_sessions_cache_updated_time");

    /* JADX INFO: renamed from: a */
    public final androidx.datastore.core.h f906a;

    /* JADX INFO: renamed from: b */
    public C0133c f907b;

    public C0136f(androidx.datastore.core.h hVar) {
        Intrinsics.checkNotNullParameter(hVar, "dataStore");
        this.f906a = hVar;
        g0.F(new SettingsCache$1(this, null));
    }

    /* JADX INFO: renamed from: a */
    public static final void m346a(C0136f c0136f, g gVar) {
        c0136f.getClass();
        c0136f.f907b = new C0133c((Boolean) gVar.b(f901c), (Double) gVar.b(f902d), (Integer) gVar.b(f903e), (Integer) gVar.b(f904f), (Long) gVar.b(f905g));
    }

    /* JADX INFO: renamed from: b */
    public final boolean m347b() {
        Integer num;
        C0133c c0133c = this.f907b;
        if (c0133c == null) {
            Intrinsics.j("sessionConfigs");
            throw null;
        }
        if (c0133c != null) {
            Long l = c0133c.f895e;
            return l == null || (num = c0133c.f894d) == null || (System.currentTimeMillis() - l.longValue()) / ((long) 1000) >= ((long) num.intValue());
        }
        Intrinsics.j("sessionConfigs");
        throw null;
    }

    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    /* JADX INFO: renamed from: c */
    public final Object m348c(androidx.datastore.preferences.core.e eVar, Object obj, ContinuationImpl continuationImpl) {
        SettingsCache$updateConfigValue$1 settingsCache$updateConfigValue$1;
        if (continuationImpl instanceof SettingsCache$updateConfigValue$1) {
            settingsCache$updateConfigValue$1 = (SettingsCache$updateConfigValue$1) continuationImpl;
            int i = settingsCache$updateConfigValue$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                settingsCache$updateConfigValue$1.label = i - BasicMeasure.AT_MOST;
            } else {
                settingsCache$updateConfigValue$1 = new SettingsCache$updateConfigValue$1(this, continuationImpl);
            }
        } else {
            settingsCache$updateConfigValue$1 = new SettingsCache$updateConfigValue$1(this, continuationImpl);
        }
        Object obj2 = settingsCache$updateConfigValue$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i2 = settingsCache$updateConfigValue$1.label;
        try {
            if (i2 == 0) {
                wakotl.b.b(obj2);
                androidx.datastore.core.h hVar = this.f906a;
                SettingsCache$updateConfigValue$2 settingsCache$updateConfigValue$2 = new SettingsCache$updateConfigValue$2(obj, eVar, this, null);
                settingsCache$updateConfigValue$1.label = 1;
                if (androidx.datastore.preferences.core.d.b(hVar, settingsCache$updateConfigValue$2, settingsCache$updateConfigValue$1) == coroutine_suspended) {
                    return coroutine_suspended;
                }
            } else {
                if (i2 != 1) {
                    throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                }
                wakotl.b.b(obj2);
            }
        } catch (IOException e) {
            e.toString();
        }
        return Unit.a;
    }
}
