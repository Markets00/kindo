ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
                     0007    33 .equ Game_max_points, 	7	;; maximum of points
                             34 
                     0050    35 .equ RIGHT_LIMIT,	80
                     0000    36 .equ LEFT_LIMIT,	0
                     000A    37 .equ TOP_LIMIT,	 	10
                     00C8    38 .equ BOTTOM_LIMIT,	200
                     0028    39 .equ CENTER_LIMIT,	40
