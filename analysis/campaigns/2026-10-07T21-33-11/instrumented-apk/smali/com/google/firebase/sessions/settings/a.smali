.class public final Lcom/google/firebase/sessions/settings/a;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lwakotl/coroutines/CoroutineContext;

.field public final b:Llg/d;

.field public final c:Lcom/google/firebase/sessions/settings/b;

.field public final d:Lop/i;

.field public final e:Lkotlinx/coroutines/sync/a;


# direct methods
.method public constructor <init>(Lwakotl/coroutines/CoroutineContext;Llg/d;Lcom/google/firebase/sessions/b;Lcom/google/firebase/sessions/settings/b;Landroidx/datastore/core/h;)V
    .locals 1

    .line 1
    const-string v0, "backgroundDispatcher"

    .line 2
    .line 3
    invoke-static {p1, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    const-string v0, "firebaseInstallationsApi"

    .line 7
    .line 8
    invoke-static {p2, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    .line 10
    .line 11
    const-string v0, "appInfo"

    .line 12
    .line 13
    invoke-static {p3, v0}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    .line 15
    .line 16
    const-string p3, "configsFetcher"

    .line 17
    .line 18
    invoke-static {p4, p3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    .line 20
    .line 21
    const-string p3, "dataStore"

    .line 22
    .line 23
    invoke-static {p5, p3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    .line 25
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    .line 28
    .line 29
    iput-object p1, p0, Lcom/google/firebase/sessions/settings/a;->a:Lwakotl/coroutines/CoroutineContext;

    .line 30
    .line 31
    iput-object p2, p0, Lcom/google/firebase/sessions/settings/a;->b:Llg/d;

    .line 32
    .line 33
    iput-object p4, p0, Lcom/google/firebase/sessions/settings/a;->c:Lcom/google/firebase/sessions/settings/b;

    .line 34
    .line 35
    new-instance p1, Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;

    .line 36
    .line 37
    invoke-direct {p1, p5}, Lcom/google/firebase/sessions/settings/RemoteSettings$settingsCache$2;-><init>(Landroidx/datastore/core/h;)V

    .line 38
    .line 39
    .line 40
    invoke-static {p1}, Lwakotl/a;->b(Lwakotl/jvm/functions/Function0;)Lop/i;

    .line 41
    .line 42
    .line 43
    move-result-object p1

    .line 44
    iput-object p1, p0, Lcom/google/firebase/sessions/settings/a;->d:Lop/i;

    .line 45
    .line 46
    invoke-static {}, Lqq/d;->a()Lkotlinx/coroutines/sync/a;

    .line 47
    .line 48
    .line 49
    move-result-object p1

    .line 50
    iput-object p1, p0, Lcom/google/firebase/sessions/settings/a;->e:Lkotlinx/coroutines/sync/a;

    .line 51
    .line 52
    return-void
.end method


# virtual methods
.method public final a()Ljava/lang/Boolean;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/f;->b:Lcom/google/firebase/sessions/settings/c;

    .line 6
    .line 7
    if-eqz v0, :cond_0

    .line 8
    .line 9
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/c;->a:Ljava/lang/Boolean;

    .line 10
    .line 11
    return-object v0

    .line 12
    :cond_0
    const-string v0, "sessionConfigs"

    .line 13
    .line 14
    invoke-static {v0}, Lwakotl/jvm/internal/Intrinsics;->j(Ljava/lang/String;)V

    .line 15
    .line 16
    .line 17
    const/4 v0, 0x0

    .line 18
    throw v0
.end method

.method public final b()Lcom/google/firebase/sessions/settings/f;
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/firebase/sessions/settings/a;->d:Lop/i;

    .line 2
    .line 3
    invoke-interface {v0}, Lop/i;->getValue()Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    check-cast v0, Lcom/google/firebase/sessions/settings/f;

    .line 8
    .line 9
    return-object v0
.end method

.method public final c(Lwakotl/coroutines/Continuation;)Ljava/lang/Object;
    .locals 23

    .line 1
    move-object/from16 v1, p0

    .line 2
    .line 3
    move-object/from16 v0, p1

    .line 4
    .line 5
    const/4 v2, 0x0

    .line 6
    const/4 v3, 0x3

    .line 7
    const/4 v4, 0x2

    .line 8
    const/4 v5, 0x1

    .line 9
    const-string v6, "/"

    .line 10
    .line 11
    const-string v7, ""

    .line 12
    .line 13
    instance-of v8, v0, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;

    .line 14
    .line 15
    if-eqz v8, :cond_0

    .line 16
    .line 17
    move-object v8, v0

    .line 18
    check-cast v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;

    .line 19
    .line 20
    iget v9, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 21
    .line 22
    const/high16 v10, -0x80000000

    .line 23
    .line 24
    and-int v11, v9, v10

    .line 25
    .line 26
    if-eqz v11, :cond_0

    .line 27
    .line 28
    sub-int/2addr v9, v10

    .line 29
    iput v9, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 30
    .line 31
    goto :goto_0

    .line 32
    :cond_0
    new-instance v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;

    .line 33
    .line 34
    invoke-direct {v8, v1, v0}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;-><init>(Lcom/google/firebase/sessions/settings/a;Lwakotl/coroutines/Continuation;)V

    .line 35
    .line 36
    .line 37
    :goto_0
    iget-object v0, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->result:Ljava/lang/Object;

    .line 38
    .line 39
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 40
    .line 41
    .line 42
    move-result-object v9

    .line 43
    iget v10, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 44
    .line 45
    const/4 v11, 0x0

    .line 46
    if-eqz v10, :cond_4

    .line 47
    .line 48
    if-eq v10, v5, :cond_3

    .line 49
    .line 50
    if-eq v10, v4, :cond_2

    .line 51
    .line 52
    if-ne v10, v3, :cond_1

    .line 53
    .line 54
    iget-object v2, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 55
    .line 56
    check-cast v2, Lqq/a;

    .line 57
    .line 58
    :try_start_0
    invoke-static {v0}, Lwakotl/b;->b(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 59
    .line 60
    .line 61
    goto/16 :goto_5

    .line 62
    .line 63
    :catchall_0
    move-exception v0

    .line 64
    :goto_1
    move-object v3, v11

    .line 65
    goto/16 :goto_8

    .line 66
    .line 67
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 68
    .line 69
    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    .line 70
    .line 71
    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 72
    .line 73
    .line 74
    throw v0

    .line 75
    :cond_2
    iget-object v10, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$1:Ljava/lang/Object;

    .line 76
    .line 77
    check-cast v10, Lqq/a;

    .line 78
    .line 79
    iget-object v12, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 80
    .line 81
    check-cast v12, Lcom/google/firebase/sessions/settings/a;

    .line 82
    .line 83
    :try_start_1
    invoke-static {v0}, Lwakotl/b;->b(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 84
    .line 85
    .line 86
    goto :goto_3

    .line 87
    :catchall_1
    move-exception v0

    .line 88
    move-object v2, v10

    .line 89
    goto :goto_1

    .line 90
    :cond_3
    iget-object v10, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$1:Ljava/lang/Object;

    .line 91
    .line 92
    check-cast v10, Lqq/a;

    .line 93
    .line 94
    iget-object v12, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 95
    .line 96
    check-cast v12, Lcom/google/firebase/sessions/settings/a;

    .line 97
    .line 98
    invoke-static {v0}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 99
    .line 100
    .line 101
    goto :goto_2

    .line 102
    :cond_4
    invoke-static {v0}, Lwakotl/b;->b(Ljava/lang/Object;)V

    .line 103
    .line 104
    .line 105
    iget-object v0, v1, Lcom/google/firebase/sessions/settings/a;->e:Lkotlinx/coroutines/sync/a;

    .line 106
    .line 107
    invoke-virtual {v0}, Lkotlinx/coroutines/sync/a;->f()Z

    .line 108
    .line 109
    .line 110
    move-result v10

    .line 111
    if-nez v10, :cond_5

    .line 112
    .line 113
    invoke-virtual/range {p0 .. p0}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 114
    .line 115
    .line 116
    move-result-object v10

    .line 117
    invoke-virtual {v10}, Lcom/google/firebase/sessions/settings/f;->b()Z

    .line 118
    .line 119
    .line 120
    move-result v10

    .line 121
    if-nez v10, :cond_5

    .line 122
    .line 123
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 124
    .line 125
    return-object v0

    .line 126
    :cond_5
    iput-object v1, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 127
    .line 128
    iput-object v0, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$1:Ljava/lang/Object;

    .line 129
    .line 130
    iput v5, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 131
    .line 132
    invoke-virtual {v0, v8}, Lkotlinx/coroutines/sync/a;->a(Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 133
    .line 134
    .line 135
    move-result-object v10

    .line 136
    if-ne v10, v9, :cond_6

    .line 137
    .line 138
    return-object v9

    .line 139
    :cond_6
    move-object v10, v0

    .line 140
    move-object v12, v1

    .line 141
    :goto_2
    :try_start_2
    invoke-virtual {v12}, Lcom/google/firebase/sessions/settings/a;->b()Lcom/google/firebase/sessions/settings/f;

    .line 142
    .line 143
    .line 144
    move-result-object v0

    .line 145
    invoke-virtual {v0}, Lcom/google/firebase/sessions/settings/f;->b()Z

    .line 146
    .line 147
    .line 148
    move-result v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 149
    if-nez v0, :cond_7

    .line 150
    .line 151
    :try_start_3
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 152
    .line 153
    invoke-interface {v10, v11}, Lqq/a;->b(Ljava/lang/Object;)V

    .line 154
    .line 155
    .line 156
    return-object v0

    .line 157
    :cond_7
    :try_start_4
    sget-object v0, Lcom/google/firebase/sessions/o;->c:Lcom/google/firebase/sessions/n;

    .line 158
    .line 159
    iget-object v13, v12, Lcom/google/firebase/sessions/settings/a;->b:Llg/d;

    .line 160
    .line 161
    iput-object v12, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 162
    .line 163
    iput-object v10, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$1:Ljava/lang/Object;

    .line 164
    .line 165
    iput v4, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 166
    .line 167
    invoke-virtual {v0, v13, v8}, Lcom/google/firebase/sessions/n;->a(Llg/d;Lwakotl/coroutines/jvm/internal/ContinuationImpl;)Ljava/lang/Object;

    .line 168
    .line 169
    .line 170
    move-result-object v0

    .line 171
    if-ne v0, v9, :cond_8

    .line 172
    .line 173
    return-object v9

    .line 174
    :cond_8
    :goto_3
    check-cast v0, Lcom/google/firebase/sessions/o;

    .line 175
    .line 176
    iget-object v0, v0, Lcom/google/firebase/sessions/o;->a:Ljava/lang/String;

    .line 177
    .line 178
    invoke-static {v0, v7}, Lwakotl/jvm/internal/Intrinsics;->a(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 179
    .line 180
    .line 181
    move-result v13
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 182
    if-eqz v13, :cond_9

    .line 183
    .line 184
    :try_start_5
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 185
    .line 186
    invoke-interface {v10, v11}, Lqq/a;->b(Ljava/lang/Object;)V

    .line 187
    .line 188
    .line 189
    return-object v0

    .line 190
    :cond_9
    :try_start_6
    const-string v13, "X-Crashlytics-Installation-ID"

    .line 191
    .line 192
    new-instance v14, Lwakotl/Pair;

    .line 193
    .line 194
    invoke-direct {v14, v13, v0}, Lwakotl/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 195
    .line 196
    .line 197
    const-string v0, "X-Crashlytics-Device-Model"

    .line 198
    .line 199
    const-string v13, "%s/%s"

    .line 200
    .line 201
    new-array v15, v4, [Ljava/lang/Object;

    .line 202
    .line 203
    sget-object v16, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 204
    .line 205
    aput-object v16, v15, v2

    .line 206
    .line 207
    sget-object v16, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 208
    .line 209
    aput-object v16, v15, v5

    .line 210
    .line 211
    invoke-static {v15, v4}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    .line 212
    .line 213
    .line 214
    move-result-object v15

    .line 215
    invoke-static {v13, v15}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    .line 216
    .line 217
    .line 218
    move-result-object v13

    .line 219
    const-string v15, "format(format, *args)"

    .line 220
    .line 221
    invoke-static {v13, v15}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 222
    .line 223
    .line 224
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 225
    .line 226
    .line 227
    new-instance v15, Lwakotl/text/Regex;

    .line 228
    .line 229
    invoke-direct {v15, v6}, Lwakotl/text/Regex;-><init>(Ljava/lang/String;)V

    .line 230
    .line 231
    .line 232
    invoke-virtual {v15, v13, v7}, Lwakotl/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    .line 233
    .line 234
    .line 235
    move-result-object v13

    .line 236
    new-instance v15, Lwakotl/Pair;

    .line 237
    .line 238
    invoke-direct {v15, v0, v13}, Lwakotl/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 239
    .line 240
    .line 241
    const-string v0, "X-Crashlytics-OS-Build-Version"

    .line 242
    .line 243
    sget-object v13, Landroid/os/Build$VERSION;->INCREMENTAL:Ljava/lang/String;

    .line 244
    .line 245
    const-string v11, "INCREMENTAL"

    .line 246
    .line 247
    invoke-static {v13, v11}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 248
    .line 249
    .line 250
    new-instance v11, Lwakotl/text/Regex;

    .line 251
    .line 252
    invoke-direct {v11, v6}, Lwakotl/text/Regex;-><init>(Ljava/lang/String;)V

    .line 253
    .line 254
    .line 255
    invoke-virtual {v11, v13, v7}, Lwakotl/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    .line 256
    .line 257
    .line 258
    move-result-object v11

    .line 259
    new-instance v13, Lwakotl/Pair;

    .line 260
    .line 261
    invoke-direct {v13, v0, v11}, Lwakotl/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 262
    .line 263
    .line 264
    const-string v0, "X-Crashlytics-OS-Display-Version"

    .line 265
    .line 266
    sget-object v11, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 267
    .line 268
    const-string v3, "RELEASE"

    .line 269
    .line 270
    invoke-static {v11, v3}, Lwakotl/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 271
    .line 272
    .line 273
    new-instance v3, Lwakotl/text/Regex;

    .line 274
    .line 275
    invoke-direct {v3, v6}, Lwakotl/text/Regex;-><init>(Ljava/lang/String;)V

    .line 276
    .line 277
    .line 278
    invoke-virtual {v3, v11, v7}, Lwakotl/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    .line 279
    .line 280
    .line 281
    move-result-object v3

    .line 282
    new-instance v6, Lwakotl/Pair;

    .line 283
    .line 284
    invoke-direct {v6, v0, v3}, Lwakotl/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 285
    .line 286
    .line 287
    const-string v0, "X-Crashlytics-API-Client-Version"

    .line 288
    .line 289
    const-string v3, "2.0.8"

    .line 290
    .line 291
    new-instance v7, Lwakotl/Pair;

    .line 292
    .line 293
    invoke-direct {v7, v0, v3}, Lwakotl/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 294
    .line 295
    .line 296
    const/4 v0, 0x5

    .line 297
    new-array v0, v0, [Lwakotl/Pair;

    .line 298
    .line 299
    aput-object v14, v0, v2

    .line 300
    .line 301
    aput-object v15, v0, v5

    .line 302
    .line 303
    aput-object v13, v0, v4

    .line 304
    .line 305
    const/4 v2, 0x3

    .line 306
    aput-object v6, v0, v2

    .line 307
    .line 308
    const/4 v2, 0x4

    .line 309
    aput-object v7, v0, v2

    .line 310
    .line 311
    invoke-static {v0}, Lwakotl/collections/s0;->i([Lwakotl/Pair;)Ljava/util/Map;

    .line 312
    .line 313
    .line 314
    move-result-object v19

    .line 315
    iget-object v0, v12, Lcom/google/firebase/sessions/settings/a;->c:Lcom/google/firebase/sessions/settings/b;

    .line 316
    .line 317
    new-instance v2, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;

    .line 318
    .line 319
    const/4 v3, 0x0

    .line 320
    invoke-direct {v2, v12, v3}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$1;-><init>(Lcom/google/firebase/sessions/settings/a;Lwakotl/coroutines/Continuation;)V

    .line 321
    .line 322
    .line 323
    new-instance v4, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$2;

    .line 324
    .line 325
    invoke-direct {v4, v3}, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$2$2;-><init>(Lwakotl/coroutines/Continuation;)V

    .line 326
    .line 327
    .line 328
    iput-object v10, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$0:Ljava/lang/Object;

    .line 329
    .line 330
    iput-object v3, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->L$1:Ljava/lang/Object;

    .line 331
    .line 332
    const/4 v3, 0x3

    .line 333
    iput v3, v8, Lcom/google/firebase/sessions/settings/RemoteSettings$updateSettings$1;->label:I

    .line 334
    .line 335
    new-instance v3, Lcom/google/firebase/sessions/settings/RemoteSettingsFetcher$doConfigFetch$2;

    .line 336
    .line 337
    const/16 v22, 0x0

    .line 338
    .line 339
    move-object/from16 v17, v3

    .line 340
    .line 341
    move-object/from16 v18, v0

    .line 342
    .line 343
    move-object/from16 v20, v2

    .line 344
    .line 345
    move-object/from16 v21, v4

    .line 346
    .line 347
    invoke-direct/range {v17 .. v22}, Lcom/google/firebase/sessions/settings/RemoteSettingsFetcher$doConfigFetch$2;-><init>(Lcom/google/firebase/sessions/settings/b;Ljava/util/Map;Lwakotl/jvm/functions/Function2;Lwakotl/jvm/functions/Function2;Lwakotl/coroutines/Continuation;)V

    .line 348
    .line 349
    .line 350
    iget-object v0, v0, Lcom/google/firebase/sessions/settings/b;->b:Lwakotl/coroutines/CoroutineContext;

    .line 351
    .line 352
    invoke-static {v0, v3, v8}, Lkotlinx/coroutines/g0;->K(Lwakotl/coroutines/CoroutineContext;Lwakotl/jvm/functions/Function2;Lwakotl/coroutines/Continuation;)Ljava/lang/Object;

    .line 353
    .line 354
    .line 355
    move-result-object v0

    .line 356
    invoke-static {}, Lwakotl/coroutines/intrinsics/a;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 357
    .line 358
    .line 359
    move-result-object v2

    .line 360
    if-ne v0, v2, :cond_a

    .line 361
    .line 362
    goto :goto_4

    .line 363
    :cond_a
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 364
    .line 365
    :goto_4
    if-ne v0, v9, :cond_b

    .line 366
    .line 367
    return-object v9

    .line 368
    :cond_b
    move-object v2, v10

    .line 369
    :goto_5
    :try_start_7
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 370
    .line 371
    const/4 v3, 0x0

    .line 372
    invoke-interface {v2, v3}, Lqq/a;->b(Ljava/lang/Object;)V

    .line 373
    .line 374
    .line 375
    sget-object v0, Lwakotl/Unit;->a:Lwakotl/Unit;

    .line 376
    .line 377
    return-object v0

    .line 378
    :catchall_2
    move-exception v0

    .line 379
    :goto_6
    const/4 v3, 0x0

    .line 380
    goto :goto_8

    .line 381
    :goto_7
    move-object v2, v10

    .line 382
    goto :goto_6

    .line 383
    :catchall_3
    move-exception v0

    .line 384
    goto :goto_7

    .line 385
    :goto_8
    invoke-interface {v2, v3}, Lqq/a;->b(Ljava/lang/Object;)V

    .line 386
    .line 387
    .line 388
    throw v0
.end method
