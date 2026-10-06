package com.google.firebase.messaging;

import android.os.Binder;
import android.os.Process;
import androidx.appcompat.widget.w0;

/* JADX INFO: renamed from: com.google.firebase.messaging.f0 */
/* JADX INFO: loaded from: classes.dex */
public final class BinderC0071f0 extends Binder {

    /* JADX INFO: renamed from: a */
    public final w0 f709a;

    public BinderC0071f0(w0 w0Var) {
        this.f709a = w0Var;
    }

    /* JADX INFO: renamed from: a */
    public final void m263a(C0073g0 c0073g0) {
        if (Binder.getCallingUid() != Process.myUid()) {
            throw new SecurityException("Binding only allowed within app");
        }
        ((EnhancedIntentService) this.f709a.b).m236b(c0073g0.f713a).addOnCompleteListener(new androidx.arch.core.executor.a(2), new f(c0073g0, 4));
    }
}
