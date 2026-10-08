.class final Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;
.super Lwakotl/jvm/internal/Lambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/jvm/internal/Lambda;",
        "Lwakotl/jvm/functions/Function0<",
        "Lcom/google/firebase/sessions/settings/f;",
        ">;"
    }
.end annotation

.annotation runtime Lwakotl/Metadata;
    d1 = {
        "\u0000\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0010\u0003\u001a\u00020\u0000H\n\u00a2\u0006\u0004\u0008\u0001\u0010\u0002"
    }
    d2 = {
        "Lcom/google/firebase/sessions/settings/f;",
        "invoke",
        "()Lcom/google/firebase/sessions/settings/f;",
        "<anonymous>"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
.end annotation


# instance fields
.field final synthetic $dataStore:Landroidx/datastore/core/h;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/datastore/core/h;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroidx/datastore/core/h;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/datastore/core/h;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;->$dataStore:Landroidx/datastore/core/h;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lwakotl/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Lcom/google/firebase/sessions/settings/f;
    .locals 2
    .annotation build Lorg/jetbrains/annotations/NotNull;
    .end annotation

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/settings/f;

    iget-object v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;->$dataStore:Landroidx/datastore/core/h;

    invoke-direct {v0, v1}, Lcom/google/firebase/sessions/settings/f;-><init>(Landroidx/datastore/core/h;)V

    return-object v0
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 2
    invoke-virtual {p0}, Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;->invoke()Lcom/google/firebase/sessions/settings/f;

    move-result-object v0

    return-object v0
.end method
