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
                             19 .globl cpct_drawSprite_asm
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
                             10 .globl player_data
                             11 .globl enemy_data
                             12 .globl player_2_data
                             13 .globl enemy_2_data
                             14 .globl play_music	;; alomejor son privados
                             15 .globl stop_music	;; alomejor son privados
                             16 .globl game_data
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; GAME PUBLIC DATA
                             21 ;; ====================================
                             22 ;; ====================================
                     0050    23 .equ RIGHT_LIMIT,	80
                     0000    24 .equ LEFT_LIMIT,	0
                     0014    25 .equ TOP_LIMIT,	 	20
                     00C8    26 .equ BOTTOM_LIMIT,	200
                     0028    27 .equ CENTER_LIMIT,	40
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
                     0015    34 .equ Ent_sprite_H, 	21	;; Pointer to sprite, high part
                     0016    35 .equ Ent_sprite_L, 	22	;; Pointer to sprite, low part
                     0017    36 .equ Ent_id, 		23	;; Numeric ID
                             37 				;; Frisbee 	0
                             38 				;; Player1 	1
                             39 				;; Enemy1	2
                             40 
                     0003    41 .equ MAX_VEL_X, 3 
                     FFFFFFFD    42 .equ MIN_VEL_X, -3
                     0003    43 .equ MAX_VEL_Y, 3
                     FFFFFFFD    44 .equ MIN_VEL_Y, -3
                             45 
                             46 
                             47 ;; ====================================
                             48 ;; ====================================
                             49 ;; PUBLIC FUNCTIONS
                             50 ;; ====================================
                             51 ;; ====================================
                             52 
                             53 ;; ===================================
                             54 ;; Pinta una entidad en pantalla
                             55 ;; Entrada:
                             56 ;; 	IX => Pointer to entity data 
                             57 ;; Modifica AF, BC, DE, HL
                             58 ;; ===================================
   0B21                      59 entityDraw::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0B21 CD 2A 11      [17]   60 	call 	getVideoPtr		;; HL <= Video memory pointer
   0B24 EB            [ 4]   61 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0B25 DD 4E 00      [19]   62 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   0B28 DD 46 02      [19]   63 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   0B2B CD 3A 1C      [17]   64 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             65 
   0B2E EB            [ 4]   66 	ex 	de, hl 			;; DE = ent screen pointer
   0B2F DD 66 16      [19]   67 	ld	h, Ent_sprite_L(ix)	;;
   0B32 DD 6E 15      [19]   68 	ld	l, Ent_sprite_H(ix)	;; HL = sprite pointer
   0B35 DD 46 04      [19]   69 	ld 	b, Ent_h(ix) 		;; B = ent height
   0B38 DD 4E 05      [19]   70 	ld 	c, Ent_w(ix) 		;; C = ent width
   0B3B CD A0 1A      [17]   71 	call cpct_drawSprite_asm
                             72 
   0B3E CD 45 0D      [17]   73 	call updateX
   0B41 CD 59 0D      [17]   74 	call updateY
   0B44 C9            [10]   75 	ret
                             76 
                             77 ;; ===================================
                             78 ;; Borra una entidad de la pantalla
                             79 ;; Entrada:
                             80 ;; 	IX => Pointer to entity data 
                             81 ;; Modifica AF, BC, DE, HL
                             82 ;; ===================================
   0B45                      83 entityErase::
   0B45 CD 2A 11      [17]   84 	call 	getVideoPtr		;; HL <= Video memory pointer
   0B48 EB            [ 4]   85 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   0B49 DD 4E 11      [19]   86 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   0B4C DD 46 13      [19]   87 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   0B4F CD 3A 1C      [17]   88 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             89 
   0B52 EB            [ 4]   90 	ex 	de, hl 			;; DE = ent screen pointer
   0B53 3E 00         [ 7]   91 	ld 	a, #0x00 		;; A = background color
   0B55 DD 46 04      [19]   92 	ld 	b, Ent_h(ix) 		;; B = ent height
   0B58 DD 4E 05      [19]   93 	ld 	c, Ent_w(ix) 		;; C = ent width
   0B5B CD 8D 1B      [17]   94 	call cpct_drawSolidBox_asm
                             95 
   0B5E C9            [10]   96 	ret
                             97 
                             98 ;; =========================================
                             99 ;; Actualiza el estado de las físicas
                            100 ;; 	de una entidad
                            101 ;; Entrada:
                            102 ;; 	IX => Pointer to entity data
                            103 ;; Modifica F, DE, HL
                            104 ;; =========================================
   0B5F                     105 entityUpdatePhysics::
                            106 	;; vx' = vx + ax
   0B5F DD 66 06      [19]  107 	ld 	h, Ent_vx_I(ix)
   0B62 DD 6E 07      [19]  108 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0B65 DD 56 0A      [19]  109 	ld 	d, Ent_ax_I(ix)
   0B68 DD 5E 0B      [19]  110 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            111 
   0B6B 19            [11]  112 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            113 
   0B6C 7C            [ 4]  114 	ld 	a, h
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0B6D FE 03         [ 7]  115 	cp 	#MAX_VEL_X
   0B6F F2 7D 0B      [10]  116 	jp 	p, cant_accelerate_x
                            117 		;; vx' < MAX_VEL_X
   0B72 FE FD         [ 7]  118 		cp 	#MIN_VEL_X
   0B74 FA 7D 0B      [10]  119 		jp 	m, cant_accelerate_x
                            120 			;; vx' > MIN_VEL_X
                            121 			;; Can accelerate at X axis
   0B77 DD 74 06      [19]  122 			ld 	Ent_vx_I(ix), h
   0B7A DD 75 07      [19]  123 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            124 
   0B7D                     125 	cant_accelerate_x:
                            126 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            127 
                            128 
                            129 	;; vy = vy + ay
   0B7D DD 66 08      [19]  130 	ld 	h, Ent_vy_I(ix)
   0B80 DD 6E 09      [19]  131 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0B83 DD 56 0C      [19]  132 	ld 	d, Ent_ay_I(ix)
   0B86 DD 5E 0D      [19]  133 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            134 
   0B89 19            [11]  135 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   0B8A 7C            [ 4]  136 	ld 	a, h
   0B8B FE 03         [ 7]  137 	cp 	#MAX_VEL_Y
   0B8D F2 9B 0B      [10]  138 	jp 	p, cant_accelerate_y
                            139 		;; vy' < MIN_VEL_Y
   0B90 FE FD         [ 7]  140 		cp 	#MIN_VEL_Y
   0B92 FA 9B 0B      [10]  141 		jp 	m, cant_accelerate_y
                            142 			;; vy' > MIN_VEL_Y
                            143 			;; Can accelerate at Y axis
   0B95 DD 74 08      [19]  144 			ld 	Ent_vy_I(ix), h
   0B98 DD 75 09      [19]  145 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            146 
   0B9B                     147 	cant_accelerate_y:
                            148 
                            149 	;; Apply deceleration X axis
   0B9B DD 7E 06      [19]  150 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0B9E FE 00         [ 7]  151 	cp 	#0
   0BA0 28 37         [12]  152 	jr	z, check_ax
                            153 
   0BA2                     154 	check_vx:
   0BA2 DD 7E 06      [19]  155 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   0BA5 FE 00         [ 7]  156 		cp 	#0
   0BA7 FA C0 0B      [10]  157 		jp	m, vx_negative
                            158 			;; vx positive
                            159 
   0BAA DD 66 0E      [19]  160 			ld 	h, Ent_N_I(ix)
   0BAD DD 6E 0F      [19]  161 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            162 
   0BB0 CD 35 0D      [17]  163 			call 	negateHL		;; HL <= -ent_N
                            164 
   0BB3 54            [ 4]  165 			ld 	d, h
   0BB4 5D            [ 4]  166 			ld 	e, l			;; DE <= -ent_N
                            167 
   0BB5 DD 66 06      [19]  168 			ld 	h, Ent_vx_I(ix)
   0BB8 DD 6E 07      [19]  169 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            170 
   0BBB 19            [11]  171 			add 	hl, de
   0BBC 38 13         [12]  172 			jr	c, can_decelerate_x
                            173 
   0BBE 18 36         [12]  174 			jr cant_decelerate_x
                            175 
   0BC0                     176 		vx_negative:
   0BC0 28 34         [12]  177 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            178 
   0BC2 DD 66 06      [19]  179 			ld 	h, Ent_vx_I(ix)
   0BC5 DD 6E 07      [19]  180 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0BC8 DD 56 0E      [19]  181 			ld 	d, Ent_N_I(ix)
   0BCB DD 5E 0F      [19]  182 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            183 
   0BCE 19            [11]  184 			add 	hl, de
   0BCF 38 00         [12]  185 			jr	c, can_decelerate_x
                            186 
   0BD1                     187 			can_decelerate_x:
   0BD1 DD 74 06      [19]  188 				ld 	Ent_vx_I(ix), h
   0BD4 DD 75 07      [19]  189 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            190 
   0BD7 18 1D         [12]  191 				jr cant_decelerate_x
   0BD9                     192 	check_ax:
   0BD9 DD 7E 0A      [19]  193 		ld	a, Ent_ax_I(ix)
   0BDC FE 00         [ 7]  194 		cp 	#0
   0BDE 20 C2         [12]  195 		jr	nz, check_vx
   0BE0 DD 7E 0B      [19]  196 		ld	a, Ent_ax_F(ix)
   0BE3 FE 00         [ 7]  197 		cp 	#0
   0BE5 20 BB         [12]  198 		jr	nz, check_vx
                            199 			;; vx_I == 0 && ax == 0
   0BE7 DD 7E 17      [19]  200 			ld	a, Ent_id(ix)
   0BEA FE 00         [ 7]  201 			cp	#0
   0BEC 28 08         [12]  202 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            203 
   0BEE DD 36 06 00   [19]  204 			ld	Ent_vx_I(ix), #0
   0BF2 DD 36 07 00   [19]  205 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            206 
                            207 
   0BF6                     208 	cant_decelerate_x:
                            209 
                            210 	;; Apply deceleration Y axis
   0BF6 DD 7E 08      [19]  211 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   0BF9 FE 00         [ 7]  212 	cp 	#0
   0BFB 28 35         [12]  213 	jr	z, check_ay
                            214 
   0BFD                     215 	check_vy:
   0BFD DD 7E 08      [19]  216 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   0C00 FE 00         [ 7]  217 		cp 	#0
   0C02 FA 1B 0C      [10]  218 		jp	m, vy_negative
                            219 
                            220 			;; vy positive
   0C05 DD 66 0E      [19]  221 			ld 	h, Ent_N_I(ix)
   0C08 DD 6E 0F      [19]  222 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            223 
   0C0B CD 35 0D      [17]  224 			call 	negateHL		;; HL <= -ent_N
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            225 
   0C0E 54            [ 4]  226 			ld 	d, h
   0C0F 5D            [ 4]  227 			ld 	e, l			;; DE <= -ent_N
                            228 
   0C10 DD 66 08      [19]  229 			ld 	h, Ent_vy_I(ix)
   0C13 DD 6E 09      [19]  230 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            231 
   0C16 19            [11]  232 			add 	hl, de
   0C17 38 11         [12]  233 			jr	c, can_decelerate_y
                            234 
   0C19 18 34         [12]  235 			jr cant_decelerate_y
                            236 
   0C1B                     237 		vy_negative:
   0C1B DD 66 08      [19]  238 			ld 	h, Ent_vy_I(ix)
   0C1E DD 6E 09      [19]  239 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0C21 DD 56 0E      [19]  240 			ld 	d, Ent_N_I(ix)
   0C24 DD 5E 0F      [19]  241 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            242 
   0C27 19            [11]  243 			add 	hl, de
   0C28 38 00         [12]  244 			jr	c, can_decelerate_y
                            245 
   0C2A                     246 			can_decelerate_y:
   0C2A DD 74 08      [19]  247 				ld 	Ent_vy_I(ix), h
   0C2D DD 75 09      [19]  248 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            249 
                            250 
   0C30 18 1D         [12]  251 				jr cant_decelerate_y
   0C32                     252 	check_ay:
   0C32 DD 7E 0C      [19]  253 		ld	a, Ent_ay_I(ix)
   0C35 FE 00         [ 7]  254 		cp 	#0
   0C37 20 C4         [12]  255 		jr	nz, check_vy
   0C39 DD 7E 0D      [19]  256 		ld	a, Ent_ay_F(ix)
   0C3C FE 00         [ 7]  257 		cp 	#0
   0C3E 20 BD         [12]  258 		jr	nz, check_vy
                            259 			;; vy_I == 0 && ay == 0
   0C40 DD 7E 17      [19]  260 			ld	a, Ent_id(ix)
   0C43 FE 00         [ 7]  261 			cp	#0
   0C45 28 08         [12]  262 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            263 			
   0C47 DD 36 08 00   [19]  264 			ld	Ent_vy_I(ix), #0
   0C4B DD 36 09 00   [19]  265 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            266 
   0C4F                     267 	cant_decelerate_y:
                            268 
   0C4F DD 36 0A 00   [19]  269 	ld 	Ent_ax_I(ix), #0	;; 
   0C53 DD 36 0B 00   [19]  270 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   0C57 DD 36 0C 00   [19]  271 	ld 	Ent_ay_I(ix), #0	;; 
   0C5B DD 36 0D 00   [19]  272 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            273 
   0C5F C9            [10]  274 	ret
                            275 
                            276 ;; =========================================
                            277 ;; Comprueba si existe colision entre
                            278 ;; dos entidades.
                            279 ;; Entrada:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            280 ;; 	IX => Pointer to entity 1 data
                            281 ;; 	HL => Pointer to entity 2 data
                            282 ;; Modifica AF, B, HL, IX
                            283 ;; Devuelve:
                            284 ;; 	A <==== 0 si no hay colisión, y la
                            285 ;; 		diferencia absoluta entre
                            286 ;;		las x, en caso de colisión
                            287 ;; =========================================
   0C60 00 00               288 ent1_ptr: .dw #0000
   0C62 00 00               289 ent2_ptr: .dw #0000
   0C64                     290 entityCheckCollision::
                            291 	;;
                            292 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            293 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            294 	;;
   0C64 DD 22 60 0C   [20]  295 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   0C68 22 62 0C      [16]  296 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            297 
   0C6B DD 7E 00      [19]  298 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   0C6E DD 86 05      [19]  299 	add 	Ent_w(ix)		;; A <= A + ent1_w
   0C71 DD 2A 62 0C   [20]  300 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0C75 DD 96 00      [19]  301 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   0C78 F2 7D 0C      [10]  302 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            303 
   0C7B 18 39         [12]  304 	jr 	no_collision
                            305 
                            306 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   0C7D                     307 	collision_XR:
                            308 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   0C7D 47            [ 4]  309 		ld 	b, a 		;; B <= A
                            310 		;;
                            311 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            312 		;; ent2_x + ent2_w - ent1_x <= 0
                            313 		;; 
   0C7E DD 7E 00      [19]  314 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   0C81 DD 86 05      [19]  315 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   0C84 DD 2A 60 0C   [20]  316 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0C88 DD 96 00      [19]  317 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   0C8B F2 90 0C      [10]  318 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            319 
   0C8E 18 26         [12]  320 		jr 	no_collision
                            321 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   0C90                     322 	collision_XL:
                            323 		;;
                            324 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            325 		;; ent1_y + ent1_h - ent2_y <= 0
                            326 		;;
   0C90 DD 7E 02      [19]  327 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   0C93 DD 86 04      [19]  328 		add 	Ent_h(ix)		;; A <= A + ent1_w
   0C96 DD 2A 62 0C   [20]  329 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   0C9A DD 96 02      [19]  330 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   0C9D F2 A2 0C      [10]  331 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            332 
   0CA0 18 14         [12]  333 		jr 	no_collision
                            334 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            335 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   0CA2                     336 	collision_YB:
                            337 		;;
                            338 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            339 		;; ent2_y + ent2_h - ent1_y <= 0
                            340 		;; 
   0CA2 DD 7E 02      [19]  341 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   0CA5 DD 86 04      [19]  342 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   0CA8 DD 2A 60 0C   [20]  343 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   0CAC DD 96 02      [19]  344 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   0CAF F2 B4 0C      [10]  345 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            346 
   0CB2 18 02         [12]  347 		jr 	no_collision
                            348 
                            349 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   0CB4                     350 	collision_YT:
                            351 
                            352 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0CB4 78            [ 4]  353 	ld 	a, b
                            354 
   0CB5 C9            [10]  355 	ret
                            356 
   0CB6                     357 	no_collision:
   0CB6 3E 00         [ 7]  358 	ld 	a, #0 	;; A == 0 si no hay colisión
   0CB8 C9            [10]  359 	ret
                            360 
                            361 
                            362 ;; =========================================
                            363 ;; Actualiza la posición de la entidad
                            364 ;; Entrada:
                            365 ;; 	IX => Pointer to entity data
                            366 ;; Modifica AF, B, DE, HL, IX
                            367 ;; =========================================
   0CB9                     368 entityUpdatePosition::
                            369 
                            370 	;; x' = x + vx_I
   0CB9 DD 56 06      [19]  371 	ld 	d, Ent_vx_I(ix) 	
   0CBC DD 5E 07      [19]  372 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            373 
   0CBF DD 66 00      [19]  374 	ld 	h, Ent_x_I(ix) 		;; 
   0CC2 DD 6E 01      [19]  375 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            376 
   0CC5 19            [11]  377 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            378 
   0CC6 7C            [ 4]  379 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   0CC7 FE 00         [ 7]  380 	cp 	#LEFT_LIMIT
   0CC9 FA DA 0C      [10]  381 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            382 		;; can move left
   0CCC DD 86 05      [19]  383 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   0CCF 47            [ 4]  384 		ld	b, a
   0CD0 3E 50         [ 7]  385 		ld 	a, #RIGHT_LIMIT
   0CD2 B8            [ 4]  386 		cp	b
   0CD3 38 0E         [12]  387 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            388 			;; can move
   0CD5 CD 3E 0D      [17]  389 			call setX 		;; Ent_x <= HL (x + vx)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            390 
   0CD8 18 14         [12]  391 			jr check_y
                            392 
   0CDA                     393 	check_left:
   0CDA 26 00         [ 7]  394 		ld 	h, #LEFT_LIMIT
   0CDC 2E 00         [ 7]  395 		ld 	l, #0
   0CDE CD 3E 0D      [17]  396 		call	setX 			;; Ent_x <= LEFT_LIMIT
   0CE1 18 0B         [12]  397 			jr check_y
                            398 
   0CE3                     399 	check_right:
   0CE3 3E 50         [ 7]  400 		ld 	a, #RIGHT_LIMIT
   0CE5 DD 96 05      [19]  401 		sub	a, Ent_w(ix)
   0CE8 67            [ 4]  402 		ld 	h, a
   0CE9 2E 00         [ 7]  403 		ld 	l, #0
   0CEB CD 3E 0D      [17]  404 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            405 
   0CEE                     406 	check_y:
                            407 	;; y' = y + vy_I*2
   0CEE DD 56 08      [19]  408 	ld 	d, Ent_vy_I(ix) 	
   0CF1 DD 5E 09      [19]  409 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            410 
   0CF4 DD 66 02      [19]  411 	ld 	h, Ent_y_I(ix) 		;; 
   0CF7 DD 6E 03      [19]  412 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            413 
   0CFA 19            [11]  414 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   0CFB 19            [11]  415 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            416 
   0CFC 7C            [ 4]  417 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   0CFD FE 14         [ 7]  418 	cp 	#TOP_LIMIT
   0CFF DA 11 0D      [10]  419 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            420 		;; can move up
   0D02 7C            [ 4]  421 		ld 	a, h
   0D03 DD 86 04      [19]  422 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   0D06 47            [ 4]  423 		ld	b, a
   0D07 3E C8         [ 7]  424 		ld 	a, #BOTTOM_LIMIT
   0D09 B8            [ 4]  425 		cp	b
   0D0A DA 1A 0D      [10]  426 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            427 			;; can move
   0D0D CD 52 0D      [17]  428 			call 	setY			;; Ent_y <= HL (y + vy)
                            429 
   0D10 C9            [10]  430 			ret
                            431 
                            432 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            433 
   0D11                     434 	check_top:
   0D11 26 14         [ 7]  435 		ld 	h, #TOP_LIMIT
   0D13 2E 00         [ 7]  436 		ld 	l, #0
   0D15 CD 52 0D      [17]  437 		call 	setY				;; Ent_y <= TOP_LIMIT
   0D18 18 0B         [12]  438 		jr bounce
                            439 
   0D1A                     440 	check_bot:
   0D1A 3E C8         [ 7]  441 		ld 	a, #BOTTOM_LIMIT
   0D1C DD 96 04      [19]  442 		sub	a, Ent_h(ix)
   0D1F 67            [ 4]  443 		ld 	h, a
   0D20 2E 00         [ 7]  444 		ld 	l, #0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0D22 CD 52 0D      [17]  445 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            446 
   0D25                     447 	bounce:
   0D25 DD 66 08      [19]  448 			ld 	h, Ent_vy_I(ix)
   0D28 DD 6E 09      [19]  449 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            450 
   0D2B CD 35 0D      [17]  451 			call 	negateHL
                            452 
   0D2E DD 74 08      [19]  453 			ld 	Ent_vy_I(ix), h
   0D31 DD 75 09      [19]  454 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            455 
   0D34 C9            [10]  456 		ret
                            457 
                            458 ;; =========================================
                            459 ;; Inverts HL value
                            460 ;; Entrada:
                            461 ;; 	HL => value we are going to negate
                            462 ;; Modifica AF, HL
                            463 ;; Devuelve:
                            464 ;; 	HL <= HL value negated
                            465 ;; =========================================
   0D35                     466 negateHL::
   0D35 3E 00         [ 7]  467 	ld 	a, #0			;;
   0D37 AF            [ 4]  468 	xor	a			;;
   0D38 95            [ 4]  469 	sub	l			;;
   0D39 6F            [ 4]  470 	ld	l,a			;;
   0D3A 9F            [ 4]  471 	sbc	a,a			;;
   0D3B 94            [ 4]  472 	sub	h			;;
   0D3C 67            [ 4]  473 	ld	h,a			;; negate HL
                            474 
   0D3D C9            [10]  475 	ret
                            476 
                            477 ;; ====================================
                            478 ;; ====================================
                            479 ;; PRIVATE FUNCTIONS
                            480 ;; ====================================
                            481 ;; ====================================
                            482 
                            483 
                            484 
                            485 ;; =========================================
                            486 ;; Modifica la x de la entidad a la pasada
                            487 ;; 	por parámetro
                            488 ;; Entrada:
                            489 ;; 	IX => Pointer to entity data
                            490 ;; 	HL => value we are going to set
                            491 ;; Modifica AF
                            492 ;; =========================================
   0D3E                     493 setX:
   0D3E DD 74 00      [19]  494 	ld	Ent_x_I(ix), h
   0D41 DD 75 01      [19]  495 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            496 
   0D44 C9            [10]  497 	ret
                            498 
                            499 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            500 ;; =========================================
                            501 ;; Modifica las de últimas posiciones X
                            502 ;	de la entidad
                            503 ;; Entrada:
                            504 ;; 	IX => Pointer to entity data
                            505 ;; Modifica AF
                            506 ;; =========================================
   0D45                     507 updateX:
   0D45 DD 7E 10      [19]  508 	ld	a, Ent_last_x(ix)
   0D48 DD 77 11      [19]  509 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            510 
   0D4B DD 7E 00      [19]  511 	ld	a, Ent_x_I(ix)
   0D4E DD 77 10      [19]  512 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   0D51 C9            [10]  513 	ret
                            514 
                            515 
                            516 ;; =========================================
                            517 ;; Modifica la y de la entidad a la pasada
                            518 ;; 	por parámetro
                            519 ;; Entrada:
                            520 ;; 	IX => Pointer to entity data
                            521 ;; 	HL => value we are going to set
                            522 ;; Modifica AF
                            523 ;; =========================================
   0D52                     524 setY:
                            525 
   0D52 DD 74 02      [19]  526 	ld	Ent_y_I(ix), h
   0D55 DD 75 03      [19]  527 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            528 
   0D58 C9            [10]  529 	ret
                            530 
                            531 
                            532 ;; =========================================
                            533 ;; Modifica las de últimas posiciones Y
                            534 ;	de la entidad
                            535 ;; Entrada:
                            536 ;; 	IX => Pointer to entity data
                            537 ;; Modifica AF
                            538 ;; =========================================
   0D59                     539 updateY:
   0D59 DD 7E 12      [19]  540 	ld	a, Ent_last_y(ix)
   0D5C DD 77 13      [19]  541 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            542 
   0D5F DD 7E 02      [19]  543 	ld	a, Ent_y_I(ix)
   0D62 DD 77 12      [19]  544 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   0D65 C9            [10]  545 	ret
