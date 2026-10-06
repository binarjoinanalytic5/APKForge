.class public final Lcom/google/firebase/sessions/x;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/sessions/r;


# static fields
.field public static final e:Lcom/google/firebase/sessions/t;

.field public static final f:Landroidx/datastore/preferences/b;


# instance fields
.field public final a:Landroid/content/Context;

.field public final b:Lwakotl/coroutines/CoroutineContext;

.field public final c:Ljava/util/concurrent/atomic/AtomicReference;

.field public final d:Lcom/google/firebase/sessions/w;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/t;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/x;->e:Lcom/google/firebase/sessions/t;

    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/sessions/q;->a:Ljava/lang/String;

    .line 9
    .line 10
    new-instance v1, Lkotlinx/serialization/json/internal/o;

    .line 11
    .line 12
    sget-object v2, Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;->INSTANCE:Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;

    .line 13
    .line 14
    invoke-direct {v1, v2}, Lkotlinx/serialization/json/internal/o;-><init>(Lwakotl/jvm/functions/Function1;)V

    .line 15
    .line 16
    .line 17
    const/16 v2, 0xc

    .line 18
    .line 19
    invoke-static {v0, v1, v2}, Landroidx/datastore/preferences/a;->a(Ljava/lang/String;Lkotlinx/serialization/json/internal/o;I)Landroidx/datastore/preferences/b;

    .line 20
    .line 21
    .line 22
    move-result-object v0

    .line 23
    sput-object v0, Lcom/google/firebase/sessions/x;->f:Landroidx/datastore/preferences/b;

    .line 24
    .line 25
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lwakotl/coroutines/CoroutineContext;)V
    .locals 3

    .line 1
    const-string v0, "context"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    const-string v0, "backgroundDispatcher"

    .line 7
    .line 8
    invoke-static {p2, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    .line 13
    .line 14
    iput-object p1, p0, Lcom/google/firebase/sessions/x;->a:Landroid/content/Context;

    .line 15
    .line 16
    iput-object p2, p0, Lcom/google/firebase/sessions/x;->b:Lwakotl/coroutines/CoroutineContext;

    .line 17
    .line 18
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    .line 19
    .line 20
    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 21
    .line 22
    .line 23
    iput-object v0, p0, Lcom/google/firebase/sessions/x;->c:Ljava/util/concurrent/atomic/AtomicReference;

    .line 24
    .line 25
    sget-object v0, Lcom/google/firebase/sessions/x;->e:Lcom/google/firebase/sessions/t;

    .line 26
    .line 27
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 28
    .line 29
    .line 30
    sget-object v0, Lcom/google/firebase/sessions/t;->a:[Lwakotl/reflect/KProperty;

    .line 31
    .line 32
    const/4 v1, 0x0

    .line 33
    aget-object v0, v0, v1

    .line 34
    .line 35
    sget-object v1, Lcom/google/firebase/sessions/x;->f:Landroidx/datastore/preferences/b;

    .line 36
    .line 37
    invoke-virtual {v1, p1, v0}, Landroidx/datastore/preferences/b;->getValue(Ljava/lang/Object;Lwakotl/reflect/KProperty;)Ljava/lang/Object;

    .line 38
    .line 39
    .line 40
    move-result-object p1

    .line 41
    check-cast p1, Landroidx/datastore/core/h;

    .line 42
    .line 43
    invoke-interface {p1}, Landroidx/datastore/core/h;->getData()Lkotlinx/coroutines/flow/i;

    .line 44
    .line 45
    .line 46
    move-result-object p1

    .line 47
    new-instance v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$firebaseSessionDataFlow$1;

    .line 48
    .line 49
    const/4 v1, 0x0

    .line 50
    invoke-direct {v0, v1}, Lcom/google/firebase/sessions/SessionDatastoreImpl$firebaseSessionDataFlow$1;-><init>(Lwakotl/coroutines/Continuation;)V

    .line 51
    .line 52
    .line 53
    new-instance v2, Lkotlinx/coroutines/flow/d0;

    .line 54
    .line 55
    invoke-direct {v2, p1, v0}, Lkotlinx/coroutines/flow/d0;-><init>(Lkotlinx/coroutines/flow/i;Lbq/n;)V

    .line 56
    .line 57
    .line 58
    new-instance p1, Lcom/google/firebase/sessions/w;

    .line 59
    .line 60
    const/4 v0, 0x0

    .line 61
    invoke-direct {p1, v2, p0, v0}, Lcom/google/firebase/sessions/w;-><init>(Lkotlinx/coroutines/flow/i;Ljava/lang/Object;I)V

    .line 62
    .line 63
    .line 64
    iput-object p1, p0, Lcom/google/firebase/sessions/x;->d:Lcom/google/firebase/sessions/w;

    .line 65
    .line 66
    invoke-static {p2}, Lkotlinx/coroutines/g0;->a(Lwakotl/coroutines/CoroutineContext;)Lmq/d;

    .line 67
    .line 68
    .line 69
    move-result-object p1

    .line 70
    new-instance p2, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;

    .line 71
    .line 72
    invoke-direct {p2, p0, v1}, Lcom/google/firebase/sessions/SessionDatastoreImpl$1;-><init>(Lcom/google/firebase/sessions/x;Lwakotl/coroutines/Continuation;)V

    .line 73
    .line 74
    .line 75
    const/4 v0, 0x3

    .line 76
    invoke-static {p1, v1, v1, p2, v0}, Lkotlinx/coroutines/g0;->A(Lkotlinx/coroutines/e0;Lwakotl/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lwakotl/jvm/functions/Function2;I)Lkotlinx/coroutines/z1;

    .line 77
    .line 78
    .line 79
    return-void
.end method
