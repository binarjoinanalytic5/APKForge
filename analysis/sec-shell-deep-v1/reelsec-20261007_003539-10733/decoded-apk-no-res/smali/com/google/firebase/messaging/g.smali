.class public final synthetic Lcom/google/firebase/messaging/g;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/Continuation;


# instance fields
.field public final synthetic a:Landroid/content/Context;

.field public final synthetic b:Landroid/content/Intent;

.field public final synthetic c:Z


# direct methods
.method public synthetic constructor <init>(Landroid/content/Context;Landroid/content/Intent;Z)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/messaging/g;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/google/firebase/messaging/g;->b:Landroid/content/Intent;

    iput-boolean p3, p0, Lcom/google/firebase/messaging/g;->c:Z

    return-void
.end method


# virtual methods
.method public final then(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;
    .locals 3

    .line 1
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastO()Z

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-eqz v0, :cond_1

    .line 6
    .line 7
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    .line 8
    .line 9
    .line 10
    move-result-object v0

    .line 11
    check-cast v0, Ljava/lang/Integer;

    .line 12
    .line 13
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    .line 14
    .line 15
    .line 16
    move-result v0

    .line 17
    const/16 v1, 0x192

    .line 18
    .line 19
    if-eq v0, v1, :cond_0

    .line 20
    .line 21
    goto :goto_0

    .line 22
    :cond_0
    iget-object p1, p0, Lcom/google/firebase/messaging/g;->b:Landroid/content/Intent;

    .line 23
    .line 24
    iget-boolean v0, p0, Lcom/google/firebase/messaging/g;->c:Z

    .line 25
    .line 26
    iget-object v1, p0, Lcom/google/firebase/messaging/g;->a:Landroid/content/Context;

    .line 27
    .line 28
    invoke-static {v1, p1, v0}, Lcom/google/firebase/messaging/h;->a(Landroid/content/Context;Landroid/content/Intent;Z)Lcom/google/android/gms/tasks/Task;

    .line 29
    .line 30
    .line 31
    move-result-object p1

    .line 32
    new-instance v0, Lcom/google/firebase/messaging/f;

    .line 33
    .line 34
    invoke-direct {v0}, Lcom/google/firebase/messaging/f;-><init>()V

    .line 35
    .line 36
    .line 37
    new-instance v1, Lcom/google/android/material/internal/i;

    .line 38
    .line 39
    const/4 v2, 0x2

    .line 40
    invoke-direct {v1, v2}, Lcom/google/android/material/internal/i;-><init>(I)V

    .line 41
    .line 42
    .line 43
    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/tasks/Task;->continueWith(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    .line 44
    .line 45
    .line 46
    move-result-object p1

    .line 47
    :cond_1
    :goto_0
    return-object p1
.end method
