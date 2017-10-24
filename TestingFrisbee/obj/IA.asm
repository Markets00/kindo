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
;src/IA.c:48: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
;	---------------------------------
; Function moveIA
; ---------------------------------
_moveIA::
;src/IA.c:53: myself->ax = acc;
	pop	de
	pop	bc
	push	bc
	push	de
	ld	hl,#0x000A
	add	hl,bc
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0xFE
;src/IA.c:54: myself->ay = acc;
	ld	hl,#0x000C
	add	hl,bc
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0xFE
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
