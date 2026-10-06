.class public final Landroidx/constraintlayout/core/widgets/analyzer/g;
.super Landroidx/constraintlayout/core/widgets/analyzer/h;
.source "SourceFile"


# instance fields
.field public final k:Landroidx/constraintlayout/core/widgets/analyzer/a;

.field public l:Le1/a;


# direct methods
.method public constructor <init>(Ld1/f;)V
    .locals 2

    .line 1
    invoke-direct {p0, p1}, Landroidx/constraintlayout/core/widgets/analyzer/h;-><init>(Ld1/f;)V

    .line 2
    .line 3
    .line 4
    new-instance p1, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 5
    .line 6
    invoke-direct {p1, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;-><init>(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 7
    .line 8
    .line 9
    iput-object p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->k:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 10
    .line 11
    const/4 v0, 0x0

    .line 12
    iput-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 13
    .line 14
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 15
    .line 16
    sget-object v1, Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;->TOP:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 17
    .line 18
    iput-object v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->e:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 19
    .line 20
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 21
    .line 22
    sget-object v1, Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 23
    .line 24
    iput-object v1, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->e:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 25
    .line 26
    sget-object v0, Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;->BASELINE:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 27
    .line 28
    iput-object v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->e:Landroidx/constraintlayout/core/widgets/analyzer/DependencyNode$Type;

    .line 29
    .line 30
    const/4 p1, 0x1

    .line 31
    iput p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->f:I

    .line 32
    .line 33
    return-void
.end method


# virtual methods
.method public final a(Le1/e;)V
    .locals 10

    .line 1
    sget-object p1, Landroidx/constraintlayout/core/widgets/analyzer/f;->a:[I

    .line 2
    .line 3
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->j:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 4
    .line 5
    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    .line 6
    .line 7
    .line 8
    move-result v0

    .line 9
    aget p1, p1, v0

    .line 10
    .line 11
    const/4 v0, 0x1

    .line 12
    const/4 v1, 0x3

    .line 13
    if-eq p1, v1, :cond_e

    .line 14
    .line 15
    iget-object p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 16
    .line 17
    iget-boolean v2, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 18
    .line 19
    const/high16 v3, 0x3f000000    # 0.5f

    .line 20
    .line 21
    const/4 v4, 0x0

    .line 22
    if-eqz v2, :cond_5

    .line 23
    .line 24
    iget-boolean v2, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 25
    .line 26
    if-nez v2, :cond_5

    .line 27
    .line 28
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 29
    .line 30
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 31
    .line 32
    if-ne v2, v5, :cond_5

    .line 33
    .line 34
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 35
    .line 36
    iget v5, v2, Ld1/f;->s:I

    .line 37
    .line 38
    const/4 v6, 0x2

    .line 39
    if-eq v5, v6, :cond_4

    .line 40
    .line 41
    if-eq v5, v1, :cond_0

    .line 42
    .line 43
    goto :goto_3

    .line 44
    :cond_0
    iget-object v1, v2, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 45
    .line 46
    iget-object v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 47
    .line 48
    iget-boolean v5, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 49
    .line 50
    if-eqz v5, :cond_5

    .line 51
    .line 52
    iget v5, v2, Ld1/f;->Z:I

    .line 53
    .line 54
    const/4 v6, -0x1

    .line 55
    if-eq v5, v6, :cond_3

    .line 56
    .line 57
    if-eqz v5, :cond_2

    .line 58
    .line 59
    if-eq v5, v0, :cond_1

    .line 60
    .line 61
    move v1, v4

    .line 62
    goto :goto_2

    .line 63
    :cond_1
    iget v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 64
    .line 65
    int-to-float v1, v1

    .line 66
    iget v2, v2, Ld1/f;->Y:F

    .line 67
    .line 68
    :goto_0
    div-float/2addr v1, v2

    .line 69
    :goto_1
    add-float/2addr v1, v3

    .line 70
    float-to-int v1, v1

    .line 71
    goto :goto_2

    .line 72
    :cond_2
    iget v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 73
    .line 74
    int-to-float v1, v1

    .line 75
    iget v2, v2, Ld1/f;->Y:F

    .line 76
    .line 77
    mul-float/2addr v1, v2

    .line 78
    goto :goto_1

    .line 79
    :cond_3
    iget v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 80
    .line 81
    int-to-float v1, v1

    .line 82
    iget v2, v2, Ld1/f;->Y:F

    .line 83
    .line 84
    goto :goto_0

    .line 85
    :goto_2
    invoke-virtual {p1, v1}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 86
    .line 87
    .line 88
    goto :goto_3

    .line 89
    :cond_4
    iget-object v1, v2, Ld1/f;->V:Ld1/f;

    .line 90
    .line 91
    if-eqz v1, :cond_5

    .line 92
    .line 93
    iget-object v1, v1, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 94
    .line 95
    iget-object v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 96
    .line 97
    iget-boolean v5, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 98
    .line 99
    if-eqz v5, :cond_5

    .line 100
    .line 101
    iget v2, v2, Ld1/f;->z:F

    .line 102
    .line 103
    iget v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 104
    .line 105
    int-to-float v1, v1

    .line 106
    mul-float/2addr v1, v2

    .line 107
    add-float/2addr v1, v3

    .line 108
    float-to-int v1, v1

    .line 109
    invoke-virtual {p1, v1}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 110
    .line 111
    .line 112
    :cond_5
    :goto_3
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 113
    .line 114
    iget-boolean v2, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 115
    .line 116
    if-eqz v2, :cond_d

    .line 117
    .line 118
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 119
    .line 120
    iget-boolean v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 121
    .line 122
    if-nez v5, :cond_6

    .line 123
    .line 124
    goto/16 :goto_6

    .line 125
    .line 126
    :cond_6
    iget-boolean v5, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 127
    .line 128
    if-eqz v5, :cond_7

    .line 129
    .line 130
    iget-boolean v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 131
    .line 132
    if-eqz v5, :cond_7

    .line 133
    .line 134
    iget-boolean v5, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 135
    .line 136
    if-eqz v5, :cond_7

    .line 137
    .line 138
    return-void

    .line 139
    :cond_7
    iget-boolean v5, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 140
    .line 141
    if-nez v5, :cond_8

    .line 142
    .line 143
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 144
    .line 145
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 146
    .line 147
    if-ne v5, v6, :cond_8

    .line 148
    .line 149
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 150
    .line 151
    iget v6, v5, Ld1/f;->r:I

    .line 152
    .line 153
    if-nez v6, :cond_8

    .line 154
    .line 155
    invoke-virtual {v5}, Ld1/f;->z()Z

    .line 156
    .line 157
    .line 158
    move-result v5

    .line 159
    if-nez v5, :cond_8

    .line 160
    .line 161
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 162
    .line 163
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 164
    .line 165
    .line 166
    move-result-object v0

    .line 167
    check-cast v0, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 168
    .line 169
    iget-object v3, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 170
    .line 171
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 172
    .line 173
    .line 174
    move-result-object v3

    .line 175
    check-cast v3, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 176
    .line 177
    iget v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 178
    .line 179
    iget v4, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 180
    .line 181
    add-int/2addr v0, v4

    .line 182
    iget v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 183
    .line 184
    iget v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 185
    .line 186
    add-int/2addr v3, v4

    .line 187
    sub-int v4, v3, v0

    .line 188
    .line 189
    invoke-virtual {v1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 190
    .line 191
    .line 192
    invoke-virtual {v2, v3}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 193
    .line 194
    .line 195
    invoke-virtual {p1, v4}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 196
    .line 197
    .line 198
    return-void

    .line 199
    :cond_8
    iget-boolean v5, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 200
    .line 201
    if-nez v5, :cond_a

    .line 202
    .line 203
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 204
    .line 205
    sget-object v6, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 206
    .line 207
    if-ne v5, v6, :cond_a

    .line 208
    .line 209
    iget v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->a:I

    .line 210
    .line 211
    if-ne v5, v0, :cond_a

    .line 212
    .line 213
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 214
    .line 215
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 216
    .line 217
    .line 218
    move-result v0

    .line 219
    if-lez v0, :cond_a

    .line 220
    .line 221
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 222
    .line 223
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 224
    .line 225
    .line 226
    move-result v0

    .line 227
    if-lez v0, :cond_a

    .line 228
    .line 229
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 230
    .line 231
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 232
    .line 233
    .line 234
    move-result-object v0

    .line 235
    check-cast v0, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 236
    .line 237
    iget-object v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 238
    .line 239
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 240
    .line 241
    .line 242
    move-result-object v5

    .line 243
    check-cast v5, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 244
    .line 245
    iget v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 246
    .line 247
    iget v6, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 248
    .line 249
    add-int/2addr v0, v6

    .line 250
    iget v5, v5, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 251
    .line 252
    iget v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 253
    .line 254
    add-int/2addr v5, v6

    .line 255
    sub-int/2addr v5, v0

    .line 256
    iget v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/b;->m:I

    .line 257
    .line 258
    if-ge v5, v0, :cond_9

    .line 259
    .line 260
    invoke-virtual {p1, v5}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 261
    .line 262
    .line 263
    goto :goto_4

    .line 264
    :cond_9
    invoke-virtual {p1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 265
    .line 266
    .line 267
    :cond_a
    :goto_4
    iget-boolean v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 268
    .line 269
    if-nez v0, :cond_b

    .line 270
    .line 271
    return-void

    .line 272
    :cond_b
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 273
    .line 274
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 275
    .line 276
    .line 277
    move-result v0

    .line 278
    if-lez v0, :cond_d

    .line 279
    .line 280
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 281
    .line 282
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 283
    .line 284
    .line 285
    move-result v0

    .line 286
    if-lez v0, :cond_d

    .line 287
    .line 288
    iget-object v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 289
    .line 290
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 291
    .line 292
    .line 293
    move-result-object v0

    .line 294
    check-cast v0, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 295
    .line 296
    iget-object v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 297
    .line 298
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 299
    .line 300
    .line 301
    move-result-object v4

    .line 302
    check-cast v4, Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 303
    .line 304
    iget v5, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 305
    .line 306
    iget v6, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 307
    .line 308
    add-int/2addr v6, v5

    .line 309
    iget v7, v4, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 310
    .line 311
    iget v8, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 312
    .line 313
    add-int/2addr v8, v7

    .line 314
    iget-object v9, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 315
    .line 316
    iget v9, v9, Ld1/f;->g0:F

    .line 317
    .line 318
    if-ne v0, v4, :cond_c

    .line 319
    .line 320
    move v9, v3

    .line 321
    goto :goto_5

    .line 322
    :cond_c
    move v5, v6

    .line 323
    move v7, v8

    .line 324
    :goto_5
    sub-int/2addr v7, v5

    .line 325
    iget v0, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 326
    .line 327
    sub-int/2addr v7, v0

    .line 328
    int-to-float v0, v5

    .line 329
    add-float/2addr v0, v3

    .line 330
    int-to-float v3, v7

    .line 331
    mul-float/2addr v3, v9

    .line 332
    add-float/2addr v3, v0

    .line 333
    float-to-int v0, v3

    .line 334
    invoke-virtual {v1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 335
    .line 336
    .line 337
    iget v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 338
    .line 339
    iget p1, p1, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 340
    .line 341
    add-int/2addr v0, p1

    .line 342
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 343
    .line 344
    .line 345
    :cond_d
    :goto_6
    return-void

    .line 346
    :cond_e
    iget-object p1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 347
    .line 348
    iget-object v1, p1, Ld1/f;->K:Ld1/d;

    .line 349
    .line 350
    iget-object p1, p1, Ld1/f;->M:Ld1/d;

    .line 351
    .line 352
    invoke-virtual {p0, v1, p1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->l(Ld1/d;Ld1/d;I)V

    .line 353
    .line 354
    .line 355
    return-void
.end method

.method public final d()V
    .locals 14

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
    invoke-virtual {v0}, Ld1/f;->l()I

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
    const/4 v4, 0x1

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
    iget-boolean v0, v0, Ld1/f;->E:Z

    .line 34
    .line 35
    if-eqz v0, :cond_1

    .line 36
    .line 37
    new-instance v0, Le1/a;

    .line 38
    .line 39
    invoke-direct {v0, p0}, Le1/a;-><init>(Landroidx/constraintlayout/core/widgets/analyzer/g;)V

    .line 40
    .line 41
    .line 42
    iput-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 43
    .line 44
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 45
    .line 46
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 47
    .line 48
    if-eq v0, v5, :cond_4

    .line 49
    .line 50
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 51
    .line 52
    if-ne v0, v5, :cond_2

    .line 53
    .line 54
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 55
    .line 56
    iget-object v5, v5, Ld1/f;->V:Ld1/f;

    .line 57
    .line 58
    if-eqz v5, :cond_2

    .line 59
    .line 60
    iget-object v6, v5, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 61
    .line 62
    aget-object v6, v6, v4

    .line 63
    .line 64
    sget-object v7, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 65
    .line 66
    if-ne v6, v7, :cond_2

    .line 67
    .line 68
    invoke-virtual {v5}, Ld1/f;->l()I

    .line 69
    .line 70
    .line 71
    move-result v0

    .line 72
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 73
    .line 74
    iget-object v4, v4, Ld1/f;->K:Ld1/d;

    .line 75
    .line 76
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 77
    .line 78
    .line 79
    move-result v4

    .line 80
    sub-int/2addr v0, v4

    .line 81
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 82
    .line 83
    iget-object v4, v4, Ld1/f;->M:Ld1/d;

    .line 84
    .line 85
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 86
    .line 87
    .line 88
    move-result v4

    .line 89
    sub-int/2addr v0, v4

    .line 90
    iget-object v4, v5, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 91
    .line 92
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 93
    .line 94
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 95
    .line 96
    iget-object v6, v6, Ld1/f;->K:Ld1/d;

    .line 97
    .line 98
    invoke-virtual {v6}, Ld1/d;->e()I

    .line 99
    .line 100
    .line 101
    move-result v6

    .line 102
    invoke-static {v3, v4, v6}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 103
    .line 104
    .line 105
    iget-object v3, v5, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 106
    .line 107
    iget-object v3, v3, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 108
    .line 109
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 110
    .line 111
    iget-object v4, v4, Ld1/f;->M:Ld1/d;

    .line 112
    .line 113
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 114
    .line 115
    .line 116
    move-result v4

    .line 117
    neg-int v4, v4

    .line 118
    invoke-static {v1, v3, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 119
    .line 120
    .line 121
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 122
    .line 123
    .line 124
    return-void

    .line 125
    :cond_2
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 126
    .line 127
    if-ne v0, v5, :cond_4

    .line 128
    .line 129
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 130
    .line 131
    invoke-virtual {v0}, Ld1/f;->l()I

    .line 132
    .line 133
    .line 134
    move-result v0

    .line 135
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 136
    .line 137
    .line 138
    goto :goto_0

    .line 139
    :cond_3
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 140
    .line 141
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 142
    .line 143
    if-ne v0, v5, :cond_4

    .line 144
    .line 145
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 146
    .line 147
    iget-object v5, v0, Ld1/f;->V:Ld1/f;

    .line 148
    .line 149
    if-eqz v5, :cond_4

    .line 150
    .line 151
    iget-object v6, v5, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 152
    .line 153
    aget-object v6, v6, v4

    .line 154
    .line 155
    sget-object v7, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 156
    .line 157
    if-ne v6, v7, :cond_4

    .line 158
    .line 159
    iget-object v2, v5, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 160
    .line 161
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 162
    .line 163
    iget-object v0, v0, Ld1/f;->K:Ld1/d;

    .line 164
    .line 165
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 166
    .line 167
    .line 168
    move-result v0

    .line 169
    invoke-static {v3, v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 170
    .line 171
    .line 172
    iget-object v0, v5, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 173
    .line 174
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 175
    .line 176
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 177
    .line 178
    iget-object v2, v2, Ld1/f;->M:Ld1/d;

    .line 179
    .line 180
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 181
    .line 182
    .line 183
    move-result v2

    .line 184
    neg-int v2, v2

    .line 185
    invoke-static {v1, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 186
    .line 187
    .line 188
    return-void

    .line 189
    :cond_4
    :goto_0
    iget-boolean v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 190
    .line 191
    iget-object v5, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->k:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 192
    .line 193
    const/4 v6, 0x0

    .line 194
    const/4 v7, 0x4

    .line 195
    const/4 v8, 0x2

    .line 196
    const/4 v9, 0x3

    .line 197
    if-eqz v0, :cond_d

    .line 198
    .line 199
    iget-object v10, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 200
    .line 201
    iget-boolean v11, v10, Ld1/f;->a:Z

    .line 202
    .line 203
    if-eqz v11, :cond_d

    .line 204
    .line 205
    iget-object v0, v10, Ld1/f;->R:[Ld1/d;

    .line 206
    .line 207
    aget-object v11, v0, v8

    .line 208
    .line 209
    iget-object v12, v11, Ld1/d;->f:Ld1/d;

    .line 210
    .line 211
    if-eqz v12, :cond_8

    .line 212
    .line 213
    aget-object v13, v0, v9

    .line 214
    .line 215
    iget-object v13, v13, Ld1/d;->f:Ld1/d;

    .line 216
    .line 217
    if-eqz v13, :cond_8

    .line 218
    .line 219
    invoke-virtual {v10}, Ld1/f;->z()Z

    .line 220
    .line 221
    .line 222
    move-result v0

    .line 223
    if-eqz v0, :cond_5

    .line 224
    .line 225
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 226
    .line 227
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 228
    .line 229
    aget-object v0, v0, v8

    .line 230
    .line 231
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 232
    .line 233
    .line 234
    move-result v0

    .line 235
    iput v0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 236
    .line 237
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 238
    .line 239
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 240
    .line 241
    aget-object v0, v0, v9

    .line 242
    .line 243
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 244
    .line 245
    .line 246
    move-result v0

    .line 247
    neg-int v0, v0

    .line 248
    iput v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 249
    .line 250
    goto :goto_1

    .line 251
    :cond_5
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 252
    .line 253
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 254
    .line 255
    aget-object v0, v0, v8

    .line 256
    .line 257
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 258
    .line 259
    .line 260
    move-result-object v0

    .line 261
    if-eqz v0, :cond_6

    .line 262
    .line 263
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 264
    .line 265
    iget-object v2, v2, Ld1/f;->R:[Ld1/d;

    .line 266
    .line 267
    aget-object v2, v2, v8

    .line 268
    .line 269
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 270
    .line 271
    .line 272
    move-result v2

    .line 273
    invoke-static {v3, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 274
    .line 275
    .line 276
    :cond_6
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 277
    .line 278
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 279
    .line 280
    aget-object v0, v0, v9

    .line 281
    .line 282
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 283
    .line 284
    .line 285
    move-result-object v0

    .line 286
    if-eqz v0, :cond_7

    .line 287
    .line 288
    iget-object v2, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 289
    .line 290
    iget-object v2, v2, Ld1/f;->R:[Ld1/d;

    .line 291
    .line 292
    aget-object v2, v2, v9

    .line 293
    .line 294
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 295
    .line 296
    .line 297
    move-result v2

    .line 298
    neg-int v2, v2

    .line 299
    invoke-static {v1, v0, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 300
    .line 301
    .line 302
    :cond_7
    iput-boolean v4, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 303
    .line 304
    iput-boolean v4, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 305
    .line 306
    :goto_1
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 307
    .line 308
    iget-boolean v1, v0, Ld1/f;->E:Z

    .line 309
    .line 310
    if-eqz v1, :cond_1e

    .line 311
    .line 312
    iget v0, v0, Ld1/f;->c0:I

    .line 313
    .line 314
    invoke-static {v5, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 315
    .line 316
    .line 317
    goto/16 :goto_5

    .line 318
    .line 319
    :cond_8
    if-eqz v12, :cond_9

    .line 320
    .line 321
    invoke-static {v11}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 322
    .line 323
    .line 324
    move-result-object v0

    .line 325
    if-eqz v0, :cond_1e

    .line 326
    .line 327
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 328
    .line 329
    iget-object v4, v4, Ld1/f;->R:[Ld1/d;

    .line 330
    .line 331
    aget-object v4, v4, v8

    .line 332
    .line 333
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 334
    .line 335
    .line 336
    move-result v4

    .line 337
    invoke-static {v3, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 338
    .line 339
    .line 340
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 341
    .line 342
    invoke-static {v1, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 343
    .line 344
    .line 345
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 346
    .line 347
    iget-boolean v1, v0, Ld1/f;->E:Z

    .line 348
    .line 349
    if-eqz v1, :cond_1e

    .line 350
    .line 351
    iget v0, v0, Ld1/f;->c0:I

    .line 352
    .line 353
    invoke-static {v5, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 354
    .line 355
    .line 356
    goto/16 :goto_5

    .line 357
    .line 358
    :cond_9
    aget-object v4, v0, v9

    .line 359
    .line 360
    iget-object v8, v4, Ld1/d;->f:Ld1/d;

    .line 361
    .line 362
    if-eqz v8, :cond_b

    .line 363
    .line 364
    invoke-static {v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 365
    .line 366
    .line 367
    move-result-object v0

    .line 368
    if-eqz v0, :cond_a

    .line 369
    .line 370
    iget-object v4, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 371
    .line 372
    iget-object v4, v4, Ld1/f;->R:[Ld1/d;

    .line 373
    .line 374
    aget-object v4, v4, v9

    .line 375
    .line 376
    invoke-virtual {v4}, Ld1/d;->e()I

    .line 377
    .line 378
    .line 379
    move-result v4

    .line 380
    neg-int v4, v4

    .line 381
    invoke-static {v1, v0, v4}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 382
    .line 383
    .line 384
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 385
    .line 386
    neg-int v0, v0

    .line 387
    invoke-static {v3, v1, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 388
    .line 389
    .line 390
    :cond_a
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 391
    .line 392
    iget-boolean v1, v0, Ld1/f;->E:Z

    .line 393
    .line 394
    if-eqz v1, :cond_1e

    .line 395
    .line 396
    iget v0, v0, Ld1/f;->c0:I

    .line 397
    .line 398
    invoke-static {v5, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 399
    .line 400
    .line 401
    goto/16 :goto_5

    .line 402
    .line 403
    :cond_b
    aget-object v0, v0, v7

    .line 404
    .line 405
    iget-object v4, v0, Ld1/d;->f:Ld1/d;

    .line 406
    .line 407
    if-eqz v4, :cond_c

    .line 408
    .line 409
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 410
    .line 411
    .line 412
    move-result-object v0

    .line 413
    if-eqz v0, :cond_1e

    .line 414
    .line 415
    invoke-static {v5, v0, v6}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 416
    .line 417
    .line 418
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 419
    .line 420
    iget v0, v0, Ld1/f;->c0:I

    .line 421
    .line 422
    neg-int v0, v0

    .line 423
    invoke-static {v3, v5, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 424
    .line 425
    .line 426
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 427
    .line 428
    invoke-static {v1, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 429
    .line 430
    .line 431
    goto/16 :goto_5

    .line 432
    .line 433
    :cond_c
    instance-of v0, v10, Ld1/l;

    .line 434
    .line 435
    if-nez v0, :cond_1e

    .line 436
    .line 437
    iget-object v0, v10, Ld1/f;->V:Ld1/f;

    .line 438
    .line 439
    if-eqz v0, :cond_1e

    .line 440
    .line 441
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->CENTER:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 442
    .line 443
    invoke-virtual {v10, v0}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 444
    .line 445
    .line 446
    move-result-object v0

    .line 447
    iget-object v0, v0, Ld1/d;->f:Ld1/d;

    .line 448
    .line 449
    if-nez v0, :cond_1e

    .line 450
    .line 451
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 452
    .line 453
    iget-object v4, v0, Ld1/f;->V:Ld1/f;

    .line 454
    .line 455
    iget-object v4, v4, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 456
    .line 457
    iget-object v4, v4, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 458
    .line 459
    invoke-virtual {v0}, Ld1/f;->t()I

    .line 460
    .line 461
    .line 462
    move-result v0

    .line 463
    invoke-static {v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 464
    .line 465
    .line 466
    iget v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->g:I

    .line 467
    .line 468
    invoke-static {v1, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 469
    .line 470
    .line 471
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 472
    .line 473
    iget-boolean v1, v0, Ld1/f;->E:Z

    .line 474
    .line 475
    if-eqz v1, :cond_1e

    .line 476
    .line 477
    iget v0, v0, Ld1/f;->c0:I

    .line 478
    .line 479
    invoke-static {v5, v3, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 480
    .line 481
    .line 482
    goto/16 :goto_5

    .line 483
    .line 484
    :cond_d
    if-nez v0, :cond_12

    .line 485
    .line 486
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 487
    .line 488
    sget-object v10, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 489
    .line 490
    if-ne v0, v10, :cond_12

    .line 491
    .line 492
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 493
    .line 494
    iget v10, v0, Ld1/f;->s:I

    .line 495
    .line 496
    if-eq v10, v8, :cond_10

    .line 497
    .line 498
    if-eq v10, v9, :cond_e

    .line 499
    .line 500
    goto :goto_2

    .line 501
    :cond_e
    invoke-virtual {v0}, Ld1/f;->z()Z

    .line 502
    .line 503
    .line 504
    move-result v0

    .line 505
    if-nez v0, :cond_13

    .line 506
    .line 507
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 508
    .line 509
    iget v10, v0, Ld1/f;->r:I

    .line 510
    .line 511
    if-ne v10, v9, :cond_f

    .line 512
    .line 513
    goto :goto_2

    .line 514
    :cond_f
    iget-object v0, v0, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 515
    .line 516
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 517
    .line 518
    iget-object v10, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 519
    .line 520
    invoke-virtual {v10, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 521
    .line 522
    .line 523
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 524
    .line 525
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 526
    .line 527
    .line 528
    iput-boolean v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 529
    .line 530
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 531
    .line 532
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 533
    .line 534
    .line 535
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 536
    .line 537
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 538
    .line 539
    .line 540
    goto :goto_2

    .line 541
    :cond_10
    iget-object v0, v0, Ld1/f;->V:Ld1/f;

    .line 542
    .line 543
    if-nez v0, :cond_11

    .line 544
    .line 545
    goto :goto_2

    .line 546
    :cond_11
    iget-object v0, v0, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 547
    .line 548
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 549
    .line 550
    iget-object v10, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 551
    .line 552
    invoke-virtual {v10, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 553
    .line 554
    .line 555
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 556
    .line 557
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 558
    .line 559
    .line 560
    iput-boolean v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->b:Z

    .line 561
    .line 562
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 563
    .line 564
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 565
    .line 566
    .line 567
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 568
    .line 569
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 570
    .line 571
    .line 572
    goto :goto_2

    .line 573
    :cond_12
    invoke-virtual {v2, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->b(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 574
    .line 575
    .line 576
    :cond_13
    :goto_2
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 577
    .line 578
    iget-object v10, v0, Ld1/f;->R:[Ld1/d;

    .line 579
    .line 580
    aget-object v11, v10, v8

    .line 581
    .line 582
    iget-object v12, v11, Ld1/d;->f:Ld1/d;

    .line 583
    .line 584
    if-eqz v12, :cond_17

    .line 585
    .line 586
    aget-object v13, v10, v9

    .line 587
    .line 588
    iget-object v13, v13, Ld1/d;->f:Ld1/d;

    .line 589
    .line 590
    if-eqz v13, :cond_17

    .line 591
    .line 592
    invoke-virtual {v0}, Ld1/f;->z()Z

    .line 593
    .line 594
    .line 595
    move-result v0

    .line 596
    if-eqz v0, :cond_14

    .line 597
    .line 598
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 599
    .line 600
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 601
    .line 602
    aget-object v0, v0, v8

    .line 603
    .line 604
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 605
    .line 606
    .line 607
    move-result v0

    .line 608
    iput v0, v3, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 609
    .line 610
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 611
    .line 612
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 613
    .line 614
    aget-object v0, v0, v9

    .line 615
    .line 616
    invoke-virtual {v0}, Ld1/d;->e()I

    .line 617
    .line 618
    .line 619
    move-result v0

    .line 620
    neg-int v0, v0

    .line 621
    iput v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->f:I

    .line 622
    .line 623
    goto :goto_3

    .line 624
    :cond_14
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 625
    .line 626
    iget-object v0, v0, Ld1/f;->R:[Ld1/d;

    .line 627
    .line 628
    aget-object v0, v0, v8

    .line 629
    .line 630
    invoke-static {v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 631
    .line 632
    .line 633
    move-result-object v0

    .line 634
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 635
    .line 636
    iget-object v1, v1, Ld1/f;->R:[Ld1/d;

    .line 637
    .line 638
    aget-object v1, v1, v9

    .line 639
    .line 640
    invoke-static {v1}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 641
    .line 642
    .line 643
    move-result-object v1

    .line 644
    if-eqz v0, :cond_15

    .line 645
    .line 646
    invoke-virtual {v0, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->b(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 647
    .line 648
    .line 649
    :cond_15
    if-eqz v1, :cond_16

    .line 650
    .line 651
    invoke-virtual {v1, p0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->b(Landroidx/constraintlayout/core/widgets/analyzer/h;)V

    .line 652
    .line 653
    .line 654
    :cond_16
    sget-object v0, Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;->CENTER:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 655
    .line 656
    iput-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->j:Landroidx/constraintlayout/core/widgets/analyzer/WidgetRun$RunType;

    .line 657
    .line 658
    :goto_3
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 659
    .line 660
    iget-boolean v0, v0, Ld1/f;->E:Z

    .line 661
    .line 662
    if-eqz v0, :cond_1d

    .line 663
    .line 664
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 665
    .line 666
    invoke-virtual {p0, v5, v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 667
    .line 668
    .line 669
    goto/16 :goto_4

    .line 670
    .line 671
    :cond_17
    const/4 v13, 0x0

    .line 672
    if-eqz v12, :cond_19

    .line 673
    .line 674
    invoke-static {v11}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 675
    .line 676
    .line 677
    move-result-object v0

    .line 678
    if-eqz v0, :cond_1d

    .line 679
    .line 680
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 681
    .line 682
    iget-object v6, v6, Ld1/f;->R:[Ld1/d;

    .line 683
    .line 684
    aget-object v6, v6, v8

    .line 685
    .line 686
    invoke-virtual {v6}, Ld1/d;->e()I

    .line 687
    .line 688
    .line 689
    move-result v6

    .line 690
    invoke-static {v3, v0, v6}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 691
    .line 692
    .line 693
    invoke-virtual {p0, v1, v3, v4, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 694
    .line 695
    .line 696
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 697
    .line 698
    iget-boolean v0, v0, Ld1/f;->E:Z

    .line 699
    .line 700
    if-eqz v0, :cond_18

    .line 701
    .line 702
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 703
    .line 704
    invoke-virtual {p0, v5, v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 705
    .line 706
    .line 707
    :cond_18
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 708
    .line 709
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 710
    .line 711
    if-ne v0, v1, :cond_1d

    .line 712
    .line 713
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 714
    .line 715
    iget v3, v0, Ld1/f;->Y:F

    .line 716
    .line 717
    cmpl-float v3, v3, v13

    .line 718
    .line 719
    if-lez v3, :cond_1d

    .line 720
    .line 721
    iget-object v0, v0, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 722
    .line 723
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 724
    .line 725
    if-ne v3, v1, :cond_1d

    .line 726
    .line 727
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 728
    .line 729
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 730
    .line 731
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 732
    .line 733
    .line 734
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 735
    .line 736
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 737
    .line 738
    iget-object v1, v1, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 739
    .line 740
    iget-object v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 741
    .line 742
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 743
    .line 744
    .line 745
    iput-object p0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 746
    .line 747
    goto/16 :goto_4

    .line 748
    .line 749
    :cond_19
    aget-object v8, v10, v9

    .line 750
    .line 751
    iget-object v11, v8, Ld1/d;->f:Ld1/d;

    .line 752
    .line 753
    const/4 v12, -0x1

    .line 754
    if-eqz v11, :cond_1a

    .line 755
    .line 756
    invoke-static {v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 757
    .line 758
    .line 759
    move-result-object v0

    .line 760
    if-eqz v0, :cond_1d

    .line 761
    .line 762
    iget-object v6, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 763
    .line 764
    iget-object v6, v6, Ld1/f;->R:[Ld1/d;

    .line 765
    .line 766
    aget-object v6, v6, v9

    .line 767
    .line 768
    invoke-virtual {v6}, Ld1/d;->e()I

    .line 769
    .line 770
    .line 771
    move-result v6

    .line 772
    neg-int v6, v6

    .line 773
    invoke-static {v1, v0, v6}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 774
    .line 775
    .line 776
    invoke-virtual {p0, v3, v1, v12, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 777
    .line 778
    .line 779
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 780
    .line 781
    iget-boolean v0, v0, Ld1/f;->E:Z

    .line 782
    .line 783
    if-eqz v0, :cond_1d

    .line 784
    .line 785
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 786
    .line 787
    invoke-virtual {p0, v5, v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 788
    .line 789
    .line 790
    goto :goto_4

    .line 791
    :cond_1a
    aget-object v7, v10, v7

    .line 792
    .line 793
    iget-object v8, v7, Ld1/d;->f:Ld1/d;

    .line 794
    .line 795
    if-eqz v8, :cond_1b

    .line 796
    .line 797
    invoke-static {v7}, Landroidx/constraintlayout/core/widgets/analyzer/h;->h(Ld1/d;)Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 798
    .line 799
    .line 800
    move-result-object v0

    .line 801
    if-eqz v0, :cond_1d

    .line 802
    .line 803
    invoke-static {v5, v0, v6}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 804
    .line 805
    .line 806
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 807
    .line 808
    invoke-virtual {p0, v3, v5, v12, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 809
    .line 810
    .line 811
    invoke-virtual {p0, v1, v3, v4, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 812
    .line 813
    .line 814
    goto :goto_4

    .line 815
    :cond_1b
    instance-of v6, v0, Ld1/l;

    .line 816
    .line 817
    if-nez v6, :cond_1d

    .line 818
    .line 819
    iget-object v6, v0, Ld1/f;->V:Ld1/f;

    .line 820
    .line 821
    if-eqz v6, :cond_1d

    .line 822
    .line 823
    iget-object v6, v6, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 824
    .line 825
    iget-object v6, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 826
    .line 827
    invoke-virtual {v0}, Ld1/f;->t()I

    .line 828
    .line 829
    .line 830
    move-result v0

    .line 831
    invoke-static {v3, v6, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->b(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;I)V

    .line 832
    .line 833
    .line 834
    invoke-virtual {p0, v1, v3, v4, v2}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 835
    .line 836
    .line 837
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 838
    .line 839
    iget-boolean v0, v0, Ld1/f;->E:Z

    .line 840
    .line 841
    if-eqz v0, :cond_1c

    .line 842
    .line 843
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->l:Le1/a;

    .line 844
    .line 845
    invoke-virtual {p0, v5, v3, v4, v0}, Landroidx/constraintlayout/core/widgets/analyzer/h;->c(Landroidx/constraintlayout/core/widgets/analyzer/a;Landroidx/constraintlayout/core/widgets/analyzer/a;ILandroidx/constraintlayout/core/widgets/analyzer/b;)V

    .line 846
    .line 847
    .line 848
    :cond_1c
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 849
    .line 850
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 851
    .line 852
    if-ne v0, v1, :cond_1d

    .line 853
    .line 854
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 855
    .line 856
    iget v3, v0, Ld1/f;->Y:F

    .line 857
    .line 858
    cmpl-float v3, v3, v13

    .line 859
    .line 860
    if-lez v3, :cond_1d

    .line 861
    .line 862
    iget-object v0, v0, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 863
    .line 864
    iget-object v3, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->d:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 865
    .line 866
    if-ne v3, v1, :cond_1d

    .line 867
    .line 868
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 869
    .line 870
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/a;->k:Ljava/util/ArrayList;

    .line 871
    .line 872
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 873
    .line 874
    .line 875
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 876
    .line 877
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 878
    .line 879
    iget-object v1, v1, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 880
    .line 881
    iget-object v1, v1, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 882
    .line 883
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 884
    .line 885
    .line 886
    iput-object p0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->a:Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 887
    .line 888
    :cond_1d
    :goto_4
    iget-object v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->l:Ljava/util/ArrayList;

    .line 889
    .line 890
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    .line 891
    .line 892
    .line 893
    move-result v0

    .line 894
    if-nez v0, :cond_1e

    .line 895
    .line 896
    iput-boolean v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/a;->c:Z

    .line 897
    .line 898
    :cond_1e
    :goto_5
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
    iput v0, v1, Ld1/f;->b0:I

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
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->k:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 15
    .line 16
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 17
    .line 18
    .line 19
    iget-object v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 20
    .line 21
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 22
    .line 23
    .line 24
    const/4 v0, 0x0

    .line 25
    iput-boolean v0, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 26
    .line 27
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
    iget v0, v0, Ld1/f;->s:I

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

.method public final m()V
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
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/g;->k:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 19
    .line 20
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/analyzer/a;->c()V

    .line 21
    .line 22
    .line 23
    iput-boolean v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 24
    .line 25
    iget-object v1, p0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 26
    .line 27
    iput-boolean v0, v1, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 28
    .line 29
    return-void
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    .line 2
    .line 3
    const-string v1, "VerticalRun "

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
