ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     0010     1 std_acc = 16 	;; standard acceleration per frame
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
                             11 .globl frisbee_setEffect
                             12 .globl frisbee_setVelocities
                             13 	
                     0010    14 .equ Frisbee_effect_I, 16
                     0011    15 .equ Frisbee_effect_F, 17
                     0008    16 .equ std_eff, 08
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
   032D                      25 _cpct_keyboardStatusBuffer:: .ds 10
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



                              9 .globl _moveIA
                             10 
                             11 ;; ====================================
                             12 ;; ====================================
                             13 ;; PRIVATE DATA
                             14 ;; ====================================
                             15 ;; ====================================
                             16 
                             17 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr, id
                             18 
   0337                      19 defineEntity player, #0x0027, #0x0050, #16, #4, #0000, #0000, #0000, #0000, #1, #0xF0, #1
   000A                       1 	player_data::
   0337 27 00                 2 		player_x:	.dw #0x0027		;; X coordinate			(16 bits)
   0339 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   033B 10                    4 		player_h:	.db #16		;; Height			(8 bits)
   033C 04                    5 		player_w:	.db #4		;; Width			(8 bits)
   033D 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   033F 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0341 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0343 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0345 01                   10 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0346 F0                   11 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0347 01                   12 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             20 
   0348                      21 defineEntity enemy, #0x0050-0x0004, #0x0064, #16, #4, #0000, #0000, #0000, #0000, #1, #0xFF, #2
   001B                       1 	enemy_data::
   0348 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   034A 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   034C 10                    4 		enemy_h:	.db #16		;; Height			(8 bits)
   034D 04                    5 		enemy_w:	.db #4		;; Width			(8 bits)
   034E 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0350 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0352 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0354 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0356 01                   10 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0357 FF                   11 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0358 02                   12 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             22 
                             23 	
                             24 ;; ====================================
                             25 ;; ====================================
                             26 ;; PUBLIC FUNCTIONS
                             27 ;; ====================================
                             28 ;; ====================================
   0359                      29 player_erase::
   0359 DD 21 37 03   [14]   30 	ld 	ix, #player_data
   035D CD 1B 01      [17]   31 	call 	entityErase		;; Erase player
   0360 DD 21 48 03   [14]   32 	ld 	ix, #enemy_data
   0364 CD 1B 01      [17]   33 	call 	entityErase		;; Erase enemy
                             34 
   0367 C9            [10]   35 	ret
                             36 
                             37 ;; =========================================
                             38 ;; Actualiza el estado de los entities tipo
                             39 ;;	player
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             40 ;; Modifica: AF, IX
                             41 ;; =========================================
   0368                      42 player_update::
   0368 DD 21 37 03   [14]   43 	ld 	ix, #player_data
   036C CD 14 04      [17]   44 	call checkUserInput
                             45 
   036F 21 4D 02      [10]   46 	ld	hl, #frisbee_data
   0372 E5            [11]   47 	push 	hl
   0373 21 37 03      [10]   48 	ld	hl, #player_data
   0376 E5            [11]   49 	push 	hl
   0377 21 48 03      [10]   50 	ld	hl, #enemy_data
   037A E5            [11]   51 	push 	hl
   037B CD 00 01      [17]   52 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
   037E F1            [10]   53 	pop 	af
   037F F1            [10]   54 	pop 	af
   0380 F1            [10]   55 	pop 	af
                             56 
   0381 DD 21 37 03   [14]   57 	ld 	ix, #player_data
   0385 CD 34 01      [17]   58 	call entityUpdatePhysics
   0388 DD 21 48 03   [14]   59 	ld 	ix, #enemy_data
   038C CD 34 01      [17]   60 	call entityUpdatePhysics
                             61 
   038F DD 21 37 03   [14]   62 	ld 	ix, #player_data
   0393 CD DA 01      [17]   63 	call entityUpdatePosition
   0396 DD 21 48 03   [14]   64 	ld 	ix, #enemy_data
   039A CD DA 01      [17]   65 	call entityUpdatePosition
   039D C9            [10]   66 	ret
                             67 
   039E                      68 player_draw::
   039E DD 21 37 03   [14]   69 	ld 	ix, #player_data
   03A2 CD 01 01      [17]   70 	call 	entityDraw		;; Draw player
   03A5 DD 21 48 03   [14]   71 	ld 	ix, #enemy_data
   03A9 CD 01 01      [17]   72 	call 	entityDraw		;; Draw enemy
                             73 
   03AC C9            [10]   74 	ret
                             75 	
                             76 ;; ====================================
                             77 ;; ====================================
                             78 ;; PRIVATE FUNCTIONS
                             79 ;; ====================================
                             80 ;; ====================================
                             81 
                             82 ;; =========================================
                             83 ;; Determina el siguiente estado de
                             84 ;;	la entidad
                             85 ;; Entrada:
                             86 ;; =========================================
   03AD                      87 delta:
                             88 
                             89 
   03AD                      90 update:
                             91 
                             92 
                             93 ;; =========================================
                             94 ;; Comprueba si la entidad colisiona con 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             95 ;; 	el frisbee
                             96 ;; Entrada:
                             97 ;; 	IX <= puntero al player a comparar
                             98 ;; 		con el frisbee
                             99 ;; Modifica: AF, B, HL, IX
                            100 ;; Devuelve:
                            101 ;; 	A <= 	0 si no hay colisión
                            102 ;; 		>1 si hay colisión
                            103 ;; =========================================
   03AD                     104 checkFrisbeeCollision:
   03AD 21 4D 02      [10]  105 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   03B0 CD 85 01      [17]  106 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            107 
   03B3 C9            [10]  108 	ret
                            109 
                            110 
                            111 ;; ===============================================
                            112 ;; Acelera la entidad hacia la derecha, si puede
                            113 ;; Entrada:
                            114 ;; 	IX <= puntero a los datos de la entidad
                            115 ;; Modifica A, IX
                            116 ;; ===============================================
   03B4                     117 moveRight:
   03B4 DD E5         [15]  118 	push 	ix
   03B6 CD AD 03      [17]  119 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   03B9 DD E1         [14]  120 	pop 	ix
   03BB FE 00         [ 7]  121 	cp 	#0			;; A == 0?
   03BD 20 09         [12]  122 	jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            123 
                            124 		;; no_collision
   03BF DD 36 0A 00   [19]  125 		ld 	Ent_ax_I(ix), #0
   03C3 DD 36 0B 10   [19]  126 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            127 
                            128 
   03C7 C9            [10]  129 		ret
                            130 
   03C8                     131 	collision_right:
   03C8 CD 60 02      [17]  132 		call 	frisbee_setOff
                            133 
   03CB C9            [10]  134 		ret
                            135 
                            136 ;; ===============================================
                            137 ;; Acelera la entidad hacia abajo, si puede
                            138 ;; Entrada:
                            139 ;; 	IX <= puntero a los datos de la entidad
                            140 ;; Modifica A, IX
                            141 ;; ===============================================
   03CC                     142 moveDown:
   03CC DD E5         [15]  143 	push 	ix
   03CE CD AD 03      [17]  144 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   03D1 DD E1         [14]  145 	pop 	ix
   03D3 FE 00         [ 7]  146 	cp 	#0			;; A == 0?
   03D5 20 09         [12]  147 	jr	nz, collision_down 	;; checkFrisbeeCollision != 0?
                            148 
                            149 		;; no_collision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   03D7 DD 36 0C 00   [19]  150 		ld 	Ent_ay_I(ix), #0
   03DB DD 36 0D 10   [19]  151 		ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            152 
   03DF C9            [10]  153 		ret
                            154 
   03E0                     155 	collision_down:
   03E0 CD 60 02      [17]  156 		call 	frisbee_setOff
                            157 
   03E3 C9            [10]  158 		ret
                            159 
                            160 ;; ===============================================
                            161 ;; Acelera la entidad hacia la izquierda, si puede
                            162 ;; Entrada:
                            163 ;; 	IX <= puntero a los datos de la entidad
                            164 ;; Modifica A, IX
                            165 ;; ===============================================
   03E4                     166 moveLeft:
   03E4 DD E5         [15]  167 	push 	ix
   03E6 CD AD 03      [17]  168 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   03E9 DD E1         [14]  169 	pop 	ix
   03EB FE 00         [ 7]  170 	cp 	#0			;; A == 0?
   03ED 20 09         [12]  171 	jr	nz, collision_left 	;; checkFrisbeeCollision != 0?
                            172 
                            173 		;; no_collision
   03EF DD 36 0A FF   [19]  174 		ld 	Ent_ax_I(ix), #-1
   03F3 DD 36 0B F0   [19]  175 		ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            176 
   03F7 C9            [10]  177 		ret
                            178 
   03F8                     179 	collision_left:
   03F8 CD 60 02      [17]  180 		call 	frisbee_setOff
   03FB                     181 	cant_move_left:
   03FB C9            [10]  182 	ret
                            183 
                            184 ;; ===============================================
                            185 ;; Acelera la entidad hacia arriba, si puede
                            186 ;; Entrada:
                            187 ;; 	IX <= puntero a los datos de la entidad
                            188 ;; Modifica A, IX
                            189 ;; ===============================================
   03FC                     190 moveUp:
   03FC DD E5         [15]  191 	push 	ix
   03FE CD AD 03      [17]  192 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0401 DD E1         [14]  193 	pop 	ix
   0403 FE 00         [ 7]  194 	cp 	#0			;; A == 0?
   0405 20 09         [12]  195 	jr	nz, collision_up 	;; checkFrisbeeCollision != 0?
                            196 
                            197 		;; no_collision
   0407 DD 36 0C FF   [19]  198 		ld 	Ent_ay_I(ix), #-1
   040B DD 36 0D F0   [19]  199 		ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            200 
   040F C9            [10]  201 		ret
                            202 
   0410                     203 	collision_up:
   0410 CD 60 02      [17]  204 		call 	frisbee_setOff
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0413                     205 	cant_move_up:
   0413 C9            [10]  206 	ret
                            207 
                            208 
                            209 
                            210 ;; ====================================
                            211 ;; Lee la entrada del teclado
                            212 ;; Entrada:
                            213 ;; 	IX <= pointer to entity data
                            214 ;; Modifica AF, BC, DE, HL
                            215 ;; ====================================
   0414                     216 checkUserInput:
   0414 CD CF 05      [17]  217 	call cpct_scanKeyboard_asm
                            218 
   0417 21 07 20      [10]  219 	ld 	hl, #Key_D			;; HL = D Keycode
   041A CD C2 04      [17]  220 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   041D FE 00         [ 7]  221 	cp 	#0 				;; A == 0?
   041F 28 03         [12]  222 	jr 	z, d_not_pressed
                            223 		;; D is pressed
   0421 CD B4 03      [17]  224 		call 	moveRight	
   0424                     225 	d_not_pressed:
                            226 
   0424 21 08 20      [10]  227 	ld 	hl, #Key_A			;; HL = A Keycode
   0427 CD C2 04      [17]  228 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   042A FE 00         [ 7]  229 	cp 	#0 				;; A == 0?
   042C 28 03         [12]  230 	jr 	z, a_not_pressed
                            231 		;; A is pressed	
   042E CD E4 03      [17]  232 		call 	moveLeft
   0431                     233 	a_not_pressed:
                            234 
   0431 21 07 08      [10]  235 	ld 	hl, #Key_W			;; HL = W Keycode
   0434 CD C2 04      [17]  236 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   0437 FE 00         [ 7]  237 	cp 	#0 				;; A == 0?
   0439 28 03         [12]  238 	jr 	z, w_not_pressed
                            239 		;; W is pressed
   043B CD FC 03      [17]  240 		call 	moveUp	
   043E                     241 	w_not_pressed:
                            242 
   043E 21 07 10      [10]  243 	ld 	hl, #Key_S			;; HL = S Keycode
   0441 CD C2 04      [17]  244 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   0444 FE 00         [ 7]  245 	cp 	#0 				;; A == 0?
   0446 28 03         [12]  246 	jr 	z, s_not_pressed
                            247 		;; S is pressed	
   0448 CD CC 03      [17]  248 		call 	moveDown
   044B                     249 	s_not_pressed:
                            250 
                            251 
   044B DD E5         [15]  252 	push 	ix
   044D CD AD 03      [17]  253 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0450 DD E1         [14]  254 	pop 	ix
   0452 FE 00         [ 7]  255 	cp 	#0			;; A == 0?
   0454 28 3F         [12]  256 	jr	z, b_not_pressed 	;; checkFrisbeeCollision == 0?
                            257 
   0456 21 06 80      [10]  258 	ld 	hl, #Key_V			;; HL = V Keycode
   0459 CD C2 04      [17]  259 	call 	cpct_isKeyPressed_asm 		;; A = True/False
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   045C FE 00         [ 7]  260 	cp 	#0 				;; A == 0?
   045E 28 15         [12]  261 	jr 	z, v_not_pressed
                            262 		;; V is pressed	
   0460 21 06 40      [10]  263 		ld 	hl, #Key_B			;; HL = B Keycode
   0463 CD C2 04      [17]  264 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0466 FE 00         [ 7]  265 		cp 	#0 				;; A == 0?
   0468 28 02         [12]  266 		jr 	z, just_v_pressed
                            267 			;; V and B are pressed
   046A 18 1A         [12]  268 			jr vorb_pressed
   046C                     269 		just_v_pressed:
   046C 26 FF         [ 7]  270 			ld 	h, #-1
   046E 26 08         [ 7]  271 			ld 	h, #std_eff
   0470 CD 7F 02      [17]  272 			call frisbee_setEffect		;; efecto hacia arriba
   0473 18 11         [12]  273 			jr 	vorb_pressed
   0475                     274 	v_not_pressed:
                            275 
   0475 21 06 40      [10]  276 		ld 	hl, #Key_B			;; HL = B Keycode
   0478 CD C2 04      [17]  277 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   047B FE 00         [ 7]  278 		cp 	#0 				;; A == 0?
   047D 28 16         [12]  279 		jr 	z, b_not_pressed
                            280 			;; B is pressed
   047F 26 00         [ 7]  281 			ld 	h, #0
   0481 26 08         [ 7]  282 			ld 	h, #std_eff
   0483 CD 7F 02      [17]  283 			call frisbee_setEffect		;; efecto hacia arriba
                            284 
   0486                     285 			vorb_pressed:
   0486 DD 66 06      [19]  286 			ld	h, Ent_vx_I(ix)		;;
   0489 DD 6E 07      [19]  287 			ld	l, Ent_vx_F(ix)		;;
   048C DD 56 08      [19]  288 			ld	d, Ent_vy_I(ix)		;;
   048F DD 5E 09      [19]  289 			ld	e, Ent_vy_F(ix)		;;
   0492 CD 6E 02      [17]  290 			call frisbee_setVelocities	;; transferimos la velocidad de la entidad al frisbee
                            291 
   0495                     292 	b_not_pressed:
   0495 C9            [10]  293 	ret
                            294 
