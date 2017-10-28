;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
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
	.db #0x5C	; 92
	.db #0x58	; 88	'X'
	.db #0x45	; 69	'E'
	.db #0x56	; 86	'V'
	.db #0x46	; 70	'F'
	.db #0x5E	; 94
	.db #0x40	; 64
	.db #0x47	; 71	'G'
	.db #0x42	; 66	'B'
	.db #0x53	; 83	'S'
	.db #0x5A	; 90	'Z'
	.db #0x4A	; 74	'J'
	.db #0x43	; 67	'C'
	.db #0x4B	; 75	'K'
_sprite_robot_1_0:
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x56	; 86	'V'
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
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x3C	; 60
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x3C	; 60
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x3C	; 60
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
_sprite_robot_1_1:
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xBC	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xBC	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xFC	; 252
	.db #0xBC	; 188
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0x16	; 22
	.db #0x3C	; 60
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xFC	; 252
	.db #0xBC	; 188
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0x03	; 3
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xA9	; 169
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.db #0xFC	; 252
	.area _INITIALIZER
	.area _CABS (ABS)
