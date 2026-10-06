.class public final Lcom/google/firebase/crashlytics/internal/settings/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Landroid/content/Context;

.field public final b:Lxf/c;

.field public final c:Lkotlinx/serialization/json/internal/o;

.field public final d:Ll3/c;

.field public final e:Lkotlinx/serialization/json/internal/o;

.field public final f:Lkotlinx/serialization/json/internal/c0;

.field public final g:Lpf/s;

.field public final h:Ljava/util/concurrent/atomic/AtomicReference;

.field public final i:Ljava/util/concurrent/atomic/AtomicReference;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lxf/c;Ll3/c;Lkotlinx/serialization/json/internal/o;Lkotlinx/serialization/json/internal/o;Lkotlinx/serialization/json/internal/c0;Lpf/s;)V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    .line 5
    .line 6
    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 7
    .line 8
    .line 9
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->h:Ljava/util/concurrent/atomic/AtomicReference;

    .line 10
    .line 11
    new-instance v1, Ljava/util/concurrent/atomic/AtomicReference;

    .line 12
    .line 13
    new-instance v2, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 14
    .line 15
    invoke-direct {v2}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 16
    .line 17
    .line 18
    invoke-direct {v1, v2}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    .line 19
    .line 20
    .line 21
    iput-object v1, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->i:Ljava/util/concurrent/atomic/AtomicReference;

    .line 22
    .line 23
    iput-object p1, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->a:Landroid/content/Context;

    .line 24
    .line 25
    iput-object p2, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->b:Lxf/c;

    .line 26
    .line 27
    iput-object p3, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->d:Ll3/c;

    .line 28
    .line 29
    iput-object p4, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->c:Lkotlinx/serialization/json/internal/o;

    .line 30
    .line 31
    iput-object p5, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->e:Lkotlinx/serialization/json/internal/o;

    .line 32
    .line 33
    iput-object p6, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->f:Lkotlinx/serialization/json/internal/c0;

    .line 34
    .line 35
    iput-object p7, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->g:Lpf/s;

    .line 36
    .line 37
    invoke-static {p3}, Lt3/h;->c(Ll3/c;)Lxf/b;

    .line 38
    .line 39
    .line 40
    move-result-object p1

    .line 41
    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 42
    .line 43
    .line 44
    return-void
.end method


# virtual methods
.method public final a(Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;)Lxf/b;
    .locals 7

    .line 1
    const/4 v0, 0x0

    .line 2
    :try_start_0
    sget-object v1, Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;->SKIP_CACHE_LOOKUP:Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;

    .line 3
    .line 4
    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 5
    .line 6
    .line 7
    move-result v1

    .line 8
    if-nez v1, :cond_1

    .line 9
    .line 10
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->e:Lkotlinx/serialization/json/internal/o;

    .line 11
    .line 12
    invoke-virtual {v1}, Lkotlinx/serialization/json/internal/o;->O()Lorg/json/JSONObject;

    .line 13
    .line 14
    .line 15
    move-result-object v1

    .line 16
    if-eqz v1, :cond_1

    .line 17
    .line 18
    iget-object v2, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->c:Lkotlinx/serialization/json/internal/o;

    .line 19
    .line 20
    invoke-virtual {v2, v1}, Lkotlinx/serialization/json/internal/o;->N(Lorg/json/JSONObject;)Lxf/b;

    .line 21
    .line 22
    .line 23
    move-result-object v2

    .line 24
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    .line 25
    .line 26
    .line 27
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->d:Ll3/c;

    .line 28
    .line 29
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 30
    .line 31
    .line 32
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 33
    .line 34
    .line 35
    move-result-wide v3

    .line 36
    sget-object v1, Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;->IGNORE_CACHE_EXPIRATION:Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;

    .line 37
    .line 38
    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 39
    .line 40
    .line 41
    move-result p1

    .line 42
    if-nez p1, :cond_0

    .line 43
    .line 44
    iget-wide v5, v2, Lxf/b;->c:J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 45
    .line 46
    cmp-long p1, v5, v3

    .line 47
    .line 48
    if-gez p1, :cond_0

    .line 49
    .line 50
    goto :goto_0

    .line 51
    :cond_0
    move-object v0, v2

    .line 52
    goto :goto_0

    .line 53
    :catch_0
    move-exception p1

    .line 54
    const-string v1, "Failed to get cached settings"

    .line 55
    .line 56
    const-string v2, "FirebaseCrashlytics"

    .line 57
    .line 58
    invoke-static {v2, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 59
    .line 60
    .line 61
    :cond_1
    :goto_0
    return-object v0
.end method

.method public final b()Lxf/b;
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->h:Ljava/util/concurrent/atomic/AtomicReference;

    .line 2
    .line 3
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    check-cast v0, Lxf/b;

    .line 8
    .line 9
    return-object v0
.end method

.method public final c(Lcom/google/firebase/crashlytics/internal/concurrency/a;)Lcom/google/android/gms/tasks/Task;
    .locals 4

    .line 1
    sget-object v0, Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;->USE_CACHE:Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;

    .line 2
    .line 3
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->a:Landroid/content/Context;

    .line 4
    .line 5
    const-string v2, "com.google.firebase.crashlytics"

    .line 6
    .line 7
    const/4 v3, 0x0

    .line 8
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    .line 9
    .line 10
    .line 11
    move-result-object v1

    .line 12
    const-string v2, "existing_instance_identifier"

    .line 13
    .line 14
    const-string v3, ""

    .line 15
    .line 16
    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 17
    .line 18
    .line 19
    move-result-object v1

    .line 20
    iget-object v2, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->b:Lxf/c;

    .line 21
    .line 22
    iget-object v2, v2, Lxf/c;->f:Ljava/lang/String;

    .line 23
    .line 24
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 25
    .line 26
    .line 27
    move-result v1

    .line 28
    iget-object v2, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->i:Ljava/util/concurrent/atomic/AtomicReference;

    .line 29
    .line 30
    iget-object v3, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->h:Ljava/util/concurrent/atomic/AtomicReference;

    .line 31
    .line 32
    if-eqz v1, :cond_0

    .line 33
    .line 34
    invoke-virtual {p0, v0}, Lcom/google/firebase/crashlytics/internal/settings/a;->a(Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;)Lxf/b;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    if-eqz v0, :cond_0

    .line 39
    .line 40
    invoke-virtual {v3, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 41
    .line 42
    .line 43
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    .line 44
    .line 45
    .line 46
    move-result-object p1

    .line 47
    check-cast p1, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 48
    .line 49
    invoke-virtual {p1, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 50
    .line 51
    .line 52
    const/4 p1, 0x0

    .line 53
    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 54
    .line 55
    .line 56
    move-result-object p1

    .line 57
    goto :goto_0

    .line 58
    :cond_0
    sget-object v0, Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;->IGNORE_CACHE_EXPIRATION:Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;

    .line 59
    .line 60
    invoke-virtual {p0, v0}, Lcom/google/firebase/crashlytics/internal/settings/a;->a(Lcom/google/firebase/crashlytics/internal/settings/SettingsCacheBehavior;)Lxf/b;

    .line 61
    .line 62
    .line 63
    move-result-object v0

    .line 64
    if-eqz v0, :cond_1

    .line 65
    .line 66
    invoke-virtual {v3, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 67
    .line 68
    .line 69
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    .line 70
    .line 71
    .line 72
    move-result-object v1

    .line 73
    check-cast v1, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 74
    .line 75
    invoke-virtual {v1, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 76
    .line 77
    .line 78
    :cond_1
    iget-object v0, p0, Lcom/google/firebase/crashlytics/internal/settings/a;->g:Lpf/s;

    .line 79
    .line 80
    iget-object v1, v0, Lpf/s;->g:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 81
    .line 82
    invoke-virtual {v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 83
    .line 84
    .line 85
    move-result-object v1

    .line 86
    iget-object v2, v0, Lpf/s;->c:Ljava/lang/Object;

    .line 87
    .line 88
    monitor-enter v2

    .line 89
    :try_start_0
    iget-object v0, v0, Lpf/s;->d:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 90
    .line 91
    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 92
    .line 93
    .line 94
    move-result-object v0

    .line 95
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 96
    invoke-static {v1, v0}, Lqf/a;->a(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    .line 97
    .line 98
    .line 99
    move-result-object v0

    .line 100
    iget-object v1, p1, Lcom/google/firebase/crashlytics/internal/concurrency/a;->a:Lqf/b;

    .line 101
    .line 102
    new-instance v2, Landroidx/work/impl/model/l;

    .line 103
    .line 104
    const/4 v3, 0x0

    .line 105
    invoke-direct {v2, p0, p1, v3}, Landroidx/work/impl/model/l;-><init>(Ljava/lang/Object;Ljava/lang/Object;Z)V

    .line 106
    .line 107
    .line 108
    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    .line 109
    .line 110
    .line 111
    move-result-object p1

    .line 112
    :goto_0
    return-object p1

    .line 113
    :catchall_0
    move-exception p1

    .line 114
    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 115
    throw p1
.end method
