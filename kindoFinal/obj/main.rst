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
                             12 .globl player2_data
                             13 .globl enemy2_data
                             14 .globl game_data
                             15 .globl paletteM1
                             16 .globl paletteM2
                             17 ;;.globl paletteM0
                             18 .globl blackPaletteM1
                             19 ;; ====================================
                             20 ;; ====================================
                             21 ;; GAME PUBLIC DATA
                             22 ;; ====================================
                             23 ;; ====================================
                     0050    24 .equ RIGHT_LIMIT,	80
                     0000    25 .equ LEFT_LIMIT,	0
                     001E    26 .equ TOP_LIMIT,	 	30
                     00C8    27 .equ BOTTOM_LIMIT,	200
                     0028    28 .equ CENTER_LIMIT,	40
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
                              8 ;; .globl setPaletteM0
                              9 .globl setPaletteM1
                             10 .globl setPaletteBlackM1
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
                             19 .globl cpct_drawSprite_asm
                             20 .globl cpct_setInterruptHandler_asm
                             21 .globl cpct_setPALColour_asm
                             22 .globl cpct_drawStringM2_asm
                             23 .globl cpct_drawStringM1_asm
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
   4EA5                      15 _main::
   4EA5 31 00 80      [10]   16 	ld 	sp, #0x8000 			;; Set stack pointer to 8000 to enable double buffer
                             17 
   4EA8 CD DA 67      [17]   18 	call cpct_disableFirmware_asm  ;; Disable the firmware
   4EAB CD 9D 59      [17]   19 call setPaletteBlackM1			;; Sets the palette to black on mode 1.
                             20 
   4EAE 2E 10         [ 7]   21 	ld l, #16					;; Select the border colour
   4EB0 26 54         [ 7]   22 	ld h, #0x54					;; Set the Black Colour
   4EB2 CD B0 5D      [17]   23 	call cpct_setPALColour_asm
                             24 
                             25 	;; Clean from C000 to EFFF
   4EB5 21 00 C0      [10]   26 	ld	hl, #0xC000			;; HL <= Copy pointer
   4EB8 11 01 C0      [10]   27 	ld	de, #0xC001			;; DE <= Write pointer
   4EBB 36 FF         [10]   28 	ld	(hl), #0xFF			;; Set to 0 where HL points
   4EBD 01 00 40      [10]   29 	ld	bc, #0x4000			;; BC <= Times to repeat
   4EC0 ED B0         [21]   30 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                             31 
                             32 	;;call menuStart
   4EC2 CD ED 5A      [17]   33 	call gameStart		;; inicia una partida con los valores de game_data
                             34 
                             35 	;;jr (_main)
