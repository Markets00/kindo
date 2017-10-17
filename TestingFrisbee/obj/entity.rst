ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     0050     1 RIGHT_LIMIT  	= 80
                     0000     2 LEFT_LIMIT 	= 0
                     0000     3 TOP_LIMIT 	= 0
                     00C8     4 BOTTOM_LIMIT 	= 200
                              5 
                              6 .area _DATA
                              7 .area _CODE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              8 .include "utility.h.s"
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



                              9 
                     0000    10 .equ Ent_x, 	0	;; X coordinate
                     0001    11 .equ Ent_y, 	1	;; Y coordinate
                     0002    12 .equ Ent_h, 	2	;; Height
                     0003    13 .equ Ent_w, 	3	;; Width
                     0004    14 .equ Ent_vx_I,	4	;; Velocity at X axis, integer part
                     0005    15 .equ Ent_vx_F,	5	;; Velocity at X axis, fractional part
                     0006    16 .equ Ent_vy_I,	6	;; Velocity at Y axis, integer part
                     0007    17 .equ Ent_vy_F,	7	;; Velocity at Y axis, fractional part
                     0008    18 .equ Ent_ax_I,	8	;; Acceleration at X axis, integer part
                     0009    19 .equ Ent_ax_F,	9	;; Acceleration at X axis, fractional part
                     000A    20 .equ Ent_ay_I,	10	;; Acceleration at Y axis, integer part
                     000B    21 .equ Ent_ay_F,	11	;; Acceleration at Y axis, fractional part
                     000C    22 .equ Ent_onOff,	12	;; Entity enabled/disabled
                     000D    23 .equ Ent_clr, 	13	;; Entity color pattern
                             24 
                             25 
                             26 ;; ===================================
                             27 ;; Pinta una entidad en pantalla
                             28 ;; Entrada:
                             29 ;; 	IX => Pointer to entity data 
                             30 ;; Modifica AF, BC, DE, HL
                             31 ;; ===================================
   0100                      32 entityDraw::
   0100 11 00 C0      [10]   33 	ld 	de, #0xC000 		;; Video memory pointer
   0103 DD 4E 00      [19]   34 	ld 	c, Ent_x(ix) 		;; C = ent_x
   0106 DD 46 01      [19]   35 	ld 	b, Ent_y(ix) 		;; B = ent_y
   0109 CD B6 04      [17]   36 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             37 
   010C EB            [ 4]   38 	ex 	de, hl 			;; DE = ent screen pointer
   010D DD 46 02      [19]   39 	ld 	b, Ent_h(ix) 		;; B = ent height
   0110 DD 4E 03      [19]   40 	ld 	c, Ent_w(ix) 		;; C = ent width
   0113 DD 7E 0D      [19]   41 	ld 	a, Ent_clr(ix)		;; A = ent colour
   0116 CD 09 04      [17]   42 	call cpct_drawSolidBox_asm
                             43 
   0119 C9            [10]   44 	ret
                             45 
                             46 ;; ===================================
                             47 ;; Borra una entidad de la pantalla
                             48 ;; Entrada:
                             49 ;; 	IX => Pointer to entity data 
                             50 ;; Modifica AF, BC, DE, HL
                             51 ;; ===================================
   011A                      52 entityErase::
   011A 11 00 C0      [10]   53 	ld 	de, #0xC000 		;; Video memory  pointer
   011D DD 4E 00      [19]   54 	ld 	c, 0(ix) 		;; C = ent_x
   0120 DD 46 01      [19]   55 	ld 	b, 1(ix) 		;; B = ent_y
   0123 CD B6 04      [17]   56 	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer
                             57 
   0126 EB            [ 4]   58 	ex 	de, hl 			;; DE = ent screen pointer
   0127 3E 00         [ 7]   59 	ld 	a, #0x00 		;; A = background color
   0129 DD 46 02      [19]   60 	ld 	b, Ent_h(ix) 		;; B = ent height
   012C DD 4E 03      [19]   61 	ld 	c, Ent_w(ix) 		;; C = ent width
   012F CD 09 04      [17]   62 	call cpct_drawSolidBox_asm
                             63 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   0132 C9            [10]   64 	ret
                             65 
                             66 ;; =========================================
                             67 ;; Actualiza la posición de la entidad
                             68 ;; Entrada:
                             69 ;; 	IX => Pointer to entity data
                             70 ;; Modifica AF, B, DE, HL, IX
                             71 ;; =========================================
   0133                      72 entityUpdatePosition:
                             73 
                             74 	;; x = x + vx_I
   0133 DD 56 04      [19]   75 	ld 	d, Ent_vx_I(ix) 	;; D <= ent_vx_I
   0136 1E 00         [ 7]   76 	ld 	e, #0			;; E <= 0 (discard fractional part)
                             77 
   0138 DD 66 00      [19]   78 	ld 	h, Ent_x(ix) 		;; H <= Ent_x
   013B 2E 00         [ 7]   79 	ld 	l, #0			;; L <= 0 (discard fractional part)
                             80 
   013D 19            [11]   81 	add 	hl, de 			;; H <= H + D (x + vx_I)
                             82 
   013E 44            [ 4]   83 	ld 	b, h 			;; B <= H (x + vx_I)
   013F 3E 50         [ 7]   84 	ld 	a, #RIGHT_LIMIT
   0141 DD 96 03      [19]   85 	sub 	Ent_w(IX) 		;; A <= RIGHT_LIMIT - Ent_width
                             86 
   0144 B8            [ 4]   87 	cp 	b			;; F <= A - B
   0145 FA 51 01      [10]   88 	jp 	m, cant_move_x		;; RIGHT_LIMIT - Ent_width < x + vx_I? can't move
                             89 
   0148 3E 00         [ 7]   90 		ld 	a, #LEFT_LIMIT		;; A <= LEFT_LIMIT
   014A B8            [ 4]   91 		cp 	b 			;; F <= A - B
   014B F2 51 01      [10]   92 		jp 	p, cant_move_x		;; LIMIT_LEFT > x + vx_I? can't move
                             93 
                             94 			;; can move
   014E DD 74 00      [19]   95 			ld 	Ent_x(ix), h 		;; Ent_x <= H
                             96 
   0151                      97 	cant_move_x:
                             98 
                             99 
                            100 	;; y = y + vy_I*2
   0151 DD 66 06      [19]  101 	ld 	h, Ent_vy_I(ix) 	;; H <= ent_vy_I
   0154 DD 6E 07      [19]  102 	ld 	l, Ent_vy_F(ix)		;; L <= ent_vy_F
                            103 
   0157 DD 56 01      [19]  104 	ld 	d, Ent_y(ix) 		;; D <= Ent_y
   015A 1E 00         [ 7]  105 	ld 	e, #0			;; E <= 0 (discard fractional part)
                            106 
                            107 	;;add 	hl, hl 			;; H <= H(ent_vy_I)*2
                            108 					;; D <= ent_vy_I*2
   015C EB            [ 4]  109 	ex 	de, hl 			;; H <= Ent_y
                            110 
   015D 19            [11]  111 	add 	hl, de 			;; H <= H (y) + D (y + ent_vy_I*2)
                            112 
   015E 44            [ 4]  113 	ld 	b, h 			;; B <= H (y + ent_vy_I*2)
   015F 3E C8         [ 7]  114 	ld 	a, #BOTTOM_LIMIT
   0161 DD 96 02      [19]  115 	sub 	Ent_h(IX) 		;; A <= BOTTOM_LIMIT - Ent_height
                            116 
   0164 B8            [ 4]  117 	cp 	b			;; F <= A - B
   0165 FA 71 01      [10]  118 	jp 	m, cant_move_y		;; BOTTOM_LIMIT - Ent_height < y + ent_vy_I*2? can't move
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            119 
   0168 3E 00         [ 7]  120 		ld 	a, #TOP_LIMIT		;; A <= TOP_LIMIT
   016A B8            [ 4]  121 		cp 	b 			;; F <= A - B
   016B F2 71 01      [10]  122 		jp 	p, cant_move_y		;; TOP_LIMIT > y + ent_vy_I*2? can't move
                            123 
                            124 			;; can move
   016E DD 74 01      [19]  125 			ld 	Ent_y(ix), h 		;; Ent_y <= H
                            126 
   0171                     127 	cant_move_y:
                            128 
   0171 C9            [10]  129 		ret
                            130 
                            131 ;; =========================================
                            132 ;; Actualiza el estado de las físicas
                            133 ;; 	de una entidad
                            134 ;; Entrada:
                            135 ;; 	IX => Pointer to entity data
                            136 ;; Modifica F, DE, HL, IX
                            137 ;; =========================================
   0172                     138 entityUpdatePhysics::
                            139 	;; vx = vx + ax
   0172 DD 66 04      [19]  140 	ld 	h, Ent_vx_I(ix)
   0175 DD 6E 05      [19]  141 	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
   0178 DD 56 08      [19]  142 	ld 	d, Ent_ax_I(ix)
   017B DD 5E 09      [19]  143 	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax
                            144 
   017E 19            [11]  145 	add 	hl, de 			;; HL <= HL + DE
   017F DD 74 04      [19]  146 	ld 	Ent_vx_I(ix), h
   0182 DD 75 05      [19]  147 	ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL
                            148 
                            149 
                            150 	;; vy = vy + ay
   0185 DD 66 06      [19]  151 	ld 	h, Ent_vy_I(ix)
   0188 DD 6E 07      [19]  152 	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
   018B DD 56 0A      [19]  153 	ld 	d, Ent_ay_I(ix)
   018E DD 5E 0B      [19]  154 	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay
                            155 
   0191 19            [11]  156 	add 	hl, de 			;; HL <= HL + DE
   0192 DD 74 06      [19]  157 	ld 	Ent_vy_I(ix), h
   0195 DD 75 07      [19]  158 	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL
                            159 
                            160 
   0198 DD 36 08 00   [19]  161 	ld 	Ent_ax_I(ix), #0	;; 
   019C DD 36 09 00   [19]  162 	ld 	Ent_ax_F(ix), #0	;; ax = 0
   01A0 DD 36 0A 00   [19]  163 	ld 	Ent_ay_I(ix), #0	;; 
   01A4 DD 36 0B 00   [19]  164 	ld 	Ent_ay_F(ix), #0	;; ay = 0
                            165 
   01A8 CD 33 01      [17]  166 	call entityUpdatePosition
                            167 
                            168 	;; ld 	Ent_vx_I(ix), #0	;; 
                            169 	;; ld 	Ent_vx_F(ix), #0	;; vx = 0
                            170 	;; ld 	Ent_vy_I(ix), #0	;; 
                            171 	;; ld 	Ent_vy_F(ix), #0	;; vy = 0
                            172 
   01AB C9            [10]  173 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            174 
                            175 ;; =========================================
                            176 ;; Comprueba si existe colision entre
                            177 ;; dos entidades.
                            178 ;; Entrada:
                            179 ;; 	IX => Pointer to entity 1 data
                            180 ;; 	HL => Pointer to entity 2 data
                            181 ;; Modifica AF, B, HL, IX
                            182 ;; Devuelve:
                            183 ;; 	A <==== 0 si no hay colisión, y la
                            184 ;; 		diferencia absoluta entre
                            185 ;;		las x, en caso de colisión
                            186 ;; =========================================
   01AC 00 00               187 ent1_ptr: .dw #0000
   01AE 00 00               188 ent2_ptr: .dw #0000
   01B0                     189 entityCheckCollision::
                            190 	;;
                            191 	;; If (ent1_x + ent1_w <= ent2_x) no collision
                            192 	;; ent1_x + ent1_w - ent2_x <= 0  no collision
                            193 	;;
   01B0 DD 22 AC 01   [20]  194 	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
   01B4 22 AE 01      [16]  195 	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL
                            196 
   01B7 DD 7E 00      [19]  197 	ld 	a, Ent_x(ix)		;; A <= ent1_x
   01BA DD 86 03      [19]  198 	add 	Ent_w(ix)		;; A <= A + ent1_w
   01BD DD 2A AE 01   [20]  199 	ld 	ix, (ent2_ptr)		;; IX <= ent 2
   01C1 DD 96 00      [19]  200 	sub 	Ent_x(ix)		;; A <= A - ent2_x
   01C4 F2 C9 01      [10]  201 	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0
                            202 
   01C7 18 39         [12]  203 	jr 	no_collision
                            204 
                            205 	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
   01C9                     206 	collision_XR:
                            207 		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
   01C9 47            [ 4]  208 		ld 	b, a 		;; B <= A
                            209 		;;
                            210 		;; If (ent2_x + ent2_w <= ent1_x) no collision
                            211 		;; ent2_x + ent2_w - ent1_x <= 0
                            212 		;; 
   01CA DD 7E 00      [19]  213 		ld 	a, Ent_x(ix)		;; A <= ent2_x
   01CD DD 86 03      [19]  214 		add 	Ent_w(ix) 		;; A <= A + ent2_w
   01D0 DD 2A AC 01   [20]  215 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01D4 DD 96 00      [19]  216 		sub 	Ent_x(ix)		;; A <= A - ent1_x
   01D7 F2 DC 01      [10]  217 		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0
                            218 
   01DA 18 26         [12]  219 		jr 	no_collision
                            220 	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
   01DC                     221 	collision_XL:
                            222 		;;
                            223 		;; If (ent1_y + ent1_h <= ent2_y) no collision
                            224 		;; ent1_y + ent1_h - ent2_y <= 0
                            225 		;;
   01DC DD 7E 01      [19]  226 		ld 	a, Ent_y(ix)		;; A <= ent1_x
   01DF DD 86 02      [19]  227 		add 	Ent_h(ix)		;; A <= A + ent1_w
   01E2 DD 2A AE 01   [20]  228 		ld 	ix, (ent2_ptr)		;; IX <= ent 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   01E6 DD 96 01      [19]  229 		sub 	Ent_y(ix)		;; A <= A - ent2_x
   01E9 F2 EE 01      [10]  230 		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0
                            231 
   01EC 18 14         [12]  232 		jr 	no_collision
                            233 
                            234 	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
   01EE                     235 	collision_YB:
                            236 		;;
                            237 		;; If (ent2_y + ent2_h <= ent1_y) no collision
                            238 		;; ent2_y + ent2_h - ent1_y <= 0
                            239 		;; 
   01EE DD 7E 01      [19]  240 		ld 	a, Ent_y(ix)		;; A <= ent2_y
   01F1 DD 86 02      [19]  241 		add 	Ent_h(ix) 		;; A <= A + ent2_h
   01F4 DD 2A AC 01   [20]  242 		ld 	ix, (ent1_ptr)		;; IX <= ent 1
   01F8 DD 96 01      [19]  243 		sub 	Ent_y(ix)		;; A <= A - ent1_y
   01FB F2 00 02      [10]  244 		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0
                            245 
   01FE 18 02         [12]  246 		jr 	no_collision
                            247 
                            248 	;; Hay colisión en el eje Y, , ent2 está entre arriba y abajo de ent1
   0200                     249 	collision_YT:
                            250 
                            251 	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
   0200 78            [ 4]  252 	ld 	a, b
                            253 
   0201 C9            [10]  254 	ret
                            255 
   0202                     256 	no_collision:
   0202 3E 00         [ 7]  257 	ld 	a, #0 	;; A == 0 si no hay colisión
   0204 C9            [10]  258 	ret
