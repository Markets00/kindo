;; ====================================
;; ====================================
;; GAME PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl gameStart

.macro defineGame name, type, map, fTime
	name'_data::
		name'_type:	.db type	;; Game Mode			(8 bits)
		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits little endian)
		name'_fTime:	.dw fTime	;; Final duration of each match	(16 bits)
.endm

;; ====================================
;; ====================================
;; GAME PUBLIC DATA
;; ====================================
;; ====================================
.equ Game_type, 	0	;; Game mode
.equ Game_map_L, 	1	;; Low part of pointer to game map
.equ Game_map_H, 	2	;; High part of pointer to game map
.equ Game_fTime_H, 	3	;; High part of final match time
.equ Game_fTime_L, 	4	;; Low part of final match time

.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	10
.equ BOTTOM_LIMIT,	200
.equ CENTER_LIMIT,	40