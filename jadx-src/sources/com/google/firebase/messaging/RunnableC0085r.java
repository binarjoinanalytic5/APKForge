package com.google.firebase.messaging;

import android.app.NotificationManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Binder;
import android.util.Log;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: renamed from: com.google.firebase.messaging.r */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class RunnableC0085r implements Runnable {

    /* JADX INFO: renamed from: a */
    public final /* synthetic */ Context f743a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ boolean f744b;

    /* JADX INFO: renamed from: c */
    public final /* synthetic */ TaskCompletionSource f745c;

    public /* synthetic */ RunnableC0085r(Context context, boolean z, TaskCompletionSource taskCompletionSource) {
        this.f743a = context;
        this.f744b = z;
        this.f745c = taskCompletionSource;
    }

    @Override // java.lang.Runnable
    public final void run() {
        Context context = this.f743a;
        TaskCompletionSource taskCompletionSource = this.f745c;
        try {
            if (Binder.getCallingUid() == context.getApplicationInfo().uid) {
                SharedPreferences.Editor editorEdit = com.facebook.appevents.g.n(context).edit();
                editorEdit.putBoolean("proxy_notification_initialized", true);
                editorEdit.apply();
                NotificationManager notificationManager = (NotificationManager) context.getSystemService(NotificationManager.class);
                if (this.f744b) {
                    ae.a.k(notificationManager);
                } else if ("com.google.android.gms".equals(ae.a.h(notificationManager))) {
                    ae.a.v(notificationManager);
                }
            } else {
                Log.e("FirebaseMessaging", "error configuring notification delegate for package " + context.getPackageName());
            }
        } finally {
            taskCompletionSource.trySetResult((Object) null);
        }
    }
}
