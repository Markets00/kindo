.area _DATA
.area _CODE

.include "utility.h.s"

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



;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================
menuStart::
	call 	initializeMenu
	;; Do stuff here...
	;; Do stuff here...
	;; Do stuff here...
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
;; Initialize menu
;; ========================
initializeMenu:
	;; Set video mode
	;; ld 	c, #1 ;; Set mode 1.
	;; call cpct_setVideoMode_asm

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