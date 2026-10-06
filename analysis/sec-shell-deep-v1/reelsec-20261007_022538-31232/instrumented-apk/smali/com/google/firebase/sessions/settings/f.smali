.class public final Lcom/google/firebase/sessions/settings/f;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final c:Landroidx/datastore/preferences/core/e;

.field public static final d:Landroidx/datastore/preferences/core/e;

.field public static final e:Landroidx/datastore/preferences/core/e;

.field public static final f:Landroidx/datastore/preferences/core/e;

.field public static final g:Landroidx/datastore/preferences/core/e;


# instance fields
.field public final a:Landroidx/datastore/core/h;

.field public b:Lcom/google/firebase/sessions/settings/c;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    const-string v0, "firebase_sessions_enabled"

    .line 2
    .line 3
    const-string v1, "name"

    .line 4
    .line 5
    invoke-static {v0, v1, v0}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    sput-object v0, Lcom/google/firebase/sessions/settings/f;->c:Landroidx/datastore/preferences/core/e;

    .line 10
    .line 11
    const-string v0, "firebase_sessions_sampling_rate"

    .line 12
    .line 13
    invoke-static {v0, v1, v0}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 14
    .line 15
    .line 16
    move-result-object v0

    .line 17
    sput-object v0, Lcom/google/firebase/sessions/settings/f;->d:Landroidx/datastore/preferences/core/e;

    .line 18
    .line 19
    const-string v0, "firebase_sessions_restart_timeout"

    .line 20
    .line 21
    invoke-static {v0, v1, v0}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    sput-object v0, Lcom/google/firebase/sessions/settings/f;->e:Landroidx/datastore/preferences/core/e;

    .line 26
    .line 27
    const-string v0, "firebase_sessions_cache_duration"

    .line 28
    .line 29
    invoke-static {v0, v1, v0}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 30
    .line 31
    .line 32
    move-result-object v0

    .line 33
    sput-object v0, Lcom/google/firebase/sessions/settings/f;->f:Landroidx/datastore/preferences/core/e;

    .line 34
    .line 35
    const-string v0, "firebase_sessions_cache_updated_time"

    .line 36
    .line 37
    invoke-static {v0, v1, v0}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 38
    .line 39
    .line 40
    move-result-object v0

    .line 41
    sput-object v0, Lcom/google/firebase/sessions/settings/f;->g:Landroidx/datastore/preferences/core/e;

    .line 42
    .line 43
    return-void
.end method

.method public constructor <init>(Landroidx/datastore/core/h;)V
    .locals 1

    .line 1
    const-string v0, "dataStore"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    .line 8
    .line 9
    iput-object p1, p0, Lcom/google/firebase/sessions/settings/f;->a:Landroidx/datastore/core/h;

    .line 10
    .line 11
    new-instance p1, Lcom/google/firebase/sessions/settings/SettingsCache$1;

    .line 12
    .line 13
    const/4 v0, 0x0

    .line 14
    invoke-direct {p1, p0, v0}, Lcom/google/firebase/sessions/settings/SettingsCache$1;-><init>(Lcom/google/firebase/sessions/settings/f;Lwakotl/coroutines/Continuation;)V

    .line 15
    .line 16
    .line 17
    invoke-static {p1}, Lkotlinx/coroutines/g0;->F(Lwakotl/jvm/functions/Function2;)Ljava/lang/Object;

    .line 18
    .line 19
    .line 20
    return-void
.end method

.method public static final a(Lcom/google/firebase/sessions/settings/f;Landroidx/datastore/preferences/core/g;)V
    .locals 7

    .line 1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    new-instance v6, Lcom/google/firebase/sessions/settings/c;

    .line 5
    .line 6
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->c:Landroidx/datastore/preferences/core/e;

    .line 7
    .line 8
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    move-object v1, v0

    .line 13
    check-cast v1, Ljava/lang/Boolean;

    .line 14
    .line 15
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->d:Landroidx/datastore/preferences/core/e;

    .line 16
    .line 17
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    move-object v2, v0

    .line 22
    check-cast v2, Ljava/lang/Double;

    .line 23
    .line 24
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->e:Landroidx/datastore/preferences/core/e;

    .line 25
    .line 26
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 27
    .line 28
    .line 29
    move-result-object v0

    .line 30
    move-object v3, v0

    .line 31
    check-cast v3, Ljava/lang/Integer;

    .line 32
    .line 33
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->f:Landroidx/datastore/preferences/core/e;

    .line 34
    .line 35
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 36
    .line 37
    .line 38
    move-result-object v0

    .line 39
    move-object v4, v0

    .line 40
    check-cast v4, Ljava/lang/Integer;

    .line 41
    .line 42
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->g:Landroidx/datastore/preferences/core/e;

    .line 43
    .line 44
    invoke-virtual {p1, v0}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 45
    .line 46
    .line 47
    move-result-object p1

    .line 48
    move-object v5, p1

    .line 49
    check-cast v5, Ljava/lang/Long;

    .line 50
    .line 51
    move-object v0, v6

    .line 52
    invoke-direct/range {v0 .. v5}, Lcom/google/firebase/sessions/settings/c;-><init>(Ljava/lang/Boolean;Ljava/lang/Double;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Long;)V

    .line 53
    .line 54
    .line 55
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/f;->b:Lcom/google/firebase/sessions/settings/c;

    .line 56
    .line 57
    return-void
.end method


# virtual methods
.method public final b()Z
    .locals 6

    .line 1
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/f;->b:Lcom/google/firebase/sessions/settings/c;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    const-string v2, "sessionConfigs"

    .line 5
    .line 6
    if-eqz v0, :cond_2

    .line 7
    .line 8
    if-eqz v0, :cond_1

    .line 9
    .line 10
    iget-object v1, v0, Lcom/google/firebase/sessions/settings/c;->e:Ljava/lang/Long;

    .line 11
    .line 12
    if-eqz v1, :cond_0

    .line 13
    .line 14
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/c;->d:Ljava/lang/Integer;

    .line 15
    .line 16
    if-eqz v0, :cond_0

    .line 17
    .line 18
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 19
    .line 20
    .line 21
    move-result-wide v2

    .line 22
    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    .line 23
    .line 24
    .line 25
    move-result-wide v4

    .line 26
    sub-long/2addr v2, v4

    .line 27
    const/16 v1, 0x3e8

    .line 28
    .line 29
    int-to-long v4, v1

    .line 30
    div-long/2addr v2, v4

    .line 31
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    .line 32
    .line 33
    .line 34
    move-result v0

    .line 35
    int-to-long v0, v0

    .line 36
    cmp-long v0, v2, v0

    .line 37
    .line 38
    if-gez v0, :cond_0

    .line 39
    .line 40
    const/4 v0, 0x0

    .line 41
    return v0

    .line 42
    :cond_0
    const/4 v0, 0x1

    .line 43
    return v0

    .line 44
    :cond_1
    invoke-static {v2}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 45
    .line 46
    .line 47
    throw v1

    .line 48
    :cond_2
    invoke-static {v2}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 49
    .line 50
    .line 51
    throw v1
.end method

.method public final c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;
    .locals 5

    .line 1
    instance-of v0, p3, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    move-object v0, p3

    .line 6
    check-cast v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;

    .line 7
    .line 8
    iget v1, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;->label:I

    .line 9
    .line 10
    const/high16 v2, -0x80000000

    .line 11
    .line 12
    and-int v3, v1, v2

    .line 13
    .line 14
    if-eqz v3, :cond_0

    .line 15
    .line 16
    sub-int/2addr v1, v2

    .line 17
    iput v1, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;->label:I

    .line 18
    .line 19
    goto :goto_0

    .line 20
    :cond_0
    new-instance v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;

    .line 21
    .line 22
    invoke-direct {v0, p0, p3}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;-><init>(Lcom/google/firebase/sessions/settings/f;Lwakotl/coroutines/Continuation;)V

    .line 23
    .line 24
    .line 25
    :goto_0
    iget-object p3, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;->result:Ljava/lang/Object;

    .line 26
    .line 27
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 28
    .line 29
    .line 30
    move-result-object v1

    .line 31
    iget v2, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;->label:I

    .line 32
    .line 33
    const/4 v3, 0x1

    .line 34
    if-eqz v2, :cond_2

    .line 35
    .line 36
    if-ne v2, v3, :cond_1

    .line 37
    .line 38
    :try_start_0
    invoke-static {p3}, Lwakotl/b;->b(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 39
    .line 40
    .line 41
    goto :goto_2

    .line 42
    :catch_0
    move-exception p1

    .line 43
    goto :goto_1

    .line 44
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 45
    .line 46
    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    .line 47
    .line 48
    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 49
    .line 50
    .line 51
    throw p1

    .line 52
    :cond_2
    invoke-static {p3}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 53
    .line 54
    .line 55
    :try_start_1
    iget-object p3, p0, Lcom/google/firebase/sessions/settings/f;->a:Landroidx/datastore/core/h;

    .line 56
    .line 57
    new-instance v2, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;

    .line 58
    .line 59
    const/4 v4, 0x0

    .line 60
    invoke-direct {v2, p2, p1, p0, v4}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;-><init>(Ljava/lang/Object;Landroidx/datastore/preferences/core/e;Lcom/google/firebase/sessions/settings/f;Lwakotl/coroutines/Continuation;)V

    .line 61
    .line 62
    .line 63
    iput v3, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$1;->label:I

    .line 64
    .line 65
    invoke-static {p3, v2, v0}, Landroidx/datastore/preferences/core/d;->b(Landroidx/datastore/core/h;Lwakotl/jvm/functions/Function2;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 66
    .line 67
    .line 68
    move-result-object p1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 69
    if-ne p1, v1, :cond_3

    .line 70
    .line 71
    return-object v1

    .line 72
    :goto_1
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    .line 73
    .line 74
    .line 75
    :cond_3
    :goto_2
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 76
    .line 77
    return-object p1
.end method
