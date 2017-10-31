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
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x8B	; 139
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x8B	; 139
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
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
_sprite_frisbee_1_1:
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
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x8B	; 139
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x55	; 85	'U'
	.db #0x8A	; 138
	.db #0xAA	; 170
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xAA	; 170
	.db #0x01	; 1
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x8B	; 139
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xAA	; 170
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x55	; 85	'U'
	.db #0x0A	; 10
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0B	; 11
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0xAA	; 170
	.db #0x05	; 5
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
