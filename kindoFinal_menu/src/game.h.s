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
.globl player2_data
.globl enemy2_data
.globl game_data
.globl paletteM1
.globl paletteM2
;;.globl paletteM0
.globl blackPaletteM1

.globl game_type
.globl game_numPlayers
.globl game_WinCondition

.globl game_maxScore
.globl game_t1Score
.globl game_t2Score

.globl game_minute
.globl game_secLeft
.globl game_secRight
.globl game_maxTime
.globl game_map

.globl game_musicOptions
.globl game_timeOptions

.globl game_interrMusic
.globl game_interrTime
.globl game_musicPlayer
.globl game_musicEffects

.globl game_enableMusic


;; ====================================
;; ====================================
;; GAME PUBLIC DATA
;; ====================================
;; ====================================
.equ RIGHT_LIMIT,	80
.equ LEFT_LIMIT,	0
.equ TOP_LIMIT,	 	30
.equ BOTTOM_LIMIT,	200
.equ CENTER_LIMIT,	40
