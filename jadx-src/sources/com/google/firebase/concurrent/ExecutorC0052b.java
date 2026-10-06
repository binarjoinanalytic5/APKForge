package com.google.firebase.concurrent;

import com.google.android.gms.common.internal.Preconditions;
import hb.o;
import java.util.ArrayDeque;
import java.util.concurrent.Executor;
import java.util.concurrent.RejectedExecutionException;
import java.util.logging.Logger;

/* JADX INFO: renamed from: com.google.firebase.concurrent.b */
/* JADX INFO: loaded from: classes.dex */
public final class ExecutorC0052b implements Executor {

    /* JADX INFO: renamed from: f */
    public static final Logger f576f = Logger.getLogger(ExecutorC0052b.class.getName());

    /* JADX INFO: renamed from: a */
    public final Executor f577a;

    /* JADX INFO: renamed from: b */
    public final ArrayDeque f578b = new ArrayDeque();

    /* JADX INFO: renamed from: c */
    public SequentialExecutor$WorkerRunningState f579c = SequentialExecutor$WorkerRunningState.IDLE;

    /* JADX INFO: renamed from: d */
    public long f580d = 0;

    /* JADX INFO: renamed from: e */
    public final RunnableC0051a f581e = new RunnableC0051a(this);

    public ExecutorC0052b(Executor executor) {
        this.f577a = (Executor) Preconditions.checkNotNull(executor);
    }

    /* JADX WARN: Code duplicated, block: B:43:0x0062  */
    @Override // java.util.concurrent.Executor
    public final void execute(Runnable runnable) {
        SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState;
        boolean z;
        Preconditions.checkNotNull(runnable);
        synchronized (this.f578b) {
            SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState2 = this.f579c;
            if (sequentialExecutor$WorkerRunningState2 != SequentialExecutor$WorkerRunningState.RUNNING && sequentialExecutor$WorkerRunningState2 != (sequentialExecutor$WorkerRunningState = SequentialExecutor$WorkerRunningState.QUEUED)) {
                long j = this.f580d;
                o oVar = new o(runnable, 2);
                this.f578b.add(oVar);
                SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState3 = SequentialExecutor$WorkerRunningState.QUEUING;
                this.f579c = sequentialExecutor$WorkerRunningState3;
                try {
                    this.f577a.execute(this.f581e);
                    if (this.f579c != sequentialExecutor$WorkerRunningState3) {
                        return;
                    }
                    synchronized (this.f578b) {
                        try {
                            if (this.f580d == j && this.f579c == sequentialExecutor$WorkerRunningState3) {
                                this.f579c = sequentialExecutor$WorkerRunningState;
                            }
                        } catch (Throwable th) {
                            throw th;
                        }
                    }
                    return;
                } catch (Error | RuntimeException e) {
                    synchronized (this.f578b) {
                        try {
                            SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState4 = this.f579c;
                            if (sequentialExecutor$WorkerRunningState4 != SequentialExecutor$WorkerRunningState.IDLE && sequentialExecutor$WorkerRunningState4 != SequentialExecutor$WorkerRunningState.QUEUING) {
                                z = false;
                            } else if (this.f578b.removeLastOccurrence(oVar)) {
                                z = true;
                            } else {
                                z = false;
                            }
                            if (!(e instanceof RejectedExecutionException) || z) {
                                throw e;
                            }
                        } catch (Throwable th2) {
                            throw th2;
                        }
                    }
                    return;
                }
            }
            this.f578b.add(runnable);
        }
    }

    public final String toString() {
        return "SequentialExecutor@" + System.identityHashCode(this) + "{" + this.f577a + "}";
    }
}
