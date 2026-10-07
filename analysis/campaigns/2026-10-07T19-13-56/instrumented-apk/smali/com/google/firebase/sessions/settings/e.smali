.class public final Lcom/google/firebase/sessions/settings/e;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final c:Lcom/google/firebase/sessions/settings/d;

.field public static final d:Landroidx/datastore/preferences/b;


# instance fields
.field public final a:Lcom/google/firebase/messaging/p;

.field public final b:Lcom/google/firebase/sessions/settings/a;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/settings/d;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/settings/e;->c:Lcom/google/firebase/sessions/settings/d;

    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/sessions/q;->b:Ljava/lang/String;

    .line 9
    .line 10
    new-instance v1, Lkotlinx/serialization/json/internal/o;

    .line 11
    .line 12
    sget-object v2, Lcom/google/firebase/sessions/settings/SessionsSettings$Companion$dataStore$2;->INSTANCE:Lcom/google/firebase/sessions/settings/SessionsSettings$Companion$dataStore$2;

    .line 13
    .line 14
    invoke-direct {v1, v2}, Lkotlinx/serialization/json/internal/o;-><init>(Lwakotl/jvm/functions/Function1;)V

    .line 15
    .line 16
    .line 17
    const/16 v2, 0xc

    .line 18
    .line 19
    invoke-static {v0, v1, v2}, Landroidx/datastore/preferences/a;->a(Ljava/lang/String;Lkotlinx/serialization/json/internal/o;I)Landroidx/datastore/preferences/b;

    .line 20
    .line 21
    .line 22
    move-result-object v0

    .line 23
    sput-object v0, Lcom/google/firebase/sessions/settings/e;->d:Landroidx/datastore/preferences/b;

    .line 24
    .line 25
    return-void
.end method

.method public constructor <init>(Lef/h;Lwakotl/coroutines/CoroutineContext;Lwakotl/coroutines/CoroutineContext;Llg/d;)V
    .locals 8

    .line 1
    const-string v0, "firebaseApp"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    const-string v0, "blockingDispatcher"

    .line 7
    .line 8
    invoke-static {p2, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    const-string v0, "backgroundDispatcher"

    .line 12
    .line 13
    invoke-static {p3, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    .line 15
    .line 16
    const-string v0, "firebaseInstallationsApi"

    .line 17
    .line 18
    invoke-static {p4, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    invoke-virtual {p1}, Lef/h;->a()V

    .line 22
    .line 23
    .line 24
    iget-object v0, p1, Lef/h;->a:Landroid/content/Context;

    .line 25
    .line 26
    const-string v1, "firebaseApp.applicationContext"

    .line 27
    .line 28
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    .line 30
    .line 31
    sget-object v1, Lcom/google/firebase/sessions/a0;->a:Lcom/google/firebase/sessions/a0;

    .line 32
    .line 33
    invoke-static {p1}, Lcom/google/firebase/sessions/a0;->a(Lef/h;)Lcom/google/firebase/sessions/b;

    .line 34
    .line 35
    .line 36
    move-result-object v5

    .line 37
    new-instance p1, Lcom/google/firebase/messaging/p;

    .line 38
    .line 39
    invoke-direct {p1, v0}, Lcom/google/firebase/messaging/p;-><init>(Landroid/content/Context;)V

    .line 40
    .line 41
    .line 42
    new-instance v1, Lcom/google/firebase/sessions/settings/a;

    .line 43
    .line 44
    new-instance v6, Lcom/google/firebase/sessions/settings/b;

    .line 45
    .line 46
    invoke-direct {v6, v5, p2}, Lcom/google/firebase/sessions/settings/b;-><init>(Lcom/google/firebase/sessions/b;Lwakotl/coroutines/CoroutineContext;)V

    .line 47
    .line 48
    .line 49
    sget-object p2, Lcom/google/firebase/sessions/settings/e;->c:Lcom/google/firebase/sessions/settings/d;

    .line 50
    .line 51
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 52
    .line 53
    .line 54
    sget-object p2, Lcom/google/firebase/sessions/settings/d;->a:[Lwakotl/reflect/KProperty;

    .line 55
    .line 56
    const/4 v2, 0x0

    .line 57
    aget-object p2, p2, v2

    .line 58
    .line 59
    sget-object v2, Lcom/google/firebase/sessions/settings/e;->d:Landroidx/datastore/preferences/b;

    .line 60
    .line 61
    invoke-virtual {v2, v0, p2}, Landroidx/datastore/preferences/b;->getValue(Ljava/lang/Object;Lwakotl/reflect/KProperty;)Ljava/lang/Object;

    .line 62
    .line 63
    .line 64
    move-result-object p2

    .line 65
    move-object v7, p2

    .line 66
    check-cast v7, Landroidx/datastore/core/h;

    .line 67
    .line 68
    move-object v2, v1

    .line 69
    move-object v3, p3

    .line 70
    move-object v4, p4

    .line 71
    invoke-direct/range {v2 .. v7}, Lcom/google/firebase/sessions/settings/a;-><init>(Lwakotl/coroutines/CoroutineContext;Llg/d;Lcom/google/firebase/sessions/b;Lcom/google/firebase/sessions/settings/b;Landroidx/datastore/core/h;)V

    .line 72
    .line 73
    .line 74
    const-string p2, "localOverrideSettings"

    .line 75
    .line 76
    invoke-static {p1, p2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    .line 78
    .line 79
    const-string p2, "remoteSettings"

    .line 80
    .line 81
    invoke-static {v1, p2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    .line 83
    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    .line 86
    .line 87
    iput-object p1, p0, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 88
    .line 89
    iput-object v1, p0, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 90
    .line 91
    return-void
.end method


# virtual methods
.method public final a()D
    .locals 7

    .line 1
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 2
    .line 3
    iget-object v0, v0, Lcom/google/firebase/messaging/p;->a:Landroid/os/Bundle;

    .line 4
    .line 5
    const-string v1, "firebase_sessions_sampling_rate"

    .line 6
    .line 7
    invoke-virtual {v0, v1}, Landroid/os/BaseBundle;->containsKey(Ljava/lang/String;)Z

    .line 8
    .line 9
    .line 10
    move-result v2

    .line 11
    if-eqz v2, :cond_0

    .line 12
    .line 13
    invoke-virtual {v0, v1}, Landroid/os/BaseBundle;->getDouble(Ljava/lang/String;)D

    .line 14
    .line 15
    .line 16
    move-result-wide v0

    .line 17
    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    goto :goto_0

    .line 22
    :cond_0
    const/4 v0, 0x0

    .line 23
    :goto_0
    const-wide/16 v1, 0x0

    .line 24
    .line 25
    const-wide/high16 v3, 0x3ff0000000000000L    # 1.0

    .line 26
    .line 27
    if-eqz v0, :cond_1

    .line 28
    .line 29
    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    .line 30
    .line 31
    .line 32
    move-result-wide v5

    .line 33
    cmpg-double v0, v1, v5

    .line 34
    .line 35
    if-gtz v0, :cond_1

    .line 36
    .line 37
    cmpg-double v0, v5, v3

    .line 38
    .line 39
    if-gtz v0, :cond_1

    .line 40
    .line 41
    return-wide v5

    .line 42
    :cond_1
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 43
    .line 44
    invoke-virtual {v0}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 45
    .line 46
    .line 47
    move-result-object v0

    .line 48
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/f;->b:Lcom/google/firebase/sessions/settings/c;

    .line 49
    .line 50
    if-eqz v0, :cond_3

    .line 51
    .line 52
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/c;->b:Ljava/lang/Double;

    .line 53
    .line 54
    if-eqz v0, :cond_2

    .line 55
    .line 56
    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    .line 57
    .line 58
    .line 59
    move-result-wide v5

    .line 60
    cmpg-double v0, v1, v5

    .line 61
    .line 62
    if-gtz v0, :cond_2

    .line 63
    .line 64
    cmpg-double v0, v5, v3

    .line 65
    .line 66
    if-gtz v0, :cond_2

    .line 67
    .line 68
    return-wide v5

    .line 69
    :cond_2
    return-wide v3

    .line 70
    :cond_3
    const-string v0, "sessionConfigs"

    .line 71
    .line 72
    invoke-static {v0}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    const/4 v0, 0x0

    .line 76
    throw v0
.end method

.method public final b(Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;
    .locals 5

    .line 1
    instance-of v0, p1, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    move-object v0, p1

    .line 6
    check-cast v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;

    .line 7
    .line 8
    iget v1, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->label:I

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
    iput v1, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->label:I

    .line 18
    .line 19
    goto :goto_0

    .line 20
    :cond_0
    new-instance v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;

    .line 21
    .line 22
    invoke-direct {v0, p0, p1}, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;-><init>(Lcom/google/firebase/sessions/settings/e;Lwakotl/coroutines/Continuation;)V

    .line 23
    .line 24
    .line 25
    :goto_0
    iget-object p1, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->result:Ljava/lang/Object;

    .line 26
    .line 27
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 28
    .line 29
    .line 30
    move-result-object v1

    .line 31
    iget v2, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->label:I

    .line 32
    .line 33
    const/4 v3, 0x2

    .line 34
    const/4 v4, 0x1

    .line 35
    if-eqz v2, :cond_3

    .line 36
    .line 37
    if-eq v2, v4, :cond_2

    .line 38
    .line 39
    if-ne v2, v3, :cond_1

    .line 40
    .line 41
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 42
    .line 43
    .line 44
    goto :goto_2

    .line 45
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 46
    .line 47
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 48
    .line 49
    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 50
    .line 51
    .line 52
    throw p1

    .line 53
    :cond_2
    iget-object v2, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 54
    .line 55
    check-cast v2, Lcom/google/firebase/sessions/settings/e;

    .line 56
    .line 57
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 58
    .line 59
    .line 60
    goto :goto_1

    .line 61
    :cond_3
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 62
    .line 63
    .line 64
    iput-object p0, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 65
    .line 66
    iput v4, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->label:I

    .line 67
    .line 68
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 69
    .line 70
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 71
    .line 72
    .line 73
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 74
    .line 75
    if-ne p1, v1, :cond_4

    .line 76
    .line 77
    return-object v1

    .line 78
    :cond_4
    move-object v2, p0

    .line 79
    :goto_1
    iget-object p1, v2, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 80
    .line 81
    const/4 v2, 0x0

    .line 82
    iput-object v2, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 83
    .line 84
    iput v3, v0, Lcom/google/firebase/sessions/settings/SessionsSettings$updateSettings$1;->label:I

    .line 85
    .line 86
    invoke-virtual {p1, v0}, Lcom/google/firebase/sessions/settings/a;->c(Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 87
    .line 88
    .line 89
    move-result-object p1

    .line 90
    if-ne p1, v1, :cond_5

    .line 91
    .line 92
    return-object v1

    .line 93
    :cond_5
    :goto_2
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 94
    .line 95
    return-object p1
.end method
