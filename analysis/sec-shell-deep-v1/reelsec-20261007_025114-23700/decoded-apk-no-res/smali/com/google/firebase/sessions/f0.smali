.class public final Lcom/google/firebase/sessions/f0;
.super Landroid/os/Handler;
.source "SourceFile"


# instance fields
.field public final a:Lwakotl/coroutines/CoroutineContext;


# direct methods
.method public constructor <init>(Lwakotl/coroutines/CoroutineContext;)V
    .locals 1

    .line 1
    const-string v0, "backgroundDispatcher"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    .line 7
    .line 8
    .line 9
    move-result-object v0

    .line 10
    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 11
    .line 12
    .line 13
    iput-object p1, p0, Lcom/google/firebase/sessions/f0;->a:Lwakotl/coroutines/CoroutineContext;

    .line 14
    .line 15
    return-void
.end method


# virtual methods
.method public final handleMessage(Landroid/os/Message;)V
    .locals 4

    .line 1
    const-string v0, "msg"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    iget v0, p1, Landroid/os/Message;->what:I

    .line 7
    .line 8
    const/4 v1, 0x3

    .line 9
    if-ne v0, v1, :cond_2

    .line 10
    .line 11
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    .line 12
    .line 13
    .line 14
    move-result-object p1

    .line 15
    if-eqz p1, :cond_0

    .line 16
    .line 17
    const-string v0, "SessionUpdateExtra"

    .line 18
    .line 19
    invoke-virtual {p1, v0}, Landroid/os/BaseBundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    .line 20
    .line 21
    .line 22
    move-result-object p1

    .line 23
    if-nez p1, :cond_1

    .line 24
    .line 25
    :cond_0
    const-string p1, ""

    .line 26
    .line 27
    :cond_1
    iget-object v0, p0, Lcom/google/firebase/sessions/f0;->a:Lwakotl/coroutines/CoroutineContext;

    .line 28
    .line 29
    invoke-static {v0}, Lkotlinx/coroutines/g0;->a(Lwakotl/coroutines/CoroutineContext;)Lmq/d;

    .line 30
    .line 31
    .line 32
    move-result-object v0

    .line 33
    new-instance v2, Lcom/google/firebase/sessions/SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1;

    .line 34
    .line 35
    const/4 v3, 0x0

    .line 36
    invoke-direct {v2, p1, v3}, Lcom/google/firebase/sessions/SessionLifecycleClient$ClientUpdateHandler$handleSessionUpdate$1;-><init>(Ljava/lang/String;Lwakotl/coroutines/Continuation;)V

    .line 37
    .line 38
    .line 39
    invoke-static {v0, v3, v3, v2, v1}, Lkotlinx/coroutines/g0;->A(Lkotlinx/coroutines/e0;Lwakotl/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lwakotl/jvm/functions/Function2;I)Lkotlinx/coroutines/z1;

    .line 40
    .line 41
    .line 42
    goto :goto_0

    .line 43
    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    .line 44
    .line 45
    .line 46
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 47
    .line 48
    .line 49
    :goto_0
    return-void
.end method
