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
.equ Game_fTime_H, 	3	;; High part of final match time
.equ Game_fTime_L, 	4	;; Low part of final match time
.equ Game_t1points, 	5	;; Points of team 1
.equ Game_t2points, 	6	;; Points of team 2

.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	10
.equ BOTTOM_LIMIT,	200
.equ CENTER_LIMIT,	40

;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================

;; .equ mi_constante0, 0
;; .equ mi_constante1, 1
	
videoPtr:	.dw 0x8000

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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Reading game data example
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;	ld 	h, Game_type(ix)	;; H <= Game_type
	;;
	;;	ld 	h, Game_map_L(ix)
	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
	;;
	;;	ld 	h, Game_time_H(ix)
	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;; Modifying game data example
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;; ==================================
;; Devuelve el puntero a video en HL
;; Devuelve:
;;	HL => Pointer to video memory
;; ==================================
getVideoPtr::
	ld	hl, (videoPtr)
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

	;; Clean from 8000 to BFFF
	ld	hl, #0x8000			;; HL <= Copy pointer
	ld	de, #0x8001			;; DE <= Write pointer
	ld	(hl), #00			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	ld 	Game_t1points(ix), #0
	ld 	Game_t2points(ix), #0		;; Initialize points to 0

	
	ret


switchBuffers:
	mem_page = .+1
	ld 	l, #0x20
	call 	cpct_setVideoMemoryPage_asm
	ld 	hl, #mem_page
	ld	a, #0x10
	xor	(hl)
	ld	(hl), a

	ld	hl, #videoPtr+1
	ld	a, #0x40
	xor	(hl)
	ld	(hl), a


	ret


;; ============================
;; Game loop until end of game
;; ============================
game_loop:


	;; Erase entities
	call player_erase
	call frisbee_erase

	;; Update entities
	call player_update
	call frisbee_update

	;; Draw entities
	call player_draw
	call frisbee_draw

	ld	ix, #frisbee_data
	call frisbee_checkGoal

	;; Wait VSYNC to modify VMEM without blinking
	call cpct_waitVSYNC_asm
	call switchBuffers

	jr (game_loop) 			;; Bucle infinito
	ret