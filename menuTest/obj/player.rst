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
                             10 .globl player_data
                             11 .globl enemy_data
                             12 .globl player_2_data
                             13 .globl enemy_2_data
                             14 .globl play_music	;; alomejor son privados
                             15 .globl stop_music	;; alomejor son privados
                             16 .globl game_data
                             17 
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; GAME PUBLIC DATA
                             21 ;; ====================================
                             22 ;; ====================================
                     0050    23 .equ RIGHT_LIMIT,	80
                     0000    24 .equ LEFT_LIMIT,	0
                     0014    25 .equ TOP_LIMIT,	 	20
                     00C8    26 .equ BOTTOM_LIMIT,	200
                     0028    27 .equ CENTER_LIMIT,	40
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
   0C55                      25 _cpct_keyboardStatusBuffer:: .ds 10
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
                             18 ;; ====================================
                             19 ;; ====================================
                             20 ;; PUBLIC FUNCTIONS
                             21 ;; ====================================
                             22 ;; ====================================
   0C5F                      23 player_erase::
   0C5F DD 21 85 0E   [14]   24 	ld 	ix, #player_data
   0C63 CD 24 09      [17]   25 	call 	entityErase		;; Erase player
   0C66 DD 21 9C 0E   [14]   26 	ld 	ix, #enemy_data
   0C6A CD 24 09      [17]   27 	call 	entityErase		;; Erase enemy
                             28 
   0C6D C9            [10]   29 	ret	
                             30 
                             31 ;; =========================================
                             32 ;; Actualiza el estado del player recibido
                             33 ;; 	en IX
                             34 ;; Entrada:
                             35 ;;	IX => Pointer to player data
                             36 ;; Modifica: AF, BC, DE, HL, IX
                             37 ;; =========================================
   0C6E                      38 player_update::
   0C6E CD 4F 0D      [17]   39 	call checkUserInput
                             40 
                             41 
                             42 
   0C71 DD 7E 16      [19]   43 	ld	a, Ent_id(ix)
   0C74 FE 02         [ 7]   44 	cp	#2
   0C76 28 09         [12]   45 	jr	z, check_IA		;; Ent_id == 2? check IA
   0C78 FE 04         [ 7]   46 	cp	#4
   0C7A 28 05         [12]   47 	jr	z, check_IA		;; Ent_id == 4? check IA
                             48 		;; check input
   0C7C CD 4F 0D      [17]   49 		call checkUserInput
   0C7F 18 03         [12]   50 		jr continue_updating
                             51 
   0C81                      52 	check_IA:
   0C81 CD BF 0C      [17]   53 		call move_IA
                             54 
   0C84                      55 	continue_updating:
                             56 
   0C84 CD 3E 09      [17]   57 	call entityUpdatePhysics
   0C87 CD 98 0A      [17]   58 	call entityUpdatePosition
   0C8A CD 24 0D      [17]   59 	call checkCenterCrossing
                             60 	
   0C8D C9            [10]   61 	ret
                             62 
                             63 ;; ====================================
                             64 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             65 ;; PRIVATE FUNCTIONS
                             66 ;; ====================================
                             67 ;; ====================================
                             68 
                             69 ;; =========================================
                             70 ;; Determina el siguiente estado de
                             71 ;;	la entidad
                             72 ;; Entrada:
                             73 ;; =========================================
   0C8E                      74 delta:
                             75 
                             76 
   0C8E                      77 update:
                             78 
                             79 ;; =========================================
                             80 ;; Invierte los datos para poder operarlos
                             81 ;;	en C
                             82 ;; Entrada:
                             83 ;;	IX <= Pointer to entity data
                             84 ;;	Modifica: BC
                             85 ;; =========================================
   0C8E                      86 invert_variables:
                             87 	;; Inverts X
   0C8E DD 46 00      [19]   88 	ld	b,	Ent_x_I(ix)
   0C91 DD 4E 01      [19]   89 	ld	c,	Ent_x_F(ix)
   0C94 DD 71 00      [19]   90 	ld	Ent_x_I(ix), c
   0C97 DD 70 01      [19]   91 	ld	Ent_x_F(ix), b
                             92 
                             93 	;; Inverts Y
   0C9A DD 46 02      [19]   94 	ld	b,	Ent_y_I(ix)
   0C9D DD 4E 03      [19]   95 	ld	c,	Ent_y_F(ix)
   0CA0 DD 71 02      [19]   96 	ld	Ent_y_I(ix), c
   0CA3 DD 70 03      [19]   97 	ld	Ent_y_F(ix), b
                             98 
                             99 	;; Inverts AX
   0CA6 DD 46 0A      [19]  100 	ld	b, Ent_ax_I(ix)		 
   0CA9 DD 4E 0B      [19]  101 	ld	c, Ent_ax_F(ix)		 
   0CAC DD 71 0A      [19]  102 	ld	Ent_ax_I(ix), c		 
   0CAF DD 70 0B      [19]  103 	ld	Ent_ax_F(ix), b		
                            104 
                            105 	;; Inverts AY
   0CB2 DD 46 0C      [19]  106 	ld	b, Ent_ay_I(ix)		 
   0CB5 DD 4E 0D      [19]  107 	ld	c, Ent_ay_F(ix)		 
   0CB8 DD 71 0C      [19]  108 	ld	Ent_ay_I(ix), c		 
   0CBB DD 70 0D      [19]  109 	ld	Ent_ay_F(ix), b		
                            110 
                            111 	;; FALTARIA EFECTO, CUIDAO
                            112 
   0CBE C9            [10]  113 	ret
                            114 
   0CBF                     115 move_IA:
                            116 
   0CBF DD 21 45 0B   [14]  117 	ld	ix, #frisbee_data
   0CC3 DD E5         [15]  118 	push 	ix
   0CC5 CD 8E 0C      [17]  119 	call 	invert_variables
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   0CC8 DD 21 85 0E   [14]  120 	ld	ix, #player_data
   0CCC DD E5         [15]  121 	push 	ix
   0CCE CD 8E 0C      [17]  122 	call 	invert_variables
   0CD1 DD 21 9C 0E   [14]  123 	ld	ix, #enemy_data
   0CD5 DD E5         [15]  124 	push 	ix
   0CD7 CD 8E 0C      [17]  125 	call 	invert_variables
   0CDA CD B3 08      [17]  126 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
                            127 	
   0CDD DD E1         [14]  128 	pop 	ix
   0CDF DD E1         [14]  129 	pop 	ix
   0CE1 DD E1         [14]  130 	pop 	ix
                            131 
   0CE3 DD 21 45 0B   [14]  132 	ld	ix, #frisbee_data
   0CE7 CD 8E 0C      [17]  133 	call 	invert_variables
   0CEA DD 21 85 0E   [14]  134 	ld	ix, #player_data
   0CEE CD 8E 0C      [17]  135 	call 	invert_variables
   0CF1 DD 21 9C 0E   [14]  136 	ld	ix, #enemy_data
   0CF5 CD 8E 0C      [17]  137 	call 	invert_variables
                            138 
                            139 
   0CF8 C9            [10]  140 	ret
                            141 	
                            142 ;; =========================================
                            143 ;; Comprueba si la entidad colisiona con 
                            144 ;; 	el frisbee
                            145 ;; Entrada:
                            146 ;; 	IX <= puntero al player a comparar
                            147 ;; 		con el frisbee
                            148 ;; Modifica: AF, B, HL, IX
                            149 ;; Devuelve:
                            150 ;; 	A <= 	0 si no hay colisión
                            151 ;; 		>1 si hay colisión
                            152 ;; =========================================
   0CF9                     153 checkFrisbeeCollision:
   0CF9 21 45 0B      [10]  154 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   0CFC CD 43 0A      [17]  155 	call 	entityCheckCollision 	;; A <= collison/no_collision
                            156 
   0CFF C9            [10]  157 	ret
                            158 
                            159 
                            160 ;; ===============================================
                            161 ;; Acelera la entidad hacia la derecha, si puede
                            162 ;; Entrada:
                            163 ;; 	IX <= puntero a los datos de la entidad
                            164 ;; Modifica A, IX
                            165 ;; ===============================================
   0D00                     166 moveRight:
                            167 	;; push 	ix
                            168 	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
                            169 	;; pop 	ix
                            170 	;; cp 	#0			;; A == 0?
                            171 	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?
                            172 
                            173 		;; no_collision
   0D00 DD 36 0A 00   [19]  174 		ld 	Ent_ax_I(ix), #0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0D04 DD 36 0B 20   [19]  175 		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            176 
                            177 
   0D08 C9            [10]  178 		ret
                            179 
                            180 	;;collision_right:
                            181 	;;	call 	frisbee_setOff
                            182 	;;
                            183 	;;	ret
                            184 
                            185 ;; ===============================================
                            186 ;; Acelera la entidad hacia abajo, si puede
                            187 ;; Entrada:
                            188 ;; 	IX <= puntero a los datos de la entidad
                            189 ;; Modifica A, IX
                            190 ;; ===============================================
   0D09                     191 moveDown:
   0D09 DD 36 0C 00   [19]  192 	ld 	Ent_ay_I(ix), #0
   0D0D DD 36 0D 20   [19]  193 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                            194 
   0D11 C9            [10]  195 	ret
                            196 
                            197 ;; ===============================================
                            198 ;; Acelera la entidad hacia la izquierda, si puede
                            199 ;; Entrada:
                            200 ;; 	IX <= puntero a los datos de la entidad
                            201 ;; Modifica A, IX
                            202 ;; ===============================================
   0D12                     203 moveLeft:
   0D12 DD 36 0A FF   [19]  204 	ld 	Ent_ax_I(ix), #-1
   0D16 DD 36 0B E0   [19]  205 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                            206 
   0D1A C9            [10]  207 	ret
                            208 
                            209 ;; ===============================================
                            210 ;; Acelera la entidad hacia arriba, si puede
                            211 ;; Entrada:
                            212 ;; 	IX <= puntero a los datos de la entidad
                            213 ;; Modifica A, IX
                            214 ;; ===============================================
   0D1B                     215 moveUp:
   0D1B DD 36 0C FF   [19]  216 	ld 	Ent_ay_I(ix), #-1
   0D1F DD 36 0D E0   [19]  217 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                            218 
   0D23 C9            [10]  219 	ret
                            220 
                            221 
                            222 ;; ===========================================
                            223 ;; Chequea si un jugador pasa del centro del
                            224 ;; 	campo y lo corrige en caso necesario
                            225 ;; Entrada:
                            226 ;; 	IX <= pointer to entity data
                            227 ;; Modifica AF, BC, DE, HL
                            228 ;; ===========================================
   0D24                     229 checkCenterCrossing:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   0D24 DD 7E 16      [19]  230 	ld 	a, Ent_id(ix)
   0D27 FE 01         [ 7]  231 	cp 	#1
   0D29 28 11         [12]  232 	jr	z, player_1
   0D2B FE 02         [ 7]  233 		cp	#2
   0D2D 20 1F         [12]  234 		jr	nz, invalid_id
                            235 			;; player 2
   0D2F 3E 28         [ 7]  236 			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
   0D31 DD BE 00      [19]  237 			cp	Ent_x_I(ix)
   0D34 38 18         [12]  238 			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                            239 				;; center limit crossed
   0D36 DD 36 00 28   [19]  240 				ld	Ent_x_I(ix), #CENTER_LIMIT
   0D3A 18 12         [12]  241 				jr not_crossed
                            242 
   0D3C                     243 	player_1:
   0D3C DD 7E 00      [19]  244 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   0D3F DD 86 05      [19]  245 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   0D42 FE 28         [ 7]  246 			cp	#CENTER_LIMIT
   0D44 38 08         [12]  247 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                            248 				;; center limit crossed
   0D46 3E 28         [ 7]  249 				ld	a, #CENTER_LIMIT
   0D48 DD 96 05      [19]  250 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   0D4B DD 77 00      [19]  251 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                            252 
   0D4E                     253 	invalid_id:
   0D4E                     254 	not_crossed:
   0D4E C9            [10]  255 	ret
                            256 
                            257 
                            258 ;; ====================================
                            259 ;; Lee la entrada del teclado
                            260 ;; Entrada:
                            261 ;; 	IX <= pointer to entity data
                            262 ;; Modifica AF, BC, DE, HL, IX
                            263 ;; ====================================
   0D4F                     264 checkUserInput:
   0D4F CD 7F 19      [17]  265 	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;
                            266 
   0D52 DD 7E 16      [19]  267 	ld 	a, Ent_id(ix)
   0D55 FE 01         [ 7]  268 	cp	#1
   0D57 C2 90 0D      [10]  269 	jp	nz, player_2
                            270 		;; Player 1
   0D5A 21 07 20      [10]  271 		ld 	hl, #Key_D			;; HL = D Keycode
   0D5D CD 23 10      [17]  272 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0D60 FE 00         [ 7]  273 		cp 	#0 				;; A == 0?
   0D62 28 03         [12]  274 		jr 	z, d_not_pressed
                            275 			;; D is pressed
   0D64 CD 00 0D      [17]  276 			call 	moveRight	
   0D67                     277 		d_not_pressed:
                            278 
   0D67 21 08 20      [10]  279 		ld 	hl, #Key_A			;; HL = A Keycode
   0D6A CD 23 10      [17]  280 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0D6D FE 00         [ 7]  281 		cp 	#0 				;; A == 0?
   0D6F 28 03         [12]  282 		jr 	z, a_not_pressed
                            283 			;; A is pressed	
   0D71 CD 12 0D      [17]  284 			call 	moveLeft
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   0D74                     285 		a_not_pressed:
                            286 
   0D74 21 07 08      [10]  287 		ld 	hl, #Key_W			;; HL = W Keycode
   0D77 CD 23 10      [17]  288 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0D7A FE 00         [ 7]  289 		cp 	#0 				;; A == 0?
   0D7C 28 03         [12]  290 		jr 	z, w_not_pressed
                            291 			;; W is pressed
   0D7E CD 1B 0D      [17]  292 			call 	moveUp	
   0D81                     293 		w_not_pressed:
                            294 
   0D81 21 07 10      [10]  295 		ld 	hl, #Key_S			;; HL = S Keycode
   0D84 CD 23 10      [17]  296 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0D87 FE 00         [ 7]  297 		cp 	#0 				;; A == 0?
   0D89 28 03         [12]  298 		jr 	z, s_not_pressed
                            299 			;; S is pressed	
   0D8B CD 09 0D      [17]  300 			call 	moveDown
   0D8E                     301 		s_not_pressed:
   0D8E 18 34         [12]  302 		jr five_not_pressed
                            303 
   0D90                     304 	player_2:
   0D90 21 00 10      [10]  305 		ld 	hl, #Key_F6			;; HL = F6 Keycode
   0D93 CD 23 10      [17]  306 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0D96 FE 00         [ 7]  307 		cp 	#0 				;; A == 0?
   0D98 28 03         [12]  308 		jr 	z, six_not_pressed
                            309 			;; D is pressed
   0D9A CD 00 0D      [17]  310 			call 	moveRight	
   0D9D                     311 		six_not_pressed:
                            312 
   0D9D 21 02 10      [10]  313 		ld 	hl, #Key_F4			;; HL = F4 Keycode
   0DA0 CD 23 10      [17]  314 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DA3 FE 00         [ 7]  315 		cp 	#0 				;; A == 0?
   0DA5 28 03         [12]  316 		jr 	z, four_not_pressed
                            317 			;; A is pressed	
   0DA7 CD 12 0D      [17]  318 			call 	moveLeft
   0DAA                     319 		four_not_pressed:
                            320 
   0DAA 21 01 08      [10]  321 		ld 	hl, #Key_F8			;; HL = F8 Keycode
   0DAD CD 23 10      [17]  322 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DB0 FE 00         [ 7]  323 		cp 	#0 				;; A == 0?
   0DB2 28 03         [12]  324 		jr 	z, eight_not_pressed
                            325 			;; W is pressed
   0DB4 CD 1B 0D      [17]  326 			call 	moveUp	
   0DB7                     327 		eight_not_pressed:
                            328 
   0DB7 21 01 10      [10]  329 		ld 	hl, #Key_F5			;; HL = F5 Keycode
   0DBA CD 23 10      [17]  330 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DBD FE 00         [ 7]  331 		cp 	#0 				;; A == 0?
   0DBF 28 03         [12]  332 		jr 	z, five_not_pressed
                            333 			;; S is pressed	
   0DC1 CD 09 0D      [17]  334 			call 	moveDown
   0DC4                     335 		five_not_pressed:
                            336 
                            337 
                            338 
   0DC4 CD C8 0D      [17]  339 	call checkVandB
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   0DC7 C9            [10]  340 	ret
                            341 
                            342 
                            343 ;; ====================================
                            344 ;; Funcion auxiliar para leer V y B
                            345 ;;	de la entrada por teclado
                            346 ;; Entrada:
                            347 ;; 	IX <= pointer to entity data
                            348 ;; Modifica AF, BC, DE, HL
                            349 ;; ====================================
   0DC8                     350 checkVandB:
   0DC8 DD E5         [15]  351 	push 	ix
   0DCA CD F9 0C      [17]  352 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   0DCD DD E1         [14]  353 	pop 	ix
   0DCF FE 00         [ 7]  354 	cp 	#0			;; A == 0?
   0DD1 CA 7D 0E      [10]  355 	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
                            356 		;; There is collision
                            357 
   0DD4 DD 7E 16      [19]  358 		ld 	a, Ent_id(ix)
   0DD7 FE 01         [ 7]  359 		cp	#1
   0DD9 20 54         [12]  360 		jr	nz, player_2_vorb
                            361 			;; Player 1
                            362 
   0DDB 21 06 80      [10]  363 			ld 	hl, #Key_V			;; HL = V Keycode
   0DDE CD 23 10      [17]  364 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DE1 FE 00         [ 7]  365 			cp 	#0 				;; A == 0?
   0DE3 28 22         [12]  366 			jr 	z, v_not_pressed
                            367 				;; V is pressed	
   0DE5 21 06 40      [10]  368 				ld 	hl, #Key_B			;; HL = B Keycode
   0DE8 CD 23 10      [17]  369 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0DEB FE 00         [ 7]  370 				cp 	#0 				;; A == 0?
   0DED 28 0C         [12]  371 				jr 	z, just_v_pressed
                            372 					;; V and B are pressed
   0DEF 21 00 00      [10]  373 					ld 	hl, #0			;; HL <= standard effect
   0DF2 DD E5         [15]  374 					push 	ix
   0DF4 CD E5 0B      [17]  375 					call frisbee_setEffect		;; efecto hacia abajo
   0DF7 DD E1         [14]  376 					pop 	ix
   0DF9 18 20         [12]  377 					jr vorb_pressed
   0DFB                     378 				just_v_pressed:
   0DFB 21 F8 FF      [10]  379 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0DFE DD E5         [15]  380 					push 	ix
   0E00 CD E5 0B      [17]  381 					call frisbee_setEffect		;; efecto hacia arriba
   0E03 DD E1         [14]  382 					pop 	ix
   0E05 18 14         [12]  383 					jr 	vorb_pressed
   0E07                     384 			v_not_pressed:
                            385 
   0E07 21 06 40      [10]  386 				ld 	hl, #Key_B			;; HL = B Keycode
   0E0A CD 23 10      [17]  387 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E0D FE 00         [ 7]  388 				cp 	#0 				;; A == 0?
   0E0F 28 6C         [12]  389 				jr 	z, b_not_pressed
                            390 					;; B is pressed
   0E11 21 08 00      [10]  391 					ld 	hl, #std_eff		;; HL <= standard effect
   0E14 DD E5         [15]  392 					push 	ix
   0E16 CD E5 0B      [17]  393 					call frisbee_setEffect		;; efecto hacia abajo
   0E19 DD E1         [14]  394 					pop 	ix
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            395 
   0E1B                     396 					vorb_pressed:
   0E1B DD 7E 16      [19]  397 					ld	a, Ent_id(ix)		;;
   0E1E DD 66 06      [19]  398 					ld	h, Ent_vx_I(ix)		;;
   0E21 DD 6E 07      [19]  399 					ld	l, Ent_vx_F(ix)		;;
   0E24 DD 56 08      [19]  400 					ld	d, Ent_vy_I(ix)		;;
   0E27 DD 5E 09      [19]  401 					ld	e, Ent_vy_F(ix)		;;
   0E2A CD AE 0B      [17]  402 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            403 
   0E2D 18 4E         [12]  404 					jr o_not_pressed
   0E2F                     405 	player_2_vorb:
                            406 
   0E2F 21 04 08      [10]  407 			ld 	hl, #Key_I			;; HL = I Keycode
   0E32 CD 23 10      [17]  408 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E35 FE 00         [ 7]  409 			cp 	#0 				;; A == 0?
   0E37 28 1E         [12]  410 			jr 	z, i_not_pressed
                            411 				;; I is pressed	
   0E39 21 04 04      [10]  412 				ld 	hl, #Key_O			;; HL = O Keycode
   0E3C CD 23 10      [17]  413 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E3F FE 00         [ 7]  414 				cp 	#0 				;; A == 0?
   0E41 28 08         [12]  415 				jr 	z, just_i_pressed
                            416 					;; I and O are pressed
   0E43 21 00 00      [10]  417 					ld 	hl, #0			;; HL <= standard effect
   0E46 CD E5 0B      [17]  418 					call frisbee_setEffect		;; efecto hacia abajo
   0E49 18 20         [12]  419 					jr ioro_pressed
   0E4B                     420 				just_i_pressed:
   0E4B 21 F8 FF      [10]  421 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   0E4E DD E5         [15]  422 					push 	ix
   0E50 CD E5 0B      [17]  423 					call frisbee_setEffect		;; efecto hacia arriba
   0E53 DD E1         [14]  424 					pop 	ix
   0E55 18 14         [12]  425 					jr 	ioro_pressed
   0E57                     426 			i_not_pressed:
                            427 
   0E57 21 04 04      [10]  428 				ld 	hl, #Key_O			;; HL = O Keycode
   0E5A CD 23 10      [17]  429 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   0E5D FE 00         [ 7]  430 				cp 	#0 				;; A == 0?
   0E5F 28 1C         [12]  431 				jr 	z, o_not_pressed
                            432 					;; O is pressed
   0E61 21 08 00      [10]  433 					ld 	hl, #std_eff		;; HL <= standard effect
   0E64 DD E5         [15]  434 					push 	ix
   0E66 CD E5 0B      [17]  435 					call frisbee_setEffect		;; efecto hacia abajo
   0E69 DD E1         [14]  436 					pop 	ix
                            437 
   0E6B                     438 					ioro_pressed:
   0E6B DD 7E 16      [19]  439 					ld	a, Ent_id(ix)		;;
   0E6E DD 66 06      [19]  440 					ld	h, Ent_vx_I(ix)		;;
   0E71 DD 6E 07      [19]  441 					ld	l, Ent_vx_F(ix)		;;
   0E74 DD 56 08      [19]  442 					ld	d, Ent_vy_I(ix)		;;
   0E77 DD 5E 09      [19]  443 					ld	e, Ent_vy_F(ix)		;;
   0E7A CD AE 0B      [17]  444 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                            445 
                            446 
   0E7D                     447 	no_collision:
   0E7D                     448 	b_not_pressed:
   0E7D                     449 	o_not_pressed:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   0E7D C9            [10]  450 	ret
