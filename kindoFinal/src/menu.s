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
  Key_Enter        = 0x4000

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
timeString: 			.asciz "Time"
scoreString:			.asciz "Score"
winCondString: 			.asciz "Win Condition"

.equ menuPos_1, 0xC850
.equ menuPos_2, 0xC940
.equ menuPos_3, 0xCA30
.equ menuPos_4, 0xCB20
.equ menuPos_5, 0xCC10
.equ menuPos_6, 0xCD00
.equ menuPos_7, 0xCDF0

;; .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
;; .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
;; .equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
;; .equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.

.equ instrPos, 0xC6E0

.globl _sprite_frisbeeMenu

;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================
menuStart::
	call 	initializeMenu

	ld	hl, #_sprite_frisbeeMenu
	ld 	de, (cursorPos)
	ld 	b, #8 		;; B = ent height
	ld 	c, #2		;; C = ent width
	call cpct_drawSprite_asm

	call checkSelection
	;; if i == 0 -> play
	;; if i == 1 -> options

	;; Do stuff here...
	;; Do stuff here...
	;; Do stuff here...
	ret 



cursor_W 	= 2
cursor_H 	= 8
max_index_value	= 6
addPosition	= 0xF0 			;; Sums to the next position (or substrct to the previous one)
subPosition	= #-240
cursorPos: 	.dw 0xC88F		;; Saves the cursor position


;; =======================================
;; Mueve el índice a la posición indicada
;; Modifica: AF, BC, DE, HL
;; Devuelve:
;;	A <= Selected index [0 - 6]
;; =======================================
checkSelection:: 
	ld	a, #0			;; Initialize A to 0 as starting index

	selection_waitting:
		push 	af

		call 	cpct_scanKeyboard_asm

		ld 	hl, #Key_Enter
		call 	cpct_isKeyPressed_asm	;; A <= True/False
		cp 	#0 
		jr 	z, enter_not_pressed	;; Is enter key pressed?
			pop af			;; A <= final index selected
			ret

		enter_not_pressed:
			pop af			;; A <= index value
			call checkCursor	;; check cursor movement
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
	push 	af			;; Save the index at the stack
	ld 	hl, #Key_CursorUp
	call 	cpct_isKeyPressed_asm	;; A <= True/False
	cp 	#0 
	jr 	z, up_not_pressed	;; Is up key pressed?
		;; Up pressed
			pop af
			dec a
			jp	m, cant_dec_index
				;; decrement index
				push af				;; Save the index

				ld 	hl, (cursorPos)		;; HL <= Cursor position
				ld	de, #subPosition	;; DE <= Negative value to substract to cursor position
				add	hl, de			;; HL <= Cursor position - SubPosition
				call 	reDrawCursor

				ld	a, #10
				call 	wait_X_halts

				pop af				;; Restore the index before looping
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
				push af				;; Save the index

				ld 	hl, (cursorPos)		;; HL <= Cursor position
				ld	de, #addPosition	;; DE <= Positive value to add to cursor position
				add	hl, de			;; HL <= Cursor position + AddPosition
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
;; Espera 8 halts, N veces
;; Entrada:
;;	A <= N times
;; Modifica: A
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

;; Sets the palette to mode 0
;;setPaletteM0::
;;	ld c, #0					;; Mode 0
;;	call cpct_setVideoMode_asm
;;
;;	ld hl, #paletteM0			;; hl <- paletteM0
;;	ld de, #16 					;; 16 Colours
;;	call cpct_setPalette_asm
;;
;;	ret

;; Sets the palette to mode 1
setPaletteM1::
	ld c, #1					;; Mode 1
	call cpct_setVideoMode_asm

	ld hl, #paletteM1			;; hl <- paletteM1
	ld de, #4 					;; 4 Colours
	call cpct_setPalette_asm

	ret

;; Sets the palette to black on mode 1
setPaletteBlackM1::
	ld c, #1					;; Mode 1
	call cpct_setVideoMode_asm

	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
	ld de, #4 					;; 4 Colours
	call cpct_setPalette_asm

	ret

menuOptions::

	;; Clean from C000 to EFFF
	ld	hl, #0xC000			;; HL <= Copy pointer
	ld	de, #0xC001			;; DE <= Write pointer
	ld	(hl), #0xFF			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	;; Print Menu
	ld hl, #winCondString
	ld de, #0xC000
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	menuOptions_iterate:
	call cpct_scanKeyboard_asm
	ld 	hl, #Key_Enter				;; HL <- Key_Space
	call 	cpct_isKeyPressed_asm	;; A = True/False
	cp 	#0 							;; A == 0?
	jr 	z, menuOptions_iterate				;; Iterate
		jp menuStart				;; Go Options (HL presed)

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

;; ========================
;; Write the menu strings
;; ========================
initializeMenu:
	call setPaletteM1

	;; Clean from C000 to EFFF
	ld	hl, #0xC000			;; HL <= Copy pointer
	ld	de, #0xC001			;; DE <= Write pointer
	ld	(hl), #0xFF			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	;; Print Menu
	ld hl, #menuString
	ld de, #0xC000
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	;; Print Play
	ld hl, #playString
	ld de, #menuPos_1
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	;; Print Options
	ld hl, #optionsString
	ld de, #menuPos_2
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #menuString
	ld de, #menuPos_3
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #playString
	ld de, #menuPos_4
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #optionsString
	ld de, #menuPos_5
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #menuString
	ld de, #menuPos_6
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #playString
	ld de, #menuPos_7
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm

	ld hl, #menuInstrucString
	ld de, #instrPos
	ld c, #2
	ld b, #3
	call cpct_drawStringM1_asm
	;; Set video mode
	;; ld 	c, #1 ;; Set mode 1.
	;; call cpct_setVideoMode_as

	;; Set palette
	;; ld 	hl, #direccion_paleta
	;; ld 	de, #16
	;; call cpct_setPalette_asm

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
	;;call cpct_drawStringM1_asm

	ret