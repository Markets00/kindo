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

.equ sumPos, 0xF0 			;; Sums to the next position (or substrct to the previous one)
.equ subPos, #-240
cursorPos: 	.dw 0xC88F		;; Saves the cursor position
.equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
.equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
;;.equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
;;.equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.

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

	ld a, #0		;; Saving on i the iterator
	call moveCursor
	pop af
	;; if i == 0 -> play
	;; if i == 1 -> options

	;; Do stuff here...
	;; Do stuff here...
	;; Do stuff here...
	ret 

;; reDrawCursor::
;; 
;; 	ld de, #cursorPos
;; 	ld a, #0xFF
;; 	ld c, #2
;; 	ld b, #8
;; 
;; 	call cpct_drawSolidBox_asm
;; 
;; 	ld	hl, _sprite_frisbeeMenu
;; 	ld 	de, (nextCursorPos)
;; 	ld 	b, #8		;; B = ent height
;; 	ld 	c, #2		;; C = ent width
;; 	call cpct_drawSprite_asm
;; 
;; 	ret

;; Entrada: A <= N times
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

moveCursor::
	push af 		;; Saving iterator on the stack

	ld	hl, #_sprite_frisbeeMenu
	ld 	de, (cursorPos)
	ld 	b, #8 		;; B = ent height
	ld 	c, #2		;; C = ent width
	call cpct_drawSprite_asm

	pop af
	moveCursor_iterator:
		push af
		call cpct_scanKeyboard_asm
		ld 	hl, #Key_Enter				;; HL <- Key_Enter
		call 	cpct_isKeyPressed_asm	;; A = True/False
		cp 	#0 							;; A == 0?
		jr 	nz, moveCursor_exit			;; If ENTER , then exit.
			;; Enter not pressed
			ld hl, #Key_CursorUp
			call 	cpct_isKeyPressed_asm	;; A = True/False
			cp 	#0 							;; A == 0?
			jr 	z, checkDown_Movement		;; checkUp_Movement
				;; else: You hitted UP
				pop af 						;; Charge the iterator
				cp #0
				jr z, moveCursor_iterator2
					;; You can go UP
					dec a 					;; a--
					push af
					;; **TODO**: Repintar cursor
						ld hl, (cursorPos)
						ex de, hl
						ld a, #0xFF
						ld c, #2
						ld b, #8

						call cpct_drawSolidBox_asm ;; Destroyed Register values AF, BC, DE, HL

						ld hl, (cursorPos)
						ld de, #subPos
						add hl, de
						ex de, hl

						ld	hl, #_sprite_frisbeeMenu
						ld 	b, #8		;; B = ent height
						ld 	c, #2		;; C = ent width
						call cpct_drawSprite_asm

						jr moveCursor_iterator2

			checkDown_Movement:
				ld hl, #Key_CursorDown
				call 	cpct_isKeyPressed_asm	;; A = True/False
				cp #0
				jr 	z, moveCursor_iterator2		;; Iterate
					;; You hitted DOWN
					pop af 						;; Charge the iterator
					cp #2						;; a - 2 !!! (MAXIMUM OPTION ON MENU)
					jp p, moveCursor_iterator2	;; a==2
						;; You can go down
						inc a
						push af
						;; **TODO**: Repintar cursor
						ld hl, (cursorPos)
						ex de, hl
						ld a, #0xFF
						ld c, #2
						ld b, #8

						call cpct_drawSolidBox_asm ;; Destroyed Register values AF, BC, DE, HL

						ld hl, (cursorPos)
						ld de, #sumPos
						add hl, de
						ex de, hl

						ld	hl, #_sprite_frisbeeMenu
						ld 	b, #8		;; B = ent height
						ld 	c, #2		;; C = ent width
						call cpct_drawSprite_asm

	moveCursor_iterator2:
		ld a, #5
		call wait_X_halts
		jr moveCursor_iterator
	moveCursor_exit:
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