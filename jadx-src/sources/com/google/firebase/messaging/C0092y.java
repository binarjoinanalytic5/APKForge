package com.google.firebase.messaging;

import com.google.android.gms.common.internal.Objects;
import java.util.regex.Pattern;

/* JADX INFO: renamed from: com.google.firebase.messaging.y */
/* JADX INFO: loaded from: classes.dex */
public final class C0092y {

    /* JADX INFO: renamed from: d */
    public static final Pattern f768d = Pattern.compile("[a-zA-Z0-9-_.~%]{1,900}");

    /* JADX INFO: renamed from: a */
    public final String f769a;

    /* JADX INFO: renamed from: b */
    public final String f770b;

    /* JADX INFO: renamed from: c */
    public final String f771c;

    public C0092y(String str, String str2) {
        String strSubstring = (str2 == null || !str2.startsWith("/topics/")) ? str2 : str2.substring(8);
        if (strSubstring == null || !f768d.matcher(strSubstring).matches()) {
            throw new IllegalArgumentException(a1.a.o("Invalid topic name: ", strSubstring, " does not match the allowed format [a-zA-Z0-9-_.~%]{1,900}."));
        }
        this.f769a = strSubstring;
        this.f770b = str;
        this.f771c = a1.a.D(str, "!", str2);
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof C0092y)) {
            return false;
        }
        C0092y c0092y = (C0092y) obj;
        return this.f769a.equals(c0092y.f769a) && this.f770b.equals(c0092y.f770b);
    }

    public final int hashCode() {
        return Objects.hashCode(new Object[]{this.f770b, this.f769a});
    }
}
