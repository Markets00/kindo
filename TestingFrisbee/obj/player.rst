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
                             12 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
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
                             23 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             24 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             25 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             26 .endm
                             27 
                             28 
                             29 ;; ====================================
                             30 ;; ====================================
                             31 ;; ENTITY PUBLIC DATA
                             32 ;; ====================================
                             33 ;; ====================================
                     0000    34 .equ Ent_x_I, 	0	;; X coordinate, integer part
                     0001    35 .equ Ent_x_F, 	1	;; X coordinate, fractional part
                     0002    36 .equ Ent_y_I, 	2	;; Y coordinate, integer part
                     0003    37 .equ Ent_y_F, 	3	;; Y coordinate, fractional part
                     0004    38 .equ Ent_h, 	4	;; Height
                     0005    39 .equ Ent_w, 	5	;; Width
                     0006    40 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    41 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    42 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    43 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    44 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    45 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    46 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    47 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    48 .equ Ent_N_I,	14	;; Normal force, integer part
                     000F    49 .equ Ent_N_F,	15	;; Normal force, fractional part
                     0010    50 .equ Ent_state,	16	;; Entity enabled/disabled
                     0011    51 .equ Ent_clr, 	17	;; Entity color pattern
                     0012    52 .equ Ent_id, 	18	;; Numeric ID
                             53 			;; Frisbee 	0
                             54 			;; Player1 	1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55 			;; Enemy1	2
                             56 
                     0002    57 .equ MAX_VEL_X, 2 
                     FFFFFFFE    58 .equ MIN_VEL_X, -2
                     0004    59 .equ MAX_VEL_Y, 4
                     FFFFFFFC    60 .equ MIN_VEL_Y, -4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 
                              8 .macro defineGame name, type, map, fTime
                              9 	name'_data::
                             10 		name'_type:	.db type	;; Game Mode			(8 bits)
                             11 		name'_map:	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime:	.dw fTime	;; Final duration of each match	(16 bits)
                             13 .endm
                             14 
                             15 ;; ====================================
                             16 ;; ====================================
                             17 ;; GAME PUBLIC DATA
                             18 ;; ====================================
                             19 ;; ====================================
                     0000    20 .equ Game_type, 	0	;; Game mode
                     0001    21 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    22 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    23 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    24 .equ Game_fTime_L, 	4	;; Low part of final match time
                             25 
                     0050    26 .equ RIGHT_LIMIT,	80
                     0000    27 .equ LEFT_LIMIT,	0
                     000A    28 .equ TOP_LIMIT,	 	10
                     00C8    29 .equ BOTTOM_LIMIT,	200
                     0028    30 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              9 .include "keyboard/keyboard.s"
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
   0395                      25 _cpct_keyboardStatusBuffer:: .ds 10
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             10 .globl _moveIA
                             11 
                             12 ;; ====================================
                             13 ;; ====================================
                             14 ;; PRIVATE DATA
                             15 ;; ====================================
                             16 ;; ====================================
                             17 
                             18 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr, id
                             19 
   039F                      20 defineEntity player, #0x0010, #0x0050, #16, #4, #0000, #0000, #0000, #0000, #0x0800, #1, #0xF0, #1
   000A                       1 	player_data::
   039F 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   03A1 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   03A3 10                    4 		player_h:	.db #16		;; Height			(8 bits)
   03A4 04                    5 		player_w:	.db #4		;; Width			(8 bits)
   03A5 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   03A7 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   03A9 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   03AB 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   03AD 00 08                10 		player_normal:	.dw #0x0800	;; Normal force			(16 bits)
   03AF 01                   11 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   03B0 F0                   12 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   03B1 01                   13 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             21 
   03B2                      22 defineEntity enemy, #0x0050-0x0004, #0x0064, #16, #4, #0000, #0000, #0000, #0000, #0x0800, #1, #0xFF, #2
   001D                       1 	enemy_data::
   03B2 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   03B4 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   03B6 10                    4 		enemy_h:	.db #16		;; Height			(8 bits)
   03B7 04                    5 		enemy_w:	.db #4		;; Width			(8 bits)
   03B8 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   03BA 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   03BC 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   03BE 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   03C0 00 08                10 		enemy_normal:	.dw #0x0800	;; Normal force			(16 bits)
   03C2 01                   11 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   03C3 FF                   12 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   03C4 02                   13 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             23 
                             24 	
                             25 ;; ====================================
                             26 ;; ====================================
                             27 ;; PUBLIC FUNCTIONS
                             28 ;; ====================================
                             29 ;; ====================================
   03C5                      30 player_erase::
   03C5 DD 21 9F 03   [14]   31 	ld 	ix, #player_data
   03C9 CD 1B 01      [17]   32 	call 	entityErase		;; Erase player
   03CC DD 21 B2 03   [14]   33 	ld 	ix, #enemy_data
   03D0 CD 1B 01      [17]   34 	call 	entityErase		;; Erase enemy
                             35 
   03D3 C9            [10]   36 	ret
                             37 
                             38 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             39 ;; Actualiza el estado de los entities tipo
                             40 ;;	player
                             41 ;; Modifica: AF, IX
                             42 ;; =========================================
   03D4                      43 player_update::
   03D4 DD 21 9F 03   [14]   44 	ld 	ix, #player_data
   03D8 CD B7 04      [17]   45 	call checkUserInput
                             46 
   03DB 21 B3 02      [10]   47 	ld	hl, #frisbee_data
   03DE E5            [11]   48 	push 	hl
   03DF 21 9F 03      [10]   49 	ld	hl, #player_data
   03E2 E5            [11]   50 	push 	hl
   03E3 21 B2 03      [10]   51 	ld	hl, #enemy_data
   03E6 E5            [11]   52 	push 	hl
   03E7 CD 00 01      [17]   53 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
   03EA F1            [10]   54 	pop 	af
   03EB F1            [10]   55 	pop 	af
   03EC F1            [10]   56 	pop 	af
                             57 
   03ED DD 21 9F 03   [14]   58 	ld 	ix, #player_data
   03F1 CD 34 01      [17]   59 	call entityUpdatePhysics
   03F4 DD 21 B2 03   [14]   60 	ld 	ix, #enemy_data
   03F8 CD 34 01      [17]   61 	call entityUpdatePhysics
                             62 
   03FB DD 21 9F 03   [14]   63 	ld 	ix, #player_data
   03FF CD 3C 02      [17]   64 	call entityUpdatePosition
   0402 DD 21 B2 03   [14]   65 	ld 	ix, #enemy_data
   0406 CD 3C 02      [17]   66 	call entityUpdatePosition
                             67 
                             68 
   0409 DD 21 9F 03   [14]   69 	ld 	ix, #player_data
   040D CD 8E 04      [17]   70 	call checkCenterCrossing
   0410 DD 21 B2 03   [14]   71 	ld 	ix, #enemy_data
   0414 CD 8E 04      [17]   72 	call checkCenterCrossing
   0417 C9            [10]   73 	ret
                             74 
   0418                      75 player_draw::
   0418 DD 21 9F 03   [14]   76 	ld 	ix, #player_data
   041C CD 01 01      [17]   77 	call 	entityDraw		;; Draw player
   041F DD 21 B2 03   [14]   78 	ld 	ix, #enemy_data
   0423 CD 01 01      [17]   79 	call 	entityDraw		;; Draw enemy
                             80 
   0426 C9            [10]   81 	ret
                             82 	
                             83 ;; ====================================
                             84 ;; ====================================
                             85 ;; PRIVATE FUNCTIONS
                             86 ;; ====================================
                             87 ;; ====================================
                             88 
                             89 ;; =========================================
                             90 ;; Determina el siguiente estado de
                             91 ;;	la entidad
                             92 ;; Entrada:
                             93 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0427                      94 delta:
                             95 
                             96 
   0427                      97 update:
                             98 
                             99 
                            100 ;; =========================================
                            101 ;; Comprueba si la entidad colisiona con 
                            102 ;; 	el frisbee
                            103 ;; Entrada:
                            104 ;; 	IX <= puntero al player a comparar
                            105 ;; 		con el frisbee
                            106 ;; Modifica: AF, B, HL, IX
                            107 ;; Devuelve:
                            108 ;; 	A <= 	0 si no hay colisión
                            109 ;; 		>1 si hay colisión
                            110 ;; =========================================
   0427                     111 checkFrisbeeCollision:
   0427 21 B3 02      [10]  112 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   042A CD E7 01      [17]  113 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            114 
   042D C9            [10]  115 	ret
                            116 
                            117 
                            118 ;; ===============================================
                            119 ;; Acelera la entidad hacia la derecha, si puede
                            120 ;; Entrada:
                            121 ;; 	IX <= puntero a los datos de la entidad
                            122 ;; Modifica A, IX
                            123 ;; ===============================================
   042E                     124 moveRight:
   042E DD E5         [15]  125 	push 	ix
   0430 CD 27 04      [17]  126 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0433 DD E1         [14]  127 	pop 	ix
   0435 FE 00         [ 7]  128 	cp 	#0			;; A == 0?
   0437 20 09         [12]  129 	jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            130 
                            131 		;; no_collision
   0439 DD 36 0A 00   [19]  132 		ld 	Ent_ax_I(ix), #0
   043D DD 36 0B 10   [19]  133 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            134 
                            135 
   0441 C9            [10]  136 		ret
                            137 
   0442                     138 	collision_right:
   0442 CD C8 02      [17]  139 		call 	frisbee_setOff
                            140 
   0445 C9            [10]  141 		ret
                            142 
                            143 ;; ===============================================
                            144 ;; Acelera la entidad hacia abajo, si puede
                            145 ;; Entrada:
                            146 ;; 	IX <= puntero a los datos de la entidad
                            147 ;; Modifica A, IX
                            148 ;; ===============================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0446                     149 moveDown:
   0446 DD E5         [15]  150 	push 	ix
   0448 CD 27 04      [17]  151 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   044B DD E1         [14]  152 	pop 	ix
   044D FE 00         [ 7]  153 	cp 	#0			;; A == 0?
   044F 20 09         [12]  154 	jr	nz, collision_down 	;; checkFrisbeeCollision != 0?
                            155 
                            156 		;; no_collision
   0451 DD 36 0C 00   [19]  157 		ld 	Ent_ay_I(ix), #0
   0455 DD 36 0D 10   [19]  158 		ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            159 
   0459 C9            [10]  160 		ret
                            161 
   045A                     162 	collision_down:
   045A CD C8 02      [17]  163 		call 	frisbee_setOff
                            164 
   045D C9            [10]  165 		ret
                            166 
                            167 ;; ===============================================
                            168 ;; Acelera la entidad hacia la izquierda, si puede
                            169 ;; Entrada:
                            170 ;; 	IX <= puntero a los datos de la entidad
                            171 ;; Modifica A, IX
                            172 ;; ===============================================
   045E                     173 moveLeft:
   045E DD E5         [15]  174 	push 	ix
   0460 CD 27 04      [17]  175 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0463 DD E1         [14]  176 	pop 	ix
   0465 FE 00         [ 7]  177 	cp 	#0			;; A == 0?
   0467 20 09         [12]  178 	jr	nz, collision_left 	;; checkFrisbeeCollision != 0?
                            179 
                            180 		;; no_collision
   0469 DD 36 0A FF   [19]  181 		ld 	Ent_ax_I(ix), #-1
   046D DD 36 0B F0   [19]  182 		ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            183 
   0471 C9            [10]  184 		ret
                            185 
   0472                     186 	collision_left:
   0472 CD C8 02      [17]  187 		call 	frisbee_setOff
   0475                     188 	cant_move_left:
   0475 C9            [10]  189 	ret
                            190 
                            191 ;; ===============================================
                            192 ;; Acelera la entidad hacia arriba, si puede
                            193 ;; Entrada:
                            194 ;; 	IX <= puntero a los datos de la entidad
                            195 ;; Modifica A, IX
                            196 ;; ===============================================
   0476                     197 moveUp:
   0476 DD E5         [15]  198 	push 	ix
   0478 CD 27 04      [17]  199 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   047B DD E1         [14]  200 	pop 	ix
   047D FE 00         [ 7]  201 	cp 	#0			;; A == 0?
   047F 20 09         [12]  202 	jr	nz, collision_up 	;; checkFrisbeeCollision != 0?
                            203 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            204 		;; no_collision
   0481 DD 36 0C FF   [19]  205 		ld 	Ent_ay_I(ix), #-1
   0485 DD 36 0D F0   [19]  206 		ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            207 
   0489 C9            [10]  208 		ret
                            209 
   048A                     210 	collision_up:
   048A CD C8 02      [17]  211 		call 	frisbee_setOff
   048D                     212 	cant_move_up:
   048D C9            [10]  213 	ret
                            214 
                            215 
                            216 ;; ===========================================
                            217 ;; Chequea si un jugador pasa del centro del
                            218 ;; 	campo y lo corrige en caso necesario
                            219 ;; Entrada:
                            220 ;; 	IX <= pointer to entity data
                            221 ;; Modifica AF, BC, DE, HL
                            222 ;; ===========================================
   048E                     223 checkCenterCrossing:
   048E DD 7E 12      [19]  224 	ld 	a, Ent_id(ix)
   0491 FE 01         [ 7]  225 	cp 	#1
   0493 28 0F         [12]  226 	jr	z, player_1
   0495 FE 02         [ 7]  227 		cp	#2
   0497 20 1D         [12]  228 		jr	nz, invalid_id
                            229 			;; player 2
   0499 DD 7E 00      [19]  230 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   049C FE 28         [ 7]  231 			cp	#CENTER_LIMIT
   049E 30 16         [12]  232 			jr	nc, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            233 				;; center limit crossed
   04A0 DD 36 00 28   [19]  234 				ld	Ent_x_I(ix), #CENTER_LIMIT
                            235 
   04A4                     236 	player_1:
   04A4 DD 7E 00      [19]  237 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   04A7 DD 86 05      [19]  238 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   04AA FE 28         [ 7]  239 			cp	#CENTER_LIMIT
   04AC 38 08         [12]  240 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            241 				;; center limit crossed
   04AE 3E 28         [ 7]  242 				ld	a, #CENTER_LIMIT
   04B0 DD 96 05      [19]  243 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   04B3 DD 77 00      [19]  244 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            245 
                            246 
   04B6                     247 	invalid_id:
   04B6                     248 	not_crossed:
   04B6 C9            [10]  249 	ret
                            250 
                            251 
                            252 ;; ====================================
                            253 ;; Lee la entrada del teclado
                            254 ;; Entrada:
                            255 ;; 	IX <= pointer to entity data
                            256 ;; Modifica AF, BC, DE, HL
                            257 ;; ====================================
   04B7                     258 checkUserInput:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   04B7 CD 72 06      [17]  259 	call cpct_scanKeyboard_asm
                            260 
   04BA 21 07 20      [10]  261 	ld 	hl, #Key_D			;; HL = D Keycode
   04BD CD 65 05      [17]  262 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04C0 FE 00         [ 7]  263 	cp 	#0 				;; A == 0?
   04C2 28 03         [12]  264 	jr 	z, d_not_pressed
                            265 		;; D is pressed
   04C4 CD 2E 04      [17]  266 		call 	moveRight	
   04C7                     267 	d_not_pressed:
                            268 
   04C7 21 08 20      [10]  269 	ld 	hl, #Key_A			;; HL = A Keycode
   04CA CD 65 05      [17]  270 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04CD FE 00         [ 7]  271 	cp 	#0 				;; A == 0?
   04CF 28 03         [12]  272 	jr 	z, a_not_pressed
                            273 		;; A is pressed	
   04D1 CD 5E 04      [17]  274 		call 	moveLeft
   04D4                     275 	a_not_pressed:
                            276 
   04D4 21 07 08      [10]  277 	ld 	hl, #Key_W			;; HL = W Keycode
   04D7 CD 65 05      [17]  278 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04DA FE 00         [ 7]  279 	cp 	#0 				;; A == 0?
   04DC 28 03         [12]  280 	jr 	z, w_not_pressed
                            281 		;; W is pressed
   04DE CD 76 04      [17]  282 		call 	moveUp	
   04E1                     283 	w_not_pressed:
                            284 
   04E1 21 07 10      [10]  285 	ld 	hl, #Key_S			;; HL = S Keycode
   04E4 CD 65 05      [17]  286 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04E7 FE 00         [ 7]  287 	cp 	#0 				;; A == 0?
   04E9 28 03         [12]  288 	jr 	z, s_not_pressed
                            289 		;; S is pressed	
   04EB CD 46 04      [17]  290 		call 	moveDown
   04EE                     291 	s_not_pressed:
                            292 
                            293 
   04EE DD E5         [15]  294 	push 	ix
   04F0 CD 27 04      [17]  295 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   04F3 DD E1         [14]  296 	pop 	ix
   04F5 FE 00         [ 7]  297 	cp 	#0			;; A == 0?
   04F7 28 3F         [12]  298 	jr	z, b_not_pressed 	;; checkFrisbeeCollision == 0?
                            299 
   04F9 21 06 80      [10]  300 		ld 	hl, #Key_V			;; HL = V Keycode
   04FC CD 65 05      [17]  301 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   04FF FE 00         [ 7]  302 		cp 	#0 				;; A == 0?
   0501 28 15         [12]  303 		jr 	z, v_not_pressed
                            304 			;; V is pressed	
   0503 21 06 40      [10]  305 			ld 	hl, #Key_B			;; HL = B Keycode
   0506 CD 65 05      [17]  306 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0509 FE 00         [ 7]  307 			cp 	#0 				;; A == 0?
   050B 28 02         [12]  308 			jr 	z, just_v_pressed
                            309 				;; V and B are pressed
   050D 18 1A         [12]  310 				jr vorb_pressed
   050F                     311 			just_v_pressed:
   050F 26 FF         [ 7]  312 				ld 	h, #-1
   0511 26 08         [ 7]  313 				ld 	h, #std_eff
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0513 CD E7 02      [17]  314 				call frisbee_setEffect		;; efecto hacia arriba
   0516 18 11         [12]  315 				jr 	vorb_pressed
   0518                     316 		v_not_pressed:
                            317 
   0518 21 06 40      [10]  318 			ld 	hl, #Key_B			;; HL = B Keycode
   051B CD 65 05      [17]  319 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   051E FE 00         [ 7]  320 			cp 	#0 				;; A == 0?
   0520 28 16         [12]  321 			jr 	z, b_not_pressed
                            322 				;; B is pressed
   0522 26 00         [ 7]  323 				ld 	h, #0
   0524 26 08         [ 7]  324 				ld 	h, #std_eff
   0526 CD E7 02      [17]  325 				call frisbee_setEffect		;; efecto hacia arriba
                            326 
   0529                     327 				vorb_pressed:
   0529 DD 66 06      [19]  328 				ld	h, Ent_vx_I(ix)		;;
   052C DD 6E 07      [19]  329 				ld	l, Ent_vx_F(ix)		;;
   052F DD 56 08      [19]  330 				ld	d, Ent_vy_I(ix)		;;
   0532 DD 5E 09      [19]  331 				ld	e, Ent_vy_F(ix)		;;
   0535 CD D6 02      [17]  332 				call frisbee_setVelocities	;; transferimos la velocidad de la entidad al frisbee
                            333 
   0538                     334 	b_not_pressed:
   0538 C9            [10]  335 	ret
                            336 
