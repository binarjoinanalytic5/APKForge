package com.google.firebase.messaging;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.internal.ShowFirstParty;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import j$.util.Objects;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "RemoteMessageCreator")
@SafeParcelable.Reserved({1})
public final class RemoteMessage extends AbstractSafeParcelable {
    public static final Parcelable.Creator<RemoteMessage> CREATOR = new ba.y(10);
    public static final int PRIORITY_HIGH = 1;
    public static final int PRIORITY_NORMAL = 2;
    public static final int PRIORITY_UNKNOWN = 0;

    /* JADX INFO: renamed from: a */
    public final Bundle f660a;
    private Map<String, String> data;
    private C0087t notification;

    @SafeParcelable.Constructor
    public RemoteMessage(@SafeParcelable.Param(id = 2) Bundle bundle) {
        this.f660a = bundle;
    }

    private int getMessagePriority(String str) {
        if ("high".equals(str)) {
            return 1;
        }
        return "normal".equals(str) ? 2 : 0;
    }

    @Nullable
    public String getCollapseKey() {
        return this.f660a.getString("collapse_key");
    }

    @NonNull
    public Map<String, String> getData() {
        if (this.data == null) {
            androidx.collection.g gVar = new androidx.collection.g(0);
            Bundle bundle = this.f660a;
            for (String str : bundle.keySet()) {
                Object obj = bundle.get(str);
                if (obj instanceof String) {
                    String str2 = (String) obj;
                    if (!str.startsWith("google.") && !str.startsWith("gcm.") && !str.equals("from") && !str.equals("message_type") && !str.equals("collapse_key")) {
                        gVar.put(str, str2);
                    }
                }
            }
            this.data = gVar;
        }
        return this.data;
    }

    @Nullable
    public String getFrom() {
        return this.f660a.getString("from");
    }

    @Nullable
    public String getMessageId() {
        Bundle bundle = this.f660a;
        String string = bundle.getString("google.message_id");
        return string == null ? bundle.getString("message_id") : string;
    }

    @Nullable
    public String getMessageType() {
        return this.f660a.getString("message_type");
    }

    @Nullable
    public C0087t getNotification() {
        if (this.notification == null) {
            Bundle bundle = this.f660a;
            if (C0083p.m277k(bundle)) {
                C0083p c0083p = new C0083p(bundle);
                C0087t c0087t = new C0087t();
                c0083p.m287i("gcm.n.title");
                c0083p.m284f("gcm.n.title");
                Object[] objArrM283e = c0083p.m283e("gcm.n.title");
                if (objArrM283e != null) {
                    String[] strArr = new String[objArrM283e.length];
                    for (int i = 0; i < objArrM283e.length; i++) {
                        strArr[i] = String.valueOf(objArrM283e[i]);
                    }
                }
                c0083p.m287i("gcm.n.body");
                c0083p.m284f("gcm.n.body");
                Object[] objArrM283e2 = c0083p.m283e("gcm.n.body");
                if (objArrM283e2 != null) {
                    String[] strArr2 = new String[objArrM283e2.length];
                    for (int i2 = 0; i2 < objArrM283e2.length; i2++) {
                        strArr2[i2] = String.valueOf(objArrM283e2[i2]);
                    }
                }
                c0083p.m287i("gcm.n.icon");
                if (TextUtils.isEmpty(c0083p.m287i("gcm.n.sound2"))) {
                    c0083p.m287i("gcm.n.sound");
                }
                c0083p.m287i("gcm.n.tag");
                c0083p.m287i("gcm.n.color");
                c0083p.m287i("gcm.n.click_action");
                c0083p.m287i("gcm.n.android_channel_id");
                String strM287i = c0083p.m287i("gcm.n.link_android");
                if (TextUtils.isEmpty(strM287i)) {
                    strM287i = c0083p.m287i("gcm.n.link");
                }
                if (!TextUtils.isEmpty(strM287i)) {
                    Uri.parse(strM287i);
                }
                c0083p.m287i("gcm.n.image");
                c0083p.m287i("gcm.n.ticker");
                c0083p.m280b("gcm.n.notification_priority");
                c0083p.m280b("gcm.n.visibility");
                c0083p.m280b("gcm.n.notification_count");
                c0083p.m279a("gcm.n.sticky");
                c0083p.m279a("gcm.n.local_only");
                c0083p.m279a("gcm.n.default_sound");
                c0083p.m279a("gcm.n.default_vibrate_timings");
                c0083p.m279a("gcm.n.default_light_settings");
                String strM287i2 = c0083p.m287i("gcm.n.event_time");
                if (!TextUtils.isEmpty(strM287i2)) {
                    try {
                        Long.parseLong(strM287i2);
                    } catch (NumberFormatException unused) {
                        C0083p.m278m("gcm.n.event_time");
                    }
                }
                c0083p.m282d();
                c0083p.m288j();
                this.notification = c0087t;
            }
        }
        return this.notification;
    }

    public int getOriginalPriority() {
        Bundle bundle = this.f660a;
        String string = bundle.getString("google.original_priority");
        if (string == null) {
            string = bundle.getString("google.priority");
        }
        return getMessagePriority(string);
    }

    public int getPriority() {
        Bundle bundle = this.f660a;
        String string = bundle.getString("google.delivered_priority");
        if (string == null) {
            if ("1".equals(bundle.getString("google.priority_reduced"))) {
                return 2;
            }
            string = bundle.getString("google.priority");
        }
        return getMessagePriority(string);
    }

    @Nullable
    @ShowFirstParty
    public byte[] getRawData() {
        return this.f660a.getByteArray("rawData");
    }

    @Nullable
    public String getSenderId() {
        return this.f660a.getString("google.c.sender.id");
    }

    public long getSentTime() {
        Object obj = this.f660a.get("google.sent_time");
        if (obj instanceof Long) {
            return ((Long) obj).longValue();
        }
        if (!(obj instanceof String)) {
            return 0L;
        }
        try {
            return Long.parseLong((String) obj);
        } catch (NumberFormatException unused) {
            Objects.toString(obj);
            return 0L;
        }
    }

    @Nullable
    @Deprecated
    public String getTo() {
        return this.f660a.getString("google.to");
    }

    public int getTtl() {
        Object obj = this.f660a.get("google.ttl");
        if (obj instanceof Integer) {
            return ((Integer) obj).intValue();
        }
        if (!(obj instanceof String)) {
            return 0;
        }
        try {
            return Integer.parseInt((String) obj);
        } catch (NumberFormatException unused) {
            Objects.toString(obj);
            return 0;
        }
    }

    @KeepForSdk
    public Intent toIntent() {
        Intent intent = new Intent();
        intent.putExtras(this.f660a);
        return intent;
    }

    public void writeToParcel(@NonNull Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeBundle(parcel, 2, this.f660a, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
