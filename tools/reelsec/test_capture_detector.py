#!/usr/bin/env python3
import tempfile
from pathlib import Path
from capture_detector import run

def main():
    with tempfile.TemporaryDirectory() as d:
        r=Path(d)
        (r/"AndroidManifest.xml").write_text("<manifest/>")
        (r/"x.smali").write_text("const/high16 v0, 0x2000\ninvoke-virtual {v1}, Landroid/view/Window;->setFlags")
        out=run(r)
        cats=out["category_counts"]
        assert "FLAG_SECURE" in cats
        assert out["causal_proof"] is False
    print("capture_detector: PASS")

if __name__=="__main__": main()
