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
                             23 .globl cpct_drawStringM1_asm
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
                             19 ;; ====================================
                             20 ;; ====================================
                             21 ;; GAME PUBLIC DATA
                             22 ;; ====================================
                             23 ;; ====================================
                     0050    24 .equ RIGHT_LIMIT,	80
                     0000    25 .equ LEFT_LIMIT,	0
                     001E    26 .equ TOP_LIMIT,	 	30
                     00C8    27 .equ BOTTOM_LIMIT,	200
                     0028    28 .equ CENTER_LIMIT,	40
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
                              7 ;; definición de las teclas que necesitaremos
                     0100     8   Key_CursorUp     = 0x0100
                     0101     9   Key_CursorLeft   = 0x0101
                     0400    10   Key_CursorDown   = 0x0400
                     0200    11   Key_CursorRight  = 0x0200
                     8005    12   Key_Space        = 0x8005
                     4000    13   Key_Enter        = 0x4000
                             14 
                             15 ;; ====================================
                             16 ;; ====================================
                             17 ;; PRIVATE DATA
                             18 ;; ====================================
                             19 ;; ====================================
                             20 
                             21 ;; .equ mi_constante0, 0
                             22 ;; .equ mi_constante1, 1
   589B 4D 65 6E 75 00       23 menuString:				.asciz "Menu"
   58A0 50 6C 61 79 00       24 playString:				.asciz "Play"
   58A5 4F 70 74 69 6F 6E    25 optionsString:			.asciz "Options"
        73 00
   58AD 43 72 65 64 69 74    26 creditsString:			.asciz "Credits"
        73 00
   58B5 49 6E 74 72 75 63    27 menuInstrucString:		.asciz "Intructions"
        74 69 6F 6E 73 00
                             28 
   58C1 3C 00                29 leftArrowCharacter: 	.asciz "<"
   58C3 3E 00                30 rightArrowCharacter:	.asciz ">"
   58C5 54 69 6D 65 00       31 timeString: 			.asciz "Time"
   58CA 53 63 6F 72 65 00    32 scoreString:			.asciz "Score"
   58D0 57 69 6E 20 43 6F    33 winCondString: 			.asciz "Win Condition"
        6E 64 69 74 69 6F
        6E 00
                             34 
                     C850    35 .equ menuPos_1, 0xC850
                     C940    36 .equ menuPos_2, 0xC940
                     CA30    37 .equ menuPos_3, 0xCA30
                     CB20    38 .equ menuPos_4, 0xCB20
                     CC10    39 .equ menuPos_5, 0xCC10
                     CD00    40 .equ menuPos_6, 0xCD00
                     CDF0    41 .equ menuPos_7, 0xCDF0
                             42 
                     00F0    43 .equ sumPos, 0xF0 			;; Sums to the next position (or substrct to the previous one)
                     FFFFFF10    44 .equ subPos, #-240
   58DE 8F C8                45 cursorPos: 	.dw 0xC88F		;; Saves the cursor position
                     C88F    46 .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
                     C97F    47 .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
                             48 ;;.equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
                             49 ;;.equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.
                             50 
                     C6E0    51 .equ instrPos, 0xC6E0
                             52 
                             53 .globl _sprite_frisbeeMenu
                             54 
                             55 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             56 ;; ====================================
                             57 ;; PUBLIC FUNCTIONS
                             58 ;; ====================================
                             59 ;; ====================================
   58E0                      60 menuStart::
   58E0 CD D8 59      [17]   61 	call 	initializeMenu
                             62 
   58E3 21 F0 4A      [10]   63 	ld	hl, #_sprite_frisbeeMenu
   58E6 ED 5B DE 58   [20]   64 	ld 	de, (cursorPos)
   58EA 06 08         [ 7]   65 	ld 	b, #8 		;; B = ent height
   58EC 0E 02         [ 7]   66 	ld 	c, #2		;; C = ent width
   58EE CD 26 66      [17]   67 	call cpct_drawSprite_asm
                             68 
   58F1 3E 00         [ 7]   69 	ld a, #0		;; Saving on i the iterator
   58F3 CD 05 59      [17]   70 	call moveCursor
   58F6 F1            [10]   71 	pop af
                             72 	;; if i == 0 -> play
                             73 	;; if i == 1 -> options
                             74 
                             75 	;; Do stuff here...
                             76 	;; Do stuff here...
                             77 	;; Do stuff here...
   58F7 C9            [10]   78 	ret 
                             79 
                             80 ;; reDrawCursor::
                             81 ;; 
                             82 ;; 	ld de, #cursorPos
                             83 ;; 	ld a, #0xFF
                             84 ;; 	ld c, #2
                             85 ;; 	ld b, #8
                             86 ;; 
                             87 ;; 	call cpct_drawSolidBox_asm
                             88 ;; 
                             89 ;; 	ld	hl, _sprite_frisbeeMenu
                             90 ;; 	ld 	de, (nextCursorPos)
                             91 ;; 	ld 	b, #8		;; B = ent height
                             92 ;; 	ld 	c, #2		;; C = ent width
                             93 ;; 	call cpct_drawSprite_asm
                             94 ;; 
                             95 ;; 	ret
                             96 
                             97 ;; Entrada: A <= N times
   58F8                      98 wait_X_halts::
   58F8 3D            [ 4]   99 	dec a
   58F9 28 09         [12]  100 	jr z, wait_halts_exit
   58FB 76            [ 4]  101 		halt
   58FC 76            [ 4]  102 		halt
   58FD 76            [ 4]  103 		halt
   58FE 76            [ 4]  104 		halt
   58FF 76            [ 4]  105 		halt
   5900 76            [ 4]  106 		halt
   5901 76            [ 4]  107 		halt
   5902 18 F4         [12]  108 		jr wait_X_halts
   5904                     109 	wait_halts_exit:
   5904 C9            [10]  110 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            111 
   5905                     112 moveCursor::
   5905 F5            [11]  113 	push af 		;; Saving iterator on the stack
                            114 
   5906 21 F0 4A      [10]  115 	ld	hl, #_sprite_frisbeeMenu
   5909 ED 5B DE 58   [20]  116 	ld 	de, (cursorPos)
   590D 06 08         [ 7]  117 	ld 	b, #8 		;; B = ent height
   590F 0E 02         [ 7]  118 	ld 	c, #2		;; C = ent width
   5911 CD 26 66      [17]  119 	call cpct_drawSprite_asm
                            120 
   5914 F1            [10]  121 	pop af
   5915                     122 	moveCursor_iterator:
   5915 F5            [11]  123 		push af
   5916 CD B3 68      [17]  124 		call cpct_scanKeyboard_asm
   5919 21 00 40      [10]  125 		ld 	hl, #Key_Enter				;; HL <- Key_Enter
   591C CD 91 5D      [17]  126 		call 	cpct_isKeyPressed_asm	;; A = True/False
   591F FE 00         [ 7]  127 		cp 	#0 							;; A == 0?
   5921 20 6A         [12]  128 		jr 	nz, moveCursor_exit			;; If ENTER , then exit.
                            129 			;; Enter not pressed
   5923 21 00 01      [10]  130 			ld hl, #Key_CursorUp
   5926 CD 91 5D      [17]  131 			call 	cpct_isKeyPressed_asm	;; A = True/False
   5929 FE 00         [ 7]  132 			cp 	#0 							;; A == 0?
   592B 28 28         [12]  133 			jr 	z, checkDown_Movement		;; checkUp_Movement
                            134 				;; else: You hitted UP
   592D F1            [10]  135 				pop af 						;; Charge the iterator
   592E FE 00         [ 7]  136 				cp #0
   5930 28 54         [12]  137 				jr z, moveCursor_iterator2
                            138 					;; You can go UP
   5932 3D            [ 4]  139 					dec a 					;; a--
   5933 F5            [11]  140 					push af
                            141 					;; **TODO**: Repintar cursor
   5934 2A DE 58      [16]  142 						ld hl, (cursorPos)
   5937 EB            [ 4]  143 						ex de, hl
   5938 3E FF         [ 7]  144 						ld a, #0xFF
   593A 0E 02         [ 7]  145 						ld c, #2
   593C 06 08         [ 7]  146 						ld b, #8
                            147 
   593E CD EA 67      [17]  148 						call cpct_drawSolidBox_asm ;; Destroyed Register values AF, BC, DE, HL
                            149 
   5941 2A DE 58      [16]  150 						ld hl, (cursorPos)
   5944 11 10 FF      [10]  151 						ld de, #subPos
   5947 19            [11]  152 						add hl, de
   5948 EB            [ 4]  153 						ex de, hl
                            154 
   5949 21 F0 4A      [10]  155 						ld	hl, #_sprite_frisbeeMenu
   594C 06 08         [ 7]  156 						ld 	b, #8		;; B = ent height
   594E 0E 02         [ 7]  157 						ld 	c, #2		;; C = ent width
   5950 CD 26 66      [17]  158 						call cpct_drawSprite_asm
                            159 
   5953 18 31         [12]  160 						jr moveCursor_iterator2
                            161 
   5955                     162 			checkDown_Movement:
   5955 21 00 04      [10]  163 				ld hl, #Key_CursorDown
   5958 CD 91 5D      [17]  164 				call 	cpct_isKeyPressed_asm	;; A = True/False
   595B FE 00         [ 7]  165 				cp #0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   595D 28 27         [12]  166 				jr 	z, moveCursor_iterator2		;; Iterate
                            167 					;; You hitted DOWN
   595F F1            [10]  168 					pop af 						;; Charge the iterator
   5960 FE 02         [ 7]  169 					cp #2						;; a - 2 !!! (MAXIMUM OPTION ON MENU)
   5962 F2 86 59      [10]  170 					jp p, moveCursor_iterator2	;; a==2
                            171 						;; You can go down
   5965 3C            [ 4]  172 						inc a
   5966 F5            [11]  173 						push af
                            174 						;; **TODO**: Repintar cursor
   5967 2A DE 58      [16]  175 						ld hl, (cursorPos)
   596A EB            [ 4]  176 						ex de, hl
   596B 3E FF         [ 7]  177 						ld a, #0xFF
   596D 0E 02         [ 7]  178 						ld c, #2
   596F 06 08         [ 7]  179 						ld b, #8
                            180 
   5971 CD EA 67      [17]  181 						call cpct_drawSolidBox_asm ;; Destroyed Register values AF, BC, DE, HL
                            182 
   5974 2A DE 58      [16]  183 						ld hl, (cursorPos)
   5977 11 F0 00      [10]  184 						ld de, #sumPos
   597A 19            [11]  185 						add hl, de
   597B EB            [ 4]  186 						ex de, hl
                            187 
   597C 21 F0 4A      [10]  188 						ld	hl, #_sprite_frisbeeMenu
   597F 06 08         [ 7]  189 						ld 	b, #8		;; B = ent height
   5981 0E 02         [ 7]  190 						ld 	c, #2		;; C = ent width
   5983 CD 26 66      [17]  191 						call cpct_drawSprite_asm
                            192 
   5986                     193 	moveCursor_iterator2:
   5986 3E 05         [ 7]  194 		ld a, #5
   5988 CD F8 58      [17]  195 		call wait_X_halts
   598B 18 88         [12]  196 		jr moveCursor_iterator
   598D                     197 	moveCursor_exit:
   598D C9            [10]  198 	ret
                            199 
                            200 ;; Sets the palette to mode 0
                            201 ;;setPaletteM0::
                            202 ;;	ld c, #0					;; Mode 0
                            203 ;;	call cpct_setVideoMode_asm
                            204 ;;
                            205 ;;	ld hl, #paletteM0			;; hl <- paletteM0
                            206 ;;	ld de, #16 					;; 16 Colours
                            207 ;;	call cpct_setPalette_asm
                            208 ;;
                            209 ;;	ret
                            210 
                            211 ;; Sets the palette to mode 1
   598E                     212 setPaletteM1::
   598E 0E 01         [ 7]  213 	ld c, #1					;; Mode 1
   5990 CD C6 67      [17]  214 	call cpct_setVideoMode_asm
                            215 
   5993 21 61 5A      [10]  216 	ld hl, #paletteM1			;; hl <- paletteM1
   5996 11 04 00      [10]  217 	ld de, #4 					;; 4 Colours
   5999 CD 9D 5D      [17]  218 	call cpct_setPalette_asm
                            219 
   599C C9            [10]  220 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            221 
                            222 ;; Sets the palette to black on mode 1
   599D                     223 setPaletteBlackM1::
   599D 0E 01         [ 7]  224 	ld c, #1					;; Mode 1
   599F CD C6 67      [17]  225 	call cpct_setVideoMode_asm
                            226 
   59A2 21 65 5A      [10]  227 	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
   59A5 11 04 00      [10]  228 	ld de, #4 					;; 4 Colours
   59A8 CD 9D 5D      [17]  229 	call cpct_setPalette_asm
                            230 
   59AB C9            [10]  231 	ret
                            232 
   59AC                     233 menuOptions::
                            234 
                            235 	;; Clean from C000 to EFFF
   59AC 21 00 C0      [10]  236 	ld	hl, #0xC000			;; HL <= Copy pointer
   59AF 11 01 C0      [10]  237 	ld	de, #0xC001			;; DE <= Write pointer
   59B2 36 FF         [10]  238 	ld	(hl), #0xFF			;; Set to 0 where HL points
   59B4 01 00 40      [10]  239 	ld	bc, #0x4000			;; BC <= Times to repeat
   59B7 ED B0         [21]  240 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            241 
                            242 	;; Print Menu
   59B9 21 D0 58      [10]  243 	ld hl, #winCondString
   59BC 11 00 C0      [10]  244 	ld de, #0xC000
   59BF 0E 02         [ 7]  245 	ld c, #2
   59C1 06 03         [ 7]  246 	ld b, #3
   59C3 CD EB 65      [17]  247 	call cpct_drawStringM1_asm
                            248 
   59C6                     249 	menuOptions_iterate:
   59C6 CD B3 68      [17]  250 	call cpct_scanKeyboard_asm
   59C9 21 00 40      [10]  251 	ld 	hl, #Key_Enter				;; HL <- Key_Space
   59CC CD 91 5D      [17]  252 	call 	cpct_isKeyPressed_asm	;; A = True/False
   59CF FE 00         [ 7]  253 	cp 	#0 							;; A == 0?
   59D1 28 F3         [12]  254 	jr 	z, menuOptions_iterate				;; Iterate
   59D3 C3 E0 58      [10]  255 		jp menuStart				;; Go Options (HL presed)
                            256 
   59D6 C9            [10]  257 	ret
                            258 
                            259 
                            260 ;; ====================================
                            261 ;; ====================================
                            262 ;; PRIVATE FUNCTIONS
                            263 ;; ====================================
                            264 ;; ====================================
                            265 
   59D7                     266 checkUserInput:
                            267 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            268 	;; Reading keyboard example
                            269 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            270 	;; 	call cpct_scanKeyboard_asm
                            271 	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
                            272 	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
                            273 	;; 	cp 	#0 			;; A == 0?
                            274 	;; 	jr 	z, up_not_pressed
                            275 	;; 		;; Up is pressed code
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            276 	;; 		call 	moveUp	
                            277 	;; 	up_not_pressed:
                            278 	;; 		;; Up is not pressed code
                            279 	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
                            280 	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
                            281 	;; 		cp 	#0 				;; A == 0?
                            282 	;; 		jr 	z, down_not_pressed
                            283 	;; 			;; Down is pressed code
                            284 	;; 			call 	moveDown	
                            285 	;; 		down_not_pressed:
                            286 	;; 		;; Down is not pressed code
                            287 
   59D7 C9            [10]  288 	ret
                            289 
                            290 ;; ========================
                            291 ;; Write the menu strings
                            292 ;; ========================
   59D8                     293 initializeMenu:
   59D8 CD 8E 59      [17]  294 	call setPaletteM1
                            295 
                            296 	;; Clean from C000 to EFFF
   59DB 21 00 C0      [10]  297 	ld	hl, #0xC000			;; HL <= Copy pointer
   59DE 11 01 C0      [10]  298 	ld	de, #0xC001			;; DE <= Write pointer
   59E1 36 FF         [10]  299 	ld	(hl), #0xFF			;; Set to 0 where HL points
   59E3 01 00 40      [10]  300 	ld	bc, #0x4000			;; BC <= Times to repeat
   59E6 ED B0         [21]  301 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            302 
                            303 	;; Print Menu
   59E8 21 9B 58      [10]  304 	ld hl, #menuString
   59EB 11 00 C0      [10]  305 	ld de, #0xC000
   59EE 0E 02         [ 7]  306 	ld c, #2
   59F0 06 03         [ 7]  307 	ld b, #3
   59F2 CD EB 65      [17]  308 	call cpct_drawStringM1_asm
                            309 
                            310 	;; Print Play
   59F5 21 A0 58      [10]  311 	ld hl, #playString
   59F8 11 50 C8      [10]  312 	ld de, #menuPos_1
   59FB 0E 02         [ 7]  313 	ld c, #2
   59FD 06 03         [ 7]  314 	ld b, #3
   59FF CD EB 65      [17]  315 	call cpct_drawStringM1_asm
                            316 
                            317 	;; Print Options
   5A02 21 A5 58      [10]  318 	ld hl, #optionsString
   5A05 11 40 C9      [10]  319 	ld de, #menuPos_2
   5A08 0E 02         [ 7]  320 	ld c, #2
   5A0A 06 03         [ 7]  321 	ld b, #3
   5A0C CD EB 65      [17]  322 	call cpct_drawStringM1_asm
                            323 
   5A0F 21 9B 58      [10]  324 	ld hl, #menuString
   5A12 11 30 CA      [10]  325 	ld de, #menuPos_3
   5A15 0E 02         [ 7]  326 	ld c, #2
   5A17 06 03         [ 7]  327 	ld b, #3
   5A19 CD EB 65      [17]  328 	call cpct_drawStringM1_asm
                            329 
   5A1C 21 A0 58      [10]  330 	ld hl, #playString
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   5A1F 11 20 CB      [10]  331 	ld de, #menuPos_4
   5A22 0E 02         [ 7]  332 	ld c, #2
   5A24 06 03         [ 7]  333 	ld b, #3
   5A26 CD EB 65      [17]  334 	call cpct_drawStringM1_asm
                            335 
   5A29 21 A5 58      [10]  336 	ld hl, #optionsString
   5A2C 11 10 CC      [10]  337 	ld de, #menuPos_5
   5A2F 0E 02         [ 7]  338 	ld c, #2
   5A31 06 03         [ 7]  339 	ld b, #3
   5A33 CD EB 65      [17]  340 	call cpct_drawStringM1_asm
                            341 
   5A36 21 9B 58      [10]  342 	ld hl, #menuString
   5A39 11 00 CD      [10]  343 	ld de, #menuPos_6
   5A3C 0E 02         [ 7]  344 	ld c, #2
   5A3E 06 03         [ 7]  345 	ld b, #3
   5A40 CD EB 65      [17]  346 	call cpct_drawStringM1_asm
                            347 
   5A43 21 A0 58      [10]  348 	ld hl, #playString
   5A46 11 F0 CD      [10]  349 	ld de, #menuPos_7
   5A49 0E 02         [ 7]  350 	ld c, #2
   5A4B 06 03         [ 7]  351 	ld b, #3
   5A4D CD EB 65      [17]  352 	call cpct_drawStringM1_asm
                            353 
   5A50 21 B5 58      [10]  354 	ld hl, #menuInstrucString
   5A53 11 E0 C6      [10]  355 	ld de, #instrPos
   5A56 0E 02         [ 7]  356 	ld c, #2
   5A58 06 03         [ 7]  357 	ld b, #3
   5A5A CD EB 65      [17]  358 	call cpct_drawStringM1_asm
                            359 	;; Set video mode
                            360 	;; ld 	c, #1 ;; Set mode 1.
                            361 	;; call cpct_setVideoMode_as
                            362 
                            363 	;; Set palette
                            364 	;; ld 	hl, #direccion_paleta
                            365 	;; ld 	de, #16
                            366 	;; call cpct_setPalette_asm
                            367 
   5A5D C9            [10]  368 	ret
                            369 
                            370 
                            371 ;; ========================
                            372 ;; Print Credits
                            373 ;; ========================
   5A5E                     374 printCreditLine:
                            375 	;;ld hl, #elString
                            376 	;;ld de, #video_memory
                            377 	;;ld c, #Color_Letra
                            378 	;;cd b, #Color_fondo
                            379 ;;
                            380 	;;call cpct_drawStringM1_asm
                            381 
   5A5E C9            [10]  382 	ret
