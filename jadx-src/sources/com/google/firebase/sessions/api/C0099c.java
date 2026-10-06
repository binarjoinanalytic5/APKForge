package com.google.firebase.sessions.api;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.api.c */
/* JADX INFO: loaded from: classes.dex */
public final class C0099c {

    /* JADX INFO: renamed from: a */
    public final String f793a;

    public C0099c(String str) {
        Intrinsics.checkNotNullParameter(str, "sessionId");
        this.f793a = str;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return (obj instanceof C0099c) && Intrinsics.a(this.f793a, ((C0099c) obj).f793a);
    }

    public final int hashCode() {
        return this.f793a.hashCode();
    }

    public final String toString() {
        return a1.a.s(new StringBuilder("SessionDetails(sessionId="), this.f793a, ')');
    }
}
