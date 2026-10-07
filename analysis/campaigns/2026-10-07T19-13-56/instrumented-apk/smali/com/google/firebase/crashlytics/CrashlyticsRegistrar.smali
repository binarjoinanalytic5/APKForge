.class public Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# static fields
.field public static final synthetic d:I


# instance fields
.field public final a:Ljf/o;

.field public final b:Ljf/o;

.field public final c:Ljf/o;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 1
    sget-object v0, Lcom/google/firebase/sessions/api/SessionSubscriber$Name;->CRASHLYTICS:Lcom/google/firebase/sessions/api/SessionSubscriber$Name;

    .line 2
    .line 3
    sget-object v1, Lcom/google/firebase/sessions/api/b;->a:Lcom/google/firebase/sessions/api/b;

    .line 4
    .line 5
    const-string v1, "subscriberName"

    .line 6
    .line 7
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    .line 9
    .line 10
    sget-object v1, Lcom/google/firebase/sessions/api/SessionSubscriber$Name;->PERFORMANCE:Lcom/google/firebase/sessions/api/SessionSubscriber$Name;

    .line 11
    .line 12
    if-eq v0, v1, :cond_1

    .line 13
    .line 14
    sget-object v1, Lcom/google/firebase/sessions/api/b;->b:Ljava/util/Map;

    .line 15
    .line 16
    invoke-interface {v1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    .line 17
    .line 18
    .line 19
    move-result v2

    .line 20
    if-eqz v2, :cond_0

    .line 21
    .line 22
    invoke-static {v0}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 23
    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_0
    const-string v2, "dependencies"

    .line 27
    .line 28
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    .line 30
    .line 31
    new-instance v2, Lcom/google/firebase/sessions/api/a;

    .line 32
    .line 33
    new-instance v3, Lkotlinx/coroutines/sync/a;

    .line 34
    .line 35
    const/4 v4, 0x1

    .line 36
    invoke-direct {v3, v4}, Lkotlinx/coroutines/sync/a;-><init>(Z)V

    .line 37
    .line 38
    .line 39
    invoke-direct {v2, v3}, Lcom/google/firebase/sessions/api/a;-><init>(Lkotlinx/coroutines/sync/a;)V

    .line 40
    .line 41
    .line 42
    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 43
    .line 44
    .line 45
    invoke-static {v0}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 46
    .line 47
    .line 48
    :goto_0
    return-void

    .line 49
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    .line 50
    .line 51
    const-string v1, "Incompatible versions of Firebase Perf and Firebase Sessions.\nA safe combination would be:\n  firebase-sessions:1.1.0\n  firebase-crashlytics:18.5.0\n  firebase-perf:20.5.0\nFor more information contact Firebase Support."

    .line 52
    .line 53
    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 54
    .line 55
    .line 56
    throw v0
.end method

.method public constructor <init>()V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    new-instance v0, Ljf/o;

    .line 5
    .line 6
    const-class v1, Lif/a;

    .line 7
    .line 8
    const-class v2, Ljava/util/concurrent/ExecutorService;

    .line 9
    .line 10
    invoke-direct {v0, v1, v2}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 11
    .line 12
    .line 13
    iput-object v0, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->a:Ljf/o;

    .line 14
    .line 15
    new-instance v0, Ljf/o;

    .line 16
    .line 17
    const-class v1, Lif/b;

    .line 18
    .line 19
    invoke-direct {v0, v1, v2}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 20
    .line 21
    .line 22
    iput-object v0, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->b:Ljf/o;

    .line 23
    .line 24
    new-instance v0, Ljf/o;

    .line 25
    .line 26
    const-class v1, Lif/c;

    .line 27
    .line 28
    invoke-direct {v0, v1, v2}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 29
    .line 30
    .line 31
    iput-object v0, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->c:Ljf/o;

    .line 32
    .line 33
    return-void
.end method


# virtual methods
.method public final getComponents()Ljava/util/List;
    .locals 7

    .line 1
    const/4 v0, 0x2

    .line 2
    const/4 v1, 0x0

    .line 3
    const/4 v2, 0x1

    .line 4
    const-class v3, Lcom/google/firebase/crashlytics/FirebaseCrashlytics;

    .line 5
    .line 6
    invoke-static {v3}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 7
    .line 8
    .line 9
    move-result-object v3

    .line 10
    const-string v4, "fire-cls"

    .line 11
    .line 12
    iput-object v4, v3, Ljf/a;->a:Ljava/lang/String;

    .line 13
    .line 14
    const-class v5, Lef/h;

    .line 15
    .line 16
    invoke-static {v5}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 17
    .line 18
    .line 19
    move-result-object v5

    .line 20
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 21
    .line 22
    .line 23
    const-class v5, Llg/d;

    .line 24
    .line 25
    invoke-static {v5}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 26
    .line 27
    .line 28
    move-result-object v5

    .line 29
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 30
    .line 31
    .line 32
    iget-object v5, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->a:Ljf/o;

    .line 33
    .line 34
    new-instance v6, Ljf/i;

    .line 35
    .line 36
    invoke-direct {v6, v5, v2, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 37
    .line 38
    .line 39
    invoke-virtual {v3, v6}, Ljf/a;->a(Ljf/i;)V

    .line 40
    .line 41
    .line 42
    iget-object v5, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->b:Ljf/o;

    .line 43
    .line 44
    new-instance v6, Ljf/i;

    .line 45
    .line 46
    invoke-direct {v6, v5, v2, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 47
    .line 48
    .line 49
    invoke-virtual {v3, v6}, Ljf/a;->a(Ljf/i;)V

    .line 50
    .line 51
    .line 52
    iget-object v5, p0, Lcom/google/firebase/crashlytics/CrashlyticsRegistrar;->c:Ljf/o;

    .line 53
    .line 54
    new-instance v6, Ljf/i;

    .line 55
    .line 56
    invoke-direct {v6, v5, v2, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 57
    .line 58
    .line 59
    invoke-virtual {v3, v6}, Ljf/a;->a(Ljf/i;)V

    .line 60
    .line 61
    .line 62
    new-instance v5, Ljf/i;

    .line 63
    .line 64
    const-class v6, Lmf/a;

    .line 65
    .line 66
    invoke-direct {v5, v6, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 67
    .line 68
    .line 69
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 70
    .line 71
    .line 72
    new-instance v5, Ljf/i;

    .line 73
    .line 74
    const-class v6, Lgf/a;

    .line 75
    .line 76
    invoke-direct {v5, v6, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 77
    .line 78
    .line 79
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 80
    .line 81
    .line 82
    new-instance v5, Ljf/i;

    .line 83
    .line 84
    const-class v6, Ltg/a;

    .line 85
    .line 86
    invoke-direct {v5, v6, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 87
    .line 88
    .line 89
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 90
    .line 91
    .line 92
    new-instance v5, Lf;

    .line 93
    .line 94
    const/16 v6, 0xf

    .line 95
    .line 96
    invoke-direct {v5, p0, v6}, Lf;-><init>(Ljava/lang/Object;I)V

    .line 97
    .line 98
    .line 99
    iput-object v5, v3, Ljf/a;->f:Ljf/e;

    .line 100
    .line 101
    invoke-virtual {v3, v0}, Ljf/a;->c(I)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {v3}, Ljf/a;->b()Ljf/b;

    .line 105
    .line 106
    .line 107
    move-result-object v3

    .line 108
    const-string v5, "19.4.0"

    .line 109
    .line 110
    invoke-static {v4, v5}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 111
    .line 112
    .line 113
    move-result-object v4

    .line 114
    new-array v0, v0, [Ljf/b;

    .line 115
    .line 116
    aput-object v3, v0, v1

    .line 117
    .line 118
    aput-object v4, v0, v2

    .line 119
    .line 120
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 121
    .line 122
    .line 123
    move-result-object v0

    .line 124
    return-object v0
.end method
