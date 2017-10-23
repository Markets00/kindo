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
   0580 00 80                37 videoPtr:	.dw 0x8000
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
   0582                      53 gameStart::
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
   0582 CD 9D 05      [17]   77 	call 	initializeGame
                             78 	;; Configuration staff...
                             79 	;; Configuration staff...
                             80 	;; Configuration staff...
   0585 CD CA 05      [17]   81 	call 	game_loop
   0588 C9            [10]   82 	ret
                             83 
                             84 
                             85 ;; ==================================
                             86 ;; Devuelve el puntero a video en HL
                             87 ;; Devuelve:
                             88 ;;	HL => Pointer to video memory
                             89 ;; ==================================
   0589                      90 getVideoPtr::
   0589 2A 80 05      [16]   91 	ld	hl, (videoPtr)
   058C C9            [10]   92 	ret
                             93 
                             94 
                             95 ;; ==================================
                             96 ;; Incrementa los puntos del equipo 1
                             97 ;; Modifica: A
                             98 ;; ==================================
   058D                      99 incTeam1Points::
   058D 3A 05 00      [13]  100 	ld	a, (Game_t1points)
   0590 3C            [ 4]  101 	inc	a
   0591 32 05 00      [13]  102 	ld	(Game_t1points), a	;; Inc team 1 points
   0594 C9            [10]  103 	ret
                            104 
                            105 ;; ==================================
                            106 ;; Incrementa los puntos del equipo 2
                            107 ;; Modifica: A
                            108 ;; ==================================
   0595                     109 incTeam2Points::
   0595 3A 06 00      [13]  110 	ld	a, (Game_t2points)
   0598 3C            [ 4]  111 	inc	a
   0599 32 06 00      [13]  112 	ld	(Game_t2points), a	;; Inc team 2 points
   059C C9            [10]  113 	ret
                            114 
                            115 ;; ====================================
                            116 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            117 ;; PRIVATE FUNCTIONS
                            118 ;; ====================================
                            119 ;; ====================================
                            120 
                            121 
                            122 ;; ========================
                            123 ;; Initialize game
                            124 ;; ========================
   059D                     125 initializeGame:
   059D CD 2C 06      [17]  126 	call cpct_disableFirmware_asm
                            127 
                            128 	;; Set video mode
                            129 	;; ld 	c, #0
                            130 	;; call cpct_setVideoMode_asm
                            131 
                            132 	;; Set palette
                            133 	;; ld 	hl, #direccion_paleta
                            134 	;; ld 	de, #16
                            135 	;; call cpct_setPalette_asm
                            136 
                            137 	;; Clean from 8000 to BFFF
   05A0 21 00 80      [10]  138 	ld	hl, #0x8000			;; HL <= Copy pointer
   05A3 11 01 80      [10]  139 	ld	de, #0x8001			;; DE <= Write pointer
   05A6 36 00         [10]  140 	ld	(hl), #00			;; Set to 0 where HL points
   05A8 01 00 40      [10]  141 	ld	bc, #0x4000			;; BC <= Times to repeat
   05AB ED B0         [21]  142 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            143 
   05AD DD 36 05 00   [19]  144 	ld 	Game_t1points(ix), #0
   05B1 DD 36 06 00   [19]  145 	ld 	Game_t2points(ix), #0		;; Initialize points to 0
                            146 
                            147 	
   05B5 C9            [10]  148 	ret
                            149 
                            150 
   05B6                     151 switchBuffers:
                     0037   152 	mem_page = .+1
   05B6 2E 20         [ 7]  153 	ld 	l, #0x20
   05B8 CD 0B 06      [17]  154 	call 	cpct_setVideoMemoryPage_asm
   05BB 21 B7 05      [10]  155 	ld 	hl, #mem_page
   05BE 3E 10         [ 7]  156 	ld	a, #0x10
   05C0 AE            [ 7]  157 	xor	(hl)
   05C1 77            [ 7]  158 	ld	(hl), a
                            159 
   05C2 21 81 05      [10]  160 	ld	hl, #videoPtr+1
   05C5 3E 40         [ 7]  161 	ld	a, #0x40
   05C7 AE            [ 7]  162 	xor	(hl)
   05C8 77            [ 7]  163 	ld	(hl), a
                            164 
                            165 
   05C9 C9            [10]  166 	ret
                            167 
                            168 
                            169 ;; ============================
                            170 ;; Game loop until end of game
                            171 ;; ============================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   05CA                     172 game_loop:
                            173 
                            174 
                            175 	;; Erase entities
   05CA CD 2F 04      [17]  176 	call player_erase
   05CD CD 52 03      [17]  177 	call frisbee_erase
                            178 
                            179 	;; Update entities
   05D0 CD 3E 04      [17]  180 	call player_update
   05D3 CD 90 03      [17]  181 	call frisbee_update
                            182 
                            183 	;; Draw entities
   05D6 CD 82 04      [17]  184 	call player_draw
   05D9 CD AB 03      [17]  185 	call frisbee_draw
                            186 
   05DC DD 21 F1 02   [14]  187 	ld	ix, #frisbee_data
   05E0 CD C7 03      [17]  188 	call frisbee_checkGoal
                            189 
                            190 	;; Wait VSYNC to modify VMEM without blinking
   05E3 CD 14 06      [17]  191 	call cpct_waitVSYNC_asm
   05E6 CD B6 05      [17]  192 	call switchBuffers
                            193 
   05E9 18 DF         [12]  194 	jr (game_loop) 			;; Bucle infinito
   05EB C9            [10]  195 	ret
