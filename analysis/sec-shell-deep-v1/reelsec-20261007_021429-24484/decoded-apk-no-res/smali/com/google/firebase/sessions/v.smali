.class public final Lcom/google/firebase/sessions/v;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lkotlinx/coroutines/flow/j;


# instance fields
.field public final synthetic a:Lkotlinx/coroutines/flow/j;

.field public final synthetic b:Lcom/google/firebase/sessions/x;


# direct methods
.method public constructor <init>(Lkotlinx/coroutines/flow/j;Lcom/google/firebase/sessions/x;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/sessions/v;->a:Lkotlinx/coroutines/flow/j;

    iput-object p2, p0, Lcom/google/firebase/sessions/v;->b:Lcom/google/firebase/sessions/x;

    return-void
.end method


# virtual methods
.method public final emit(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 4

    .line 1
    instance-of v0, p2, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    move-object v0, p2

    .line 6
    check-cast v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;

    .line 7
    .line 8
    iget v1, v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;->label:I

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
    iput v1, v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;->label:I

    .line 18
    .line 19
    goto :goto_0

    .line 20
    :cond_0
    new-instance v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;

    .line 21
    .line 22
    invoke-direct {v0, p0, p2}, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;-><init>(Lcom/google/firebase/sessions/v;Lwakotl/coroutines/Continuation;)V

    .line 23
    .line 24
    .line 25
    :goto_0
    iget-object p2, v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;->result:Ljava/lang/Object;

    .line 26
    .line 27
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 28
    .line 29
    .line 30
    move-result-object v1

    .line 31
    iget v2, v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;->label:I

    .line 32
    .line 33
    const/4 v3, 0x1

    .line 34
    if-eqz v2, :cond_2

    .line 35
    .line 36
    if-ne v2, v3, :cond_1

    .line 37
    .line 38
    invoke-static {p2}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 39
    .line 40
    .line 41
    goto :goto_1

    .line 42
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 43
    .line 44
    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    .line 45
    .line 46
    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 47
    .line 48
    .line 49
    throw p1

    .line 50
    :cond_2
    invoke-static {p2}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 51
    .line 52
    .line 53
    check-cast p1, Landroidx/datastore/preferences/core/g;

    .line 54
    .line 55
    sget-object p2, Lcom/google/firebase/sessions/x;->e:Lcom/google/firebase/sessions/t;

    .line 56
    .line 57
    iget-object p2, p0, Lcom/google/firebase/sessions/v;->b:Lcom/google/firebase/sessions/x;

    .line 58
    .line 59
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 60
    .line 61
    .line 62
    new-instance p2, Lcom/google/firebase/sessions/l;

    .line 63
    .line 64
    sget-object v2, Lcom/google/firebase/sessions/u;->a:Landroidx/datastore/preferences/core/e;

    .line 65
    .line 66
    invoke-virtual {p1, v2}, Landroidx/datastore/preferences/core/g;->b(Landroidx/datastore/preferences/core/e;)Ljava/lang/Object;

    .line 67
    .line 68
    .line 69
    move-result-object p1

    .line 70
    check-cast p1, Ljava/lang/String;

    .line 71
    .line 72
    invoke-direct {p2, p1}, Lcom/google/firebase/sessions/l;-><init>(Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    iput v3, v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$special$$inlined$map$1$2$1;->label:I

    .line 76
    .line 77
    iget-object p1, p0, Lcom/google/firebase/sessions/v;->a:Lkotlinx/coroutines/flow/j;

    .line 78
    .line 79
    invoke-interface {p1, p2, v0}, Lkotlinx/coroutines/flow/j;->emit(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 80
    .line 81
    .line 82
    move-result-object p1

    .line 83
    if-ne p1, v1, :cond_3

    .line 84
    .line 85
    return-object v1

    .line 86
    :cond_3
    :goto_1
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 87
    .line 88
    return-object p1
.end method
