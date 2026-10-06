.class public final Lcom/google/firebase/sessions/w;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lkotlinx/coroutines/flow/i;


# instance fields
.field public final synthetic a:I

.field public final synthetic b:Lkotlinx/coroutines/flow/i;

.field public final synthetic c:Ljava/lang/Object;


# direct methods
.method public synthetic constructor <init>(Lkotlinx/coroutines/flow/i;Ljava/lang/Object;I)V
    .locals 0

    .line 1
    iput p3, p0, Lcom/google/firebase/sessions/w;->a:I

    iput-object p1, p0, Lcom/google/firebase/sessions/w;->b:Lkotlinx/coroutines/flow/i;

    iput-object p2, p0, Lcom/google/firebase/sessions/w;->c:Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Lwakotl/jvm/functions/Function2;Lkotlinx/coroutines/flow/i;)V
    .locals 1

    const/4 v0, 0x1

    iput v0, p0, Lcom/google/firebase/sessions/w;->a:I

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    iput-object p2, p0, Lcom/google/firebase/sessions/w;->b:Lkotlinx/coroutines/flow/i;

    check-cast p1, Lwakotl/coroutines/jvm/internal/SuspendLambda;

    iput-object p1, p0, Lcom/google/firebase/sessions/w;->c:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final collect(Lkotlinx/coroutines/flow/j;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3

    .line 1
    iget v0, p0, Lcom/google/firebase/sessions/w;->a:I

    .line 2
    .line 3
    packed-switch v0, :pswitch_data_0

    .line 4
    .line 5
    .line 6
    new-instance v0, Lkotlinx/coroutines/flow/m1;

    .line 7
    .line 8
    iget-object v1, p0, Lcom/google/firebase/sessions/w;->c:Ljava/lang/Object;

    .line 9
    .line 10
    invoke-direct {v0, v1, p1}, Lkotlinx/coroutines/flow/m1;-><init>(Lwakotl/jvm/functions/Function2;Lkotlinx/coroutines/flow/j;)V

    .line 11
    .line 12
    .line 13
    iget-object p1, p0, Lcom/google/firebase/sessions/w;->b:Lkotlinx/coroutines/flow/i;

    .line 14
    .line 15
    invoke-interface {p1, v0, p2}, Lkotlinx/coroutines/flow/i;->collect(Lkotlinx/coroutines/flow/j;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 16
    .line 17
    .line 18
    move-result-object p1

    .line 19
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object p2

    .line 23
    if-ne p1, p2, :cond_0

    .line 24
    .line 25
    goto :goto_0

    .line 26
    :cond_0
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 27
    .line 28
    :goto_0
    return-object p1

    .line 29
    :pswitch_0
    new-instance v0, Lwakotl/jvm/internal/Ref$BooleanRef;

    .line 30
    .line 31
    invoke-direct {v0}, Lwakotl/jvm/internal/Ref$BooleanRef;-><init>()V

    .line 32
    .line 33
    .line 34
    new-instance v1, Lkotlinx/coroutines/flow/h0;

    .line 35
    .line 36
    iget-object v2, p0, Lcom/google/firebase/sessions/w;->c:Ljava/lang/Object;

    .line 37
    .line 38
    check-cast v2, Lwakotl/coroutines/jvm/internal/SuspendLambda;

    .line 39
    .line 40
    invoke-direct {v1, v0, p1, v2}, Lkotlinx/coroutines/flow/h0;-><init>(Lwakotl/jvm/internal/Ref$BooleanRef;Lkotlinx/coroutines/flow/j;Lwakotl/jvm/functions/Function2;)V

    .line 41
    .line 42
    .line 43
    iget-object p1, p0, Lcom/google/firebase/sessions/w;->b:Lkotlinx/coroutines/flow/i;

    .line 44
    .line 45
    invoke-interface {p1, v1, p2}, Lkotlinx/coroutines/flow/i;->collect(Lkotlinx/coroutines/flow/j;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 46
    .line 47
    .line 48
    move-result-object p1

    .line 49
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 50
    .line 51
    .line 52
    move-result-object p2

    .line 53
    if-ne p1, p2, :cond_1

    .line 54
    .line 55
    goto :goto_1

    .line 56
    :cond_1
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 57
    .line 58
    :goto_1
    return-object p1

    .line 59
    :pswitch_1
    new-instance v0, Lcom/google/firebase/sessions/v;

    .line 60
    .line 61
    iget-object v1, p0, Lcom/google/firebase/sessions/w;->c:Ljava/lang/Object;

    .line 62
    .line 63
    check-cast v1, Lcom/google/firebase/sessions/x;

    .line 64
    .line 65
    invoke-direct {v0, p1, v1}, Lcom/google/firebase/sessions/v;-><init>(Lkotlinx/coroutines/flow/j;Lcom/google/firebase/sessions/x;)V

    .line 66
    .line 67
    .line 68
    iget-object p1, p0, Lcom/google/firebase/sessions/w;->b:Lkotlinx/coroutines/flow/i;

    .line 69
    .line 70
    check-cast p1, Lkotlinx/coroutines/flow/d0;

    .line 71
    .line 72
    invoke-virtual {p1, v0, p2}, Lkotlinx/coroutines/flow/d0;->collect(Lkotlinx/coroutines/flow/j;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 73
    .line 74
    .line 75
    move-result-object p1

    .line 76
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 77
    .line 78
    .line 79
    move-result-object p2

    .line 80
    if-ne p1, p2, :cond_2

    .line 81
    .line 82
    goto :goto_2

    .line 83
    :cond_2
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 84
    .line 85
    :goto_2
    return-object p1

    .line 86
    nop

    .line 87
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
