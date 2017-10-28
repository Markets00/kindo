ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     0028     1 std_acc = 40 	;; standard acceleration per frame
                              2 
                     0014     3 P_HEIGHT 	= 20
                     0005     4 P_WIDTH 	= 5
                              5 
                     000A     6 MID_HEIGHT	= P_HEIGHT/2
                     0002     7 MID_WIDTH	= P_WIDTH/2
                              8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              9 .include "utility.h.s"
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



                             10 .include "entity.h.s"
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



                             11 .include "frisbee.h.s"
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



                             12 .include "game.h.s"
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



                             13 .include "keyboard/keyboard.s"
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



                             14 .globl _moveIA
                             15 
                             16 ;; ====================================
                             17 ;; ====================================
                             18 ;; PRIVATE DATA
                             19 ;; ====================================
                             20 ;; ====================================
                             21 
                             22 ;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             23 
   0C5C                      24 defineEntity player, #0x0010, #0x0050, #P_HEIGHT, #P_WIDTH, #0000, #0000, #0000, #0000, #0x1000, #1, #0xF0, #1
   000A                       1 	player_data::
   0C5C 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0C5E 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0C60 14                    4 		player_h:	.db #P_HEIGHT		;; Height			(8 bits)
   0C61 05                    5 		player_w:	.db #P_WIDTH		;; Width			(8 bits)
   0C62 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0C64 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0C66 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0C68 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0C6A 00 10                10 		player_normal:	.dw #0x1000	;; Normal force			(16 bits)
   0C6C 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0C6D 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0C6E 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0C6F 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0C70 01                   15 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0C71 F0                   16 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0C72 01                   17 		player_id:	.db #1		;; Numeric ID			(8 bits)
                             25 
   0C73                      26 defineEntity enemy, #0x0050-0x0004, #0x0064, #P_HEIGHT, #P_WIDTH, #0000, #0000, #0000, #0000, #0x1000, #1, #0xFF, #2
   0021                       1 	enemy_data::
   0C73 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0C75 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0C77 14                    4 		enemy_h:	.db #P_HEIGHT		;; Height			(8 bits)
   0C78 05                    5 		enemy_w:	.db #P_WIDTH		;; Width			(8 bits)
   0C79 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0C7B 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0C7D 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0C7F 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0C81 00 10                10 		enemy_normal:	.dw #0x1000	;; Normal force			(16 bits)
   0C83 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   0C84 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   0C85 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0C86 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0C87 01                   15 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0C88 FF                   16 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0C89 02                   17 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             27 
                             28 
                             29 ; defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x0300, #1, #0xF0, #1
                             30 ; defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x0300, #1, #0xFF, #2
                             31 	
                             32 ;; ====================================
                             33 ;; ====================================
                             34 ;; PUBLIC FUNCTIONS
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             35 ;; ====================================
                             36 ;; ====================================
   0C8A                      37 player_erase::
   0C8A DD 21 5C 0C   [14]   38 	ld 	ix, #player_data
   0C8E CD 22 09      [17]   39 	call 	entityErase		;; Erase player
   0C91 DD 21 73 0C   [14]   40 	ld 	ix, #enemy_data
   0C95 CD 22 09      [17]   41 	call 	entityErase		;; Erase enemy
                             42 
   0C98 C9            [10]   43 	ret
                             44 
                             45 ;; =========================================
                             46 ;; Actualiza el estado de los entities tipo
                             47 ;;	player
                             48 ;; Modifica: AF, IX
                             49 ;; =========================================
   0C99                      50 player_update::
   0C99 DD 21 5C 0C   [14]   51 	ld 	ix, #player_data
   0C9D CD A2 0D      [17]   52 	call checkUserInput
                             53 
   0CA0 DD 21 73 0C   [14]   54 	ld 	ix, #enemy_data
   0CA4 CD A2 0D      [17]   55 	call checkUserInput
                             56 
                             57 ;	call move_IA
                             58 
   0CA7 DD 21 5C 0C   [14]   59 	ld 	ix, #player_data
   0CAB CD 3C 09      [17]   60 	call entityUpdatePhysics
   0CAE DD 21 73 0C   [14]   61 	ld 	ix, #enemy_data
   0CB2 CD 3C 09      [17]   62 	call entityUpdatePhysics
                             63 
   0CB5 DD 21 5C 0C   [14]   64 	ld 	ix, #player_data
   0CB9 CD 96 0A      [17]   65 	call entityUpdatePosition
   0CBC DD 21 73 0C   [14]   66 	ld 	ix, #enemy_data
   0CC0 CD 96 0A      [17]   67 	call entityUpdatePosition
                             68 
                             69 
   0CC3 DD 21 5C 0C   [14]   70 	ld 	ix, #player_data
   0CC7 CD 77 0D      [17]   71 	call checkCenterCrossing
   0CCA DD 21 73 0C   [14]   72 	ld 	ix, #enemy_data
   0CCE CD 77 0D      [17]   73 	call checkCenterCrossing
   0CD1 C9            [10]   74 	ret
                             75 
   0CD2                      76 player_draw::
   0CD2 DD 21 5C 0C   [14]   77 	ld 	ix, #player_data
   0CD6 CD 01 09      [17]   78 	call 	entityDraw		;; Draw player
   0CD9 DD 21 73 0C   [14]   79 	ld 	ix, #enemy_data
   0CDD CD 01 09      [17]   80 	call 	entityDraw		;; Draw enemy
                             81 
   0CE0 C9            [10]   82 	ret
                             83 	
                             84 ;; ====================================
                             85 ;; ====================================
                             86 ;; PRIVATE FUNCTIONS
                             87 ;; ====================================
                             88 ;; ====================================
                             89 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             90 ;; =========================================
                             91 ;; Determina el siguiente estado de
                             92 ;;	la entidad
                             93 ;; Entrada:
                             94 ;; =========================================
   0CE1                      95 delta:
                             96 
   0CE1                      97 update_state:
                             98 
                             99 ;; =========================================
                            100 ;; Invierte los datos para poder operarlos
                            101 ;;	en C
                            102 ;; Entrada:
                            103 ;;	IX <= Pointer to entity data
                            104 ;;	Modifica: BC
                            105 ;; =========================================
   0CE1                     106 invert_variables:
                            107 	;; Inverts X
   0CE1 DD 46 00      [19]  108 	ld	b,	Ent_x_I(ix)
   0CE4 DD 4E 01      [19]  109 	ld	c,	Ent_x_F(ix)
   0CE7 DD 71 00      [19]  110 	ld	Ent_x_I(ix), c
   0CEA DD 70 01      [19]  111 	ld	Ent_x_F(ix), b
                            112 
                            113 	;; Inverts Y
   0CED DD 46 02      [19]  114 	ld	b,	Ent_y_I(ix)
   0CF0 DD 4E 03      [19]  115 	ld	c,	Ent_y_F(ix)
   0CF3 DD 71 02      [19]  116 	ld	Ent_y_I(ix), c
   0CF6 DD 70 03      [19]  117 	ld	Ent_y_F(ix), b
                            118 
                            119 	;; Inverts AX
   0CF9 DD 46 0A      [19]  120 	ld	b, Ent_ax_I(ix)		 
   0CFC DD 4E 0B      [19]  121 	ld	c, Ent_ax_F(ix)		 
   0CFF DD 71 0A      [19]  122 	ld	Ent_ax_I(ix), c		 
   0D02 DD 70 0B      [19]  123 	ld	Ent_ax_F(ix), b		
                            124 
                            125 	;; Inverts AY
   0D05 DD 46 0C      [19]  126 	ld	b, Ent_ay_I(ix)		 
   0D08 DD 4E 0D      [19]  127 	ld	c, Ent_ay_F(ix)		 
   0D0B DD 71 0C      [19]  128 	ld	Ent_ay_I(ix), c		 
   0D0E DD 70 0D      [19]  129 	ld	Ent_ay_F(ix), b		
                            130 
                            131 	;; FALTARIA EFECTO, CUIDAO
                            132 
   0D11 C9            [10]  133 	ret
                            134 
   0D12                     135 move_IA:
                            136 
   0D12 DD 21 43 0B   [14]  137 	ld	ix, #frisbee_data
   0D16 DD E5         [15]  138 	push 	ix
   0D18 CD E1 0C      [17]  139 	call 	invert_variables
   0D1B DD 21 5C 0C   [14]  140 	ld	ix, #player_data
   0D1F DD E5         [15]  141 	push 	ix
   0D21 CD E1 0C      [17]  142 	call 	invert_variables
   0D24 DD 21 73 0C   [14]  143 	ld	ix, #enemy_data
   0D28 DD E5         [15]  144 	push 	ix
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0D2A CD E1 0C      [17]  145 	call 	invert_variables
   0D2D CD B1 08      [17]  146 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
                            147 	
   0D30 DD E1         [14]  148 	pop 	ix
   0D32 DD E1         [14]  149 	pop 	ix
   0D34 DD E1         [14]  150 	pop 	ix
                            151 
   0D36 DD 21 43 0B   [14]  152 	ld	ix, #frisbee_data
   0D3A CD E1 0C      [17]  153 	call 	invert_variables
   0D3D DD 21 5C 0C   [14]  154 	ld	ix, #player_data
   0D41 CD E1 0C      [17]  155 	call 	invert_variables
   0D44 DD 21 73 0C   [14]  156 	ld	ix, #enemy_data
   0D48 CD E1 0C      [17]  157 	call 	invert_variables
                            158 
                            159 
   0D4B C9            [10]  160 	ret
                            161 	
                            162 ;; =========================================
                            163 ;; Comprueba si la entidad colisiona con 
                            164 ;; 	el frisbee
                            165 ;; Entrada:
                            166 ;; 	IX <= puntero al player a comparar
                            167 ;; 		con el frisbee
                            168 ;; Modifica: AF, B, HL, IX
                            169 ;; Devuelve:
                            170 ;; 	A <= 	0 si no hay colisión
                            171 ;; 		>1 si hay colisión
                            172 ;; =========================================
   0D4C                     173 checkFrisbeeCollision:
   0D4C 21 43 0B      [10]  174 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   0D4F CD 41 0A      [17]  175 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            176 
   0D52 C9            [10]  177 	ret
                            178 
                            179 
                            180 ;; ===============================================
                            181 ;; Acelera la entidad hacia la derecha, si puede
                            182 ;; Entrada:
                            183 ;; 	IX <= puntero a los datos de la entidad
                            184 ;; Modifica A, IX
                            185 ;; ===============================================
   0D53                     186 moveRight:
                            187 	;; push 	ix
                            188 	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
                            189 	;; pop 	ix
                            190 	;; cp 	#0			;; A == 0?
                            191 	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            192 
                            193 		;; no_collision
   0D53 DD 36 0A 00   [19]  194 		ld 	Ent_ax_I(ix), #0
   0D57 DD 36 0B 28   [19]  195 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            196 
                            197 
   0D5B C9            [10]  198 		ret
                            199 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            200 	;;collision_right:
                            201 	;;	call 	frisbee_setOff
                            202 	;;
                            203 	;;	ret
                            204 
                            205 ;; ===============================================
                            206 ;; Acelera la entidad hacia abajo, si puede
                            207 ;; Entrada:
                            208 ;; 	IX <= puntero a los datos de la entidad
                            209 ;; Modifica A, IX
                            210 ;; ===============================================
   0D5C                     211 moveDown:
   0D5C DD 36 0C 00   [19]  212 	ld 	Ent_ay_I(ix), #0
   0D60 DD 36 0D 28   [19]  213 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            214 
   0D64 C9            [10]  215 	ret
                            216 
                            217 ;; ===============================================
                            218 ;; Acelera la entidad hacia la izquierda, si puede
                            219 ;; Entrada:
                            220 ;; 	IX <= puntero a los datos de la entidad
                            221 ;; Modifica A, IX
                            222 ;; ===============================================
   0D65                     223 moveLeft:
   0D65 DD 36 0A FF   [19]  224 	ld 	Ent_ax_I(ix), #-1
   0D69 DD 36 0B D8   [19]  225 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            226 
   0D6D C9            [10]  227 	ret
                            228 
                            229 ;; ===============================================
                            230 ;; Acelera la entidad hacia arriba, si puede
                            231 ;; Entrada:
                            232 ;; 	IX <= puntero a los datos de la entidad
                            233 ;; Modifica A, IX
                            234 ;; ===============================================
   0D6E                     235 moveUp:
   0D6E DD 36 0C FF   [19]  236 	ld 	Ent_ay_I(ix), #-1
   0D72 DD 36 0D D8   [19]  237 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            238 
   0D76 C9            [10]  239 	ret
                            240 
                            241 
                            242 ;; ===========================================
                            243 ;; Chequea si un jugador pasa del centro del
                            244 ;; 	campo y lo corrige en caso necesario
                            245 ;; Entrada:
                            246 ;; 	IX <= pointer to entity data
                            247 ;; Modifica AF, BC, DE, HL
                            248 ;; ===========================================
   0D77                     249 checkCenterCrossing:
   0D77 DD 7E 16      [19]  250 	ld 	a, Ent_id(ix)
   0D7A FE 01         [ 7]  251 	cp 	#1
   0D7C 28 11         [12]  252 	jr	z, player_1
   0D7E FE 02         [ 7]  253 		cp	#2
   0D80 20 1F         [12]  254 		jr	nz, invalid_id
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            255 			;; player 2
   0D82 3E 28         [ 7]  256 			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
   0D84 DD BE 00      [19]  257 			cp	Ent_x_I(ix)
   0D87 38 18         [12]  258 			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            259 				;; center limit crossed
   0D89 DD 36 00 28   [19]  260 				ld	Ent_x_I(ix), #CENTER_LIMIT
   0D8D 18 12         [12]  261 				jr not_crossed
                            262 
   0D8F                     263 	player_1:
   0D8F DD 7E 00      [19]  264 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   0D92 DD 86 05      [19]  265 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   0D95 FE 28         [ 7]  266 			cp	#CENTER_LIMIT
   0D97 38 08         [12]  267 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            268 				;; center limit crossed
   0D99 3E 28         [ 7]  269 				ld	a, #CENTER_LIMIT
   0D9B DD 96 05      [19]  270 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   0D9E DD 77 00      [19]  271 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            272 
   0DA1                     273 	invalid_id:
   0DA1                     274 	not_crossed:
   0DA1 C9            [10]  275 	ret
                            276 
                            277 
                            278 ;; ====================================
                            279 ;; Lee la entrada del teclado
                            280 ;; Entrada:
                            281 ;; 	IX <= pointer to entity data
                            282 ;; Modifica AF, BC, DE, HL, IX
                            283 ;; ====================================
   0DA2                     284 checkUserInput:
   0DA2 CD 22 19      [17]  285 	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;
                            286 
   0DA5 DD 7E 16      [19]  287 	ld 	a, Ent_id(ix)
   0DA8 FE 01         [ 7]  288 	cp	#1
   0DAA C2 E3 0D      [10]  289 	jp	nz, player_2
                            290 		;; Player 1
   0DAD 21 07 20      [10]  291 		ld 	hl, #Key_D			;; HL = D Keycode
   0DB0 CD C4 0F      [17]  292 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DB3 FE 00         [ 7]  293 		cp 	#0 				;; A == 0?
   0DB5 28 03         [12]  294 		jr 	z, d_not_pressed
                            295 			;; D is pressed
   0DB7 CD 53 0D      [17]  296 			call 	moveRight	
   0DBA                     297 		d_not_pressed:
                            298 
   0DBA 21 08 20      [10]  299 		ld 	hl, #Key_A			;; HL = A Keycode
   0DBD CD C4 0F      [17]  300 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DC0 FE 00         [ 7]  301 		cp 	#0 				;; A == 0?
   0DC2 28 03         [12]  302 		jr 	z, a_not_pressed
                            303 			;; A is pressed	
   0DC4 CD 65 0D      [17]  304 			call 	moveLeft
   0DC7                     305 		a_not_pressed:
                            306 
   0DC7 21 07 08      [10]  307 		ld 	hl, #Key_W			;; HL = W Keycode
   0DCA CD C4 0F      [17]  308 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DCD FE 00         [ 7]  309 		cp 	#0 				;; A == 0?
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0DCF 28 03         [12]  310 		jr 	z, w_not_pressed
                            311 			;; W is pressed
   0DD1 CD 6E 0D      [17]  312 			call 	moveUp	
   0DD4                     313 		w_not_pressed:
                            314 
   0DD4 21 07 10      [10]  315 		ld 	hl, #Key_S			;; HL = S Keycode
   0DD7 CD C4 0F      [17]  316 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DDA FE 00         [ 7]  317 		cp 	#0 				;; A == 0?
   0DDC 28 03         [12]  318 		jr 	z, s_not_pressed
                            319 			;; S is pressed	
   0DDE CD 5C 0D      [17]  320 			call 	moveDown
   0DE1                     321 		s_not_pressed:
   0DE1 18 34         [12]  322 		jr five_not_pressed
                            323 
   0DE3                     324 	player_2:
   0DE3 21 00 10      [10]  325 		ld 	hl, #Key_F6			;; HL = F6 Keycode
   0DE6 CD C4 0F      [17]  326 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DE9 FE 00         [ 7]  327 		cp 	#0 				;; A == 0?
   0DEB 28 03         [12]  328 		jr 	z, six_not_pressed
                            329 			;; D is pressed
   0DED CD 53 0D      [17]  330 			call 	moveRight	
   0DF0                     331 		six_not_pressed:
                            332 
   0DF0 21 02 10      [10]  333 		ld 	hl, #Key_F4			;; HL = F4 Keycode
   0DF3 CD C4 0F      [17]  334 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DF6 FE 00         [ 7]  335 		cp 	#0 				;; A == 0?
   0DF8 28 03         [12]  336 		jr 	z, four_not_pressed
                            337 			;; A is pressed	
   0DFA CD 65 0D      [17]  338 			call 	moveLeft
   0DFD                     339 		four_not_pressed:
                            340 
   0DFD 21 01 08      [10]  341 		ld 	hl, #Key_F8			;; HL = F8 Keycode
   0E00 CD C4 0F      [17]  342 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E03 FE 00         [ 7]  343 		cp 	#0 				;; A == 0?
   0E05 28 03         [12]  344 		jr 	z, eight_not_pressed
                            345 			;; W is pressed
   0E07 CD 6E 0D      [17]  346 			call 	moveUp	
   0E0A                     347 		eight_not_pressed:
                            348 
   0E0A 21 01 10      [10]  349 		ld 	hl, #Key_F5			;; HL = F5 Keycode
   0E0D CD C4 0F      [17]  350 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E10 FE 00         [ 7]  351 		cp 	#0 				;; A == 0?
   0E12 28 03         [12]  352 		jr 	z, five_not_pressed
                            353 			;; S is pressed	
   0E14 CD 5C 0D      [17]  354 			call 	moveDown
   0E17                     355 		five_not_pressed:
                            356 
                            357 
                            358 
   0E17 CD 1B 0E      [17]  359 	call checkVandB
   0E1A C9            [10]  360 	ret
                            361 
                            362 
                            363 ;; ====================================
                            364 ;; Funcion auxiliar para leer V y B
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            365 ;;	de la entrada por teclado
                            366 ;; Entrada:
                            367 ;; 	IX <= pointer to entity data
                            368 ;; Modifica AF, BC, DE, HL
                            369 ;; ====================================
   0E1B                     370 checkVandB:
   0E1B DD E5         [15]  371 	push 	ix
   0E1D CD 4C 0D      [17]  372 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0E20 DD E1         [14]  373 	pop 	ix
   0E22 FE 00         [ 7]  374 	cp 	#0			;; A == 0?
   0E24 CA D0 0E      [10]  375 	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
                            376 		;; There is collision
                            377 
   0E27 DD 7E 16      [19]  378 		ld 	a, Ent_id(ix)
   0E2A FE 01         [ 7]  379 		cp	#1
   0E2C 20 54         [12]  380 		jr	nz, player_2_vorb
                            381 			;; Player 1
                            382 
   0E2E 21 06 80      [10]  383 			ld 	hl, #Key_V			;; HL = V Keycode
   0E31 CD C4 0F      [17]  384 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E34 FE 00         [ 7]  385 			cp 	#0 				;; A == 0?
   0E36 28 22         [12]  386 			jr 	z, v_not_pressed
                            387 				;; V is pressed	
   0E38 21 06 40      [10]  388 				ld 	hl, #Key_B			;; HL = B Keycode
   0E3B CD C4 0F      [17]  389 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E3E FE 00         [ 7]  390 				cp 	#0 				;; A == 0?
   0E40 28 0C         [12]  391 				jr 	z, just_v_pressed
                            392 					;; V and B are pressed
   0E42 21 00 00      [10]  393 					ld 	hl, #0			;; HL <= standard effect
   0E45 DD E5         [15]  394 					push 	ix
   0E47 CD E3 0B      [17]  395 					call frisbee_setEffect		;; efecto hacia abajo
   0E4A DD E1         [14]  396 					pop 	ix
   0E4C 18 20         [12]  397 					jr vorb_pressed
   0E4E                     398 				just_v_pressed:
   0E4E 21 F8 FF      [10]  399 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0E51 DD E5         [15]  400 					push 	ix
   0E53 CD E3 0B      [17]  401 					call frisbee_setEffect		;; efecto hacia arriba
   0E56 DD E1         [14]  402 					pop 	ix
   0E58 18 14         [12]  403 					jr 	vorb_pressed
   0E5A                     404 			v_not_pressed:
                            405 
   0E5A 21 06 40      [10]  406 				ld 	hl, #Key_B			;; HL = B Keycode
   0E5D CD C4 0F      [17]  407 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E60 FE 00         [ 7]  408 				cp 	#0 				;; A == 0?
   0E62 28 6C         [12]  409 				jr 	z, b_not_pressed
                            410 					;; B is pressed
   0E64 21 08 00      [10]  411 					ld 	hl, #std_eff		;; HL <= standard effect
   0E67 DD E5         [15]  412 					push 	ix
   0E69 CD E3 0B      [17]  413 					call frisbee_setEffect		;; efecto hacia abajo
   0E6C DD E1         [14]  414 					pop 	ix
                            415 
   0E6E                     416 					vorb_pressed:
   0E6E DD 7E 16      [19]  417 					ld	a, Ent_id(ix)		;;
   0E71 DD 66 06      [19]  418 					ld	h, Ent_vx_I(ix)		;;
   0E74 DD 6E 07      [19]  419 					ld	l, Ent_vx_F(ix)		;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   0E77 DD 56 08      [19]  420 					ld	d, Ent_vy_I(ix)		;;
   0E7A DD 5E 09      [19]  421 					ld	e, Ent_vy_F(ix)		;;
   0E7D CD AC 0B      [17]  422 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            423 
   0E80 18 4E         [12]  424 					jr o_not_pressed
   0E82                     425 	player_2_vorb:
                            426 
   0E82 21 04 08      [10]  427 			ld 	hl, #Key_I			;; HL = I Keycode
   0E85 CD C4 0F      [17]  428 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E88 FE 00         [ 7]  429 			cp 	#0 				;; A == 0?
   0E8A 28 1E         [12]  430 			jr 	z, i_not_pressed
                            431 				;; I is pressed	
   0E8C 21 04 04      [10]  432 				ld 	hl, #Key_O			;; HL = O Keycode
   0E8F CD C4 0F      [17]  433 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E92 FE 00         [ 7]  434 				cp 	#0 				;; A == 0?
   0E94 28 08         [12]  435 				jr 	z, just_i_pressed
                            436 					;; I and O are pressed
   0E96 21 00 00      [10]  437 					ld 	hl, #0			;; HL <= standard effect
   0E99 CD E3 0B      [17]  438 					call frisbee_setEffect		;; efecto hacia abajo
   0E9C 18 20         [12]  439 					jr ioro_pressed
   0E9E                     440 				just_i_pressed:
   0E9E 21 F8 FF      [10]  441 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0EA1 DD E5         [15]  442 					push 	ix
   0EA3 CD E3 0B      [17]  443 					call frisbee_setEffect		;; efecto hacia arriba
   0EA6 DD E1         [14]  444 					pop 	ix
   0EA8 18 14         [12]  445 					jr 	ioro_pressed
   0EAA                     446 			i_not_pressed:
                            447 
   0EAA 21 04 04      [10]  448 				ld 	hl, #Key_O			;; HL = O Keycode
   0EAD CD C4 0F      [17]  449 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0EB0 FE 00         [ 7]  450 				cp 	#0 				;; A == 0?
   0EB2 28 1C         [12]  451 				jr 	z, o_not_pressed
                            452 					;; O is pressed
   0EB4 21 08 00      [10]  453 					ld 	hl, #std_eff		;; HL <= standard effect
   0EB7 DD E5         [15]  454 					push 	ix
   0EB9 CD E3 0B      [17]  455 					call frisbee_setEffect		;; efecto hacia abajo
   0EBC DD E1         [14]  456 					pop 	ix
                            457 
   0EBE                     458 					ioro_pressed:
   0EBE DD 7E 16      [19]  459 					ld	a, Ent_id(ix)		;;
   0EC1 DD 66 06      [19]  460 					ld	h, Ent_vx_I(ix)		;;
   0EC4 DD 6E 07      [19]  461 					ld	l, Ent_vx_F(ix)		;;
   0EC7 DD 56 08      [19]  462 					ld	d, Ent_vy_I(ix)		;;
   0ECA DD 5E 09      [19]  463 					ld	e, Ent_vy_F(ix)		;;
   0ECD CD AC 0B      [17]  464 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            465 
                            466 
   0ED0                     467 	no_collision:
   0ED0                     468 	b_not_pressed:
   0ED0                     469 	o_not_pressed:
   0ED0 C9            [10]  470 	ret
