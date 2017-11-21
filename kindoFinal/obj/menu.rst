ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "utility.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "game.h.s"
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
                             19 
                             20 .globl game_type
                             21 .globl game_numPlayers
                             22 .globl game_WinCondition
                             23 
                             24 .globl game_maxScore
                             25 .globl game_t1Score
                             26 .globl game_t2Score
                             27 
                             28 .globl game_minute
                             29 .globl game_secLeft
                             30 .globl game_secRight
                             31 .globl game_maxTime
                             32 .globl game_map
                             33 
                             34 .globl game_musicOptions
                             35 .globl game_timeOptions
                             36 
                             37 .globl game_interrMusic
                             38 .globl game_interrTime
                             39 .globl game_musicPlayer
                             40 .globl game_musicEffects
                             41 
                             42 .globl game_enableMusic
                             43 
                             44 
                             45 ;; ====================================
                             46 ;; ====================================
                             47 ;; GAME PUBLIC DATA
                             48 ;; ====================================
                             49 ;; ====================================
                     0050    50 .equ RIGHT_LIMIT,	80
                     0000    51 .equ LEFT_LIMIT,	0
                     001E    52 .equ TOP_LIMIT,	 	30
                     00C8    53 .equ BOTTOM_LIMIT,	200
                     0028    54 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                              7 ;; definición de las teclas que necesitaremos
                     0100     8   Key_CursorUp     = 0x0100
                     0101     9   Key_CursorLeft   = 0x0101
                     0400    10   Key_CursorDown   = 0x0400
                     0200    11   Key_CursorRight  = 0x0200
                     8005    12   Key_Space        = 0x8005
                     0402    13   Key_Return       = 0x0402
                             14 
                             15 ;; ====================================
                             16 ;; ====================================
                             17 ;; PRIVATE DATA
                             18 ;; ====================================
                             19 ;; ====================================
                             20 
                             21 ;; .equ mi_constante0, 0
                             22 ;; .equ mi_constante1, 1
   58A8 4D 65 6E 75 00       23 menuString:				.asciz "Menu"
   58AD 43 72 65 64 69 74    24 credString:				.asciz "Credits"
        73 00
   58B5 50 6C 61 79 00       25 playString:				.asciz "Play"
   58BA 50 6C 61 79 65 72    26 pvpString:				.asciz "Player vs Player"
        20 76 73 20 50 6C
        61 79 65 72 00
   58CB 4F 70 74 69 6F 6E    27 optionsString:			.asciz "Options"
        73 00
   58D3 43 72 65 64 69 74    28 creditsString:			.asciz "Credits"
        73 00
   58DB 5E 0A 20 20 4D 6F    29 menuInstrucString:		.asciz "^\n  Move                    \r Select"
        76 65 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 0D 20
        53 65 6C 65 63 74
        00
   5900 5E 0A 20 20 4D 6F    30 menuOptInstrucString:	.asciz "^\n  Move     < > Select     \r Return"
        76 65 20 20 20 20
        20 3C 20 3E 20 53
        65 6C 65 63 74 20
        20 20 20 20 0D 20
        52 65 74 75 72 6E
        00
   5925 5E 20 20 20 20 20    31 CredotsInstrucString:	.asciz "^                            \r Return"
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 0D
        20 52 65 74 75 72
        6E 00
                             32 
   594B 3C 00                33 leftArrowCharacter: 	.asciz "<"
   594D 3E 00                34 rightArrowCharacter:	.asciz ">"
   594F 57 69 6E 20 43 6F    35 winCondString: 			.asciz "Win Condition"
        6E 64 69 74 69 6F
        6E 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   595D 54 69 6D 65 00       36 timeString: 			.asciz "Time"
   5962 31 00                37 string_1:				.asciz "1"
   5964 32 00                38 string_2:				.asciz "2"
   5966 33 00                39 string_3:				.asciz "3"
                             40 
   5968 53 63 6F 72 65 00    41 scoreString:			.asciz "Score"
   596E 31 35 00             42 string_15:				.asciz "15"
   5971 32 31 00             43 string_21:				.asciz "21"
   5974 32 35 00             44 string_25:				.asciz "25"
   5977 35 38 00             45 string_58:				.asciz "58"
                             46 
   597A 4D 75 73 69 63 00    47 musicString:			.asciz "Music"
   5980 4F 6E 00             48 onString:				.asciz "On"
   5983 4F 66 66 00          49 offString:				.asciz "Off"
   5987 00                   50 callingFromOpts: 		.db #0 ;; Are we calling from options?
                             51 
                             52 
                             53 ;; menuPos_X_sub 	-> For submenus, to the option menu
                             54 ;; menuPos_X 		-> Orignal position string (Strings on Menu, "<" on Options)
                             55 ;; menuPos_X_1 		-> String for options menu
                             56 ;; menuPos_X_2		-> ">" For Option menu
                             57 
                     C8F0    58 .equ txt_credits1, 0xC8F0
                     C990    59 .equ txt_credits3, 0xC990
                     C9E0    60 .equ txt_credits4, 0xC9E0
                     CA48    61 .equ txt_credits5, 0xCA48
                     CA80    62 .equ txt_credits6, 0xCA80
                     CAD0    63 .equ txt_credits7, 0xCAD0
                     CBC0    64 .equ txt_credits9, 0xCBC0
                     CC60    65 .equ txt_credits11, 0xCC60
                     CCB0    66 .equ txt_credits12, 0xCCB0
                     CDA0    67 .equ txt_credits14, 0xCDA0
                             68 
                     C000    69 .equ menuPos_1_sub, 0xC000
                     C850    70 .equ menuPos_1, 0xC850
                     C85B    71 .equ menuPos_1_1, 0xC85B
                     C870    72 .equ menuPos_1_2, 0xC870
                             73 
                     C0F0    74 .equ menuPos_2_sub, 0xC0F0
                     C940    75 .equ menuPos_2, 0xC940
                     C94B    76 .equ menuPos_2_1, 0xC94B
                     C960    77 .equ menuPos_2_2, 0xC960
                             78 
                     C1E0    79 .equ menuPos_3_sub, 0xC1E0
                     CA30    80 .equ menuPos_3, 0xCA30
                     CA3B    81 .equ menuPos_3_1, 0xCA3b
                     CA50    82 .equ menuPos_3_2, 0xCA50
                             83 
                     C2D0    84 .equ menuPos_4_sub, 0xC2D0
                     CB20    85 .equ menuPos_4, 0xCB20
                     CB2B    86 .equ menuPos_4_1, 0xCB2B
                     CB40    87 .equ menuPos_4_2, 0xCB40
                             88 
                     CC10    89 .equ menuPos_5, 0xCC10
                     CC1B    90 .equ menuPos_5_1, 0xCC1B
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                     CC30    91 .equ menuPos_5_2, 0xCC30
                             92 
                     CD00    93 .equ menuPos_6, 0xCD00
                     CD0B    94 .equ menuPos_6_1, 0xCD0B
                     CD20    95 .equ menuPos_6_2, 0xCD20
                             96 
                     CDF0    97 .equ menuPos_7, 0xCDF0
                     CDFB    98 .equ menuPos_7_1, 0xCDFB
                     CE10    99 .equ menuPos_7_2, 0xCE10
                            100 
                     C88F   101 .equ cursorPosDef, 0xC88F
                            102 ;; .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
                            103 ;; .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
                            104 ;;.equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
                            105 ;;.equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.
                            106 
                     C6E0   107 .equ instrPos, 0xC6E0
                            108 
                            109 ;;_sprite_frisbeeMenu_0: .dw #34
   5988 01                  110 nextSprite: .db #1
                            111 .globl _sprite_frisbeeMenu_0
                            112 .globl _sprite_frisbeeMenu_1 
                            113 
                     0002   114 cursor_W 	= 2
                     0008   115 cursor_H 	= 8
                     0004   116 max_index_value	= 4
                     00F0   117 addPosition	= 0xF0 			;; Sums to the next position (or substrct to the previous one)
                     FFFFFF10   118 subPosition	= #-240
   5989 8F C8               119 cursorPos: 	.dw 0xC88F		;; Saves the cursor position
                            120 
                            121 ;; ====================================
                            122 ;; ====================================
                            123 ;; PUBLIC FUNCTIONS
                            124 ;; ====================================
                            125 ;; ====================================
   598B                     126 menuStart::
                            127 
   598B 2E 10         [ 7]  128 	ld l, #16					;; Select the border colour
   598D 26 54         [ 7]  129 	ld h, #0x54					;; Set the Black Colour
   598F CD B9 63      [17]  130 	call cpct_setPALColour_asm
                            131 
   5992 CD 14 5E      [17]  132 	call cleanScreen		;;
   5995 CD 22 5E      [17]  133 	call initializeMenu 	;; 
                            134 
   5998 3A 1C 60      [13]  135  	ld	a, (game_type)			;; Initialize A to 0 as starting index for main menu
   599B CD A2 59      [17]  136 	call menu_loop 			;; Checks the state
   599E CD 0C 5B      [17]  137 	call setGameVariables	;; Sets the game variables.
   59A1 C9            [10]  138 	ret
                            139 
                            140 ;;
                            141 ;;
                            142 ;;
   59A2                     143 menu_loop::
                            144 
                            145 	;; Check 0.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   59A2 CD 9F 5C      [17]  146 	call 	checkSelection
                            147 	;; We have on A the option selected
   59A5 FE 00         [ 7]  148 	cp #0 					;; a - 0
   59A7 20 06         [12]  149 	jr nz, menuStart_check1	;; if (a - 0) != 0
                            150 		;; else, a == 0 ;; Go Configure Match
   59A9 3E 00         [ 7]  151 		ld a, #0
   59AB 32 1C 60      [13]  152 		ld (game_type), a
   59AE C9            [10]  153 		ret
                            154 
                            155 	;; Check 1: PvP
   59AF                     156 	menuStart_check1:
   59AF FE 01         [ 7]  157 		cp #1					;; a - 1
   59B1 20 06         [12]  158 		jr nz, menuStart_check2
   59B3 3E 01         [ 7]  159 			ld a, #1
   59B5 32 1C 60      [13]  160 			ld (game_type), a
   59B8 C9            [10]  161 			ret
                            162 
                            163 	;; Check 2: Options
   59B9                     164 	menuStart_check2:
   59B9 FE 02         [ 7]  165 	cp #2
   59BB 20 12         [12]  166 	jr nz, menuStart_check3	;; if (a - 1) != 0
                            167 			;; else, a == 1 ;; Go options
   59BD F5            [11]  168 			push af
   59BE 2A 89 59      [16]  169 			ld 	hl, (cursorPos)
   59C1 E5            [11]  170 			push hl
   59C2 CD E2 59      [17]  171 			call menuOptionsStart
   59C5 E1            [10]  172 			pop hl
   59C6 22 89 59      [16]  173 			ld (cursorPos), hl
   59C9 CD 22 5E      [17]  174 			call initializeMenu
   59CC F1            [10]  175 			pop af
                            176 
   59CD 18 D3         [12]  177 			jr menu_loop
                            178 	
                            179 	;; Check 3
   59CF                     180 	menuStart_check3:
   59CF F5            [11]  181 		push af
   59D0 2A 89 59      [16]  182 		ld 	hl, (cursorPos)
   59D3 E5            [11]  183 		push hl
   59D4 CD 28 5F      [17]  184 		call printCredits
   59D7 E1            [10]  185 		pop hl
   59D8 22 89 59      [16]  186 		ld (cursorPos), hl
   59DB CD 22 5E      [17]  187 		call initializeMenu
   59DE F1            [10]  188 		pop af
   59DF 18 C1         [12]  189 		jr menu_loop
                            190 
   59E1 C9            [10]  191 	ret
                            192 
                            193 ;;
                            194 ;;
                            195 ;;
   59E2                     196 menuOptionsStart::
   59E2 21 8F C8      [10]  197 	ld hl, #cursorPosDef
   59E5 22 89 59      [16]  198 	ld (cursorPos), hl
   59E8 CD 6E 5D      [17]  199 	call initializeOptionsMenu
                            200 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   59EB 3E 00         [ 7]  201 	ld a, #0
                            202 	;; Menu Options Loop
   59ED CD 9F 5C      [17]  203 	call checkSelection		;; Check Until hit enter.
                            204 
   59F0 C9            [10]  205 	ret
                            206 
                            207 ;; ====================================
                            208 ;; Erase the draw on options
                            209 ;; HL <- what to print
                            210 ;; DE <- Where to print
                            211 ;; Modifies: BC
                            212 ;; ====================================
   59F1                     213 eraseOptionsRefactor::
   59F1 0E 03         [ 7]  214 	ld c, #3
   59F3 06 03         [ 7]  215 	ld b, #3
   59F5 CD B5 6C      [17]  216 	call cpct_drawStringM1_f_asm
                            217 
   59F8 C9            [10]  218 	ret
                            219 
                            220 ;; ====================================
                            221 ;; Refactors the draw on options
                            222 ;; HL <- what to print
                            223 ;; DE <- Where to print
                            224 ;; Modifies: BC
                            225 ;; ====================================
   59F9                     226 drawOptionsRefactor::
   59F9 0E 02         [ 7]  227 	ld c, #2
   59FB 06 03         [ 7]  228 	ld b, #3
   59FD CD B5 6C      [17]  229 	call cpct_drawStringM1_f_asm
                            230 
   5A00 C9            [10]  231 	ret
                            232 
                            233 ;; ====================================
                            234 ;; Gets the win condition string
                            235 ;; Modifies: A, HL, DE, BC
                            236 ;; ====================================
   5A01                     237 getWinCondition::
   5A01 3A 2A 5B      [13]  238 	ld a, (winIndex) 	;; a <- Win condition ; 0 -> Time, 1 -> Score
   5A04 FE 00         [ 7]  239 	cp #0						;; 
   5A06 20 04         [12]  240 	jr nz, itsTime 				;; a != 0, then go time
   5A08 21 68 59      [10]  241 		ld hl, #scoreString		;; Charge score sprite
   5A0B C9            [10]  242 		ret		;; Jump to draw
                            243 
   5A0C                     244 	itsTime:
   5A0C 21 5D 59      [10]  245 		ld hl, #timeString		;; Charge time sprite
                            246 
   5A0F C9            [10]  247 	ret
                            248 
                            249 ;; ====================================
                            250 ;; Erases the win condition string
                            251 ;; Modifies: A, HL, DE, BC
                            252 ;; ====================================
   5A10                     253 eraseWinCondition::
   5A10 CD 01 5A      [17]  254 	call getWinCondition
   5A13 11 5B C8      [10]  255 	ld de, #menuPos_1_1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   5A16 CD F1 59      [17]  256 	call eraseOptionsRefactor
                            257 
   5A19 C9            [10]  258 	ret
                            259 
                            260 ;; ====================================
                            261 ;; Prints the win condition string
                            262 ;; Modifies: A, HL, DE, BC
                            263 ;; ====================================
   5A1A                     264 printWinCondition::
                            265 	;; Prints win condition options
   5A1A CD 01 5A      [17]  266 	call getWinCondition
   5A1D 11 5B C8      [10]  267 	ld de, #menuPos_1_1
   5A20 CD F9 59      [17]  268 	call drawOptionsRefactor
                            269 
   5A23 C9            [10]  270 	ret
                            271 
                            272 ;; ====================================
                            273 ;; Gets the time string
                            274 ;; Modifies: A, HL, DE, BC
                            275 ;; ====================================
   5A24                     276 getTimeOptions::
   5A24 3A B6 5B      [13]  277 	ld a, (timIndex)		;; a <- game_minute
   5A27 FE 00         [ 7]  278 	cp #0					;;
   5A29 20 04         [12]  279 	jr nz, itsTwoMinutes	;; a != 1, then go two minutes
   5A2B 21 62 59      [10]  280 		ld hl, #string_1 	;; Charge the 1 string
   5A2E C9            [10]  281 		ret	;; Jump to draw
                            282 
   5A2F                     283 	itsTwoMinutes:
   5A2F FE 01         [ 7]  284 		cp #1					;;
   5A31 20 04         [12]  285 		jr nz, itsThreeMinutes	;; a != 2, then go two minutes
   5A33 21 64 59      [10]  286 			ld hl, #string_2 	;; Charge the 2 string
   5A36 C9            [10]  287 			ret	;; Jump to draw
                            288 
   5A37                     289 	itsThreeMinutes:
   5A37 21 66 59      [10]  290 		ld hl, #string_3 	;; Charge the 3 string
   5A3A C9            [10]  291 	ret
                            292 
                            293 ;; ====================================
                            294 ;; Erases the win condition string
                            295 ;; Modifies: A, HL, DE, BC
                            296 ;; ====================================
   5A3B                     297 eraseTimeOptions::
   5A3B CD 24 5A      [17]  298 	call getTimeOptions
   5A3E 11 4B C9      [10]  299 	ld de, #menuPos_2_1
   5A41 CD F1 59      [17]  300 	call eraseOptionsRefactor
                            301 
   5A44 C9            [10]  302 	ret
                            303 
                            304 ;; ====================================
                            305 ;; Prints the time string
                            306 ;; Modifies: A, HL, DE, BC
                            307 ;; ====================================
   5A45                     308 printTimeOptions::
                            309 	;; Print time options
   5A45 CD 24 5A      [17]  310 	call getTimeOptions
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5A48 11 4B C9      [10]  311 	ld de, #menuPos_2_1
   5A4B CD F9 59      [17]  312 	call drawOptionsRefactor
   5A4E C9            [10]  313 	ret
                            314 
                            315 ;; ====================================
                            316 ;; Gets the score string
                            317 ;; Modifies: A, HL, DE, BC
                            318 ;; ====================================
   5A4F                     319 getScoreOptions::
   5A4F 3A 70 5B      [13]  320 	ld a, (scoIndex)		;; a <- game_maxScore
   5A52 FE 00         [ 7]  321 	cp #0						;;
   5A54 20 04         [12]  322 	jr nz, itsTwentyOneGoals	;; a != 11, then go two minutes
   5A56 21 6E 59      [10]  323 		ld hl, #string_15 		;; Charge the 1 string
   5A59 C9            [10]  324 		ret						;; Jump to draw
                            325 
   5A5A                     326 	itsTwentyOneGoals:
   5A5A FE 01         [ 7]  327 		cp #1						;;
   5A5C 20 04         [12]  328 		jr nz, itsTwentyFiveGoals	;; a != 11, then go two minutes
   5A5E 21 71 59      [10]  329 			ld hl, #string_21 		;; Charge the 1 string
   5A61 C9            [10]  330 			ret						;; Jump to draw
                            331 
   5A62                     332 	itsTwentyFiveGoals:
   5A62 FE 02         [ 7]  333 		cp #2						;;
   5A64 20 04         [12]  334 		jr nz, itsFiftyEightGoals	;; a != 11, then go two minutes
   5A66 21 74 59      [10]  335 			ld hl, #string_25 		;; Charge the 1 string
   5A69 C9            [10]  336 			ret						;; Jump to draw
                            337 
   5A6A                     338 	itsFiftyEightGoals:
   5A6A 21 77 59      [10]  339 			ld hl, #string_58 	;; Charge the 1 string
                            340 
   5A6D C9            [10]  341 	ret
                            342 
                            343 ;; ====================================
                            344 ;; Erases the win condition string
                            345 ;; Modifies: A, HL, DE, BC
                            346 ;; ====================================
   5A6E                     347 eraseScoreOptions::
   5A6E CD 4F 5A      [17]  348 	call getScoreOptions
   5A71 11 3B CA      [10]  349 	ld de, #menuPos_3_1
   5A74 CD F1 59      [17]  350 	call eraseOptionsRefactor
                            351 
   5A77 C9            [10]  352 	ret
                            353 
                            354 ;; ====================================
                            355 ;; Prints the score string
                            356 ;; Modifies: A, HL, DE, BC
                            357 ;; ====================================
   5A78                     358 printScoreOptions::
                            359 	;; Print time options
   5A78 CD 4F 5A      [17]  360 	call getScoreOptions
   5A7B 11 3B CA      [10]  361 	ld de, #menuPos_3_1
   5A7E CD F9 59      [17]  362 	call drawOptionsRefactor
   5A81 C9            [10]  363 	ret
                            364 
                            365 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            366 ;; Gets the music string
                            367 ;; Modifies: A, HL, DE, BC
                            368 ;; ====================================
   5A82                     369 getMusicOption::
   5A82 3A FC 5B      [13]  370 	ld a, (musIndex) 	;;  a <- game_enableMusic
   5A85 FE 00         [ 7]  371 	cp #0						;;
   5A87 28 04         [12]  372 	jr z, itsMusicOff
   5A89 21 80 59      [10]  373 		ld hl, #onString
   5A8C C9            [10]  374 		ret
                            375 
   5A8D                     376 	itsMusicOff:
   5A8D 21 83 59      [10]  377 		ld hl, #offString
                            378 
   5A90 C9            [10]  379 	ret
                            380 
                            381 ;; ====================================
                            382 ;; Erases the win condition string
                            383 ;; Modifies: A, HL, DE, BC
                            384 ;; ====================================
   5A91                     385 eraseMusicOptions::
   5A91 CD 82 5A      [17]  386 	call getMusicOption
   5A94 11 2B CB      [10]  387 	ld de, #menuPos_4_1
   5A97 CD F1 59      [17]  388 	call eraseOptionsRefactor
                            389 
   5A9A C9            [10]  390 	ret
                            391 
                            392 ;; ====================================
                            393 ;; Prints the music string
                            394 ;; Modifies: A, HL, DE, BC
                            395 ;; ====================================
   5A9B                     396 printMusicOptions::
   5A9B CD 82 5A      [17]  397 	call getMusicOption
   5A9E 11 2B CB      [10]  398 	ld de, #menuPos_4_1
   5AA1 CD F9 59      [17]  399 	call drawOptionsRefactor
                            400 
   5AA4 C9            [10]  401 	ret
                            402 
                            403 ;; ====================================
                            404 ;; Checks the options strings
                            405 ;; Modifies: A, HL, DE, BC
                            406 ;; ====================================
   5AA5                     407 printOptions::
                            408 
   5AA5 CD 1A 5A      [17]  409 	call printWinCondition
   5AA8 CD 45 5A      [17]  410 	call printTimeOptions
   5AAB CD 78 5A      [17]  411 	call printScoreOptions
   5AAE CD 9B 5A      [17]  412 	call printMusicOptions
                            413 
   5AB1 C9            [10]  414 	ret
                            415 
                            416 ;;
                            417 ;;
                            418 ;;
   5AB2                     419 setWinCondition::
   5AB2 3A 2A 5B      [13]  420 	ld a, (winIndex) ;; Charge the Win Index
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   5AB5 FE 00         [ 7]  421 	cp #0
   5AB7 20 04         [12]  422 	jr nz, winIndNotZero
                            423 		;; Its a Zero!
   5AB9 3E 01         [ 7]  424 		ld a, #1
   5ABB 18 02         [12]  425 		jr chargeWinCond
                            426 
   5ABD                     427 	winIndNotZero:
   5ABD 3E 00         [ 7]  428 		ld a, #0
                            429 
   5ABF                     430 	chargeWinCond:
   5ABF 32 1E 60      [13]  431 		ld (game_WinCondition), a
                            432 
   5AC2 C9            [10]  433 	ret
                            434 
                            435 ;;
                            436 ;;
                            437 ;;
   5AC3                     438 setTimeOptions::
   5AC3 3A B6 5B      [13]  439 	ld a, (timIndex) ;; Charge the Win Index
   5AC6 FE 00         [ 7]  440 	cp #0
   5AC8 20 04         [12]  441 	jr nz, timIndNotZero
                            442 		;; Its a Zero!
   5ACA 3E 01         [ 7]  443 		ld a, #1
   5ACC 18 0A         [12]  444 		jr chargeTimeOpt
                            445 
   5ACE                     446 	timIndNotZero:
   5ACE FE 01         [ 7]  447 	cp #1
   5AD0 20 04         [12]  448 	jr nz, timIndNotOne
                            449 		;; Its a One!
   5AD2 3E 02         [ 7]  450 		ld a, #2
   5AD4 18 02         [12]  451 		jr chargeTimeOpt
                            452 
   5AD6                     453 	timIndNotOne:
   5AD6 3E 03         [ 7]  454 		ld a, #3
                            455 
   5AD8                     456 	chargeTimeOpt:
   5AD8 32 22 60      [13]  457 		ld (game_minute), a
                            458 		
   5ADB C9            [10]  459 	ret
                            460 
                            461 ;;
                            462 ;;
                            463 ;;
   5ADC                     464 setScoreOptions::
   5ADC 3A 70 5B      [13]  465 	ld a, (scoIndex) ;; Charge the Win Index
   5ADF FE 00         [ 7]  466 	cp #0
   5AE1 20 04         [12]  467 	jr nz, scoIndNotZero
                            468 		;; Its a Zero!
   5AE3 3E 0F         [ 7]  469 		ld a, #15
   5AE5 18 10         [12]  470 		jr chargeScoreOpt
                            471 
   5AE7                     472 	scoIndNotZero:
   5AE7 FE 01         [ 7]  473 	cp #1
   5AE9 20 04         [12]  474 	jr nz, scoIndNotOne
                            475 		;; Its a One!
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   5AEB 3E 15         [ 7]  476 		ld a, #21
   5AED 18 08         [12]  477 		jr chargeScoreOpt
                            478 
   5AEF                     479 	scoIndNotOne:
   5AEF FE 02         [ 7]  480 		cp #2
   5AF1 20 02         [12]  481 		jr nz, scoIndNotTwo
   5AF3 3E 19         [ 7]  482 		ld a, #25
                            483 
   5AF5                     484 	scoIndNotTwo:
   5AF5 3E 3A         [ 7]  485 		ld a, #58
                            486 
   5AF7                     487 	chargeScoreOpt:
   5AF7 32 1F 60      [13]  488 		ld (game_maxScore), a
                            489 		
   5AFA C9            [10]  490 	ret
                            491 
                            492 ;;
                            493 ;;
                            494 ;;
   5AFB                     495 setMusicOptions::
   5AFB 3A FC 5B      [13]  496 	ld a, (musIndex) ;; Charge the Win Index
   5AFE FE 00         [ 7]  497 	cp #0
   5B00 20 04         [12]  498 	jr nz, musIndNotZero
                            499 		;; Its a Zero!
   5B02 3E 00         [ 7]  500 		ld a, #0
   5B04 18 02         [12]  501 		jr chargeMusicOpts
                            502 
   5B06                     503 	musIndNotZero:
   5B06 3E 01         [ 7]  504 		ld a, #1
                            505 
   5B08                     506 	chargeMusicOpts:
   5B08 32 30 60      [13]  507 		ld (game_enableMusic), a
                            508 
   5B0B C9            [10]  509 	ret
                            510 
                            511 ;;
                            512 ;;
                            513 ;;
   5B0C                     514 setGameVariables::
   5B0C CD B2 5A      [17]  515 	call setWinCondition
   5B0F CD C3 5A      [17]  516 	call setTimeOptions
   5B12 CD DC 5A      [17]  517 	call setScoreOptions
   5B15 CD FB 5A      [17]  518 	call setMusicOptions
                            519 
   5B18 C9            [10]  520 	ret
                            521 
                            522 ;;
                            523 ;;
                            524 ;;
   5B19                     525 getMaxIterator::
   5B19 F1            [10]  526 	pop af 		;; Get the iterator on A.
                            527 
   5B1A FE 00         [ 7]  528 	cp #0
   5B1C 20 00         [12]  529 	jr nz, not_WinCondition
                            530 		;; Win Condition
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   5B1E                     531 	not_WinCondition:
   5B1E FE 01         [ 7]  532 		cp #1
   5B20 20 00         [12]  533 		jr nz, not_Time
                            534 			;; Time
                            535 
   5B22                     536 	not_Time:
   5B22 FE 02         [ 7]  537 		cp #2
   5B24 20 00         [12]  538 		jr nz, not_Score
                            539 			;; Score
                            540 
   5B26                     541 	not_Score:
                            542 		;; Music
                            543 
   5B26 C9            [10]  544 	ret
                            545 
                            546 ;; Max iterators
   5B27 02                  547 maxOn2:		.db #2
   5B28 03                  548 maxOn3:		.db #3
   5B29 04                  549 maxOn4:		.db #4
                            550 
                            551 
                            552 ;; =======================================
                            553 ;; Win Condition Movements
                            554 ;; =======================================
   5B2A 01                  555 winIndex:	.db #1
                            556 
   5B2B                     557 moveLeftWinCond::
   5B2B F5            [11]  558 	push af  				;; Save the Index on the stack
   5B2C CD 10 5A      [17]  559 	call eraseWinCondition	;; Erase the actual string
                            560 
                            561 	;; Move
   5B2F 3A 2A 5B      [13]  562 	ld a, (winIndex)
   5B32 3D            [ 4]  563 	dec a
   5B33 FE FF         [ 7]  564 	cp #-1
   5B35 28 05         [12]  565 	jr z, maxWinCond_left
                            566 		;; We can move to the left
   5B37 32 2A 5B      [13]  567 		ld (winIndex), a
   5B3A 18 07         [12]  568 		jr printWinCond_left
                            569 
   5B3C                     570 	maxWinCond_left:
   5B3C 3A 27 5B      [13]  571 		ld a, (maxOn2)
   5B3F 3D            [ 4]  572 		dec a
   5B40 32 2A 5B      [13]  573 		ld (winIndex), a
                            574 
                            575 	;; Print the new string
   5B43                     576 	printWinCond_left:
   5B43 CD 1A 5A      [17]  577 		call printWinCondition
                            578 
   5B46 3E 0C         [ 7]  579 		ld a, #12
   5B48 CD 43 5D      [17]  580 		call wait_X_halts
                            581 
   5B4B F1            [10]  582 	pop af  				;; Get the Index from the stack
   5B4C C9            [10]  583 	ret
                            584 
   5B4D                     585 moveRightWinCond::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   5B4D F5            [11]  586 	push af  				;; Save the Index on the stack
   5B4E CD 10 5A      [17]  587 	call eraseWinCondition	;; Erase the actual string
                            588 
   5B51 3A 27 5B      [13]  589 	ld a, (maxOn2)
   5B54 47            [ 4]  590 	ld b, a
   5B55 3A 2A 5B      [13]  591 	ld a, (winIndex)
   5B58 3C            [ 4]  592 	inc a
   5B59 B8            [ 4]  593 	cp b
   5B5A 28 05         [12]  594 	jr z, minWinCond_right
                            595 		;; We can move to the right
   5B5C 32 2A 5B      [13]  596 		ld (winIndex), a
   5B5F 18 05         [12]  597 		jr printWinCond_right
                            598 
   5B61                     599 	minWinCond_right:
   5B61 3E 00         [ 7]  600 		ld a, #0
   5B63 32 2A 5B      [13]  601 		ld (winIndex), a
                            602 
   5B66                     603 	printWinCond_right:
   5B66 CD 1A 5A      [17]  604 		call printWinCondition
                            605 
   5B69 3E 0C         [ 7]  606 		ld a, #12
   5B6B CD 43 5D      [17]  607 		call wait_X_halts
                            608 
   5B6E F1            [10]  609 	pop af  				;; Save the Index on the stack
   5B6F C9            [10]  610 	ret
                            611 
                            612 ;; =======================================
                            613 ;; Score Movements
                            614 ;; =======================================
   5B70 01                  615 scoIndex:	.db #1
                            616 
   5B71                     617 moveLeftScore::
   5B71 F5            [11]  618 	push af  				;; Save the Index on the stack
   5B72 CD 6E 5A      [17]  619 	call eraseScoreOptions	;; Erase the actual string
                            620 
                            621 	;; Move
   5B75 3A 70 5B      [13]  622 	ld a, (scoIndex)
   5B78 3D            [ 4]  623 	dec a
   5B79 FE FF         [ 7]  624 	cp #-1
   5B7B 28 05         [12]  625 	jr z, maxScoOpt_left
                            626 		;; We can move to the left
   5B7D 32 70 5B      [13]  627 		ld (scoIndex), a
   5B80 18 07         [12]  628 		jr printScoOpt_left
                            629 
   5B82                     630 	maxScoOpt_left:
   5B82 3A 29 5B      [13]  631 		ld a, (maxOn4)
   5B85 3D            [ 4]  632 		dec a
   5B86 32 70 5B      [13]  633 		ld (scoIndex), a
                            634 
                            635 	;; Print the new string
   5B89                     636 	printScoOpt_left:
   5B89 CD 78 5A      [17]  637 		call printScoreOptions
                            638 
   5B8C 3E 0C         [ 7]  639 		ld a, #12
   5B8E CD 43 5D      [17]  640 		call wait_X_halts
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            641 		
   5B91 F1            [10]  642 	pop af  				;; Save the Index on the stack
                            643 
   5B92 C9            [10]  644 	ret
                            645 
   5B93                     646 moveRightScore::
   5B93 F5            [11]  647 	push af  				;; Save the Index on the stack
   5B94 CD 6E 5A      [17]  648 	call eraseScoreOptions	;; Erase the actual string
                            649 
   5B97 3A 29 5B      [13]  650 	ld a, (maxOn4)
   5B9A 47            [ 4]  651 	ld b, a
   5B9B 3A 70 5B      [13]  652 	ld a, (scoIndex)
   5B9E 3C            [ 4]  653 	inc a
   5B9F B8            [ 4]  654 	cp b
   5BA0 28 05         [12]  655 	jr z, minScoreOptions_right
                            656 		;; We can move to the right
   5BA2 32 70 5B      [13]  657 		ld (scoIndex), a
   5BA5 18 05         [12]  658 		jr prinScoreOptions_right
                            659 
   5BA7                     660 	minScoreOptions_right:
   5BA7 3E 00         [ 7]  661 		ld a, #0
   5BA9 32 70 5B      [13]  662 		ld (scoIndex), a
                            663 
   5BAC                     664 	prinScoreOptions_right:
   5BAC CD 78 5A      [17]  665 		call printScoreOptions
                            666 
   5BAF 3E 0C         [ 7]  667 		ld a, #12
   5BB1 CD 43 5D      [17]  668 		call wait_X_halts
                            669 
   5BB4 F1            [10]  670 	pop af  				;; Save the Index on the stack
                            671 
   5BB5 C9            [10]  672 	ret
                            673 
                            674 ;; =======================================
                            675 ;; Time Movements
                            676 ;; =======================================
   5BB6 01                  677 timIndex:	.db #1
                            678 
   5BB7                     679 moveLeftTime::
   5BB7 F5            [11]  680 	push af  				;; Save the Index on the stack
   5BB8 CD 3B 5A      [17]  681 	call eraseTimeOptions	;; Erase the actual string
                            682 
                            683 	;; Move
   5BBB 3A B6 5B      [13]  684 	ld a, (timIndex)
   5BBE 3D            [ 4]  685 	dec a
   5BBF FE FF         [ 7]  686 	cp #-1
   5BC1 28 05         [12]  687 	jr z, maxTimeOpt_left
                            688 		;; We can move to the left
   5BC3 32 B6 5B      [13]  689 		ld (timIndex), a
   5BC6 18 07         [12]  690 		jr printTimeOpt_left
                            691 
   5BC8                     692 	maxTimeOpt_left:
   5BC8 3A 28 5B      [13]  693 		ld a, (maxOn3)
   5BCB 3D            [ 4]  694 		dec a
   5BCC 32 B6 5B      [13]  695 		ld (timIndex), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                            696 
                            697 	;; Print the new string
   5BCF                     698 	printTimeOpt_left:
   5BCF CD 45 5A      [17]  699 		call printTimeOptions
                            700 
   5BD2 3E 0C         [ 7]  701 		ld a, #12
   5BD4 CD 43 5D      [17]  702 		call wait_X_halts
                            703 		
   5BD7 F1            [10]  704 	pop af  				;; Save the Index on the stack
                            705 
   5BD8 C9            [10]  706 	ret
                            707 
   5BD9                     708 moveRightTime::
   5BD9 F5            [11]  709 	push af  				;; Save the Index on the stack
   5BDA CD 3B 5A      [17]  710 	call eraseTimeOptions	;; Erase the actual string
                            711 
   5BDD 3A 28 5B      [13]  712 	ld a, (maxOn3)
   5BE0 47            [ 4]  713 	ld b, a
   5BE1 3A B6 5B      [13]  714 	ld a, (timIndex)
   5BE4 3C            [ 4]  715 	inc a
   5BE5 B8            [ 4]  716 	cp b
   5BE6 28 05         [12]  717 	jr z, minTimeOptions_right
                            718 		;; We can move to the right
   5BE8 32 B6 5B      [13]  719 		ld (timIndex), a
   5BEB 18 05         [12]  720 		jr prinTimeOptions_right
                            721 
   5BED                     722 	minTimeOptions_right:
   5BED 3E 00         [ 7]  723 		ld a, #0
   5BEF 32 B6 5B      [13]  724 		ld (timIndex), a
                            725 
   5BF2                     726 	prinTimeOptions_right:
   5BF2 CD 45 5A      [17]  727 		call printTimeOptions
                            728 
   5BF5 3E 0C         [ 7]  729 		ld a, #12
   5BF7 CD 43 5D      [17]  730 		call wait_X_halts
                            731 
   5BFA F1            [10]  732 	pop af  				;; Save the Index on the stack
                            733 	
   5BFB C9            [10]  734 	ret
                            735 
                            736 ;; =======================================
                            737 ;; Music Movements
                            738 ;; =======================================
   5BFC 01                  739 musIndex:	.db #1
                            740 
   5BFD                     741 moveLeftMusic::
   5BFD F5            [11]  742 	push af  				;; Save the Index on the stack
   5BFE CD 91 5A      [17]  743 	call eraseMusicOptions	;; Erase the actual string
                            744 
                            745 	;; Move
   5C01 3A FC 5B      [13]  746 	ld a, (musIndex)
   5C04 3D            [ 4]  747 	dec a
   5C05 FE FF         [ 7]  748 	cp #-1
   5C07 28 05         [12]  749 	jr z, maxMusicOpt_left
                            750 		;; We can move to the left
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   5C09 32 FC 5B      [13]  751 		ld (musIndex), a
   5C0C 18 07         [12]  752 		jr printMusicOpt_left
                            753 
   5C0E                     754 	maxMusicOpt_left:
   5C0E 3A 27 5B      [13]  755 		ld a, (maxOn2)
   5C11 3D            [ 4]  756 		dec a
   5C12 32 FC 5B      [13]  757 		ld (musIndex), a
                            758 
                            759 	;; Print the new string
   5C15                     760 	printMusicOpt_left:
   5C15 CD 9B 5A      [17]  761 		call printMusicOptions
                            762 
   5C18 3E 0C         [ 7]  763 		ld a, #12
   5C1A CD 43 5D      [17]  764 		call wait_X_halts
                            765 		
   5C1D F1            [10]  766 	pop af  				;; Save the Index on the stack
                            767 
   5C1E C9            [10]  768 	ret
                            769 
   5C1F                     770 moveRightMusic::
   5C1F F5            [11]  771 	push af  				;; Save the Index on the stack
   5C20 CD 91 5A      [17]  772 	call eraseMusicOptions	;; Erase the actual string
                            773 
   5C23 3A 27 5B      [13]  774 	ld a, (maxOn2)
   5C26 47            [ 4]  775 	ld b, a
   5C27 3A FC 5B      [13]  776 	ld a, (musIndex)
   5C2A 3C            [ 4]  777 	inc a
   5C2B B8            [ 4]  778 	cp b
   5C2C 28 05         [12]  779 	jr z, minMusicOptions_right
                            780 		;; We can move to the right
   5C2E 32 FC 5B      [13]  781 		ld (musIndex), a
   5C31 18 05         [12]  782 		jr prinMusicOptions_right
                            783 
   5C33                     784 	minMusicOptions_right:
   5C33 3E 00         [ 7]  785 		ld a, #0
   5C35 32 FC 5B      [13]  786 		ld (musIndex), a
                            787 
   5C38                     788 	prinMusicOptions_right:
   5C38 CD 9B 5A      [17]  789 		call printMusicOptions
                            790 
   5C3B 3E 0C         [ 7]  791 		ld a, #12
   5C3D CD 43 5D      [17]  792 		call wait_X_halts
                            793 
   5C40 F1            [10]  794 	pop af  				;; Save the Index on the stack
                            795 
   5C41 C9            [10]  796 	ret
                            797 
                            798 ;; =======================================
                            799 ;; Check Lateral Moves
                            800 ;; =======================================
   5C42                     801 checkLateral::
                            802 
   5C42 F5            [11]  803 	push af 				;; Stack <- A (Index)
                            804 
   5C43 21 01 01      [10]  805 	ld 	hl, #Key_CursorLeft
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   5C46 CD 9A 63      [17]  806 	call cpct_isKeyPressed_asm	;; A <= True/False
   5C49 FE 00         [ 7]  807 	cp 	#0 
   5C4B 28 23         [12]  808 	jr 	z, left_not_pressed			;; Is left key pressed?
                            809 		;; left pressed
   5C4D F1            [10]  810 		pop 	af 			;; A <- Index (Stack)
   5C4E FE 00         [ 7]  811 		cp #0
   5C50 20 06         [12]  812 		jr nz, not_WinCondition_left
                            813 			;; Call Win Condition left
   5C52 CD 2B 5B      [17]  814 			call moveLeftWinCond
   5C55 F5            [11]  815 			push	af
   5C56 18 18         [12]  816 			jr left_not_pressed
                            817 
   5C58                     818 		not_WinCondition_left:
   5C58 FE 01         [ 7]  819 			cp #1
   5C5A 20 06         [12]  820 			jr nz, not_Time_left
                            821 				;; Time
   5C5C CD B7 5B      [17]  822 				call moveLeftTime
   5C5F F5            [11]  823 				push	af
   5C60 18 0E         [12]  824 				jr left_not_pressed
                            825 
   5C62                     826 		not_Time_left:
   5C62 FE 02         [ 7]  827 			cp #2
   5C64 20 06         [12]  828 			jr nz, not_Score_left
                            829 				;; Score
   5C66 CD 71 5B      [17]  830 				call moveLeftScore
   5C69 F5            [11]  831 				push	af
   5C6A 18 04         [12]  832 				jr left_not_pressed
                            833 
   5C6C                     834 		not_Score_left:
                            835 			;; Music
   5C6C CD FD 5B      [17]  836 			call moveLeftMusic
   5C6F F5            [11]  837 			push	af
                            838 
   5C70                     839 	left_not_pressed:
   5C70 21 00 02      [10]  840 		ld 	hl, #Key_CursorRight
   5C73 CD 9A 63      [17]  841 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5C76 FE 00         [ 7]  842 		cp 	#0 
   5C78 28 23         [12]  843 		jr 	z, right_not_pressed			;; Is left key pressed?
                            844 			;; right pressed
   5C7A F1            [10]  845 			pop 	af
   5C7B FE 00         [ 7]  846 			cp #0
   5C7D 20 06         [12]  847 			jr nz, not_WinCondition_right
                            848 				;; Call Win Condition left
   5C7F CD 4D 5B      [17]  849 				call moveRightWinCond
   5C82 F5            [11]  850 				push	af
   5C83 18 18         [12]  851 				jr right_not_pressed
                            852 
   5C85                     853 			not_WinCondition_right:
   5C85 FE 01         [ 7]  854 				cp #1
   5C87 20 06         [12]  855 				jr nz, not_Time_right
                            856 					;; Time
   5C89 CD D9 5B      [17]  857 					call moveRightTime
   5C8C F5            [11]  858 					push	af
   5C8D 18 0E         [12]  859 					jr right_not_pressed
                            860 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   5C8F                     861 			not_Time_right:
   5C8F FE 02         [ 7]  862 				cp #2
   5C91 20 06         [12]  863 				jr nz, not_Score_right
                            864 					;; Score
   5C93 CD 93 5B      [17]  865 					call moveRightScore
   5C96 F5            [11]  866 					push	af
   5C97 18 04         [12]  867 					jr right_not_pressed
                            868 
   5C99                     869 			not_Score_right:
                            870 				;; Music
   5C99 CD 1F 5C      [17]  871 				call moveRightMusic
   5C9C F5            [11]  872 				push	af
                            873 
   5C9D                     874 	right_not_pressed:
   5C9D F1            [10]  875 		pop af
   5C9E C9            [10]  876 	ret
                            877 
                            878 ;; =======================================
                            879 ;; Mueve el índice a la posición indicada
                            880 ;; Entrada A <- Index Actual
                            881 ;; Modifica: AF, BC, DE, HL
                            882 ;; Devuelve:
                            883 ;;	A -> Selected index [0 - 6]
                            884 ;; =======================================
   5C9F                     885 checkSelection::
   5C9F F5            [11]  886 		push 	af ;; Saves on the stack the index (A).
                            887 
   5CA0 CD 8C 6F      [17]  888 		call 	cpct_scanKeyboard_asm
                            889 
   5CA3 21 02 04      [10]  890 		ld 	hl, #Key_Return
   5CA6 CD 9A 63      [17]  891 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5CA9 FE 00         [ 7]  892 		cp 	#0 
   5CAB 28 02         [12]  893 		jr 	z, enter_not_pressed	;; Is enter key pressed?
   5CAD F1            [10]  894 			pop af					;; A <= final index selected
   5CAE C9            [10]  895 			ret
                            896 
   5CAF                     897 		enter_not_pressed:
   5CAF F1            [10]  898 			pop af				;; A <= index value (stacked)
   5CB0 CD F8 5C      [17]  899 			call checkCursor	;; Check cursor movement
   5CB3 F5            [11]  900 			push af  			;; Stack <- A (Index)
                            901 
   5CB4 3A 87 59      [13]  902 			ld 	a, (callingFromOpts)
   5CB7 FE 00         [ 7]  903 			cp 	#0
   5CB9 28 05         [12]  904 			jr 	z, not_options
   5CBB F1            [10]  905 				pop af  			;; A <- Stack (Index)
   5CBC CD 42 5C      [17]  906 				call checkLateral 	;; Check if we hitted left or right
   5CBF F5            [11]  907 				push af 			;; Stack <- A (Index)
                            908 
   5CC0                     909 			not_options:
   5CC0 F1            [10]  910 			pop af
   5CC1 18 DC         [12]  911 			jr checkSelection
                            912 
   5CC3 C9            [10]  913 	ret
                            914 
                            915 ;; =======================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



                            916 ;; Mueve el índice a la posición indicada
                            917 ;; Entrada:
                            918 ;;	HL <= pointer to new position
                            919 ;; Modifica: AF, BC, DE, HL
                            920 ;; =======================================
   5CC4                     921 reDrawCursor::
   5CC4 E5            [11]  922 	push hl
                            923 
   5CC5 ED 5B 89 59   [20]  924 	ld de, (cursorPos)		;; alomejor esto no compila
   5CC9 3E FF         [ 7]  925 	ld a, #0xFF
   5CCB 06 08         [ 7]  926 	ld b, #cursor_H
   5CCD 0E 02         [ 7]  927 	ld c, #cursor_W
   5CCF CD C3 6E      [17]  928 	call cpct_drawSolidBox_asm	;; Erase last index position
                            929 
   5CD2 E1            [10]  930 	pop hl
   5CD3 22 89 59      [16]  931 	ld (cursorPos), hl		;; Update cursorPos to the new position after erasing
                            932 
   5CD6 EB            [ 4]  933 	ex 	de, hl			;; DE <= pointer to new position
   5CD7 3A 88 59      [13]  934 	ld a, (nextSprite)
   5CDA FE 00         [ 7]  935 	cp #0
   5CDC 20 0A         [12]  936 	jr nz, spriteTo1
                            937 		;, Sprite to 0
   5CDE 21 E9 40      [10]  938 		ld	hl, #_sprite_frisbeeMenu_1;; HL <= cursor sprite pointer
   5CE1 3E 01         [ 7]  939 		ld a, #1
   5CE3 32 88 59      [13]  940 		ld (nextSprite), a
   5CE6 18 08         [12]  941 		jr printSpite
                            942 
   5CE8                     943 	spriteTo1:
   5CE8 21 D9 40      [10]  944 		ld	hl, #_sprite_frisbeeMenu_0;; HL <= cursor sprite pointer
   5CEB 3E 00         [ 7]  945 		ld a, #0
   5CED 32 88 59      [13]  946 		ld (nextSprite), a
                            947 
   5CF0                     948 	printSpite:
   5CF0 06 08         [ 7]  949 		ld 	b, #cursor_H		;; B = height
   5CF2 0E 02         [ 7]  950 		ld 	c, #cursor_W		;; C = width
   5CF4 CD 0D 6C      [17]  951 		call cpct_drawSprite_asm
                            952 
   5CF7 C9            [10]  953 	ret
                            954 
                            955 ;; =================================
                            956 ;; Chequea si el índice debe moverse
                            957 ;; Entrada:
                            958 ;;	A <= starting index
                            959 ;; Modifica: AF, BC, DE, HL
                            960 ;; Devuelve:
                            961 ;; 	A => selected index
                            962 ;; =================================
   5CF8                     963 checkCursor::
   5CF8 F5            [11]  964 	push 	af						;; Stack <- A (Index)
   5CF9 21 00 01      [10]  965 	ld 	hl, #Key_CursorUp
   5CFC CD 9A 63      [17]  966 	call 	cpct_isKeyPressed_asm	;; A <= True/False
   5CFF FE 00         [ 7]  967 	cp 	#0 
   5D01 28 19         [12]  968 	jr 	z, up_not_pressed			;; Is up key pressed?
                            969 		;; Up pressed
   5D03 F1            [10]  970 		pop af 						;; A <- Index (Stack)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



   5D04 3D            [ 4]  971 		dec a 						;; A--
   5D05 FA 1A 5D      [10]  972 		jp	m, cant_dec_index 		;; A < 0
                            973 			;; Decrement index
   5D08 F5            [11]  974 			push af				;; Save the index
                            975 
   5D09 2A 89 59      [16]  976 			ld 	hl, (cursorPos)		;; HL <= Cursor position
   5D0C 11 10 FF      [10]  977 			ld	de, #subPosition	;; DE <= Negative value to substract to cursor position
   5D0F 19            [11]  978 			add	hl, de				;; HL <= Cursor position - SubPosition
   5D10 CD C4 5C      [17]  979 			call 	reDrawCursor
                            980 
   5D13 3E 0A         [ 7]  981 			ld	a, #10
   5D15 CD 43 5D      [17]  982 			call 	wait_X_halts	;; Waits a amout of halts * 8.
                            983 
   5D18 F1            [10]  984 			pop af					;; Restore the index before looping
   5D19 C9            [10]  985 			ret
                            986 
   5D1A                     987 			cant_dec_index:
   5D1A 3C            [ 4]  988 				inc a 				;; A++. Restore index value
   5D1B C9            [10]  989 				ret
                            990 
   5D1C                     991 	up_not_pressed:
   5D1C 21 00 04      [10]  992 		ld 	hl, #Key_CursorDown
   5D1F CD 9A 63      [17]  993 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5D22 FE 00         [ 7]  994 		cp 	#0 
   5D24 28 1B         [12]  995 		jr 	z, down_not_pressed	;; Is down key pressed?
                            996 			;; Down pressed
   5D26 F1            [10]  997 			pop 	af
   5D27 3C            [ 4]  998 			inc 	a
   5D28 FE 04         [ 7]  999 			cp  	#max_index_value
   5D2A F2 3F 5D      [10] 1000 			jp	p, cant_inc_index
                           1001 				;; increment index
   5D2D F5            [11] 1002 				push af					;; Save the index
                           1003 
   5D2E 2A 89 59      [16] 1004 				ld 	hl, (cursorPos)		;; HL <= Cursor position
   5D31 11 F0 00      [10] 1005 				ld	de, #addPosition	;; DE <= Positive value to add to cursor position
   5D34 19            [11] 1006 				add	hl, de				;; HL <= Cursor position + AddPosition
   5D35 CD C4 5C      [17] 1007 				call 	reDrawCursor
                           1008 
   5D38 3E 0A         [ 7] 1009 				ld	a, #10
   5D3A CD 43 5D      [17] 1010 				call 	wait_X_halts
                           1011 
   5D3D F1            [10] 1012 				pop af				;; Restore the index before looping
   5D3E C9            [10] 1013 				ret
                           1014 
   5D3F                    1015 			cant_inc_index:
   5D3F 3D            [ 4] 1016 				dec a 				;; Restore index value
   5D40 C9            [10] 1017 				ret
                           1018 
   5D41                    1019 	down_not_pressed:
                           1020 		;; Any key pressed
   5D41 F1            [10] 1021 		pop af
   5D42 C9            [10] 1022 	ret
                           1023 
                           1024 ;; =================================
                           1025 ;; Waits 8 halts, N times
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



                           1026 ;; In:
                           1027 ;;	A <= N times
                           1028 ;; Modifies: A
                           1029 ;; =================================
   5D43                    1030 wait_X_halts::
   5D43 3D            [ 4] 1031 	dec a
   5D44 28 09         [12] 1032 	jr z, wait_halts_exit
   5D46 76            [ 4] 1033 		halt
   5D47 76            [ 4] 1034 		halt
   5D48 76            [ 4] 1035 		halt
   5D49 76            [ 4] 1036 		halt
   5D4A 76            [ 4] 1037 		halt
   5D4B 76            [ 4] 1038 		halt
   5D4C 76            [ 4] 1039 		halt
   5D4D 18 F4         [12] 1040 		jr wait_X_halts
   5D4F                    1041 	wait_halts_exit:
   5D4F C9            [10] 1042 	ret
                           1043 
                           1044 ;; =======================================
                           1045 ;; Sets the palette to mode 0
                           1046 ;; Modifies: C, HL, DE
                           1047 ;; =======================================
                           1048 ;;setPaletteM0::
                           1049 ;;	ld c, #0					;; Mode 0
                           1050 ;;	call cpct_setVideoMode_asm
                           1051 ;;
                           1052 ;;	ld hl, #paletteM0			;; hl <- paletteM0
                           1053 ;;	ld de, #16 					;; 16 Colours
                           1054 ;;	call cpct_setPalette_asm
                           1055 ;;
                           1056 ;;	ret
                           1057 
                           1058 ;; =======================================
                           1059 ;; Sets the palette to mode 1
                           1060 ;; Modifies: C, HL, DE
                           1061 ;; =======================================
   5D50                    1062 setPaletteM1::
   5D50 0E 01         [ 7] 1063 	ld c, #1					;; Mode 1
   5D52 CD A3 6E      [17] 1064 	call cpct_setVideoMode_asm
                           1065 
   5D55 21 A8 5F      [10] 1066 	ld hl, #paletteM1			;; hl <- paletteM1
   5D58 11 04 00      [10] 1067 	ld de, #4 					;; 4 Colours
   5D5B CD A6 63      [17] 1068 	call cpct_setPalette_asm
                           1069 
   5D5E C9            [10] 1070 	ret
                           1071 
                           1072 ;; =======================================
                           1073 ;; Sets the palette to black on mode 1
                           1074 ;; Modifies: C, HL, DE
                           1075 ;; =======================================
   5D5F                    1076 setPaletteBlackM1::
   5D5F 0E 01         [ 7] 1077 	ld c, #1					;; Mode 1
   5D61 CD A3 6E      [17] 1078 	call cpct_setVideoMode_asm
                           1079 
   5D64 21 AC 5F      [10] 1080 	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



   5D67 11 04 00      [10] 1081 	ld de, #4 					;; 4 Colours
   5D6A CD A6 63      [17] 1082 	call cpct_setPalette_asm
                           1083 
   5D6D C9            [10] 1084 	ret
                           1085 
                           1086 ;; =======================================
                           1087 ;; Print the options menu
                           1088 ;; =======================================
   5D6E                    1089 initializeOptionsMenu::
                           1090 
   5D6E 3E 01         [ 7] 1091 	ld a, #1
   5D70 32 87 59      [13] 1092 	ld (callingFromOpts), a
                           1093 
   5D73 CD 14 5E      [17] 1094 	call cleanScreen
                           1095 
                           1096 	;; Print winCondString
   5D76 21 4F 59      [10] 1097 	ld hl, #winCondString
   5D79 11 00 C0      [10] 1098 	ld de, #menuPos_1_sub
   5D7C CD F9 59      [17] 1099 	call drawOptionsRefactor
                           1100 
                           1101 	;; Print scoreString
   5D7F 21 5D 59      [10] 1102 	ld hl, #timeString
   5D82 11 F0 C0      [10] 1103 	ld de, #menuPos_2_sub
   5D85 CD F9 59      [17] 1104 	call drawOptionsRefactor
                           1105 
                           1106 	;; Print timeString
   5D88 21 68 59      [10] 1107 	ld hl, #scoreString
   5D8B 11 E0 C1      [10] 1108 	ld de, #menuPos_3_sub
   5D8E CD F9 59      [17] 1109 	call drawOptionsRefactor
                           1110 
                           1111 	;; Print musicString
   5D91 21 7A 59      [10] 1112 	ld hl, #musicString
   5D94 11 D0 C2      [10] 1113 	ld de, #menuPos_4_sub
   5D97 CD F9 59      [17] 1114 	call drawOptionsRefactor
                           1115 
                           1116 	;; Print left arrows string
   5D9A 21 4B 59      [10] 1117 	ld hl, #leftArrowCharacter
   5D9D 11 50 C8      [10] 1118 	ld de, #menuPos_1
   5DA0 CD F9 59      [17] 1119 	call drawOptionsRefactor
                           1120 
   5DA3 21 4B 59      [10] 1121 	ld hl, #leftArrowCharacter
   5DA6 11 40 C9      [10] 1122 	ld de, #menuPos_2
   5DA9 CD F9 59      [17] 1123 	call drawOptionsRefactor
                           1124 
   5DAC 21 4B 59      [10] 1125 	ld hl, #leftArrowCharacter
   5DAF 11 30 CA      [10] 1126 	ld de, #menuPos_3
   5DB2 CD F9 59      [17] 1127 	call drawOptionsRefactor
                           1128 
   5DB5 21 4B 59      [10] 1129 	ld hl, #leftArrowCharacter
   5DB8 11 20 CB      [10] 1130 	ld de, #menuPos_4
   5DBB CD F9 59      [17] 1131 	call drawOptionsRefactor
                           1132 
                           1133 	;;	ld hl, #leftArrowCharacter
                           1134 	;;	ld de, #menuPos_5
                           1135 	;;	call drawOptionsRefactor
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 25.
Hexadecimal [16-Bits]



                           1136 	;;
                           1137 	;;	ld hl, #leftArrowCharacter
                           1138 	;;	ld de, #menuPos_6
                           1139 	;;	call drawOptionsRefactor
                           1140 	;;
                           1141 	;;	ld hl, #leftArrowCharacter
                           1142 	;;	ld de, #menuPos_7
                           1143 	;;	call drawOptionsRefactor
                           1144 
                           1145 	;; Print right arrows string
   5DBE 21 4D 59      [10] 1146 	ld hl, #rightArrowCharacter
   5DC1 11 70 C8      [10] 1147 	ld de, #menuPos_1_2
   5DC4 CD F9 59      [17] 1148 	call drawOptionsRefactor
                           1149 
   5DC7 21 4D 59      [10] 1150 	ld hl, #rightArrowCharacter
   5DCA 11 60 C9      [10] 1151 	ld de, #menuPos_2_2
   5DCD CD F9 59      [17] 1152 	call drawOptionsRefactor
                           1153 
   5DD0 21 4D 59      [10] 1154 	ld hl, #rightArrowCharacter
   5DD3 11 50 CA      [10] 1155 	ld de, #menuPos_3_2
   5DD6 CD F9 59      [17] 1156 	call drawOptionsRefactor
                           1157 
   5DD9 21 4D 59      [10] 1158 	ld hl, #rightArrowCharacter
   5DDC 11 40 CB      [10] 1159 	ld de, #menuPos_4_2
   5DDF CD F9 59      [17] 1160 	call drawOptionsRefactor
                           1161 
                           1162 	;;	ld hl, #rightArrowCharacter
                           1163 	;;	ld de, #menuPos_5_2
                           1164 	;;	call drawOptionsRefactor
                           1165 	;;
                           1166 	;;
                           1167 	;;	ld hl, #rightArrowCharacter
                           1168 	;;	ld de, #menuPos_6_2
                           1169 	;;	call drawOptionsRefactor
                           1170 	;;
                           1171 	;;	ld hl, #rightArrowCharacter
                           1172 	;;	ld de, #menuPos_7_2
                           1173 	;;	call drawOptionsRefactor
                           1174 
                           1175 	;; Print the instructions
   5DE2 21 00 59      [10] 1176 	ld hl, #menuOptInstrucString
   5DE5 11 E0 C6      [10] 1177 	ld de, #instrPos
   5DE8 CD F9 59      [17] 1178 	call drawOptionsRefactor
                           1179 
                           1180 	;; Print the cursor
   5DEB 3A 88 59      [13] 1181 		ld a, (nextSprite)
   5DEE FE 00         [ 7] 1182 	cp #0
   5DF0 20 0A         [12] 1183 	jr nz, spriteTo1_Menu
                           1184 		;, Sprite to 0
   5DF2 21 E9 40      [10] 1185 		ld	hl, #_sprite_frisbeeMenu_1;; HL <= cursor sprite pointer
   5DF5 3E 01         [ 7] 1186 		ld a, #1
   5DF7 32 88 59      [13] 1187 		ld (nextSprite), a
   5DFA 18 08         [12] 1188 		jr printSpite_Menu
                           1189 
   5DFC                    1190 	spriteTo1_Menu:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 26.
Hexadecimal [16-Bits]



   5DFC 21 D9 40      [10] 1191 		ld	hl, #_sprite_frisbeeMenu_0;; HL <= cursor sprite pointer
   5DFF 3E 00         [ 7] 1192 		ld a, #0
   5E01 32 88 59      [13] 1193 		ld (nextSprite), a
                           1194 
   5E04                    1195 	printSpite_Menu:
   5E04 ED 5B 89 59   [20] 1196 	ld 	de, (cursorPos)
   5E08 06 08         [ 7] 1197 	ld 	b, #cursor_H 		;; B = ent height
   5E0A 0E 02         [ 7] 1198 	ld 	c, #cursor_W		;; C = ent width
   5E0C CD 0D 6C      [17] 1199 	call cpct_drawSprite_asm
                           1200 
   5E0F CD A5 5A      [17] 1201 	call printOptions
   5E12 C9            [10] 1202 	ret
                           1203 
                           1204 ;; ====================================
                           1205 ;; ====================================
                           1206 ;; PRIVATE FUNCTIONS
                           1207 ;; ====================================
                           1208 ;; ====================================
                           1209 
   5E13                    1210 checkUserInput:
                           1211 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1212 	;; Reading keyboard example
                           1213 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1214 	;; 	call cpct_scanKeyboard_asm
                           1215 	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
                           1216 	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
                           1217 	;; 	cp 	#0 			;; A == 0?
                           1218 	;; 	jr 	z, up_not_pressed
                           1219 	;; 		;; Up is pressed code
                           1220 	;; 		call 	moveUp	
                           1221 	;; 	up_not_pressed:
                           1222 	;; 		;; Up is not pressed code
                           1223 	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
                           1224 	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
                           1225 	;; 		cp 	#0 				;; A == 0?
                           1226 	;; 		jr 	z, down_not_pressed
                           1227 	;; 			;; Down is pressed code
                           1228 	;; 			call 	moveDown	
                           1229 	;; 		down_not_pressed:
                           1230 	;; 		;; Down is not pressed code
                           1231 
   5E13 C9            [10] 1232 	ret
                           1233 
                           1234 ;; ====================================
                           1235 ;; Clears the cleanScreen
                           1236 ;; Modifies: HL, DE, BC
                           1237 ;; ====================================
   5E14                    1238 cleanScreen::
                           1239 	;; Clean from C000 to EFFF
   5E14 21 00 C0      [10] 1240 	ld	hl, #menuPos_1_sub			;; HL <= Copy pointer
   5E17 11 01 C0      [10] 1241 	ld	de, #0xC001			;; DE <= Write pointer
   5E1A 36 FF         [10] 1242 	ld	(hl), #0xFF			;; Set to 0 where HL points
   5E1C 01 00 40      [10] 1243 	ld	bc, #0x4000			;; BC <= Times to repeat
   5E1F ED B0         [21] 1244 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                           1245 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 27.
Hexadecimal [16-Bits]



   5E21 C9            [10] 1246 	ret
                           1247 
                           1248 ;; ====================================
                           1249 ;; Write the menu strings
                           1250 ;; Modifies: HL, DE, BC
                           1251 ;; ====================================
   5E22                    1252 initializeMenu:
   5E22 CD 50 5D      [17] 1253 	call setPaletteM1
   5E25 CD 14 5E      [17] 1254 	call cleanScreen
                           1255 
   5E28 F5            [11] 1256 	push af
   5E29 3E 00         [ 7] 1257 	ld a, #0
   5E2B 32 87 59      [13] 1258 	ld (callingFromOpts), a
   5E2E F1            [10] 1259 	pop af
                           1260 
                           1261 	;; Print Menu
   5E2F 21 A8 58      [10] 1262 	ld hl, #menuString
   5E32 11 00 C0      [10] 1263 	ld de, #menuPos_1_sub
   5E35 CD F9 59      [17] 1264 	call drawOptionsRefactor
                           1265 
                           1266 	;; Print Play
   5E38 21 B5 58      [10] 1267 	ld hl, #playString
   5E3B 11 50 C8      [10] 1268 	ld de, #menuPos_1
   5E3E CD F9 59      [17] 1269 	call drawOptionsRefactor
                           1270 
                           1271 	;; Print Options
                           1272 
   5E41 21 BA 58      [10] 1273 	ld hl, #pvpString
   5E44 11 40 C9      [10] 1274 	ld de, #menuPos_2
   5E47 CD F9 59      [17] 1275 	call drawOptionsRefactor
                           1276 
                           1277 	;; Print Menu
   5E4A 21 CB 58      [10] 1278 	ld hl, #optionsString
   5E4D 11 30 CA      [10] 1279 	ld de, #menuPos_3
   5E50 CD F9 59      [17] 1280 	call drawOptionsRefactor
                           1281 
                           1282 	;; Print Cretids
   5E53 21 AD 58      [10] 1283 	ld hl, #credString
   5E56 11 20 CB      [10] 1284 	ld de, #menuPos_4
   5E59 CD F9 59      [17] 1285 	call drawOptionsRefactor
                           1286 
                           1287 	;;	ld hl, #optionsString
                           1288 	;;	ld de, #menuPos_5
                           1289 	;;	call drawOptionsRefactor
                           1290 	;;
                           1291 	;;	ld hl, #menuString
                           1292 	;;	ld de, #menuPos_6
                           1293 	;;	call drawOptionsRefactor
                           1294 	;;
                           1295 	;;	ld hl, #playString
                           1296 	;;	ld de, #menuPos_7
                           1297 	;;	call drawOptionsRefactor
                           1298 
   5E5C 21 DB 58      [10] 1299 	ld hl, #menuInstrucString
   5E5F 11 E0 C6      [10] 1300 	ld de, #instrPos
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 28.
Hexadecimal [16-Bits]



   5E62 CD F9 59      [17] 1301 	call drawOptionsRefactor
                           1302 
                           1303 	;; Print the cursor
   5E65 F5            [11] 1304 	push af
   5E66 3A 88 59      [13] 1305 	ld a, (nextSprite)
   5E69 FE 00         [ 7] 1306 	cp #0
   5E6B 20 0A         [12] 1307 	jr nz, spriteTo1_Opt
                           1308 		;, Sprite to 0
   5E6D 21 E9 40      [10] 1309 		ld	hl, #_sprite_frisbeeMenu_1;; HL <= cursor sprite pointer
   5E70 3E 01         [ 7] 1310 		ld a, #1
   5E72 32 88 59      [13] 1311 		ld (nextSprite), a
   5E75 18 08         [12] 1312 		jr printSpite_Opt
                           1313 
   5E77                    1314 	spriteTo1_Opt:
   5E77 21 D9 40      [10] 1315 		ld	hl, #_sprite_frisbeeMenu_0;; HL <= cursor sprite pointer
   5E7A 3E 00         [ 7] 1316 		ld a, #0
   5E7C 32 88 59      [13] 1317 		ld (nextSprite), a
                           1318 
   5E7F                    1319 	printSpite_Opt:
   5E7F ED 5B 89 59   [20] 1320 	ld 	de, (cursorPos)
   5E83 06 08         [ 7] 1321 	ld 	b, #cursor_H 		;; B = height
   5E85 0E 02         [ 7] 1322 	ld 	c, #cursor_W		;; C = width
   5E87 CD 0D 6C      [17] 1323 	call cpct_drawSprite_asm
                           1324 
   5E8A F1            [10] 1325 	pop af
   5E8B C9            [10] 1326 	ret
                           1327 
                           1328 
   5E8C 50 41 42 4C 4F 20  1329 PabloString: 	.asciz "PABLO REQUENA"
        52 45 51 55 45 4E
        41 00
   5E9A 4D 41 52 43 4F 53  1330 MarcosString:	.asciz "MARCOS GONZALEZ"
        20 47 4F 4E 5A 41
        4C 45 5A 00
   5EAA 45 55 20 4C 4C 4F  1331 EuString:		.asciz "EU LLOPIS"
        50 49 53 00
   5EB4 47 45 4E 45 52 41  1332 ProgString:		.asciz "GENERAL PROGRAMING AND MANAGEMENT"
        4C 20 50 52 4F 47
        52 41 4D 49 4E 47
        20 41 4E 44 20 4D
        41 4E 41 47 45 4D
        45 4E 54 00
   5ED6 49 4E 54 45 52 46  1333 IfAndMecString:	.asciz "INTERFACE AND MECHANICS"
        41 43 45 20 41 4E
        44 20 4D 45 43 48
        41 4E 49 43 53 00
   5EEE 50 48 59 53 49 43  1334 PhysString:		.asciz "PHYSICS"
        53 00
   5EF6 41 52 54 20 45 58  1335 ArtString:		.asciz "ART EXPERT"
        50 45 52 54 00
   5F01 4D 41 50 20 41 4E  1336 Art2String:		.asciz "MAP AND ART DESIGN"
        44 20 41 52 54 20
        44 45 53 49 47 4E
        00
   5F14 4F 52 49 47 49 4E  1337 bsoString:		.asciz "ORIGINAL SOUNDTRACK"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 29.
Hexadecimal [16-Bits]



        41 4C 20 53 4F 55
        4E 44 54 52 41 43
        4B 00
                           1338 
                           1339 ;;
                           1340 ;;
                           1341 ;;
   5F28                    1342 printCredits::
                           1343 
   5F28 CD 50 5D      [17] 1344 	call setPaletteM1
   5F2B CD 14 5E      [17] 1345 	call cleanScreen
                           1346 
   5F2E F5            [11] 1347 	push af
   5F2F 3E 00         [ 7] 1348 	ld a, #0
   5F31 32 87 59      [13] 1349 	ld (callingFromOpts), a
   5F34 F1            [10] 1350 	pop af
                           1351 	;; Pablo
   5F35 21 8C 5E      [10] 1352 		ld hl, #PabloString
   5F38 11 F0 C8      [10] 1353 		ld de, #txt_credits1
   5F3B CD F9 59      [17] 1354 		call drawOptionsRefactor
                           1355 
   5F3E 21 B4 5E      [10] 1356 		ld hl, #ProgString
   5F41 11 40 C9      [10] 1357 		ld de, #menuPos_2
   5F44 CD F9 59      [17] 1358 		call drawOptionsRefactor
                           1359 
   5F47 21 D6 5E      [10] 1360 		ld hl, #IfAndMecString
   5F4A 11 90 C9      [10] 1361 		ld de, #txt_credits3
   5F4D CD F9 59      [17] 1362 		call drawOptionsRefactor
                           1363 
                           1364 		;; Credits 4?
                           1365 
                           1366 	;; Eu
   5F50 21 AA 5E      [10] 1367 		ld hl, #EuString
   5F53 11 80 CA      [10] 1368 		ld de, #txt_credits6
   5F56 CD F9 59      [17] 1369 		call drawOptionsRefactor
                           1370 
   5F59 21 F6 5E      [10] 1371 		ld hl, #ArtString
   5F5C 11 D0 CA      [10] 1372 		ld de, #txt_credits7
   5F5F CD F9 59      [17] 1373 		call drawOptionsRefactor
                           1374 
   5F62 21 01 5F      [10] 1375 		ld hl, #Art2String
   5F65 11 20 CB      [10] 1376 		ld de, #menuPos_4
   5F68 CD F9 59      [17] 1377 		call drawOptionsRefactor
                           1378 
                           1379 	;; Marcos
   5F6B 21 9A 5E      [10] 1380 		ld hl, #MarcosString
   5F6E 11 C0 CB      [10] 1381 		ld de, #txt_credits9
   5F71 CD F9 59      [17] 1382 		call drawOptionsRefactor
                           1383 
   5F74 21 14 5F      [10] 1384 		ld hl, #bsoString
   5F77 11 10 CC      [10] 1385 		ld de, #menuPos_5
   5F7A CD F9 59      [17] 1386 		call drawOptionsRefactor
                           1387 
   5F7D 21 B4 5E      [10] 1388 		ld hl, #ProgString
   5F80 11 60 CC      [10] 1389 		ld de, #txt_credits11
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 30.
Hexadecimal [16-Bits]



   5F83 CD F9 59      [17] 1390 		call drawOptionsRefactor
                           1391 
   5F86 21 D6 5E      [10] 1392 		ld hl, #IfAndMecString
   5F89 11 B0 CC      [10] 1393 		ld de, #txt_credits12
   5F8C CD F9 59      [17] 1394 		call drawOptionsRefactor
                           1395 
   5F8F 21 EE 5E      [10] 1396 		ld hl, #PhysString
   5F92 11 00 CD      [10] 1397 		ld de, #menuPos_6
   5F95 CD F9 59      [17] 1398 		call drawOptionsRefactor
                           1399 
                           1400 ;;	ld hl, #
                           1401 ;;	ld de, #txt_credits9
                           1402 ;;	drawOptionsRefactor
                           1403 ;;
                           1404 ;;	ld hl, #
                           1405 ;;	ld de, #txt_credits10
                           1406 ;;	drawOptionsRefactor
                           1407 ;;
                           1408 ;;	ld hl, #
                           1409 ;;	ld de, #txt_credits11
                           1410 ;;	drawOptionsRefactor
                           1411 ;;
                           1412 ;;	ld hl, #
                           1413 ;;	ld de, #txt_credits12
                           1414 ;;	drawOptionsRefactor
                           1415 ;;
                           1416 ;;	ld hl, #
                           1417 ;;	ld de, #txt_credits13
                           1418 ;;	drawOptionsRefactor
                           1419 ;;
                           1420 ;;	ld hl, #
                           1421 ;;	ld de, #txt_credits14
                           1422 ;;	drawOptionsRefactor
                           1423 
   5F98                    1424 	loop_credits:
   5F98 CD 8C 6F      [17] 1425 		call 	cpct_scanKeyboard_asm
                           1426 
   5F9B 21 02 04      [10] 1427 		ld 	hl, #Key_Return
   5F9E CD 9A 63      [17] 1428 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5FA1 FE 00         [ 7] 1429 		cp 	#0 
   5FA3 28 F3         [12] 1430 		jr 	z, loop_credits	;; Is enter key pressed?
   5FA5 C9            [10] 1431 	ret
