package androidx.constraintlayout.core.widgets.analyzer;

import java.util.ArrayList;
import java.util.Iterator;

/* JADX INFO: renamed from: androidx.constraintlayout.core.widgets.analyzer.a */
/* JADX INFO: loaded from: classes.dex */
public class C0000a implements e1.e {

    /* JADX INFO: renamed from: d */
    public final AbstractC0007h f5d;

    /* JADX INFO: renamed from: f */
    public int f7f;

    /* JADX INFO: renamed from: g */
    public int f8g;

    /* JADX INFO: renamed from: a */
    public AbstractC0007h f2a = null;

    /* JADX INFO: renamed from: b */
    public boolean f3b = false;

    /* JADX INFO: renamed from: c */
    public boolean f4c = false;

    /* JADX INFO: renamed from: e */
    public DependencyNode$Type f6e = DependencyNode$Type.UNKNOWN;

    /* JADX INFO: renamed from: h */
    public int f9h = 1;

    /* JADX INFO: renamed from: i */
    public C0001b f10i = null;

    /* JADX INFO: renamed from: j */
    public boolean f11j = false;

    /* JADX INFO: renamed from: k */
    public final ArrayList f12k = new ArrayList();

    /* JADX INFO: renamed from: l */
    public final ArrayList f13l = new ArrayList();

    public C0000a(AbstractC0007h abstractC0007h) {
        this.f5d = abstractC0007h;
    }

    /* JADX INFO: renamed from: a */
    public final void m0a(e1.e eVar) {
        ArrayList<C0000a> arrayList = this.f13l;
        Iterator it = arrayList.iterator();
        while (it.hasNext()) {
            if (!((C0000a) it.next()).f11j) {
                return;
            }
        }
        this.f4c = true;
        AbstractC0007h abstractC0007h = this.f2a;
        if (abstractC0007h != null) {
            abstractC0007h.a(this);
        }
        if (this.f3b) {
            this.f5d.a(this);
            return;
        }
        C0000a c0000a = null;
        int i = 0;
        for (C0000a c0000a2 : arrayList) {
            if (!(c0000a2 instanceof C0001b)) {
                i++;
                c0000a = c0000a2;
            }
        }
        if (c0000a != null && i == 1 && c0000a.f11j) {
            C0001b c0001b = this.f10i;
            if (c0001b != null) {
                if (!c0001b.f11j) {
                    return;
                } else {
                    this.f7f = this.f9h * c0001b.f8g;
                }
            }
            mo3d(c0000a.f8g + this.f7f);
        }
        AbstractC0007h abstractC0007h2 = this.f2a;
        if (abstractC0007h2 != null) {
            abstractC0007h2.a(this);
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m1b(AbstractC0007h abstractC0007h) {
        this.f12k.add(abstractC0007h);
        if (this.f11j) {
            abstractC0007h.a(abstractC0007h);
        }
    }

    /* JADX INFO: renamed from: c */
    public final void m2c() {
        this.f13l.clear();
        this.f12k.clear();
        this.f11j = false;
        this.f8g = 0;
        this.f4c = false;
        this.f3b = false;
    }

    /* JADX INFO: renamed from: d */
    public void mo3d(int i) {
        if (this.f11j) {
            return;
        }
        this.f11j = true;
        this.f8g = i;
        for (e1.e eVar : this.f12k) {
            eVar.a(eVar);
        }
    }

    public final String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.f5d.f21b.k0);
        sb.append(":");
        sb.append(this.f6e);
        sb.append("(");
        sb.append(this.f11j ? Integer.valueOf(this.f8g) : "unresolved");
        sb.append(") <t=");
        sb.append(this.f13l.size());
        sb.append(":d=");
        sb.append(this.f12k.size());
        sb.append(">");
        return sb.toString();
    }
}
