package com.google.firebase.sessions.settings;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.settings.c */
/* JADX INFO: loaded from: classes.dex */
public final class C0133c {

    /* JADX INFO: renamed from: a */
    public final Boolean f891a;

    /* JADX INFO: renamed from: b */
    public final Double f892b;

    /* JADX INFO: renamed from: c */
    public final Integer f893c;

    /* JADX INFO: renamed from: d */
    public final Integer f894d;

    /* JADX INFO: renamed from: e */
    public final Long f895e;

    public C0133c(Boolean bool, Double d, Integer num, Integer num2, Long l) {
        this.f891a = bool;
        this.f892b = d;
        this.f893c = num;
        this.f894d = num2;
        this.f895e = l;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0133c)) {
            return false;
        }
        C0133c c0133c = (C0133c) obj;
        return Intrinsics.a(this.f891a, c0133c.f891a) && Intrinsics.a(this.f892b, c0133c.f892b) && Intrinsics.a(this.f893c, c0133c.f893c) && Intrinsics.a(this.f894d, c0133c.f894d) && Intrinsics.a(this.f895e, c0133c.f895e);
    }

    public final int hashCode() {
        Boolean bool = this.f891a;
        int iHashCode = (bool == null ? 0 : bool.hashCode()) * 31;
        Double d = this.f892b;
        int iHashCode2 = (iHashCode + (d == null ? 0 : d.hashCode())) * 31;
        Integer num = this.f893c;
        int iHashCode3 = (iHashCode2 + (num == null ? 0 : num.hashCode())) * 31;
        Integer num2 = this.f894d;
        int iHashCode4 = (iHashCode3 + (num2 == null ? 0 : num2.hashCode())) * 31;
        Long l = this.f895e;
        return iHashCode4 + (l != null ? l.hashCode() : 0);
    }

    public final String toString() {
        return "SessionConfigs(sessionEnabled=" + this.f891a + ", sessionSamplingRate=" + this.f892b + ", sessionRestartTimeout=" + this.f893c + ", cacheDuration=" + this.f894d + ", cacheUpdatedTime=" + this.f895e + ')';
    }
}
