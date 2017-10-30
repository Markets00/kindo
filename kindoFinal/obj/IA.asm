;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module IA
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _moveIA
	.globl _fuzzificacion
	.globl _calcularb_direc
	.globl _calcule
	.globl _defuzzi
	.globl _calculateDom
	.globl _initAcel
	.globl _fmems
	.globl _vRulesy
	.globl _vRulesx
	.globl _aceleracion
	.globl _ruley2
	.globl _ruley1
	.globl _ruley
	.globl _rulex2
	.globl _rulex1
	.globl _rulex
	.globl _acelMed
	.globl _acelPo
	.globl _acelMu
	.globl _lejos
	.globl _medio
	.globl _cerca
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_aceleracion::
	.ds 6
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_vRulesx::
	.ds 6
_vRulesy::
	.ds 6
_fmems::
	.ds 6
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
;src/IA.c:127: void initAcel(u8 nivel)
;	---------------------------------
; Function initAcel
; ---------------------------------
_initAcel::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;src/IA.c:129: u8 i = 0;
	ld	e,#0x00
;src/IA.c:130: switch(nivel){
	ld	a,4 (ix)
	or	a, a
	jr	Z,00101$
	ld	a,4 (ix)
	dec	a
	jr	Z,00105$
	jp	00109$
;src/IA.c:131: case 0:{ 
00101$:
;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
	ld	hl,#0x0000
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x0F
	inc	hl
	ld	(hl),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	inc	hl
	inc	hl
	ld	(hl),#0x14
	inc	hl
	ld	(hl),#0x00
	ld	a,-2 (ix)
	add	a, #0x04
	ld	l,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x17
	inc	hl
	ld	(hl),#0x00
;src/IA.c:133: while(i<3)
	ld	bc,#_aceleracion+0
	ld	e,#0x00
00102$:
	ld	a,e
	sub	a, #0x03
	jr	NC,00124$
;src/IA.c:135: aceleracion[i] = aux[i];
	ld	l,e
	ld	h,#0x00
	add	hl, hl
	push	hl
	pop	iy
	add	iy, bc
	ld	a,-2 (ix)
	add	a, l
	ld	l,a
	ld	a,-1 (ix)
	adc	a, h
	ld	h,a
	ld	a, (hl)
	inc	hl
	ld	d,(hl)
	ld	0 (iy), a
	ld	1 (iy),d
;src/IA.c:136: i++;
	inc	e
	jr	00102$
;src/IA.c:139: case 1:{
00124$:
00105$:
;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
	ld	hl,#0x0000
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x17
	inc	hl
	ld	(hl),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	inc	hl
	inc	hl
	ld	(hl),#0x19
	inc	hl
	ld	(hl),#0x00
	ld	a,-2 (ix)
	add	a, #0x04
	ld	l,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	h,a
	ld	(hl),#0x33
	inc	hl
	ld	(hl),#0x00
;src/IA.c:141: while(i<3)
	ld	bc,#_aceleracion+0
00106$:
	ld	a,e
	sub	a, #0x03
	jr	NC,00125$
;src/IA.c:143: aceleracion[i] = aux[i];
	ld	l,e
	ld	h,#0x00
	add	hl, hl
	push	hl
	pop	iy
	add	iy, bc
	ld	a,-2 (ix)
	add	a, l
	ld	l,a
	ld	a,-1 (ix)
	adc	a, h
	ld	h,a
	ld	a, (hl)
	inc	hl
	ld	d,(hl)
	ld	0 (iy), a
	ld	1 (iy),d
;src/IA.c:144: i++;
	inc	e
	jr	00106$
;src/IA.c:147: default:{
00125$:
00109$:
;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	(hl),#0x19
	inc	hl
	ld	(hl),#0x00
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl),#0x33
	inc	hl
	ld	(hl),#0x00
	ld	hl,#0x0004
	add	hl,bc
	ld	(hl),#0x4C
	inc	hl
	ld	(hl),#0x00
;src/IA.c:149: while(i<3)
00110$:
	ld	a,e
	sub	a, #0x03
	jr	NC,00114$
;src/IA.c:151: aceleracion[i] = aux[i]; 
	ld	l,e
	ld	h,#0x00
	add	hl, hl
	ld	iy,#_aceleracion
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	add	hl,bc
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	0 (iy), a
	ld	1 (iy),h
;src/IA.c:152: i++;
	inc	e
	jr	00110$
;src/IA.c:155: }
00114$:
	ld	sp, ix
	pop	ix
	ret
_cerca:
	.dw #0x0000
	.dw #0x0500
	.db #0x01	; 1
	.dw #0x0A00
	.dw #0x0A00
	.dw #0x0A00
_medio:
	.dw #0x0000
	.dw #0x1400
	.db #0x00	; 0
	.dw #0x1400
	.dw #0x0A00
	.dw #0x0F00
_lejos:
	.dw #0x0000
	.dw #0x6E00
	.db #0x02	; 2
	.dw #0x3C00
	.dw #0x1900
	.dw #0x6400
_acelMu:
	.dw #0x0000
	.dw #0x5780
	.db #0x02	; 2
	.dw #0x4B00
	.dw #0x1900
	.dw #0x1900
_acelPo:
	.dw #0x0000
	.dw #0x0C80
	.db #0x01	; 1
	.dw #0x1900
	.dw #0x1900
	.dw #0x1900
_acelMed:
	.dw #0x0000
	.dw #0x3200
	.db #0x00	; 0
	.dw #0x3200
	.dw #0x1900
	.dw #0x1900
_rulex:
	.dw _cerca
	.dw _acelMu
_rulex1:
	.dw _medio
	.dw _acelMed
_rulex2:
	.dw _lejos
	.dw _acelPo
_ruley:
	.dw _cerca
	.dw _acelMu
_ruley1:
	.dw _medio
	.dw _acelMed
_ruley2:
	.dw _lejos
	.dw _acelPo
;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
;	---------------------------------
; Function calculateDom
; ---------------------------------
_calculateDom::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-19
	add	hl,sp
	ld	sp,hl
;src/IA.c:161: *grad = 0.0;
	ld	e,7 (ix)
	ld	d,8 (ix)
	ld	l, e
	ld	h, d
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;src/IA.c:162: if(c->tipo == 0){
	ld	a,4 (ix)
	ld	-13 (ix),a
	ld	a,5 (ix)
	ld	-12 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	bc, #0x0004
	add	hl, bc
	ld	c,(hl)
;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
	ld	a,-13 (ix)
	add	a, #0x09
	ld	-17 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-16 (ix),a
	ld	a,-13 (ix)
	add	a, #0x05
	ld	-19 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-18 (ix),a
	ld	a,6 (ix)
	ld	-15 (ix),a
	ld	-14 (ix),#0x00
;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
	ld	a,-13 (ix)
	add	a, #0x07
	ld	-13 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-12 (ix),a
;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
	pop	hl
	push	hl
	ld	a,(hl)
	ld	-11 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
	ld	a,6 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
	xor	a, a
	sub	a, -2 (ix)
	ld	l,a
	ld	a, #0x00
	sbc	a, -1 (ix)
	ld	h,a
	push	bc
	push	de
	push	hl
	ld	hl,#0x0100
	push	hl
;src/IA.c:162: if(c->tipo == 0){
	call	__divuint
	pop	af
	pop	af
	ld	-7 (ix),h
	ld	-8 (ix),l
	pop	de
	pop	bc
	ld	a,c
	or	a, a
	jp	NZ,00138$
;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
	ld	a,-15 (ix)
	sub	a, -11 (ix)
	jr	NZ,00214$
	ld	a,-14 (ix)
	sub	a, -10 (ix)
	jr	NZ,00214$
	ld	a,#0x01
	jr	00215$
00214$:
	xor	a,a
00215$:
	ld	b,a
	ld	a,-1 (ix)
	or	a,-2 (ix)
	jr	NZ,00105$
	ld	a,b
	or	a, a
	jr	NZ,00101$
00105$:
;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,h
	or	a,c
	jr	NZ,00102$
	or	a,b
	jr	Z,00102$
00101$:
;src/IA.c:167: *grad = SCALA;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x01
	ld	(de),a
;src/IA.c:168: return;
	jp	00140$
00102$:
;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
	ld	a,-11 (ix)
	sub	a, -15 (ix)
	ld	a,-10 (ix)
	sbc	a, -14 (ix)
	ld	a,#0x00
	rla
	ld	-9 (ix),a
	bit	0,-9 (ix)
	jr	NZ,00111$
	ld	a,-11 (ix)
	sub	a, c
	ld	b,a
	ld	a,-10 (ix)
	sbc	a, h
	ld	l,a
	ld	a,-15 (ix)
	sub	a, b
	ld	a,-14 (ix)
	sbc	a, l
	jr	C,00111$
;src/IA.c:173: *grad = SCALA / c->leftOffSet;
	push	de
	ld	l, c
	push	hl
	ld	hl,#0x0100
	push	hl
	call	__divuint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	l, e
	ld	h, d
	ld	(hl),c
	inc	hl
	ld	(hl),b
;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
	pop	hl
	push	hl
	ld	a,(hl)
	ld	-4 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-3 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-4 (ix)
	sub	a, l
	ld	l,a
	ld	a,-3 (ix)
	sbc	a, h
	ld	h,a
	ld	a,-6 (ix)
	sub	a, l
	ld	l,a
	ld	a,-5 (ix)
	sbc	a, h
	ld	h,a
	push	de
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;src/IA.c:175: return;
	jp	00140$
00111$:
;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
	bit	0,-9 (ix)
	jr	Z,00107$
	ld	a,-11 (ix)
	add	a, -2 (ix)
	ld	c,a
	ld	a,-10 (ix)
	adc	a, -1 (ix)
	ld	b,a
	ld	a,-15 (ix)
	sub	a, c
	ld	a,-14 (ix)
	sbc	a, b
	jr	NC,00107$
;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
	ld	l, e
	ld	h, d
	ld	a,-8 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-7 (ix)
	ld	(hl),a
;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
	pop	hl
	push	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,-6 (ix)
	sub	a, c
	ld	c,a
	ld	a,-5 (ix)
	sbc	a, b
	ld	b,a
	push	de
	push	bc
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	hl,#0x0100
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;src/IA.c:180: return;
	jp	00140$
00107$:
;src/IA.c:183: *grad = 0;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
;src/IA.c:184: return;
	jp	00140$
00138$:
;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
	ld	l,-11 (ix)
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,l
	add	a, -4 (ix)
	sub	a, -4 (ix)
	ld	b,a
;src/IA.c:187: }else if(c->tipo == 1)
	dec	c
	jp	NZ,00135$
;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
	ld	c,b
;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
	ld	a,-1 (ix)
	or	a,-2 (ix)
	jr	NZ,00115$
	ld	a,6 (ix)
;src/IA.c:193: *grad = SCALA;
	sub	a,c
	jr	NZ,00115$
	ld	(de),a
	inc	de
	ld	a,#0x01
	ld	(de),a
;src/IA.c:194: return;
	jp	00140$
00115$:
;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
	ld	a,6 (ix)
	sub	a, c
	ld	a,#0x00
	rla
	ld	-4 (ix),a
	bit	0,-4 (ix)
	jr	NZ,00121$
	ld	b,#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	add	hl,bc
	ld	a,-15 (ix)
	sub	a, l
	ld	a,-14 (ix)
	sbc	a, h
	jr	NC,00121$
;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
	ld	l, e
	ld	h, d
	ld	a,-8 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-7 (ix)
	ld	(hl),a
;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	a,-6 (ix)
	sub	a, l
	ld	c,a
	ld	a,-5 (ix)
	sbc	a, h
	ld	b,a
	push	de
	push	bc
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;src/IA.c:201: return;
	jp	00140$
00121$:
;src/IA.c:202: }else if(val < midPoint)
	bit	0,-4 (ix)
	jr	Z,00118$
;src/IA.c:204: *grad = SCALA;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x01
	ld	(de),a
;src/IA.c:205: return;
	jp	00140$
00118$:
;src/IA.c:207: *grad = 0;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
;src/IA.c:208: return;
	jp	00140$
00135$:
;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	c,(hl)
	inc	hl
	ld	a, (hl)
	or	a,c
	jr	NZ,00125$
	ld	a,6 (ix)
	sub	a, b
	jr	NZ,00125$
;src/IA.c:215: *grad = SCALA;
	ld	l, e
	ld	h, d
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x01
00125$:
;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
	ld	a,b
	sub	a, 6 (ix)
	ld	a,#0x00
	rla
	ld	-4 (ix),a
	bit	0,-4 (ix)
	jr	NZ,00131$
	ld	c,#0x00
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	-8 (ix),b
	ld	-7 (ix),c
	ld	a,-8 (ix)
	sub	a, l
	ld	c,a
	ld	a,-7 (ix)
	sbc	a, h
	ld	b,a
	ld	a,c
	sub	a, -15 (ix)
	ld	a,b
	sbc	a, -14 (ix)
	jr	NC,00131$
;src/IA.c:218: *grad = SCALA/c->leftOffSet;
	push	de
	push	hl
	ld	hl,#0x0100
	push	hl
	call	__divuint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	l, e
	ld	h, d
	ld	(hl),c
	inc	hl
	ld	(hl),b
;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-8 (ix)
	sub	a, l
	ld	l,a
	ld	a,-7 (ix)
	sbc	a, h
	ld	h,a
	ld	a,-6 (ix)
	sub	a, l
	ld	l,a
	ld	a,-5 (ix)
	sbc	a, h
	ld	h,a
	push	de
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
	jr	00140$
00131$:
;src/IA.c:220: }else if(val > midPoint)
	bit	0,-4 (ix)
	jr	Z,00128$
;src/IA.c:223: *grad = SCALA;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x01
	ld	(de),a
	jr	00140$
00128$:
;src/IA.c:225: *grad = 0;
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
00140$:
	ld	sp, ix
	pop	ix
	ret
;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
;	---------------------------------
; Function defuzzi
; ---------------------------------
_defuzzi::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-17
	add	hl,sp
	ld	sp,hl
;src/IA.c:239: *re = 0;
	ld	a,8 (ix)
	ld	-2 (ix),a
	ld	a,9 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;src/IA.c:241: while(i < 3)
	ld	hl,#0x0000
	add	hl,sp
	ld	-4 (ix),l
	ld	-3 (ix),h
	ld	c,#0x00
00101$:
	ld	a,c
	sub	a, #0x03
	jr	NC,00103$
;src/IA.c:243: dom = 0;
	ld	-10 (ix),#0x00
	ld	-9 (ix),#0x00
;src/IA.c:244: calculateDom(fmems[i], val, &dom);
	ld	hl,#0x0007
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	b,4 (ix)
	ld	l,c
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_fmems
	add	hl,de
	ld	a,(hl)
	ld	-8 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-7 (ix),a
	push	bc
	push	de
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	push	bc
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_calculateDom
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
;src/IA.c:245: vDom[i] = dom/SCALA;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl,de
	ld	e,-9 (ix)
	ld	d,#0x00
	ld	(hl),e
	inc	hl
	ld	(hl),d
;src/IA.c:246: i++;
	inc	c
	jr	00101$
00103$:
;src/IA.c:250: for(i = 0; i<3; i++)
	ld	-11 (ix),#0x00
00108$:
;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
	ld	l,-11 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_aceleracion
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	bc
	push	de
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;src/IA.c:250: for(i = 0; i<3; i++)
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x03
	jr	C,00108$
;src/IA.c:255: if(direccion->b_izq)
	ld	l,6 (ix)
	ld	h,7 (ix)
	inc	hl
	ld	a,(hl)
;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;src/IA.c:255: if(direccion->b_izq)
	or	a, a
	jr	Z,00106$
;src/IA.c:256: *re = *re;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jr	00110$
00106$:
;src/IA.c:259: *re = -*re;
	xor	a, a
	sub	a, e
	ld	e,a
	ld	a, #0x00
	sbc	a, d
	ld	c,a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),c
00110$:
	ld	sp, ix
	pop	ix
	ret
;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
;	---------------------------------
; Function calcule
; ---------------------------------
_calcule::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/IA.c:268: resultadoDistoball = 0;
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
;src/IA.c:269: for(i = 0 ; i<tam; i++){
	ld	-3 (ix),#0x00
00103$:
	ld	a,-3 (ix)
	sub	a, 4 (ix)
	jr	NC,00105$
;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
	ld	iy,#0x0001
	add	iy,sp
	ld	l,-3 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	bc,#_vRulesx
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	push	iy
	ld	a,5 (ix)
	push	af
	inc	sp
	push	de
	call	_calculateDom
	pop	af
	pop	af
	inc	sp
	pop	bc
;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	inc	hl
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	ld	c,l
	ld	b,h
	pop	de
	ld	l, e
	ld	h, d
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	c,h
	ld	b,#0x00
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;src/IA.c:269: for(i = 0 ; i<tam; i++){
	inc	-3 (ix)
	jr	00103$
00105$:
	ld	sp, ix
	pop	ix
	ret
;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
;	---------------------------------
; Function calcularb_direc
; ---------------------------------
_calcularb_direc::
;src/IA.c:277: ball->b_izq = 0;
	ld	hl, #4
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	e, c
	ld	d, b
	inc	de
	xor	a, a
	ld	(de),a
;src/IA.c:278: ball->b_der = 0;
	xor	a, a
	ld	(bc),a
;src/IA.c:280: if(totalxb < 0){
	ld	hl, #2+1
	add	hl, sp
	bit	7,(hl)
	jr	Z,00104$
;src/IA.c:281: ball->b_der = 1;
	ld	a,#0x01
	ld	(bc),a
;src/IA.c:282: ball->b_izq = 0;
	xor	a, a
	ld	(de),a
	ret
00104$:
;src/IA.c:283: }else if(totalxb > 0)
	xor	a, a
	ld	iy,#2
	add	iy,sp
	cp	a, 0 (iy)
	sbc	a, 1 (iy)
	jp	PO, 00116$
	xor	a, #0x80
00116$:
	ret	P
;src/IA.c:285: ball->b_izq = 1;
	ld	a,#0x01
	ld	(de),a
;src/IA.c:286: ball->b_der = 0;
	xor	a, a
	ld	(bc),a
	ret
;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
;	---------------------------------
; Function fuzzificacion
; ---------------------------------
_fuzzificacion::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-18
	add	hl,sp
	ld	sp,hl
;src/IA.c:299: ball = &ballX;
	ld	hl,#0x0006
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	c,l
	ld	b,h
;src/IA.c:300: x = ballx - pingu_enemyx;
	ld	e,8 (ix)
	ld	d,#0x00
	ld	l,10 (ix)
	ld	h,#0x00
	ld	a,e
	sub	a, l
	ld	-2 (ix),a
	ld	a,d
	sbc	a, h
	ld	-1 (ix),a
;src/IA.c:301: y = bally - pingu_enemyy;
	ld	l,9 (ix)
	ld	h,#0x00
	ld	e,11 (ix)
	ld	d,#0x00
	ld	a,l
	sub	a, e
	ld	-4 (ix),a
	ld	a,h
	sbc	a, d
	ld	-3 (ix),a
;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
	ld	a,#0x6F
	sub	a, e
	ld	-8 (ix),a
	ld	a,#0x00
	sbc	a, d
	ld	-7 (ix),a
;src/IA.c:307: ball->b_izq = 0;
	ld	e, c
	ld	d, b
	inc	de
;src/IA.c:304: if(x <= -2){ //ATACAR 
	ld	a,#0xFE
	cp	a, -2 (ix)
	ld	a,#0xFF
	sbc	a, -1 (ix)
	jp	PO, 00148$
	xor	a, #0x80
00148$:
	jp	M,00102$
;src/IA.c:306: ball->b_der = 1;
	ld	a,#0x01
	ld	(bc),a
;src/IA.c:307: ball->b_izq = 0;
	xor	a, a
	ld	(de),a
	jr	00103$
00102$:
;src/IA.c:312: ball->b_izq = 1;
	ld	a,#0x01
	ld	(de),a
;src/IA.c:313: ball->b_der = 0;
	xor	a, a
	ld	(bc),a
00103$:
;src/IA.c:316: if(y1 < y && x > 0){
	xor	a, a
	cp	a, -2 (ix)
	sbc	a, -1 (ix)
	jp	PO, 00149$
	xor	a, #0x80
00149$:
	rlca
	and	a,#0x01
	ld	c,a
	ld	a,-8 (ix)
	sub	a, -4 (ix)
	ld	a,-7 (ix)
	sbc	a, -3 (ix)
	jp	PO, 00150$
	xor	a, #0x80
00150$:
	jp	P,00109$
	ld	a,c
	or	a, a
	jr	Z,00109$
;src/IA.c:317: calcularb_direc(y1, &ballY);
	ld	hl,#0x0004
	add	hl,sp
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_calcularb_direc
	pop	af
	pop	af
	jr	00110$
00109$:
;src/IA.c:319: else if(y1> y && x>0){
	ld	a,-4 (ix)
	sub	a, -8 (ix)
	ld	a,-3 (ix)
	sbc	a, -7 (ix)
	jp	PO, 00151$
	xor	a, #0x80
00151$:
	jp	P,00105$
	ld	a,c
	or	a, a
	jr	Z,00105$
;src/IA.c:320: calcularb_direc(y1, &ballY);
	ld	hl,#0x0004
	add	hl,sp
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_calcularb_direc
	pop	af
	pop	af
	jr	00110$
00105$:
;src/IA.c:323: calcularb_direc(y, &ballY);
	ld	hl,#0x0004
	add	hl,sp
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_calcularb_direc
	pop	af
	pop	af
00110$:
;src/IA.c:327: x = (u8)x*SCALA;
	ld	c,-2 (ix)
	ld	-15 (ix),c
	ld	-16 (ix),#0x00
;src/IA.c:328: y = (u8)y*SCALA;
	ld	b,-4 (ix)
	ld	c,#0x00
;src/IA.c:329: calcule(3,x,&accerationX);
	ld	hl,#0x0008
	add	hl,sp
	ld	d,-16 (ix)
	push	bc
	push	hl
	ld	e, #0x03
	push	de
	call	_calcule
	pop	af
	pop	af
	pop	bc
;src/IA.c:330: calcule(3,y,&accerationY);
	ld	hl,#0x0000
	add	hl,sp
	ld	d,c
	push	bc
	push	hl
	ld	e, #0x03
	push	de
	call	_calcule
	pop	af
	pop	af
	pop	bc
;src/IA.c:333: if(y!=0)
	ld	a,b
	or	a,c
	jr	Z,00114$
;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
	ld	c,-6 (ix)
	ld	b,-5 (ix)
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	push	bc
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	call	_defuzzi
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/IA.c:336: ax = 0;
00114$:
;src/IA.c:338: if(x!=0)
	ld	a,-15 (ix)
	or	a,-16 (ix)
	jr	Z,00118$
;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
	ld	hl,#0x0004
	add	hl,sp
	ld	c,6 (ix)
	ld	b,7 (ix)
	push	bc
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	call	_defuzzi
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/IA.c:341: ay = 0;
00118$:
	ld	sp, ix
	pop	ix
	ret
;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
;	---------------------------------
; Function moveIA
; ---------------------------------
_moveIA::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/IA.c:368: if(myself->y > frisbee->y) {
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,8 (ix)
	ld	h,9 (ix)
	inc	hl
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;src/IA.c:369: myself->ay = -SCALA/8;
	ld	a,-2 (ix)
	add	a, #0x0C
	ld	l,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	h,a
;src/IA.c:368: if(myself->y > frisbee->y) {
	ld	a,e
	sub	a, c
	ld	a,d
	sbc	a, b
	jr	NC,00104$
;src/IA.c:369: myself->ay = -SCALA/8;
	ld	(hl),#0xE0
	inc	hl
	ld	(hl),#0xFF
	jr	00106$
00104$:
;src/IA.c:370: } else if (myself->y < frisbee->y) {
	ld	a,c
	sub	a, e
	ld	a,b
	sbc	a, d
	jr	NC,00106$
;src/IA.c:371: myself->ay = SCALA/8;
	ld	(hl),#0x20
	inc	hl
	ld	(hl),#0x00
00106$:
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__vRulesx:
	.dw _rulex
	.dw _rulex1
	.dw _rulex2
__xinit__vRulesy:
	.dw _ruley
	.dw _ruley1
	.dw _ruley2
__xinit__fmems:
	.dw _acelPo
	.dw _acelMed
	.dw _acelMu
	.area _CABS (ABS)
