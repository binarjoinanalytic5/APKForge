.class public final Lcom/google/firebase/messaging/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ldg/c;


# static fields
.field public static final a:Lcom/google/firebase/messaging/b;

.field public static final b:Ldg/b;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/messaging/b;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/messaging/b;->a:Lcom/google/firebase/messaging/b;

    .line 7
    .line 8
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    const/4 v1, 0x1

    .line 13
    iput v1, v0, Landroidx/compose/animation/core/u;->a:I

    .line 14
    .line 15
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 16
    .line 17
    .line 18
    move-result-object v0

    .line 19
    const-class v1, Lgg/c;

    .line 20
    .line 21
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    new-instance v1, Ldg/b;

    .line 26
    .line 27
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 28
    .line 29
    .line 30
    move-result-object v0

    .line 31
    const-string v2, "messagingClientEvent"

    .line 32
    .line 33
    invoke-direct {v1, v2, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 34
    .line 35
    .line 36
    sput-object v1, Lcom/google/firebase/messaging/b;->b:Ldg/b;

    .line 37
    .line 38
    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1

    .line 1
    check-cast p1, Lrg/c;

    .line 2
    .line 3
    check-cast p2, Ldg/d;

    .line 4
    .line 5
    iget-object p1, p1, Lrg/c;->a:Lrg/b;

    .line 6
    .line 7
    sget-object v0, Lcom/google/firebase/messaging/b;->b:Ldg/b;

    .line 8
    .line 9
    invoke-interface {p2, v0, p1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 10
    .line 11
    .line 12
    return-void
.end method
