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
                             14 .globl cpct_memcpy_asm
                             15 .globl negateHL
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
                     0008    16 .equ std_eff, 0x0008
                     FFF8    17 .equ std_N_eff, 0xFFF8
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
                              8 .macro defineGame name, type, map, fTime, t1points, t2points
                              9 	name'_data::
                             10 		name'_type::	.db type	;; Game Mode			(8 bits)
                             11 		name'_map::	.dw map		;; Pointer to map of tiles	(16 bits little endian)
                             12 		name'_fTime::	.dw fTime	;; Final duration of each match	(16 bits)
                             13 		name'_t1points:: .db t1points 	;; Points of team 1		(8 bits)
                             14 		name'_t2points:: .db t2points 	;; Points of team 2		(8 bits)
                             15 .endm
                             16 
                             17 ;; ====================================
                             18 ;; ====================================
                             19 ;; GAME PUBLIC DATA
                             20 ;; ====================================
                             21 ;; ====================================
                     0000    22 .equ Game_type, 	0	;; Game mode
                     0001    23 .equ Game_map_L, 	1	;; Low part of pointer to game map
                     0002    24 .equ Game_map_H, 	2	;; High part of pointer to game map
                     0003    25 .equ Game_fTime_H, 	3	;; High part of final match time
                     0004    26 .equ Game_fTime_L, 	4	;; Low part of final match time
                     0005    27 .equ Game_t1points, 	5	;; Points of team 1
                     0006    28 .equ Game_t2points, 	6	;; Points of team 2
                             29 
                     0050    30 .equ RIGHT_LIMIT,	80
                     0000    31 .equ LEFT_LIMIT,	0
                     000A    32 .equ TOP_LIMIT,	 	10
                     00C8    33 .equ BOTTOM_LIMIT,	200
                     0028    34 .equ CENTER_LIMIT,	40
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
   03F1                      25 _cpct_keyboardStatusBuffer:: .ds 10
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
                             18 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             19 
   03FB                      20 defineEntity player, #0x0010, #0x0050, #16, #4, #0000, #0000, #0000, #0000, #0x0800, #1, #0xF0, #1
   000A                       1 	player_data::
   03FB 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   03FD 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   03FF 10                    4 		player_h:	.db #16		;; Height			(8 bits)
   0400 04                    5 		player_w:	.db #4		;; Width			(8 bits)
   0401 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0403 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0405 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0407 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0409 00 08                10 		player_normal:	.dw #0x0800	;; Normal force			(16 bits)
   040B 01                   11 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   040C F0                   12 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   040D 01                   13 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             21 
   040E                      22 defineEntity enemy, #0x0050-0x0004, #0x0064, #16, #4, #0000, #0000, #0000, #0000, #0x0800, #1, #0xFF, #2
   001D                       1 	enemy_data::
   040E 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0410 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0412 10                    4 		enemy_h:	.db #16		;; Height			(8 bits)
   0413 04                    5 		enemy_w:	.db #4		;; Width			(8 bits)
   0414 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0416 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0418 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   041A 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   041C 00 08                10 		enemy_normal:	.dw #0x0800	;; Normal force			(16 bits)
   041E 01                   11 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   041F FF                   12 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0420 02                   13 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             23 
                             24 	
                             25 ;; ====================================
                             26 ;; ====================================
                             27 ;; PUBLIC FUNCTIONS
                             28 ;; ====================================
                             29 ;; ====================================
   0421                      30 player_erase::
   0421 DD 21 FB 03   [14]   31 	ld 	ix, #player_data
   0425 CD 1B 01      [17]   32 	call 	entityErase		;; Erase player
   0428 DD 21 0E 04   [14]   33 	ld 	ix, #enemy_data
   042C CD 1B 01      [17]   34 	call 	entityErase		;; Erase enemy
                             35 
   042F C9            [10]   36 	ret
                             37 
                             38 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             39 ;; Actualiza el estado de los entities tipo
                             40 ;;	player
                             41 ;; Modifica: AF, IX
                             42 ;; =========================================
   0430                      43 player_update::
   0430 DD 21 FB 03   [14]   44 	ld 	ix, #player_data
   0434 CD D7 04      [17]   45 	call checkUserInput
                             46 
   0437 21 CB 02      [10]   47 	ld	hl, #frisbee_data
   043A E5            [11]   48 	push 	hl
   043B 21 FB 03      [10]   49 	ld	hl, #player_data
   043E E5            [11]   50 	push 	hl
   043F 21 0E 04      [10]   51 	ld	hl, #enemy_data
   0442 E5            [11]   52 	push 	hl
   0443 CD 00 01      [17]   53 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
   0446 F1            [10]   54 	pop 	af
   0447 F1            [10]   55 	pop 	af
   0448 F1            [10]   56 	pop 	af
                             57 
   0449 DD 21 FB 03   [14]   58 	ld 	ix, #player_data
   044D CD 34 01      [17]   59 	call entityUpdatePhysics
   0450 DD 21 0E 04   [14]   60 	ld 	ix, #enemy_data
   0454 CD 34 01      [17]   61 	call entityUpdatePhysics
                             62 
   0457 DD 21 FB 03   [14]   63 	ld 	ix, #player_data
   045B CD 3C 02      [17]   64 	call entityUpdatePosition
   045E DD 21 0E 04   [14]   65 	ld 	ix, #enemy_data
   0462 CD 3C 02      [17]   66 	call entityUpdatePosition
                             67 
                             68 
   0465 DD 21 FB 03   [14]   69 	ld 	ix, #player_data
   0469 CD AE 04      [17]   70 	call checkCenterCrossing
   046C DD 21 0E 04   [14]   71 	ld 	ix, #enemy_data
   0470 CD AE 04      [17]   72 	call checkCenterCrossing
   0473 C9            [10]   73 	ret
                             74 
   0474                      75 player_draw::
   0474 DD 21 FB 03   [14]   76 	ld 	ix, #player_data
   0478 CD 01 01      [17]   77 	call 	entityDraw		;; Draw player
   047B DD 21 0E 04   [14]   78 	ld 	ix, #enemy_data
   047F CD 01 01      [17]   79 	call 	entityDraw		;; Draw enemy
                             80 
   0482 C9            [10]   81 	ret
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



   0483                      94 delta:
                             95 
                             96 
   0483                      97 update:
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
   0483                     111 checkFrisbeeCollision:
   0483 21 CB 02      [10]  112 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   0486 CD E7 01      [17]  113 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            114 
   0489 C9            [10]  115 	ret
                            116 
                            117 
                            118 ;; ===============================================
                            119 ;; Acelera la entidad hacia la derecha, si puede
                            120 ;; Entrada:
                            121 ;; 	IX <= puntero a los datos de la entidad
                            122 ;; Modifica A, IX
                            123 ;; ===============================================
   048A                     124 moveRight:
                            125 	;; push 	ix
                            126 	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
                            127 	;; pop 	ix
                            128 	;; cp 	#0			;; A == 0?
                            129 	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            130 
                            131 		;; no_collision
   048A DD 36 0A 00   [19]  132 		ld 	Ent_ax_I(ix), #0
   048E DD 36 0B 10   [19]  133 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            134 
                            135 
   0492 C9            [10]  136 		ret
                            137 
                            138 	;;collision_right:
                            139 	;;	call 	frisbee_setOff
                            140 	;;
                            141 	;;	ret
                            142 
                            143 ;; ===============================================
                            144 ;; Acelera la entidad hacia abajo, si puede
                            145 ;; Entrada:
                            146 ;; 	IX <= puntero a los datos de la entidad
                            147 ;; Modifica A, IX
                            148 ;; ===============================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0493                     149 moveDown:
   0493 DD 36 0C 00   [19]  150 	ld 	Ent_ay_I(ix), #0
   0497 DD 36 0D 10   [19]  151 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            152 
   049B C9            [10]  153 	ret
                            154 
                            155 ;; ===============================================
                            156 ;; Acelera la entidad hacia la izquierda, si puede
                            157 ;; Entrada:
                            158 ;; 	IX <= puntero a los datos de la entidad
                            159 ;; Modifica A, IX
                            160 ;; ===============================================
   049C                     161 moveLeft:
   049C DD 36 0A FF   [19]  162 	ld 	Ent_ax_I(ix), #-1
   04A0 DD 36 0B F0   [19]  163 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            164 
   04A4 C9            [10]  165 	ret
                            166 
                            167 ;; ===============================================
                            168 ;; Acelera la entidad hacia arriba, si puede
                            169 ;; Entrada:
                            170 ;; 	IX <= puntero a los datos de la entidad
                            171 ;; Modifica A, IX
                            172 ;; ===============================================
   04A5                     173 moveUp:
   04A5 DD 36 0C FF   [19]  174 	ld 	Ent_ay_I(ix), #-1
   04A9 DD 36 0D F0   [19]  175 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            176 
   04AD C9            [10]  177 	ret
                            178 
                            179 
                            180 ;; ===========================================
                            181 ;; Chequea si un jugador pasa del centro del
                            182 ;; 	campo y lo corrige en caso necesario
                            183 ;; Entrada:
                            184 ;; 	IX <= pointer to entity data
                            185 ;; Modifica AF, BC, DE, HL
                            186 ;; ===========================================
   04AE                     187 checkCenterCrossing:
   04AE DD 7E 12      [19]  188 	ld 	a, Ent_id(ix)
   04B1 FE 01         [ 7]  189 	cp 	#1
   04B3 28 0F         [12]  190 	jr	z, player_1
   04B5 FE 02         [ 7]  191 		cp	#2
   04B7 20 1D         [12]  192 		jr	nz, invalid_id
                            193 			;; player 2
   04B9 DD 7E 00      [19]  194 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   04BC FE 28         [ 7]  195 			cp	#CENTER_LIMIT
   04BE 30 16         [12]  196 			jr	nc, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            197 				;; center limit crossed
   04C0 DD 36 00 28   [19]  198 				ld	Ent_x_I(ix), #CENTER_LIMIT
                            199 
   04C4                     200 	player_1:
   04C4 DD 7E 00      [19]  201 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   04C7 DD 86 05      [19]  202 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   04CA FE 28         [ 7]  203 			cp	#CENTER_LIMIT
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   04CC 38 08         [12]  204 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            205 				;; center limit crossed
   04CE 3E 28         [ 7]  206 				ld	a, #CENTER_LIMIT
   04D0 DD 96 05      [19]  207 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   04D3 DD 77 00      [19]  208 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            209 
   04D6                     210 	invalid_id:
   04D6                     211 	not_crossed:
   04D6 C9            [10]  212 	ret
                            213 
                            214 
                            215 ;; ====================================
                            216 ;; Lee la entrada del teclado
                            217 ;; Entrada:
                            218 ;; 	IX <= pointer to entity data
                            219 ;; Modifica AF, BC, DE, HL, IX
                            220 ;; ====================================
   04D7                     221 checkUserInput:
   04D7 CD AD 06      [17]  222 	call cpct_scanKeyboard_asm
                            223 
   04DA 21 07 20      [10]  224 	ld 	hl, #Key_D			;; HL = D Keycode
   04DD CD 9D 05      [17]  225 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04E0 FE 00         [ 7]  226 	cp 	#0 				;; A == 0?
   04E2 28 03         [12]  227 	jr 	z, d_not_pressed
                            228 		;; D is pressed
   04E4 CD 8A 04      [17]  229 		call 	moveRight	
   04E7                     230 	d_not_pressed:
                            231 
   04E7 21 08 20      [10]  232 	ld 	hl, #Key_A			;; HL = A Keycode
   04EA CD 9D 05      [17]  233 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04ED FE 00         [ 7]  234 	cp 	#0 				;; A == 0?
   04EF 28 03         [12]  235 	jr 	z, a_not_pressed
                            236 		;; A is pressed	
   04F1 CD 9C 04      [17]  237 		call 	moveLeft
   04F4                     238 	a_not_pressed:
                            239 
   04F4 21 07 08      [10]  240 	ld 	hl, #Key_W			;; HL = W Keycode
   04F7 CD 9D 05      [17]  241 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   04FA FE 00         [ 7]  242 	cp 	#0 				;; A == 0?
   04FC 28 03         [12]  243 	jr 	z, w_not_pressed
                            244 		;; W is pressed
   04FE CD A5 04      [17]  245 		call 	moveUp	
   0501                     246 	w_not_pressed:
                            247 
   0501 21 07 10      [10]  248 	ld 	hl, #Key_S			;; HL = S Keycode
   0504 CD 9D 05      [17]  249 	call 	cpct_isKeyPressed_asm 		;; A = True/False
   0507 FE 00         [ 7]  250 	cp 	#0 				;; A == 0?
   0509 28 03         [12]  251 	jr 	z, s_not_pressed
                            252 		;; S is pressed	
   050B CD 93 04      [17]  253 		call 	moveDown
   050E                     254 	s_not_pressed:
                            255 
                            256 
   050E CD 12 05      [17]  257 	call checkVandB
   0511 C9            [10]  258 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            259 
                            260 
                            261 ;; ====================================
                            262 ;; Funcion auxiliar para leer V y B
                            263 ;;	de la entrada por teclado
                            264 ;; Entrada:
                            265 ;; 	IX <= pointer to entity data
                            266 ;; Modifica AF, BC, DE, HL
                            267 ;; ====================================
   0512                     268 checkVandB:
   0512 DD E5         [15]  269 	push 	ix
   0514 CD 83 04      [17]  270 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0517 DD E1         [14]  271 	pop 	ix
   0519 FE 00         [ 7]  272 	cp 	#0			;; A == 0?
   051B 28 4B         [12]  273 	jr	z, b_not_pressed 	;; checkFrisbeeCollision == 0?
                            274 
   051D 21 06 80      [10]  275 		ld 	hl, #Key_V			;; HL = V Keycode
   0520 CD 9D 05      [17]  276 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0523 FE 00         [ 7]  277 		cp 	#0 				;; A == 0?
   0525 28 1E         [12]  278 		jr 	z, v_not_pressed
                            279 			;; V is pressed	
   0527 21 06 40      [10]  280 			ld 	hl, #Key_B			;; HL = B Keycode
   052A CD 9D 05      [17]  281 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   052D FE 00         [ 7]  282 			cp 	#0 				;; A == 0?
   052F 28 08         [12]  283 			jr 	z, just_v_pressed
                            284 				;; V and B are pressed
   0531 21 00 00      [10]  285 				ld 	hl, #0			;; HL <= standard effect
   0534 CD 20 03      [17]  286 				call frisbee_setEffect		;; efecto hacia abajo
   0537 18 20         [12]  287 				jr vorb_pressed
   0539                     288 			just_v_pressed:
   0539 21 F8 FF      [10]  289 				ld 	hl, #std_N_eff		;; HL <= -standard effect
   053C DD E5         [15]  290 				push 	ix
   053E CD 20 03      [17]  291 				call frisbee_setEffect		;; efecto hacia arriba
   0541 DD E1         [14]  292 				pop 	ix
   0543 18 14         [12]  293 				jr 	vorb_pressed
   0545                     294 		v_not_pressed:
                            295 
   0545 21 06 40      [10]  296 			ld 	hl, #Key_B			;; HL = B Keycode
   0548 CD 9D 05      [17]  297 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   054B FE 00         [ 7]  298 			cp 	#0 				;; A == 0?
   054D 28 19         [12]  299 			jr 	z, b_not_pressed
                            300 				;; B is pressed
   054F 21 08 00      [10]  301 				ld 	hl, #std_eff		;; HL <= standard effect
   0552 DD E5         [15]  302 				push 	ix
   0554 CD 20 03      [17]  303 				call frisbee_setEffect		;; efecto hacia abajo
   0557 DD E1         [14]  304 				pop 	ix
                            305 
   0559                     306 				vorb_pressed:
   0559 DD 66 06      [19]  307 				ld	h, Ent_vx_I(ix)		;;
   055C DD 6E 07      [19]  308 				ld	l, Ent_vx_F(ix)		;;
   055F DD 56 08      [19]  309 				ld	d, Ent_vy_I(ix)		;;
   0562 DD 5E 09      [19]  310 				ld	e, Ent_vy_F(ix)		;;
   0565 CD 0F 03      [17]  311 				call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            312 
   0568                     313 	b_not_pressed:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0568 C9            [10]  314 	ret
