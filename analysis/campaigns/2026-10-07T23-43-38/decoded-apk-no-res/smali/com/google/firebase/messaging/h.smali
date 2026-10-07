.class public final Lcom/google/firebase/messaging/h;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final c:Ljava/lang/Object;

.field public static d:Lcom/google/firebase/messaging/h0;


# instance fields
.field public final a:Ljava/lang/Object;

.field public final b:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/lang/Object;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/messaging/h;->c:Ljava/lang/Object;

    .line 7
    .line 8
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    iput-object p1, p0, Lcom/google/firebase/messaging/h;->a:Ljava/lang/Object;

    .line 8
    new-instance p1, Landroidx/arch/core/executor/a;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Landroidx/arch/core/executor/a;-><init>(I)V

    iput-object p1, p0, Lcom/google/firebase/messaging/h;->b:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Ljava/util/concurrent/ExecutorService;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Landroidx/collection/g;

    const/4 v1, 0x0

    .line 3
    invoke-direct {v0, v1}, Landroidx/collection/c0;-><init>(I)V

    .line 4
    iput-object v0, p0, Lcom/google/firebase/messaging/h;->b:Ljava/lang/Object;

    .line 5
    iput-object p1, p0, Lcom/google/firebase/messaging/h;->a:Ljava/lang/Object;

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/content/Intent;Z)Lcom/google/android/gms/tasks/Task;
    .locals 2

    .line 1
    sget-object v0, Lcom/google/firebase/messaging/h;->c:Ljava/lang/Object;

    .line 2
    .line 3
    monitor-enter v0

    .line 4
    :try_start_0
    sget-object v1, Lcom/google/firebase/messaging/h;->d:Lcom/google/firebase/messaging/h0;

    .line 5
    .line 6
    if-nez v1, :cond_0

    .line 7
    .line 8
    new-instance v1, Lcom/google/firebase/messaging/h0;

    .line 9
    .line 10
    invoke-direct {v1, p0}, Lcom/google/firebase/messaging/h0;-><init>(Landroid/content/Context;)V

    .line 11
    .line 12
    .line 13
    sput-object v1, Lcom/google/firebase/messaging/h;->d:Lcom/google/firebase/messaging/h0;

    .line 14
    .line 15
    goto :goto_0

    .line 16
    :catchall_0
    move-exception p0

    .line 17
    goto :goto_2

    .line 18
    :cond_0
    :goto_0
    sget-object v1, Lcom/google/firebase/messaging/h;->d:Lcom/google/firebase/messaging/h0;

    .line 19
    .line 20
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 21
    if-eqz p2, :cond_2

    .line 22
    .line 23
    invoke-static {}, Lcom/google/firebase/messaging/u;->c()Lcom/google/firebase/messaging/u;

    .line 24
    .line 25
    .line 26
    move-result-object p2

    .line 27
    invoke-virtual {p2, p0}, Lcom/google/firebase/messaging/u;->e(Landroid/content/Context;)Z

    .line 28
    .line 29
    .line 30
    move-result p2

    .line 31
    if-eqz p2, :cond_1

    .line 32
    .line 33
    invoke-static {p0, v1, p1}, Lcom/google/firebase/messaging/e0;->b(Landroid/content/Context;Lcom/google/firebase/messaging/h0;Landroid/content/Intent;)V

    .line 34
    .line 35
    .line 36
    goto :goto_1

    .line 37
    :cond_1
    invoke-virtual {v1, p1}, Lcom/google/firebase/messaging/h0;->b(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    .line 38
    .line 39
    .line 40
    :goto_1
    const/4 p0, -0x1

    .line 41
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 42
    .line 43
    .line 44
    move-result-object p0

    .line 45
    invoke-static {p0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    .line 46
    .line 47
    .line 48
    move-result-object p0

    .line 49
    return-object p0

    .line 50
    :cond_2
    invoke-virtual {v1, p1}, Lcom/google/firebase/messaging/h0;->b(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    .line 51
    .line 52
    .line 53
    move-result-object p0

    .line 54
    new-instance p1, Landroidx/arch/core/executor/a;

    .line 55
    .line 56
    const/4 p2, 0x2

    .line 57
    invoke-direct {p1, p2}, Landroidx/arch/core/executor/a;-><init>(I)V

    .line 58
    .line 59
    .line 60
    new-instance p2, Landroidx/core/view/h;

    .line 61
    .line 62
    const/16 v0, 0xe

    .line 63
    .line 64
    invoke-direct {p2, v0}, Landroidx/core/view/h;-><init>(I)V

    .line 65
    .line 66
    .line 67
    invoke-virtual {p0, p1, p2}, Lcom/google/android/gms/tasks/Task;->continueWith(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    .line 68
    .line 69
    .line 70
    move-result-object p0

    .line 71
    return-object p0

    .line 72
    :goto_2
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 73
    throw p0
.end method


# virtual methods
.method public b(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;
    .locals 6

    .line 1
    const-string v0, "gcm.rawData64"

    .line 2
    .line 3
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    const/4 v2, 0x0

    .line 8
    if-eqz v1, :cond_0

    .line 9
    .line 10
    const-string v3, "rawData"

    .line 11
    .line 12
    invoke-static {v1, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    .line 13
    .line 14
    .line 15
    move-result-object v1

    .line 16
    invoke-virtual {p1, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    .line 17
    .line 18
    .line 19
    invoke-virtual {p1, v0}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 20
    .line 21
    .line 22
    :cond_0
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastO()Z

    .line 23
    .line 24
    .line 25
    move-result v0

    .line 26
    iget-object v1, p0, Lcom/google/firebase/messaging/h;->a:Ljava/lang/Object;

    .line 27
    .line 28
    check-cast v1, Landroid/content/Context;

    .line 29
    .line 30
    const/4 v3, 0x1

    .line 31
    if-eqz v0, :cond_1

    .line 32
    .line 33
    invoke-virtual {v1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    .line 34
    .line 35
    .line 36
    move-result-object v0

    .line 37
    iget v0, v0, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    .line 38
    .line 39
    const/16 v4, 0x1a

    .line 40
    .line 41
    if-lt v0, v4, :cond_1

    .line 42
    .line 43
    move v0, v3

    .line 44
    goto :goto_0

    .line 45
    :cond_1
    move v0, v2

    .line 46
    :goto_0
    invoke-virtual {p1}, Landroid/content/Intent;->getFlags()I

    .line 47
    .line 48
    .line 49
    move-result v4

    .line 50
    const/high16 v5, 0x10000000

    .line 51
    .line 52
    and-int/2addr v4, v5

    .line 53
    if-eqz v4, :cond_2

    .line 54
    .line 55
    move v2, v3

    .line 56
    :cond_2
    if-eqz v0, :cond_3

    .line 57
    .line 58
    if-nez v2, :cond_3

    .line 59
    .line 60
    invoke-static {v1, p1, v2}, Lcom/google/firebase/messaging/h;->a(Landroid/content/Context;Landroid/content/Intent;Z)Lcom/google/android/gms/tasks/Task;

    .line 61
    .line 62
    .line 63
    move-result-object p1

    .line 64
    goto :goto_1

    .line 65
    :cond_3
    iget-object v0, p0, Lcom/google/firebase/messaging/h;->b:Ljava/lang/Object;

    .line 66
    .line 67
    check-cast v0, Landroidx/arch/core/executor/a;

    .line 68
    .line 69
    new-instance v3, Landroidx/work/impl/b0;

    .line 70
    .line 71
    const/4 v4, 0x3

    .line 72
    invoke-direct {v3, v4, v1, p1}, Landroidx/work/impl/b0;-><init>(ILjava/lang/Object;Ljava/lang/Object;)V

    .line 73
    .line 74
    .line 75
    invoke-static {v0, v3}, Lcom/google/android/gms/tasks/Tasks;->call(Ljava/util/concurrent/Executor;Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    .line 76
    .line 77
    .line 78
    move-result-object v3

    .line 79
    new-instance v4, Lcom/google/firebase/messaging/g;

    .line 80
    .line 81
    invoke-direct {v4, v1, p1, v2}, Lcom/google/firebase/messaging/g;-><init>(Landroid/content/Context;Landroid/content/Intent;Z)V

    .line 82
    .line 83
    .line 84
    invoke-virtual {v3, v0, v4}, Lcom/google/android/gms/tasks/Task;->continueWithTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    .line 85
    .line 86
    .line 87
    move-result-object p1

    .line 88
    :goto_1
    return-object p1
.end method
