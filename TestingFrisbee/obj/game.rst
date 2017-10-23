ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "player.h.s"
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



                              5 .include "frisbee.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 	
                              8 ;; ====================================
                              9 ;; ====================================
                             10 ;; PUBLIC DATA
                             11 ;; ====================================
                             12 ;; ====================================
                             13 
                     0000    14 .equ Game_type, 	0	;; Game mode
                     0001    15 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    16 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    17 .equ Game_time_H, 	3	;; High part of match time
                     0004    18 .equ Game_time_L, 	4	;; Low part of match time
                             19 
                     0050    20 .equ RIGHT_LIMIT,	80
                     0000    21 .equ LEFT_LIMIT,	0
                     000A    22 .equ TOP_LIMIT,	 	10
                     00C8    23 .equ BOTTOM_LIMIT,	200
                     0028    24 .equ CENTER_LIMIT,	40
                             25 
                             26 ;; ====================================
                             27 ;; ====================================
                             28 ;; PRIVATE DATA
                             29 ;; ====================================
                             30 ;; ====================================
                             31 
                             32 ;; .equ mi_constante0, 0
                             33 ;; .equ mi_constante1, 1
                             34 
                             35 	
                             36 ;; ====================================
                             37 ;; ====================================
                             38 ;; PUBLIC FUNCTIONS
                             39 ;; ====================================
                             40 ;; ====================================
                             41 
                             42 
                             43 ;; ===================================
                             44 ;; Inicia una partida dependiendo
                             45 ;; 	de los atributos de game
                             46 ;; Entrada:
                             47 ;; 	IX => Pointer to game data 
                             48 ;; Modifica IX
                             49 ;; ===================================
   050B                      50 gameStart::
                             51 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             52 	;; Reading game data example
                             53 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             54 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             55 	;;
                             56 	;;	ld 	h, Game_map_L(ix)
                             57 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             58 	;;
                             59 	;;	ld 	h, Game_time_H(ix)
                             60 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             61 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             62 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             63 	;; Modifying game data example
                             64 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             65 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             66 	;;
                             67 	;;	ld 	Game_map_L(ix), #0
                             68 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             69 	;;
                             70 	;;	ld 	Game_time_H(ix), #0
                             71 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             72 
   050B CD 12 05      [17]   73 	call 	initializeGame
                             74 	;; Configuration staff...
                             75 	;; Configuration staff...
                             76 	;; Configuration staff...
   050E CD 16 05      [17]   77 	call 	game_loop
   0511 C9            [10]   78 	ret
                             79 
                             80 
                             81 ;; ====================================
                             82 ;; ====================================
                             83 ;; PRIVATE FUNCTIONS
                             84 ;; ====================================
                             85 ;; ====================================
                             86 
                             87 
                             88 ;; ========================
                             89 ;; Initialize game
                             90 ;; ========================
   0512                      91 initializeGame:
   0512 CD 62 05      [17]   92 	call cpct_disableFirmware_asm
                             93 
                             94 	;; Set video mode
                             95 	;; ld 	c, #0
                             96 	;; call cpct_setVideoMode_asm
                             97 
                             98 	;; Set palette
                             99 	;; ld 	hl, #direccion_paleta
                            100 	;; ld 	de, #16
                            101 	;; call cpct_setPalette_asm
                            102 
   0515 C9            [10]  103 	ret
                            104 
                            105 
                            106 ;; ============================
                            107 ;; Game loop until end of game
                            108 ;; ============================
   0516                     109 game_loop:
                            110 
                            111 	;; Wait VSYNC to modify VMEM without blinking
   0516 CD 4D 05      [17]  112 	call cpct_waitVSYNC_asm
                            113 
                            114 	;; Erase entities
   0519 CD C5 03      [17]  115 	call player_erase
   051C CD CE 02      [17]  116 	call frisbee_erase
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            117 
                            118 	;; Update entities
   051F CD D4 03      [17]  119 	call player_update
   0522 CD EB 02      [17]  120 	call frisbee_update
                            121 
                            122 	;; Draw entities
   0525 CD 0A 04      [17]  123 	call player_draw
   0528 CD 06 03      [17]  124 	call frisbee_draw
                            125 
   052B 18 E9         [12]  126 	jr (game_loop) 			;; Bucle infinito
   052D C9            [10]  127 	ret
