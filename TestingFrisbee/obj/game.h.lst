ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
