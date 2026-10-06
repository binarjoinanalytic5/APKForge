.class public final Lcom/google/firebase/FirebaseCommonKtxRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroidx/annotation/Keep;
.end annotation

.annotation runtime Lwakotl/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0007\u0018\u00002\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0019\u0010\u0006\u001a\u000c\u0012\u0008\u0012\u0006\u0012\u0002\u0008\u00030\u00050\u0004H\u0016\u00a2\u0006\u0004\u0008\u0006\u0010\u0007\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/google/firebase/FirebaseCommonKtxRegistrar;",
        "Lcom/google/firebase/components/ComponentRegistrar;",
        "<init>",
        "()V",
        "",
        "Ljf/b;",
        "getComponents",
        "()Ljava/util/List;",
        "com.google.firebase-firebase-common"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


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
.method public getComponents()Ljava/util/List;
    .locals 10
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
    new-instance v2, Ljf/o;

    .line 4
    .line 5
    const-class v3, Lif/a;

    .line 6
    .line 7
    const-class v4, Lkotlinx/coroutines/a0;

    .line 8
    .line 9
    invoke-direct {v2, v3, v4}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 10
    .line 11
    .line 12
    invoke-static {v2}, Ljf/b;->b(Ljf/o;)Ljf/a;

    .line 13
    .line 14
    .line 15
    move-result-object v2

    .line 16
    new-instance v5, Ljf/o;

    .line 17
    .line 18
    const-class v6, Ljava/util/concurrent/Executor;

    .line 19
    .line 20
    invoke-direct {v5, v3, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 21
    .line 22
    .line 23
    new-instance v3, Ljf/i;

    .line 24
    .line 25
    invoke-direct {v3, v5, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 26
    .line 27
    .line 28
    invoke-virtual {v2, v3}, Ljf/a;->a(Ljf/i;)V

    .line 29
    .line 30
    .line 31
    sget-object v3, Lef/c;->c:Lef/c;

    .line 32
    .line 33
    iput-object v3, v2, Ljf/a;->f:Ljf/e;

    .line 34
    .line 35
    invoke-virtual {v2}, Ljf/a;->b()Ljf/b;

    .line 36
    .line 37
    .line 38
    move-result-object v2

    .line 39
    const-string v3, "builder(Qualified.qualif\u2026cher()\n    }\n    .build()"

    .line 40
    .line 41
    invoke-static {v2, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    .line 43
    .line 44
    new-instance v5, Ljf/o;

    .line 45
    .line 46
    const-class v7, Lif/c;

    .line 47
    .line 48
    invoke-direct {v5, v7, v4}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 49
    .line 50
    .line 51
    invoke-static {v5}, Ljf/b;->b(Ljf/o;)Ljf/a;

    .line 52
    .line 53
    .line 54
    move-result-object v5

    .line 55
    new-instance v8, Ljf/o;

    .line 56
    .line 57
    invoke-direct {v8, v7, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 58
    .line 59
    .line 60
    new-instance v7, Ljf/i;

    .line 61
    .line 62
    invoke-direct {v7, v8, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 63
    .line 64
    .line 65
    invoke-virtual {v5, v7}, Ljf/a;->a(Ljf/i;)V

    .line 66
    .line 67
    .line 68
    sget-object v7, Lef/c;->d:Lef/c;

    .line 69
    .line 70
    iput-object v7, v5, Ljf/a;->f:Ljf/e;

    .line 71
    .line 72
    invoke-virtual {v5}, Ljf/a;->b()Ljf/b;

    .line 73
    .line 74
    .line 75
    move-result-object v5

    .line 76
    invoke-static {v5, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    .line 78
    .line 79
    new-instance v7, Ljf/o;

    .line 80
    .line 81
    const-class v8, Lif/b;

    .line 82
    .line 83
    invoke-direct {v7, v8, v4}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 84
    .line 85
    .line 86
    invoke-static {v7}, Ljf/b;->b(Ljf/o;)Ljf/a;

    .line 87
    .line 88
    .line 89
    move-result-object v7

    .line 90
    new-instance v9, Ljf/o;

    .line 91
    .line 92
    invoke-direct {v9, v8, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 93
    .line 94
    .line 95
    new-instance v8, Ljf/i;

    .line 96
    .line 97
    invoke-direct {v8, v9, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 98
    .line 99
    .line 100
    invoke-virtual {v7, v8}, Ljf/a;->a(Ljf/i;)V

    .line 101
    .line 102
    .line 103
    sget-object v8, Lef/c;->e:Lef/c;

    .line 104
    .line 105
    iput-object v8, v7, Ljf/a;->f:Ljf/e;

    .line 106
    .line 107
    invoke-virtual {v7}, Ljf/a;->b()Ljf/b;

    .line 108
    .line 109
    .line 110
    move-result-object v7

    .line 111
    invoke-static {v7, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    .line 113
    .line 114
    new-instance v8, Ljf/o;

    .line 115
    .line 116
    const-class v9, Lif/d;

    .line 117
    .line 118
    invoke-direct {v8, v9, v4}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 119
    .line 120
    .line 121
    invoke-static {v8}, Ljf/b;->b(Ljf/o;)Ljf/a;

    .line 122
    .line 123
    .line 124
    move-result-object v4

    .line 125
    new-instance v8, Ljf/o;

    .line 126
    .line 127
    invoke-direct {v8, v9, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 128
    .line 129
    .line 130
    new-instance v6, Ljf/i;

    .line 131
    .line 132
    invoke-direct {v6, v8, v1, v0}, Ljf/i;-><init>(Ljf/o;II)V

    .line 133
    .line 134
    .line 135
    invoke-virtual {v4, v6}, Ljf/a;->a(Ljf/i;)V

    .line 136
    .line 137
    .line 138
    sget-object v6, Lef/c;->f:Lef/c;

    .line 139
    .line 140
    iput-object v6, v4, Ljf/a;->f:Ljf/e;

    .line 141
    .line 142
    invoke-virtual {v4}, Ljf/a;->b()Ljf/b;

    .line 143
    .line 144
    .line 145
    move-result-object v4

    .line 146
    invoke-static {v4, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 147
    .line 148
    .line 149
    const/4 v3, 0x4

    .line 150
    new-array v3, v3, [Ljf/b;

    .line 151
    .line 152
    aput-object v2, v3, v0

    .line 153
    .line 154
    aput-object v5, v3, v1

    .line 155
    .line 156
    const/4 v0, 0x2

    .line 157
    aput-object v7, v3, v0

    .line 158
    .line 159
    const/4 v0, 0x3

    .line 160
    aput-object v4, v3, v0

    .line 161
    .line 162
    invoke-static {v3}, Lwakotl/collections/c0;->l([Ljava/lang/Object;)Ljava/util/List;

    .line 163
    .line 164
    .line 165
    move-result-object v0

    .line 166
    return-object v0
.end method
