.class public Lcom/google/firebase/concurrent/ExecutorsRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/components/ComponentRegistrar;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ThreadPoolCreation"
    }
.end annotation


# static fields
.field public static final a:Ljf/k;

.field public static final b:Ljf/k;

.field public static final c:Ljf/k;

.field public static final d:Ljf/k;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Ljf/k;

    .line 2
    .line 3
    new-instance v1, Lcom/google/firebase/messaging/j;

    .line 4
    .line 5
    const/4 v2, 0x3

    .line 6
    invoke-direct {v1, v2}, Lcom/google/firebase/messaging/j;-><init>(I)V

    .line 7
    .line 8
    .line 9
    invoke-direct {v0, v1}, Ljf/k;-><init>(Lkg/b;)V

    .line 10
    .line 11
    .line 12
    sput-object v0, Lcom/google/firebase/concurrent/ExecutorsRegistrar;->a:Ljf/k;

    .line 13
    .line 14
    new-instance v0, Ljf/k;

    .line 15
    .line 16
    new-instance v1, Lcom/google/firebase/messaging/j;

    .line 17
    .line 18
    const/4 v2, 0x4

    .line 19
    invoke-direct {v1, v2}, Lcom/google/firebase/messaging/j;-><init>(I)V

    .line 20
    .line 21
    .line 22
    invoke-direct {v0, v1}, Ljf/k;-><init>(Lkg/b;)V

    .line 23
    .line 24
    .line 25
    sput-object v0, Lcom/google/firebase/concurrent/ExecutorsRegistrar;->b:Ljf/k;

    .line 26
    .line 27
    new-instance v0, Ljf/k;

    .line 28
    .line 29
    new-instance v1, Lcom/google/firebase/messaging/j;

    .line 30
    .line 31
    const/4 v2, 0x5

    .line 32
    invoke-direct {v1, v2}, Lcom/google/firebase/messaging/j;-><init>(I)V

    .line 33
    .line 34
    .line 35
    invoke-direct {v0, v1}, Ljf/k;-><init>(Lkg/b;)V

    .line 36
    .line 37
    .line 38
    sput-object v0, Lcom/google/firebase/concurrent/ExecutorsRegistrar;->c:Ljf/k;

    .line 39
    .line 40
    new-instance v0, Ljf/k;

    .line 41
    .line 42
    new-instance v1, Lcom/google/firebase/messaging/j;

    .line 43
    .line 44
    const/4 v2, 0x6

    .line 45
    invoke-direct {v1, v2}, Lcom/google/firebase/messaging/j;-><init>(I)V

    .line 46
    .line 47
    .line 48
    invoke-direct {v0, v1}, Ljf/k;-><init>(Lkg/b;)V

    .line 49
    .line 50
    .line 51
    sput-object v0, Lcom/google/firebase/concurrent/ExecutorsRegistrar;->d:Ljf/k;

    .line 52
    .line 53
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    .line 3
    .line 4
    return-void
.end method


# virtual methods
.method public final getComponents()Ljava/util/List;
    .locals 21

    .line 1
    const/4 v0, 0x4

    .line 2
    const/4 v1, 0x0

    .line 3
    const/4 v2, 0x2

    .line 4
    const/4 v3, 0x1

    .line 5
    new-instance v4, Ljf/o;

    .line 6
    .line 7
    const-class v5, Lif/a;

    .line 8
    .line 9
    const-class v6, Ljava/util/concurrent/ScheduledExecutorService;

    .line 10
    .line 11
    invoke-direct {v4, v5, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 12
    .line 13
    .line 14
    new-instance v7, Ljf/o;

    .line 15
    .line 16
    const-class v8, Ljava/util/concurrent/ExecutorService;

    .line 17
    .line 18
    invoke-direct {v7, v5, v8}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 19
    .line 20
    .line 21
    new-instance v9, Ljf/o;

    .line 22
    .line 23
    const-class v10, Ljava/util/concurrent/Executor;

    .line 24
    .line 25
    invoke-direct {v9, v5, v10}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 26
    .line 27
    .line 28
    new-array v5, v2, [Ljf/o;

    .line 29
    .line 30
    aput-object v7, v5, v1

    .line 31
    .line 32
    aput-object v9, v5, v3

    .line 33
    .line 34
    new-instance v7, Ljava/util/HashSet;

    .line 35
    .line 36
    invoke-direct {v7}, Ljava/util/HashSet;-><init>()V

    .line 37
    .line 38
    .line 39
    new-instance v9, Ljava/util/HashSet;

    .line 40
    .line 41
    invoke-direct {v9}, Ljava/util/HashSet;-><init>()V

    .line 42
    .line 43
    .line 44
    new-instance v18, Ljava/util/HashSet;

    .line 45
    .line 46
    invoke-direct/range {v18 .. v18}, Ljava/util/HashSet;-><init>()V

    .line 47
    .line 48
    .line 49
    invoke-virtual {v7, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 50
    .line 51
    .line 52
    array-length v4, v5

    .line 53
    const/16 v16, 0x0

    .line 54
    .line 55
    move/from16 v11, v16

    .line 56
    .line 57
    :goto_0
    const-string v15, "Null interface"

    .line 58
    .line 59
    if-ge v11, v4, :cond_0

    .line 60
    .line 61
    aget-object v12, v5, v11

    .line 62
    .line 63
    invoke-static {v12, v15}, Lef/b;->m(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    .line 65
    .line 66
    add-int/2addr v11, v3

    .line 67
    goto :goto_0

    .line 68
    :cond_0
    invoke-static {v7, v5}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    .line 69
    .line 70
    .line 71
    new-instance v4, Lef/i;

    .line 72
    .line 73
    invoke-direct {v4, v0}, Lef/i;-><init>(I)V

    .line 74
    .line 75
    .line 76
    new-instance v5, Ljf/b;

    .line 77
    .line 78
    new-instance v13, Ljava/util/HashSet;

    .line 79
    .line 80
    invoke-direct {v13, v7}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 81
    .line 82
    .line 83
    new-instance v14, Ljava/util/HashSet;

    .line 84
    .line 85
    invoke-direct {v14, v9}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 86
    .line 87
    .line 88
    const/4 v12, 0x0

    .line 89
    move-object v11, v5

    .line 90
    move-object v7, v15

    .line 91
    move/from16 v15, v16

    .line 92
    .line 93
    move-object/from16 v17, v4

    .line 94
    .line 95
    invoke-direct/range {v11 .. v18}, Ljf/b;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILjf/e;Ljava/util/Set;)V

    .line 96
    .line 97
    .line 98
    new-instance v4, Ljf/o;

    .line 99
    .line 100
    const-class v9, Lif/b;

    .line 101
    .line 102
    invoke-direct {v4, v9, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 103
    .line 104
    .line 105
    new-instance v11, Ljf/o;

    .line 106
    .line 107
    invoke-direct {v11, v9, v8}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 108
    .line 109
    .line 110
    new-instance v12, Ljf/o;

    .line 111
    .line 112
    invoke-direct {v12, v9, v10}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 113
    .line 114
    .line 115
    new-array v9, v2, [Ljf/o;

    .line 116
    .line 117
    aput-object v11, v9, v1

    .line 118
    .line 119
    aput-object v12, v9, v3

    .line 120
    .line 121
    new-instance v11, Ljava/util/HashSet;

    .line 122
    .line 123
    invoke-direct {v11}, Ljava/util/HashSet;-><init>()V

    .line 124
    .line 125
    .line 126
    new-instance v12, Ljava/util/HashSet;

    .line 127
    .line 128
    invoke-direct {v12}, Ljava/util/HashSet;-><init>()V

    .line 129
    .line 130
    .line 131
    new-instance v20, Ljava/util/HashSet;

    .line 132
    .line 133
    invoke-direct/range {v20 .. v20}, Ljava/util/HashSet;-><init>()V

    .line 134
    .line 135
    .line 136
    invoke-virtual {v11, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 137
    .line 138
    .line 139
    array-length v4, v9

    .line 140
    const/16 v18, 0x0

    .line 141
    .line 142
    move/from16 v13, v18

    .line 143
    .line 144
    :goto_1
    if-ge v13, v4, :cond_1

    .line 145
    .line 146
    aget-object v14, v9, v13

    .line 147
    .line 148
    invoke-static {v14, v7}, Lef/b;->m(Ljava/lang/Object;Ljava/lang/String;)V

    .line 149
    .line 150
    .line 151
    add-int/2addr v13, v3

    .line 152
    goto :goto_1

    .line 153
    :cond_1
    invoke-static {v11, v9}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    .line 154
    .line 155
    .line 156
    new-instance v4, Lef/i;

    .line 157
    .line 158
    const/4 v9, 0x5

    .line 159
    invoke-direct {v4, v9}, Lef/i;-><init>(I)V

    .line 160
    .line 161
    .line 162
    new-instance v9, Ljf/b;

    .line 163
    .line 164
    new-instance v15, Ljava/util/HashSet;

    .line 165
    .line 166
    invoke-direct {v15, v11}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 167
    .line 168
    .line 169
    new-instance v11, Ljava/util/HashSet;

    .line 170
    .line 171
    invoke-direct {v11, v12}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 172
    .line 173
    .line 174
    const/4 v14, 0x0

    .line 175
    move-object v13, v9

    .line 176
    move-object/from16 v16, v11

    .line 177
    .line 178
    move/from16 v17, v18

    .line 179
    .line 180
    move-object/from16 v19, v4

    .line 181
    .line 182
    invoke-direct/range {v13 .. v20}, Ljf/b;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILjf/e;Ljava/util/Set;)V

    .line 183
    .line 184
    .line 185
    new-instance v4, Ljf/o;

    .line 186
    .line 187
    const-class v11, Lif/c;

    .line 188
    .line 189
    invoke-direct {v4, v11, v6}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 190
    .line 191
    .line 192
    new-instance v6, Ljf/o;

    .line 193
    .line 194
    invoke-direct {v6, v11, v8}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 195
    .line 196
    .line 197
    new-instance v8, Ljf/o;

    .line 198
    .line 199
    invoke-direct {v8, v11, v10}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 200
    .line 201
    .line 202
    new-array v11, v2, [Ljf/o;

    .line 203
    .line 204
    aput-object v6, v11, v1

    .line 205
    .line 206
    aput-object v8, v11, v3

    .line 207
    .line 208
    new-instance v6, Ljava/util/HashSet;

    .line 209
    .line 210
    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    .line 211
    .line 212
    .line 213
    new-instance v8, Ljava/util/HashSet;

    .line 214
    .line 215
    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    .line 216
    .line 217
    .line 218
    new-instance v19, Ljava/util/HashSet;

    .line 219
    .line 220
    invoke-direct/range {v19 .. v19}, Ljava/util/HashSet;-><init>()V

    .line 221
    .line 222
    .line 223
    invoke-virtual {v6, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 224
    .line 225
    .line 226
    array-length v4, v11

    .line 227
    const/16 v17, 0x0

    .line 228
    .line 229
    move/from16 v12, v17

    .line 230
    .line 231
    :goto_2
    if-ge v12, v4, :cond_2

    .line 232
    .line 233
    aget-object v13, v11, v12

    .line 234
    .line 235
    invoke-static {v13, v7}, Lef/b;->m(Ljava/lang/Object;Ljava/lang/String;)V

    .line 236
    .line 237
    .line 238
    add-int/2addr v12, v3

    .line 239
    goto :goto_2

    .line 240
    :cond_2
    invoke-static {v6, v11}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    .line 241
    .line 242
    .line 243
    new-instance v4, Lef/i;

    .line 244
    .line 245
    const/4 v7, 0x6

    .line 246
    invoke-direct {v4, v7}, Lef/i;-><init>(I)V

    .line 247
    .line 248
    .line 249
    new-instance v7, Ljf/b;

    .line 250
    .line 251
    new-instance v14, Ljava/util/HashSet;

    .line 252
    .line 253
    invoke-direct {v14, v6}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 254
    .line 255
    .line 256
    new-instance v15, Ljava/util/HashSet;

    .line 257
    .line 258
    invoke-direct {v15, v8}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 259
    .line 260
    .line 261
    const/4 v13, 0x0

    .line 262
    move-object v12, v7

    .line 263
    move/from16 v16, v17

    .line 264
    .line 265
    move-object/from16 v18, v4

    .line 266
    .line 267
    invoke-direct/range {v12 .. v19}, Ljf/b;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILjf/e;Ljava/util/Set;)V

    .line 268
    .line 269
    .line 270
    new-instance v4, Ljf/o;

    .line 271
    .line 272
    const-class v6, Lif/d;

    .line 273
    .line 274
    invoke-direct {v4, v6, v10}, Ljf/o;-><init>(Ljava/lang/Class;Ljava/lang/Class;)V

    .line 275
    .line 276
    .line 277
    invoke-static {v4}, Ljf/b;->b(Ljf/o;)Ljf/a;

    .line 278
    .line 279
    .line 280
    move-result-object v4

    .line 281
    new-instance v6, Lef/i;

    .line 282
    .line 283
    const/4 v8, 0x7

    .line 284
    invoke-direct {v6, v8}, Lef/i;-><init>(I)V

    .line 285
    .line 286
    .line 287
    iput-object v6, v4, Ljf/a;->f:Ljf/e;

    .line 288
    .line 289
    invoke-virtual {v4}, Ljf/a;->b()Ljf/b;

    .line 290
    .line 291
    .line 292
    move-result-object v4

    .line 293
    new-array v0, v0, [Ljf/b;

    .line 294
    .line 295
    aput-object v5, v0, v1

    .line 296
    .line 297
    aput-object v9, v0, v3

    .line 298
    .line 299
    aput-object v7, v0, v2

    .line 300
    .line 301
    const/4 v1, 0x3

    .line 302
    aput-object v4, v0, v1

    .line 303
    .line 304
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 305
    .line 306
    .line 307
    move-result-object v0

    .line 308
    return-object v0
.end method
