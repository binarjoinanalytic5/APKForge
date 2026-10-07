.class public final synthetic Lcom/google/firebase/messaging/l;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/OnSuccessListener;


# instance fields
.field public final synthetic a:I

.field public final synthetic b:Lcom/google/firebase/messaging/FirebaseMessaging;


# direct methods
.method public synthetic constructor <init>(Lcom/google/firebase/messaging/FirebaseMessaging;I)V
    .locals 0

    .line 1
    iput p2, p0, Lcom/google/firebase/messaging/l;->a:I

    iput-object p1, p0, Lcom/google/firebase/messaging/l;->b:Lcom/google/firebase/messaging/FirebaseMessaging;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onSuccess(Ljava/lang/Object;)V
    .locals 3

    .line 1
    iget v0, p0, Lcom/google/firebase/messaging/l;->a:I

    .line 2
    .line 3
    packed-switch v0, :pswitch_data_0

    .line 4
    .line 5
    .line 6
    check-cast p1, Lcom/google/android/gms/cloudmessaging/CloudMessage;

    .line 7
    .line 8
    sget-object v0, Lcom/google/firebase/messaging/FirebaseMessaging;->k:Lcom/facebook/f;

    .line 9
    .line 10
    iget-object v0, p0, Lcom/google/firebase/messaging/l;->b:Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 11
    .line 12
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 13
    .line 14
    .line 15
    if-eqz p1, :cond_0

    .line 16
    .line 17
    invoke-virtual {p1}, Lcom/google/android/gms/cloudmessaging/CloudMessage;->getIntent()Landroid/content/Intent;

    .line 18
    .line 19
    .line 20
    move-result-object p1

    .line 21
    invoke-static {p1}, Lcom/bumptech/glide/e;->d0(Landroid/content/Intent;)V

    .line 22
    .line 23
    .line 24
    iget-object p1, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->c:Landroidx/appcompat/widget/w;

    .line 25
    .line 26
    iget-object p1, p1, Landroidx/appcompat/widget/w;->c:Ljava/lang/Object;

    .line 27
    .line 28
    check-cast p1, Lcom/google/android/gms/cloudmessaging/Rpc;

    .line 29
    .line 30
    invoke-virtual {p1}, Lcom/google/android/gms/cloudmessaging/Rpc;->getProxiedNotificationData()Lcom/google/android/gms/tasks/Task;

    .line 31
    .line 32
    .line 33
    move-result-object p1

    .line 34
    new-instance v1, Lcom/google/firebase/messaging/l;

    .line 35
    .line 36
    const/4 v2, 0x1

    .line 37
    invoke-direct {v1, v0, v2}, Lcom/google/firebase/messaging/l;-><init>(Lcom/google/firebase/messaging/FirebaseMessaging;I)V

    .line 38
    .line 39
    .line 40
    iget-object v0, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->f:Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    .line 41
    .line 42
    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    .line 43
    .line 44
    .line 45
    :cond_0
    return-void

    .line 46
    :pswitch_0
    iget-object v0, p0, Lcom/google/firebase/messaging/l;->b:Lcom/google/firebase/messaging/FirebaseMessaging;

    .line 47
    .line 48
    check-cast p1, Lcom/google/firebase/messaging/b0;

    .line 49
    .line 50
    iget-object v0, v0, Lcom/google/firebase/messaging/FirebaseMessaging;->e:Lb6/j;

    .line 51
    .line 52
    invoke-virtual {v0}, Lb6/j;->f()Z

    .line 53
    .line 54
    .line 55
    move-result v0

    .line 56
    if-eqz v0, :cond_1

    .line 57
    .line 58
    iget-object v0, p1, Lcom/google/firebase/messaging/b0;->h:Lcom/google/firebase/messaging/z;

    .line 59
    .line 60
    invoke-virtual {v0}, Lcom/google/firebase/messaging/z;->a()Lcom/google/firebase/messaging/y;

    .line 61
    .line 62
    .line 63
    move-result-object v0

    .line 64
    if-eqz v0, :cond_1

    .line 65
    .line 66
    monitor-enter p1

    .line 67
    :try_start_0
    iget-boolean v0, p1, Lcom/google/firebase/messaging/b0;->g:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 68
    .line 69
    monitor-exit p1

    .line 70
    if-nez v0, :cond_1

    .line 71
    .line 72
    const-wide/16 v0, 0x0

    .line 73
    .line 74
    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/messaging/b0;->g(J)V

    .line 75
    .line 76
    .line 77
    goto :goto_0

    .line 78
    :catchall_0
    move-exception v0

    .line 79
    :try_start_1
    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 80
    throw v0

    .line 81
    :cond_1
    :goto_0
    return-void

    .line 82
    nop

    .line 83
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
