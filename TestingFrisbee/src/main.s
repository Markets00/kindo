.area _DATA
.area _CODE

.include "game.h.s"
.include "menu.h.s"


;; .macro defineGame name, type, map, fTime, t1points, t2points
defineGame game, #0, #0x0000, #0x012C, #0, #0

;; .macro defineGame name, type, map, fTime
;; defineGame gameaux, #0, #0x0000, #0x012C

;; ========================
;; Programa principal
;; ========================
_main::
	ld ix, #game_data
	call menuStart
	call gameStart		;; inicia una partida con los valores de game_data

	jr (_main)