package androidx.constraintlayout.solver.widgets;

import androidx.constraintlayout.solver.ArrayRow;
import androidx.constraintlayout.solver.Cache;
import androidx.constraintlayout.solver.LinearSystem;
import androidx.constraintlayout.solver.SolverVariable;
import androidx.constraintlayout.solver.widgets.analyzer.ChainRun;
import androidx.constraintlayout.solver.widgets.analyzer.HorizontalWidgetRun;
import androidx.constraintlayout.solver.widgets.analyzer.VerticalWidgetRun;
import androidx.constraintlayout.solver.widgets.analyzer.WidgetRun;
import androidx.constraintlayout.widget.ConstraintLayout;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class ConstraintWidget {
    public static final int ANCHOR_BASELINE = 4;
    public static final int ANCHOR_BOTTOM = 3;
    public static final int ANCHOR_LEFT = 0;
    public static final int ANCHOR_RIGHT = 1;
    public static final int ANCHOR_TOP = 2;
    private static final boolean AUTOTAG_CENTER = false;
    public static final int CHAIN_PACKED = 2;
    public static final int CHAIN_SPREAD = 0;
    public static final int CHAIN_SPREAD_INSIDE = 1;
    public static float DEFAULT_BIAS = 0.5f;
    static final int DIMENSION_HORIZONTAL = 0;
    static final int DIMENSION_VERTICAL = 1;
    protected static final int DIRECT = 2;
    public static final int GONE = 8;
    public static final int HORIZONTAL = 0;
    public static final int INVISIBLE = 4;
    public static final int MATCH_CONSTRAINT_PERCENT = 2;
    public static final int MATCH_CONSTRAINT_RATIO = 3;
    public static final int MATCH_CONSTRAINT_RATIO_RESOLVED = 4;
    public static final int MATCH_CONSTRAINT_SPREAD = 0;
    public static final int MATCH_CONSTRAINT_WRAP = 1;
    protected static final int SOLVER = 1;
    public static final int UNKNOWN = -1;
    private static final boolean USE_WRAP_DIMENSION_FOR_SPREAD = false;
    public static final int VERTICAL = 1;
    public static final int VISIBLE = 0;
    private static final int WRAP = -2;
    private boolean hasBaseline;
    public ChainRun horizontalChainRun;
    public HorizontalWidgetRun horizontalRun;
    private boolean inPlaceholder;
    public boolean[] isTerminalWidget;
    protected ArrayList<ConstraintAnchor> mAnchors;
    ConstraintAnchor mBaseline;
    int mBaselineDistance;
    public ConstraintAnchor mBottom;
    boolean mBottomHasCentered;
    ConstraintAnchor mCenter;
    ConstraintAnchor mCenterX;
    ConstraintAnchor mCenterY;
    private float mCircleConstraintAngle;
    private Object mCompanionWidget;
    private int mContainerItemSkip;
    private String mDebugName;
    public float mDimensionRatio;
    protected int mDimensionRatioSide;
    int mDistToBottom;
    int mDistToLeft;
    int mDistToRight;
    int mDistToTop;
    boolean mGroupsToSolver;
    int mHeight;
    float mHorizontalBiasPercent;
    boolean mHorizontalChainFixedPosition;
    int mHorizontalChainStyle;
    ConstraintWidget mHorizontalNextWidget;
    public int mHorizontalResolution;
    boolean mHorizontalWrapVisited;
    private boolean mInVirtuaLayout;
    public boolean mIsHeightWrapContent;
    private boolean[] mIsInBarrier;
    public boolean mIsWidthWrapContent;
    public ConstraintAnchor mLeft;
    boolean mLeftHasCentered;
    public ConstraintAnchor[] mListAnchors;
    public DimensionBehaviour[] mListDimensionBehaviors;
    protected ConstraintWidget[] mListNextMatchConstraintsWidget;
    public int mMatchConstraintDefaultHeight;
    public int mMatchConstraintDefaultWidth;
    public int mMatchConstraintMaxHeight;
    public int mMatchConstraintMaxWidth;
    public int mMatchConstraintMinHeight;
    public int mMatchConstraintMinWidth;
    public float mMatchConstraintPercentHeight;
    public float mMatchConstraintPercentWidth;
    private int[] mMaxDimension;
    protected int mMinHeight;
    protected int mMinWidth;
    protected ConstraintWidget[] mNextChainWidget;
    protected int mOffsetX;
    protected int mOffsetY;
    boolean mOptimizerMeasurable;
    public ConstraintWidget mParent;
    int mRelX;
    int mRelY;
    float mResolvedDimensionRatio;
    int mResolvedDimensionRatioSide;
    boolean mResolvedHasRatio;
    public int[] mResolvedMatchConstraintDefault;
    public ConstraintAnchor mRight;
    boolean mRightHasCentered;
    public ConstraintAnchor mTop;
    boolean mTopHasCentered;
    private String mType;
    float mVerticalBiasPercent;
    boolean mVerticalChainFixedPosition;
    int mVerticalChainStyle;
    ConstraintWidget mVerticalNextWidget;
    public int mVerticalResolution;
    boolean mVerticalWrapVisited;
    private int mVisibility;
    public float[] mWeight;
    int mWidth;

    /* JADX INFO: renamed from: mX */
    protected int f231mX;

    /* JADX INFO: renamed from: mY */
    protected int f232mY;
    public boolean measured;
    public WidgetRun[] run;
    public ChainRun verticalChainRun;
    public VerticalWidgetRun verticalRun;
    public int[] wrapMeasure;

    public enum DimensionBehaviour {
        FIXED,
        WRAP_CONTENT,
        MATCH_CONSTRAINT,
        MATCH_PARENT
    }

    public WidgetRun getRun(int i) {
        if (i == 0) {
            return this.horizontalRun;
        }
        if (i == 1) {
            return this.verticalRun;
        }
        return null;
    }

    public boolean isInVirtualLayout() {
        return this.mInVirtuaLayout;
    }

    public void setInVirtualLayout(boolean z) {
        this.mInVirtuaLayout = z;
    }

    public int getMaxHeight() {
        return this.mMaxDimension[1];
    }

    public int getMaxWidth() {
        return this.mMaxDimension[0];
    }

    public void setMaxWidth(int i) {
        this.mMaxDimension[0] = i;
    }

    public void setMaxHeight(int i) {
        this.mMaxDimension[1] = i;
    }

    public boolean isSpreadWidth() {
        return this.mMatchConstraintDefaultWidth == 0 && this.mDimensionRatio == 0.0f && this.mMatchConstraintMinWidth == 0 && this.mMatchConstraintMaxWidth == 0 && this.mListDimensionBehaviors[0] == DimensionBehaviour.MATCH_CONSTRAINT;
    }

    public boolean isSpreadHeight() {
        return this.mMatchConstraintDefaultHeight == 0 && this.mDimensionRatio == 0.0f && this.mMatchConstraintMinHeight == 0 && this.mMatchConstraintMaxHeight == 0 && this.mListDimensionBehaviors[1] == DimensionBehaviour.MATCH_CONSTRAINT;
    }

    public void setHasBaseline(boolean z) {
        this.hasBaseline = z;
    }

    public boolean getHasBaseline() {
        return this.hasBaseline;
    }

    public boolean isInPlaceholder() {
        return this.inPlaceholder;
    }

    public void setInPlaceholder(boolean z) {
        this.inPlaceholder = z;
    }

    protected void setInBarrier(int i, boolean z) {
        this.mIsInBarrier[i] = z;
    }

    public void reset() {
        this.mLeft.reset();
        this.mTop.reset();
        this.mRight.reset();
        this.mBottom.reset();
        this.mBaseline.reset();
        this.mCenterX.reset();
        this.mCenterY.reset();
        this.mCenter.reset();
        this.mParent = null;
        this.mCircleConstraintAngle = 0.0f;
        this.mWidth = 0;
        this.mHeight = 0;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.f231mX = 0;
        this.f232mY = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        this.mMinWidth = 0;
        this.mMinHeight = 0;
        float f = DEFAULT_BIAS;
        this.mHorizontalBiasPercent = f;
        this.mVerticalBiasPercent = f;
        this.mListDimensionBehaviors[0] = DimensionBehaviour.FIXED;
        this.mListDimensionBehaviors[1] = DimensionBehaviour.FIXED;
        this.mCompanionWidget = null;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mType = null;
        this.mHorizontalWrapVisited = false;
        this.mVerticalWrapVisited = false;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mHorizontalChainFixedPosition = false;
        this.mVerticalChainFixedPosition = false;
        float[] fArr = this.mWeight;
        fArr[0] = -1.0f;
        fArr[1] = -1.0f;
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
        int[] iArr = this.mMaxDimension;
        iArr[0] = Integer.MAX_VALUE;
        iArr[1] = Integer.MAX_VALUE;
        this.mMatchConstraintDefaultWidth = 0;
        this.mMatchConstraintDefaultHeight = 0;
        this.mMatchConstraintPercentWidth = 1.0f;
        this.mMatchConstraintPercentHeight = 1.0f;
        this.mMatchConstraintMaxWidth = Integer.MAX_VALUE;
        this.mMatchConstraintMaxHeight = Integer.MAX_VALUE;
        this.mMatchConstraintMinWidth = 0;
        this.mMatchConstraintMinHeight = 0;
        this.mResolvedHasRatio = false;
        this.mResolvedDimensionRatioSide = -1;
        this.mResolvedDimensionRatio = 1.0f;
        this.mOptimizerMeasurable = false;
        this.mGroupsToSolver = false;
        boolean[] zArr = this.isTerminalWidget;
        zArr[0] = true;
        zArr[1] = true;
        this.mInVirtuaLayout = false;
        boolean[] zArr2 = this.mIsInBarrier;
        zArr2[0] = false;
        zArr2[1] = false;
    }

    public ConstraintWidget() {
        this.measured = false;
        this.run = new WidgetRun[2];
        this.horizontalRun = new HorizontalWidgetRun(this);
        this.verticalRun = new VerticalWidgetRun(this);
        this.isTerminalWidget = new boolean[]{true, true};
        this.wrapMeasure = new int[]{0, 0, 0, 0};
        this.mResolvedHasRatio = false;
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
        this.mMatchConstraintDefaultWidth = 0;
        this.mMatchConstraintDefaultHeight = 0;
        this.mResolvedMatchConstraintDefault = new int[2];
        this.mMatchConstraintMinWidth = 0;
        this.mMatchConstraintMaxWidth = 0;
        this.mMatchConstraintPercentWidth = 1.0f;
        this.mMatchConstraintMinHeight = 0;
        this.mMatchConstraintMaxHeight = 0;
        this.mMatchConstraintPercentHeight = 1.0f;
        this.mResolvedDimensionRatioSide = -1;
        this.mResolvedDimensionRatio = 1.0f;
        this.mMaxDimension = new int[]{Integer.MAX_VALUE, Integer.MAX_VALUE};
        this.mCircleConstraintAngle = 0.0f;
        this.hasBaseline = false;
        this.mInVirtuaLayout = false;
        this.mLeft = new ConstraintAnchor(this, ConstraintAnchor.Type.LEFT);
        this.mTop = new ConstraintAnchor(this, ConstraintAnchor.Type.TOP);
        this.mRight = new ConstraintAnchor(this, ConstraintAnchor.Type.RIGHT);
        this.mBottom = new ConstraintAnchor(this, ConstraintAnchor.Type.BOTTOM);
        this.mBaseline = new ConstraintAnchor(this, ConstraintAnchor.Type.BASELINE);
        this.mCenterX = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_X);
        this.mCenterY = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_Y);
        ConstraintAnchor constraintAnchor = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER);
        this.mCenter = constraintAnchor;
        this.mListAnchors = new ConstraintAnchor[]{this.mLeft, this.mRight, this.mTop, this.mBottom, this.mBaseline, constraintAnchor};
        this.mAnchors = new ArrayList<>();
        this.mIsInBarrier = new boolean[2];
        this.mListDimensionBehaviors = new DimensionBehaviour[]{DimensionBehaviour.FIXED, DimensionBehaviour.FIXED};
        this.mParent = null;
        this.mWidth = 0;
        this.mHeight = 0;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.f231mX = 0;
        this.f232mY = 0;
        this.mRelX = 0;
        this.mRelY = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        float f = DEFAULT_BIAS;
        this.mHorizontalBiasPercent = f;
        this.mVerticalBiasPercent = f;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mDebugName = null;
        this.mType = null;
        this.mOptimizerMeasurable = false;
        this.mGroupsToSolver = false;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mWeight = new float[]{-1.0f, -1.0f};
        this.mListNextMatchConstraintsWidget = new ConstraintWidget[]{null, null};
        this.mNextChainWidget = new ConstraintWidget[]{null, null};
        this.mHorizontalNextWidget = null;
        this.mVerticalNextWidget = null;
        addAnchors();
    }

    public ConstraintWidget(int i, int i2, int i3, int i4) {
        this.measured = false;
        this.run = new WidgetRun[2];
        this.horizontalRun = new HorizontalWidgetRun(this);
        this.verticalRun = new VerticalWidgetRun(this);
        this.isTerminalWidget = new boolean[]{true, true};
        this.wrapMeasure = new int[]{0, 0, 0, 0};
        this.mResolvedHasRatio = false;
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
        this.mMatchConstraintDefaultWidth = 0;
        this.mMatchConstraintDefaultHeight = 0;
        this.mResolvedMatchConstraintDefault = new int[2];
        this.mMatchConstraintMinWidth = 0;
        this.mMatchConstraintMaxWidth = 0;
        this.mMatchConstraintPercentWidth = 1.0f;
        this.mMatchConstraintMinHeight = 0;
        this.mMatchConstraintMaxHeight = 0;
        this.mMatchConstraintPercentHeight = 1.0f;
        this.mResolvedDimensionRatioSide = -1;
        this.mResolvedDimensionRatio = 1.0f;
        this.mMaxDimension = new int[]{Integer.MAX_VALUE, Integer.MAX_VALUE};
        this.mCircleConstraintAngle = 0.0f;
        this.hasBaseline = false;
        this.mInVirtuaLayout = false;
        this.mLeft = new ConstraintAnchor(this, ConstraintAnchor.Type.LEFT);
        this.mTop = new ConstraintAnchor(this, ConstraintAnchor.Type.TOP);
        this.mRight = new ConstraintAnchor(this, ConstraintAnchor.Type.RIGHT);
        this.mBottom = new ConstraintAnchor(this, ConstraintAnchor.Type.BOTTOM);
        this.mBaseline = new ConstraintAnchor(this, ConstraintAnchor.Type.BASELINE);
        this.mCenterX = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_X);
        this.mCenterY = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_Y);
        ConstraintAnchor constraintAnchor = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER);
        this.mCenter = constraintAnchor;
        this.mListAnchors = new ConstraintAnchor[]{this.mLeft, this.mRight, this.mTop, this.mBottom, this.mBaseline, constraintAnchor};
        this.mAnchors = new ArrayList<>();
        this.mIsInBarrier = new boolean[2];
        this.mListDimensionBehaviors = new DimensionBehaviour[]{DimensionBehaviour.FIXED, DimensionBehaviour.FIXED};
        this.mParent = null;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.mRelX = 0;
        this.mRelY = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        float f = DEFAULT_BIAS;
        this.mHorizontalBiasPercent = f;
        this.mVerticalBiasPercent = f;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mDebugName = null;
        this.mType = null;
        this.mOptimizerMeasurable = false;
        this.mGroupsToSolver = false;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mWeight = new float[]{-1.0f, -1.0f};
        this.mListNextMatchConstraintsWidget = new ConstraintWidget[]{null, null};
        this.mNextChainWidget = new ConstraintWidget[]{null, null};
        this.mHorizontalNextWidget = null;
        this.mVerticalNextWidget = null;
        this.f231mX = i;
        this.f232mY = i2;
        this.mWidth = i3;
        this.mHeight = i4;
        addAnchors();
    }

    public ConstraintWidget(int i, int i2) {
        this(0, 0, i, i2);
    }

    public void resetSolverVariables(Cache cache) {
        this.mLeft.resetSolverVariable(cache);
        this.mTop.resetSolverVariable(cache);
        this.mRight.resetSolverVariable(cache);
        this.mBottom.resetSolverVariable(cache);
        this.mBaseline.resetSolverVariable(cache);
        this.mCenter.resetSolverVariable(cache);
        this.mCenterX.resetSolverVariable(cache);
        this.mCenterY.resetSolverVariable(cache);
    }

    private void addAnchors() {
        this.mAnchors.add(this.mLeft);
        this.mAnchors.add(this.mTop);
        this.mAnchors.add(this.mRight);
        this.mAnchors.add(this.mBottom);
        this.mAnchors.add(this.mCenterX);
        this.mAnchors.add(this.mCenterY);
        this.mAnchors.add(this.mCenter);
        this.mAnchors.add(this.mBaseline);
    }

    public boolean isRoot() {
        return this.mParent == null;
    }

    public ConstraintWidget getParent() {
        return this.mParent;
    }

    public void setParent(ConstraintWidget constraintWidget) {
        this.mParent = constraintWidget;
    }

    public void setWidthWrapContent(boolean z) {
        this.mIsWidthWrapContent = z;
    }

    public boolean isWidthWrapContent() {
        return this.mIsWidthWrapContent;
    }

    public void setHeightWrapContent(boolean z) {
        this.mIsHeightWrapContent = z;
    }

    public boolean isHeightWrapContent() {
        return this.mIsHeightWrapContent;
    }

    public void connectCircularConstraint(ConstraintWidget constraintWidget, float f, int i) {
        immediateConnect(ConstraintAnchor.Type.CENTER, constraintWidget, ConstraintAnchor.Type.CENTER, i, 0);
        this.mCircleConstraintAngle = f;
    }

    public String getType() {
        return this.mType;
    }

    public void setType(String str) {
        this.mType = str;
    }

    public void setVisibility(int i) {
        this.mVisibility = i;
    }

    public int getVisibility() {
        return this.mVisibility;
    }

    public String getDebugName() {
        return this.mDebugName;
    }

    public void setDebugName(String str) {
        this.mDebugName = str;
    }

    public void setDebugSolverName(LinearSystem linearSystem, String str) {
        this.mDebugName = str;
        SolverVariable solverVariableCreateObjectVariable = linearSystem.createObjectVariable(this.mLeft);
        SolverVariable solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(this.mTop);
        SolverVariable solverVariableCreateObjectVariable3 = linearSystem.createObjectVariable(this.mRight);
        SolverVariable solverVariableCreateObjectVariable4 = linearSystem.createObjectVariable(this.mBottom);
        solverVariableCreateObjectVariable.setName(str + ".left");
        solverVariableCreateObjectVariable2.setName(str + ".top");
        solverVariableCreateObjectVariable3.setName(str + ".right");
        solverVariableCreateObjectVariable4.setName(str + ".bottom");
        if (this.mBaselineDistance > 0) {
            linearSystem.createObjectVariable(this.mBaseline).setName(str + ".baseline");
        }
    }

    public void createObjectVariables(LinearSystem linearSystem) {
        linearSystem.createObjectVariable(this.mLeft);
        linearSystem.createObjectVariable(this.mTop);
        linearSystem.createObjectVariable(this.mRight);
        linearSystem.createObjectVariable(this.mBottom);
        if (this.mBaselineDistance > 0) {
            linearSystem.createObjectVariable(this.mBaseline);
        }
    }

    public String toString() {
        String str;
        StringBuilder sb = new StringBuilder();
        String str2 = "";
        if (this.mType != null) {
            str = "type: " + this.mType + " ";
        } else {
            str = "";
        }
        sb.append(str);
        if (this.mDebugName != null) {
            str2 = "id: " + this.mDebugName + " ";
        }
        sb.append(str2);
        sb.append("(");
        sb.append(this.f231mX);
        sb.append(", ");
        sb.append(this.f232mY);
        sb.append(") - (");
        sb.append(this.mWidth);
        sb.append(" x ");
        sb.append(this.mHeight);
        sb.append(")");
        return sb.toString();
    }

    public int getX() {
        ConstraintWidget constraintWidget = this.mParent;
        if (constraintWidget != null && (constraintWidget instanceof ConstraintWidgetContainer)) {
            return ((ConstraintWidgetContainer) constraintWidget).mPaddingLeft + this.f231mX;
        }
        return this.f231mX;
    }

    public int getY() {
        ConstraintWidget constraintWidget = this.mParent;
        if (constraintWidget != null && (constraintWidget instanceof ConstraintWidgetContainer)) {
            return ((ConstraintWidgetContainer) constraintWidget).mPaddingTop + this.f232mY;
        }
        return this.f232mY;
    }

    public int getWidth() {
        if (this.mVisibility == 8) {
            return 0;
        }
        return this.mWidth;
    }

    public int getOptimizerWrapWidth() {
        int iMax;
        int i = this.mWidth;
        if (this.mListDimensionBehaviors[0] != DimensionBehaviour.MATCH_CONSTRAINT) {
            return i;
        }
        if (this.mMatchConstraintDefaultWidth == 1) {
            iMax = Math.max(this.mMatchConstraintMinWidth, i);
        } else {
            iMax = this.mMatchConstraintMinWidth;
            if (iMax > 0) {
                this.mWidth = iMax;
            } else {
                iMax = 0;
            }
        }
        int i2 = this.mMatchConstraintMaxWidth;
        return (i2 <= 0 || i2 >= iMax) ? iMax : i2;
    }

    public int getOptimizerWrapHeight() {
        int iMax;
        int i = this.mHeight;
        if (this.mListDimensionBehaviors[1] != DimensionBehaviour.MATCH_CONSTRAINT) {
            return i;
        }
        if (this.mMatchConstraintDefaultHeight == 1) {
            iMax = Math.max(this.mMatchConstraintMinHeight, i);
        } else {
            iMax = this.mMatchConstraintMinHeight;
            if (iMax > 0) {
                this.mHeight = iMax;
            } else {
                iMax = 0;
            }
        }
        int i2 = this.mMatchConstraintMaxHeight;
        return (i2 <= 0 || i2 >= iMax) ? iMax : i2;
    }

    public int getHeight() {
        if (this.mVisibility == 8) {
            return 0;
        }
        return this.mHeight;
    }

    public int getLength(int i) {
        if (i == 0) {
            return getWidth();
        }
        if (i == 1) {
            return getHeight();
        }
        return 0;
    }

    protected int getRootX() {
        return this.f231mX + this.mOffsetX;
    }

    protected int getRootY() {
        return this.f232mY + this.mOffsetY;
    }

    public int getMinWidth() {
        return this.mMinWidth;
    }

    public int getMinHeight() {
        return this.mMinHeight;
    }

    public int getLeft() {
        return getX();
    }

    public int getTop() {
        return getY();
    }

    public int getRight() {
        return getX() + this.mWidth;
    }

    public int getBottom() {
        return getY() + this.mHeight;
    }

    public int getHorizontalMargin() {
        ConstraintAnchor constraintAnchor = this.mLeft;
        int i = constraintAnchor != null ? 0 + constraintAnchor.mMargin : 0;
        ConstraintAnchor constraintAnchor2 = this.mRight;
        return constraintAnchor2 != null ? i + constraintAnchor2.mMargin : i;
    }

    public int getVerticalMargin() {
        int i = this.mLeft != null ? 0 + this.mTop.mMargin : 0;
        return this.mRight != null ? i + this.mBottom.mMargin : i;
    }

    public float getHorizontalBiasPercent() {
        return this.mHorizontalBiasPercent;
    }

    public float getVerticalBiasPercent() {
        return this.mVerticalBiasPercent;
    }

    public float getBiasPercent(int i) {
        if (i == 0) {
            return this.mHorizontalBiasPercent;
        }
        if (i == 1) {
            return this.mVerticalBiasPercent;
        }
        return -1.0f;
    }

    public boolean hasBaseline() {
        return this.hasBaseline;
    }

    public int getBaselineDistance() {
        return this.mBaselineDistance;
    }

    public Object getCompanionWidget() {
        return this.mCompanionWidget;
    }

    public ArrayList<ConstraintAnchor> getAnchors() {
        return this.mAnchors;
    }

    public void setX(int i) {
        this.f231mX = i;
    }

    public void setY(int i) {
        this.f232mY = i;
    }

    public void setOrigin(int i, int i2) {
        this.f231mX = i;
        this.f232mY = i2;
    }

    public void setOffset(int i, int i2) {
        this.mOffsetX = i;
        this.mOffsetY = i2;
    }

    public void setGoneMargin(ConstraintAnchor.Type type, int i) {
        int i2 = C00261.f233x4c44d048[type.ordinal()];
        if (i2 == 1) {
            this.mLeft.mGoneMargin = i;
            return;
        }
        if (i2 == 2) {
            this.mTop.mGoneMargin = i;
        } else if (i2 == 3) {
            this.mRight.mGoneMargin = i;
        } else {
            if (i2 != 4) {
                return;
            }
            this.mBottom.mGoneMargin = i;
        }
    }

    public void setWidth(int i) {
        this.mWidth = i;
        int i2 = this.mMinWidth;
        if (i < i2) {
            this.mWidth = i2;
        }
    }

    public void setHeight(int i) {
        this.mHeight = i;
        int i2 = this.mMinHeight;
        if (i < i2) {
            this.mHeight = i2;
        }
    }

    public void setLength(int i, int i2) {
        if (i2 == 0) {
            setWidth(i);
        } else if (i2 == 1) {
            setHeight(i);
        }
    }

    public void setHorizontalMatchStyle(int i, int i2, int i3, float f) {
        this.mMatchConstraintDefaultWidth = i;
        this.mMatchConstraintMinWidth = i2;
        if (i3 == Integer.MAX_VALUE) {
            i3 = 0;
        }
        this.mMatchConstraintMaxWidth = i3;
        this.mMatchConstraintPercentWidth = f;
        if (f <= 0.0f || f >= 1.0f || i != 0) {
            return;
        }
        this.mMatchConstraintDefaultWidth = 2;
    }

    public void setVerticalMatchStyle(int i, int i2, int i3, float f) {
        this.mMatchConstraintDefaultHeight = i;
        this.mMatchConstraintMinHeight = i2;
        if (i3 == Integer.MAX_VALUE) {
            i3 = 0;
        }
        this.mMatchConstraintMaxHeight = i3;
        this.mMatchConstraintPercentHeight = f;
        if (f <= 0.0f || f >= 1.0f || i != 0) {
            return;
        }
        this.mMatchConstraintDefaultHeight = 2;
    }

    /* JADX WARN: Code duplicated, block: B:40:0x0087 A[PHI: r0
      0x0087: PHI (r0v2 int) = (r0v1 int), (r0v0 int), (r0v0 int), (r0v0 int), (r0v0 int), (r0v0 int) binds: [B:39:0x0086, B:36:0x007f, B:24:0x0051, B:26:0x0057, B:28:0x0063, B:30:0x0067] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:40:0x0087 -> B:41:0x0088). Please report as a decompilation issue!!! */
    public void setDimensionRatio(String str) {
        float fAbs;
        int i = 0;
        if (str == null || str.length() == 0) {
            this.mDimensionRatio = 0.0f;
            return;
        }
        int length = str.length();
        int iIndexOf = str.indexOf(44);
        int i2 = 0;
        int i3 = -1;
        if (iIndexOf > 0 && iIndexOf < length - 1) {
            String strSubstring = str.substring(0, iIndexOf);
            if (!strSubstring.equalsIgnoreCase("W")) {
                i2 = strSubstring.equalsIgnoreCase("H") ? 1 : -1;
            }
            i3 = i2;
            i2 = iIndexOf + 1;
        }
        int iIndexOf2 = str.indexOf(58);
        try {
            if (iIndexOf2 >= 0 && iIndexOf2 < length - 1) {
                String strSubstring2 = str.substring(i2, iIndexOf2);
                String strSubstring3 = str.substring(iIndexOf2 + 1);
                if (strSubstring2.length() <= 0 || strSubstring3.length() <= 0) {
                    fAbs = 0.0f;
                } else {
                    float f = Float.parseFloat(strSubstring2);
                    float f2 = Float.parseFloat(strSubstring3);
                    if (f <= 0.0f || f2 <= 0.0f) {
                        fAbs = 0.0f;
                    } else if (i3 == 1) {
                        fAbs = Math.abs(f2 / f);
                    } else {
                        fAbs = Math.abs(f / f2);
                    }
                }
            } else {
                String strSubstring4 = str.substring(i2);
                if (strSubstring4.length() > 0) {
                    fAbs = Float.parseFloat(strSubstring4);
                } else {
                    fAbs = 0.0f;
                }
            }
        } catch (NumberFormatException unused) {
        }
        i = (fAbs > i ? 1 : (fAbs == i ? 0 : -1));
        if (i > 0) {
            this.mDimensionRatio = fAbs;
            this.mDimensionRatioSide = i3;
        }
    }

    public void setDimensionRatio(float f, int i) {
        this.mDimensionRatio = f;
        this.mDimensionRatioSide = i;
    }

    public float getDimensionRatio() {
        return this.mDimensionRatio;
    }

    public int getDimensionRatioSide() {
        return this.mDimensionRatioSide;
    }

    public void setHorizontalBiasPercent(float f) {
        this.mHorizontalBiasPercent = f;
    }

    public void setVerticalBiasPercent(float f) {
        this.mVerticalBiasPercent = f;
    }

    public void setMinWidth(int i) {
        if (i < 0) {
            this.mMinWidth = 0;
        } else {
            this.mMinWidth = i;
        }
    }

    public void setMinHeight(int i) {
        if (i < 0) {
            this.mMinHeight = 0;
        } else {
            this.mMinHeight = i;
        }
    }

    public void setDimension(int i, int i2) {
        this.mWidth = i;
        int i3 = this.mMinWidth;
        if (i < i3) {
            this.mWidth = i3;
        }
        this.mHeight = i2;
        int i4 = this.mMinHeight;
        if (i2 < i4) {
            this.mHeight = i4;
        }
    }

    public void setFrame(int i, int i2, int i3, int i4) {
        int i5;
        int i6;
        int i7 = i3 - i;
        int i8 = i4 - i2;
        this.f231mX = i;
        this.f232mY = i2;
        if (this.mVisibility == 8) {
            this.mWidth = 0;
            this.mHeight = 0;
            return;
        }
        if (this.mListDimensionBehaviors[0] == DimensionBehaviour.FIXED && i7 < (i6 = this.mWidth)) {
            i7 = i6;
        }
        if (this.mListDimensionBehaviors[1] == DimensionBehaviour.FIXED && i8 < (i5 = this.mHeight)) {
            i8 = i5;
        }
        this.mWidth = i7;
        this.mHeight = i8;
        int i9 = this.mMinHeight;
        if (i8 < i9) {
            this.mHeight = i9;
        }
        int i10 = this.mMinWidth;
        if (i7 < i10) {
            this.mWidth = i10;
        }
    }

    public void setFrame(int i, int i2, int i3) {
        if (i3 == 0) {
            setHorizontalDimension(i, i2);
        } else if (i3 == 1) {
            setVerticalDimension(i, i2);
        }
    }

    public void setHorizontalDimension(int i, int i2) {
        this.f231mX = i;
        int i3 = i2 - i;
        this.mWidth = i3;
        int i4 = this.mMinWidth;
        if (i3 < i4) {
            this.mWidth = i4;
        }
    }

    public void setVerticalDimension(int i, int i2) {
        this.f232mY = i;
        int i3 = i2 - i;
        this.mHeight = i3;
        int i4 = this.mMinHeight;
        if (i3 < i4) {
            this.mHeight = i4;
        }
    }

    int getRelativePositioning(int i) {
        if (i == 0) {
            return this.mRelX;
        }
        if (i == 1) {
            return this.mRelY;
        }
        return 0;
    }

    void setRelativePositioning(int i, int i2) {
        if (i2 == 0) {
            this.mRelX = i;
        } else if (i2 == 1) {
            this.mRelY = i;
        }
    }

    public void setBaselineDistance(int i) {
        this.mBaselineDistance = i;
        this.hasBaseline = i > 0;
    }

    public void setCompanionWidget(Object obj) {
        this.mCompanionWidget = obj;
    }

    public void setContainerItemSkip(int i) {
        if (i >= 0) {
            this.mContainerItemSkip = i;
        } else {
            this.mContainerItemSkip = 0;
        }
    }

    public int getContainerItemSkip() {
        return this.mContainerItemSkip;
    }

    public void setHorizontalWeight(float f) {
        this.mWeight[0] = f;
    }

    public void setVerticalWeight(float f) {
        this.mWeight[1] = f;
    }

    public void setHorizontalChainStyle(int i) {
        this.mHorizontalChainStyle = i;
    }

    public int getHorizontalChainStyle() {
        return this.mHorizontalChainStyle;
    }

    public void setVerticalChainStyle(int i) {
        this.mVerticalChainStyle = i;
    }

    public int getVerticalChainStyle() {
        return this.mVerticalChainStyle;
    }

    public boolean allowedInBarrier() {
        return this.mVisibility != 8;
    }

    public void immediateConnect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i, int i2) {
        getAnchor(type).connect(constraintWidget.getAnchor(type2), i, i2, true);
    }

    public void connect(ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i) {
        if (constraintAnchor.getOwner() == this) {
            connect(constraintAnchor.getType(), constraintAnchor2.getOwner(), constraintAnchor2.getType(), i);
        }
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2) {
        connect(type, constraintWidget, type2, 0);
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i) {
        boolean z;
        if (type == ConstraintAnchor.Type.CENTER) {
            if (type2 == ConstraintAnchor.Type.CENTER) {
                ConstraintAnchor anchor = getAnchor(ConstraintAnchor.Type.LEFT);
                ConstraintAnchor anchor2 = getAnchor(ConstraintAnchor.Type.RIGHT);
                ConstraintAnchor anchor3 = getAnchor(ConstraintAnchor.Type.TOP);
                ConstraintAnchor anchor4 = getAnchor(ConstraintAnchor.Type.BOTTOM);
                boolean z2 = true;
                if ((anchor == null || !anchor.isConnected()) && (anchor2 == null || !anchor2.isConnected())) {
                    connect(ConstraintAnchor.Type.LEFT, constraintWidget, ConstraintAnchor.Type.LEFT, 0);
                    connect(ConstraintAnchor.Type.RIGHT, constraintWidget, ConstraintAnchor.Type.RIGHT, 0);
                    z = true;
                } else {
                    z = false;
                }
                if ((anchor3 == null || !anchor3.isConnected()) && (anchor4 == null || !anchor4.isConnected())) {
                    connect(ConstraintAnchor.Type.TOP, constraintWidget, ConstraintAnchor.Type.TOP, 0);
                    connect(ConstraintAnchor.Type.BOTTOM, constraintWidget, ConstraintAnchor.Type.BOTTOM, 0);
                } else {
                    z2 = false;
                }
                if (z && z2) {
                    getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER), 0);
                    return;
                } else if (z) {
                    getAnchor(ConstraintAnchor.Type.CENTER_X).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER_X), 0);
                    return;
                } else {
                    if (z2) {
                        getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER_Y), 0);
                        return;
                    }
                    return;
                }
            }
            if (type2 == ConstraintAnchor.Type.LEFT || type2 == ConstraintAnchor.Type.RIGHT) {
                connect(ConstraintAnchor.Type.LEFT, constraintWidget, type2, 0);
                connect(ConstraintAnchor.Type.RIGHT, constraintWidget, type2, 0);
                getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(type2), 0);
                return;
            } else {
                if (type2 == ConstraintAnchor.Type.TOP || type2 == ConstraintAnchor.Type.BOTTOM) {
                    connect(ConstraintAnchor.Type.TOP, constraintWidget, type2, 0);
                    connect(ConstraintAnchor.Type.BOTTOM, constraintWidget, type2, 0);
                    getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(type2), 0);
                    return;
                }
                return;
            }
        }
        if (type == ConstraintAnchor.Type.CENTER_X && (type2 == ConstraintAnchor.Type.LEFT || type2 == ConstraintAnchor.Type.RIGHT)) {
            ConstraintAnchor anchor5 = getAnchor(ConstraintAnchor.Type.LEFT);
            ConstraintAnchor anchor6 = constraintWidget.getAnchor(type2);
            ConstraintAnchor anchor7 = getAnchor(ConstraintAnchor.Type.RIGHT);
            anchor5.connect(anchor6, 0);
            anchor7.connect(anchor6, 0);
            getAnchor(ConstraintAnchor.Type.CENTER_X).connect(anchor6, 0);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_Y && (type2 == ConstraintAnchor.Type.TOP || type2 == ConstraintAnchor.Type.BOTTOM)) {
            ConstraintAnchor anchor8 = constraintWidget.getAnchor(type2);
            getAnchor(ConstraintAnchor.Type.TOP).connect(anchor8, 0);
            getAnchor(ConstraintAnchor.Type.BOTTOM).connect(anchor8, 0);
            getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(anchor8, 0);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_X && type2 == ConstraintAnchor.Type.CENTER_X) {
            getAnchor(ConstraintAnchor.Type.LEFT).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.LEFT), 0);
            getAnchor(ConstraintAnchor.Type.RIGHT).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.RIGHT), 0);
            getAnchor(ConstraintAnchor.Type.CENTER_X).connect(constraintWidget.getAnchor(type2), 0);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_Y && type2 == ConstraintAnchor.Type.CENTER_Y) {
            getAnchor(ConstraintAnchor.Type.TOP).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.TOP), 0);
            getAnchor(ConstraintAnchor.Type.BOTTOM).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.BOTTOM), 0);
            getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(constraintWidget.getAnchor(type2), 0);
            return;
        }
        ConstraintAnchor anchor9 = getAnchor(type);
        ConstraintAnchor anchor10 = constraintWidget.getAnchor(type2);
        if (anchor9.isValidConnection(anchor10)) {
            if (type == ConstraintAnchor.Type.BASELINE) {
                ConstraintAnchor anchor11 = getAnchor(ConstraintAnchor.Type.TOP);
                ConstraintAnchor anchor12 = getAnchor(ConstraintAnchor.Type.BOTTOM);
                if (anchor11 != null) {
                    anchor11.reset();
                }
                if (anchor12 != null) {
                    anchor12.reset();
                }
                i = 0;
            } else if (type == ConstraintAnchor.Type.TOP || type == ConstraintAnchor.Type.BOTTOM) {
                ConstraintAnchor anchor13 = getAnchor(ConstraintAnchor.Type.BASELINE);
                if (anchor13 != null) {
                    anchor13.reset();
                }
                ConstraintAnchor anchor14 = getAnchor(ConstraintAnchor.Type.CENTER);
                if (anchor14.getTarget() != anchor10) {
                    anchor14.reset();
                }
                ConstraintAnchor opposite = getAnchor(type).getOpposite();
                ConstraintAnchor anchor15 = getAnchor(ConstraintAnchor.Type.CENTER_Y);
                if (anchor15.isConnected()) {
                    opposite.reset();
                    anchor15.reset();
                }
            } else if (type == ConstraintAnchor.Type.LEFT || type == ConstraintAnchor.Type.RIGHT) {
                ConstraintAnchor anchor16 = getAnchor(ConstraintAnchor.Type.CENTER);
                if (anchor16.getTarget() != anchor10) {
                    anchor16.reset();
                }
                ConstraintAnchor opposite2 = getAnchor(type).getOpposite();
                ConstraintAnchor anchor17 = getAnchor(ConstraintAnchor.Type.CENTER_X);
                if (anchor17.isConnected()) {
                    opposite2.reset();
                    anchor17.reset();
                }
            }
            anchor9.connect(anchor10, i);
        }
    }

    public void resetAllConstraints() {
        resetAnchors();
        setVerticalBiasPercent(DEFAULT_BIAS);
        setHorizontalBiasPercent(DEFAULT_BIAS);
    }

    public void resetAnchor(ConstraintAnchor constraintAnchor) {
        if (getParent() != null && (getParent() instanceof ConstraintWidgetContainer) && ((ConstraintWidgetContainer) getParent()).handlesInternalConstraints()) {
            return;
        }
        ConstraintAnchor anchor = getAnchor(ConstraintAnchor.Type.LEFT);
        ConstraintAnchor anchor2 = getAnchor(ConstraintAnchor.Type.RIGHT);
        ConstraintAnchor anchor3 = getAnchor(ConstraintAnchor.Type.TOP);
        ConstraintAnchor anchor4 = getAnchor(ConstraintAnchor.Type.BOTTOM);
        ConstraintAnchor anchor5 = getAnchor(ConstraintAnchor.Type.CENTER);
        ConstraintAnchor anchor6 = getAnchor(ConstraintAnchor.Type.CENTER_X);
        ConstraintAnchor anchor7 = getAnchor(ConstraintAnchor.Type.CENTER_Y);
        if (constraintAnchor == anchor5) {
            if (anchor.isConnected() && anchor2.isConnected() && anchor.getTarget() == anchor2.getTarget()) {
                anchor.reset();
                anchor2.reset();
            }
            if (anchor3.isConnected() && anchor4.isConnected() && anchor3.getTarget() == anchor4.getTarget()) {
                anchor3.reset();
                anchor4.reset();
            }
            this.mHorizontalBiasPercent = 0.5f;
            this.mVerticalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor6) {
            if (anchor.isConnected() && anchor2.isConnected() && anchor.getTarget().getOwner() == anchor2.getTarget().getOwner()) {
                anchor.reset();
                anchor2.reset();
            }
            this.mHorizontalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor7) {
            if (anchor3.isConnected() && anchor4.isConnected() && anchor3.getTarget().getOwner() == anchor4.getTarget().getOwner()) {
                anchor3.reset();
                anchor4.reset();
            }
            this.mVerticalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor || constraintAnchor == anchor2) {
            if (anchor.isConnected() && anchor.getTarget() == anchor2.getTarget()) {
                anchor5.reset();
            }
        } else if ((constraintAnchor == anchor3 || constraintAnchor == anchor4) && anchor3.isConnected() && anchor3.getTarget() == anchor4.getTarget()) {
            anchor5.reset();
        }
        constraintAnchor.reset();
    }

    public void resetAnchors() {
        ConstraintWidget parent = getParent();
        if (parent != null && (parent instanceof ConstraintWidgetContainer) && ((ConstraintWidgetContainer) getParent()).handlesInternalConstraints()) {
            return;
        }
        int size = this.mAnchors.size();
        for (int i = 0; i < size; i++) {
            this.mAnchors.get(i).reset();
        }
    }

    public ConstraintAnchor getAnchor(ConstraintAnchor.Type type) {
        switch (C00261.f233x4c44d048[type.ordinal()]) {
            case 1:
                return this.mLeft;
            case 2:
                return this.mTop;
            case 3:
                return this.mRight;
            case 4:
                return this.mBottom;
            case 5:
                return this.mBaseline;
            case 6:
                return this.mCenter;
            case 7:
                return this.mCenterX;
            case 8:
                return this.mCenterY;
            case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_LEFT_TO_RIGHT_OF /* 9 */:
                return null;
            default:
                throw new AssertionError(type.name());
        }
    }

    public DimensionBehaviour getHorizontalDimensionBehaviour() {
        return this.mListDimensionBehaviors[0];
    }

    public DimensionBehaviour getVerticalDimensionBehaviour() {
        return this.mListDimensionBehaviors[1];
    }

    public DimensionBehaviour getDimensionBehaviour(int i) {
        if (i == 0) {
            return getHorizontalDimensionBehaviour();
        }
        if (i == 1) {
            return getVerticalDimensionBehaviour();
        }
        return null;
    }

    public void setHorizontalDimensionBehaviour(DimensionBehaviour dimensionBehaviour) {
        this.mListDimensionBehaviors[0] = dimensionBehaviour;
    }

    public void setVerticalDimensionBehaviour(DimensionBehaviour dimensionBehaviour) {
        this.mListDimensionBehaviors[1] = dimensionBehaviour;
    }

    public boolean isInHorizontalChain() {
        if (this.mLeft.mTarget == null || this.mLeft.mTarget.mTarget != this.mLeft) {
            return this.mRight.mTarget != null && this.mRight.mTarget.mTarget == this.mRight;
        }
        return true;
    }

    public ConstraintWidget getPreviousChainMember(int i) {
        if (i == 0) {
            if (this.mLeft.mTarget == null) {
                return null;
            }
            ConstraintAnchor constraintAnchor = this.mLeft.mTarget.mTarget;
            ConstraintAnchor constraintAnchor2 = this.mLeft;
            if (constraintAnchor == constraintAnchor2) {
                return constraintAnchor2.mTarget.mOwner;
            }
            return null;
        }
        if (i != 1 || this.mTop.mTarget == null) {
            return null;
        }
        ConstraintAnchor constraintAnchor3 = this.mTop.mTarget.mTarget;
        ConstraintAnchor constraintAnchor4 = this.mTop;
        if (constraintAnchor3 == constraintAnchor4) {
            return constraintAnchor4.mTarget.mOwner;
        }
        return null;
    }

    public ConstraintWidget getNextChainMember(int i) {
        if (i == 0) {
            if (this.mRight.mTarget == null) {
                return null;
            }
            ConstraintAnchor constraintAnchor = this.mRight.mTarget.mTarget;
            ConstraintAnchor constraintAnchor2 = this.mRight;
            if (constraintAnchor == constraintAnchor2) {
                return constraintAnchor2.mTarget.mOwner;
            }
            return null;
        }
        if (i != 1 || this.mBottom.mTarget == null) {
            return null;
        }
        ConstraintAnchor constraintAnchor3 = this.mBottom.mTarget.mTarget;
        ConstraintAnchor constraintAnchor4 = this.mBottom;
        if (constraintAnchor3 == constraintAnchor4) {
            return constraintAnchor4.mTarget.mOwner;
        }
        return null;
    }

    public ConstraintWidget getHorizontalChainControlWidget() {
        if (!isInHorizontalChain()) {
            return null;
        }
        ConstraintWidget constraintWidget = this;
        ConstraintWidget constraintWidget2 = null;
        while (constraintWidget2 == null && constraintWidget != null) {
            ConstraintAnchor anchor = constraintWidget.getAnchor(ConstraintAnchor.Type.LEFT);
            ConstraintAnchor target = anchor == null ? null : anchor.getTarget();
            ConstraintWidget owner = target == null ? null : target.getOwner();
            if (owner == getParent()) {
                return constraintWidget;
            }
            ConstraintAnchor target2 = owner == null ? null : owner.getAnchor(ConstraintAnchor.Type.RIGHT).getTarget();
            if (target2 == null || target2.getOwner() == constraintWidget) {
                constraintWidget = owner;
            } else {
                constraintWidget2 = constraintWidget;
            }
        }
        return constraintWidget2;
    }

    public boolean isInVerticalChain() {
        if (this.mTop.mTarget == null || this.mTop.mTarget.mTarget != this.mTop) {
            return this.mBottom.mTarget != null && this.mBottom.mTarget.mTarget == this.mBottom;
        }
        return true;
    }

    public ConstraintWidget getVerticalChainControlWidget() {
        if (!isInVerticalChain()) {
            return null;
        }
        ConstraintWidget constraintWidget = this;
        ConstraintWidget constraintWidget2 = null;
        while (constraintWidget2 == null && constraintWidget != null) {
            ConstraintAnchor anchor = constraintWidget.getAnchor(ConstraintAnchor.Type.TOP);
            ConstraintAnchor target = anchor == null ? null : anchor.getTarget();
            ConstraintWidget owner = target == null ? null : target.getOwner();
            if (owner == getParent()) {
                return constraintWidget;
            }
            ConstraintAnchor target2 = owner == null ? null : owner.getAnchor(ConstraintAnchor.Type.BOTTOM).getTarget();
            if (target2 == null || target2.getOwner() == constraintWidget) {
                constraintWidget = owner;
            } else {
                constraintWidget2 = constraintWidget;
            }
        }
        return constraintWidget2;
    }

    private boolean isChainHead(int i) {
        int i2 = i * 2;
        if (this.mListAnchors[i2].mTarget != null) {
            ConstraintAnchor constraintAnchor = this.mListAnchors[i2].mTarget.mTarget;
            ConstraintAnchor[] constraintAnchorArr = this.mListAnchors;
            if (constraintAnchor != constraintAnchorArr[i2]) {
                int i3 = i2 + 1;
                if (constraintAnchorArr[i3].mTarget != null && this.mListAnchors[i3].mTarget.mTarget == this.mListAnchors[i3]) {
                    return true;
                }
            }
        }
        return false;
    }

    /* JADX WARN: Code duplicated, block: B:198:0x03f8  */
    /* JADX WARN: Code duplicated, block: B:201:0x040a  */
    /* JADX WARN: Code duplicated, block: B:202:0x040c  */
    /* JADX WARN: Code duplicated, block: B:204:0x040f  */
    /* JADX WARN: Code duplicated, block: B:209:0x041e  */
    /* JADX WARN: Code duplicated, block: B:211:0x0422  */
    /* JADX WARN: Code duplicated, block: B:218:0x0430  */
    /* JADX WARN: Code duplicated, block: B:221:0x0436  */
    /* JADX WARN: Code duplicated, block: B:222:0x043d  */
    /* JADX WARN: Code duplicated, block: B:225:0x0443  */
    /* JADX WARN: Code duplicated, block: B:230:0x0453  */
    /* JADX WARN: Code duplicated, block: B:232:0x0460  */
    /* JADX WARN: Code duplicated, block: B:234:0x046d  */
    /* JADX WARN: Code duplicated, block: B:236:0x047a  */
    /* JADX WARN: Code duplicated, block: B:238:0x047e  */
    /* JADX WARN: Code duplicated, block: B:241:0x04ce  */
    /* JADX WARN: Code duplicated, block: B:243:0x04d4  */
    /* JADX WARN: Code duplicated, block: B:245:0x04dd  */
    /* JADX WARN: Code duplicated, block: B:246:0x04ed  */
    /* JADX WARN: Code duplicated, block: B:247:0x04ff  */
    /* JADX WARN: Code duplicated, block: B:250:0x0509  */
    /* JADX WARN: Code duplicated, block: B:256:? A[RETURN, SYNTHETIC] */
    public void addToSolver(LinearSystem linearSystem) {
        boolean z;
        boolean z2;
        boolean z3;
        boolean z4;
        SolverVariable solverVariable;
        int i;
        int i2;
        int i3;
        boolean z5;
        boolean z6;
        boolean z7;
        LinearSystem linearSystem2;
        SolverVariable solverVariable2;
        SolverVariable solverVariable3;
        SolverVariable solverVariable4;
        int i4;
        int i5;
        int i6;
        boolean z8;
        boolean z9;
        ConstraintWidget constraintWidget;
        boolean z10;
        boolean z11;
        ConstraintWidget constraintWidget2;
        SolverVariable solverVariableCreateObjectVariable;
        boolean z12;
        int i7;
        int i8;
        boolean zIsInHorizontalChain;
        boolean zIsInVerticalChain;
        ConstraintWidget constraintWidget3 = this;
        SolverVariable solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(constraintWidget3.mLeft);
        SolverVariable solverVariableCreateObjectVariable3 = linearSystem.createObjectVariable(constraintWidget3.mRight);
        SolverVariable solverVariableCreateObjectVariable4 = linearSystem.createObjectVariable(constraintWidget3.mTop);
        SolverVariable solverVariableCreateObjectVariable5 = linearSystem.createObjectVariable(constraintWidget3.mBottom);
        SolverVariable solverVariableCreateObjectVariable6 = linearSystem.createObjectVariable(constraintWidget3.mBaseline);
        if (LinearSystem.sMetrics != null) {
            LinearSystem.sMetrics.widgets++;
        }
        if (constraintWidget3.horizontalRun.start.resolved && constraintWidget3.horizontalRun.end.resolved && constraintWidget3.verticalRun.start.resolved && constraintWidget3.verticalRun.end.resolved) {
            if (LinearSystem.sMetrics != null) {
                LinearSystem.sMetrics.graphSolved++;
            }
            linearSystem.addEquality(solverVariableCreateObjectVariable2, constraintWidget3.horizontalRun.start.value);
            linearSystem.addEquality(solverVariableCreateObjectVariable3, constraintWidget3.horizontalRun.end.value);
            linearSystem.addEquality(solverVariableCreateObjectVariable4, constraintWidget3.verticalRun.start.value);
            linearSystem.addEquality(solverVariableCreateObjectVariable5, constraintWidget3.verticalRun.end.value);
            linearSystem.addEquality(solverVariableCreateObjectVariable6, constraintWidget3.verticalRun.baseline.value);
            ConstraintWidget constraintWidget4 = constraintWidget3.mParent;
            if (constraintWidget4 != null) {
                boolean z13 = constraintWidget4 != null && constraintWidget4.mListDimensionBehaviors[0] == DimensionBehaviour.WRAP_CONTENT;
                ConstraintWidget constraintWidget5 = constraintWidget3.mParent;
                boolean z14 = constraintWidget5 != null && constraintWidget5.mListDimensionBehaviors[1] == DimensionBehaviour.WRAP_CONTENT;
                if (z13 && constraintWidget3.isTerminalWidget[0] && !isInHorizontalChain()) {
                    linearSystem.addGreaterThan(linearSystem.createObjectVariable(constraintWidget3.mParent.mRight), solverVariableCreateObjectVariable3, 0, 8);
                }
                if (z14 && constraintWidget3.isTerminalWidget[1] && !isInVerticalChain()) {
                    linearSystem.addGreaterThan(linearSystem.createObjectVariable(constraintWidget3.mParent.mBottom), solverVariableCreateObjectVariable5, 0, 8);
                    return;
                }
                return;
            }
            return;
        }
        if (LinearSystem.sMetrics != null) {
            LinearSystem.sMetrics.linearSolved++;
        }
        ConstraintWidget constraintWidget6 = constraintWidget3.mParent;
        if (constraintWidget6 != null) {
            boolean z15 = constraintWidget6 != null && constraintWidget6.mListDimensionBehaviors[0] == DimensionBehaviour.WRAP_CONTENT;
            ConstraintWidget constraintWidget7 = constraintWidget3.mParent;
            boolean z16 = constraintWidget7 != null && constraintWidget7.mListDimensionBehaviors[1] == DimensionBehaviour.WRAP_CONTENT;
            if (constraintWidget3.isChainHead(0)) {
                ((ConstraintWidgetContainer) constraintWidget3.mParent).addChain(constraintWidget3, 0);
                zIsInHorizontalChain = true;
            } else {
                zIsInHorizontalChain = isInHorizontalChain();
            }
            if (constraintWidget3.isChainHead(1)) {
                ((ConstraintWidgetContainer) constraintWidget3.mParent).addChain(constraintWidget3, 1);
                zIsInVerticalChain = true;
            } else {
                zIsInVerticalChain = isInVerticalChain();
            }
            if (!zIsInHorizontalChain && z15 && constraintWidget3.mVisibility != 8 && constraintWidget3.mLeft.mTarget == null && constraintWidget3.mRight.mTarget == null) {
                linearSystem.addGreaterThan(linearSystem.createObjectVariable(constraintWidget3.mParent.mRight), solverVariableCreateObjectVariable3, 0, 1);
            }
            if (!zIsInVerticalChain && z16 && constraintWidget3.mVisibility != 8 && constraintWidget3.mTop.mTarget == null && constraintWidget3.mBottom.mTarget == null && constraintWidget3.mBaseline == null) {
                linearSystem.addGreaterThan(linearSystem.createObjectVariable(constraintWidget3.mParent.mBottom), solverVariableCreateObjectVariable5, 0, 1);
            }
            z2 = z15;
            z = z16;
            z4 = zIsInHorizontalChain;
            z3 = zIsInVerticalChain;
        } else {
            z = false;
            z2 = false;
            z3 = false;
            z4 = false;
        }
        int i9 = constraintWidget3.mWidth;
        int i10 = constraintWidget3.mMinWidth;
        if (i9 < i10) {
            i9 = i10;
        }
        int i11 = constraintWidget3.mHeight;
        int i12 = constraintWidget3.mMinHeight;
        if (i11 < i12) {
            i11 = i12;
        }
        boolean z17 = constraintWidget3.mListDimensionBehaviors[0] != DimensionBehaviour.MATCH_CONSTRAINT;
        boolean z18 = constraintWidget3.mListDimensionBehaviors[1] != DimensionBehaviour.MATCH_CONSTRAINT;
        constraintWidget3.mResolvedDimensionRatioSide = constraintWidget3.mDimensionRatioSide;
        float f = constraintWidget3.mDimensionRatio;
        constraintWidget3.mResolvedDimensionRatio = f;
        int i13 = constraintWidget3.mMatchConstraintDefaultWidth;
        int i14 = constraintWidget3.mMatchConstraintDefaultHeight;
        int i15 = i9;
        if (f <= 0.0f || constraintWidget3.mVisibility == 8) {
            solverVariable = solverVariableCreateObjectVariable6;
            i = i11;
            i2 = i14;
            i13 = i13;
            i3 = i15;
            z5 = false;
        } else {
            solverVariable = solverVariableCreateObjectVariable6;
            if (constraintWidget3.mListDimensionBehaviors[0] == DimensionBehaviour.MATCH_CONSTRAINT && i13 == 0) {
                i13 = 3;
            }
            if (constraintWidget3.mListDimensionBehaviors[1] == DimensionBehaviour.MATCH_CONSTRAINT && i14 == 0) {
                i14 = 3;
            }
            if (constraintWidget3.mListDimensionBehaviors[0] == DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget3.mListDimensionBehaviors[1] == DimensionBehaviour.MATCH_CONSTRAINT && i13 == 3 && i14 == 3) {
                constraintWidget3.setupDimensionRatio(z2, z, z17, z18);
            } else if (constraintWidget3.mListDimensionBehaviors[0] == DimensionBehaviour.MATCH_CONSTRAINT && i13 == 3) {
                constraintWidget3.mResolvedDimensionRatioSide = 0;
                i3 = (int) (constraintWidget3.mResolvedDimensionRatio * constraintWidget3.mHeight);
                i = i11;
                i2 = i14;
                if (constraintWidget3.mListDimensionBehaviors[1] != DimensionBehaviour.MATCH_CONSTRAINT) {
                    z5 = false;
                    i13 = 4;
                } else {
                    z5 = true;
                }
            } else if (constraintWidget3.mListDimensionBehaviors[1] == DimensionBehaviour.MATCH_CONSTRAINT && i14 == 3) {
                constraintWidget3.mResolvedDimensionRatioSide = 1;
                if (constraintWidget3.mDimensionRatioSide == -1) {
                    constraintWidget3.mResolvedDimensionRatio = 1.0f / constraintWidget3.mResolvedDimensionRatio;
                }
                i11 = (int) (constraintWidget3.mResolvedDimensionRatio * constraintWidget3.mWidth);
                if (constraintWidget3.mListDimensionBehaviors[0] != DimensionBehaviour.MATCH_CONSTRAINT) {
                    i = i11;
                    i13 = i13;
                    i3 = i15;
                    z5 = false;
                    i2 = 4;
                }
            }
            i = i11;
            i2 = i14;
            i3 = i15;
            z5 = true;
        }
        int[] iArr = constraintWidget3.mResolvedMatchConstraintDefault;
        iArr[0] = i13;
        iArr[1] = i2;
        constraintWidget3.mResolvedHasRatio = z5;
        boolean z19 = z5 && ((i8 = constraintWidget3.mResolvedDimensionRatioSide) == 0 || i8 == -1);
        boolean z20 = constraintWidget3.mListDimensionBehaviors[0] == DimensionBehaviour.WRAP_CONTENT && (constraintWidget3 instanceof ConstraintWidgetContainer);
        int i16 = z20 ? 0 : i3;
        boolean z21 = !constraintWidget3.mCenter.isConnected();
        boolean[] zArr = constraintWidget3.mIsInBarrier;
        boolean z22 = zArr[0];
        boolean z23 = zArr[1];
        if (constraintWidget3.mHorizontalResolution != 2) {
            if (!constraintWidget3.horizontalRun.start.resolved || !constraintWidget3.horizontalRun.end.resolved) {
                ConstraintWidget constraintWidget8 = constraintWidget3.mParent;
                SolverVariable solverVariableCreateObjectVariable7 = constraintWidget8 != null ? linearSystem.createObjectVariable(constraintWidget8.mRight) : null;
                ConstraintWidget constraintWidget9 = constraintWidget3.mParent;
                z6 = z;
                z7 = z2;
                applyConstraints(linearSystem, true, z7, z6, constraintWidget3.isTerminalWidget[0], constraintWidget9 != null ? linearSystem.createObjectVariable(constraintWidget9.mLeft) : null, solverVariableCreateObjectVariable7, constraintWidget3.mListDimensionBehaviors[0], z20, constraintWidget3.mLeft, constraintWidget3.mRight, constraintWidget3.f231mX, i16, constraintWidget3.mMinWidth, constraintWidget3.mMaxDimension[0], constraintWidget3.mHorizontalBiasPercent, z19, z4, z3, z22, i13, i2, constraintWidget3.mMatchConstraintMinWidth, constraintWidget3.mMatchConstraintMaxWidth, constraintWidget3.mMatchConstraintPercentWidth, z21);
            } else {
                linearSystem.addEquality(solverVariableCreateObjectVariable2, constraintWidget3.horizontalRun.start.value);
                linearSystem.addEquality(solverVariableCreateObjectVariable3, constraintWidget3.horizontalRun.end.value);
                if (constraintWidget3.mParent != null && z2 && constraintWidget3.isTerminalWidget[0] && !isInHorizontalChain()) {
                    linearSystem.addGreaterThan(linearSystem.createObjectVariable(constraintWidget3.mParent.mRight), solverVariableCreateObjectVariable3, 0, 8);
                }
                z6 = z;
                z5 = z5;
                solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                solverVariableCreateObjectVariable3 = solverVariableCreateObjectVariable3;
                solverVariableCreateObjectVariable2 = solverVariableCreateObjectVariable2;
                z7 = z2;
                solverVariable = solverVariable;
            }
            if (constraintWidget3.verticalRun.start.resolved || !constraintWidget3.verticalRun.end.resolved) {
                linearSystem2 = linearSystem;
                solverVariable2 = solverVariable;
                solverVariable3 = solverVariableCreateObjectVariable5;
                solverVariable4 = solverVariableCreateObjectVariable4;
                i4 = 8;
                i5 = 0;
                i6 = 1;
                z8 = true;
            } else {
                linearSystem2 = linearSystem;
                solverVariable4 = solverVariableCreateObjectVariable4;
                linearSystem2.addEquality(solverVariable4, constraintWidget3.verticalRun.start.value);
                solverVariable3 = solverVariableCreateObjectVariable5;
                linearSystem2.addEquality(solverVariable3, constraintWidget3.verticalRun.end.value);
                solverVariable2 = solverVariable;
                linearSystem2.addEquality(solverVariable2, constraintWidget3.verticalRun.baseline.value);
                ConstraintWidget constraintWidget10 = constraintWidget3.mParent;
                if (constraintWidget10 == null || z3 || !z6) {
                    i4 = 8;
                    i5 = 0;
                    i6 = 1;
                } else {
                    i6 = 1;
                    if (constraintWidget3.isTerminalWidget[1]) {
                        i4 = 8;
                        i5 = 0;
                        linearSystem2.addGreaterThan(linearSystem2.createObjectVariable(constraintWidget10.mBottom), solverVariable3, 0, 8);
                    } else {
                        i4 = 8;
                        i5 = 0;
                    }
                }
                z8 = false;
            }
            if (constraintWidget3.mVerticalResolution == 2) {
                z9 = false;
            } else {
                z9 = z8;
            }
            if (!z9) {
                if (constraintWidget3.mListDimensionBehaviors[i6] == DimensionBehaviour.WRAP_CONTENT || !(constraintWidget3 instanceof ConstraintWidgetContainer)) {
                    z10 = false;
                } else {
                    z10 = true;
                }
                if (z10) {
                    i = 0;
                }
                if (z5 || !((i7 = constraintWidget3.mResolvedDimensionRatioSide) == i6 || i7 == -1)) {
                    z11 = false;
                } else {
                    z11 = true;
                }
                constraintWidget2 = constraintWidget3.mParent;
                if (constraintWidget2 != null) {
                    solverVariableCreateObjectVariable = linearSystem2.createObjectVariable(constraintWidget2.mBottom);
                } else {
                    solverVariableCreateObjectVariable = null;
                }
                ConstraintWidget constraintWidget11 = constraintWidget3.mParent;
                SolverVariable solverVariableCreateObjectVariable8 = constraintWidget11 != null ? linearSystem2.createObjectVariable(constraintWidget11.mTop) : null;
                if (constraintWidget3.mBaselineDistance <= 0 || constraintWidget3.mVisibility == i4) {
                    linearSystem2.addEquality(solverVariable2, solverVariable4, getBaselineDistance(), i4);
                    if (constraintWidget3.mBaseline.mTarget != null) {
                        linearSystem2.addEquality(solverVariable2, linearSystem2.createObjectVariable(constraintWidget3.mBaseline.mTarget), i5, i4);
                        if (z6) {
                            linearSystem2.addGreaterThan(solverVariableCreateObjectVariable, linearSystem2.createObjectVariable(constraintWidget3.mBottom), i5, 5);
                        }
                        z12 = false;
                    } else {
                        if (constraintWidget3.mVisibility == i4) {
                            linearSystem2.addEquality(solverVariable2, solverVariable4, i5, i4);
                        }
                        z12 = z21;
                    }
                } else {
                    z12 = z21;
                }
                applyConstraints(linearSystem, false, z6, z7, constraintWidget3.isTerminalWidget[i6], solverVariableCreateObjectVariable8, solverVariableCreateObjectVariable, constraintWidget3.mListDimensionBehaviors[i6], z10, constraintWidget3.mTop, constraintWidget3.mBottom, constraintWidget3.f232mY, i, constraintWidget3.mMinHeight, constraintWidget3.mMaxDimension[i6], constraintWidget3.mVerticalBiasPercent, z11, z3, z4, z23, i2, i13, constraintWidget3.mMatchConstraintMinHeight, constraintWidget3.mMatchConstraintMaxHeight, constraintWidget3.mMatchConstraintPercentHeight, z12);
            }
            if (z5) {
                constraintWidget = this;
                if (constraintWidget.mResolvedDimensionRatioSide == 1) {
                    linearSystem.addRatio(solverVariable3, solverVariable4, solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, constraintWidget.mResolvedDimensionRatio, 8);
                } else {
                    linearSystem.addRatio(solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, solverVariable3, solverVariable4, constraintWidget.mResolvedDimensionRatio, 8);
                }
            } else {
                constraintWidget = this;
            }
            if (constraintWidget.mCenter.isConnected()) {
                linearSystem.addCenterPoint(constraintWidget, constraintWidget.mCenter.getTarget().getOwner(), (float) Math.toRadians(constraintWidget.mCircleConstraintAngle + 90.0f), constraintWidget.mCenter.getMargin());
            }
        }
        z6 = z;
        z7 = z2;
        constraintWidget3 = this;
        if (constraintWidget3.verticalRun.start.resolved) {
            linearSystem2 = linearSystem;
            solverVariable2 = solverVariable;
            solverVariable3 = solverVariableCreateObjectVariable5;
            solverVariable4 = solverVariableCreateObjectVariable4;
            i4 = 8;
            i5 = 0;
            i6 = 1;
            z8 = true;
        } else {
            linearSystem2 = linearSystem;
            solverVariable2 = solverVariable;
            solverVariable3 = solverVariableCreateObjectVariable5;
            solverVariable4 = solverVariableCreateObjectVariable4;
            i4 = 8;
            i5 = 0;
            i6 = 1;
            z8 = true;
        }
        if (constraintWidget3.mVerticalResolution == 2) {
            z9 = false;
        } else {
            z9 = z8;
        }
        if (!z9) {
            if (constraintWidget3.mListDimensionBehaviors[i6] == DimensionBehaviour.WRAP_CONTENT) {
                z10 = false;
            } else {
                z10 = false;
            }
            if (z10) {
                i = 0;
            }
            if (z5) {
                z11 = false;
            } else {
                z11 = false;
            }
            constraintWidget2 = constraintWidget3.mParent;
            if (constraintWidget2 != null) {
                solverVariableCreateObjectVariable = linearSystem2.createObjectVariable(constraintWidget2.mBottom);
            } else {
                solverVariableCreateObjectVariable = null;
            }
            ConstraintWidget constraintWidget12 = constraintWidget3.mParent;
            if (constraintWidget12 != null) {
            }
            if (constraintWidget3.mBaselineDistance <= 0) {
                linearSystem2.addEquality(solverVariable2, solverVariable4, getBaselineDistance(), i4);
                if (constraintWidget3.mBaseline.mTarget != null) {
                    linearSystem2.addEquality(solverVariable2, linearSystem2.createObjectVariable(constraintWidget3.mBaseline.mTarget), i5, i4);
                    if (z6) {
                        linearSystem2.addGreaterThan(solverVariableCreateObjectVariable, linearSystem2.createObjectVariable(constraintWidget3.mBottom), i5, 5);
                    }
                    z12 = false;
                } else {
                    if (constraintWidget3.mVisibility == i4) {
                        linearSystem2.addEquality(solverVariable2, solverVariable4, i5, i4);
                    }
                    z12 = z21;
                }
            } else {
                linearSystem2.addEquality(solverVariable2, solverVariable4, getBaselineDistance(), i4);
                if (constraintWidget3.mBaseline.mTarget != null) {
                    linearSystem2.addEquality(solverVariable2, linearSystem2.createObjectVariable(constraintWidget3.mBaseline.mTarget), i5, i4);
                    if (z6) {
                        linearSystem2.addGreaterThan(solverVariableCreateObjectVariable, linearSystem2.createObjectVariable(constraintWidget3.mBottom), i5, 5);
                    }
                    z12 = false;
                } else {
                    if (constraintWidget3.mVisibility == i4) {
                        linearSystem2.addEquality(solverVariable2, solverVariable4, i5, i4);
                    }
                    z12 = z21;
                }
            }
            applyConstraints(linearSystem, false, z6, z7, constraintWidget3.isTerminalWidget[i6], solverVariableCreateObjectVariable8, solverVariableCreateObjectVariable, constraintWidget3.mListDimensionBehaviors[i6], z10, constraintWidget3.mTop, constraintWidget3.mBottom, constraintWidget3.f232mY, i, constraintWidget3.mMinHeight, constraintWidget3.mMaxDimension[i6], constraintWidget3.mVerticalBiasPercent, z11, z3, z4, z23, i2, i13, constraintWidget3.mMatchConstraintMinHeight, constraintWidget3.mMatchConstraintMaxHeight, constraintWidget3.mMatchConstraintPercentHeight, z12);
        }
        if (z5) {
            constraintWidget = this;
            if (constraintWidget.mResolvedDimensionRatioSide == 1) {
                linearSystem.addRatio(solverVariable3, solverVariable4, solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, constraintWidget.mResolvedDimensionRatio, 8);
            } else {
                linearSystem.addRatio(solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, solverVariable3, solverVariable4, constraintWidget.mResolvedDimensionRatio, 8);
            }
        } else {
            constraintWidget = this;
        }
        if (constraintWidget.mCenter.isConnected()) {
            linearSystem.addCenterPoint(constraintWidget, constraintWidget.mCenter.getTarget().getOwner(), (float) Math.toRadians(constraintWidget.mCircleConstraintAngle + 90.0f), constraintWidget.mCenter.getMargin());
        }
    }

    boolean addFirst() {
        return (this instanceof VirtualLayout) || (this instanceof Guideline);
    }

    public void setupDimensionRatio(boolean z, boolean z2, boolean z3, boolean z4) {
        if (this.mResolvedDimensionRatioSide == -1) {
            if (z3 && !z4) {
                this.mResolvedDimensionRatioSide = 0;
            } else if (!z3 && z4) {
                this.mResolvedDimensionRatioSide = 1;
                if (this.mDimensionRatioSide == -1) {
                    this.mResolvedDimensionRatio = 1.0f / this.mResolvedDimensionRatio;
                }
            }
        }
        if (this.mResolvedDimensionRatioSide == 0 && (!this.mTop.isConnected() || !this.mBottom.isConnected())) {
            this.mResolvedDimensionRatioSide = 1;
        } else if (this.mResolvedDimensionRatioSide == 1 && (!this.mLeft.isConnected() || !this.mRight.isConnected())) {
            this.mResolvedDimensionRatioSide = 0;
        }
        if (this.mResolvedDimensionRatioSide == -1 && (!this.mTop.isConnected() || !this.mBottom.isConnected() || !this.mLeft.isConnected() || !this.mRight.isConnected())) {
            if (this.mTop.isConnected() && this.mBottom.isConnected()) {
                this.mResolvedDimensionRatioSide = 0;
            } else if (this.mLeft.isConnected() && this.mRight.isConnected()) {
                this.mResolvedDimensionRatio = 1.0f / this.mResolvedDimensionRatio;
                this.mResolvedDimensionRatioSide = 1;
            }
        }
        if (this.mResolvedDimensionRatioSide == -1) {
            int i = this.mMatchConstraintMinWidth;
            if (i > 0 && this.mMatchConstraintMinHeight == 0) {
                this.mResolvedDimensionRatioSide = 0;
            } else {
                if (i != 0 || this.mMatchConstraintMinHeight <= 0) {
                    return;
                }
                this.mResolvedDimensionRatio = 1.0f / this.mResolvedDimensionRatio;
                this.mResolvedDimensionRatioSide = 1;
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:103:0x0181  */
    /* JADX WARN: Code duplicated, block: B:105:0x01bd  */
    /* JADX WARN: Code duplicated, block: B:107:0x01cd A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:185:0x02de  */
    /* JADX WARN: Code duplicated, block: B:187:0x02e4  */
    /* JADX WARN: Code duplicated, block: B:189:0x02ea  */
    /* JADX WARN: Code duplicated, block: B:190:0x02ed  */
    /* JADX WARN: Code duplicated, block: B:192:0x0315  */
    /* JADX WARN: Code duplicated, block: B:195:0x0322 A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:196:0x0323 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:197:0x0325  */
    /* JADX WARN: Code duplicated, block: B:205:0x0335  */
    /* JADX WARN: Code duplicated, block: B:207:0x034f  */
    /* JADX WARN: Code duplicated, block: B:215:0x0366  */
    /* JADX WARN: Code duplicated, block: B:217:0x036c  */
    /* JADX WARN: Code duplicated, block: B:239:0x039a  */
    /* JADX WARN: Code duplicated, block: B:241:0x039e  */
    /* JADX WARN: Code duplicated, block: B:249:0x03bc  */
    /* JADX WARN: Code duplicated, block: B:251:0x03c0  */
    /* JADX WARN: Code duplicated, block: B:252:0x03c5  */
    /* JADX WARN: Code duplicated, block: B:254:0x03c8  */
    /* JADX WARN: Code duplicated, block: B:276:0x0404 A[ADDED_TO_REGION, REMOVE] */
    /* JADX WARN: Code duplicated, block: B:279:0x0412 A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:306:? A[ADDED_TO_REGION, RETURN, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:30:0x0085  */
    /* JADX WARN: Code duplicated, block: B:31:0x0089  */
    /* JADX WARN: Code duplicated, block: B:33:0x008d  */
    /* JADX WARN: Code duplicated, block: B:37:0x0099 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:38:0x009b A[ADDED_TO_REGION] */
    /* JADX WARN: Code duplicated, block: B:40:0x00a9  */
    /* JADX WARN: Code duplicated, block: B:42:0x00af A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:43:0x00b1  */
    /* JADX WARN: Code duplicated, block: B:45:0x00ba  */
    /* JADX WARN: Code duplicated, block: B:48:0x00c2  */
    /* JADX WARN: Code duplicated, block: B:49:0x00c6  */
    /* JADX WARN: Code duplicated, block: B:53:0x00d8  */
    /* JADX WARN: Code duplicated, block: B:65:0x0100  */
    /* JADX WARN: Code duplicated, block: B:66:0x0102  */
    /* JADX WARN: Code duplicated, block: B:68:0x0105  */
    /* JADX WARN: Code duplicated, block: B:69:0x0107  */
    /* JADX WARN: Code duplicated, block: B:75:0x0110  */
    /* JADX WARN: Code duplicated, block: B:77:0x011b  */
    /* JADX WARN: Code duplicated, block: B:81:0x0122  */
    /* JADX WARN: Code duplicated, block: B:83:0x0125  */
    /* JADX WARN: Code duplicated, block: B:84:0x012b  */
    /* JADX WARN: Code duplicated, block: B:86:0x0132  */
    /* JADX WARN: Code duplicated, block: B:89:0x0137 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:90:0x0139  */
    /* JADX WARN: Code duplicated, block: B:91:0x013d A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:92:0x013f  */
    /* JADX WARN: Code duplicated, block: B:93:0x0147  */
    /* JADX WARN: Code duplicated, block: B:95:0x0154  */
    /* JADX WARN: Code duplicated, block: B:97:0x0157  */
    private void applyConstraints(LinearSystem linearSystem, boolean z, boolean z2, boolean z3, boolean z4, SolverVariable solverVariable, SolverVariable solverVariable2, DimensionBehaviour dimensionBehaviour, boolean z5, ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i, int i2, int i3, int i4, float f, boolean z6, boolean z7, boolean z8, boolean z9, int i5, int i6, int i7, int i8, float f2, boolean z10) {
        int i9;
        boolean z11;
        int iMin;
        int i10;
        int i11;
        int i12;
        int i13;
        int i14;
        int i15;
        boolean z12;
        SolverVariable solverVariableCreateObjectVariable;
        SolverVariable solverVariableCreateObjectVariable2;
        boolean z13;
        int i16;
        boolean z14;
        int i17;
        boolean z15;
        boolean z16;
        int i18;
        int i19;
        boolean z17;
        boolean z18;
        boolean z19;
        int i20;
        ConstraintWidget constraintWidget;
        int i21;
        LinearSystem linearSystem2;
        SolverVariable solverVariable3;
        int i22;
        int iMin2;
        int i23;
        SolverVariable solverVariable4;
        int margin;
        ConstraintWidget constraintWidget2;
        int i24;
        int i25;
        int i26;
        int i27;
        int i28;
        int i29;
        boolean z20;
        boolean z21;
        SolverVariable solverVariableCreateObjectVariable3 = linearSystem.createObjectVariable(constraintAnchor);
        SolverVariable solverVariableCreateObjectVariable4 = linearSystem.createObjectVariable(constraintAnchor2);
        SolverVariable solverVariableCreateObjectVariable5 = linearSystem.createObjectVariable(constraintAnchor.getTarget());
        SolverVariable solverVariableCreateObjectVariable6 = linearSystem.createObjectVariable(constraintAnchor2.getTarget());
        if (LinearSystem.getMetrics() != null) {
            LinearSystem.getMetrics().nonresolvedWidgets++;
        }
        boolean zIsConnected = constraintAnchor.isConnected();
        boolean zIsConnected2 = constraintAnchor2.isConnected();
        boolean zIsConnected3 = this.mCenter.isConnected();
        int i30 = zIsConnected2 ? (zIsConnected ? 1 : 0) + 1 : zIsConnected ? 1 : 0;
        if (zIsConnected3) {
            i30++;
        }
        int i31 = z6 ? 3 : i5;
        int i32 = C00261.f234xdde91696[dimensionBehaviour.ordinal()];
        if (i32 != 1 && i32 != 2 && i32 != 3 && i32 == 4) {
            i9 = i31;
            if (i9 != 4) {
                z11 = true;
            }
            if (this.mVisibility == 8) {
                iMin = 0;
                z11 = false;
            } else {
                iMin = i2;
            }
            if (z10) {
                if (zIsConnected && !zIsConnected2 && !zIsConnected3) {
                    linearSystem.addEquality(solverVariableCreateObjectVariable3, i);
                } else if (zIsConnected && !zIsConnected2) {
                    i10 = 8;
                    linearSystem.addEquality(solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), 8);
                }
                i10 = 8;
            } else {
                i10 = 8;
            }
            if (!z11) {
                if (i30 == 2 && !z6 && (i9 == 1 || i9 == 0)) {
                    int iMax = Math.max(i7, iMin);
                    if (i8 > 0) {
                        iMax = Math.min(i8, iMax);
                    }
                    linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMax, 8);
                    i15 = i7;
                    i12 = i8;
                    solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                    solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                    z12 = false;
                    i14 = i30;
                } else {
                    if (i7 == -2) {
                        i11 = iMin;
                    } else {
                        i11 = i7;
                    }
                    if (i8 == -2) {
                        i12 = iMin;
                    } else {
                        i12 = i8;
                    }
                    if (iMin > 0 && i9 != 1) {
                        iMin = 0;
                    }
                    if (i11 > 0) {
                        linearSystem.addGreaterThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i11, 8);
                        iMin = Math.max(iMin, i11);
                    }
                    if (i12 > 0) {
                        if (z2 || i9 != 1) {
                            z13 = true;
                        } else {
                            z13 = false;
                        }
                        if (z13) {
                            i13 = 8;
                            linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i12, 8);
                        } else {
                            i13 = 8;
                        }
                        iMin = Math.min(iMin, i12);
                    } else {
                        i13 = 8;
                    }
                    if (i9 == 1) {
                        if (z2) {
                            linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                        } else if (z7) {
                            linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, 5);
                            linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                        } else {
                            linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, 5);
                            linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                        }
                        i15 = i11;
                    } else if (i9 == 2) {
                        if (constraintAnchor.getType() != ConstraintAnchor.Type.TOP || constraintAnchor.getType() == ConstraintAnchor.Type.BOTTOM) {
                            solverVariableCreateObjectVariable = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.TOP));
                            solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.BOTTOM));
                        } else {
                            solverVariableCreateObjectVariable = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.LEFT));
                            solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.RIGHT));
                        }
                        SolverVariable solverVariable5 = solverVariableCreateObjectVariable;
                        ArrayRow arrayRowCreateRow = linearSystem.createRow();
                        int i33 = i11;
                        solverVariableCreateObjectVariable6 = solverVariableCreateObjectVariable6;
                        i14 = i30 == true ? 1 : 0;
                        solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                        solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                        linearSystem.addConstraint(arrayRowCreateRow.createRowDimensionRatio(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, solverVariable5, f2));
                        z4 = z4;
                        i15 = i33;
                        z12 = false;
                    } else {
                        solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                        solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                        int i34 = i11;
                        solverVariableCreateObjectVariable6 = solverVariableCreateObjectVariable6;
                        i14 = i30;
                        i15 = i34;
                        z12 = z11;
                        z4 = true;
                    }
                }
                if (z10 || z7) {
                    i16 = 8;
                    if (i14 >= 2 && z2 && z4) {
                        r10.addGreaterThan(solverVariableCreateObjectVariable3, solverVariable, 0, i16);
                        boolean z22 = z || this.mBaseline.mTarget == null;
                        if (z || this.mBaseline.mTarget == null) {
                            z14 = z22;
                        } else {
                            ConstraintWidget constraintWidget3 = this.mBaseline.mTarget.mOwner;
                            z14 = constraintWidget3.mDimensionRatio != 0.0f && constraintWidget3.mListDimensionBehaviors[0] == DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget3.mListDimensionBehaviors[1] == DimensionBehaviour.MATCH_CONSTRAINT;
                        }
                        if (z14) {
                            linearSystem.addGreaterThan(solverVariable2, solverVariableCreateObjectVariable4, 0, i16);
                            return;
                        }
                        return;
                    }
                    return;
                }
                if ((zIsConnected || zIsConnected2 || zIsConnected3) && (!zIsConnected || zIsConnected2)) {
                    if (zIsConnected || !zIsConnected2) {
                        if (zIsConnected && zIsConnected2) {
                            ConstraintWidget constraintWidget4 = constraintAnchor.mTarget.mOwner;
                            ConstraintWidget constraintWidget5 = constraintAnchor2.mTarget.mOwner;
                            ConstraintWidget parent = getParent();
                            int i35 = 6;
                            if (z12) {
                                if (i9 == 0) {
                                    if (i12 == 0 && i15 == 0) {
                                        i28 = 8;
                                        i29 = 8;
                                        z20 = false;
                                        z21 = true;
                                    } else {
                                        i28 = 5;
                                        i29 = 5;
                                        z20 = true;
                                        z21 = false;
                                    }
                                    if ((constraintWidget4 instanceof Barrier) || (constraintWidget5 instanceof Barrier)) {
                                        z16 = z20;
                                        z17 = z21;
                                        z15 = false;
                                        i18 = 4;
                                        i19 = i28;
                                        i17 = 6;
                                    } else {
                                        z16 = z20;
                                        z17 = z21;
                                        i19 = i28;
                                        i18 = i29;
                                        i17 = 6;
                                        z15 = false;
                                    }
                                } else if (i9 == 1) {
                                    i17 = 6;
                                    z15 = true;
                                    z16 = true;
                                    i18 = 4;
                                    i19 = 8;
                                    z17 = false;
                                } else if (i9 == 3) {
                                    if (this.mResolvedDimensionRatioSide == -1) {
                                        if (z8) {
                                            i17 = z2 ? 5 : 4;
                                        } else {
                                            i17 = 8;
                                        }
                                        z15 = true;
                                        z16 = true;
                                        i18 = 5;
                                        i19 = 8;
                                    } else if (z6) {
                                        if (i6 == 2 || i6 == 1) {
                                            i26 = 5;
                                            i27 = 4;
                                        } else {
                                            i26 = 8;
                                            i27 = 5;
                                        }
                                        i19 = i26;
                                        i18 = i27;
                                        i17 = 6;
                                        z15 = true;
                                        z16 = true;
                                    } else {
                                        if (i12 > 0) {
                                            i17 = 6;
                                            z15 = true;
                                            z16 = true;
                                            i18 = 5;
                                        } else if (i12 != 0 || i15 != 0) {
                                            i17 = 6;
                                            z15 = true;
                                            z16 = true;
                                            i18 = 4;
                                        } else if (z8) {
                                            i19 = (constraintWidget4 == parent || constraintWidget5 == parent) ? 5 : 4;
                                            i17 = 6;
                                            z15 = true;
                                            z16 = true;
                                            i18 = 4;
                                        } else {
                                            i17 = 6;
                                            z15 = true;
                                            z16 = true;
                                            i18 = 8;
                                        }
                                        i19 = 5;
                                    }
                                    z17 = true;
                                } else {
                                    i17 = 6;
                                    z15 = false;
                                    z16 = false;
                                }
                                if (z15 || solverVariableCreateObjectVariable5 != solverVariableCreateObjectVariable6 || constraintWidget4 == parent) {
                                    z18 = z15;
                                    z19 = true;
                                } else {
                                    z18 = false;
                                    z19 = false;
                                }
                                if (z16) {
                                    if (this.mVisibility == 8) {
                                        i25 = 4;
                                    } else {
                                        i25 = i17;
                                    }
                                    i20 = i9;
                                    constraintWidget = parent;
                                    i21 = 8;
                                    linearSystem.addCentering(solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), f, solverVariableCreateObjectVariable6, solverVariableCreateObjectVariable4, constraintAnchor2.getMargin(), i25);
                                } else {
                                    i20 = i9;
                                    constraintWidget = parent;
                                    i21 = 8;
                                }
                                if (this.mVisibility == i21) {
                                    return;
                                }
                                if (z18) {
                                    if (z2 || solverVariableCreateObjectVariable5 == solverVariableCreateObjectVariable6 || z12 || !((constraintWidget4 instanceof Barrier) || (constraintWidget5 instanceof Barrier))) {
                                        i24 = i19;
                                    } else {
                                        i24 = 6;
                                    }
                                    linearSystem2 = linearSystem;
                                    solverVariable3 = solverVariableCreateObjectVariable3;
                                    i22 = 8;
                                    linearSystem2.addGreaterThan(solverVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), i24);
                                    linearSystem2.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable6, -constraintAnchor2.getMargin(), i24);
                                    i19 = i24;
                                } else {
                                    linearSystem2 = linearSystem;
                                    solverVariable3 = solverVariableCreateObjectVariable3;
                                    i22 = 8;
                                }
                                if (z2 || !z9 || (constraintWidget4 instanceof Barrier) || (constraintWidget5 instanceof Barrier)) {
                                    iMin2 = i18;
                                    i23 = i19;
                                } else {
                                    iMin2 = 6;
                                    i23 = 6;
                                    z19 = true;
                                }
                                if (z19) {
                                    if (z17 || (z8 && !z3)) {
                                        constraintWidget2 = constraintWidget;
                                    } else {
                                        constraintWidget2 = constraintWidget;
                                        if (constraintWidget4 != constraintWidget2 && constraintWidget5 != constraintWidget2) {
                                            i35 = iMin2;
                                        }
                                        if ((constraintWidget4 instanceof Guideline) || (constraintWidget5 instanceof Guideline)) {
                                            i35 = 5;
                                        }
                                        if ((constraintWidget4 instanceof Barrier) || (constraintWidget5 instanceof Barrier)) {
                                            i35 = 5;
                                        }
                                        iMin2 = Math.max(z8 ? 5 : i35, iMin2);
                                    }
                                    if (z2) {
                                        iMin2 = Math.min(i23, iMin2);
                                        if (z6 && !z8 && (constraintWidget4 == constraintWidget2 || constraintWidget5 == constraintWidget2)) {
                                            iMin2 = 4;
                                        }
                                    }
                                    linearSystem2.addEquality(solverVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), iMin2);
                                    linearSystem2.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable6, -constraintAnchor2.getMargin(), iMin2);
                                }
                                if (z2) {
                                    if (solverVariable == solverVariableCreateObjectVariable5) {
                                        margin = constraintAnchor.getMargin();
                                    } else {
                                        margin = 0;
                                    }
                                    if (solverVariableCreateObjectVariable5 != solverVariable) {
                                        linearSystem2.addGreaterThan(solverVariable3, solverVariable, margin, 5);
                                    }
                                }
                                if (!z2 && z12) {
                                    solverVariable4 = solverVariableCreateObjectVariable4;
                                    if (i3 == 0 && i15 == 0) {
                                        if (z12 && i20 == 3) {
                                            linearSystem2.addGreaterThan(solverVariable4, solverVariable3, 0, i22);
                                        } else {
                                            linearSystem2.addGreaterThan(solverVariable4, solverVariable3, 0, 5);
                                        }
                                    }
                                }
                            } else {
                                i17 = 6;
                                z15 = true;
                                z16 = true;
                            }
                            i18 = 4;
                            i19 = 5;
                            z17 = false;
                            if (z15) {
                                z18 = z15;
                                z19 = true;
                            } else {
                                z18 = z15;
                                z19 = true;
                            }
                            if (z16) {
                                if (this.mVisibility == 8) {
                                    i25 = 4;
                                } else {
                                    i25 = i17;
                                }
                                i20 = i9;
                                constraintWidget = parent;
                                i21 = 8;
                                linearSystem.addCentering(solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), f, solverVariableCreateObjectVariable6, solverVariableCreateObjectVariable4, constraintAnchor2.getMargin(), i25);
                            } else {
                                i20 = i9;
                                constraintWidget = parent;
                                i21 = 8;
                            }
                            if (this.mVisibility == i21) {
                                return;
                            }
                            if (z18) {
                                if (z2) {
                                    i24 = i19;
                                } else {
                                    i24 = i19;
                                }
                                linearSystem2 = linearSystem;
                                solverVariable3 = solverVariableCreateObjectVariable3;
                                i22 = 8;
                                linearSystem2.addGreaterThan(solverVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), i24);
                                linearSystem2.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable6, -constraintAnchor2.getMargin(), i24);
                                i19 = i24;
                            } else {
                                linearSystem2 = linearSystem;
                                solverVariable3 = solverVariableCreateObjectVariable3;
                                i22 = 8;
                            }
                            if (z2) {
                                iMin2 = i18;
                                i23 = i19;
                            } else {
                                iMin2 = i18;
                                i23 = i19;
                            }
                            if (z19) {
                                if (z17) {
                                    constraintWidget2 = constraintWidget;
                                } else {
                                    constraintWidget2 = constraintWidget;
                                }
                                if (z2) {
                                    iMin2 = Math.min(i23, iMin2);
                                    if (z6) {
                                        iMin2 = 4;
                                    }
                                }
                                linearSystem2.addEquality(solverVariable3, solverVariableCreateObjectVariable5, constraintAnchor.getMargin(), iMin2);
                                linearSystem2.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable6, -constraintAnchor2.getMargin(), iMin2);
                            }
                            if (z2) {
                                if (solverVariable == solverVariableCreateObjectVariable5) {
                                    margin = constraintAnchor.getMargin();
                                } else {
                                    margin = 0;
                                }
                                if (solverVariableCreateObjectVariable5 != solverVariable) {
                                    linearSystem2.addGreaterThan(solverVariable3, solverVariable, margin, 5);
                                }
                            }
                            if (!z2) {
                            }
                        }
                        solverVariable4 = solverVariableCreateObjectVariable4;
                    } else {
                        linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable6, -constraintAnchor2.getMargin(), 8);
                        if (z2) {
                            linearSystem.addGreaterThan(solverVariableCreateObjectVariable3, solverVariable, 0, 5);
                        }
                    }
                    linearSystem2 = linearSystem;
                    solverVariable4 = solverVariableCreateObjectVariable4;
                } else {
                    linearSystem2 = linearSystem;
                    solverVariable4 = solverVariableCreateObjectVariable4;
                }
                if (z2 && z4) {
                    int margin2 = constraintAnchor2.mTarget != null ? constraintAnchor2.getMargin() : 0;
                    if (solverVariableCreateObjectVariable6 != solverVariable2) {
                        linearSystem2.addGreaterThan(solverVariable2, solverVariable4, margin2, 5);
                        return;
                    }
                    return;
                }
                return;
            }
            if (z5) {
                linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, 0, 3);
                if (i3 > 0) {
                    linearSystem.addGreaterThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i3, 8);
                }
                if (i4 < Integer.MAX_VALUE) {
                    linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i4, 8);
                }
            } else {
                linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i10);
            }
            i15 = i7;
            i12 = i8;
            z12 = z11;
            i14 = i30;
            if (z10) {
                i16 = 8;
            } else {
                i16 = 8;
            }
            if (i14 >= 2) {
            }
        }
        i9 = i31;
        z11 = false;
        if (this.mVisibility == 8) {
            iMin = 0;
            z11 = false;
        } else {
            iMin = i2;
        }
        if (z10) {
            i10 = 8;
        } else if (zIsConnected) {
            if (zIsConnected) {
                i10 = 8;
            } else {
                i10 = 8;
            }
        } else if (zIsConnected) {
            i10 = 8;
        } else {
            i10 = 8;
        }
        if (!z11) {
            if (i30 == 2) {
            }
            if (i7 == -2) {
                i11 = iMin;
            } else {
                i11 = i7;
            }
            if (i8 == -2) {
                i12 = iMin;
            } else {
                i12 = i8;
            }
            if (iMin > 0) {
                iMin = 0;
            }
            if (i11 > 0) {
                linearSystem.addGreaterThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i11, 8);
                iMin = Math.max(iMin, i11);
            }
            if (i12 > 0) {
                if (z2) {
                    z13 = true;
                } else {
                    z13 = true;
                }
                if (z13) {
                    i13 = 8;
                    linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i12, 8);
                } else {
                    i13 = 8;
                }
                iMin = Math.min(iMin, i12);
            } else {
                i13 = 8;
            }
            if (i9 == 1) {
                if (z2) {
                    linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                } else if (z7) {
                    linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, 5);
                    linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                } else {
                    linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, 5);
                    linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i13);
                }
                i15 = i11;
            } else if (i9 == 2) {
                if (constraintAnchor.getType() != ConstraintAnchor.Type.TOP) {
                    solverVariableCreateObjectVariable = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.TOP));
                    solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.BOTTOM));
                } else {
                    solverVariableCreateObjectVariable = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.TOP));
                    solverVariableCreateObjectVariable2 = linearSystem.createObjectVariable(this.mParent.getAnchor(ConstraintAnchor.Type.BOTTOM));
                }
                SolverVariable solverVariable6 = solverVariableCreateObjectVariable;
                ArrayRow arrayRowCreateRow2 = linearSystem.createRow();
                int i36 = i11;
                solverVariableCreateObjectVariable6 = solverVariableCreateObjectVariable6;
                i14 = i30 == true ? 1 : 0;
                solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                linearSystem.addConstraint(arrayRowCreateRow2.createRowDimensionRatio(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, solverVariableCreateObjectVariable2, solverVariable6, f2));
                z4 = z4;
                i15 = i36;
                z12 = false;
            } else {
                solverVariableCreateObjectVariable5 = solverVariableCreateObjectVariable5;
                solverVariableCreateObjectVariable4 = solverVariableCreateObjectVariable4;
                int i37 = i11;
                solverVariableCreateObjectVariable6 = solverVariableCreateObjectVariable6;
                i14 = i30;
                i15 = i37;
                z12 = z11;
                z4 = true;
            }
            if (z10) {
                i16 = 8;
            } else {
                i16 = 8;
            }
            if (i14 >= 2) {
            }
        }
        if (z5) {
            linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, 0, 3);
            if (i3 > 0) {
                linearSystem.addGreaterThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i3, 8);
            }
            if (i4 < Integer.MAX_VALUE) {
                linearSystem.addLowerThan(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, i4, 8);
            }
        } else {
            linearSystem.addEquality(solverVariableCreateObjectVariable4, solverVariableCreateObjectVariable3, iMin, i10);
        }
        i15 = i7;
        i12 = i8;
        z12 = z11;
        i14 = i30;
        if (z10) {
            i16 = 8;
        } else {
            i16 = 8;
        }
        if (i14 >= 2) {
        }
    }

    /* JADX INFO: renamed from: androidx.constraintlayout.solver.widgets.ConstraintWidget$1 */
    static /* synthetic */ class C00261 {

        /* JADX INFO: renamed from: $SwitchMap$androidx$constraintlayout$solver$widgets$ConstraintAnchor$Type */
        static final /* synthetic */ int[] f233x4c44d048;

        /* JADX INFO: renamed from: $SwitchMap$androidx$constraintlayout$solver$widgets$ConstraintWidget$DimensionBehaviour */
        static final /* synthetic */ int[] f234xdde91696;

        static {
            int[] iArr = new int[DimensionBehaviour.values().length];
            f234xdde91696 = iArr;
            try {
                iArr[DimensionBehaviour.FIXED.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f234xdde91696[DimensionBehaviour.WRAP_CONTENT.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f234xdde91696[DimensionBehaviour.MATCH_PARENT.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f234xdde91696[DimensionBehaviour.MATCH_CONSTRAINT.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            int[] iArr2 = new int[ConstraintAnchor.Type.values().length];
            f233x4c44d048 = iArr2;
            try {
                iArr2[ConstraintAnchor.Type.LEFT.ordinal()] = 1;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.TOP.ordinal()] = 2;
            } catch (NoSuchFieldError unused6) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.RIGHT.ordinal()] = 3;
            } catch (NoSuchFieldError unused7) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.BOTTOM.ordinal()] = 4;
            } catch (NoSuchFieldError unused8) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.BASELINE.ordinal()] = 5;
            } catch (NoSuchFieldError unused9) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.CENTER.ordinal()] = 6;
            } catch (NoSuchFieldError unused10) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.CENTER_X.ordinal()] = 7;
            } catch (NoSuchFieldError unused11) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.CENTER_Y.ordinal()] = 8;
            } catch (NoSuchFieldError unused12) {
            }
            try {
                f233x4c44d048[ConstraintAnchor.Type.NONE.ordinal()] = 9;
            } catch (NoSuchFieldError unused13) {
            }
        }
    }

    public void updateFromSolver(LinearSystem linearSystem) {
        int objectVariableValue = linearSystem.getObjectVariableValue(this.mLeft);
        int objectVariableValue2 = linearSystem.getObjectVariableValue(this.mTop);
        int objectVariableValue3 = linearSystem.getObjectVariableValue(this.mRight);
        int objectVariableValue4 = linearSystem.getObjectVariableValue(this.mBottom);
        if (this.horizontalRun.start.resolved && this.horizontalRun.end.resolved) {
            objectVariableValue = this.horizontalRun.start.value;
            objectVariableValue3 = this.horizontalRun.end.value;
        }
        if (this.verticalRun.start.resolved && this.verticalRun.end.resolved) {
            objectVariableValue2 = this.verticalRun.start.value;
            objectVariableValue4 = this.verticalRun.end.value;
        }
        int i = objectVariableValue4 - objectVariableValue2;
        if (objectVariableValue3 - objectVariableValue < 0 || i < 0 || objectVariableValue == Integer.MIN_VALUE || objectVariableValue == Integer.MAX_VALUE || objectVariableValue2 == Integer.MIN_VALUE || objectVariableValue2 == Integer.MAX_VALUE || objectVariableValue3 == Integer.MIN_VALUE || objectVariableValue3 == Integer.MAX_VALUE || objectVariableValue4 == Integer.MIN_VALUE || objectVariableValue4 == Integer.MAX_VALUE) {
            objectVariableValue = 0;
            objectVariableValue4 = 0;
            objectVariableValue2 = 0;
            objectVariableValue3 = 0;
        }
        setFrame(objectVariableValue, objectVariableValue2, objectVariableValue3, objectVariableValue4);
    }

    public void copy(ConstraintWidget constraintWidget, HashMap<ConstraintWidget, ConstraintWidget> map) {
        this.mHorizontalResolution = constraintWidget.mHorizontalResolution;
        this.mVerticalResolution = constraintWidget.mVerticalResolution;
        this.mMatchConstraintDefaultWidth = constraintWidget.mMatchConstraintDefaultWidth;
        this.mMatchConstraintDefaultHeight = constraintWidget.mMatchConstraintDefaultHeight;
        int[] iArr = this.mResolvedMatchConstraintDefault;
        int[] iArr2 = constraintWidget.mResolvedMatchConstraintDefault;
        iArr[0] = iArr2[0];
        iArr[1] = iArr2[1];
        this.mMatchConstraintMinWidth = constraintWidget.mMatchConstraintMinWidth;
        this.mMatchConstraintMaxWidth = constraintWidget.mMatchConstraintMaxWidth;
        this.mMatchConstraintMinHeight = constraintWidget.mMatchConstraintMinHeight;
        this.mMatchConstraintMaxHeight = constraintWidget.mMatchConstraintMaxHeight;
        this.mMatchConstraintPercentHeight = constraintWidget.mMatchConstraintPercentHeight;
        this.mIsWidthWrapContent = constraintWidget.mIsWidthWrapContent;
        this.mIsHeightWrapContent = constraintWidget.mIsHeightWrapContent;
        this.mResolvedDimensionRatioSide = constraintWidget.mResolvedDimensionRatioSide;
        this.mResolvedDimensionRatio = constraintWidget.mResolvedDimensionRatio;
        int[] iArr3 = constraintWidget.mMaxDimension;
        this.mMaxDimension = Arrays.copyOf(iArr3, iArr3.length);
        this.mCircleConstraintAngle = constraintWidget.mCircleConstraintAngle;
        this.hasBaseline = constraintWidget.hasBaseline;
        this.inPlaceholder = constraintWidget.inPlaceholder;
        this.mLeft.reset();
        this.mTop.reset();
        this.mRight.reset();
        this.mBottom.reset();
        this.mBaseline.reset();
        this.mCenterX.reset();
        this.mCenterY.reset();
        this.mCenter.reset();
        this.mListDimensionBehaviors = (DimensionBehaviour[]) Arrays.copyOf(this.mListDimensionBehaviors, 2);
        this.mParent = this.mParent == null ? null : map.get(constraintWidget.mParent);
        this.mWidth = constraintWidget.mWidth;
        this.mHeight = constraintWidget.mHeight;
        this.mDimensionRatio = constraintWidget.mDimensionRatio;
        this.mDimensionRatioSide = constraintWidget.mDimensionRatioSide;
        this.f231mX = constraintWidget.f231mX;
        this.f232mY = constraintWidget.f232mY;
        this.mRelX = constraintWidget.mRelX;
        this.mRelY = constraintWidget.mRelY;
        this.mOffsetX = constraintWidget.mOffsetX;
        this.mOffsetY = constraintWidget.mOffsetY;
        this.mBaselineDistance = constraintWidget.mBaselineDistance;
        this.mMinWidth = constraintWidget.mMinWidth;
        this.mMinHeight = constraintWidget.mMinHeight;
        this.mHorizontalBiasPercent = constraintWidget.mHorizontalBiasPercent;
        this.mVerticalBiasPercent = constraintWidget.mVerticalBiasPercent;
        this.mCompanionWidget = constraintWidget.mCompanionWidget;
        this.mContainerItemSkip = constraintWidget.mContainerItemSkip;
        this.mVisibility = constraintWidget.mVisibility;
        this.mDebugName = constraintWidget.mDebugName;
        this.mType = constraintWidget.mType;
        this.mDistToTop = constraintWidget.mDistToTop;
        this.mDistToLeft = constraintWidget.mDistToLeft;
        this.mDistToRight = constraintWidget.mDistToRight;
        this.mDistToBottom = constraintWidget.mDistToBottom;
        this.mLeftHasCentered = constraintWidget.mLeftHasCentered;
        this.mRightHasCentered = constraintWidget.mRightHasCentered;
        this.mTopHasCentered = constraintWidget.mTopHasCentered;
        this.mBottomHasCentered = constraintWidget.mBottomHasCentered;
        this.mHorizontalWrapVisited = constraintWidget.mHorizontalWrapVisited;
        this.mVerticalWrapVisited = constraintWidget.mVerticalWrapVisited;
        this.mOptimizerMeasurable = constraintWidget.mOptimizerMeasurable;
        this.mGroupsToSolver = constraintWidget.mGroupsToSolver;
        this.mHorizontalChainStyle = constraintWidget.mHorizontalChainStyle;
        this.mVerticalChainStyle = constraintWidget.mVerticalChainStyle;
        this.mHorizontalChainFixedPosition = constraintWidget.mHorizontalChainFixedPosition;
        this.mVerticalChainFixedPosition = constraintWidget.mVerticalChainFixedPosition;
        float[] fArr = this.mWeight;
        float[] fArr2 = constraintWidget.mWeight;
        fArr[0] = fArr2[0];
        fArr[1] = fArr2[1];
        ConstraintWidget[] constraintWidgetArr = this.mListNextMatchConstraintsWidget;
        ConstraintWidget[] constraintWidgetArr2 = constraintWidget.mListNextMatchConstraintsWidget;
        constraintWidgetArr[0] = constraintWidgetArr2[0];
        constraintWidgetArr[1] = constraintWidgetArr2[1];
        ConstraintWidget[] constraintWidgetArr3 = this.mNextChainWidget;
        ConstraintWidget[] constraintWidgetArr4 = constraintWidget.mNextChainWidget;
        constraintWidgetArr3[0] = constraintWidgetArr4[0];
        constraintWidgetArr3[1] = constraintWidgetArr4[1];
        ConstraintWidget constraintWidget2 = constraintWidget.mHorizontalNextWidget;
        this.mHorizontalNextWidget = constraintWidget2 == null ? null : map.get(constraintWidget2);
        ConstraintWidget constraintWidget3 = constraintWidget.mVerticalNextWidget;
        this.mVerticalNextWidget = constraintWidget3 != null ? map.get(constraintWidget3) : null;
    }

    public void updateFromRuns(boolean z, boolean z2) {
        int i;
        int i2;
        boolean zIsResolved = z & this.horizontalRun.isResolved();
        boolean zIsResolved2 = z2 & this.verticalRun.isResolved();
        int i3 = this.horizontalRun.start.value;
        int i4 = this.verticalRun.start.value;
        int i5 = this.horizontalRun.end.value;
        int i6 = this.verticalRun.end.value;
        int i7 = i6 - i4;
        if (i5 - i3 < 0 || i7 < 0 || i3 == Integer.MIN_VALUE || i3 == Integer.MAX_VALUE || i4 == Integer.MIN_VALUE || i4 == Integer.MAX_VALUE || i5 == Integer.MIN_VALUE || i5 == Integer.MAX_VALUE || i6 == Integer.MIN_VALUE || i6 == Integer.MAX_VALUE) {
            i3 = 0;
            i4 = 0;
            i5 = 0;
            i6 = 0;
        }
        int i8 = i5 - i3;
        int i9 = i6 - i4;
        if (zIsResolved) {
            this.f231mX = i3;
        }
        if (zIsResolved2) {
            this.f232mY = i4;
        }
        if (this.mVisibility == 8) {
            this.mWidth = 0;
            this.mHeight = 0;
            return;
        }
        if (zIsResolved) {
            if (this.mListDimensionBehaviors[0] == DimensionBehaviour.FIXED && i8 < (i2 = this.mWidth)) {
                i8 = i2;
            }
            this.mWidth = i8;
            int i10 = this.mMinWidth;
            if (i8 < i10) {
                this.mWidth = i10;
            }
        }
        if (zIsResolved2) {
            if (this.mListDimensionBehaviors[1] == DimensionBehaviour.FIXED && i9 < (i = this.mHeight)) {
                i9 = i;
            }
            this.mHeight = i9;
            int i11 = this.mMinHeight;
            if (i9 < i11) {
                this.mHeight = i11;
            }
        }
    }
}
