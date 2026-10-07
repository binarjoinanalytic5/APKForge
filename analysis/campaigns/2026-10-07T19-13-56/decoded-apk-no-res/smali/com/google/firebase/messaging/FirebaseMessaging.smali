.class public Lcom/google/firebase/messaging/FirebaseMessaging;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final j:J

.field public static k:Lcom/facebook/f;

.field public static l:Lkg/b;

.field public static m:Ljava/util/concurrent/ScheduledThreadPoolExecutor;


# instance fields
.field public final a:Lef/h;

.field public final b:Landroid/content/Context;

.field public final c:Landroidx/appcompat/widget/w;

.field public final d:Lcom/google/firebase/messaging/h;

.field public final e:Lb6/j;

.field public final f:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

.field public final g:Ljava/util/concurrent/ThreadPoolExecutor;

.field public final h:Lcom/google/firebase/messaging/o;

.field public i:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    sget-object v0, Ljava/util/concurrent/TimeUnit;->HOURS:Ljava/util/concurrent/TimeUnit;

    .line 2
    .line 3
    const-wide/16 v1, 0x8

    .line 4
    .line 5
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    .line 6
    .line 7
    .line 8
    move-result-wide v0

    .line 9
    sput-wide v0, Lcom/google/firebase/messaging/FirebaseMessaging;->j:J

    .line 10
    .line 11
    new-instance v0, Lcom/google/firebase/messaging/j;

    .line 12
    .line 13
    const/4 v1, 0x0

    .line 14
    invoke-direct {v0, v1}, Lcom/google/firebase/messaging/j;-><init>(I)V

    .line 15
    .line 16
    .line 17
    sput-object v0, Lcom/google/firebase/messaging/FirebaseMessaging;->l:Lkg/b;

    .line 18
    .line 19
    return-void
.end method

.method public constructor <init>(Lef/h;Lkg/b;Lkg/b;Llg/d;Lkg/b;Lhg/c;)V
    .locals 21

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v7, p1

    .line 4
    .line 5
    const/4 v8, 0x1

    .line 6
    const/4 v9, 0x0

    .line 7
    new-instance v10, Lcom/google/firebase/messaging/o;

    .line 8
    .line 9
    invoke-virtual/range {p1 .. p1}, Lef/h;->a()V

    .line 10
    .line 11
    .line 12
    iget-object v11, v7, Lef/h;->a:Landroid/content/Context;

    .line 13
    .line 14
    invoke-direct {v10, v11}, Lcom/google/firebase/messaging/o;-><init>(Landroid/content/Context;)V

    .line 15
    .line 16
    .line 17
    new-instance v12, Landroidx/appcompat/widget/w;

    .line 18
    .line 19
    move-object v1, v12

    .line 20
    move-object/from16 v2, p1

    .line 21
    .line 22
    move-object v3, v10

    .line 23
    move-object/from16 v4, p2

    .line 24
    .line 25
    move-object/from16 v5, p3

    .line 26
    .line 27
    move-object/from16 v6, p4

    .line 28
    .line 29
    invoke-direct/range {v1 .. v6}, Landroidx/appcompat/widget/w;-><init>(Lef/h;Lcom/google/firebase/messaging/o;Lkg/b;Lkg/b;Llg/d;)V

    .line 30
    .line 31
    .line 32
    new-instance v1, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;

    .line 33
    .line 34
    const-string v2, "Firebase-Messaging-Task"

    .line 35
    .line 36
    invoke-direct {v1, v2}, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;-><init>(Ljava/lang/String;)V

    .line 37
    .line 38
    .line 39
    invoke-static {v1}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    .line 40
    .line 41
    .line 42
    move-result-object v1

    .line 43
    new-instance v2, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 44
    .line 45
    new-instance v3, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;

    .line 46
    .line 47
    const-string v4, "Firebase-Messaging-Init"

    .line 48
    .line 49
    invoke-direct {v3, v4}, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;-><init>(Ljava/lang/String;)V

    .line 50
    .line 51
    .line 52
    invoke-direct {v2, v8, v3}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(ILjava/util/concurrent/ThreadFactory;)V

    .line 53
    .line 54
    .line 55
    new-instance v3, Ljava/util/concurrent/ThreadPoolExecutor;

    .line 56
    .line 57
    sget-object v18, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 58
    .line 59
    new-instance v19, Ljava/util/concurrent/LinkedBlockingQueue;

    .line 60
    .line 61
    invoke-direct/range {v19 .. v19}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    .line 62
    .line 63
    .line 64
    new-instance v4, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;

    .line 65
    .line 66
    const-string v5, "Firebase-Messaging-File-Io"

    .line 67
    .line 68
    invoke-direct {v4, v5}, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;-><init>(Ljava/lang/String;)V

    .line 69
    .line 70
    .line 71
    const/4 v15, 0x1

    .line 72
    const-wide/16 v16, 0x1e

    .line 73
    .line 74
    const/4 v14, 0x0

    .line 75
    move-object v13, v3

    .line 76
    move-object/from16 v20, v4

    .line 77
    .line 78
    invoke-direct/range {v13 .. v20}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    .line 79
    .line 80
    .line 81
    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 82
    .line 83
    .line 84
    iput-boolean v9, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->i:Z

    .line 85
    .line 86
    sput-object p5, Lcom/google/firebase/messaging/FirebaseMessaging;->l:Lkg/b;

    .line 87
    .line 88
    iput-object v7, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->a:Lef/h;

    .line 89
    .line 90
    new-instance v4, Lb6/j;

    .line 91
    .line 92
    move-object/from16 v5, p6

    .line 93
    .line 94
    invoke-direct {v4, v0, v5}, Lb6/j;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;Lhg/c;)V

    .line 95
    .line 96
    .line 97
    iput-object v4, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->e:Lb6/j;

    .line 98
    .line 99
    invoke-virtual/range {p1 .. p1}, Lef/h;->a()V

    .line 100
    .line 101
    .line 102
    iget-object v4, v7, Lef/h;->a:Landroid/content/Context;

    .line 103
    .line 104
    iput-object v4, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->b:Landroid/content/Context;

    .line 105
    .line 106
    new-instance v5, Lcom/google/firebase/messaging/i;

    .line 107
    .line 108
    invoke-direct {v5}, Lcom/google/firebase/messaging/i;-><init>()V

    .line 109
    .line 110
    .line 111
    iput-object v10, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->h:Lcom/google/firebase/messaging/o;

    .line 112
    .line 113
    iput-object v12, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->c:Landroidx/appcompat/widget/w;

    .line 114
    .line 115
    new-instance v6, Lcom/google/firebase/messaging/h;

    .line 116
    .line 117
    invoke-direct {v6, v1}, Lcom/google/firebase/messaging/h;-><init>(Ljava/util/concurrent/ExecutorService;)V

    .line 118
    .line 119
    .line 120
    iput-object v6, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->d:Lcom/google/firebase/messaging/h;

    .line 121
    .line 122
    iput-object v2, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->f:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 123
    .line 124
    iput-object v3, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->g:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 125
    .line 126
    invoke-virtual/range {p1 .. p1}, Lef/h;->a()V

    .line 127
    .line 128
    .line 129
    instance-of v1, v11, Landroid/app/Application;

    .line 130
    .line 131
    if-eqz v1, :cond_0

    .line 132
    .line 133
    check-cast v11, Landroid/app/Application;

    .line 134
    .line 135
    invoke-virtual {v11, v5}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 136
    .line 137
    .line 138
    goto :goto_0

    .line 139
    :cond_0
    invoke-static {v11}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 140
    .line 141
    .line 142
    :goto_0
    new-instance v1, Lcom/google/firebase/messaging/k;

    .line 143
    .line 144
    invoke-direct {v1, v0, v9}, Lcom/google/firebase/messaging/k;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;I)V

    .line 145
    .line 146
    .line 147
    invoke-virtual {v2, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 148
    .line 149
    .line 150
    new-instance v1, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 151
    .line 152
    new-instance v3, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;

    .line 153
    .line 154
    const-string v5, "Firebase-Messaging-Topics-Io"

    .line 155
    .line 156
    invoke-direct {v3, v5}, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;-><init>(Ljava/lang/String;)V

    .line 157
    .line 158
    .line 159
    invoke-direct {v1, v8, v3}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(ILjava/util/concurrent/ThreadFactory;)V

    .line 160
    .line 161
    .line 162
    sget v3, Lcom/google/firebase/messaging/b0;->j:I

    .line 163
    .line 164
    new-instance v3, Lcom/google/firebase/messaging/a0;

    .line 165
    .line 166
    move-object/from16 p1, v3

    .line 167
    .line 168
    move-object/from16 p2, v4

    .line 169
    .line 170
    move-object/from16 p3, v1

    .line 171
    .line 172
    move-object/from16 p4, p0

    .line 173
    .line 174
    move-object/from16 p5, v10

    .line 175
    .line 176
    move-object/from16 p6, v12

    .line 177
    .line 178
    invoke-direct/range {p1 .. p6}, Lcom/google/firebase/messaging/a0;-><init>(Landroid/content/Context;Ljava/util/concurrent/ScheduledThreadPoolExecutor;Lcom/google/firebase/messaging/FirebaseMessaging;Lcom/google/firebase/messaging/o;Landroidx/appcompat/widget/w;)V

    .line 179
    .line 180
    .line 181
    invoke-static {v1, v3}, Lcom/google/android/gms/tasks/Tasks;->call(Ljava/util/concurrent/Executor;Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    .line 182
    .line 183
    .line 184
    move-result-object v1

    .line 185
    new-instance v3, Lcom/google/firebase/messaging/l;

    .line 186
    .line 187
    invoke-direct {v3, v0, v9}, Lcom/google/firebase/messaging/l;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;I)V

    .line 188
    .line 189
    .line 190
    invoke-virtual {v1, v2, v3}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    .line 191
    .line 192
    .line 193
    new-instance v1, Lcom/google/firebase/messaging/k;

    .line 194
    .line 195
    invoke-direct {v1, v0, v8}, Lcom/google/firebase/messaging/k;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;I)V

    .line 196
    .line 197
    .line 198
    invoke-virtual {v2, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 199
    .line 200
    .line 201
    return-void
.end method

.method public static b(JLjava/lang/Runnable;)V
    .locals 4

    .line 1
    const-class v0, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    sget-object v1, Lcom/google/firebase/messaging/FirebaseMessaging;->m:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 5
    .line 6
    if-nez v1, :cond_0

    .line 7
    .line 8
    new-instance v1, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 9
    .line 10
    new-instance v2, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;

    .line 11
    .line 12
    const-string v3, "TAG"

    .line 13
    .line 14
    invoke-direct {v2, v3}, Lcom/google/android/gms/common/util/concurrent/NamedThreadFactory;-><init>(Ljava/lang/String;)V

    .line 15
    .line 16
    .line 17
    const/4 v3, 0x1

    .line 18
    invoke-direct {v1, v3, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(ILjava/util/concurrent/ThreadFactory;)V

    .line 19
    .line 20
    .line 21
    sput-object v1, Lcom/google/firebase/messaging/FirebaseMessaging;->m:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 22
    .line 23
    goto :goto_0

    .line 24
    :catchall_0
    move-exception p0

    .line 25
    goto :goto_1

    .line 26
    :cond_0
    :goto_0
    sget-object v1, Lcom/google/firebase/messaging/FirebaseMessaging;->m:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 27
    .line 28
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 29
    .line 30
    invoke-virtual {v1, p2, p0, p1, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    .line 31
    .line 32
    .line 33
    monitor-exit v0

    .line 34
    return-void

    .line 35
    :goto_1
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 36
    throw p0
.end method

.method public static declared-synchronized c(Landroid/content/Context;)Lcom/facebook/f;
    .locals 2

    .line 1
    const-class v0, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    sget-object v1, Lcom/google/firebase/messaging/FirebaseMessaging;->k:Lcom/facebook/f;

    .line 5
    .line 6
    if-nez v1, :cond_0

    .line 7
    .line 8
    new-instance v1, Lcom/facebook/f;

    .line 9
    .line 10
    invoke-direct {v1, p0}, Lcom/facebook/f;-><init>(Landroid/content/Context;)V

    .line 11
    .line 12
    .line 13
    sput-object v1, Lcom/google/firebase/messaging/FirebaseMessaging;->k:Lcom/facebook/f;

    .line 14
    .line 15
    goto :goto_0

    .line 16
    :catchall_0
    move-exception p0

    .line 17
    goto :goto_1

    .line 18
    :cond_0
    :goto_0
    sget-object p0, Lcom/google/firebase/messaging/FirebaseMessaging;->k:Lcom/facebook/f;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 19
    .line 20
    monitor-exit v0

    .line 21
    return-object p0

    .line 22
    :goto_1
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 23
    throw p0
.end method

.method public static declared-synchronized getInstance(Lef/h;)Lcom/google/firebase/messaging/FirebaseMessaging;
    .locals 2
    .param p0    # Lef/h;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroidx/annotation/Keep;
    .end annotation

    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    .line 1
    const-class v0, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    const-class v1, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 5
    .line 6
    invoke-virtual {p0, v1}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 7
    .line 8
    .line 9
    move-result-object p0

    .line 10
    check-cast p0, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 11
    .line 12
    const-string v1, "Firebase Messaging component is not present"

    .line 13
    .line 14
    invoke-static {p0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 15
    .line 16
    .line 17
    monitor-exit v0

    .line 18
    return-object p0

    .line 19
    :catchall_0
    move-exception p0

    .line 20
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 21
    throw p0
.end method


# virtual methods
.method public final a()Ljava/lang/String;
    .locals 7

    .line 1
    invoke-virtual {p0}, Lcom/google/firebase/messaging/FirebaseMessaging;->d()Lcom/google/firebase/messaging/w;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    invoke-virtual {p0, v0}, Lcom/google/firebase/messaging/FirebaseMessaging;->h(Lcom/google/firebase/messaging/w;)Z

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    if-nez v1, :cond_0

    .line 10
    .line 11
    iget-object v0, v0, Lcom/google/firebase/messaging/w;->a:Ljava/lang/String;

    .line 12
    .line 13
    return-object v0

    .line 14
    :cond_0
    iget-object v1, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->a:Lef/h;

    .line 15
    .line 16
    invoke-static {v1}, Lcom/google/firebase/messaging/o;->c(Lef/h;)Ljava/lang/String;

    .line 17
    .line 18
    .line 19
    move-result-object v1

    .line 20
    iget-object v2, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->d:Lcom/google/firebase/messaging/h;

    .line 21
    .line 22
    monitor-enter v2

    .line 23
    :try_start_0
    iget-object v3, v2, Lcom/google/firebase/messaging/h;->b:Ljava/lang/Object;

    .line 24
    .line 25
    check-cast v3, Landroidx/collection/g;

    .line 26
    .line 27
    invoke-virtual {v3, v1}, Landroidx/collection/c0;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 28
    .line 29
    .line 30
    move-result-object v3

    .line 31
    check-cast v3, Lcom/google/android/gms/tasks/Task;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 32
    .line 33
    if-eqz v3, :cond_1

    .line 34
    .line 35
    monitor-exit v2

    .line 36
    goto :goto_0

    .line 37
    :cond_1
    :try_start_1
    iget-object v3, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->c:Landroidx/appcompat/widget/w;

    .line 38
    .line 39
    iget-object v4, v3, Landroidx/appcompat/widget/w;->a:Ljava/lang/Object;

    .line 40
    .line 41
    check-cast v4, Lef/h;

    .line 42
    .line 43
    invoke-static {v4}, Lcom/google/firebase/messaging/o;->c(Lef/h;)Ljava/lang/String;

    .line 44
    .line 45
    .line 46
    move-result-object v4

    .line 47
    new-instance v5, Landroid/os/Bundle;

    .line 48
    .line 49
    invoke-direct {v5}, Landroid/os/Bundle;-><init>()V

    .line 50
    .line 51
    .line 52
    const-string v6, "*"

    .line 53
    .line 54
    invoke-virtual {v3, v5, v4, v6}, Landroidx/appcompat/widget/w;->h(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;

    .line 55
    .line 56
    .line 57
    move-result-object v4

    .line 58
    invoke-virtual {v3, v4}, Landroidx/appcompat/widget/w;->c(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    .line 59
    .line 60
    .line 61
    move-result-object v3

    .line 62
    new-instance v4, Lb;

    .line 63
    .line 64
    const/16 v5, 0x8

    .line 65
    .line 66
    invoke-direct {v4, p0, v5, v1, v0}, Lb;-><init>(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Object;)V

    .line 67
    .line 68
    .line 69
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->g:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 70
    .line 71
    invoke-virtual {v3, v0, v4}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    .line 72
    .line 73
    .line 74
    move-result-object v0

    .line 75
    iget-object v3, v2, Lcom/google/firebase/messaging/h;->a:Ljava/lang/Object;

    .line 76
    .line 77
    check-cast v3, Ljava/util/concurrent/ExecutorService;

    .line 78
    .line 79
    new-instance v4, Le;

    .line 80
    .line 81
    const/4 v5, 0x2

    .line 82
    invoke-direct {v4, v5, v2, v1}, Le;-><init>(ILjava/lang/Object;Ljava/lang/Object;)V

    .line 83
    .line 84
    .line 85
    invoke-virtual {v0, v3, v4}, Lcom/google/android/gms/tasks/Task;->continueWithTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    .line 86
    .line 87
    .line 88
    move-result-object v3

    .line 89
    iget-object v0, v2, Lcom/google/firebase/messaging/h;->b:Ljava/lang/Object;

    .line 90
    .line 91
    check-cast v0, Landroidx/collection/g;

    .line 92
    .line 93
    invoke-virtual {v0, v1, v3}, Landroidx/collection/c0;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 94
    .line 95
    .line 96
    monitor-exit v2

    .line 97
    :goto_0
    :try_start_2
    invoke-static {v3}, Lcom/google/android/gms/tasks/Tasks;->await(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;

    .line 98
    .line 99
    .line 100
    move-result-object v0

    .line 101
    check-cast v0, Ljava/lang/String;
    :try_end_2
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0

    .line 102
    .line 103
    return-object v0

    .line 104
    :catch_0
    move-exception v0

    .line 105
    goto :goto_1

    .line 106
    :catch_1
    move-exception v0

    .line 107
    :goto_1
    new-instance v1, Ljava/io/IOException;

    .line 108
    .line 109
    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    .line 110
    .line 111
    .line 112
    throw v1

    .line 113
    :catchall_0
    move-exception v0

    .line 114
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 115
    throw v0
.end method

.method public final d()Lcom/google/firebase/messaging/w;
    .locals 5

    .line 1
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->b:Landroid/content/Context;

    .line 2
    .line 3
    invoke-static {v0}, Lcom/google/firebase/messaging/FirebaseMessaging;->c(Landroid/content/Context;)Lcom/facebook/f;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    iget-object v1, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->a:Lef/h;

    .line 8
    .line 9
    invoke-virtual {v1}, Lef/h;->a()V

    .line 10
    .line 11
    .line 12
    const-string v2, "[DEFAULT]"

    .line 13
    .line 14
    iget-object v3, v1, Lef/h;->b:Ljava/lang/String;

    .line 15
    .line 16
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 17
    .line 18
    .line 19
    move-result v2

    .line 20
    if-eqz v2, :cond_0

    .line 21
    .line 22
    const-string v1, ""

    .line 23
    .line 24
    goto :goto_0

    .line 25
    :cond_0
    invoke-virtual {v1}, Lef/h;->d()Ljava/lang/String;

    .line 26
    .line 27
    .line 28
    move-result-object v1

    .line 29
    :goto_0
    iget-object v2, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->a:Lef/h;

    .line 30
    .line 31
    invoke-static {v2}, Lcom/google/firebase/messaging/o;->c(Lef/h;)Ljava/lang/String;

    .line 32
    .line 33
    .line 34
    move-result-object v2

    .line 35
    monitor-enter v0

    .line 36
    :try_start_0
    iget-object v3, v0, Lcom/facebook/f;->a:Landroid/content/SharedPreferences;

    .line 37
    .line 38
    new-instance v4, Ljava/lang/StringBuilder;

    .line 39
    .line 40
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 41
    .line 42
    .line 43
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 44
    .line 45
    .line 46
    const-string v1, "|T|"

    .line 47
    .line 48
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 49
    .line 50
    .line 51
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 52
    .line 53
    .line 54
    const-string v1, "|*"

    .line 55
    .line 56
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    .line 58
    .line 59
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 60
    .line 61
    .line 62
    move-result-object v1

    .line 63
    const/4 v2, 0x0

    .line 64
    invoke-interface {v3, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 65
    .line 66
    .line 67
    move-result-object v1

    .line 68
    invoke-static {v1}, Lcom/google/firebase/messaging/w;->a(Ljava/lang/String;)Lcom/google/firebase/messaging/w;

    .line 69
    .line 70
    .line 71
    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 72
    monitor-exit v0

    .line 73
    return-object v1

    .line 74
    :catchall_0
    move-exception v1

    .line 75
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 76
    throw v1
.end method

.method public final declared-synchronized e(Z)V
    .locals 0

    .line 1
    monitor-enter p0

    .line 2
    :try_start_0
    iput-boolean p1, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->i:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3
    .line 4
    monitor-exit p0

    .line 5
    return-void

    .line 6
    :catchall_0
    move-exception p1

    .line 7
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 8
    throw p1
.end method

.method public final f()Z
    .locals 5

    .line 1
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->b:Landroid/content/Context;

    .line 2
    .line 3
    invoke-static {v0}, Lcom/bumptech/glide/f;->j(Landroid/content/Context;)V

    .line 4
    .line 5
    .line 6
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastQ()Z

    .line 7
    .line 8
    .line 9
    move-result v1

    .line 10
    const/4 v2, 0x0

    .line 11
    if-nez v1, :cond_0

    .line 12
    .line 13
    goto :goto_1

    .line 14
    :cond_0
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    .line 15
    .line 16
    .line 17
    move-result v1

    .line 18
    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    .line 19
    .line 20
    .line 21
    move-result-object v3

    .line 22
    iget v3, v3, Landroid/content/pm/ApplicationInfo;->uid:I

    .line 23
    .line 24
    const/4 v4, 0x1

    .line 25
    if-ne v1, v3, :cond_1

    .line 26
    .line 27
    move v1, v4

    .line 28
    goto :goto_0

    .line 29
    :cond_1
    move v1, v2

    .line 30
    :goto_0
    if-nez v1, :cond_2

    .line 31
    .line 32
    new-instance v1, Ljava/lang/StringBuilder;

    .line 33
    .line 34
    const-string v3, "error retrieving notification delegate for package "

    .line 35
    .line 36
    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 37
    .line 38
    .line 39
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    .line 40
    .line 41
    .line 42
    move-result-object v0

    .line 43
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 44
    .line 45
    .line 46
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 47
    .line 48
    .line 49
    move-result-object v0

    .line 50
    const-string v1, "FirebaseMessaging"

    .line 51
    .line 52
    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    .line 54
    .line 55
    goto :goto_1

    .line 56
    :cond_2
    const-class v1, Landroid/app/NotificationManager;

    .line 57
    .line 58
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    .line 59
    .line 60
    .line 61
    move-result-object v0

    .line 62
    check-cast v0, Landroid/app/NotificationManager;

    .line 63
    .line 64
    invoke-static {v0}, Lae/a;->h(Landroid/app/NotificationManager;)Ljava/lang/String;

    .line 65
    .line 66
    .line 67
    move-result-object v0

    .line 68
    const-string v1, "com.google.android.gms"

    .line 69
    .line 70
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 71
    .line 72
    .line 73
    move-result v0

    .line 74
    if-eqz v0, :cond_4

    .line 75
    .line 76
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->a:Lef/h;

    .line 77
    .line 78
    const-class v1, Lgf/a;

    .line 79
    .line 80
    invoke-virtual {v0, v1}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 81
    .line 82
    .line 83
    move-result-object v0

    .line 84
    if-eqz v0, :cond_3

    .line 85
    .line 86
    return v4

    .line 87
    :cond_3
    invoke-static {}, Lcom/bumptech/glide/e;->O()Z

    .line 88
    .line 89
    .line 90
    move-result v0

    .line 91
    if-eqz v0, :cond_4

    .line 92
    .line 93
    sget-object v0, Lcom/google/firebase/messaging/FirebaseMessaging;->l:Lkg/b;

    .line 94
    .line 95
    if-eqz v0, :cond_4

    .line 96
    .line 97
    move v2, v4

    .line 98
    :cond_4
    :goto_1
    return v2
.end method

.method public final declared-synchronized g(J)V
    .locals 4

    .line 1
    monitor-enter p0

    .line 2
    const-wide/16 v0, 0x2

    .line 3
    .line 4
    mul-long/2addr v0, p1

    .line 5
    const-wide/16 v2, 0x1e

    .line 6
    .line 7
    :try_start_0
    invoke-static {v2, v3, v0, v1}, Ljava/lang/Math;->max(JJ)J

    .line 8
    .line 9
    .line 10
    move-result-wide v0

    .line 11
    sget-wide v2, Lcom/google/firebase/messaging/FirebaseMessaging;->j:J

    .line 12
    .line 13
    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    .line 14
    .line 15
    .line 16
    move-result-wide v0

    .line 17
    new-instance v2, Lcom/google/firebase/messaging/x;

    .line 18
    .line 19
    invoke-direct {v2, p0, v0, v1}, Lcom/google/firebase/messaging/x;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;J)V

    .line 20
    .line 21
    .line 22
    invoke-static {p1, p2, v2}, Lcom/google/firebase/messaging/FirebaseMessaging;->b(JLjava/lang/Runnable;)V

    .line 23
    .line 24
    .line 25
    const/4 p1, 0x1

    .line 26
    iput-boolean p1, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->i:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 27
    .line 28
    monitor-exit p0

    .line 29
    return-void

    .line 30
    :catchall_0
    move-exception p1

    .line 31
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 32
    throw p1
.end method

.method public final h(Lcom/google/firebase/messaging/w;)Z
    .locals 7

    .line 1
    if-eqz p1, :cond_1

    .line 2
    .line 3
    iget-object v0, p0, Lcom/google/firebase/messaging/FirebaseMessaging;->h:Lcom/google/firebase/messaging/o;

    .line 4
    .line 5
    invoke-virtual {v0}, Lcom/google/firebase/messaging/o;->a()Ljava/lang/String;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 10
    .line 11
    .line 12
    move-result-wide v1

    .line 13
    iget-wide v3, p1, Lcom/google/firebase/messaging/w;->c:J

    .line 14
    .line 15
    sget-wide v5, Lcom/google/firebase/messaging/w;->d:J

    .line 16
    .line 17
    add-long/2addr v3, v5

    .line 18
    cmp-long v1, v1, v3

    .line 19
    .line 20
    if-gtz v1, :cond_1

    .line 21
    .line 22
    iget-object p1, p1, Lcom/google/firebase/messaging/w;->b:Ljava/lang/String;

    .line 23
    .line 24
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 25
    .line 26
    .line 27
    move-result p1

    .line 28
    if-nez p1, :cond_0

    .line 29
    .line 30
    goto :goto_0

    .line 31
    :cond_0
    const/4 p1, 0x0

    .line 32
    goto :goto_1

    .line 33
    :cond_1
    :goto_0
    const/4 p1, 0x1

    .line 34
    :goto_1
    return p1
.end method
