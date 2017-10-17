                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _cpct_etm_setTileset2x4
                             13 	.globl _cpct_etm_drawTileBox2x4
                             14 	.globl _cpct_setPALColour
                             15 	.globl _cpct_setPalette
                             16 	.globl _cpct_setVideoMode
                             17 	.globl _cpct_disableFirmware
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _INITIALIZED
                             29 ;--------------------------------------------------------
                             30 ; absolute external ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DABS (ABS)
                             33 ;--------------------------------------------------------
                             34 ; global & static initialisations
                             35 ;--------------------------------------------------------
                             36 	.area _HOME
                             37 	.area _GSINIT
                             38 	.area _GSFINAL
                             39 	.area _GSINIT
                             40 ;--------------------------------------------------------
                             41 ; Home
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _HOME
                             45 ;--------------------------------------------------------
                             46 ; code
                             47 ;--------------------------------------------------------
                             48 	.area _CODE
                             49 ;src/main.c:29: void main(void) {
                             50 ;	---------------------------------
                             51 ; Function main
                             52 ; ---------------------------------
   4E34                      53 _main::
                             54 ;src/main.c:31: cpct_disableFirmware();
   4E34 CD 51 4F      [17]   55 	call	_cpct_disableFirmware
                             56 ;src/main.c:32: cpct_setVideoMode(0);
   4E37 2E 00         [ 7]   57 	ld	l,#0x00
   4E39 CD 43 4F      [17]   58 	call	_cpct_setVideoMode
                             59 ;src/main.c:33: cpct_setBorder(HW_BLACK);
   4E3C 21 10 14      [10]   60 	ld	hl,#0x1410
   4E3F E5            [11]   61 	push	hl
   4E40 CD 83 4E      [17]   62 	call	_cpct_setPALColour
                             63 ;src/main.c:34: cpct_setPalette(g_palette, 16);
   4E43 21 10 00      [10]   64 	ld	hl,#0x0010
   4E46 E5            [11]   65 	push	hl
   4E47 21 10 4E      [10]   66 	ld	hl,#_g_palette
   4E4A E5            [11]   67 	push	hl
   4E4B CD 6C 4E      [17]   68 	call	_cpct_setPalette
                             69 ;src/main.c:36: cpct_etm_setTileset2x4(g_tileset);
   4E4E 21 20 4E      [10]   70 	ld	hl,#_g_tileset
   4E51 CD 1E 4F      [17]   71 	call	_cpct_etm_setTileset2x4
                             72 ;src/main.c:39: cpct_etm_drawTileBox2x4(0, 0, g_shit_W, g_shit_H, g_shit_H, ORIGIN_MAP, g_shit);
   4E54 21 00 40      [10]   73 	ld	hl,#_g_shit
   4E57 E5            [11]   74 	push	hl
   4E58 21 00 C0      [10]   75 	ld	hl,#0xC000
   4E5B E5            [11]   76 	push	hl
   4E5C 21 2D 2D      [10]   77 	ld	hl,#0x2D2D
   4E5F E5            [11]   78 	push	hl
   4E60 21 00 50      [10]   79 	ld	hl,#0x5000
   4E63 E5            [11]   80 	push	hl
   4E64 AF            [ 4]   81 	xor	a, a
   4E65 F5            [11]   82 	push	af
   4E66 33            [ 6]   83 	inc	sp
   4E67 CD 8F 4E      [17]   84 	call	_cpct_etm_drawTileBox2x4
                             85 ;src/main.c:41: while (1);
   4E6A                      86 00102$:
   4E6A 18 FE         [12]   87 	jr	00102$
                             88 	.area _CODE
                             89 	.area _INITIALIZER
                             90 	.area _CABS (ABS)
