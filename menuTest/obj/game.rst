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
                     0017    15 .equ Frisbee_effect_I, 23
                     0018    16 .equ Frisbee_effect_F, 24
                     0008    17 .equ std_eff, 0x0008
                     FFF8    18 .equ std_N_eff, 0xFFF8
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 	
                              9 ;; ====================================
                             10 ;; ====================================
                             11 ;; PUBLIC DATA
                             12 ;; ====================================
                             13 ;; ====================================
                             14 
                             15 ;;    .macro name,   x,       y,       h,   w,  vx,    vy,    ax,    ay,    normal,  state, clr(sprite),   id
   0E85                      16 defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1,    #0xF0,         #1
   0000                       1 	player_data::
   0E85 10 00                 2 		player_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0E87 50 00                 3 		player_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0E89 14                    4 		player_h:	.db #20		;; Height			(8 bits)
   0E8A 05                    5 		player_w:	.db #5		;; Width			(8 bits)
   0E8B 00 00                 6 		player_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0E8D 00 00                 7 		player_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0E8F 00 00                 8 		player_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0E91 00 00                 9 		player_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0E93 00 18                10 		player_normal:	.dw #0x1800	;; Normal force			(16 bits)
   0E95 10                   11 		player_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0E96 10                   12 		player_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0E97 50                   13 		player_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0E98 50                   14 		player_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0E99 01                   15 		player_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0E9A F0                   16 		player_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0E9B 01                   17 		player_id:	.db #1		;; Numeric ID			(8 bits)
   0E9C                      17 defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xFF, #2
   0017                       1 	enemy_data::
   0E9C 4C 00                 2 		enemy_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0E9E 64 00                 3 		enemy_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0EA0 14                    4 		enemy_h:	.db #20		;; Height			(8 bits)
   0EA1 05                    5 		enemy_w:	.db #5		;; Width			(8 bits)
   0EA2 00 00                 6 		enemy_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0EA4 00 00                 7 		enemy_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0EA6 00 00                 8 		enemy_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0EA8 00 00                 9 		enemy_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0EAA 00 18                10 		enemy_normal:	.dw #0x1800	;; Normal force			(16 bits)
   0EAC 4C                   11 		enemy_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   0EAD 4C                   12 		enemy_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   0EAE 64                   13 		enemy_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0EAF 64                   14 		enemy_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0EB0 01                   15 		enemy_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0EB1 FF                   16 		enemy_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0EB2 02                   17 		enemy_id:	.db #2		;; Numeric ID			(8 bits)
                             18 
   0EB3                      19 defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xF0, #1
   002E                       1 	player_2_data::
   0EB3 10 00                 2 		player_2_x:	.dw #0x0010		;; X coordinate			(16 bits)
   0EB5 50 00                 3 		player_2_y:	.dw #0x0050		;; Y coordinate			(16 bits)
   0EB7 14                    4 		player_2_h:	.db #20		;; Height			(8 bits)
   0EB8 05                    5 		player_2_w:	.db #5		;; Width			(8 bits)
   0EB9 00 00                 6 		player_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0EBB 00 00                 7 		player_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0EBD 00 00                 8 		player_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0EBF 00 00                 9 		player_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0EC1 00 04                10 		player_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   0EC3 10                   11 		player_2_last_x:	.db #0x0010		;; Last x rendered		(8 bits)
   0EC4 10                   12 		player_2_erase_x:	.db #0x0010		;; x rendered at same buffer	(8 bits)
   0EC5 50                   13 		player_2_last_y:	.db #0x0050		;; Last y rendered		(8 bits)
   0EC6 50                   14 		player_2_erase_y:	.db #0x0050		;; y rendered at same buffer	(8 bits)
   0EC7 01                   15 		player_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0EC8 F0                   16 		player_2_clr:	.db #0xF0		;; Entity color pattern		(8 bits)
   0EC9 01                   17 		player_2_id:	.db #1		;; Numeric ID			(8 bits)
   0ECA                      20 defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xFF, #2
   0045                       1 	enemy_2_data::
   0ECA 4C 00                 2 		enemy_2_x:	.dw #0x0050-0x0004		;; X coordinate			(16 bits)
   0ECC 64 00                 3 		enemy_2_y:	.dw #0x0064		;; Y coordinate			(16 bits)
   0ECE 14                    4 		enemy_2_h:	.db #20		;; Height			(8 bits)
   0ECF 05                    5 		enemy_2_w:	.db #5		;; Width			(8 bits)
   0ED0 00 00                 6 		enemy_2_vx:	.dw #0000		;; Velocity at X axis 		(16 bits)
   0ED2 00 00                 7 		enemy_2_vy:	.dw #0000		;; Velocity at Y axis		(16 bits)
   0ED4 00 00                 8 		enemy_2_ax:	.dw #0000		;; Acceleration at X axis	(16 bits)
   0ED6 00 00                 9 		enemy_2_ay:	.dw #0000		;; Acceleration at Y axis	(16 bits)
   0ED8 00 04                10 		enemy_2_normal:	.dw #0x0400	;; Normal force			(16 bits)
   0EDA 4C                   11 		enemy_2_last_x:	.db #0x0050-0x0004		;; Last x rendered		(8 bits)
   0EDB 4C                   12 		enemy_2_erase_x:	.db #0x0050-0x0004		;; x rendered at same buffer	(8 bits)
   0EDC 64                   13 		enemy_2_last_y:	.db #0x0064		;; Last y rendered		(8 bits)
   0EDD 64                   14 		enemy_2_erase_y:	.db #0x0064		;; y rendered at same buffer	(8 bits)
   0EDE 01                   15 		enemy_2_state:	.db #1	;; Entity enabled/disabled	(8 bits)
   0EDF FF                   16 		enemy_2_clr:	.db #0xFF		;; Entity color pattern		(8 bits)
   0EE0 02                   17 		enemy_2_id:	.db #2		;; Numeric ID			(8 bits)
                             21 
   0EE1                      22 game_data::
   0EE1 00                   23 	game_type::         .db #0 ;; Game Mode (8 bits)
   0EE2 00                   24    	game_numPlayers:    .db #0 ;; Players who are going to play
   0EE3 01                   25    	game_WinCondition:  .db #1 ;; Win condition 0-> Time, 1 -> Score
                             26 
   0EE4 0A                   27 	game_maxScore:      .db #10 ;; Max score of a match (to win)
   0EE5 00                   28 	game_t1Score:       .db #0 ;; Points of team 1		(8 bits)
   0EE6 00                   29 	game_t2Score:       .db #0 ;; Points of team 2		(8 bits)
                             30 
   0EE7 00                   31 	game_time:			.db #0 ;; Actual time of a game
   0EE8 00 00                32 	game_maxTime:       .dw #0x0000 ;; Max time of a match
   0EEA 00 00                33 	game_map:           .dw #0x0000 ;; Pointer to map of tiles	(16 bits little endian)
                             34 
   0EEC 00                   35 	game_interruptions: .db #0 ;; Counter interruption handler	(8 bits)
   0EED 00                   36 	game_musicPlayer:   .db #0 ;; Controles the music player
   0EEE 00                   37 	game_musicEffects:  .db #0 ;; Controles the effects on the match
                             38 
                             39 	;;game_map:		.dw #0x0000	;; Pointer to map of tiles	(16 bits little endian)
                             40 	;;game_fTime:		.dw #0x0000	;; Final duration of each match	(16 bits)
                             41 	;;game_t1Score: 		.db #0 		;; Points of team 1		(8 bits)
                             42 	;;game_t2Score: 		.db #0 		;; Points of team 2		(8 bits)
                             43 ;; 
                             44 ;; .equ RIGHT_LIMIT,	80
                             45 ;; .equ LEFT_LIMIT,	0
                             46 ;; .equ TOP_LIMIT,	10
                             47 ;; .equ BOTTOM_LIMIT,	200
                             48 ;; .equ CENTER_LIMIT,	40
                             49 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             50 
                             51 ;; ====================================
                             52 ;; ====================================
                             53 ;; PRIVATE DATA
                             54 ;; ====================================
                             55 ;; ====================================
                             56 
                             57 ;; .equ mi_constante0, 0
                             58 ;; .equ mi_constante1, 1
                             59 	
   0EEF 00 80                60 videoPtr:	.dw 0x8000
                             61 
                             62 ;; ====================================
                             63 ;; ====================================
                             64 ;; PUBLIC FUNCTIONS
                             65 ;; ====================================
                             66 ;; ====================================
                             67 
                             68 
                             69 ;; ===================================
                             70 ;; Inicia una partida dependiendo
                             71 ;; 	de los atributos de game
                             72 ;; ===================================
   0EF1                      73 gameStart::
                             74 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             75 	;; Reading game data example
                             76 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             77 	;;	ld 	h, Game_type(ix)	;; H <= Game_type
                             78 	;;
                             79 	;;	ld 	h, Game_map_L(ix)
                             80 	;;	ld 	l, Game_map_H(ix) 	;; HL <= Game_map pointer (little endian)
                             81 	;;
                             82 	;;	ld 	h, Game_time_H(ix)
                             83 	;;	ld 	l, Game_time_L(ix)	;; HL <= Game_time
                             84 	
                             85 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
                             86 	;; Modifying game data example
                             87 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             88 	;;	ld 	Game_type(ix), #0	;; Game_type <= 0
                             89 	;;
                             90 	;;	ld 	Game_map_L(ix), #0
                             91 	;;	ld 	Game_map_H(ix), #0 	;; Game_map <= 0x0000 (little endian)
                             92 	;;
                             93 	;;	ld 	Game_time_H(ix), #0
                             94 	;;	ld 	Game_time_L(ix), #0	;; Game_time <= 0x0000
                             95 
                             96 
   0EF1 CD 3F 0F      [17]   97 	call 	initializeGame
                             98 	;; Configuration staff...
                             99 	;; Configuration staff...
                            100 	;; Configuration staff...
   0EF4 CD 6B 0F      [17]  101 	call 	game_loop_Player_IA
                            102 
   0EF7 3A E6 0E      [13]  103 	ld 	a, (game_t2Score)
   0EFA 47            [ 4]  104 	ld 	b, a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            105 
   0EFB 3A E5 0E      [13]  106 	ld 	a, (game_t1Score)
   0EFE B8            [ 4]  107 	cp 	b
   0EFF FA 02 0F      [10]  108 	jp 	m, t2_win
                            109 		;; t1 win
                            110 
   0F02                     111 	t2_win:
                            112 
                            113 
   0F02 C9            [10]  114 	ret
                            115 
                            116 ;; ==================================
                            117 ;; Devuelve el puntero a video en HL
                            118 ;; Devuelve:
                            119 ;;	HL => Pointer to video memory
                            120 ;; ==================================
   0F03                     121 getVideoPtr::
   0F03 2A EF 0E      [16]  122 	ld	hl, (videoPtr)
   0F06 C9            [10]  123 	ret
                            124 
                            125 ;; ==================================
                            126 ;; Incrementa los puntos del equipo 1
                            127 ;; Modifica: A, B
                            128 ;; ==================================
   0F07                     129 incTeam1Points::
   0F07 3A E4 0E      [13]  130 	ld	a, (game_maxScore)
   0F0A 47            [ 4]  131 	ld 	b, a				;; B <= Max points
                            132 
   0F0B 3A E5 0E      [13]  133 	ld	a, (game_t1Score)
   0F0E 3C            [ 4]  134 	inc	a				;; A <= Team 1 points + 1
                            135 
   0F0F 32 E5 0E      [13]  136 	ld	(game_t1Score), a	;; Inc team 1 points
                            137 
   0F12 C9            [10]  138 		ret
                            139 
                            140 ;; ================================== 
                            141 ;; Incrementa los puntos del equipo 2
                            142 ;; Modifica: A, B
                            143 ;; ==================================
   0F13                     144 incTeam2Points::
   0F13 3A E4 0E      [13]  145 	ld	a, (game_maxScore)
   0F16 47            [ 4]  146 	ld 	b, a				;; B <= Max points
                            147 
   0F17 3A E6 0E      [13]  148 	ld	a, (game_t2Score)
   0F1A 3C            [ 4]  149 	inc	a				;; A <= Team 2 points + 1
                            150 
   0F1B 32 E6 0E      [13]  151 	ld	(game_t2Score), a	;; Inc team 2 points
                            152 
                            153 	;;cp 	b
                            154 	;;jr	z, max_t2_points		;; t2Points+1 == max_points? 
                            155 	;;	ld	(game_t2Score), a	;; Inc team 2 points
                            156 
   0F1E C9            [10]  157 		ret
                            158 
                            159 ;; alomejor es una función privada
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   0F1F                     160 play_music::
   0F1F D9            [ 4]  161 	exx
   0F20 08            [ 4]  162 	ex af', af
   0F21 F5            [11]  163 	push af
   0F22 C5            [11]  164 	push bc
   0F23 D5            [11]  165 	push de
   0F24 E5            [11]  166 	push hl
                            167 
   0F25 CD 44 10      [17]  168 	call cpct_akp_musicPlay_asm
                            169 
   0F28 E1            [10]  170 	pop hl
   0F29 D1            [10]  171 	pop de
   0F2A C1            [10]  172 	pop bc
   0F2B F1            [10]  173 	pop af
   0F2C 08            [ 4]  174 	ex af', af
   0F2D D9            [ 4]  175 	exx
                            176 
   0F2E C9            [10]  177 	ret
                            178 
                            179 ;; alomejor es una función privada
   0F2F                     180 stop_music::
   0F2F D9            [ 4]  181 	exx
   0F30 08            [ 4]  182 	ex af', af
   0F31 F5            [11]  183 	push af
   0F32 C5            [11]  184 	push bc
   0F33 D5            [11]  185 	push de
   0F34 E5            [11]  186 	push hl
                            187 
   0F35 CD A7 17      [17]  188 	call cpct_akp_stop_asm
                            189 
   0F38 E1            [10]  190 	pop hl
   0F39 D1            [10]  191 	pop de
   0F3A C1            [10]  192 	pop bc
   0F3B F1            [10]  193 	pop af
   0F3C 08            [ 4]  194 	ex af', af
   0F3D D9            [ 4]  195 	exx
                            196 
   0F3E C9            [10]  197 	ret
                            198 
                            199 
                            200 ;; ====================================
                            201 ;; ====================================
                            202 ;; PRIVATE FUNCTIONS
                            203 ;; ====================================
                            204 ;; ====================================
                            205 
                            206 
                            207 ;; ========================
                            208 ;; Initialize game
                            209 ;; ========================
   0F3F                     210 initializeGame:
                            211 
                            212 	;; Set video mode
                            213 	;; ld 	c, #0
                            214 	;; call cpct_setVideoMode_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            215 
                            216 	;; Set palette
                            217 	;; ld 	hl, #direccion_paleta
                            218 	;; ld 	de, #16
                            219 	;; call cpct_setPalette_asm
                            220 
                            221 	;; Clean from 8000 to BFFF
   0F3F 21 00 80      [10]  222 	ld	hl, #0x8000			;; HL <= Copy pointer
   0F42 11 01 80      [10]  223 	ld	de, #0x8001			;; DE <= Write pointer
   0F45 36 00         [10]  224 	ld	(hl), #00			;; Set to 0 where HL points
   0F47 01 00 40      [10]  225 	ld	bc, #0x4000			;; BC <= Times to repeat
   0F4A ED B0         [21]  226 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            227 
   0F4C 21 E5 0E      [10]  228 	ld	hl, #game_t1Score
   0F4F 36 00         [10]  229 	ld 	(hl), #0
   0F51 21 E6 0E      [10]  230 	ld	hl, #game_t2Score
   0F54 36 00         [10]  231 	ld 	(hl), #0		;; Initialize points to 0
                            232 
                            233 	
   0F56 C9            [10]  234 	ret
                            235 
                            236 
                            237 ;; ========================
                            238 ;; Switch Buffers
                            239 ;; ========================
   0F57                     240 switchBuffers:
                     00D3   241 	mem_page = .+1
   0F57 2E 20         [ 7]  242 	ld 	l, #0x20
   0F59 CD 85 18      [17]  243 	call 	cpct_setVideoMemoryPage_asm
   0F5C 21 58 0F      [10]  244 	ld 	hl, #mem_page
   0F5F 3E 10         [ 7]  245 	ld	a, #0x10
   0F61 AE            [ 7]  246 	xor	(hl)
   0F62 77            [ 7]  247 	ld	(hl), a
                            248 
   0F63 21 F0 0E      [10]  249 	ld	hl, #videoPtr+1
   0F66 3E 40         [ 7]  250 	ld	a, #0x40
   0F68 AE            [ 7]  251 	xor	(hl)
   0F69 77            [ 7]  252 	ld	(hl), a
                            253 
                            254 
   0F6A C9            [10]  255 	ret
                            256 
                            257 ;; ============================
                            258 ;; Game loop until end of game
                            259 ;; ============================
   0F6B                     260 game_loop_Player_IA:
                            261 
                            262 	;; Erase
   0F6B DD 21 85 0E   [14]  263 	ld ix, #player_data
   0F6F CD 24 09      [17]  264 	call entityErase
                            265 
   0F72 DD 21 9C 0E   [14]  266 	ld ix, #enemy_data
   0F76 CD 24 09      [17]  267 	call entityErase
                            268 
   0F79 DD 21 45 0B   [14]  269 	ld ix, #frisbee_data
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   0F7D CD 24 09      [17]  270 	call entityErase
                            271 
                            272 	;; Update
   0F80 DD 21 85 0E   [14]  273 	ld ix, #player_data
   0F84 CD 6E 0C      [17]  274 	call player_update
                            275 
   0F87 DD 21 9C 0E   [14]  276 	ld ix, #enemy_data
   0F8B CD 6E 0C      [17]  277 	call player_update
                            278 
   0F8E DD 21 45 0B   [14]  279 	ld ix, #frisbee_data
   0F92 CD F0 0B      [17]  280 	call frisbee_update
                            281 
                            282 	;; Draw
   0F95 DD 21 85 0E   [14]  283 	ld ix, #player_data
   0F99 CD 03 09      [17]  284 	call entityDraw
                            285 
   0F9C DD 21 9C 0E   [14]  286 	ld ix, #enemy_data
   0FA0 CD 03 09      [17]  287 	call entityDraw
                            288 
   0FA3 DD 21 45 0B   [14]  289 	ld ix, #frisbee_data
   0FA7 CD 03 09      [17]  290 	call entityDraw
                            291 
                            292 	;; Check goal
   0FAA DD 21 45 0B   [14]  293 	ld	ix, #frisbee_data
   0FAE CD 27 0C      [17]  294 	call frisbee_checkGoal
                            295 
                            296 	;; Wait VSYNC to modify VMEM without blinking
   0FB1 CD 8E 18      [17]  297 	call cpct_waitVSYNC_asm
   0FB4 CD 57 0F      [17]  298 	call switchBuffers
                            299 
   0FB7 3A E3 0E      [13]  300 	ld a, (game_WinCondition) ;; a <- WinCondition (0-> Time, 1 -> Score)
   0FBA FE 00         [ 7]  301 	cp #0  				      ;; a - 0
   0FBC 28 02         [12]  302 	jr z, timeWinning         ;; if (a - 0) == 0, then jump timeWinning
   0FBE 18 0C         [12]  303 		jr scoreEnd 		  ;; else, jump ScoreWinning.
                            304 
   0FC0                     305 	timeWinning:
   0FC0 3A E7 0E      [13]  306 		ld a, (game_time)
   0FC3 47            [ 4]  307 		ld b, a 				   ;; b <- timeActual
   0FC4 3A E8 0E      [13]  308 		ld a, (game_maxTime)       ;; a <- maxTime
   0FC7 B8            [ 4]  309 		cp b             	 	   ;; a - b 
   0FC8 28 17         [12]  310 		jr z, exit 		 	       ;; if (maxTime - timeActual) == 0, then jump timesUp
   0FCA 18 9F         [12]  311 			jr game_loop_Player_IA ;; Keep Playing
                            312 
   0FCC                     313 	timesUP:
                            314 		;; Check Scores to know who wins.
                            315 
   0FCC                     316 	scoreEnd:
   0FCC 3A E5 0E      [13]  317 		ld a, (game_t1Score) 
   0FCF 47            [ 4]  318 		ld b, a               ;; b <- LocalScore
   0FD0 3A E4 0E      [13]  319 		ld a, (game_maxScore) ;; a <- maxScore
   0FD3 B8            [ 4]  320 		cp b             	  ;; a - b 
   0FD4 28 0B         [12]  321 		jr z, exit 		      ;; if (maxScore - LocalScore) == 0, then jump localWin
                            322 
   0FD6 4F            [ 4]  323 		ld c, a      	      ;; c <- maxScore
   0FD7 3A E6 0E      [13]  324 		ld a, (game_t2Score)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   0FDA 47            [ 4]  325 		ld b, a               ;; b <- VisitantScore
   0FDB 79            [ 4]  326 		ld a, c 			  ;; a <- c
   0FDC B8            [ 4]  327 		cp b             	  ;; a - b 
   0FDD 28 02         [12]  328 		jr z, exit            ;; if (maxScore - VisitantScore) == 0, then jump visitantWin
   0FDF 18 8A         [12]  329 			jr game_loop_Player_IA ;; Keep Playing
                            330 
   0FE1                     331 exit:
   0FE1 C9            [10]  332 	ret
