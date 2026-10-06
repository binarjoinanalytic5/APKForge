.class public final Landroidx/constraintlayout/motion/widget/c;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Landroidx/constraintlayout/motion/widget/MotionLayout;

.field public final b:Landroidx/compose/animation/core/u;

.field public c:Lh1/x;

.field public final d:Ljava/util/ArrayList;

.field public final e:Lh1/x;

.field public final f:Ljava/util/ArrayList;

.field public final g:Landroid/util/SparseArray;

.field public final h:Ljava/util/HashMap;

.field public final i:Landroid/util/SparseIntArray;

.field public j:I

.field public k:I

.field public l:Landroid/view/MotionEvent;

.field public m:Z

.field public n:Z

.field public o:Lh1/t;

.field public p:Z

.field public final q:Las/c;

.field public r:F

.field public s:F


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroidx/constraintlayout/motion/widget/MotionLayout;I)V
    .locals 11

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    const/4 v0, 0x0

    .line 5
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 6
    .line 7
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 8
    .line 9
    new-instance v1, Ljava/util/ArrayList;

    .line 10
    .line 11
    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 12
    .line 13
    .line 14
    iput-object v1, p0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 15
    .line 16
    iput-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->e:Lh1/x;

    .line 17
    .line 18
    new-instance v2, Ljava/util/ArrayList;

    .line 19
    .line 20
    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 21
    .line 22
    .line 23
    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->f:Ljava/util/ArrayList;

    .line 24
    .line 25
    new-instance v2, Landroid/util/SparseArray;

    .line 26
    .line 27
    invoke-direct {v2}, Landroid/util/SparseArray;-><init>()V

    .line 28
    .line 29
    .line 30
    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 31
    .line 32
    new-instance v2, Ljava/util/HashMap;

    .line 33
    .line 34
    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 35
    .line 36
    .line 37
    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->h:Ljava/util/HashMap;

    .line 38
    .line 39
    new-instance v2, Landroid/util/SparseIntArray;

    .line 40
    .line 41
    invoke-direct {v2}, Landroid/util/SparseIntArray;-><init>()V

    .line 42
    .line 43
    .line 44
    iput-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->i:Landroid/util/SparseIntArray;

    .line 45
    .line 46
    const/16 v2, 0x190

    .line 47
    .line 48
    iput v2, p0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 49
    .line 50
    const/4 v2, 0x0

    .line 51
    iput v2, p0, Landroidx/constraintlayout/motion/widget/c;->k:I

    .line 52
    .line 53
    iput-boolean v2, p0, Landroidx/constraintlayout/motion/widget/c;->m:Z

    .line 54
    .line 55
    iput-boolean v2, p0, Landroidx/constraintlayout/motion/widget/c;->n:Z

    .line 56
    .line 57
    iput-object p2, p0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 58
    .line 59
    new-instance v3, Las/c;

    .line 60
    .line 61
    invoke-direct {v3, p2}, Las/c;-><init>(Landroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 62
    .line 63
    .line 64
    iput-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->q:Las/c;

    .line 65
    .line 66
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 67
    .line 68
    .line 69
    move-result-object p2

    .line 70
    invoke-virtual {p2, p3}, Landroid/content/res/Resources;->getXml(I)Landroid/content/res/XmlResourceParser;

    .line 71
    .line 72
    .line 73
    move-result-object p2

    .line 74
    :try_start_0
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    .line 75
    .line 76
    .line 77
    move-result v3

    .line 78
    move-object v4, v0

    .line 79
    :goto_0
    const/4 v5, 0x1

    .line 80
    if-eq v3, v5, :cond_8

    .line 81
    .line 82
    if-eqz v3, :cond_6

    .line 83
    .line 84
    const/4 v6, 0x2

    .line 85
    if-eq v3, v6, :cond_0

    .line 86
    .line 87
    goto/16 :goto_4

    .line 88
    .line 89
    :cond_0
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    .line 90
    .line 91
    .line 92
    move-result-object v3

    .line 93
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    .line 94
    .line 95
    .line 96
    move-result v7

    .line 97
    const/4 v8, 0x5

    .line 98
    const/4 v9, 0x4

    .line 99
    const/4 v10, -0x1

    .line 100
    sparse-switch v7, :sswitch_data_0

    .line 101
    .line 102
    .line 103
    goto/16 :goto_1

    .line 104
    .line 105
    :sswitch_0
    const-string v5, "include"

    .line 106
    .line 107
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 108
    .line 109
    .line 110
    move-result v3

    .line 111
    if-eqz v3, :cond_1

    .line 112
    .line 113
    const/4 v5, 0x6

    .line 114
    goto/16 :goto_2

    .line 115
    .line 116
    :catch_0
    move-exception p1

    .line 117
    goto/16 :goto_5

    .line 118
    .line 119
    :catch_1
    move-exception p1

    .line 120
    goto/16 :goto_6

    .line 121
    .line 122
    :sswitch_1
    const-string v5, "StateSet"

    .line 123
    .line 124
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 125
    .line 126
    .line 127
    move-result v3

    .line 128
    if-eqz v3, :cond_1

    .line 129
    .line 130
    move v5, v9

    .line 131
    goto :goto_2

    .line 132
    :sswitch_2
    const-string v5, "MotionScene"

    .line 133
    .line 134
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 135
    .line 136
    .line 137
    move-result v3

    .line 138
    if-eqz v3, :cond_1

    .line 139
    .line 140
    move v5, v2

    .line 141
    goto :goto_2

    .line 142
    :sswitch_3
    const-string v5, "OnSwipe"

    .line 143
    .line 144
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 145
    .line 146
    .line 147
    move-result v3

    .line 148
    if-eqz v3, :cond_1

    .line 149
    .line 150
    move v5, v6

    .line 151
    goto :goto_2

    .line 152
    :sswitch_4
    const-string v5, "OnClick"

    .line 153
    .line 154
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 155
    .line 156
    .line 157
    move-result v3

    .line 158
    if-eqz v3, :cond_1

    .line 159
    .line 160
    const/4 v5, 0x3

    .line 161
    goto :goto_2

    .line 162
    :sswitch_5
    const-string v6, "Transition"

    .line 163
    .line 164
    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 165
    .line 166
    .line 167
    move-result v3

    .line 168
    if-eqz v3, :cond_1

    .line 169
    .line 170
    goto :goto_2

    .line 171
    :sswitch_6
    const-string v5, "ViewTransition"

    .line 172
    .line 173
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 174
    .line 175
    .line 176
    move-result v3

    .line 177
    if-eqz v3, :cond_1

    .line 178
    .line 179
    const/16 v5, 0x9

    .line 180
    .line 181
    goto :goto_2

    .line 182
    :sswitch_7
    const-string v5, "Include"

    .line 183
    .line 184
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 185
    .line 186
    .line 187
    move-result v3

    .line 188
    if-eqz v3, :cond_1

    .line 189
    .line 190
    const/4 v5, 0x7

    .line 191
    goto :goto_2

    .line 192
    :sswitch_8
    const-string v5, "KeyFrameSet"

    .line 193
    .line 194
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 195
    .line 196
    .line 197
    move-result v3

    .line 198
    if-eqz v3, :cond_1

    .line 199
    .line 200
    const/16 v5, 0x8

    .line 201
    .line 202
    goto :goto_2

    .line 203
    :sswitch_9
    const-string v5, "ConstraintSet"

    .line 204
    .line 205
    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 206
    .line 207
    .line 208
    move-result v3

    .line 209
    if-eqz v3, :cond_1

    .line 210
    .line 211
    move v5, v8

    .line 212
    goto :goto_2

    .line 213
    :cond_1
    :goto_1
    move v5, v10

    .line 214
    :goto_2
    packed-switch v5, :pswitch_data_0

    .line 215
    .line 216
    .line 217
    goto/16 :goto_4

    .line 218
    .line 219
    :pswitch_0
    new-instance v3, Lh1/a0;

    .line 220
    .line 221
    invoke-direct {v3, p1, p2}, Lh1/a0;-><init>(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 222
    .line 223
    .line 224
    iget-object v5, p0, Landroidx/constraintlayout/motion/widget/c;->q:Las/c;

    .line 225
    .line 226
    iget-object v6, v5, Las/c;->c:Ljava/lang/Object;

    .line 227
    .line 228
    check-cast v6, Ljava/util/ArrayList;

    .line 229
    .line 230
    invoke-virtual {v6, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 231
    .line 232
    .line 233
    iput-object v0, v5, Las/c;->d:Ljava/lang/Object;

    .line 234
    .line 235
    iget v5, v3, Lh1/a0;->b:I

    .line 236
    .line 237
    if-ne v5, v9, :cond_2

    .line 238
    .line 239
    invoke-static {}, Landroidx/constraintlayout/widget/ConstraintLayout;->getSharedValues()Lj1/o;

    .line 240
    .line 241
    .line 242
    move-result-object v5

    .line 243
    iget v3, v3, Lh1/a0;->u:I

    .line 244
    .line 245
    new-instance v6, Lh1/b0;

    .line 246
    .line 247
    invoke-direct {v6}, Ljava/lang/Object;-><init>()V

    .line 248
    .line 249
    .line 250
    invoke-virtual {v5, v3, v6}, Lj1/o;->a(ILj1/n;)V

    .line 251
    .line 252
    .line 253
    goto/16 :goto_4

    .line 254
    .line 255
    :cond_2
    if-ne v5, v8, :cond_7

    .line 256
    .line 257
    invoke-static {}, Landroidx/constraintlayout/widget/ConstraintLayout;->getSharedValues()Lj1/o;

    .line 258
    .line 259
    .line 260
    move-result-object v5

    .line 261
    iget v3, v3, Lh1/a0;->u:I

    .line 262
    .line 263
    new-instance v6, Lh1/b0;

    .line 264
    .line 265
    invoke-direct {v6}, Ljava/lang/Object;-><init>()V

    .line 266
    .line 267
    .line 268
    invoke-virtual {v5, v3, v6}, Lj1/o;->a(ILj1/n;)V

    .line 269
    .line 270
    .line 271
    goto/16 :goto_4

    .line 272
    .line 273
    :pswitch_1
    new-instance v3, Lh1/g;

    .line 274
    .line 275
    invoke-direct {v3, p1, p2}, Lh1/g;-><init>(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 276
    .line 277
    .line 278
    if-eqz v4, :cond_7

    .line 279
    .line 280
    iget-object v5, v4, Lh1/x;->k:Ljava/util/ArrayList;

    .line 281
    .line 282
    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 283
    .line 284
    .line 285
    goto/16 :goto_4

    .line 286
    .line 287
    :pswitch_2
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->k(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 288
    .line 289
    .line 290
    goto/16 :goto_4

    .line 291
    .line 292
    :pswitch_3
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->i(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)I

    .line 293
    .line 294
    .line 295
    goto :goto_4

    .line 296
    :pswitch_4
    new-instance v3, Landroidx/compose/animation/core/u;

    .line 297
    .line 298
    invoke-direct {v3, p1, p2}, Landroidx/compose/animation/core/u;-><init>(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 299
    .line 300
    .line 301
    iput-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 302
    .line 303
    goto :goto_4

    .line 304
    :pswitch_5
    if-eqz v4, :cond_7

    .line 305
    .line 306
    new-instance v3, Lh1/w;

    .line 307
    .line 308
    invoke-direct {v3, p1, v4, p2}, Lh1/w;-><init>(Landroid/content/Context;Lh1/x;Landroid/content/res/XmlResourceParser;)V

    .line 309
    .line 310
    .line 311
    iget-object v5, v4, Lh1/x;->m:Ljava/util/ArrayList;

    .line 312
    .line 313
    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 314
    .line 315
    .line 316
    goto :goto_4

    .line 317
    :pswitch_6
    if-nez v4, :cond_3

    .line 318
    .line 319
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 320
    .line 321
    .line 322
    move-result-object v3

    .line 323
    invoke-virtual {v3, p3}, Landroid/content/res/Resources;->getResourceEntryName(I)Ljava/lang/String;

    .line 324
    .line 325
    .line 326
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getLineNumber()I

    .line 327
    .line 328
    .line 329
    :cond_3
    if-eqz v4, :cond_7

    .line 330
    .line 331
    new-instance v3, Landroidx/constraintlayout/motion/widget/d;

    .line 332
    .line 333
    iget-object v5, p0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 334
    .line 335
    invoke-direct {v3, p1, v5, p2}, Landroidx/constraintlayout/motion/widget/d;-><init>(Landroid/content/Context;Landroidx/constraintlayout/motion/widget/MotionLayout;Landroid/content/res/XmlResourceParser;)V

    .line 336
    .line 337
    .line 338
    iput-object v3, v4, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 339
    .line 340
    goto :goto_4

    .line 341
    :pswitch_7
    new-instance v4, Lh1/x;

    .line 342
    .line 343
    invoke-direct {v4, p0, p1, p2}, Lh1/x;-><init>(Landroidx/constraintlayout/motion/widget/c;Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 344
    .line 345
    .line 346
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 347
    .line 348
    .line 349
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 350
    .line 351
    if-nez v3, :cond_4

    .line 352
    .line 353
    iget-boolean v3, v4, Lh1/x;->b:Z

    .line 354
    .line 355
    if-nez v3, :cond_4

    .line 356
    .line 357
    iput-object v4, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 358
    .line 359
    iget-object v3, v4, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 360
    .line 361
    if-eqz v3, :cond_4

    .line 362
    .line 363
    iget-boolean v5, p0, Landroidx/constraintlayout/motion/widget/c;->p:Z

    .line 364
    .line 365
    invoke-virtual {v3, v5}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 366
    .line 367
    .line 368
    :cond_4
    iget-boolean v3, v4, Lh1/x;->b:Z

    .line 369
    .line 370
    if-eqz v3, :cond_7

    .line 371
    .line 372
    iget v3, v4, Lh1/x;->c:I

    .line 373
    .line 374
    if-ne v3, v10, :cond_5

    .line 375
    .line 376
    iput-object v4, p0, Landroidx/constraintlayout/motion/widget/c;->e:Lh1/x;

    .line 377
    .line 378
    goto :goto_3

    .line 379
    :cond_5
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->f:Ljava/util/ArrayList;

    .line 380
    .line 381
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 382
    .line 383
    .line 384
    :goto_3
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 385
    .line 386
    .line 387
    goto :goto_4

    .line 388
    :pswitch_8
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->l(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 389
    .line 390
    .line 391
    goto :goto_4

    .line 392
    :cond_6
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    .line 393
    .line 394
    .line 395
    :cond_7
    :goto_4
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    .line 396
    .line 397
    .line 398
    move-result v3
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 399
    goto/16 :goto_0

    .line 400
    .line 401
    :goto_5
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 402
    .line 403
    .line 404
    goto :goto_7

    .line 405
    :goto_6
    invoke-virtual {p1}, Lorg/xmlpull/v1/XmlPullParserException;->printStackTrace()V

    .line 406
    .line 407
    .line 408
    :cond_8
    :goto_7
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 409
    .line 410
    new-instance p2, Landroidx/constraintlayout/widget/d;

    .line 411
    .line 412
    invoke-direct {p2}, Landroidx/constraintlayout/widget/d;-><init>()V

    .line 413
    .line 414
    .line 415
    const p3, 0x7f0a05e8

    .line 416
    .line 417
    .line 418
    invoke-virtual {p1, p3, p2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 419
    .line 420
    .line 421
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/c;->h:Ljava/util/HashMap;

    .line 422
    .line 423
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 424
    .line 425
    .line 426
    move-result-object p2

    .line 427
    const-string p3, "motion_base"

    .line 428
    .line 429
    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 430
    .line 431
    .line 432
    return-void

    .line 433
    :sswitch_data_0
    .sparse-switch
        -0x50764adb -> :sswitch_9
        -0x49df9cec -> :sswitch_8
        -0x28fe1378 -> :sswitch_7
        0x3b205fa -> :sswitch_6
        0x100d4975 -> :sswitch_5
        0x12a432c9 -> :sswitch_4
        0x138aac7b -> :sswitch_3
        0x2f487256 -> :sswitch_2
        0x526c4e31 -> :sswitch_1
        0x73c954a8 -> :sswitch_0
    .end sparse-switch

    .line 434
    .line 435
    .line 436
    .line 437
    .line 438
    .line 439
    .line 440
    .line 441
    .line 442
    .line 443
    .line 444
    .line 445
    .line 446
    .line 447
    .line 448
    .line 449
    .line 450
    .line 451
    .line 452
    .line 453
    .line 454
    .line 455
    .line 456
    .line 457
    .line 458
    .line 459
    .line 460
    .line 461
    .line 462
    .line 463
    .line 464
    .line 465
    .line 466
    .line 467
    .line 468
    .line 469
    .line 470
    .line 471
    .line 472
    .line 473
    .line 474
    .line 475
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public final a(ILandroidx/constraintlayout/motion/widget/MotionLayout;)Z
    .locals 7

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->o:Lh1/t;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    if-eqz v0, :cond_0

    .line 5
    .line 6
    return v1

    .line 7
    :cond_0
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 8
    .line 9
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 10
    .line 11
    .line 12
    move-result-object v0

    .line 13
    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 14
    .line 15
    .line 16
    move-result v2

    .line 17
    if-eqz v2, :cond_9

    .line 18
    .line 19
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 20
    .line 21
    .line 22
    move-result-object v2

    .line 23
    check-cast v2, Lh1/x;

    .line 24
    .line 25
    iget v3, v2, Lh1/x;->n:I

    .line 26
    .line 27
    if-nez v3, :cond_2

    .line 28
    .line 29
    goto :goto_0

    .line 30
    :cond_2
    iget-object v4, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 31
    .line 32
    const/4 v5, 0x2

    .line 33
    if-ne v4, v2, :cond_3

    .line 34
    .line 35
    iget v4, v4, Lh1/x;->r:I

    .line 36
    .line 37
    and-int/2addr v4, v5

    .line 38
    if-eqz v4, :cond_3

    .line 39
    .line 40
    goto :goto_0

    .line 41
    :cond_3
    iget v4, v2, Lh1/x;->d:I

    .line 42
    .line 43
    const/4 v6, 0x1

    .line 44
    if-ne p1, v4, :cond_6

    .line 45
    .line 46
    const/4 v4, 0x4

    .line 47
    if-eq v3, v4, :cond_4

    .line 48
    .line 49
    if-ne v3, v5, :cond_6

    .line 50
    .line 51
    :cond_4
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 52
    .line 53
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 54
    .line 55
    .line 56
    invoke-virtual {p2, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setTransition(Lh1/x;)V

    .line 57
    .line 58
    .line 59
    iget v0, v2, Lh1/x;->n:I

    .line 60
    .line 61
    if-ne v0, v4, :cond_5

    .line 62
    .line 63
    invoke-virtual {p2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->H()V

    .line 64
    .line 65
    .line 66
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 67
    .line 68
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 69
    .line 70
    .line 71
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 72
    .line 73
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 74
    .line 75
    .line 76
    goto :goto_1

    .line 77
    :cond_5
    const/high16 v0, 0x3f800000    # 1.0f

    .line 78
    .line 79
    invoke-virtual {p2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 80
    .line 81
    .line 82
    invoke-virtual {p2, v6}, Landroidx/constraintlayout/motion/widget/MotionLayout;->t(Z)V

    .line 83
    .line 84
    .line 85
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 86
    .line 87
    invoke-virtual {p2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 88
    .line 89
    .line 90
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 91
    .line 92
    invoke-virtual {p2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 93
    .line 94
    .line 95
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 96
    .line 97
    .line 98
    invoke-virtual {p2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->A()V

    .line 99
    .line 100
    .line 101
    :goto_1
    return v6

    .line 102
    :cond_6
    iget v4, v2, Lh1/x;->c:I

    .line 103
    .line 104
    if-ne p1, v4, :cond_1

    .line 105
    .line 106
    const/4 v4, 0x3

    .line 107
    if-eq v3, v4, :cond_7

    .line 108
    .line 109
    if-ne v3, v6, :cond_1

    .line 110
    .line 111
    :cond_7
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->FINISHED:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 112
    .line 113
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 114
    .line 115
    .line 116
    invoke-virtual {p2, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setTransition(Lh1/x;)V

    .line 117
    .line 118
    .line 119
    iget v0, v2, Lh1/x;->n:I

    .line 120
    .line 121
    const/4 v1, 0x0

    .line 122
    if-ne v0, v4, :cond_8

    .line 123
    .line 124
    invoke-virtual {p2, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->r(F)V

    .line 125
    .line 126
    .line 127
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 128
    .line 129
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 130
    .line 131
    .line 132
    sget-object p1, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 133
    .line 134
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 135
    .line 136
    .line 137
    goto :goto_2

    .line 138
    :cond_8
    invoke-virtual {p2, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setProgress(F)V

    .line 139
    .line 140
    .line 141
    invoke-virtual {p2, v6}, Landroidx/constraintlayout/motion/widget/MotionLayout;->t(Z)V

    .line 142
    .line 143
    .line 144
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->SETUP:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 145
    .line 146
    invoke-virtual {p2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 147
    .line 148
    .line 149
    sget-object v0, Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;->MOVING:Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;

    .line 150
    .line 151
    invoke-virtual {p2, v0}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 152
    .line 153
    .line 154
    invoke-virtual {p2, p1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->setState(Landroidx/constraintlayout/motion/widget/MotionLayout$TransitionState;)V

    .line 155
    .line 156
    .line 157
    invoke-virtual {p2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->A()V

    .line 158
    .line 159
    .line 160
    :goto_2
    return v6

    .line 161
    :cond_9
    return v1
.end method

.method public final b(I)Landroidx/constraintlayout/widget/d;
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 2
    .line 3
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 4
    .line 5
    if-eqz v1, :cond_0

    .line 6
    .line 7
    invoke-virtual {v1, p1}, Landroidx/compose/animation/core/u;->t(I)I

    .line 8
    .line 9
    .line 10
    move-result v1

    .line 11
    const/4 v2, -0x1

    .line 12
    if-eq v1, v2, :cond_0

    .line 13
    .line 14
    move p1, v1

    .line 15
    :cond_0
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 16
    .line 17
    .line 18
    move-result-object v1

    .line 19
    if-nez v1, :cond_1

    .line 20
    .line 21
    new-instance v1, Ljava/lang/StringBuilder;

    .line 22
    .line 23
    const-string v2, "Warning could not find ConstraintSet id/"

    .line 24
    .line 25
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 26
    .line 27
    .line 28
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 29
    .line 30
    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 31
    .line 32
    .line 33
    move-result-object v2

    .line 34
    invoke-static {v2, p1}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 35
    .line 36
    .line 37
    move-result-object p1

    .line 38
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 39
    .line 40
    .line 41
    const-string p1, " In MotionScene"

    .line 42
    .line 43
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 44
    .line 45
    .line 46
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 47
    .line 48
    .line 49
    move-result-object p1

    .line 50
    const-string v1, "MotionScene"

    .line 51
    .line 52
    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    .line 54
    .line 55
    const/4 p1, 0x0

    .line 56
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->keyAt(I)I

    .line 57
    .line 58
    .line 59
    move-result p1

    .line 60
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 61
    .line 62
    .line 63
    move-result-object p1

    .line 64
    check-cast p1, Landroidx/constraintlayout/widget/d;

    .line 65
    .line 66
    goto :goto_0

    .line 67
    :cond_1
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 68
    .line 69
    .line 70
    move-result-object p1

    .line 71
    check-cast p1, Landroidx/constraintlayout/widget/d;

    .line 72
    .line 73
    :goto_0
    return-object p1
.end method

.method public final c()I
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    iget v0, v0, Lh1/x;->h:I

    .line 6
    .line 7
    return v0

    .line 8
    :cond_0
    iget v0, p0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 9
    .line 10
    return v0
.end method

.method public final d(Landroid/content/Context;Ljava/lang/String;)I
    .locals 5

    .line 1
    const-string v0, "/"

    .line 2
    .line 3
    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    .line 4
    .line 5
    .line 6
    move-result v0

    .line 7
    const/4 v1, 0x1

    .line 8
    const/4 v2, -0x1

    .line 9
    if-eqz v0, :cond_0

    .line 10
    .line 11
    const/16 v0, 0x2f

    .line 12
    .line 13
    invoke-virtual {p2, v0}, Ljava/lang/String;->indexOf(I)I

    .line 14
    .line 15
    .line 16
    move-result v0

    .line 17
    add-int/2addr v0, v1

    .line 18
    invoke-virtual {p2, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 19
    .line 20
    .line 21
    move-result-object v0

    .line 22
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 23
    .line 24
    .line 25
    move-result-object v3

    .line 26
    const-string v4, "id"

    .line 27
    .line 28
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    .line 29
    .line 30
    .line 31
    move-result-object p1

    .line 32
    invoke-virtual {v3, v0, v4, p1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    .line 33
    .line 34
    .line 35
    move-result p1

    .line 36
    goto :goto_0

    .line 37
    :cond_0
    move p1, v2

    .line 38
    :goto_0
    if-ne p1, v2, :cond_2

    .line 39
    .line 40
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    .line 41
    .line 42
    .line 43
    move-result v0

    .line 44
    if-le v0, v1, :cond_1

    .line 45
    .line 46
    invoke-virtual {p2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 47
    .line 48
    .line 49
    move-result-object p1

    .line 50
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 51
    .line 52
    .line 53
    move-result p1

    .line 54
    goto :goto_1

    .line 55
    :cond_1
    const-string p2, "MotionScene"

    .line 56
    .line 57
    const-string v0, "error in parsing id"

    .line 58
    .line 59
    invoke-static {p2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 60
    .line 61
    .line 62
    :cond_2
    :goto_1
    return p1
.end method

.method public final e()Landroid/view/animation/Interpolator;
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2
    .line 3
    iget v1, v0, Lh1/x;->e:I

    .line 4
    .line 5
    const/4 v2, -0x2

    .line 6
    if-eq v1, v2, :cond_7

    .line 7
    .line 8
    const/4 v2, -0x1

    .line 9
    if-eq v1, v2, :cond_6

    .line 10
    .line 11
    if-eqz v1, :cond_5

    .line 12
    .line 13
    const/4 v0, 0x1

    .line 14
    if-eq v1, v0, :cond_4

    .line 15
    .line 16
    const/4 v0, 0x2

    .line 17
    if-eq v1, v0, :cond_3

    .line 18
    .line 19
    const/4 v0, 0x4

    .line 20
    if-eq v1, v0, :cond_2

    .line 21
    .line 22
    const/4 v0, 0x5

    .line 23
    if-eq v1, v0, :cond_1

    .line 24
    .line 25
    const/4 v0, 0x6

    .line 26
    if-eq v1, v0, :cond_0

    .line 27
    .line 28
    const/4 v0, 0x0

    .line 29
    return-object v0

    .line 30
    :cond_0
    new-instance v0, Landroid/view/animation/AnticipateInterpolator;

    .line 31
    .line 32
    invoke-direct {v0}, Landroid/view/animation/AnticipateInterpolator;-><init>()V

    .line 33
    .line 34
    .line 35
    return-object v0

    .line 36
    :cond_1
    new-instance v0, Landroid/view/animation/OvershootInterpolator;

    .line 37
    .line 38
    invoke-direct {v0}, Landroid/view/animation/OvershootInterpolator;-><init>()V

    .line 39
    .line 40
    .line 41
    return-object v0

    .line 42
    :cond_2
    new-instance v0, Landroid/view/animation/BounceInterpolator;

    .line 43
    .line 44
    invoke-direct {v0}, Landroid/view/animation/BounceInterpolator;-><init>()V

    .line 45
    .line 46
    .line 47
    return-object v0

    .line 48
    :cond_3
    new-instance v0, Landroid/view/animation/DecelerateInterpolator;

    .line 49
    .line 50
    invoke-direct {v0}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    .line 51
    .line 52
    .line 53
    return-object v0

    .line 54
    :cond_4
    new-instance v0, Landroid/view/animation/AccelerateInterpolator;

    .line 55
    .line 56
    invoke-direct {v0}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    .line 57
    .line 58
    .line 59
    return-object v0

    .line 60
    :cond_5
    new-instance v0, Landroid/view/animation/AccelerateDecelerateInterpolator;

    .line 61
    .line 62
    invoke-direct {v0}, Landroid/view/animation/AccelerateDecelerateInterpolator;-><init>()V

    .line 63
    .line 64
    .line 65
    return-object v0

    .line 66
    :cond_6
    iget-object v0, v0, Lh1/x;->f:Ljava/lang/String;

    .line 67
    .line 68
    invoke-static {v0}, Lb1/e;->d(Ljava/lang/String;)Lb1/e;

    .line 69
    .line 70
    .line 71
    move-result-object v0

    .line 72
    new-instance v1, Lh1/m;

    .line 73
    .line 74
    const/4 v2, 0x1

    .line 75
    invoke-direct {v1, v0, v2}, Lh1/m;-><init>(Lb1/e;I)V

    .line 76
    .line 77
    .line 78
    return-object v1

    .line 79
    :cond_7
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 80
    .line 81
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 82
    .line 83
    .line 84
    move-result-object v0

    .line 85
    iget-object v1, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 86
    .line 87
    iget v1, v1, Lh1/x;->g:I

    .line 88
    .line 89
    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadInterpolator(Landroid/content/Context;I)Landroid/view/animation/Interpolator;

    .line 90
    .line 91
    .line 92
    move-result-object v0

    .line 93
    return-object v0
.end method

.method public final f(Lh1/n;)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2
    .line 3
    if-nez v0, :cond_1

    .line 4
    .line 5
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->e:Lh1/x;

    .line 6
    .line 7
    if-eqz v0, :cond_0

    .line 8
    .line 9
    iget-object v0, v0, Lh1/x;->k:Ljava/util/ArrayList;

    .line 10
    .line 11
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 12
    .line 13
    .line 14
    move-result-object v0

    .line 15
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 16
    .line 17
    .line 18
    move-result v1

    .line 19
    if-eqz v1, :cond_0

    .line 20
    .line 21
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 22
    .line 23
    .line 24
    move-result-object v1

    .line 25
    check-cast v1, Lh1/g;

    .line 26
    .line 27
    invoke-virtual {v1, p1}, Lh1/g;->a(Lh1/n;)V

    .line 28
    .line 29
    .line 30
    goto :goto_0

    .line 31
    :cond_0
    return-void

    .line 32
    :cond_1
    iget-object v0, v0, Lh1/x;->k:Ljava/util/ArrayList;

    .line 33
    .line 34
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 39
    .line 40
    .line 41
    move-result v1

    .line 42
    if-eqz v1, :cond_2

    .line 43
    .line 44
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 45
    .line 46
    .line 47
    move-result-object v1

    .line 48
    check-cast v1, Lh1/g;

    .line 49
    .line 50
    invoke-virtual {v1, p1}, Lh1/g;->a(Lh1/n;)V

    .line 51
    .line 52
    .line 53
    goto :goto_1

    .line 54
    :cond_2
    return-void
.end method

.method public final g()F
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2
    .line 3
    if-eqz v0, :cond_0

    .line 4
    .line 5
    iget-object v0, v0, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 6
    .line 7
    if-eqz v0, :cond_0

    .line 8
    .line 9
    iget v0, v0, Landroidx/constraintlayout/motion/widget/d;->t:F

    .line 10
    .line 11
    return v0

    .line 12
    :cond_0
    const/4 v0, 0x0

    .line 13
    return v0
.end method

.method public final h()I
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    const/4 v0, -0x1

    .line 6
    return v0

    .line 7
    :cond_0
    iget v0, v0, Lh1/x;->d:I

    .line 8
    .line 9
    return v0
.end method

.method public final i(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)I
    .locals 17

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    move-object/from16 v2, p2

    .line 6
    .line 7
    const/4 v3, 0x4

    .line 8
    const/4 v4, 0x3

    .line 9
    const/4 v5, 0x2

    .line 10
    const/4 v7, 0x0

    .line 11
    const/4 v8, 0x1

    .line 12
    new-instance v9, Landroidx/constraintlayout/widget/d;

    .line 13
    .line 14
    invoke-direct {v9}, Landroidx/constraintlayout/widget/d;-><init>()V

    .line 15
    .line 16
    .line 17
    iput-boolean v7, v9, Landroidx/constraintlayout/widget/d;->e:Z

    .line 18
    .line 19
    invoke-interface/range {p2 .. p2}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeCount()I

    .line 20
    .line 21
    .line 22
    move-result v10

    .line 23
    move v11, v7

    .line 24
    const/4 v12, -0x1

    .line 25
    const/4 v13, -0x1

    .line 26
    :goto_0
    if-ge v11, v10, :cond_9

    .line 27
    .line 28
    invoke-interface {v2, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeName(I)Ljava/lang/String;

    .line 29
    .line 30
    .line 31
    move-result-object v14

    .line 32
    invoke-interface {v2, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(I)Ljava/lang/String;

    .line 33
    .line 34
    .line 35
    move-result-object v15

    .line 36
    invoke-virtual {v14}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 37
    .line 38
    .line 39
    invoke-virtual {v14}, Ljava/lang/String;->hashCode()I

    .line 40
    .line 41
    .line 42
    move-result v16

    .line 43
    sparse-switch v16, :sswitch_data_0

    .line 44
    .line 45
    .line 46
    :goto_1
    const/4 v6, -0x1

    .line 47
    goto :goto_2

    .line 48
    :sswitch_0
    const-string v6, "id"

    .line 49
    .line 50
    invoke-virtual {v14, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 51
    .line 52
    .line 53
    move-result v6

    .line 54
    if-nez v6, :cond_0

    .line 55
    .line 56
    goto :goto_1

    .line 57
    :cond_0
    move v6, v5

    .line 58
    goto :goto_2

    .line 59
    :sswitch_1
    const-string v6, "constraintRotate"

    .line 60
    .line 61
    invoke-virtual {v14, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 62
    .line 63
    .line 64
    move-result v6

    .line 65
    if-nez v6, :cond_1

    .line 66
    .line 67
    goto :goto_1

    .line 68
    :cond_1
    move v6, v8

    .line 69
    goto :goto_2

    .line 70
    :sswitch_2
    const-string v6, "deriveConstraintsFrom"

    .line 71
    .line 72
    invoke-virtual {v14, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 73
    .line 74
    .line 75
    move-result v6

    .line 76
    if-nez v6, :cond_2

    .line 77
    .line 78
    goto :goto_1

    .line 79
    :cond_2
    move v6, v7

    .line 80
    :goto_2
    packed-switch v6, :pswitch_data_0

    .line 81
    .line 82
    .line 83
    goto/16 :goto_6

    .line 84
    .line 85
    :pswitch_0
    invoke-virtual {v0, v1, v15}, Landroidx/constraintlayout/motion/widget/c;->d(Landroid/content/Context;Ljava/lang/String;)I

    .line 86
    .line 87
    .line 88
    move-result v12

    .line 89
    const/16 v6, 0x2f

    .line 90
    .line 91
    invoke-virtual {v15, v6}, Ljava/lang/String;->indexOf(I)I

    .line 92
    .line 93
    .line 94
    move-result v6

    .line 95
    if-gez v6, :cond_3

    .line 96
    .line 97
    goto :goto_3

    .line 98
    :cond_3
    add-int/2addr v6, v8

    .line 99
    invoke-virtual {v15, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 100
    .line 101
    .line 102
    move-result-object v15

    .line 103
    :goto_3
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 104
    .line 105
    .line 106
    move-result-object v6

    .line 107
    iget-object v14, v0, Landroidx/constraintlayout/motion/widget/c;->h:Ljava/util/HashMap;

    .line 108
    .line 109
    invoke-virtual {v14, v15, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
    .line 111
    .line 112
    invoke-static {v1, v12}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 113
    .line 114
    .line 115
    move-result-object v6

    .line 116
    iput-object v6, v9, Landroidx/constraintlayout/widget/d;->a:Ljava/lang/String;

    .line 117
    .line 118
    goto/16 :goto_6

    .line 119
    .line 120
    :pswitch_1
    :try_start_0
    invoke-static {v15}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 121
    .line 122
    .line 123
    move-result v6

    .line 124
    iput v6, v9, Landroidx/constraintlayout/widget/d;->c:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    .line 126
    goto/16 :goto_6

    .line 127
    .line 128
    :catch_0
    invoke-virtual {v15}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 129
    .line 130
    .line 131
    invoke-virtual {v15}, Ljava/lang/String;->hashCode()I

    .line 132
    .line 133
    .line 134
    move-result v6

    .line 135
    sparse-switch v6, :sswitch_data_1

    .line 136
    .line 137
    .line 138
    :goto_4
    const/4 v6, -0x1

    .line 139
    goto :goto_5

    .line 140
    :sswitch_3
    const-string v6, "x_right"

    .line 141
    .line 142
    invoke-virtual {v15, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 143
    .line 144
    .line 145
    move-result v6

    .line 146
    if-nez v6, :cond_4

    .line 147
    .line 148
    goto :goto_4

    .line 149
    :cond_4
    move v6, v3

    .line 150
    goto :goto_5

    .line 151
    :sswitch_4
    const-string v6, "right"

    .line 152
    .line 153
    invoke-virtual {v15, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 154
    .line 155
    .line 156
    move-result v6

    .line 157
    if-nez v6, :cond_5

    .line 158
    .line 159
    goto :goto_4

    .line 160
    :cond_5
    move v6, v4

    .line 161
    goto :goto_5

    .line 162
    :sswitch_5
    const-string v6, "none"

    .line 163
    .line 164
    invoke-virtual {v15, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 165
    .line 166
    .line 167
    move-result v6

    .line 168
    if-nez v6, :cond_6

    .line 169
    .line 170
    goto :goto_4

    .line 171
    :cond_6
    move v6, v5

    .line 172
    goto :goto_5

    .line 173
    :sswitch_6
    const-string v6, "left"

    .line 174
    .line 175
    invoke-virtual {v15, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 176
    .line 177
    .line 178
    move-result v6

    .line 179
    if-nez v6, :cond_7

    .line 180
    .line 181
    goto :goto_4

    .line 182
    :cond_7
    move v6, v8

    .line 183
    goto :goto_5

    .line 184
    :sswitch_7
    const-string v6, "x_left"

    .line 185
    .line 186
    invoke-virtual {v15, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 187
    .line 188
    .line 189
    move-result v6

    .line 190
    if-nez v6, :cond_8

    .line 191
    .line 192
    goto :goto_4

    .line 193
    :cond_8
    move v6, v7

    .line 194
    :goto_5
    packed-switch v6, :pswitch_data_1

    .line 195
    .line 196
    .line 197
    goto :goto_6

    .line 198
    :pswitch_2
    iput v4, v9, Landroidx/constraintlayout/widget/d;->c:I

    .line 199
    .line 200
    goto :goto_6

    .line 201
    :pswitch_3
    iput v8, v9, Landroidx/constraintlayout/widget/d;->c:I

    .line 202
    .line 203
    goto :goto_6

    .line 204
    :pswitch_4
    iput v7, v9, Landroidx/constraintlayout/widget/d;->c:I

    .line 205
    .line 206
    goto :goto_6

    .line 207
    :pswitch_5
    iput v5, v9, Landroidx/constraintlayout/widget/d;->c:I

    .line 208
    .line 209
    goto :goto_6

    .line 210
    :pswitch_6
    iput v3, v9, Landroidx/constraintlayout/widget/d;->c:I

    .line 211
    .line 212
    goto :goto_6

    .line 213
    :pswitch_7
    invoke-virtual {v0, v1, v15}, Landroidx/constraintlayout/motion/widget/c;->d(Landroid/content/Context;Ljava/lang/String;)I

    .line 214
    .line 215
    .line 216
    move-result v13

    .line 217
    :goto_6
    add-int/2addr v11, v8

    .line 218
    goto/16 :goto_0

    .line 219
    .line 220
    :cond_9
    const/4 v6, -0x1

    .line 221
    if-eq v12, v6, :cond_b

    .line 222
    .line 223
    iget-object v3, v0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 224
    .line 225
    iget v3, v3, Landroidx/constraintlayout/motion/widget/MotionLayout;->M:I

    .line 226
    .line 227
    invoke-virtual {v9, v1, v2}, Landroidx/constraintlayout/widget/d;->n(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V

    .line 228
    .line 229
    .line 230
    if-eq v13, v6, :cond_a

    .line 231
    .line 232
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/c;->i:Landroid/util/SparseIntArray;

    .line 233
    .line 234
    invoke-virtual {v1, v12, v13}, Landroid/util/SparseIntArray;->put(II)V

    .line 235
    .line 236
    .line 237
    :cond_a
    iget-object v1, v0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 238
    .line 239
    invoke-virtual {v1, v12, v9}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 240
    .line 241
    .line 242
    :cond_b
    return v12

    .line 243
    :sswitch_data_0
    .sparse-switch
        -0x59328327 -> :sswitch_2
        -0x44bbba68 -> :sswitch_1
        0xd1b -> :sswitch_0
    .end sparse-switch

    .line 244
    .line 245
    .line 246
    .line 247
    .line 248
    .line 249
    .line 250
    .line 251
    .line 252
    .line 253
    .line 254
    .line 255
    .line 256
    .line 257
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_1
        :pswitch_0
    .end packed-switch

    .line 258
    .line 259
    .line 260
    .line 261
    .line 262
    .line 263
    .line 264
    .line 265
    .line 266
    .line 267
    :sswitch_data_1
    .sparse-switch
        -0x2dcd1c92 -> :sswitch_7
        0x32a007 -> :sswitch_6
        0x33af38 -> :sswitch_5
        0x677c21c -> :sswitch_4
        0x747feb95 -> :sswitch_3
    .end sparse-switch

    .line 268
    .line 269
    .line 270
    .line 271
    .line 272
    .line 273
    .line 274
    .line 275
    .line 276
    .line 277
    .line 278
    .line 279
    .line 280
    .line 281
    .line 282
    .line 283
    .line 284
    .line 285
    .line 286
    .line 287
    .line 288
    .line 289
    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public final j(Landroid/content/Context;I)I
    .locals 3

    .line 1
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    invoke-virtual {v0, p2}, Landroid/content/res/Resources;->getXml(I)Landroid/content/res/XmlResourceParser;

    .line 6
    .line 7
    .line 8
    move-result-object p2

    .line 9
    :try_start_0
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    :goto_0
    const/4 v1, 0x1

    .line 14
    if-eq v0, v1, :cond_1

    .line 15
    .line 16
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    .line 17
    .line 18
    .line 19
    move-result-object v1

    .line 20
    const/4 v2, 0x2

    .line 21
    if-ne v2, v0, :cond_0

    .line 22
    .line 23
    const-string v0, "ConstraintSet"

    .line 24
    .line 25
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    .line 26
    .line 27
    .line 28
    move-result v0

    .line 29
    if-eqz v0, :cond_0

    .line 30
    .line 31
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->i(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)I

    .line 32
    .line 33
    .line 34
    move-result p1

    .line 35
    return p1

    .line 36
    :catch_0
    move-exception p1

    .line 37
    goto :goto_1

    .line 38
    :catch_1
    move-exception p1

    .line 39
    goto :goto_2

    .line 40
    :cond_0
    invoke-interface {p2}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    .line 41
    .line 42
    .line 43
    move-result v0
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 44
    goto :goto_0

    .line 45
    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 46
    .line 47
    .line 48
    goto :goto_3

    .line 49
    :goto_2
    invoke-virtual {p1}, Lorg/xmlpull/v1/XmlPullParserException;->printStackTrace()V

    .line 50
    .line 51
    .line 52
    :cond_1
    :goto_3
    const/4 p1, -0x1

    .line 53
    return p1
.end method

.method public final k(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V
    .locals 4

    .line 1
    invoke-static {p2}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    .line 2
    .line 3
    .line 4
    move-result-object p2

    .line 5
    sget-object v0, Lj1/m;->D:[I

    .line 6
    .line 7
    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    .line 8
    .line 9
    .line 10
    move-result-object p2

    .line 11
    invoke-virtual {p2}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 12
    .line 13
    .line 14
    move-result v0

    .line 15
    const/4 v1, 0x0

    .line 16
    :goto_0
    if-ge v1, v0, :cond_1

    .line 17
    .line 18
    invoke-virtual {p2, v1}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 19
    .line 20
    .line 21
    move-result v2

    .line 22
    if-nez v2, :cond_0

    .line 23
    .line 24
    const/4 v3, -0x1

    .line 25
    invoke-virtual {p2, v2, v3}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 26
    .line 27
    .line 28
    move-result v2

    .line 29
    invoke-virtual {p0, p1, v2}, Landroidx/constraintlayout/motion/widget/c;->j(Landroid/content/Context;I)I

    .line 30
    .line 31
    .line 32
    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 33
    .line 34
    goto :goto_0

    .line 35
    :cond_1
    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    .line 36
    .line 37
    .line 38
    return-void
.end method

.method public final l(Landroid/content/Context;Landroid/content/res/XmlResourceParser;)V
    .locals 4

    .line 1
    invoke-static {p2}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    .line 2
    .line 3
    .line 4
    move-result-object p2

    .line 5
    sget-object v0, Lj1/m;->s:[I

    .line 6
    .line 7
    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    .line 8
    .line 9
    .line 10
    move-result-object p1

    .line 11
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 12
    .line 13
    .line 14
    move-result p2

    .line 15
    const/4 v0, 0x0

    .line 16
    move v1, v0

    .line 17
    :goto_0
    if-ge v1, p2, :cond_2

    .line 18
    .line 19
    invoke-virtual {p1, v1}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 20
    .line 21
    .line 22
    move-result v2

    .line 23
    if-nez v2, :cond_0

    .line 24
    .line 25
    iget v3, p0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 26
    .line 27
    invoke-virtual {p1, v2, v3}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 28
    .line 29
    .line 30
    move-result v2

    .line 31
    iput v2, p0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 32
    .line 33
    const/16 v3, 0x8

    .line 34
    .line 35
    if-ge v2, v3, :cond_1

    .line 36
    .line 37
    iput v3, p0, Landroidx/constraintlayout/motion/widget/c;->j:I

    .line 38
    .line 39
    goto :goto_1

    .line 40
    :cond_0
    const/4 v3, 0x1

    .line 41
    if-ne v2, v3, :cond_1

    .line 42
    .line 43
    invoke-virtual {p1, v2, v0}, Landroid/content/res/TypedArray;->getInteger(II)I

    .line 44
    .line 45
    .line 46
    move-result v2

    .line 47
    iput v2, p0, Landroidx/constraintlayout/motion/widget/c;->k:I

    .line 48
    .line 49
    :cond_1
    :goto_1
    add-int/lit8 v1, v1, 0x1

    .line 50
    .line 51
    goto :goto_0

    .line 52
    :cond_2
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    .line 53
    .line 54
    .line 55
    return-void
.end method

.method public final m(ILandroidx/constraintlayout/motion/widget/MotionLayout;)V
    .locals 11

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->g:Landroid/util/SparseArray;

    .line 2
    .line 3
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    check-cast v1, Landroidx/constraintlayout/widget/d;

    .line 8
    .line 9
    iget-object v2, v1, Landroidx/constraintlayout/widget/d;->a:Ljava/lang/String;

    .line 10
    .line 11
    iput-object v2, v1, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 12
    .line 13
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->i:Landroid/util/SparseIntArray;

    .line 14
    .line 15
    invoke-virtual {v2, p1}, Landroid/util/SparseIntArray;->get(I)I

    .line 16
    .line 17
    .line 18
    move-result p1

    .line 19
    iget-object v2, v1, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 20
    .line 21
    if-lez p1, :cond_9

    .line 22
    .line 23
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/c;->m(ILandroidx/constraintlayout/motion/widget/MotionLayout;)V

    .line 24
    .line 25
    .line 26
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 27
    .line 28
    .line 29
    move-result-object p2

    .line 30
    check-cast p2, Landroidx/constraintlayout/widget/d;

    .line 31
    .line 32
    if-nez p2, :cond_0

    .line 33
    .line 34
    new-instance p2, Ljava/lang/StringBuilder;

    .line 35
    .line 36
    const-string v0, "ERROR! invalid deriveConstraintsFrom: @id/"

    .line 37
    .line 38
    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 39
    .line 40
    .line 41
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->a:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 42
    .line 43
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 44
    .line 45
    .line 46
    move-result-object v0

    .line 47
    invoke-static {v0, p1}, Lso/c;->w(Landroid/content/Context;I)Ljava/lang/String;

    .line 48
    .line 49
    .line 50
    move-result-object p1

    .line 51
    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 52
    .line 53
    .line 54
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 55
    .line 56
    .line 57
    move-result-object p1

    .line 58
    const-string p2, "MotionScene"

    .line 59
    .line 60
    invoke-static {p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 61
    .line 62
    .line 63
    return-void

    .line 64
    :cond_0
    new-instance p1, Ljava/lang/StringBuilder;

    .line 65
    .line 66
    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    .line 67
    .line 68
    .line 69
    iget-object v0, v1, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 70
    .line 71
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 72
    .line 73
    .line 74
    const-string v0, "/"

    .line 75
    .line 76
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 77
    .line 78
    .line 79
    iget-object v0, p2, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 80
    .line 81
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 82
    .line 83
    .line 84
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 85
    .line 86
    .line 87
    move-result-object p1

    .line 88
    iput-object p1, v1, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 89
    .line 90
    iget-object p1, p2, Landroidx/constraintlayout/widget/d;->f:Ljava/util/HashMap;

    .line 91
    .line 92
    invoke-virtual {p1}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    .line 93
    .line 94
    .line 95
    move-result-object p2

    .line 96
    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 97
    .line 98
    .line 99
    move-result-object p2

    .line 100
    :cond_1
    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    .line 101
    .line 102
    .line 103
    move-result v0

    .line 104
    if-eqz v0, :cond_14

    .line 105
    .line 106
    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 107
    .line 108
    .line 109
    move-result-object v0

    .line 110
    check-cast v0, Ljava/lang/Integer;

    .line 111
    .line 112
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 113
    .line 114
    .line 115
    invoke-virtual {p1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    .line 117
    .line 118
    move-result-object v3

    .line 119
    check-cast v3, Landroidx/constraintlayout/widget/c;

    .line 120
    .line 121
    invoke-virtual {v2, v0}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    .line 122
    .line 123
    .line 124
    move-result v4

    .line 125
    if-nez v4, :cond_2

    .line 126
    .line 127
    new-instance v4, Landroidx/constraintlayout/widget/c;

    .line 128
    .line 129
    invoke-direct {v4}, Landroidx/constraintlayout/widget/c;-><init>()V

    .line 130
    .line 131
    .line 132
    invoke-virtual {v2, v0, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    .line 134
    .line 135
    :cond_2
    invoke-virtual {v2, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 136
    .line 137
    .line 138
    move-result-object v0

    .line 139
    check-cast v0, Landroidx/constraintlayout/widget/c;

    .line 140
    .line 141
    if-nez v0, :cond_3

    .line 142
    .line 143
    goto :goto_0

    .line 144
    :cond_3
    iget-object v4, v0, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 145
    .line 146
    iget-boolean v5, v4, Lj1/g;->b:Z

    .line 147
    .line 148
    if-nez v5, :cond_4

    .line 149
    .line 150
    iget-object v5, v3, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 151
    .line 152
    invoke-virtual {v4, v5}, Lj1/g;->a(Lj1/g;)V

    .line 153
    .line 154
    .line 155
    :cond_4
    iget-object v4, v0, Landroidx/constraintlayout/widget/c;->c:Lj1/i;

    .line 156
    .line 157
    iget-boolean v5, v4, Lj1/i;->a:Z

    .line 158
    .line 159
    if-nez v5, :cond_5

    .line 160
    .line 161
    iget-object v5, v3, Landroidx/constraintlayout/widget/c;->c:Lj1/i;

    .line 162
    .line 163
    invoke-virtual {v4, v5}, Lj1/i;->a(Lj1/i;)V

    .line 164
    .line 165
    .line 166
    :cond_5
    iget-object v4, v0, Landroidx/constraintlayout/widget/c;->f:Lj1/j;

    .line 167
    .line 168
    iget-boolean v5, v4, Lj1/j;->a:Z

    .line 169
    .line 170
    if-nez v5, :cond_6

    .line 171
    .line 172
    iget-object v5, v3, Landroidx/constraintlayout/widget/c;->f:Lj1/j;

    .line 173
    .line 174
    invoke-virtual {v4, v5}, Lj1/j;->a(Lj1/j;)V

    .line 175
    .line 176
    .line 177
    :cond_6
    iget-object v4, v0, Landroidx/constraintlayout/widget/c;->d:Lj1/h;

    .line 178
    .line 179
    iget-boolean v5, v4, Lj1/h;->a:Z

    .line 180
    .line 181
    if-nez v5, :cond_7

    .line 182
    .line 183
    iget-object v5, v3, Landroidx/constraintlayout/widget/c;->d:Lj1/h;

    .line 184
    .line 185
    invoke-virtual {v4, v5}, Lj1/h;->a(Lj1/h;)V

    .line 186
    .line 187
    .line 188
    :cond_7
    iget-object v4, v3, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 189
    .line 190
    invoke-virtual {v4}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    .line 191
    .line 192
    .line 193
    move-result-object v4

    .line 194
    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 195
    .line 196
    .line 197
    move-result-object v4

    .line 198
    :cond_8
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 199
    .line 200
    .line 201
    move-result v5

    .line 202
    if-eqz v5, :cond_1

    .line 203
    .line 204
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 205
    .line 206
    .line 207
    move-result-object v5

    .line 208
    check-cast v5, Ljava/lang/String;

    .line 209
    .line 210
    iget-object v6, v0, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 211
    .line 212
    invoke-virtual {v6, v5}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    .line 213
    .line 214
    .line 215
    move-result v6

    .line 216
    if-nez v6, :cond_8

    .line 217
    .line 218
    iget-object v6, v0, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 219
    .line 220
    iget-object v7, v3, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 221
    .line 222
    invoke-virtual {v7, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 223
    .line 224
    .line 225
    move-result-object v7

    .line 226
    check-cast v7, Lj1/b;

    .line 227
    .line 228
    invoke-virtual {v6, v5, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 229
    .line 230
    .line 231
    goto :goto_1

    .line 232
    :cond_9
    new-instance p1, Ljava/lang/StringBuilder;

    .line 233
    .line 234
    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    .line 235
    .line 236
    .line 237
    iget-object v0, v1, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 238
    .line 239
    const-string v3, "  layout"

    .line 240
    .line 241
    invoke-static {p1, v0, v3}, La1/a;->t(Ljava/lang/StringBuilder;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 242
    .line 243
    .line 244
    move-result-object p1

    .line 245
    iput-object p1, v1, Landroidx/constraintlayout/widget/d;->b:Ljava/lang/String;

    .line 246
    .line 247
    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    .line 248
    .line 249
    .line 250
    move-result p1

    .line 251
    const/4 v0, 0x0

    .line 252
    :goto_2
    if-ge v0, p1, :cond_14

    .line 253
    .line 254
    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 255
    .line 256
    .line 257
    move-result-object v3

    .line 258
    invoke-virtual {v3}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 259
    .line 260
    .line 261
    move-result-object v4

    .line 262
    check-cast v4, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 263
    .line 264
    invoke-virtual {v3}, Landroid/view/View;->getId()I

    .line 265
    .line 266
    .line 267
    move-result v5

    .line 268
    iget-boolean v6, v1, Landroidx/constraintlayout/widget/d;->e:Z

    .line 269
    .line 270
    if-eqz v6, :cond_b

    .line 271
    .line 272
    const/4 v6, -0x1

    .line 273
    if-eq v5, v6, :cond_a

    .line 274
    .line 275
    goto :goto_3

    .line 276
    :cond_a
    new-instance p1, Ljava/lang/RuntimeException;

    .line 277
    .line 278
    const-string p2, "All children of ConstraintLayout must have ids to use ConstraintSet"

    .line 279
    .line 280
    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 281
    .line 282
    .line 283
    throw p1

    .line 284
    :cond_b
    :goto_3
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 285
    .line 286
    .line 287
    move-result-object v6

    .line 288
    invoke-virtual {v2, v6}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    .line 289
    .line 290
    .line 291
    move-result v6

    .line 292
    if-nez v6, :cond_c

    .line 293
    .line 294
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 295
    .line 296
    .line 297
    move-result-object v6

    .line 298
    new-instance v7, Landroidx/constraintlayout/widget/c;

    .line 299
    .line 300
    invoke-direct {v7}, Landroidx/constraintlayout/widget/c;-><init>()V

    .line 301
    .line 302
    .line 303
    invoke-virtual {v2, v6, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 304
    .line 305
    .line 306
    :cond_c
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 307
    .line 308
    .line 309
    move-result-object v6

    .line 310
    invoke-virtual {v2, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 311
    .line 312
    .line 313
    move-result-object v6

    .line 314
    check-cast v6, Landroidx/constraintlayout/widget/c;

    .line 315
    .line 316
    if-nez v6, :cond_d

    .line 317
    .line 318
    goto/16 :goto_4

    .line 319
    .line 320
    :cond_d
    iget-object v7, v6, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 321
    .line 322
    iget-boolean v8, v7, Lj1/g;->b:Z

    .line 323
    .line 324
    const/4 v9, 0x1

    .line 325
    if-nez v8, :cond_f

    .line 326
    .line 327
    invoke-virtual {v6, v5, v4}, Landroidx/constraintlayout/widget/c;->f(ILandroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;)V

    .line 328
    .line 329
    .line 330
    instance-of v4, v3, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 331
    .line 332
    if-eqz v4, :cond_e

    .line 333
    .line 334
    move-object v4, v3

    .line 335
    check-cast v4, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 336
    .line 337
    invoke-virtual {v4}, Landroidx/constraintlayout/widget/ConstraintHelper;->getReferencedIds()[I

    .line 338
    .line 339
    .line 340
    move-result-object v4

    .line 341
    iput-object v4, v7, Lj1/g;->j0:[I

    .line 342
    .line 343
    instance-of v4, v3, Landroidx/constraintlayout/widget/Barrier;

    .line 344
    .line 345
    if-eqz v4, :cond_e

    .line 346
    .line 347
    move-object v4, v3

    .line 348
    check-cast v4, Landroidx/constraintlayout/widget/Barrier;

    .line 349
    .line 350
    invoke-virtual {v4}, Landroidx/constraintlayout/widget/Barrier;->getAllowsGoneWidget()Z

    .line 351
    .line 352
    .line 353
    move-result v5

    .line 354
    iput-boolean v5, v7, Lj1/g;->o0:Z

    .line 355
    .line 356
    invoke-virtual {v4}, Landroidx/constraintlayout/widget/Barrier;->getType()I

    .line 357
    .line 358
    .line 359
    move-result v5

    .line 360
    iput v5, v7, Lj1/g;->g0:I

    .line 361
    .line 362
    invoke-virtual {v4}, Landroidx/constraintlayout/widget/Barrier;->getMargin()I

    .line 363
    .line 364
    .line 365
    move-result v4

    .line 366
    iput v4, v7, Lj1/g;->h0:I

    .line 367
    .line 368
    :cond_e
    iput-boolean v9, v7, Lj1/g;->b:Z

    .line 369
    .line 370
    :cond_f
    iget-object v4, v6, Landroidx/constraintlayout/widget/c;->c:Lj1/i;

    .line 371
    .line 372
    iget-boolean v5, v4, Lj1/i;->a:Z

    .line 373
    .line 374
    if-nez v5, :cond_10

    .line 375
    .line 376
    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    .line 377
    .line 378
    .line 379
    move-result v5

    .line 380
    iput v5, v4, Lj1/i;->b:I

    .line 381
    .line 382
    invoke-virtual {v3}, Landroid/view/View;->getAlpha()F

    .line 383
    .line 384
    .line 385
    move-result v5

    .line 386
    iput v5, v4, Lj1/i;->d:F

    .line 387
    .line 388
    iput-boolean v9, v4, Lj1/i;->a:Z

    .line 389
    .line 390
    :cond_10
    iget-object v4, v6, Landroidx/constraintlayout/widget/c;->f:Lj1/j;

    .line 391
    .line 392
    iget-boolean v5, v4, Lj1/j;->a:Z

    .line 393
    .line 394
    if-nez v5, :cond_13

    .line 395
    .line 396
    iput-boolean v9, v4, Lj1/j;->a:Z

    .line 397
    .line 398
    invoke-virtual {v3}, Landroid/view/View;->getRotation()F

    .line 399
    .line 400
    .line 401
    move-result v5

    .line 402
    iput v5, v4, Lj1/j;->b:F

    .line 403
    .line 404
    invoke-virtual {v3}, Landroid/view/View;->getRotationX()F

    .line 405
    .line 406
    .line 407
    move-result v5

    .line 408
    iput v5, v4, Lj1/j;->c:F

    .line 409
    .line 410
    invoke-virtual {v3}, Landroid/view/View;->getRotationY()F

    .line 411
    .line 412
    .line 413
    move-result v5

    .line 414
    iput v5, v4, Lj1/j;->d:F

    .line 415
    .line 416
    invoke-virtual {v3}, Landroid/view/View;->getScaleX()F

    .line 417
    .line 418
    .line 419
    move-result v5

    .line 420
    iput v5, v4, Lj1/j;->e:F

    .line 421
    .line 422
    invoke-virtual {v3}, Landroid/view/View;->getScaleY()F

    .line 423
    .line 424
    .line 425
    move-result v5

    .line 426
    iput v5, v4, Lj1/j;->f:F

    .line 427
    .line 428
    invoke-virtual {v3}, Landroid/view/View;->getPivotX()F

    .line 429
    .line 430
    .line 431
    move-result v5

    .line 432
    invoke-virtual {v3}, Landroid/view/View;->getPivotY()F

    .line 433
    .line 434
    .line 435
    move-result v6

    .line 436
    float-to-double v7, v5

    .line 437
    const-wide/16 v9, 0x0

    .line 438
    .line 439
    cmpl-double v7, v7, v9

    .line 440
    .line 441
    if-nez v7, :cond_11

    .line 442
    .line 443
    float-to-double v7, v6

    .line 444
    cmpl-double v7, v7, v9

    .line 445
    .line 446
    if-eqz v7, :cond_12

    .line 447
    .line 448
    :cond_11
    iput v5, v4, Lj1/j;->g:F

    .line 449
    .line 450
    iput v6, v4, Lj1/j;->h:F

    .line 451
    .line 452
    :cond_12
    invoke-virtual {v3}, Landroid/view/View;->getTranslationX()F

    .line 453
    .line 454
    .line 455
    move-result v5

    .line 456
    iput v5, v4, Lj1/j;->j:F

    .line 457
    .line 458
    invoke-virtual {v3}, Landroid/view/View;->getTranslationY()F

    .line 459
    .line 460
    .line 461
    move-result v5

    .line 462
    iput v5, v4, Lj1/j;->k:F

    .line 463
    .line 464
    invoke-virtual {v3}, Landroid/view/View;->getTranslationZ()F

    .line 465
    .line 466
    .line 467
    move-result v5

    .line 468
    iput v5, v4, Lj1/j;->l:F

    .line 469
    .line 470
    iget-boolean v5, v4, Lj1/j;->m:Z

    .line 471
    .line 472
    if-eqz v5, :cond_13

    .line 473
    .line 474
    invoke-virtual {v3}, Landroid/view/View;->getElevation()F

    .line 475
    .line 476
    .line 477
    move-result v3

    .line 478
    iput v3, v4, Lj1/j;->n:F

    .line 479
    .line 480
    :cond_13
    :goto_4
    add-int/lit8 v0, v0, 0x1

    .line 481
    .line 482
    goto/16 :goto_2

    .line 483
    .line 484
    :cond_14
    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    .line 485
    .line 486
    .line 487
    move-result-object p1

    .line 488
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    .line 489
    .line 490
    .line 491
    move-result-object p1

    .line 492
    :cond_15
    :goto_5
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    .line 493
    .line 494
    .line 495
    move-result p2

    .line 496
    if-eqz p2, :cond_18

    .line 497
    .line 498
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 499
    .line 500
    .line 501
    move-result-object p2

    .line 502
    check-cast p2, Landroidx/constraintlayout/widget/c;

    .line 503
    .line 504
    iget-object v0, p2, Landroidx/constraintlayout/widget/c;->h:Lj1/f;

    .line 505
    .line 506
    if-eqz v0, :cond_15

    .line 507
    .line 508
    iget-object v0, p2, Landroidx/constraintlayout/widget/c;->b:Ljava/lang/String;

    .line 509
    .line 510
    if-eqz v0, :cond_17

    .line 511
    .line 512
    invoke-virtual {v2}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    .line 513
    .line 514
    .line 515
    move-result-object v0

    .line 516
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    .line 517
    .line 518
    .line 519
    move-result-object v0

    .line 520
    :cond_16
    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 521
    .line 522
    .line 523
    move-result v3

    .line 524
    if-eqz v3, :cond_15

    .line 525
    .line 526
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 527
    .line 528
    .line 529
    move-result-object v3

    .line 530
    check-cast v3, Ljava/lang/Integer;

    .line 531
    .line 532
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    .line 533
    .line 534
    .line 535
    move-result v3

    .line 536
    invoke-virtual {v1, v3}, Landroidx/constraintlayout/widget/d;->l(I)Landroidx/constraintlayout/widget/c;

    .line 537
    .line 538
    .line 539
    move-result-object v3

    .line 540
    iget-object v4, v3, Landroidx/constraintlayout/widget/c;->e:Lj1/g;

    .line 541
    .line 542
    iget-object v4, v4, Lj1/g;->l0:Ljava/lang/String;

    .line 543
    .line 544
    if-eqz v4, :cond_16

    .line 545
    .line 546
    iget-object v5, p2, Landroidx/constraintlayout/widget/c;->b:Ljava/lang/String;

    .line 547
    .line 548
    invoke-virtual {v5, v4}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    .line 549
    .line 550
    .line 551
    move-result v4

    .line 552
    if-eqz v4, :cond_16

    .line 553
    .line 554
    iget-object v4, p2, Landroidx/constraintlayout/widget/c;->h:Lj1/f;

    .line 555
    .line 556
    invoke-virtual {v4, v3}, Lj1/f;->e(Landroidx/constraintlayout/widget/c;)V

    .line 557
    .line 558
    .line 559
    iget-object v3, v3, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 560
    .line 561
    iget-object v4, p2, Landroidx/constraintlayout/widget/c;->g:Ljava/util/HashMap;

    .line 562
    .line 563
    invoke-virtual {v4}, Ljava/util/HashMap;->clone()Ljava/lang/Object;

    .line 564
    .line 565
    .line 566
    move-result-object v4

    .line 567
    check-cast v4, Ljava/util/HashMap;

    .line 568
    .line 569
    invoke-virtual {v3, v4}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    .line 570
    .line 571
    .line 572
    goto :goto_6

    .line 573
    :cond_17
    iget v0, p2, Landroidx/constraintlayout/widget/c;->a:I

    .line 574
    .line 575
    invoke-virtual {v1, v0}, Landroidx/constraintlayout/widget/d;->l(I)Landroidx/constraintlayout/widget/c;

    .line 576
    .line 577
    .line 578
    move-result-object v0

    .line 579
    iget-object p2, p2, Landroidx/constraintlayout/widget/c;->h:Lj1/f;

    .line 580
    .line 581
    invoke-virtual {p2, v0}, Lj1/f;->e(Landroidx/constraintlayout/widget/c;)V

    .line 582
    .line 583
    .line 584
    goto :goto_5

    .line 585
    :cond_18
    return-void
.end method

.method public final n(II)V
    .locals 8

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 2
    .line 3
    const/4 v1, -0x1

    .line 4
    if-eqz v0, :cond_2

    .line 5
    .line 6
    invoke-virtual {v0, p1}, Landroidx/compose/animation/core/u;->t(I)I

    .line 7
    .line 8
    .line 9
    move-result v0

    .line 10
    if-eq v0, v1, :cond_0

    .line 11
    .line 12
    goto :goto_0

    .line 13
    :cond_0
    move v0, p1

    .line 14
    :goto_0
    iget-object v2, p0, Landroidx/constraintlayout/motion/widget/c;->b:Landroidx/compose/animation/core/u;

    .line 15
    .line 16
    invoke-virtual {v2, p2}, Landroidx/compose/animation/core/u;->t(I)I

    .line 17
    .line 18
    .line 19
    move-result v2

    .line 20
    if-eq v2, v1, :cond_1

    .line 21
    .line 22
    goto :goto_2

    .line 23
    :cond_1
    :goto_1
    move v2, p2

    .line 24
    goto :goto_2

    .line 25
    :cond_2
    move v0, p1

    .line 26
    goto :goto_1

    .line 27
    :goto_2
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 28
    .line 29
    if-eqz v3, :cond_3

    .line 30
    .line 31
    iget v4, v3, Lh1/x;->c:I

    .line 32
    .line 33
    if-ne v4, p2, :cond_3

    .line 34
    .line 35
    iget v3, v3, Lh1/x;->d:I

    .line 36
    .line 37
    if-ne v3, p1, :cond_3

    .line 38
    .line 39
    return-void

    .line 40
    :cond_3
    iget-object v3, p0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 41
    .line 42
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 43
    .line 44
    .line 45
    move-result-object v4

    .line 46
    :cond_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 47
    .line 48
    .line 49
    move-result v5

    .line 50
    if-eqz v5, :cond_8

    .line 51
    .line 52
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 53
    .line 54
    .line 55
    move-result-object v5

    .line 56
    check-cast v5, Lh1/x;

    .line 57
    .line 58
    iget v6, v5, Lh1/x;->c:I

    .line 59
    .line 60
    if-ne v6, v2, :cond_5

    .line 61
    .line 62
    iget v7, v5, Lh1/x;->d:I

    .line 63
    .line 64
    if-eq v7, v0, :cond_6

    .line 65
    .line 66
    :cond_5
    if-ne v6, p2, :cond_4

    .line 67
    .line 68
    iget v6, v5, Lh1/x;->d:I

    .line 69
    .line 70
    if-ne v6, p1, :cond_4

    .line 71
    .line 72
    :cond_6
    iput-object v5, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 73
    .line 74
    iget-object p1, v5, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 75
    .line 76
    if-eqz p1, :cond_7

    .line 77
    .line 78
    iget-boolean p2, p0, Landroidx/constraintlayout/motion/widget/c;->p:Z

    .line 79
    .line 80
    invoke-virtual {p1, p2}, Landroidx/constraintlayout/motion/widget/d;->c(Z)V

    .line 81
    .line 82
    .line 83
    :cond_7
    return-void

    .line 84
    :cond_8
    iget-object p1, p0, Landroidx/constraintlayout/motion/widget/c;->e:Lh1/x;

    .line 85
    .line 86
    iget-object v4, p0, Landroidx/constraintlayout/motion/widget/c;->f:Ljava/util/ArrayList;

    .line 87
    .line 88
    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 89
    .line 90
    .line 91
    move-result-object v4

    .line 92
    :cond_9
    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    .line 93
    .line 94
    .line 95
    move-result v5

    .line 96
    if-eqz v5, :cond_a

    .line 97
    .line 98
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 99
    .line 100
    .line 101
    move-result-object v5

    .line 102
    check-cast v5, Lh1/x;

    .line 103
    .line 104
    iget v6, v5, Lh1/x;->c:I

    .line 105
    .line 106
    if-ne v6, p2, :cond_9

    .line 107
    .line 108
    move-object p1, v5

    .line 109
    goto :goto_3

    .line 110
    :cond_a
    new-instance p2, Lh1/x;

    .line 111
    .line 112
    invoke-direct {p2, p0, p1}, Lh1/x;-><init>(Landroidx/constraintlayout/motion/widget/c;Lh1/x;)V

    .line 113
    .line 114
    .line 115
    iput v0, p2, Lh1/x;->d:I

    .line 116
    .line 117
    iput v2, p2, Lh1/x;->c:I

    .line 118
    .line 119
    if-eq v0, v1, :cond_b

    .line 120
    .line 121
    invoke-virtual {v3, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 122
    .line 123
    .line 124
    :cond_b
    iput-object p2, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 125
    .line 126
    return-void
.end method

.method public final o()Z
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->d:Ljava/util/ArrayList;

    .line 2
    .line 3
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 8
    .line 9
    .line 10
    move-result v1

    .line 11
    const/4 v2, 0x1

    .line 12
    if-eqz v1, :cond_1

    .line 13
    .line 14
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 15
    .line 16
    .line 17
    move-result-object v1

    .line 18
    check-cast v1, Lh1/x;

    .line 19
    .line 20
    iget-object v1, v1, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 21
    .line 22
    if-eqz v1, :cond_0

    .line 23
    .line 24
    return v2

    .line 25
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/motion/widget/c;->c:Lh1/x;

    .line 26
    .line 27
    if-eqz v0, :cond_2

    .line 28
    .line 29
    iget-object v0, v0, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 30
    .line 31
    if-eqz v0, :cond_2

    .line 32
    .line 33
    goto :goto_0

    .line 34
    :cond_2
    const/4 v2, 0x0

    .line 35
    :goto_0
    return v2
.end method
