ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 .globl getVideoPtr
                              8 .globl incTeam1Points
                              9 .globl incTeam2Points
                             10 .globl player_data
                             11 .globl enemy_data
                             12 .globl player_2_data
                             13 .globl enemy_2_data
                             14 .globl play_music	;; alomejor son privados
                             15 .globl stop_music	;; alomejor son privados
                             16 .globl game_data
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; GAME PUBLIC DATA
                             21 ;; ====================================
                             22 ;; ====================================
                     0050    23 .equ RIGHT_LIMIT,	80
                     0000    24 .equ LEFT_LIMIT,	0
                     0014    25 .equ TOP_LIMIT,	 	20
                     00C8    26 .equ BOTTOM_LIMIT,	200
                     0028    27 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "menu.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; MENU PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 
                              7 .globl menuStart
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "utility.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; INCLUDED CPCTELERA FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl cpct_waitVSYNC_asm
                              7 .globl cpct_drawSolidBox_asm
                              8 .globl cpct_getScreenPtr_asm
                              9 .globl cpct_scanKeyboard_asm
                             10 .globl cpct_isKeyPressed_asm
                             11 .globl cpct_disableFirmware_asm
                             12 .globl cpct_setVideoMode_asm
                             13 .globl cpct_setPalette_asm
                             14 .globl cpct_memcpy_asm
                             15 .globl negateHL
                             16 .globl cpct_setVideoMemoryPage_asm
                             17 .globl cpct_akp_musicPlay_asm
                             18 .globl cpct_akp_stop_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 
                              8 
                              9 ;; .macro defineGame name, type, map, fTime
                             10 ;; defineGame gameaux, #0, #0x0000, #0x012C
                             11 
                             12 ;; ========================
                             13 ;; Programa principal
                             14 ;; ========================
   0E6C                      15 _main::
   0E6C 31 00 80      [10]   16 	ld 	sp, #0x8000 			;; Set stack pointer to 8000 to enable double buffer
                             17 
   0E6F CD 7D 1B      [17]   18 	call cpct_disableFirmware_asm  ;; Disable the firmware
   0E72 CD A1 10      [17]   19 	call menuStart
   0E75 CD 18 11      [17]   20 	call gameStart		;; inicia una partida con los valores de game_data
                             21 
                             22 	;;jr (_main)
