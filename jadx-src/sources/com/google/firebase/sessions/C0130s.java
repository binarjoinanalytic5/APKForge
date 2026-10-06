package com.google.firebase.sessions;

import wakotl.Unit;
import wakotl.coroutines.Continuation;

/* JADX INFO: renamed from: com.google.firebase.sessions.s */
/* JADX INFO: loaded from: classes.dex */
public final class C0130s implements kotlinx.coroutines.flow.j {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ C0141x f883a;

    public C0130s(C0141x c0141x) {
        this.f883a = c0141x;
    }

    public final Object emit(Object obj, Continuation continuation) {
        this.f883a.f919c.set((C0120l) obj);
        return Unit.a;
    }
}
