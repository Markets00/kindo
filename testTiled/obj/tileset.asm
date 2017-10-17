;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module tileset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_tileset_1
	.globl _g_tileset_0
	.globl _g_tileset
	.globl _g_palette
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
_g_palette:
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
_g_tileset:
	.dw _g_tileset_0
	.dw _g_tileset_1
_g_tileset_0:
	.db #0x44	; 68	'D'
	.db #0x74	; 116	't'
	.db #0xC4	; 196
	.db #0xA1	; 161
	.db #0x84	; 132
	.db #0x29	; 41
	.db #0x18	; 24
	.db #0x7C	; 124
_g_tileset_1:
	.db #0xC7	; 199
	.db #0xF7	; 247
	.db #0x93	; 147
	.db #0x7F	; 127
	.db #0xA1	; 161
	.db #0xFF	; 255
	.db #0x5F	; 95
	.db #0xFF	; 255
	.area _INITIALIZER
	.area _CABS (ABS)