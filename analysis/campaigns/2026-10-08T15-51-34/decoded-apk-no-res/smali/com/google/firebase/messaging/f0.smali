.class public final Lcom/google/firebase/messaging/f0;
.super Landroid/os/Binder;
.source "SourceFile"


# instance fields
.field public final a:Landroidx/appcompat/widget/w0;


# direct methods
.method public constructor <init>(Landroidx/appcompat/widget/w0;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 2
    .line 3
    .line 4
    iput-object p1, p0, Lcom/google/firebase/messaging/f0;->a:Landroidx/appcompat/widget/w0;

    .line 5
    .line 6
    return-void
.end method


# virtual methods
.method public final a(Lcom/google/firebase/messaging/g0;)V
    .locals 4

    .line 1
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    invoke-static {}, Landroid/os/Process;->myUid()I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    if-ne v0, v1, :cond_0

    .line 10
    .line 11
    iget-object v0, p1, Lcom/google/firebase/messaging/g0;->a:Landroid/content/Intent;

    .line 12
    .line 13
    iget-object v1, p0, Lcom/google/firebase/messaging/f0;->a:Landroidx/appcompat/widget/w0;

    .line 14
    .line 15
    iget-object v1, v1, Landroidx/appcompat/widget/w0;->b:Ljava/lang/Object;

    .line 16
    .line 17
    check-cast v1, Lcom/google/firebase/messaging/EnhancedIntentService;

    .line 18
    .line 19
    invoke-static {v1, v0}, Lcom/google/firebase/messaging/EnhancedIntentService;->access$000(Lcom/google/firebase/messaging/EnhancedIntentService;Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    .line 20
    .line 21
    .line 22
    move-result-object v0

    .line 23
    new-instance v1, Landroidx/arch/core/executor/a;

    .line 24
    .line 25
    const/4 v2, 0x2

    .line 26
    invoke-direct {v1, v2}, Landroidx/arch/core/executor/a;-><init>(I)V

    .line 27
    .line 28
    .line 29
    new-instance v2, Lf;

    .line 30
    .line 31
    const/4 v3, 0x4

    .line 32
    invoke-direct {v2, p1, v3}, Lf;-><init>(Ljava/lang/Object;I)V

    .line 33
    .line 34
    .line 35
    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    .line 36
    .line 37
    .line 38
    return-void

    .line 39
    :cond_0
    new-instance p1, Ljava/lang/SecurityException;

    .line 40
    .line 41
    const-string v0, "Binding only allowed within app"

    .line 42
    .line 43
    invoke-direct {p1, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    .line 44
    .line 45
    .line 46
    throw p1
.end method
