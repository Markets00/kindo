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
                             24 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             25 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             26 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             27 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
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
                             23 .globl cpct_drawStringM1_f_asm
                             24 .globl cpct_akp_musicInit_asm
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
   4D7E                      30 defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #frisbee_sprites, #0
   0000                       1 	frisbee_data::
   4D7E 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   4D80 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   4D82 10                    4 		frisbee_h:	.db #16		;; Height			(8 bits)
   4D83 04                    5 		frisbee_w:	.db #4		;; Width			(8 bits)
   4D84 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   4D86 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4D88 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4D8A 64 00                 9 		frisbee_ay:	.dw #0100		;; Acceleration at Y axis	(16 bits)
   4D8C 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   4D8E 27                   11 		frisbee_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   4D8F 27                   12 		frisbee_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   4D90 54                   13 		frisbee_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   4D91 54                   14 		frisbee_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   4D92 00                   15 		frisbee_state:	.db #0		;; Entity animation state	(8 bits)
   4D93 00                   16 		frisbee_lastState:.db #0		;; Last entity animation state	(8 bits)
   4D94 FF                   17 		frisbee_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4D95 00                   18 		frisbee_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4D96 24 4B                19 		frisbee_sprites_ptr: .dw #frisbee_sprites ;; Pointer to sprites	(16 bits)
   4D98 00                   20 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   4D99 FF F8                31 	frisbee_effect: .dw #0xF8FF									;; effect
                             32 
   4D9B                      33 defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #frisbee_sprites, #0
   001D                       1 	init_data::
   4D9B 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   4D9D 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   4D9F 10                    4 		init_h:	.db #16		;; Height			(8 bits)
   4DA0 04                    5 		init_w:	.db #4		;; Width			(8 bits)
   4DA1 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   4DA3 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4DA5 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4DA7 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4DA9 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   4DAB 27                   11 		init_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   4DAC 27                   12 		init_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   4DAD 54                   13 		init_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   4DAE 54                   14 		init_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   4DAF 00                   15 		init_state:	.db #0		;; Entity animation state	(8 bits)
   4DB0 00                   16 		init_lastState:.db #0		;; Last entity animation state	(8 bits)
   4DB1 FF                   17 		init_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4DB2 00                   18 		init_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4DB3 24 4B                19 		init_sprites_ptr: .dw #frisbee_sprites ;; Pointer to sprites	(16 bits)
   4DB5 00                   20 		init_id:	.db #0		;; Numeric ID			(8 bits)
   4DB6 FF F8                34 	init_effect: .dw #0xF8FF									;; effect
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
   4DB8                      58 frisbee_restart::
   4DB8 DD 66 10      [19]   59 	ld	h, Ent_last_x(ix)	;; H <= last_x
   4DBB DD 6E 11      [19]   60 	ld	l, Ent_erase_x(ix)	;; L <= erase_x
   4DBE E5            [11]   61 	push	hl			;; push last_x and erase_x
                             62 
   4DBF DD 66 12      [19]   63 	ld	h, Ent_last_y(ix)	;; H <= last_y
   4DC2 DD 6E 13      [19]   64 	ld	l, Ent_erase_y(ix)	;; L <= erase_y
   4DC5 E5            [11]   65 	push	hl			;; push last_y and erase_y
                             66 
   4DC6 DD 54                67 	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
   4DC8 DD 5D                68 	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
   4DCA 21 9B 4D      [10]   69 	ld	hl, #init_data
   4DCD 01 1D 00      [10]   70 	ld	bc, #frisbee_size
   4DD0 CD B0 6E      [17]   71 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             72 
   4DD3 E1            [10]   73 	pop	hl
   4DD4 DD 74 12      [19]   74 	ld	Ent_last_y(ix), h	;; last_y <= H
   4DD7 DD 75 13      [19]   75 	ld	Ent_erase_y(ix), l	;; erase_y <= L
                             76 
   4DDA E1            [10]   77 	pop	hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4DDB DD 74 10      [19]   78 	ld	Ent_last_x(ix), h	;; last_x <= H
   4DDE DD 75 11      [19]   79 	ld	Ent_erase_x(ix), l	;; erase_x <= L
                             80 
   4DE1                      81 frisbee_erase::
   4DE1 DD 21 7E 4D   [14]   82 	ld 	ix, #frisbee_data
   4DE5 CD 5D 4B      [17]   83 	call entityErase		;; Pintar cuadrado azul fondo
                             84 
   4DE8 C9            [10]   85 	ret
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
   4DE9                      99 frisbee_setVelocities::
   4DE9 DD 21 7E 4D   [14]  100 	ld 	ix, #frisbee_data
                            101 
   4DED FE 01         [ 7]  102 	cp 	#1
   4DEF 28 12         [12]  103 	jr	z, player_1				;; Ent_id == 1?
                            104 		;; player 2
   4DF1 7C            [ 4]  105 		ld	a, h
   4DF2 FE 00         [ 7]  106 		cp 	#0
   4DF4 F2 FE 4D      [10]  107 		jp	p, less_than_minus_one		;; Is VX positive? 
                            108 
   4DF7 3E 01         [ 7]  109 		ld	a, #1
   4DF9 BC            [ 4]  110 		cp	h
   4DFA 30 02         [12]  111 		jr	nc, less_than_minus_one
                            112 			;; vx greater than minus one
   4DFC 18 15         [12]  113 			jr set_vels
   4DFE                     114 		less_than_minus_one:
   4DFE 21 30 FF      [10]  115 			ld	hl, #neg_min_vel
   4E01 18 10         [12]  116 			jr set_vels
   4E03                     117 	negative_vx:
                            118 
   4E03                     119 	player_1:
   4E03 7C            [ 4]  120 		ld	a, h
   4E04 FE 00         [ 7]  121 		cp 	#0
   4E06 FA 10 4E      [10]  122 		jp	m, less_than_one		;; Is VX negative? 
                            123 
   4E09 7C            [ 4]  124 		ld	a, h
   4E0A FE 01         [ 7]  125 		cp	#1
   4E0C 38 02         [12]  126 		jr	c, less_than_one
                            127 			;; vx greater than one
   4E0E 18 03         [12]  128 			jr set_vels
   4E10                     129 		less_than_one:
   4E10 21 D0 00      [10]  130 			ld	hl, #pos_min_vel
                            131 
                            132 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   4E13                     133 	set_vels:
   4E13 DD 74 06      [19]  134 	ld 	Ent_vx_I(ix), h
   4E16 DD 75 07      [19]  135 	ld 	Ent_vx_F(ix), l
   4E19 DD 72 08      [19]  136 	ld 	Ent_vy_I(ix), d
   4E1C DD 73 09      [19]  137 	ld 	Ent_vy_F(ix), e
   4E1F C9            [10]  138 	ret
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
   4E20                     149 frisbee_setEffect::
   4E20 DD 21 7E 4D   [14]  150 	ld 	ix, #frisbee_data
   4E24 DD 74 1B      [19]  151 	ld 	Frisbee_effect_I(ix), h
   4E27 DD 75 1C      [19]  152 	ld 	Frisbee_effect_F(ix), l
   4E2A C9            [10]  153 	ret
                            154 
                            155 ;; =========================================
                            156 ;; Actualiza el estado del frisbee
                            157 ;; Modifica A
                            158 ;; =========================================
   4E2B                     159 frisbee_update::
   4E2B CD 52 4E      [17]  160 	call update_frisbee_animation	;; A <= update / not update
   4E2E FE 00         [ 7]  161 	cp 	#0
   4E30 28 0E         [12]  162 	jr 	z, not_active		;; A == 0? not active
                            163 		;; Active
   4E32 DD 21 7E 4D   [14]  164 		ld 	ix, #frisbee_data
   4E36 CD 8B 4E      [17]  165 		call frisbee_applyEffect 	
   4E39 CD 77 4B      [17]  166 		call entityUpdatePhysics
   4E3C CD D1 4C      [17]  167 		call entityUpdatePosition
   4E3F C9            [10]  168 		ret
                            169 
   4E40                     170 	not_active:
   4E40 3E 01         [ 7]  171 		ld 	a, #1
   4E42 32 92 4D      [13]  172 		ld 	(frisbee_state), a
   4E45 C9            [10]  173 	ret
                            174 
   4E46                     175 frisbee_draw::
                            176 
   4E46 DD 21 7E 4D   [14]  177 	ld 	ix, #frisbee_data
   4E4A CD 28 4B      [17]  178 	call entityDraw 		;; Pintar cuadrado azul cian
                            179 
   4E4D C9            [10]  180 	ret
                            181 	
                            182 ;; =========================================
                            183 ;; Desactiva el frisbee
                            184 ;; Modifica A
                            185 ;; Entrada:
                            186 ;; 	A <= State number to set
                            187 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4E4E                     188 frisbee_setState::
   4E4E 32 92 4D      [13]  189 	ld 	(frisbee_state), a
   4E51 C9            [10]  190 	ret
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
   4E52                     202 update_frisbee_animation::
   4E52 CD 5A 4E      [17]  203 	call 	animation_delta
   4E55 DD 36 16 FF   [19]  204 	ld 	Ent_signal(ix), #-1
   4E59 C9            [10]  205 	ret
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
   4E5A                     219 animation_delta:
   4E5A DD 7E 14      [19]  220 	ld	a, Ent_state(ix)
                            221 
   4E5D FE FF         [ 7]  222 	cp	#-1
   4E5F 28 11         [12]  223 	jr	z, anim_disabled
                            224 		;; Firsbee active
   4E61 FE 00         [ 7]  225 		cp	#0
   4E63 20 04         [12]  226 		jr	nz, not_zero
                            227 			;; STATE 0 - frisbee step 1 state ;;
   4E65 CD 75 4E      [17]  228 			call frisbee0_state
   4E68 C9            [10]  229 			ret
   4E69                     230 		not_zero:
   4E69 FE 01         [ 7]  231 		cp	#1
   4E6B 20 04         [12]  232 		jr	nz, not_one
                            233 			;; STATE 1 - frisbee step 2 state ;;
   4E6D CD 80 4E      [17]  234 			call frisbee1_state
   4E70 C9            [10]  235 			ret
   4E71                     236 		not_one:
                            237 
   4E71 C9            [10]  238 		ret
   4E72                     239 	anim_disabled:
                            240 
   4E72 3E 00         [ 7]  241 	ld a, #0	;; A <= Not update physics
   4E74 C9            [10]  242 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            243 
                            244 
                            245 ;; ======================================
                            246 ;; 	Frisbee 1 State #1
                            247 ;; Entrada:  IX <= Pointer to player data
                            248 ;; Devuelve: A <= Not Update/Update
                            249 ;; ======================================
   4E75                     250 frisbee0_state:
   4E75 DD 36 17 00   [19]  251 	ld Ent_sprite(ix), #0	;; Next sprite <= 30
                            252 	;; ld a, Ent_state(ix)	;;
                            253 	;; ld Ent_lastState(ix), a	;; LastState <= current state
   4E79 DD 36 14 01   [19]  254 	ld Ent_state(ix), #1	;; Next state <= 0
                            255 
   4E7D 3E 01         [ 7]  256 	ld a, #1		;; A <= Update physics
   4E7F C9            [10]  257 	ret
                            258 
                            259 ;; ======================================
                            260 ;; 	Frisbee 1 State #1
                            261 ;; Entrada:  IX <= Pointer to player data
                            262 ;; Devuelve: A <= Not Update/Update
                            263 ;; ======================================
   4E80                     264 frisbee1_state:
   4E80 DD 36 17 01   [19]  265 	ld Ent_sprite(ix), #1	;; Next sprite <= 30
                            266 	;; ld a, Ent_state(ix)	;;
                            267 	;; ld Ent_lastState(ix), a	;; LastState <= current state
   4E84 DD 36 14 00   [19]  268 	ld Ent_state(ix), #0	;; Next state <= 0
                            269 
   4E88 3E 01         [ 7]  270 	ld a, #1		;; A <= Update physics
   4E8A C9            [10]  271 	ret
                            272 
                            273 ;; ===========================================
                            274 ;; Mueve el frisbee a la izquierda un píxel
                            275 ;; Recibe:
                            276 ;; 	IX <= Pointer to entity data
                            277 ;; Modifica A
                            278 ;; ===========================================
   4E8B                     279 frisbee_applyEffect:
                            280 	;; vy' = vy + ay
   4E8B DD 66 08      [19]  281 	ld 	h, Ent_vy_I(ix)
   4E8E DD 6E 09      [19]  282 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   4E91 DD 56 1B      [19]  283 	ld 	d, Frisbee_effect_I(ix)
   4E94 DD 5E 1C      [19]  284 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            285 
   4E97 19            [11]  286 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            287 
   4E98 DD 74 08      [19]  288 	ld 	Ent_vy_I(ix), h
   4E9B DD 75 09      [19]  289 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            290 
   4E9E C9            [10]  291 	ret
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
   4E9F                     301 frisbee_checkGoal::
   4E9F DD 7E 00      [19]  302 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   4EA2 FE 00         [ 7]  303 	cp	#LEFT_LIMIT
   4EA4 20 09         [12]  304 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            305 		;; left goal
   4EA6 DD E5         [15]  306 		push ix
   4EA8 CD 6A 60      [17]  307 		call incTeam2Points
   4EAB DD E1         [14]  308 		pop ix
   4EAD 18 0E         [12]  309 		jr	goal
                            310 
   4EAF                     311 	no_left_goal:
   4EAF DD 86 05      [19]  312 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   4EB2 FE 50         [ 7]  313 		cp	#RIGHT_LIMIT
   4EB4 20 0A         [12]  314 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            315 			;; right goal
   4EB6 DD E5         [15]  316 			push ix
   4EB8 CD 5E 60      [17]  317 			call incTeam1Points
   4EBB DD E1         [14]  318 			pop ix
   4EBD                     319 	goal:
   4EBD CD B8 4D      [17]  320 		call frisbee_restart
                            321 
   4EC0                     322 	no_right_goal:
   4EC0 C9            [10]  323 	ret
