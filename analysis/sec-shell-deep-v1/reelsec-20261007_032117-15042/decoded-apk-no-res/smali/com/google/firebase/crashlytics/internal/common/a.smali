.class public final Lcom/google/firebase/crashlytics/internal/common/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final s:Lcom/facebook/internal/f1;


# instance fields
.field public final a:Landroid/content/Context;

.field public final b:Lpf/s;

.field public final c:Landroidx/work/impl/model/l;

.field public final d:Lvf/c;

.field public final e:Lcom/google/firebase/crashlytics/internal/concurrency/a;

.field public final f:Lpf/x;

.field public final g:Lvf/c;

.field public final h:Landroidx/work/impl/w;

.field public final i:Lrf/f;

.field public final j:Lmf/c;

.field public final k:Llf/a;

.field public final l:Lpf/j;

.field public final m:Lvf/c;

.field public n:Lpf/r;

.field public final o:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field public final p:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field public final q:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field public final r:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/facebook/internal/f1;

    .line 2
    .line 3
    const/4 v1, 0x2

    .line 4
    invoke-direct {v0, v1}, Lcom/facebook/internal/f1;-><init>(I)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/google/firebase/crashlytics/internal/common/a;->s:Lcom/facebook/internal/f1;

    .line 8
    .line 9
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lpf/x;Lpf/s;Lvf/c;Landroidx/work/impl/model/l;Landroidx/work/impl/w;Lvf/c;Lrf/f;Lvf/c;Lmf/c;Llf/a;Lpf/j;Lcom/google/firebase/crashlytics/internal/concurrency/a;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 5
    .line 6
    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 7
    .line 8
    .line 9
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 10
    .line 11
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 12
    .line 13
    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 14
    .line 15
    .line 16
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->p:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 17
    .line 18
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 19
    .line 20
    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 21
    .line 22
    .line 23
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->q:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 24
    .line 25
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 26
    .line 27
    const/4 v1, 0x0

    .line 28
    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 29
    .line 30
    .line 31
    iput-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->r:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 32
    .line 33
    iput-object p1, p0, Lcom/google/firebase/crashlytics/internal/common/a;->a:Landroid/content/Context;

    .line 34
    .line 35
    iput-object p2, p0, Lcom/google/firebase/crashlytics/internal/common/a;->f:Lpf/x;

    .line 36
    .line 37
    iput-object p3, p0, Lcom/google/firebase/crashlytics/internal/common/a;->b:Lpf/s;

    .line 38
    .line 39
    iput-object p4, p0, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    .line 40
    .line 41
    iput-object p5, p0, Lcom/google/firebase/crashlytics/internal/common/a;->c:Landroidx/work/impl/model/l;

    .line 42
    .line 43
    iput-object p6, p0, Lcom/google/firebase/crashlytics/internal/common/a;->h:Landroidx/work/impl/w;

    .line 44
    .line 45
    iput-object p7, p0, Lcom/google/firebase/crashlytics/internal/common/a;->d:Lvf/c;

    .line 46
    .line 47
    iput-object p8, p0, Lcom/google/firebase/crashlytics/internal/common/a;->i:Lrf/f;

    .line 48
    .line 49
    iput-object p10, p0, Lcom/google/firebase/crashlytics/internal/common/a;->j:Lmf/c;

    .line 50
    .line 51
    iput-object p11, p0, Lcom/google/firebase/crashlytics/internal/common/a;->k:Llf/a;

    .line 52
    .line 53
    iput-object p12, p0, Lcom/google/firebase/crashlytics/internal/common/a;->l:Lpf/j;

    .line 54
    .line 55
    iput-object p9, p0, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 56
    .line 57
    iput-object p13, p0, Lcom/google/firebase/crashlytics/internal/common/a;->e:Lcom/google/firebase/crashlytics/internal/concurrency/a;

    .line 58
    .line 59
    return-void
.end method

.method public static a(Lcom/google/firebase/crashlytics/internal/common/a;)Lcom/google/android/gms/tasks/Task;
    .locals 7

    .line 1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    new-instance v0, Ljava/util/ArrayList;

    .line 5
    .line 6
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 7
    .line 8
    .line 9
    sget-object v1, Lcom/google/firebase/crashlytics/internal/common/a;->s:Lcom/facebook/internal/f1;

    .line 10
    .line 11
    iget-object v2, p0, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    .line 12
    .line 13
    iget-object v2, v2, Lvf/c;->c:Ljava/lang/Object;

    .line 14
    .line 15
    check-cast v2, Ljava/io/File;

    .line 16
    .line 17
    invoke-virtual {v2, v1}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    .line 18
    .line 19
    .line 20
    move-result-object v1

    .line 21
    invoke-static {v1}, Lvf/c;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 22
    .line 23
    .line 24
    move-result-object v1

    .line 25
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    .line 26
    .line 27
    .line 28
    move-result-object v1

    .line 29
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 30
    .line 31
    .line 32
    move-result v2

    .line 33
    if-eqz v2, :cond_0

    .line 34
    .line 35
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 36
    .line 37
    .line 38
    move-result-object v2

    .line 39
    check-cast v2, Ljava/io/File;

    .line 40
    .line 41
    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    .line 42
    .line 43
    .line 44
    move-result-object v3

    .line 45
    const/4 v4, 0x3

    .line 46
    invoke-virtual {v3, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 47
    .line 48
    .line 49
    move-result-object v3

    .line 50
    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    .line 51
    .line 52
    .line 53
    move-result-wide v3
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 54
    :try_start_1
    const-string v5, "com.google.firebase.crash.FirebaseCrash"

    .line 55
    .line 56
    invoke-static {v5}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    .line 57
    .line 58
    .line 59
    const/4 v3, 0x0

    .line 60
    :try_start_2
    invoke-static {v3}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 61
    .line 62
    .line 63
    move-result-object v3

    .line 64
    goto :goto_1

    .line 65
    :catch_0
    new-instance v5, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 66
    .line 67
    const/4 v6, 0x1

    .line 68
    invoke-direct {v5, v6}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(I)V

    .line 69
    .line 70
    .line 71
    new-instance v6, Lpf/m;

    .line 72
    .line 73
    invoke-direct {v6, p0, v3, v4}, Lpf/m;-><init>(Lcom/google/firebase/crashlytics/internal/common/a;J)V

    .line 74
    .line 75
    .line 76
    invoke-static {v5, v6}, Lcom/google/android/gms/tasks/Tasks;->call(Ljava/util/concurrent/Executor;Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    .line 77
    .line 78
    .line 79
    move-result-object v3

    .line 80
    :goto_1
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_1

    .line 81
    .line 82
    .line 83
    goto :goto_2

    .line 84
    :catch_1
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    .line 85
    .line 86
    .line 87
    :goto_2
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 88
    .line 89
    .line 90
    goto :goto_0

    .line 91
    :cond_0
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->whenAll(Ljava/util/Collection;)Lcom/google/android/gms/tasks/Task;

    .line 92
    .line 93
    .line 94
    move-result-object p0

    .line 95
    return-object p0
.end method


# virtual methods
.method public final b(ZLcom/google/firebase/crashlytics/internal/settings/a;Z)V
    .locals 22

    move-object/from16 v1, p0

    move/from16 v2, p1

    const/4 v3, 0x0

    const/4 v4, 0x1

    .line 1
    invoke-static {}, Lcom/google/firebase/crashlytics/internal/concurrency/a;->a()V

    .line 2
    new-instance v5, Ljava/util/ArrayList;

    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 3
    iget-object v0, v0, Lvf/c;->b:Ljava/lang/Object;

    check-cast v0, Lvf/a;

    .line 4
    invoke-virtual {v0}, Lvf/a;->c()Ljava/util/NavigableSet;

    move-result-object v0

    .line 5
    invoke-direct {v5, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 6
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gt v0, v2, :cond_0

    return-void

    .line 7
    :cond_0
    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Ljava/lang/String;

    if-eqz p3, :cond_e

    .line 8
    invoke-virtual/range {p2 .. p2}, Lcom/google/firebase/crashlytics/internal/settings/a;->b()Lxf/b;

    move-result-object v0

    iget-object v0, v0, Lxf/b;->b:Lj6/h;

    iget-boolean v0, v0, Lj6/h;->b:Z

    if-eqz v0, :cond_e

    .line 9
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0x1e

    if-lt v0, v9, :cond_e

    .line 10
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->a:Landroid/content/Context;

    const-string v9, "activity"

    .line 11
    invoke-virtual {v0, v9}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 12
    invoke-static {v0}, Landroidx/core/view/h0;->l(Landroid/app/ActivityManager;)Ljava/util/List;

    move-result-object v0

    .line 13
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v9

    if-eqz v9, :cond_e

    .line 14
    new-instance v9, Lrf/f;

    iget-object v10, v1, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    .line 15
    invoke-direct {v9, v10}, Lrf/f;-><init>(Lvf/c;)V

    .line 16
    sget-object v11, Lrf/f;->c:Ll3/c;

    invoke-interface {v11}, Lrf/d;->a()V

    .line 17
    iput-object v11, v9, Lrf/f;->b:Lrf/d;

    if-nez v6, :cond_1

    goto :goto_0

    .line 18
    :cond_1
    const-string v11, "userlog"

    invoke-virtual {v10, v6, v11}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v10

    .line 19
    new-instance v11, Lrf/n;

    invoke-direct {v11, v10}, Lrf/n;-><init>(Ljava/io/File;)V

    iput-object v11, v9, Lrf/f;->b:Lrf/d;

    .line 20
    :goto_0
    iget-object v10, v1, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    iget-object v11, v1, Lcom/google/firebase/crashlytics/internal/common/a;->e:Lcom/google/firebase/crashlytics/internal/concurrency/a;

    .line 21
    new-instance v12, Lrf/h;

    invoke-direct {v12, v10}, Lrf/h;-><init>(Lvf/c;)V

    .line 22
    new-instance v13, Lvf/c;

    invoke-direct {v13, v6, v10, v11}, Lvf/c;-><init>(Ljava/lang/String;Lvf/c;Lcom/google/firebase/crashlytics/internal/concurrency/a;)V

    .line 23
    iget-object v11, v13, Lvf/c;->d:Ljava/lang/Object;

    check-cast v11, Lb6/j;

    iget-object v11, v11, Lb6/j;->b:Ljava/lang/Object;

    check-cast v11, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-virtual {v11}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lrf/e;

    invoke-virtual {v12, v6, v3}, Lrf/h;->c(Ljava/lang/String;Z)Ljava/util/Map;

    move-result-object v14

    invoke-virtual {v11, v14}, Lrf/e;->d(Ljava/util/Map;)V

    .line 24
    iget-object v11, v13, Lvf/c;->e:Ljava/lang/Object;

    check-cast v11, Lb6/j;

    iget-object v11, v11, Lb6/j;->b:Ljava/lang/Object;

    check-cast v11, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-virtual {v11}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lrf/e;

    invoke-virtual {v12, v6, v4}, Lrf/h;->c(Ljava/lang/String;Z)Ljava/util/Map;

    move-result-object v14

    invoke-virtual {v11, v14}, Lrf/e;->d(Ljava/util/Map;)V

    .line 25
    iget-object v11, v13, Lvf/c;->g:Ljava/lang/Object;

    check-cast v11, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-virtual {v12, v6}, Lrf/h;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12, v3}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 26
    iget-object v11, v13, Lvf/c;->f:Ljava/lang/Object;

    check-cast v11, Lcom/facebook/appevents/p;

    .line 27
    const-string v12, "Failed to close rollouts state file."

    .line 28
    const-string v14, "rollouts-state"

    invoke-virtual {v10, v6, v14}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v10

    .line 29
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v14

    move-object/from16 v16, v5

    const-wide/16 v4, 0x0

    if-eqz v14, :cond_3

    invoke-virtual {v10}, Ljava/io/File;->length()J

    move-result-wide v17

    cmp-long v14, v17, v4

    if-nez v14, :cond_2

    goto :goto_3

    .line 30
    :cond_2
    :try_start_0
    new-instance v14, Ljava/io/FileInputStream;

    invoke-direct {v14, v10}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 31
    :try_start_1
    invoke-static {v14}, Lpf/g;->j(Ljava/io/FileInputStream;)Ljava/lang/String;

    move-result-object v17

    invoke-static/range {v17 .. v17}, Lrf/h;->b(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v17

    .line 32
    invoke-virtual/range {v17 .. v17}, Ljava/lang/Object;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 33
    invoke-static {v14, v12}, Lpf/g;->b(Ljava/io/Closeable;Ljava/lang/String;)V

    :goto_1
    move-object/from16 v10, v17

    goto :goto_4

    :catchall_0
    move-exception v0

    move-object v8, v14

    goto :goto_2

    :catchall_1
    move-exception v0

    const/4 v8, 0x0

    goto :goto_2

    :catch_0
    const/4 v14, 0x0

    .line 34
    :catch_1
    :try_start_2
    invoke-static {v10}, Lrf/h;->f(Ljava/io/File;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 35
    invoke-static {v14, v12}, Lpf/g;->b(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 36
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v17

    goto :goto_1

    .line 37
    :goto_2
    invoke-static {v8, v12}, Lpf/g;->b(Ljava/io/Closeable;Ljava/lang/String;)V

    .line 38
    throw v0

    .line 39
    :cond_3
    :goto_3
    new-instance v12, Ljava/lang/StringBuilder;

    const-string v14, "The file has a length of zero for session: "

    invoke-direct {v12, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v10, v12}, Lrf/h;->g(Ljava/io/File;Ljava/lang/String;)V

    .line 40
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v17

    goto :goto_1

    .line 41
    :goto_4
    monitor-enter v11

    .line 42
    :try_start_3
    iget-object v12, v11, Lcom/facebook/appevents/p;->c:Ljava/lang/Object;

    check-cast v12, Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->clear()V

    .line 43
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v12

    iget v14, v11, Lcom/facebook/appevents/p;->b:I

    if-le v12, v14, :cond_4

    .line 44
    invoke-interface {v10, v3, v14}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v10

    .line 45
    iget-object v12, v11, Lcom/facebook/appevents/p;->c:Ljava/lang/Object;

    check-cast v12, Ljava/util/ArrayList;

    invoke-virtual {v12, v10}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    monitor-exit v11

    goto :goto_5

    :catchall_2
    move-exception v0

    goto/16 :goto_d

    .line 46
    :cond_4
    :try_start_4
    iget-object v12, v11, Lcom/facebook/appevents/p;->c:Ljava/lang/Object;

    check-cast v12, Ljava/util/ArrayList;

    invoke-virtual {v12, v10}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    monitor-exit v11

    .line 47
    :goto_5
    iget-object v10, v1, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 48
    iget-object v11, v10, Lvf/c;->b:Ljava/lang/Object;

    check-cast v11, Lvf/a;

    .line 49
    iget-object v12, v11, Lvf/a;->b:Lvf/c;

    .line 50
    const-string v14, "start-time"

    .line 51
    invoke-virtual {v12, v6, v14}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v12

    .line 52
    invoke-virtual {v12}, Ljava/io/File;->lastModified()J

    move-result-wide v17

    .line 53
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    invoke-static {v12}, Landroidx/core/view/h0;->d(Ljava/lang/Object;)Landroid/app/ApplicationExitInfo;

    move-result-object v12

    .line 54
    invoke-static {v12}, Landroidx/core/view/h0;->c(Landroid/app/ApplicationExitInfo;)J

    move-result-wide v19

    cmp-long v14, v19, v17

    if-gez v14, :cond_6

    :cond_5
    const/4 v12, 0x0

    goto :goto_7

    .line 55
    :cond_6
    invoke-static {v12}, Landroidx/core/view/h0;->b(Landroid/app/ApplicationExitInfo;)I

    move-result v14

    const/4 v15, 0x6

    if-eq v14, v15, :cond_7

    goto :goto_6

    :cond_7
    :goto_7
    if-nez v12, :cond_8

    goto/16 :goto_e

    .line 56
    :cond_8
    :try_start_5
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->g(Landroid/app/ApplicationExitInfo;)Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_a

    .line 57
    new-instance v14, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v14}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v15, 0x2000

    .line 58
    new-array v15, v15, [B

    .line 59
    :goto_8
    invoke-virtual {v0, v15}, Ljava/io/InputStream;->read([B)I

    move-result v8

    const/4 v4, -0x1

    if-eq v8, v4, :cond_9

    .line 60
    invoke-virtual {v14, v15, v3, v8}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    const-wide/16 v4, 0x0

    goto :goto_8

    .line 61
    :cond_9
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v14, v0}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_9

    :catch_2
    move-exception v0

    .line 62
    invoke-static {v12}, Lcom/google/android/gms/internal/ads/x;->g(Landroid/app/ApplicationExitInfo;)V

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    :cond_a
    const/4 v0, 0x0

    .line 63
    :goto_9
    new-instance v4, Lsf/c0;

    invoke-direct {v4}, Lsf/c0;-><init>()V

    .line 64
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->b(Landroid/app/ApplicationExitInfo;)I

    move-result v5

    invoke-virtual {v4, v5}, Lsf/c0;->c(I)V

    .line 65
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->h(Landroid/app/ApplicationExitInfo;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lsf/c0;->e(Ljava/lang/String;)V

    .line 66
    invoke-static {v12}, Landroidx/core/view/h0;->b(Landroid/app/ApplicationExitInfo;)I

    move-result v5

    invoke-virtual {v4, v5}, Lsf/c0;->g(I)V

    .line 67
    invoke-static {v12}, Landroidx/core/view/h0;->c(Landroid/app/ApplicationExitInfo;)J

    move-result-wide v14

    invoke-virtual {v4, v14, v15}, Lsf/c0;->i(J)V

    .line 68
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->m(Landroid/app/ApplicationExitInfo;)I

    move-result v5

    invoke-virtual {v4, v5}, Lsf/c0;->d(I)V

    .line 69
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->c(Landroid/app/ApplicationExitInfo;)J

    move-result-wide v14

    invoke-virtual {v4, v14, v15}, Lsf/c0;->f(J)V

    .line 70
    invoke-static {v12}, Lcom/applovin/impl/sdk/b0;->n(Landroid/app/ApplicationExitInfo;)J

    move-result-wide v14

    invoke-virtual {v4, v14, v15}, Lsf/c0;->h(J)V

    .line 71
    invoke-virtual {v4, v0}, Lsf/c0;->j(Ljava/lang/String;)V

    .line 72
    invoke-virtual {v4}, Lsf/c0;->a()Lsf/d0;

    move-result-object v0

    .line 73
    iget-object v4, v10, Lvf/c;->a:Ljava/lang/Object;

    check-cast v4, Lpf/q;

    iget-object v5, v4, Lpf/q;->a:Landroid/content/Context;

    .line 74
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v5

    iget v5, v5, Landroid/content/res/Configuration;->orientation:I

    .line 75
    new-instance v8, Lsf/o0;

    invoke-direct {v8}, Lsf/o0;-><init>()V

    .line 76
    const-string v10, "anr"

    .line 77
    invoke-virtual {v8, v10}, Lsf/o0;->g(Ljava/lang/String;)V

    .line 78
    iget-wide v14, v0, Lsf/d0;->g:J

    invoke-virtual {v8, v14, v15}, Lsf/o0;->f(J)V

    .line 79
    iget-object v10, v4, Lpf/q;->e:Lcom/google/firebase/crashlytics/internal/settings/a;

    invoke-virtual {v10}, Lcom/google/firebase/crashlytics/internal/settings/a;->b()Lxf/b;

    move-result-object v10

    iget-object v10, v10, Lxf/b;->b:Lj6/h;

    iget-boolean v10, v10, Lj6/h;->c:Z

    if-eqz v10, :cond_c

    iget-object v10, v4, Lpf/q;->c:Landroidx/work/impl/w;

    iget-object v12, v10, Landroidx/work/impl/w;->a:Ljava/util/ArrayList;

    .line 80
    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    if-lez v12, :cond_c

    .line 81
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 82
    iget-object v10, v10, Landroidx/work/impl/w;->a:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_a
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_b

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v20

    check-cast v20, Lpf/d;

    .line 83
    new-instance v7, Lde/c;

    move-object/from16 v21, v10

    const/16 v10, 0xe

    invoke-direct {v7, v10, v3}, Lde/c;-><init>(IZ)V

    .line 84
    invoke-virtual/range {v20 .. v20}, Lpf/d;->c()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v7, v10}, Lde/c;->T(Ljava/lang/String;)V

    .line 85
    invoke-virtual/range {v20 .. v20}, Lpf/d;->a()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v7, v10}, Lde/c;->R(Ljava/lang/String;)V

    .line 86
    invoke-virtual/range {v20 .. v20}, Lpf/d;->b()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v7, v10}, Lde/c;->S(Ljava/lang/String;)V

    .line 87
    invoke-virtual {v7}, Lde/c;->J()Lsf/e0;

    move-result-object v7

    .line 88
    invoke-virtual {v12, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object/from16 v10, v21

    goto :goto_a

    .line 89
    :cond_b
    invoke-static {v12}, Lj$/util/DesugarCollections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v7

    goto :goto_b

    :cond_c
    const/4 v7, 0x0

    .line 90
    :goto_b
    new-instance v10, Lsf/c0;

    invoke-direct {v10}, Lsf/c0;-><init>()V

    .line 91
    iget v12, v0, Lsf/d0;->d:I

    invoke-virtual {v10, v12}, Lsf/c0;->c(I)V

    .line 92
    iget-object v12, v0, Lsf/d0;->b:Ljava/lang/String;

    invoke-virtual {v10, v12}, Lsf/c0;->e(Ljava/lang/String;)V

    .line 93
    iget v12, v0, Lsf/d0;->c:I

    invoke-virtual {v10, v12}, Lsf/c0;->g(I)V

    .line 94
    invoke-virtual {v10, v14, v15}, Lsf/c0;->i(J)V

    .line 95
    iget v12, v0, Lsf/d0;->a:I

    invoke-virtual {v10, v12}, Lsf/c0;->d(I)V

    .line 96
    iget-wide v14, v0, Lsf/d0;->e:J

    invoke-virtual {v10, v14, v15}, Lsf/c0;->f(J)V

    .line 97
    iget-wide v14, v0, Lsf/d0;->f:J

    invoke-virtual {v10, v14, v15}, Lsf/c0;->h(J)V

    .line 98
    iget-object v0, v0, Lsf/d0;->h:Ljava/lang/String;

    invoke-virtual {v10, v0}, Lsf/c0;->j(Ljava/lang/String;)V

    .line 99
    invoke-virtual {v10, v7}, Lsf/c0;->b(Ljava/util/List;)V

    .line 100
    invoke-virtual {v10}, Lsf/c0;->a()Lsf/d0;

    move-result-object v0

    const/16 v7, 0x64

    .line 101
    iget v10, v0, Lsf/d0;->d:I

    if-eq v10, v7, :cond_d

    const/4 v15, 0x1

    goto :goto_c

    :cond_d
    move v15, v3

    .line 102
    :goto_c
    new-instance v7, Lsf/q0;

    invoke-direct {v7}, Lsf/q0;-><init>()V

    .line 103
    invoke-static {v15}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    invoke-virtual {v7, v10}, Lsf/q0;->c(Ljava/lang/Boolean;)V

    .line 104
    sget-object v10, Lmf/f;->a:Lmf/f;

    .line 105
    const-string v12, "processName"

    iget-object v14, v0, Lsf/d0;->b:Ljava/lang/String;

    invoke-static {v14, v12}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget v12, v0, Lsf/d0;->d:I

    iget v15, v0, Lsf/d0;->a:I

    const/16 v3, 0x8

    invoke-static {v10, v14, v15, v12, v3}, Lmf/f;->a(Lmf/f;Ljava/lang/String;III)Lsf/e1;

    move-result-object v10

    .line 106
    invoke-virtual {v7, v10}, Lsf/q0;->d(Lsf/h2;)V

    .line 107
    invoke-virtual {v7, v5}, Lsf/q0;->h(I)V

    .line 108
    new-instance v3, Las/c;

    const/16 v10, 0xc

    invoke-direct {v3, v10}, Las/c;-><init>(I)V

    .line 109
    invoke-virtual {v3, v0}, Las/c;->m(Lsf/u1;)V

    .line 110
    new-instance v0, Lsf/x0;

    invoke-direct {v0}, Lsf/x0;-><init>()V

    .line 111
    const-string v10, "0"

    invoke-virtual {v0, v10}, Lsf/x0;->d(Ljava/lang/String;)V

    .line 112
    invoke-virtual {v0, v10}, Lsf/x0;->c(Ljava/lang/String;)V

    const-wide/16 v14, 0x0

    .line 113
    invoke-virtual {v0, v14, v15}, Lsf/x0;->b(J)V

    .line 114
    invoke-virtual {v0}, Lsf/x0;->a()Lsf/y0;

    move-result-object v0

    .line 115
    invoke-virtual {v3, v0}, Las/c;->t(Lsf/y0;)V

    .line 116
    invoke-virtual {v4}, Lpf/q;->a()Ljava/util/List;

    move-result-object v0

    invoke-virtual {v3, v0}, Las/c;->n(Ljava/util/List;)V

    .line 117
    invoke-virtual {v3}, Las/c;->d()Lsf/s0;

    move-result-object v0

    .line 118
    invoke-virtual {v7, v0}, Lsf/q0;->f(Lsf/s0;)V

    .line 119
    invoke-virtual {v7}, Lsf/q0;->a()Lsf/r0;

    move-result-object v0

    .line 120
    invoke-virtual {v8, v0}, Lsf/o0;->b(Lsf/r0;)V

    .line 121
    invoke-virtual {v4, v5}, Lpf/q;->b(I)Lsf/g1;

    move-result-object v0

    invoke-virtual {v8, v0}, Lsf/o0;->c(Lsf/g1;)V

    .line 122
    invoke-virtual {v8}, Lsf/o0;->a()Lsf/p0;

    move-result-object v0

    .line 123
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v3

    .line 124
    invoke-static {v0, v9, v13, v3}, Lvf/c;->a(Lsf/p0;Lrf/f;Lvf/c;Ljava/util/Map;)Lsf/p0;

    move-result-object v0

    .line 125
    invoke-static {v0, v13}, Lvf/c;->b(Lsf/p0;Lvf/c;)Lsf/o2;

    move-result-object v0

    const/4 v3, 0x1

    .line 126
    invoke-virtual {v11, v0, v6, v3}, Lvf/a;->d(Lsf/o2;Ljava/lang/String;Z)V

    goto :goto_e

    .line 127
    :goto_d
    :try_start_6
    monitor-exit v11
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw v0

    :cond_e
    move-object/from16 v16, v5

    :goto_e
    if-eqz p3, :cond_1b

    .line 128
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->j:Lmf/c;

    invoke-virtual {v0, v6}, Lmf/c;->d(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 129
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->j:Lmf/c;

    .line 130
    invoke-virtual {v0, v6}, Lmf/c;->a(Ljava/lang/String;)Lmf/e;

    move-result-object v0

    .line 131
    invoke-interface {v0}, Lmf/e;->l()Ljava/io/File;

    move-result-object v3

    .line 132
    invoke-interface {v0}, Lmf/e;->g()Lsf/u1;

    move-result-object v4

    if-eqz v3, :cond_f

    .line 133
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    :cond_f
    if-nez v4, :cond_10

    .line 134
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v7, "No Tombstones data found for session "

    invoke-direct {v5, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 135
    const-string v7, "FirebaseCrashlytics"

    const/4 v8, 0x0

    invoke-static {v7, v5, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_10
    if-eqz v3, :cond_11

    .line 136
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_12

    :cond_11
    if-nez v4, :cond_12

    goto/16 :goto_15

    .line 137
    :cond_12
    invoke-virtual {v3}, Ljava/io/File;->lastModified()J

    move-result-wide v7

    .line 138
    iget-object v3, v1, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    .line 139
    sget-object v5, Lrf/f;->c:Ll3/c;

    if-nez v6, :cond_13

    goto :goto_f

    .line 140
    :cond_13
    const-string v5, "userlog"

    invoke-virtual {v3, v6, v5}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v5

    .line 141
    new-instance v9, Lrf/n;

    invoke-direct {v9, v5}, Lrf/n;-><init>(Ljava/io/File;)V

    move-object v5, v9

    .line 142
    :goto_f
    invoke-virtual {v3, v6}, Lvf/c;->f(Ljava/lang/String;)Ljava/io/File;

    move-result-object v9

    .line 143
    invoke-virtual {v9}, Ljava/io/File;->isDirectory()Z

    move-result v10

    if-nez v10, :cond_14

    goto/16 :goto_15

    .line 144
    :cond_14
    invoke-virtual {v1, v7, v8}, Lcom/google/firebase/crashlytics/internal/common/a;->d(J)V

    .line 145
    invoke-interface {v5}, Lrf/d;->f()[B

    move-result-object v7

    .line 146
    const-string v8, "user-data"

    .line 147
    invoke-virtual {v3, v6, v8}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v8

    .line 148
    const-string v10, "keys"

    invoke-virtual {v3, v6, v10}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v11

    .line 149
    const-string v12, "rollouts-state"

    .line 150
    invoke-virtual {v3, v6, v12}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    .line 151
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 152
    new-instance v13, Lpf/e;

    const-string v14, "logs_file"

    const-string v15, "logs"

    const/4 v2, 0x0

    invoke-direct {v13, v14, v15, v7, v2}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    invoke-virtual {v12, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 153
    new-instance v2, Lpf/e;

    .line 154
    invoke-interface {v0}, Lmf/e;->o()Ljava/io/File;

    move-result-object v7

    const-string v13, "crash_meta_file"

    const-string v14, "metadata"

    const/4 v15, 0x1

    invoke-direct {v2, v13, v14, v7, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 155
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 156
    new-instance v2, Lpf/e;

    .line 157
    invoke-interface {v0}, Lmf/e;->E()Ljava/io/File;

    move-result-object v7

    const-string v13, "session_meta_file"

    const-string v14, "session"

    invoke-direct {v2, v13, v14, v7, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 158
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 159
    new-instance v2, Lpf/e;

    .line 160
    invoke-interface {v0}, Lmf/e;->r()Ljava/io/File;

    move-result-object v7

    const-string v13, "app_meta_file"

    const-string v14, "app"

    invoke-direct {v2, v13, v14, v7, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 161
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 162
    new-instance v2, Lpf/e;

    .line 163
    invoke-interface {v0}, Lmf/e;->c()Ljava/io/File;

    move-result-object v7

    const-string v13, "device_meta_file"

    const-string v14, "device"

    invoke-direct {v2, v13, v14, v7, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 164
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 165
    new-instance v2, Lpf/e;

    .line 166
    invoke-interface {v0}, Lmf/e;->s()Ljava/io/File;

    move-result-object v7

    const-string v13, "os_meta_file"

    const-string v14, "os"

    invoke-direct {v2, v13, v14, v7, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 167
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 168
    invoke-interface {v0}, Lmf/e;->l()Ljava/io/File;

    move-result-object v0

    .line 169
    const-string v2, "minidump"

    const-string v7, "minidump_file"

    if-eqz v0, :cond_16

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v13

    if-nez v13, :cond_15

    goto :goto_10

    .line 170
    :cond_15
    new-instance v13, Lpf/e;

    invoke-direct {v13, v7, v2, v0, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    goto :goto_11

    .line 171
    :cond_16
    :goto_10
    new-instance v13, Lpf/e;

    new-array v0, v15, [B

    const/4 v14, 0x0

    aput-byte v14, v0, v14

    invoke-direct {v13, v7, v2, v0, v14}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 172
    :goto_11
    invoke-virtual {v12, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 173
    new-instance v0, Lpf/e;

    const-string v2, "user_meta_file"

    const-string v7, "user"

    invoke-direct {v0, v2, v7, v8, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    invoke-virtual {v12, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 174
    new-instance v0, Lpf/e;

    const-string v2, "keys_file"

    invoke-direct {v0, v2, v10, v11, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    invoke-virtual {v12, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 175
    new-instance v0, Lpf/e;

    const-string v2, "rollouts_file"

    const-string v7, "rollouts"

    invoke-direct {v0, v2, v7, v3, v15}, Lpf/e;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/Serializable;I)V

    invoke-virtual {v12, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 176
    invoke-static {v9, v12}, Lb4/a;->K(Ljava/io/File;Ljava/util/ArrayList;)V

    .line 177
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 178
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 179
    invoke-virtual {v12}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_17
    :goto_12
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_18

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lpf/e;

    .line 180
    invoke-virtual {v7}, Lpf/e;->a()Lsf/h0;

    move-result-object v7

    if-eqz v7, :cond_17

    .line 181
    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_12

    .line 182
    :cond_18
    new-instance v3, Lcom/moloco/sdk/xenoss/sdkdevkit/android/adrenderer/internal/vast/model/k;

    invoke-direct {v3}, Lcom/moloco/sdk/xenoss/sdkdevkit/android/adrenderer/internal/vast/model/k;-><init>()V

    .line 183
    invoke-static {v2}, Lj$/util/DesugarCollections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v3, v2}, Lcom/moloco/sdk/xenoss/sdkdevkit/android/adrenderer/internal/vast/model/k;->b(Ljava/util/List;)V

    invoke-virtual {v3}, Lcom/moloco/sdk/xenoss/sdkdevkit/android/adrenderer/internal/vast/model/k;->a()Lsf/g0;

    move-result-object v2

    .line 184
    iget-object v0, v0, Lvf/c;->b:Ljava/lang/Object;

    check-cast v0, Lvf/a;

    iget-object v3, v0, Lvf/a;->b:Lvf/c;

    .line 185
    const-string v7, "report"

    invoke-virtual {v3, v6, v7}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v7

    .line 186
    invoke-virtual {v7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    .line 187
    iget-object v0, v0, Lvf/a;->d:Lpf/j;

    invoke-virtual {v0, v6}, Lpf/j;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 188
    :try_start_7
    sget-object v8, Lvf/a;->g:Ltf/a;

    .line 189
    invoke-static {v7}, Lvf/a;->e(Ljava/io/File;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {v9}, Ltf/a;->i(Ljava/lang/String;)Lsf/b0;

    move-result-object v8

    .line 190
    invoke-virtual {v8}, Lsf/b0;->a()Lsf/a0;

    move-result-object v8

    const/4 v9, 0x0

    .line 191
    iput-object v9, v8, Lsf/a0;->j:Lsf/j0;

    .line 192
    iput-object v2, v8, Lsf/a0;->k:Lsf/g0;

    .line 193
    invoke-virtual {v8}, Lsf/a0;->a()Lsf/b0;

    move-result-object v2

    if-nez v4, :cond_19

    goto :goto_13

    .line 194
    :cond_19
    invoke-virtual {v2}, Lsf/b0;->a()Lsf/a0;

    move-result-object v2

    .line 195
    iput-object v4, v2, Lsf/a0;->l:Lsf/u1;

    .line 196
    invoke-virtual {v2}, Lsf/a0;->a()Lsf/b0;

    move-result-object v2

    .line 197
    :goto_13
    invoke-virtual {v2}, Lsf/b0;->a()Lsf/a0;

    move-result-object v4

    .line 198
    iput-object v0, v4, Lsf/a0;->g:Ljava/lang/String;

    .line 199
    iget-object v2, v2, Lsf/b0;->k:Lsf/j0;

    if-eqz v2, :cond_1a

    .line 200
    invoke-virtual {v2}, Lsf/j0;->a()Lsf/i0;

    move-result-object v2

    .line 201
    iput-object v0, v2, Lsf/i0;->c:Ljava/lang/String;

    .line 202
    invoke-virtual {v2}, Lsf/i0;->a()Lsf/j0;

    move-result-object v0

    .line 203
    iput-object v0, v4, Lsf/a0;->j:Lsf/j0;

    .line 204
    :cond_1a
    invoke-virtual {v4}, Lsf/a0;->a()Lsf/b0;

    move-result-object v0

    .line 205
    new-instance v2, Ljava/io/File;

    iget-object v3, v3, Lvf/c;->g:Ljava/lang/Object;

    check-cast v3, Ljava/io/File;

    invoke-direct {v2, v3, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 206
    sget-object v3, Ltf/a;->a:Landroidx/appcompat/widget/w0;

    invoke-virtual {v3, v0}, Landroidx/appcompat/widget/w0;->j(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 207
    invoke-static {v2, v0}, Lvf/a;->f(Ljava/io/File;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_14

    .line 208
    :catch_3
    invoke-static {v7}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 209
    :goto_14
    invoke-interface {v5}, Lrf/d;->h()V

    :cond_1b
    :goto_15
    if-eqz p1, :cond_1c

    move-object/from16 v3, v16

    const/4 v2, 0x0

    .line 210
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/lang/String;

    goto :goto_16

    :cond_1c
    const/4 v2, 0x0

    .line 211
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->l:Lpf/j;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lpf/j;->b(Ljava/lang/String;)V

    move-object v8, v3

    .line 212
    :goto_16
    iget-object v0, v1, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 213
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    const-wide/16 v5, 0x3e8

    .line 214
    div-long/2addr v3, v5

    .line 215
    iget-object v0, v0, Lvf/c;->b:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Lvf/a;

    .line 216
    iget-object v6, v5, Lvf/a;->b:Lvf/c;

    .line 217
    const-string v0, ".com.google.firebase.crashlytics"

    invoke-virtual {v6, v0}, Lvf/c;->d(Ljava/lang/String;)V

    .line 218
    const-string v0, ".com.google.firebase.crashlytics-ndk"

    invoke-virtual {v6, v0}, Lvf/c;->d(Ljava/lang/String;)V

    .line 219
    iget-object v0, v6, Lvf/c;->a:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1d

    .line 220
    const-string v0, ".com.google.firebase.crashlytics.files.v1"

    invoke-virtual {v6, v0}, Lvf/c;->d(Ljava/lang/String;)V

    .line 221
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v7, ".com.google.firebase.crashlytics.files.v2"

    invoke-direct {v0, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v7, Ljava/io/File;->pathSeparator:Ljava/lang/String;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 222
    iget-object v7, v6, Lvf/c;->b:Ljava/lang/Object;

    check-cast v7, Ljava/io/File;

    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v9

    if-eqz v9, :cond_1d

    .line 223
    new-instance v9, Lvf/b;

    invoke-direct {v9, v0}, Lvf/b;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v9}, Ljava/io/File;->list(Ljava/io/FilenameFilter;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1d

    .line 224
    array-length v7, v0

    move v9, v2

    :goto_17
    if-ge v9, v7, :cond_1d

    aget-object v10, v0, v9

    .line 225
    invoke-virtual {v6, v10}, Lvf/c;->d(Ljava/lang/String;)V

    const/4 v10, 0x1

    add-int/2addr v9, v10

    goto :goto_17

    :cond_1d
    const/4 v10, 0x1

    .line 226
    invoke-virtual {v5}, Lvf/a;->c()Ljava/util/NavigableSet;

    move-result-object v0

    if-eqz v8, :cond_1e

    .line 227
    invoke-interface {v0, v8}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 228
    :cond_1e
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v7

    const/16 v8, 0x8

    if-gt v7, v8, :cond_1f

    goto :goto_19

    .line 229
    :cond_1f
    :goto_18
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v7

    if-le v7, v8, :cond_20

    .line 230
    invoke-interface {v0}, Ljava/util/SortedSet;->last()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 231
    new-instance v9, Ljava/io/File;

    iget-object v11, v6, Lvf/c;->d:Ljava/lang/Object;

    check-cast v11, Ljava/io/File;

    invoke-direct {v9, v11, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 232
    invoke-static {v9}, Lvf/c;->k(Ljava/io/File;)Z

    .line 233
    invoke-interface {v0, v7}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_18

    .line 234
    :cond_20
    :goto_19
    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_1a
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2a

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/lang/String;

    .line 235
    sget-object v0, Lvf/a;->i:Lcom/facebook/internal/f1;

    .line 236
    new-instance v9, Ljava/io/File;

    iget-object v11, v6, Lvf/c;->d:Ljava/lang/Object;

    check-cast v11, Ljava/io/File;

    invoke-direct {v9, v11, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 237
    invoke-virtual {v9}, Ljava/io/File;->mkdirs()Z

    .line 238
    invoke-virtual {v9, v0}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Lvf/c;->l([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 239
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_21

    goto/16 :goto_21

    .line 240
    :cond_21
    invoke-static {v0}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 241
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 242
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v11

    move v12, v2

    :goto_1b
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    sget-object v13, Lvf/a;->g:Ltf/a;

    if-eqz v0, :cond_24

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v14, v0

    check-cast v14, Ljava/io/File;

    .line 243
    :try_start_8
    invoke-static {v14}, Lvf/a;->e(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v13}, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    .line 244
    :try_start_9
    new-instance v13, Landroid/util/JsonReader;

    new-instance v15, Ljava/io/StringReader;

    invoke-direct {v15, v0}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v13, v15}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V
    :try_end_9
    .catch Ljava/lang/IllegalStateException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 245
    :try_start_a
    invoke-static {v13}, Ltf/a;->e(Landroid/util/JsonReader;)Lsf/p0;

    move-result-object v0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    .line 246
    :try_start_b
    invoke-virtual {v13}, Landroid/util/JsonReader;->close()V
    :try_end_b
    .catch Ljava/lang/IllegalStateException; {:try_start_b .. :try_end_b} :catch_4
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_5

    .line 247
    :try_start_c
    invoke-virtual {v9, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    if-nez v12, :cond_23

    .line 248
    invoke-virtual {v14}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    .line 249
    const-string v13, "event"

    invoke-virtual {v0, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_22

    const-string v13, "_"

    invoke-virtual {v0, v13}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_5

    if-eqz v0, :cond_22

    goto :goto_1c

    :cond_22
    move v0, v2

    goto :goto_1d

    :cond_23
    :goto_1c
    move v0, v10

    :goto_1d
    move v12, v0

    goto :goto_1b

    :catch_4
    move-exception v0

    goto :goto_1f

    :catchall_3
    move-exception v0

    move-object v15, v0

    .line 250
    :try_start_d
    invoke-virtual {v13}, Landroid/util/JsonReader;->close()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_4

    goto :goto_1e

    :catchall_4
    move-exception v0

    move-object v13, v0

    :try_start_e
    invoke-virtual {v15, v13}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1e
    throw v15
    :try_end_e
    .catch Ljava/lang/IllegalStateException; {:try_start_e .. :try_end_e} :catch_4
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_5

    .line 251
    :goto_1f
    :try_start_f
    new-instance v13, Ljava/io/IOException;

    invoke-direct {v13, v0}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v13
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_5

    .line 252
    :catch_5
    invoke-static {v14}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    goto :goto_1b

    .line 253
    :cond_24
    invoke-virtual {v9}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_25

    goto/16 :goto_21

    .line 254
    :cond_25
    new-instance v0, Lrf/h;

    invoke-direct {v0, v6}, Lrf/h;-><init>(Lvf/c;)V

    invoke-virtual {v0, v8}, Lrf/h;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 255
    iget-object v11, v5, Lvf/a;->d:Lpf/j;

    invoke-virtual {v11, v8}, Lpf/j;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 256
    const-string v14, "report"

    invoke-virtual {v6, v8, v14}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v14

    .line 257
    :try_start_10
    invoke-static {v14}, Lvf/a;->e(Ljava/io/File;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v13}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {v15}, Ltf/a;->i(Ljava/lang/String;)Lsf/b0;

    move-result-object v13

    .line 258
    invoke-virtual {v13, v3, v4, v0, v12}, Lsf/s2;->b(JLjava/lang/String;Z)Lsf/b0;

    move-result-object v0

    .line 259
    invoke-virtual {v0}, Lsf/b0;->a()Lsf/a0;

    move-result-object v13

    .line 260
    iput-object v11, v13, Lsf/a0;->g:Ljava/lang/String;

    .line 261
    iget-object v0, v0, Lsf/b0;->k:Lsf/j0;

    if-eqz v0, :cond_26

    .line 262
    invoke-virtual {v0}, Lsf/j0;->a()Lsf/i0;

    move-result-object v0

    .line 263
    iput-object v11, v0, Lsf/i0;->c:Ljava/lang/String;

    .line 264
    invoke-virtual {v0}, Lsf/i0;->a()Lsf/j0;

    move-result-object v0

    .line 265
    iput-object v0, v13, Lsf/a0;->j:Lsf/j0;

    .line 266
    :cond_26
    invoke-virtual {v13}, Lsf/a0;->a()Lsf/b0;

    move-result-object v0

    .line 267
    iget-object v11, v0, Lsf/b0;->k:Lsf/j0;

    if-eqz v11, :cond_29

    .line 268
    invoke-virtual {v0}, Lsf/b0;->a()Lsf/a0;

    move-result-object v0

    .line 269
    invoke-virtual {v11}, Lsf/j0;->a()Lsf/i0;

    move-result-object v11

    .line 270
    iput-object v9, v11, Lsf/i0;->k:Ljava/util/List;

    .line 271
    invoke-virtual {v11}, Lsf/i0;->a()Lsf/j0;

    move-result-object v9

    .line 272
    iput-object v9, v0, Lsf/a0;->j:Lsf/j0;

    .line 273
    invoke-virtual {v0}, Lsf/a0;->a()Lsf/b0;

    move-result-object v0

    .line 274
    iget-object v9, v0, Lsf/b0;->k:Lsf/j0;

    if-nez v9, :cond_27

    goto :goto_21

    :cond_27
    if-eqz v12, :cond_28

    .line 275
    iget-object v9, v9, Lsf/j0;->b:Ljava/lang/String;

    .line 276
    new-instance v11, Ljava/io/File;

    iget-object v12, v6, Lvf/c;->f:Ljava/lang/Object;

    check-cast v12, Ljava/io/File;

    invoke-direct {v11, v12, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_20

    .line 277
    :cond_28
    iget-object v9, v9, Lsf/j0;->b:Ljava/lang/String;

    .line 278
    new-instance v11, Ljava/io/File;

    iget-object v12, v6, Lvf/c;->e:Ljava/lang/Object;

    check-cast v12, Ljava/io/File;

    invoke-direct {v11, v12, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 279
    :goto_20
    sget-object v9, Ltf/a;->a:Landroidx/appcompat/widget/w0;

    invoke-virtual {v9, v0}, Landroidx/appcompat/widget/w0;->j(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 280
    invoke-static {v11, v0}, Lvf/a;->f(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_21

    .line 281
    :cond_29
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v9, "Reports without sessions cannot have events added to them."

    invoke-direct {v0, v9}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_6

    .line 282
    :catch_6
    invoke-static {v14}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 283
    :goto_21
    new-instance v0, Ljava/io/File;

    iget-object v9, v6, Lvf/c;->d:Ljava/lang/Object;

    check-cast v9, Ljava/io/File;

    invoke-direct {v0, v9, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 284
    invoke-static {v0}, Lvf/c;->k(Ljava/io/File;)Z

    goto/16 :goto_1a

    .line 285
    :cond_2a
    iget-object v0, v5, Lvf/a;->c:Lcom/google/firebase/crashlytics/internal/settings/a;

    invoke-virtual {v0}, Lcom/google/firebase/crashlytics/internal/settings/a;->b()Lxf/b;

    move-result-object v0

    iget-object v0, v0, Lxf/b;->a:Lxf/a;

    .line 286
    invoke-virtual {v5}, Lvf/a;->b()Ljava/util/ArrayList;

    move-result-object v0

    .line 287
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x4

    if-gt v2, v3, :cond_2b

    goto :goto_23

    .line 288
    :cond_2b
    invoke-virtual {v0, v3, v2}, Ljava/util/ArrayList;->subList(II)Ljava/util/List;

    move-result-object v0

    .line 289
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_22
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2c

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/io/File;

    .line 290
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto :goto_22

    :cond_2c
    :goto_23
    return-void
.end method

.method public final c(Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 30

    .line 1
    move-object/from16 v1, p0

    .line 2
    .line 3
    move-object/from16 v0, p1

    .line 4
    .line 5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 6
    .line 7
    .line 8
    move-result-wide v2

    .line 9
    const-wide/16 v8, 0x3e8

    .line 10
    .line 11
    div-long v10, v2, v8

    .line 12
    .line 13
    sget-object v12, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 14
    .line 15
    iget-object v2, v1, Lcom/google/firebase/crashlytics/internal/common/a;->f:Lpf/x;

    .line 16
    .line 17
    iget-object v3, v1, Lcom/google/firebase/crashlytics/internal/common/a;->h:Landroidx/work/impl/w;

    .line 18
    .line 19
    iget-object v14, v2, Lpf/x;->c:Ljava/lang/String;

    .line 20
    .line 21
    iget-object v4, v3, Landroidx/work/impl/w;->f:Ljava/lang/Object;

    .line 22
    .line 23
    move-object v15, v4

    .line 24
    check-cast v15, Ljava/lang/String;

    .line 25
    .line 26
    invoke-virtual {v2}, Lpf/x;->c()Lpf/b;

    .line 27
    .line 28
    .line 29
    move-result-object v2

    .line 30
    iget-object v2, v2, Lpf/b;->a:Ljava/lang/String;

    .line 31
    .line 32
    iget-object v4, v3, Landroidx/work/impl/w;->d:Ljava/lang/Object;

    .line 33
    .line 34
    check-cast v4, Ljava/lang/String;

    .line 35
    .line 36
    invoke-static {v4}, Lcom/google/firebase/crashlytics/internal/common/DeliveryMechanism;->determineFrom(Ljava/lang/String;)Lcom/google/firebase/crashlytics/internal/common/DeliveryMechanism;

    .line 37
    .line 38
    .line 39
    move-result-object v4

    .line 40
    invoke-virtual {v4}, Lcom/google/firebase/crashlytics/internal/common/DeliveryMechanism;->getId()I

    .line 41
    .line 42
    .line 43
    move-result v18

    .line 44
    new-instance v4, Lsf/q1;

    .line 45
    .line 46
    iget-object v5, v3, Landroidx/work/impl/w;->g:Ljava/lang/Object;

    .line 47
    .line 48
    move-object/from16 v16, v5

    .line 49
    .line 50
    check-cast v16, Ljava/lang/String;

    .line 51
    .line 52
    iget-object v3, v3, Landroidx/work/impl/w;->h:Ljava/lang/Object;

    .line 53
    .line 54
    move-object/from16 v19, v3

    .line 55
    .line 56
    check-cast v19, Lmf/d;

    .line 57
    .line 58
    move-object v13, v4

    .line 59
    move-object/from16 v17, v2

    .line 60
    .line 61
    invoke-direct/range {v13 .. v19}, Lsf/q1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILmf/d;)V

    .line 62
    .line 63
    .line 64
    sget-object v13, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 65
    .line 66
    sget-object v14, Landroid/os/Build$VERSION;->CODENAME:Ljava/lang/String;

    .line 67
    .line 68
    invoke-static {}, Lpf/g;->h()Z

    .line 69
    .line 70
    .line 71
    move-result v2

    .line 72
    new-instance v3, Lsf/s1;

    .line 73
    .line 74
    invoke-direct {v3, v13, v14, v2}, Lsf/s1;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 75
    .line 76
    .line 77
    iget-object v2, v1, Lcom/google/firebase/crashlytics/internal/common/a;->a:Landroid/content/Context;

    .line 78
    .line 79
    new-instance v5, Landroid/os/StatFs;

    .line 80
    .line 81
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    .line 82
    .line 83
    .line 84
    move-result-object v6

    .line 85
    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    .line 86
    .line 87
    .line 88
    move-result-object v6

    .line 89
    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 90
    .line 91
    .line 92
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockCount()I

    .line 93
    .line 94
    .line 95
    move-result v6

    .line 96
    int-to-long v6, v6

    .line 97
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    .line 98
    .line 99
    .line 100
    move-result v5

    .line 101
    int-to-long v8, v5

    .line 102
    mul-long v23, v6, v8

    .line 103
    .line 104
    invoke-static {}, Lcom/google/firebase/crashlytics/internal/common/CommonUtils$Architecture;->getValue()Lcom/google/firebase/crashlytics/internal/common/CommonUtils$Architecture;

    .line 105
    .line 106
    .line 107
    move-result-object v5

    .line 108
    invoke-virtual {v5}, Ljava/lang/Enum;->ordinal()I

    .line 109
    .line 110
    .line 111
    move-result v18

    .line 112
    sget-object v8, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 113
    .line 114
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    .line 115
    .line 116
    .line 117
    move-result-object v5

    .line 118
    invoke-virtual {v5}, Ljava/lang/Runtime;->availableProcessors()I

    .line 119
    .line 120
    .line 121
    move-result v20

    .line 122
    invoke-static {v2}, Lpf/g;->a(Landroid/content/Context;)J

    .line 123
    .line 124
    .line 125
    move-result-wide v21

    .line 126
    invoke-static {}, Lpf/g;->g()Z

    .line 127
    .line 128
    .line 129
    move-result v25

    .line 130
    invoke-static {}, Lpf/g;->d()I

    .line 131
    .line 132
    .line 133
    move-result v26

    .line 134
    sget-object v9, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 135
    .line 136
    sget-object v7, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    .line 137
    .line 138
    new-instance v2, Lsf/r1;

    .line 139
    .line 140
    move-object/from16 v17, v2

    .line 141
    .line 142
    move-object/from16 v19, v8

    .line 143
    .line 144
    move-object/from16 v27, v9

    .line 145
    .line 146
    move-object/from16 v28, v7

    .line 147
    .line 148
    invoke-direct/range {v17 .. v28}, Lsf/r1;-><init>(ILjava/lang/String;IJJZILjava/lang/String;Ljava/lang/String;)V

    .line 149
    .line 150
    .line 151
    iget-object v5, v1, Lcom/google/firebase/crashlytics/internal/common/a;->j:Lmf/c;

    .line 152
    .line 153
    new-instance v6, Lsf/p1;

    .line 154
    .line 155
    invoke-direct {v6, v4, v3, v2}, Lsf/p1;-><init>(Lsf/q1;Lsf/s1;Lsf/r1;)V

    .line 156
    .line 157
    .line 158
    invoke-virtual {v5, v0, v10, v11, v6}, Lmf/c;->c(Ljava/lang/String;JLsf/p1;)V

    .line 159
    .line 160
    .line 161
    invoke-virtual/range {p2 .. p2}, Ljava/lang/Boolean;->booleanValue()Z

    .line 162
    .line 163
    .line 164
    move-result v2

    .line 165
    if-eqz v2, :cond_0

    .line 166
    .line 167
    if-eqz v0, :cond_0

    .line 168
    .line 169
    iget-object v3, v1, Lcom/google/firebase/crashlytics/internal/common/a;->d:Lvf/c;

    .line 170
    .line 171
    iget-object v2, v3, Lvf/c;->a:Ljava/lang/Object;

    .line 172
    .line 173
    move-object/from16 v17, v2

    .line 174
    .line 175
    check-cast v17, Ljava/lang/String;

    .line 176
    .line 177
    monitor-enter v17

    .line 178
    :try_start_0
    iput-object v0, v3, Lvf/c;->a:Ljava/lang/Object;

    .line 179
    .line 180
    iget-object v2, v3, Lvf/c;->d:Ljava/lang/Object;

    .line 181
    .line 182
    check-cast v2, Lb6/j;

    .line 183
    .line 184
    iget-object v2, v2, Lb6/j;->b:Ljava/lang/Object;

    .line 185
    .line 186
    check-cast v2, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 187
    .line 188
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    .line 189
    .line 190
    .line 191
    move-result-object v2

    .line 192
    check-cast v2, Lrf/e;

    .line 193
    .line 194
    invoke-virtual {v2}, Lrf/e;->a()Ljava/util/Map;

    .line 195
    .line 196
    .line 197
    move-result-object v5

    .line 198
    iget-object v2, v3, Lvf/c;->f:Ljava/lang/Object;

    .line 199
    .line 200
    check-cast v2, Lcom/facebook/appevents/p;

    .line 201
    .line 202
    invoke-virtual {v2}, Lcom/facebook/appevents/p;->b()Ljava/util/List;

    .line 203
    .line 204
    .line 205
    move-result-object v6

    .line 206
    iget-object v2, v3, Lvf/c;->c:Ljava/lang/Object;

    .line 207
    .line 208
    check-cast v2, Lcom/google/firebase/crashlytics/internal/concurrency/a;

    .line 209
    .line 210
    iget-object v4, v2, Lcom/google/firebase/crashlytics/internal/concurrency/a;->b:Lqf/b;

    .line 211
    .line 212
    new-instance v2, Lap/g;

    .line 213
    .line 214
    const/16 v18, 0x17

    .line 215
    .line 216
    move-object/from16 p2, v2

    .line 217
    .line 218
    move-object v15, v4

    .line 219
    move-object/from16 v4, p1

    .line 220
    .line 221
    move-object/from16 v29, v7

    .line 222
    .line 223
    move/from16 v7, v18

    .line 224
    .line 225
    invoke-direct/range {v2 .. v7}, Lap/g;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    .line 226
    .line 227
    .line 228
    invoke-virtual {v15, v2}, Lqf/b;->a(Ljava/lang/Runnable;)Lcom/google/android/gms/tasks/Task;

    .line 229
    .line 230
    .line 231
    monitor-exit v17

    .line 232
    goto :goto_0

    .line 233
    :catchall_0
    move-exception v0

    .line 234
    monitor-exit v17
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 235
    throw v0

    .line 236
    :cond_0
    move-object/from16 v29, v7

    .line 237
    .line 238
    :goto_0
    iget-object v2, v1, Lcom/google/firebase/crashlytics/internal/common/a;->i:Lrf/f;

    .line 239
    .line 240
    iget-object v3, v2, Lrf/f;->b:Lrf/d;

    .line 241
    .line 242
    invoke-interface {v3}, Lrf/d;->a()V

    .line 243
    .line 244
    .line 245
    sget-object v3, Lrf/f;->c:Ll3/c;

    .line 246
    .line 247
    iput-object v3, v2, Lrf/f;->b:Lrf/d;

    .line 248
    .line 249
    if-nez v0, :cond_1

    .line 250
    .line 251
    goto :goto_1

    .line 252
    :cond_1
    iget-object v3, v2, Lrf/f;->a:Lvf/c;

    .line 253
    .line 254
    const-string v4, "userlog"

    .line 255
    .line 256
    invoke-virtual {v3, v0, v4}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    .line 257
    .line 258
    .line 259
    move-result-object v3

    .line 260
    new-instance v4, Lrf/n;

    .line 261
    .line 262
    invoke-direct {v4, v3}, Lrf/n;-><init>(Ljava/io/File;)V

    .line 263
    .line 264
    .line 265
    iput-object v4, v2, Lrf/f;->b:Lrf/d;

    .line 266
    .line 267
    :goto_1
    iget-object v2, v1, Lcom/google/firebase/crashlytics/internal/common/a;->l:Lpf/j;

    .line 268
    .line 269
    invoke-virtual {v2, v0}, Lpf/j;->b(Ljava/lang/String;)V

    .line 270
    .line 271
    .line 272
    iget-object v2, v1, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 273
    .line 274
    iget-object v3, v2, Lvf/c;->a:Ljava/lang/Object;

    .line 275
    .line 276
    check-cast v3, Lpf/q;

    .line 277
    .line 278
    sget-object v4, Lsf/s2;->a:Ljava/nio/charset/Charset;

    .line 279
    .line 280
    new-instance v4, Lsf/a0;

    .line 281
    .line 282
    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    .line 283
    .line 284
    .line 285
    const-string v5, "19.4.0"

    .line 286
    .line 287
    iput-object v5, v4, Lsf/a0;->a:Ljava/lang/String;

    .line 288
    .line 289
    iget-object v5, v3, Lpf/q;->c:Landroidx/work/impl/w;

    .line 290
    .line 291
    iget-object v6, v5, Landroidx/work/impl/w;->b:Ljava/lang/Object;

    .line 292
    .line 293
    check-cast v6, Ljava/lang/String;

    .line 294
    .line 295
    if-eqz v6, :cond_b

    .line 296
    .line 297
    iput-object v6, v4, Lsf/a0;->b:Ljava/lang/String;

    .line 298
    .line 299
    iget-object v6, v3, Lpf/q;->b:Lpf/x;

    .line 300
    .line 301
    invoke-virtual {v6}, Lpf/x;->c()Lpf/b;

    .line 302
    .line 303
    .line 304
    move-result-object v7

    .line 305
    iget-object v7, v7, Lpf/b;->a:Ljava/lang/String;

    .line 306
    .line 307
    if-eqz v7, :cond_a

    .line 308
    .line 309
    iput-object v7, v4, Lsf/a0;->d:Ljava/lang/String;

    .line 310
    .line 311
    invoke-virtual {v6}, Lpf/x;->c()Lpf/b;

    .line 312
    .line 313
    .line 314
    move-result-object v7

    .line 315
    iget-object v7, v7, Lpf/b;->b:Ljava/lang/String;

    .line 316
    .line 317
    iput-object v7, v4, Lsf/a0;->e:Ljava/lang/String;

    .line 318
    .line 319
    invoke-virtual {v6}, Lpf/x;->c()Lpf/b;

    .line 320
    .line 321
    .line 322
    move-result-object v7

    .line 323
    iget-object v7, v7, Lpf/b;->c:Ljava/lang/String;

    .line 324
    .line 325
    iput-object v7, v4, Lsf/a0;->f:Ljava/lang/String;

    .line 326
    .line 327
    iget-object v7, v5, Landroidx/work/impl/w;->f:Ljava/lang/Object;

    .line 328
    .line 329
    check-cast v7, Ljava/lang/String;

    .line 330
    .line 331
    if-eqz v7, :cond_9

    .line 332
    .line 333
    iput-object v7, v4, Lsf/a0;->h:Ljava/lang/String;

    .line 334
    .line 335
    iget-object v15, v5, Landroidx/work/impl/w;->g:Ljava/lang/Object;

    .line 336
    .line 337
    check-cast v15, Ljava/lang/String;

    .line 338
    .line 339
    if-eqz v15, :cond_8

    .line 340
    .line 341
    iput-object v15, v4, Lsf/a0;->i:Ljava/lang/String;

    .line 342
    .line 343
    const/4 v1, 0x4

    .line 344
    iput v1, v4, Lsf/a0;->c:I

    .line 345
    .line 346
    iget-byte v1, v4, Lsf/a0;->m:B

    .line 347
    .line 348
    or-int/lit8 v1, v1, 0x1

    .line 349
    .line 350
    int-to-byte v1, v1

    .line 351
    iput-byte v1, v4, Lsf/a0;->m:B

    .line 352
    .line 353
    new-instance v1, Lsf/i0;

    .line 354
    .line 355
    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    .line 356
    .line 357
    .line 358
    move-object/from16 v16, v2

    .line 359
    .line 360
    const/4 v2, 0x0

    .line 361
    iput-boolean v2, v1, Lsf/i0;->f:Z

    .line 362
    .line 363
    iget-byte v2, v1, Lsf/i0;->m:B

    .line 364
    .line 365
    or-int/lit8 v2, v2, 0x2

    .line 366
    .line 367
    int-to-byte v2, v2

    .line 368
    iput-wide v10, v1, Lsf/i0;->d:J

    .line 369
    .line 370
    or-int/lit8 v2, v2, 0x1

    .line 371
    .line 372
    int-to-byte v2, v2

    .line 373
    iput-byte v2, v1, Lsf/i0;->m:B

    .line 374
    .line 375
    if-eqz v0, :cond_7

    .line 376
    .line 377
    iput-object v0, v1, Lsf/i0;->b:Ljava/lang/String;

    .line 378
    .line 379
    sget-object v0, Lpf/q;->g:Ljava/lang/String;

    .line 380
    .line 381
    if-eqz v0, :cond_6

    .line 382
    .line 383
    iput-object v0, v1, Lsf/i0;->a:Ljava/lang/String;

    .line 384
    .line 385
    iget-object v0, v6, Lpf/x;->c:Ljava/lang/String;

    .line 386
    .line 387
    if-eqz v0, :cond_5

    .line 388
    .line 389
    invoke-virtual {v6}, Lpf/x;->c()Lpf/b;

    .line 390
    .line 391
    .line 392
    move-result-object v2

    .line 393
    iget-object v2, v2, Lpf/b;->a:Ljava/lang/String;

    .line 394
    .line 395
    iget-object v5, v5, Landroidx/work/impl/w;->h:Ljava/lang/Object;

    .line 396
    .line 397
    check-cast v5, Lmf/d;

    .line 398
    .line 399
    invoke-virtual {v5}, Lmf/d;->a()Lmf/d;

    .line 400
    .line 401
    .line 402
    move-result-object v6

    .line 403
    iget-object v6, v6, Lmf/d;->a:Ljava/lang/Object;

    .line 404
    .line 405
    move-object/from16 v26, v6

    .line 406
    .line 407
    check-cast v26, Ljava/lang/String;

    .line 408
    .line 409
    invoke-virtual {v5}, Lmf/d;->a()Lmf/d;

    .line 410
    .line 411
    .line 412
    move-result-object v5

    .line 413
    iget-object v5, v5, Lmf/d;->b:Ljava/lang/Object;

    .line 414
    .line 415
    move-object/from16 v27, v5

    .line 416
    .line 417
    check-cast v27, Ljava/lang/String;

    .line 418
    .line 419
    new-instance v5, Lsf/k0;

    .line 420
    .line 421
    move-object/from16 v21, v5

    .line 422
    .line 423
    move-object/from16 v22, v0

    .line 424
    .line 425
    move-object/from16 v23, v7

    .line 426
    .line 427
    move-object/from16 v24, v15

    .line 428
    .line 429
    move-object/from16 v25, v2

    .line 430
    .line 431
    invoke-direct/range {v21 .. v27}, Lsf/k0;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 432
    .line 433
    .line 434
    iput-object v5, v1, Lsf/i0;->g:Lsf/k0;

    .line 435
    .line 436
    new-instance v0, Lsf/m1;

    .line 437
    .line 438
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 439
    .line 440
    .line 441
    const/4 v2, 0x3

    .line 442
    iput v2, v0, Lsf/m1;->a:I

    .line 443
    .line 444
    iget-byte v5, v0, Lsf/m1;->e:B

    .line 445
    .line 446
    or-int/lit8 v5, v5, 0x1

    .line 447
    .line 448
    int-to-byte v5, v5

    .line 449
    iput-byte v5, v0, Lsf/m1;->e:B

    .line 450
    .line 451
    iput-object v13, v0, Lsf/m1;->b:Ljava/lang/String;

    .line 452
    .line 453
    iput-object v14, v0, Lsf/m1;->c:Ljava/lang/String;

    .line 454
    .line 455
    invoke-static {}, Lpf/g;->h()Z

    .line 456
    .line 457
    .line 458
    move-result v5

    .line 459
    iput-boolean v5, v0, Lsf/m1;->d:Z

    .line 460
    .line 461
    iget-byte v5, v0, Lsf/m1;->e:B

    .line 462
    .line 463
    or-int/lit8 v5, v5, 0x2

    .line 464
    .line 465
    int-to-byte v5, v5

    .line 466
    iput-byte v5, v0, Lsf/m1;->e:B

    .line 467
    .line 468
    invoke-virtual {v0}, Lsf/m1;->a()Lsf/n1;

    .line 469
    .line 470
    .line 471
    move-result-object v0

    .line 472
    iput-object v0, v1, Lsf/i0;->i:Lsf/n1;

    .line 473
    .line 474
    new-instance v0, Landroid/os/StatFs;

    .line 475
    .line 476
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    .line 477
    .line 478
    .line 479
    move-result-object v5

    .line 480
    invoke-virtual {v5}, Ljava/io/File;->getPath()Ljava/lang/String;

    .line 481
    .line 482
    .line 483
    move-result-object v5

    .line 484
    invoke-direct {v0, v5}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 485
    .line 486
    .line 487
    sget-object v5, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    .line 488
    .line 489
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    .line 490
    .line 491
    .line 492
    move-result v6

    .line 493
    const/4 v7, 0x7

    .line 494
    if-eqz v6, :cond_2

    .line 495
    .line 496
    goto :goto_2

    .line 497
    :cond_2
    sget-object v6, Lpf/q;->f:Ljava/util/HashMap;

    .line 498
    .line 499
    invoke-virtual {v5, v12}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    .line 500
    .line 501
    .line 502
    move-result-object v5

    .line 503
    invoke-virtual {v6, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 504
    .line 505
    .line 506
    move-result-object v5

    .line 507
    check-cast v5, Ljava/lang/Integer;

    .line 508
    .line 509
    if-nez v5, :cond_3

    .line 510
    .line 511
    goto :goto_2

    .line 512
    :cond_3
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    .line 513
    .line 514
    .line 515
    move-result v7

    .line 516
    :goto_2
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    .line 517
    .line 518
    .line 519
    move-result-object v5

    .line 520
    invoke-virtual {v5}, Ljava/lang/Runtime;->availableProcessors()I

    .line 521
    .line 522
    .line 523
    move-result v5

    .line 524
    iget-object v3, v3, Lpf/q;->a:Landroid/content/Context;

    .line 525
    .line 526
    invoke-static {v3}, Lpf/g;->a(Landroid/content/Context;)J

    .line 527
    .line 528
    .line 529
    move-result-wide v10

    .line 530
    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockCount()I

    .line 531
    .line 532
    .line 533
    move-result v3

    .line 534
    int-to-long v12, v3

    .line 535
    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    .line 536
    .line 537
    .line 538
    move-result v0

    .line 539
    int-to-long v14, v0

    .line 540
    mul-long/2addr v12, v14

    .line 541
    invoke-static {}, Lpf/g;->g()Z

    .line 542
    .line 543
    .line 544
    move-result v0

    .line 545
    invoke-static {}, Lpf/g;->d()I

    .line 546
    .line 547
    .line 548
    move-result v3

    .line 549
    new-instance v6, Lsf/m0;

    .line 550
    .line 551
    invoke-direct {v6}, Ljava/lang/Object;-><init>()V

    .line 552
    .line 553
    .line 554
    iput v7, v6, Lsf/m0;->a:I

    .line 555
    .line 556
    iget-byte v7, v6, Lsf/m0;->j:B

    .line 557
    .line 558
    or-int/lit8 v7, v7, 0x1

    .line 559
    .line 560
    int-to-byte v7, v7

    .line 561
    iput-object v8, v6, Lsf/m0;->b:Ljava/lang/String;

    .line 562
    .line 563
    iput v5, v6, Lsf/m0;->c:I

    .line 564
    .line 565
    or-int/lit8 v5, v7, 0x2

    .line 566
    .line 567
    int-to-byte v5, v5

    .line 568
    iput-wide v10, v6, Lsf/m0;->d:J

    .line 569
    .line 570
    const/4 v7, 0x4

    .line 571
    or-int/2addr v5, v7

    .line 572
    int-to-byte v5, v5

    .line 573
    iput-wide v12, v6, Lsf/m0;->e:J

    .line 574
    .line 575
    or-int/lit8 v5, v5, 0x8

    .line 576
    .line 577
    int-to-byte v5, v5

    .line 578
    iput-boolean v0, v6, Lsf/m0;->f:Z

    .line 579
    .line 580
    or-int/lit8 v0, v5, 0x10

    .line 581
    .line 582
    int-to-byte v0, v0

    .line 583
    iput v3, v6, Lsf/m0;->g:I

    .line 584
    .line 585
    or-int/lit8 v0, v0, 0x20

    .line 586
    .line 587
    int-to-byte v0, v0

    .line 588
    iput-byte v0, v6, Lsf/m0;->j:B

    .line 589
    .line 590
    iput-object v9, v6, Lsf/m0;->h:Ljava/lang/String;

    .line 591
    .line 592
    move-object/from16 v0, v29

    .line 593
    .line 594
    iput-object v0, v6, Lsf/m0;->i:Ljava/lang/String;

    .line 595
    .line 596
    invoke-virtual {v6}, Lsf/m0;->a()Lsf/n0;

    .line 597
    .line 598
    .line 599
    move-result-object v0

    .line 600
    iput-object v0, v1, Lsf/i0;->j:Lsf/n0;

    .line 601
    .line 602
    iput v2, v1, Lsf/i0;->l:I

    .line 603
    .line 604
    iget-byte v0, v1, Lsf/i0;->m:B

    .line 605
    .line 606
    const/4 v2, 0x4

    .line 607
    or-int/2addr v0, v2

    .line 608
    int-to-byte v0, v0

    .line 609
    iput-byte v0, v1, Lsf/i0;->m:B

    .line 610
    .line 611
    invoke-virtual {v1}, Lsf/i0;->a()Lsf/j0;

    .line 612
    .line 613
    .line 614
    move-result-object v0

    .line 615
    iput-object v0, v4, Lsf/a0;->j:Lsf/j0;

    .line 616
    .line 617
    invoke-virtual {v4}, Lsf/a0;->a()Lsf/b0;

    .line 618
    .line 619
    .line 620
    move-result-object v0

    .line 621
    move-object/from16 v1, v16

    .line 622
    .line 623
    iget-object v1, v1, Lvf/c;->b:Ljava/lang/Object;

    .line 624
    .line 625
    check-cast v1, Lvf/a;

    .line 626
    .line 627
    iget-object v1, v1, Lvf/a;->b:Lvf/c;

    .line 628
    .line 629
    iget-object v2, v0, Lsf/b0;->k:Lsf/j0;

    .line 630
    .line 631
    if-nez v2, :cond_4

    .line 632
    .line 633
    goto :goto_4

    .line 634
    :cond_4
    iget-object v3, v2, Lsf/j0;->b:Ljava/lang/String;

    .line 635
    .line 636
    :try_start_1
    sget-object v4, Lvf/a;->g:Ltf/a;

    .line 637
    .line 638
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 639
    .line 640
    .line 641
    sget-object v4, Ltf/a;->a:Landroidx/appcompat/widget/w0;

    .line 642
    .line 643
    invoke-virtual {v4, v0}, Landroidx/appcompat/widget/w0;->j(Ljava/lang/Object;)Ljava/lang/String;

    .line 644
    .line 645
    .line 646
    move-result-object v0

    .line 647
    const-string v4, "report"

    .line 648
    .line 649
    invoke-virtual {v1, v3, v4}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    .line 650
    .line 651
    .line 652
    move-result-object v4

    .line 653
    invoke-static {v4, v0}, Lvf/a;->f(Ljava/io/File;Ljava/lang/String;)V

    .line 654
    .line 655
    .line 656
    const-string v0, "start-time"

    .line 657
    .line 658
    invoke-virtual {v1, v3, v0}, Lvf/c;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    .line 659
    .line 660
    .line 661
    move-result-object v0

    .line 662
    const-string v1, ""

    .line 663
    .line 664
    iget-wide v2, v2, Lsf/j0;->d:J

    .line 665
    .line 666
    new-instance v4, Ljava/io/OutputStreamWriter;

    .line 667
    .line 668
    new-instance v5, Ljava/io/FileOutputStream;

    .line 669
    .line 670
    invoke-direct {v5, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 671
    .line 672
    .line 673
    sget-object v6, Lvf/a;->e:Ljava/nio/charset/Charset;

    .line 674
    .line 675
    invoke-direct {v4, v5, v6}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 676
    .line 677
    .line 678
    :try_start_2
    invoke-virtual {v4, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 679
    .line 680
    .line 681
    const-wide/16 v5, 0x3e8

    .line 682
    .line 683
    mul-long/2addr v2, v5

    .line 684
    invoke-virtual {v0, v2, v3}, Ljava/io/File;->setLastModified(J)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 685
    .line 686
    .line 687
    :try_start_3
    invoke-virtual {v4}, Ljava/io/OutputStreamWriter;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 688
    .line 689
    .line 690
    goto :goto_4

    .line 691
    :catchall_1
    move-exception v0

    .line 692
    move-object v1, v0

    .line 693
    :try_start_4
    invoke-virtual {v4}, Ljava/io/OutputStreamWriter;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 694
    .line 695
    .line 696
    goto :goto_3

    .line 697
    :catchall_2
    move-exception v0

    .line 698
    move-object v2, v0

    .line 699
    :try_start_5
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .line 700
    .line 701
    .line 702
    :goto_3
    throw v1
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    .line 703
    :catch_0
    :goto_4
    return-void

    .line 704
    :cond_5
    new-instance v0, Ljava/lang/NullPointerException;

    .line 705
    .line 706
    const-string v1, "Null identifier"

    .line 707
    .line 708
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 709
    .line 710
    .line 711
    throw v0

    .line 712
    :cond_6
    new-instance v0, Ljava/lang/NullPointerException;

    .line 713
    .line 714
    const-string v1, "Null generator"

    .line 715
    .line 716
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 717
    .line 718
    .line 719
    throw v0

    .line 720
    :cond_7
    new-instance v0, Ljava/lang/NullPointerException;

    .line 721
    .line 722
    const-string v1, "Null identifier"

    .line 723
    .line 724
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 725
    .line 726
    .line 727
    throw v0

    .line 728
    :cond_8
    new-instance v0, Ljava/lang/NullPointerException;

    .line 729
    .line 730
    const-string v1, "Null displayVersion"

    .line 731
    .line 732
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 733
    .line 734
    .line 735
    throw v0

    .line 736
    :cond_9
    new-instance v0, Ljava/lang/NullPointerException;

    .line 737
    .line 738
    const-string v1, "Null buildVersion"

    .line 739
    .line 740
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 741
    .line 742
    .line 743
    throw v0

    .line 744
    :cond_a
    new-instance v0, Ljava/lang/NullPointerException;

    .line 745
    .line 746
    const-string v1, "Null installationUuid"

    .line 747
    .line 748
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 749
    .line 750
    .line 751
    throw v0

    .line 752
    :cond_b
    new-instance v0, Ljava/lang/NullPointerException;

    .line 753
    .line 754
    const-string v1, "Null gmpAppId"

    .line 755
    .line 756
    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .line 757
    .line 758
    .line 759
    throw v0
.end method

.method public final d(J)V
    .locals 3

    .line 1
    const-string v0, ".ae"

    .line 2
    .line 3
    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/common/a;->g:Lvf/c;

    .line 4
    .line 5
    new-instance v2, Ljava/lang/StringBuilder;

    .line 6
    .line 7
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 8
    .line 9
    .line 10
    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 11
    .line 12
    .line 13
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 14
    .line 15
    .line 16
    move-result-object p1

    .line 17
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 18
    .line 19
    .line 20
    new-instance p2, Ljava/io/File;

    .line 21
    .line 22
    iget-object v0, v1, Lvf/c;->c:Ljava/lang/Object;

    .line 23
    .line 24
    check-cast v0, Ljava/io/File;

    .line 25
    .line 26
    invoke-direct {p2, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 27
    .line 28
    .line 29
    invoke-virtual {p2}, Ljava/io/File;->createNewFile()Z

    .line 30
    .line 31
    .line 32
    move-result p1

    .line 33
    if-eqz p1, :cond_0

    .line 34
    .line 35
    goto :goto_0

    .line 36
    :cond_0
    new-instance p1, Ljava/io/IOException;

    .line 37
    .line 38
    const-string p2, "Create new file failed."

    .line 39
    .line 40
    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 41
    .line 42
    .line 43
    throw p1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 44
    :catch_0
    :goto_0
    return-void
.end method

.method public final e()Ljava/lang/String;
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 2
    .line 3
    iget-object v0, v0, Lvf/c;->b:Ljava/lang/Object;

    .line 4
    .line 5
    check-cast v0, Lvf/a;

    .line 6
    .line 7
    invoke-virtual {v0}, Lvf/a;->c()Ljava/util/NavigableSet;

    .line 8
    .line 9
    .line 10
    move-result-object v0

    .line 11
    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    .line 12
    .line 13
    .line 14
    move-result v1

    .line 15
    if-nez v1, :cond_0

    .line 16
    .line 17
    invoke-interface {v0}, Ljava/util/SortedSet;->first()Ljava/lang/Object;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    check-cast v0, Ljava/lang/String;

    .line 22
    .line 23
    goto :goto_0

    .line 24
    :cond_0
    const/4 v0, 0x0

    .line 25
    :goto_0
    return-object v0
.end method

.method public final f()V
    .locals 8

    .line 1
    :try_start_0
    const-class v0, Lcom/google/firebase/crashlytics/internal/common/a;

    .line 2
    .line 3
    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    .line 4
    .line 5
    .line 6
    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 7
    const-string v1, "FirebaseCrashlytics"

    .line 8
    .line 9
    const/4 v2, 0x0

    .line 10
    if-nez v0, :cond_0

    .line 11
    .line 12
    :goto_0
    move-object v0, v2

    .line 13
    goto :goto_1

    .line 14
    :cond_0
    :try_start_1
    const-string v3, "META-INF/version-control-info.textproto"

    .line 15
    .line 16
    invoke-virtual {v0, v3}, Ljava/lang/ClassLoader;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    .line 17
    .line 18
    .line 19
    move-result-object v0

    .line 20
    if-nez v0, :cond_1

    .line 21
    .line 22
    const-string v0, "No version control information found"

    .line 23
    .line 24
    invoke-static {v1, v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 25
    .line 26
    .line 27
    goto :goto_0

    .line 28
    :cond_1
    :goto_1
    const/4 v3, 0x0

    .line 29
    if-nez v0, :cond_2

    .line 30
    .line 31
    move-object v0, v2

    .line 32
    goto :goto_3

    .line 33
    :cond_2
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    .line 34
    .line 35
    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 36
    .line 37
    .line 38
    const/16 v5, 0x400

    .line 39
    .line 40
    new-array v5, v5, [B

    .line 41
    .line 42
    :goto_2
    invoke-virtual {v0, v5}, Ljava/io/InputStream;->read([B)I

    .line 43
    .line 44
    .line 45
    move-result v6

    .line 46
    const/4 v7, -0x1

    .line 47
    if-eq v6, v7, :cond_3

    .line 48
    .line 49
    invoke-virtual {v4, v5, v3, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 50
    .line 51
    .line 52
    goto :goto_2

    .line 53
    :cond_3
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    .line 54
    .line 55
    .line 56
    move-result-object v0

    .line 57
    invoke-static {v0, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    .line 58
    .line 59
    .line 60
    move-result-object v0

    .line 61
    :goto_3
    if-eqz v0, :cond_7

    .line 62
    .line 63
    const-string v4, "com.crashlytics.version-control-info"
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 64
    .line 65
    :try_start_2
    iget-object v5, p0, Lcom/google/firebase/crashlytics/internal/common/a;->d:Lvf/c;

    .line 66
    .line 67
    iget-object v5, v5, Lvf/c;->e:Ljava/lang/Object;

    .line 68
    .line 69
    check-cast v5, Lb6/j;

    .line 70
    .line 71
    invoke-virtual {v5, v4, v0}, Lb6/j;->h(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 72
    .line 73
    .line 74
    goto :goto_5

    .line 75
    :catch_0
    move-exception v0

    .line 76
    :try_start_3
    iget-object v4, p0, Lcom/google/firebase/crashlytics/internal/common/a;->a:Landroid/content/Context;

    .line 77
    .line 78
    if-eqz v4, :cond_6

    .line 79
    .line 80
    invoke-virtual {v4}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    .line 81
    .line 82
    .line 83
    move-result-object v4

    .line 84
    iget v4, v4, Landroid/content/pm/ApplicationInfo;->flags:I

    .line 85
    .line 86
    and-int/lit8 v4, v4, 0x2

    .line 87
    .line 88
    if-eqz v4, :cond_4

    .line 89
    .line 90
    const/4 v3, 0x1

    .line 91
    :cond_4
    if-nez v3, :cond_5

    .line 92
    .line 93
    goto :goto_4

    .line 94
    :cond_5
    throw v0

    .line 95
    :cond_6
    :goto_4
    const-string v0, "Attempting to set custom attribute with null key, ignoring."

    .line 96
    .line 97
    invoke-static {v1, v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 98
    .line 99
    .line 100
    :goto_5
    const-string v0, "Saved version control info"

    .line 101
    .line 102
    invoke-static {v1, v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 103
    .line 104
    .line 105
    :catch_1
    :cond_7
    return-void
.end method

.method public final g(Lcom/google/android/gms/tasks/Task;)V
    .locals 3

    .line 1
    iget-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->m:Lvf/c;

    .line 2
    .line 3
    iget-object v0, v0, Lvf/c;->b:Ljava/lang/Object;

    .line 4
    .line 5
    check-cast v0, Lvf/a;

    .line 6
    .line 7
    iget-object v0, v0, Lvf/a;->b:Lvf/c;

    .line 8
    .line 9
    iget-object v1, v0, Lvf/c;->e:Ljava/lang/Object;

    .line 10
    .line 11
    check-cast v1, Ljava/io/File;

    .line 12
    .line 13
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    .line 14
    .line 15
    .line 16
    move-result-object v1

    .line 17
    invoke-static {v1}, Lvf/c;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 18
    .line 19
    .line 20
    move-result-object v1

    .line 21
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    .line 22
    .line 23
    .line 24
    move-result v1

    .line 25
    iget-object v2, p0, Lcom/google/firebase/crashlytics/internal/common/a;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 26
    .line 27
    if-eqz v1, :cond_1

    .line 28
    .line 29
    iget-object v1, v0, Lvf/c;->f:Ljava/lang/Object;

    .line 30
    .line 31
    check-cast v1, Ljava/io/File;

    .line 32
    .line 33
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    .line 34
    .line 35
    .line 36
    move-result-object v1

    .line 37
    invoke-static {v1}, Lvf/c;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 38
    .line 39
    .line 40
    move-result-object v1

    .line 41
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    .line 42
    .line 43
    .line 44
    move-result v1

    .line 45
    if-eqz v1, :cond_1

    .line 46
    .line 47
    iget-object v0, v0, Lvf/c;->g:Ljava/lang/Object;

    .line 48
    .line 49
    check-cast v0, Ljava/io/File;

    .line 50
    .line 51
    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    .line 52
    .line 53
    .line 54
    move-result-object v0

    .line 55
    invoke-static {v0}, Lvf/c;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 56
    .line 57
    .line 58
    move-result-object v0

    .line 59
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    .line 60
    .line 61
    .line 62
    move-result v0

    .line 63
    if-nez v0, :cond_0

    .line 64
    .line 65
    goto :goto_0

    .line 66
    :cond_0
    sget-object p1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 67
    .line 68
    invoke-virtual {v2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 69
    .line 70
    .line 71
    return-void

    .line 72
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/google/firebase/crashlytics/internal/common/a;->b:Lpf/s;

    .line 73
    .line 74
    invoke-virtual {v0}, Lpf/s;->b()Z

    .line 75
    .line 76
    .line 77
    move-result v1

    .line 78
    if-eqz v1, :cond_2

    .line 79
    .line 80
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 81
    .line 82
    invoke-virtual {v2, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 83
    .line 84
    .line 85
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 86
    .line 87
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 88
    .line 89
    .line 90
    move-result-object v0

    .line 91
    goto :goto_1

    .line 92
    :cond_2
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 93
    .line 94
    invoke-virtual {v2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 95
    .line 96
    .line 97
    iget-object v1, v0, Lpf/s;->c:Ljava/lang/Object;

    .line 98
    .line 99
    monitor-enter v1

    .line 100
    :try_start_0
    iget-object v0, v0, Lpf/s;->d:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 101
    .line 102
    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 103
    .line 104
    .line 105
    move-result-object v0

    .line 106
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 107
    new-instance v1, Lcom/crazymaple/reelshort/novel/htmltext/f;

    .line 108
    .line 109
    invoke-direct {v1}, Lcom/crazymaple/reelshort/novel/htmltext/f;-><init>()V

    .line 110
    .line 111
    .line 112
    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    .line 113
    .line 114
    .line 115
    move-result-object v0

    .line 116
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/common/a;->p:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 117
    .line 118
    invoke-virtual {v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    .line 119
    .line 120
    .line 121
    move-result-object v1

    .line 122
    invoke-static {v0, v1}, Lqf/a;->a(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    .line 123
    .line 124
    .line 125
    move-result-object v0

    .line 126
    :goto_1
    iget-object v1, p0, Lcom/google/firebase/crashlytics/internal/common/a;->e:Lcom/google/firebase/crashlytics/internal/concurrency/a;

    .line 127
    .line 128
    iget-object v1, v1, Lcom/google/firebase/crashlytics/internal/concurrency/a;->a:Lqf/b;

    .line 129
    .line 130
    new-instance v2, Lgc/i;

    .line 131
    .line 132
    invoke-direct {v2, p0, p1}, Lgc/i;-><init>(Lcom/google/firebase/crashlytics/internal/common/a;Lcom/google/android/gms/tasks/Task;)V

    .line 133
    .line 134
    .line 135
    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    .line 136
    .line 137
    .line 138
    return-void

    .line 139
    :catchall_0
    move-exception p1

    .line 140
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 141
    throw p1
.end method
