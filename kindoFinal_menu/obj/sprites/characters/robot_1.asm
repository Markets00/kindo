;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module robot_1
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprite_robot_1_1
	.globl _sprite_robot_1_0
	.globl _sprite_palette
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
_sprite_palette:
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x5c	; 92
	.db #0x58	; 88	'X'
	.db #0x45	; 69	'E'
	.db #0x56	; 86	'V'
	.db #0x46	; 70	'F'
	.db #0x5e	; 94
	.db #0x40	; 64
	.db #0x47	; 71	'G'
	.db #0x42	; 66	'B'
	.db #0x53	; 83	'S'
	.db #0x5a	; 90	'Z'
	.db #0x4a	; 74	'J'
	.db #0x43	; 67	'C'
	.db #0x4b	; 75	'K'
_sprite_robot_1_0:
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
_sprite_robot_1_1:
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.area _INITIALIZER
	.area _CABS (ABS)
