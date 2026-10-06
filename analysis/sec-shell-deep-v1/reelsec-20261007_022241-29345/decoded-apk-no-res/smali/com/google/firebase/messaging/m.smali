.class public final synthetic Lcom/google/firebase/messaging/m;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljf/e;


# instance fields
.field public final synthetic a:I

.field public final synthetic b:Ljf/o;


# direct methods
.method public synthetic constructor <init>(Ljf/o;I)V
    .locals 0

    .line 1
    iput p2, p0, Lcom/google/firebase/messaging/m;->a:I

    iput-object p1, p0, Lcom/google/firebase/messaging/m;->b:Ljf/o;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final f(Lcom/google/firebase/messaging/v;)Ljava/lang/Object;
    .locals 7

    .line 1
    iget v0, p0, Lcom/google/firebase/messaging/m;->a:I

    .line 2
    .line 3
    packed-switch v0, :pswitch_data_0

    .line 4
    .line 5
    .line 6
    new-instance v0, Lig/c;

    .line 7
    .line 8
    const-class v1, Landroid/content/Context;

    .line 9
    .line 10
    invoke-virtual {p1, v1}, Lcom/google/firebase/messaging/v;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 11
    .line 12
    .line 13
    move-result-object v1

    .line 14
    move-object v2, v1

    .line 15
    check-cast v2, Landroid/content/Context;

    .line 16
    .line 17
    const-class v1, Lef/h;

    .line 18
    .line 19
    invoke-virtual {p1, v1}, Lcom/google/firebase/messaging/v;->a(Ljava/lang/Class;)Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object v1

    .line 23
    check-cast v1, Lef/h;

    .line 24
    .line 25
    invoke-virtual {v1}, Lef/h;->d()Ljava/lang/String;

    .line 26
    .line 27
    .line 28
    move-result-object v3

    .line 29
    const-class v1, Lig/d;

    .line 30
    .line 31
    invoke-virtual {p1, v1}, Lcom/google/firebase/messaging/v;->o(Ljava/lang/Class;)Ljava/util/Set;

    .line 32
    .line 33
    .line 34
    move-result-object v4

    .line 35
    const-class v1, Lsg/b;

    .line 36
    .line 37
    invoke-virtual {p1, v1}, Lcom/google/firebase/messaging/v;->e(Ljava/lang/Class;)Lkg/b;

    .line 38
    .line 39
    .line 40
    move-result-object v5

    .line 41
    iget-object v1, p0, Lcom/google/firebase/messaging/m;->b:Ljf/o;

    .line 42
    .line 43
    invoke-virtual {p1, v1}, Lcom/google/firebase/messaging/v;->c(Ljf/o;)Ljava/lang/Object;

    .line 44
    .line 45
    .line 46
    move-result-object p1

    .line 47
    move-object v6, p1

    .line 48
    check-cast v6, Ljava/util/concurrent/Executor;

    .line 49
    .line 50
    move-object v1, v0

    .line 51
    invoke-direct/range {v1 .. v6}, Lig/c;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/util/Set;Lkg/b;Ljava/util/concurrent/Executor;)V

    .line 52
    .line 53
    .line 54
    return-object v0

    .line 55
    :pswitch_0
    iget-object v0, p0, Lcom/google/firebase/messaging/m;->b:Ljf/o;

    .line 56
    .line 57
    invoke-static {v0, p1}, Lcom/google/firebase/messaging/FirebaseMessagingRegistrar;->a(Ljf/o;Lcom/google/firebase/messaging/v;)Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 58
    .line 59
    .line 60
    move-result-object p1

    .line 61
    return-object p1

    .line 62
    nop

    .line 63
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
