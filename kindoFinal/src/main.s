.area _DATA
.area _CODE

.include "game.h.s"
.include "menu.h.s"
.include "utility.h.s"


;; .macro defineGame name, type, map, fTime
;; defineGame gameaux, #0, #0x0000, #0x012C

;; ========================
;; Programa principal
;; ========================
_main::
	ld 	sp, #0x8000 			;; Set stack pointer to 8000 to enable double buffer

	call cpct_disableFirmware_asm  ;; Disable the firmware
call setPaletteBlackM1			;; Sets the palette to black on mode 1.

	ld l, #16					;; Select the border colour
	ld h, #0x54					;; Set the Black Colour
	call cpct_setPALColour_asm

	;; Clean from C000 to EFFF
	ld	hl, #0xC000			;; HL <= Copy pointer
	ld	de, #0xC001			;; DE <= Write pointer
	ld	(hl), #0xFF			;; Set to 0 where HL points
	ld	bc, #0x4000			;; BC <= Times to repeat
	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times

	;;call menuStart
	call gameStart		;; inicia una partida con los valores de game_data

	;;jr (_main)
