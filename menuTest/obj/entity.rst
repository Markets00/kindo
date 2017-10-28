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
   0903                      58 entityDraw::
   0903 CD 03 0F      [17]   59 	call 	getVideoPtr		;; HL <= Video memory pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0906 EB            [ 4]   60 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0907 DD 4E 00      [19]   61 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   090A DD 46 02      [19]   62 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   090D CD 63 19      [17]   63 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             64 
   0910 EB            [ 4]   65 	ex 	de, hl 			;; DE = ent screen pointer
   0911 DD 46 04      [19]   66 	ld 	b, Ent_h(ix) 		;; B = ent height
   0914 DD 4E 05      [19]   67 	ld 	c, Ent_w(ix) 		;; C = ent width
   0917 DD 7E 15      [19]   68 	ld 	a, Ent_clr(ix)		;; A = ent colour
   091A CD B6 18      [17]   69 	call cpct_drawSolidBox_asm
                             70 
   091D CD 24 0B      [17]   71 	call updateX
   0920 CD 38 0B      [17]   72 	call updateY
   0923 C9            [10]   73 	ret
                             74 
                             75 ;; ===================================
                             76 ;; Borra una entidad de la pantalla
                             77 ;; Entrada:
                             78 ;; 	IX => Pointer to entity data 
                             79 ;; Modifica AF, BC, DE, HL
                             80 ;; ===================================
   0924                      81 entityErase::
   0924 CD 03 0F      [17]   82 	call 	getVideoPtr		;; HL <= Video memory pointer
   0927 EB            [ 4]   83 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0928 DD 4E 11      [19]   84 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   092B DD 46 13      [19]   85 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   092E CD 63 19      [17]   86 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             87 
   0931 EB            [ 4]   88 	ex 	de, hl 			;; DE = ent screen pointer
   0932 3E 00         [ 7]   89 	ld 	a, #0x00 		;; A = background color
   0934 DD 46 04      [19]   90 	ld 	b, Ent_h(ix) 		;; B = ent height
   0937 DD 4E 05      [19]   91 	ld 	c, Ent_w(ix) 		;; C = ent width
   093A CD B6 18      [17]   92 	call cpct_drawSolidBox_asm
                             93 
   093D C9            [10]   94 	ret
                             95 
                             96 ;; =========================================
                             97 ;; Actualiza el estado de las físicas
                             98 ;; 	de una entidad
                             99 ;; Entrada:
                            100 ;; 	IX => Pointer to entity data
                            101 ;; Modifica F, DE, HL
                            102 ;; =========================================
   093E                     103 entityUpdatePhysics::
                            104 	;; vx' = vx + ax
   093E DD 66 06      [19]  105 	ld 	h, Ent_vx_I(ix)
   0941 DD 6E 07      [19]  106 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0944 DD 56 0A      [19]  107 	ld 	d, Ent_ax_I(ix)
   0947 DD 5E 0B      [19]  108 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            109 
   094A 19            [11]  110 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            111 
   094B 7C            [ 4]  112 	ld 	a, h
   094C FE 03         [ 7]  113 	cp 	#MAX_VEL_X
   094E F2 5C 09      [10]  114 	jp 	p, cant_accelerate_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 		;; vx' < MAX_VEL_X
   0951 FE FD         [ 7]  116 		cp 	#MIN_VEL_X
   0953 FA 5C 09      [10]  117 		jp 	m, cant_accelerate_x
                            118 			;; vx' > MIN_VEL_X
                            119 			;; Can accelerate at X axis
   0956 DD 74 06      [19]  120 			ld 	Ent_vx_I(ix), h
   0959 DD 75 07      [19]  121 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            122 
   095C                     123 	cant_accelerate_x:
                            124 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            125 
                            126 
                            127 	;; vy = vy + ay
   095C DD 66 08      [19]  128 	ld 	h, Ent_vy_I(ix)
   095F DD 6E 09      [19]  129 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0962 DD 56 0C      [19]  130 	ld 	d, Ent_ay_I(ix)
   0965 DD 5E 0D      [19]  131 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            132 
   0968 19            [11]  133 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   0969 7C            [ 4]  134 	ld 	a, h
   096A FE 03         [ 7]  135 	cp 	#MAX_VEL_Y
   096C F2 7A 09      [10]  136 	jp 	p, cant_accelerate_y
                            137 		;; vy' < MIN_VEL_Y
   096F FE FD         [ 7]  138 		cp 	#MIN_VEL_Y
   0971 FA 7A 09      [10]  139 		jp 	m, cant_accelerate_y
                            140 			;; vy' > MIN_VEL_Y
                            141 			;; Can accelerate at Y axis
   0974 DD 74 08      [19]  142 			ld 	Ent_vy_I(ix), h
   0977 DD 75 09      [19]  143 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            144 
   097A                     145 	cant_accelerate_y:
                            146 
                            147 	;; Apply deceleration X axis
   097A DD 7E 06      [19]  148 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   097D FE 00         [ 7]  149 	cp 	#0
   097F 28 37         [12]  150 	jr	z, check_ax
                            151 
   0981                     152 	check_vx:
   0981 DD 7E 06      [19]  153 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0984 FE 00         [ 7]  154 		cp 	#0
   0986 FA 9F 09      [10]  155 		jp	m, vx_negative
                            156 			;; vx positive
                            157 
   0989 DD 66 0E      [19]  158 			ld 	h, Ent_N_I(ix)
   098C DD 6E 0F      [19]  159 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            160 
   098F CD 14 0B      [17]  161 			call 	negateHL		;; HL <= -ent_N
                            162 
   0992 54            [ 4]  163 			ld 	d, h
   0993 5D            [ 4]  164 			ld 	e, l			;; DE <= -ent_N
                            165 
   0994 DD 66 06      [19]  166 			ld 	h, Ent_vx_I(ix)
   0997 DD 6E 07      [19]  167 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            168 
   099A 19            [11]  169 			add 	hl, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   099B 38 13         [12]  170 			jr	c, can_decelerate_x
                            171 
   099D 18 36         [12]  172 			jr cant_decelerate_x
                            173 
   099F                     174 		vx_negative:
   099F 28 34         [12]  175 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            176 
   09A1 DD 66 06      [19]  177 			ld 	h, Ent_vx_I(ix)
   09A4 DD 6E 07      [19]  178 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   09A7 DD 56 0E      [19]  179 			ld 	d, Ent_N_I(ix)
   09AA DD 5E 0F      [19]  180 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            181 
   09AD 19            [11]  182 			add 	hl, de
   09AE 38 00         [12]  183 			jr	c, can_decelerate_x
                            184 
   09B0                     185 			can_decelerate_x:
   09B0 DD 74 06      [19]  186 				ld 	Ent_vx_I(ix), h
   09B3 DD 75 07      [19]  187 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            188 
   09B6 18 1D         [12]  189 				jr cant_decelerate_x
   09B8                     190 	check_ax:
   09B8 DD 7E 0A      [19]  191 		ld	a, Ent_ax_I(ix)
   09BB FE 00         [ 7]  192 		cp 	#0
   09BD 20 C2         [12]  193 		jr	nz, check_vx
   09BF DD 7E 0B      [19]  194 		ld	a, Ent_ax_F(ix)
   09C2 FE 00         [ 7]  195 		cp 	#0
   09C4 20 BB         [12]  196 		jr	nz, check_vx
                            197 			;; vx_I == 0 && ax == 0
   09C6 DD 7E 16      [19]  198 			ld	a, Ent_id(ix)
   09C9 FE 00         [ 7]  199 			cp	#0
   09CB 28 08         [12]  200 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            201 
   09CD DD 36 06 00   [19]  202 			ld	Ent_vx_I(ix), #0
   09D1 DD 36 07 00   [19]  203 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            204 
                            205 
   09D5                     206 	cant_decelerate_x:
                            207 
                            208 	;; Apply deceleration Y axis
   09D5 DD 7E 08      [19]  209 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   09D8 FE 00         [ 7]  210 	cp 	#0
   09DA 28 35         [12]  211 	jr	z, check_ay
                            212 
   09DC                     213 	check_vy:
   09DC DD 7E 08      [19]  214 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   09DF FE 00         [ 7]  215 		cp 	#0
   09E1 FA FA 09      [10]  216 		jp	m, vy_negative
                            217 
                            218 			;; vy positive
   09E4 DD 66 0E      [19]  219 			ld 	h, Ent_N_I(ix)
   09E7 DD 6E 0F      [19]  220 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            221 
   09EA CD 14 0B      [17]  222 			call 	negateHL		;; HL <= -ent_N
                            223 
   09ED 54            [ 4]  224 			ld 	d, h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   09EE 5D            [ 4]  225 			ld 	e, l			;; DE <= -ent_N
                            226 
   09EF DD 66 08      [19]  227 			ld 	h, Ent_vy_I(ix)
   09F2 DD 6E 09      [19]  228 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            229 
   09F5 19            [11]  230 			add 	hl, de
   09F6 38 11         [12]  231 			jr	c, can_decelerate_y
                            232 
   09F8 18 34         [12]  233 			jr cant_decelerate_y
                            234 
   09FA                     235 		vy_negative:
   09FA DD 66 08      [19]  236 			ld 	h, Ent_vy_I(ix)
   09FD DD 6E 09      [19]  237 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0A00 DD 56 0E      [19]  238 			ld 	d, Ent_N_I(ix)
   0A03 DD 5E 0F      [19]  239 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            240 
   0A06 19            [11]  241 			add 	hl, de
   0A07 38 00         [12]  242 			jr	c, can_decelerate_y
                            243 
   0A09                     244 			can_decelerate_y:
   0A09 DD 74 08      [19]  245 				ld 	Ent_vy_I(ix), h
   0A0C DD 75 09      [19]  246 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            247 
                            248 
   0A0F 18 1D         [12]  249 				jr cant_decelerate_y
   0A11                     250 	check_ay:
   0A11 DD 7E 0C      [19]  251 		ld	a, Ent_ay_I(ix)
   0A14 FE 00         [ 7]  252 		cp 	#0
   0A16 20 C4         [12]  253 		jr	nz, check_vy
   0A18 DD 7E 0D      [19]  254 		ld	a, Ent_ay_F(ix)
   0A1B FE 00         [ 7]  255 		cp 	#0
   0A1D 20 BD         [12]  256 		jr	nz, check_vy
                            257 			;; vy_I == 0 && ay == 0
   0A1F DD 7E 16      [19]  258 			ld	a, Ent_id(ix)
   0A22 FE 00         [ 7]  259 			cp	#0
   0A24 28 08         [12]  260 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            261 			
   0A26 DD 36 08 00   [19]  262 			ld	Ent_vy_I(ix), #0
   0A2A DD 36 09 00   [19]  263 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            264 
   0A2E                     265 	cant_decelerate_y:
                            266 
   0A2E DD 36 0A 00   [19]  267 	ld 	Ent_ax_I(ix), #0	;; 
   0A32 DD 36 0B 00   [19]  268 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   0A36 DD 36 0C 00   [19]  269 	ld 	Ent_ay_I(ix), #0	;; 
   0A3A DD 36 0D 00   [19]  270 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            271 
   0A3E C9            [10]  272 	ret
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
   0A3F 00 00               286 ent1_ptr: .dw #0000
   0A41 00 00               287 ent2_ptr: .dw #0000
   0A43                     288 entityCheckCollision::
                            289 	;;
                            290 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            291 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            292 	;;
   0A43 DD 22 3F 0A   [20]  293 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   0A47 22 41 0A      [16]  294 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            295 
   0A4A DD 7E 00      [19]  296 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0A4D DD 86 05      [19]  297 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0A50 DD 2A 41 0A   [20]  298 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0A54 DD 96 00      [19]  299 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   0A57 F2 5C 0A      [10]  300 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            301 
   0A5A 18 39         [12]  302 	jr 	no_collision
                            303 
                            304 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0A5C                     305 	collision_XR:
                            306 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0A5C 47            [ 4]  307 		ld 	b, a 		;; B <= A
                            308 		;;
                            309 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            310 		;; ent2_x + ent2_w - ent1_x <= 0
                            311 		;; 
   0A5D DD 7E 00      [19]  312 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0A60 DD 86 05      [19]  313 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   0A63 DD 2A 3F 0A   [20]  314 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0A67 DD 96 00      [19]  315 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   0A6A F2 6F 0A      [10]  316 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            317 
   0A6D 18 26         [12]  318 		jr 	no_collision
                            319 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   0A6F                     320 	collision_XL:
                            321 		;;
                            322 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            323 		;; ent1_y + ent1_h - ent2_y <= 0
                            324 		;;
   0A6F DD 7E 02      [19]  325 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   0A72 DD 86 04      [19]  326 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0A75 DD 2A 41 0A   [20]  327 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0A79 DD 96 02      [19]  328 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0A7C F2 81 0A      [10]  329 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            330 
   0A7F 18 14         [12]  331 		jr 	no_collision
                            332 
                            333 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0A81                     334 	collision_YB:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 		;;
                            336 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            337 		;; ent2_y + ent2_h - ent1_y <= 0
                            338 		;; 
   0A81 DD 7E 02      [19]  339 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0A84 DD 86 04      [19]  340 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   0A87 DD 2A 3F 0A   [20]  341 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0A8B DD 96 02      [19]  342 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   0A8E F2 93 0A      [10]  343 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            344 
   0A91 18 02         [12]  345 		jr 	no_collision
                            346 
                            347 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   0A93                     348 	collision_YT:
                            349 
                            350 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0A93 78            [ 4]  351 	ld 	a, b
                            352 
   0A94 C9            [10]  353 	ret
                            354 
   0A95                     355 	no_collision:
   0A95 3E 00         [ 7]  356 	ld 	a, #0 	;; A == 0 si no hay colisión
   0A97 C9            [10]  357 	ret
                            358 
                            359 
                            360 ;; =========================================
                            361 ;; Actualiza la posición de la entidad
                            362 ;; Entrada:
                            363 ;; 	IX => Pointer to entity data
                            364 ;; Modifica AF, B, DE, HL, IX
                            365 ;; =========================================
   0A98                     366 entityUpdatePosition::
                            367 
                            368 	;; x' = x + vx_I
   0A98 DD 56 06      [19]  369 	ld 	d, Ent_vx_I(ix) 	
   0A9B DD 5E 07      [19]  370 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            371 
   0A9E DD 66 00      [19]  372 	ld 	h, Ent_x_I(ix) 		;; 
   0AA1 DD 6E 01      [19]  373 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            374 
   0AA4 19            [11]  375 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            376 
   0AA5 7C            [ 4]  377 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   0AA6 FE 00         [ 7]  378 	cp 	#LEFT_LIMIT
   0AA8 FA B9 0A      [10]  379 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            380 		;; can move left
   0AAB DD 86 05      [19]  381 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   0AAE 47            [ 4]  382 		ld	b, a
   0AAF 3E 50         [ 7]  383 		ld 	a, #RIGHT_LIMIT
   0AB1 B8            [ 4]  384 		cp	b
   0AB2 38 0E         [12]  385 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            386 			;; can move
   0AB4 CD 1D 0B      [17]  387 			call setX 		;; Ent_x <= HL (x + vx)
                            388 
   0AB7 18 14         [12]  389 			jr check_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 
   0AB9                     391 	check_left:
   0AB9 26 00         [ 7]  392 		ld 	h, #LEFT_LIMIT
   0ABB 2E 00         [ 7]  393 		ld 	l, #0
   0ABD CD 1D 0B      [17]  394 		call	setX 			;; Ent_x <= LEFT_LIMIT
   0AC0 18 0B         [12]  395 			jr check_y
                            396 
   0AC2                     397 	check_right:
   0AC2 3E 50         [ 7]  398 		ld 	a, #RIGHT_LIMIT
   0AC4 DD 96 05      [19]  399 		sub	a, Ent_w(ix)
   0AC7 67            [ 4]  400 		ld 	h, a
   0AC8 2E 00         [ 7]  401 		ld 	l, #0
   0ACA CD 1D 0B      [17]  402 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            403 
   0ACD                     404 	check_y:
                            405 	;; y' = y + vy_I*2
   0ACD DD 56 08      [19]  406 	ld 	d, Ent_vy_I(ix) 	
   0AD0 DD 5E 09      [19]  407 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            408 
   0AD3 DD 66 02      [19]  409 	ld 	h, Ent_y_I(ix) 		;; 
   0AD6 DD 6E 03      [19]  410 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            411 
   0AD9 19            [11]  412 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0ADA 19            [11]  413 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            414 
   0ADB 7C            [ 4]  415 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   0ADC FE 0A         [ 7]  416 	cp 	#TOP_LIMIT
   0ADE DA F0 0A      [10]  417 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            418 		;; can move up
   0AE1 7C            [ 4]  419 		ld 	a, h
   0AE2 DD 86 04      [19]  420 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   0AE5 47            [ 4]  421 		ld	b, a
   0AE6 3E C8         [ 7]  422 		ld 	a, #BOTTOM_LIMIT
   0AE8 B8            [ 4]  423 		cp	b
   0AE9 DA F9 0A      [10]  424 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            425 			;; can move
   0AEC CD 31 0B      [17]  426 			call 	setY			;; Ent_y <= HL (y + vy)
                            427 
   0AEF C9            [10]  428 			ret
                            429 
                            430 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            431 
   0AF0                     432 	check_top:
   0AF0 26 0A         [ 7]  433 		ld 	h, #TOP_LIMIT
   0AF2 2E 00         [ 7]  434 		ld 	l, #0
   0AF4 CD 31 0B      [17]  435 		call 	setY				;; Ent_y <= TOP_LIMIT
   0AF7 18 0B         [12]  436 		jr bounce
                            437 
   0AF9                     438 	check_bot:
   0AF9 3E C8         [ 7]  439 		ld 	a, #BOTTOM_LIMIT
   0AFB DD 96 04      [19]  440 		sub	a, Ent_h(ix)
   0AFE 67            [ 4]  441 		ld 	h, a
   0AFF 2E 00         [ 7]  442 		ld 	l, #0
   0B01 CD 31 0B      [17]  443 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            444 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0B04                     445 	bounce:
   0B04 DD 66 08      [19]  446 			ld 	h, Ent_vy_I(ix)
   0B07 DD 6E 09      [19]  447 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            448 
   0B0A CD 14 0B      [17]  449 			call 	negateHL
                            450 
   0B0D DD 74 08      [19]  451 			ld 	Ent_vy_I(ix), h
   0B10 DD 75 09      [19]  452 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            453 
   0B13 C9            [10]  454 		ret
                            455 
                            456 ;; =========================================
                            457 ;; Inverts HL value
                            458 ;; Entrada:
                            459 ;; 	HL => value we are going to negate
                            460 ;; Modifica AF, HL
                            461 ;; Devuelve:
                            462 ;; 	HL <= HL value negated
                            463 ;; =========================================
   0B14                     464 negateHL::
   0B14 3E 00         [ 7]  465 	ld 	a, #0			;;
   0B16 AF            [ 4]  466 	xor	a			;;
   0B17 95            [ 4]  467 	sub	l			;;
   0B18 6F            [ 4]  468 	ld	l,a			;;
   0B19 9F            [ 4]  469 	sbc	a,a			;;
   0B1A 94            [ 4]  470 	sub	h			;;
   0B1B 67            [ 4]  471 	ld	h,a			;; negate HL
                            472 
   0B1C C9            [10]  473 	ret
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
   0B1D                     491 setX:
   0B1D DD 74 00      [19]  492 	ld	Ent_x_I(ix), h
   0B20 DD 75 01      [19]  493 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            494 
   0B23 C9            [10]  495 	ret
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
   0B24                     505 updateX:
   0B24 DD 7E 10      [19]  506 	ld	a, Ent_last_x(ix)
   0B27 DD 77 11      [19]  507 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            508 
   0B2A DD 7E 00      [19]  509 	ld	a, Ent_x_I(ix)
   0B2D DD 77 10      [19]  510 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   0B30 C9            [10]  511 	ret
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
   0B31                     522 setY:
                            523 
   0B31 DD 74 02      [19]  524 	ld	Ent_y_I(ix), h
   0B34 DD 75 03      [19]  525 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            526 
   0B37 C9            [10]  527 	ret
                            528 
                            529 
                            530 ;; =========================================
                            531 ;; Modifica las de últimas posiciones Y
                            532 ;	de la entidad
                            533 ;; Entrada:
                            534 ;; 	IX => Pointer to entity data
                            535 ;; Modifica AF
                            536 ;; =========================================
   0B38                     537 updateY:
   0B38 DD 7E 12      [19]  538 	ld	a, Ent_last_y(ix)
   0B3B DD 77 13      [19]  539 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            540 
   0B3E DD 7E 02      [19]  541 	ld	a, Ent_y_I(ix)
   0B41 DD 77 12      [19]  542 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   0B44 C9            [10]  543 	ret
