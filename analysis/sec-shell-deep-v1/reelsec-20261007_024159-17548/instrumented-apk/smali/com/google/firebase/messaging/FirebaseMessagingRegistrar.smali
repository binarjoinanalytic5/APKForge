.class public Lcom/google/firebase/messaging/FirebaseMessagingRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroidx/annotation/Keep;
.end annotation

.annotation build Lcom/google/android/gms/common/annotation/KeepForSdk;
.end annotation


# static fields
.field private static final LIBRARY_NAME:Ljava/lang/String; = "fire-fcm"


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

.method public static synthetic a(Ljf/o;Lcom/google/firebase/messaging/v;)Lcom/google/firebase/messaging/FirebaseMessaging;
    .locals 0

    .line 1
    invoke-static {p0, p1}, Lcom/google/firebase/messaging/FirebaseMessagingRegistrar;->lambda$getComponents$0(Ljf/o;Ljf/c;)Lcom/google/firebase/messaging/FirebaseMessaging;

    move-result-object p0

    return-object p0
.end method

.method private static synthetic lambda$getComponents$0(Ljf/o;Ljf/c;)Lcom/google/firebase/messaging/FirebaseMessaging;
    .locals 8

    .line 1
    new-instance v7, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 2
    .line 3
    const-class v0, Lef/h;

    .line 4
    .line 5
    invoke-interface {p1, v0}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    move-object v1, v0

    .line 10
    check-cast v1, Lef/h;

    .line 11
    .line 12
    const-class v0, Ljg/a;

    .line 13
    .line 14
    invoke-interface {p1, v0}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 15
    .line 16
    .line 17
    move-result-object v0

    .line 18
    if-nez v0, :cond_0

    .line 19
    .line 20
    const-class v0, Lsg/b;

    .line 21
    .line 22
    invoke-interface {p1, v0}, Ljf/c;->e(Ljava/lang/Class;)Lkg/b;

    .line 23
    .line 24
    .line 25
    move-result-object v2

    .line 26
    const-class v0, Lig/f;

    .line 27
    .line 28
    invoke-interface {p1, v0}, Ljf/c;->e(Ljava/lang/Class;)Lkg/b;

    .line 29
    .line 30
    .line 31
    move-result-object v3

    .line 32
    const-class v0, Llg/d;

    .line 33
    .line 34
    invoke-interface {p1, v0}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    move-object v4, v0

    .line 39
    check-cast v4, Llg/d;

    .line 40
    .line 41
    invoke-interface {p1, p0}, Ljf/c;->b(Ljf/o;)Lkg/b;

    .line 42
    .line 43
    .line 44
    move-result-object v5

    .line 45
    const-class p0, Lhg/c;

    .line 46
    .line 47
    invoke-interface {p1, p0}, Ljf/c;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 48
    .line 49
    .line 50
    move-result-object p0

    .line 51
    move-object v6, p0

    .line 52
    check-cast v6, Lhg/c;

    .line 53
    .line 54
    move-object v0, v7

    .line 55
    invoke-direct/range {v0 .. v6}, Lcom/google/firebase/messaging/FirebaseMessaging;-><init>(Lef/h;Lkg/b;Lkg/b;Llg/d;Lkg/b;Lhg/c;)V

    .line 56
    .line 57
    .line 58
    return-object v7

    .line 59
    :cond_0
    new-instance p0, Ljava/lang/ClassCastException;

    .line 60
    .line 61
    invoke-direct {p0}, Ljava/lang/ClassCastException;-><init>()V

    .line 62
    .line 63
    .line 64
    throw p0
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 7
    .annotation build Landroidx/annotation/Keep;
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
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x0

    .line 3
    new-instance v2, Ljf/o;

    .line 4
    .line 5
    const-class v3, Lbg/b;

    .line 6
    .line 7
    const-class v4, Leb/f;

    .line 8
    .line 9
    invoke-direct {v2, v3, v4}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 10
    .line 11
    .line 12
    const-class v3, Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 13
    .line 14
    invoke-static {v3}, Ljf/b;->a(Ljava/lang/Class;)Ljf/a;

    .line 15
    .line 16
    .line 17
    move-result-object v3

    .line 18
    const-string v4, "fire-fcm"

    .line 19
    .line 20
    iput-object v4, v3, Ljf/a;->a:Ljava/lang/String;

    .line 21
    .line 22
    const-class v5, Lef/h;

    .line 23
    .line 24
    invoke-static {v5}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 25
    .line 26
    .line 27
    move-result-object v5

    .line 28
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 29
    .line 30
    .line 31
    new-instance v5, Ljf/i;

    .line 32
    .line 33
    const-class v6, Ljg/a;

    .line 34
    .line 35
    invoke-direct {v5, v6, v1, v1}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 36
    .line 37
    .line 38
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 39
    .line 40
    .line 41
    new-instance v5, Ljf/i;

    .line 42
    .line 43
    const-class v6, Lsg/b;

    .line 44
    .line 45
    invoke-direct {v5, v6, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 46
    .line 47
    .line 48
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 49
    .line 50
    .line 51
    new-instance v5, Ljf/i;

    .line 52
    .line 53
    const-class v6, Lig/f;

    .line 54
    .line 55
    invoke-direct {v5, v6, v1, v0}, Ljf/i;-><init>(Ljava/lang/Class;II)V

    .line 56
    .line 57
    .line 58
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 59
    .line 60
    .line 61
    const-class v5, Llg/d;

    .line 62
    .line 63
    invoke-static {v5}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 64
    .line 65
    .line 66
    move-result-object v5

    .line 67
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 68
    .line 69
    .line 70
    new-instance v5, Ljf/i;

    .line 71
    .line 72
    invoke-direct {v5, v2, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 73
    .line 74
    .line 75
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 76
    .line 77
    .line 78
    const-class v5, Lhg/c;

    .line 79
    .line 80
    invoke-static {v5}, Ljf/i;->a(Ljava/lang/Class;)Ljf/i;

    .line 81
    .line 82
    .line 83
    move-result-object v5

    .line 84
    invoke-virtual {v3, v5}, Ljf/a;->a(Ljf/i;)V

    .line 85
    .line 86
    .line 87
    new-instance v5, Lcom/google/firebase/messaging/m;

    .line 88
    .line 89
    invoke-direct {v5, v2, v1}, Lcom/google/firebase/messaging/m;-><init>(Ljf/o;I)V

    .line 90
    .line 91
    .line 92
    iput-object v5, v3, Ljf/a;->f:Ljf/e;

    .line 93
    .line 94
    invoke-virtual {v3, v0}, Ljf/a;->c(I)V

    .line 95
    .line 96
    .line 97
    invoke-virtual {v3}, Ljf/a;->b()Ljf/b;

    .line 98
    .line 99
    .line 100
    move-result-object v2

    .line 101
    const-string v3, "24.1.0"

    .line 102
    .line 103
    invoke-static {v4, v3}, Lcom/bumptech/glide/e;->K(Ljava/lang/String;Ljava/lang/String;)Ljf/b;

    .line 104
    .line 105
    .line 106
    move-result-object v3

    .line 107
    const/4 v4, 0x2

    .line 108
    new-array v4, v4, [Ljf/b;

    .line 109
    .line 110
    aput-object v2, v4, v1

    .line 111
    .line 112
    aput-object v3, v4, v0

    .line 113
    .line 114
    invoke-static {v4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 115
    .line 116
    .line 117
    move-result-object v0

    .line 118
    return-object v0
.end method
