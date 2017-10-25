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
   0C52                      25 _cpct_keyboardStatusBuffer:: .ds 10
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
   0C5C                      20 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xF0, #1
   000A                       1 	player_data::
   0C5C 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0C5E 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0C60 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   0C61 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   0C62 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0C64 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0C66 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0C68 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0C6A 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   0C6C 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0C6D 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0C6E 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0C6F 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0C70 01                   15 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0C71 F0                   16 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0C72 01                   17 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             21 
   0C73                      22 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xFF, #2
   0021                       1 	enemy_data::
   0C73 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0C75 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0C77 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   0C78 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   0C79 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0C7B 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0C7D 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0C7F 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0C81 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   0C83 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   0C84 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   0C85 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0C86 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0C87 01                   15 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0C88 FF                   16 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0C89 02                   17 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             23 
                             24 
   0C8A                      25 defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xF0, #1
   0038                       1 	player_2_data::
   0C8A 10 00                 2 		player_2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0C8C 50 00                 3 		player_2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0C8E 14                    4 		player_2_h:	.db #20		;; Height			(8 bits)
   0C8F 05                    5 		player_2_w:	.db #5		;; Width			(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   0C90 00 00                 6 		player_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0C92 00 00                 7 		player_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0C94 00 00                 8 		player_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0C96 00 00                 9 		player_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0C98 00 04                10 		player_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   0C9A 10                   11 		player_2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0C9B 10                   12 		player_2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0C9C 50                   13 		player_2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0C9D 50                   14 		player_2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0C9E 01                   15 		player_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0C9F F0                   16 		player_2_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0CA0 01                   17 		player_2_id:	.db #1		;; Numeric ID			(8 bits)
                             26 
                             27 
   0CA1                      28 defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xFF, #2
   004F                       1 	enemy_2_data::
   0CA1 4C 00                 2 		enemy_2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0CA3 64 00                 3 		enemy_2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0CA5 14                    4 		enemy_2_h:	.db #20		;; Height			(8 bits)
   0CA6 05                    5 		enemy_2_w:	.db #5		;; Width			(8 bits)
   0CA7 00 00                 6 		enemy_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0CA9 00 00                 7 		enemy_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0CAB 00 00                 8 		enemy_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0CAD 00 00                 9 		enemy_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0CAF 00 04                10 		enemy_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   0CB1 4C                   11 		enemy_2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   0CB2 4C                   12 		enemy_2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   0CB3 64                   13 		enemy_2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0CB4 64                   14 		enemy_2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0CB5 01                   15 		enemy_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0CB6 FF                   16 		enemy_2_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0CB7 02                   17 		enemy_2_id:	.db #2		;; Numeric ID			(8 bits)
                             29 	
                             30 ;; ====================================
                             31 ;; ====================================
                             32 ;; PUBLIC FUNCTIONS
                             33 ;; ====================================
                             34 ;; ====================================
   0CB8                      35 player_erase::
   0CB8 DD 21 5C 0C   [14]   36 	ld 	ix, #player_data
   0CBC CD 22 09      [17]   37 	call 	entityErase		;; Erase player
   0CBF DD 21 73 0C   [14]   38 	ld 	ix, #enemy_data
   0CC3 CD 22 09      [17]   39 	call 	entityErase		;; Erase enemy
                             40 
   0CC6 C9            [10]   41 	ret
                             42 
                             43 ;; =========================================
                             44 ;; Actualiza el estado de los entities tipo
                             45 ;;	player
                             46 ;; Modifica: AF, IX
                             47 ;; =========================================
   0CC7                      48 player_update::
   0CC7 DD 21 5C 0C   [14]   49 	ld 	ix, #player_data
   0CCB CD CC 0D      [17]   50 	call checkUserInput
                             51 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             52 ;;	ld 	ix, #enemy_data
                             53 ;;	call checkUserInput
                             54 
   0CCE CD 3C 0D      [17]   55 	call move_IA
                             56 
   0CD1 DD 21 5C 0C   [14]   57 	ld 	ix, #player_data
   0CD5 CD 3C 09      [17]   58 	call entityUpdatePhysics
   0CD8 DD 21 73 0C   [14]   59 	ld 	ix, #enemy_data
   0CDC CD 3C 09      [17]   60 	call entityUpdatePhysics
                             61 
   0CDF DD 21 5C 0C   [14]   62 	ld 	ix, #player_data
   0CE3 CD 96 0A      [17]   63 	call entityUpdatePosition
   0CE6 DD 21 73 0C   [14]   64 	ld 	ix, #enemy_data
   0CEA CD 96 0A      [17]   65 	call entityUpdatePosition
                             66 
                             67 
   0CED DD 21 5C 0C   [14]   68 	ld 	ix, #player_data
   0CF1 CD A1 0D      [17]   69 	call checkCenterCrossing
   0CF4 DD 21 73 0C   [14]   70 	ld 	ix, #enemy_data
   0CF8 CD A1 0D      [17]   71 	call checkCenterCrossing
   0CFB C9            [10]   72 	ret
                             73 
   0CFC                      74 player_draw::
   0CFC DD 21 5C 0C   [14]   75 	ld 	ix, #player_data
   0D00 CD 01 09      [17]   76 	call 	entityDraw		;; Draw player
   0D03 DD 21 73 0C   [14]   77 	ld 	ix, #enemy_data
   0D07 CD 01 09      [17]   78 	call 	entityDraw		;; Draw enemy
                             79 
   0D0A C9            [10]   80 	ret
                             81 	
                             82 ;; ====================================
                             83 ;; ====================================
                             84 ;; PRIVATE FUNCTIONS
                             85 ;; ====================================
                             86 ;; ====================================
                             87 
                             88 ;; =========================================
                             89 ;; Determina el siguiente estado de
                             90 ;;	la entidad
                             91 ;; Entrada:
                             92 ;; =========================================
   0D0B                      93 delta:
                             94 
                             95 
   0D0B                      96 update:
                             97 
                             98 ;; =========================================
                             99 ;; Invierte los datos para poder operarlos
                            100 ;;	en C
                            101 ;; Entrada:
                            102 ;;	IX <= Pointer to entity data
                            103 ;;	Modifica: BC
                            104 ;; =========================================
   0D0B                     105 invert_variables:
                            106 	;; Inverts X
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0D0B DD 46 00      [19]  107 	ld	b,	Ent_x_I(ix)
   0D0E DD 4E 01      [19]  108 	ld	c,	Ent_x_F(ix)
   0D11 DD 71 00      [19]  109 	ld	Ent_x_I(ix), c
   0D14 DD 70 01      [19]  110 	ld	Ent_x_F(ix), b
                            111 
                            112 	;; Inverts Y
   0D17 DD 46 02      [19]  113 	ld	b,	Ent_y_I(ix)
   0D1A DD 4E 03      [19]  114 	ld	c,	Ent_y_F(ix)
   0D1D DD 71 02      [19]  115 	ld	Ent_y_I(ix), c
   0D20 DD 70 03      [19]  116 	ld	Ent_y_F(ix), b
                            117 
                            118 	;; Inverts AX
   0D23 DD 46 0A      [19]  119 	ld	b, Ent_ax_I(ix)		 
   0D26 DD 4E 0B      [19]  120 	ld	c, Ent_ax_F(ix)		 
   0D29 DD 71 0A      [19]  121 	ld	Ent_ax_I(ix), c		 
   0D2C DD 70 0B      [19]  122 	ld	Ent_ax_F(ix), b		
                            123 
                            124 	;; Inverts AY
   0D2F DD 46 0C      [19]  125 	ld	b, Ent_ay_I(ix)		 
   0D32 DD 4E 0D      [19]  126 	ld	c, Ent_ay_F(ix)		 
   0D35 DD 71 0C      [19]  127 	ld	Ent_ay_I(ix), c		 
   0D38 DD 70 0D      [19]  128 	ld	Ent_ay_F(ix), b		
                            129 
                            130 	;; FALTARIA EFECTO, CUIDAO
                            131 
   0D3B C9            [10]  132 	ret
                            133 
   0D3C                     134 move_IA:
                            135 
   0D3C DD 21 43 0B   [14]  136 	ld	ix, #frisbee_data
   0D40 DD E5         [15]  137 	push 	ix
   0D42 CD 0B 0D      [17]  138 	call 	invert_variables
   0D45 DD 21 5C 0C   [14]  139 	ld	ix, #player_data
   0D49 DD E5         [15]  140 	push 	ix
   0D4B CD 0B 0D      [17]  141 	call 	invert_variables
   0D4E DD 21 73 0C   [14]  142 	ld	ix, #enemy_data
   0D52 DD E5         [15]  143 	push 	ix
   0D54 CD 0B 0D      [17]  144 	call 	invert_variables
   0D57 CD B1 08      [17]  145 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
                            146 	
   0D5A DD E1         [14]  147 	pop 	ix
   0D5C DD E1         [14]  148 	pop 	ix
   0D5E DD E1         [14]  149 	pop 	ix
                            150 
   0D60 DD 21 43 0B   [14]  151 	ld	ix, #frisbee_data
   0D64 CD 0B 0D      [17]  152 	call 	invert_variables
   0D67 DD 21 5C 0C   [14]  153 	ld	ix, #player_data
   0D6B CD 0B 0D      [17]  154 	call 	invert_variables
   0D6E DD 21 73 0C   [14]  155 	ld	ix, #enemy_data
   0D72 CD 0B 0D      [17]  156 	call 	invert_variables
                            157 
                            158 
   0D75 C9            [10]  159 	ret
                            160 	
                            161 ;; =========================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            162 ;; Comprueba si la entidad colisiona con 
                            163 ;; 	el frisbee
                            164 ;; Entrada:
                            165 ;; 	IX <= puntero al player a comparar
                            166 ;; 		con el frisbee
                            167 ;; Modifica: AF, B, HL, IX
                            168 ;; Devuelve:
                            169 ;; 	A <= 	0 si no hay colisión
                            170 ;; 		>1 si hay colisión
                            171 ;; =========================================
   0D76                     172 checkFrisbeeCollision:
   0D76 21 43 0B      [10]  173 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   0D79 CD 41 0A      [17]  174 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            175 
   0D7C C9            [10]  176 	ret
                            177 
                            178 
                            179 ;; ===============================================
                            180 ;; Acelera la entidad hacia la derecha, si puede
                            181 ;; Entrada:
                            182 ;; 	IX <= puntero a los datos de la entidad
                            183 ;; Modifica A, IX
                            184 ;; ===============================================
   0D7D                     185 moveRight:
                            186 	;; push 	ix
                            187 	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
                            188 	;; pop 	ix
                            189 	;; cp 	#0			;; A == 0?
                            190 	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            191 
                            192 		;; no_collision
   0D7D DD 36 0A 00   [19]  193 		ld 	Ent_ax_I(ix), #0
   0D81 DD 36 0B 20   [19]  194 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            195 
                            196 
   0D85 C9            [10]  197 		ret
                            198 
                            199 	;;collision_right:
                            200 	;;	call 	frisbee_setOff
                            201 	;;
                            202 	;;	ret
                            203 
                            204 ;; ===============================================
                            205 ;; Acelera la entidad hacia abajo, si puede
                            206 ;; Entrada:
                            207 ;; 	IX <= puntero a los datos de la entidad
                            208 ;; Modifica A, IX
                            209 ;; ===============================================
   0D86                     210 moveDown:
   0D86 DD 36 0C 00   [19]  211 	ld 	Ent_ay_I(ix), #0
   0D8A DD 36 0D 20   [19]  212 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            213 
   0D8E C9            [10]  214 	ret
                            215 
                            216 ;; ===============================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            217 ;; Acelera la entidad hacia la izquierda, si puede
                            218 ;; Entrada:
                            219 ;; 	IX <= puntero a los datos de la entidad
                            220 ;; Modifica A, IX
                            221 ;; ===============================================
   0D8F                     222 moveLeft:
   0D8F DD 36 0A FF   [19]  223 	ld 	Ent_ax_I(ix), #-1
   0D93 DD 36 0B E0   [19]  224 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            225 
   0D97 C9            [10]  226 	ret
                            227 
                            228 ;; ===============================================
                            229 ;; Acelera la entidad hacia arriba, si puede
                            230 ;; Entrada:
                            231 ;; 	IX <= puntero a los datos de la entidad
                            232 ;; Modifica A, IX
                            233 ;; ===============================================
   0D98                     234 moveUp:
   0D98 DD 36 0C FF   [19]  235 	ld 	Ent_ay_I(ix), #-1
   0D9C DD 36 0D E0   [19]  236 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            237 
   0DA0 C9            [10]  238 	ret
                            239 
                            240 
                            241 ;; ===========================================
                            242 ;; Chequea si un jugador pasa del centro del
                            243 ;; 	campo y lo corrige en caso necesario
                            244 ;; Entrada:
                            245 ;; 	IX <= pointer to entity data
                            246 ;; Modifica AF, BC, DE, HL
                            247 ;; ===========================================
   0DA1                     248 checkCenterCrossing:
   0DA1 DD 7E 16      [19]  249 	ld 	a, Ent_id(ix)
   0DA4 FE 01         [ 7]  250 	cp 	#1
   0DA6 28 11         [12]  251 	jr	z, player_1
   0DA8 FE 02         [ 7]  252 		cp	#2
   0DAA 20 1F         [12]  253 		jr	nz, invalid_id
                            254 			;; player 2
   0DAC 3E 28         [ 7]  255 			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
   0DAE DD BE 00      [19]  256 			cp	Ent_x_I(ix)
   0DB1 38 18         [12]  257 			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            258 				;; center limit crossed
   0DB3 DD 36 00 28   [19]  259 				ld	Ent_x_I(ix), #CENTER_LIMIT
   0DB7 18 12         [12]  260 				jr not_crossed
                            261 
   0DB9                     262 	player_1:
   0DB9 DD 7E 00      [19]  263 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   0DBC DD 86 05      [19]  264 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   0DBF FE 28         [ 7]  265 			cp	#CENTER_LIMIT
   0DC1 38 08         [12]  266 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            267 				;; center limit crossed
   0DC3 3E 28         [ 7]  268 				ld	a, #CENTER_LIMIT
   0DC5 DD 96 05      [19]  269 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   0DC8 DD 77 00      [19]  270 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            271 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0DCB                     272 	invalid_id:
   0DCB                     273 	not_crossed:
   0DCB C9            [10]  274 	ret
                            275 
                            276 
                            277 ;; ====================================
                            278 ;; Lee la entrada del teclado
                            279 ;; Entrada:
                            280 ;; 	IX <= pointer to entity data
                            281 ;; Modifica AF, BC, DE, HL, IX
                            282 ;; ====================================
   0DCC                     283 checkUserInput:
   0DCC CD 4C 19      [17]  284 	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;
                            285 
   0DCF DD 7E 16      [19]  286 	ld 	a, Ent_id(ix)
   0DD2 FE 01         [ 7]  287 	cp	#1
   0DD4 C2 0D 0E      [10]  288 	jp	nz, player_2
                            289 		;; Player 1
   0DD7 21 07 20      [10]  290 		ld 	hl, #Key_D			;; HL = D Keycode
   0DDA CD EE 0F      [17]  291 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DDD FE 00         [ 7]  292 		cp 	#0 				;; A == 0?
   0DDF 28 03         [12]  293 		jr 	z, d_not_pressed
                            294 			;; D is pressed
   0DE1 CD 7D 0D      [17]  295 			call 	moveRight	
   0DE4                     296 		d_not_pressed:
                            297 
   0DE4 21 08 20      [10]  298 		ld 	hl, #Key_A			;; HL = A Keycode
   0DE7 CD EE 0F      [17]  299 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DEA FE 00         [ 7]  300 		cp 	#0 				;; A == 0?
   0DEC 28 03         [12]  301 		jr 	z, a_not_pressed
                            302 			;; A is pressed	
   0DEE CD 8F 0D      [17]  303 			call 	moveLeft
   0DF1                     304 		a_not_pressed:
                            305 
   0DF1 21 07 08      [10]  306 		ld 	hl, #Key_W			;; HL = W Keycode
   0DF4 CD EE 0F      [17]  307 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DF7 FE 00         [ 7]  308 		cp 	#0 				;; A == 0?
   0DF9 28 03         [12]  309 		jr 	z, w_not_pressed
                            310 			;; W is pressed
   0DFB CD 98 0D      [17]  311 			call 	moveUp	
   0DFE                     312 		w_not_pressed:
                            313 
   0DFE 21 07 10      [10]  314 		ld 	hl, #Key_S			;; HL = S Keycode
   0E01 CD EE 0F      [17]  315 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E04 FE 00         [ 7]  316 		cp 	#0 				;; A == 0?
   0E06 28 03         [12]  317 		jr 	z, s_not_pressed
                            318 			;; S is pressed	
   0E08 CD 86 0D      [17]  319 			call 	moveDown
   0E0B                     320 		s_not_pressed:
   0E0B 18 34         [12]  321 		jr five_not_pressed
                            322 
   0E0D                     323 	player_2:
   0E0D 21 00 10      [10]  324 		ld 	hl, #Key_F6			;; HL = F6 Keycode
   0E10 CD EE 0F      [17]  325 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E13 FE 00         [ 7]  326 		cp 	#0 				;; A == 0?
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   0E15 28 03         [12]  327 		jr 	z, six_not_pressed
                            328 			;; D is pressed
   0E17 CD 7D 0D      [17]  329 			call 	moveRight	
   0E1A                     330 		six_not_pressed:
                            331 
   0E1A 21 02 10      [10]  332 		ld 	hl, #Key_F4			;; HL = F4 Keycode
   0E1D CD EE 0F      [17]  333 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E20 FE 00         [ 7]  334 		cp 	#0 				;; A == 0?
   0E22 28 03         [12]  335 		jr 	z, four_not_pressed
                            336 			;; A is pressed	
   0E24 CD 8F 0D      [17]  337 			call 	moveLeft
   0E27                     338 		four_not_pressed:
                            339 
   0E27 21 01 08      [10]  340 		ld 	hl, #Key_F8			;; HL = F8 Keycode
   0E2A CD EE 0F      [17]  341 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E2D FE 00         [ 7]  342 		cp 	#0 				;; A == 0?
   0E2F 28 03         [12]  343 		jr 	z, eight_not_pressed
                            344 			;; W is pressed
   0E31 CD 98 0D      [17]  345 			call 	moveUp	
   0E34                     346 		eight_not_pressed:
                            347 
   0E34 21 01 10      [10]  348 		ld 	hl, #Key_F5			;; HL = F5 Keycode
   0E37 CD EE 0F      [17]  349 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E3A FE 00         [ 7]  350 		cp 	#0 				;; A == 0?
   0E3C 28 03         [12]  351 		jr 	z, five_not_pressed
                            352 			;; S is pressed	
   0E3E CD 86 0D      [17]  353 			call 	moveDown
   0E41                     354 		five_not_pressed:
                            355 
                            356 
                            357 
   0E41 CD 45 0E      [17]  358 	call checkVandB
   0E44 C9            [10]  359 	ret
                            360 
                            361 
                            362 ;; ====================================
                            363 ;; Funcion auxiliar para leer V y B
                            364 ;;	de la entrada por teclado
                            365 ;; Entrada:
                            366 ;; 	IX <= pointer to entity data
                            367 ;; Modifica AF, BC, DE, HL
                            368 ;; ====================================
   0E45                     369 checkVandB:
   0E45 DD E5         [15]  370 	push 	ix
   0E47 CD 76 0D      [17]  371 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0E4A DD E1         [14]  372 	pop 	ix
   0E4C FE 00         [ 7]  373 	cp 	#0			;; A == 0?
   0E4E CA FA 0E      [10]  374 	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
                            375 		;; There is collision
                            376 
   0E51 DD 7E 16      [19]  377 		ld 	a, Ent_id(ix)
   0E54 FE 01         [ 7]  378 		cp	#1
   0E56 20 54         [12]  379 		jr	nz, player_2_vorb
                            380 			;; Player 1
                            381 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   0E58 21 06 80      [10]  382 			ld 	hl, #Key_V			;; HL = V Keycode
   0E5B CD EE 0F      [17]  383 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E5E FE 00         [ 7]  384 			cp 	#0 				;; A == 0?
   0E60 28 22         [12]  385 			jr 	z, v_not_pressed
                            386 				;; V is pressed	
   0E62 21 06 40      [10]  387 				ld 	hl, #Key_B			;; HL = B Keycode
   0E65 CD EE 0F      [17]  388 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E68 FE 00         [ 7]  389 				cp 	#0 				;; A == 0?
   0E6A 28 0C         [12]  390 				jr 	z, just_v_pressed
                            391 					;; V and B are pressed
   0E6C 21 00 00      [10]  392 					ld 	hl, #0			;; HL <= standard effect
   0E6F DD E5         [15]  393 					push 	ix
   0E71 CD E3 0B      [17]  394 					call frisbee_setEffect		;; efecto hacia abajo
   0E74 DD E1         [14]  395 					pop 	ix
   0E76 18 20         [12]  396 					jr vorb_pressed
   0E78                     397 				just_v_pressed:
   0E78 21 F8 FF      [10]  398 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0E7B DD E5         [15]  399 					push 	ix
   0E7D CD E3 0B      [17]  400 					call frisbee_setEffect		;; efecto hacia arriba
   0E80 DD E1         [14]  401 					pop 	ix
   0E82 18 14         [12]  402 					jr 	vorb_pressed
   0E84                     403 			v_not_pressed:
                            404 
   0E84 21 06 40      [10]  405 				ld 	hl, #Key_B			;; HL = B Keycode
   0E87 CD EE 0F      [17]  406 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E8A FE 00         [ 7]  407 				cp 	#0 				;; A == 0?
   0E8C 28 6C         [12]  408 				jr 	z, b_not_pressed
                            409 					;; B is pressed
   0E8E 21 08 00      [10]  410 					ld 	hl, #std_eff		;; HL <= standard effect
   0E91 DD E5         [15]  411 					push 	ix
   0E93 CD E3 0B      [17]  412 					call frisbee_setEffect		;; efecto hacia abajo
   0E96 DD E1         [14]  413 					pop 	ix
                            414 
   0E98                     415 					vorb_pressed:
   0E98 DD 7E 16      [19]  416 					ld	a, Ent_id(ix)		;;
   0E9B DD 66 06      [19]  417 					ld	h, Ent_vx_I(ix)		;;
   0E9E DD 6E 07      [19]  418 					ld	l, Ent_vx_F(ix)		;;
   0EA1 DD 56 08      [19]  419 					ld	d, Ent_vy_I(ix)		;;
   0EA4 DD 5E 09      [19]  420 					ld	e, Ent_vy_F(ix)		;;
   0EA7 CD AC 0B      [17]  421 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            422 
   0EAA 18 4E         [12]  423 					jr o_not_pressed
   0EAC                     424 	player_2_vorb:
                            425 
   0EAC 21 04 08      [10]  426 			ld 	hl, #Key_I			;; HL = I Keycode
   0EAF CD EE 0F      [17]  427 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0EB2 FE 00         [ 7]  428 			cp 	#0 				;; A == 0?
   0EB4 28 1E         [12]  429 			jr 	z, i_not_pressed
                            430 				;; I is pressed	
   0EB6 21 04 04      [10]  431 				ld 	hl, #Key_O			;; HL = O Keycode
   0EB9 CD EE 0F      [17]  432 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0EBC FE 00         [ 7]  433 				cp 	#0 				;; A == 0?
   0EBE 28 08         [12]  434 				jr 	z, just_i_pressed
                            435 					;; I and O are pressed
   0EC0 21 00 00      [10]  436 					ld 	hl, #0			;; HL <= standard effect
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   0EC3 CD E3 0B      [17]  437 					call frisbee_setEffect		;; efecto hacia abajo
   0EC6 18 20         [12]  438 					jr ioro_pressed
   0EC8                     439 				just_i_pressed:
   0EC8 21 F8 FF      [10]  440 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0ECB DD E5         [15]  441 					push 	ix
   0ECD CD E3 0B      [17]  442 					call frisbee_setEffect		;; efecto hacia arriba
   0ED0 DD E1         [14]  443 					pop 	ix
   0ED2 18 14         [12]  444 					jr 	ioro_pressed
   0ED4                     445 			i_not_pressed:
                            446 
   0ED4 21 04 04      [10]  447 				ld 	hl, #Key_O			;; HL = O Keycode
   0ED7 CD EE 0F      [17]  448 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0EDA FE 00         [ 7]  449 				cp 	#0 				;; A == 0?
   0EDC 28 1C         [12]  450 				jr 	z, o_not_pressed
                            451 					;; O is pressed
   0EDE 21 08 00      [10]  452 					ld 	hl, #std_eff		;; HL <= standard effect
   0EE1 DD E5         [15]  453 					push 	ix
   0EE3 CD E3 0B      [17]  454 					call frisbee_setEffect		;; efecto hacia abajo
   0EE6 DD E1         [14]  455 					pop 	ix
                            456 
   0EE8                     457 					ioro_pressed:
   0EE8 DD 7E 16      [19]  458 					ld	a, Ent_id(ix)		;;
   0EEB DD 66 06      [19]  459 					ld	h, Ent_vx_I(ix)		;;
   0EEE DD 6E 07      [19]  460 					ld	l, Ent_vx_F(ix)		;;
   0EF1 DD 56 08      [19]  461 					ld	d, Ent_vy_I(ix)		;;
   0EF4 DD 5E 09      [19]  462 					ld	e, Ent_vy_F(ix)		;;
   0EF7 CD AC 0B      [17]  463 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            464 
                            465 
   0EFA                     466 	no_collision:
   0EFA                     467 	b_not_pressed:
   0EFA                     468 	o_not_pressed:
   0EFA C9            [10]  469 	ret
