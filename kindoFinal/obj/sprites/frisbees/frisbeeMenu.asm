;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module frisbeeMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprite_frisbeeMenu_1
	.globl _sprite_frisbeeMenu_0
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
	.area _CODE
_sprite_frisbeeMenu_0:
	.db #0x9e	; 158
	.db #0x97	; 151
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0x78	; 120	'x'
	.db #0xe1	; 225
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x78	; 120	'x'
	.db #0xe1	; 225
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0x9e	; 158
	.db #0x97	; 151
_sprite_frisbeeMenu_1:
	.db #0xe8	; 232
	.db #0x71	; 113	'q'
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0x80	; 128
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x10	; 16
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xe8	; 232
	.db #0x71	; 113	'q'
	.area _INITIALIZER
	.area _CABS (ABS)
