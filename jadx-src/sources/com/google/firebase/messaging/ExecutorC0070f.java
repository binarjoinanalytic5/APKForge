package com.google.firebase.messaging;

import java.util.concurrent.Executor;

/* JADX INFO: renamed from: com.google.firebase.messaging.f */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class ExecutorC0070f implements Executor {
    @Override // java.util.concurrent.Executor
    public final void execute(Runnable runnable) {
        runnable.run();
    }
}
