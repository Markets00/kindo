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
                             12 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr, id
                             13 	name'_data::
                             14 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             15 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             16 		name'_h:	.db h		;; Height			(8 bits)
                             17 		name'_w:	.db w		;; Width			(8 bits)
                             18 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             19 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             20 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             21 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             22 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             23 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             24 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             25 .endm
                             26 
                             27 
                             28 ;; ====================================
                             29 ;; ====================================
                             30 ;; ENTITY PUBLIC DATA
                             31 ;; ====================================
                             32 ;; ====================================
                     0000    33 .equ Ent_x_I, 	0	;; X coordinate, integer part
                     0001    34 .equ Ent_x_F, 	1	;; X coordinate, fractional part
                     0002    35 .equ Ent_y_I, 	2	;; Y coordinate, integer part
                     0003    36 .equ Ent_y_F, 	3	;; Y coordinate, fractional part
                     0004    37 .equ Ent_h, 	4	;; Height
                     0005    38 .equ Ent_w, 	5	;; Width
                     0006    39 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    40 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    41 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    42 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    43 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    44 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    45 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    46 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    47 .equ Ent_state,	14	;; Entity enabled/disabled
                     000F    48 .equ Ent_clr, 	15	;; Entity color pattern
                     0010    49 .equ Ent_id, 	16	;; Numeric ID
                             50 
                     0002    51 .equ MAX_VEL_X, 2 
                     FFFFFFFE    52 .equ MIN_VEL_X, -2
                     0004    53 .equ MAX_VEL_Y, 4
                     FFFFFFFC    54 .equ MIN_VEL_Y, -4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                     0011     7 .equ Frisbee_effect_I, 17
                     0012     8 .equ Frisbee_effect_F, 18
                     0008     9 .equ std_eff, 08
                             10 ;; ====================================
                             11 ;; ====================================
                             12 ;; PUBLIC DATA
                             13 ;; ====================================
                             14 ;; ====================================
                             15 
                             16 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr
                             17 
   028B                      18 defineEntity frisbee, #0x0050-0x0002, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #1, #0x0F, #0
   0000                       1 	frisbee_data::
   028B 4E 00                 2 		frisbee_x:	.dw #0x0050-0x0002		;; X coordinate			(16 bits)
   028D 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   028F 08                    4 		frisbee_h:	.db #8		;; Height			(8 bits)
   0290 02                    5 		frisbee_w:	.db #2		;; Width			(8 bits)
   0291 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0293 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0295 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0297 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0299 01                   10 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   029A 0F                   11 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   029B 00                   12 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   029C 00 08                19 	frisbee_effect: .dw #0x0800									;; effect
                             20 
                             21 
                             22 
                             23 ;; ====================================
                             24 ;; ====================================
                             25 ;; PRIVATE DATA
                             26 ;; ====================================
                             27 ;; ====================================
                             28 
                             29 
                             30 ;; ====================================
                             31 ;; ====================================
                             32 ;; PUBLIC FUNCTIONS
                             33 ;; ====================================
                             34 ;; ====================================
                             35 
                             36 ;; =========================================
                             37 ;; Desactiva el frisbee
                             38 ;; Modifica A
                             39 ;; =========================================
   029E                      40 frisbee_setOff::
   029E 3E 00         [ 7]   41 	ld 	a, #0
   02A0 32 99 02      [13]   42 	ld 	(frisbee_state), a
   02A3 C9            [10]   43 	ret
                             44 
   02A4                      45 frisbee_erase::
   02A4 DD 21 8B 02   [14]   46 	ld 	ix, #frisbee_data
   02A8 CD 59 01      [17]   47 	call entityErase		;; Pintar cuadrado azul fondo
                             48 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   02AB C9            [10]   49 	ret
                             50 
                             51 
                             52 ;; ================================================
                             53 ;; Modifica el valor de la velocidad del frisbee
                             54 ;; 	en el eje X e Y, al recibido en HL y DE
                             55 ;; Recibe:
                             56 ;; 	HL <= X axis velocity
                             57 ;; 	DE <= Y axis velocity
                             58 ;; Modifica: HL, IX
                             59 ;; ================================================
   02AC                      60 frisbee_setVelocities::
   02AC DD 21 8B 02   [14]   61 	ld 	ix, #frisbee_data
   02B0 DD 74 06      [19]   62 	ld 	Ent_vx_I(ix), h
   02B3 DD 75 07      [19]   63 	ld 	Ent_vx_F(ix), l
   02B6 DD 72 08      [19]   64 	ld 	Ent_vy_I(ix), d
   02B9 DD 73 09      [19]   65 	ld 	Ent_vy_F(ix), e
   02BC C9            [10]   66 	ret
                             67 
                             68 
                             69 ;; ===========================================
                             70 ;; Modifica el valor del efecto del frisbee
                             71 ;; 	al recibido en HL
                             72 ;; Recibe:
                             73 ;; 	HL <= Effect value
                             74 ;; Modifica A
                             75 ;; ===========================================
   02BD                      76 frisbee_setEffect::
   02BD 22 9C 02      [16]   77 	ld 	(frisbee_effect), hl
   02C0 C9            [10]   78 	ret
                             79 
                             80 ;; =========================================
                             81 ;; Actualiza el estado del frisbee
                             82 ;; Modifica A
                             83 ;; =========================================
   02C1                      84 frisbee_update::
                             85 
   02C1 3A 99 02      [13]   86 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   02C4 FE 01         [ 7]   87 	cp 	#1
   02C6 20 0E         [12]   88 	jr 	nz, not_active		;; A != 1?
                             89 	
                             90 		;; Active
   02C8 DD 21 8B 02   [14]   91 		ld 	ix, #frisbee_data
   02CC CD E4 02      [17]   92 		call frisbee_applyEffect 	
   02CF CD 72 01      [17]   93 		call entityUpdatePhysics
   02D2 CD 18 02      [17]   94 		call entityUpdatePosition
                             95 		;; call moveLeft
   02D5 C9            [10]   96 		ret
                             97 
   02D6                      98 	not_active:
   02D6 3E 01         [ 7]   99 		ld 	a, #1
   02D8 32 99 02      [13]  100 		ld 	(frisbee_state), a
   02DB C9            [10]  101 	ret
                            102 
   02DC                     103 frisbee_draw::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            104 
   02DC DD 21 8B 02   [14]  105 	ld 	ix, #frisbee_data
   02E0 CD 3F 01      [17]  106 	call entityDraw 		;; Pintar cuadrado azul cian
                            107 
   02E3 C9            [10]  108 	ret
                            109 	
                            110 ;; ====================================
                            111 ;; ====================================
                            112 ;; PRIVATE FUNCTIONS
                            113 ;; ====================================
                            114 ;; ====================================
                            115 
                            116 
                            117 ;; ===========================================
                            118 ;; Mueve el frisbee a la izquierda un píxel
                            119 ;; Recibe:
                            120 ;; 	IX <= Pointer to entity data
                            121 ;; Modifica A
                            122 ;; ===========================================
   02E4                     123 frisbee_applyEffect:
                            124 
                            125 	;; vy' = vy + ay
   02E4 DD 66 08      [19]  126 	ld 	h, Ent_vy_I(ix)
   02E7 DD 6E 09      [19]  127 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   02EA DD 56 11      [19]  128 	ld 	d, Frisbee_effect_I(ix)
   02ED DD 5E 12      [19]  129 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            130 
   02F0 19            [11]  131 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
   02F1 7C            [ 4]  132 	ld 	a, h
   02F2 FE 04         [ 7]  133 	cp 	#MAX_VEL_Y
   02F4 F2 02 03      [10]  134 	jp 	p, cant_accelerate_y
                            135 		;; vy' < MIN_VEL_Y
   02F7 FE FC         [ 7]  136 		cp 	#MIN_VEL_Y
   02F9 FA 02 03      [10]  137 		jp 	m, cant_accelerate_y
                            138 			;; vy' > MIN_VEL_Y
                            139 			;; Can accelerate at Y axis
   02FC DD 74 08      [19]  140 			ld 	Ent_vy_I(ix), h
   02FF DD 75 09      [19]  141 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            142 
   0302                     143 	cant_accelerate_y:
                            144 
   0302 C9            [10]  145 	ret
                            146 
                            147 ;; =========================================
                            148 ;; Mueve el frisbee a la derecha un píxel
                            149 ;; Modifica A
                            150 ;; =========================================
   0303                     151 moveRight:
   0303 3A 8B 02      [13]  152 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   0306 FE 4D         [ 7]  153 	cp 	#80-3 			;; A == right_limit - frisbee_width?
   0308 28 04         [12]  154 	jr 	z, cant_move_right 		
   030A 3C            [ 4]  155 		inc 	a 		;; move right one pixel
   030B 32 8B 02      [13]  156 		ld 	(frisbee_x), a
   030E                     157 	cant_move_right:
   030E C9            [10]  158 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            159 
                            160 ;; =========================================
                            161 ;; Mueve el frisbee abajo un píxel
                            162 ;; Modifica A
                            163 ;; =========================================
   030F                     164 moveDown:
   030F 3A 8D 02      [13]  165 	ld 	a, (frisbee_y) 		;; A = frisbee_x
   0312 FE BC         [ 7]  166 	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
   0314 28 04         [12]  167 	jr 	z, cant_move_down 		
   0316 3C            [ 4]  168 		inc 	a 		;; move down one pixel
   0317 32 8D 02      [13]  169 		ld 	(frisbee_y), a
   031A                     170 	cant_move_down:
   031A C9            [10]  171 	ret
                            172 
                            173 ;; ===========================================
                            174 ;; Mueve el frisbee a la izquierda un píxel
                            175 ;; Recibe:
                            176 ;; 	IX <= Pointer to entity data
                            177 ;; Modifica A
                            178 ;; ===========================================
   031B                     179 moveLeft:
   031B DD 7E 00      [19]  180 	ld 	a, Ent_x_I(IX) 		;; A = frisbee_x
   031E FE 00         [ 7]  181 	cp 	#0 			;; A == left_limit?
   0320 20 07         [12]  182 	jr 	nz, can_move_left 
   0322 3E 4E         [ 7]  183 		ld 	a, #80-2 	;; restore initial position
   0324 DD 77 00      [19]  184 		ld 	Ent_x_I(IX), a
                            185 		;; ld 	a, #80
                            186 		;; ld 	(frisbee_y), a	
   0327 18 0C         [12]  187 		jr 	cant_move_left
   0329                     188 	can_move_left:	
   0329 DD 21 8B 02   [14]  189 		ld	ix, #frisbee_data
   032D DD 36 0A FF   [19]  190 		ld 	Ent_ax_I(ix), #-1
   0331 DD 36 0B 80   [19]  191 		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)
                            192 
   0335                     193 	cant_move_left:
   0335 C9            [10]  194 	ret
                            195 
                            196 ;; =========================================
                            197 ;; Mueve el frisbee arriba un píxel
                            198 ;; Modifica A
                            199 ;; =========================================
   0336                     200 moveUp:
   0336 3A 8D 02      [13]  201 	ld 	a, (frisbee_y) 		;; A = frisbee_y
   0339 FE 00         [ 7]  202 	cp 	#0 			;; A == top_limit?
   033B 28 04         [12]  203 	jr 	z, cant_move_up 		
   033D 3D            [ 4]  204 		dec 	a 		;; move up one pixel
   033E 32 8D 02      [13]  205 		ld 	(frisbee_y), a
   0341                     206 	cant_move_up:
   0341 C9            [10]  207 	ret
                            208 
                            209 ;; ================================================
                            210 ;; Pinta un cuadrado en pantalla del color elegido
                            211 ;; Entrada:
                            212 ;; 	A => Colour Pattern
                            213 ;; Modifica AF, BC, DE, HL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            214 ;; ================================================
   0342                     215 drawFrisbee:
   0342 F5            [11]  216 	push 	af 
   0343 11 00 C0      [10]  217 	ld 	de, #0xC000 		;; Video memory  pointer
   0346 3A 8B 02      [13]  218 	ld 	a, (frisbee_x) 
   0349 4F            [ 4]  219 	ld 	c, a			;; C = frisbee_x
   034A 3A 8D 02      [13]  220 	ld 	a, (frisbee_y) 
   034D 47            [ 4]  221 	ld 	b, a 			;; B = frisbee_y
   034E CD F1 05      [17]  222 	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer
                            223 
   0351 EB            [ 4]  224 	ex 	de, hl 			;; DE = frisbee screen pointer
   0352 F1            [10]  225 	pop 	af 			;; A = User selected colour
   0353 01 02 08      [10]  226 	ld 	bc, #0x0802		;; 8x8 píxeles
   0356 CD 44 05      [17]  227 	call cpct_drawSolidBox_asm
                            228 
   0359 C9            [10]  229 	ret
