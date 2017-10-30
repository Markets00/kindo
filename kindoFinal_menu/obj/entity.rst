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
                             20 .globl cpct_setInterruptHandler_asm
                             21 .globl cpct_setPALColour_asm
                             22 .globl cpct_drawStringM2_asm
                             23 .globl cpct_drawStringM1_f_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "sprites.h.s"
                              1 .globl _sprite_palette
                              2 
                              3 .globl _sprite_robot_1_0
                              4 .globl _sprite_robot_1_1
                              5 
                              6 .globl _sprite_robot_2_0
                              7 .globl _sprite_robot_2_1
                              8 
                              9 .globl _sprite_frisbee_1_0
                             10 .globl _sprite_frisbee_1_1
                             11 
                             12 	
                             13 ;; ":"
                             14 .globl _sprite_points
                             15 ;; "0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
                             16 .globl _sprite_numbers_09
                             17 .globl _sprite_numbers_08
                             18 .globl _sprite_numbers_07
                             19 .globl _sprite_numbers_06
                             20 .globl _sprite_numbers_05
                             21 .globl _sprite_numbers_04
                             22 .globl _sprite_numbers_03
                             23 .globl _sprite_numbers_02
                             24 .globl _sprite_numbers_01
                             25 .globl _sprite_numbers_00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 .include "game.h.s"
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
                             12 .globl player2_data
                             13 .globl enemy2_data
                             14 .globl game_data
                             15 .globl paletteM1
                             16 .globl paletteM2
                             17 ;;.globl paletteM0
                             18 .globl blackPaletteM1
                             19 
                             20 .globl game_type
                             21 .globl game_numPlayers
                             22 .globl game_WinCondition
                             23 
                             24 .globl game_maxScore
                             25 .globl game_t1Score
                             26 .globl game_t2Score
                             27 
                             28 .globl game_minute
                             29 .globl game_secLeft
                             30 .globl game_secRight
                             31 .globl game_maxTime
                             32 .globl game_map
                             33 
                             34 .globl game_musicOptions
                             35 .globl game_timeOptions
                             36 
                             37 .globl game_interrMusic
                             38 .globl game_interrTime
                             39 .globl game_musicPlayer
                             40 .globl game_musicEffects
                             41 
                             42 .globl game_enableMusic
                             43 
                             44 
                             45 ;; ====================================
                             46 ;; ====================================
                             47 ;; GAME PUBLIC DATA
                             48 ;; ====================================
                             49 ;; ====================================
                     0050    50 .equ RIGHT_LIMIT,	80
                     0000    51 .equ LEFT_LIMIT,	0
                     001E    52 .equ TOP_LIMIT,	 	30
                     00C8    53 .equ BOTTOM_LIMIT,	200
                     0028    54 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 
                              7 
                              8 
                              9 ;; ====================================
                             10 ;; ====================================
                             11 ;; PUBLIC DATA
                             12 ;; ====================================
                             13 ;; ====================================
                     0000    14 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    15 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    16 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    17 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    18 .equ Ent_h, 		4	;; Height
                     0005    19 .equ Ent_w, 		5	;; Width
                     0006    20 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    21 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    22 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    23 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    24 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    25 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    26 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    27 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    28 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    29 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    30 .equ Ent_last_x,	16	;; Last x rendered
                     0011    31 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    32 .equ Ent_last_y,	18	;; Last y rendered
                     0013    33 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    34 .equ Ent_state,		20	;; Entity animation state
                     0015    35 .equ Ent_lastState,	21	;; Last entity animation state
                     0016    36 .equ Ent_signal,	22	;; Signar for animations
                     0017    37 .equ Ent_sprite, 	23	;; Entity sprite index
                     0018    38 .equ Ent_sprites_ptr_H, 24	;; Pointer to sprite, high part
                     0019    39 .equ Ent_sprites_ptr_L, 25	;; Pointer to sprite, high part
                     001A    40 .equ Ent_id, 		26	;; Numeric ID
                             41 				;; Frisbee 	0
                             42 				;; Player1 	1
                             43 				;; Enemy1	2
                             44 
                     0003    45 .equ MAX_VEL_X, 3 
                     FFFFFFFD    46 .equ MIN_VEL_X, -3
                     0003    47 .equ MAX_VEL_Y, 3
                     FFFFFFFD    48 .equ MIN_VEL_Y, -3
                             49 
                             50 
                             51 ;; Sprite pointers vectors
   4B0C                      52 robot_1_sprites::
   4B0C 31 42                53 	.dw	#_sprite_robot_1_0
   4B0E 95 42                54 	.dw	#_sprite_robot_1_1
                             55 
   4B10                      56 robot_2_sprites::
   4B10 59 41                57 	.dw	#_sprite_robot_2_0
   4B12 BD 41                58 	.dw	#_sprite_robot_2_1
                             59 
   4B14                      60 frisbee_sprites::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   4B14 D9 40                61 	.dw	#_sprite_frisbee_1_0
   4B16 19 41                62 	.dw	#_sprite_frisbee_1_1
                             63 
                             64 
                             65 ;; ====================================
                             66 ;; ====================================
                             67 ;; PUBLIC FUNCTIONS
                             68 ;; ====================================
                             69 ;; ====================================
                             70 
                             71 ;; ===================================
                             72 ;; Pinta una entidad en pantalla
                             73 ;; Entrada:
                             74 ;; 	IX => Pointer to entity data 
                             75 ;; Modifica AF, BC, DE, HL
                             76 ;; ===================================
   4B18                      77 entityDraw::
   4B18 CD 0B 5D      [17]   78 	call 	getVideoPtr		;; HL <= Video memory pointer
   4B1B EB            [ 4]   79 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   4B1C DD 4E 00      [19]   80 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   4B1F DD 46 02      [19]   81 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   4B22 CD 70 6B      [17]   82 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             83 
   4B25 EB            [ 4]   84 	ex 	de, hl 			;; DE = ent screen pointer
                             85 
   4B26 DD 66 19      [19]   86 	ld	h, Ent_sprites_ptr_L(ix)	;;
   4B29 DD 6E 18      [19]   87 	ld	l, Ent_sprites_ptr_H(ix)	;; HL <= Pointer to sprites vector
                             88 
   4B2C DD 7E 17      [19]   89 	ld	a, Ent_sprite(ix)	;; A <= sprite index
                             90 
   4B2F                      91 	index_loop:
   4B2F FE 00         [ 7]   92 	cp	#0
   4B31 28 05         [12]   93 	jr	z, load_sprite		;; A == 0?
                             94 		;; A (sprite) != 0
   4B33 23            [ 6]   95 		inc 	hl
   4B34 23            [ 6]   96 		inc 	hl		;; HL points 2 bytes ahead
   4B35 3D            [ 4]   97 		dec 	a		;; a--
   4B36 18 F7         [12]   98 		jr index_loop
                             99 
   4B38                     100 	load_sprite:
   4B38 46            [ 7]  101 	ld 	b, (hl)			;;
   4B39 23            [ 6]  102 	inc 	hl			;;
   4B3A 4E            [ 7]  103 	ld	c, (hl)			;; BC <= Sprite pointer
   4B3B 61            [ 4]  104 	ld 	h, c			;;
   4B3C 68            [ 4]  105 	ld 	l, b			;; HL <= BC
                            106 
   4B3D DD 46 04      [19]  107 	ld 	b, Ent_h(ix) 		;; B = ent height
   4B40 DD 4E 05      [19]  108 	ld 	c, Ent_w(ix) 		;; C = ent width
   4B43 CD 0D 68      [17]  109 	call cpct_drawSprite_asm
                            110 
   4B46 CD 4D 4D      [17]  111 	call updateX
   4B49 CD 61 4D      [17]  112 	call updateY
   4B4C C9            [10]  113 	ret
                            114 
                            115 ;; ===================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            116 ;; Borra una entidad de la pantalla
                            117 ;; Entrada:
                            118 ;; 	IX => Pointer to entity data 
                            119 ;; Modifica AF, BC, DE, HL
                            120 ;; ===================================
   4B4D                     121 entityErase::
   4B4D CD 0B 5D      [17]  122 	call 	getVideoPtr		;; HL <= Video memory pointer
   4B50 EB            [ 4]  123 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   4B51 DD 4E 11      [19]  124 	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
   4B54 DD 46 13      [19]  125 	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
   4B57 CD 70 6B      [17]  126 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                            127 
   4B5A EB            [ 4]  128 	ex 	de, hl 			;; DE = ent screen pointer
   4B5B 3E 00         [ 7]  129 	ld 	a, #0x00 		;; A = background color
   4B5D DD 46 04      [19]  130 	ld 	b, Ent_h(ix) 		;; B = ent height
   4B60 DD 4E 05      [19]  131 	ld 	c, Ent_w(ix) 		;; C = ent width
   4B63 CD C3 6A      [17]  132 	call cpct_drawSolidBox_asm
                            133 
   4B66 C9            [10]  134 	ret
                            135 
                            136 ;; =========================================
                            137 ;; Actualiza el estado de las físicas
                            138 ;; 	de una entidad
                            139 ;; Entrada:
                            140 ;; 	IX => Pointer to entity data
                            141 ;; Modifica F, DE, HL
                            142 ;; =========================================
   4B67                     143 entityUpdatePhysics::
                            144 	;; vx' = vx + ax
   4B67 DD 66 06      [19]  145 	ld 	h, Ent_vx_I(ix)
   4B6A DD 6E 07      [19]  146 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   4B6D DD 56 0A      [19]  147 	ld 	d, Ent_ax_I(ix)
   4B70 DD 5E 0B      [19]  148 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            149 
   4B73 19            [11]  150 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            151 
   4B74 7C            [ 4]  152 	ld 	a, h
   4B75 FE 03         [ 7]  153 	cp 	#MAX_VEL_X
   4B77 F2 85 4B      [10]  154 	jp 	p, cant_accelerate_x
                            155 		;; vx' < MAX_VEL_X
   4B7A FE FD         [ 7]  156 		cp 	#MIN_VEL_X
   4B7C FA 85 4B      [10]  157 		jp 	m, cant_accelerate_x
                            158 			;; vx' > MIN_VEL_X
                            159 			;; Can accelerate at X axis
   4B7F DD 74 06      [19]  160 			ld 	Ent_vx_I(ix), h
   4B82 DD 75 07      [19]  161 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            162 
   4B85                     163 	cant_accelerate_x:
                            164 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            165 
                            166 
                            167 	;; vy = vy + ay
   4B85 DD 66 08      [19]  168 	ld 	h, Ent_vy_I(ix)
   4B88 DD 6E 09      [19]  169 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   4B8B DD 56 0C      [19]  170 	ld 	d, Ent_ay_I(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4B8E DD 5E 0D      [19]  171 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            172 
   4B91 19            [11]  173 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   4B92 7C            [ 4]  174 	ld 	a, h
   4B93 FE 03         [ 7]  175 	cp 	#MAX_VEL_Y
   4B95 F2 A3 4B      [10]  176 	jp 	p, cant_accelerate_y
                            177 		;; vy' < MIN_VEL_Y
   4B98 FE FD         [ 7]  178 		cp 	#MIN_VEL_Y
   4B9A FA A3 4B      [10]  179 		jp 	m, cant_accelerate_y
                            180 			;; vy' > MIN_VEL_Y
                            181 			;; Can accelerate at Y axis
   4B9D DD 74 08      [19]  182 			ld 	Ent_vy_I(ix), h
   4BA0 DD 75 09      [19]  183 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            184 
   4BA3                     185 	cant_accelerate_y:
                            186 
                            187 	;; Apply deceleration X axis
   4BA3 DD 7E 06      [19]  188 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   4BA6 FE 00         [ 7]  189 	cp 	#0
   4BA8 28 37         [12]  190 	jr	z, check_ax
                            191 
   4BAA                     192 	check_vx:
   4BAA DD 7E 06      [19]  193 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   4BAD FE 00         [ 7]  194 		cp 	#0
   4BAF FA C8 4B      [10]  195 		jp	m, vx_negative
                            196 			;; vx positive
                            197 
   4BB2 DD 66 0E      [19]  198 			ld 	h, Ent_N_I(ix)
   4BB5 DD 6E 0F      [19]  199 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            200 
   4BB8 CD 3D 4D      [17]  201 			call 	negateHL		;; HL <= -ent_N
                            202 
   4BBB 54            [ 4]  203 			ld 	d, h
   4BBC 5D            [ 4]  204 			ld 	e, l			;; DE <= -ent_N
                            205 
   4BBD DD 66 06      [19]  206 			ld 	h, Ent_vx_I(ix)
   4BC0 DD 6E 07      [19]  207 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            208 
   4BC3 19            [11]  209 			add 	hl, de
   4BC4 38 13         [12]  210 			jr	c, can_decelerate_x
                            211 
   4BC6 18 36         [12]  212 			jr cant_decelerate_x
                            213 
   4BC8                     214 		vx_negative:
   4BC8 28 34         [12]  215 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            216 
   4BCA DD 66 06      [19]  217 			ld 	h, Ent_vx_I(ix)
   4BCD DD 6E 07      [19]  218 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   4BD0 DD 56 0E      [19]  219 			ld 	d, Ent_N_I(ix)
   4BD3 DD 5E 0F      [19]  220 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            221 
   4BD6 19            [11]  222 			add 	hl, de
   4BD7 38 00         [12]  223 			jr	c, can_decelerate_x
                            224 
   4BD9                     225 			can_decelerate_x:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4BD9 DD 74 06      [19]  226 				ld 	Ent_vx_I(ix), h
   4BDC DD 75 07      [19]  227 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            228 
   4BDF 18 1D         [12]  229 				jr cant_decelerate_x
   4BE1                     230 	check_ax:
   4BE1 DD 7E 0A      [19]  231 		ld	a, Ent_ax_I(ix)
   4BE4 FE 00         [ 7]  232 		cp 	#0
   4BE6 20 C2         [12]  233 		jr	nz, check_vx
   4BE8 DD 7E 0B      [19]  234 		ld	a, Ent_ax_F(ix)
   4BEB FE 00         [ 7]  235 		cp 	#0
   4BED 20 BB         [12]  236 		jr	nz, check_vx
                            237 			;; vx_I == 0 && ax == 0
   4BEF DD 7E 1A      [19]  238 			ld	a, Ent_id(ix)
   4BF2 FE 00         [ 7]  239 			cp	#0
   4BF4 28 08         [12]  240 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            241 
   4BF6 DD 36 06 00   [19]  242 			ld	Ent_vx_I(ix), #0
   4BFA DD 36 07 00   [19]  243 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            244 
                            245 
   4BFE                     246 	cant_decelerate_x:
                            247 
                            248 	;; Apply deceleration Y axis
   4BFE DD 7E 08      [19]  249 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   4C01 FE 00         [ 7]  250 	cp 	#0
   4C03 28 35         [12]  251 	jr	z, check_ay
                            252 
   4C05                     253 	check_vy:
   4C05 DD 7E 08      [19]  254 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   4C08 FE 00         [ 7]  255 		cp 	#0
   4C0A FA 23 4C      [10]  256 		jp	m, vy_negative
                            257 
                            258 			;; vy positive
   4C0D DD 66 0E      [19]  259 			ld 	h, Ent_N_I(ix)
   4C10 DD 6E 0F      [19]  260 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            261 
   4C13 CD 3D 4D      [17]  262 			call 	negateHL		;; HL <= -ent_N
                            263 
   4C16 54            [ 4]  264 			ld 	d, h
   4C17 5D            [ 4]  265 			ld 	e, l			;; DE <= -ent_N
                            266 
   4C18 DD 66 08      [19]  267 			ld 	h, Ent_vy_I(ix)
   4C1B DD 6E 09      [19]  268 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            269 
   4C1E 19            [11]  270 			add 	hl, de
   4C1F 38 11         [12]  271 			jr	c, can_decelerate_y
                            272 
   4C21 18 34         [12]  273 			jr cant_decelerate_y
                            274 
   4C23                     275 		vy_negative:
   4C23 DD 66 08      [19]  276 			ld 	h, Ent_vy_I(ix)
   4C26 DD 6E 09      [19]  277 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   4C29 DD 56 0E      [19]  278 			ld 	d, Ent_N_I(ix)
   4C2C DD 5E 0F      [19]  279 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            280 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   4C2F 19            [11]  281 			add 	hl, de
   4C30 38 00         [12]  282 			jr	c, can_decelerate_y
                            283 
   4C32                     284 			can_decelerate_y:
   4C32 DD 74 08      [19]  285 				ld 	Ent_vy_I(ix), h
   4C35 DD 75 09      [19]  286 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            287 
                            288 
   4C38 18 1D         [12]  289 				jr cant_decelerate_y
   4C3A                     290 	check_ay:
   4C3A DD 7E 0C      [19]  291 		ld	a, Ent_ay_I(ix)
   4C3D FE 00         [ 7]  292 		cp 	#0
   4C3F 20 C4         [12]  293 		jr	nz, check_vy
   4C41 DD 7E 0D      [19]  294 		ld	a, Ent_ay_F(ix)
   4C44 FE 00         [ 7]  295 		cp 	#0
   4C46 20 BD         [12]  296 		jr	nz, check_vy
                            297 			;; vy_I == 0 && ay == 0
   4C48 DD 7E 1A      [19]  298 			ld	a, Ent_id(ix)
   4C4B FE 00         [ 7]  299 			cp	#0
   4C4D 28 08         [12]  300 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            301 			
   4C4F DD 36 08 00   [19]  302 			ld	Ent_vy_I(ix), #0
   4C53 DD 36 09 00   [19]  303 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            304 
   4C57                     305 	cant_decelerate_y:
                            306 
   4C57 DD 36 0A 00   [19]  307 	ld 	Ent_ax_I(ix), #0	;; 
   4C5B DD 36 0B 00   [19]  308 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   4C5F DD 36 0C 00   [19]  309 	ld 	Ent_ay_I(ix), #0	;; 
   4C63 DD 36 0D 00   [19]  310 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            311 
   4C67 C9            [10]  312 	ret
                            313 
                            314 ;; =========================================
                            315 ;; Comprueba si existe colision entre
                            316 ;; dos entidades.
                            317 ;; Entrada:
                            318 ;; 	IX => Pointer to entity 1 data
                            319 ;; 	HL => Pointer to entity 2 data
                            320 ;; Modifica AF, B, HL, IX
                            321 ;; Devuelve:
                            322 ;; 	A <==== 0 si no hay colisión, y la
                            323 ;; 		diferencia absoluta entre
                            324 ;;		las x, en caso de colisión
                            325 ;; =========================================
   4C68 00 00               326 ent1_ptr: .dw #0000
   4C6A 00 00               327 ent2_ptr: .dw #0000
   4C6C                     328 entityCheckCollision::
                            329 	;;
                            330 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            331 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            332 	;;
   4C6C DD 22 68 4C   [20]  333 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   4C70 22 6A 4C      [16]  334 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            335 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4C73 DD 7E 00      [19]  336 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   4C76 DD 86 05      [19]  337 	add 	Ent_w(ix)		;; A <= A + ent1_w
   4C79 DD 2A 6A 4C   [20]  338 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   4C7D DD 96 00      [19]  339 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   4C80 F2 85 4C      [10]  340 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            341 
   4C83 18 39         [12]  342 	jr 	no_collision
                            343 
                            344 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   4C85                     345 	collision_XR:
                            346 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   4C85 47            [ 4]  347 		ld 	b, a 		;; B <= A
                            348 		;;
                            349 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            350 		;; ent2_x + ent2_w - ent1_x <= 0
                            351 		;; 
   4C86 DD 7E 00      [19]  352 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   4C89 DD 86 05      [19]  353 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   4C8C DD 2A 68 4C   [20]  354 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   4C90 DD 96 00      [19]  355 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   4C93 F2 98 4C      [10]  356 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            357 
   4C96 18 26         [12]  358 		jr 	no_collision
                            359 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   4C98                     360 	collision_XL:
                            361 		;;
                            362 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            363 		;; ent1_y + ent1_h - ent2_y <= 0
                            364 		;;
   4C98 DD 7E 02      [19]  365 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   4C9B DD 86 04      [19]  366 		add 	Ent_h(ix)		;; A <= A + ent1_w
   4C9E DD 2A 6A 4C   [20]  367 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   4CA2 DD 96 02      [19]  368 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   4CA5 F2 AA 4C      [10]  369 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            370 
   4CA8 18 14         [12]  371 		jr 	no_collision
                            372 
                            373 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   4CAA                     374 	collision_YB:
                            375 		;;
                            376 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            377 		;; ent2_y + ent2_h - ent1_y <= 0
                            378 		;; 
   4CAA DD 7E 02      [19]  379 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   4CAD DD 86 04      [19]  380 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   4CB0 DD 2A 68 4C   [20]  381 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   4CB4 DD 96 02      [19]  382 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   4CB7 F2 BC 4C      [10]  383 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            384 
   4CBA 18 02         [12]  385 		jr 	no_collision
                            386 
                            387 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   4CBC                     388 	collision_YT:
                            389 
                            390 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   4CBC 78            [ 4]  391 	ld 	a, b
                            392 
   4CBD C9            [10]  393 	ret
                            394 
   4CBE                     395 	no_collision:
   4CBE 3E 00         [ 7]  396 	ld 	a, #0 	;; A == 0 si no hay colisión
   4CC0 C9            [10]  397 	ret
                            398 
                            399 
                            400 ;; =========================================
                            401 ;; Actualiza la posición de la entidad
                            402 ;; Entrada:
                            403 ;; 	IX => Pointer to entity data
                            404 ;; Modifica AF, B, DE, HL, IX
                            405 ;; =========================================
   4CC1                     406 entityUpdatePosition::
                            407 
                            408 	;; x' = x + vx_I
   4CC1 DD 56 06      [19]  409 	ld 	d, Ent_vx_I(ix) 	
   4CC4 DD 5E 07      [19]  410 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            411 
   4CC7 DD 66 00      [19]  412 	ld 	h, Ent_x_I(ix) 		;; 
   4CCA DD 6E 01      [19]  413 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            414 
   4CCD 19            [11]  415 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            416 
   4CCE 7C            [ 4]  417 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   4CCF FE 00         [ 7]  418 	cp 	#LEFT_LIMIT
   4CD1 FA E2 4C      [10]  419 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            420 		;; can move left
   4CD4 DD 86 05      [19]  421 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   4CD7 47            [ 4]  422 		ld	b, a
   4CD8 3E 50         [ 7]  423 		ld 	a, #RIGHT_LIMIT
   4CDA B8            [ 4]  424 		cp	b
   4CDB 38 0E         [12]  425 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            426 			;; can move
   4CDD CD 46 4D      [17]  427 			call setX 		;; Ent_x <= HL (x + vx)
                            428 
   4CE0 18 14         [12]  429 			jr check_y
                            430 
   4CE2                     431 	check_left:
   4CE2 26 00         [ 7]  432 		ld 	h, #LEFT_LIMIT
   4CE4 2E 00         [ 7]  433 		ld 	l, #0
   4CE6 CD 46 4D      [17]  434 		call	setX 			;; Ent_x <= LEFT_LIMIT
   4CE9 18 0B         [12]  435 			jr check_y
                            436 
   4CEB                     437 	check_right:
   4CEB 3E 50         [ 7]  438 		ld 	a, #RIGHT_LIMIT
   4CED DD 96 05      [19]  439 		sub	a, Ent_w(ix)
   4CF0 67            [ 4]  440 		ld 	h, a
   4CF1 2E 00         [ 7]  441 		ld 	l, #0
   4CF3 CD 46 4D      [17]  442 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            443 
   4CF6                     444 	check_y:
                            445 	;; y' = y + vy_I*2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   4CF6 DD 56 08      [19]  446 	ld 	d, Ent_vy_I(ix) 	
   4CF9 DD 5E 09      [19]  447 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            448 
   4CFC DD 66 02      [19]  449 	ld 	h, Ent_y_I(ix) 		;; 
   4CFF DD 6E 03      [19]  450 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            451 
   4D02 19            [11]  452 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   4D03 19            [11]  453 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            454 
   4D04 7C            [ 4]  455 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   4D05 FE 1E         [ 7]  456 	cp 	#TOP_LIMIT
   4D07 DA 19 4D      [10]  457 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            458 		;; can move up
   4D0A 7C            [ 4]  459 		ld 	a, h
   4D0B DD 86 04      [19]  460 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   4D0E 47            [ 4]  461 		ld	b, a
   4D0F 3E C8         [ 7]  462 		ld 	a, #BOTTOM_LIMIT
   4D11 B8            [ 4]  463 		cp	b
   4D12 DA 22 4D      [10]  464 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            465 			;; can move
   4D15 CD 5A 4D      [17]  466 			call 	setY			;; Ent_y <= HL (y + vy)
                            467 
   4D18 C9            [10]  468 			ret
                            469 
                            470 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            471 
   4D19                     472 	check_top:
   4D19 26 1E         [ 7]  473 		ld 	h, #TOP_LIMIT
   4D1B 2E 00         [ 7]  474 		ld 	l, #0
   4D1D CD 5A 4D      [17]  475 		call 	setY				;; Ent_y <= TOP_LIMIT
   4D20 18 0B         [12]  476 		jr bounce
                            477 
   4D22                     478 	check_bot:
   4D22 3E C8         [ 7]  479 		ld 	a, #BOTTOM_LIMIT
   4D24 DD 96 04      [19]  480 		sub	a, Ent_h(ix)
   4D27 67            [ 4]  481 		ld 	h, a
   4D28 2E 00         [ 7]  482 		ld 	l, #0
   4D2A CD 5A 4D      [17]  483 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            484 
   4D2D                     485 	bounce:
   4D2D DD 66 08      [19]  486 			ld 	h, Ent_vy_I(ix)
   4D30 DD 6E 09      [19]  487 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            488 
   4D33 CD 3D 4D      [17]  489 			call 	negateHL
                            490 
   4D36 DD 74 08      [19]  491 			ld 	Ent_vy_I(ix), h
   4D39 DD 75 09      [19]  492 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            493 
   4D3C C9            [10]  494 		ret
                            495 
                            496 ;; =========================================
                            497 ;; Inverts HL value
                            498 ;; Entrada:
                            499 ;; 	HL => value we are going to negate
                            500 ;; Modifica AF, HL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            501 ;; Devuelve:
                            502 ;; 	HL <= HL value negated
                            503 ;; =========================================
   4D3D                     504 negateHL::
   4D3D 3E 00         [ 7]  505 	ld 	a, #0			;;
   4D3F AF            [ 4]  506 	xor	a			;;
   4D40 95            [ 4]  507 	sub	l			;;
   4D41 6F            [ 4]  508 	ld	l,a			;;
   4D42 9F            [ 4]  509 	sbc	a,a			;;
   4D43 94            [ 4]  510 	sub	h			;;
   4D44 67            [ 4]  511 	ld	h,a			;; negate HL
                            512 
   4D45 C9            [10]  513 	ret
                            514 
                            515 ;; ====================================
                            516 ;; ====================================
                            517 ;; PRIVATE FUNCTIONS
                            518 ;; ====================================
                            519 ;; ====================================
                            520 
                            521 
                            522 
                            523 ;; =========================================
                            524 ;; Modifica la x de la entidad a la pasada
                            525 ;; 	por parámetro
                            526 ;; Entrada:
                            527 ;; 	IX => Pointer to entity data
                            528 ;; 	HL => value we are going to set
                            529 ;; Modifica AF
                            530 ;; =========================================
   4D46                     531 setX:
   4D46 DD 74 00      [19]  532 	ld	Ent_x_I(ix), h
   4D49 DD 75 01      [19]  533 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            534 
   4D4C C9            [10]  535 	ret
                            536 
                            537 
                            538 ;; =========================================
                            539 ;; Modifica las de últimas posiciones X
                            540 ;	de la entidad
                            541 ;; Entrada:
                            542 ;; 	IX => Pointer to entity data
                            543 ;; Modifica AF
                            544 ;; =========================================
   4D4D                     545 updateX:
   4D4D DD 7E 10      [19]  546 	ld	a, Ent_last_x(ix)
   4D50 DD 77 11      [19]  547 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            548 
   4D53 DD 7E 00      [19]  549 	ld	a, Ent_x_I(ix)
   4D56 DD 77 10      [19]  550 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   4D59 C9            [10]  551 	ret
                            552 
                            553 
                            554 ;; =========================================
                            555 ;; Modifica la y de la entidad a la pasada
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            556 ;; 	por parámetro
                            557 ;; Entrada:
                            558 ;; 	IX => Pointer to entity data
                            559 ;; 	HL => value we are going to set
                            560 ;; Modifica AF
                            561 ;; =========================================
   4D5A                     562 setY:
                            563 
   4D5A DD 74 02      [19]  564 	ld	Ent_y_I(ix), h
   4D5D DD 75 03      [19]  565 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            566 
   4D60 C9            [10]  567 	ret
                            568 
                            569 
                            570 ;; =========================================
                            571 ;; Modifica las de últimas posiciones Y
                            572 ;	de la entidad
                            573 ;; Entrada:
                            574 ;; 	IX => Pointer to entity data
                            575 ;; Modifica AF
                            576 ;; =========================================
   4D61                     577 updateY:
   4D61 DD 7E 12      [19]  578 	ld	a, Ent_last_y(ix)
   4D64 DD 77 13      [19]  579 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            580 
   4D67 DD 7E 02      [19]  581 	ld	a, Ent_y_I(ix)
   4D6A DD 77 12      [19]  582 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   4D6D C9            [10]  583 	ret
