.class public final Landroidx/constraintlayout/core/widgets/analyzer/e;
.super Landroidx/constraintlayout/core/widgets/analyzer/h;
.source "SourceFile"


# static fields
.field public static final k:[I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    const/4 v0, 0x2

    .line 2
    new-array v0, v0, [I

    .line 3
    .line 4
    sput-object v0, Landroidx/constraintlayout/core/widgets/analyzer/e;->k:[I

    .line 5
    .line 6
    return-void
.end method

.method public constructor <init>(Ld1/f;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1}, Landroidx/constraintlayout/core/widgets/analyzer/h;-><init>(Ld1/f;)V

    .line 2
    .line 3
    .line 4
    iget-object p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 5
    .line 6
    sget-object v0, Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;->LEFT:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 7
    .line 8
    iput-object v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->e:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 9
    .line 10
    iget-object p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 11
    .line 12
    sget-object v0, Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 13
    .line 14
    iput-object v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->e:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 15
    .line 16
    const/4 p1, 0x0

    .line 17
    iput p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->f:I

    .line 18
    .line 19
    return-void
.end method

.method public static m([IIIIIFI)V
    .locals 2

    .line 1
    sub-int/2addr p2, p1

    .line 2
    sub-int/2addr p4, p3

    .line 3
    const/4 p1, -0x1

    .line 4
    const/4 p3, 0x0

    .line 5
    const/high16 v0, 0x3f000000    # 0.5f

    .line 6
    .line 7
    const/4 v1, 0x1

    .line 8
    if-eq p6, p1, :cond_2

    .line 9
    .line 10
    if-eqz p6, :cond_1

    .line 11
    .line 12
    if-eq p6, v1, :cond_0

    .line 13
    .line 14
    goto :goto_0

    .line 15
    :cond_0
    int-to-float p1, p2

    .line 16
    mul-float/2addr p1, p5

    .line 17
    add-float/2addr p1, v0

    .line 18
    float-to-int p1, p1

    .line 19
    aput p2, p0, p3

    .line 20
    .line 21
    aput p1, p0, v1

    .line 22
    .line 23
    goto :goto_0

    .line 24
    :cond_1
    int-to-float p1, p4

    .line 25
    mul-float/2addr p1, p5

    .line 26
    add-float/2addr p1, v0

    .line 27
    float-to-int p1, p1

    .line 28
    aput p1, p0, p3

    .line 29
    .line 30
    aput p4, p0, v1

    .line 31
    .line 32
    goto :goto_0

    .line 33
    :cond_2
    int-to-float p1, p4

    .line 34
    mul-float/2addr p1, p5

    .line 35
    add-float/2addr p1, v0

    .line 36
    float-to-int p1, p1

    .line 37
    int-to-float p6, p2

    .line 38
    div-float/2addr p6, p5

    .line 39
    add-float/2addr p6, v0

    .line 40
    float-to-int p5, p6

    .line 41
    if-gt p1, p2, :cond_3

    .line 42
    .line 43
    aput p1, p0, p3

    .line 44
    .line 45
    aput p4, p0, v1

    .line 46
    .line 47
    goto :goto_0

    .line 48
    :cond_3
    if-gt p5, p4, :cond_4

    .line 49
    .line 50
    aput p2, p0, p3

    .line 51
    .line 52
    aput p5, p0, v1

    .line 53
    .line 54
    :cond_4
    :goto_0
    return-void
.end method


# virtual methods
.method public final a(Le1/e;)V
    .locals 22

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    sget-object v1, Landroidx/constraintlayout/core/widgets/analyzer/d;->a:[I

    .line 4
    .line 5
    iget-object v2, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->j:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 6
    .line 7
    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    .line 8
    .line 9
    .line 10
    move-result v2

    .line 11
    aget v1, v1, v2

    .line 12
    .line 13
    const/4 v2, 0x0

    .line 14
    const/4 v3, 0x3

    .line 15
    if-eq v1, v3, :cond_2a

    .line 16
    .line 17
    iget-object v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 18
    .line 19
    iget-boolean v4, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 20
    .line 21
    iget-object v5, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 22
    .line 23
    iget-object v6, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 24
    .line 25
    const/high16 v7, 0x3f000000    # 0.5f

    .line 26
    .line 27
    const/4 v8, 0x1

    .line 28
    if-nez v4, :cond_21

    .line 29
    .line 30
    iget-object v4, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 31
    .line 32
    sget-object v9, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 33
    .line 34
    if-ne v4, v9, :cond_21

    .line 35
    .line 36
    iget-object v4, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 37
    .line 38
    iget v9, v4, Ld1/f;->r:I

    .line 39
    .line 40
    const/4 v10, 0x2

    .line 41
    if-eq v9, v10, :cond_20

    .line 42
    .line 43
    if-eq v9, v3, :cond_0

    .line 44
    .line 45
    goto/16 :goto_e

    .line 46
    .line 47
    :cond_0
    iget v9, v4, Ld1/f;->s:I

    .line 48
    .line 49
    const/4 v10, -0x1

    .line 50
    if-eqz v9, :cond_5

    .line 51
    .line 52
    if-ne v9, v3, :cond_1

    .line 53
    .line 54
    goto :goto_3

    .line 55
    :cond_1
    iget v3, v4, Ld1/f;->Z:I

    .line 56
    .line 57
    if-eq v3, v10, :cond_4

    .line 58
    .line 59
    if-eqz v3, :cond_3

    .line 60
    .line 61
    if-eq v3, v8, :cond_2

    .line 62
    .line 63
    move v3, v2

    .line 64
    goto :goto_2

    .line 65
    :cond_2
    iget-object v3, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 66
    .line 67
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 68
    .line 69
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 70
    .line 71
    int-to-float v3, v3

    .line 72
    iget v4, v4, Ld1/f;->Y:F

    .line 73
    .line 74
    :goto_0
    mul-float/2addr v3, v4

    .line 75
    :goto_1
    add-float/2addr v3, v7

    .line 76
    float-to-int v3, v3

    .line 77
    goto :goto_2

    .line 78
    :cond_3
    iget-object v3, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 79
    .line 80
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 81
    .line 82
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 83
    .line 84
    int-to-float v3, v3

    .line 85
    iget v4, v4, Ld1/f;->Y:F

    .line 86
    .line 87
    div-float/2addr v3, v4

    .line 88
    goto :goto_1

    .line 89
    :cond_4
    iget-object v3, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 90
    .line 91
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 92
    .line 93
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 94
    .line 95
    int-to-float v3, v3

    .line 96
    iget v4, v4, Ld1/f;->Y:F

    .line 97
    .line 98
    goto :goto_0

    .line 99
    :goto_2
    invoke-virtual {v1, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 100
    .line 101
    .line 102
    goto/16 :goto_e

    .line 103
    .line 104
    :cond_5
    :goto_3
    iget-object v3, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 105
    .line 106
    iget-object v9, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 107
    .line 108
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 109
    .line 110
    iget-object v11, v4, Ld1/f;->J:Ld1/d;

    .line 111
    .line 112
    iget-object v11, v11, Ld1/d;->f:Ld1/d;

    .line 113
    .line 114
    if-eqz v11, :cond_6

    .line 115
    .line 116
    move v11, v8

    .line 117
    goto :goto_4

    .line 118
    :cond_6
    move v11, v2

    .line 119
    :goto_4
    iget-object v12, v4, Ld1/f;->K:Ld1/d;

    .line 120
    .line 121
    iget-object v12, v12, Ld1/d;->f:Ld1/d;

    .line 122
    .line 123
    if-eqz v12, :cond_7

    .line 124
    .line 125
    move v12, v8

    .line 126
    goto :goto_5

    .line 127
    :cond_7
    move v12, v2

    .line 128
    :goto_5
    iget-object v13, v4, Ld1/f;->L:Ld1/d;

    .line 129
    .line 130
    iget-object v13, v13, Ld1/d;->f:Ld1/d;

    .line 131
    .line 132
    if-eqz v13, :cond_8

    .line 133
    .line 134
    move v13, v8

    .line 135
    goto :goto_6

    .line 136
    :cond_8
    move v13, v2

    .line 137
    :goto_6
    iget-object v14, v4, Ld1/f;->M:Ld1/d;

    .line 138
    .line 139
    iget-object v14, v14, Ld1/d;->f:Ld1/d;

    .line 140
    .line 141
    if-eqz v14, :cond_9

    .line 142
    .line 143
    move v14, v8

    .line 144
    goto :goto_7

    .line 145
    :cond_9
    move v14, v2

    .line 146
    :goto_7
    iget v15, v4, Ld1/f;->Z:I

    .line 147
    .line 148
    if-eqz v11, :cond_12

    .line 149
    .line 150
    if-eqz v12, :cond_12

    .line 151
    .line 152
    if-eqz v13, :cond_12

    .line 153
    .line 154
    if-eqz v14, :cond_12

    .line 155
    .line 156
    iget v4, v4, Ld1/f;->Y:F

    .line 157
    .line 158
    iget-boolean v10, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 159
    .line 160
    sget-object v11, Landroidx/constraintlayout/core/widgets/analyzer/e;->k:[I

    .line 161
    .line 162
    if-eqz v10, :cond_c

    .line 163
    .line 164
    iget-boolean v10, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 165
    .line 166
    if-eqz v10, :cond_c

    .line 167
    .line 168
    iget-boolean v7, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 169
    .line 170
    if-eqz v7, :cond_b

    .line 171
    .line 172
    iget-boolean v7, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 173
    .line 174
    if-nez v7, :cond_a

    .line 175
    .line 176
    goto :goto_8

    .line 177
    :cond_a
    iget-object v7, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 178
    .line 179
    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 180
    .line 181
    .line 182
    move-result-object v7

    .line 183
    check-cast v7, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 184
    .line 185
    iget v7, v7, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 186
    .line 187
    iget v5, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 188
    .line 189
    add-int v16, v7, v5

    .line 190
    .line 191
    iget-object v5, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 192
    .line 193
    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 194
    .line 195
    .line 196
    move-result-object v5

    .line 197
    check-cast v5, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 198
    .line 199
    iget v5, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 200
    .line 201
    iget v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 202
    .line 203
    sub-int v17, v5, v6

    .line 204
    .line 205
    iget v5, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 206
    .line 207
    iget v6, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 208
    .line 209
    add-int v18, v5, v6

    .line 210
    .line 211
    iget v5, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 212
    .line 213
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 214
    .line 215
    sub-int v19, v5, v3

    .line 216
    .line 217
    move v10, v15

    .line 218
    move-object v15, v11

    .line 219
    move/from16 v20, v4

    .line 220
    .line 221
    move/from16 v21, v10

    .line 222
    .line 223
    invoke-static/range {v15 .. v21}, Landroidx/constraintlayout/core/widgets/analyzer/e;->m([IIIIIFI)V

    .line 224
    .line 225
    .line 226
    aget v2, v11, v2

    .line 227
    .line 228
    invoke-virtual {v1, v2}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 229
    .line 230
    .line 231
    iget-object v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 232
    .line 233
    iget-object v1, v1, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 234
    .line 235
    iget-object v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 236
    .line 237
    aget v2, v11, v8

    .line 238
    .line 239
    invoke-virtual {v1, v2}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 240
    .line 241
    .line 242
    :cond_b
    :goto_8
    return-void

    .line 243
    :cond_c
    move v10, v15

    .line 244
    iget-boolean v12, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 245
    .line 246
    iget-object v13, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 247
    .line 248
    if-eqz v12, :cond_f

    .line 249
    .line 250
    iget-boolean v12, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 251
    .line 252
    if-eqz v12, :cond_f

    .line 253
    .line 254
    iget-boolean v12, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 255
    .line 256
    if-eqz v12, :cond_e

    .line 257
    .line 258
    iget-boolean v12, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 259
    .line 260
    if-nez v12, :cond_d

    .line 261
    .line 262
    goto :goto_9

    .line 263
    :cond_d
    iget v12, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 264
    .line 265
    iget v14, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 266
    .line 267
    add-int v16, v12, v14

    .line 268
    .line 269
    iget v12, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 270
    .line 271
    iget v14, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 272
    .line 273
    sub-int v17, v12, v14

    .line 274
    .line 275
    invoke-virtual {v13, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 276
    .line 277
    .line 278
    move-result-object v12

    .line 279
    check-cast v12, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 280
    .line 281
    iget v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 282
    .line 283
    iget v14, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 284
    .line 285
    add-int v18, v12, v14

    .line 286
    .line 287
    iget-object v12, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 288
    .line 289
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 290
    .line 291
    .line 292
    move-result-object v12

    .line 293
    check-cast v12, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 294
    .line 295
    iget v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 296
    .line 297
    iget v14, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 298
    .line 299
    sub-int v19, v12, v14

    .line 300
    .line 301
    move-object v15, v11

    .line 302
    move/from16 v20, v4

    .line 303
    .line 304
    move/from16 v21, v10

    .line 305
    .line 306
    invoke-static/range {v15 .. v21}, Landroidx/constraintlayout/core/widgets/analyzer/e;->m([IIIIIFI)V

    .line 307
    .line 308
    .line 309
    aget v12, v11, v2

    .line 310
    .line 311
    invoke-virtual {v1, v12}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 312
    .line 313
    .line 314
    iget-object v12, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 315
    .line 316
    iget-object v12, v12, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 317
    .line 318
    iget-object v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 319
    .line 320
    aget v14, v11, v8

    .line 321
    .line 322
    invoke-virtual {v12, v14}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 323
    .line 324
    .line 325
    goto :goto_a

    .line 326
    :cond_e
    :goto_9
    return-void

    .line 327
    :cond_f
    :goto_a
    iget-boolean v12, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 328
    .line 329
    if-eqz v12, :cond_11

    .line 330
    .line 331
    iget-boolean v12, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 332
    .line 333
    if-eqz v12, :cond_11

    .line 334
    .line 335
    iget-boolean v12, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 336
    .line 337
    if-eqz v12, :cond_11

    .line 338
    .line 339
    iget-boolean v12, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 340
    .line 341
    if-nez v12, :cond_10

    .line 342
    .line 343
    goto :goto_b

    .line 344
    :cond_10
    iget-object v12, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 345
    .line 346
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 347
    .line 348
    .line 349
    move-result-object v12

    .line 350
    check-cast v12, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 351
    .line 352
    iget v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 353
    .line 354
    iget v14, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 355
    .line 356
    add-int v16, v12, v14

    .line 357
    .line 358
    iget-object v12, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 359
    .line 360
    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 361
    .line 362
    .line 363
    move-result-object v12

    .line 364
    check-cast v12, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 365
    .line 366
    iget v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 367
    .line 368
    iget v14, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 369
    .line 370
    sub-int v17, v12, v14

    .line 371
    .line 372
    invoke-virtual {v13, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 373
    .line 374
    .line 375
    move-result-object v12

    .line 376
    check-cast v12, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 377
    .line 378
    iget v12, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 379
    .line 380
    iget v9, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 381
    .line 382
    add-int v18, v12, v9

    .line 383
    .line 384
    iget-object v9, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 385
    .line 386
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 387
    .line 388
    .line 389
    move-result-object v9

    .line 390
    check-cast v9, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 391
    .line 392
    iget v9, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 393
    .line 394
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 395
    .line 396
    sub-int v19, v9, v3

    .line 397
    .line 398
    move-object v15, v11

    .line 399
    move/from16 v20, v4

    .line 400
    .line 401
    move/from16 v21, v10

    .line 402
    .line 403
    invoke-static/range {v15 .. v21}, Landroidx/constraintlayout/core/widgets/analyzer/e;->m([IIIIIFI)V

    .line 404
    .line 405
    .line 406
    aget v3, v11, v2

    .line 407
    .line 408
    invoke-virtual {v1, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 409
    .line 410
    .line 411
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 412
    .line 413
    iget-object v3, v3, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 414
    .line 415
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 416
    .line 417
    aget v4, v11, v8

    .line 418
    .line 419
    invoke-virtual {v3, v4}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 420
    .line 421
    .line 422
    goto/16 :goto_e

    .line 423
    .line 424
    :cond_11
    :goto_b
    return-void

    .line 425
    :cond_12
    if-eqz v11, :cond_19

    .line 426
    .line 427
    if-eqz v13, :cond_19

    .line 428
    .line 429
    iget-boolean v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 430
    .line 431
    if-eqz v3, :cond_18

    .line 432
    .line 433
    iget-boolean v3, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 434
    .line 435
    if-nez v3, :cond_13

    .line 436
    .line 437
    goto :goto_c

    .line 438
    :cond_13
    iget v3, v4, Ld1/f;->Y:F

    .line 439
    .line 440
    iget-object v4, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 441
    .line 442
    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 443
    .line 444
    .line 445
    move-result-object v4

    .line 446
    check-cast v4, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 447
    .line 448
    iget v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 449
    .line 450
    iget v9, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 451
    .line 452
    add-int/2addr v4, v9

    .line 453
    iget-object v9, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 454
    .line 455
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 456
    .line 457
    .line 458
    move-result-object v9

    .line 459
    check-cast v9, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 460
    .line 461
    iget v9, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 462
    .line 463
    iget v11, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 464
    .line 465
    sub-int/2addr v9, v11

    .line 466
    if-eq v15, v10, :cond_16

    .line 467
    .line 468
    if-eqz v15, :cond_16

    .line 469
    .line 470
    if-eq v15, v8, :cond_14

    .line 471
    .line 472
    goto/16 :goto_e

    .line 473
    .line 474
    :cond_14
    sub-int/2addr v9, v4

    .line 475
    invoke-virtual {v0, v9, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 476
    .line 477
    .line 478
    move-result v4

    .line 479
    int-to-float v9, v4

    .line 480
    div-float/2addr v9, v3

    .line 481
    add-float/2addr v9, v7

    .line 482
    float-to-int v9, v9

    .line 483
    invoke-virtual {v0, v9, v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 484
    .line 485
    .line 486
    move-result v10

    .line 487
    if-eq v9, v10, :cond_15

    .line 488
    .line 489
    int-to-float v4, v10

    .line 490
    mul-float/2addr v4, v3

    .line 491
    add-float/2addr v4, v7

    .line 492
    float-to-int v4, v4

    .line 493
    :cond_15
    invoke-virtual {v1, v4}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 494
    .line 495
    .line 496
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 497
    .line 498
    iget-object v3, v3, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 499
    .line 500
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 501
    .line 502
    invoke-virtual {v3, v10}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 503
    .line 504
    .line 505
    goto/16 :goto_e

    .line 506
    .line 507
    :cond_16
    sub-int/2addr v9, v4

    .line 508
    invoke-virtual {v0, v9, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 509
    .line 510
    .line 511
    move-result v4

    .line 512
    int-to-float v9, v4

    .line 513
    mul-float/2addr v9, v3

    .line 514
    add-float/2addr v9, v7

    .line 515
    float-to-int v9, v9

    .line 516
    invoke-virtual {v0, v9, v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 517
    .line 518
    .line 519
    move-result v10

    .line 520
    if-eq v9, v10, :cond_17

    .line 521
    .line 522
    int-to-float v4, v10

    .line 523
    div-float/2addr v4, v3

    .line 524
    add-float/2addr v4, v7

    .line 525
    float-to-int v4, v4

    .line 526
    :cond_17
    invoke-virtual {v1, v4}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 527
    .line 528
    .line 529
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 530
    .line 531
    iget-object v3, v3, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 532
    .line 533
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 534
    .line 535
    invoke-virtual {v3, v10}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 536
    .line 537
    .line 538
    goto/16 :goto_e

    .line 539
    .line 540
    :cond_18
    :goto_c
    return-void

    .line 541
    :cond_19
    if-eqz v12, :cond_21

    .line 542
    .line 543
    if-eqz v14, :cond_21

    .line 544
    .line 545
    iget-boolean v11, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 546
    .line 547
    if-eqz v11, :cond_1f

    .line 548
    .line 549
    iget-boolean v11, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 550
    .line 551
    if-nez v11, :cond_1a

    .line 552
    .line 553
    goto :goto_d

    .line 554
    :cond_1a
    iget v4, v4, Ld1/f;->Y:F

    .line 555
    .line 556
    iget-object v11, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 557
    .line 558
    invoke-virtual {v11, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 559
    .line 560
    .line 561
    move-result-object v11

    .line 562
    check-cast v11, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 563
    .line 564
    iget v11, v11, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 565
    .line 566
    iget v9, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 567
    .line 568
    add-int/2addr v11, v9

    .line 569
    iget-object v9, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 570
    .line 571
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 572
    .line 573
    .line 574
    move-result-object v9

    .line 575
    check-cast v9, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 576
    .line 577
    iget v9, v9, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 578
    .line 579
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 580
    .line 581
    sub-int/2addr v9, v3

    .line 582
    if-eq v15, v10, :cond_1d

    .line 583
    .line 584
    if-eqz v15, :cond_1b

    .line 585
    .line 586
    if-eq v15, v8, :cond_1d

    .line 587
    .line 588
    goto :goto_e

    .line 589
    :cond_1b
    sub-int/2addr v9, v11

    .line 590
    invoke-virtual {v0, v9, v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 591
    .line 592
    .line 593
    move-result v3

    .line 594
    int-to-float v9, v3

    .line 595
    mul-float/2addr v9, v4

    .line 596
    add-float/2addr v9, v7

    .line 597
    float-to-int v9, v9

    .line 598
    invoke-virtual {v0, v9, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 599
    .line 600
    .line 601
    move-result v10

    .line 602
    if-eq v9, v10, :cond_1c

    .line 603
    .line 604
    int-to-float v3, v10

    .line 605
    div-float/2addr v3, v4

    .line 606
    add-float/2addr v3, v7

    .line 607
    float-to-int v3, v3

    .line 608
    :cond_1c
    invoke-virtual {v1, v10}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 609
    .line 610
    .line 611
    iget-object v4, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 612
    .line 613
    iget-object v4, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 614
    .line 615
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 616
    .line 617
    invoke-virtual {v4, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 618
    .line 619
    .line 620
    goto :goto_e

    .line 621
    :cond_1d
    sub-int/2addr v9, v11

    .line 622
    invoke-virtual {v0, v9, v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 623
    .line 624
    .line 625
    move-result v3

    .line 626
    int-to-float v9, v3

    .line 627
    div-float/2addr v9, v4

    .line 628
    add-float/2addr v9, v7

    .line 629
    float-to-int v9, v9

    .line 630
    invoke-virtual {v0, v9, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->g(II)I

    .line 631
    .line 632
    .line 633
    move-result v10

    .line 634
    if-eq v9, v10, :cond_1e

    .line 635
    .line 636
    int-to-float v3, v10

    .line 637
    mul-float/2addr v3, v4

    .line 638
    add-float/2addr v3, v7

    .line 639
    float-to-int v3, v3

    .line 640
    :cond_1e
    invoke-virtual {v1, v10}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 641
    .line 642
    .line 643
    iget-object v4, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 644
    .line 645
    iget-object v4, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 646
    .line 647
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 648
    .line 649
    invoke-virtual {v4, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 650
    .line 651
    .line 652
    goto :goto_e

    .line 653
    :cond_1f
    :goto_d
    return-void

    .line 654
    :cond_20
    iget-object v3, v4, Ld1/f;->V:Ld1/f;

    .line 655
    .line 656
    if-eqz v3, :cond_21

    .line 657
    .line 658
    iget-object v3, v3, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 659
    .line 660
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 661
    .line 662
    iget-boolean v9, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 663
    .line 664
    if-eqz v9, :cond_21

    .line 665
    .line 666
    iget v4, v4, Ld1/f;->w:F

    .line 667
    .line 668
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 669
    .line 670
    int-to-float v3, v3

    .line 671
    mul-float/2addr v3, v4

    .line 672
    add-float/2addr v3, v7

    .line 673
    float-to-int v3, v3

    .line 674
    invoke-virtual {v1, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 675
    .line 676
    .line 677
    :cond_21
    :goto_e
    iget-boolean v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 678
    .line 679
    if-eqz v3, :cond_29

    .line 680
    .line 681
    iget-boolean v3, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 682
    .line 683
    if-nez v3, :cond_22

    .line 684
    .line 685
    goto/16 :goto_10

    .line 686
    .line 687
    :cond_22
    iget-boolean v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 688
    .line 689
    if-eqz v3, :cond_23

    .line 690
    .line 691
    iget-boolean v3, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 692
    .line 693
    if-eqz v3, :cond_23

    .line 694
    .line 695
    iget-boolean v3, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 696
    .line 697
    if-eqz v3, :cond_23

    .line 698
    .line 699
    return-void

    .line 700
    :cond_23
    iget-boolean v3, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 701
    .line 702
    if-nez v3, :cond_24

    .line 703
    .line 704
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 705
    .line 706
    sget-object v4, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 707
    .line 708
    if-ne v3, v4, :cond_24

    .line 709
    .line 710
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 711
    .line 712
    iget v4, v3, Ld1/f;->r:I

    .line 713
    .line 714
    if-nez v4, :cond_24

    .line 715
    .line 716
    invoke-virtual {v3}, Ld1/f;->y()Z

    .line 717
    .line 718
    .line 719
    move-result v3

    .line 720
    if-nez v3, :cond_24

    .line 721
    .line 722
    iget-object v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 723
    .line 724
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 725
    .line 726
    .line 727
    move-result-object v3

    .line 728
    check-cast v3, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 729
    .line 730
    iget-object v4, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 731
    .line 732
    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 733
    .line 734
    .line 735
    move-result-object v2

    .line 736
    check-cast v2, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 737
    .line 738
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 739
    .line 740
    iget v4, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 741
    .line 742
    add-int/2addr v3, v4

    .line 743
    iget v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 744
    .line 745
    iget v4, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 746
    .line 747
    add-int/2addr v2, v4

    .line 748
    sub-int v4, v2, v3

    .line 749
    .line 750
    invoke-virtual {v5, v3}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 751
    .line 752
    .line 753
    invoke-virtual {v6, v2}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 754
    .line 755
    .line 756
    invoke-virtual {v1, v4}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 757
    .line 758
    .line 759
    return-void

    .line 760
    :cond_24
    iget-boolean v3, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 761
    .line 762
    if-nez v3, :cond_26

    .line 763
    .line 764
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 765
    .line 766
    sget-object v4, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 767
    .line 768
    if-ne v3, v4, :cond_26

    .line 769
    .line 770
    iget v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->a:I

    .line 771
    .line 772
    if-ne v3, v8, :cond_26

    .line 773
    .line 774
    iget-object v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 775
    .line 776
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 777
    .line 778
    .line 779
    move-result v3

    .line 780
    if-lez v3, :cond_26

    .line 781
    .line 782
    iget-object v3, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 783
    .line 784
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 785
    .line 786
    .line 787
    move-result v3

    .line 788
    if-lez v3, :cond_26

    .line 789
    .line 790
    iget-object v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 791
    .line 792
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 793
    .line 794
    .line 795
    move-result-object v3

    .line 796
    check-cast v3, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 797
    .line 798
    iget-object v4, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 799
    .line 800
    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 801
    .line 802
    .line 803
    move-result-object v4

    .line 804
    check-cast v4, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 805
    .line 806
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 807
    .line 808
    iget v8, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 809
    .line 810
    add-int/2addr v3, v8

    .line 811
    iget v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 812
    .line 813
    iget v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 814
    .line 815
    add-int/2addr v4, v8

    .line 816
    sub-int/2addr v4, v3

    .line 817
    iget v3, v1, Landroidx/constraintlayout/core/widgets/analyzer/b;->m:I

    .line 818
    .line 819
    invoke-static {v4, v3}, Ljava/lang/Math;->min(II)I

    .line 820
    .line 821
    .line 822
    move-result v3

    .line 823
    iget-object v4, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 824
    .line 825
    iget v8, v4, Ld1/f;->v:I

    .line 826
    .line 827
    iget v4, v4, Ld1/f;->u:I

    .line 828
    .line 829
    invoke-static {v4, v3}, Ljava/lang/Math;->max(II)I

    .line 830
    .line 831
    .line 832
    move-result v3

    .line 833
    if-lez v8, :cond_25

    .line 834
    .line 835
    invoke-static {v8, v3}, Ljava/lang/Math;->min(II)I

    .line 836
    .line 837
    .line 838
    move-result v3

    .line 839
    :cond_25
    invoke-virtual {v1, v3}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 840
    .line 841
    .line 842
    :cond_26
    iget-boolean v3, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 843
    .line 844
    if-nez v3, :cond_27

    .line 845
    .line 846
    return-void

    .line 847
    :cond_27
    iget-object v3, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 848
    .line 849
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 850
    .line 851
    .line 852
    move-result-object v3

    .line 853
    check-cast v3, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 854
    .line 855
    iget-object v4, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 856
    .line 857
    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 858
    .line 859
    .line 860
    move-result-object v2

    .line 861
    check-cast v2, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 862
    .line 863
    iget v4, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 864
    .line 865
    iget v8, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 866
    .line 867
    add-int/2addr v8, v4

    .line 868
    iget v9, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 869
    .line 870
    iget v10, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 871
    .line 872
    add-int/2addr v10, v9

    .line 873
    iget-object v11, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 874
    .line 875
    iget v11, v11, Ld1/f;->f0:F

    .line 876
    .line 877
    if-ne v3, v2, :cond_28

    .line 878
    .line 879
    move v11, v7

    .line 880
    goto :goto_f

    .line 881
    :cond_28
    move v4, v8

    .line 882
    move v9, v10

    .line 883
    :goto_f
    sub-int/2addr v9, v4

    .line 884
    iget v2, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 885
    .line 886
    sub-int/2addr v9, v2

    .line 887
    int-to-float v2, v4

    .line 888
    add-float/2addr v2, v7

    .line 889
    int-to-float v3, v9

    .line 890
    mul-float/2addr v3, v11

    .line 891
    add-float/2addr v3, v2

    .line 892
    float-to-int v2, v3

    .line 893
    invoke-virtual {v5, v2}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 894
    .line 895
    .line 896
    iget v2, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 897
    .line 898
    iget v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 899
    .line 900
    add-int/2addr v2, v1

    .line 901
    invoke-virtual {v6, v2}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 902
    .line 903
    .line 904
    :cond_29
    :goto_10
    return-void

    .line 905
    :cond_2a
    iget-object v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 906
    .line 907
    iget-object v3, v1, Ld1/f;->J:Ld1/d;

    .line 908
    .line 909
    iget-object v1, v1, Ld1/f;->L:Ld1/d;

    .line 910
    .line 911
    invoke-virtual {v0, v3, v1, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->l(Ld1/d;Ld1/d;I)V

    .line 912
    .line 913
    .line 914
    return-void
.end method

.method public final d()V
    .locals 10

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 2
    .line 3
    iget-boolean v1, v0, Ld1/f;->a:Z

    .line 4
    .line 5
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 6
    .line 7
    if-eqz v1, :cond_0

    .line 8
    .line 9
    invoke-virtual {v0}, Ld1/f;->r()I

    .line 10
    .line 11
    .line 12
    move-result v0

    .line 13
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 14
    .line 15
    .line 16
    :cond_0
    iget-boolean v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 17
    .line 18
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 19
    .line 20
    iget-object v3, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 21
    .line 22
    const/4 v4, 0x0

    .line 23
    if-nez v0, :cond_3

    .line 24
    .line 25
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 26
    .line 27
    iget-object v5, v0, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 28
    .line 29
    aget-object v5, v5, v4

    .line 30
    .line 31
    iput-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 32
    .line 33
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 34
    .line 35
    if-eq v5, v6, :cond_5

    .line 36
    .line 37
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 38
    .line 39
    if-ne v5, v6, :cond_2

    .line 40
    .line 41
    iget-object v7, v0, Ld1/f;->V:Ld1/f;

    .line 42
    .line 43
    if-eqz v7, :cond_2

    .line 44
    .line 45
    iget-object v8, v7, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 46
    .line 47
    aget-object v8, v8, v4

    .line 48
    .line 49
    sget-object v9, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 50
    .line 51
    if-eq v8, v9, :cond_1

    .line 52
    .line 53
    if-ne v8, v6, :cond_2

    .line 54
    .line 55
    :cond_1
    invoke-virtual {v7}, Ld1/f;->r()I

    .line 56
    .line 57
    .line 58
    move-result v0

    .line 59
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 60
    .line 61
    iget-object v4, v4, Ld1/f;->J:Ld1/d;

    .line 62
    .line 63
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 64
    .line 65
    .line 66
    move-result v4

    .line 67
    sub-int/2addr v0, v4

    .line 68
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 69
    .line 70
    iget-object v4, v4, Ld1/f;->L:Ld1/d;

    .line 71
    .line 72
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 73
    .line 74
    .line 75
    move-result v4

    .line 76
    sub-int/2addr v0, v4

    .line 77
    iget-object v4, v7, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 78
    .line 79
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 80
    .line 81
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 82
    .line 83
    iget-object v5, v5, Ld1/f;->J:Ld1/d;

    .line 84
    .line 85
    invoke-virtual {v5}, Ld1/d;->e()I

    .line 86
    .line 87
    .line 88
    move-result v5

    .line 89
    invoke-static {v3, v4, v5}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 90
    .line 91
    .line 92
    iget-object v3, v7, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 93
    .line 94
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 95
    .line 96
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 97
    .line 98
    iget-object v4, v4, Ld1/f;->L:Ld1/d;

    .line 99
    .line 100
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 101
    .line 102
    .line 103
    move-result v4

    .line 104
    neg-int v4, v4

    .line 105
    invoke-static {v1, v3, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 106
    .line 107
    .line 108
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 109
    .line 110
    .line 111
    return-void

    .line 112
    :cond_2
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 113
    .line 114
    if-ne v5, v6, :cond_5

    .line 115
    .line 116
    invoke-virtual {v0}, Ld1/f;->r()I

    .line 117
    .line 118
    .line 119
    move-result v0

    .line 120
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 121
    .line 122
    .line 123
    goto :goto_0

    .line 124
    :cond_3
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 125
    .line 126
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 127
    .line 128
    if-ne v0, v5, :cond_5

    .line 129
    .line 130
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 131
    .line 132
    iget-object v6, v0, Ld1/f;->V:Ld1/f;

    .line 133
    .line 134
    if-eqz v6, :cond_5

    .line 135
    .line 136
    iget-object v7, v6, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 137
    .line 138
    aget-object v7, v7, v4

    .line 139
    .line 140
    sget-object v8, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 141
    .line 142
    if-eq v7, v8, :cond_4

    .line 143
    .line 144
    if-ne v7, v5, :cond_5

    .line 145
    .line 146
    :cond_4
    iget-object v2, v6, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 147
    .line 148
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 149
    .line 150
    iget-object v0, v0, Ld1/f;->J:Ld1/d;

    .line 151
    .line 152
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 153
    .line 154
    .line 155
    move-result v0

    .line 156
    invoke-static {v3, v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 157
    .line 158
    .line 159
    iget-object v0, v6, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 160
    .line 161
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 162
    .line 163
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 164
    .line 165
    iget-object v2, v2, Ld1/f;->L:Ld1/d;

    .line 166
    .line 167
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 168
    .line 169
    .line 170
    move-result v2

    .line 171
    neg-int v2, v2

    .line 172
    invoke-static {v1, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 173
    .line 174
    .line 175
    return-void

    .line 176
    :cond_5
    :goto_0
    iget-boolean v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 177
    .line 178
    const/4 v5, 0x1

    .line 179
    if-eqz v0, :cond_c

    .line 180
    .line 181
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 182
    .line 183
    iget-boolean v6, v0, Ld1/f;->a:Z

    .line 184
    .line 185
    if-eqz v6, :cond_c

    .line 186
    .line 187
    iget-object v6, v0, Ld1/f;->R:[Ld1/d;

    .line 188
    .line 189
    aget-object v7, v6, v4

    .line 190
    .line 191
    iget-object v8, v7, Ld1/d;->f:Ld1/d;

    .line 192
    .line 193
    if-eqz v8, :cond_9

    .line 194
    .line 195
    aget-object v9, v6, v5

    .line 196
    .line 197
    iget-object v9, v9, Ld1/d;->f:Ld1/d;

    .line 198
    .line 199
    if-eqz v9, :cond_9

    .line 200
    .line 201
    invoke-virtual {v0}, Ld1/f;->y()Z

    .line 202
    .line 203
    .line 204
    move-result v0

    .line 205
    if-eqz v0, :cond_6

    .line 206
    .line 207
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 208
    .line 209
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 210
    .line 211
    aget-object v0, v0, v4

    .line 212
    .line 213
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 214
    .line 215
    .line 216
    move-result v0

    .line 217
    iput v0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 218
    .line 219
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 220
    .line 221
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 222
    .line 223
    aget-object v0, v0, v5

    .line 224
    .line 225
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 226
    .line 227
    .line 228
    move-result v0

    .line 229
    neg-int v0, v0

    .line 230
    iput v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 231
    .line 232
    goto/16 :goto_2

    .line 233
    .line 234
    :cond_6
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 235
    .line 236
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 237
    .line 238
    aget-object v0, v0, v4

    .line 239
    .line 240
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 241
    .line 242
    .line 243
    move-result-object v0

    .line 244
    if-eqz v0, :cond_7

    .line 245
    .line 246
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 247
    .line 248
    iget-object v2, v2, Ld1/f;->R:[Ld1/d;

    .line 249
    .line 250
    aget-object v2, v2, v4

    .line 251
    .line 252
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 253
    .line 254
    .line 255
    move-result v2

    .line 256
    invoke-static {v3, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 257
    .line 258
    .line 259
    :cond_7
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 260
    .line 261
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 262
    .line 263
    aget-object v0, v0, v5

    .line 264
    .line 265
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 266
    .line 267
    .line 268
    move-result-object v0

    .line 269
    if-eqz v0, :cond_8

    .line 270
    .line 271
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 272
    .line 273
    iget-object v2, v2, Ld1/f;->R:[Ld1/d;

    .line 274
    .line 275
    aget-object v2, v2, v5

    .line 276
    .line 277
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 278
    .line 279
    .line 280
    move-result v2

    .line 281
    neg-int v2, v2

    .line 282
    invoke-static {v1, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 283
    .line 284
    .line 285
    :cond_8
    iput-boolean v5, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 286
    .line 287
    iput-boolean v5, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 288
    .line 289
    goto/16 :goto_2

    .line 290
    .line 291
    :cond_9
    if-eqz v8, :cond_a

    .line 292
    .line 293
    invoke-static {v7}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 294
    .line 295
    .line 296
    move-result-object v0

    .line 297
    if-eqz v0, :cond_1a

    .line 298
    .line 299
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 300
    .line 301
    iget-object v5, v5, Ld1/f;->R:[Ld1/d;

    .line 302
    .line 303
    aget-object v4, v5, v4

    .line 304
    .line 305
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 306
    .line 307
    .line 308
    move-result v4

    .line 309
    invoke-static {v3, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 310
    .line 311
    .line 312
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 313
    .line 314
    invoke-static {v1, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 315
    .line 316
    .line 317
    goto/16 :goto_2

    .line 318
    .line 319
    :cond_a
    aget-object v4, v6, v5

    .line 320
    .line 321
    iget-object v6, v4, Ld1/d;->f:Ld1/d;

    .line 322
    .line 323
    if-eqz v6, :cond_b

    .line 324
    .line 325
    invoke-static {v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 326
    .line 327
    .line 328
    move-result-object v0

    .line 329
    if-eqz v0, :cond_1a

    .line 330
    .line 331
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 332
    .line 333
    iget-object v4, v4, Ld1/f;->R:[Ld1/d;

    .line 334
    .line 335
    aget-object v4, v4, v5

    .line 336
    .line 337
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 338
    .line 339
    .line 340
    move-result v4

    .line 341
    neg-int v4, v4

    .line 342
    invoke-static {v1, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 343
    .line 344
    .line 345
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 346
    .line 347
    neg-int v0, v0

    .line 348
    invoke-static {v3, v1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 349
    .line 350
    .line 351
    goto/16 :goto_2

    .line 352
    .line 353
    :cond_b
    instance-of v4, v0, Ld1/l;

    .line 354
    .line 355
    if-nez v4, :cond_1a

    .line 356
    .line 357
    iget-object v4, v0, Ld1/f;->V:Ld1/f;

    .line 358
    .line 359
    if-eqz v4, :cond_1a

    .line 360
    .line 361
    sget-object v4, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->CENTER:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 362
    .line 363
    invoke-virtual {v0, v4}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 364
    .line 365
    .line 366
    move-result-object v0

    .line 367
    iget-object v0, v0, Ld1/d;->f:Ld1/d;

    .line 368
    .line 369
    if-nez v0, :cond_1a

    .line 370
    .line 371
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 372
    .line 373
    iget-object v4, v0, Ld1/f;->V:Ld1/f;

    .line 374
    .line 375
    iget-object v4, v4, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 376
    .line 377
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 378
    .line 379
    invoke-virtual {v0}, Ld1/f;->s()I

    .line 380
    .line 381
    .line 382
    move-result v0

    .line 383
    invoke-static {v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 384
    .line 385
    .line 386
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 387
    .line 388
    invoke-static {v1, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 389
    .line 390
    .line 391
    goto/16 :goto_2

    .line 392
    .line 393
    :cond_c
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 394
    .line 395
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 396
    .line 397
    if-ne v0, v6, :cond_13

    .line 398
    .line 399
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 400
    .line 401
    iget v6, v0, Ld1/f;->r:I

    .line 402
    .line 403
    const/4 v7, 0x2

    .line 404
    if-eq v6, v7, :cond_11

    .line 405
    .line 406
    const/4 v7, 0x3

    .line 407
    if-eq v6, v7, :cond_d

    .line 408
    .line 409
    goto/16 :goto_1

    .line 410
    .line 411
    :cond_d
    iget v6, v0, Ld1/f;->s:I

    .line 412
    .line 413
    if-ne v6, v7, :cond_10

    .line 414
    .line 415
    iput-object p0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 416
    .line 417
    iput-object p0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 418
    .line 419
    iget-object v6, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 420
    .line 421
    iget-object v7, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 422
    .line 423
    iput-object p0, v7, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 424
    .line 425
    iget-object v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 426
    .line 427
    iput-object p0, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 428
    .line 429
    iput-object p0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 430
    .line 431
    invoke-virtual {v0}, Ld1/f;->z()Z

    .line 432
    .line 433
    .line 434
    move-result v0

    .line 435
    if-eqz v0, :cond_e

    .line 436
    .line 437
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 438
    .line 439
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 440
    .line 441
    iget-object v6, v6, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 442
    .line 443
    iget-object v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 444
    .line 445
    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 446
    .line 447
    .line 448
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 449
    .line 450
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 451
    .line 452
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 453
    .line 454
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 455
    .line 456
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 457
    .line 458
    .line 459
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 460
    .line 461
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 462
    .line 463
    iget-object v6, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 464
    .line 465
    iput-object p0, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 466
    .line 467
    iget-object v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 468
    .line 469
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 470
    .line 471
    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 472
    .line 473
    .line 474
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 475
    .line 476
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 477
    .line 478
    iget-object v6, v6, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 479
    .line 480
    iget-object v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 481
    .line 482
    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 483
    .line 484
    .line 485
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 486
    .line 487
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 488
    .line 489
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 490
    .line 491
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 492
    .line 493
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 494
    .line 495
    .line 496
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 497
    .line 498
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 499
    .line 500
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 501
    .line 502
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 503
    .line 504
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 505
    .line 506
    .line 507
    goto/16 :goto_1

    .line 508
    .line 509
    :cond_e
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 510
    .line 511
    invoke-virtual {v0}, Ld1/f;->y()Z

    .line 512
    .line 513
    .line 514
    move-result v0

    .line 515
    if-eqz v0, :cond_f

    .line 516
    .line 517
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 518
    .line 519
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 520
    .line 521
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 522
    .line 523
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 524
    .line 525
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 526
    .line 527
    .line 528
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 529
    .line 530
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 531
    .line 532
    iget-object v6, v6, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 533
    .line 534
    iget-object v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 535
    .line 536
    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 537
    .line 538
    .line 539
    goto :goto_1

    .line 540
    :cond_f
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 541
    .line 542
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 543
    .line 544
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 545
    .line 546
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 547
    .line 548
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 549
    .line 550
    .line 551
    goto :goto_1

    .line 552
    :cond_10
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 553
    .line 554
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 555
    .line 556
    iget-object v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 557
    .line 558
    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 559
    .line 560
    .line 561
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 562
    .line 563
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 564
    .line 565
    .line 566
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 567
    .line 568
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 569
    .line 570
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 571
    .line 572
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 573
    .line 574
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 575
    .line 576
    .line 577
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 578
    .line 579
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 580
    .line 581
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 582
    .line 583
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 584
    .line 585
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 586
    .line 587
    .line 588
    iput-boolean v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 589
    .line 590
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 591
    .line 592
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 593
    .line 594
    .line 595
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 596
    .line 597
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 598
    .line 599
    .line 600
    iget-object v0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 601
    .line 602
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 603
    .line 604
    .line 605
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 606
    .line 607
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 608
    .line 609
    .line 610
    goto :goto_1

    .line 611
    :cond_11
    iget-object v0, v0, Ld1/f;->V:Ld1/f;

    .line 612
    .line 613
    if-nez v0, :cond_12

    .line 614
    .line 615
    goto :goto_1

    .line 616
    :cond_12
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 617
    .line 618
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 619
    .line 620
    iget-object v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 621
    .line 622
    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 623
    .line 624
    .line 625
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 626
    .line 627
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 628
    .line 629
    .line 630
    iput-boolean v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 631
    .line 632
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 633
    .line 634
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 635
    .line 636
    .line 637
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 638
    .line 639
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 640
    .line 641
    .line 642
    :cond_13
    :goto_1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 643
    .line 644
    iget-object v6, v0, Ld1/f;->R:[Ld1/d;

    .line 645
    .line 646
    aget-object v7, v6, v4

    .line 647
    .line 648
    iget-object v8, v7, Ld1/d;->f:Ld1/d;

    .line 649
    .line 650
    if-eqz v8, :cond_17

    .line 651
    .line 652
    aget-object v9, v6, v5

    .line 653
    .line 654
    iget-object v9, v9, Ld1/d;->f:Ld1/d;

    .line 655
    .line 656
    if-eqz v9, :cond_17

    .line 657
    .line 658
    invoke-virtual {v0}, Ld1/f;->y()Z

    .line 659
    .line 660
    .line 661
    move-result v0

    .line 662
    if-eqz v0, :cond_14

    .line 663
    .line 664
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 665
    .line 666
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 667
    .line 668
    aget-object v0, v0, v4

    .line 669
    .line 670
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 671
    .line 672
    .line 673
    move-result v0

    .line 674
    iput v0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 675
    .line 676
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 677
    .line 678
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 679
    .line 680
    aget-object v0, v0, v5

    .line 681
    .line 682
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 683
    .line 684
    .line 685
    move-result v0

    .line 686
    neg-int v0, v0

    .line 687
    iput v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 688
    .line 689
    goto/16 :goto_2

    .line 690
    .line 691
    :cond_14
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 692
    .line 693
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 694
    .line 695
    aget-object v0, v0, v4

    .line 696
    .line 697
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 698
    .line 699
    .line 700
    move-result-object v0

    .line 701
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 702
    .line 703
    iget-object v1, v1, Ld1/f;->R:[Ld1/d;

    .line 704
    .line 705
    aget-object v1, v1, v5

    .line 706
    .line 707
    invoke-static {v1}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 708
    .line 709
    .line 710
    move-result-object v1

    .line 711
    if-eqz v0, :cond_15

    .line 712
    .line 713
    invoke-virtual {v0, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->b(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 714
    .line 715
    .line 716
    :cond_15
    if-eqz v1, :cond_16

    .line 717
    .line 718
    invoke-virtual {v1, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->b(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 719
    .line 720
    .line 721
    :cond_16
    sget-object v0, Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;->CENTER:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 722
    .line 723
    iput-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->j:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 724
    .line 725
    goto :goto_2

    .line 726
    :cond_17
    if-eqz v8, :cond_18

    .line 727
    .line 728
    invoke-static {v7}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 729
    .line 730
    .line 731
    move-result-object v0

    .line 732
    if-eqz v0, :cond_1a

    .line 733
    .line 734
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 735
    .line 736
    iget-object v6, v6, Ld1/f;->R:[Ld1/d;

    .line 737
    .line 738
    aget-object v4, v6, v4

    .line 739
    .line 740
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 741
    .line 742
    .line 743
    move-result v4

    .line 744
    invoke-static {v3, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 745
    .line 746
    .line 747
    invoke-virtual {p0, v1, v3, v5, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 748
    .line 749
    .line 750
    goto :goto_2

    .line 751
    :cond_18
    aget-object v4, v6, v5

    .line 752
    .line 753
    iget-object v6, v4, Ld1/d;->f:Ld1/d;

    .line 754
    .line 755
    if-eqz v6, :cond_19

    .line 756
    .line 757
    invoke-static {v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 758
    .line 759
    .line 760
    move-result-object v0

    .line 761
    if-eqz v0, :cond_1a

    .line 762
    .line 763
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 764
    .line 765
    iget-object v4, v4, Ld1/f;->R:[Ld1/d;

    .line 766
    .line 767
    aget-object v4, v4, v5

    .line 768
    .line 769
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 770
    .line 771
    .line 772
    move-result v4

    .line 773
    neg-int v4, v4

    .line 774
    invoke-static {v1, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 775
    .line 776
    .line 777
    const/4 v0, -0x1

    .line 778
    invoke-virtual {p0, v3, v1, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 779
    .line 780
    .line 781
    goto :goto_2

    .line 782
    :cond_19
    instance-of v4, v0, Ld1/l;

    .line 783
    .line 784
    if-nez v4, :cond_1a

    .line 785
    .line 786
    iget-object v4, v0, Ld1/f;->V:Ld1/f;

    .line 787
    .line 788
    if-eqz v4, :cond_1a

    .line 789
    .line 790
    iget-object v4, v4, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 791
    .line 792
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 793
    .line 794
    invoke-virtual {v0}, Ld1/f;->s()I

    .line 795
    .line 796
    .line 797
    move-result v0

    .line 798
    invoke-static {v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 799
    .line 800
    .line 801
    invoke-virtual {p0, v1, v3, v5, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 802
    .line 803
    .line 804
    :cond_1a
    :goto_2
    return-void
.end method

.method public final e()V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 2
    .line 3
    iget-boolean v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 4
    .line 5
    if-eqz v1, :cond_0

    .line 6
    .line 7
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 8
    .line 9
    iget v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 10
    .line 11
    iput v0, v1, Ld1/f;->a0:I

    .line 12
    .line 13
    :cond_0
    return-void
.end method

.method public final f()V
    .locals 1

    .line 1
    const/4 v0, 0x0

    .line 2
    iput-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->c:Le1/i;

    .line 3
    .line 4
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 5
    .line 6
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 7
    .line 8
    .line 9
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 10
    .line 11
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 12
    .line 13
    .line 14
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 15
    .line 16
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 17
    .line 18
    .line 19
    const/4 v0, 0x0

    .line 20
    iput-boolean v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 21
    .line 22
    return-void
.end method

.method public final k()Z
    .locals 3

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 2
    .line 3
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 4
    .line 5
    const/4 v2, 0x1

    .line 6
    if-ne v0, v1, :cond_1

    .line 7
    .line 8
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 9
    .line 10
    iget v0, v0, Ld1/f;->r:I

    .line 11
    .line 12
    if-nez v0, :cond_0

    .line 13
    .line 14
    return v2

    .line 15
    :cond_0
    const/4 v0, 0x0

    .line 16
    return v0

    .line 17
    :cond_1
    return v2
.end method

.method public final n()V
    .locals 2

    .line 1
    const/4 v0, 0x0

    .line 2
    iput-boolean v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 3
    .line 4
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 5
    .line 6
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 7
    .line 8
    .line 9
    iput-boolean v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 10
    .line 11
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 12
    .line 13
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 14
    .line 15
    .line 16
    iput-boolean v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 17
    .line 18
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 19
    .line 20
    iput-boolean v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 21
    .line 22
    return-void
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    .line 2
    .line 3
    const-string v1, "HorizontalRun "

    .line 4
    .line 5
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 6
    .line 7
    .line 8
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 9
    .line 10
    iget-object v1, v1, Ld1/f;->k0:Ljava/lang/String;

    .line 11
    .line 12
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 13
    .line 14
    .line 15
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 16
    .line 17
    .line 18
    move-result-object v0

    .line 19
    return-object v0
.end method
