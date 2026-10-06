package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.y */
/* JADX INFO: loaded from: classes.dex */
public final class C0142y {

    /* JADX INFO: renamed from: a */
    public final String f921a;

    /* JADX INFO: renamed from: b */
    public final String f922b;

    /* JADX INFO: renamed from: c */
    public final int f923c;

    /* JADX INFO: renamed from: d */
    public final long f924d;

    public C0142y(int i, long j, String str, String str2) {
        Intrinsics.checkNotNullParameter(str, "sessionId");
        Intrinsics.checkNotNullParameter(str2, "firstSessionId");
        this.f921a = str;
        this.f922b = str2;
        this.f923c = i;
        this.f924d = j;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0142y)) {
            return false;
        }
        C0142y c0142y = (C0142y) obj;
        return Intrinsics.a(this.f921a, c0142y.f921a) && Intrinsics.a(this.f922b, c0142y.f922b) && this.f923c == c0142y.f923c && this.f924d == c0142y.f924d;
    }

    public final int hashCode() {
        return com.applovin.impl.sdk.w.h(this.f924d) + ((a1.a.b(this.f921a.hashCode() * 31, 31, this.f922b) + this.f923c) * 31);
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder("SessionDetails(sessionId=");
        sb.append(this.f921a);
        sb.append(", firstSessionId=");
        sb.append(this.f922b);
        sb.append(", sessionIndex=");
        sb.append(this.f923c);
        sb.append(", sessionStartTimestampUs=");
        return a1.a.q(sb, this.f924d, ')');
    }
}
