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
                             13 .globl frisbee_checkGoal
                             14 	
                     0017    15 .equ Frisbee_effect_I, 23
                     0018    16 .equ Frisbee_effect_F, 24
                     0008    17 .equ std_eff, 0x0008
                     FFF8    18 .equ std_N_eff, 0xFFF8
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
   056E 00 80                37 videoPtr:	.dw 0x8000
                             38 
                             39 ;; ====================================
                             40 ;; ====================================
                             41 ;; PUBLIC FUNCTIONS
                             42 ;; ====================================
                             43 ;; ====================================
                             44 
                             45 
                             46 ;; ===================================
                             47 ;; Inicia una partida dependiendo
                             48 ;; 	de los atributos de game
                             49 ;; Entrada:
                             50 ;; 	IX => Pointer to game data 
                             51 ;; Modifica IX
                             52 ;; ===================================
   0570                      53 gameStart::
                             54 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             55 	;; Reading game data example
                             56 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             57 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             58 	;;
                             59 	;;	ld 	h, Game_map_L(ix)
                             60 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             61 	;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             62 	;;	ld 	h, Game_time_H(ix)
                             63 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             64 	
                             65 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             66 	;; Modifying game data example
                             67 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             68 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             69 	;;
                             70 	;;	ld 	Game_map_L(ix), #0
                             71 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             72 	;;
                             73 	;;	ld 	Game_time_H(ix), #0
                             74 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             75 
                             76 
   0570 CD 7B 05      [17]   77 	call 	initializeGame
                             78 	;; Configuration staff...
                             79 	;; Configuration staff...
                             80 	;; Configuration staff...
   0573 CD A8 05      [17]   81 	call 	game_loop
   0576 C9            [10]   82 	ret
                             83 
                             84 
                             85 ;; ==================================
                             86 ;; Devuelve el puntero a video en HL
                             87 ;; Devuelve:
                             88 ;;	HL => Pointer to video memory
                             89 ;; ==================================
   0577                      90 getVideoPtr::
   0577 2A 6E 05      [16]   91 	ld	hl, (videoPtr)
   057A C9            [10]   92 	ret
                             93 
                             94 ;; ====================================
                             95 ;; ====================================
                             96 ;; PRIVATE FUNCTIONS
                             97 ;; ====================================
                             98 ;; ====================================
                             99 
                            100 
                            101 ;; ========================
                            102 ;; Initialize game
                            103 ;; ========================
   057B                     104 initializeGame:
   057B CD 0A 06      [17]  105 	call cpct_disableFirmware_asm
                            106 
                            107 	;; Set video mode
                            108 	;; ld 	c, #0
                            109 	;; call cpct_setVideoMode_asm
                            110 
                            111 	;; Set palette
                            112 	;; ld 	hl, #direccion_paleta
                            113 	;; ld 	de, #16
                            114 	;; call cpct_setPalette_asm
                            115 
                            116 	;; Clean from 8000 to BFFF
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   057E 21 00 80      [10]  117 	ld	hl, #0x8000			;; HL <= Copy pointer
   0581 11 01 80      [10]  118 	ld	de, #0x8001			;; DE <= Write pointer
   0584 36 00         [10]  119 	ld	(hl), #00			;; Set to 0 where HL points
   0586 01 00 40      [10]  120 	ld	bc, #0x4000			;; BC <= Times to repeat
   0589 ED B0         [21]  121 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            122 
   058B DD 36 05 00   [19]  123 	ld 	Game_t1points(ix), #0
   058F DD 36 06 00   [19]  124 	ld 	Game_t2points(ix), #0		;; Initialize points to 0
                            125 
                            126 	
   0593 C9            [10]  127 	ret
                            128 
                            129 
   0594                     130 switchBuffers:
                     0027   131 	mem_page = .+1
   0594 2E 20         [ 7]  132 	ld 	l, #0x20
   0596 CD E9 05      [17]  133 	call 	cpct_setVideoMemoryPage_asm
   0599 21 95 05      [10]  134 	ld 	hl, #mem_page
   059C 3E 10         [ 7]  135 	ld	a, #0x10
   059E AE            [ 7]  136 	xor	(hl)
   059F 77            [ 7]  137 	ld	(hl), a
                            138 
   05A0 21 6F 05      [10]  139 	ld	hl, #videoPtr+1
   05A3 3E 40         [ 7]  140 	ld	a, #0x40
   05A5 AE            [ 7]  141 	xor	(hl)
   05A6 77            [ 7]  142 	ld	(hl), a
                            143 
                            144 
   05A7 C9            [10]  145 	ret
                            146 
                            147 
                            148 ;; ============================
                            149 ;; Game loop until end of game
                            150 ;; ============================
   05A8                     151 game_loop:
                            152 
                            153 
                            154 	;; Erase entities
   05A8 CD 1D 04      [17]  155 	call player_erase
   05AB CD 52 03      [17]  156 	call frisbee_erase
                            157 
                            158 	;; Update entities
   05AE CD 2C 04      [17]  159 	call player_update
   05B1 CD 76 03      [17]  160 	call frisbee_update
                            161 
                            162 	;; Draw entities
   05B4 CD 70 04      [17]  163 	call player_draw
   05B7 CD 91 03      [17]  164 	call frisbee_draw
                            165 
   05BA DD 21 F1 02   [14]  166 	ld	ix, #frisbee_data
   05BE CD AD 03      [17]  167 	call frisbee_checkGoal
                            168 
                            169 	;; Wait VSYNC to modify VMEM without blinking
   05C1 CD F2 05      [17]  170 	call cpct_waitVSYNC_asm
   05C4 CD 94 05      [17]  171 	call switchBuffers
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            172 
   05C7 18 DF         [12]  173 	jr (game_loop) 			;; Bucle infinito
   05C9 C9            [10]  174 	ret
