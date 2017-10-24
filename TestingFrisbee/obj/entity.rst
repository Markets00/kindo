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
   0117 CD 79 06      [17]   59 	call 	getVideoPtr		;; HL <= Video memory pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   011A EB            [ 4]   60 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   011B DD 4E 00      [19]   61 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   011E DD 46 02      [19]   62 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   0121 CD 36 10      [17]   63 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             64 
   0124 EB            [ 4]   65 	ex 	de, hl 			;; DE = ent screen pointer
   0125 DD 46 04      [19]   66 	ld 	b, Ent_h(ix) 		;; B = ent height
   0128 DD 4E 05      [19]   67 	ld 	c, Ent_w(ix) 		;; C = ent width
   012B DD 7E 15      [19]   68 	ld 	a, Ent_clr(ix)		;; A = ent colour
   012E CD 89 0F      [17]   69 	call cpct_drawSolidBox_asm
                             70 
   0131 CD EC 02      [17]   71 	call updateX
   0134 CD 00 03      [17]   72 	call updateY
   0137 C9            [10]   73 	ret
                             74 
                             75 ;; ===================================
                             76 ;; Borra una entidad de la pantalla
                             77 ;; Entrada:
                             78 ;; 	IX => Pointer to entity data 
                             79 ;; Modifica AF, BC, DE, HL
                             80 ;; ===================================
   0138                      81 entityErase::
   0138 CD 79 06      [17]   82 	call 	getVideoPtr		;; HL <= Video memory pointer
   013B EB            [ 4]   83 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   013C DD 4E 11      [19]   84 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   013F DD 46 13      [19]   85 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   0142 CD 36 10      [17]   86 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             87 
   0145 EB            [ 4]   88 	ex 	de, hl 			;; DE = ent screen pointer
   0146 3E 00         [ 7]   89 	ld 	a, #0x00 		;; A = background color
   0148 DD 46 04      [19]   90 	ld 	b, Ent_h(ix) 		;; B = ent height
   014B DD 4E 05      [19]   91 	ld 	c, Ent_w(ix) 		;; C = ent width
   014E CD 89 0F      [17]   92 	call cpct_drawSolidBox_asm
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
                            150 	;;jr 	z, cant_decelerate_x	;; vx_I == 0?
                            151 		;; vx_I != 0
   0193 FA AC 01      [10]  152 	jp	m, vx_negative
                            153 		;; vx positive
                            154 
   0196 DD 66 0E      [19]  155 		ld 	h, Ent_N_I(ix)
   0199 DD 6E 0F      [19]  156 		ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            157 
   019C CD DC 02      [17]  158 		call 	negateHL		;; HL <= -ent_N
                            159 
   019F 54            [ 4]  160 		ld 	d, h
   01A0 5D            [ 4]  161 		ld 	e, l			;; DE <= -ent_N
                            162 
   01A1 DD 66 06      [19]  163 		ld 	h, Ent_vx_I(ix)
   01A4 DD 6E 07      [19]  164 		ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            165 
   01A7 19            [11]  166 		add 	hl, de
   01A8 38 13         [12]  167 		jr	c, can_decelerate_x
                            168 
   01AA 18 11         [12]  169 		jr can_decelerate_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            170 
   01AC                     171 	vx_negative:
   01AC 28 15         [12]  172 		jr 	z, cant_decelerate_x	;; vx_I == 0?
                            173 
   01AE DD 66 06      [19]  174 		ld 	h, Ent_vx_I(ix)
   01B1 DD 6E 07      [19]  175 		ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   01B4 DD 56 0E      [19]  176 		ld 	d, Ent_N_I(ix)
   01B7 DD 5E 0F      [19]  177 		ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            178 
   01BA 19            [11]  179 		add 	hl, de
   01BB 38 00         [12]  180 		jr	c, can_decelerate_x
                            181 
   01BD                     182 		can_decelerate_x:
   01BD DD 74 06      [19]  183 			ld 	Ent_vx_I(ix), h
   01C0 DD 75 07      [19]  184 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            185 
   01C3                     186 	cant_decelerate_x:
                            187 
                            188 	;; Apply deceleration Y axis
   01C3 DD 7E 08      [19]  189 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   01C6 FE 00         [ 7]  190 	cp 	#0
                            191 	;;jr 	z, cant_decelerate_y	;; vy_I == 0?
                            192 		;; vy_I != 0
   01C8 FA E1 01      [10]  193 		jp	m, vy_negative
                            194 
                            195 			;; vy positive
   01CB DD 66 0E      [19]  196 			ld 	h, Ent_N_I(ix)
   01CE DD 6E 0F      [19]  197 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            198 
   01D1 CD DC 02      [17]  199 			call 	negateHL		;; HL <= -ent_N
                            200 
   01D4 54            [ 4]  201 			ld 	d, h
   01D5 5D            [ 4]  202 			ld 	e, l			;; DE <= -ent_N
                            203 
   01D6 DD 66 08      [19]  204 			ld 	h, Ent_vy_I(ix)
   01D9 DD 6E 09      [19]  205 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            206 
   01DC 19            [11]  207 			add 	hl, de
   01DD 38 11         [12]  208 			jr	c, can_decelerate_y
                            209 
   01DF 18 0F         [12]  210 			jr can_decelerate_y
                            211 
   01E1                     212 		vy_negative:
   01E1 DD 66 08      [19]  213 			ld 	h, Ent_vy_I(ix)
   01E4 DD 6E 09      [19]  214 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   01E7 DD 56 0E      [19]  215 			ld 	d, Ent_N_I(ix)
   01EA DD 5E 0F      [19]  216 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            217 
   01ED 19            [11]  218 			add 	hl, de
   01EE 38 00         [12]  219 			jr	c, can_decelerate_y
                            220 
   01F0                     221 			can_decelerate_y:
   01F0 DD 74 08      [19]  222 				ld 	Ent_vy_I(ix), h
   01F3 DD 75 09      [19]  223 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            224 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   01F6                     225 	cant_decelerate_y:
                            226 
   01F6 DD 36 0A 00   [19]  227 	ld 	Ent_ax_I(ix), #0	;; 
   01FA DD 36 0B 00   [19]  228 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   01FE DD 36 0C 00   [19]  229 	ld 	Ent_ay_I(ix), #0	;; 
   0202 DD 36 0D 00   [19]  230 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            231 
   0206 C9            [10]  232 	ret
                            233 
                            234 ;; =========================================
                            235 ;; Comprueba si existe colision entre
                            236 ;; dos entidades.
                            237 ;; Entrada:
                            238 ;; 	IX => Pointer to entity 1 data
                            239 ;; 	HL => Pointer to entity 2 data
                            240 ;; Modifica AF, B, HL, IX
                            241 ;; Devuelve:
                            242 ;; 	A <==== 0 si no hay colisión, y la
                            243 ;; 		diferencia absoluta entre
                            244 ;;		las x, en caso de colisión
                            245 ;; =========================================
   0207 00 00               246 ent1_ptr: .dw #0000
   0209 00 00               247 ent2_ptr: .dw #0000
   020B                     248 entityCheckCollision::
                            249 	;;
                            250 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            251 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            252 	;;
   020B DD 22 07 02   [20]  253 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   020F 22 09 02      [16]  254 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            255 
   0212 DD 7E 00      [19]  256 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0215 DD 86 05      [19]  257 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0218 DD 2A 09 02   [20]  258 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   021C DD 96 00      [19]  259 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   021F F2 24 02      [10]  260 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            261 
   0222 18 39         [12]  262 	jr 	no_collision
                            263 
                            264 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0224                     265 	collision_XR:
                            266 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0224 47            [ 4]  267 		ld 	b, a 		;; B <= A
                            268 		;;
                            269 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            270 		;; ent2_x + ent2_w - ent1_x <= 0
                            271 		;; 
   0225 DD 7E 00      [19]  272 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0228 DD 86 05      [19]  273 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   022B DD 2A 07 02   [20]  274 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   022F DD 96 00      [19]  275 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   0232 F2 37 02      [10]  276 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            277 
   0235 18 26         [12]  278 		jr 	no_collision
                            279 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   0237                     280 	collision_XL:
                            281 		;;
                            282 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            283 		;; ent1_y + ent1_h - ent2_y <= 0
                            284 		;;
   0237 DD 7E 02      [19]  285 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   023A DD 86 04      [19]  286 		add 	Ent_h(ix)		;; A <= A + ent1_w
   023D DD 2A 09 02   [20]  287 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0241 DD 96 02      [19]  288 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0244 F2 49 02      [10]  289 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            290 
   0247 18 14         [12]  291 		jr 	no_collision
                            292 
                            293 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0249                     294 	collision_YB:
                            295 		;;
                            296 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            297 		;; ent2_y + ent2_h - ent1_y <= 0
                            298 		;; 
   0249 DD 7E 02      [19]  299 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   024C DD 86 04      [19]  300 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   024F DD 2A 07 02   [20]  301 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0253 DD 96 02      [19]  302 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   0256 F2 5B 02      [10]  303 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            304 
   0259 18 02         [12]  305 		jr 	no_collision
                            306 
                            307 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   025B                     308 	collision_YT:
                            309 
                            310 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   025B 78            [ 4]  311 	ld 	a, b
                            312 
   025C C9            [10]  313 	ret
                            314 
   025D                     315 	no_collision:
   025D 3E 00         [ 7]  316 	ld 	a, #0 	;; A == 0 si no hay colisión
   025F C9            [10]  317 	ret
                            318 
                            319 
                            320 ;; =========================================
                            321 ;; Actualiza la posición de la entidad
                            322 ;; Entrada:
                            323 ;; 	IX => Pointer to entity data
                            324 ;; Modifica AF, B, DE, HL, IX
                            325 ;; =========================================
   0260                     326 entityUpdatePosition::
                            327 
                            328 	;; x' = x + vx_I
   0260 DD 56 06      [19]  329 	ld 	d, Ent_vx_I(ix) 	
   0263 DD 5E 07      [19]  330 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            331 
   0266 DD 66 00      [19]  332 	ld 	h, Ent_x_I(ix) 		;; 
   0269 DD 6E 01      [19]  333 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            334 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   026C 19            [11]  335 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            336 
   026D 7C            [ 4]  337 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   026E FE 00         [ 7]  338 	cp 	#LEFT_LIMIT
   0270 FA 81 02      [10]  339 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            340 		;; can move left
   0273 DD 86 05      [19]  341 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   0276 47            [ 4]  342 		ld	b, a
   0277 3E 50         [ 7]  343 		ld 	a, #RIGHT_LIMIT
   0279 B8            [ 4]  344 		cp	b
   027A 38 0E         [12]  345 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            346 			;; can move
   027C CD E5 02      [17]  347 			call setX 		;; Ent_x <= HL (x + vx)
                            348 
   027F 18 14         [12]  349 			jr check_y
                            350 
   0281                     351 	check_left:
   0281 26 00         [ 7]  352 		ld 	h, #LEFT_LIMIT
   0283 2E 00         [ 7]  353 		ld 	l, #0
   0285 CD E5 02      [17]  354 		call	setX 			;; Ent_x <= LEFT_LIMIT
   0288 18 0B         [12]  355 			jr check_y
                            356 
   028A                     357 	check_right:
   028A 3E 50         [ 7]  358 		ld 	a, #RIGHT_LIMIT
   028C DD 96 05      [19]  359 		sub	a, Ent_w(ix)
   028F 67            [ 4]  360 		ld 	h, a
   0290 2E 00         [ 7]  361 		ld 	l, #0
   0292 CD E5 02      [17]  362 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            363 
   0295                     364 	check_y:
                            365 	;; y' = y + vy_I*2
   0295 DD 56 08      [19]  366 	ld 	d, Ent_vy_I(ix) 	
   0298 DD 5E 09      [19]  367 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            368 
   029B DD 66 02      [19]  369 	ld 	h, Ent_y_I(ix) 		;; 
   029E DD 6E 03      [19]  370 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            371 
   02A1 19            [11]  372 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   02A2 19            [11]  373 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            374 
   02A3 7C            [ 4]  375 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   02A4 FE 0A         [ 7]  376 	cp 	#TOP_LIMIT
   02A6 DA B8 02      [10]  377 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            378 		;; can move up
   02A9 7C            [ 4]  379 		ld 	a, h
   02AA DD 86 04      [19]  380 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   02AD 47            [ 4]  381 		ld	b, a
   02AE 3E C8         [ 7]  382 		ld 	a, #BOTTOM_LIMIT
   02B0 B8            [ 4]  383 		cp	b
   02B1 DA C1 02      [10]  384 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            385 			;; can move
   02B4 CD F9 02      [17]  386 			call 	setY			;; Ent_y <= HL (y + vy)
                            387 
   02B7 C9            [10]  388 			ret
                            389 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            391 
   02B8                     392 	check_top:
   02B8 26 0A         [ 7]  393 		ld 	h, #TOP_LIMIT
   02BA 2E 00         [ 7]  394 		ld 	l, #0
   02BC CD F9 02      [17]  395 		call 	setY				;; Ent_y <= TOP_LIMIT
   02BF 18 0B         [12]  396 		jr bounce
                            397 
   02C1                     398 	check_bot:
   02C1 3E C8         [ 7]  399 		ld 	a, #BOTTOM_LIMIT
   02C3 DD 96 04      [19]  400 		sub	a, Ent_h(ix)
   02C6 67            [ 4]  401 		ld 	h, a
   02C7 2E 00         [ 7]  402 		ld 	l, #0
   02C9 CD F9 02      [17]  403 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            404 
   02CC                     405 	bounce:
   02CC DD 66 08      [19]  406 			ld 	h, Ent_vy_I(ix)
   02CF DD 6E 09      [19]  407 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            408 
   02D2 CD DC 02      [17]  409 			call 	negateHL
                            410 
   02D5 DD 74 08      [19]  411 			ld 	Ent_vy_I(ix), h
   02D8 DD 75 09      [19]  412 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            413 
   02DB C9            [10]  414 		ret
                            415 
                            416 ;; =========================================
                            417 ;; Inverts HL value
                            418 ;; Entrada:
                            419 ;; 	HL => value we are going to negate
                            420 ;; Modifica AF, HL
                            421 ;; Devuelve:
                            422 ;; 	HL <= HL value negated
                            423 ;; =========================================
   02DC                     424 negateHL::
   02DC 3E 00         [ 7]  425 	ld 	a, #0			;;
   02DE AF            [ 4]  426 	xor	a			;;
   02DF 95            [ 4]  427 	sub	l			;;
   02E0 6F            [ 4]  428 	ld	l,a			;;
   02E1 9F            [ 4]  429 	sbc	a,a			;;
   02E2 94            [ 4]  430 	sub	h			;;
   02E3 67            [ 4]  431 	ld	h,a			;; negate HL
                            432 
   02E4 C9            [10]  433 	ret
                            434 
                            435 ;; ====================================
                            436 ;; ====================================
                            437 ;; PRIVATE FUNCTIONS
                            438 ;; ====================================
                            439 ;; ====================================
                            440 
                            441 
                            442 
                            443 ;; =========================================
                            444 ;; Modifica la x de la entidad a la pasada
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            445 ;; 	por parámetro
                            446 ;; Entrada:
                            447 ;; 	IX => Pointer to entity data
                            448 ;; 	HL => value we are going to set
                            449 ;; Modifica AF
                            450 ;; =========================================
   02E5                     451 setX:
   02E5 DD 74 00      [19]  452 	ld	Ent_x_I(ix), h
   02E8 DD 75 01      [19]  453 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            454 
   02EB C9            [10]  455 	ret
                            456 
                            457 
                            458 ;; =========================================
                            459 ;; Modifica las de últimas posiciones X
                            460 ;	de la entidad
                            461 ;; Entrada:
                            462 ;; 	IX => Pointer to entity data
                            463 ;; Modifica AF
                            464 ;; =========================================
   02EC                     465 updateX:
   02EC DD 7E 10      [19]  466 	ld	a, Ent_last_x(ix)
   02EF DD 77 11      [19]  467 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            468 
   02F2 DD 7E 00      [19]  469 	ld	a, Ent_x_I(ix)
   02F5 DD 77 10      [19]  470 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   02F8 C9            [10]  471 	ret
                            472 
                            473 
                            474 ;; =========================================
                            475 ;; Modifica la y de la entidad a la pasada
                            476 ;; 	por parámetro
                            477 ;; Entrada:
                            478 ;; 	IX => Pointer to entity data
                            479 ;; 	HL => value we are going to set
                            480 ;; Modifica AF
                            481 ;; =========================================
   02F9                     482 setY:
                            483 
   02F9 DD 74 02      [19]  484 	ld	Ent_y_I(ix), h
   02FC DD 75 03      [19]  485 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            486 
   02FF C9            [10]  487 	ret
                            488 
                            489 
                            490 ;; =========================================
                            491 ;; Modifica las de últimas posiciones Y
                            492 ;	de la entidad
                            493 ;; Entrada:
                            494 ;; 	IX => Pointer to entity data
                            495 ;; Modifica AF
                            496 ;; =========================================
   0300                     497 updateY:
   0300 DD 7E 12      [19]  498 	ld	a, Ent_last_y(ix)
   0303 DD 77 13      [19]  499 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            500 
   0306 DD 7E 02      [19]  501 	ld	a, Ent_y_I(ix)
   0309 DD 77 12      [19]  502 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   030C C9            [10]  503 	ret
