ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 .globl getVideoPtr
                              8 
                              9 .macro defineGame name, type, map, fTime, t1points, t2points
                             10 	name'_data::
                             11 		name'_type::	.db type	;; Game Mode			(8 bits)
                             12 		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             13 		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
                             14 		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
                             15 		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
                             16 .endm
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; GAME PUBLIC DATA
                             21 ;; ====================================
                             22 ;; ====================================
                     0000    23 .equ Game_type, 	0	;; Game mode
                     0001    24 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    25 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    26 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    27 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    28 .equ Game_t1points, 	5	;; Points of team 1
                     0006    29 .equ Game_t2points, 	6	;; Points of team 2
                             30 
                     0050    31 .equ RIGHT_LIMIT,	80
                     0000    32 .equ LEFT_LIMIT,	0
                     000A    33 .equ TOP_LIMIT,	 	10
                     00C8    34 .equ BOTTOM_LIMIT,	200
                     0028    35 .equ CENTER_LIMIT,	40
