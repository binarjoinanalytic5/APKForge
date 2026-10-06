package com.google.firebase.sessions;

import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import wakotl.Unit;
import wakotl.coroutines.Continuation;

/* JADX INFO: renamed from: com.google.firebase.sessions.v */
/* JADX INFO: loaded from: classes.dex */
public final class C0139v implements kotlinx.coroutines.flow.j {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ kotlinx.coroutines.flow.j f910a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ C0141x f911b;

    public C0139v(kotlinx.coroutines.flow.j jVar, C0141x c0141x) {
        this.f910a = jVar;
        this.f911b = c0141x;
    }

    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object emit(Object obj, Continuation continuation) {
        SessionDatastoreImpl$special$$inlined$map$1$2$1 sessionDatastoreImpl$special$$inlined$map$1$2$1;
        if (continuation instanceof SessionDatastoreImpl$special$$inlined$map$1$2$1) {
            sessionDatastoreImpl$special$$inlined$map$1$2$1 = (SessionDatastoreImpl$special$$inlined$map$1$2$1) continuation;
            int i = sessionDatastoreImpl$special$$inlined$map$1$2$1.label;
            if ((i & BasicMeasure.AT_MOST) != 0) {
                sessionDatastoreImpl$special$$inlined$map$1$2$1.label = i - BasicMeasure.AT_MOST;
            } else {
                sessionDatastoreImpl$special$$inlined$map$1$2$1 = new SessionDatastoreImpl$special$$inlined$map$1$2$1(this, continuation);
            }
        } else {
            sessionDatastoreImpl$special$$inlined$map$1$2$1 = new SessionDatastoreImpl$special$$inlined$map$1$2$1(this, continuation);
        }
        Object obj2 = sessionDatastoreImpl$special$$inlined$map$1$2$1.result;
        Object coroutine_suspended = wakotl.coroutines.intrinsics.a.getCOROUTINE_SUSPENDED();
        int i2 = sessionDatastoreImpl$special$$inlined$map$1$2$1.label;
        if (i2 == 0) {
            wakotl.b.b(obj2);
            C0137t c0137t = C0141x.f915e;
            this.f911b.getClass();
            C0120l c0120l = new C0120l((String) ((androidx.datastore.preferences.core.g) obj).b(AbstractC0138u.f909a));
            sessionDatastoreImpl$special$$inlined$map$1$2$1.label = 1;
            if (this.f910a.emit(c0120l, sessionDatastoreImpl$special$$inlined$map$1$2$1) == coroutine_suspended) {
                return coroutine_suspended;
            }
        } else {
            if (i2 != 1) {
                throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
            }
            wakotl.b.b(obj2);
        }
        return Unit.a;
    }
}
