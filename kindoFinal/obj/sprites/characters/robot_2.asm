;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module robot_2
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprite_robot_2_1
	.globl _sprite_robot_2_0
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
_sprite_robot_2_0:
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
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
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
	.db #0xAA	; 170
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC5	; 197
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xC5	; 197
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xC5	; 197
	.db #0x00	; 0
	.db #0x5F	; 95
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x4E	; 78	'N'
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0xC5	; 197
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
_sprite_robot_2_1:
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
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC5	; 197
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x9B	; 155
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x8B	; 139
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCA	; 202
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0x55	; 85	'U'
	.db #0xAA	; 170
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0x8F	; 143
	.db #0x55	; 85	'U'
	.db #0x88	; 136
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xCF	; 207
	.db #0x55	; 85	'U'
	.db #0x80	; 128
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xC0	; 192
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
	.area _INITIALIZER
	.area _CABS (ABS)
