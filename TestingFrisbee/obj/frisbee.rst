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
                             10 
                             11 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr
                             12 	name'_data::
                             13 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             14 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             15 		name'_h:	.db h		;; Height			(8 bits)
                             16 		name'_w:	.db w		;; Width			(8 bits)
                             17 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             18 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             19 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             20 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             21 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             22 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             23 .endm
                             24 
                             25 
                             26 ;; ====================================
                             27 ;; ====================================
                             28 ;; ENTITY PUBLIC DATA
                             29 ;; ====================================
                             30 ;; ====================================
                     0000    31 .equ Ent_x_I, 	0	;; X coordinate, high part
                     0001    32 .equ Ent_x_F, 	1	;; X coordinate, low part
                     0002    33 .equ Ent_y_I, 	2	;; Y coordinate, high part
                     0003    34 .equ Ent_y_F, 	3	;; Y coordinate, low part
                     0004    35 .equ Ent_h, 	4	;; Height
                     0005    36 .equ Ent_w, 	5	;; Width
                     0006    37 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    38 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    39 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    40 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    41 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    42 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    43 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    44 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    45 .equ Ent_state,	14	;; Entity enabled/disabled
                     000F    46 .equ Ent_clr, 	15	;; Entity color pattern
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
                              7 ;; ====================================
                              8 ;; ====================================
                              9 ;; PRIVATE DATA
                             10 ;; ====================================
                             11 ;; ====================================
                             12 
                             13 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr
                             14 
   0224                      15 defineEntity frisbee, #0x5000-0x200, #0x5400, #8, #2, #0000, #0000, #0000, #0000, #1, #0x0F
   0000                       1 	frisbee_data::
   0224 00 4E                 2 		frisbee_x:	.dw #0x5000-0x200		;; X coordinate			(16 bits)
   0226 00 54                 3 		frisbee_y:	.dw #0x5400		;; Y coordinate			(16 bits)
   0228 08                    4 		frisbee_h:	.db #8		;; Height			(8 bits)
   0229 02                    5 		frisbee_w:	.db #2		;; Width			(8 bits)
   022A 00 00                 6 		frisbee_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   022C 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   022E 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0230 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0232 01                   10 		frisbee_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0233 0F                   11 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
                             16 
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; PUBLIC FUNCTIONS
                             21 ;; ====================================
                             22 ;; ====================================
                             23 
                             24 ;; =========================================
                             25 ;; Desactiva el frisbee
                             26 ;; Modifica A
                             27 ;; =========================================
   0234                      28 frisbee_setOff::
   0234 3E 00         [ 7]   29 	ld 	a, #0
   0236 32 32 02      [13]   30 	ld 	(frisbee_state), a
   0239 C9            [10]   31 	ret
                             32 
   023A                      33 frisbee_erase::
   023A DD 21 24 02   [14]   34 	ld 	ix, #frisbee_data
   023E CD 1A 01      [17]   35 	call entityErase		;; Pintar cuadrado azul fondo
                             36 
   0241 C9            [10]   37 	ret
                             38 
                             39 ;; =========================================
                             40 ;; Actualiza el estado del frisbee
                             41 ;; Modifica A
                             42 ;; =========================================
   0242                      43 frisbee_update::
                             44 
   0242 3A 32 02      [13]   45 	ld 	a, (frisbee_state)	;; A <= frisbee_state
   0245 FE 01         [ 7]   46 	cp 	#1
   0247 20 0B         [12]   47 	jr 	nz, not_active		;; A != 1?
                             48 	
                             49 		;; Active
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0249 DD 21 24 02   [14]   50 		ld 	ix, #frisbee_data
   024D CD 33 01      [17]   51 		call entityUpdatePhysics
                             52 
   0250 CD 7A 02      [17]   53 		call moveLeft
   0253 C9            [10]   54 		ret
                             55 
   0254                      56 	not_active:
   0254 3E 01         [ 7]   57 		ld 	a, #1
   0256 32 32 02      [13]   58 		ld 	(frisbee_state), a
   0259 C9            [10]   59 	ret
                             60 
   025A                      61 frisbee_draw::
                             62 
   025A DD 21 24 02   [14]   63 	ld 	ix, #frisbee_data
   025E CD 00 01      [17]   64 	call entityDraw 		;; Pintar cuadrado azul cian
                             65 
   0261 C9            [10]   66 	ret
                             67 	
                             68 ;; ====================================
                             69 ;; ====================================
                             70 ;; PRIVATE FUNCTIONS
                             71 ;; ====================================
                             72 ;; ====================================
                             73 
                             74 ;; =========================================
                             75 ;; Mueve el frisbee a la derecha un píxel
                             76 ;; Modifica A
                             77 ;; =========================================
   0262                      78 moveRight:
   0262 3A 24 02      [13]   79 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   0265 FE 4D         [ 7]   80 	cp 	#80-3 			;; A == right_limit - frisbee_width?
   0267 28 04         [12]   81 	jr 	z, cant_move_right 		
   0269 3C            [ 4]   82 		inc 	a 		;; move right one pixel
   026A 32 24 02      [13]   83 		ld 	(frisbee_x), a
   026D                      84 	cant_move_right:
   026D C9            [10]   85 	ret
                             86 
                             87 ;; =========================================
                             88 ;; Mueve el frisbee abajo un píxel
                             89 ;; Modifica A
                             90 ;; =========================================
   026E                      91 moveDown:
   026E 3A 26 02      [13]   92 	ld 	a, (frisbee_y) 		;; A = frisbee_x
   0271 FE BC         [ 7]   93 	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
   0273 28 04         [12]   94 	jr 	z, cant_move_down 		
   0275 3C            [ 4]   95 		inc 	a 		;; move down one pixel
   0276 32 26 02      [13]   96 		ld 	(frisbee_y), a
   0279                      97 	cant_move_down:
   0279 C9            [10]   98 	ret
                             99 
                            100 ;; ===========================================
                            101 ;; Mueve el frisbee a la izquierda un píxel
                            102 ;; Modifica A
                            103 ;; ===========================================
   027A                     104 moveLeft:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   027A 3A 24 02      [13]  105 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   027D FE 00         [ 7]  106 	cp 	#0 			;; A == left_limit?
   027F 20 0C         [12]  107 	jr 	nz, can_move_left 
   0281 3E 4E         [ 7]  108 		ld 	a, #80-2 	;; restore initial position
   0283 32 24 02      [13]  109 		ld 	(frisbee_x), a
   0286 3E 50         [ 7]  110 		ld 	a, #80
   0288 32 26 02      [13]  111 		ld 	(frisbee_y), a	
   028B 18 0C         [12]  112 		jr 	cant_move_left
   028D                     113 	can_move_left:	
   028D DD 21 24 02   [14]  114 		ld	ix, #frisbee_data
   0291 DD 36 0A FF   [19]  115 		ld 	Ent_ax_I(ix), #-1
   0295 DD 36 0B 80   [19]  116 		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)
                            117 
   0299                     118 	cant_move_left:
   0299 C9            [10]  119 	ret
                            120 
                            121 ;; =========================================
                            122 ;; Mueve el frisbee arriba un píxel
                            123 ;; Modifica A
                            124 ;; =========================================
   029A                     125 moveUp:
   029A 3A 26 02      [13]  126 	ld 	a, (frisbee_y) 		;; A = frisbee_y
   029D FE 00         [ 7]  127 	cp 	#0 			;; A == top_limit?
   029F 28 04         [12]  128 	jr 	z, cant_move_up 		
   02A1 3D            [ 4]  129 		dec 	a 		;; move up one pixel
   02A2 32 26 02      [13]  130 		ld 	(frisbee_y), a
   02A5                     131 	cant_move_up:
   02A5 C9            [10]  132 	ret
                            133 
                            134 ;; ================================================
                            135 ;; Pinta un cuadrado en pantalla del color elegido
                            136 ;; Entrada:
                            137 ;; 	A => Colour Pattern
                            138 ;; Modifica AF, BC, DE, HL
                            139 ;; ================================================
   02A6                     140 drawFrisbee:
   02A6 F5            [11]  141 	push 	af 
   02A7 11 00 C0      [10]  142 	ld 	de, #0xC000 		;; Video memory  pointer
   02AA 3A 24 02      [13]  143 	ld 	a, (frisbee_x) 
   02AD 4F            [ 4]  144 	ld 	c, a			;; C = frisbee_x
   02AE 3A 26 02      [13]  145 	ld 	a, (frisbee_y) 
   02B1 47            [ 4]  146 	ld 	b, a 			;; B = frisbee_y
   02B2 CD EE 04      [17]  147 	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer
                            148 
   02B5 EB            [ 4]  149 	ex 	de, hl 			;; DE = frisbee screen pointer
   02B6 F1            [10]  150 	pop 	af 			;; A = User selected colour
   02B7 01 02 08      [10]  151 	ld 	bc, #0x0802		;; 8x8 píxeles
   02BA CD 41 04      [17]  152 	call cpct_drawSolidBox_asm
                            153 
   02BD C9            [10]  154 	ret
