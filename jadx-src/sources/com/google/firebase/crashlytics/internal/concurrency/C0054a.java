package com.google.firebase.crashlytics.internal.concurrency;

import com.google.android.gms.tasks.Tasks;
import java.util.concurrent.ExecutorService;
import qf.b;
import qf.c;
import wakotl.jvm.internal.Intrinsics;

/* JADX INFO: renamed from: com.google.firebase.crashlytics.internal.concurrency.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0054a {

    /* JADX INFO: renamed from: d */
    public static final c f609d = new c();

    /* JADX INFO: renamed from: a */
    public final b f610a;

    /* JADX INFO: renamed from: b */
    public final b f611b;

    /* JADX INFO: renamed from: c */
    public final b f612c;

    public C0054a(ExecutorService executorService, ExecutorService executorService2) {
        Intrinsics.checkNotNullParameter(executorService, "backgroundExecutorService");
        Intrinsics.checkNotNullParameter(executorService2, "blockingExecutorService");
        this.f610a = new b(executorService);
        this.f611b = new b(executorService);
        Tasks.forResult((Object) null);
        this.f612c = new b(executorService2);
    }

    /* JADX INFO: renamed from: a */
    public static final void m208a() {
        c.a(new CrashlyticsWorkers$Companion$checkBackgroundThread$1(f609d), CrashlyticsWorkers$Companion$checkBackgroundThread$2.INSTANCE);
    }

    /* JADX INFO: renamed from: b */
    public static final void m209b() {
        c.a(new CrashlyticsWorkers$Companion$checkBlockingThread$1(f609d), CrashlyticsWorkers$Companion$checkBlockingThread$2.INSTANCE);
    }

    /* JADX INFO: renamed from: c */
    public static final void m210c() {
        c.a(new CrashlyticsWorkers$Companion$checkNotMainThread$1(f609d), CrashlyticsWorkers$Companion$checkNotMainThread$2.INSTANCE);
    }
}
