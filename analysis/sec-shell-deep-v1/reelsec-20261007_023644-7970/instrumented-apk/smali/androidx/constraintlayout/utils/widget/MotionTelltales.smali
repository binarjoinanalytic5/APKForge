.class public Landroidx/constraintlayout/utils/widget/MotionTelltales;
.super Landroidx/constraintlayout/utils/widget/MockView;
.source "SourceFile"


# instance fields
.field public final l:Landroid/graphics/Paint;

.field public m:Landroidx/constraintlayout/motion/widget/MotionLayout;

.field public final n:[F

.field public final o:Landroid/graphics/Matrix;

.field public p:I

.field public q:I

.field public r:F


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1, p2}, Landroidx/constraintlayout/utils/widget/MockView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 2
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->l:Landroid/graphics/Paint;

    const/4 v0, 0x2

    .line 3
    new-array v0, v0, [F

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->n:[F

    .line 4
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->o:Landroid/graphics/Matrix;

    const/4 v0, 0x0

    .line 5
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->p:I

    const v0, -0xff01

    .line 6
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->q:I

    const/high16 v0, 0x3e800000    # 0.25f

    .line 7
    iput v0, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->r:F

    .line 8
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/utils/widget/MotionTelltales;->b(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    .line 9
    invoke-direct {p0, p1, p2, p3}, Landroidx/constraintlayout/utils/widget/MockView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 10
    new-instance p3, Landroid/graphics/Paint;

    invoke-direct {p3}, Landroid/graphics/Paint;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->l:Landroid/graphics/Paint;

    const/4 p3, 0x2

    .line 11
    new-array p3, p3, [F

    iput-object p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->n:[F

    .line 12
    new-instance p3, Landroid/graphics/Matrix;

    invoke-direct {p3}, Landroid/graphics/Matrix;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->o:Landroid/graphics/Matrix;

    const/4 p3, 0x0

    .line 13
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->p:I

    const p3, -0xff01

    .line 14
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->q:I

    const/high16 p3, 0x3e800000    # 0.25f

    .line 15
    iput p3, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->r:F

    .line 16
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/utils/widget/MotionTelltales;->b(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method


# virtual methods
.method public final b(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3

    .line 1
    if-eqz p2, :cond_4

    .line 2
    .line 3
    sget-object v0, Lj1/m;->t:[I

    .line 4
    .line 5
    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    .line 6
    .line 7
    .line 8
    move-result-object p1

    .line 9
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 10
    .line 11
    .line 12
    move-result p2

    .line 13
    const/4 v0, 0x0

    .line 14
    :goto_0
    if-ge v0, p2, :cond_3

    .line 15
    .line 16
    invoke-virtual {p1, v0}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 17
    .line 18
    .line 19
    move-result v1

    .line 20
    if-nez v1, :cond_0

    .line 21
    .line 22
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->q:I

    .line 23
    .line 24
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    .line 25
    .line 26
    .line 27
    move-result v1

    .line 28
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->q:I

    .line 29
    .line 30
    goto :goto_1

    .line 31
    :cond_0
    const/4 v2, 0x2

    .line 32
    if-ne v1, v2, :cond_1

    .line 33
    .line 34
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->p:I

    .line 35
    .line 36
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 37
    .line 38
    .line 39
    move-result v1

    .line 40
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->p:I

    .line 41
    .line 42
    goto :goto_1

    .line 43
    :cond_1
    const/4 v2, 0x1

    .line 44
    if-ne v1, v2, :cond_2

    .line 45
    .line 46
    iget v2, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->r:F

    .line 47
    .line 48
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 49
    .line 50
    .line 51
    move-result v1

    .line 52
    iput v1, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->r:F

    .line 53
    .line 54
    :cond_2
    :goto_1
    add-int/lit8 v0, v0, 0x1

    .line 55
    .line 56
    goto :goto_0

    .line 57
    :cond_3
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    .line 58
    .line 59
    .line 60
    :cond_4
    iget p1, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->q:I

    .line 61
    .line 62
    iget-object p2, p0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->l:Landroid/graphics/Paint;

    .line 63
    .line 64
    invoke-virtual {p2, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 65
    .line 66
    .line 67
    const/high16 p1, 0x40a00000    # 5.0f

    .line 68
    .line 69
    invoke-virtual {p2, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 70
    .line 71
    .line 72
    return-void
.end method

.method public final onAttachedToWindow()V
    .locals 0

    .line 1
    invoke-super {p0}, Landroid/view/View;->onAttachedToWindow()V

    .line 2
    .line 3
    .line 4
    return-void
.end method

.method public final onDraw(Landroid/graphics/Canvas;)V
    .locals 32

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    const/4 v1, 0x5

    .line 4
    const/4 v2, 0x1

    .line 5
    invoke-super/range {p0 .. p1}, Landroidx/constraintlayout/utils/widget/MockView;->onDraw(Landroid/graphics/Canvas;)V

    .line 6
    .line 7
    .line 8
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getMatrix()Landroid/graphics/Matrix;

    .line 9
    .line 10
    .line 11
    move-result-object v3

    .line 12
    iget-object v4, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->o:Landroid/graphics/Matrix;

    .line 13
    .line 14
    invoke-virtual {v3, v4}, Landroid/graphics/Matrix;->invert(Landroid/graphics/Matrix;)Z

    .line 15
    .line 16
    .line 17
    iget-object v3, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->m:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 18
    .line 19
    if-nez v3, :cond_1

    .line 20
    .line 21
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    .line 22
    .line 23
    .line 24
    move-result-object v1

    .line 25
    instance-of v2, v1, Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 26
    .line 27
    if-eqz v2, :cond_0

    .line 28
    .line 29
    check-cast v1, Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 30
    .line 31
    iput-object v1, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->m:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 32
    .line 33
    :cond_0
    return-void

    .line 34
    :cond_1
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getWidth()I

    .line 35
    .line 36
    .line 37
    move-result v3

    .line 38
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getHeight()I

    .line 39
    .line 40
    .line 41
    move-result v5

    .line 42
    new-array v6, v1, [F

    .line 43
    .line 44
    fill-array-data v6, :array_0

    .line 45
    .line 46
    .line 47
    const/4 v8, 0x0

    .line 48
    :goto_0
    if-ge v8, v1, :cond_29

    .line 49
    .line 50
    aget v15, v6, v8

    .line 51
    .line 52
    const/4 v14, 0x0

    .line 53
    :goto_1
    if-ge v14, v1, :cond_28

    .line 54
    .line 55
    aget v13, v6, v14

    .line 56
    .line 57
    iget-object v9, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->m:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 58
    .line 59
    iget v12, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->p:I

    .line 60
    .line 61
    iget v10, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->v:F

    .line 62
    .line 63
    iget v11, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 64
    .line 65
    iget-object v1, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 66
    .line 67
    if-eqz v1, :cond_2

    .line 68
    .line 69
    iget v1, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->I:F

    .line 70
    .line 71
    sub-float/2addr v1, v11

    .line 72
    invoke-static {v1}, Ljava/lang/Math;->signum(F)F

    .line 73
    .line 74
    .line 75
    move-result v1

    .line 76
    iget-object v10, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 77
    .line 78
    iget v11, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 79
    .line 80
    const v16, 0x3727c5ac    # 1.0E-5f

    .line 81
    .line 82
    .line 83
    add-float v11, v11, v16

    .line 84
    .line 85
    invoke-interface {v10, v11}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 86
    .line 87
    .line 88
    move-result v10

    .line 89
    iget-object v11, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 90
    .line 91
    iget v7, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->G:F

    .line 92
    .line 93
    invoke-interface {v11, v7}, Landroid/animation/TimeInterpolator;->getInterpolation(F)F

    .line 94
    .line 95
    .line 96
    move-result v11

    .line 97
    sub-float/2addr v10, v11

    .line 98
    div-float v10, v10, v16

    .line 99
    .line 100
    mul-float/2addr v10, v1

    .line 101
    iget v1, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->E:F

    .line 102
    .line 103
    div-float/2addr v10, v1

    .line 104
    :cond_2
    iget-object v1, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->t:Lh1/o;

    .line 105
    .line 106
    instance-of v7, v1, Lh1/o;

    .line 107
    .line 108
    if-eqz v7, :cond_3

    .line 109
    .line 110
    invoke-virtual {v1}, Lh1/o;->a()F

    .line 111
    .line 112
    .line 113
    move-result v10

    .line 114
    :cond_3
    move v1, v10

    .line 115
    iget-object v7, v9, Landroidx/constraintlayout/motion/widget/MotionLayout;->C:Ljava/util/HashMap;

    .line 116
    .line 117
    invoke-virtual {v7, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 118
    .line 119
    .line 120
    move-result-object v7

    .line 121
    check-cast v7, Lh1/n;

    .line 122
    .line 123
    and-int/lit8 v9, v12, 0x1

    .line 124
    .line 125
    iget-object v10, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->n:[F

    .line 126
    .line 127
    if-nez v9, :cond_26

    .line 128
    .line 129
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getWidth()I

    .line 130
    .line 131
    .line 132
    move-result v16

    .line 133
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getHeight()I

    .line 134
    .line 135
    .line 136
    move-result v17

    .line 137
    iget-object v9, v7, Lh1/n;->v:[F

    .line 138
    .line 139
    invoke-virtual {v7, v9, v11}, Lh1/n;->b([FF)F

    .line 140
    .line 141
    .line 142
    move-result v11

    .line 143
    iget-object v2, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 144
    .line 145
    move-object/from16 v18, v6

    .line 146
    .line 147
    const-string v6, "translationX"

    .line 148
    .line 149
    const/16 v19, 0x0

    .line 150
    .line 151
    if-nez v2, :cond_4

    .line 152
    .line 153
    move-object/from16 v20, v10

    .line 154
    .line 155
    move-object/from16 v2, v19

    .line 156
    .line 157
    goto :goto_2

    .line 158
    :cond_4
    invoke-virtual {v2, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 159
    .line 160
    .line 161
    move-result-object v2

    .line 162
    check-cast v2, Lg1/l;

    .line 163
    .line 164
    move-object/from16 v20, v10

    .line 165
    .line 166
    :goto_2
    iget-object v10, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 167
    .line 168
    move/from16 v21, v12

    .line 169
    .line 170
    const-string v12, "translationY"

    .line 171
    .line 172
    if-nez v10, :cond_5

    .line 173
    .line 174
    move/from16 v22, v14

    .line 175
    .line 176
    move-object/from16 v10, v19

    .line 177
    .line 178
    goto :goto_3

    .line 179
    :cond_5
    invoke-virtual {v10, v12}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 180
    .line 181
    .line 182
    move-result-object v10

    .line 183
    check-cast v10, Lg1/l;

    .line 184
    .line 185
    move/from16 v22, v14

    .line 186
    .line 187
    :goto_3
    iget-object v14, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 188
    .line 189
    move/from16 v23, v8

    .line 190
    .line 191
    const-string v8, "rotation"

    .line 192
    .line 193
    if-nez v14, :cond_6

    .line 194
    .line 195
    move/from16 v24, v5

    .line 196
    .line 197
    move-object/from16 v14, v19

    .line 198
    .line 199
    goto :goto_4

    .line 200
    :cond_6
    invoke-virtual {v14, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 201
    .line 202
    .line 203
    move-result-object v14

    .line 204
    check-cast v14, Lg1/l;

    .line 205
    .line 206
    move/from16 v24, v5

    .line 207
    .line 208
    :goto_4
    iget-object v5, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 209
    .line 210
    move/from16 v25, v3

    .line 211
    .line 212
    const-string v3, "scaleX"

    .line 213
    .line 214
    if-nez v5, :cond_7

    .line 215
    .line 216
    move-object/from16 v26, v4

    .line 217
    .line 218
    move-object/from16 v5, v19

    .line 219
    .line 220
    goto :goto_5

    .line 221
    :cond_7
    invoke-virtual {v5, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 222
    .line 223
    .line 224
    move-result-object v5

    .line 225
    check-cast v5, Lg1/l;

    .line 226
    .line 227
    move-object/from16 v26, v4

    .line 228
    .line 229
    :goto_5
    iget-object v4, v7, Lh1/n;->y:Ljava/util/HashMap;

    .line 230
    .line 231
    const-string v0, "scaleY"

    .line 232
    .line 233
    if-nez v4, :cond_8

    .line 234
    .line 235
    move/from16 v27, v1

    .line 236
    .line 237
    move-object/from16 v4, v19

    .line 238
    .line 239
    goto :goto_6

    .line 240
    :cond_8
    invoke-virtual {v4, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 241
    .line 242
    .line 243
    move-result-object v4

    .line 244
    check-cast v4, Lg1/l;

    .line 245
    .line 246
    move/from16 v27, v1

    .line 247
    .line 248
    :goto_6
    iget-object v1, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 249
    .line 250
    if-nez v1, :cond_9

    .line 251
    .line 252
    move-object/from16 v1, v19

    .line 253
    .line 254
    goto :goto_7

    .line 255
    :cond_9
    invoke-virtual {v1, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 256
    .line 257
    .line 258
    move-result-object v1

    .line 259
    check-cast v1, Lg1/g;

    .line 260
    .line 261
    :goto_7
    iget-object v6, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 262
    .line 263
    if-nez v6, :cond_a

    .line 264
    .line 265
    move-object/from16 v6, v19

    .line 266
    .line 267
    goto :goto_8

    .line 268
    :cond_a
    invoke-virtual {v6, v12}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 269
    .line 270
    .line 271
    move-result-object v6

    .line 272
    check-cast v6, Lg1/g;

    .line 273
    .line 274
    :goto_8
    iget-object v12, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 275
    .line 276
    if-nez v12, :cond_b

    .line 277
    .line 278
    move-object/from16 v8, v19

    .line 279
    .line 280
    goto :goto_9

    .line 281
    :cond_b
    invoke-virtual {v12, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 282
    .line 283
    .line 284
    move-result-object v8

    .line 285
    check-cast v8, Lg1/g;

    .line 286
    .line 287
    :goto_9
    iget-object v12, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 288
    .line 289
    if-nez v12, :cond_c

    .line 290
    .line 291
    move-object/from16 v3, v19

    .line 292
    .line 293
    goto :goto_a

    .line 294
    :cond_c
    invoke-virtual {v12, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 295
    .line 296
    .line 297
    move-result-object v3

    .line 298
    check-cast v3, Lg1/g;

    .line 299
    .line 300
    :goto_a
    iget-object v12, v7, Lh1/n;->z:Ljava/util/HashMap;

    .line 301
    .line 302
    if-nez v12, :cond_d

    .line 303
    .line 304
    :goto_b
    move-object/from16 v0, v19

    .line 305
    .line 306
    goto :goto_c

    .line 307
    :cond_d
    invoke-virtual {v12, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 308
    .line 309
    .line 310
    move-result-object v0

    .line 311
    move-object/from16 v19, v0

    .line 312
    .line 313
    check-cast v19, Lg1/g;

    .line 314
    .line 315
    goto :goto_b

    .line 316
    :goto_c
    new-instance v12, Lb1/n;

    .line 317
    .line 318
    invoke-direct {v12}, Ljava/lang/Object;-><init>()V

    .line 319
    .line 320
    .line 321
    move-object/from16 v19, v9

    .line 322
    .line 323
    const/4 v9, 0x0

    .line 324
    iput v9, v12, Lb1/n;->e:F

    .line 325
    .line 326
    iput v9, v12, Lb1/n;->d:F

    .line 327
    .line 328
    iput v9, v12, Lb1/n;->c:F

    .line 329
    .line 330
    iput v9, v12, Lb1/n;->b:F

    .line 331
    .line 332
    iput v9, v12, Lb1/n;->a:F

    .line 333
    .line 334
    if-eqz v14, :cond_e

    .line 335
    .line 336
    iget-object v9, v14, Lg1/l;->a:Lb4/a;

    .line 337
    .line 338
    move-object/from16 v29, v6

    .line 339
    .line 340
    move-object/from16 v28, v7

    .line 341
    .line 342
    float-to-double v6, v11

    .line 343
    invoke-virtual {v9, v6, v7}, Lb4/a;->x(D)D

    .line 344
    .line 345
    .line 346
    move-result-wide v6

    .line 347
    double-to-float v6, v6

    .line 348
    iput v6, v12, Lb1/n;->e:F

    .line 349
    .line 350
    invoke-virtual {v14, v11}, Lg1/l;->a(F)F

    .line 351
    .line 352
    .line 353
    move-result v6

    .line 354
    iput v6, v12, Lb1/n;->f:F

    .line 355
    .line 356
    goto :goto_d

    .line 357
    :cond_e
    move-object/from16 v29, v6

    .line 358
    .line 359
    move-object/from16 v28, v7

    .line 360
    .line 361
    :goto_d
    if-eqz v2, :cond_f

    .line 362
    .line 363
    iget-object v6, v2, Lg1/l;->a:Lb4/a;

    .line 364
    .line 365
    move-object v9, v14

    .line 366
    move v7, v15

    .line 367
    float-to-double v14, v11

    .line 368
    invoke-virtual {v6, v14, v15}, Lb4/a;->x(D)D

    .line 369
    .line 370
    .line 371
    move-result-wide v14

    .line 372
    double-to-float v6, v14

    .line 373
    iput v6, v12, Lb1/n;->c:F

    .line 374
    .line 375
    goto :goto_e

    .line 376
    :cond_f
    move-object v9, v14

    .line 377
    move v7, v15

    .line 378
    :goto_e
    if-eqz v10, :cond_10

    .line 379
    .line 380
    iget-object v6, v10, Lg1/l;->a:Lb4/a;

    .line 381
    .line 382
    float-to-double v14, v11

    .line 383
    invoke-virtual {v6, v14, v15}, Lb4/a;->x(D)D

    .line 384
    .line 385
    .line 386
    move-result-wide v14

    .line 387
    double-to-float v6, v14

    .line 388
    iput v6, v12, Lb1/n;->d:F

    .line 389
    .line 390
    :cond_10
    if-eqz v5, :cond_11

    .line 391
    .line 392
    iget-object v6, v5, Lg1/l;->a:Lb4/a;

    .line 393
    .line 394
    float-to-double v14, v11

    .line 395
    invoke-virtual {v6, v14, v15}, Lb4/a;->x(D)D

    .line 396
    .line 397
    .line 398
    move-result-wide v14

    .line 399
    double-to-float v6, v14

    .line 400
    iput v6, v12, Lb1/n;->a:F

    .line 401
    .line 402
    :cond_11
    if-eqz v4, :cond_12

    .line 403
    .line 404
    iget-object v6, v4, Lg1/l;->a:Lb4/a;

    .line 405
    .line 406
    float-to-double v14, v11

    .line 407
    invoke-virtual {v6, v14, v15}, Lb4/a;->x(D)D

    .line 408
    .line 409
    .line 410
    move-result-wide v14

    .line 411
    double-to-float v6, v14

    .line 412
    iput v6, v12, Lb1/n;->b:F

    .line 413
    .line 414
    :cond_12
    if-eqz v8, :cond_13

    .line 415
    .line 416
    invoke-virtual {v8, v11}, Lg1/g;->b(F)F

    .line 417
    .line 418
    .line 419
    move-result v6

    .line 420
    iput v6, v12, Lb1/n;->e:F

    .line 421
    .line 422
    :cond_13
    if-eqz v1, :cond_14

    .line 423
    .line 424
    invoke-virtual {v1, v11}, Lg1/g;->b(F)F

    .line 425
    .line 426
    .line 427
    move-result v6

    .line 428
    iput v6, v12, Lb1/n;->c:F

    .line 429
    .line 430
    :cond_14
    move-object/from16 v6, v29

    .line 431
    .line 432
    if-eqz v29, :cond_15

    .line 433
    .line 434
    invoke-virtual {v6, v11}, Lg1/g;->b(F)F

    .line 435
    .line 436
    .line 437
    move-result v14

    .line 438
    iput v14, v12, Lb1/n;->d:F

    .line 439
    .line 440
    :cond_15
    if-eqz v3, :cond_16

    .line 441
    .line 442
    invoke-virtual {v3, v11}, Lg1/g;->b(F)F

    .line 443
    .line 444
    .line 445
    move-result v14

    .line 446
    iput v14, v12, Lb1/n;->a:F

    .line 447
    .line 448
    :cond_16
    if-eqz v0, :cond_17

    .line 449
    .line 450
    invoke-virtual {v0, v11}, Lg1/g;->b(F)F

    .line 451
    .line 452
    .line 453
    move-result v14

    .line 454
    iput v14, v12, Lb1/n;->b:F

    .line 455
    .line 456
    :cond_17
    move-object/from16 v14, v28

    .line 457
    .line 458
    iget-object v15, v14, Lh1/n;->k:Lb1/b;

    .line 459
    .line 460
    if-eqz v15, :cond_19

    .line 461
    .line 462
    iget-object v0, v14, Lh1/n;->p:[D

    .line 463
    .line 464
    array-length v1, v0

    .line 465
    if-lez v1, :cond_18

    .line 466
    .line 467
    float-to-double v1, v11

    .line 468
    invoke-virtual {v15, v1, v2, v0}, Lb1/b;->v(D[D)V

    .line 469
    .line 470
    .line 471
    iget-object v0, v14, Lh1/n;->k:Lb1/b;

    .line 472
    .line 473
    iget-object v3, v14, Lh1/n;->q:[D

    .line 474
    .line 475
    invoke-virtual {v0, v1, v2, v3}, Lb1/b;->y(D[D)V

    .line 476
    .line 477
    .line 478
    iget-object v0, v14, Lh1/n;->o:[I

    .line 479
    .line 480
    iget-object v1, v14, Lh1/n;->q:[D

    .line 481
    .line 482
    iget-object v2, v14, Lh1/n;->p:[D

    .line 483
    .line 484
    iget-object v3, v14, Lh1/n;->f:Lh1/v;

    .line 485
    .line 486
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 487
    .line 488
    .line 489
    move v9, v13

    .line 490
    move-object/from16 v15, v20

    .line 491
    .line 492
    move v10, v7

    .line 493
    move-object v11, v15

    .line 494
    move-object v4, v12

    .line 495
    move/from16 v3, v21

    .line 496
    .line 497
    move-object v12, v0

    .line 498
    move v0, v13

    .line 499
    move-object v13, v1

    .line 500
    move/from16 v20, v22

    .line 501
    .line 502
    move-object v14, v2

    .line 503
    invoke-static/range {v9 .. v14}, Lh1/v;->g(FF[F[I[D[D)V

    .line 504
    .line 505
    .line 506
    goto :goto_f

    .line 507
    :cond_18
    move-object v4, v12

    .line 508
    move v0, v13

    .line 509
    move-object/from16 v15, v20

    .line 510
    .line 511
    move/from16 v3, v21

    .line 512
    .line 513
    move/from16 v20, v22

    .line 514
    .line 515
    :goto_f
    move-object v9, v4

    .line 516
    move v10, v0

    .line 517
    move v11, v7

    .line 518
    move/from16 v12, v16

    .line 519
    .line 520
    move/from16 v13, v17

    .line 521
    .line 522
    move-object v14, v15

    .line 523
    invoke-virtual/range {v9 .. v14}, Lb1/n;->a(FFII[F)V

    .line 524
    .line 525
    .line 526
    move v1, v0

    .line 527
    move v0, v3

    .line 528
    :goto_10
    move-object v3, v15

    .line 529
    goto/16 :goto_13

    .line 530
    .line 531
    :cond_19
    move-object/from16 v15, v20

    .line 532
    .line 533
    move/from16 v20, v22

    .line 534
    .line 535
    move/from16 v22, v21

    .line 536
    .line 537
    move-object/from16 v21, v12

    .line 538
    .line 539
    iget-object v12, v14, Lh1/n;->j:[Lb4/a;

    .line 540
    .line 541
    if-eqz v12, :cond_1b

    .line 542
    .line 543
    move-object/from16 v12, v19

    .line 544
    .line 545
    invoke-virtual {v14, v12, v11}, Lh1/n;->b([FF)F

    .line 546
    .line 547
    .line 548
    move-result v0

    .line 549
    iget-object v1, v14, Lh1/n;->j:[Lb4/a;

    .line 550
    .line 551
    const/4 v2, 0x0

    .line 552
    aget-object v1, v1, v2

    .line 553
    .line 554
    float-to-double v3, v0

    .line 555
    iget-object v0, v14, Lh1/n;->q:[D

    .line 556
    .line 557
    invoke-virtual {v1, v3, v4, v0}, Lb4/a;->y(D[D)V

    .line 558
    .line 559
    .line 560
    iget-object v0, v14, Lh1/n;->j:[Lb4/a;

    .line 561
    .line 562
    aget-object v0, v0, v2

    .line 563
    .line 564
    iget-object v1, v14, Lh1/n;->p:[D

    .line 565
    .line 566
    invoke-virtual {v0, v3, v4, v1}, Lb4/a;->v(D[D)V

    .line 567
    .line 568
    .line 569
    aget v0, v12, v2

    .line 570
    .line 571
    const/4 v1, 0x0

    .line 572
    :goto_11
    iget-object v2, v14, Lh1/n;->q:[D

    .line 573
    .line 574
    array-length v3, v2

    .line 575
    if-ge v1, v3, :cond_1a

    .line 576
    .line 577
    aget-wide v3, v2, v1

    .line 578
    .line 579
    float-to-double v5, v0

    .line 580
    mul-double/2addr v3, v5

    .line 581
    aput-wide v3, v2, v1

    .line 582
    .line 583
    const/4 v2, 0x1

    .line 584
    add-int/2addr v1, v2

    .line 585
    goto :goto_11

    .line 586
    :cond_1a
    iget-object v12, v14, Lh1/n;->o:[I

    .line 587
    .line 588
    iget-object v0, v14, Lh1/n;->p:[D

    .line 589
    .line 590
    iget-object v1, v14, Lh1/n;->f:Lh1/v;

    .line 591
    .line 592
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 593
    .line 594
    .line 595
    move v9, v13

    .line 596
    move v10, v7

    .line 597
    move-object v11, v15

    .line 598
    move/from16 v1, v22

    .line 599
    .line 600
    move v3, v13

    .line 601
    move-object v13, v2

    .line 602
    move-object v14, v0

    .line 603
    invoke-static/range {v9 .. v14}, Lh1/v;->g(FF[F[I[D[D)V

    .line 604
    .line 605
    .line 606
    move-object/from16 v9, v21

    .line 607
    .line 608
    move v10, v3

    .line 609
    move v11, v7

    .line 610
    move/from16 v12, v16

    .line 611
    .line 612
    move/from16 v13, v17

    .line 613
    .line 614
    move-object v14, v15

    .line 615
    invoke-virtual/range {v9 .. v14}, Lb1/n;->a(FFII[F)V

    .line 616
    .line 617
    .line 618
    move v0, v1

    .line 619
    move v1, v3

    .line 620
    goto :goto_10

    .line 621
    :cond_1b
    iget-object v12, v14, Lh1/n;->g:Lh1/v;

    .line 622
    .line 623
    move-object/from16 v19, v0

    .line 624
    .line 625
    iget v0, v12, Lh1/v;->e:F

    .line 626
    .line 627
    iget-object v14, v14, Lh1/n;->f:Lh1/v;

    .line 628
    .line 629
    move-object/from16 v28, v3

    .line 630
    .line 631
    iget v3, v14, Lh1/v;->e:F

    .line 632
    .line 633
    sub-float/2addr v0, v3

    .line 634
    iget v3, v12, Lh1/v;->f:F

    .line 635
    .line 636
    move-object/from16 v29, v6

    .line 637
    .line 638
    iget v6, v14, Lh1/v;->f:F

    .line 639
    .line 640
    sub-float/2addr v3, v6

    .line 641
    iget v6, v12, Lh1/v;->g:F

    .line 642
    .line 643
    move-object/from16 v30, v1

    .line 644
    .line 645
    iget v1, v14, Lh1/v;->g:F

    .line 646
    .line 647
    sub-float/2addr v6, v1

    .line 648
    iget v1, v12, Lh1/v;->h:F

    .line 649
    .line 650
    iget v12, v14, Lh1/v;->h:F

    .line 651
    .line 652
    sub-float/2addr v1, v12

    .line 653
    add-float/2addr v6, v0

    .line 654
    add-float/2addr v1, v3

    .line 655
    const/high16 v12, 0x3f800000    # 1.0f

    .line 656
    .line 657
    sub-float v14, v12, v13

    .line 658
    .line 659
    mul-float/2addr v14, v0

    .line 660
    mul-float/2addr v6, v13

    .line 661
    add-float/2addr v6, v14

    .line 662
    const/4 v0, 0x0

    .line 663
    aput v6, v15, v0

    .line 664
    .line 665
    sub-float/2addr v12, v7

    .line 666
    mul-float/2addr v12, v3

    .line 667
    mul-float/2addr v1, v7

    .line 668
    add-float/2addr v1, v12

    .line 669
    const/4 v0, 0x1

    .line 670
    aput v1, v15, v0

    .line 671
    .line 672
    move-object/from16 v0, v21

    .line 673
    .line 674
    const/4 v1, 0x0

    .line 675
    iput v1, v0, Lb1/n;->e:F

    .line 676
    .line 677
    iput v1, v0, Lb1/n;->d:F

    .line 678
    .line 679
    iput v1, v0, Lb1/n;->c:F

    .line 680
    .line 681
    iput v1, v0, Lb1/n;->b:F

    .line 682
    .line 683
    iput v1, v0, Lb1/n;->a:F

    .line 684
    .line 685
    if-eqz v9, :cond_1c

    .line 686
    .line 687
    iget-object v1, v9, Lg1/l;->a:Lb4/a;

    .line 688
    .line 689
    move-object v3, v15

    .line 690
    float-to-double v14, v11

    .line 691
    invoke-virtual {v1, v14, v15}, Lb4/a;->x(D)D

    .line 692
    .line 693
    .line 694
    move-result-wide v14

    .line 695
    double-to-float v1, v14

    .line 696
    iput v1, v0, Lb1/n;->e:F

    .line 697
    .line 698
    invoke-virtual {v9, v11}, Lg1/l;->a(F)F

    .line 699
    .line 700
    .line 701
    move-result v1

    .line 702
    iput v1, v0, Lb1/n;->f:F

    .line 703
    .line 704
    goto :goto_12

    .line 705
    :cond_1c
    move-object v3, v15

    .line 706
    :goto_12
    if-eqz v2, :cond_1d

    .line 707
    .line 708
    iget-object v1, v2, Lg1/l;->a:Lb4/a;

    .line 709
    .line 710
    float-to-double v14, v11

    .line 711
    invoke-virtual {v1, v14, v15}, Lb4/a;->x(D)D

    .line 712
    .line 713
    .line 714
    move-result-wide v1

    .line 715
    double-to-float v1, v1

    .line 716
    iput v1, v0, Lb1/n;->c:F

    .line 717
    .line 718
    :cond_1d
    if-eqz v10, :cond_1e

    .line 719
    .line 720
    iget-object v1, v10, Lg1/l;->a:Lb4/a;

    .line 721
    .line 722
    float-to-double v9, v11

    .line 723
    invoke-virtual {v1, v9, v10}, Lb4/a;->x(D)D

    .line 724
    .line 725
    .line 726
    move-result-wide v1

    .line 727
    double-to-float v1, v1

    .line 728
    iput v1, v0, Lb1/n;->d:F

    .line 729
    .line 730
    :cond_1e
    if-eqz v5, :cond_1f

    .line 731
    .line 732
    iget-object v1, v5, Lg1/l;->a:Lb4/a;

    .line 733
    .line 734
    float-to-double v5, v11

    .line 735
    invoke-virtual {v1, v5, v6}, Lb4/a;->x(D)D

    .line 736
    .line 737
    .line 738
    move-result-wide v1

    .line 739
    double-to-float v1, v1

    .line 740
    iput v1, v0, Lb1/n;->a:F

    .line 741
    .line 742
    :cond_1f
    if-eqz v4, :cond_20

    .line 743
    .line 744
    iget-object v1, v4, Lg1/l;->a:Lb4/a;

    .line 745
    .line 746
    float-to-double v4, v11

    .line 747
    invoke-virtual {v1, v4, v5}, Lb4/a;->x(D)D

    .line 748
    .line 749
    .line 750
    move-result-wide v1

    .line 751
    double-to-float v1, v1

    .line 752
    iput v1, v0, Lb1/n;->b:F

    .line 753
    .line 754
    :cond_20
    if-eqz v8, :cond_21

    .line 755
    .line 756
    invoke-virtual {v8, v11}, Lg1/g;->b(F)F

    .line 757
    .line 758
    .line 759
    move-result v1

    .line 760
    iput v1, v0, Lb1/n;->e:F

    .line 761
    .line 762
    :cond_21
    if-eqz v30, :cond_22

    .line 763
    .line 764
    move-object/from16 v1, v30

    .line 765
    .line 766
    invoke-virtual {v1, v11}, Lg1/g;->b(F)F

    .line 767
    .line 768
    .line 769
    move-result v1

    .line 770
    iput v1, v0, Lb1/n;->c:F

    .line 771
    .line 772
    :cond_22
    if-eqz v29, :cond_23

    .line 773
    .line 774
    move-object/from16 v6, v29

    .line 775
    .line 776
    invoke-virtual {v6, v11}, Lg1/g;->b(F)F

    .line 777
    .line 778
    .line 779
    move-result v1

    .line 780
    iput v1, v0, Lb1/n;->d:F

    .line 781
    .line 782
    :cond_23
    if-eqz v28, :cond_24

    .line 783
    .line 784
    move-object/from16 v1, v28

    .line 785
    .line 786
    invoke-virtual {v1, v11}, Lg1/g;->b(F)F

    .line 787
    .line 788
    .line 789
    move-result v1

    .line 790
    iput v1, v0, Lb1/n;->a:F

    .line 791
    .line 792
    :cond_24
    if-eqz v19, :cond_25

    .line 793
    .line 794
    move-object/from16 v1, v19

    .line 795
    .line 796
    invoke-virtual {v1, v11}, Lg1/g;->b(F)F

    .line 797
    .line 798
    .line 799
    move-result v1

    .line 800
    iput v1, v0, Lb1/n;->b:F

    .line 801
    .line 802
    :cond_25
    move-object v9, v0

    .line 803
    move v10, v13

    .line 804
    move v11, v7

    .line 805
    move/from16 v0, v22

    .line 806
    .line 807
    move/from16 v12, v16

    .line 808
    .line 809
    move v1, v13

    .line 810
    move/from16 v13, v17

    .line 811
    .line 812
    move-object v14, v3

    .line 813
    invoke-virtual/range {v9 .. v14}, Lb1/n;->a(FFII[F)V

    .line 814
    .line 815
    .line 816
    goto :goto_13

    .line 817
    :cond_26
    move/from16 v27, v1

    .line 818
    .line 819
    move/from16 v25, v3

    .line 820
    .line 821
    move-object/from16 v26, v4

    .line 822
    .line 823
    move/from16 v24, v5

    .line 824
    .line 825
    move-object/from16 v18, v6

    .line 826
    .line 827
    move/from16 v23, v8

    .line 828
    .line 829
    move-object v3, v10

    .line 830
    move v0, v12

    .line 831
    move v1, v13

    .line 832
    move/from16 v20, v14

    .line 833
    .line 834
    move-object v14, v7

    .line 835
    move v7, v15

    .line 836
    invoke-virtual {v14, v11, v1, v7, v3}, Lh1/n;->d(FFF[F)V

    .line 837
    .line 838
    .line 839
    :goto_13
    const/4 v2, 0x2

    .line 840
    if-ge v0, v2, :cond_27

    .line 841
    .line 842
    const/4 v0, 0x0

    .line 843
    aget v2, v3, v0

    .line 844
    .line 845
    mul-float v2, v2, v27

    .line 846
    .line 847
    aput v2, v3, v0

    .line 848
    .line 849
    const/4 v0, 0x1

    .line 850
    aget v2, v3, v0

    .line 851
    .line 852
    mul-float v2, v2, v27

    .line 853
    .line 854
    aput v2, v3, v0

    .line 855
    .line 856
    :cond_27
    move-object/from16 v0, p0

    .line 857
    .line 858
    iget-object v2, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->n:[F

    .line 859
    .line 860
    move-object/from16 v3, v26

    .line 861
    .line 862
    invoke-virtual {v3, v2}, Landroid/graphics/Matrix;->mapVectors([F)V

    .line 863
    .line 864
    .line 865
    move/from16 v4, v25

    .line 866
    .line 867
    int-to-float v5, v4

    .line 868
    mul-float v9, v5, v1

    .line 869
    .line 870
    move/from16 v1, v24

    .line 871
    .line 872
    int-to-float v5, v1

    .line 873
    mul-float v10, v5, v7

    .line 874
    .line 875
    const/4 v5, 0x0

    .line 876
    aget v6, v2, v5

    .line 877
    .line 878
    iget v8, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->r:F

    .line 879
    .line 880
    mul-float/2addr v6, v8

    .line 881
    sub-float v11, v9, v6

    .line 882
    .line 883
    const/4 v6, 0x1

    .line 884
    aget v12, v2, v6

    .line 885
    .line 886
    mul-float/2addr v12, v8

    .line 887
    sub-float v12, v10, v12

    .line 888
    .line 889
    invoke-virtual {v3, v2}, Landroid/graphics/Matrix;->mapVectors([F)V

    .line 890
    .line 891
    .line 892
    iget-object v13, v0, Landroidx/constraintlayout/utils/widget/MotionTelltales;->l:Landroid/graphics/Paint;

    .line 893
    .line 894
    move-object/from16 v8, p1

    .line 895
    .line 896
    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 897
    .line 898
    .line 899
    const/4 v2, 0x1

    .line 900
    add-int/lit8 v14, v20, 0x1

    .line 901
    .line 902
    move v5, v1

    .line 903
    move v15, v7

    .line 904
    move-object/from16 v6, v18

    .line 905
    .line 906
    move/from16 v8, v23

    .line 907
    .line 908
    const/4 v1, 0x5

    .line 909
    move/from16 v31, v4

    .line 910
    .line 911
    move-object v4, v3

    .line 912
    move/from16 v3, v31

    .line 913
    .line 914
    goto/16 :goto_1

    .line 915
    .line 916
    :cond_28
    move v1, v5

    .line 917
    move-object/from16 v18, v6

    .line 918
    .line 919
    move/from16 v23, v8

    .line 920
    .line 921
    const/4 v5, 0x0

    .line 922
    move-object/from16 v31, v4

    .line 923
    .line 924
    move v4, v3

    .line 925
    move-object/from16 v3, v31

    .line 926
    .line 927
    add-int/lit8 v8, v23, 0x1

    .line 928
    .line 929
    move v5, v1

    .line 930
    const/4 v1, 0x5

    .line 931
    move/from16 v31, v4

    .line 932
    .line 933
    move-object v4, v3

    .line 934
    move/from16 v3, v31

    .line 935
    .line 936
    goto/16 :goto_0

    .line 937
    .line 938
    :cond_29
    return-void

    .line 939
    :array_0
    .array-data 4
        0x3dcccccd    # 0.1f
        0x3e800000    # 0.25f
        0x3f000000    # 0.5f
        0x3f400000    # 0.75f
        0x3f666666    # 0.9f
    .end array-data
.end method

.method public final onLayout(ZIIII)V
    .locals 0

    .line 1
    invoke-super/range {p0 .. p5}, Landroid/view/View;->onLayout(ZIIII)V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0}, Landroid/view/View;->postInvalidate()V

    .line 5
    .line 6
    .line 7
    return-void
.end method

.method public setText(Ljava/lang/CharSequence;)V
    .locals 0

    .line 1
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    .line 2
    .line 3
    .line 4
    move-result-object p1

    .line 5
    iput-object p1, p0, Landroidx/constraintlayout/utils/widget/MockView;->f:Ljava/lang/String;

    .line 6
    .line 7
    invoke-virtual {p0}, Landroid/view/View;->requestLayout()V

    .line 8
    .line 9
    .line 10
    return-void
.end method
