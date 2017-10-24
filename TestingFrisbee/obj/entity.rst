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
                             17 .globl cpct_akp_musicPlay_asm
                             18 .globl cpct_akp_stop_asm
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
                     0003    40 .equ MAX_VEL_X, 3 
                     FFFFFFFD    41 .equ MIN_VEL_X, -3
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
   0117                      58 entityDraw::
   0117 CD F0 06      [17]   59 	call 	getVideoPtr		;; HL <= Video memory pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   011A EB            [ 4]   60 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   011B DD 4E 00      [19]   61 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   011E DD 46 02      [19]   62 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   0121 CD AD 10      [17]   63 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             64 
   0124 EB            [ 4]   65 	ex 	de, hl 			;; DE = ent screen pointer
   0125 DD 46 04      [19]   66 	ld 	b, Ent_h(ix) 		;; B = ent height
   0128 DD 4E 05      [19]   67 	ld 	c, Ent_w(ix) 		;; C = ent width
   012B DD 7E 15      [19]   68 	ld 	a, Ent_clr(ix)		;; A = ent colour
   012E CD 00 10      [17]   69 	call cpct_drawSolidBox_asm
                             70 
   0131 CD 38 03      [17]   71 	call updateX
   0134 CD 4C 03      [17]   72 	call updateY
   0137 C9            [10]   73 	ret
                             74 
                             75 ;; ===================================
                             76 ;; Borra una entidad de la pantalla
                             77 ;; Entrada:
                             78 ;; 	IX => Pointer to entity data 
                             79 ;; Modifica AF, BC, DE, HL
                             80 ;; ===================================
   0138                      81 entityErase::
   0138 CD F0 06      [17]   82 	call 	getVideoPtr		;; HL <= Video memory pointer
   013B EB            [ 4]   83 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   013C DD 4E 11      [19]   84 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   013F DD 46 13      [19]   85 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   0142 CD AD 10      [17]   86 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             87 
   0145 EB            [ 4]   88 	ex 	de, hl 			;; DE = ent screen pointer
   0146 3E 00         [ 7]   89 	ld 	a, #0x00 		;; A = background color
   0148 DD 46 04      [19]   90 	ld 	b, Ent_h(ix) 		;; B = ent height
   014B DD 4E 05      [19]   91 	ld 	c, Ent_w(ix) 		;; C = ent width
   014E CD 00 10      [17]   92 	call cpct_drawSolidBox_asm
                             93 
   0151 C9            [10]   94 	ret
                             95 
                             96 ;; =========================================
                             97 ;; Actualiza el estado de las físicas
                             98 ;; 	de una entidad
                             99 ;; Entrada:
                            100 ;; 	IX => Pointer to entity data
                            101 ;; Modifica F, DE, HL
                            102 ;; =========================================
   0152                     103 entityUpdatePhysics::
                            104 	;; vx' = vx + ax
   0152 DD 66 06      [19]  105 	ld 	h, Ent_vx_I(ix)
   0155 DD 6E 07      [19]  106 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0158 DD 56 0A      [19]  107 	ld 	d, Ent_ax_I(ix)
   015B DD 5E 0B      [19]  108 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            109 
   015E 19            [11]  110 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            111 
   015F 7C            [ 4]  112 	ld 	a, h
   0160 FE 03         [ 7]  113 	cp 	#MAX_VEL_X
   0162 F2 70 01      [10]  114 	jp 	p, cant_accelerate_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 		;; vx' < MAX_VEL_X
   0165 FE FD         [ 7]  116 		cp 	#MIN_VEL_X
   0167 FA 70 01      [10]  117 		jp 	m, cant_accelerate_x
                            118 			;; vx' > MIN_VEL_X
                            119 			;; Can accelerate at X axis
   016A DD 74 06      [19]  120 			ld 	Ent_vx_I(ix), h
   016D DD 75 07      [19]  121 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            122 
   0170                     123 	cant_accelerate_x:
                            124 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            125 
                            126 
                            127 	;; vy = vy + ay
   0170 DD 66 08      [19]  128 	ld 	h, Ent_vy_I(ix)
   0173 DD 6E 09      [19]  129 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0176 DD 56 0C      [19]  130 	ld 	d, Ent_ay_I(ix)
   0179 DD 5E 0D      [19]  131 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            132 
   017C 19            [11]  133 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   017D 7C            [ 4]  134 	ld 	a, h
   017E FE 03         [ 7]  135 	cp 	#MAX_VEL_Y
   0180 F2 8E 01      [10]  136 	jp 	p, cant_accelerate_y
                            137 		;; vy' < MIN_VEL_Y
   0183 FE FD         [ 7]  138 		cp 	#MIN_VEL_Y
   0185 FA 8E 01      [10]  139 		jp 	m, cant_accelerate_y
                            140 			;; vy' > MIN_VEL_Y
                            141 			;; Can accelerate at Y axis
   0188 DD 74 08      [19]  142 			ld 	Ent_vy_I(ix), h
   018B DD 75 09      [19]  143 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            144 
   018E                     145 	cant_accelerate_y:
                            146 
                            147 	;; Apply deceleration X axis
   018E DD 7E 06      [19]  148 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0191 FE 00         [ 7]  149 	cp 	#0
   0193 28 37         [12]  150 	jr	z, check_ax
                            151 
   0195                     152 	check_vx:
   0195 DD 7E 06      [19]  153 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0198 FE 00         [ 7]  154 		cp 	#0
   019A FA B3 01      [10]  155 		jp	m, vx_negative
                            156 			;; vx positive
                            157 
   019D DD 66 0E      [19]  158 			ld 	h, Ent_N_I(ix)
   01A0 DD 6E 0F      [19]  159 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            160 
   01A3 CD 28 03      [17]  161 			call 	negateHL		;; HL <= -ent_N
                            162 
   01A6 54            [ 4]  163 			ld 	d, h
   01A7 5D            [ 4]  164 			ld 	e, l			;; DE <= -ent_N
                            165 
   01A8 DD 66 06      [19]  166 			ld 	h, Ent_vx_I(ix)
   01AB DD 6E 07      [19]  167 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            168 
   01AE 19            [11]  169 			add 	hl, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   01AF 38 13         [12]  170 			jr	c, can_decelerate_x
                            171 
   01B1 18 36         [12]  172 			jr cant_decelerate_x
                            173 
   01B3                     174 		vx_negative:
   01B3 28 34         [12]  175 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            176 
   01B5 DD 66 06      [19]  177 			ld 	h, Ent_vx_I(ix)
   01B8 DD 6E 07      [19]  178 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   01BB DD 56 0E      [19]  179 			ld 	d, Ent_N_I(ix)
   01BE DD 5E 0F      [19]  180 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            181 
   01C1 19            [11]  182 			add 	hl, de
   01C2 38 00         [12]  183 			jr	c, can_decelerate_x
                            184 
   01C4                     185 			can_decelerate_x:
   01C4 DD 74 06      [19]  186 				ld 	Ent_vx_I(ix), h
   01C7 DD 75 07      [19]  187 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            188 
   01CA 18 1D         [12]  189 				jr cant_decelerate_x
   01CC                     190 	check_ax:
   01CC DD 7E 0A      [19]  191 		ld	a, Ent_ax_I(ix)
   01CF FE 00         [ 7]  192 		cp 	#0
   01D1 20 C2         [12]  193 		jr	nz, check_vx
   01D3 DD 7E 0B      [19]  194 		ld	a, Ent_ax_F(ix)
   01D6 FE 00         [ 7]  195 		cp 	#0
   01D8 20 BB         [12]  196 		jr	nz, check_vx
                            197 			;; vx_I == 0 && ax == 0
   01DA DD 7E 16      [19]  198 			ld	a, Ent_id(ix)
   01DD FE 00         [ 7]  199 			cp	#0
   01DF 28 08         [12]  200 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            201 
   01E1 DD 36 06 00   [19]  202 			ld	Ent_vx_I(ix), #0
   01E5 DD 36 07 00   [19]  203 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            204 
                            205 
   01E9                     206 	cant_decelerate_x:
                            207 
                            208 	;; Apply deceleration Y axis
   01E9 DD 7E 08      [19]  209 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   01EC FE 00         [ 7]  210 	cp 	#0
   01EE 28 35         [12]  211 	jr	z, check_ay
                            212 
   01F0                     213 	check_vy:
   01F0 DD 7E 08      [19]  214 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   01F3 FE 00         [ 7]  215 		cp 	#0
   01F5 FA 0E 02      [10]  216 		jp	m, vy_negative
                            217 
                            218 			;; vy positive
   01F8 DD 66 0E      [19]  219 			ld 	h, Ent_N_I(ix)
   01FB DD 6E 0F      [19]  220 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            221 
   01FE CD 28 03      [17]  222 			call 	negateHL		;; HL <= -ent_N
                            223 
   0201 54            [ 4]  224 			ld 	d, h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0202 5D            [ 4]  225 			ld 	e, l			;; DE <= -ent_N
                            226 
   0203 DD 66 08      [19]  227 			ld 	h, Ent_vy_I(ix)
   0206 DD 6E 09      [19]  228 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            229 
   0209 19            [11]  230 			add 	hl, de
   020A 38 11         [12]  231 			jr	c, can_decelerate_y
                            232 
   020C 18 34         [12]  233 			jr cant_decelerate_y
                            234 
   020E                     235 		vy_negative:
   020E DD 66 08      [19]  236 			ld 	h, Ent_vy_I(ix)
   0211 DD 6E 09      [19]  237 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0214 DD 56 0E      [19]  238 			ld 	d, Ent_N_I(ix)
   0217 DD 5E 0F      [19]  239 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            240 
   021A 19            [11]  241 			add 	hl, de
   021B 38 00         [12]  242 			jr	c, can_decelerate_y
                            243 
   021D                     244 			can_decelerate_y:
   021D DD 74 08      [19]  245 				ld 	Ent_vy_I(ix), h
   0220 DD 75 09      [19]  246 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            247 
                            248 
   0223 18 1D         [12]  249 				jr cant_decelerate_y
   0225                     250 	check_ay:
   0225 DD 7E 0C      [19]  251 		ld	a, Ent_ay_I(ix)
   0228 FE 00         [ 7]  252 		cp 	#0
   022A 20 C4         [12]  253 		jr	nz, check_vy
   022C DD 7E 0D      [19]  254 		ld	a, Ent_ay_F(ix)
   022F FE 00         [ 7]  255 		cp 	#0
   0231 20 BD         [12]  256 		jr	nz, check_vy
                            257 			;; vy_I == 0 && ay == 0
   0233 DD 7E 16      [19]  258 			ld	a, Ent_id(ix)
   0236 FE 00         [ 7]  259 			cp	#0
   0238 28 08         [12]  260 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            261 			
   023A DD 36 08 00   [19]  262 			ld	Ent_vy_I(ix), #0
   023E DD 36 09 00   [19]  263 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            264 
   0242                     265 	cant_decelerate_y:
                            266 
   0242 DD 36 0A 00   [19]  267 	ld 	Ent_ax_I(ix), #0	;; 
   0246 DD 36 0B 00   [19]  268 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   024A DD 36 0C 00   [19]  269 	ld 	Ent_ay_I(ix), #0	;; 
   024E DD 36 0D 00   [19]  270 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            271 
   0252 C9            [10]  272 	ret
                            273 
                            274 ;; =========================================
                            275 ;; Comprueba si existe colision entre
                            276 ;; dos entidades.
                            277 ;; Entrada:
                            278 ;; 	IX => Pointer to entity 1 data
                            279 ;; 	HL => Pointer to entity 2 data
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            280 ;; Modifica AF, B, HL, IX
                            281 ;; Devuelve:
                            282 ;; 	A <==== 0 si no hay colisión, y la
                            283 ;; 		diferencia absoluta entre
                            284 ;;		las x, en caso de colisión
                            285 ;; =========================================
   0253 00 00               286 ent1_ptr: .dw #0000
   0255 00 00               287 ent2_ptr: .dw #0000
   0257                     288 entityCheckCollision::
                            289 	;;
                            290 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            291 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            292 	;;
   0257 DD 22 53 02   [20]  293 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   025B 22 55 02      [16]  294 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            295 
   025E DD 7E 00      [19]  296 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0261 DD 86 05      [19]  297 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0264 DD 2A 55 02   [20]  298 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0268 DD 96 00      [19]  299 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   026B F2 70 02      [10]  300 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            301 
   026E 18 39         [12]  302 	jr 	no_collision
                            303 
                            304 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0270                     305 	collision_XR:
                            306 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0270 47            [ 4]  307 		ld 	b, a 		;; B <= A
                            308 		;;
                            309 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            310 		;; ent2_x + ent2_w - ent1_x <= 0
                            311 		;; 
   0271 DD 7E 00      [19]  312 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0274 DD 86 05      [19]  313 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   0277 DD 2A 53 02   [20]  314 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   027B DD 96 00      [19]  315 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   027E F2 83 02      [10]  316 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            317 
   0281 18 26         [12]  318 		jr 	no_collision
                            319 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   0283                     320 	collision_XL:
                            321 		;;
                            322 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            323 		;; ent1_y + ent1_h - ent2_y <= 0
                            324 		;;
   0283 DD 7E 02      [19]  325 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   0286 DD 86 04      [19]  326 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0289 DD 2A 55 02   [20]  327 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   028D DD 96 02      [19]  328 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0290 F2 95 02      [10]  329 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            330 
   0293 18 14         [12]  331 		jr 	no_collision
                            332 
                            333 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0295                     334 	collision_YB:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 		;;
                            336 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            337 		;; ent2_y + ent2_h - ent1_y <= 0
                            338 		;; 
   0295 DD 7E 02      [19]  339 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0298 DD 86 04      [19]  340 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   029B DD 2A 53 02   [20]  341 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   029F DD 96 02      [19]  342 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   02A2 F2 A7 02      [10]  343 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            344 
   02A5 18 02         [12]  345 		jr 	no_collision
                            346 
                            347 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   02A7                     348 	collision_YT:
                            349 
                            350 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   02A7 78            [ 4]  351 	ld 	a, b
                            352 
   02A8 C9            [10]  353 	ret
                            354 
   02A9                     355 	no_collision:
   02A9 3E 00         [ 7]  356 	ld 	a, #0 	;; A == 0 si no hay colisión
   02AB C9            [10]  357 	ret
                            358 
                            359 
                            360 ;; =========================================
                            361 ;; Actualiza la posición de la entidad
                            362 ;; Entrada:
                            363 ;; 	IX => Pointer to entity data
                            364 ;; Modifica AF, B, DE, HL, IX
                            365 ;; =========================================
   02AC                     366 entityUpdatePosition::
                            367 
                            368 	;; x' = x + vx_I
   02AC DD 56 06      [19]  369 	ld 	d, Ent_vx_I(ix) 	
   02AF DD 5E 07      [19]  370 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            371 
   02B2 DD 66 00      [19]  372 	ld 	h, Ent_x_I(ix) 		;; 
   02B5 DD 6E 01      [19]  373 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            374 
   02B8 19            [11]  375 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            376 
   02B9 7C            [ 4]  377 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   02BA FE 00         [ 7]  378 	cp 	#LEFT_LIMIT
   02BC FA CD 02      [10]  379 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            380 		;; can move left
   02BF DD 86 05      [19]  381 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   02C2 47            [ 4]  382 		ld	b, a
   02C3 3E 50         [ 7]  383 		ld 	a, #RIGHT_LIMIT
   02C5 B8            [ 4]  384 		cp	b
   02C6 38 0E         [12]  385 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            386 			;; can move
   02C8 CD 31 03      [17]  387 			call setX 		;; Ent_x <= HL (x + vx)
                            388 
   02CB 18 14         [12]  389 			jr check_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 
   02CD                     391 	check_left:
   02CD 26 00         [ 7]  392 		ld 	h, #LEFT_LIMIT
   02CF 2E 00         [ 7]  393 		ld 	l, #0
   02D1 CD 31 03      [17]  394 		call	setX 			;; Ent_x <= LEFT_LIMIT
   02D4 18 0B         [12]  395 			jr check_y
                            396 
   02D6                     397 	check_right:
   02D6 3E 50         [ 7]  398 		ld 	a, #RIGHT_LIMIT
   02D8 DD 96 05      [19]  399 		sub	a, Ent_w(ix)
   02DB 67            [ 4]  400 		ld 	h, a
   02DC 2E 00         [ 7]  401 		ld 	l, #0
   02DE CD 31 03      [17]  402 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            403 
   02E1                     404 	check_y:
                            405 	;; y' = y + vy_I*2
   02E1 DD 56 08      [19]  406 	ld 	d, Ent_vy_I(ix) 	
   02E4 DD 5E 09      [19]  407 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            408 
   02E7 DD 66 02      [19]  409 	ld 	h, Ent_y_I(ix) 		;; 
   02EA DD 6E 03      [19]  410 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            411 
   02ED 19            [11]  412 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   02EE 19            [11]  413 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            414 
   02EF 7C            [ 4]  415 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   02F0 FE 0A         [ 7]  416 	cp 	#TOP_LIMIT
   02F2 DA 04 03      [10]  417 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            418 		;; can move up
   02F5 7C            [ 4]  419 		ld 	a, h
   02F6 DD 86 04      [19]  420 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   02F9 47            [ 4]  421 		ld	b, a
   02FA 3E C8         [ 7]  422 		ld 	a, #BOTTOM_LIMIT
   02FC B8            [ 4]  423 		cp	b
   02FD DA 0D 03      [10]  424 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            425 			;; can move
   0300 CD 45 03      [17]  426 			call 	setY			;; Ent_y <= HL (y + vy)
                            427 
   0303 C9            [10]  428 			ret
                            429 
                            430 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            431 
   0304                     432 	check_top:
   0304 26 0A         [ 7]  433 		ld 	h, #TOP_LIMIT
   0306 2E 00         [ 7]  434 		ld 	l, #0
   0308 CD 45 03      [17]  435 		call 	setY				;; Ent_y <= TOP_LIMIT
   030B 18 0B         [12]  436 		jr bounce
                            437 
   030D                     438 	check_bot:
   030D 3E C8         [ 7]  439 		ld 	a, #BOTTOM_LIMIT
   030F DD 96 04      [19]  440 		sub	a, Ent_h(ix)
   0312 67            [ 4]  441 		ld 	h, a
   0313 2E 00         [ 7]  442 		ld 	l, #0
   0315 CD 45 03      [17]  443 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            444 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0318                     445 	bounce:
   0318 DD 66 08      [19]  446 			ld 	h, Ent_vy_I(ix)
   031B DD 6E 09      [19]  447 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            448 
   031E CD 28 03      [17]  449 			call 	negateHL
                            450 
   0321 DD 74 08      [19]  451 			ld 	Ent_vy_I(ix), h
   0324 DD 75 09      [19]  452 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            453 
   0327 C9            [10]  454 		ret
                            455 
                            456 ;; =========================================
                            457 ;; Inverts HL value
                            458 ;; Entrada:
                            459 ;; 	HL => value we are going to negate
                            460 ;; Modifica AF, HL
                            461 ;; Devuelve:
                            462 ;; 	HL <= HL value negated
                            463 ;; =========================================
   0328                     464 negateHL::
   0328 3E 00         [ 7]  465 	ld 	a, #0			;;
   032A AF            [ 4]  466 	xor	a			;;
   032B 95            [ 4]  467 	sub	l			;;
   032C 6F            [ 4]  468 	ld	l,a			;;
   032D 9F            [ 4]  469 	sbc	a,a			;;
   032E 94            [ 4]  470 	sub	h			;;
   032F 67            [ 4]  471 	ld	h,a			;; negate HL
                            472 
   0330 C9            [10]  473 	ret
                            474 
                            475 ;; ====================================
                            476 ;; ====================================
                            477 ;; PRIVATE FUNCTIONS
                            478 ;; ====================================
                            479 ;; ====================================
                            480 
                            481 
                            482 
                            483 ;; =========================================
                            484 ;; Modifica la x de la entidad a la pasada
                            485 ;; 	por parámetro
                            486 ;; Entrada:
                            487 ;; 	IX => Pointer to entity data
                            488 ;; 	HL => value we are going to set
                            489 ;; Modifica AF
                            490 ;; =========================================
   0331                     491 setX:
   0331 DD 74 00      [19]  492 	ld	Ent_x_I(ix), h
   0334 DD 75 01      [19]  493 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            494 
   0337 C9            [10]  495 	ret
                            496 
                            497 
                            498 ;; =========================================
                            499 ;; Modifica las de últimas posiciones X
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            500 ;	de la entidad
                            501 ;; Entrada:
                            502 ;; 	IX => Pointer to entity data
                            503 ;; Modifica AF
                            504 ;; =========================================
   0338                     505 updateX:
   0338 DD 7E 10      [19]  506 	ld	a, Ent_last_x(ix)
   033B DD 77 11      [19]  507 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            508 
   033E DD 7E 00      [19]  509 	ld	a, Ent_x_I(ix)
   0341 DD 77 10      [19]  510 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   0344 C9            [10]  511 	ret
                            512 
                            513 
                            514 ;; =========================================
                            515 ;; Modifica la y de la entidad a la pasada
                            516 ;; 	por parámetro
                            517 ;; Entrada:
                            518 ;; 	IX => Pointer to entity data
                            519 ;; 	HL => value we are going to set
                            520 ;; Modifica AF
                            521 ;; =========================================
   0345                     522 setY:
                            523 
   0345 DD 74 02      [19]  524 	ld	Ent_y_I(ix), h
   0348 DD 75 03      [19]  525 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            526 
   034B C9            [10]  527 	ret
                            528 
                            529 
                            530 ;; =========================================
                            531 ;; Modifica las de últimas posiciones Y
                            532 ;	de la entidad
                            533 ;; Entrada:
                            534 ;; 	IX => Pointer to entity data
                            535 ;; Modifica AF
                            536 ;; =========================================
   034C                     537 updateY:
   034C DD 7E 12      [19]  538 	ld	a, Ent_last_y(ix)
   034F DD 77 13      [19]  539 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            540 
   0352 DD 7E 02      [19]  541 	ld	a, Ent_y_I(ix)
   0355 DD 77 12      [19]  542 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   0358 C9            [10]  543 	ret
