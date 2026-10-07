.class public final Lcom/google/firebase/sessions/g;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ldg/c;


# static fields
.field public static final a:Lcom/google/firebase/sessions/g;

.field public static final b:Ldg/b;

.field public static final c:Ldg/b;

.field public static final d:Ldg/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/g;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/g;->a:Lcom/google/firebase/sessions/g;

    .line 7
    .line 8
    const-string v0, "eventType"

    .line 9
    .line 10
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    sput-object v0, Lcom/google/firebase/sessions/g;->b:Ldg/b;

    .line 15
    .line 16
    const-string v0, "sessionData"

    .line 17
    .line 18
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 19
    .line 20
    .line 21
    move-result-object v0

    .line 22
    sput-object v0, Lcom/google/firebase/sessions/g;->c:Ldg/b;

    .line 23
    .line 24
    const-string v0, "applicationInfo"

    .line 25
    .line 26
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 27
    .line 28
    .line 29
    move-result-object v0

    .line 30
    sput-object v0, Lcom/google/firebase/sessions/g;->d:Ldg/b;

    .line 31
    .line 32
    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 2

    .line 1
    check-cast p1, Lcom/google/firebase/sessions/z;

    .line 2
    .line 3
    check-cast p2, Ldg/d;

    .line 4
    .line 5
    iget-object v0, p1, Lcom/google/firebase/sessions/z;->a:Lcom/google/firebase/sessions/EventType;

    .line 6
    .line 7
    sget-object v1, Lcom/google/firebase/sessions/g;->b:Ldg/b;

    .line 8
    .line 9
    invoke-interface {p2, v1, v0}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 10
    .line 11
    .line 12
    iget-object v0, p1, Lcom/google/firebase/sessions/z;->b:Lcom/google/firebase/sessions/e0;

    .line 13
    .line 14
    sget-object v1, Lcom/google/firebase/sessions/g;->c:Ldg/b;

    .line 15
    .line 16
    invoke-interface {p2, v1, v0}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 17
    .line 18
    .line 19
    iget-object p1, p1, Lcom/google/firebase/sessions/z;->c:Lcom/google/firebase/sessions/b;

    .line 20
    .line 21
    sget-object v0, Lcom/google/firebase/sessions/g;->d:Ldg/b;

    .line 22
    .line 23
    invoke-interface {p2, v0, p1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 24
    .line 25
    .line 26
    return-void
.end method
