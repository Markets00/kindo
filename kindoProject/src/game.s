.area _DATA
.area _CODE

.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"
.include "entity.h.s"
	
;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

.globl _sprite_palette
.globl _sprite_robot_1_0
.globl _sprite_robot_1_1
.globl _sprite_robot_2_0
.globl _sprite_robot_2_1

;;    .macro name,   x,       y,       h,   w,  vx,    vy,    ax,    ay,    normal,  state, sprite,  			id
defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1,    #_sprite_robot_1_0, 	#1
defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #_sprite_robot_2_0, 	#2

defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1,    #_sprite_robot_1_0, 	#1
defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #_sprite_robot_2_0, 	#2

game_data::
	game_type::         .db #0 ;; Game Mode (8 bits)
   	game_numPlayers:    .db #0 ;; Players who are going to play
   	game_WinCondition:  .db #0 ;; Win condition 0-> Time, 1 -> Score

	game_maxScore:      .db #10 ;; Max score of a match (to win)
	game_t1Score:       .db #0 ;; Points of team 1		(8 bits)
	game_t2Score:       .db #0 ;; Points of team 2		(8 bits)

	game_minute:		.db #2 ;; Actual minute. Also Controles if we whant to play with time
	game_secLeft:		.db #0 ;; Both variables to control the seconds
	game_secRight:		.db #0 ;; Both variables to control the seconds
	game_maxTime:       .dw #0x0000 ;; Max time of a match
	game_map:           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)

	game_musicOptions:  .db #0 ;; Controles if we whant to play music on options
	game_timeOptions:   .db #0 ;; Controles if we whant to play with time on options

	game_interrMusic:   .dw #0 ;; Interruption counter for music handler	(16 bits)
	game_interrTime:	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
	game_musicPlayer:   .db #0 ;; Controles the music player
	game_musicEffects:  .db #0 ;; Controles the effects on the match

	game_enableMusic:	.db #0 ;; Controles if we whant some music

	;; ÑORDBUGER 0f89

	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
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
	;; Configurating the handler
	;; Prepartida
	call 	configureMatch
	call 	game_loop_Player_IA

	ld 	a, (game_t2Score)
	ld 	b, a

	ld 	a, (game_t1Score)
	cp 	b
	jp 	m, t2_win
		;; t1 win

	t2_win:


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
;; Modifica: A, B
;; ==================================
incTeam1Points::
	ld	a, (game_maxScore)
	ld 	b, a				;; B <= Max points

	ld	a, (game_t1Score)
	inc	a				;; A <= Team 1 points + 1

	ld	(game_t1Score), a	;; Inc team 1 points

		ret

;; ================================== 
;; Incrementa los puntos del equipo 2
;; Modifica: A, B
;; ==================================
incTeam2Points::
	ld	a, (game_maxScore)
	ld 	b, a				;; B <= Max points

	ld	a, (game_t2Score)
	inc	a				;; A <= Team 2 points + 1

	ld	(game_t2Score), a	;; Inc team 2 points

	;;cp 	b
	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
	;;	ld	(game_t2Score), a	;; Inc team 2 points

		ret

;; alomejor es una función privada
play_music:
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
stop_music:
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


;; ================================== 
;; Actualiza las variables del tiempo
;; Modifica: A
;; ==================================
updateTime:
	ld a, (game_secLeft)
	cp #0
	jr nz, checkRightsec

	ld a, (game_secRight)
	cp #0
	jr nz, decRightsec
		ld a, (game_minute) 
		dec a ;; min--
		ld (game_minute), a

		ld a, #5
		ld (game_secLeft), a ;; secLeft = 5

		ld a, #9
		ld (game_secRight), a ;; secRight = 9;

		jr continue
	checkRightsec:
		ld a, (game_secRight)
		cp #0
		jr nz, decRightsec
			ld a, (game_secLeft) 
			dec a ;; secLeft--
			ld (game_secLeft), a

			ld a, #9 ;; secRight = 9;
			ld (game_secRight), a
			jr continue
	decRightsec:
		ld a, (game_secRight)
		dec a ;; secRight--
		ld (game_secRight), a

	continue:

	ret

emptyHandler:
	ret

handlerTime::
	ld 	hl, (game_interrTime)
	dec hl
	ld 	a, h
	cp 	#0
	jr 	nz, time_iterate
	ld 	a, l
	cp 	#0
	jr 	nz, time_iterate
		;; interrTime == 0
		ld hl, #0x012C		;; HL <= 300
		call updateTime

	time_iterate:
		ld (game_interrTime), hl
	ret

handlerMusic:
	ret

handlerTimeMusic:
	call handlerTime
	call handlerMusic
	ret

configureMatch:
	ld a, (game_minute) 		;; a <- game_minute
	cp #0						;; a - 0
	jr nz, ISR_timeOn			;; if (game_enableTime - 0) == 1, then jump ISR_timeOn
	;; Time Off
	ld a, (game_enableMusic) 	;; a <- game_enableMusic
	cp #0						;; a - 0
	jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
	;; Time Off, Music Off
	ld hl, #emptyHandler
	call cpct_setInterruptHandler_asm

	jr configureMatch_exit

	ISR_timeOn:
		;; Time On
		ld a, (game_enableMusic)	;; a <- game_enableMusic
		cp #0
		jr nz, ISR_timeOn_musicOn
		;; Time On, Music Off
		ld hl, #handlerTime
		call cpct_setInterruptHandler_asm

	ISR_timeOff_musicOn:

	ISR_timeOn_musicOn:

	configureMatch_exit:
	ret

;; ========================
;; Initialize game
;; ========================
initializeGame:

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

	ld	hl, #game_t1Score
	ld 	(hl), #0
	ld	hl, #game_t2Score
	ld 	(hl), #0		;; Initialize points to 0

	
	ret


;; ========================
;; Switch Buffers
;; ========================
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
game_loop_Player_IA:

	;; Erase
	ld ix, #player_data
	call entityErase

	ld ix, #enemy_data
	call entityErase

	ld ix, #frisbee_data
	call entityErase

	;; Update
	ld ix, #player_data
	call player_update

	ld ix, #enemy_data
	call player_update

	ld ix, #frisbee_data
	call frisbee_update

	;; Draw
	ld ix, #player_data
	call entityDraw

	ld ix, #enemy_data
	call entityDraw

	ld ix, #frisbee_data
	call entityDraw

	;; Check goal
	ld	ix, #frisbee_data
	call frisbee_checkGoal

	;; Wait VSYNC to modify VMEM without blinking
	call cpct_waitVSYNC_asm
	call switchBuffers

	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
	cp #0  				      ;; a - 0
	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
		jr scoreEnd 		  ;; else, jump ScoreWinning.

	timeWinning:
		ld a, (game_minute) ;; a <- game_minute
		cp #0 				;; a - 0
		jr nz, game_loop_Player_IA 	;; if (a - 0) != 0, then jump game_loop_Player_IA

		ld a, (game_secLeft)	;; a <- game_secLeft
		cp #0 				  	;; a - 0
		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA

		ld a, (game_secRight)	;; a <- game_secRight
		cp #0 				  	;; a - 0
		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
		jr game_loop_Player_IA_exit

	scoreEnd:
		ld a, (game_t1Score) 
		ld b, a               ;; b <- LocalScore
		ld a, (game_maxScore) ;; a <- maxScore
		cp b             	  ;; a - b 
		jr z, game_loop_Player_IA_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin

		ld c, a      	      ;; c <- maxScore
		ld a, (game_t2Score)
		ld b, a               ;; b <- VisitantScore
		ld a, c 			  ;; a <- c
		cp b             	  ;; a - b 
		jr z, game_loop_Player_IA_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
			jp game_loop_Player_IA ;; Keep Playing

game_loop_Player_IA_exit:
	ret