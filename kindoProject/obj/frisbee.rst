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
                             12 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, sprite, id
                             13 	name'_data::
                             14 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             15 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             16 		name'_h:	.db h		;; Height			(8 bits)
                             17 		name'_w:	.db w		;; Width			(8 bits)
                             18 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             19 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             20 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             21 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             22 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             23 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             24 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             25 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             26 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
                             27 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             28 		name'_sprite:	.dw sprite	;; Entity sprite		(16 bits)
                             29 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             30 .endm
                             31 
                             32 
                             33 ;; ====================================
                             34 ;; ====================================
                             35 ;; ENTITY PUBLIC DATA
                             36 ;; ====================================
                             37 ;; ====================================
                     0000    38 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    39 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    40 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    41 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    42 .equ Ent_h, 		4	;; Height
                     0005    43 .equ Ent_w, 		5	;; Width
                     0006    44 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    45 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    46 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    47 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    48 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    49 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    50 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    51 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    52 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    53 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    54 .equ Ent_last_x,	16	;; Last x rendered
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0011    55 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    56 .equ Ent_last_y,	18	;; Last y rendered
                     0013    57 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    58 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    59 .equ Ent_sprite_H, 	21	;; Pointer to sprite, high part
                     0016    60 .equ Ent_sprite_L, 	22	;; Pointer to sprite, low part
                     0017    61 .equ Ent_id, 		23	;; Numeric ID
                             62 				;; Frisbee 	0
                             63 				;; Player1 	1
                             64 				;; Enemy1	2
                             65 
                     0003    66 .equ MAX_VEL_X, 3 
                     FFFFFFFD    67 .equ MIN_VEL_X, -3
                     0003    68 .equ MAX_VEL_Y, 3
                     FFFFFFFD    69 .equ MIN_VEL_Y, -3
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 
                              8 .globl _sprite_frisbee_1_0
                              9 .globl _sprite_frisbee_1_1
                             10 
                     001A    11 frisbee_size = 26		;; Size of frisbee structure
                     00D0    12 pos_min_vel = 0x00D0
                     FF30    13 neg_min_vel = 0xFF30
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; PUBLIC DATA
                             17 ;; ====================================
                             18 ;; ====================================
                             19 
                     0018    20 .equ Frisbee_effect_I, 24
                     0019    21 .equ Frisbee_effect_F, 25
                     0008    22 .equ std_eff, 0x0008
                     FFF8    23 .equ std_N_eff, 0xFFF8
                             24 
                             25 
                             26 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             27 
   0D66                      28 defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #1, #_sprite_frisbee_1_0, #0
   0000                       1 	frisbee_data::
   0D66 27 00                 2 		frisbee_x:	.dw #0x0027		;; X coordinate			(16 bits)
   0D68 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   0D6A 10                    4 		frisbee_h:	.db #16		;; Height			(8 bits)
   0D6B 04                    5 		frisbee_w:	.db #4		;; Width			(8 bits)
   0D6C FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0D6E 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0D70 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0D72 64 00                 9 		frisbee_ay:	.dw #0100		;; Acceleration at Y axis	(16 bits)
   0D74 00 01                10 		frisbee_normal:	.dw #0x0100	;; Normal force			(16 bits)
   0D76 27                   11 		frisbee_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   0D77 27                   12 		frisbee_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   0D78 54                   13 		frisbee_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
   0D79 54                   14 		frisbee_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   0D7A 01                   15 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0D7B 00 01                16 		frisbee_sprite:	.dw #_sprite_frisbee_1_0	;; Entity sprite		(16 bits)
   0D7D 00                   17 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   0D7E FF F8                29 	frisbee_effect: .dw #0xF8FF									;; effect
                             30 
   0D80                      31 defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #_sprite_frisbee_1_0, #0
   001A                       1 	init_data::
   0D80 27 00                 2 		init_x:	.dw #0x0027		;; X coordinate			(16 bits)
   0D82 54 00                 3 		init_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   0D84 10                    4 		init_h:	.db #16		;; Height			(8 bits)
   0D85 04                    5 		init_w:	.db #4		;; Width			(8 bits)
   0D86 FF 10                 6 		init_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0D88 00 00                 7 		init_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0D8A 00 00                 8 		init_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0D8C 00 00                 9 		init_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0D8E 00 01                10 		init_normal:	.dw #0x0100	;; Normal force			(16 bits)
   0D90 27                   11 		init_last_x:	.db #0x0027		;; Last x rendered		(8 bits)
   0D91 27                   12 		init_erase_x:	.db #0x0027		;; x rendered at same buffer	(8 bits)
   0D92 54                   13 		init_last_y:	.db #0x0054		;; Last y rendered		(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0D93 54                   14 		init_erase_y:	.db #0x0054		;; y rendered at same buffer	(8 bits)
   0D94 01                   15 		init_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0D95 00 01                16 		init_sprite:	.dw #_sprite_frisbee_1_0	;; Entity sprite		(16 bits)
   0D97 00                   17 		init_id:	.db #0		;; Numeric ID			(8 bits)
   0D98 FF F8                32 	init_effect: .dw #0xF8FF									;; effect
                             33 
                             34 
                             35 
                             36 ;; ====================================
                             37 ;; ====================================
                             38 ;; PRIVATE DATA
                             39 ;; ====================================
                             40 ;; ====================================
                             41 
                             42 
                             43 ;; ====================================
                             44 ;; ====================================
                             45 ;; PUBLIC FUNCTIONS
                             46 ;; ====================================
                             47 ;; ====================================
                             48 
                             49 ;; =========================================
                             50 ;; Desactiva el frisbee
                             51 ;; Modifica A
                             52 ;; =========================================
   0D9A                      53 frisbee_setOff::
   0D9A 3E 00         [ 7]   54 	ld 	a, #0
   0D9C 32 7A 0D      [13]   55 	ld 	(frisbee_state), a
   0D9F C9            [10]   56 	ret
                             57 
                             58 ;; ================================================
                             59 ;; Reinicia los datos de la entidad recibida en ix
                             60 ;; Recibe:
                             61 ;; 	IX <= pointer to entity data
                             62 ;; Modifica: HL, IX
                             63 ;; ================================================
   0DA0                      64 frisbee_restart::
   0DA0 DD 66 10      [19]   65 	ld	h, Ent_last_x(ix)	;; H <= last_x
   0DA3 DD 6E 11      [19]   66 	ld	l, Ent_erase_x(ix)	;; L <= erase_x
   0DA6 E5            [11]   67 	push	hl			;; push last_x and erase_x
                             68 
   0DA7 DD 66 12      [19]   69 	ld	h, Ent_last_y(ix)	;; H <= last_y
   0DAA DD 6E 13      [19]   70 	ld	l, Ent_erase_y(ix)	;; L <= erase_y
   0DAD E5            [11]   71 	push	hl			;; push last_y and erase_y
                             72 
   0DAE DD 54                73 	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
   0DB0 DD 5D                74 	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
   0DB2 21 80 0D      [10]   75 	ld	hl, #init_data
   0DB5 01 1A 00      [10]   76 	ld	bc, #frisbee_size
   0DB8 CD 7A 1B      [17]   77 	call cpct_memcpy_asm		;; Ititialize Frisbee
                             78 
   0DBB E1            [10]   79 	pop	hl
   0DBC DD 74 12      [19]   80 	ld	Ent_last_y(ix), h	;; last_y <= H
   0DBF DD 75 13      [19]   81 	ld	Ent_erase_y(ix), l	;; erase_y <= L
                             82 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0DC2 E1            [10]   83 	pop	hl
   0DC3 DD 74 10      [19]   84 	ld	Ent_last_x(ix), h	;; last_x <= H
   0DC6 DD 75 11      [19]   85 	ld	Ent_erase_x(ix), l	;; erase_x <= L
                             86 
   0DC9                      87 frisbee_erase::
   0DC9 DD 21 66 0D   [14]   88 	ld 	ix, #frisbee_data
   0DCD CD 45 0B      [17]   89 	call entityErase		;; Pintar cuadrado azul fondo
                             90 
   0DD0 C9            [10]   91 	ret
                             92 
                             93 
                             94 ;; ================================================
                             95 ;; Modifica el valor de la velocidad del frisbee
                             96 ;; 	en el eje X e Y, al recibido en HL y DE
                             97 ;;	Si la velocidad en el eje X es menor que 1
                             98 ;; 	la modifica a mínimo 1 (positivo y neg)
                             99 ;; Recibe:
                            100 ;;	 A <= entity ID
                            101 ;; 	HL <= X axis velocity
                            102 ;; 	DE <= Y axis velocity
                            103 ;; Modifica: A, HL, IX
                            104 ;; ================================================
   0DD1                     105 frisbee_setVelocities::
   0DD1 DD 21 66 0D   [14]  106 	ld 	ix, #frisbee_data
                            107 
   0DD5 FE 01         [ 7]  108 	cp 	#1
   0DD7 28 12         [12]  109 	jr	z, player_1				;; Ent_id == 1?
                            110 		;; player 2
   0DD9 7C            [ 4]  111 		ld	a, h
   0DDA FE 00         [ 7]  112 		cp 	#0
   0DDC F2 E6 0D      [10]  113 		jp	p, less_than_minus_one		;; Is VX positive? 
                            114 
   0DDF 3E 01         [ 7]  115 		ld	a, #1
   0DE1 BC            [ 4]  116 		cp	h
   0DE2 30 02         [12]  117 		jr	nc, less_than_minus_one
                            118 			;; vx greater than minus one
   0DE4 18 15         [12]  119 			jr set_vels
   0DE6                     120 		less_than_minus_one:
   0DE6 21 30 FF      [10]  121 			ld	hl, #neg_min_vel
   0DE9 18 10         [12]  122 			jr set_vels
   0DEB                     123 	negative_vx:
                            124 
   0DEB                     125 	player_1:
   0DEB 7C            [ 4]  126 		ld	a, h
   0DEC FE 00         [ 7]  127 		cp 	#0
   0DEE FA F8 0D      [10]  128 		jp	m, less_than_one		;; Is VX negative? 
                            129 
   0DF1 7C            [ 4]  130 		ld	a, h
   0DF2 FE 01         [ 7]  131 		cp	#1
   0DF4 38 02         [12]  132 		jr	c, less_than_one
                            133 			;; vx greater than one
   0DF6 18 03         [12]  134 			jr set_vels
   0DF8                     135 		less_than_one:
   0DF8 21 D0 00      [10]  136 			ld	hl, #pos_min_vel
                            137 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            138 
   0DFB                     139 	set_vels:
   0DFB DD 74 06      [19]  140 	ld 	Ent_vx_I(ix), h
   0DFE DD 75 07      [19]  141 	ld 	Ent_vx_F(ix), l
   0E01 DD 72 08      [19]  142 	ld 	Ent_vy_I(ix), d
   0E04 DD 73 09      [19]  143 	ld 	Ent_vy_F(ix), e
   0E07 C9            [10]  144 	ret
                            145 
                            146 
                            147 
                            148 
                            149 ;; ===========================================
                            150 ;; Modifica el valor del efecto del frisbee
                            151 ;; 	al recibido en HL
                            152 ;; Recibe:
                            153 ;; 	HL <= Effect value
                            154 ;; ===========================================
   0E08                     155 frisbee_setEffect::
   0E08 DD 21 66 0D   [14]  156 	ld 	ix, #frisbee_data
   0E0C DD 74 18      [19]  157 	ld 	Frisbee_effect_I(ix), h
   0E0F DD 75 19      [19]  158 	ld 	Frisbee_effect_F(ix), l
   0E12 C9            [10]  159 	ret
                            160 
                            161 ;; =========================================
                            162 ;; Actualiza el estado del frisbee
                            163 ;; Modifica A
                            164 ;; =========================================
   0E13                     165 frisbee_update::
                            166 
   0E13 3A 7A 0D      [13]  167 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   0E16 FE 01         [ 7]  168 	cp 	#1
   0E18 20 0E         [12]  169 	jr 	nz, not_active		;; A != 1?
                            170 	
                            171 		;; Active
   0E1A DD 21 66 0D   [14]  172 		ld 	ix, #frisbee_data
   0E1E CD 36 0E      [17]  173 		call frisbee_applyEffect 	
   0E21 CD 5F 0B      [17]  174 		call entityUpdatePhysics
   0E24 CD B9 0C      [17]  175 		call entityUpdatePosition
   0E27 C9            [10]  176 		ret
                            177 
   0E28                     178 	not_active:
   0E28 3E 01         [ 7]  179 		ld 	a, #1
   0E2A 32 7A 0D      [13]  180 		ld 	(frisbee_state), a
   0E2D C9            [10]  181 	ret
                            182 
   0E2E                     183 frisbee_draw::
                            184 
   0E2E DD 21 66 0D   [14]  185 	ld 	ix, #frisbee_data
   0E32 CD 21 0B      [17]  186 	call entityDraw 		;; Pintar cuadrado azul cian
                            187 
   0E35 C9            [10]  188 	ret
                            189 	
                            190 ;; ====================================
                            191 ;; ====================================
                            192 ;; PRIVATE FUNCTIONS
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            193 ;; ====================================
                            194 ;; ====================================
                            195 
                            196 
                            197 ;; ===========================================
                            198 ;; Mueve el frisbee a la izquierda un píxel
                            199 ;; Recibe:
                            200 ;; 	IX <= Pointer to entity data
                            201 ;; Modifica A
                            202 ;; ===========================================
   0E36                     203 frisbee_applyEffect:
                            204 
                            205 	;; vy' = vy + ay
   0E36 DD 66 08      [19]  206 	ld 	h, Ent_vy_I(ix)
   0E39 DD 6E 09      [19]  207 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   0E3C DD 56 18      [19]  208 	ld 	d, Frisbee_effect_I(ix)
   0E3F DD 5E 19      [19]  209 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            210 
   0E42 19            [11]  211 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
                            212 
   0E43 DD 74 08      [19]  213 	ld 	Ent_vy_I(ix), h
   0E46 DD 75 09      [19]  214 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            215 
   0E49 C9            [10]  216 	ret
                            217 
                            218 
                            219 ;; ===========================================
                            220 ;; Comprueba si el frisbee está en posición
                            221 ;;	de gol
                            222 ;; Recibe:
                            223 ;; 	IX <= Pointer to entity data
                            224 ;; Modifica A
                            225 ;; ===========================================
   0E4A                     226 frisbee_checkGoal::
   0E4A DD 7E 00      [19]  227 	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
   0E4D FE 00         [ 7]  228 	cp	#LEFT_LIMIT
   0E4F 20 09         [12]  229 	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
                            230 		;; left goal
   0E51 DD E5         [15]  231 		push ix
   0E53 CD 3A 11      [17]  232 		call incTeam2Points
   0E56 DD E1         [14]  233 		pop ix
   0E58 18 0E         [12]  234 		jr	goal
                            235 
   0E5A                     236 	no_left_goal:
   0E5A DD 86 05      [19]  237 		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
   0E5D FE 50         [ 7]  238 		cp	#RIGHT_LIMIT
   0E5F 20 0A         [12]  239 		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
                            240 			;; right goal
   0E61 DD E5         [15]  241 			push ix
   0E63 CD 2E 11      [17]  242 			call incTeam1Points
   0E66 DD E1         [14]  243 			pop ix
   0E68                     244 	goal:
   0E68 CD A0 0D      [17]  245 		call frisbee_restart
                            246 
   0E6B                     247 	no_right_goal:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   0E6B C9            [10]  248 	ret
