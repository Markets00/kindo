ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "entity.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; ENTITY PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl entityDraw
                              7 .globl entityErase
                              8 .globl entityCheckCollision
                              9 .globl entityUpdatePhysics
                             10 .globl entityUpdatePosition
                             11 
                             12 
                             13 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, sprites_ptr, id
                             14 	name'_data::
                             15 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             16 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             17 		name'_h:	.db h		;; Height			(8 bits)
                             18 		name'_w:	.db w		;; Width			(8 bits)
                             19 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             20 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             21 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             22 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             23 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             24 		name'_last_x:	.db #30		;; Last x rendered		(8 bits)
                             25 		name'_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
                             26 		name'_last_y:	.db #30		;; Last y rendered		(8 bits)
                             27 		name'_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
                             28 		name'_state:	.db #0		;; Entity animation state	(8 bits)
                             29 		name'_lastState:.db #0		;; Last entity animation state	(8 bits)
                             30 		name'_signal:	.db #-1		;; Signal recived for animations(8 bits)
                             31 		name'_sprite:	.db #0		;; Entity sprite index		(8 bits)
                             32 		name'_sprites_ptr: .dw sprites_ptr ;; Pointer to sprites	(16 bits)
                             33 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             34 .endm
                             35 
                             36 
                             37 ;; ====================================
                             38 ;; ====================================
                             39 ;; ENTITY PUBLIC DATA
                             40 ;; ====================================
                             41 ;; ====================================
                             42 
                             43 .globl robot_1_sprites
                             44 .globl robot_2_sprites
                             45 .globl frisbee_sprites
                             46 
                     0000    47 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    48 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    49 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    50 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    51 .equ Ent_h, 		4	;; Height
                     0005    52 .equ Ent_w, 		5	;; Width
                     0006    53 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    54 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0008    55 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    56 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    57 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    58 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    59 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    60 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    61 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    62 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    63 .equ Ent_last_x,	16	;; Last x rendered
                     0011    64 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    65 .equ Ent_last_y,	18	;; Last y rendered
                     0013    66 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    67 .equ Ent_state,		20	;; Entity animation state
                     0015    68 .equ Ent_lastState,	21	;; Last entity animation state
                     0016    69 .equ Ent_signal,	22	;; Signar for animations
                     0017    70 .equ Ent_sprite, 	23	;; Entity sprite index
                     0018    71 .equ Ent_sprites_ptr_H, 24	;; Pointer to sprite, high part
                     0019    72 .equ Ent_sprites_ptr_L, 25	;; Pointer to sprite, high part
                     001A    73 .equ Ent_id, 		26	;; Numeric ID
                             74 				;; Frisbee 	0
                             75 				;; Player1 	1
                             76 				;; Enemy1	2
                             77 
                     0003    78 .equ MAX_VEL_X, 3 
                     FFFFFFFD    79 .equ MIN_VEL_X, -3
                     0003    80 .equ MAX_VEL_Y, 3
                     FFFFFFFD    81 .equ MIN_VEL_Y, -3
                             82 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 .include "utility.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 .include "game.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 .include "sprites.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 
                              9 .globl _sprite_frisbee_1_0
                             10 .globl _sprite_frisbee_1_1
                             11 
                     00D0    12 pos_min_vel = 0x00D0
                     FF30    13 neg_min_vel = 0xFF30
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; PUBLIC DATA
                             17 ;; ====================================
                             18 ;; ====================================
                             19 
                     001D    20 frisbee_size = 29		;; Size of frisbee structure
                             21 
                     001B    22 .equ Frisbee_effect_I, 27
                     001C    23 .equ Frisbee_effect_F, 28
                     0008    24 .equ std_eff, 0x0008
                     FFF8    25 .equ std_N_eff, 0xFFF8
                             26 
                             27 
                             28 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, sprites_ptr, id
                             29 
   4062                      30 defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #frisbee_sprites, #0
   0000                       1 	frisbee_data::
   4062 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   4064 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   4066 10                    4 		frisbee_h:	.db #16		;; Height			(8 bits)
   4067 04                    5 		frisbee_w:	.db #4		;; Width			(8 bits)
   4068 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   406A 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   406C 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   406E 64 00                 9 		frisbee_ay:	.dw #0100		;; Acceleration at Y axis	(16 bits)
   4070 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   4072 1E                   11 		frisbee_last_x:	.db #30		;; Last x rendered		(8 bits)
   4073 1E                   12 		frisbee_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
   4074 1E                   13 		frisbee_last_y:	.db #30		;; Last y rendered		(8 bits)
   4075 1E                   14 		frisbee_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4076 00                   15 		frisbee_state:	.db #0		;; Entity animation state	(8 bits)
   4077 00                   16 		frisbee_lastState:.db #0		;; Last entity animation state	(8 bits)
   4078 FF                   17 		frisbee_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4079 00                   18 		frisbee_sprite:	.db #0		;; Entity sprite index		(8 bits)
   407A F5 3D                19 		frisbee_sprites_ptr: .dw #frisbee_sprites ;; Pointer to sprites	(16 bits)
   407C 00                   20 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   407D FF F8                31 	frisbee_effect: .dw #0xF8FF									;; effect
                             32 
   407F                      33 defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #frisbee_sprites, #0
   001D                       1 	init_data::
   407F 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   4081 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   4083 10                    4 		init_h:	.db #16		;; Height			(8 bits)
   4084 04                    5 		init_w:	.db #4		;; Width			(8 bits)
   4085 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   4087 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4089 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   408B 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   408D 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   408F 1E                   11 		init_last_x:	.db #30		;; Last x rendered		(8 bits)
   4090 1E                   12 		init_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
   4091 1E                   13 		init_last_y:	.db #30		;; Last y rendered		(8 bits)
   4092 1E                   14 		init_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4093 00                   15 		init_state:	.db #0		;; Entity animation state	(8 bits)
   4094 00                   16 		init_lastState:.db #0		;; Last entity animation state	(8 bits)
   4095 FF                   17 		init_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4096 00                   18 		init_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4097 F5 3D                19 		init_sprites_ptr: .dw #frisbee_sprites ;; Pointer to sprites	(16 bits)
   4099 00                   20 		init_id:	.db #0		;; Numeric ID			(8 bits)
   409A FF F8                34 	init_effect: .dw #0xF8FF									;; effect
                             35 
                             36 
                             37 
                             38 ;; ====================================
                             39 ;; ====================================
                             40 ;; PRIVATE DATA
                             41 ;; ====================================
                             42 ;; ====================================
                             43 
                             44 
                             45 ;; ====================================
                             46 ;; ====================================
                             47 ;; PUBLIC FUNCTIONS
                             48 ;; ====================================
                             49 ;; ====================================
                             50 
                             51 
                             52 ;; ================================================
                             53 ;; Reinicia los datos de la entidad recibida en ix
                             54 ;; Recibe:
                             55 ;; 	IX <= pointer to entity data
                             56 ;; Modifica: HL, IX
                             57 ;; ================================================
   409C                      58 frisbee_restart::
   409C DD 66 10      [19]   59 	ld	h, Ent_last_x(ix)	;; H <= last_x
   409F DD 6E 11      [19]   60 	ld	l, Ent_erase_x(ix)	;; L <= erase_x
   40A2 E5            [11]   61 	push	hl			;; push last_x and erase_x
                             62 
   40A3 DD 66 12      [19]   63 	ld	h, Ent_last_y(ix)	;; H <= last_y
   40A6 DD 6E 13      [19]   64 	ld	l, Ent_erase_y(ix)	;; L <= erase_y
   40A9 E5            [11]   65 	push	hl			;; push last_y and erase_y
                             66 
   40AA DD 54                67 	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
   40AC DD 5D                68 	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
   40AE 21 7F 40      [10]   69 	ld	hl, #init_data
   40B1 01 1D 00      [10]   70 	ld	bc, #frisbee_size
   40B4 CD 05 5C      [17]   71 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             72 
   40B7 E1            [10]   73 	pop	hl
   40B8 DD 74 12      [19]   74 	ld	Ent_last_y(ix), h	;; last_y <= H
   40BB DD 75 13      [19]   75 	ld	Ent_erase_y(ix), l	;; erase_y <= L
                             76 
   40BE E1            [10]   77 	pop	hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   40BF DD 74 10      [19]   78 	ld	Ent_last_x(ix), h	;; last_x <= H
   40C2 DD 75 11      [19]   79 	ld	Ent_erase_x(ix), l	;; erase_x <= L
                             80 
   40C5                      81 frisbee_erase::
   40C5 DD 21 62 40   [14]   82 	ld 	ix, #frisbee_data
   40C9 CD 2D 3E      [17]   83 	call entityErase		;; Pintar cuadrado azul fondo
                             84 
   40CC C9            [10]   85 	ret
                             86 
                             87 
                             88 ;; ================================================
                             89 ;; Modifica el valor de la velocidad del frisbee
                             90 ;; 	en el eje X e Y, al recibido en HL y DE
                             91 ;;	Si la velocidad en el eje X es menor que 1
                             92 ;; 	la modifica a mínimo 1 (positivo y neg)
                             93 ;; Recibe:
                             94 ;;	 A <= entity ID
                             95 ;; 	HL <= X axis velocity
                             96 ;; 	DE <= Y axis velocity
                             97 ;; Modifica: A, HL, IX
                             98 ;; ================================================
   40CD                      99 frisbee_setVelocities::
   40CD DD 21 62 40   [14]  100 	ld 	ix, #frisbee_data
                            101 
   40D1 FE 01         [ 7]  102 	cp 	#1
   40D3 28 12         [12]  103 	jr	z, player_1				;; Ent_id == 1?
                            104 		;; player 2
   40D5 7C            [ 4]  105 		ld	a, h
   40D6 FE 00         [ 7]  106 		cp 	#0
   40D8 F2 E2 40      [10]  107 		jp	p, less_than_minus_one		;; Is VX positive? 
                            108 
   40DB 3E 01         [ 7]  109 		ld	a, #1
   40DD BC            [ 4]  110 		cp	h
   40DE 30 02         [12]  111 		jr	nc, less_than_minus_one
                            112 			;; vx greater than minus one
   40E0 18 15         [12]  113 			jr set_vels
   40E2                     114 		less_than_minus_one:
   40E2 21 30 FF      [10]  115 			ld	hl, #neg_min_vel
   40E5 18 10         [12]  116 			jr set_vels
   40E7                     117 	negative_vx:
                            118 
   40E7                     119 	player_1:
   40E7 7C            [ 4]  120 		ld	a, h
   40E8 FE 00         [ 7]  121 		cp 	#0
   40EA FA F4 40      [10]  122 		jp	m, less_than_one		;; Is VX negative? 
                            123 
   40ED 7C            [ 4]  124 		ld	a, h
   40EE FE 01         [ 7]  125 		cp	#1
   40F0 38 02         [12]  126 		jr	c, less_than_one
                            127 			;; vx greater than one
   40F2 18 03         [12]  128 			jr set_vels
   40F4                     129 		less_than_one:
   40F4 21 D0 00      [10]  130 			ld	hl, #pos_min_vel
                            131 
                            132 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   40F7                     133 	set_vels:
   40F7 DD 74 06      [19]  134 	ld 	Ent_vx_I(ix), h
   40FA DD 75 07      [19]  135 	ld 	Ent_vx_F(ix), l
   40FD DD 72 08      [19]  136 	ld 	Ent_vy_I(ix), d
   4100 DD 73 09      [19]  137 	ld 	Ent_vy_F(ix), e
   4103 C9            [10]  138 	ret
                            139 
                            140 
                            141 
                            142 
                            143 ;; ===========================================
                            144 ;; Modifica el valor del efecto del frisbee
                            145 ;; 	al recibido en HL
                            146 ;; Recibe:
                            147 ;; 	HL <= Effect value
                            148 ;; ===========================================
   4104                     149 frisbee_setEffect::
   4104 DD 21 62 40   [14]  150 	ld 	ix, #frisbee_data
   4108 DD 74 1B      [19]  151 	ld 	Frisbee_effect_I(ix), h
   410B DD 75 1C      [19]  152 	ld 	Frisbee_effect_F(ix), l
   410E C9            [10]  153 	ret
                            154 
                            155 ;; =========================================
                            156 ;; Actualiza el estado del frisbee
                            157 ;; Modifica A
                            158 ;; =========================================
   410F                     159 frisbee_update::
   410F CD 36 41      [17]  160 	call update_frisbee_animation	;; A <= update / not update
   4112 FE 00         [ 7]  161 	cp 	#0
   4114 28 0E         [12]  162 	jr 	z, not_active		;; A == 0? not active
                            163 		;; Active
   4116 DD 21 62 40   [14]  164 		ld 	ix, #frisbee_data
   411A CD 6F 41      [17]  165 		call frisbee_applyEffect 	
   411D CD 5B 3E      [17]  166 		call entityUpdatePhysics
   4120 CD B5 3F      [17]  167 		call entityUpdatePosition
   4123 C9            [10]  168 		ret
                            169 
   4124                     170 	not_active:
   4124 3E 01         [ 7]  171 		ld 	a, #1
   4126 32 76 40      [13]  172 		ld 	(frisbee_state), a
   4129 C9            [10]  173 	ret
                            174 
   412A                     175 frisbee_draw::
                            176 
   412A DD 21 62 40   [14]  177 	ld 	ix, #frisbee_data
   412E CD F9 3D      [17]  178 	call entityDraw 		;; Pintar cuadrado azul cian
                            179 
   4131 C9            [10]  180 	ret
                            181 	
                            182 ;; =========================================
                            183 ;; Desactiva el frisbee
                            184 ;; Modifica A
                            185 ;; Entrada:
                            186 ;; 	A <= State number to set
                            187 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4132                     188 frisbee_setState::
   4132 32 76 40      [13]  189 	ld 	(frisbee_state), a
   4135 C9            [10]  190 	ret
                            191 
                            192 ;; =============================================
                            193 ;; Actualiza el sprite que se tiene que
                            194 ;; 	dibujar en este frame
                            195 ;; Entrada:
                            196 ;;	IX <= Pointer to player data
                            197 ;; Modifica: 
                            198 ;; Devuelve:
                            199 ;; 	A => 1 that state have to update physics
                            200 ;;	  => 0 that state not update physics
                            201 ;; =============================================
   4136                     202 update_frisbee_animation::
   4136 CD 3E 41      [17]  203 	call 	animation_delta
   4139 DD 36 16 FF   [19]  204 	ld 	Ent_signal(ix), #-1
   413D C9            [10]  205 	ret
                            206 
                            207 ;; ====================================
                            208 ;; ====================================
                            209 ;; PRIVATE FUNCTIONS
                            210 ;; ====================================
                            211 ;; ====================================
                            212 
                            213 ;; =========================================
                            214 ;; Determina el siguiente estado de
                            215 ;;	la entidad
                            216 ;; Entrada:
                            217 ;;	IX <= Pointer to player data
                            218 ;; =========================================
   413E                     219 animation_delta:
   413E DD 7E 14      [19]  220 	ld	a, Ent_state(ix)
                            221 
   4141 FE FF         [ 7]  222 	cp	#-1
   4143 28 11         [12]  223 	jr	z, anim_disabled
                            224 		;; Firsbee active
   4145 FE 00         [ 7]  225 		cp	#0
   4147 20 04         [12]  226 		jr	nz, not_zero
                            227 			;; STATE 0 - frisbee step 1 state ;;
   4149 CD 59 41      [17]  228 			call frisbee0_state
   414C C9            [10]  229 			ret
   414D                     230 		not_zero:
   414D FE 01         [ 7]  231 		cp	#1
   414F 20 04         [12]  232 		jr	nz, not_one
                            233 			;; STATE 1 - frisbee step 2 state ;;
   4151 CD 64 41      [17]  234 			call frisbee1_state
   4154 C9            [10]  235 			ret
   4155                     236 		not_one:
                            237 
   4155 C9            [10]  238 		ret
   4156                     239 	anim_disabled:
                            240 
   4156 3E 00         [ 7]  241 	ld a, #0	;; A <= Not update physics
   4158 C9            [10]  242 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            243 
                            244 
                            245 ;; ======================================
                            246 ;; 	Frisbee 1 State #1
                            247 ;; Entrada:  IX <= Pointer to player data
                            248 ;; Devuelve: A <= Not Update/Update
                            249 ;; ======================================
   4159                     250 frisbee0_state:
   4159 DD 36 17 00   [19]  251 	ld Ent_sprite(ix), #0	;; Next sprite <= 30
                            252 	;; ld a, Ent_state(ix)	;;
                            253 	;; ld Ent_lastState(ix), a	;; LastState <= current state
   415D DD 36 14 01   [19]  254 	ld Ent_state(ix), #1	;; Next state <= 0
                            255 
   4161 3E 01         [ 7]  256 	ld a, #1		;; A <= Update physics
   4163 C9            [10]  257 	ret
                            258 
                            259 ;; ======================================
                            260 ;; 	Frisbee 1 State #1
                            261 ;; Entrada:  IX <= Pointer to player data
                            262 ;; Devuelve: A <= Not Update/Update
                            263 ;; ======================================
   4164                     264 frisbee1_state:
   4164 DD 36 17 01   [19]  265 	ld Ent_sprite(ix), #1	;; Next sprite <= 30
                            266 	;; ld a, Ent_state(ix)	;;
                            267 	;; ld Ent_lastState(ix), a	;; LastState <= current state
   4168 DD 36 14 00   [19]  268 	ld Ent_state(ix), #0	;; Next state <= 0
                            269 
   416C 3E 01         [ 7]  270 	ld a, #1		;; A <= Update physics
   416E C9            [10]  271 	ret
                            272 
                            273 ;; ===========================================
                            274 ;; Mueve el frisbee a la izquierda un píxel
                            275 ;; Recibe:
                            276 ;; 	IX <= Pointer to entity data
                            277 ;; Modifica A
                            278 ;; ===========================================
   416F                     279 frisbee_applyEffect:
                            280 	;; vy' = vy + ay
   416F DD 66 08      [19]  281 	ld 	h, Ent_vy_I(ix)
   4172 DD 6E 09      [19]  282 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   4175 DD 56 1B      [19]  283 	ld 	d, Frisbee_effect_I(ix)
   4178 DD 5E 1C      [19]  284 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            285 
   417B 19            [11]  286 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            287 
   417C DD 74 08      [19]  288 	ld 	Ent_vy_I(ix), h
   417F DD 75 09      [19]  289 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            290 
   4182 C9            [10]  291 	ret
                            292 
                            293 
                            294 ;; ===========================================
                            295 ;; Comprueba si el frisbee está en posición
                            296 ;;	de gol
                            297 ;; Recibe:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            298 ;; 	IX <= Pointer to entity data
                            299 ;; Modifica A
                            300 ;; ===========================================
   4183                     301 frisbee_checkGoal::
   4183 DD 7E 00      [19]  302 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   4186 FE 00         [ 7]  303 	cp	#LEFT_LIMIT
   4188 20 09         [12]  304 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            305 		;; left goal
   418A DD E5         [15]  306 		push ix
   418C CD 08 4E      [17]  307 		call incTeam2Points
   418F DD E1         [14]  308 		pop ix
   4191 18 0E         [12]  309 		jr	goal
                            310 
   4193                     311 	no_left_goal:
   4193 DD 86 05      [19]  312 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   4196 FE 50         [ 7]  313 		cp	#RIGHT_LIMIT
   4198 20 0A         [12]  314 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            315 			;; right goal
   419A DD E5         [15]  316 			push ix
   419C CD FC 4D      [17]  317 			call incTeam1Points
   419F DD E1         [14]  318 			pop ix
   41A1                     319 	goal:
   41A1 CD 9C 40      [17]  320 		call frisbee_restart
                            321 
   41A4                     322 	no_right_goal:
   41A4 C9            [10]  323 	ret
