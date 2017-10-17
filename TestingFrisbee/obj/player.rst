ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     001E     1 std_acc = 30 	;; standard acceleration per frame
                              2 
                              3 .area _DATA
                              4 .area _CODE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "entity.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "frisbee.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; FRISBEE PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 .globl frisbee_erase
                              7 .globl frisbee_update
                              8 .globl frisbee_draw
                              9 .globl frisbee_data
                             10 .globl frisbee_setOff
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 .include "keyboard/keyboard.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2014 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module cpct_keyboard
                             19 
                             20 ;; bndry directive does not work when linking previously compiled files
                             21 ;.bndry 16
                             22 ;;   16-byte aligned in memory to let functions use 8-bit maths for pointing
                             23 ;;   (alignment not working on user linking)
                             24 
   02BB                      25 _cpct_keyboardStatusBuffer:: .ds 10
                             26 
                             27 ;;
                             28 ;; Assembly constant definitions for keyboard mapping
                             29 ;;
                             30 
                             31 ;; Matrix Line 0x00
                     0100    32 .equ Key_CursorUp     ,#0x0100  ;; Bit 0 (01h) => | 0000 0001 |
                     0200    33 .equ Key_CursorRight  ,#0x0200  ;; Bit 1 (02h) => | 0000 0010 |
                     0400    34 .equ Key_CursorDown   ,#0x0400  ;; Bit 2 (04h) => | 0000 0100 |
                     0800    35 .equ Key_F9           ,#0x0800  ;; Bit 3 (08h) => | 0000 1000 |
                     1000    36 .equ Key_F6           ,#0x1000  ;; Bit 4 (10h) => | 0001 0000 |
                     2000    37 .equ Key_F3           ,#0x2000  ;; Bit 5 (20h) => | 0010 0000 |
                     4000    38 .equ Key_Enter        ,#0x4000  ;; Bit 6 (40h) => | 0100 0000 |
                     8000    39 .equ Key_FDot         ,#0x8000  ;; Bit 7 (80h) => | 1000 0000 |
                             40 ;; Matrix Line 0x01
                     0101    41 .equ Key_CursorLeft   ,#0x0101
                     0201    42 .equ Key_Copy         ,#0x0201
                     0401    43 .equ Key_F7           ,#0x0401
                     0801    44 .equ Key_F8           ,#0x0801
                     1001    45 .equ Key_F5           ,#0x1001
                     2001    46 .equ Key_F1           ,#0x2001
                     4001    47 .equ Key_F2           ,#0x4001
                     8001    48 .equ Key_F0           ,#0x8001
                             49 ;; Matrix Line 0x02
                     0102    50 .equ Key_Clr          ,#0x0102
                     0202    51 .equ Key_OpenBracket  ,#0x0202
                     0402    52 .equ Key_Return       ,#0x0402
                     0802    53 .equ Key_CloseBracket ,#0x0802
                     1002    54 .equ Key_F4           ,#0x1002
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                     2002    55 .equ Key_Shift        ,#0x2002
                     4002    56 .equ Key_BackSlash    ,#0x4002
                     8002    57 .equ Key_Control      ,#0x8002
                             58 ;; Matrix Line 0x03
                     0103    59 .equ Key_Caret        ,#0x0103
                     0203    60 .equ Key_Hyphen       ,#0x0203
                     0403    61 .equ Key_At           ,#0x0403
                     0803    62 .equ Key_P            ,#0x0803
                     1003    63 .equ Key_SemiColon    ,#0x1003
                     2003    64 .equ Key_Colon        ,#0x2003
                     4003    65 .equ Key_Slash        ,#0x4003
                     8003    66 .equ Key_Dot          ,#0x8003
                             67 ;; Matrix Line 0x04
                     0104    68 .equ Key_0            ,#0x0104
                     0204    69 .equ Key_9            ,#0x0204
                     0404    70 .equ Key_O            ,#0x0404
                     0804    71 .equ Key_I            ,#0x0804
                     1004    72 .equ Key_L            ,#0x1004
                     2004    73 .equ Key_K            ,#0x2004
                     4004    74 .equ Key_M            ,#0x4004
                     8004    75 .equ Key_Comma        ,#0x8004
                             76 ;; Matrix Line 0x05
                     0105    77 .equ Key_8            ,#0x0105
                     0205    78 .equ Key_7            ,#0x0205
                     0405    79 .equ Key_U            ,#0x0405
                     0805    80 .equ Key_Y            ,#0x0805
                     1005    81 .equ Key_H            ,#0x1005
                     2005    82 .equ Key_J            ,#0x2005
                     4005    83 .equ Key_N            ,#0x4005
                     8005    84 .equ Key_Space        ,#0x8005
                             85 ;; Matrix Line 0x06
                     0106    86 .equ Key_6            ,#0x0106
                     0106    87 .equ Joy1_Up          ,#0x0106
                     0206    88 .equ Key_5            ,#0x0206
                     0206    89 .equ Joy1_Down        ,#0x0206
                     0406    90 .equ Key_R            ,#0x0406
                     0406    91 .equ Joy1_Left        ,#0x0406
                     0806    92 .equ Key_T            ,#0x0806
                     0806    93 .equ Joy1_Right       ,#0x0806
                     1006    94 .equ Key_G            ,#0x1006
                     1006    95 .equ Joy1_Fire1       ,#0x1006
                     2006    96 .equ Key_F            ,#0x2006
                     2006    97 .equ Joy1_Fire2       ,#0x2006
                     4006    98 .equ Key_B            ,#0x4006
                     4006    99 .equ Joy1_Fire3       ,#0x4006
                     8006   100 .equ Key_V            ,#0x8006
                            101 ;; Matrix Line 0x07
                     0107   102 .equ Key_4            ,#0x0107
                     0207   103 .equ Key_3            ,#0x0207
                     0407   104 .equ Key_E            ,#0x0407
                     0807   105 .equ Key_W            ,#0x0807
                     1007   106 .equ Key_S            ,#0x1007
                     2007   107 .equ Key_D            ,#0x2007
                     4007   108 .equ Key_C            ,#0x4007
                     8007   109 .equ Key_X            ,#0x8007
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            110 ;; Matrix Line 0x08
                     0108   111 .equ Key_1            ,#0x0108
                     0208   112 .equ Key_2            ,#0x0208
                     0408   113 .equ Key_Esc          ,#0x0408
                     0808   114 .equ Key_Q            ,#0x0808
                     1008   115 .equ Key_Tab          ,#0x1008
                     2008   116 .equ Key_A            ,#0x2008
                     4008   117 .equ Key_CapsLock     ,#0x4008
                     8008   118 .equ Key_Z            ,#0x8008
                            119 ;; Matrix Line 0x09
                     0109   120 .equ Joy0_Up          ,#0x0109
                     0209   121 .equ Joy0_Down        ,#0x0209
                     0409   122 .equ Joy0_Left        ,#0x0409
                     0809   123 .equ Joy0_Right       ,#0x0809
                     1009   124 .equ Joy0_Fire1       ,#0x1009
                     2009   125 .equ Joy0_Fire2       ,#0x2009
                     4009   126 .equ Joy0_Fire3       ,#0x4009
                     8009   127 .equ Key_Del          ,#0x8009
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 
                             10 ;; ====================================
                             11 ;; ====================================
                             12 ;; PRIVATE DATA
                             13 ;; ====================================
                             14 ;; ====================================
                             15 
                             16 ;; .macro defineEntity name, x, y, h, w, vx, vy, ax, ay, onOff, clr
                             17 
   02C5                      18 defineEntity player, #39, #80, #16, #4, #0000, #0000, #0000, #0000, #1, #0xF0
   000A                       1 	player_data::
   02C5 27                    2 		player_x:	.db #39		;; X coordinate			(8 bits)
   02C6 50                    3 		player_y:	.db #80		;; Y coordinate			(8 bits)
   02C7 10                    4 		player_h:	.db #16		;; Height			(8 bits)
   02C8 04                    5 		player_w:	.db #4		;; Width			(8 bits)
   02C9 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   02CB 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   02CD 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   02CF 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   02D1 01                   10 		player_onOff:	.db #1	;; Entity enabled/disabled	(8 bits)
   02D2 F0                   11 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
                             19 
   02D3                      20 defineEntity enemy, #80-4, #100, #16, #4, #0000, #0000, #0000, #0000, #1, #0xFF
   0018                       1 	enemy_data::
   02D3 4C                    2 		enemy_x:	.db #80-4		;; X coordinate			(8 bits)
   02D4 64                    3 		enemy_y:	.db #100		;; Y coordinate			(8 bits)
   02D5 10                    4 		enemy_h:	.db #16		;; Height			(8 bits)
   02D6 04                    5 		enemy_w:	.db #4		;; Width			(8 bits)
   02D7 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   02D9 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   02DB 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   02DD 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   02DF 01                   10 		enemy_onOff:	.db #1	;; Entity enabled/disabled	(8 bits)
   02E0 FF                   11 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
                             21 
                             22 	
                             23 ;; ====================================
                             24 ;; ====================================
                             25 ;; PUBLIC FUNCTIONS
                             26 ;; ====================================
                             27 ;; ====================================
   02E1                      28 player_erase::
   02E1 DD 21 C5 02   [14]   29 	ld 	ix, #player_data
   02E5 CD 1A 01      [17]   30 	call 	entityErase		;; Erase player
   02E8 DD 21 D3 02   [14]   31 	ld 	ix, #enemy_data
   02EC CD 1A 01      [17]   32 	call 	entityErase		;; Erase enemy
                             33 
   02EF C9            [10]   34 	ret
                             35 
   02F0                      36 player_update::
   02F0 CD 78 03      [17]   37 	call checkUserInput
                             38 
   02F3 DD 21 C5 02   [14]   39 	ld 	ix, #player_data
   02F7 CD 72 01      [17]   40 	call entityUpdatePhysics
   02FA DD 21 D3 02   [14]   41 	ld 	ix, #enemy_data
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   02FE CD 72 01      [17]   42 	call entityUpdatePhysics
   0301 C9            [10]   43 	ret
                             44 
   0302                      45 player_draw::
   0302 DD 21 C5 02   [14]   46 	ld 	ix, #player_data
   0306 CD 00 01      [17]   47 	call 	entityDraw		;; Draw player
   0309 DD 21 D3 02   [14]   48 	ld 	ix, #enemy_data
   030D CD 00 01      [17]   49 	call 	entityDraw		;; Draw enemy
                             50 
   0310 C9            [10]   51 	ret
                             52 	
                             53 ;; ====================================
                             54 ;; ====================================
                             55 ;; PRIVATE FUNCTIONS
                             56 ;; ====================================
                             57 ;; ====================================
                             58 
                             59 
                             60 
                             61 ;; =========================================
                             62 ;; Comprueba si la entidad colisiona con 
                             63 ;; 	el frisbee
                             64 ;; Entrada:
                             65 ;; 	IX <= puntero al player a comparar
                             66 ;; 		con el frisbee
                             67 ;; Modifica: AF, B, HL, IX
                             68 ;; Devuelve:
                             69 ;; 	A <= 	0 si no hay colisión
                             70 ;; 		>1 si hay colisión
                             71 ;; =========================================
   0311                      72 checkFrisbeeCollision:
   0311 21 05 02      [10]   73 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   0314 CD B0 01      [17]   74 	call 	entityCheckCollision 	;; A <= collison/no_collision
                             75 
   0317 C9            [10]   76 	ret
                             77 
                             78 
                             79 ;; ===============================================
                             80 ;; Acelera la entidad hacia la derecha, si puede
                             81 ;; Entrada:
                             82 ;; 	IX <= puntero a los datos de la entidad
                             83 ;; Modifica A, IX
                             84 ;; ===============================================
   0318                      85 moveRight:
   0318 DD E5         [15]   86 	push 	ix
   031A CD 11 03      [17]   87 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   031D DD E1         [14]   88 	pop 	ix
   031F FE 00         [ 7]   89 	cp 	#0			;; A == 0?
   0321 20 09         [12]   90 	jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                             91 
                             92 		;; no_collision
   0323 DD 36 08 00   [19]   93 		ld 	Ent_ax_I(ix), #0
   0327 DD 36 09 1E   [19]   94 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                             95 
                             96 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   032B C9            [10]   97 		ret
                             98 
   032C                      99 	collision_right:
   032C CD 13 02      [17]  100 		call 	frisbee_setOff
                            101 
   032F C9            [10]  102 		ret
                            103 
                            104 ;; ===============================================
                            105 ;; Acelera la entidad hacia abajo, si puede
                            106 ;; Entrada:
                            107 ;; 	IX <= puntero a los datos de la entidad
                            108 ;; Modifica A, IX
                            109 ;; ===============================================
   0330                     110 moveDown:
   0330 DD E5         [15]  111 	push 	ix
   0332 CD 11 03      [17]  112 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0335 DD E1         [14]  113 	pop 	ix
   0337 FE 00         [ 7]  114 	cp 	#0			;; A == 0?
   0339 20 09         [12]  115 	jr	nz, collision_down 	;; checkFrisbeeCollision != 0?
                            116 
                            117 		;; no_collision
   033B DD 36 0A 00   [19]  118 		ld 	Ent_ay_I(ix), #0
   033F DD 36 0B 1E   [19]  119 		ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            120 
   0343 C9            [10]  121 		ret
                            122 
   0344                     123 	collision_down:
   0344 CD 13 02      [17]  124 		call 	frisbee_setOff
                            125 
   0347 C9            [10]  126 		ret
                            127 
                            128 ;; ===============================================
                            129 ;; Acelera la entidad hacia la izquierda, si puede
                            130 ;; Entrada:
                            131 ;; 	IX <= puntero a los datos de la entidad
                            132 ;; Modifica A, IX
                            133 ;; ===============================================
   0348                     134 moveLeft:
   0348 DD E5         [15]  135 	push 	ix
   034A CD 11 03      [17]  136 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   034D DD E1         [14]  137 	pop 	ix
   034F FE 00         [ 7]  138 	cp 	#0			;; A == 0?
   0351 20 09         [12]  139 	jr	nz, collision_left 	;; checkFrisbeeCollision != 0?
                            140 
                            141 		;; no_collision
   0353 DD 36 08 FF   [19]  142 		ld 	Ent_ax_I(ix), #-1
   0357 DD 36 09 E2   [19]  143 		ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            144 
   035B C9            [10]  145 		ret
                            146 
   035C                     147 	collision_left:
   035C CD 13 02      [17]  148 		call 	frisbee_setOff
   035F                     149 	cant_move_left:
   035F C9            [10]  150 	ret
                            151 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            152 ;; ===============================================
                            153 ;; Acelera la entidad hacia arriba, si puede
                            154 ;; Entrada:
                            155 ;; 	IX <= puntero a los datos de la entidad
                            156 ;; Modifica A, IX
                            157 ;; ===============================================
   0360                     158 moveUp:
   0360 DD E5         [15]  159 	push 	ix
   0362 CD 11 03      [17]  160 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0365 DD E1         [14]  161 	pop 	ix
   0367 FE 00         [ 7]  162 	cp 	#0			;; A == 0?
   0369 20 09         [12]  163 	jr	nz, collision_up 	;; checkFrisbeeCollision != 0?
                            164 
                            165 		;; no_collision
   036B DD 36 0A FF   [19]  166 		ld 	Ent_ay_I(ix), #-1
   036F DD 36 0B E2   [19]  167 		ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            168 
   0373 C9            [10]  169 		ret
                            170 
   0374                     171 	collision_up:
   0374 CD 13 02      [17]  172 		call 	frisbee_setOff
   0377                     173 	cant_move_up:
   0377 C9            [10]  174 	ret
                            175 
                            176 ;; ============================
                            177 ;; Lee la entrada del teclado
                            178 ;; Modifica AF, BC, DE, HL
                            179 ;; ============================
   0378                     180 checkUserInput:
   0378 CD C1 04      [17]  181 	call cpct_scanKeyboard_asm
                            182 
   037B DD 21 C5 02   [14]  183 	ld 	ix, #player_data
   037F 21 07 20      [10]  184 	ld 	hl, #Key_D			;; HL = D Keycode
   0382 CD B4 03      [17]  185 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   0385 FE 00         [ 7]  186 	cp 	#0 				;; A == 0?
   0387 28 03         [12]  187 	jr 	z, d_not_pressed
                            188 		;; D is pressed
   0389 CD 18 03      [17]  189 		call 	moveRight	
   038C                     190 	d_not_pressed:
                            191 
   038C 21 08 20      [10]  192 	ld 	hl, #Key_A			;; HL = A Keycode
   038F CD B4 03      [17]  193 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   0392 FE 00         [ 7]  194 	cp 	#0 				;; A == 0?
   0394 28 03         [12]  195 	jr 	z, a_not_pressed
                            196 		;; A is pressed	
   0396 CD 48 03      [17]  197 		call 	moveLeft
   0399                     198 	a_not_pressed:
                            199 
   0399 21 07 08      [10]  200 	ld 	hl, #Key_W			;; HL = W Keycode
   039C CD B4 03      [17]  201 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   039F FE 00         [ 7]  202 	cp 	#0 				;; A == 0?
   03A1 28 03         [12]  203 	jr 	z, w_not_pressed
                            204 		;; W is pressed
   03A3 CD 60 03      [17]  205 		call 	moveUp	
   03A6                     206 	w_not_pressed:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            207 
   03A6 21 07 10      [10]  208 	ld 	hl, #Key_S			;; HL = S Keycode
   03A9 CD B4 03      [17]  209 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   03AC FE 00         [ 7]  210 	cp 	#0 				;; A == 0?
   03AE 28 03         [12]  211 	jr 	z, s_not_pressed
                            212 		;; S is pressed	
   03B0 CD 30 03      [17]  213 		call 	moveDown
   03B3                     214 	s_not_pressed:
                            215 
   03B3 C9            [10]  216 	ret
