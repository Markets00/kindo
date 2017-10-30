;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module frisbee_1
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprite_frisbee_1_1
	.globl _sprite_frisbee_1_0
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
_sprite_frisbee_1_0:
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x3C	; 60
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x3C	; 60
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
_sprite_frisbee_1_1:
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x29	; 41
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xBC	; 188
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x7C	; 124
	.db #0xBC	; 188
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x29	; 41
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xA9	; 169
	.db #0x3C	; 60
	.db #0x3C	; 60
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.area _INITIALIZER
	.area _CABS (ABS)
