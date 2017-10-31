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
                             24 .globl cpct_etm_setTileset2x4_asm
                             25 .globl cpct_etm_drawTileBox2x4_asm
                             26 .globl cpct_etm_drawTilemap2x4_f_asm
                             27 .globl cpct_drawSpriteMaskedAlignedTable_asm
                             28 .globl cpct_drawSpriteMasked_asm
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
                     0020    26 .equ TOP_LIMIT,	 	32
                     00C8    27 .equ BOTTOM_LIMIT,	200
                     0028    28 .equ CENTER_LIMIT,	40
                             29 
                             30 
                     002A    31 .equ map_tH, 42
                     0028    32 .equ map_tW, 40
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
   4B9B 4D 65 6E 75 00       23 menuString:				.asciz "Menu"
   4BA0 50 6C 61 79 00       24 playString:				.asciz "Play"
   4BA5 4F 70 74 69 6F 6E    25 optionsString:			.asciz "Options"
        73 00
   4BAD 43 72 65 64 69 74    26 creditsString:			.asciz "Credits"
        73 00
   4BB5 49 6E 74 72 75 63    27 menuInstrucString:		.asciz "Intructions"
        74 69 6F 6E 73 00
                             28 
   4BC1 3C 00                29 leftArrowCharacter: 	.asciz "<"
   4BC3 3E 00                30 rightArrowCharacter:	.asciz ">"
   4BC5 54 69 6D 65 00       31 timeString: 			.asciz "Time"
   4BCA 53 63 6F 72 65 00    32 scoreString:			.asciz "Score"
   4BD0 57 69 6E 20 43 6F    33 winCondString: 			.asciz "Win Condition"
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
                             43 ;; .equ minCursorPos, 0xC88F	;; Saves the MIN position posible of the cursor.
                             44 ;; .equ maxCursorPos, 0xC97F	;; 2 ;; Saves the MIN position posible of the cursor.
                             45 ;; .equ maxCursorPos, 0xCA6F	;; 3 ;; Saves the MAX position posible of the cursor.
                             46 ;; .equ maxCursorPos, 0xCB5F	;; 4 ;; Saves the MAX position posible of the cursor.
                             47 
                     C6E0    48 .equ instrPos, 0xC6E0
                             49 
                             50 .globl _sprite_frisbeeMenu
                             51 
                             52 ;; ====================================
                             53 ;; ====================================
                             54 ;; PUBLIC FUNCTIONS
                             55 ;; ====================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             56 ;; ====================================
   4BDE                      57 menuStart::
   4BDE CD CE 4C      [17]   58 	call 	initializeMenu
                             59 
   4BE1 21 DD 3D      [10]   60 	ld	hl, #_sprite_frisbeeMenu
   4BE4 ED 5B F3 4B   [20]   61 	ld 	de, (cursorPos)
   4BE8 06 08         [ 7]   62 	ld 	b, #8 		;; B = ent height
   4BEA 0E 02         [ 7]   63 	ld 	c, #2		;; C = ent width
   4BEC CD 54 59      [17]   64 	call cpct_drawSprite_asm
                             65 
   4BEF CD F5 4B      [17]   66 	call checkSelection
                             67 	;; if i == 0 -> play
                             68 	;; if i == 1 -> options
                             69 
                             70 	;; Do stuff here...
                             71 	;; Do stuff here...
                             72 	;; Do stuff here...
   4BF2 C9            [10]   73 	ret 
                             74 
                             75 
                             76 
                     0002    77 cursor_W 	= 2
                     0008    78 cursor_H 	= 8
                     0006    79 max_index_value	= 6
                     00F0    80 addPosition	= 0xF0 			;; Sums to the next position (or substrct to the previous one)
                     FFFFFF10    81 subPosition	= #-240
   4BF3 8F C8                82 cursorPos: 	.dw 0xC88F		;; Saves the cursor position
                             83 
                             84 
                             85 ;; =======================================
                             86 ;; Mueve el índice a la posición indicada
                             87 ;; Modifica: AF, BC, DE, HL
                             88 ;; Devuelve:
                             89 ;;	A <= Selected index [0 - 6]
                             90 ;; =======================================
   4BF5                      91 checkSelection:: 
   4BF5 3E 00         [ 7]   92 	ld	a, #0			;; Initialize A to 0 as starting index
                             93 
   4BF7                      94 	selection_waitting:
   4BF7 F5            [11]   95 		push 	af
                             96 
   4BF8 CD 02 5D      [17]   97 		call 	cpct_scanKeyboard_asm
                             98 
   4BFB 21 00 40      [10]   99 		ld 	hl, #Key_Enter
   4BFE CD BF 50      [17]  100 		call 	cpct_isKeyPressed_asm	;; A <= True/False
   4C01 FE 00         [ 7]  101 		cp 	#0 
   4C03 28 02         [12]  102 		jr 	z, enter_not_pressed	;; Is enter key pressed?
   4C05 F1            [10]  103 			pop af			;; A <= final index selected
   4C06 C9            [10]  104 			ret
                            105 
   4C07                     106 		enter_not_pressed:
   4C07 F1            [10]  107 			pop af			;; A <= index value
   4C08 CD 2C 4C      [17]  108 			call checkCursor	;; check cursor movement
   4C0B 18 EA         [12]  109 			jr selection_waitting
                            110 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   4C0D C9            [10]  111 	ret
                            112 
                            113 ;; =======================================
                            114 ;; Mueve el índice a la posición indicada
                            115 ;; Entrada:
                            116 ;;	HL <= pointer to new position
                            117 ;; Modifica: AF, BC, DE, HL
                            118 ;; =======================================
   4C0E                     119 reDrawCursor::
   4C0E E5            [11]  120 	push hl
                            121 
   4C0F ED 5B F3 4B   [20]  122 	ld de, (cursorPos)		;; alomejor esto no compila
   4C13 3E FF         [ 7]  123 	ld a, #0xFF
   4C15 06 08         [ 7]  124 	ld b, #cursor_H
   4C17 0E 02         [ 7]  125 	ld c, #cursor_W
   4C19 CD 18 5C      [17]  126 	call cpct_drawSolidBox_asm	;; Erase last index position
                            127 
   4C1C E1            [10]  128 	pop hl
   4C1D 22 F3 4B      [16]  129 	ld (cursorPos), hl		;; Update cursorPos to the new position after erasing
                            130 
   4C20 EB            [ 4]  131 	ex 	de, hl			;; DE <= pointer to new position
   4C21 21 DD 3D      [10]  132 	ld	hl, #_sprite_frisbeeMenu;; HL <= cursor sprite pointer
   4C24 06 08         [ 7]  133 	ld 	b, #cursor_H		;; B = height
   4C26 0E 02         [ 7]  134 	ld 	c, #cursor_W		;; C = width
   4C28 CD 54 59      [17]  135 	call cpct_drawSprite_asm
                            136 
   4C2B C9            [10]  137 	ret
                            138 
                            139 
                            140 ;; =================================
                            141 ;; Chequea si el índice debe moverse
                            142 ;; Entrada:
                            143 ;;	A <= starting index
                            144 ;; Modifica: AF, BC, DE, HL
                            145 ;; Devuelve:
                            146 ;; 	A => selected index
                            147 ;; =================================
   4C2C                     148 checkCursor::
   4C2C F5            [11]  149 	push 	af			;; Save the index at the stack
   4C2D 21 00 01      [10]  150 	ld 	hl, #Key_CursorUp
   4C30 CD BF 50      [17]  151 	call 	cpct_isKeyPressed_asm	;; A <= True/False
   4C33 FE 00         [ 7]  152 	cp 	#0 
   4C35 28 19         [12]  153 	jr 	z, up_not_pressed	;; Is up key pressed?
                            154 		;; Up pressed
   4C37 F1            [10]  155 			pop af
   4C38 3D            [ 4]  156 			dec a
   4C39 FA 4E 4C      [10]  157 			jp	m, cant_dec_index
                            158 				;; decrement index
   4C3C F5            [11]  159 				push af				;; Save the index
                            160 
   4C3D 2A F3 4B      [16]  161 				ld 	hl, (cursorPos)		;; HL <= Cursor position
   4C40 11 10 FF      [10]  162 				ld	de, #subPosition	;; DE <= Negative value to substract to cursor position
   4C43 19            [11]  163 				add	hl, de			;; HL <= Cursor position - SubPosition
   4C44 CD 0E 4C      [17]  164 				call 	reDrawCursor
                            165 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4C47 3E 0A         [ 7]  166 				ld	a, #10
   4C49 CD 77 4C      [17]  167 				call 	wait_X_halts
                            168 
   4C4C F1            [10]  169 				pop af				;; Restore the index before looping
   4C4D C9            [10]  170 				ret
   4C4E                     171 			cant_dec_index:
   4C4E 3C            [ 4]  172 				inc a 				;; Restore index value
   4C4F C9            [10]  173 				ret
   4C50                     174 	up_not_pressed:
   4C50 21 00 04      [10]  175 	ld 	hl, #Key_CursorDown
   4C53 CD BF 50      [17]  176 	call 	cpct_isKeyPressed_asm	;; A <= True/False
   4C56 FE 00         [ 7]  177 	cp 	#0 
   4C58 28 1B         [12]  178 	jr 	z, down_not_pressed	;; Is down key pressed?
                            179 		;; Down pressed
   4C5A F1            [10]  180 			pop 	af
   4C5B 3C            [ 4]  181 			inc 	a
   4C5C FE 06         [ 7]  182 			cp  	#max_index_value
   4C5E F2 73 4C      [10]  183 			jp	p, cant_inc_index
                            184 				;; increment index
   4C61 F5            [11]  185 				push af				;; Save the index
                            186 
   4C62 2A F3 4B      [16]  187 				ld 	hl, (cursorPos)		;; HL <= Cursor position
   4C65 11 F0 00      [10]  188 				ld	de, #addPosition	;; DE <= Positive value to add to cursor position
   4C68 19            [11]  189 				add	hl, de			;; HL <= Cursor position + AddPosition
   4C69 CD 0E 4C      [17]  190 				call 	reDrawCursor
                            191 
   4C6C 3E 0A         [ 7]  192 				ld	a, #10
   4C6E CD 77 4C      [17]  193 				call 	wait_X_halts
                            194 
   4C71 F1            [10]  195 				pop af				;; Restore the index before looping
   4C72 C9            [10]  196 				ret
   4C73                     197 			cant_inc_index:
   4C73 3D            [ 4]  198 				dec a 				;; Restore index value
   4C74 C9            [10]  199 				ret
   4C75                     200 	down_not_pressed:
                            201 		;; Any key pressed
   4C75 F1            [10]  202 		pop af
   4C76 C9            [10]  203 	ret
                            204 
                            205 ;; =================================
                            206 ;; Espera 8 halts, N veces
                            207 ;; Entrada:
                            208 ;;	A <= N times
                            209 ;; Modifica: A
                            210 ;; =================================
   4C77                     211 wait_X_halts::
   4C77 3D            [ 4]  212 	dec a
   4C78 28 09         [12]  213 	jr z, wait_halts_exit
   4C7A 76            [ 4]  214 		halt
   4C7B 76            [ 4]  215 		halt
   4C7C 76            [ 4]  216 		halt
   4C7D 76            [ 4]  217 		halt
   4C7E 76            [ 4]  218 		halt
   4C7F 76            [ 4]  219 		halt
   4C80 76            [ 4]  220 		halt
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4C81 18 F4         [12]  221 		jr wait_X_halts
   4C83                     222 	wait_halts_exit:
   4C83 C9            [10]  223 	ret
                            224 
                            225 ;; Sets the palette to mode 0
                            226 ;;setPaletteM0::
                            227 ;;	ld c, #0					;; Mode 0
                            228 ;;	call cpct_setVideoMode_asm
                            229 ;;
                            230 ;;	ld hl, #paletteM0			;; hl <- paletteM0
                            231 ;;	ld de, #16 					;; 16 Colours
                            232 ;;	call cpct_setPalette_asm
                            233 ;;
                            234 ;;	ret
                            235 
                            236 ;; Sets the palette to mode 1
   4C84                     237 setPaletteM1::
   4C84 0E 01         [ 7]  238 	ld c, #1					;; Mode 1
   4C86 CD F4 5B      [17]  239 	call cpct_setVideoMode_asm
                            240 
   4C89 21 57 4D      [10]  241 	ld hl, #paletteM1			;; hl <- paletteM1
   4C8C 11 04 00      [10]  242 	ld de, #4 					;; 4 Colours
   4C8F CD CB 50      [17]  243 	call cpct_setPalette_asm
                            244 
   4C92 C9            [10]  245 	ret
                            246 
                            247 ;; Sets the palette to black on mode 1
   4C93                     248 setPaletteBlackM1::
   4C93 0E 01         [ 7]  249 	ld c, #1					;; Mode 1
   4C95 CD F4 5B      [17]  250 	call cpct_setVideoMode_asm
                            251 
   4C98 21 5B 4D      [10]  252 	ld hl, #blackPaletteM1		;; hl <- blackPaletteM1
   4C9B 11 04 00      [10]  253 	ld de, #4 					;; 4 Colours
   4C9E CD CB 50      [17]  254 	call cpct_setPalette_asm
                            255 
   4CA1 C9            [10]  256 	ret
                            257 
   4CA2                     258 menuOptions::
                            259 
                            260 	;; Clean from C000 to EFFF
   4CA2 21 00 C0      [10]  261 	ld	hl, #0xC000			;; HL <= Copy pointer
   4CA5 11 01 C0      [10]  262 	ld	de, #0xC001			;; DE <= Write pointer
   4CA8 36 FF         [10]  263 	ld	(hl), #0xFF			;; Set to 0 where HL points
   4CAA 01 00 40      [10]  264 	ld	bc, #0x4000			;; BC <= Times to repeat
   4CAD ED B0         [21]  265 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            266 
                            267 	;; Print Menu
   4CAF 21 D0 4B      [10]  268 	ld hl, #winCondString
   4CB2 11 00 C0      [10]  269 	ld de, #0xC000
   4CB5 0E 02         [ 7]  270 	ld c, #2
   4CB7 06 03         [ 7]  271 	ld b, #3
   4CB9 CD 19 59      [17]  272 	call cpct_drawStringM1_asm
                            273 
   4CBC                     274 	menuOptions_iterate:
   4CBC CD 02 5D      [17]  275 	call cpct_scanKeyboard_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4CBF 21 00 40      [10]  276 	ld 	hl, #Key_Enter				;; HL <- Key_Space
   4CC2 CD BF 50      [17]  277 	call 	cpct_isKeyPressed_asm	;; A = True/False
   4CC5 FE 00         [ 7]  278 	cp 	#0 							;; A == 0?
   4CC7 28 F3         [12]  279 	jr 	z, menuOptions_iterate				;; Iterate
   4CC9 C3 DE 4B      [10]  280 		jp menuStart				;; Go Options (HL presed)
                            281 
   4CCC C9            [10]  282 	ret
                            283 
                            284 
                            285 ;; ====================================
                            286 ;; ====================================
                            287 ;; PRIVATE FUNCTIONS
                            288 ;; ====================================
                            289 ;; ====================================
                            290 
   4CCD                     291 checkUserInput:
                            292 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            293 	;; Reading keyboard example
                            294 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            295 	;; 	call cpct_scanKeyboard_asm
                            296 	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
                            297 	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
                            298 	;; 	cp 	#0 			;; A == 0?
                            299 	;; 	jr 	z, up_not_pressed
                            300 	;; 		;; Up is pressed code
                            301 	;; 		call 	moveUp	
                            302 	;; 	up_not_pressed:
                            303 	;; 		;; Up is not pressed code
                            304 	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
                            305 	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
                            306 	;; 		cp 	#0 				;; A == 0?
                            307 	;; 		jr 	z, down_not_pressed
                            308 	;; 			;; Down is pressed code
                            309 	;; 			call 	moveDown	
                            310 	;; 		down_not_pressed:
                            311 	;; 		;; Down is not pressed code
                            312 
   4CCD C9            [10]  313 	ret
                            314 
                            315 ;; ========================
                            316 ;; Write the menu strings
                            317 ;; ========================
   4CCE                     318 initializeMenu:
   4CCE CD 84 4C      [17]  319 	call setPaletteM1
                            320 
                            321 	;; Clean from C000 to EFFF
   4CD1 21 00 C0      [10]  322 	ld	hl, #0xC000			;; HL <= Copy pointer
   4CD4 11 01 C0      [10]  323 	ld	de, #0xC001			;; DE <= Write pointer
   4CD7 36 FF         [10]  324 	ld	(hl), #0xFF			;; Set to 0 where HL points
   4CD9 01 00 40      [10]  325 	ld	bc, #0x4000			;; BC <= Times to repeat
   4CDC ED B0         [21]  326 	ldir					;; Copy from where HL points to where DE points, and inc HL and DE, BC times
                            327 
                            328 	;; Print Menu
   4CDE 21 9B 4B      [10]  329 	ld hl, #menuString
   4CE1 11 00 C0      [10]  330 	ld de, #0xC000
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   4CE4 0E 02         [ 7]  331 	ld c, #2
   4CE6 06 03         [ 7]  332 	ld b, #3
   4CE8 CD 19 59      [17]  333 	call cpct_drawStringM1_asm
                            334 
                            335 	;; Print Play
   4CEB 21 A0 4B      [10]  336 	ld hl, #playString
   4CEE 11 50 C8      [10]  337 	ld de, #menuPos_1
   4CF1 0E 02         [ 7]  338 	ld c, #2
   4CF3 06 03         [ 7]  339 	ld b, #3
   4CF5 CD 19 59      [17]  340 	call cpct_drawStringM1_asm
                            341 
                            342 	;; Print Options
   4CF8 21 A5 4B      [10]  343 	ld hl, #optionsString
   4CFB 11 40 C9      [10]  344 	ld de, #menuPos_2
   4CFE 0E 02         [ 7]  345 	ld c, #2
   4D00 06 03         [ 7]  346 	ld b, #3
   4D02 CD 19 59      [17]  347 	call cpct_drawStringM1_asm
                            348 
   4D05 21 9B 4B      [10]  349 	ld hl, #menuString
   4D08 11 30 CA      [10]  350 	ld de, #menuPos_3
   4D0B 0E 02         [ 7]  351 	ld c, #2
   4D0D 06 03         [ 7]  352 	ld b, #3
   4D0F CD 19 59      [17]  353 	call cpct_drawStringM1_asm
                            354 
   4D12 21 A0 4B      [10]  355 	ld hl, #playString
   4D15 11 20 CB      [10]  356 	ld de, #menuPos_4
   4D18 0E 02         [ 7]  357 	ld c, #2
   4D1A 06 03         [ 7]  358 	ld b, #3
   4D1C CD 19 59      [17]  359 	call cpct_drawStringM1_asm
                            360 
   4D1F 21 A5 4B      [10]  361 	ld hl, #optionsString
   4D22 11 10 CC      [10]  362 	ld de, #menuPos_5
   4D25 0E 02         [ 7]  363 	ld c, #2
   4D27 06 03         [ 7]  364 	ld b, #3
   4D29 CD 19 59      [17]  365 	call cpct_drawStringM1_asm
                            366 
   4D2C 21 9B 4B      [10]  367 	ld hl, #menuString
   4D2F 11 00 CD      [10]  368 	ld de, #menuPos_6
   4D32 0E 02         [ 7]  369 	ld c, #2
   4D34 06 03         [ 7]  370 	ld b, #3
   4D36 CD 19 59      [17]  371 	call cpct_drawStringM1_asm
                            372 
   4D39 21 A0 4B      [10]  373 	ld hl, #playString
   4D3C 11 F0 CD      [10]  374 	ld de, #menuPos_7
   4D3F 0E 02         [ 7]  375 	ld c, #2
   4D41 06 03         [ 7]  376 	ld b, #3
   4D43 CD 19 59      [17]  377 	call cpct_drawStringM1_asm
                            378 
   4D46 21 B5 4B      [10]  379 	ld hl, #menuInstrucString
   4D49 11 E0 C6      [10]  380 	ld de, #instrPos
   4D4C 0E 02         [ 7]  381 	ld c, #2
   4D4E 06 03         [ 7]  382 	ld b, #3
   4D50 CD 19 59      [17]  383 	call cpct_drawStringM1_asm
                            384 	;; Set video mode
                            385 	;; ld 	c, #1 ;; Set mode 1.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            386 	;; call cpct_setVideoMode_as
                            387 
                            388 	;; Set palette
                            389 	;; ld 	hl, #direccion_paleta
                            390 	;; ld 	de, #16
                            391 	;; call cpct_setPalette_asm
                            392 
   4D53 C9            [10]  393 	ret
                            394 
                            395 
                            396 ;; ========================
                            397 ;; Print Credits
                            398 ;; ========================
   4D54                     399 printCreditLine:
                            400 	;;ld hl, #elString
                            401 	;;ld de, #video_memory
                            402 	;;ld c, #Color_Letra
                            403 	;;cd b, #Color_fondo
                            404 ;;
                            405 	;;call cpct_drawStringM1_asm
                            406 
   4D54 C9            [10]  407 	ret
