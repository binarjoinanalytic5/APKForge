package com.SecShell.SecShell;

import android.content.ComponentName;
import android.content.ServiceConnection;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;

/* JADX INFO: renamed from: com.SecShell.SecShell.b */
/* JADX INFO: loaded from: classes.dex */
class ServiceConnectionC0047b implements ServiceConnection {
    ServiceConnectionC0047b() {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.content.ServiceConnection
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) throws Exception {
        try {
            int[] iArr = new int[0];
            try {
                C0045H.access$002(new Messenger(iBinder));
                Message messageObtain = Message.obtain((Handler) null, 1000);
                messageObtain.replyTo = C0045H.access$100();
                C0045H.access$000().send(messageObtain);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        } catch (Exception ex1) {
            throw ex1;
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.content.ServiceConnection
    public void onServiceDisconnected(ComponentName componentName) throws Exception {
        try {
            int[] iArr = new int[0];
        } catch (Exception ex1) {
            throw ex1;
        }
    }
}
