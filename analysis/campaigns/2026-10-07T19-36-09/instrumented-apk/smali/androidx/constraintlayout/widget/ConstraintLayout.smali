.class public Landroidx/constraintlayout/widget/ConstraintLayout;
.super Landroid/view/ViewGroup;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;
    }
.end annotation


# static fields
.field public static r:Lj1/o;


# instance fields
.field public a:Landroid/util/SparseArray;

.field public b:Ljava/util/ArrayList;

.field public c:Ld1/g;

.field public d:I

.field public e:I

.field public f:I

.field public g:I

.field public h:Z

.field public i:I

.field public j:Landroidx/constraintlayout/widget/d;

.field public k:Lcom/google/firebase/messaging/o;

.field public l:I

.field public m:Ljava/util/HashMap;

.field public n:Landroid/util/SparseArray;

.field public o:Landroidx/constraintlayout/widget/b;

.field public p:I

.field public q:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 1
    invoke-direct {p0, p1, p2}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 2
    new-instance p1, Landroid/util/SparseArray;

    invoke-direct {p1}, Landroid/util/SparseArray;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 3
    new-instance p1, Ljava/util/ArrayList;

    const/4 v0, 0x4

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 4
    new-instance p1, Ld1/g;

    invoke-direct {p1}, Ld1/g;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    const/4 p1, 0x0

    .line 5
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 6
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    const v0, 0x7fffffff

    .line 7
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 8
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    const/4 v0, 0x1

    .line 9
    iput-boolean v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    const/16 v0, 0x101

    .line 10
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    const/4 v0, 0x0

    .line 11
    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 12
    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    const/4 v0, -0x1

    .line 13
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->l:I

    .line 14
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->m:Ljava/util/HashMap;

    .line 15
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->n:Landroid/util/SparseArray;

    .line 16
    new-instance v0, Landroidx/constraintlayout/widget/b;

    invoke-direct {v0, p0, p0}, Landroidx/constraintlayout/widget/b;-><init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroidx/constraintlayout/widget/ConstraintLayout;)V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->o:Landroidx/constraintlayout/widget/b;

    .line 17
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->p:I

    .line 18
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->q:I

    .line 19
    invoke-virtual {p0, p2, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->k(Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 20
    invoke-direct {p0, p1, p2, p3}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 21
    new-instance p1, Landroid/util/SparseArray;

    invoke-direct {p1}, Landroid/util/SparseArray;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 22
    new-instance p1, Ljava/util/ArrayList;

    const/4 v0, 0x4

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 23
    new-instance p1, Ld1/g;

    invoke-direct {p1}, Ld1/g;-><init>()V

    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    const/4 p1, 0x0

    .line 24
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 25
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    const v0, 0x7fffffff

    .line 26
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 27
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    const/4 v0, 0x1

    .line 28
    iput-boolean v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    const/16 v0, 0x101

    .line 29
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    const/4 v0, 0x0

    .line 30
    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 31
    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    const/4 v0, -0x1

    .line 32
    iput v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->l:I

    .line 33
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->m:Ljava/util/HashMap;

    .line 34
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->n:Landroid/util/SparseArray;

    .line 35
    new-instance v0, Landroidx/constraintlayout/widget/b;

    invoke-direct {v0, p0, p0}, Landroidx/constraintlayout/widget/b;-><init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroidx/constraintlayout/widget/ConstraintLayout;)V

    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->o:Landroidx/constraintlayout/widget/b;

    .line 36
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->p:I

    .line 37
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->q:I

    .line 38
    invoke-virtual {p0, p2, p3}, Landroidx/constraintlayout/widget/ConstraintLayout;->k(Landroid/util/AttributeSet;I)V

    return-void
.end method

.method private getPaddingWidth()I
    .locals 4

    .line 1
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    const/4 v1, 0x0

    .line 6
    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    .line 7
    .line 8
    .line 9
    move-result v0

    .line 10
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    .line 11
    .line 12
    .line 13
    move-result v2

    .line 14
    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    .line 15
    .line 16
    .line 17
    move-result v2

    .line 18
    add-int/2addr v2, v0

    .line 19
    invoke-virtual {p0}, Landroid/view/View;->getPaddingStart()I

    .line 20
    .line 21
    .line 22
    move-result v0

    .line 23
    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    .line 24
    .line 25
    .line 26
    move-result v0

    .line 27
    invoke-virtual {p0}, Landroid/view/View;->getPaddingEnd()I

    .line 28
    .line 29
    .line 30
    move-result v3

    .line 31
    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    .line 32
    .line 33
    .line 34
    move-result v1

    .line 35
    add-int/2addr v1, v0

    .line 36
    if-lez v1, :cond_0

    .line 37
    .line 38
    move v2, v1

    .line 39
    :cond_0
    return v2
.end method

.method public static getSharedValues()Lj1/o;
    .locals 1

    .line 1
    sget-object v0, Landroidx/constraintlayout/widget/ConstraintLayout;->r:Lj1/o;

    .line 2
    .line 3
    if-nez v0, :cond_0

    .line 4
    .line 5
    new-instance v0, Lj1/o;

    .line 6
    .line 7
    invoke-direct {v0}, Lj1/o;-><init>()V

    .line 8
    .line 9
    .line 10
    sput-object v0, Landroidx/constraintlayout/widget/ConstraintLayout;->r:Lj1/o;

    .line 11
    .line 12
    :cond_0
    sget-object v0, Landroidx/constraintlayout/widget/ConstraintLayout;->r:Lj1/o;

    .line 13
    .line 14
    return-object v0
.end method


# virtual methods
.method public final a(ZLandroid/view/View;Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;)V
    .locals 17

    move-object/from16 v0, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    .line 1
    invoke-virtual/range {p4 .. p4}, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->a()V

    .line 2
    invoke-virtual/range {p2 .. p2}, Landroid/view/View;->getVisibility()I

    move-result v1

    .line 3
    iput v1, v6, Ld1/f;->i0:I

    .line 4
    iget-boolean v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->f0:Z

    const/4 v9, 0x1

    if-eqz v1, :cond_0

    .line 5
    iput-boolean v9, v6, Ld1/f;->F:Z

    const/16 v1, 0x8

    .line 6
    iput v1, v6, Ld1/f;->i0:I

    .line 7
    :cond_0
    iput-object v0, v6, Ld1/f;->h0:Landroid/view/View;

    .line 8
    instance-of v1, v0, Landroidx/constraintlayout/widget/ConstraintHelper;

    if-eqz v1, :cond_1

    .line 9
    check-cast v0, Landroidx/constraintlayout/widget/ConstraintHelper;

    move-object/from16 v10, p0

    .line 10
    iget-object v1, v10, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    iget-boolean v1, v1, Ld1/g;->z0:Z

    .line 11
    invoke-virtual {v0, v6, v1}, Landroidx/constraintlayout/widget/ConstraintHelper;->m(Ld1/f;Z)V

    goto :goto_0

    :cond_1
    move-object/from16 v10, p0

    .line 12
    :goto_0
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->d0:Z

    const/4 v11, -0x1

    if-eqz v0, :cond_4

    .line 13
    move-object v0, v6

    check-cast v0, Ld1/k;

    .line 14
    iget v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->n0:I

    .line 15
    iget v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->o0:I

    .line 16
    iget v3, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->p0:F

    const/high16 v4, -0x40800000    # -1.0f

    cmpl-float v5, v3, v4

    if-eqz v5, :cond_2

    if-lez v5, :cond_2c

    .line 17
    iput v3, v0, Ld1/k;->u0:F

    .line 18
    iput v11, v0, Ld1/k;->v0:I

    .line 19
    iput v11, v0, Ld1/k;->w0:I

    goto/16 :goto_12

    :cond_2
    if-eq v1, v11, :cond_3

    if-le v1, v11, :cond_2c

    .line 20
    iput v4, v0, Ld1/k;->u0:F

    .line 21
    iput v1, v0, Ld1/k;->v0:I

    .line 22
    iput v11, v0, Ld1/k;->w0:I

    goto/16 :goto_12

    :cond_3
    if-eq v2, v11, :cond_2c

    if-le v2, v11, :cond_2c

    .line 23
    iput v4, v0, Ld1/k;->u0:F

    .line 24
    iput v11, v0, Ld1/k;->v0:I

    .line 25
    iput v2, v0, Ld1/k;->w0:I

    goto/16 :goto_12

    .line 26
    :cond_4
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->g0:I

    .line 27
    iget v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->h0:I

    .line 28
    iget v12, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->i0:I

    .line 29
    iget v13, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->j0:I

    .line 30
    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->k0:I

    .line 31
    iget v14, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->l0:I

    .line 32
    iget v15, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->m0:F

    .line 33
    iget v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->p:I

    const/4 v4, 0x0

    if-eq v2, v11, :cond_6

    .line 34
    invoke-virtual {v8, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_5

    .line 35
    iget v8, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->r:F

    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q:I

    .line 36
    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->CENTER:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    const/4 v12, 0x0

    move-object/from16 v0, p3

    move-object v1, v3

    move v13, v4

    move v4, v5

    move v5, v12

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    .line 37
    iput v8, v6, Ld1/f;->D:F

    goto :goto_1

    :cond_5
    move v13, v4

    :goto_1
    move v9, v13

    goto/16 :goto_7

    :cond_6
    if-eq v0, v11, :cond_8

    .line 38
    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_7

    .line 39
    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->LEFT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v1, v7, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    move-object/from16 v0, p3

    move/from16 v16, v1

    move-object v1, v3

    move v9, v4

    move/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    goto :goto_2

    :cond_7
    move v9, v4

    goto :goto_2

    :cond_8
    move v9, v4

    if-eq v1, v11, :cond_9

    .line 40
    invoke-virtual {v8, v1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_9

    .line 41
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->LEFT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    move-object/from16 v0, p3

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    :cond_9
    :goto_2
    if-eq v12, v11, :cond_a

    .line 42
    invoke-virtual {v8, v12}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_b

    .line 43
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->LEFT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    move-object/from16 v0, p3

    move v5, v14

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    goto :goto_3

    :cond_a
    if-eq v13, v11, :cond_b

    .line 44
    invoke-virtual {v8, v13}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_b

    .line 45
    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    move-object/from16 v0, p3

    move-object v1, v3

    move v5, v14

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    .line 46
    :cond_b
    :goto_3
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->i:I

    if-eq v0, v11, :cond_c

    .line 47
    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_d

    .line 48
    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->x:I

    move-object/from16 v0, p3

    move-object v1, v3

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    goto :goto_4

    .line 49
    :cond_c
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->j:I

    if-eq v0, v11, :cond_d

    .line 50
    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_d

    .line 51
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->x:I

    move-object/from16 v0, p3

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    .line 52
    :cond_d
    :goto_4
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->k:I

    if-eq v0, v11, :cond_e

    .line 53
    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_f

    .line 54
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->z:I

    move-object/from16 v0, p3

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    goto :goto_5

    .line 55
    :cond_e
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->l:I

    if-eq v0, v11, :cond_f

    .line 56
    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ld1/f;

    if-eqz v2, :cond_f

    .line 57
    sget-object v3, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    iget v4, v7, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    iget v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->z:I

    move-object/from16 v0, p3

    move-object v1, v3

    invoke-virtual/range {v0 .. v5}, Ld1/f;->w(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;Ld1/f;Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;II)V

    .line 58
    :cond_f
    :goto_5
    iget v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->m:I

    if-eq v4, v11, :cond_10

    .line 59
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BASELINE:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move-object/from16 v2, p4

    move-object/from16 v3, p5

    invoke-virtual/range {v0 .. v5}, Landroidx/constraintlayout/widget/ConstraintLayout;->p(Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;ILandroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)V

    goto :goto_6

    .line 60
    :cond_10
    iget v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->n:I

    if-eq v4, v11, :cond_11

    .line 61
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move-object/from16 v2, p4

    move-object/from16 v3, p5

    invoke-virtual/range {v0 .. v5}, Landroidx/constraintlayout/widget/ConstraintLayout;->p(Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;ILandroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)V

    goto :goto_6

    .line 62
    :cond_11
    iget v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->o:I

    if-eq v4, v11, :cond_12

    .line 63
    sget-object v5, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move-object/from16 v2, p4

    move-object/from16 v3, p5

    invoke-virtual/range {v0 .. v5}, Landroidx/constraintlayout/widget/ConstraintLayout;->p(Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;ILandroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)V

    :cond_12
    :goto_6
    cmpl-float v0, v15, v9

    if-ltz v0, :cond_13

    .line 64
    iput v15, v6, Ld1/f;->f0:F

    .line 65
    :cond_13
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->F:F

    cmpl-float v1, v0, v9

    if-ltz v1, :cond_14

    .line 66
    iput v0, v6, Ld1/f;->g0:F

    :cond_14
    :goto_7
    if-eqz p1, :cond_16

    .line 67
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->T:I

    if-ne v0, v11, :cond_15

    iget v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->U:I

    if-eq v1, v11, :cond_16

    .line 68
    :cond_15
    iget v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->U:I

    .line 69
    iput v0, v6, Ld1/f;->a0:I

    .line 70
    iput v1, v6, Ld1/f;->b0:I

    .line 71
    :cond_16
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->a0:Z

    const/4 v1, -0x2

    const/4 v2, 0x0

    if-nez v0, :cond_19

    .line 72
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->width:I

    if-ne v0, v11, :cond_18

    .line 73
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->W:Z

    if-eqz v0, :cond_17

    .line 74
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    goto :goto_8

    .line 75
    :cond_17
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 76
    :goto_8
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->LEFT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    invoke-virtual {v6, v0}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    move-result-object v0

    iget v3, v7, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iput v3, v0, Ld1/d;->g:I

    .line 77
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    invoke-virtual {v6, v0}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    move-result-object v0

    iget v3, v7, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iput v3, v0, Ld1/d;->g:I

    goto :goto_9

    .line 78
    :cond_18
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 79
    invoke-virtual {v6, v2}, Ld1/f;->P(I)V

    goto :goto_9

    .line 80
    :cond_19
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 81
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->width:I

    invoke-virtual {v6, v0}, Ld1/f;->P(I)V

    .line 82
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->width:I

    if-ne v0, v1, :cond_1a

    .line 83
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 84
    :cond_1a
    :goto_9
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->b0:Z

    if-nez v0, :cond_1d

    .line 85
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->height:I

    if-ne v0, v11, :cond_1c

    .line 86
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->X:Z

    if-eqz v0, :cond_1b

    .line 87
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    goto :goto_a

    .line 88
    :cond_1b
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 89
    :goto_a
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    invoke-virtual {v6, v0}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    move-result-object v0

    iget v1, v7, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iput v1, v0, Ld1/d;->g:I

    .line 90
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    invoke-virtual {v6, v0}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    move-result-object v0

    iget v1, v7, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    iput v1, v0, Ld1/d;->g:I

    goto :goto_b

    .line 91
    :cond_1c
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 92
    invoke-virtual {v6, v2}, Ld1/f;->M(I)V

    goto :goto_b

    .line 93
    :cond_1d
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 94
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->height:I

    invoke-virtual {v6, v0}, Ld1/f;->M(I)V

    .line 95
    iget v0, v7, Landroid/view/ViewGroup$MarginLayoutParams;->height:I

    if-ne v0, v1, :cond_1e

    .line 96
    sget-object v0, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    invoke-virtual {v6, v0}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 97
    :cond_1e
    :goto_b
    iget-object v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->G:Ljava/lang/String;

    if-eqz v0, :cond_26

    .line 98
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1f

    goto/16 :goto_f

    .line 99
    :cond_1f
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v3, 0x2c

    .line 100
    invoke-virtual {v0, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-lez v3, :cond_22

    add-int/lit8 v4, v1, -0x1

    if-ge v3, v4, :cond_22

    .line 101
    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 102
    const-string v5, "W"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_21

    move v11, v2

    :cond_20
    const/4 v4, 0x1

    goto :goto_c

    .line 103
    :cond_21
    const-string v5, "H"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_20

    const/4 v4, 0x1

    const/4 v11, 0x1

    :goto_c
    add-int/2addr v3, v4

    goto :goto_d

    :cond_22
    const/4 v4, 0x1

    move v3, v2

    :goto_d
    const/16 v5, 0x3a

    .line 104
    invoke-virtual {v0, v5}, Ljava/lang/String;->indexOf(I)I

    move-result v5

    if-ltz v5, :cond_24

    sub-int/2addr v1, v4

    if-ge v5, v1, :cond_24

    .line 105
    invoke-virtual {v0, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/2addr v5, v4

    .line 106
    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 107
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_25

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_25

    .line 108
    :try_start_0
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    .line 109
    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    cmpl-float v3, v1, v9

    if-lez v3, :cond_25

    cmpl-float v3, v0, v9

    if-lez v3, :cond_25

    const/4 v3, 0x1

    if-ne v11, v3, :cond_23

    div-float/2addr v0, v1

    .line 110
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v4

    goto :goto_e

    :cond_23
    div-float/2addr v1, v0

    .line 111
    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v4
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_e

    .line 112
    :cond_24
    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 113
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_25

    .line 114
    :try_start_1
    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v4
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_e

    :catch_0
    :cond_25
    move v4, v9

    :goto_e
    cmpl-float v0, v4, v9

    if-lez v0, :cond_27

    .line 115
    iput v4, v6, Ld1/f;->Y:F

    .line 116
    iput v11, v6, Ld1/f;->Z:I

    goto :goto_10

    .line 117
    :cond_26
    :goto_f
    iput v9, v6, Ld1/f;->Y:F

    .line 118
    :cond_27
    :goto_10
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->H:F

    .line 119
    iget-object v1, v6, Ld1/f;->n0:[F

    aput v0, v1, v2

    .line 120
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->I:F

    const/4 v3, 0x1

    .line 121
    aput v0, v1, v3

    .line 122
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->J:I

    .line 123
    iput v0, v6, Ld1/f;->l0:I

    .line 124
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->K:I

    .line 125
    iput v0, v6, Ld1/f;->m0:I

    .line 126
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->Z:I

    if-ltz v0, :cond_28

    const/4 v1, 0x3

    if-gt v0, v1, :cond_28

    .line 127
    iput v0, v6, Ld1/f;->q:I

    .line 128
    :cond_28
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->L:I

    iget v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->N:I

    iget v3, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->P:I

    iget v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->R:F

    .line 129
    iput v0, v6, Ld1/f;->r:I

    .line 130
    iput v1, v6, Ld1/f;->u:I

    const v1, 0x7fffffff

    if-ne v3, v1, :cond_29

    move v3, v2

    .line 131
    :cond_29
    iput v3, v6, Ld1/f;->v:I

    .line 132
    iput v4, v6, Ld1/f;->w:F

    cmpl-float v3, v4, v9

    const/4 v5, 0x2

    const/high16 v8, 0x3f800000    # 1.0f

    if-lez v3, :cond_2a

    cmpg-float v3, v4, v8

    if-gez v3, :cond_2a

    if-nez v0, :cond_2a

    .line 133
    iput v5, v6, Ld1/f;->r:I

    .line 134
    :cond_2a
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->M:I

    iget v3, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->O:I

    iget v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->Q:I

    iget v7, v7, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->S:F

    .line 135
    iput v0, v6, Ld1/f;->s:I

    .line 136
    iput v3, v6, Ld1/f;->x:I

    if-ne v4, v1, :cond_2b

    goto :goto_11

    :cond_2b
    move v2, v4

    .line 137
    :goto_11
    iput v2, v6, Ld1/f;->y:I

    .line 138
    iput v7, v6, Ld1/f;->z:F

    cmpl-float v1, v7, v9

    if-lez v1, :cond_2c

    cmpg-float v1, v7, v8

    if-gez v1, :cond_2c

    if-nez v0, :cond_2c

    .line 139
    iput v5, v6, Ld1/f;->s:I

    :cond_2c
    :goto_12
    return-void
.end method

.method public final checkLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Z
    .locals 0

    .line 1
    instance-of p1, p1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 2
    .line 3
    return p1
.end method

.method public dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 18

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    iget-object v1, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 4
    .line 5
    const/4 v2, 0x0

    .line 6
    if-eqz v1, :cond_0

    .line 7
    .line 8
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    .line 9
    .line 10
    .line 11
    move-result v3

    .line 12
    if-lez v3, :cond_0

    .line 13
    .line 14
    move v4, v2

    .line 15
    :goto_0
    if-ge v4, v3, :cond_0

    .line 16
    .line 17
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 18
    .line 19
    .line 20
    move-result-object v5

    .line 21
    check-cast v5, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 22
    .line 23
    invoke-virtual {v5, v0}, Landroidx/constraintlayout/widget/ConstraintHelper;->o(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 24
    .line 25
    .line 26
    add-int/lit8 v4, v4, 0x1

    .line 27
    .line 28
    goto :goto_0

    .line 29
    :cond_0
    invoke-super/range {p0 .. p1}, Landroid/view/ViewGroup;->dispatchDraw(Landroid/graphics/Canvas;)V

    .line 30
    .line 31
    .line 32
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->isInEditMode()Z

    .line 33
    .line 34
    .line 35
    move-result v1

    .line 36
    if-eqz v1, :cond_3

    .line 37
    .line 38
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getWidth()I

    .line 39
    .line 40
    .line 41
    move-result v1

    .line 42
    int-to-float v1, v1

    .line 43
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getHeight()I

    .line 44
    .line 45
    .line 46
    move-result v3

    .line 47
    int-to-float v3, v3

    .line 48
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 49
    .line 50
    .line 51
    move-result v4

    .line 52
    move v5, v2

    .line 53
    :goto_1
    if-ge v5, v4, :cond_3

    .line 54
    .line 55
    invoke-virtual {v0, v5}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 56
    .line 57
    .line 58
    move-result-object v6

    .line 59
    invoke-virtual {v6}, Landroid/view/View;->getVisibility()I

    .line 60
    .line 61
    .line 62
    move-result v7

    .line 63
    const/16 v8, 0x8

    .line 64
    .line 65
    if-ne v7, v8, :cond_1

    .line 66
    .line 67
    goto/16 :goto_2

    .line 68
    .line 69
    :cond_1
    invoke-virtual {v6}, Landroid/view/View;->getTag()Ljava/lang/Object;

    .line 70
    .line 71
    .line 72
    move-result-object v6

    .line 73
    if-eqz v6, :cond_2

    .line 74
    .line 75
    instance-of v7, v6, Ljava/lang/String;

    .line 76
    .line 77
    if-eqz v7, :cond_2

    .line 78
    .line 79
    check-cast v6, Ljava/lang/String;

    .line 80
    .line 81
    const-string v7, ","

    .line 82
    .line 83
    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 84
    .line 85
    .line 86
    move-result-object v6

    .line 87
    array-length v7, v6

    .line 88
    const/4 v8, 0x4

    .line 89
    if-ne v7, v8, :cond_2

    .line 90
    .line 91
    aget-object v7, v6, v2

    .line 92
    .line 93
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 94
    .line 95
    .line 96
    move-result v7

    .line 97
    const/4 v8, 0x1

    .line 98
    aget-object v8, v6, v8

    .line 99
    .line 100
    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 101
    .line 102
    .line 103
    move-result v8

    .line 104
    const/4 v9, 0x2

    .line 105
    aget-object v9, v6, v9

    .line 106
    .line 107
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 108
    .line 109
    .line 110
    move-result v9

    .line 111
    const/4 v10, 0x3

    .line 112
    aget-object v6, v6, v10

    .line 113
    .line 114
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    .line 115
    .line 116
    .line 117
    move-result v6

    .line 118
    int-to-float v7, v7

    .line 119
    const/high16 v10, 0x44870000    # 1080.0f

    .line 120
    .line 121
    div-float/2addr v7, v10

    .line 122
    mul-float/2addr v7, v1

    .line 123
    float-to-int v7, v7

    .line 124
    int-to-float v8, v8

    .line 125
    const/high16 v11, 0x44f00000    # 1920.0f

    .line 126
    .line 127
    div-float/2addr v8, v11

    .line 128
    mul-float/2addr v8, v3

    .line 129
    float-to-int v8, v8

    .line 130
    int-to-float v9, v9

    .line 131
    div-float/2addr v9, v10

    .line 132
    mul-float/2addr v9, v1

    .line 133
    float-to-int v9, v9

    .line 134
    int-to-float v6, v6

    .line 135
    div-float/2addr v6, v11

    .line 136
    mul-float/2addr v6, v3

    .line 137
    float-to-int v6, v6

    .line 138
    new-instance v15, Landroid/graphics/Paint;

    .line 139
    .line 140
    invoke-direct {v15}, Landroid/graphics/Paint;-><init>()V

    .line 141
    .line 142
    .line 143
    const/high16 v10, -0x10000

    .line 144
    .line 145
    invoke-virtual {v15, v10}, Landroid/graphics/Paint;->setColor(I)V

    .line 146
    .line 147
    .line 148
    int-to-float v14, v7

    .line 149
    int-to-float v13, v8

    .line 150
    add-int/2addr v7, v9

    .line 151
    int-to-float v7, v7

    .line 152
    move-object/from16 v10, p1

    .line 153
    .line 154
    move v11, v14

    .line 155
    move v12, v13

    .line 156
    move v9, v13

    .line 157
    move v13, v7

    .line 158
    move/from16 v16, v14

    .line 159
    .line 160
    move v14, v9

    .line 161
    move-object/from16 v17, v15

    .line 162
    .line 163
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 164
    .line 165
    .line 166
    add-int/2addr v8, v6

    .line 167
    int-to-float v6, v8

    .line 168
    move v11, v7

    .line 169
    move v12, v9

    .line 170
    move v14, v6

    .line 171
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 172
    .line 173
    .line 174
    move v12, v6

    .line 175
    move/from16 v13, v16

    .line 176
    .line 177
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 178
    .line 179
    .line 180
    move/from16 v11, v16

    .line 181
    .line 182
    move v14, v9

    .line 183
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 184
    .line 185
    .line 186
    const v8, -0xff0100

    .line 187
    .line 188
    .line 189
    invoke-virtual {v15, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 190
    .line 191
    .line 192
    move v12, v9

    .line 193
    move v13, v7

    .line 194
    move v14, v6

    .line 195
    move-object v8, v15

    .line 196
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 197
    .line 198
    .line 199
    move v12, v6

    .line 200
    move v14, v9

    .line 201
    invoke-virtual/range {v10 .. v15}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 202
    .line 203
    .line 204
    :cond_2
    :goto_2
    add-int/lit8 v5, v5, 0x1

    .line 205
    .line 206
    goto/16 :goto_1

    .line 207
    .line 208
    :cond_3
    return-void
.end method

.method public final f(I)Landroid/view/View;
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 2
    .line 3
    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object p1

    .line 7
    check-cast p1, Landroid/view/View;

    .line 8
    .line 9
    return-object p1
.end method

.method public final forceLayout()V
    .locals 1

    .line 1
    const/4 v0, 0x1

    .line 2
    iput-boolean v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 3
    .line 4
    invoke-super {p0}, Landroid/view/ViewGroup;->forceLayout()V

    .line 5
    .line 6
    .line 7
    return-void
.end method

.method public final generateDefaultLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    .locals 2

    .line 1
    new-instance v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 2
    .line 3
    const/4 v1, -0x2

    .line 4
    invoke-direct {v0, v1, v1}, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;-><init>(II)V

    .line 5
    .line 6
    .line 7
    return-object v0
.end method

.method public final generateLayoutParams(Landroid/util/AttributeSet;)Landroid/view/ViewGroup$LayoutParams;
    .locals 2

    .line 1
    new-instance v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-object v0
.end method

.method public final generateLayoutParams(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;
    .locals 1

    .line 2
    new-instance v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    invoke-direct {v0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    return-object v0
.end method

.method public getMaxHeight()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 2
    .line 3
    return v0
.end method

.method public getMaxWidth()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 2
    .line 3
    return v0
.end method

.method public getMinHeight()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 2
    .line 3
    return v0
.end method

.method public getMinWidth()I
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 2
    .line 3
    return v0
.end method

.method public getOptimizationLevel()I
    .locals 1

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 2
    .line 3
    iget v0, v0, Ld1/g;->H0:I

    .line 4
    .line 5
    return v0
.end method

.method public getSceneString()Ljava/lang/String;
    .locals 7

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 4
    .line 5
    .line 6
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 7
    .line 8
    iget-object v2, v1, Ld1/f;->j:Ljava/lang/String;

    .line 9
    .line 10
    const/4 v3, -0x1

    .line 11
    if-nez v2, :cond_1

    .line 12
    .line 13
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    .line 14
    .line 15
    .line 16
    move-result v2

    .line 17
    if-eq v2, v3, :cond_0

    .line 18
    .line 19
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 20
    .line 21
    .line 22
    move-result-object v4

    .line 23
    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 24
    .line 25
    .line 26
    move-result-object v4

    .line 27
    invoke-virtual {v4, v2}, Landroid/content/res/Resources;->getResourceEntryName(I)Ljava/lang/String;

    .line 28
    .line 29
    .line 30
    move-result-object v2

    .line 31
    iput-object v2, v1, Ld1/f;->j:Ljava/lang/String;

    .line 32
    .line 33
    goto :goto_0

    .line 34
    :cond_0
    const-string v2, "parent"

    .line 35
    .line 36
    iput-object v2, v1, Ld1/f;->j:Ljava/lang/String;

    .line 37
    .line 38
    :cond_1
    :goto_0
    iget-object v2, v1, Ld1/f;->k0:Ljava/lang/String;

    .line 39
    .line 40
    if-nez v2, :cond_2

    .line 41
    .line 42
    iget-object v2, v1, Ld1/f;->j:Ljava/lang/String;

    .line 43
    .line 44
    iput-object v2, v1, Ld1/f;->k0:Ljava/lang/String;

    .line 45
    .line 46
    :cond_2
    iget-object v2, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 47
    .line 48
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 49
    .line 50
    .line 51
    move-result-object v2

    .line 52
    :cond_3
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 53
    .line 54
    .line 55
    move-result v4

    .line 56
    if-eqz v4, :cond_5

    .line 57
    .line 58
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 59
    .line 60
    .line 61
    move-result-object v4

    .line 62
    check-cast v4, Ld1/f;

    .line 63
    .line 64
    iget-object v5, v4, Ld1/f;->h0:Landroid/view/View;

    .line 65
    .line 66
    if-eqz v5, :cond_3

    .line 67
    .line 68
    iget-object v6, v4, Ld1/f;->j:Ljava/lang/String;

    .line 69
    .line 70
    if-nez v6, :cond_4

    .line 71
    .line 72
    invoke-virtual {v5}, Landroid/view/View;->getId()I

    .line 73
    .line 74
    .line 75
    move-result v5

    .line 76
    if-eq v5, v3, :cond_4

    .line 77
    .line 78
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 79
    .line 80
    .line 81
    move-result-object v6

    .line 82
    invoke-virtual {v6}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 83
    .line 84
    .line 85
    move-result-object v6

    .line 86
    invoke-virtual {v6, v5}, Landroid/content/res/Resources;->getResourceEntryName(I)Ljava/lang/String;

    .line 87
    .line 88
    .line 89
    move-result-object v5

    .line 90
    iput-object v5, v4, Ld1/f;->j:Ljava/lang/String;

    .line 91
    .line 92
    :cond_4
    iget-object v5, v4, Ld1/f;->k0:Ljava/lang/String;

    .line 93
    .line 94
    if-nez v5, :cond_3

    .line 95
    .line 96
    iget-object v5, v4, Ld1/f;->j:Ljava/lang/String;

    .line 97
    .line 98
    iput-object v5, v4, Ld1/f;->k0:Ljava/lang/String;

    .line 99
    .line 100
    goto :goto_1

    .line 101
    :cond_5
    invoke-virtual {v1, v0}, Ld1/g;->o(Ljava/lang/StringBuilder;)V

    .line 102
    .line 103
    .line 104
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 105
    .line 106
    .line 107
    move-result-object v0

    .line 108
    return-object v0
.end method

.method public final j(Landroid/view/View;)Ld1/f;
    .locals 2

    .line 1
    if-ne p1, p0, :cond_0

    .line 2
    .line 3
    iget-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 4
    .line 5
    return-object p1

    .line 6
    :cond_0
    if-eqz p1, :cond_2

    .line 7
    .line 8
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    instance-of v0, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 13
    .line 14
    if-eqz v0, :cond_1

    .line 15
    .line 16
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 17
    .line 18
    .line 19
    move-result-object p1

    .line 20
    check-cast p1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 21
    .line 22
    iget-object p1, p1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 23
    .line 24
    return-object p1

    .line 25
    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 26
    .line 27
    .line 28
    move-result-object v0

    .line 29
    new-instance v1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 30
    .line 31
    invoke-direct {v1, v0}, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    .line 32
    .line 33
    .line 34
    invoke-virtual {p1, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 35
    .line 36
    .line 37
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 38
    .line 39
    .line 40
    move-result-object v0

    .line 41
    instance-of v0, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 42
    .line 43
    if-eqz v0, :cond_2

    .line 44
    .line 45
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 46
    .line 47
    .line 48
    move-result-object p1

    .line 49
    check-cast p1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 50
    .line 51
    iget-object p1, p1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 52
    .line 53
    return-object p1

    .line 54
    :cond_2
    const/4 p1, 0x0

    .line 55
    return-object p1
.end method

.method public final k(Landroid/util/AttributeSet;I)V
    .locals 7

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 2
    .line 3
    iput-object p0, v0, Ld1/f;->h0:Landroid/view/View;

    .line 4
    .line 5
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->o:Landroidx/constraintlayout/widget/b;

    .line 6
    .line 7
    iput-object v1, v0, Ld1/g;->y0:Le1/c;

    .line 8
    .line 9
    iget-object v2, v0, Ld1/g;->w0:Le1/f;

    .line 10
    .line 11
    iput-object v1, v2, Le1/f;->f:Le1/c;

    .line 12
    .line 13
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 14
    .line 15
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    .line 16
    .line 17
    .line 18
    move-result v2

    .line 19
    invoke-virtual {v1, v2, p0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 20
    .line 21
    .line 22
    const/4 v1, 0x0

    .line 23
    iput-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 24
    .line 25
    if-eqz p1, :cond_8

    .line 26
    .line 27
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 28
    .line 29
    .line 30
    move-result-object v2

    .line 31
    sget-object v3, Lj1/m;->c:[I

    .line 32
    .line 33
    const/4 v4, 0x0

    .line 34
    invoke-virtual {v2, p1, v3, p2, v4}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    .line 35
    .line 36
    .line 37
    move-result-object p1

    .line 38
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->getIndexCount()I

    .line 39
    .line 40
    .line 41
    move-result p2

    .line 42
    move v2, v4

    .line 43
    :goto_0
    if-ge v2, p2, :cond_7

    .line 44
    .line 45
    invoke-virtual {p1, v2}, Landroid/content/res/TypedArray;->getIndex(I)I

    .line 46
    .line 47
    .line 48
    move-result v3

    .line 49
    const/16 v5, 0x10

    .line 50
    .line 51
    if-ne v3, v5, :cond_0

    .line 52
    .line 53
    iget v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 54
    .line 55
    invoke-virtual {p1, v3, v5}, Landroid/content/res/TypedArray;->getDimensionPixelOffset(II)I

    .line 56
    .line 57
    .line 58
    move-result v3

    .line 59
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 60
    .line 61
    goto :goto_2

    .line 62
    :cond_0
    const/16 v5, 0x11

    .line 63
    .line 64
    if-ne v3, v5, :cond_1

    .line 65
    .line 66
    iget v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 67
    .line 68
    invoke-virtual {p1, v3, v5}, Landroid/content/res/TypedArray;->getDimensionPixelOffset(II)I

    .line 69
    .line 70
    .line 71
    move-result v3

    .line 72
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 73
    .line 74
    goto :goto_2

    .line 75
    :cond_1
    const/16 v5, 0xe

    .line 76
    .line 77
    if-ne v3, v5, :cond_2

    .line 78
    .line 79
    iget v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 80
    .line 81
    invoke-virtual {p1, v3, v5}, Landroid/content/res/TypedArray;->getDimensionPixelOffset(II)I

    .line 82
    .line 83
    .line 84
    move-result v3

    .line 85
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 86
    .line 87
    goto :goto_2

    .line 88
    :cond_2
    const/16 v5, 0xf

    .line 89
    .line 90
    if-ne v3, v5, :cond_3

    .line 91
    .line 92
    iget v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 93
    .line 94
    invoke-virtual {p1, v3, v5}, Landroid/content/res/TypedArray;->getDimensionPixelOffset(II)I

    .line 95
    .line 96
    .line 97
    move-result v3

    .line 98
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 99
    .line 100
    goto :goto_2

    .line 101
    :cond_3
    const/16 v5, 0x71

    .line 102
    .line 103
    if-ne v3, v5, :cond_4

    .line 104
    .line 105
    iget v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 106
    .line 107
    invoke-virtual {p1, v3, v5}, Landroid/content/res/TypedArray;->getInt(II)I

    .line 108
    .line 109
    .line 110
    move-result v3

    .line 111
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 112
    .line 113
    goto :goto_2

    .line 114
    :cond_4
    const/16 v5, 0x38

    .line 115
    .line 116
    if-ne v3, v5, :cond_5

    .line 117
    .line 118
    invoke-virtual {p1, v3, v4}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 119
    .line 120
    .line 121
    move-result v3

    .line 122
    if-eqz v3, :cond_6

    .line 123
    .line 124
    :try_start_0
    invoke-virtual {p0, v3}, Landroidx/constraintlayout/widget/ConstraintLayout;->m(I)V
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 125
    .line 126
    .line 127
    goto :goto_2

    .line 128
    :catch_0
    iput-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    .line 129
    .line 130
    goto :goto_2

    .line 131
    :cond_5
    const/16 v5, 0x22

    .line 132
    .line 133
    if-ne v3, v5, :cond_6

    .line 134
    .line 135
    invoke-virtual {p1, v3, v4}, Landroid/content/res/TypedArray;->getResourceId(II)I

    .line 136
    .line 137
    .line 138
    move-result v3

    .line 139
    :try_start_1
    new-instance v5, Landroidx/constraintlayout/widget/d;

    .line 140
    .line 141
    invoke-direct {v5}, Landroidx/constraintlayout/widget/d;-><init>()V

    .line 142
    .line 143
    .line 144
    iput-object v5, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 145
    .line 146
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 147
    .line 148
    .line 149
    move-result-object v6

    .line 150
    invoke-virtual {v5, v6, v3}, Landroidx/constraintlayout/widget/d;->m(Landroid/content/Context;I)V
    :try_end_1
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    .line 151
    .line 152
    .line 153
    goto :goto_1

    .line 154
    :catch_1
    iput-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 155
    .line 156
    :goto_1
    iput v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->l:I

    .line 157
    .line 158
    :cond_6
    :goto_2
    add-int/lit8 v2, v2, 0x1

    .line 159
    .line 160
    goto :goto_0

    .line 161
    :cond_7
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    .line 162
    .line 163
    .line 164
    :cond_8
    iget p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 165
    .line 166
    iput p1, v0, Ld1/g;->H0:I

    .line 167
    .line 168
    const/16 p1, 0x200

    .line 169
    .line 170
    invoke-virtual {v0, p1}, Ld1/g;->X(I)Z

    .line 171
    .line 172
    .line 173
    move-result p1

    .line 174
    sput-boolean p1, La1/d;->p:Z

    .line 175
    .line 176
    return-void
.end method

.method public final l()Z
    .locals 2

    .line 1
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 2
    .line 3
    .line 4
    move-result-object v0

    .line 5
    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    .line 6
    .line 7
    .line 8
    move-result-object v0

    .line 9
    iget v0, v0, Landroid/content/pm/ApplicationInfo;->flags:I

    .line 10
    .line 11
    const/high16 v1, 0x400000

    .line 12
    .line 13
    and-int/2addr v0, v1

    .line 14
    if-eqz v0, :cond_0

    .line 15
    .line 16
    invoke-virtual {p0}, Landroid/view/View;->getLayoutDirection()I

    .line 17
    .line 18
    .line 19
    move-result v0

    .line 20
    const/4 v1, 0x1

    .line 21
    if-ne v1, v0, :cond_0

    .line 22
    .line 23
    goto :goto_0

    .line 24
    :cond_0
    const/4 v1, 0x0

    .line 25
    :goto_0
    return v1
.end method

.method public m(I)V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/firebase/messaging/o;

    .line 2
    .line 3
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    .line 4
    .line 5
    .line 6
    move-result-object v1

    .line 7
    invoke-direct {v0, v1, p0, p1}, Lcom/google/firebase/messaging/o;-><init>(Landroid/content/Context;Landroidx/constraintlayout/widget/ConstraintLayout;I)V

    .line 8
    .line 9
    .line 10
    iput-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    .line 11
    .line 12
    return-void
.end method

.method public final n(IIIIZZ)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->o:Landroidx/constraintlayout/widget/b;

    .line 2
    .line 3
    iget v1, v0, Landroidx/constraintlayout/widget/b;->e:I

    .line 4
    .line 5
    iget v0, v0, Landroidx/constraintlayout/widget/b;->d:I

    .line 6
    .line 7
    add-int/2addr p3, v0

    .line 8
    add-int/2addr p4, v1

    .line 9
    const/4 v0, 0x0

    .line 10
    invoke-static {p3, p1, v0}, Landroid/view/View;->resolveSizeAndState(III)I

    .line 11
    .line 12
    .line 13
    move-result p1

    .line 14
    invoke-static {p4, p2, v0}, Landroid/view/View;->resolveSizeAndState(III)I

    .line 15
    .line 16
    .line 17
    move-result p2

    .line 18
    const p3, 0xffffff

    .line 19
    .line 20
    .line 21
    and-int/2addr p1, p3

    .line 22
    and-int/2addr p2, p3

    .line 23
    iget p3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 24
    .line 25
    invoke-static {p3, p1}, Ljava/lang/Math;->min(II)I

    .line 26
    .line 27
    .line 28
    move-result p1

    .line 29
    iget p3, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 30
    .line 31
    invoke-static {p3, p2}, Ljava/lang/Math;->min(II)I

    .line 32
    .line 33
    .line 34
    move-result p2

    .line 35
    const/high16 p3, 0x1000000

    .line 36
    .line 37
    if-eqz p5, :cond_0

    .line 38
    .line 39
    or-int/2addr p1, p3

    .line 40
    :cond_0
    if-eqz p6, :cond_1

    .line 41
    .line 42
    or-int/2addr p2, p3

    .line 43
    :cond_1
    invoke-virtual {p0, p1, p2}, Landroid/view/View;->setMeasuredDimension(II)V

    .line 44
    .line 45
    .line 46
    return-void
.end method

.method public final o(Ld1/g;III)V
    .locals 23

    .line 1
    move-object/from16 v0, p0

    .line 2
    .line 3
    move-object/from16 v1, p1

    .line 4
    .line 5
    move/from16 v2, p2

    .line 6
    .line 7
    invoke-static/range {p3 .. p3}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 8
    .line 9
    .line 10
    move-result v3

    .line 11
    invoke-static/range {p3 .. p3}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 12
    .line 13
    .line 14
    move-result v4

    .line 15
    invoke-static/range {p4 .. p4}, Landroid/view/View$MeasureSpec;->getMode(I)I

    .line 16
    .line 17
    .line 18
    move-result v5

    .line 19
    invoke-static/range {p4 .. p4}, Landroid/view/View$MeasureSpec;->getSize(I)I

    .line 20
    .line 21
    .line 22
    move-result v6

    .line 23
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingTop()I

    .line 24
    .line 25
    .line 26
    move-result v7

    .line 27
    const/4 v8, 0x0

    .line 28
    invoke-static {v8, v7}, Ljava/lang/Math;->max(II)I

    .line 29
    .line 30
    .line 31
    move-result v7

    .line 32
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingBottom()I

    .line 33
    .line 34
    .line 35
    move-result v9

    .line 36
    invoke-static {v8, v9}, Ljava/lang/Math;->max(II)I

    .line 37
    .line 38
    .line 39
    move-result v9

    .line 40
    add-int v10, v7, v9

    .line 41
    .line 42
    invoke-direct/range {p0 .. p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->getPaddingWidth()I

    .line 43
    .line 44
    .line 45
    move-result v11

    .line 46
    iget-object v12, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->o:Landroidx/constraintlayout/widget/b;

    .line 47
    .line 48
    iput v7, v12, Landroidx/constraintlayout/widget/b;->b:I

    .line 49
    .line 50
    iput v9, v12, Landroidx/constraintlayout/widget/b;->c:I

    .line 51
    .line 52
    iput v11, v12, Landroidx/constraintlayout/widget/b;->d:I

    .line 53
    .line 54
    iput v10, v12, Landroidx/constraintlayout/widget/b;->e:I

    .line 55
    .line 56
    move/from16 v9, p3

    .line 57
    .line 58
    iput v9, v12, Landroidx/constraintlayout/widget/b;->f:I

    .line 59
    .line 60
    move/from16 v9, p4

    .line 61
    .line 62
    iput v9, v12, Landroidx/constraintlayout/widget/b;->g:I

    .line 63
    .line 64
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingStart()I

    .line 65
    .line 66
    .line 67
    move-result v9

    .line 68
    invoke-static {v8, v9}, Ljava/lang/Math;->max(II)I

    .line 69
    .line 70
    .line 71
    move-result v9

    .line 72
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingEnd()I

    .line 73
    .line 74
    .line 75
    move-result v13

    .line 76
    invoke-static {v8, v13}, Ljava/lang/Math;->max(II)I

    .line 77
    .line 78
    .line 79
    move-result v13

    .line 80
    if-gtz v9, :cond_1

    .line 81
    .line 82
    if-lez v13, :cond_0

    .line 83
    .line 84
    goto :goto_0

    .line 85
    :cond_0
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getPaddingLeft()I

    .line 86
    .line 87
    .line 88
    move-result v9

    .line 89
    invoke-static {v8, v9}, Ljava/lang/Math;->max(II)I

    .line 90
    .line 91
    .line 92
    move-result v9

    .line 93
    goto :goto_1

    .line 94
    :cond_1
    :goto_0
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->l()Z

    .line 95
    .line 96
    .line 97
    move-result v14

    .line 98
    if-eqz v14, :cond_2

    .line 99
    .line 100
    move v9, v13

    .line 101
    :cond_2
    :goto_1
    sub-int/2addr v4, v11

    .line 102
    sub-int/2addr v6, v10

    .line 103
    iget v10, v12, Landroidx/constraintlayout/widget/b;->e:I

    .line 104
    .line 105
    iget v11, v12, Landroidx/constraintlayout/widget/b;->d:I

    .line 106
    .line 107
    sget-object v12, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 108
    .line 109
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 110
    .line 111
    .line 112
    move-result v13

    .line 113
    const/high16 v14, 0x40000000    # 2.0f

    .line 114
    .line 115
    const/high16 v15, -0x80000000

    .line 116
    .line 117
    if-eq v3, v15, :cond_6

    .line 118
    .line 119
    if-eqz v3, :cond_4

    .line 120
    .line 121
    if-eq v3, v14, :cond_3

    .line 122
    .line 123
    move v14, v8

    .line 124
    :goto_2
    move v8, v15

    .line 125
    move-object v15, v12

    .line 126
    goto :goto_4

    .line 127
    :cond_3
    iget v14, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 128
    .line 129
    sub-int/2addr v14, v11

    .line 130
    invoke-static {v14, v4}, Ljava/lang/Math;->min(II)I

    .line 131
    .line 132
    .line 133
    move-result v14

    .line 134
    goto :goto_2

    .line 135
    :cond_4
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 136
    .line 137
    if-nez v13, :cond_5

    .line 138
    .line 139
    iget v15, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 140
    .line 141
    invoke-static {v8, v15}, Ljava/lang/Math;->max(II)I

    .line 142
    .line 143
    .line 144
    move-result v15

    .line 145
    :goto_3
    const/high16 v8, -0x80000000

    .line 146
    .line 147
    move/from16 v22, v15

    .line 148
    .line 149
    move-object v15, v14

    .line 150
    move/from16 v14, v22

    .line 151
    .line 152
    goto :goto_4

    .line 153
    :cond_5
    move-object/from16 v22, v14

    .line 154
    .line 155
    move v14, v8

    .line 156
    move v8, v15

    .line 157
    move-object/from16 v15, v22

    .line 158
    .line 159
    goto :goto_4

    .line 160
    :cond_6
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 161
    .line 162
    if-nez v13, :cond_7

    .line 163
    .line 164
    iget v15, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 165
    .line 166
    invoke-static {v8, v15}, Ljava/lang/Math;->max(II)I

    .line 167
    .line 168
    .line 169
    move-result v15

    .line 170
    goto :goto_3

    .line 171
    :cond_7
    move-object v15, v14

    .line 172
    const/high16 v8, -0x80000000

    .line 173
    .line 174
    move v14, v4

    .line 175
    :goto_4
    if-eq v5, v8, :cond_b

    .line 176
    .line 177
    if-eqz v5, :cond_a

    .line 178
    .line 179
    const/high16 v8, 0x40000000    # 2.0f

    .line 180
    .line 181
    if-eq v5, v8, :cond_9

    .line 182
    .line 183
    :cond_8
    const/4 v13, 0x0

    .line 184
    goto :goto_5

    .line 185
    :cond_9
    iget v8, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 186
    .line 187
    sub-int/2addr v8, v10

    .line 188
    invoke-static {v8, v6}, Ljava/lang/Math;->min(II)I

    .line 189
    .line 190
    .line 191
    move-result v8

    .line 192
    move v13, v8

    .line 193
    goto :goto_5

    .line 194
    :cond_a
    sget-object v12, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 195
    .line 196
    if-nez v13, :cond_8

    .line 197
    .line 198
    iget v8, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 199
    .line 200
    const/4 v13, 0x0

    .line 201
    invoke-static {v13, v8}, Ljava/lang/Math;->max(II)I

    .line 202
    .line 203
    .line 204
    move-result v16

    .line 205
    move/from16 v13, v16

    .line 206
    .line 207
    goto :goto_5

    .line 208
    :cond_b
    const/4 v8, 0x0

    .line 209
    sget-object v12, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 210
    .line 211
    if-nez v13, :cond_c

    .line 212
    .line 213
    iget v13, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 214
    .line 215
    invoke-static {v8, v13}, Ljava/lang/Math;->max(II)I

    .line 216
    .line 217
    .line 218
    move-result v13

    .line 219
    goto :goto_5

    .line 220
    :cond_c
    move v13, v6

    .line 221
    :goto_5
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 222
    .line 223
    .line 224
    move-result v8

    .line 225
    move/from16 p4, v6

    .line 226
    .line 227
    iget-object v6, v1, Ld1/g;->w0:Le1/f;

    .line 228
    .line 229
    move/from16 v17, v4

    .line 230
    .line 231
    const/4 v4, 0x1

    .line 232
    if-ne v14, v8, :cond_e

    .line 233
    .line 234
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 235
    .line 236
    .line 237
    move-result v8

    .line 238
    if-eq v13, v8, :cond_d

    .line 239
    .line 240
    goto :goto_7

    .line 241
    :cond_d
    :goto_6
    const/4 v8, 0x0

    .line 242
    goto :goto_8

    .line 243
    :cond_e
    :goto_7
    iput-boolean v4, v6, Le1/f;->c:Z

    .line 244
    .line 245
    goto :goto_6

    .line 246
    :goto_8
    iput v8, v1, Ld1/f;->a0:I

    .line 247
    .line 248
    iput v8, v1, Ld1/f;->b0:I

    .line 249
    .line 250
    iget v4, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 251
    .line 252
    sub-int/2addr v4, v11

    .line 253
    move-object/from16 v19, v6

    .line 254
    .line 255
    iget-object v6, v1, Ld1/f;->C:[I

    .line 256
    .line 257
    aput v4, v6, v8

    .line 258
    .line 259
    iget v4, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 260
    .line 261
    sub-int/2addr v4, v10

    .line 262
    const/16 v16, 0x1

    .line 263
    .line 264
    aput v4, v6, v16

    .line 265
    .line 266
    iput v8, v1, Ld1/f;->d0:I

    .line 267
    .line 268
    iput v8, v1, Ld1/f;->e0:I

    .line 269
    .line 270
    invoke-virtual {v1, v15}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 271
    .line 272
    .line 273
    invoke-virtual {v1, v14}, Ld1/f;->P(I)V

    .line 274
    .line 275
    .line 276
    invoke-virtual {v1, v12}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 277
    .line 278
    .line 279
    invoke-virtual {v1, v13}, Ld1/f;->M(I)V

    .line 280
    .line 281
    .line 282
    iget v4, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 283
    .line 284
    sub-int/2addr v4, v11

    .line 285
    if-gez v4, :cond_f

    .line 286
    .line 287
    iput v8, v1, Ld1/f;->d0:I

    .line 288
    .line 289
    goto :goto_9

    .line 290
    :cond_f
    iput v4, v1, Ld1/f;->d0:I

    .line 291
    .line 292
    :goto_9
    iget v4, v0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 293
    .line 294
    sub-int/2addr v4, v10

    .line 295
    if-gez v4, :cond_10

    .line 296
    .line 297
    iput v8, v1, Ld1/f;->e0:I

    .line 298
    .line 299
    goto :goto_a

    .line 300
    :cond_10
    iput v4, v1, Ld1/f;->e0:I

    .line 301
    .line 302
    :goto_a
    iput v9, v1, Ld1/g;->B0:I

    .line 303
    .line 304
    iput v7, v1, Ld1/g;->C0:I

    .line 305
    .line 306
    iget-object v4, v1, Ld1/g;->v0:Landroidx/work/impl/model/v;

    .line 307
    .line 308
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 309
    .line 310
    .line 311
    iget-object v6, v1, Ld1/g;->y0:Le1/c;

    .line 312
    .line 313
    iget-object v7, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 314
    .line 315
    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    .line 316
    .line 317
    .line 318
    move-result v7

    .line 319
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 320
    .line 321
    .line 322
    move-result v8

    .line 323
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 324
    .line 325
    .line 326
    move-result v9

    .line 327
    const/16 v10, 0x80

    .line 328
    .line 329
    invoke-static {v2, v10}, Ld1/m;->c(II)Z

    .line 330
    .line 331
    .line 332
    move-result v10

    .line 333
    const/16 v11, 0x40

    .line 334
    .line 335
    if-nez v10, :cond_12

    .line 336
    .line 337
    invoke-static {v2, v11}, Ld1/m;->c(II)Z

    .line 338
    .line 339
    .line 340
    move-result v2

    .line 341
    if-eqz v2, :cond_11

    .line 342
    .line 343
    goto :goto_b

    .line 344
    :cond_11
    const/4 v2, 0x0

    .line 345
    goto :goto_c

    .line 346
    :cond_12
    :goto_b
    const/4 v2, 0x1

    .line 347
    :goto_c
    if-eqz v2, :cond_17

    .line 348
    .line 349
    const/4 v13, 0x0

    .line 350
    :goto_d
    if-ge v13, v7, :cond_17

    .line 351
    .line 352
    iget-object v14, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 353
    .line 354
    invoke-virtual {v14, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 355
    .line 356
    .line 357
    move-result-object v14

    .line 358
    check-cast v14, Ld1/f;

    .line 359
    .line 360
    iget-object v15, v14, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 361
    .line 362
    const/16 v16, 0x0

    .line 363
    .line 364
    aget-object v11, v15, v16

    .line 365
    .line 366
    sget-object v12, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 367
    .line 368
    if-ne v11, v12, :cond_13

    .line 369
    .line 370
    const/4 v11, 0x1

    .line 371
    :goto_e
    const/16 v18, 0x1

    .line 372
    .line 373
    goto :goto_f

    .line 374
    :cond_13
    const/4 v11, 0x0

    .line 375
    goto :goto_e

    .line 376
    :goto_f
    aget-object v15, v15, v18

    .line 377
    .line 378
    if-ne v15, v12, :cond_14

    .line 379
    .line 380
    const/4 v12, 0x1

    .line 381
    goto :goto_10

    .line 382
    :cond_14
    const/4 v12, 0x0

    .line 383
    :goto_10
    if-eqz v11, :cond_15

    .line 384
    .line 385
    if-eqz v12, :cond_15

    .line 386
    .line 387
    iget v11, v14, Ld1/f;->Y:F

    .line 388
    .line 389
    const/4 v12, 0x0

    .line 390
    cmpl-float v11, v11, v12

    .line 391
    .line 392
    if-lez v11, :cond_15

    .line 393
    .line 394
    const/4 v11, 0x1

    .line 395
    goto :goto_11

    .line 396
    :cond_15
    const/4 v11, 0x0

    .line 397
    :goto_11
    invoke-virtual {v14}, Ld1/f;->y()Z

    .line 398
    .line 399
    .line 400
    move-result v12

    .line 401
    if-eqz v12, :cond_18

    .line 402
    .line 403
    if-eqz v11, :cond_18

    .line 404
    .line 405
    :cond_16
    :goto_12
    const/4 v2, 0x0

    .line 406
    :cond_17
    const/high16 v11, 0x40000000    # 2.0f

    .line 407
    .line 408
    goto :goto_13

    .line 409
    :cond_18
    invoke-virtual {v14}, Ld1/f;->z()Z

    .line 410
    .line 411
    .line 412
    move-result v12

    .line 413
    if-eqz v12, :cond_19

    .line 414
    .line 415
    if-eqz v11, :cond_19

    .line 416
    .line 417
    goto :goto_12

    .line 418
    :cond_19
    instance-of v11, v14, Ld1/o;

    .line 419
    .line 420
    if-eqz v11, :cond_1a

    .line 421
    .line 422
    goto :goto_12

    .line 423
    :cond_1a
    invoke-virtual {v14}, Ld1/f;->y()Z

    .line 424
    .line 425
    .line 426
    move-result v11

    .line 427
    if-nez v11, :cond_16

    .line 428
    .line 429
    invoke-virtual {v14}, Ld1/f;->z()Z

    .line 430
    .line 431
    .line 432
    move-result v11

    .line 433
    if-eqz v11, :cond_1b

    .line 434
    .line 435
    goto :goto_12

    .line 436
    :cond_1b
    add-int/lit8 v13, v13, 0x1

    .line 437
    .line 438
    const/16 v11, 0x40

    .line 439
    .line 440
    goto :goto_d

    .line 441
    :goto_13
    if-ne v3, v11, :cond_1c

    .line 442
    .line 443
    if-eq v5, v11, :cond_1d

    .line 444
    .line 445
    :cond_1c
    if-eqz v10, :cond_1e

    .line 446
    .line 447
    :cond_1d
    const/4 v11, 0x1

    .line 448
    goto :goto_14

    .line 449
    :cond_1e
    const/4 v11, 0x0

    .line 450
    :goto_14
    and-int/2addr v2, v11

    .line 451
    if-eqz v2, :cond_3d

    .line 452
    .line 453
    iget-object v12, v1, Ld1/f;->C:[I

    .line 454
    .line 455
    const/4 v13, 0x0

    .line 456
    aget v12, v12, v13

    .line 457
    .line 458
    move/from16 v13, v17

    .line 459
    .line 460
    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    .line 461
    .line 462
    .line 463
    move-result v12

    .line 464
    iget-object v13, v1, Ld1/f;->C:[I

    .line 465
    .line 466
    const/4 v14, 0x1

    .line 467
    aget v13, v13, v14

    .line 468
    .line 469
    move/from16 v15, p4

    .line 470
    .line 471
    invoke-static {v13, v15}, Ljava/lang/Math;->min(II)I

    .line 472
    .line 473
    .line 474
    move-result v13

    .line 475
    const/high16 v15, 0x40000000    # 2.0f

    .line 476
    .line 477
    if-ne v3, v15, :cond_1f

    .line 478
    .line 479
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 480
    .line 481
    .line 482
    move-result v11

    .line 483
    if-eq v11, v12, :cond_1f

    .line 484
    .line 485
    invoke-virtual {v1, v12}, Ld1/f;->P(I)V

    .line 486
    .line 487
    .line 488
    iget-object v11, v1, Ld1/g;->w0:Le1/f;

    .line 489
    .line 490
    iput-boolean v14, v11, Le1/f;->b:Z

    .line 491
    .line 492
    :cond_1f
    if-ne v5, v15, :cond_20

    .line 493
    .line 494
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 495
    .line 496
    .line 497
    move-result v11

    .line 498
    if-eq v11, v13, :cond_20

    .line 499
    .line 500
    invoke-virtual {v1, v13}, Ld1/f;->M(I)V

    .line 501
    .line 502
    .line 503
    iget-object v11, v1, Ld1/g;->w0:Le1/f;

    .line 504
    .line 505
    iput-boolean v14, v11, Le1/f;->b:Z

    .line 506
    .line 507
    :cond_20
    if-ne v3, v15, :cond_36

    .line 508
    .line 509
    if-ne v5, v15, :cond_36

    .line 510
    .line 511
    move-object/from16 v11, v19

    .line 512
    .line 513
    iget-boolean v12, v11, Le1/f;->b:Z

    .line 514
    .line 515
    iget-object v13, v11, Le1/f;->a:Ld1/g;

    .line 516
    .line 517
    if-nez v12, :cond_22

    .line 518
    .line 519
    iget-boolean v12, v11, Le1/f;->c:Z

    .line 520
    .line 521
    if-eqz v12, :cond_21

    .line 522
    .line 523
    goto :goto_15

    .line 524
    :cond_21
    const/4 v12, 0x0

    .line 525
    goto :goto_17

    .line 526
    :cond_22
    :goto_15
    iget-object v12, v13, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 527
    .line 528
    invoke-virtual {v12}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 529
    .line 530
    .line 531
    move-result-object v12

    .line 532
    :goto_16
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    .line 533
    .line 534
    .line 535
    move-result v14

    .line 536
    if-eqz v14, :cond_23

    .line 537
    .line 538
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 539
    .line 540
    .line 541
    move-result-object v14

    .line 542
    check-cast v14, Ld1/f;

    .line 543
    .line 544
    invoke-virtual {v14}, Ld1/f;->i()V

    .line 545
    .line 546
    .line 547
    const/4 v15, 0x0

    .line 548
    iput-boolean v15, v14, Ld1/f;->a:Z

    .line 549
    .line 550
    iget-object v15, v14, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 551
    .line 552
    invoke-virtual {v15}, Landroidx/constraintlayout/core/widgets/analyzer/e;->n()V

    .line 553
    .line 554
    .line 555
    iget-object v14, v14, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 556
    .line 557
    invoke-virtual {v14}, Landroidx/constraintlayout/core/widgets/analyzer/g;->m()V

    .line 558
    .line 559
    .line 560
    goto :goto_16

    .line 561
    :cond_23
    invoke-virtual {v13}, Ld1/f;->i()V

    .line 562
    .line 563
    .line 564
    const/4 v12, 0x0

    .line 565
    iput-boolean v12, v13, Ld1/f;->a:Z

    .line 566
    .line 567
    iget-object v14, v13, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 568
    .line 569
    invoke-virtual {v14}, Landroidx/constraintlayout/core/widgets/analyzer/e;->n()V

    .line 570
    .line 571
    .line 572
    iget-object v14, v13, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 573
    .line 574
    invoke-virtual {v14}, Landroidx/constraintlayout/core/widgets/analyzer/g;->m()V

    .line 575
    .line 576
    .line 577
    iput-boolean v12, v11, Le1/f;->c:Z

    .line 578
    .line 579
    :goto_17
    iget-object v14, v11, Le1/f;->d:Ld1/g;

    .line 580
    .line 581
    invoke-virtual {v11, v14}, Le1/f;->b(Ld1/g;)V

    .line 582
    .line 583
    .line 584
    iput v12, v13, Ld1/f;->a0:I

    .line 585
    .line 586
    iput v12, v13, Ld1/f;->b0:I

    .line 587
    .line 588
    invoke-virtual {v13, v12}, Ld1/f;->k(I)Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 589
    .line 590
    .line 591
    move-result-object v14

    .line 592
    const/4 v12, 0x1

    .line 593
    invoke-virtual {v13, v12}, Ld1/f;->k(I)Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 594
    .line 595
    .line 596
    move-result-object v15

    .line 597
    iget-boolean v12, v11, Le1/f;->b:Z

    .line 598
    .line 599
    if-eqz v12, :cond_24

    .line 600
    .line 601
    invoke-virtual {v11}, Le1/f;->c()V

    .line 602
    .line 603
    .line 604
    :cond_24
    invoke-virtual {v13}, Ld1/f;->s()I

    .line 605
    .line 606
    .line 607
    move-result v12

    .line 608
    invoke-virtual {v13}, Ld1/f;->t()I

    .line 609
    .line 610
    .line 611
    move-result v0

    .line 612
    move/from16 v17, v2

    .line 613
    .line 614
    iget-object v2, v13, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 615
    .line 616
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 617
    .line 618
    invoke-virtual {v2, v12}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 619
    .line 620
    .line 621
    iget-object v2, v13, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 622
    .line 623
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 624
    .line 625
    invoke-virtual {v2, v0}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 626
    .line 627
    .line 628
    invoke-virtual {v11}, Le1/f;->g()V

    .line 629
    .line 630
    .line 631
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 632
    .line 633
    move-object/from16 v19, v6

    .line 634
    .line 635
    iget-object v6, v11, Le1/f;->e:Ljava/util/ArrayList;

    .line 636
    .line 637
    if-eq v14, v2, :cond_26

    .line 638
    .line 639
    if-ne v15, v2, :cond_25

    .line 640
    .line 641
    goto :goto_18

    .line 642
    :cond_25
    move/from16 v21, v8

    .line 643
    .line 644
    goto :goto_1a

    .line 645
    :cond_26
    :goto_18
    if-eqz v10, :cond_28

    .line 646
    .line 647
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 648
    .line 649
    .line 650
    move-result-object v2

    .line 651
    :cond_27
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 652
    .line 653
    .line 654
    move-result v21

    .line 655
    if-eqz v21, :cond_28

    .line 656
    .line 657
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 658
    .line 659
    .line 660
    move-result-object v21

    .line 661
    check-cast v21, Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 662
    .line 663
    invoke-virtual/range {v21 .. v21}, Landroidx/constraintlayout/core/widgets/analyzer/h;->k()Z

    .line 664
    .line 665
    .line 666
    move-result v21

    .line 667
    if-nez v21, :cond_27

    .line 668
    .line 669
    const/4 v10, 0x0

    .line 670
    :cond_28
    if-eqz v10, :cond_29

    .line 671
    .line 672
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 673
    .line 674
    if-ne v14, v2, :cond_29

    .line 675
    .line 676
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 677
    .line 678
    invoke-virtual {v13, v2}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 679
    .line 680
    .line 681
    move/from16 v21, v8

    .line 682
    .line 683
    const/4 v2, 0x0

    .line 684
    invoke-virtual {v11, v13, v2}, Le1/f;->d(Ld1/g;I)I

    .line 685
    .line 686
    .line 687
    move-result v8

    .line 688
    invoke-virtual {v13, v8}, Ld1/f;->P(I)V

    .line 689
    .line 690
    .line 691
    iget-object v2, v13, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 692
    .line 693
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 694
    .line 695
    invoke-virtual {v13}, Ld1/f;->r()I

    .line 696
    .line 697
    .line 698
    move-result v8

    .line 699
    invoke-virtual {v2, v8}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 700
    .line 701
    .line 702
    goto :goto_19

    .line 703
    :cond_29
    move/from16 v21, v8

    .line 704
    .line 705
    :goto_19
    if-eqz v10, :cond_2a

    .line 706
    .line 707
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 708
    .line 709
    if-ne v15, v2, :cond_2a

    .line 710
    .line 711
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 712
    .line 713
    invoke-virtual {v13, v2}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 714
    .line 715
    .line 716
    const/4 v2, 0x1

    .line 717
    invoke-virtual {v11, v13, v2}, Le1/f;->d(Ld1/g;I)I

    .line 718
    .line 719
    .line 720
    move-result v8

    .line 721
    invoke-virtual {v13, v8}, Ld1/f;->M(I)V

    .line 722
    .line 723
    .line 724
    iget-object v2, v13, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 725
    .line 726
    iget-object v2, v2, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 727
    .line 728
    invoke-virtual {v13}, Ld1/f;->l()I

    .line 729
    .line 730
    .line 731
    move-result v8

    .line 732
    invoke-virtual {v2, v8}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 733
    .line 734
    .line 735
    :cond_2a
    :goto_1a
    iget-object v2, v13, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 736
    .line 737
    const/4 v8, 0x0

    .line 738
    aget-object v2, v2, v8

    .line 739
    .line 740
    sget-object v8, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 741
    .line 742
    if-eq v2, v8, :cond_2c

    .line 743
    .line 744
    sget-object v10, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 745
    .line 746
    if-ne v2, v10, :cond_2b

    .line 747
    .line 748
    goto :goto_1b

    .line 749
    :cond_2b
    const/4 v0, 0x0

    .line 750
    goto :goto_1c

    .line 751
    :cond_2c
    :goto_1b
    invoke-virtual {v13}, Ld1/f;->r()I

    .line 752
    .line 753
    .line 754
    move-result v2

    .line 755
    add-int/2addr v2, v12

    .line 756
    iget-object v10, v13, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 757
    .line 758
    iget-object v10, v10, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 759
    .line 760
    invoke-virtual {v10, v2}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 761
    .line 762
    .line 763
    iget-object v10, v13, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 764
    .line 765
    iget-object v10, v10, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 766
    .line 767
    sub-int/2addr v2, v12

    .line 768
    invoke-virtual {v10, v2}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 769
    .line 770
    .line 771
    invoke-virtual {v11}, Le1/f;->g()V

    .line 772
    .line 773
    .line 774
    iget-object v2, v13, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 775
    .line 776
    const/4 v10, 0x1

    .line 777
    aget-object v2, v2, v10

    .line 778
    .line 779
    if-eq v2, v8, :cond_2d

    .line 780
    .line 781
    sget-object v8, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 782
    .line 783
    if-ne v2, v8, :cond_2e

    .line 784
    .line 785
    :cond_2d
    invoke-virtual {v13}, Ld1/f;->l()I

    .line 786
    .line 787
    .line 788
    move-result v2

    .line 789
    add-int/2addr v2, v0

    .line 790
    iget-object v8, v13, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 791
    .line 792
    iget-object v8, v8, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 793
    .line 794
    invoke-virtual {v8, v2}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 795
    .line 796
    .line 797
    iget-object v8, v13, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 798
    .line 799
    iget-object v8, v8, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 800
    .line 801
    sub-int/2addr v2, v0

    .line 802
    invoke-virtual {v8, v2}, Landroidx/constraintlayout/core/widgets/analyzer/b;->d(I)V

    .line 803
    .line 804
    .line 805
    :cond_2e
    invoke-virtual {v11}, Le1/f;->g()V

    .line 806
    .line 807
    .line 808
    const/4 v0, 0x1

    .line 809
    :goto_1c
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 810
    .line 811
    .line 812
    move-result-object v2

    .line 813
    :goto_1d
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 814
    .line 815
    .line 816
    move-result v8

    .line 817
    if-eqz v8, :cond_30

    .line 818
    .line 819
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 820
    .line 821
    .line 822
    move-result-object v8

    .line 823
    check-cast v8, Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 824
    .line 825
    iget-object v10, v8, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 826
    .line 827
    if-ne v10, v13, :cond_2f

    .line 828
    .line 829
    iget-boolean v10, v8, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 830
    .line 831
    if-nez v10, :cond_2f

    .line 832
    .line 833
    goto :goto_1d

    .line 834
    :cond_2f
    invoke-virtual {v8}, Landroidx/constraintlayout/core/widgets/analyzer/h;->e()V

    .line 835
    .line 836
    .line 837
    goto :goto_1d

    .line 838
    :cond_30
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 839
    .line 840
    .line 841
    move-result-object v2

    .line 842
    :cond_31
    :goto_1e
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 843
    .line 844
    .line 845
    move-result v6

    .line 846
    if-eqz v6, :cond_35

    .line 847
    .line 848
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 849
    .line 850
    .line 851
    move-result-object v6

    .line 852
    check-cast v6, Landroidx/constraintlayout/core/widgets/analyzer/h;

    .line 853
    .line 854
    if-nez v0, :cond_32

    .line 855
    .line 856
    iget-object v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->b:Ld1/f;

    .line 857
    .line 858
    if-ne v8, v13, :cond_32

    .line 859
    .line 860
    goto :goto_1e

    .line 861
    :cond_32
    iget-object v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 862
    .line 863
    iget-boolean v8, v8, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 864
    .line 865
    if-nez v8, :cond_33

    .line 866
    .line 867
    :goto_1f
    const/4 v0, 0x0

    .line 868
    goto :goto_20

    .line 869
    :cond_33
    iget-object v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->i:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 870
    .line 871
    iget-boolean v8, v8, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 872
    .line 873
    if-nez v8, :cond_34

    .line 874
    .line 875
    instance-of v8, v6, Le1/h;

    .line 876
    .line 877
    if-nez v8, :cond_34

    .line 878
    .line 879
    goto :goto_1f

    .line 880
    :cond_34
    iget-object v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 881
    .line 882
    iget-boolean v8, v8, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 883
    .line 884
    if-nez v8, :cond_31

    .line 885
    .line 886
    instance-of v8, v6, Le1/d;

    .line 887
    .line 888
    if-nez v8, :cond_31

    .line 889
    .line 890
    instance-of v6, v6, Le1/h;

    .line 891
    .line 892
    if-nez v6, :cond_31

    .line 893
    .line 894
    goto :goto_1f

    .line 895
    :cond_35
    const/4 v0, 0x1

    .line 896
    :goto_20
    invoke-virtual {v13, v14}, Ld1/f;->N(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 897
    .line 898
    .line 899
    invoke-virtual {v13, v15}, Ld1/f;->O(Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;)V

    .line 900
    .line 901
    .line 902
    move v6, v0

    .line 903
    const/high16 v0, 0x40000000    # 2.0f

    .line 904
    .line 905
    const/4 v2, 0x2

    .line 906
    goto/16 :goto_24

    .line 907
    .line 908
    :cond_36
    move/from16 v17, v2

    .line 909
    .line 910
    move/from16 v21, v8

    .line 911
    .line 912
    move-object/from16 v11, v19

    .line 913
    .line 914
    move-object/from16 v19, v6

    .line 915
    .line 916
    iget-boolean v0, v11, Le1/f;->b:Z

    .line 917
    .line 918
    iget-object v2, v11, Le1/f;->a:Ld1/g;

    .line 919
    .line 920
    if-eqz v0, :cond_38

    .line 921
    .line 922
    iget-object v0, v2, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 923
    .line 924
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 925
    .line 926
    .line 927
    move-result-object v0

    .line 928
    :goto_21
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 929
    .line 930
    .line 931
    move-result v6

    .line 932
    if-eqz v6, :cond_37

    .line 933
    .line 934
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 935
    .line 936
    .line 937
    move-result-object v6

    .line 938
    check-cast v6, Ld1/f;

    .line 939
    .line 940
    invoke-virtual {v6}, Ld1/f;->i()V

    .line 941
    .line 942
    .line 943
    const/4 v8, 0x0

    .line 944
    iput-boolean v8, v6, Ld1/f;->a:Z

    .line 945
    .line 946
    iget-object v12, v6, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 947
    .line 948
    iget-object v13, v12, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 949
    .line 950
    iput-boolean v8, v13, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 951
    .line 952
    iput-boolean v8, v12, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 953
    .line 954
    invoke-virtual {v12}, Landroidx/constraintlayout/core/widgets/analyzer/e;->n()V

    .line 955
    .line 956
    .line 957
    iget-object v6, v6, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 958
    .line 959
    iget-object v12, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 960
    .line 961
    iput-boolean v8, v12, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 962
    .line 963
    iput-boolean v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 964
    .line 965
    invoke-virtual {v6}, Landroidx/constraintlayout/core/widgets/analyzer/g;->m()V

    .line 966
    .line 967
    .line 968
    goto :goto_21

    .line 969
    :cond_37
    const/4 v8, 0x0

    .line 970
    invoke-virtual {v2}, Ld1/f;->i()V

    .line 971
    .line 972
    .line 973
    iput-boolean v8, v2, Ld1/f;->a:Z

    .line 974
    .line 975
    iget-object v0, v2, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 976
    .line 977
    iget-object v6, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 978
    .line 979
    iput-boolean v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 980
    .line 981
    iput-boolean v8, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 982
    .line 983
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/e;->n()V

    .line 984
    .line 985
    .line 986
    iget-object v0, v2, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 987
    .line 988
    iget-object v6, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 989
    .line 990
    iput-boolean v8, v6, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 991
    .line 992
    iput-boolean v8, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->g:Z

    .line 993
    .line 994
    invoke-virtual {v0}, Landroidx/constraintlayout/core/widgets/analyzer/g;->m()V

    .line 995
    .line 996
    .line 997
    invoke-virtual {v11}, Le1/f;->c()V

    .line 998
    .line 999
    .line 1000
    goto :goto_22

    .line 1001
    :cond_38
    const/4 v8, 0x0

    .line 1002
    :goto_22
    iget-object v0, v11, Le1/f;->d:Ld1/g;

    .line 1003
    .line 1004
    invoke-virtual {v11, v0}, Le1/f;->b(Ld1/g;)V

    .line 1005
    .line 1006
    .line 1007
    iput v8, v2, Ld1/f;->a0:I

    .line 1008
    .line 1009
    iput v8, v2, Ld1/f;->b0:I

    .line 1010
    .line 1011
    iget-object v0, v2, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 1012
    .line 1013
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 1014
    .line 1015
    invoke-virtual {v0, v8}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 1016
    .line 1017
    .line 1018
    iget-object v0, v2, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 1019
    .line 1020
    iget-object v0, v0, Landroidx/constraintlayout/core/widgets/analyzer/h;->h:Landroidx/constraintlayout/core/widgets/analyzer/a;

    .line 1021
    .line 1022
    invoke-virtual {v0, v8}, Landroidx/constraintlayout/core/widgets/analyzer/a;->d(I)V

    .line 1023
    .line 1024
    .line 1025
    const/high16 v0, 0x40000000    # 2.0f

    .line 1026
    .line 1027
    if-ne v3, v0, :cond_39

    .line 1028
    .line 1029
    invoke-virtual {v1, v8, v10}, Ld1/g;->U(IZ)Z

    .line 1030
    .line 1031
    .line 1032
    move-result v2

    .line 1033
    move v6, v2

    .line 1034
    const/4 v2, 0x1

    .line 1035
    goto :goto_23

    .line 1036
    :cond_39
    const/4 v2, 0x0

    .line 1037
    const/4 v6, 0x1

    .line 1038
    :goto_23
    if-ne v5, v0, :cond_3a

    .line 1039
    .line 1040
    const/4 v8, 0x1

    .line 1041
    invoke-virtual {v1, v8, v10}, Ld1/g;->U(IZ)Z

    .line 1042
    .line 1043
    .line 1044
    move-result v10

    .line 1045
    and-int/2addr v6, v10

    .line 1046
    add-int/lit8 v2, v2, 0x1

    .line 1047
    .line 1048
    :cond_3a
    :goto_24
    if-eqz v6, :cond_3e

    .line 1049
    .line 1050
    if-ne v3, v0, :cond_3b

    .line 1051
    .line 1052
    const/4 v3, 0x1

    .line 1053
    goto :goto_25

    .line 1054
    :cond_3b
    const/4 v3, 0x0

    .line 1055
    :goto_25
    if-ne v5, v0, :cond_3c

    .line 1056
    .line 1057
    const/4 v0, 0x1

    .line 1058
    goto :goto_26

    .line 1059
    :cond_3c
    const/4 v0, 0x0

    .line 1060
    :goto_26
    invoke-virtual {v1, v3, v0}, Ld1/g;->Q(ZZ)V

    .line 1061
    .line 1062
    .line 1063
    goto :goto_27

    .line 1064
    :cond_3d
    move/from16 v17, v2

    .line 1065
    .line 1066
    move-object/from16 v19, v6

    .line 1067
    .line 1068
    move/from16 v21, v8

    .line 1069
    .line 1070
    const/4 v2, 0x0

    .line 1071
    const/4 v6, 0x0

    .line 1072
    :cond_3e
    :goto_27
    if-eqz v6, :cond_3f

    .line 1073
    .line 1074
    const/4 v0, 0x2

    .line 1075
    if-eq v2, v0, :cond_6a

    .line 1076
    .line 1077
    :cond_3f
    iget v0, v1, Ld1/g;->H0:I

    .line 1078
    .line 1079
    const/16 v2, 0x8

    .line 1080
    .line 1081
    if-lez v7, :cond_51

    .line 1082
    .line 1083
    iget-object v3, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 1084
    .line 1085
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 1086
    .line 1087
    .line 1088
    move-result v3

    .line 1089
    const/16 v5, 0x40

    .line 1090
    .line 1091
    invoke-virtual {v1, v5}, Ld1/g;->X(I)Z

    .line 1092
    .line 1093
    .line 1094
    move-result v5

    .line 1095
    iget-object v6, v1, Ld1/g;->y0:Le1/c;

    .line 1096
    .line 1097
    const/4 v8, 0x0

    .line 1098
    :goto_28
    if-ge v8, v3, :cond_4b

    .line 1099
    .line 1100
    iget-object v10, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 1101
    .line 1102
    invoke-virtual {v10, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1103
    .line 1104
    .line 1105
    move-result-object v10

    .line 1106
    check-cast v10, Ld1/f;

    .line 1107
    .line 1108
    instance-of v11, v10, Ld1/k;

    .line 1109
    .line 1110
    if-eqz v11, :cond_40

    .line 1111
    .line 1112
    :goto_29
    const/4 v12, 0x0

    .line 1113
    goto/16 :goto_2d

    .line 1114
    .line 1115
    :cond_40
    instance-of v11, v10, Ld1/a;

    .line 1116
    .line 1117
    if-eqz v11, :cond_41

    .line 1118
    .line 1119
    goto :goto_29

    .line 1120
    :cond_41
    iget-boolean v11, v10, Ld1/f;->G:Z

    .line 1121
    .line 1122
    if-eqz v11, :cond_42

    .line 1123
    .line 1124
    goto :goto_29

    .line 1125
    :cond_42
    if-eqz v5, :cond_43

    .line 1126
    .line 1127
    iget-object v11, v10, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 1128
    .line 1129
    if-eqz v11, :cond_43

    .line 1130
    .line 1131
    iget-object v12, v10, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 1132
    .line 1133
    if-eqz v12, :cond_43

    .line 1134
    .line 1135
    iget-object v11, v11, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 1136
    .line 1137
    iget-boolean v11, v11, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 1138
    .line 1139
    if-eqz v11, :cond_43

    .line 1140
    .line 1141
    iget-object v11, v12, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 1142
    .line 1143
    iget-boolean v11, v11, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 1144
    .line 1145
    if-eqz v11, :cond_43

    .line 1146
    .line 1147
    goto :goto_29

    .line 1148
    :cond_43
    const/4 v11, 0x0

    .line 1149
    invoke-virtual {v10, v11}, Ld1/f;->k(I)Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1150
    .line 1151
    .line 1152
    move-result-object v12

    .line 1153
    const/4 v11, 0x1

    .line 1154
    invoke-virtual {v10, v11}, Ld1/f;->k(I)Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1155
    .line 1156
    .line 1157
    move-result-object v13

    .line 1158
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1159
    .line 1160
    if-ne v12, v14, :cond_44

    .line 1161
    .line 1162
    iget v15, v10, Ld1/f;->r:I

    .line 1163
    .line 1164
    if-eq v15, v11, :cond_44

    .line 1165
    .line 1166
    if-ne v13, v14, :cond_44

    .line 1167
    .line 1168
    iget v15, v10, Ld1/f;->s:I

    .line 1169
    .line 1170
    if-eq v15, v11, :cond_44

    .line 1171
    .line 1172
    move v15, v11

    .line 1173
    goto :goto_2a

    .line 1174
    :cond_44
    const/4 v15, 0x0

    .line 1175
    :goto_2a
    if-nez v15, :cond_47

    .line 1176
    .line 1177
    invoke-virtual {v1, v11}, Ld1/g;->X(I)Z

    .line 1178
    .line 1179
    .line 1180
    move-result v20

    .line 1181
    if-eqz v20, :cond_47

    .line 1182
    .line 1183
    instance-of v11, v10, Ld1/o;

    .line 1184
    .line 1185
    if-nez v11, :cond_47

    .line 1186
    .line 1187
    if-ne v12, v14, :cond_45

    .line 1188
    .line 1189
    iget v11, v10, Ld1/f;->r:I

    .line 1190
    .line 1191
    if-nez v11, :cond_45

    .line 1192
    .line 1193
    if-eq v13, v14, :cond_45

    .line 1194
    .line 1195
    invoke-virtual {v10}, Ld1/f;->y()Z

    .line 1196
    .line 1197
    .line 1198
    move-result v11

    .line 1199
    if-nez v11, :cond_45

    .line 1200
    .line 1201
    const/4 v15, 0x1

    .line 1202
    :cond_45
    if-ne v13, v14, :cond_46

    .line 1203
    .line 1204
    iget v11, v10, Ld1/f;->s:I

    .line 1205
    .line 1206
    if-nez v11, :cond_46

    .line 1207
    .line 1208
    if-eq v12, v14, :cond_46

    .line 1209
    .line 1210
    invoke-virtual {v10}, Ld1/f;->y()Z

    .line 1211
    .line 1212
    .line 1213
    move-result v11

    .line 1214
    if-nez v11, :cond_46

    .line 1215
    .line 1216
    const/4 v15, 0x1

    .line 1217
    :cond_46
    if-eq v12, v14, :cond_48

    .line 1218
    .line 1219
    if-ne v13, v14, :cond_47

    .line 1220
    .line 1221
    goto :goto_2b

    .line 1222
    :cond_47
    const/4 v12, 0x0

    .line 1223
    goto :goto_2c

    .line 1224
    :cond_48
    :goto_2b
    iget v11, v10, Ld1/f;->Y:F

    .line 1225
    .line 1226
    const/4 v12, 0x0

    .line 1227
    cmpl-float v11, v11, v12

    .line 1228
    .line 1229
    if-lez v11, :cond_49

    .line 1230
    .line 1231
    const/4 v15, 0x1

    .line 1232
    :cond_49
    :goto_2c
    if-eqz v15, :cond_4a

    .line 1233
    .line 1234
    goto :goto_2d

    .line 1235
    :cond_4a
    const/4 v11, 0x0

    .line 1236
    invoke-virtual {v4, v11, v10, v6}, Landroidx/work/impl/model/v;->h(ILd1/f;Le1/c;)Z

    .line 1237
    .line 1238
    .line 1239
    :goto_2d
    add-int/lit8 v8, v8, 0x1

    .line 1240
    .line 1241
    goto/16 :goto_28

    .line 1242
    .line 1243
    :cond_4b
    check-cast v6, Landroidx/constraintlayout/widget/b;

    .line 1244
    .line 1245
    iget-object v3, v6, Landroidx/constraintlayout/widget/b;->a:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 1246
    .line 1247
    invoke-virtual {v3}, Landroid/view/ViewGroup;->getChildCount()I

    .line 1248
    .line 1249
    .line 1250
    move-result v5

    .line 1251
    const/4 v13, 0x0

    .line 1252
    :goto_2e
    if-ge v13, v5, :cond_50

    .line 1253
    .line 1254
    invoke-virtual {v3, v13}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 1255
    .line 1256
    .line 1257
    move-result-object v6

    .line 1258
    instance-of v8, v6, Landroidx/constraintlayout/widget/Placeholder;

    .line 1259
    .line 1260
    if-eqz v8, :cond_4f

    .line 1261
    .line 1262
    check-cast v6, Landroidx/constraintlayout/widget/Placeholder;

    .line 1263
    .line 1264
    iget-object v8, v6, Landroidx/constraintlayout/widget/Placeholder;->b:Landroid/view/View;

    .line 1265
    .line 1266
    if-nez v8, :cond_4c

    .line 1267
    .line 1268
    goto :goto_2f

    .line 1269
    :cond_4c
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 1270
    .line 1271
    .line 1272
    move-result-object v8

    .line 1273
    check-cast v8, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 1274
    .line 1275
    iget-object v6, v6, Landroidx/constraintlayout/widget/Placeholder;->b:Landroid/view/View;

    .line 1276
    .line 1277
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 1278
    .line 1279
    .line 1280
    move-result-object v6

    .line 1281
    check-cast v6, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 1282
    .line 1283
    iget-object v10, v6, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 1284
    .line 1285
    const/4 v11, 0x0

    .line 1286
    iput v11, v10, Ld1/f;->i0:I

    .line 1287
    .line 1288
    iget-object v12, v8, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 1289
    .line 1290
    iget-object v14, v12, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1291
    .line 1292
    aget-object v14, v14, v11

    .line 1293
    .line 1294
    sget-object v11, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1295
    .line 1296
    if-eq v14, v11, :cond_4d

    .line 1297
    .line 1298
    invoke-virtual {v10}, Ld1/f;->r()I

    .line 1299
    .line 1300
    .line 1301
    move-result v10

    .line 1302
    invoke-virtual {v12, v10}, Ld1/f;->P(I)V

    .line 1303
    .line 1304
    .line 1305
    :cond_4d
    iget-object v8, v8, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 1306
    .line 1307
    iget-object v10, v8, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1308
    .line 1309
    const/4 v12, 0x1

    .line 1310
    aget-object v10, v10, v12

    .line 1311
    .line 1312
    if-eq v10, v11, :cond_4e

    .line 1313
    .line 1314
    iget-object v10, v6, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 1315
    .line 1316
    invoke-virtual {v10}, Ld1/f;->l()I

    .line 1317
    .line 1318
    .line 1319
    move-result v10

    .line 1320
    invoke-virtual {v8, v10}, Ld1/f;->M(I)V

    .line 1321
    .line 1322
    .line 1323
    :cond_4e
    iget-object v6, v6, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 1324
    .line 1325
    iput v2, v6, Ld1/f;->i0:I

    .line 1326
    .line 1327
    :cond_4f
    :goto_2f
    add-int/lit8 v13, v13, 0x1

    .line 1328
    .line 1329
    goto :goto_2e

    .line 1330
    :cond_50
    iget-object v3, v3, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 1331
    .line 1332
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 1333
    .line 1334
    .line 1335
    move-result v5

    .line 1336
    if-lez v5, :cond_51

    .line 1337
    .line 1338
    const/4 v13, 0x0

    .line 1339
    :goto_30
    if-ge v13, v5, :cond_51

    .line 1340
    .line 1341
    invoke-virtual {v3, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1342
    .line 1343
    .line 1344
    move-result-object v6

    .line 1345
    check-cast v6, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 1346
    .line 1347
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1348
    .line 1349
    .line 1350
    add-int/lit8 v13, v13, 0x1

    .line 1351
    .line 1352
    goto :goto_30

    .line 1353
    :cond_51
    invoke-virtual {v4, v1}, Landroidx/work/impl/model/v;->n(Ld1/g;)V

    .line 1354
    .line 1355
    .line 1356
    iget-object v3, v4, Landroidx/work/impl/model/v;->a:Ljava/lang/Object;

    .line 1357
    .line 1358
    check-cast v3, Ljava/util/ArrayList;

    .line 1359
    .line 1360
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 1361
    .line 1362
    .line 1363
    move-result v5

    .line 1364
    move/from16 v6, v21

    .line 1365
    .line 1366
    const/4 v13, 0x0

    .line 1367
    if-lez v7, :cond_52

    .line 1368
    .line 1369
    invoke-virtual {v4, v1, v13, v6, v9}, Landroidx/work/impl/model/v;->m(Ld1/g;III)V

    .line 1370
    .line 1371
    .line 1372
    :cond_52
    if-lez v5, :cond_69

    .line 1373
    .line 1374
    iget-object v7, v1, Ld1/f;->U:[Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1375
    .line 1376
    aget-object v8, v7, v13

    .line 1377
    .line 1378
    sget-object v10, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->WRAP_CONTENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 1379
    .line 1380
    if-ne v8, v10, :cond_53

    .line 1381
    .line 1382
    const/4 v8, 0x1

    .line 1383
    :goto_31
    const/4 v11, 0x1

    .line 1384
    goto :goto_32

    .line 1385
    :cond_53
    move v8, v13

    .line 1386
    goto :goto_31

    .line 1387
    :goto_32
    aget-object v7, v7, v11

    .line 1388
    .line 1389
    if-ne v7, v10, :cond_54

    .line 1390
    .line 1391
    const/4 v7, 0x1

    .line 1392
    goto :goto_33

    .line 1393
    :cond_54
    move v7, v13

    .line 1394
    :goto_33
    invoke-virtual/range {p1 .. p1}, Ld1/f;->r()I

    .line 1395
    .line 1396
    .line 1397
    move-result v10

    .line 1398
    iget-object v11, v4, Landroidx/work/impl/model/v;->c:Ljava/lang/Object;

    .line 1399
    .line 1400
    check-cast v11, Ld1/g;

    .line 1401
    .line 1402
    iget v12, v11, Ld1/f;->d0:I

    .line 1403
    .line 1404
    invoke-static {v10, v12}, Ljava/lang/Math;->max(II)I

    .line 1405
    .line 1406
    .line 1407
    move-result v10

    .line 1408
    invoke-virtual/range {p1 .. p1}, Ld1/f;->l()I

    .line 1409
    .line 1410
    .line 1411
    move-result v12

    .line 1412
    iget v11, v11, Ld1/f;->e0:I

    .line 1413
    .line 1414
    invoke-static {v12, v11}, Ljava/lang/Math;->max(II)I

    .line 1415
    .line 1416
    .line 1417
    move-result v11

    .line 1418
    move v12, v13

    .line 1419
    move v14, v12

    .line 1420
    :goto_34
    if-ge v12, v5, :cond_5a

    .line 1421
    .line 1422
    invoke-virtual {v3, v12}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1423
    .line 1424
    .line 1425
    move-result-object v15

    .line 1426
    check-cast v15, Ld1/f;

    .line 1427
    .line 1428
    instance-of v13, v15, Ld1/o;

    .line 1429
    .line 1430
    if-nez v13, :cond_55

    .line 1431
    .line 1432
    move/from16 v20, v0

    .line 1433
    .line 1434
    move-object/from16 v1, v19

    .line 1435
    .line 1436
    goto/16 :goto_36

    .line 1437
    .line 1438
    :cond_55
    invoke-virtual {v15}, Ld1/f;->r()I

    .line 1439
    .line 1440
    .line 1441
    move-result v13

    .line 1442
    invoke-virtual {v15}, Ld1/f;->l()I

    .line 1443
    .line 1444
    .line 1445
    move-result v2

    .line 1446
    move/from16 v20, v0

    .line 1447
    .line 1448
    move-object/from16 v1, v19

    .line 1449
    .line 1450
    const/4 v0, 0x1

    .line 1451
    invoke-virtual {v4, v0, v15, v1}, Landroidx/work/impl/model/v;->h(ILd1/f;Le1/c;)Z

    .line 1452
    .line 1453
    .line 1454
    move-result v19

    .line 1455
    or-int v0, v14, v19

    .line 1456
    .line 1457
    invoke-virtual {v15}, Ld1/f;->r()I

    .line 1458
    .line 1459
    .line 1460
    move-result v14

    .line 1461
    move/from16 p3, v0

    .line 1462
    .line 1463
    invoke-virtual {v15}, Ld1/f;->l()I

    .line 1464
    .line 1465
    .line 1466
    move-result v0

    .line 1467
    if-eq v14, v13, :cond_57

    .line 1468
    .line 1469
    invoke-virtual {v15, v14}, Ld1/f;->P(I)V

    .line 1470
    .line 1471
    .line 1472
    if-eqz v8, :cond_56

    .line 1473
    .line 1474
    invoke-virtual {v15}, Ld1/f;->s()I

    .line 1475
    .line 1476
    .line 1477
    move-result v13

    .line 1478
    iget v14, v15, Ld1/f;->W:I

    .line 1479
    .line 1480
    add-int/2addr v13, v14

    .line 1481
    if-le v13, v10, :cond_56

    .line 1482
    .line 1483
    invoke-virtual {v15}, Ld1/f;->s()I

    .line 1484
    .line 1485
    .line 1486
    move-result v13

    .line 1487
    iget v14, v15, Ld1/f;->W:I

    .line 1488
    .line 1489
    add-int/2addr v13, v14

    .line 1490
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 1491
    .line 1492
    invoke-virtual {v15, v14}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 1493
    .line 1494
    .line 1495
    move-result-object v14

    .line 1496
    invoke-virtual {v14}, Ld1/d;->e()I

    .line 1497
    .line 1498
    .line 1499
    move-result v14

    .line 1500
    add-int/2addr v14, v13

    .line 1501
    invoke-static {v10, v14}, Ljava/lang/Math;->max(II)I

    .line 1502
    .line 1503
    .line 1504
    move-result v10

    .line 1505
    :cond_56
    const/4 v13, 0x1

    .line 1506
    goto :goto_35

    .line 1507
    :cond_57
    move/from16 v13, p3

    .line 1508
    .line 1509
    :goto_35
    if-eq v0, v2, :cond_59

    .line 1510
    .line 1511
    invoke-virtual {v15, v0}, Ld1/f;->M(I)V

    .line 1512
    .line 1513
    .line 1514
    if-eqz v7, :cond_58

    .line 1515
    .line 1516
    invoke-virtual {v15}, Ld1/f;->t()I

    .line 1517
    .line 1518
    .line 1519
    move-result v0

    .line 1520
    iget v2, v15, Ld1/f;->X:I

    .line 1521
    .line 1522
    add-int/2addr v0, v2

    .line 1523
    if-le v0, v11, :cond_58

    .line 1524
    .line 1525
    invoke-virtual {v15}, Ld1/f;->t()I

    .line 1526
    .line 1527
    .line 1528
    move-result v0

    .line 1529
    iget v2, v15, Ld1/f;->X:I

    .line 1530
    .line 1531
    add-int/2addr v0, v2

    .line 1532
    sget-object v2, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 1533
    .line 1534
    invoke-virtual {v15, v2}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 1535
    .line 1536
    .line 1537
    move-result-object v2

    .line 1538
    invoke-virtual {v2}, Ld1/d;->e()I

    .line 1539
    .line 1540
    .line 1541
    move-result v2

    .line 1542
    add-int/2addr v2, v0

    .line 1543
    invoke-static {v11, v2}, Ljava/lang/Math;->max(II)I

    .line 1544
    .line 1545
    .line 1546
    move-result v11

    .line 1547
    :cond_58
    const/4 v13, 0x1

    .line 1548
    :cond_59
    check-cast v15, Ld1/o;

    .line 1549
    .line 1550
    iget-boolean v0, v15, Ld1/o;->C0:Z

    .line 1551
    .line 1552
    or-int/2addr v0, v13

    .line 1553
    move v14, v0

    .line 1554
    :goto_36
    add-int/lit8 v12, v12, 0x1

    .line 1555
    .line 1556
    move-object/from16 v19, v1

    .line 1557
    .line 1558
    move/from16 v0, v20

    .line 1559
    .line 1560
    const/16 v2, 0x8

    .line 1561
    .line 1562
    const/4 v13, 0x0

    .line 1563
    move-object/from16 v1, p1

    .line 1564
    .line 1565
    goto/16 :goto_34

    .line 1566
    .line 1567
    :cond_5a
    move/from16 v20, v0

    .line 1568
    .line 1569
    move-object/from16 v1, v19

    .line 1570
    .line 1571
    const/4 v0, 0x2

    .line 1572
    const/4 v13, 0x0

    .line 1573
    :goto_37
    if-ge v13, v0, :cond_68

    .line 1574
    .line 1575
    const/4 v2, 0x0

    .line 1576
    :goto_38
    if-ge v2, v5, :cond_67

    .line 1577
    .line 1578
    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1579
    .line 1580
    .line 1581
    move-result-object v12

    .line 1582
    check-cast v12, Ld1/f;

    .line 1583
    .line 1584
    instance-of v15, v12, Ld1/l;

    .line 1585
    .line 1586
    if-eqz v15, :cond_5c

    .line 1587
    .line 1588
    instance-of v15, v12, Ld1/o;

    .line 1589
    .line 1590
    if-eqz v15, :cond_5b

    .line 1591
    .line 1592
    goto :goto_3a

    .line 1593
    :cond_5b
    :goto_39
    const/16 v0, 0x8

    .line 1594
    .line 1595
    goto :goto_3b

    .line 1596
    :cond_5c
    :goto_3a
    instance-of v15, v12, Ld1/k;

    .line 1597
    .line 1598
    if-eqz v15, :cond_5d

    .line 1599
    .line 1600
    goto :goto_39

    .line 1601
    :cond_5d
    iget v15, v12, Ld1/f;->i0:I

    .line 1602
    .line 1603
    const/16 v0, 0x8

    .line 1604
    .line 1605
    if-ne v15, v0, :cond_5e

    .line 1606
    .line 1607
    goto :goto_3b

    .line 1608
    :cond_5e
    if-eqz v17, :cond_5f

    .line 1609
    .line 1610
    iget-object v15, v12, Ld1/f;->d:Landroidx/constraintlayout/core/widgets/analyzer/e;

    .line 1611
    .line 1612
    iget-object v15, v15, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 1613
    .line 1614
    iget-boolean v15, v15, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 1615
    .line 1616
    if-eqz v15, :cond_5f

    .line 1617
    .line 1618
    iget-object v15, v12, Ld1/f;->e:Landroidx/constraintlayout/core/widgets/analyzer/g;

    .line 1619
    .line 1620
    iget-object v15, v15, Landroidx/constraintlayout/core/widgets/analyzer/h;->e:Landroidx/constraintlayout/core/widgets/analyzer/b;

    .line 1621
    .line 1622
    iget-boolean v15, v15, Landroidx/constraintlayout/core/widgets/analyzer/a;->j:Z

    .line 1623
    .line 1624
    if-eqz v15, :cond_5f

    .line 1625
    .line 1626
    goto :goto_3b

    .line 1627
    :cond_5f
    instance-of v15, v12, Ld1/o;

    .line 1628
    .line 1629
    if-eqz v15, :cond_60

    .line 1630
    .line 1631
    :goto_3b
    move-object/from16 v21, v1

    .line 1632
    .line 1633
    move-object/from16 p3, v3

    .line 1634
    .line 1635
    move/from16 v19, v5

    .line 1636
    .line 1637
    goto/16 :goto_3c

    .line 1638
    .line 1639
    :cond_60
    invoke-virtual {v12}, Ld1/f;->r()I

    .line 1640
    .line 1641
    .line 1642
    move-result v15

    .line 1643
    invoke-virtual {v12}, Ld1/f;->l()I

    .line 1644
    .line 1645
    .line 1646
    move-result v0

    .line 1647
    move-object/from16 p3, v3

    .line 1648
    .line 1649
    iget v3, v12, Ld1/f;->c0:I

    .line 1650
    .line 1651
    move/from16 v19, v5

    .line 1652
    .line 1653
    const/4 v5, 0x1

    .line 1654
    if-ne v13, v5, :cond_61

    .line 1655
    .line 1656
    const/4 v5, 0x2

    .line 1657
    :cond_61
    invoke-virtual {v4, v5, v12, v1}, Landroidx/work/impl/model/v;->h(ILd1/f;Le1/c;)Z

    .line 1658
    .line 1659
    .line 1660
    move-result v5

    .line 1661
    or-int/2addr v5, v14

    .line 1662
    invoke-virtual {v12}, Ld1/f;->r()I

    .line 1663
    .line 1664
    .line 1665
    move-result v14

    .line 1666
    move-object/from16 v21, v1

    .line 1667
    .line 1668
    invoke-virtual {v12}, Ld1/f;->l()I

    .line 1669
    .line 1670
    .line 1671
    move-result v1

    .line 1672
    if-eq v14, v15, :cond_63

    .line 1673
    .line 1674
    invoke-virtual {v12, v14}, Ld1/f;->P(I)V

    .line 1675
    .line 1676
    .line 1677
    if-eqz v8, :cond_62

    .line 1678
    .line 1679
    invoke-virtual {v12}, Ld1/f;->s()I

    .line 1680
    .line 1681
    .line 1682
    move-result v5

    .line 1683
    iget v14, v12, Ld1/f;->W:I

    .line 1684
    .line 1685
    add-int/2addr v5, v14

    .line 1686
    if-le v5, v10, :cond_62

    .line 1687
    .line 1688
    invoke-virtual {v12}, Ld1/f;->s()I

    .line 1689
    .line 1690
    .line 1691
    move-result v5

    .line 1692
    iget v14, v12, Ld1/f;->W:I

    .line 1693
    .line 1694
    add-int/2addr v5, v14

    .line 1695
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->RIGHT:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 1696
    .line 1697
    invoke-virtual {v12, v14}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 1698
    .line 1699
    .line 1700
    move-result-object v14

    .line 1701
    invoke-virtual {v14}, Ld1/d;->e()I

    .line 1702
    .line 1703
    .line 1704
    move-result v14

    .line 1705
    add-int/2addr v14, v5

    .line 1706
    invoke-static {v10, v14}, Ljava/lang/Math;->max(II)I

    .line 1707
    .line 1708
    .line 1709
    move-result v10

    .line 1710
    :cond_62
    const/4 v5, 0x1

    .line 1711
    :cond_63
    if-eq v1, v0, :cond_65

    .line 1712
    .line 1713
    invoke-virtual {v12, v1}, Ld1/f;->M(I)V

    .line 1714
    .line 1715
    .line 1716
    if-eqz v7, :cond_64

    .line 1717
    .line 1718
    invoke-virtual {v12}, Ld1/f;->t()I

    .line 1719
    .line 1720
    .line 1721
    move-result v0

    .line 1722
    iget v1, v12, Ld1/f;->X:I

    .line 1723
    .line 1724
    add-int/2addr v0, v1

    .line 1725
    if-le v0, v11, :cond_64

    .line 1726
    .line 1727
    invoke-virtual {v12}, Ld1/f;->t()I

    .line 1728
    .line 1729
    .line 1730
    move-result v0

    .line 1731
    iget v1, v12, Ld1/f;->X:I

    .line 1732
    .line 1733
    add-int/2addr v0, v1

    .line 1734
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 1735
    .line 1736
    invoke-virtual {v12, v1}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 1737
    .line 1738
    .line 1739
    move-result-object v1

    .line 1740
    invoke-virtual {v1}, Ld1/d;->e()I

    .line 1741
    .line 1742
    .line 1743
    move-result v1

    .line 1744
    add-int/2addr v1, v0

    .line 1745
    invoke-static {v11, v1}, Ljava/lang/Math;->max(II)I

    .line 1746
    .line 1747
    .line 1748
    move-result v11

    .line 1749
    :cond_64
    const/4 v5, 0x1

    .line 1750
    :cond_65
    iget-boolean v0, v12, Ld1/f;->E:Z

    .line 1751
    .line 1752
    if-eqz v0, :cond_66

    .line 1753
    .line 1754
    iget v0, v12, Ld1/f;->c0:I

    .line 1755
    .line 1756
    if-eq v3, v0, :cond_66

    .line 1757
    .line 1758
    const/4 v14, 0x1

    .line 1759
    goto :goto_3c

    .line 1760
    :cond_66
    move v14, v5

    .line 1761
    :goto_3c
    add-int/lit8 v2, v2, 0x1

    .line 1762
    .line 1763
    move-object/from16 v3, p3

    .line 1764
    .line 1765
    move/from16 v5, v19

    .line 1766
    .line 1767
    move-object/from16 v1, v21

    .line 1768
    .line 1769
    const/4 v0, 0x2

    .line 1770
    goto/16 :goto_38

    .line 1771
    .line 1772
    :cond_67
    move-object/from16 v21, v1

    .line 1773
    .line 1774
    move-object/from16 p3, v3

    .line 1775
    .line 1776
    move/from16 v19, v5

    .line 1777
    .line 1778
    if-eqz v14, :cond_68

    .line 1779
    .line 1780
    add-int/lit8 v13, v13, 0x1

    .line 1781
    .line 1782
    move-object/from16 v0, p1

    .line 1783
    .line 1784
    move-object/from16 v1, v21

    .line 1785
    .line 1786
    invoke-virtual {v4, v0, v13, v6, v9}, Landroidx/work/impl/model/v;->m(Ld1/g;III)V

    .line 1787
    .line 1788
    .line 1789
    move-object/from16 v3, p3

    .line 1790
    .line 1791
    move/from16 v5, v19

    .line 1792
    .line 1793
    const/4 v0, 0x2

    .line 1794
    const/4 v14, 0x0

    .line 1795
    goto/16 :goto_37

    .line 1796
    .line 1797
    :cond_68
    move-object/from16 v0, p1

    .line 1798
    .line 1799
    :goto_3d
    move/from16 v1, v20

    .line 1800
    .line 1801
    goto :goto_3e

    .line 1802
    :cond_69
    move/from16 v20, v0

    .line 1803
    .line 1804
    move-object v0, v1

    .line 1805
    goto :goto_3d

    .line 1806
    :goto_3e
    iput v1, v0, Ld1/g;->H0:I

    .line 1807
    .line 1808
    const/16 v1, 0x200

    .line 1809
    .line 1810
    invoke-virtual {v0, v1}, Ld1/g;->X(I)Z

    .line 1811
    .line 1812
    .line 1813
    move-result v0

    .line 1814
    sput-boolean v0, La1/d;->p:Z

    .line 1815
    .line 1816
    :cond_6a
    return-void
.end method

.method public onLayout(ZIIII)V
    .locals 5

    .line 1
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 2
    .line 3
    .line 4
    move-result p1

    .line 5
    invoke-virtual {p0}, Landroid/view/View;->isInEditMode()Z

    .line 6
    .line 7
    .line 8
    move-result p2

    .line 9
    const/4 p3, 0x0

    .line 10
    move p4, p3

    .line 11
    :goto_0
    if-ge p4, p1, :cond_3

    .line 12
    .line 13
    invoke-virtual {p0, p4}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 14
    .line 15
    .line 16
    move-result-object p5

    .line 17
    invoke-virtual {p5}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 22
    .line 23
    iget-object v1, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 24
    .line 25
    invoke-virtual {p5}, Landroid/view/View;->getVisibility()I

    .line 26
    .line 27
    .line 28
    move-result v2

    .line 29
    const/16 v3, 0x8

    .line 30
    .line 31
    if-ne v2, v3, :cond_0

    .line 32
    .line 33
    iget-boolean v2, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->d0:Z

    .line 34
    .line 35
    if-nez v2, :cond_0

    .line 36
    .line 37
    iget-boolean v2, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->e0:Z

    .line 38
    .line 39
    if-nez v2, :cond_0

    .line 40
    .line 41
    if-nez p2, :cond_0

    .line 42
    .line 43
    goto :goto_1

    .line 44
    :cond_0
    iget-boolean v0, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->f0:Z

    .line 45
    .line 46
    if-eqz v0, :cond_1

    .line 47
    .line 48
    goto :goto_1

    .line 49
    :cond_1
    invoke-virtual {v1}, Ld1/f;->s()I

    .line 50
    .line 51
    .line 52
    move-result v0

    .line 53
    invoke-virtual {v1}, Ld1/f;->t()I

    .line 54
    .line 55
    .line 56
    move-result v2

    .line 57
    invoke-virtual {v1}, Ld1/f;->r()I

    .line 58
    .line 59
    .line 60
    move-result v3

    .line 61
    add-int/2addr v3, v0

    .line 62
    invoke-virtual {v1}, Ld1/f;->l()I

    .line 63
    .line 64
    .line 65
    move-result v1

    .line 66
    add-int/2addr v1, v2

    .line 67
    invoke-virtual {p5, v0, v2, v3, v1}, Landroid/view/View;->layout(IIII)V

    .line 68
    .line 69
    .line 70
    instance-of v4, p5, Landroidx/constraintlayout/widget/Placeholder;

    .line 71
    .line 72
    if-eqz v4, :cond_2

    .line 73
    .line 74
    check-cast p5, Landroidx/constraintlayout/widget/Placeholder;

    .line 75
    .line 76
    invoke-virtual {p5}, Landroidx/constraintlayout/widget/Placeholder;->getContent()Landroid/view/View;

    .line 77
    .line 78
    .line 79
    move-result-object p5

    .line 80
    if-eqz p5, :cond_2

    .line 81
    .line 82
    invoke-virtual {p5, p3}, Landroid/view/View;->setVisibility(I)V

    .line 83
    .line 84
    .line 85
    invoke-virtual {p5, v0, v2, v3, v1}, Landroid/view/View;->layout(IIII)V

    .line 86
    .line 87
    .line 88
    :cond_2
    :goto_1
    add-int/lit8 p4, p4, 0x1

    .line 89
    .line 90
    goto :goto_0

    .line 91
    :cond_3
    iget-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 92
    .line 93
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    .line 94
    .line 95
    .line 96
    move-result p2

    .line 97
    if-lez p2, :cond_4

    .line 98
    .line 99
    :goto_2
    if-ge p3, p2, :cond_4

    .line 100
    .line 101
    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 102
    .line 103
    .line 104
    move-result-object p4

    .line 105
    check-cast p4, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 106
    .line 107
    invoke-virtual {p4}, Landroidx/constraintlayout/widget/ConstraintHelper;->n()V

    .line 108
    .line 109
    .line 110
    add-int/lit8 p3, p3, 0x1

    .line 111
    .line 112
    goto :goto_2

    .line 113
    :cond_4
    return-void
.end method

.method public onMeasure(II)V
    .locals 17

    .line 1
    move-object/from16 v7, p0

    .line 2
    .line 3
    move/from16 v6, p1

    .line 4
    .line 5
    move/from16 v8, p2

    .line 6
    .line 7
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->p:I

    .line 8
    .line 9
    if-ne v0, v6, :cond_0

    .line 10
    .line 11
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->q:I

    .line 12
    .line 13
    :cond_0
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 14
    .line 15
    const/4 v1, 0x0

    .line 16
    const/4 v2, 0x1

    .line 17
    if-nez v0, :cond_2

    .line 18
    .line 19
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 20
    .line 21
    .line 22
    move-result v0

    .line 23
    move v3, v1

    .line 24
    :goto_0
    if-ge v3, v0, :cond_2

    .line 25
    .line 26
    invoke-virtual {v7, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 27
    .line 28
    .line 29
    move-result-object v4

    .line 30
    invoke-virtual {v4}, Landroid/view/View;->isLayoutRequested()Z

    .line 31
    .line 32
    .line 33
    move-result v4

    .line 34
    if-eqz v4, :cond_1

    .line 35
    .line 36
    iput-boolean v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 37
    .line 38
    goto :goto_1

    .line 39
    :cond_1
    add-int/lit8 v3, v3, 0x1

    .line 40
    .line 41
    goto :goto_0

    .line 42
    :cond_2
    :goto_1
    iput v6, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->p:I

    .line 43
    .line 44
    iput v8, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->q:I

    .line 45
    .line 46
    invoke-virtual/range {p0 .. p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->l()Z

    .line 47
    .line 48
    .line 49
    move-result v0

    .line 50
    iget-object v9, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 51
    .line 52
    iput-boolean v0, v9, Ld1/g;->z0:Z

    .line 53
    .line 54
    iget-boolean v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 55
    .line 56
    if-eqz v0, :cond_21

    .line 57
    .line 58
    iput-boolean v1, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 59
    .line 60
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 61
    .line 62
    .line 63
    move-result v0

    .line 64
    move v3, v1

    .line 65
    :goto_2
    if-ge v3, v0, :cond_4

    .line 66
    .line 67
    invoke-virtual {v7, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 68
    .line 69
    .line 70
    move-result-object v4

    .line 71
    invoke-virtual {v4}, Landroid/view/View;->isLayoutRequested()Z

    .line 72
    .line 73
    .line 74
    move-result v4

    .line 75
    if-eqz v4, :cond_3

    .line 76
    .line 77
    move v10, v2

    .line 78
    goto :goto_3

    .line 79
    :cond_3
    add-int/lit8 v3, v3, 0x1

    .line 80
    .line 81
    goto :goto_2

    .line 82
    :cond_4
    move v10, v1

    .line 83
    :goto_3
    if-eqz v10, :cond_20

    .line 84
    .line 85
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->isInEditMode()Z

    .line 86
    .line 87
    .line 88
    move-result v11

    .line 89
    invoke-virtual/range {p0 .. p0}, Landroid/view/ViewGroup;->getChildCount()I

    .line 90
    .line 91
    .line 92
    move-result v12

    .line 93
    move v0, v1

    .line 94
    :goto_4
    if-ge v0, v12, :cond_6

    .line 95
    .line 96
    invoke-virtual {v7, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 97
    .line 98
    .line 99
    move-result-object v3

    .line 100
    invoke-virtual {v7, v3}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 101
    .line 102
    .line 103
    move-result-object v3

    .line 104
    if-nez v3, :cond_5

    .line 105
    .line 106
    goto :goto_5

    .line 107
    :cond_5
    invoke-virtual {v3}, Ld1/f;->D()V

    .line 108
    .line 109
    .line 110
    :goto_5
    add-int/lit8 v0, v0, 0x1

    .line 111
    .line 112
    goto :goto_4

    .line 113
    :cond_6
    const/4 v0, 0x0

    .line 114
    const/4 v3, -0x1

    .line 115
    if-eqz v11, :cond_f

    .line 116
    .line 117
    move v4, v1

    .line 118
    :goto_6
    if-ge v4, v12, :cond_f

    .line 119
    .line 120
    invoke-virtual {v7, v4}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 121
    .line 122
    .line 123
    move-result-object v5

    .line 124
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    .line 125
    .line 126
    .line 127
    move-result-object v13

    .line 128
    invoke-virtual {v5}, Landroid/view/View;->getId()I

    .line 129
    .line 130
    .line 131
    move-result v14

    .line 132
    invoke-virtual {v13, v14}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    .line 133
    .line 134
    .line 135
    move-result-object v13

    .line 136
    invoke-virtual {v5}, Landroid/view/View;->getId()I

    .line 137
    .line 138
    .line 139
    move-result v14

    .line 140
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 141
    .line 142
    .line 143
    move-result-object v14

    .line 144
    instance-of v15, v13, Ljava/lang/String;

    .line 145
    .line 146
    if-eqz v15, :cond_9

    .line 147
    .line 148
    iget-object v15, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->m:Ljava/util/HashMap;

    .line 149
    .line 150
    if-nez v15, :cond_7

    .line 151
    .line 152
    new-instance v15, Ljava/util/HashMap;

    .line 153
    .line 154
    invoke-direct {v15}, Ljava/util/HashMap;-><init>()V

    .line 155
    .line 156
    .line 157
    iput-object v15, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->m:Ljava/util/HashMap;

    .line 158
    .line 159
    :cond_7
    const-string v15, "/"

    .line 160
    .line 161
    invoke-virtual {v13, v15}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    .line 162
    .line 163
    .line 164
    move-result v15

    .line 165
    if-eq v15, v3, :cond_8

    .line 166
    .line 167
    add-int/lit8 v15, v15, 0x1

    .line 168
    .line 169
    invoke-virtual {v13, v15}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 170
    .line 171
    .line 172
    move-result-object v15

    .line 173
    goto :goto_7

    .line 174
    :cond_8
    move-object v15, v13

    .line 175
    :goto_7
    iget-object v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->m:Ljava/util/HashMap;

    .line 176
    .line 177
    invoke-virtual {v2, v15, v14}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 178
    .line 179
    .line 180
    :cond_9
    const/16 v2, 0x2f

    .line 181
    .line 182
    invoke-virtual {v13, v2}, Ljava/lang/String;->indexOf(I)I

    .line 183
    .line 184
    .line 185
    move-result v2

    .line 186
    if-eq v2, v3, :cond_a

    .line 187
    .line 188
    add-int/lit8 v2, v2, 0x1

    .line 189
    .line 190
    invoke-virtual {v13, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    .line 191
    .line 192
    .line 193
    move-result-object v13

    .line 194
    :cond_a
    invoke-virtual {v5}, Landroid/view/View;->getId()I

    .line 195
    .line 196
    .line 197
    move-result v2

    .line 198
    if-nez v2, :cond_b

    .line 199
    .line 200
    :goto_8
    move-object v2, v9

    .line 201
    goto :goto_9

    .line 202
    :cond_b
    iget-object v5, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 203
    .line 204
    invoke-virtual {v5, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 205
    .line 206
    .line 207
    move-result-object v5

    .line 208
    check-cast v5, Landroid/view/View;

    .line 209
    .line 210
    if-nez v5, :cond_c

    .line 211
    .line 212
    invoke-virtual {v7, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 213
    .line 214
    .line 215
    move-result-object v5

    .line 216
    if-eqz v5, :cond_c

    .line 217
    .line 218
    if-eq v5, v7, :cond_c

    .line 219
    .line 220
    invoke-virtual {v5}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    .line 221
    .line 222
    .line 223
    move-result-object v2

    .line 224
    if-ne v2, v7, :cond_c

    .line 225
    .line 226
    invoke-virtual {v7, v5}, Landroidx/constraintlayout/widget/ConstraintLayout;->onViewAdded(Landroid/view/View;)V

    .line 227
    .line 228
    .line 229
    :cond_c
    if-ne v5, v7, :cond_d

    .line 230
    .line 231
    goto :goto_8

    .line 232
    :cond_d
    if-nez v5, :cond_e

    .line 233
    .line 234
    move-object v2, v0

    .line 235
    goto :goto_9

    .line 236
    :cond_e
    invoke-virtual {v5}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 237
    .line 238
    .line 239
    move-result-object v2

    .line 240
    check-cast v2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 241
    .line 242
    iget-object v2, v2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 243
    .line 244
    :goto_9
    iput-object v13, v2, Ld1/f;->k0:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 245
    .line 246
    :catch_0
    add-int/lit8 v4, v4, 0x1

    .line 247
    .line 248
    const/4 v2, 0x1

    .line 249
    goto/16 :goto_6

    .line 250
    .line 251
    :cond_f
    iget v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->l:I

    .line 252
    .line 253
    if-eq v2, v3, :cond_11

    .line 254
    .line 255
    move v2, v1

    .line 256
    :goto_a
    if-ge v2, v12, :cond_11

    .line 257
    .line 258
    invoke-virtual {v7, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 259
    .line 260
    .line 261
    move-result-object v4

    .line 262
    invoke-virtual {v4}, Landroid/view/View;->getId()I

    .line 263
    .line 264
    .line 265
    move-result v5

    .line 266
    iget v13, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->l:I

    .line 267
    .line 268
    if-ne v5, v13, :cond_10

    .line 269
    .line 270
    instance-of v5, v4, Landroidx/constraintlayout/widget/Constraints;

    .line 271
    .line 272
    if-eqz v5, :cond_10

    .line 273
    .line 274
    check-cast v4, Landroidx/constraintlayout/widget/Constraints;

    .line 275
    .line 276
    invoke-virtual {v4}, Landroidx/constraintlayout/widget/Constraints;->getConstraintSet()Landroidx/constraintlayout/widget/d;

    .line 277
    .line 278
    .line 279
    move-result-object v4

    .line 280
    iput-object v4, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 281
    .line 282
    :cond_10
    add-int/lit8 v2, v2, 0x1

    .line 283
    .line 284
    goto :goto_a

    .line 285
    :cond_11
    iget-object v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 286
    .line 287
    if-eqz v2, :cond_12

    .line 288
    .line 289
    invoke-virtual {v2, v7}, Landroidx/constraintlayout/widget/d;->c(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 290
    .line 291
    .line 292
    :cond_12
    iget-object v2, v9, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 293
    .line 294
    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 295
    .line 296
    .line 297
    iget-object v2, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 298
    .line 299
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    .line 300
    .line 301
    .line 302
    move-result v4

    .line 303
    if-lez v4, :cond_18

    .line 304
    .line 305
    move v5, v1

    .line 306
    :goto_b
    if-ge v5, v4, :cond_18

    .line 307
    .line 308
    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 309
    .line 310
    .line 311
    move-result-object v13

    .line 312
    check-cast v13, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 313
    .line 314
    invoke-virtual {v13}, Landroid/view/View;->isInEditMode()Z

    .line 315
    .line 316
    .line 317
    move-result v14

    .line 318
    if-eqz v14, :cond_13

    .line 319
    .line 320
    iget-object v14, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->e:Ljava/lang/String;

    .line 321
    .line 322
    invoke-virtual {v13, v14}, Landroidx/constraintlayout/widget/ConstraintHelper;->setIds(Ljava/lang/String;)V

    .line 323
    .line 324
    .line 325
    :cond_13
    iget-object v14, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->d:Ld1/l;

    .line 326
    .line 327
    if-nez v14, :cond_14

    .line 328
    .line 329
    goto :goto_d

    .line 330
    :cond_14
    iput v1, v14, Ld1/l;->v0:I

    .line 331
    .line 332
    iget-object v14, v14, Ld1/l;->u0:[Ld1/f;

    .line 333
    .line 334
    invoke-static {v14, v0}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 335
    .line 336
    .line 337
    move v14, v1

    .line 338
    :goto_c
    iget v15, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->b:I

    .line 339
    .line 340
    if-ge v14, v15, :cond_17

    .line 341
    .line 342
    iget-object v15, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->a:[I

    .line 343
    .line 344
    aget v15, v15, v14

    .line 345
    .line 346
    invoke-virtual {v7, v15}, Landroidx/constraintlayout/widget/ConstraintLayout;->f(I)Landroid/view/View;

    .line 347
    .line 348
    .line 349
    move-result-object v16

    .line 350
    if-nez v16, :cond_15

    .line 351
    .line 352
    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 353
    .line 354
    .line 355
    move-result-object v15

    .line 356
    iget-object v0, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->h:Ljava/util/HashMap;

    .line 357
    .line 358
    invoke-virtual {v0, v15}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 359
    .line 360
    .line 361
    move-result-object v15

    .line 362
    check-cast v15, Ljava/lang/String;

    .line 363
    .line 364
    invoke-virtual {v13, v7, v15}, Landroidx/constraintlayout/widget/ConstraintHelper;->h(Landroidx/constraintlayout/widget/ConstraintLayout;Ljava/lang/String;)I

    .line 365
    .line 366
    .line 367
    move-result v1

    .line 368
    if-eqz v1, :cond_15

    .line 369
    .line 370
    iget-object v3, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->a:[I

    .line 371
    .line 372
    aput v1, v3, v14

    .line 373
    .line 374
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 375
    .line 376
    .line 377
    move-result-object v3

    .line 378
    invoke-virtual {v0, v3, v15}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 379
    .line 380
    .line 381
    invoke-virtual {v7, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->f(I)Landroid/view/View;

    .line 382
    .line 383
    .line 384
    move-result-object v16

    .line 385
    :cond_15
    move-object/from16 v0, v16

    .line 386
    .line 387
    if-eqz v0, :cond_16

    .line 388
    .line 389
    iget-object v1, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->d:Ld1/l;

    .line 390
    .line 391
    invoke-virtual {v7, v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 392
    .line 393
    .line 394
    move-result-object v0

    .line 395
    invoke-virtual {v1, v0}, Ld1/l;->S(Ld1/f;)V

    .line 396
    .line 397
    .line 398
    :cond_16
    add-int/lit8 v14, v14, 0x1

    .line 399
    .line 400
    const/4 v0, 0x0

    .line 401
    const/4 v1, 0x0

    .line 402
    const/4 v3, -0x1

    .line 403
    goto :goto_c

    .line 404
    :cond_17
    iget-object v0, v13, Landroidx/constraintlayout/widget/ConstraintHelper;->d:Ld1/l;

    .line 405
    .line 406
    invoke-virtual {v0}, Ld1/l;->U()V

    .line 407
    .line 408
    .line 409
    :goto_d
    add-int/lit8 v5, v5, 0x1

    .line 410
    .line 411
    const/4 v0, 0x0

    .line 412
    const/4 v1, 0x0

    .line 413
    const/4 v3, -0x1

    .line 414
    goto :goto_b

    .line 415
    :cond_18
    const/4 v0, 0x0

    .line 416
    :goto_e
    if-ge v0, v12, :cond_1c

    .line 417
    .line 418
    invoke-virtual {v7, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 419
    .line 420
    .line 421
    move-result-object v1

    .line 422
    instance-of v2, v1, Landroidx/constraintlayout/widget/Placeholder;

    .line 423
    .line 424
    if-eqz v2, :cond_1a

    .line 425
    .line 426
    check-cast v1, Landroidx/constraintlayout/widget/Placeholder;

    .line 427
    .line 428
    iget v2, v1, Landroidx/constraintlayout/widget/Placeholder;->a:I

    .line 429
    .line 430
    const/4 v3, -0x1

    .line 431
    if-ne v2, v3, :cond_19

    .line 432
    .line 433
    invoke-virtual {v1}, Landroid/view/View;->isInEditMode()Z

    .line 434
    .line 435
    .line 436
    move-result v2

    .line 437
    if-nez v2, :cond_19

    .line 438
    .line 439
    iget v2, v1, Landroidx/constraintlayout/widget/Placeholder;->c:I

    .line 440
    .line 441
    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 442
    .line 443
    .line 444
    :cond_19
    iget v2, v1, Landroidx/constraintlayout/widget/Placeholder;->a:I

    .line 445
    .line 446
    invoke-virtual {v7, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    .line 447
    .line 448
    .line 449
    move-result-object v2

    .line 450
    iput-object v2, v1, Landroidx/constraintlayout/widget/Placeholder;->b:Landroid/view/View;

    .line 451
    .line 452
    if-eqz v2, :cond_1b

    .line 453
    .line 454
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 455
    .line 456
    .line 457
    move-result-object v2

    .line 458
    check-cast v2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 459
    .line 460
    const/4 v4, 0x1

    .line 461
    iput-boolean v4, v2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->f0:Z

    .line 462
    .line 463
    iget-object v2, v1, Landroidx/constraintlayout/widget/Placeholder;->b:Landroid/view/View;

    .line 464
    .line 465
    const/4 v5, 0x0

    .line 466
    invoke-virtual {v2, v5}, Landroid/view/View;->setVisibility(I)V

    .line 467
    .line 468
    .line 469
    invoke-virtual {v1, v5}, Landroid/view/View;->setVisibility(I)V

    .line 470
    .line 471
    .line 472
    goto :goto_f

    .line 473
    :cond_1a
    const/4 v3, -0x1

    .line 474
    :cond_1b
    const/4 v4, 0x1

    .line 475
    const/4 v5, 0x0

    .line 476
    :goto_f
    add-int/lit8 v0, v0, 0x1

    .line 477
    .line 478
    goto :goto_e

    .line 479
    :cond_1c
    const/4 v5, 0x0

    .line 480
    iget-object v13, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->n:Landroid/util/SparseArray;

    .line 481
    .line 482
    invoke-virtual {v13}, Landroid/util/SparseArray;->clear()V

    .line 483
    .line 484
    .line 485
    invoke-virtual {v13, v5, v9}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 486
    .line 487
    .line 488
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getId()I

    .line 489
    .line 490
    .line 491
    move-result v0

    .line 492
    invoke-virtual {v13, v0, v9}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 493
    .line 494
    .line 495
    move v0, v5

    .line 496
    :goto_10
    if-ge v0, v12, :cond_1d

    .line 497
    .line 498
    invoke-virtual {v7, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 499
    .line 500
    .line 501
    move-result-object v1

    .line 502
    invoke-virtual {v7, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 503
    .line 504
    .line 505
    move-result-object v2

    .line 506
    invoke-virtual {v1}, Landroid/view/View;->getId()I

    .line 507
    .line 508
    .line 509
    move-result v1

    .line 510
    invoke-virtual {v13, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 511
    .line 512
    .line 513
    add-int/lit8 v0, v0, 0x1

    .line 514
    .line 515
    goto :goto_10

    .line 516
    :cond_1d
    move v14, v5

    .line 517
    :goto_11
    if-ge v14, v12, :cond_20

    .line 518
    .line 519
    invoke-virtual {v7, v14}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    .line 520
    .line 521
    .line 522
    move-result-object v2

    .line 523
    invoke-virtual {v7, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 524
    .line 525
    .line 526
    move-result-object v3

    .line 527
    if-nez v3, :cond_1e

    .line 528
    .line 529
    goto :goto_12

    .line 530
    :cond_1e
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 531
    .line 532
    .line 533
    move-result-object v0

    .line 534
    move-object v4, v0

    .line 535
    check-cast v4, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 536
    .line 537
    iget-object v0, v9, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 538
    .line 539
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 540
    .line 541
    .line 542
    iget-object v0, v3, Ld1/f;->V:Ld1/f;

    .line 543
    .line 544
    if-eqz v0, :cond_1f

    .line 545
    .line 546
    check-cast v0, Ld1/g;

    .line 547
    .line 548
    iget-object v0, v0, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 549
    .line 550
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 551
    .line 552
    .line 553
    invoke-virtual {v3}, Ld1/f;->D()V

    .line 554
    .line 555
    .line 556
    :cond_1f
    iput-object v9, v3, Ld1/f;->V:Ld1/f;

    .line 557
    .line 558
    move-object/from16 v0, p0

    .line 559
    .line 560
    move v1, v11

    .line 561
    move-object v5, v13

    .line 562
    invoke-virtual/range {v0 .. v5}, Landroidx/constraintlayout/widget/ConstraintLayout;->a(ZLandroid/view/View;Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;)V

    .line 563
    .line 564
    .line 565
    :goto_12
    add-int/lit8 v14, v14, 0x1

    .line 566
    .line 567
    goto :goto_11

    .line 568
    :cond_20
    if-eqz v10, :cond_21

    .line 569
    .line 570
    iget-object v0, v9, Ld1/g;->v0:Landroidx/work/impl/model/v;

    .line 571
    .line 572
    invoke-virtual {v0, v9}, Landroidx/work/impl/model/v;->n(Ld1/g;)V

    .line 573
    .line 574
    .line 575
    :cond_21
    iget v0, v7, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 576
    .line 577
    invoke-virtual {v7, v9, v0, v6, v8}, Landroidx/constraintlayout/widget/ConstraintLayout;->o(Ld1/g;III)V

    .line 578
    .line 579
    .line 580
    invoke-virtual {v9}, Ld1/f;->r()I

    .line 581
    .line 582
    .line 583
    move-result v3

    .line 584
    invoke-virtual {v9}, Ld1/f;->l()I

    .line 585
    .line 586
    .line 587
    move-result v4

    .line 588
    iget-boolean v5, v9, Ld1/g;->I0:Z

    .line 589
    .line 590
    iget-boolean v9, v9, Ld1/g;->J0:Z

    .line 591
    .line 592
    move-object/from16 v0, p0

    .line 593
    .line 594
    move/from16 v1, p1

    .line 595
    .line 596
    move/from16 v2, p2

    .line 597
    .line 598
    move v6, v9

    .line 599
    invoke-virtual/range {v0 .. v6}, Landroidx/constraintlayout/widget/ConstraintLayout;->n(IIIIZZ)V

    .line 600
    .line 601
    .line 602
    return-void
.end method

.method public onViewAdded(Landroid/view/View;)V
    .locals 4

    .line 1
    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onViewAdded(Landroid/view/View;)V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 5
    .line 6
    .line 7
    move-result-object v0

    .line 8
    instance-of v1, p1, Landroidx/constraintlayout/widget/Guideline;

    .line 9
    .line 10
    const/4 v2, 0x1

    .line 11
    if-eqz v1, :cond_0

    .line 12
    .line 13
    instance-of v0, v0, Ld1/k;

    .line 14
    .line 15
    if-nez v0, :cond_0

    .line 16
    .line 17
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 22
    .line 23
    new-instance v1, Ld1/k;

    .line 24
    .line 25
    invoke-direct {v1}, Ld1/k;-><init>()V

    .line 26
    .line 27
    .line 28
    iput-object v1, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 29
    .line 30
    iput-boolean v2, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->d0:Z

    .line 31
    .line 32
    iget v0, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->V:I

    .line 33
    .line 34
    invoke-virtual {v1, v0}, Ld1/k;->T(I)V

    .line 35
    .line 36
    .line 37
    :cond_0
    instance-of v0, p1, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 38
    .line 39
    if-eqz v0, :cond_1

    .line 40
    .line 41
    move-object v0, p1

    .line 42
    check-cast v0, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 43
    .line 44
    invoke-virtual {v0}, Landroidx/constraintlayout/widget/ConstraintHelper;->q()V

    .line 45
    .line 46
    .line 47
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 48
    .line 49
    .line 50
    move-result-object v1

    .line 51
    check-cast v1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 52
    .line 53
    iput-boolean v2, v1, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->e0:Z

    .line 54
    .line 55
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 56
    .line 57
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    .line 58
    .line 59
    .line 60
    move-result v3

    .line 61
    if-nez v3, :cond_1

    .line 62
    .line 63
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 64
    .line 65
    .line 66
    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    .line 67
    .line 68
    .line 69
    move-result v0

    .line 70
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 71
    .line 72
    invoke-virtual {v1, v0, p1}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 73
    .line 74
    .line 75
    iput-boolean v2, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 76
    .line 77
    return-void
.end method

.method public onViewRemoved(Landroid/view/View;)V
    .locals 2

    .line 1
    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onViewRemoved(Landroid/view/View;)V

    .line 2
    .line 3
    .line 4
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    .line 5
    .line 6
    .line 7
    move-result v0

    .line 8
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 9
    .line 10
    invoke-virtual {v1, v0}, Landroid/util/SparseArray;->remove(I)V

    .line 11
    .line 12
    .line 13
    invoke-virtual {p0, p1}, Landroidx/constraintlayout/widget/ConstraintLayout;->j(Landroid/view/View;)Ld1/f;

    .line 14
    .line 15
    .line 16
    move-result-object v0

    .line 17
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 18
    .line 19
    iget-object v1, v1, Ld1/g;->u0:Ljava/util/ArrayList;

    .line 20
    .line 21
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 22
    .line 23
    .line 24
    invoke-virtual {v0}, Ld1/f;->D()V

    .line 25
    .line 26
    .line 27
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->b:Ljava/util/ArrayList;

    .line 28
    .line 29
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 30
    .line 31
    .line 32
    const/4 p1, 0x1

    .line 33
    iput-boolean p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 34
    .line 35
    return-void
.end method

.method public final p(Ld1/f;Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;Landroid/util/SparseArray;ILandroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)V
    .locals 2

    .line 1
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 2
    .line 3
    invoke-virtual {v0, p4}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 4
    .line 5
    .line 6
    move-result-object v0

    .line 7
    check-cast v0, Landroid/view/View;

    .line 8
    .line 9
    invoke-virtual {p3, p4}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    .line 10
    .line 11
    .line 12
    move-result-object p3

    .line 13
    check-cast p3, Ld1/f;

    .line 14
    .line 15
    if-eqz p3, :cond_1

    .line 16
    .line 17
    if-eqz v0, :cond_1

    .line 18
    .line 19
    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 20
    .line 21
    .line 22
    move-result-object p4

    .line 23
    instance-of p4, p4, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 24
    .line 25
    if-eqz p4, :cond_1

    .line 26
    .line 27
    const/4 p4, 0x1

    .line 28
    iput-boolean p4, p2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->c0:Z

    .line 29
    .line 30
    sget-object v1, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BASELINE:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 31
    .line 32
    if-ne p5, v1, :cond_0

    .line 33
    .line 34
    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    .line 35
    .line 36
    .line 37
    move-result-object v0

    .line 38
    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 39
    .line 40
    iput-boolean p4, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->c0:Z

    .line 41
    .line 42
    iget-object v0, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->q0:Ld1/f;

    .line 43
    .line 44
    iput-boolean p4, v0, Ld1/f;->E:Z

    .line 45
    .line 46
    :cond_0
    invoke-virtual {p1, v1}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 47
    .line 48
    .line 49
    move-result-object v0

    .line 50
    invoke-virtual {p3, p5}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 51
    .line 52
    .line 53
    move-result-object p3

    .line 54
    iget p5, p2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->D:I

    .line 55
    .line 56
    iget p2, p2, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->C:I

    .line 57
    .line 58
    invoke-virtual {v0, p3, p5, p2, p4}, Ld1/d;->b(Ld1/d;IIZ)Z

    .line 59
    .line 60
    .line 61
    iput-boolean p4, p1, Ld1/f;->E:Z

    .line 62
    .line 63
    sget-object p2, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->TOP:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 64
    .line 65
    invoke-virtual {p1, p2}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 66
    .line 67
    .line 68
    move-result-object p2

    .line 69
    invoke-virtual {p2}, Ld1/d;->j()V

    .line 70
    .line 71
    .line 72
    sget-object p2, Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;->BOTTOM:Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;

    .line 73
    .line 74
    invoke-virtual {p1, p2}, Ld1/f;->j(Landroidx/constraintlayout/core/widgets/ConstraintAnchor$Type;)Ld1/d;

    .line 75
    .line 76
    .line 77
    move-result-object p1

    .line 78
    invoke-virtual {p1}, Ld1/d;->j()V

    .line 79
    .line 80
    .line 81
    :cond_1
    return-void
.end method

.method public requestLayout()V
    .locals 1

    .line 1
    const/4 v0, 0x1

    .line 2
    iput-boolean v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->h:Z

    .line 3
    .line 4
    invoke-super {p0}, Landroid/view/ViewGroup;->requestLayout()V

    .line 5
    .line 6
    .line 7
    return-void
.end method

.method public setConstraintSet(Landroidx/constraintlayout/widget/d;)V
    .locals 0

    .line 1
    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->j:Landroidx/constraintlayout/widget/d;

    .line 2
    .line 3
    return-void
.end method

.method public setId(I)V
    .locals 2

    .line 1
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    .line 2
    .line 3
    .line 4
    move-result v0

    .line 5
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->a:Landroid/util/SparseArray;

    .line 6
    .line 7
    invoke-virtual {v1, v0}, Landroid/util/SparseArray;->remove(I)V

    .line 8
    .line 9
    .line 10
    invoke-super {p0, p1}, Landroid/view/ViewGroup;->setId(I)V

    .line 11
    .line 12
    .line 13
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    .line 14
    .line 15
    .line 16
    move-result p1

    .line 17
    invoke-virtual {v1, p1, p0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 18
    .line 19
    .line 20
    return-void
.end method

.method public setMaxHeight(I)V
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 2
    .line 3
    if-ne p1, v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->g:I

    .line 7
    .line 8
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->requestLayout()V

    .line 9
    .line 10
    .line 11
    return-void
.end method

.method public setMaxWidth(I)V
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 2
    .line 3
    if-ne p1, v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->f:I

    .line 7
    .line 8
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->requestLayout()V

    .line 9
    .line 10
    .line 11
    return-void
.end method

.method public setMinHeight(I)V
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 2
    .line 3
    if-ne p1, v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->e:I

    .line 7
    .line 8
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->requestLayout()V

    .line 9
    .line 10
    .line 11
    return-void
.end method

.method public setMinWidth(I)V
    .locals 1

    .line 1
    iget v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 2
    .line 3
    if-ne p1, v0, :cond_0

    .line 4
    .line 5
    return-void

    .line 6
    :cond_0
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->d:I

    .line 7
    .line 8
    invoke-virtual {p0}, Landroidx/constraintlayout/widget/ConstraintLayout;->requestLayout()V

    .line 9
    .line 10
    .line 11
    return-void
.end method

.method public setOnConstraintsChanged(Lj1/k;)V
    .locals 0

    .line 1
    iget-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->k:Lcom/google/firebase/messaging/o;

    .line 2
    .line 3
    if-eqz p1, :cond_0

    .line 4
    .line 5
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 6
    .line 7
    .line 8
    :cond_0
    return-void
.end method

.method public setOptimizationLevel(I)V
    .locals 1

    .line 1
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->i:I

    .line 2
    .line 3
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout;->c:Ld1/g;

    .line 4
    .line 5
    iput p1, v0, Ld1/g;->H0:I

    .line 6
    .line 7
    const/16 p1, 0x200

    .line 8
    .line 9
    invoke-virtual {v0, p1}, Ld1/g;->X(I)Z

    .line 10
    .line 11
    .line 12
    move-result p1

    .line 13
    sput-boolean p1, La1/d;->p:Z

    .line 14
    .line 15
    return-void
.end method

.method public final shouldDelayChildPressedState()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
