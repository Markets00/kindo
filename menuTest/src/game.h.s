;; ====================================
;; ====================================
;; GAME PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl gameStart
.globl getVideoPtr
.globl incTeam1Points
.globl incTeam2Points
.globl player_data
.globl enemy_data
.globl player_2_data
.globl enemy_2_data
.globl play_music	;; alomejor son privados
.globl stop_music	;; alomejor son privados
.globl game_data

;; ====================================
;; ====================================
;; GAME PUBLIC DATA
;; ====================================
;; ====================================
.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	20
.equ BOTTOM_LIMIT,	200
.equ CENTER_LIMIT,	40