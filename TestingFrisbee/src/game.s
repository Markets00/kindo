.area _DATA
.area _CODE

.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"
	
;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

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
	;; Reading game data example
	;;	ld 	h, Game_type(ix)	;; H <= Game_type
	;;
	;;	ld 	h, Game_map_L(ix)
	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
	;;
	;;	ld 	h, Game_time_H(ix)
	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time

	;; Modifying game data example
	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
	;;
	;;	ld 	Game_map_L(ix), #0
	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
	;;
	;;	ld 	Game_time_H(ix), #0
	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000

	call 	initializeGame
	;; Configuration staff...
	;; Configuration staff...
	;; Configuration staff...
	call 	game_loop
	ret


;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================


;; ========================
;; Initialize game
;; ========================
initializeGame:
	call cpct_disableFirmware_asm

	;; Set video mode
	;; ld 	c, #0
	;; call cpct_setVideoMode_asm

	;; Set palette
	;; ld 	hl, #direccion_paleta
	;; ld 	de, #16
	;; call cpct_setPalette_asm

	ret


;; ============================
;; Game loop until end of game
;; ============================
game_loop:

	;; Wait VSYNC to modify VMEM without blinking
	call cpct_waitVSYNC_asm

	;; Erase entities
	call player_erase
	call frisbee_erase

	;; Update entities
	call player_update
	call frisbee_update

	;; Draw entities
	call player_draw
	call frisbee_draw

	jr (game_loop) 			;; Bucle infinito
	ret