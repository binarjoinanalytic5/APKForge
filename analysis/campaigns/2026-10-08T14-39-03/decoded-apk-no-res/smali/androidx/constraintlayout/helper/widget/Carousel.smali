.class public Landroidx/constraintlayout/helper/widget/Carousel;
.super Landroidx/constraintlayout/motion/widget/MotionHelper;
.source "SourceFile"


# instance fields
.field public final m:Ljava/util/ArrayList;

.field public n:I

.field public o:Landroidx/constraintlayout/motion/widget/MotionLayout;

.field public p:I

.field public q:Z

.field public r:I

.field public s:I

.field public t:I

.field public u:I

.field public v:F

.field public w:I

.field public x:I

.field public y:F


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    .line 1
    invoke-direct {p0, p1, p2}, Landroidx/constraintlayout/motion/widget/MotionHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->m:Ljava/util/ArrayList;

    const/4 v0, 0x0

    .line 3
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    const/4 v1, -0x1

    .line 4
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->p:I

    .line 5
    iput-boolean v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->q:Z

    .line 6
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->r:I

    .line 7
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->s:I

    .line 8
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->t:I

    .line 9
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->u:I

    const v0, 0x3f666666    # 0.9f

    .line 10
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->v:F

    const/4 v0, 0x4

    .line 11
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->w:I

    const/4 v0, 0x1

    .line 12
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->x:I

    const/high16 v0, 0x40000000    # 2.0f

    .line 13
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->y:F

    .line 14
    new-instance v0, Lai/g;

    const/16 v1, 0x1a

    invoke-direct {v0, p0, v1}, Lai/g;-><init>(Ljava/lang/Object;I)V

    .line 15
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/helper/widget/Carousel;->s(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1

    .line 16
    invoke-direct {p0, p1, p2, p3}, Landroidx/constraintlayout/motion/widget/MotionHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 17
    new-instance p3, Ljava/util/ArrayList;

    invoke-direct {p3}, Ljava/util/ArrayList;-><init>()V

    iput-object p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->m:Ljava/util/ArrayList;

    const/4 p3, 0x0

    .line 18
    iput p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    const/4 v0, -0x1

    .line 19
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->p:I

    .line 20
    iput-boolean p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->q:Z

    .line 21
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->r:I

    .line 22
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->s:I

    .line 23
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->t:I

    .line 24
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->u:I

    const p3, 0x3f666666    # 0.9f

    .line 25
    iput p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->v:F

    const/4 p3, 0x4

    .line 26
    iput p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->w:I

    const/4 p3, 0x1

    .line 27
    iput p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->x:I

    const/high16 p3, 0x40000000    # 2.0f

    .line 28
    iput p3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->y:F

    .line 29
    new-instance p3, Lai/g;

    const/16 v0, 0x1a

    invoke-direct {p3, p0, v0}, Lai/g;-><init>(Ljava/lang/Object;I)V

    .line 30
    invoke-virtual {p0, p1, p2}, Landroidx/constraintlayout/helper/widget/Carousel;->s(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method


# virtual methods
.method public final a(I)V
    .locals 2

    .line 1
    iget v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    .line 2
    .line 3
    iget v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->u:I

    .line 4
    .line 5
    if-ne p1, v1, :cond_0

    .line 6
    .line 7
    add-int/lit8 v0, v0, 0x1

    .line 8
    .line 9
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    .line 10
    .line 11
    goto :goto_0

    .line 12
    :cond_0
    iget v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->t:I

    .line 13
    .line 14
    if-ne p1, v1, :cond_1

    .line 15
    .line 16
    add-int/lit8 v0, v0, -0x1

    .line 17
    .line 18
    iput v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    .line 19
    .line 20
    :cond_1
    :goto_0
    iget-boolean p1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->q:Z

    .line 21
    .line 22
    const/4 v0, 0x0

    .line 23
    if-eqz p1, :cond_2

    .line 24
    .line 25
    throw v0

    .line 26
    :cond_2
    throw v0
.end method

.method public getCount()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getCurrentIndex()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->n:I

    .line 2
    .line 3
    return v0
.end method

.method public final onAttachedToWindow()V
    .locals 4

    .line 1
    invoke-super {p0}, Landroidx/constraintlayout/widget/ConstraintHelper;->onAttachedToWindow()V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    .line 5
    .line 6
    .line 7
    move-result-object v0

    .line 8
    instance-of v0, v0, Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 9
    .line 10
    if-eqz v0, :cond_2

    .line 11
    .line 12
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    .line 13
    .line 14
    .line 15
    move-result-object v0

    .line 16
    check-cast v0, Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 17
    .line 18
    const/4 v1, 0x0

    .line 19
    :goto_0
    iget v2, p0, Landroidx/constraintlayout/widget/ConstraintHelper;->b:I

    .line 20
    .line 21
    if-ge v1, v2, :cond_0

    .line 22
    .line 23
    iget-object v2, p0, Landroidx/constraintlayout/widget/ConstraintHelper;->a:[I

    .line 24
    .line 25
    aget v2, v2, v1

    .line 26
    .line 27
    invoke-virtual {v0, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->f(I)Landroid/view/View;

    .line 28
    .line 29
    .line 30
    move-result-object v2

    .line 31
    iget-object v3, p0, Landroidx/constraintlayout/helper/widget/Carousel;->m:Ljava/util/ArrayList;

    .line 32
    .line 33
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 34
    .line 35
    .line 36
    add-int/lit8 v1, v1, 0x1

    .line 37
    .line 38
    goto :goto_0

    .line 39
    :cond_0
    iput-object v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->o:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 40
    .line 41
    iget v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->x:I

    .line 42
    .line 43
    const/4 v2, 0x2

    .line 44
    if-ne v1, v2, :cond_2

    .line 45
    .line 46
    iget v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->s:I

    .line 47
    .line 48
    invoke-virtual {v0, v1}, Landroidx/constraintlayout/motion/widget/MotionLayout;->x(I)Lh1/x;

    .line 49
    .line 50
    .line 51
    move-result-object v0

    .line 52
    const/4 v1, 0x5

    .line 53
    if-eqz v0, :cond_1

    .line 54
    .line 55
    iget-object v0, v0, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 56
    .line 57
    if-eqz v0, :cond_1

    .line 58
    .line 59
    iput v1, v0, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 60
    .line 61
    :cond_1
    iget-object v0, p0, Landroidx/constraintlayout/helper/widget/Carousel;->o:Landroidx/constraintlayout/motion/widget/MotionLayout;

    .line 62
    .line 63
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->r:I

    .line 64
    .line 65
    invoke-virtual {v0, v2}, Landroidx/constraintlayout/motion/widget/MotionLayout;->x(I)Lh1/x;

    .line 66
    .line 67
    .line 68
    move-result-object v0

    .line 69
    if-eqz v0, :cond_2

    .line 70
    .line 71
    iget-object v0, v0, Lh1/x;->l:Landroidx/constraintlayout/motion/widget/d;

    .line 72
    .line 73
    if-eqz v0, :cond_2

    .line 74
    .line 75
    iput v1, v0, Landroidx/constraintlayout/motion/widget/d;->c:I

    .line 76
    .line 77
    :cond_2
    return-void
.end method

.method public final s(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3

    .line 1
    if-eqz p2, :cond_b

    .line 2
    .line 3
    sget-object v0, Lj1/m;->a:[I

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
    if-ge v0, p2, :cond_a

    .line 15
    .line 16
    invoke-virtual {p1, v0}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 17
    .line 18
    .line 19
    move-result v1

    .line 20
    const/4 v2, 0x3

    .line 21
    if-ne v1, v2, :cond_0

    .line 22
    .line 23
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->p:I

    .line 24
    .line 25
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 26
    .line 27
    .line 28
    move-result v1

    .line 29
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->p:I

    .line 30
    .line 31
    goto/16 :goto_1

    .line 32
    .line 33
    :cond_0
    const/4 v2, 0x1

    .line 34
    if-ne v1, v2, :cond_1

    .line 35
    .line 36
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->r:I

    .line 37
    .line 38
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 39
    .line 40
    .line 41
    move-result v1

    .line 42
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->r:I

    .line 43
    .line 44
    goto :goto_1

    .line 45
    :cond_1
    const/4 v2, 0x4

    .line 46
    if-ne v1, v2, :cond_2

    .line 47
    .line 48
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->s:I

    .line 49
    .line 50
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 51
    .line 52
    .line 53
    move-result v1

    .line 54
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->s:I

    .line 55
    .line 56
    goto :goto_1

    .line 57
    :cond_2
    const/4 v2, 0x2

    .line 58
    if-ne v1, v2, :cond_3

    .line 59
    .line 60
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->w:I

    .line 61
    .line 62
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 63
    .line 64
    .line 65
    move-result v1

    .line 66
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->w:I

    .line 67
    .line 68
    goto :goto_1

    .line 69
    :cond_3
    const/4 v2, 0x7

    .line 70
    if-ne v1, v2, :cond_4

    .line 71
    .line 72
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->t:I

    .line 73
    .line 74
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 75
    .line 76
    .line 77
    move-result v1

    .line 78
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->t:I

    .line 79
    .line 80
    goto :goto_1

    .line 81
    :cond_4
    const/4 v2, 0x6

    .line 82
    if-ne v1, v2, :cond_5

    .line 83
    .line 84
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->u:I

    .line 85
    .line 86
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 87
    .line 88
    .line 89
    move-result v1

    .line 90
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->u:I

    .line 91
    .line 92
    goto :goto_1

    .line 93
    :cond_5
    const/16 v2, 0x9

    .line 94
    .line 95
    if-ne v1, v2, :cond_6

    .line 96
    .line 97
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->v:F

    .line 98
    .line 99
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 100
    .line 101
    .line 102
    move-result v1

    .line 103
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->v:F

    .line 104
    .line 105
    goto :goto_1

    .line 106
    :cond_6
    const/16 v2, 0x8

    .line 107
    .line 108
    if-ne v1, v2, :cond_7

    .line 109
    .line 110
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->x:I

    .line 111
    .line 112
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 113
    .line 114
    .line 115
    move-result v1

    .line 116
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->x:I

    .line 117
    .line 118
    goto :goto_1

    .line 119
    :cond_7
    const/16 v2, 0xa

    .line 120
    .line 121
    if-ne v1, v2, :cond_8

    .line 122
    .line 123
    iget v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->y:F

    .line 124
    .line 125
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getFloat(IF)F

    .line 126
    .line 127
    .line 128
    move-result v1

    .line 129
    iput v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->y:F

    .line 130
    .line 131
    goto :goto_1

    .line 132
    :cond_8
    const/4 v2, 0x5

    .line 133
    if-ne v1, v2, :cond_9

    .line 134
    .line 135
    iget-boolean v2, p0, Landroidx/constraintlayout/helper/widget/Carousel;->q:Z

    .line 136
    .line 137
    invoke-virtual {p1, v1, v2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    .line 138
    .line 139
    .line 140
    move-result v1

    .line 141
    iput-boolean v1, p0, Landroidx/constraintlayout/helper/widget/Carousel;->q:Z

    .line 142
    .line 143
    :cond_9
    :goto_1
    add-int/lit8 v0, v0, 0x1

    .line 144
    .line 145
    goto/16 :goto_0

    .line 146
    .line 147
    :cond_a
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    .line 148
    .line 149
    .line 150
    :cond_b
    return-void
.end method

.method public setAdapter(Lf1/a;)V
    .locals 0

    .line 1
    return-void
.end method
