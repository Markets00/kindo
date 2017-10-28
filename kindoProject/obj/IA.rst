                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module IA
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _moveIA
                             12 	.globl _fuzzificacion
                             13 	.globl _calcularb_direc
                             14 	.globl _calcule
                             15 	.globl _defuzzi
                             16 	.globl _calculateDom
                             17 	.globl _initAcel
                             18 	.globl _fmems
                             19 	.globl _vRulesy
                             20 	.globl _vRulesx
                             21 	.globl _aceleracion
                             22 	.globl _ruley2
                             23 	.globl _ruley1
                             24 	.globl _ruley
                             25 	.globl _rulex2
                             26 	.globl _rulex1
                             27 	.globl _rulex
                             28 	.globl _acelMed
                             29 	.globl _acelPo
                             30 	.globl _acelMu
                             31 	.globl _lejos
                             32 	.globl _medio
                             33 	.globl _cerca
                             34 ;--------------------------------------------------------
                             35 ; special function registers
                             36 ;--------------------------------------------------------
                             37 ;--------------------------------------------------------
                             38 ; ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DATA
   1C87                      41 _aceleracion::
   1C87                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   1C8D                      47 _vRulesx::
   1C8D                      48 	.ds 6
   1C93                      49 _vRulesy::
   1C93                      50 	.ds 6
   1C99                      51 _fmems::
   1C99                      52 	.ds 6
                             53 ;--------------------------------------------------------
                             54 ; absolute external ram data
                             55 ;--------------------------------------------------------
                             56 	.area _DABS (ABS)
                             57 ;--------------------------------------------------------
                             58 ; global & static initialisations
                             59 ;--------------------------------------------------------
                             60 	.area _HOME
                             61 	.area _GSINIT
                             62 	.area _GSFINAL
                             63 	.area _GSINIT
                             64 ;--------------------------------------------------------
                             65 ; Home
                             66 ;--------------------------------------------------------
                             67 	.area _HOME
                             68 	.area _HOME
                             69 ;--------------------------------------------------------
                             70 ; code
                             71 ;--------------------------------------------------------
                             72 	.area _CODE
                             73 ;src/IA.c:127: void initAcel(u8 nivel)
                             74 ;	---------------------------------
                             75 ; Function initAcel
                             76 ; ---------------------------------
   0320                      77 _initAcel::
   0320 DD E5         [15]   78 	push	ix
   0322 DD 21 00 00   [14]   79 	ld	ix,#0
   0326 DD 39         [15]   80 	add	ix,sp
   0328 21 F8 FF      [10]   81 	ld	hl,#-8
   032B 39            [11]   82 	add	hl,sp
   032C F9            [ 6]   83 	ld	sp,hl
                             84 ;src/IA.c:129: u8 i = 0;
   032D 1E 00         [ 7]   85 	ld	e,#0x00
                             86 ;src/IA.c:130: switch(nivel){
   032F DD 7E 04      [19]   87 	ld	a,4 (ix)
   0332 B7            [ 4]   88 	or	a, a
   0333 28 09         [12]   89 	jr	Z,00101$
   0335 DD 7E 04      [19]   90 	ld	a,4 (ix)
   0338 3D            [ 4]   91 	dec	a
   0339 28 5F         [12]   92 	jr	Z,00105$
   033B C3 F4 03      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   033E                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   033E 21 00 00      [10]   97 	ld	hl,#0x0000
   0341 39            [11]   98 	add	hl,sp
   0342 DD 75 FE      [19]   99 	ld	-2 (ix),l
   0345 DD 74 FF      [19]  100 	ld	-1 (ix),h
   0348 DD 6E FE      [19]  101 	ld	l,-2 (ix)
   034B DD 66 FF      [19]  102 	ld	h,-1 (ix)
   034E 36 0F         [10]  103 	ld	(hl),#0x0F
   0350 23            [ 6]  104 	inc	hl
   0351 36 00         [10]  105 	ld	(hl),#0x00
   0353 DD 6E FE      [19]  106 	ld	l,-2 (ix)
   0356 DD 66 FF      [19]  107 	ld	h,-1 (ix)
   0359 23            [ 6]  108 	inc	hl
   035A 23            [ 6]  109 	inc	hl
   035B 36 14         [10]  110 	ld	(hl),#0x14
   035D 23            [ 6]  111 	inc	hl
   035E 36 00         [10]  112 	ld	(hl),#0x00
   0360 DD 7E FE      [19]  113 	ld	a,-2 (ix)
   0363 C6 04         [ 7]  114 	add	a, #0x04
   0365 6F            [ 4]  115 	ld	l,a
   0366 DD 7E FF      [19]  116 	ld	a,-1 (ix)
   0369 CE 00         [ 7]  117 	adc	a, #0x00
   036B 67            [ 4]  118 	ld	h,a
   036C 36 17         [10]  119 	ld	(hl),#0x17
   036E 23            [ 6]  120 	inc	hl
   036F 36 00         [10]  121 	ld	(hl),#0x00
                            122 ;src/IA.c:133: while(i<3)
   0371 01 87 1C      [10]  123 	ld	bc,#_aceleracion+0
   0374 1E 00         [ 7]  124 	ld	e,#0x00
   0376                     125 00102$:
   0376 7B            [ 4]  126 	ld	a,e
   0377 D6 03         [ 7]  127 	sub	a, #0x03
   0379 30 1F         [12]  128 	jr	NC,00124$
                            129 ;src/IA.c:135: aceleracion[i] = aux[i];
   037B 6B            [ 4]  130 	ld	l,e
   037C 26 00         [ 7]  131 	ld	h,#0x00
   037E 29            [11]  132 	add	hl, hl
   037F E5            [11]  133 	push	hl
   0380 FD E1         [14]  134 	pop	iy
   0382 FD 09         [15]  135 	add	iy, bc
   0384 DD 7E FE      [19]  136 	ld	a,-2 (ix)
   0387 85            [ 4]  137 	add	a, l
   0388 6F            [ 4]  138 	ld	l,a
   0389 DD 7E FF      [19]  139 	ld	a,-1 (ix)
   038C 8C            [ 4]  140 	adc	a, h
   038D 67            [ 4]  141 	ld	h,a
   038E 7E            [ 7]  142 	ld	a, (hl)
   038F 23            [ 6]  143 	inc	hl
   0390 56            [ 7]  144 	ld	d,(hl)
   0391 FD 77 00      [19]  145 	ld	0 (iy), a
   0394 FD 72 01      [19]  146 	ld	1 (iy),d
                            147 ;src/IA.c:136: i++;
   0397 1C            [ 4]  148 	inc	e
   0398 18 DC         [12]  149 	jr	00102$
                            150 ;src/IA.c:139: case 1:{
   039A                     151 00124$:
   039A                     152 00105$:
                            153 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   039A 21 00 00      [10]  154 	ld	hl,#0x0000
   039D 39            [11]  155 	add	hl,sp
   039E DD 75 FE      [19]  156 	ld	-2 (ix),l
   03A1 DD 74 FF      [19]  157 	ld	-1 (ix),h
   03A4 DD 6E FE      [19]  158 	ld	l,-2 (ix)
   03A7 DD 66 FF      [19]  159 	ld	h,-1 (ix)
   03AA 36 17         [10]  160 	ld	(hl),#0x17
   03AC 23            [ 6]  161 	inc	hl
   03AD 36 00         [10]  162 	ld	(hl),#0x00
   03AF DD 6E FE      [19]  163 	ld	l,-2 (ix)
   03B2 DD 66 FF      [19]  164 	ld	h,-1 (ix)
   03B5 23            [ 6]  165 	inc	hl
   03B6 23            [ 6]  166 	inc	hl
   03B7 36 19         [10]  167 	ld	(hl),#0x19
   03B9 23            [ 6]  168 	inc	hl
   03BA 36 00         [10]  169 	ld	(hl),#0x00
   03BC DD 7E FE      [19]  170 	ld	a,-2 (ix)
   03BF C6 04         [ 7]  171 	add	a, #0x04
   03C1 6F            [ 4]  172 	ld	l,a
   03C2 DD 7E FF      [19]  173 	ld	a,-1 (ix)
   03C5 CE 00         [ 7]  174 	adc	a, #0x00
   03C7 67            [ 4]  175 	ld	h,a
   03C8 36 33         [10]  176 	ld	(hl),#0x33
   03CA 23            [ 6]  177 	inc	hl
   03CB 36 00         [10]  178 	ld	(hl),#0x00
                            179 ;src/IA.c:141: while(i<3)
   03CD 01 87 1C      [10]  180 	ld	bc,#_aceleracion+0
   03D0                     181 00106$:
   03D0 7B            [ 4]  182 	ld	a,e
   03D1 D6 03         [ 7]  183 	sub	a, #0x03
   03D3 30 1F         [12]  184 	jr	NC,00125$
                            185 ;src/IA.c:143: aceleracion[i] = aux[i];
   03D5 6B            [ 4]  186 	ld	l,e
   03D6 26 00         [ 7]  187 	ld	h,#0x00
   03D8 29            [11]  188 	add	hl, hl
   03D9 E5            [11]  189 	push	hl
   03DA FD E1         [14]  190 	pop	iy
   03DC FD 09         [15]  191 	add	iy, bc
   03DE DD 7E FE      [19]  192 	ld	a,-2 (ix)
   03E1 85            [ 4]  193 	add	a, l
   03E2 6F            [ 4]  194 	ld	l,a
   03E3 DD 7E FF      [19]  195 	ld	a,-1 (ix)
   03E6 8C            [ 4]  196 	adc	a, h
   03E7 67            [ 4]  197 	ld	h,a
   03E8 7E            [ 7]  198 	ld	a, (hl)
   03E9 23            [ 6]  199 	inc	hl
   03EA 56            [ 7]  200 	ld	d,(hl)
   03EB FD 77 00      [19]  201 	ld	0 (iy), a
   03EE FD 72 01      [19]  202 	ld	1 (iy),d
                            203 ;src/IA.c:144: i++;
   03F1 1C            [ 4]  204 	inc	e
   03F2 18 DC         [12]  205 	jr	00106$
                            206 ;src/IA.c:147: default:{
   03F4                     207 00125$:
   03F4                     208 00109$:
                            209 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   03F4 21 00 00      [10]  210 	ld	hl,#0x0000
   03F7 39            [11]  211 	add	hl,sp
   03F8 4D            [ 4]  212 	ld	c,l
   03F9 44            [ 4]  213 	ld	b,h
   03FA 36 19         [10]  214 	ld	(hl),#0x19
   03FC 23            [ 6]  215 	inc	hl
   03FD 36 00         [10]  216 	ld	(hl),#0x00
   03FF 69            [ 4]  217 	ld	l, c
   0400 60            [ 4]  218 	ld	h, b
   0401 23            [ 6]  219 	inc	hl
   0402 23            [ 6]  220 	inc	hl
   0403 36 33         [10]  221 	ld	(hl),#0x33
   0405 23            [ 6]  222 	inc	hl
   0406 36 00         [10]  223 	ld	(hl),#0x00
   0408 21 04 00      [10]  224 	ld	hl,#0x0004
   040B 09            [11]  225 	add	hl,bc
   040C 36 4C         [10]  226 	ld	(hl),#0x4C
   040E 23            [ 6]  227 	inc	hl
   040F 36 00         [10]  228 	ld	(hl),#0x00
                            229 ;src/IA.c:149: while(i<3)
   0411                     230 00110$:
   0411 7B            [ 4]  231 	ld	a,e
   0412 D6 03         [ 7]  232 	sub	a, #0x03
   0414 30 1B         [12]  233 	jr	NC,00114$
                            234 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   0416 6B            [ 4]  235 	ld	l,e
   0417 26 00         [ 7]  236 	ld	h,#0x00
   0419 29            [11]  237 	add	hl, hl
   041A FD 21 87 1C   [14]  238 	ld	iy,#_aceleracion
   041E C5            [11]  239 	push	bc
   041F 4D            [ 4]  240 	ld	c, l
   0420 44            [ 4]  241 	ld	b, h
   0421 FD 09         [15]  242 	add	iy, bc
   0423 C1            [10]  243 	pop	bc
   0424 09            [11]  244 	add	hl,bc
   0425 7E            [ 7]  245 	ld	a, (hl)
   0426 23            [ 6]  246 	inc	hl
   0427 66            [ 7]  247 	ld	h,(hl)
   0428 FD 77 00      [19]  248 	ld	0 (iy), a
   042B FD 74 01      [19]  249 	ld	1 (iy),h
                            250 ;src/IA.c:152: i++;
   042E 1C            [ 4]  251 	inc	e
   042F 18 E0         [12]  252 	jr	00110$
                            253 ;src/IA.c:155: }
   0431                     254 00114$:
   0431 DD F9         [10]  255 	ld	sp, ix
   0433 DD E1         [14]  256 	pop	ix
   0435 C9            [10]  257 	ret
   0436                     258 _cerca:
   0436 00 00               259 	.dw #0x0000
   0438 00 05               260 	.dw #0x0500
   043A 01                  261 	.db #0x01	; 1
   043B 00 0A               262 	.dw #0x0A00
   043D 00 0A               263 	.dw #0x0A00
   043F 00 0A               264 	.dw #0x0A00
   0441                     265 _medio:
   0441 00 00               266 	.dw #0x0000
   0443 00 14               267 	.dw #0x1400
   0445 00                  268 	.db #0x00	; 0
   0446 00 14               269 	.dw #0x1400
   0448 00 0A               270 	.dw #0x0A00
   044A 00 0F               271 	.dw #0x0F00
   044C                     272 _lejos:
   044C 00 00               273 	.dw #0x0000
   044E 00 6E               274 	.dw #0x6E00
   0450 02                  275 	.db #0x02	; 2
   0451 00 3C               276 	.dw #0x3C00
   0453 00 19               277 	.dw #0x1900
   0455 00 64               278 	.dw #0x6400
   0457                     279 _acelMu:
   0457 00 00               280 	.dw #0x0000
   0459 80 57               281 	.dw #0x5780
   045B 02                  282 	.db #0x02	; 2
   045C 00 4B               283 	.dw #0x4B00
   045E 00 19               284 	.dw #0x1900
   0460 00 19               285 	.dw #0x1900
   0462                     286 _acelPo:
   0462 00 00               287 	.dw #0x0000
   0464 80 0C               288 	.dw #0x0C80
   0466 01                  289 	.db #0x01	; 1
   0467 00 19               290 	.dw #0x1900
   0469 00 19               291 	.dw #0x1900
   046B 00 19               292 	.dw #0x1900
   046D                     293 _acelMed:
   046D 00 00               294 	.dw #0x0000
   046F 00 32               295 	.dw #0x3200
   0471 00                  296 	.db #0x00	; 0
   0472 00 32               297 	.dw #0x3200
   0474 00 19               298 	.dw #0x1900
   0476 00 19               299 	.dw #0x1900
   0478                     300 _rulex:
   0478 36 04               301 	.dw _cerca
   047A 57 04               302 	.dw _acelMu
   047C                     303 _rulex1:
   047C 41 04               304 	.dw _medio
   047E 6D 04               305 	.dw _acelMed
   0480                     306 _rulex2:
   0480 4C 04               307 	.dw _lejos
   0482 62 04               308 	.dw _acelPo
   0484                     309 _ruley:
   0484 36 04               310 	.dw _cerca
   0486 57 04               311 	.dw _acelMu
   0488                     312 _ruley1:
   0488 41 04               313 	.dw _medio
   048A 6D 04               314 	.dw _acelMed
   048C                     315 _ruley2:
   048C 4C 04               316 	.dw _lejos
   048E 62 04               317 	.dw _acelPo
                            318 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            319 ;	---------------------------------
                            320 ; Function calculateDom
                            321 ; ---------------------------------
   0490                     322 _calculateDom::
   0490 DD E5         [15]  323 	push	ix
   0492 DD 21 00 00   [14]  324 	ld	ix,#0
   0496 DD 39         [15]  325 	add	ix,sp
   0498 21 ED FF      [10]  326 	ld	hl,#-19
   049B 39            [11]  327 	add	hl,sp
   049C F9            [ 6]  328 	ld	sp,hl
                            329 ;src/IA.c:161: *grad = 0.0;
   049D DD 5E 07      [19]  330 	ld	e,7 (ix)
   04A0 DD 56 08      [19]  331 	ld	d,8 (ix)
   04A3 6B            [ 4]  332 	ld	l, e
   04A4 62            [ 4]  333 	ld	h, d
   04A5 AF            [ 4]  334 	xor	a, a
   04A6 77            [ 7]  335 	ld	(hl), a
   04A7 23            [ 6]  336 	inc	hl
   04A8 77            [ 7]  337 	ld	(hl), a
                            338 ;src/IA.c:162: if(c->tipo == 0){
   04A9 DD 7E 04      [19]  339 	ld	a,4 (ix)
   04AC DD 77 FE      [19]  340 	ld	-2 (ix),a
   04AF DD 7E 05      [19]  341 	ld	a,5 (ix)
   04B2 DD 77 FF      [19]  342 	ld	-1 (ix),a
   04B5 DD 6E FE      [19]  343 	ld	l,-2 (ix)
   04B8 DD 66 FF      [19]  344 	ld	h,-1 (ix)
   04BB 01 04 00      [10]  345 	ld	bc, #0x0004
   04BE 09            [11]  346 	add	hl, bc
   04BF 4E            [ 7]  347 	ld	c,(hl)
                            348 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   04C0 DD 7E FE      [19]  349 	ld	a,-2 (ix)
   04C3 C6 09         [ 7]  350 	add	a, #0x09
   04C5 DD 77 FA      [19]  351 	ld	-6 (ix),a
   04C8 DD 7E FF      [19]  352 	ld	a,-1 (ix)
   04CB CE 00         [ 7]  353 	adc	a, #0x00
   04CD DD 77 FB      [19]  354 	ld	-5 (ix),a
   04D0 DD 7E FE      [19]  355 	ld	a,-2 (ix)
   04D3 C6 05         [ 7]  356 	add	a, #0x05
   04D5 DD 77 F2      [19]  357 	ld	-14 (ix),a
   04D8 DD 7E FF      [19]  358 	ld	a,-1 (ix)
   04DB CE 00         [ 7]  359 	adc	a, #0x00
   04DD DD 77 F3      [19]  360 	ld	-13 (ix),a
   04E0 DD 7E 06      [19]  361 	ld	a,6 (ix)
   04E3 DD 77 ED      [19]  362 	ld	-19 (ix),a
   04E6 DD 36 EE 00   [19]  363 	ld	-18 (ix),#0x00
                            364 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   04EA DD 7E FE      [19]  365 	ld	a,-2 (ix)
   04ED C6 07         [ 7]  366 	add	a, #0x07
   04EF DD 77 FE      [19]  367 	ld	-2 (ix),a
   04F2 DD 7E FF      [19]  368 	ld	a,-1 (ix)
   04F5 CE 00         [ 7]  369 	adc	a, #0x00
   04F7 DD 77 FF      [19]  370 	ld	-1 (ix),a
                            371 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   04FA DD 6E F2      [19]  372 	ld	l,-14 (ix)
   04FD DD 66 F3      [19]  373 	ld	h,-13 (ix)
   0500 7E            [ 7]  374 	ld	a,(hl)
   0501 DD 77 F6      [19]  375 	ld	-10 (ix),a
   0504 23            [ 6]  376 	inc	hl
   0505 7E            [ 7]  377 	ld	a,(hl)
   0506 DD 77 F7      [19]  378 	ld	-9 (ix),a
                            379 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   0509 DD 7E 06      [19]  380 	ld	a,6 (ix)
   050C DD 77 F8      [19]  381 	ld	-8 (ix),a
   050F DD 36 F9 00   [19]  382 	ld	-7 (ix),#0x00
                            383 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   0513 DD 6E FA      [19]  384 	ld	l,-6 (ix)
   0516 DD 66 FB      [19]  385 	ld	h,-5 (ix)
   0519 7E            [ 7]  386 	ld	a,(hl)
   051A DD 77 F4      [19]  387 	ld	-12 (ix),a
   051D 23            [ 6]  388 	inc	hl
   051E 7E            [ 7]  389 	ld	a,(hl)
   051F DD 77 F5      [19]  390 	ld	-11 (ix),a
                            391 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            392 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   0522 AF            [ 4]  393 	xor	a, a
   0523 DD 96 F4      [19]  394 	sub	a, -12 (ix)
   0526 6F            [ 4]  395 	ld	l,a
   0527 3E 00         [ 7]  396 	ld	a, #0x00
   0529 DD 9E F5      [19]  397 	sbc	a, -11 (ix)
   052C 67            [ 4]  398 	ld	h,a
   052D C5            [11]  399 	push	bc
   052E D5            [11]  400 	push	de
   052F E5            [11]  401 	push	hl
   0530 21 00 01      [10]  402 	ld	hl,#0x0100
   0533 E5            [11]  403 	push	hl
                            404 ;src/IA.c:162: if(c->tipo == 0){
   0534 CD 17 12      [17]  405 	call	__divuint
   0537 F1            [10]  406 	pop	af
   0538 F1            [10]  407 	pop	af
   0539 DD 74 F1      [19]  408 	ld	-15 (ix),h
   053C DD 75 F0      [19]  409 	ld	-16 (ix),l
   053F D1            [10]  410 	pop	de
   0540 C1            [10]  411 	pop	bc
   0541 79            [ 4]  412 	ld	a,c
   0542 B7            [ 4]  413 	or	a, a
   0543 C2 67 06      [10]  414 	jp	NZ,00138$
                            415 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   0546 DD 7E ED      [19]  416 	ld	a,-19 (ix)
   0549 DD 96 F6      [19]  417 	sub	a, -10 (ix)
   054C 20 0C         [12]  418 	jr	NZ,00214$
   054E DD 7E EE      [19]  419 	ld	a,-18 (ix)
   0551 DD 96 F7      [19]  420 	sub	a, -9 (ix)
   0554 20 04         [12]  421 	jr	NZ,00214$
   0556 3E 01         [ 7]  422 	ld	a,#0x01
   0558 18 01         [12]  423 	jr	00215$
   055A                     424 00214$:
   055A AF            [ 4]  425 	xor	a,a
   055B                     426 00215$:
   055B 47            [ 4]  427 	ld	b,a
   055C DD 7E F5      [19]  428 	ld	a,-11 (ix)
   055F DD B6 F4      [19]  429 	or	a,-12 (ix)
   0562 20 04         [12]  430 	jr	NZ,00105$
   0564 78            [ 4]  431 	ld	a,b
   0565 B7            [ 4]  432 	or	a, a
   0566 20 10         [12]  433 	jr	NZ,00101$
   0568                     434 00105$:
                            435 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   0568 DD 6E FE      [19]  436 	ld	l,-2 (ix)
   056B DD 66 FF      [19]  437 	ld	h,-1 (ix)
   056E 4E            [ 7]  438 	ld	c,(hl)
   056F 23            [ 6]  439 	inc	hl
   0570 66            [ 7]  440 	ld	h,(hl)
   0571 7C            [ 4]  441 	ld	a,h
   0572 B1            [ 4]  442 	or	a,c
   0573 20 0D         [12]  443 	jr	NZ,00102$
   0575 B0            [ 4]  444 	or	a,b
   0576 28 0A         [12]  445 	jr	Z,00102$
   0578                     446 00101$:
                            447 ;src/IA.c:167: *grad = SCALA;
   0578 3E 00         [ 7]  448 	ld	a,#0x00
   057A 12            [ 7]  449 	ld	(de),a
   057B 13            [ 6]  450 	inc	de
   057C 3E 01         [ 7]  451 	ld	a,#0x01
   057E 12            [ 7]  452 	ld	(de),a
                            453 ;src/IA.c:168: return;
   057F C3 B1 07      [10]  454 	jp	00140$
   0582                     455 00102$:
                            456 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   0582 DD 7E F6      [19]  457 	ld	a,-10 (ix)
   0585 DD 96 ED      [19]  458 	sub	a, -19 (ix)
   0588 DD 7E F7      [19]  459 	ld	a,-9 (ix)
   058B DD 9E EE      [19]  460 	sbc	a, -18 (ix)
   058E 3E 00         [ 7]  461 	ld	a,#0x00
   0590 17            [ 4]  462 	rla
   0591 DD 77 EF      [19]  463 	ld	-17 (ix),a
   0594 DD CB EF 46   [20]  464 	bit	0,-17 (ix)
   0598 20 68         [12]  465 	jr	NZ,00111$
   059A DD 7E F6      [19]  466 	ld	a,-10 (ix)
   059D 91            [ 4]  467 	sub	a, c
   059E 47            [ 4]  468 	ld	b,a
   059F DD 7E F7      [19]  469 	ld	a,-9 (ix)
   05A2 9C            [ 4]  470 	sbc	a, h
   05A3 6F            [ 4]  471 	ld	l,a
   05A4 DD 7E ED      [19]  472 	ld	a,-19 (ix)
   05A7 90            [ 4]  473 	sub	a, b
   05A8 DD 7E EE      [19]  474 	ld	a,-18 (ix)
   05AB 9D            [ 4]  475 	sbc	a, l
   05AC 38 54         [12]  476 	jr	C,00111$
                            477 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   05AE D5            [11]  478 	push	de
   05AF 69            [ 4]  479 	ld	l, c
   05B0 E5            [11]  480 	push	hl
   05B1 21 00 01      [10]  481 	ld	hl,#0x0100
   05B4 E5            [11]  482 	push	hl
   05B5 CD 17 12      [17]  483 	call	__divuint
   05B8 F1            [10]  484 	pop	af
   05B9 F1            [10]  485 	pop	af
   05BA 4D            [ 4]  486 	ld	c,l
   05BB 44            [ 4]  487 	ld	b,h
   05BC D1            [10]  488 	pop	de
   05BD 6B            [ 4]  489 	ld	l, e
   05BE 62            [ 4]  490 	ld	h, d
   05BF 71            [ 7]  491 	ld	(hl),c
   05C0 23            [ 6]  492 	inc	hl
   05C1 70            [ 7]  493 	ld	(hl),b
                            494 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   05C2 DD 6E F2      [19]  495 	ld	l,-14 (ix)
   05C5 DD 66 F3      [19]  496 	ld	h,-13 (ix)
   05C8 7E            [ 7]  497 	ld	a,(hl)
   05C9 DD 77 FC      [19]  498 	ld	-4 (ix),a
   05CC 23            [ 6]  499 	inc	hl
   05CD 7E            [ 7]  500 	ld	a,(hl)
   05CE DD 77 FD      [19]  501 	ld	-3 (ix),a
   05D1 DD 6E FE      [19]  502 	ld	l,-2 (ix)
   05D4 DD 66 FF      [19]  503 	ld	h,-1 (ix)
   05D7 7E            [ 7]  504 	ld	a, (hl)
   05D8 23            [ 6]  505 	inc	hl
   05D9 66            [ 7]  506 	ld	h,(hl)
   05DA 6F            [ 4]  507 	ld	l,a
   05DB DD 7E FC      [19]  508 	ld	a,-4 (ix)
   05DE 95            [ 4]  509 	sub	a, l
   05DF 6F            [ 4]  510 	ld	l,a
   05E0 DD 7E FD      [19]  511 	ld	a,-3 (ix)
   05E3 9C            [ 4]  512 	sbc	a, h
   05E4 67            [ 4]  513 	ld	h,a
   05E5 DD 7E F8      [19]  514 	ld	a,-8 (ix)
   05E8 95            [ 4]  515 	sub	a, l
   05E9 6F            [ 4]  516 	ld	l,a
   05EA DD 7E F9      [19]  517 	ld	a,-7 (ix)
   05ED 9C            [ 4]  518 	sbc	a, h
   05EE 67            [ 4]  519 	ld	h,a
   05EF D5            [11]  520 	push	de
   05F0 E5            [11]  521 	push	hl
   05F1 C5            [11]  522 	push	bc
   05F2 CD 40 1B      [17]  523 	call	__mulint
   05F5 F1            [10]  524 	pop	af
   05F6 F1            [10]  525 	pop	af
   05F7 4D            [ 4]  526 	ld	c,l
   05F8 44            [ 4]  527 	ld	b,h
   05F9 D1            [10]  528 	pop	de
   05FA 79            [ 4]  529 	ld	a,c
   05FB 12            [ 7]  530 	ld	(de),a
   05FC 13            [ 6]  531 	inc	de
   05FD 78            [ 4]  532 	ld	a,b
   05FE 12            [ 7]  533 	ld	(de),a
                            534 ;src/IA.c:175: return;
   05FF C3 B1 07      [10]  535 	jp	00140$
   0602                     536 00111$:
                            537 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   0602 DD CB EF 46   [20]  538 	bit	0,-17 (ix)
   0606 28 55         [12]  539 	jr	Z,00107$
   0608 DD 7E F6      [19]  540 	ld	a,-10 (ix)
   060B DD 86 F4      [19]  541 	add	a, -12 (ix)
   060E 4F            [ 4]  542 	ld	c,a
   060F DD 7E F7      [19]  543 	ld	a,-9 (ix)
   0612 DD 8E F5      [19]  544 	adc	a, -11 (ix)
   0615 47            [ 4]  545 	ld	b,a
   0616 DD 7E ED      [19]  546 	ld	a,-19 (ix)
   0619 91            [ 4]  547 	sub	a, c
   061A DD 7E EE      [19]  548 	ld	a,-18 (ix)
   061D 98            [ 4]  549 	sbc	a, b
   061E 30 3D         [12]  550 	jr	NC,00107$
                            551 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   0620 6B            [ 4]  552 	ld	l, e
   0621 62            [ 4]  553 	ld	h, d
   0622 DD 7E F0      [19]  554 	ld	a,-16 (ix)
   0625 77            [ 7]  555 	ld	(hl),a
   0626 23            [ 6]  556 	inc	hl
   0627 DD 7E F1      [19]  557 	ld	a,-15 (ix)
   062A 77            [ 7]  558 	ld	(hl),a
                            559 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   062B DD 6E F2      [19]  560 	ld	l,-14 (ix)
   062E DD 66 F3      [19]  561 	ld	h,-13 (ix)
   0631 4E            [ 7]  562 	ld	c,(hl)
   0632 23            [ 6]  563 	inc	hl
   0633 46            [ 7]  564 	ld	b,(hl)
   0634 DD 7E F8      [19]  565 	ld	a,-8 (ix)
   0637 91            [ 4]  566 	sub	a, c
   0638 4F            [ 4]  567 	ld	c,a
   0639 DD 7E F9      [19]  568 	ld	a,-7 (ix)
   063C 98            [ 4]  569 	sbc	a, b
   063D 47            [ 4]  570 	ld	b,a
   063E D5            [11]  571 	push	de
   063F C5            [11]  572 	push	bc
   0640 DD 6E F0      [19]  573 	ld	l,-16 (ix)
   0643 DD 66 F1      [19]  574 	ld	h,-15 (ix)
   0646 E5            [11]  575 	push	hl
   0647 CD 40 1B      [17]  576 	call	__mulint
   064A F1            [10]  577 	pop	af
   064B F1            [10]  578 	pop	af
   064C 4D            [ 4]  579 	ld	c,l
   064D 44            [ 4]  580 	ld	b,h
   064E D1            [10]  581 	pop	de
   064F 21 00 01      [10]  582 	ld	hl,#0x0100
   0652 09            [11]  583 	add	hl,bc
   0653 4D            [ 4]  584 	ld	c,l
   0654 44            [ 4]  585 	ld	b,h
   0655 79            [ 4]  586 	ld	a,c
   0656 12            [ 7]  587 	ld	(de),a
   0657 13            [ 6]  588 	inc	de
   0658 78            [ 4]  589 	ld	a,b
   0659 12            [ 7]  590 	ld	(de),a
                            591 ;src/IA.c:180: return;
   065A C3 B1 07      [10]  592 	jp	00140$
   065D                     593 00107$:
                            594 ;src/IA.c:183: *grad = 0;
   065D 3E 00         [ 7]  595 	ld	a,#0x00
   065F 12            [ 7]  596 	ld	(de),a
   0660 13            [ 6]  597 	inc	de
   0661 3E 00         [ 7]  598 	ld	a,#0x00
   0663 12            [ 7]  599 	ld	(de),a
                            600 ;src/IA.c:184: return;
   0664 C3 B1 07      [10]  601 	jp	00140$
   0667                     602 00138$:
                            603 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   0667 DD 6E F6      [19]  604 	ld	l,-10 (ix)
   066A DD 7E F4      [19]  605 	ld	a,-12 (ix)
   066D DD 77 FC      [19]  606 	ld	-4 (ix),a
   0670 7D            [ 4]  607 	ld	a,l
   0671 DD 86 FC      [19]  608 	add	a, -4 (ix)
   0674 DD 96 FC      [19]  609 	sub	a, -4 (ix)
   0677 47            [ 4]  610 	ld	b,a
                            611 ;src/IA.c:187: }else if(c->tipo == 1)
   0678 0D            [ 4]  612 	dec	c
   0679 C2 09 07      [10]  613 	jp	NZ,00135$
                            614 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   067C 48            [ 4]  615 	ld	c,b
                            616 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   067D DD 7E F5      [19]  617 	ld	a,-11 (ix)
   0680 DD B6 F4      [19]  618 	or	a,-12 (ix)
   0683 20 0E         [12]  619 	jr	NZ,00115$
   0685 DD 7E 06      [19]  620 	ld	a,6 (ix)
                            621 ;src/IA.c:193: *grad = SCALA;
   0688 91            [ 4]  622 	sub	a,c
   0689 20 08         [12]  623 	jr	NZ,00115$
   068B 12            [ 7]  624 	ld	(de),a
   068C 13            [ 6]  625 	inc	de
   068D 3E 01         [ 7]  626 	ld	a,#0x01
   068F 12            [ 7]  627 	ld	(de),a
                            628 ;src/IA.c:194: return;
   0690 C3 B1 07      [10]  629 	jp	00140$
   0693                     630 00115$:
                            631 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   0693 DD 7E 06      [19]  632 	ld	a,6 (ix)
   0696 91            [ 4]  633 	sub	a, c
   0697 3E 00         [ 7]  634 	ld	a,#0x00
   0699 17            [ 4]  635 	rla
   069A DD 77 FC      [19]  636 	ld	-4 (ix),a
   069D DD CB FC 46   [20]  637 	bit	0,-4 (ix)
   06A1 20 4C         [12]  638 	jr	NZ,00121$
   06A3 06 00         [ 7]  639 	ld	b,#0x00
   06A5 DD 6E F4      [19]  640 	ld	l,-12 (ix)
   06A8 DD 66 F5      [19]  641 	ld	h,-11 (ix)
   06AB 09            [11]  642 	add	hl,bc
   06AC DD 7E ED      [19]  643 	ld	a,-19 (ix)
   06AF 95            [ 4]  644 	sub	a, l
   06B0 DD 7E EE      [19]  645 	ld	a,-18 (ix)
   06B3 9C            [ 4]  646 	sbc	a, h
   06B4 30 39         [12]  647 	jr	NC,00121$
                            648 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   06B6 6B            [ 4]  649 	ld	l, e
   06B7 62            [ 4]  650 	ld	h, d
   06B8 DD 7E F0      [19]  651 	ld	a,-16 (ix)
   06BB 77            [ 7]  652 	ld	(hl),a
   06BC 23            [ 6]  653 	inc	hl
   06BD DD 7E F1      [19]  654 	ld	a,-15 (ix)
   06C0 77            [ 7]  655 	ld	(hl),a
                            656 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   06C1 DD 6E FA      [19]  657 	ld	l,-6 (ix)
   06C4 DD 66 FB      [19]  658 	ld	h,-5 (ix)
   06C7 7E            [ 7]  659 	ld	a, (hl)
   06C8 23            [ 6]  660 	inc	hl
   06C9 66            [ 7]  661 	ld	h,(hl)
   06CA 6F            [ 4]  662 	ld	l,a
   06CB 09            [11]  663 	add	hl,bc
   06CC DD 7E F8      [19]  664 	ld	a,-8 (ix)
   06CF 95            [ 4]  665 	sub	a, l
   06D0 4F            [ 4]  666 	ld	c,a
   06D1 DD 7E F9      [19]  667 	ld	a,-7 (ix)
   06D4 9C            [ 4]  668 	sbc	a, h
   06D5 47            [ 4]  669 	ld	b,a
   06D6 D5            [11]  670 	push	de
   06D7 C5            [11]  671 	push	bc
   06D8 DD 6E F0      [19]  672 	ld	l,-16 (ix)
   06DB DD 66 F1      [19]  673 	ld	h,-15 (ix)
   06DE E5            [11]  674 	push	hl
   06DF CD 40 1B      [17]  675 	call	__mulint
   06E2 F1            [10]  676 	pop	af
   06E3 F1            [10]  677 	pop	af
   06E4 4D            [ 4]  678 	ld	c,l
   06E5 44            [ 4]  679 	ld	b,h
   06E6 D1            [10]  680 	pop	de
   06E7 79            [ 4]  681 	ld	a,c
   06E8 12            [ 7]  682 	ld	(de),a
   06E9 13            [ 6]  683 	inc	de
   06EA 78            [ 4]  684 	ld	a,b
   06EB 12            [ 7]  685 	ld	(de),a
                            686 ;src/IA.c:201: return;
   06EC C3 B1 07      [10]  687 	jp	00140$
   06EF                     688 00121$:
                            689 ;src/IA.c:202: }else if(val < midPoint)
   06EF DD CB FC 46   [20]  690 	bit	0,-4 (ix)
   06F3 28 0A         [12]  691 	jr	Z,00118$
                            692 ;src/IA.c:204: *grad = SCALA;
   06F5 3E 00         [ 7]  693 	ld	a,#0x00
   06F7 12            [ 7]  694 	ld	(de),a
   06F8 13            [ 6]  695 	inc	de
   06F9 3E 01         [ 7]  696 	ld	a,#0x01
   06FB 12            [ 7]  697 	ld	(de),a
                            698 ;src/IA.c:205: return;
   06FC C3 B1 07      [10]  699 	jp	00140$
   06FF                     700 00118$:
                            701 ;src/IA.c:207: *grad = 0;
   06FF 3E 00         [ 7]  702 	ld	a,#0x00
   0701 12            [ 7]  703 	ld	(de),a
   0702 13            [ 6]  704 	inc	de
   0703 3E 00         [ 7]  705 	ld	a,#0x00
   0705 12            [ 7]  706 	ld	(de),a
                            707 ;src/IA.c:208: return;
   0706 C3 B1 07      [10]  708 	jp	00140$
   0709                     709 00135$:
                            710 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            711 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   0709 DD 6E FE      [19]  712 	ld	l,-2 (ix)
   070C DD 66 FF      [19]  713 	ld	h,-1 (ix)
   070F 4E            [ 7]  714 	ld	c,(hl)
   0710 23            [ 6]  715 	inc	hl
   0711 7E            [ 7]  716 	ld	a, (hl)
   0712 B1            [ 4]  717 	or	a,c
   0713 20 0D         [12]  718 	jr	NZ,00125$
   0715 DD 7E 06      [19]  719 	ld	a,6 (ix)
   0718 90            [ 4]  720 	sub	a, b
   0719 20 07         [12]  721 	jr	NZ,00125$
                            722 ;src/IA.c:215: *grad = SCALA;
   071B 6B            [ 4]  723 	ld	l, e
   071C 62            [ 4]  724 	ld	h, d
   071D 36 00         [10]  725 	ld	(hl),#0x00
   071F 23            [ 6]  726 	inc	hl
   0720 36 01         [10]  727 	ld	(hl),#0x01
   0722                     728 00125$:
                            729 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   0722 78            [ 4]  730 	ld	a,b
   0723 DD 96 06      [19]  731 	sub	a, 6 (ix)
   0726 3E 00         [ 7]  732 	ld	a,#0x00
   0728 17            [ 4]  733 	rla
   0729 DD 77 FC      [19]  734 	ld	-4 (ix),a
   072C DD CB FC 46   [20]  735 	bit	0,-4 (ix)
   0730 20 69         [12]  736 	jr	NZ,00131$
   0732 0E 00         [ 7]  737 	ld	c,#0x00
   0734 DD 6E FE      [19]  738 	ld	l,-2 (ix)
   0737 DD 66 FF      [19]  739 	ld	h,-1 (ix)
   073A 7E            [ 7]  740 	ld	a, (hl)
   073B 23            [ 6]  741 	inc	hl
   073C 66            [ 7]  742 	ld	h,(hl)
   073D 6F            [ 4]  743 	ld	l,a
   073E DD 70 F0      [19]  744 	ld	-16 (ix),b
   0741 DD 71 F1      [19]  745 	ld	-15 (ix),c
   0744 DD 7E F0      [19]  746 	ld	a,-16 (ix)
   0747 95            [ 4]  747 	sub	a, l
   0748 4F            [ 4]  748 	ld	c,a
   0749 DD 7E F1      [19]  749 	ld	a,-15 (ix)
   074C 9C            [ 4]  750 	sbc	a, h
   074D 47            [ 4]  751 	ld	b,a
   074E 79            [ 4]  752 	ld	a,c
   074F DD 96 ED      [19]  753 	sub	a, -19 (ix)
   0752 78            [ 4]  754 	ld	a,b
   0753 DD 9E EE      [19]  755 	sbc	a, -18 (ix)
   0756 30 43         [12]  756 	jr	NC,00131$
                            757 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   0758 D5            [11]  758 	push	de
   0759 E5            [11]  759 	push	hl
   075A 21 00 01      [10]  760 	ld	hl,#0x0100
   075D E5            [11]  761 	push	hl
   075E CD 17 12      [17]  762 	call	__divuint
   0761 F1            [10]  763 	pop	af
   0762 F1            [10]  764 	pop	af
   0763 4D            [ 4]  765 	ld	c,l
   0764 44            [ 4]  766 	ld	b,h
   0765 D1            [10]  767 	pop	de
   0766 6B            [ 4]  768 	ld	l, e
   0767 62            [ 4]  769 	ld	h, d
   0768 71            [ 7]  770 	ld	(hl),c
   0769 23            [ 6]  771 	inc	hl
   076A 70            [ 7]  772 	ld	(hl),b
                            773 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   076B DD 6E FE      [19]  774 	ld	l,-2 (ix)
   076E DD 66 FF      [19]  775 	ld	h,-1 (ix)
   0771 7E            [ 7]  776 	ld	a, (hl)
   0772 23            [ 6]  777 	inc	hl
   0773 66            [ 7]  778 	ld	h,(hl)
   0774 6F            [ 4]  779 	ld	l,a
   0775 DD 7E F0      [19]  780 	ld	a,-16 (ix)
   0778 95            [ 4]  781 	sub	a, l
   0779 6F            [ 4]  782 	ld	l,a
   077A DD 7E F1      [19]  783 	ld	a,-15 (ix)
   077D 9C            [ 4]  784 	sbc	a, h
   077E 67            [ 4]  785 	ld	h,a
   077F DD 7E F8      [19]  786 	ld	a,-8 (ix)
   0782 95            [ 4]  787 	sub	a, l
   0783 6F            [ 4]  788 	ld	l,a
   0784 DD 7E F9      [19]  789 	ld	a,-7 (ix)
   0787 9C            [ 4]  790 	sbc	a, h
   0788 67            [ 4]  791 	ld	h,a
   0789 D5            [11]  792 	push	de
   078A E5            [11]  793 	push	hl
   078B C5            [11]  794 	push	bc
   078C CD 40 1B      [17]  795 	call	__mulint
   078F F1            [10]  796 	pop	af
   0790 F1            [10]  797 	pop	af
   0791 4D            [ 4]  798 	ld	c,l
   0792 44            [ 4]  799 	ld	b,h
   0793 D1            [10]  800 	pop	de
   0794 79            [ 4]  801 	ld	a,c
   0795 12            [ 7]  802 	ld	(de),a
   0796 13            [ 6]  803 	inc	de
   0797 78            [ 4]  804 	ld	a,b
   0798 12            [ 7]  805 	ld	(de),a
   0799 18 16         [12]  806 	jr	00140$
   079B                     807 00131$:
                            808 ;src/IA.c:220: }else if(val > midPoint)
   079B DD CB FC 46   [20]  809 	bit	0,-4 (ix)
   079F 28 09         [12]  810 	jr	Z,00128$
                            811 ;src/IA.c:223: *grad = SCALA;
   07A1 3E 00         [ 7]  812 	ld	a,#0x00
   07A3 12            [ 7]  813 	ld	(de),a
   07A4 13            [ 6]  814 	inc	de
   07A5 3E 01         [ 7]  815 	ld	a,#0x01
   07A7 12            [ 7]  816 	ld	(de),a
   07A8 18 07         [12]  817 	jr	00140$
   07AA                     818 00128$:
                            819 ;src/IA.c:225: *grad = 0;
   07AA 3E 00         [ 7]  820 	ld	a,#0x00
   07AC 12            [ 7]  821 	ld	(de),a
   07AD 13            [ 6]  822 	inc	de
   07AE 3E 00         [ 7]  823 	ld	a,#0x00
   07B0 12            [ 7]  824 	ld	(de),a
   07B1                     825 00140$:
   07B1 DD F9         [10]  826 	ld	sp, ix
   07B3 DD E1         [14]  827 	pop	ix
   07B5 C9            [10]  828 	ret
                            829 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            830 ;	---------------------------------
                            831 ; Function defuzzi
                            832 ; ---------------------------------
   07B6                     833 _defuzzi::
   07B6 DD E5         [15]  834 	push	ix
   07B8 DD 21 00 00   [14]  835 	ld	ix,#0
   07BC DD 39         [15]  836 	add	ix,sp
   07BE 21 EF FF      [10]  837 	ld	hl,#-17
   07C1 39            [11]  838 	add	hl,sp
   07C2 F9            [ 6]  839 	ld	sp,hl
                            840 ;src/IA.c:239: *re = 0;
   07C3 DD 7E 08      [19]  841 	ld	a,8 (ix)
   07C6 DD 77 FC      [19]  842 	ld	-4 (ix),a
   07C9 DD 7E 09      [19]  843 	ld	a,9 (ix)
   07CC DD 77 FD      [19]  844 	ld	-3 (ix),a
   07CF DD 6E FC      [19]  845 	ld	l,-4 (ix)
   07D2 DD 66 FD      [19]  846 	ld	h,-3 (ix)
   07D5 AF            [ 4]  847 	xor	a, a
   07D6 77            [ 7]  848 	ld	(hl), a
   07D7 23            [ 6]  849 	inc	hl
   07D8 77            [ 7]  850 	ld	(hl), a
                            851 ;src/IA.c:241: while(i < 3)
   07D9 21 01 00      [10]  852 	ld	hl,#0x0001
   07DC 39            [11]  853 	add	hl,sp
   07DD DD 75 F8      [19]  854 	ld	-8 (ix),l
   07E0 DD 74 F9      [19]  855 	ld	-7 (ix),h
   07E3 0E 00         [ 7]  856 	ld	c,#0x00
   07E5                     857 00101$:
   07E5 79            [ 4]  858 	ld	a,c
   07E6 D6 03         [ 7]  859 	sub	a, #0x03
   07E8 30 53         [12]  860 	jr	NC,00103$
                            861 ;src/IA.c:243: dom = 0;
   07EA DD 36 F6 00   [19]  862 	ld	-10 (ix),#0x00
   07EE DD 36 F7 00   [19]  863 	ld	-9 (ix),#0x00
                            864 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   07F2 21 07 00      [10]  865 	ld	hl,#0x0007
   07F5 39            [11]  866 	add	hl,sp
   07F6 DD 75 FA      [19]  867 	ld	-6 (ix),l
   07F9 DD 74 FB      [19]  868 	ld	-5 (ix),h
   07FC DD 46 04      [19]  869 	ld	b,4 (ix)
   07FF 69            [ 4]  870 	ld	l,c
   0800 26 00         [ 7]  871 	ld	h,#0x00
   0802 29            [11]  872 	add	hl, hl
   0803 EB            [ 4]  873 	ex	de,hl
   0804 21 99 1C      [10]  874 	ld	hl,#_fmems
   0807 19            [11]  875 	add	hl,de
   0808 7E            [ 7]  876 	ld	a,(hl)
   0809 DD 77 FE      [19]  877 	ld	-2 (ix),a
   080C 23            [ 6]  878 	inc	hl
   080D 7E            [ 7]  879 	ld	a,(hl)
   080E DD 77 FF      [19]  880 	ld	-1 (ix),a
   0811 C5            [11]  881 	push	bc
   0812 D5            [11]  882 	push	de
   0813 DD 6E FA      [19]  883 	ld	l,-6 (ix)
   0816 DD 66 FB      [19]  884 	ld	h,-5 (ix)
   0819 E5            [11]  885 	push	hl
   081A C5            [11]  886 	push	bc
   081B 33            [ 6]  887 	inc	sp
   081C DD 6E FE      [19]  888 	ld	l,-2 (ix)
   081F DD 66 FF      [19]  889 	ld	h,-1 (ix)
   0822 E5            [11]  890 	push	hl
   0823 CD 90 04      [17]  891 	call	_calculateDom
   0826 F1            [10]  892 	pop	af
   0827 F1            [10]  893 	pop	af
   0828 33            [ 6]  894 	inc	sp
   0829 D1            [10]  895 	pop	de
   082A C1            [10]  896 	pop	bc
                            897 ;src/IA.c:245: vDom[i] = dom/SCALA;
   082B DD 6E F8      [19]  898 	ld	l,-8 (ix)
   082E DD 66 F9      [19]  899 	ld	h,-7 (ix)
   0831 19            [11]  900 	add	hl,de
   0832 DD 5E F7      [19]  901 	ld	e,-9 (ix)
   0835 16 00         [ 7]  902 	ld	d,#0x00
   0837 73            [ 7]  903 	ld	(hl),e
   0838 23            [ 6]  904 	inc	hl
   0839 72            [ 7]  905 	ld	(hl),d
                            906 ;src/IA.c:246: i++;
   083A 0C            [ 4]  907 	inc	c
   083B 18 A8         [12]  908 	jr	00101$
   083D                     909 00103$:
                            910 ;src/IA.c:250: for(i = 0; i<3; i++)
   083D DD 36 EF 00   [19]  911 	ld	-17 (ix),#0x00
   0841                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   0841 DD 6E EF      [19]  914 	ld	l,-17 (ix)
   0844 26 00         [ 7]  915 	ld	h,#0x00
   0846 29            [11]  916 	add	hl, hl
   0847 4D            [ 4]  917 	ld	c, l
   0848 44            [ 4]  918 	ld	b, h
   0849 DD 6E F8      [19]  919 	ld	l,-8 (ix)
   084C DD 66 F9      [19]  920 	ld	h,-7 (ix)
   084F 09            [11]  921 	add	hl,bc
   0850 5E            [ 7]  922 	ld	e,(hl)
   0851 23            [ 6]  923 	inc	hl
   0852 56            [ 7]  924 	ld	d,(hl)
   0853 21 87 1C      [10]  925 	ld	hl,#_aceleracion
   0856 09            [11]  926 	add	hl,bc
   0857 4E            [ 7]  927 	ld	c,(hl)
   0858 23            [ 6]  928 	inc	hl
   0859 46            [ 7]  929 	ld	b,(hl)
   085A C5            [11]  930 	push	bc
   085B D5            [11]  931 	push	de
   085C CD 40 1B      [17]  932 	call	__mulint
   085F F1            [10]  933 	pop	af
   0860 F1            [10]  934 	pop	af
   0861 4D            [ 4]  935 	ld	c,l
   0862 44            [ 4]  936 	ld	b,h
   0863 DD 6E FC      [19]  937 	ld	l,-4 (ix)
   0866 DD 66 FD      [19]  938 	ld	h,-3 (ix)
   0869 5E            [ 7]  939 	ld	e,(hl)
   086A 23            [ 6]  940 	inc	hl
   086B 66            [ 7]  941 	ld	h,(hl)
   086C 6B            [ 4]  942 	ld	l, e
   086D 09            [11]  943 	add	hl,bc
   086E 4D            [ 4]  944 	ld	c,l
   086F 44            [ 4]  945 	ld	b,h
   0870 DD 6E FC      [19]  946 	ld	l,-4 (ix)
   0873 DD 66 FD      [19]  947 	ld	h,-3 (ix)
   0876 71            [ 7]  948 	ld	(hl),c
   0877 23            [ 6]  949 	inc	hl
   0878 70            [ 7]  950 	ld	(hl),b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   0879 DD 34 EF      [23]  952 	inc	-17 (ix)
   087C DD 7E EF      [19]  953 	ld	a,-17 (ix)
   087F D6 03         [ 7]  954 	sub	a, #0x03
   0881 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   0883 DD 6E 06      [19]  957 	ld	l,6 (ix)
   0886 DD 66 07      [19]  958 	ld	h,7 (ix)
   0889 23            [ 6]  959 	inc	hl
   088A 7E            [ 7]  960 	ld	a,(hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   088B DD 6E FC      [19]  962 	ld	l,-4 (ix)
   088E DD 66 FD      [19]  963 	ld	h,-3 (ix)
   0891 5E            [ 7]  964 	ld	e,(hl)
   0892 23            [ 6]  965 	inc	hl
   0893 56            [ 7]  966 	ld	d,(hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   0894 B7            [ 4]  968 	or	a, a
   0895 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   0897 DD 6E FC      [19]  971 	ld	l,-4 (ix)
   089A DD 66 FD      [19]  972 	ld	h,-3 (ix)
   089D 73            [ 7]  973 	ld	(hl),e
   089E 23            [ 6]  974 	inc	hl
   089F 72            [ 7]  975 	ld	(hl),d
   08A0 18 10         [12]  976 	jr	00110$
   08A2                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   08A2 AF            [ 4]  979 	xor	a, a
   08A3 93            [ 4]  980 	sub	a, e
   08A4 5F            [ 4]  981 	ld	e,a
   08A5 3E 00         [ 7]  982 	ld	a, #0x00
   08A7 9A            [ 4]  983 	sbc	a, d
   08A8 4F            [ 4]  984 	ld	c,a
   08A9 DD 6E FC      [19]  985 	ld	l,-4 (ix)
   08AC DD 66 FD      [19]  986 	ld	h,-3 (ix)
   08AF 73            [ 7]  987 	ld	(hl),e
   08B0 23            [ 6]  988 	inc	hl
   08B1 71            [ 7]  989 	ld	(hl),c
   08B2                     990 00110$:
   08B2 DD F9         [10]  991 	ld	sp, ix
   08B4 DD E1         [14]  992 	pop	ix
   08B6 C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   08B7                     998 _calcule::
   08B7 DD E5         [15]  999 	push	ix
   08B9 DD 21 00 00   [14] 1000 	ld	ix,#0
   08BD DD 39         [15] 1001 	add	ix,sp
   08BF F5            [11] 1002 	push	af
   08C0 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   08C1 DD 36 FE 00   [19] 1005 	ld	-2 (ix),#0x00
   08C5 DD 36 FF 00   [19] 1006 	ld	-1 (ix),#0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   08C9 DD 36 FD 00   [19] 1008 	ld	-3 (ix),#0x00
   08CD                    1009 00103$:
   08CD DD 7E FD      [19] 1010 	ld	a,-3 (ix)
   08D0 DD 96 04      [19] 1011 	sub	a, 4 (ix)
   08D3 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   08D5 FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   08D9 FD 39         [15] 1015 	add	iy,sp
   08DB DD 6E FD      [19] 1016 	ld	l,-3 (ix)
   08DE 26 00         [ 7] 1017 	ld	h,#0x00
   08E0 29            [11] 1018 	add	hl, hl
   08E1 01 8D 1C      [10] 1019 	ld	bc,#_vRulesx
   08E4 09            [11] 1020 	add	hl,bc
   08E5 4D            [ 4] 1021 	ld	c,l
   08E6 44            [ 4] 1022 	ld	b,h
   08E7 7E            [ 7] 1023 	ld	a, (hl)
   08E8 23            [ 6] 1024 	inc	hl
   08E9 66            [ 7] 1025 	ld	h,(hl)
   08EA 6F            [ 4] 1026 	ld	l,a
   08EB 5E            [ 7] 1027 	ld	e,(hl)
   08EC 23            [ 6] 1028 	inc	hl
   08ED 56            [ 7] 1029 	ld	d,(hl)
   08EE C5            [11] 1030 	push	bc
   08EF FD E5         [15] 1031 	push	iy
   08F1 DD 7E 05      [19] 1032 	ld	a,5 (ix)
   08F4 F5            [11] 1033 	push	af
   08F5 33            [ 6] 1034 	inc	sp
   08F6 D5            [11] 1035 	push	de
   08F7 CD 90 04      [17] 1036 	call	_calculateDom
   08FA F1            [10] 1037 	pop	af
   08FB F1            [10] 1038 	pop	af
   08FC 33            [ 6] 1039 	inc	sp
   08FD C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   08FE DD 5E 06      [19] 1042 	ld	e,6 (ix)
   0901 DD 56 07      [19] 1043 	ld	d,7 (ix)
   0904 69            [ 4] 1044 	ld	l, c
   0905 60            [ 4] 1045 	ld	h, b
   0906 7E            [ 7] 1046 	ld	a, (hl)
   0907 23            [ 6] 1047 	inc	hl
   0908 66            [ 7] 1048 	ld	h,(hl)
   0909 6F            [ 4] 1049 	ld	l,a
   090A 23            [ 6] 1050 	inc	hl
   090B 23            [ 6] 1051 	inc	hl
   090C 7E            [ 7] 1052 	ld	a, (hl)
   090D 23            [ 6] 1053 	inc	hl
   090E 66            [ 7] 1054 	ld	h,(hl)
   090F 6F            [ 4] 1055 	ld	l,a
   0910 23            [ 6] 1056 	inc	hl
   0911 23            [ 6] 1057 	inc	hl
   0912 4E            [ 7] 1058 	ld	c,(hl)
   0913 23            [ 6] 1059 	inc	hl
   0914 46            [ 7] 1060 	ld	b,(hl)
   0915 D5            [11] 1061 	push	de
   0916 DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   0919 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   091C E5            [11] 1064 	push	hl
   091D C5            [11] 1065 	push	bc
   091E CD 40 1B      [17] 1066 	call	__mulint
   0921 F1            [10] 1067 	pop	af
   0922 F1            [10] 1068 	pop	af
   0923 4D            [ 4] 1069 	ld	c,l
   0924 44            [ 4] 1070 	ld	b,h
   0925 D1            [10] 1071 	pop	de
   0926 6B            [ 4] 1072 	ld	l, e
   0927 62            [ 4] 1073 	ld	h, d
   0928 7E            [ 7] 1074 	ld	a, (hl)
   0929 23            [ 6] 1075 	inc	hl
   092A 66            [ 7] 1076 	ld	h,(hl)
   092B 6F            [ 4] 1077 	ld	l,a
   092C 09            [11] 1078 	add	hl,bc
   092D 4C            [ 4] 1079 	ld	c,h
   092E 06 00         [ 7] 1080 	ld	b,#0x00
   0930 79            [ 4] 1081 	ld	a,c
   0931 12            [ 7] 1082 	ld	(de),a
   0932 13            [ 6] 1083 	inc	de
   0933 78            [ 4] 1084 	ld	a,b
   0934 12            [ 7] 1085 	ld	(de),a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   0935 DD 34 FD      [23] 1087 	inc	-3 (ix)
   0938 18 93         [12] 1088 	jr	00103$
   093A                    1089 00105$:
   093A DD F9         [10] 1090 	ld	sp, ix
   093C DD E1         [14] 1091 	pop	ix
   093E C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   093F                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   093F 21 04 00      [10] 1099 	ld	hl, #4
   0942 39            [11] 1100 	add	hl, sp
   0943 4E            [ 7] 1101 	ld	c, (hl)
   0944 23            [ 6] 1102 	inc	hl
   0945 46            [ 7] 1103 	ld	b, (hl)
   0946 59            [ 4] 1104 	ld	e, c
   0947 50            [ 4] 1105 	ld	d, b
   0948 13            [ 6] 1106 	inc	de
   0949 AF            [ 4] 1107 	xor	a, a
   094A 12            [ 7] 1108 	ld	(de),a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   094B AF            [ 4] 1110 	xor	a, a
   094C 02            [ 7] 1111 	ld	(bc),a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   094D 21 03 00      [10] 1113 	ld	hl, #2+1
   0950 39            [11] 1114 	add	hl, sp
   0951 CB 7E         [12] 1115 	bit	7,(hl)
   0953 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   0955 3E 01         [ 7] 1118 	ld	a,#0x01
   0957 02            [ 7] 1119 	ld	(bc),a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   0958 AF            [ 4] 1121 	xor	a, a
   0959 12            [ 7] 1122 	ld	(de),a
   095A C9            [10] 1123 	ret
   095B                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   095B AF            [ 4] 1126 	xor	a, a
   095C FD 21 02 00   [14] 1127 	ld	iy,#2
   0960 FD 39         [15] 1128 	add	iy,sp
   0962 FD BE 00      [19] 1129 	cp	a, 0 (iy)
   0965 FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   0968 E2 6D 09      [10] 1131 	jp	PO, 00116$
   096B EE 80         [ 7] 1132 	xor	a, #0x80
   096D                    1133 00116$:
   096D F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   096E 3E 01         [ 7] 1136 	ld	a,#0x01
   0970 12            [ 7] 1137 	ld	(de),a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   0971 AF            [ 4] 1139 	xor	a, a
   0972 02            [ 7] 1140 	ld	(bc),a
   0973 C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   0974                    1146 _fuzzificacion::
   0974 DD E5         [15] 1147 	push	ix
   0976 DD 21 00 00   [14] 1148 	ld	ix,#0
   097A DD 39         [15] 1149 	add	ix,sp
   097C 21 EE FF      [10] 1150 	ld	hl,#-18
   097F 39            [11] 1151 	add	hl,sp
                           1152 ;src/IA.c:299: ball = &ballX;
   0980 F9            [ 6] 1153 	ld	sp, hl
   0981 23            [ 6] 1154 	inc	hl
   0982 23            [ 6] 1155 	inc	hl
   0983 DD 75 FC      [19] 1156 	ld	-4 (ix),l
   0986 DD 74 FD      [19] 1157 	ld	-3 (ix),h
   0989 4D            [ 4] 1158 	ld	c,l
   098A 44            [ 4] 1159 	ld	b,h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   098B DD 5E 08      [19] 1161 	ld	e,8 (ix)
   098E 16 00         [ 7] 1162 	ld	d,#0x00
   0990 DD 6E 0A      [19] 1163 	ld	l,10 (ix)
   0993 26 00         [ 7] 1164 	ld	h,#0x00
   0995 7B            [ 4] 1165 	ld	a,e
   0996 95            [ 4] 1166 	sub	a, l
   0997 DD 77 FA      [19] 1167 	ld	-6 (ix),a
   099A 7A            [ 4] 1168 	ld	a,d
   099B 9C            [ 4] 1169 	sbc	a, h
   099C DD 77 FB      [19] 1170 	ld	-5 (ix),a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   099F DD 6E 09      [19] 1172 	ld	l,9 (ix)
   09A2 26 00         [ 7] 1173 	ld	h,#0x00
   09A4 DD 5E 0B      [19] 1174 	ld	e,11 (ix)
   09A7 16 00         [ 7] 1175 	ld	d,#0x00
   09A9 7D            [ 4] 1176 	ld	a,l
   09AA 93            [ 4] 1177 	sub	a, e
   09AB DD 77 FE      [19] 1178 	ld	-2 (ix),a
   09AE 7C            [ 4] 1179 	ld	a,h
   09AF 9A            [ 4] 1180 	sbc	a, d
   09B0 DD 77 FF      [19] 1181 	ld	-1 (ix),a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   09B3 3E 6F         [ 7] 1183 	ld	a,#0x6F
   09B5 93            [ 4] 1184 	sub	a, e
   09B6 DD 77 F2      [19] 1185 	ld	-14 (ix),a
   09B9 3E 00         [ 7] 1186 	ld	a,#0x00
   09BB 9A            [ 4] 1187 	sbc	a, d
   09BC DD 77 F3      [19] 1188 	ld	-13 (ix),a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   09BF 59            [ 4] 1190 	ld	e, c
   09C0 50            [ 4] 1191 	ld	d, b
   09C1 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   09C2 3E FE         [ 7] 1194 	ld	a,#0xFE
   09C4 DD BE FA      [19] 1195 	cp	a, -6 (ix)
   09C7 3E FF         [ 7] 1196 	ld	a,#0xFF
   09C9 DD 9E FB      [19] 1197 	sbc	a, -5 (ix)
   09CC E2 D1 09      [10] 1198 	jp	PO, 00148$
   09CF EE 80         [ 7] 1199 	xor	a, #0x80
   09D1                    1200 00148$:
   09D1 FA DB 09      [10] 1201 	jp	M,00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   09D4 3E 01         [ 7] 1203 	ld	a,#0x01
   09D6 02            [ 7] 1204 	ld	(bc),a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   09D7 AF            [ 4] 1206 	xor	a, a
   09D8 12            [ 7] 1207 	ld	(de),a
   09D9 18 05         [12] 1208 	jr	00103$
   09DB                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   09DB 3E 01         [ 7] 1211 	ld	a,#0x01
   09DD 12            [ 7] 1212 	ld	(de),a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   09DE AF            [ 4] 1214 	xor	a, a
   09DF 02            [ 7] 1215 	ld	(bc),a
   09E0                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   09E0 AF            [ 4] 1218 	xor	a, a
   09E1 DD BE FA      [19] 1219 	cp	a, -6 (ix)
   09E4 DD 9E FB      [19] 1220 	sbc	a, -5 (ix)
   09E7 E2 EC 09      [10] 1221 	jp	PO, 00149$
   09EA EE 80         [ 7] 1222 	xor	a, #0x80
   09EC                    1223 00149$:
   09EC 07            [ 4] 1224 	rlca
   09ED E6 01         [ 7] 1225 	and	a,#0x01
   09EF 4F            [ 4] 1226 	ld	c,a
   09F0 DD 7E F2      [19] 1227 	ld	a,-14 (ix)
   09F3 DD 96 FE      [19] 1228 	sub	a, -2 (ix)
   09F6 DD 7E F3      [19] 1229 	ld	a,-13 (ix)
   09F9 DD 9E FF      [19] 1230 	sbc	a, -1 (ix)
   09FC E2 01 0A      [10] 1231 	jp	PO, 00150$
   09FF EE 80         [ 7] 1232 	xor	a, #0x80
   0A01                    1233 00150$:
   0A01 F2 1B 0A      [10] 1234 	jp	P,00109$
   0A04 79            [ 4] 1235 	ld	a,c
   0A05 B7            [ 4] 1236 	or	a, a
   0A06 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   0A08 21 00 00      [10] 1239 	ld	hl,#0x0000
   0A0B 39            [11] 1240 	add	hl,sp
   0A0C E5            [11] 1241 	push	hl
   0A0D DD 6E F2      [19] 1242 	ld	l,-14 (ix)
   0A10 DD 66 F3      [19] 1243 	ld	h,-13 (ix)
   0A13 E5            [11] 1244 	push	hl
   0A14 CD 3F 09      [17] 1245 	call	_calcularb_direc
   0A17 F1            [10] 1246 	pop	af
   0A18 F1            [10] 1247 	pop	af
   0A19 18 3C         [12] 1248 	jr	00110$
   0A1B                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   0A1B DD 7E FE      [19] 1251 	ld	a,-2 (ix)
   0A1E DD 96 F2      [19] 1252 	sub	a, -14 (ix)
   0A21 DD 7E FF      [19] 1253 	ld	a,-1 (ix)
   0A24 DD 9E F3      [19] 1254 	sbc	a, -13 (ix)
   0A27 E2 2C 0A      [10] 1255 	jp	PO, 00151$
   0A2A EE 80         [ 7] 1256 	xor	a, #0x80
   0A2C                    1257 00151$:
   0A2C F2 46 0A      [10] 1258 	jp	P,00105$
   0A2F 79            [ 4] 1259 	ld	a,c
   0A30 B7            [ 4] 1260 	or	a, a
   0A31 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   0A33 21 00 00      [10] 1263 	ld	hl,#0x0000
   0A36 39            [11] 1264 	add	hl,sp
   0A37 E5            [11] 1265 	push	hl
   0A38 DD 6E F2      [19] 1266 	ld	l,-14 (ix)
   0A3B DD 66 F3      [19] 1267 	ld	h,-13 (ix)
   0A3E E5            [11] 1268 	push	hl
   0A3F CD 3F 09      [17] 1269 	call	_calcularb_direc
   0A42 F1            [10] 1270 	pop	af
   0A43 F1            [10] 1271 	pop	af
   0A44 18 11         [12] 1272 	jr	00110$
   0A46                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   0A46 21 00 00      [10] 1275 	ld	hl,#0x0000
   0A49 39            [11] 1276 	add	hl,sp
   0A4A E5            [11] 1277 	push	hl
   0A4B DD 6E FE      [19] 1278 	ld	l,-2 (ix)
   0A4E DD 66 FF      [19] 1279 	ld	h,-1 (ix)
   0A51 E5            [11] 1280 	push	hl
   0A52 CD 3F 09      [17] 1281 	call	_calcularb_direc
   0A55 F1            [10] 1282 	pop	af
   0A56 F1            [10] 1283 	pop	af
   0A57                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   0A57 DD 4E FA      [19] 1286 	ld	c,-6 (ix)
   0A5A DD 71 F5      [19] 1287 	ld	-11 (ix),c
   0A5D DD 36 F4 00   [19] 1288 	ld	-12 (ix),#0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   0A61 DD 46 FE      [19] 1290 	ld	b,-2 (ix)
   0A64 0E 00         [ 7] 1291 	ld	c,#0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   0A66 21 08 00      [10] 1293 	ld	hl,#0x0008
   0A69 39            [11] 1294 	add	hl,sp
   0A6A DD 56 F4      [19] 1295 	ld	d,-12 (ix)
   0A6D C5            [11] 1296 	push	bc
   0A6E E5            [11] 1297 	push	hl
   0A6F 1E 03         [ 7] 1298 	ld	e, #0x03
   0A71 D5            [11] 1299 	push	de
   0A72 CD B7 08      [17] 1300 	call	_calcule
   0A75 F1            [10] 1301 	pop	af
   0A76 F1            [10] 1302 	pop	af
   0A77 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   0A78 21 0A 00      [10] 1305 	ld	hl,#0x000A
   0A7B 39            [11] 1306 	add	hl,sp
   0A7C 51            [ 4] 1307 	ld	d,c
   0A7D C5            [11] 1308 	push	bc
   0A7E E5            [11] 1309 	push	hl
   0A7F 1E 03         [ 7] 1310 	ld	e, #0x03
   0A81 D5            [11] 1311 	push	de
   0A82 CD B7 08      [17] 1312 	call	_calcule
   0A85 F1            [10] 1313 	pop	af
   0A86 F1            [10] 1314 	pop	af
   0A87 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   0A88 78            [ 4] 1317 	ld	a,b
   0A89 B1            [ 4] 1318 	or	a,c
   0A8A 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   0A8C DD 4E FC      [19] 1321 	ld	c,-4 (ix)
   0A8F DD 46 FD      [19] 1322 	ld	b,-3 (ix)
   0A92 DD 6E 04      [19] 1323 	ld	l,4 (ix)
   0A95 DD 66 05      [19] 1324 	ld	h,5 (ix)
   0A98 E5            [11] 1325 	push	hl
   0A99 C5            [11] 1326 	push	bc
   0A9A DD 6E F6      [19] 1327 	ld	l,-10 (ix)
   0A9D DD 66 F7      [19] 1328 	ld	h,-9 (ix)
   0AA0 E5            [11] 1329 	push	hl
   0AA1 CD B6 07      [17] 1330 	call	_defuzzi
   0AA4 21 06 00      [10] 1331 	ld	hl,#6
   0AA7 39            [11] 1332 	add	hl,sp
   0AA8 F9            [ 6] 1333 	ld	sp,hl
                           1334 ;src/IA.c:336: ax = 0;
   0AA9                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   0AA9 DD 7E F5      [19] 1337 	ld	a,-11 (ix)
   0AAC DD B6 F4      [19] 1338 	or	a,-12 (ix)
   0AAF 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   0AB1 21 00 00      [10] 1341 	ld	hl,#0x0000
   0AB4 39            [11] 1342 	add	hl,sp
   0AB5 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   0AB8 DD 46 07      [19] 1344 	ld	b,7 (ix)
   0ABB C5            [11] 1345 	push	bc
   0ABC E5            [11] 1346 	push	hl
   0ABD DD 6E F8      [19] 1347 	ld	l,-8 (ix)
   0AC0 DD 66 F9      [19] 1348 	ld	h,-7 (ix)
   0AC3 E5            [11] 1349 	push	hl
   0AC4 CD B6 07      [17] 1350 	call	_defuzzi
   0AC7 21 06 00      [10] 1351 	ld	hl,#6
   0ACA 39            [11] 1352 	add	hl,sp
   0ACB F9            [ 6] 1353 	ld	sp,hl
                           1354 ;src/IA.c:341: ay = 0;
   0ACC                    1355 00118$:
   0ACC DD F9         [10] 1356 	ld	sp, ix
   0ACE DD E1         [14] 1357 	pop	ix
   0AD0 C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   0AD1                    1363 _moveIA::
   0AD1 DD E5         [15] 1364 	push	ix
   0AD3 DD 21 00 00   [14] 1365 	ld	ix,#0
   0AD7 DD 39         [15] 1366 	add	ix,sp
   0AD9 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   0ADA DD 7E 04      [19] 1369 	ld	a,4 (ix)
   0ADD DD 77 FE      [19] 1370 	ld	-2 (ix),a
   0AE0 DD 7E 05      [19] 1371 	ld	a,5 (ix)
   0AE3 DD 77 FF      [19] 1372 	ld	-1 (ix),a
   0AE6 E1            [10] 1373 	pop	hl
   0AE7 E5            [11] 1374 	push	hl
   0AE8 23            [ 6] 1375 	inc	hl
   0AE9 23            [ 6] 1376 	inc	hl
   0AEA 4E            [ 7] 1377 	ld	c,(hl)
   0AEB 23            [ 6] 1378 	inc	hl
   0AEC 46            [ 7] 1379 	ld	b,(hl)
   0AED DD 6E 08      [19] 1380 	ld	l,8 (ix)
   0AF0 DD 66 09      [19] 1381 	ld	h,9 (ix)
   0AF3 23            [ 6] 1382 	inc	hl
   0AF4 23            [ 6] 1383 	inc	hl
   0AF5 5E            [ 7] 1384 	ld	e,(hl)
   0AF6 23            [ 6] 1385 	inc	hl
   0AF7 56            [ 7] 1386 	ld	d,(hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   0AF8 DD 7E FE      [19] 1388 	ld	a,-2 (ix)
   0AFB C6 0C         [ 7] 1389 	add	a, #0x0C
   0AFD 6F            [ 4] 1390 	ld	l,a
   0AFE DD 7E FF      [19] 1391 	ld	a,-1 (ix)
   0B01 CE 00         [ 7] 1392 	adc	a, #0x00
   0B03 67            [ 4] 1393 	ld	h,a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   0B04 7B            [ 4] 1395 	ld	a,e
   0B05 91            [ 4] 1396 	sub	a, c
   0B06 7A            [ 4] 1397 	ld	a,d
   0B07 98            [ 4] 1398 	sbc	a, b
   0B08 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   0B0A 36 E0         [10] 1401 	ld	(hl),#0xE0
   0B0C 23            [ 6] 1402 	inc	hl
   0B0D 36 FF         [10] 1403 	ld	(hl),#0xFF
   0B0F 18 0B         [12] 1404 	jr	00106$
   0B11                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   0B11 79            [ 4] 1407 	ld	a,c
   0B12 93            [ 4] 1408 	sub	a, e
   0B13 78            [ 4] 1409 	ld	a,b
   0B14 9A            [ 4] 1410 	sbc	a, d
   0B15 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   0B17 36 20         [10] 1413 	ld	(hl),#0x20
   0B19 23            [ 6] 1414 	inc	hl
   0B1A 36 00         [10] 1415 	ld	(hl),#0x00
   0B1C                    1416 00106$:
   0B1C DD F9         [10] 1417 	ld	sp, ix
   0B1E DD E1         [14] 1418 	pop	ix
   0B20 C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   1C9F                    1422 __xinit__vRulesx:
   1C9F 78 04              1423 	.dw _rulex
   1CA1 7C 04              1424 	.dw _rulex1
   1CA3 80 04              1425 	.dw _rulex2
   1CA5                    1426 __xinit__vRulesy:
   1CA5 84 04              1427 	.dw _ruley
   1CA7 88 04              1428 	.dw _ruley1
   1CA9 8C 04              1429 	.dw _ruley2
   1CAB                    1430 __xinit__fmems:
   1CAB 62 04              1431 	.dw _acelPo
   1CAD 6D 04              1432 	.dw _acelMed
   1CAF 57 04              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
