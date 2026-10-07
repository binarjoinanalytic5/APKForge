.class final Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;
.super Lwakotl/jvm/internal/Lambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/jvm/internal/Lambda;",
        "Lwakotl/jvm/functions/Function1<",
        "Landroidx/datastore/core/CorruptionException;",
        "Landroidx/datastore/preferences/core/g;",
        ">;"
    }
.end annotation

.annotation runtime Lwakotl/Metadata;
    d1 = {
        "\u0000\u000e\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0010\u0005\u001a\u00020\u00022\u0006\u0010\u0001\u001a\u00020\u0000H\n\u00a2\u0006\u0004\u0008\u0003\u0010\u0004"
    }
    d2 = {
        "Landroidx/datastore/core/CorruptionException;",
        "ex",
        "Landroidx/datastore/preferences/core/g;",
        "invoke",
        "(Landroidx/datastore/core/CorruptionException;)Landroidx/datastore/preferences/core/g;",
        "<anonymous>"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
.end annotation


# static fields
.field public static final INSTANCE:Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;

    invoke-direct {v0}, Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;-><init>()V

    sput-object v0, Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;->INSTANCE:Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lwakotl/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke(Landroidx/datastore/core/CorruptionException;)Landroidx/datastore/preferences/core/g;
    .locals 1
    .param p1    # Landroidx/datastore/core/CorruptionException;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation

    const-string v0, "ex"

    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x21

    if-lt p1, v0, :cond_0

    .line 2
    invoke-static {}, Landroidx/appcompat/app/c0;->l()Ljava/lang/String;

    move-result-object p1

    const-string v0, "myProcessName()"

    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const/16 v0, 0x1c

    if-lt p1, v0, :cond_1

    .line 3
    invoke-static {}, Landroidx/activity/z;->i()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    goto :goto_0

    .line 4
    :cond_1
    invoke-static {}, Lcom/google/android/gms/common/util/ProcessUtils;->getMyProcessName()Ljava/lang/String;

    .line 5
    :goto_0
    new-instance p1, Landroidx/datastore/preferences/core/b;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Landroidx/datastore/preferences/core/b;-><init>(Z)V

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 6
    check-cast p1, Landroidx/datastore/core/CorruptionException;

    invoke-virtual {p0, p1}, Lcom/google/firebase/sessions/SessionDatastoreImpl$Companion$dataStore$2;->invoke(Landroidx/datastore/core/CorruptionException;)Landroidx/datastore/preferences/core/g;

    move-result-object p1

    return-object p1
.end method
