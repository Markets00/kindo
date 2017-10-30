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
   5896 4D 65 6E 75 00       23 menuString:				.asciz "Menu"
   589B 50 6C 61 79 00       24 playString:				.asciz "Play"
   58A0 4F 70 74 69 6F 6E    25 optionsString:			.asciz "Options"
        73 00
   58A8 43 72 65 64 69 74    26 creditsString:			.asciz "Credits"
        73 00
   58B0 49 6E 74 72 75 63    27 menuInstrucString:		.asciz "Intructions"
        74 69 6F 6E 73 00
                             28 
   58BC 3C 00                29 leftArrowCharacter: 	.asciz "<"
   58BE 3E 00                30 rightArrowCharacter:	.asciz ">"
   58C0 57 69 6E 20 43 6F    31 winCondString: 			.asciz "Win Condition"
        6E 64 69 74 69 6F
        6E 00
   58CE 54 69 6D 65 00       32 timeString: 			.asciz "Time"
   58D3 31 00                33 string_1:				.asciz "1"
   58D5 32 00                34 string_2:				.asciz "2"
   58D7 33 00                35 string_3:				.asciz "3"
                             36 
   58D9 53 63 6F 72 65 00    37 scoreString:			.asciz "Score"
   58DF 31 35 00             38 string_15:				.asciz "15"
   58E2 32 31 00             39 string_21:				.asciz "21"
   58E5 32 35 00             40 string_25:				.asciz "25"
   58E8 35 38 00             41 string_58:				.asciz "58"
                             42 
   58EB 4D 75 73 69 63 00    43 musicString:			.asciz "Music"
   58F1 4F 6E 00             44 onString:				.asciz "On"
   58F4 4F 66 66 00          45 offString:				.asciz "Off"
   58F8 00                   46 callingFromOpts: 		.db #0 ;; Are we calling from options?
                             47 
                             48 
                             49 ;; menuPos_X_sub 	-> For submenus, to the option menu
                             50 ;; menuPos_X 		-> Orignal position string (Strings on Menu, "<" on Options)
                             51 ;; menuPos_X_1 		-> String for options menu
                             52 ;; menuPos_X_2		-> ">" For Option menu
                             53 
                     C000    54 .equ menuPos_1_sub, 0xC000
                     C850    55 .equ menuPos_1, 0xC850
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                     C85B    56 .equ menuPos_1_1, 0xC85B
                     C870    57 .equ menuPos_1_2, 0xC870
                             58 
                     C0F0    59 .equ menuPos_2_sub, 0xC0F0
                     C940    60 .equ menuPos_2, 0xC940
                     C94B    61 .equ menuPos_2_1, 0xC94B
                     C960    62 .equ menuPos_2_2, 0xC960
                             63 
                     C1E0    64 .equ menuPos_3_sub, 0xC1E0
                     CA30    65 .equ menuPos_3, 0xCA30
                     CA3B    66 .equ menuPos_3_1, 0xCA3b
                     CA50    67 .equ menuPos_3_2, 0xCA50
                             68 
                     C2D0    69 .equ menuPos_4_sub, 0xC2D0
                     CB20    70 .equ menuPos_4, 0xCB20
                     CB2B    71 .equ menuPos_4_1, 0xCB2B
                     CB40    72 .equ menuPos_4_2, 0xCB40
                             73 
                     CC10    74 .equ menuPos_5, 0xCC10
                     CC1B    75 .equ menuPos_5_1, 0xCC1B
                     CC30    76 .equ menuPos_5_2, 0xCC30
                             77 
                     CD00    78 .equ menuPos_6, 0xCD00
                     CD0B    79 .equ menuPos_6_1, 0xCD0B
                     CD20    80 .equ menuPos_6_2, 0xCD20
                             81 
                     CDF0    82 .equ menuPos_7, 0xCDF0
                     CDFB    83 .equ menuPos_7_1, 0xCDFB
                     CE10    84 .equ menuPos_7_2, 0xCE10
                             85 
                     C88F    86 .equ cursorPosDef, 0xC88F
                             87 ;; .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
                             88 ;; .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
                             89 ;;.equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
                             90 ;;.equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.
                             91 
                     C6E0    92 .equ instrPos, 0xC6E0
                             93 
                             94 .globl _sprite_frisbeeMenu
                             95 
                     0002    96 cursor_W 	= 2
                     0008    97 cursor_H 	= 8
                     0006    98 max_index_value	= 6
                     00F0    99 addPosition	= 0xF0 			;; Sums to the next position (or substrct to the previous one)
                     FFFFFF10   100 subPosition	= #-240
   58F9 8F C8               101 cursorPos: 	.dw 0xC88F		;; Saves the cursor position
                            102 
                            103 ;; ====================================
                            104 ;; ====================================
                            105 ;; PUBLIC FUNCTIONS
                            106 ;; ====================================
                            107 ;; ====================================
   58FB                     108 menuStart::
   58FB 2E 10         [ 7]  109 	ld l, #16					;; Select the border colour
   58FD 26 54         [ 7]  110 	ld h, #0x54					;; Set the Black Colour
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   58FF CD B9 5F      [17]  111 	call cpct_setPALColour_asm
                            112 
   5902 CD EC 5B      [17]  113 	call cleanScreen		;;
   5905 CD FA 5B      [17]  114 	call initializeMenu 	;; 
                            115 
   5908 3E 00         [ 7]  116 	ld	a, #0			;; Initialize A to 0 as starting index for main menu
   590A CD 0E 59      [17]  117 	call menu_loop 			;; Checks the state
   590D C9            [10]  118 	ret
                            119 
                            120 ;;
                            121 ;;
                            122 ;;
   590E                     123 menu_loop::
                            124 
   590E CD 6D 5A      [17]  125 	call 	checkSelection
                            126 	;; We have on A the option selected
   5911 FE 00         [ 7]  127 	cp #0 					;; a - 0
   5913 20 01         [12]  128 	jr nz, menuStart_check1	;; if (a - 0) != 0
                            129 		;; else, a == 0 ;; Go Configure Match
   5915 C9            [10]  130 		ret
                            131 
   5916                     132 	menuStart_check1:
   5916 FE 01         [ 7]  133 		cp #1					;; a - 1
   5918 20 12         [12]  134 		jr nz, menuStart_check2	;; if (a - 1) != 0
                            135 			;; else, a == 1 ;; Go options
   591A F5            [11]  136 			push af
   591B 2A F9 58      [16]  137 			ld 	hl, (cursorPos)
   591E E5            [11]  138 			push hl
   591F CD 2D 59      [17]  139 			call menuOptionsStart
   5922 E1            [10]  140 			pop hl
   5923 22 F9 58      [16]  141 			ld (cursorPos), hl
   5926 CD FA 5B      [17]  142 			call initializeMenu
   5929 F1            [10]  143 			pop af
                            144 
   592A 18 E2         [12]  145 			jr menu_loop
                            146 
                            147 
   592C                     148 	menuStart_check2:
                            149 		;; Do stuff.
   592C C9            [10]  150 	ret
                            151 
                            152 ;;
                            153 ;;
                            154 ;;
   592D                     155 menuOptionsStart::
   592D 21 8F C8      [10]  156 	ld hl, #cursorPosDef
   5930 22 F9 58      [16]  157 	ld (cursorPos), hl
   5933 CD 26 5B      [17]  158 	call initializeOptionsMenu
                            159 
   5936 3E 00         [ 7]  160 	ld a, #0
   5938 CD 6D 5A      [17]  161 	call checkSelection
                            162 	;; Set variables game
   593B C9            [10]  163 	ret
                            164 
                            165 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            166 ;; Erase the draw on options
                            167 ;; HL <- what to print
                            168 ;; DE <- Where to print
                            169 ;; Modifies: BC
                            170 ;; ====================================
   593C                     171 eraseOptionsRefactor::
   593C 0E 03         [ 7]  172 	ld c, #3
   593E 06 03         [ 7]  173 	ld b, #3
   5940 CD B5 68      [17]  174 	call cpct_drawStringM1_f_asm
                            175 
   5943 C9            [10]  176 	ret
                            177 
                            178 ;; ====================================
                            179 ;; Refactors the draw on options
                            180 ;; HL <- what to print
                            181 ;; DE <- Where to print
                            182 ;; Modifies: BC
                            183 ;; ====================================
   5944                     184 drawOptionsRefactor::
   5944 0E 02         [ 7]  185 	ld c, #2
   5946 06 03         [ 7]  186 	ld b, #3
   5948 CD B5 68      [17]  187 	call cpct_drawStringM1_f_asm
                            188 
   594B C9            [10]  189 	ret
                            190 
                            191 ;; ====================================
                            192 ;; Gets the win condition string
                            193 ;; Modifies: A, HL, DE, BC
                            194 ;; ====================================
   594C                     195 getWinCondition::
   594C 3A E6 59      [13]  196 	ld a, (winIndex) 	;; a <- Win condition ; 0 -> Time, 1 -> Score
   594F FE 00         [ 7]  197 	cp #0						;; 
   5951 20 04         [12]  198 	jr nz, itsTime 				;; a != 0, then go time
   5953 21 D9 58      [10]  199 		ld hl, #scoreString		;; Charge score sprite
   5956 C9            [10]  200 		ret		;; Jump to draw
                            201 
   5957                     202 	itsTime:
   5957 21 CE 58      [10]  203 		ld hl, #timeString		;; Charge time sprite
                            204 
   595A C9            [10]  205 	ret
                            206 
                            207 ;; ====================================
                            208 ;; Prints the win condition string
                            209 ;; Modifies: A, HL, DE, BC
                            210 ;; ====================================
   595B                     211 printWinCondition::
                            212 	;; Prints win condition options
   595B CD 4C 59      [17]  213 	call getWinCondition
   595E 11 5B C8      [10]  214 	ld de, #menuPos_1_1
   5961 CD 44 59      [17]  215 	call drawOptionsRefactor
                            216 
   5964 C9            [10]  217 	ret
                            218 
                            219 ;; ====================================
                            220 ;; Gets the time string
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            221 ;; Modifies: A, HL, DE, BC
                            222 ;; ====================================
   5965                     223 getTimeOptions::
   5965 3A 1B 5A      [13]  224 	ld a, (timIndex)		;; a <- game_minute
   5968 FE 00         [ 7]  225 	cp #0					;;
   596A 20 04         [12]  226 	jr nz, itsTwoMinutes	;; a != 1, then go two minutes
   596C 21 D3 58      [10]  227 		ld hl, #string_1 	;; Charge the 1 string
   596F C9            [10]  228 		ret	;; Jump to draw
                            229 
   5970                     230 	itsTwoMinutes:
   5970 FE 01         [ 7]  231 		cp #1					;;
   5972 20 04         [12]  232 		jr nz, itsThreeMinutes	;; a != 2, then go two minutes
   5974 21 D5 58      [10]  233 			ld hl, #string_2 	;; Charge the 2 string
   5977 C9            [10]  234 			ret	;; Jump to draw
                            235 
   5978                     236 	itsThreeMinutes:
   5978 21 D7 58      [10]  237 		ld hl, #string_3 	;; Charge the 3 string
   597B C9            [10]  238 	ret
                            239 
                            240 ;; ====================================
                            241 ;; Prints the time string
                            242 ;; Modifies: A, HL, DE, BC
                            243 ;; ====================================
   597C                     244 printTimeOptions::
                            245 	;; Print time options
   597C CD 65 59      [17]  246 	call getTimeOptions
   597F 11 4B C9      [10]  247 	ld de, #menuPos_2_1
   5982 CD 44 59      [17]  248 	call drawOptionsRefactor
   5985 C9            [10]  249 	ret
                            250 
                            251 ;; ====================================
                            252 ;; Gets the score string
                            253 ;; Modifies: A, HL, DE, BC
                            254 ;; ====================================
   5986                     255 getScoreOptions::
   5986 3A 18 5A      [13]  256 	ld a, (scoIndex)		;; a <- game_maxScore
   5989 FE 00         [ 7]  257 	cp #0						;;
   598B 20 04         [12]  258 	jr nz, itsTwentyOneGoals	;; a != 11, then go two minutes
   598D 21 DF 58      [10]  259 		ld hl, #string_15 		;; Charge the 1 string
   5990 C9            [10]  260 		ret						;; Jump to draw
                            261 
   5991                     262 	itsTwentyOneGoals:
   5991 FE 01         [ 7]  263 		cp #1						;;
   5993 20 04         [12]  264 		jr nz, itsTwentyFiveGoals	;; a != 11, then go two minutes
   5995 21 E2 58      [10]  265 			ld hl, #string_21 		;; Charge the 1 string
   5998 C9            [10]  266 			ret						;; Jump to draw
                            267 
   5999                     268 	itsTwentyFiveGoals:
   5999 FE 02         [ 7]  269 		cp #2						;;
   599B 20 04         [12]  270 		jr nz, itsFiftyEightGoals	;; a != 11, then go two minutes
   599D 21 E5 58      [10]  271 			ld hl, #string_25 		;; Charge the 1 string
   59A0 C9            [10]  272 			ret						;; Jump to draw
                            273 
   59A1                     274 	itsFiftyEightGoals:
   59A1 21 E8 58      [10]  275 			ld hl, #string_58 	;; Charge the 1 string
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            276 
   59A4 C9            [10]  277 	ret
                            278 
                            279 ;; ====================================
                            280 ;; Prints the score string
                            281 ;; Modifies: A, HL, DE, BC
                            282 ;; ====================================
   59A5                     283 printScoreOptions::
                            284 	;; Print time options
   59A5 CD 86 59      [17]  285 	call getScoreOptions
   59A8 11 3B CA      [10]  286 	ld de, #menuPos_3_1
   59AB CD 44 59      [17]  287 	call drawOptionsRefactor
   59AE C9            [10]  288 	ret
                            289 
                            290 ;; ====================================
                            291 ;; Gets the music string
                            292 ;; Modifies: A, HL, DE, BC
                            293 ;; ====================================
   59AF                     294 getMusicOption::
   59AF 3A 1E 5A      [13]  295 	ld a, (musIndex) 	;;  a <- game_enableMusic
   59B2 FE 00         [ 7]  296 	cp #0						;;
   59B4 28 04         [12]  297 	jr z, itsMusicOff
   59B6 21 F1 58      [10]  298 		ld hl, #onString
   59B9 C9            [10]  299 		ret
                            300 
   59BA                     301 	itsMusicOff:
   59BA 21 F4 58      [10]  302 		ld hl, #offString
                            303 
   59BD C9            [10]  304 	ret
                            305 
                            306 ;; ====================================
                            307 ;; Prints the music string
                            308 ;; Modifies: A, HL, DE, BC
                            309 ;; ====================================
   59BE                     310 printMusicOptions::
   59BE CD AF 59      [17]  311 	call getMusicOption
   59C1 11 2B CB      [10]  312 	ld de, #menuPos_4_1
   59C4 CD 44 59      [17]  313 	call drawOptionsRefactor
                            314 
   59C7 C9            [10]  315 	ret
                            316 
                            317 ;; ====================================
                            318 ;; Checks the options strings
                            319 ;; Modifies: A, HL, DE, BC
                            320 ;; ====================================
   59C8                     321 printOptions::
                            322 
   59C8 CD 5B 59      [17]  323 	call printWinCondition
   59CB CD 7C 59      [17]  324 	call printTimeOptions
   59CE CD A5 59      [17]  325 	call printScoreOptions
   59D1 CD BE 59      [17]  326 	call printMusicOptions
                            327 
   59D4 C9            [10]  328 	ret
                            329 
   59D5                     330 getMaxIterator::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   59D5 F1            [10]  331 	pop af 		;; Get the iterator on A.
                            332 
   59D6 FE 00         [ 7]  333 	cp #0
   59D8 20 00         [12]  334 	jr nz, not_WinCondition
                            335 		;; Win Condition
   59DA                     336 	not_WinCondition:
   59DA FE 01         [ 7]  337 		cp #1
   59DC 20 00         [12]  338 		jr nz, not_Time
                            339 			;; Time
                            340 
   59DE                     341 	not_Time:
   59DE FE 02         [ 7]  342 		cp #2
   59E0 20 00         [12]  343 		jr nz, not_Score
                            344 			;; Score
                            345 
   59E2                     346 	not_Score:
                            347 		;; Music
                            348 
   59E2 C9            [10]  349 	ret
                            350 
                            351 ;; Max iterators
   59E3 02                  352 maxOn2:		.db #2
   59E4 03                  353 maxOn3:		.db #3
   59E5 04                  354 maxOn4:		.db #4
                            355 
                            356 ;; =======================================
                            357 ;; Win Condition Movements
                            358 ;; =======================================
   59E6 00                  359 winIndex:	.db #0
                            360 
   59E7                     361 moveLeftWinCond::
   59E7 3A E6 59      [13]  362 	ld a, (winIndex)
   59EA 3D            [ 4]  363 	dec a
   59EB FE FF         [ 7]  364 	cp #-1
   59ED 28 05         [12]  365 	jr z, maxWinCond_left
                            366 		;; We can move to the left
   59EF 32 E6 59      [13]  367 		ld (winIndex), a
   59F2 18 07         [12]  368 		jr printWinCond_left
                            369 
   59F4                     370 	maxWinCond_left:
   59F4 3A E3 59      [13]  371 		ld a, (maxOn2)
   59F7 3D            [ 4]  372 		dec a
   59F8 32 E6 59      [13]  373 		ld (winIndex), a
                            374 
   59FB                     375 	printWinCond_left:
   59FB CD 5B 59      [17]  376 		call printWinCondition
   59FE C9            [10]  377 	ret
                            378 
   59FF                     379 moveRightWinCond::
   59FF 3A E3 59      [13]  380 	ld a, (maxOn2)
   5A02 47            [ 4]  381 	ld b, a
   5A03 3A E6 59      [13]  382 	ld a, (winIndex)
   5A06 3C            [ 4]  383 	inc a
   5A07 B8            [ 4]  384 	cp b
   5A08 28 05         [12]  385 	jr z, minWinCond_right
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            386 		;; We can move to the right
   5A0A 32 E6 59      [13]  387 		ld (winIndex), a
   5A0D 18 05         [12]  388 		jr printWinCond_right
                            389 
   5A0F                     390 	minWinCond_right:
   5A0F 3E 00         [ 7]  391 		ld a, #0
   5A11 32 E6 59      [13]  392 		ld (winIndex), a
                            393 
   5A14                     394 	printWinCond_right:
   5A14 CD 5B 59      [17]  395 		call printWinCondition
   5A17 C9            [10]  396 	ret
                            397 
                            398 ;; =======================================
                            399 ;; Score Movements
                            400 ;; =======================================
   5A18 01                  401 scoIndex:	.db #1
                            402 
   5A19                     403 moveLeftScore::
   5A19 C9            [10]  404 	ret
                            405 
   5A1A                     406 moveRightScore::
   5A1A C9            [10]  407 	ret
                            408 
                            409 ;; =======================================
                            410 ;; Time Movements
                            411 ;; =======================================
   5A1B 01                  412 timIndex:	.db #1
                            413 
   5A1C                     414 moveLeftTime::
   5A1C C9            [10]  415 	ret
                            416 
   5A1D                     417 moveRightTime::
   5A1D C9            [10]  418 	ret
                            419 
                            420 ;; =======================================
                            421 ;; Music Movements
                            422 ;; =======================================
   5A1E 00                  423 musIndex:	.db #0
                            424 
   5A1F                     425 moveLeftMusic::
   5A1F C9            [10]  426 	ret
                            427 
   5A20                     428 moveRightMusic::
   5A20 C9            [10]  429 	ret
                            430 
                            431 ;; =======================================
                            432 ;;
                            433 ;; =======================================
   5A21                     434 checkLateral::
   5A21 F5            [11]  435 	push af
                            436 ;winMoveRight
   5A22 21 01 01      [10]  437 	ld 	hl, #Key_CursorLeft
   5A25 CD 9A 5F      [17]  438 	call 	cpct_isKeyPressed_asm	;; A <= True/False
   5A28 FE 00         [ 7]  439 	cp 	#0 
   5A2A 28 1C         [12]  440 	jr 	z, left_not_pressed			;; Is left key pressed?
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            441 		;; left pressed
   5A2C F1            [10]  442 		pop 	af
   5A2D FE 00         [ 7]  443 		cp #0
   5A2F 20 03         [12]  444 		jr nz, not_WinCondition_left
                            445 			;; Call Win Condition left
   5A31 CD E7 59      [17]  446 			call moveLeftWinCond
                            447 
   5A34                     448 		not_WinCondition_left:
   5A34 FE 01         [ 7]  449 			cp #1
   5A36 20 03         [12]  450 			jr nz, not_Time_left
                            451 				;; Time
   5A38 CD 1C 5A      [17]  452 				call moveLeftTime
                            453 
   5A3B                     454 		not_Time_left:
   5A3B FE 02         [ 7]  455 			cp #2
   5A3D 20 03         [12]  456 			jr nz, not_Score_left
                            457 				;; Score
   5A3F CD 19 5A      [17]  458 				call moveLeftScore
                            459 
   5A42                     460 		not_Score_left:
                            461 			;; Music
   5A42 CD 1F 5A      [17]  462 			call moveLeftMusic
                            463 
   5A45 F5            [11]  464 		push	af
   5A46 18 24         [12]  465 		jr right_not_pressed
                            466 
   5A48                     467 	left_not_pressed:
   5A48 21 00 02      [10]  468 		ld 	hl, #Key_CursorRight
   5A4B CD 9A 5F      [17]  469 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5A4E FE 00         [ 7]  470 		cp 	#0 
   5A50 28 1A         [12]  471 		jr 	z, right_not_pressed			;; Is left key pressed?
                            472 			;; right pressed
   5A52 F1            [10]  473 			pop 	af
   5A53 FE 00         [ 7]  474 			cp #0
   5A55 20 03         [12]  475 			jr nz, not_WinCondition_right
                            476 				;; Call Win Condition left
   5A57 CD FF 59      [17]  477 				call moveRightWinCond
                            478 
   5A5A                     479 			not_WinCondition_right:
   5A5A FE 01         [ 7]  480 				cp #1
   5A5C 20 03         [12]  481 				jr nz, not_Time_right
                            482 					;; Time
   5A5E CD 1D 5A      [17]  483 					call moveRightTime
                            484 
   5A61                     485 			not_Time_right:
   5A61 FE 02         [ 7]  486 				cp #2
   5A63 20 03         [12]  487 				jr nz, not_Score_right
                            488 					;; Score
   5A65 CD 1A 5A      [17]  489 					call moveRightScore
                            490 
   5A68                     491 			not_Score_right:
                            492 				;; Music
   5A68 CD 20 5A      [17]  493 				call moveRightMusic
                            494 
   5A6B F5            [11]  495 			push	af
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                            496 
   5A6C                     497 	right_not_pressed:
   5A6C C9            [10]  498 	ret
                            499 
                            500 ;; =======================================
                            501 ;; Mueve el índice a la posición indicada
                            502 ;; Recibe: A <= Index
                            503 ;; Modifica: AF, BC, DE, HL
                            504 ;; Devuelve:
                            505 ;;	A <= Selected index [0 - 6]
                            506 ;; =======================================
   5A6D                     507 checkSelection::
   5A6D                     508 	selection_waitting:
   5A6D F5            [11]  509 		push 	af
                            510 
   5A6E CD 8C 6B      [17]  511 		call 	cpct_scanKeyboard_asm
                            512 
   5A71 21 02 04      [10]  513 		ld 	hl, #Key_Return 
   5A74 CD 9A 5F      [17]  514 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5A77 FE 00         [ 7]  515 		cp 	#0 
   5A79 28 02         [12]  516 		jr 	z, enter_not_pressed	;; Is enter key pressed?
   5A7B F1            [10]  517 			pop af			;; A <= final index selected
   5A7C C9            [10]  518 			ret
                            519 
   5A7D                     520 		enter_not_pressed:
   5A7D F1            [10]  521 			pop af			;; A <= index value
   5A7E CD B0 5A      [17]  522 			call checkCursor	;; check cursor movement
   5A81 F5            [11]  523 			push af
                            524 
   5A82 3A F8 58      [13]  525 			ld 	a, (callingFromOpts)
   5A85 FE 00         [ 7]  526 			cp 	#0
   5A87 28 05         [12]  527 			jr 	z, not_options
   5A89 F1            [10]  528 				pop af
   5A8A CD 21 5A      [17]  529 				call checkLateral
   5A8D F5            [11]  530 				push af
   5A8E                     531 			not_options:
   5A8E F1            [10]  532 			pop af
   5A8F 18 DC         [12]  533 			jr selection_waitting
                            534 
   5A91 C9            [10]  535 	ret
                            536 
                            537 ;; =======================================
                            538 ;; Mueve el índice a la posición indicada
                            539 ;; Entrada:
                            540 ;;	HL <= pointer to new position
                            541 ;; Modifica: AF, BC, DE, HL
                            542 ;; =======================================
   5A92                     543 reDrawCursor::
   5A92 E5            [11]  544 	push hl
                            545 
   5A93 ED 5B F9 58   [20]  546 	ld de, (cursorPos)		;; alomejor esto no compila
   5A97 3E FF         [ 7]  547 	ld a, #0xFF
   5A99 06 08         [ 7]  548 	ld b, #cursor_H
   5A9B 0E 02         [ 7]  549 	ld c, #cursor_W
   5A9D CD C3 6A      [17]  550 	call cpct_drawSolidBox_asm	;; Erase last index position
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            551 
   5AA0 E1            [10]  552 	pop hl
   5AA1 22 F9 58      [16]  553 	ld (cursorPos), hl		;; Update cursorPos to the new position after erasing
                            554 
   5AA4 EB            [ 4]  555 	ex 	de, hl			;; DE <= pointer to new position
   5AA5 21 FC 4A      [10]  556 	ld	hl, #_sprite_frisbeeMenu;; HL <= cursor sprite pointer
   5AA8 06 08         [ 7]  557 	ld 	b, #cursor_H		;; B = height
   5AAA 0E 02         [ 7]  558 	ld 	c, #cursor_W		;; C = width
   5AAC CD 0D 68      [17]  559 	call cpct_drawSprite_asm
                            560 
   5AAF C9            [10]  561 	ret
                            562 
                            563 ;; =================================
                            564 ;; Chequea si el índice debe moverse
                            565 ;; Entrada:
                            566 ;;	A <= starting index
                            567 ;; Modifica: AF, BC, DE, HL
                            568 ;; Devuelve:
                            569 ;; 	A => selected index
                            570 ;; =================================
   5AB0                     571 checkCursor::
   5AB0 F5            [11]  572 	push 	af						;; Save the index at the stack
   5AB1 21 00 01      [10]  573 	ld 	hl, #Key_CursorUp
   5AB4 CD 9A 5F      [17]  574 	call 	cpct_isKeyPressed_asm	;; A <= True/False
   5AB7 FE 00         [ 7]  575 	cp 	#0 
   5AB9 28 19         [12]  576 	jr 	z, up_not_pressed			;; Is up key pressed?
                            577 		;; Up pressed
   5ABB F1            [10]  578 		pop af
   5ABC 3D            [ 4]  579 		dec a
   5ABD FA D2 5A      [10]  580 		jp	m, cant_dec_index
                            581 			;; Decrement index
   5AC0 F5            [11]  582 			push af				;; Save the index
                            583 
   5AC1 2A F9 58      [16]  584 			ld 	hl, (cursorPos)		;; HL <= Cursor position
   5AC4 11 10 FF      [10]  585 			ld	de, #subPosition	;; DE <= Negative value to substract to cursor position
   5AC7 19            [11]  586 			add	hl, de				;; HL <= Cursor position - SubPosition
   5AC8 CD 92 5A      [17]  587 			call 	reDrawCursor
                            588 
   5ACB 3E 0A         [ 7]  589 			ld	a, #10
   5ACD CD FB 5A      [17]  590 			call 	wait_X_halts	;; Waits a amout of halts * 8.
                            591 
   5AD0 F1            [10]  592 			pop af					;; Restore the index before looping
   5AD1 C9            [10]  593 			ret
                            594 
   5AD2                     595 			cant_dec_index:
   5AD2 3C            [ 4]  596 				inc a 				;; Restore index value
   5AD3 C9            [10]  597 				ret
                            598 
   5AD4                     599 	up_not_pressed:
   5AD4 21 00 04      [10]  600 		ld 	hl, #Key_CursorDown
   5AD7 CD 9A 5F      [17]  601 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   5ADA FE 00         [ 7]  602 		cp 	#0 
   5ADC 28 1B         [12]  603 		jr 	z, down_not_pressed	;; Is down key pressed?
                            604 			;; Down pressed
   5ADE F1            [10]  605 			pop 	af
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   5ADF 3C            [ 4]  606 			inc 	a
   5AE0 FE 06         [ 7]  607 			cp  	#max_index_value
   5AE2 F2 F7 5A      [10]  608 			jp	p, cant_inc_index
                            609 				;; increment index
   5AE5 F5            [11]  610 				push af					;; Save the index
                            611 
   5AE6 2A F9 58      [16]  612 				ld 	hl, (cursorPos)		;; HL <= Cursor position
   5AE9 11 F0 00      [10]  613 				ld	de, #addPosition	;; DE <= Positive value to add to cursor position
   5AEC 19            [11]  614 				add	hl, de				;; HL <= Cursor position + AddPosition
   5AED CD 92 5A      [17]  615 				call 	reDrawCursor
                            616 
   5AF0 3E 0A         [ 7]  617 				ld	a, #10
   5AF2 CD FB 5A      [17]  618 				call 	wait_X_halts
                            619 
   5AF5 F1            [10]  620 				pop af				;; Restore the index before looping
   5AF6 C9            [10]  621 				ret
                            622 
   5AF7                     623 			cant_inc_index:
   5AF7 3D            [ 4]  624 				dec a 				;; Restore index value
   5AF8 C9            [10]  625 				ret
                            626 
   5AF9                     627 	down_not_pressed:
                            628 		;; Any key pressed
   5AF9 F1            [10]  629 		pop af
   5AFA C9            [10]  630 	ret
                            631 
                            632 ;; =================================
                            633 ;; Waits 8 halts, N times
                            634 ;; In:
                            635 ;;	A <= N times
                            636 ;; Modifies: A
                            637 ;; =================================
   5AFB                     638 wait_X_halts::
   5AFB 3D            [ 4]  639 	dec a
   5AFC 28 09         [12]  640 	jr z, wait_halts_exit
   5AFE 76            [ 4]  641 		halt
   5AFF 76            [ 4]  642 		halt
   5B00 76            [ 4]  643 		halt
   5B01 76            [ 4]  644 		halt
   5B02 76            [ 4]  645 		halt
   5B03 76            [ 4]  646 		halt
   5B04 76            [ 4]  647 		halt
   5B05 18 F4         [12]  648 		jr wait_X_halts
   5B07                     649 	wait_halts_exit:
   5B07 C9            [10]  650 	ret
                            651 
                            652 ;; =======================================
                            653 ;; Sets the palette to mode 0
                            654 ;; Modifies: C, HL, DE
                            655 ;; =======================================
                            656 ;;setPaletteM0::
                            657 ;;	ld c, #0					;; Mode 0
                            658 ;;	call cpct_setVideoMode_asm
                            659 ;;
                            660 ;;	ld hl, #paletteM0			;; hl <- paletteM0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            661 ;;	ld de, #16 					;; 16 Colours
                            662 ;;	call cpct_setPalette_asm
                            663 ;;
                            664 ;;	ret
                            665 
                            666 ;; =======================================
                            667 ;; Sets the palette to mode 1
                            668 ;; Modifies: C, HL, DE
                            669 ;; =======================================
   5B08                     670 setPaletteM1::
   5B08 0E 01         [ 7]  671 	ld c, #1					;; Mode 1
   5B0A CD A3 6A      [17]  672 	call cpct_setVideoMode_asm
                            673 
   5B0D 21 6A 5C      [10]  674 	ld hl, #paletteM1			;; hl <- paletteM1
   5B10 11 04 00      [10]  675 	ld de, #4 					;; 4 Colours
   5B13 CD A6 5F      [17]  676 	call cpct_setPalette_asm
                            677 
   5B16 C9            [10]  678 	ret
                            679 
                            680 ;; =======================================
                            681 ;; Sets the palette to black on mode 1
                            682 ;; Modifies: C, HL, DE
                            683 ;; =======================================
   5B17                     684 setPaletteBlackM1::
   5B17 0E 01         [ 7]  685 	ld c, #1					;; Mode 1
   5B19 CD A3 6A      [17]  686 	call cpct_setVideoMode_asm
                            687 
   5B1C 21 6E 5C      [10]  688 	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
   5B1F 11 04 00      [10]  689 	ld de, #4 					;; 4 Colours
   5B22 CD A6 5F      [17]  690 	call cpct_setPalette_asm
                            691 
   5B25 C9            [10]  692 	ret
                            693 
                            694 ;; =======================================
                            695 ;; Print the options menu
                            696 ;; =======================================
   5B26                     697 initializeOptionsMenu::
                            698 
   5B26 3E 01         [ 7]  699 	ld a, #1
   5B28 32 F8 58      [13]  700 	ld (callingFromOpts), a
                            701 
   5B2B CD EC 5B      [17]  702 	call cleanScreen
                            703 
                            704 	;; Print winCondString
   5B2E 21 C0 58      [10]  705 	ld hl, #winCondString
   5B31 11 00 C0      [10]  706 	ld de, #menuPos_1_sub
   5B34 CD 44 59      [17]  707 	call drawOptionsRefactor
                            708 
                            709 	;; Print scoreString
   5B37 21 CE 58      [10]  710 	ld hl, #timeString
   5B3A 11 F0 C0      [10]  711 	ld de, #menuPos_2_sub
   5B3D CD 44 59      [17]  712 	call drawOptionsRefactor
                            713 
                            714 	;; Print timeString
   5B40 21 D9 58      [10]  715 	ld hl, #scoreString
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



   5B43 11 E0 C1      [10]  716 	ld de, #menuPos_3_sub
   5B46 CD 44 59      [17]  717 	call drawOptionsRefactor
                            718 
                            719 	;; Print musicString
   5B49 21 EB 58      [10]  720 	ld hl, #musicString
   5B4C 11 D0 C2      [10]  721 	ld de, #menuPos_4_sub
   5B4F CD 44 59      [17]  722 	call drawOptionsRefactor
                            723 
                            724 	;; Print left arrows string
   5B52 21 BC 58      [10]  725 	ld hl, #leftArrowCharacter
   5B55 11 50 C8      [10]  726 	ld de, #menuPos_1
   5B58 CD 44 59      [17]  727 	call drawOptionsRefactor
                            728 
   5B5B 21 BC 58      [10]  729 	ld hl, #leftArrowCharacter
   5B5E 11 40 C9      [10]  730 	ld de, #menuPos_2
   5B61 CD 44 59      [17]  731 	call drawOptionsRefactor
                            732 
   5B64 21 BC 58      [10]  733 	ld hl, #leftArrowCharacter
   5B67 11 30 CA      [10]  734 	ld de, #menuPos_3
   5B6A CD 44 59      [17]  735 	call drawOptionsRefactor
                            736 
   5B6D 21 BC 58      [10]  737 	ld hl, #leftArrowCharacter
   5B70 11 20 CB      [10]  738 	ld de, #menuPos_4
   5B73 CD 44 59      [17]  739 	call drawOptionsRefactor
                            740 
   5B76 21 BC 58      [10]  741 	ld hl, #leftArrowCharacter
   5B79 11 10 CC      [10]  742 	ld de, #menuPos_5
   5B7C CD 44 59      [17]  743 	call drawOptionsRefactor
                            744 
   5B7F 21 BC 58      [10]  745 	ld hl, #leftArrowCharacter
   5B82 11 00 CD      [10]  746 	ld de, #menuPos_6
   5B85 CD 44 59      [17]  747 	call drawOptionsRefactor
                            748 
   5B88 21 BC 58      [10]  749 	ld hl, #leftArrowCharacter
   5B8B 11 F0 CD      [10]  750 	ld de, #menuPos_7
   5B8E CD 44 59      [17]  751 	call drawOptionsRefactor
                            752 
                            753 	;; Print right arrows string
   5B91 21 BE 58      [10]  754 	ld hl, #rightArrowCharacter
   5B94 11 70 C8      [10]  755 	ld de, #menuPos_1_2
   5B97 CD 44 59      [17]  756 	call drawOptionsRefactor
                            757 
   5B9A 21 BE 58      [10]  758 	ld hl, #rightArrowCharacter
   5B9D 11 60 C9      [10]  759 	ld de, #menuPos_2_2
   5BA0 CD 44 59      [17]  760 	call drawOptionsRefactor
                            761 
   5BA3 21 BE 58      [10]  762 	ld hl, #rightArrowCharacter
   5BA6 11 50 CA      [10]  763 	ld de, #menuPos_3_2
   5BA9 CD 44 59      [17]  764 	call drawOptionsRefactor
                            765 
   5BAC 21 BE 58      [10]  766 	ld hl, #rightArrowCharacter
   5BAF 11 40 CB      [10]  767 	ld de, #menuPos_4_2
   5BB2 CD 44 59      [17]  768 	call drawOptionsRefactor
                            769 
   5BB5 21 BE 58      [10]  770 	ld hl, #rightArrowCharacter
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



   5BB8 11 30 CC      [10]  771 	ld de, #menuPos_5_2
   5BBB CD 44 59      [17]  772 	call drawOptionsRefactor
                            773 
                            774 
   5BBE 21 BE 58      [10]  775 	ld hl, #rightArrowCharacter
   5BC1 11 20 CD      [10]  776 	ld de, #menuPos_6_2
   5BC4 CD 44 59      [17]  777 	call drawOptionsRefactor
                            778 
   5BC7 21 BE 58      [10]  779 	ld hl, #rightArrowCharacter
   5BCA 11 10 CE      [10]  780 	ld de, #menuPos_7_2
   5BCD CD 44 59      [17]  781 	call drawOptionsRefactor
                            782 
                            783 	;; Print the instructions
   5BD0 21 B0 58      [10]  784 	ld hl, #menuInstrucString
   5BD3 11 E0 C6      [10]  785 	ld de, #instrPos
   5BD6 CD 44 59      [17]  786 	call drawOptionsRefactor
                            787 
                            788 	;; Print the cursor
   5BD9 21 FC 4A      [10]  789 	ld	hl, #_sprite_frisbeeMenu
   5BDC ED 5B F9 58   [20]  790 	ld 	de, (cursorPos)
   5BE0 06 08         [ 7]  791 	ld 	b, #cursor_H 		;; B = ent height
   5BE2 0E 02         [ 7]  792 	ld 	c, #cursor_W		;; C = ent width
   5BE4 CD 0D 68      [17]  793 	call cpct_drawSprite_asm
                            794 
   5BE7 CD C8 59      [17]  795 	call printOptions
   5BEA C9            [10]  796 	ret
                            797 
                            798 ;; ====================================
                            799 ;; ====================================
                            800 ;; PRIVATE FUNCTIONS
                            801 ;; ====================================
                            802 ;; ====================================
                            803 
   5BEB                     804 checkUserInput:
                            805 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            806 	;; Reading keyboard example
                            807 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            808 	;; 	call cpct_scanKeyboard_asm
                            809 	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
                            810 	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
                            811 	;; 	cp 	#0 			;; A == 0?
                            812 	;; 	jr 	z, up_not_pressed
                            813 	;; 		;; Up is pressed code
                            814 	;; 		call 	moveUp	
                            815 	;; 	up_not_pressed:
                            816 	;; 		;; Up is not pressed code
                            817 	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
                            818 	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
                            819 	;; 		cp 	#0 				;; A == 0?
                            820 	;; 		jr 	z, down_not_pressed
                            821 	;; 			;; Down is pressed code
                            822 	;; 			call 	moveDown	
                            823 	;; 		down_not_pressed:
                            824 	;; 		;; Down is not pressed code
                            825 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



   5BEB C9            [10]  826 	ret
                            827 
                            828 ;; ====================================
                            829 ;; Clears the cleanScreen
                            830 ;; Modifies: HL, DE, BC
                            831 ;; ====================================
   5BEC                     832 cleanScreen::
                            833 	;; Clean from C000 to EFFF
   5BEC 21 00 C0      [10]  834 	ld	hl, #menuPos_1_sub			;; HL <= Copy pointer
   5BEF 11 01 C0      [10]  835 	ld	de, #0xC001			;; DE <= Write pointer
   5BF2 36 FF         [10]  836 	ld	(hl), #0xFF			;; Set to 0 where HL points
   5BF4 01 00 40      [10]  837 	ld	bc, #0x4000			;; BC <= Times to repeat
   5BF7 ED B0         [21]  838 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            839 
   5BF9 C9            [10]  840 	ret
                            841 
                            842 ;; ====================================
                            843 ;; Write the menu strings
                            844 ;; Modifies: HL, DE, BC
                            845 ;; ====================================
   5BFA                     846 initializeMenu:
   5BFA CD 08 5B      [17]  847 	call setPaletteM1
   5BFD CD EC 5B      [17]  848 	call cleanScreen
                            849 
   5C00 F5            [11]  850 	push af
   5C01 3E 00         [ 7]  851 	ld a, #0
   5C03 32 F8 58      [13]  852 	ld (callingFromOpts), a
   5C06 F1            [10]  853 	pop af
                            854 
                            855 	;; Print Menu
   5C07 21 96 58      [10]  856 	ld hl, #menuString
   5C0A 11 00 C0      [10]  857 	ld de, #menuPos_1_sub
   5C0D CD 44 59      [17]  858 	call drawOptionsRefactor
                            859 
                            860 	;; Print Play
   5C10 21 9B 58      [10]  861 	ld hl, #playString
   5C13 11 50 C8      [10]  862 	ld de, #menuPos_1
   5C16 CD 44 59      [17]  863 	call drawOptionsRefactor
                            864 
                            865 	;; Print Options
   5C19 21 A0 58      [10]  866 	ld hl, #optionsString
   5C1C 11 40 C9      [10]  867 	ld de, #menuPos_2
   5C1F CD 44 59      [17]  868 	call drawOptionsRefactor
                            869 
   5C22 21 96 58      [10]  870 	ld hl, #menuString
   5C25 11 30 CA      [10]  871 	ld de, #menuPos_3
   5C28 CD 44 59      [17]  872 	call drawOptionsRefactor
                            873 
   5C2B 21 9B 58      [10]  874 	ld hl, #playString
   5C2E 11 20 CB      [10]  875 	ld de, #menuPos_4
   5C31 CD 44 59      [17]  876 	call drawOptionsRefactor
                            877 
   5C34 21 A0 58      [10]  878 	ld hl, #optionsString
   5C37 11 10 CC      [10]  879 	ld de, #menuPos_5
   5C3A CD 44 59      [17]  880 	call drawOptionsRefactor
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



                            881 
   5C3D 21 96 58      [10]  882 	ld hl, #menuString
   5C40 11 00 CD      [10]  883 	ld de, #menuPos_6
   5C43 CD 44 59      [17]  884 	call drawOptionsRefactor
                            885 
   5C46 21 9B 58      [10]  886 	ld hl, #playString
   5C49 11 F0 CD      [10]  887 	ld de, #menuPos_7
   5C4C CD 44 59      [17]  888 	call drawOptionsRefactor
                            889 
   5C4F 21 B0 58      [10]  890 	ld hl, #menuInstrucString
   5C52 11 E0 C6      [10]  891 	ld de, #instrPos
   5C55 CD 44 59      [17]  892 	call drawOptionsRefactor
                            893 
                            894 	;; Print the cursor
   5C58 21 FC 4A      [10]  895 	ld	hl, #_sprite_frisbeeMenu
   5C5B ED 5B F9 58   [20]  896 	ld 	de, (cursorPos)
   5C5F 06 08         [ 7]  897 	ld 	b, #cursor_H 		;; B = height
   5C61 0E 02         [ 7]  898 	ld 	c, #cursor_W		;; C = width
   5C63 CD 0D 68      [17]  899 	call cpct_drawSprite_asm
                            900 
   5C66 C9            [10]  901 	ret
                            902 
                            903 ;; ========================
                            904 ;; Print Credits
                            905 ;; ========================
   5C67                     906 printCreditLine:
                            907 	;;ld hl, #elString
                            908 	;;ld de, #video_memory
                            909 	;;ld c, #Color_Letra
                            910 	;;cd b, #Color_fondo
                            911 ;;
                            912 	;;call cpct_drawStringM1_f_asm
                            913 
   5C67 C9            [10]  914 	ret
