ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "entity.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; ENTITY PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl entityDraw
                              7 .globl entityErase
                              8 .globl entityCheckCollision
                              9 .globl entityUpdatePhysics
                             10 .globl entityUpdatePosition
                             11 
                             12 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             13 	name'_data::
                             14 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             15 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             16 		name'_h:	.db h		;; Height			(8 bits)
                             17 		name'_w:	.db w		;; Width			(8 bits)
                             18 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             19 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             20 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             21 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             22 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             23 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             24 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             25 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             26 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
                             27 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             28 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             29 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             30 .endm
                             31 
                             32 
                             33 ;; ====================================
                             34 ;; ====================================
                             35 ;; ENTITY PUBLIC DATA
                             36 ;; ====================================
                             37 ;; ====================================
                     0000    38 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    39 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    40 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    41 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    42 .equ Ent_h, 		4	;; Height
                     0005    43 .equ Ent_w, 		5	;; Width
                     0006    44 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    45 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    46 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    47 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    48 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    49 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    50 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    51 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    52 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    53 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    54 .equ Ent_last_x,	16	;; Last x rendered
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0011    55 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    56 .equ Ent_last_y,	18	;; Last y rendered
                     0013    57 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    58 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    59 .equ Ent_clr, 		21	;; Entity color pattern
                     0016    60 .equ Ent_id, 		22	;; Numeric ID
                             61 				;; Frisbee 	0
                             62 				;; Player1 	1
                             63 				;; Enemy1	2
                             64 
                     0003    65 .equ MAX_VEL_X, 3 
                     FFFFFFFD    66 .equ MIN_VEL_X, -3
                     0003    67 .equ MAX_VEL_Y, 3
                     FFFFFFFD    68 .equ MIN_VEL_Y, -3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 .include "utility.h.s"
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



                              6 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 .globl getVideoPtr
                              8 .globl incTeam1Points
                              9 .globl incTeam2Points
                             10 .globl play_music	;; alomejor son privados
                             11 .globl stop_music	;; alomejor son privados
                             12 .globl game_data
                             13 
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; GAME PUBLIC DATA
                             17 ;; ====================================
                             18 ;; ====================================
                     0050    19 .equ RIGHT_LIMIT,	80
                     0000    20 .equ LEFT_LIMIT,	0
                     000A    21 .equ TOP_LIMIT,	 	10
                     00C8    22 .equ BOTTOM_LIMIT,	200
                     0028    23 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 
                              8 
                     0019     9 frisbee_size = 25		;; Size of frisbee structure
                     00D0    10 pos_min_vel = 0x00D0
                     FF30    11 neg_min_vel = 0xFF30
                             12 ;; ====================================
                             13 ;; ====================================
                             14 ;; PUBLIC DATA
                             15 ;; ====================================
                             16 ;; ====================================
                             17 
                     0017    18 .equ Frisbee_effect_I, 23
                     0018    19 .equ Frisbee_effect_F, 24
                     0008    20 .equ std_eff, 0x0008
                     FFF8    21 .equ std_N_eff, 0xFFF8
                             22 
                             23 
                             24 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             25 
   0359                      26 defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #1, #0x0F, #0
   0000                       1 	frisbee_data::
   0359 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   035B 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   035D 10                    4 		frisbee_h:	.db #16		;; Height			(8 bits)
   035E 04                    5 		frisbee_w:	.db #4		;; Width			(8 bits)
   035F FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0361 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0363 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0365 64 00                 9 		frisbee_ay:	.dw #0100		;; Acceleration at Y axis	(16 bits)
   0367 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   0369 27                   11 		frisbee_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   036A 27                   12 		frisbee_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   036B 54                   13 		frisbee_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   036C 54                   14 		frisbee_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   036D 01                   15 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   036E 0F                   16 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   036F 00                   17 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   0370 FF F8                27 	frisbee_effect: .dw #0xF8FF									;; effect
                             28 
   0372                      29 defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
   0019                       1 	init_data::
   0372 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   0374 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   0376 10                    4 		init_h:	.db #16		;; Height			(8 bits)
   0377 04                    5 		init_w:	.db #4		;; Width			(8 bits)
   0378 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   037A 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   037C 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   037E 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0380 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   0382 27                   11 		init_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   0383 27                   12 		init_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   0384 54                   13 		init_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   0385 54                   14 		init_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   0386 01                   15 		init_state:	.db #1	;; Entity enabled/disabled	(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0387 0F                   16 		init_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   0388 00                   17 		init_id:	.db #0		;; Numeric ID			(8 bits)
   0389 FF F8                30 	init_effect: .dw #0xF8FF									;; effect
                             31 
                             32 
                             33 
                             34 ;; ====================================
                             35 ;; ====================================
                             36 ;; PRIVATE DATA
                             37 ;; ====================================
                             38 ;; ====================================
                             39 
                             40 
                             41 ;; ====================================
                             42 ;; ====================================
                             43 ;; PUBLIC FUNCTIONS
                             44 ;; ====================================
                             45 ;; ====================================
                             46 
                             47 ;; =========================================
                             48 ;; Desactiva el frisbee
                             49 ;; Modifica A
                             50 ;; =========================================
   038B                      51 frisbee_setOff::
   038B 3E 00         [ 7]   52 	ld 	a, #0
   038D 32 6D 03      [13]   53 	ld 	(frisbee_state), a
   0390 C9            [10]   54 	ret
                             55 
                             56 ;; ================================================
                             57 ;; Reinicia los datos de la entidad recibida en ix
                             58 ;; Recibe:
                             59 ;; 	IX <= pointer to entity data
                             60 ;; Modifica: HL, IX
                             61 ;; ================================================
   0391                      62 frisbee_restart::
   0391 DD 66 10      [19]   63 	ld	h, Ent_last_x(ix)	;; H <= last_x
   0394 DD 6E 11      [19]   64 	ld	l, Ent_erase_x(ix)	;; L <= erase_x
   0397 E5            [11]   65 	push	hl			;; push last_x and erase_x
                             66 
   0398 DD 66 12      [19]   67 	ld	h, Ent_last_y(ix)	;; H <= last_y
   039B DD 6E 13      [19]   68 	ld	l, Ent_erase_y(ix)	;; L <= erase_y
   039E E5            [11]   69 	push	hl			;; push last_y and erase_y
                             70 
   039F DD 54                71 	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
   03A1 DD 5D                72 	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
   03A3 21 72 03      [10]   73 	ld	hl, #init_data
   03A6 01 19 00      [10]   74 	ld	bc, #frisbee_size
   03A9 CD ED 0F      [17]   75 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             76 
   03AC E1            [10]   77 	pop	hl
   03AD DD 74 12      [19]   78 	ld	Ent_last_y(ix), h	;; last_y <= H
   03B0 DD 75 13      [19]   79 	ld	Ent_erase_y(ix), l	;; erase_y <= L
                             80 
   03B3 E1            [10]   81 	pop	hl
   03B4 DD 74 10      [19]   82 	ld	Ent_last_x(ix), h	;; last_x <= H
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   03B7 DD 75 11      [19]   83 	ld	Ent_erase_x(ix), l	;; erase_x <= L
                             84 
   03BA                      85 frisbee_erase::
   03BA DD 21 59 03   [14]   86 	ld 	ix, #frisbee_data
   03BE CD 38 01      [17]   87 	call entityErase		;; Pintar cuadrado azul fondo
                             88 
   03C1 C9            [10]   89 	ret
                             90 
                             91 
                             92 ;; ================================================
                             93 ;; Modifica el valor de la velocidad del frisbee
                             94 ;; 	en el eje X e Y, al recibido en HL y DE
                             95 ;;	Si la velocidad en el eje X es menor que 1
                             96 ;; 	la modifica a mínimo 1 (positivo y neg)
                             97 ;; Recibe:
                             98 ;;	 A <= entity ID
                             99 ;; 	HL <= X axis velocity
                            100 ;; 	DE <= Y axis velocity
                            101 ;; Modifica: A, HL, IX
                            102 ;; ================================================
   03C2                     103 frisbee_setVelocities::
   03C2 DD 21 59 03   [14]  104 	ld 	ix, #frisbee_data
                            105 
   03C6 FE 01         [ 7]  106 	cp 	#1
   03C8 28 12         [12]  107 	jr	z, player_1				;; Ent_id == 1?
                            108 		;; player 2
   03CA 7C            [ 4]  109 		ld	a, h
   03CB FE 00         [ 7]  110 		cp 	#0
   03CD F2 D7 03      [10]  111 		jp	p, less_than_minus_one		;; Is VX positive? 
                            112 
   03D0 3E 01         [ 7]  113 		ld	a, #1
   03D2 BC            [ 4]  114 		cp	h
   03D3 30 02         [12]  115 		jr	nc, less_than_minus_one
                            116 			;; vx greater than minus one
   03D5 18 15         [12]  117 			jr set_vels
   03D7                     118 		less_than_minus_one:
   03D7 21 30 FF      [10]  119 			ld	hl, #neg_min_vel
   03DA 18 10         [12]  120 			jr set_vels
   03DC                     121 	negative_vx:
                            122 
   03DC                     123 	player_1:
   03DC 7C            [ 4]  124 		ld	a, h
   03DD FE 00         [ 7]  125 		cp 	#0
   03DF FA E9 03      [10]  126 		jp	m, less_than_one		;; Is VX negative? 
                            127 
   03E2 7C            [ 4]  128 		ld	a, h
   03E3 FE 01         [ 7]  129 		cp	#1
   03E5 38 02         [12]  130 		jr	c, less_than_one
                            131 			;; vx greater than one
   03E7 18 03         [12]  132 			jr set_vels
   03E9                     133 		less_than_one:
   03E9 21 D0 00      [10]  134 			ld	hl, #pos_min_vel
                            135 
                            136 
   03EC                     137 	set_vels:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   03EC DD 74 06      [19]  138 	ld 	Ent_vx_I(ix), h
   03EF DD 75 07      [19]  139 	ld 	Ent_vx_F(ix), l
   03F2 DD 72 08      [19]  140 	ld 	Ent_vy_I(ix), d
   03F5 DD 73 09      [19]  141 	ld 	Ent_vy_F(ix), e
   03F8 C9            [10]  142 	ret
                            143 
                            144 
                            145 
                            146 
                            147 ;; ===========================================
                            148 ;; Modifica el valor del efecto del frisbee
                            149 ;; 	al recibido en HL
                            150 ;; Recibe:
                            151 ;; 	HL <= Effect value
                            152 ;; ===========================================
   03F9                     153 frisbee_setEffect::
   03F9 DD 21 59 03   [14]  154 	ld 	ix, #frisbee_data
   03FD DD 74 17      [19]  155 	ld 	Frisbee_effect_I(ix), h
   0400 DD 75 18      [19]  156 	ld 	Frisbee_effect_F(ix), l
   0403 C9            [10]  157 	ret
                            158 
                            159 ;; =========================================
                            160 ;; Actualiza el estado del frisbee
                            161 ;; Modifica A
                            162 ;; =========================================
   0404                     163 frisbee_update::
                            164 
   0404 3A 6D 03      [13]  165 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   0407 FE 01         [ 7]  166 	cp 	#1
   0409 20 0E         [12]  167 	jr 	nz, not_active		;; A != 1?
                            168 	
                            169 		;; Active
   040B DD 21 59 03   [14]  170 		ld 	ix, #frisbee_data
   040F CD 27 04      [17]  171 		call frisbee_applyEffect 	
   0412 CD 52 01      [17]  172 		call entityUpdatePhysics
   0415 CD AC 02      [17]  173 		call entityUpdatePosition
   0418 C9            [10]  174 		ret
                            175 
   0419                     176 	not_active:
   0419 3E 01         [ 7]  177 		ld 	a, #1
   041B 32 6D 03      [13]  178 		ld 	(frisbee_state), a
   041E C9            [10]  179 	ret
                            180 
   041F                     181 frisbee_draw::
                            182 
   041F DD 21 59 03   [14]  183 	ld 	ix, #frisbee_data
   0423 CD 17 01      [17]  184 	call entityDraw 		;; Pintar cuadrado azul cian
                            185 
   0426 C9            [10]  186 	ret
                            187 	
                            188 ;; ====================================
                            189 ;; ====================================
                            190 ;; PRIVATE FUNCTIONS
                            191 ;; ====================================
                            192 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            193 
                            194 
                            195 ;; ===========================================
                            196 ;; Mueve el frisbee a la izquierda un píxel
                            197 ;; Recibe:
                            198 ;; 	IX <= Pointer to entity data
                            199 ;; Modifica A
                            200 ;; ===========================================
   0427                     201 frisbee_applyEffect:
                            202 
                            203 	;; vy' = vy + ay
   0427 DD 66 08      [19]  204 	ld 	h, Ent_vy_I(ix)
   042A DD 6E 09      [19]  205 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   042D DD 56 17      [19]  206 	ld 	d, Frisbee_effect_I(ix)
   0430 DD 5E 18      [19]  207 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            208 
   0433 19            [11]  209 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            210 
   0434 DD 74 08      [19]  211 	ld 	Ent_vy_I(ix), h
   0437 DD 75 09      [19]  212 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            213 
   043A C9            [10]  214 	ret
                            215 
                            216 
                            217 ;; ===========================================
                            218 ;; Comprueba si el frisbee está en posición
                            219 ;;	de gol
                            220 ;; Recibe:
                            221 ;; 	IX <= Pointer to entity data
                            222 ;; Modifica A
                            223 ;; ===========================================
   043B                     224 frisbee_checkGoal::
   043B DD 7E 00      [19]  225 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   043E FE 00         [ 7]  226 	cp	#LEFT_LIMIT
   0440 20 09         [12]  227 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            228 		;; left goal
   0442 DD E5         [15]  229 		push ix
   0444 CD 03 07      [17]  230 		call incTeam2Points
   0447 DD E1         [14]  231 		pop ix
   0449 18 0E         [12]  232 		jr	goal
                            233 
   044B                     234 	no_left_goal:
   044B DD 86 05      [19]  235 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   044E FE 50         [ 7]  236 		cp	#RIGHT_LIMIT
   0450 20 0A         [12]  237 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            238 			;; right goal
   0452 DD E5         [15]  239 			push ix
   0454 CD F4 06      [17]  240 			call incTeam1Points
   0457 DD E1         [14]  241 			pop ix
   0459                     242 	goal:
   0459 CD 91 03      [17]  243 		call frisbee_restart
                            244 
   045C                     245 	no_right_goal:
   045C C9            [10]  246 	ret
