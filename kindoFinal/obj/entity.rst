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
                             23 .globl cpct_drawStringM1_asm
                             24 .globl cpct_etm_setTileset2x4_asm
                             25 .globl cpct_etm_drawTileBox2x4_asm
                             26 .globl cpct_etm_drawTilemap2x4_f_asm
                             27 .globl cpct_drawSpriteMaskedAlignedTable_asm
                             28 .globl cpct_drawSpriteMasked_asm
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
                             12 ;; MAP
                             13 .globl _map_tileset
                             14 .globl _tilemap
                             15 	
                             16 ;; ":"
                             17 .globl _sprite_points
                             18 ;; "0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
                             19 .globl _sprite_numbers_09
                             20 .globl _sprite_numbers_08
                             21 .globl _sprite_numbers_07
                             22 .globl _sprite_numbers_06
                             23 .globl _sprite_numbers_05
                             24 .globl _sprite_numbers_04
                             25 .globl _sprite_numbers_03
                             26 .globl _sprite_numbers_02
                             27 .globl _sprite_numbers_01
                             28 .globl _sprite_numbers_00
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
                             19 ;; ====================================
                             20 ;; ====================================
                             21 ;; GAME PUBLIC DATA
                             22 ;; ====================================
                             23 ;; ====================================
                     0050    24 .equ RIGHT_LIMIT,	80
                     0000    25 .equ LEFT_LIMIT,	0
                     0020    26 .equ TOP_LIMIT,	 	32
                     00C8    27 .equ BOTTOM_LIMIT,	200
                     0028    28 .equ CENTER_LIMIT,	40
                             29 
                             30 
                     002A    31 .equ map_tH, 42
                     0028    32 .equ map_tW, 40
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
   3DED                      52 robot_1_sprites::
   3DED 56 34                53 	.dw	#_sprite_robot_1_0
   3DEF 1E 35                54 	.dw	#_sprite_robot_1_1
                             55 
   3DF1                      56 robot_2_sprites::
   3DF1 B6 32                57 	.dw	#_sprite_robot_2_0
   3DF3 7E 33                58 	.dw	#_sprite_robot_2_1
                             59 
   3DF5                      60 frisbee_sprites::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   3DF5 B6 31                61 	.dw	#_sprite_frisbee_1_0
   3DF7 36 32                62 	.dw	#_sprite_frisbee_1_1
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
   3DF9                      77 entityDraw::
   3DF9 CD F8 4D      [17]   78 	call 	getVideoPtr		;; HL <= Video memory pointer
   3DFC EB            [ 4]   79 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   3DFD DD 4E 00      [19]   80 	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
   3E00 DD 46 02      [19]   81 	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
   3E03 CD E6 5C      [17]   82 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             83 
   3E06 EB            [ 4]   84 	ex 	de, hl 			;; DE = ent screen pointer
                             85 
   3E07 DD 66 19      [19]   86 	ld	h, Ent_sprites_ptr_L(ix)	;;
   3E0A DD 6E 18      [19]   87 	ld	l, Ent_sprites_ptr_H(ix)	;; HL <= Pointer to sprites vector
                             88 
   3E0D DD 7E 17      [19]   89 	ld	a, Ent_sprite(ix)	;; A <= sprite index
                             90 
   3E10                      91 	index_loop_2:
   3E10 FE 00         [ 7]   92 	cp	#0
   3E12 28 05         [12]   93 	jr	z, load_sprite_2		;; A == 0?
                             94 		;; A (sprite) != 0
   3E14 23            [ 6]   95 		inc 	hl
   3E15 23            [ 6]   96 		inc 	hl		;; HL points 2 bytes ahead
   3E16 3D            [ 4]   97 		dec 	a		;; a--
   3E17 18 F7         [12]   98 		jr index_loop_2
                             99 
   3E19                     100 	load_sprite_2:
   3E19 46            [ 7]  101 	ld 	b, (hl)			;;
   3E1A 23            [ 6]  102 	inc 	hl			;;
   3E1B 4E            [ 7]  103 	ld	c, (hl)			;; BC <= Sprite pointer
   3E1C 61            [ 4]  104 	ld 	h, c			;;
   3E1D 68            [ 4]  105 	ld 	l, b			;; HL <= BC
                            106 
   3E1E DD 46 04      [19]  107 	ld 	b, Ent_h(ix) 		;; B = ent height
   3E21 DD 4E 05      [19]  108 	ld 	c, Ent_w(ix) 		;; C = ent width
   3E24 CD 9C 5B      [17]  109 	call cpct_drawSpriteMasked_asm
                            110 
   3E27 CD 41 40      [17]  111 	call updateX
   3E2A CD 55 40      [17]  112 	call updateY
                            113 
                            114 
                            115 ;; ===================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            116 ;; Borra una entidad de la pantalla
                            117 ;; Entrada:
                            118 ;; 	IX => Pointer to entity data 
                            119 ;; Modifica AF, BC, DE, HL
                            120 ;; ===================================
   3E2D                     121 entityErase::
   3E2D CD F8 4D      [17]  122 	call 	getVideoPtr		;; HL <= Video memory pointer
   3E30 EB            [ 4]  123 	ex 	de, hl			;; DE <= HL (Video memory pointer)
   3E31 DD 4E 11      [19]  124 	ld 	c, Ent_erase_x(ix)	;; C <= ent_erase_x
   3E34 DD 46 13      [19]  125 	ld 	b, Ent_erase_y(ix)	;; B <= ent_erase_y
   3E37 CD E6 5C      [17]  126 	call cpct_getScreenPtr_asm 	;; HL <= ent screen pointer
                            127 
                            128 ;	ex 	de, hl 			;; DE <= ent screen pointer
                            129 ;	ld 	a, #0x00 		;; A <= background color
                            130 ;	ld 	b, Ent_h(ix) 		;; B <= ent height
                            131 ;	ld 	c, Ent_w(ix) 		;; C <= ent width
                            132 ;	call cpct_drawSolidBox_asm
                            133 
   3E3A C9            [10]  134 	ret
                            135 
                            136 ;; ===================================
                            137 ;; Borra una entidad de la pantalla
                            138 ;; Entrada:
                            139 ;; 	IX => Pointer to entity data 
                            140 ;; Modifica AF, BC, DE, HL
                            141 ;; ===================================
   3E3B                     142 entityErase_2::
   3E3B DD 7E 11      [19]  143 	ld	a, Ent_erase_x(ix)	;; A <= ent_erase_x
   3E3E CB 2F         [ 8]  144 	sra 	a			;; A <= A/2
   3E40 4F            [ 4]  145 	ld	c, a 			;; C <= ent_erase_x/2
                            146 
   3E41 DD 7E 13      [19]  147 	ld	a, Ent_erase_y(ix)	;; A <= ent_erase_y
   3E44 CB 2F         [ 8]  148 	sra 	a			;;
   3E46 CB 2F         [ 8]  149 	sra 	a			;; A <= A/4
   3E48 47            [ 4]  150 	ld	b, a 			;; B <= ent_erase_y/4
                            151 
                            152 
   3E49 21 00 20      [10]  153 	ld	hl, #_tilemap	;; Pointer to tilemap
   3E4C E5            [11]  154 	push 	hl
   3E4D CD F8 4D      [17]  155 	call 	getVideoPtr	;; HL <= Video memory pointer
   3E50 E5            [11]  156 	push	hl		;; Videomem pointer to draw
   3E51 1E 05         [ 7]  157 	ld	e, #5
   3E53 16 05         [ 7]  158 	ld	d, #5
   3E55 3E 28         [ 7]  159 	ld	a, #map_tW
   3E57 CD F4 59      [17]  160 	call cpct_etm_drawTileBox2x4_asm
                            161 
   3E5A C9            [10]  162 	ret
                            163 
                            164 
                            165  ;;   ;; Set Parameters on the stack
                            166  ;;   ld   hl, #ptilemap   ;; HL = pointer to the tilemap
                            167  ;;   push hl              ;; Push ptilemap to the stack
                            168  ;;   ld   hl, #pvideomem  ;; HL = Pointer to video memory location where tilemap is drawn
                            169  ;;   push hl              ;; Push pvideomem to the stack
                            170  ;;   ;; Set Paramters on registers
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            171  ;;   ld    a, #map_width  ;; A = map_width
                            172  ;;   ld    b, #y          ;; B = x tile-coordinate
                            173  ;;   ld    c, #x          ;; C = y tile-coordinate
                            174  ;;   ld    d, #h          ;; H = height in tiles of the tile-box
                            175  ;;   ld    e, #w          ;; L =  width in tiles of the tile-box
                            176  ;;   call  cpct_etm_drawTileBox2x4_asm ;; Call the function
                            177 
                            178 ;; =========================================
                            179 ;; Actualiza el estado de las físicas
                            180 ;; 	de una entidad
                            181 ;; Entrada:
                            182 ;; 	IX => Pointer to entity data
                            183 ;; Modifica F, DE, HL
                            184 ;; =========================================
   3E5B                     185 entityUpdatePhysics::
                            186 	;; vx' = vx + ax
   3E5B DD 66 06      [19]  187 	ld 	h, Ent_vx_I(ix)
   3E5E DD 6E 07      [19]  188 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   3E61 DD 56 0A      [19]  189 	ld 	d, Ent_ax_I(ix)
   3E64 DD 5E 0B      [19]  190 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            191 
   3E67 19            [11]  192 	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)
                            193 
   3E68 7C            [ 4]  194 	ld 	a, h
   3E69 FE 03         [ 7]  195 	cp 	#MAX_VEL_X
   3E6B F2 79 3E      [10]  196 	jp 	p, cant_accelerate_x
                            197 		;; vx' < MAX_VEL_X
   3E6E FE FD         [ 7]  198 		cp 	#MIN_VEL_X
   3E70 FA 79 3E      [10]  199 		jp 	m, cant_accelerate_x
                            200 			;; vx' > MIN_VEL_X
                            201 			;; Can accelerate at X axis
   3E73 DD 74 06      [19]  202 			ld 	Ent_vx_I(ix), h
   3E76 DD 75 07      [19]  203 			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            204 
   3E79                     205 	cant_accelerate_x:
                            206 	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X
                            207 
                            208 
                            209 	;; vy = vy + ay
   3E79 DD 66 08      [19]  210 	ld 	h, Ent_vy_I(ix)
   3E7C DD 6E 09      [19]  211 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   3E7F DD 56 0C      [19]  212 	ld 	d, Ent_ay_I(ix)
   3E82 DD 5E 0D      [19]  213 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            214 
   3E85 19            [11]  215 	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
   3E86 7C            [ 4]  216 	ld 	a, h
   3E87 FE 03         [ 7]  217 	cp 	#MAX_VEL_Y
   3E89 F2 97 3E      [10]  218 	jp 	p, cant_accelerate_y
                            219 		;; vy' < MIN_VEL_Y
   3E8C FE FD         [ 7]  220 		cp 	#MIN_VEL_Y
   3E8E FA 97 3E      [10]  221 		jp 	m, cant_accelerate_y
                            222 			;; vy' > MIN_VEL_Y
                            223 			;; Can accelerate at Y axis
   3E91 DD 74 08      [19]  224 			ld 	Ent_vy_I(ix), h
   3E94 DD 75 09      [19]  225 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            226 
   3E97                     227 	cant_accelerate_y:
                            228 
                            229 	;; Apply deceleration X axis
   3E97 DD 7E 06      [19]  230 	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   3E9A FE 00         [ 7]  231 	cp 	#0
   3E9C 28 37         [12]  232 	jr	z, check_ax
                            233 
   3E9E                     234 	check_vx:
   3E9E DD 7E 06      [19]  235 		ld 	a, Ent_vx_I(ix)		;; A <= vx_I
   3EA1 FE 00         [ 7]  236 		cp 	#0
   3EA3 FA BC 3E      [10]  237 		jp	m, vx_negative
                            238 			;; vx positive
                            239 
   3EA6 DD 66 0E      [19]  240 			ld 	h, Ent_N_I(ix)
   3EA9 DD 6E 0F      [19]  241 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            242 
   3EAC CD 31 40      [17]  243 			call 	negateHL		;; HL <= -ent_N
                            244 
   3EAF 54            [ 4]  245 			ld 	d, h
   3EB0 5D            [ 4]  246 			ld 	e, l			;; DE <= -ent_N
                            247 
   3EB1 DD 66 06      [19]  248 			ld 	h, Ent_vx_I(ix)
   3EB4 DD 6E 07      [19]  249 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
                            250 
   3EB7 19            [11]  251 			add 	hl, de
   3EB8 38 13         [12]  252 			jr	c, can_decelerate_x
                            253 
   3EBA 18 36         [12]  254 			jr cant_decelerate_x
                            255 
   3EBC                     256 		vx_negative:
   3EBC 28 34         [12]  257 			jr 	z, cant_decelerate_x	;; vx_I == 0?
                            258 
   3EBE DD 66 06      [19]  259 			ld 	h, Ent_vx_I(ix)
   3EC1 DD 6E 07      [19]  260 			ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   3EC4 DD 56 0E      [19]  261 			ld 	d, Ent_N_I(ix)
   3EC7 DD 5E 0F      [19]  262 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            263 
   3ECA 19            [11]  264 			add 	hl, de
   3ECB 38 00         [12]  265 			jr	c, can_decelerate_x
                            266 
   3ECD                     267 			can_decelerate_x:
   3ECD DD 74 06      [19]  268 				ld 	Ent_vx_I(ix), h
   3ED0 DD 75 07      [19]  269 				ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            270 
   3ED3 18 1D         [12]  271 				jr cant_decelerate_x
   3ED5                     272 	check_ax:
   3ED5 DD 7E 0A      [19]  273 		ld	a, Ent_ax_I(ix)
   3ED8 FE 00         [ 7]  274 		cp 	#0
   3EDA 20 C2         [12]  275 		jr	nz, check_vx
   3EDC DD 7E 0B      [19]  276 		ld	a, Ent_ax_F(ix)
   3EDF FE 00         [ 7]  277 		cp 	#0
   3EE1 20 BB         [12]  278 		jr	nz, check_vx
                            279 			;; vx_I == 0 && ax == 0
   3EE3 DD 7E 1A      [19]  280 			ld	a, Ent_id(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   3EE6 FE 00         [ 7]  281 			cp	#0
   3EE8 28 08         [12]  282 			jr	z, cant_decelerate_x	;; If Ent_id == frisbee_id, cant_decelerate_x
                            283 
   3EEA DD 36 06 00   [19]  284 			ld	Ent_vx_I(ix), #0
   3EEE DD 36 07 00   [19]  285 			ld	Ent_vx_F(ix), #0	;; Ent_vx <= 0
                            286 
                            287 
   3EF2                     288 	cant_decelerate_x:
                            289 
                            290 	;; Apply deceleration Y axis
   3EF2 DD 7E 08      [19]  291 	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   3EF5 FE 00         [ 7]  292 	cp 	#0
   3EF7 28 35         [12]  293 	jr	z, check_ay
                            294 
   3EF9                     295 	check_vy:
   3EF9 DD 7E 08      [19]  296 		ld 	a, Ent_vy_I(ix)		;; A <= vy_I
   3EFC FE 00         [ 7]  297 		cp 	#0
   3EFE FA 17 3F      [10]  298 		jp	m, vy_negative
                            299 
                            300 			;; vy positive
   3F01 DD 66 0E      [19]  301 			ld 	h, Ent_N_I(ix)
   3F04 DD 6E 0F      [19]  302 			ld 	l, Ent_N_F(ix)		;; HL <= ent_N
                            303 
   3F07 CD 31 40      [17]  304 			call 	negateHL		;; HL <= -ent_N
                            305 
   3F0A 54            [ 4]  306 			ld 	d, h
   3F0B 5D            [ 4]  307 			ld 	e, l			;; DE <= -ent_N
                            308 
   3F0C DD 66 08      [19]  309 			ld 	h, Ent_vy_I(ix)
   3F0F DD 6E 09      [19]  310 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
                            311 
   3F12 19            [11]  312 			add 	hl, de
   3F13 38 11         [12]  313 			jr	c, can_decelerate_y
                            314 
   3F15 18 34         [12]  315 			jr cant_decelerate_y
                            316 
   3F17                     317 		vy_negative:
   3F17 DD 66 08      [19]  318 			ld 	h, Ent_vy_I(ix)
   3F1A DD 6E 09      [19]  319 			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   3F1D DD 56 0E      [19]  320 			ld 	d, Ent_N_I(ix)
   3F20 DD 5E 0F      [19]  321 			ld 	e, Ent_N_F(ix)		;; DE <= ent_N
                            322 
   3F23 19            [11]  323 			add 	hl, de
   3F24 38 00         [12]  324 			jr	c, can_decelerate_y
                            325 
   3F26                     326 			can_decelerate_y:
   3F26 DD 74 08      [19]  327 				ld 	Ent_vy_I(ix), h
   3F29 DD 75 09      [19]  328 				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            329 
                            330 
   3F2C 18 1D         [12]  331 				jr cant_decelerate_y
   3F2E                     332 	check_ay:
   3F2E DD 7E 0C      [19]  333 		ld	a, Ent_ay_I(ix)
   3F31 FE 00         [ 7]  334 		cp 	#0
   3F33 20 C4         [12]  335 		jr	nz, check_vy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   3F35 DD 7E 0D      [19]  336 		ld	a, Ent_ay_F(ix)
   3F38 FE 00         [ 7]  337 		cp 	#0
   3F3A 20 BD         [12]  338 		jr	nz, check_vy
                            339 			;; vy_I == 0 && ay == 0
   3F3C DD 7E 1A      [19]  340 			ld	a, Ent_id(ix)
   3F3F FE 00         [ 7]  341 			cp	#0
   3F41 28 08         [12]  342 			jr	z, cant_decelerate_y	;; If Ent_id == frisbee_id, cant_decelerate_y
                            343 			
   3F43 DD 36 08 00   [19]  344 			ld	Ent_vy_I(ix), #0
   3F47 DD 36 09 00   [19]  345 			ld	Ent_vy_F(ix), #0	;; Ent_vy <= 0
                            346 
   3F4B                     347 	cant_decelerate_y:
                            348 
   3F4B DD 36 0A 00   [19]  349 	ld 	Ent_ax_I(ix), #0	;; 
   3F4F DD 36 0B 00   [19]  350 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   3F53 DD 36 0C 00   [19]  351 	ld 	Ent_ay_I(ix), #0	;; 
   3F57 DD 36 0D 00   [19]  352 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            353 
   3F5B C9            [10]  354 	ret
                            355 
                            356 ;; =========================================
                            357 ;; Comprueba si existe colision entre
                            358 ;; dos entidades.
                            359 ;; Entrada:
                            360 ;; 	IX => Pointer to entity 1 data
                            361 ;; 	HL => Pointer to entity 2 data
                            362 ;; Modifica AF, B, HL, IX
                            363 ;; Devuelve:
                            364 ;; 	A <==== 0 si no hay colisión, y la
                            365 ;; 		diferencia absoluta entre
                            366 ;;		las x, en caso de colisión
                            367 ;; =========================================
   3F5C 00 00               368 ent1_ptr: .dw #0000
   3F5E 00 00               369 ent2_ptr: .dw #0000
   3F60                     370 entityCheckCollision::
                            371 	;;
                            372 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            373 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            374 	;;
   3F60 DD 22 5C 3F   [20]  375 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   3F64 22 5E 3F      [16]  376 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            377 
   3F67 DD 7E 00      [19]  378 	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
   3F6A DD 86 05      [19]  379 	add 	Ent_w(ix)		;; A <= A + ent1_w
   3F6D DD 2A 5E 3F   [20]  380 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   3F71 DD 96 00      [19]  381 	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
   3F74 F2 79 3F      [10]  382 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            383 
   3F77 18 39         [12]  384 	jr 	no_collision
                            385 
                            386 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   3F79                     387 	collision_XR:
                            388 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   3F79 47            [ 4]  389 		ld 	b, a 		;; B <= A
                            390 		;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            391 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            392 		;; ent2_x + ent2_w - ent1_x <= 0
                            393 		;; 
   3F7A DD 7E 00      [19]  394 		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
   3F7D DD 86 05      [19]  395 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   3F80 DD 2A 5C 3F   [20]  396 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   3F84 DD 96 00      [19]  397 		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
   3F87 F2 8C 3F      [10]  398 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            399 
   3F8A 18 26         [12]  400 		jr 	no_collision
                            401 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   3F8C                     402 	collision_XL:
                            403 		;;
                            404 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            405 		;; ent1_y + ent1_h - ent2_y <= 0
                            406 		;;
   3F8C DD 7E 02      [19]  407 		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
   3F8F DD 86 04      [19]  408 		add 	Ent_h(ix)		;; A <= A + ent1_w
   3F92 DD 2A 5E 3F   [20]  409 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
   3F96 DD 96 02      [19]  410 		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
   3F99 F2 9E 3F      [10]  411 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            412 
   3F9C 18 14         [12]  413 		jr 	no_collision
                            414 
                            415 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   3F9E                     416 	collision_YB:
                            417 		;;
                            418 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            419 		;; ent2_y + ent2_h - ent1_y <= 0
                            420 		;; 
   3F9E DD 7E 02      [19]  421 		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
   3FA1 DD 86 04      [19]  422 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   3FA4 DD 2A 5C 3F   [20]  423 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   3FA8 DD 96 02      [19]  424 		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
   3FAB F2 B0 3F      [10]  425 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            426 
   3FAE 18 02         [12]  427 		jr 	no_collision
                            428 
                            429 	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
   3FB0                     430 	collision_YT:
                            431 
                            432 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   3FB0 78            [ 4]  433 	ld 	a, b
                            434 
   3FB1 C9            [10]  435 	ret
                            436 
   3FB2                     437 	no_collision:
   3FB2 3E 00         [ 7]  438 	ld 	a, #0 	;; A == 0 si no hay colisión
   3FB4 C9            [10]  439 	ret
                            440 
                            441 
                            442 ;; =========================================
                            443 ;; Actualiza la posición de la entidad
                            444 ;; Entrada:
                            445 ;; 	IX => Pointer to entity data
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            446 ;; Modifica AF, B, DE, HL, IX
                            447 ;; =========================================
   3FB5                     448 entityUpdatePosition::
                            449 
                            450 	;; x' = x + vx_I
   3FB5 DD 56 06      [19]  451 	ld 	d, Ent_vx_I(ix) 	
   3FB8 DD 5E 07      [19]  452 	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx
                            453 
   3FBB DD 66 00      [19]  454 	ld 	h, Ent_x_I(ix) 		;; 
   3FBE DD 6E 01      [19]  455 	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x
                            456 
   3FC1 19            [11]  457 	add 	hl, de 			;; HL <= HL + DE (x + vx)
                            458 
   3FC2 7C            [ 4]  459 	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
   3FC3 FE 00         [ 7]  460 	cp 	#LEFT_LIMIT
   3FC5 FA D6 3F      [10]  461 	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
                            462 		;; can move left
   3FC8 DD 86 05      [19]  463 		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
   3FCB 47            [ 4]  464 		ld	b, a
   3FCC 3E 50         [ 7]  465 		ld 	a, #RIGHT_LIMIT
   3FCE B8            [ 4]  466 		cp	b
   3FCF 38 0E         [12]  467 		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
                            468 			;; can move
   3FD1 CD 3A 40      [17]  469 			call setX 		;; Ent_x <= HL (x + vx)
                            470 
   3FD4 18 14         [12]  471 			jr check_y
                            472 
   3FD6                     473 	check_left:
   3FD6 26 00         [ 7]  474 		ld 	h, #LEFT_LIMIT
   3FD8 2E 00         [ 7]  475 		ld 	l, #0
   3FDA CD 3A 40      [17]  476 		call	setX 			;; Ent_x <= LEFT_LIMIT
   3FDD 18 0B         [12]  477 			jr check_y
                            478 
   3FDF                     479 	check_right:
   3FDF 3E 50         [ 7]  480 		ld 	a, #RIGHT_LIMIT
   3FE1 DD 96 05      [19]  481 		sub	a, Ent_w(ix)
   3FE4 67            [ 4]  482 		ld 	h, a
   3FE5 2E 00         [ 7]  483 		ld 	l, #0
   3FE7 CD 3A 40      [17]  484 		call	setX 			;; Ent_x <= RIGHT_LIMIT
                            485 
   3FEA                     486 	check_y:
                            487 	;; y' = y + vy_I*2
   3FEA DD 56 08      [19]  488 	ld 	d, Ent_vy_I(ix) 	
   3FED DD 5E 09      [19]  489 	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy
                            490 
   3FF0 DD 66 02      [19]  491 	ld 	h, Ent_y_I(ix) 		;; 
   3FF3 DD 6E 03      [19]  492 	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y
                            493 
   3FF6 19            [11]  494 	add 	hl, de 			;; HL <= HL + DE (y + vy)
   3FF7 19            [11]  495 	add 	hl, de 			;; HL <= HL + DE (y + vy)
                            496 
   3FF8 7C            [ 4]  497 	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
   3FF9 FE 20         [ 7]  498 	cp 	#TOP_LIMIT
   3FFB DA 0D 40      [10]  499 	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
                            500 		;; can move up
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   3FFE 7C            [ 4]  501 		ld 	a, h
   3FFF DD 86 04      [19]  502 		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
   4002 47            [ 4]  503 		ld	b, a
   4003 3E C8         [ 7]  504 		ld 	a, #BOTTOM_LIMIT
   4005 B8            [ 4]  505 		cp	b
   4006 DA 16 40      [10]  506 		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
                            507 			;; can move
   4009 CD 4E 40      [17]  508 			call 	setY			;; Ent_y <= HL (y + vy)
                            509 
   400C C9            [10]  510 			ret
                            511 
                            512 	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html
                            513 
   400D                     514 	check_top:
   400D 26 20         [ 7]  515 		ld 	h, #TOP_LIMIT
   400F 2E 00         [ 7]  516 		ld 	l, #0
   4011 CD 4E 40      [17]  517 		call 	setY				;; Ent_y <= TOP_LIMIT
   4014 18 0B         [12]  518 		jr bounce
                            519 
   4016                     520 	check_bot:
   4016 3E C8         [ 7]  521 		ld 	a, #BOTTOM_LIMIT
   4018 DD 96 04      [19]  522 		sub	a, Ent_h(ix)
   401B 67            [ 4]  523 		ld 	h, a
   401C 2E 00         [ 7]  524 		ld 	l, #0
   401E CD 4E 40      [17]  525 		call 	setY				;; Ent_y <= BOTTOM_LIMIT
                            526 
   4021                     527 	bounce:
   4021 DD 66 08      [19]  528 			ld 	h, Ent_vy_I(ix)
   4024 DD 6E 09      [19]  529 			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy
                            530 
   4027 CD 31 40      [17]  531 			call 	negateHL
                            532 
   402A DD 74 08      [19]  533 			ld 	Ent_vy_I(ix), h
   402D DD 75 09      [19]  534 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated
                            535 
   4030 C9            [10]  536 		ret
                            537 
                            538 ;; ==========================================================================
                            539 ;; Inverts HL value
                            540 ;; Entrada:
                            541 ;; 	HL => value we are going to negate
                            542 ;; Modifica AF, HL
                            543 ;; Devuelve:
                            544 ;; 	HL <= HL value negated
                            545 ;; http://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Signed_Math
                            546 ;; ==========================================================================
   4031                     547 negateHL::
   4031 3E 00         [ 7]  548 	ld 	a, #0			;;
   4033 AF            [ 4]  549 	xor	a			;;
   4034 95            [ 4]  550 	sub	l			;;
   4035 6F            [ 4]  551 	ld	l,a			;;
   4036 9F            [ 4]  552 	sbc	a,a			;;
   4037 94            [ 4]  553 	sub	h			;;
   4038 67            [ 4]  554 	ld	h,a			;; negate HL
                            555 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   4039 C9            [10]  556 	ret
                            557 
                            558 ;; ====================================
                            559 ;; ====================================
                            560 ;; PRIVATE FUNCTIONS
                            561 ;; ====================================
                            562 ;; ====================================
                            563 
                            564 
                            565 
                            566 ;; =========================================
                            567 ;; Modifica la x de la entidad a la pasada
                            568 ;; 	por parámetro
                            569 ;; Entrada:
                            570 ;; 	IX => Pointer to entity data
                            571 ;; 	HL => value we are going to set
                            572 ;; Modifica AF
                            573 ;; =========================================
   403A                     574 setX:
   403A DD 74 00      [19]  575 	ld	Ent_x_I(ix), h
   403D DD 75 01      [19]  576 	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL
                            577 
   4040 C9            [10]  578 	ret
                            579 
                            580 
                            581 ;; =========================================
                            582 ;; Modifica las de últimas posiciones X
                            583 ;	de la entidad
                            584 ;; Entrada:
                            585 ;; 	IX => Pointer to entity data
                            586 ;; Modifica AF
                            587 ;; =========================================
   4041                     588 updateX:
   4041 DD 7E 10      [19]  589 	ld	a, Ent_last_x(ix)
   4044 DD 77 11      [19]  590 	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x
                            591 
   4047 DD 7E 00      [19]  592 	ld	a, Ent_x_I(ix)
   404A DD 77 10      [19]  593 	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
   404D C9            [10]  594 	ret
                            595 
                            596 
                            597 ;; =========================================
                            598 ;; Modifica la y de la entidad a la pasada
                            599 ;; 	por parámetro
                            600 ;; Entrada:
                            601 ;; 	IX => Pointer to entity data
                            602 ;; 	HL => value we are going to set
                            603 ;; Modifica AF
                            604 ;; =========================================
   404E                     605 setY:
                            606 
   404E DD 74 02      [19]  607 	ld	Ent_y_I(ix), h
   4051 DD 75 03      [19]  608 	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL
                            609 
   4054 C9            [10]  610 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            611 
                            612 
                            613 ;; =========================================
                            614 ;; Modifica las de últimas posiciones Y
                            615 ;	de la entidad
                            616 ;; Entrada:
                            617 ;; 	IX => Pointer to entity data
                            618 ;; Modifica AF
                            619 ;; =========================================
   4055                     620 updateY:
   4055 DD 7E 12      [19]  621 	ld	a, Ent_last_y(ix)
   4058 DD 77 13      [19]  622 	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y
                            623 
   405B DD 7E 02      [19]  624 	ld	a, Ent_y_I(ix)
   405E DD 77 12      [19]  625 	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
   4061 C9            [10]  626 	ret
                            627 
                            628 
                            629 ;; Transparent mask table definition
   4062                     630 transparent_mask:
                            631  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            632  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            633  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            634  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            635  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            636  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            637  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            638  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            639  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            640  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            641  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            642  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            643  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            644  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            645  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            646  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            647  ;;     .db 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA
                            648  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            649  ;;     .db 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA
                            650  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            651  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            652  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            653  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            654  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            655  ;;     .db 0x00, 0x55, 0xAA, 0xFF, 0x00, 0x00, 0xAA, 0xAA
                            656  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            657  ;;     .db 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA
                            658  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            659  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            660  ;;     .db 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00
                            661  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            662  ;;     .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
