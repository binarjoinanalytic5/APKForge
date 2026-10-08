.class final Lcom/google/firebase/sessions/FirebaseSessions$1;
.super Lwakotl/coroutines/jvm/internal/SuspendLambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/coroutines/jvm/internal/SuspendLambda;",
        "Lwakotl/jvm/functions/Function2<",
        "Lkotlinx/coroutines/e0;",
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
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\u008a@\u00a2\u0006\u0004\u0008\u0002\u0010\u0003"
    }
    d2 = {
        "Lkotlinx/coroutines/e0;",
        "",
        "<anonymous>",
        "(Lkotlinx/coroutines/e0;)V"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
.end annotation

.annotation runtime Lwakotl/coroutines/jvm/internal/DebugMetadata;
    c = "com.google.firebase.sessions.FirebaseSessions$1"
    f = "FirebaseSessions.kt"
    i = {}
    l = {
        0x2d,
        0x31
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $backgroundDispatcher:Lwakotl/coroutines/CoroutineContext;

.field final synthetic $lifecycleServiceBinder:Lcom/google/firebase/sessions/k0;

.field label:I

.field final synthetic this$0:Lcom/google/firebase/sessions/k;


# direct methods
.method public constructor <init>(Lcom/google/firebase/sessions/k;Lwakotl/coroutines/CoroutineContext;Lcom/google/firebase/sessions/k0;Lwakotl/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/sessions/k;",
            "Lwakotl/coroutines/CoroutineContext;",
            "Lcom/google/firebase/sessions/k0;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/sessions/FirebaseSessions$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->this$0:Lcom/google/firebase/sessions/k;

    iput-object p2, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$backgroundDispatcher:Lwakotl/coroutines/CoroutineContext;

    iput-object p3, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$lifecycleServiceBinder:Lcom/google/firebase/sessions/k0;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p4}, Lwakotl/coroutines/jvm/internal/SuspendLambda;-><init>(ILwakotl/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;
    .locals 3
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

    new-instance p1, Lcom/google/firebase/sessions/FirebaseSessions$1;

    iget-object v0, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->this$0:Lcom/google/firebase/sessions/k;

    iget-object v1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$backgroundDispatcher:Lwakotl/coroutines/CoroutineContext;

    iget-object v2, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$lifecycleServiceBinder:Lcom/google/firebase/sessions/k0;

    invoke-direct {p1, v0, v1, v2, p2}, Lcom/google/firebase/sessions/FirebaseSessions$1;-><init>(Lcom/google/firebase/sessions/k;Lwakotl/coroutines/CoroutineContext;Lcom/google/firebase/sessions/k0;Lwakotl/coroutines/Continuation;)V

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 1
    check-cast p1, Lkotlinx/coroutines/e0;

    check-cast p2, Lwakotl/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/FirebaseSessions$1;->invoke(Lkotlinx/coroutines/e0;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invoke(Lkotlinx/coroutines/e0;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .param p1    # Lkotlinx/coroutines/e0;
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
            "Lkotlinx/coroutines/e0;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lwakotl/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 2
    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/FirebaseSessions$1;->create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/sessions/FirebaseSessions$1;

    sget-object p2, Lwakotl/Unit;->a:Lwakotl/Unit;

    invoke-virtual {p1, p2}, Lcom/google/firebase/sessions/FirebaseSessions$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6
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
    move-result-object v0

    .line 5
    iget v1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->label:I

    .line 6
    .line 7
    const/4 v2, 0x1

    .line 8
    const/4 v3, 0x2

    .line 9
    if-eqz v1, :cond_2

    .line 10
    .line 11
    if-eq v1, v2, :cond_1

    .line 12
    .line 13
    if-ne v1, v3, :cond_0

    .line 14
    .line 15
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 16
    .line 17
    .line 18
    goto :goto_1

    .line 19
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    .line 20
    .line 21
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 22
    .line 23
    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 24
    .line 25
    .line 26
    throw p1

    .line 27
    :cond_1
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 28
    .line 29
    .line 30
    goto :goto_0

    .line 31
    :cond_2
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 32
    .line 33
    .line 34
    sget-object p1, Lcom/google/firebase/sessions/api/b;->a:Lcom/google/firebase/sessions/api/b;

    .line 35
    .line 36
    iput v2, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->label:I

    .line 37
    .line 38
    invoke-virtual {p1, p0}, Lcom/google/firebase/sessions/api/b;->b(Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 39
    .line 40
    .line 41
    move-result-object p1

    .line 42
    if-ne p1, v0, :cond_3

    .line 43
    .line 44
    return-object v0

    .line 45
    :cond_3
    :goto_0
    check-cast p1, Ljava/util/Map;

    .line 46
    .line 47
    invoke-interface {p1}, Ljava/util/Map;->values()Ljava/util/Collection;

    .line 48
    .line 49
    .line 50
    move-result-object p1

    .line 51
    check-cast p1, Ljava/lang/Iterable;

    .line 52
    .line 53
    instance-of v1, p1, Ljava/util/Collection;

    .line 54
    .line 55
    if-eqz v1, :cond_4

    .line 56
    .line 57
    move-object v1, p1

    .line 58
    check-cast v1, Ljava/util/Collection;

    .line 59
    .line 60
    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    .line 61
    .line 62
    .line 63
    move-result v1

    .line 64
    if-eqz v1, :cond_4

    .line 65
    .line 66
    goto/16 :goto_4

    .line 67
    .line 68
    :cond_4
    invoke-interface {p1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 69
    .line 70
    .line 71
    move-result-object p1

    .line 72
    :cond_5
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    .line 73
    .line 74
    .line 75
    move-result v1

    .line 76
    if-eqz v1, :cond_c

    .line 77
    .line 78
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 79
    .line 80
    .line 81
    move-result-object v1

    .line 82
    check-cast v1, Lpf/j;

    .line 83
    .line 84
    iget-object v1, v1, Lpf/j;->a:Lpf/s;

    .line 85
    .line 86
    invoke-virtual {v1}, Lpf/s;->b()Z

    .line 87
    .line 88
    .line 89
    move-result v1

    .line 90
    if-eqz v1, :cond_5

    .line 91
    .line 92
    iget-object p1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->this$0:Lcom/google/firebase/sessions/k;

    .line 93
    .line 94
    iget-object p1, p1, Lcom/google/firebase/sessions/k;->b:Lcom/google/firebase/sessions/settings/e;

    .line 95
    .line 96
    iput v3, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->label:I

    .line 97
    .line 98
    invoke-virtual {p1, p0}, Lcom/google/firebase/sessions/settings/e;->b(Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 99
    .line 100
    .line 101
    move-result-object p1

    .line 102
    if-ne p1, v0, :cond_6

    .line 103
    .line 104
    return-object v0

    .line 105
    :cond_6
    :goto_1
    iget-object p1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->this$0:Lcom/google/firebase/sessions/k;

    .line 106
    .line 107
    iget-object p1, p1, Lcom/google/firebase/sessions/k;->b:Lcom/google/firebase/sessions/settings/e;

    .line 108
    .line 109
    iget-object v0, p1, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 110
    .line 111
    invoke-virtual {v0}, Lcom/google/firebase/messaging/p;->h()Ljava/lang/Boolean;

    .line 112
    .line 113
    .line 114
    move-result-object v0

    .line 115
    if-eqz v0, :cond_7

    .line 116
    .line 117
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    .line 118
    .line 119
    .line 120
    move-result p1

    .line 121
    goto :goto_2

    .line 122
    :cond_7
    iget-object p1, p1, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 123
    .line 124
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->a()Ljava/lang/Boolean;

    .line 125
    .line 126
    .line 127
    move-result-object p1

    .line 128
    if-eqz p1, :cond_8

    .line 129
    .line 130
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    .line 131
    .line 132
    .line 133
    move-result p1

    .line 134
    goto :goto_2

    .line 135
    :cond_8
    move p1, v2

    .line 136
    :goto_2
    if-nez p1, :cond_9

    .line 137
    .line 138
    goto/16 :goto_4

    .line 139
    .line 140
    :cond_9
    new-instance p1, Lcom/google/firebase/sessions/i0;

    .line 141
    .line 142
    iget-object v0, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$backgroundDispatcher:Lwakotl/coroutines/CoroutineContext;

    .line 143
    .line 144
    invoke-direct {p1, v0}, Lcom/google/firebase/sessions/i0;-><init>(Lwakotl/coroutines/CoroutineContext;)V

    .line 145
    .line 146
    .line 147
    iget-object v1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->$lifecycleServiceBinder:Lcom/google/firebase/sessions/k0;

    .line 148
    .line 149
    const-string v3, "sessionLifecycleServiceBinder"

    .line 150
    .line 151
    invoke-static {v1, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 152
    .line 153
    .line 154
    new-instance v3, Landroid/os/Messenger;

    .line 155
    .line 156
    new-instance v4, Lcom/google/firebase/sessions/f0;

    .line 157
    .line 158
    invoke-direct {v4, v0}, Lcom/google/firebase/sessions/f0;-><init>(Lwakotl/coroutines/CoroutineContext;)V

    .line 159
    .line 160
    .line 161
    invoke-direct {v3, v4}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    .line 162
    .line 163
    .line 164
    check-cast v1, Lcom/google/firebase/sessions/l0;

    .line 165
    .line 166
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 167
    .line 168
    .line 169
    const-string v0, "callback"

    .line 170
    .line 171
    invoke-static {v3, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 172
    .line 173
    .line 174
    const-string v0, "serviceConnection"

    .line 175
    .line 176
    iget-object v4, p1, Lcom/google/firebase/sessions/i0;->d:Lcom/google/firebase/sessions/h0;

    .line 177
    .line 178
    invoke-static {v4, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 179
    .line 180
    .line 181
    iget-object v0, v1, Lcom/google/firebase/sessions/l0;->a:Lef/h;

    .line 182
    .line 183
    invoke-virtual {v0}, Lef/h;->a()V

    .line 184
    .line 185
    .line 186
    iget-object v0, v0, Lef/h;->a:Landroid/content/Context;

    .line 187
    .line 188
    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    .line 189
    .line 190
    .line 191
    move-result-object v0

    .line 192
    const-string v1, "firebaseApp.applicationContext.applicationContext"

    .line 193
    .line 194
    invoke-static {v0, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 195
    .line 196
    .line 197
    new-instance v1, Landroid/content/Intent;

    .line 198
    .line 199
    const-class v5, Lcom/google/firebase/sessions/SessionLifecycleService;

    .line 200
    .line 201
    invoke-direct {v1, v0, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 202
    .line 203
    .line 204
    invoke-static {}, Landroid/os/Process;->myPid()I

    .line 205
    .line 206
    .line 207
    move-result v5

    .line 208
    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 209
    .line 210
    .line 211
    move-result-object v5

    .line 212
    invoke-virtual {v1, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 213
    .line 214
    .line 215
    const-string v5, "ClientCallbackMessenger"

    .line 216
    .line 217
    invoke-virtual {v1, v5, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 218
    .line 219
    .line 220
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    .line 221
    .line 222
    .line 223
    move-result-object v3

    .line 224
    invoke-virtual {v1, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 225
    .line 226
    .line 227
    const/16 v3, 0x41

    .line 228
    .line 229
    const/4 v5, 0x0

    .line 230
    :try_start_0
    invoke-virtual {v0, v1, v4, v3}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    .line 231
    .line 232
    .line 233
    move-result v1
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 234
    goto :goto_3

    .line 235
    :catch_0
    move v1, v5

    .line 236
    :goto_3
    if-nez v1, :cond_a

    .line 237
    .line 238
    :try_start_1
    invoke-virtual {v0, v4}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    .line 239
    .line 240
    .line 241
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1

    .line 242
    .line 243
    :catch_1
    const-string v0, "LifecycleServiceBinder"

    .line 244
    .line 245
    const-string v1, "Session lifecycle service binding failed."

    .line 246
    .line 247
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 248
    .line 249
    .line 250
    :cond_a
    sput-object p1, Lcom/google/firebase/sessions/m0;->c:Lcom/google/firebase/sessions/i0;

    .line 251
    .line 252
    sget-boolean v0, Lcom/google/firebase/sessions/m0;->b:Z

    .line 253
    .line 254
    if-eqz v0, :cond_b

    .line 255
    .line 256
    sput-boolean v5, Lcom/google/firebase/sessions/m0;->b:Z

    .line 257
    .line 258
    invoke-virtual {p1, v2}, Lcom/google/firebase/sessions/i0;->b(I)V

    .line 259
    .line 260
    .line 261
    :cond_b
    iget-object p1, p0, Lcom/google/firebase/sessions/FirebaseSessions$1;->this$0:Lcom/google/firebase/sessions/k;

    .line 262
    .line 263
    iget-object p1, p1, Lcom/google/firebase/sessions/k;->a:Lef/h;

    .line 264
    .line 265
    new-instance v0, Landroidx/core/view/h;

    .line 266
    .line 267
    const/16 v1, 0x10

    .line 268
    .line 269
    invoke-direct {v0, v1}, Landroidx/core/view/h;-><init>(I)V

    .line 270
    .line 271
    .line 272
    invoke-virtual {p1}, Lef/h;->a()V

    .line 273
    .line 274
    .line 275
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 276
    .line 277
    .line 278
    iget-object p1, p1, Lef/h;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 279
    .line 280
    invoke-virtual {p1, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 281
    .line 282
    .line 283
    :cond_c
    :goto_4
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 284
    .line 285
    return-object p1
.end method
