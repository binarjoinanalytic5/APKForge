package com.google.firebase.sessions;

import java.util.Locale;
import java.util.UUID;
import wakotl.jvm.functions.Function0;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.sessions.d0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0105d0 {

    /* JADX INFO: renamed from: a */
    public final C0125n0 f820a;

    /* JADX INFO: renamed from: b */
    public final Function0 f821b;

    /* JADX INFO: renamed from: c */
    public final String f822c;

    /* JADX INFO: renamed from: d */
    public int f823d;

    /* JADX INFO: renamed from: e */
    public C0142y f824e;

    public C0105d0() {
        C0125n0 c0125n0 = C0125n0.f873a;
        SessionGenerator$1 sessionGenerator$1 = SessionGenerator$1.INSTANCE;
        Intrinsics.checkNotNullParameter(c0125n0, "timeProvider");
        Intrinsics.checkNotNullParameter(sessionGenerator$1, "uuidGenerator");
        this.f820a = c0125n0;
        this.f821b = sessionGenerator$1;
        this.f822c = m328a();
        this.f823d = -1;
    }

    /* JADX INFO: renamed from: a */
    public final String m328a() {
        String string = ((UUID) this.f821b.invoke()).toString();
        Intrinsics.checkNotNullExpressionValue(string, "uuidGenerator().toString()");
        String lowerCase = wakotl.text.v.t(string, "-", "", false).toLowerCase(Locale.ROOT);
        Intrinsics.checkNotNullExpressionValue(lowerCase, "this as java.lang.String).toLowerCase(Locale.ROOT)");
        return lowerCase;
    }
}
