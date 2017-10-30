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
                             23 .globl cpct_drawStringM1_asm
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
   5A5F 4B                   16 paletteM2::	.db #0x4B	;; White
   5A60 54                   17 			.db #0x54	;; Black
                             18 
   5A61 4C                   19 paletteM1::	.db #0x4C	;; Red
   5A62 40                   20 			.db #0x40	;; Grey
   5A63 4B                   21 			.db #0x4B	;; White
   5A64 54                   22 			.db #0x54	;; Black
                             23 
   5A65 54                   24 blackPaletteM1::	.db #0x54	;; Black
   5A66 54                   25 					.db #0x54	;; Black
   5A67 54                   26 					.db #0x54	;; Black
   5A68 54                   27 					.db #0x54	;; Black
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
   5A69                      51 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 		#1
   000A                       1 	player_data::
   5A69 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   5A6B 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   5A6D 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   5A6E 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   5A6F 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5A71 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5A73 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5A75 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5A77 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5A79 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   5A7A 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5A7B 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   5A7C 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   5A7D 00                   15 		player_state:	.db #0		;; Entity animation state	(8 bits)
   5A7E 00                   16 		player_lastState:.db #0		;; Last entity animation state	(8 bits)
   5A7F FF                   17 		player_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5A80 00                   18 		player_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5A81 00 4B                19 		player_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   5A83 01                   20 		player_id:	.db #1		;; Numeric ID			(8 bits)
   5A84                      52 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#2
   0025                       1 	enemy_data::
   5A84 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5A86 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   5A88 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   5A89 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   5A8A 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5A8C 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5A8E 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5A90 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5A92 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5A94 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5A95 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5A96 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5A97 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5A98 00                   15 		enemy_state:	.db #0		;; Entity animation state	(8 bits)
   5A99 00                   16 		enemy_lastState:.db #0		;; Last entity animation state	(8 bits)
   5A9A FF                   17 		enemy_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5A9B 00                   18 		enemy_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5A9C 04 4B                19 		enemy_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   5A9E 02                   20 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             53 
   5A9F                      54 defineEntity player2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 	#3
   0040                       1 	player2_data::
   5A9F 10 00                 2 		player2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   5AA1 50 00                 3 		player2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   5AA3 14                    4 		player2_h:	.db #20		;; Height			(8 bits)
   5AA4 05                    5 		player2_w:	.db #5		;; Width			(8 bits)
   5AA5 00 00                 6 		player2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5AA7 00 00                 7 		player2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5AA9 00 00                 8 		player2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5AAB 00 00                 9 		player2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5AAD 00 18                10 		player2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5AAF 10                   11 		player2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   5AB0 10                   12 		player2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   5AB1 50                   13 		player2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   5AB2 50                   14 		player2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   5AB3 00                   15 		player2_state:	.db #0		;; Entity animation state	(8 bits)
   5AB4 00                   16 		player2_lastState:.db #0		;; Last entity animation state	(8 bits)
   5AB5 FF                   17 		player2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5AB6 00                   18 		player2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5AB7 00 4B                19 		player2_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   5AB9 03                   20 		player2_id:	.db #3		;; Numeric ID			(8 bits)
   5ABA                      55 defineEntity enemy2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#4
   005B                       1 	enemy2_data::
   5ABA 4C 00                 2 		enemy2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   5ABC 64 00                 3 		enemy2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5ABE 14                    4 		enemy2_h:	.db #20		;; Height			(8 bits)
   5ABF 05                    5 		enemy2_w:	.db #5		;; Width			(8 bits)
   5AC0 00 00                 6 		enemy2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   5AC2 00 00                 7 		enemy2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   5AC4 00 00                 8 		enemy2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   5AC6 00 00                 9 		enemy2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   5AC8 00 18                10 		enemy2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   5ACA 4C                   11 		enemy2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   5ACB 4C                   12 		enemy2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   5ACC 64                   13 		enemy2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   5ACD 64                   14 		enemy2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   5ACE 00                   15 		enemy2_state:	.db #0		;; Entity animation state	(8 bits)
   5ACF 00                   16 		enemy2_lastState:.db #0		;; Last entity animation state	(8 bits)
   5AD0 FF                   17 		enemy2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   5AD1 00                   18 		enemy2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   5AD2 04 4B                19 		enemy2_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   5AD4 04                   20 		enemy2_id:	.db #4		;; Numeric ID			(8 bits)
                             56 
   5AD5                      57 game_data::
   5AD5 00                   58 	game_type::         .db #0 ;; Game Mode (8 bits)
   5AD6 00                   59    	game_numPlayers:    .db #0 ;; Players who are going to play
   5AD7 00                   60    	game_WinCondition:  .db #0 ;; Win condition 0-> Time, 1 -> Score
                             61 
   5AD8 0A                   62 	game_maxScore:      .db #10 ;; Max score of a match (to win)
   5AD9 00                   63 	game_t1Score:       .db #0 ;; Points of team 1		(8 bits)
   5ADA 00                   64 	game_t2Score:       .db #0 ;; Points of team 2		(8 bits)
                             65 
   5ADB 02                   66 	game_minute:		.db #2 ;; Actual minute. Also Controles if we whant to play with time
   5ADC 00                   67 	game_secLeft:		.db #0 ;; Both variables to control the seconds
   5ADD 00                   68 	game_secRight:		.db #0 ;; Both variables to control the seconds
   5ADE 00 00                69 	game_maxTime:       .dw #0x0000 ;; Max time of a match
   5AE0 00 00                70 	game_map:           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             71 
   5AE2 00                   72 	game_musicOptions:  .db #0 ;; Controles if we whant to play music on options
   5AE3 00                   73 	game_timeOptions:   .db #0 ;; Controles if we whant to play with time on options
                             74 
   5AE4 00 00                75 	game_interrMusic:   .dw #0 ;; Interruption counter for music handler	(16 bits)
   5AE6 2C 01                76 	game_interrTime:	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
   5AE8 00                   77 	game_musicPlayer:   .db #0 ;; Controles the music player
   5AE9 00                   78 	game_musicEffects:  .db #0 ;; Controles the effects on the match
                             79 
   5AEA 00                   80 	game_enableMusic:	.db #0 ;; Controles if we whant some music
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
   5AEB 00 80               112 videoPtr:	.dw 0x8000
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
   5AED                     125 gameStart::
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



   5AED CD 68 5C      [17]  149 	call 	initializeGame
                            150 	;; Configuration staff...
                            151 	;; Configuration staff...
                            152 	;; Configuration staff...
                            153 	;; Configurating the handler
                            154 	;; Prepartida
   5AF0 CD 44 5C      [17]  155 	call 	configureMatch
   5AF3 CD A2 5C      [17]  156 	call 	game_loop_Player_IA
                            157 
   5AF6 3A DA 5A      [13]  158 	ld 	a, (game_t2Score)
   5AF9 47            [ 4]  159 	ld 	b, a
                            160 
   5AFA 3A D9 5A      [13]  161 	ld 	a, (game_t1Score)
   5AFD B8            [ 4]  162 	cp 	b
   5AFE FA 01 5B      [10]  163 	jp 	m, t2_win
                            164 		;; t1 win
                            165 
   5B01                     166 	t2_win:
                            167 
                            168 
   5B01 C9            [10]  169 	ret
                            170 
                            171 ;; ==================================
                            172 ;; Devuelve el puntero a video en HL
                            173 ;; Devuelve:
                            174 ;;	HL => Pointer to video memory
                            175 ;; ==================================
   5B02                     176 getVideoPtr::
   5B02 2A EB 5A      [16]  177 	ld	hl, (videoPtr)
   5B05 C9            [10]  178 	ret
                            179 
                            180 ;; ==================================
                            181 ;; Incrementa los puntos del equipo 1
                            182 ;; Modifica: A, B
                            183 ;; ==================================
   5B06                     184 incTeam1Points::
   5B06 3A D8 5A      [13]  185 	ld	a, (game_maxScore)
   5B09 47            [ 4]  186 	ld 	b, a				;; B <= Max points
                            187 
   5B0A 3A D9 5A      [13]  188 	ld	a, (game_t1Score)
   5B0D 3C            [ 4]  189 	inc	a				;; A <= Team 1 points + 1
                            190 
   5B0E 32 D9 5A      [13]  191 	ld	(game_t1Score), a	;; Inc team 1 points
                            192 
   5B11 C9            [10]  193 		ret
                            194 
                            195 ;; ================================== 
                            196 ;; Incrementa los puntos del equipo 2
                            197 ;; Modifica: A, B
                            198 ;; ==================================
   5B12                     199 incTeam2Points::
   5B12 3A D8 5A      [13]  200 	ld	a, (game_maxScore)
   5B15 47            [ 4]  201 	ld 	b, a				;; B <= Max points
                            202 
   5B16 3A DA 5A      [13]  203 	ld	a, (game_t2Score)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   5B19 3C            [ 4]  204 	inc	a				;; A <= Team 2 points + 1
                            205 
   5B1A 32 DA 5A      [13]  206 	ld	(game_t2Score), a	;; Inc team 2 points
                            207 
                            208 	;;cp 	b
                            209 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            210 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            211 
   5B1D C9            [10]  212 		ret
                            213 
                            214 ;; alomejor es una función privada
   5B1E                     215 play_music:
   5B1E D9            [ 4]  216 	exx
   5B1F 08            [ 4]  217 	ex af', af
   5B20 F5            [11]  218 	push af
   5B21 C5            [11]  219 	push bc
   5B22 D5            [11]  220 	push de
   5B23 E5            [11]  221 	push hl
                            222 
   5B24 CD BC 5D      [17]  223 	call cpct_akp_musicPlay_asm
                            224 
   5B27 E1            [10]  225 	pop hl
   5B28 D1            [10]  226 	pop de
   5B29 C1            [10]  227 	pop bc
   5B2A F1            [10]  228 	pop af
   5B2B 08            [ 4]  229 	ex af', af
   5B2C D9            [ 4]  230 	exx
                            231 
   5B2D C9            [10]  232 	ret
                            233 
                            234 ;; alomejor es una función privada
   5B2E                     235 stop_music:
   5B2E D9            [ 4]  236 	exx
   5B2F 08            [ 4]  237 	ex af', af
   5B30 F5            [11]  238 	push af
   5B31 C5            [11]  239 	push bc
   5B32 D5            [11]  240 	push de
   5B33 E5            [11]  241 	push hl
                            242 
   5B34 CD 1F 65      [17]  243 	call cpct_akp_stop_asm
                            244 
   5B37 E1            [10]  245 	pop hl
   5B38 D1            [10]  246 	pop de
   5B39 C1            [10]  247 	pop bc
   5B3A F1            [10]  248 	pop af
   5B3B 08            [ 4]  249 	ex af', af
   5B3C D9            [ 4]  250 	exx
                            251 
   5B3D C9            [10]  252 	ret
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
   5B3E                     268 decideNumber::
   5B3E FE 00         [ 7]  269 	cp #0
   5B40 20 04         [12]  270 	jr nz, is_One
                            271 		;; if
   5B42 21 07 40      [10]  272 		ld hl, #_sprite_numbers_00
   5B45 C9            [10]  273 		ret
                            274 
   5B46                     275 	is_One:
   5B46 FE 01         [ 7]  276 	cp #1
   5B48 20 04         [12]  277 	jr nz, is_Two
   5B4A 21 1C 40      [10]  278 		ld hl, #_sprite_numbers_01
   5B4D C9            [10]  279 		ret
                            280 
   5B4E                     281 	is_Two:
   5B4E FE 02         [ 7]  282 	cp #2
   5B50 20 04         [12]  283 	jr nz, is_Tree
   5B52 21 31 40      [10]  284 		ld hl, #_sprite_numbers_02
   5B55 C9            [10]  285 		ret
                            286 
   5B56                     287 	is_Tree:
   5B56 FE 03         [ 7]  288 	cp #3
   5B58 20 04         [12]  289 	jr nz, is_Four
   5B5A 21 46 40      [10]  290 		ld hl, #_sprite_numbers_03
   5B5D C9            [10]  291 		ret
                            292 
   5B5E                     293 	is_Four:
   5B5E FE 04         [ 7]  294 	cp #4
   5B60 20 04         [12]  295 	jr nz, is_Five
   5B62 21 5B 40      [10]  296 		ld hl, #_sprite_numbers_04
   5B65 C9            [10]  297 		ret
                            298 
   5B66                     299 	is_Five:
   5B66 FE 05         [ 7]  300 	cp #5
   5B68 20 04         [12]  301 	jr nz, is_Six
   5B6A 21 70 40      [10]  302 		ld hl, #_sprite_numbers_05
   5B6D C9            [10]  303 		ret
                            304 
   5B6E                     305 	is_Six:
   5B6E FE 06         [ 7]  306 	cp #6
   5B70 20 04         [12]  307 	jr nz, is_Seven
   5B72 21 85 40      [10]  308 		ld hl, #_sprite_numbers_06
   5B75 C9            [10]  309 		ret
                            310 
   5B76                     311 	is_Seven:
   5B76 FE 07         [ 7]  312 	cp #7
   5B78 20 04         [12]  313 	jr nz, is_Eight
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   5B7A 21 9A 40      [10]  314 		ld hl, #_sprite_numbers_07
   5B7D C9            [10]  315 		ret
                            316 
   5B7E                     317 	is_Eight:
   5B7E FE 08         [ 7]  318 	cp #8
   5B80 20 04         [12]  319 	jr nz, is_Nine
   5B82 21 AF 40      [10]  320 		ld hl, #_sprite_numbers_08
   5B85 C9            [10]  321 		ret
                            322 
   5B86                     323 	is_Nine:
   5B86 21 C4 40      [10]  324 		ld hl, #_sprite_numbers_09
   5B89 C9            [10]  325 		ret
                            326 
   5B8A C9            [10]  327 	ret
                            328 
                            329 ;; ===================================
                            330 ;; Draws a number
                            331 ;; Entrada:
                            332 ;;	HL <= Pointer to number sprite
                            333 ;;	DE <= Pointer to video memory
                            334 ;; Modifica AF, BC, DE, HL
                            335 ;; ===================================
   5B8B                     336 drawNumber::
   5B8B 06 07         [ 7]  337 	ld 	b, #number_h 		;; B = ent height
   5B8D 0E 03         [ 7]  338 	ld 	c, #number_w 		;; C = ent width
   5B8F CD 26 66      [17]  339 	call cpct_drawSprite_asm
                            340 
   5B92 C9            [10]  341 	ret
                            342 
   5B93                     343 drawTimeCounters:
   5B93 3A EC 5A      [13]  344 		ld a, (videoPtr + 1)
   5B96 FE 80         [ 7]  345 		cp #0x80
   5B98 28 26         [12]  346 		jr z, paintOn8000
                            347 			;; Painting on C000
   5B9A 3A DB 5A      [13]  348 			ld a, (game_minute)
   5B9D CD 3E 5B      [17]  349 			call decideNumber	;; HL <= sprite pointer
   5BA0 11 25 E0      [10]  350 			ld de,	#minSpPointer
   5BA3 CD 8B 5B      [17]  351 			call drawNumber
                            352 
   5BA6 3A DC 5A      [13]  353 			ld a, (game_secLeft)
   5BA9 CD 3E 5B      [17]  354 			call decideNumber	;; HL <= sprite pointer
   5BAC 11 29 E0      [10]  355 			ld de,	#secLeftSpPointer
   5BAF CD 8B 5B      [17]  356 			call drawNumber
                            357 
   5BB2 3A DD 5A      [13]  358 			ld a, (game_secRight)
   5BB5 CD 3E 5B      [17]  359 			call decideNumber	;; HL <= sprite pointer
   5BB8 11 2C E0      [10]  360 			ld de,	#secRightSpPointer
   5BBB CD 8B 5B      [17]  361 			call drawNumber
                            362 
   5BBE 18 24         [12]  363 		jr drawTimeCounters_exit
                            364 
   5BC0                     365 		paintOn8000:
   5BC0 3A DB 5A      [13]  366 			ld a, (game_minute)
   5BC3 CD 3E 5B      [17]  367 			call decideNumber	;; HL <= sprite pointer
   5BC6 11 25 A0      [10]  368 			ld de,	#minSpPointer2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   5BC9 CD 8B 5B      [17]  369 			call drawNumber
                            370 
   5BCC 3A DC 5A      [13]  371 			ld a, (game_secLeft)
   5BCF CD 3E 5B      [17]  372 			call decideNumber	;; HL <= sprite pointer
   5BD2 11 29 A0      [10]  373 			ld de,	#secLeftSpPointer2
   5BD5 CD 8B 5B      [17]  374 			call drawNumber
                            375 
   5BD8 3A DD 5A      [13]  376 			ld a, (game_secRight)
   5BDB CD 3E 5B      [17]  377 			call decideNumber	;; HL <= sprite pointer
   5BDE 11 2C A0      [10]  378 			ld de,	#secRightSpPointer2
   5BE1 CD 8B 5B      [17]  379 			call drawNumber
                            380 
   5BE4                     381 		drawTimeCounters_exit:
   5BE4 C9            [10]  382 		ret
                            383 
   5BE5                     384 updateTime::
   5BE5 3A DC 5A      [13]  385 	ld a, (game_secLeft)
   5BE8 FE 00         [ 7]  386 	cp #0
   5BEA 20 1A         [12]  387 	jr nz, checkRightsec
                            388 
   5BEC 3A DD 5A      [13]  389 	ld a, (game_secRight)
   5BEF FE 00         [ 7]  390 	cp #0
   5BF1 20 28         [12]  391 	jr nz, decRightsec
   5BF3 3A DB 5A      [13]  392 		ld a, (game_minute) 
   5BF6 3D            [ 4]  393 		dec a ;; min--
   5BF7 32 DB 5A      [13]  394 		ld (game_minute), a
                            395 
   5BFA 3E 05         [ 7]  396 		ld a, #5
   5BFC 32 DC 5A      [13]  397 		ld (game_secLeft), a ;; secLeft = 5
                            398 
   5BFF 3E 09         [ 7]  399 		ld a, #9
   5C01 32 DD 5A      [13]  400 		ld (game_secRight), a ;; secRight = 9;
                            401 
   5C04 18 1C         [12]  402 		jr continue
   5C06                     403 	checkRightsec:
   5C06 3A DD 5A      [13]  404 		ld a, (game_secRight)
   5C09 FE 00         [ 7]  405 		cp #0
   5C0B 20 0E         [12]  406 		jr nz, decRightsec
   5C0D 3A DC 5A      [13]  407 			ld a, (game_secLeft) 
   5C10 3D            [ 4]  408 			dec a ;; secLeft--
   5C11 32 DC 5A      [13]  409 			ld (game_secLeft), a
                            410 
   5C14 3E 09         [ 7]  411 			ld a, #9 ;; secRight = 9;
   5C16 32 DD 5A      [13]  412 			ld (game_secRight), a
   5C19 18 07         [12]  413 			jr continue
   5C1B                     414 	decRightsec:
   5C1B 3A DD 5A      [13]  415 		ld a, (game_secRight)
   5C1E 3D            [ 4]  416 		dec a ;; secRight--
   5C1F 32 DD 5A      [13]  417 		ld (game_secRight), a
                            418 
   5C22                     419 	continue:
   5C22 C9            [10]  420 	ret
                            421 
   5C23                     422 emptyHandler:
   5C23 C9            [10]  423 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            424 
   5C24                     425 handlerTime::
   5C24 2A E6 5A      [16]  426 	ld 	hl, (game_interrTime)
   5C27 2B            [ 6]  427 	dec hl
   5C28 7C            [ 4]  428 	ld 	a, h
   5C29 FE 00         [ 7]  429 	cp 	#0
   5C2B 20 0B         [12]  430 	jr 	nz, time_iterate
   5C2D 7D            [ 4]  431 	ld 	a, l
   5C2E FE 00         [ 7]  432 	cp 	#0
   5C30 20 06         [12]  433 	jr 	nz, time_iterate
                            434 		;; interrTime == 0
   5C32 21 2C 01      [10]  435 		ld hl, #0x012C		;; HL <= 300
   5C35 CD E5 5B      [17]  436 		call updateTime
                            437 
   5C38                     438 	time_iterate:
   5C38 22 E6 5A      [16]  439 		ld (game_interrTime), hl
   5C3B C9            [10]  440 	ret
                            441 
   5C3C                     442 handlerMusic:
   5C3C C9            [10]  443 	ret
                            444 
   5C3D                     445 handlerTimeMusic:
   5C3D CD 24 5C      [17]  446 	call handlerTime
   5C40 CD 3C 5C      [17]  447 	call handlerMusic
   5C43 C9            [10]  448 	ret
                            449 
   5C44                     450 configureMatch:
   5C44 3A DB 5A      [13]  451 	ld a, (game_minute) 		;; a <- game_minute
   5C47 FE 00         [ 7]  452 	cp #0						;; a - 0
   5C49 20 0F         [12]  453 	jr nz, ISR_timeOn			;; if (game_enableTime - 0) == 1, then jump ISR_timeOn
                            454 	;; Time Off
   5C4B 3A EA 5A      [13]  455 	ld a, (game_enableMusic) 	;; a <- game_enableMusic
   5C4E FE 00         [ 7]  456 	cp #0						;; a - 0
   5C50 20 15         [12]  457 	jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
                            458 	;; Time Off, Music Off
   5C52 21 23 5C      [10]  459 	ld hl, #emptyHandler
   5C55 CD 28 5D      [17]  460 	call cpct_setInterruptHandler_asm
                            461 
   5C58 18 0D         [12]  462 	jr configureMatch_exit
                            463 
   5C5A                     464 	ISR_timeOn:
                            465 		;; Time On
   5C5A 3A EA 5A      [13]  466 		ld a, (game_enableMusic)	;; a <- game_enableMusic
   5C5D FE 00         [ 7]  467 		cp #0
   5C5F 20 06         [12]  468 		jr nz, ISR_timeOn_musicOn
                            469 		;; Time On, Music Off
   5C61 21 24 5C      [10]  470 		ld hl, #handlerTime
   5C64 CD 28 5D      [17]  471 		call cpct_setInterruptHandler_asm
                            472 
   5C67                     473 	ISR_timeOff_musicOn:
                            474 
   5C67                     475 	ISR_timeOn_musicOn:
                            476 
   5C67                     477 	configureMatch_exit:
   5C67 C9            [10]  478 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                            479 
                            480 ;; ========================
                            481 ;; Initialize game
                            482 ;; ========================
   5C68                     483 initializeGame:
                            484 
                            485 	;; Set video mode
   5C68 0E 00         [ 7]  486 	ld 	c, #0
   5C6A CD C6 67      [17]  487 	call cpct_setVideoMode_asm
                            488 
                            489 	;; Set palette
   5C6D 21 21 42      [10]  490 	ld 	hl, #_sprite_palette
   5C70 11 10 00      [10]  491 	ld 	de, #16
   5C73 CD 9D 5D      [17]  492 	call cpct_setPalette_asm
                            493 
                            494 	;; Clean from 8000 to FFFF
   5C76 21 00 80      [10]  495 	ld	hl, #0x8000			;; HL <= Copy pointer
   5C79 11 01 80      [10]  496 	ld	de, #0x8001			;; DE <= Write pointer
   5C7C 36 00         [10]  497 	ld	(hl), #00			;; Set to 0 where HL points
   5C7E 01 00 80      [10]  498 	ld	bc, #0x8000			;; BC <= Times to repeat
   5C81 ED B0         [21]  499 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            500 
   5C83 21 D9 5A      [10]  501 	ld	hl, #game_t1Score
   5C86 36 00         [10]  502 	ld 	(hl), #0
   5C88 21 DA 5A      [10]  503 	ld	hl, #game_t2Score
   5C8B 36 00         [10]  504 	ld 	(hl), #0		;; Initialize points to 0
                            505 
                            506 	
   5C8D C9            [10]  507 	ret
                            508 
                            509 
                            510 ;; ========================
                            511 ;; Switch Buffers
                            512 ;; ========================
   5C8E                     513 switchBuffers:
                     0230   514 	mem_page = .+1
   5C8E 2E 20         [ 7]  515 	ld 	l, #0x20
   5C90 CD B5 67      [17]  516 	call 	cpct_setVideoMemoryPage_asm
   5C93 21 8F 5C      [10]  517 	ld 	hl, #mem_page
   5C96 3E 10         [ 7]  518 	ld	a, #0x10
   5C98 AE            [ 7]  519 	xor	(hl)
   5C99 77            [ 7]  520 	ld	(hl), a
                            521 
   5C9A 21 EC 5A      [10]  522 	ld	hl, #videoPtr+1
   5C9D 3E 40         [ 7]  523 	ld	a, #0x40
   5C9F AE            [ 7]  524 	xor	(hl)
   5CA0 77            [ 7]  525 	ld	(hl), a
                            526 
                            527 
   5CA1 C9            [10]  528 	ret
                            529 
                            530 ;; ============================
                            531 ;; Game loop until end of game
                            532 ;; ============================
   5CA2                     533 game_loop_Player_IA:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            534 
                            535 	;; Erase
   5CA2 DD 21 69 5A   [14]  536 	ld ix, #player_data
   5CA6 CD 41 4B      [17]  537 	call entityErase
                            538 
   5CA9 DD 21 84 5A   [14]  539 	ld ix, #enemy_data
   5CAD CD 41 4B      [17]  540 	call entityErase
                            541 
   5CB0 DD 21 62 4D   [14]  542 	ld ix, #frisbee_data
   5CB4 CD 41 4B      [17]  543 	call entityErase
                            544 
                            545 	;; Update
   5CB7 DD 21 69 5A   [14]  546 	ld ix, #player_data
   5CBB CD DE 4E      [17]  547 	call player_update
                            548 
   5CBE DD 21 84 5A   [14]  549 	ld ix, #enemy_data
   5CC2 CD DE 4E      [17]  550 	call player_update
                            551 
   5CC5 DD 21 62 4D   [14]  552 	ld ix, #frisbee_data
   5CC9 CD 0F 4E      [17]  553 	call frisbee_update
                            554 
                            555 	;; Draw
   5CCC DD 21 69 5A   [14]  556 	ld ix, #player_data
   5CD0 CD 0C 4B      [17]  557 	call entityDraw
                            558 
   5CD3 DD 21 84 5A   [14]  559 	ld ix, #enemy_data
   5CD7 CD 0C 4B      [17]  560 	call entityDraw
                            561 
   5CDA DD 21 62 4D   [14]  562 	ld ix, #frisbee_data
   5CDE CD 0C 4B      [17]  563 	call entityDraw
                            564 
   5CE1 CD 93 5B      [17]  565 	call drawTimeCounters
                            566 
                            567 	;; Check goal
   5CE4 DD 21 62 4D   [14]  568 	ld	ix, #frisbee_data
   5CE8 CD 83 4E      [17]  569 	call frisbee_checkGoal
                            570 
                            571 	;; Wait VSYNC to modify VMEM without blinking
   5CEB CD BE 67      [17]  572 	call cpct_waitVSYNC_asm
   5CEE CD 8E 5C      [17]  573 	call switchBuffers
                            574 
   5CF1 3A D7 5A      [13]  575 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   5CF4 FE 00         [ 7]  576 	cp #0  				      ;; a - 0
   5CF6 28 02         [12]  577 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   5CF8 18 17         [12]  578 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            579 
   5CFA                     580 	timeWinning:
   5CFA 3A DB 5A      [13]  581 		ld a, (game_minute) ;; a <- game_minute
   5CFD FE 00         [ 7]  582 		cp #0 				;; a - 0
   5CFF 20 A1         [12]  583 		jr nz, game_loop_Player_IA 	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            584 
   5D01 3A DC 5A      [13]  585 		ld a, (game_secLeft)	;; a <- game_secLeft
   5D04 FE 00         [ 7]  586 		cp #0 				  	;; a - 0
   5D06 20 9A         [12]  587 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            588 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   5D08 3A DD 5A      [13]  589 		ld a, (game_secRight)	;; a <- game_secRight
   5D0B FE 00         [ 7]  590 		cp #0 				  	;; a - 0
   5D0D 20 93         [12]  591 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
   5D0F 18 16         [12]  592 		jr game_loop_Player_IA_exit
                            593 
   5D11                     594 	scoreEnd:
   5D11 3A D9 5A      [13]  595 		ld a, (game_t1Score) 
   5D14 47            [ 4]  596 		ld b, a               ;; b <- LocalScore
   5D15 3A D8 5A      [13]  597 		ld a, (game_maxScore) ;; a <- maxScore
   5D18 B8            [ 4]  598 		cp b             	  ;; a - b 
   5D19 28 0C         [12]  599 		jr z, game_loop_Player_IA_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            600 
   5D1B 4F            [ 4]  601 		ld c, a      	      ;; c <- maxScore
   5D1C 3A DA 5A      [13]  602 		ld a, (game_t2Score)
   5D1F 47            [ 4]  603 		ld b, a               ;; b <- VisitantScore
   5D20 79            [ 4]  604 		ld a, c 			  ;; a <- c
   5D21 B8            [ 4]  605 		cp b             	  ;; a - b 
   5D22 28 03         [12]  606 		jr z, game_loop_Player_IA_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   5D24 C3 A2 5C      [10]  607 			jp game_loop_Player_IA ;; Keep Playing
                            608 
   5D27                     609 game_loop_Player_IA_exit:
   5D27 C9            [10]  610 	ret
