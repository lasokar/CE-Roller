#!/usr/bin/env python3
from pathlib import Path
from PIL import Image
import argparse

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('input', help='original favicon.ico')
    ap.add_argument('-o', '--output', default='icon.png')
    ns = ap.parse_args()
    im = Image.open(ns.input).convert('RGBA')
    im = im.resize((16, 16), Image.Resampling.LANCZOS)

    bg = Image.new('RGBA', (16, 16), (0, 0, 0, 255))
    bg.alpha_composite(im)
    im = bg.convert('RGB')
    Path(ns.output).parent.mkdir(parents=True, exist_ok=True)
    im.save(ns.output)
    print(ns.output, im.size)

if __name__ == '__main__':
    main()
