package com.google.firebase.sessions.api;

import pf.j;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.api.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0097a {

    /* JADX INFO: renamed from: a */
    public final kotlinx.coroutines.sync.a f789a;

    /* JADX INFO: renamed from: b */
    public j f790b;

    public C0097a(kotlinx.coroutines.sync.a aVar) {
        Intrinsics.checkNotNullParameter(aVar, "mutex");
        this.f789a = aVar;
        this.f790b = null;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0097a)) {
            return false;
        }
        C0097a c0097a = (C0097a) obj;
        return this.f789a.equals(c0097a.f789a) && Intrinsics.a(this.f790b, c0097a.f790b);
    }

    public final int hashCode() {
        int iHashCode = this.f789a.hashCode() * 31;
        j jVar = this.f790b;
        return iHashCode + (jVar == null ? 0 : jVar.hashCode());
    }

    public final String toString() {
        return "Dependency(mutex=" + this.f789a + ", subscriber=" + this.f790b + ')';
    }
}
