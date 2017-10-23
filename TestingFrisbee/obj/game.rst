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
                             11 .globl frisbee_setEffect
                             12 .globl frisbee_setVelocities
                             13 	
                     0010    14 .equ Frisbee_effect_I, 16
                     0011    15 .equ Frisbee_effect_F, 17
                     0008    16 .equ std_eff, 08
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
                     0003    17 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    18 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    19 .equ Game_t1points, 	5	;; Points of team 1
                     0006    20 .equ Game_t2points, 	6	;; Points of team 2
                             21 
                     0050    22 .equ RIGHT_LIMIT,	80
                     0000    23 .equ LEFT_LIMIT,	0
                     000A    24 .equ TOP_LIMIT,	 	10
                     00C8    25 .equ BOTTOM_LIMIT,	200
                     0028    26 .equ CENTER_LIMIT,	40
                             27 
                             28 ;; ====================================
                             29 ;; ====================================
                             30 ;; PRIVATE DATA
                             31 ;; ====================================
                             32 ;; ====================================
                             33 
                             34 ;; .equ mi_constante0, 0
                             35 ;; .equ mi_constante1, 1
                             36 	
                             37 ;; ====================================
                             38 ;; ====================================
                             39 ;; PUBLIC FUNCTIONS
                             40 ;; ====================================
                             41 ;; ====================================
                             42 
                             43 
                             44 ;; ===================================
                             45 ;; Inicia una partida dependiendo
                             46 ;; 	de los atributos de game
                             47 ;; Entrada:
                             48 ;; 	IX => Pointer to game data 
                             49 ;; Modifica IX
                             50 ;; ===================================
   0572                      51 gameStart::
                             52 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             53 	;; Reading game data example
                             54 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             55 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             56 	;;
                             57 	;;	ld 	h, Game_map_L(ix)
                             58 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             59 	;;
                             60 	;;	ld 	h, Game_time_H(ix)
                             61 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             62 	
                             63 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             64 	;; Modifying game data example
                             65 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             66 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             67 	;;
                             68 	;;	ld 	Game_map_L(ix), #0
                             69 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             70 	;;
                             71 	;;	ld 	Game_time_H(ix), #0
                             72 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             73 
                             74 
   0572 CD 79 05      [17]   75 	call 	initializeGame
                             76 	;; Configuration staff...
                             77 	;; Configuration staff...
                             78 	;; Configuration staff...
   0575 CD 85 05      [17]   79 	call 	game_loop
   0578 C9            [10]   80 	ret
                             81 
                             82 
                             83 ;; ====================================
                             84 ;; ====================================
                             85 ;; PRIVATE FUNCTIONS
                             86 ;; ====================================
                             87 ;; ====================================
                             88 
                             89 
                             90 ;; ========================
                             91 ;; Initialize game
                             92 ;; ========================
   0579                      93 initializeGame:
   0579 CD D4 05      [17]   94 	call cpct_disableFirmware_asm
                             95 
                             96 	;; Set video mode
                             97 	;; ld 	c, #0
                             98 	;; call cpct_setVideoMode_asm
                             99 
                            100 	;; Set palette
                            101 	;; ld 	hl, #direccion_paleta
                            102 	;; ld 	de, #16
                            103 	;; call cpct_setPalette_asm
                            104 	
   057C DD 36 05 00   [19]  105 	ld 	Game_t1points(ix), #0
   0580 DD 36 06 00   [19]  106 	ld 	Game_t2points(ix), #0		;; Initialize points to 0
                            107 
   0584 C9            [10]  108 	ret
                            109 
                            110 
                            111 ;; ============================
                            112 ;; Game loop until end of game
                            113 ;; ============================
   0585                     114 game_loop:
                            115 
                            116 	;; Wait VSYNC to modify VMEM without blinking
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0585 CD BC 05      [17]  117 	call cpct_waitVSYNC_asm
                            118 
                            119 	;; Erase entities
   0588 CD 21 04      [17]  120 	call player_erase
   058B CD 07 03      [17]  121 	call frisbee_erase
                            122 
                            123 	;; Update entities
   058E CD 30 04      [17]  124 	call player_update
   0591 CD 2B 03      [17]  125 	call frisbee_update
                            126 
                            127 	;; Draw entities
   0594 CD 74 04      [17]  128 	call player_draw
   0597 CD 49 03      [17]  129 	call frisbee_draw
                            130 
   059A 18 E9         [12]  131 	jr (game_loop) 			;; Bucle infinito
   059C C9            [10]  132 	ret
