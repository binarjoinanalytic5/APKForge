package com.google.firebase.messaging;

import android.content.Context;
import java.util.concurrent.Executor;

/* JADX INFO: renamed from: com.google.firebase.messaging.m */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0080m implements jf.e {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ int f731a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ jf.o f732b;

    public /* synthetic */ C0080m(jf.o oVar, int i) {
        this.f731a = i;
        this.f732b = oVar;
    }

    /* JADX INFO: renamed from: f */
    public final Object m269f(C0089v c0089v) {
        switch (this.f731a) {
            case 0:
                return FirebaseMessagingRegistrar.lambda$getComponents$0(this.f732b, c0089v);
            default:
                return new ig.c((Context) c0089v.m297a(Context.class), ((ef.h) c0089v.m297a(ef.h.class)).d(), c0089v.m309o(ig.d.class), c0089v.m301e(sg.b.class), (Executor) c0089v.m299c(this.f732b));
        }
    }
}
