;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module IA
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _moveIA
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/IA.c:42: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
;	---------------------------------
; Function moveIA
; ---------------------------------
_moveIA::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/IA.c:44: if(myself->y_I > frisbee->y_I) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	c,(hl)
	ld	l,8 (ix)
	ld	h,9 (ix)
	inc	hl
	inc	hl
	ld	b,(hl)
;src/IA.c:45: myself->ay_I = 255;
	ld	hl,#0x000C
	add	hl,de
;src/IA.c:46: myself->ay_F = -4;
	ld	a,e
	add	a, #0x0D
	ld	e,a
	ld	a,d
	adc	a, #0x00
	ld	d,a
;src/IA.c:44: if(myself->y_I > frisbee->y_I) {
	ld	a,b
	sub	a, c
	jr	NC,00104$
;src/IA.c:45: myself->ay_I = 255;
	ld	(hl),#0xFF
;src/IA.c:46: myself->ay_F = -4;
	ld	a,#0xFC
	ld	(de),a
	jr	00106$
00104$:
;src/IA.c:47: } else if (myself->y_I < frisbee->y_I) {
	ld	a,c
	sub	a, b
	jr	NC,00106$
;src/IA.c:48: myself->ay_I = 0;
	ld	(hl),#0x00
;src/IA.c:49: myself->ay_F = 4;
	ld	a,#0x04
	ld	(de),a
00106$:
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
