ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     0020     1 std_acc = 32 	;; standard acceleration per frame
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
                             16 .globl cpct_setVideoMemoryPage_asm
                             17 .globl cpct_akp_musicPlay_asm
                             18 .globl cpct_akp_stop_asm
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
                             23 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             24 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             25 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             26 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
                             27 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             28 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             29 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             30 .endm
                             31 
                             32 
                             33 ;; ====================================
                             34 ;; ====================================
                             35 ;; ENTITY PUBLIC DATA
                             36 ;; ====================================
                             37 ;; ====================================
                     0000    38 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    39 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    40 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    41 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    42 .equ Ent_h, 		4	;; Height
                     0005    43 .equ Ent_w, 		5	;; Width
                     0006    44 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    45 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    46 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    47 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    48 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    49 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    50 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    51 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    52 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    53 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    54 .equ Ent_last_x,	16	;; Last x rendered
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                     0011    55 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    56 .equ Ent_last_y,	18	;; Last y rendered
                     0013    57 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    58 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    59 .equ Ent_clr, 		21	;; Entity color pattern
                     0016    60 .equ Ent_id, 		22	;; Numeric ID
                             61 				;; Frisbee 	0
                             62 				;; Player1 	1
                             63 				;; Enemy1	2
                             64 
                     0003    65 .equ MAX_VEL_X, 3 
                     FFFFFFFD    66 .equ MIN_VEL_X, -3
                     0003    67 .equ MAX_VEL_Y, 3
                     FFFFFFFD    68 .equ MIN_VEL_Y, -3
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
                             13 .globl frisbee_checkGoal
                             14 	
                     0017    15 .equ Frisbee_effect_I, 23
                     0018    16 .equ Frisbee_effect_F, 24
                     0008    17 .equ std_eff, 0x0008
                     FFF8    18 .equ std_N_eff, 0xFFF8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 .include "game.h.s"
                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; GAME PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl gameStart
                              7 .globl getVideoPtr
                              8 .globl incTeam1Points
                              9 .globl incTeam2Points
                             10 .globl play_music	;; alomejor son privados
                             11 .globl stop_music	;; alomejor son privados
                             12 .globl game_data
                             13 
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; GAME PUBLIC DATA
                             17 ;; ====================================
                             18 ;; ====================================
                     0050    19 .equ RIGHT_LIMIT,	80
                     0000    20 .equ LEFT_LIMIT,	0
                     000A    21 .equ TOP_LIMIT,	 	10
                     00C8    22 .equ BOTTOM_LIMIT,	200
                     0028    23 .equ CENTER_LIMIT,	40
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
   041C                      25 _cpct_keyboardStatusBuffer:: .ds 10
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
   0426                      20 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xF0, #1
   000A                       1 	player_data::
   0426 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0428 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   042A 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   042B 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   042C 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   042E 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0430 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0432 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0434 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   0436 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0437 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0438 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0439 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   043A 01                   15 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   043B F0                   16 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   043C 01                   17 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             21 
   043D                      22 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xFF, #2
   0021                       1 	enemy_data::
   043D 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   043F 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0441 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   0442 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   0443 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0445 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0447 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0449 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   044B 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   044D 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   044E 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   044F 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0450 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0451 01                   15 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0452 FF                   16 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0453 02                   17 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             23 
                             24 
   0454                      25 defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xF0, #1
   0038                       1 	player_2_data::
   0454 10 00                 2 		player_2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0456 50 00                 3 		player_2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0458 14                    4 		player_2_h:	.db #20		;; Height			(8 bits)
   0459 05                    5 		player_2_w:	.db #5		;; Width			(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   045A 00 00                 6 		player_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   045C 00 00                 7 		player_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   045E 00 00                 8 		player_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0460 00 00                 9 		player_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0462 00 04                10 		player_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   0464 10                   11 		player_2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0465 10                   12 		player_2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0466 50                   13 		player_2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0467 50                   14 		player_2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0468 01                   15 		player_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0469 F0                   16 		player_2_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   046A 01                   17 		player_2_id:	.db #1		;; Numeric ID			(8 bits)
                             26 
                             27 
   046B                      28 defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xFF, #2
   004F                       1 	enemy_2_data::
   046B 4C 00                 2 		enemy_2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   046D 64 00                 3 		enemy_2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   046F 14                    4 		enemy_2_h:	.db #20		;; Height			(8 bits)
   0470 05                    5 		enemy_2_w:	.db #5		;; Width			(8 bits)
   0471 00 00                 6 		enemy_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0473 00 00                 7 		enemy_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0475 00 00                 8 		enemy_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0477 00 00                 9 		enemy_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0479 00 04                10 		enemy_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   047B 4C                   11 		enemy_2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   047C 4C                   12 		enemy_2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   047D 64                   13 		enemy_2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   047E 64                   14 		enemy_2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   047F 01                   15 		enemy_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0480 FF                   16 		enemy_2_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0481 02                   17 		enemy_2_id:	.db #2		;; Numeric ID			(8 bits)
                             29 	
                             30 ;; ====================================
                             31 ;; ====================================
                             32 ;; PUBLIC FUNCTIONS
                             33 ;; ====================================
                             34 ;; ====================================
   0482                      35 player_erase::
   0482 DD 21 26 04   [14]   36 	ld 	ix, #player_data
   0486 CD 38 01      [17]   37 	call 	entityErase		;; Erase player
   0489 DD 21 3D 04   [14]   38 	ld 	ix, #enemy_data
   048D CD 38 01      [17]   39 	call 	entityErase		;; Erase enemy
                             40 
   0490 C9            [10]   41 	ret
                             42 
                             43 ;; =========================================
                             44 ;; Actualiza el estado de los entities tipo
                             45 ;;	player
                             46 ;; Modifica: AF, IX
                             47 ;; =========================================
   0491                      48 player_update::
   0491 DD 21 26 04   [14]   49 	ld 	ix, #player_data
   0495 CD 2F 05      [17]   50 	call checkUserInput
                             51 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0498 DD 21 3D 04   [14]   52 	ld 	ix, #enemy_data
   049C CD 2F 05      [17]   53 	call checkUserInput
                             54 
                             55 ;;	ld	hl, #frisbee_data
                             56 ;;	push 	hl
                             57 ;;	ld	hl, #player_data
                             58 ;;	push 	hl
                             59 ;;	ld	hl, #enemy_data
                             60 ;;	push 	hl
                             61 ;;	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
                             62 ;;	pop 	af
                             63 ;;	pop 	af
                             64 ;;	pop 	af
                             65 
   049F DD 21 26 04   [14]   66 	ld 	ix, #player_data
   04A3 CD 52 01      [17]   67 	call entityUpdatePhysics
   04A6 DD 21 3D 04   [14]   68 	ld 	ix, #enemy_data
   04AA CD 52 01      [17]   69 	call entityUpdatePhysics
                             70 
   04AD DD 21 26 04   [14]   71 	ld 	ix, #player_data
   04B1 CD 60 02      [17]   72 	call entityUpdatePosition
   04B4 DD 21 3D 04   [14]   73 	ld 	ix, #enemy_data
   04B8 CD 60 02      [17]   74 	call entityUpdatePosition
                             75 
                             76 
   04BB DD 21 26 04   [14]   77 	ld 	ix, #player_data
   04BF CD 04 05      [17]   78 	call checkCenterCrossing
   04C2 DD 21 3D 04   [14]   79 	ld 	ix, #enemy_data
   04C6 CD 04 05      [17]   80 	call checkCenterCrossing
   04C9 C9            [10]   81 	ret
                             82 
   04CA                      83 player_draw::
   04CA DD 21 26 04   [14]   84 	ld 	ix, #player_data
   04CE CD 17 01      [17]   85 	call 	entityDraw		;; Draw player
   04D1 DD 21 3D 04   [14]   86 	ld 	ix, #enemy_data
   04D5 CD 17 01      [17]   87 	call 	entityDraw		;; Draw enemy
                             88 
   04D8 C9            [10]   89 	ret
                             90 	
                             91 ;; ====================================
                             92 ;; ====================================
                             93 ;; PRIVATE FUNCTIONS
                             94 ;; ====================================
                             95 ;; ====================================
                             96 
                             97 ;; =========================================
                             98 ;; Determina el siguiente estado de
                             99 ;;	la entidad
                            100 ;; Entrada:
                            101 ;; =========================================
   04D9                     102 delta:
                            103 
                            104 
   04D9                     105 update:
                            106 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            107 
                            108 ;; =========================================
                            109 ;; Comprueba si la entidad colisiona con 
                            110 ;; 	el frisbee
                            111 ;; Entrada:
                            112 ;; 	IX <= puntero al player a comparar
                            113 ;; 		con el frisbee
                            114 ;; Modifica: AF, B, HL, IX
                            115 ;; Devuelve:
                            116 ;; 	A <= 	0 si no hay colisión
                            117 ;; 		>1 si hay colisión
                            118 ;; =========================================
   04D9                     119 checkFrisbeeCollision:
   04D9 21 0D 03      [10]  120 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   04DC CD 0B 02      [17]  121 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            122 
   04DF C9            [10]  123 	ret
                            124 
                            125 
                            126 ;; ===============================================
                            127 ;; Acelera la entidad hacia la derecha, si puede
                            128 ;; Entrada:
                            129 ;; 	IX <= puntero a los datos de la entidad
                            130 ;; Modifica A, IX
                            131 ;; ===============================================
   04E0                     132 moveRight:
                            133 	;; push 	ix
                            134 	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
                            135 	;; pop 	ix
                            136 	;; cp 	#0			;; A == 0?
                            137 	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            138 
                            139 		;; no_collision
   04E0 DD 36 0A 00   [19]  140 		ld 	Ent_ax_I(ix), #0
   04E4 DD 36 0B 20   [19]  141 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            142 
                            143 
   04E8 C9            [10]  144 		ret
                            145 
                            146 	;;collision_right:
                            147 	;;	call 	frisbee_setOff
                            148 	;;
                            149 	;;	ret
                            150 
                            151 ;; ===============================================
                            152 ;; Acelera la entidad hacia abajo, si puede
                            153 ;; Entrada:
                            154 ;; 	IX <= puntero a los datos de la entidad
                            155 ;; Modifica A, IX
                            156 ;; ===============================================
   04E9                     157 moveDown:
   04E9 DD 36 0C 00   [19]  158 	ld 	Ent_ay_I(ix), #0
   04ED DD 36 0D 20   [19]  159 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            160 
   04F1 C9            [10]  161 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            162 
                            163 ;; ===============================================
                            164 ;; Acelera la entidad hacia la izquierda, si puede
                            165 ;; Entrada:
                            166 ;; 	IX <= puntero a los datos de la entidad
                            167 ;; Modifica A, IX
                            168 ;; ===============================================
   04F2                     169 moveLeft:
   04F2 DD 36 0A FF   [19]  170 	ld 	Ent_ax_I(ix), #-1
   04F6 DD 36 0B E0   [19]  171 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            172 
   04FA C9            [10]  173 	ret
                            174 
                            175 ;; ===============================================
                            176 ;; Acelera la entidad hacia arriba, si puede
                            177 ;; Entrada:
                            178 ;; 	IX <= puntero a los datos de la entidad
                            179 ;; Modifica A, IX
                            180 ;; ===============================================
   04FB                     181 moveUp:
   04FB DD 36 0C FF   [19]  182 	ld 	Ent_ay_I(ix), #-1
   04FF DD 36 0D E0   [19]  183 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            184 
   0503 C9            [10]  185 	ret
                            186 
                            187 
                            188 ;; ===========================================
                            189 ;; Chequea si un jugador pasa del centro del
                            190 ;; 	campo y lo corrige en caso necesario
                            191 ;; Entrada:
                            192 ;; 	IX <= pointer to entity data
                            193 ;; Modifica AF, BC, DE, HL
                            194 ;; ===========================================
   0504                     195 checkCenterCrossing:
   0504 DD 7E 16      [19]  196 	ld 	a, Ent_id(ix)
   0507 FE 01         [ 7]  197 	cp 	#1
   0509 28 11         [12]  198 	jr	z, player_1
   050B FE 02         [ 7]  199 		cp	#2
   050D 20 1F         [12]  200 		jr	nz, invalid_id
                            201 			;; player 2
   050F 3E 28         [ 7]  202 			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
   0511 DD BE 00      [19]  203 			cp	Ent_x_I(ix)
   0514 38 18         [12]  204 			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            205 				;; center limit crossed
   0516 DD 36 00 28   [19]  206 				ld	Ent_x_I(ix), #CENTER_LIMIT
   051A 18 12         [12]  207 				jr not_crossed
                            208 
   051C                     209 	player_1:
   051C DD 7E 00      [19]  210 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   051F DD 86 05      [19]  211 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   0522 FE 28         [ 7]  212 			cp	#CENTER_LIMIT
   0524 38 08         [12]  213 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            214 				;; center limit crossed
   0526 3E 28         [ 7]  215 				ld	a, #CENTER_LIMIT
   0528 DD 96 05      [19]  216 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   052B DD 77 00      [19]  217 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            218 
   052E                     219 	invalid_id:
   052E                     220 	not_crossed:
   052E C9            [10]  221 	ret
                            222 
                            223 
                            224 ;; ====================================
                            225 ;; Lee la entrada del teclado
                            226 ;; Entrada:
                            227 ;; 	IX <= pointer to entity data
                            228 ;; Modifica AF, BC, DE, HL, IX
                            229 ;; ====================================
   052F                     230 checkUserInput:
   052F CD 52 10      [17]  231 	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;
                            232 
   0532 DD 7E 16      [19]  233 	ld 	a, Ent_id(ix)
   0535 FE 01         [ 7]  234 	cp	#1
   0537 C2 70 05      [10]  235 	jp	nz, player_2
                            236 		;; Player 1
   053A 21 07 20      [10]  237 		ld 	hl, #Key_D			;; HL = D Keycode
   053D CD 10 07      [17]  238 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0540 FE 00         [ 7]  239 		cp 	#0 				;; A == 0?
   0542 28 03         [12]  240 		jr 	z, d_not_pressed
                            241 			;; D is pressed
   0544 CD E0 04      [17]  242 			call 	moveRight	
   0547                     243 		d_not_pressed:
                            244 
   0547 21 08 20      [10]  245 		ld 	hl, #Key_A			;; HL = A Keycode
   054A CD 10 07      [17]  246 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   054D FE 00         [ 7]  247 		cp 	#0 				;; A == 0?
   054F 28 03         [12]  248 		jr 	z, a_not_pressed
                            249 			;; A is pressed	
   0551 CD F2 04      [17]  250 			call 	moveLeft
   0554                     251 		a_not_pressed:
                            252 
   0554 21 07 08      [10]  253 		ld 	hl, #Key_W			;; HL = W Keycode
   0557 CD 10 07      [17]  254 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   055A FE 00         [ 7]  255 		cp 	#0 				;; A == 0?
   055C 28 03         [12]  256 		jr 	z, w_not_pressed
                            257 			;; W is pressed
   055E CD FB 04      [17]  258 			call 	moveUp	
   0561                     259 		w_not_pressed:
                            260 
   0561 21 07 10      [10]  261 		ld 	hl, #Key_S			;; HL = S Keycode
   0564 CD 10 07      [17]  262 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0567 FE 00         [ 7]  263 		cp 	#0 				;; A == 0?
   0569 28 03         [12]  264 		jr 	z, s_not_pressed
                            265 			;; S is pressed	
   056B CD E9 04      [17]  266 			call 	moveDown
   056E                     267 		s_not_pressed:
   056E 18 34         [12]  268 		jr five_not_pressed
                            269 
   0570                     270 	player_2:
   0570 21 00 10      [10]  271 		ld 	hl, #Key_F6			;; HL = F6 Keycode
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0573 CD 10 07      [17]  272 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0576 FE 00         [ 7]  273 		cp 	#0 				;; A == 0?
   0578 28 03         [12]  274 		jr 	z, six_not_pressed
                            275 			;; D is pressed
   057A CD E0 04      [17]  276 			call 	moveRight	
   057D                     277 		six_not_pressed:
                            278 
   057D 21 02 10      [10]  279 		ld 	hl, #Key_F4			;; HL = F4 Keycode
   0580 CD 10 07      [17]  280 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0583 FE 00         [ 7]  281 		cp 	#0 				;; A == 0?
   0585 28 03         [12]  282 		jr 	z, four_not_pressed
                            283 			;; A is pressed	
   0587 CD F2 04      [17]  284 			call 	moveLeft
   058A                     285 		four_not_pressed:
                            286 
   058A 21 01 08      [10]  287 		ld 	hl, #Key_F8			;; HL = F8 Keycode
   058D CD 10 07      [17]  288 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0590 FE 00         [ 7]  289 		cp 	#0 				;; A == 0?
   0592 28 03         [12]  290 		jr 	z, eight_not_pressed
                            291 			;; W is pressed
   0594 CD FB 04      [17]  292 			call 	moveUp	
   0597                     293 		eight_not_pressed:
                            294 
   0597 21 01 10      [10]  295 		ld 	hl, #Key_F5			;; HL = F5 Keycode
   059A CD 10 07      [17]  296 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   059D FE 00         [ 7]  297 		cp 	#0 				;; A == 0?
   059F 28 03         [12]  298 		jr 	z, five_not_pressed
                            299 			;; S is pressed	
   05A1 CD E9 04      [17]  300 			call 	moveDown
   05A4                     301 		five_not_pressed:
                            302 
                            303 
                            304 
   05A4 CD A8 05      [17]  305 	call checkVandB
   05A7 C9            [10]  306 	ret
                            307 
                            308 
                            309 ;; ====================================
                            310 ;; Funcion auxiliar para leer V y B
                            311 ;;	de la entrada por teclado
                            312 ;; Entrada:
                            313 ;; 	IX <= pointer to entity data
                            314 ;; Modifica AF, BC, DE, HL
                            315 ;; ====================================
   05A8                     316 checkVandB:
   05A8 DD E5         [15]  317 	push 	ix
   05AA CD D9 04      [17]  318 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   05AD DD E1         [14]  319 	pop 	ix
   05AF FE 00         [ 7]  320 	cp 	#0			;; A == 0?
   05B1 CA 5D 06      [10]  321 	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
                            322 		;; There is collision
                            323 
   05B4 DD 7E 16      [19]  324 		ld 	a, Ent_id(ix)
   05B7 FE 01         [ 7]  325 		cp	#1
   05B9 20 54         [12]  326 		jr	nz, player_2_vorb
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            327 			;; Player 1
                            328 
   05BB 21 06 80      [10]  329 			ld 	hl, #Key_V			;; HL = V Keycode
   05BE CD 10 07      [17]  330 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   05C1 FE 00         [ 7]  331 			cp 	#0 				;; A == 0?
   05C3 28 22         [12]  332 			jr 	z, v_not_pressed
                            333 				;; V is pressed	
   05C5 21 06 40      [10]  334 				ld 	hl, #Key_B			;; HL = B Keycode
   05C8 CD 10 07      [17]  335 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   05CB FE 00         [ 7]  336 				cp 	#0 				;; A == 0?
   05CD 28 0C         [12]  337 				jr 	z, just_v_pressed
                            338 					;; V and B are pressed
   05CF 21 00 00      [10]  339 					ld 	hl, #0			;; HL <= standard effect
   05D2 DD E5         [15]  340 					push 	ix
   05D4 CD AD 03      [17]  341 					call frisbee_setEffect		;; efecto hacia abajo
   05D7 DD E1         [14]  342 					pop 	ix
   05D9 18 20         [12]  343 					jr vorb_pressed
   05DB                     344 				just_v_pressed:
   05DB 21 F8 FF      [10]  345 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   05DE DD E5         [15]  346 					push 	ix
   05E0 CD AD 03      [17]  347 					call frisbee_setEffect		;; efecto hacia arriba
   05E3 DD E1         [14]  348 					pop 	ix
   05E5 18 14         [12]  349 					jr 	vorb_pressed
   05E7                     350 			v_not_pressed:
                            351 
   05E7 21 06 40      [10]  352 				ld 	hl, #Key_B			;; HL = B Keycode
   05EA CD 10 07      [17]  353 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   05ED FE 00         [ 7]  354 				cp 	#0 				;; A == 0?
   05EF 28 6C         [12]  355 				jr 	z, b_not_pressed
                            356 					;; B is pressed
   05F1 21 08 00      [10]  357 					ld 	hl, #std_eff		;; HL <= standard effect
   05F4 DD E5         [15]  358 					push 	ix
   05F6 CD AD 03      [17]  359 					call frisbee_setEffect		;; efecto hacia abajo
   05F9 DD E1         [14]  360 					pop 	ix
                            361 
   05FB                     362 					vorb_pressed:
   05FB DD 7E 16      [19]  363 					ld	a, Ent_id(ix)		;;
   05FE DD 66 06      [19]  364 					ld	h, Ent_vx_I(ix)		;;
   0601 DD 6E 07      [19]  365 					ld	l, Ent_vx_F(ix)		;;
   0604 DD 56 08      [19]  366 					ld	d, Ent_vy_I(ix)		;;
   0607 DD 5E 09      [19]  367 					ld	e, Ent_vy_F(ix)		;;
   060A CD 76 03      [17]  368 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            369 
   060D 18 4E         [12]  370 					jr o_not_pressed
   060F                     371 	player_2_vorb:
                            372 
   060F 21 04 08      [10]  373 			ld 	hl, #Key_I			;; HL = I Keycode
   0612 CD 10 07      [17]  374 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0615 FE 00         [ 7]  375 			cp 	#0 				;; A == 0?
   0617 28 1E         [12]  376 			jr 	z, i_not_pressed
                            377 				;; I is pressed	
   0619 21 04 04      [10]  378 				ld 	hl, #Key_O			;; HL = O Keycode
   061C CD 10 07      [17]  379 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   061F FE 00         [ 7]  380 				cp 	#0 				;; A == 0?
   0621 28 08         [12]  381 				jr 	z, just_i_pressed
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            382 					;; I and O are pressed
   0623 21 00 00      [10]  383 					ld 	hl, #0			;; HL <= standard effect
   0626 CD AD 03      [17]  384 					call frisbee_setEffect		;; efecto hacia abajo
   0629 18 20         [12]  385 					jr ioro_pressed
   062B                     386 				just_i_pressed:
   062B 21 F8 FF      [10]  387 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   062E DD E5         [15]  388 					push 	ix
   0630 CD AD 03      [17]  389 					call frisbee_setEffect		;; efecto hacia arriba
   0633 DD E1         [14]  390 					pop 	ix
   0635 18 14         [12]  391 					jr 	ioro_pressed
   0637                     392 			i_not_pressed:
                            393 
   0637 21 04 04      [10]  394 				ld 	hl, #Key_O			;; HL = O Keycode
   063A CD 10 07      [17]  395 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   063D FE 00         [ 7]  396 				cp 	#0 				;; A == 0?
   063F 28 1C         [12]  397 				jr 	z, o_not_pressed
                            398 					;; O is pressed
   0641 21 08 00      [10]  399 					ld 	hl, #std_eff		;; HL <= standard effect
   0644 DD E5         [15]  400 					push 	ix
   0646 CD AD 03      [17]  401 					call frisbee_setEffect		;; efecto hacia abajo
   0649 DD E1         [14]  402 					pop 	ix
                            403 
   064B                     404 					ioro_pressed:
   064B DD 7E 16      [19]  405 					ld	a, Ent_id(ix)		;;
   064E DD 66 06      [19]  406 					ld	h, Ent_vx_I(ix)		;;
   0651 DD 6E 07      [19]  407 					ld	l, Ent_vx_F(ix)		;;
   0654 DD 56 08      [19]  408 					ld	d, Ent_vy_I(ix)		;;
   0657 DD 5E 09      [19]  409 					ld	e, Ent_vy_F(ix)		;;
   065A CD 76 03      [17]  410 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            411 
                            412 
   065D                     413 	no_collision:
   065D                     414 	b_not_pressed:
   065D                     415 	o_not_pressed:
   065D C9            [10]  416 	ret
