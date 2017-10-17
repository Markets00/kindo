.area _DATA
.area _CODE

.include "player.h.s"
.include "frisbee.h.s"
.include "utility.h.s"
.globl player_data
.globl enemy_data


;; ========================
;; Initialize system
;; ========================
initializeGame:
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
	call initializeGame

	call player_erase
	call frisbee_erase

	call player_update
	call frisbee_update

	call player_draw
	call frisbee_draw

	
	call cpct_waitVSYNC_asm

	jr (_main) 			;; Bucle infinito
