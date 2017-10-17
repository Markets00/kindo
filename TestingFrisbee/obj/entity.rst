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
                     0000    28 .equ TOP_LIMIT,	 	0
                     00C8    29 .equ BOTTOM_LIMIT,	200
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 
                     0000     6 .equ Ent_x_F, 	0	;; X coordinate, low part
                     0001     7 .equ Ent_x_I, 	1	;; X coordinate, high part
                     0002     8 .equ Ent_y_F, 	2	;; Y coordinate, low part
                     0003     9 .equ Ent_y_I, 	3	;; Y coordinate, high part
                     0004    10 .equ Ent_h, 	4	;; Height
                     0005    11 .equ Ent_w, 	5	;; Width
                     0006    12 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    13 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    14 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    15 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    16 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    17 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    18 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    19 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    20 .equ Ent_state,	14	;; Entity enabled/disabled
                     000F    21 .equ Ent_clr, 	15	;; Entity color pattern
                             22 
                             23 
                             24 ;; ====================================
                             25 ;; ====================================
                             26 ;; PRIVATE DATA
                             27 ;; ====================================
                             28 ;; ====================================
                     0002    29 .equ MAX_VEL_X, 2 
                     FFFFFFFE    30 .equ MIN_VEL_X, -2
                     0004    31 .equ MAX_VEL_Y, 4
                     FFFFFFFC    32 .equ MIN_VEL_Y, -4
                             33 
                             34 
                             35 ;; ====================================
                             36 ;; ====================================
                             37 ;; PUBLIC FUNCTIONS
                             38 ;; ====================================
                             39 ;; ====================================
                             40 
                             41 ;; ===================================
                             42 ;; Pinta una entidad en pantalla
                             43 ;; Entrada:
                             44 ;; 	IX => Pointer to entity data 
                             45 ;; Modifica AF, BC, DE, HL
                             46 ;; ===================================
   0100                      47 entityDraw::
   0100 11 00 C0      [10]   48 	ld 	de, #0xC000 		;; Video memory pointer
   0103 DD 4E 01      [19]   49 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0106 DD 46 03      [19]   50 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   0109 CD EE 04      [17]   51 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             52 
   010C EB            [ 4]   53 	ex 	de, hl 			;; DE = ent screen pointer
   010D DD 46 04      [19]   54 	ld 	b, Ent_h(ix) 		;; B = ent height
   0110 DD 4E 05      [19]   55 	ld 	c, Ent_w(ix) 		;; C = ent width
   0113 DD 7E 0F      [19]   56 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0116 CD 41 04      [17]   57 	call cpct_drawSolidBox_asm
                             58 
   0119 C9            [10]   59 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             60 
                             61 ;; ===================================
                             62 ;; Borra una entidad de la pantalla
                             63 ;; Entrada:
                             64 ;; 	IX => Pointer to entity data 
                             65 ;; Modifica AF, BC, DE, HL
                             66 ;; ===================================
   011A                      67 entityErase::
   011A 11 00 C0      [10]   68 	ld 	de, #0xC000 		;; Video memory  pointer
   011D DD 4E 01      [19]   69 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_H
   0120 DD 46 03      [19]   70 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_H
   0123 CD EE 04      [17]   71 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             72 
   0126 EB            [ 4]   73 	ex 	de, hl 			;; DE = ent screen pointer
   0127 3E 00         [ 7]   74 	ld 	a, #0x00 		;; A = background color
   0129 DD 46 04      [19]   75 	ld 	b, Ent_h(ix) 		;; B = ent height
   012C DD 4E 05      [19]   76 	ld 	c, Ent_w(ix) 		;; C = ent width
   012F CD 41 04      [17]   77 	call cpct_drawSolidBox_asm
                             78 
   0132 C9            [10]   79 	ret
                             80 
                             81 ;; =========================================
                             82 ;; Actualiza el estado de las físicas
                             83 ;; 	de una entidad
                             84 ;; Entrada:
                             85 ;; 	IX => Pointer to entity data
                             86 ;; Modifica F, DE, HL, IX
                             87 ;; =========================================
   0133                      88 entityUpdatePhysics::
                             89 	;; vx' = vx + ax
   0133 DD 66 06      [19]   90 	ld 	h, Ent_vx_I(ix)
   0136 DD 6E 07      [19]   91 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0139 DD 56 0A      [19]   92 	ld 	d, Ent_ax_I(ix)
   013C DD 5E 0B      [19]   93 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                             94 
   013F 19            [11]   95 	add 	hl, de 			;; HL <= HL + DE
                             96 
   0140 7C            [ 4]   97 	ld 	a, h
   0141 FE 02         [ 7]   98 	cp 	#MAX_VEL_X
   0143 F2 51 01      [10]   99 	jp 	p, cant_accelerate_x
                            100 		;; vx' < MAX_VEL_X
   0146 FE FE         [ 7]  101 		cp 	#MIN_VEL_X
   0148 FA 51 01      [10]  102 		jp 	m, cant_accelerate_x
                            103 			;; vx' > MIN_VEL_X
                            104 			;; Can accelerate at X axis
   014B DD 74 06      [19]  105 			ld 	Ent_vx_I(ix), h
   014E DD 75 07      [19]  106 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            107 
   0151                     108 	cant_accelerate_x:
                            109 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            110 
                            111 
                            112 	;; vy = vy + ay
   0151 DD 66 08      [19]  113 	ld 	h, Ent_vy_I(ix)
   0154 DD 6E 09      [19]  114 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0157 DD 56 0C      [19]  115 	ld 	d, Ent_ay_I(ix)
   015A DD 5E 0D      [19]  116 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            117 
   015D 19            [11]  118 	add 	hl, de 			;; HL <= HL + DE
   015E 7C            [ 4]  119 	ld 	a, h
   015F FE 04         [ 7]  120 	cp 	#MAX_VEL_Y
   0161 F2 6F 01      [10]  121 	jp 	p, cant_accelerate_y
                            122 		;; vy' < MIN_VEL_Y
   0164 FE FC         [ 7]  123 		cp 	#MIN_VEL_Y
   0166 FA 6F 01      [10]  124 		jp 	m, cant_accelerate_y
                            125 			;; vy' > MIN_VEL_Y
                            126 			;; Can accelerate at Y axis
   0169 DD 74 08      [19]  127 			ld 	Ent_vy_I(ix), h
   016C DD 75 09      [19]  128 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            129 
   016F                     130 	cant_accelerate_y:
                            131 
   016F DD 36 0A 00   [19]  132 	ld 	Ent_ax_I(ix), #0	;; 
   0173 DD 36 0B 00   [19]  133 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   0177 DD 36 0C 00   [19]  134 	ld 	Ent_ay_I(ix), #0	;; 
   017B DD 36 0D 00   [19]  135 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            136 
   017F CD DC 01      [17]  137 	call entityUpdatePosition
                            138 
   0182 C9            [10]  139 	ret
                            140 
                            141 ;; =========================================
                            142 ;; Comprueba si existe colision entre
                            143 ;; dos entidades.
                            144 ;; Entrada:
                            145 ;; 	IX => Pointer to entity 1 data
                            146 ;; 	HL => Pointer to entity 2 data
                            147 ;; Modifica AF, B, HL, IX
                            148 ;; Devuelve:
                            149 ;; 	A <==== 0 si no hay colisión, y la
                            150 ;; 		diferencia absoluta entre
                            151 ;;		las x, en caso de colisión
                            152 ;; =========================================
   0183 00 00               153 ent1_ptr: .dw #0000
   0185 00 00               154 ent2_ptr: .dw #0000
   0187                     155 entityCheckCollision::
                            156 	;;
                            157 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            158 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            159 	;;
   0187 DD 22 83 01   [20]  160 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   018B 22 85 01      [16]  161 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            162 
   018E DD 7E 01      [19]  163 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0191 DD 86 05      [19]  164 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0194 DD 2A 85 01   [20]  165 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0198 DD 96 01      [19]  166 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   019B F2 A0 01      [10]  167 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            168 
   019E 18 39         [12]  169 	jr 	no_collision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            170 
                            171 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   01A0                     172 	collision_XR:
                            173 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   01A0 47            [ 4]  174 		ld 	b, a 		;; B <= A
                            175 		;;
                            176 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            177 		;; ent2_x + ent2_w - ent1_x <= 0
                            178 		;; 
   01A1 DD 7E 01      [19]  179 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   01A4 DD 86 05      [19]  180 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   01A7 DD 2A 83 01   [20]  181 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01AB DD 96 01      [19]  182 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   01AE F2 B3 01      [10]  183 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            184 
   01B1 18 26         [12]  185 		jr 	no_collision
                            186 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   01B3                     187 	collision_XL:
                            188 		;;
                            189 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            190 		;; ent1_y + ent1_h - ent2_y <= 0
                            191 		;;
   01B3 DD 7E 03      [19]  192 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   01B6 DD 86 04      [19]  193 		add 	Ent_h(ix)		;; A <= A + ent1_w
   01B9 DD 2A 85 01   [20]  194 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   01BD DD 96 03      [19]  195 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   01C0 F2 C5 01      [10]  196 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            197 
   01C3 18 14         [12]  198 		jr 	no_collision
                            199 
                            200 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   01C5                     201 	collision_YB:
                            202 		;;
                            203 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            204 		;; ent2_y + ent2_h - ent1_y <= 0
                            205 		;; 
   01C5 DD 7E 03      [19]  206 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   01C8 DD 86 04      [19]  207 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   01CB DD 2A 83 01   [20]  208 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01CF DD 96 03      [19]  209 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   01D2 F2 D7 01      [10]  210 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            211 
   01D5 18 02         [12]  212 		jr 	no_collision
                            213 
                            214 	;; Hay colisión en el eje Y, , ent2 está entre arriba y abajo de ent1
   01D7                     215 	collision_YT:
                            216 
                            217 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   01D7 78            [ 4]  218 	ld 	a, b
                            219 
   01D8 C9            [10]  220 	ret
                            221 
   01D9                     222 	no_collision:
   01D9 3E 00         [ 7]  223 	ld 	a, #0 	;; A == 0 si no hay colisión
   01DB C9            [10]  224 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            225 
                            226 
                            227 ;; ====================================
                            228 ;; ====================================
                            229 ;; PRIVATE FUNCTIONS
                            230 ;; ====================================
                            231 ;; ====================================
                            232 
                            233 
                            234 ;; =========================================
                            235 ;; Actualiza la posición de la entidad
                            236 ;; Entrada:
                            237 ;; 	IX => Pointer to entity data
                            238 ;; Modifica AF, B, DE, HL, IX
                            239 ;; =========================================
   01DC                     240 entityUpdatePosition:
                            241 
                            242 	;; x' = x + vx_I
   01DC DD 56 06      [19]  243 	ld 	d, Ent_vx_I(ix) 	
   01DF DD 5E 07      [19]  244 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx_I 
                            245 
   01E2 DD 66 01      [19]  246 	ld 	h, Ent_x_I(ix) 		;; 
   01E5 DD 6E 00      [19]  247 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            248 
   01E8 19            [11]  249 	add 	hl, de 			;; H <= HL + DE (x + vx_I)
                            250 
   01E9 44            [ 4]  251 	ld 	b, h 			;; B <= H (x + vx_I)
   01EA 3E 50         [ 7]  252 	ld 	a, #RIGHT_LIMIT
   01EC DD 96 05      [19]  253 	sub 	Ent_w(IX) 		;; A <= RIGHT_LIMIT - Ent_width
                            254 
   01EF B8            [ 4]  255 	cp 	b			;; F <= A - B
   01F0 FA FF 01      [10]  256 	jp 	m, cant_move_x		;; RIGHT_LIMIT - Ent_width < x + vx_I? can't move
                            257 
   01F3 3E 00         [ 7]  258 		ld 	a, #LEFT_LIMIT		;; A <= LEFT_LIMIT
   01F5 B8            [ 4]  259 		cp 	b 			;; F <= A - B
   01F6 F2 FF 01      [10]  260 		jp 	p, cant_move_x		;; LIMIT_LEFT > x + vx_I? can't move
                            261 
                            262 			;; can move
   01F9 DD 74 01      [19]  263 			ld 	Ent_x_I(ix), h
   01FC DD 75 00      [19]  264 			ld 	Ent_x_F(ix), l 		;; Ent_x <= HL
                            265 
   01FF                     266 	cant_move_x:
                            267 
                            268 
                            269 	;; y' = y + vy_I*2
   01FF DD 56 08      [19]  270 	ld 	d, Ent_vy_I(ix)
   0202 DD 5E 09      [19]  271 	ld 	e, Ent_vy_F(ix) 	;; DE <= ent_vy
                            272 
   0205 DD 66 03      [19]  273 	ld 	h, Ent_y_I(ix)
   0208 DD 6E 02      [19]  274 	ld 	l, Ent_y_F(ix) 		;; HL <= Ent_y
                            275 
   020B 19            [11]  276 	add 	hl, de
   020C 19            [11]  277 	add 	hl, de 			;; A <= Ent_y + Ent_vy_I*2
                            278 
   020D 44            [ 4]  279 	ld 	b, h 			;; B <= A (y + ent_vy_I*2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   020E 3E C8         [ 7]  280 	ld 	a, #BOTTOM_LIMIT
   0210 DD 96 04      [19]  281 	sub 	Ent_h(IX) 		;; A <= BOTTOM_LIMIT - Ent_height
                            282 
   0213 B8            [ 4]  283 	cp 	b			;; F <= A - B
   0214 FA 23 02      [10]  284 	jp 	m, cant_move_y		;; BOTTOM_LIMIT - Ent_height < y + ent_vy_I*2? can't move
                            285 
   0217 3E 00         [ 7]  286 		ld 	a, #TOP_LIMIT		;; A <= TOP_LIMIT
   0219 B8            [ 4]  287 		cp 	b 			;; F <= A - B
   021A F2 23 02      [10]  288 		jp 	p, cant_move_y		;; TOP_LIMIT > y + ent_vy_I*2? can't move
                            289 
                            290 			;; can move
   021D DD 74 03      [19]  291 			ld 	Ent_y_I(ix), h
   0220 DD 75 02      [19]  292 			ld 	Ent_y_F(ix), l 		;; Ent_y <= HL
                            293 
   0223                     294 	cant_move_y:
                            295 
   0223 C9            [10]  296 		ret
                            297 
                            298 
                            299 
                            300 ;;	;; x = x + vx_I
                            301 ;;	ld 	d, Ent_vx_I(ix) 	;; D <= ent_vx_I
                            302 ;;	ld 	e, #0			;; E <= 0 (discard fractional part)
                            303 ;;
                            304 ;;	ld 	h, Ent_x(ix) 		;; H <= Ent_x
                            305 ;;	ld 	l, #0			;; L <= 0 (discard fractional part)
                            306 ;;
                            307 ;;	add 	hl, de 			;; H <= H + D (x + vx_I)
                            308 ;;
                            309 ;;	ld 	b, h 			;; B <= H (x + vx_I)
                            310 ;;	ld 	a, #RIGHT_LIMIT
                            311 ;;	sub 	Ent_w(IX) 		;; A <= RIGHT_LIMIT - Ent_width
                            312 ;;
                            313 ;;	cp 	b			;; F <= A - B
                            314 ;;	jp 	m, cant_move_x		;; RIGHT_LIMIT - Ent_width < x + vx_I? can't move
                            315 ;;
                            316 ;;		ld 	a, #LEFT_LIMIT		;; A <= LEFT_LIMIT
                            317 ;;		cp 	b 			;; F <= A - B
                            318 ;;		jp 	p, cant_move_x		;; LIMIT_LEFT > x + vx_I? can't move
                            319 ;;
                            320 ;;			;; can move
                            321 ;;			ld 	Ent_x(ix), h 		;; Ent_x <= H
                            322 ;;
                            323 ;;	cant_move_x:
                            324 
                            325 	;; y = y + vy_I*2
                            326 	;;ld 	h, Ent_vy_I(ix) 	;; H <= ent_vy_I
                            327 	;;ld 	l, Ent_vy_F(ix)		;; L <= ent_vy_F
                            328 ;;
                            329 ;;	;;ld 	d, Ent_y(ix) 		;; D <= Ent_y
                            330 ;;	;;ld 	e, #0			;; E <= 0 (discard fractional part)
                            331 ;;
                            332 ;;	;;add 	hl, hl 			;; H <= H(ent_vy_I)*2
                            333 ;;	;;				;; D <= ent_vy_I*2
                            334 ;;	;;ex 	de, hl 			;; H <= Ent_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 ;;
                            336 ;;	;;add 	hl, de 			;; H <= H (y) + D (ent_vy_I*2)
                            337 ;;
                            338 ;;	;;ld 	b, h 			;; B <= H (y + ent_vy_I*2)
                            339 ;;	;;ld 	a, #BOTTOM_LIMIT
                            340 ;;	;;sub 	Ent_h(IX) 		;; A <= BOTTOM_LIMIT - Ent_height
                            341 ;;
                            342 ;;	;;cp 	b			;; F <= A - B
                            343 ;;	;;jp 	m, cant_move_y		;; BOTTOM_LIMIT - Ent_height < y + ent_vy_I*2? can't move
                            344 ;;
                            345 ;;	;;	ld 	a, #TOP_LIMIT		;; A <= TOP_LIMIT
                            346 ;;	;;	cp 	b 			;; F <= A - B
                            347 ;;	;;	jp 	p, cant_move_y		;; TOP_LIMIT > y + ent_vy_I*2? can't move
                            348 ;;
                            349 ;;	;;		;; can move
                            350 ;;	;;		ld 	Ent_y(ix), h 		;; Ent_y <= H
                            351 ;;
                            352 ;;	;;cant_move_y:
                            353 ;;
                            354 	;;	ret
