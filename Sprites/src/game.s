.area _DATA
.area _CODE

.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"
	
.globl _sp_palette

;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

game_data::
	game_type:		.db #0		;; Game Mode			(8 bits)
	game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
	game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
	game_t1points: 		.db #0 		;; Points of team 1		(8 bits)
	game_t2points: 		.db #0 		;; Points of team 2		(8 bits)
	game_maxPoints: 	.db #100 	;; Quantity of points to win	(8 bits)
	game_interruptions: 	.db #0 		;; Counter interruption handler	(8 bits)
;; 
;; .equ RIGHT_LIMIT,	80
;; .equ LEFT_LIMIT,	0
;; .equ TOP_LIMIT,	10
;; .equ BOTTOM_LIMIT,	200
;; .equ CENTER_LIMIT,	40


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


;; ==================================
;; Incrementa los puntos del equipo 1
;; Modifica: A, IX
;; ==================================
incTeam1Points::
	ld	a, (game_maxPoints)
	ld 	b, a				;; B <= Max points

	ld	a, (game_t1points)
	inc	a				;; A <= Team 1 points + 1

	cp 	b
	jr	z, max_t1_points		;; t1Points+1 == max_points? 
		ld	(game_t1points), a	;; Inc team 1 points

	max_t1_points:
		ret

;; ==================================
;; Incrementa los puntos del equipo 2
;; Modifica: A, IX
;; ==================================
incTeam2Points::
	ld 	ix, #game_data
	ld	a, (game_maxPoints)
	ld 	b, a				;; B <= Max points

	ld	a, (game_t2points)
	inc	a				;; A <= Team 2 points + 1

	cp 	b
	jr	z, max_t2_points		;; t2Points+1 == max_points? 
		ld	(game_t2points), a	;; Inc team 2 points

	max_t2_points:
		ret

;; alomejor es una función privada
play_music::
	exx
	ex af', af
	push af
	push bc
	push de
	push hl

	call cpct_akp_musicPlay_asm

	pop hl
	pop de
	pop bc
	pop af
	ex af', af
	exx

	ret

;; alomejor es una función privada
stop_music::
	exx
	ex af', af
	push af
	push bc
	push de
	push hl

	call cpct_akp_stop_asm

	pop hl
	pop de
	pop bc
	pop af
	ex af', af
	exx

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
	ld 	c, #0
	call cpct_setVideoMode_asm

	;; Set palette
	ld 	hl, #_sp_palette
	ld 	de, #16
	call cpct_setPalette_asm

	;; Clean from 8000 to BFFF
	ld	hl, #0x8000			;; HL <= Copy pointer
	ld	de, #0x8001			;; DE <= Write pointer
	ld	(hl), #00			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	ld	hl, #game_t1points
	ld 	(hl), #0
	ld	hl, #game_t2points
	ld 	(hl), #0		;; Initialize points to 0

	
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