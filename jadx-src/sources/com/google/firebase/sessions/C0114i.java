package com.google.firebase.sessions;

import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.i */
/* JADX INFO: loaded from: classes.dex */
public final class C0114i {

    /* JADX INFO: renamed from: a */
    public final DataCollectionState f855a;

    /* JADX INFO: renamed from: b */
    public final DataCollectionState f856b;

    /* JADX INFO: renamed from: c */
    public final double f857c;

    public C0114i(DataCollectionState dataCollectionState, DataCollectionState dataCollectionState2, double d) {
        Intrinsics.checkNotNullParameter(dataCollectionState, "performance");
        Intrinsics.checkNotNullParameter(dataCollectionState2, "crashlytics");
        this.f855a = dataCollectionState;
        this.f856b = dataCollectionState2;
        this.f857c = d;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof C0114i)) {
            return false;
        }
        C0114i c0114i = (C0114i) obj;
        return this.f855a == c0114i.f855a && this.f856b == c0114i.f856b && Double.compare(this.f857c, c0114i.f857c) == 0;
    }

    public final int hashCode() {
        return com.applovin.impl.sdk.w.d(this.f857c) + ((this.f856b.hashCode() + (this.f855a.hashCode() * 31)) * 31);
    }

    public final String toString() {
        return "DataCollectionStatus(performance=" + this.f855a + ", crashlytics=" + this.f856b + ", sessionSamplingRate=" + this.f857c + ')';
    }
}
