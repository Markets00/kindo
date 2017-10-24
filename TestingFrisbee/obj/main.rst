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
                              7 .globl getVideoPtr
                              8 .globl incTeam1Points
                              9 .globl incTeam2Points
                             10 
                             11 .macro defineGame name, type, map, fTime
                             12 	name'_data::
                             13 		name'_type::		.db type	;; Game Mode			(8 bits)
                             14 		name'_map::		.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             15 		name'_fTime::		.dw fTime	;; Final duration of each match	(16 bits)
                             16 		name'_t1points:: 	.db 0 		;; Points of team 1		(8 bits)
                             17 		name'_t2points:: 	.db 0 		;; Points of team 2		(8 bits)
                             18 		name'_maxPoints:: 	.db 100 	;; Quantity of points to win	(8 bits)
                             19 .endm
                             20 
                             21 ;; ====================================
                             22 ;; ====================================
                             23 ;; GAME PUBLIC DATA
                             24 ;; ====================================
                             25 ;; ====================================
                     0000    26 .equ Game_type, 	0	;; Game mode
                     0001    27 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    28 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    29 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    30 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    31 .equ Game_t1points, 	5	;; Points of team 1
                     0006    32 .equ Game_t2points, 	6	;; Points of team 2
                             33 
                     0050    34 .equ RIGHT_LIMIT,	80
                     0000    35 .equ LEFT_LIMIT,	0
                     000A    36 .equ TOP_LIMIT,	 	10
                     00C8    37 .equ BOTTOM_LIMIT,	200
                     0028    38 .equ CENTER_LIMIT,	40
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
                              9 ;; defineGame gameaux, #0, #0x0000, #0x012C
                             10 
                             11 ;; ========================
                             12 ;; Programa principal
                             13 ;; ========================
   0411                      14 _main::
   0411 31 00 80      [10]   15 	ld 	sp, #0x8000 			;; Set stack pointer to 8000 to enable double buffer
                             16 
   0414 CD 5E 06      [17]   17 	call menuStart
   0417 CD 72 06      [17]   18 	call gameStart		;; inicia una partida con los valores de game_data
                             19 
   041A 18 F5         [12]   20 	jr (_main)
