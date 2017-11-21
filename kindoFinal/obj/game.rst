ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "player.h.s"
                              1 ;; =========================
                              2 ;; =========================
                              3 ;; PLAYER PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 .globl player_update
                              7 .globl update_player_animation
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "frisbee.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "utility.h.s"
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
                             23 .globl cpct_drawStringM1_f_asm
                             24 .globl cpct_akp_musicInit_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 .include "entity.h.s"
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
                             24 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             25 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             26 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             27 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 .include "sprites.h.s"
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
                             12 	
                             13 ;; ":"
                             14 .globl _sprite_points
                             15 ;; "0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
                             16 .globl _sprite_numbers_09
                             17 .globl _sprite_numbers_08
                             18 .globl _sprite_numbers_07
                             19 .globl _sprite_numbers_06
                             20 .globl _sprite_numbers_05
                             21 .globl _sprite_numbers_04
                             22 .globl _sprite_numbers_03
                             23 .globl _sprite_numbers_02
                             24 .globl _sprite_numbers_01
                             25 .globl _sprite_numbers_00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 	
                             10 ;; ====================================
                             11 ;; ====================================
                             12 ;; PUBLIC DATA
                             13 ;; ====================================
                             14 ;; ====================================
                             15 
   5FA6 4B                   16 paletteM2::	.db #0x4B	;; White
   5FA7 54                   17 			.db #0x54	;; Black
                             18 
   5FA8 4C                   19 paletteM1::	.db #0x4C	;; Red
   5FA9 40                   20 			.db #0x40	;; Grey
   5FAA 4B                   21 			.db #0x4B	;; White
   5FAB 54                   22 			.db #0x54	;; Black
                             23 
   5FAC 54                   24 blackPaletteM1::	.db #0x54	;; Black
   5FAD 54                   25 					.db #0x54	;; Black
   5FAE 54                   26 					.db #0x54	;; Black
   5FAF 54                   27 					.db #0x54	;; Black
                             28 
                             29 ;;paletteM0::	.db # ;; 
                             30 ;;			.db # ;; 
                             31 ;;			.db # ;; 
                             32 ;;			.db # ;; 
                             33 ;;			.db # ;; 
                             34 ;;			.db # ;; 
                             35 ;;			.db # ;; 
                             36 ;;			.db # ;; 
                             37 ;;			.db # ;; 
                             38 ;;			.db # ;; 
                             39 ;;			.db # ;; 
                             40 ;;			.db # ;; 
                             41 ;;			.db # ;; 
                             42 ;;			.db # ;;  
                             43 ;;			.db #0x4B ;; White
                             44 ;;			.db #0x54 ;; Black 
                             45 
                             46 
                     0003    47 number_w = 3
                     0007    48 number_h = 7
                     0006    49 .equ music_vel, #6
                             50 
                             51 ;;defineEntity name, 	x,				y,	 	 h,   w,  vx, 	vy, 	ax,    ay,    normal, 	sprites_ptr, 	 id
   5FB0                      52 defineEntity player, 	#0x0010, 		#0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, #1
   000A                       1 	player_data::
   5FB0 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   5FB2 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   5FB4 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   5FB5 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   5FB6 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5FB8 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5FBA 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5FBC 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5FBE 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5FC0 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5FC1 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   5FC2 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   5FC3 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   5FC4 00                   15 		player_state:	.db #0		;; Entity animation state	(8 bits)
   5FC5 00                   16 		player_lastState:.db #0		;; Last entity animation state	(8 bits)
   5FC6 FF                   17 		player_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5FC7 00                   18 		player_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5FC8 1C 4B                19 		player_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   5FCA 01                   20 		player_id:	.db #1		;; Numeric ID			(8 bits)
   5FCB                      53 defineEntity enemy, 	#0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, #2
   0025                       1 	enemy_data::
   5FCB 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5FCD 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   5FCF 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   5FD0 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   5FD1 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5FD3 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5FD5 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5FD7 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5FD9 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5FDB 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5FDC 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5FDD 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5FDE 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5FDF 00                   15 		enemy_state:	.db #0		;; Entity animation state	(8 bits)
   5FE0 00                   16 		enemy_lastState:.db #0		;; Last entity animation state	(8 bits)
   5FE1 FF                   17 		enemy_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5FE2 00                   18 		enemy_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5FE3 20 4B                19 		enemy_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   5FE5 02                   20 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             54 
   5FE6                      55 defineEntity player2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#3
   0040                       1 	player2_data::
   5FE6 4C 00                 2 		player2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5FE8 64 00                 3 		player2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   5FEA 14                    4 		player2_h:	.db #20		;; Height			(8 bits)
   5FEB 05                    5 		player2_w:	.db #5		;; Width			(8 bits)
   5FEC 00 00                 6 		player2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5FEE 00 00                 7 		player2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5FF0 00 00                 8 		player2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5FF2 00 00                 9 		player2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5FF4 00 18                10 		player2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5FF6 4C                   11 		player2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5FF7 4C                   12 		player2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5FF8 64                   13 		player2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5FF9 64                   14 		player2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5FFA 00                   15 		player2_state:	.db #0		;; Entity animation state	(8 bits)
   5FFB 00                   16 		player2_lastState:.db #0		;; Last entity animation state	(8 bits)
   5FFC FF                   17 		player2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5FFD 00                   18 		player2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5FFE 20 4B                19 		player2_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   6000 03                   20 		player2_id:	.db #3		;; Numeric ID			(8 bits)
   6001                      56 defineEntity enemy2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 	#4
   005B                       1 	enemy2_data::
   6001 4C 00                 2 		enemy2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   6003 64 00                 3 		enemy2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   6005 14                    4 		enemy2_h:	.db #20		;; Height			(8 bits)
   6006 05                    5 		enemy2_w:	.db #5		;; Width			(8 bits)
   6007 00 00                 6 		enemy2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   6009 00 00                 7 		enemy2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   600B 00 00                 8 		enemy2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   600D 00 00                 9 		enemy2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   600F 00 18                10 		enemy2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   6011 4C                   11 		enemy2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   6012 4C                   12 		enemy2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   6013 64                   13 		enemy2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   6014 64                   14 		enemy2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   6015 00                   15 		enemy2_state:	.db #0		;; Entity animation state	(8 bits)
   6016 00                   16 		enemy2_lastState:.db #0		;; Last entity animation state	(8 bits)
   6017 FF                   17 		enemy2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   6018 00                   18 		enemy2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   6019 1C 4B                19 		enemy2_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   601B 04                   20 		enemy2_id:	.db #4		;; Numeric ID			(8 bits)
                             57 
   601C                      58 game_data::
   601C 00                   59 	game_type::          .db #0 ;; Game Mode (8 bits)
   601D 00                   60    	game_numPlayers::    .db #0 ;; Players who are going to play
   601E 00                   61    	game_WinCondition::  .db #0 ;; Win condition 0-> Time, 1 -> Score
                             62 
   601F 15                   63 	game_maxScore::      .db #21 ;; Max score of a match (to win)
   6020 00                   64 	game_t1Score::       .db #0 ;; Points of team 1		(8 bits)
   6021 00                   65 	game_t2Score::       .db #0 ;; Points of team 2		(8 bits)
                             66 
   6022 02                   67 	game_minute::		.db #2 ;; Actual minute. Also Controles if we whant to play with time
   6023 00                   68 	game_secLeft::		.db #0 ;; Both variables to control the seconds
   6024 00                   69 	game_secRight::		.db #0 ;; Both variables to control the seconds
   6025 00 00                70 	game_maxTime::       .dw #0x0000 ;; Max time of a match
   6027 00 00                71 	game_map::           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             72 
   6029 00                   73 	game_musicOptions::  .db #0 ;; Controles if we whant to play music on options
   602A 00                   74 	game_timeOptions::   .db #0 ;; Controles if we whant to play with time on options
                             75 
   602B 06                   76 	game_interrMusic::   .db #music_vel ;; Interruption counter for music handler	(16 bits)
   602C 2C 01                77 	game_interrTime::	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
   602E 00                   78 	game_musicPlayer::   .db #0 ;; Controles the music player
   602F 00                   79 	game_musicEffects::  .db #0 ;; Controles the effects on the match
                             80 
   6030 01                   81 	game_enableMusic::	.db #1 ;; Controles if we whant some music
                             82 
                             83 	;; ÑORDBUGER 0f89
                             84 
                             85 	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
                             86 	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
                             87 	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
                             88 	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
                             89 ;; 
                             90 ;; .equ RIGHT_LIMIT,	80
                             91 ;; .equ LEFT_LIMIT,	0
                             92 ;; .equ TOP_LIMIT,	10
                             93 ;; .equ BOTTOM_LIMIT,	200
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             94 ;; .equ CENTER_LIMIT,	40
                             95 
                             96 
                             97 ;; ====================================
                             98 ;; ====================================
                             99 ;; PRIVATE DATA
                            100 ;; ====================================
                            101 ;; ====================================
                            102 
                            103 ;; .equ mi_constante0, 0
                            104 ;; .equ mi_constante1, 1
                            105 
                     E025   106 .equ minSpPointer, 0xE025		;; Pointer to know where to print the score, on both videopointers.
                     A025   107 .equ minSpPointer2, 0xA025
                     E029   108 .equ secLeftSpPointer, 0xE029
                     A029   109 .equ secLeftSpPointer2, 0xA029
                     E02C   110 .equ secRightSpPointer, 0xE02C
                     A02C   111 .equ secRightSpPointer2, 0xA02C
                            112 
   6031 00 80               113 videoPtr:	.dw 0x8000
                            114 
                            115 ;; ====================================
                            116 ;; ====================================
                            117 ;; PUBLIC FUNCTIONS
                            118 ;; ====================================
                            119 ;; ====================================
                            120 
                            121 
                            122 ;; ===================================
                            123 ;; Inicia una partida dependiendo
                            124 ;; 	de los atributos de game
                            125 ;; ===================================
   6033                     126 gameStart::
   6033 CD DE 61      [17]  127 	call 	initializeGame
                            128 	;; Prepartida
   6036 CD AD 61      [17]  129 	call 	configureISR
   6039 3A 1C 60      [13]  130 	ld a, (game_type)
   603C FE 00         [ 7]  131 	cp #0
   603E 20 05         [12]  132 	jr nz, game_PVP
   6040 CD 25 62      [17]  133 		call game_loop_Player_IA
   6043 18 03         [12]  134 		jr afterGame
                            135 
   6045                     136 	game_PVP:
   6045 CD AB 62      [17]  137 		call game_loop_Player_PvP
                            138 		;; call game_loop_PvP
                            139 
   6048                     140 	afterGame:
                            141 
   6048 21 7B 61      [10]  142 	ld hl, #emptyHandler	;; emptyHandler
   604B CD 31 63      [17]  143 	call cpct_setInterruptHandler_asm
                            144 
   604E 3A 21 60      [13]  145 	ld 	a, (game_t2Score)
   6051 47            [ 4]  146 	ld 	b, a
                            147 
   6052 3A 20 60      [13]  148 	ld 	a, (game_t1Score)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   6055 B8            [ 4]  149 	cp 	b
   6056 FA 59 60      [10]  150 	jp 	m, t2_win
                            151 		;; t1 win
                            152 
   6059                     153 	t2_win:
                            154 
                            155 
   6059 C9            [10]  156 	ret
                            157 
                            158 ;; ==================================
                            159 ;; Devuelve el puntero a video en HL
                            160 ;; Devuelve:
                            161 ;;	HL => Pointer to video memory
                            162 ;; ==================================
   605A                     163 getVideoPtr::
   605A 2A 31 60      [16]  164 	ld	hl, (videoPtr)
   605D C9            [10]  165 	ret
                            166 
                            167 ;; ==================================
                            168 ;; Incrementa los puntos del equipo 1
                            169 ;; Modifica: A, B
                            170 ;; ==================================
   605E                     171 incTeam1Points::
   605E 3A 1F 60      [13]  172 	ld	a, (game_maxScore)
   6061 47            [ 4]  173 	ld 	b, a				;; B <= Max points
                            174 
   6062 3A 20 60      [13]  175 	ld	a, (game_t1Score)
   6065 3C            [ 4]  176 	inc	a				;; A <= Team 1 points + 1
                            177 
   6066 32 20 60      [13]  178 	ld	(game_t1Score), a	;; Inc team 1 points
                            179 
   6069 C9            [10]  180 		ret
                            181 
                            182 ;; ================================== 
                            183 ;; Incrementa los puntos del equipo 2
                            184 ;; Modifica: A, B
                            185 ;; ==================================
   606A                     186 incTeam2Points::
   606A 3A 1F 60      [13]  187 	ld	a, (game_maxScore)
   606D 47            [ 4]  188 	ld 	b, a				;; B <= Max points
                            189 
   606E 3A 21 60      [13]  190 	ld	a, (game_t2Score)
   6071 3C            [ 4]  191 	inc	a				;; A <= Team 2 points + 1
                            192 
   6072 32 21 60      [13]  193 	ld	(game_t2Score), a	;; Inc team 2 points
                            194 
                            195 	;;cp 	b
                            196 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            197 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            198 
   6075 C9            [10]  199 		ret
                            200 
                            201 ;; alomejor es una función privada
   6076                     202 play_music:
   6076 D9            [ 4]  203 	exx
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   6077 08            [ 4]  204 	ex af', af
   6078 F5            [11]  205 	push af
   6079 C5            [11]  206 	push bc
   607A D5            [11]  207 	push de
   607B E5            [11]  208 	push hl
                            209 
   607C CD C5 63      [17]  210 	call cpct_akp_musicPlay_asm
                            211 
   607F E1            [10]  212 	pop hl
   6080 D1            [10]  213 	pop de
   6081 C1            [10]  214 	pop bc
   6082 F1            [10]  215 	pop af
   6083 08            [ 4]  216 	ex af', af
   6084 D9            [ 4]  217 	exx
                            218 
   6085 C9            [10]  219 	ret
                            220 
                            221 ;; alomejor es una función privada
   6086                     222 stop_music:
   6086 D9            [ 4]  223 	exx
   6087 08            [ 4]  224 	ex af', af
   6088 F5            [11]  225 	push af
   6089 C5            [11]  226 	push bc
   608A D5            [11]  227 	push de
   608B E5            [11]  228 	push hl
                            229 
   608C CD 28 6B      [17]  230 	call cpct_akp_stop_asm
                            231 
   608F E1            [10]  232 	pop hl
   6090 D1            [10]  233 	pop de
   6091 C1            [10]  234 	pop bc
   6092 F1            [10]  235 	pop af
   6093 08            [ 4]  236 	ex af', af
   6094 D9            [ 4]  237 	exx
                            238 
   6095 C9            [10]  239 	ret
                            240 
                            241 
                            242 ;; ====================================
                            243 ;; ====================================
                            244 ;; PRIVATE FUNCTIONS
                            245 ;; ====================================
                            246 ;; ====================================
                            247 
                            248 ;; ====================================
                            249 ;; ====================================
                            250 ;; Decide what number must charge
                            251 ;; a -> Number
                            252 ;; hl <- Sprite to print
                            253 ;; ====================================
                            254 ;; ====================================
   6096                     255 decideNumber::
   6096 FE 00         [ 7]  256 	cp #0
   6098 20 04         [12]  257 	jr nz, is_One
                            258 		;; if
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   609A 21 07 40      [10]  259 		ld hl, #_sprite_numbers_00
   609D C9            [10]  260 		ret
                            261 
   609E                     262 	is_One:
   609E FE 01         [ 7]  263 	cp #1
   60A0 20 04         [12]  264 	jr nz, is_Two
   60A2 21 1C 40      [10]  265 		ld hl, #_sprite_numbers_01
   60A5 C9            [10]  266 		ret
                            267 
   60A6                     268 	is_Two:
   60A6 FE 02         [ 7]  269 	cp #2
   60A8 20 04         [12]  270 	jr nz, is_Tree
   60AA 21 31 40      [10]  271 		ld hl, #_sprite_numbers_02
   60AD C9            [10]  272 		ret
                            273 
   60AE                     274 	is_Tree:
   60AE FE 03         [ 7]  275 	cp #3
   60B0 20 04         [12]  276 	jr nz, is_Four
   60B2 21 46 40      [10]  277 		ld hl, #_sprite_numbers_03
   60B5 C9            [10]  278 		ret
                            279 
   60B6                     280 	is_Four:
   60B6 FE 04         [ 7]  281 	cp #4
   60B8 20 04         [12]  282 	jr nz, is_Five
   60BA 21 5B 40      [10]  283 		ld hl, #_sprite_numbers_04
   60BD C9            [10]  284 		ret
                            285 
   60BE                     286 	is_Five:
   60BE FE 05         [ 7]  287 	cp #5
   60C0 20 04         [12]  288 	jr nz, is_Six
   60C2 21 70 40      [10]  289 		ld hl, #_sprite_numbers_05
   60C5 C9            [10]  290 		ret
                            291 
   60C6                     292 	is_Six:
   60C6 FE 06         [ 7]  293 	cp #6
   60C8 20 04         [12]  294 	jr nz, is_Seven
   60CA 21 85 40      [10]  295 		ld hl, #_sprite_numbers_06
   60CD C9            [10]  296 		ret
                            297 
   60CE                     298 	is_Seven:
   60CE FE 07         [ 7]  299 	cp #7
   60D0 20 04         [12]  300 	jr nz, is_Eight
   60D2 21 9A 40      [10]  301 		ld hl, #_sprite_numbers_07
   60D5 C9            [10]  302 		ret
                            303 
   60D6                     304 	is_Eight:
   60D6 FE 08         [ 7]  305 	cp #8
   60D8 20 04         [12]  306 	jr nz, is_Nine
   60DA 21 AF 40      [10]  307 		ld hl, #_sprite_numbers_08
   60DD C9            [10]  308 		ret
                            309 
   60DE                     310 	is_Nine:
   60DE 21 C4 40      [10]  311 		ld hl, #_sprite_numbers_09
   60E1 C9            [10]  312 		ret
                            313 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   60E2 C9            [10]  314 	ret
                            315 
                            316 ;; ===================================
                            317 ;; Draws a number
                            318 ;; Entrada:
                            319 ;;	HL <= Pointer to number sprite
                            320 ;;	DE <= Pointer to video memory
                            321 ;; Modifica AF, BC, DE, HL
                            322 ;; ===================================
   60E3                     323 drawNumber::
   60E3 06 07         [ 7]  324 	ld 	b, #number_h 		;; B = ent height
   60E5 0E 03         [ 7]  325 	ld 	c, #number_w 		;; C = ent width
   60E7 CD 0D 6C      [17]  326 	call cpct_drawSprite_asm
                            327 
   60EA C9            [10]  328 	ret
                            329 
   60EB                     330 drawTimeCounters::
   60EB 3A 32 60      [13]  331 		ld a, (videoPtr + 1)
   60EE FE 80         [ 7]  332 		cp #0x80
   60F0 28 26         [12]  333 		jr z, paintOn8000
                            334 			;; Painting on C000
   60F2 3A 22 60      [13]  335 			ld a, (game_minute)
   60F5 CD 96 60      [17]  336 			call decideNumber	;; HL <= sprite pointer
   60F8 11 25 E0      [10]  337 			ld de,	#minSpPointer
   60FB CD E3 60      [17]  338 			call drawNumber
                            339 
   60FE 3A 23 60      [13]  340 			ld a, (game_secLeft)
   6101 CD 96 60      [17]  341 			call decideNumber	;; HL <= sprite pointer
   6104 11 29 E0      [10]  342 			ld de,	#secLeftSpPointer
   6107 CD E3 60      [17]  343 			call drawNumber
                            344 
   610A 3A 24 60      [13]  345 			ld a, (game_secRight)
   610D CD 96 60      [17]  346 			call decideNumber	;; HL <= sprite pointer
   6110 11 2C E0      [10]  347 			ld de,	#secRightSpPointer
   6113 CD E3 60      [17]  348 			call drawNumber
                            349 
   6116 18 24         [12]  350 		jr drawTimeCounters_exit
                            351 
   6118                     352 		paintOn8000:
   6118 3A 22 60      [13]  353 			ld a, (game_minute)
   611B CD 96 60      [17]  354 			call decideNumber	;; HL <= sprite pointer
   611E 11 25 A0      [10]  355 			ld de,	#minSpPointer2
   6121 CD E3 60      [17]  356 			call drawNumber
                            357 
   6124 3A 23 60      [13]  358 			ld a, (game_secLeft)
   6127 CD 96 60      [17]  359 			call decideNumber	;; HL <= sprite pointer
   612A 11 29 A0      [10]  360 			ld de,	#secLeftSpPointer2
   612D CD E3 60      [17]  361 			call drawNumber
                            362 
   6130 3A 24 60      [13]  363 			ld a, (game_secRight)
   6133 CD 96 60      [17]  364 			call decideNumber	;; HL <= sprite pointer
   6136 11 2C A0      [10]  365 			ld de,	#secRightSpPointer2
   6139 CD E3 60      [17]  366 			call drawNumber
                            367 
   613C                     368 		drawTimeCounters_exit:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   613C C9            [10]  369 		ret
                            370 
   613D                     371 updateTime::
   613D 3A 23 60      [13]  372 	ld a, (game_secLeft)
   6140 FE 00         [ 7]  373 	cp #0
   6142 20 1A         [12]  374 	jr nz, checkRightsec
                            375 
   6144 3A 24 60      [13]  376 	ld a, (game_secRight)
   6147 FE 00         [ 7]  377 	cp #0
   6149 20 28         [12]  378 	jr nz, decRightsec
   614B 3A 22 60      [13]  379 		ld a, (game_minute) 
   614E 3D            [ 4]  380 		dec a ;; min--
   614F 32 22 60      [13]  381 		ld (game_minute), a
                            382 
   6152 3E 05         [ 7]  383 		ld a, #5
   6154 32 23 60      [13]  384 		ld (game_secLeft), a ;; secLeft = 5
                            385 
   6157 3E 09         [ 7]  386 		ld a, #9
   6159 32 24 60      [13]  387 		ld (game_secRight), a ;; secRight = 9;
                            388 
   615C 18 1C         [12]  389 		jr continue
   615E                     390 	checkRightsec:
   615E 3A 24 60      [13]  391 		ld a, (game_secRight)
   6161 FE 00         [ 7]  392 		cp #0
   6163 20 0E         [12]  393 		jr nz, decRightsec
   6165 3A 23 60      [13]  394 			ld a, (game_secLeft) 
   6168 3D            [ 4]  395 			dec a ;; secLeft--
   6169 32 23 60      [13]  396 			ld (game_secLeft), a
                            397 
   616C 3E 09         [ 7]  398 			ld a, #9 ;; secRight = 9;
   616E 32 24 60      [13]  399 			ld (game_secRight), a
   6171 18 07         [12]  400 			jr continue
   6173                     401 	decRightsec:
   6173 3A 24 60      [13]  402 		ld a, (game_secRight)
   6176 3D            [ 4]  403 		dec a ;; secRight--
   6177 32 24 60      [13]  404 		ld (game_secRight), a
                            405 
   617A                     406 	continue:
   617A C9            [10]  407 	ret
                            408 
                            409 ;; Empty Handler
   617B                     410 emptyHandler:
   617B C9            [10]  411 	ret
                            412 
                            413 ;; Handler for time
   617C                     414 handlerTime::
   617C 2A 2C 60      [16]  415 	ld 	hl, (game_interrTime)
   617F 2B            [ 6]  416 	dec hl
   6180 7C            [ 4]  417 	ld 	a, h
   6181 FE 00         [ 7]  418 	cp 	#0
   6183 20 0B         [12]  419 	jr 	nz, time_iterate
   6185 7D            [ 4]  420 		ld 	a, l
   6186 FE 00         [ 7]  421 		cp 	#0
   6188 20 06         [12]  422 	jr 	nz, time_iterate
                            423 		;; interrTime == 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   618A 21 2C 01      [10]  424 		ld hl, #0x012C		;; HL <= 300
   618D CD 3D 61      [17]  425 		call updateTime
                            426 
   6190                     427 	time_iterate:
   6190 22 2C 60      [16]  428 		ld (game_interrTime), hl
   6193 C9            [10]  429 	ret
                            430 
                            431 ;; Handler for music
   6194                     432 handlerMusic::
   6194 3A 2B 60      [13]  433 	ld a , (game_interrMusic) ;; a <- game_interrMusic
   6197 3D            [ 4]  434 	dec a
   6198 32 2B 60      [13]  435 	ld (game_interrMusic), a
                            436 
   619B 20 08         [12]  437 	jr nz, music_iterate
                            438 		;; a == 0
   619D 3E 06         [ 7]  439 		ld a, #music_vel
   619F 32 2B 60      [13]  440 		ld (game_interrMusic), a
   61A2 CD 76 60      [17]  441 		call play_music
                            442 
   61A5                     443 	music_iterate:
   61A5 C9            [10]  444 	ret
                            445 
                            446 ;; Handler for time music
   61A6                     447 handlerTimeMusic:
   61A6 CD 7C 61      [17]  448 	call handlerTime
   61A9 CD 94 61      [17]  449 	call handlerMusic
   61AC C9            [10]  450 	ret
                            451 
   61AD                     452 configureISR::
   61AD 3A 1E 60      [13]  453 	ld a, (game_WinCondition) 	;; a <- game_WinCondition (0-> Time, 1 -> Score)
   61B0 FE 00         [ 7]  454 	cp #0						;; a - 0
   61B2 28 0E         [12]  455 	jr z, ISR_timeOn			;; if (game_enableTime - 0) == 0, then jump ISR_timeOn
                            456 		;; Time Off
   61B4 3A 30 60      [13]  457 		ld a, (game_enableMusic) 	;; a <- game_enableMusic
   61B7 FE 00         [ 7]  458 		cp #0						;; a - 0
   61B9 20 15         [12]  459 		jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
                            460 		;; Time Off, Music Off
   61BB 21 7B 61      [10]  461 			ld hl, #emptyHandler	;; emptyHandler
   61BE CD 31 63      [17]  462 			call cpct_setInterruptHandler_asm
   61C1 C9            [10]  463 			ret 					;; Get Out
                            464 
   61C2                     465 	ISR_timeOn:
                            466 		;; Time On
   61C2 3A 30 60      [13]  467 		ld a, (game_enableMusic)	;; a <- game_enableMusic
   61C5 FE 00         [ 7]  468 		cp #0
   61C7 20 0E         [12]  469 		jr nz, ISR_timeOn_musicOn 	;; if (a - 0) == 1, jump ISR_timeOn_musicOn
                            470 			;; Time On, Music Off
   61C9 21 7C 61      [10]  471 			ld hl, #handlerTime 				;; handlerTime
   61CC CD 31 63      [17]  472 			call cpct_setInterruptHandler_asm	;;
   61CF C9            [10]  473 			ret 								;; Get Out
                            474 
   61D0                     475 	ISR_timeOff_musicOn:
   61D0 21 94 61      [10]  476 		ld hl, #handlerMusic
   61D3 CD 31 63      [17]  477 		call cpct_setInterruptHandler_asm
   61D6 C9            [10]  478 		ret 								;; Get Out
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            479 
   61D7                     480 	ISR_timeOn_musicOn:
   61D7 21 A6 61      [10]  481 		ld hl, #handlerTimeMusic
   61DA CD 31 63      [17]  482 		call cpct_setInterruptHandler_asm
   61DD C9            [10]  483 		ret 								;; Get Out
                            484 
                            485 .globl _mainSong
                            486 
                            487 ;; ========================
                            488 ;; Initialize game
                            489 ;; ========================
   61DE                     490 initializeGame:
                            491 
                            492 	;; Set video mode
   61DE 0E 00         [ 7]  493 	ld 	c, #0
   61E0 CD A3 6E      [17]  494 	call cpct_setVideoMode_asm
                            495 
                            496 	;; Set palette
   61E3 21 41 42      [10]  497 	ld 	hl, #_sprite_palette
   61E6 11 10 00      [10]  498 	ld 	de, #16
   61E9 CD A6 63      [17]  499 	call cpct_setPalette_asm
                            500 
   61EC 2E 10         [ 7]  501 	ld l, #16					;; Select the border colour
   61EE 26 4B         [ 7]  502 	ld h, #0x4B					;; Set the White Colour
   61F0 CD B9 63      [17]  503 	call cpct_setPALColour_asm
                            504 
                            505 	;; Clean from 8000 to FFFF
   61F3 21 00 80      [10]  506 	ld	hl, #0x8000			;; HL <= Copy pointer
   61F6 11 01 80      [10]  507 	ld	de, #0x8001			;; DE <= Write pointer
   61F9 36 00         [10]  508 	ld	(hl), #00			;; Set to 0 where HL points
   61FB 01 00 80      [10]  509 	ld	bc, #0x8000			;; BC <= Times to repeat
   61FE ED B0         [21]  510 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            511 
   6200 21 20 60      [10]  512 	ld	hl, #game_t1Score
   6203 36 00         [10]  513 	ld 	(hl), #0
   6205 21 21 60      [10]  514 	ld	hl, #game_t2Score
   6208 36 00         [10]  515 	ld 	(hl), #0		;; Initialize points to 0
                            516 
   620A 11 00 01      [10]  517 	ld de, #_mainSong
   620D CD CF 6A      [17]  518 	call cpct_akp_musicInit_asm
                            519 	
   6210 C9            [10]  520 	ret
                            521 
                            522 ;; ========================
                            523 ;; Switch Buffers
                            524 ;; ========================
   6211                     525 switchBuffers:
                     026C   526 	mem_page = .+1
   6211 2E 20         [ 7]  527 	ld 	l, #0x20
   6213 CD 92 6E      [17]  528 	call 	cpct_setVideoMemoryPage_asm
   6216 21 12 62      [10]  529 	ld 	hl, #mem_page
   6219 3E 10         [ 7]  530 	ld	a, #0x10
   621B AE            [ 7]  531 	xor	(hl)
   621C 77            [ 7]  532 	ld	(hl), a
                            533 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   621D 21 32 60      [10]  534 	ld	hl, #videoPtr+1
   6220 3E 40         [ 7]  535 	ld	a, #0x40
   6222 AE            [ 7]  536 	xor	(hl)
   6223 77            [ 7]  537 	ld	(hl), a
                            538 
                            539 
   6224 C9            [10]  540 	ret
                            541 
                            542 ;; ============================
                            543 ;; Game loop until end of game
                            544 ;; ============================
   6225                     545 game_loop_Player_IA:
                            546 
                            547 	;; Erase
   6225 DD 21 B0 5F   [14]  548 	ld ix, #player_data
   6229 CD 5D 4B      [17]  549 	call entityErase
                            550 
   622C DD 21 CB 5F   [14]  551 	ld ix, #enemy_data
   6230 CD 5D 4B      [17]  552 	call entityErase
                            553 
   6233 DD 21 7E 4D   [14]  554 	ld ix, #frisbee_data
   6237 CD 5D 4B      [17]  555 	call entityErase
                            556 
                            557 	;; Update
   623A DD 21 B0 5F   [14]  558 	ld ix, #player_data
   623E CD EB 4E      [17]  559 	call player_update
                            560 
   6241 DD 21 CB 5F   [14]  561 	ld ix, #enemy_data
   6245 CD EB 4E      [17]  562 	call player_update
                            563 
   6248 DD 21 7E 4D   [14]  564 	ld ix, #frisbee_data
   624C CD 2B 4E      [17]  565 	call frisbee_update
                            566 
                            567 	;; Draw
   624F DD 21 B0 5F   [14]  568 	ld ix, #player_data
   6253 CD 28 4B      [17]  569 	call entityDraw
                            570 
   6256 DD 21 CB 5F   [14]  571 	ld ix, #enemy_data
   625A CD 28 4B      [17]  572 	call entityDraw
                            573 
   625D DD 21 7E 4D   [14]  574 	ld ix, #frisbee_data
   6261 CD 28 4B      [17]  575 	call entityDraw
                            576 
   6264 CD EB 60      [17]  577 	call drawTimeCounters
                            578 
                            579 	;; Check goal
   6267 DD 21 7E 4D   [14]  580 	ld	ix, #frisbee_data
   626B CD 9F 4E      [17]  581 	call frisbee_checkGoal
                            582 
                            583 	;; Wait VSYNC to modify VMEM without blinking
   626E CD 9B 6E      [17]  584 	call cpct_waitVSYNC_asm
   6271 CD 11 62      [17]  585 	call switchBuffers
                            586 
   6274 3A 1E 60      [13]  587 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   6277 FE 00         [ 7]  588 	cp #0  				      ;; a - 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   6279 28 02         [12]  589 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   627B 18 17         [12]  590 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            591 
   627D                     592 	timeWinning:
   627D 3A 22 60      [13]  593 		ld a, (game_minute) ;; a <- game_minute
   6280 FE 00         [ 7]  594 		cp #0 				;; a - 0
   6282 20 A1         [12]  595 		jr nz, game_loop_Player_IA 	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            596 
   6284 3A 23 60      [13]  597 		ld a, (game_secLeft)	;; a <- game_secLeft
   6287 FE 00         [ 7]  598 		cp #0 				  	;; a - 0
   6289 20 9A         [12]  599 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            600 
   628B 3A 24 60      [13]  601 		ld a, (game_secRight)	;; a <- game_secRight
   628E FE 00         [ 7]  602 		cp #0 				  	;; a - 0
   6290 20 93         [12]  603 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
   6292 18 16         [12]  604 		jr game_loop_Player_IA_exit
                            605 
   6294                     606 	scoreEnd:
   6294 3A 20 60      [13]  607 		ld a, (game_t1Score) 
   6297 47            [ 4]  608 		ld b, a               ;; b <- LocalScore
   6298 3A 1F 60      [13]  609 		ld a, (game_maxScore) ;; a <- maxScore
   629B B8            [ 4]  610 		cp b             	  ;; a - b 
   629C 28 0C         [12]  611 		jr z, game_loop_Player_IA_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            612 
   629E 4F            [ 4]  613 		ld c, a      	      ;; c <- maxScore
   629F 3A 21 60      [13]  614 		ld a, (game_t2Score)
   62A2 47            [ 4]  615 		ld b, a               ;; b <- VisitantScore
   62A3 79            [ 4]  616 		ld a, c 			  ;; a <- c
   62A4 B8            [ 4]  617 		cp b             	  ;; a - b 
   62A5 28 03         [12]  618 		jr z, game_loop_Player_IA_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   62A7 C3 25 62      [10]  619 			jp game_loop_Player_IA ;; Keep Playing
                            620 
   62AA                     621 	game_loop_Player_IA_exit:
   62AA C9            [10]  622 	ret
                            623 
                            624 
                            625 ;; Game loop for PVP
   62AB                     626 game_loop_Player_PvP:
                            627 	;; Erase
   62AB DD 21 B0 5F   [14]  628 	ld ix, #player_data
   62AF CD 5D 4B      [17]  629 	call entityErase
                            630 
   62B2 DD 21 E6 5F   [14]  631 	ld ix, #player2_data
   62B6 CD 5D 4B      [17]  632 	call entityErase
                            633 
   62B9 DD 21 7E 4D   [14]  634 	ld ix, #frisbee_data
   62BD CD 5D 4B      [17]  635 	call entityErase
                            636 
                            637 	;; Update
   62C0 DD 21 B0 5F   [14]  638 	ld ix, #player_data
   62C4 CD EB 4E      [17]  639 	call player_update
                            640 
   62C7 DD 21 E6 5F   [14]  641 	ld ix, #player2_data
   62CB CD EB 4E      [17]  642 	call player_update
                            643 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



   62CE DD 21 7E 4D   [14]  644 	ld ix, #frisbee_data
   62D2 CD 2B 4E      [17]  645 	call frisbee_update
                            646 
                            647 	;; Draw
   62D5 DD 21 B0 5F   [14]  648 	ld ix, #player_data
   62D9 CD 28 4B      [17]  649 	call entityDraw
                            650 
   62DC DD 21 E6 5F   [14]  651 	ld ix, #player2_data
   62E0 CD 28 4B      [17]  652 	call entityDraw
                            653 
   62E3 DD 21 7E 4D   [14]  654 	ld ix, #frisbee_data
   62E7 CD 28 4B      [17]  655 	call entityDraw
                            656 
   62EA CD EB 60      [17]  657 	call drawTimeCounters
                            658 
                            659 	;; Check goal
   62ED DD 21 7E 4D   [14]  660 	ld	ix, #frisbee_data
   62F1 CD 9F 4E      [17]  661 	call frisbee_checkGoal
                            662 
                            663 	;; Wait VSYNC to modify VMEM without blinking
   62F4 CD 9B 6E      [17]  664 	call cpct_waitVSYNC_asm
   62F7 CD 11 62      [17]  665 	call switchBuffers
                            666 
   62FA 3A 1E 60      [13]  667 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   62FD FE 00         [ 7]  668 	cp #0  				      ;; a - 0
   62FF 28 02         [12]  669 	jr z, timeWinning_Pvp         ;; if (a - 0) == 0, then jump timeWinning_Pvp
   6301 18 17         [12]  670 		jr scoreEnd_Pvp 		  ;; else, jump ScoreWinning.
                            671 
   6303                     672 	timeWinning_Pvp:
   6303 3A 22 60      [13]  673 		ld a, (game_minute) ;; a <- game_minute
   6306 FE 00         [ 7]  674 		cp #0 				;; a - 0
   6308 20 A1         [12]  675 		jr nz, game_loop_Player_PvP 	;; if (a - 0) != 0, then jump game_loop_Player_PvP
                            676 
   630A 3A 23 60      [13]  677 		ld a, (game_secLeft)	;; a <- game_secLeft
   630D FE 00         [ 7]  678 		cp #0 				  	;; a - 0
   630F 20 9A         [12]  679 		jr nz, game_loop_Player_PvP	;; if (a - 0) != 0, then jump game_loop_Player_PvP
                            680 
   6311 3A 24 60      [13]  681 		ld a, (game_secRight)	;; a <- game_secRight
   6314 FE 00         [ 7]  682 		cp #0 				  	;; a - 0
   6316 20 93         [12]  683 		jr nz, game_loop_Player_PvP	;; if (a - 0) != 0, then jump game_loop_Player_PvP
   6318 18 16         [12]  684 		jr game_loop_Player_PvP_exit
                            685 
   631A                     686 	scoreEnd_Pvp:
   631A 3A 20 60      [13]  687 		ld a, (game_t1Score) 
   631D 47            [ 4]  688 		ld b, a               ;; b <- LocalScore
   631E 3A 1F 60      [13]  689 		ld a, (game_maxScore) ;; a <- maxScore
   6321 B8            [ 4]  690 		cp b             	  ;; a - b 
   6322 28 0C         [12]  691 		jr z, game_loop_Player_PvP_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            692 
   6324 4F            [ 4]  693 		ld c, a      	      ;; c <- maxScore
   6325 3A 21 60      [13]  694 		ld a, (game_t2Score)
   6328 47            [ 4]  695 		ld b, a               ;; b <- VisitantScore
   6329 79            [ 4]  696 		ld a, c 			  ;; a <- c
   632A B8            [ 4]  697 		cp b             	  ;; a - b 
   632B 28 03         [12]  698 		jr z, game_loop_Player_PvP_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



   632D C3 AB 62      [10]  699 			jp game_loop_Player_PvP ;; Keep Playing
                            700 
   6330                     701 	game_loop_Player_PvP_exit:
                            702 
   6330 C9            [10]  703 	ret
