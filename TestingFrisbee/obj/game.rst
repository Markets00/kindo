ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
                              4 ;; ====================================
                              5 ;; ====================================
                              6 ;; PUBLIC DATA
                              7 ;; ====================================
                              8 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              9 .include "player.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; PLAYER PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 .globl player_erase
                              7 .globl player_update
                              8 .globl player_draw
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             10 .include "frisbee.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; FRISBEE PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 .globl frisbee_erase
                              7 .globl frisbee_update
                              8 .globl frisbee_draw
                              9 .globl frisbee_data
                             10 .globl frisbee_setOff
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             11 .include "utility.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             12 
                     0000    13 .equ Game_type, 	0	;; Game mode
                     0001    14 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    15 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    16 .equ Game_time_H, 	3	;; High part of match time
                     0004    17 .equ Game_time_L, 	4	;; Low part of match time
                             18 
                     0050    19 .equ RIGHT_LIMIT,	80
                     0000    20 .equ LEFT_LIMIT,	0
                     0000    21 .equ TOP_LIMIT,	 	0
                     00C8    22 .equ BOTTOM_LIMIT,	200
                             23 
                             24 ;; ====================================
                             25 ;; ====================================
                             26 ;; PRIVATE DATA
                             27 ;; ====================================
                             28 ;; ====================================
                             29 
                             30 	
                             31 ;; ====================================
                             32 ;; ====================================
                             33 ;; PUBLIC FUNCTIONS
                             34 ;; ====================================
                             35 ;; ====================================
                             36 
                             37 
                             38 ;; ===================================
                             39 ;; Inicia una partida dependiendo
                             40 ;; 	de los atributos de game
                             41 ;; Entrada:
                             42 ;; 	IX => Pointer to game data 
                             43 ;; Modifica IX
                             44 ;; ===================================
   03A2                      45 gameStart::
                             46 	;; Reading game data example
                             47 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             48 	;;
                             49 	;;	ld 	h, Game_map_L(ix)
                             50 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             51 	;;
                             52 	;;	ld 	h, Game_time_H(ix)
                             53 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             54 
                             55 	;; Modifying game data example
                             56 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             57 	;;
                             58 	;;	ld 	Game_map_L(ix), #0
                             59 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             60 	;;
                             61 	;;	ld 	Game_time_H(ix), #0
                             62 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             63 
   03A2 CD A9 03      [17]   64 	call 	initializeGame
                             65 	;; Configuration staff...
                             66 	;; Configuration staff...
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             67 	;; Configuration staff...
   03A5 CD AD 03      [17]   68 	call 	game_loop
   03A8 C9            [10]   69 	ret
                             70 
                             71 
                             72 ;; ====================================
                             73 ;; ====================================
                             74 ;; PRIVATE FUNCTIONS
                             75 ;; ====================================
                             76 ;; ====================================
                             77 
                             78 
                             79 ;; ========================
                             80 ;; Initialize game
                             81 ;; ========================
   03A9                      82 initializeGame:
   03A9 CD F9 03      [17]   83 	call cpct_disableFirmware_asm
                             84 
                             85 	;; Set video mode
                             86 	;; ld 	c, #0
                             87 	;; call cpct_setVideoMode_asm
                             88 
                             89 	;; Set palette
                             90 	;; ld 	hl, #direccion_paleta
                             91 	;; ld 	de, #16
                             92 	;; call cpct_setPalette_asm
                             93 
   03AC C9            [10]   94 	ret
                             95 
                             96 
                             97 ;; ============================
                             98 ;; Game loop until end of game
                             99 ;; ============================
   03AD                     100 game_loop:
                            101 
                            102 	;; Wait VSYNC to modify VMEM without blinking
   03AD CD E4 03      [17]  103 	call cpct_waitVSYNC_asm
                            104 
                            105 	;; Erase entities
   03B0 CD CF 02      [17]  106 	call player_erase
   03B3 CD 19 02      [17]  107 	call frisbee_erase
                            108 
                            109 	;; Update entities
   03B6 CD DE 02      [17]  110 	call player_update
   03B9 CD 21 02      [17]  111 	call frisbee_update
                            112 
                            113 	;; Draw entities
   03BC CD F0 02      [17]  114 	call player_draw
   03BF CD 39 02      [17]  115 	call frisbee_draw
                            116 
   03C2 18 E9         [12]  117 	jr (game_loop) 			;; Bucle infinito
   03C4 C9            [10]  118 	ret
