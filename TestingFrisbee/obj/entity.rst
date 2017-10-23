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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "game.h.s"
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
                     0000    13 .equ Ent_x_I, 	0	;; X coordinate, integer part
                     0001    14 .equ Ent_x_F, 	1	;; X coordinate, fractional part
                     0002    15 .equ Ent_y_I, 	2	;; Y coordinate, integer part
                     0003    16 .equ Ent_y_F, 	3	;; Y coordinate, fractional part
                     0004    17 .equ Ent_h, 	4	;; Height
                     0005    18 .equ Ent_w, 	5	;; Width
                     0006    19 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    20 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    21 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    22 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    23 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    24 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    25 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    26 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    27 .equ Ent_N_I,	14	;; Normal force, integer part
                     000F    28 .equ Ent_N_F,	15	;; Normal force, fractional part
                     0010    29 .equ Ent_state,	16	;; Entity enabled/disabled
                     0011    30 .equ Ent_clr, 	17	;; Entity color pattern
                     0012    31 .equ Ent_id, 	18	;; Numeric ID
                             32 			;; Frisbee 	0
                             33 			;; Player1 	1
                             34 			;; Enemy1	2
                             35 
                     0002    36 .equ MAX_VEL_X, 2 
                     FFFFFFFE    37 .equ MIN_VEL_X, -2
                     0004    38 .equ MAX_VEL_Y, 4
                     FFFFFFFC    39 .equ MIN_VEL_Y, -4
                             40 
                             41 
                             42 ;; ====================================
                             43 ;; ====================================
                             44 ;; PUBLIC FUNCTIONS
                             45 ;; ====================================
                             46 ;; ====================================
                             47 
                             48 ;; ===================================
                             49 ;; Pinta una entidad en pantalla
                             50 ;; Entrada:
                             51 ;; 	IX => Pointer to entity data 
                             52 ;; Modifica AF, BC, DE, HL
                             53 ;; ===================================
   0101                      54 entityDraw::
   0101 11 00 C0      [10]   55 	ld 	de, #0xC000 		;; Video memory pointer
   0104 DD 4E 00      [19]   56 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0107 DD 46 02      [19]   57 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   010A CD 91 06      [17]   58 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             59 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   010D EB            [ 4]   60 	ex 	de, hl 			;; DE = ent screen pointer
   010E DD 46 04      [19]   61 	ld 	b, Ent_h(ix) 		;; B = ent height
   0111 DD 4E 05      [19]   62 	ld 	c, Ent_w(ix) 		;; C = ent width
   0114 DD 7E 11      [19]   63 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0117 CD E4 05      [17]   64 	call cpct_drawSolidBox_asm
                             65 
   011A C9            [10]   66 	ret
                             67 
                             68 ;; ===================================
                             69 ;; Borra una entidad de la pantalla
                             70 ;; Entrada:
                             71 ;; 	IX => Pointer to entity data 
                             72 ;; Modifica AF, BC, DE, HL
                             73 ;; ===================================
   011B                      74 entityErase::
   011B 11 00 C0      [10]   75 	ld 	de, #0xC000 		;; Video memory  pointer
   011E DD 4E 00      [19]   76 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0121 DD 46 02      [19]   77 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   0124 CD 91 06      [17]   78 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             79 
   0127 EB            [ 4]   80 	ex 	de, hl 			;; DE = ent screen pointer
   0128 3E 00         [ 7]   81 	ld 	a, #0x00 		;; A = background color
   012A DD 46 04      [19]   82 	ld 	b, Ent_h(ix) 		;; B = ent height
   012D DD 4E 05      [19]   83 	ld 	c, Ent_w(ix) 		;; C = ent width
   0130 CD E4 05      [17]   84 	call cpct_drawSolidBox_asm
                             85 
   0133 C9            [10]   86 	ret
                             87 
                             88 ;; =========================================
                             89 ;; Actualiza el estado de las físicas
                             90 ;; 	de una entidad
                             91 ;; Entrada:
                             92 ;; 	IX => Pointer to entity data
                             93 ;; Modifica F, DE, HL
                             94 ;; =========================================
   0134                      95 entityUpdatePhysics::
                             96 	;; vx' = vx + ax
   0134 DD 66 06      [19]   97 	ld 	h, Ent_vx_I(ix)
   0137 DD 6E 07      [19]   98 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   013A DD 56 0A      [19]   99 	ld 	d, Ent_ax_I(ix)
   013D DD 5E 0B      [19]  100 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            101 
   0140 19            [11]  102 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            103 
   0141 7C            [ 4]  104 	ld 	a, h
   0142 FE 02         [ 7]  105 	cp 	#MAX_VEL_X
   0144 F2 52 01      [10]  106 	jp 	p, cant_accelerate_x
                            107 		;; vx' < MAX_VEL_X
   0147 FE FE         [ 7]  108 		cp 	#MIN_VEL_X
   0149 FA 52 01      [10]  109 		jp 	m, cant_accelerate_x
                            110 			;; vx' > MIN_VEL_X
                            111 			;; Can accelerate at X axis
   014C DD 74 06      [19]  112 			ld 	Ent_vx_I(ix), h
   014F DD 75 07      [19]  113 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            114 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0152                     115 	cant_accelerate_x:
                            116 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            117 
                            118 
                            119 	;; vy = vy + ay
   0152 DD 66 08      [19]  120 	ld 	h, Ent_vy_I(ix)
   0155 DD 6E 09      [19]  121 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0158 DD 56 0C      [19]  122 	ld 	d, Ent_ay_I(ix)
   015B DD 5E 0D      [19]  123 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            124 
   015E 19            [11]  125 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   015F 7C            [ 4]  126 	ld 	a, h
   0160 FE 04         [ 7]  127 	cp 	#MAX_VEL_Y
   0162 F2 70 01      [10]  128 	jp 	p, cant_accelerate_y
                            129 		;; vy' < MIN_VEL_Y
   0165 FE FC         [ 7]  130 		cp 	#MIN_VEL_Y
   0167 FA 70 01      [10]  131 		jp 	m, cant_accelerate_y
                            132 			;; vy' > MIN_VEL_Y
                            133 			;; Can accelerate at Y axis
   016A DD 74 08      [19]  134 			ld 	Ent_vy_I(ix), h
   016D DD 75 09      [19]  135 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            136 
   0170                     137 	cant_accelerate_y:
                            138 
                            139 	;; Apply deceleration X axis
   0170 DD 7E 06      [19]  140 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0173 FE 00         [ 7]  141 	cp 	#0
   0175 28 2A         [12]  142 	jr 	z, cant_decelerate_x	;; vx_I == 0?
                            143 		;; vx_I != 0
   0177 FA 8E 01      [10]  144 		jp	m, vx_negative
                            145 			;; vx positive
                            146 
   017A DD 66 0E      [19]  147 			ld 	h, Ent_N_I(ix)
   017D DD 6E 0F      [19]  148 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            149 
   0180 CD C2 02      [17]  150 			call 	negateHL		;; HL <= -ent_N
   0183 54            [ 4]  151 			ld 	d, h
   0184 5D            [ 4]  152 			ld 	e, l			;; DE <= -ent_N
                            153 
   0185 DD 66 06      [19]  154 			ld 	h, Ent_vx_I(ix)
   0188 DD 6E 07      [19]  155 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            156 
   018B 19            [11]  157 			add 	hl, de
                            158 
   018C 18 0D         [12]  159 			jr can_decelerate_x
                            160 
   018E                     161 		vx_negative:
   018E DD 66 06      [19]  162 			ld 	h, Ent_vx_I(ix)
   0191 DD 6E 07      [19]  163 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0194 DD 56 0E      [19]  164 			ld 	d, Ent_N_I(ix)
   0197 DD 5E 0F      [19]  165 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            166 
   019A 19            [11]  167 			add 	hl, de
                            168 
   019B                     169 			can_decelerate_x:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   019B DD 74 06      [19]  170 				ld 	Ent_vx_I(ix), h
   019E DD 75 07      [19]  171 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            172 
   01A1                     173 	cant_decelerate_x:
                            174 
                            175 	;; Apply deceleration Y axis
   01A1 DD 7E 08      [19]  176 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   01A4 FE 00         [ 7]  177 	cp 	#0
   01A6 28 2A         [12]  178 	jr 	z, cant_decelerate_y	;; vy_I == 0?
                            179 		;; vy_I != 0
   01A8 FA BF 01      [10]  180 		jp	m, vy_negative
                            181 			;; vy positive
                            182 
   01AB DD 66 0E      [19]  183 			ld 	h, Ent_N_I(ix)
   01AE DD 6E 0F      [19]  184 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            185 
   01B1 CD C2 02      [17]  186 			call 	negateHL		;; HL <= -ent_N
   01B4 54            [ 4]  187 			ld 	d, h
   01B5 5D            [ 4]  188 			ld 	e, l			;; DE <= -ent_N
                            189 
   01B6 DD 66 08      [19]  190 			ld 	h, Ent_vy_I(ix)
   01B9 DD 6E 09      [19]  191 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            192 
   01BC 19            [11]  193 			add 	hl, de
                            194 
   01BD 18 0D         [12]  195 			jr can_decelerate_y
                            196 
   01BF                     197 		vy_negative:
   01BF DD 66 08      [19]  198 			ld 	h, Ent_vy_I(ix)
   01C2 DD 6E 09      [19]  199 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   01C5 DD 56 0E      [19]  200 			ld 	d, Ent_N_I(ix)
   01C8 DD 5E 0F      [19]  201 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            202 
   01CB 19            [11]  203 			add 	hl, de
                            204 
   01CC                     205 			can_decelerate_y:
   01CC DD 74 08      [19]  206 				ld 	Ent_vy_I(ix), h
   01CF DD 75 09      [19]  207 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            208 
   01D2                     209 	cant_decelerate_y:
                            210 
   01D2 DD 36 0A 00   [19]  211 	ld 	Ent_ax_I(ix), #0	;; 
   01D6 DD 36 0B 00   [19]  212 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   01DA DD 36 0C 00   [19]  213 	ld 	Ent_ay_I(ix), #0	;; 
   01DE DD 36 0D 00   [19]  214 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            215 
   01E2 C9            [10]  216 	ret
                            217 
                            218 ;; =========================================
                            219 ;; Comprueba si existe colision entre
                            220 ;; dos entidades.
                            221 ;; Entrada:
                            222 ;; 	IX => Pointer to entity 1 data
                            223 ;; 	HL => Pointer to entity 2 data
                            224 ;; Modifica AF, B, HL, IX
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            225 ;; Devuelve:
                            226 ;; 	A <==== 0 si no hay colisión, y la
                            227 ;; 		diferencia absoluta entre
                            228 ;;		las x, en caso de colisión
                            229 ;; =========================================
   01E3 00 00               230 ent1_ptr: .dw #0000
   01E5 00 00               231 ent2_ptr: .dw #0000
   01E7                     232 entityCheckCollision::
                            233 	;;
                            234 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            235 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            236 	;;
   01E7 DD 22 E3 01   [20]  237 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   01EB 22 E5 01      [16]  238 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            239 
   01EE DD 7E 00      [19]  240 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   01F1 DD 86 05      [19]  241 	add 	Ent_w(ix)		;; A <= A + ent1_w
   01F4 DD 2A E5 01   [20]  242 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   01F8 DD 96 00      [19]  243 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   01FB F2 00 02      [10]  244 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            245 
   01FE 18 39         [12]  246 	jr 	no_collision
                            247 
                            248 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0200                     249 	collision_XR:
                            250 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0200 47            [ 4]  251 		ld 	b, a 		;; B <= A
                            252 		;;
                            253 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            254 		;; ent2_x + ent2_w - ent1_x <= 0
                            255 		;; 
   0201 DD 7E 00      [19]  256 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0204 DD 86 05      [19]  257 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   0207 DD 2A E3 01   [20]  258 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   020B DD 96 00      [19]  259 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   020E F2 13 02      [10]  260 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            261 
   0211 18 26         [12]  262 		jr 	no_collision
                            263 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   0213                     264 	collision_XL:
                            265 		;;
                            266 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            267 		;; ent1_y + ent1_h - ent2_y <= 0
                            268 		;;
   0213 DD 7E 02      [19]  269 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   0216 DD 86 04      [19]  270 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0219 DD 2A E5 01   [20]  271 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   021D DD 96 02      [19]  272 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0220 F2 25 02      [10]  273 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            274 
   0223 18 14         [12]  275 		jr 	no_collision
                            276 
                            277 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0225                     278 	collision_YB:
                            279 		;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            280 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            281 		;; ent2_y + ent2_h - ent1_y <= 0
                            282 		;; 
   0225 DD 7E 02      [19]  283 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0228 DD 86 04      [19]  284 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   022B DD 2A E3 01   [20]  285 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   022F DD 96 02      [19]  286 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   0232 F2 37 02      [10]  287 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            288 
   0235 18 02         [12]  289 		jr 	no_collision
                            290 
                            291 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   0237                     292 	collision_YT:
                            293 
                            294 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0237 78            [ 4]  295 	ld 	a, b
                            296 
   0238 C9            [10]  297 	ret
                            298 
   0239                     299 	no_collision:
   0239 3E 00         [ 7]  300 	ld 	a, #0 	;; A == 0 si no hay colisión
   023B C9            [10]  301 	ret
                            302 
                            303 
                            304 ;; =========================================
                            305 ;; Actualiza la posición de la entidad
                            306 ;; Entrada:
                            307 ;; 	IX => Pointer to entity data
                            308 ;; Modifica AF, B, DE, HL, IX
                            309 ;; =========================================
   023C                     310 entityUpdatePosition::
                            311 
                            312 	;; x' = x + vx_I
   023C DD 56 06      [19]  313 	ld 	d, Ent_vx_I(ix) 	
   023F DD 5E 07      [19]  314 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            315 
   0242 DD 66 00      [19]  316 	ld 	h, Ent_x_I(ix) 		;; 
   0245 DD 6E 01      [19]  317 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            318 
   0248 19            [11]  319 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            320 
   0249 7C            [ 4]  321 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   024A FE 00         [ 7]  322 	cp 	#LEFT_LIMIT
   024C FA 60 02      [10]  323 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            324 		;; can move left
   024F DD 86 05      [19]  325 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   0252 47            [ 4]  326 		ld	b, a
   0253 3E 50         [ 7]  327 		ld 	a, #RIGHT_LIMIT
   0255 B8            [ 4]  328 		cp	b
   0256 38 12         [12]  329 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            330 			;; can move
   0258 DD 74 00      [19]  331 			ld 	Ent_x_I(ix), h
   025B DD 75 01      [19]  332 			ld 	Ent_x_F(ix), l 		;; Ent_x <= HL (x + vx)
                            333 
   025E 18 16         [12]  334 			jr check_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 
   0260                     336 	check_left:
   0260 DD 36 00 00   [19]  337 		ld 	Ent_x_I(ix), #LEFT_LIMIT
   0264 DD 36 01 00   [19]  338 		ld 	Ent_x_F(ix), #0 		;; Ent_x <= LEFT_LIMIT
   0268 18 0C         [12]  339 			jr check_y
                            340 
   026A                     341 	check_right:
   026A 3E 50         [ 7]  342 		ld 	a, #RIGHT_LIMIT
   026C DD 96 05      [19]  343 		sub	a, Ent_w(ix)
   026F DD 77 00      [19]  344 		ld 	Ent_x_I(ix), a
   0272 DD 36 01 00   [19]  345 		ld 	Ent_x_F(ix), #0 		;; Ent_x <= RIGHT_LIMIT
                            346 
   0276                     347 	check_y:
                            348 	;; y' = y + vy_I*2
   0276 DD 56 08      [19]  349 	ld 	d, Ent_vy_I(ix) 	
   0279 DD 5E 09      [19]  350 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            351 
   027C DD 66 02      [19]  352 	ld 	h, Ent_y_I(ix) 		;; 
   027F DD 6E 03      [19]  353 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            354 
   0282 19            [11]  355 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0283 19            [11]  356 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            357 
   0284 7C            [ 4]  358 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   0285 FE 0A         [ 7]  359 	cp 	#TOP_LIMIT
   0287 DA 9C 02      [10]  360 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            361 	;;jp 	m, cant_move_y
                            362 		;; can move up
   028A 7C            [ 4]  363 		ld 	a, h
   028B DD 86 04      [19]  364 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   028E 47            [ 4]  365 		ld	b, a
   028F 3E C8         [ 7]  366 		ld 	a, #BOTTOM_LIMIT
   0291 B8            [ 4]  367 		cp	b
   0292 DA A6 02      [10]  368 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            369 			;; can move
   0295 DD 74 02      [19]  370 			ld 	Ent_y_I(ix), h
   0298 DD 75 03      [19]  371 			ld 	Ent_y_F(ix), l 		;; Ent_y <= HL (y + vy)
                            372 
   029B C9            [10]  373 			ret
                            374 
                            375 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            376 
   029C                     377 	check_top:
   029C DD 36 02 0A   [19]  378 		ld 	Ent_y_I(ix), #TOP_LIMIT
   02A0 DD 36 03 00   [19]  379 		ld 	Ent_y_F(ix), #0 		;; Ent_y <= TOP_LIMIT
                            380 		;; ld	a, Ent_id(ix)
                            381 		;; cp 	#0
                            382 		;; jr 	nz, not_frisbee			;;Ent_id != 0?
   02A4 18 0C         [12]  383 			jr bounce
   02A6                     384 	check_bot:
   02A6 3E C8         [ 7]  385 		ld 	a, #BOTTOM_LIMIT
   02A8 DD 96 04      [19]  386 		sub	a, Ent_h(ix)
   02AB DD 77 02      [19]  387 		ld 	Ent_y_I(ix), a
   02AE DD 36 03 00   [19]  388 		ld 	Ent_y_F(ix), #0 		;; Ent_y <= BOTTOM_LIMIT
                            389 		;; ld	a, Ent_id(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 		;; cp 	#0
                            391 		;; jr 	nz, not_frisbee			;;Ent_id != 0?
                            392 
   02B2                     393 	bounce:
   02B2 DD 66 08      [19]  394 			ld 	h, Ent_vy_I(ix)
   02B5 DD 6E 09      [19]  395 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            396 
   02B8 CD C2 02      [17]  397 			call 	negateHL
                            398 
   02BB DD 74 08      [19]  399 			ld 	Ent_vy_I(ix), h
   02BE DD 75 09      [19]  400 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            401 
   02C1 C9            [10]  402 		ret
                            403 
                            404 ;; =========================================
                            405 ;; Inverts HL value
                            406 ;; Entrada:
                            407 ;; 	HL => value we are going to negate
                            408 ;; Modifica AF
                            409 ;; Devuelve:
                            410 ;; 	HL <= HL value negated
                            411 ;; =========================================
   02C2                     412 negateHL::
   02C2 3E 00         [ 7]  413 	ld 	a, #0			;;
   02C4 AF            [ 4]  414 	xor	a			;;
   02C5 95            [ 4]  415 	sub	l			;;
   02C6 6F            [ 4]  416 	ld	l,a			;;
   02C7 9F            [ 4]  417 	sbc	a,a			;;
   02C8 94            [ 4]  418 	sub	h			;;
   02C9 67            [ 4]  419 	ld	h,a			;; negate HL
                            420 
   02CA C9            [10]  421 	ret
                            422 
                            423 ;; ====================================
                            424 ;; ====================================
                            425 ;; PRIVATE FUNCTIONS
                            426 ;; ====================================
                            427 ;; ====================================
                            428 
                            429 
