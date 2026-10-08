.class public final Lcom/google/firebase/sessions/j;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lkg/b;


# direct methods
.method public constructor <init>(Lkg/b;)V
    .locals 1

    .line 1
    const-string v0, "transportFactoryProvider"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    .line 8
    .line 9
    iput-object p1, p0, Lcom/google/firebase/sessions/j;->a:Lkg/b;

    .line 10
    .line 11
    return-void
.end method


# virtual methods
.method public final a(Lcom/google/firebase/sessions/z;)V
    .locals 4

    .line 1
    const-string v0, "sessionEvent"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    iget-object v0, p0, Lcom/google/firebase/sessions/j;->a:Lkg/b;

    .line 7
    .line 8
    invoke-interface {v0}, Lkg/b;->get()Ljava/lang/Object;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    check-cast v0, Leb/f;

    .line 13
    .line 14
    new-instance v1, Leb/c;

    .line 15
    .line 16
    const-string v2, "json"

    .line 17
    .line 18
    invoke-direct {v1, v2}, Leb/c;-><init>(Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    new-instance v2, Lf;

    .line 22
    .line 23
    const/4 v3, 0x6

    .line 24
    invoke-direct {v2, p0, v3}, Lf;-><init>(Ljava/lang/Object;I)V

    .line 25
    .line 26
    .line 27
    check-cast v0, Lhb/p;

    .line 28
    .line 29
    const-string v3, "FIREBASE_APPQUALITY_SESSION"

    .line 30
    .line 31
    invoke-virtual {v0, v3, v1, v2}, Lhb/p;->a(Ljava/lang/String;Leb/c;Leb/e;)Lcom/google/firebase/messaging/v;

    .line 32
    .line 33
    .line 34
    move-result-object v0

    .line 35
    new-instance v1, Leb/a;

    .line 36
    .line 37
    sget-object v2, Lcom/google/android/datatransport/Priority;->DEFAULT:Lcom/google/android/datatransport/Priority;

    .line 38
    .line 39
    const/4 v3, 0x0

    .line 40
    invoke-direct {v1, p1, v2, v3}, Leb/a;-><init>(Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Leb/b;)V

    .line 41
    .line 42
    .line 43
    new-instance p1, Lef/i;

    .line 44
    .line 45
    const/4 v2, 0x1

    .line 46
    invoke-direct {p1, v2}, Lef/i;-><init>(I)V

    .line 47
    .line 48
    .line 49
    invoke-virtual {v0, v1, p1}, Lcom/google/firebase/messaging/v;->n(Leb/a;Leb/g;)V

    .line 50
    .line 51
    .line 52
    return-void
.end method
