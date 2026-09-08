#!/usr/bin/env python3
from PIL import Image
from pathlib import Path
import argparse

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('input')
    ap.add_argument('-o','--output',default='../src/generated/logo.c')
    ns=ap.parse_args()
    im=Image.open(ns.input).convert('RGBA')
    bbox=im.getbbox(); im=im.crop(bbox)
    target_w=188
    target_h=max(1,round(im.height*target_w/im.width))
    im=im.resize((target_w,target_h),Image.Resampling.LANCZOS)

    data=[]
    for r,g,b,a in im.getdata():
        if a < 64: data.append(31)
        elif g>90 and b>90 and r<120: data.append(2)
        elif r+g+b < 160: data.append(0)
        else: data.append(2)
    lines=['#include <stdint.h>',f'const uint8_t cyber_logo[{2+len(data)}] = {{',f'    {target_w}, {target_h},']
    for i in range(0,len(data),28): lines.append('    '+', '.join(map(str,data[i:i+28]))+',')
    lines += ['};',f'const uint8_t cyber_logo_width = {target_w};',f'const uint8_t cyber_logo_height = {target_h};','']
    Path(ns.output).write_text('\n'.join(lines),encoding='utf-8')
    print(ns.output,target_w,target_h,len(data))
if __name__=='__main__': main()
