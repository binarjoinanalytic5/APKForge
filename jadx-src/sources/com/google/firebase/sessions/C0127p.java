package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.p */
/* JADX INFO: loaded from: classes.dex */
public final class C0127p {

    /* JADX INFO: renamed from: a */
    public final String f877a;

    /* JADX INFO: renamed from: b */
    public final int f878b;

    /* JADX INFO: renamed from: c */
    public final int f879c;

    /* JADX INFO: renamed from: d */
    public final boolean f880d;

    public C0127p(int i, int i2, String str, boolean z) {
        Intrinsics.checkNotNullParameter(str, "processName");
        this.f877a = str;
        this.f878b = i;
        this.f879c = i2;
        this.f880d = z;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0127p)) {
            return false;
        }
        C0127p c0127p = (C0127p) obj;
        return Intrinsics.a(this.f877a, c0127p.f877a) && this.f878b == c0127p.f878b && this.f879c == c0127p.f879c && this.f880d == c0127p.f880d;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v7, types: [int] */
    /* JADX WARN: Type inference failed for: r1v3, types: [int] */
    /* JADX WARN: Type inference failed for: r1v4 */
    /* JADX WARN: Type inference failed for: r1v5 */
    public final int hashCode() {
        int iHashCode = ((((this.f877a.hashCode() * 31) + this.f878b) * 31) + this.f879c) * 31;
        boolean z = this.f880d;
        ?? r1 = z;
        if (z) {
            r1 = 1;
        }
        return iHashCode + r1;
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder("ProcessDetails(processName=");
        sb.append(this.f877a);
        sb.append(", pid=");
        sb.append(this.f878b);
        sb.append(", importance=");
        sb.append(this.f879c);
        sb.append(", isDefaultProcess=");
        return a1.a.v(sb, this.f880d, ')');
    }
}
