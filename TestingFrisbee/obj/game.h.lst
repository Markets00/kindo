ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 
                              8 .macro defineGame name, type, map, fTime, t1points, t2points
                              9 	name'_data::
                             10 		name'_type::	.db type	;; Game Mode			(8 bits)
                             11 		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
                             13 		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
                             14 		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
                             15 .endm
                             16 
                             17 ;; ====================================
                             18 ;; ====================================
                             19 ;; GAME PUBLIC DATA
                             20 ;; ====================================
                             21 ;; ====================================
                     0000    22 .equ Game_type, 	0	;; Game mode
                     0001    23 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    24 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    25 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    26 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    27 .equ Game_t1points, 	5	;; Points of team 1
                     0006    28 .equ Game_t2points, 	6	;; Points of team 2
                             29 
                     0050    30 .equ RIGHT_LIMIT,	80
                     0000    31 .equ LEFT_LIMIT,	0
                     000A    32 .equ TOP_LIMIT,	 	10
                     00C8    33 .equ BOTTOM_LIMIT,	200
                     0028    34 .equ CENTER_LIMIT,	40
