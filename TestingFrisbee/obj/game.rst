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
                             17 .globl cpct_akp_musicPlay_asm
                             18 .globl cpct_akp_stop_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 	
                              8 ;; ====================================
                              9 ;; ====================================
                             10 ;; PUBLIC DATA
                             11 ;; ====================================
                             12 ;; ====================================
                             13 
   0F04                      14 game_data::
   0F04 00                   15 	game_type:		.db #0		;; Game Mode			(8 bits)
   0F05 00 00                16 	game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
   0F07 00 00                17 	game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
   0F09 00                   18 	game_t1points: 		.db #0 		;; Points of team 1		(8 bits)
   0F0A 00                   19 	game_t2points: 		.db #0 		;; Points of team 2		(8 bits)
   0F0B 64                   20 	game_maxPoints: 	.db #100 	;; Quantity of points to win	(8 bits)
   0F0C 00                   21 	game_interruptions: 	.db #0 		;; Counter interruption handler	(8 bits)
                             22 ;; 
                             23 ;; .equ RIGHT_LIMIT,	80
                             24 ;; .equ LEFT_LIMIT,	0
                             25 ;; .equ TOP_LIMIT,	10
                             26 ;; .equ BOTTOM_LIMIT,	200
                             27 ;; .equ CENTER_LIMIT,	40
                             28 
                             29 
                             30 ;; ====================================
                             31 ;; ====================================
                             32 ;; PRIVATE DATA
                             33 ;; ====================================
                             34 ;; ====================================
                             35 
                             36 ;; .equ mi_constante0, 0
                             37 ;; .equ mi_constante1, 1
                             38 	
   0F0D 00 80                39 videoPtr:	.dw 0x8000
                             40 
                             41 ;; ====================================
                             42 ;; ====================================
                             43 ;; PUBLIC FUNCTIONS
                             44 ;; ====================================
                             45 ;; ====================================
                             46 
                             47 
                             48 ;; ===================================
                             49 ;; Inicia una partida dependiendo
                             50 ;; 	de los atributos de game
                             51 ;; ===================================
   0F0F                      52 gameStart::
                             53 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             54 	;; Reading game data example
                             55 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             56 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             57 	;;
                             58 	;;	ld 	h, Game_map_L(ix)
                             59 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             60 	;;
                             61 	;;	ld 	h, Game_time_H(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             62 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             63 	
                             64 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             65 	;; Modifying game data example
                             66 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             67 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             68 	;;
                             69 	;;	ld 	Game_map_L(ix), #0
                             70 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             71 	;;
                             72 	;;	ld 	Game_time_H(ix), #0
                             73 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             74 
                             75 
   0F0F CD 5C 0F      [17]   76 	call 	initializeGame
                             77 	;; Configuration staff...
                             78 	;; Configuration staff...
                             79 	;; Configuration staff...
   0F12 CD 8B 0F      [17]   80 	call 	game_loop
   0F15 C9            [10]   81 	ret
                             82 
                             83 
                             84 ;; ==================================
                             85 ;; Devuelve el puntero a video en HL
                             86 ;; Devuelve:
                             87 ;;	HL => Pointer to video memory
                             88 ;; ==================================
   0F16                      89 getVideoPtr::
   0F16 2A 0D 0F      [16]   90 	ld	hl, (videoPtr)
   0F19 C9            [10]   91 	ret
                             92 
                             93 
                             94 ;; ==================================
                             95 ;; Incrementa los puntos del equipo 1
                             96 ;; Modifica: A, IX
                             97 ;; ==================================
   0F1A                      98 incTeam1Points::
   0F1A 3A 0B 0F      [13]   99 	ld	a, (game_maxPoints)
   0F1D 47            [ 4]  100 	ld 	b, a				;; B <= Max points
                            101 
   0F1E 3A 09 0F      [13]  102 	ld	a, (game_t1points)
   0F21 3C            [ 4]  103 	inc	a				;; A <= Team 1 points + 1
                            104 
   0F22 B8            [ 4]  105 	cp 	b
   0F23 28 03         [12]  106 	jr	z, max_t1_points		;; t1Points+1 == max_points? 
   0F25 32 09 0F      [13]  107 		ld	(game_t1points), a	;; Inc team 1 points
                            108 
   0F28                     109 	max_t1_points:
   0F28 C9            [10]  110 		ret
                            111 
                            112 ;; ==================================
                            113 ;; Incrementa los puntos del equipo 2
                            114 ;; Modifica: A, IX
                            115 ;; ==================================
   0F29                     116 incTeam2Points::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0F29 DD 21 04 0F   [14]  117 	ld 	ix, #game_data
   0F2D 3A 0B 0F      [13]  118 	ld	a, (game_maxPoints)
   0F30 47            [ 4]  119 	ld 	b, a				;; B <= Max points
                            120 
   0F31 3A 0A 0F      [13]  121 	ld	a, (game_t2points)
   0F34 3C            [ 4]  122 	inc	a				;; A <= Team 2 points + 1
                            123 
   0F35 B8            [ 4]  124 	cp 	b
   0F36 28 03         [12]  125 	jr	z, max_t2_points		;; t2Points+1 == max_points? 
   0F38 32 0A 0F      [13]  126 		ld	(game_t2points), a	;; Inc team 2 points
                            127 
   0F3B                     128 	max_t2_points:
   0F3B C9            [10]  129 		ret
                            130 
                            131 ;; alomejor es una función privada
   0F3C                     132 play_music::
   0F3C D9            [ 4]  133 	exx
   0F3D 08            [ 4]  134 	ex af', af
   0F3E F5            [11]  135 	push af
   0F3F C5            [11]  136 	push bc
   0F40 D5            [11]  137 	push de
   0F41 E5            [11]  138 	push hl
                            139 
   0F42 CD 0F 10      [17]  140 	call cpct_akp_musicPlay_asm
                            141 
   0F45 E1            [10]  142 	pop hl
   0F46 D1            [10]  143 	pop de
   0F47 C1            [10]  144 	pop bc
   0F48 F1            [10]  145 	pop af
   0F49 08            [ 4]  146 	ex af', af
   0F4A D9            [ 4]  147 	exx
                            148 
   0F4B C9            [10]  149 	ret
                            150 
                            151 ;; alomejor es una función privada
   0F4C                     152 stop_music::
   0F4C D9            [ 4]  153 	exx
   0F4D 08            [ 4]  154 	ex af', af
   0F4E F5            [11]  155 	push af
   0F4F C5            [11]  156 	push bc
   0F50 D5            [11]  157 	push de
   0F51 E5            [11]  158 	push hl
                            159 
   0F52 CD 72 17      [17]  160 	call cpct_akp_stop_asm
                            161 
   0F55 E1            [10]  162 	pop hl
   0F56 D1            [10]  163 	pop de
   0F57 C1            [10]  164 	pop bc
   0F58 F1            [10]  165 	pop af
   0F59 08            [ 4]  166 	ex af', af
   0F5A D9            [ 4]  167 	exx
                            168 
   0F5B C9            [10]  169 	ret
                            170 
                            171 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            172 ;; ====================================
                            173 ;; ====================================
                            174 ;; PRIVATE FUNCTIONS
                            175 ;; ====================================
                            176 ;; ====================================
                            177 
                            178 
                            179 ;; ========================
                            180 ;; Initialize game
                            181 ;; ========================
   0F5C                     182 initializeGame:
   0F5C CD 73 18      [17]  183 	call cpct_disableFirmware_asm
                            184 
                            185 	;; Set video mode
                            186 	;; ld 	c, #0
                            187 	;; call cpct_setVideoMode_asm
                            188 
                            189 	;; Set palette
                            190 	;; ld 	hl, #direccion_paleta
                            191 	;; ld 	de, #16
                            192 	;; call cpct_setPalette_asm
                            193 
                            194 	;; Clean from 8000 to BFFF
   0F5F 21 00 80      [10]  195 	ld	hl, #0x8000			;; HL <= Copy pointer
   0F62 11 01 80      [10]  196 	ld	de, #0x8001			;; DE <= Write pointer
   0F65 36 00         [10]  197 	ld	(hl), #00			;; Set to 0 where HL points
   0F67 01 00 40      [10]  198 	ld	bc, #0x4000			;; BC <= Times to repeat
   0F6A ED B0         [21]  199 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            200 
   0F6C 21 09 0F      [10]  201 	ld	hl, #game_t1points
   0F6F 36 00         [10]  202 	ld 	(hl), #0
   0F71 21 0A 0F      [10]  203 	ld	hl, #game_t2points
   0F74 36 00         [10]  204 	ld 	(hl), #0		;; Initialize points to 0
                            205 
                            206 	
   0F76 C9            [10]  207 	ret
                            208 
                            209 
   0F77                     210 switchBuffers:
                     0074   211 	mem_page = .+1
   0F77 2E 20         [ 7]  212 	ld 	l, #0x20
   0F79 CD 52 18      [17]  213 	call 	cpct_setVideoMemoryPage_asm
   0F7C 21 78 0F      [10]  214 	ld 	hl, #mem_page
   0F7F 3E 10         [ 7]  215 	ld	a, #0x10
   0F81 AE            [ 7]  216 	xor	(hl)
   0F82 77            [ 7]  217 	ld	(hl), a
                            218 
   0F83 21 0E 0F      [10]  219 	ld	hl, #videoPtr+1
   0F86 3E 40         [ 7]  220 	ld	a, #0x40
   0F88 AE            [ 7]  221 	xor	(hl)
   0F89 77            [ 7]  222 	ld	(hl), a
                            223 
                            224 
   0F8A C9            [10]  225 	ret
                            226 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            227 ;; ============================
                            228 ;; Game loop until end of game
                            229 ;; ============================
   0F8B                     230 game_loop:
                            231 
                            232 
                            233 	;; Erase entities
   0F8B CD B8 0C      [17]  234 	call player_erase
   0F8E CD A4 0B      [17]  235 	call frisbee_erase
                            236 
                            237 	;; Update entities
   0F91 CD C7 0C      [17]  238 	call player_update
   0F94 CD EE 0B      [17]  239 	call frisbee_update
                            240 
                            241 	;; Draw entities
   0F97 CD FC 0C      [17]  242 	call player_draw
   0F9A CD 09 0C      [17]  243 	call frisbee_draw
                            244 
   0F9D DD 21 43 0B   [14]  245 	ld	ix, #frisbee_data
   0FA1 CD 25 0C      [17]  246 	call frisbee_checkGoal
                            247 
                            248 	;; Wait VSYNC to modify VMEM without blinking
   0FA4 CD 5B 18      [17]  249 	call cpct_waitVSYNC_asm
   0FA7 CD 77 0F      [17]  250 	call switchBuffers
                            251 
   0FAA 18 DF         [12]  252 	jr (game_loop) 			;; Bucle infinito
   0FAC C9            [10]  253 	ret
