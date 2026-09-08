#!/usr/bin/env python3
import argparse, json, re
from pathlib import Path
from solver import parse_code, solve

def c_ident(s):
    return re.sub(r'[^A-Za-z0-9_]', '_', s)

def chunks(seq,n=24):
    for i in range(0,len(seq),n): yield seq[i:i+n]

def main():
    ap=argparse.ArgumentParser(description='Generate built-in Cyber Roller level data for the TI-84+ CE port.')
    ap.add_argument('levels_json')
    ap.add_argument('-o','--output',default='../src/generated/builtin_levels.c')
    args=ap.parse_args()
    levels=json.load(open(args.levels_json,encoding='utf-8'))
    out=[]
    out += ['#include "builtin_levels.h"', '']
    entries=[]
    for i,item in enumerate(levels):
        w,h,cells=parse_code(item['data'])
        sol=solve(item['data'])
        if sol is None: raise SystemExit(f'No solution found for {item["name"]}')
        cname=f'level_{i:02d}_cells'; sname=f'level_{i:02d}_solution'
        out.append(f'static const uint8_t {cname}[] = {{')
        for ch in chunks(cells): out.append('    '+', '.join(map(str,ch))+',')
        out += ['};', f'static const uint8_t {sname}[] = {{']
        for ch in chunks(list(sol)): out.append('    '+', '.join(map(str,ch))+',')
        out += ['};','']
        name=item['name'].replace('\\','\\\\').replace('"','\\"')
        entries.append(f'    {{"{name}", {w}, {h}, {cname}, {len(sol)}, {sname}}}')
    out += [f'const BuiltinLevel builtin_levels[{len(entries)}] = {{', ',\n'.join(entries), '};', f'const uint8_t builtin_level_count = {len(entries)};', '']
    op=Path(args.output); op.parent.mkdir(parents=True,exist_ok=True); op.write_text('\n'.join(out),encoding='utf-8')
    print(f'wrote {op} with {len(entries)} levels')

if __name__=='__main__': main()
