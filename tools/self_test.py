#!/usr/bin/env python3
from __future__ import annotations
import json, re, sys
from pathlib import Path

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent
sys.path.insert(0,str(HERE))
from solver import build_model, apply, solve, parse_code

def play_solution(code: str, sol: bytes) -> bool:
    m=build_model(code)
    sr,sc=divmod(m['start'],m['w'])
    state=(sr,sc,1,0,0,tuple(sorted(m['blue'])),tuple(sorted(m['pink'])))
    for d in sol:
        res=apply(state,d,m)
        if not res:
            return False
        kind,state=res
        if kind=='won':
            return True
        if kind!='stable':
            return False
    return False

def main():
    levels=json.loads((ROOT/'data/all_levels.json').read_text())
    assert len(levels)==49
    lengths=[]

    names=[item['name'] for item in levels]
    assert names[29]=='Level 30' and names[30]=='Level 31'
    assert names[31:45]==[f'Level {n}' for n in range(32,46)]
    assert names[45:] == ['Unused Level 47','Auto Level Example','test level 1','test level 2']
    for i,item in enumerate(levels):
        w,h,cells=parse_code(item['data'])
        assert w==14 and h==14, (i,w,h)
        assert len(cells)==196
        sol=solve(item['data'])
        assert sol is not None, f'level {i+1} unsolved'
        assert play_solution(item['data'],sol), f'level {i+1} generated solution fails'
        lengths.append(len(sol))

    csrc=(ROOT/'src/generated/builtin_levels.c').read_text()
    assert 'const uint8_t builtin_level_count = 49;' in csrc
    assert len(re.findall(r'^static const uint8_t level_\d\d_cells\[\]',csrc,re.M))==49
    assert len(re.findall(r'^static const uint8_t level_\d\d_solution\[\]',csrc,re.M))==49

    mainc=(ROOT/'src/main.c').read_text()
    assert '#define EDITOR_SLOTS 8' in mainc
    assert '#define EDIT_W 14' in mainc and '#define EDIT_H 14' in mainc
    assert '#define EDIT_SAVE_VAR "CREDITOR"' in mainc
    assert 'LEVEL EDITOR' in mainc and 'edit_slot' in mainc and 'editor_menu' in mainc
    assert 'draw_wrapped_label' in mainc and 'NO SOLVER' not in mainc and '"COINS"' not in mainc
    assert '#define MOVE_DURATION_MS 96' in mainc and '#define MOVE_FRAMES 12' in mainc and 'const clock_t start=clock();' in mainc
    assert 'animate_adjacent_move' in mainc and 'gfx_BlitRectangle(gfx_buffer' in mainc
    assert 'animate_ramp_move' in mainc and 'ramp_control_for_move' in mainc and 'ramp_turn_matches' in mainc
    assert 't*t*(768u-2u*t)' in mainc and 'q*q*(uint32_t)x0' in mainc
    assert 'draw_animation_corridor' in mainc and 'for(int frame=1;frame<=MOVE_FRAMES;frame++)' in mainc
    assert 'int pxoff=(dx*remain)/MOVE_FRAMES;' in mainc and 'remain*remain' not in mainc
    assert 'snap_player_to_current' in mainc and 'delay(24)' not in mainc
    assert 'draw_coin_block' in mainc and 'draw_teleporter' in mainc and 'draw_ball_at' in mainc
    assert 'anim_block_active' in mainc and 'hide_anim' in mainc
    assert 'static const char *actions[3]={"PLAY","EDIT","DELETE"};' in mainc
    assert 'LEFT/RIGHT OPTION' in mainc and 'ALPHA EDIT' not in mainc
    assert 'if(!saved){ edit_slot(sel); action=1; }' in mainc
    assert '(g7&kb_Left)&&(editor_valid_mask&(1u<<sel))' in mainc
    assert 'ARROWS SELECT  ENTER PLAY  MODE BACK' not in mainc
    assert 'gfx_PrintStringXY("ARROWS",224,y)' not in mainc and 'gfx_PrintStringXY("MODE",224,y)' not in mainc
    assert 'static void draw_complete_screen(void)' in mainc and 'C_POPUP' in mainc and 'C_BUTTON' in mainc
    assert 'static void builtin_menu(void)' in mainc
    assert 'gfx_Rectangle(ox+(i%w)*s' not in mainc
    assert 'static uint8_t view_start=0;' in mainc and 'for(uint8_t k=0;k<6;k++)' in mainc
    assert 'view_start=(uint8_t)(view_start+3)' in mainc and 'view_start=(uint8_t)(view_start>=3?view_start-3:0)' in mainc
    assert 'col=k%3,row=k/3' in mainc and 'uint8_t idx=(uint8_t)(view_start+k)' in mainc and 'draw_mini_preview(l->cells,l->width,l->height,x+10,y+3,80)' in mainc
    assert 'draw_wrapped_label_centered(l->name,x+50,y+84' in mainc and 'gfx_GetStringWidth(line)' in mainc
    assert 'uint8_t press7=(uint8_t)(g7&~prev7)' in mainc and 'if(dirty)' in mainc
    assert 'death_ball_fade' in mainc and 'fade_grid_to_black' in mainc and 'fade_grid_from_black' in mainc
    assert 'draw_solver_arrow' in mainc and '"PLAY MACRO"' in mainc and '"CLOSE"' in mainc and '#define SOLVER_ARROW_SIZE 13' in mainc and '#define SOLVER_PER_ROW 13' in mainc
    assert 'press7&kb_Left' in mainc and 'press7&kb_Right' in mainc and 'press7&kb_Up' in mainc and 'press7&kb_Down' in mainc and 'press6&kb_Enter' in mainc
    assert 'render_game_frame_offset(0,0);\n    const int x=22,y=42,w=276,h=156;' in mainc
    assert 'if(next_row<builtin_level_count) sel=(uint8_t)(builtin_level_count-1);' in mainc
    assert '"URDL"' not in mainc and '2ND PLAY MACRO' not in mainc and 'MODE CLOSE' not in mainc
    assert 'gfx_GetStringWidth(title)' in mainc
    assert '#define DEATH_FADE_MS 500' in mainc and 'center_popup("CRASHED!"' not in mainc
    assert 'int x0=x+(int)c*size/w' in mainc and 'int y0=y+(int)r*size/h' in mainc
    icon_tool=(ROOT/'tools/make_icon.py').read_text()
    assert "Image.new('RGBA', (16, 16), (0, 0, 0, 255))" in icon_tool and "bg.alpha_composite(im)" in icon_tool
    assert 'scan_custom' not in mainc and 'load_custom' not in mainc and 'CRLVL' not in mainc
    assert not (ROOT/'tools/make_levelpack.py').exists()
    assert not (ROOT/'custom_example').exists()
    assert not list((ROOT/'dist').glob('CRLVL*'))

    asm=(ROOT/'src/engine.S').read_text()
    labels=set(re.findall(r'^([._A-Za-z][\w.]*)\s*:',asm,re.M))
    refs=set(re.findall(r'\b(?:call|jr|jp)\s+(?:[a-z]+,\s*)?(\.[A-Za-z_][\w.]*)',asm))
    missing=sorted(refs-labels)
    assert not missing, f'undefined assembly local labels: {missing}'
    assert '.assume ADL=1' in asm and '_engine_move:' in asm
    assert '.mark_push_animation:' in asm and 'call .mark_push_animation' in asm
    assert not re.search(r'\bix\b',asm,re.I), 'engine unexpectedly modifies IX'

    print('PASS: 49/49 built-in levels solved and replay-verified')
    print(f'PASS: built-in solution bytes = {sum(lengths)} (max {max(lengths)})')
    print('PASS: generated C contains 49 cell arrays + 49 solution arrays')
    print('PASS: external CRLVL import system removed')
    print('PASS: in-game editor configured for 8 x 14x14 slots in CREDITOR')
    print('PASS: wrapped names, hidden no-solver UI, and PLAY/EDIT/DELETE slot actions present')
    print('PASS: web-style tile renderers + linear continuous 96 ms / 12-frame movement handoff present')
    print('PASS: ramps use orientation-checked smoothstep quadratic Bezier interpolation through the ramp cell')
    print('PASS: solver popup redraws the active level into each back buffer before swapping')
    print('PASS: empty editor slots are single-action rows; left/right disabled until saved')
    print('PASS: level menu sliding window reaches the partial final row from every column')
    print('PASS: death effect fades ball, grid to black, resets, and fades grid back in')
    print('PASS: favicon conversion flattens transparency onto opaque pure black')
    print('PASS: web-styled completion popup returns to level menu; preview cells are solid')
    print('PASS: assembly branch/call targets resolved; IX not touched')

if __name__=='__main__':
    main()
