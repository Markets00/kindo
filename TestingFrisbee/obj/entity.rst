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
                              8 .macro defineGame name, type, map, fTime
                              9 	name'_data::
                             10 		name'_type:	.db type	;; Game Mode			(8 bits)
                             11 		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime:	.dw fTime	;; Final duration of each match	(16 bits)
                             13 .endm
                             14 
                             15 ;; ====================================
                             16 ;; ====================================
                             17 ;; GAME PUBLIC DATA
                             18 ;; ====================================
                             19 ;; ====================================
                     0000    20 .equ Game_type, 	0	;; Game mode
                     0001    21 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    22 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    23 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    24 .equ Game_fTime_L, 	4	;; Low part of final match time
                             25 
                     0050    26 .equ RIGHT_LIMIT,	80
                     0000    27 .equ LEFT_LIMIT,	0
                     000A    28 .equ TOP_LIMIT,	 	10
                     00C8    29 .equ BOTTOM_LIMIT,	200
                     0028    30 .equ CENTER_LIMIT,	40
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
                     000E    27 .equ Ent_state,	14	;; Entity enabled/disabled
                     000F    28 .equ Ent_clr, 	15	;; Entity color pattern
                     0010    29 .equ Ent_id, 	16	;; Numeric ID
                             30 			;; Frisbee 	0
                             31 			;; Player1 	1
                             32 			;; Enemy1	2
                             33 
                     0002    34 .equ MAX_VEL_X, 2 
                     FFFFFFFE    35 .equ MIN_VEL_X, -2
                     0004    36 .equ MAX_VEL_Y, 4
                     FFFFFFFC    37 .equ MIN_VEL_Y, -4
                             38 
                             39 
                             40 ;; ====================================
                             41 ;; ====================================
                             42 ;; PUBLIC FUNCTIONS
                             43 ;; ====================================
                             44 ;; ====================================
                             45 
                             46 ;; ===================================
                             47 ;; Pinta una entidad en pantalla
                             48 ;; Entrada:
                             49 ;; 	IX => Pointer to entity data 
                             50 ;; Modifica AF, BC, DE, HL
                             51 ;; ===================================
   0101                      52 entityDraw::
   0101 11 00 C0      [10]   53 	ld 	de, #0xC000 		;; Video memory pointer
   0104 DD 4E 00      [19]   54 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0107 DD 46 02      [19]   55 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   010A CD B3 05      [17]   56 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             57 
   010D EB            [ 4]   58 	ex 	de, hl 			;; DE = ent screen pointer
   010E DD 46 04      [19]   59 	ld 	b, Ent_h(ix) 		;; B = ent height
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0111 DD 4E 05      [19]   60 	ld 	c, Ent_w(ix) 		;; C = ent width
   0114 DD 7E 0F      [19]   61 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0117 CD 06 05      [17]   62 	call cpct_drawSolidBox_asm
                             63 
   011A C9            [10]   64 	ret
                             65 
                             66 ;; ===================================
                             67 ;; Borra una entidad de la pantalla
                             68 ;; Entrada:
                             69 ;; 	IX => Pointer to entity data 
                             70 ;; Modifica AF, BC, DE, HL
                             71 ;; ===================================
   011B                      72 entityErase::
   011B 11 00 C0      [10]   73 	ld 	de, #0xC000 		;; Video memory  pointer
   011E DD 4E 00      [19]   74 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0121 DD 46 02      [19]   75 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   0124 CD B3 05      [17]   76 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             77 
   0127 EB            [ 4]   78 	ex 	de, hl 			;; DE = ent screen pointer
   0128 3E 00         [ 7]   79 	ld 	a, #0x00 		;; A = background color
   012A DD 46 04      [19]   80 	ld 	b, Ent_h(ix) 		;; B = ent height
   012D DD 4E 05      [19]   81 	ld 	c, Ent_w(ix) 		;; C = ent width
   0130 CD 06 05      [17]   82 	call cpct_drawSolidBox_asm
                             83 
   0133 C9            [10]   84 	ret
                             85 
                             86 ;; =========================================
                             87 ;; Actualiza el estado de las físicas
                             88 ;; 	de una entidad
                             89 ;; Entrada:
                             90 ;; 	IX => Pointer to entity data
                             91 ;; Modifica F, DE, HL
                             92 ;; =========================================
   0134                      93 entityUpdatePhysics::
                             94 	;; vx' = vx + ax
   0134 DD 66 06      [19]   95 	ld 	h, Ent_vx_I(ix)
   0137 DD 6E 07      [19]   96 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   013A DD 56 0A      [19]   97 	ld 	d, Ent_ax_I(ix)
   013D DD 5E 0B      [19]   98 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                             99 
   0140 19            [11]  100 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            101 
   0141 7C            [ 4]  102 	ld 	a, h
   0142 FE 02         [ 7]  103 	cp 	#MAX_VEL_X
   0144 F2 52 01      [10]  104 	jp 	p, cant_accelerate_x
                            105 		;; vx' < MAX_VEL_X
   0147 FE FE         [ 7]  106 		cp 	#MIN_VEL_X
   0149 FA 52 01      [10]  107 		jp 	m, cant_accelerate_x
                            108 			;; vx' > MIN_VEL_X
                            109 			;; Can accelerate at X axis
   014C DD 74 06      [19]  110 			ld 	Ent_vx_I(ix), h
   014F DD 75 07      [19]  111 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            112 
   0152                     113 	cant_accelerate_x:
                            114 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 
                            116 
                            117 	;; vy = vy + ay
   0152 DD 66 08      [19]  118 	ld 	h, Ent_vy_I(ix)
   0155 DD 6E 09      [19]  119 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0158 DD 56 0C      [19]  120 	ld 	d, Ent_ay_I(ix)
   015B DD 5E 0D      [19]  121 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            122 
   015E 19            [11]  123 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   015F 7C            [ 4]  124 	ld 	a, h
   0160 FE 04         [ 7]  125 	cp 	#MAX_VEL_Y
   0162 F2 70 01      [10]  126 	jp 	p, cant_accelerate_y
                            127 		;; vy' < MIN_VEL_Y
   0165 FE FC         [ 7]  128 		cp 	#MIN_VEL_Y
   0167 FA 70 01      [10]  129 		jp 	m, cant_accelerate_y
                            130 			;; vy' > MIN_VEL_Y
                            131 			;; Can accelerate at Y axis
   016A DD 74 08      [19]  132 			ld 	Ent_vy_I(ix), h
   016D DD 75 09      [19]  133 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            134 
   0170                     135 	cant_accelerate_y:
                            136 
   0170 DD 36 0A 00   [19]  137 	ld 	Ent_ax_I(ix), #0	;; 
   0174 DD 36 0B 00   [19]  138 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   0178 DD 36 0C 00   [19]  139 	ld 	Ent_ay_I(ix), #0	;; 
   017C DD 36 0D 00   [19]  140 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            141 
   0180 C9            [10]  142 	ret
                            143 
                            144 ;; =========================================
                            145 ;; Comprueba si existe colision entre
                            146 ;; dos entidades.
                            147 ;; Entrada:
                            148 ;; 	IX => Pointer to entity 1 data
                            149 ;; 	HL => Pointer to entity 2 data
                            150 ;; Modifica AF, B, HL, IX
                            151 ;; Devuelve:
                            152 ;; 	A <==== 0 si no hay colisión, y la
                            153 ;; 		diferencia absoluta entre
                            154 ;;		las x, en caso de colisión
                            155 ;; =========================================
   0181 00 00               156 ent1_ptr: .dw #0000
   0183 00 00               157 ent2_ptr: .dw #0000
   0185                     158 entityCheckCollision::
                            159 	;;
                            160 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            161 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            162 	;;
   0185 DD 22 81 01   [20]  163 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   0189 22 83 01      [16]  164 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            165 
   018C DD 7E 00      [19]  166 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   018F DD 86 05      [19]  167 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0192 DD 2A 83 01   [20]  168 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0196 DD 96 00      [19]  169 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0199 F2 9E 01      [10]  170 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            171 
   019C 18 39         [12]  172 	jr 	no_collision
                            173 
                            174 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   019E                     175 	collision_XR:
                            176 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   019E 47            [ 4]  177 		ld 	b, a 		;; B <= A
                            178 		;;
                            179 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            180 		;; ent2_x + ent2_w - ent1_x <= 0
                            181 		;; 
   019F DD 7E 00      [19]  182 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   01A2 DD 86 05      [19]  183 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   01A5 DD 2A 81 01   [20]  184 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01A9 DD 96 00      [19]  185 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   01AC F2 B1 01      [10]  186 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            187 
   01AF 18 26         [12]  188 		jr 	no_collision
                            189 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   01B1                     190 	collision_XL:
                            191 		;;
                            192 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            193 		;; ent1_y + ent1_h - ent2_y <= 0
                            194 		;;
   01B1 DD 7E 02      [19]  195 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   01B4 DD 86 04      [19]  196 		add 	Ent_h(ix)		;; A <= A + ent1_w
   01B7 DD 2A 83 01   [20]  197 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   01BB DD 96 02      [19]  198 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   01BE F2 C3 01      [10]  199 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            200 
   01C1 18 14         [12]  201 		jr 	no_collision
                            202 
                            203 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   01C3                     204 	collision_YB:
                            205 		;;
                            206 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            207 		;; ent2_y + ent2_h - ent1_y <= 0
                            208 		;; 
   01C3 DD 7E 02      [19]  209 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   01C6 DD 86 04      [19]  210 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   01C9 DD 2A 81 01   [20]  211 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01CD DD 96 02      [19]  212 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   01D0 F2 D5 01      [10]  213 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            214 
   01D3 18 02         [12]  215 		jr 	no_collision
                            216 
                            217 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   01D5                     218 	collision_YT:
                            219 
                            220 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   01D5 78            [ 4]  221 	ld 	a, b
                            222 
   01D6 C9            [10]  223 	ret
                            224 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   01D7                     225 	no_collision:
   01D7 3E 00         [ 7]  226 	ld 	a, #0 	;; A == 0 si no hay colisión
   01D9 C9            [10]  227 	ret
                            228 
                            229 
                            230 ;; =========================================
                            231 ;; Actualiza la posición de la entidad
                            232 ;; Entrada:
                            233 ;; 	IX => Pointer to entity data
                            234 ;; Modifica AF, B, DE, HL, IX
                            235 ;; =========================================
   01DA                     236 entityUpdatePosition::
                            237 
                            238 	;; x' = x + vx_I
   01DA DD 56 06      [19]  239 	ld 	d, Ent_vx_I(ix) 	
   01DD DD 5E 07      [19]  240 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            241 
   01E0 DD 66 00      [19]  242 	ld 	h, Ent_x_I(ix) 		;; 
   01E3 DD 6E 01      [19]  243 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            244 
   01E6 19            [11]  245 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            246 
   01E7 7C            [ 4]  247 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   01E8 FE 00         [ 7]  248 	cp 	#LEFT_LIMIT
   01EA FA FC 01      [10]  249 	jp 	m, cant_move_x		;; LIMIT_LEFT > x_I + vx_I? can't move
                            250 		;; can move left
   01ED DD 86 05      [19]  251 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   01F0 47            [ 4]  252 		ld	b, a
   01F1 3E 50         [ 7]  253 		ld 	a, #RIGHT_LIMIT
   01F3 B8            [ 4]  254 		cp	b
   01F4 38 06         [12]  255 		jr 	c, cant_move_x	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            256 			;; can move
   01F6 DD 74 00      [19]  257 			ld 	Ent_x_I(ix), h
   01F9 DD 75 01      [19]  258 			ld 	Ent_x_F(ix), l 		;; Ent_x <= HL (x + vx)
                            259 
   01FC                     260 	cant_move_x:
                            261 
                            262 	;; y' = y + vy_I*2
   01FC DD 56 08      [19]  263 	ld 	d, Ent_vy_I(ix) 	
   01FF DD 5E 09      [19]  264 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            265 
   0202 DD 66 02      [19]  266 	ld 	h, Ent_y_I(ix) 		;; 
   0205 DD 6E 03      [19]  267 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            268 
   0208 19            [11]  269 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0209 19            [11]  270 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            271 
   020A 7C            [ 4]  272 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   020B FE 0A         [ 7]  273 	cp 	#TOP_LIMIT
   020D DA 22 02      [10]  274 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            275 	;;jp 	m, cant_move_y
                            276 		;; can move up
   0210 7C            [ 4]  277 		ld 	a, h
   0211 DD 86 04      [19]  278 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   0214 47            [ 4]  279 		ld	b, a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   0215 3E C8         [ 7]  280 		ld 	a, #BOTTOM_LIMIT
   0217 B8            [ 4]  281 		cp	b
   0218 DA 2C 02      [10]  282 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            283 			;; can move
   021B DD 74 02      [19]  284 			ld 	Ent_y_I(ix), h
   021E DD 75 03      [19]  285 			ld 	Ent_y_F(ix), l 		;; Ent_y <= HL (y + vy)
                            286 
   0221 C9            [10]  287 			ret
                            288 
                            289 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            290 
   0222                     291 	check_top:
   0222 DD 36 02 0A   [19]  292 		ld 	Ent_y_I(ix), #TOP_LIMIT
   0226 DD 36 03 00   [19]  293 		ld 	Ent_y_F(ix), #0 		;; Ent_y <= TOP_LIMIT
                            294 		;; ld	a, Ent_id(ix)
                            295 		;; cp 	#0
                            296 		;; jr 	nz, not_frisbee			;;Ent_id != 0?
   022A 18 0C         [12]  297 			jr frisbee
   022C                     298 	check_bot:
   022C 3E C8         [ 7]  299 		ld 	a, #BOTTOM_LIMIT
   022E DD 96 04      [19]  300 		sub	a, Ent_h(ix)
   0231 DD 77 02      [19]  301 		ld 	Ent_y_I(ix), a
   0234 DD 36 03 00   [19]  302 		ld 	Ent_y_F(ix), #0 		;; Ent_y <= BOTTOM_LIMIT
                            303 		;; ld	a, Ent_id(ix)
                            304 		;; cp 	#0
                            305 		;; jr 	nz, not_frisbee			;;Ent_id != 0?
                            306 
   0238                     307 	frisbee:
   0238 DD 66 08      [19]  308 			ld 	h, Ent_vy_I(ix)
   023B DD 6E 09      [19]  309 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            310 
   023E 3E 00         [ 7]  311 			ld 	a, #0			;;
   0240 AF            [ 4]  312 			xor	a			;;
   0241 95            [ 4]  313 			sub	l			;;
   0242 6F            [ 4]  314 			ld	l,a			;;
   0243 9F            [ 4]  315 			sbc	a,a			;;
   0244 94            [ 4]  316 			sub	h			;;
   0245 67            [ 4]  317 			ld	h,a			;; negate HL
                            318 
   0246 DD 74 08      [19]  319 			ld 	Ent_vy_I(ix), h
   0249 DD 75 09      [19]  320 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            321 
                            322 
   024C                     323 	not_frisbee:
   024C C9            [10]  324 		ret
                            325 
                            326 ;; ====================================
                            327 ;; ====================================
                            328 ;; PRIVATE FUNCTIONS
                            329 ;; ====================================
                            330 ;; ====================================
                            331 
