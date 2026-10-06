package com.google.firebase.messaging;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import java.io.IOException;
import java.util.ArrayDeque;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/* JADX INFO: renamed from: com.google.firebase.messaging.b0 */
/* JADX INFO: loaded from: classes.dex */
public final class C0063b0 {

    /* JADX INFO: renamed from: i */
    public static final long f684i = TimeUnit.HOURS.toSeconds(8);

    /* JADX INFO: renamed from: j */
    public static final /* synthetic */ int f685j = 0;

    /* JADX INFO: renamed from: a */
    public final Context f686a;

    /* JADX INFO: renamed from: b */
    public final C0082o f687b;

    /* JADX INFO: renamed from: c */
    public final androidx.appcompat.widget.w f688c;

    /* JADX INFO: renamed from: d */
    public final FirebaseMessaging f689d;

    /* JADX INFO: renamed from: f */
    public final ScheduledThreadPoolExecutor f691f;

    /* JADX INFO: renamed from: h */
    public final C0093z f693h;

    /* JADX INFO: renamed from: e */
    public final androidx.collection.g f690e = new androidx.collection.g(0);

    /* JADX INFO: renamed from: g */
    public boolean f692g = false;

    public C0063b0(FirebaseMessaging firebaseMessaging, C0082o c0082o, C0093z c0093z, androidx.appcompat.widget.w wVar, Context context, ScheduledThreadPoolExecutor scheduledThreadPoolExecutor) {
        this.f689d = firebaseMessaging;
        this.f687b = c0082o;
        this.f693h = c0093z;
        this.f688c = wVar;
        this.f686a = context;
        this.f691f = scheduledThreadPoolExecutor;
    }

    /* JADX INFO: renamed from: a */
    public static void m248a(Task task) throws IOException {
        try {
            Tasks.await(task, 30L, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            e = e;
            throw new IOException("SERVICE_NOT_AVAILABLE", e);
        } catch (ExecutionException e2) {
            Throwable cause = e2.getCause();
            if (cause instanceof IOException) {
                throw ((IOException) cause);
            }
            if (!(cause instanceof RuntimeException)) {
                throw new IOException(e2);
            }
            throw ((RuntimeException) cause);
        } catch (TimeoutException e3) {
            e = e3;
            throw new IOException("SERVICE_NOT_AVAILABLE", e);
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m249b(String str) throws IOException {
        String strM239a = this.f689d.m239a();
        androidx.appcompat.widget.w wVar = this.f688c;
        wVar.getClass();
        Bundle bundle = new Bundle();
        bundle.putString("gcm.topic", "/topics/" + str);
        m248a(wVar.c(wVar.h(bundle, strM239a, "/topics/" + str)));
    }

    /* JADX INFO: renamed from: c */
    public final void m250c(String str) throws IOException {
        String strM239a = this.f689d.m239a();
        androidx.appcompat.widget.w wVar = this.f688c;
        wVar.getClass();
        Bundle bundle = new Bundle();
        bundle.putString("gcm.topic", "/topics/" + str);
        bundle.putString("delete", "1");
        m248a(wVar.c(wVar.h(bundle, strM239a, "/topics/" + str)));
    }

    /* JADX INFO: renamed from: d */
    public final void m251d(C0092y c0092y) {
        synchronized (this.f690e) {
            try {
                String str = c0092y.f771c;
                if (this.f690e.containsKey(str)) {
                    ArrayDeque arrayDeque = (ArrayDeque) this.f690e.get(str);
                    TaskCompletionSource taskCompletionSource = (TaskCompletionSource) arrayDeque.poll();
                    if (taskCompletionSource != null) {
                        taskCompletionSource.setResult((Object) null);
                    }
                    if (arrayDeque.isEmpty()) {
                        this.f690e.remove(str);
                    }
                }
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: e */
    public final synchronized void m252e(boolean z) {
        this.f692g = z;
    }

    /* JADX WARN: Code duplicated, block: B:24:0x0036  */
    /* JADX INFO: renamed from: f */
    public final boolean m253f() throws IOException {
        C0092y c0092yM313a;
        byte b;
        while (true) {
            synchronized (this) {
                try {
                    c0092yM313a = this.f693h.m313a();
                    if (c0092yM313a == null) {
                        return true;
                    }
                } catch (Throwable th) {
                    throw th;
                }
            }
            try {
                String str = c0092yM313a.f770b;
                int iHashCode = str.hashCode();
                if (iHashCode != 83) {
                    if (iHashCode == 85 && str.equals("U")) {
                        b = 1;
                    } else {
                        b = -1;
                    }
                } else if (str.equals("S")) {
                    b = 0;
                } else {
                    b = -1;
                }
                String str2 = c0092yM313a.f769a;
                if (b == 0) {
                    m249b(str2);
                } else if (b == 1) {
                    m250c(str2);
                }
                this.f693h.m315c(c0092yM313a);
                m251d(c0092yM313a);
            } catch (IOException e) {
                if ("SERVICE_NOT_AVAILABLE".equals(e.getMessage()) || "INTERNAL_SERVER_ERROR".equals(e.getMessage()) || "TOO_MANY_SUBSCRIBERS".equals(e.getMessage())) {
                    Log.e("FirebaseMessaging", "Topic operation failed: " + e.getMessage() + ". Will retry Topic operation.");
                } else {
                    if (e.getMessage() != null) {
                        throw e;
                    }
                    Log.e("FirebaseMessaging", "Topic operation failed without exception message. Will retry Topic operation.");
                }
                return false;
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public final void m254g(long j) {
        long jMin = Math.min(Math.max(30L, 2 * j), f684i);
        this.f691f.schedule(new RunnableC0067d0(this, this.f686a, this.f687b, jMin), j, TimeUnit.SECONDS);
        m252e(true);
    }
}
