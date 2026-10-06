package com.google.firebase.sessions;

import com.google.android.datatransport.Priority;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.j */
/* JADX INFO: loaded from: classes.dex */
public final class C0116j {

    /* JADX INFO: renamed from: a */
    public final kg.b f862a;

    public C0116j(kg.b bVar) {
        Intrinsics.checkNotNullParameter(bVar, "transportFactoryProvider");
        this.f862a = bVar;
    }

    /* JADX INFO: renamed from: a */
    public final void m335a(C0143z c0143z) {
        Intrinsics.checkNotNullParameter(c0143z, "sessionEvent");
        ((eb.f) this.f862a.get()).a("FIREBASE_APPQUALITY_SESSION", new eb.c("json"), new f(this, 6)).m308n(new eb.a(c0143z, Priority.DEFAULT, (eb.b) null), new ef.i(1));
    }
}
