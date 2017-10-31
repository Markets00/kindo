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
                             19 .globl cpct_drawSprite_asm
                             20 .globl cpct_setInterruptHandler_asm
                             21 .globl cpct_setPALColour_asm
                             22 .globl cpct_drawStringM2_asm
                             23 .globl cpct_drawStringM1_asm
                             24 .globl cpct_etm_setTileset2x4_asm
                             25 .globl cpct_etm_drawTileBox2x4_asm
                             26 .globl cpct_etm_drawTilemap2x4_f_asm
                             27 .globl cpct_drawSpriteMaskedAlignedTable_asm
                             28 .globl cpct_drawSpriteMasked_asm
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
                             12 
                             13 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, sprites_ptr, id
                             14 	name'_data::
                             15 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             16 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             17 		name'_h:	.db h		;; Height			(8 bits)
                             18 		name'_w:	.db w		;; Width			(8 bits)
                             19 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             20 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             21 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             22 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             23 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             24 		name'_last_x:	.db #30		;; Last x rendered		(8 bits)
                             25 		name'_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
                             26 		name'_last_y:	.db #30		;; Last y rendered		(8 bits)
                             27 		name'_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
                             28 		name'_state:	.db #0		;; Entity animation state	(8 bits)
                             29 		name'_lastState:.db #0		;; Last entity animation state	(8 bits)
                             30 		name'_signal:	.db #-1		;; Signal recived for animations(8 bits)
                             31 		name'_sprite:	.db #0		;; Entity sprite index		(8 bits)
                             32 		name'_sprites_ptr: .dw sprites_ptr ;; Pointer to sprites	(16 bits)
                             33 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             34 .endm
                             35 
                             36 
                             37 ;; ====================================
                             38 ;; ====================================
                             39 ;; ENTITY PUBLIC DATA
                             40 ;; ====================================
                             41 ;; ====================================
                             42 
                             43 .globl robot_1_sprites
                             44 .globl robot_2_sprites
                             45 .globl frisbee_sprites
                             46 
                     0000    47 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    48 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    49 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    50 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    51 .equ Ent_h, 		4	;; Height
                     0005    52 .equ Ent_w, 		5	;; Width
                     0006    53 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    54 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                     0008    55 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    56 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    57 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    58 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    59 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    60 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    61 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    62 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    63 .equ Ent_last_x,	16	;; Last x rendered
                     0011    64 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    65 .equ Ent_last_y,	18	;; Last y rendered
                     0013    66 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    67 .equ Ent_state,		20	;; Entity animation state
                     0015    68 .equ Ent_lastState,	21	;; Last entity animation state
                     0016    69 .equ Ent_signal,	22	;; Signar for animations
                     0017    70 .equ Ent_sprite, 	23	;; Entity sprite index
                     0018    71 .equ Ent_sprites_ptr_H, 24	;; Pointer to sprite, high part
                     0019    72 .equ Ent_sprites_ptr_L, 25	;; Pointer to sprite, high part
                     001A    73 .equ Ent_id, 		26	;; Numeric ID
                             74 				;; Frisbee 	0
                             75 				;; Player1 	1
                             76 				;; Enemy1	2
                             77 
                     0003    78 .equ MAX_VEL_X, 3 
                     FFFFFFFD    79 .equ MIN_VEL_X, -3
                     0003    80 .equ MAX_VEL_Y, 3
                     FFFFFFFD    81 .equ MIN_VEL_Y, -3
                             82 
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
                             10 .globl frisbee_setEffect
                             11 .globl frisbee_setVelocities
                             12 .globl frisbee_checkGoal
                             13 .globl frisbee_setState
                             14 .globl update_frisbee_animation
                             15 	
                     001B    16 .equ Frisbee_effect_I, 27
                     001C    17 .equ Frisbee_effect_F, 28
                     0008    18 .equ std_eff, 0x0008
                     FFF8    19 .equ std_N_eff, 0xFFF8
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
                             12 .globl player2_data
                             13 .globl enemy2_data
                             14 .globl game_data
                             15 .globl paletteM1
                             16 .globl paletteM2
                             17 ;;.globl paletteM0
                             18 .globl blackPaletteM1
                             19 ;; ====================================
                             20 ;; ====================================
                             21 ;; GAME PUBLIC DATA
                             22 ;; ====================================
                             23 ;; ====================================
                     0050    24 .equ RIGHT_LIMIT,	80
                     0000    25 .equ LEFT_LIMIT,	0
                     0020    26 .equ TOP_LIMIT,	 	32
                     00C8    27 .equ BOTTOM_LIMIT,	200
                     0028    28 .equ CENTER_LIMIT,	40
                             29 
                             30 
                     002A    31 .equ map_tH, 42
                     0028    32 .equ map_tW, 40
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
   41C5                      25 _cpct_keyboardStatusBuffer:: .ds 10
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



                             10 .include "sprites.h.s"
                              1 .globl _sprite_palette
                              2 
                              3 .globl _sprite_robot_1_0
                              4 .globl _sprite_robot_1_1
                              5 
                              6 .globl _sprite_robot_2_0
                              7 .globl _sprite_robot_2_1
                              8 
                              9 .globl _sprite_frisbee_1_0
                             10 .globl _sprite_frisbee_1_1
                             11 
                             12 ;; MAP
                             13 .globl _map_tileset
                             14 .globl _tilemap
                             15 	
                             16 ;; ":"
                             17 .globl _sprite_points
                             18 ;; "0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
                             19 .globl _sprite_numbers_09
                             20 .globl _sprite_numbers_08
                             21 .globl _sprite_numbers_07
                             22 .globl _sprite_numbers_06
                             23 .globl _sprite_numbers_05
                             24 .globl _sprite_numbers_04
                             25 .globl _sprite_numbers_03
                             26 .globl _sprite_numbers_02
                             27 .globl _sprite_numbers_01
                             28 .globl _sprite_numbers_00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             11 .globl _moveIA
                             12 
                             13 ;; ====================================
                             14 ;; ====================================
                             15 ;; PRIVATE DATA
                             16 ;; ====================================
                             17 ;; ====================================
                             18 	
                             19 ;; ====================================
                             20 ;; ====================================
                             21 ;; PUBLIC FUNCTIONS
                             22 ;; ====================================
                             23 ;; ====================================
   41CF                      24 player_erase::
   41CF DD 21 5F 4D   [14]   25 	ld 	ix, #player_data
   41D3 CD 2D 3E      [17]   26 	call 	entityErase		;; Erase player
   41D6 DD 21 7A 4D   [14]   27 	ld 	ix, #enemy_data
   41DA CD 2D 3E      [17]   28 	call 	entityErase		;; Erase enemy
                             29 
   41DD C9            [10]   30 	ret
                             31 
                             32 ;; =========================================
                             33 ;; Actualiza el estado del player recibido
                             34 ;; 	en IX
                             35 ;; Entrada:
                             36 ;;	IX => Pointer to player data
                             37 ;; Modifica: AF, BC, DE, HL, IX
                             38 ;; =========================================
   41DE                      39 player_update::
                             40 
   41DE DD 7E 1A      [19]   41 	ld	a, Ent_id(ix)
   41E1 FE 02         [ 7]   42 	cp	#2
   41E3 28 09         [12]   43 	jr	z, check_IA		;; Ent_id == 2? check IA
   41E5 FE 04         [ 7]   44 	cp	#4
   41E7 28 05         [12]   45 	jr	z, check_IA		;; Ent_id == 4? check IA
                             46 		;; check input
   41E9 CD 6C 4A      [17]   47 		call checkUserInput
   41EC 18 03         [12]   48 		jr continue_updating
                             49 
   41EE                      50 	check_IA:
   41EE CD DC 49      [17]   51 		call move_IA
                             52 
   41F1                      53 	continue_updating:
                             54 
   41F1 CD 5B 3E      [17]   55 	call entityUpdatePhysics
   41F4 CD B5 3F      [17]   56 	call entityUpdatePosition
   41F7 CD 41 4A      [17]   57 	call checkCenterCrossing
                             58 	
   41FA C9            [10]   59 	ret
                             60 
                             61 ;; ====================================
                             62 ;; ====================================
                             63 ;; PRIVATE FUNCTIONS
                             64 ;; ====================================
                             65 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             66 
                             67 ;; =============================================
                             68 ;; Actualiza el sprite que se tiene que
                             69 ;; 	dibujar en este frame
                             70 ;; Entrada:
                             71 ;;	IX <= Pointer to player data
                             72 ;; Modifica: 
                             73 ;; Devuelve:
                             74 ;; 	A => 1 that state have to update physics
                             75 ;;	  => 0 that state not update physics
                             76 ;; =============================================
   41FB                      77 update_player_animation::
   41FB CD 03 42      [17]   78 	call 	animation_delta
   41FE DD 36 16 FF   [19]   79 	ld 	Ent_signal(ix), #-1
   4202 C9            [10]   80 	ret
                             81 
                             82 ;; =========================================
                             83 ;; Determina el siguiente estado de
                             84 ;;	la entidad
                             85 ;; Entrada:
                             86 ;;	IX <= Pointer to player data
                             87 ;; =========================================
   4203                      88 animation_delta:
   4203 DD 7E 14      [19]   89 	ld	a, Ent_state(ix)
                             90 
   4206 FE 00         [ 7]   91 	cp	#0
   4208 20 04         [12]   92 	jr	nz, not_zero
                             93 		;; STATE 0  ;;
   420A CD 77 43      [17]   94 		call origin_state
   420D C9            [10]   95 		ret
   420E                      96 	not_zero:
   420E FE 01         [ 7]   97 	cp	#1
   4210 20 04         [12]   98 	jr	nz, not_one
                             99 		;; STATE 1 - Step up first state ;;
   4212 CD 42 44      [17]  100 		call stepUp1_state
   4215 C9            [10]  101 		ret
   4216                     102 	not_one:
   4216 FE 02         [ 7]  103 	cp	#2
   4218 20 04         [12]  104 	jr	nz, not_two
                            105 		;; STATE 2 - Step down first state ;;
   421A CD C6 44      [17]  106 		call stepDown1_state
   421D C9            [10]  107 		ret
   421E                     108 	not_two:
   421E FE 03         [ 7]  109 	cp	#3
   4220 20 04         [12]  110 	jr	nz, not_three
                            111 		;; STATE 3 - Step right first state ;;
   4222 CD 46 45      [17]  112 		call stepRight1_state
   4225 C9            [10]  113 		ret
   4226                     114 	not_three:
   4226 FE 04         [ 7]  115 	cp	#4
   4228 20 04         [12]  116 	jr	nz, not_four
                            117 		;; STATE 4 - Step left first state ;;
   422A CD C6 45      [17]  118 		call stepLeft1_state
   422D C9            [10]  119 		ret
   422E                     120 	not_four:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   422E FE 05         [ 7]  121 	cp	#5
   4230 20 04         [12]  122 	jr	nz, not_five
                            123 		;; STATE 5 - Step up-right first state ;;
   4232 CD 46 46      [17]  124 		call stepUpRight1_state
   4235 C9            [10]  125 		ret
   4236                     126 	not_five:
   4236 FE 06         [ 7]  127 	cp	#6
   4238 20 04         [12]  128 	jr	nz, not_six
                            129 		;; STATE 6 - Step up-left first state ;;
   423A CD C6 46      [17]  130 		call stepUpLeft1_state
   423D C9            [10]  131 		ret
   423E                     132 	not_six:
   423E FE 07         [ 7]  133 	cp	#7
   4240 20 04         [12]  134 	jr	nz, not_seven
                            135 		;; STATE 7 - Step down-right first state ;;
   4242 CD 46 47      [17]  136 		call stepDownRight1_state
   4245 C9            [10]  137 		ret
   4246                     138 	not_seven:
   4246 FE 08         [ 7]  139 	cp	#8
   4248 20 04         [12]  140 	jr	nz, not_eight
                            141 		;; STATE 8 - Step down-left first state ;;
   424A CD C6 47      [17]  142 		call stepDownLeft1_state
   424D C9            [10]  143 		ret
   424E                     144 	not_eight:
   424E FE 09         [ 7]  145 	cp	#9
   4250 20 04         [12]  146 	jr	nz, not_nine
                            147 		;; STATE 9 - Throwing up - first ;;
   4252 CD BD 48      [17]  148 		call throwUp1_state
   4255 C9            [10]  149 		ret
   4256                     150 	not_nine:
   4256 FE 0A         [ 7]  151 	cp	#10
   4258 20 04         [12]  152 	jr	nz, not_ten
                            153 		;; STATE 10 - Throwing up ;;
   425A CD CE 48      [17]  154 		call throwUp2_state
   425D C9            [10]  155 		ret
   425E                     156 	not_ten:
   425E FE 0B         [ 7]  157 	cp	#11
   4260 20 04         [12]  158 	jr	nz, not_eleven
                            159 		;; STATE 11 - Throwing up ;;
   4262 CD DF 48      [17]  160 		call throwUp3_state
   4265 C9            [10]  161 		ret
   4266                     162 	not_eleven:
   4266 FE 0C         [ 7]  163 	cp	#12
   4268 20 04         [12]  164 	jr	nz, not_twelve
                            165 		;; STATE 12 - Throwing up ;;
   426A CD F0 48      [17]  166 		call throwUp4_state
   426D C9            [10]  167 		ret
   426E                     168 	not_twelve:
   426E FE 0D         [ 7]  169 	cp	#13
   4270 20 04         [12]  170 	jr	nz, not_thirteen
                            171 		;; STATE 13 - Throwing up ;;
   4272 CD 01 49      [17]  172 		call throwUp5_state
   4275 C9            [10]  173 		ret
   4276                     174 	not_thirteen:
   4276 FE 0E         [ 7]  175 	cp	#14
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   4278 20 04         [12]  176 	jr	nz, not_fourteen
                            177 		;; STATE 14 - Throwing up ;;
   427A CD 12 49      [17]  178 		call throwUp6_state
   427D C9            [10]  179 		ret
   427E                     180 	not_fourteen:
   427E FE 0F         [ 7]  181 	cp	#15
   4280 20 04         [12]  182 	jr	nz, not_fiveteen
                            183 		;; STATE 15 - Throwing up - last ;;
   4282 CD 23 49      [17]  184 		call throwUp7_state
   4285 C9            [10]  185 		ret
   4286                     186 	not_fiveteen:
   4286 FE 10         [ 7]  187 	cp	#16
   4288 20 04         [12]  188 	jr	nz, not_sixteen
                            189 		;; STATE 16 - Throwing Down - first ;;
   428A CD 46 48      [17]  190 		call throwDown1_state
   428D C9            [10]  191 		ret
   428E                     192 	not_sixteen:
   428E FE 11         [ 7]  193 	cp	#17
   4290 20 04         [12]  194 	jr	nz, not_seventeen
                            195 		;; STATE 17 - Throwing Down ;;
   4292 CD 57 48      [17]  196 		call throwDown2_state
   4295 C9            [10]  197 		ret
   4296                     198 	not_seventeen:
   4296 FE 12         [ 7]  199 	cp	#18
   4298 20 04         [12]  200 	jr	nz, not_eighteen
                            201 		;; STATE 18 - Throwing Down ;;
   429A CD 68 48      [17]  202 		call throwDown3_state
   429D C9            [10]  203 		ret
   429E                     204 	not_eighteen:
   429E FE 13         [ 7]  205 	cp	#19
   42A0 20 04         [12]  206 	jr	nz, not_nineteen
                            207 		;; STATE 19 - Throwing Down ;;
   42A2 CD 79 48      [17]  208 		call throwDown4_state
   42A5 C9            [10]  209 		ret
   42A6                     210 	not_nineteen:
   42A6 FE 14         [ 7]  211 	cp	#20
   42A8 20 04         [12]  212 	jr	nz, not_twenty
                            213 		;; STATE 20 - Throwing Down ;;
   42AA CD 8A 48      [17]  214 		call throwDown5_state
   42AD C9            [10]  215 		ret
   42AE                     216 	not_twenty:
   42AE FE 15         [ 7]  217 	cp	#21
   42B0 20 04         [12]  218 	jr	nz, not_twenty_one
                            219 		;; STATE 21 - Throwing Down ;;
   42B2 CD 9B 48      [17]  220 		call throwDown6_state
   42B5 C9            [10]  221 		ret
   42B6                     222 	not_twenty_one:
   42B6 FE 16         [ 7]  223 	cp	#22
   42B8 20 04         [12]  224 	jr	nz, not_twenty_two
                            225 		;; STATE 22 - Throwing Down - last ;;
   42BA CD AC 48      [17]  226 		call throwDown7_state
   42BD C9            [10]  227 		ret
   42BE                     228 	not_twenty_two:
   42BE FE 17         [ 7]  229 	cp	#23
   42C0 20 04         [12]  230 	jr	nz, not_twenty_three
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            231 		;; STATE 23 - Throwing straight - first ;;
   42C2 CD 34 49      [17]  232 		call throwStraight1_state
   42C5 C9            [10]  233 		ret
   42C6                     234 	not_twenty_three:
   42C6 FE 18         [ 7]  235 	cp	#24
   42C8 20 04         [12]  236 	jr	nz, not_twenty_four
                            237 		;; STATE 24 - Throwing straight ;;
   42CA CD 45 49      [17]  238 		call throwStraight2_state
   42CD C9            [10]  239 		ret
   42CE                     240 	not_twenty_four:
   42CE FE 19         [ 7]  241 	cp	#25
   42D0 20 04         [12]  242 	jr	nz, not_twenty_five
                            243 		;; STATE 25 - Throwing straight ;;
   42D2 CD 56 49      [17]  244 		call throwStraight3_state
   42D5 C9            [10]  245 		ret
   42D6                     246 	not_twenty_five:
   42D6 FE 1A         [ 7]  247 	cp	#26
   42D8 20 04         [12]  248 	jr	nz, not_twenty_six
                            249 		;; STATE 26 - Throwing straight ;;
   42DA CD 67 49      [17]  250 		call throwStraight4_state
   42DD C9            [10]  251 		ret
   42DE                     252 	not_twenty_six:
   42DE FE 1B         [ 7]  253 	cp	#27
   42E0 20 04         [12]  254 	jr	nz, not_twenty_seven
                            255 		;; STATE 27 - Throwing straight ;;
   42E2 CD 78 49      [17]  256 		call throwStraight5_state
   42E5 C9            [10]  257 		ret
   42E6                     258 	not_twenty_seven:
   42E6 FE 1C         [ 7]  259 	cp	#28
   42E8 20 04         [12]  260 	jr	nz, not_twenty_eight
                            261 		;; STATE 28 - Throwing straight ;;
   42EA CD 89 49      [17]  262 		call throwStraight6_state
   42ED C9            [10]  263 		ret
   42EE                     264 	not_twenty_eight:
   42EE FE 1D         [ 7]  265 	cp	#29
   42F0 20 04         [12]  266 	jr	nz, not_twenty_nine
                            267 		;; STATE 29 - Throwing straight - last ;;
   42F2 CD 9A 49      [17]  268 		call throwStraight7_state
   42F5 C9            [10]  269 		ret
   42F6                     270 	not_twenty_nine:
   42F6 FE 1E         [ 7]  271 	cp	#30
   42F8 20 04         [12]  272 	jr	nz, not_thirty
                            273 		;; STATE 30 - Step up second state ;;
   42FA CD 67 44      [17]  274 		call stepUp2_state
   42FD C9            [10]  275 		ret
   42FE                     276 	not_thirty:
   42FE FE 1F         [ 7]  277 	cp	#31
   4300 20 04         [12]  278 	jr	nz, not_thirty_one
                            279 		;; STATE 31 - Step up third state ;;
   4302 CD 9D 44      [17]  280 		call stepUp3_state
   4305 C9            [10]  281 		ret
   4306                     282 	not_thirty_one:
   4306 FE 20         [ 7]  283 	cp	#32
   4308 20 04         [12]  284 	jr	nz, not_thirty_two
                            285 		;; STATE 31 - Step down second state ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   430A CD EB 44      [17]  286 		call stepDown2_state
   430D C9            [10]  287 		ret
   430E                     288 	not_thirty_two:
   430E FE 21         [ 7]  289 	cp	#33
   4310 20 04         [12]  290 	jr	nz, not_thirty_three
                            291 		;; STATE 33 - Step down third state ;;
   4312 CD 21 45      [17]  292 		call stepDown3_state
   4315 C9            [10]  293 		ret
   4316                     294 	not_thirty_three:
   4316 FE 22         [ 7]  295 	cp	#34
   4318 20 04         [12]  296 	jr	nz, not_thirty_four
                            297 		;; STATE 34 - Step right second state ;;
   431A CD 6B 45      [17]  298 		call stepRight2_state
   431D C9            [10]  299 		ret
   431E                     300 	not_thirty_four:
   431E FE 23         [ 7]  301 	cp	#35
   4320 20 04         [12]  302 	jr	nz, not_thirty_five
                            303 		;; STATE 35 - Step right third state ;;
   4322 CD A1 45      [17]  304 		call stepRight3_state
   4325 C9            [10]  305 		ret
   4326                     306 	not_thirty_five:
   4326 FE 24         [ 7]  307 	cp	#36
   4328 20 04         [12]  308 	jr	nz, not_thirty_six
                            309 		;; STATE 36 - Step left second state ;;
   432A CD EB 45      [17]  310 		call stepLeft2_state
   432D C9            [10]  311 		ret
   432E                     312 	not_thirty_six:
   432E FE 25         [ 7]  313 	cp	#37
   4330 20 04         [12]  314 	jr	nz, not_thirty_seven
                            315 		;; STATE 37 - Step left third state ;;
   4332 CD 21 46      [17]  316 		call stepLeft3_state
   4335 C9            [10]  317 		ret
   4336                     318 	not_thirty_seven:
   4336 FE 26         [ 7]  319 	cp	#38
   4338 20 04         [12]  320 	jr	nz, not_thirty_eight
                            321 		;; STATE 38 - Step up-right second state ;;
   433A CD 6B 46      [17]  322 		call stepUpRight2_state
   433D C9            [10]  323 		ret
   433E                     324 	not_thirty_eight:
   433E FE 27         [ 7]  325 	cp	#39
   4340 20 04         [12]  326 	jr	nz, not_thirty_nine
                            327 		;; STATE 39 - Step up-right third state ;;
   4342 CD A1 46      [17]  328 		call stepUpRight3_state
   4345 C9            [10]  329 		ret
   4346                     330 	not_thirty_nine:
   4346 FE 28         [ 7]  331 	cp	#40
   4348 20 04         [12]  332 	jr	nz, not_fourty
                            333 		;; STATE 40 - Step up-left second state ;;
   434A CD EB 46      [17]  334 		call stepUpLeft2_state
   434D C9            [10]  335 		ret
   434E                     336 	not_fourty:
   434E FE 29         [ 7]  337 	cp	#41
   4350 20 04         [12]  338 	jr	nz, not_fourty_one
                            339 		;; STATE 41 - Step up-left third state ;;
   4352 CD 21 47      [17]  340 		call stepUpLeft3_state
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   4355 C9            [10]  341 		ret
   4356                     342 	not_fourty_one:
   4356 FE 2A         [ 7]  343 	cp	#42
   4358 20 04         [12]  344 	jr	nz, not_fourty_two
                            345 		;; STATE 42 - Step down-right second state ;;
   435A CD 6B 47      [17]  346 		call stepDownRight2_state
   435D C9            [10]  347 		ret
   435E                     348 	not_fourty_two:
   435E FE 2B         [ 7]  349 	cp	#43
   4360 20 04         [12]  350 	jr	nz, not_fourty_three
                            351 		;; STATE 43 - Step down-right third state ;;
   4362 CD A1 47      [17]  352 		call stepDownRight3_state
   4365 C9            [10]  353 		ret
   4366                     354 	not_fourty_three:
   4366 FE 2C         [ 7]  355 	cp	#44
   4368 20 04         [12]  356 	jr	nz, not_fourty_four
                            357 		;; STATE 44 - Step down-left second state ;;
   436A CD EB 47      [17]  358 		call stepDownLeft2_state
   436D C9            [10]  359 		ret
   436E                     360 	not_fourty_four:
   436E FE 2D         [ 7]  361 	cp	#45
   4370 20 04         [12]  362 	jr	nz, not_fourty_five
                            363 		;; STATE 45 - Step down-left third state ;;
   4372 CD 21 48      [17]  364 		call stepDownLeft3_state
   4375 C9            [10]  365 		ret
   4376                     366 	not_fourty_five:
                            367 
   4376 C9            [10]  368 	ret
                            369 
                            370 ;; ======================================
                            371 ;; 		Origin State #0
                            372 ;; Entrada:  IX <= Pointer to player data
                            373 ;; Devuelve: A <= Not Update/Update
                            374 ;; ======================================
   4377                     375 origin_state:
   4377 DD 7E 16      [19]  376 	ld	a, Ent_signal(ix)
   437A FE 01         [ 7]  377 	cp	#1
   437C 20 0D         [12]  378 	jr	nz, origin_not_one
   437E DD 7E 14      [19]  379 		ld a, Ent_state(ix)	;;
   4381 DD 77 15      [19]  380 		ld Ent_lastState(ix), a	;; LastState <= current state
   4384 DD 36 14 01   [19]  381 		ld Ent_state(ix), #1
   4388 C3 3F 44      [10]  382 		jp origin_exit
   438B                     383 	origin_not_one:
   438B FE 02         [ 7]  384 	cp	#2
   438D 20 0D         [12]  385 	jr	nz, origin_not_two
   438F DD 7E 14      [19]  386 		ld a, Ent_state(ix)	;;
   4392 DD 77 15      [19]  387 		ld Ent_lastState(ix), a	;; LastState <= current state
   4395 DD 36 14 02   [19]  388 		ld Ent_state(ix), #2
   4399 C3 3F 44      [10]  389 		jp origin_exit
   439C                     390 	origin_not_two:
   439C FE 03         [ 7]  391 	cp	#3
   439E 20 0D         [12]  392 	jr	nz, origin_not_three
   43A0 DD 7E 14      [19]  393 		ld a, Ent_state(ix)	;;
   43A3 DD 77 15      [19]  394 		ld Ent_lastState(ix), a	;; LastState <= current state
   43A6 DD 36 14 03   [19]  395 		ld Ent_state(ix), #3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   43AA C3 3F 44      [10]  396 		jp origin_exit
   43AD                     397 	origin_not_three:
   43AD FE 04         [ 7]  398 	cp	#4
   43AF 20 0D         [12]  399 	jr	nz, origin_not_four
   43B1 DD 7E 14      [19]  400 		ld a, Ent_state(ix)	;;
   43B4 DD 77 15      [19]  401 		ld Ent_lastState(ix), a	;; LastState <= current state
   43B7 DD 36 14 04   [19]  402 		ld Ent_state(ix), #4
   43BB C3 3F 44      [10]  403 		jp origin_exit
   43BE                     404 	origin_not_four:
   43BE FE 05         [ 7]  405 	cp	#5
   43C0 20 0D         [12]  406 	jr	nz, origin_not_five
   43C2 DD 7E 14      [19]  407 		ld a, Ent_state(ix)	;;
   43C5 DD 77 15      [19]  408 		ld Ent_lastState(ix), a	;; LastState <= current state
   43C8 DD 36 14 05   [19]  409 		ld Ent_state(ix), #5
   43CC C3 3F 44      [10]  410 		jp origin_exit
   43CF                     411 	origin_not_five:
   43CF FE 06         [ 7]  412 	cp	#6
   43D1 20 0D         [12]  413 	jr	nz, origin_not_six
   43D3 DD 7E 14      [19]  414 		ld a, Ent_state(ix)	;;
   43D6 DD 77 15      [19]  415 		ld Ent_lastState(ix), a	;; LastState <= current state
   43D9 DD 36 14 06   [19]  416 		ld Ent_state(ix), #6
   43DD C3 3F 44      [10]  417 		jp origin_exit
   43E0                     418 	origin_not_six:
   43E0 FE 07         [ 7]  419 	cp	#7
   43E2 20 0D         [12]  420 	jr	nz, origin_not_seven
   43E4 DD 7E 14      [19]  421 		ld a, Ent_state(ix)	;;
   43E7 DD 77 15      [19]  422 		ld Ent_lastState(ix), a	;; LastState <= current state
   43EA DD 36 14 07   [19]  423 		ld Ent_state(ix), #7
   43EE C3 3F 44      [10]  424 		jp origin_exit
   43F1                     425 	origin_not_seven:
   43F1 FE 08         [ 7]  426 	cp	#8
   43F3 20 0D         [12]  427 	jr	nz, origin_not_eight
   43F5 DD 7E 14      [19]  428 		ld a, Ent_state(ix)	;;
   43F8 DD 77 15      [19]  429 		ld Ent_lastState(ix), a	;; LastState <= current state
   43FB DD 36 14 08   [19]  430 		ld Ent_state(ix), #8
   43FF C3 3F 44      [10]  431 		jp origin_exit
   4402                     432 	origin_not_eight:
   4402 FE 09         [ 7]  433 	cp	#9
   4404 20 0D         [12]  434 	jr	nz, origin_not_nine
   4406 DD 7E 14      [19]  435 		ld a, Ent_state(ix)	;;
   4409 DD 77 15      [19]  436 		ld Ent_lastState(ix), a	;; LastState <= current state
   440C DD 36 14 10   [19]  437 		ld Ent_state(ix), #16
   4410 C3 3F 44      [10]  438 		jp origin_exit
   4413                     439 	origin_not_nine:
   4413 FE 0A         [ 7]  440 	cp	#10
   4415 20 0D         [12]  441 	jr	nz, origin_not_ten
   4417 DD 7E 14      [19]  442 		ld a, Ent_state(ix)	;;
   441A DD 77 15      [19]  443 		ld Ent_lastState(ix), a	;; LastState <= current state
   441D DD 36 14 09   [19]  444 		ld Ent_state(ix), #9
   4421 C3 3F 44      [10]  445 		jp origin_exit
   4424                     446 	origin_not_ten:
   4424 FE 0B         [ 7]  447 	cp	#11
   4426 20 0D         [12]  448 	jr	nz, origin_not_eleven
   4428 DD 7E 14      [19]  449 		ld a, Ent_state(ix)	;;
   442B DD 77 15      [19]  450 		ld Ent_lastState(ix), a	;; LastState <= current state
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   442E DD 36 14 17   [19]  451 		ld Ent_state(ix), #23
   4432 C3 3F 44      [10]  452 		jp origin_exit
   4435                     453 	origin_not_eleven:
                            454 	;; else
   4435 DD 7E 14      [19]  455 	ld a, Ent_state(ix)	;;
   4438 DD 77 15      [19]  456 	ld Ent_lastState(ix), a	;; LastState <= current state
   443B DD 36 14 00   [19]  457 	ld Ent_state(ix), #0
                            458 
   443F                     459 	origin_exit:
   443F 3E 01         [ 7]  460 	ld 	a, #1
                            461 
   4441 C9            [10]  462 	ret
                            463 
                            464 ;; =======================================
                            465 ;; =======================================
                            466 ;; == 		MOVE UP STATES		==
                            467 ;; =======================================
                            468 ;; =======================================
                            469 
                            470 ;; ======================================
                            471 ;; 		Step up 1 State #1
                            472 ;; Entrada:  IX <= Pointer to player data
                            473 ;; Devuelve: A <= Not Update/Update
                            474 ;; ======================================
   4442                     475 stepUp1_state:
   4442 DD 36 17 00   [19]  476 	ld Ent_sprite(ix), #0	;; Next sprite <= 0
   4446 DD 7E 16      [19]  477 	ld	a, Ent_signal(ix)
   4449 FE 01         [ 7]  478 	cp	#1
   444B 20 0D         [12]  479 	jr 	nz, stepUp1_else
                            480 		;; Move up
   444D DD 7E 14      [19]  481 		ld a, Ent_state(ix)	;;
   4450 DD 77 15      [19]  482 		ld Ent_lastState(ix), a	;; LastState <= current state
   4453 DD 36 14 1E   [19]  483 		ld Ent_state(ix), #30	;; Next state <= 30
                            484 
   4457 3E 01         [ 7]  485 		ld a, #1		;; A <= Update physics
   4459 C9            [10]  486 		ret
   445A                     487 	stepUp1_else:
                            488 	;; else
   445A DD 7E 14      [19]  489 	ld a, Ent_state(ix)	;;
   445D DD 77 15      [19]  490 	ld Ent_lastState(ix), a	;; LastState <= current state
   4460 DD 36 14 00   [19]  491 	ld Ent_state(ix), #0	;; Next state <= 0
   4464 3E 01         [ 7]  492 	ld a, #1		;; A <= Update physics
                            493 
   4466 C9            [10]  494 	ret
                            495 
                            496 
                            497 ;; ======================================
                            498 ;; 		Step up 2 State #30
                            499 ;; Entrada:  IX <= Pointer to player data
                            500 ;; Devuelve: A <= Not Update/Update
                            501 ;; ======================================
   4467                     502 stepUp2_state:
   4467 DD 36 17 01   [19]  503 	ld Ent_sprite(ix), #1		;; Next sprite <= 1
   446B DD 7E 16      [19]  504 	ld	a, Ent_signal(ix)
   446E FE 01         [ 7]  505 	cp	#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   4470 20 1E         [12]  506 	jr 	nz, stepUp2_else
                            507 		;; Move up
   4472 DD 7E 15      [19]  508 		ld a, Ent_lastState(ix)
   4475 FE 01         [ 7]  509 		cp #1
   4477 28 0A         [12]  510 		jr z, goto_state_31
                            511 			;; GO TO 1
   4479 DD 7E 14      [19]  512 			ld a, Ent_state(ix)	;;
   447C DD 77 15      [19]  513 			ld Ent_lastState(ix), a	;; LastState <= current state
   447F DD 36 14 01   [19]  514 			ld Ent_state(ix), #1	;; Next state <= 1
   4483                     515 		goto_state_31:
   4483 DD 7E 14      [19]  516 		ld a, Ent_state(ix)	;;
   4486 DD 77 15      [19]  517 		ld Ent_lastState(ix), a	;; LastState <= current state
   4489 DD 36 14 1F   [19]  518 		ld Ent_state(ix), #31	;; Next state <= 30
                            519 
   448D 3E 01         [ 7]  520 		ld a, #1		;; A <= Update physics
   448F C9            [10]  521 		ret
   4490                     522 	stepUp2_else:
                            523 	;; else
   4490 DD 7E 14      [19]  524 	ld a, Ent_state(ix)	;;
   4493 DD 77 15      [19]  525 	ld Ent_lastState(ix), a	;; LastState <= current state
   4496 DD 36 14 00   [19]  526 	ld Ent_state(ix), #0	;; Next state <= 0
   449A 3E 01         [ 7]  527 	ld a, #1		;; A <= Update physics
   449C C9            [10]  528 	ret
                            529 
                            530 
                            531 ;; ======================================
                            532 ;; 		Step up 3 State #31
                            533 ;; Entrada:  IX <= Pointer to player data
                            534 ;; Devuelve: A <= Not Update/Update
                            535 ;; ======================================
   449D                     536 stepUp3_state:
   449D DD 36 17 02   [19]  537 	ld Ent_sprite(ix), #2		;; Next sprite <= 2
   44A1 DD 7E 16      [19]  538 	ld	a, Ent_signal(ix)
   44A4 FE 01         [ 7]  539 	cp	#1
   44A6 20 11         [12]  540 	jr 	nz, stepUp3_else
                            541 		;; Move up
   44A8 DD 36 17 00   [19]  542 		ld Ent_sprite(ix), #0	;; Next sprite <= 1
   44AC DD 7E 14      [19]  543 		ld a, Ent_state(ix)	;;
   44AF DD 77 15      [19]  544 		ld Ent_lastState(ix), a	;; LastState <= current state
   44B2 DD 36 14 1E   [19]  545 		ld Ent_state(ix), #30	;; Next state <= 30
                            546 
   44B6 3E 01         [ 7]  547 		ld a, #1		;; A <= Update physics
   44B8 C9            [10]  548 		ret
   44B9                     549 	stepUp3_else:
                            550 	;; else
   44B9 DD 7E 14      [19]  551 	ld a, Ent_state(ix)	;;
   44BC DD 77 15      [19]  552 	ld Ent_lastState(ix), a	;; LastState <= current state
   44BF DD 36 14 00   [19]  553 	ld Ent_state(ix), #0	;; Next state <= 0
   44C3 3E 01         [ 7]  554 	ld a, #1		;; A <= Update physics
   44C5 C9            [10]  555 	ret
                            556 
                            557 ;; =======================================
                            558 ;; =======================================
                            559 ;; == 		MOVE DOWN STATES	==
                            560 ;; =======================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



                            561 ;; =======================================
                            562 
                            563 ;; ======================================
                            564 ;; 		Step down 1 State #2
                            565 ;; Entrada:  IX <= Pointer to player data
                            566 ;; Devuelve: A <= Not Update/Update
                            567 ;; ======================================
   44C6                     568 stepDown1_state:
   44C6 DD 36 17 03   [19]  569 	ld Ent_sprite(ix), #3		;; Next sprite <= 3
   44CA DD 7E 16      [19]  570 	ld	a, Ent_signal(ix)
   44CD FE 02         [ 7]  571 	cp	#2
   44CF 20 0D         [12]  572 	jr 	nz, stepDown1_else
                            573 		;; Move Down
   44D1 DD 7E 14      [19]  574 		ld a, Ent_state(ix)	;;
   44D4 DD 77 15      [19]  575 		ld Ent_lastState(ix), a	;; LastState <= current state
   44D7 DD 36 14 20   [19]  576 		ld Ent_state(ix), #32	;; Next state <= 32
                            577 
   44DB 3E 01         [ 7]  578 		ld a, #1		;; A <= Update physics
   44DD C9            [10]  579 		ret
   44DE                     580 	stepDown1_else:
                            581 	;; else
   44DE DD 7E 14      [19]  582 	ld a, Ent_state(ix)	;;
   44E1 DD 77 15      [19]  583 	ld Ent_lastState(ix), a	;; LastState <= current state
   44E4 DD 36 14 00   [19]  584 	ld Ent_state(ix), #0	;; Next state <= 0
   44E8 3E 01         [ 7]  585 	ld a, #1		;; A <= Update physics
                            586 
   44EA C9            [10]  587 	ret
                            588 
                            589 
                            590 ;; ======================================
                            591 ;; 	Step down 2 State #32
                            592 ;; Entrada:  IX <= Pointer to player data
                            593 ;; Devuelve: A <= Not Update/Update
                            594 ;; ======================================
   44EB                     595 stepDown2_state:
   44EB DD 36 17 04   [19]  596 	ld Ent_sprite(ix), #4	;; Next sprite <= 4
   44EF DD 7E 16      [19]  597 	ld	a, Ent_signal(ix)
   44F2 FE 02         [ 7]  598 	cp	#2
   44F4 20 1E         [12]  599 	jr 	nz, stepDown2_else
                            600 		;; Move down
   44F6 DD 7E 15      [19]  601 		ld a, Ent_lastState(ix)
   44F9 FE 02         [ 7]  602 		cp #2
   44FB 28 0A         [12]  603 		jr z, goto_state_33
                            604 			;; GO TO 2
   44FD DD 7E 14      [19]  605 			ld a, Ent_state(ix)	;;
   4500 DD 77 15      [19]  606 			ld Ent_lastState(ix), a	;; LastState <= current state
   4503 DD 36 14 02   [19]  607 			ld Ent_state(ix), #2	;; Next state <= 2
   4507                     608 		goto_state_33:
   4507 DD 7E 14      [19]  609 		ld a, Ent_state(ix)	;;
   450A DD 77 15      [19]  610 		ld Ent_lastState(ix), a	;; LastState <= current state
   450D DD 36 14 21   [19]  611 		ld Ent_state(ix), #33	;; Next state <= 33
                            612 
   4511 3E 01         [ 7]  613 		ld a, #1		;; A <= Update physics
   4513 C9            [10]  614 		ret
   4514                     615 	stepDown2_else:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



                            616 	;; else
   4514 DD 7E 14      [19]  617 	ld a, Ent_state(ix)	;;
   4517 DD 77 15      [19]  618 	ld Ent_lastState(ix), a	;; LastState <= current state
   451A DD 36 14 00   [19]  619 	ld Ent_state(ix), #0	;; Next state <= 0
   451E 3E 01         [ 7]  620 	ld a, #1		;; A <= Update physics
   4520 C9            [10]  621 	ret
                            622 
                            623 
                            624 ;; ======================================
                            625 ;; 	Step down 3 State #33
                            626 ;; Entrada:  IX <= Pointer to player data
                            627 ;; Devuelve: A <= Not Update/Update
                            628 ;; ======================================
   4521                     629 stepDown3_state:
   4521 DD 36 17 05   [19]  630 	ld Ent_sprite(ix), #5	;; Next sprite <= 5
   4525 DD 7E 16      [19]  631 	ld	a, Ent_signal(ix)
   4528 FE 02         [ 7]  632 	cp	#2
   452A 20 0D         [12]  633 	jr 	nz, stepDown3_else
                            634 		;; Move down
   452C DD 7E 14      [19]  635 		ld a, Ent_state(ix)	;;
   452F DD 77 15      [19]  636 		ld Ent_lastState(ix), a	;; LastState <= current state
   4532 DD 36 14 20   [19]  637 		ld Ent_state(ix), #32	;; Next state <= 32
                            638 
   4536 3E 01         [ 7]  639 		ld a, #1		;; A <= Update physics
   4538 C9            [10]  640 		ret
   4539                     641 	stepDown3_else:
                            642 	;; else
   4539 DD 7E 14      [19]  643 	ld a, Ent_state(ix)	;;
   453C DD 77 15      [19]  644 	ld Ent_lastState(ix), a	;; LastState <= current state
   453F DD 36 14 00   [19]  645 	ld Ent_state(ix), #0	;; Next state <= 0
   4543 3E 01         [ 7]  646 	ld a, #1		;; A <= Update physics
   4545 C9            [10]  647 	ret
                            648 
                            649 
                            650 ;; =======================================
                            651 ;; =======================================
                            652 ;; == 		MOVE RIGHT STATES	==
                            653 ;; =======================================
                            654 ;; =======================================
                            655 
                            656 ;; ======================================
                            657 ;; 	Step Right 1 State #3
                            658 ;; Entrada:  IX <= Pointer to player data
                            659 ;; Devuelve: A <= Not Update/Update
                            660 ;; ======================================
   4546                     661 stepRight1_state:
   4546 DD 36 17 06   [19]  662 	ld Ent_sprite(ix), #6		;; Next sprite <= 6
   454A DD 7E 16      [19]  663 	ld	a, Ent_signal(ix)
   454D FE 03         [ 7]  664 	cp	#3
   454F 20 0D         [12]  665 	jr 	nz, stepRight1_else
                            666 		;; Move Right
   4551 DD 7E 14      [19]  667 		ld a, Ent_state(ix)	;;
   4554 DD 77 15      [19]  668 		ld Ent_lastState(ix), a	;; LastState <= current state
   4557 DD 36 14 22   [19]  669 		ld Ent_state(ix), #34	;; Next state <= 34
                            670 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



   455B 3E 01         [ 7]  671 		ld a, #1		;; A <= Update physics
   455D C9            [10]  672 		ret
   455E                     673 	stepRight1_else:
                            674 	;; else
   455E DD 7E 14      [19]  675 	ld a, Ent_state(ix)	;;
   4561 DD 77 15      [19]  676 	ld Ent_lastState(ix), a	;; LastState <= current state
   4564 DD 36 14 00   [19]  677 	ld Ent_state(ix), #0	;; Next state <= 0
   4568 3E 01         [ 7]  678 	ld a, #1		;; A <= Update physics
   456A C9            [10]  679 	ret
                            680 
                            681 
                            682 ;; ======================================
                            683 ;; 	Step Right 2 State #34
                            684 ;; Entrada:  IX <= Pointer to player data
                            685 ;; Devuelve: A <= Not Update/Update
                            686 ;; ======================================
   456B                     687 stepRight2_state:
   456B DD 36 17 07   [19]  688 	ld Ent_sprite(ix), #7			;; Next sprite <= 7
   456F DD 7E 16      [19]  689 	ld	a, Ent_signal(ix)
   4572 FE 03         [ 7]  690 	cp	#3
   4574 20 1E         [12]  691 	jr 	nz, stepRight2_else
                            692 		;; Move Right
   4576 DD 7E 15      [19]  693 		ld a, Ent_lastState(ix)
   4579 FE 03         [ 7]  694 		cp #3
   457B 28 0A         [12]  695 		jr z, goto_state_35
                            696 			;; GO TO 3
   457D DD 7E 14      [19]  697 			ld a, Ent_state(ix)	;;
   4580 DD 77 15      [19]  698 			ld Ent_lastState(ix), a	;; LastState <= current state
   4583 DD 36 14 03   [19]  699 			ld Ent_state(ix), #3	;; Next state <= 3
   4587                     700 		goto_state_35:
   4587 DD 7E 14      [19]  701 		ld a, Ent_state(ix)	;;
   458A DD 77 15      [19]  702 		ld Ent_lastState(ix), a	;; LastState <= current state
   458D DD 36 14 23   [19]  703 		ld Ent_state(ix), #35	;; Next state <= 35
                            704 
   4591 3E 01         [ 7]  705 		ld a, #1		;; A <= Update physics
   4593 C9            [10]  706 		ret
   4594                     707 	stepRight2_else:
                            708 	;; else
   4594 DD 7E 14      [19]  709 	ld a, Ent_state(ix)	;;
   4597 DD 77 15      [19]  710 	ld Ent_lastState(ix), a	;; LastState <= current state
   459A DD 36 14 00   [19]  711 	ld Ent_state(ix), #0	;; Next state <= 0
   459E 3E 01         [ 7]  712 	ld a, #1		;; A <= Update physics
   45A0 C9            [10]  713 	ret
                            714 
                            715 
                            716 ;; ======================================
                            717 ;; 	Step Right 3 State #35
                            718 ;; Entrada:  IX <= Pointer to player data
                            719 ;; Devuelve: A <= Not Update/Update
                            720 ;; ======================================
   45A1                     721 stepRight3_state:
   45A1 DD 36 17 08   [19]  722 	ld Ent_sprite(ix), #8		;; Next sprite <= 8
   45A5 DD 7E 16      [19]  723 	ld	a, Ent_signal(ix)
   45A8 FE 03         [ 7]  724 	cp	#3
   45AA 20 0D         [12]  725 	jr 	nz, stepRight3_else
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



                            726 		;; Move Right
   45AC DD 7E 14      [19]  727 		ld a, Ent_state(ix)	;;
   45AF DD 77 15      [19]  728 		ld Ent_lastState(ix), a	;; LastState <= current state
   45B2 DD 36 14 22   [19]  729 		ld Ent_state(ix), #34	;; Next state <= 34
                            730 
   45B6 3E 01         [ 7]  731 		ld a, #1		;; A <= Update physics
   45B8 C9            [10]  732 		ret
   45B9                     733 	stepRight3_else:
                            734 	;; else
   45B9 DD 7E 14      [19]  735 	ld a, Ent_state(ix)	;;
   45BC DD 77 15      [19]  736 	ld Ent_lastState(ix), a	;; LastState <= current state
   45BF DD 36 14 00   [19]  737 	ld Ent_state(ix), #0	;; Next state <= 0
   45C3 3E 01         [ 7]  738 	ld a, #1		;; A <= Update physics
   45C5 C9            [10]  739 	ret
                            740 
                            741 
                            742 ;; =======================================
                            743 ;; =======================================
                            744 ;; == 		MOVE LEFT STATES	==
                            745 ;; =======================================
                            746 ;; =======================================
                            747 
                            748 ;; ======================================
                            749 ;; 	Step Left 1 State #4
                            750 ;; Entrada:  IX <= Pointer to player data
                            751 ;; Devuelve: A <= Not Update/Update
                            752 ;; ======================================
   45C6                     753 stepLeft1_state:
   45C6 DD 36 17 09   [19]  754 	ld Ent_sprite(ix), #9		;; Next sprite <= 9
   45CA DD 7E 16      [19]  755 	ld	a, Ent_signal(ix)
   45CD FE 04         [ 7]  756 	cp	#4
   45CF 20 0D         [12]  757 	jr 	nz, stepLeft1_else
                            758 		;; Move Left
   45D1 DD 7E 14      [19]  759 		ld a, Ent_state(ix)	;;
   45D4 DD 77 15      [19]  760 		ld Ent_lastState(ix), a	;; LastState <= current state
   45D7 DD 36 14 24   [19]  761 		ld Ent_state(ix), #36	;; Next state <= 36
                            762 
   45DB 3E 01         [ 7]  763 		ld a, #1		;; A <= Update physics
   45DD C9            [10]  764 		ret
   45DE                     765 	stepLeft1_else:
                            766 	;; else
   45DE DD 7E 14      [19]  767 	ld a, Ent_state(ix)	;;
   45E1 DD 77 15      [19]  768 	ld Ent_lastState(ix), a	;; LastState <= current state
   45E4 DD 36 14 00   [19]  769 	ld Ent_state(ix), #0	;; Next state <= 0
   45E8 3E 01         [ 7]  770 	ld a, #1		;; A <= Update physics
   45EA C9            [10]  771 	ret
                            772 
                            773 
                            774 ;; ======================================
                            775 ;; 	Step Left 2 State #36
                            776 ;; Entrada:  IX <= Pointer to player data
                            777 ;; Devuelve: A <= Not Update/Update
                            778 ;; ======================================
   45EB                     779 stepLeft2_state:
   45EB DD 36 17 0A   [19]  780 	ld Ent_sprite(ix), #10			;; Next sprite <= 10
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 25.
Hexadecimal [16-Bits]



   45EF DD 7E 16      [19]  781 	ld	a, Ent_signal(ix)
   45F2 FE 04         [ 7]  782 	cp	#4
   45F4 20 1E         [12]  783 	jr 	nz, stepLeft2_else
                            784 		;; Move Left
   45F6 DD 7E 15      [19]  785 		ld a, Ent_lastState(ix)
   45F9 FE 03         [ 7]  786 		cp #3
   45FB 28 0A         [12]  787 		jr z, goto_state_37
                            788 			;; GO TO 4
   45FD DD 7E 14      [19]  789 			ld a, Ent_state(ix)	;;
   4600 DD 77 15      [19]  790 			ld Ent_lastState(ix), a	;; LastState <= current state
   4603 DD 36 14 04   [19]  791 			ld Ent_state(ix), #4	;; Next state <= 4
   4607                     792 		goto_state_37:
   4607 DD 7E 14      [19]  793 		ld a, Ent_state(ix)	;;
   460A DD 77 15      [19]  794 		ld Ent_lastState(ix), a	;; LastState <= current state
   460D DD 36 14 25   [19]  795 		ld Ent_state(ix), #37	;; Next state <= 37
                            796 
   4611 3E 01         [ 7]  797 		ld a, #1		;; A <= Update physics
   4613 C9            [10]  798 		ret
   4614                     799 	stepLeft2_else:
                            800 	;; else
   4614 DD 7E 14      [19]  801 	ld a, Ent_state(ix)	;;
   4617 DD 77 15      [19]  802 	ld Ent_lastState(ix), a	;; LastState <= current state
   461A DD 36 14 00   [19]  803 	ld Ent_state(ix), #0	;; Next state <= 0
   461E 3E 01         [ 7]  804 	ld a, #1		;; A <= Update physics
   4620 C9            [10]  805 	ret
                            806 
                            807 
                            808 ;; ======================================
                            809 ;; 	Step Left 3 State #37
                            810 ;; Entrada:  IX <= Pointer to player data
                            811 ;; Devuelve: A <= Not Update/Update
                            812 ;; ======================================
   4621                     813 stepLeft3_state:
   4621 DD 36 17 0B   [19]  814 	ld Ent_sprite(ix), #11		;; Next sprite <= 11
   4625 DD 7E 16      [19]  815 	ld	a, Ent_signal(ix)
   4628 FE 04         [ 7]  816 	cp	#4
   462A 20 0D         [12]  817 	jr 	nz, stepLeft3_else
                            818 		;; Move Left
   462C DD 7E 14      [19]  819 		ld a, Ent_state(ix)	;;
   462F DD 77 15      [19]  820 		ld Ent_lastState(ix), a	;; LastState <= current state
   4632 DD 36 14 24   [19]  821 		ld Ent_state(ix), #36	;; Next state <= 36
                            822 
   4636 3E 01         [ 7]  823 		ld a, #1		;; A <= Update physics
   4638 C9            [10]  824 		ret
   4639                     825 	stepLeft3_else:
                            826 	;; else
   4639 DD 7E 14      [19]  827 	ld a, Ent_state(ix)	;;
   463C DD 77 15      [19]  828 	ld Ent_lastState(ix), a	;; LastState <= current state
   463F DD 36 14 00   [19]  829 	ld Ent_state(ix), #0	;; Next state <= 0
   4643 3E 01         [ 7]  830 	ld a, #1		;; A <= Update physics
   4645 C9            [10]  831 	ret
                            832 
                            833 
                            834 ;; =======================================
                            835 ;; =======================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 26.
Hexadecimal [16-Bits]



                            836 ;; == 	    MOVE UP RIGHT STATES	==
                            837 ;; =======================================
                            838 ;; =======================================
                            839 
                            840 ;; ======================================
                            841 ;; 	Step UpRight 1 State #5
                            842 ;; Entrada:  IX <= Pointer to player data
                            843 ;; Devuelve: A <= Not Update/Update
                            844 ;; ======================================
   4646                     845 stepUpRight1_state:
   4646 DD 36 17 0C   [19]  846 	ld Ent_sprite(ix), #12		;; Next sprite <= 12
   464A DD 7E 16      [19]  847 	ld	a, Ent_signal(ix)
   464D FE 05         [ 7]  848 	cp	#5
   464F 20 0D         [12]  849 	jr 	nz, stepUpRight1_else
                            850 		;; Move UpRight
   4651 DD 7E 14      [19]  851 		ld a, Ent_state(ix)	;;
   4654 DD 77 15      [19]  852 		ld Ent_lastState(ix), a	;; LastState <= current state
   4657 DD 36 14 26   [19]  853 		ld Ent_state(ix), #38	;; Next state <= 38
                            854 
   465B 3E 01         [ 7]  855 		ld a, #1		;; A <= Update physics
   465D C9            [10]  856 		ret
   465E                     857 	stepUpRight1_else:
                            858 	;; else
   465E DD 7E 14      [19]  859 	ld a, Ent_state(ix)	;;
   4661 DD 77 15      [19]  860 	ld Ent_lastState(ix), a	;; LastState <= current state
   4664 DD 36 14 00   [19]  861 	ld Ent_state(ix), #0	;; Next state <= 0
   4668 3E 01         [ 7]  862 	ld a, #1		;; A <= Update physics
   466A C9            [10]  863 	ret
                            864 
                            865 
                            866 ;; ======================================
                            867 ;; 	Step UpRight 2 State #38
                            868 ;; Entrada:  IX <= Pointer to player data
                            869 ;; Devuelve: A <= Not Update/Update
                            870 ;; ======================================
   466B                     871 stepUpRight2_state:
   466B DD 36 17 0D   [19]  872 	ld Ent_sprite(ix), #13			;; Next sprite <= 13
   466F DD 7E 16      [19]  873 	ld	a, Ent_signal(ix)
   4672 FE 05         [ 7]  874 	cp	#5
   4674 20 1E         [12]  875 	jr 	nz, stepUpRight2_else
                            876 		;; Move UpRight
   4676 DD 7E 15      [19]  877 		ld a, Ent_lastState(ix)
   4679 FE 03         [ 7]  878 		cp #3
   467B 28 0A         [12]  879 		jr z, goto_state_39
                            880 			;; GO TO 5
   467D DD 7E 14      [19]  881 			ld a, Ent_state(ix)	;;
   4680 DD 77 15      [19]  882 			ld Ent_lastState(ix), a	;; LastState <= current state
   4683 DD 36 14 05   [19]  883 			ld Ent_state(ix), #5	;; Next state <= 5
   4687                     884 		goto_state_39:
   4687 DD 7E 14      [19]  885 		ld a, Ent_state(ix)	;;
   468A DD 77 15      [19]  886 		ld Ent_lastState(ix), a	;; LastState <= current state
   468D DD 36 14 27   [19]  887 		ld Ent_state(ix), #39	;; Next state <= 39
                            888 
   4691 3E 01         [ 7]  889 		ld a, #1		;; A <= Update physics
   4693 C9            [10]  890 		ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 27.
Hexadecimal [16-Bits]



   4694                     891 	stepUpRight2_else:
                            892 	;; else
   4694 DD 7E 14      [19]  893 	ld a, Ent_state(ix)	;;
   4697 DD 77 15      [19]  894 	ld Ent_lastState(ix), a	;; LastState <= current state
   469A DD 36 14 00   [19]  895 	ld Ent_state(ix), #0	;; Next state <= 0
   469E 3E 01         [ 7]  896 	ld a, #1		;; A <= Update physics
   46A0 C9            [10]  897 	ret
                            898 
                            899 
                            900 ;; ======================================
                            901 ;; 	Step UpRight 3 State #39
                            902 ;; Entrada:  IX <= Pointer to player data
                            903 ;; Devuelve: A <= Not Update/Update
                            904 ;; ======================================
   46A1                     905 stepUpRight3_state:
   46A1 DD 36 17 0E   [19]  906 	ld Ent_sprite(ix), #14		;; Next sprite <= 14
   46A5 DD 7E 16      [19]  907 	ld	a, Ent_signal(ix)
   46A8 FE 05         [ 7]  908 	cp	#5
   46AA 20 0D         [12]  909 	jr 	nz, stepUpRight3_else
                            910 		;; Move UpRight
   46AC DD 7E 14      [19]  911 		ld a, Ent_state(ix)	;;
   46AF DD 77 15      [19]  912 		ld Ent_lastState(ix), a	;; LastState <= current state
   46B2 DD 36 14 26   [19]  913 		ld Ent_state(ix), #38	;; Next state <= 38
                            914 
   46B6 3E 01         [ 7]  915 		ld a, #1		;; A <= Update physics
   46B8 C9            [10]  916 		ret
   46B9                     917 	stepUpRight3_else:
                            918 	;; else
   46B9 DD 7E 14      [19]  919 	ld a, Ent_state(ix)	;;
   46BC DD 77 15      [19]  920 	ld Ent_lastState(ix), a	;; LastState <= current state
   46BF DD 36 14 00   [19]  921 	ld Ent_state(ix), #0	;; Next state <= 0
   46C3 3E 01         [ 7]  922 	ld a, #1		;; A <= Update physics
   46C5 C9            [10]  923 	ret
                            924 
                            925 
                            926 
                            927 ;; =======================================
                            928 ;; =======================================
                            929 ;; == 	    MOVE UP LEFT STATES	==
                            930 ;; =======================================
                            931 ;; =======================================
                            932 
                            933 ;; ======================================
                            934 ;; 	Step UpLeft 1 State #6
                            935 ;; Entrada:  IX <= Pointer to player data
                            936 ;; Devuelve: A <= Not Update/Update
                            937 ;; ======================================
   46C6                     938 stepUpLeft1_state:
   46C6 DD 36 17 0F   [19]  939 	ld Ent_sprite(ix), #15		;; Next sprite <= 15
   46CA DD 7E 16      [19]  940 	ld	a, Ent_signal(ix)
   46CD FE 06         [ 7]  941 	cp	#6
   46CF 20 0D         [12]  942 	jr 	nz, stepUpLeft1_else
                            943 		;; Move UpLeft
   46D1 DD 7E 14      [19]  944 		ld a, Ent_state(ix)	;;
   46D4 DD 77 15      [19]  945 		ld Ent_lastState(ix), a	;; LastState <= current state
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 28.
Hexadecimal [16-Bits]



   46D7 DD 36 14 28   [19]  946 		ld Ent_state(ix), #40	;; Next state <= 40
                            947 
   46DB 3E 01         [ 7]  948 		ld a, #1		;; A <= Update physics
   46DD C9            [10]  949 		ret
   46DE                     950 	stepUpLeft1_else:
                            951 	;; else
   46DE DD 7E 14      [19]  952 	ld a, Ent_state(ix)	;;
   46E1 DD 77 15      [19]  953 	ld Ent_lastState(ix), a	;; LastState <= current state
   46E4 DD 36 14 00   [19]  954 	ld Ent_state(ix), #0	;; Next state <= 0
   46E8 3E 01         [ 7]  955 	ld a, #1		;; A <= Update physics
   46EA C9            [10]  956 	ret
                            957 
                            958 
                            959 ;; ======================================
                            960 ;; 	Step UpLeft 2 State #40
                            961 ;; Entrada:  IX <= Pointer to player data
                            962 ;; Devuelve: A <= Not Update/Update
                            963 ;; ======================================
   46EB                     964 stepUpLeft2_state:
   46EB DD 36 17 10   [19]  965 	ld Ent_sprite(ix), #16			;; Next sprite <= 16
   46EF DD 7E 16      [19]  966 	ld	a, Ent_signal(ix)
   46F2 FE 06         [ 7]  967 	cp	#6
   46F4 20 1E         [12]  968 	jr 	nz, stepUpLeft2_else
                            969 		;; Move UpLeft
   46F6 DD 7E 15      [19]  970 		ld a, Ent_lastState(ix)
   46F9 FE 03         [ 7]  971 		cp #3
   46FB 28 0A         [12]  972 		jr z, goto_state_41
                            973 			;; GO TO 6
   46FD DD 7E 14      [19]  974 			ld a, Ent_state(ix)	;;
   4700 DD 77 15      [19]  975 			ld Ent_lastState(ix), a	;; LastState <= current state
   4703 DD 36 14 06   [19]  976 			ld Ent_state(ix), #6	;; Next state <= 6
   4707                     977 		goto_state_41:
   4707 DD 7E 14      [19]  978 		ld a, Ent_state(ix)	;;
   470A DD 77 15      [19]  979 		ld Ent_lastState(ix), a	;; LastState <= current state
   470D DD 36 14 29   [19]  980 		ld Ent_state(ix), #41	;; Next state <= 41
                            981 
   4711 3E 01         [ 7]  982 		ld a, #1		;; A <= Update physics
   4713 C9            [10]  983 		ret
   4714                     984 	stepUpLeft2_else:
                            985 	;; else
   4714 DD 7E 14      [19]  986 	ld a, Ent_state(ix)	;;
   4717 DD 77 15      [19]  987 	ld Ent_lastState(ix), a	;; LastState <= current state
   471A DD 36 14 00   [19]  988 	ld Ent_state(ix), #0	;; Next state <= 0
   471E 3E 01         [ 7]  989 	ld a, #1		;; A <= Update physics
   4720 C9            [10]  990 	ret
                            991 
                            992 
                            993 ;; ======================================
                            994 ;; 	Step UpLeft 3 State #41
                            995 ;; Entrada:  IX <= Pointer to player data
                            996 ;; Devuelve: A <= Not Update/Update
                            997 ;; ======================================
   4721                     998 stepUpLeft3_state:
   4721 DD 36 17 11   [19]  999 	ld Ent_sprite(ix), #17		;; Next sprite <= 17
   4725 DD 7E 16      [19] 1000 	ld	a, Ent_signal(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 29.
Hexadecimal [16-Bits]



   4728 FE 06         [ 7] 1001 	cp	#6
   472A 20 0D         [12] 1002 	jr 	nz, stepUpLeft3_else
                           1003 		;; Move UpLeft
   472C DD 7E 14      [19] 1004 		ld a, Ent_state(ix)	;;
   472F DD 77 15      [19] 1005 		ld Ent_lastState(ix), a	;; LastState <= current state
   4732 DD 36 14 28   [19] 1006 		ld Ent_state(ix), #40	;; Next state <= 40
                           1007 
   4736 3E 01         [ 7] 1008 		ld a, #1		;; A <= Update physics
   4738 C9            [10] 1009 		ret
   4739                    1010 	stepUpLeft3_else:
                           1011 	;; else
   4739 DD 7E 14      [19] 1012 	ld a, Ent_state(ix)	;;
   473C DD 77 15      [19] 1013 	ld Ent_lastState(ix), a	;; LastState <= current state
   473F DD 36 14 00   [19] 1014 	ld Ent_state(ix), #0	;; Next state <= 0
   4743 3E 01         [ 7] 1015 	ld a, #1		;; A <= Update physics
   4745 C9            [10] 1016 	ret
                           1017 
                           1018 
                           1019 
                           1020 ;; =======================================
                           1021 ;; =======================================
                           1022 ;; == 	    MOVE DOWN RIGHT STATES	==
                           1023 ;; =======================================
                           1024 ;; =======================================
                           1025 
                           1026 ;; ======================================
                           1027 ;; 	Step DownRight 1 State #7
                           1028 ;; Entrada:  IX <= Pointer to player data
                           1029 ;; Devuelve: A <= Not Update/Update
                           1030 ;; ======================================
   4746                    1031 stepDownRight1_state:
   4746 DD 36 17 12   [19] 1032 	ld Ent_sprite(ix), #18		;; Next sprite <= 18
   474A DD 7E 16      [19] 1033 	ld	a, Ent_signal(ix)
   474D FE 07         [ 7] 1034 	cp	#7
   474F 20 0D         [12] 1035 	jr 	nz, stepDownRight1_else
                           1036 		;; Move DownRight
   4751 DD 7E 14      [19] 1037 		ld a, Ent_state(ix)	;;
   4754 DD 77 15      [19] 1038 		ld Ent_lastState(ix), a	;; LastState <= current state
   4757 DD 36 14 2A   [19] 1039 		ld Ent_state(ix), #42	;; Next state <= 42
                           1040 
   475B 3E 01         [ 7] 1041 		ld a, #1		;; A <= Update physics
   475D C9            [10] 1042 		ret
   475E                    1043 	stepDownRight1_else:
                           1044 	;; else
   475E DD 7E 14      [19] 1045 	ld a, Ent_state(ix)	;;
   4761 DD 77 15      [19] 1046 	ld Ent_lastState(ix), a	;; LastState <= current state
   4764 DD 36 14 00   [19] 1047 	ld Ent_state(ix), #0	;; Next state <= 0
   4768 3E 01         [ 7] 1048 	ld a, #1		;; A <= Update physics
   476A C9            [10] 1049 	ret
                           1050 
                           1051 
                           1052 ;; ======================================
                           1053 ;; 	Step DownRight 2 State #42
                           1054 ;; Entrada:  IX <= Pointer to player data
                           1055 ;; Devuelve: A <= Not Update/Update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 30.
Hexadecimal [16-Bits]



                           1056 ;; ======================================
   476B                    1057 stepDownRight2_state:
   476B DD 36 17 13   [19] 1058 	ld Ent_sprite(ix), #19			;; Next sprite <= 19
   476F DD 7E 16      [19] 1059 	ld	a, Ent_signal(ix)
   4772 FE 07         [ 7] 1060 	cp	#7
   4774 20 1E         [12] 1061 	jr 	nz, stepDownRight2_else
                           1062 		;; Move DownRight
   4776 DD 7E 15      [19] 1063 		ld a, Ent_lastState(ix)
   4779 FE 03         [ 7] 1064 		cp #3
   477B 28 0A         [12] 1065 		jr z, goto_state_43
                           1066 			;; GO TO 7
   477D DD 7E 14      [19] 1067 			ld a, Ent_state(ix)	;;
   4780 DD 77 15      [19] 1068 			ld Ent_lastState(ix), a	;; LastState <= current state
   4783 DD 36 14 07   [19] 1069 			ld Ent_state(ix), #7	;; Next state <= 7
   4787                    1070 		goto_state_43:
   4787 DD 7E 14      [19] 1071 		ld a, Ent_state(ix)	;;
   478A DD 77 15      [19] 1072 		ld Ent_lastState(ix), a	;; LastState <= current state
   478D DD 36 14 2B   [19] 1073 		ld Ent_state(ix), #43	;; Next state <= 43
                           1074 
   4791 3E 01         [ 7] 1075 		ld a, #1		;; A <= Update physics
   4793 C9            [10] 1076 		ret
   4794                    1077 	stepDownRight2_else:
                           1078 	;; else
   4794 DD 7E 14      [19] 1079 	ld a, Ent_state(ix)	;;
   4797 DD 77 15      [19] 1080 	ld Ent_lastState(ix), a	;; LastState <= current state
   479A DD 36 14 00   [19] 1081 	ld Ent_state(ix), #0	;; Next state <= 0
   479E 3E 01         [ 7] 1082 	ld a, #1		;; A <= Update physics
   47A0 C9            [10] 1083 	ret
                           1084 
                           1085 
                           1086 ;; ======================================
                           1087 ;; 	Step DownRight 3 State #43
                           1088 ;; Entrada:  IX <= Pointer to player data
                           1089 ;; Devuelve: A <= Not Update/Update
                           1090 ;; ======================================
   47A1                    1091 stepDownRight3_state:
   47A1 DD 36 17 14   [19] 1092 	ld Ent_sprite(ix), #20		;; Next sprite <= 20
   47A5 DD 7E 16      [19] 1093 	ld	a, Ent_signal(ix)
   47A8 FE 07         [ 7] 1094 	cp	#7
   47AA 20 0D         [12] 1095 	jr 	nz, stepDownRight3_else
                           1096 		;; Move DownRight
   47AC DD 7E 14      [19] 1097 		ld a, Ent_state(ix)	;;
   47AF DD 77 15      [19] 1098 		ld Ent_lastState(ix), a	;; LastState <= current state
   47B2 DD 36 14 2A   [19] 1099 		ld Ent_state(ix), #42	;; Next state <= 42
                           1100 
   47B6 3E 01         [ 7] 1101 		ld a, #1		;; A <= Update physics
   47B8 C9            [10] 1102 		ret
   47B9                    1103 	stepDownRight3_else:
                           1104 	;; else
   47B9 DD 7E 14      [19] 1105 	ld a, Ent_state(ix)	;;
   47BC DD 77 15      [19] 1106 	ld Ent_lastState(ix), a	;; LastState <= current state
   47BF DD 36 14 00   [19] 1107 	ld Ent_state(ix), #0	;; Next state <= 0
   47C3 3E 01         [ 7] 1108 	ld a, #1		;; A <= Update physics
   47C5 C9            [10] 1109 	ret
                           1110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 31.
Hexadecimal [16-Bits]



                           1111 
                           1112 
                           1113 
                           1114 ;; =======================================
                           1115 ;; =======================================
                           1116 ;; == 	    MOVE DOWN LEFT STATES	==
                           1117 ;; =======================================
                           1118 ;; =======================================
                           1119 
                           1120 ;; ======================================
                           1121 ;; 	Step DownLeft 1 State #8
                           1122 ;; Entrada:  IX <= Pointer to player data
                           1123 ;; Devuelve: A <= Not Update/Update
                           1124 ;; ======================================
   47C6                    1125 stepDownLeft1_state:
   47C6 DD 36 17 15   [19] 1126 	ld Ent_sprite(ix), #21		;; Next sprite <= 21
   47CA DD 7E 16      [19] 1127 	ld	a, Ent_signal(ix)
   47CD FE 08         [ 7] 1128 	cp	#8
   47CF 20 0D         [12] 1129 	jr 	nz, stepDownLeft1_else
                           1130 		;; Move DownLeft
   47D1 DD 7E 14      [19] 1131 		ld a, Ent_state(ix)	;;
   47D4 DD 77 15      [19] 1132 		ld Ent_lastState(ix), a	;; LastState <= current state
   47D7 DD 36 14 2C   [19] 1133 		ld Ent_state(ix), #44	;; Next state <= 44
                           1134 
   47DB 3E 01         [ 7] 1135 		ld a, #1		;; A <= Update physics
   47DD C9            [10] 1136 		ret
   47DE                    1137 	stepDownLeft1_else:
                           1138 	;; else
   47DE DD 7E 14      [19] 1139 	ld a, Ent_state(ix)	;;
   47E1 DD 77 15      [19] 1140 	ld Ent_lastState(ix), a	;; LastState <= current state
   47E4 DD 36 14 00   [19] 1141 	ld Ent_state(ix), #0	;; Next state <= 0
   47E8 3E 01         [ 7] 1142 	ld a, #1		;; A <= Update physics
   47EA C9            [10] 1143 	ret
                           1144 
                           1145 
                           1146 ;; ======================================
                           1147 ;; 	Step DownLeft 2 State #44
                           1148 ;; Entrada:  IX <= Pointer to player data
                           1149 ;; Devuelve: A <= Not Update/Update
                           1150 ;; ======================================
   47EB                    1151 stepDownLeft2_state:
   47EB DD 36 17 16   [19] 1152 	ld Ent_sprite(ix), #22			;; Next sprite <= 22
   47EF DD 7E 16      [19] 1153 	ld	a, Ent_signal(ix)
   47F2 FE 08         [ 7] 1154 	cp	#8
   47F4 20 1E         [12] 1155 	jr 	nz, stepDownLeft2_else
                           1156 		;; Move DownLeft
   47F6 DD 7E 15      [19] 1157 		ld a, Ent_lastState(ix)
   47F9 FE 03         [ 7] 1158 		cp #3
   47FB 28 0A         [12] 1159 		jr z, goto_state_45
                           1160 			;; GO TO 8
   47FD DD 7E 14      [19] 1161 			ld a, Ent_state(ix)	;;
   4800 DD 77 15      [19] 1162 			ld Ent_lastState(ix), a	;; LastState <= current state
   4803 DD 36 14 08   [19] 1163 			ld Ent_state(ix), #8	;; Next state <= 8
   4807                    1164 		goto_state_45:
   4807 DD 7E 14      [19] 1165 		ld a, Ent_state(ix)	;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 32.
Hexadecimal [16-Bits]



   480A DD 77 15      [19] 1166 		ld Ent_lastState(ix), a	;; LastState <= current state
   480D DD 36 14 2D   [19] 1167 		ld Ent_state(ix), #45	;; Next state <= 45
                           1168 
   4811 3E 01         [ 7] 1169 		ld a, #1		;; A <= Update physics
   4813 C9            [10] 1170 		ret
   4814                    1171 	stepDownLeft2_else:
                           1172 	;; else
   4814 DD 7E 14      [19] 1173 	ld a, Ent_state(ix)	;;
   4817 DD 77 15      [19] 1174 	ld Ent_lastState(ix), a	;; LastState <= current state
   481A DD 36 14 00   [19] 1175 	ld Ent_state(ix), #0	;; Next state <= 0
   481E 3E 01         [ 7] 1176 	ld a, #1		;; A <= Update physics
   4820 C9            [10] 1177 	ret
                           1178 
                           1179 
                           1180 ;; ======================================
                           1181 ;; 	Step DownLeft 3 State #45
                           1182 ;; Entrada:  IX <= Pointer to player data
                           1183 ;; Devuelve: A <= Not Update/Update
                           1184 ;; ======================================
   4821                    1185 stepDownLeft3_state:
   4821 DD 36 17 17   [19] 1186 	ld Ent_sprite(ix), #23		;; Next sprite <= 23
   4825 DD 7E 16      [19] 1187 	ld	a, Ent_signal(ix)
   4828 FE 08         [ 7] 1188 	cp	#8
   482A 20 0D         [12] 1189 	jr 	nz, stepDownLeft3_else
                           1190 		;; Move DownLeft
   482C DD 7E 14      [19] 1191 		ld a, Ent_state(ix)	;;
   482F DD 77 15      [19] 1192 		ld Ent_lastState(ix), a	;; LastState <= current state
   4832 DD 36 14 2C   [19] 1193 		ld Ent_state(ix), #44	;; Next state <= 44
                           1194 
   4836 3E 01         [ 7] 1195 		ld a, #1		;; A <= Update physics
   4838 C9            [10] 1196 		ret
   4839                    1197 	stepDownLeft3_else:
                           1198 	;; else
   4839 DD 7E 14      [19] 1199 	ld a, Ent_state(ix)	;;
   483C DD 77 15      [19] 1200 	ld Ent_lastState(ix), a	;; LastState <= current state
   483F DD 36 14 00   [19] 1201 	ld Ent_state(ix), #0	;; Next state <= 0
   4843 3E 01         [ 7] 1202 	ld a, #1		;; A <= Update physics
   4845 C9            [10] 1203 	ret
                           1204 
                           1205 
                           1206 
                           1207 ;; =======================================
                           1208 ;; =======================================
                           1209 ;; == 	    THROW DOWN STATES		==
                           1210 ;; =======================================
                           1211 ;; =======================================
                           1212 
                           1213 ;; ======================================
                           1214 ;; 	Throw Down 1 State #9
                           1215 ;; Entrada:  IX <= Pointer to player data
                           1216 ;; Devuelve: A <= Not Update/Update
                           1217 ;; ======================================
   4846                    1218 throwDown1_state:
   4846 DD 36 17 18   [19] 1219 	ld Ent_sprite(ix), #24	;; Next sprite <= 24
   484A DD 7E 14      [19] 1220 	ld a, Ent_state(ix)	;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 33.
Hexadecimal [16-Bits]



   484D DD 77 15      [19] 1221 	ld Ent_lastState(ix), a	;; LastState <= current state
   4850 DD 36 14 0A   [19] 1222 	ld Ent_state(ix), #10	;; Next state <= 10
                           1223 
   4854 3E 00         [ 7] 1224 	ld a, #0		;; A <= Not update physics
   4856 C9            [10] 1225 	ret
                           1226 
                           1227 ;; ======================================
                           1228 ;; 	Throw Down 2 State #10
                           1229 ;; Entrada:  IX <= Pointer to player data
                           1230 ;; Devuelve: A <= Not Update/Update
                           1231 ;; ======================================
   4857                    1232 throwDown2_state:
   4857 DD 36 17 19   [19] 1233 	ld Ent_sprite(ix), #25	;; Next sprite <= 25
   485B DD 7E 14      [19] 1234 	ld a, Ent_state(ix)	;;
   485E DD 77 15      [19] 1235 	ld Ent_lastState(ix), a	;; LastState <= current state
   4861 DD 36 14 0B   [19] 1236 	ld Ent_state(ix), #11	;; Next state <= 11
                           1237 
   4865 3E 00         [ 7] 1238 	ld a, #0		;; A <= Not update physics
   4867 C9            [10] 1239 	ret
                           1240 
                           1241 ;; ======================================
                           1242 ;; 	Throw Down 3 State #11
                           1243 ;; Entrada:  IX <= Pointer to player data
                           1244 ;; Devuelve: A <= Not Update/Update
                           1245 ;; ======================================
   4868                    1246 throwDown3_state:
   4868 DD 36 17 1A   [19] 1247 	ld Ent_sprite(ix), #26	;; Next sprite <= 26
   486C DD 7E 14      [19] 1248 	ld a, Ent_state(ix)	;;
   486F DD 77 15      [19] 1249 	ld Ent_lastState(ix), a	;; LastState <= current state
   4872 DD 36 14 0C   [19] 1250 	ld Ent_state(ix), #12	;; Next state <= 12
                           1251 
   4876 3E 00         [ 7] 1252 	ld a, #0		;; A <= Not update physics
   4878 C9            [10] 1253 	ret
                           1254 
                           1255 ;; ======================================
                           1256 ;; 	Throw Down 4 State #12
                           1257 ;; Entrada:  IX <= Pointer to player data
                           1258 ;; Devuelve: A <= Not Update/Update
                           1259 ;; ======================================
   4879                    1260 throwDown4_state:
   4879 DD 36 17 1B   [19] 1261 	ld Ent_sprite(ix), #27	;; Next sprite <= 27
   487D DD 7E 14      [19] 1262 	ld a, Ent_state(ix)	;;
   4880 DD 77 15      [19] 1263 	ld Ent_lastState(ix), a	;; LastState <= current state
   4883 DD 36 14 0D   [19] 1264 	ld Ent_state(ix), #13	;; Next state <= 13
                           1265 
   4887 3E 00         [ 7] 1266 	ld a, #0		;; A <= Not update physics
   4889 C9            [10] 1267 	ret
                           1268 
                           1269 ;; ======================================
                           1270 ;; 	Throw Down 5 State #13
                           1271 ;; Entrada:  IX <= Pointer to player data
                           1272 ;; Devuelve: A <= Not Update/Update
                           1273 ;; ======================================
   488A                    1274 throwDown5_state:
   488A DD 36 17 1C   [19] 1275 	ld Ent_sprite(ix), #28	;; Next sprite <= 28
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 34.
Hexadecimal [16-Bits]



   488E DD 7E 14      [19] 1276 	ld a, Ent_state(ix)	;;
   4891 DD 77 15      [19] 1277 	ld Ent_lastState(ix), a	;; LastState <= current state
   4894 DD 36 14 0E   [19] 1278 	ld Ent_state(ix), #14	;; Next state <= 14
                           1279 
   4898 3E 00         [ 7] 1280 	ld a, #0		;; A <= Not update physics
   489A C9            [10] 1281 	ret
                           1282 
                           1283 ;; ======================================
                           1284 ;; 	Throw Down 6 State #14
                           1285 ;; Entrada:  IX <= Pointer to player data
                           1286 ;; Devuelve: A <= Not Update/Update
                           1287 ;; ======================================
   489B                    1288 throwDown6_state:
   489B DD 36 17 1D   [19] 1289 	ld Ent_sprite(ix), #29	;; Next sprite <= 29
   489F DD 7E 14      [19] 1290 	ld a, Ent_state(ix)	;;
   48A2 DD 77 15      [19] 1291 	ld Ent_lastState(ix), a	;; LastState <= current state
   48A5 DD 36 14 0F   [19] 1292 	ld Ent_state(ix), #15	;; Next state <= 15
                           1293 
   48A9 3E 00         [ 7] 1294 	ld a, #0		;; A <= Not update physics
   48AB C9            [10] 1295 	ret
                           1296 
                           1297 ;; ======================================
                           1298 ;; 	Throw Down 7 State #15
                           1299 ;; Entrada:  IX <= Pointer to player data
                           1300 ;; Devuelve: A <= Not Update/Update
                           1301 ;; ======================================
   48AC                    1302 throwDown7_state:
   48AC DD 36 17 1E   [19] 1303 	ld Ent_sprite(ix), #30	;; Next sprite <= 30
   48B0 DD 7E 14      [19] 1304 	ld a, Ent_state(ix)	;;
   48B3 DD 77 15      [19] 1305 	ld Ent_lastState(ix), a	;; LastState <= current state
   48B6 DD 36 14 00   [19] 1306 	ld Ent_state(ix), #0	;; Next state <= 0
                           1307 
   48BA 3E 00         [ 7] 1308 	ld a, #0		;; A <= Not update physics
   48BC C9            [10] 1309 	ret
                           1310 
                           1311 
                           1312 
                           1313 ;; =======================================
                           1314 ;; =======================================
                           1315 ;; == 	    THROW UP STATES		==
                           1316 ;; =======================================
                           1317 ;; =======================================
                           1318 
                           1319 ;; ======================================
                           1320 ;; 	Throw Up 1 State #16
                           1321 ;; Entrada:  IX <= Pointer to player data
                           1322 ;; Devuelve: A <= Not Update/Update
                           1323 ;; ======================================
   48BD                    1324 throwUp1_state:
   48BD DD 36 17 18   [19] 1325 	ld Ent_sprite(ix), #24	;; Next sprite <= 24
   48C1 DD 7E 14      [19] 1326 	ld a, Ent_state(ix)	;;
   48C4 DD 77 15      [19] 1327 	ld Ent_lastState(ix), a	;; LastState <= current state
   48C7 DD 36 14 11   [19] 1328 	ld Ent_state(ix), #17	;; Next state <= 17
                           1329 
   48CB 3E 00         [ 7] 1330 	ld a, #0		;; A <= Not update physics
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 35.
Hexadecimal [16-Bits]



   48CD C9            [10] 1331 	ret
                           1332 
                           1333 ;; ======================================
                           1334 ;; 	Throw Up 2 State #17
                           1335 ;; Entrada:  IX <= Pointer to player data
                           1336 ;; Devuelve: A <= Not Update/Update
                           1337 ;; ======================================
   48CE                    1338 throwUp2_state:
   48CE DD 36 17 1F   [19] 1339 	ld Ent_sprite(ix), #31	;; Next sprite <= 31
   48D2 DD 7E 14      [19] 1340 	ld a, Ent_state(ix)	;;
   48D5 DD 77 15      [19] 1341 	ld Ent_lastState(ix), a	;; LastState <= current state
   48D8 DD 36 14 12   [19] 1342 	ld Ent_state(ix), #18	;; Next state <= 18
                           1343 
   48DC 3E 00         [ 7] 1344 	ld a, #0		;; A <= Not update physics
   48DE C9            [10] 1345 	ret
                           1346 
                           1347 ;; ======================================
                           1348 ;; 	Throw Up 3 State #18
                           1349 ;; Entrada:  IX <= Pointer to player data
                           1350 ;; Devuelve: A <= Not Update/Update
                           1351 ;; ======================================
   48DF                    1352 throwUp3_state:
   48DF DD 36 17 1E   [19] 1353 	ld Ent_sprite(ix), #30	;; Next sprite <= 30
   48E3 DD 7E 14      [19] 1354 	ld a, Ent_state(ix)	;;
   48E6 DD 77 15      [19] 1355 	ld Ent_lastState(ix), a	;; LastState <= current state
   48E9 DD 36 14 13   [19] 1356 	ld Ent_state(ix), #19	;; Next state <= 19
                           1357 
   48ED 3E 00         [ 7] 1358 	ld a, #0		;; A <= Not update physics
   48EF C9            [10] 1359 	ret
                           1360 
                           1361 ;; ======================================
                           1362 ;; 	Throw Up 4 State #19
                           1363 ;; Entrada:  IX <= Pointer to player data
                           1364 ;; Devuelve: A <= Not Update/Update
                           1365 ;; ======================================
   48F0                    1366 throwUp4_state:
   48F0 DD 36 17 1D   [19] 1367 	ld Ent_sprite(ix), #29	;; Next sprite <= 29
   48F4 DD 7E 14      [19] 1368 	ld a, Ent_state(ix)	;;
   48F7 DD 77 15      [19] 1369 	ld Ent_lastState(ix), a	;; LastState <= current state
   48FA DD 36 14 14   [19] 1370 	ld Ent_state(ix), #20	;; Next state <= 20
                           1371 
   48FE 3E 00         [ 7] 1372 	ld a, #0		;; A <= Not update physics
   4900 C9            [10] 1373 	ret
                           1374 
                           1375 ;; ======================================
                           1376 ;; 	Throw Up 5 State #20
                           1377 ;; Entrada:  IX <= Pointer to player data
                           1378 ;; Devuelve: A <= Not Update/Update
                           1379 ;; ======================================
   4901                    1380 throwUp5_state:
   4901 DD 36 17 1C   [19] 1381 	ld Ent_sprite(ix), #28	;; Next sprite <= 28
   4905 DD 7E 14      [19] 1382 	ld a, Ent_state(ix)	;;
   4908 DD 77 15      [19] 1383 	ld Ent_lastState(ix), a	;; LastState <= current state
   490B DD 36 14 15   [19] 1384 	ld Ent_state(ix), #21	;; Next state <= 21
                           1385 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 36.
Hexadecimal [16-Bits]



   490F 3E 00         [ 7] 1386 	ld a, #0		;; A <= Not update physics
   4911 C9            [10] 1387 	ret
                           1388 
                           1389 ;; ======================================
                           1390 ;; 	Throw Up 6 State #21
                           1391 ;; Entrada:  IX <= Pointer to player data
                           1392 ;; Devuelve: A <= Not Update/Update
                           1393 ;; ======================================
   4912                    1394 throwUp6_state:
   4912 DD 36 17 1B   [19] 1395 	ld Ent_sprite(ix), #27	;; Next sprite <= 27
   4916 DD 7E 14      [19] 1396 	ld a, Ent_state(ix)	;;
   4919 DD 77 15      [19] 1397 	ld Ent_lastState(ix), a	;; LastState <= current state
   491C DD 36 14 0F   [19] 1398 	ld Ent_state(ix), #15	;; Next state <= 15
                           1399 
   4920 3E 00         [ 7] 1400 	ld a, #0		;; A <= Not update physics
   4922 C9            [10] 1401 	ret
                           1402 
                           1403 ;; ======================================
                           1404 ;; 	Throw Up 7 State #22
                           1405 ;; Entrada:  IX <= Pointer to player data
                           1406 ;; Devuelve: A <= Not Update/Update
                           1407 ;; ======================================
   4923                    1408 throwUp7_state:
   4923 DD 36 17 1A   [19] 1409 	ld Ent_sprite(ix), #26	;; Next sprite <= 26
   4927 DD 7E 14      [19] 1410 	ld a, Ent_state(ix)	;;
   492A DD 77 15      [19] 1411 	ld Ent_lastState(ix), a	;; LastState <= current state
   492D DD 36 14 00   [19] 1412 	ld Ent_state(ix), #0	;; Next state <= 0
                           1413 
   4931 3E 00         [ 7] 1414 	ld a, #0		;; A <= Not update physics
   4933 C9            [10] 1415 	ret
                           1416 
                           1417 
                           1418 
                           1419 ;; =======================================
                           1420 ;; =======================================
                           1421 ;; == 	    THROW STRAIGHT STATES	==
                           1422 ;; =======================================
                           1423 ;; =======================================
                           1424 
                           1425 ;; ======================================
                           1426 ;; 	Throw Straight 1 State #23
                           1427 ;; Entrada:  IX <= Pointer to player data
                           1428 ;; Devuelve: A <= Not Update/Update
                           1429 ;; ======================================
   4934                    1430 throwStraight1_state:
   4934 DD 36 17 18   [19] 1431 	ld Ent_sprite(ix), #24	;; Next sprite <= 24
   4938 DD 7E 14      [19] 1432 	ld a, Ent_state(ix)	;;
   493B DD 77 15      [19] 1433 	ld Ent_lastState(ix), a	;; LastState <= current state
   493E DD 36 14 18   [19] 1434 	ld Ent_state(ix), #24	;; Next state <= 24
                           1435 
   4942 3E 00         [ 7] 1436 	ld a, #0		;; A <= Not update physics
   4944 C9            [10] 1437 	ret
                           1438 
                           1439 ;; ======================================
                           1440 ;; 	Throw Straight 2 State #24
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 37.
Hexadecimal [16-Bits]



                           1441 ;; Entrada:  IX <= Pointer to player data
                           1442 ;; Devuelve: A <= Not Update/Update
                           1443 ;; ======================================
   4945                    1444 throwStraight2_state:
   4945 DD 36 17 1F   [19] 1445 	ld Ent_sprite(ix), #31	;; Next sprite <= 31
   4949 DD 7E 14      [19] 1446 	ld a, Ent_state(ix)	;;
   494C DD 77 15      [19] 1447 	ld Ent_lastState(ix), a	;; LastState <= current state
   494F DD 36 14 19   [19] 1448 	ld Ent_state(ix), #25	;; Next state <= 25
                           1449 
   4953 3E 00         [ 7] 1450 	ld a, #0		;; A <= Not update physics
   4955 C9            [10] 1451 	ret
                           1452 
                           1453 ;; ======================================
                           1454 ;; 	Throw Straight 3 State #25
                           1455 ;; Entrada:  IX <= Pointer to player data
                           1456 ;; Devuelve: A <= Not Update/Update
                           1457 ;; ======================================
   4956                    1458 throwStraight3_state:
   4956 DD 36 17 1E   [19] 1459 	ld Ent_sprite(ix), #30	;; Next sprite <= 30
   495A DD 7E 14      [19] 1460 	ld a, Ent_state(ix)	;;
   495D DD 77 15      [19] 1461 	ld Ent_lastState(ix), a	;; LastState <= current state
   4960 DD 36 14 1A   [19] 1462 	ld Ent_state(ix), #26	;; Next state <= 26
                           1463 
   4964 3E 00         [ 7] 1464 	ld a, #0		;; A <= Not update physics
   4966 C9            [10] 1465 	ret
                           1466 
                           1467 ;; ======================================
                           1468 ;; 	Throw Straight 4 State #26
                           1469 ;; Entrada:  IX <= Pointer to player data
                           1470 ;; Devuelve: A <= Not Update/Update
                           1471 ;; ======================================
   4967                    1472 throwStraight4_state:
   4967 DD 36 17 1D   [19] 1473 	ld Ent_sprite(ix), #29	;; Next sprite <= 29
   496B DD 7E 14      [19] 1474 	ld a, Ent_state(ix)	;;
   496E DD 77 15      [19] 1475 	ld Ent_lastState(ix), a	;; LastState <= current state
   4971 DD 36 14 1B   [19] 1476 	ld Ent_state(ix), #27	;; Next state <= 27
                           1477 
   4975 3E 00         [ 7] 1478 	ld a, #0		;; A <= Not update physics
   4977 C9            [10] 1479 	ret
                           1480 
                           1481 ;; ======================================
                           1482 ;; 	Throw Straight 5 State #27
                           1483 ;; Entrada:  IX <= Pointer to player data
                           1484 ;; Devuelve: A <= Not Update/Update
                           1485 ;; ======================================
   4978                    1486 throwStraight5_state:
   4978 DD 36 17 1C   [19] 1487 	ld Ent_sprite(ix), #28	;; Next sprite <= 28
   497C DD 7E 14      [19] 1488 	ld a, Ent_state(ix)	;;
   497F DD 77 15      [19] 1489 	ld Ent_lastState(ix), a	;; LastState <= current state
   4982 DD 36 14 1C   [19] 1490 	ld Ent_state(ix), #28	;; Next state <= 28
                           1491 
   4986 3E 00         [ 7] 1492 	ld a, #0		;; A <= Not update physics
   4988 C9            [10] 1493 	ret
                           1494 
                           1495 ;; ======================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 38.
Hexadecimal [16-Bits]



                           1496 ;; 	Throw Straight 6 State #28
                           1497 ;; Entrada:  IX <= Pointer to player data
                           1498 ;; Devuelve: A <= Not Update/Update
                           1499 ;; ======================================
   4989                    1500 throwStraight6_state:
   4989 DD 36 17 1D   [19] 1501 	ld Ent_sprite(ix), #29	;; Next sprite <= 29
   498D DD 7E 14      [19] 1502 	ld a, Ent_state(ix)	;;
   4990 DD 77 15      [19] 1503 	ld Ent_lastState(ix), a	;; LastState <= current state
   4993 DD 36 14 1D   [19] 1504 	ld Ent_state(ix), #29	;; Next state <= 29
                           1505 
   4997 3E 00         [ 7] 1506 	ld a, #0		;; A <= Not update physics
   4999 C9            [10] 1507 	ret
                           1508 
                           1509 ;; ======================================
                           1510 ;; 	Throw Straight 7 State #29
                           1511 ;; Entrada:  IX <= Pointer to player data
                           1512 ;; Devuelve: A <= Not Update/Update
                           1513 ;; ======================================
   499A                    1514 throwStraight7_state:
   499A DD 36 17 1E   [19] 1515 	ld Ent_sprite(ix), #30	;; Next sprite <= 30
   499E DD 7E 14      [19] 1516 	ld a, Ent_state(ix)	;;
   49A1 DD 77 15      [19] 1517 	ld Ent_lastState(ix), a	;; LastState <= current state
   49A4 DD 36 14 00   [19] 1518 	ld Ent_state(ix), #0	;; Next state <= 0
                           1519 
   49A8 3E 00         [ 7] 1520 	ld a, #0		;; A <= Not update physics
   49AA C9            [10] 1521 	ret
                           1522 
                           1523 
                           1524 ;; =========================================
                           1525 ;; Invierte los datos para poder operarlos
                           1526 ;;	en C
                           1527 ;; Entrada:
                           1528 ;;	IX <= Pointer to entity data
                           1529 ;;	Modifica: BC
                           1530 ;; =========================================
   49AB                    1531 invert_variables:
                           1532 	;; Inverts X
   49AB DD 46 00      [19] 1533 	ld	b,	Ent_x_I(ix)
   49AE DD 4E 01      [19] 1534 	ld	c,	Ent_x_F(ix)
   49B1 DD 71 00      [19] 1535 	ld	Ent_x_I(ix), c
   49B4 DD 70 01      [19] 1536 	ld	Ent_x_F(ix), b
                           1537 
                           1538 	;; Inverts Y
   49B7 DD 46 02      [19] 1539 	ld	b,	Ent_y_I(ix)
   49BA DD 4E 03      [19] 1540 	ld	c,	Ent_y_F(ix)
   49BD DD 71 02      [19] 1541 	ld	Ent_y_I(ix), c
   49C0 DD 70 03      [19] 1542 	ld	Ent_y_F(ix), b
                           1543 
                           1544 	;; Inverts AX
   49C3 DD 46 0A      [19] 1545 	ld	b, Ent_ax_I(ix)		 
   49C6 DD 4E 0B      [19] 1546 	ld	c, Ent_ax_F(ix)		 
   49C9 DD 71 0A      [19] 1547 	ld	Ent_ax_I(ix), c		 
   49CC DD 70 0B      [19] 1548 	ld	Ent_ax_F(ix), b		
                           1549 
                           1550 	;; Inverts AY
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 39.
Hexadecimal [16-Bits]



   49CF DD 46 0C      [19] 1551 	ld	b, Ent_ay_I(ix)		 
   49D2 DD 4E 0D      [19] 1552 	ld	c, Ent_ay_F(ix)		 
   49D5 DD 71 0C      [19] 1553 	ld	Ent_ay_I(ix), c		 
   49D8 DD 70 0D      [19] 1554 	ld	Ent_ay_F(ix), b		
                           1555 
                           1556 	;; FALTARIA EFECTO, CUIDAO
                           1557 
   49DB C9            [10] 1558 	ret
                           1559 
   49DC                    1560 move_IA:
                           1561 
   49DC DD 21 62 40   [14] 1562 	ld	ix, #frisbee_data
   49E0 DD E5         [15] 1563 	push 	ix
   49E2 CD AB 49      [17] 1564 	call 	invert_variables
   49E5 DD 21 5F 4D   [14] 1565 	ld	ix, #player_data
   49E9 DD E5         [15] 1566 	push 	ix
   49EB CD AB 49      [17] 1567 	call 	invert_variables
   49EE DD 21 7A 4D   [14] 1568 	ld	ix, #enemy_data
   49F2 DD E5         [15] 1569 	push 	ix
   49F4 CD AB 49      [17] 1570 	call 	invert_variables
   49F7 CD 8D 3D      [17] 1571 	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
                           1572 	
   49FA DD E1         [14] 1573 	pop 	ix
   49FC DD E1         [14] 1574 	pop 	ix
   49FE DD E1         [14] 1575 	pop 	ix
                           1576 
   4A00 DD 21 62 40   [14] 1577 	ld	ix, #frisbee_data
   4A04 CD AB 49      [17] 1578 	call 	invert_variables
   4A07 DD 21 5F 4D   [14] 1579 	ld	ix, #player_data
   4A0B CD AB 49      [17] 1580 	call 	invert_variables
   4A0E DD 21 7A 4D   [14] 1581 	ld	ix, #enemy_data
   4A12 CD AB 49      [17] 1582 	call 	invert_variables
                           1583 
                           1584 
   4A15 C9            [10] 1585 	ret
                           1586 	
                           1587 ;; =========================================
                           1588 ;; Comprueba si la entidad colisiona con 
                           1589 ;; 	el frisbee
                           1590 ;; Entrada:
                           1591 ;; 	IX <= puntero al player a comparar
                           1592 ;; 		con el frisbee
                           1593 ;; Modifica: AF, B, HL, IX
                           1594 ;; Devuelve:
                           1595 ;; 	A <= 	0 si no hay colisión
                           1596 ;; 		>1 si hay colisión
                           1597 ;; =========================================
   4A16                    1598 checkFrisbeeCollision:
   4A16 21 62 40      [10] 1599 	ld 	hl, #frisbee_data	;; HL <= frisbee_data
   4A19 CD 60 3F      [17] 1600 	call 	entityCheckCollision 	;; A <= collison/no_collision
                           1601 
   4A1C C9            [10] 1602 	ret
                           1603 
                           1604 
                           1605 ;; ===============================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 40.
Hexadecimal [16-Bits]



                           1606 ;; Acelera la entidad hacia la derecha, si puede
                           1607 ;; Entrada:
                           1608 ;; 	IX <= puntero a los datos de la entidad
                           1609 ;; Modifica A, IX
                           1610 ;; ===============================================
   4A1D                    1611 moveRight:
   4A1D DD 36 0A 00   [19] 1612 	ld 	Ent_ax_I(ix), #0
   4A21 DD 36 0B 20   [19] 1613 	ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
   4A25 C9            [10] 1614 	ret
                           1615 
                           1616 ;; ===============================================
                           1617 ;; Acelera la entidad hacia abajo, si puede
                           1618 ;; Entrada:
                           1619 ;; 	IX <= puntero a los datos de la entidad
                           1620 ;; Modifica A, IX
                           1621 ;; ===============================================
   4A26                    1622 moveDown:
   4A26 DD 36 0C 00   [19] 1623 	ld 	Ent_ay_I(ix), #0
   4A2A DD 36 0D 20   [19] 1624 	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
                           1625 
   4A2E C9            [10] 1626 	ret
                           1627 
                           1628 ;; ===============================================
                           1629 ;; Acelera la entidad hacia la izquierda, si puede
                           1630 ;; Entrada:
                           1631 ;; 	IX <= puntero a los datos de la entidad
                           1632 ;; Modifica A, IX
                           1633 ;; ===============================================
   4A2F                    1634 moveLeft:
   4A2F DD 36 0A FF   [19] 1635 	ld 	Ent_ax_I(ix), #-1
   4A33 DD 36 0B E0   [19] 1636 	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)
                           1637 
   4A37 C9            [10] 1638 	ret
                           1639 
                           1640 ;; ===============================================
                           1641 ;; Acelera la entidad hacia arriba, si puede
                           1642 ;; Entrada:
                           1643 ;; 	IX <= puntero a los datos de la entidad
                           1644 ;; Modifica A, IX
                           1645 ;; ===============================================
   4A38                    1646 moveUp:
   4A38 DD 36 0C FF   [19] 1647 	ld 	Ent_ay_I(ix), #-1
   4A3C DD 36 0D E0   [19] 1648 	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)
                           1649 
   4A40 C9            [10] 1650 	ret
                           1651 
                           1652 
                           1653 ;; ===========================================
                           1654 ;; Chequea si un jugador pasa del centro del
                           1655 ;; 	campo y lo corrige en caso necesario
                           1656 ;; Entrada:
                           1657 ;; 	IX <= pointer to entity data
                           1658 ;; Modifica AF, BC, DE, HL
                           1659 ;; ===========================================
   4A41                    1660 checkCenterCrossing:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 41.
Hexadecimal [16-Bits]



   4A41 DD 7E 1A      [19] 1661 	ld 	a, Ent_id(ix)
   4A44 FE 01         [ 7] 1662 	cp 	#1
   4A46 28 11         [12] 1663 	jr	z, player_1
   4A48 FE 02         [ 7] 1664 		cp	#2
   4A4A 20 1F         [12] 1665 		jr	nz, invalid_id
                           1666 			;; player 2
   4A4C 3E 28         [ 7] 1667 			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
   4A4E DD BE 00      [19] 1668 			cp	Ent_x_I(ix)
   4A51 38 18         [12] 1669 			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
                           1670 				;; center limit crossed
   4A53 DD 36 00 28   [19] 1671 				ld	Ent_x_I(ix), #CENTER_LIMIT
   4A57 18 12         [12] 1672 				jr not_crossed
                           1673 
   4A59                    1674 	player_1:
   4A59 DD 7E 00      [19] 1675 			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
   4A5C DD 86 05      [19] 1676 			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
   4A5F FE 28         [ 7] 1677 			cp	#CENTER_LIMIT
   4A61 38 08         [12] 1678 			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
                           1679 				;; center limit crossed
   4A63 3E 28         [ 7] 1680 				ld	a, #CENTER_LIMIT
   4A65 DD 96 05      [19] 1681 				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
   4A68 DD 77 00      [19] 1682 				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w
                           1683 
   4A6B                    1684 	invalid_id:
   4A6B                    1685 	not_crossed:
   4A6B C9            [10] 1686 	ret
                           1687 
                           1688 
                           1689 ;; ====================================
                           1690 ;; Lee la entrada del teclado
                           1691 ;; Entrada:
                           1692 ;; 	IX <= pointer to entity data
                           1693 ;; Modifica AF, BC, DE, HL, IX
                           1694 ;; ====================================
   4A6C                    1695 checkUserInput:
   4A6C CD 02 5D      [17] 1696 	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;
                           1697 
   4A6F DD 7E 1A      [19] 1698 	ld 	a, Ent_id(ix)
   4A72 FE 01         [ 7] 1699 	cp	#1
   4A74 C2 AD 4A      [10] 1700 	jp	nz, player_2
                           1701 		;; Player 1
   4A77 21 07 20      [10] 1702 		ld 	hl, #Key_D			;; HL = D Keycode
   4A7A CD BF 50      [17] 1703 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4A7D FE 00         [ 7] 1704 		cp 	#0 				;; A == 0?
   4A7F 28 03         [12] 1705 		jr 	z, d_not_pressed
                           1706 			;; D is pressed
   4A81 CD 1D 4A      [17] 1707 			call 	moveRight	
   4A84                    1708 		d_not_pressed:
                           1709 
   4A84 21 08 20      [10] 1710 		ld 	hl, #Key_A			;; HL = A Keycode
   4A87 CD BF 50      [17] 1711 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4A8A FE 00         [ 7] 1712 		cp 	#0 				;; A == 0?
   4A8C 28 03         [12] 1713 		jr 	z, a_not_pressed
                           1714 			;; A is pressed	
   4A8E CD 2F 4A      [17] 1715 			call 	moveLeft
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 42.
Hexadecimal [16-Bits]



   4A91                    1716 		a_not_pressed:
                           1717 
   4A91 21 07 08      [10] 1718 		ld 	hl, #Key_W			;; HL = W Keycode
   4A94 CD BF 50      [17] 1719 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4A97 FE 00         [ 7] 1720 		cp 	#0 				;; A == 0?
   4A99 28 03         [12] 1721 		jr 	z, w_not_pressed
                           1722 			;; W is pressed
   4A9B CD 38 4A      [17] 1723 			call 	moveUp	
   4A9E                    1724 		w_not_pressed:
                           1725 
   4A9E 21 07 10      [10] 1726 		ld 	hl, #Key_S			;; HL = S Keycode
   4AA1 CD BF 50      [17] 1727 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4AA4 FE 00         [ 7] 1728 		cp 	#0 				;; A == 0?
   4AA6 28 03         [12] 1729 		jr 	z, s_not_pressed
                           1730 			;; S is pressed	
   4AA8 CD 26 4A      [17] 1731 			call 	moveDown
   4AAB                    1732 		s_not_pressed:
   4AAB 18 34         [12] 1733 		jr five_not_pressed
                           1734 
   4AAD                    1735 	player_2:
   4AAD 21 00 10      [10] 1736 		ld 	hl, #Key_F6			;; HL = F6 Keycode
   4AB0 CD BF 50      [17] 1737 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4AB3 FE 00         [ 7] 1738 		cp 	#0 				;; A == 0?
   4AB5 28 03         [12] 1739 		jr 	z, six_not_pressed
                           1740 			;; D is pressed
   4AB7 CD 1D 4A      [17] 1741 			call 	moveRight	
   4ABA                    1742 		six_not_pressed:
                           1743 
   4ABA 21 02 10      [10] 1744 		ld 	hl, #Key_F4			;; HL = F4 Keycode
   4ABD CD BF 50      [17] 1745 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4AC0 FE 00         [ 7] 1746 		cp 	#0 				;; A == 0?
   4AC2 28 03         [12] 1747 		jr 	z, four_not_pressed
                           1748 			;; A is pressed	
   4AC4 CD 2F 4A      [17] 1749 			call 	moveLeft
   4AC7                    1750 		four_not_pressed:
                           1751 
   4AC7 21 01 08      [10] 1752 		ld 	hl, #Key_F8			;; HL = F8 Keycode
   4ACA CD BF 50      [17] 1753 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4ACD FE 00         [ 7] 1754 		cp 	#0 				;; A == 0?
   4ACF 28 03         [12] 1755 		jr 	z, eight_not_pressed
                           1756 			;; W is pressed
   4AD1 CD 38 4A      [17] 1757 			call 	moveUp	
   4AD4                    1758 		eight_not_pressed:
                           1759 
   4AD4 21 01 10      [10] 1760 		ld 	hl, #Key_F5			;; HL = F5 Keycode
   4AD7 CD BF 50      [17] 1761 		call 	cpct_isKeyPressed_asm 		;; A = True/False
   4ADA FE 00         [ 7] 1762 		cp 	#0 				;; A == 0?
   4ADC 28 03         [12] 1763 		jr 	z, five_not_pressed
                           1764 			;; S is pressed	
   4ADE CD 26 4A      [17] 1765 			call 	moveDown
   4AE1                    1766 		five_not_pressed:
                           1767 
                           1768 
                           1769 
   4AE1 CD E5 4A      [17] 1770 	call checkVandB
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 43.
Hexadecimal [16-Bits]



   4AE4 C9            [10] 1771 	ret
                           1772 
                           1773 
                           1774 ;; ====================================
                           1775 ;; Funcion auxiliar para leer V y B
                           1776 ;;	de la entrada por teclado
                           1777 ;; Entrada:
                           1778 ;; 	IX <= pointer to entity data
                           1779 ;; Modifica AF, BC, DE, HL
                           1780 ;; ====================================
   4AE5                    1781 checkVandB:
   4AE5 DD E5         [15] 1782 	push 	ix
   4AE7 CD 16 4A      [17] 1783 	call 	checkFrisbeeCollision 	;; A == collision/no_collision
   4AEA DD E1         [14] 1784 	pop 	ix
   4AEC FE 00         [ 7] 1785 	cp 	#0			;; A == 0?
   4AEE CA 9A 4B      [10] 1786 	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
                           1787 		;; There is collision
                           1788 
   4AF1 DD 7E 1A      [19] 1789 		ld 	a, Ent_id(ix)
   4AF4 FE 01         [ 7] 1790 		cp	#1
   4AF6 20 54         [12] 1791 		jr	nz, player_2_vorb
                           1792 			;; Player 1
                           1793 
   4AF8 21 06 80      [10] 1794 			ld 	hl, #Key_V			;; HL = V Keycode
   4AFB CD BF 50      [17] 1795 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   4AFE FE 00         [ 7] 1796 			cp 	#0 				;; A == 0?
   4B00 28 22         [12] 1797 			jr 	z, v_not_pressed
                           1798 				;; V is pressed	
   4B02 21 06 40      [10] 1799 				ld 	hl, #Key_B			;; HL = B Keycode
   4B05 CD BF 50      [17] 1800 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   4B08 FE 00         [ 7] 1801 				cp 	#0 				;; A == 0?
   4B0A 28 0C         [12] 1802 				jr 	z, just_v_pressed
                           1803 					;; V and B are pressed
   4B0C 21 00 00      [10] 1804 					ld 	hl, #0			;; HL <= standard effect
   4B0F DD E5         [15] 1805 					push 	ix
   4B11 CD 04 41      [17] 1806 					call frisbee_setEffect		;; efecto hacia abajo
   4B14 DD E1         [14] 1807 					pop 	ix
   4B16 18 20         [12] 1808 					jr vorb_pressed
   4B18                    1809 				just_v_pressed:
   4B18 21 F8 FF      [10] 1810 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   4B1B DD E5         [15] 1811 					push 	ix
   4B1D CD 04 41      [17] 1812 					call frisbee_setEffect		;; efecto hacia arriba
   4B20 DD E1         [14] 1813 					pop 	ix
   4B22 18 14         [12] 1814 					jr 	vorb_pressed
   4B24                    1815 			v_not_pressed:
                           1816 
   4B24 21 06 40      [10] 1817 				ld 	hl, #Key_B			;; HL = B Keycode
   4B27 CD BF 50      [17] 1818 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   4B2A FE 00         [ 7] 1819 				cp 	#0 				;; A == 0?
   4B2C 28 6C         [12] 1820 				jr 	z, b_not_pressed
                           1821 					;; B is pressed
   4B2E 21 08 00      [10] 1822 					ld 	hl, #std_eff		;; HL <= standard effect
   4B31 DD E5         [15] 1823 					push 	ix
   4B33 CD 04 41      [17] 1824 					call frisbee_setEffect		;; efecto hacia abajo
   4B36 DD E1         [14] 1825 					pop 	ix
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 44.
Hexadecimal [16-Bits]



                           1826 
   4B38                    1827 					vorb_pressed:
   4B38 DD 7E 1A      [19] 1828 					ld	a, Ent_id(ix)		;;
   4B3B DD 66 06      [19] 1829 					ld	h, Ent_vx_I(ix)		;;
   4B3E DD 6E 07      [19] 1830 					ld	l, Ent_vx_F(ix)		;;
   4B41 DD 56 08      [19] 1831 					ld	d, Ent_vy_I(ix)		;;
   4B44 DD 5E 09      [19] 1832 					ld	e, Ent_vy_F(ix)		;;
   4B47 CD CD 40      [17] 1833 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                           1834 
   4B4A 18 4E         [12] 1835 					jr o_not_pressed
   4B4C                    1836 	player_2_vorb:
                           1837 
   4B4C 21 04 08      [10] 1838 			ld 	hl, #Key_I			;; HL = I Keycode
   4B4F CD BF 50      [17] 1839 			call 	cpct_isKeyPressed_asm 		;; A = True/False
   4B52 FE 00         [ 7] 1840 			cp 	#0 				;; A == 0?
   4B54 28 1E         [12] 1841 			jr 	z, i_not_pressed
                           1842 				;; I is pressed	
   4B56 21 04 04      [10] 1843 				ld 	hl, #Key_O			;; HL = O Keycode
   4B59 CD BF 50      [17] 1844 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   4B5C FE 00         [ 7] 1845 				cp 	#0 				;; A == 0?
   4B5E 28 08         [12] 1846 				jr 	z, just_i_pressed
                           1847 					;; I and O are pressed
   4B60 21 00 00      [10] 1848 					ld 	hl, #0			;; HL <= standard effect
   4B63 CD 04 41      [17] 1849 					call frisbee_setEffect		;; efecto hacia abajo
   4B66 18 20         [12] 1850 					jr ioro_pressed
   4B68                    1851 				just_i_pressed:
   4B68 21 F8 FF      [10] 1852 					ld 	hl, #std_N_eff		;; HL <= -standard effect
   4B6B DD E5         [15] 1853 					push 	ix
   4B6D CD 04 41      [17] 1854 					call frisbee_setEffect		;; efecto hacia arriba
   4B70 DD E1         [14] 1855 					pop 	ix
   4B72 18 14         [12] 1856 					jr 	ioro_pressed
   4B74                    1857 			i_not_pressed:
                           1858 
   4B74 21 04 04      [10] 1859 				ld 	hl, #Key_O			;; HL = O Keycode
   4B77 CD BF 50      [17] 1860 				call 	cpct_isKeyPressed_asm 		;; A = True/False
   4B7A FE 00         [ 7] 1861 				cp 	#0 				;; A == 0?
   4B7C 28 1C         [12] 1862 				jr 	z, o_not_pressed
                           1863 					;; O is pressed
   4B7E 21 08 00      [10] 1864 					ld 	hl, #std_eff		;; HL <= standard effect
   4B81 DD E5         [15] 1865 					push 	ix
   4B83 CD 04 41      [17] 1866 					call frisbee_setEffect		;; efecto hacia abajo
   4B86 DD E1         [14] 1867 					pop 	ix
                           1868 
   4B88                    1869 					ioro_pressed:
   4B88 DD 7E 1A      [19] 1870 					ld	a, Ent_id(ix)		;;
   4B8B DD 66 06      [19] 1871 					ld	h, Ent_vx_I(ix)		;;
   4B8E DD 6E 07      [19] 1872 					ld	l, Ent_vx_F(ix)		;;
   4B91 DD 56 08      [19] 1873 					ld	d, Ent_vy_I(ix)		;;
   4B94 DD 5E 09      [19] 1874 					ld	e, Ent_vy_F(ix)		;;
   4B97 CD CD 40      [17] 1875 					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee
                           1876 
                           1877 
   4B9A                    1878 	no_collision:
   4B9A                    1879 	b_not_pressed:
   4B9A                    1880 	o_not_pressed:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 45.
Hexadecimal [16-Bits]



   4B9A C9            [10] 1881 	ret
