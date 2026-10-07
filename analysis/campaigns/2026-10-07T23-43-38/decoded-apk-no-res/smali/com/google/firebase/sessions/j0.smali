.class public final Lcom/google/firebase/sessions/j0;
.super Landroid/os/Handler;
.source "SourceFile"


# instance fields
.field public a:Z

.field public b:J

.field public final c:Ljava/util/ArrayList;


# direct methods
.method public constructor <init>(Landroid/os/Looper;)V
    .locals 1

    .line 1
    const-string v0, "looper"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 7
    .line 8
    .line 9
    new-instance p1, Ljava/util/ArrayList;

    .line 10
    .line 11
    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 12
    .line 13
    .line 14
    iput-object p1, p0, Lcom/google/firebase/sessions/j0;->c:Ljava/util/ArrayList;

    .line 15
    .line 16
    return-void
.end method


# virtual methods
.method public final a(Landroid/os/Messenger;)V
    .locals 3

    .line 1
    iget-boolean v0, p0, Lcom/google/firebase/sessions/j0;->a:Z

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    if-eqz v0, :cond_1

    .line 5
    .line 6
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 7
    .line 8
    .line 9
    move-result-object v0

    .line 10
    const-class v2, Lcom/google/firebase/sessions/d0;

    .line 11
    .line 12
    invoke-virtual {v0, v2}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 13
    .line 14
    .line 15
    move-result-object v0

    .line 16
    const-string v2, "Firebase.app[SessionGenerator::class.java]"

    .line 17
    .line 18
    invoke-static {v0, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    check-cast v0, Lcom/google/firebase/sessions/d0;

    .line 22
    .line 23
    iget-object v0, v0, Lcom/google/firebase/sessions/d0;->e:Lcom/google/firebase/sessions/y;

    .line 24
    .line 25
    if-eqz v0, :cond_0

    .line 26
    .line 27
    iget-object v0, v0, Lcom/google/firebase/sessions/y;->a:Ljava/lang/String;

    .line 28
    .line 29
    invoke-virtual {p0, p1, v0}, Lcom/google/firebase/sessions/j0;->c(Landroid/os/Messenger;Ljava/lang/String;)V

    .line 30
    .line 31
    .line 32
    goto :goto_0

    .line 33
    :cond_0
    const-string p1, "currentSession"

    .line 34
    .line 35
    invoke-static {p1}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 36
    .line 37
    .line 38
    throw v1

    .line 39
    :cond_1
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 40
    .line 41
    .line 42
    move-result-object v0

    .line 43
    const-class v2, Lcom/google/firebase/sessions/r;

    .line 44
    .line 45
    invoke-virtual {v0, v2}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 46
    .line 47
    .line 48
    move-result-object v0

    .line 49
    const-string v2, "Firebase.app[SessionDatastore::class.java]"

    .line 50
    .line 51
    invoke-static {v0, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    .line 53
    .line 54
    check-cast v0, Lcom/google/firebase/sessions/r;

    .line 55
    .line 56
    check-cast v0, Lcom/google/firebase/sessions/x;

    .line 57
    .line 58
    iget-object v0, v0, Lcom/google/firebase/sessions/x;->c:Ljava/util/concurrent/atomic/AtomicReference;

    .line 59
    .line 60
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    .line 61
    .line 62
    .line 63
    move-result-object v0

    .line 64
    check-cast v0, Lcom/google/firebase/sessions/l;

    .line 65
    .line 66
    if-eqz v0, :cond_2

    .line 67
    .line 68
    iget-object v1, v0, Lcom/google/firebase/sessions/l;->a:Ljava/lang/String;

    .line 69
    .line 70
    :cond_2
    if-eqz v1, :cond_3

    .line 71
    .line 72
    invoke-virtual {p0, p1, v1}, Lcom/google/firebase/sessions/j0;->c(Landroid/os/Messenger;Ljava/lang/String;)V

    .line 73
    .line 74
    .line 75
    :cond_3
    :goto_0
    return-void
.end method

.method public final b()V
    .locals 11

    .line 1
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    const-class v1, Lcom/google/firebase/sessions/d0;

    .line 6
    .line 7
    invoke-virtual {v0, v1}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 8
    .line 9
    .line 10
    move-result-object v0

    .line 11
    const-string v2, "Firebase.app[SessionGenerator::class.java]"

    .line 12
    .line 13
    invoke-static {v0, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    .line 15
    .line 16
    check-cast v0, Lcom/google/firebase/sessions/d0;

    .line 17
    .line 18
    iget v3, v0, Lcom/google/firebase/sessions/d0;->d:I

    .line 19
    .line 20
    add-int/lit8 v3, v3, 0x1

    .line 21
    .line 22
    iput v3, v0, Lcom/google/firebase/sessions/d0;->d:I

    .line 23
    .line 24
    new-instance v10, Lcom/google/firebase/sessions/y;

    .line 25
    .line 26
    if-nez v3, :cond_0

    .line 27
    .line 28
    iget-object v3, v0, Lcom/google/firebase/sessions/d0;->c:Ljava/lang/String;

    .line 29
    .line 30
    :goto_0
    move-object v8, v3

    .line 31
    goto :goto_1

    .line 32
    :cond_0
    invoke-virtual {v0}, Lcom/google/firebase/sessions/d0;->a()Ljava/lang/String;

    .line 33
    .line 34
    .line 35
    move-result-object v3

    .line 36
    goto :goto_0

    .line 37
    :goto_1
    iget v5, v0, Lcom/google/firebase/sessions/d0;->d:I

    .line 38
    .line 39
    iget-object v3, v0, Lcom/google/firebase/sessions/d0;->a:Lcom/google/firebase/sessions/n0;

    .line 40
    .line 41
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 42
    .line 43
    .line 44
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 45
    .line 46
    .line 47
    move-result-wide v3

    .line 48
    const-wide/16 v6, 0x3e8

    .line 49
    .line 50
    mul-long/2addr v6, v3

    .line 51
    iget-object v9, v0, Lcom/google/firebase/sessions/d0;->c:Ljava/lang/String;

    .line 52
    .line 53
    move-object v4, v10

    .line 54
    invoke-direct/range {v4 .. v9}, Lcom/google/firebase/sessions/y;-><init>(IJLjava/lang/String;Ljava/lang/String;)V

    .line 55
    .line 56
    .line 57
    iput-object v10, v0, Lcom/google/firebase/sessions/d0;->e:Lcom/google/firebase/sessions/y;

    .line 58
    .line 59
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 60
    .line 61
    .line 62
    move-result-object v0

    .line 63
    const-class v3, Lcom/google/firebase/sessions/b0;

    .line 64
    .line 65
    invoke-virtual {v0, v3}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 66
    .line 67
    .line 68
    move-result-object v0

    .line 69
    const-string v3, "Firebase.app[SessionFirelogPublisher::class.java]"

    .line 70
    .line 71
    invoke-static {v0, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 72
    .line 73
    .line 74
    check-cast v0, Lcom/google/firebase/sessions/b0;

    .line 75
    .line 76
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 77
    .line 78
    .line 79
    move-result-object v3

    .line 80
    invoke-virtual {v3, v1}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 81
    .line 82
    .line 83
    move-result-object v3

    .line 84
    invoke-static {v3, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    .line 86
    .line 87
    check-cast v3, Lcom/google/firebase/sessions/d0;

    .line 88
    .line 89
    iget-object v3, v3, Lcom/google/firebase/sessions/d0;->e:Lcom/google/firebase/sessions/y;

    .line 90
    .line 91
    const-string v4, "currentSession"

    .line 92
    .line 93
    const/4 v5, 0x0

    .line 94
    if-eqz v3, :cond_3

    .line 95
    .line 96
    check-cast v0, Lcom/google/firebase/sessions/c0;

    .line 97
    .line 98
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 99
    .line 100
    .line 101
    const-string v6, "sessionDetails"

    .line 102
    .line 103
    invoke-static {v3, v6}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 104
    .line 105
    .line 106
    iget-object v6, v0, Lcom/google/firebase/sessions/c0;->e:Lwakotl/coroutines/CoroutineContext;

    .line 107
    .line 108
    invoke-static {v6}, Lkotlinx/coroutines/g0;->a(Lwakotl/coroutines/CoroutineContext;)Lmq/d;

    .line 109
    .line 110
    .line 111
    move-result-object v6

    .line 112
    new-instance v7, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;

    .line 113
    .line 114
    invoke-direct {v7, v0, v3, v5}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;-><init>(Lcom/google/firebase/sessions/c0;Lcom/google/firebase/sessions/y;Lwakotl/coroutines/Continuation;)V

    .line 115
    .line 116
    .line 117
    const/4 v0, 0x3

    .line 118
    invoke-static {v6, v5, v5, v7, v0}, Lkotlinx/coroutines/g0;->A(Lkotlinx/coroutines/e0;Lwakotl/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lwakotl/jvm/functions/Function2;I)Lkotlinx/coroutines/z1;

    .line 119
    .line 120
    .line 121
    new-instance v3, Ljava/util/ArrayList;

    .line 122
    .line 123
    iget-object v6, p0, Lcom/google/firebase/sessions/j0;->c:Ljava/util/ArrayList;

    .line 124
    .line 125
    invoke-direct {v3, v6}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 126
    .line 127
    .line 128
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 129
    .line 130
    .line 131
    move-result-object v3

    .line 132
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 133
    .line 134
    .line 135
    move-result v6

    .line 136
    if-eqz v6, :cond_1

    .line 137
    .line 138
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 139
    .line 140
    .line 141
    move-result-object v6

    .line 142
    check-cast v6, Landroid/os/Messenger;

    .line 143
    .line 144
    const-string v7, "it"

    .line 145
    .line 146
    invoke-static {v6, v7}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 147
    .line 148
    .line 149
    invoke-virtual {p0, v6}, Lcom/google/firebase/sessions/j0;->a(Landroid/os/Messenger;)V

    .line 150
    .line 151
    .line 152
    goto :goto_2

    .line 153
    :cond_1
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 154
    .line 155
    .line 156
    move-result-object v3

    .line 157
    const-class v6, Lcom/google/firebase/sessions/r;

    .line 158
    .line 159
    invoke-virtual {v3, v6}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 160
    .line 161
    .line 162
    move-result-object v3

    .line 163
    const-string v6, "Firebase.app[SessionDatastore::class.java]"

    .line 164
    .line 165
    invoke-static {v3, v6}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 166
    .line 167
    .line 168
    check-cast v3, Lcom/google/firebase/sessions/r;

    .line 169
    .line 170
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 171
    .line 172
    .line 173
    move-result-object v6

    .line 174
    invoke-virtual {v6, v1}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 175
    .line 176
    .line 177
    move-result-object v1

    .line 178
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 179
    .line 180
    .line 181
    check-cast v1, Lcom/google/firebase/sessions/d0;

    .line 182
    .line 183
    iget-object v1, v1, Lcom/google/firebase/sessions/d0;->e:Lcom/google/firebase/sessions/y;

    .line 184
    .line 185
    if-eqz v1, :cond_2

    .line 186
    .line 187
    check-cast v3, Lcom/google/firebase/sessions/x;

    .line 188
    .line 189
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 190
    .line 191
    .line 192
    iget-object v1, v1, Lcom/google/firebase/sessions/y;->a:Ljava/lang/String;

    .line 193
    .line 194
    const-string v2, "sessionId"

    .line 195
    .line 196
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 197
    .line 198
    .line 199
    iget-object v2, v3, Lcom/google/firebase/sessions/x;->b:Lwakotl/coroutines/CoroutineContext;

    .line 200
    .line 201
    invoke-static {v2}, Lkotlinx/coroutines/g0;->a(Lwakotl/coroutines/CoroutineContext;)Lmq/d;

    .line 202
    .line 203
    .line 204
    move-result-object v2

    .line 205
    new-instance v4, Lcom/google/firebase/sessions/SessionDatastoreImpl$updateSessionId$1;

    .line 206
    .line 207
    invoke-direct {v4, v3, v1, v5}, Lcom/google/firebase/sessions/SessionDatastoreImpl$updateSessionId$1;-><init>(Lcom/google/firebase/sessions/x;Ljava/lang/String;Lwakotl/coroutines/Continuation;)V

    .line 208
    .line 209
    .line 210
    invoke-static {v2, v5, v5, v4, v0}, Lkotlinx/coroutines/g0;->A(Lkotlinx/coroutines/e0;Lwakotl/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lwakotl/jvm/functions/Function2;I)Lkotlinx/coroutines/z1;

    .line 211
    .line 212
    .line 213
    return-void

    .line 214
    :cond_2
    invoke-static {v4}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 215
    .line 216
    .line 217
    throw v5

    .line 218
    :cond_3
    invoke-static {v4}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 219
    .line 220
    .line 221
    throw v5
.end method

.method public final c(Landroid/os/Messenger;Ljava/lang/String;)V
    .locals 3

    .line 1
    :try_start_0
    new-instance v0, Landroid/os/Bundle;

    .line 2
    .line 3
    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 4
    .line 5
    .line 6
    const-string v1, "SessionUpdateExtra"

    .line 7
    .line 8
    invoke-virtual {v0, v1, p2}, Landroid/os/BaseBundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    const/4 p2, 0x0

    .line 12
    const/4 v1, 0x3

    .line 13
    const/4 v2, 0x0

    .line 14
    invoke-static {p2, v1, v2, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;III)Landroid/os/Message;

    .line 15
    .line 16
    .line 17
    move-result-object p2

    .line 18
    invoke-virtual {p2, v0}, Landroid/os/Message;->setData(Landroid/os/Bundle;)V

    .line 19
    .line 20
    .line 21
    invoke-virtual {p1, p2}, Landroid/os/Messenger;->send(Landroid/os/Message;)V
    :try_end_0
    .catch Landroid/os/DeadObjectException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 22
    .line 23
    .line 24
    goto :goto_0

    .line 25
    :catch_0
    invoke-static {p1}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 26
    .line 27
    .line 28
    goto :goto_0

    .line 29
    :catch_1
    invoke-static {p1}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 30
    .line 31
    .line 32
    iget-object p2, p0, Lcom/google/firebase/sessions/j0;->c:Ljava/util/ArrayList;

    .line 33
    .line 34
    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 35
    .line 36
    .line 37
    :goto_0
    return-void
.end method

.method public final handleMessage(Landroid/os/Message;)V
    .locals 9

    .line 1
    const/4 v0, 0x0

    .line 2
    const-string v1, "msg"

    .line 3
    .line 4
    invoke-static {p1, v1}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 5
    .line 6
    .line 7
    iget-wide v1, p0, Lcom/google/firebase/sessions/j0;->b:J

    .line 8
    .line 9
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 10
    .line 11
    .line 12
    move-result-wide v3

    .line 13
    cmp-long v1, v1, v3

    .line 14
    .line 15
    if-lez v1, :cond_0

    .line 16
    .line 17
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 18
    .line 19
    .line 20
    return-void

    .line 21
    :cond_0
    iget v1, p1, Landroid/os/Message;->what:I

    .line 22
    .line 23
    const/4 v2, 0x1

    .line 24
    if-eq v1, v2, :cond_3

    .line 25
    .line 26
    const/4 v0, 0x2

    .line 27
    if-eq v1, v0, :cond_2

    .line 28
    .line 29
    const/4 v0, 0x4

    .line 30
    if-eq v1, v0, :cond_1

    .line 31
    .line 32
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    .line 33
    .line 34
    .line 35
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 36
    .line 37
    .line 38
    goto/16 :goto_3

    .line 39
    .line 40
    :cond_1
    iget-object v0, p0, Lcom/google/firebase/sessions/j0;->c:Ljava/util/ArrayList;

    .line 41
    .line 42
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    .line 43
    .line 44
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 45
    .line 46
    .line 47
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    .line 48
    .line 49
    const-string v2, "msg.replyTo"

    .line 50
    .line 51
    invoke-static {v1, v2}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    .line 53
    .line 54
    invoke-virtual {p0, v1}, Lcom/google/firebase/sessions/j0;->a(Landroid/os/Messenger;)V

    .line 55
    .line 56
    .line 57
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    .line 58
    .line 59
    invoke-static {v1}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 60
    .line 61
    .line 62
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 63
    .line 64
    .line 65
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 66
    .line 67
    .line 68
    goto/16 :goto_3

    .line 69
    .line 70
    :cond_2
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 71
    .line 72
    .line 73
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 74
    .line 75
    .line 76
    move-result-wide v0

    .line 77
    iput-wide v0, p0, Lcom/google/firebase/sessions/j0;->b:J

    .line 78
    .line 79
    goto/16 :goto_3

    .line 80
    .line 81
    :cond_3
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 82
    .line 83
    .line 84
    iget-boolean v1, p0, Lcom/google/firebase/sessions/j0;->a:Z

    .line 85
    .line 86
    if-nez v1, :cond_4

    .line 87
    .line 88
    iput-boolean v2, p0, Lcom/google/firebase/sessions/j0;->a:Z

    .line 89
    .line 90
    invoke-virtual {p0}, Lcom/google/firebase/sessions/j0;->b()V

    .line 91
    .line 92
    .line 93
    goto/16 :goto_2

    .line 94
    .line 95
    :cond_4
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 96
    .line 97
    .line 98
    move-result-wide v1

    .line 99
    iget-wide v3, p0, Lcom/google/firebase/sessions/j0;->b:J

    .line 100
    .line 101
    sub-long/2addr v1, v3

    .line 102
    sget-object v3, Lcom/google/firebase/sessions/settings/e;->c:Lcom/google/firebase/sessions/settings/d;

    .line 103
    .line 104
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 105
    .line 106
    .line 107
    invoke-static {}, Landroidx/work/impl/model/f;->k()Lef/h;

    .line 108
    .line 109
    .line 110
    move-result-object v3

    .line 111
    const-class v4, Lcom/google/firebase/sessions/settings/e;

    .line 112
    .line 113
    invoke-virtual {v3, v4}, Lef/h;->b(Ljava/lang/Class;)Ljava/lang/Object;

    .line 114
    .line 115
    .line 116
    move-result-object v3

    .line 117
    const-string v4, "Firebase.app[SessionsSettings::class.java]"

    .line 118
    .line 119
    invoke-static {v3, v4}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 120
    .line 121
    .line 122
    check-cast v3, Lcom/google/firebase/sessions/settings/e;

    .line 123
    .line 124
    iget-object v4, v3, Lcom/google/firebase/sessions/settings/e;->a:Lcom/google/firebase/messaging/p;

    .line 125
    .line 126
    iget-object v4, v4, Lcom/google/firebase/messaging/p;->a:Landroid/os/Bundle;

    .line 127
    .line 128
    const-string v5, "firebase_sessions_sessions_restart_timeout"

    .line 129
    .line 130
    invoke-virtual {v4, v5}, Landroid/os/BaseBundle;->containsKey(Ljava/lang/String;)Z

    .line 131
    .line 132
    .line 133
    move-result v6

    .line 134
    if-eqz v6, :cond_5

    .line 135
    .line 136
    invoke-virtual {v4, v5}, Landroid/os/BaseBundle;->getInt(Ljava/lang/String;)I

    .line 137
    .line 138
    .line 139
    move-result v4

    .line 140
    sget-object v5, Lwakotl/time/DurationUnit;->SECONDS:Lwakotl/time/DurationUnit;

    .line 141
    .line 142
    invoke-static {v4, v5}, Lcom/bumptech/glide/d;->v0(ILwakotl/time/DurationUnit;)J

    .line 143
    .line 144
    .line 145
    move-result-wide v4

    .line 146
    new-instance v6, Liq/d;

    .line 147
    .line 148
    invoke-direct {v6, v4, v5}, Liq/d;-><init>(J)V

    .line 149
    .line 150
    .line 151
    goto :goto_0

    .line 152
    :cond_5
    move-object v6, v0

    .line 153
    :goto_0
    const-wide/16 v4, 0x0

    .line 154
    .line 155
    if-eqz v6, :cond_6

    .line 156
    .line 157
    sget-object v7, Liq/d;->b:Liq/c;

    .line 158
    .line 159
    iget-wide v6, v6, Liq/d;->a:J

    .line 160
    .line 161
    cmp-long v8, v6, v4

    .line 162
    .line 163
    if-lez v8, :cond_6

    .line 164
    .line 165
    invoke-static {v6, v7}, Liq/d;->h(J)Z

    .line 166
    .line 167
    .line 168
    move-result v8

    .line 169
    if-nez v8, :cond_6

    .line 170
    .line 171
    goto :goto_1

    .line 172
    :cond_6
    iget-object v3, v3, Lcom/google/firebase/sessions/settings/e;->b:Lcom/google/firebase/sessions/settings/a;

    .line 173
    .line 174
    invoke-virtual {v3}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 175
    .line 176
    .line 177
    move-result-object v3

    .line 178
    iget-object v3, v3, Lcom/google/firebase/sessions/settings/f;->b:Lcom/google/firebase/sessions/settings/c;

    .line 179
    .line 180
    if-eqz v3, :cond_a

    .line 181
    .line 182
    iget-object v3, v3, Lcom/google/firebase/sessions/settings/c;->c:Ljava/lang/Integer;

    .line 183
    .line 184
    if-eqz v3, :cond_7

    .line 185
    .line 186
    sget-object v0, Liq/d;->b:Liq/c;

    .line 187
    .line 188
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    .line 189
    .line 190
    .line 191
    move-result v0

    .line 192
    sget-object v3, Lwakotl/time/DurationUnit;->SECONDS:Lwakotl/time/DurationUnit;

    .line 193
    .line 194
    invoke-static {v0, v3}, Lcom/bumptech/glide/d;->v0(ILwakotl/time/DurationUnit;)J

    .line 195
    .line 196
    .line 197
    move-result-wide v6

    .line 198
    new-instance v0, Liq/d;

    .line 199
    .line 200
    invoke-direct {v0, v6, v7}, Liq/d;-><init>(J)V

    .line 201
    .line 202
    .line 203
    :cond_7
    if-eqz v0, :cond_8

    .line 204
    .line 205
    sget-object v3, Liq/d;->b:Liq/c;

    .line 206
    .line 207
    iget-wide v6, v0, Liq/d;->a:J

    .line 208
    .line 209
    cmp-long v0, v6, v4

    .line 210
    .line 211
    if-lez v0, :cond_8

    .line 212
    .line 213
    invoke-static {v6, v7}, Liq/d;->h(J)Z

    .line 214
    .line 215
    .line 216
    move-result v0

    .line 217
    if-nez v0, :cond_8

    .line 218
    .line 219
    goto :goto_1

    .line 220
    :cond_8
    sget-object v0, Liq/d;->b:Liq/c;

    .line 221
    .line 222
    const/16 v0, 0x1e

    .line 223
    .line 224
    sget-object v3, Lwakotl/time/DurationUnit;->MINUTES:Lwakotl/time/DurationUnit;

    .line 225
    .line 226
    invoke-static {v0, v3}, Lcom/bumptech/glide/d;->v0(ILwakotl/time/DurationUnit;)J

    .line 227
    .line 228
    .line 229
    move-result-wide v6

    .line 230
    :goto_1
    invoke-static {v6, v7}, Liq/d;->f(J)J

    .line 231
    .line 232
    .line 233
    move-result-wide v3

    .line 234
    cmp-long v0, v1, v3

    .line 235
    .line 236
    if-lez v0, :cond_9

    .line 237
    .line 238
    invoke-virtual {p0}, Lcom/google/firebase/sessions/j0;->b()V

    .line 239
    .line 240
    .line 241
    :cond_9
    :goto_2
    invoke-virtual {p1}, Landroid/os/Message;->getWhen()J

    .line 242
    .line 243
    .line 244
    move-result-wide v0

    .line 245
    iput-wide v0, p0, Lcom/google/firebase/sessions/j0;->b:J

    .line 246
    .line 247
    :goto_3
    return-void

    .line 248
    :cond_a
    const-string p1, "sessionConfigs"

    .line 249
    .line 250
    invoke-static {p1}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 251
    .line 252
    .line 253
    throw v0
.end method
