.class public final Landroidx/constraintlayout/widget/b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Le1/c;


# instance fields
.field public final a:Landroidx/constraintlayout/widget/ConstraintLayout;

.field public b:I

.field public c:I

.field public d:I

.field public e:I

.field public f:I

.field public g:I

.field public final synthetic h:Landroidx/constraintlayout/widget/ConstraintLayout;


# direct methods
.method public constructor <init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroidx/constraintlayout/widget/ConstraintLayout;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    iput-object p1, p0, Landroidx/constraintlayout/widget/b;->h:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 5
    .line 6
    iput-object p2, p0, Landroidx/constraintlayout/widget/b;->a:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 7
    .line 8
    return-void
.end method

.method public static a(III)Z
    .locals 3

    .line 1
    const/4 v0, 0x1

    .line 2
    if-ne p0, p1, :cond_0

    .line 3
    .line 4
    return v0

    .line 5
    :cond_0
    invoke-static {p0}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 6
    .line 7
    .line 8
    move-result v1

    .line 9
    invoke-static {p0}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 10
    .line 11
    .line 12
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 13
    .line 14
    .line 15
    move-result p0

    .line 16
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 17
    .line 18
    .line 19
    move-result p1

    .line 20
    const/high16 v2, 0x40000000    # 2.0f

    .line 21
    .line 22
    if-ne p0, v2, :cond_2

    .line 23
    .line 24
    const/high16 p0, -0x80000000

    .line 25
    .line 26
    if-eq v1, p0, :cond_1

    .line 27
    .line 28
    if-nez v1, :cond_2

    .line 29
    .line 30
    :cond_1
    if-ne p2, p1, :cond_2

    .line 31
    .line 32
    return v0

    .line 33
    :cond_2
    const/4 p0, 0x0

    .line 34
    return p0
.end method


# virtual methods
.method public final b(Ld1/f;Le1/b;)V
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
    if-nez v1, :cond_0

    .line 8
    .line 9
    return-void

    .line 10
    :cond_0
    iget v3, v1, Ld1/f;->i0:I

    .line 11
    .line 12
    const/16 v4, 0x8

    .line 13
    .line 14
    const/4 v5, 0x0

    .line 15
    if-ne v3, v4, :cond_1

    .line 16
    .line 17
    iget-boolean v3, v1, Ld1/f;->F:Z

    .line 18
    .line 19
    if-nez v3, :cond_1

    .line 20
    .line 21
    iput v5, v2, Le1/b;->e:I

    .line 22
    .line 23
    iput v5, v2, Le1/b;->f:I

    .line 24
    .line 25
    iput v5, v2, Le1/b;->g:I

    .line 26
    .line 27
    return-void

    .line 28
    :cond_1
    iget-object v3, v1, Ld1/f;->V:Ld1/f;

    .line 29
    .line 30
    if-nez v3, :cond_2

    .line 31
    .line 32
    return-void

    .line 33
    :cond_2
    iget-object v3, v2, Le1/b;->a:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 34
    .line 35
    iget-object v4, v2, Le1/b;->b:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 36
    .line 37
    iget v6, v2, Le1/b;->c:I

    .line 38
    .line 39
    iget v7, v2, Le1/b;->d:I

    .line 40
    .line 41
    iget v8, v0, Landroidx/constraintlayout/widget/b;->b:I

    .line 42
    .line 43
    iget v9, v0, Landroidx/constraintlayout/widget/b;->c:I

    .line 44
    .line 45
    add-int/2addr v8, v9

    .line 46
    iget v9, v0, Landroidx/constraintlayout/widget/b;->d:I

    .line 47
    .line 48
    iget-object v10, v1, Ld1/f;->h0:Landroid/view/View;

    .line 49
    .line 50
    sget-object v11, Lj1/c;->a:[I

    .line 51
    .line 52
    invoke-virtual {v3}, Ljava/lang/Enum;->ordinal()I

    .line 53
    .line 54
    .line 55
    move-result v12

    .line 56
    aget v12, v11, v12

    .line 57
    .line 58
    iget-object v13, v1, Ld1/f;->L:Ld1/d;

    .line 59
    .line 60
    iget-object v14, v1, Ld1/f;->J:Ld1/d;

    .line 61
    .line 62
    const/4 v15, 0x2

    .line 63
    const/4 v5, 0x1

    .line 64
    if-eq v12, v5, :cond_d

    .line 65
    .line 66
    if-eq v12, v15, :cond_c

    .line 67
    .line 68
    const/4 v6, 0x3

    .line 69
    if-eq v12, v6, :cond_9

    .line 70
    .line 71
    const/4 v6, 0x4

    .line 72
    if-eq v12, v6, :cond_3

    .line 73
    .line 74
    const/4 v6, 0x0

    .line 75
    goto/16 :goto_4

    .line 76
    .line 77
    :cond_3
    iget v6, v0, Landroidx/constraintlayout/widget/b;->f:I

    .line 78
    .line 79
    const/4 v12, -0x2

    .line 80
    invoke-static {v6, v9, v12}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 81
    .line 82
    .line 83
    move-result v6

    .line 84
    iget v9, v1, Ld1/f;->r:I

    .line 85
    .line 86
    if-ne v9, v5, :cond_4

    .line 87
    .line 88
    move v9, v5

    .line 89
    goto :goto_0

    .line 90
    :cond_4
    const/4 v9, 0x0

    .line 91
    :goto_0
    iget v12, v2, Le1/b;->j:I

    .line 92
    .line 93
    if-eq v12, v5, :cond_5

    .line 94
    .line 95
    if-ne v12, v15, :cond_e

    .line 96
    .line 97
    :cond_5
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredHeight()I

    .line 98
    .line 99
    .line 100
    move-result v12

    .line 101
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 102
    .line 103
    .line 104
    move-result v5

    .line 105
    if-ne v12, v5, :cond_6

    .line 106
    .line 107
    const/4 v5, 0x1

    .line 108
    goto :goto_1

    .line 109
    :cond_6
    const/4 v5, 0x0

    .line 110
    :goto_1
    iget v12, v2, Le1/b;->j:I

    .line 111
    .line 112
    if-eq v12, v15, :cond_8

    .line 113
    .line 114
    if-eqz v9, :cond_8

    .line 115
    .line 116
    if-eqz v9, :cond_7

    .line 117
    .line 118
    if-nez v5, :cond_8

    .line 119
    .line 120
    :cond_7
    instance-of v5, v10, Landroidx/constraintlayout/widget/Placeholder;

    .line 121
    .line 122
    if-nez v5, :cond_8

    .line 123
    .line 124
    invoke-virtual/range {p1 .. p1}, Ld1/f;->B()Z

    .line 125
    .line 126
    .line 127
    move-result v5

    .line 128
    if-eqz v5, :cond_e

    .line 129
    .line 130
    :cond_8
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 131
    .line 132
    .line 133
    move-result v5

    .line 134
    const/high16 v6, 0x40000000    # 2.0f

    .line 135
    .line 136
    invoke-static {v5, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 137
    .line 138
    .line 139
    move-result v5

    .line 140
    :goto_2
    move v6, v5

    .line 141
    goto :goto_4

    .line 142
    :cond_9
    iget v5, v0, Landroidx/constraintlayout/widget/b;->f:I

    .line 143
    .line 144
    if-eqz v14, :cond_a

    .line 145
    .line 146
    iget v6, v14, Ld1/d;->g:I

    .line 147
    .line 148
    goto :goto_3

    .line 149
    :cond_a
    const/4 v6, 0x0

    .line 150
    :goto_3
    if-eqz v13, :cond_b

    .line 151
    .line 152
    iget v12, v13, Ld1/d;->g:I

    .line 153
    .line 154
    add-int/2addr v6, v12

    .line 155
    :cond_b
    add-int/2addr v9, v6

    .line 156
    const/4 v6, -0x1

    .line 157
    invoke-static {v5, v9, v6}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 158
    .line 159
    .line 160
    move-result v5

    .line 161
    goto :goto_2

    .line 162
    :cond_c
    iget v5, v0, Landroidx/constraintlayout/widget/b;->f:I

    .line 163
    .line 164
    const/4 v6, -0x2

    .line 165
    invoke-static {v5, v9, v6}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 166
    .line 167
    .line 168
    move-result v5

    .line 169
    goto :goto_2

    .line 170
    :cond_d
    const/high16 v5, 0x40000000    # 2.0f

    .line 171
    .line 172
    invoke-static {v6, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 173
    .line 174
    .line 175
    move-result v6

    .line 176
    :cond_e
    :goto_4
    invoke-virtual {v4}, Ljava/lang/Enum;->ordinal()I

    .line 177
    .line 178
    .line 179
    move-result v5

    .line 180
    aget v5, v11, v5

    .line 181
    .line 182
    const/4 v9, 0x1

    .line 183
    if-eq v5, v9, :cond_19

    .line 184
    .line 185
    if-eq v5, v15, :cond_18

    .line 186
    .line 187
    const/4 v7, 0x3

    .line 188
    if-eq v5, v7, :cond_15

    .line 189
    .line 190
    const/4 v7, 0x4

    .line 191
    if-eq v5, v7, :cond_f

    .line 192
    .line 193
    const/4 v5, 0x0

    .line 194
    goto/16 :goto_8

    .line 195
    .line 196
    :cond_f
    iget v5, v0, Landroidx/constraintlayout/widget/b;->g:I

    .line 197
    .line 198
    const/4 v7, -0x2

    .line 199
    invoke-static {v5, v8, v7}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 200
    .line 201
    .line 202
    move-result v5

    .line 203
    iget v7, v1, Ld1/f;->s:I

    .line 204
    .line 205
    if-ne v7, v9, :cond_10

    .line 206
    .line 207
    move v7, v9

    .line 208
    goto :goto_5

    .line 209
    :cond_10
    const/4 v7, 0x0

    .line 210
    :goto_5
    iget v8, v2, Le1/b;->j:I

    .line 211
    .line 212
    if-eq v8, v9, :cond_11

    .line 213
    .line 214
    if-ne v8, v15, :cond_1a

    .line 215
    .line 216
    :cond_11
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredWidth()I

    .line 217
    .line 218
    .line 219
    move-result v8

    .line 220
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 221
    .line 222
    .line 223
    move-result v9

    .line 224
    if-ne v8, v9, :cond_12

    .line 225
    .line 226
    const/4 v8, 0x1

    .line 227
    goto :goto_6

    .line 228
    :cond_12
    const/4 v8, 0x0

    .line 229
    :goto_6
    iget v9, v2, Le1/b;->j:I

    .line 230
    .line 231
    if-eq v9, v15, :cond_14

    .line 232
    .line 233
    if-eqz v7, :cond_14

    .line 234
    .line 235
    if-eqz v7, :cond_13

    .line 236
    .line 237
    if-nez v8, :cond_14

    .line 238
    .line 239
    :cond_13
    instance-of v7, v10, Landroidx/constraintlayout/widget/Placeholder;

    .line 240
    .line 241
    if-nez v7, :cond_14

    .line 242
    .line 243
    invoke-virtual/range {p1 .. p1}, Ld1/f;->C()Z

    .line 244
    .line 245
    .line 246
    move-result v7

    .line 247
    if-eqz v7, :cond_1a

    .line 248
    .line 249
    :cond_14
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 250
    .line 251
    .line 252
    move-result v5

    .line 253
    const/high16 v7, 0x40000000    # 2.0f

    .line 254
    .line 255
    invoke-static {v5, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 256
    .line 257
    .line 258
    move-result v5

    .line 259
    goto :goto_8

    .line 260
    :cond_15
    iget v5, v0, Landroidx/constraintlayout/widget/b;->g:I

    .line 261
    .line 262
    if-eqz v14, :cond_16

    .line 263
    .line 264
    iget-object v7, v1, Ld1/f;->K:Ld1/d;

    .line 265
    .line 266
    iget v7, v7, Ld1/d;->g:I

    .line 267
    .line 268
    goto :goto_7

    .line 269
    :cond_16
    const/4 v7, 0x0

    .line 270
    :goto_7
    if-eqz v13, :cond_17

    .line 271
    .line 272
    iget-object v9, v1, Ld1/f;->M:Ld1/d;

    .line 273
    .line 274
    iget v9, v9, Ld1/d;->g:I

    .line 275
    .line 276
    add-int/2addr v7, v9

    .line 277
    :cond_17
    add-int/2addr v8, v7

    .line 278
    const/4 v7, -0x1

    .line 279
    invoke-static {v5, v8, v7}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 280
    .line 281
    .line 282
    move-result v5

    .line 283
    goto :goto_8

    .line 284
    :cond_18
    iget v5, v0, Landroidx/constraintlayout/widget/b;->g:I

    .line 285
    .line 286
    const/4 v7, -0x2

    .line 287
    invoke-static {v5, v8, v7}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    .line 288
    .line 289
    .line 290
    move-result v5

    .line 291
    goto :goto_8

    .line 292
    :cond_19
    const/high16 v5, 0x40000000    # 2.0f

    .line 293
    .line 294
    invoke-static {v7, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 295
    .line 296
    .line 297
    move-result v7

    .line 298
    move v5, v7

    .line 299
    :cond_1a
    :goto_8
    iget-object v7, v1, Ld1/f;->V:Ld1/f;

    .line 300
    .line 301
    check-cast v7, Ld1/g;

    .line 302
    .line 303
    iget-object v8, v0, Landroidx/constraintlayout/widget/b;->h:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 304
    .line 305
    if-eqz v7, :cond_1b

    .line 306
    .line 307
    iget v9, v8, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 308
    .line 309
    const/16 v11, 0x100

    .line 310
    .line 311
    invoke-static {v9, v11}, Ld1/m;->c(II)Z

    .line 312
    .line 313
    .line 314
    move-result v9

    .line 315
    if-eqz v9, :cond_1b

    .line 316
    .line 317
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredWidth()I

    .line 318
    .line 319
    .line 320
    move-result v9

    .line 321
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 322
    .line 323
    .line 324
    move-result v11

    .line 325
    if-ne v9, v11, :cond_1b

    .line 326
    .line 327
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredWidth()I

    .line 328
    .line 329
    .line 330
    move-result v9

    .line 331
    invoke-virtual {v7}, Ld1/f;->r()I

    .line 332
    .line 333
    .line 334
    move-result v11

    .line 335
    if-ge v9, v11, :cond_1b

    .line 336
    .line 337
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredHeight()I

    .line 338
    .line 339
    .line 340
    move-result v9

    .line 341
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 342
    .line 343
    .line 344
    move-result v11

    .line 345
    if-ne v9, v11, :cond_1b

    .line 346
    .line 347
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredHeight()I

    .line 348
    .line 349
    .line 350
    move-result v9

    .line 351
    invoke-virtual {v7}, Ld1/f;->l()I

    .line 352
    .line 353
    .line 354
    move-result v7

    .line 355
    if-ge v9, v7, :cond_1b

    .line 356
    .line 357
    invoke-virtual {v10}, Landroid/view/View;->getBaseline()I

    .line 358
    .line 359
    .line 360
    move-result v7

    .line 361
    iget v9, v1, Ld1/f;->c0:I

    .line 362
    .line 363
    if-ne v7, v9, :cond_1b

    .line 364
    .line 365
    invoke-virtual/range {p1 .. p1}, Ld1/f;->A()Z

    .line 366
    .line 367
    .line 368
    move-result v7

    .line 369
    if-nez v7, :cond_1b

    .line 370
    .line 371
    iget v7, v1, Ld1/f;->H:I

    .line 372
    .line 373
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 374
    .line 375
    .line 376
    move-result v9

    .line 377
    invoke-static {v7, v6, v9}, Landroidx/constraintlayout/widget/b;->a(III)Z

    .line 378
    .line 379
    .line 380
    move-result v7

    .line 381
    if-eqz v7, :cond_1b

    .line 382
    .line 383
    iget v7, v1, Ld1/f;->I:I

    .line 384
    .line 385
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 386
    .line 387
    .line 388
    move-result v9

    .line 389
    invoke-static {v7, v5, v9}, Landroidx/constraintlayout/widget/b;->a(III)Z

    .line 390
    .line 391
    .line 392
    move-result v7

    .line 393
    if-eqz v7, :cond_1b

    .line 394
    .line 395
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 396
    .line 397
    .line 398
    move-result v3

    .line 399
    iput v3, v2, Le1/b;->e:I

    .line 400
    .line 401
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 402
    .line 403
    .line 404
    move-result v3

    .line 405
    iput v3, v2, Le1/b;->f:I

    .line 406
    .line 407
    iget v1, v1, Ld1/f;->c0:I

    .line 408
    .line 409
    iput v1, v2, Le1/b;->g:I

    .line 410
    .line 411
    return-void

    .line 412
    :cond_1b
    sget-object v7, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 413
    .line 414
    if-ne v3, v7, :cond_1c

    .line 415
    .line 416
    const/4 v9, 0x1

    .line 417
    goto :goto_9

    .line 418
    :cond_1c
    const/4 v9, 0x0

    .line 419
    :goto_9
    if-ne v4, v7, :cond_1d

    .line 420
    .line 421
    const/4 v7, 0x1

    .line 422
    goto :goto_a

    .line 423
    :cond_1d
    const/4 v7, 0x0

    .line 424
    :goto_a
    sget-object v11, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 425
    .line 426
    if-eq v4, v11, :cond_1f

    .line 427
    .line 428
    sget-object v12, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 429
    .line 430
    if-ne v4, v12, :cond_1e

    .line 431
    .line 432
    goto :goto_b

    .line 433
    :cond_1e
    const/4 v4, 0x0

    .line 434
    goto :goto_c

    .line 435
    :cond_1f
    :goto_b
    const/4 v4, 0x1

    .line 436
    :goto_c
    if-eq v3, v11, :cond_21

    .line 437
    .line 438
    sget-object v11, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 439
    .line 440
    if-ne v3, v11, :cond_20

    .line 441
    .line 442
    goto :goto_d

    .line 443
    :cond_20
    const/4 v3, 0x0

    .line 444
    goto :goto_e

    .line 445
    :cond_21
    :goto_d
    const/4 v3, 0x1

    .line 446
    :goto_e
    const/4 v11, 0x0

    .line 447
    if-eqz v9, :cond_22

    .line 448
    .line 449
    iget v12, v1, Ld1/f;->Y:F

    .line 450
    .line 451
    cmpl-float v12, v12, v11

    .line 452
    .line 453
    if-lez v12, :cond_22

    .line 454
    .line 455
    const/4 v12, 0x1

    .line 456
    goto :goto_f

    .line 457
    :cond_22
    const/4 v12, 0x0

    .line 458
    :goto_f
    if-eqz v7, :cond_23

    .line 459
    .line 460
    iget v13, v1, Ld1/f;->Y:F

    .line 461
    .line 462
    cmpl-float v11, v13, v11

    .line 463
    .line 464
    if-lez v11, :cond_23

    .line 465
    .line 466
    const/4 v11, 0x1

    .line 467
    goto :goto_10

    .line 468
    :cond_23
    const/4 v11, 0x0

    .line 469
    :goto_10
    if-nez v10, :cond_24

    .line 470
    .line 471
    return-void

    .line 472
    :cond_24
    invoke-virtual {v10}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 473
    .line 474
    .line 475
    move-result-object v13

    .line 476
    check-cast v13, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 477
    .line 478
    iget v14, v2, Le1/b;->j:I

    .line 479
    .line 480
    const/4 v0, 0x1

    .line 481
    if-eq v14, v0, :cond_26

    .line 482
    .line 483
    if-eq v14, v15, :cond_26

    .line 484
    .line 485
    if-eqz v9, :cond_26

    .line 486
    .line 487
    iget v0, v1, Ld1/f;->r:I

    .line 488
    .line 489
    if-nez v0, :cond_26

    .line 490
    .line 491
    if-eqz v7, :cond_26

    .line 492
    .line 493
    iget v0, v1, Ld1/f;->s:I

    .line 494
    .line 495
    if-eqz v0, :cond_25

    .line 496
    .line 497
    goto :goto_11

    .line 498
    :cond_25
    const/4 v0, 0x0

    .line 499
    const/4 v3, -0x1

    .line 500
    const/4 v9, 0x0

    .line 501
    const/4 v14, 0x0

    .line 502
    const/4 v15, 0x0

    .line 503
    goto/16 :goto_19

    .line 504
    .line 505
    :cond_26
    :goto_11
    instance-of v0, v10, Landroidx/constraintlayout/widget/VirtualLayout;

    .line 506
    .line 507
    if-eqz v0, :cond_27

    .line 508
    .line 509
    instance-of v0, v1, Ld1/o;

    .line 510
    .line 511
    if-eqz v0, :cond_27

    .line 512
    .line 513
    move-object v0, v1

    .line 514
    check-cast v0, Ld1/o;

    .line 515
    .line 516
    move-object v7, v10

    .line 517
    check-cast v7, Landroidx/constraintlayout/widget/VirtualLayout;

    .line 518
    .line 519
    invoke-virtual {v7, v0, v6, v5}, Landroidx/constraintlayout/widget/VirtualLayout;->r(Ld1/o;II)V

    .line 520
    .line 521
    .line 522
    goto :goto_12

    .line 523
    :cond_27
    invoke-virtual {v10, v6, v5}, Landroid/view/View;->measure(II)V

    .line 524
    .line 525
    .line 526
    :goto_12
    iput v6, v1, Ld1/f;->H:I

    .line 527
    .line 528
    iput v5, v1, Ld1/f;->I:I

    .line 529
    .line 530
    const/4 v0, 0x0

    .line 531
    iput-boolean v0, v1, Ld1/f;->g:Z

    .line 532
    .line 533
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredWidth()I

    .line 534
    .line 535
    .line 536
    move-result v0

    .line 537
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredHeight()I

    .line 538
    .line 539
    .line 540
    move-result v7

    .line 541
    invoke-virtual {v10}, Landroid/view/View;->getBaseline()I

    .line 542
    .line 543
    .line 544
    move-result v9

    .line 545
    iget v14, v1, Ld1/f;->u:I

    .line 546
    .line 547
    if-lez v14, :cond_28

    .line 548
    .line 549
    invoke-static {v14, v0}, Ljava/lang/Math;->max(II)I

    .line 550
    .line 551
    .line 552
    move-result v14

    .line 553
    goto :goto_13

    .line 554
    :cond_28
    move v14, v0

    .line 555
    :goto_13
    iget v15, v1, Ld1/f;->v:I

    .line 556
    .line 557
    if-lez v15, :cond_29

    .line 558
    .line 559
    invoke-static {v15, v14}, Ljava/lang/Math;->min(II)I

    .line 560
    .line 561
    .line 562
    move-result v14

    .line 563
    :cond_29
    iget v15, v1, Ld1/f;->x:I

    .line 564
    .line 565
    if-lez v15, :cond_2a

    .line 566
    .line 567
    invoke-static {v15, v7}, Ljava/lang/Math;->max(II)I

    .line 568
    .line 569
    .line 570
    move-result v15

    .line 571
    move/from16 v16, v5

    .line 572
    .line 573
    goto :goto_14

    .line 574
    :cond_2a
    move/from16 v16, v5

    .line 575
    .line 576
    move v15, v7

    .line 577
    :goto_14
    iget v5, v1, Ld1/f;->y:I

    .line 578
    .line 579
    if-lez v5, :cond_2b

    .line 580
    .line 581
    invoke-static {v5, v15}, Ljava/lang/Math;->min(II)I

    .line 582
    .line 583
    .line 584
    move-result v15

    .line 585
    :cond_2b
    iget v5, v8, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 586
    .line 587
    const/4 v8, 0x1

    .line 588
    invoke-static {v5, v8}, Ld1/m;->c(II)Z

    .line 589
    .line 590
    .line 591
    move-result v5

    .line 592
    if-nez v5, :cond_2d

    .line 593
    .line 594
    const/high16 v5, 0x3f000000    # 0.5f

    .line 595
    .line 596
    if-eqz v12, :cond_2c

    .line 597
    .line 598
    if-eqz v4, :cond_2c

    .line 599
    .line 600
    iget v3, v1, Ld1/f;->Y:F

    .line 601
    .line 602
    int-to-float v4, v15

    .line 603
    mul-float/2addr v4, v3

    .line 604
    add-float/2addr v4, v5

    .line 605
    float-to-int v3, v4

    .line 606
    move v14, v3

    .line 607
    goto :goto_15

    .line 608
    :cond_2c
    if-eqz v11, :cond_2d

    .line 609
    .line 610
    if-eqz v3, :cond_2d

    .line 611
    .line 612
    iget v3, v1, Ld1/f;->Y:F

    .line 613
    .line 614
    int-to-float v4, v14

    .line 615
    div-float/2addr v4, v3

    .line 616
    add-float/2addr v4, v5

    .line 617
    float-to-int v3, v4

    .line 618
    move v15, v3

    .line 619
    :cond_2d
    :goto_15
    if-ne v0, v14, :cond_2f

    .line 620
    .line 621
    if-eq v7, v15, :cond_2e

    .line 622
    .line 623
    goto :goto_16

    .line 624
    :cond_2e
    move v0, v9

    .line 625
    const/4 v3, -0x1

    .line 626
    const/4 v9, 0x0

    .line 627
    goto :goto_19

    .line 628
    :cond_2f
    :goto_16
    if-eq v0, v14, :cond_30

    .line 629
    .line 630
    const/high16 v0, 0x40000000    # 2.0f

    .line 631
    .line 632
    invoke-static {v14, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 633
    .line 634
    .line 635
    move-result v6

    .line 636
    goto :goto_17

    .line 637
    :cond_30
    const/high16 v0, 0x40000000    # 2.0f

    .line 638
    .line 639
    :goto_17
    if-eq v7, v15, :cond_31

    .line 640
    .line 641
    invoke-static {v15, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    .line 642
    .line 643
    .line 644
    move-result v5

    .line 645
    goto :goto_18

    .line 646
    :cond_31
    move/from16 v5, v16

    .line 647
    .line 648
    :goto_18
    invoke-virtual {v10, v6, v5}, Landroid/view/View;->measure(II)V

    .line 649
    .line 650
    .line 651
    iput v6, v1, Ld1/f;->H:I

    .line 652
    .line 653
    iput v5, v1, Ld1/f;->I:I

    .line 654
    .line 655
    const/4 v9, 0x0

    .line 656
    iput-boolean v9, v1, Ld1/f;->g:Z

    .line 657
    .line 658
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredWidth()I

    .line 659
    .line 660
    .line 661
    move-result v0

    .line 662
    invoke-virtual {v10}, Landroid/view/View;->getMeasuredHeight()I

    .line 663
    .line 664
    .line 665
    move-result v3

    .line 666
    invoke-virtual {v10}, Landroid/view/View;->getBaseline()I

    .line 667
    .line 668
    .line 669
    move-result v4

    .line 670
    move v14, v0

    .line 671
    move v15, v3

    .line 672
    move v0, v4

    .line 673
    const/4 v3, -0x1

    .line 674
    :goto_19
    if-eq v0, v3, :cond_32

    .line 675
    .line 676
    const/4 v3, 0x1

    .line 677
    goto :goto_1a

    .line 678
    :cond_32
    move v3, v9

    .line 679
    :goto_1a
    iget v4, v2, Le1/b;->c:I

    .line 680
    .line 681
    if-ne v14, v4, :cond_34

    .line 682
    .line 683
    iget v4, v2, Le1/b;->d:I

    .line 684
    .line 685
    if-eq v15, v4, :cond_33

    .line 686
    .line 687
    goto :goto_1b

    .line 688
    :cond_33
    move v5, v9

    .line 689
    goto :goto_1c

    .line 690
    :cond_34
    :goto_1b
    const/4 v5, 0x1

    .line 691
    :goto_1c
    iput-boolean v5, v2, Le1/b;->i:Z

    .line 692
    .line 693
    iget-boolean v4, v13, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->c0:Z

    .line 694
    .line 695
    if-eqz v4, :cond_35

    .line 696
    .line 697
    const/4 v9, 0x1

    .line 698
    goto :goto_1d

    .line 699
    :cond_35
    move v9, v3

    .line 700
    :goto_1d
    if-eqz v9, :cond_36

    .line 701
    .line 702
    const/4 v3, -0x1

    .line 703
    if-eq v0, v3, :cond_36

    .line 704
    .line 705
    iget v1, v1, Ld1/f;->c0:I

    .line 706
    .line 707
    if-eq v1, v0, :cond_36

    .line 708
    .line 709
    const/4 v1, 0x1

    .line 710
    iput-boolean v1, v2, Le1/b;->i:Z

    .line 711
    .line 712
    :cond_36
    iput v14, v2, Le1/b;->e:I

    .line 713
    .line 714
    iput v15, v2, Le1/b;->f:I

    .line 715
    .line 716
    iput-boolean v9, v2, Le1/b;->h:Z

    .line 717
    .line 718
    iput v0, v2, Le1/b;->g:I

    .line 719
    .line 720
    return-void
.end method
