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
                     0002    65 .equ MAX_VEL_X, 2 
                     FFFFFFFE    66 .equ MIN_VEL_X, -2
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
                              8 
                              9 .macro defineGame name, type, map, fTime, t1points, t2points
                             10 	name'_data::
                             11 		name'_type::	.db type	;; Game Mode			(8 bits)
                             12 		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             13 		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
                             14 		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
                             15 		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
                             16 .endm
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; GAME PUBLIC DATA
                             21 ;; ====================================
                             22 ;; ====================================
                     0000    23 .equ Game_type, 	0	;; Game mode
                     0001    24 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    25 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    26 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    27 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    28 .equ Game_t1points, 	5	;; Points of team 1
                     0006    29 .equ Game_t2points, 	6	;; Points of team 2
                             30 
                     0050    31 .equ RIGHT_LIMIT,	80
                     0000    32 .equ LEFT_LIMIT,	0
                     000A    33 .equ TOP_LIMIT,	 	10
                     00C8    34 .equ BOTTOM_LIMIT,	200
                     0028    35 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 
                              8 
                     0019     9 frisbee_size = 25		;; Size of frisbee structure
                             10 
                             11 ;; ====================================
                             12 ;; ====================================
                             13 ;; PUBLIC DATA
                             14 ;; ====================================
                             15 ;; ====================================
                             16 
                     0017    17 .equ Frisbee_effect_I, 23
                     0018    18 .equ Frisbee_effect_F, 24
                     0008    19 .equ std_eff, 0x0008
                     FFF8    20 .equ std_N_eff, 0xFFF8
                             21 
                             22 
                             23 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             24 
   02F1                      25 defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
   0000                       1 	frisbee_data::
   02F1 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   02F3 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   02F5 10                    4 		frisbee_h:	.db #16		;; Height			(8 bits)
   02F6 04                    5 		frisbee_w:	.db #4		;; Width			(8 bits)
   02F7 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   02F9 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   02FB 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   02FD 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   02FF 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   0301 27                   11 		frisbee_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   0302 27                   12 		frisbee_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   0303 54                   13 		frisbee_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   0304 54                   14 		frisbee_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   0305 01                   15 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0306 0F                   16 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   0307 00                   17 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   0308 FF F8                26 	frisbee_effect: .dw #0xF8FF									;; effect
                             27 
   030A                      28 defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
   0019                       1 	init_data::
   030A 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   030C 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   030E 10                    4 		init_h:	.db #16		;; Height			(8 bits)
   030F 04                    5 		init_w:	.db #4		;; Width			(8 bits)
   0310 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0312 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0314 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0316 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0318 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   031A 27                   11 		init_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   031B 27                   12 		init_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   031C 54                   13 		init_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   031D 54                   14 		init_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   031E 01                   15 		init_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   031F 0F                   16 		init_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0320 00                   17 		init_id:	.db #0		;; Numeric ID			(8 bits)
   0321 FF F8                29 	init_effect: .dw #0xF8FF									;; effect
                             30 
                             31 
                             32 
                             33 ;; ====================================
                             34 ;; ====================================
                             35 ;; PRIVATE DATA
                             36 ;; ====================================
                             37 ;; ====================================
                             38 
                             39 
                             40 ;; ====================================
                             41 ;; ====================================
                             42 ;; PUBLIC FUNCTIONS
                             43 ;; ====================================
                             44 ;; ====================================
                             45 
                             46 ;; =========================================
                             47 ;; Desactiva el frisbee
                             48 ;; Modifica A
                             49 ;; =========================================
   0323                      50 frisbee_setOff::
   0323 3E 00         [ 7]   51 	ld 	a, #0
   0325 32 05 03      [13]   52 	ld 	(frisbee_state), a
   0328 C9            [10]   53 	ret
                             54 
                             55 ;; ================================================
                             56 ;; Reinicia los datos de la entidad recibida en ix
                             57 ;; Recibe:
                             58 ;; 	IX <= pointer to entity data
                             59 ;; Modifica: HL, IX
                             60 ;; ================================================
   0329                      61 frisbee_restart::
   0329 DD 66 10      [19]   62 	ld	h, Ent_last_x(ix)	;; H <= last_x
   032C DD 6E 11      [19]   63 	ld	l, Ent_erase_x(ix)	;; L <= erase_x
   032F E5            [11]   64 	push	hl			;; push last_x and erase_x
                             65 
   0330 DD 66 12      [19]   66 	ld	h, Ent_last_y(ix)	;; H <= last_y
   0333 DD 6E 13      [19]   67 	ld	l, Ent_erase_y(ix)	;; L <= erase_y
   0336 E5            [11]   68 	push	hl			;; push last_y and erase_y
                             69 
   0337 DD 54                70 	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
   0339 DD 5D                71 	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
   033B 21 0A 03      [10]   72 	ld	hl, #init_data
   033E 01 19 00      [10]   73 	ld	bc, #frisbee_size
   0341 CD 07 06      [17]   74 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             75 
   0344 E1            [10]   76 	pop	hl
   0345 DD 74 12      [19]   77 	ld	Ent_last_y(ix), h	;; last_y <= H
   0348 DD 75 13      [19]   78 	ld	Ent_erase_y(ix), l	;; erase_y <= L
                             79 
   034B E1            [10]   80 	pop	hl
   034C DD 74 10      [19]   81 	ld	Ent_last_x(ix), h	;; last_x <= H
   034F DD 75 11      [19]   82 	ld	Ent_erase_x(ix), l	;; erase_x <= L
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             83 
   0352                      84 frisbee_erase::
   0352 DD 21 F1 02   [14]   85 	ld 	ix, #frisbee_data
   0356 CD 22 01      [17]   86 	call entityErase		;; Pintar cuadrado azul fondo
                             87 
   0359 C9            [10]   88 	ret
                             89 
                             90 
                             91 ;; ================================================
                             92 ;; Modifica el valor de la velocidad del frisbee
                             93 ;; 	en el eje X e Y, al recibido en HL y DE
                             94 ;; Recibe:
                             95 ;; 	HL <= X axis velocity
                             96 ;; 	DE <= Y axis velocity
                             97 ;; Modifica: HL, IX
                             98 ;; ================================================
   035A                      99 frisbee_setVelocities::
   035A DD 21 F1 02   [14]  100 	ld 	ix, #frisbee_data
   035E DD 74 06      [19]  101 	ld 	Ent_vx_I(ix), h
   0361 DD 75 07      [19]  102 	ld 	Ent_vx_F(ix), l
   0364 DD 72 08      [19]  103 	ld 	Ent_vy_I(ix), d
   0367 DD 73 09      [19]  104 	ld 	Ent_vy_F(ix), e
   036A C9            [10]  105 	ret
                            106 
                            107 
                            108 ;; ===========================================
                            109 ;; Modifica el valor del efecto del frisbee
                            110 ;; 	al recibido en HL
                            111 ;; Recibe:
                            112 ;; 	HL <= Effect value
                            113 ;; ===========================================
   036B                     114 frisbee_setEffect::
   036B DD 21 F1 02   [14]  115 	ld 	ix, #frisbee_data
   036F DD 74 17      [19]  116 	ld 	Frisbee_effect_I(ix), h
   0372 DD 75 18      [19]  117 	ld 	Frisbee_effect_F(ix), l
   0375 C9            [10]  118 	ret
                            119 
                            120 ;; =========================================
                            121 ;; Actualiza el estado del frisbee
                            122 ;; Modifica A
                            123 ;; =========================================
   0376                     124 frisbee_update::
                            125 
   0376 3A 05 03      [13]  126 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   0379 FE 01         [ 7]  127 	cp 	#1
   037B 20 0E         [12]  128 	jr 	nz, not_active		;; A != 1?
                            129 	
                            130 		;; Active
   037D DD 21 F1 02   [14]  131 		ld 	ix, #frisbee_data
   0381 CD 99 03      [17]  132 		call frisbee_applyEffect 	
   0384 CD 3C 01      [17]  133 		call entityUpdatePhysics
   0387 CD 44 02      [17]  134 		call entityUpdatePosition
   038A C9            [10]  135 		ret
                            136 
   038B                     137 	not_active:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   038B 3E 01         [ 7]  138 		ld 	a, #1
   038D 32 05 03      [13]  139 		ld 	(frisbee_state), a
   0390 C9            [10]  140 	ret
                            141 
   0391                     142 frisbee_draw::
                            143 
   0391 DD 21 F1 02   [14]  144 	ld 	ix, #frisbee_data
   0395 CD 01 01      [17]  145 	call entityDraw 		;; Pintar cuadrado azul cian
                            146 
   0398 C9            [10]  147 	ret
                            148 	
                            149 ;; ====================================
                            150 ;; ====================================
                            151 ;; PRIVATE FUNCTIONS
                            152 ;; ====================================
                            153 ;; ====================================
                            154 
                            155 
                            156 ;; ===========================================
                            157 ;; Mueve el frisbee a la izquierda un píxel
                            158 ;; Recibe:
                            159 ;; 	IX <= Pointer to entity data
                            160 ;; Modifica A
                            161 ;; ===========================================
   0399                     162 frisbee_applyEffect:
                            163 
                            164 	;; vy' = vy + ay
   0399 DD 66 08      [19]  165 	ld 	h, Ent_vy_I(ix)
   039C DD 6E 09      [19]  166 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   039F DD 56 17      [19]  167 	ld 	d, Frisbee_effect_I(ix)
   03A2 DD 5E 18      [19]  168 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            169 
   03A5 19            [11]  170 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            171 
   03A6 DD 74 08      [19]  172 	ld 	Ent_vy_I(ix), h
   03A9 DD 75 09      [19]  173 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            174 
   03AC C9            [10]  175 	ret
                            176 
                            177 
                            178 ;; ===========================================
                            179 ;; Comprueba si el frisbee está en posición
                            180 ;;	de gol
                            181 ;; Recibe:
                            182 ;; 	IX <= Pointer to entity data
                            183 ;; Modifica A
                            184 ;; ===========================================
   03AD                     185 frisbee_checkGoal::
   03AD DD 7E 00      [19]  186 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   03B0 FE 00         [ 7]  187 	cp	#LEFT_LIMIT
   03B2 20 09         [12]  188 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            189 		;; left goal
   03B4 3A 06 00      [13]  190 		ld	a, (Game_t2points)
   03B7 3C            [ 4]  191 		inc	a
   03B8 32 06 00      [13]  192 		ld	(Game_t2points), a	;; Inc team 2 points
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   03BB 18 0E         [12]  193 		jr	goal
                            194 
   03BD                     195 	no_left_goal:
   03BD DD 86 05      [19]  196 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   03C0 FE 50         [ 7]  197 		cp	#RIGHT_LIMIT
   03C2 20 0A         [12]  198 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            199 			;; right goal
   03C4 3A 05 00      [13]  200 			ld	a, (Game_t1points)
   03C7 3C            [ 4]  201 			inc	a
   03C8 32 05 00      [13]  202 			ld	(Game_t1points), a 	;; Inc team 1 points
                            203 
   03CB                     204 	goal:
   03CB CD 29 03      [17]  205 		call frisbee_restart
                            206 
   03CE                     207 	no_right_goal:
   03CE C9            [10]  208 	ret
