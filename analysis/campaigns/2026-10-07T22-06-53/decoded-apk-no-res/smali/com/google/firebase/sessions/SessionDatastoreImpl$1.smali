.class final Lcom/google/firebase/sessions/SessionDatastoreImpl$1;
.super Lwakotl/coroutines/jvm/internal/SuspendLambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/coroutines/jvm/internal/SuspendLambda;",
        "Lwakotl/jvm/functions/Function2<",
        "Lkotlinx/coroutines/e0;",
        "Lwakotl/coroutines/Continuation<",
        "-",
        "Lwakotl/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lwakotl/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@\u00a2\u0006\u0004\u0008\u0002\u0010\u0003"
    }
    d2 = {
        "Lkotlinx/coroutines/e0;",
        "",
        "<anonymous>",
        "(Lkotlinx/coroutines/e0;)V"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
.end annotation

.annotation runtime Lwakotl/coroutines/jvm/internal/DebugMetadata;
    c = "com.google.firebase.sessions.SessionDatastoreImpl$1"
    f = "SessionDatastore.kt"
    i = {}
    l = {
        0x52
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field label:I

.field final synthetic this$0:Lcom/google/firebase/sessions/x;


# direct methods
.method public constructor <init>(Lcom/google/firebase/sessions/x;Lwakotl/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/sessions/x;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/sessions/SessionDatastoreImpl$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->this$0:Lcom/google/firebase/sessions/x;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p2}, Lwakotl/coroutines/jvm/internal/SuspendLambda;-><init>(ILwakotl/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;
    .locals 1
    .param p1    # Ljava/lang/Object;
        .annotation build Lorg/jetbrains/annotations/Nullable;
        .end annotation
    .end param
    .param p2    # Lwakotl/coroutines/Continuation;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lwakotl/coroutines/Continuation<",
            "*>;)",
            "Lwakotl/coroutines/Continuation<",
            "Lwakotl/Unit;",
            ">;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation

    new-instance p1, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;

    iget-object v0, p0, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->this$0:Lcom/google/firebase/sessions/x;

    invoke-direct {p1, v0, p2}, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;-><init>(Lcom/google/firebase/sessions/x;Lwakotl/coroutines/Continuation;)V

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 1
    check-cast p1, Lkotlinx/coroutines/e0;

    check-cast p2, Lwakotl/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->invoke(Lkotlinx/coroutines/e0;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invoke(Lkotlinx/coroutines/e0;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .param p1    # Lkotlinx/coroutines/e0;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .param p2    # Lwakotl/coroutines/Continuation;
        .annotation build Lorg/jetbrains/annotations/Nullable;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/e0;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lwakotl/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 2
    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;

    sget-object p2, Lwakotl/Unit;->a:Lwakotl/Unit;

    invoke-virtual {p1, p2}, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1    # Ljava/lang/Object;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 1
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    iget v1, p0, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->label:I

    .line 6
    .line 7
    const/4 v2, 0x1

    .line 8
    if-eqz v1, :cond_1

    .line 9
    .line 10
    if-ne v1, v2, :cond_0

    .line 11
    .line 12
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 13
    .line 14
    .line 15
    goto :goto_0

    .line 16
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 17
    .line 18
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 19
    .line 20
    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 21
    .line 22
    .line 23
    throw p1

    .line 24
    :cond_1
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 25
    .line 26
    .line 27
    iget-object p1, p0, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->this$0:Lcom/google/firebase/sessions/x;

    .line 28
    .line 29
    iget-object v1, p1, Lcom/google/firebase/sessions/x;->d:Lcom/google/firebase/sessions/w;

    .line 30
    .line 31
    new-instance v3, Lcom/google/firebase/sessions/s;

    .line 32
    .line 33
    invoke-direct {v3, p1}, Lcom/google/firebase/sessions/s;-><init>(Lcom/google/firebase/sessions/x;)V

    .line 34
    .line 35
    .line 36
    iput v2, p0, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;->label:I

    .line 37
    .line 38
    invoke-virtual {v1, v3, p0}, Lcom/google/firebase/sessions/w;->collect(Lkotlinx/coroutines/flow/j;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 39
    .line 40
    .line 41
    move-result-object p1

    .line 42
    if-ne p1, v0, :cond_2

    .line 43
    .line 44
    return-object v0

    .line 45
    :cond_2
    :goto_0
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 46
    .line 47
    return-object p1
.end method
