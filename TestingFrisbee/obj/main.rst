ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 
                              8 .macro defineGame name, type, map, time
                              9 	name'_data::
                             10 		name'_type:	.db type	;; Game Mode			(8 bits)
                             11 		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits)
                             12 		name'_time:	.dw time	;; Duration of each match	(16 bits)
                             13 .endm
                             14 
                     0000    15 .equ Game_type, 	0	;; Game mode
                     0001    16 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    17 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    18 .equ Game_time_H, 	3	;; High part of match time
                     0004    19 .equ Game_time_L, 	4	;; Low part of match time
                             20 
                     0050    21 .equ RIGHT_LIMIT,	80
                     0000    22 .equ LEFT_LIMIT,	0
                     0000    23 .equ TOP_LIMIT,	 	0
                     00C8    24 .equ BOTTOM_LIMIT,	200
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "utility.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; INCLUDED CPCTELERA FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl cpct_waitVSYNC_asm
                              7 .globl cpct_drawSolidBox_asm
                              8 .globl cpct_getScreenPtr_asm
                              9 .globl cpct_scanKeyboard_asm
                             10 .globl cpct_isKeyPressed_asm
                             11 .globl cpct_disableFirmware_asm
                             12 .globl cpct_setVideoMode_asm
                             13 .globl cpct_setPalette_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                              7 
                              8 ;; .macro defineGame name, type, map, time
   029D                       9 defineGame game, #0, #0x0000, #0x012C
   0000                       1 	game_data::
   029D 00                    2 		game_type:	.db #0	;; Game Mode			(8 bits)
   029E 00 00                 3 		game_map:	.dw #0x0000		;; Pointer to map of tiles	(16 bits)
   02A0 2C 01                 4 		game_time:	.dw #0x012C	;; Duration of each match	(16 bits)
                             10 
                             11 
                             12 ;; ========================
                             13 ;; Initialize system
                             14 ;; ========================
   02A2                      15 initializeSystem:
   02A2 CD F9 03      [17]   16 	call cpct_disableFirmware_asm
                             17 
                             18 	;; Set video mode
                             19 	;; ld 	c, #0
                             20 	;; call cpct_setVideoMode_asm
                             21 
                             22 	;; Set palette
                             23 	;; ld 	hl, #direccion_paleta
                             24 	;; ld 	de, #16
                             25 	;; call cpct_setPalette_asm
                             26 
   02A5 C9            [10]   27 	ret
                             28 
                             29 ;; ========================
                             30 ;; Programa principal
                             31 ;; ========================
   02A6                      32 _main::
   02A6 CD A2 02      [17]   33 	call initializeSystem
                             34 
   02A9 DD 21 9D 02   [14]   35 	ld ix, #game_data
   02AD CD A9 03      [17]   36 	call gameStart		;; inicia una partida con los valores de game_data
