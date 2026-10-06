.class public Lcom/google/firebase/analytics/connector/internal/AnalyticsConnectorRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroidx/annotation/Keep;
.end annotation

.annotation build Lcom/google/android/gms/common/annotation/KeepForSdk;
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static lambda$getComponents$0(Ljf/c;)Lgf/a;
    .locals 7

    .line 1
    const-class v0, Lef/h;

    .line 2
    .line 3
    invoke-interface {p0, v0}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    check-cast v0, Lef/h;

    .line 8
    .line 9
    const-class v1, Landroid/content/Context;

    .line 10
    .line 11
    invoke-interface {p0, v1}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 12
    .line 13
    .line 14
    move-result-object v1

    .line 15
    check-cast v1, Landroid/content/Context;

    .line 16
    .line 17
    const-class v2, Lhg/c;

    .line 18
    .line 19
    invoke-interface {p0, v2}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object p0

    .line 23
    check-cast p0, Lhg/c;

    .line 24
    .line 25
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 26
    .line 27
    .line 28
    invoke-static {v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 29
    .line 30
    .line 31
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 32
    .line 33
    .line 34
    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    .line 35
    .line 36
    .line 37
    move-result-object v2

    .line 38
    invoke-static {v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 39
    .line 40
    .line 41
    sget-object v2, Lgf/b;->c:Lgf/b;

    .line 42
    .line 43
    if-nez v2, :cond_2

    .line 44
    .line 45
    const-class v2, Lgf/b;

    .line 46
    .line 47
    monitor-enter v2

    .line 48
    :try_start_0
    sget-object v3, Lgf/b;->c:Lgf/b;

    .line 49
    .line 50
    if-nez v3, :cond_1

    .line 51
    .line 52
    new-instance v3, Landroid/os/Bundle;

    .line 53
    .line 54
    const/4 v4, 0x1

    .line 55
    invoke-direct {v3, v4}, Landroid/os/Bundle;-><init>(I)V

    .line 56
    .line 57
    .line 58
    invoke-virtual {v0}, Lef/h;->a()V

    .line 59
    .line 60
    .line 61
    const-string v4, "[DEFAULT]"

    .line 62
    .line 63
    iget-object v5, v0, Lef/h;->b:Ljava/lang/String;

    .line 64
    .line 65
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 66
    .line 67
    .line 68
    move-result v4

    .line 69
    if-eqz v4, :cond_0

    .line 70
    .line 71
    new-instance v4, Landroidx/appcompat/app/s;

    .line 72
    .line 73
    const/4 v5, 0x3

    .line 74
    invoke-direct {v4, v5}, Landroidx/appcompat/app/s;-><init>(I)V

    .line 75
    .line 76
    .line 77
    new-instance v5, Lcom/moloco/sdk/acm/db/a;

    .line 78
    .line 79
    const/16 v6, 0x11

    .line 80
    .line 81
    invoke-direct {v5, v6}, Lcom/moloco/sdk/acm/db/a;-><init>(I)V

    .line 82
    .line 83
    .line 84
    check-cast p0, Ljf/j;

    .line 85
    .line 86
    invoke-virtual {p0, v4, v5}, Ljf/j;->a(Ljava/util/concurrent/Executor;Lhg/a;)V

    .line 87
    .line 88
    .line 89
    const-string p0, "dataCollectionDefaultEnabled"

    .line 90
    .line 91
    invoke-virtual {v0}, Lef/h;->g()Z

    .line 92
    .line 93
    .line 94
    move-result v0

    .line 95
    invoke-virtual {v3, p0, v0}, Landroid/os/BaseBundle;->putBoolean(Ljava/lang/String;Z)V

    .line 96
    .line 97
    .line 98
    goto :goto_0

    .line 99
    :catchall_0
    move-exception p0

    .line 100
    goto :goto_1

    .line 101
    :cond_0
    :goto_0
    new-instance p0, Lgf/b;

    .line 102
    .line 103
    const/4 v0, 0x0

    .line 104
    invoke-static {v1, v0, v0, v0, v3}, Lcom/google/android/gms/internal/measurement/zzed;->zza(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Lcom/google/android/gms/internal/measurement/zzed;

    .line 105
    .line 106
    .line 107
    move-result-object v0

    .line 108
    invoke-virtual {v0}, Lcom/google/android/gms/internal/measurement/zzed;->zzb()Lcom/google/android/gms/measurement/api/AppMeasurementSdk;

    .line 109
    .line 110
    .line 111
    move-result-object v0

    .line 112
    invoke-direct {p0, v0}, Lgf/b;-><init>(Lcom/google/android/gms/measurement/api/AppMeasurementSdk;)V

    .line 113
    .line 114
    .line 115
    sput-object p0, Lgf/b;->c:Lgf/b;

    .line 116
    .line 117
    :cond_1
    monitor-exit v2

    .line 118
    goto :goto_2

    .line 119
    :goto_1
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 120
    throw p0

    .line 121
    :cond_2
    :goto_2
    sget-object p0, Lgf/b;->c:Lgf/b;

    .line 122
    .line 123
    return-object p0
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "MissingPermission"
        }
    .end annotation

    .annotation build Landroidx/annotation/Keep;
    .end annotation

    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    .annotation build Lcom/google/android/gms/common/annotation/KeepForSdk;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljf/b;",
            ">;"
        }
    .end annotation

    .line 1
    const/4 v0, 0x2

    .line 2
    const-class v1, Lgf/a;

    .line 3
    .line 4
    invoke-static {v1}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 5
    .line 6
    .line 7
    move-result-object v1

    .line 8
    const-class v2, Lef/h;

    .line 9
    .line 10
    invoke-static {v2}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 11
    .line 12
    .line 13
    move-result-object v2

    .line 14
    invoke-virtual {v1, v2}, Ljf/a;->a(Ljf/i;)V

    .line 15
    .line 16
    .line 17
    const-class v2, Landroid/content/Context;

    .line 18
    .line 19
    invoke-static {v2}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 20
    .line 21
    .line 22
    move-result-object v2

    .line 23
    invoke-virtual {v1, v2}, Ljf/a;->a(Ljf/i;)V

    .line 24
    .line 25
    .line 26
    const-class v2, Lhg/c;

    .line 27
    .line 28
    invoke-static {v2}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 29
    .line 30
    .line 31
    move-result-object v2

    .line 32
    invoke-virtual {v1, v2}, Ljf/a;->a(Ljf/i;)V

    .line 33
    .line 34
    .line 35
    new-instance v2, Lcom/moloco/sdk/acm/db/a;

    .line 36
    .line 37
    const/16 v3, 0x14

    .line 38
    .line 39
    invoke-direct {v2, v3}, Lcom/moloco/sdk/acm/db/a;-><init>(I)V

    .line 40
    .line 41
    .line 42
    iput-object v2, v1, Ljf/a;->f:Ljf/e;

    .line 43
    .line 44
    invoke-virtual {v1, v0}, Ljf/a;->c(I)V

    .line 45
    .line 46
    .line 47
    invoke-virtual {v1}, Ljf/a;->b()Ljf/b;

    .line 48
    .line 49
    .line 50
    move-result-object v1

    .line 51
    const-string v2, "fire-analytics"

    .line 52
    .line 53
    const-string v3, "22.2.0"

    .line 54
    .line 55
    invoke-static {v2, v3}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 56
    .line 57
    .line 58
    move-result-object v2

    .line 59
    new-array v0, v0, [Ljf/b;

    .line 60
    .line 61
    const/4 v3, 0x0

    .line 62
    aput-object v1, v0, v3

    .line 63
    .line 64
    const/4 v1, 0x1

    .line 65
    aput-object v2, v0, v1

    .line 66
    .line 67
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 68
    .line 69
    .line 70
    move-result-object v0

    .line 71
    return-object v0
.end method
