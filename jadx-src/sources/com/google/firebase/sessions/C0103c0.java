package com.google.firebase.sessions;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import com.google.firebase.sessions.settings.C0135e;
import wakotl.coroutines.CoroutineContext;
import wakotl.coroutines.jvm.internal.Boxing;
import wakotl.coroutines.jvm.internal.ContinuationImpl;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.c0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0103c0 implements InterfaceC0101b0 {

    /* JADX INFO: renamed from: f */
    public static final double f806f = Math.random();

    /* JADX INFO: renamed from: g */
    public static final /* synthetic */ int f807g = 0;

    /* JADX INFO: renamed from: a */
    public final ef.h f808a;

    /* JADX INFO: renamed from: b */
    public final lg.d f809b;

    /* JADX INFO: renamed from: c */
    public final C0135e f810c;

    /* JADX INFO: renamed from: d */
    public final C0116j f811d;

    /* JADX INFO: renamed from: e */
    public final CoroutineContext f812e;

    public C0103c0(ef.h hVar, lg.d dVar, C0135e c0135e, C0116j c0116j, CoroutineContext coroutineContext) {
        Intrinsics.checkNotNullParameter(hVar, "firebaseApp");
        Intrinsics.checkNotNullParameter(dVar, "firebaseInstallations");
        Intrinsics.checkNotNullParameter(c0135e, "sessionSettings");
        Intrinsics.checkNotNullParameter(c0116j, "eventGDTLogger");
        Intrinsics.checkNotNullParameter(coroutineContext, "backgroundDispatcher");
        this.f808a = hVar;
        this.f809b = dVar;
        this.f810c = c0135e;
        this.f811d = c0116j;
        this.f812e = coroutineContext;
    }

    /* JADX WARN: Code duplicated, block: B:7:0x0016  */
    /* JADX INFO: renamed from: a */
    public static final Object m326a(C0103c0 c0103c0, ContinuationImpl continuationImpl) {
        SessionFirelogPublisherImpl$shouldLogSession$1 sessionFirelogPublisherImpl$shouldLogSession$1;
        boolean zBooleanValue;
        c0103c0.getClass();
        if (continuationImpl instanceof SessionFirelogPublisherImpl$shouldLogSession$1) {
            sessionFirelogPublisherImpl$shouldLogSession$1 = (SessionFirelogPublisherImpl$shouldLogSession$1) continuationImpl;
            int i = sessionFirelogPublisherImpl$shouldLogSession$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                sessionFirelogPublisherImpl$shouldLogSession$1.label = i - BasicMeasure.AT_MOST;
            } else {
                sessionFirelogPublisherImpl$shouldLogSession$1 = new SessionFirelogPublisherImpl$shouldLogSession$1(c0103c0, continuationImpl);
            }
        } else {
            sessionFirelogPublisherImpl$shouldLogSession$1 = new SessionFirelogPublisherImpl$shouldLogSession$1(c0103c0, continuationImpl);
        }
        Object obj = sessionFirelogPublisherImpl$shouldLogSession$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i2 = sessionFirelogPublisherImpl$shouldLogSession$1.label;
        if (i2 == 0) {
            wakotl.b.b(obj);
            sessionFirelogPublisherImpl$shouldLogSession$1.L$0 = c0103c0;
            sessionFirelogPublisherImpl$shouldLogSession$1.label = 1;
            if (c0103c0.f810c.m345b(sessionFirelogPublisherImpl$shouldLogSession$1) == coroutine_suspended) {
                return coroutine_suspended;
            }
        } else {
            if (i2 != 1) {
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
            }
            c0103c0 = (C0103c0) sessionFirelogPublisherImpl$shouldLogSession$1.L$0;
            wakotl.b.b(obj);
        }
        C0135e c0135e = c0103c0.f810c;
        Boolean boolM286h = c0135e.f899a.m286h();
        if (boolM286h != null) {
            zBooleanValue = boolM286h.booleanValue();
        } else {
            Boolean boolM340a = c0135e.f900b.m340a();
            zBooleanValue = boolM340a != null ? boolM340a.booleanValue() : true;
        }
        if (zBooleanValue) {
            return f806f <= c0103c0.f810c.m344a() ? Boxing.boxBoolean(true) : Boxing.boxBoolean(false);
        }
        return Boxing.boxBoolean(false);
    }
}
