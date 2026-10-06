package com.google.firebase.sessions;

import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import androidx.constraintlayout.widget.ConstraintLayout;
import wakotl.Metadata;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: loaded from: classes.dex */
@Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0004\b\u0000\u0018\u00002\u00020\u0001:\u0001\u0004B\u0007¢\u0006\u0004\b\u0002\u0010\u0003¨\u0006\u0005"}, d2 = {"Lcom/google/firebase/sessions/SessionLifecycleService;", "Landroid/app/Service;", "<init>", "()V", "com/google/firebase/sessions/j0", "com.google.firebase-firebase-sessions"}, k = 1, mv = {1, 8, 0}, xi = ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE)
public final class SessionLifecycleService extends Service {

    /* JADX INFO: renamed from: a */
    public final HandlerThread f778a = new HandlerThread("FirebaseSessions_HandlerThread");

    /* JADX INFO: renamed from: b */
    public HandlerC0117j0 f779b;

    /* JADX INFO: renamed from: c */
    public Messenger f780c;

    @Override // android.app.Service
    public final IBinder onBind(Intent intent) {
        if (intent == null) {
            return null;
        }
        intent.getAction();
        Messenger messenger = Build.VERSION.SDK_INT >= 33 ? (Messenger) androidx.appcompat.app.c0.k(intent) : (Messenger) intent.getParcelableExtra("ClientCallbackMessenger");
        if (messenger != null) {
            Message messageObtain = Message.obtain(null, 4, 0, 0);
            messageObtain.replyTo = messenger;
            HandlerC0117j0 handlerC0117j0 = this.f779b;
            if (handlerC0117j0 != null) {
                handlerC0117j0.sendMessage(messageObtain);
            }
        }
        Messenger messenger2 = this.f780c;
        if (messenger2 != null) {
            return messenger2.getBinder();
        }
        return null;
    }

    @Override // android.app.Service
    public final void onCreate() {
        super.onCreate();
        HandlerThread handlerThread = this.f778a;
        handlerThread.start();
        Looper looper = handlerThread.getLooper();
        Intrinsics.checkNotNullExpressionValue(looper, "handlerThread.looper");
        this.f779b = new HandlerC0117j0(looper);
        this.f780c = new Messenger(this.f779b);
    }

    @Override // android.app.Service
    public final void onDestroy() {
        super.onDestroy();
        this.f778a.quit();
    }
}
