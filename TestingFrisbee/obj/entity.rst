ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              3 .include "utility.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "game.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 
                              6 
                              7 
                              8 ;; ====================================
                              9 ;; ====================================
                             10 ;; PUBLIC DATA
                             11 ;; ====================================
                             12 ;; ====================================
                     0000    13 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    14 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    15 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    16 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    17 .equ Ent_h, 		4	;; Height
                     0005    18 .equ Ent_w, 		5	;; Width
                     0006    19 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    20 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    21 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    22 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    23 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    24 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    25 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    26 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    27 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    28 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    29 .equ Ent_last_x,	16	;; Last x rendered
                     0011    30 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    31 .equ Ent_last_y,	18	;; Last y rendered
                     0013    32 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    33 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    34 .equ Ent_clr, 		21	;; Entity color pattern
                     0016    35 .equ Ent_id, 		22	;; Numeric ID
                             36 				;; Frisbee 	0
                             37 				;; Player1 	1
                             38 				;; Enemy1	2
                             39 
                     0002    40 .equ MAX_VEL_X, 2 
                     FFFFFFFE    41 .equ MIN_VEL_X, -2
                     0003    42 .equ MAX_VEL_Y, 3
                     FFFFFFFD    43 .equ MIN_VEL_Y, -3
                             44 
                             45 
                             46 ;; ====================================
                             47 ;; ====================================
                             48 ;; PUBLIC FUNCTIONS
                             49 ;; ====================================
                             50 ;; ====================================
                             51 
                             52 ;; ===================================
                             53 ;; Pinta una entidad en pantalla
                             54 ;; Entrada:
                             55 ;; 	IX => Pointer to entity data 
                             56 ;; Modifica AF, BC, DE, HL
                             57 ;; ===================================
   0101                      58 entityDraw::
   0101 CD 16 06      [17]   59 	call 	getVideoPtr		;; HL <= Video memory pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0104 EB            [ 4]   60 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0105 DD 4E 00      [19]   61 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   0108 DD 46 02      [19]   62 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   010B CD 8C 07      [17]   63 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             64 
   010E EB            [ 4]   65 	ex 	de, hl 			;; DE = ent screen pointer
   010F DD 46 04      [19]   66 	ld 	b, Ent_h(ix) 		;; B = ent height
   0112 DD 4E 05      [19]   67 	ld 	c, Ent_w(ix) 		;; C = ent width
   0115 DD 7E 15      [19]   68 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0118 CD DF 06      [17]   69 	call cpct_drawSolidBox_asm
                             70 
   011B CD D0 02      [17]   71 	call updateX
   011E CD E4 02      [17]   72 	call updateY
   0121 C9            [10]   73 	ret
                             74 
                             75 ;; ===================================
                             76 ;; Borra una entidad de la pantalla
                             77 ;; Entrada:
                             78 ;; 	IX => Pointer to entity data 
                             79 ;; Modifica AF, BC, DE, HL
                             80 ;; ===================================
   0122                      81 entityErase::
   0122 CD 16 06      [17]   82 	call 	getVideoPtr		;; HL <= Video memory pointer
   0125 EB            [ 4]   83 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0126 DD 4E 11      [19]   84 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   0129 DD 46 13      [19]   85 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   012C CD 8C 07      [17]   86 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             87 
   012F EB            [ 4]   88 	ex 	de, hl 			;; DE = ent screen pointer
   0130 3E 00         [ 7]   89 	ld 	a, #0x00 		;; A = background color
   0132 DD 46 04      [19]   90 	ld 	b, Ent_h(ix) 		;; B = ent height
   0135 DD 4E 05      [19]   91 	ld 	c, Ent_w(ix) 		;; C = ent width
   0138 CD DF 06      [17]   92 	call cpct_drawSolidBox_asm
                             93 
   013B C9            [10]   94 	ret
                             95 
                             96 ;; =========================================
                             97 ;; Actualiza el estado de las físicas
                             98 ;; 	de una entidad
                             99 ;; Entrada:
                            100 ;; 	IX => Pointer to entity data
                            101 ;; Modifica F, DE, HL
                            102 ;; =========================================
   013C                     103 entityUpdatePhysics::
                            104 	;; vx' = vx + ax
   013C DD 66 06      [19]  105 	ld 	h, Ent_vx_I(ix)
   013F DD 6E 07      [19]  106 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0142 DD 56 0A      [19]  107 	ld 	d, Ent_ax_I(ix)
   0145 DD 5E 0B      [19]  108 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            109 
   0148 19            [11]  110 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            111 
   0149 7C            [ 4]  112 	ld 	a, h
   014A FE 02         [ 7]  113 	cp 	#MAX_VEL_X
   014C F2 5A 01      [10]  114 	jp 	p, cant_accelerate_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 		;; vx' < MAX_VEL_X
   014F FE FE         [ 7]  116 		cp 	#MIN_VEL_X
   0151 FA 5A 01      [10]  117 		jp 	m, cant_accelerate_x
                            118 			;; vx' > MIN_VEL_X
                            119 			;; Can accelerate at X axis
   0154 DD 74 06      [19]  120 			ld 	Ent_vx_I(ix), h
   0157 DD 75 07      [19]  121 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            122 
   015A                     123 	cant_accelerate_x:
                            124 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            125 
                            126 
                            127 	;; vy = vy + ay
   015A DD 66 08      [19]  128 	ld 	h, Ent_vy_I(ix)
   015D DD 6E 09      [19]  129 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0160 DD 56 0C      [19]  130 	ld 	d, Ent_ay_I(ix)
   0163 DD 5E 0D      [19]  131 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            132 
   0166 19            [11]  133 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   0167 7C            [ 4]  134 	ld 	a, h
   0168 FE 03         [ 7]  135 	cp 	#MAX_VEL_Y
   016A F2 78 01      [10]  136 	jp 	p, cant_accelerate_y
                            137 		;; vy' < MIN_VEL_Y
   016D FE FD         [ 7]  138 		cp 	#MIN_VEL_Y
   016F FA 78 01      [10]  139 		jp 	m, cant_accelerate_y
                            140 			;; vy' > MIN_VEL_Y
                            141 			;; Can accelerate at Y axis
   0172 DD 74 08      [19]  142 			ld 	Ent_vy_I(ix), h
   0175 DD 75 09      [19]  143 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            144 
   0178                     145 	cant_accelerate_y:
                            146 
                            147 	;; Apply deceleration X axis
   0178 DD 7E 06      [19]  148 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   017B FE 00         [ 7]  149 	cp 	#0
   017D 28 2A         [12]  150 	jr 	z, cant_decelerate_x	;; vx_I == 0?
                            151 		;; vx_I != 0
   017F FA 96 01      [10]  152 		jp	m, vx_negative
                            153 			;; vx positive
                            154 
   0182 DD 66 0E      [19]  155 			ld 	h, Ent_N_I(ix)
   0185 DD 6E 0F      [19]  156 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            157 
   0188 CD C0 02      [17]  158 			call 	negateHL		;; HL <= -ent_N
   018B 54            [ 4]  159 			ld 	d, h
   018C 5D            [ 4]  160 			ld 	e, l			;; DE <= -ent_N
                            161 
   018D DD 66 06      [19]  162 			ld 	h, Ent_vx_I(ix)
   0190 DD 6E 07      [19]  163 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            164 
   0193 19            [11]  165 			add 	hl, de
                            166 
   0194 18 0D         [12]  167 			jr can_decelerate_x
                            168 
   0196                     169 		vx_negative:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0196 DD 66 06      [19]  170 			ld 	h, Ent_vx_I(ix)
   0199 DD 6E 07      [19]  171 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   019C DD 56 0E      [19]  172 			ld 	d, Ent_N_I(ix)
   019F DD 5E 0F      [19]  173 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            174 
   01A2 19            [11]  175 			add 	hl, de
                            176 
   01A3                     177 			can_decelerate_x:
   01A3 DD 74 06      [19]  178 				ld 	Ent_vx_I(ix), h
   01A6 DD 75 07      [19]  179 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            180 
   01A9                     181 	cant_decelerate_x:
                            182 
                            183 	;; Apply deceleration Y axis
   01A9 DD 7E 08      [19]  184 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   01AC FE 00         [ 7]  185 	cp 	#0
   01AE 28 2A         [12]  186 	jr 	z, cant_decelerate_y	;; vy_I == 0?
                            187 		;; vy_I != 0
   01B0 FA C7 01      [10]  188 		jp	m, vy_negative
                            189 			;; vy positive
                            190 
   01B3 DD 66 0E      [19]  191 			ld 	h, Ent_N_I(ix)
   01B6 DD 6E 0F      [19]  192 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            193 
   01B9 CD C0 02      [17]  194 			call 	negateHL		;; HL <= -ent_N
   01BC 54            [ 4]  195 			ld 	d, h
   01BD 5D            [ 4]  196 			ld 	e, l			;; DE <= -ent_N
                            197 
   01BE DD 66 08      [19]  198 			ld 	h, Ent_vy_I(ix)
   01C1 DD 6E 09      [19]  199 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            200 
   01C4 19            [11]  201 			add 	hl, de
                            202 
   01C5 18 0D         [12]  203 			jr can_decelerate_y
                            204 
   01C7                     205 		vy_negative:
   01C7 DD 66 08      [19]  206 			ld 	h, Ent_vy_I(ix)
   01CA DD 6E 09      [19]  207 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   01CD DD 56 0E      [19]  208 			ld 	d, Ent_N_I(ix)
   01D0 DD 5E 0F      [19]  209 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            210 
   01D3 19            [11]  211 			add 	hl, de
                            212 
   01D4                     213 			can_decelerate_y:
   01D4 DD 74 08      [19]  214 				ld 	Ent_vy_I(ix), h
   01D7 DD 75 09      [19]  215 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            216 
   01DA                     217 	cant_decelerate_y:
                            218 
   01DA DD 36 0A 00   [19]  219 	ld 	Ent_ax_I(ix), #0	;; 
   01DE DD 36 0B 00   [19]  220 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   01E2 DD 36 0C 00   [19]  221 	ld 	Ent_ay_I(ix), #0	;; 
   01E6 DD 36 0D 00   [19]  222 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            223 
   01EA C9            [10]  224 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            225 
                            226 ;; =========================================
                            227 ;; Comprueba si existe colision entre
                            228 ;; dos entidades.
                            229 ;; Entrada:
                            230 ;; 	IX => Pointer to entity 1 data
                            231 ;; 	HL => Pointer to entity 2 data
                            232 ;; Modifica AF, B, HL, IX
                            233 ;; Devuelve:
                            234 ;; 	A <==== 0 si no hay colisión, y la
                            235 ;; 		diferencia absoluta entre
                            236 ;;		las x, en caso de colisión
                            237 ;; =========================================
   01EB 00 00               238 ent1_ptr: .dw #0000
   01ED 00 00               239 ent2_ptr: .dw #0000
   01EF                     240 entityCheckCollision::
                            241 	;;
                            242 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            243 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            244 	;;
   01EF DD 22 EB 01   [20]  245 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   01F3 22 ED 01      [16]  246 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            247 
   01F6 DD 7E 00      [19]  248 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   01F9 DD 86 05      [19]  249 	add 	Ent_w(ix)		;; A <= A + ent1_w
   01FC DD 2A ED 01   [20]  250 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0200 DD 96 00      [19]  251 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   0203 F2 08 02      [10]  252 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            253 
   0206 18 39         [12]  254 	jr 	no_collision
                            255 
                            256 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0208                     257 	collision_XR:
                            258 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0208 47            [ 4]  259 		ld 	b, a 		;; B <= A
                            260 		;;
                            261 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            262 		;; ent2_x + ent2_w - ent1_x <= 0
                            263 		;; 
   0209 DD 7E 00      [19]  264 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   020C DD 86 05      [19]  265 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   020F DD 2A EB 01   [20]  266 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0213 DD 96 00      [19]  267 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   0216 F2 1B 02      [10]  268 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            269 
   0219 18 26         [12]  270 		jr 	no_collision
                            271 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   021B                     272 	collision_XL:
                            273 		;;
                            274 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            275 		;; ent1_y + ent1_h - ent2_y <= 0
                            276 		;;
   021B DD 7E 02      [19]  277 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   021E DD 86 04      [19]  278 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0221 DD 2A ED 01   [20]  279 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   0225 DD 96 02      [19]  280 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0228 F2 2D 02      [10]  281 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            282 
   022B 18 14         [12]  283 		jr 	no_collision
                            284 
                            285 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   022D                     286 	collision_YB:
                            287 		;;
                            288 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            289 		;; ent2_y + ent2_h - ent1_y <= 0
                            290 		;; 
   022D DD 7E 02      [19]  291 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0230 DD 86 04      [19]  292 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   0233 DD 2A EB 01   [20]  293 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0237 DD 96 02      [19]  294 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   023A F2 3F 02      [10]  295 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            296 
   023D 18 02         [12]  297 		jr 	no_collision
                            298 
                            299 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   023F                     300 	collision_YT:
                            301 
                            302 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   023F 78            [ 4]  303 	ld 	a, b
                            304 
   0240 C9            [10]  305 	ret
                            306 
   0241                     307 	no_collision:
   0241 3E 00         [ 7]  308 	ld 	a, #0 	;; A == 0 si no hay colisión
   0243 C9            [10]  309 	ret
                            310 
                            311 
                            312 ;; =========================================
                            313 ;; Actualiza la posición de la entidad
                            314 ;; Entrada:
                            315 ;; 	IX => Pointer to entity data
                            316 ;; Modifica AF, B, DE, HL, IX
                            317 ;; =========================================
   0244                     318 entityUpdatePosition::
                            319 
                            320 	;; x' = x + vx_I
   0244 DD 56 06      [19]  321 	ld 	d, Ent_vx_I(ix) 	
   0247 DD 5E 07      [19]  322 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            323 
   024A DD 66 00      [19]  324 	ld 	h, Ent_x_I(ix) 		;; 
   024D DD 6E 01      [19]  325 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            326 
   0250 19            [11]  327 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            328 
   0251 7C            [ 4]  329 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   0252 FE 00         [ 7]  330 	cp 	#LEFT_LIMIT
   0254 FA 65 02      [10]  331 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            332 		;; can move left
   0257 DD 86 05      [19]  333 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   025A 47            [ 4]  334 		ld	b, a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   025B 3E 50         [ 7]  335 		ld 	a, #RIGHT_LIMIT
   025D B8            [ 4]  336 		cp	b
   025E 38 0E         [12]  337 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            338 			;; can move
   0260 CD C9 02      [17]  339 			call setX 		;; Ent_x <= HL (x + vx)
                            340 
   0263 18 14         [12]  341 			jr check_y
                            342 
   0265                     343 	check_left:
   0265 26 00         [ 7]  344 		ld 	h, #LEFT_LIMIT
   0267 2E 00         [ 7]  345 		ld 	l, #0
   0269 CD C9 02      [17]  346 		call	setX 			;; Ent_x <= LEFT_LIMIT
   026C 18 0B         [12]  347 			jr check_y
                            348 
   026E                     349 	check_right:
   026E 3E 50         [ 7]  350 		ld 	a, #RIGHT_LIMIT
   0270 DD 96 05      [19]  351 		sub	a, Ent_w(ix)
   0273 67            [ 4]  352 		ld 	h, a
   0274 2E 00         [ 7]  353 		ld 	l, #0
   0276 CD C9 02      [17]  354 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            355 
   0279                     356 	check_y:
                            357 	;; y' = y + vy_I*2
   0279 DD 56 08      [19]  358 	ld 	d, Ent_vy_I(ix) 	
   027C DD 5E 09      [19]  359 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            360 
   027F DD 66 02      [19]  361 	ld 	h, Ent_y_I(ix) 		;; 
   0282 DD 6E 03      [19]  362 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            363 
   0285 19            [11]  364 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0286 19            [11]  365 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            366 
   0287 7C            [ 4]  367 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   0288 FE 0A         [ 7]  368 	cp 	#TOP_LIMIT
   028A DA 9C 02      [10]  369 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            370 		;; can move up
   028D 7C            [ 4]  371 		ld 	a, h
   028E DD 86 04      [19]  372 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   0291 47            [ 4]  373 		ld	b, a
   0292 3E C8         [ 7]  374 		ld 	a, #BOTTOM_LIMIT
   0294 B8            [ 4]  375 		cp	b
   0295 DA A5 02      [10]  376 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            377 			;; can move
   0298 CD DD 02      [17]  378 			call 	setY			;; Ent_y <= HL (y + vy)
                            379 
   029B C9            [10]  380 			ret
                            381 
                            382 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            383 
   029C                     384 	check_top:
   029C 26 0A         [ 7]  385 		ld 	h, #TOP_LIMIT
   029E 2E 00         [ 7]  386 		ld 	l, #0
   02A0 CD DD 02      [17]  387 		call 	setY				;; Ent_y <= TOP_LIMIT
   02A3 18 0B         [12]  388 		jr bounce
                            389 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   02A5                     390 	check_bot:
   02A5 3E C8         [ 7]  391 		ld 	a, #BOTTOM_LIMIT
   02A7 DD 96 04      [19]  392 		sub	a, Ent_h(ix)
   02AA 67            [ 4]  393 		ld 	h, a
   02AB 2E 00         [ 7]  394 		ld 	l, #0
   02AD CD DD 02      [17]  395 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            396 
   02B0                     397 	bounce:
   02B0 DD 66 08      [19]  398 			ld 	h, Ent_vy_I(ix)
   02B3 DD 6E 09      [19]  399 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            400 
   02B6 CD C0 02      [17]  401 			call 	negateHL
                            402 
   02B9 DD 74 08      [19]  403 			ld 	Ent_vy_I(ix), h
   02BC DD 75 09      [19]  404 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            405 
   02BF C9            [10]  406 		ret
                            407 
                            408 ;; =========================================
                            409 ;; Inverts HL value
                            410 ;; Entrada:
                            411 ;; 	HL => value we are going to negate
                            412 ;; Modifica AF
                            413 ;; Devuelve:
                            414 ;; 	HL <= HL value negated
                            415 ;; =========================================
   02C0                     416 negateHL::
   02C0 3E 00         [ 7]  417 	ld 	a, #0			;;
   02C2 AF            [ 4]  418 	xor	a			;;
   02C3 95            [ 4]  419 	sub	l			;;
   02C4 6F            [ 4]  420 	ld	l,a			;;
   02C5 9F            [ 4]  421 	sbc	a,a			;;
   02C6 94            [ 4]  422 	sub	h			;;
   02C7 67            [ 4]  423 	ld	h,a			;; negate HL
                            424 
   02C8 C9            [10]  425 	ret
                            426 
                            427 ;; ====================================
                            428 ;; ====================================
                            429 ;; PRIVATE FUNCTIONS
                            430 ;; ====================================
                            431 ;; ====================================
                            432 
                            433 
                            434 
                            435 ;; =========================================
                            436 ;; Modifica la x de la entidad a la pasada
                            437 ;; 	por parámetro
                            438 ;; Entrada:
                            439 ;; 	IX => Pointer to entity data
                            440 ;; 	HL => value we are going to set
                            441 ;; Modifica AF
                            442 ;; =========================================
   02C9                     443 setX:
   02C9 DD 74 00      [19]  444 	ld	Ent_x_I(ix), h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   02CC DD 75 01      [19]  445 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            446 
   02CF C9            [10]  447 	ret
                            448 
                            449 
                            450 ;; =========================================
                            451 ;; Modifica las de últimas posiciones X
                            452 ;	de la entidad
                            453 ;; Entrada:
                            454 ;; 	IX => Pointer to entity data
                            455 ;; Modifica AF
                            456 ;; =========================================
   02D0                     457 updateX:
   02D0 DD 7E 10      [19]  458 	ld	a, Ent_last_x(ix)
   02D3 DD 77 11      [19]  459 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            460 
   02D6 DD 7E 00      [19]  461 	ld	a, Ent_x_I(ix)
   02D9 DD 77 10      [19]  462 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   02DC C9            [10]  463 	ret
                            464 
                            465 
                            466 ;; =========================================
                            467 ;; Modifica la y de la entidad a la pasada
                            468 ;; 	por parámetro
                            469 ;; Entrada:
                            470 ;; 	IX => Pointer to entity data
                            471 ;; 	HL => value we are going to set
                            472 ;; Modifica AF
                            473 ;; =========================================
   02DD                     474 setY:
                            475 
   02DD DD 74 02      [19]  476 	ld	Ent_y_I(ix), h
   02E0 DD 75 03      [19]  477 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            478 
   02E3 C9            [10]  479 	ret
                            480 
                            481 
                            482 ;; =========================================
                            483 ;; Modifica las de últimas posiciones Y
                            484 ;	de la entidad
                            485 ;; Entrada:
                            486 ;; 	IX => Pointer to entity data
                            487 ;; Modifica AF
                            488 ;; =========================================
   02E4                     489 updateY:
   02E4 DD 7E 12      [19]  490 	ld	a, Ent_last_y(ix)
   02E7 DD 77 13      [19]  491 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            492 
   02EA DD 7E 02      [19]  493 	ld	a, Ent_y_I(ix)
   02ED DD 77 12      [19]  494 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   02F0 C9            [10]  495 	ret
