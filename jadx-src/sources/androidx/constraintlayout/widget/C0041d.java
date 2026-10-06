package androidx.constraintlayout.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseIntArray;
import android.util.Xml;
import android.view.View;
import android.view.ViewGroup;
import androidx.constraintlayout.motion.widget.MotionLayout;
import androidx.constraintlayout.solver.widgets.Optimizer;
import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;
import b1.e;
import j1.f;
import j1.g;
import j1.h;
import j1.i;
import j1.j;
import j1.l;
import j1.m;
import j1.o;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;
import org.xmlpull.v1.XmlPullParserException;

/* JADX INFO: renamed from: androidx.constraintlayout.widget.d */
/* JADX INFO: loaded from: classes.dex */
public final class C0041d {

    /* JADX INFO: renamed from: g */
    public static final int[] f548g = {0, 4, 8};

    /* JADX INFO: renamed from: h */
    public static final SparseIntArray f549h;

    /* JADX INFO: renamed from: i */
    public static final SparseIntArray f550i;

    /* JADX INFO: renamed from: a */
    public String f551a;

    /* JADX INFO: renamed from: b */
    public String f552b = "";

    /* JADX INFO: renamed from: c */
    public int f553c = 0;

    /* JADX INFO: renamed from: d */
    public final HashMap f554d = new HashMap();

    /* JADX INFO: renamed from: e */
    public boolean f555e = true;

    /* JADX INFO: renamed from: f */
    public final HashMap f556f = new HashMap();

    static {
        SparseIntArray sparseIntArray = new SparseIntArray();
        f549h = sparseIntArray;
        SparseIntArray sparseIntArray2 = new SparseIntArray();
        f550i = sparseIntArray2;
        sparseIntArray.append(82, 25);
        sparseIntArray.append(83, 26);
        sparseIntArray.append(85, 29);
        sparseIntArray.append(86, 30);
        sparseIntArray.append(92, 36);
        sparseIntArray.append(91, 35);
        sparseIntArray.append(63, 4);
        sparseIntArray.append(62, 3);
        sparseIntArray.append(58, 1);
        sparseIntArray.append(60, 91);
        sparseIntArray.append(59, 92);
        sparseIntArray.append(101, 6);
        sparseIntArray.append(102, 7);
        sparseIntArray.append(70, 17);
        sparseIntArray.append(71, 18);
        sparseIntArray.append(72, 19);
        sparseIntArray.append(54, 99);
        sparseIntArray.append(0, 27);
        sparseIntArray.append(87, 32);
        sparseIntArray.append(88, 33);
        sparseIntArray.append(69, 10);
        sparseIntArray.append(68, 9);
        sparseIntArray.append(106, 13);
        sparseIntArray.append(109, 16);
        sparseIntArray.append(107, 14);
        sparseIntArray.append(104, 11);
        sparseIntArray.append(108, 15);
        sparseIntArray.append(105, 12);
        sparseIntArray.append(95, 40);
        sparseIntArray.append(80, 39);
        sparseIntArray.append(79, 41);
        sparseIntArray.append(94, 42);
        sparseIntArray.append(78, 20);
        sparseIntArray.append(93, 37);
        sparseIntArray.append(67, 5);
        sparseIntArray.append(81, 87);
        sparseIntArray.append(90, 87);
        sparseIntArray.append(84, 87);
        sparseIntArray.append(61, 87);
        sparseIntArray.append(57, 87);
        sparseIntArray.append(5, 24);
        sparseIntArray.append(7, 28);
        sparseIntArray.append(23, 31);
        sparseIntArray.append(24, 8);
        sparseIntArray.append(6, 34);
        sparseIntArray.append(8, 2);
        sparseIntArray.append(3, 23);
        sparseIntArray.append(4, 21);
        sparseIntArray.append(96, 95);
        sparseIntArray.append(73, 96);
        sparseIntArray.append(2, 22);
        sparseIntArray.append(13, 43);
        sparseIntArray.append(26, 44);
        sparseIntArray.append(21, 45);
        sparseIntArray.append(22, 46);
        sparseIntArray.append(20, 60);
        sparseIntArray.append(18, 47);
        sparseIntArray.append(19, 48);
        sparseIntArray.append(14, 49);
        sparseIntArray.append(15, 50);
        sparseIntArray.append(16, 51);
        sparseIntArray.append(17, 52);
        sparseIntArray.append(25, 53);
        sparseIntArray.append(97, 54);
        sparseIntArray.append(74, 55);
        sparseIntArray.append(98, 56);
        sparseIntArray.append(75, 57);
        sparseIntArray.append(99, 58);
        sparseIntArray.append(76, 59);
        sparseIntArray.append(64, 61);
        sparseIntArray.append(66, 62);
        sparseIntArray.append(65, 63);
        sparseIntArray.append(28, 64);
        sparseIntArray.append(121, 65);
        sparseIntArray.append(35, 66);
        sparseIntArray.append(122, 67);
        sparseIntArray.append(113, 79);
        sparseIntArray.append(1, 38);
        sparseIntArray.append(112, 68);
        sparseIntArray.append(100, 69);
        sparseIntArray.append(77, 70);
        sparseIntArray.append(111, 97);
        sparseIntArray.append(32, 71);
        sparseIntArray.append(30, 72);
        sparseIntArray.append(31, 73);
        sparseIntArray.append(33, 74);
        sparseIntArray.append(29, 75);
        sparseIntArray.append(114, 76);
        sparseIntArray.append(89, 77);
        sparseIntArray.append(123, 78);
        sparseIntArray.append(56, 80);
        sparseIntArray.append(55, 81);
        sparseIntArray.append(116, 82);
        sparseIntArray.append(120, 83);
        sparseIntArray.append(119, 84);
        sparseIntArray.append(118, 85);
        sparseIntArray.append(117, 86);
        sparseIntArray2.append(85, 6);
        sparseIntArray2.append(85, 7);
        sparseIntArray2.append(0, 27);
        sparseIntArray2.append(89, 13);
        sparseIntArray2.append(92, 16);
        sparseIntArray2.append(90, 14);
        sparseIntArray2.append(87, 11);
        sparseIntArray2.append(91, 15);
        sparseIntArray2.append(88, 12);
        sparseIntArray2.append(78, 40);
        sparseIntArray2.append(71, 39);
        sparseIntArray2.append(70, 41);
        sparseIntArray2.append(77, 42);
        sparseIntArray2.append(69, 20);
        sparseIntArray2.append(76, 37);
        sparseIntArray2.append(60, 5);
        sparseIntArray2.append(72, 87);
        sparseIntArray2.append(75, 87);
        sparseIntArray2.append(73, 87);
        sparseIntArray2.append(57, 87);
        sparseIntArray2.append(56, 87);
        sparseIntArray2.append(5, 24);
        sparseIntArray2.append(7, 28);
        sparseIntArray2.append(23, 31);
        sparseIntArray2.append(24, 8);
        sparseIntArray2.append(6, 34);
        sparseIntArray2.append(8, 2);
        sparseIntArray2.append(3, 23);
        sparseIntArray2.append(4, 21);
        sparseIntArray2.append(79, 95);
        sparseIntArray2.append(64, 96);
        sparseIntArray2.append(2, 22);
        sparseIntArray2.append(13, 43);
        sparseIntArray2.append(26, 44);
        sparseIntArray2.append(21, 45);
        sparseIntArray2.append(22, 46);
        sparseIntArray2.append(20, 60);
        sparseIntArray2.append(18, 47);
        sparseIntArray2.append(19, 48);
        sparseIntArray2.append(14, 49);
        sparseIntArray2.append(15, 50);
        sparseIntArray2.append(16, 51);
        sparseIntArray2.append(17, 52);
        sparseIntArray2.append(25, 53);
        sparseIntArray2.append(80, 54);
        sparseIntArray2.append(65, 55);
        sparseIntArray2.append(81, 56);
        sparseIntArray2.append(66, 57);
        sparseIntArray2.append(82, 58);
        sparseIntArray2.append(67, 59);
        sparseIntArray2.append(59, 62);
        sparseIntArray2.append(58, 63);
        sparseIntArray2.append(28, 64);
        sparseIntArray2.append(105, 65);
        sparseIntArray2.append(34, 66);
        sparseIntArray2.append(106, 67);
        sparseIntArray2.append(96, 79);
        sparseIntArray2.append(1, 38);
        sparseIntArray2.append(97, 98);
        sparseIntArray2.append(95, 68);
        sparseIntArray2.append(83, 69);
        sparseIntArray2.append(68, 70);
        sparseIntArray2.append(32, 71);
        sparseIntArray2.append(30, 72);
        sparseIntArray2.append(31, 73);
        sparseIntArray2.append(33, 74);
        sparseIntArray2.append(29, 75);
        sparseIntArray2.append(98, 76);
        sparseIntArray2.append(74, 77);
        sparseIntArray2.append(107, 78);
        sparseIntArray2.append(55, 80);
        sparseIntArray2.append(54, 81);
        sparseIntArray2.append(100, 82);
        sparseIntArray2.append(104, 83);
        sparseIntArray2.append(103, 84);
        sparseIntArray2.append(102, 85);
        sparseIntArray2.append(101, 86);
        sparseIntArray2.append(94, 97);
    }

    /* JADX INFO: renamed from: d */
    public static C0040c m128d(Context context, XmlResourceParser xmlResourceParser) {
        AttributeSet attributeSetAsAttributeSet = Xml.asAttributeSet(xmlResourceParser);
        C0040c c0040c = new C0040c();
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSetAsAttributeSet, m.f);
        m134r(c0040c, typedArrayObtainStyledAttributes);
        typedArrayObtainStyledAttributes.recycle();
        return c0040c;
    }

    /* JADX INFO: renamed from: i */
    public static int[] m129i(Barrier barrier, String str) {
        int iIntValue;
        HashMap map;
        String[] strArrSplit = str.split(",");
        Context context = barrier.getContext();
        int[] iArr = new int[strArrSplit.length];
        int i = 0;
        int i2 = 0;
        while (i < strArrSplit.length) {
            String strTrim = strArrSplit[i].trim();
            Object obj = null;
            try {
                iIntValue = l.class.getField(strTrim).getInt(null);
            } catch (Exception unused) {
                iIntValue = 0;
            }
            if (iIntValue == 0) {
                iIntValue = context.getResources().getIdentifier(strTrim, "id", context.getPackageName());
            }
            if (iIntValue == 0 && barrier.isInEditMode() && (barrier.getParent() instanceof ConstraintLayout)) {
                ConstraintLayout constraintLayout = (ConstraintLayout) barrier.getParent();
                constraintLayout.getClass();
                if ((strTrim instanceof String) && (map = constraintLayout.f368m) != null && map.containsKey(strTrim)) {
                    obj = constraintLayout.f368m.get(strTrim);
                }
                if (obj != null && (obj instanceof Integer)) {
                    iIntValue = ((Integer) obj).intValue();
                }
            }
            iArr[i2] = iIntValue;
            i++;
            i2++;
        }
        return i2 != strArrSplit.length ? Arrays.copyOf(iArr, i2) : iArr;
    }

    /* JADX INFO: renamed from: j */
    public static C0040c m130j(Context context, AttributeSet attributeSet, boolean z) {
        C0040c c0040c = new C0040c();
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, z ? m.f : m.b);
        if (z) {
            m134r(c0040c, typedArrayObtainStyledAttributes);
        } else {
            int indexCount = typedArrayObtainStyledAttributes.getIndexCount();
            int i = 0;
            while (true) {
                g gVar = c0040c.f544e;
                if (i < indexCount) {
                    int index = typedArrayObtainStyledAttributes.getIndex(i);
                    i iVar = c0040c.f542c;
                    j jVar = c0040c.f545f;
                    h hVar = c0040c.f543d;
                    if (index != 1 && 23 != index && 24 != index) {
                        hVar.a = true;
                        gVar.b = true;
                        iVar.a = true;
                        jVar.a = true;
                    }
                    SparseIntArray sparseIntArray = f549h;
                    switch (sparseIntArray.get(index)) {
                        case 1:
                            gVar.q = m131o(typedArrayObtainStyledAttributes, index, gVar.q);
                            break;
                        case 2:
                            gVar.J = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.J);
                            break;
                        case 3:
                            gVar.p = m131o(typedArrayObtainStyledAttributes, index, gVar.p);
                            break;
                        case 4:
                            gVar.o = m131o(typedArrayObtainStyledAttributes, index, gVar.o);
                            break;
                        case 5:
                            gVar.z = typedArrayObtainStyledAttributes.getString(index);
                            break;
                        case 6:
                            gVar.D = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, gVar.D);
                            break;
                        case 7:
                            gVar.E = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, gVar.E);
                            break;
                        case 8:
                            gVar.K = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.K);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_LEFT_TO_RIGHT_OF /* 9 */:
                            gVar.w = m131o(typedArrayObtainStyledAttributes, index, gVar.w);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_TO_LEFT_OF /* 10 */:
                            gVar.v = m131o(typedArrayObtainStyledAttributes, index, gVar.v);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_TO_RIGHT_OF /* 11 */:
                            gVar.Q = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.Q);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_TO_TOP_OF /* 12 */:
                            gVar.R = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.R);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_TO_BOTTOM_OF /* 13 */:
                            gVar.N = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.N);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_TO_TOP_OF /* 14 */:
                            gVar.P = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.P);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_TO_BOTTOM_OF /* 15 */:
                            gVar.S = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.S);
                            break;
                        case 16:
                            gVar.O = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.O);
                            break;
                        case 17:
                            gVar.e = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, gVar.e);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_START_TO_START_OF /* 18 */:
                            gVar.f = typedArrayObtainStyledAttributes.getDimensionPixelOffset(index, gVar.f);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_END_TO_START_OF /* 19 */:
                            gVar.g = typedArrayObtainStyledAttributes.getFloat(index, gVar.g);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_END_TO_END_OF /* 20 */:
                            gVar.x = typedArrayObtainStyledAttributes.getFloat(index, gVar.x);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_LEFT /* 21 */:
                            gVar.d = typedArrayObtainStyledAttributes.getLayoutDimension(index, gVar.d);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_TOP /* 22 */:
                            int i2 = typedArrayObtainStyledAttributes.getInt(index, iVar.b);
                            iVar.b = i2;
                            iVar.b = f548g[i2];
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_RIGHT /* 23 */:
                            gVar.c = typedArrayObtainStyledAttributes.getLayoutDimension(index, gVar.c);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_BOTTOM /* 24 */:
                            gVar.G = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.G);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_START /* 25 */:
                            gVar.i = m131o(typedArrayObtainStyledAttributes, index, gVar.i);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_END /* 26 */:
                            gVar.j = m131o(typedArrayObtainStyledAttributes, index, gVar.j);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINED_WIDTH /* 27 */:
                            gVar.F = typedArrayObtainStyledAttributes.getInt(index, gVar.F);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINED_HEIGHT /* 28 */:
                            gVar.H = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.H);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_BIAS /* 29 */:
                            gVar.k = m131o(typedArrayObtainStyledAttributes, index, gVar.k);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_BIAS /* 30 */:
                            gVar.l = m131o(typedArrayObtainStyledAttributes, index, gVar.l);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_DEFAULT /* 31 */:
                            gVar.L = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.L);
                            break;
                        case 32:
                            gVar.t = m131o(typedArrayObtainStyledAttributes, index, gVar.t);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_MIN /* 33 */:
                            gVar.u = m131o(typedArrayObtainStyledAttributes, index, gVar.u);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_MAX /* 34 */:
                            gVar.I = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.I);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_PERCENT /* 35 */:
                            gVar.n = m131o(typedArrayObtainStyledAttributes, index, gVar.n);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_MIN /* 36 */:
                            gVar.m = m131o(typedArrayObtainStyledAttributes, index, gVar.m);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_MAX /* 37 */:
                            gVar.y = typedArrayObtainStyledAttributes.getFloat(index, gVar.y);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_PERCENT /* 38 */:
                            c0040c.f540a = typedArrayObtainStyledAttributes.getResourceId(index, c0040c.f540a);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_LEFT_CREATOR /* 39 */:
                            gVar.V = typedArrayObtainStyledAttributes.getFloat(index, gVar.V);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_CREATOR /* 40 */:
                            gVar.U = typedArrayObtainStyledAttributes.getFloat(index, gVar.U);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_CREATOR /* 41 */:
                            gVar.W = typedArrayObtainStyledAttributes.getInt(index, gVar.W);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_CREATOR /* 42 */:
                            gVar.X = typedArrayObtainStyledAttributes.getInt(index, gVar.X);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BASELINE_CREATOR /* 43 */:
                            iVar.d = typedArrayObtainStyledAttributes.getFloat(index, iVar.d);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_DIMENSION_RATIO /* 44 */:
                            jVar.m = true;
                            jVar.n = typedArrayObtainStyledAttributes.getDimension(index, jVar.n);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_WEIGHT /* 45 */:
                            jVar.c = typedArrayObtainStyledAttributes.getFloat(index, jVar.c);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_WEIGHT /* 46 */:
                            jVar.d = typedArrayObtainStyledAttributes.getFloat(index, jVar.d);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_CHAINSTYLE /* 47 */:
                            jVar.e = typedArrayObtainStyledAttributes.getFloat(index, jVar.e);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE /* 48 */:
                            jVar.f = typedArrayObtainStyledAttributes.getFloat(index, jVar.f);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_EDITOR_ABSOLUTEX /* 49 */:
                            jVar.g = typedArrayObtainStyledAttributes.getDimension(index, jVar.g);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_EDITOR_ABSOLUTEY /* 50 */:
                            jVar.h = typedArrayObtainStyledAttributes.getDimension(index, jVar.h);
                            break;
                        case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TAG /* 51 */:
                            jVar.j = typedArrayObtainStyledAttributes.getDimension(index, jVar.j);
                            break;
                        case 52:
                            jVar.k = typedArrayObtainStyledAttributes.getDimension(index, jVar.k);
                            break;
                        case 53:
                            jVar.l = typedArrayObtainStyledAttributes.getDimension(index, jVar.l);
                            break;
                        case 54:
                            gVar.Y = typedArrayObtainStyledAttributes.getInt(index, gVar.Y);
                            break;
                        case 55:
                            gVar.Z = typedArrayObtainStyledAttributes.getInt(index, gVar.Z);
                            break;
                        case 56:
                            gVar.a0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.a0);
                            break;
                        case 57:
                            gVar.b0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.b0);
                            break;
                        case 58:
                            gVar.c0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.c0);
                            break;
                        case 59:
                            gVar.d0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.d0);
                            break;
                        case 60:
                            jVar.b = typedArrayObtainStyledAttributes.getFloat(index, jVar.b);
                            break;
                        case 61:
                            gVar.A = m131o(typedArrayObtainStyledAttributes, index, gVar.A);
                            break;
                        case 62:
                            gVar.B = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.B);
                            break;
                        case 63:
                            gVar.C = typedArrayObtainStyledAttributes.getFloat(index, gVar.C);
                            break;
                        case Optimizer.OPTIMIZATION_GRAPH /* 64 */:
                            hVar.b = m131o(typedArrayObtainStyledAttributes, index, hVar.b);
                            break;
                        case 65:
                            if (typedArrayObtainStyledAttributes.peekValue(index).type != 3) {
                                hVar.d = e.d[typedArrayObtainStyledAttributes.getInteger(index, 0)];
                            } else {
                                hVar.d = typedArrayObtainStyledAttributes.getString(index);
                            }
                            break;
                        case 66:
                            hVar.f = typedArrayObtainStyledAttributes.getInt(index, 0);
                            break;
                        case 67:
                            hVar.h = typedArrayObtainStyledAttributes.getFloat(index, hVar.h);
                            break;
                        case 68:
                            iVar.e = typedArrayObtainStyledAttributes.getFloat(index, iVar.e);
                            break;
                        case 69:
                            gVar.e0 = typedArrayObtainStyledAttributes.getFloat(index, 1.0f);
                            break;
                        case 70:
                            gVar.f0 = typedArrayObtainStyledAttributes.getFloat(index, 1.0f);
                            break;
                        case 71:
                            Log.e("ConstraintSet", "CURRENTLY UNSUPPORTED");
                            break;
                        case 72:
                            gVar.g0 = typedArrayObtainStyledAttributes.getInt(index, gVar.g0);
                            break;
                        case 73:
                            gVar.h0 = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.h0);
                            break;
                        case 74:
                            gVar.k0 = typedArrayObtainStyledAttributes.getString(index);
                            break;
                        case 75:
                            gVar.o0 = typedArrayObtainStyledAttributes.getBoolean(index, gVar.o0);
                            break;
                        case 76:
                            hVar.e = typedArrayObtainStyledAttributes.getInt(index, hVar.e);
                            break;
                        case 77:
                            gVar.l0 = typedArrayObtainStyledAttributes.getString(index);
                            break;
                        case 78:
                            iVar.c = typedArrayObtainStyledAttributes.getInt(index, iVar.c);
                            break;
                        case 79:
                            hVar.g = typedArrayObtainStyledAttributes.getFloat(index, hVar.g);
                            break;
                        case 80:
                            gVar.m0 = typedArrayObtainStyledAttributes.getBoolean(index, gVar.m0);
                            break;
                        case 81:
                            gVar.n0 = typedArrayObtainStyledAttributes.getBoolean(index, gVar.n0);
                            break;
                        case 82:
                            hVar.c = typedArrayObtainStyledAttributes.getInteger(index, hVar.c);
                            break;
                        case 83:
                            jVar.i = m131o(typedArrayObtainStyledAttributes, index, jVar.i);
                            break;
                        case 84:
                            hVar.j = typedArrayObtainStyledAttributes.getInteger(index, hVar.j);
                            break;
                        case 85:
                            hVar.i = typedArrayObtainStyledAttributes.getFloat(index, hVar.i);
                            break;
                        case 86:
                            int i3 = typedArrayObtainStyledAttributes.peekValue(index).type;
                            if (i3 == 1) {
                                int resourceId = typedArrayObtainStyledAttributes.getResourceId(index, -1);
                                hVar.m = resourceId;
                                if (resourceId != -1) {
                                    hVar.l = -2;
                                }
                            } else if (i3 != 3) {
                                hVar.l = typedArrayObtainStyledAttributes.getInteger(index, hVar.m);
                            } else {
                                String string = typedArrayObtainStyledAttributes.getString(index);
                                hVar.k = string;
                                if (string.indexOf("/") <= 0) {
                                    hVar.l = -1;
                                } else {
                                    hVar.m = typedArrayObtainStyledAttributes.getResourceId(index, -1);
                                    hVar.l = -2;
                                }
                            }
                            break;
                        case 87:
                            Integer.toHexString(index);
                            sparseIntArray.get(index);
                            break;
                        case 88:
                        case 89:
                        case 90:
                        default:
                            Integer.toHexString(index);
                            sparseIntArray.get(index);
                            break;
                        case 91:
                            gVar.r = m131o(typedArrayObtainStyledAttributes, index, gVar.r);
                            break;
                        case 92:
                            gVar.s = m131o(typedArrayObtainStyledAttributes, index, gVar.s);
                            break;
                        case 93:
                            gVar.M = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.M);
                            break;
                        case 94:
                            gVar.T = typedArrayObtainStyledAttributes.getDimensionPixelSize(index, gVar.T);
                            break;
                        case 95:
                            m132p(gVar, typedArrayObtainStyledAttributes, index, 0);
                            break;
                        case 96:
                            m132p(gVar, typedArrayObtainStyledAttributes, index, 1);
                            break;
                        case 97:
                            gVar.p0 = typedArrayObtainStyledAttributes.getInt(index, gVar.p0);
                            break;
                    }
                    i++;
                } else if (gVar.k0 != null) {
                    gVar.j0 = null;
                }
            }
        }
        typedArrayObtainStyledAttributes.recycle();
        return c0040c;
    }

    /* JADX INFO: renamed from: o */
    public static int m131o(TypedArray typedArray, int i, int i2) {
        int resourceId = typedArray.getResourceId(i, i2);
        return resourceId == -1 ? typedArray.getInt(i, -1) : resourceId;
    }

    /* JADX WARN: Code duplicated, block: B:111:? A[RETURN, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:20:0x0035  */
    /* JADX WARN: Code duplicated, block: B:22:0x0039  */
    /* JADX WARN: Code duplicated, block: B:23:0x003e  */
    /* JADX WARN: Code duplicated, block: B:24:0x0043  */
    /* JADX WARN: Code duplicated, block: B:26:0x0047  */
    /* JADX WARN: Code duplicated, block: B:28:0x004b  */
    /* JADX WARN: Code duplicated, block: B:29:0x0050  */
    /* JADX WARN: Code duplicated, block: B:30:0x0055  */
    /* JADX WARN: Code duplicated, block: B:32:0x0059  */
    /* JADX WARN: Code duplicated, block: B:34:0x005d  */
    /* JADX WARN: Code duplicated, block: B:35:0x0066  */
    /* JADX INFO: renamed from: p */
    public static void m132p(Object obj, TypedArray typedArray, int i, int i2) {
        int dimensionPixelSize;
        f fVar;
        g gVar;
        ConstraintLayout.LayoutParams layoutParams;
        if (obj == null) {
            return;
        }
        int i3 = typedArray.peekValue(i).type;
        boolean z = true;
        int i4 = 0;
        if (i3 != 3) {
            if (i3 != 5) {
                dimensionPixelSize = typedArray.getInt(i, 0);
                if (dimensionPixelSize == -4) {
                    i4 = -2;
                } else if (dimensionPixelSize == -3 || (dimensionPixelSize != -2 && dimensionPixelSize != -1)) {
                    z = false;
                }
                if (obj instanceof ConstraintLayout.LayoutParams) {
                    layoutParams = (ConstraintLayout.LayoutParams) obj;
                    if (i2 == 0) {
                        ((ViewGroup.MarginLayoutParams) layoutParams).width = i4;
                        layoutParams.f396W = z;
                        return;
                    } else {
                        ((ViewGroup.MarginLayoutParams) layoutParams).height = i4;
                        layoutParams.f397X = z;
                        return;
                    }
                }
                if (obj instanceof g) {
                    gVar = (g) obj;
                    if (i2 == 0) {
                        gVar.c = i4;
                        gVar.m0 = z;
                        return;
                    } else {
                        gVar.d = i4;
                        gVar.n0 = z;
                        return;
                    }
                }
                if (obj instanceof f) {
                    fVar = (f) obj;
                    if (i2 == 0) {
                        fVar.b(23, i4);
                        fVar.d(80, z);
                        return;
                    } else {
                        fVar.b(21, i4);
                        fVar.d(81, z);
                        return;
                    }
                }
                return;
            }
            dimensionPixelSize = typedArray.getDimensionPixelSize(i, 0);
            z = false;
            i4 = dimensionPixelSize;
            if (obj instanceof ConstraintLayout.LayoutParams) {
                layoutParams = (ConstraintLayout.LayoutParams) obj;
                if (i2 == 0) {
                    ((ViewGroup.MarginLayoutParams) layoutParams).width = i4;
                    layoutParams.f396W = z;
                    return;
                } else {
                    ((ViewGroup.MarginLayoutParams) layoutParams).height = i4;
                    layoutParams.f397X = z;
                    return;
                }
            }
            if (obj instanceof g) {
                gVar = (g) obj;
                if (i2 == 0) {
                    gVar.c = i4;
                    gVar.m0 = z;
                    return;
                } else {
                    gVar.d = i4;
                    gVar.n0 = z;
                    return;
                }
            }
            if (obj instanceof f) {
                fVar = (f) obj;
                if (i2 == 0) {
                    fVar.b(23, i4);
                    fVar.d(80, z);
                    return;
                } else {
                    fVar.b(21, i4);
                    fVar.d(81, z);
                    return;
                }
            }
            return;
        }
        String string = typedArray.getString(i);
        if (string == null) {
            return;
        }
        int iIndexOf = string.indexOf(61);
        int length = string.length();
        if (iIndexOf <= 0 || iIndexOf >= length - 1) {
            return;
        }
        String strSubstring = string.substring(0, iIndexOf);
        String strSubstring2 = string.substring(iIndexOf + 1);
        if (strSubstring2.length() > 0) {
            String strTrim = strSubstring.trim();
            String strTrim2 = strSubstring2.trim();
            if ("ratio".equalsIgnoreCase(strTrim)) {
                if (obj instanceof ConstraintLayout.LayoutParams) {
                    ConstraintLayout.LayoutParams layoutParams2 = (ConstraintLayout.LayoutParams) obj;
                    if (i2 == 0) {
                        ((ViewGroup.MarginLayoutParams) layoutParams2).width = 0;
                    } else {
                        ((ViewGroup.MarginLayoutParams) layoutParams2).height = 0;
                    }
                    m133q(layoutParams2, strTrim2);
                    return;
                }
                if (obj instanceof g) {
                    ((g) obj).z = strTrim2;
                    return;
                } else {
                    if (obj instanceof f) {
                        ((f) obj).c(5, strTrim2);
                        return;
                    }
                    return;
                }
            }
            try {
                if ("weight".equalsIgnoreCase(strTrim)) {
                    float f = Float.parseFloat(strTrim2);
                    if (obj instanceof ConstraintLayout.LayoutParams) {
                        ConstraintLayout.LayoutParams layoutParams3 = (ConstraintLayout.LayoutParams) obj;
                        if (i2 == 0) {
                            ((ViewGroup.MarginLayoutParams) layoutParams3).width = 0;
                            layoutParams3.f381H = f;
                        } else {
                            ((ViewGroup.MarginLayoutParams) layoutParams3).height = 0;
                            layoutParams3.f382I = f;
                        }
                    } else if (obj instanceof g) {
                        g gVar2 = (g) obj;
                        if (i2 == 0) {
                            gVar2.c = 0;
                            gVar2.V = f;
                        } else {
                            gVar2.d = 0;
                            gVar2.U = f;
                        }
                    } else if (obj instanceof f) {
                        f fVar2 = (f) obj;
                        if (i2 == 0) {
                            fVar2.b(23, 0);
                            fVar2.a(f, 39);
                        } else {
                            fVar2.b(21, 0);
                            fVar2.a(f, 40);
                        }
                    }
                } else {
                    if (!"parent".equalsIgnoreCase(strTrim)) {
                        return;
                    }
                    float fMax = Math.max(0.0f, Math.min(1.0f, Float.parseFloat(strTrim2)));
                    if (obj instanceof ConstraintLayout.LayoutParams) {
                        ConstraintLayout.LayoutParams layoutParams4 = (ConstraintLayout.LayoutParams) obj;
                        if (i2 == 0) {
                            ((ViewGroup.MarginLayoutParams) layoutParams4).width = 0;
                            layoutParams4.f391R = fMax;
                            layoutParams4.f385L = 2;
                        } else {
                            ((ViewGroup.MarginLayoutParams) layoutParams4).height = 0;
                            layoutParams4.f392S = fMax;
                            layoutParams4.f386M = 2;
                        }
                    } else if (obj instanceof g) {
                        g gVar3 = (g) obj;
                        if (i2 == 0) {
                            gVar3.c = 0;
                            gVar3.e0 = fMax;
                            gVar3.Y = 2;
                        } else {
                            gVar3.d = 0;
                            gVar3.f0 = fMax;
                            gVar3.Z = 2;
                        }
                    } else if (obj instanceof f) {
                        f fVar3 = (f) obj;
                        if (i2 == 0) {
                            fVar3.b(23, 0);
                            fVar3.b(54, 2);
                        } else {
                            fVar3.b(21, 0);
                            fVar3.b(55, 2);
                        }
                    }
                }
            } catch (NumberFormatException unused) {
            }
        }
    }

    /* JADX INFO: renamed from: q */
    public static void m133q(ConstraintLayout.LayoutParams layoutParams, String str) {
        if (str != null) {
            int length = str.length();
            int iIndexOf = str.indexOf(44);
            int i = 0;
            int i2 = -1;
            if (iIndexOf > 0 && iIndexOf < length - 1) {
                String strSubstring = str.substring(0, iIndexOf);
                if (!strSubstring.equalsIgnoreCase("W")) {
                    i = strSubstring.equalsIgnoreCase("H") ? 1 : -1;
                }
                i2 = i;
                i = iIndexOf + 1;
            }
            int iIndexOf2 = str.indexOf(58);
            try {
                if (iIndexOf2 < 0 || iIndexOf2 >= length - 1) {
                    String strSubstring2 = str.substring(i);
                    if (strSubstring2.length() > 0) {
                        Float.parseFloat(strSubstring2);
                    }
                } else {
                    String strSubstring3 = str.substring(i, iIndexOf2);
                    String strSubstring4 = str.substring(iIndexOf2 + 1);
                    if (strSubstring3.length() > 0 && strSubstring4.length() > 0) {
                        float f = Float.parseFloat(strSubstring3);
                        float f2 = Float.parseFloat(strSubstring4);
                        if (f > 0.0f && f2 > 0.0f) {
                            if (i2 == 1) {
                                Math.abs(f2 / f);
                            } else {
                                Math.abs(f / f2);
                            }
                        }
                    }
                }
            } catch (NumberFormatException unused) {
            }
        }
        layoutParams.f380G = str;
    }

    /* JADX INFO: renamed from: r */
    public static void m134r(C0040c c0040c, TypedArray typedArray) {
        int i;
        int indexCount = typedArray.getIndexCount();
        f fVar = new f();
        c0040c.f547h = fVar;
        h hVar = c0040c.f543d;
        int i2 = 0;
        hVar.a = false;
        g gVar = c0040c.f544e;
        gVar.b = false;
        i iVar = c0040c.f542c;
        iVar.a = false;
        j jVar = c0040c.f545f;
        jVar.a = false;
        int i3 = 0;
        while (i3 < indexCount) {
            int index = typedArray.getIndex(i3);
            int i4 = f550i.get(index);
            SparseIntArray sparseIntArray = f549h;
            switch (i4) {
                case 2:
                    i = i2;
                    fVar.b(2, typedArray.getDimensionPixelSize(index, gVar.J));
                    break;
                case 3:
                case 4:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_LEFT_TO_RIGHT_OF /* 9 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_TO_LEFT_OF /* 10 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_START /* 25 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_END /* 26 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_BIAS /* 29 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_BIAS /* 30 */:
                case 32:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_MIN /* 33 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_PERCENT /* 35 */:
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_MIN /* 36 */:
                case 61:
                case 88:
                case 89:
                case 90:
                case 91:
                case 92:
                default:
                    Integer.toHexString(index);
                    sparseIntArray.get(index);
                    i = i2;
                    break;
                case 5:
                    i = i2;
                    fVar.c(5, typedArray.getString(index));
                    break;
                case 6:
                    i = i2;
                    fVar.b(6, typedArray.getDimensionPixelOffset(index, gVar.D));
                    break;
                case 7:
                    i = i2;
                    fVar.b(7, typedArray.getDimensionPixelOffset(index, gVar.E));
                    break;
                case 8:
                    i = i2;
                    fVar.b(8, typedArray.getDimensionPixelSize(index, gVar.K));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_TO_RIGHT_OF /* 11 */:
                    i = i2;
                    fVar.b(11, typedArray.getDimensionPixelSize(index, gVar.Q));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_TO_TOP_OF /* 12 */:
                    i = i2;
                    fVar.b(12, typedArray.getDimensionPixelSize(index, gVar.R));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_TO_BOTTOM_OF /* 13 */:
                    i = i2;
                    fVar.b(13, typedArray.getDimensionPixelSize(index, gVar.N));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_TO_TOP_OF /* 14 */:
                    i = i2;
                    fVar.b(14, typedArray.getDimensionPixelSize(index, gVar.P));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_TO_BOTTOM_OF /* 15 */:
                    i = i2;
                    fVar.b(15, typedArray.getDimensionPixelSize(index, gVar.S));
                    break;
                case 16:
                    i = i2;
                    fVar.b(16, typedArray.getDimensionPixelSize(index, gVar.O));
                    break;
                case 17:
                    i = i2;
                    fVar.b(17, typedArray.getDimensionPixelOffset(index, gVar.e));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_START_TO_START_OF /* 18 */:
                    i = i2;
                    fVar.b(18, typedArray.getDimensionPixelOffset(index, gVar.f));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_END_TO_START_OF /* 19 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.g), 19);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_END_TO_END_OF /* 20 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.x), 20);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_LEFT /* 21 */:
                    i = i2;
                    fVar.b(21, typedArray.getLayoutDimension(index, gVar.d));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_TOP /* 22 */:
                    i = i2;
                    fVar.b(22, f548g[typedArray.getInt(index, iVar.b)]);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_RIGHT /* 23 */:
                    i = i2;
                    fVar.b(23, typedArray.getLayoutDimension(index, gVar.c));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_GONE_MARGIN_BOTTOM /* 24 */:
                    i = i2;
                    fVar.b(24, typedArray.getDimensionPixelSize(index, gVar.G));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINED_WIDTH /* 27 */:
                    i = i2;
                    fVar.b(27, typedArray.getInt(index, gVar.F));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINED_HEIGHT /* 28 */:
                    i = i2;
                    fVar.b(28, typedArray.getDimensionPixelSize(index, gVar.H));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_DEFAULT /* 31 */:
                    i = i2;
                    fVar.b(31, typedArray.getDimensionPixelSize(index, gVar.L));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_WIDTH_MAX /* 34 */:
                    i = i2;
                    fVar.b(34, typedArray.getDimensionPixelSize(index, gVar.I));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_MAX /* 37 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.y), 37);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HEIGHT_PERCENT /* 38 */:
                    i = i2;
                    int resourceId = typedArray.getResourceId(index, c0040c.f540a);
                    c0040c.f540a = resourceId;
                    fVar.b(38, resourceId);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_LEFT_CREATOR /* 39 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.V), 39);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TOP_CREATOR /* 40 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.U), 40);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_RIGHT_CREATOR /* 41 */:
                    i = i2;
                    fVar.b(41, typedArray.getInt(index, gVar.W));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BOTTOM_CREATOR /* 42 */:
                    i = i2;
                    fVar.b(42, typedArray.getInt(index, gVar.X));
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_BASELINE_CREATOR /* 43 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, iVar.d), 43);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_DIMENSION_RATIO /* 44 */:
                    i = i2;
                    fVar.d(44, true);
                    fVar.a(typedArray.getDimension(index, jVar.n), 44);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_WEIGHT /* 45 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, jVar.c), 45);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_WEIGHT /* 46 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, jVar.d), 46);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_HORIZONTAL_CHAINSTYLE /* 47 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, jVar.e), 47);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_VERTICAL_CHAINSTYLE /* 48 */:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, jVar.f), 48);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_EDITOR_ABSOLUTEX /* 49 */:
                    i = i2;
                    fVar.a(typedArray.getDimension(index, jVar.g), 49);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_EDITOR_ABSOLUTEY /* 50 */:
                    i = i2;
                    fVar.a(typedArray.getDimension(index, jVar.h), 50);
                    break;
                case ConstraintLayout.LayoutParams.Table.LAYOUT_CONSTRAINT_TAG /* 51 */:
                    i = i2;
                    fVar.a(typedArray.getDimension(index, jVar.j), 51);
                    break;
                case 52:
                    i = i2;
                    fVar.a(typedArray.getDimension(index, jVar.k), 52);
                    break;
                case 53:
                    i = i2;
                    fVar.a(typedArray.getDimension(index, jVar.l), 53);
                    break;
                case 54:
                    i = i2;
                    fVar.b(54, typedArray.getInt(index, gVar.Y));
                    break;
                case 55:
                    i = i2;
                    fVar.b(55, typedArray.getInt(index, gVar.Z));
                    break;
                case 56:
                    i = i2;
                    fVar.b(56, typedArray.getDimensionPixelSize(index, gVar.a0));
                    break;
                case 57:
                    i = i2;
                    fVar.b(57, typedArray.getDimensionPixelSize(index, gVar.b0));
                    break;
                case 58:
                    i = i2;
                    fVar.b(58, typedArray.getDimensionPixelSize(index, gVar.c0));
                    break;
                case 59:
                    i = i2;
                    fVar.b(59, typedArray.getDimensionPixelSize(index, gVar.d0));
                    break;
                case 60:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, jVar.b), 60);
                    break;
                case 62:
                    i = i2;
                    fVar.b(62, typedArray.getDimensionPixelSize(index, gVar.B));
                    break;
                case 63:
                    i = i2;
                    fVar.a(typedArray.getFloat(index, gVar.C), 63);
                    break;
                case Optimizer.OPTIMIZATION_GRAPH /* 64 */:
                    i = i2;
                    fVar.b(64, m131o(typedArray, index, hVar.b));
                    break;
                case 65:
                    i = i2;
                    if (typedArray.peekValue(index).type != 3) {
                        fVar.c(65, e.d[typedArray.getInteger(index, i)]);
                    } else {
                        fVar.c(65, typedArray.getString(index));
                    }
                    break;
                case 66:
                    i = 0;
                    fVar.b(66, typedArray.getInt(index, 0));
                    break;
                case 67:
                    fVar.a(typedArray.getFloat(index, hVar.h), 67);
                    i = 0;
                    break;
                case 68:
                    fVar.a(typedArray.getFloat(index, iVar.e), 68);
                    i = 0;
                    break;
                case 69:
                    fVar.a(typedArray.getFloat(index, 1.0f), 69);
                    i = 0;
                    break;
                case 70:
                    fVar.a(typedArray.getFloat(index, 1.0f), 70);
                    i = 0;
                    break;
                case 71:
                    Log.e("ConstraintSet", "CURRENTLY UNSUPPORTED");
                    i = 0;
                    break;
                case 72:
                    fVar.b(72, typedArray.getInt(index, gVar.g0));
                    i = 0;
                    break;
                case 73:
                    fVar.b(73, typedArray.getDimensionPixelSize(index, gVar.h0));
                    i = 0;
                    break;
                case 74:
                    fVar.c(74, typedArray.getString(index));
                    i = 0;
                    break;
                case 75:
                    fVar.d(75, typedArray.getBoolean(index, gVar.o0));
                    i = 0;
                    break;
                case 76:
                    fVar.b(76, typedArray.getInt(index, hVar.e));
                    i = 0;
                    break;
                case 77:
                    fVar.c(77, typedArray.getString(index));
                    i = 0;
                    break;
                case 78:
                    fVar.b(78, typedArray.getInt(index, iVar.c));
                    i = 0;
                    break;
                case 79:
                    fVar.a(typedArray.getFloat(index, hVar.g), 79);
                    i = 0;
                    break;
                case 80:
                    fVar.d(80, typedArray.getBoolean(index, gVar.m0));
                    i = 0;
                    break;
                case 81:
                    fVar.d(81, typedArray.getBoolean(index, gVar.n0));
                    i = 0;
                    break;
                case 82:
                    fVar.b(82, typedArray.getInteger(index, hVar.c));
                    i = 0;
                    break;
                case 83:
                    fVar.b(83, m131o(typedArray, index, jVar.i));
                    i = 0;
                    break;
                case 84:
                    fVar.b(84, typedArray.getInteger(index, hVar.j));
                    i = 0;
                    break;
                case 85:
                    fVar.a(typedArray.getFloat(index, hVar.i), 85);
                    i = 0;
                    break;
                case 86:
                    int i5 = typedArray.peekValue(index).type;
                    if (i5 == 1) {
                        int resourceId2 = typedArray.getResourceId(index, -1);
                        hVar.m = resourceId2;
                        fVar.b(89, resourceId2);
                        if (hVar.m != -1) {
                            hVar.l = -2;
                            fVar.b(88, -2);
                        }
                    } else if (i5 == 3) {
                        String string = typedArray.getString(index);
                        hVar.k = string;
                        fVar.c(90, string);
                        if (hVar.k.indexOf("/") > 0) {
                            int resourceId3 = typedArray.getResourceId(index, -1);
                            hVar.m = resourceId3;
                            fVar.b(89, resourceId3);
                            hVar.l = -2;
                            fVar.b(88, -2);
                        } else {
                            hVar.l = -1;
                            fVar.b(88, -1);
                        }
                    } else {
                        int integer = typedArray.getInteger(index, hVar.m);
                        hVar.l = integer;
                        fVar.b(88, integer);
                    }
                    i = 0;
                    break;
                case 87:
                    Integer.toHexString(index);
                    sparseIntArray.get(index);
                    i = i2;
                    break;
                case 93:
                    fVar.b(93, typedArray.getDimensionPixelSize(index, gVar.M));
                    i = i2;
                    break;
                case 94:
                    fVar.b(94, typedArray.getDimensionPixelSize(index, gVar.T));
                    i = i2;
                    break;
                case 95:
                    m132p(fVar, typedArray, index, i2);
                    i = i2;
                    break;
                case 96:
                    m132p(fVar, typedArray, index, 1);
                    i = i2;
                    break;
                case 97:
                    fVar.b(97, typedArray.getInt(index, gVar.p0));
                    i = i2;
                    break;
                case 98:
                    if (MotionLayout.f100H0) {
                        int resourceId4 = typedArray.getResourceId(index, c0040c.f540a);
                        c0040c.f540a = resourceId4;
                        if (resourceId4 == -1) {
                            c0040c.f541b = typedArray.getString(index);
                        }
                    } else if (typedArray.peekValue(index).type == 3) {
                        c0040c.f541b = typedArray.getString(index);
                    } else {
                        c0040c.f540a = typedArray.getResourceId(index, c0040c.f540a);
                    }
                    i = i2;
                    break;
                case 99:
                    fVar.d(99, typedArray.getBoolean(index, gVar.h));
                    i = i2;
                    break;
            }
            i3++;
            i2 = i;
        }
    }

    /* JADX INFO: renamed from: t */
    public static String m135t(int i) {
        switch (i) {
            case 1:
                return "left";
            case 2:
                return "right";
            case 3:
                return "top";
            case 4:
                return "bottom";
            case 5:
                return "baseline";
            case 6:
                return "start";
            case 7:
                return "end";
            default:
                return "undefined";
        }
    }

    /* JADX INFO: renamed from: a */
    public final void m136a(MotionLayout motionLayout) {
        C0040c c0040c;
        int childCount = motionLayout.getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = motionLayout.getChildAt(i);
            int id = childAt.getId();
            HashMap map = this.f556f;
            if (!map.containsKey(Integer.valueOf(id))) {
                so.c.x(childAt);
            } else {
                if (this.f555e && id == -1) {
                    throw new RuntimeException("All children of ConstraintLayout must have ids to use ConstraintSet");
                }
                if (map.containsKey(Integer.valueOf(id)) && (c0040c = (C0040c) map.get(Integer.valueOf(id))) != null) {
                    j1.b.f(childAt, c0040c.f546g);
                }
            }
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m137b(ConstraintLayout constraintLayout) {
        m138c(constraintLayout);
        constraintLayout.setConstraintSet(null);
        constraintLayout.requestLayout();
    }

    /* JADX INFO: renamed from: c */
    public final void m138c(ConstraintLayout constraintLayout) {
        int childCount = constraintLayout.getChildCount();
        HashMap map = this.f556f;
        HashSet<Integer> hashSet = new HashSet(map.keySet());
        for (int i = 0; i < childCount; i++) {
            View childAt = constraintLayout.getChildAt(i);
            int id = childAt.getId();
            if (!map.containsKey(Integer.valueOf(id))) {
                so.c.x(childAt);
            } else {
                if (this.f555e && id == -1) {
                    throw new RuntimeException("All children of ConstraintLayout must have ids to use ConstraintSet");
                }
                if (id != -1 && map.containsKey(Integer.valueOf(id))) {
                    hashSet.remove(Integer.valueOf(id));
                    C0040c c0040c = (C0040c) map.get(Integer.valueOf(id));
                    if (c0040c != null) {
                        if (childAt instanceof Barrier) {
                            g gVar = c0040c.f544e;
                            gVar.i0 = 1;
                            Barrier barrier = (Barrier) childAt;
                            barrier.setId(id);
                            barrier.setType(gVar.g0);
                            barrier.setMargin(gVar.h0);
                            barrier.setAllowsGoneWidget(gVar.o0);
                            int[] iArr = gVar.j0;
                            if (iArr != null) {
                                barrier.setReferencedIds(iArr);
                            } else {
                                String str = gVar.k0;
                                if (str != null) {
                                    int[] iArrM129i = m129i(barrier, str);
                                    gVar.j0 = iArrM129i;
                                    barrier.setReferencedIds(iArrM129i);
                                }
                            }
                        }
                        ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) childAt.getLayoutParams();
                        layoutParams.m116a();
                        c0040c.m124d(layoutParams);
                        j1.b.f(childAt, c0040c.f546g);
                        childAt.setLayoutParams(layoutParams);
                        i iVar = c0040c.f542c;
                        if (iVar.c == 0) {
                            childAt.setVisibility(iVar.b);
                        }
                        childAt.setAlpha(iVar.d);
                        j jVar = c0040c.f545f;
                        childAt.setRotation(jVar.b);
                        childAt.setRotationX(jVar.c);
                        childAt.setRotationY(jVar.d);
                        childAt.setScaleX(jVar.e);
                        childAt.setScaleY(jVar.f);
                        if (jVar.i != -1) {
                            View viewFindViewById = ((View) childAt.getParent()).findViewById(jVar.i);
                            if (viewFindViewById != null) {
                                float bottom = (viewFindViewById.getBottom() + viewFindViewById.getTop()) / 2.0f;
                                float right = (viewFindViewById.getRight() + viewFindViewById.getLeft()) / 2.0f;
                                if (childAt.getRight() - childAt.getLeft() > 0 && childAt.getBottom() - childAt.getTop() > 0) {
                                    float left = right - childAt.getLeft();
                                    float top = bottom - childAt.getTop();
                                    childAt.setPivotX(left);
                                    childAt.setPivotY(top);
                                }
                            }
                        } else {
                            if (!Float.isNaN(jVar.g)) {
                                childAt.setPivotX(jVar.g);
                            }
                            if (!Float.isNaN(jVar.h)) {
                                childAt.setPivotY(jVar.h);
                            }
                        }
                        childAt.setTranslationX(jVar.j);
                        childAt.setTranslationY(jVar.k);
                        childAt.setTranslationZ(jVar.l);
                        if (jVar.m) {
                            childAt.setElevation(jVar.n);
                        }
                    }
                }
            }
        }
        for (Integer num : hashSet) {
            C0040c c0040c2 = (C0040c) map.get(num);
            if (c0040c2 != null) {
                g gVar2 = c0040c2.f544e;
                if (gVar2.i0 == 1) {
                    Barrier barrier2 = new Barrier(constraintLayout.getContext());
                    barrier2.setId(num.intValue());
                    int[] iArr2 = gVar2.j0;
                    if (iArr2 != null) {
                        barrier2.setReferencedIds(iArr2);
                    } else {
                        String str2 = gVar2.k0;
                        if (str2 != null) {
                            int[] iArrM129i2 = m129i(barrier2, str2);
                            gVar2.j0 = iArrM129i2;
                            barrier2.setReferencedIds(iArrM129i2);
                        }
                    }
                    barrier2.setType(gVar2.g0);
                    barrier2.setMargin(gVar2.h0);
                    o oVar = ConstraintLayout.f355r;
                    ConstraintLayout.LayoutParams layoutParams2 = new ConstraintLayout.LayoutParams(-2, -2);
                    barrier2.m107q();
                    c0040c2.m124d(layoutParams2);
                    constraintLayout.addView(barrier2, layoutParams2);
                }
                if (gVar2.a) {
                    View guideline = new Guideline(constraintLayout.getContext());
                    guideline.setId(num.intValue());
                    o oVar2 = ConstraintLayout.f355r;
                    ConstraintLayout.LayoutParams layoutParams3 = new ConstraintLayout.LayoutParams(-2, -2);
                    c0040c2.m124d(layoutParams3);
                    constraintLayout.addView(guideline, layoutParams3);
                }
            }
        }
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt2 = constraintLayout.getChildAt(i2);
            if (childAt2 instanceof ConstraintHelper) {
                ((ConstraintHelper) childAt2).mo30g(constraintLayout);
            }
        }
    }

    /* JADX INFO: renamed from: e */
    public final void m139e(int i, int i2) {
        C0040c c0040c;
        HashMap map = this.f556f;
        if (!map.containsKey(Integer.valueOf(i)) || (c0040c = (C0040c) map.get(Integer.valueOf(i))) == null) {
            return;
        }
        g gVar = c0040c.f544e;
        switch (i2) {
            case 1:
                gVar.j = -1;
                gVar.i = -1;
                gVar.G = -1;
                gVar.N = BasicMeasure.AT_MOST;
                return;
            case 2:
                gVar.l = -1;
                gVar.k = -1;
                gVar.H = -1;
                gVar.P = BasicMeasure.AT_MOST;
                return;
            case 3:
                gVar.n = -1;
                gVar.m = -1;
                gVar.I = 0;
                gVar.O = BasicMeasure.AT_MOST;
                return;
            case 4:
                gVar.o = -1;
                gVar.p = -1;
                gVar.J = 0;
                gVar.Q = BasicMeasure.AT_MOST;
                return;
            case 5:
                gVar.q = -1;
                gVar.r = -1;
                gVar.s = -1;
                gVar.M = 0;
                gVar.T = BasicMeasure.AT_MOST;
                return;
            case 6:
                gVar.t = -1;
                gVar.u = -1;
                gVar.L = 0;
                gVar.S = BasicMeasure.AT_MOST;
                return;
            case 7:
                gVar.v = -1;
                gVar.w = -1;
                gVar.K = 0;
                gVar.R = BasicMeasure.AT_MOST;
                return;
            case 8:
                gVar.C = -1.0f;
                gVar.B = -1;
                gVar.A = -1;
                return;
            default:
                throw new IllegalArgumentException("unknown constraint");
        }
    }

    /* JADX INFO: renamed from: f */
    public final void m140f(ConstraintLayout constraintLayout) {
        int childCount = constraintLayout.getChildCount();
        HashMap map = this.f556f;
        map.clear();
        for (int i = 0; i < childCount; i++) {
            View childAt = constraintLayout.getChildAt(i);
            ConstraintLayout.LayoutParams layoutParams = (ConstraintLayout.LayoutParams) childAt.getLayoutParams();
            int id = childAt.getId();
            if (this.f555e && id == -1) {
                throw new RuntimeException("All children of ConstraintLayout must have ids to use ConstraintSet");
            }
            if (!map.containsKey(Integer.valueOf(id))) {
                map.put(Integer.valueOf(id), new C0040c());
            }
            C0040c c0040c = (C0040c) map.get(Integer.valueOf(id));
            if (c0040c != null) {
                c0040c.f546g = j1.b.a(childAt, this.f554d);
                c0040c.m126f(id, layoutParams);
                int visibility = childAt.getVisibility();
                i iVar = c0040c.f542c;
                iVar.b = visibility;
                iVar.d = childAt.getAlpha();
                float rotation = childAt.getRotation();
                j jVar = c0040c.f545f;
                jVar.b = rotation;
                jVar.c = childAt.getRotationX();
                jVar.d = childAt.getRotationY();
                jVar.e = childAt.getScaleX();
                jVar.f = childAt.getScaleY();
                float pivotX = childAt.getPivotX();
                float pivotY = childAt.getPivotY();
                if (pivotX != 0.0d || pivotY != 0.0d) {
                    jVar.g = pivotX;
                    jVar.h = pivotY;
                }
                jVar.j = childAt.getTranslationX();
                jVar.k = childAt.getTranslationY();
                jVar.l = childAt.getTranslationZ();
                if (jVar.m) {
                    jVar.n = childAt.getElevation();
                }
                if (childAt instanceof Barrier) {
                    Barrier barrier = (Barrier) childAt;
                    boolean allowsGoneWidget = barrier.getAllowsGoneWidget();
                    g gVar = c0040c.f544e;
                    gVar.o0 = allowsGoneWidget;
                    gVar.j0 = barrier.getReferencedIds();
                    gVar.g0 = barrier.getType();
                    gVar.h0 = barrier.getMargin();
                }
            }
        }
    }

    /* JADX INFO: renamed from: g */
    public final void m141g(int i, int i2, int i3, int i4) {
        HashMap map = this.f556f;
        if (!map.containsKey(Integer.valueOf(i))) {
            map.put(Integer.valueOf(i), new C0040c());
        }
        C0040c c0040c = (C0040c) map.get(Integer.valueOf(i));
        if (c0040c == null) {
            return;
        }
        g gVar = c0040c.f544e;
        switch (i2) {
            case 1:
                if (i4 == 1) {
                    gVar.i = i3;
                    gVar.j = -1;
                    return;
                } else if (i4 == 2) {
                    gVar.j = i3;
                    gVar.i = -1;
                    return;
                } else {
                    throw new IllegalArgumentException("left to " + m135t(i4) + " undefined");
                }
            case 2:
                if (i4 == 1) {
                    gVar.k = i3;
                    gVar.l = -1;
                    return;
                } else if (i4 == 2) {
                    gVar.l = i3;
                    gVar.k = -1;
                    return;
                } else {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
            case 3:
                if (i4 == 3) {
                    gVar.m = i3;
                    gVar.n = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                    return;
                }
                if (i4 != 4) {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
                gVar.n = i3;
                gVar.m = -1;
                gVar.q = -1;
                gVar.r = -1;
                gVar.s = -1;
                return;
            case 4:
                if (i4 == 4) {
                    gVar.p = i3;
                    gVar.o = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                    return;
                }
                if (i4 != 3) {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
                gVar.o = i3;
                gVar.p = -1;
                gVar.q = -1;
                gVar.r = -1;
                gVar.s = -1;
                return;
            case 5:
                if (i4 == 5) {
                    gVar.q = i3;
                    gVar.p = -1;
                    gVar.o = -1;
                    gVar.m = -1;
                    gVar.n = -1;
                    return;
                }
                if (i4 == 3) {
                    gVar.r = i3;
                    gVar.p = -1;
                    gVar.o = -1;
                    gVar.m = -1;
                    gVar.n = -1;
                    return;
                }
                if (i4 != 4) {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
                gVar.s = i3;
                gVar.p = -1;
                gVar.o = -1;
                gVar.m = -1;
                gVar.n = -1;
                return;
            case 6:
                if (i4 == 6) {
                    gVar.u = i3;
                    gVar.t = -1;
                    return;
                } else if (i4 == 7) {
                    gVar.t = i3;
                    gVar.u = -1;
                    return;
                } else {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
            case 7:
                if (i4 == 7) {
                    gVar.w = i3;
                    gVar.v = -1;
                    return;
                } else if (i4 == 6) {
                    gVar.v = i3;
                    gVar.w = -1;
                    return;
                } else {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
            default:
                throw new IllegalArgumentException(m135t(i2) + " to " + m135t(i4) + " unknown");
        }
    }

    /* JADX INFO: renamed from: h */
    public final void m142h(int i, int i2, int i3, int i4, int i5) {
        HashMap map = this.f556f;
        if (!map.containsKey(Integer.valueOf(i))) {
            map.put(Integer.valueOf(i), new C0040c());
        }
        C0040c c0040c = (C0040c) map.get(Integer.valueOf(i));
        if (c0040c == null) {
            return;
        }
        g gVar = c0040c.f544e;
        switch (i2) {
            case 1:
                if (i4 == 1) {
                    gVar.i = i3;
                    gVar.j = -1;
                } else {
                    if (i4 != 2) {
                        throw new IllegalArgumentException("Left to " + m135t(i4) + " undefined");
                    }
                    gVar.j = i3;
                    gVar.i = -1;
                }
                gVar.G = i5;
                return;
            case 2:
                if (i4 == 1) {
                    gVar.k = i3;
                    gVar.l = -1;
                } else {
                    if (i4 != 2) {
                        throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                    }
                    gVar.l = i3;
                    gVar.k = -1;
                }
                gVar.H = i5;
                return;
            case 3:
                if (i4 == 3) {
                    gVar.m = i3;
                    gVar.n = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                } else {
                    if (i4 != 4) {
                        throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                    }
                    gVar.n = i3;
                    gVar.m = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                }
                gVar.I = i5;
                return;
            case 4:
                if (i4 == 4) {
                    gVar.p = i3;
                    gVar.o = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                } else {
                    if (i4 != 3) {
                        throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                    }
                    gVar.o = i3;
                    gVar.p = -1;
                    gVar.q = -1;
                    gVar.r = -1;
                    gVar.s = -1;
                }
                gVar.J = i5;
                return;
            case 5:
                if (i4 == 5) {
                    gVar.q = i3;
                    gVar.p = -1;
                    gVar.o = -1;
                    gVar.m = -1;
                    gVar.n = -1;
                    return;
                }
                if (i4 == 3) {
                    gVar.r = i3;
                    gVar.p = -1;
                    gVar.o = -1;
                    gVar.m = -1;
                    gVar.n = -1;
                    return;
                }
                if (i4 != 4) {
                    throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                }
                gVar.s = i3;
                gVar.p = -1;
                gVar.o = -1;
                gVar.m = -1;
                gVar.n = -1;
                return;
            case 6:
                if (i4 == 6) {
                    gVar.u = i3;
                    gVar.t = -1;
                } else {
                    if (i4 != 7) {
                        throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                    }
                    gVar.t = i3;
                    gVar.u = -1;
                }
                gVar.L = i5;
                return;
            case 7:
                if (i4 == 7) {
                    gVar.w = i3;
                    gVar.v = -1;
                } else {
                    if (i4 != 6) {
                        throw new IllegalArgumentException("right to " + m135t(i4) + " undefined");
                    }
                    gVar.v = i3;
                    gVar.w = -1;
                }
                gVar.K = i5;
                return;
            default:
                throw new IllegalArgumentException(m135t(i2) + " to " + m135t(i4) + " unknown");
        }
    }

    /* JADX INFO: renamed from: k */
    public final C0040c m143k(int i) {
        HashMap map = this.f556f;
        if (!map.containsKey(Integer.valueOf(i))) {
            map.put(Integer.valueOf(i), new C0040c());
        }
        return (C0040c) map.get(Integer.valueOf(i));
    }

    /* JADX INFO: renamed from: l */
    public final C0040c m144l(int i) {
        HashMap map = this.f556f;
        if (map.containsKey(Integer.valueOf(i))) {
            return (C0040c) map.get(Integer.valueOf(i));
        }
        return null;
    }

    /* JADX INFO: renamed from: m */
    public final void m145m(Context context, int i) {
        XmlResourceParser xml = context.getResources().getXml(i);
        try {
            for (int eventType = xml.getEventType(); eventType != 1; eventType = xml.next()) {
                if (eventType == 0) {
                    xml.getName();
                } else if (eventType == 2) {
                    String name = xml.getName();
                    C0040c c0040cM130j = m130j(context, Xml.asAttributeSet(xml), false);
                    if (name.equalsIgnoreCase("Guideline")) {
                        c0040cM130j.f544e.a = true;
                    }
                    this.f556f.put(Integer.valueOf(c0040cM130j.f540a), c0040cM130j);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (XmlPullParserException e2) {
            e2.printStackTrace();
        }
    }

    /* JADX WARN: Failed to restore switch over string. Please report as a decompilation issue */
    /* JADX INFO: renamed from: n */
    public final void m146n(Context context, XmlResourceParser xmlResourceParser) {
        try {
            int eventType = xmlResourceParser.getEventType();
            C0040c c0040cM130j = null;
            while (eventType != 1) {
                if (eventType == 0) {
                    xmlResourceParser.getName();
                } else if (eventType == 2) {
                    switch (xmlResourceParser.getName()) {
                        case "Constraint":
                            c0040cM130j = m130j(context, Xml.asAttributeSet(xmlResourceParser), false);
                            break;
                        case "ConstraintOverride":
                            c0040cM130j = m130j(context, Xml.asAttributeSet(xmlResourceParser), true);
                            break;
                        case "Guideline":
                            c0040cM130j = m130j(context, Xml.asAttributeSet(xmlResourceParser), false);
                            g gVar = c0040cM130j.f544e;
                            gVar.a = true;
                            gVar.b = true;
                            break;
                        case "Barrier":
                            c0040cM130j = m130j(context, Xml.asAttributeSet(xmlResourceParser), false);
                            c0040cM130j.f544e.i0 = 1;
                            break;
                        case "PropertySet":
                            if (c0040cM130j == null) {
                                throw new RuntimeException("XML parser error must be within a Constraint " + xmlResourceParser.getLineNumber());
                            }
                            c0040cM130j.f542c.b(context, Xml.asAttributeSet(xmlResourceParser));
                            break;
                            break;
                        case "Transform":
                            if (c0040cM130j == null) {
                                throw new RuntimeException("XML parser error must be within a Constraint " + xmlResourceParser.getLineNumber());
                            }
                            c0040cM130j.f545f.b(context, Xml.asAttributeSet(xmlResourceParser));
                            break;
                            break;
                        case "Layout":
                            if (c0040cM130j == null) {
                                throw new RuntimeException("XML parser error must be within a Constraint " + xmlResourceParser.getLineNumber());
                            }
                            c0040cM130j.f544e.b(context, Xml.asAttributeSet(xmlResourceParser));
                            break;
                            break;
                        case "Motion":
                            if (c0040cM130j == null) {
                                throw new RuntimeException("XML parser error must be within a Constraint " + xmlResourceParser.getLineNumber());
                            }
                            c0040cM130j.f543d.b(context, Xml.asAttributeSet(xmlResourceParser));
                            break;
                            break;
                        case "CustomAttribute":
                        case "CustomMethod":
                            if (c0040cM130j == null) {
                                throw new RuntimeException("XML parser error must be within a Constraint " + xmlResourceParser.getLineNumber());
                            }
                            j1.b.e(context, xmlResourceParser, c0040cM130j.f546g);
                            break;
                            break;
                    }
                } else if (eventType == 3) {
                    String lowerCase = xmlResourceParser.getName().toLowerCase(Locale.ROOT);
                    switch (lowerCase.hashCode()) {
                        case -2075718416:
                            if (lowerCase.equals("guideline")) {
                            }
                            break;
                        case -190376483:
                            if (lowerCase.equals("constraint")) {
                            }
                            break;
                        case 426575017:
                            if (lowerCase.equals("constraintoverride")) {
                            }
                            break;
                        case 2146106725:
                            if (lowerCase.equals("constraintset")) {
                            }
                            break;
                    }
                    if (r4 == 0) {
                        return;
                    }
                    if (r4 == 1 || r4 == 2 || r4 == 3) {
                        this.f556f.put(Integer.valueOf(c0040cM130j.f540a), c0040cM130j);
                        c0040cM130j = null;
                    }
                }
                eventType = xmlResourceParser.next();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (XmlPullParserException e2) {
            e2.printStackTrace();
        }
    }

    /* JADX INFO: renamed from: s */
    public final void m147s(int i, int i2, int i3) {
        C0040c c0040cM143k = m143k(i);
        switch (i2) {
            case 1:
                c0040cM143k.f544e.G = i3;
                return;
            case 2:
                c0040cM143k.f544e.H = i3;
                return;
            case 3:
                c0040cM143k.f544e.I = i3;
                return;
            case 4:
                c0040cM143k.f544e.J = i3;
                return;
            case 5:
                c0040cM143k.f544e.M = i3;
                return;
            case 6:
                c0040cM143k.f544e.L = i3;
                return;
            case 7:
                c0040cM143k.f544e.K = i3;
                return;
            default:
                throw new IllegalArgumentException("unknown constraint");
        }
    }
}
