.class public final Lcom/google/firebase/sessions/c0;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/sessions/b0;


# static fields
.field public static final f:D

.field public static final synthetic g:I


# instance fields
.field public final a:Lef/h;

.field public final b:Llg/d;

.field public final c:Lcom/google/firebase/sessions/settings/e;

.field public final d:Lcom/google/firebase/sessions/j;

.field public final e:Lwakotl/coroutines/CoroutineContext;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    invoke-static {}, Ljava/lang/Math;->random()D

    .line 2
    .line 3
    .line 4
    move-result-wide v0

    .line 5
    sput-wide v0, Lcom/google/firebase/sessions/c0;->f:D

    .line 6
    .line 7
    return-void
.end method

.method public constructor <init>(Lef/h;Llg/d;Lcom/google/firebase/sessions/settings/e;Lcom/google/firebase/sessions/j;Lwakotl/coroutines/CoroutineContext;)V
    .locals 1

    .line 1
    const-string v0, "firebaseApp"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    const-string v0, "firebaseInstallations"

    .line 7
    .line 8
    invoke-static {p2, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    const-string v0, "sessionSettings"

    .line 12
    .line 13
    invoke-static {p3, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    .line 15
    .line 16
    const-string v0, "eventGDTLogger"

    .line 17
    .line 18
    invoke-static {p4, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    const-string v0, "backgroundDispatcher"

    .line 22
    .line 23
    invoke-static {p5, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    .line 25
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    .line 28
    .line 29
    iput-object p1, p0, Lcom/google/firebase/sessions/c0;->a:Lef/h;

    .line 30
    .line 31
    iput-object p2, p0, Lcom/google/firebase/sessions/c0;->b:Llg/d;

    .line 32
    .line 33
    iput-object p3, p0, Lcom/google/firebase/sessions/c0;->c:Lcom/google/firebase/sessions/settings/e;

    .line 34
    .line 35
    iput-object p4, p0, Lcom/google/firebase/sessions/c0;->d:Lcom/google/firebase/sessions/j;

    .line 36
    .line 37
    iput-object p5, p0, Lcom/google/firebase/sessions/c0;->e:Lwakotl/coroutines/CoroutineContext;

    .line 38
    .line 39
    return-void
.end method

.method public static final a(Lcom/google/firebase/sessions/c0;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;
    .locals 4

    .line 1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    instance-of v0, p1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;

    .line 5
    .line 6
    if-eqz v0, :cond_0

    .line 7
    .line 8
    move-object v0, p1

    .line 9
    check-cast v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;

    .line 10
    .line 11
    iget v1, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->label:I

    .line 12
    .line 13
    const/high16 v2, -0x80000000

    .line 14
    .line 15
    and-int v3, v1, v2

    .line 16
    .line 17
    if-eqz v3, :cond_0

    .line 18
    .line 19
    sub-int/2addr v1, v2

    .line 20
    iput v1, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->label:I

    .line 21
    .line 22
    goto :goto_0

    .line 23
    :cond_0
    new-instance v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;

    .line 24
    .line 25
    invoke-direct {v0, p0, p1}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;-><init>(Lcom/google/firebase/sessions/c0;Lwakotl/coroutines/Continuation;)V

    .line 26
    .line 27
    .line 28
    :goto_0
    iget-object p1, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->result:Ljava/lang/Object;

    .line 29
    .line 30
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 31
    .line 32
    .line 33
    move-result-object v1

    .line 34
    iget v2, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->label:I

    .line 35
    .line 36
    const/4 v3, 0x1

    .line 37
    if-eqz v2, :cond_2

    .line 38
    .line 39
    if-ne v2, v3, :cond_1

    .line 40
    .line 41
    iget-object p0, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->L$0:Ljava/lang/Object;

    .line 42
    .line 43
    check-cast p0, Lcom/google/firebase/sessions/c0;

    .line 44
    .line 45
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 46
    .line 47
    .line 48
    goto :goto_1

    .line 49
    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    .line 50
    .line 51
    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    .line 52
    .line 53
    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 54
    .line 55
    .line 56
    throw p0

    .line 57
    :cond_2
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 58
    .line 59
    .line 60
    iput-object p0, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->L$0:Ljava/lang/Object;

    .line 61
    .line 62
    iput v3, v0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$shouldLogSession$1;->label:I

    .line 63
    .line 64
    iget-object p1, p0, Lcom/google/firebase/sessions/c0;->c:Lcom/google/firebase/sessions/settings/e;

    .line 65
    .line 66
    invoke-virtual {p1, v0}, Lcom/google/firebase/sessions/settings/e;->b(Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 67
    .line 68
    .line 69
    move-result-object p1

    .line 70
    if-ne p1, v1, :cond_3

    .line 71
    .line 72
    goto :goto_3

    .line 73
    :cond_3
    :goto_1
    iget-object p1, p0, Lcom/google/firebase/sessions/c0;->c:Lcom/google/firebase/sessions/settings/e;

    .line 74
    .line 75
    iget-object v0, p1, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 76
    .line 77
    invoke-virtual {v0}, Lcom/google/firebase/messaging/p;->h()Ljava/lang/Boolean;

    .line 78
    .line 79
    .line 80
    move-result-object v0

    .line 81
    if-eqz v0, :cond_4

    .line 82
    .line 83
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    .line 84
    .line 85
    .line 86
    move-result p1

    .line 87
    goto :goto_2

    .line 88
    :cond_4
    iget-object p1, p1, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 89
    .line 90
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->a()Ljava/lang/Boolean;

    .line 91
    .line 92
    .line 93
    move-result-object p1

    .line 94
    if-eqz p1, :cond_5

    .line 95
    .line 96
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    .line 97
    .line 98
    .line 99
    move-result p1

    .line 100
    goto :goto_2

    .line 101
    :cond_5
    move p1, v3

    .line 102
    :goto_2
    const/4 v0, 0x0

    .line 103
    if-nez p1, :cond_6

    .line 104
    .line 105
    invoke-static {v0}, Lwakotl/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    .line 106
    .line 107
    .line 108
    move-result-object v1

    .line 109
    goto :goto_3

    .line 110
    :cond_6
    iget-object p0, p0, Lcom/google/firebase/sessions/c0;->c:Lcom/google/firebase/sessions/settings/e;

    .line 111
    .line 112
    invoke-virtual {p0}, Lcom/google/firebase/sessions/settings/e;->a()D

    .line 113
    .line 114
    .line 115
    move-result-wide p0

    .line 116
    sget-wide v1, Lcom/google/firebase/sessions/c0;->f:D

    .line 117
    .line 118
    cmpg-double p0, v1, p0

    .line 119
    .line 120
    if-gtz p0, :cond_7

    .line 121
    .line 122
    invoke-static {v3}, Lwakotl/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    .line 123
    .line 124
    .line 125
    move-result-object v1

    .line 126
    goto :goto_3

    .line 127
    :cond_7
    invoke-static {v0}, Lwakotl/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    .line 128
    .line 129
    .line 130
    move-result-object v1

    .line 131
    :goto_3
    return-object v1
.end method
