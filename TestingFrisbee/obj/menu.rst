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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 
                              6 ;; definición de las teclas que necesitaremos
                     0100     7   Key_CursorUp     = 0x0100
                     0101     8   Key_CursorLeft   = 0x0101
                     0400     9   Key_CursorDown   = 0x0400
                     0200    10   Key_CursorRight  = 0x0200
                     8005    11   Key_Space        = 0x8005
                     4000    12   Key_Enter        = 0x4000
                             13 
                             14 ;; ====================================
                             15 ;; ====================================
                             16 ;; PRIVATE DATA
                             17 ;; ====================================
                             18 ;; ====================================
                             19 
                             20 ;; .equ mi_constante0, 0
                             21 ;; .equ mi_constante1, 1
                             22 
                             23 
                             24 
                             25 ;; ====================================
                             26 ;; ====================================
                             27 ;; PUBLIC FUNCTIONS
                             28 ;; ====================================
                             29 ;; ====================================
   0482                      30 menuStart::
   0482 CD 87 04      [17]   31 	call 	initializeMenu
                             32 	;; Do stuff here...
                             33 	;; Do stuff here...
                             34 	;; Do stuff here...
   0485 C9            [10]   35 	ret
                             36 
                             37 
                             38 ;; ====================================
                             39 ;; ====================================
                             40 ;; PRIVATE FUNCTIONS
                             41 ;; ====================================
                             42 ;; ====================================
                             43 
   0486                      44 checkUserInput:
                             45 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             46 	;; Reading keyboard example
                             47 	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             48 	;; 	call cpct_scanKeyboard_asm
                             49 	;; 	ld 	hl, #Key_CursorUp	;; HL = CursorUp Keycode
                             50 	;; 	call 	cpct_isKeyPressed_asm 	;; A = True/False
                             51 	;; 	cp 	#0 			;; A == 0?
                             52 	;; 	jr 	z, up_not_pressed
                             53 	;; 		;; Up is pressed code
                             54 	;; 		call 	moveUp	
                             55 	;; 	up_not_pressed:
                             56 	;; 		;; Up is not pressed code
                             57 	;; 		ld 	hl, #Key_CursorDown		;; HL = CursorDown Keycode
                             58 	;; 		call 	cpct_isKeyPressed_asm 		;; A = True/False
                             59 	;; 		cp 	#0 				;; A == 0?
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             60 	;; 		jr 	z, down_not_pressed
                             61 	;; 			;; Down is pressed code
                             62 	;; 			call 	moveDown	
                             63 	;; 		down_not_pressed:
                             64 	;; 		;; Down is not pressed code
                             65 
   0486 C9            [10]   66 	ret
                             67 
                             68 ;; ========================
                             69 ;; Initialize menu
                             70 ;; ========================
   0487                      71 initializeMenu:
   0487 CD E2 04      [17]   72 	call cpct_disableFirmware_asm
                             73 
                             74 	;; Set video mode
                             75 	;; ld 	c, #0
                             76 	;; call cpct_setVideoMode_asm
                             77 
                             78 	;; Set palette
                             79 	;; ld 	hl, #direccion_paleta
                             80 	;; ld 	de, #16
                             81 	;; call cpct_setPalette_asm
                             82 
   048A C9            [10]   83 	ret
