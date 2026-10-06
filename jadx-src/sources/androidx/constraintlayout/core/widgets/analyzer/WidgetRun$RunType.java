package androidx.constraintlayout.core.widgets.analyzer;

/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* JADX WARN: Unknown enum class pattern. Please report as an issue! */
/* JADX INFO: loaded from: classes.dex */
final class WidgetRun$RunType {
    public static final WidgetRun$RunType CENTER;
    public static final WidgetRun$RunType END;
    public static final WidgetRun$RunType NONE;
    public static final WidgetRun$RunType START;

    /* JADX INFO: renamed from: a */
    public static final /* synthetic */ WidgetRun$RunType[] f1a;

    static {
        WidgetRun$RunType widgetRun$RunType = new WidgetRun$RunType("NONE", 0);
        NONE = widgetRun$RunType;
        WidgetRun$RunType widgetRun$RunType2 = new WidgetRun$RunType("START", 1);
        START = widgetRun$RunType2;
        WidgetRun$RunType widgetRun$RunType3 = new WidgetRun$RunType("END", 2);
        END = widgetRun$RunType3;
        WidgetRun$RunType widgetRun$RunType4 = new WidgetRun$RunType("CENTER", 3);
        CENTER = widgetRun$RunType4;
        f1a = new WidgetRun$RunType[]{widgetRun$RunType, widgetRun$RunType2, widgetRun$RunType3, widgetRun$RunType4};
    }

    public static WidgetRun$RunType valueOf(String str) {
        return (WidgetRun$RunType) Enum.valueOf(WidgetRun$RunType.class, str);
    }

    public static WidgetRun$RunType[] values() {
        return (WidgetRun$RunType[]) f1a.clone();
    }
}
