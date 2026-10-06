.class public final Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroidx/annotation/Keep;
.end annotation

.annotation runtime Lwakotl/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0006\u0008\u0001\u0018\u0000 \n2\u00020\u0001:\u0001\u000bB\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J=\u0010\u0008\u001a0\u0012,\u0012*\u0012\u000e\u0008\u0001\u0012\n \u0007*\u0004\u0018\u00010\u00060\u0006 \u0007*\u0014\u0012\u000e\u0008\u0001\u0012\n \u0007*\u0004\u0018\u00010\u00060\u0006\u0018\u00010\u00050\u00050\u0004H\u0016\u00a2\u0006\u0004\u0008\u0008\u0010\t\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;",
        "Lcom/google/firebase/components/ComponentRegistrar;",
        "<init>",
        "()V",
        "",
        "Ljf/b;",
        "",
        "kotlin.jvm.PlatformType",
        "getComponents",
        "()Ljava/util/List;",
        "Companion",
        "com/google/firebase/sessions/m",
        "com.google.firebase-firebase-sessions"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final Companion:Lcom/google/firebase/sessions/m;
    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final LIBRARY_NAME:Ljava/lang/String; = "fire-sessions"
    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final backgroundDispatcher:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final blockingDispatcher:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final firebaseApp:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final firebaseInstallationsApi:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final sessionLifecycleServiceBinder:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final sessionsSettings:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field

.field private static final transportFactory:Ljf/o;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljf/o;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/m;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->Companion:Lcom/google/firebase/sessions/m;

    .line 7
    .line 8
    const-class v0, Lef/h;

    .line 9
    .line 10
    invoke-static {v0}, Ljf/o;->a(Ljava/lang/Class;)Ljf/o;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    const-string v1, "unqualified(FirebaseApp::class.java)"

    .line 15
    .line 16
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    .line 18
    .line 19
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 20
    .line 21
    const-class v0, Llg/d;

    .line 22
    .line 23
    invoke-static {v0}, Ljf/o;->a(Ljava/lang/Class;)Ljf/o;

    .line 24
    .line 25
    .line 26
    move-result-object v0

    .line 27
    const-string v1, "unqualified(FirebaseInstallationsApi::class.java)"

    .line 28
    .line 29
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    .line 31
    .line 32
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseInstallationsApi:Ljf/o;

    .line 33
    .line 34
    new-instance v0, Ljf/o;

    .line 35
    .line 36
    const-class v1, Lif/a;

    .line 37
    .line 38
    const-class v2, Lkotlinx/coroutines/a0;

    .line 39
    .line 40
    invoke-direct {v0, v1, v2}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 41
    .line 42
    .line 43
    const-string v1, "qualified(Background::cl\u2026neDispatcher::class.java)"

    .line 44
    .line 45
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    .line 47
    .line 48
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 49
    .line 50
    new-instance v0, Ljf/o;

    .line 51
    .line 52
    const-class v1, Lif/b;

    .line 53
    .line 54
    invoke-direct {v0, v1, v2}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 55
    .line 56
    .line 57
    const-string v1, "qualified(Blocking::clas\u2026neDispatcher::class.java)"

    .line 58
    .line 59
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 60
    .line 61
    .line 62
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->blockingDispatcher:Ljf/o;

    .line 63
    .line 64
    const-class v0, Leb/f;

    .line 65
    .line 66
    invoke-static {v0}, Ljf/o;->a(Ljava/lang/Class;)Ljf/o;

    .line 67
    .line 68
    .line 69
    move-result-object v0

    .line 70
    const-string v1, "unqualified(TransportFactory::class.java)"

    .line 71
    .line 72
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->transportFactory:Ljf/o;

    .line 76
    .line 77
    const-class v0, Lcom/google/firebase/sessions/settings/e;

    .line 78
    .line 79
    invoke-static {v0}, Ljf/o;->a(Ljava/lang/Class;)Ljf/o;

    .line 80
    .line 81
    .line 82
    move-result-object v0

    .line 83
    const-string v1, "unqualified(SessionsSettings::class.java)"

    .line 84
    .line 85
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 86
    .line 87
    .line 88
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionsSettings:Ljf/o;

    .line 89
    .line 90
    const-class v0, Lcom/google/firebase/sessions/k0;

    .line 91
    .line 92
    invoke-static {v0}, Ljf/o;->a(Ljava/lang/Class;)Ljf/o;

    .line 93
    .line 94
    .line 95
    move-result-object v0

    .line 96
    const-string v1, "unqualified(SessionLifec\u2026erviceBinder::class.java)"

    .line 97
    .line 98
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 99
    .line 100
    .line 101
    sput-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionLifecycleServiceBinder:Ljf/o;

    .line 102
    .line 103
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    return-void
.end method

.method public static synthetic a(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/r;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$4(Ljf/c;)Lcom/google/firebase/sessions/r;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic b(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/k0;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$5(Ljf/c;)Lcom/google/firebase/sessions/k0;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic c(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/settings/e;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$3(Ljf/c;)Lcom/google/firebase/sessions/settings/e;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic d(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/b0;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$2(Ljf/c;)Lcom/google/firebase/sessions/b0;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic e(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/d0;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$1(Ljf/c;)Lcom/google/firebase/sessions/d0;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic f(Lcom/google/firebase/messaging/v;)Lcom/google/firebase/sessions/k;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->getComponents$lambda$0(Ljf/c;)Lcom/google/firebase/sessions/k;

    move-result-object p0

    return-object p0
.end method

.method private static final getComponents$lambda$0(Ljf/c;)Lcom/google/firebase/sessions/k;
    .locals 5

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/k;

    .line 2
    .line 3
    sget-object v1, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 4
    .line 5
    invoke-interface {p0, v1}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v1

    .line 9
    const-string v2, "container[firebaseApp]"

    .line 10
    .line 11
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    .line 13
    .line 14
    check-cast v1, Lef/h;

    .line 15
    .line 16
    sget-object v2, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionsSettings:Ljf/o;

    .line 17
    .line 18
    invoke-interface {p0, v2}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 19
    .line 20
    .line 21
    move-result-object v2

    .line 22
    const-string v3, "container[sessionsSettings]"

    .line 23
    .line 24
    invoke-static {v2, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    .line 26
    .line 27
    check-cast v2, Lcom/google/firebase/sessions/settings/e;

    .line 28
    .line 29
    sget-object v3, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 30
    .line 31
    invoke-interface {p0, v3}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 32
    .line 33
    .line 34
    move-result-object v3

    .line 35
    const-string v4, "container[backgroundDispatcher]"

    .line 36
    .line 37
    invoke-static {v3, v4}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    .line 39
    .line 40
    check-cast v3, Lwakotl/coroutines/CoroutineContext;

    .line 41
    .line 42
    sget-object v4, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionLifecycleServiceBinder:Ljf/o;

    .line 43
    .line 44
    invoke-interface {p0, v4}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 45
    .line 46
    .line 47
    move-result-object p0

    .line 48
    const-string v4, "container[sessionLifecycleServiceBinder]"

    .line 49
    .line 50
    invoke-static {p0, v4}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    .line 52
    .line 53
    check-cast p0, Lcom/google/firebase/sessions/k0;

    .line 54
    .line 55
    invoke-direct {v0, v1, v2, v3, p0}, Lcom/google/firebase/sessions/k;-><init>(Lef/h;Lcom/google/firebase/sessions/settings/e;Lwakotl/coroutines/CoroutineContext;Lcom/google/firebase/sessions/k0;)V

    .line 56
    .line 57
    .line 58
    return-object v0
.end method

.method private static final getComponents$lambda$1(Ljf/c;)Lcom/google/firebase/sessions/d0;
    .locals 0

    .line 1
    new-instance p0, Lcom/google/firebase/sessions/d0;

    .line 2
    .line 3
    invoke-direct {p0}, Lcom/google/firebase/sessions/d0;-><init>()V

    .line 4
    .line 5
    .line 6
    return-object p0
.end method

.method private static final getComponents$lambda$2(Ljf/c;)Lcom/google/firebase/sessions/b0;
    .locals 7

    .line 1
    new-instance v6, Lcom/google/firebase/sessions/c0;

    .line 2
    .line 3
    sget-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 4
    .line 5
    invoke-interface {p0, v0}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    const-string v1, "container[firebaseApp]"

    .line 10
    .line 11
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    .line 13
    .line 14
    move-object v1, v0

    .line 15
    check-cast v1, Lef/h;

    .line 16
    .line 17
    sget-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseInstallationsApi:Ljf/o;

    .line 18
    .line 19
    invoke-interface {p0, v0}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object v0

    .line 23
    const-string v2, "container[firebaseInstallationsApi]"

    .line 24
    .line 25
    invoke-static {v0, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    .line 27
    .line 28
    move-object v2, v0

    .line 29
    check-cast v2, Llg/d;

    .line 30
    .line 31
    sget-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionsSettings:Ljf/o;

    .line 32
    .line 33
    invoke-interface {p0, v0}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 34
    .line 35
    .line 36
    move-result-object v0

    .line 37
    const-string v3, "container[sessionsSettings]"

    .line 38
    .line 39
    invoke-static {v0, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    .line 41
    .line 42
    move-object v3, v0

    .line 43
    check-cast v3, Lcom/google/firebase/sessions/settings/e;

    .line 44
    .line 45
    new-instance v4, Lcom/google/firebase/sessions/j;

    .line 46
    .line 47
    sget-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->transportFactory:Ljf/o;

    .line 48
    .line 49
    invoke-interface {p0, v0}, Ljf/c;->b(Ljf/o;)Lkg/b;

    .line 50
    .line 51
    .line 52
    move-result-object v0

    .line 53
    const-string v5, "container.getProvider(transportFactory)"

    .line 54
    .line 55
    invoke-static {v0, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    .line 57
    .line 58
    invoke-direct {v4, v0}, Lcom/google/firebase/sessions/j;-><init>(Lkg/b;)V

    .line 59
    .line 60
    .line 61
    sget-object v0, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 62
    .line 63
    invoke-interface {p0, v0}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 64
    .line 65
    .line 66
    move-result-object p0

    .line 67
    const-string v0, "container[backgroundDispatcher]"

    .line 68
    .line 69
    invoke-static {p0, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    .line 71
    .line 72
    move-object v5, p0

    .line 73
    check-cast v5, Lwakotl/coroutines/CoroutineContext;

    .line 74
    .line 75
    move-object v0, v6

    .line 76
    invoke-direct/range {v0 .. v5}, Lcom/google/firebase/sessions/c0;-><init>(Lef/h;Llg/d;Lcom/google/firebase/sessions/settings/e;Lcom/google/firebase/sessions/j;Lwakotl/coroutines/CoroutineContext;)V

    .line 77
    .line 78
    .line 79
    return-object v6
.end method

.method private static final getComponents$lambda$3(Ljf/c;)Lcom/google/firebase/sessions/settings/e;
    .locals 5

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/settings/e;

    .line 2
    .line 3
    sget-object v1, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 4
    .line 5
    invoke-interface {p0, v1}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v1

    .line 9
    const-string v2, "container[firebaseApp]"

    .line 10
    .line 11
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    .line 13
    .line 14
    check-cast v1, Lef/h;

    .line 15
    .line 16
    sget-object v2, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->blockingDispatcher:Ljf/o;

    .line 17
    .line 18
    invoke-interface {p0, v2}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 19
    .line 20
    .line 21
    move-result-object v2

    .line 22
    const-string v3, "container[blockingDispatcher]"

    .line 23
    .line 24
    invoke-static {v2, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    .line 26
    .line 27
    check-cast v2, Lwakotl/coroutines/CoroutineContext;

    .line 28
    .line 29
    sget-object v3, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 30
    .line 31
    invoke-interface {p0, v3}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 32
    .line 33
    .line 34
    move-result-object v3

    .line 35
    const-string v4, "container[backgroundDispatcher]"

    .line 36
    .line 37
    invoke-static {v3, v4}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    .line 39
    .line 40
    check-cast v3, Lwakotl/coroutines/CoroutineContext;

    .line 41
    .line 42
    sget-object v4, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseInstallationsApi:Ljf/o;

    .line 43
    .line 44
    invoke-interface {p0, v4}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 45
    .line 46
    .line 47
    move-result-object p0

    .line 48
    const-string v4, "container[firebaseInstallationsApi]"

    .line 49
    .line 50
    invoke-static {p0, v4}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    .line 52
    .line 53
    check-cast p0, Llg/d;

    .line 54
    .line 55
    invoke-direct {v0, v1, v2, v3, p0}, Lcom/google/firebase/sessions/settings/e;-><init>(Lef/h;Lwakotl/coroutines/CoroutineContext;Lwakotl/coroutines/CoroutineContext;Llg/d;)V

    .line 56
    .line 57
    .line 58
    return-object v0
.end method

.method private static final getComponents$lambda$4(Ljf/c;)Lcom/google/firebase/sessions/r;
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/x;

    .line 2
    .line 3
    sget-object v1, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 4
    .line 5
    invoke-interface {p0, v1}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v1

    .line 9
    check-cast v1, Lef/h;

    .line 10
    .line 11
    invoke-virtual {v1}, Lef/h;->a()V

    .line 12
    .line 13
    .line 14
    iget-object v1, v1, Lef/h;->a:Landroid/content/Context;

    .line 15
    .line 16
    const-string v2, "container[firebaseApp].applicationContext"

    .line 17
    .line 18
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    sget-object v2, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 22
    .line 23
    invoke-interface {p0, v2}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 24
    .line 25
    .line 26
    move-result-object p0

    .line 27
    const-string v2, "container[backgroundDispatcher]"

    .line 28
    .line 29
    invoke-static {p0, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    .line 31
    .line 32
    check-cast p0, Lwakotl/coroutines/CoroutineContext;

    .line 33
    .line 34
    invoke-direct {v0, v1, p0}, Lcom/google/firebase/sessions/x;-><init>(Landroid/content/Context;Lwakotl/coroutines/CoroutineContext;)V

    .line 35
    .line 36
    .line 37
    return-object v0
.end method

.method private static final getComponents$lambda$5(Ljf/c;)Lcom/google/firebase/sessions/k0;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/l0;

    .line 2
    .line 3
    sget-object v1, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 4
    .line 5
    invoke-interface {p0, v1}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object p0

    .line 9
    const-string v1, "container[firebaseApp]"

    .line 10
    .line 11
    invoke-static {p0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    .line 13
    .line 14
    check-cast p0, Lef/h;

    .line 15
    .line 16
    invoke-direct {v0, p0}, Lcom/google/firebase/sessions/l0;-><init>(Lef/h;)V

    .line 17
    .line 18
    .line 19
    return-object v0
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljf/b;",
            ">;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation

    .line 1
    const/4 v0, 0x0

    .line 2
    const/4 v1, 0x1

    .line 3
    const/4 v2, 0x2

    .line 4
    const-class v3, Lcom/google/firebase/sessions/k;

    .line 5
    .line 6
    invoke-static {v3}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 7
    .line 8
    .line 9
    move-result-object v3

    .line 10
    const-string v4, "fire-sessions"

    .line 11
    .line 12
    iput-object v4, v3, Ljf/a;->a:Ljava/lang/String;

    .line 13
    .line 14
    sget-object v5, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseApp:Ljf/o;

    .line 15
    .line 16
    invoke-static {v5}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 17
    .line 18
    .line 19
    move-result-object v6

    .line 20
    invoke-virtual {v3, v6}, Ljf/a;->a(Ljf/i;)V

    .line 21
    .line 22
    .line 23
    sget-object v6, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionsSettings:Ljf/o;

    .line 24
    .line 25
    invoke-static {v6}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 26
    .line 27
    .line 28
    move-result-object v7

    .line 29
    invoke-virtual {v3, v7}, Ljf/a;->a(Ljf/i;)V

    .line 30
    .line 31
    .line 32
    sget-object v7, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->backgroundDispatcher:Ljf/o;

    .line 33
    .line 34
    invoke-static {v7}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 35
    .line 36
    .line 37
    move-result-object v8

    .line 38
    invoke-virtual {v3, v8}, Ljf/a;->a(Ljf/i;)V

    .line 39
    .line 40
    .line 41
    sget-object v8, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->sessionLifecycleServiceBinder:Ljf/o;

    .line 42
    .line 43
    invoke-static {v8}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 44
    .line 45
    .line 46
    move-result-object v8

    .line 47
    invoke-virtual {v3, v8}, Ljf/a;->a(Ljf/i;)V

    .line 48
    .line 49
    .line 50
    new-instance v8, Landroidx/core/view/h;

    .line 51
    .line 52
    const/16 v9, 0x11

    .line 53
    .line 54
    invoke-direct {v8, v9}, Landroidx/core/view/h;-><init>(I)V

    .line 55
    .line 56
    .line 57
    iput-object v8, v3, Ljf/a;->f:Ljf/e;

    .line 58
    .line 59
    invoke-virtual {v3, v2}, Ljf/a;->c(I)V

    .line 60
    .line 61
    .line 62
    invoke-virtual {v3}, Ljf/a;->b()Ljf/b;

    .line 63
    .line 64
    .line 65
    move-result-object v3

    .line 66
    const-class v8, Lcom/google/firebase/sessions/d0;

    .line 67
    .line 68
    invoke-static {v8}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 69
    .line 70
    .line 71
    move-result-object v8

    .line 72
    const-string v9, "session-generator"

    .line 73
    .line 74
    iput-object v9, v8, Ljf/a;->a:Ljava/lang/String;

    .line 75
    .line 76
    new-instance v9, Landroidx/core/view/h;

    .line 77
    .line 78
    const/16 v10, 0x12

    .line 79
    .line 80
    invoke-direct {v9, v10}, Landroidx/core/view/h;-><init>(I)V

    .line 81
    .line 82
    .line 83
    iput-object v9, v8, Ljf/a;->f:Ljf/e;

    .line 84
    .line 85
    invoke-virtual {v8}, Ljf/a;->b()Ljf/b;

    .line 86
    .line 87
    .line 88
    move-result-object v8

    .line 89
    const-class v9, Lcom/google/firebase/sessions/b0;

    .line 90
    .line 91
    invoke-static {v9}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 92
    .line 93
    .line 94
    move-result-object v9

    .line 95
    const-string v10, "session-publisher"

    .line 96
    .line 97
    iput-object v10, v9, Ljf/a;->a:Ljava/lang/String;

    .line 98
    .line 99
    new-instance v10, Ljf/i;

    .line 100
    .line 101
    invoke-direct {v10, v5, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {v9, v10}, Ljf/a;->a(Ljf/i;)V

    .line 105
    .line 106
    .line 107
    sget-object v10, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->firebaseInstallationsApi:Ljf/o;

    .line 108
    .line 109
    invoke-static {v10}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 110
    .line 111
    .line 112
    move-result-object v11

    .line 113
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 114
    .line 115
    .line 116
    new-instance v11, Ljf/i;

    .line 117
    .line 118
    invoke-direct {v11, v6, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 119
    .line 120
    .line 121
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 122
    .line 123
    .line 124
    sget-object v6, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->transportFactory:Ljf/o;

    .line 125
    .line 126
    new-instance v11, Ljf/i;

    .line 127
    .line 128
    invoke-direct {v11, v6, v1, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 129
    .line 130
    .line 131
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 132
    .line 133
    .line 134
    new-instance v6, Ljf/i;

    .line 135
    .line 136
    invoke-direct {v6, v7, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 137
    .line 138
    .line 139
    invoke-virtual {v9, v6}, Ljf/a;->a(Ljf/i;)V

    .line 140
    .line 141
    .line 142
    new-instance v6, Landroidx/core/view/h;

    .line 143
    .line 144
    const/16 v11, 0x13

    .line 145
    .line 146
    invoke-direct {v6, v11}, Landroidx/core/view/h;-><init>(I)V

    .line 147
    .line 148
    .line 149
    iput-object v6, v9, Ljf/a;->f:Ljf/e;

    .line 150
    .line 151
    invoke-virtual {v9}, Ljf/a;->b()Ljf/b;

    .line 152
    .line 153
    .line 154
    move-result-object v6

    .line 155
    const-class v9, Lcom/google/firebase/sessions/settings/e;

    .line 156
    .line 157
    invoke-static {v9}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 158
    .line 159
    .line 160
    move-result-object v9

    .line 161
    const-string v11, "sessions-settings"

    .line 162
    .line 163
    iput-object v11, v9, Ljf/a;->a:Ljava/lang/String;

    .line 164
    .line 165
    new-instance v11, Ljf/i;

    .line 166
    .line 167
    invoke-direct {v11, v5, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 168
    .line 169
    .line 170
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 171
    .line 172
    .line 173
    sget-object v11, Lcom/google/firebase/sessions/FirebaseSessionsRegistrar;->blockingDispatcher:Ljf/o;

    .line 174
    .line 175
    invoke-static {v11}, Ljf/i;->b(Ljf/o;)Ljf/i;

    .line 176
    .line 177
    .line 178
    move-result-object v11

    .line 179
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 180
    .line 181
    .line 182
    new-instance v11, Ljf/i;

    .line 183
    .line 184
    invoke-direct {v11, v7, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 185
    .line 186
    .line 187
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 188
    .line 189
    .line 190
    new-instance v11, Ljf/i;

    .line 191
    .line 192
    invoke-direct {v11, v10, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 193
    .line 194
    .line 195
    invoke-virtual {v9, v11}, Ljf/a;->a(Ljf/i;)V

    .line 196
    .line 197
    .line 198
    new-instance v10, Landroidx/core/view/h;

    .line 199
    .line 200
    const/16 v11, 0x14

    .line 201
    .line 202
    invoke-direct {v10, v11}, Landroidx/core/view/h;-><init>(I)V

    .line 203
    .line 204
    .line 205
    iput-object v10, v9, Ljf/a;->f:Ljf/e;

    .line 206
    .line 207
    invoke-virtual {v9}, Ljf/a;->b()Ljf/b;

    .line 208
    .line 209
    .line 210
    move-result-object v9

    .line 211
    const-class v10, Lcom/google/firebase/sessions/r;

    .line 212
    .line 213
    invoke-static {v10}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 214
    .line 215
    .line 216
    move-result-object v10

    .line 217
    const-string v11, "sessions-datastore"

    .line 218
    .line 219
    iput-object v11, v10, Ljf/a;->a:Ljava/lang/String;

    .line 220
    .line 221
    new-instance v11, Ljf/i;

    .line 222
    .line 223
    invoke-direct {v11, v5, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 224
    .line 225
    .line 226
    invoke-virtual {v10, v11}, Ljf/a;->a(Ljf/i;)V

    .line 227
    .line 228
    .line 229
    new-instance v11, Ljf/i;

    .line 230
    .line 231
    invoke-direct {v11, v7, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 232
    .line 233
    .line 234
    invoke-virtual {v10, v11}, Ljf/a;->a(Ljf/i;)V

    .line 235
    .line 236
    .line 237
    new-instance v7, Landroidx/core/view/h;

    .line 238
    .line 239
    const/16 v11, 0x15

    .line 240
    .line 241
    invoke-direct {v7, v11}, Landroidx/core/view/h;-><init>(I)V

    .line 242
    .line 243
    .line 244
    iput-object v7, v10, Ljf/a;->f:Ljf/e;

    .line 245
    .line 246
    invoke-virtual {v10}, Ljf/a;->b()Ljf/b;

    .line 247
    .line 248
    .line 249
    move-result-object v7

    .line 250
    const-class v10, Lcom/google/firebase/sessions/k0;

    .line 251
    .line 252
    invoke-static {v10}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 253
    .line 254
    .line 255
    move-result-object v10

    .line 256
    const-string v11, "sessions-service-binder"

    .line 257
    .line 258
    iput-object v11, v10, Ljf/a;->a:Ljava/lang/String;

    .line 259
    .line 260
    new-instance v11, Ljf/i;

    .line 261
    .line 262
    invoke-direct {v11, v5, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 263
    .line 264
    .line 265
    invoke-virtual {v10, v11}, Ljf/a;->a(Ljf/i;)V

    .line 266
    .line 267
    .line 268
    new-instance v5, Landroidx/core/view/h;

    .line 269
    .line 270
    const/16 v11, 0x16

    .line 271
    .line 272
    invoke-direct {v5, v11}, Landroidx/core/view/h;-><init>(I)V

    .line 273
    .line 274
    .line 275
    iput-object v5, v10, Ljf/a;->f:Ljf/e;

    .line 276
    .line 277
    invoke-virtual {v10}, Ljf/a;->b()Ljf/b;

    .line 278
    .line 279
    .line 280
    move-result-object v5

    .line 281
    const-string v10, "2.0.8"

    .line 282
    .line 283
    invoke-static {v4, v10}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 284
    .line 285
    .line 286
    move-result-object v4

    .line 287
    const/4 v10, 0x7

    .line 288
    new-array v10, v10, [Ljf/b;

    .line 289
    .line 290
    aput-object v3, v10, v0

    .line 291
    .line 292
    aput-object v8, v10, v1

    .line 293
    .line 294
    aput-object v6, v10, v2

    .line 295
    .line 296
    const/4 v0, 0x3

    .line 297
    aput-object v9, v10, v0

    .line 298
    .line 299
    const/4 v0, 0x4

    .line 300
    aput-object v7, v10, v0

    .line 301
    .line 302
    const/4 v0, 0x5

    .line 303
    aput-object v5, v10, v0

    .line 304
    .line 305
    const/4 v0, 0x6

    .line 306
    aput-object v4, v10, v0

    .line 307
    .line 308
    invoke-static {v10}, Lwakotl/collections/c0;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 309
    .line 310
    .line 311
    move-result-object v0

    .line 312
    return-object v0
.end method
