.area _DATA
.area _CODE

.include "utility.h.s"
.include "game.h.s"

;; definición de las teclas que necesitaremos
  Key_CursorUp     = 0x0100
  Key_CursorLeft   = 0x0101
  Key_CursorDown   = 0x0400
  Key_CursorRight  = 0x0200
  Key_Space        = 0x8005
  Key_Return       = 0x0402

;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================

;; .equ mi_constante0, 0
;; .equ mi_constante1, 1
menuString:				.asciz "Menu"
playString:				.asciz "Play"
optionsString:			.asciz "Options"
creditsString:			.asciz "Credits"
menuInstrucString:		.asciz "Intructions"

leftArrowCharacter: 	.asciz "<"
rightArrowCharacter:	.asciz ">"
winCondString: 			.asciz "Win Condition"
timeString: 			.asciz "Time"
string_1:				.asciz "1"
string_2:				.asciz "2"
string_3:				.asciz "3"

scoreString:			.asciz "Score"
string_15:				.asciz "15"
string_21:				.asciz "21"
string_25:				.asciz "25"
string_58:				.asciz "58"

musicString:			.asciz "Music"
onString:				.asciz "On"
offString:				.asciz "Off"
callingFromOpts: 		.db #0 ;; Are we calling from options?


;; menuPos_X_sub 	-> For submenus, to the option menu
;; menuPos_X 		-> Orignal position string (Strings on Menu, "<" on Options)
;; menuPos_X_1 		-> String for options menu
;; menuPos_X_2		-> ">" For Option menu

.equ menuPos_1_sub, 0xC000
.equ menuPos_1, 0xC850
.equ menuPos_1_1, 0xC85B
.equ menuPos_1_2, 0xC870

.equ menuPos_2_sub, 0xC0F0
.equ menuPos_2, 0xC940
.equ menuPos_2_1, 0xC94B
.equ menuPos_2_2, 0xC960

.equ menuPos_3_sub, 0xC1E0
.equ menuPos_3, 0xCA30
.equ menuPos_3_1, 0xCA3b
.equ menuPos_3_2, 0xCA50

.equ menuPos_4_sub, 0xC2D0
.equ menuPos_4, 0xCB20
.equ menuPos_4_1, 0xCB2B
.equ menuPos_4_2, 0xCB40

.equ menuPos_5, 0xCC10
.equ menuPos_5_1, 0xCC1B
.equ menuPos_5_2, 0xCC30

.equ menuPos_6, 0xCD00
.equ menuPos_6_1, 0xCD0B
.equ menuPos_6_2, 0xCD20

.equ menuPos_7, 0xCDF0
.equ menuPos_7_1, 0xCDFB
.equ menuPos_7_2, 0xCE10

.equ cursorPosDef, 0xC88F
;; .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
;; .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
;;.equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
;;.equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.

.equ instrPos, 0xC6E0

.globl _sprite_frisbeeMenu

cursor_W 	= 2
cursor_H 	= 8
max_index_value	= 6
addPosition	= 0xF0 			;; Sums to the next position (or substrct to the previous one)
subPosition	= #-240
cursorPos: 	.dw 0xC88F		;; Saves the cursor position

;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================
menuStart::
	ld l, #16					;; Select the border colour
	ld h, #0x54					;; Set the Black Colour
	call cpct_setPALColour_asm

	call cleanScreen		;;
	call initializeMenu 	;; 

	ld	a, #0			;; Initialize A to 0 as starting index for main menu
	call menu_loop 			;; Checks the state
	ret

;;
;;
;;
menu_loop::

	call 	checkSelection
	;; We have on A the option selected
	cp #0 					;; a - 0
	jr nz, menuStart_check1	;; if (a - 0) != 0
		;; else, a == 0 ;; Go Configure Match
		ret

	menuStart_check1:
		cp #1					;; a - 1
		jr nz, menuStart_check2	;; if (a - 1) != 0
			;; else, a == 1 ;; Go options
			push af
			ld 	hl, (cursorPos)
			push hl
			call menuOptionsStart
			pop hl
			ld (cursorPos), hl
			call initializeMenu
			pop af

			jr menu_loop


	menuStart_check2:
		;; Do stuff.
	ret

;;
;;
;;
menuOptionsStart::
	ld hl, #cursorPosDef
	ld (cursorPos), hl
	call initializeOptionsMenu

	ld a, #0
	call menuOptions_loop
	ret

;; ====================================
;; Erase the draw on options
;; HL <- what to print
;; DE <- Where to print
;; Modifies: BC
;; ====================================
eraseOptionsRefactor::
	ld c, #3
	ld b, #3
	call cpct_drawStringM1_f_asm

	ret

;; ====================================
;; Refactors the draw on options
;; HL <- what to print
;; DE <- Where to print
;; Modifies: BC
;; ====================================
drawOptionsRefactor::
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_f_asm

	ret

;; ====================================
;; Gets the win condition string
;; Modifies: A, HL, DE, BC
;; ====================================
getWinCondition::
	ld a, (winIndex) 	;; a <- Win condition ; 0 -> Time, 1 -> Score
	cp #0						;; 
	jr nz, itsTime 				;; a != 0, then go time
		ld hl, #scoreString		;; Charge score sprite
		ret		;; Jump to draw

	itsTime:
		ld hl, #timeString		;; Charge time sprite

	ret

;; ====================================
;; Prints the win condition string
;; Modifies: A, HL, DE, BC
;; ====================================
printWinCondition::
	;; Prints win condition options
	call getWinCondition
	ld de, #menuPos_1_1
	call drawOptionsRefactor

	ret

;; ====================================
;; Gets the time string
;; Modifies: A, HL, DE, BC
;; ====================================
getTimeOptions::
	ld a, (timIndex)		;; a <- game_minute
	cp #0					;;
	jr nz, itsTwoMinutes	;; a != 1, then go two minutes
		ld hl, #string_1 	;; Charge the 1 string
		ret	;; Jump to draw

	itsTwoMinutes:
		cp #1					;;
		jr nz, itsThreeMinutes	;; a != 2, then go two minutes
			ld hl, #string_2 	;; Charge the 2 string
			ret	;; Jump to draw

	itsThreeMinutes:
		ld hl, #string_3 	;; Charge the 3 string
	ret

;; ====================================
;; Prints the time string
;; Modifies: A, HL, DE, BC
;; ====================================
printTimeOptions::
	;; Print time options
	call getTimeOptions
	ld de, #menuPos_2_1
	call drawOptionsRefactor
	ret

;; ====================================
;; Gets the score string
;; Modifies: A, HL, DE, BC
;; ====================================
getScoreOptions::
	ld a, (scoIndex)		;; a <- game_maxScore
	cp #0						;;
	jr nz, itsTwentyOneGoals	;; a != 11, then go two minutes
		ld hl, #string_15 		;; Charge the 1 string
		ret						;; Jump to draw

	itsTwentyOneGoals:
		cp #1						;;
		jr nz, itsTwentyFiveGoals	;; a != 11, then go two minutes
			ld hl, #string_21 		;; Charge the 1 string
			ret						;; Jump to draw

	itsTwentyFiveGoals:
		cp #2						;;
		jr nz, itsFiftyEightGoals	;; a != 11, then go two minutes
			ld hl, #string_25 		;; Charge the 1 string
			ret						;; Jump to draw

	itsFiftyEightGoals:
			ld hl, #string_58 	;; Charge the 1 string

	ret

;; ====================================
;; Prints the score string
;; Modifies: A, HL, DE, BC
;; ====================================
printScoreOptions::
	;; Print time options
	call getScoreOptions
	ld de, #menuPos_3_1
	call drawOptionsRefactor
	ret

;; ====================================
;; Gets the music string
;; Modifies: A, HL, DE, BC
;; ====================================
getMusicOption::
	ld a, (musIndex) 	;;  a <- game_enableMusic
	cp #0						;;
	jr z, itsMusicOff
		ld hl, #onString
		ret

	itsMusicOff:
		ld hl, #offString

	ret

;; ====================================
;; Prints the music string
;; Modifies: A, HL, DE, BC
;; ====================================
printMusicOptions::
	call getMusicOption
	ld de, #menuPos_4_1
	call drawOptionsRefactor

	ret

;; ====================================
;; Checks the options strings
;; Modifies: A, HL, DE, BC
;; ====================================
printOptions::

	call printWinCondition
	call printTimeOptions
	call printScoreOptions
	call printMusicOptions

	ret

menuOptions_loop::
	call checkSelection
	;; Set variables game
	ret

getMaxIterator::
	pop af 		;; Get the iterator on A.

	cp #0
	jr nz, not_WinCondition
		;; Win Condition
	not_WinCondition:
		cp #1
		jr nz, not_Time
			;; Time

	not_Time:
		cp #2
		jr nz, not_Score
			;; Score

	not_Score:
		;; Music

	ret

;; Max iterators
maxOn2:		.db #2
maxOn3:		.db #3
maxOn4:		.db #4

;; =======================================
;; Win Condition Movements
;; =======================================
winIndex:	.db #0

moveLeftWinCond::
	ld a, (winIndex)
	dec a
	cp #-1
	jr z, maxWinCond_left
		;; We can move to the left
		ld (winIndex), a
		jr printWinCond_left

	maxWinCond_left:
		ld a, (maxOn2)
		dec a
		ld (winIndex), a

	printWinCond_left:
		call printWinCondition
	ret

moveRightWinCond::
	ld a, (maxOn2)
	ld b, a
	ld a, (winIndex)
	inc a
	cp b
	jr z, minWinCond_right
		;; We can move to the right
		ld (winIndex), a
		jr printWinCond_right

	minWinCond_right:
		ld a, #0
		ld (winIndex), a

	printWinCond_right:
		call printWinCondition
	ret

;; =======================================
;; Score Movements
;; =======================================
scoIndex:	.db #1

moveLeftScore::
	ret

moveRightScore::
	ret

;; =======================================
;; Time Movements
;; =======================================
timIndex:	.db #1

moveLeftTime::
	ret

moveRightTime::
	ret

;; =======================================
;; Music Movements
;; =======================================
musIndex:	.db #0

moveLeftMusic::
	ret

moveRightMusic::
	ret

;; =======================================
;;
;; =======================================
checkLateral::
;winMoveRight
	ld 	hl, #Key_CursorLeft
	call 	cpct_isKeyPressed_asm	;; A <= True/False
	cp 	#0 
	jr 	z, left_not_pressed			;; Is left key pressed?
		;; left pressed
		pop 	af
		cp #0
		jr nz, not_WinCondition_left
			;; Call Win Condition left
			call moveLeftWinCond

		not_WinCondition_left:
			cp #1
			jr nz, not_Time_left
				;; Time
				call moveLeftTime

		not_Time_left:
			cp #2
			jr nz, not_Score_left
				;; Score
				call moveLeftScore

		not_Score_left:
			;; Music
			call moveLeftMusic

		push	af
		jr right_not_pressed

	left_not_pressed:
		ld 	hl, #Key_CursorRight
		call 	cpct_isKeyPressed_asm	;; A <= True/False
		cp 	#0 
		jr 	z, right_not_pressed			;; Is left key pressed?
			;; right pressed
			pop 	af
			cp #0
			jr nz, not_WinCondition_right
				;; Call Win Condition left
				call moveRightWinCond

			not_WinCondition_right:
				cp #1
				jr nz, not_Time_right
					;; Time
					call moveRightTime

			not_Time_right:
				cp #2
				jr nz, not_Score_right
					;; Score
					call moveRightScore

			not_Score_right:
				;; Music
				call moveRightMusic

			push	af

	right_not_pressed:
	ret

;; =======================================
;; Mueve el índice a la posición indicada
;; Modifica: AF, BC, DE, HL
;; Devuelve:
;;	A <= Selected index [0 - 6]
;; =======================================
checkSelection::
	selection_waitting:
		push 	af

		call 	cpct_scanKeyboard_asm

		ld 	hl, #Key_Return 
		call 	cpct_isKeyPressed_asm	;; A <= True/False
		cp 	#0 
		jr 	z, enter_not_pressed	;; Is enter key pressed?
			pop af			;; A <= final index selected
			ret

		enter_not_pressed:
			pop af			;; A <= index value
			call checkCursor	;; check cursor movement
			push af

			ld 	a, (callingFromOpts)
			cp 	#0
			jr 	z, not_options
				call checkLateral

			not_options:
			pop af
			jr selection_waitting

	ret

;; =======================================
;; Mueve el índice a la posición indicada
;; Entrada:
;;	HL <= pointer to new position
;; Modifica: AF, BC, DE, HL
;; =======================================
reDrawCursor::
	push hl

	ld de, (cursorPos)		;; alomejor esto no compila
	ld a, #0xFF
	ld b, #cursor_H
	ld c, #cursor_W
	call cpct_drawSolidBox_asm	;; Erase last index position

	pop hl
	ld (cursorPos), hl		;; Update cursorPos to the new position after erasing

	ex 	de, hl			;; DE <= pointer to new position
	ld	hl, #_sprite_frisbeeMenu;; HL <= cursor sprite pointer
	ld 	b, #cursor_H		;; B = height
	ld 	c, #cursor_W		;; C = width
	call cpct_drawSprite_asm

	ret

;; =================================
;; Chequea si el índice debe moverse
;; Entrada:
;;	A <= starting index
;; Modifica: AF, BC, DE, HL
;; Devuelve:
;; 	A => selected index
;; =================================
checkCursor::
	push 	af						;; Save the index at the stack
	ld 	hl, #Key_CursorUp
	call 	cpct_isKeyPressed_asm	;; A <= True/False
	cp 	#0 
	jr 	z, up_not_pressed			;; Is up key pressed?
		;; Up pressed
		pop af
		dec a
		jp	m, cant_dec_index
			;; Decrement index
			push af				;; Save the index

			ld 	hl, (cursorPos)		;; HL <= Cursor position
			ld	de, #subPosition	;; DE <= Negative value to substract to cursor position
			add	hl, de				;; HL <= Cursor position - SubPosition
			call 	reDrawCursor

			ld	a, #10
			call 	wait_X_halts	;; Waits a amout of halts * 8.

			pop af					;; Restore the index before looping
			ret

			cant_dec_index:
				inc a 				;; Restore index value
				ret

	up_not_pressed:
		ld 	hl, #Key_CursorDown
		call 	cpct_isKeyPressed_asm	;; A <= True/False
		cp 	#0 
		jr 	z, down_not_pressed	;; Is down key pressed?
			;; Down pressed
			pop 	af
			inc 	a
			cp  	#max_index_value
			jp	p, cant_inc_index
				;; increment index
				push af					;; Save the index

				ld 	hl, (cursorPos)		;; HL <= Cursor position
				ld	de, #addPosition	;; DE <= Positive value to add to cursor position
				add	hl, de				;; HL <= Cursor position + AddPosition
				call 	reDrawCursor

				ld	a, #10
				call 	wait_X_halts

				pop af				;; Restore the index before looping
				ret

			cant_inc_index:
				dec a 				;; Restore index value
				ret

	down_not_pressed:
		;; Any key pressed
		pop af
	ret

;; =================================
;; Waits 8 halts, N times
;; In:
;;	A <= N times
;; Modifies: A
;; =================================
wait_X_halts::
	dec a
	jr z, wait_halts_exit
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		jr wait_X_halts
	wait_halts_exit:
	ret

;; =======================================
;; Sets the palette to mode 0
;; Modifies: C, HL, DE
;; =======================================
;;setPaletteM0::
;;	ld c, #0					;; Mode 0
;;	call cpct_setVideoMode_asm
;;
;;	ld hl, #paletteM0			;; hl <- paletteM0
;;	ld de, #16 					;; 16 Colours
;;	call cpct_setPalette_asm
;;
;;	ret

;; =======================================
;; Sets the palette to mode 1
;; Modifies: C, HL, DE
;; =======================================
setPaletteM1::
	ld c, #1					;; Mode 1
	call cpct_setVideoMode_asm

	ld hl, #paletteM1			;; hl <- paletteM1
	ld de, #4 					;; 4 Colours
	call cpct_setPalette_asm

	ret

;; =======================================
;; Sets the palette to black on mode 1
;; Modifies: C, HL, DE
;; =======================================
setPaletteBlackM1::
	ld c, #1					;; Mode 1
	call cpct_setVideoMode_asm

	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
	ld de, #4 					;; 4 Colours
	call cpct_setPalette_asm

	ret

;; =======================================
;; Print the options menu
;; =======================================
initializeOptionsMenu::

	ld a, #1
	ld (callingFromOpts), a

	call cleanScreen

	;; Print winCondString
	ld hl, #winCondString
	ld de, #menuPos_1_sub
	call drawOptionsRefactor

	;; Print scoreString
	ld hl, #timeString
	ld de, #menuPos_2_sub
	call drawOptionsRefactor

	;; Print timeString
	ld hl, #scoreString
	ld de, #menuPos_3_sub
	call drawOptionsRefactor

	;; Print musicString
	ld hl, #musicString
	ld de, #menuPos_4_sub
	call drawOptionsRefactor

	;; Print left arrows string
	ld hl, #leftArrowCharacter
	ld de, #menuPos_1
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_2
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_3
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_4
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_5
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_6
	call drawOptionsRefactor

	ld hl, #leftArrowCharacter
	ld de, #menuPos_7
	call drawOptionsRefactor

	;; Print right arrows string
	ld hl, #rightArrowCharacter
	ld de, #menuPos_1_2
	call drawOptionsRefactor

	ld hl, #rightArrowCharacter
	ld de, #menuPos_2_2
	call drawOptionsRefactor

	ld hl, #rightArrowCharacter
	ld de, #menuPos_3_2
	call drawOptionsRefactor

	ld hl, #rightArrowCharacter
	ld de, #menuPos_4_2
	call drawOptionsRefactor

	ld hl, #rightArrowCharacter
	ld de, #menuPos_5_2
	call drawOptionsRefactor


	ld hl, #rightArrowCharacter
	ld de, #menuPos_6_2
	call drawOptionsRefactor

	ld hl, #rightArrowCharacter
	ld de, #menuPos_7_2
	call drawOptionsRefactor

	;; Print the instructions
	ld hl, #menuInstrucString
	ld de, #instrPos
	call drawOptionsRefactor

	;; Print the cursor
	ld	hl, #_sprite_frisbeeMenu
	ld 	de, (cursorPos)
	ld 	b, #cursor_H 		;; B = ent height
	ld 	c, #cursor_W		;; C = ent width
	call cpct_drawSprite_asm

	call printOptions
	ret

;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================

checkUserInput:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Reading keyboard example
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 	call cpct_scanKeyboard_asm
	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
	;; 	cp 	#0 			;; A == 0?
	;; 	jr 	z, up_not_pressed
	;; 		;; Up is pressed code
	;; 		call 	moveUp	
	;; 	up_not_pressed:
	;; 		;; Up is not pressed code
	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
	;; 		cp 	#0 				;; A == 0?
	;; 		jr 	z, down_not_pressed
	;; 			;; Down is pressed code
	;; 			call 	moveDown	
	;; 		down_not_pressed:
	;; 		;; Down is not pressed code

	ret

;; ====================================
;; Clears the cleanScreen
;; Modifies: HL, DE, BC
;; ====================================
cleanScreen::
	;; Clean from C000 to EFFF
	ld	hl, #menuPos_1_sub			;; HL <= Copy pointer
	ld	de, #0xC001			;; DE <= Write pointer
	ld	(hl), #0xFF			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	ret

;; ====================================
;; Write the menu strings
;; Modifies: HL, DE, BC
;; ====================================
initializeMenu:
	call setPaletteM1
	call cleanScreen

	push af
	ld a, #0
	ld (callingFromOpts), a
	pop af

	;; Print Menu
	ld hl, #menuString
	ld de, #menuPos_1_sub
	call drawOptionsRefactor

	;; Print Play
	ld hl, #playString
	ld de, #menuPos_1
	call drawOptionsRefactor

	;; Print Options
	ld hl, #optionsString
	ld de, #menuPos_2
	call drawOptionsRefactor

	ld hl, #menuString
	ld de, #menuPos_3
	call drawOptionsRefactor

	ld hl, #playString
	ld de, #menuPos_4
	call drawOptionsRefactor

	ld hl, #optionsString
	ld de, #menuPos_5
	call drawOptionsRefactor

	ld hl, #menuString
	ld de, #menuPos_6
	call drawOptionsRefactor

	ld hl, #playString
	ld de, #menuPos_7
	call drawOptionsRefactor

	ld hl, #menuInstrucString
	ld de, #instrPos
	call drawOptionsRefactor

	;; Print the cursor
	ld	hl, #_sprite_frisbeeMenu
	ld 	de, (cursorPos)
	ld 	b, #cursor_H 		;; B = height
	ld 	c, #cursor_W		;; C = width
	call cpct_drawSprite_asm

	ret

;; ========================
;; Print Credits
;; ========================
printCreditLine:
	;;ld hl, #elString
	;;ld de, #video_memory
	;;ld c, #Color_Letra
	;;cd b, #Color_fondo
;;
	;;call cpct_drawStringM1_f_asm

	ret