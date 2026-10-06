package com.google.firebase.crashlytics.ndk;

import java.io.File;
import java.io.FilenameFilter;

/* JADX INFO: renamed from: com.google.firebase.crashlytics.ndk.c */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class C0058c implements FilenameFilter {
    @Override // java.io.FilenameFilter
    public final boolean accept(File file, String str) {
        boolean z = JniNativeApi.f623b;
        return str.toLowerCase().endsWith(".apk");
    }
}
