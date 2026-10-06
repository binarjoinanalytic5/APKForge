package com.google.firebase.crashlytics.ndk;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import androidx.credentials.playservices.controllers.CreatePublicKeyCredential.PublicKeyCredentialControllerUtility$GetGMSVersion$;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;

/* JADX INFO: loaded from: classes.dex */
class JniNativeApi implements ag.c {

    /* JADX INFO: renamed from: b */
    public static final boolean f623b;

    /* JADX INFO: renamed from: c */
    public static final C0058c f624c = new C0058c();

    /* JADX INFO: renamed from: a */
    public final Context f625a;

    static {
        boolean z;
        try {
            System.loadLibrary("crashlytics");
            z = true;
        } catch (UnsatisfiedLinkError e) {
            Log.e("FirebaseCrashlytics", "libcrashlytics could not be loaded. This APK may not have been compiled for this device's architecture. NDK crashes will not be reported to Crashlytics:\n" + e.getLocalizedMessage(), null);
            z = false;
        }
        f623b = z;
    }

    public JniNativeApi(Context context) {
        this.f625a = context;
    }

    /* JADX INFO: renamed from: a */
    public static void m214a(ArrayList arrayList, PackageInfo packageInfo) {
        ApplicationInfo applicationInfo = packageInfo.applicationInfo;
        String[] strArr = applicationInfo.splitSourceDirs;
        if (strArr != null) {
            Collections.addAll(arrayList, strArr);
        }
        File file = new File(applicationInfo.dataDir, a1.a.o("files/splitcompat/", Build.VERSION.SDK_INT >= 28 ? Long.toString(PublicKeyCredentialControllerUtility$GetGMSVersion$.ExternalSyntheticApiModelOutline0.m(packageInfo)) : Integer.toString(packageInfo.versionCode), "/verified-splits"));
        if (!file.exists()) {
            file.getAbsolutePath();
            return;
        }
        File[] fileArrListFiles = file.listFiles(f624c);
        if (fileArrListFiles == null) {
            fileArrListFiles = new File[0];
        }
        file.getAbsolutePath();
        for (File file2 : fileArrListFiles) {
            file2.getName();
            arrayList.add(file2.getAbsolutePath());
        }
    }

    private native boolean nativeInit(String[] strArr, Object obj);

    /* JADX INFO: renamed from: b */
    public final boolean m215b(AssetManager assetManager, String str) {
        String str2 = Build.CPU_ABI;
        Context context = this.f625a;
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), Build.VERSION.SDK_INT >= 24 ? 9216 : 1024);
            ArrayList<String> arrayList = new ArrayList(10);
            arrayList.add(packageInfo.applicationInfo.sourceDir);
            m214a(arrayList, packageInfo);
            String[] strArr = packageInfo.applicationInfo.sharedLibraryFiles;
            if (strArr != null) {
                Collections.addAll(arrayList, strArr);
            }
            ArrayList arrayList2 = new ArrayList(10);
            File parentFile = new File(packageInfo.applicationInfo.nativeLibraryDir).getParentFile();
            if (parentFile != null) {
                arrayList2.add(new File(parentFile, str2).getPath());
                if (str2.startsWith("arm64")) {
                    arrayList2.add(new File(parentFile, "arm64").getPath());
                } else if (str2.startsWith("arm")) {
                    arrayList2.add(new File(parentFile, "arm").getPath());
                }
            }
            for (String str3 : arrayList) {
                if (str3.endsWith(".apk")) {
                    arrayList2.add(str3 + "!/lib/" + str2);
                }
            }
            arrayList2.add(System.getProperty("java.library.path"));
            arrayList2.add(packageInfo.applicationInfo.nativeLibraryDir);
            String str4 = File.pathSeparator;
            String[] strArr2 = {TextUtils.join(str4, arrayList), TextUtils.join(str4, arrayList2)};
            return f623b && nativeInit(new String[]{strArr2[0], strArr2[1], str}, assetManager);
        } catch (PackageManager.NameNotFoundException e) {
            Log.e("FirebaseCrashlytics", "Unable to compose package paths", e);
            throw new RuntimeException(e);
        }
    }
}
