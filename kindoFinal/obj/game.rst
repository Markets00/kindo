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
                             24 .globl cpct_etm_setTileset2x4_asm
                             25 .globl cpct_etm_drawTileBox2x4_asm
                             26 .globl cpct_etm_drawTilemap2x4_f_asm
                             27 .globl cpct_drawSpriteMaskedAlignedTable_asm
                             28 .globl cpct_drawSpriteMasked_asm
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 	
                             10 ;; ====================================
                             11 ;; ====================================
                             12 ;; PUBLIC DATA
                             13 ;; ====================================
                             14 ;; ====================================
                             15 
   4D55 4B                   16 paletteM2::	.db #0x4B	;; White
   4D56 54                   17 			.db #0x54	;; Black
                             18 
   4D57 4C                   19 paletteM1::	.db #0x4C	;; Red
   4D58 40                   20 			.db #0x40	;; Grey
   4D59 4B                   21 			.db #0x4B	;; White
   4D5A 54                   22 			.db #0x54	;; Black
                             23 
   4D5B 54                   24 blackPaletteM1::	.db #0x54	;; Black
   4D5C 54                   25 					.db #0x54	;; Black
   4D5D 54                   26 					.db #0x54	;; Black
   4D5E 54                   27 					.db #0x54	;; Black
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
   4D5F                      51 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 		#1
   000A                       1 	player_data::
   4D5F 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   4D61 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   4D63 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   4D64 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   4D65 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   4D67 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4D69 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4D6B 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   4D6D 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   4D6F 1E                   11 		player_last_x:	.db #30		;; Last x rendered		(8 bits)
   4D70 1E                   12 		player_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4D71 1E                   13 		player_last_y:	.db #30		;; Last y rendered		(8 bits)
   4D72 1E                   14 		player_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4D73 00                   15 		player_state:	.db #0		;; Entity animation state	(8 bits)
   4D74 00                   16 		player_lastState:.db #0		;; Last entity animation state	(8 bits)
   4D75 FF                   17 		player_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4D76 00                   18 		player_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4D77 ED 3D                19 		player_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   4D79 01                   20 		player_id:	.db #1		;; Numeric ID			(8 bits)
   4D7A                      52 defineEntity enemy, #0x0050-0x000A, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#2
   0025                       1 	enemy_data::
   4D7A 46 00                 2 		enemy_x:	.dw #0x0050-0x000A		;; X coordinate			(16 bits)
   4D7C 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   4D7E 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   4D7F 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   4D80 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   4D82 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4D84 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4D86 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   4D88 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   4D8A 1E                   11 		enemy_last_x:	.db #30		;; Last x rendered		(8 bits)
   4D8B 1E                   12 		enemy_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
   4D8C 1E                   13 		enemy_last_y:	.db #30		;; Last y rendered		(8 bits)
   4D8D 1E                   14 		enemy_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4D8E 00                   15 		enemy_state:	.db #0		;; Entity animation state	(8 bits)
   4D8F 00                   16 		enemy_lastState:.db #0		;; Last entity animation state	(8 bits)
   4D90 FF                   17 		enemy_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4D91 00                   18 		enemy_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4D92 F1 3D                19 		enemy_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   4D94 02                   20 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             53 
   4D95                      54 defineEntity player2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_1_sprites, 	#3
   0040                       1 	player2_data::
   4D95 10 00                 2 		player2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   4D97 50 00                 3 		player2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   4D99 14                    4 		player2_h:	.db #20		;; Height			(8 bits)
   4D9A 05                    5 		player2_w:	.db #5		;; Width			(8 bits)
   4D9B 00 00                 6 		player2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   4D9D 00 00                 7 		player2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4D9F 00 00                 8 		player2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4DA1 00 00                 9 		player2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   4DA3 00 18                10 		player2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   4DA5 1E                   11 		player2_last_x:	.db #30		;; Last x rendered		(8 bits)
   4DA6 1E                   12 		player2_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
   4DA7 1E                   13 		player2_last_y:	.db #30		;; Last y rendered		(8 bits)
   4DA8 1E                   14 		player2_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4DA9 00                   15 		player2_state:	.db #0		;; Entity animation state	(8 bits)
   4DAA 00                   16 		player2_lastState:.db #0		;; Last entity animation state	(8 bits)
   4DAB FF                   17 		player2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4DAC 00                   18 		player2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4DAD ED 3D                19 		player2_sprites_ptr: .dw #robot_1_sprites ;; Pointer to sprites	(16 bits)
   4DAF 03                   20 		player2_id:	.db #3		;; Numeric ID			(8 bits)
   4DB0                      55 defineEntity enemy2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #robot_2_sprites, 	#4
   005B                       1 	enemy2_data::
   4DB0 4C 00                 2 		enemy2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   4DB2 64 00                 3 		enemy2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   4DB4 14                    4 		enemy2_h:	.db #20		;; Height			(8 bits)
   4DB5 05                    5 		enemy2_w:	.db #5		;; Width			(8 bits)
   4DB6 00 00                 6 		enemy2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   4DB8 00 00                 7 		enemy2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   4DBA 00 00                 8 		enemy2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   4DBC 00 00                 9 		enemy2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   4DBE 00 18                10 		enemy2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   4DC0 1E                   11 		enemy2_last_x:	.db #30		;; Last x rendered		(8 bits)
   4DC1 1E                   12 		enemy2_erase_x:	.db #30		;; x rendered at same buffer	(8 bits)
   4DC2 1E                   13 		enemy2_last_y:	.db #30		;; Last y rendered		(8 bits)
   4DC3 1E                   14 		enemy2_erase_y:	.db #30		;; y rendered at same buffer	(8 bits)
   4DC4 00                   15 		enemy2_state:	.db #0		;; Entity animation state	(8 bits)
   4DC5 00                   16 		enemy2_lastState:.db #0		;; Last entity animation state	(8 bits)
   4DC6 FF                   17 		enemy2_signal:	.db #-1		;; Signal recived for animations(8 bits)
   4DC7 00                   18 		enemy2_sprite:	.db #0		;; Entity sprite index		(8 bits)
   4DC8 F1 3D                19 		enemy2_sprites_ptr: .dw #robot_2_sprites ;; Pointer to sprites	(16 bits)
   4DCA 04                   20 		enemy2_id:	.db #4		;; Numeric ID			(8 bits)
                             56 
   4DCB                      57 game_data::
   4DCB 00                   58 	game_type::         .db #0 ;; Game Mode (8 bits)
   4DCC 00                   59    	game_numPlayers:    .db #0 ;; Players who are going to play
   4DCD 00                   60    	game_WinCondition:  .db #0 ;; Win condition 0-> Time, 1 -> Score
                             61 
   4DCE 0A                   62 	game_maxScore:      .db #10 ;; Max score of a match (to win)
   4DCF 00                   63 	game_t1Score:       .db #0 ;; Points of team 1		(8 bits)
   4DD0 00                   64 	game_t2Score:       .db #0 ;; Points of team 2		(8 bits)
                             65 
   4DD1 02                   66 	game_minute:		.db #2 ;; Actual minute. Also Controles if we whant to play with time
   4DD2 00                   67 	game_secLeft:		.db #0 ;; Both variables to control the seconds
   4DD3 00                   68 	game_secRight:		.db #0 ;; Both variables to control the seconds
   4DD4 00 00                69 	game_maxTime:       .dw #0x0000 ;; Max time of a match
   4DD6 00 00                70 	game_map:           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             71 
   4DD8 00                   72 	game_musicOptions:  .db #0 ;; Controles if we whant to play music on options
   4DD9 00                   73 	game_timeOptions:   .db #0 ;; Controles if we whant to play with time on options
                             74 
   4DDA 00 00                75 	game_interrMusic:   .dw #0 ;; Interruption counter for music handler	(16 bits)
   4DDC 2C 01                76 	game_interrTime:	.dw #0x012C ;; Interruption counter for time handler	(16 bits)
   4DDE 00                   77 	game_musicPlayer:   .db #0 ;; Controles the music player
   4DDF 00                   78 	game_musicEffects:  .db #0 ;; Controles the effects on the match
                             79 
   4DE0 00                   80 	game_enableMusic:	.db #0 ;; Controles if we whant some music
                             81 
                             82 	;; ÑORDBUGER 0f89
                             83 
                             84 	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
                             85 	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
                             86 	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
                             87 	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
                             88 ;; 
                             89 
                             90 
                             91 ;; ====================================
                             92 ;; ====================================
                             93 ;; PRIVATE DATA
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             94 ;; ====================================
                             95 ;; ====================================
                             96 
                     0050    97 .equ RIGHT_LIMIT,	80
                     0000    98 .equ LEFT_LIMIT,	0
                     0020    99 .equ TOP_LIMIT,	 	32
                     00C8   100 .equ BOTTOM_LIMIT,	200
                     0028   101 .equ CENTER_LIMIT,	40
                            102 
                     E025   103 .equ minSpPointer, 0xE025		;; Pointer to know where to print the score, on both videopointers.
                     A025   104 .equ minSpPointer2, 0xA025
                     E029   105 .equ secLeftSpPointer, 0xE029
                     A029   106 .equ secLeftSpPointer2, 0xA029
                     E02C   107 .equ secRightSpPointer, 0xE02C
                     A02C   108 .equ secRightSpPointer2, 0xA02C
                            109 
   4DE1 00 80               110 videoPtr:	.dw 0x8000
                            111 
                     002A   112 .equ map_tH, 42
                     0028   113 .equ map_tW, 40
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
   4DE3                     126 gameStart::
                            127 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            128 	;; Reading game data example
                            129 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            130 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                            131 	;;
                            132 	;;	ld 	h, Game_map_L(ix)
                            133 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                            134 	;;
                            135 	;;	ld 	h, Game_time_H(ix)
                            136 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                            137 	
                            138 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                            139 	;; Modifying game data example
                            140 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            141 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                            142 	;;
                            143 	;;	ld 	Game_map_L(ix), #0
                            144 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                            145 	;;
                            146 	;;	ld 	Game_time_H(ix), #0
                            147 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                            148 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            149 
   4DE3 CD 68 4F      [17]  150 	call 	initializeGame
                            151 	;; Configuration staff...
                            152 	;; Configuration staff...
                            153 	;; Configuration staff...
                            154 	;; Configurating the handler
                            155 	;; Prepartida
   4DE6 CD 44 4F      [17]  156 	call 	configureMatch
   4DE9 CD D0 4F      [17]  157 	call 	game_loop_Player_IA
                            158 
   4DEC 3A D0 4D      [13]  159 	ld 	a, (game_t2Score)
   4DEF 47            [ 4]  160 	ld 	b, a
                            161 
   4DF0 3A CF 4D      [13]  162 	ld 	a, (game_t1Score)
   4DF3 B8            [ 4]  163 	cp 	b
   4DF4 FA F7 4D      [10]  164 	jp 	m, t2_win
                            165 		;; t1 win
                            166 
   4DF7                     167 	t2_win:
                            168 
                            169 
   4DF7 C9            [10]  170 	ret
                            171 
                            172 ;; ==================================
                            173 ;; Devuelve el puntero a video en HL
                            174 ;; Devuelve:
                            175 ;;	HL => Pointer to video memory
                            176 ;; ==================================
   4DF8                     177 getVideoPtr::
   4DF8 2A E1 4D      [16]  178 	ld	hl, (videoPtr)
   4DFB C9            [10]  179 	ret
                            180 
                            181 ;; ==================================
                            182 ;; Incrementa los puntos del equipo 1
                            183 ;; Modifica: A, B
                            184 ;; ==================================
   4DFC                     185 incTeam1Points::
   4DFC 3A CE 4D      [13]  186 	ld	a, (game_maxScore)
   4DFF 47            [ 4]  187 	ld 	b, a				;; B <= Max points
                            188 
   4E00 3A CF 4D      [13]  189 	ld	a, (game_t1Score)
   4E03 3C            [ 4]  190 	inc	a				;; A <= Team 1 points + 1
                            191 
   4E04 32 CF 4D      [13]  192 	ld	(game_t1Score), a	;; Inc team 1 points
                            193 
   4E07 C9            [10]  194 		ret
                            195 
                            196 ;; ================================== 
                            197 ;; Incrementa los puntos del equipo 2
                            198 ;; Modifica: A, B
                            199 ;; ==================================
   4E08                     200 incTeam2Points::
   4E08 3A CE 4D      [13]  201 	ld	a, (game_maxScore)
   4E0B 47            [ 4]  202 	ld 	b, a				;; B <= Max points
                            203 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   4E0C 3A D0 4D      [13]  204 	ld	a, (game_t2Score)
   4E0F 3C            [ 4]  205 	inc	a				;; A <= Team 2 points + 1
                            206 
   4E10 32 D0 4D      [13]  207 	ld	(game_t2Score), a	;; Inc team 2 points
                            208 
                            209 	;;cp 	b
                            210 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            211 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            212 
   4E13 C9            [10]  213 		ret
                            214 
                            215 ;; alomejor es una función privada
   4E14                     216 play_music:
   4E14 D9            [ 4]  217 	exx
   4E15 08            [ 4]  218 	ex af', af
   4E16 F5            [11]  219 	push af
   4E17 C5            [11]  220 	push bc
   4E18 D5            [11]  221 	push de
   4E19 E5            [11]  222 	push hl
                            223 
   4E1A CD EA 50      [17]  224 	call cpct_akp_musicPlay_asm
                            225 
   4E1D E1            [10]  226 	pop hl
   4E1E D1            [10]  227 	pop de
   4E1F C1            [10]  228 	pop bc
   4E20 F1            [10]  229 	pop af
   4E21 08            [ 4]  230 	ex af', af
   4E22 D9            [ 4]  231 	exx
                            232 
   4E23 C9            [10]  233 	ret
                            234 
                            235 ;; alomejor es una función privada
   4E24                     236 stop_music:
   4E24 D9            [ 4]  237 	exx
   4E25 08            [ 4]  238 	ex af', af
   4E26 F5            [11]  239 	push af
   4E27 C5            [11]  240 	push bc
   4E28 D5            [11]  241 	push de
   4E29 E5            [11]  242 	push hl
                            243 
   4E2A CD 4D 58      [17]  244 	call cpct_akp_stop_asm
                            245 
   4E2D E1            [10]  246 	pop hl
   4E2E D1            [10]  247 	pop de
   4E2F C1            [10]  248 	pop bc
   4E30 F1            [10]  249 	pop af
   4E31 08            [ 4]  250 	ex af', af
   4E32 D9            [ 4]  251 	exx
                            252 
   4E33 C9            [10]  253 	ret
                            254 
                            255 
                            256 ;; ====================================
                            257 ;; ====================================
                            258 ;; PRIVATE FUNCTIONS
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            259 ;; ====================================
                            260 ;; ====================================
                            261 
                            262 ;; ====================================
                            263 ;; ====================================
                            264 ;; Decide what number must charge
                            265 ;; a -> Number
                            266 ;; hl <- Sprite to print
                            267 ;; ====================================
                            268 ;; ====================================
   4E34                     269 decideNumber::
   4E34 FE 00         [ 7]  270 	cp #0
   4E36 20 04         [12]  271 	jr nz, is_One
                            272 		;; if
   4E38 21 12 30      [10]  273 		ld hl, #_sprite_numbers_00
   4E3B C9            [10]  274 		ret
                            275 
   4E3C                     276 	is_One:
   4E3C FE 01         [ 7]  277 	cp #1
   4E3E 20 04         [12]  278 	jr nz, is_Two
   4E40 21 3C 30      [10]  279 		ld hl, #_sprite_numbers_01
   4E43 C9            [10]  280 		ret
                            281 
   4E44                     282 	is_Two:
   4E44 FE 02         [ 7]  283 	cp #2
   4E46 20 04         [12]  284 	jr nz, is_Tree
   4E48 21 66 30      [10]  285 		ld hl, #_sprite_numbers_02
   4E4B C9            [10]  286 		ret
                            287 
   4E4C                     288 	is_Tree:
   4E4C FE 03         [ 7]  289 	cp #3
   4E4E 20 04         [12]  290 	jr nz, is_Four
   4E50 21 90 30      [10]  291 		ld hl, #_sprite_numbers_03
   4E53 C9            [10]  292 		ret
                            293 
   4E54                     294 	is_Four:
   4E54 FE 04         [ 7]  295 	cp #4
   4E56 20 04         [12]  296 	jr nz, is_Five
   4E58 21 BA 30      [10]  297 		ld hl, #_sprite_numbers_04
   4E5B C9            [10]  298 		ret
                            299 
   4E5C                     300 	is_Five:
   4E5C FE 05         [ 7]  301 	cp #5
   4E5E 20 04         [12]  302 	jr nz, is_Six
   4E60 21 E4 30      [10]  303 		ld hl, #_sprite_numbers_05
   4E63 C9            [10]  304 		ret
                            305 
   4E64                     306 	is_Six:
   4E64 FE 06         [ 7]  307 	cp #6
   4E66 20 04         [12]  308 	jr nz, is_Seven
   4E68 21 0E 31      [10]  309 		ld hl, #_sprite_numbers_06
   4E6B C9            [10]  310 		ret
                            311 
   4E6C                     312 	is_Seven:
   4E6C FE 07         [ 7]  313 	cp #7
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   4E6E 20 04         [12]  314 	jr nz, is_Eight
   4E70 21 38 31      [10]  315 		ld hl, #_sprite_numbers_07
   4E73 C9            [10]  316 		ret
                            317 
   4E74                     318 	is_Eight:
   4E74 FE 08         [ 7]  319 	cp #8
   4E76 20 04         [12]  320 	jr nz, is_Nine
   4E78 21 62 31      [10]  321 		ld hl, #_sprite_numbers_08
   4E7B C9            [10]  322 		ret
                            323 
   4E7C                     324 	is_Nine:
   4E7C 21 8C 31      [10]  325 		ld hl, #_sprite_numbers_09
   4E7F C9            [10]  326 		ret
                            327 
   4E80 C9            [10]  328 	ret
                            329 
                            330 ;; ===================================
                            331 ;; Draws a number
                            332 ;; Entrada:
                            333 ;;	HL <= Pointer to number sprite
                            334 ;;	DE <= Pointer to video memory
                            335 ;; Modifica AF, BC, DE, HL
                            336 ;; ===================================
   4E81                     337 drawNumber::
   4E81 06 07         [ 7]  338 	ld 	b, #number_h 		;; B = ent height
   4E83 0E 03         [ 7]  339 	ld 	c, #number_w 		;; C = ent width
   4E85 CD 54 59      [17]  340 	call cpct_drawSprite_asm
                            341 
   4E88 C9            [10]  342 	ret
                            343 
   4E89                     344 drawTimeCounters:
   4E89 3A E2 4D      [13]  345 		ld a, (videoPtr + 1)
   4E8C FE 80         [ 7]  346 		cp #0x80
   4E8E 28 26         [12]  347 		jr z, paintOn8000
                            348 			;; Painting on C000
   4E90 3A D1 4D      [13]  349 			ld a, (game_minute)
   4E93 CD 34 4E      [17]  350 			call decideNumber	;; HL <= sprite pointer
   4E96 11 25 E0      [10]  351 			ld de,	#minSpPointer
   4E99 CD 81 4E      [17]  352 			call drawNumber
                            353 
   4E9C 3A D2 4D      [13]  354 			ld a, (game_secLeft)
   4E9F CD 34 4E      [17]  355 			call decideNumber	;; HL <= sprite pointer
   4EA2 11 29 E0      [10]  356 			ld de,	#secLeftSpPointer
   4EA5 CD 81 4E      [17]  357 			call drawNumber
                            358 
   4EA8 3A D3 4D      [13]  359 			ld a, (game_secRight)
   4EAB CD 34 4E      [17]  360 			call decideNumber	;; HL <= sprite pointer
   4EAE 11 2C E0      [10]  361 			ld de,	#secRightSpPointer
   4EB1 CD 81 4E      [17]  362 			call drawNumber
                            363 
   4EB4 18 24         [12]  364 		jr drawTimeCounters_exit
                            365 
   4EB6                     366 		paintOn8000:
   4EB6 3A D1 4D      [13]  367 			ld a, (game_minute)
   4EB9 CD 34 4E      [17]  368 			call decideNumber	;; HL <= sprite pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   4EBC 11 25 A0      [10]  369 			ld de,	#minSpPointer2
   4EBF CD 81 4E      [17]  370 			call drawNumber
                            371 
   4EC2 3A D2 4D      [13]  372 			ld a, (game_secLeft)
   4EC5 CD 34 4E      [17]  373 			call decideNumber	;; HL <= sprite pointer
   4EC8 11 29 A0      [10]  374 			ld de,	#secLeftSpPointer2
   4ECB CD 81 4E      [17]  375 			call drawNumber
                            376 
   4ECE 3A D3 4D      [13]  377 			ld a, (game_secRight)
   4ED1 CD 34 4E      [17]  378 			call decideNumber	;; HL <= sprite pointer
   4ED4 11 2C A0      [10]  379 			ld de,	#secRightSpPointer2
   4ED7 CD 81 4E      [17]  380 			call drawNumber
                            381 
   4EDA                     382 		drawTimeCounters_exit:
   4EDA C9            [10]  383 		ret
                            384 
   4EDB                     385 updateTime::
   4EDB 3A D2 4D      [13]  386 	ld a, (game_secLeft)
   4EDE FE 00         [ 7]  387 	cp #0
   4EE0 20 1A         [12]  388 	jr nz, checkRightsec
                            389 
   4EE2 3A D3 4D      [13]  390 	ld a, (game_secRight)
   4EE5 FE 00         [ 7]  391 	cp #0
   4EE7 20 28         [12]  392 	jr nz, decRightsec
   4EE9 3A D1 4D      [13]  393 		ld a, (game_minute) 
   4EEC 3D            [ 4]  394 		dec a ;; min--
   4EED 32 D1 4D      [13]  395 		ld (game_minute), a
                            396 
   4EF0 3E 05         [ 7]  397 		ld a, #5
   4EF2 32 D2 4D      [13]  398 		ld (game_secLeft), a ;; secLeft = 5
                            399 
   4EF5 3E 09         [ 7]  400 		ld a, #9
   4EF7 32 D3 4D      [13]  401 		ld (game_secRight), a ;; secRight = 9;
                            402 
   4EFA 18 1C         [12]  403 		jr continue
   4EFC                     404 	checkRightsec:
   4EFC 3A D3 4D      [13]  405 		ld a, (game_secRight)
   4EFF FE 00         [ 7]  406 		cp #0
   4F01 20 0E         [12]  407 		jr nz, decRightsec
   4F03 3A D2 4D      [13]  408 			ld a, (game_secLeft) 
   4F06 3D            [ 4]  409 			dec a ;; secLeft--
   4F07 32 D2 4D      [13]  410 			ld (game_secLeft), a
                            411 
   4F0A 3E 09         [ 7]  412 			ld a, #9 ;; secRight = 9;
   4F0C 32 D3 4D      [13]  413 			ld (game_secRight), a
   4F0F 18 07         [12]  414 			jr continue
   4F11                     415 	decRightsec:
   4F11 3A D3 4D      [13]  416 		ld a, (game_secRight)
   4F14 3D            [ 4]  417 		dec a ;; secRight--
   4F15 32 D3 4D      [13]  418 		ld (game_secRight), a
                            419 
   4F18                     420 	continue:
   4F18 C9            [10]  421 	ret
                            422 
   4F19                     423 emptyHandler:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   4F19 C9            [10]  424 	ret
                            425 
   4F1A                     426 handlerTime::
   4F1A F5            [11]  427 	push af
   4F1B E5            [11]  428 	push hl
   4F1C D9            [ 4]  429 	exx
   4F1D F5            [11]  430 	push af
   4F1E E5            [11]  431 	push hl
                            432 
                            433 
                            434 
                            435 
   4F1F 2A DC 4D      [16]  436 	ld 	hl, (game_interrTime)
   4F22 2B            [ 6]  437 	dec 	hl
   4F23 7C            [ 4]  438 	ld 	a, h
   4F24 FE 00         [ 7]  439 	cp 	#0
   4F26 20 0B         [12]  440 	jr 	nz, time_iterate
   4F28 7D            [ 4]  441 	ld 	a, l
   4F29 FE 00         [ 7]  442 	cp 	#0
   4F2B 20 06         [12]  443 	jr 	nz, time_iterate
                            444 		;; interrTime == 0
   4F2D 21 2C 01      [10]  445 		ld hl, #0x012C		;; HL <= 300
   4F30 CD DB 4E      [17]  446 		call updateTime
                            447 
   4F33                     448 	time_iterate:
   4F33 22 DC 4D      [16]  449 		ld (game_interrTime), hl
                            450 
   4F36 E1            [10]  451 	pop hl
   4F37 F1            [10]  452 	pop af
   4F38 D9            [ 4]  453 	exx
   4F39 E1            [10]  454 	pop hl
   4F3A F1            [10]  455 	pop af
                            456 
   4F3B C9            [10]  457 	ret
                            458 
   4F3C                     459 handlerMusic:
   4F3C C9            [10]  460 	ret
                            461 
   4F3D                     462 handlerTimeMusic:
   4F3D CD 1A 4F      [17]  463 	call handlerTime
   4F40 CD 3C 4F      [17]  464 	call handlerMusic
   4F43 C9            [10]  465 	ret
                            466 
   4F44                     467 configureMatch:
   4F44 3A D1 4D      [13]  468 	ld a, (game_minute) 		;; a <- game_minute
   4F47 FE 00         [ 7]  469 	cp #0						;; a - 0
   4F49 20 0F         [12]  470 	jr nz, ISR_timeOn			;; if (game_enableTime - 0) == 1, then jump ISR_timeOn
                            471 	;; Time Off
   4F4B 3A E0 4D      [13]  472 	ld a, (game_enableMusic) 	;; a <- game_enableMusic
   4F4E FE 00         [ 7]  473 	cp #0						;; a - 0
   4F50 20 15         [12]  474 	jr nz, ISR_timeOff_musicOn	;; if (game_enableMusic - 0) == 1, then jump ISR_timeOff_musicOn
                            475 	;; Time Off, Music Off
   4F52 21 19 4F      [10]  476 	ld hl, #emptyHandler
   4F55 CD 56 50      [17]  477 	call cpct_setInterruptHandler_asm
                            478 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   4F58 18 0D         [12]  479 	jr configureMatch_exit
                            480 
   4F5A                     481 	ISR_timeOn:
                            482 		;; Time On
   4F5A 3A E0 4D      [13]  483 		ld a, (game_enableMusic)	;; a <- game_enableMusic
   4F5D FE 00         [ 7]  484 		cp #0
   4F5F 20 06         [12]  485 		jr nz, ISR_timeOn_musicOn
                            486 		;; Time On, Music Off
   4F61 21 1A 4F      [10]  487 		ld hl, #handlerTime
   4F64 CD 56 50      [17]  488 		call cpct_setInterruptHandler_asm
                            489 
   4F67                     490 	ISR_timeOff_musicOn:
                            491 
   4F67                     492 	ISR_timeOn_musicOn:
                            493 
   4F67                     494 	configureMatch_exit:
   4F67 C9            [10]  495 	ret
                            496 
                            497 ;; ========================
                            498 ;; Initialize game
                            499 ;; ========================
   4F68                     500 initializeGame::
                            501 
                            502 	;; Set video mode
   4F68 0E 00         [ 7]  503 	ld 	c, #0
   4F6A CD F4 5B      [17]  504 	call cpct_setVideoMode_asm
                            505 
                            506 	;; Set palette
   4F6D 21 46 34      [10]  507 	ld 	hl, #_sprite_palette
   4F70 11 10 00      [10]  508 	ld 	de, #16
   4F73 CD CB 50      [17]  509 	call cpct_setPalette_asm
                            510 
                            511 	;; Clean from 8000 to FFFF
   4F76 21 00 80      [10]  512 	ld	hl, #0x8000			;; HL <= Copy pointer
   4F79 11 01 80      [10]  513 	ld	de, #0x8001			;; DE <= Write pointer
   4F7C 36 00         [10]  514 	ld	(hl), #00			;; Set to 0 where HL points
   4F7E 01 00 80      [10]  515 	ld	bc, #0x8000			;; BC <= Times to repeat
   4F81 ED B0         [21]  516 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            517 
   4F83 21 CF 4D      [10]  518 	ld	hl, #game_t1Score
   4F86 36 00         [10]  519 	ld 	(hl), #0
   4F88 21 D0 4D      [10]  520 	ld	hl, #game_t2Score
   4F8B 36 00         [10]  521 	ld 	(hl), #0		;; Initialize points to 0
                            522 
   4F8D 21 90 26      [10]  523 	ld	hl, #_map_tileset
   4F90 CD 7F 5A      [17]  524 	call cpct_etm_setTileset2x4_asm
                            525 
                            526 ;;	;; Print map at second video buffer
                            527 ;;	ld	a, #map_tW
                            528 ;;	ld	c, #map_tH
                            529 ;;	ld	de, #0x8140
                            530 ;;	ld	hl, #_tilemap
                            531 ;;	call cpct_etm_drawTilemap2x4_f_asm
                            532 ;;	;; Print map at first video buffer
                            533 ;;	ld	a, #map_tW
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            534 ;;	ld	c, #map_tH
                            535 ;;	ld	de, #0xC140
                            536 ;;	ld	hl, #_tilemap
                            537 ;;	call cpct_etm_drawTilemap2x4_f_asm
                            538 
                            539 ;;	ld	a, Ent_erase_x(ix)	;; A <= ent_erase_x
                            540 ;;	sra 	a			;; A <= A/2
                            541 ;;	ld	c, a 			;; C <= ent_erase_x/2
                            542 ;;
                            543 ;;	ld	a, Ent_erase_y(ix)	;; A <= ent_erase_y
                            544 ;;	sra 	a			;;
                            545 ;;	sra 	a			;; A <= A/4
                            546 ;;	ld	b, a 			;; B <= ent_erase_y/4
                            547 ;;
                            548 ;;
                            549 ;;	ld	hl, #_tilemap	;; Pointer to tilemap
                            550 ;;	push 	hl
                            551 ;;	call 	getVideoPtr	;; HL <= Video memory pointer
                            552 ;;	push	hl		;; Videomem pointer to draw
                            553 ;;	ld	e, #5
                            554 ;;	ld	d, #5
                            555 ;;	ld	a, #map_tW
                            556 ;;	call cpct_etm_drawTileBox2x4_asm
                            557 
                            558 
                            559 
                            560 	;; Print map at second video buffer
   4F93 21 00 20      [10]  561 	ld	hl, #_tilemap	;; Pointer to tilemap
   4F96 E5            [11]  562 	push 	hl
   4F97 21 00 80      [10]  563 	ld	hl, #0x8000	;; Videomem pointer
   4F9A E5            [11]  564 	push 	hl
   4F9B 01 00 00      [10]  565 	ld	bc, #0x0000	;; Starting tile of the tilemap
   4F9E 1E 28         [ 7]  566 	ld	e, #map_tW
   4FA0 16 2A         [ 7]  567 	ld	d, #map_tH
   4FA2 3E 28         [ 7]  568 	ld	a, #map_tW
   4FA4 CD F4 59      [17]  569 	call 	cpct_etm_drawTileBox2x4_asm
                            570 
                            571 	;; Print map at first video buffer
   4FA7 21 00 20      [10]  572 	ld	hl, #_tilemap	;; Pointer to tilemap
   4FAA E5            [11]  573 	push 	hl
   4FAB 21 00 C0      [10]  574 	ld	hl, #0xC000	;; Videomem pointer
   4FAE E5            [11]  575 	push 	hl
   4FAF 01 00 00      [10]  576 	ld	bc, #0x0000	;; Starting tile of the tilemap
   4FB2 1E 28         [ 7]  577 	ld	e, #map_tW
   4FB4 16 2A         [ 7]  578 	ld	d, #map_tH
   4FB6 3E 28         [ 7]  579 	ld	a, #map_tW
   4FB8 CD F4 59      [17]  580 	call 	cpct_etm_drawTileBox2x4_asm
                            581 
                            582 
                            583 	;; Initialize music
                            584 ;;	ld	de, #_song_pointer
                            585 ;;	call	cpct_akp_musicInit_asm
                            586 	
                            587 
   4FBB C9            [10]  588 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



                            589 
                            590 
                            591 ;; ========================
                            592 ;; Switch Buffers
                            593 ;; ========================
   4FBC                     594 switchBuffers:
                     0268   595 	mem_page = .+1
   4FBC 2E 20         [ 7]  596 	ld 	l, #0x20
   4FBE CD 93 5B      [17]  597 	call 	cpct_setVideoMemoryPage_asm
   4FC1 21 BD 4F      [10]  598 	ld 	hl, #mem_page
   4FC4 3E 10         [ 7]  599 	ld	a, #0x10
   4FC6 AE            [ 7]  600 	xor	(hl)
   4FC7 77            [ 7]  601 	ld	(hl), a
                            602 
   4FC8 21 E2 4D      [10]  603 	ld	hl, #videoPtr+1
   4FCB 3E 40         [ 7]  604 	ld	a, #0x40
   4FCD AE            [ 7]  605 	xor	(hl)
   4FCE 77            [ 7]  606 	ld	(hl), a
                            607 
                            608 
   4FCF C9            [10]  609 	ret
                            610 
                            611 ;; ============================
                            612 ;; Game loop until end of game
                            613 ;; ============================
   4FD0                     614 game_loop_Player_IA:
                            615 
                            616 	;; Erase
   4FD0 DD 21 5F 4D   [14]  617 	ld ix, #player_data
   4FD4 CD 2D 3E      [17]  618 	call entityErase
                            619 
   4FD7 DD 21 7A 4D   [14]  620 	ld ix, #enemy_data
   4FDB CD 2D 3E      [17]  621 	call entityErase
                            622 
   4FDE DD 21 62 40   [14]  623 	ld ix, #frisbee_data
   4FE2 CD 2D 3E      [17]  624 	call entityErase
                            625 
                            626 	;; Update
   4FE5 DD 21 5F 4D   [14]  627 	ld ix, #player_data
   4FE9 CD DE 41      [17]  628 	call player_update
                            629 
   4FEC DD 21 7A 4D   [14]  630 	ld ix, #enemy_data
   4FF0 CD DE 41      [17]  631 	call player_update
                            632 
   4FF3 DD 21 62 40   [14]  633 	ld ix, #frisbee_data
   4FF7 CD 0F 41      [17]  634 	call frisbee_update
                            635 
                            636 	;; Draw
   4FFA DD 21 5F 4D   [14]  637 	ld ix, #player_data
   4FFE CD F9 3D      [17]  638 	call entityDraw
                            639 
   5001 DD 21 7A 4D   [14]  640 	ld ix, #enemy_data
   5005 CD F9 3D      [17]  641 	call entityDraw
                            642 
   5008 DD 21 62 40   [14]  643 	ld ix, #frisbee_data
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



   500C CD F9 3D      [17]  644 	call entityDraw
                            645 
   500F CD 89 4E      [17]  646 	call drawTimeCounters
                            647 
                            648 	;; Check goal
   5012 DD 21 62 40   [14]  649 	ld	ix, #frisbee_data
   5016 CD 83 41      [17]  650 	call frisbee_checkGoal
                            651 
                            652 	;; Wait VSYNC to modify VMEM without blinking
   5019 CD EC 5B      [17]  653 	call cpct_waitVSYNC_asm
   501C CD BC 4F      [17]  654 	call switchBuffers
                            655 
   501F 3A CD 4D      [13]  656 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   5022 FE 00         [ 7]  657 	cp #0  				      ;; a - 0
   5024 28 02         [12]  658 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   5026 18 17         [12]  659 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            660 
   5028                     661 	timeWinning:
   5028 3A D1 4D      [13]  662 		ld a, (game_minute) ;; a <- game_minute
   502B FE 00         [ 7]  663 		cp #0 				;; a - 0
   502D 20 A1         [12]  664 		jr nz, game_loop_Player_IA 	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            665 
   502F 3A D2 4D      [13]  666 		ld a, (game_secLeft)	;; a <- game_secLeft
   5032 FE 00         [ 7]  667 		cp #0 				  	;; a - 0
   5034 20 9A         [12]  668 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
                            669 
   5036 3A D3 4D      [13]  670 		ld a, (game_secRight)	;; a <- game_secRight
   5039 FE 00         [ 7]  671 		cp #0 				  	;; a - 0
   503B 20 93         [12]  672 		jr nz, game_loop_Player_IA	;; if (a - 0) != 0, then jump game_loop_Player_IA
   503D 18 16         [12]  673 		jr game_loop_Player_IA_exit
                            674 
   503F                     675 	scoreEnd:
   503F 3A CF 4D      [13]  676 		ld a, (game_t1Score) 
   5042 47            [ 4]  677 		ld b, a               ;; b <- LocalScore
   5043 3A CE 4D      [13]  678 		ld a, (game_maxScore) ;; a <- maxScore
   5046 B8            [ 4]  679 		cp b             	  ;; a - b 
   5047 28 0C         [12]  680 		jr z, game_loop_Player_IA_exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            681 
   5049 4F            [ 4]  682 		ld c, a      	      ;; c <- maxScore
   504A 3A D0 4D      [13]  683 		ld a, (game_t2Score)
   504D 47            [ 4]  684 		ld b, a               ;; b <- VisitantScore
   504E 79            [ 4]  685 		ld a, c 			  ;; a <- c
   504F B8            [ 4]  686 		cp b             	  ;; a - b 
   5050 28 03         [12]  687 		jr z, game_loop_Player_IA_exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   5052 C3 D0 4F      [10]  688 			jp game_loop_Player_IA ;; Keep Playing
                            689 
   5055                     690 game_loop_Player_IA_exit:
   5055 C9            [10]  691 	ret
