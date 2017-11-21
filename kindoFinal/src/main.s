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

	call menuStart
	call gameStart		;; inicia una partida con los valores de game_data

	jr (_main)
