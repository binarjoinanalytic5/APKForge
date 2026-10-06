package com.google.firebase.messaging;

import android.app.Application;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Binder;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import com.google.android.gms.cloudmessaging.Rpc;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.concurrent.NamedThreadFactory;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import j$.util.Objects;
import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class FirebaseMessaging {

    /* JADX INFO: renamed from: k */
    public static com.facebook.f f648k;

    /* JADX INFO: renamed from: m */
    public static ScheduledThreadPoolExecutor f650m;

    /* JADX INFO: renamed from: a */
    public final ef.h f651a;

    /* JADX INFO: renamed from: b */
    public final Context f652b;

    /* JADX INFO: renamed from: c */
    public final androidx.appcompat.widget.w f653c;

    /* JADX INFO: renamed from: d */
    public final C0074h f654d;

    /* JADX INFO: renamed from: e */
    public final b6.j f655e;

    /* JADX INFO: renamed from: f */
    public final ScheduledThreadPoolExecutor f656f;

    /* JADX INFO: renamed from: g */
    public final ThreadPoolExecutor f657g;

    /* JADX INFO: renamed from: h */
    public final C0082o f658h;

    /* JADX INFO: renamed from: i */
    public boolean f659i;

    /* JADX INFO: renamed from: j */
    public static final long f647j = TimeUnit.HOURS.toSeconds(8);

    /* JADX INFO: renamed from: l */
    public static kg.b f649l = new C0077j(0);

    public FirebaseMessaging(ef.h hVar, kg.b bVar, kg.b bVar2, lg.d dVar, kg.b bVar3, hg.c cVar) {
        final int i = 1;
        final int i2 = 0;
        hVar.a();
        Context context = hVar.a;
        final C0082o c0082o = new C0082o(context);
        final androidx.appcompat.widget.w wVar = new androidx.appcompat.widget.w(hVar, c0082o, bVar, bVar2, dVar);
        ExecutorService executorServiceNewSingleThreadExecutor = Executors.newSingleThreadExecutor(new NamedThreadFactory("Firebase-Messaging-Task"));
        ScheduledThreadPoolExecutor scheduledThreadPoolExecutor = new ScheduledThreadPoolExecutor(1, (ThreadFactory) new NamedThreadFactory("Firebase-Messaging-Init"));
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(0, 1, 30L, TimeUnit.SECONDS, (BlockingQueue<Runnable>) new LinkedBlockingQueue(), (ThreadFactory) new NamedThreadFactory("Firebase-Messaging-File-Io"));
        this.f659i = false;
        f649l = bVar3;
        this.f651a = hVar;
        this.f655e = new b6.j(this, cVar);
        hVar.a();
        final Context context2 = hVar.a;
        this.f652b = context2;
        C0076i c0076i = new C0076i();
        this.f658h = c0082o;
        this.f653c = wVar;
        this.f654d = new C0074h(executorServiceNewSingleThreadExecutor);
        this.f656f = scheduledThreadPoolExecutor;
        this.f657g = threadPoolExecutor;
        hVar.a();
        if (context instanceof Application) {
            ((Application) context).registerActivityLifecycleCallbacks(c0076i);
        } else {
            Objects.toString(context);
        }
        scheduledThreadPoolExecutor.execute(new Runnable(this) { // from class: com.google.firebase.messaging.k

            /* JADX INFO: renamed from: b */
            public final /* synthetic */ FirebaseMessaging f728b;

            {
                this.f728b = this;
            }

            @Override // java.lang.Runnable
            public final void run() {
                switch (i2) {
                    case 0:
                        FirebaseMessaging firebaseMessaging = this.f728b;
                        if (firebaseMessaging.f655e.f() && firebaseMessaging.m244h(firebaseMessaging.m240d())) {
                            synchronized (firebaseMessaging) {
                                if (!firebaseMessaging.f659i) {
                                    firebaseMessaging.m243g(0L);
                                }
                                break;
                            }
                            return;
                        }
                        return;
                    default:
                        FirebaseMessaging firebaseMessaging2 = this.f728b;
                        Context context3 = firebaseMessaging2.f652b;
                        com.bumptech.glide.f.j(context3);
                        boolean zM242f = firebaseMessaging2.m242f();
                        androidx.appcompat.widget.w wVar2 = firebaseMessaging2.f653c;
                        com.facebook.appevents.g.z(context3, wVar2, zM242f);
                        if (firebaseMessaging2.m242f()) {
                            ((Rpc) wVar2.c).getProxiedNotificationData().addOnSuccessListener(firebaseMessaging2.f656f, new C0079l(firebaseMessaging2, 1));
                            return;
                        }
                        return;
                }
            }
        });
        final ScheduledThreadPoolExecutor scheduledThreadPoolExecutor2 = new ScheduledThreadPoolExecutor(1, (ThreadFactory) new NamedThreadFactory("Firebase-Messaging-Topics-Io"));
        int i3 = C0063b0.f685j;
        Tasks.call(scheduledThreadPoolExecutor2, new Callable() { // from class: com.google.firebase.messaging.a0
            @Override // java.util.concurrent.Callable
            public final Object call() {
                C0093z c0093z;
                Context context3 = context2;
                ScheduledThreadPoolExecutor scheduledThreadPoolExecutor3 = scheduledThreadPoolExecutor2;
                FirebaseMessaging firebaseMessaging = this;
                C0082o c0082o2 = c0082o;
                androidx.appcompat.widget.w wVar2 = wVar;
                synchronized (C0093z.class) {
                    try {
                        WeakReference weakReference = C0093z.f772d;
                        c0093z = weakReference != null ? (C0093z) weakReference.get() : null;
                        if (c0093z == null) {
                            C0093z c0093z2 = new C0093z(context3.getSharedPreferences("com.google.android.gms.appid", 0), scheduledThreadPoolExecutor3);
                            c0093z2.m314b();
                            C0093z.f772d = new WeakReference(c0093z2);
                            c0093z = c0093z2;
                        }
                    } catch (Throwable th) {
                        throw th;
                    }
                }
                return new C0063b0(firebaseMessaging, c0082o2, c0093z, wVar2, context3, scheduledThreadPoolExecutor3);
            }
        }).addOnSuccessListener(scheduledThreadPoolExecutor, new C0079l(this, i2));
        scheduledThreadPoolExecutor.execute(new Runnable(this) { // from class: com.google.firebase.messaging.k

            /* JADX INFO: renamed from: b */
            public final /* synthetic */ FirebaseMessaging f728b;

            {
                this.f728b = this;
            }

            @Override // java.lang.Runnable
            public final void run() {
                switch (i) {
                    case 0:
                        FirebaseMessaging firebaseMessaging = this.f728b;
                        if (firebaseMessaging.f655e.f() && firebaseMessaging.m244h(firebaseMessaging.m240d())) {
                            synchronized (firebaseMessaging) {
                                if (!firebaseMessaging.f659i) {
                                    firebaseMessaging.m243g(0L);
                                }
                                break;
                            }
                            return;
                        }
                        return;
                    default:
                        FirebaseMessaging firebaseMessaging2 = this.f728b;
                        Context context3 = firebaseMessaging2.f652b;
                        com.bumptech.glide.f.j(context3);
                        boolean zM242f = firebaseMessaging2.m242f();
                        androidx.appcompat.widget.w wVar2 = firebaseMessaging2.f653c;
                        com.facebook.appevents.g.z(context3, wVar2, zM242f);
                        if (firebaseMessaging2.m242f()) {
                            ((Rpc) wVar2.c).getProxiedNotificationData().addOnSuccessListener(firebaseMessaging2.f656f, new C0079l(firebaseMessaging2, 1));
                            return;
                        }
                        return;
                }
            }
        });
    }

    /* JADX INFO: renamed from: b */
    public static void m237b(long j, Runnable runnable) {
        synchronized (FirebaseMessaging.class) {
            try {
                if (f650m == null) {
                    f650m = new ScheduledThreadPoolExecutor(1, (ThreadFactory) new NamedThreadFactory("TAG"));
                }
                f650m.schedule(runnable, j, TimeUnit.SECONDS);
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: c */
    public static synchronized com.facebook.f m238c(Context context) {
        try {
            if (f648k == null) {
                f648k = new com.facebook.f(context);
            }
        } catch (Throwable th) {
            throw th;
        }
        return f648k;
    }

    @NonNull
    @Keep
    public static synchronized FirebaseMessaging getInstance(@NonNull ef.h hVar) {
        FirebaseMessaging firebaseMessaging;
        firebaseMessaging = (FirebaseMessaging) hVar.b(FirebaseMessaging.class);
        Preconditions.checkNotNull(firebaseMessaging, "Firebase Messaging component is not present");
        return firebaseMessaging;
    }

    /* JADX INFO: renamed from: a */
    public final String m239a() throws IOException {
        Task taskContinueWithTask;
        C0090w c0090wM240d = m240d();
        if (!m244h(c0090wM240d)) {
            return c0090wM240d.f761a;
        }
        String strM271c = C0082o.m271c(this.f651a);
        C0074h c0074h = this.f654d;
        synchronized (c0074h) {
            taskContinueWithTask = (Task) ((androidx.collection.g) c0074h.f718b).get(strM271c);
            if (taskContinueWithTask == null) {
                androidx.appcompat.widget.w wVar = this.f653c;
                taskContinueWithTask = wVar.c(wVar.h(new Bundle(), C0082o.m271c((ef.h) wVar.a), "*")).onSuccessTask(this.f657g, new b(this, 8, strM271c, c0090wM240d)).continueWithTask((ExecutorService) c0074h.f717a, new e(2, c0074h, strM271c));
                ((androidx.collection.g) c0074h.f718b).put(strM271c, taskContinueWithTask);
            }
        }
        try {
            return (String) Tasks.await(taskContinueWithTask);
        } catch (InterruptedException | ExecutionException e) {
            throw new IOException(e);
        }
    }

    /* JADX INFO: renamed from: d */
    public final C0090w m240d() {
        C0090w c0090wM310a;
        com.facebook.f fVarM238c = m238c(this.f652b);
        ef.h hVar = this.f651a;
        hVar.a();
        String strD = "[DEFAULT]".equals(hVar.b) ? "" : hVar.d();
        String strM271c = C0082o.m271c(this.f651a);
        synchronized (fVarM238c) {
            c0090wM310a = C0090w.m310a(fVarM238c.a.getString(strD + "|T|" + strM271c + "|*", null));
        }
        return c0090wM310a;
    }

    /* JADX INFO: renamed from: e */
    public final synchronized void m241e(boolean z) {
        this.f659i = z;
    }

    /* JADX INFO: renamed from: f */
    public final boolean m242f() {
        Context context = this.f652b;
        com.bumptech.glide.f.j(context);
        if (!PlatformVersion.isAtLeastQ()) {
            return false;
        }
        if (!(Binder.getCallingUid() == context.getApplicationInfo().uid)) {
            Log.e("FirebaseMessaging", "error retrieving notification delegate for package " + context.getPackageName());
            return false;
        }
        if (!"com.google.android.gms".equals(ae.a.h((NotificationManager) context.getSystemService(NotificationManager.class)))) {
            return false;
        }
        if (this.f651a.b(gf.a.class) != null) {
            return true;
        }
        return com.bumptech.glide.e.O() && f649l != null;
    }

    /* JADX INFO: renamed from: g */
    public final synchronized void m243g(long j) {
        m237b(j, new RunnableC0091x(this, Math.min(Math.max(30L, 2 * j), f647j)));
        this.f659i = true;
    }

    /* JADX INFO: renamed from: h */
    public final boolean m244h(C0090w c0090w) {
        if (c0090w != null) {
            String strM272a = this.f658h.m272a();
            if (System.currentTimeMillis() <= c0090w.f763c + C0090w.f759d && strM272a.equals(c0090w.f762b)) {
                return false;
            }
        }
        return true;
    }
}
