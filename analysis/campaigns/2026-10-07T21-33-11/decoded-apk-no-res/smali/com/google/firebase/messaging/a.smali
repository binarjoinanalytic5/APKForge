.class public final Lcom/google/firebase/messaging/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ldg/c;


# static fields
.field public static final a:Lcom/google/firebase/messaging/a;

.field public static final b:Ldg/b;

.field public static final c:Ldg/b;

.field public static final d:Ldg/b;

.field public static final e:Ldg/b;

.field public static final f:Ldg/b;

.field public static final g:Ldg/b;

.field public static final h:Ldg/b;

.field public static final i:Ldg/b;

.field public static final j:Ldg/b;

.field public static final k:Ldg/b;

.field public static final l:Ldg/b;

.field public static final m:Ldg/b;

.field public static final n:Ldg/b;

.field public static final o:Ldg/b;

.field public static final p:Ldg/b;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 1
    new-instance v0, Lcom/google/firebase/messaging/a;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/google/firebase/messaging/a;->a:Lcom/google/firebase/messaging/a;

    .line 7
    .line 8
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    const/4 v1, 0x1

    .line 13
    iput v1, v0, Landroidx/compose/animation/core/u;->a:I

    .line 14
    .line 15
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 16
    .line 17
    .line 18
    move-result-object v0

    .line 19
    const-class v1, Lgg/c;

    .line 20
    .line 21
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    new-instance v2, Ldg/b;

    .line 26
    .line 27
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 28
    .line 29
    .line 30
    move-result-object v0

    .line 31
    const-string v3, "projectNumber"

    .line 32
    .line 33
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 34
    .line 35
    .line 36
    sput-object v2, Lcom/google/firebase/messaging/a;->b:Ldg/b;

    .line 37
    .line 38
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 39
    .line 40
    .line 41
    move-result-object v0

    .line 42
    const/4 v2, 0x2

    .line 43
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 44
    .line 45
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 46
    .line 47
    .line 48
    move-result-object v0

    .line 49
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 50
    .line 51
    .line 52
    move-result-object v0

    .line 53
    new-instance v2, Ldg/b;

    .line 54
    .line 55
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 56
    .line 57
    .line 58
    move-result-object v0

    .line 59
    const-string v3, "messageId"

    .line 60
    .line 61
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 62
    .line 63
    .line 64
    sput-object v2, Lcom/google/firebase/messaging/a;->c:Ldg/b;

    .line 65
    .line 66
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 67
    .line 68
    .line 69
    move-result-object v0

    .line 70
    const/4 v2, 0x3

    .line 71
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 72
    .line 73
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 74
    .line 75
    .line 76
    move-result-object v0

    .line 77
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 78
    .line 79
    .line 80
    move-result-object v0

    .line 81
    new-instance v2, Ldg/b;

    .line 82
    .line 83
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 84
    .line 85
    .line 86
    move-result-object v0

    .line 87
    const-string v3, "instanceId"

    .line 88
    .line 89
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 90
    .line 91
    .line 92
    sput-object v2, Lcom/google/firebase/messaging/a;->d:Ldg/b;

    .line 93
    .line 94
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 95
    .line 96
    .line 97
    move-result-object v0

    .line 98
    const/4 v2, 0x4

    .line 99
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 100
    .line 101
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 102
    .line 103
    .line 104
    move-result-object v0

    .line 105
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 106
    .line 107
    .line 108
    move-result-object v0

    .line 109
    new-instance v2, Ldg/b;

    .line 110
    .line 111
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 112
    .line 113
    .line 114
    move-result-object v0

    .line 115
    const-string v3, "messageType"

    .line 116
    .line 117
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 118
    .line 119
    .line 120
    sput-object v2, Lcom/google/firebase/messaging/a;->e:Ldg/b;

    .line 121
    .line 122
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 123
    .line 124
    .line 125
    move-result-object v0

    .line 126
    const/4 v2, 0x5

    .line 127
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 128
    .line 129
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 130
    .line 131
    .line 132
    move-result-object v0

    .line 133
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 134
    .line 135
    .line 136
    move-result-object v0

    .line 137
    new-instance v2, Ldg/b;

    .line 138
    .line 139
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 140
    .line 141
    .line 142
    move-result-object v0

    .line 143
    const-string v3, "sdkPlatform"

    .line 144
    .line 145
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 146
    .line 147
    .line 148
    sput-object v2, Lcom/google/firebase/messaging/a;->f:Ldg/b;

    .line 149
    .line 150
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 151
    .line 152
    .line 153
    move-result-object v0

    .line 154
    const/4 v2, 0x6

    .line 155
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 156
    .line 157
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 158
    .line 159
    .line 160
    move-result-object v0

    .line 161
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 162
    .line 163
    .line 164
    move-result-object v0

    .line 165
    new-instance v2, Ldg/b;

    .line 166
    .line 167
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 168
    .line 169
    .line 170
    move-result-object v0

    .line 171
    const-string v3, "packageName"

    .line 172
    .line 173
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 174
    .line 175
    .line 176
    sput-object v2, Lcom/google/firebase/messaging/a;->g:Ldg/b;

    .line 177
    .line 178
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 179
    .line 180
    .line 181
    move-result-object v0

    .line 182
    const/4 v2, 0x7

    .line 183
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 184
    .line 185
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 186
    .line 187
    .line 188
    move-result-object v0

    .line 189
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 190
    .line 191
    .line 192
    move-result-object v0

    .line 193
    new-instance v2, Ldg/b;

    .line 194
    .line 195
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 196
    .line 197
    .line 198
    move-result-object v0

    .line 199
    const-string v3, "collapseKey"

    .line 200
    .line 201
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 202
    .line 203
    .line 204
    sput-object v2, Lcom/google/firebase/messaging/a;->h:Ldg/b;

    .line 205
    .line 206
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 207
    .line 208
    .line 209
    move-result-object v0

    .line 210
    const/16 v2, 0x8

    .line 211
    .line 212
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 213
    .line 214
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 215
    .line 216
    .line 217
    move-result-object v0

    .line 218
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 219
    .line 220
    .line 221
    move-result-object v0

    .line 222
    new-instance v2, Ldg/b;

    .line 223
    .line 224
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 225
    .line 226
    .line 227
    move-result-object v0

    .line 228
    const-string v3, "priority"

    .line 229
    .line 230
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 231
    .line 232
    .line 233
    sput-object v2, Lcom/google/firebase/messaging/a;->i:Ldg/b;

    .line 234
    .line 235
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 236
    .line 237
    .line 238
    move-result-object v0

    .line 239
    const/16 v2, 0x9

    .line 240
    .line 241
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 242
    .line 243
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 244
    .line 245
    .line 246
    move-result-object v0

    .line 247
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 248
    .line 249
    .line 250
    move-result-object v0

    .line 251
    new-instance v2, Ldg/b;

    .line 252
    .line 253
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 254
    .line 255
    .line 256
    move-result-object v0

    .line 257
    const-string v3, "ttl"

    .line 258
    .line 259
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 260
    .line 261
    .line 262
    sput-object v2, Lcom/google/firebase/messaging/a;->j:Ldg/b;

    .line 263
    .line 264
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 265
    .line 266
    .line 267
    move-result-object v0

    .line 268
    const/16 v2, 0xa

    .line 269
    .line 270
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 271
    .line 272
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 273
    .line 274
    .line 275
    move-result-object v0

    .line 276
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 277
    .line 278
    .line 279
    move-result-object v0

    .line 280
    new-instance v2, Ldg/b;

    .line 281
    .line 282
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 283
    .line 284
    .line 285
    move-result-object v0

    .line 286
    const-string v3, "topic"

    .line 287
    .line 288
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 289
    .line 290
    .line 291
    sput-object v2, Lcom/google/firebase/messaging/a;->k:Ldg/b;

    .line 292
    .line 293
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 294
    .line 295
    .line 296
    move-result-object v0

    .line 297
    const/16 v2, 0xb

    .line 298
    .line 299
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 300
    .line 301
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 302
    .line 303
    .line 304
    move-result-object v0

    .line 305
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 306
    .line 307
    .line 308
    move-result-object v0

    .line 309
    new-instance v2, Ldg/b;

    .line 310
    .line 311
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 312
    .line 313
    .line 314
    move-result-object v0

    .line 315
    const-string v3, "bulkId"

    .line 316
    .line 317
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 318
    .line 319
    .line 320
    sput-object v2, Lcom/google/firebase/messaging/a;->l:Ldg/b;

    .line 321
    .line 322
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 323
    .line 324
    .line 325
    move-result-object v0

    .line 326
    const/16 v2, 0xc

    .line 327
    .line 328
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 329
    .line 330
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 331
    .line 332
    .line 333
    move-result-object v0

    .line 334
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 335
    .line 336
    .line 337
    move-result-object v0

    .line 338
    new-instance v2, Ldg/b;

    .line 339
    .line 340
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 341
    .line 342
    .line 343
    move-result-object v0

    .line 344
    const-string v3, "event"

    .line 345
    .line 346
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 347
    .line 348
    .line 349
    sput-object v2, Lcom/google/firebase/messaging/a;->m:Ldg/b;

    .line 350
    .line 351
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 352
    .line 353
    .line 354
    move-result-object v0

    .line 355
    const/16 v2, 0xd

    .line 356
    .line 357
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 358
    .line 359
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 360
    .line 361
    .line 362
    move-result-object v0

    .line 363
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 364
    .line 365
    .line 366
    move-result-object v0

    .line 367
    new-instance v2, Ldg/b;

    .line 368
    .line 369
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 370
    .line 371
    .line 372
    move-result-object v0

    .line 373
    const-string v3, "analyticsLabel"

    .line 374
    .line 375
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 376
    .line 377
    .line 378
    sput-object v2, Lcom/google/firebase/messaging/a;->n:Ldg/b;

    .line 379
    .line 380
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 381
    .line 382
    .line 383
    move-result-object v0

    .line 384
    const/16 v2, 0xe

    .line 385
    .line 386
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 387
    .line 388
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 389
    .line 390
    .line 391
    move-result-object v0

    .line 392
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 393
    .line 394
    .line 395
    move-result-object v0

    .line 396
    new-instance v2, Ldg/b;

    .line 397
    .line 398
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 399
    .line 400
    .line 401
    move-result-object v0

    .line 402
    const-string v3, "campaignId"

    .line 403
    .line 404
    invoke-direct {v2, v3, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 405
    .line 406
    .line 407
    sput-object v2, Lcom/google/firebase/messaging/a;->o:Ldg/b;

    .line 408
    .line 409
    invoke-static {}, Landroidx/compose/animation/core/u;->n()Landroidx/compose/animation/core/u;

    .line 410
    .line 411
    .line 412
    move-result-object v0

    .line 413
    const/16 v2, 0xf

    .line 414
    .line 415
    iput v2, v0, Landroidx/compose/animation/core/u;->a:I

    .line 416
    .line 417
    invoke-virtual {v0}, Landroidx/compose/animation/core/u;->m()Lgg/a;

    .line 418
    .line 419
    .line 420
    move-result-object v0

    .line 421
    invoke-static {v1, v0}, Lcom/mbridge/msdk/advanced/manager/e;->z(Ljava/lang/Class;Lgg/a;)Ljava/util/HashMap;

    .line 422
    .line 423
    .line 424
    move-result-object v0

    .line 425
    new-instance v1, Ldg/b;

    .line 426
    .line 427
    invoke-static {v0}, Lcom/mbridge/msdk/advanced/manager/e;->A(Ljava/util/HashMap;)Ljava/util/Map;

    .line 428
    .line 429
    .line 430
    move-result-object v0

    .line 431
    const-string v2, "composerLabel"

    .line 432
    .line 433
    invoke-direct {v1, v2, v0}, Ldg/b;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    .line 434
    .line 435
    .line 436
    sput-object v1, Lcom/google/firebase/messaging/a;->p:Ldg/b;

    .line 437
    .line 438
    return-void
.end method


# virtual methods
.method public final a(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 4

    .line 1
    check-cast p1, Lrg/b;

    .line 2
    .line 3
    check-cast p2, Ldg/d;

    .line 4
    .line 5
    iget-wide v0, p1, Lrg/b;->a:J

    .line 6
    .line 7
    sget-object v2, Lcom/google/firebase/messaging/a;->b:Ldg/b;

    .line 8
    .line 9
    invoke-interface {p2, v2, v0, v1}, Ldg/d;->c(Ldg/b;J)Ldg/d;

    .line 10
    .line 11
    .line 12
    iget-object v0, p1, Lrg/b;->b:Ljava/lang/String;

    .line 13
    .line 14
    sget-object v1, Lcom/google/firebase/messaging/a;->c:Ldg/b;

    .line 15
    .line 16
    invoke-interface {p2, v1, v0}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 17
    .line 18
    .line 19
    sget-object v0, Lcom/google/firebase/messaging/a;->d:Ldg/b;

    .line 20
    .line 21
    iget-object v1, p1, Lrg/b;->c:Ljava/lang/String;

    .line 22
    .line 23
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 24
    .line 25
    .line 26
    sget-object v0, Lcom/google/firebase/messaging/a;->e:Ldg/b;

    .line 27
    .line 28
    iget-object v1, p1, Lrg/b;->d:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;

    .line 29
    .line 30
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 31
    .line 32
    .line 33
    sget-object v0, Lcom/google/firebase/messaging/a;->f:Ldg/b;

    .line 34
    .line 35
    iget-object v1, p1, Lrg/b;->e:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$SDKPlatform;

    .line 36
    .line 37
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 38
    .line 39
    .line 40
    sget-object v0, Lcom/google/firebase/messaging/a;->g:Ldg/b;

    .line 41
    .line 42
    iget-object v1, p1, Lrg/b;->f:Ljava/lang/String;

    .line 43
    .line 44
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 45
    .line 46
    .line 47
    sget-object v0, Lcom/google/firebase/messaging/a;->h:Ldg/b;

    .line 48
    .line 49
    iget-object v1, p1, Lrg/b;->g:Ljava/lang/String;

    .line 50
    .line 51
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 52
    .line 53
    .line 54
    sget-object v0, Lcom/google/firebase/messaging/a;->i:Ldg/b;

    .line 55
    .line 56
    iget v1, p1, Lrg/b;->h:I

    .line 57
    .line 58
    invoke-interface {p2, v0, v1}, Ldg/d;->d(Ldg/b;I)Ldg/d;

    .line 59
    .line 60
    .line 61
    sget-object v0, Lcom/google/firebase/messaging/a;->j:Ldg/b;

    .line 62
    .line 63
    iget v1, p1, Lrg/b;->i:I

    .line 64
    .line 65
    invoke-interface {p2, v0, v1}, Ldg/d;->d(Ldg/b;I)Ldg/d;

    .line 66
    .line 67
    .line 68
    sget-object v0, Lcom/google/firebase/messaging/a;->k:Ldg/b;

    .line 69
    .line 70
    iget-object v1, p1, Lrg/b;->j:Ljava/lang/String;

    .line 71
    .line 72
    invoke-interface {p2, v0, v1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 73
    .line 74
    .line 75
    sget-object v0, Lcom/google/firebase/messaging/a;->l:Ldg/b;

    .line 76
    .line 77
    const-wide/16 v1, 0x0

    .line 78
    .line 79
    invoke-interface {p2, v0, v1, v2}, Ldg/d;->c(Ldg/b;J)Ldg/d;

    .line 80
    .line 81
    .line 82
    sget-object v0, Lcom/google/firebase/messaging/a;->m:Ldg/b;

    .line 83
    .line 84
    iget-object v3, p1, Lrg/b;->k:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;

    .line 85
    .line 86
    invoke-interface {p2, v0, v3}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 87
    .line 88
    .line 89
    sget-object v0, Lcom/google/firebase/messaging/a;->n:Ldg/b;

    .line 90
    .line 91
    iget-object v3, p1, Lrg/b;->l:Ljava/lang/String;

    .line 92
    .line 93
    invoke-interface {p2, v0, v3}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 94
    .line 95
    .line 96
    sget-object v0, Lcom/google/firebase/messaging/a;->o:Ldg/b;

    .line 97
    .line 98
    invoke-interface {p2, v0, v1, v2}, Ldg/d;->c(Ldg/b;J)Ldg/d;

    .line 99
    .line 100
    .line 101
    sget-object v0, Lcom/google/firebase/messaging/a;->p:Ldg/b;

    .line 102
    .line 103
    iget-object p1, p1, Lrg/b;->m:Ljava/lang/String;

    .line 104
    .line 105
    invoke-interface {p2, v0, p1}, Ldg/d;->a(Ldg/b;Ljava/lang/Object;)Ldg/d;

    .line 106
    .line 107
    .line 108
    return-void
.end method
