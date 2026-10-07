.class public final Lcom/google/firebase/sessions/c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ldg/c;


# static fields
.field public static final a:Lcom/google/firebase/sessions/c;

.field public static final b:Ldg/b;

.field public static final c:Ldg/b;

.field public static final d:Ldg/b;

.field public static final e:Ldg/b;

.field public static final f:Ldg/b;

.field public static final g:Ldg/b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/google/firebase/sessions/c;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/sessions/c;->a:Lcom/google/firebase/sessions/c;

    .line 7
    .line 8
    const-string v0, "packageName"

    .line 9
    .line 10
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    sput-object v0, Lcom/google/firebase/sessions/c;->b:Ldg/b;

    .line 15
    .line 16
    const-string v0, "versionName"

    .line 17
    .line 18
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 19
    .line 20
    .line 21
    move-result-object v0

    .line 22
    sput-object v0, Lcom/google/firebase/sessions/c;->c:Ldg/b;

    .line 23
    .line 24
    const-string v0, "appBuildVersion"

    .line 25
    .line 26
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 27
    .line 28
    .line 29
    move-result-object v0

    .line 30
    sput-object v0, Lcom/google/firebase/sessions/c;->d:Ldg/b;

    .line 31
    .line 32
    const-string v0, "deviceManufacturer"

    .line 33
    .line 34
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    sput-object v0, Lcom/google/firebase/sessions/c;->e:Ldg/b;

    .line 39
    .line 40
    const-string v0, "currentProcessDetails"

    .line 41
    .line 42
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 43
    .line 44
    .line 45
    move-result-object v0

    .line 46
    sput-object v0, Lcom/google/firebase/sessions/c;->f:Ldg/b;

    .line 47
    .line 48
    const-string v0, "appProcessDetails"

    .line 49
    .line 50
    invoke-static {v0}, Ldg/b;->a(Ljava/lang/String;)Ldg/b;

    .line 51
    .line 52
    .line 53
    move-result-object v0

    .line 54
    sput-object v0, Lcom/google/firebase/sessions/c;->g:Ldg/b;

    .line 55
    .line 56
    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 2

    .line 1
    check-cast p1, Lcom/google/firebase/sessions/a;

    .line 2
    .line 3
    check-cast p2, Ldg/d;

    .line 4
    .line 5
    iget-object v0, p1, Lcom/google/firebase/sessions/a;->a:Ljava/lang/String;

    .line 6
    .line 7
    sget-object v1, Lcom/google/firebase/sessions/c;->b:Ldg/b;

    .line 8
    .line 9
    invoke-interface {p2, v1, v0}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 10
    .line 11
    .line 12
    sget-object v0, Lcom/google/firebase/sessions/c;->c:Ldg/b;

    .line 13
    .line 14
    iget-object v1, p1, Lcom/google/firebase/sessions/a;->b:Ljava/lang/String;

    .line 15
    .line 16
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 17
    .line 18
    .line 19
    sget-object v0, Lcom/google/firebase/sessions/c;->d:Ldg/b;

    .line 20
    .line 21
    iget-object v1, p1, Lcom/google/firebase/sessions/a;->c:Ljava/lang/String;

    .line 22
    .line 23
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 24
    .line 25
    .line 26
    sget-object v0, Lcom/google/firebase/sessions/c;->e:Ldg/b;

    .line 27
    .line 28
    iget-object v1, p1, Lcom/google/firebase/sessions/a;->d:Ljava/lang/String;

    .line 29
    .line 30
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 31
    .line 32
    .line 33
    iget-object v0, p1, Lcom/google/firebase/sessions/a;->e:Lcom/google/firebase/sessions/p;

    .line 34
    .line 35
    sget-object v1, Lcom/google/firebase/sessions/c;->f:Ldg/b;

    .line 36
    .line 37
    invoke-interface {p2, v1, v0}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 38
    .line 39
    .line 40
    iget-object p1, p1, Lcom/google/firebase/sessions/a;->f:Ljava/util/ArrayList;

    .line 41
    .line 42
    sget-object v0, Lcom/google/firebase/sessions/c;->g:Ldg/b;

    .line 43
    .line 44
    invoke-interface {p2, v0, p1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 45
    .line 46
    .line 47
    return-void
.end method
