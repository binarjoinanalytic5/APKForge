.class public Lcom/google/firebase/installations/FirebaseInstallationsRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroidx/annotation/Keep;
.end annotation


# static fields
.field private static final LIBRARY_NAME:Ljava/lang/String; = "fire-installations"


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

.method public static synthetic a(Lcom/google/firebase/messaging/v;)Llg/d;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/google/firebase/installations/FirebaseInstallationsRegistrar;->lambda$getComponents$0(Ljf/c;)Llg/d;

    move-result-object p0

    return-object p0
.end method

.method private static lambda$getComponents$0(Ljf/c;)Llg/d;
    .locals 7

    .line 1
    new-instance v0, Lcom/google/firebase/installations/a;

    .line 2
    .line 3
    const-class v1, Lef/h;

    .line 4
    .line 5
    invoke-interface {p0, v1}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v1

    .line 9
    check-cast v1, Lef/h;

    .line 10
    .line 11
    const-class v2, Lig/e;

    .line 12
    .line 13
    invoke-interface {p0, v2}, Ljf/c;->e(Ljava/lang/Class;)Lkg/b;

    .line 14
    .line 15
    .line 16
    move-result-object v2

    .line 17
    new-instance v3, Ljf/o;

    .line 18
    .line 19
    const-class v4, Lif/a;

    .line 20
    .line 21
    const-class v5, Ljava/util/concurrent/ExecutorService;

    .line 22
    .line 23
    invoke-direct {v3, v4, v5}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 24
    .line 25
    .line 26
    invoke-interface {p0, v3}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 27
    .line 28
    .line 29
    move-result-object v3

    .line 30
    check-cast v3, Ljava/util/concurrent/ExecutorService;

    .line 31
    .line 32
    new-instance v4, Ljf/o;

    .line 33
    .line 34
    const-class v5, Lif/b;

    .line 35
    .line 36
    const-class v6, Ljava/util/concurrent/Executor;

    .line 37
    .line 38
    invoke-direct {v4, v5, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 39
    .line 40
    .line 41
    invoke-interface {p0, v4}, Ljf/c;->c(Ljf/o;)Ljava/lang/Object;

    .line 42
    .line 43
    .line 44
    move-result-object p0

    .line 45
    check-cast p0, Ljava/util/concurrent/Executor;

    .line 46
    .line 47
    new-instance v4, Lcom/google/firebase/concurrent/b;

    .line 48
    .line 49
    invoke-direct {v4, p0}, Lcom/google/firebase/concurrent/b;-><init>(Ljava/util/concurrent/Executor;)V

    .line 50
    .line 51
    .line 52
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/google/firebase/installations/a;-><init>(Lef/h;Lkg/b;Ljava/util/concurrent/ExecutorService;Lcom/google/firebase/concurrent/b;)V

    .line 53
    .line 54
    .line 55
    return-object v0
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljf/b;",
            ">;"
        }
    .end annotation

    .line 1
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x0

    .line 3
    const-class v2, Llg/d;

    .line 4
    .line 5
    invoke-static {v2}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 6
    .line 7
    .line 8
    move-result-object v2

    .line 9
    const-string v3, "fire-installations"

    .line 10
    .line 11
    iput-object v3, v2, Ljf/a;->a:Ljava/lang/String;

    .line 12
    .line 13
    const-class v4, Lef/h;

    .line 14
    .line 15
    invoke-static {v4}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 16
    .line 17
    .line 18
    move-result-object v4

    .line 19
    invoke-virtual {v2, v4}, Ljf/a;->a(Ljf/i;)V

    .line 20
    .line 21
    .line 22
    new-instance v4, Ljf/i;

    .line 23
    .line 24
    const-class v5, Lig/e;

    .line 25
    .line 26
    invoke-direct {v4, v5, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 27
    .line 28
    .line 29
    invoke-virtual {v2, v4}, Ljf/a;->a(Ljf/i;)V

    .line 30
    .line 31
    .line 32
    new-instance v4, Ljf/o;

    .line 33
    .line 34
    const-class v5, Lif/a;

    .line 35
    .line 36
    const-class v6, Ljava/util/concurrent/ExecutorService;

    .line 37
    .line 38
    invoke-direct {v4, v5, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 39
    .line 40
    .line 41
    new-instance v5, Ljf/i;

    .line 42
    .line 43
    invoke-direct {v5, v4, v0, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 44
    .line 45
    .line 46
    invoke-virtual {v2, v5}, Ljf/a;->a(Ljf/i;)V

    .line 47
    .line 48
    .line 49
    new-instance v4, Ljf/o;

    .line 50
    .line 51
    const-class v5, Lif/b;

    .line 52
    .line 53
    const-class v6, Ljava/util/concurrent/Executor;

    .line 54
    .line 55
    invoke-direct {v4, v5, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 56
    .line 57
    .line 58
    new-instance v5, Ljf/i;

    .line 59
    .line 60
    invoke-direct {v5, v4, v0, v1}, Ljf/i;-><init>(Ljf/o;II)V

    .line 61
    .line 62
    .line 63
    invoke-virtual {v2, v5}, Ljf/a;->a(Ljf/i;)V

    .line 64
    .line 65
    .line 66
    new-instance v4, Lef/i;

    .line 67
    .line 68
    const/16 v5, 0x9

    .line 69
    .line 70
    invoke-direct {v4, v5}, Lef/i;-><init>(I)V

    .line 71
    .line 72
    .line 73
    iput-object v4, v2, Ljf/a;->f:Ljf/e;

    .line 74
    .line 75
    invoke-virtual {v2}, Ljf/a;->b()Ljf/b;

    .line 76
    .line 77
    .line 78
    move-result-object v2

    .line 79
    new-instance v4, Lig/d;

    .line 80
    .line 81
    invoke-direct {v4, v1}, Lig/d;-><init>(I)V

    .line 82
    .line 83
    .line 84
    const-class v5, Lig/d;

    .line 85
    .line 86
    invoke-static {v5}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 87
    .line 88
    .line 89
    move-result-object v5

    .line 90
    iput v0, v5, Ljf/a;->e:I

    .line 91
    .line 92
    new-instance v6, Lf;

    .line 93
    .line 94
    const/16 v7, 0xe

    .line 95
    .line 96
    invoke-direct {v6, v4, v7}, Lf;-><init>(Ljava/lang/Object;I)V

    .line 97
    .line 98
    .line 99
    iput-object v6, v5, Ljf/a;->f:Ljf/e;

    .line 100
    .line 101
    invoke-virtual {v5}, Ljf/a;->b()Ljf/b;

    .line 102
    .line 103
    .line 104
    move-result-object v4

    .line 105
    const-string v5, "18.0.0"

    .line 106
    .line 107
    invoke-static {v3, v5}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 108
    .line 109
    .line 110
    move-result-object v3

    .line 111
    const/4 v5, 0x3

    .line 112
    new-array v5, v5, [Ljf/b;

    .line 113
    .line 114
    aput-object v2, v5, v1

    .line 115
    .line 116
    aput-object v4, v5, v0

    .line 117
    .line 118
    const/4 v0, 0x2

    .line 119
    aput-object v3, v5, v0

    .line 120
    .line 121
    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 122
    .line 123
    .line 124
    move-result-object v0

    .line 125
    return-object v0
.end method
