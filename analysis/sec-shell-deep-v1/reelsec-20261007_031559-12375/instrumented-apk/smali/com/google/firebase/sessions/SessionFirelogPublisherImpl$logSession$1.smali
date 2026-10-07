.class final Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;
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
    c = "com.google.firebase.sessions.SessionFirelogPublisherImpl$logSession$1"
    f = "SessionFirelogPublisher.kt"
    i = {
        0x2
    }
    l = {
        0x3f,
        0x40,
        0x46
    }
    m = "invokeSuspend"
    n = {
        "installationId"
    }
    s = {
        "L$0"
    }
.end annotation


# instance fields
.field final synthetic $sessionDetails:Lcom/google/firebase/sessions/y;

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field L$5:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/google/firebase/sessions/c0;


# direct methods
.method public constructor <init>(Lcom/google/firebase/sessions/c0;Lcom/google/firebase/sessions/y;Lwakotl/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/sessions/c0;",
            "Lcom/google/firebase/sessions/y;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->this$0:Lcom/google/firebase/sessions/c0;

    iput-object p2, p0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->$sessionDetails:Lcom/google/firebase/sessions/y;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lwakotl/coroutines/jvm/internal/SuspendLambda;-><init>(ILwakotl/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;
    .locals 2
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

    new-instance p1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;

    iget-object v0, p0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->this$0:Lcom/google/firebase/sessions/c0;

    iget-object v1, p0, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->$sessionDetails:Lcom/google/firebase/sessions/y;

    invoke-direct {p1, v0, v1, p2}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;-><init>(Lcom/google/firebase/sessions/c0;Lcom/google/firebase/sessions/y;Lwakotl/coroutines/Continuation;)V

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 1
    check-cast p1, Lkotlinx/coroutines/e0;

    check-cast p2, Lwakotl/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->invoke(Lkotlinx/coroutines/e0;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

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
    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;

    sget-object p2, Lwakotl/Unit;->a:Lwakotl/Unit;

    invoke-virtual {p1, p2}, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 19
    .param p1    # Ljava/lang/Object;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 1
    move-object/from16 v1, p0

    .line 2
    .line 3
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    iget v2, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->label:I

    .line 8
    .line 9
    const/4 v3, 0x3

    .line 10
    const/4 v4, 0x2

    .line 11
    const/4 v5, 0x1

    .line 12
    if-eqz v2, :cond_3

    .line 13
    .line 14
    if-eq v2, v5, :cond_2

    .line 15
    .line 16
    if-eq v2, v4, :cond_1

    .line 17
    .line 18
    if-ne v2, v3, :cond_0

    .line 19
    .line 20
    iget-object v0, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$5:Ljava/lang/Object;

    .line 21
    .line 22
    check-cast v0, Lcom/google/firebase/sessions/settings/e;

    .line 23
    .line 24
    iget-object v2, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$4:Ljava/lang/Object;

    .line 25
    .line 26
    check-cast v2, Lcom/google/firebase/sessions/y;

    .line 27
    .line 28
    iget-object v3, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$3:Ljava/lang/Object;

    .line 29
    .line 30
    check-cast v3, Lef/h;

    .line 31
    .line 32
    iget-object v4, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$2:Ljava/lang/Object;

    .line 33
    .line 34
    check-cast v4, Lcom/google/firebase/sessions/a0;

    .line 35
    .line 36
    iget-object v5, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$1:Ljava/lang/Object;

    .line 37
    .line 38
    check-cast v5, Lcom/google/firebase/sessions/c0;

    .line 39
    .line 40
    iget-object v6, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$0:Ljava/lang/Object;

    .line 41
    .line 42
    check-cast v6, Lcom/google/firebase/sessions/o;

    .line 43
    .line 44
    invoke-static/range {p1 .. p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 45
    .line 46
    .line 47
    move-object v7, v6

    .line 48
    move-object v6, v5

    .line 49
    move-object v5, v4

    .line 50
    move-object v4, v3

    .line 51
    move-object/from16 v3, p1

    .line 52
    .line 53
    goto :goto_2

    .line 54
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 55
    .line 56
    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    .line 57
    .line 58
    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 59
    .line 60
    .line 61
    throw v0

    .line 62
    :cond_1
    invoke-static/range {p1 .. p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 63
    .line 64
    .line 65
    move-object/from16 v2, p1

    .line 66
    .line 67
    goto :goto_1

    .line 68
    :cond_2
    invoke-static/range {p1 .. p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 69
    .line 70
    .line 71
    move-object/from16 v2, p1

    .line 72
    .line 73
    goto :goto_0

    .line 74
    :cond_3
    invoke-static/range {p1 .. p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 75
    .line 76
    .line 77
    iget-object v2, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->this$0:Lcom/google/firebase/sessions/c0;

    .line 78
    .line 79
    iput v5, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->label:I

    .line 80
    .line 81
    invoke-static {v2, v1}, Lcom/google/firebase/sessions/c0;->a(Lcom/google/firebase/sessions/c0;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 82
    .line 83
    .line 84
    move-result-object v2

    .line 85
    if-ne v2, v0, :cond_4

    .line 86
    .line 87
    return-object v0

    .line 88
    :cond_4
    :goto_0
    check-cast v2, Ljava/lang/Boolean;

    .line 89
    .line 90
    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    .line 91
    .line 92
    .line 93
    move-result v2

    .line 94
    if-eqz v2, :cond_b

    .line 95
    .line 96
    sget-object v2, Lcom/google/firebase/sessions/o;->c:Lcom/google/firebase/sessions/n;

    .line 97
    .line 98
    iget-object v5, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->this$0:Lcom/google/firebase/sessions/c0;

    .line 99
    .line 100
    iget-object v5, v5, Lcom/google/firebase/sessions/c0;->b:Llg/d;

    .line 101
    .line 102
    iput v4, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->label:I

    .line 103
    .line 104
    invoke-virtual {v2, v5, v1}, Lcom/google/firebase/sessions/n;->a(Llg/d;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 105
    .line 106
    .line 107
    move-result-object v2

    .line 108
    if-ne v2, v0, :cond_5

    .line 109
    .line 110
    return-object v0

    .line 111
    :cond_5
    :goto_1
    move-object v6, v2

    .line 112
    check-cast v6, Lcom/google/firebase/sessions/o;

    .line 113
    .line 114
    iget-object v5, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->this$0:Lcom/google/firebase/sessions/c0;

    .line 115
    .line 116
    sget-object v4, Lcom/google/firebase/sessions/a0;->a:Lcom/google/firebase/sessions/a0;

    .line 117
    .line 118
    iget-object v2, v5, Lcom/google/firebase/sessions/c0;->a:Lef/h;

    .line 119
    .line 120
    iget-object v7, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->$sessionDetails:Lcom/google/firebase/sessions/y;

    .line 121
    .line 122
    sget-object v8, Lcom/google/firebase/sessions/api/b;->a:Lcom/google/firebase/sessions/api/b;

    .line 123
    .line 124
    iput-object v6, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$0:Ljava/lang/Object;

    .line 125
    .line 126
    iput-object v5, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$1:Ljava/lang/Object;

    .line 127
    .line 128
    iput-object v4, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$2:Ljava/lang/Object;

    .line 129
    .line 130
    iput-object v2, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$3:Ljava/lang/Object;

    .line 131
    .line 132
    iput-object v7, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$4:Ljava/lang/Object;

    .line 133
    .line 134
    iget-object v9, v5, Lcom/google/firebase/sessions/c0;->c:Lcom/google/firebase/sessions/settings/e;

    .line 135
    .line 136
    iput-object v9, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->L$5:Ljava/lang/Object;

    .line 137
    .line 138
    iput v3, v1, Lcom/google/firebase/sessions/SessionFirelogPublisherImpl$logSession$1;->label:I

    .line 139
    .line 140
    invoke-virtual {v8, v1}, Lcom/google/firebase/sessions/api/b;->b(Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 141
    .line 142
    .line 143
    move-result-object v3

    .line 144
    if-ne v3, v0, :cond_6

    .line 145
    .line 146
    return-object v0

    .line 147
    :cond_6
    move-object v0, v9

    .line 148
    move-object/from16 v18, v4

    .line 149
    .line 150
    move-object v4, v2

    .line 151
    move-object v2, v7

    .line 152
    move-object v7, v6

    .line 153
    move-object v6, v5

    .line 154
    move-object/from16 v5, v18

    .line 155
    .line 156
    :goto_2
    check-cast v3, Ljava/util/Map;

    .line 157
    .line 158
    iget-object v15, v7, Lcom/google/firebase/sessions/o;->a:Ljava/lang/String;

    .line 159
    .line 160
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 161
    .line 162
    .line 163
    const-string v5, "firebaseApp"

    .line 164
    .line 165
    invoke-static {v4, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 166
    .line 167
    .line 168
    const-string v5, "sessionDetails"

    .line 169
    .line 170
    invoke-static {v2, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 171
    .line 172
    .line 173
    const-string v5, "sessionsSettings"

    .line 174
    .line 175
    invoke-static {v0, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 176
    .line 177
    .line 178
    const-string v5, "subscribers"

    .line 179
    .line 180
    invoke-static {v3, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 181
    .line 182
    .line 183
    const-string v5, "firebaseInstallationId"

    .line 184
    .line 185
    invoke-static {v15, v5}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 186
    .line 187
    .line 188
    iget-object v5, v7, Lcom/google/firebase/sessions/o;->b:Ljava/lang/String;

    .line 189
    .line 190
    const-string v7, "firebaseAuthenticationToken"

    .line 191
    .line 192
    invoke-static {v5, v7}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 193
    .line 194
    .line 195
    new-instance v7, Lcom/google/firebase/sessions/z;

    .line 196
    .line 197
    sget-object v14, Lcom/google/firebase/sessions/EventType;->SESSION_START:Lcom/google/firebase/sessions/EventType;

    .line 198
    .line 199
    new-instance v12, Lcom/google/firebase/sessions/e0;

    .line 200
    .line 201
    iget-object v9, v2, Lcom/google/firebase/sessions/y;->a:Ljava/lang/String;

    .line 202
    .line 203
    new-instance v13, Lcom/google/firebase/sessions/i;

    .line 204
    .line 205
    sget-object v8, Lcom/google/firebase/sessions/api/SessionSubscriber$Name;->PERFORMANCE:Lcom/google/firebase/sessions/api/SessionSubscriber$Name;

    .line 206
    .line 207
    invoke-interface {v3, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 208
    .line 209
    .line 210
    move-result-object v8

    .line 211
    check-cast v8, Lpf/j;

    .line 212
    .line 213
    if-nez v8, :cond_7

    .line 214
    .line 215
    sget-object v8, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_SDK_NOT_INSTALLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 216
    .line 217
    goto :goto_3

    .line 218
    :cond_7
    iget-object v8, v8, Lpf/j;->a:Lpf/s;

    .line 219
    .line 220
    invoke-virtual {v8}, Lpf/s;->b()Z

    .line 221
    .line 222
    .line 223
    move-result v8

    .line 224
    if-eqz v8, :cond_8

    .line 225
    .line 226
    sget-object v8, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_ENABLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 227
    .line 228
    goto :goto_3

    .line 229
    :cond_8
    sget-object v8, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_DISABLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 230
    .line 231
    :goto_3
    sget-object v10, Lcom/google/firebase/sessions/api/SessionSubscriber$Name;->CRASHLYTICS:Lcom/google/firebase/sessions/api/SessionSubscriber$Name;

    .line 232
    .line 233
    invoke-interface {v3, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 234
    .line 235
    .line 236
    move-result-object v3

    .line 237
    check-cast v3, Lpf/j;

    .line 238
    .line 239
    if-nez v3, :cond_9

    .line 240
    .line 241
    sget-object v3, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_SDK_NOT_INSTALLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 242
    .line 243
    goto :goto_4

    .line 244
    :cond_9
    iget-object v3, v3, Lpf/j;->a:Lpf/s;

    .line 245
    .line 246
    invoke-virtual {v3}, Lpf/s;->b()Z

    .line 247
    .line 248
    .line 249
    move-result v3

    .line 250
    if-eqz v3, :cond_a

    .line 251
    .line 252
    sget-object v3, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_ENABLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 253
    .line 254
    goto :goto_4

    .line 255
    :cond_a
    sget-object v3, Lcom/google/firebase/sessions/DataCollectionState;->COLLECTION_DISABLED:Lcom/google/firebase/sessions/DataCollectionState;

    .line 256
    .line 257
    :goto_4
    invoke-virtual {v0}, Lcom/google/firebase/sessions/settings/e;->a()D

    .line 258
    .line 259
    .line 260
    move-result-wide v10

    .line 261
    invoke-direct {v13, v8, v3, v10, v11}, Lcom/google/firebase/sessions/i;-><init>(Lcom/google/firebase/sessions/DataCollectionState;Lcom/google/firebase/sessions/DataCollectionState;D)V

    .line 262
    .line 263
    .line 264
    iget-wide v10, v2, Lcom/google/firebase/sessions/y;->d:J

    .line 265
    .line 266
    iget-object v0, v2, Lcom/google/firebase/sessions/y;->b:Ljava/lang/String;

    .line 267
    .line 268
    iget v2, v2, Lcom/google/firebase/sessions/y;->c:I

    .line 269
    .line 270
    move-object v8, v12

    .line 271
    move-wide/from16 v16, v10

    .line 272
    .line 273
    move-object v10, v0

    .line 274
    move v11, v2

    .line 275
    move-object v0, v12

    .line 276
    move-object v2, v13

    .line 277
    move-wide/from16 v12, v16

    .line 278
    .line 279
    move-object v3, v14

    .line 280
    move-object v14, v2

    .line 281
    move-object/from16 v16, v5

    .line 282
    .line 283
    invoke-direct/range {v8 .. v16}, Lcom/google/firebase/sessions/e0;-><init>(Ljava/lang/String;Ljava/lang/String;IJLcom/google/firebase/sessions/i;Ljava/lang/String;Ljava/lang/String;)V

    .line 284
    .line 285
    .line 286
    invoke-static {v4}, Lcom/google/firebase/sessions/a0;->a(Lef/h;)Lcom/google/firebase/sessions/b;

    .line 287
    .line 288
    .line 289
    move-result-object v2

    .line 290
    invoke-direct {v7, v3, v0, v2}, Lcom/google/firebase/sessions/z;-><init>(Lcom/google/firebase/sessions/EventType;Lcom/google/firebase/sessions/e0;Lcom/google/firebase/sessions/b;)V

    .line 291
    .line 292
    .line 293
    sget v0, Lcom/google/firebase/sessions/c0;->g:I

    .line 294
    .line 295
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 296
    .line 297
    .line 298
    :try_start_0
    iget-object v0, v6, Lcom/google/firebase/sessions/c0;->d:Lcom/google/firebase/sessions/j;

    .line 299
    .line 300
    invoke-virtual {v0, v7}, Lcom/google/firebase/sessions/j;->a(Lcom/google/firebase/sessions/z;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 301
    .line 302
    .line 303
    goto :goto_5

    .line 304
    :catch_0
    move-exception v0

    .line 305
    const-string v2, "SessionFirelogPublisher"

    .line 306
    .line 307
    const-string v3, "Error logging Session Start event to DataTransport: "

    .line 308
    .line 309
    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 310
    .line 311
    .line 312
    :cond_b
    :goto_5
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 313
    .line 314
    return-object v0
.end method
