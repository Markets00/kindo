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
                              8 .macro defineGame name, type, map, fTime
                              9 	name'_data::
                             10 		name'_type:	.db type	;; Game Mode			(8 bits)
                             11 		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime:	.dw fTime	;; Final duration of each match	(16 bits)
                             13 .endm
                             14 
                             15 ;; ====================================
                             16 ;; ====================================
                             17 ;; GAME PUBLIC DATA
                             18 ;; ====================================
                             19 ;; ====================================
                     0000    20 .equ Game_type, 	0	;; Game mode
                     0001    21 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    22 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    23 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    24 .equ Game_fTime_L, 	4	;; Low part of final match time
                             25 
                     0050    26 .equ RIGHT_LIMIT,	80
                     0000    27 .equ LEFT_LIMIT,	0
                     0000    28 .equ TOP_LIMIT,	 	0
                     00C8    29 .equ BOTTOM_LIMIT,	200
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "menu.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; MENU PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 
                              7 .globl menuStart
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                              7 
                              8 ;; .macro defineGame name, type, map, fTime
   02BE                       9 defineGame game, #0, #0x0000, #0x012C
   0000                       1 	game_data::
   02BE 00                    2 		game_type:	.db #0	;; Game Mode			(8 bits)
   02BF 00 00                 3 		game_map:	.dw #0x0000		;; Pointer to map of tiles	(16 bits little endian)
   02C1 2C 01                 4 		game_fTime:	.dw #0x012C	;; Final duration of each match	(16 bits)
                             10 
                             11 ;; .macro defineGame name, type, map, fTime
   02C3                      12 defineGame gameaux, #0, #0x0000, #0x012C
   0005                       1 	gameaux_data::
   02C3 00                    2 		gameaux_type:	.db #0	;; Game Mode			(8 bits)
   02C4 00 00                 3 		gameaux_map:	.dw #0x0000		;; Pointer to map of tiles	(16 bits little endian)
   02C6 2C 01                 4 		gameaux_fTime:	.dw #0x012C	;; Final duration of each match	(16 bits)
                             13 
                             14 ;; ========================
                             15 ;; Programa principal
                             16 ;; ========================
   02C8                      17 _main::
   02C8 DD 21 BE 02   [14]   18 	ld ix, #game_data
   02CC CD D1 03      [17]   19 	call menuStart
   02CF CD DA 03      [17]   20 	call gameStart		;; inicia una partida con los valores de game_data
                             21 
   02D2 18 F4         [12]   22 	jr (_main)
