package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.l */
/* JADX INFO: loaded from: classes.dex */
public final class C0120l {

    /* JADX INFO: renamed from: a */
    public final String f868a;

    public C0120l(String str) {
        this.f868a = str;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return (obj instanceof C0120l) && Intrinsics.a(this.f868a, ((C0120l) obj).f868a);
    }

    public final int hashCode() {
        String str = this.f868a;
        if (str == null) {
            return 0;
        }
        return str.hashCode();
    }

    public final String toString() {
        return a1.a.s(new StringBuilder("FirebaseSessionsData(sessionId="), this.f868a, ')');
    }
}
