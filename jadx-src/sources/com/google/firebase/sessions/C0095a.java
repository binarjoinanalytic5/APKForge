package com.google.firebase.sessions;

import java.util.ArrayList;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0095a {

    /* JADX INFO: renamed from: a */
    public final String f781a;

    /* JADX INFO: renamed from: b */
    public final String f782b;

    /* JADX INFO: renamed from: c */
    public final String f783c;

    /* JADX INFO: renamed from: d */
    public final String f784d;

    /* JADX INFO: renamed from: e */
    public final C0127p f785e;

    /* JADX INFO: renamed from: f */
    public final ArrayList f786f;

    public C0095a(String str, String str2, String str3, String str4, C0127p c0127p, ArrayList arrayList) {
        Intrinsics.checkNotNullParameter(str, "packageName");
        Intrinsics.checkNotNullParameter(str2, "versionName");
        Intrinsics.checkNotNullParameter(str3, "appBuildVersion");
        Intrinsics.checkNotNullParameter(str4, "deviceManufacturer");
        Intrinsics.checkNotNullParameter(c0127p, "currentProcessDetails");
        Intrinsics.checkNotNullParameter(arrayList, "appProcessDetails");
        this.f781a = str;
        this.f782b = str2;
        this.f783c = str3;
        this.f784d = str4;
        this.f785e = c0127p;
        this.f786f = arrayList;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0095a)) {
            return false;
        }
        C0095a c0095a = (C0095a) obj;
        return Intrinsics.a(this.f781a, c0095a.f781a) && Intrinsics.a(this.f782b, c0095a.f782b) && Intrinsics.a(this.f783c, c0095a.f783c) && Intrinsics.a(this.f784d, c0095a.f784d) && this.f785e.equals(c0095a.f785e) && this.f786f.equals(c0095a.f786f);
    }

    public final int hashCode() {
        return this.f786f.hashCode() + ((this.f785e.hashCode() + a1.a.b(a1.a.b(a1.a.b(this.f781a.hashCode() * 31, 31, this.f782b), 31, this.f783c), 31, this.f784d)) * 31);
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder("AndroidApplicationInfo(packageName=");
        sb.append(this.f781a);
        sb.append(", versionName=");
        sb.append(this.f782b);
        sb.append(", appBuildVersion=");
        sb.append(this.f783c);
        sb.append(", deviceManufacturer=");
        sb.append(this.f784d);
        sb.append(", currentProcessDetails=");
        sb.append(this.f785e);
        sb.append(", appProcessDetails=");
        return an.q.k(sb, this.f786f, ')');
    }
}
