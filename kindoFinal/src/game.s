.area _DATA
.area _CODE

.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"
.include "entity.h.s"
.include "sprites.h.s"
	
;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

paletteM2::	.db #0x4B	;; White
			.db #0x54	;; Black

paletteM1::	.db #0x4C	;; Red
			.db #0x40	;; Grey
			.db #0x4B	;; White
			.db #0x54	;; Black

blackPaletteM1::	.db #0x54	;; Black
					.db #0x54	;; Black
					.db #0x54	;; Black
					.db #0x54	;; Black

;;paletteM0::	.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;; 
;;			.db # ;;  
;;			.db #0x4B ;; White
;;			.db #0x54 ;; Black 


number_w = 3
number_h = 7
.equ music_vel, #6

;;defineEntity name, 	x,				y,	 	 h,   w,  vx, 	vy, 	ax,    ay,    normal, 	sprites_ptr, 	 id
defineEntity player, 	#0x0010, 		#0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, #1
defineEntity enemy, 	#0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, #2

defineEntity player2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#3
defineEntity enemy2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 	#4

game_data::
	game_type::          .db #0 ;; Game Mode (8 bits)
   	game_numPlayers::    .db #0 ;; Players who are going to play
   	game_WinCondition::  .db #0 ;; Win condition 0-> Time, 1 -> Score

	game_maxScore::      .db #21 ;; Max score of a match (to win)
	game_t1Score::       .db #0 ;; Points of team 1		(8 bits)
	game_t2Score::       .db #0 ;; Points of team 2		(8 bits)

	game_minute::		.db #2 ;; Actual minute. Also Controles if we whant to play with time
	game_secLeft::		.db #0 ;; Both variables to control the seconds
	game_secRight::		.db #0 ;; Both variables to control the seconds
	game_maxTime::       .dw #0x0000 ;; Max time of a match
	game_map::           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)

	game_musicOptions::  .db #0 ;; Controles if we whant to play music on options
	game_timeOptions::   .db #0 ;; Controles if we whant to play with time on options

	game_interrMusic::   .db #music_vel ;; Interruption counter for music handler	(16 bits)
	game_interrTime::	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
	game_musicPlayer::   .db #0 ;; Controles the music player
	game_musicEffects::  .db #0 ;; Controles the effects on the match

	game_enableMusic::	.db #1 ;; Controles if we whant some music

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

.equ minSpPointer, 0xE025		;; Pointer to know where to print the score, on both videopointers.
.equ minSpPointer2, 0xA025
.equ secLeftSpPointer, 0xE029
.equ secLeftSpPointer2, 0xA029
.equ secRightSpPointer, 0xE02C
.equ secRightSpPointer2, 0xA02C

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
	call 	initializeGame
	;; Prepartida
	call 	configureISR
	ld a, (game_type)
	cp #0
	jr nz, game_PVP
		call game_loop_Player_IA
		jr afterGame

	game_PVP:
		call game_loop_Player_PvP
		;; call game_loop_PvP

	afterGame:

	ld hl, #emptyHandler	;; emptyHandler
	call cpct_setInterruptHandler_asm

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

;; ====================================
;; ====================================
;; Decide what number must charge
;; a -> Number
;; hl <- Sprite to print
;; ====================================
;; ====================================
decideNumber::
	cp #0
	jr nz, is_One
		;; if
		ld hl, #_sprite_numbers_00
		ret

	is_One:
	cp #1
	jr nz, is_Two
		ld hl, #_sprite_numbers_01
		ret

	is_Two:
	cp #2
	jr nz, is_Tree
		ld hl, #_sprite_numbers_02
		ret

	is_Tree:
	cp #3
	jr nz, is_Four
		ld hl, #_sprite_numbers_03
		ret

	is_Four:
	cp #4
	jr nz, is_Five
		ld hl, #_sprite_numbers_04
		ret

	is_Five:
	cp #5
	jr nz, is_Six
		ld hl, #_sprite_numbers_05
		ret

	is_Six:
	cp #6
	jr nz, is_Seven
		ld hl, #_sprite_numbers_06
		ret

	is_Seven:
	cp #7
	jr nz, is_Eight
		ld hl, #_sprite_numbers_07
		ret

	is_Eight:
	cp #8
	jr nz, is_Nine
		ld hl, #_sprite_numbers_08
		ret

	is_Nine:
		ld hl, #_sprite_numbers_09
		ret

	ret

;; ===================================
;; Draws a number
;; Entrada:
;;	HL <= Pointer to number sprite
;;	DE <= Pointer to video memory
;; Modifica AF, BC, DE, HL
;; ===================================
drawNumber::
	ld 	b, #number_h 		;; B = ent height
	ld 	c, #number_w 		;; C = ent width
	call cpct_drawSprite_asm

	ret

drawTimeCounters::
		ld a, (videoPtr + 1)
		cp #0x80
		jr z, paintOn8000
			;; Painting on C000
			ld a, (game_minute)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#minSpPointer
			call drawNumber

			ld a, (game_secLeft)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#secLeftSpPointer
			call drawNumber

			ld a, (game_secRight)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#secRightSpPointer
			call drawNumber

		jr drawTimeCounters_exit

		paintOn8000:
			ld a, (game_minute)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#minSpPointer2
			call drawNumber

			ld a, (game_secLeft)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#secLeftSpPointer2
			call drawNumber

			ld a, (game_secRight)
			call decideNumber	;; HL <= sprite pointer
			ld de,	#secRightSpPointer2
			call drawNumber

		drawTimeCounters_exit:
		ret

updateTime::
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

;; Empty Handler
emptyHandler:
	ret

;; Handler for time
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

;; Handler for music
handlerMusic::
	ld a , (game_interrMusic) ;; a <- game_interrMusic
	dec a
	ld (game_interrMusic), a

	jr nz, music_iterate
		;; a == 0
		ld a, #music_vel
		ld (game_interrMusic), a
		call play_music

	music_iterate:
	ret

;; Handler for time music
handlerTimeMusic:
	call handlerTime
	call handlerMusic
	ret

configureISR::
	ld a, (game_WinCondition) 	;; a <- game_WinCondition (0-> Time, 1 -> Score)
	cp #0						;; a - 0
	jr z, ISR_timeOn			;; if (game_enableTime - 0) == 0, then jump ISR_timeOn
		;; Time Off
		ld a, (game_enableMusic) 	;; a <- game_enableMusic
		cp #0						;; a - 0
		jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
		;; Time Off, Music Off
			ld hl, #emptyHandler	;; emptyHandler
			call cpct_setInterruptHandler_asm
			ret 					;; Get Out

	ISR_timeOn:
		;; Time On
		ld a, (game_enableMusic)	;; a <- game_enableMusic
		cp #0
		jr nz, ISR_timeOn_musicOn 	;; if (a - 0) == 1, jump ISR_timeOn_musicOn
			;; Time On, Music Off
			ld hl, #handlerTime 				;; handlerTime
			call cpct_setInterruptHandler_asm	;;
			ret 								;; Get Out

	ISR_timeOff_musicOn:
		ld hl, #handlerMusic
		call cpct_setInterruptHandler_asm
		ret 								;; Get Out

	ISR_timeOn_musicOn:
		ld hl, #handlerTimeMusic
		call cpct_setInterruptHandler_asm
		ret 								;; Get Out

.globl _mainSong

;; ========================
;; Initialize game
;; ========================
initializeGame:

	;; Set video mode
	ld 	c, #0
	call cpct_setVideoMode_asm

	;; Set palette
	ld 	hl, #_sprite_palette
	ld 	de, #16
	call cpct_setPalette_asm

	ld l, #16					;; Select the border colour
	ld h, #0x4B					;; Set the White Colour
	call cpct_setPALColour_asm

	;; Clean from 8000 to FFFF
	ld	hl, #0x8000			;; HL <= Copy pointer
	ld	de, #0x8001			;; DE <= Write pointer
	ld	(hl), #00			;; Set to 0 where HL points
	ld	bc, #0x8000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	ld	hl, #game_t1Score
	ld 	(hl), #0
	ld	hl, #game_t2Score
	ld 	(hl), #0		;; Initialize points to 0

	ld de, #_mainSong
	call cpct_akp_musicInit_asm
	
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

	call drawTimeCounters

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


;; Game loop for PVP
game_loop_Player_PvP:
	;; Erase
	ld ix, #player_data
	call entityErase

	ld ix, #player2_data
	call entityErase

	ld ix, #frisbee_data
	call entityErase

	;; Update
	ld ix, #player_data
	call player_update

	ld ix, #player2_data
	call player_update

	ld ix, #frisbee_data
	call frisbee_update

	;; Draw
	ld ix, #player_data
	call entityDraw

	ld ix, #player2_data
	call entityDraw

	ld ix, #frisbee_data
	call entityDraw

	call drawTimeCounters

	;; Check goal
	ld	ix, #frisbee_data
	call frisbee_checkGoal

	;; Wait VSYNC to modify VMEM without blinking
	call cpct_waitVSYNC_asm
	call switchBuffers

	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
	cp #0  				      ;; a - 0
	jr z, timeWinning_Pvp         ;; if (a - 0) == 0, then jump timeWinning_Pvp
		jr scoreEnd_Pvp 		  ;; else, jump ScoreWinning.

	timeWinning_Pvp:
		ld a, (game_minute) ;; a <- game_minute
		cp #0 				;; a - 0
		jr nz, game_loop_Player_PvP 	;; if (a - 0) != 0, then jump game_loop_Player_PvP

		ld a, (game_secLeft)	;; a <- game_secLeft
		cp #0 				  	;; a - 0
		jr nz, game_loop_Player_PvP	;; if (a - 0) != 0, then jump game_loop_Player_PvP

		ld a, (game_secRight)	;; a <- game_secRight
		cp #0 				  	;; a - 0
		jr nz, game_loop_Player_PvP	;; if (a - 0) != 0, then jump game_loop_Player_PvP
		jr game_loop_Player_PvP_exit

	scoreEnd_Pvp:
		ld a, (game_t1Score) 
		ld b, a               ;; b <- LocalScore
		ld a, (game_maxScore) ;; a <- maxScore
		cp b             	  ;; a - b 
		jr z, game_loop_Player_PvP_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin

		ld c, a      	      ;; c <- maxScore
		ld a, (game_t2Score)
		ld b, a               ;; b <- VisitantScore
		ld a, c 			  ;; a <- c
		cp b             	  ;; a - b 
		jr z, game_loop_Player_PvP_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
			jp game_loop_Player_PvP ;; Keep Playing

	game_loop_Player_PvP_exit:

	ret