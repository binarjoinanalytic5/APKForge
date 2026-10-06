package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0100b {

    /* JADX INFO: renamed from: a */
    public final String f794a;

    /* JADX INFO: renamed from: b */
    public final String f795b;

    /* JADX INFO: renamed from: c */
    public final String f796c;

    /* JADX INFO: renamed from: d */
    public final LogEnvironment f797d;

    /* JADX INFO: renamed from: e */
    public final C0095a f798e;

    public C0100b(String str, String str2, String str3, LogEnvironment logEnvironment, C0095a c0095a) {
        Intrinsics.checkNotNullParameter(str, "appId");
        Intrinsics.checkNotNullParameter(str2, "deviceModel");
        Intrinsics.checkNotNullParameter("2.0.8", "sessionSdkVersion");
        Intrinsics.checkNotNullParameter(str3, "osVersion");
        Intrinsics.checkNotNullParameter(logEnvironment, "logEnvironment");
        Intrinsics.checkNotNullParameter(c0095a, "androidAppInfo");
        this.f794a = str;
        this.f795b = str2;
        this.f796c = str3;
        this.f797d = logEnvironment;
        this.f798e = c0095a;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0100b)) {
            return false;
        }
        C0100b c0100b = (C0100b) obj;
        return Intrinsics.a(this.f794a, c0100b.f794a) && Intrinsics.a(this.f795b, c0100b.f795b) && Intrinsics.a(this.f796c, c0100b.f796c) && this.f797d == c0100b.f797d && this.f798e.equals(c0100b.f798e);
    }

    public final int hashCode() {
        return this.f798e.hashCode() + ((this.f797d.hashCode() + a1.a.b((((this.f795b.hashCode() + (this.f794a.hashCode() * 31)) * 31) + 47594046) * 31, 31, this.f796c)) * 31);
    }

    public final String toString() {
        return "ApplicationInfo(appId=" + this.f794a + ", deviceModel=" + this.f795b + ", sessionSdkVersion=2.0.8, osVersion=" + this.f796c + ", logEnvironment=" + this.f797d + ", androidAppInfo=" + this.f798e + ')';
    }
}
