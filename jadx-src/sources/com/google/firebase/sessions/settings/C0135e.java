package com.google.firebase.sessions.settings;

import android.content.Context;
import android.os.Bundle;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import com.google.firebase.messaging.C0083p;
import com.google.firebase.sessions.AbstractC0128q;
import com.google.firebase.sessions.C0096a0;
import com.google.firebase.sessions.C0100b;
import ef.h;
import kotlinx.serialization.json.internal.o;
import wakotl.Unit;
import wakotl.coroutines.CoroutineContext;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.settings.e */
/* JADX INFO: loaded from: classes.dex */
public final class C0135e {

    /* JADX INFO: renamed from: c */
    public static final C0134d f897c = new C0134d();

    /* JADX INFO: renamed from: d */
    public static final androidx.datastore.preferences.b f898d = androidx.datastore.preferences.a.a(AbstractC0128q.f882b, new o(SessionsSettings$Companion$dataStore$2.INSTANCE), 12);

    /* JADX INFO: renamed from: a */
    public final C0083p f899a;

    /* JADX INFO: renamed from: b */
    public final C0131a f900b;

    public C0135e(h hVar, CoroutineContext coroutineContext, CoroutineContext coroutineContext2, lg.d dVar) {
        Intrinsics.checkNotNullParameter(hVar, "firebaseApp");
        Intrinsics.checkNotNullParameter(coroutineContext, "blockingDispatcher");
        Intrinsics.checkNotNullParameter(coroutineContext2, "backgroundDispatcher");
        Intrinsics.checkNotNullParameter(dVar, "firebaseInstallationsApi");
        hVar.a();
        Context context = hVar.a;
        Intrinsics.checkNotNullExpressionValue(context, "firebaseApp.applicationContext");
        C0096a0 c0096a0 = C0096a0.f787a;
        C0100b c0100bM322a = C0096a0.m322a(hVar);
        C0083p c0083p = new C0083p(context);
        C0132b c0132b = new C0132b(c0100bM322a, coroutineContext);
        f897c.getClass();
        C0131a c0131a = new C0131a(coroutineContext2, dVar, c0100bM322a, c0132b, (androidx.datastore.core.h) f898d.getValue(context, C0134d.f896a[0]));
        Intrinsics.checkNotNullParameter(c0083p, "localOverrideSettings");
        Intrinsics.checkNotNullParameter(c0131a, "remoteSettings");
        this.f899a = c0083p;
        this.f900b = c0131a;
    }

    /* JADX INFO: renamed from: a */
    public final double m344a() {
        Bundle bundle = this.f899a.f741a;
        Double dValueOf = bundle.containsKey("firebase_sessions_sampling_rate") ? Double.valueOf(bundle.getDouble("firebase_sessions_sampling_rate")) : null;
        if (dValueOf != null) {
            double dDoubleValue = dValueOf.doubleValue();
            if (0.0d <= dDoubleValue && dDoubleValue <= 1.0d) {
                return dDoubleValue;
            }
        }
        C0133c c0133c = this.f900b.m341b().f907b;
        if (c0133c == null) {
            Intrinsics.j("sessionConfigs");
            throw null;
        }
        Double d = c0133c.f892b;
        if (d != null) {
            double dDoubleValue2 = d.doubleValue();
            if (0.0d <= dDoubleValue2 && dDoubleValue2 <= 1.0d) {
                return dDoubleValue2;
            }
        }
        return 1.0d;
    }

    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    /* JADX INFO: renamed from: b */
    public final Object m345b(ContinuationImpl continuationImpl) {
        SessionsSettings$updateSettings$1 sessionsSettings$updateSettings$1;
        C0135e c0135e;
        if (continuationImpl instanceof SessionsSettings$updateSettings$1) {
            sessionsSettings$updateSettings$1 = (SessionsSettings$updateSettings$1) continuationImpl;
            int i = sessionsSettings$updateSettings$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                sessionsSettings$updateSettings$1.label = i - BasicMeasure.AT_MOST;
            } else {
                sessionsSettings$updateSettings$1 = new SessionsSettings$updateSettings$1(this, continuationImpl);
            }
        } else {
            sessionsSettings$updateSettings$1 = new SessionsSettings$updateSettings$1(this, continuationImpl);
        }
        Object obj = sessionsSettings$updateSettings$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i2 = sessionsSettings$updateSettings$1.label;
        if (i2 != 0) {
            if (i2 == 1) {
                c0135e = (C0135e) sessionsSettings$updateSettings$1.L$0;
                wakotl.b.b(obj);
            } else {
                if (i2 != 2) {
                    throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
                }
                wakotl.b.b(obj);
            }
            return Unit.a;
        }
        wakotl.b.b(obj);
        sessionsSettings$updateSettings$1.L$0 = this;
        sessionsSettings$updateSettings$1.label = 1;
        this.f899a.getClass();
        if (Unit.a == coroutine_suspended) {
            return coroutine_suspended;
        }
        c0135e = this;
        C0131a c0131a = c0135e.f900b;
        sessionsSettings$updateSettings$1.L$0 = null;
        sessionsSettings$updateSettings$1.label = 2;
        if (c0131a.m342c(sessionsSettings$updateSettings$1) == coroutine_suspended) {
            return coroutine_suspended;
        }
        return Unit.a;
    }
}
