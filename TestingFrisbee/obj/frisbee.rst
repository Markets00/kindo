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
                             23 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             24 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             25 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             26 .endm
                             27 
                             28 
                             29 ;; ====================================
                             30 ;; ====================================
                             31 ;; ENTITY PUBLIC DATA
                             32 ;; ====================================
                             33 ;; ====================================
                     0000    34 .equ Ent_x_I, 	0	;; X coordinate, integer part
                     0001    35 .equ Ent_x_F, 	1	;; X coordinate, fractional part
                     0002    36 .equ Ent_y_I, 	2	;; Y coordinate, integer part
                     0003    37 .equ Ent_y_F, 	3	;; Y coordinate, fractional part
                     0004    38 .equ Ent_h, 	4	;; Height
                     0005    39 .equ Ent_w, 	5	;; Width
                     0006    40 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    41 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    42 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    43 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    44 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    45 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    46 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    47 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    48 .equ Ent_N_I,	14	;; Normal force, integer part
                     000F    49 .equ Ent_N_F,	15	;; Normal force, fractional part
                     0010    50 .equ Ent_state,	16	;; Entity enabled/disabled
                     0011    51 .equ Ent_clr, 	17	;; Entity color pattern
                     0012    52 .equ Ent_id, 	18	;; Numeric ID
                             53 			;; Frisbee 	0
                             54 			;; Player1 	1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 			;; Enemy1	2
                             56 
                     0002    57 .equ MAX_VEL_X, 2 
                     FFFFFFFE    58 .equ MIN_VEL_X, -2
                     0004    59 .equ MAX_VEL_Y, 4
                     FFFFFFFC    60 .equ MIN_VEL_Y, -4
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 
                              8 .macro defineGame name, type, map, fTime, t1points, t2points
                              9 	name'_data::
                             10 		name'_type::	.db type	;; Game Mode			(8 bits)
                             11 		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
                             13 		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
                             14 		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
                             15 .endm
                             16 
                             17 ;; ====================================
                             18 ;; ====================================
                             19 ;; GAME PUBLIC DATA
                             20 ;; ====================================
                             21 ;; ====================================
                     0000    22 .equ Game_type, 	0	;; Game mode
                     0001    23 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    24 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    25 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    26 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    27 .equ Game_t1points, 	5	;; Points of team 1
                     0006    28 .equ Game_t2points, 	6	;; Points of team 2
                             29 
                     0050    30 .equ RIGHT_LIMIT,	80
                     0000    31 .equ LEFT_LIMIT,	0
                     000A    32 .equ TOP_LIMIT,	 	10
                     00C8    33 .equ BOTTOM_LIMIT,	200
                     0028    34 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 
                     0013     8 .equ Frisbee_effect_I, 19
                     0014     9 .equ Frisbee_effect_F, 20
                     0800    10 .equ std_eff, 0x0800
                             11 
                     0015    12 frisbee_size = 21		;; Size of frisbee structure
                             13 
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; PUBLIC DATA
                             17 ;; ====================================
                             18 ;; ====================================
                             19 
                             20 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             21 
   02CB                      22 defineEntity frisbee, #0x0027, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
   0000                       1 	frisbee_data::
   02CB 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   02CD 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   02CF 08                    4 		frisbee_h:	.db #8		;; Height			(8 bits)
   02D0 02                    5 		frisbee_w:	.db #2		;; Width			(8 bits)
   02D1 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   02D3 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   02D5 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   02D7 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   02D9 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   02DB 01                   11 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   02DC 0F                   12 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   02DD 00                   13 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   02DE FF F8                23 	frisbee_effect: .dw #0xF8FF									;; effect
                             24 
   02E0                      25 defineEntity init, #0x0027, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
   0015                       1 	init_data::
   02E0 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   02E2 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   02E4 08                    4 		init_h:	.db #8		;; Height			(8 bits)
   02E5 02                    5 		init_w:	.db #2		;; Width			(8 bits)
   02E6 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   02E8 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   02EA 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   02EC 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   02EE 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   02F0 01                   11 		init_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   02F1 0F                   12 		init_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   02F2 00                   13 		init_id:	.db #0		;; Numeric ID			(8 bits)
   02F3 FF F8                26 	init_effect: .dw #0xF8FF									;; effect
                             27 
                             28 
                             29 
                             30 ;; ====================================
                             31 ;; ====================================
                             32 ;; PRIVATE DATA
                             33 ;; ====================================
                             34 ;; ====================================
                             35 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             36 
                             37 ;; ====================================
                             38 ;; ====================================
                             39 ;; PUBLIC FUNCTIONS
                             40 ;; ====================================
                             41 ;; ====================================
                             42 
                             43 ;; =========================================
                             44 ;; Desactiva el frisbee
                             45 ;; Modifica A
                             46 ;; =========================================
   02F5                      47 frisbee_setOff::
   02F5 3E 00         [ 7]   48 	ld 	a, #0
   02F7 32 DB 02      [13]   49 	ld 	(frisbee_state), a
   02FA C9            [10]   50 	ret
                             51 
   02FB                      52 frisbee_restart::
                             53 	;; Input Parameters (6 Bytes)
                             54 	;; (2B DE) to	Pointer to the destination (first byte where bytes will be written)
                             55 	;; (2B HL) from	Pointer to the source (first byte from which bytes will be read)
                             56 	;; (2B BC) size	Number of bytes to be set (>= 1)
   02FB 11 CB 02      [10]   57 	ld	de, #frisbee_data
   02FE 21 E0 02      [10]   58 	ld	hl, #init_data
   0301 01 15 00      [10]   59 	ld	bc, #frisbee_size
   0304 CD D1 05      [17]   60 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             61 
   0307                      62 frisbee_erase::
   0307 DD 21 CB 02   [14]   63 	ld 	ix, #frisbee_data
   030B CD 1B 01      [17]   64 	call entityErase		;; Pintar cuadrado azul fondo
                             65 
   030E C9            [10]   66 	ret
                             67 
                             68 
                             69 ;; ================================================
                             70 ;; Modifica el valor de la velocidad del frisbee
                             71 ;; 	en el eje X e Y, al recibido en HL y DE
                             72 ;; Recibe:
                             73 ;; 	HL <= X axis velocity
                             74 ;; 	DE <= Y axis velocity
                             75 ;; Modifica: HL, IX
                             76 ;; ================================================
   030F                      77 frisbee_setVelocities::
   030F DD 21 CB 02   [14]   78 	ld 	ix, #frisbee_data
   0313 DD 74 06      [19]   79 	ld 	Ent_vx_I(ix), h
   0316 DD 75 07      [19]   80 	ld 	Ent_vx_F(ix), l
   0319 DD 72 08      [19]   81 	ld 	Ent_vy_I(ix), d
   031C DD 73 09      [19]   82 	ld 	Ent_vy_F(ix), e
   031F C9            [10]   83 	ret
                             84 
                             85 
                             86 ;; ===========================================
                             87 ;; Modifica el valor del efecto del frisbee
                             88 ;; 	al recibido en HL
                             89 ;; Recibe:
                             90 ;; 	HL <= Effect value
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             91 ;; ===========================================
   0320                      92 frisbee_setEffect::
   0320 DD 21 CB 02   [14]   93 	ld 	ix, #frisbee_data
   0324 DD 74 13      [19]   94 	ld 	Frisbee_effect_I(ix), h
   0327 DD 75 14      [19]   95 	ld 	Frisbee_effect_F(ix), l
   032A C9            [10]   96 	ret
                             97 
                             98 ;; =========================================
                             99 ;; Actualiza el estado del frisbee
                            100 ;; Modifica A
                            101 ;; =========================================
   032B                     102 frisbee_update::
                            103 
   032B 3A DB 02      [13]  104 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   032E FE 01         [ 7]  105 	cp 	#1
   0330 20 11         [12]  106 	jr 	nz, not_active		;; A != 1?
                            107 	
                            108 		;; Active
   0332 DD 21 CB 02   [14]  109 		ld 	ix, #frisbee_data
   0336 CD 51 03      [17]  110 		call frisbee_applyEffect 	
   0339 CD 34 01      [17]  111 		call entityUpdatePhysics
   033C CD 3C 02      [17]  112 		call entityUpdatePosition
   033F CD 65 03      [17]  113 		call frisbee_checkGoal
                            114 		;; call moveLeft
   0342 C9            [10]  115 		ret
                            116 
   0343                     117 	not_active:
   0343 3E 01         [ 7]  118 		ld 	a, #1
   0345 32 DB 02      [13]  119 		ld 	(frisbee_state), a
   0348 C9            [10]  120 	ret
                            121 
   0349                     122 frisbee_draw::
                            123 
   0349 DD 21 CB 02   [14]  124 	ld 	ix, #frisbee_data
   034D CD 01 01      [17]  125 	call entityDraw 		;; Pintar cuadrado azul cian
                            126 
   0350 C9            [10]  127 	ret
                            128 	
                            129 ;; ====================================
                            130 ;; ====================================
                            131 ;; PRIVATE FUNCTIONS
                            132 ;; ====================================
                            133 ;; ====================================
                            134 
                            135 
                            136 ;; ===========================================
                            137 ;; Mueve el frisbee a la izquierda un píxel
                            138 ;; Recibe:
                            139 ;; 	IX <= Pointer to entity data
                            140 ;; Modifica A
                            141 ;; ===========================================
   0351                     142 frisbee_applyEffect:
                            143 
                            144 	;; vy' = vy + ay
   0351 DD 66 08      [19]  145 	ld 	h, Ent_vy_I(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   0354 DD 6E 09      [19]  146 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0357 DD 56 13      [19]  147 	ld 	d, Frisbee_effect_I(ix)
   035A DD 5E 14      [19]  148 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            149 
   035D 19            [11]  150 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            151 
   035E DD 74 08      [19]  152 	ld 	Ent_vy_I(ix), h
   0361 DD 75 09      [19]  153 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            154 
   0364 C9            [10]  155 	ret
                            156 
                            157 
                            158 ;; ===========================================
                            159 ;; Comprueba si el frisbee está en posición
                            160 ;;	de gol
                            161 ;; Recibe:
                            162 ;; 	IX <= Pointer to entity data
                            163 ;; Modifica A
                            164 ;; ===========================================
   0365                     165 frisbee_checkGoal:
   0365 DD 7E 00      [19]  166 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   0368 FE 00         [ 7]  167 	cp	#LEFT_LIMIT
   036A 20 09         [12]  168 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            169 		;; left goal
   036C 3A 06 00      [13]  170 		ld	a, (Game_t2points)
   036F 3C            [ 4]  171 		inc	a
   0370 32 06 00      [13]  172 		ld	(Game_t2points), a	;; Inc team 2 points
   0373 18 0E         [12]  173 		jr	goal
                            174 
   0375                     175 	no_left_goal:
   0375 DD 86 05      [19]  176 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   0378 FE 50         [ 7]  177 		cp	#RIGHT_LIMIT
   037A 20 0A         [12]  178 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            179 			;; right goal
   037C 3A 05 00      [13]  180 			ld	a, (Game_t1points)
   037F 3C            [ 4]  181 			inc	a
   0380 32 05 00      [13]  182 			ld	(Game_t1points), a 	;; Inc team 1 points
                            183 
   0383                     184 	goal:
   0383 CD FB 02      [17]  185 		call frisbee_restart
                            186 
   0386                     187 	no_right_goal:
   0386 C9            [10]  188 	ret
                            189 
                            190 
                            191 ;; =========================================
                            192 ;; Mueve el frisbee a la derecha un píxel
                            193 ;; Modifica A
                            194 ;; =========================================
   0387                     195 moveRight:
   0387 3A CB 02      [13]  196 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   038A FE 4D         [ 7]  197 	cp 	#80-3 			;; A == right_limit - frisbee_width?
   038C 28 04         [12]  198 	jr 	z, cant_move_right 		
   038E 3C            [ 4]  199 		inc 	a 		;; move right one pixel
   038F 32 CB 02      [13]  200 		ld 	(frisbee_x), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   0392                     201 	cant_move_right:
   0392 C9            [10]  202 	ret
                            203 
                            204 ;; =========================================
                            205 ;; Mueve el frisbee abajo un píxel
                            206 ;; Modifica A
                            207 ;; =========================================
   0393                     208 moveDown:
   0393 3A CD 02      [13]  209 	ld 	a, (frisbee_y) 		;; A = frisbee_x
   0396 FE BC         [ 7]  210 	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
   0398 28 04         [12]  211 	jr 	z, cant_move_down 		
   039A 3C            [ 4]  212 		inc 	a 		;; move down one pixel
   039B 32 CD 02      [13]  213 		ld 	(frisbee_y), a
   039E                     214 	cant_move_down:
   039E C9            [10]  215 	ret
                            216 
                            217 ;; ===========================================
                            218 ;; Mueve el frisbee a la izquierda un píxel
                            219 ;; Recibe:
                            220 ;; 	IX <= Pointer to entity data
                            221 ;; Modifica A
                            222 ;; ===========================================
   039F                     223 moveLeft:
   039F DD 7E 00      [19]  224 	ld 	a, Ent_x_I(IX) 		;; A = frisbee_x
   03A2 FE 00         [ 7]  225 	cp 	#0 			;; A == left_limit?
   03A4 20 07         [12]  226 	jr 	nz, can_move_left 
   03A6 3E 4E         [ 7]  227 		ld 	a, #80-2 	;; restore initial position
   03A8 DD 77 00      [19]  228 		ld 	Ent_x_I(IX), a
                            229 		;; ld 	a, #80
                            230 		;; ld 	(frisbee_y), a	
   03AB 18 0C         [12]  231 		jr 	cant_move_left
   03AD                     232 	can_move_left:	
   03AD DD 21 CB 02   [14]  233 		ld	ix, #frisbee_data
   03B1 DD 36 0A FF   [19]  234 		ld 	Ent_ax_I(ix), #-1
   03B5 DD 36 0B 80   [19]  235 		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)
                            236 
   03B9                     237 	cant_move_left:
   03B9 C9            [10]  238 	ret
                            239 
                            240 ;; =========================================
                            241 ;; Mueve el frisbee arriba un píxel
                            242 ;; Modifica A
                            243 ;; =========================================
   03BA                     244 moveUp:
   03BA 3A CD 02      [13]  245 	ld 	a, (frisbee_y) 		;; A = frisbee_y
   03BD FE 00         [ 7]  246 	cp 	#0 			;; A == top_limit?
   03BF 28 04         [12]  247 	jr 	z, cant_move_up 		
   03C1 3D            [ 4]  248 		dec 	a 		;; move up one pixel
   03C2 32 CD 02      [13]  249 		ld 	(frisbee_y), a
   03C5                     250 	cant_move_up:
   03C5 C9            [10]  251 	ret
                            252 
                            253 ;; ================================================
                            254 ;; Pinta un cuadrado en pantalla del color elegido
                            255 ;; Entrada:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            256 ;; 	A => Colour Pattern
                            257 ;; Modifica AF, BC, DE, HL
                            258 ;; ================================================
   03C6                     259 drawFrisbee:
   03C6 F5            [11]  260 	push 	af 
   03C7 11 00 C0      [10]  261 	ld 	de, #0xC000 		;; Video memory  pointer
   03CA 3A CB 02      [13]  262 	ld 	a, (frisbee_x) 
   03CD 4F            [ 4]  263 	ld 	c, a			;; C = frisbee_x
   03CE 3A CD 02      [13]  264 	ld 	a, (frisbee_y) 
   03D1 47            [ 4]  265 	ld 	b, a 			;; B = frisbee_y
   03D2 CD 91 06      [17]  266 	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer
                            267 
   03D5 EB            [ 4]  268 	ex 	de, hl 			;; DE = frisbee screen pointer
   03D6 F1            [10]  269 	pop 	af 			;; A = User selected colour
   03D7 01 02 08      [10]  270 	ld 	bc, #0x0802		;; 8x8 píxeles
   03DA CD E4 05      [17]  271 	call cpct_drawSolidBox_asm
                            272 
   03DD C9            [10]  273 	ret
