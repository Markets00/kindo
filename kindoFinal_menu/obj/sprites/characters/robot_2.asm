;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
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
	.db #0xfc	; 252
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
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa8	; 168
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0xa1	; 161
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x29	; 41
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x57	; 87	'W'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
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
_sprite_robot_2_1:
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xa8	; 168
	.db #0x52	; 82	'R'
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x16	; 22
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x5c	; 92
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x14	; 20
	.db #0x03	; 3
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa8	; 168
	.db #0x00	; 0
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
	.db #0xa9	; 169
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.area _INITIALIZER
	.area _CABS (ABS)
