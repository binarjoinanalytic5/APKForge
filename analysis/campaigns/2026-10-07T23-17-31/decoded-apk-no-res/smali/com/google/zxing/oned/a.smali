.class public final Lcom/google/zxing/oned/a;
.super Lcom/moloco/sdk/internal/publisher/s;
.source "SourceFile"


# direct methods
.method public static N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;
    .locals 4

    .line 1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    if-lt p0, v0, :cond_0

    .line 6
    .line 7
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->UNCODABLE:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 8
    .line 9
    return-object p0

    .line 10
    :cond_0
    invoke-virtual {p1, p0}, Ljava/lang/String;->charAt(I)C

    .line 11
    .line 12
    .line 13
    move-result v1

    .line 14
    const/16 v2, 0xf1

    .line 15
    .line 16
    if-ne v1, v2, :cond_1

    .line 17
    .line 18
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->FNC_1:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 19
    .line 20
    return-object p0

    .line 21
    :cond_1
    const/16 v2, 0x30

    .line 22
    .line 23
    if-lt v1, v2, :cond_6

    .line 24
    .line 25
    const/16 v3, 0x39

    .line 26
    .line 27
    if-le v1, v3, :cond_2

    .line 28
    .line 29
    goto :goto_1

    .line 30
    :cond_2
    add-int/lit8 p0, p0, 0x1

    .line 31
    .line 32
    if-lt p0, v0, :cond_3

    .line 33
    .line 34
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->ONE_DIGIT:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 35
    .line 36
    return-object p0

    .line 37
    :cond_3
    invoke-virtual {p1, p0}, Ljava/lang/String;->charAt(I)C

    .line 38
    .line 39
    .line 40
    move-result p0

    .line 41
    if-lt p0, v2, :cond_5

    .line 42
    .line 43
    if-le p0, v3, :cond_4

    .line 44
    .line 45
    goto :goto_0

    .line 46
    :cond_4
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->TWO_DIGITS:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 47
    .line 48
    return-object p0

    .line 49
    :cond_5
    :goto_0
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->ONE_DIGIT:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 50
    .line 51
    return-object p0

    .line 52
    :cond_6
    :goto_1
    sget-object p0, Lcom/google/zxing/oned/Code128Writer$CType;->UNCODABLE:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 53
    .line 54
    return-object p0
.end method


# virtual methods
.method public final s(Ljava/lang/String;Lcom/google/zxing/BarcodeFormat;Ljava/util/EnumMap;)Lxg/b;
    .locals 1

    .line 1
    sget-object v0, Lcom/google/zxing/BarcodeFormat;->CODE_128:Lcom/google/zxing/BarcodeFormat;

    .line 2
    .line 3
    if-ne p2, v0, :cond_0

    .line 4
    .line 5
    invoke-super {p0, p1, p2, p3}, Lcom/moloco/sdk/internal/publisher/s;->s(Ljava/lang/String;Lcom/google/zxing/BarcodeFormat;Ljava/util/EnumMap;)Lxg/b;

    .line 6
    .line 7
    .line 8
    move-result-object p1

    .line 9
    return-object p1

    .line 10
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    .line 11
    .line 12
    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    .line 13
    .line 14
    .line 15
    move-result-object p2

    .line 16
    const-string p3, "Can only encode CODE_128, but got "

    .line 17
    .line 18
    invoke-virtual {p3, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 19
    .line 20
    .line 21
    move-result-object p2

    .line 22
    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 23
    .line 24
    .line 25
    throw p1
.end method

.method public final t(Ljava/lang/String;)[Z
    .locals 16

    .line 1
    move-object/from16 v0, p1

    .line 2
    .line 3
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    .line 4
    .line 5
    .line 6
    move-result v1

    .line 7
    if-lez v1, :cond_1b

    .line 8
    .line 9
    const/16 v2, 0x50

    .line 10
    .line 11
    if-gt v1, v2, :cond_1b

    .line 12
    .line 13
    const/4 v3, 0x0

    .line 14
    :goto_0
    if-ge v3, v1, :cond_1

    .line 15
    .line 16
    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    .line 17
    .line 18
    .line 19
    move-result v4

    .line 20
    packed-switch v4, :pswitch_data_0

    .line 21
    .line 22
    .line 23
    const/16 v5, 0x7f

    .line 24
    .line 25
    if-gt v4, v5, :cond_0

    .line 26
    .line 27
    goto :goto_1

    .line 28
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    .line 29
    .line 30
    const-string v1, "Bad character in input: "

    .line 31
    .line 32
    invoke-static {v4}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    .line 33
    .line 34
    .line 35
    move-result-object v2

    .line 36
    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 37
    .line 38
    .line 39
    move-result-object v1

    .line 40
    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 41
    .line 42
    .line 43
    throw v0

    .line 44
    :goto_1
    :pswitch_0
    add-int/lit8 v3, v3, 0x1

    .line 45
    .line 46
    goto :goto_0

    .line 47
    :cond_1
    new-instance v3, Ljava/util/ArrayList;

    .line 48
    .line 49
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 50
    .line 51
    .line 52
    const/4 v4, 0x1

    .line 53
    move v8, v4

    .line 54
    const/4 v5, 0x0

    .line 55
    const/4 v6, 0x0

    .line 56
    const/4 v7, 0x0

    .line 57
    :cond_2
    :goto_2
    sget-object v9, Lbh/c;->e:[[I

    .line 58
    .line 59
    if-ge v5, v1, :cond_17

    .line 60
    .line 61
    invoke-static {v5, v0}, Lcom/google/zxing/oned/a;->N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;

    .line 62
    .line 63
    .line 64
    move-result-object v11

    .line 65
    sget-object v12, Lcom/google/zxing/oned/Code128Writer$CType;->ONE_DIGIT:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 66
    .line 67
    const/16 v13, 0x20

    .line 68
    .line 69
    const/16 v14, 0x60

    .line 70
    .line 71
    const/16 v15, 0x64

    .line 72
    .line 73
    const/16 v2, 0x65

    .line 74
    .line 75
    if-ne v11, v12, :cond_4

    .line 76
    .line 77
    :cond_3
    :goto_3
    move v14, v15

    .line 78
    goto/16 :goto_6

    .line 79
    .line 80
    :cond_4
    sget-object v10, Lcom/google/zxing/oned/Code128Writer$CType;->UNCODABLE:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 81
    .line 82
    if-ne v11, v10, :cond_6

    .line 83
    .line 84
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    .line 85
    .line 86
    .line 87
    move-result v10

    .line 88
    if-ge v5, v10, :cond_3

    .line 89
    .line 90
    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    .line 91
    .line 92
    .line 93
    move-result v10

    .line 94
    if-lt v10, v13, :cond_5

    .line 95
    .line 96
    if-ne v7, v2, :cond_3

    .line 97
    .line 98
    if-ge v10, v14, :cond_3

    .line 99
    .line 100
    :cond_5
    move v14, v2

    .line 101
    goto :goto_6

    .line 102
    :cond_6
    const/16 v14, 0x63

    .line 103
    .line 104
    if-ne v7, v14, :cond_7

    .line 105
    .line 106
    goto :goto_6

    .line 107
    :cond_7
    if-ne v7, v15, :cond_d

    .line 108
    .line 109
    sget-object v14, Lcom/google/zxing/oned/Code128Writer$CType;->FNC_1:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 110
    .line 111
    if-ne v11, v14, :cond_8

    .line 112
    .line 113
    goto :goto_3

    .line 114
    :cond_8
    add-int/lit8 v11, v5, 0x2

    .line 115
    .line 116
    invoke-static {v11, v0}, Lcom/google/zxing/oned/a;->N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;

    .line 117
    .line 118
    .line 119
    move-result-object v11

    .line 120
    if-eq v11, v10, :cond_3

    .line 121
    .line 122
    if-ne v11, v12, :cond_9

    .line 123
    .line 124
    goto :goto_3

    .line 125
    :cond_9
    if-ne v11, v14, :cond_b

    .line 126
    .line 127
    add-int/lit8 v10, v5, 0x3

    .line 128
    .line 129
    invoke-static {v10, v0}, Lcom/google/zxing/oned/a;->N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;

    .line 130
    .line 131
    .line 132
    move-result-object v10

    .line 133
    sget-object v11, Lcom/google/zxing/oned/Code128Writer$CType;->TWO_DIGITS:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 134
    .line 135
    if-ne v10, v11, :cond_3

    .line 136
    .line 137
    :cond_a
    :goto_4
    const/16 v14, 0x63

    .line 138
    .line 139
    goto :goto_6

    .line 140
    :cond_b
    add-int/lit8 v10, v5, 0x4

    .line 141
    .line 142
    :goto_5
    invoke-static {v10, v0}, Lcom/google/zxing/oned/a;->N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;

    .line 143
    .line 144
    .line 145
    move-result-object v11

    .line 146
    sget-object v12, Lcom/google/zxing/oned/Code128Writer$CType;->TWO_DIGITS:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 147
    .line 148
    if-ne v11, v12, :cond_c

    .line 149
    .line 150
    add-int/lit8 v10, v10, 0x2

    .line 151
    .line 152
    goto :goto_5

    .line 153
    :cond_c
    sget-object v10, Lcom/google/zxing/oned/Code128Writer$CType;->ONE_DIGIT:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 154
    .line 155
    if-ne v11, v10, :cond_a

    .line 156
    .line 157
    goto :goto_3

    .line 158
    :cond_d
    sget-object v10, Lcom/google/zxing/oned/Code128Writer$CType;->FNC_1:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 159
    .line 160
    if-ne v11, v10, :cond_e

    .line 161
    .line 162
    add-int/lit8 v10, v5, 0x1

    .line 163
    .line 164
    invoke-static {v10, v0}, Lcom/google/zxing/oned/a;->N(ILjava/lang/String;)Lcom/google/zxing/oned/Code128Writer$CType;

    .line 165
    .line 166
    .line 167
    move-result-object v11

    .line 168
    :cond_e
    sget-object v10, Lcom/google/zxing/oned/Code128Writer$CType;->TWO_DIGITS:Lcom/google/zxing/oned/Code128Writer$CType;

    .line 169
    .line 170
    if-ne v11, v10, :cond_3

    .line 171
    .line 172
    goto :goto_4

    .line 173
    :goto_6
    if-ne v14, v7, :cond_13

    .line 174
    .line 175
    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    .line 176
    .line 177
    .line 178
    move-result v10

    .line 179
    packed-switch v10, :pswitch_data_1

    .line 180
    .line 181
    .line 182
    if-eq v7, v15, :cond_10

    .line 183
    .line 184
    if-eq v7, v2, :cond_f

    .line 185
    .line 186
    add-int/lit8 v2, v5, 0x2

    .line 187
    .line 188
    invoke-virtual {v0, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    .line 189
    .line 190
    .line 191
    move-result-object v2

    .line 192
    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 193
    .line 194
    .line 195
    move-result v14

    .line 196
    add-int/lit8 v5, v5, 0x1

    .line 197
    .line 198
    goto :goto_7

    .line 199
    :cond_f
    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    .line 200
    .line 201
    .line 202
    move-result v2

    .line 203
    add-int/lit8 v14, v2, -0x20

    .line 204
    .line 205
    if-gez v14, :cond_12

    .line 206
    .line 207
    add-int/lit8 v14, v2, 0x40

    .line 208
    .line 209
    goto :goto_7

    .line 210
    :cond_10
    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    .line 211
    .line 212
    .line 213
    move-result v2

    .line 214
    add-int/lit8 v14, v2, -0x20

    .line 215
    .line 216
    goto :goto_7

    .line 217
    :pswitch_1
    if-ne v7, v2, :cond_11

    .line 218
    .line 219
    move v14, v2

    .line 220
    goto :goto_7

    .line 221
    :cond_11
    move v14, v15

    .line 222
    goto :goto_7

    .line 223
    :pswitch_2
    const/16 v14, 0x60

    .line 224
    .line 225
    goto :goto_7

    .line 226
    :pswitch_3
    const/16 v14, 0x61

    .line 227
    .line 228
    goto :goto_7

    .line 229
    :pswitch_4
    const/16 v14, 0x66

    .line 230
    .line 231
    :cond_12
    :goto_7
    add-int/2addr v5, v4

    .line 232
    goto :goto_9

    .line 233
    :cond_13
    if-nez v7, :cond_16

    .line 234
    .line 235
    if-eq v14, v15, :cond_15

    .line 236
    .line 237
    if-eq v14, v2, :cond_14

    .line 238
    .line 239
    const/16 v10, 0x69

    .line 240
    .line 241
    goto :goto_8

    .line 242
    :cond_14
    const/16 v10, 0x67

    .line 243
    .line 244
    goto :goto_8

    .line 245
    :cond_15
    const/16 v10, 0x68

    .line 246
    .line 247
    goto :goto_8

    .line 248
    :cond_16
    move v10, v14

    .line 249
    :goto_8
    move v7, v14

    .line 250
    move v14, v10

    .line 251
    :goto_9
    aget-object v2, v9, v14

    .line 252
    .line 253
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 254
    .line 255
    .line 256
    mul-int/2addr v14, v8

    .line 257
    add-int/2addr v6, v14

    .line 258
    if-eqz v5, :cond_2

    .line 259
    .line 260
    add-int/lit8 v8, v8, 0x1

    .line 261
    .line 262
    goto/16 :goto_2

    .line 263
    .line 264
    :cond_17
    const/16 v2, 0x67

    .line 265
    .line 266
    rem-int/2addr v6, v2

    .line 267
    aget-object v0, v9, v6

    .line 268
    .line 269
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 270
    .line 271
    .line 272
    const/16 v0, 0x6a

    .line 273
    .line 274
    aget-object v0, v9, v0

    .line 275
    .line 276
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 277
    .line 278
    .line 279
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 280
    .line 281
    .line 282
    move-result-object v0

    .line 283
    const/4 v1, 0x0

    .line 284
    :cond_18
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 285
    .line 286
    .line 287
    move-result v2

    .line 288
    if-eqz v2, :cond_19

    .line 289
    .line 290
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 291
    .line 292
    .line 293
    move-result-object v2

    .line 294
    check-cast v2, [I

    .line 295
    .line 296
    array-length v5, v2

    .line 297
    const/4 v6, 0x0

    .line 298
    :goto_a
    if-ge v6, v5, :cond_18

    .line 299
    .line 300
    aget v7, v2, v6

    .line 301
    .line 302
    add-int/2addr v1, v7

    .line 303
    add-int/lit8 v6, v6, 0x1

    .line 304
    .line 305
    goto :goto_a

    .line 306
    :cond_19
    new-array v0, v1, [Z

    .line 307
    .line 308
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 309
    .line 310
    .line 311
    move-result-object v1

    .line 312
    const/4 v2, 0x0

    .line 313
    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    .line 314
    .line 315
    .line 316
    move-result v3

    .line 317
    if-eqz v3, :cond_1a

    .line 318
    .line 319
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 320
    .line 321
    .line 322
    move-result-object v3

    .line 323
    check-cast v3, [I

    .line 324
    .line 325
    invoke-static {v0, v2, v3, v4}, Lcom/moloco/sdk/internal/publisher/s;->j([ZI[IZ)I

    .line 326
    .line 327
    .line 328
    move-result v3

    .line 329
    add-int/2addr v2, v3

    .line 330
    goto :goto_b

    .line 331
    :cond_1a
    return-object v0

    .line 332
    :cond_1b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    .line 333
    .line 334
    const-string v2, "Contents length should be between 1 and 80 characters, but got "

    .line 335
    .line 336
    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    .line 337
    .line 338
    .line 339
    move-result-object v1

    .line 340
    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 341
    .line 342
    .line 343
    move-result-object v1

    .line 344
    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .line 345
    .line 346
    .line 347
    throw v0

    .line 348
    nop

    .line 349
    :pswitch_data_0
    .packed-switch 0xf1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch

    .line 350
    .line 351
    .line 352
    .line 353
    .line 354
    .line 355
    .line 356
    .line 357
    .line 358
    .line 359
    .line 360
    .line 361
    :pswitch_data_1
    .packed-switch 0xf1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
