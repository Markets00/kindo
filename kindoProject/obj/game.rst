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
                              7 
                              8 .globl _sprite_robot_1_0
                              9 .globl _sprite_robot_1_1
                             10 .globl _sprite_robot_2_0
                             11 .globl _sprite_robot_2_1
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
                             10 .globl frisbee_setOff
                             11 .globl frisbee_setEffect
                             12 .globl frisbee_setVelocities
                             13 .globl frisbee_checkGoal
                             14 
                             15 .globl _sprite_frisbee_1_0
                             16 .globl _sprite_frisbee_1_1
                             17 	
                     0018    18 .equ Frisbee_effect_I, 24
                     0019    19 .equ Frisbee_effect_F, 25
                     0008    20 .equ std_eff, 0x0008
                     FFF8    21 .equ std_N_eff, 0xFFF8
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
                             13 .globl _sprite_palette
                             14 
                             15 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, sprite, id
                             16 	name'_data::
                             17 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             18 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             19 		name'_h:	.db h		;; Height			(8 bits)
                             20 		name'_w:	.db w		;; Width			(8 bits)
                             21 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             22 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             23 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             24 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             25 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             26 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             27 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             28 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             29 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
                             30 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             31 		name'_sprite:	.dw sprite	;; Entity sprite		(16 bits)
                             32 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             33 .endm
                             34 
                             35 
                             36 ;; ====================================
                             37 ;; ====================================
                             38 ;; ENTITY PUBLIC DATA
                             39 ;; ====================================
                             40 ;; ====================================
                     0000    41 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    42 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    43 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    44 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    45 .equ Ent_h, 		4	;; Height
                     0005    46 .equ Ent_w, 		5	;; Width
                     0006    47 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    48 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    49 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    50 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    51 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    52 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    53 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    54 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                     000E    55 .equ Ent_N_I,		14	;; Normal force, integer part
                     000F    56 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    57 .equ Ent_last_x,	16	;; Last x rendered
                     0011    58 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    59 .equ Ent_last_y,	18	;; Last y rendered
                     0013    60 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    61 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    62 .equ Ent_sprite_H, 	21	;; Pointer to sprite, high part
                     0016    63 .equ Ent_sprite_L, 	22	;; Pointer to sprite, low part
                     0017    64 .equ Ent_id, 		23	;; Numeric ID
                             65 				;; Frisbee 	0
                             66 				;; Player1 	1
                             67 				;; Enemy1	2
                             68 
                     0003    69 .equ MAX_VEL_X, 3 
                     FFFFFFFD    70 .equ MIN_VEL_X, -3
                     0003    71 .equ MAX_VEL_Y, 3
                     FFFFFFFD    72 .equ MIN_VEL_Y, -3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 	
                              9 ;; ====================================
                             10 ;; ====================================
                             11 ;; PUBLIC DATA
                             12 ;; ====================================
                             13 ;; ====================================
                             14 
                             15 
                             16 .globl _sprite_palette
                             17 .globl _sprite_robot_1_0
                             18 .globl _sprite_robot_1_1
                             19 .globl _sprite_robot_2_0
                             20 .globl _sprite_robot_2_1
                             21 
                             22 
                             23 
                             24 ;;    .macro name,   x,       y,       h,   w,  vx,    vy,    ax,    ay,    normal,  state, sprite,  			id
   10A8                      25 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1,    #_sprite_robot_1_0, 	#1
   0000                       1 	player_data::
   10A8 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   10AA 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   10AC 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   10AD 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   10AE 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   10B0 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   10B2 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   10B4 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   10B6 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   10B8 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   10B9 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   10BA 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   10BB 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   10BC 01                   15 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   10BD 58 02                16 		player_sprite:	.dw #_sprite_robot_1_0	;; Entity sprite		(16 bits)
   10BF 01                   17 		player_id:	.db #1		;; Numeric ID			(8 bits)
   10C0                      26 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #_sprite_robot_2_0, 	#2
   0018                       1 	enemy_data::
   10C0 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   10C2 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   10C4 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   10C5 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   10C6 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   10C8 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   10CA 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   10CC 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   10CE 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   10D0 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   10D1 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   10D2 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   10D3 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   10D4 01                   15 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   10D5 80 01                16 		enemy_sprite:	.dw #_sprite_robot_2_0	;; Entity sprite		(16 bits)
   10D7 02                   17 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             27 
   10D8                      28 defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1,    #_sprite_robot_1_0, 	#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0030                       1 	player_2_data::
   10D8 10 00                 2 		player_2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   10DA 50 00                 3 		player_2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   10DC 14                    4 		player_2_h:	.db #20		;; Height			(8 bits)
   10DD 05                    5 		player_2_w:	.db #5		;; Width			(8 bits)
   10DE 00 00                 6 		player_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   10E0 00 00                 7 		player_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   10E2 00 00                 8 		player_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   10E4 00 00                 9 		player_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   10E6 00 18                10 		player_2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   10E8 10                   11 		player_2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   10E9 10                   12 		player_2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   10EA 50                   13 		player_2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   10EB 50                   14 		player_2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   10EC 01                   15 		player_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   10ED 58 02                16 		player_2_sprite:	.dw #_sprite_robot_1_0	;; Entity sprite		(16 bits)
   10EF 01                   17 		player_2_id:	.db #1		;; Numeric ID			(8 bits)
   10F0                      29 defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #_sprite_robot_2_0, 	#2
   0048                       1 	enemy_2_data::
   10F0 4C 00                 2 		enemy_2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   10F2 64 00                 3 		enemy_2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   10F4 14                    4 		enemy_2_h:	.db #20		;; Height			(8 bits)
   10F5 05                    5 		enemy_2_w:	.db #5		;; Width			(8 bits)
   10F6 00 00                 6 		enemy_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   10F8 00 00                 7 		enemy_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   10FA 00 00                 8 		enemy_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   10FC 00 00                 9 		enemy_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   10FE 00 18                10 		enemy_2_normal:	.dw #0x1800	;; Normal force			(16 bits)
   1100 4C                   11 		enemy_2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   1101 4C                   12 		enemy_2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   1102 64                   13 		enemy_2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   1103 64                   14 		enemy_2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   1104 01                   15 		enemy_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   1105 80 01                16 		enemy_2_sprite:	.dw #_sprite_robot_2_0	;; Entity sprite		(16 bits)
   1107 02                   17 		enemy_2_id:	.db #2		;; Numeric ID			(8 bits)
                             30 
   1108                      31 game_data::
   1108 00                   32 	game_type::         .db #0 ;; Game Mode (8 bits)
   1109 00                   33    	game_numPlayers:    .db #0 ;; Players who are going to play
   110A 01                   34    	game_WinCondition:  .db #1 ;; Win condition 0-> Time, 1 -> Score
                             35 
   110B 0A                   36 	game_maxScore:      .db #10 ;; Max score of a match (to win)
   110C 00                   37 	game_t1Score:       .db #0 ;; Points of team 1		(8 bits)
   110D 00                   38 	game_t2Score:       .db #0 ;; Points of team 2		(8 bits)
                             39 
   110E 00                   40 	game_time:			.db #0 ;; Actual time of a game
   110F 00 00                41 	game_maxTime:       .dw #0x0000 ;; Max time of a match
   1111 00 00                42 	game_map:           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             43 
   1113 00                   44 	game_interruptions: .db #0 ;; Counter interruption handler	(8 bits)
   1114 00                   45 	game_musicPlayer:   .db #0 ;; Controles the music player
   1115 00                   46 	game_musicEffects:  .db #0 ;; Controles the effects on the match
                             47 
                             48 	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
                             49 	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             50 	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
                             51 	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
                             52 ;; 
                             53 ;; .equ RIGHT_LIMIT,	80
                             54 ;; .equ LEFT_LIMIT,	0
                             55 ;; .equ TOP_LIMIT,	10
                             56 ;; .equ BOTTOM_LIMIT,	200
                             57 ;; .equ CENTER_LIMIT,	40
                             58 
                             59 
                             60 ;; ====================================
                             61 ;; ====================================
                             62 ;; PRIVATE DATA
                             63 ;; ====================================
                             64 ;; ====================================
                             65 
                             66 ;; .equ mi_constante0, 0
                             67 ;; .equ mi_constante1, 1
                             68 	
   1116 00 80                69 videoPtr:	.dw 0x8000
                             70 
                             71 ;; ====================================
                             72 ;; ====================================
                             73 ;; PUBLIC FUNCTIONS
                             74 ;; ====================================
                             75 ;; ====================================
                             76 
                             77 
                             78 ;; ===================================
                             79 ;; Inicia una partida dependiendo
                             80 ;; 	de los atributos de game
                             81 ;; ===================================
   1118                      82 gameStart::
                             83 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             84 	;; Reading game data example
                             85 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             86 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             87 	;;
                             88 	;;	ld 	h, Game_map_L(ix)
                             89 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             90 	;;
                             91 	;;	ld 	h, Game_time_H(ix)
                             92 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             93 	
                             94 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             95 	;; Modifying game data example
                             96 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             97 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             98 	;;
                             99 	;;	ld 	Game_map_L(ix), #0
                            100 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                            101 	;;
                            102 	;;	ld 	Game_time_H(ix), #0
                            103 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                            104 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            105 
   1118 CD 66 11      [17]  106 	call 	initializeGame
                            107 	;; Configuration staff...
                            108 	;; Configuration staff...
                            109 	;; Configuration staff...
   111B CD A0 11      [17]  110 	call 	game_loop_Player_IA
                            111 
   111E 3A 0D 11      [13]  112 	ld 	a, (game_t2Score)
   1121 47            [ 4]  113 	ld 	b, a
                            114 
   1122 3A 0C 11      [13]  115 	ld 	a, (game_t1Score)
   1125 B8            [ 4]  116 	cp 	b
   1126 FA 29 11      [10]  117 	jp 	m, t2_win
                            118 		;; t1 win
                            119 
   1129                     120 	t2_win:
                            121 
                            122 
   1129 C9            [10]  123 	ret
                            124 
                            125 ;; ==================================
                            126 ;; Devuelve el puntero a video en HL
                            127 ;; Devuelve:
                            128 ;;	HL => Pointer to video memory
                            129 ;; ==================================
   112A                     130 getVideoPtr::
   112A 2A 16 11      [16]  131 	ld	hl, (videoPtr)
   112D C9            [10]  132 	ret
                            133 
                            134 ;; ==================================
                            135 ;; Incrementa los puntos del equipo 1
                            136 ;; Modifica: A, B
                            137 ;; ==================================
   112E                     138 incTeam1Points::
   112E 3A 0B 11      [13]  139 	ld	a, (game_maxScore)
   1131 47            [ 4]  140 	ld 	b, a				;; B <= Max points
                            141 
   1132 3A 0C 11      [13]  142 	ld	a, (game_t1Score)
   1135 3C            [ 4]  143 	inc	a				;; A <= Team 1 points + 1
                            144 
   1136 32 0C 11      [13]  145 	ld	(game_t1Score), a	;; Inc team 1 points
                            146 
   1139 C9            [10]  147 		ret
                            148 
                            149 ;; ================================== 
                            150 ;; Incrementa los puntos del equipo 2
                            151 ;; Modifica: A, B
                            152 ;; ==================================
   113A                     153 incTeam2Points::
   113A 3A 0B 11      [13]  154 	ld	a, (game_maxScore)
   113D 47            [ 4]  155 	ld 	b, a				;; B <= Max points
                            156 
   113E 3A 0D 11      [13]  157 	ld	a, (game_t2Score)
   1141 3C            [ 4]  158 	inc	a				;; A <= Team 2 points + 1
                            159 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   1142 32 0D 11      [13]  160 	ld	(game_t2Score), a	;; Inc team 2 points
                            161 
                            162 	;;cp 	b
                            163 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            164 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            165 
   1145 C9            [10]  166 		ret
                            167 
                            168 ;; alomejor es una función privada
   1146                     169 play_music::
   1146 D9            [ 4]  170 	exx
   1147 08            [ 4]  171 	ex af', af
   1148 F5            [11]  172 	push af
   1149 C5            [11]  173 	push bc
   114A D5            [11]  174 	push de
   114B E5            [11]  175 	push hl
                            176 
   114C CD 79 12      [17]  177 	call cpct_akp_musicPlay_asm
                            178 
   114F E1            [10]  179 	pop hl
   1150 D1            [10]  180 	pop de
   1151 C1            [10]  181 	pop bc
   1152 F1            [10]  182 	pop af
   1153 08            [ 4]  183 	ex af', af
   1154 D9            [ 4]  184 	exx
                            185 
   1155 C9            [10]  186 	ret
                            187 
                            188 ;; alomejor es una función privada
   1156                     189 stop_music::
   1156 D9            [ 4]  190 	exx
   1157 08            [ 4]  191 	ex af', af
   1158 F5            [11]  192 	push af
   1159 C5            [11]  193 	push bc
   115A D5            [11]  194 	push de
   115B E5            [11]  195 	push hl
                            196 
   115C CD DC 19      [17]  197 	call cpct_akp_stop_asm
                            198 
   115F E1            [10]  199 	pop hl
   1160 D1            [10]  200 	pop de
   1161 C1            [10]  201 	pop bc
   1162 F1            [10]  202 	pop af
   1163 08            [ 4]  203 	ex af', af
   1164 D9            [ 4]  204 	exx
                            205 
   1165 C9            [10]  206 	ret
                            207 
                            208 
                            209 ;; ====================================
                            210 ;; ====================================
                            211 ;; PRIVATE FUNCTIONS
                            212 ;; ====================================
                            213 ;; ====================================
                            214 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            215 
                            216 ;; ========================
                            217 ;; Initialize game
                            218 ;; ========================
   1166                     219 initializeGame:
                            220 
                            221 	;; Set video mode
   1166 0E 00         [ 7]  222 	ld 	c, #0
   1168 CD 6D 1B      [17]  223 	call cpct_setVideoMode_asm
                            224 
                            225 	;; Set palette
   116B 21 48 02      [10]  226 	ld 	hl, #_sprite_palette
   116E 11 10 00      [10]  227 	ld 	de, #16
   1171 CD 64 12      [17]  228 	call cpct_setPalette_asm
                            229 
                            230 	;; Clean from 8000 to BFFF
   1174 21 00 80      [10]  231 	ld	hl, #0x8000			;; HL <= Copy pointer
   1177 11 01 80      [10]  232 	ld	de, #0x8001			;; DE <= Write pointer
   117A 36 00         [10]  233 	ld	(hl), #00			;; Set to 0 where HL points
   117C 01 00 40      [10]  234 	ld	bc, #0x4000			;; BC <= Times to repeat
   117F ED B0         [21]  235 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            236 
   1181 21 0C 11      [10]  237 	ld	hl, #game_t1Score
   1184 36 00         [10]  238 	ld 	(hl), #0
   1186 21 0D 11      [10]  239 	ld	hl, #game_t2Score
   1189 36 00         [10]  240 	ld 	(hl), #0		;; Initialize points to 0
                            241 
                            242 	
   118B C9            [10]  243 	ret
                            244 
                            245 
                            246 ;; ========================
                            247 ;; Switch Buffers
                            248 ;; ========================
   118C                     249 switchBuffers:
                     00E5   250 	mem_page = .+1
   118C 2E 20         [ 7]  251 	ld 	l, #0x20
   118E CD 5C 1B      [17]  252 	call 	cpct_setVideoMemoryPage_asm
   1191 21 8D 11      [10]  253 	ld 	hl, #mem_page
   1194 3E 10         [ 7]  254 	ld	a, #0x10
   1196 AE            [ 7]  255 	xor	(hl)
   1197 77            [ 7]  256 	ld	(hl), a
                            257 
   1198 21 17 11      [10]  258 	ld	hl, #videoPtr+1
   119B 3E 40         [ 7]  259 	ld	a, #0x40
   119D AE            [ 7]  260 	xor	(hl)
   119E 77            [ 7]  261 	ld	(hl), a
                            262 
                            263 
   119F C9            [10]  264 	ret
                            265 
                            266 ;; ============================
                            267 ;; Game loop until end of game
                            268 ;; ============================
   11A0                     269 game_loop_Player_IA:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            270 
                            271 	;; Erase
   11A0 DD 21 A8 10   [14]  272 	ld ix, #player_data
   11A4 CD 45 0B      [17]  273 	call entityErase
                            274 
   11A7 DD 21 C0 10   [14]  275 	ld ix, #enemy_data
   11AB CD 45 0B      [17]  276 	call entityErase
                            277 
   11AE DD 21 66 0D   [14]  278 	ld ix, #frisbee_data
   11B2 CD 45 0B      [17]  279 	call entityErase
                            280 
                            281 	;; Update
   11B5 DD 21 A8 10   [14]  282 	ld ix, #player_data
   11B9 CD 91 0E      [17]  283 	call player_update
                            284 
   11BC DD 21 C0 10   [14]  285 	ld ix, #enemy_data
   11C0 CD 91 0E      [17]  286 	call player_update
                            287 
   11C3 DD 21 66 0D   [14]  288 	ld ix, #frisbee_data
   11C7 CD 13 0E      [17]  289 	call frisbee_update
                            290 
                            291 	;; Draw
   11CA DD 21 A8 10   [14]  292 	ld ix, #player_data
   11CE CD 21 0B      [17]  293 	call entityDraw
                            294 
   11D1 DD 21 C0 10   [14]  295 	ld ix, #enemy_data
   11D5 CD 21 0B      [17]  296 	call entityDraw
                            297 
   11D8 DD 21 66 0D   [14]  298 	ld ix, #frisbee_data
   11DC CD 21 0B      [17]  299 	call entityDraw
                            300 
                            301 	;; Check goal
   11DF DD 21 66 0D   [14]  302 	ld	ix, #frisbee_data
   11E3 CD 4A 0E      [17]  303 	call frisbee_checkGoal
                            304 
                            305 	;; Wait VSYNC to modify VMEM without blinking
   11E6 CD 65 1B      [17]  306 	call cpct_waitVSYNC_asm
   11E9 CD 8C 11      [17]  307 	call switchBuffers
                            308 
   11EC 3A 0A 11      [13]  309 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   11EF FE 00         [ 7]  310 	cp #0  				      ;; a - 0
   11F1 28 02         [12]  311 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   11F3 18 0C         [12]  312 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            313 
   11F5                     314 	timeWinning:
   11F5 3A 0E 11      [13]  315 		ld a, (game_time)
   11F8 47            [ 4]  316 		ld b, a 				   ;; b <- timeActual
   11F9 3A 0F 11      [13]  317 		ld a, (game_maxTime)       ;; a <- maxTime
   11FC B8            [ 4]  318 		cp b             	 	   ;; a - b 
   11FD 28 17         [12]  319 		jr z, exit 		 	       ;; if (maxTime - timeActual) == 0, then jump timesUp
   11FF 18 9F         [12]  320 			jr game_loop_Player_IA ;; Keep Playing
                            321 
   1201                     322 	timesUP:
                            323 		;; Check Scores to know who wins.
                            324 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   1201                     325 	scoreEnd:
   1201 3A 0C 11      [13]  326 		ld a, (game_t1Score) 
   1204 47            [ 4]  327 		ld b, a               ;; b <- LocalScore
   1205 3A 0B 11      [13]  328 		ld a, (game_maxScore) ;; a <- maxScore
   1208 B8            [ 4]  329 		cp b             	  ;; a - b 
   1209 28 0B         [12]  330 		jr z, exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            331 
   120B 4F            [ 4]  332 		ld c, a      	      ;; c <- maxScore
   120C 3A 0D 11      [13]  333 		ld a, (game_t2Score)
   120F 47            [ 4]  334 		ld b, a               ;; b <- VisitantScore
   1210 79            [ 4]  335 		ld a, c 			  ;; a <- c
   1211 B8            [ 4]  336 		cp b             	  ;; a - b 
   1212 28 02         [12]  337 		jr z, exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   1214 18 8A         [12]  338 			jr game_loop_Player_IA ;; Keep Playing
                            339 
   1216                     340 exit:
   1216 C9            [10]  341 	ret
