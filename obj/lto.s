	.section	.text,"ax",@progbits
	.assume	ADL = 1
	.file	"llvm-link"
	.section	.text._engine_reset,"ax",@progbits
	.globl	_engine_reset                   ; -- Begin function engine_reset
	.type	_engine_reset,@function
_engine_reset:                          ; @engine_reset
; %bb.0:
	ld	hl, -3
	call	__frameset
	ld	iy, _grid
	ld	de, _base_grid
	ld	a, (_level_w)
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, a
	ld	a, (_level_h)
	ld	l, a
	call	__imulu
	ld	(ix - 3), hl
	push	hl
	push	de
	push	iy
	call	_memcpy
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 3)
	push	hl
	ld	hl, _base_blocks
	push	hl
	ld	hl, _blocks
	push	hl
	call	_memcpy
	pop	hl
	pop	hl
	pop	hl
	ld	a, (_start_r)
	ld	l, a
	ld	(_player_r), a
	ld	a, (_start_c)
	ld	e, a
	ld	(_player_c), a
	ld	c, 0
	ld	a, c
	ld	(_coin_count), a
	ld	a, l
	ld	(_render_r), a
	ld	a, e
	ld	(_render_c), a
	ld	a, 1
	ld	(_render_pos_valid), a
	ld	a, c
	ld	(_anim_block_active), a
	pop	hl
	pop	ix
	ret
	.local	.Lfunc_end0
.Lfunc_end0:
	.size	_engine_reset, .Lfunc_end0-_engine_reset
                                        ; -- End function
	.section	.text._engine_tick,"ax",@progbits
	.globl	_engine_tick                    ; -- Begin function engine_tick
	.type	_engine_tick,@function
_engine_tick:                           ; @engine_tick
; %bb.0:
	ld	hl, -125
	call	__frameset
	ld	e, 0
	ld	a, (_in_game)
	bit	0, a
	jp	z, .LBB1_24
; %bb.1:
	ld	a, (_player_r)
	ld	de, 0
	push	de
	pop	hl
	ld	(ix - 32), a                    ; 1-byte Folded Spill
	ld	l, a
	ld	a, (_render_r)
	push	de
	pop	bc
	ld	(ix - 38), a                    ; 1-byte Folded Spill
	ld	c, a
	ld	(ix - 44), hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	a, (_player_c)
	push	de
	pop	hl
	ld	(ix - 56), a                    ; 1-byte Folded Spill
	ld	l, a
	ld	a, (_render_c)
	ld	(ix - 41), a                    ; 1-byte Folded Spill
	ld	e, a
	ld	(ix - 47), hl
	or	a, a
	sbc	hl, de
	ld	(ix - 35), hl
	ld	a, (_render_pos_valid)
	bit	0, a
	jp	z, .LBB1_13
; %bb.2:
	ld	(ix - 53), de
	ld	(ix - 50), bc
	lea	hl, iy + 0
	ld	(ix - 59), iy
	lea	bc, iy + 0
	call	__imulu
	ex	de, hl
	ld	bc, (ix - 35)
	push	bc
	pop	hl
	call	__imulu
	push	hl
	pop	iy
	add	iy, de
	ld	de, 1
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_14
; %bb.3:
	pea	ix - 9
	pea	ix - 6
	pea	ix - 3
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 3)
	push	de
	pop	hl
	ld	bc, (ix - 35)
	call	__imulu
	ld	(ix - 65), hl
	ld	(ix - 32), de
	ex	de, hl
	ld	bc, (ix - 59)
	call	__imulu
	ld	(ix - 68), hl
	ld	bc, (ix - 50)
	push	bc
	pop	hl
	ld	de, (ix - 44)
	or	a, a
	sbc	hl, de
	push	bc
	pop	hl
	jr	c, .LBB1_5
; %bb.4:
	push	de
	pop	hl
	.local	.LBB1_5
.LBB1_5:
	ld	(ix - 35), hl
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	ex	de, hl
	ld	bc, (ix - 53)
	jr	c, .LBB1_7
; %bb.6:
	ld	(ix - 50), hl
	.local	.LBB1_7
.LBB1_7:
	push	bc
	pop	hl
	ld	de, (ix - 47)
	or	a, a
	sbc	hl, de
	push	bc
	pop	iy
	jr	c, .LBB1_9
; %bb.8:
	push	de
	pop	iy
	.local	.LBB1_9
.LBB1_9:
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	c, .LBB1_11
; %bb.10:
	push	de
	pop	bc
	.local	.LBB1_11
.LBB1_11:
	ld	a, (_anim_block_active)
	or	a, a
	jp	nz, .LBB1_25
; %bb.12:
	lea	de, iy + 0
                                        ; kill: def $c killed $c killed $ubc def $ubc
	ld	(ix - 53), bc
	ld	hl, (ix - 50)
                                        ; kill: def $l killed $l killed $uhl def $uhl
	ld	(ix - 47), hl
	jp	.LBB1_42
	.local	.LBB1_13
.LBB1_13:
	call	_draw_game_frame
	jp	.LBB1_22
	.local	.LBB1_14
.LBB1_14:
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_21
; %bb.15:
	ld	bc, 0
	lea	hl, ix - 3
	ld	(ix - 35), hl
	lea	hl, ix - 6
	ld	(ix - 59), hl
	ld	a, (ix - 38)
	ld	(ix - 3), a
	ld	a, (ix - 32)
	ld	(ix - 2), a
	ld	a, (ix - 56)
	ld	(ix - 6), a
	ld	a, (ix - 41)
	ld	(ix - 5), a
	ld	a, (_level_w)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	(ix - 56), hl
	.local	.LBB1_16
.LBB1_16:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jp	z, .LBB1_21
; %bb.17:                               ;   in Loop: Header=BB1_16 Depth=1
	ld	hl, (ix - 35)
	add	hl, bc
	ld	a, (hl)
	ld	hl, (ix - 59)
	ld	(ix - 62), bc
	add	hl, bc
	ld	e, (hl)
	ld	iy, 0
	ld	(ix - 65), a                    ; 1-byte Folded Spill
	ld	iyl, a
	lea	hl, iy + 0
	ld	bc, (ix - 56)
	call	__imulu
	ld	bc, 0
	ld	(ix - 68), e                    ; 1-byte Folded Spill
	ld	c, e
	add	hl, bc
	ex	de, hl
	ld	hl, _grid
	add	hl, de
	ld	a, (hl)
	ld	(ix - 32), a
	ld	(ix - 71), iy
	lea	hl, iy + 0
	ld	de, (ix - 50)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	(ix - 74), bc
	push	bc
	pop	hl
	ld	bc, (ix - 53)
	or	a, a
	sbc	hl, bc
	push	hl
	push	de
	call	_cardinal_dir
	ld	e, a
	pop	hl
	pop	hl
	ld	l, -20
	ld	a, (ix - 32)
	add	a, l
	ld	l, a
	cp	a, -4
	jr	c, .LBB1_20
; %bb.18:                               ;   in Loop: Header=BB1_16 Depth=1
	ld	a, e
	cp	a, 4
	jr	nc, .LBB1_20
; %bb.19:                               ;   in Loop: Header=BB1_16 Depth=1
	ld	hl, (ix - 44)
	ld	(ix - 77), e                    ; 1-byte Folded Spill
	ld	de, (ix - 71)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	hl, (ix - 47)
	ld	bc, (ix - 74)
	or	a, a
	sbc	hl, bc
	push	hl
	push	de
	call	_cardinal_dir
	ld	iyl, a
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, (ix - 77)                    ; 1-byte Folded Reload
	ld	l, (ix - 32)                    ; 1-byte Folded Reload
	ld	de, -16
	add	hl, de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, _ramp_turn_matches.turns
	add	hl, de
	add	hl, bc
	ld	a, (hl)
	cp	a, iyl
	jp	z, .LBB1_49
	.local	.LBB1_20
.LBB1_20:                               ;   in Loop: Header=BB1_16 Depth=1
	ld	bc, (ix - 62)
	inc	bc
	ld	de, 2
	jp	.LBB1_16
	.local	.LBB1_21
.LBB1_21:
	pea	ix - 9
	pea	ix - 6
	pea	ix - 3
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	bc, (ix - 3)
	ld	(ix - 32), bc
	ld	hl, (ix - 6)
	ld	(ix - 44), hl
	ld	de, (ix - 9)
	ld	(ix - 47), de
	push	de
	push	hl
	push	bc
	ld	l, (ix - 41)                    ; 1-byte Folded Reload
	push	hl
	ld	l, (ix - 38)                    ; 1-byte Folded Reload
	push	hl
	call	_draw_static_board_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	a, (_render_c)
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, a
	ld	(ix - 35), bc
	ld	hl, (ix - 32)
	call	__imulu
	ld	de, (ix - 44)
	add	hl, de
	ld	a, (_render_r)
	ld	e, a
	ld	iy, (ix - 32)
	ld	d, iyl
	ld	(ix - 41), e
	ld	(ix - 40), d
	mlt	de
	ld	bc, (ix - 47)
                                        ; kill: def $c killed $c killed $ubc
	ld	(ix - 38), c
	ld	a, e
	add	a, c
	ld	e, a
	push	iy
	push	iy
	push	de
	push	hl
	ld	hl, 1
	push	hl
	call	_gfx_BlitRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	a, (_player_r)
	ld	l, a
	ld	a, (_player_c)
	ld	e, a
	ld	bc, (ix - 47)
	push	bc
	ld	bc, (ix - 44)
	push	bc
	ld	bc, (ix - 32)
	push	bc
	push	de
	push	hl
	call	_draw_static_board_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	a, (_player_c)
	ld	bc, (ix - 35)
	ld	c, a
	ld	(ix - 35), bc
	ld	hl, (ix - 32)
	call	__imulu
	ld	(ix - 50), hl
	ld	bc, (ix - 32)
	push	bc
	pop	hl
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	call	__ishrs_1
	ex	de, hl
	push	de
	pop	iy
	ld	bc, (ix - 44)
	add	iy, bc
	ld	bc, (ix - 50)
	add	iy, bc
	ld	a, (_player_r)
	ld	bc, (ix - 35)
	ld	c, a
	ld	(ix - 35), bc
	ld	hl, (ix - 32)
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 47)
	add	hl, de
	add	hl, bc
	ld	de, (ix - 32)
	push	de
	push	hl
	push	iy
	call	_draw_ball_at
	pop	hl
	pop	hl
	pop	hl
	ld	a, (_player_c)
	ld	bc, (ix - 35)
	ld	c, a
	ld	hl, (ix - 32)
	call	__imulu
	ld	de, (ix - 44)
	add	hl, de
	ld	a, (_player_r)
	ld	e, (ix - 41)
	ld	d, (ix - 40)
	ld	e, a
	mlt	de
	ld	c, (ix - 38)
	ld	a, e
	add	a, c
	ld	e, a
	ld	bc, (ix - 32)
	push	bc
	push	bc
	push	de
	push	hl
	ld	hl, 1
	push	hl
	call	_gfx_BlitRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB1_22
.LBB1_22:
	ld	e, 0
	.local	.LBB1_23
.LBB1_23:
	ld	a, (_player_r)
	ld	(_render_r), a
	ld	a, (_player_c)
	ld	(_render_c), a
	ld	a, 1
	ld	(_render_pos_valid), a
	.local	.LBB1_24
.LBB1_24:
	ld	a, e
	ld	(_anim_block_active), a
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB1_25
.LBB1_25:
	ld	(ix - 44), iy
	ld	(ix - 53), bc
	ld	a, (_anim_block_from_r)
	ld	l, a
	ld	iy, (ix - 35)
	cp	a, iyl
	ld	h, l
	jr	c, .LBB1_27
; %bb.26:
	ex	de, hl
	ld	d, iyl
	ex	de, hl
	.local	.LBB1_27
.LBB1_27:
	ld	a, (_anim_block_to_r)
	ld	c, a
	cp	a, h
	ld	e, c
	ld	(ix - 35), de
	jr	c, .LBB1_29
; %bb.28:
	ld	e, h
	ld	(ix - 35), de
	.local	.LBB1_29
.LBB1_29:
	ld	de, (ix - 50)
	ld	a, e
	cp	a, l
	ld	iy, (ix - 44)
	jr	c, .LBB1_31
; %bb.30:
	ld	l, e
	.local	.LBB1_31
.LBB1_31:
	ld	a, l
	cp	a, c
	jr	c, .LBB1_33
; %bb.32:
	ld	c, l
	.local	.LBB1_33
.LBB1_33:
	ld	(ix - 47), bc
	ld	a, (_anim_block_from_c)
	ld	l, a
	cp	a, iyl
	ld	e, l
	jr	c, .LBB1_35
; %bb.34:
	ld	e, iyl
	.local	.LBB1_35
.LBB1_35:
	ld	a, (_anim_block_to_c)
	ld	iyl, a
	cp	a, e
	lea	bc, iy + 0
                                        ; kill: def $iyl killed $iyl killed $uiy def $uiy
	jr	c, .LBB1_37
; %bb.36:
	ld	iyl, e
	.local	.LBB1_37
.LBB1_37:
	ld	de, (ix - 53)
	ld	a, e
	cp	a, l
	jr	c, .LBB1_39
; %bb.38:
	ld	l, e
	.local	.LBB1_39
.LBB1_39:
	ld	a, l
	cp	a, c
	jr	c, .LBB1_41
; %bb.40:
	ld	c, l
	.local	.LBB1_41
.LBB1_41:
	ld	(ix - 53), bc
	lea	de, iy + 0
	.local	.LBB1_42
.LBB1_42:
	ld	iy, (ix - 6)
	ld	bc, 0
	ex	de, hl
	ld	(ix - 44), hl
	ld	c, l
	ld	hl, (ix - 32)
	call	__imulu
	ex	de, hl
	ld	(ix - 62), iy
	ld	(ix - 38), iy
	add	iy, de
	ld	(ix - 71), iy
	ld	iy, (ix - 9)
	ld	(ix - 41), iy
	ld	de, 0
	ld	hl, (ix - 35)
	ld	e, l
	ld	(ix - 50), de
	ld	de, (ix - 32)
	ld	h, e
	ld	(ix - 35), hl
                                        ; kill: def $hl killed $hl killed $uhl
	mlt	hl
	ld	a, iyl
	add	a, l
	ld	l, a
	ld	(ix - 74), hl
	ld	iy, 0
	lea	hl, iy + 0
	ld	de, (ix - 53)
	ld	l, e
	inc	hl
	or	a, a
	sbc	hl, bc
	ld	de, (ix - 32)
	push	de
	pop	bc
	call	__imulu
	ld	(ix - 77), hl
	lea	hl, iy + 0
	ld	bc, (ix - 47)
	ld	l, c
	inc	hl
	ld	bc, (ix - 50)
	or	a, a
	sbc	hl, bc
	push	de
	pop	bc
	call	__imulu
	ld	(ix - 80), hl
	call	_clock
	ld	(ix - 83), hl
	ld	(ix - 86), e                    ; 1-byte Folded Spill
	ld	bc, (ix - 32)
	push	bc
	pop	hl
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	call	__ishrs_1
	ex	de, hl
	ld	hl, (ix - 38)
	add	hl, de
	ld	(ix - 38), hl
	ld	hl, (ix - 41)
	add	hl, de
	ld	(ix - 89), hl
	ld	de, 13
	ld	bc, 1
	.local	.LBB1_43
.LBB1_43:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_45 Depth 2
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	e, 0
	jp	z, .LBB1_23
; %bb.44:                               ;   in Loop: Header=BB1_43 Depth=1
	ld	(ix - 50), bc
	ld	l, c
	ld	h, b
	ld.sis	bc, 3146
	call	__smulu
	ld.sis	bc, 12
	call	__sdivu
	ld	(ix - 10), e
	ld	bc, (ix - 12)
	ld	b, h
	ld	c, l
	or	a, a
	sbc	hl, hl
	ld	a, l
	ld	hl, (ix - 83)
	ld	e, (ix - 86)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 56), hl
	ld	(ix - 59), e                    ; 1-byte Folded Spill
	.local	.LBB1_45
.LBB1_45:                               ;   Parent Loop BB1_43 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	call	_clock
	ld	bc, (ix - 56)
	ld	a, (ix - 59)                    ; 1-byte Folded Reload
	call	__lcmpu
	jr	c, .LBB1_45
; %bb.46:                               ;   in Loop: Header=BB1_43 Depth=1
	ld	iy, (ix - 50)
	ld	de, -12
	add	iy, de
	ld	hl, (ix - 65)
	lea	bc, iy + 0
	call	__imulu
	ld	de, 12
	push	de
	pop	bc
	call	__idivs
	ld	(ix - 59), hl
	ld	hl, (ix - 68)
	lea	bc, iy + 0
	call	__imulu
	push	de
	pop	bc
	call	__idivs
	ld	(ix - 56), hl
	ld	hl, (ix - 53)
	push	hl
	ld	hl, (ix - 44)
	push	hl
	ld	hl, (ix - 47)
	push	hl
	ld	hl, (ix - 35)
	push	hl
	ld	hl, (ix - 41)
	push	hl
	ld	hl, (ix - 62)
	push	hl
	ld	hl, (ix - 32)
	push	hl
	call	_draw_animation_corridor
	ld	hl, 21
	add	hl, sp
	ld	sp, hl
	ld	a, (_anim_block_active)
	or	a, a
	jr	z, .LBB1_48
; %bb.47:                               ;   in Loop: Header=BB1_43 Depth=1
	ld	a, (_anim_block_to_c)
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, a
	ld	de, (ix - 32)
	push	de
	pop	hl
	call	__imulu
	ld	iy, (ix - 59)
	ld	bc, (ix - 62)
	add	iy, bc
	push	hl
	pop	bc
	add	iy, bc
	ld	a, (_anim_block_to_r)
	ld	bc, 0
	ld	c, a
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 92), hl
	ld	hl, (ix - 56)
	ld	bc, (ix - 41)
	add	hl, bc
	ld	bc, (ix - 92)
	add	hl, bc
	ld	a, (_anim_block_type)
	ld	c, a
	push	bc
	push	de
	push	hl
	push	iy
	call	_draw_block
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB1_48
.LBB1_48:                               ;   in Loop: Header=BB1_43 Depth=1
	ld	a, (_player_c)
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, a
	ld	de, (ix - 32)
	push	de
	pop	hl
	call	__imulu
	ld	iy, (ix - 38)
	ld	bc, (ix - 59)
	add	iy, bc
	push	hl
	pop	bc
	add	iy, bc
	ld	a, (_player_r)
	ld	bc, 0
	ld	c, a
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 59), hl
	ld	hl, (ix - 89)
	ld	bc, (ix - 56)
	add	hl, bc
	ld	bc, (ix - 59)
	add	hl, bc
	push	de
	push	hl
	push	iy
	call	_draw_ball_at
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 80)
	push	hl
	ld	hl, (ix - 77)
	push	hl
	ld	hl, (ix - 74)
	push	hl
	ld	hl, (ix - 71)
	push	hl
	ld	hl, 1
	push	hl
	call	_gfx_BlitRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	bc, (ix - 50)
	inc	bc
	ld	de, 13
	jp	.LBB1_43
	.local	.LBB1_49
.LBB1_49:
	pea	ix - 9
	pea	ix - 6
	pea	ix - 3
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	bc, (ix - 50)
	push	bc
	pop	hl
	ld	de, (ix - 44)
	or	a, a
	sbc	hl, de
	ld	(ix - 32), bc
	jr	c, .LBB1_51
; %bb.50:
	ld	(ix - 32), de
	.local	.LBB1_51
.LBB1_51:
	ex	de, hl
	or	a, a
	sbc	hl, bc
	jr	c, .LBB1_53
; %bb.52:
	ld	bc, (ix - 44)
	.local	.LBB1_53
.LBB1_53:
	ld	(ix - 56), bc
	ld	iy, (ix - 53)
	lea	hl, iy + 0
	ld	de, (ix - 47)
	or	a, a
	sbc	hl, de
	jr	c, .LBB1_55
; %bb.54:
	push	de
	pop	iy
	.local	.LBB1_55
.LBB1_55:
	ld	(ix - 35), iy
	ex	de, hl
	ld	bc, (ix - 53)
	or	a, a
	sbc	hl, bc
	jr	c, .LBB1_57
; %bb.56:
	ld	bc, (ix - 47)
	.local	.LBB1_57
.LBB1_57:
	ld	(ix - 38), bc
	ld	c, (ix - 65)                    ; 1-byte Folded Reload
	ld	a, c
	ld	de, (ix - 32)
	cp	a, e
	ld	l, c
	ld	(ix - 41), hl
	ld	iy, (ix - 56)
	jp	c, .LBB1_59
; %bb.58:
                                        ; kill: def $e killed $e killed $ude def $ude
	ld	(ix - 41), de
	.local	.LBB1_59
.LBB1_59:
	ld	a, iyl
	cp	a, c
	ld	e, (ix - 68)                    ; 1-byte Folded Reload
	ld	hl, (ix - 35)
	jr	c, .LBB1_61
; %bb.60:
	ld	c, iyl
	.local	.LBB1_61
.LBB1_61:
	ld	a, e
	cp	a, l
	push	hl
	pop	iy
	ld	l, e
	jr	c, .LBB1_63
; %bb.62:
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	.local	.LBB1_63
.LBB1_63:
	ld	(ix - 65), c                    ; 1-byte Folded Spill
	ld	bc, (ix - 38)
	ld	a, c
	cp	a, e
	jr	c, .LBB1_65
; %bb.64:
	ld	e, c
	.local	.LBB1_65
.LBB1_65:
	ld	(ix - 68), e
	ld	de, (ix - 6)
	ld	(ix - 56), de
	ld	bc, 0
	ld	(ix - 77), hl
	ld	c, l
	ld	hl, (ix - 3)
	ld	(ix - 35), hl
	call	__imulu
	ld	de, (ix - 56)
	add	hl, de
	ld	(ix - 80), hl
	ld	hl, (ix - 9)
	ld	(ix - 59), hl
	ld	iy, 0
	lea	de, iy + 0
	ld	hl, (ix - 41)
	ld	e, l
	ld	(ix - 32), de
	ld	de, (ix - 35)
	ld	h, e
	ld	(ix - 41), hl
                                        ; kill: def $hl killed $hl killed $uhl
	mlt	hl
	ld	de, (ix - 59)
	ld	a, l
	add	a, e
	ld	l, a
	ld	(ix - 83), hl
	push	af
	ld	a, (ix - 68)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	inc	bc
	ld	de, (ix - 35)
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 86), hl
	push	af
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	lea	hl, iy + 0
	ld	bc, (ix - 32)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	inc	bc
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 89), hl
	push	de
	pop	hl
	ld	bc, (ix - 53)
	call	__imulu
	ld	(ix - 53), hl
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	call	__ishrs_1
	push	hl
	pop	iy
	ld	(ix - 32), iy
	ld	bc, (ix - 56)
	add	iy, bc
	ld	(ix - 38), iy
	ld	de, (ix - 53)
	add	iy, de
	ld	(ix - 53), iy
	ld	iy, (ix - 35)
	lea	hl, iy + 0
	ld	bc, (ix - 50)
	call	__imulu
	push	hl
	pop	bc
	ld	de, (ix - 59)
	ld	hl, (ix - 32)
	add	hl, de
	ld	(ix - 32), hl
	add	hl, bc
	ld	(ix - 50), hl
	lea	de, iy + 0
	push	de
	pop	hl
	ld	bc, (ix - 74)
	call	__imulu
	push	hl
	pop	bc
	ld	iy, (ix - 38)
	lea	hl, iy + 0
	add	hl, bc
	ld	(ix - 62), hl
	push	de
	pop	hl
	ld	bc, (ix - 71)
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 32)
	add	hl, bc
	ld	(ix - 71), hl
	push	de
	pop	hl
	ld	bc, (ix - 47)
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	ld	(ix - 38), iy
	ex	de, hl
	ld	bc, (ix - 44)
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 32)
	add	hl, de
	ld	(ix - 32), hl
	call	_clock
	ld	(ix - 74), hl
	ld	(ix - 92), e                    ; 1-byte Folded Spill
	ld	de, 13
	ld	l, (ix - 68)                    ; 1-byte Folded Reload
	ld	(ix - 68), hl
	ld	l, (ix - 65)                    ; 1-byte Folded Reload
	ld	(ix - 95), hl
	ld	bc, 1
	.local	.LBB1_66
.LBB1_66:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_68 Depth 2
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	e, 0
	jp	z, .LBB1_23
; %bb.67:                               ;   in Loop: Header=BB1_66 Depth=1
	ld	(ix - 44), bc
	ld	l, c
	ld	h, b
	ld.sis	bc, 3146
	call	__smulu
	ld.sis	bc, 12
	call	__sdivu
	ld	(ix - 29), e
	ld	bc, (ix - 31)
	ld	b, h
	ld	c, l
	or	a, a
	sbc	hl, hl
	ld	a, l
	ld	hl, (ix - 74)
	ld	e, (ix - 92)                    ; 1-byte Folded Reload
	ld	(ix - 103), a                   ; 1-byte Folded Spill
	call	__ladd
	ld	(ix - 47), hl
	ld	(ix - 65), e                    ; 1-byte Folded Spill
	.local	.LBB1_68
.LBB1_68:                               ;   Parent Loop BB1_66 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	call	_clock
	ld	bc, (ix - 47)
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	call	__lcmpu
	jr	c, .LBB1_68
; %bb.69:                               ;   in Loop: Header=BB1_66 Depth=1
	ld	hl, (ix - 32)
	ld	(ix - 28), hl
	ld	a, (ix - 26)
	rlc	a
	sbc	a, a
	ld	(ix - 47), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 71)
	ld	(ix - 25), hl
	ld	a, (ix - 23)
	rlc	a
	sbc	a, a
	ld	(ix - 65), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 50)
	ld	(ix - 22), hl
	ld	a, (ix - 20)
	rlc	a
	sbc	a, a
	ld	(ix - 98), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 38)
	ld	(ix - 19), hl
	ld	a, (ix - 17)
	rlc	a
	sbc	a, a
	ld	(ix - 101), a                   ; 1-byte Folded Spill
	ld	hl, (ix - 62)
	ld	(ix - 16), hl
	ld	a, (ix - 14)
	rlc	a
	sbc	a, a
	ld	(ix - 102), a                   ; 1-byte Folded Spill
	ld	hl, (ix - 53)
	ld	(ix - 13), hl
	ld	a, (ix - 11)
	rlc	a
	sbc	a, a
	ld	(ix - 106), a                   ; 1-byte Folded Spill
	ld	hl, (ix - 44)
	ld	c, 8
	call	__ishl
	ld	bc, 12
	call	__idivu
	push	hl
	pop	bc
	ld	a, (ix - 103)                   ; 1-byte Folded Reload
	ld	e, a
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	ld	l, 1
	call	__lshl
	ld	hl, 768
	ld	e, l
	call	__lsub
	push	hl
	pop	bc
	ld	a, e
	lea	hl, iy + 0
	ld	e, d
	call	__lmulu
	ld	bc, 32768
	xor	a, a
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 16
	call	__lshru
	ld	(ix - 120), bc
	ld	(ix - 121), a
	ld	hl, 256
	ld	e, l
	call	__lsub
	push	hl
	pop	iy
	ld	d, e
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	ld	(ix - 109), hl
	ld	(ix - 103), e
	ld	bc, (ix - 53)
	ld	a, (ix - 106)                   ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 112), hl
	ld	(ix - 113), e                   ; 1-byte Folded Spill
	lea	bc, iy + 0
	ld	a, d
	ld	l, 1
	call	__lshl
	push	bc
	pop	hl
	ld	e, a
	ld	iy, (ix - 120)
	lea	bc, iy + 0
	ld	d, (ix - 121)                   ; 1-byte Folded Reload
	ld	a, d
	call	__lmulu
	ld	(ix - 116), hl
	ld	(ix - 117), e
	ld	bc, (ix - 62)
	ld	a, (ix - 102)                   ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 124), hl
	ld	(ix - 125), e                   ; 1-byte Folded Spill
	lea	hl, iy + 0
	ld	e, d
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	ld	(ix - 106), hl
	ld	(ix - 102), e
	ld	bc, (ix - 38)
	ld	a, (ix - 101)                   ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 112)
	ld	a, (ix - 113)                   ; 1-byte Folded Reload
	call	__ladd
	ld	bc, (ix - 124)
	ld	a, (ix - 125)                   ; 1-byte Folded Reload
	call	__ladd
	ld	bc, 32768
	xor	a, a
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 16
	call	__lshru
	ld	(ix - 101), bc
	ld	hl, (ix - 109)
	ld	e, (ix - 103)                   ; 1-byte Folded Reload
	ld	bc, (ix - 50)
	ld	a, (ix - 98)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 98), hl
	ld	(ix - 103), e                   ; 1-byte Folded Spill
	ld	hl, (ix - 116)
	ld	e, (ix - 117)                   ; 1-byte Folded Reload
	ld	bc, (ix - 71)
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	ld	hl, (ix - 106)
	ld	e, (ix - 102)                   ; 1-byte Folded Reload
	ld	bc, (ix - 32)
	ld	a, (ix - 47)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 98)
	ld	a, (ix - 103)                   ; 1-byte Folded Reload
	call	__ladd
	lea	bc, iy + 0
	ld	a, d
	call	__ladd
	ld	bc, 32768
	xor	a, a
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 16
	call	__lshru
	ld	(ix - 47), bc
	ld	hl, (ix - 68)
	push	hl
	ld	hl, (ix - 77)
	push	hl
	ld	hl, (ix - 95)
	push	hl
	ld	hl, (ix - 41)
	push	hl
	ld	hl, (ix - 59)
	push	hl
	ld	hl, (ix - 56)
	push	hl
	ld	hl, (ix - 35)
	push	hl
	call	_draw_animation_corridor
	ld	hl, 21
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 35)
	push	hl
	ld	hl, (ix - 47)
	push	hl
	ld	hl, (ix - 101)
	push	hl
	call	_draw_ball_at
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 89)
	push	hl
	ld	hl, (ix - 86)
	push	hl
	ld	hl, (ix - 83)
	push	hl
	ld	hl, (ix - 80)
	push	hl
	ld	hl, 1
	push	hl
	call	_gfx_BlitRectangle
	ld	bc, (ix - 44)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	inc	bc
	ld	de, 13
	jp	.LBB1_66
	.local	.Lfunc_end1
.Lfunc_end1:
	.size	_engine_tick, .Lfunc_end1-_engine_tick
                                        ; -- End function
	.section	.text._board_geometry,"ax",@progbits
	.type	_board_geometry,@function       ; -- Begin function board_geometry
_board_geometry:                        ; @board_geometry
; %bb.0:
	call	__frameset0
	call	_tile_size
	ld	de, 0
	push	de
	pop	bc
	ld	c, a
	ld	a, (_level_w)
	ld	e, a
	push	de
	pop	hl
	call	__imulu
	push	hl
	pop	iy
	ld	a, (_level_h)
	ld	e, a
	ex	de, hl
	call	__imulu
	ex	de, hl
	ld	hl, (ix + 6)
	ld	(hl), bc
	ld	hl, 252
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ishrs_1
	ld	bc, 68
	add	hl, bc
	ld	iy, (ix + 9)
	ld	(iy), hl
	ld	hl, 240
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	call	__ishrs_1
	ld	iy, (ix + 12)
	ld	(iy), hl
	pop	ix
	ret
	.local	.Lfunc_end2
.Lfunc_end2:
	.size	_board_geometry, .Lfunc_end2-_board_geometry
                                        ; -- End function
	.section	.text._draw_animation_corridor,"ax",@progbits
	.type	_draw_animation_corridor,@function ; -- Begin function draw_animation_corridor
_draw_animation_corridor:               ; @draw_animation_corridor
; %bb.0:
	ld	hl, -6
	call	__frameset
	ld	hl, (ix + 6)
	ld	bc, (ix + 12)
	ld	a, (ix + 15)
	ld	e, (ix + 21)
	ld	iyl, a
	.local	.LBB3_1
.LBB3_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_2 Depth 2
	ld	a, (ix + 18)
	ld	(ix - 3), iy
	cp	a, iyl
	ld	iyl, e
	jr	c, .LBB3_5
	.local	.LBB3_2
.LBB3_2:                                ; %.preheader
                                        ;   Parent Loop BB3_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	a, (ix + 24)
	cp	a, iyl
	jr	c, .LBB3_4
; %bb.3:                                ;   in Loop: Header=BB3_2 Depth=2
	push	bc
	ld	de, (ix + 9)
	push	de
	push	hl
	push	iy
	ld	hl, (ix - 3)
	push	hl
	ld	(ix - 6), iy
	call	_draw_static_board_cell
	ld	iy, (ix - 6)
	ld	bc, (ix + 12)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix + 6)
	inc	iyl
	jr	.LBB3_2
	.local	.LBB3_4
.LBB3_4:                                ;   in Loop: Header=BB3_1 Depth=1
	ld	iy, (ix - 3)
	inc	iyl
	ld	e, (ix + 21)
	jr	.LBB3_1
	.local	.LBB3_5
.LBB3_5:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end3
.Lfunc_end3:
	.size	_draw_animation_corridor, .Lfunc_end3-_draw_animation_corridor
                                        ; -- End function
	.section	.text._draw_block,"ax",@progbits
	.type	_draw_block,@function           ; -- Begin function draw_block
_draw_block:                            ; @draw_block
; %bb.0:
	ld	hl, -33
	call	__frameset
	ld	iy, (ix + 12)
	ld	bc, 85
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB4_2
; %bb.1:
	ld	iy, 1
	.local	.LBB4_2
.LBB4_2:
	lea	hl, iy + 0
	add	hl, hl
	ld	de, 42
	add	hl, de
	call	__idivu
	push	hl
	pop	bc
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	nc, .LBB4_4
; %bb.3:
	ld	bc, 1
	.local	.LBB4_4
.LBB4_4:
	ld	(ix - 24), bc
	lea	hl, iy + 0
	call	__ishru_1
	lea	de, iy + 0
	push	hl
	pop	iy
	ld	bc, (ix + 6)
	add	iy, bc
	ld	(ix - 9), iy
	ld	bc, (ix + 9)
	add	hl, bc
	ld	(ix - 6), hl
	push	de
	pop	hl
	ld	bc, 18
	call	__imulu
	ld	bc, 42
	add	hl, bc
	ld	bc, 85
	call	__idivu
	push	hl
	pop	iy
	push	de
	pop	hl
	ld	bc, 12
	call	__imulu
	ld	bc, 42
	add	hl, bc
	ld	bc, 85
	call	__idivu
	ld	(ix - 12), hl
	push	de
	pop	hl
	ld	bc, 20
	call	__imulu
	ld	bc, 42
	add	hl, bc
	ld	bc, 85
	call	__idivu
	ld	(ix - 3), hl
	ld	(ix - 21), de
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, 42
	add	hl, de
	call	__idivu
	push	hl
	pop	bc
	ld	de, 3
	ld	(ix - 15), iy
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB4_6
; %bb.5:
	ld	hl, 2
	ld	(ix - 15), hl
	.local	.LBB4_6
.LBB4_6:
	ld	hl, (ix - 12)
	or	a, a
	sbc	hl, de
	jr	nc, .LBB4_8
; %bb.7:
	ld	hl, 2
	ld	(ix - 12), hl
	.local	.LBB4_8
.LBB4_8:
	ld	de, 4
	ld	hl, (ix - 3)
	or	a, a
	sbc	hl, de
	ld	de, 1
	jr	nc, .LBB4_10
; %bb.9:
	ld	hl, 3
	ld	(ix - 3), hl
	.local	.LBB4_10
.LBB4_10:
	ld	(ix - 18), bc
	push	bc
	pop	hl
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_12
; %bb.11:
	ld	(ix - 18), de
	.local	.LBB4_12
.LBB4_12:
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 21)
	push	hl
	push	hl
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	a, (ix + 15)
	cp	a, 13
	jr	z, .LBB4_14
; %bb.13:
	ld	a, 0
	jr	.LBB4_15
	.local	.LBB4_14
.LBB4_14:
	ld	a, -1
	.local	.LBB4_15
.LBB4_15:
	ld	l, 14
	add	a, l
	ld	l, a
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 24)
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	lea	bc, iy + 0
	push	hl
	pop	iy
	ld	de, (ix + 9)
	add	iy, de
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 21)
	or	a, a
	sbc	hl, de
	push	hl
	push	hl
	push	iy
	push	bc
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 18)
	call	__ishru_1
	ex	de, hl
	ld	(ix - 27), de
	ld	hl, (ix - 9)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	hl, (ix - 6)
	ld	bc, (ix - 15)
	or	a, a
	sbc	hl, bc
	ld	(ix - 15), bc
	ex	de, hl
	ld	(ix - 30), de
	push	bc
	pop	hl
	ld	(ix - 21), hl
	add	hl, hl
	inc	hl
	ld	(ix - 33), hl
	push	hl
	ld	hl, (ix - 18)
	push	hl
	push	de
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 9)
	ld	de, (ix - 15)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	(ix - 24), de
	ld	hl, (ix - 6)
	ld	bc, (ix - 27)
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 18)
	push	bc
	ld	bc, (ix - 33)
	push	bc
	push	hl
	push	de
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 30)
	lea	hl, iy + 0
	ld	de, (ix - 3)
	or	a, a
	sbc	hl, de
	ld	(ix - 33), hl
	ld	bc, (ix - 9)
	push	bc
	pop	hl
	ld	de, (ix - 12)
	or	a, a
	sbc	hl, de
	ld	(ix - 18), hl
	ld	(ix - 15), de
	ex	de, hl
	add	hl, bc
	ld	(ix - 27), hl
	push	iy
	push	hl
	push	iy
	ld	hl, (ix - 18)
	push	hl
	ld	hl, (ix - 33)
	push	hl
	push	bc
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 21)
	ld	de, (ix - 6)
	add	hl, de
	push	hl
	pop	iy
	ld	de, (ix - 3)
	add	iy, de
	push	hl
	ld	de, (ix - 27)
	push	de
	push	hl
	ld	hl, (ix - 18)
	push	hl
	push	iy
	ld	hl, (ix - 9)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 24)
	lea	hl, iy + 0
	ld	bc, (ix - 3)
	or	a, a
	sbc	hl, bc
	ld	(ix - 18), hl
	ld	bc, (ix - 6)
	push	bc
	pop	hl
	ld	de, (ix - 12)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	(ix - 12), de
	ld	hl, (ix - 15)
	add	hl, bc
	ld	(ix - 15), hl
	push	hl
	push	iy
	push	de
	push	iy
	push	bc
	ld	hl, (ix - 18)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 21)
	ld	de, (ix - 9)
	add	hl, de
	push	hl
	pop	iy
	ld	de, (ix - 3)
	add	iy, de
	ld	de, (ix - 15)
	push	de
	push	hl
	ld	de, (ix - 12)
	push	de
	push	hl
	ld	hl, (ix - 6)
	push	hl
	push	iy
	call	_gfx_FillTriangle
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end4
.Lfunc_end4:
	.size	_draw_block, .Lfunc_end4-_draw_block
                                        ; -- End function
	.section	.text._draw_ball_at,"ax",@progbits
	.type	_draw_ball_at,@function         ; -- Begin function draw_ball_at
_draw_ball_at:                          ; @draw_ball_at
; %bb.0:
	ld	hl, -12
	call	__frameset
	ld	hl, (ix + 6)
	ld	(ix - 3), hl
	ld	hl, (ix + 9)
	ld	(ix - 6), hl
	ld	de, (ix + 12)
	ld	iy, 85
	ld	bc, 2
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	call	pe, __setflag
	jp	p, .LBB5_2
; %bb.1:
	ld	de, 1
	.local	.LBB5_2
.LBB5_2:
	push	de
	pop	hl
	ld	bc, 44
	call	__imulu
	ld	bc, 42
	add	hl, bc
	lea	bc, iy + 0
	call	__idivu
	push	hl
	pop	iy
	ex	de, hl
	ld	bc, 37
	call	__imulu
	ld	de, 42
	add	hl, de
	ld	bc, 85
	call	__idivu
	push	hl
	pop	bc
	ld	de, 3
	ld	(ix - 9), iy
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB5_4
; %bb.3:
	ld	hl, 2
	ld	(ix - 9), hl
	.local	.LBB5_4
.LBB5_4:
	push	bc
	pop	hl
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	nc, .LBB5_6
; %bb.5:
	ld	bc, 1
	.local	.LBB5_6
.LBB5_6:
	ld	(ix - 12), bc
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 9)
	push	hl
	ld	hl, (ix - 6)
	push	hl
	ld	hl, (ix - 3)
	push	hl
	call	_gfx_FillCircle
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 15
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 3)
	ld	(ix + 6), hl
	ld	hl, (ix - 6)
	ld	(ix + 9), hl
	ld	hl, (ix - 12)
	ld	(ix + 12), hl
	ld	sp, ix
	pop	ix
	jp	_gfx_FillCircle
	.local	.Lfunc_end5
.Lfunc_end5:
	.size	_draw_ball_at, .Lfunc_end5-_draw_ball_at
                                        ; -- End function
	.section	.text._cardinal_dir,"ax",@progbits
	.type	_cardinal_dir,@function         ; -- Begin function cardinal_dir
_cardinal_dir:                          ; @cardinal_dir
; %bb.0:
	call	__frameset0
	ld	bc, (ix + 6)
	ld	iy, (ix + 9)
	ld	de, -1
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jr	nz, .LBB6_3
; %bb.1:
	sbc	hl, hl
	adc	hl, de
	jr	nz, .LBB6_3
; %bb.2:
	ld	l, 0
	jr	.LBB6_14
	.local	.LBB6_3
.LBB6_3:
	push	de
	pop	iy
	sbc	hl, hl
	adc	hl, bc
	ld	de, 1
	jr	nz, .LBB6_6
; %bb.4:
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	nz, .LBB6_6
; %bb.5:
	ld	l, 1
	jr	.LBB6_14
	.local	.LBB6_6
.LBB6_6:
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jr	nz, .LBB6_9
; %bb.7:
	lea	hl, iy + 0
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB6_9
; %bb.8:
	ld	l, 2
	jr	.LBB6_14
	.local	.LBB6_9
.LBB6_9:
	sbc	hl, hl
	adc	hl, bc
	ld	c, -1
	ld	b, 0
	ld	a, c
	jr	nz, .LBB6_11
; %bb.10:
	ld	a, b
	.local	.LBB6_11
.LBB6_11:
	lea	hl, iy + 0
	ld	de, -1
	or	a, a
	sbc	hl, de
	jr	nz, .LBB6_13
; %bb.12:
	ld	c, b
	.local	.LBB6_13
.LBB6_13:
	or	a, c
	ld	l, a
	ld	b, 7
	call	__bshl
	rlc	a
	sbc	a, a
	ld	l, 3
	or	a, l
	ld	l, a
	.local	.LBB6_14
.LBB6_14:
	ld	a, l
	pop	ix
	ret
	.local	.Lfunc_end6
.Lfunc_end6:
	.size	_cardinal_dir, .Lfunc_end6-_cardinal_dir
                                        ; -- End function
	.section	.text._draw_static_board_cell,"ax",@progbits
	.type	_draw_static_board_cell,@function ; -- Begin function draw_static_board_cell
_draw_static_board_cell:                ; @draw_static_board_cell
; %bb.0:
	ld	hl, -10
	call	__frameset
	ld	e, (ix + 6)
	ld	bc, 0
	ld	a, (_level_h)
	ld	l, a
	ld	a, e
	cp	a, l
	jp	nc, .LBB7_9
; %bb.1:
	ld	l, (ix + 9)
	ld	a, (_level_w)
	ld	iyl, a
	ld	a, l
	cp	a, iyl
	jp	nc, .LBB7_9
; %bb.2:
	ld	a, l
	push	bc
	pop	hl
	ld	c, e
	ex	de, hl
	ld	e, a
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	push	bc
	pop	iy
	call	__imulu
	add	hl, de
	push	hl
	pop	bc
	ld	(ix - 4), bc
	ld	hl, _grid
	add	hl, bc
	ld	a, (hl)
	ld	(ix - 1), a
	ex	de, hl
	ld	bc, (ix + 12)
	call	__imulu
	ld	de, (ix + 15)
	add	hl, de
	ex	de, hl
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	iy
	ld	bc, (ix + 18)
	add	iy, bc
	or	a, a
	sbc	hl, hl
	push	hl
	ld	l, (ix - 1)                     ; 1-byte Folded Reload
	push	hl
	ld	hl, (ix + 12)
	push	hl
	ld	(ix - 10), iy
	push	iy
	ex	de, hl
	ld	(ix - 7), hl
	push	hl
	call	_draw_raw_tile
	ld	c, (ix - 1)                     ; 1-byte Folded Reload
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	l, -5
	ld	a, c
	add	a, l
	ld	l, a
	cp	a, 5
	jr	nc, .LBB7_4
; %bb.3:
	ld	de, -4
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	a, (_coin_count)
	ld	l, a
	add	iy, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, 1
	push	hl
	ld	hl, (ix + 12)
	push	hl
	ld	hl, (ix - 10)
	push	hl
	ld	hl, (ix - 7)
	push	hl
	call	nc, _draw_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB7_4
.LBB7_4:
	ld	hl, _blocks
	ld	de, (ix - 4)
	add	hl, de
	ld	l, (hl)
	ld	a, l
	or	a, a
	ld	d, (ix + 6)
	ld	b, (ix + 9)
	jp	z, .LBB7_9
; %bb.5:
	ld	a, (_anim_block_active)
	ld	h, a
	ld	a, (_anim_block_to_r)
	ld	c, a
	ld	a, (_anim_block_to_c)
	ld	e, a
	ld	a, h
	or	a, a
	jr	z, .LBB7_8
; %bb.6:
	ld	a, c
	cp	a, d
	jr	nz, .LBB7_8
; %bb.7:
	ld	a, e
	cp	a, b
	jp	z, .LBB7_9
	.local	.LBB7_8
.LBB7_8:
                                        ; kill: def $l killed $l def $uhl
	push	hl
	ld	hl, (ix + 12)
	push	hl
	ld	hl, (ix - 10)
	push	hl
	ld	hl, (ix - 7)
	push	hl
	call	_draw_block
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB7_9
.LBB7_9:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end7
.Lfunc_end7:
	.size	_draw_static_board_cell, .Lfunc_end7-_draw_static_board_cell
                                        ; -- End function
	.section	.text._draw_game_frame,"ax",@progbits
	.type	_draw_game_frame,@function      ; -- Begin function draw_game_frame
_draw_game_frame:                       ; @draw_game_frame
; %bb.0:
	call	_render_game_frame_offset
	jp	_gfx_SwapDraw
	.local	.Lfunc_end8
.Lfunc_end8:
	.size	_draw_game_frame, .Lfunc_end8-_draw_game_frame
                                        ; -- End function
	.section	.text._render_game_frame_offset,"ax",@progbits
	.type	_render_game_frame_offset,@function ; -- Begin function render_game_frame_offset
_render_game_frame_offset:              ; @render_game_frame_offset
; %bb.0:
	ld	hl, -64
	call	__frameset
	ld	de, 0
	ld.sis	hl, 0
	ld	(ix - 30), l
	ld	(ix - 29), h
	lea	hl, ix - 24
	ld	(ix - 51), hl
	push	de
	call	_gfx_FillScreen
	pop	hl
	ld	hl, 24
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 240
	push	hl
	ld	hl, 68
	push	hl
	or	a, a
	sbc	hl, hl
	push	hl
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	call	_tile_size
	ld	de, 0
	push	de
	pop	bc
	ld	c, a
	ld	a, (_level_w)
	push	de
	pop	hl
	ld	l, a
	ld	(ix - 36), hl
	call	__imulu
	push	hl
	pop	iy
	ld	a, (_level_h)
	ld	e, a
	push	de
	pop	hl
	ld	(ix - 27), bc
	call	__imulu
	ld	(ix - 33), hl
	ld	hl, 252
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ishrs_1
	ld	bc, 68
	add	hl, bc
	ld	(ix - 54), hl
	ld	(ix - 46), hl
	ld	hl, 240
	ld	bc, (ix - 33)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ishrs_1
	ld	(ix - 33), hl
	ex	de, hl
	ld	bc, (ix - 36)
	call	__imulu
	push	hl
	pop	bc
	or	a, a
	sbc	hl, hl
	ld	(ix - 43), hl
	ld	de, 0
	.local	.LBB9_1
.LBB9_1:                                ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jp	z, .LBB9_10
; %bb.2:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	(ix - 57), bc
	ld	a, (_level_w)
	ld	c, a
	ld	b, 0
	ld	l, (ix - 30)
	ld	h, (ix - 29)
	call	__sdivu
	ld	(ix - 48), l
	ld	(ix - 47), h
	ld	(ix - 62), c
	ld	(ix - 61), b
	call	__smulu
	ld	c, l
	ld	b, h
	ld	l, e
	ld	h, d
	or	a, a
	sbc.sis	hl, bc
	ld	c, l
	ld	b, h
	or	a, a
	sbc	hl, hl
	ld	(ix - 64), c
	ld	(ix - 63), b
	ld	l, c
	ld	h, b
	ld	iy, _grid
	ld	(ix - 36), de
	add	iy, de
	ld	a, (iy)
	ld	(ix - 37), a
	ld	iy, (ix - 27)
	lea	bc, iy + 0
	call	__imulu
	ld	de, (ix - 46)
	add	hl, de
	ld	(ix - 40), hl
	ld	l, (ix - 48)
	ld	h, (ix - 47)
	ld.sis	bc, 255
	call	__sand
	ld	de, 0
	ld	e, l
	ld	d, h
	ex	de, hl
	lea	bc, iy + 0
	call	__imulu
	push	hl
	pop	iy
	ld	de, (ix - 33)
	add	iy, de
	or	a, a
	sbc	hl, hl
	push	hl
	ld	l, (ix - 37)                    ; 1-byte Folded Reload
	push	hl
	ld	hl, (ix - 27)
	push	hl
	ld	(ix - 60), iy
	push	iy
	ld	hl, (ix - 40)
	push	hl
	call	_draw_raw_tile
	ld	e, (ix - 37)                    ; 1-byte Folded Reload
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	l, -5
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, 5
	jr	nc, .LBB9_4
; %bb.3:                                ;   in Loop: Header=BB9_1 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	a, (_coin_count)
	ld	l, a
	ld	de, -4
	add	iy, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, 1
	push	hl
	ld	hl, (ix - 27)
	push	hl
	ld	hl, (ix - 60)
	push	hl
	ld	hl, (ix - 40)
	push	hl
	call	nc, _draw_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB9_4
.LBB9_4:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	hl, _blocks
	ld	de, (ix - 36)
	add	hl, de
	ld	e, (hl)
	ld	a, e
	or	a, a
	jr	z, .LBB9_9
; %bb.5:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	a, (_anim_block_active)
	ld	h, a
	ld	a, (_anim_block_to_r)
	ld	c, a
	ld	a, (_anim_block_to_c)
	ld	l, a
	ld	a, h
	or	a, a
	jr	z, .LBB9_8
; %bb.6:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	a, c
	ld	c, (ix - 48)
	ld	b, (ix - 47)
	cp	a, c
	jr	nz, .LBB9_8
; %bb.7:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	c, (ix - 62)
	ld	b, (ix - 61)
	ld	c, l
	ld	l, (ix - 64)
	ld	h, (ix - 63)
	or	a, a
	sbc.sis	hl, bc
	jr	z, .LBB9_9
	.local	.LBB9_8
.LBB9_8:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	l, e
	push	hl
	ld	hl, (ix - 27)
	push	hl
	ld	hl, (ix - 60)
	push	hl
	ld	hl, (ix - 40)
	push	hl
	call	_draw_block
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB9_9
.LBB9_9:                                ;   in Loop: Header=BB9_1 Depth=1
	ld	de, (ix - 36)
	inc	de
	ld	l, (ix - 30)
	ld	h, (ix - 29)
	inc.sis	hl
	ld	(ix - 30), l
	ld	(ix - 29), h
	ld	bc, (ix - 57)
	jp	.LBB9_1
	.local	.LBB9_10
.LBB9_10:
	ld	a, (_anim_block_active)
	or	a, a
	jr	z, .LBB9_12
; %bb.11:
	ld	a, (_anim_block_to_c)
	ld	iy, 0
	ld	iyl, a
	lea	hl, iy + 0
	ld	bc, (ix - 27)
	call	__imulu
	ld	de, (ix - 46)
	add	hl, de
	ld	(ix - 30), hl
	ld	a, (_anim_block_to_r)
	ld	iyl, a
	lea	hl, iy + 0
	call	__imulu
	ld	de, (ix - 33)
	add	hl, de
	ld	a, (_anim_block_type)
	ld	e, a
	push	de
	push	bc
	push	hl
	ld	hl, (ix - 30)
	push	hl
	call	_draw_block
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB9_12
.LBB9_12:
	ld	de, 2
	ld	iy, (ix - 27)
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB9_14
; %bb.13:
	ld	iy, 1
	.local	.LBB9_14
.LBB9_14:
	ld	a, (_player_c)
	ld	de, 0
	ld	e, a
	push	de
	pop	hl
	ld	bc, (ix - 27)
	call	__imulu
	ld	(ix - 36), hl
	lea	hl, iy + 0
	call	__ishru_1
	push	hl
	pop	bc
	ld	(ix - 30), bc
	ld	iy, (ix - 54)
	add	iy, bc
	ld	bc, (ix - 36)
	add	iy, bc
	ld	a, (_player_r)
	ld	e, a
	ex	de, hl
	ld	bc, (ix - 27)
	call	__imulu
	ld	(ix - 36), hl
	ld	hl, (ix - 33)
	ld	de, (ix - 30)
	add	hl, de
	ld	de, (ix - 36)
	add	hl, de
	push	bc
	push	hl
	push	iy
	call	_draw_ball_at
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	a, (_active_name)
	ld	e, a
	ld	iy, _active_name
	.local	.LBB9_15
.LBB9_15:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_18 Depth 2
                                        ;     Child Loop BB9_32 Depth 2
                                        ;     Child Loop BB9_35 Depth 2
	ld	a, e
	or	a, a
	jp	z, .LBB9_37
; %bb.16:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	hl, (ix - 43)
	ld	bc, 4
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB9_37
; %bb.17:                               ; %.preheader.preheader
                                        ;   in Loop: Header=BB9_15 Depth=1
	ld	hl, 1
	ld	(ix - 27), hl
	ld	d, h
	ld	c, -1
	.local	.LBB9_18
.LBB9_18:                               ; %.preheader
                                        ;   Parent Loop BB9_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	a, e
	or	a, a
	jr	z, .LBB9_23
; %bb.19:                               ; %.preheader
                                        ;   in Loop: Header=BB9_18 Depth=2
	ld	a, c
	ld	bc, (ix - 27)
	dec	bc
	push	bc
	pop	hl
	ld	bc, 8
	or	a, a
	sbc	hl, bc
	ld	c, a
	jr	nc, .LBB9_23
; %bb.20:                               ;   in Loop: Header=BB9_18 Depth=2
	ld	a, e
	cp	a, 32
	ld	a, d
	jr	z, .LBB9_22
; %bb.21:                               ;   in Loop: Header=BB9_18 Depth=2
	ld	a, c
	.local	.LBB9_22
.LBB9_22:                               ;   in Loop: Header=BB9_18 Depth=2
	lea	hl, iy + 0
	ld	bc, (ix - 27)
	add	hl, bc
	ld	e, (hl)
	inc	d
	inc	bc
	ld	(ix - 27), bc
	ld	c, a
	jr	.LBB9_18
	.local	.LBB9_23
.LBB9_23:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	a, c
	cp	a, -1
	ld	l, -1
	jr	nz, .LBB9_25
; %bb.24:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	l, 0
	.local	.LBB9_25
.LBB9_25:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	a, e
	or	a, a
	ld	a, -1
	jr	nz, .LBB9_27
; %bb.26:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	a, 0
	.local	.LBB9_27
.LBB9_27:                               ;   in Loop: Header=BB9_15 Depth=1
	and	a, l
	ld	l, a
	bit	0, l
	jr	nz, .LBB9_29
; %bb.28:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	c, d
	.local	.LBB9_29
.LBB9_29:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	a, c
	cp	a, 23
	jr	c, .LBB9_31
; %bb.30:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	c, 23
	.local	.LBB9_31
.LBB9_31:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	(ix - 27), c
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	(ix - 33), hl
	push	hl
	ld	(ix - 30), iy
	push	iy
	ld	hl, (ix - 51)
	push	hl
	call	_memcpy
	ld	bc, (ix - 33)
	ld	e, (ix - 27)                    ; 1-byte Folded Reload
	ld	iy, (ix - 51)
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB9_32
.LBB9_32:                               ;   Parent Loop BB9_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lea	hl, iy + 0
	add	hl, bc
	ld	(hl), 0
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	(ix - 27), hl
	ld	a, e
	or	a, a
	jr	z, .LBB9_34
; %bb.33:                               ;   in Loop: Header=BB9_32 Depth=2
	ld	iy, (ix - 51)
	ld	bc, (ix - 27)
	add	iy, bc
	ld	l, e
	dec	l
	dec	e
	ld	bc, 0
	ld	c, e
	ld	a, (iy - 1)
	ld	iy, (ix - 51)
	cp	a, 32
	ld	e, l
	jr	z, .LBB9_32
	.local	.LBB9_34
.LBB9_34:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	hl, (ix - 43)
	ld	bc, 9
	call	__imulu
	ld	de, 8
	add	hl, de
	push	hl
	ld	hl, 4
	push	hl
	push	iy
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 30)
	ld	de, (ix - 27)
	add	iy, de
	dec	iy
	.local	.LBB9_35
.LBB9_35:                               ;   Parent Loop BB9_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	e, (iy + 1)
	inc	iy
	ld	a, e
	cp	a, 32
	jr	z, .LBB9_35
; %bb.36:                               ;   in Loop: Header=BB9_15 Depth=1
	ld	hl, (ix - 43)
	inc	hl
	ld	(ix - 43), hl
	jp	.LBB9_15
	.local	.LBB9_37
.LBB9_37:
	ld	hl, 23
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 62
	push	hl
	ld	hl, 5
	push	hl
	ld	hl, _.str.49
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 73
	push	hl
	ld	hl, 5
	push	hl
	ld	hl, _.str.1.50
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, _solution_len
	ld	hl, (hl)
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jr	z, .LBB9_39
; %bb.38:
	ld	hl, 104
	push	hl
	ld	hl, 5
	push	hl
	ld	hl, _.str.2.51
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 115
	push	hl
	ld	hl, 5
	push	hl
	ld	hl, _.str.3.52
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB9_39
.LBB9_39:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end9
.Lfunc_end9:
	.size	_render_game_frame_offset, .Lfunc_end9-_render_game_frame_offset
                                        ; -- End function
	.section	.text._tile_size,"ax",@progbits
	.type	_tile_size,@function            ; -- Begin function tile_size
_tile_size:                             ; @tile_size
; %bb.0:
	ld	b, -6
	ld	e, -18
	ld	a, (_level_w)
	ld	c, a
	call	__bdivu
	ld	l, a
	ld	a, (_level_h)
	ld	b, e
	ld	c, a
	call	__bdivu
	ld	e, a
	ld	a, l
	cp	a, e
	jr	c, .LBB10_2
; %bb.1:
	ld	l, e
	.local	.LBB10_2
.LBB10_2:
	ld	a, l
	cp	a, 17
	jr	c, .LBB10_4
; %bb.3:
	ld	l, 17
	.local	.LBB10_4
.LBB10_4:
	ld	a, l
	cp	a, 9
	jr	nc, .LBB10_6
; %bb.5:
	ld	l, 8
	.local	.LBB10_6
.LBB10_6:
	ld	a, l
	ret
	.local	.Lfunc_end10
.Lfunc_end10:
	.size	_tile_size, .Lfunc_end10-_tile_size
                                        ; -- End function
	.section	.text._draw_raw_tile,"ax",@progbits
	.type	_draw_raw_tile,@function        ; -- Begin function draw_raw_tile
_draw_raw_tile:                         ; @draw_raw_tile
; %bb.0:
	ld	hl, -26
	call	__frameset
	ld	de, (ix + 6)
	ld	bc, (ix + 9)
	ld	iy, (ix + 12)
	ld	h, (ix + 15)
	ld	a, h
	dec	a
	cp	a, 3
	jr	nc, .LBB11_3
	.local	.LBB11_1
.LBB11_1:                               ; %tile_color.exit
	ld	l, h
	.local	.LBB11_2
.LBB11_2:
	push	hl
	push	iy
	push	bc
	push	de
	call	_draw_cell
	jp	.LBB11_11
	.local	.LBB11_3
.LBB11_3:
	ld	a, h
	cp	a, 4
	jp	nz, .LBB11_17
; %bb.4:
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	lea	hl, iy + 0
	jp	p, .LBB11_6
; %bb.5:
	ld	hl, 1
	.local	.LBB11_6
.LBB11_6:
	ld	(ix - 5), hl
	ld	hl, 1
	push	hl
	push	iy
	push	bc
	ld	hl, (ix + 6)
	push	hl
	call	_draw_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 5)
	call	__ishru_1
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	ld	(ix - 11), iy
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 8), hl
	ld	hl, (ix - 5)
	ld	bc, 28
	call	__imulu
	ld	de, 42
	add	hl, de
	ld	iy, 85
	lea	bc, iy + 0
	call	__idivu
	ex	de, hl
	ld	hl, (ix - 5)
	ld	bc, 24
	call	__imulu
	ld	bc, 42
	add	hl, bc
	lea	bc, iy + 0
	call	__idivu
	push	hl
	pop	iy
	push	de
	pop	hl
	ld	bc, 3
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB11_8
; %bb.7:
	ld	de, 2
	.local	.LBB11_8
.LBB11_8:
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB11_10
; %bb.9:
	ld	iy, 1
	.local	.LBB11_10
.LBB11_10:
	ld	(ix - 5), iy
	ld	hl, 4
	push	hl
	push	de
	push	de
	ld	hl, (ix - 8)
	push	hl
	ld	hl, (ix - 11)
	push	hl
	call	_draw_filled_ellipse
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 7
	push	hl
	ld	hl, (ix - 5)
	push	hl
	push	hl
	ld	hl, (ix - 8)
	push	hl
	ld	hl, (ix - 11)
	push	hl
	call	_draw_filled_ellipse
	pop	hl
	.local	.LBB11_11
.LBB11_11:
	pop	hl
	.local	.LBB11_12
.LBB11_12:
	pop	hl
	pop	hl
	pop	hl
	bit	0, (ix + 18)
	jr	z, .LBB11_16
; %bb.13:
	ld	hl, 25
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, 2
	ld	bc, (ix + 12)
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB11_15
; %bb.14:
	ld	bc, 1
	.local	.LBB11_15
.LBB11_15:
	dec	bc
	push	bc
	push	bc
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB11_16
.LBB11_16:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB11_17
.LBB11_17:
	ld	a, h
	cp	a, 12
	jp	z, .LBB11_1
; %bb.18:
	ld	l, -5
	ld	a, h
	add	a, l
	ld	l, a
	cp	a, 5
	jp	nc, .LBB11_32
; %bb.19:
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	lea	hl, iy + 0
	jp	p, .LBB11_21
; %bb.20:
	ld	hl, 1
	.local	.LBB11_21
.LBB11_21:
	ld	(ix - 5), hl
	add	hl, hl
	add	hl, hl
	ld	de, 42
	add	hl, de
	ld	bc, 85
	call	__idivu
	ld	(ix - 8), hl
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	nc, .LBB11_23
; %bb.22:
	ld	hl, 1
	ld	(ix - 8), hl
	.local	.LBB11_23
.LBB11_23:
	ld	hl, 5
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 5)
	push	hl
	push	hl
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_gfx_FillRectangle
	ld	de, (ix - 5)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 8)
	add	hl, hl
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	jr	nc, .LBB11_25
; %bb.24:
	ld	hl, 6
	push	hl
	ld	(ix - 11), bc
	call	_gfx_SetColor
	pop	hl
	ld	iy, (ix - 8)
	lea	hl, iy + 0
	ld	de, (ix + 6)
	add	hl, de
	push	hl
	pop	bc
	ld	de, (ix + 9)
	add	iy, de
	ld	hl, (ix - 5)
	ld	de, (ix - 11)
	or	a, a
	sbc	hl, de
	push	hl
	push	hl
	push	iy
	push	bc
	call	_gfx_FillRectangle
	ld	de, (ix - 5)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB11_25
.LBB11_25:
	ex	de, hl
	ld	bc, 33
	call	__imulu
	ld	de, 42
	add	hl, de
	ld	de, 85
	push	de
	pop	bc
	call	__idivu
	push	hl
	pop	iy
	ld	hl, (ix - 5)
	ld	bc, 29
	call	__imulu
	ld	bc, 42
	add	hl, bc
	push	de
	pop	bc
	call	__idivu
	ex	de, hl
	ld	(ix - 11), iy
	lea	hl, iy + 0
	ld	bc, 3
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB11_27
; %bb.26:
	ld	hl, 2
	ld	(ix - 11), hl
	.local	.LBB11_27
.LBB11_27:
	push	de
	pop	hl
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	push	de
	pop	iy
	ld	bc, (ix + 9)
	jr	nc, .LBB11_29
; %bb.28:
	ld	hl, 1
	push	hl
	pop	iy
	.local	.LBB11_29
.LBB11_29:
	ex	de, hl
	ld	de, (ix - 11)
	or	a, a
	sbc	hl, de
	jr	c, .LBB11_31
; %bb.30:
	push	de
	pop	iy
	dec	iy
	.local	.LBB11_31
.LBB11_31:
	ld	(ix - 14), iy
	ld	hl, (ix - 5)
	call	__ishru_1
	push	hl
	pop	iy
	add	iy, bc
	ld	(ix - 5), iy
	push	de
	pop	bc
	ld	de, (ix + 6)
	add	hl, de
	ld	(ix - 8), hl
	ld	de, 4
	push	de
	push	bc
	push	bc
	push	iy
	push	hl
	call	_draw_filled_ellipse
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 7
	push	hl
	ld	hl, (ix - 14)
	push	hl
	push	hl
	ld	hl, (ix - 5)
	push	hl
	ld	hl, (ix - 8)
	push	hl
	call	_draw_filled_ellipse
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	a, (ix + 15)
	ld	l, 44
	add	a, l
	ld	l, a
	ld	(ix - 2), l
	ld	(ix - 1), 0
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 15
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -2
	ld	iy, (ix - 8)
	add	iy, de
	ld	de, -4
	ld	hl, (ix - 5)
	add	hl, de
	push	hl
	push	iy
	pea	ix - 2
	call	_gfx_PrintStringXY
	jp	.LBB11_12
	.local	.LBB11_32
.LBB11_32:
	ld	a, h
	cp	a, 22
	jp	nc, .LBB11_41
; %bb.33:
	ld	hl, 1
	ld	c, (ix + 15)
	call	__ishl
	ld	bc, 3148800
	call	__iand
	ld	bc, (ix + 9)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	h, (ix + 15)
	jp	z, .LBB11_41
; %bb.34:
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB11_36
; %bb.35:
	ld	iy, 1
	.local	.LBB11_36
.LBB11_36:
	lea	hl, iy + 0
	add	hl, hl
	ld	bc, 42
	add	hl, bc
	ld	bc, 85
	call	__idivu
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	jr	nc, .LBB11_38
; %bb.37:
	ld	bc, 1
	.local	.LBB11_38
.LBB11_38:
	ld	(ix - 11), bc
	push	bc
	pop	hl
	add	hl, hl
	ex	de, hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ld	(ix - 8), hl
	or	a, a
	sbc	hl, hl
	push	hl
	ld	(ix - 5), iy
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 5)
	push	hl
	push	hl
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 8)
	ld	de, 1
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	m, .LBB11_58
; %bb.39:
	ld	l, -10
	ld	a, (ix + 15)
	add	a, l
	ld	l, a
	cp	a, 12
	jp	nc, .LBB11_56
; %bb.40:                               ; %switch.lookup
	ld	iy, _switch.table.draw_raw_tile
	ld	de, 0
	ld	e, l
	add	iy, de
	ld	a, (iy)
	ld	l, a
	jp	.LBB11_57
	.local	.LBB11_41
.LBB11_41:
	ld	l, -13
	ld	a, h
	add	a, l
	ld	l, a
	cp	a, 2
	jr	nc, .LBB11_43
; %bb.42:
	ld	l, h
	push	hl
	push	iy
	push	bc
	push	de
	call	_draw_block
	jp	.LBB11_11
	.local	.LBB11_43
.LBB11_43:
	ld	a, h
	cp	a, 15
	jr	nz, .LBB11_47
; %bb.44:
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	lea	hl, iy + 0
	jp	p, .LBB11_46
; %bb.45:
	ld	hl, 1
	.local	.LBB11_46
.LBB11_46:
	ld	(ix - 5), hl
	ld	hl, 1
	push	hl
	push	iy
	push	bc
	ld	hl, (ix + 6)
	push	hl
	call	_draw_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 5)
	call	__ishru_1
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	ld	de, (ix + 9)
	add	hl, de
	ld	de, (ix + 12)
	push	de
	push	hl
	push	iy
	call	_draw_ball_at
	jp	.LBB11_12
	.local	.LBB11_47
.LBB11_47:
	ld	l, -4
	ld	a, h
	and	a, l
	ld	l, a
	cp	a, 16
	jp	nz, .LBB11_55
; %bb.48:
	ld	de, 2
	lea	bc, iy + 0
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	push	bc
	pop	hl
	jp	p, .LBB11_50
; %bb.49:
	ld	hl, 1
	.local	.LBB11_50
.LBB11_50:
	ld	(ix - 11), hl
	add	hl, hl
	ld	bc, 42
	add	hl, bc
	ld	bc, 85
	call	__idivu
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	jr	nc, .LBB11_52
; %bb.51:
	ld	hl, 1
	push	hl
	pop	bc
	.local	.LBB11_52
.LBB11_52:
	ld	(ix - 17), bc
	ld	hl, (ix - 11)
	or	a, a
	sbc	hl, bc
	ld	(ix - 5), hl
	ld	hl, 1
	push	hl
	push	iy
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_draw_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 16
	push	hl
	call	_gfx_SetColor
	ld	bc, (ix - 17)
	ld	de, (ix + 6)
	pop	hl
	push	bc
	pop	hl
	add	hl, de
	ld	a, (ix + 15)
	cp	a, 16
	ld	iy, (ix - 5)
	ld	(ix - 14), hl
	jp	nz, .LBB11_59
; %bb.53:
	ld	de, (ix + 9)
	add	iy, de
	lea	de, iy + 0
	push	bc
	pop	iy
	ld	bc, (ix + 6)
	ld	hl, (ix - 5)
	add	hl, bc
	ld	bc, (ix + 9)
	add	iy, bc
	push	de
	push	hl
	push	iy
	.local	.LBB11_54
.LBB11_54:
	push	hl
	push	de
	ld	hl, (ix - 14)
	jp	.LBB11_65
	.local	.LBB11_55
.LBB11_55:
	ld	hl, 1
	jp	.LBB11_2
	.local	.LBB11_56
.LBB11_56:
	ld	hl, 1
	.local	.LBB11_57
.LBB11_57:                              ; %tile_color.exit4
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 11)
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	ld	de, (ix + 9)
	add	hl, de
	ld	de, (ix - 8)
	push	de
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB11_58
.LBB11_58:
	ld	de, (ix - 5)
	push	de
	pop	hl
	call	__ishru_1
	push	hl
	pop	bc
	ld	(ix - 8), bc
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	call	__ishrs_1
	ld	(ix - 5), hl
	ld	hl, 22
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 5)
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	ld	de, (ix + 9)
	add	hl, de
	ld	de, (ix - 8)
	push	de
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	jp	.LBB11_11
	.local	.LBB11_59
.LBB11_59:
	push	bc
	pop	hl
	ld	bc, (ix + 9)
	add	hl, bc
	cp	a, 17
	jr	nz, .LBB11_61
; %bb.60:
	ex	de, hl
	ld	iy, (ix - 5)
	lea	hl, iy + 0
	add	hl, bc
	ld	bc, (ix + 6)
	add	iy, bc
	push	hl
	push	iy
	push	hl
	ld	hl, (ix - 14)
	push	hl
	jr	.LBB11_64
	.local	.LBB11_61
.LBB11_61:
	ld	(ix - 8), hl
	cp	a, 18
	ld	hl, (ix - 5)
	push	hl
	pop	iy
	jr	nz, .LBB11_63
; %bb.62:
	add	hl, de
	add	iy, bc
	push	iy
	push	hl
	ld	de, (ix - 8)
	push	de
	jp	.LBB11_54
	.local	.LBB11_63
.LBB11_63:
	add	iy, de
	add	hl, bc
	push	hl
	ld	hl, (ix - 14)
	push	hl
	ld	de, (ix - 8)
	push	de
	push	iy
	.local	.LBB11_64
.LBB11_64:
	push	de
	.local	.LBB11_65
.LBB11_65:
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 11)
	lea	hl, iy + 0
	ld	de, 3
	add	hl, de
	ld	a, 2
	ld	c, a
	call	__ishru
	ld	(ix - 8), hl
	lea	hl, iy + 0
	push	de
	pop	bc
	call	__imulu
	inc	hl
	ld	c, a
	call	__ishru
	ld	(ix - 11), hl
	ld	hl, 18
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	a, (ix + 15)
	cp	a, 16
	jp	nz, .LBB11_68
; %bb.66:
	ld	hl, (ix - 5)
	ld	de, (ix + 6)
	add	hl, de
	ld	(ix - 20), hl
	ld	iy, (ix - 8)
	ld	hl, (ix + 9)
	ex	de, hl
	add	iy, de
	lea	de, iy + 0
	ld	(ix - 26), de
	ld	iy, (ix - 11)
	lea	hl, iy + 0
	ld	bc, (ix + 6)
	add	hl, bc
	ld	(ix - 23), hl
	ld	bc, (ix + 9)
	add	iy, bc
	ld	(ix - 11), iy
	ld	hl, (ix - 8)
	ld	bc, (ix + 6)
	add	hl, bc
	ld	(ix - 8), hl
	ld	iy, (ix - 5)
	ld	bc, (ix + 9)
	add	iy, bc
	ld	(ix - 5), iy
	ld	bc, (ix - 5)
	push	bc
	push	hl
	ld	hl, (ix - 11)
	push	hl
	ld	hl, (ix - 23)
	push	hl
	push	de
	ld	hl, (ix - 20)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 5)
	push	hl
	ld	de, (ix - 20)
	push	de
	push	hl
	ld	hl, (ix - 8)
	push	hl
	ld	hl, (ix - 26)
	push	hl
	push	de
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, (ix - 20)
	ld	iy, (ix - 5)
	ld	hl, (ix - 17)
	ld	bc, (ix + 9)
	add	hl, bc
	ld	(ix - 8), hl
	.local	.LBB11_67
.LBB11_67:
	ld	hl, (ix - 8)
	push	hl
	push	de
	push	iy
	jp	.LBB11_73
	.local	.LBB11_68
.LBB11_68:
	ld	iy, (ix - 11)
	cp	a, 17
	ld	bc, (ix - 5)
	jr	nz, .LBB11_70
; %bb.69:
	ld	de, (ix + 6)
	add	iy, de
	ld	(ix - 23), iy
	push	bc
	pop	hl
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 20), hl
	ld	hl, (ix - 8)
	push	hl
	pop	iy
	ld	bc, (ix + 6)
	add	iy, bc
	lea	bc, iy + 0
	ld	iy, (ix - 11)
	add	iy, de
	add	hl, de
	ld	(ix - 8), hl
	push	hl
	ld	hl, (ix - 14)
	push	hl
	push	iy
	push	bc
	ld	hl, (ix - 20)
	push	hl
	ld	hl, (ix - 23)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 20)
	push	hl
	ld	de, (ix - 14)
	push	de
	ld	bc, (ix - 8)
	push	bc
	push	de
	push	hl
	ld	hl, (ix - 23)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 17)
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 17), hl
	ld	hl, (ix - 5)
	ld	de, (ix + 6)
	add	hl, de
	jp	.LBB11_72
	.local	.LBB11_70
.LBB11_70:
	cp	a, 18
	ld	de, (ix - 8)
	jp	nz, .LBB11_74
; %bb.71:
	ld	hl, (ix - 8)
	ld	de, (ix + 6)
	add	hl, de
	ld	(ix - 20), hl
	ld	hl, (ix - 17)
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 17), hl
	lea	de, iy + 0
	push	de
	pop	hl
	ld	bc, (ix + 6)
	add	hl, bc
	ld	(ix - 26), hl
	ld	hl, (ix - 8)
	ld	bc, (ix + 9)
	add	hl, bc
	ld	(ix - 8), hl
	ld	iy, (ix - 5)
	ld	bc, (ix + 6)
	add	iy, bc
	ld	(ix - 23), iy
	ex	de, hl
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 11), hl
	push	hl
	push	iy
	ld	hl, (ix - 8)
	push	hl
	ld	hl, (ix - 26)
	push	hl
	ld	hl, (ix - 17)
	push	hl
	ld	hl, (ix - 20)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 17)
	push	de
	ld	hl, (ix - 23)
	push	hl
	ld	bc, (ix - 11)
	push	bc
	push	hl
	push	de
	ld	hl, (ix - 20)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 5)
	ld	de, (ix + 9)
	add	hl, de
	ld	(ix - 20), hl
	ld	hl, (ix - 23)
	.local	.LBB11_72
.LBB11_72:
	ld	(ix - 5), hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 20)
	push	hl
	ld	hl, (ix - 5)
	push	hl
	ld	hl, (ix - 17)
	push	hl
	.local	.LBB11_73
.LBB11_73:
	ld	hl, (ix - 14)
	push	hl
	call	_gfx_Line
	jp	.LBB11_11
	.local	.LBB11_74
.LBB11_74:
	ld	bc, (ix + 9)
	add	iy, bc
	ld	(ix - 20), iy
	ex	de, hl
	push	hl
	pop	iy
	ld	de, (ix + 6)
	add	iy, de
	ld	(ix - 23), iy
	add	hl, bc
	ex	de, hl
	ld	hl, (ix - 11)
	ld	bc, (ix + 6)
	add	hl, bc
	ld	(ix - 11), hl
	ld	iy, (ix - 17)
	ld	bc, (ix + 9)
	add	iy, bc
	ld	(ix - 8), iy
	ld	bc, (ix - 8)
	push	bc
	push	hl
	push	de
	ld	hl, (ix - 23)
	push	hl
	ld	hl, (ix - 20)
	push	hl
	ld	hl, (ix - 14)
	push	hl
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 8)
	push	hl
	ld	de, (ix - 14)
	push	de
	push	hl
	ld	hl, (ix - 11)
	push	hl
	ld	hl, (ix - 20)
	push	hl
	push	de
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 5)
	push	hl
	pop	iy
	ld	de, (ix + 9)
	add	iy, de
	ld	de, (ix + 6)
	add	hl, de
	ex	de, hl
	jp	.LBB11_67
	.local	.Lfunc_end11
.Lfunc_end11:
	.size	_draw_raw_tile, .Lfunc_end11-_draw_raw_tile
                                        ; -- End function
	.section	.text._draw_cell,"ax",@progbits
	.type	_draw_cell,@function            ; -- Begin function draw_cell
_draw_cell:                             ; @draw_cell
; %bb.0:
	ld	hl, -9
	call	__frameset
	ld	iy, (ix + 12)
	ld	bc, 42
	ld	de, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB12_2
; %bb.1:
	ld	iy, 1
	.local	.LBB12_2
.LBB12_2:
	ld	(ix - 3), iy
	add	iy, iy
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, 85
	call	__idivu
	ld	(ix - 6), hl
	or	a, a
	sbc	hl, de
	jr	nc, .LBB12_4
; %bb.3:
	ld	hl, 1
	ld	(ix - 6), hl
	.local	.LBB12_4
.LBB12_4:
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 3)
	push	hl
	push	hl
	ld	hl, (ix + 9)
	push	hl
	ld	hl, (ix + 6)
	push	hl
	call	_gfx_FillRectangle
	ld	de, (ix - 3)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 6)
	add	hl, hl
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	jr	nc, .LBB12_6
; %bb.5:
	ld	a, (ix + 15)
	ld	l, a
	push	hl
	ld	(ix - 9), bc
	call	_gfx_SetColor
	pop	hl
	ld	iy, (ix - 6)
	lea	hl, iy + 0
	ld	de, (ix + 6)
	add	hl, de
	push	hl
	pop	bc
	ld	de, (ix + 9)
	add	iy, de
	ld	hl, (ix - 3)
	ld	de, (ix - 9)
	or	a, a
	sbc	hl, de
	push	hl
	push	hl
	push	iy
	push	bc
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB12_6
.LBB12_6:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end12
.Lfunc_end12:
	.size	_draw_cell, .Lfunc_end12-_draw_cell
                                        ; -- End function
	.section	.text._draw_filled_ellipse,"ax",@progbits
	.type	_draw_filled_ellipse,@function  ; -- Begin function draw_filled_ellipse
_draw_filled_ellipse:                   ; @draw_filled_ellipse
; %bb.0:
	ld	hl, -26
	call	__frameset
	ld	hl, (ix + 12)
	ld	bc, (ix + 15)
	ld	iy, 1
	ld	de, 2
	ld	(ix - 9), hl
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB13_2
; %bb.1:
	ld	(ix - 9), iy
	.local	.LBB13_2
.LBB13_2:
	ld	a, (ix + 18)
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB13_4
; %bb.3:
	lea	bc, iy + 0
	.local	.LBB13_4
.LBB13_4:
	ld	(ix - 12), bc
	ld	l, a
	push	hl
	call	_gfx_SetColor
	ld	iy, (ix - 12)
	pop	hl
	lea	hl, iy + 0
	call	__ineg
	ld	(ix - 6), hl
	or	a, a
	sbc	hl, hl
	ld	a, l
	inc	iy
	ld	bc, (ix - 9)
	push	bc
	pop	hl
	ld	e, a
	ld	(ix - 13), a                    ; 1-byte Folded Spill
	call	__lmulu
	lea	bc, iy + 0
	ld	(ix - 19), hl
	ld	(ix - 20), e                    ; 1-byte Folded Spill
	ld	iy, (ix - 6)
	.local	.LBB13_5
.LBB13_5:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_7 Depth 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	push	bc
	pop	hl
	jp	z, .LBB13_11
; %bb.6:                                ;   in Loop: Header=BB13_5 Depth=1
	ld	(ix - 16), hl
	ld	(ix - 3), iy
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	d, a
	lea	hl, iy + 0
	ld	e, d
	ld	bc, (ix - 12)
	ld	a, (ix - 13)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 23), hl
	ld	(ix - 26), e                    ; 1-byte Folded Spill
	push	bc
	pop	hl
	ld	e, a
	ld	(ix - 6), iy
	lea	bc, iy + 0
	ld	a, d
	call	__lsub
	push	hl
	pop	iy
	ld	d, e
	ld	hl, (ix - 19)
	ld	e, (ix - 20)                    ; 1-byte Folded Reload
	ld	bc, (ix - 23)
	ld	a, (ix - 26)                    ; 1-byte Folded Reload
	call	__lmulu
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	ld	(ix - 23), hl
	ld	d, e
	ld	iy, 0
	.local	.LBB13_7
.LBB13_7:                               ;   Parent Loop BB13_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lea	bc, iy + 0
	ld	iy, (ix - 9)
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	z, .LBB13_10
; %bb.8:                                ;   in Loop: Header=BB13_7 Depth=2
	push	bc
	pop	iy
	inc	iy
	ld	(ix - 26), bc
	inc	bc
	push	bc
	pop	hl
	ld	a, (ix - 13)                    ; 1-byte Folded Reload
	ld	e, a
	ld	bc, (ix - 12)
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	hl, (ix - 23)
	ld	e, d
	call	__lcmps
	call	pe, __setflag
	jp	p, .LBB13_7
; %bb.9:                                ; %._crit_edge
                                        ;   in Loop: Header=BB13_5 Depth=1
	ld	iy, (ix - 26)
	.local	.LBB13_10
.LBB13_10:                              ;   in Loop: Header=BB13_5 Depth=1
	lea	de, iy + 0
	ld	hl, (ix + 6)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	hl, (ix - 6)
	ld	bc, (ix + 9)
	add	hl, bc
	add	iy, iy
	inc	iy
	push	iy
	push	hl
	push	de
	call	_gfx_HorizLine
	ld	iy, (ix - 6)
	pop	hl
	pop	hl
	pop	hl
	inc	iy
	ld	bc, (ix - 16)
	jp	.LBB13_5
	.local	.LBB13_11
.LBB13_11:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end13
.Lfunc_end13:
	.size	_draw_filled_ellipse, .Lfunc_end13-_draw_filled_ellipse
                                        ; -- End function
	.section	.text._main,"ax",@progbits
	.globl	_main                           ; -- Begin function main
	.type	_main,@function
_main:                                  ; @main
; %bb.0:
	ld	hl, -272
	call	__frameset
	ld	de, -202
	lea	iy, ix + 0
	add	iy, de
	ld	l, -3
	push	ix
	lea	ix, ix - 128
	ld	(ix - 94), l
	ld	(ix - 93), h
	pop	ix
	ld	de, -272
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	lea	hl, iy + 0
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	call	_gfx_Begin
	ld	hl, 1
	push	hl
	call	_gfx_SetDraw
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	ld	hl, 64
	push	hl
	ld	hl, _palette
	push	hl
	call	_gfx_SetPalette
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 31
	push	hl
	call	_gfx_SetTransparentColor
	pop	hl
	ld	hl, 31
	push	hl
	call	_gfx_SetTextTransparentColor
	pop	hl
	ld	hl, 31
	push	hl
	call	_gfx_SetTextBGColor
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	.local	.LBB14_1
.LBB14_1:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB14_2 Depth 2
                                        ;       Child Loop BB14_3 Depth 3
                                        ;         Child Loop BB14_4 Depth 4
                                        ;     Child Loop BB14_113 Depth 2
                                        ;     Child Loop BB14_121 Depth 2
                                        ;     Child Loop BB14_130 Depth 2
                                        ;       Child Loop BB14_131 Depth 3
                                        ;         Child Loop BB14_147 Depth 4
                                        ;     Child Loop BB14_20 Depth 2
                                        ;       Child Loop BB14_26 Depth 3
                                        ;         Child Loop BB14_28 Depth 4
                                        ;           Child Loop BB14_33 Depth 5
                                        ;           Child Loop BB14_49 Depth 5
                                        ;             Child Loop BB14_52 Depth 6
                                        ;             Child Loop BB14_66 Depth 6
                                        ;             Child Loop BB14_69 Depth 6
	xor	a, a
	ld	de, -208
	.local	.LBB14_2
.LBB14_2:                               ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB14_3 Depth 3
                                        ;         Child Loop BB14_4 Depth 4
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	call	_wait_release
	or	a, a
	sbc	hl, hl
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	ld	bc, 28
	call	__imulu
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	.local	.LBB14_3
.LBB14_3:                               ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_2 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB14_4 Depth 4
	call	_draw_grid_background
	ld	hl, 31
	push	hl
	call	_gfx_SetTransparentColor
	pop	hl
	ld	hl, 20
	push	hl
	ld	hl, 66
	push	hl
	ld	hl, _cyber_logo
	push	hl
	call	_gfx_TransparentSprite
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 98
	push	hl
	ld	hl, 63
	push	hl
	ld	hl, _.str.8.53
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, ___const.main_menu.items
	push	hl
	pop	iy
	or	a, a
	sbc	hl, hl
	.local	.LBB14_4
.LBB14_4:                               ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_2 Depth=2
                                        ;       Parent Loop BB14_3 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	push	hl
	pop	bc
	ld	de, 84
	or	a, a
	sbc	hl, de
	jp	z, .LBB14_12
; %bb.5:                                ;   in Loop: Header=BB14_4 Depth=4
	push	bc
	pop	hl
	ld	de, 132
	add	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 86), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 92)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	a, -1
	jr	z, .LBB14_7
; %bb.6:                                ;   in Loop: Header=BB14_4 Depth=4
	ld	a, 0
	.local	.LBB14_7
.LBB14_7:                               ;   in Loop: Header=BB14_4 Depth=4
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	de, -205
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	de, -217
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	bit	0, a
	ld	a, 2
	ld	l, a
	jr	nz, .LBB14_9
; %bb.8:                                ;   in Loop: Header=BB14_4 Depth=4
	ld	a, 24
	ld	l, a
	.local	.LBB14_9
.LBB14_9:                               ;   in Loop: Header=BB14_4 Depth=4
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 22
	push	hl
	ld	hl, 196
	push	hl
	ld	de, -214
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	ld	hl, 62
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, -217
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, 0
	ld	l, a
	jr	nz, .LBB14_11
; %bb.10:                               ;   in Loop: Header=BB14_4 Depth=4
	ld	a, 22
	ld	l, a
	.local	.LBB14_11
.LBB14_11:                              ;   in Loop: Header=BB14_4 Depth=4
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, (hl)
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	ld	bc, 139
	add	hl, bc
	push	hl
	ld	hl, 80
	push	hl
	push	de
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	de, 28
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 77)
	pop	ix
	lea	iy, iy + 3
	jp	.LBB14_4
	.local	.LBB14_12
.LBB14_12:                              ;   in Loop: Header=BB14_3 Depth=3
	ld	hl, 23
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 222
	push	hl
	ld	hl, 101
	push	hl
	ld	hl, _.str.7.54
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	call	_kb_Scan
	ld	hl, -720866
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	iy, -720868
	ld	e, (iy)
	ld	d, (iy + 1)
	ld	a, l
	bit	3, a
	jr	nz, .LBB14_16
; %bb.13:                               ;   in Loop: Header=BB14_3 Depth=3
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jr	nz, .LBB14_17
; %bb.14:                               ;   in Loop: Header=BB14_3 Depth=3
	ld	l, e
	ld	h, d
	call	__sand
	bit	0, l
	jr	nz, .LBB14_19
; %bb.15:                               ;   in Loop: Header=BB14_3 Depth=3
	ld	a, e
	bit	6, a
	jp	z, .LBB14_3
	jp	.LBB14_195
	.local	.LBB14_16
.LBB14_16:                              ;   in Loop: Header=BB14_2 Depth=2
	ld	l, 2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	add	a, l
	ld	l, a
	ld	c, 3
	call	__bremu
	jp	.LBB14_2
	.local	.LBB14_17
.LBB14_17:                              ;   in Loop: Header=BB14_2 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	inc	l
	ld	a, l
	cp	a, 3
	ld	a, 0
	jp	z, .LBB14_2
; %bb.18:                               ;   in Loop: Header=BB14_2 Depth=2
	ld	a, l
	jp	.LBB14_2
	.local	.LBB14_19
.LBB14_19:                              ;   in Loop: Header=BB14_1 Depth=1
	call	_wait_release
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, l
	or	a, a
	jp	nz, .LBB14_111
	.local	.LBB14_20
.LBB14_20:                              ; %.preheader29
                                        ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB14_26 Depth 3
                                        ;         Child Loop BB14_28 Depth 4
                                        ;           Child Loop BB14_33 Depth 5
                                        ;           Child Loop BB14_49 Depth 5
                                        ;             Child Loop BB14_52 Depth 6
                                        ;             Child Loop BB14_66 Depth 6
                                        ;             Child Loop BB14_69 Depth 6
	ld	a, (_choose_builtin.sel)
	ld	e, a
	cp	a, 49
	jr	c, .LBB14_22
; %bb.21:                               ;   in Loop: Header=BB14_20 Depth=2
	xor	a, a
	ld	(_choose_builtin.sel), a
	ld	e, a
	.local	.LBB14_22
.LBB14_22:                              ;   in Loop: Header=BB14_20 Depth=2
	ld	a, (_choose_builtin.view_start)
	ld	l, a
	ld	iy, 0
	ex	de, hl
	ld	iyl, e
	ex	de, hl
	ld	bc, 6
	add	iy, bc
	ld	a, e
	cp	a, l
	jr	c, .LBB14_24
; %bb.23:                               ;   in Loop: Header=BB14_20 Depth=2
	or	a, a
	sbc	hl, hl
	ld	l, e
	lea	bc, iy + 0
	sbc	hl, bc
	jr	c, .LBB14_25
	.local	.LBB14_24
.LBB14_24:                              ;   in Loop: Header=BB14_20 Depth=2
	ld	a, e
	ld	c, 3
	call	__bremu
	ld	l, a
	ld	a, e
	sub	a, l
	ld	l, a
	ld	(_choose_builtin.view_start), a
	.local	.LBB14_25
.LBB14_25:                              ;   in Loop: Header=BB14_20 Depth=2
	call	_wait_release
	ld	l, 1
	ld	de, 0
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	bc, -208
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	.local	.LBB14_26
.LBB14_26:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB14_28 Depth 4
                                        ;           Child Loop BB14_33 Depth 5
                                        ;           Child Loop BB14_49 Depth 5
                                        ;             Child Loop BB14_52 Depth 6
                                        ;             Child Loop BB14_66 Depth 6
                                        ;             Child Loop BB14_69 Depth 6
	bit	0, l
	jp	z, .LBB14_73
; %bb.27:                               ;   in Loop: Header=BB14_26 Depth=3
	call	_draw_grid_background
	ld	hl, 2
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 6
	push	hl
	ld	hl, 8
	push	hl
	ld	hl, _.str.9.55
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	xor	a, a
	ld	b, a
	.local	.LBB14_28
.LBB14_28:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB14_33 Depth 5
                                        ;           Child Loop BB14_49 Depth 5
                                        ;             Child Loop BB14_52 Depth 6
                                        ;             Child Loop BB14_66 Depth 6
                                        ;             Child Loop BB14_69 Depth 6
	ld	a, b
	cp	a, 6
	jp	z, .LBB14_72
; %bb.29:                               ;   in Loop: Header=BB14_28 Depth=4
	ld	a, (_choose_builtin.view_start)
	add	a, b
	ld	l, a
	cp	a, 49
	jp	nc, .LBB14_72
; %bb.30:                               ;   in Loop: Header=BB14_28 Depth=4
	ld	a, l
	ld	de, -225
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	ld	iy, 0
	lea	hl, iy + 0
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 100), hl
	pop	ix
	ld	c, 3
	call	__bdivu
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 94)
	ld	d, (ix - 93)
	pop	ix
	ld	d, a
	ld	l, e
	ld	h, d
	mlt	hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 115), b                   ; 1-byte Folded Spill
	pop	ix
	ld	a, l
	add	a, b
	ld	c, a
	lea	hl, iy + 0
	ld	l, c
	push	ix
	lea	ix, ix - 128
	ld	(ix - 94), e
	ld	(ix - 93), d
	pop	ix
	ld	iyl, d
	ld	bc, 105
	call	__imulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 89), hl
	pop	ix
	ld	bc, 5
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	lea	hl, iy + 0
	ld	bc, 103
	call	__imulu
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, 31
	add	hl, de
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -228
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	hl, _builtin_levels
	add	hl, de
	ld	de, -228
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	a, (_choose_builtin.sel)
	ld	l, a
	ld	de, -225
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, l
	ld	a, 2
	ld	l, a
	jr	z, .LBB14_32
; %bb.31:                               ;   in Loop: Header=BB14_28 Depth=4
	ld	a, 24
	ld	l, a
	.local	.LBB14_32
.LBB14_32:                              ;   in Loop: Header=BB14_28 Depth=4
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 100
	push	hl
	push	hl
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, -217
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, 7
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 92)
	pop	ix
	ld	de, 33
	add	hl, de
	ld	de, 96
	push	de
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, -228
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	hl, (iy + 5)
	ld	de, -246
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -217
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 15
	add	hl, de
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 34
	add	hl, de
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	hl, 1
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 80
	push	hl
	push	hl
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld.sis	iy, 0
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc	hl, hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	.local	.LBB14_33
.LBB14_33:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ;         Parent Loop BB14_28 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	ld	l, e
	ld	h, d
	ld.sis	bc, 14
	call	__sdivu
	ld.sis	bc, 1120
	call	__smulu
	ld	c, e
	ld	b, d
	ex.sis	de, hl
	push	ix
	lea	ix, ix - 128
	push	iy
	ex	(sp), hl
	ld	(ix - 109), l
	ld	(ix - 108), h
	pop	hl
	pop	ix
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 83)
	pop	ix
	ld	de, 196
	or	a, a
	sbc	hl, de
	jp	z, .LBB14_46
; %bb.34:                               ;   in Loop: Header=BB14_33 Depth=5
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 118)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 83)
	pop	ix
	add	hl, de
	ld	e, (hl)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 120), c
	ld	(ix - 119), b
	pop	ix
	ld	l, c
	ld	h, b
	ld.sis	bc, 14
	call	__sdivu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 123), l
	ld	(ix - 122), h
	pop	ix
	ld	l, -2
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, 3
	jr	nc, .LBB14_36
; %bb.35:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	a, l
	ld	b, 3
	call	__bshl
	ld	hl, 459522
	ld	c, a
	call	__ishru
	ld.sis	bc, 14
	jr	.LBB14_45
	.local	.LBB14_36
.LBB14_36:                              ;   in Loop: Header=BB14_33 Depth=5
	ld	l, -5
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, 5
	ld	hl, 6
	ld.sis	bc, 14
	jr	c, .LBB14_45
; %bb.37:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	l, -10
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, 6
	jr	nc, .LBB14_39
; %bb.38:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	de, 0
	ld	e, l
	ld	hl, _switch.table.main
	add	hl, de
	ld	a, (hl)
	ld	l, a
	jr	.LBB14_45
	.local	.LBB14_39
.LBB14_39:                              ;   in Loop: Header=BB14_33 Depth=5
	ld	l, -4
	ld	a, e
	and	a, l
	ld	l, a
	cp	a, 16
	ld	hl, 16
	jr	z, .LBB14_45
; %bb.40:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	a, e
	cp	a, 21
	ld	l, 21
	jr	z, .LBB14_42
; %bb.41:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	l, 1
	.local	.LBB14_42
.LBB14_42:                              ;   in Loop: Header=BB14_33 Depth=5
	ld	a, e
	cp	a, 20
	ld	a, 20
	ld	e, a
	jr	z, .LBB14_44
; %bb.43:                               ;   in Loop: Header=BB14_33 Depth=5
	ld	e, l
	.local	.LBB14_44
.LBB14_44:                              ;   in Loop: Header=BB14_33 Depth=5
	ex	de, hl
	.local	.LBB14_45
.LBB14_45:                              ;   in Loop: Header=BB14_33 Depth=5
	push	ix
	ld	de, -257
	add	ix, de
	ld	(ix + 0), hl
	pop	ix
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	call	__sdivu
	ld	de, 0
	push	de
	pop	bc
	ld	c, l
	ld	b, h
	ld	de, -260
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 103)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 126), hl
	pop	ix
	ld.sis	hl, 80
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	de, 14
	ld	c, e
	ld	b, d
	call	__sdivu
	ld	bc, 0
	ld	c, l
	ld	b, h
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 128
	lea	iy, iy - 7
	ld	(iy + 0), bc
	ld	bc, -251
	lea	iy, ix + 0
	add	iy, bc
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld.sis	bc, 255
	call	__sand
	ld.sis	bc, 80
	call	__smulu
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	c, e
	ld	b, d
	call	__sdivu
	ld	de, 0
	push	de
	pop	bc
	ld	c, l
	ld	b, h
	push	ix
	lea	ix, ix - 128
	lea	ix, ix - 128
	lea	ix, ix - 10
	ld	(ix + 0), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 106)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 123), hl
	pop	ix
	ld.sis	bc, 80
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, 14
	call	__sdivu
	ld	e, l
	ld	d, h
	ld	bc, -269
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	de, -257
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, -263
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -260
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	bc, -269
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	bc, (iy + 0)
	or	a, a
	sbc	hl, bc
	push	hl
	push	de
	ld	de, -251
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -254
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	inc	hl
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -237
	lea	hl, ix + 0
	add	hl, de
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	hl
	ld	iyl, e
	ld	iyh, d
	pop	de
	ld.sis	de, 80
	add.sis	iy, de
	ld	bc, -248
	lea	hl, ix + 0
	add	hl, bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	hl
	inc.sis	de
	jp	.LBB14_33
	.local	.LBB14_46
.LBB14_46:                              ;   in Loop: Header=BB14_28 Depth=4
	ld	de, -228
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	hl, (hl)
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	a, (_choose_builtin.sel)
	ld	l, a
	ld	de, -225
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, l
	ld	a, 3
	ld	l, a
	jr	z, .LBB14_48
; %bb.47:                               ;   in Loop: Header=BB14_28 Depth=4
	ld	a, 22
	ld	l, a
	.local	.LBB14_48
.LBB14_48:                              ;   in Loop: Header=BB14_28 Depth=4
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	e, (iy)
	or	a, a
	sbc	hl, hl
	.local	.LBB14_49
.LBB14_49:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ;         Parent Loop BB14_28 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB14_52 Depth 6
                                        ;             Child Loop BB14_66 Depth 6
                                        ;             Child Loop BB14_69 Depth 6
	push	ix
	lea	ix, ix - 128
	ld	(ix - 97), hl
	pop	ix
	ld	a, e
	or	a, a
	jp	z, .LBB14_71
; %bb.50:                               ;   in Loop: Header=BB14_49 Depth=5
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 97)
	pop	ix
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB14_71
; %bb.51:                               ; %.preheader.preheader
                                        ;   in Loop: Header=BB14_49 Depth=5
	ld	hl, 1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	ld	d, h
	ld	c, -1
	.local	.LBB14_52
.LBB14_52:                              ; %.preheader
                                        ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ;         Parent Loop BB14_28 Depth=4
                                        ;           Parent Loop BB14_49 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ld	a, e
	or	a, a
	jr	z, .LBB14_57
; %bb.53:                               ; %.preheader
                                        ;   in Loop: Header=BB14_52 Depth=6
	ld	a, c
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 83)
	pop	ix
	dec	bc
	push	bc
	pop	hl
	ld	bc, 12
	or	a, a
	sbc	hl, bc
	ld	c, a
	jr	nc, .LBB14_57
; %bb.54:                               ;   in Loop: Header=BB14_52 Depth=6
	ld	a, e
	cp	a, 32
	ld	a, d
	jr	z, .LBB14_56
; %bb.55:                               ;   in Loop: Header=BB14_52 Depth=6
	ld	a, c
	.local	.LBB14_56
.LBB14_56:                              ;   in Loop: Header=BB14_52 Depth=6
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 83)
	pop	ix
	add	hl, bc
	ld	e, (hl)
	inc	d
	inc	bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), bc
	pop	ix
	ld	c, a
	jr	.LBB14_52
	.local	.LBB14_57
.LBB14_57:                              ;   in Loop: Header=BB14_49 Depth=5
	ld	a, c
	cp	a, -1
	ld	l, -1
	jr	nz, .LBB14_59
; %bb.58:                               ;   in Loop: Header=BB14_49 Depth=5
	ld	l, 0
	.local	.LBB14_59
.LBB14_59:                              ;   in Loop: Header=BB14_49 Depth=5
	ld	a, e
	or	a, a
	ld	a, -1
	jr	nz, .LBB14_61
; %bb.60:                               ;   in Loop: Header=BB14_49 Depth=5
	ld	a, 0
	.local	.LBB14_61
.LBB14_61:                              ;   in Loop: Header=BB14_49 Depth=5
	and	a, l
	ld	l, a
	bit	0, l
	jr	nz, .LBB14_63
; %bb.62:                               ;   in Loop: Header=BB14_49 Depth=5
	ld	c, d
	.local	.LBB14_63
.LBB14_63:                              ;   in Loop: Header=BB14_49 Depth=5
	ld	a, c
	cp	a, 23
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 112)
	pop	ix
	jr	c, .LBB14_65
; %bb.64:                               ;   in Loop: Header=BB14_49 Depth=5
	ld	c, 23
	.local	.LBB14_65
.LBB14_65:                              ;   in Loop: Header=BB14_49 Depth=5
	push	ix
	lea	ix, ix - 128
	ld	(ix - 100), c
	pop	ix
	ld	de, 0
	ld	e, c
	push	ix
	lea	ix, ix - 128
	ld	(ix - 103), de
	pop	ix
	push	de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), iy
	pop	ix
	push	iy
	push	hl
	call	_memcpy
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 100
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	pop	hl
	pop	hl
	pop	hl
	.local	.LBB14_66
.LBB14_66:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ;         Parent Loop BB14_28 Depth=4
                                        ;           Parent Loop BB14_49 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 112
	ld	hl, (iy + 0)
	add	hl, bc
	ld	(hl), 0
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, -228
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	a, e
	or	a, a
	jr	z, .LBB14_68
; %bb.67:                               ;   in Loop: Header=BB14_66 Depth=6
	ld	bc, -240
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 100
	ld	bc, (iy + 0)
	add	hl, bc
	ld	bc, -231
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	l, e
	dec	l
	dec	e
	ld	bc, 0
	ld	c, e
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 103)
	pop	ix
	ld	a, (iy - 1)
	cp	a, 32
	ld	e, l
	jr	z, .LBB14_66
	.local	.LBB14_68
.LBB14_68:                              ;   in Loop: Header=BB14_49 Depth=5
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_GetStringWidth
	push	hl
	pop	iy
	pop	hl
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	call	__ishrs_1
	ex	de, hl
	ld	bc, -217
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	de, 55
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 97)
	pop	ix
	ld	bc, 9
	call	__imulu
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 92)
	pop	ix
	add	hl, de
	ld	de, 115
	add	hl, de
	push	hl
	push	iy
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	bc, -228
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	add	iy, de
	dec	iy
	.local	.LBB14_69
.LBB14_69:                              ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_20 Depth=2
                                        ;       Parent Loop BB14_26 Depth=3
                                        ;         Parent Loop BB14_28 Depth=4
                                        ;           Parent Loop BB14_49 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	ld	e, (iy + 1)
	inc	iy
	ld	a, e
	cp	a, 32
	jr	z, .LBB14_69
; %bb.70:                               ;   in Loop: Header=BB14_49 Depth=5
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 97)
	pop	ix
	inc	hl
	jp	.LBB14_49
	.local	.LBB14_71
.LBB14_71:                              ;   in Loop: Header=BB14_28 Depth=4
	ld	de, -243
	lea	iy, ix + 0
	add	iy, de
	ld	b, (iy + 0)                     ; 1-byte Folded Reload
	inc	b
	jp	.LBB14_28
	.local	.LBB14_72
.LBB14_72:                              ;   in Loop: Header=BB14_26 Depth=3
	call	_gfx_SwapDraw
	.local	.LBB14_73
.LBB14_73:                              ;   in Loop: Header=BB14_26 Depth=3
	call	_kb_Scan
	ld	hl, -720866
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	iy, 0
	lea	de, iy + 0
	ld	e, l
	ld	d, h
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	hl, -720878
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), l
	ld	(ix - 82), h
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 80)
	pop	ix
	call	__inot
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 80), de
	pop	ix
	ex	de, hl
	call	__iand
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 77)
	pop	ix
	call	__inot
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), iy
	pop	ix
	lea	hl, iy + 0
	call	__iand
	ld	a, (_choose_builtin.sel)
	ld	b, a
	ld	a, (_choose_builtin.view_start)
	ld	iyh, a
	ld	a, e
	bit	1, a
	jp	nz, .LBB14_82
; %bb.74:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	a, e
	bit	2, a
	jp	nz, .LBB14_84
; %bb.75:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	a, e
	bit	3, a
	jp	nz, .LBB14_87
; %bb.76:                               ;   in Loop: Header=BB14_26 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	(ix - 89), hl
	pop	ix
	ld	iyl, b
	ex	de, hl
	ld	bc, 1
	call	__iand
	bit	0, l
	jp	nz, .LBB14_89
; %bb.77:                               ;   in Loop: Header=BB14_26 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 89)
	pop	ix
	call	__iand
	bit	0, l
	jp	nz, .LBB14_109
; %bb.78:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, -1
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 86)
	pop	ix
	ld	a, e
	xor	a, l
	ld	l, a
	ld	e, 64
	ld	a, l
	and	a, e
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 83)
	ld	d, (ix - 82)
	pop	ix
                                        ; kill: def $e killed $e killed $de
	ld	a, l
	and	a, e
	ld	l, a
	or	a, a
	ld	b, iyl
	jp	nz, .LBB14_194
; %bb.79:                               ;   in Loop: Header=BB14_26 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 89)
	pop	ix
	ld	a, l
	bit	6, a
	ld	a, -1
	jr	z, .LBB14_81
; %bb.80:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	a, 0
	.local	.LBB14_81
.LBB14_81:                              ;   in Loop: Header=BB14_26 Depth=3
	bit	0, a
	ld	c, b
	jp	z, .LBB14_194
	jr	.LBB14_93
	.local	.LBB14_82
.LBB14_82:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, b
	ld	c, 3
	call	__bremu
	or	a, a
	ld	c, b
	jr	z, .LBB14_93
; %bb.83:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, b
	dec	l
	jr	.LBB14_92
	.local	.LBB14_84
.LBB14_84:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, b
	ld	c, 3
	call	__bremu
	ld	l, a
	ld	a, b
	cp	a, 48
	ld	c, b
	jr	nc, .LBB14_93
; %bb.85:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	a, l
	cp	a, 2
	ld	c, b
	jr	nc, .LBB14_93
; %bb.86:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, b
	inc	l
	jr	.LBB14_92
	.local	.LBB14_87
.LBB14_87:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, b
	cp	a, 3
	ld	c, b
	jr	c, .LBB14_93
; %bb.88:                               ;   in Loop: Header=BB14_26 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 94)
	ld	h, (ix - 93)
	pop	ix
	jr	.LBB14_91
	.local	.LBB14_89
.LBB14_89:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	b, iyl
	ld	a, b
	cp	a, 46
	jp	nc, .LBB14_108
; %bb.90:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, 3
	.local	.LBB14_91
.LBB14_91:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, b
	add	a, l
	ld	l, a
	.local	.LBB14_92
.LBB14_92:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, l
	ld	(_choose_builtin.sel), a
	ld	c, l
	.local	.LBB14_93
.LBB14_93:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, c
	cp	a, iyh
	jr	nc, .LBB14_96
; %bb.94:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	a, iyh
	cp	a, 3
	jr	nc, .LBB14_98
; %bb.95:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, 0
	jr	.LBB14_100
	.local	.LBB14_96
.LBB14_96:                              ;   in Loop: Header=BB14_26 Depth=3
	or	a, a
	sbc	hl, hl
	ld	a, iyh
	push	hl
	pop	iy
	ld	iyl, a
	ld	l, c
	ld	de, 6
	add	iy, de
	lea	de, iy + 0
	ld	iyh, a
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	e, iyh
	ex	de, hl
	jr	c, .LBB14_101
; %bb.97:                               ;   in Loop: Header=BB14_26 Depth=3
	ld	l, 3
	jr	.LBB14_99
	.local	.LBB14_98
.LBB14_98:                              ;   in Loop: Header=BB14_26 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 94)
	ld	h, (ix - 93)
	pop	ix
	.local	.LBB14_99
.LBB14_99:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, iyh
	add	a, l
	ld	l, a
	.local	.LBB14_100
.LBB14_100:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	a, l
	ld	(_choose_builtin.view_start), a
	.local	.LBB14_101
.LBB14_101:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	a, l
	cp	a, 49
	jr	c, .LBB14_103
; %bb.102:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, 48
	ld	(_choose_builtin.view_start), a
	ld	l, a
	.local	.LBB14_103
.LBB14_103:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	a, l
	cp	a, iyh
	ld	l, -1
	jr	nz, .LBB14_105
; %bb.104:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	l, 0
	.local	.LBB14_105
.LBB14_105:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	a, c
	cp	a, b
	ld	a, -1
	jr	nz, .LBB14_107
; %bb.106:                              ;   in Loop: Header=BB14_26 Depth=3
	ld	a, 0
	.local	.LBB14_107
.LBB14_107:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	de, 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	c, (iy + 0)
	ld	b, (iy + 1)
	ld	e, c
	ld	d, b
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	or	a, l
	ld	l, a
	jp	.LBB14_26
	.local	.LBB14_108
.LBB14_108:                             ;   in Loop: Header=BB14_26 Depth=3
	ld	a, b
	ld	c, 3
	call	__bremu
	ld	l, a
	ld	a, b
	add	a, c
	ld	e, a
	ld	a, e
	sub	a, l
	ld	l, a
	cp	a, 49
	ld	l, 48
	ld	c, b
	jp	c, .LBB14_92
	jp	.LBB14_93
	.local	.LBB14_109
.LBB14_109:                             ;   in Loop: Header=BB14_20 Depth=2
	call	_wait_release
	ld	a, (_choose_builtin.sel)
	cp	a, 49
	jp	nc, .LBB14_20
; %bb.110:                              ;   in Loop: Header=BB14_20 Depth=2
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	de, 14
	push	de
	pop	bc
	call	__imulu
	ex	de, hl
	ld	iy, _builtin_levels
	add	iy, de
	ld	hl, (iy)
	ld	de, (iy + 5)
	ld	bc, (iy + 10)
	ld	iy, (iy + 8)
	push	iy
	push	bc
	push	de
	ld	de, 14
	push	de
	push	de
	push	hl
	call	_install_level
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	bit	0, a
	call	nz, _play_level
	jp	.LBB14_20
	.local	.LBB14_111
.LBB14_111:                             ;   in Loop: Header=BB14_1 Depth=1
	ld	a, l
	cp	a, 1
	jp	nz, .LBB14_195
; %bb.112:                              ;   in Loop: Header=BB14_1 Depth=1
	xor	a, a
	ld	(_editor_valid_mask), a
	sbc	hl, hl
	.local	.LBB14_113
.LBB14_113:                             ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	push	hl
	pop	bc
	ld	de, 1568
	or	a, a
	sbc	hl, de
	jr	z, .LBB14_115
; %bb.114:                              ;   in Loop: Header=BB14_113 Depth=2
	ld	hl, _editor_cells
	add	hl, bc
	ld	(hl), 1
	push	hl
	pop	iy
	inc	iy
	lea	de, iy + 0
	push	bc
	pop	iy
	ld	bc, 195
	ldir
	lea	hl, iy + 0
	ld	de, 196
	add	hl, de
	jr	.LBB14_113
	.local	.LBB14_115
.LBB14_115:                             ;   in Loop: Header=BB14_1 Depth=1
	ld	hl, _.str.28.57
	push	hl
	ld	hl, _.str.27.56
	push	hl
	call	_ti_Open
	ld	e, a
	pop	hl
	pop	hl
	or	a, a
	jp	z, .LBB14_129
; %bb.116:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	push	de
	ld	hl, 6
	push	hl
	ld	hl, 1
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_ti_Read
	pop	de
	pop	de
	pop	de
	pop	de
	ld	de, 6
	or	a, a
	sbc	hl, de
	jp	nz, .LBB14_128
; %bb.117:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	hl, 4
	push	hl
	ld	hl, _.str.29.58
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_memcmp
	pop	de
	pop	de
	pop	de
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB14_128
; %bb.118:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	de, -272
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	a, (iy + 4)
	cp	a, 1
	jp	nz, .LBB14_128
; %bb.119:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	hl, 1568
	push	hl
	ld	hl, 1
	push	hl
	ld	hl, _editor_cells
	push	hl
	call	_ti_Read
	pop	de
	pop	de
	pop	de
	pop	de
	ld	de, 1568
	or	a, a
	sbc	hl, de
	jp	nz, .LBB14_128
; %bb.120:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	de, -272
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	a, (iy + 5)
	ld	(_editor_valid_mask), a
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_ti_Close
	pop	hl
	ld	a, (_editor_valid_mask)
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	hl, _editor_cells
	push	hl
	pop	iy
	ld	bc, 0
	.local	.LBB14_121
.LBB14_121:                             ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	push	bc
	pop	hl
	ld	de, 8
	or	a, a
	sbc	hl, de
	jp	z, .LBB14_129
; %bb.122:                              ;   in Loop: Header=BB14_121 Depth=2
	ld	hl, 1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 80), bc
	pop	ix
                                        ; kill: def $c killed $c killed $ubc
	call	__ishl
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 77)
	pop	ix
	ld	a, e
	and	a, l
	ld	l, a
	or	a, a
	jr	nz, .LBB14_124
; %bb.123:                              ;   in Loop: Header=BB14_121 Depth=2
	ld	de, 196
	jr	.LBB14_127
	.local	.LBB14_124
.LBB14_124:                             ;   in Loop: Header=BB14_121 Depth=2
	ld	bc, -214
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), de
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	push	iy
	call	_editor_level_valid
	pop	hl
	bit	0, a
	jr	nz, .LBB14_126
; %bb.125:                              ;   in Loop: Header=BB14_121 Depth=2
	ld	l, -1
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	a, e
	xor	a, l
	ld	l, a
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, e
	and	a, l
	ld	e, a
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	ld	(_editor_valid_mask), a
	.local	.LBB14_126
.LBB14_126:                             ;   in Loop: Header=BB14_121 Depth=2
	ld	de, 196
	ld	bc, -211
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	.local	.LBB14_127
.LBB14_127:                             ;   in Loop: Header=BB14_121 Depth=2
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 80)
	pop	ix
	inc	bc
	add	iy, de
	jp	.LBB14_121
	.local	.LBB14_128
.LBB14_128:                             ;   in Loop: Header=BB14_1 Depth=1
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_ti_Close
	pop	hl
	.local	.LBB14_129
.LBB14_129:                             ;   in Loop: Header=BB14_1 Depth=1
	call	_wait_release
	ld	a, 1
	ld	l, a
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	dec	a
	ld	e, a
	.local	.LBB14_130
.LBB14_130:                             ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB14_131 Depth 3
                                        ;         Child Loop BB14_147 Depth 4
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	l, -4
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	a, e
	and	a, l
	ld	l, a
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	call	_draw_grid_background
	ld	hl, 2
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 5
	push	hl
	ld	hl, 8
	push	hl
	ld	hl, _.str.5.59
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	iy, 0
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 80)
	ld	d, (ix - 79)
	pop	ix
	ld	l, e
	push	ix
	lea	ix, ix - 128
	push	af
	ld	a, (ix - 83)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	pop	ix
	ld	bc, 69
	call	__imulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 97), hl
	pop	ix
	ld	bc, 0
	.local	.LBB14_131
.LBB14_131:                             ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_130 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB14_147 Depth 4
	push	bc
	pop	hl
	ld	de, 4
	or	a, a
	sbc	hl, de
	jp	z, .LBB14_157
; %bb.132:                              ;   in Loop: Header=BB14_131 Depth=3
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 89), bc
	pop	ix
	lea	bc, iy + 0
	call	__ior
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 89)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 92), hl
	pop	ix
	ld	de, 8
	or	a, a
	sbc	hl, de
	jp	nc, .LBB14_157
; %bb.133:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	de, -228
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	push	bc
	pop	hl
	ld	bc, 43
	call	__imulu
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, 31
	add	hl, de
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	a, (_editor_valid_mask)
	ld	e, a
	ld	hl, 1
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 92
	ld	bc, (iy + 0)
	call	__ishl
	ld	a, l
	and	a, e
	ld	l, a
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	push	bc
	pop	hl
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ld	a, 2
	ld	l, a
	jr	z, .LBB14_135
; %bb.134:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	a, 24
	ld	l, a
	.local	.LBB14_135
.LBB14_135:                             ;   in Loop: Header=BB14_131 Depth=3
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 38
	push	hl
	ld	hl, 280
	push	hl
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	hl, 20
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 33
	add	hl, de
	inc	de
	push	de
	ld	de, 276
	push	de
	push	hl
	ld	hl, 22
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 52
	add	hl, de
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	or	a, a
	ld	de, -220
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	pop	bc
	inc	bc
	jp	nz, .LBB14_144
; %bb.136:                              ;   in Loop: Header=BB14_131 Depth=3
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ld	a, -1
	jr	z, .LBB14_138
; %bb.137:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	a, 0
	.local	.LBB14_138
.LBB14_138:                             ;   in Loop: Header=BB14_131 Depth=3
	ld	de, -220
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), a
	push	bc
	ld	hl, _.str.18.60
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	call	_sprintf
	pop	hl
	pop	hl
	pop	hl
	ld	de, -220
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, 3
	ld	l, a
	jr	nz, .LBB14_140
; %bb.139:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	a, 22
	ld	l, a
	.local	.LBB14_140
.LBB14_140:                             ;   in Loop: Header=BB14_131 Depth=3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, 39
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	push	hl
	ld	hl, 136
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	de, -220
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, 2
	ld	l, a
	jr	nz, .LBB14_142
; %bb.141:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	a, 23
	ld	l, a
	.local	.LBB14_142
.LBB14_142:                             ;   in Loop: Header=BB14_131 Depth=3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -231
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	hl, 120
	push	hl
	ld	hl, _.str.19.61
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	de, -228
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, -217
	lea	hl, ix + 0
	add	hl, de
	ld	bc, (hl)
	.local	.LBB14_143
.LBB14_143:                             ; %.loopexit
                                        ;   in Loop: Header=BB14_131 Depth=3
	inc	bc
	jp	.LBB14_131
	.local	.LBB14_144
.LBB14_144:                             ;   in Loop: Header=BB14_131 Depth=3
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ld	a, 3
	ld	l, a
	jr	z, .LBB14_146
; %bb.145:                              ;   in Loop: Header=BB14_131 Depth=3
	ld	a, 22
	ld	l, a
	.local	.LBB14_146
.LBB14_146:                             ;   in Loop: Header=BB14_131 Depth=3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	hl, _.str.20.62
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_sprintf
	pop	hl
	pop	hl
	pop	hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 36
	add	hl, de
	push	hl
	ld	hl, 29
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	de, 49
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	hl, _editor_menu.actions
	push	hl
	pop	iy
	ld	bc, 0
	.local	.LBB14_147
.LBB14_147:                             ;   Parent Loop BB14_1 Depth=1
                                        ;     Parent Loop BB14_130 Depth=2
                                        ;       Parent Loop BB14_131 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ld	de, -234
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	push	bc
	pop	hl
	ld	de, 207
	or	a, a
	sbc	hl, de
	ld	de, -228
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	iy, (hl)
	push	bc
	pop	de
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 89)
	pop	ix
	jp	z, .LBB14_143
; %bb.148:                              ;   in Loop: Header=BB14_147 Depth=4
	push	de
	pop	hl
	push	de
	pop	bc
	ld	de, 80
	add	hl, de
	ld	de, -243
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -225
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, -237
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	or	a, a
	sbc	hl, bc
	ld	e, d
	jr	z, .LBB14_150
; %bb.149:                              ;   in Loop: Header=BB14_147 Depth=4
	ld	e, 0
	.local	.LBB14_150
.LBB14_150:                             ;   in Loop: Header=BB14_147 Depth=4
	ld	bc, -220
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	bc, (iy + 0)
	or	a, a
	sbc	hl, bc
	ld	a, -1
	jr	z, .LBB14_152
; %bb.151:                              ;   in Loop: Header=BB14_147 Depth=4
	ld	a, 0
	.local	.LBB14_152
.LBB14_152:                             ;   in Loop: Header=BB14_147 Depth=4
	and	a, e
	ld	l, a
	ld	de, -246
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l                     ; 1-byte Folded Spill
	bit	0, l
	ld	a, 2
	ld	l, a
	jr	nz, .LBB14_154
; %bb.153:                              ;   in Loop: Header=BB14_147 Depth=4
	ld	a, 25
	ld	l, a
	.local	.LBB14_154
.LBB14_154:                             ;   in Loop: Header=BB14_147 Depth=4
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 14
	push	hl
	ld	hl, 62
	push	hl
	ld	de, -211
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	ld	de, -243
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, -246
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, 0
	ld	l, a
	jr	nz, .LBB14_156
; %bb.155:                              ;   in Loop: Header=BB14_147 Depth=4
	ld	a, 22
	ld	l, a
	.local	.LBB14_156
.LBB14_156:                             ;   in Loop: Header=BB14_147 Depth=4
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	de, -234
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, (hl)
	ld	bc, -237
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	ld	bc, 85
	add	hl, bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 103
	ld	bc, (iy + 0)
	push	bc
	push	hl
	push	de
	call	_gfx_PrintStringXY
	ld	de, -234
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	pop	hl
	pop	hl
	pop	hl
	ld	de, 69
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 109)
	pop	ix
	add	hl, de
	lea	iy, iy + 3
	push	hl
	pop	bc
	jp	.LBB14_147
	.local	.LBB14_157
.LBB14_157:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	hl, 23
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 218
	push	hl
	ld	hl, 33
	push	hl
	ld	hl, _.str.21.63
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 229
	push	hl
	ld	hl, 48
	push	hl
	ld	hl, _.str.22.64
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	call	_kb_Scan
	ld	hl, -720866
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	iyl, e
	ld	iyh, d
	pop	de
	ld	hl, -720878
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, e
	bit	3, a
	jp	nz, .LBB14_166
; %bb.158:                              ;   in Loop: Header=BB14_130 Depth=2
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), l
	ld	(ix - 82), h
	pop	ix
	ld	l, e
	ld	h, d
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jp	nz, .LBB14_171
; %bb.159:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	a, e
	bit	1, a
	jp	z, .LBB14_161
; %bb.160:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	hl, 1
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 77)
	pop	ix
                                        ; kill: def $c killed $c killed $ubc
	call	__ishl
	ld	c, a
	ld	a, l
	and	a, c
	ld	l, a
	or	a, a
	jp	nz, .LBB14_180
	.local	.LBB14_161
.LBB14_161:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	a, e
	bit	2, a
	jp	z, .LBB14_163
; %bb.162:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	e, a
	ld	hl, 1
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 77)
	pop	ix
                                        ; kill: def $c killed $c killed $ubc
	call	__ishl
	ld	a, l
	and	a, e
	ld	l, a
	or	a, a
	jp	nz, .LBB14_182
	.local	.LBB14_163
.LBB14_163:                             ;   in Loop: Header=BB14_130 Depth=2
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jp	nz, .LBB14_177
; %bb.164:                              ;   in Loop: Header=BB14_130 Depth=2
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 83)
	ld	h, (ix - 82)
	pop	ix
	ld	a, l
	bit	6, a
	ld	bc, -205
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	de, (hl)
	jp	nz, .LBB14_194
; %bb.165:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	a, iyl
	bit	6, a
	jp	z, .LBB14_130
	jp	.LBB14_194
	.local	.LBB14_166
.LBB14_166:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	a, l
	or	a, a
	ld	a, 7
	ld	c, a
	jr	z, .LBB14_168
; %bb.167:                              ;   in Loop: Header=BB14_130 Depth=2
	dec	l
	ld	c, l
	.local	.LBB14_168
.LBB14_168:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	e, a
	ld	hl, 1
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	(iy + 0), c                     ; 1-byte Folded Spill
	call	__ishl
	ld	a, l
	and	a, e
	ld	l, a
	or	a, a
	ld	a, 1
	jr	z, .LBB14_170
; %bb.169:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	.local	.LBB14_170
.LBB14_170:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	call	_wait_release
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	jp	.LBB14_130
	.local	.LBB14_171
.LBB14_171:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	inc	c
	ld	l, 7
	ld	a, c
	and	a, l
	ld	c, a
	ld	a, (_editor_valid_mask)
	ld	e, a
	ld	hl, 1
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	(iy + 0), bc
                                        ; kill: def $c killed $c killed $ubc
	call	__ishl
	ld	a, l
	and	a, e
	ld	l, a
	or	a, a
	ld	a, 1
	jr	z, .LBB14_173
; %bb.172:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	.local	.LBB14_173
.LBB14_173:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	.local	.LBB14_174
.LBB14_174:                             ;   in Loop: Header=BB14_130 Depth=2
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	call	_wait_release
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	.local	.LBB14_175
.LBB14_175:                             ;   in Loop: Header=BB14_130 Depth=2
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	.local	.LBB14_176
.LBB14_176:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	jp	.LBB14_130
	.local	.LBB14_177
.LBB14_177:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	e, a
	ld	hl, 1
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	bc, (iy + 0)
                                        ; kill: def $c killed $c killed $ubc
	call	__ishl
	ld	bc, -217
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	a, l
	and	a, e
	ld	l, a
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	call	_wait_release
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	or	a, a
	jr	nz, .LBB14_183
; %bb.178:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_edit_slot
	.local	.LBB14_179
.LBB14_179:                             ;   in Loop: Header=BB14_130 Depth=2
	pop	hl
	ld	a, 1
	ld	l, a
	ld	de, -208
	jp	.LBB14_175
	.local	.LBB14_180
.LBB14_180:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	or	a, a
	ld	a, 2
	jp	z, .LBB14_174
; %bb.181:                              ;   in Loop: Header=BB14_130 Depth=2
	dec	l
	ld	a, l
	jp	.LBB14_174
	.local	.LBB14_182
.LBB14_182:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	h, 0
	inc.sis	hl
	ld.sis	bc, 3
	call	__sremu
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	call	_wait_release
	jp	.LBB14_176
	.local	.LBB14_183
.LBB14_183:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -208
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	or	a, a
	jp	nz, .LBB14_188
; %bb.184:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	a, e
	cp	a, 8
	ld	a, 0
	ld	l, a
	ld	bc, -208
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	(iy + 0), l
	ld	(iy + 1), h
	jp	nc, .LBB14_130
; %bb.185:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	l, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 89
	ld	bc, (iy + 0)
	ld	a, c
	and	a, l
	ld	l, a
	or	a, a
	ld	a, 0
	ld	l, a
	ld	bc, -208
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	(iy + 0), l
	ld	(iy + 1), h
	jp	z, .LBB14_130
; %bb.186:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	inc	de
	push	de
	ld	hl, _.str.69
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_sprintf
	pop	hl
	pop	hl
	pop	hl
	ld	de, -214
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, 196
	call	__imulu
	ex	de, hl
	ld	hl, _editor_cells
	add	hl, de
	ld	de, 0
	push	de
	push	de
	push	hl
	ld	hl, 14
	push	hl
	push	hl
	ld	de, -240
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_install_level
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	bit	0, a
	ld	a, 0
	ld	l, a
	ld	bc, -208
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	(iy + 0), l
	ld	(iy + 1), h
	jp	z, .LBB14_130
; %bb.187:                              ;   in Loop: Header=BB14_130 Depth=2
	call	_play_level
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	xor	a, a
	jr	.LBB14_190
	.local	.LBB14_188
.LBB14_188:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	a, l
	cp	a, 1
	jr	nz, .LBB14_191
; %bb.189:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_edit_slot
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	pop	hl
	ld	a, 1
	.local	.LBB14_190
.LBB14_190:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	l, a
	ld	bc, -208
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), l
	ld	(iy + 1), h
	jp	.LBB14_130
	.local	.LBB14_191
.LBB14_191:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	a, (_editor_valid_mask)
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -214
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 196
	push	de
	pop	bc
	call	__imulu
	ex	de, hl
	ld	iy, _editor_cells
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 112)
	pop	ix
	lea	hl, iy + 0
	ldir
	ld	l, -1
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 89)
	pop	ix
	ld	a, e
	xor	a, l
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 83)
	pop	ix
	and	a, l
	ld	l, a
	ld	(_editor_valid_mask), a
	ld	(iy), 1
	lea	hl, iy + 0
	inc	hl
	ex	de, hl
	ld	bc, -214
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	lea	hl, iy + 0
	ld	bc, 195
	ldir
	call	_save_editor_data
	bit	0, a
	jr	z, .LBB14_193
; %bb.192:                              ;   in Loop: Header=BB14_130 Depth=2
	ld	hl, _.str.26.68
	push	hl
	ld	hl, _.str.25.67
	push	hl
	call	_popup_wait
	pop	hl
	jp	.LBB14_179
	.local	.LBB14_193
.LBB14_193:                             ;   in Loop: Header=BB14_130 Depth=2
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	ld	(_editor_valid_mask), a
	ld	bc, -214
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -240
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	ld	bc, 196
	ldir
	ld	hl, _.str.24.66
	push	hl
	ld	hl, _.str.23.65
	push	hl
	call	_popup_wait
	pop	hl
	pop	hl
	jp	.LBB14_176
	.local	.LBB14_194
.LBB14_194:                             ; %.loopexit28
                                        ;   in Loop: Header=BB14_1 Depth=1
	call	_wait_release
	jp	.LBB14_1
	.local	.LBB14_195
.LBB14_195:                             ; %.loopexit32
	call	_gfx_End
	call	_kb_Reset
	or	a, a
	sbc	hl, hl
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end14
.Lfunc_end14:
	.size	_main, .Lfunc_end14-_main
                                        ; -- End function
	.section	.text._wait_release,"ax",@progbits
	.type	_wait_release,@function         ; -- Begin function wait_release
_wait_release:                          ; @wait_release
; %bb.0:
	.local	.LBB15_1
.LBB15_1:                               ; =>This Inner Loop Header: Depth=1
	call	_kb_Scan
	call	_kb_AnyKey
	or	a, a
	jr	nz, .LBB15_1
; %bb.2:
	ret
	.local	.Lfunc_end15
.Lfunc_end15:
	.size	_wait_release, .Lfunc_end15-_wait_release
                                        ; -- End function
	.section	.text._draw_grid_background,"ax",@progbits
	.type	_draw_grid_background,@function ; -- Begin function draw_grid_background
_draw_grid_background:                  ; @draw_grid_background
; %bb.0:
	ld	hl, -3
	call	__frameset
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_FillScreen
	pop	hl
	ld	hl, 25
	push	hl
	call	_gfx_SetColor
	ld	iy, -160
	pop	hl
	.local	.LBB16_1
.LBB16_1:                               ; =>This Inner Loop Header: Depth=1
	ld	de, 340
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB16_3
; %bb.2:                                ;   in Loop: Header=BB16_1 Depth=1
	lea	hl, iy + 0
	ld	de, 120
	add	hl, de
	ld	de, 240
	push	de
	push	hl
	or	a, a
	sbc	hl, hl
	push	hl
	push	iy
	ld	(ix - 3), iy
	call	_gfx_Line
	ld	iy, (ix - 3)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, 24
	add	iy, de
	jr	.LBB16_1
	.local	.LBB16_3
.LBB16_3:
	ld	de, 260
	ld	iy, -120
	.local	.LBB16_4
.LBB16_4:                               ; %.preheader
                                        ; =>This Inner Loop Header: Depth=1
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB16_6
; %bb.5:                                ;   in Loop: Header=BB16_4 Depth=1
	lea	hl, iy + 0
	ld	de, 160
	add	hl, de
	push	hl
	ld	hl, 320
	push	hl
	push	iy
	or	a, a
	sbc	hl, hl
	push	hl
	ld	(ix - 3), iy
	call	_gfx_Line
	ld	iy, (ix - 3)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, 24
	add	iy, de
	ld	de, 260
	jr	.LBB16_4
	.local	.LBB16_6
.LBB16_6:
	pop	hl
	pop	ix
	ret
	.local	.Lfunc_end16
.Lfunc_end16:
	.size	_draw_grid_background, .Lfunc_end16-_draw_grid_background
                                        ; -- End function
	.section	.text._install_level,"ax",@progbits
	.type	_install_level,@function        ; -- Begin function install_level
_install_level:                         ; @install_level
; %bb.0:
	ld	hl, -32
	call	__frameset
	ld	e, (ix + 9)
	ld	c, -21
	ld	iyl, 0
	ld	a, e
	add	a, c
	ld	l, a
	cp	a, -20
	jp	c, .LBB17_39
; %bb.1:
	ld	(ix - 2), e
	ld	(ix - 1), d
	ld	e, (ix + 12)
	ld	a, e
	add	a, c
	ld	l, a
	cp	a, -20
	jp	c, .LBB17_39
; %bb.2:
	or	a, a
	sbc	hl, hl
	ld	a, e
	ex	de, hl
	push	de
	pop	bc
	ld	l, (ix + 9)
	ld	c, l
	ld	e, a
	ex	de, hl
	ld	(ix - 5), bc
	call	__imulu
	push	hl
	pop	de
	ld	bc, 401
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB17_39
; %bb.3:
	ld	hl, (ix + 21)
	ld.sis	bc, 1025
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB17_39
; %bb.4:
	ld	(ix - 8), de
	ld	bc, _base_grid
	ld	iyh, 0
	or	a, a
	sbc	hl, hl
	ld	de, (ix + 21)
	ld	l, e
	ld	h, d
	ld	(ix - 11), hl
	ld	l, (ix + 9)
	ld	a, l
	ld	(_level_w), a
	ld	a, (ix + 12)
	ld	(_level_h), a
	ld	a, 1
	ld	(_base_grid), a
	push	bc
	pop	hl
	inc	hl
	ex	de, hl
	push	bc
	pop	hl
	ld	bc, 399
	ldir
	ld	a, iyh
	ld	(_base_blocks), a
	ld	bc, _base_blocks
	push	bc
	pop	hl
	inc	hl
	ex	de, hl
	push	bc
	pop	hl
	ld	bc, 399
	ldir
	ld	de, 0
	ld	b, iyh
	.local	.LBB17_5
.LBB17_5:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 8)
	or	a, a
	sbc	hl, de
	jp	z, .LBB17_16
; %bb.6:                                ;   in Loop: Header=BB17_5 Depth=1
	ld	iyh, a
	ld	hl, (ix + 15)
	ld	(ix - 14), de
	add	hl, de
	ld	c, (hl)
	ld	a, c
	dec	a
	cp	a, 21
	jp	nc, .LBB17_39
; %bb.7:                                ;   in Loop: Header=BB17_5 Depth=1
	ld	(ix - 16), b                    ; 1-byte Folded Spill
	ld	l, -13
	ld	a, c
	add	a, l
	ld	e, a
	cp	a, 2
	jr	nc, .LBB17_9
; %bb.8:                                ;   in Loop: Header=BB17_5 Depth=1
	ld	hl, _base_blocks
	ld	de, (ix - 14)
	add	hl, de
	ld	(hl), c
	ld	hl, _base_grid
	add	hl, de
	ld	(hl), 1
	ld	b, (ix - 16)                    ; 1-byte Folded Reload
	jr	.LBB17_14
	.local	.LBB17_9
.LBB17_9:                               ;   in Loop: Header=BB17_5 Depth=1
	ld	a, c
	cp	a, 15
	jr	nz, .LBB17_11
; %bb.10:                               ;   in Loop: Header=BB17_5 Depth=1
	ld	de, (ix - 14)
	push	de
	pop	hl
	ld	bc, (ix - 5)
	call	__idivu
	ld	a, l
	ld	(_start_r), a
	ld	c, (ix - 2)
	ld	b, (ix - 1)
	ld	b, l
	ld	(ix - 2), c
	ld	(ix - 1), b
	ld	l, c
	ld	h, b
	mlt	hl
	ld	a, e
	sub	a, l
	ld	l, a
	ld	(_start_c), a
	ld	hl, _base_grid
	add	hl, de
	ld	(hl), 1
	ld	b, 1
	ld	a, b
	ld	b, (ix - 16)                    ; 1-byte Folded Reload
	jr	.LBB17_15
	.local	.LBB17_11
.LBB17_11:                              ;   in Loop: Header=BB17_5 Depth=1
	ld	hl, _base_grid
	ld	de, (ix - 14)
	add	hl, de
	ld	(hl), c
	ld	a, c
	cp	a, 3
	ld	a, -1
	ld	b, (ix - 16)                    ; 1-byte Folded Reload
	ld	l, 0
	jr	z, .LBB17_13
; %bb.12:                               ;   in Loop: Header=BB17_5 Depth=1
	ld	a, l
	.local	.LBB17_13
.LBB17_13:                              ;   in Loop: Header=BB17_5 Depth=1
	or	a, b
	ld	b, a
	ld	de, (ix - 14)
	.local	.LBB17_14
.LBB17_14:                              ;   in Loop: Header=BB17_5 Depth=1
	ld	a, iyh
	.local	.LBB17_15
.LBB17_15:                              ;   in Loop: Header=BB17_5 Depth=1
	inc	de
	jp	.LBB17_5
	.local	.LBB17_16
.LBB17_16:
	bit	0, a
	jp	z, .LBB17_39
; %bb.17:
	bit	0, b
	jp	z, .LBB17_39
; %bb.18:
	ld	hl, 40
	push	hl
	ld	hl, (ix + 6)
	push	hl
	ld	hl, _active_name
	push	hl
	call	_strncpy
	pop	hl
	pop	hl
	pop	hl
	xor	a, a
	ld	(_active_name+40), a
	ld	hl, (ix + 21)
	ex	de, hl
	ld	hl, _solution_len
	ld	(hl), e
	inc	hl
	ld	(hl), d
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	hl, (ix - 11)
	push	hl
	ld	hl, (ix + 18)
	push	hl
	ld	hl, _solution
	push	hl
	call	nz, _memcpy
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 8)
	ld	hl, _tele_c
	push	hl
	pop	bc
	ld	iy, _tele_r
	.local	.LBB17_19
.LBB17_19:                              ; =>This Inner Loop Header: Depth=1
	sbc	hl, hl
	adc	hl, de
	jr	z, .LBB17_21
; %bb.20:                               ;   in Loop: Header=BB17_19 Depth=1
	ld	(iy), -1
	push	bc
	pop	hl
	ld	(hl), -1
	inc	iy
	inc	hl
	push	hl
	pop	bc
	dec	de
	jr	.LBB17_19
	.local	.LBB17_21
.LBB17_21:
	ld	iyh, 0
	ld	l, (ix - 2)
	ld	h, (ix - 1)
	ex	de, hl
	ld	iyl, e
	ex	de, hl
	ld	de, 0
	.local	.LBB17_22
.LBB17_22:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB17_26 Depth 2
	push	de
	pop	hl
	ld	bc, (ix - 8)
	or	a, a
	sbc	hl, bc
	jp	z, .LBB17_38
; %bb.23:                               ;   in Loop: Header=BB17_22 Depth=1
	ld	hl, _base_grid
	add	hl, de
	ld	a, (hl)
	cp	a, 22
	jp	nc, .LBB17_37
; %bb.24:                               ;   in Loop: Header=BB17_22 Depth=1
	ld	hl, 1
	ld	(ix - 11), a                    ; 1-byte Folded Spill
	ld	c, (ix - 11)                    ; 1-byte Folded Reload
	call	__ishl
	ld	bc, 3148800
	call	__iand
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	z, .LBB17_37
; %bb.25:                               ;   in Loop: Header=BB17_22 Depth=1
	push	iy
	ex	(sp), hl
	ld	(ix - 18), l
	ld	(ix - 17), h
	pop	hl
	push	de
	pop	hl
	ld	bc, (ix - 5)
	call	__idivu
	push	hl
	pop	iy
	call	__imulu
	or	a, a
	sbc	hl, de
	ld	(ix - 26), hl
	lea	hl, iy + 0
	ld	bc, 255
	call	__iand
	ld	(ix - 29), hl
	ld.sis	iy, 0
	push	iy
	ex	(sp), hl
	ld	(ix - 16), l
	ld	(ix - 15), h
	pop	hl
	ld	iy, 0
	ld.sis	hl, -1
	ld	(ix - 14), l
	ld	(ix - 13), h
	ld	(ix - 23), l
	ld	(ix - 22), h
	.local	.LBB17_26
.LBB17_26:                              ;   Parent Loop BB17_22 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	hl, (ix - 8)
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	z, .LBB17_35
; %bb.27:                               ;   in Loop: Header=BB17_26 Depth=2
	push	de
	pop	hl
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ld	(ix - 21), iy
	jp	z, .LBB17_34
; %bb.28:                               ;   in Loop: Header=BB17_26 Depth=2
	ld	hl, _base_grid
	lea	bc, iy + 0
	add	hl, bc
	ld	a, (hl)
	ld	l, (ix - 11)
	cp	a, l
	jp	nz, .LBB17_34
; %bb.29:                               ;   in Loop: Header=BB17_26 Depth=2
	lea	hl, iy + 0
	ld	bc, (ix - 5)
	call	__idivu
	push	hl
	pop	iy
	ld	bc, (ix - 29)
	or	a, a
	sbc	hl, bc
	ld	(ix - 32), hl
	lea	hl, iy + 0
	ld	bc, (ix - 5)
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 21)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	bc, (ix - 26)
	add	iy, bc
	ld	bc, (ix - 32)
	push	bc
	pop	hl
	call	__imulu
	ld	(ix - 32), hl
	lea	hl, iy + 0
	lea	bc, iy + 0
	call	__imulu
	ld	bc, (ix - 32)
	add	hl, bc
	ld	(ix - 32), hl
	ld	bc, 65535
	call	__iand
	ld	iy, 0
	ld	c, (ix - 23)
	ld	b, (ix - 22)
	ld	iyl, c
	ld	iyh, b
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
                                        ; kill: def $a killed $a
	sbc	a, a
	bit	0, a
	ld	l, (ix - 16)
	ld	h, (ix - 15)
	jr	nz, .LBB17_31
; %bb.30:                               ;   in Loop: Header=BB17_26 Depth=2
	ld	l, (ix - 14)
	ld	h, (ix - 13)
	.local	.LBB17_31
.LBB17_31:                              ;   in Loop: Header=BB17_26 Depth=2
	bit	0, a
	ld	bc, (ix - 32)
	jp	nz, .LBB17_33
; %bb.32:                               ;   in Loop: Header=BB17_26 Depth=2
	ld	c, (ix - 23)
	ld	b, (ix - 22)
                                        ; kill: def $bc killed $bc def $ubc
	.local	.LBB17_33
.LBB17_33:                              ;   in Loop: Header=BB17_26 Depth=2
	ld	(ix - 14), l
	ld	(ix - 13), h
	ld	l, c
	ld	h, b
	ld	(ix - 23), l
	ld	(ix - 22), h
	.local	.LBB17_34
.LBB17_34:                              ;   in Loop: Header=BB17_26 Depth=2
	ld	iy, (ix - 21)
	inc	iy
	ld	l, (ix - 16)
	ld	h, (ix - 15)
	inc.sis	hl
	ld	(ix - 16), l
	ld	(ix - 15), h
	jp	.LBB17_26
	.local	.LBB17_35
.LBB17_35:                              ;   in Loop: Header=BB17_22 Depth=1
	ld	l, (ix - 14)
	ld	h, (ix - 13)
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	push	hl
	ld	l, (ix - 18)
	ld	h, (ix - 17)
	ex	(sp), hl
	pop	iy
	jr	z, .LBB17_37
; %bb.36:                               ;   in Loop: Header=BB17_22 Depth=1
	ld	l, (ix - 14)
	ld	h, (ix - 13)
	ld	c, iyl
	ld	b, iyh
	call	__sdivu
	ld	a, l
	ld	iy, _tele_r
	add	iy, de
	ld	(iy), a
	push	hl
	ld	l, (ix - 18)
	ld	h, (ix - 17)
	ex	(sp), hl
	pop	iy
	ld	h, l
	ld	c, (ix - 2)
	ld	b, (ix - 1)
	ld	l, c
	mlt	hl
	ld	c, (ix - 14)
	ld	b, (ix - 13)
	ld	a, c
	sub	a, l
	ld	c, a
	ld	hl, _tele_c
	add	hl, de
	ld	(hl), c
	.local	.LBB17_37
.LBB17_37:                              ;   in Loop: Header=BB17_22 Depth=1
	inc	de
	jp	.LBB17_22
	.local	.LBB17_38
.LBB17_38:
	call	_engine_reset
	ld	iyl, 1
	.local	.LBB17_39
.LBB17_39:                              ; %.loopexit
	ld	a, iyl
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end17
.Lfunc_end17:
	.size	_install_level, .Lfunc_end17-_install_level
                                        ; -- End function
	.section	.text._play_level,"ax",@progbits
	.type	_play_level,@function           ; -- Begin function play_level
_play_level:                            ; @play_level
; %bb.0:
	ld	hl, -113
	call	__frameset
	ld	a, 1
	lea	hl, ix - 28
	ld	(ix - 70), hl
	ld	(_in_game), a
	.local	.LBB18_1
.LBB18_1:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB18_2 Depth 2
                                        ;       Child Loop BB18_3 Depth 3
                                        ;         Child Loop BB18_4 Depth 4
                                        ;         Child Loop BB18_22 Depth 4
                                        ;           Child Loop BB18_26 Depth 5
                                        ;             Child Loop BB18_28 Depth 6
                                        ;         Child Loop BB18_37 Depth 4
                                        ;           Child Loop BB18_39 Depth 5
                                        ;         Child Loop BB18_43 Depth 4
                                        ;           Child Loop BB18_45 Depth 5
                                        ;       Child Loop BB18_49 Depth 3
                                        ;         Child Loop BB18_50 Depth 4
                                        ;           Child Loop BB18_64 Depth 5
                                        ;             Child Loop BB18_66 Depth 6
                                        ;               Child Loop BB18_73 Depth 7
                                        ;       Child Loop BB18_98 Depth 3
	call	_engine_reset
	.local	.LBB18_2
.LBB18_2:                               ;   Parent Loop BB18_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB18_3 Depth 3
                                        ;         Child Loop BB18_4 Depth 4
                                        ;         Child Loop BB18_22 Depth 4
                                        ;           Child Loop BB18_26 Depth 5
                                        ;             Child Loop BB18_28 Depth 6
                                        ;         Child Loop BB18_37 Depth 4
                                        ;           Child Loop BB18_39 Depth 5
                                        ;         Child Loop BB18_43 Depth 4
                                        ;           Child Loop BB18_45 Depth 5
                                        ;       Child Loop BB18_49 Depth 3
                                        ;         Child Loop BB18_50 Depth 4
                                        ;           Child Loop BB18_64 Depth 5
                                        ;             Child Loop BB18_66 Depth 6
                                        ;               Child Loop BB18_73 Depth 7
                                        ;       Child Loop BB18_98 Depth 3
	call	_draw_game_frame
	.local	.LBB18_3
.LBB18_3:                               ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB18_4 Depth 4
                                        ;         Child Loop BB18_22 Depth 4
                                        ;           Child Loop BB18_26 Depth 5
                                        ;             Child Loop BB18_28 Depth 6
                                        ;         Child Loop BB18_37 Depth 4
                                        ;           Child Loop BB18_39 Depth 5
                                        ;         Child Loop BB18_43 Depth 4
                                        ;           Child Loop BB18_45 Depth 5
	call	_wait_release
	.local	.LBB18_4
.LBB18_4:                               ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	call	_kb_Scan
	ld	hl, -720866
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	iyl, e
	ld	iyh, d
	pop	de
	ld	hl, -720878
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, -720876
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	(ix - 37), l
	ld	(ix - 36), h
	ld	a, e
	bit	3, a
	ld	hl, 0
	jr	nz, .LBB18_13
; %bb.5:                                ;   in Loop: Header=BB18_4 Depth=4
	ld	a, e
	bit	2, a
	ld	hl, 1
	jr	nz, .LBB18_13
; %bb.6:                                ;   in Loop: Header=BB18_4 Depth=4
	ld	l, e
	ld	h, d
	ld	(ix - 40), c
	ld	(ix - 39), b
	ld.sis	bc, 1
	call	__sand
	ld	c, (ix - 40)
	ld	b, (ix - 39)
	bit	0, l
	ld	hl, 2
	jr	nz, .LBB18_13
; %bb.7:                                ;   in Loop: Header=BB18_4 Depth=4
	ld	a, e
	bit	1, a
	ld	hl, 3
	jr	nz, .LBB18_13
; %bb.8:                                ;   in Loop: Header=BB18_4 Depth=4
	ld	a, c
	bit	5, a
	jr	nz, .LBB18_1
; %bb.9:                                ;   in Loop: Header=BB18_4 Depth=4
	ld	l, -128
	ld	e, (ix - 37)
	ld	d, (ix - 36)
	ld	a, e
	and	a, l
	ld	l, a
	or	a, a
	jr	z, .LBB18_11
; %bb.10:                               ;   in Loop: Header=BB18_4 Depth=4
	ld	hl, _solution_len
	ld	de, (hl)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB18_48
	.local	.LBB18_11
.LBB18_11:                              ;   in Loop: Header=BB18_4 Depth=4
	ld	a, c
	bit	6, a
	jp	nz, .LBB18_102
; %bb.12:                               ;   in Loop: Header=BB18_4 Depth=4
	ld	a, iyl
	bit	6, a
	jp	z, .LBB18_4
	jp	.LBB18_102
	.local	.LBB18_13
.LBB18_13:                              ;   in Loop: Header=BB18_4 Depth=4
	push	hl
	call	_engine_move
	pop	hl
	cp	a, 3
	jr	z, .LBB18_15
; %bb.14:                               ;   in Loop: Header=BB18_4 Depth=4
	ld	(ix - 37), a                    ; 1-byte Folded Spill
	call	_draw_game_frame
	call	_wait_release
	ld	a, (ix - 37)                    ; 1-byte Folded Reload
	cp	a, 2
	jp	nz, .LBB18_4
	jp	.LBB18_104
	.local	.LBB18_15
.LBB18_15:                              ;   in Loop: Header=BB18_3 Depth=3
	call	_render_game_frame_offset
	pea	ix - 34
	pea	ix - 31
	pea	ix - 28
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 31)
	ld	a, (_player_c)
	ld	bc, 0
	ld	c, a
	ld	iy, (ix - 28)
	lea	hl, iy + 0
	call	__imulu
	ld	(ix - 49), de
	add	hl, de
	ld	(ix - 46), hl
	ld	de, (ix - 34)
	ld	a, (_player_r)
	ld	bc, 0
	ld	c, a
	lea	hl, iy + 0
	call	__imulu
	ld	(ix - 52), de
	add	hl, de
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	lea	hl, iy + 0
	add	hl, de
	call	__ishrs_1
	ex	de, hl
	ld	hl, (ix - 46)
	add	hl, de
	ld	(ix - 73), hl
	push	bc
	pop	hl
	ld	(ix - 55), hl
	add	hl, de
	ld	(ix - 64), hl
	lea	hl, iy + 0
	ld	de, 2
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	ld	(ix - 43), iy
	lea	de, iy + 0
	jp	p, .LBB18_17
; %bb.16:                               ;   in Loop: Header=BB18_3 Depth=3
	ld	de, 1
	.local	.LBB18_17
.LBB18_17:                              ;   in Loop: Header=BB18_3 Depth=3
	push	de
	pop	hl
	ld	bc, 44
	call	__imulu
	ld	bc, 42
	add	hl, bc
	ld	iy, 85
	lea	bc, iy + 0
	call	__idivu
	push	hl
	pop	iy
	ex	de, hl
	ld	bc, 37
	call	__imulu
	ld	de, 42
	add	hl, de
	ld	bc, 85
	call	__idivu
	ex	de, hl
	ld	(ix - 37), iy
	lea	hl, iy + 0
	ld	bc, 3
	or	a, a
	sbc	hl, bc
	dec	bc
	jr	nc, .LBB18_19
; %bb.18:                               ;   in Loop: Header=BB18_3 Depth=3
	ld	(ix - 37), bc
	.local	.LBB18_19
.LBB18_19:                              ;   in Loop: Header=BB18_3 Depth=3
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB18_21
; %bb.20:                               ;   in Loop: Header=BB18_3 Depth=3
	ld	de, 1
	.local	.LBB18_21
.LBB18_21:                              ;   in Loop: Header=BB18_3 Depth=3
	ld	iy, (ix - 37)
	lea	hl, iy + 0
	lea	bc, iy + 0
	call	__imulu
	ld	(ix - 67), hl
	push	de
	pop	hl
	push	de
	pop	bc
	call	__imulu
	ld	(ix - 76), hl
	lea	hl, iy + 0
	call	__ineg
	ld	(ix - 58), hl
	lea	hl, iy + 0
	inc	hl
	ld	(ix - 61), hl
	add	iy, iy
	inc	iy
	ld	(ix - 37), iy
	ld	bc, 15
	.local	.LBB18_22
.LBB18_22:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB18_26 Depth 5
                                        ;             Child Loop BB18_28 Depth 6
	push	bc
	pop	hl
	ld	de, 0
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	m, .LBB18_36
; %bb.23:                               ;   in Loop: Header=BB18_22 Depth=4
	ld	a, (_player_r)
	ld	l, a
	ld	a, (_player_c)
	ld	e, a
	ld	(ix - 40), bc
	ld	bc, (ix - 52)
	push	bc
	ld	bc, (ix - 49)
	push	bc
	ld	bc, (ix - 43)
	push	bc
	push	de
	push	hl
	call	_draw_static_board_cell
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 40)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	de, 1
	push	de
	pop	iy
	jr	nz, .LBB18_25
	.local	.LBB18_24
.LBB18_24:                              ; %.loopexit
                                        ;   in Loop: Header=BB18_22 Depth=4
	ld	hl, (ix - 43)
	push	hl
	push	hl
	ld	hl, (ix - 55)
	push	hl
	ld	hl, (ix - 46)
	push	hl
	push	iy
	call	_gfx_BlitRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 31
	push	hl
	call	_delay
	pop	hl
	ld	bc, (ix - 40)
	dec	bc
	jr	.LBB18_22
	.local	.LBB18_25
.LBB18_25:                              ;   in Loop: Header=BB18_22 Depth=4
	ld	de, (ix - 58)
	.local	.LBB18_26
.LBB18_26:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ;         Parent Loop BB18_22 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB18_28 Depth 6
	push	de
	pop	hl
	ld	bc, (ix - 61)
	or	a, a
	sbc	hl, bc
	jr	z, .LBB18_24
; %bb.27:                               ;   in Loop: Header=BB18_26 Depth=5
	push	de
	pop	hl
	push	de
	pop	bc
	call	__imulu
	ld	(ix - 82), hl
	ld	hl, (ix - 64)
	ld	(ix - 79), de
	add	hl, de
	ld	(ix - 91), hl
	add	hl, hl
	add	hl, hl
	ld	bc, 12
	call	__iand
	ld	(ix - 88), hl
	ld	de, (ix - 37)
	ld	bc, (ix - 58)
	.local	.LBB18_28
.LBB18_28:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ;         Parent Loop BB18_22 Depth=4
                                        ;           Parent Loop BB18_26 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	sbc	hl, hl
	adc	hl, de
	jr	z, .LBB18_35
; %bb.29:                               ;   in Loop: Header=BB18_28 Depth=6
	ld	(ix - 85), de
	push	bc
	pop	hl
	call	__imulu
	ld	de, (ix - 82)
	add	hl, de
	ex	de, hl
	ld	hl, (ix - 67)
	or	a, a
	sbc	hl, de
	jr	c, .LBB18_34
; %bb.30:                               ;   in Loop: Header=BB18_28 Depth=6
	ld	iy, (ix - 73)
	add	iy, bc
	lea	hl, iy + 0
	ld	(ix - 94), bc
	ld	bc, 3
	call	__iand
	ld	bc, (ix - 88)
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, _bayer4
	add	hl, bc
	ld	bc, (ix - 94)
	ld	a, (hl)
	ld	hl, (ix - 40)
	cp	a, l
	jr	nc, .LBB18_34
; %bb.31:                               ;   in Loop: Header=BB18_28 Depth=6
	ld	(ix - 97), iy
	ld	hl, (ix - 76)
	or	a, a
	sbc	hl, de
	ld	a, 0
	ld	l, a
	jr	c, .LBB18_33
; %bb.32:                               ;   in Loop: Header=BB18_28 Depth=6
	ld	a, 15
	ld	l, a
	.local	.LBB18_33
.LBB18_33:                              ;   in Loop: Header=BB18_28 Depth=6
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 91)
	push	hl
	ld	hl, (ix - 97)
	push	hl
	call	_gfx_SetPixel
	pop	hl
	pop	hl
	ld	bc, (ix - 94)
	.local	.LBB18_34
.LBB18_34:                              ;   in Loop: Header=BB18_28 Depth=6
	inc	bc
	ld	hl, (ix - 85)
	dec	hl
	ld	de, 1
	push	de
	pop	iy
	ex	de, hl
	jr	.LBB18_28
	.local	.LBB18_35
.LBB18_35:                              ;   in Loop: Header=BB18_26 Depth=5
	ld	de, (ix - 79)
	inc	de
	jp	.LBB18_26
	.local	.LBB18_36
.LBB18_36:                              ;   in Loop: Header=BB18_3 Depth=3
	pea	ix - 34
	pea	ix - 31
	pea	ix - 28
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 28)
	ld	a, (_level_w)
	ld	iy, 0
	lea	bc, iy + 0
	ld	c, a
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 40), hl
	ld	a, (_level_h)
	lea	bc, iy + 0
	ld	c, a
	ex	de, hl
	call	__imulu
	ld	(ix - 37), hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, (ix - 34)
	ld	(ix - 49), hl
	ld	de, (ix - 37)
	add	hl, de
	ld	(ix - 43), hl
	ld	hl, (ix - 31)
	ld	(ix - 46), hl
	ld	bc, 0
	.local	.LBB18_37
.LBB18_37:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB18_39 Depth 5
	push	bc
	pop	hl
	ld	de, 16
	or	a, a
	sbc	hl, de
	jp	z, .LBB18_42
; %bb.38:                               ;   in Loop: Header=BB18_37 Depth=4
	ld	hl, _fade_line_order
	ld	(ix - 52), bc
	add	hl, bc
	ld	l, (hl)
	ld	de, 0
	ld	e, l
	ld	bc, (ix - 49)
	push	bc
	pop	iy
	add	iy, de
	ld	a, c
	add	a, l
	ld	l, a
	ld	(ix - 37), hl
	.local	.LBB18_39
.LBB18_39:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ;         Parent Loop BB18_37 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	lea	hl, iy + 0
	ld	de, (ix - 43)
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB18_41
; %bb.40:                               ;   in Loop: Header=BB18_39 Depth=5
	ld	hl, 1
	push	hl
	ld	hl, (ix - 40)
	push	hl
	push	iy
	ld	hl, (ix - 46)
	push	hl
	ld	(ix - 55), iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	ld	de, (ix - 40)
	push	de
	ld	de, (ix - 37)
	push	de
	ld	de, (ix - 46)
	push	de
	push	hl
	call	_gfx_BlitRectangle
	ld	iy, (ix - 55)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, 16
	add	iy, de
	ld	l, e
	ld	de, (ix - 37)
	ld	a, e
	add	a, l
	ld	e, a
	ld	(ix - 37), de
	jr	.LBB18_39
	.local	.LBB18_41
.LBB18_41:                              ;   in Loop: Header=BB18_37 Depth=4
	ld	hl, 31
	push	hl
	call	_delay
	pop	hl
	ld	bc, (ix - 52)
	inc	bc
	jp	.LBB18_37
	.local	.LBB18_42
.LBB18_42:                              ;   in Loop: Header=BB18_3 Depth=3
	call	_engine_reset
	call	_render_game_frame_offset
	pea	ix - 34
	pea	ix - 31
	pea	ix - 28
	call	_board_geometry
	pop	hl
	pop	hl
	pop	hl
	ld	de, (ix - 28)
	ld	a, (_level_w)
	ld	iy, 0
	lea	bc, iy + 0
	ld	c, a
	push	de
	pop	hl
	call	__imulu
	ld	(ix - 40), hl
	ld	a, (_level_h)
	lea	bc, iy + 0
	ld	c, a
	ex	de, hl
	call	__imulu
	ld	de, (ix - 34)
	ld	(ix - 43), de
	add	hl, de
	ld	(ix - 37), hl
	ld	hl, (ix - 31)
	ld	(ix - 46), hl
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	.local	.LBB18_43
.LBB18_43:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB18_45 Depth 5
	push	bc
	pop	hl
	ld	de, 16
	or	a, a
	sbc	hl, de
	jp	z, .LBB18_3
; %bb.44:                               ;   in Loop: Header=BB18_43 Depth=4
	ld	hl, _fade_line_order
	ld	(ix - 49), bc
	add	hl, bc
	ld	l, (hl)
	ld	de, 0
	ld	e, l
	ld	bc, (ix - 43)
	push	bc
	pop	iy
	add	iy, de
	.local	.LBB18_45
.LBB18_45:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_3 Depth=3
                                        ;         Parent Loop BB18_43 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	ld	a, c
	add	a, l
	ld	c, a
	lea	hl, iy + 0
	ld	de, (ix - 37)
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB18_47
; %bb.46:                               ;   in Loop: Header=BB18_45 Depth=5
	ld	hl, 1
	push	hl
	ld	de, (ix - 40)
	push	de
	push	bc
	ld	de, (ix - 46)
	push	de
	push	hl
	ld	(ix - 52), iy
	ld	(ix - 55), bc
	call	_gfx_BlitRectangle
	ld	bc, (ix - 55)
	ld	iy, (ix - 52)
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, 16
	add	iy, de
	ld	l, e
	jr	.LBB18_45
	.local	.LBB18_47
.LBB18_47:                              ;   in Loop: Header=BB18_43 Depth=4
	ld	hl, 31
	push	hl
	call	_delay
	pop	hl
	ld	bc, (ix - 49)
	inc	bc
	jr	.LBB18_43
	.local	.LBB18_48
.LBB18_48:                              ;   in Loop: Header=BB18_2 Depth=2
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, 12
	add	hl, de
	ld	bc, 13
	call	__idivu
	ex	de, hl
	ld	l, -2
	ld	(ix - 112), de
	ld	a, e
	add	a, l
	ld	l, a
	ld	(ix - 113), l
	call	_wait_release
	ld	a, 1
	ld	(ix - 40), a                    ; 1-byte Folded Spill
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	(ix - 37), hl
	dec	a
	ld	c, a
	.local	.LBB18_49
.LBB18_49:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB18_50 Depth 4
                                        ;           Child Loop BB18_64 Depth 5
                                        ;             Child Loop BB18_66 Depth 6
                                        ;               Child Loop BB18_73 Depth 7
	ld	de, 0
	ld	e, c
	ld	b, d
	ld	(ix - 94), c
	ld	(ix - 93), b
	ld	l, c
	ld	h, b
	ld.sis	bc, -13
	call	__smulu
	ld	(ix - 82), l
	ld	(ix - 81), h
	ld	(ix - 91), de
	ex	de, hl
	ld	bc, 13
	call	__imulu
	ex	de, hl
	ld	hl, _solution
	add	hl, de
	ld	(ix - 85), hl
	ld	c, 22
	ld	b, (ix - 40)                    ; 1-byte Folded Reload
	.local	.LBB18_50
.LBB18_50:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_49 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB18_64 Depth 5
                                        ;             Child Loop BB18_66 Depth 6
                                        ;               Child Loop BB18_73 Depth 7
	ld	(ix - 58), a                    ; 1-byte Folded Spill
	or	a, a
	ld	a, -1
	ld	l, 2
	jr	z, .LBB18_52
; %bb.51:                               ;   in Loop: Header=BB18_50 Depth=4
	ld	a, 0
	.local	.LBB18_52
.LBB18_52:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	e, l
	ld	(ix - 40), de
	jp	nz, .LBB18_54
; %bb.53:                               ;   in Loop: Header=BB18_50 Depth=4
	ld	e, 24
                                        ; kill: def $e killed $e def $ude
	ld	(ix - 40), de
	.local	.LBB18_54
.LBB18_54:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	e, l
	ld	(ix - 43), de
	jr	nz, .LBB18_56
; %bb.55:                               ;   in Loop: Header=BB18_50 Depth=4
	ld	e, c
	ld	(ix - 43), de
	.local	.LBB18_56
.LBB18_56:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	e, 0
                                        ; kill: def $e killed $e def $ude
	ld	(ix - 46), de
	jr	nz, .LBB18_58
; %bb.57:                               ;   in Loop: Header=BB18_50 Depth=4
	ld	e, c
	ld	(ix - 46), de
	.local	.LBB18_58
.LBB18_58:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	e, 24
                                        ; kill: def $e killed $e def $ude
	ld	(ix - 49), de
	jr	nz, .LBB18_60
; %bb.59:                               ;   in Loop: Header=BB18_50 Depth=4
	ld	e, l
	ld	(ix - 49), de
	.local	.LBB18_60
.LBB18_60:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	e, c
	ld	(ix - 52), de
	jp	nz, .LBB18_62
; %bb.61:                               ;   in Loop: Header=BB18_50 Depth=4
                                        ; kill: def $l killed $l def $uhl
	ld	(ix - 52), hl
	.local	.LBB18_62
.LBB18_62:                              ;   in Loop: Header=BB18_50 Depth=4
	bit	0, a
	ld	l, c
	ld	(ix - 55), hl
	jr	nz, .LBB18_64
; %bb.63:                               ;   in Loop: Header=BB18_50 Depth=4
	xor	a, a
	ld	l, a
	ld	(ix - 55), hl
	.local	.LBB18_64
.LBB18_64:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_49 Depth=3
                                        ;         Parent Loop BB18_50 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB18_66 Depth 6
                                        ;               Child Loop BB18_73 Depth 7
	ld	(ix - 64), iy
	bit	0, b
	jp	z, .LBB18_83
; %bb.65:                               ;   in Loop: Header=BB18_64 Depth=5
	call	_render_game_frame_offset
	ld	hl, _solution_len
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	push	de
	ld	hl, _.str.12.92
	push	hl
	ld	hl, (ix - 70)
	push	hl
	call	_sprintf
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 24
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 156
	push	hl
	ld	hl, 276
	push	hl
	ld	hl, 42
	push	hl
	ld	hl, 22
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 156
	push	hl
	ld	hl, 276
	push	hl
	ld	hl, 42
	push	hl
	ld	hl, 22
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 154
	push	hl
	ld	hl, 274
	push	hl
	ld	hl, 43
	push	hl
	ld	hl, 23
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, _.str.3.52
	push	hl
	call	_gfx_GetStringWidth
	push	hl
	pop	iy
	pop	hl
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	call	__ishrs_1
	ex	de, hl
	ld	hl, 160
	or	a, a
	sbc	hl, de
	ld	de, 53
	push	de
	push	hl
	ld	hl, _.str.3.52
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, (ix - 70)
	push	hl
	call	_gfx_GetStringWidth
	push	hl
	pop	iy
	pop	hl
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	call	__ishrs_1
	ex	de, hl
	ld	hl, 160
	or	a, a
	sbc	hl, de
	ld	de, 78
	push	de
	push	hl
	ld	hl, (ix - 70)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 28
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 60
	push	hl
	ld	hl, 256
	push	hl
	ld	hl, 92
	push	hl
	ld	hl, 32
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 60
	push	hl
	ld	hl, 256
	push	hl
	ld	hl, 92
	push	hl
	ld	hl, 32
	push	hl
	call	_gfx_Rectangle
	ld	de, 2
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 85)
	ld	(ix - 67), hl
	ld	l, (ix - 82)
	ld	h, (ix - 81)
	ld	(ix - 73), l
	ld	(ix - 72), h
	ld	bc, 0
	.local	.LBB18_66
.LBB18_66:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_49 Depth=3
                                        ;         Parent Loop BB18_50 Depth=4
                                        ;           Parent Loop BB18_64 Depth=5
                                        ; =>          This Loop Header: Depth=6
                                        ;               Child Loop BB18_73 Depth 7
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jp	z, .LBB18_82
; %bb.67:                               ;   in Loop: Header=BB18_66 Depth=6
	push	bc
	pop	hl
	ld	de, (ix - 91)
	add	hl, de
	ld	(ix - 61), bc
	ld	bc, 13
	call	__imulu
	ex	de, hl
	ld	hl, _solution_len
	ld	iy, (hl)
	ld	bc, 0
	ld	c, iyl
	ld	b, iyh
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB18_82
; %bb.68:                               ;   in Loop: Header=BB18_66 Depth=6
	ld	(ix - 76), iy
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	ld	e, l
	ld	d, h
	ld.sis	bc, 13
	or	a, a
	sbc.sis	hl, bc
	jr	c, .LBB18_70
; %bb.69:                               ;   in Loop: Header=BB18_66 Depth=6
	ld.sis	de, 13
	.local	.LBB18_70
.LBB18_70:                              ;   in Loop: Header=BB18_66 Depth=6
	ex.sis	de, hl
	ld.sis	bc, 18
	call	__smulu
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	de, -5
	add.sis	iy, de
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add.sis	hl, hl
	sbc.sis	hl, hl
	ld	c, 15
	call	__sshru
	ex.sis	de, hl
	add.sis	iy, de
	ld	d, iyh
	ld	e, iyl
	sra	d
	rr	e
	ld.sis	hl, 160
	or	a, a
	sbc.sis	hl, de
	ex.sis	de, hl
	ld	hl, (ix - 61)
	ld	bc, 24
	call	__imulu
	push	hl
	pop	iy
	ld	bc, 98
	call	__ior
	ld	(ix - 103), hl
	lea	hl, iy + 0
	ld	bc, 104
	add	hl, bc
	ld	(ix - 97), hl
	lea	hl, iy + 0
	ld	bc, 110
	add	hl, bc
	ld	(ix - 106), hl
	lea	hl, iy + 0
	ld	bc, 103
	call	__ior
	ld	(ix - 109), hl
	ld	c, (ix - 73)
	ld	b, (ix - 72)
	ld	iy, (ix - 76)
	add.sis	iy, bc
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 79), hl
	ld	bc, 13
	sbc	hl, bc
	jr	c, .LBB18_72
; %bb.71:                               ;   in Loop: Header=BB18_66 Depth=6
	ld	hl, 13
	ld	(ix - 79), hl
	.local	.LBB18_72
.LBB18_72:                              ;   in Loop: Header=BB18_66 Depth=6
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 76), hl
	ld	iy, (ix - 67)
	ld	(ix - 88), iy
	ld	de, 2
	ld	bc, (ix - 61)
	ld	hl, (ix - 79)
	.local	.LBB18_73
.LBB18_73:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ;       Parent Loop BB18_49 Depth=3
                                        ;         Parent Loop BB18_50 Depth=4
                                        ;           Parent Loop BB18_64 Depth=5
                                        ;             Parent Loop BB18_66 Depth=6
                                        ; =>            This Inner Loop Header: Depth=7
	ld	(ix - 79), hl
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	z, .LBB18_81
; %bb.74:                               ;   in Loop: Header=BB18_73 Depth=7
	ld	hl, (ix - 88)
	ld	a, (hl)
	ld	l, 3
	and	a, l
	ld	l, a
	ld	(ix - 100), l
	ld	hl, 3
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, 0
	ld	e, (ix - 100)                   ; 1-byte Folded Reload
	ld	hl, JTI18_0
	add	hl, de
	add	hl, de
	add	hl, de
	ld	hl, (hl)
	jp	(hl)
	.local	.LBB18_75
.LBB18_75:                              ;   in Loop: Header=BB18_73 Depth=7
	ld	bc, (ix - 76)
	push	bc
	pop	iy
	ld	de, 6
	add	iy, de
	push	bc
	pop	hl
	ld	de, 12
	add	hl, de
	ld	de, (ix - 97)
	push	de
	push	hl
	push	de
	push	bc
	ld	hl, (ix - 103)
	push	hl
	push	iy
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 76)
	ld	de, 5
	add	hl, de
	ld	de, 7
	push	de
	ld	de, 3
	push	de
	ld	de, (ix - 97)
	jr	.LBB18_77
	.local	.LBB18_76
.LBB18_76:                              ;   in Loop: Header=BB18_73 Depth=7
	ld	bc, (ix - 76)
	push	bc
	pop	iy
	ld	de, 6
	add	iy, de
	push	bc
	pop	hl
	ld	de, 12
	add	hl, de
	ld	de, (ix - 97)
	push	de
	push	hl
	push	de
	push	bc
	ld	hl, (ix - 106)
	push	hl
	push	iy
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 76)
	ld	de, 5
	add	hl, de
	ld	de, 7
	push	de
	ld	de, 3
	push	de
	ld	de, (ix - 103)
	.local	.LBB18_77
.LBB18_77:                              ;   in Loop: Header=BB18_73 Depth=7
	push	de
	jr	.LBB18_80
	.local	.LBB18_78
.LBB18_78:                              ;   in Loop: Header=BB18_73 Depth=7
	ld	bc, (ix - 76)
	push	bc
	pop	iy
	ld	de, 6
	add	iy, de
	ld	(ix - 100), iy
	ld	hl, (ix - 106)
	push	hl
	push	iy
	ld	hl, (ix - 103)
	push	hl
	push	iy
	ld	hl, (ix - 97)
	push	hl
	ld	(ix - 76), bc
	push	bc
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 3
	push	hl
	ld	hl, 7
	push	hl
	ld	hl, (ix - 109)
	push	hl
	ld	hl, (ix - 100)
	jr	.LBB18_80
	.local	.LBB18_79
.LBB18_79:                              ;   in Loop: Header=BB18_73 Depth=7
	ld	hl, (ix - 76)
	push	hl
	pop	iy
	ld	de, 12
	add	iy, de
	ld	de, 6
	add	hl, de
	ld	de, (ix - 106)
	push	de
	push	hl
	ld	de, (ix - 103)
	push	de
	push	hl
	ld	hl, (ix - 97)
	push	hl
	push	iy
	call	_gfx_FillTriangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 3
	push	hl
	ld	hl, 7
	push	hl
	ld	hl, (ix - 109)
	push	hl
	ld	hl, (ix - 76)
	.local	.LBB18_80
.LBB18_80:                              ;   in Loop: Header=BB18_73 Depth=7
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	de, 18
	ld	hl, (ix - 76)
	add	hl, de
	ld	(ix - 76), hl
	ld	hl, (ix - 88)
	inc	hl
	ld	(ix - 88), hl
	ld	hl, (ix - 79)
	dec	hl
	ld	de, 2
	ld	iy, (ix - 67)
	ld	bc, (ix - 61)
	jp	.LBB18_73
	.local	.LBB18_81
.LBB18_81:                              ;   in Loop: Header=BB18_66 Depth=6
	inc	bc
	ld	(ix - 61), bc
	ld	l, (ix - 73)
	ld	h, (ix - 72)
	ld.sis	bc, -13
	add.sis	hl, bc
	ld	bc, (ix - 61)
	lea	iy, iy + 13
	ld	(ix - 67), iy
	ld	(ix - 73), l
	ld	(ix - 72), h
	jp	.LBB18_66
	.local	.LBB18_82
.LBB18_82:                              ;   in Loop: Header=BB18_64 Depth=5
	ld	hl, (ix - 40)
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 27
	push	hl
	ld	hl, 108
	push	hl
	ld	hl, 160
	push	hl
	ld	hl, 42
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 43)
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 27
	push	hl
	ld	hl, 108
	push	hl
	ld	hl, 160
	push	hl
	ld	hl, 42
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 46)
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 170
	push	hl
	ld	hl, 56
	push	hl
	ld	hl, _.str.13.93
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 49)
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 27
	push	hl
	ld	hl, 108
	push	hl
	ld	hl, 160
	push	hl
	ld	hl, 170
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 52)
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 27
	push	hl
	ld	hl, 108
	push	hl
	ld	hl, 160
	push	hl
	ld	hl, 170
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 55)
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 170
	push	hl
	ld	hl, 204
	push	hl
	ld	hl, _.str.14.94
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	.local	.LBB18_83
.LBB18_83:                              ;   in Loop: Header=BB18_64 Depth=5
	call	_kb_Scan
	ld	hl, -720866
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	iy, 0
	lea	de, iy + 0
	ld	e, l
	ld	d, h
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	hl, (ix - 37)
	call	__inot
	push	hl
	pop	bc
	push	de
	pop	hl
	call	__iand
	ld	a, l
	bit	1, a
	jr	nz, .LBB18_88
; %bb.84:                               ;   in Loop: Header=BB18_64 Depth=5
	ld	a, l
	bit	2, a
	jr	nz, .LBB18_89
; %bb.85:                               ;   in Loop: Header=BB18_64 Depth=5
	ld	a, l
	bit	3, a
	jr	nz, .LBB18_90
; %bb.86:                               ;   in Loop: Header=BB18_64 Depth=5
	ld	bc, 1
	call	__iand
	bit	0, l
	jr	nz, .LBB18_95
; %bb.87:                               ;   in Loop: Header=BB18_64 Depth=5
	ld	hl, (ix - 64)
	call	__inot
	call	__iand
	lea	bc, iy + 0
	call	__iand
	bit	0, l
	ld	a, 0
	ld	b, a
	ld	(ix - 37), de
	jp	z, .LBB18_64
	jp	.LBB18_96
	.local	.LBB18_88
.LBB18_88:                              ;   in Loop: Header=BB18_50 Depth=4
	ld	a, 1
	ld	b, a
	ld	(ix - 37), de
	dec	a
	ld	c, 22
	jp	.LBB18_50
	.local	.LBB18_89
.LBB18_89:                              ;   in Loop: Header=BB18_50 Depth=4
	ld	a, 1
	ld	b, a
	ld	(ix - 37), de
	ld	c, 22
	jp	.LBB18_50
	.local	.LBB18_90
.LBB18_90:                              ;   in Loop: Header=BB18_49 Depth=3
	ld	c, (ix - 94)
	ld	b, (ix - 93)
	ld	a, c
	sub	a, 1
	ld	l, 0
	jr	c, .LBB18_92
; %bb.91:                               ;   in Loop: Header=BB18_49 Depth=3
	ld	l, a
	.local	.LBB18_92
.LBB18_92:                              ;   in Loop: Header=BB18_49 Depth=3
	ld	a, c
	or	a, a
	ld	a, -1
	jr	nz, .LBB18_94
; %bb.93:                               ;   in Loop: Header=BB18_49 Depth=3
	ld	a, 0
	.local	.LBB18_94
.LBB18_94:                              ;   in Loop: Header=BB18_49 Depth=3
	ld	(ix - 40), a
	ld	(ix - 37), de
	ld	c, l
	ld	a, (ix - 58)                    ; 1-byte Folded Reload
	jp	.LBB18_49
	.local	.LBB18_95
.LBB18_95:                              ;   in Loop: Header=BB18_49 Depth=3
	ld	l, (ix - 94)
	ld	h, (ix - 93)
	ld	a, l
	ld	l, (ix - 113)
	cp	a, l
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	l, a
	ld	bc, (ix - 112)
	ld	a, c
	ld	c, (ix - 94)
	ld	b, (ix - 93)
	cp	a, 3
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	and	a, l
	ld	h, a
	ld	l, 1
	ld	(ix - 40), h                    ; 1-byte Folded Spill
	ld	a, h
	and	a, l
	ld	l, a
	ld	a, c
	add	a, l
	ld	c, a
	ld	(ix - 37), de
	ld	a, (ix - 58)                    ; 1-byte Folded Reload
	jp	.LBB18_49
	.local	.LBB18_96
.LBB18_96:                              ;   in Loop: Header=BB18_2 Depth=2
	call	_wait_release
	ld	a, (ix - 58)                    ; 1-byte Folded Reload
	or	a, a
	jp	nz, .LBB18_2
; %bb.97:                               ;   in Loop: Header=BB18_2 Depth=2
	call	_engine_reset
	call	_draw_game_frame
	ld	hl, 120
	push	hl
	call	_delay
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	.local	.LBB18_98
.LBB18_98:                              ;   Parent Loop BB18_1 Depth=1
                                        ;     Parent Loop BB18_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ld	hl, _solution_len
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jp	nc, .LBB18_2
; %bb.99:                               ;   in Loop: Header=BB18_98 Depth=3
	ld	hl, _solution
	ld	(ix - 37), bc
	add	hl, bc
	ld	a, (hl)
	ld	l, a
	push	hl
	call	_engine_move
	pop	hl
	cp	a, 2
	jr	z, .LBB18_103
; %bb.100:                              ;   in Loop: Header=BB18_98 Depth=3
	cp	a, 3
	jp	z, .LBB18_1
; %bb.101:                              ;   in Loop: Header=BB18_98 Depth=3
	ld	hl, 10
	push	hl
	call	_delay
	pop	hl
	ld	bc, (ix - 37)
	inc	bc
	jr	.LBB18_98
	.local	.LBB18_102
.LBB18_102:
	call	_wait_release
	jr	.LBB18_105
	.local	.LBB18_103
.LBB18_103:
	call	_draw_game_frame
	.local	.LBB18_104
.LBB18_104:
	call	_level_complete_wait
	.local	.LBB18_105
.LBB18_105:
	xor	a, a
	ld	(_in_game), a
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end18
.Lfunc_end18:
	.size	_play_level, .Lfunc_end18-_play_level
	.section	.rodata._play_level,"a",@progbits
JTI18_0:
	d24	.LBB18_75
	d24	.LBB18_79
	d24	.LBB18_76
	d24	.LBB18_78
                                        ; -- End function
	.section	.text._editor_level_valid,"ax",@progbits
	.type	_editor_level_valid,@function   ; -- Begin function editor_level_valid
_editor_level_valid:                    ; @editor_level_valid
; %bb.0:
	ld	hl, -1
	call	__frameset
	xor	a, a
	ld	bc, 0
	ld	de, 196
	ld	(ix - 1), a                     ; 1-byte Folded Spill
	.local	.LBB19_1
.LBB19_1:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	push	de
	pop	iy
	or	a, a
	sbc	hl, de
	jr	z, .LBB19_9
; %bb.2:                                ;   in Loop: Header=BB19_1 Depth=1
	ld	e, a
	ld	hl, (ix + 6)
	add	hl, bc
	ld	l, (hl)
	ld	a, l
	dec	a
	cp	a, 21
	jr	nc, .LBB19_14
; %bb.3:                                ;   in Loop: Header=BB19_1 Depth=1
	ld	a, l
	cp	a, 3
	jr	nz, .LBB19_5
; %bb.4:                                ;   in Loop: Header=BB19_1 Depth=1
	ld	a, e
	inc	a
	jr	.LBB19_8
	.local	.LBB19_5
.LBB19_5:                               ;   in Loop: Header=BB19_1 Depth=1
	ld	a, l
	cp	a, 15
	jr	nz, .LBB19_7
; %bb.6:                                ;   in Loop: Header=BB19_1 Depth=1
	inc	(ix - 1)
	.local	.LBB19_7
.LBB19_7:                               ;   in Loop: Header=BB19_1 Depth=1
	ld	a, e
	.local	.LBB19_8
.LBB19_8:                               ;   in Loop: Header=BB19_1 Depth=1
	inc	bc
	lea	de, iy + 0
	jr	.LBB19_1
	.local	.LBB19_9
.LBB19_9:
	or	a, a
	ld	l, -1
	ld	h, 0
	ld	c, l
	jr	nz, .LBB19_11
; %bb.10:
	ld	c, h
	.local	.LBB19_11
.LBB19_11:
	ld	a, (ix - 1)                     ; 1-byte Folded Reload
	cp	a, 1
	jr	z, .LBB19_13
; %bb.12:
	ld	l, h
	.local	.LBB19_13
.LBB19_13:
	ld	a, l
	and	a, c
	ld	l, a
	jr	.LBB19_15
	.local	.LBB19_14
.LBB19_14:
	ld	l, 0
	.local	.LBB19_15
.LBB19_15:                              ; %.loopexit
	ld	a, l
	inc	sp
	pop	ix
	ret
	.local	.Lfunc_end19
.Lfunc_end19:
	.size	_editor_level_valid, .Lfunc_end19-_editor_level_valid
                                        ; -- End function
	.section	.text._edit_slot,"ax",@progbits
	.type	_edit_slot,@function            ; -- Begin function edit_slot
_edit_slot:                             ; @edit_slot
; %bb.0:
	ld	hl, -239
	call	__frameset
	ld	a, (ix + 6)
	cp	a, 8
	jp	nc, .LBB20_60
; %bb.1:
	ld	bc, -202
	lea	iy, ix + 0
	add	iy, bc
	lea	de, iy + 0
	ld	iy, 0
	lea	hl, iy + 0
	ld	l, a
	ld	bc, 196
	push	ix
	lea	ix, ix - 128
	ld	(ix - 104), hl
	pop	ix
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _editor_cells
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 108), de
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 101), hl
	pop	ix
	ld	bc, 196
	ldir
	ld	a, (_editor_valid_mask)
	ld	iyl, a
	ld	hl, 1
	ld	c, (ix + 6)
	call	__ishl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 79), hl
	pop	ix
	lea	bc, iy + 0
	call	__iand
	ld	de, -239
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	a, l
	or	a, a
	jp	nz, .LBB20_12
; %bb.2:                                ; %.preheader8.preheader
	ld	de, 0
	ld	bc, 196
	.local	.LBB20_3
.LBB20_3:                               ; %.preheader8
                                        ; =>This Inner Loop Header: Depth=1
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	z, .LBB20_5
; %bb.4:                                ;   in Loop: Header=BB20_3 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 101)
	pop	ix
	add	iy, de
	ld	(iy), 1
	inc	de
	jr	.LBB20_3
	.local	.LBB20_5
.LBB20_5:
	ld	iy, 182
	ld	bc, 0
	.local	.LBB20_6
.LBB20_6:                               ; %.preheader7
                                        ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	ld	de, 14
	or	a, a
	sbc	hl, de
	jr	z, .LBB20_8
; %bb.7:                                ;   in Loop: Header=BB20_6 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 101)
	pop	ix
	add	hl, bc
	ld	(hl), 2
	lea	de, iy + 0
	add	hl, de
	ld	(hl), 2
	inc	bc
	jr	.LBB20_6
	.local	.LBB20_8
.LBB20_8:
	ld	de, 0
	ld	bc, 196
	.local	.LBB20_9
.LBB20_9:                               ; %.preheader6
                                        ; =>This Inner Loop Header: Depth=1
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	z, .LBB20_11
; %bb.10:                               ;   in Loop: Header=BB20_9 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 101)
	pop	ix
	add	iy, de
	ld	(iy), 2
	ld	(iy + 13), 2
	ex	de, hl
	ld	de, 14
	add	hl, de
	ex	de, hl
	jr	.LBB20_9
	.local	.LBB20_11
.LBB20_11:
	ld	de, -229
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pop	iy
	ld	de, 169
	add	iy, de
	ld	(iy), 15
	push	hl
	pop	iy
	ld	(iy + 26), 3
	.local	.LBB20_12
.LBB20_12:
	ld	a, 2
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	ld	l, 46
	ld	de, -204
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	ld	l, 12
	ld	de, -212
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	call	_wait_release
	ld	de, -232
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pop	de
	inc	de
	ld	bc, -226
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	bc, -207
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -233
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	ld	bc, 196
	call	__imulu
	ex	de, hl
	ld	hl, _editor_cells
	add	hl, de
	ld	de, -223
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	a, 1
	ld	l, a
	.local	.LBB20_13
.LBB20_13:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB20_14 Depth 2
                                        ;       Child Loop BB20_15 Depth 3
                                        ;         Child Loop BB20_16 Depth 4
                                        ;         Child Loop BB20_39 Depth 4
	ld	de, -220
	.local	.LBB20_14
.LBB20_14:                              ;   Parent Loop BB20_13 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB20_15 Depth 3
                                        ;         Child Loop BB20_16 Depth 4
                                        ;         Child Loop BB20_39 Depth 4
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	.local	.LBB20_15
.LBB20_15:                              ;   Parent Loop BB20_13 Depth=1
                                        ;     Parent Loop BB20_14 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB20_16 Depth 4
                                        ;         Child Loop BB20_39 Depth 4
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_FillScreen
	pop	hl
	ld	hl, 24
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 240
	push	hl
	ld	hl, 216
	push	hl
	or	a, a
	sbc	hl, hl
	push	hl
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	xor	a, a
	ld	b, a
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, 0
	ld	a, 14
	ld	iyl, a
	.local	.LBB20_16
.LBB20_16:                              ;   Parent Loop BB20_13 Depth=1
                                        ;     Parent Loop BB20_14 Depth=2
                                        ;       Parent Loop BB20_15 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ld	c, iyl
	call	__bdivu
	push	ix
	lea	ix, ix - 128
	push	hl
	ld	l, (ix - 76)
	ld	h, (ix - 75)
	ex	(sp), hl
	pop	iy
	pop	ix
	ld	iyh, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 82), de
	pop	ix
	ex	de, hl
	ld	de, 196
	or	a, a
	sbc	hl, de
	ld	e, iyl
	ld	d, iyh
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 76
	ld	(iy + 0), e
	ld	(iy + 1), d
	jp	z, .LBB20_18
; %bb.17:                               ;   in Loop: Header=BB20_16 Depth=4
	ex.sis	de, hl
	mlt	hl
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	add	a, l
	ld	iyh, a
	ld	iyl, b
	call	__bdivu
	ld	de, 0
	push	de
	pop	hl
	ex	de, hl
	ld	e, iyh
	ex	de, hl
	ld	bc, 3
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 90), hl
	pop	ix
	ex	de, hl
	ld	l, a
	ld	bc, 15
	call	__imulu
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	push	af
	ld	a, iyl
	ld	(ix - 87), a                    ; 1-byte Folded Spill
	pop	af
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 95)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 82)
	pop	ix
	add	iy, de
	ld	a, (iy)
	ld	de, 1
	push	de
	ld	e, a
	push	de
	push	bc
	push	hl
	ld	de, -218
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_draw_raw_tile
	ld	iyl, 14
	ld	bc, -210
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	push	ix
	lea	ix, ix - 128
	ld	b, (ix - 87)                    ; 1-byte Folded Reload
	pop	ix
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	inc	de
	ld	l, 15
	push	ix
	lea	ix, ix - 128
	ld	c, (ix - 79)
	pop	ix
	ld	a, c
	add	a, l
	ld	c, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 79), c
	pop	ix
	inc	b
	jp	.LBB20_16
	.local	.LBB20_18
.LBB20_18:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	hl, 3
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	de, 0
	ld	bc, -220
	lea	iy, ix + 0
	add	iy, bc
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	e, l
	ld	bc, -207
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ex	de, hl
	ld	bc, 15
	call	__imulu
	push	hl
	pop	iy
	ld	hl, 2
	ex	de, hl
	add	iy, de
	or	a, a
	sbc	hl, hl
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 84)
	ld	d, (ix - 83)
	pop	ix
	ld	l, e
	push	ix
	lea	ix, ix - 128
	ld	(ix - 82), hl
	pop	ix
	call	__imulu
	ld	de, 14
	add	hl, de
	ld	de, 16
	push	de
	push	de
	push	hl
	push	iy
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 8
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.35.69
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 25
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.36.70
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	ld	de, -226
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_gfx_PrintUInt
	pop	hl
	pop	hl
	ld	hl, 3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	or	a, a
	sbc	hl, hl
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _tile_names
	add	hl, de
	ld	hl, (hl)
	ld	de, 47
	push	de
	ld	de, 220
	push	de
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	push	hl
	ld	hl, 18
	push	hl
	ld	hl, 65
	push	hl
	ld	hl, 252
	push	hl
	call	_draw_raw_tile
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 23
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 94
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.37.71
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 105
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.38.72
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 126
	push	hl
	ld	hl, 220
	push	hl
	ld	hl, _.str.39.73
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 137
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.40.74
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 158
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.41.75
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 169
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.42.76
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 190
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.43.77
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 201
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.44.78
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 218
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.45.79
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 229
	push	hl
	ld	hl, 224
	push	hl
	ld	hl, _.str.46.80
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	call	_kb_Scan
	ld	hl, -720866
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, -720868
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, -720878
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	iyl, e
	ld	iyh, d
	pop	de
	ld	hl, -720876
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, e
	bit	3, a
	jp	nz, .LBB20_49
; %bb.19:                               ;   in Loop: Header=BB20_15 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	(ix - 87), l
	ld	(ix - 86), h
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 90), c
	ld	(ix - 89), b
	pop	ix
	ld	l, e
	ld	h, d
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jr	nz, .LBB20_27
; %bb.20:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	a, e
	bit	1, a
	jp	nz, .LBB20_52
; %bb.21:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	a, e
	bit	2, a
	jp	nz, .LBB20_29
; %bb.22:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	a, iyl
	bit	5, a
	jp	nz, .LBB20_30
; %bb.23:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	l, -128
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 87)
	ld	d, (ix - 86)
	pop	ix
	ld	a, e
	and	a, l
	ld	l, a
	or	a, a
	jp	nz, .LBB20_33
; %bb.24:                               ;   in Loop: Header=BB20_15 Depth=3
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 90)
	ld	h, (ix - 89)
	pop	ix
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jp	nz, .LBB20_37
; %bb.25:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	a, iyl
	bit	6, a
	jp	nz, .LBB20_44
; %bb.26:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -218
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	bit	6, a
	jp	z, .LBB20_15
	jp	.LBB20_55
	.local	.LBB20_27
.LBB20_27:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -212
	.local	.LBB20_28
.LBB20_28:                              ;   in Loop: Header=BB20_15 Depth=3
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	h, 0
	inc.sis	hl
	ld.sis	bc, 14
	call	__sremu
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	(iy + 1), h
	call	_wait_release
	jp	.LBB20_15
	.local	.LBB20_29
.LBB20_29:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -220
	jr	.LBB20_28
	.local	.LBB20_30
.LBB20_30:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	ld	a, l
	cp	a, 21
	ld	a, 1
	jr	z, .LBB20_32
; %bb.31:                               ;   in Loop: Header=BB20_15 Depth=3
	inc	l
	ld	a, l
	.local	.LBB20_32
.LBB20_32:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	jr	.LBB20_36
	.local	.LBB20_33
.LBB20_33:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, 1
	ld	l, 21
	jr	z, .LBB20_35
; %bb.34:                               ;   in Loop: Header=BB20_15 Depth=3
	dec	a
	ld	l, a
	.local	.LBB20_35
.LBB20_35:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	.local	.LBB20_36
.LBB20_36:                              ;   in Loop: Header=BB20_15 Depth=3
	call	_wait_release
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	jp	.LBB20_15
	.local	.LBB20_37
.LBB20_37:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, 15
	jr	nz, .LBB20_43
; %bb.38:                               ; %.preheader.preheader
                                        ;   in Loop: Header=BB20_15 Depth=3
	ld	de, 0
	.local	.LBB20_39
.LBB20_39:                              ; %.preheader
                                        ;   Parent Loop BB20_13 Depth=1
                                        ;     Parent Loop BB20_14 Depth=2
                                        ;       Parent Loop BB20_15 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	push	de
	pop	hl
	ld	bc, 196
	or	a, a
	sbc	hl, bc
	jr	z, .LBB20_43
; %bb.40:                               ;   in Loop: Header=BB20_39 Depth=4
	ld	bc, -223
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	ld	a, (hl)
	cp	a, 15
	jr	nz, .LBB20_42
; %bb.41:                               ;   in Loop: Header=BB20_39 Depth=4
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	ld	(hl), 1
	.local	.LBB20_42
.LBB20_42:                              ;   in Loop: Header=BB20_39 Depth=4
	inc	de
	jr	.LBB20_39
	.local	.LBB20_43
.LBB20_43:                              ; %.loopexit
                                        ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -210
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, 14
	call	__imulu
	ld	bc, -207
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	add	hl, de
	ex	de, hl
	ld	bc, -232
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	ld	bc, 196
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _editor_cells
	add	hl, bc
	add	hl, de
	ld	de, -213
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	ld	(hl), a
	call	_wait_release
	jp	.LBB20_15
	.local	.LBB20_44
.LBB20_44:                              ;   in Loop: Header=BB20_15 Depth=3
	call	_wait_release
	ld	de, -229
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_editor_level_valid
	pop	hl
	bit	0, a
	jr	z, .LBB20_47
; %bb.45:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	a, (_editor_valid_mask)
	ld	de, -233
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	or	a, l
	ld	l, a
	ld	(_editor_valid_mask), a
	call	_save_editor_data
	bit	0, a
	jp	nz, .LBB20_57
; %bb.46:                               ;   in Loop: Header=BB20_15 Depth=3
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	ld	(_editor_valid_mask), a
	ld	hl, _.str.24.66
	push	hl
	ld	hl, _.str.32.83
	jr	.LBB20_48
	.local	.LBB20_47
.LBB20_47:                              ;   in Loop: Header=BB20_15 Depth=3
	ld	hl, _.str.31.82
	push	hl
	ld	hl, _.str.30.81
	.local	.LBB20_48
.LBB20_48:                              ;   in Loop: Header=BB20_15 Depth=3
	push	hl
	call	_popup_wait
	pop	hl
	pop	hl
	jp	.LBB20_15
	.local	.LBB20_49
.LBB20_49:                              ;   in Loop: Header=BB20_14 Depth=2
	ld	de, -212
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	or	a, a
	ld	a, 13
	jr	z, .LBB20_51
; %bb.50:                               ;   in Loop: Header=BB20_14 Depth=2
	dec	l
	ld	a, l
	.local	.LBB20_51
.LBB20_51:                              ;   in Loop: Header=BB20_14 Depth=2
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	call	_wait_release
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	ld	de, -212
	jp	.LBB20_14
	.local	.LBB20_52
.LBB20_52:                              ;   in Loop: Header=BB20_13 Depth=1
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	a, l
	or	a, a
	ld	a, 13
	jr	z, .LBB20_54
; %bb.53:                               ;   in Loop: Header=BB20_13 Depth=1
	dec	l
	ld	a, l
	.local	.LBB20_54
.LBB20_54:                              ;   in Loop: Header=BB20_13 Depth=1
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	call	_wait_release
	ld	de, -207
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)                     ; 1-byte Folded Reload
	jp	.LBB20_13
	.local	.LBB20_55
.LBB20_55:
	ld	bc, -229
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -236
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	ld	bc, 196
	ldir
	ld	a, (_editor_valid_mask)
	ld	l, a
	ld	bc, -239
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	a, e
	or	a, a
	jr	z, .LBB20_58
; %bb.56:
	ld	bc, -233
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	a, l
	or	a, e
	jr	.LBB20_59
	.local	.LBB20_57
.LBB20_57:
	ld	hl, _.str.34.85
	push	hl
	ld	hl, _.str.33.84
	push	hl
	call	_popup_wait
	pop	hl
	pop	hl
	jr	.LBB20_60
	.local	.LBB20_58
.LBB20_58:
	ld	e, -1
	ld	bc, -233
	lea	iy, ix + 0
	add	iy, bc
	ld	a, (iy + 0)
	xor	a, e
	ld	e, a
	ld	a, l
	and	a, e
	.local	.LBB20_59
.LBB20_59:
	ld	l, a
	ld	a, l
	ld	(_editor_valid_mask), a
	call	_wait_release
	.local	.LBB20_60
.LBB20_60:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end20
.Lfunc_end20:
	.size	_edit_slot, .Lfunc_end20-_edit_slot
                                        ; -- End function
	.section	.text._save_editor_data,"ax",@progbits
	.type	_save_editor_data,@function     ; -- Begin function save_editor_data
_save_editor_data:                      ; @save_editor_data
; %bb.0:
	ld	hl, -10
	call	__frameset
	ld	hl, _.str.27.56
	ld	de, _.str.70
	push	de
	push	hl
	call	_ti_Open
	ld	e, a
	pop	hl
	pop	hl
	or	a, a
	jr	nz, .LBB21_2
; %bb.1:
	xor	a, a
	jr	.LBB21_8
	.local	.LBB21_2
.LBB21_2:
	ld	hl, 1
	ld	bc, 6
	ld	(ix - 6), 67
	ld	(ix - 5), 82
	ld	(ix - 4), 69
	ld	(ix - 3), 68
	ld	(ix - 2), l
	ld	a, (_editor_valid_mask)
	ld	(ix - 1), a
	push	de
	push	bc
	push	hl
	pea	ix - 6
	ld	(ix - 9), de
	call	_ti_Write
	pop	de
	pop	de
	pop	de
	pop	de
	ld	de, 6
	or	a, a
	sbc	hl, de
	jr	nz, .LBB21_5
; %bb.3:
	ld	hl, _editor_cells
	ld	bc, 1568
	ld	de, (ix - 9)
	push	de
	push	bc
	ld	de, 1
	push	de
	push	hl
	call	_ti_Write
	pop	de
	pop	de
	pop	de
	pop	de
	ld	de, 1568
	or	a, a
	sbc	hl, de
	jr	z, .LBB21_6
; %bb.4:
	ld	a, 0
	jr	.LBB21_7
	.local	.LBB21_5
.LBB21_5:
	xor	a, a
	jr	.LBB21_7
	.local	.LBB21_6
.LBB21_6:
	ld	a, -1
	.local	.LBB21_7
.LBB21_7:
	ld	(ix - 10), a
	ld	hl, (ix - 9)
	push	hl
	call	_ti_Close
	pop	hl
	ld	a, (ix - 10)                    ; 1-byte Folded Reload
	.local	.LBB21_8
.LBB21_8:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end21
.Lfunc_end21:
	.size	_save_editor_data, .Lfunc_end21-_save_editor_data
                                        ; -- End function
	.section	.text._popup_wait,"ax",@progbits
	.type	_popup_wait,@function           ; -- Begin function popup_wait
_popup_wait:                            ; @popup_wait
; %bb.0:
	ld	hl, -6
	call	__frameset
	ld	hl, (ix + 6)
	ld	(ix - 6), hl
	ld	hl, (ix + 9)
	ld	(ix - 3), hl
	ld	hl, 24
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 88
	push	hl
	ld	hl, 244
	push	hl
	ld	hl, 76
	push	hl
	ld	hl, 38
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 88
	push	hl
	ld	hl, 244
	push	hl
	ld	hl, 76
	push	hl
	ld	hl, 38
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 92
	push	hl
	ld	hl, 64
	push	hl
	ld	hl, (ix - 6)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 3
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 133
	push	hl
	ld	hl, 64
	push	hl
	ld	hl, (ix - 3)
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	call	_wait_release
	.local	.LBB22_1
.LBB22_1:                               ; =>This Inner Loop Header: Depth=1
	call	_kb_AnyKey
	or	a, a
	jr	nz, .LBB22_3
; %bb.2:                                ;   in Loop: Header=BB22_1 Depth=1
	call	_kb_Scan
	jr	.LBB22_1
	.local	.LBB22_3
.LBB22_3:
	ld	sp, ix
	pop	ix
	jp	_wait_release
	.local	.Lfunc_end22
.Lfunc_end22:
	.size	_popup_wait, .Lfunc_end22-_popup_wait
                                        ; -- End function
	.section	.text._level_complete_wait,"ax",@progbits
	.type	_level_complete_wait,@function  ; -- Begin function level_complete_wait
_level_complete_wait:                   ; @level_complete_wait
; %bb.0:
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_FillScreen
	pop	hl
	ld	hl, 8
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 158
	push	hl
	ld	hl, 252
	push	hl
	ld	hl, 41
	push	hl
	ld	hl, 34
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 158
	push	hl
	ld	hl, 252
	push	hl
	ld	hl, 41
	push	hl
	ld	hl, 34
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 156
	push	hl
	ld	hl, 250
	push	hl
	ld	hl, 42
	push	hl
	ld	hl, 35
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 154
	push	hl
	ld	hl, 248
	push	hl
	ld	hl, 43
	push	hl
	ld	hl, 36
	push	hl
	call	_gfx_Rectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 78
	push	hl
	ld	hl, 48
	push	hl
	ld	hl, _.str.10.95
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 38
	push	hl
	ld	hl, 140
	push	hl
	ld	hl, 137
	push	hl
	ld	hl, 90
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 9
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 32
	push	hl
	ld	hl, 134
	push	hl
	ld	hl, 140
	push	hl
	ld	hl, 93
	push	hl
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 22
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 148
	push	hl
	ld	hl, 128
	push	hl
	ld	hl, _.str.11.96
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	call	_wait_release
	.local	.LBB23_1
.LBB23_1:                               ; =>This Inner Loop Header: Depth=1
	call	_kb_Scan
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jr	nz, .LBB23_4
; %bb.2:                                ;   in Loop: Header=BB23_1 Depth=1
	ld	hl, -720878
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, l
	bit	6, a
	jr	nz, .LBB23_4
; %bb.3:                                ;   in Loop: Header=BB23_1 Depth=1
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, l
	bit	6, a
	jr	z, .LBB23_1
	.local	.LBB23_4
.LBB23_4:
	jp	_wait_release
	.local	.Lfunc_end23
.Lfunc_end23:
	.size	_level_complete_wait, .Lfunc_end23-_level_complete_wait
                                        ; -- End function
	.section	.rodata._.str,"a",@progbits
	.balign	1
	.local	_.str
_.str:
	.asciz	"Level 1"

	.section	.rodata._level_00_cells,"a",@progbits
	.balign	1
	.local	_level_00_cells
_level_00_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\017\001\001\001\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\003\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_00_solution,"a",@progbits
	.balign	1
	.local	_level_00_solution
_level_00_solution:
	.ascii	"\001\002\003\000\001\002\003"

	.section	.rodata._.str.1,"a",@progbits
	.balign	1
	.local	_.str.1
_.str.1:
	.asciz	"Level 2"

	.section	.rodata._level_01_cells,"a",@progbits
	.balign	1
	.local	_level_01_cells
_level_01_cells:
	.ascii	"\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\017\001\001\001\001\002\003\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_01_solution,"a",@progbits
	.balign	1
	.local	_level_01_solution
_level_01_solution:
	.ascii	"\001\002\003\000\001\002\003"

	.section	.rodata._.str.2,"a",@progbits
	.balign	1
	.local	_.str.2
_.str.2:
	.asciz	"Level 3"

	.section	.rodata._level_02_cells,"a",@progbits
	.balign	1
	.local	_level_02_cells
_level_02_cells:
	.ascii	"\001\003\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\017"

	.section	.rodata._level_02_solution,"a",@progbits
	.balign	1
	.local	_level_02_solution
_level_02_solution:
	.asciz	"\000\003\000\003\000\001\000\003\002\001\000\003"

	.section	.rodata._.str.3,"a",@progbits
	.balign	1
	.local	_.str.3
_.str.3:
	.asciz	"Level 4"

	.section	.rodata._level_03_cells,"a",@progbits
	.balign	1
	.local	_level_03_cells
_level_03_cells:
	.ascii	"\001\003\002\001\001\001\001\001\001\001\001\001\001\001\002\005\001\001\001\001\001\001\001\001\002\001\001\001\001\017\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\004\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001"

	.section	.rodata._level_03_solution,"a",@progbits
	.balign	1
	.local	_level_03_solution
_level_03_solution:
	.asciz	"\002\001\002\003\002\001\002\003\000\003\000\003\000\003"

	.section	.rodata._.str.4,"a",@progbits
	.balign	1
	.local	_.str.4
_.str.4:
	.asciz	"Level 5"

	.section	.rodata._level_04_cells,"a",@progbits
	.balign	1
	.local	_level_04_cells
_level_04_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\002\001\002\001\001\001\001\003\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\005\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\017\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\004\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001"

	.section	.rodata._level_04_solution,"a",@progbits
	.balign	1
	.local	_level_04_solution
_level_04_solution:
	.asciz	"\001\002\003\002\003\000\001\002\001\002\003\000\003"

	.section	.rodata._.str.5,"a",@progbits
	.balign	1
	.local	_.str.5
_.str.5:
	.asciz	"Level 6"

	.section	.rodata._level_05_cells,"a",@progbits
	.balign	1
	.local	_level_05_cells
_level_05_cells:
	.ascii	"\001\003\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\005\001\001\001\001\001\001\001\001\002\001\002\002\002\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\004\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\017"

	.section	.rodata._level_05_solution,"a",@progbits
	.balign	1
	.local	_level_05_solution
_level_05_solution:
	.asciz	"\003\000\003\000\001\000\003\002\001\002\001\002\003\000\003\000\001\002\001\000\003\000\003"

	.section	.rodata._.str.6,"a",@progbits
	.balign	1
	.local	_.str.6
_.str.6:
	.asciz	"Level 7"

	.section	.rodata._level_06_cells,"a",@progbits
	.balign	1
	.local	_level_06_cells
_level_06_cells:
	.ascii	"\001\001\001\002\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\003\002\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\005\002\002\001\001\001\001\001\002\002\001\002\001\001\001\001\001\001\002\001\001\002\001\001\001\001\001\002\001\001\001\001\001\002\004\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\002\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\002\001"

	.section	.rodata._level_06_solution,"a",@progbits
	.balign	1
	.local	_level_06_solution
_level_06_solution:
	.ascii	"\001\002\003\002\003\000\003\002\003\002\001\000\001\002\001\000\001\000\003\002\003\000\001"

	.section	.rodata._.str.7,"a",@progbits
	.balign	1
	.local	_.str.7
_.str.7:
	.asciz	"Level 8"

	.section	.rodata._level_07_cells,"a",@progbits
	.balign	1
	.local	_level_07_cells
_level_07_cells:
	.ascii	"\001\002\001\001\001\002\002\001\001\001\001\001\001\001\001\001\001\001\002\003\001\001\001\002\001\002\001\001\001\001\001\001\001\002\001\001\001\005\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\002\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\002\001\001\001\001\001\004\002\001\001\001\002\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\002\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\017\001\001\002\001\002\001\001\001\001\001\001\001\001"

	.section	.rodata._level_07_solution,"a",@progbits
	.balign	1
	.local	_level_07_solution
_level_07_solution:
	.ascii	"\001\000\001\002\001\000\003\002\003\000\003\000\003\000\001\002\001\002\001\002\001\000\003\000\003"

	.section	.rodata._.str.8,"a",@progbits
	.balign	1
	.local	_.str.8
_.str.8:
	.asciz	"Level 9"

	.section	.rodata._level_08_cells,"a",@progbits
	.balign	1
	.local	_level_08_cells
_level_08_cells:
	.ascii	"\001\001\001\001\001\002\002\001\001\001\001\001\001\001\001\001\001\001\002\003\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\005\001\001\002\001\001\001\001\001\001\001\001\001\001\002\002\001\001\001\001\001\001\001\006\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\004\002\001\001\001\002\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\002\001\002\001\001\001\001\001\001\002\001\001\002\001\004\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\002\001\001\017\001\001\002\001\001\002\001\001\001\001\001\001\001"

	.section	.rodata._level_08_solution,"a",@progbits
	.balign	1
	.local	_level_08_solution
_level_08_solution:
	.ascii	"\001\000\001\002\001\000\003\000\003\000\001\000\001\002\001\002\001\000\003\000\003\000\003"

	.section	.rodata._.str.9,"a",@progbits
	.balign	1
	.local	_.str.9
_.str.9:
	.asciz	"Level 10"

	.section	.rodata._level_09_cells,"a",@progbits
	.balign	1
	.local	_level_09_cells
_level_09_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\001\001\001\n\001\001\001\005\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\n\001\001\001\001\001\002\001\001\001\001\001\002\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\004\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\003\001"

	.section	.rodata._level_09_solution,"a",@progbits
	.balign	1
	.local	_level_09_solution
_level_09_solution:
	.ascii	"\002\001\002\003\002\001\000\003\002\001\002"

	.section	.rodata._.str.10,"a",@progbits
	.balign	1
	.local	_.str.10
_.str.10:
	.asciz	"Level 11"

	.section	.rodata._level_10_cells,"a",@progbits
	.balign	1
	.local	_level_10_cells
_level_10_cells:
	.ascii	"\001\001\001\001\002\001\001\001\001\001\003\001\001\001\001\001\001\001\005\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\n\001\001\001\001\002\001\001\001\001\001\002\001\001\002\001\001\001\001\001\001\001\002\001\001\n\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\002\004\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_10_solution,"a",@progbits
	.balign	1
	.local	_level_10_solution
_level_10_solution:
	.asciz	"\001\002\003\002\001\002\001\000\003\000\003\000\001\002\003"

	.section	.rodata._.str.11,"a",@progbits
	.balign	1
	.local	_.str.11
_.str.11:
	.asciz	"Level 12"

	.section	.rodata._level_11_cells,"a",@progbits
	.balign	1
	.local	_level_11_cells
_level_11_cells:
	.ascii	"\001\002\002\002\001\001\001\001\001\001\002\002\002\001\002\017\001\002\001\001\001\001\001\001\002\001\001\002\002\001\n\001\001\001\001\001\001\001\001\003\001\002\002\002\001\001\001\001\001\001\001\001\001\001\002\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\005\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\n\001\005\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\004\002\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_11_solution,"a",@progbits
	.balign	1
	.local	_level_11_solution
_level_11_solution:
	.asciz	"\001\002\003\000\001\002\001\002\003\000\003\000\003\002\001\000\003\002\001"

	.section	.rodata._.str.12,"a",@progbits
	.balign	1
	.local	_.str.12
_.str.12:
	.asciz	"Level 13"

	.section	.rodata._level_12_cells,"a",@progbits
	.balign	1
	.local	_level_12_cells
_level_12_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\002\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\n\002\001\001\001\002\001\001\001\002\001\001\002\001\001\001\001\002\001\001\001\001\001\001\001\002\001\001\002\002\001\013\001\001\002\001\001\001\001\001\013\001\002\003\001\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\002\001\001\001\001\001\001\001\001\001\002\n\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_12_solution,"a",@progbits
	.balign	1
	.local	_level_12_solution
_level_12_solution:
	.ascii	"\001\002\003\002\003\000\001\000\003\002\003\002\001\000\003\002\003"

	.section	.rodata._.str.13,"a",@progbits
	.balign	1
	.local	_.str.13
_.str.13:
	.asciz	"Level 14"

	.section	.rodata._level_13_cells,"a",@progbits
	.balign	1
	.local	_level_13_cells
_level_13_cells:
	.ascii	"\002\002\002\001\001\001\002\001\001\002\001\002\001\001\003\001\002\002\001\001\017\001\002\001\001\001\n\001\002\001\005\001\001\002\001\001\001\001\002\001\001\001\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\001\001\001\001\001\001\002\001\001\001\001\001\002\001\n\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\002\013\001\001\002\001\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\001\001\001\001\001\001\001\001\004\002\001\013\001\001\001\002\001\002\001\002\001\002\002\001\001\002\001\002\001\001\001\001\002\001\001\001\001\001\002\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\001\002\001\002\001\001\002\001\002\001\001\001\002\001\001\001"

	.section	.rodata._level_13_solution,"a",@progbits
	.balign	1
	.local	_level_13_solution
_level_13_solution:
	.ascii	"\002\001\000\001\000\001\002\001\000\001\000\001\002\003\002\003\002\003\002\001\000\003\000\003\002\003\000\003\000\001\003\002\001\000\001\002\001\000\001\000\001\000\001\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003"

	.section	.rodata._.str.14,"a",@progbits
	.balign	1
	.local	_.str.14
_.str.14:
	.asciz	"Level 15"

	.section	.rodata._level_14_cells,"a",@progbits
	.balign	1
	.local	_level_14_cells
_level_14_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\n\001\001\001\017\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\002\001\001\001\001\001\001\001\001\001\001\001\002\003\f\001\001\001\002\001\001\001\001\001\001\001\001\005\002\001\001\001\f\001\001\001\n\001\001\001\001\001\001\001\001\001\002\004\001\001\001\001\001\001\001\002\001\001\001\001\002\001\001\001\001\001\001\002\001\f\001\001\001\001\f\001\001\001\002\001\001\f\001\002\001\001\001\001\002\001\001\001\f\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001"

	.section	.rodata._level_14_solution,"a",@progbits
	.balign	1
	.local	_level_14_solution
_level_14_solution:
	.asciz	"\002\001\002\003\001\000\001"

	.section	.rodata._.str.15,"a",@progbits
	.balign	1
	.local	_.str.15
_.str.15:
	.asciz	"Level 16"

	.section	.rodata._level_15_cells,"a",@progbits
	.balign	1
	.local	_level_15_cells
_level_15_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\f\001\002\001\001\001\001\001\f\001\001\001\001\002\001\001\001\f\017\f\001\001\001\f\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\f\001\002\001\001\001\001\002\001\001\001\001\001\001\001\001\001\n\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\f\002\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\004\001\001\001\n\001\001\001\002\001\001\001\001\001\f\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\005\003\f\001\001\001\001\001\001\001\001\001\f\002\001\001"

	.section	.rodata._level_15_solution,"a",@progbits
	.balign	1
	.local	_level_15_solution
_level_15_solution:
	.ascii	"\002\003\000\003\002\003\000\003\000\001\002\001"

	.section	.rodata._.str.16,"a",@progbits
	.balign	1
	.local	_.str.16
_.str.16:
	.asciz	"Level 17"

	.section	.rodata._level_16_cells,"a",@progbits
	.balign	1
	.local	_level_16_cells
_level_16_cells:
	.ascii	"\001\002\001\001\f\001\001\001\001\001\001\001\001\001\001\004\001\001\002\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\f\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\001\f\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\002\001\n\001\017\001\001\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\f\001\n\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\f\001\002\001\001\001\001\002\002\001\002\001\002\001\002\001\002\001\002\001\002\001\001\001\002\001\001\001\001\001\001\001\001\001\005\003\001\001\001\001\001\001\001\001\002\002\001\001\001\001\001\001\f\002\001\001\001\001\001\f\001\001\001\001"

	.section	.rodata._level_16_solution,"a",@progbits
	.balign	1
	.local	_level_16_solution
_level_16_solution:
	.ascii	"\001\002\003\002\003\000\002\001\000\001\002\001\002\003\002\001"

	.section	.rodata._.str.17,"a",@progbits
	.balign	1
	.local	_.str.17
_.str.17:
	.asciz	"Level 18"

	.section	.rodata._level_17_cells,"a",@progbits
	.balign	1
	.local	_level_17_cells
_level_17_cells:
	.ascii	"\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\002\f\001\001\001\001\001\001\001\f\001\001\001\001\001\002\001\001\f\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\002\001\001\013\001\001\002\001\013\001\001\001\001\001\f\001\001\005\002\001\001\001\001\001\001\001\001\001\001\001\f\001\f\002\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\f\003\f\002\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\f\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\n\001\001\n\001\001\001\002\f\001\001\f\001\001\001\001\001\001\002\001\001\001\001\001\001\001\004\001\017\002\001\001\f\001\f\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001"

	.section	.rodata._level_17_solution,"a",@progbits
	.balign	1
	.local	_level_17_solution
_level_17_solution:
	.ascii	"\000\001\002\003\000\003\002\003\000\003\002\001\000\001\002\003\000\003\002\003\000\003\000\003\002"

	.section	.rodata._.str.18,"a",@progbits
	.balign	1
	.local	_.str.18
_.str.18:
	.asciz	"Level 19"

	.section	.rodata._level_18_cells,"a",@progbits
	.balign	1
	.local	_level_18_cells
_level_18_cells:
	.ascii	"\f\001\001\001\002\001\001\002\001\001\f\001\001\f\001\002\001\001\001\002\001\001\001\004\002\001\001\001\001\001\001\002\001\001\001\001\001\001\013\001\017\002\f\002\n\f\f\001\002\001\001\001\001\001\001\001\001\001\005\002\001\001\f\001\001\001\f\001\n\001\001\001\001\001\001\001\001\001\001\001\004\002\001\001\f\001\001\001\001\001\001\001\f\001\001\001\001\f\001\001\001\001\001\001\001\001\002\f\001\001\001\001\f\001\002\001\001\001\001\001\001\001\001\002\006\001\001\001\f\001\f\001\001\001\001\002\002\f\001\f\001\001\001\001\001\001\001\002\001\001\013\001\001\001\f\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\002\f\001\001\001\001\001\f\001\001\001\001\f\001\001\001\001\001\f\001\001\001\001\003\f"

	.section	.rodata._level_18_solution,"a",@progbits
	.balign	1
	.local	_level_18_solution
_level_18_solution:
	.ascii	"\003\000\003\000\001\002\003\002\001\000\001\002\001\000\001\003\002\003\000\003\002"

	.section	.rodata._.str.19,"a",@progbits
	.balign	1
	.local	_.str.19
_.str.19:
	.asciz	"Level 20"

	.section	.rodata._level_19_cells,"a",@progbits
	.balign	1
	.local	_level_19_cells
_level_19_cells:
	.ascii	"\001\001\001\001\001\001\003\001\001\001\001\001\001\001\001\001\001\001\001\001\005\001\001\017\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\r\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\004\001\001\001\002\001\001\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_19_solution,"a",@progbits
	.balign	1
	.local	_level_19_solution
_level_19_solution:
	.asciz	"\002\002\002\002\001\002\003\003\003\003\002\001\000\003"

	.section	.rodata._.str.20,"a",@progbits
	.balign	1
	.local	_.str.20
_.str.20:
	.asciz	"Level 21"

	.section	.rodata._level_20_cells,"a",@progbits
	.balign	1
	.local	_level_20_cells
_level_20_cells:
	.ascii	"\n\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\017\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\n\001\005\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\004\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\r\001\001\001\001\002\001\003\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\002\001\001\002\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\f\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_20_solution,"a",@progbits
	.balign	1
	.local	_level_20_solution
_level_20_solution:
	.ascii	"\002\001\000\003\002\001\003\000\002\001\002\001\000\000\000\000\000\000\000\000\000\001\002"

	.section	.rodata._.str.21,"a",@progbits
	.balign	1
	.local	_.str.21
_.str.21:
	.asciz	"Level 22"

	.section	.rodata._level_21_cells,"a",@progbits
	.balign	1
	.local	_level_21_cells
_level_21_cells:
	.ascii	"\001\001\001\002\002\f\001\001\n\001\001\005\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\003\f\001\002\001\001\001\001\001\001\002\f\001\001\001\001\001\017\001\001\002\001\001\001\001\001\r\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\f\001\001\001\001\f\001\001\001\001\001\001\001\001\004\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\002\f\001\001\n\001\001\001\001\001\001\001\001\r\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\f\001\001\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\001\001\001\f\001\002\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_21_solution,"a",@progbits
	.balign	1
	.local	_level_21_solution
_level_21_solution:
	.ascii	"\001\000\001\002\003\002\001\000\003\003\003\003\003\003\000\001\000\001\000\000\000\001"

	.section	.rodata._.str.22,"a",@progbits
	.balign	1
	.local	_.str.22
_.str.22:
	.asciz	"Level 23"

	.section	.rodata._level_22_cells,"a",@progbits
	.balign	1
	.local	_level_22_cells
_level_22_cells:
	.ascii	"\001\001\001\001\002\f\002\001\f\001\001\001\001\001\001\f\001\f\001\001\001\001\001\001\001\f\001\001\f\001\002\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\002\001\001\002\f\001\r\001\f\001\001\001\r\001\001\f\001\001\004\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\002\n\001\001\001\001\001\001\001\017\001\r\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\002\001\001\001\001\001\r\001\001\001\001\001\001\001\001\f\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\001\f\001\f\001\001\001\001\f\002\001\001\r\001\001\001\001\n\001\f\001\001\001\r\001\002\001\001\001\001\005\001\001\001\001\003\001\001\002\001\001\001\f\001\001\002\001\001"

	.section	.rodata._level_22_solution,"a",@progbits
	.balign	1
	.local	_level_22_solution
_level_22_solution:
	.ascii	"\001\001\002\003\003\003\003\003\000\001\000\000\003\002\003\003\002\003\000\003\002\003\003\003\002"

	.section	.rodata._.str.23,"a",@progbits
	.balign	1
	.local	_.str.23
_.str.23:
	.asciz	"Level 24"

	.section	.rodata._level_23_cells,"a",@progbits
	.balign	1
	.local	_level_23_cells
_level_23_cells:
	.ascii	"\001\001\001\f\001\001\001\001\001\001\001\001\f\001\001\002\001\001\001\r\017\001\001\001\f\002\001\001\001\f\001\001\001\001\001\f\001\003\001\001\001\001\001\001\001\f\001\001\n\001\001\001\001\002\f\001\001\001\001\002\001\001\001\001\f\001\001\001\001\f\001\001\r\001\001\002\001\001\001\001\004\001\001\001\002\f\001\001\001\001\001\002\001\001\002\001\001\001\f\001\001\f\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\f\002\001\001\001\001\001\r\001\001\001\001\f\013\005\001\f\001\001\f\001\001\001\001\001\001\001\001\001\n\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\f\r\001\001\001\f\001\001\002\001\001\001\001\001\002\001\001\001\001\001\013"

	.section	.rodata._level_23_solution,"a",@progbits
	.balign	1
	.local	_level_23_solution
_level_23_solution:
	.asciz	"\003\003\002\002\001\002\003\000\003\000\000\000\000\000\000\000\001"

	.section	.rodata._.str.24,"a",@progbits
	.balign	1
	.local	_.str.24
_.str.24:
	.asciz	"Level 25"

	.section	.rodata._level_24_cells,"a",@progbits
	.balign	1
	.local	_level_24_cells
_level_24_cells:
	.ascii	"\f\001\001\001\f\n\001\001\001\001\001\001\001\002\001\001\f\001\001\001\001\001\001\001\f\001\001\013\001\001\001\r\001\001\001\f\001\003\001\r\002\001\f\001\001\001\001\f\001\001\001\001\f\001\f\001\002\001\001\001\001\001\001\r\017\001\001\001\001\f\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\f\002\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\f\002\001\001\001\001\002\001\001\001\005\002\001\001\001\r\001\001\001\001\f\001\f\001\001\001\001\001\r\f\001\002\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\004\001\n\001\001\001\001\f\001\001\001\001\001\001\r\001\001\001\f\001\001\001\001\001\001\f\001\001\001\002\013\001\r\001\001\001"

	.section	.rodata._level_24_solution,"a",@progbits
	.balign	1
	.local	_level_24_solution
_level_24_solution:
	.ascii	"\003\003\003\003\002\003\003\002\002\001\002\001\001\000\003"

	.section	.rodata._.str.25,"a",@progbits
	.balign	1
	.local	_.str.25
_.str.25:
	.asciz	"Level 26"

	.section	.rodata._level_25_cells,"a",@progbits
	.balign	1
	.local	_level_25_cells
_level_25_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\013\f\003\f\001\001\001\001\001\004\001\r\001\001\001\001\f\001\001\r\001\001\001\001\001\001\001\001\f\001\001\001\001\001\r\001\001\001\001\001\n\001\001\f\001\f\001\001\f\f\001\f\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\n\001\001\001\001\001\f\001\001\001\001\001\001\001\001\f\001\001\001\r\001\001\f\001\f\001\001\001\r\001\001\f\001\001\001\001\001\001\001\001\f\001\001\f\001\001\001\r\001\001\001\f\013\001\001\f\001\001\001\001\001\001\r\f\001\001\001\001\001\001\001\f\001\001\f\001\001\001\r\001\017\r\f\001\001\001\r\001\001\001\001\001\001\001\001\001\001\001\005\f\001\001\f\001\001\f\001\001\f\001\001"

	.section	.rodata._level_25_solution,"a",@progbits
	.balign	1
	.local	_level_25_solution
_level_25_solution:
	.ascii	"\003\003\003\000\000\003\000\000\003\003\000\000\001\001\002\002\002\002\002\001\001\001\001\001\001\001\001\001\001\000\000\000\003\003\003\003\002"

	.section	.rodata._.str.26,"a",@progbits
	.balign	1
	.local	_.str.26
_.str.26:
	.asciz	"Level 27"

	.section	.rodata._level_26_cells,"a",@progbits
	.balign	1
	.local	_level_26_cells
_level_26_cells:
	.ascii	"\001\001\001\001\001\f\002\001\001\001\001\001\001\001\f\001\001\f\001\002\004\001\001\001\001\002\001\f\001\001\001\001\001\001\001\002\001\001\r\001\001\001\001\001\001\001\001\001\f\f\001\001\001\013\001\001\f\001\001\f\001\001\001\001\001\r\r\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\r\n\f\f\001\001\f\f\001\001\f\f\r\f\f\005\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\f\002\001\001\001\r\001\013\001\f\001\001\002\001\001\004\001\001\001\001\001\001\001\f\001\001\001\001\002\001\001\f\001\017\001\r\001\f\001\001\001\001\f\001\001\001\006\001\001\001\001\003\001\001\n\001\r\001\001\f\001\001\f\001\001\f\001\001\001\002\001\001\f"

	.section	.rodata._level_26_solution,"a",@progbits
	.balign	1
	.local	_level_26_solution
_level_26_solution:
	.ascii	"\001\000\003\002\003\000\000\003\001\002\001\000\001\002\001\001\000\003\002\003\003\003\002\002\002\002\002\002\001"

	.section	.rodata._.str.27,"a",@progbits
	.balign	1
	.local	_.str.27
_.str.27:
	.asciz	"Level 28"

	.section	.rodata._level_27_cells,"a",@progbits
	.balign	1
	.local	_level_27_cells
_level_27_cells:
	.ascii	"\001\001\f\003\001\n\001\001\001\001\001\f\002\001\001\001\001\006\001\001\001\001\001\001\001\r\001\001\001\001\f\001\001\002\001\001\f\002\f\001\001\001\001\001\001\001\001\001\001\002\001\001\001\004\001\002\f\001\f\001\001\001\001\001\001\001\002\f\001\001\001\001\f\001\001\001\001\001\002\001\001\001\001\001\001\001\013\001\001\001\002\001\001\001\f\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\017\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\005\002\004\001\001\001\013\001\001\f\001\001\r\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\r\f\001\001\001\002\f\001\001\001\001\001\001\f\n\f\001\002\001\001\001\001\001\001\002\001\001"

	.section	.rodata._level_27_solution,"a",@progbits
	.balign	1
	.local	_level_27_solution
_level_27_solution:
	.asciz	"\002\002\003\002\001\000\003\003\003\003\003\002\003\000\002\001\000\001\000\001\000\003\002\001\000\003"

	.section	.rodata._.str.28,"a",@progbits
	.balign	1
	.local	_.str.28
_.str.28:
	.asciz	"Level 29"

	.section	.rodata._level_28_cells,"a",@progbits
	.balign	1
	.local	_level_28_cells
_level_28_cells:
	.ascii	"\001\f\f\002\001\001\001\001\001\f\001\001\002\001\001\001\001\001\001\001\r\001\001\001\001\001\004\001\001\002\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\r\001\001\001\001\001\002\001\001\001\001\001\001\001\r\001\001\001\001\001\f\001\001\f\001\f\001\001\001\001\001\001\001\n\001\001\001\001\001\001\r\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\f\001\002\001\001\001\001\001\001\001\001\013\001\001\001\001\001\r\001\017\001\013\001\001\001\f\001\001\f\001\001\001\001\f\001\001\001\f\001\f\001\001\f\001\001\001\001\002\001\001\001\f\001\f\005\001\f\002\004\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\002\f\001\001\001\f\001\001\n\001\006\003\f\001\001\001\001\001\001\001\001"

	.section	.rodata._level_28_solution,"a",@progbits
	.balign	1
	.local	_level_28_solution
_level_28_solution:
	.ascii	"\003\003\003\000\003\000\001\001\001\001\002\001\000\003\003\003\003\002\003\000\003\003\001\000\000\001"

	.section	.rodata._.str.29,"a",@progbits
	.balign	1
	.local	_.str.29
_.str.29:
	.asciz	"Level 30"

	.section	.rodata._level_29_cells,"a",@progbits
	.balign	1
	.local	_level_29_cells
_level_29_cells:
	.ascii	"\f\001\001\001\f\001\001\001\f\001\002\001\001\f\002\001\001\001\001\001\001\001\002\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\002\f\001\001\r\001\001\001\001\f\005\n\001\001\001\001\001\f\001\001\001\002\004\001\001\001\001\001\001\001\002\f\001\001\001\001\002\001\017\001\002\f\f\n\f\001\001\001\001\001\001\r\r\r\007\003\f\001\001\f\001\f\001\001\001\001\001\001\f\f\f\006\002\f\001\001\001\f\f\f\001\f\001\001\r\001\001\f\001\001\001\001\f\001\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\002\f\001\001\001\001\001\001\001\001\001\001\001\001\001\f\f\001\001\001\001\001\004\002\001\001\001\004\002\f\f\001\002\f\001\001\001\f\001\002\001\f\001"

	.section	.rodata._level_29_solution,"a",@progbits
	.balign	1
	.local	_level_29_solution
_level_29_solution:
	.ascii	"\002\002\002\002\000\001\002\003\003\003\003\002\001\000\001\000\003\003\002\001\000\001\000\003\002\003\001\002\001"

	.section	.rodata._.str.30,"a",@progbits
	.balign	1
	.local	_.str.30
_.str.30:
	.asciz	"Level 31"

	.section	.rodata._level_30_cells,"a",@progbits
	.balign	1
	.local	_level_30_cells
_level_30_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\002\001\003\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\016\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\016\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\n\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\n\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_30_solution,"a",@progbits
	.balign	1
	.local	_level_30_solution
_level_30_solution:
	.ascii	"\001\002\003\000\001\000\003"

	.section	.rodata._.str.31,"a",@progbits
	.balign	1
	.local	_.str.31
_.str.31:
	.asciz	"Level 32"

	.section	.rodata._level_31_cells,"a",@progbits
	.balign	1
	.local	_level_31_cells
_level_31_cells:
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\016\001\f\001\001\001\001\003\001\001\001\001\001\001\001\001\001\001\001\001\001\005\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\001\001\001\001\001\002\016\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\f\001\f\n\001\f\f\f\f\f\n\001\002\f\001\001\001\001\001\001\001\001\001\001\002\001\001\f\001\001\001\001\016\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\f\001\001\001\001\001\001\001\001\f\001\001\001\001\002\001\001\001\001\001\001\001\001\002\001\001\001\004\f\001\001\001\001\001\001\001\001\001\001\002\001\002\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_31_solution,"a",@progbits
	.balign	1
	.local	_level_31_solution
_level_31_solution:
	.asciz	"\001\002\001\000\003\000\001\000\003\002\001\002\003\000\001\002"

	.section	.rodata._.str.32,"a",@progbits
	.balign	1
	.local	_.str.32
_.str.32:
	.asciz	"Level 33"

	.section	.rodata._level_32_cells,"a",@progbits
	.balign	1
	.local	_level_32_cells
_level_32_cells:
	.ascii	"\017\f\f\f\f\f\001\002\001\001\001\001\001\n\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\r\001\001\001\f\001\001\001\001\001\016\002\f\001\f\f\001\001\002\001\f\f\f\f\001\001\001\001\001\001\002\f\f\001\f\f\f\f\001\001\001\n\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\002\004\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\002\f\001\001\002\001\001\001\001\001\001\001\001\001\001\004\002\016\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\f\f\f\f\f\f\001\002\001\001\001\001\001\001\002\001\001\001\001\006\001\001\001\r\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\f\003\001\001\001\001\001\001\002\001\002\001"

	.section	.rodata._level_32_solution,"a",@progbits
	.balign	1
	.local	_level_32_solution
_level_32_solution:
	.ascii	"\002\001\001\001\002\001\000\000\003\002\003\002\003\001\002\001\002\003\000\003\002\003\000\001\002\003\002"

	.section	.rodata._.str.33,"a",@progbits
	.balign	1
	.local	_.str.33
_.str.33:
	.asciz	"Level 34"

	.section	.rodata._level_33_cells,"a",@progbits
	.balign	1
	.local	_level_33_cells
_level_33_cells:
	.ascii	"\001\001\f\001\001\001\001\001\001\001\002\001\001\f\001\001\001\001\001\001\001\002\001\002\001\001\n\001\f\001\f\001\002\001\001\001\001\004\001\002\001\f\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\005\001\001\001\013\f\001\f\001\001\002\f\001\001\001\f\001\001\006\001\001\001\001\001\001\001\001\001\001\001\001\001\003\001\001\002\001\001\001\001\n\001\001\001\001\004\002\001\001\001\001\001\001\001\001\002\001\001\001\001\f\001\001\f\001\001\001\001\002\001\001\002\016\001\001\001\001\001\001\001\006\016\001\r\001\001\001\002\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\f\013\001\001\001\001\001\017\002\001\001\f\001\f"

	.section	.rodata._level_33_solution,"a",@progbits
	.balign	1
	.local	_level_33_solution
_level_33_solution:
	.ascii	"\003\000\001\000\001\003\002\001\000\003\002"

	.section	.rodata._.str.34,"a",@progbits
	.balign	1
	.local	_.str.34
_.str.34:
	.asciz	"Level 35"

	.section	.rodata._level_34_cells,"a",@progbits
	.balign	1
	.local	_level_34_cells
_level_34_cells:
	.ascii	"\f\001\f\001\001\001\013\001\n\001\001\001\001\002\002\001\001\001\001\001\001\002\001\001\001\001\001\002\f\001\002\001\f\001\004\017\004\001\f\001\001\f\002\001\001\001\001\001\016\001\001\001\001\001\001\002\f\001\f\001\001\001\001\001\001\001\002\001\001\f\f\001\f\001\001\001\001\002\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\006\001\001\003\f\001\002\001\f\001\001\001\001\n\001\001\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\f\001\f\001\001\001\001\f\005\001\002\001\001\f\f\001\f\001\001\001\001\001\002\r\001\002\001\002\002\001\001\001\001\f\001\001\001\001\001\001\001\f\f\001\002\001\001\001\016\r\001\f\002\001\001\002\002\001\001\001\013\001\001\001\001\001\001\001\001\002"

	.section	.rodata._level_34_solution,"a",@progbits
	.balign	1
	.local	_level_34_solution
_level_34_solution:
	.ascii	"\002\001\002\001\002\001\002\003\003\003\002\003\002\001"

	.section	.rodata._.str.35,"a",@progbits
	.balign	1
	.local	_.str.35
_.str.35:
	.asciz	"Level 36"

	.section	.rodata._level_35_cells,"a",@progbits
	.balign	1
	.local	_level_35_cells
_level_35_cells:
	.ascii	"\f\001\f\002\f\002\f\002\f\001\001\001\001\001\001\001\001\r\005\001\001\001\002\001\001\001\n\001\001\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\004\001\001\001\001\001\001\001\001\001\001\002\001\001\002\001\001\001\001\004\f\001\001\001\001\f\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\017\016\001\001\r\f\004\001\001\001\001\001\001\001\001\001\002\001\001\001\002\001\001\001\001\001\016\002\001\001\001\001\006\001\f\f\f\016\f\002\001\001\001\001\001\f\001\n\001\r\001\001\001\f\001\001\002\001\001\001\001\f\001\001\001\001\001\f\001\001\001\001\001\001\001\013\001\001\001\001\001\001\001\001\001\001\001\f\003\007\013\001\001\001\001\001\001\001\001\001\001"

	.section	.rodata._level_35_solution,"a",@progbits
	.balign	1
	.local	_level_35_solution
_level_35_solution:
	.ascii	"\002\003\000\001\001\001\000\003\000\001\002\000\003\002\000\003\003\002\002\001\002\003"

	.section	.rodata._.str.36,"a",@progbits
	.balign	1
	.local	_.str.36
_.str.36:
	.asciz	"Level 37"

	.section	.rodata._level_36_cells,"a",@progbits
	.balign	1
	.local	_level_36_cells
_level_36_cells:
	.ascii	"\f\n\f\f\f\f\002\f\f\f\f\f\002\f\f\001\001\001\002\001\001\001\001\001\002\004\001\f\001\001\001\001\001\001\001\001\002\001\001\001\001\f\f\001\001\002\005\r\001\001\006\001\r\001\001\001\f\001\001\001\001\f\f\001\001\002\001\002\001\f\f\001\001\001\001\f\f\001\001\001\001\001\001\f\017\001\016\001\001\002\013\001\001\001\001\001\001\f\002\001\001\r\001\001\001\001\001\001\001\001\001\f\001\001\002\001\001\f\007\002\001\001\001\001\002\f\001\001\001\001\001\002\001\001\001\001\001\001\007\002\001\001\001\001\001\f\001\001\001\001\001\001\016\001\001\001\001\001\002\001\001\004\002\001\001\001\001\001\001\007\004\001\f\001\001\001\f\001\001\001\001\001\013\003\002\002\f\002\002\f\f\f\f\f\f\n"

	.section	.rodata._level_36_solution,"a",@progbits
	.balign	1
	.local	_level_36_solution
_level_36_solution:
	.ascii	"\001\002\003\002\001\002\003\000\001\000\001\001\000\001\002\001\001\001\000\003\002\001\002\003\000\003\000\003\002\001\000\003\000\001\002"

	.section	.rodata._.str.37,"a",@progbits
	.balign	1
	.local	_.str.37
_.str.37:
	.asciz	"Level 38"

	.section	.rodata._level_37_cells,"a",@progbits
	.balign	1
	.local	_level_37_cells
_level_37_cells:
	.ascii	"\f\f\002\f\f\f\f\f\f\f\f\f\f\f\f\002\001\001\001\001\f\f\f\f\f\f\002\f\013\001\001\001\001\001\002\001\001\001\001\001\001\f\002\007\001\001\001\001\004\001\002\001\001\001\001\f\f\001\001\001\001\002\007\n\001\016\001\001\001\001\f\001\001\001\001\001\003\f\001\f\001\001\001\f\f\001\001\001\001\001\001\f\001\f\001\001\001\f\f\001\001\001\001\001\001\002\001\001\017\001\001\f\f\001\001\001\001\f\001\n\001\001\001\001\001\013\f\001\016\001\001\001\001\001\001\001\001\001\001\f\f\002\001\001\001\001\f\001\001\001\001\001\004\002\f\001\001\001\001\r\f\005\f\f\f\f\001\f\002\004\001\002\001\001\r\001\001\001\001\001\001\002\f\f\002\f\f\f\f\002\f\f\f\f\f\f"

	.section	.rodata._level_37_solution,"a",@progbits
	.balign	1
	.local	_level_37_solution
_level_37_solution:
	.ascii	"\003\000\001\000\003\002\001\000\003\002\003\003\000\000\003\000\001\002\001\003\002\003\001\000\003\002"

	.section	.rodata._.str.38,"a",@progbits
	.balign	1
	.local	_.str.38
_.str.38:
	.asciz	"Level 39"

	.section	.rodata._level_38_cells,"a",@progbits
	.balign	1
	.local	_level_38_cells
_level_38_cells:
	.ascii	"\001\001\001\001\024\006\003\f\002\001\001\001\001\017\f\001\001\001\f\002\f\002\f\001\001\n\001\001\001\002\006\005\001\001\001\001\001\001\001\f\001\016\f\001\r\r\001\001\001\001\002\f\001\001\001\001\001\001\001\001\013\001\002\004\001\001\001\f\001\001\001\f\001\001\f\001\001\001\001\002\001\001\r\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\002\f\001\001\001\016\001\f\f\001\001\f\001\001\001\001\001\001\001\001\002\001\013\006\024\001\001\f\001\001\001\001\f\001\001\001\004\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\f\001\f\001\f\001\f\f\001\001\001\001\001\001\001\001\001\001\001\r\001\n\001\001\001\002\001\f\001\002\001\f\001\001\f\001\001\001"

	.section	.rodata._level_38_solution,"a",@progbits
	.balign	1
	.local	_level_38_solution
_level_38_solution:
	.ascii	"\002\003\000\000\000\000\000\003\003\003\003\003\000\003\002\001\001\000\003\002\001\002\000\003\002\002\002\002\002\002\002\001"

	.section	.rodata._.str.39,"a",@progbits
	.balign	1
	.local	_.str.39
_.str.39:
	.asciz	"Level 40"

	.section	.rodata._level_39_cells,"a",@progbits
	.balign	1
	.local	_level_39_cells
_level_39_cells:
	.ascii	"\003\f\f\f\f\f\f\f\002\f\f\f\f\f\005\001\001\001\001\002\004\001\001\001\001\001\001\002\001\f\002\001\001\001\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\001\001\002\002\001\001\f\025\001\001\002\001\001\001\001\001\001\001\001\024\f\002\001\001\024\001\001\001\001\001\001\001\001\001\f\f\001\001\002\001\001\001\001\001\001\001\001\025\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\002\f\001\001\001\013\001\001\001\001\001\001\f\f\001\001\016\001\001\001\001\001\002\001\001\001\f\f\001\n\001\002\f\001\001\r\001\016\001\001\f\f\001\001\001\f\f\001\013\001\001\001\002\001\f\f\001\017\001\f\f\001\001\001\n\001\001\001\f\f\f\f\f\f\f\001\f\f\f\f\f\f\f"

	.section	.rodata._level_39_solution,"a",@progbits
	.balign	1
	.local	_level_39_solution
_level_39_solution:
	.asciz	"\000\001\003\003\002\002\002\001\000\001\000\003\002\001\000\003\001\002\003\002\001"

	.section	.rodata._.str.40,"a",@progbits
	.balign	1
	.local	_.str.40
_.str.40:
	.asciz	"Level 41"

	.section	.rodata._level_40_cells,"a",@progbits
	.balign	1
	.local	_level_40_cells
_level_40_cells:
	.ascii	"\001\001\001\001\020\021\001\001\020\021\001\001\001\020\001\001\001\001\022\023\001\001\022\023\001\001\001\022\001\020\021\001\001\001\001\001\001\001\001\001\001\001\001\022\023\001\001\020\021\001\001\001\001\001\001\001\001\001\001\001\001\022\023\001\001\001\001\001\001\001\001\001\001\001\001\020\003\001\001\020\021\001\001\001\001\020\021\001\001\022\023\001\001\022\023\001\001\001\001\022\023\001\001\001\001\001\001\001\001\001\001\001\001\020\021\001\001\001\001\001\001\001\001\020\021\001\001\022\023\001\001\020\021\020\021\001\001\022\023\001\001\001\001\001\001\022\023\022\023\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\001\001\001\001\001\020\021\001\020\001\001\001\001\001\001\001\001\001\001\022\023\001\022"

	.section	.rodata._.str.41,"a",@progbits
	.balign	1
	.local	_.str.41
_.str.41:
	.asciz	"Level 42"

	.section	.rodata._level_41_cells,"a",@progbits
	.balign	1
	.local	_level_41_cells
_level_41_cells:
	.ascii	"\023\001\005\001\001\022\023\001\001\001\001\001\001\001\001\001\001\001\001\017\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\020\021\001\n\001\001\001\001\001\f\001\001\021\001\022\023\001\001\001\001\001\001\001\001\001\001\023\001\001\001\001\f\001\f\001\f\002\f\001\f\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\001\001\005\003\001\001\001\f\n\001\002\001\001\001\001\002\f\002\001\001\001\001\001\001\f\001\001\002\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\f\002\001\001\001\005\001\020\021\f\001\001\001\001\001\001\004\002\001\001\001\022\023\001\001\001\001\002\001\001\f\001\001\001\001\001\001\f\001\001"

	.section	.rodata._level_41_solution,"a",@progbits
	.balign	1
	.local	_level_41_solution
_level_41_solution:
	.ascii	"\000\002\000\003\002\003\000\003\002\001\000\001\002\001\001"

	.section	.rodata._.str.42,"a",@progbits
	.balign	1
	.local	_.str.42
_.str.42:
	.asciz	"Level 43"

	.section	.rodata._level_42_cells,"a",@progbits
	.balign	1
	.local	_level_42_cells
_level_42_cells:
	.ascii	"\001\001\001\001\001\001\001\f\001\001\020\021\001\001\001\001\n\001\001\001\001\001\001\001\022\023\001\001\f\001\001\001\f\001\f\001\002\001\001\001\001\f\001\f\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\001\001\001\001\f\001\001\001\002\001\001\001\001\001\001\001\001\001\002\001\001\004\001\001\001\001\001\017\001\r\001\001\f\001\001\002\001\001\001\001\001\005\001\001\001\001\002\002\001\020\021\001\001\001\001\003\001\001\002\001\001\001\001\022\023\001\001\001\001\001\001\001\001\001\020\021\001\005\001\001\001\001\001\f\001\001\001\001\022\023\001\001\001\001\001\001\001\001\001\020\021\001\001\001\001\n\001\001\001\001\001\f\001\022\023\001\f\001\001\001\001\001\001"

	.section	.rodata._level_42_solution,"a",@progbits
	.balign	1
	.local	_level_42_solution
_level_42_solution:
	.ascii	"\001\001\002\001\000\000\000\000\001\002\001\000\001\002\000\001\001"

	.section	.rodata._.str.43,"a",@progbits
	.balign	1
	.local	_.str.43
_.str.43:
	.asciz	"Level 44"

	.section	.rodata._level_43_cells,"a",@progbits
	.balign	1
	.local	_level_43_cells
_level_43_cells:
	.ascii	"\001\001\002\001\022\023\001\001\001\004\002\001\002\001\001\001\001\001\001\001\001\020\023\001\001\001\001\001\002\001\f\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\020\021\001\001\001\001\002\001\001\001\001\001\001\001\022\023\001\001\002\001\001\017\001\001\f\020\f\021\001\001\001\001\001\001\001\001\001\f\001\022\002\023\001\001\f\001\001\001\001\001\001\001\021\001\001\001\001\001\001\001\n\001\001\f\001\001\023\001\001\001\001\001\001\001\001\002\001\001\001\001\001\001\001\f\001\001\001\001\r\001\001\001\001\001\001\001\001\001\001\f\001\001\001\020\021\001\001\f\021\001\n\001\005\003\001\001\001\f\023\001\001\001\023\001\001\f\001\001\001\001\001\r\001\001\001\001\001\f\001\001\001\001\001\001\001\001\001\f\001\001"

	.section	.rodata._level_43_solution,"a",@progbits
	.balign	1
	.local	_level_43_solution
_level_43_solution:
	.ascii	"\003\002\003\002\002\002\003"

	.section	.rodata._.str.44,"a",@progbits
	.balign	1
	.local	_.str.44
_.str.44:
	.asciz	"Level 45"

	.section	.rodata._level_44_cells,"a",@progbits
	.balign	1
	.local	_level_44_cells
_level_44_cells:
	.ascii	"\002\001\001\001\001\001\001\n\001\001\001\001\001\022\f\001\001\001\003\002\001\001\001\002\f\001\001\001\001\001\001\001\006\006\001\020\021\f\002\001\001\001\001\001\001\001\001\001\002\f\023\001\001\001\001\002\001\002\f\001\001\001\001\001\001\001\f\002\001\f\001\f\002\001\001\001\001\002\f\001\002\f\001\001\001\001\001\001\001\001\001\f\002\001\022\023\001\022\017\001\001\001\n\001\001\001\001\001\001\001\002\004\001\001\001\001\001\001\001\001\001\001\f\001\001\020\f\001\001\001\001\001\f\002\001\001\001\005\001\f\013\001\001\001\004\001\002\f\001\f\002\002\001\001\001\001\001\001\001\001\001\001\001\002\f\f\001\001\001\001\001\001\001\013\f\001\001\001\001\001\001\001\002\001\001\001\001\f\002\001\001\001\001\001\001\001"

	.section	.rodata._level_44_solution,"a",@progbits
	.balign	1
	.local	_level_44_solution
_level_44_solution:
	.ascii	"\001\003\002\001\002\003\001\003\000\003\002\001\002\001\000\001"

	.section	.rodata._.str.45,"a",@progbits
	.balign	1
	.local	_.str.45
_.str.45:
	.asciz	"Unused Level 47"

	.section	.rodata._level_45_cells,"a",@progbits
	.balign	1
	.local	_level_45_cells
_level_45_cells:
	.ascii	"\001\002\023\001\022\013\001\001\006\002\001\001\017\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\f\021\001\016\001\001\001\001\001\001\001\f\021\001\022\002\001\001\001\020\002\001\001\001\001\022\f\001\001\004\001\001\021\f\023\001\001\020\001\001\001\016\001\001\001\022\016\001\001\001\001\f\023\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\003\001\001\001\001\001\024\021\001\016\001\001\001\001\023\n\021\001\001\001\022\f\001\001\001\001\001\013\001\022\n\001\001\001\001\001\001\001\020\002\004\022\021\001\001\001\001\001\001\001\001\001\f\023\001\001\f\001\002\021\001\001\001\001\001\001\001\001\001\020\001\001\022\024\001\001\001\001\020\001\001\001\001\f"

	.section	.rodata._level_45_solution,"a",@progbits
	.balign	1
	.local	_level_45_solution
_level_45_solution:
	.ascii	"\002\003\002\001\002\001\000\000\000\003\001\002\001\002"

	.section	.rodata._.str.46,"a",@progbits
	.balign	1
	.local	_.str.46
_.str.46:
	.asciz	"Auto Level Example"

	.section	.rodata._level_46_cells,"a",@progbits
	.balign	1
	.local	_level_46_cells
_level_46_cells:
	.ascii	"\017\f\f\023\004\022\f\f\f\f\f\023\004\022\021\004\022\004\023\004\022\023\004\022\f\004\f\004\f\f\004\004\004\004\004\004\f\004\f\004\f\004\f\f\021\004\020\004\004\004\f\004\f\004\f\n\f\f\f\021\004\004\020\004\f\004\f\004\f\f\f\f\f\023\004\020\f\004\f\004\f\004\f\f\f\f\f\004\f\f\f\004\f\021\004\020\f\f\f\f\f\021\004\004\004\020\f\f\f\f\f\n\003\022\f\023\004\004\004\022\f\f\f\023\004\020\f\004\f\004\f\f\023\004\004\004\004\004\004\013\f\004\f\004\f\f\004\004\f\f\f\021\004\022\f\004\f\004\023\004\020\021\004\022\f\f\f\004\f\004\f\004\004\f\f\f\f\004\f\f\f\004\f\021\004\020\021\004\004\004\004\020\f\013\004\020"

	.section	.rodata._level_46_solution,"a",@progbits
	.balign	1
	.local	_level_46_solution
_level_46_solution:
	db	2

	.section	.rodata._.str.47,"a",@progbits
	.balign	1
	.local	_.str.47
_.str.47:
	.asciz	"test level 1"

	.section	.rodata._level_47_cells,"a",@progbits
	.balign	1
	.local	_level_47_cells
_level_47_cells:
	.ascii	"\002\002\002\002\002\002\002\002\002\002\002\002\002\002\025\004\004\t\004\b\004\007\004\006\004\005\004\024\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\001\001\001\002\001\001\001\002\001\001\001\001\002\024\001\002\001\001\001\002\001\001\001\002\001\001\013\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\001\001\001\002\001\001\001\002\001\001\001\001\002\013\001\002\001\001\001\002\001\001\001\002\001\001\n\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\001\001\001\002\001\001\001\002\001\001\001\001\002\n\001\002\001\001\001\002\001\001\001\002\001\001\017\002\002\002\002\002\002\002\002\002\002\002\002\002\002\003\004\004\004\004\004\004\004\004\004\004\004\004\025\002\002\002\002\002\002\002\002\002\002\002\002\002\002"

	.section	.rodata._level_47_solution,"a",@progbits
	.balign	1
	.local	_level_47_solution
_level_47_solution:
	.ascii	"\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003\000\003\002\003"

	.section	.rodata._.str.48,"a",@progbits
	.balign	1
	.local	_.str.48
_.str.48:
	.asciz	"test level 2"

	.section	.rodata._level_48_cells,"a",@progbits
	.balign	1
	.local	_level_48_cells
_level_48_cells:
	.ascii	"\002\002\002\002\002\002\002\002\002\002\002\003\002\002\002\002\002\002\002\002\002\002\002\002\002\001\002\002\002\002\002\002\002\002\002\002\002\002\002\001\002\002\001\002\002\002\002\002\002\001\001\001\002\001\002\002\021\004\002\002\002\002\002\001\001\001\002\001\002\002\022\021\004\002\002\002\002\001\001\001\002\001\002\002\002\022\021\004\002\002\002\001\t\001\r\004\001\022\002\002\022\021\006\002\002\002\002\002\002\002\002\001\002\023\001\022\004\001\001\001\022\023\001\022\005\005\002\001\001\001\022\021\001\001\001\001\001\001\001\005\002\021\001\001\001\022\021\001\001\020\001\021\001\020\017\001\001\020\002\001\002\002\002\002\002\002\001\002\002\002\002\002\002\021\001\001\001\001\001\001\020\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002"

	.section	.rodata._level_48_solution,"a",@progbits
	.balign	1
	.local	_level_48_solution
_level_48_solution:
	.asciz	"\001\003\003\001\001\001\003\000\003\003\003\002\002\002\002\001\001\000\003\002\001\001\001\001"

	.section	.rodata._cyber_logo_width,"a",@progbits
	.balign	1
	.globl	_cyber_logo_width
_cyber_logo_width:
	db	188                             ; 0xbc

	.section	.rodata._cyber_logo_height,"a",@progbits
	.balign	1
	.globl	_cyber_logo_height
_cyber_logo_height:
	db	70                              ; 0x46

	.section	.bss._level_w,"aw",@nobits
	.balign	1
	.globl	_level_w
_level_w:
	.zero	1

	.section	.bss._level_h,"aw",@nobits
	.balign	1
	.globl	_level_h
_level_h:
	.zero	1

	.section	.bss._grid,"aw",@nobits
	.balign	1
	.globl	_grid
_grid:
	.zero	400

	.section	.bss._base_grid,"aw",@nobits
	.balign	1
	.globl	_base_grid
_base_grid:
	.zero	400

	.section	.bss._blocks,"aw",@nobits
	.balign	1
	.globl	_blocks
_blocks:
	.zero	400

	.section	.bss._base_blocks,"aw",@nobits
	.balign	1
	.globl	_base_blocks
_base_blocks:
	.zero	400

	.section	.bss._start_r,"aw",@nobits
	.balign	1
	.globl	_start_r
_start_r:
	.zero	1

	.section	.bss._player_r,"aw",@nobits
	.balign	1
	.globl	_player_r
_player_r:
	.zero	1

	.section	.bss._start_c,"aw",@nobits
	.balign	1
	.globl	_start_c
_start_c:
	.zero	1

	.section	.bss._player_c,"aw",@nobits
	.balign	1
	.globl	_player_c
_player_c:
	.zero	1

	.section	.bss._coin_count,"aw",@nobits
	.balign	1
	.globl	_coin_count
_coin_count:
	.zero	1

	.section	.bss._render_r,"aw",@nobits
	.balign	1
	.local	_render_r
_render_r:
	.zero	1

	.section	.bss._render_c,"aw",@nobits
	.balign	1
	.local	_render_c
_render_c:
	.zero	1

	.section	.bss._render_pos_valid,"aw",@nobits
	.balign	1
	.local	_render_pos_valid
_render_pos_valid:
	.zero	1

	.section	.bss._anim_block_active,"aw",@nobits
	.balign	1
	.globl	_anim_block_active
_anim_block_active:
	.zero	1

	.section	.bss._in_game,"aw",@nobits
	.balign	1
	.local	_in_game
_in_game:
	.zero	1

	.section	.rodata._palette,"a",@progbits
	.balign	2
	.local	_palette
_palette:
	dw	0                               ; 0x0
	dw	13993                           ; 0x36a9
	dw	991                             ; 0x3df
	dw	32736                           ; 0x7fe0
	dw	29068                           ; 0x718c
	dw	9545                            ; 0x2549
	dw	20083                           ; 0x4e73
	dw	31436                           ; 0x7acc
	dw	273                             ; 0x111
	dw	1499                            ; 0x5db
	dw	32288                           ; 0x7e20
	dw	21535                           ; 0x541f
	dw	0                               ; 0x0
	dw	1055                            ; 0x41f
	dw	31923                           ; 0x7cb3
	dw	31744                           ; 0x7c00
	dw	22880                           ; 0x5960
	dw	26082                           ; 0x65e2
	dw	19776                           ; 0x4d40
	dw	0                               ; 0x0
	dw	16352                           ; 0x3fe0
	dw	31876                           ; 0x7c84
	dw	32767                           ; 0x7fff
	dw	19026                           ; 0x4a52
	dw	3171                            ; 0xc63
	dw	364                             ; 0x16c
	dw	6343                            ; 0x18c7
	dw	11628                           ; 0x2d6c
	dw	103                             ; 0x67
	dw	27483                           ; 0x6b5b
	dw	32767                           ; 0x7fff
	dw	31775                           ; 0x7c1f

	.section	.bss._tele_r,"aw",@nobits
	.balign	1
	.globl	_tele_r
_tele_r:
	.zero	400

	.section	.bss._tele_c,"aw",@nobits
	.balign	1
	.globl	_tele_c
_tele_c:
	.zero	400

	.section	.bss._anim_block_type,"aw",@nobits
	.balign	1
	.globl	_anim_block_type
_anim_block_type:
	.zero	1

	.section	.bss._anim_block_from_r,"aw",@nobits
	.balign	1
	.globl	_anim_block_from_r
_anim_block_from_r:
	.zero	1

	.section	.bss._anim_block_from_c,"aw",@nobits
	.balign	1
	.globl	_anim_block_from_c
_anim_block_from_c:
	.zero	1

	.section	.bss._anim_block_to_r,"aw",@nobits
	.balign	1
	.globl	_anim_block_to_r
_anim_block_to_r:
	.zero	1

	.section	.bss._anim_block_to_c,"aw",@nobits
	.balign	1
	.globl	_anim_block_to_c
_anim_block_to_c:
	.zero	1

	.section	.rodata._ramp_turn_matches.turns,"a",@progbits
	.balign	1
	.local	_ramp_turn_matches.turns
_ramp_turn_matches.turns:
	.ascii	"\377\000\003\377"
	.asciz	"\377\377\001"
	.ascii	"\003\002\377\377"
	.ascii	"\001\377\377\002"

	.section	.bss._active_name,"aw",@nobits
	.balign	1
	.local	_active_name
_active_name:
	.zero	41

	.section	.rodata._.str.49,"a",@progbits
	.balign	1
	.local	_.str.49
_.str.49:
	.asciz	"2ND"

	.section	.rodata._.str.1.50,"a",@progbits
	.balign	1
	.local	_.str.1.50
_.str.1.50:
	.asciz	"RESTART"

	.section	.bss._solution_len,"aw",@nobits
	.balign	2
	.local	_solution_len
_solution_len:
	.zero	2

	.section	.rodata._.str.2.51,"a",@progbits
	.balign	1
	.local	_.str.2.51
_.str.2.51:
	.asciz	"ALPHA"

	.section	.rodata._.str.3.52,"a",@progbits
	.balign	1
	.local	_.str.3.52
_.str.3.52:
	.asciz	"SOLVER"

	.section	.rodata._.str.4.97,"a",@progbits
	.balign	1
	.local	_.str.4.97
_.str.4.97:
	.asciz	"BUILT-IN LEVELS"

	.section	.rodata._.str.5.59,"a",@progbits
	.balign	1
	.local	_.str.5.59
_.str.5.59:
	.asciz	"LEVEL EDITOR"

	.section	.rodata._.str.6.98,"a",@progbits
	.balign	1
	.local	_.str.6.98
_.str.6.98:
	.asciz	"QUIT"

	.section	.rodata.___const.main_menu.items,"a",@progbits
	.balign	1
	.local	___const.main_menu.items
___const.main_menu.items:
	d24	_.str.4.97
	d24	_.str.5.59
	d24	_.str.6.98

	.section	.rodata._.str.7.54,"a",@progbits
	.balign	1
	.local	_.str.7.54
_.str.7.54:
	.asciz	"UP/DOWN + ENTER"

	.section	.rodata._cyber_logo,"a",@progbits
	.balign	1
	.globl	_cyber_logo
_cyber_logo:
	.ascii	"\274F\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\037\037\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\002\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\002\002\002\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\000\000\002\000\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\000\000\000\000\000\002\002\002\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\000\000\002\002\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\002\002\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\000\002\002\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\000\000\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\000\000\002\002\002\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\000\000\000\000\000\000\002\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\000\000\002\002\002\002\002\002\002\002\037\037\037\002\002\002\002\002\002\002\002\002\002\000\000\002\002\002\002\002\002\002\002\002\002\002\037\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\000\000\000\000\000\002\002\002\002\000\002\002\002\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\002\002\002\000\000\000\002\002\002\000\000\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\000\000\000\000\000\002\002\002\002\002\002\002\002\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\000\002\002\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\002\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\000\000\000\002\002\002\002\000\000\000\000\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\000\000\000\000\002\002\002\000\000\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\000\000\000\000\000\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\000\000\002\002\002\002\002\002\002\002\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\000\000\000\000\002\002\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\002\000\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\000\000\000\002\002\002\002\002\002\000\000\002\002\002\002\002\002\002\002\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\002\002\002\002\002\000\000\000\002\002\002\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\037\037\037\037\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\000\000\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\002\000\000\000\002\002\000\000\000\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\000\000\000\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\037\002\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\002\000\000\000\000\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\002\002\002\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\000\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\002\002\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\000\000\002\002\002\002\002\002\037\037\037\037\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\037\002\002\002\002\002\002\000\000\000\000\002\002\002\002\002\002\002\000\000\000\000\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\000\000\000\000\000\002\002\002\002\002\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\002\037\002\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\037\037\037\037\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\037\037\037\037\037\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\000\000\000\000\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\000\000\000\000\000\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\000\000\000\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\002\002\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\002\002\002\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037"

	.section	.rodata._.str.8.53,"a",@progbits
	.balign	1
	.local	_.str.8.53
_.str.8.53:
	.asciz	"porting this everywhere atp"

	.section	.bss._choose_builtin.sel,"aw",@nobits
	.balign	1
	.local	_choose_builtin.sel
_choose_builtin.sel:
	.zero	1

	.section	.bss._choose_builtin.view_start,"aw",@nobits
	.balign	1
	.local	_choose_builtin.view_start
_choose_builtin.view_start:
	.zero	1

	.section	.rodata._builtin_level_count,"a",@progbits
	.balign	1
	.globl	_builtin_level_count
_builtin_level_count:
	db	49                              ; 0x31

	.section	.rodata._.str.9.55,"a",@progbits
	.balign	1
	.local	_.str.9.55
_.str.9.55:
	.asciz	"LEVELS"

	.section	.rodata._builtin_levels,"a",@progbits
	.balign	2
	.globl	_builtin_levels
_builtin_levels:
	d24	_.str
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_00_cells
	dw	7                               ; 0x7
	d24	_level_00_solution
	.zero	1
	d24	_.str.1
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_01_cells
	dw	7                               ; 0x7
	d24	_level_01_solution
	.zero	1
	d24	_.str.2
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_02_cells
	dw	13                              ; 0xd
	d24	_level_02_solution
	.zero	1
	d24	_.str.3
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_03_cells
	dw	15                              ; 0xf
	d24	_level_03_solution
	.zero	1
	d24	_.str.4
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_04_cells
	dw	14                              ; 0xe
	d24	_level_04_solution
	.zero	1
	d24	_.str.5
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_05_cells
	dw	24                              ; 0x18
	d24	_level_05_solution
	.zero	1
	d24	_.str.6
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_06_cells
	dw	23                              ; 0x17
	d24	_level_06_solution
	.zero	1
	d24	_.str.7
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_07_cells
	dw	25                              ; 0x19
	d24	_level_07_solution
	.zero	1
	d24	_.str.8
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_08_cells
	dw	23                              ; 0x17
	d24	_level_08_solution
	.zero	1
	d24	_.str.9
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_09_cells
	dw	11                              ; 0xb
	d24	_level_09_solution
	.zero	1
	d24	_.str.10
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_10_cells
	dw	16                              ; 0x10
	d24	_level_10_solution
	.zero	1
	d24	_.str.11
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_11_cells
	dw	20                              ; 0x14
	d24	_level_11_solution
	.zero	1
	d24	_.str.12
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_12_cells
	dw	17                              ; 0x11
	d24	_level_12_solution
	.zero	1
	d24	_.str.13
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_13_cells
	dw	61                              ; 0x3d
	d24	_level_13_solution
	.zero	1
	d24	_.str.14
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_14_cells
	dw	8                               ; 0x8
	d24	_level_14_solution
	.zero	1
	d24	_.str.15
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_15_cells
	dw	12                              ; 0xc
	d24	_level_15_solution
	.zero	1
	d24	_.str.16
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_16_cells
	dw	16                              ; 0x10
	d24	_level_16_solution
	.zero	1
	d24	_.str.17
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_17_cells
	dw	25                              ; 0x19
	d24	_level_17_solution
	.zero	1
	d24	_.str.18
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_18_cells
	dw	21                              ; 0x15
	d24	_level_18_solution
	.zero	1
	d24	_.str.19
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_19_cells
	dw	15                              ; 0xf
	d24	_level_19_solution
	.zero	1
	d24	_.str.20
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_20_cells
	dw	23                              ; 0x17
	d24	_level_20_solution
	.zero	1
	d24	_.str.21
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_21_cells
	dw	22                              ; 0x16
	d24	_level_21_solution
	.zero	1
	d24	_.str.22
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_22_cells
	dw	25                              ; 0x19
	d24	_level_22_solution
	.zero	1
	d24	_.str.23
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_23_cells
	dw	18                              ; 0x12
	d24	_level_23_solution
	.zero	1
	d24	_.str.24
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_24_cells
	dw	15                              ; 0xf
	d24	_level_24_solution
	.zero	1
	d24	_.str.25
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_25_cells
	dw	37                              ; 0x25
	d24	_level_25_solution
	.zero	1
	d24	_.str.26
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_26_cells
	dw	29                              ; 0x1d
	d24	_level_26_solution
	.zero	1
	d24	_.str.27
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_27_cells
	dw	27                              ; 0x1b
	d24	_level_27_solution
	.zero	1
	d24	_.str.28
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_28_cells
	dw	26                              ; 0x1a
	d24	_level_28_solution
	.zero	1
	d24	_.str.29
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_29_cells
	dw	29                              ; 0x1d
	d24	_level_29_solution
	.zero	1
	d24	_.str.30
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_30_cells
	dw	7                               ; 0x7
	d24	_level_30_solution
	.zero	1
	d24	_.str.31
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_31_cells
	dw	17                              ; 0x11
	d24	_level_31_solution
	.zero	1
	d24	_.str.32
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_32_cells
	dw	27                              ; 0x1b
	d24	_level_32_solution
	.zero	1
	d24	_.str.33
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_33_cells
	dw	11                              ; 0xb
	d24	_level_33_solution
	.zero	1
	d24	_.str.34
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_34_cells
	dw	14                              ; 0xe
	d24	_level_34_solution
	.zero	1
	d24	_.str.35
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_35_cells
	dw	22                              ; 0x16
	d24	_level_35_solution
	.zero	1
	d24	_.str.36
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_36_cells
	dw	35                              ; 0x23
	d24	_level_36_solution
	.zero	1
	d24	_.str.37
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_37_cells
	dw	26                              ; 0x1a
	d24	_level_37_solution
	.zero	1
	d24	_.str.38
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_38_cells
	dw	32                              ; 0x20
	d24	_level_38_solution
	.zero	1
	d24	_.str.39
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_39_cells
	dw	22                              ; 0x16
	d24	_level_39_solution
	.zero	1
	d24	_.str.40
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_40_cells
	dw	1                               ; 0x1
	d24	_.str.47.86
	.zero	1
	d24	_.str.41
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_41_cells
	dw	15                              ; 0xf
	d24	_level_41_solution
	.zero	1
	d24	_.str.42
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_42_cells
	dw	17                              ; 0x11
	d24	_level_42_solution
	.zero	1
	d24	_.str.43
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_43_cells
	dw	7                               ; 0x7
	d24	_level_43_solution
	.zero	1
	d24	_.str.44
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_44_cells
	dw	16                              ; 0x10
	d24	_level_44_solution
	.zero	1
	d24	_.str.45
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_45_cells
	dw	14                              ; 0xe
	d24	_level_45_solution
	.zero	1
	d24	_.str.46
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_46_cells
	dw	1                               ; 0x1
	d24	_level_46_solution
	.zero	1
	d24	_.str.47
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_47_cells
	dw	37                              ; 0x25
	d24	_level_47_solution
	.zero	1
	d24	_.str.48
	db	14                              ; 0xe
	db	14                              ; 0xe
	d24	_level_48_cells
	dw	25                              ; 0x19
	d24	_level_48_solution
	.zero	1

	.section	.bss._solution,"aw",@nobits
	.balign	1
	.local	_solution
_solution:
	.zero	1024

	.section	.rodata._bayer4,"a",@progbits
	.balign	1
	.local	_bayer4
_bayer4:
	.ascii	"\000\b\002\n\f\004\016\006\003\013\001\t\017\007\r\005"

	.section	.rodata._fade_line_order,"a",@progbits
	.balign	1
	.local	_fade_line_order
_fade_line_order:
	.ascii	"\000\b\004\f\002\n\006\016\001\t\005\r\003\013\007\017"

	.section	.rodata._.str.10.95,"a",@progbits
	.balign	1
	.local	_.str.10.95
_.str.10.95:
	.asciz	"LEVEL COMPLETE"

	.section	.rodata._.str.11.96,"a",@progbits
	.balign	1
	.local	_.str.11.96
_.str.11.96:
	.asciz	"EXIT"

	.section	.rodata._.str.12.92,"a",@progbits
	.balign	1
	.local	_.str.12.92
_.str.12.92:
	.asciz	"NUMBER OF MOVES: %u"

	.section	.rodata._.str.13.93,"a",@progbits
	.balign	1
	.local	_.str.13.93
_.str.13.93:
	.asciz	"PLAY MACRO"

	.section	.rodata._.str.14.94,"a",@progbits
	.balign	1
	.local	_.str.14.94
_.str.14.94:
	.asciz	"CLOSE"

	.section	.rodata._editor_menu.actions,"a",@progbits
	.balign	1
	.local	_editor_menu.actions
_editor_menu.actions:
	d24	_.str.15.89
	d24	_.str.16.90
	d24	_.str.17.91

	.section	.rodata._.str.15.89,"a",@progbits
	.balign	1
	.local	_.str.15.89
_.str.15.89:
	.asciz	"PLAY"

	.section	.rodata._.str.16.90,"a",@progbits
	.balign	1
	.local	_.str.16.90
_.str.16.90:
	.asciz	"EDIT"

	.section	.rodata._.str.17.91,"a",@progbits
	.balign	1
	.local	_.str.17.91
_.str.17.91:
	.asciz	"DELETE"

	.section	.bss._editor_valid_mask,"aw",@nobits
	.balign	1
	.local	_editor_valid_mask
_editor_valid_mask:
	.zero	1

	.section	.rodata._.str.18.60,"a",@progbits
	.balign	1
	.local	_.str.18.60
_.str.18.60:
	.asciz	"SLOT %u"

	.section	.rodata._.str.19.61,"a",@progbits
	.balign	1
	.local	_.str.19.61
_.str.19.61:
	.asciz	"SLOT EMPTY"

	.section	.rodata._.str.20.62,"a",@progbits
	.balign	1
	.local	_.str.20.62
_.str.20.62:
	.asciz	"SLOT %u  SAVED"

	.section	.rodata._.str.21.63,"a",@progbits
	.balign	1
	.local	_.str.21.63
_.str.21.63:
	.asciz	"UP/DOWN SLOT  LEFT/RIGHT OPTION"

	.section	.rodata._.str.22.64,"a",@progbits
	.balign	1
	.local	_.str.22.64
_.str.22.64:
	.asciz	"ENTER SELECT  MODE/CLEAR BACK"

	.section	.bss._editor_cells,"aw",@nobits
	.balign	1
	.local	_editor_cells
_editor_cells:
	.zero	1568

	.section	.rodata._.str.23.65,"a",@progbits
	.balign	1
	.local	_.str.23.65
_.str.23.65:
	.asciz	"DELETE FAILED"

	.section	.rodata._.str.24.66,"a",@progbits
	.balign	1
	.local	_.str.24.66
_.str.24.66:
	.asciz	"CHECK FREE RAM"

	.section	.rodata._.str.25.67,"a",@progbits
	.balign	1
	.local	_.str.25.67
_.str.25.67:
	.asciz	"SLOT CLEARED"

	.section	.rodata._.str.26.68,"a",@progbits
	.balign	1
	.local	_.str.26.68
_.str.26.68:
	.asciz	"READY FOR NEW LEVEL"

	.section	.rodata._.str.27.56,"a",@progbits
	.balign	1
	.local	_.str.27.56
_.str.27.56:
	.asciz	"CREDITOR"

	.section	.rodata._.str.28.57,"a",@progbits
	.balign	1
	.local	_.str.28.57
_.str.28.57:
	.asciz	"r"

	.section	.rodata._.str.29.58,"a",@progbits
	.balign	1
	.local	_.str.29.58
_.str.29.58:
	.asciz	"CRED"

	.section	.rodata._.str.30.81,"a",@progbits
	.balign	1
	.local	_.str.30.81
_.str.30.81:
	.asciz	"CAN'T SAVE"

	.section	.rodata._.str.31.82,"a",@progbits
	.balign	1
	.local	_.str.31.82
_.str.31.82:
	.asciz	"NEED 1 START + GOAL"

	.section	.rodata._.str.32.83,"a",@progbits
	.balign	1
	.local	_.str.32.83
_.str.32.83:
	.asciz	"SAVE FAILED"

	.section	.rodata._.str.33.84,"a",@progbits
	.balign	1
	.local	_.str.33.84
_.str.33.84:
	.asciz	"SAVED!"

	.section	.rodata._.str.34.85,"a",@progbits
	.balign	1
	.local	_.str.34.85
_.str.34.85:
	.asciz	"LEVEL READY"

	.section	.rodata._.str.35.69,"a",@progbits
	.balign	1
	.local	_.str.35.69
_.str.35.69:
	.asciz	"EDITOR"

	.section	.rodata._.str.36.70,"a",@progbits
	.balign	1
	.local	_.str.36.70
_.str.36.70:
	.asciz	"SLOT"

	.section	.rodata._tile_names,"a",@progbits
	.balign	1
	.local	_tile_names
_tile_names:
	d24	_.str.47.86
	d24	_.str.48.87
	d24	_.str.49.88
	d24	_.str.50
	d24	_.str.51
	d24	_.str.52
	d24	_.str.53
	d24	_.str.54
	d24	_.str.55
	d24	_.str.56
	d24	_.str.57
	d24	_.str.58
	d24	_.str.59
	d24	_.str.60
	d24	_.str.61
	d24	_.str.62
	d24	_.str.63
	d24	_.str.64
	d24	_.str.65
	d24	_.str.66
	d24	_.str.67
	d24	_.str.68

	.section	.rodata._.str.37.71,"a",@progbits
	.balign	1
	.local	_.str.37.71
_.str.37.71:
	.asciz	"ARROWS"

	.section	.rodata._.str.38.72,"a",@progbits
	.balign	1
	.local	_.str.38.72
_.str.38.72:
	.asciz	"CURSOR"

	.section	.rodata._.str.39.73,"a",@progbits
	.balign	1
	.local	_.str.39.73
_.str.39.73:
	.asciz	"2ND/ALPHA"

	.section	.rodata._.str.40.74,"a",@progbits
	.balign	1
	.local	_.str.40.74
_.str.40.74:
	.asciz	"TILE +/-"

	.section	.rodata._.str.41.75,"a",@progbits
	.balign	1
	.local	_.str.41.75
_.str.41.75:
	.asciz	"ENTER"

	.section	.rodata._.str.42.76,"a",@progbits
	.balign	1
	.local	_.str.42.76
_.str.42.76:
	.asciz	"PAINT"

	.section	.rodata._.str.43.77,"a",@progbits
	.balign	1
	.local	_.str.43.77
_.str.43.77:
	.asciz	"MODE"

	.section	.rodata._.str.44.78,"a",@progbits
	.balign	1
	.local	_.str.44.78
_.str.44.78:
	.asciz	"SAVE"

	.section	.rodata._.str.45.79,"a",@progbits
	.balign	1
	.local	_.str.45.79
_.str.45.79:
	.asciz	"CLEAR"

	.section	.rodata._.str.46.80,"a",@progbits
	.balign	1
	.local	_.str.46.80
_.str.46.80:
	.asciz	"CANCEL"

	.section	.rodata._.str.47.86,"a",@progbits
	.balign	1
	.local	_.str.47.86
_.str.47.86:
	.zero	1

	.section	.rodata._.str.48.87,"a",@progbits
	.balign	1
	.local	_.str.48.87
_.str.48.87:
	.asciz	"FLOOR"

	.section	.rodata._.str.49.88,"a",@progbits
	.balign	1
	.local	_.str.49.88
_.str.49.88:
	.asciz	"WALL"

	.section	.rodata._.str.50,"a",@progbits
	.balign	1
	.local	_.str.50
_.str.50:
	.asciz	"GOAL"

	.section	.rodata._.str.51,"a",@progbits
	.balign	1
	.local	_.str.51
_.str.51:
	.asciz	"COIN"

	.section	.rodata._.str.52,"a",@progbits
	.balign	1
	.local	_.str.52
_.str.52:
	.asciz	"GATE 1"

	.section	.rodata._.str.53,"a",@progbits
	.balign	1
	.local	_.str.53
_.str.53:
	.asciz	"GATE 2"

	.section	.rodata._.str.54,"a",@progbits
	.balign	1
	.local	_.str.54
_.str.54:
	.asciz	"GATE 3"

	.section	.rodata._.str.55,"a",@progbits
	.balign	1
	.local	_.str.55
_.str.55:
	.asciz	"GATE 4"

	.section	.rodata._.str.56,"a",@progbits
	.balign	1
	.local	_.str.56
_.str.56:
	.asciz	"GATE 5"

	.section	.rodata._.str.57,"a",@progbits
	.balign	1
	.local	_.str.57
_.str.57:
	.asciz	"ORANGE TP"

	.section	.rodata._.str.58,"a",@progbits
	.balign	1
	.local	_.str.58
_.str.58:
	.asciz	"PURPLE TP"

	.section	.rodata._.str.59,"a",@progbits
	.balign	1
	.local	_.str.59
_.str.59:
	.asciz	"VOID"

	.section	.rodata._.str.60,"a",@progbits
	.balign	1
	.local	_.str.60
_.str.60:
	.asciz	"BLUE BLOCK"

	.section	.rodata._.str.61,"a",@progbits
	.balign	1
	.local	_.str.61
_.str.61:
	.asciz	"PINK BLOCK"

	.section	.rodata._.str.62,"a",@progbits
	.balign	1
	.local	_.str.62
_.str.62:
	.asciz	"START"

	.section	.rodata._.str.63,"a",@progbits
	.balign	1
	.local	_.str.63
_.str.63:
	.asciz	"RAMP NW"

	.section	.rodata._.str.64,"a",@progbits
	.balign	1
	.local	_.str.64
_.str.64:
	.asciz	"RAMP NE"

	.section	.rodata._.str.65,"a",@progbits
	.balign	1
	.local	_.str.65
_.str.65:
	.asciz	"RAMP SW"

	.section	.rodata._.str.66,"a",@progbits
	.balign	1
	.local	_.str.66
_.str.66:
	.asciz	"RAMP SE"

	.section	.rodata._.str.67,"a",@progbits
	.balign	1
	.local	_.str.67
_.str.67:
	.asciz	"LIME TP"

	.section	.rodata._.str.68,"a",@progbits
	.balign	1
	.local	_.str.68
_.str.68:
	.asciz	"RED TP"

	.section	.rodata._.str.69,"a",@progbits
	.balign	1
	.local	_.str.69
_.str.69:
	.asciz	"CUSTOM %u"

	.section	.rodata._.str.70,"a",@progbits
	.balign	1
	.local	_.str.70
_.str.70:
	.asciz	"w"

	.section	.rodata._switch.table.main,"a",@progbits
	.balign	1
	.local	_switch.table.main
_switch.table.main:
	.ascii	"\n\013\000\r\016\017"

	.section	.rodata._switch.table.draw_raw_tile,"a",@progbits
	.balign	1
	.local	_switch.table.draw_raw_tile
_switch.table.draw_raw_tile:
	.ascii	"\n\013\f\001\001\001\001\001\001\001\024\025"

	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.section	".note.GNU-stack","",@progbits
	.extern	_gfx_FillCircle
	.extern	_gfx_FillRectangle
	.extern	_llvm.lifetime.end.p0
	.extern	_gfx_SetPalette
	.extern	__ishru
	.extern	__Unwind_SjLj_Unregister
	.extern	__idivs
	.extern	_kb_Scan
	.extern	__sremu
	.extern	_llvm.umax.i8
	.extern	__ineg
	.extern	__ior
	.extern	_gfx_BlitRectangle
	.extern	__lsub
	.extern	_gfx_Line
	.extern	_ti_Read
	.extern	__inot
	.extern	_ti_Open
	.extern	_gfx_GetStringWidth
	.extern	_gfx_SetPixel
	.extern	__ladd
	.extern	__idivu
	.extern	_llvm.umin.i24
	.extern	_llvm.usub.sat.i8
	.extern	_llvm.eh.sjlj.lsda
	.extern	__iand
	.extern	__setflag
	.extern	_gfx_TransparentSprite
	.extern	_llvm.stacksave.p0
	.extern	_ti_Close
	.extern	_llvm.lifetime.start.p0
	.extern	_memcmp
	.extern	__bremu
	.extern	_gfx_Rectangle
	.extern	_gfx_SetTextTransparentColor
	.extern	__lshru
	.extern	_llvm.umin.i16
	.extern	_engine_move
	.extern	_llvm.eh.sjlj.functioncontext
	.extern	_memcpy
	.extern	__sdivu
	.extern	_llvm.umax.i24
	.extern	_gfx_FillScreen
	.extern	_gfx_PrintStringXY
	.extern	_llvm.umin.i8
	.extern	_gfx_SetColor
	.extern	_llvm.memset.p0.i24
	.extern	_llvm.memcpy.p0.p0.i24
	.extern	_gfx_End
	.extern	_kb_Reset
	.extern	_gfx_FillTriangle
	.extern	_llvm.eh.sjlj.setup.dispatch
	.extern	_llvm.frameaddress.p0
	.extern	__lshl
	.extern	__sand
	.extern	_llvm.stackrestore.p0
	.extern	_gfx_HorizLine
	.extern	_kb_AnyKey
	.extern	_sprintf
	.extern	__lcmpu
	.extern	_gfx_SetTextFGColor
	.extern	_gfx_SetTextScale
	.extern	_gfx_Begin
	.extern	_clock
	.extern	_strncpy
	.extern	_llvm.smax.i24
	.extern	__bdivu
	.extern	__ishru_1
	.extern	_gfx_SetTransparentColor
	.extern	__lcmps
	.extern	_gfx_SetTextBGColor
	.extern	_gfx_SwapDraw
	.extern	__sshru
	.extern	__frameset
	.extern	__ishrs_1
	.extern	__imulu
	.extern	_llvm.eh.sjlj.callsite
	.extern	_ti_Write
	.extern	__lmulu
	.extern	__frameset0
	.extern	_gfx_PrintUInt
	.extern	__Unwind_SjLj_Register
	.extern	__bshl
	.extern	__smulu
	.extern	_delay
	.extern	_gfx_SetDraw
	.extern	__ishl
