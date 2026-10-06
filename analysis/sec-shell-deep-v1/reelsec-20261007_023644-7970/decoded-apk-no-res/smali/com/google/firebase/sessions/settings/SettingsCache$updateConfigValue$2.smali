.class final Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;
.super Lwakotl/coroutines/jvm/internal/SuspendLambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/coroutines/jvm/internal/SuspendLambda;",
        "Lwakotl/jvm/functions/Function2<",
        "Landroidx/datastore/preferences/core/b;",
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
        "\u0000\u0010\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0010\u0004\u001a\u00020\u0003\"\u0004\u0008\u0000\u0010\u00002\u0006\u0010\u0002\u001a\u00020\u0001H\u008a@\u00a2\u0006\u0004\u0008\u0004\u0010\u0005"
    }
    d2 = {
        "T",
        "Landroidx/datastore/preferences/core/b;",
        "preferences",
        "",
        "<anonymous>",
        "(Landroidx/datastore/preferences/core/b;)V"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
.end annotation

.annotation runtime Lwakotl/coroutines/jvm/internal/DebugMetadata;
    c = "com.google.firebase.sessions.settings.SettingsCache$updateConfigValue$2"
    f = "SettingsCache.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $key:Landroidx/datastore/preferences/core/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/datastore/preferences/core/e;"
        }
    .end annotation
.end field

.field final synthetic $value:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Object;"
        }
    .end annotation
.end field

.field synthetic L$0:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/google/firebase/sessions/settings/f;


# direct methods
.method public constructor <init>(Ljava/lang/Object;Landroidx/datastore/preferences/core/e;Lcom/google/firebase/sessions/settings/f;Lwakotl/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Landroidx/datastore/preferences/core/e;",
            "Lcom/google/firebase/sessions/settings/f;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$value:Ljava/lang/Object;

    iput-object p2, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$key:Landroidx/datastore/preferences/core/e;

    iput-object p3, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->this$0:Lcom/google/firebase/sessions/settings/f;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p4}, Lwakotl/coroutines/jvm/internal/SuspendLambda;-><init>(ILwakotl/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;
    .locals 4
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

    new-instance v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;

    iget-object v1, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$value:Ljava/lang/Object;

    iget-object v2, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$key:Landroidx/datastore/preferences/core/e;

    iget-object v3, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->this$0:Lcom/google/firebase/sessions/settings/f;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;-><init>(Ljava/lang/Object;Landroidx/datastore/preferences/core/e;Lcom/google/firebase/sessions/settings/f;Lwakotl/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->L$0:Ljava/lang/Object;

    return-object v0
.end method

.method public final invoke(Landroidx/datastore/preferences/core/b;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .param p1    # Landroidx/datastore/preferences/core/b;
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
            "Landroidx/datastore/preferences/core/b;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lwakotl/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 1
    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;

    sget-object p2, Lwakotl/Unit;->a:Lwakotl/Unit;

    invoke-virtual {p1, p2}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 2
    check-cast p1, Landroidx/datastore/preferences/core/b;

    check-cast p2, Lwakotl/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->invoke(Landroidx/datastore/preferences/core/b;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
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
    iget v0, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->label:I

    .line 5
    .line 6
    if-nez v0, :cond_1

    .line 7
    .line 8
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 9
    .line 10
    .line 11
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->L$0:Ljava/lang/Object;

    .line 12
    .line 13
    check-cast p1, Landroidx/datastore/preferences/core/b;

    .line 14
    .line 15
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$value:Ljava/lang/Object;

    .line 16
    .line 17
    const-string v1, "key"

    .line 18
    .line 19
    if-eqz v0, :cond_0

    .line 20
    .line 21
    iget-object v2, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$key:Landroidx/datastore/preferences/core/e;

    .line 22
    .line 23
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 24
    .line 25
    .line 26
    invoke-static {v2, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    .line 28
    .line 29
    invoke-virtual {p1, v2, v0}, Landroidx/datastore/preferences/core/b;->d(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;)V

    .line 30
    .line 31
    .line 32
    goto :goto_0

    .line 33
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->$key:Landroidx/datastore/preferences/core/e;

    .line 34
    .line 35
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 36
    .line 37
    .line 38
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    .line 40
    .line 41
    invoke-virtual {p1}, Landroidx/datastore/preferences/core/b;->c()V

    .line 42
    .line 43
    .line 44
    iget-object v1, p1, Landroidx/datastore/preferences/core/b;->a:Ljava/util/LinkedHashMap;

    .line 45
    .line 46
    invoke-interface {v1, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 47
    .line 48
    .line 49
    :goto_0
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/SettingsCache$updateConfigValue$2;->this$0:Lcom/google/firebase/sessions/settings/f;

    .line 50
    .line 51
    invoke-static {v0, p1}, Lcom/google/firebase/sessions/settings/f;->a(Lcom/google/firebase/sessions/settings/f;Landroidx/datastore/preferences/core/g;)V

    .line 52
    .line 53
    .line 54
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 55
    .line 56
    return-object p1

    .line 57
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 58
    .line 59
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 60
    .line 61
    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 62
    .line 63
    .line 64
    throw p1
.end method
