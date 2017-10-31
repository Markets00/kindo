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
	.db #0x5E	; 94
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x5C	; 92
	.db #0x58	; 88	'X'
	.db #0x5D	; 93
	.db #0x4C	; 76	'L'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x57	; 87	'W'
	.db #0x40	; 64
	.db #0x5F	; 95
	.db #0x52	; 82	'R'
	.db #0x42	; 66	'B'
	.db #0x4A	; 74	'J'
	.db #0x4B	; 75	'K'
_sprite_robot_1_0:
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0x6D	; 109	'm'
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4F	; 79	'O'
	.db #0x00	; 0
	.db #0xCD	; 205
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x4F	; 79	'O'
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x4F	; 79	'O'
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC3	; 195
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC3	; 195
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC3	; 195
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
_sprite_robot_1_1:
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x9E	; 158
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0xCE	; 206
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCB	; 203
	.db #0x00	; 0
	.db #0xC7	; 199
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCB	; 203
	.db #0x00	; 0
	.db #0xC3	; 195
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x0F	; 15
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
