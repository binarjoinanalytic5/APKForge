package com.google.firebase.messaging;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.res.XmlResourceParser;
import android.util.Log;
import android.util.SparseArray;
import androidx.constraintlayout.widget.C0041d;
import androidx.constraintlayout.widget.ConstraintLayout;
import com.google.android.gms.common.util.PlatformVersion;
import java.io.IOException;
import java.util.List;
import org.xmlpull.v1.XmlPullParserException;

/* JADX INFO: renamed from: com.google.firebase.messaging.o */
/* JADX INFO: loaded from: classes.dex */
public final class C0082o {

    /* JADX INFO: renamed from: a */
    public int f736a;

    /* JADX INFO: renamed from: b */
    public int f737b;

    /* JADX INFO: renamed from: c */
    public final Object f738c;

    /* JADX INFO: renamed from: d */
    public Object f739d;

    /* JADX INFO: renamed from: e */
    public Object f740e;

    /* JADX WARN: Code duplicated, block: B:32:0x0072  */
    /* JADX WARN: Failed to restore switch over string. Please report as a decompilation issue */
    public C0082o(Context context, ConstraintLayout constraintLayout, int i) {
        this.f736a = -1;
        this.f737b = -1;
        this.f739d = new SparseArray();
        this.f740e = new SparseArray();
        this.f738c = constraintLayout;
        XmlResourceParser xml = context.getResources().getXml(i);
        try {
            int eventType = xml.getEventType();
            j1.d dVar = null;
            while (true) {
                byte b = 1;
                if (eventType == 1) {
                    return;
                }
                if (eventType == 0) {
                    xml.getName();
                } else if (eventType == 2) {
                    String name = xml.getName();
                    switch (name.hashCode()) {
                        case -1349929691:
                            if (!name.equals("ConstraintSet")) {
                                b = -1;
                            } else {
                                b = 4;
                            }
                            break;
                        case 80204913:
                            if (!name.equals("State")) {
                                b = -1;
                            } else {
                                b = 2;
                            }
                            break;
                        case 1382829617:
                            if (!name.equals("StateSet")) {
                                b = -1;
                            }
                            break;
                        case 1657696882:
                            if (!name.equals("layoutDescription")) {
                                b = -1;
                            } else {
                                b = 0;
                            }
                            break;
                        case 1901439077:
                            if (!name.equals("Variant")) {
                                b = -1;
                            } else {
                                b = 3;
                            }
                            break;
                        default:
                            b = -1;
                            break;
                    }
                    if (b == 2) {
                        dVar = new j1.d(context, xml);
                        ((SparseArray) this.f739d).put(dVar.a, dVar);
                    } else if (b == 3) {
                        j1.e eVar = new j1.e(context, xml);
                        if (dVar != null) {
                            dVar.a(eVar);
                        }
                    } else if (b == 4) {
                        m275e(context, xml);
                    }
                }
                eventType = xml.next();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (XmlPullParserException e2) {
            e2.printStackTrace();
        }
    }

    /* JADX INFO: renamed from: c */
    public static String m271c(ef.h hVar) {
        hVar.a();
        ef.j jVar = hVar.c;
        String str = jVar.e;
        if (str != null) {
            return str;
        }
        hVar.a();
        String str2 = jVar.b;
        if (!str2.startsWith("1:")) {
            return str2;
        }
        String[] strArrSplit = str2.split(":");
        if (strArrSplit.length < 2) {
            return null;
        }
        String str3 = strArrSplit[1];
        if (str3.isEmpty()) {
            return null;
        }
        return str3;
    }

    /* JADX INFO: renamed from: a */
    public synchronized String m272a() {
        try {
            if (((String) this.f739d) == null) {
                m276f();
            }
        } catch (Throwable th) {
            throw th;
        }
        return (String) this.f739d;
    }

    /* JADX INFO: renamed from: b */
    public synchronized String m273b() {
        try {
            if (((String) this.f740e) == null) {
                m276f();
            }
        } catch (Throwable th) {
            throw th;
        }
        return (String) this.f740e;
    }

    /* JADX WARN: Code duplicated, block: B:24:0x004c A[Catch: all -> 0x0027, TRY_ENTER, TryCatch #0 {, blocks: (B:3:0x0001, B:8:0x000a, B:10:0x001d, B:15:0x0029, B:17:0x002f, B:19:0x0041, B:21:0x0047, B:24:0x004c, B:26:0x005f, B:28:0x0065, B:31:0x006a, B:33:0x0070, B:35:0x0075, B:34:0x0073), top: B:43:0x0001 }] */
    /* JADX WARN: Code duplicated, block: B:31:0x006a A[Catch: all -> 0x0027, TRY_ENTER, TryCatch #0 {, blocks: (B:3:0x0001, B:8:0x000a, B:10:0x001d, B:15:0x0029, B:17:0x002f, B:19:0x0041, B:21:0x0047, B:24:0x004c, B:26:0x005f, B:28:0x0065, B:31:0x006a, B:33:0x0070, B:35:0x0075, B:34:0x0073), top: B:43:0x0001 }] */
    /* JADX WARN: Code duplicated, block: B:33:0x0070 A[Catch: all -> 0x0027, TryCatch #0 {, blocks: (B:3:0x0001, B:8:0x000a, B:10:0x001d, B:15:0x0029, B:17:0x002f, B:19:0x0041, B:21:0x0047, B:24:0x004c, B:26:0x005f, B:28:0x0065, B:31:0x006a, B:33:0x0070, B:35:0x0075, B:34:0x0073), top: B:43:0x0001 }] */
    /* JADX WARN: Code duplicated, block: B:34:0x0073 A[Catch: all -> 0x0027, TryCatch #0 {, blocks: (B:3:0x0001, B:8:0x000a, B:10:0x001d, B:15:0x0029, B:17:0x002f, B:19:0x0041, B:21:0x0047, B:24:0x004c, B:26:0x005f, B:28:0x0065, B:31:0x006a, B:33:0x0070, B:35:0x0075, B:34:0x0073), top: B:43:0x0001 }] */
    /* JADX INFO: renamed from: d */
    public boolean m274d() {
        int i;
        List<ResolveInfo> listQueryBroadcastReceivers;
        synchronized (this) {
            i = this.f737b;
            if (i == 0) {
                PackageManager packageManager = ((Context) this.f738c).getPackageManager();
                if (packageManager.checkPermission("com.google.android.c2dm.permission.SEND", "com.google.android.gms") == -1) {
                    Log.e("FirebaseMessaging", "Google Play services missing or without correct permission.");
                    i = 0;
                } else if (PlatformVersion.isAtLeastO()) {
                    Intent intent = new Intent("com.google.iid.TOKEN_REQUEST");
                    intent.setPackage("com.google.android.gms");
                    listQueryBroadcastReceivers = packageManager.queryBroadcastReceivers(intent, 0);
                    if (listQueryBroadcastReceivers != null) {
                        if (PlatformVersion.isAtLeastO()) {
                            this.f737b = 2;
                        } else {
                            this.f737b = 1;
                        }
                        i = this.f737b;
                    } else {
                        if (PlatformVersion.isAtLeastO()) {
                            this.f737b = 2;
                        } else {
                            this.f737b = 1;
                        }
                        i = this.f737b;
                    }
                } else {
                    Intent intent2 = new Intent("com.google.android.c2dm.intent.REGISTER");
                    intent2.setPackage("com.google.android.gms");
                    List<ResolveInfo> listQueryIntentServices = packageManager.queryIntentServices(intent2, 0);
                    if (listQueryIntentServices == null || listQueryIntentServices.size() <= 0) {
                        Intent intent3 = new Intent("com.google.iid.TOKEN_REQUEST");
                        intent3.setPackage("com.google.android.gms");
                        listQueryBroadcastReceivers = packageManager.queryBroadcastReceivers(intent3, 0);
                        if (listQueryBroadcastReceivers != null || listQueryBroadcastReceivers.size() <= 0) {
                            if (PlatformVersion.isAtLeastO()) {
                                this.f737b = 2;
                            } else {
                                this.f737b = 1;
                            }
                            i = this.f737b;
                        } else {
                            this.f737b = 2;
                            i = 2;
                        }
                    } else {
                        this.f737b = 1;
                        i = 1;
                    }
                }
            }
        }
        return i != 0;
    }

    /* JADX INFO: renamed from: e */
    public void m275e(Context context, XmlResourceParser xmlResourceParser) {
        C0041d c0041d = new C0041d();
        int attributeCount = xmlResourceParser.getAttributeCount();
        for (int i = 0; i < attributeCount; i++) {
            String attributeName = xmlResourceParser.getAttributeName(i);
            String attributeValue = xmlResourceParser.getAttributeValue(i);
            if (attributeName != null && attributeValue != null && "id".equals(attributeName)) {
                int identifier = attributeValue.contains("/") ? context.getResources().getIdentifier(attributeValue.substring(attributeValue.indexOf(47) + 1), "id", context.getPackageName()) : -1;
                if (identifier == -1) {
                    if (attributeValue.length() > 1) {
                        identifier = Integer.parseInt(attributeValue.substring(1));
                    } else {
                        Log.e("ConstraintLayoutStates", "error in parsing id");
                    }
                }
                c0041d.m146n(context, xmlResourceParser);
                ((SparseArray) this.f740e).put(identifier, c0041d);
                return;
            }
        }
    }

    /* JADX INFO: renamed from: f */
    public synchronized void m276f() {
        PackageInfo packageInfo;
        try {
            packageInfo = ((Context) this.f738c).getPackageManager().getPackageInfo(((Context) this.f738c).getPackageName(), 0);
        } catch (PackageManager.NameNotFoundException e) {
            e.toString();
            packageInfo = null;
        }
        if (packageInfo != null) {
            this.f739d = Integer.toString(packageInfo.versionCode);
            this.f740e = packageInfo.versionName;
        }
    }

    public C0082o(Context context) {
        this.f737b = 0;
        this.f738c = context;
    }
}
