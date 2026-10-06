package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.e0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0107e0 {

    /* JADX INFO: renamed from: a */
    public final String f829a;

    /* JADX INFO: renamed from: b */
    public final String f830b;

    /* JADX INFO: renamed from: c */
    public final int f831c;

    /* JADX INFO: renamed from: d */
    public final long f832d;

    /* JADX INFO: renamed from: e */
    public final C0114i f833e;

    /* JADX INFO: renamed from: f */
    public final String f834f;

    /* JADX INFO: renamed from: g */
    public final String f835g;

    public C0107e0(String str, String str2, int i, long j, C0114i c0114i, String str3, String str4) {
        Intrinsics.checkNotNullParameter(str, "sessionId");
        Intrinsics.checkNotNullParameter(str2, "firstSessionId");
        Intrinsics.checkNotNullParameter(c0114i, "dataCollectionStatus");
        Intrinsics.checkNotNullParameter(str3, "firebaseInstallationId");
        Intrinsics.checkNotNullParameter(str4, "firebaseAuthenticationToken");
        this.f829a = str;
        this.f830b = str2;
        this.f831c = i;
        this.f832d = j;
        this.f833e = c0114i;
        this.f834f = str3;
        this.f835g = str4;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0107e0)) {
            return false;
        }
        C0107e0 c0107e0 = (C0107e0) obj;
        return Intrinsics.a(this.f829a, c0107e0.f829a) && Intrinsics.a(this.f830b, c0107e0.f830b) && this.f831c == c0107e0.f831c && this.f832d == c0107e0.f832d && Intrinsics.a(this.f833e, c0107e0.f833e) && Intrinsics.a(this.f834f, c0107e0.f834f) && Intrinsics.a(this.f835g, c0107e0.f835g);
    }

    public final int hashCode() {
        return this.f835g.hashCode() + a1.a.b((this.f833e.hashCode() + ((com.applovin.impl.sdk.w.h(this.f832d) + ((a1.a.b(this.f829a.hashCode() * 31, 31, this.f830b) + this.f831c) * 31)) * 31)) * 31, 31, this.f834f);
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder("SessionInfo(sessionId=");
        sb.append(this.f829a);
        sb.append(", firstSessionId=");
        sb.append(this.f830b);
        sb.append(", sessionIndex=");
        sb.append(this.f831c);
        sb.append(", eventTimestampUs=");
        sb.append(this.f832d);
        sb.append(", dataCollectionStatus=");
        sb.append(this.f833e);
        sb.append(", firebaseInstallationId=");
        sb.append(this.f834f);
        sb.append(", firebaseAuthenticationToken=");
        return a1.a.s(sb, this.f835g, ')');
    }
}
