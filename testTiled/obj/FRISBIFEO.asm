;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module FRISBIFEO
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_FRISBIFEO_1
	.globl _g_FRISBIFEO_0
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
_g_FRISBIFEO_0:
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
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
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x3c	; 60
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x3c	; 60
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
_g_FRISBIFEO_1:
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x29	; 41
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xbc	; 188
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x7c	; 124
	.db #0xbc	; 188
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x29	; 41
	.db #0x16	; 22
	.db #0x56	; 86	'V'
	.db #0xa9	; 169
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0x16	; 22
	.db #0x29	; 41
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa9	; 169
	.db #0x56	; 86	'V'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.area _INITIALIZER
	.area _CABS (ABS)
