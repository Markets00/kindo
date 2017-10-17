.area _DATA
.area _CODE

;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================
.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"

.equ Game_type, 	0	;; Game mode
.equ Game_map_L, 	1	;; Low part of pointer to game map
.equ Game_map_H, 	2	;; High part of pointer to game map
.equ Game_time_H, 	3	;; High part of match time
.equ Game_time_L, 	4	;; Low part of match time

.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	0
.equ BOTTOM_LIMIT,	200

;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================

	
;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================


;; ===================================
;; Inicia una partida dependiendo
;; 	de los atributos de game
;; Entrada:
;; 	IX => Pointer to game data 
;; Modifica IX
;; ===================================
gameStart::

	call game_loop
	ret

	
;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================

game_loop:
	call player_erase
	call frisbee_erase

	call player_update
	call frisbee_update

	call player_draw
	call frisbee_draw

	
	call cpct_waitVSYNC_asm

	jr (game_loop) 			;; Bucle infinito
	ret