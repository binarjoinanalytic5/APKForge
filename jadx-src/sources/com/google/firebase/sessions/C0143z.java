package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.z */
/* JADX INFO: loaded from: classes.dex */
public final class C0143z {

    /* JADX INFO: renamed from: a */
    public final EventType f925a;

    /* JADX INFO: renamed from: b */
    public final C0107e0 f926b;

    /* JADX INFO: renamed from: c */
    public final C0100b f927c;

    public C0143z(EventType eventType, C0107e0 c0107e0, C0100b c0100b) {
        Intrinsics.checkNotNullParameter(eventType, "eventType");
        Intrinsics.checkNotNullParameter(c0107e0, "sessionData");
        Intrinsics.checkNotNullParameter(c0100b, "applicationInfo");
        this.f925a = eventType;
        this.f926b = c0107e0;
        this.f927c = c0100b;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0143z)) {
            return false;
        }
        C0143z c0143z = (C0143z) obj;
        return this.f925a == c0143z.f925a && Intrinsics.a(this.f926b, c0143z.f926b) && Intrinsics.a(this.f927c, c0143z.f927c);
    }

    public final int hashCode() {
        return this.f927c.hashCode() + ((this.f926b.hashCode() + (this.f925a.hashCode() * 31)) * 31);
    }

    public final String toString() {
        return "SessionEvent(eventType=" + this.f925a + ", sessionData=" + this.f926b + ", applicationInfo=" + this.f927c + ')';
    }
}
