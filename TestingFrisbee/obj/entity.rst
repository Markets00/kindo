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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 
                              8 .macro defineGame name, type, map, time
                              9 	name'_data::
                             10 		name'_type:	.db type	;; Game Mode			(8 bits)
                             11 		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits)
                             12 		name'_time:	.dw time	;; Duration of each match	(16 bits)
                             13 .endm
                             14 
                     0000    15 .equ Game_type, 	0	;; Game mode
                     0001    16 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    17 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    18 .equ Game_time_H, 	3	;; High part of match time
                     0004    19 .equ Game_time_L, 	4	;; Low part of match time
                             20 
                     0050    21 .equ RIGHT_LIMIT,	80
                     0000    22 .equ LEFT_LIMIT,	0
                     0000    23 .equ TOP_LIMIT,	 	0
                     00C8    24 .equ BOTTOM_LIMIT,	200
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 
                     0000     6 .equ Ent_x, 	0	;; X coordinate
                     0001     7 .equ Ent_y, 	1	;; Y coordinate
                     0002     8 .equ Ent_h, 	2	;; Height
                     0003     9 .equ Ent_w, 	3	;; Width
                     0004    10 .equ Ent_vx_I,	4	;; Velocity at X axis, integer part
                     0005    11 .equ Ent_vx_F,	5	;; Velocity at X axis, fractional part
                     0006    12 .equ Ent_vy_I,	6	;; Velocity at Y axis, integer part
                     0007    13 .equ Ent_vy_F,	7	;; Velocity at Y axis, fractional part
                     0008    14 .equ Ent_ax_I,	8	;; Acceleration at X axis, integer part
                     0009    15 .equ Ent_ax_F,	9	;; Acceleration at X axis, fractional part
                     000A    16 .equ Ent_ay_I,	10	;; Acceleration at Y axis, integer part
                     000B    17 .equ Ent_ay_F,	11	;; Acceleration at Y axis, fractional part
                     000C    18 .equ Ent_onOff,	12	;; Entity enabled/disabled
                     000D    19 .equ Ent_clr, 	13	;; Entity color pattern
                             20 
                             21 
                             22 ;; ===================================
                             23 ;; Pinta una entidad en pantalla
                             24 ;; Entrada:
                             25 ;; 	IX => Pointer to entity data 
                             26 ;; Modifica AF, BC, DE, HL
                             27 ;; ===================================
   0100                      28 entityDraw::
   0100 11 00 C0      [10]   29 	ld 	de, #0xC000 		;; Video memory pointer
   0103 DD 4E 00      [19]   30 	ld 	c, Ent_x(ix) 		;; C = ent_x
   0106 DD 46 01      [19]   31 	ld 	b, Ent_y(ix) 		;; B = ent_y
   0109 CD B6 04      [17]   32 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             33 
   010C EB            [ 4]   34 	ex 	de, hl 			;; DE = ent screen pointer
   010D DD 46 02      [19]   35 	ld 	b, Ent_h(ix) 		;; B = ent height
   0110 DD 4E 03      [19]   36 	ld 	c, Ent_w(ix) 		;; C = ent width
   0113 DD 7E 0D      [19]   37 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0116 CD 09 04      [17]   38 	call cpct_drawSolidBox_asm
                             39 
   0119 C9            [10]   40 	ret
                             41 
                             42 ;; ===================================
                             43 ;; Borra una entidad de la pantalla
                             44 ;; Entrada:
                             45 ;; 	IX => Pointer to entity data 
                             46 ;; Modifica AF, BC, DE, HL
                             47 ;; ===================================
   011A                      48 entityErase::
   011A 11 00 C0      [10]   49 	ld 	de, #0xC000 		;; Video memory  pointer
   011D DD 4E 00      [19]   50 	ld 	c, 0(ix) 		;; C = ent_x
   0120 DD 46 01      [19]   51 	ld 	b, 1(ix) 		;; B = ent_y
   0123 CD B6 04      [17]   52 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             53 
   0126 EB            [ 4]   54 	ex 	de, hl 			;; DE = ent screen pointer
   0127 3E 00         [ 7]   55 	ld 	a, #0x00 		;; A = background color
   0129 DD 46 02      [19]   56 	ld 	b, Ent_h(ix) 		;; B = ent height
   012C DD 4E 03      [19]   57 	ld 	c, Ent_w(ix) 		;; C = ent width
   012F CD 09 04      [17]   58 	call cpct_drawSolidBox_asm
                             59 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0132 C9            [10]   60 	ret
                             61 
                             62 ;; =========================================
                             63 ;; Actualiza la posición de la entidad
                             64 ;; Entrada:
                             65 ;; 	IX => Pointer to entity data
                             66 ;; Modifica AF, B, DE, HL, IX
                             67 ;; =========================================
   0133                      68 entityUpdatePosition:
                             69 
                             70 	;; x = x + vx_I
   0133 DD 56 04      [19]   71 	ld 	d, Ent_vx_I(ix) 	;; D <= ent_vx_I
   0136 1E 00         [ 7]   72 	ld 	e, #0			;; E <= 0 (discard fractional part)
                             73 
   0138 DD 66 00      [19]   74 	ld 	h, Ent_x(ix) 		;; H <= Ent_x
   013B 2E 00         [ 7]   75 	ld 	l, #0			;; L <= 0 (discard fractional part)
                             76 
   013D 19            [11]   77 	add 	hl, de 			;; H <= H + D (x + vx_I)
                             78 
   013E 44            [ 4]   79 	ld 	b, h 			;; B <= H (x + vx_I)
   013F 3E 50         [ 7]   80 	ld 	a, #RIGHT_LIMIT
   0141 DD 96 03      [19]   81 	sub 	Ent_w(IX) 		;; A <= RIGHT_LIMIT - Ent_width
                             82 
   0144 B8            [ 4]   83 	cp 	b			;; F <= A - B
   0145 FA 51 01      [10]   84 	jp 	m, cant_move_x		;; RIGHT_LIMIT - Ent_width < x + vx_I? can't move
                             85 
   0148 3E 00         [ 7]   86 		ld 	a, #LEFT_LIMIT		;; A <= LEFT_LIMIT
   014A B8            [ 4]   87 		cp 	b 			;; F <= A - B
   014B F2 51 01      [10]   88 		jp 	p, cant_move_x		;; LIMIT_LEFT > x + vx_I? can't move
                             89 
                             90 			;; can move
   014E DD 74 00      [19]   91 			ld 	Ent_x(ix), h 		;; Ent_x <= H
                             92 
   0151                      93 	cant_move_x:
                             94 
                             95 
                             96 	;; y = y + vy_I*2
   0151 DD 66 06      [19]   97 	ld 	h, Ent_vy_I(ix) 	;; H <= ent_vy_I
   0154 DD 6E 07      [19]   98 	ld 	l, Ent_vy_F(ix)		;; L <= ent_vy_F
                             99 
   0157 DD 56 01      [19]  100 	ld 	d, Ent_y(ix) 		;; D <= Ent_y
   015A 1E 00         [ 7]  101 	ld 	e, #0			;; E <= 0 (discard fractional part)
                            102 
                            103 	;;add 	hl, hl 			;; H <= H(ent_vy_I)*2
                            104 					;; D <= ent_vy_I*2
   015C EB            [ 4]  105 	ex 	de, hl 			;; H <= Ent_y
                            106 
   015D 19            [11]  107 	add 	hl, de 			;; H <= H (y) + D (y + ent_vy_I*2)
                            108 
   015E 44            [ 4]  109 	ld 	b, h 			;; B <= H (y + ent_vy_I*2)
   015F 3E C8         [ 7]  110 	ld 	a, #BOTTOM_LIMIT
   0161 DD 96 02      [19]  111 	sub 	Ent_h(IX) 		;; A <= BOTTOM_LIMIT - Ent_height
                            112 
   0164 B8            [ 4]  113 	cp 	b			;; F <= A - B
   0165 FA 71 01      [10]  114 	jp 	m, cant_move_y		;; BOTTOM_LIMIT - Ent_height < y + ent_vy_I*2? can't move
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115 
   0168 3E 00         [ 7]  116 		ld 	a, #TOP_LIMIT		;; A <= TOP_LIMIT
   016A B8            [ 4]  117 		cp 	b 			;; F <= A - B
   016B F2 71 01      [10]  118 		jp 	p, cant_move_y		;; TOP_LIMIT > y + ent_vy_I*2? can't move
                            119 
                            120 			;; can move
   016E DD 74 01      [19]  121 			ld 	Ent_y(ix), h 		;; Ent_y <= H
                            122 
   0171                     123 	cant_move_y:
                            124 
   0171 C9            [10]  125 		ret
                            126 
                            127 ;; =========================================
                            128 ;; Actualiza el estado de las físicas
                            129 ;; 	de una entidad
                            130 ;; Entrada:
                            131 ;; 	IX => Pointer to entity data
                            132 ;; Modifica F, DE, HL, IX
                            133 ;; =========================================
   0172                     134 entityUpdatePhysics::
                            135 	;; vx = vx + ax
   0172 DD 66 04      [19]  136 	ld 	h, Ent_vx_I(ix)
   0175 DD 6E 05      [19]  137 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0178 DD 56 08      [19]  138 	ld 	d, Ent_ax_I(ix)
   017B DD 5E 09      [19]  139 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            140 
   017E 19            [11]  141 	add 	hl, de 			;; HL <= HL + DE
   017F DD 74 04      [19]  142 	ld 	Ent_vx_I(ix), h
   0182 DD 75 05      [19]  143 	ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            144 
                            145 
                            146 	;; vy = vy + ay
   0185 DD 66 06      [19]  147 	ld 	h, Ent_vy_I(ix)
   0188 DD 6E 07      [19]  148 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   018B DD 56 0A      [19]  149 	ld 	d, Ent_ay_I(ix)
   018E DD 5E 0B      [19]  150 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            151 
   0191 19            [11]  152 	add 	hl, de 			;; HL <= HL + DE
   0192 DD 74 06      [19]  153 	ld 	Ent_vy_I(ix), h
   0195 DD 75 07      [19]  154 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            155 
                            156 
   0198 DD 36 08 00   [19]  157 	ld 	Ent_ax_I(ix), #0	;; 
   019C DD 36 09 00   [19]  158 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   01A0 DD 36 0A 00   [19]  159 	ld 	Ent_ay_I(ix), #0	;; 
   01A4 DD 36 0B 00   [19]  160 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            161 
   01A8 CD 33 01      [17]  162 	call entityUpdatePosition
                            163 
                            164 	;; ld 	Ent_vx_I(ix), #0	;; 
                            165 	;; ld 	Ent_vx_F(ix), #0	;; vx = 0
                            166 	;; ld 	Ent_vy_I(ix), #0	;; 
                            167 	;; ld 	Ent_vy_F(ix), #0	;; vy = 0
                            168 
   01AB C9            [10]  169 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            170 
                            171 ;; =========================================
                            172 ;; Comprueba si existe colision entre
                            173 ;; dos entidades.
                            174 ;; Entrada:
                            175 ;; 	IX => Pointer to entity 1 data
                            176 ;; 	HL => Pointer to entity 2 data
                            177 ;; Modifica AF, B, HL, IX
                            178 ;; Devuelve:
                            179 ;; 	A <==== 0 si no hay colisión, y la
                            180 ;; 		diferencia absoluta entre
                            181 ;;		las x, en caso de colisión
                            182 ;; =========================================
   01AC 00 00               183 ent1_ptr: .dw #0000
   01AE 00 00               184 ent2_ptr: .dw #0000
   01B0                     185 entityCheckCollision::
                            186 	;;
                            187 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            188 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            189 	;;
   01B0 DD 22 AC 01   [20]  190 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   01B4 22 AE 01      [16]  191 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            192 
   01B7 DD 7E 00      [19]  193 	ld 	a, Ent_x(ix)		;; A <= ent1_x
   01BA DD 86 03      [19]  194 	add 	Ent_w(ix)		;; A <= A + ent1_w
   01BD DD 2A AE 01   [20]  195 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   01C1 DD 96 00      [19]  196 	sub 	Ent_x(ix)		;; A <= A - ent2_x
   01C4 F2 C9 01      [10]  197 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            198 
   01C7 18 39         [12]  199 	jr 	no_collision
                            200 
                            201 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   01C9                     202 	collision_XR:
                            203 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   01C9 47            [ 4]  204 		ld 	b, a 		;; B <= A
                            205 		;;
                            206 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            207 		;; ent2_x + ent2_w - ent1_x <= 0
                            208 		;; 
   01CA DD 7E 00      [19]  209 		ld 	a, Ent_x(ix)		;; A <= ent2_x
   01CD DD 86 03      [19]  210 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   01D0 DD 2A AC 01   [20]  211 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01D4 DD 96 00      [19]  212 		sub 	Ent_x(ix)		;; A <= A - ent1_x
   01D7 F2 DC 01      [10]  213 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            214 
   01DA 18 26         [12]  215 		jr 	no_collision
                            216 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   01DC                     217 	collision_XL:
                            218 		;;
                            219 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            220 		;; ent1_y + ent1_h - ent2_y <= 0
                            221 		;;
   01DC DD 7E 01      [19]  222 		ld 	a, Ent_y(ix)		;; A <= ent1_x
   01DF DD 86 02      [19]  223 		add 	Ent_h(ix)		;; A <= A + ent1_w
   01E2 DD 2A AE 01   [20]  224 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   01E6 DD 96 01      [19]  225 		sub 	Ent_y(ix)		;; A <= A - ent2_x
   01E9 F2 EE 01      [10]  226 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            227 
   01EC 18 14         [12]  228 		jr 	no_collision
                            229 
                            230 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   01EE                     231 	collision_YB:
                            232 		;;
                            233 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            234 		;; ent2_y + ent2_h - ent1_y <= 0
                            235 		;; 
   01EE DD 7E 01      [19]  236 		ld 	a, Ent_y(ix)		;; A <= ent2_y
   01F1 DD 86 02      [19]  237 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   01F4 DD 2A AC 01   [20]  238 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01F8 DD 96 01      [19]  239 		sub 	Ent_y(ix)		;; A <= A - ent1_y
   01FB F2 00 02      [10]  240 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            241 
   01FE 18 02         [12]  242 		jr 	no_collision
                            243 
                            244 	;; Hay colisión en el eje Y, , ent2 está entre arriba y abajo de ent1
   0200                     245 	collision_YT:
                            246 
                            247 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0200 78            [ 4]  248 	ld 	a, b
                            249 
   0201 C9            [10]  250 	ret
                            251 
   0202                     252 	no_collision:
   0202 3E 00         [ 7]  253 	ld 	a, #0 	;; A == 0 si no hay colisión
   0204 C9            [10]  254 	ret
