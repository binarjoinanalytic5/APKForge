package com.google.firebase.sessions;

import android.os.Message;
import java.util.Comparator;

/* JADX INFO: renamed from: com.google.firebase.sessions.g0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0111g0 implements Comparator {
    @Override // java.util.Comparator
    public final int compare(Object obj, Object obj2) {
        return rp.a.a(Long.valueOf(((Message) obj).getWhen()), Long.valueOf(((Message) obj2).getWhen()));
    }
}
