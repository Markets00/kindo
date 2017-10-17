.area _DATA
.area _CODE

.include "game.h.s"


;; .macro defineGame name, type, map, fTime
defineGame game, #0, #0x0000, #0x012C

;; ========================
;; Programa principal
;; ========================
_main::

	ld ix, #game_data
	call gameStart		;; inicia una partida con los valores de game_data