;; ====================================
;; ====================================
;; GAME PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl gameStart
.globl getVideoPtr

.macro defineGame name, type, map, fTime, t1points, t2points
	name'_data::
		name'_type::	.db type	;; Game Mode			(8 bits)
		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
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
.equ Game_t1points, 	5	;; Points of team 1
.equ Game_t2points, 	6	;; Points of team 2

.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	10
.equ BOTTOM_LIMIT,	200
.equ CENTER_LIMIT,	40