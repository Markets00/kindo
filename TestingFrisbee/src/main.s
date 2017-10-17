.area _DATA
.area _CODE

.include "game.h.s"
.include "utility.h.s"


;; .macro defineGame name, type, map, time
defineGame game, #0, #0x0000, #0x012C


;; ========================
;; Initialize system
;; ========================
initializeSystem:
	call cpct_disableFirmware_asm

	;; Set video mode
	;; ld 	c, #0
	;; call cpct_setVideoMode_asm

	;; Set palette
	;; ld 	hl, #direccion_paleta
	;; ld 	de, #16
	;; call cpct_setPalette_asm

	ret

;; ========================
;; Programa principal
;; ========================
_main::
	call initializeSystem

	ld ix, #game_data
	call gameStart		;; inicia una partida con los valores de game_data
