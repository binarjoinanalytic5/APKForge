.class public Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    return-void
.end method


# virtual methods
.method public final getComponents()Ljava/util/List;
    .locals 4

    .line 1
    const/4 v0, 0x2

    .line 2
    const-class v1, Lmf/a;

    .line 3
    .line 4
    invoke-static {v1}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 5
    .line 6
    .line 7
    move-result-object v1

    .line 8
    const-string v2, "fire-cls-ndk"

    .line 9
    .line 10
    iput-object v2, v1, Ljf/a;->a:Ljava/lang/String;

    .line 11
    .line 12
    const-class v3, Landroid/content/Context;

    .line 13
    .line 14
    invoke-static {v3}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 15
    .line 16
    .line 17
    move-result-object v3

    .line 18
    invoke-virtual {v1, v3}, Ljf/a;->a(Ljf/i;)V

    .line 19
    .line 20
    .line 21
    new-instance v3, Lcom/google/firebase/crashlytics/ndk/a;

    .line 22
    .line 23
    invoke-direct {v3, p0}, Lcom/google/firebase/crashlytics/ndk/a;-><init>(Lcom/google/firebase/crashlytics/ndk/CrashlyticsNdkRegistrar;)V

    .line 24
    .line 25
    .line 26
    iput-object v3, v1, Ljf/a;->f:Ljf/e;

    .line 27
    .line 28
    invoke-virtual {v1, v0}, Ljf/a;->c(I)V

    .line 29
    .line 30
    .line 31
    invoke-virtual {v1}, Ljf/a;->b()Ljf/b;

    .line 32
    .line 33
    .line 34
    move-result-object v1

    .line 35
    const-string v3, "19.4.0"

    .line 36
    .line 37
    invoke-static {v2, v3}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 38
    .line 39
    .line 40
    move-result-object v2

    .line 41
    new-array v0, v0, [Ljf/b;

    .line 42
    .line 43
    const/4 v3, 0x0

    .line 44
    aput-object v1, v0, v3

    .line 45
    .line 46
    const/4 v1, 0x1

    .line 47
    aput-object v2, v0, v1

    .line 48
    .line 49
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 50
    .line 51
    .line 52
    move-result-object v0

    .line 53
    return-object v0
.end method
