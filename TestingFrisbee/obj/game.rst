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



                              7 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 .globl getVideoPtr
                              8 .globl incTeam1Points
                              9 .globl incTeam2Points
                             10 
                             11 .macro defineGame name, type, map, fTime
                             12 	name'_data::
                             13 		name'_type::		.db type	;; Game Mode			(8 bits)
                             14 		name'_map::		.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             15 		name'_fTime::		.dw fTime	;; Final duration of each match	(16 bits)
                             16 		name'_t1points:: 	.db 0 		;; Points of team 1		(8 bits)
                             17 		name'_t2points:: 	.db 0 		;; Points of team 2		(8 bits)
                             18 		name'_maxPoints:: 	.db 100 	;; Quantity of points to win	(8 bits)
                             19 .endm
                             20 
                             21 ;; ====================================
                             22 ;; ====================================
                             23 ;; GAME PUBLIC DATA
                             24 ;; ====================================
                             25 ;; ====================================
                     0000    26 .equ Game_type, 	0	;; Game mode
                     0001    27 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    28 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    29 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    30 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    31 .equ Game_t1points, 	5	;; Points of team 1
                     0006    32 .equ Game_t2points, 	6	;; Points of team 2
                     0007    33 .equ Game_max_points, 	7	;; maximum of points
                             34 
                     0050    35 .equ RIGHT_LIMIT,	80
                     0000    36 .equ LEFT_LIMIT,	0
                     000A    37 .equ TOP_LIMIT,	 	10
                     00C8    38 .equ BOTTOM_LIMIT,	200
                     0028    39 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 	
                              9 ;; ====================================
                             10 ;; ====================================
                             11 ;; PUBLIC DATA
                             12 ;; ====================================
                             13 ;; ====================================
                             14 
                             15 ;; .equ Game_type, 	0	;; Game mode
                             16 ;; .equ Game_map_L, 	1	;; Low part of pointer to game map
                             17 ;; .equ Game_map_H, 	2	;; High part of pointer to game map
                             18 ;; .equ Game_fTime_H, 	3	;; High part of final match time
                             19 ;; .equ Game_fTime_L, 	4	;; Low part of final match time
                             20 ;; .equ Game_t1points, 	5	;; Points of team 1
                             21 ;; .equ Game_t2points, 	6	;; Points of team 2
                             22 ;; .equ Game_max_points, 	7	;; maximum of points
                             23 ;; 
                             24 ;; .equ RIGHT_LIMIT,	80
                             25 ;; .equ LEFT_LIMIT,	0
                             26 ;; .equ TOP_LIMIT,	 	10
                             27 ;; .equ BOTTOM_LIMIT,	200
                             28 ;; .equ CENTER_LIMIT,	40
                             29 
                             30 
                             31 
                             32 ;; .macro defineGame name, type, map, fTime
   0605                      33 defineGame game, #0, #0x0000, #0x012C
   0000                       1 	game_data::
   0605 00                    2 		game_type::		.db #0	;; Game Mode			(8 bits)
   0606 00 00                 3 		game_map::		.dw #0x0000		;; Pointer to map of tiles	(16 bits little endian)
   0608 2C 01                 4 		game_fTime::		.dw #0x012C	;; Final duration of each match	(16 bits)
   060A 00                    5 		game_t1points:: 	.db 0 		;; Points of team 1		(8 bits)
   060B 00                    6 		game_t2points:: 	.db 0 		;; Points of team 2		(8 bits)
   060C 64                    7 		game_maxPoints:: 	.db 100 	;; Quantity of points to win	(8 bits)
                             34 
                             35 ;; ====================================
                             36 ;; ====================================
                             37 ;; PRIVATE DATA
                             38 ;; ====================================
                             39 ;; ====================================
                             40 
                             41 ;; .equ mi_constante0, 0
                             42 ;; .equ mi_constante1, 1
                             43 	
   060D 00 80                44 videoPtr:	.dw 0x8000
                             45 
                             46 ;; ====================================
                             47 ;; ====================================
                             48 ;; PUBLIC FUNCTIONS
                             49 ;; ====================================
                             50 ;; ====================================
                             51 
                             52 
                             53 ;; ===================================
                             54 ;; Inicia una partida dependiendo
                             55 ;; 	de los atributos de game
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             56 ;; ===================================
   060F                      57 gameStart::
                             58 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             59 	;; Reading game data example
                             60 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             61 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             62 	;;
                             63 	;;	ld 	h, Game_map_L(ix)
                             64 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             65 	;;
                             66 	;;	ld 	h, Game_time_H(ix)
                             67 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             68 	
                             69 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             70 	;; Modifying game data example
                             71 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             72 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             73 	;;
                             74 	;;	ld 	Game_map_L(ix), #0
                             75 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             76 	;;
                             77 	;;	ld 	Game_time_H(ix), #0
                             78 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             79 
                             80 
   060F CD 40 06      [17]   81 	call 	initializeGame
                             82 	;; Configuration staff...
                             83 	;; Configuration staff...
                             84 	;; Configuration staff...
   0612 CD 6D 06      [17]   85 	call 	game_loop
   0615 C9            [10]   86 	ret
                             87 
                             88 
                             89 ;; ==================================
                             90 ;; Devuelve el puntero a video en HL
                             91 ;; Devuelve:
                             92 ;;	HL => Pointer to video memory
                             93 ;; ==================================
   0616                      94 getVideoPtr::
   0616 2A 0D 06      [16]   95 	ld	hl, (videoPtr)
   0619 C9            [10]   96 	ret
                             97 
                             98 
                             99 ;; ==================================
                            100 ;; Incrementa los puntos del equipo 1
                            101 ;; Modifica: A, IX
                            102 ;; ==================================
   061A                     103 incTeam1Points::
   061A DD 21 05 06   [14]  104 	ld 	ix, #game_data
   061E DD 7E 07      [19]  105 	ld	a, Game_max_points(ix)
   0621 47            [ 4]  106 	ld 	b, a				;; B <= Max points
                            107 
   0622 DD 7E 05      [19]  108 	ld	a, Game_t1points(ix)
   0625 3C            [ 4]  109 	inc	a				;; A <= Team 1 points + 1
                            110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0626 B8            [ 4]  111 	cp 	b
   0627 28 03         [12]  112 	jr	z, max_t1_points		;; t1Points+1 == max_points? 
   0629 DD 77 05      [19]  113 		ld	Game_t1points(ix), a	;; Inc team 1 points
                            114 
   062C                     115 	max_t1_points:
   062C C9            [10]  116 		ret
                            117 
                            118 ;; ==================================
                            119 ;; Incrementa los puntos del equipo 2
                            120 ;; Modifica: A, IX
                            121 ;; ==================================
   062D                     122 incTeam2Points::
   062D DD 21 05 06   [14]  123 	ld 	ix, #game_data
   0631 DD 7E 07      [19]  124 	ld	a, Game_max_points(ix)
   0634 47            [ 4]  125 	ld 	b, a				;; B <= Max points
                            126 
   0635 DD 7E 06      [19]  127 	ld	a, Game_t2points(ix)
   0638 3C            [ 4]  128 	inc	a				;; A <= Team 1 points + 1
                            129 
   0639 B8            [ 4]  130 	cp 	b
   063A 28 03         [12]  131 	jr	z, max_t2_points		;; t1Points+1 == max_points? 
   063C DD 77 05      [19]  132 		ld	Game_t1points(ix), a	;; Inc team 1 points
                            133 
   063F                     134 	max_t2_points:
   063F C9            [10]  135 		ret
                            136 
                            137 ;; ====================================
                            138 ;; ====================================
                            139 ;; PRIVATE FUNCTIONS
                            140 ;; ====================================
                            141 ;; ====================================
                            142 
                            143 
                            144 ;; ========================
                            145 ;; Initialize game
                            146 ;; ========================
   0640                     147 initializeGame:
   0640 CD CF 06      [17]  148 	call cpct_disableFirmware_asm
                            149 
                            150 	;; Set video mode
                            151 	;; ld 	c, #0
                            152 	;; call cpct_setVideoMode_asm
                            153 
                            154 	;; Set palette
                            155 	;; ld 	hl, #direccion_paleta
                            156 	;; ld 	de, #16
                            157 	;; call cpct_setPalette_asm
                            158 
                            159 	;; Clean from 8000 to BFFF
   0643 21 00 80      [10]  160 	ld	hl, #0x8000			;; HL <= Copy pointer
   0646 11 01 80      [10]  161 	ld	de, #0x8001			;; DE <= Write pointer
   0649 36 00         [10]  162 	ld	(hl), #00			;; Set to 0 where HL points
   064B 01 00 40      [10]  163 	ld	bc, #0x4000			;; BC <= Times to repeat
   064E ED B0         [21]  164 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            165 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   0650 DD 36 05 00   [19]  166 	ld 	Game_t1points(ix), #0
   0654 DD 36 06 00   [19]  167 	ld 	Game_t2points(ix), #0		;; Initialize points to 0
                            168 
                            169 	
   0658 C9            [10]  170 	ret
                            171 
                            172 
   0659                     173 switchBuffers:
                     0055   174 	mem_page = .+1
   0659 2E 20         [ 7]  175 	ld 	l, #0x20
   065B CD AE 06      [17]  176 	call 	cpct_setVideoMemoryPage_asm
   065E 21 5A 06      [10]  177 	ld 	hl, #mem_page
   0661 3E 10         [ 7]  178 	ld	a, #0x10
   0663 AE            [ 7]  179 	xor	(hl)
   0664 77            [ 7]  180 	ld	(hl), a
                            181 
   0665 21 0E 06      [10]  182 	ld	hl, #videoPtr+1
   0668 3E 40         [ 7]  183 	ld	a, #0x40
   066A AE            [ 7]  184 	xor	(hl)
   066B 77            [ 7]  185 	ld	(hl), a
                            186 
                            187 
   066C C9            [10]  188 	ret
                            189 
                            190 
                            191 ;; ============================
                            192 ;; Game loop until end of game
                            193 ;; ============================
   066D                     194 game_loop:
                            195 
                            196 
                            197 	;; Erase entities
   066D CD 2C 04      [17]  198 	call player_erase
   0670 CD 52 03      [17]  199 	call frisbee_erase
                            200 
                            201 	;; Update entities
   0673 CD 3B 04      [17]  202 	call player_update
   0676 CD 90 03      [17]  203 	call frisbee_update
                            204 
                            205 	;; Draw entities
   0679 CD 74 04      [17]  206 	call player_draw
   067C CD AB 03      [17]  207 	call frisbee_draw
                            208 
   067F DD 21 F1 02   [14]  209 	ld	ix, #frisbee_data
   0683 CD C7 03      [17]  210 	call frisbee_checkGoal
                            211 
                            212 	;; Wait VSYNC to modify VMEM without blinking
   0686 CD B7 06      [17]  213 	call cpct_waitVSYNC_asm
   0689 CD 59 06      [17]  214 	call switchBuffers
                            215 
   068C 18 DF         [12]  216 	jr (game_loop) 			;; Bucle infinito
   068E C9            [10]  217 	ret
