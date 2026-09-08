# 1 "/workspaces/codespaces-blank/CyberRoller-TI84CE/src/engine.S"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 369 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/workspaces/codespaces-blank/CyberRoller-TI84CE/src/engine.S" 2

.assume ADL=1

.section .text._engine_move
.global _engine_move
.type _engine_move, @function
_engine_move:

    pop hl
    pop de
    push de
    push hl
    ld a,e
    ld (_engine_dir),a

    ld a,(_player_r)
    ld d,a
    ld a,(_player_c)
    ld e,a
    call .next_rc
    jp c,.ret_blocked

    call .block_at_rc
    or a
    jr nz,.initial_push

    call .grid_at_rc
    cp 16
    jr c,.initial_not_ramp
    cp 20
    jr c,.initial_ramp
.initial_not_ramp:
    push de
    call .is_solid_tile
    pop de
    or a
    jp nz,.ret_blocked
    call .set_player_rc
    call _engine_tick
    call .current_result
    cp 2
    ret z
    cp 3
    ret z
    jr .automatic

.initial_ramp:
    call .ramp_turn
    jp c,.ret_blocked
    ld (_engine_dir),a

    call .next_rc
    jp c,.ret_dead
    call .set_player_rc
    call _engine_tick
    call .current_result
    cp 2
    ret z
    cp 3
    ret z
    cp 1
    ret z
    jr .automatic

.initial_push:
    call .push_block
    or a
    jp z,.ret_blocked
    ld a,1
    ret

.automatic:
    call .collect_current
    call .teleport_current
    or a
    jr z,.after_tp_tick
    call _engine_tick
.after_tp_tick:
    ld a,(_player_r)
    ld d,a
    ld a,(_player_c)
    ld e,a
    call .next_rc
    jp c,.ret_dead

    call .block_at_rc
    or a
    jr nz,.auto_push

    call .grid_at_rc
    cp 16
    jr c,.auto_not_ramp
    cp 20
    jr c,.auto_ramp
.auto_not_ramp:
    push de
    call .is_solid_tile
    pop de
    or a
    jr nz,.ret_stable
    call .set_player_rc
    call _engine_tick
    call .current_result
    cp 2
    ret z
    cp 3
    ret z
    jr .automatic

.auto_ramp:
    call .ramp_turn
    jr c,.ret_stable
    ld (_engine_dir),a
    call .next_rc
    jp c,.ret_dead
    call .set_player_rc
    call _engine_tick
    call .current_result
    cp 2
    ret z
    cp 3
    ret z
    cp 1
    ret z
    jr .automatic

.auto_push:
    call .push_block

    ld a,1
    ret

.ret_blocked:
    xor a
    ret
.ret_stable:
    ld a,1
    ret
.ret_dead:
    ld a,3
    ret

.get_index:
    ld bc,0
    ld b,d
    ld a,(_level_w)
    ld c,a
    mlt bc
    ld a,c
    add a,e
    ld c,a
    jr nc,1f
    inc b
1: ret

.grid_at_rc:
    call .get_index
    ld hl,_grid
    add hl,bc
    ld a,(hl)
    ret

.block_at_rc:
    call .get_index
    ld hl,_blocks
    add hl,bc
    ld a,(hl)
    ret

.set_block_rc:
    ld (_scratch),a
    call .get_index
    ld hl,_blocks
    add hl,bc
    ld a,(_scratch)
    ld (hl),a
    ret

.set_player_rc:
    ld a,d
    ld (_player_r),a
    ld a,e
    ld (_player_c),a
    ret

.next_rc:
    ld a,(_engine_dir)
    or a
    jr z,.next_up
    cp 1
    jr z,.next_right
    cp 2
    jr z,.next_down
.next_left:
    ld a,e
    or a
    jr z,.next_out
    dec e
    or a
    ret
.next_up:
    ld a,d
    or a
    jr z,.next_out
    dec d
    or a
    ret
.next_right:
    inc e
    ld b,e
    ld a,(_level_w)
    cp b
    jr z,.next_out
    jr c,.next_out
    or a
    ret
.next_down:
    inc d
    ld b,d
    ld a,(_level_h)
    cp b
    jr z,.next_out
    jr c,.next_out
    or a
    ret
.next_out:
    scf
    ret

.is_solid_tile:
    cp 2
    jr z,.solid_yes
    cp 5
    jr c,.solid_no
    cp 10
    jr nc,.solid_no
    sub 4
    ld b,a
    ld a,(_coin_count)
    cp b
    jr c,.solid_yes
.solid_no:
    xor a
    ret
.solid_yes:
    ld a,1
    ret

.ramp_turn:
    sub 16
    add a,a
    add a,a
    ld b,a
    ld a,(_engine_dir)
    add a,b
    ld bc,0
    ld c,a
    ld hl,.ramp_table
    add hl,bc
    ld a,(hl)
    cp 255
    jr z,.ramp_bad
    or a
    ret
.ramp_bad:
    scf
    ret

.current_result:
    ld a,(_player_r)
    ld d,a
    ld a,(_player_c)
    ld e,a
    call .grid_at_rc
    cp 3
    jr z,.cur_win
    cp 12
    jr z,.cur_dead
    call .is_solid_tile
    or a
    ret z
    ld a,1
    ret
.cur_win:
    ld a,2
    ret
.cur_dead:
    ld a,3
    ret

.collect_current:
    ld a,(_player_r)
    ld d,a
    ld a,(_player_c)
    ld e,a
    call .get_index
    ld hl,_grid
    add hl,bc
    ld a,(hl)
    cp 4
    ret nz
    ld (hl),1
    ld a,(_coin_count)
    inc a
    ld (_coin_count),a
    ret

.teleport_current:
    ld a,(_player_r)
    ld d,a
    ld a,(_player_c)
    ld e,a
    call .get_index
    ld hl,_tele_r
    add hl,bc
    ld a,(hl)
    cp 255
    jr z,.no_tp
    ld (_player_r),a
    ld hl,_tele_c
    add hl,bc
    ld a,(hl)
    ld (_player_c),a
    ld a,1
    ret
.no_tp:
    xor a
    ret

.can_push_rc:
    call .block_at_rc
    or a
    jr nz,.cant_push
    call .grid_at_rc
    cp 3
    jr z,.cant_push
    cp 12
    jr z,.cant_push
    cp 16
    jr c,.push_check_wall
    cp 20
    jr c,.cant_push
.push_check_wall:
    call .is_solid_tile
    or a
    jr nz,.cant_push
    ld a,1
    ret
.cant_push:
    xor a
    ret

.mark_push_animation:
    ld a,1
    ld (_anim_block_active),a
    ld a,(_block_type)
    ld (_anim_block_type),a
    ld a,(_block_r)
    ld (_anim_block_from_r),a
    ld a,(_block_c)
    ld (_anim_block_from_c),a
    ld a,(_slide_r)
    ld (_anim_block_to_r),a
    ld a,(_slide_c)
    ld (_anim_block_to_c),a
    ret

.push_block:
    ld (_block_type),a
    ld a,d
    ld (_block_r),a
    ld a,e
    ld (_block_c),a

    call .next_rc
    jp c,.push_fail
    call .can_push_rc
    or a
    jp z,.push_fail

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    xor a
    call .set_block_rc

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    call .next_rc
    ld a,(_block_type)
    call .set_block_rc
    ld a,d
    ld (_slide_r),a
    ld a,e
    ld (_slide_c),a

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    call .set_player_rc
    call .collect_current
    call .mark_push_animation
    call _engine_tick

    ld a,(_block_type)
    cp 14
    jp nz,.push_ok

.pink_loop:

    ld a,(_slide_r)
    ld d,a
    ld a,(_slide_c)
    ld e,a
    ld a,d
    ld (_block_r),a
    ld a,e
    ld (_block_c),a
    call .next_rc
    jp c,.push_ok
    call .can_push_rc
    or a
    jp z,.push_ok

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    xor a
    call .set_block_rc

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    call .next_rc
    ld a,14
    call .set_block_rc
    ld a,d
    ld (_slide_r),a
    ld a,e
    ld (_slide_c),a

    ld a,(_block_r)
    ld d,a
    ld a,(_block_c)
    ld e,a
    call .set_player_rc
    call .collect_current
    call .mark_push_animation
    call _engine_tick
    jp .pink_loop

.push_ok:
    ld a,1
    ret
.push_fail:
    xor a
    ret

.section .rodata.engine_tables
.ramp_table:
     .byte 255,0,3,255
     .byte 255,255,1,0
     .byte 3,2,255,255
     .byte 1,255,255,2

.section .bss.engine_state
_engine_dir: .space 1
_block_type: .space 1
_block_r: .space 1
_block_c: .space 1
_slide_r: .space 1
_slide_c: .space 1
_scratch: .space 1

.extern _level_w
.extern _level_h
.extern _grid
.extern _blocks
.extern _tele_r
.extern _tele_c
.extern _player_r
.extern _player_c
.extern _coin_count
.extern _engine_tick
.extern _anim_block_active
.extern _anim_block_type
.extern _anim_block_from_r
.extern _anim_block_from_c
.extern _anim_block_to_r
.extern _anim_block_to_c
