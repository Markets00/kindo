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
   5C68 4B                   16 paletteM2::	.db #0x4B	;; White
   5C69 54                   17 			.db #0x54	;; Black
                             18 
   5C6A 4C                   19 paletteM1::	.db #0x4C	;; Red
   5C6B 40                   20 			.db #0x40	;; Grey
   5C6C 4B                   21 			.db #0x4B	;; White
   5C6D 54                   22 			.db #0x54	;; Black
                             23 
   5C6E 54                   24 blackPaletteM1::	.db #0x54	;; Black
   5C6F 54                   25 					.db #0x54	;; Black
   5C70 54                   26 					.db #0x54	;; Black
   5C71 54                   27 					.db #0x54	;; Black
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
                             49 
                             50 ;;defineEntity name, 	x,	y,	 h, w, 	vx, 	vy, 	ax, 	ay, normal, 	sprites_ptr, 		id
   5C72                      51 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 		#1
   000A                       1 	player_data::
   5C72 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   5C74 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   5C76 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   5C77 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   5C78 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5C7A 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5C7C 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5C7E 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5C80 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5C82 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   5C83 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5C84 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   5C85 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   5C86 00                   15 		player_state:	.db #0		;; Entity animation state	(8 bits)
   5C87 00                   16 		player_lastState:.db #0		;; Last entity animation state	(8 bits)
   5C88 FF                   17 		player_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5C89 00                   18 		player_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5C8A 0C 4B                19 		player_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   5C8C 01                   20 		player_id:	.db #1		;; Numeric ID			(8 bits)
   5C8D                      52 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#2
   0025                       1 	enemy_data::
   5C8D 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5C8F 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   5C91 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   5C92 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   5C93 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5C95 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5C97 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5C99 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5C9B 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5C9D 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5C9E 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5C9F 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5CA0 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5CA1 00                   15 		enemy_state:	.db #0		;; Entity animation state	(8 bits)
   5CA2 00                   16 		enemy_lastState:.db #0		;; Last entity animation state	(8 bits)
   5CA3 FF                   17 		enemy_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5CA4 00                   18 		enemy_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5CA5 10 4B                19 		enemy_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   5CA7 02                   20 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             53 
   5CA8                      54 defineEntity player2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 	#3
   0040                       1 	player2_data::
   5CA8 10 00                 2 		player2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   5CAA 50 00                 3 		player2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   5CAC 14                    4 		player2_h:	.db #20		;; Height			(8 bits)
   5CAD 05                    5 		player2_w:	.db #5		;; Width			(8 bits)
   5CAE 00 00                 6 		player2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5CB0 00 00                 7 		player2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5CB2 00 00                 8 		player2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5CB4 00 00                 9 		player2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5CB6 00 18                10 		player2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5CB8 10                   11 		player2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   5CB9 10                   12 		player2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   5CBA 50                   13 		player2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   5CBB 50                   14 		player2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   5CBC 00                   15 		player2_state:	.db #0		;; Entity animation state	(8 bits)
   5CBD 00                   16 		player2_lastState:.db #0		;; Last entity animation state	(8 bits)
   5CBE FF                   17 		player2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5CBF 00                   18 		player2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5CC0 0C 4B                19 		player2_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   5CC2 03                   20 		player2_id:	.db #3		;; Numeric ID			(8 bits)
   5CC3                      55 defineEntity enemy2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#4
   005B                       1 	enemy2_data::
   5CC3 4C 00                 2 		enemy2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5CC5 64 00                 3 		enemy2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5CC7 14                    4 		enemy2_h:	.db #20		;; Height			(8 bits)
   5CC8 05                    5 		enemy2_w:	.db #5		;; Width			(8 bits)
   5CC9 00 00                 6 		enemy2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5CCB 00 00                 7 		enemy2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5CCD 00 00                 8 		enemy2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5CCF 00 00                 9 		enemy2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5CD1 00 18                10 		enemy2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5CD3 4C                   11 		enemy2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5CD4 4C                   12 		enemy2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5CD5 64                   13 		enemy2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5CD6 64                   14 		enemy2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5CD7 00                   15 		enemy2_state:	.db #0		;; Entity animation state	(8 bits)
   5CD8 00                   16 		enemy2_lastState:.db #0		;; Last entity animation state	(8 bits)
   5CD9 FF                   17 		enemy2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5CDA 00                   18 		enemy2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5CDB 10 4B                19 		enemy2_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   5CDD 04                   20 		enemy2_id:	.db #4		;; Numeric ID			(8 bits)
                             56 
   5CDE                      57 game_data::
   5CDE 00                   58 	game_type::         .db #0 ;; Game Mode (8 bits)
   5CDF 00                   59    	game_numPlayers::    .db #0 ;; Players who are going to play
   5CE0 00                   60    	game_WinCondition::  .db #0 ;; Win condition 0-> Time, 1 -> Score
                             61 
   5CE1 15                   62 	game_maxScore::      .db #21 ;; Max score of a match (to win)
   5CE2 00                   63 	game_t1Score::       .db #0 ;; Points of team 1		(8 bits)
   5CE3 00                   64 	game_t2Score::       .db #0 ;; Points of team 2		(8 bits)
                             65 
   5CE4 02                   66 	game_minute::		.db #2 ;; Actual minute. Also Controles if we whant to play with time
   5CE5 00                   67 	game_secLeft::		.db #0 ;; Both variables to control the seconds
   5CE6 00                   68 	game_secRight::		.db #0 ;; Both variables to control the seconds
   5CE7 00 00                69 	game_maxTime::       .dw #0x0000 ;; Max time of a match
   5CE9 00 00                70 	game_map::           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             71 
   5CEB 00                   72 	game_musicOptions::  .db #0 ;; Controles if we whant to play music on options
   5CEC 00                   73 	game_timeOptions::   .db #0 ;; Controles if we whant to play with time on options
                             74 
   5CED 00 00                75 	game_interrMusic::   .dw #0 ;; Interruption counter for music handler	(16 bits)
   5CEF 2C 01                76 	game_interrTime::	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
   5CF1 00                   77 	game_musicPlayer::   .db #0 ;; Controles the music player
   5CF2 00                   78 	game_musicEffects::  .db #0 ;; Controles the effects on the match
                             79 
   5CF3 01                   80 	game_enableMusic::	.db #1 ;; Controles if we whant some music
                             81 
                             82 	;; ÑORDBUGER 0f89
                             83 
                             84 	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
                             85 	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
                             86 	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
                             87 	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
                             88 ;; 
                             89 ;; .equ RIGHT_LIMIT,	80
                             90 ;; .equ LEFT_LIMIT,	0
                             91 ;; .equ TOP_LIMIT,	10
                             92 ;; .equ BOTTOM_LIMIT,	200
                             93 ;; .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             94 
                             95 
                             96 ;; ====================================
                             97 ;; ====================================
                             98 ;; PRIVATE DATA
                             99 ;; ====================================
                            100 ;; ====================================
                            101 
                            102 ;; .equ mi_constante0, 0
                            103 ;; .equ mi_constante1, 1
                            104 
                     E025   105 .equ minSpPointer, 0xE025		;; Pointer to know where to print the score, on both videopointers.
                     A025   106 .equ minSpPointer2, 0xA025
                     E029   107 .equ secLeftSpPointer, 0xE029
                     A029   108 .equ secLeftSpPointer2, 0xA029
                     E02C   109 .equ secRightSpPointer, 0xE02C
                     A02C   110 .equ secRightSpPointer2, 0xA02C
                            111 
   5CF4 00 80               112 videoPtr:	.dw 0x8000
                            113 
                            114 ;; ====================================
                            115 ;; ====================================
                            116 ;; PUBLIC FUNCTIONS
                            117 ;; ====================================
                            118 ;; ====================================
                            119 
                            120 
                            121 ;; ===================================
                            122 ;; Inicia una partida dependiendo
                            123 ;; 	de los atributos de game
                            124 ;; ===================================
   5CF6                     125 gameStart::
                            126 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            127 	;; Reading game data example
                            128 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            129 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                            130 	;;
                            131 	;;	ld 	h, Game_map_L(ix)
                            132 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                            133 	;;
                            134 	;;	ld 	h, Game_time_H(ix)
                            135 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                            136 	
                            137 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                            138 	;; Modifying game data example
                            139 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            140 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                            141 	;;
                            142 	;;	ld 	Game_map_L(ix), #0
                            143 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                            144 	;;
                            145 	;;	ld 	Game_time_H(ix), #0
                            146 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                            147 
                            148 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   5CF6 CD 71 5E      [17]  149 	call 	initializeGame
                            150 	;; Configuration staff...
                            151 	;; Configuration staff...
                            152 	;; Configuration staff...
                            153 	;; Configurating the handler
                            154 	;; Prepartida
   5CF9 CD 4D 5E      [17]  155 	call 	configureMatch
   5CFC CD AB 5E      [17]  156 	call 	game_loop_Player_IA
                            157 
   5CFF 3A E3 5C      [13]  158 	ld 	a, (game_t2Score)
   5D02 47            [ 4]  159 	ld 	b, a
                            160 
   5D03 3A E2 5C      [13]  161 	ld 	a, (game_t1Score)
   5D06 B8            [ 4]  162 	cp 	b
   5D07 FA 0A 5D      [10]  163 	jp 	m, t2_win
                            164 		;; t1 win
                            165 
   5D0A                     166 	t2_win:
                            167 
                            168 
   5D0A C9            [10]  169 	ret
                            170 
                            171 ;; ==================================
                            172 ;; Devuelve el puntero a video en HL
                            173 ;; Devuelve:
                            174 ;;	HL => Pointer to video memory
                            175 ;; ==================================
   5D0B                     176 getVideoPtr::
   5D0B 2A F4 5C      [16]  177 	ld	hl, (videoPtr)
   5D0E C9            [10]  178 	ret
                            179 
                            180 ;; ==================================
                            181 ;; Incrementa los puntos del equipo 1
                            182 ;; Modifica: A, B
                            183 ;; ==================================
   5D0F                     184 incTeam1Points::
   5D0F 3A E1 5C      [13]  185 	ld	a, (game_maxScore)
   5D12 47            [ 4]  186 	ld 	b, a				;; B <= Max points
                            187 
   5D13 3A E2 5C      [13]  188 	ld	a, (game_t1Score)
   5D16 3C            [ 4]  189 	inc	a				;; A <= Team 1 points + 1
                            190 
   5D17 32 E2 5C      [13]  191 	ld	(game_t1Score), a	;; Inc team 1 points
                            192 
   5D1A C9            [10]  193 		ret
                            194 
                            195 ;; ================================== 
                            196 ;; Incrementa los puntos del equipo 2
                            197 ;; Modifica: A, B
                            198 ;; ==================================
   5D1B                     199 incTeam2Points::
   5D1B 3A E1 5C      [13]  200 	ld	a, (game_maxScore)
   5D1E 47            [ 4]  201 	ld 	b, a				;; B <= Max points
                            202 
   5D1F 3A E3 5C      [13]  203 	ld	a, (game_t2Score)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   5D22 3C            [ 4]  204 	inc	a				;; A <= Team 2 points + 1
                            205 
   5D23 32 E3 5C      [13]  206 	ld	(game_t2Score), a	;; Inc team 2 points
                            207 
                            208 	;;cp 	b
                            209 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            210 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            211 
   5D26 C9            [10]  212 		ret
                            213 
                            214 ;; alomejor es una función privada
   5D27                     215 play_music:
   5D27 D9            [ 4]  216 	exx
   5D28 08            [ 4]  217 	ex af', af
   5D29 F5            [11]  218 	push af
   5D2A C5            [11]  219 	push bc
   5D2B D5            [11]  220 	push de
   5D2C E5            [11]  221 	push hl
                            222 
   5D2D CD C5 5F      [17]  223 	call cpct_akp_musicPlay_asm
                            224 
   5D30 E1            [10]  225 	pop hl
   5D31 D1            [10]  226 	pop de
   5D32 C1            [10]  227 	pop bc
   5D33 F1            [10]  228 	pop af
   5D34 08            [ 4]  229 	ex af', af
   5D35 D9            [ 4]  230 	exx
                            231 
   5D36 C9            [10]  232 	ret
                            233 
                            234 ;; alomejor es una función privada
   5D37                     235 stop_music:
   5D37 D9            [ 4]  236 	exx
   5D38 08            [ 4]  237 	ex af', af
   5D39 F5            [11]  238 	push af
   5D3A C5            [11]  239 	push bc
   5D3B D5            [11]  240 	push de
   5D3C E5            [11]  241 	push hl
                            242 
   5D3D CD 28 67      [17]  243 	call cpct_akp_stop_asm
                            244 
   5D40 E1            [10]  245 	pop hl
   5D41 D1            [10]  246 	pop de
   5D42 C1            [10]  247 	pop bc
   5D43 F1            [10]  248 	pop af
   5D44 08            [ 4]  249 	ex af', af
   5D45 D9            [ 4]  250 	exx
                            251 
   5D46 C9            [10]  252 	ret
                            253 
                            254 
                            255 ;; ====================================
                            256 ;; ====================================
                            257 ;; PRIVATE FUNCTIONS
                            258 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            259 ;; ====================================
                            260 
                            261 ;; ====================================
                            262 ;; ====================================
                            263 ;; Decide what number must charge
                            264 ;; a -> Number
                            265 ;; hl <- Sprite to print
                            266 ;; ====================================
                            267 ;; ====================================
   5D47                     268 decideNumber::
   5D47 FE 00         [ 7]  269 	cp #0
   5D49 20 04         [12]  270 	jr nz, is_One
                            271 		;; if
   5D4B 21 07 40      [10]  272 		ld hl, #_sprite_numbers_00
   5D4E C9            [10]  273 		ret
                            274 
   5D4F                     275 	is_One:
   5D4F FE 01         [ 7]  276 	cp #1
   5D51 20 04         [12]  277 	jr nz, is_Two
   5D53 21 1C 40      [10]  278 		ld hl, #_sprite_numbers_01
   5D56 C9            [10]  279 		ret
                            280 
   5D57                     281 	is_Two:
   5D57 FE 02         [ 7]  282 	cp #2
   5D59 20 04         [12]  283 	jr nz, is_Tree
   5D5B 21 31 40      [10]  284 		ld hl, #_sprite_numbers_02
   5D5E C9            [10]  285 		ret
                            286 
   5D5F                     287 	is_Tree:
   5D5F FE 03         [ 7]  288 	cp #3
   5D61 20 04         [12]  289 	jr nz, is_Four
   5D63 21 46 40      [10]  290 		ld hl, #_sprite_numbers_03
   5D66 C9            [10]  291 		ret
                            292 
   5D67                     293 	is_Four:
   5D67 FE 04         [ 7]  294 	cp #4
   5D69 20 04         [12]  295 	jr nz, is_Five
   5D6B 21 5B 40      [10]  296 		ld hl, #_sprite_numbers_04
   5D6E C9            [10]  297 		ret
                            298 
   5D6F                     299 	is_Five:
   5D6F FE 05         [ 7]  300 	cp #5
   5D71 20 04         [12]  301 	jr nz, is_Six
   5D73 21 70 40      [10]  302 		ld hl, #_sprite_numbers_05
   5D76 C9            [10]  303 		ret
                            304 
   5D77                     305 	is_Six:
   5D77 FE 06         [ 7]  306 	cp #6
   5D79 20 04         [12]  307 	jr nz, is_Seven
   5D7B 21 85 40      [10]  308 		ld hl, #_sprite_numbers_06
   5D7E C9            [10]  309 		ret
                            310 
   5D7F                     311 	is_Seven:
   5D7F FE 07         [ 7]  312 	cp #7
   5D81 20 04         [12]  313 	jr nz, is_Eight
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   5D83 21 9A 40      [10]  314 		ld hl, #_sprite_numbers_07
   5D86 C9            [10]  315 		ret
                            316 
   5D87                     317 	is_Eight:
   5D87 FE 08         [ 7]  318 	cp #8
   5D89 20 04         [12]  319 	jr nz, is_Nine
   5D8B 21 AF 40      [10]  320 		ld hl, #_sprite_numbers_08
   5D8E C9            [10]  321 		ret
                            322 
   5D8F                     323 	is_Nine:
   5D8F 21 C4 40      [10]  324 		ld hl, #_sprite_numbers_09
   5D92 C9            [10]  325 		ret
                            326 
   5D93 C9            [10]  327 	ret
                            328 
                            329 ;; ===================================
                            330 ;; Draws a number
                            331 ;; Entrada:
                            332 ;;	HL <= Pointer to number sprite
                            333 ;;	DE <= Pointer to video memory
                            334 ;; Modifica AF, BC, DE, HL
                            335 ;; ===================================
   5D94                     336 drawNumber::
   5D94 06 07         [ 7]  337 	ld 	b, #number_h 		;; B = ent height
   5D96 0E 03         [ 7]  338 	ld 	c, #number_w 		;; C = ent width
   5D98 CD 0D 68      [17]  339 	call cpct_drawSprite_asm
                            340 
   5D9B C9            [10]  341 	ret
                            342 
   5D9C                     343 drawTimeCounters:
   5D9C 3A F5 5C      [13]  344 		ld a, (videoPtr + 1)
   5D9F FE 80         [ 7]  345 		cp #0x80
   5DA1 28 26         [12]  346 		jr z, paintOn8000
                            347 			;; Painting on C000
   5DA3 3A E4 5C      [13]  348 			ld a, (game_minute)
   5DA6 CD 47 5D      [17]  349 			call decideNumber	;; HL <= sprite pointer
   5DA9 11 25 E0      [10]  350 			ld de,	#minSpPointer
   5DAC CD 94 5D      [17]  351 			call drawNumber
                            352 
   5DAF 3A E5 5C      [13]  353 			ld a, (game_secLeft)
   5DB2 CD 47 5D      [17]  354 			call decideNumber	;; HL <= sprite pointer
   5DB5 11 29 E0      [10]  355 			ld de,	#secLeftSpPointer
   5DB8 CD 94 5D      [17]  356 			call drawNumber
                            357 
   5DBB 3A E6 5C      [13]  358 			ld a, (game_secRight)
   5DBE CD 47 5D      [17]  359 			call decideNumber	;; HL <= sprite pointer
   5DC1 11 2C E0      [10]  360 			ld de,	#secRightSpPointer
   5DC4 CD 94 5D      [17]  361 			call drawNumber
                            362 
   5DC7 18 24         [12]  363 		jr drawTimeCounters_exit
                            364 
   5DC9                     365 		paintOn8000:
   5DC9 3A E4 5C      [13]  366 			ld a, (game_minute)
   5DCC CD 47 5D      [17]  367 			call decideNumber	;; HL <= sprite pointer
   5DCF 11 25 A0      [10]  368 			ld de,	#minSpPointer2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   5DD2 CD 94 5D      [17]  369 			call drawNumber
                            370 
   5DD5 3A E5 5C      [13]  371 			ld a, (game_secLeft)
   5DD8 CD 47 5D      [17]  372 			call decideNumber	;; HL <= sprite pointer
   5DDB 11 29 A0      [10]  373 			ld de,	#secLeftSpPointer2
   5DDE CD 94 5D      [17]  374 			call drawNumber
                            375 
   5DE1 3A E6 5C      [13]  376 			ld a, (game_secRight)
   5DE4 CD 47 5D      [17]  377 			call decideNumber	;; HL <= sprite pointer
   5DE7 11 2C A0      [10]  378 			ld de,	#secRightSpPointer2
   5DEA CD 94 5D      [17]  379 			call drawNumber
                            380 
   5DED                     381 		drawTimeCounters_exit:
   5DED C9            [10]  382 		ret
                            383 
   5DEE                     384 updateTime::
   5DEE 3A E5 5C      [13]  385 	ld a, (game_secLeft)
   5DF1 FE 00         [ 7]  386 	cp #0
   5DF3 20 1A         [12]  387 	jr nz, checkRightsec
                            388 
   5DF5 3A E6 5C      [13]  389 	ld a, (game_secRight)
   5DF8 FE 00         [ 7]  390 	cp #0
   5DFA 20 28         [12]  391 	jr nz, decRightsec
   5DFC 3A E4 5C      [13]  392 		ld a, (game_minute) 
   5DFF 3D            [ 4]  393 		dec a ;; min--
   5E00 32 E4 5C      [13]  394 		ld (game_minute), a
                            395 
   5E03 3E 05         [ 7]  396 		ld a, #5
   5E05 32 E5 5C      [13]  397 		ld (game_secLeft), a ;; secLeft = 5
                            398 
   5E08 3E 09         [ 7]  399 		ld a, #9
   5E0A 32 E6 5C      [13]  400 		ld (game_secRight), a ;; secRight = 9;
                            401 
   5E0D 18 1C         [12]  402 		jr continue
   5E0F                     403 	checkRightsec:
   5E0F 3A E6 5C      [13]  404 		ld a, (game_secRight)
   5E12 FE 00         [ 7]  405 		cp #0
   5E14 20 0E         [12]  406 		jr nz, decRightsec
   5E16 3A E5 5C      [13]  407 			ld a, (game_secLeft) 
   5E19 3D            [ 4]  408 			dec a ;; secLeft--
   5E1A 32 E5 5C      [13]  409 			ld (game_secLeft), a
                            410 
   5E1D 3E 09         [ 7]  411 			ld a, #9 ;; secRight = 9;
   5E1F 32 E6 5C      [13]  412 			ld (game_secRight), a
   5E22 18 07         [12]  413 			jr continue
   5E24                     414 	decRightsec:
   5E24 3A E6 5C      [13]  415 		ld a, (game_secRight)
   5E27 3D            [ 4]  416 		dec a ;; secRight--
   5E28 32 E6 5C      [13]  417 		ld (game_secRight), a
                            418 
   5E2B                     419 	continue:
   5E2B C9            [10]  420 	ret
                            421 
   5E2C                     422 emptyHandler:
   5E2C C9            [10]  423 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            424 
   5E2D                     425 handlerTime::
   5E2D 2A EF 5C      [16]  426 	ld 	hl, (game_interrTime)
   5E30 2B            [ 6]  427 	dec hl
   5E31 7C            [ 4]  428 	ld 	a, h
   5E32 FE 00         [ 7]  429 	cp 	#0
   5E34 20 0B         [12]  430 	jr 	nz, time_iterate
   5E36 7D            [ 4]  431 	ld 	a, l
   5E37 FE 00         [ 7]  432 	cp 	#0
   5E39 20 06         [12]  433 	jr 	nz, time_iterate
                            434 		;; interrTime == 0
   5E3B 21 2C 01      [10]  435 		ld hl, #0x012C		;; HL <= 300
   5E3E CD EE 5D      [17]  436 		call updateTime
                            437 
   5E41                     438 	time_iterate:
   5E41 22 EF 5C      [16]  439 		ld (game_interrTime), hl
   5E44 C9            [10]  440 	ret
                            441 
   5E45                     442 handlerMusic:
   5E45 C9            [10]  443 	ret
                            444 
   5E46                     445 handlerTimeMusic:
   5E46 CD 2D 5E      [17]  446 	call handlerTime
   5E49 CD 45 5E      [17]  447 	call handlerMusic
   5E4C C9            [10]  448 	ret
                            449 
   5E4D                     450 configureMatch:
   5E4D 3A E4 5C      [13]  451 	ld a, (game_minute) 		;; a <- game_minute
   5E50 FE 00         [ 7]  452 	cp #0						;; a - 0
   5E52 20 0F         [12]  453 	jr nz, ISR_timeOn			;; if (game_enableTime - 0) == 1, then jump ISR_timeOn
                            454 	;; Time Off
   5E54 3A F3 5C      [13]  455 	ld a, (game_enableMusic) 	;; a <- game_enableMusic
   5E57 FE 00         [ 7]  456 	cp #0						;; a - 0
   5E59 20 15         [12]  457 	jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
                            458 	;; Time Off, Music Off
   5E5B 21 2C 5E      [10]  459 	ld hl, #emptyHandler
   5E5E CD 31 5F      [17]  460 	call cpct_setInterruptHandler_asm
                            461 
   5E61 18 0D         [12]  462 	jr configureMatch_exit
                            463 
   5E63                     464 	ISR_timeOn:
                            465 		;; Time On
   5E63 3A F3 5C      [13]  466 		ld a, (game_enableMusic)	;; a <- game_enableMusic
   5E66 FE 00         [ 7]  467 		cp #0
   5E68 20 06         [12]  468 		jr nz, ISR_timeOn_musicOn
                            469 		;; Time On, Music Off
   5E6A 21 2D 5E      [10]  470 		ld hl, #handlerTime
   5E6D CD 31 5F      [17]  471 		call cpct_setInterruptHandler_asm
                            472 
   5E70                     473 	ISR_timeOff_musicOn:
                            474 
   5E70                     475 	ISR_timeOn_musicOn:
                            476 
   5E70                     477 	configureMatch_exit:
   5E70 C9            [10]  478 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            479 
                            480 ;; ========================
                            481 ;; Initialize game
                            482 ;; ========================
   5E71                     483 initializeGame:
                            484 
                            485 	;; Set video mode
   5E71 0E 00         [ 7]  486 	ld 	c, #0
   5E73 CD A3 6A      [17]  487 	call cpct_setVideoMode_asm
                            488 
                            489 	;; Set palette
   5E76 21 21 42      [10]  490 	ld 	hl, #_sprite_palette
   5E79 11 10 00      [10]  491 	ld 	de, #16
   5E7C CD A6 5F      [17]  492 	call cpct_setPalette_asm
                            493 
                            494 	;; Clean from 8000 to FFFF
   5E7F 21 00 80      [10]  495 	ld	hl, #0x8000			;; HL <= Copy pointer
   5E82 11 01 80      [10]  496 	ld	de, #0x8001			;; DE <= Write pointer
   5E85 36 00         [10]  497 	ld	(hl), #00			;; Set to 0 where HL points
   5E87 01 00 80      [10]  498 	ld	bc, #0x8000			;; BC <= Times to repeat
   5E8A ED B0         [21]  499 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            500 
   5E8C 21 E2 5C      [10]  501 	ld	hl, #game_t1Score
   5E8F 36 00         [10]  502 	ld 	(hl), #0
   5E91 21 E3 5C      [10]  503 	ld	hl, #game_t2Score
   5E94 36 00         [10]  504 	ld 	(hl), #0		;; Initialize points to 0
                            505 
                            506 	
   5E96 C9            [10]  507 	ret
                            508 
                            509 
                            510 ;; ========================
                            511 ;; Switch Buffers
                            512 ;; ========================
   5E97                     513 switchBuffers:
                     0230   514 	mem_page = .+1
   5E97 2E 20         [ 7]  515 	ld 	l, #0x20
   5E99 CD 92 6A      [17]  516 	call 	cpct_setVideoMemoryPage_asm
   5E9C 21 98 5E      [10]  517 	ld 	hl, #mem_page
   5E9F 3E 10         [ 7]  518 	ld	a, #0x10
   5EA1 AE            [ 7]  519 	xor	(hl)
   5EA2 77            [ 7]  520 	ld	(hl), a
                            521 
   5EA3 21 F5 5C      [10]  522 	ld	hl, #videoPtr+1
   5EA6 3E 40         [ 7]  523 	ld	a, #0x40
   5EA8 AE            [ 7]  524 	xor	(hl)
   5EA9 77            [ 7]  525 	ld	(hl), a
                            526 
                            527 
   5EAA C9            [10]  528 	ret
                            529 
                            530 ;; ============================
                            531 ;; Game loop until end of game
                            532 ;; ============================
   5EAB                     533 game_loop_Player_IA:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            534 
                            535 	;; Erase
   5EAB DD 21 72 5C   [14]  536 	ld ix, #player_data
   5EAF CD 4D 4B      [17]  537 	call entityErase
                            538 
   5EB2 DD 21 8D 5C   [14]  539 	ld ix, #enemy_data
   5EB6 CD 4D 4B      [17]  540 	call entityErase
                            541 
   5EB9 DD 21 6E 4D   [14]  542 	ld ix, #frisbee_data
   5EBD CD 4D 4B      [17]  543 	call entityErase
                            544 
                            545 	;; Update
   5EC0 DD 21 72 5C   [14]  546 	ld ix, #player_data
   5EC4 CD D9 4E      [17]  547 	call player_update
                            548 
   5EC7 DD 21 8D 5C   [14]  549 	ld ix, #enemy_data
   5ECB CD D9 4E      [17]  550 	call player_update
                            551 
   5ECE DD 21 6E 4D   [14]  552 	ld ix, #frisbee_data
   5ED2 CD 1B 4E      [17]  553 	call frisbee_update
                            554 
                            555 	;; Draw
   5ED5 DD 21 72 5C   [14]  556 	ld ix, #player_data
   5ED9 CD 18 4B      [17]  557 	call entityDraw
                            558 
   5EDC DD 21 8D 5C   [14]  559 	ld ix, #enemy_data
   5EE0 CD 18 4B      [17]  560 	call entityDraw
                            561 
   5EE3 DD 21 6E 4D   [14]  562 	ld ix, #frisbee_data
   5EE7 CD 18 4B      [17]  563 	call entityDraw
                            564 
   5EEA CD 9C 5D      [17]  565 	call drawTimeCounters
                            566 
                            567 	;; Check goal
   5EED DD 21 6E 4D   [14]  568 	ld	ix, #frisbee_data
   5EF1 CD 8F 4E      [17]  569 	call frisbee_checkGoal
                            570 
                            571 	;; Wait VSYNC to modify VMEM without blinking
   5EF4 CD 9B 6A      [17]  572 	call cpct_waitVSYNC_asm
   5EF7 CD 97 5E      [17]  573 	call switchBuffers
                            574 
   5EFA 3A E0 5C      [13]  575 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   5EFD FE 00         [ 7]  576 	cp #0  				      ;; a - 0
   5EFF 28 02         [12]  577 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   5F01 18 17         [12]  578 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            579 
   5F03                     580 	timeWinning:
   5F03 3A E4 5C      [13]  581 		ld a, (game_minute) ;; a <- game_minute
   5F06 FE 00         [ 7]  582 		cp #0 				;; a - 0
   5F08 20 A1         [12]  583 		jr nz, game_loop_Player_IA 	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            584 
   5F0A 3A E5 5C      [13]  585 		ld a, (game_secLeft)	;; a <- game_secLeft
   5F0D FE 00         [ 7]  586 		cp #0 				  	;; a - 0
   5F0F 20 9A         [12]  587 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            588 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   5F11 3A E6 5C      [13]  589 		ld a, (game_secRight)	;; a <- game_secRight
   5F14 FE 00         [ 7]  590 		cp #0 				  	;; a - 0
   5F16 20 93         [12]  591 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
   5F18 18 16         [12]  592 		jr game_loop_Player_IA_exit
                            593 
   5F1A                     594 	scoreEnd:
   5F1A 3A E2 5C      [13]  595 		ld a, (game_t1Score) 
   5F1D 47            [ 4]  596 		ld b, a               ;; b <- LocalScore
   5F1E 3A E1 5C      [13]  597 		ld a, (game_maxScore) ;; a <- maxScore
   5F21 B8            [ 4]  598 		cp b             	  ;; a - b 
   5F22 28 0C         [12]  599 		jr z, game_loop_Player_IA_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            600 
   5F24 4F            [ 4]  601 		ld c, a      	      ;; c <- maxScore
   5F25 3A E3 5C      [13]  602 		ld a, (game_t2Score)
   5F28 47            [ 4]  603 		ld b, a               ;; b <- VisitantScore
   5F29 79            [ 4]  604 		ld a, c 			  ;; a <- c
   5F2A B8            [ 4]  605 		cp b             	  ;; a - b 
   5F2B 28 03         [12]  606 		jr z, game_loop_Player_IA_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   5F2D C3 AB 5E      [10]  607 			jp game_loop_Player_IA ;; Keep Playing
                            608 
   5F30                     609 game_loop_Player_IA_exit:
   5F30 C9            [10]  610 	ret
