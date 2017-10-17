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
                             11 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, onOff, clr
                             12 	name'_data::
                             13 		name'_x:	.db x		;; X coordinate			(8 bits)
                             14 		name'_y:	.db y		;; Y coordinate			(8 bits)
                             15 		name'_h:	.db h		;; Height			(8 bits)
                             16 		name'_w:	.db w		;; Width			(8 bits)
                             17 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             18 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             19 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             20 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             21 		name'_onOff:	.db onOff	;; Entity enabled/disabled	(8 bits)
                             22 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             23 .endm
                             24 
                     0000    25 .equ Ent_x, 	0	;; X coordinate
                     0001    26 .equ Ent_y, 	1	;; Y coordinate
                     0002    27 .equ Ent_h, 	2	;; Height
                     0003    28 .equ Ent_w, 	3	;; Width
                     0004    29 .equ Ent_vx_I,	4	;; Velocity at X axis, integer part
                     0005    30 .equ Ent_vx_F,	5	;; Velocity at X axis, fractional part
                     0006    31 .equ Ent_vy_I,	6	;; Velocity at Y axis, integer part
                     0007    32 .equ Ent_vy_F,	7	;; Velocity at Y axis, fractional part
                     0008    33 .equ Ent_ax_I,	8	;; Acceleration at X axis, integer part
                     0009    34 .equ Ent_ax_F,	9	;; Acceleration at X axis, fractional part
                     000A    35 .equ Ent_ay_I,	10	;; Acceleration at Y axis, integer part
                     000B    36 .equ Ent_ay_F,	11	;; Acceleration at Y axis, fractional part
                     000C    37 .equ Ent_onOff,	12	;; Entity enabled/disabled
                     000D    38 .equ Ent_clr, 	13	;; Entity color pattern	
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
                             13 ;; .macro defineEntity name, x, y, h, w, vx, vy, ax, ay, onOff, clr
                             14 
   0205                      15 defineEntity frisbee, #80-2, #84, #8, #2, #0000, #0000, #0000, #0000, #1, #0x0F
   0000                       1 	frisbee_data::
   0205 4E                    2 		frisbee_x:	.db #80-2		;; X coordinate			(8 bits)
   0206 54                    3 		frisbee_y:	.db #84		;; Y coordinate			(8 bits)
   0207 08                    4 		frisbee_h:	.db #8		;; Height			(8 bits)
   0208 02                    5 		frisbee_w:	.db #2		;; Width			(8 bits)
   0209 00 00                 6 		frisbee_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   020B 00 00                 7 		frisbee_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   020D 00 00                 8 		frisbee_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   020F 00 00                 9 		frisbee_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0211 01                   10 		frisbee_onOff:	.db #1	;; Entity enabled/disabled	(8 bits)
   0212 0F                   11 		frisbee_clr:	.db #0x0F		;; Entity color pattern		(8 bits)
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
   0213                      28 frisbee_setOff::
   0213 3E 00         [ 7]   29 	ld 	a, #0
   0215 32 11 02      [13]   30 	ld 	(frisbee_onOff), a
   0218 C9            [10]   31 	ret
                             32 
   0219                      33 frisbee_erase::
   0219 DD 21 05 02   [14]   34 	ld 	ix, #frisbee_data
   021D CD 1A 01      [17]   35 	call entityErase		;; Pintar cuadrado azul fondo
                             36 
   0220 C9            [10]   37 	ret
                             38 
                             39 ;; =========================================
                             40 ;; Actualiza el estado del frisbee
                             41 ;; Modifica A
                             42 ;; =========================================
   0221                      43 frisbee_update::
                             44 
   0221 3A 11 02      [13]   45 	ld 	a, (frisbee_onOff)	;; A <= frisbee_onOff
   0224 FE 01         [ 7]   46 	cp 	#1
   0226 20 0B         [12]   47 	jr 	nz, not_active		;; A != 1?
                             48 	
                             49 		;; Active
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0228 DD 21 05 02   [14]   50 		ld 	ix, #frisbee_data
   022C CD 72 01      [17]   51 		call entityUpdatePhysics
                             52 
   022F CD 59 02      [17]   53 		call moveLeft
   0232 C9            [10]   54 		ret
                             55 
   0233                      56 	not_active:
   0233 3E 01         [ 7]   57 		ld 	a, #1
   0235 32 11 02      [13]   58 		ld 	(frisbee_onOff), a
   0238 C9            [10]   59 	ret
                             60 
   0239                      61 frisbee_draw::
                             62 
   0239 DD 21 05 02   [14]   63 	ld 	ix, #frisbee_data
   023D CD 00 01      [17]   64 	call entityDraw 		;; Pintar cuadrado azul cian
                             65 
   0240 C9            [10]   66 	ret
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
   0241                      78 moveRight:
   0241 3A 05 02      [13]   79 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   0244 FE 4D         [ 7]   80 	cp 	#80-3 			;; A == right_limit - frisbee_width?
   0246 28 04         [12]   81 	jr 	z, cant_move_right 		
   0248 3C            [ 4]   82 		inc 	a 		;; move right one pixel
   0249 32 05 02      [13]   83 		ld 	(frisbee_x), a
   024C                      84 	cant_move_right:
   024C C9            [10]   85 	ret
                             86 
                             87 ;; =========================================
                             88 ;; Mueve el frisbee abajo un píxel
                             89 ;; Modifica A
                             90 ;; =========================================
   024D                      91 moveDown:
   024D 3A 06 02      [13]   92 	ld 	a, (frisbee_y) 		;; A = frisbee_x
   0250 FE BC         [ 7]   93 	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
   0252 28 04         [12]   94 	jr 	z, cant_move_down 		
   0254 3C            [ 4]   95 		inc 	a 		;; move down one pixel
   0255 32 06 02      [13]   96 		ld 	(frisbee_y), a
   0258                      97 	cant_move_down:
   0258 C9            [10]   98 	ret
                             99 
                            100 ;; ===========================================
                            101 ;; Mueve el frisbee a la izquierda un píxel
                            102 ;; Modifica A
                            103 ;; ===========================================
   0259                     104 moveLeft:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0259 3A 05 02      [13]  105 	ld 	a, (frisbee_x) 		;; A = frisbee_x
   025C FE 00         [ 7]  106 	cp 	#0 			;; A == left_limit?
   025E 20 0C         [12]  107 	jr 	nz, can_move_left 
   0260 3E 4E         [ 7]  108 		ld 	a, #80-2 	;; restore initial position
   0262 32 05 02      [13]  109 		ld 	(frisbee_x), a
   0265 3E 50         [ 7]  110 		ld 	a, #80
   0267 32 06 02      [13]  111 		ld 	(frisbee_y), a	
   026A 18 0C         [12]  112 		jr 	cant_move_left
   026C                     113 	can_move_left:	
   026C DD 21 05 02   [14]  114 		ld	ix, #frisbee_data
   0270 DD 36 08 FF   [19]  115 		ld 	Ent_ax_I(ix), #-1
   0274 DD 36 09 80   [19]  116 		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)
                            117 
   0278                     118 	cant_move_left:
   0278 C9            [10]  119 	ret
                            120 
                            121 ;; =========================================
                            122 ;; Mueve el frisbee arriba un píxel
                            123 ;; Modifica A
                            124 ;; =========================================
   0279                     125 moveUp:
   0279 3A 06 02      [13]  126 	ld 	a, (frisbee_y) 		;; A = frisbee_y
   027C FE 00         [ 7]  127 	cp 	#0 			;; A == top_limit?
   027E 28 04         [12]  128 	jr 	z, cant_move_up 		
   0280 3D            [ 4]  129 		dec 	a 		;; move up one pixel
   0281 32 06 02      [13]  130 		ld 	(frisbee_y), a
   0284                     131 	cant_move_up:
   0284 C9            [10]  132 	ret
                            133 
                            134 ;; ================================================
                            135 ;; Pinta un cuadrado en pantalla del color elegido
                            136 ;; Entrada:
                            137 ;; 	A => Colour Pattern
                            138 ;; Modifica AF, BC, DE, HL
                            139 ;; ================================================
   0285                     140 drawFrisbee:
   0285 F5            [11]  141 	push 	af 
   0286 11 00 C0      [10]  142 	ld 	de, #0xC000 		;; Video memory  pointer
   0289 3A 05 02      [13]  143 	ld 	a, (frisbee_x) 
   028C 4F            [ 4]  144 	ld 	c, a			;; C = frisbee_x
   028D 3A 06 02      [13]  145 	ld 	a, (frisbee_y) 
   0290 47            [ 4]  146 	ld 	b, a 			;; B = frisbee_y
   0291 CD B6 04      [17]  147 	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer
                            148 
   0294 EB            [ 4]  149 	ex 	de, hl 			;; DE = frisbee screen pointer
   0295 F1            [10]  150 	pop 	af 			;; A = User selected colour
   0296 01 02 08      [10]  151 	ld 	bc, #0x0802		;; 8x8 píxeles
   0299 CD 09 04      [17]  152 	call cpct_drawSolidBox_asm
                            153 
   029C C9            [10]  154 	ret
