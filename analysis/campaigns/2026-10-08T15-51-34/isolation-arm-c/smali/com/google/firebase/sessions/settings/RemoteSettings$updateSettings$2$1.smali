.class final Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;
.super Lwakotl/coroutines/jvm/internal/SuspendLambda;
.source "SourceFile"

# interfaces
.implements Lwakotl/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lwakotl/coroutines/jvm/internal/SuspendLambda;",
        "Lwakotl/jvm/functions/Function2<",
        "Lorg/json/JSONObject;",
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
        "\u0000\u000c\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "Lorg/json/JSONObject;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lwakotl/coroutines/jvm/internal/DebugMetadata;
    c = "com.google.firebase.sessions.settings.RemoteSettings$updateSettings$2$1"
    f = "RemoteSettings.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x2
    }
    l = {
        0x7d,
        0x80,
        0x83,
        0x85,
        0x86,
        0x88
    }
    m = "invokeSuspend"
    n = {
        "sessionSamplingRate",
        "sessionTimeoutSeconds",
        "cacheDuration",
        "sessionSamplingRate",
        "cacheDuration",
        "cacheDuration"
    }
    s = {
        "L$0",
        "L$1",
        "L$2",
        "L$0",
        "L$1",
        "L$0"
    }
.end annotation


# instance fields
.field synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/google/firebase/sessions/settings/a;


# direct methods
.method public constructor <init>(Lcom/google/firebase/sessions/settings/a;Lwakotl/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/sessions/settings/a;",
            "Lwakotl/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p2}, Lwakotl/coroutines/jvm/internal/SuspendLambda;-><init>(ILwakotl/coroutines/Continuation;)V

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

    new-instance v0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;

    iget-object v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    invoke-direct {v0, v1, p2}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;-><init>(Lcom/google/firebase/sessions/settings/a;Lwakotl/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 1
    check-cast p1, Lorg/json/JSONObject;

    check-cast p2, Lwakotl/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->invoke(Lorg/json/JSONObject;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invoke(Lorg/json/JSONObject;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .param p1    # Lorg/json/JSONObject;
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
            "Lorg/json/JSONObject;",
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
    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->create(Ljava/lang/Object;Lwakotl/coroutines/Continuation;)Lwakotl/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;

    sget-object p2, Lwakotl/Unit;->a:Lwakotl/Unit;

    invoke-virtual {p1, p2}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11
    .param p1    # Ljava/lang/Object;
        .annotation build Lorg/jetbrains/annotations/NotNull;
        .end annotation
    .end param
    .annotation build Lorg/jetbrains/annotations/Nullable;
    .end annotation

    .line 1
    const-string v0, "cache_duration"

    .line 2
    .line 3
    const-string v1, "session_timeout_seconds"

    .line 4
    .line 5
    const-string v2, "sampling_rate"

    .line 6
    .line 7
    const-string v3, "sessions_enabled"

    .line 8
    .line 9
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 10
    .line 11
    .line 12
    move-result-object v4

    .line 13
    iget v5, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 14
    .line 15
    const/4 v6, 0x0

    .line 16
    packed-switch v5, :pswitch_data_0

    .line 17
    .line 18
    .line 19
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
    :pswitch_0
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 28
    .line 29
    .line 30
    goto/16 :goto_11

    .line 31
    .line 32
    :pswitch_1
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 33
    .line 34
    .line 35
    goto/16 :goto_f

    .line 36
    .line 37
    :pswitch_2
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 38
    .line 39
    .line 40
    goto/16 :goto_c

    .line 41
    .line 42
    :pswitch_3
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 43
    .line 44
    check-cast v0, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 45
    .line 46
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 47
    .line 48
    .line 49
    goto/16 :goto_a

    .line 50
    .line 51
    :pswitch_4
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 52
    .line 53
    check-cast v0, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 54
    .line 55
    iget-object v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 56
    .line 57
    check-cast v1, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 58
    .line 59
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 60
    .line 61
    .line 62
    goto/16 :goto_8

    .line 63
    .line 64
    :pswitch_5
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 65
    .line 66
    check-cast v0, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 67
    .line 68
    iget-object v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 69
    .line 70
    check-cast v1, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 71
    .line 72
    iget-object v2, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 73
    .line 74
    check-cast v2, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 75
    .line 76
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 77
    .line 78
    .line 79
    goto/16 :goto_5

    .line 80
    .line 81
    :pswitch_6
    invoke-static {p1}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 82
    .line 83
    .line 84
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 85
    .line 86
    check-cast p1, Lorg/json/JSONObject;

    .line 87
    .line 88
    invoke-static {p1}, Lj$/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 89
    .line 90
    .line 91
    new-instance v5, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 92
    .line 93
    invoke-direct {v5}, Lwakotl/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 94
    .line 95
    .line 96
    new-instance v7, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 97
    .line 98
    invoke-direct {v7}, Lwakotl/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 99
    .line 100
    .line 101
    new-instance v8, Lwakotl/jvm/internal/Ref$ObjectRef;

    .line 102
    .line 103
    invoke-direct {v8}, Lwakotl/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 104
    .line 105
    .line 106
    const-string v9, "app_quality"

    .line 107
    .line 108
    invoke-virtual {p1, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 109
    .line 110
    .line 111
    move-result v10

    .line 112
    if-eqz v10, :cond_3

    .line 113
    .line 114
    invoke-virtual {p1, v9}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 115
    .line 116
    .line 117
    move-result-object p1

    .line 118
    const-string v9, "null cannot be cast to non-null type org.json.JSONObject"

    .line 119
    .line 120
    invoke-static {p1, v9}, Lwakotl/jvm/internal/Intrinsics;->d(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    .line 122
    .line 123
    check-cast p1, Lorg/json/JSONObject;

    .line 124
    .line 125
    :try_start_0
    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 126
    .line 127
    .line 128
    move-result v9

    .line 129
    if-eqz v9, :cond_0

    .line 130
    .line 131
    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 132
    .line 133
    .line 134
    move-result-object v3

    .line 135
    check-cast v3, Ljava/lang/Boolean;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 136
    .line 137
    goto :goto_0

    .line 138
    :catch_0
    move-exception p1

    .line 139
    move-object v3, v6

    .line 140
    goto :goto_2

    .line 141
    :cond_0
    move-object v3, v6

    .line 142
    :goto_0
    :try_start_1
    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 143
    .line 144
    .line 145
    move-result v9

    .line 146
    if-eqz v9, :cond_1

    .line 147
    .line 148
    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 149
    .line 150
    .line 151
    move-result-object v2

    .line 152
    check-cast v2, Ljava/lang/Double;

    .line 153
    .line 154
    iput-object v2, v5, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 155
    .line 156
    goto :goto_1

    .line 157
    :catch_1
    move-exception p1

    .line 158
    goto :goto_2

    .line 159
    :cond_1
    :goto_1
    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 160
    .line 161
    .line 162
    move-result v2

    .line 163
    if-eqz v2, :cond_2

    .line 164
    .line 165
    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 166
    .line 167
    .line 168
    move-result-object v1

    .line 169
    check-cast v1, Ljava/lang/Integer;

    .line 170
    .line 171
    iput-object v1, v7, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 172
    .line 173
    :cond_2
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 174
    .line 175
    .line 176
    move-result v1

    .line 177
    if-eqz v1, :cond_4

    .line 178
    .line 179
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 180
    .line 181
    .line 182
    move-result-object p1

    .line 183
    check-cast p1, Ljava/lang/Integer;

    .line 184
    .line 185
    iput-object p1, v8, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 186
    .line 187
    goto :goto_3

    .line 188
    :goto_2
    const-string v0, "SessionConfigFetcher"

    .line 189
    .line 190
    const-string v1, "Error parsing the configs remotely fetched: "

    .line 191
    .line 192
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 193
    .line 194
    .line 195
    goto :goto_3

    .line 196
    :cond_3
    move-object v3, v6

    .line 197
    :cond_4
    :goto_3
    if-eqz v3, :cond_7

    .line 198
    .line 199
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 200
    .line 201
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 202
    .line 203
    .line 204
    move-result-object p1

    .line 205
    iput-object v5, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 206
    .line 207
    iput-object v7, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 208
    .line 209
    iput-object v8, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 210
    .line 211
    const/4 v0, 0x1

    .line 212
    iput v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 213
    .line 214
    sget-object v0, Lcom/google/firebase/sessions/settings/f;->c:Landroidx/datastore/preferences/core/e;

    .line 215
    .line 216
    invoke-virtual {p1, v0, v3, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 217
    .line 218
    .line 219
    move-result-object p1

    .line 220
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 221
    .line 222
    .line 223
    move-result-object v0

    .line 224
    if-ne p1, v0, :cond_5

    .line 225
    .line 226
    goto :goto_4

    .line 227
    :cond_5
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 228
    .line 229
    :goto_4
    if-ne p1, v4, :cond_6

    .line 230
    .line 231
    return-object v4

    .line 232
    :cond_6
    move-object v2, v5

    .line 233
    move-object v1, v7

    .line 234
    move-object v0, v8

    .line 235
    :goto_5
    move-object v7, v1

    .line 236
    move-object v1, v2

    .line 237
    goto :goto_6

    .line 238
    :cond_7
    move-object v1, v5

    .line 239
    move-object v0, v8

    .line 240
    :goto_6
    iget-object p1, v7, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 241
    .line 242
    check-cast p1, Ljava/lang/Integer;

    .line 243
    .line 244
    if-eqz p1, :cond_9

    .line 245
    .line 246
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 247
    .line 248
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 249
    .line 250
    .line 251
    move-result-object p1

    .line 252
    iget-object v2, v7, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 253
    .line 254
    check-cast v2, Ljava/lang/Integer;

    .line 255
    .line 256
    iput-object v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 257
    .line 258
    iput-object v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 259
    .line 260
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 261
    .line 262
    const/4 v3, 0x2

    .line 263
    iput v3, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 264
    .line 265
    sget-object v3, Lcom/google/firebase/sessions/settings/f;->e:Landroidx/datastore/preferences/core/e;

    .line 266
    .line 267
    invoke-virtual {p1, v3, v2, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 268
    .line 269
    .line 270
    move-result-object p1

    .line 271
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 272
    .line 273
    .line 274
    move-result-object v2

    .line 275
    if-ne p1, v2, :cond_8

    .line 276
    .line 277
    goto :goto_7

    .line 278
    :cond_8
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 279
    .line 280
    :goto_7
    if-ne p1, v4, :cond_9

    .line 281
    .line 282
    return-object v4

    .line 283
    :cond_9
    :goto_8
    iget-object p1, v1, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 284
    .line 285
    check-cast p1, Ljava/lang/Double;

    .line 286
    .line 287
    if-eqz p1, :cond_b

    .line 288
    .line 289
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 290
    .line 291
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 292
    .line 293
    .line 294
    move-result-object p1

    .line 295
    iget-object v1, v1, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 296
    .line 297
    check-cast v1, Ljava/lang/Double;

    .line 298
    .line 299
    iput-object v0, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 300
    .line 301
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 302
    .line 303
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 304
    .line 305
    const/4 v2, 0x3

    .line 306
    iput v2, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 307
    .line 308
    sget-object v2, Lcom/google/firebase/sessions/settings/f;->d:Landroidx/datastore/preferences/core/e;

    .line 309
    .line 310
    invoke-virtual {p1, v2, v1, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 311
    .line 312
    .line 313
    move-result-object p1

    .line 314
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 315
    .line 316
    .line 317
    move-result-object v1

    .line 318
    if-ne p1, v1, :cond_a

    .line 319
    .line 320
    goto :goto_9

    .line 321
    :cond_a
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 322
    .line 323
    :goto_9
    if-ne p1, v4, :cond_b

    .line 324
    .line 325
    return-object v4

    .line 326
    :cond_b
    :goto_a
    iget-object p1, v0, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 327
    .line 328
    check-cast p1, Ljava/lang/Integer;

    .line 329
    .line 330
    if-eqz p1, :cond_e

    .line 331
    .line 332
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 333
    .line 334
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 335
    .line 336
    .line 337
    move-result-object p1

    .line 338
    iget-object v0, v0, Lwakotl/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 339
    .line 340
    check-cast v0, Ljava/lang/Integer;

    .line 341
    .line 342
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 343
    .line 344
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 345
    .line 346
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 347
    .line 348
    const/4 v1, 0x4

    .line 349
    iput v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 350
    .line 351
    sget-object v1, Lcom/google/firebase/sessions/settings/f;->f:Landroidx/datastore/preferences/core/e;

    .line 352
    .line 353
    invoke-virtual {p1, v1, v0, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 354
    .line 355
    .line 356
    move-result-object p1

    .line 357
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 358
    .line 359
    .line 360
    move-result-object v0

    .line 361
    if-ne p1, v0, :cond_c

    .line 362
    .line 363
    goto :goto_b

    .line 364
    :cond_c
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 365
    .line 366
    :goto_b
    if-ne p1, v4, :cond_d

    .line 367
    .line 368
    return-object v4

    .line 369
    :cond_d
    :goto_c
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 370
    .line 371
    goto :goto_d

    .line 372
    :cond_e
    move-object p1, v6

    .line 373
    :goto_d
    if-nez p1, :cond_10

    .line 374
    .line 375
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 376
    .line 377
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 378
    .line 379
    .line 380
    move-result-object p1

    .line 381
    const v0, 0x15180

    .line 382
    .line 383
    .line 384
    invoke-static {v0}, Lwakotl/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    .line 385
    .line 386
    .line 387
    move-result-object v0

    .line 388
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 389
    .line 390
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 391
    .line 392
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 393
    .line 394
    const/4 v1, 0x5

    .line 395
    iput v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 396
    .line 397
    sget-object v1, Lcom/google/firebase/sessions/settings/f;->f:Landroidx/datastore/preferences/core/e;

    .line 398
    .line 399
    invoke-virtual {p1, v1, v0, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 400
    .line 401
    .line 402
    move-result-object p1

    .line 403
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 404
    .line 405
    .line 406
    move-result-object v0

    .line 407
    if-ne p1, v0, :cond_f

    .line 408
    .line 409
    goto :goto_e

    .line 410
    :cond_f
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 411
    .line 412
    :goto_e
    if-ne p1, v4, :cond_10

    .line 413
    .line 414
    return-object v4

    .line 415
    :cond_10
    :goto_f
    iget-object p1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->this$0:Lcom/google/firebase/sessions/settings/a;

    .line 416
    .line 417
    invoke-virtual {p1}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 418
    .line 419
    .line 420
    move-result-object p1

    .line 421
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 422
    .line 423
    .line 424
    move-result-wide v0

    .line 425
    invoke-static {v0, v1}, Lwakotl/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    .line 426
    .line 427
    .line 428
    move-result-object v0

    .line 429
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$0:Ljava/lang/Object;

    .line 430
    .line 431
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$1:Ljava/lang/Object;

    .line 432
    .line 433
    iput-object v6, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->L$2:Ljava/lang/Object;

    .line 434
    .line 435
    const/4 v1, 0x6

    .line 436
    iput v1, p0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;->label:I

    .line 437
    .line 438
    sget-object v1, Lcom/google/firebase/sessions/settings/f;->g:Landroidx/datastore/preferences/core/e;

    .line 439
    .line 440
    invoke-virtual {p1, v1, v0, p0}, Lcom/google/firebase/sessions/settings/f;->c(Landroidx/datastore/preferences/core/e;Ljava/lang/Object;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 441
    .line 442
    .line 443
    move-result-object p1

    .line 444
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 445
    .line 446
    .line 447
    move-result-object v0

    .line 448
    if-ne p1, v0, :cond_11

    .line 449
    .line 450
    goto :goto_10

    .line 451
    :cond_11
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 452
    .line 453
    :goto_10
    if-ne p1, v4, :cond_12

    .line 454
    .line 455
    return-object v4

    .line 456
    :cond_12
    :goto_11
    sget-object p1, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 457
    .line 458
    return-object p1

    .line 459
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
