.class public final Lcom/google/firebase/concurrent/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public a:Ljava/lang/Runnable;

.field public final synthetic b:Lcom/google/firebase/concurrent/b;


# direct methods
.method public constructor <init>(Lcom/google/firebase/concurrent/b;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    iput-object p1, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 5
    .line 6
    return-void
.end method


# virtual methods
.method public final a()V
    .locals 9

    .line 1
    const/4 v0, 0x0

    .line 2
    move v1, v0

    .line 3
    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 4
    .line 5
    iget-object v2, v2, Lcom/google/firebase/concurrent/b;->b:Ljava/util/ArrayDeque;

    .line 6
    .line 7
    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 8
    if-nez v0, :cond_2

    .line 9
    .line 10
    :try_start_1
    iget-object v0, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 11
    .line 12
    iget-object v3, v0, Lcom/google/firebase/concurrent/b;->c:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 13
    .line 14
    sget-object v4, Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;->RUNNING:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 15
    .line 16
    if-ne v3, v4, :cond_1

    .line 17
    .line 18
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 19
    if-eqz v1, :cond_0

    .line 20
    .line 21
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 26
    .line 27
    .line 28
    :cond_0
    return-void

    .line 29
    :catchall_0
    move-exception v0

    .line 30
    goto :goto_3

    .line 31
    :cond_1
    :try_start_2
    iget-wide v5, v0, Lcom/google/firebase/concurrent/b;->d:J

    .line 32
    .line 33
    const-wide/16 v7, 0x1

    .line 34
    .line 35
    add-long/2addr v5, v7

    .line 36
    iput-wide v5, v0, Lcom/google/firebase/concurrent/b;->d:J

    .line 37
    .line 38
    iput-object v4, v0, Lcom/google/firebase/concurrent/b;->c:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 39
    .line 40
    const/4 v0, 0x1

    .line 41
    :cond_2
    iget-object v3, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 42
    .line 43
    iget-object v3, v3, Lcom/google/firebase/concurrent/b;->b:Ljava/util/ArrayDeque;

    .line 44
    .line 45
    invoke-virtual {v3}, Ljava/util/ArrayDeque;->poll()Ljava/lang/Object;

    .line 46
    .line 47
    .line 48
    move-result-object v3

    .line 49
    check-cast v3, Ljava/lang/Runnable;

    .line 50
    .line 51
    iput-object v3, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;

    .line 52
    .line 53
    if-nez v3, :cond_4

    .line 54
    .line 55
    iget-object v0, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 56
    .line 57
    sget-object v3, Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;->IDLE:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 58
    .line 59
    iput-object v3, v0, Lcom/google/firebase/concurrent/b;->c:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 60
    .line 61
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 62
    if-eqz v1, :cond_3

    .line 63
    .line 64
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    .line 65
    .line 66
    .line 67
    move-result-object v0

    .line 68
    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 69
    .line 70
    .line 71
    :cond_3
    return-void

    .line 72
    :cond_4
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 73
    :try_start_4
    invoke-static {}, Ljava/lang/Thread;->interrupted()Z

    .line 74
    .line 75
    .line 76
    move-result v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 77
    or-int/2addr v1, v2

    .line 78
    const/4 v2, 0x0

    .line 79
    :try_start_5
    iget-object v3, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;

    .line 80
    .line 81
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 82
    .line 83
    .line 84
    :goto_1
    :try_start_6
    iput-object v2, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 85
    .line 86
    goto :goto_0

    .line 87
    :catchall_1
    move-exception v0

    .line 88
    goto :goto_4

    .line 89
    :catchall_2
    move-exception v0

    .line 90
    goto :goto_2

    .line 91
    :catch_0
    move-exception v3

    .line 92
    :try_start_7
    sget-object v4, Lcom/google/firebase/concurrent/b;->f:Ljava/util/logging/Logger;

    .line 93
    .line 94
    sget-object v5, Ljava/util/logging/Level;->SEVERE:Ljava/util/logging/Level;

    .line 95
    .line 96
    new-instance v6, Ljava/lang/StringBuilder;

    .line 97
    .line 98
    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 99
    .line 100
    .line 101
    const-string v7, "Exception while executing runnable "

    .line 102
    .line 103
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 104
    .line 105
    .line 106
    iget-object v7, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;

    .line 107
    .line 108
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 109
    .line 110
    .line 111
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 112
    .line 113
    .line 114
    move-result-object v6

    .line 115
    invoke-virtual {v4, v5, v6, v3}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 116
    .line 117
    .line 118
    goto :goto_1

    .line 119
    :goto_2
    :try_start_8
    iput-object v2, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;

    .line 120
    .line 121
    throw v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 122
    :goto_3
    :try_start_9
    monitor-exit v2
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 123
    :try_start_a
    throw v0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 124
    :goto_4
    if-eqz v1, :cond_5

    .line 125
    .line 126
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    .line 127
    .line 128
    .line 129
    move-result-object v1

    .line 130
    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    .line 131
    .line 132
    .line 133
    :cond_5
    throw v0
.end method

.method public final run()V
    .locals 4

    .line 1
    :try_start_0
    invoke-virtual {p0}, Lcom/google/firebase/concurrent/a;->a()V
    :try_end_0
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0

    .line 2
    .line 3
    .line 4
    return-void

    .line 5
    :catch_0
    move-exception v0

    .line 6
    iget-object v1, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 7
    .line 8
    iget-object v1, v1, Lcom/google/firebase/concurrent/b;->b:Ljava/util/ArrayDeque;

    .line 9
    .line 10
    monitor-enter v1

    .line 11
    :try_start_1
    iget-object v2, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 12
    .line 13
    sget-object v3, Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;->IDLE:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 14
    .line 15
    iput-object v3, v2, Lcom/google/firebase/concurrent/b;->c:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 16
    .line 17
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 18
    throw v0

    .line 19
    :catchall_0
    move-exception v0

    .line 20
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 21
    throw v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    .line 1
    iget-object v0, p0, Lcom/google/firebase/concurrent/a;->a:Ljava/lang/Runnable;

    .line 2
    .line 3
    const-string v1, "}"

    .line 4
    .line 5
    if-eqz v0, :cond_0

    .line 6
    .line 7
    new-instance v2, Ljava/lang/StringBuilder;

    .line 8
    .line 9
    const-string v3, "SequentialExecutorWorker{running="

    .line 10
    .line 11
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 12
    .line 13
    .line 14
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 15
    .line 16
    .line 17
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 18
    .line 19
    .line 20
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 21
    .line 22
    .line 23
    move-result-object v0

    .line 24
    return-object v0

    .line 25
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    .line 26
    .line 27
    const-string v2, "SequentialExecutorWorker{state="

    .line 28
    .line 29
    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 30
    .line 31
    .line 32
    iget-object v2, p0, Lcom/google/firebase/concurrent/a;->b:Lcom/google/firebase/concurrent/b;

    .line 33
    .line 34
    iget-object v2, v2, Lcom/google/firebase/concurrent/b;->c:Lcom/google/firebase/concurrent/SequentialExecutor$WorkerRunningState;

    .line 35
    .line 36
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 37
    .line 38
    .line 39
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 40
    .line 41
    .line 42
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 43
    .line 44
    .line 45
    move-result-object v0

    .line 46
    return-object v0
.end method
