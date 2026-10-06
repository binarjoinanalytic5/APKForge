package androidx.constraintlayout.core.widgets.analyzer;

/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* JADX WARN: Unknown enum class pattern. Please report as an issue! */
/* JADX INFO: loaded from: classes.dex */
final class DependencyNode$Type {
    public static final DependencyNode$Type BASELINE;
    public static final DependencyNode$Type BOTTOM;
    public static final DependencyNode$Type HORIZONTAL_DIMENSION;
    public static final DependencyNode$Type LEFT;
    public static final DependencyNode$Type RIGHT;
    public static final DependencyNode$Type TOP;
    public static final DependencyNode$Type UNKNOWN;
    public static final DependencyNode$Type VERTICAL_DIMENSION;

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ DependencyNode$Type[] f0a;

    static {
        DependencyNode$Type dependencyNode$Type = new DependencyNode$Type("UNKNOWN", 0);
        UNKNOWN = dependencyNode$Type;
        DependencyNode$Type dependencyNode$Type2 = new DependencyNode$Type("HORIZONTAL_DIMENSION", 1);
        HORIZONTAL_DIMENSION = dependencyNode$Type2;
        DependencyNode$Type dependencyNode$Type3 = new DependencyNode$Type("VERTICAL_DIMENSION", 2);
        VERTICAL_DIMENSION = dependencyNode$Type3;
        DependencyNode$Type dependencyNode$Type4 = new DependencyNode$Type("LEFT", 3);
        LEFT = dependencyNode$Type4;
        DependencyNode$Type dependencyNode$Type5 = new DependencyNode$Type("RIGHT", 4);
        RIGHT = dependencyNode$Type5;
        DependencyNode$Type dependencyNode$Type6 = new DependencyNode$Type("TOP", 5);
        TOP = dependencyNode$Type6;
        DependencyNode$Type dependencyNode$Type7 = new DependencyNode$Type("BOTTOM", 6);
        BOTTOM = dependencyNode$Type7;
        DependencyNode$Type dependencyNode$Type8 = new DependencyNode$Type("BASELINE", 7);
        BASELINE = dependencyNode$Type8;
        f0a = new DependencyNode$Type[]{dependencyNode$Type, dependencyNode$Type2, dependencyNode$Type3, dependencyNode$Type4, dependencyNode$Type5, dependencyNode$Type6, dependencyNode$Type7, dependencyNode$Type8};
    }

    public static DependencyNode$Type valueOf(String str) {
        return (DependencyNode$Type) Enum.valueOf(DependencyNode$Type.class, str);
    }

    public static DependencyNode$Type[] values() {
        return (DependencyNode$Type[]) f0a.clone();
    }
}
