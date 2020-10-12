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
   08E7                      58 entityDraw::
   08E7 CD 46 0B      [17]   59 	call 	getVideoPtr			;; HL <= Video memory pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   08EA EB            [ 4]   60 	ex 	de, hl					;; DE <= HL (Video memory pointer)
   08EB DD 4E 00      [19]   61 	ld 	c, Ent_x_I(ix) 			;; C = ent_x_I
   08EE DD 46 02      [19]   62 	ld 	b, Ent_y_I(ix) 			;; B = ent_y_I
   08F1 CD 0C 19      [17]   63 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             64 
   08F4 EB            [ 4]   65 	ex 	de, hl 					;; DE = ent screen pointer
   08F5 DD 46 04      [19]   66 	ld 	b, Ent_h(ix) 			;; B = ent height
   08F8 DD 4E 05      [19]   67 	ld 	c, Ent_w(ix) 			;; C = ent width
   08FB DD 7E 15      [19]   68 	ld 	a, Ent_clr(ix)			;; A = ent colour
   08FE CD 67 18      [17]   69 	call cpct_drawSolidBox_asm
                             70 
   0901 CD 08 0B      [17]   71 	call updateX
   0904 CD 1C 0B      [17]   72 	call updateY
   0907 C9            [10]   73 	ret
                             74 
                             75 ;; ===================================
                             76 ;; Borra una entidad de la pantalla
                             77 ;; Entrada:
                             78 ;; 	IX => Pointer to entity data 
                             79 ;; Modifica AF, BC, DE, HL
                             80 ;; ===================================
   0908                      81 entityErase::
   0908 CD 46 0B      [17]   82 	call 	getVideoPtr		;; HL <= Video memory pointer
   090B EB            [ 4]   83 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   090C DD 4E 11      [19]   84 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   090F DD 46 13      [19]   85 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   0912 CD 0C 19      [17]   86 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             87 
   0915 EB            [ 4]   88 	ex 	de, hl 			;; DE = ent screen pointer
   0916 3E 00         [ 7]   89 	ld 	a, #0x00 		;; A = background color
   0918 DD 46 04      [19]   90 	ld 	b, Ent_h(ix) 		;; B = ent height
   091B DD 4E 05      [19]   91 	ld 	c, Ent_w(ix) 		;; C = ent width
   091E CD 67 18      [17]   92 	call cpct_drawSolidBox_asm
                             93 
   0921 C9            [10]   94 	ret
                             95 
                             96 ;; =========================================
                             97 ;; Actualiza el estado de las físicas
                             98 ;; 	de una entidad
                             99 ;; Entrada:
                            100 ;; 	IX => Pointer to entity data
                            101 ;; Modifica F, DE, HL
                            102 ;; =========================================
   0922                     103 entityUpdatePhysics::
                            104 	;; vx' = vx + ax
   0922 DD 66 06      [19]  105 	ld 	h, Ent_vx_I(ix)
   0925 DD 6E 07      [19]  106 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0928 DD 56 0A      [19]  107 	ld 	d, Ent_ax_I(ix)
   092B DD 5E 0B      [19]  108 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            109 
   092E 19            [11]  110 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            111 
   092F 7C            [ 4]  112 	ld 	a, h
   0930 FE 03         [ 7]  113 	cp 	#MAX_VEL_X
   0932 F2 40 09      [10]  114 	jp 	p, cant_accelerate_x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 		;; vx' < MAX_VEL_X
   0935 FE FD         [ 7]  116 		cp 	#MIN_VEL_X
   0937 FA 40 09      [10]  117 		jp 	m, cant_accelerate_x
                            118 			;; vx' > MIN_VEL_X
                            119 			;; Can accelerate at X axis
   093A DD 74 06      [19]  120 			ld 	Ent_vx_I(ix), h
   093D DD 75 07      [19]  121 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            122 
   0940                     123 	cant_accelerate_x:
                            124 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            125 
                            126 
                            127 	;; vy = vy + ay
   0940 DD 66 08      [19]  128 	ld 	h, Ent_vy_I(ix)
   0943 DD 6E 09      [19]  129 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0946 DD 56 0C      [19]  130 	ld 	d, Ent_ay_I(ix)
   0949 DD 5E 0D      [19]  131 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            132 
   094C 19            [11]  133 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   094D 7C            [ 4]  134 	ld 	a, h
   094E FE 03         [ 7]  135 	cp 	#MAX_VEL_Y
   0950 F2 5E 09      [10]  136 	jp 	p, cant_accelerate_y
                            137 		;; vy' < MIN_VEL_Y
   0953 FE FD         [ 7]  138 		cp 	#MIN_VEL_Y
   0955 FA 5E 09      [10]  139 		jp 	m, cant_accelerate_y
                            140 			;; vy' > MIN_VEL_Y
                            141 			;; Can accelerate at Y axis
   0958 DD 74 08      [19]  142 			ld 	Ent_vy_I(ix), h
   095B DD 75 09      [19]  143 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            144 
   095E                     145 	cant_accelerate_y:
                            146 
                            147 	;; Apply deceleration X axis
   095E DD 7E 06      [19]  148 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0961 FE 00         [ 7]  149 	cp 	#0
   0963 28 37         [12]  150 	jr	z, check_ax
                            151 
   0965                     152 	check_vx:
   0965 DD 7E 06      [19]  153 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0968 FE 00         [ 7]  154 		cp 	#0
   096A FA 83 09      [10]  155 		jp	m, vx_negative
                            156 			;; vx positive
                            157 
   096D DD 66 0E      [19]  158 			ld 	h, Ent_N_I(ix)
   0970 DD 6E 0F      [19]  159 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            160 
   0973 CD F8 0A      [17]  161 			call 	negateHL		;; HL <= -ent_N
                            162 
   0976 54            [ 4]  163 			ld 	d, h
   0977 5D            [ 4]  164 			ld 	e, l			;; DE <= -ent_N
                            165 
   0978 DD 66 06      [19]  166 			ld 	h, Ent_vx_I(ix)
   097B DD 6E 07      [19]  167 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            168 
   097E 19            [11]  169 			add 	hl, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   097F 38 13         [12]  170 			jr	c, can_decelerate_x
                            171 
   0981 18 36         [12]  172 			jr cant_decelerate_x
                            173 
   0983                     174 		vx_negative:
   0983 28 34         [12]  175 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            176 
   0985 DD 66 06      [19]  177 			ld 	h, Ent_vx_I(ix)
   0988 DD 6E 07      [19]  178 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   098B DD 56 0E      [19]  179 			ld 	d, Ent_N_I(ix)
   098E DD 5E 0F      [19]  180 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            181 
   0991 19            [11]  182 			add 	hl, de
   0992 38 00         [12]  183 			jr	c, can_decelerate_x
                            184 
   0994                     185 			can_decelerate_x:
   0994 DD 74 06      [19]  186 				ld 	Ent_vx_I(ix), h
   0997 DD 75 07      [19]  187 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            188 
   099A 18 1D         [12]  189 				jr cant_decelerate_x
   099C                     190 	check_ax:
   099C DD 7E 0A      [19]  191 		ld	a, Ent_ax_I(ix)
   099F FE 00         [ 7]  192 		cp 	#0
   09A1 20 C2         [12]  193 		jr	nz, check_vx
   09A3 DD 7E 0B      [19]  194 		ld	a, Ent_ax_F(ix)
   09A6 FE 00         [ 7]  195 		cp 	#0
   09A8 20 BB         [12]  196 		jr	nz, check_vx
                            197 			;; vx_I == 0 && ax == 0
   09AA DD 7E 16      [19]  198 			ld	a, Ent_id(ix)
   09AD FE 00         [ 7]  199 			cp	#0
   09AF 28 08         [12]  200 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            201 
   09B1 DD 36 06 00   [19]  202 			ld	Ent_vx_I(ix), #0
   09B5 DD 36 07 00   [19]  203 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            204 
                            205 
   09B9                     206 	cant_decelerate_x:
                            207 
                            208 	;; Apply deceleration Y axis
   09B9 DD 7E 08      [19]  209 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   09BC FE 00         [ 7]  210 	cp 	#0
   09BE 28 35         [12]  211 	jr	z, check_ay
                            212 
   09C0                     213 	check_vy:
   09C0 DD 7E 08      [19]  214 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   09C3 FE 00         [ 7]  215 		cp 	#0
   09C5 FA DE 09      [10]  216 		jp	m, vy_negative
                            217 
                            218 			;; vy positive
   09C8 DD 66 0E      [19]  219 			ld 	h, Ent_N_I(ix)
   09CB DD 6E 0F      [19]  220 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            221 
   09CE CD F8 0A      [17]  222 			call 	negateHL		;; HL <= -ent_N
                            223 
   09D1 54            [ 4]  224 			ld 	d, h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   09D2 5D            [ 4]  225 			ld 	e, l			;; DE <= -ent_N
                            226 
   09D3 DD 66 08      [19]  227 			ld 	h, Ent_vy_I(ix)
   09D6 DD 6E 09      [19]  228 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            229 
   09D9 19            [11]  230 			add 	hl, de
   09DA 38 11         [12]  231 			jr	c, can_decelerate_y
                            232 
   09DC 18 34         [12]  233 			jr cant_decelerate_y
                            234 
   09DE                     235 		vy_negative:
   09DE DD 66 08      [19]  236 			ld 	h, Ent_vy_I(ix)
   09E1 DD 6E 09      [19]  237 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   09E4 DD 56 0E      [19]  238 			ld 	d, Ent_N_I(ix)
   09E7 DD 5E 0F      [19]  239 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            240 
   09EA 19            [11]  241 			add 	hl, de
   09EB 38 00         [12]  242 			jr	c, can_decelerate_y
                            243 
   09ED                     244 			can_decelerate_y:
   09ED DD 74 08      [19]  245 				ld 	Ent_vy_I(ix), h
   09F0 DD 75 09      [19]  246 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            247 
                            248 
   09F3 18 1D         [12]  249 				jr cant_decelerate_y
   09F5                     250 	check_ay:
   09F5 DD 7E 0C      [19]  251 		ld	a, Ent_ay_I(ix)
   09F8 FE 00         [ 7]  252 		cp 	#0
   09FA 20 C4         [12]  253 		jr	nz, check_vy
   09FC DD 7E 0D      [19]  254 		ld	a, Ent_ay_F(ix)
   09FF FE 00         [ 7]  255 		cp 	#0
   0A01 20 BD         [12]  256 		jr	nz, check_vy
                            257 			;; vy_I == 0 && ay == 0
   0A03 DD 7E 16      [19]  258 			ld	a, Ent_id(ix)
   0A06 FE 00         [ 7]  259 			cp	#0
   0A08 28 08         [12]  260 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            261 			
   0A0A DD 36 08 00   [19]  262 			ld	Ent_vy_I(ix), #0
   0A0E DD 36 09 00   [19]  263 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            264 
   0A12                     265 	cant_decelerate_y:
                            266 
   0A12 DD 36 0A 00   [19]  267 	ld 	Ent_ax_I(ix), #0	;; 
   0A16 DD 36 0B 00   [19]  268 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   0A1A DD 36 0C 00   [19]  269 	ld 	Ent_ay_I(ix), #0	;; 
   0A1E DD 36 0D 00   [19]  270 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            271 
   0A22 C9            [10]  272 	ret
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
   0A23 00 00               286 ent1_ptr: .dw #0000
   0A25 00 00               287 ent2_ptr: .dw #0000
   0A27                     288 entityCheckCollision::
                            289 	;;
                            290 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            291 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            292 	;;
   0A27 DD 22 23 0A   [20]  293 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   0A2B 22 25 0A      [16]  294 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            295 
   0A2E DD 7E 00      [19]  296 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0A31 DD 86 05      [19]  297 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0A34 DD 2A 25 0A   [20]  298 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0A38 DD 96 00      [19]  299 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   0A3B F2 40 0A      [10]  300 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            301 
   0A3E 18 39         [12]  302 	jr 	no_collision
                            303 
                            304 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0A40                     305 	collision_XR:
                            306 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0A40 47            [ 4]  307 		ld 	b, a 		;; B <= A
                            308 		;;
                            309 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            310 		;; ent2_x + ent2_w - ent1_x <= 0
                            311 		;; 
   0A41 DD 7E 00      [19]  312 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0A44 DD 86 05      [19]  313 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   0A47 DD 2A 23 0A   [20]  314 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0A4B DD 96 00      [19]  315 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   0A4E F2 53 0A      [10]  316 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            317 
   0A51 18 26         [12]  318 		jr 	no_collision
                            319 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   0A53                     320 	collision_XL:
                            321 		;;
                            322 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            323 		;; ent1_y + ent1_h - ent2_y <= 0
                            324 		;;
   0A53 DD 7E 02      [19]  325 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   0A56 DD 86 04      [19]  326 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0A59 DD 2A 25 0A   [20]  327 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0A5D DD 96 02      [19]  328 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0A60 F2 65 0A      [10]  329 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            330 
   0A63 18 14         [12]  331 		jr 	no_collision
                            332 
                            333 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0A65                     334 	collision_YB:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 		;;
                            336 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            337 		;; ent2_y + ent2_h - ent1_y <= 0
                            338 		;; 
   0A65 DD 7E 02      [19]  339 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0A68 DD 86 04      [19]  340 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   0A6B DD 2A 23 0A   [20]  341 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0A6F DD 96 02      [19]  342 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   0A72 F2 77 0A      [10]  343 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            344 
   0A75 18 02         [12]  345 		jr 	no_collision
                            346 
                            347 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   0A77                     348 	collision_YT:
                            349 
                            350 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0A77 78            [ 4]  351 	ld 	a, b
                            352 
   0A78 C9            [10]  353 	ret
                            354 
   0A79                     355 	no_collision:
   0A79 3E 00         [ 7]  356 	ld 	a, #0 	;; A == 0 si no hay colisión
   0A7B C9            [10]  357 	ret
                            358 
                            359 
                            360 ;; =========================================
                            361 ;; Actualiza la posición de la entidad
                            362 ;; Entrada:
                            363 ;; 	IX => Pointer to entity data
                            364 ;; Modifica AF, B, DE, HL, IX
                            365 ;; =========================================
   0A7C                     366 entityUpdatePosition::
                            367 
                            368 	;; x' = x + vx_I
   0A7C DD 56 06      [19]  369 	ld 	d, Ent_vx_I(ix) 	
   0A7F DD 5E 07      [19]  370 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            371 
   0A82 DD 66 00      [19]  372 	ld 	h, Ent_x_I(ix) 		;; 
   0A85 DD 6E 01      [19]  373 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            374 
   0A88 19            [11]  375 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            376 
   0A89 7C            [ 4]  377 	ld 	a, h 				;; A <= H (x_I + vx_I) integer part
   0A8A FE 00         [ 7]  378 	cp 	#LEFT_LIMIT
   0A8C FA 9D 0A      [10]  379 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            380 		;; can move left
   0A8F DD 86 05      [19]  381 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   0A92 47            [ 4]  382 		ld	b, a
   0A93 3E 50         [ 7]  383 		ld 	a, #RIGHT_LIMIT
   0A95 B8            [ 4]  384 		cp	b
   0A96 38 0E         [12]  385 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            386 			;; can move
   0A98 CD 01 0B      [17]  387 			call setX 		;; Ent_x <= HL (x + vx)
                            388 
   0A9B 18 14         [12]  389 			jr check_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 
   0A9D                     391 	check_left:
   0A9D 26 00         [ 7]  392 		ld 	h, #LEFT_LIMIT
   0A9F 2E 00         [ 7]  393 		ld 	l, #0
   0AA1 CD 01 0B      [17]  394 		call	setX 			;; Ent_x <= LEFT_LIMIT
   0AA4 18 0B         [12]  395 			jr check_y
                            396 
   0AA6                     397 	check_right:
   0AA6 3E 50         [ 7]  398 		ld 	a, #RIGHT_LIMIT
   0AA8 DD 96 05      [19]  399 		sub	a, Ent_w(ix)
   0AAB 67            [ 4]  400 		ld 	h, a
   0AAC 2E 00         [ 7]  401 		ld 	l, #0
   0AAE CD 01 0B      [17]  402 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            403 
   0AB1                     404 	check_y:
                            405 	;; y' = y + vy_I*2
   0AB1 DD 56 08      [19]  406 	ld 	d, Ent_vy_I(ix) 	
   0AB4 DD 5E 09      [19]  407 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            408 
   0AB7 DD 66 02      [19]  409 	ld 	h, Ent_y_I(ix) 		;; 
   0ABA DD 6E 03      [19]  410 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            411 
   0ABD 19            [11]  412 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0ABE 19            [11]  413 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            414 
   0ABF 7C            [ 4]  415 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   0AC0 FE 0A         [ 7]  416 	cp 	#TOP_LIMIT
   0AC2 DA D4 0A      [10]  417 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            418 		;; can move up
   0AC5 7C            [ 4]  419 		ld 	a, h
   0AC6 DD 86 04      [19]  420 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   0AC9 47            [ 4]  421 		ld	b, a
   0ACA 3E C8         [ 7]  422 		ld 	a, #BOTTOM_LIMIT
   0ACC B8            [ 4]  423 		cp	b
   0ACD DA DD 0A      [10]  424 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            425 			;; can move
   0AD0 CD 15 0B      [17]  426 			call 	setY			;; Ent_y <= HL (y + vy)
                            427 
   0AD3 C9            [10]  428 			ret
                            429 
                            430 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            431 
   0AD4                     432 	check_top:
   0AD4 26 0A         [ 7]  433 		ld 	h, #TOP_LIMIT
   0AD6 2E 00         [ 7]  434 		ld 	l, #0
   0AD8 CD 15 0B      [17]  435 		call 	setY				;; Ent_y <= TOP_LIMIT
   0ADB 18 0B         [12]  436 		jr bounce
                            437 
   0ADD                     438 	check_bot:
   0ADD 3E C8         [ 7]  439 		ld 	a, #BOTTOM_LIMIT
   0ADF DD 96 04      [19]  440 		sub	a, Ent_h(ix)
   0AE2 67            [ 4]  441 		ld 	h, a
   0AE3 2E 00         [ 7]  442 		ld 	l, #0
   0AE5 CD 15 0B      [17]  443 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            444 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0AE8                     445 	bounce:
   0AE8 DD 66 08      [19]  446 			ld 	h, Ent_vy_I(ix)
   0AEB DD 6E 09      [19]  447 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            448 
   0AEE CD F8 0A      [17]  449 			call 	negateHL
                            450 
   0AF1 DD 74 08      [19]  451 			ld 	Ent_vy_I(ix), h
   0AF4 DD 75 09      [19]  452 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            453 
   0AF7 C9            [10]  454 		ret
                            455 
                            456 ;; =========================================
                            457 ;; Inverts HL value
                            458 ;; Entrada:
                            459 ;; 	HL => value we are going to negate
                            460 ;; Modifica AF, HL
                            461 ;; Devuelve:
                            462 ;; 	HL <= HL value negated
                            463 ;; =========================================
   0AF8                     464 negateHL::
   0AF8 3E 00         [ 7]  465 	ld 	a, #0			;;
   0AFA AF            [ 4]  466 	xor	a			;;
   0AFB 95            [ 4]  467 	sub	l			;;
   0AFC 6F            [ 4]  468 	ld	l,a			;;
   0AFD 9F            [ 4]  469 	sbc	a,a			;;
   0AFE 94            [ 4]  470 	sub	h			;;
   0AFF 67            [ 4]  471 	ld	h,a			;; negate HL
                            472 
   0B00 C9            [10]  473 	ret
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
   0B01                     491 setX:
   0B01 DD 74 00      [19]  492 	ld	Ent_x_I(ix), h
   0B04 DD 75 01      [19]  493 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            494 
   0B07 C9            [10]  495 	ret
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
   0B08                     505 updateX:
   0B08 DD 7E 10      [19]  506 	ld	a, Ent_last_x(ix)
   0B0B DD 77 11      [19]  507 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            508 
   0B0E DD 7E 00      [19]  509 	ld	a, Ent_x_I(ix)
   0B11 DD 77 10      [19]  510 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   0B14 C9            [10]  511 	ret
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
   0B15                     522 setY:
                            523 
   0B15 DD 74 02      [19]  524 	ld	Ent_y_I(ix), h
   0B18 DD 75 03      [19]  525 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            526 
   0B1B C9            [10]  527 	ret
                            528 
                            529 
                            530 ;; =========================================
                            531 ;; Modifica las de últimas posiciones Y
                            532 ;	de la entidad
                            533 ;; Entrada:
                            534 ;; 	IX => Pointer to entity data
                            535 ;; Modifica AF
                            536 ;; =========================================
   0B1C                     537 updateY:
   0B1C DD 7E 12      [19]  538 	ld	a, Ent_last_y(ix)
   0B1F DD 77 13      [19]  539 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            540 
   0B22 DD 7E 02      [19]  541 	ld	a, Ent_y_I(ix)
   0B25 DD 77 12      [19]  542 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   0B28 C9            [10]  543 	ret
