package com.google.firebase.messaging;

import android.content.Context;
import android.content.Intent;
import android.util.Base64;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import java.util.concurrent.ExecutorService;

/* JADX INFO: renamed from: com.google.firebase.messaging.h */
/* JADX INFO: loaded from: classes.dex */
public final class C0074h {

    /* JADX INFO: renamed from: c */
    public static final Object f715c = new Object();

    /* JADX INFO: renamed from: d */
    public static ServiceConnectionC0075h0 f716d;

    /* JADX INFO: renamed from: a */
    public final Object f717a;

    /* JADX INFO: renamed from: b */
    public final Object f718b;

    public C0074h(ExecutorService executorService) {
        this.f718b = new androidx.collection.g(0);
        this.f717a = executorService;
    }

    /* JADX INFO: renamed from: a */
    public static Task m264a(Context context, Intent intent, boolean z) {
        ServiceConnectionC0075h0 serviceConnectionC0075h0;
        synchronized (f715c) {
            try {
                if (f716d == null) {
                    f716d = new ServiceConnectionC0075h0(context);
                }
                serviceConnectionC0075h0 = f716d;
            } catch (Throwable th) {
                throw th;
            }
        }
        if (!z) {
            return serviceConnectionC0075h0.m267b(intent).continueWith(new androidx.arch.core.executor.a(2), new androidx.core.view.h(14));
        }
        if (C0088u.m290c().m294e(context)) {
            AbstractC0069e0.m261b(context, serviceConnectionC0075h0, intent);
        } else {
            serviceConnectionC0075h0.m267b(intent);
        }
        return Tasks.forResult(-1);
    }

    /* JADX INFO: renamed from: b */
    public Task m265b(final Intent intent) {
        String stringExtra = intent.getStringExtra("gcm.rawData64");
        if (stringExtra != null) {
            intent.putExtra("rawData", Base64.decode(stringExtra, 0));
            intent.removeExtra("gcm.rawData64");
        }
        boolean zIsAtLeastO = PlatformVersion.isAtLeastO();
        final Context context = (Context) this.f717a;
        boolean z = zIsAtLeastO && context.getApplicationInfo().targetSdkVersion >= 26;
        final boolean z2 = (intent.getFlags() & 268435456) != 0;
        if (z && !z2) {
            return m264a(context, intent, z2);
        }
        androidx.arch.core.executor.a aVar = (androidx.arch.core.executor.a) this.f718b;
        return Tasks.call(aVar, new androidx.work.impl.b0(3, context, intent)).continueWithTask(aVar, new Continuation() { // from class: com.google.firebase.messaging.g
            public final Object then(Task task) {
                if (!PlatformVersion.isAtLeastO() || ((Integer) task.getResult()).intValue() != 402) {
                    return task;
                }
                return C0074h.m264a(context, intent, z2).continueWith(new ExecutorC0070f(), new com.google.android.material.internal.i(2));
            }
        });
    }

    public C0074h(Context context) {
        this.f717a = context;
        this.f718b = new androidx.arch.core.executor.a(2);
    }
}
