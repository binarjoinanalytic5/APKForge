.class public abstract Lcom/google/firebase/sessions/u;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Landroidx/datastore/preferences/core/e;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    const-string v0, "name"

    .line 2
    .line 3
    const-string v1, "session_id"

    .line 4
    .line 5
    invoke-static {v1, v0, v1}, Landroidx/datastore/preferences/core/h;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroidx/datastore/preferences/core/e;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    sput-object v0, Lcom/google/firebase/sessions/u;->a:Landroidx/datastore/preferences/core/e;

    .line 10
    .line 11
    return-void
.end method
