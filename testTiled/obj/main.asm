;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _dibujaCosa
	.globl _cpct_etm_setTileset2x4
	.globl _cpct_etm_drawTileBox2x4
	.globl _cpct_getScreenPtr
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_waitVSYNC
	.globl _cpct_setVideoMode
	.globl _cpct_drawSprite
	.globl _cpct_disableFirmware
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:31: void dibujaCosa(const u8 * sprite) {
;	---------------------------------
; Function dibujaCosa
; ---------------------------------
_dibujaCosa::
;src/main.c:32: u8* pvmem = cpct_getScreenPtr(CPCT_VMEM_START, 0, 0); 
	ld	hl, #0x0000
	push	hl
	ld	h, #0xc0
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:33: cpct_drawSprite (sprite, CPCT_VMEM_START, G_ROBOZ2_0_W, G_ROBOZ2_0_H );
	pop	de
	pop	bc
	push	bc
	push	de
	ld	hl, #0x1405
	push	hl
	ld	hl, #0xc000
	push	hl
	push	bc
	call	_cpct_drawSprite
	ret
;src/main.c:36: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:38: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:39: cpct_setVideoMode(0);
	ld	l, #0x00
	call	_cpct_setVideoMode
;src/main.c:40: cpct_setBorder(HW_BLACK);
	ld	hl, #0x1410
	push	hl
	call	_cpct_setPALColour
;src/main.c:41: cpct_setPalette(g_palette, 16);
	ld	hl, #0x0010
	push	hl
	ld	hl, #_g_palette
	push	hl
	call	_cpct_setPalette
;src/main.c:43: cpct_etm_setTileset2x4(g_tileset);
	ld	hl, #_g_tileset
	call	_cpct_etm_setTileset2x4
;src/main.c:46: cpct_etm_drawTileBox2x4(0, 0, g_shit_W, g_shit_H, g_shit_H, ORIGIN_MAP, g_shit);
	ld	hl, #_g_shit
	push	hl
	ld	hl, #0xc000
	push	hl
	ld	hl, #0x2d2d
	push	hl
	ld	hl, #0x5000
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_cpct_etm_drawTileBox2x4
;src/main.c:49: while (1) {
00102$:
;src/main.c:50: dibujaCosa(g_roboz2_0);
	ld	hl, #_g_roboz2_0
	push	hl
	call	_dibujaCosa
	pop	af
;src/main.c:51: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:52: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:53: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:54: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:55: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:56: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:57: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:58: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:59: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:60: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:61: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:62: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:63: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:64: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:65: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:66: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:67: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:68: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:69: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:70: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:71: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:72: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:73: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:74: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:75: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:76: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:77: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:78: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:79: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:80: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:81: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:82: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:83: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:84: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:85: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:86: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:87: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:88: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:89: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:90: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:91: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:92: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:93: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:94: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:95: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:96: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:97: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:98: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:99: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:100: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:101: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:102: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:103: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:104: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:105: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:106: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:107: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:108: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:109: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:110: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:111: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:112: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:113: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:114: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:115: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:116: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:117: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:118: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:119: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:120: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:121: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:122: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:123: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:124: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:125: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:126: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:127: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:128: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:129: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:130: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:131: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:132: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:133: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:134: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:135: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:136: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:137: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:138: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:139: cpct_waitVSYNC();cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	call	_cpct_waitVSYNC
;src/main.c:140: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:141: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:142: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:143: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:144: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:145: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:146: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:147: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:148: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:149: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:150: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:151: dibujaCosa(g_roboz2_1);
	ld	hl, #_g_roboz2_1
	push	hl
	call	_dibujaCosa
	pop	af
;src/main.c:152: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:153: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:154: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:155: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:156: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:157: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:158: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:159: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:160: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:161: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:162: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/main.c:163: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	jp	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
