package com.google.firebase.crashlytics.internal.common;

import android.os.Build;
import android.text.TextUtils;
import java.util.HashMap;
import java.util.Locale;

/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* JADX WARN: Unknown enum class pattern. Please report as an issue! */
/* JADX INFO: loaded from: classes.dex */
final class CommonUtils$Architecture {
    public static final CommonUtils$Architecture ARM64;
    public static final CommonUtils$Architecture ARMV6;
    public static final CommonUtils$Architecture ARMV7;
    public static final CommonUtils$Architecture ARMV7S;
    public static final CommonUtils$Architecture ARM_UNKNOWN;
    public static final CommonUtils$Architecture PPC;
    public static final CommonUtils$Architecture PPC64;
    public static final CommonUtils$Architecture UNKNOWN;
    public static final CommonUtils$Architecture X86_32;
    public static final CommonUtils$Architecture X86_64;

    /* JADX INFO: renamed from: a */
    public static final HashMap f587a;

    /* JADX INFO: renamed from: b */
    public static final /* synthetic */ CommonUtils$Architecture[] f588b;

    static {
        CommonUtils$Architecture commonUtils$Architecture = new CommonUtils$Architecture("X86_32", 0);
        X86_32 = commonUtils$Architecture;
        CommonUtils$Architecture commonUtils$Architecture2 = new CommonUtils$Architecture("X86_64", 1);
        X86_64 = commonUtils$Architecture2;
        CommonUtils$Architecture commonUtils$Architecture3 = new CommonUtils$Architecture("ARM_UNKNOWN", 2);
        ARM_UNKNOWN = commonUtils$Architecture3;
        CommonUtils$Architecture commonUtils$Architecture4 = new CommonUtils$Architecture("PPC", 3);
        PPC = commonUtils$Architecture4;
        CommonUtils$Architecture commonUtils$Architecture5 = new CommonUtils$Architecture("PPC64", 4);
        PPC64 = commonUtils$Architecture5;
        CommonUtils$Architecture commonUtils$Architecture6 = new CommonUtils$Architecture("ARMV6", 5);
        ARMV6 = commonUtils$Architecture6;
        CommonUtils$Architecture commonUtils$Architecture7 = new CommonUtils$Architecture("ARMV7", 6);
        ARMV7 = commonUtils$Architecture7;
        CommonUtils$Architecture commonUtils$Architecture8 = new CommonUtils$Architecture("UNKNOWN", 7);
        UNKNOWN = commonUtils$Architecture8;
        CommonUtils$Architecture commonUtils$Architecture9 = new CommonUtils$Architecture("ARMV7S", 8);
        ARMV7S = commonUtils$Architecture9;
        CommonUtils$Architecture commonUtils$Architecture10 = new CommonUtils$Architecture("ARM64", 9);
        ARM64 = commonUtils$Architecture10;
        f588b = new CommonUtils$Architecture[]{commonUtils$Architecture, commonUtils$Architecture2, commonUtils$Architecture3, commonUtils$Architecture4, commonUtils$Architecture5, commonUtils$Architecture6, commonUtils$Architecture7, commonUtils$Architecture8, commonUtils$Architecture9, commonUtils$Architecture10};
        HashMap map = new HashMap(4);
        f587a = map;
        map.put("armeabi-v7a", commonUtils$Architecture7);
        map.put("armeabi", commonUtils$Architecture6);
        map.put("arm64-v8a", commonUtils$Architecture10);
        map.put("x86", commonUtils$Architecture);
    }

    public static CommonUtils$Architecture getValue() {
        String str = Build.CPU_ABI;
        if (TextUtils.isEmpty(str)) {
            return UNKNOWN;
        }
        CommonUtils$Architecture commonUtils$Architecture = (CommonUtils$Architecture) f587a.get(str.toLowerCase(Locale.US));
        return commonUtils$Architecture == null ? UNKNOWN : commonUtils$Architecture;
    }

    public static CommonUtils$Architecture valueOf(String str) {
        return (CommonUtils$Architecture) Enum.valueOf(CommonUtils$Architecture.class, str);
    }

    public static CommonUtils$Architecture[] values() {
        return (CommonUtils$Architecture[]) f588b.clone();
    }
}
