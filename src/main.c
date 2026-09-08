#include <graphx.h>
#include <keypadc.h>
#include <fileioc.h>
#include <sys/timers.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include "engine.h"
#include "generated/builtin_levels.h"
#include "generated/logo.h"

#define NAME_MAX 40
#define EDITOR_SLOTS 8
#define EDIT_W 14
#define EDIT_H 14
#define EDIT_CELLS (EDIT_W * EDIT_H)
#define EDIT_SAVE_VAR "CREDITOR"
#define EDIT_SAVE_VERSION 1

uint8_t level_w, level_h;
uint8_t base_grid[CR_MAX_CELLS], grid[CR_MAX_CELLS];
uint8_t base_blocks[CR_MAX_CELLS], blocks[CR_MAX_CELLS];
uint8_t tele_r[CR_MAX_CELLS], tele_c[CR_MAX_CELLS];
uint8_t player_r, player_c, start_r, start_c, coin_count;

static uint8_t solution[CR_MAX_SOLUTION];
static uint16_t solution_len;
static char active_name[NAME_MAX+1];
static bool animation_enabled=true;
static bool in_game=false;
static uint8_t render_r,render_c;
static bool render_pos_valid=false;

uint8_t anim_block_active, anim_block_type;
uint8_t anim_block_from_r, anim_block_from_c, anim_block_to_r, anim_block_to_c;

#define MOVE_DURATION_MS 96
#define MOVE_FRAMES 12
#define SOLVER_ARROW_SIZE 13
#define SOLVER_ARROW_STEP 18
#define SOLVER_ROW_STEP 24
#define SOLVER_PER_ROW 13
#define SOLVER_VISIBLE_ROWS 2
#define DEATH_FADE_MS 500
#define DEATH_FADE_STEPS 16
#define GAME_PANEL_W 68
#define GAME_BOARD_X GAME_PANEL_W
#define GAME_BOARD_W (320-GAME_PANEL_W)

static uint8_t editor_cells[EDITOR_SLOTS][EDIT_CELLS];
static uint8_t editor_valid_mask;

enum { C_BLACK=0, C_FLOOR=1, C_CYAN=2, C_GOAL=3, C_COIN_OUTER=4,
       C_GATE_OUTER=5, C_GATE_INNER=6, C_COIN_INNER=7, C_POPUP=8, C_BUTTON=9,
       C_ORANGE=10, C_PURPLE=11, C_VOID=12, C_BLUE=13, C_PINK=14,
       C_BALL=15, C_RAMP=16, C_RAMP_UNUSED=17, C_RAMP_DARK=18, C_RAMP_EDGE=19,
       C_LIME=20, C_REDTP=21, C_WHITE=22, C_GRAY=23, C_DARK=24,
       C_DARKCYAN=25, C_SOLVER_BG=28, C_TRANSPARENT=31 };

static const uint16_t palette[32] = {
    gfx_RGBTo1555(0,0,0),
    gfx_RGBTo1555(105,168,79),
    gfx_RGBTo1555(0,242,255),
    gfx_RGBTo1555(248,255,0),
    gfx_RGBTo1555(227,99,98),
    gfx_RGBTo1555(74,82,74),
    gfx_RGBTo1555(156,158,156),
    gfx_RGBTo1555(246,178,101),
    gfx_RGBTo1555(6,70,140),
    gfx_RGBTo1555(8,119,216),
    gfx_RGBTo1555(255,140,0),
    gfx_RGBTo1555(170,0,255),
    gfx_RGBTo1555(0,0,0),
    gfx_RGBTo1555(10,0,255),
    gfx_RGBTo1555(255,47,157),
    gfx_RGBTo1555(255,0,0),
    gfx_RGBTo1555(179,95,0),
    gfx_RGBTo1555(205,120,20),
    gfx_RGBTo1555(154,82,0),
    gfx_RGBTo1555(0,0,0),
    gfx_RGBTo1555(124,255,0),
    gfx_RGBTo1555(255,32,32),
    gfx_RGBTo1555(255,255,255), gfx_RGBTo1555(145,145,145),
    gfx_RGBTo1555(24,24,30), gfx_RGBTo1555(0,90,100), gfx_RGBTo1555(50,50,58), gfx_RGBTo1555(90,90,100),
    gfx_RGBTo1555(3,30,61), gfx_RGBTo1555(210,210,220), gfx_RGBTo1555(255,255,255), gfx_RGBTo1555(255,0,255)
};

static const char *tile_names[22] = {
    "", "FLOOR", "WALL", "GOAL", "COIN", "GATE 1", "GATE 2", "GATE 3", "GATE 4", "GATE 5",
    "ORANGE TP", "PURPLE TP", "VOID", "BLUE BLOCK", "PINK BLOCK", "START",
    "RAMP NW", "RAMP NE", "RAMP SW", "RAMP SE", "LIME TP", "RED TP"
};

static void draw_wrapped_label(const char *text,int x,int y,uint8_t max_chars,uint8_t max_lines,uint8_t color) {
    char line[24]; uint8_t line_no=0; const char *p=text;
    gfx_SetTextFGColor(color);
    while(*p && line_no<max_lines) {
        uint8_t n=0,last_space=255; const char *start=p;
        while(p[n] && n<max_chars) { if(p[n]==' ') last_space=n; n++; }
        if(p[n] && last_space!=255) n=last_space;
        if(n>=sizeof(line)) n=sizeof(line)-1;
        memcpy(line,start,n); line[n]=0;
        while(n && line[n-1]==' ') line[--n]=0;
        gfx_PrintStringXY(line,x,y+line_no*9);
        p=start+n; while(*p==' ') p++; line_no++;
    }
}

static void draw_wrapped_label_centered(const char *text,int center_x,int y,uint8_t max_chars,uint8_t max_lines,uint8_t color) {
    char line[24]; uint8_t line_no=0; const char *p=text;
    gfx_SetTextFGColor(color);
    while(*p && line_no<max_lines) {
        uint8_t n=0,last_space=255; const char *start=p;
        while(p[n] && n<max_chars) { if(p[n]==' ') last_space=n; n++; }
        if(p[n] && last_space!=255) n=last_space;
        if(n>=sizeof(line)) n=sizeof(line)-1;
        memcpy(line,start,n); line[n]=0;
        while(n && line[n-1]==' ') line[--n]=0;
        int tx=center_x-(int)gfx_GetStringWidth(line)/2;
        gfx_PrintStringXY(line,tx,y+line_no*9);
        p=start+n; while(*p==' ') p++; line_no++;
    }
}

static void wait_release(void) { do { kb_Scan(); } while (kb_AnyKey()); }
static bool read_exact(void *p,uint16_t n,uint8_t h) { return ti_Read(p,1,n,h)==n; }

static void build_teleports(void) {
    uint16_t n=(uint16_t)level_w*level_h;
    for(uint16_t i=0;i<n;i++){ tele_r[i]=255; tele_c[i]=255; }
    for(uint16_t i=0;i<n;i++) {
        uint8_t t=base_grid[i];
        if(t!=10 && t!=11 && t!=20 && t!=21) continue;
        uint8_t ir=i/level_w, ic=i%level_w; uint16_t best=0xFFFF; uint16_t bestd=0xFFFF;
        for(uint16_t j=0;j<n;j++) if(j!=i && base_grid[j]==t) {
            int dr=(int)(j/level_w)-ir, dc=(int)(j%level_w)-ic;
            uint16_t d=(uint16_t)(dr*dr+dc*dc);
            if(d<bestd){bestd=d; best=j;}
        }
        if(best!=0xFFFF){ tele_r[i]=best/level_w; tele_c[i]=best%level_w; }
    }
}

void engine_reset(void) {
    uint16_t n=(uint16_t)level_w*level_h;
    memcpy(grid,base_grid,n); memcpy(blocks,base_blocks,n);
    player_r=start_r; player_c=start_c; coin_count=0;
    render_r=player_r; render_c=player_c; render_pos_valid=true; anim_block_active=0;
}

static bool install_level(const char *name,uint8_t w,uint8_t h,const uint8_t *cells,const uint8_t *sol,uint16_t slen) {
    if(!w||!h||w>20||h>20||((uint16_t)w*h)>CR_MAX_CELLS||slen>CR_MAX_SOLUTION) return false;
    level_w=w; level_h=h; memset(base_grid,1,sizeof base_grid); memset(base_blocks,0,sizeof base_blocks);
    bool found_start=false, found_goal=false; uint16_t n=(uint16_t)w*h;
    for(uint16_t i=0;i<n;i++) {
        uint8_t t=cells[i]; if(t<1||t>21) return false;
        if(t==13||t==14){ base_blocks[i]=t; base_grid[i]=1; }
        else if(t==15){ start_r=i/w; start_c=i%w; base_grid[i]=1; found_start=true; }
        else { base_grid[i]=t; if(t==3) found_goal=true; }
    }
    if(!found_start||!found_goal) return false;
    strncpy(active_name,name,NAME_MAX); active_name[NAME_MAX]=0;
    solution_len=slen; if(slen) memcpy(solution,sol,slen);
    build_teleports(); engine_reset(); return true;
}

static bool load_builtin(uint8_t idx) {
    if(idx>=builtin_level_count) return false;
    const BuiltinLevel *l=&builtin_levels[idx];
    return install_level(l->name,l->width,l->height,l->cells,l->solution,l->solution_len);
}

static bool editor_level_valid(const uint8_t *cells) {
    uint8_t starts=0, goals=0;
    for(uint16_t i=0;i<EDIT_CELLS;i++) {
        uint8_t t=cells[i];
        if(t<1||t>21) return false;
        if(t==15) starts++;
        else if(t==3) goals++;
    }
    return starts==1 && goals>0;
}

static void editor_template(uint8_t *cells) {
    for(uint16_t i=0;i<EDIT_CELLS;i++) cells[i]=1;
    for(uint8_t x=0;x<EDIT_W;x++){ cells[x]=2; cells[(EDIT_H-1)*EDIT_W+x]=2; }
    for(uint8_t y=0;y<EDIT_H;y++){ cells[y*EDIT_W]=2; cells[y*EDIT_W+EDIT_W-1]=2; }
    cells[(EDIT_H-2)*EDIT_W+1]=15;
    cells[EDIT_W+EDIT_W-2]=3;
}

static void load_editor_data(void) {
    editor_valid_mask=0;
    for(uint8_t s=0;s<EDITOR_SLOTS;s++) memset(editor_cells[s],1,EDIT_CELLS);
    uint8_t h=ti_Open(EDIT_SAVE_VAR,"r"); if(!h) return;
    uint8_t head[6];
    if(!read_exact(head,6,h)||memcmp(head,"CRED",4)||head[4]!=EDIT_SAVE_VERSION){ti_Close(h);return;}
    if(ti_Read(editor_cells,1,sizeof editor_cells,h)!=sizeof editor_cells){ti_Close(h);return;}
    editor_valid_mask=head[5]; ti_Close(h);
    for(uint8_t s=0;s<EDITOR_SLOTS;s++) if((editor_valid_mask&(1u<<s))&&!editor_level_valid(editor_cells[s])) editor_valid_mask&=(uint8_t)~(1u<<s);
}

static bool save_editor_data(void) {
    uint8_t h=ti_Open(EDIT_SAVE_VAR,"w"); if(!h) return false;
    uint8_t head[6]={'C','R','E','D',EDIT_SAVE_VERSION,editor_valid_mask};
    bool ok=ti_Write(head,1,6,h)==6 && ti_Write(editor_cells,1,sizeof editor_cells,h)==sizeof editor_cells;
    ti_Close(h); return ok;
}

static bool load_editor_level(uint8_t slot) {
    if(slot>=EDITOR_SLOTS || !(editor_valid_mask&(1u<<slot))) return false;
    char name[NAME_MAX+1]; sprintf(name,"CUSTOM %u",(unsigned int)(slot+1));
    return install_level(name,EDIT_W,EDIT_H,editor_cells[slot],NULL,0);
}

static uint8_t tile_size(void) {
    uint8_t sx=(GAME_BOARD_W-2)/level_w, sy=238/level_h, s=sx<sy?sx:sy;
    if(s>17)s=17; if(s<8)s=8; return s;
}
static uint8_t tile_color(uint8_t t) {
    if(t==2)return C_CYAN; if(t==3)return C_GOAL; if(t==12)return C_VOID;
    if(t==10)return C_ORANGE; if(t==11)return C_PURPLE; if(t==20)return C_LIME; if(t==21)return C_REDTP;
    return C_FLOOR;
}

static int scale85(int v,int cell) { return (v*cell + 42)/85; }
static int ce_cell(int pitch) { return pitch>0 ? pitch : 1; }

static void draw_cell(int x,int y,int s,uint8_t fill) {
    int cell=ce_cell(s), inset=scale85(2,cell); if(inset<1)inset=1;
    gfx_SetColor(C_BLACK); gfx_FillRectangle(x,y,cell,cell);
    if(cell>inset*2){ gfx_SetColor(fill); gfx_FillRectangle(x+inset,y+inset,cell-inset*2,cell-inset*2); }
}

static void draw_filled_ellipse(int cx,int cy,int rx,int ry,uint8_t color) {
    if(rx<1)rx=1; if(ry<1)ry=1;
    gfx_SetColor(color);
    for(int yy=-ry;yy<=ry;yy++) {
        long rem=(long)ry*ry-(long)yy*yy;
        int xx=0;
        while(xx<rx && (long)(xx+1)*(xx+1)*(long)ry*ry <= rem*(long)rx*rx) xx++;
        gfx_HorizLine(cx-xx,cy+yy,xx*2+1);
    }
}

static void draw_coin_shape(int cx,int cy,int cell) {

    int ro=scale85(28,cell), ri=scale85(24,cell); if(ro<2)ro=2;if(ri<1)ri=1;
    draw_filled_ellipse(cx,cy,ro,ro,C_COIN_OUTER);
    draw_filled_ellipse(cx,cy,ri,ri,C_COIN_INNER);
}

static void draw_coin(int x,int y,int s) {
    int cell=ce_cell(s); draw_cell(x,y,s,C_FLOOR);
    draw_coin_shape(x+cell/2,y+cell/2,cell);
}

static void draw_coin_block(int x,int y,int s,uint8_t n) {
    int cell=ce_cell(s), b=scale85(4,cell); if(b<1)b=1;
    int cx=x+cell/2,cy=y+cell/2;
    gfx_SetColor(C_GATE_OUTER); gfx_FillRectangle(x,y,cell,cell);
    if(cell>b*2){gfx_SetColor(C_GATE_INNER);gfx_FillRectangle(x+b,y+b,cell-b*2,cell-b*2);}
    int ro=scale85(33,cell),ri=scale85(29,cell); if(ro<2)ro=2;if(ri<1)ri=1;if(ri>=ro)ri=ro-1;
    draw_filled_ellipse(cx,cy,ro,ro,C_COIN_OUTER);
    draw_filled_ellipse(cx,cy,ri,ri,C_COIN_INNER);
    char num[2]={(char)('0'+n),0};
    gfx_SetTextScale(1,1);
    gfx_SetTextFGColor(C_BALL);
    gfx_PrintStringXY(num,cx-2,cy-4);
}

static void draw_teleporter(int x,int y,int s,uint8_t color) {
    int cell=ce_cell(s), inset=scale85(2,cell); if(inset<1)inset=1;
    int inner=cell-inset*2;
    gfx_SetColor(C_BLACK); gfx_FillRectangle(x,y,cell,cell);
    if(inner>0){ gfx_SetColor(color); gfx_FillRectangle(x+inset,y+inset,inner,inner); }

    int box=cell/2, off=(cell-box)/2;
    gfx_SetColor(C_WHITE); gfx_FillRectangle(x+off,y+off,box,box);
}

static void draw_ball_at(int cx,int cy,int s) {
    int cell=ce_cell(s);

    int outer=scale85(44,cell),inner=scale85(37,cell);
    if(outer<2)outer=2;if(inner<1)inner=1;
    gfx_SetColor(C_BLACK); gfx_FillCircle(cx,cy,outer);
    gfx_SetColor(C_BALL); gfx_FillCircle(cx,cy,inner);
}

static void draw_ramp(int x,int y,int s,uint8_t id) {
    int cell=ce_cell(s), a=scale85(2,cell); if(a<1)a=1; int b=cell-a;

    draw_cell(x,y,s,C_FLOOR);
    gfx_SetColor(C_RAMP);
    if(id==16) gfx_FillTriangle(x+a,y+b,x+b,y+a,x+b,y+b);
    else if(id==17) gfx_FillTriangle(x+a,y+a,x+a,y+b,x+b,y+b);
    else if(id==18) gfx_FillTriangle(x+a,y+a,x+b,y+a,x+b,y+b);
    else gfx_FillTriangle(x+a,y+a,x+b,y+a,x+a,y+b);

    int q1=(cell+3)/4,q3=(cell*3+1)/4;
    gfx_SetColor(C_RAMP_DARK);
    if(id==16) {
        gfx_FillTriangle(x+b,y+q1,x+q3,y+q3,x+q1,y+b);
        gfx_FillTriangle(x+b,y+q1,x+q1,y+b,x+b,y+b);
    } else if(id==17) {
        gfx_FillTriangle(x+q3,y+b,x+q1,y+q3,x+a,y+q1);
        gfx_FillTriangle(x+q3,y+b,x+a,y+q1,x+a,y+b);
    } else if(id==18) {
        gfx_FillTriangle(x+q1,y+a,x+q3,y+q1,x+b,y+q3);
        gfx_FillTriangle(x+q1,y+a,x+b,y+q3,x+b,y+a);
    } else {
        gfx_FillTriangle(x+a,y+q3,x+q1,y+q1,x+q3,y+a);
        gfx_FillTriangle(x+a,y+q3,x+q3,y+a,x+a,y+a);
    }
    gfx_SetColor(C_BLACK);
    if(id==16||id==19) gfx_Line(x+a,y+b,x+b,y+a);
    else gfx_Line(x+a,y+a,x+b,y+b);
}

static void draw_block(int x,int y,int s,uint8_t b) {
    int cell=ce_cell(s), inset=scale85(2,cell); if(inset<1)inset=1;
    int cx=x+cell/2,cy=y+cell/2;
    int len=scale85(18,cell),head=scale85(12,cell),tip=scale85(20,cell),lw=scale85(8,cell);
    if(len<2)len=2;if(head<2)head=2;if(tip<3)tip=3;if(lw<1)lw=1;

    gfx_SetColor(C_BLACK); gfx_FillRectangle(x,y,cell,cell);
    gfx_SetColor(b==13?C_BLUE:C_PINK);
    gfx_FillRectangle(x+inset,y+inset,cell-inset*2,cell-inset*2);

    gfx_SetColor(C_WHITE);
    gfx_FillRectangle(cx-lw/2,cy-len,lw,2*len+1);
    gfx_FillRectangle(cx-len,cy-lw/2,2*len+1,lw);

    gfx_FillTriangle(cx,cy-len-tip,cx-head,cy-len,cx+head,cy-len);
    gfx_FillTriangle(cx,cy+len+tip,cx-head,cy+len,cx+head,cy+len);
    gfx_FillTriangle(cx-len-tip,cy,cx-len,cy-head,cx-len,cy+head);
    gfx_FillTriangle(cx+len+tip,cy,cx+len,cy-head,cx+len,cy+head);
}

static void draw_raw_tile(int x,int y,int s,uint8_t t,bool editor) {
    if(t==2||t==3||t==12||t==1) draw_cell(x,y,s,tile_color(t));
    else if(t==4) draw_coin(x,y,s);
    else if(t>=5&&t<=9) draw_coin_block(x,y,s,(uint8_t)(t-4));
    else if(t==10||t==11||t==20||t==21) draw_teleporter(x,y,s,tile_color(t));
    else if(t==13||t==14) draw_block(x,y,s,t);
    else if(t==15){ int cell=ce_cell(s); draw_cell(x,y,s,C_FLOOR); draw_ball_at(x+cell/2,y+cell/2,s); }
    else if(t>=16&&t<=19) draw_ramp(x,y,s,t);
    else draw_cell(x,y,s,C_FLOOR);
    if(editor){ gfx_SetColor(C_DARKCYAN); gfx_Rectangle(x,y,ce_cell(s)-1,ce_cell(s)-1); }
}

static void draw_board(int player_off_x,int player_off_y) {
    int s=tile_size(), bw=s*level_w,bh=s*level_h;
    int ox=GAME_BOARD_X+(GAME_BOARD_W-bw)/2, oy=(240-bh)/2;
    uint16_t n=(uint16_t)level_w*level_h;
    for(uint16_t i=0;i<n;i++) {
        uint8_t r=i/level_w,c=i%level_w,t=grid[i]; int x=ox+c*s,y=oy+r*s;

        draw_raw_tile(x,y,s,t,false);
        if(t>=5&&t<=9 && coin_count>=t-4) draw_cell(x,y,s,C_FLOOR);
        if(blocks[i]) {
            bool hide_anim = anim_block_active && r==anim_block_to_r && c==anim_block_to_c;
            if(!hide_anim) draw_block(x,y,s,blocks[i]);
        }
    }

    if(anim_block_active) {
        int bx=ox+anim_block_to_c*s+player_off_x;
        int by=oy+anim_block_to_r*s+player_off_y;
        draw_block(bx,by,s,anim_block_type);
    }

    int cell=ce_cell(s);
    int px=ox+player_c*s+cell/2+player_off_x, py=oy+player_r*s+cell/2+player_off_y;
    draw_ball_at(px,py,s);
}
static void render_game_frame_offset(int player_off_x,int player_off_y) {
    int y=62;
    gfx_FillScreen(C_BLACK);
    gfx_SetColor(C_DARK); gfx_FillRectangle(0,0,GAME_PANEL_W,240);
    draw_board(player_off_x,player_off_y);
    gfx_SetTextScale(1,1); draw_wrapped_label(active_name,4,8,8,4,C_CYAN);
    gfx_SetTextFGColor(C_GRAY);
    gfx_PrintStringXY("2ND",5,y); gfx_PrintStringXY("RESTART",5,y+11); y+=42;
    if(solution_len) { gfx_PrintStringXY("ALPHA",5,y); gfx_PrintStringXY("SOLVER",5,y+11); }
}
static void draw_game_frame_offset(int player_off_x,int player_off_y) {
    render_game_frame_offset(player_off_x,player_off_y);
    gfx_SwapDraw();
}
static void draw_game_frame(void) { draw_game_frame_offset(0,0); }

static void board_geometry(int *s_out,int *ox_out,int *oy_out) {
    int s=tile_size(),bw=s*level_w,bh=s*level_h;
    *s_out=s;
    *ox_out=GAME_BOARD_X+(GAME_BOARD_W-bw)/2;
    *oy_out=(240-bh)/2;
}

static void draw_static_board_cell(uint8_t r,uint8_t c,int s,int ox,int oy) {
    if(r>=level_h||c>=level_w) return;
    uint16_t i=(uint16_t)r*level_w+c;
    uint8_t t=grid[i];
    int x=ox+c*s,y=oy+r*s;
    draw_raw_tile(x,y,s,t,false);
    if(t>=5&&t<=9 && coin_count>=t-4) draw_cell(x,y,s,C_FLOOR);
    if(blocks[i]) {
        bool hide_anim=anim_block_active && r==anim_block_to_r && c==anim_block_to_c;
        if(!hide_anim) draw_block(x,y,s,blocks[i]);
    }
}

static void draw_animation_corridor(int s,int ox,int oy,
                                    uint8_t min_r,uint8_t max_r,uint8_t min_c,uint8_t max_c) {
    for(uint8_t r=min_r;r<=max_r;r++)
        for(uint8_t c=min_c;c<=max_c;c++)
            draw_static_board_cell(r,c,s,ox,oy);
}

static void animate_adjacent_move(int dr,int dc) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    int dx=-dc*s,dy=-dr*s;
    uint8_t min_r=render_r<player_r?render_r:player_r;
    uint8_t max_r=render_r>player_r?render_r:player_r;
    uint8_t min_c=render_c<player_c?render_c:player_c;
    uint8_t max_c=render_c>player_c?render_c:player_c;
    if(anim_block_active){
        if(anim_block_from_r<min_r)min_r=anim_block_from_r;
        if(anim_block_to_r<min_r)min_r=anim_block_to_r;
        if(anim_block_from_r>max_r)max_r=anim_block_from_r;
        if(anim_block_to_r>max_r)max_r=anim_block_to_r;
        if(anim_block_from_c<min_c)min_c=anim_block_from_c;
        if(anim_block_to_c<min_c)min_c=anim_block_to_c;
        if(anim_block_from_c>max_c)max_c=anim_block_from_c;
        if(anim_block_to_c>max_c)max_c=anim_block_to_c;
    }
    int rx=ox+min_c*s,ry=oy+min_r*s;
    int rw=(max_c-min_c+1)*s,rh=(max_r-min_r+1)*s;
    const clock_t duration=(clock_t)(((uint32_t)CLOCKS_PER_SEC*MOVE_DURATION_MS+999u)/1000u);
    const clock_t start=clock();
    for(int frame=1;frame<=MOVE_FRAMES;frame++) {
        clock_t target=start+(clock_t)((long)duration*frame/MOVE_FRAMES);
        while(clock()<target) { }
        int remain=MOVE_FRAMES-frame;
        int pxoff=(dx*remain)/MOVE_FRAMES;
        int pyoff=(dy*remain)/MOVE_FRAMES;
        draw_animation_corridor(s,ox,oy,min_r,max_r,min_c,max_c);
        if(anim_block_active){
            int bx=ox+anim_block_to_c*s+pxoff;
            int by=oy+anim_block_to_r*s+pyoff;
            draw_block(bx,by,s,anim_block_type);
        }
        draw_ball_at(ox+player_c*s+s/2+pxoff,oy+player_r*s+s/2+pyoff,s);
        gfx_BlitRectangle(gfx_buffer,rx,ry,rw,rh);
    }
}

static uint8_t cardinal_dir(int dr,int dc) {
    if(dr==-1&&dc==0) return 0;
    if(dr==0&&dc==1) return 1;
    if(dr==1&&dc==0) return 2;
    if(dr==0&&dc==-1) return 3;
    return 255;
}

static bool ramp_turn_matches(uint8_t id,uint8_t in_dir,uint8_t out_dir) {
    static const uint8_t turns[4][4]={
        {255,0,3,255},
        {255,255,1,0},
        {3,2,255,255},
        {1,255,255,2}
    };
    if(id<16||id>19||in_dir>3) return false;
    return turns[id-16][in_dir]==out_dir;
}

static bool ramp_control_for_move(uint8_t from_r,uint8_t from_c,uint8_t to_r,uint8_t to_c,uint8_t *ramp_r,uint8_t *ramp_c) {
    int dr=(int)to_r-(int)from_r,dc=(int)to_c-(int)from_c;
    if(dr*dr+dc*dc!=2) return false;
    uint8_t candidates_r[2]={from_r,to_r};
    uint8_t candidates_c[2]={to_c,from_c};
    for(uint8_t i=0;i<2;i++) {
        uint8_t r=candidates_r[i],c=candidates_c[i];
        uint8_t id=grid[(uint16_t)r*level_w+c];
        uint8_t in_dir=cardinal_dir((int)r-(int)from_r,(int)c-(int)from_c);
        uint8_t out_dir=cardinal_dir((int)to_r-(int)r,(int)to_c-(int)c);
        if(ramp_turn_matches(id,in_dir,out_dir)){ *ramp_r=r; *ramp_c=c; return true; }
    }
    return false;
}

static void animate_ramp_move(uint8_t ramp_r,uint8_t ramp_c) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    uint8_t min_r=render_r<player_r?render_r:player_r;
    uint8_t max_r=render_r>player_r?render_r:player_r;
    uint8_t min_c=render_c<player_c?render_c:player_c;
    uint8_t max_c=render_c>player_c?render_c:player_c;
    if(ramp_r<min_r)min_r=ramp_r;
    if(ramp_r>max_r)max_r=ramp_r;
    if(ramp_c<min_c)min_c=ramp_c;
    if(ramp_c>max_c)max_c=ramp_c;
    int rx=ox+min_c*s,ry=oy+min_r*s;
    int rw=(max_c-min_c+1)*s,rh=(max_r-min_r+1)*s;
    int x0=ox+render_c*s+s/2,y0=oy+render_r*s+s/2;
    int x1=ox+ramp_c*s+s/2,y1=oy+ramp_r*s+s/2;
    int x2=ox+player_c*s+s/2,y2=oy+player_r*s+s/2;
    const clock_t duration=(clock_t)(((uint32_t)CLOCKS_PER_SEC*MOVE_DURATION_MS+999u)/1000u);
    const clock_t start=clock();
    for(int frame=1;frame<=MOVE_FRAMES;frame++) {
        clock_t target=start+(clock_t)((long)duration*frame/MOVE_FRAMES);
        while(clock()<target) { }
        uint32_t t=(uint32_t)frame*256u/MOVE_FRAMES;
        uint32_t e=(t*t*(768u-2u*t)+32768u)>>16;
        uint32_t q=256u-e;
        int px=(int)((q*q*(uint32_t)x0+2u*q*e*(uint32_t)x1+e*e*(uint32_t)x2+32768u)>>16);
        int py=(int)((q*q*(uint32_t)y0+2u*q*e*(uint32_t)y1+e*e*(uint32_t)y2+32768u)>>16);
        draw_animation_corridor(s,ox,oy,min_r,max_r,min_c,max_c);
        draw_ball_at(px,py,s);
        gfx_BlitRectangle(gfx_buffer,rx,ry,rw,rh);
    }
}

static void snap_player_to_current(void) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    if(render_pos_valid) {
        draw_static_board_cell(render_r,render_c,s,ox,oy);
        gfx_BlitRectangle(gfx_buffer,ox+render_c*s,oy+render_r*s,s,s);
    }
    draw_static_board_cell(player_r,player_c,s,ox,oy);
    draw_ball_at(ox+player_c*s+s/2,oy+player_r*s+s/2,s);
    gfx_BlitRectangle(gfx_buffer,ox+player_c*s,oy+player_r*s,s,s);
}

void engine_tick(void) {
    if(animation_enabled && in_game){
        int dr=(int)player_r-(int)render_r,dc=(int)player_c-(int)render_c;
        uint8_t ramp_r=0,ramp_c=0;
        if(render_pos_valid && (dr*dr+dc*dc)==1) animate_adjacent_move(dr,dc);
        else if(render_pos_valid && ramp_control_for_move(render_r,render_c,player_r,player_c,&ramp_r,&ramp_c)) animate_ramp_move(ramp_r,ramp_c);
        else if(render_pos_valid) snap_player_to_current();
        else draw_game_frame();
        render_r=player_r; render_c=player_c; render_pos_valid=true;
    }
    anim_block_active=0;
}

static void draw_grid_background(void) {
    gfx_FillScreen(C_BLACK); gfx_SetColor(C_DARKCYAN);
    for(int x=-160;x<340;x+=24) gfx_Line(x,0,x+120,240);
    for(int y=-120;y<260;y+=24) gfx_Line(0,y,320,y+160);
}
static void title(void) {
    draw_grid_background(); gfx_SetTransparentColor(C_TRANSPARENT);
    gfx_TransparentSprite((gfx_sprite_t*)cyber_logo,66,20);
    gfx_SetTextFGColor(C_GOAL); gfx_PrintStringXY("porting this everywhere atp",63,98);
}
static uint8_t main_menu(void) {
    uint8_t sel=0; wait_release();
    while(1){ title();
        const char *items[3]={"BUILT-IN LEVELS","LEVEL EDITOR","QUIT"};
        for(uint8_t i=0;i<3;i++){ int y=132+i*28; gfx_SetColor(i==sel?C_CYAN:C_DARK); gfx_FillRectangle(62,y,196,22); gfx_SetTextFGColor(i==sel?C_BLACK:C_WHITE); gfx_PrintStringXY(items[i],80,y+7); }
        gfx_SetTextFGColor(C_GRAY); gfx_PrintStringXY("UP/DOWN + ENTER",101,222); gfx_SwapDraw();
        kb_Scan(); uint8_t g7=kb_Data[7],g6=kb_Data[6];
        if(g7&kb_Up){sel=(sel+2)%3;wait_release();} else if(g7&kb_Down){sel=(sel+1)%3;wait_release();}
        else if(g6&kb_Enter){wait_release();return sel;} else if(g6&kb_Clear){return 2;}
    }
}

static void draw_mini_preview(const uint8_t *cells,uint8_t w,uint8_t h,int x,int y,int size) {

    gfx_SetColor(C_FLOOR); gfx_FillRectangle(x,y,size,size);
    for(uint16_t i=0;i<(uint16_t)w*h;i++){
        uint8_t t=cells[i],col=C_FLOOR,c=(uint8_t)(i%w),r=(uint8_t)(i/w);
        if(t==2)col=C_CYAN; else if(t==3)col=C_GOAL; else if(t==4)col=C_COIN_INNER;
        else if(t>=5&&t<=9)col=C_GATE_INNER; else if(t==10)col=C_ORANGE; else if(t==11)col=C_PURPLE;
        else if(t==12)col=C_BLACK; else if(t==13)col=C_BLUE; else if(t==14)col=C_PINK; else if(t==15)col=C_BALL;
        else if(t>=16&&t<=19)col=C_RAMP; else if(t==20)col=C_LIME; else if(t==21)col=C_REDTP;
        int x0=x+(int)c*size/w, x1=x+(int)(c+1)*size/w;
        int y0=y+(int)r*size/h, y1=y+(int)(r+1)*size/h;
        gfx_SetColor(col); gfx_FillRectangle(x0,y0,x1-x0,y1-y0);
    }
}

static int choose_builtin(void) {
    static uint8_t sel=0;
    static uint8_t view_start=0;
    uint8_t prev7=0,prev6=0,prev1=0;
    bool dirty=true;
    if(sel>=builtin_level_count) sel=0;
    if(view_start>sel || sel>=view_start+6) view_start=(uint8_t)((sel/3)*3);
    wait_release();
    while(1){
        if(dirty){
            draw_grid_background();
            gfx_SetTextFGColor(C_CYAN); gfx_SetTextScale(2,2); gfx_PrintStringXY("LEVELS",8,6); gfx_SetTextScale(1,1);
            for(uint8_t k=0;k<6;k++){
                uint8_t idx=(uint8_t)(view_start+k); if(idx>=builtin_level_count)break;
                int col=k%3,row=k/3,x=5+col*105,y=31+row*103;
                const BuiltinLevel *l=&builtin_levels[idx];
                gfx_SetColor(idx==sel?C_CYAN:C_DARK); gfx_FillRectangle(x,y,100,100);
                gfx_SetColor(C_BLACK); gfx_FillRectangle(x+2,y+2,96,96);
                draw_mini_preview(l->cells,l->width,l->height,x+10,y+3,80);
                draw_wrapped_label_centered(l->name,x+50,y+84,12,2,idx==sel?C_GOAL:C_WHITE);
            }
            gfx_SwapDraw();
            dirty=false;
        }

        kb_Scan();
        uint8_t g7=kb_Data[7],g6=kb_Data[6],g1=kb_Data[1];
        uint8_t press7=(uint8_t)(g7&~prev7),press6=(uint8_t)(g6&~prev6),press1=(uint8_t)(g1&~prev1);
        prev7=g7; prev6=g6; prev1=g1;

        uint8_t old=sel,old_view=view_start;
        if(press7&kb_Left){ if(sel%3) sel--; }
        else if(press7&kb_Right){ if((sel%3)<2 && sel+1<builtin_level_count) sel++; }
        else if(press7&kb_Up){ if(sel>=3) sel-=3; }
        else if(press7&kb_Down){
            if(sel+3<builtin_level_count) sel+=3;
            else {
                uint8_t next_row=(uint8_t)(((sel/3)+1)*3);
                if(next_row<builtin_level_count) sel=(uint8_t)(builtin_level_count-1);
            }
        }
        else if(press6&kb_Enter){ wait_release(); return sel; }
        else if((press1&kb_Mode)||(press6&kb_Clear)){ wait_release(); return -1; }

        if(sel<view_start) view_start=(uint8_t)(view_start>=3?view_start-3:0);
        else if(sel>=view_start+6) view_start=(uint8_t)(view_start+3);
        if(view_start>=builtin_level_count) view_start=(uint8_t)(((builtin_level_count-1)/3)*3);
        if(sel!=old || view_start!=old_view) dirty=true;
    }
}

static void center_popup(const char *a,const char *b) {
    gfx_SetColor(C_DARK);gfx_FillRectangle(38,76,244,88);gfx_SetColor(C_CYAN);gfx_Rectangle(38,76,244,88);gfx_SetTextFGColor(C_WHITE);gfx_SetTextScale(2,2);gfx_PrintStringXY(a,64,92);gfx_SetTextScale(1,1);gfx_SetTextFGColor(C_GOAL);gfx_PrintStringXY(b,64,133);gfx_SwapDraw();
}
static void popup_wait(const char *a,const char *b) { center_popup(a,b); wait_release(); while(!kb_AnyKey())kb_Scan(); wait_release(); }

static void draw_complete_screen(void) {
    const int x=34,y=41,w=252,h=158;
    gfx_FillScreen(C_BLACK);
    gfx_SetColor(C_POPUP); gfx_FillRectangle(x,y,w,h);
    gfx_SetColor(C_CYAN);
    gfx_Rectangle(x,y,w,h); gfx_Rectangle(x+1,y+1,w-2,h-2); gfx_Rectangle(x+2,y+2,w-4,h-4);
    gfx_SetTextScale(2,2); gfx_SetTextFGColor(C_WHITE); gfx_PrintStringXY("LEVEL COMPLETE",48,78);
    gfx_SetTextScale(1,1);
    gfx_SetColor(C_CYAN); gfx_FillRectangle(90,137,140,38);
    gfx_SetColor(C_BUTTON); gfx_FillRectangle(93,140,134,32);
    gfx_SetTextScale(2,2); gfx_SetTextFGColor(C_WHITE); gfx_PrintStringXY("EXIT",128,148);
    gfx_SetTextScale(1,1);
    gfx_SwapDraw();
}

static void level_complete_wait(void) {
    draw_complete_screen(); wait_release();
    for(;;){
        kb_Scan();
        if((kb_Data[6]&kb_Enter)||(kb_Data[1]&kb_Mode)||(kb_Data[6]&kb_Clear)){wait_release();return;}
    }
}

static const uint8_t fade_line_order[16]={0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15};
static const uint8_t bayer4[16]={0,8,2,10,12,4,14,6,3,11,1,9,15,7,13,5};

static void draw_ball_dithered(int cx,int cy,int s,uint8_t alpha16) {
    int cell=ce_cell(s);
    int outer=scale85(44,cell),inner=scale85(37,cell);
    if(outer<2)outer=2;if(inner<1)inner=1;
    int outer2=outer*outer,inner2=inner*inner;
    for(int yy=-outer;yy<=outer;yy++){
        for(int xx=-outer;xx<=outer;xx++){
            int d2=xx*xx+yy*yy;
            if(d2>outer2) continue;
            uint8_t threshold=bayer4[((cy+yy)&3)*4+((cx+xx)&3)];
            if(threshold>=alpha16) continue;
            gfx_SetColor(d2<=inner2?C_BALL:C_BLACK);
            gfx_SetPixel(cx+xx,cy+yy);
        }
    }
}

static void death_ball_fade(void) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    int x=ox+player_c*s,y=oy+player_r*s;
    int cx=x+s/2,cy=y+s/2;
    const unsigned step_ms=DEATH_FADE_MS/DEATH_FADE_STEPS;

    for(int step=DEATH_FADE_STEPS-1;step>=0;step--){
        draw_static_board_cell(player_r,player_c,s,ox,oy);
        if(step) draw_ball_dithered(cx,cy,s,(uint8_t)step);
        gfx_BlitRectangle(gfx_buffer,x,y,s,s);
        delay(step_ms);
    }
}

static void fade_grid_to_black(void) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    int bw=s*level_w,bh=s*level_h;
    const unsigned step_ms=DEATH_FADE_MS/DEATH_FADE_STEPS;
    gfx_SetColor(C_BLACK);
    for(uint8_t phase=0;phase<DEATH_FADE_STEPS;phase++){
        uint8_t residue=fade_line_order[phase];
        for(int y=oy+residue;y<oy+bh;y+=16){
            gfx_FillRectangle(ox,y,bw,1);
            gfx_BlitRectangle(gfx_buffer,ox,y,bw,1);
        }
        delay(step_ms);
    }
}

static void fade_grid_from_black(void) {
    int s,ox,oy; board_geometry(&s,&ox,&oy);
    int bw=s*level_w,bh=s*level_h;
    const unsigned step_ms=DEATH_FADE_MS/DEATH_FADE_STEPS;
    for(uint8_t phase=0;phase<DEATH_FADE_STEPS;phase++){
        uint8_t residue=fade_line_order[phase];
        for(int y=oy+residue;y<oy+bh;y+=16)
            gfx_BlitRectangle(gfx_buffer,ox,y,bw,1);
        delay(step_ms);
    }
}

static void death_effect(void) {

    render_game_frame_offset(0,0);
    death_ball_fade();
    fade_grid_to_black();
    engine_reset();
    render_game_frame_offset(0,0);
    fade_grid_from_black();
}

static void draw_solver_arrow(int x,int y,uint8_t dir) {
    const int s=SOLVER_ARROW_SIZE,m=s/2;
    gfx_SetColor(C_GOAL);
    if(dir==0){
        gfx_FillTriangle(x+m,y,x,y+m,x+s-1,y+m);
        gfx_FillRectangle(x+m-1,y+m,3,s-m);
    } else if(dir==1){
        gfx_FillTriangle(x+s-1,y+m,x+m,y,x+m,y+s-1);
        gfx_FillRectangle(x,y+m-1,s-m,3);
    } else if(dir==2){
        gfx_FillTriangle(x+m,y+s-1,x,y+m,x+s-1,y+m);
        gfx_FillRectangle(x+m-1,y,3,s-m);
    } else {
        gfx_FillTriangle(x,y+m,x+m,y,x+m,y+s-1);
        gfx_FillRectangle(x+m,y+m-1,s-m,3);
    }
}

static void draw_solver_popup(uint8_t selected,uint8_t scroll_row) {
    render_game_frame_offset(0,0);
    const int x=22,y=42,w=276,h=156;
    char count[28];
    sprintf(count,"NUMBER OF MOVES: %u",(unsigned int)solution_len);
    gfx_SetColor(C_DARK); gfx_FillRectangle(x,y,w,h);
    gfx_SetColor(C_CYAN); gfx_Rectangle(x,y,w,h); gfx_Rectangle(x+1,y+1,w-2,h-2);
    gfx_SetTextScale(2,2); gfx_SetTextFGColor(C_CYAN);
    const char *title="SOLVER";
    gfx_PrintStringXY(title,160-(int)gfx_GetStringWidth(title)/2,53);
    gfx_SetTextScale(1,1); gfx_SetTextFGColor(C_WHITE);
    gfx_PrintStringXY(count,160-(int)gfx_GetStringWidth(count)/2,78);
    gfx_SetColor(C_SOLVER_BG); gfx_FillRectangle(32,92,256,60);
    gfx_SetColor(C_CYAN); gfx_Rectangle(32,92,256,60);
    for(uint8_t vr=0;vr<SOLVER_VISIBLE_ROWS;vr++) {
        uint16_t row=(uint16_t)scroll_row+vr;
        uint16_t first=row*SOLVER_PER_ROW;
        if(first>=solution_len) break;
        uint16_t remain=(uint16_t)(solution_len-first);
        uint8_t row_count=(uint8_t)(remain>SOLVER_PER_ROW?SOLVER_PER_ROW:remain);
        int row_w=(int)row_count*SOLVER_ARROW_STEP-(SOLVER_ARROW_STEP-SOLVER_ARROW_SIZE);
        int ax0=160-row_w/2;
        int ay=98+vr*SOLVER_ROW_STEP;
        for(uint8_t col=0;col<row_count;col++)
            draw_solver_arrow(ax0+col*SOLVER_ARROW_STEP,ay,solution[first+col]&3);
    }
    const int by=160,bw=108,bh=27;
    gfx_SetColor(selected==0?C_CYAN:C_DARK); gfx_FillRectangle(42,by,bw,bh);
    gfx_SetColor(selected==0?C_CYAN:C_WHITE); gfx_Rectangle(42,by,bw,bh);
    gfx_SetTextFGColor(selected==0?C_BLACK:C_WHITE); gfx_PrintStringXY("PLAY MACRO",56,by+10);
    gfx_SetColor(selected==1?C_CYAN:C_DARK); gfx_FillRectangle(170,by,bw,bh);
    gfx_SetColor(selected==1?C_CYAN:C_WHITE); gfx_Rectangle(170,by,bw,bh);
    gfx_SetTextFGColor(selected==1?C_BLACK:C_WHITE); gfx_PrintStringXY("CLOSE",204,by+10);
    gfx_SwapDraw();
}

static bool run_solver(void) {
    if(!solution_len) return false;
    uint8_t selected=0,scroll_row=0,prev7=0,prev6=0;
    uint8_t total_rows=(uint8_t)((solution_len+SOLVER_PER_ROW-1)/SOLVER_PER_ROW);
    uint8_t max_scroll=total_rows>SOLVER_VISIBLE_ROWS?(uint8_t)(total_rows-SOLVER_VISIBLE_ROWS):0;
    bool dirty=true;
    wait_release();
    while(1){
        if(dirty){ draw_solver_popup(selected,scroll_row); dirty=false; }
        kb_Scan();
        uint8_t g7=kb_Data[7],g6=kb_Data[6];
        uint8_t press7=(uint8_t)(g7&~prev7),press6=(uint8_t)(g6&~prev6);
        prev7=g7; prev6=g6;
        if(press7&kb_Left){ selected=0; dirty=true; }
        else if(press7&kb_Right){ selected=1; dirty=true; }
        else if(press7&kb_Up){ if(scroll_row){ scroll_row--; dirty=true; } }
        else if(press7&kb_Down){ if(scroll_row<max_scroll){ scroll_row++; dirty=true; } }
        else if(press6&kb_Enter){
            wait_release();
            if(selected==1){ draw_game_frame(); return false; }
            break;
        }
    }
    engine_reset(); animation_enabled=true; draw_game_frame(); delay(120);
    bool won=false;
    for(uint16_t i=0;i<solution_len;i++){
        uint8_t r=engine_move(solution[i]);
        if(r==2){won=true;break;}
        if(r==3){engine_reset();break;}
        delay(10);
    }
    draw_game_frame();
    return won;
}

static void play_level(void) {
    in_game=true; animation_enabled=true; engine_reset(); draw_game_frame(); wait_release();
    for(;;){ kb_Scan();uint8_t g7=kb_Data[7],g6=kb_Data[6],g1=kb_Data[1],g2=kb_Data[2]; uint8_t dir=255;
        if(g7&kb_Up)dir=0;else if(g7&kb_Right)dir=1;else if(g7&kb_Down)dir=2;else if(g7&kb_Left)dir=3;
        if(dir!=255){
            uint8_t r=engine_move(dir);
            if(r==3){ death_effect(); wait_release(); }
            else { draw_game_frame(); wait_release(); if(r==2){level_complete_wait();in_game=false;return;} }
        }
        else if(g1&kb_2nd){engine_reset();draw_game_frame();wait_release();}
        else if((g2&kb_Alpha)&&solution_len){if(run_solver()){level_complete_wait();in_game=false;return;}wait_release();}
        else if(g1&kb_Mode){wait_release();in_game=false;return;}
        else if(g6&kb_Clear){wait_release();in_game=false;return;}
    }
}

static void draw_editor_screen(uint8_t slot,uint8_t cr,uint8_t cc,uint8_t paint) {
    const int s=15, ox=3, oy=15;
    gfx_FillScreen(C_BLACK); gfx_SetColor(C_DARK); gfx_FillRectangle(0,0,216,240);
    for(uint16_t i=0;i<EDIT_CELLS;i++) draw_raw_tile(ox+(i%EDIT_W)*s,oy+(i/EDIT_W)*s,s,editor_cells[slot][i],true);
    gfx_SetColor(C_GOAL); gfx_Rectangle(ox+cc*s-1,oy+cr*s-1,s+1,s+1);
    gfx_SetTextFGColor(C_CYAN); gfx_PrintStringXY("EDITOR",224,8);
    gfx_SetTextFGColor(C_WHITE); gfx_PrintStringXY("SLOT",224,25); gfx_PrintUInt(slot+1,1);
    gfx_SetTextFGColor(C_GOAL); gfx_PrintStringXY(tile_names[paint],220,47);
    draw_raw_tile(252,65,18,paint,false);
    gfx_SetTextFGColor(C_GRAY); gfx_PrintStringXY("ARROWS",224,94); gfx_PrintStringXY("CURSOR",224,105);
    gfx_PrintStringXY("2ND/ALPHA",220,126); gfx_PrintStringXY("TILE +/-",224,137);
    gfx_PrintStringXY("ENTER",224,158); gfx_PrintStringXY("PAINT",224,169);
    gfx_PrintStringXY("MODE",224,190); gfx_PrintStringXY("SAVE",224,201);
    gfx_PrintStringXY("CLEAR",224,218); gfx_PrintStringXY("CANCEL",224,229);
    gfx_SwapDraw();
}

static void paint_editor_cell(uint8_t slot,uint8_t r,uint8_t c,uint8_t tile) {
    uint16_t idx=(uint16_t)r*EDIT_W+c;
    if(tile==15) for(uint16_t i=0;i<EDIT_CELLS;i++) if(editor_cells[slot][i]==15) editor_cells[slot][i]=1;
    editor_cells[slot][idx]=tile;
}

static bool edit_slot(uint8_t slot) {
    if(slot>=EDITOR_SLOTS) return false;
    uint8_t backup[EDIT_CELLS]; memcpy(backup,editor_cells[slot],EDIT_CELLS);
    bool was_valid=(editor_valid_mask&(1u<<slot))!=0;
    if(!was_valid) editor_template(editor_cells[slot]);
    uint8_t r=EDIT_H-2,c=1,paint=2; wait_release();
    while(1){ draw_editor_screen(slot,r,c,paint); kb_Scan(); uint8_t g7=kb_Data[7],g6=kb_Data[6],g1=kb_Data[1],g2=kb_Data[2];
        if(g7&kb_Up){r=r? r-1:EDIT_H-1;wait_release();}
        else if(g7&kb_Down){r=(r+1)%EDIT_H;wait_release();}
        else if(g7&kb_Left){c=c? c-1:EDIT_W-1;wait_release();}
        else if(g7&kb_Right){c=(c+1)%EDIT_W;wait_release();}
        else if(g1&kb_2nd){paint=paint==21?1:paint+1;wait_release();}
        else if(g2&kb_Alpha){paint=paint==1?21:paint-1;wait_release();}
        else if(g6&kb_Enter){paint_editor_cell(slot,r,c,paint);wait_release();}
        else if(g1&kb_Mode){
            wait_release();
            if(!editor_level_valid(editor_cells[slot])){popup_wait("CAN'T SAVE","NEED 1 START + GOAL");continue;}
            uint8_t old_mask=editor_valid_mask; editor_valid_mask|=(uint8_t)(1u<<slot);
            if(!save_editor_data()){editor_valid_mask=old_mask;popup_wait("SAVE FAILED","CHECK FREE RAM");continue;}
            popup_wait("SAVED!","LEVEL READY"); return true;
        }
        else if(g6&kb_Clear){ memcpy(editor_cells[slot],backup,EDIT_CELLS); if(was_valid) editor_valid_mask|=(uint8_t)(1u<<slot); else editor_valid_mask&=(uint8_t)~(1u<<slot); wait_release(); return false; }
    }
}

static void editor_menu(void) {
    static const char *actions[3]={"PLAY","EDIT","DELETE"};
    load_editor_data(); uint8_t sel=0,action=1; wait_release();
    while(1){
        uint8_t first=(uint8_t)((sel/4)*4);
        draw_grid_background(); gfx_SetTextFGColor(C_CYAN);gfx_SetTextScale(2,2);gfx_PrintStringXY("LEVEL EDITOR",8,5);gfx_SetTextScale(1,1);
        for(uint8_t row=0;row<4;row++){
            uint8_t i=first+row; if(i>=EDITOR_SLOTS) break;
            int y=31+row*43; bool saved=(editor_valid_mask&(1u<<i))!=0; bool row_sel=i==sel;
            gfx_SetColor(row_sel?C_CYAN:C_DARK); gfx_FillRectangle(20,y,280,38);
            gfx_SetColor(C_BLACK); gfx_FillRectangle(22,y+2,276,34);
            if(!saved){
                char slot_label[12]; sprintf(slot_label,"SLOT %u",(unsigned int)(i+1));
                gfx_SetTextFGColor(row_sel?C_GOAL:C_WHITE); gfx_PrintStringXY(slot_label,136,y+8);
                gfx_SetTextFGColor(row_sel?C_CYAN:C_GRAY); gfx_PrintStringXY("SLOT EMPTY",120,y+21);
            } else {
                gfx_SetTextFGColor(row_sel?C_GOAL:C_WHITE);
                { char label[18]; sprintf(label,"SLOT %u  SAVED",(unsigned int)(i+1)); gfx_PrintStringXY(label,29,y+5); }
                for(uint8_t a=0;a<3;a++){
                    int bx=80+a*69,by=y+18; bool chosen=row_sel&&a==action;
                    gfx_SetColor(chosen?C_CYAN:C_DARKCYAN); gfx_FillRectangle(bx,by,62,14);
                    gfx_SetTextFGColor(chosen?C_BLACK:C_WHITE); gfx_PrintStringXY(actions[a],bx+5,by+3);
                }
            }
        }
        gfx_SetTextFGColor(C_GRAY);gfx_PrintStringXY("UP/DOWN SLOT  LEFT/RIGHT OPTION",33,218);gfx_PrintStringXY("ENTER SELECT  MODE/CLEAR BACK",48,229);gfx_SwapDraw();
        kb_Scan();uint8_t g7=kb_Data[7],g6=kb_Data[6],g1=kb_Data[1];
        if(g7&kb_Up){sel=sel?sel-1:EDITOR_SLOTS-1;if(!(editor_valid_mask&(1u<<sel)))action=1;wait_release();}
        else if(g7&kb_Down){sel=(sel+1)%EDITOR_SLOTS;if(!(editor_valid_mask&(1u<<sel)))action=1;wait_release();}
        else if((g7&kb_Left)&&(editor_valid_mask&(1u<<sel))){action=action?action-1:2;wait_release();}
        else if((g7&kb_Right)&&(editor_valid_mask&(1u<<sel))){action=(action+1)%3;wait_release();}
        else if(g6&kb_Enter){
            bool saved=(editor_valid_mask&(1u<<sel))!=0; wait_release();
            if(!saved){ edit_slot(sel); action=1; }
            else if(action==0){ if(load_editor_level(sel)) play_level(); }
            else if(action==1){ edit_slot(sel); }
            else {
                uint8_t old_mask=editor_valid_mask; uint8_t backup[EDIT_CELLS]; memcpy(backup,editor_cells[sel],EDIT_CELLS);
                editor_valid_mask&=(uint8_t)~(1u<<sel); memset(editor_cells[sel],1,EDIT_CELLS);
                if(!save_editor_data()){editor_valid_mask=old_mask;memcpy(editor_cells[sel],backup,EDIT_CELLS);popup_wait("DELETE FAILED","CHECK FREE RAM");}
                else { action=1; popup_wait("SLOT CLEARED","READY FOR NEW LEVEL"); }
            }
        }
        else if((g1&kb_Mode)||(g6&kb_Clear)){wait_release();return;}
    }
}

static void builtin_menu(void) {
    for(;;){ int i=choose_builtin(); if(i<0)return; if(load_builtin((uint8_t)i))play_level(); }
}

int main(void) {
    gfx_Begin(); gfx_SetDrawBuffer(); gfx_SetPalette(palette,sizeof palette,0); gfx_SetTransparentColor(C_TRANSPARENT); gfx_SetTextTransparentColor(C_TRANSPARENT); gfx_SetTextBGColor(C_TRANSPARENT); gfx_SetTextFGColor(C_WHITE);
    bool quit=false; while(!quit){uint8_t m=main_menu();if(m==0){builtin_menu();}else if(m==1){editor_menu();}else quit=true;}
    gfx_End(); kb_Reset(); return 0;
}
