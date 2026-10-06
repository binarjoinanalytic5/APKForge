package com.google.firebase.concurrent;

/* JADX INFO: renamed from: com.google.firebase.concurrent.a */
/* JADX INFO: loaded from: classes.dex */
public final class RunnableC0051a implements Runnable {

    /* JADX INFO: renamed from: a */
    public Runnable f574a;

    /* JADX INFO: renamed from: b */
    public final /* synthetic */ ExecutorC0052b f575b;

    public RunnableC0051a(ExecutorC0052b executorC0052b) {
        this.f575b = executorC0052b;
    }

    /* JADX WARN: Code restructure failed: missing block: B:19:0x003d, code lost:
    
        if (r1 == false) goto L51;
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x003f, code lost:
    
        java.lang.Thread.currentThread().interrupt();
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0046, code lost:
    
        return;
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x004c, code lost:
    
        r1 = r1 | java.lang.Thread.interrupted();
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x004e, code lost:
    
        r9.f574a.run();
     */
    /* JADX WARN: Code restructure failed: missing block: B:30:0x0058, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:32:0x005a, code lost:
    
        r3 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:33:0x005b, code lost:
    
        com.google.firebase.concurrent.ExecutorC0052b.f576f.log(java.util.logging.Level.SEVERE, "Exception while executing runnable " + r9.f574a, (java.lang.Throwable) r3);
     */
    /* JADX WARN: Code restructure failed: missing block: B:35:0x0076, code lost:
    
        r9.f574a = null;
     */
    /* JADX WARN: Code restructure failed: missing block: B:36:0x0078, code lost:
    
        throw r0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:51:?, code lost:
    
        return;
     */
    /* JADX INFO: renamed from: a */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public final void m200a() {
        boolean z = false;
        boolean zInterrupted = false;
        while (true) {
            try {
                synchronized (this.f575b.f578b) {
                    if (!z) {
                        ExecutorC0052b executorC0052b = this.f575b;
                        SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState = executorC0052b.f579c;
                        SequentialExecutor$WorkerRunningState sequentialExecutor$WorkerRunningState2 = SequentialExecutor$WorkerRunningState.RUNNING;
                        if (sequentialExecutor$WorkerRunningState != sequentialExecutor$WorkerRunningState2) {
                            executorC0052b.f580d++;
                            executorC0052b.f579c = sequentialExecutor$WorkerRunningState2;
                            z = true;
                        }
                    }
                    Runnable runnable = (Runnable) this.f575b.f578b.poll();
                    this.f574a = runnable;
                    if (runnable == null) {
                        this.f575b.f579c = SequentialExecutor$WorkerRunningState.IDLE;
                    }
                }
                if (zInterrupted) {
                    Thread.currentThread().interrupt();
                    return;
                }
                return;
                this.f574a = null;
            } catch (Throwable th) {
                if (zInterrupted) {
                    Thread.currentThread().interrupt();
                }
                throw th;
            }
        }
    }

    @Override // java.lang.Runnable
    public final void run() {
        try {
            m200a();
        } catch (Error e) {
            synchronized (this.f575b.f578b) {
                this.f575b.f579c = SequentialExecutor$WorkerRunningState.IDLE;
                throw e;
            }
        }
    }

    public final String toString() {
        Runnable runnable = this.f574a;
        if (runnable != null) {
            return "SequentialExecutorWorker{running=" + runnable + "}";
        }
        return "SequentialExecutorWorker{state=" + this.f575b.f579c + "}";
    }
}
