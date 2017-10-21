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
   024C                      18 defineEntity frisbee, #0x0050-0x0002, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #1, #0x0F, #0
   0000                       1 	frisbee_data::
   024C 4E 00                 2 		frisbee_x:	.dw #0x0050-0x0002		;; X coordinate			(16 bits)
   024E 54 00                 3 		frisbee_y:	.dw #0x0054		;; Y coordinate			(16 bits)
   0250 08                    4 		frisbee_h:	.db #8		;; Height			(8 bits)
   0251 02                    5 		frisbee_w:	.db #2		;; Width			(8 bits)
   0252 FF 10                 6 		frisbee_vx:	.dw #0x10FF		;; Velocity at X axis 		(16 bits)
   0254 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0256 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0258 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   025A 01                   10 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   025B 0F                   11 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
   025C 00                   12 		frisbee_id:	.db #0		;; Numeric ID			(8 bits)
   025D 00 08                19 	frisbee_effect: .dw #0x0800									;; effect
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
   025F                      40 frisbee_setOff::
   025F 3E 00         [ 7]   41 	ld 	a, #0
   0261 32 5A 02      [13]   42 	ld 	(frisbee_state), a
   0264 C9            [10]   43 	ret
                             44 
   0265                      45 frisbee_erase::
   0265 DD 21 4C 02   [14]   46 	ld 	ix, #frisbee_data
   0269 CD 1A 01      [17]   47 	call entityErase		;; Pintar cuadrado azul fondo
                             48 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   026C C9            [10]   49 	ret
                             50 
                             51 
                             52 ;; ================================================
                             53 ;; Modifica el valor de la velocidad del frisbee
                             54 ;; 	en el eje X e Y, al recibido en HL y DE
                             55 ;; Recibe:
                             56 ;; 	HL <= X axis velocity
                             57 ;; 	DE <= Y axis velocity
                             58 ;; Modifica: HL
                             59 ;; ================================================
   026D                      60 frisbee_setVelocities::
   026D 22 52 02      [16]   61 	ld 	(frisbee_vx), hl
   0270 62            [ 4]   62 	ld 	h, d
   0271 6B            [ 4]   63 	ld 	l, e
   0272 22 54 02      [16]   64 	ld 	(frisbee_vy), hl
   0275 C9            [10]   65 	ret
                             66 
                             67 
                             68 ;; ===========================================
                             69 ;; Modifica el valor del efecto del frisbee
                             70 ;; 	al recibido en HL
                             71 ;; Recibe:
                             72 ;; 	HL <= Effect value
                             73 ;; Modifica A
                             74 ;; ===========================================
   0276                      75 frisbee_setEffect::
   0276 22 5D 02      [16]   76 	ld 	(frisbee_effect), hl
   0279 C9            [10]   77 	ret
                             78 
                             79 ;; =========================================
                             80 ;; Actualiza el estado del frisbee
                             81 ;; Modifica A
                             82 ;; =========================================
   027A                      83 frisbee_update::
                             84 
   027A 3A 5A 02      [13]   85 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   027D FE 01         [ 7]   86 	cp 	#1
   027F 20 0E         [12]   87 	jr 	nz, not_active		;; A != 1?
                             88 	
                             89 		;; Active
   0281 DD 21 4C 02   [14]   90 		ld 	ix, #frisbee_data
   0285 CD 9D 02      [17]   91 		call frisbee_applyEffect 	
   0288 CD 33 01      [17]   92 		call entityUpdatePhysics
   028B CD D9 01      [17]   93 		call entityUpdatePosition
                             94 		;; call moveLeft
   028E C9            [10]   95 		ret
                             96 
   028F                      97 	not_active:
   028F 3E 01         [ 7]   98 		ld 	a, #1
   0291 32 5A 02      [13]   99 		ld 	(frisbee_state), a
   0294 C9            [10]  100 	ret
                            101 
   0295                     102 frisbee_draw::
                            103 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0295 DD 21 4C 02   [14]  104 	ld 	ix, #frisbee_data
   0299 CD 00 01      [17]  105 	call entityDraw 		;; Pintar cuadrado azul cian
                            106 
   029C C9            [10]  107 	ret
                            108 	
                            109 ;; ====================================
                            110 ;; ====================================
                            111 ;; PRIVATE FUNCTIONS
                            112 ;; ====================================
                            113 ;; ====================================
                            114 
                            115 
                            116 ;; ===========================================
                            117 ;; Mueve el frisbee a la izquierda un píxel
                            118 ;; Recibe:
                            119 ;; 	IX <= Pointer to entity data
                            120 ;; Modifica A
                            121 ;; ===========================================
   029D                     122 frisbee_applyEffect:
                            123 
                            124 	;; vy' = vy + ay
   029D DD 66 08      [19]  125 	ld 	h, Ent_vy_I(ix)
   02A0 DD 6E 09      [19]  126 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   02A3 DD 56 11      [19]  127 	ld 	d, Frisbee_effect_I(ix)
   02A6 DD 5E 12      [19]  128 	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect
                            129 
   02A9 19            [11]  130 	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)
   02AA 7C            [ 4]  131 	ld 	a, h
   02AB FE 04         [ 7]  132 	cp 	#MAX_VEL_Y
   02AD F2 BB 02      [10]  133 	jp 	p, cant_accelerate_y
                            134 		;; vy' < MIN_VEL_Y
   02B0 FE FC         [ 7]  135 		cp 	#MIN_VEL_Y
   02B2 FA BB 02      [10]  136 		jp 	m, cant_accelerate_y
                            137 			;; vy' > MIN_VEL_Y
                            138 			;; Can accelerate at Y axis
   02B5 DD 74 08      [19]  139 			ld 	Ent_vy_I(ix), h
   02B8 DD 75 09      [19]  140 			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            141 
   02BB                     142 	cant_accelerate_y:
                            143 
   02BB C9            [10]  144 	ret
                            145 
                            146 ;; =========================================
                            147 ;; Mueve el frisbee a la derecha un píxel
                            148 ;; Modifica A
                            149 ;; =========================================
   02BC                     150 moveRight:
   02BC 3A 4C 02      [13]  151 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   02BF FE 4D         [ 7]  152 	cp 	#80-3 			;; A == right_limit - frisbee_width?
   02C1 28 04         [12]  153 	jr 	z, cant_move_right 		
   02C3 3C            [ 4]  154 		inc 	a 		;; move right one pixel
   02C4 32 4C 02      [13]  155 		ld 	(frisbee_x), a
   02C7                     156 	cant_move_right:
   02C7 C9            [10]  157 	ret
                            158 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            159 ;; =========================================
                            160 ;; Mueve el frisbee abajo un píxel
                            161 ;; Modifica A
                            162 ;; =========================================
   02C8                     163 moveDown:
   02C8 3A 4E 02      [13]  164 	ld 	a, (frisbee_y) 		;; A = frisbee_x
   02CB FE BC         [ 7]  165 	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
   02CD 28 04         [12]  166 	jr 	z, cant_move_down 		
   02CF 3C            [ 4]  167 		inc 	a 		;; move down one pixel
   02D0 32 4E 02      [13]  168 		ld 	(frisbee_y), a
   02D3                     169 	cant_move_down:
   02D3 C9            [10]  170 	ret
                            171 
                            172 ;; ===========================================
                            173 ;; Mueve el frisbee a la izquierda un píxel
                            174 ;; Recibe:
                            175 ;; 	IX <= Pointer to entity data
                            176 ;; Modifica A
                            177 ;; ===========================================
   02D4                     178 moveLeft:
   02D4 DD 7E 00      [19]  179 	ld 	a, Ent_x_I(IX) 		;; A = frisbee_x
   02D7 FE 00         [ 7]  180 	cp 	#0 			;; A == left_limit?
   02D9 20 07         [12]  181 	jr 	nz, can_move_left 
   02DB 3E 4E         [ 7]  182 		ld 	a, #80-2 	;; restore initial position
   02DD DD 77 00      [19]  183 		ld 	Ent_x_I(IX), a
                            184 		;; ld 	a, #80
                            185 		;; ld 	(frisbee_y), a	
   02E0 18 0C         [12]  186 		jr 	cant_move_left
   02E2                     187 	can_move_left:	
   02E2 DD 21 4C 02   [14]  188 		ld	ix, #frisbee_data
   02E6 DD 36 0A FF   [19]  189 		ld 	Ent_ax_I(ix), #-1
   02EA DD 36 0B 80   [19]  190 		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)
                            191 
   02EE                     192 	cant_move_left:
   02EE C9            [10]  193 	ret
                            194 
                            195 ;; =========================================
                            196 ;; Mueve el frisbee arriba un píxel
                            197 ;; Modifica A
                            198 ;; =========================================
   02EF                     199 moveUp:
   02EF 3A 4E 02      [13]  200 	ld 	a, (frisbee_y) 		;; A = frisbee_y
   02F2 FE 00         [ 7]  201 	cp 	#0 			;; A == top_limit?
   02F4 28 04         [12]  202 	jr 	z, cant_move_up 		
   02F6 3D            [ 4]  203 		dec 	a 		;; move up one pixel
   02F7 32 4E 02      [13]  204 		ld 	(frisbee_y), a
   02FA                     205 	cant_move_up:
   02FA C9            [10]  206 	ret
                            207 
                            208 ;; ================================================
                            209 ;; Pinta un cuadrado en pantalla del color elegido
                            210 ;; Entrada:
                            211 ;; 	A => Colour Pattern
                            212 ;; Modifica AF, BC, DE, HL
                            213 ;; ================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   02FB                     214 drawFrisbee:
   02FB F5            [11]  215 	push 	af 
   02FC 11 00 C0      [10]  216 	ld 	de, #0xC000 		;; Video memory  pointer
   02FF 3A 4C 02      [13]  217 	ld 	a, (frisbee_x) 
   0302 4F            [ 4]  218 	ld 	c, a			;; C = frisbee_x
   0303 3A 4E 02      [13]  219 	ld 	a, (frisbee_y) 
   0306 47            [ 4]  220 	ld 	b, a 			;; B = frisbee_y
   0307 CD 4E 05      [17]  221 	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer
                            222 
   030A EB            [ 4]  223 	ex 	de, hl 			;; DE = frisbee screen pointer
   030B F1            [10]  224 	pop 	af 			;; A = User selected colour
   030C 01 02 08      [10]  225 	ld 	bc, #0x0802		;; 8x8 píxeles
   030F CD A1 04      [17]  226 	call cpct_drawSolidBox_asm
                            227 
   0312 C9            [10]  228 	ret
