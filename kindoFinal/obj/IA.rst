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
   68E4                      41 _aceleracion::
   68E4                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   68EA                      47 _vRulesx::
   68EA                      48 	.ds 6
   68F0                      49 _vRulesy::
   68F0                      50 	.ds 6
   68F6                      51 _fmems::
   68F6                      52 	.ds 6
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
   42F9                      77 _initAcel::
   42F9 DD E5         [15]   78 	push	ix
   42FB DD 21 00 00   [14]   79 	ld	ix,#0
   42FF DD 39         [15]   80 	add	ix,sp
   4301 21 F8 FF      [10]   81 	ld	hl,#-8
   4304 39            [11]   82 	add	hl,sp
   4305 F9            [ 6]   83 	ld	sp,hl
                             84 ;src/IA.c:129: u8 i = 0;
   4306 1E 00         [ 7]   85 	ld	e,#0x00
                             86 ;src/IA.c:130: switch(nivel){
   4308 DD 7E 04      [19]   87 	ld	a,4 (ix)
   430B B7            [ 4]   88 	or	a, a
   430C 28 09         [12]   89 	jr	Z,00101$
   430E DD 7E 04      [19]   90 	ld	a,4 (ix)
   4311 3D            [ 4]   91 	dec	a
   4312 28 5F         [12]   92 	jr	Z,00105$
   4314 C3 CD 43      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   4317                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   4317 21 00 00      [10]   97 	ld	hl,#0x0000
   431A 39            [11]   98 	add	hl,sp
   431B DD 75 FE      [19]   99 	ld	-2 (ix),l
   431E DD 74 FF      [19]  100 	ld	-1 (ix),h
   4321 DD 6E FE      [19]  101 	ld	l,-2 (ix)
   4324 DD 66 FF      [19]  102 	ld	h,-1 (ix)
   4327 36 0F         [10]  103 	ld	(hl),#0x0F
   4329 23            [ 6]  104 	inc	hl
   432A 36 00         [10]  105 	ld	(hl),#0x00
   432C DD 6E FE      [19]  106 	ld	l,-2 (ix)
   432F DD 66 FF      [19]  107 	ld	h,-1 (ix)
   4332 23            [ 6]  108 	inc	hl
   4333 23            [ 6]  109 	inc	hl
   4334 36 14         [10]  110 	ld	(hl),#0x14
   4336 23            [ 6]  111 	inc	hl
   4337 36 00         [10]  112 	ld	(hl),#0x00
   4339 DD 7E FE      [19]  113 	ld	a,-2 (ix)
   433C C6 04         [ 7]  114 	add	a, #0x04
   433E 6F            [ 4]  115 	ld	l,a
   433F DD 7E FF      [19]  116 	ld	a,-1 (ix)
   4342 CE 00         [ 7]  117 	adc	a, #0x00
   4344 67            [ 4]  118 	ld	h,a
   4345 36 17         [10]  119 	ld	(hl),#0x17
   4347 23            [ 6]  120 	inc	hl
   4348 36 00         [10]  121 	ld	(hl),#0x00
                            122 ;src/IA.c:133: while(i<3)
   434A 01 E4 68      [10]  123 	ld	bc,#_aceleracion+0
   434D 1E 00         [ 7]  124 	ld	e,#0x00
   434F                     125 00102$:
   434F 7B            [ 4]  126 	ld	a,e
   4350 D6 03         [ 7]  127 	sub	a, #0x03
   4352 30 1F         [12]  128 	jr	NC,00124$
                            129 ;src/IA.c:135: aceleracion[i] = aux[i];
   4354 6B            [ 4]  130 	ld	l,e
   4355 26 00         [ 7]  131 	ld	h,#0x00
   4357 29            [11]  132 	add	hl, hl
   4358 E5            [11]  133 	push	hl
   4359 FD E1         [14]  134 	pop	iy
   435B FD 09         [15]  135 	add	iy, bc
   435D DD 7E FE      [19]  136 	ld	a,-2 (ix)
   4360 85            [ 4]  137 	add	a, l
   4361 6F            [ 4]  138 	ld	l,a
   4362 DD 7E FF      [19]  139 	ld	a,-1 (ix)
   4365 8C            [ 4]  140 	adc	a, h
   4366 67            [ 4]  141 	ld	h,a
   4367 7E            [ 7]  142 	ld	a, (hl)
   4368 23            [ 6]  143 	inc	hl
   4369 56            [ 7]  144 	ld	d,(hl)
   436A FD 77 00      [19]  145 	ld	0 (iy), a
   436D FD 72 01      [19]  146 	ld	1 (iy),d
                            147 ;src/IA.c:136: i++;
   4370 1C            [ 4]  148 	inc	e
   4371 18 DC         [12]  149 	jr	00102$
                            150 ;src/IA.c:139: case 1:{
   4373                     151 00124$:
   4373                     152 00105$:
                            153 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   4373 21 00 00      [10]  154 	ld	hl,#0x0000
   4376 39            [11]  155 	add	hl,sp
   4377 DD 75 FE      [19]  156 	ld	-2 (ix),l
   437A DD 74 FF      [19]  157 	ld	-1 (ix),h
   437D DD 6E FE      [19]  158 	ld	l,-2 (ix)
   4380 DD 66 FF      [19]  159 	ld	h,-1 (ix)
   4383 36 17         [10]  160 	ld	(hl),#0x17
   4385 23            [ 6]  161 	inc	hl
   4386 36 00         [10]  162 	ld	(hl),#0x00
   4388 DD 6E FE      [19]  163 	ld	l,-2 (ix)
   438B DD 66 FF      [19]  164 	ld	h,-1 (ix)
   438E 23            [ 6]  165 	inc	hl
   438F 23            [ 6]  166 	inc	hl
   4390 36 19         [10]  167 	ld	(hl),#0x19
   4392 23            [ 6]  168 	inc	hl
   4393 36 00         [10]  169 	ld	(hl),#0x00
   4395 DD 7E FE      [19]  170 	ld	a,-2 (ix)
   4398 C6 04         [ 7]  171 	add	a, #0x04
   439A 6F            [ 4]  172 	ld	l,a
   439B DD 7E FF      [19]  173 	ld	a,-1 (ix)
   439E CE 00         [ 7]  174 	adc	a, #0x00
   43A0 67            [ 4]  175 	ld	h,a
   43A1 36 33         [10]  176 	ld	(hl),#0x33
   43A3 23            [ 6]  177 	inc	hl
   43A4 36 00         [10]  178 	ld	(hl),#0x00
                            179 ;src/IA.c:141: while(i<3)
   43A6 01 E4 68      [10]  180 	ld	bc,#_aceleracion+0
   43A9                     181 00106$:
   43A9 7B            [ 4]  182 	ld	a,e
   43AA D6 03         [ 7]  183 	sub	a, #0x03
   43AC 30 1F         [12]  184 	jr	NC,00125$
                            185 ;src/IA.c:143: aceleracion[i] = aux[i];
   43AE 6B            [ 4]  186 	ld	l,e
   43AF 26 00         [ 7]  187 	ld	h,#0x00
   43B1 29            [11]  188 	add	hl, hl
   43B2 E5            [11]  189 	push	hl
   43B3 FD E1         [14]  190 	pop	iy
   43B5 FD 09         [15]  191 	add	iy, bc
   43B7 DD 7E FE      [19]  192 	ld	a,-2 (ix)
   43BA 85            [ 4]  193 	add	a, l
   43BB 6F            [ 4]  194 	ld	l,a
   43BC DD 7E FF      [19]  195 	ld	a,-1 (ix)
   43BF 8C            [ 4]  196 	adc	a, h
   43C0 67            [ 4]  197 	ld	h,a
   43C1 7E            [ 7]  198 	ld	a, (hl)
   43C2 23            [ 6]  199 	inc	hl
   43C3 56            [ 7]  200 	ld	d,(hl)
   43C4 FD 77 00      [19]  201 	ld	0 (iy), a
   43C7 FD 72 01      [19]  202 	ld	1 (iy),d
                            203 ;src/IA.c:144: i++;
   43CA 1C            [ 4]  204 	inc	e
   43CB 18 DC         [12]  205 	jr	00106$
                            206 ;src/IA.c:147: default:{
   43CD                     207 00125$:
   43CD                     208 00109$:
                            209 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   43CD 21 00 00      [10]  210 	ld	hl,#0x0000
   43D0 39            [11]  211 	add	hl,sp
   43D1 4D            [ 4]  212 	ld	c,l
   43D2 44            [ 4]  213 	ld	b,h
   43D3 36 19         [10]  214 	ld	(hl),#0x19
   43D5 23            [ 6]  215 	inc	hl
   43D6 36 00         [10]  216 	ld	(hl),#0x00
   43D8 69            [ 4]  217 	ld	l, c
   43D9 60            [ 4]  218 	ld	h, b
   43DA 23            [ 6]  219 	inc	hl
   43DB 23            [ 6]  220 	inc	hl
   43DC 36 33         [10]  221 	ld	(hl),#0x33
   43DE 23            [ 6]  222 	inc	hl
   43DF 36 00         [10]  223 	ld	(hl),#0x00
   43E1 21 04 00      [10]  224 	ld	hl,#0x0004
   43E4 09            [11]  225 	add	hl,bc
   43E5 36 4C         [10]  226 	ld	(hl),#0x4C
   43E7 23            [ 6]  227 	inc	hl
   43E8 36 00         [10]  228 	ld	(hl),#0x00
                            229 ;src/IA.c:149: while(i<3)
   43EA                     230 00110$:
   43EA 7B            [ 4]  231 	ld	a,e
   43EB D6 03         [ 7]  232 	sub	a, #0x03
   43ED 30 1B         [12]  233 	jr	NC,00114$
                            234 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   43EF 6B            [ 4]  235 	ld	l,e
   43F0 26 00         [ 7]  236 	ld	h,#0x00
   43F2 29            [11]  237 	add	hl, hl
   43F3 FD 21 E4 68   [14]  238 	ld	iy,#_aceleracion
   43F7 C5            [11]  239 	push	bc
   43F8 4D            [ 4]  240 	ld	c, l
   43F9 44            [ 4]  241 	ld	b, h
   43FA FD 09         [15]  242 	add	iy, bc
   43FC C1            [10]  243 	pop	bc
   43FD 09            [11]  244 	add	hl,bc
   43FE 7E            [ 7]  245 	ld	a, (hl)
   43FF 23            [ 6]  246 	inc	hl
   4400 66            [ 7]  247 	ld	h,(hl)
   4401 FD 77 00      [19]  248 	ld	0 (iy), a
   4404 FD 74 01      [19]  249 	ld	1 (iy),h
                            250 ;src/IA.c:152: i++;
   4407 1C            [ 4]  251 	inc	e
   4408 18 E0         [12]  252 	jr	00110$
                            253 ;src/IA.c:155: }
   440A                     254 00114$:
   440A DD F9         [10]  255 	ld	sp, ix
   440C DD E1         [14]  256 	pop	ix
   440E C9            [10]  257 	ret
   440F                     258 _cerca:
   440F 00 00               259 	.dw #0x0000
   4411 00 05               260 	.dw #0x0500
   4413 01                  261 	.db #0x01	; 1
   4414 00 0A               262 	.dw #0x0A00
   4416 00 0A               263 	.dw #0x0A00
   4418 00 0A               264 	.dw #0x0A00
   441A                     265 _medio:
   441A 00 00               266 	.dw #0x0000
   441C 00 14               267 	.dw #0x1400
   441E 00                  268 	.db #0x00	; 0
   441F 00 14               269 	.dw #0x1400
   4421 00 0A               270 	.dw #0x0A00
   4423 00 0F               271 	.dw #0x0F00
   4425                     272 _lejos:
   4425 00 00               273 	.dw #0x0000
   4427 00 6E               274 	.dw #0x6E00
   4429 02                  275 	.db #0x02	; 2
   442A 00 3C               276 	.dw #0x3C00
   442C 00 19               277 	.dw #0x1900
   442E 00 64               278 	.dw #0x6400
   4430                     279 _acelMu:
   4430 00 00               280 	.dw #0x0000
   4432 80 57               281 	.dw #0x5780
   4434 02                  282 	.db #0x02	; 2
   4435 00 4B               283 	.dw #0x4B00
   4437 00 19               284 	.dw #0x1900
   4439 00 19               285 	.dw #0x1900
   443B                     286 _acelPo:
   443B 00 00               287 	.dw #0x0000
   443D 80 0C               288 	.dw #0x0C80
   443F 01                  289 	.db #0x01	; 1
   4440 00 19               290 	.dw #0x1900
   4442 00 19               291 	.dw #0x1900
   4444 00 19               292 	.dw #0x1900
   4446                     293 _acelMed:
   4446 00 00               294 	.dw #0x0000
   4448 00 32               295 	.dw #0x3200
   444A 00                  296 	.db #0x00	; 0
   444B 00 32               297 	.dw #0x3200
   444D 00 19               298 	.dw #0x1900
   444F 00 19               299 	.dw #0x1900
   4451                     300 _rulex:
   4451 0F 44               301 	.dw _cerca
   4453 30 44               302 	.dw _acelMu
   4455                     303 _rulex1:
   4455 1A 44               304 	.dw _medio
   4457 46 44               305 	.dw _acelMed
   4459                     306 _rulex2:
   4459 25 44               307 	.dw _lejos
   445B 3B 44               308 	.dw _acelPo
   445D                     309 _ruley:
   445D 0F 44               310 	.dw _cerca
   445F 30 44               311 	.dw _acelMu
   4461                     312 _ruley1:
   4461 1A 44               313 	.dw _medio
   4463 46 44               314 	.dw _acelMed
   4465                     315 _ruley2:
   4465 25 44               316 	.dw _lejos
   4467 3B 44               317 	.dw _acelPo
                            318 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            319 ;	---------------------------------
                            320 ; Function calculateDom
                            321 ; ---------------------------------
   4469                     322 _calculateDom::
   4469 DD E5         [15]  323 	push	ix
   446B DD 21 00 00   [14]  324 	ld	ix,#0
   446F DD 39         [15]  325 	add	ix,sp
   4471 21 ED FF      [10]  326 	ld	hl,#-19
   4474 39            [11]  327 	add	hl,sp
   4475 F9            [ 6]  328 	ld	sp,hl
                            329 ;src/IA.c:161: *grad = 0.0;
   4476 DD 5E 07      [19]  330 	ld	e,7 (ix)
   4479 DD 56 08      [19]  331 	ld	d,8 (ix)
   447C 6B            [ 4]  332 	ld	l, e
   447D 62            [ 4]  333 	ld	h, d
   447E AF            [ 4]  334 	xor	a, a
   447F 77            [ 7]  335 	ld	(hl), a
   4480 23            [ 6]  336 	inc	hl
   4481 77            [ 7]  337 	ld	(hl), a
                            338 ;src/IA.c:162: if(c->tipo == 0){
   4482 DD 7E 04      [19]  339 	ld	a,4 (ix)
   4485 DD 77 F3      [19]  340 	ld	-13 (ix),a
   4488 DD 7E 05      [19]  341 	ld	a,5 (ix)
   448B DD 77 F4      [19]  342 	ld	-12 (ix),a
   448E DD 6E F3      [19]  343 	ld	l,-13 (ix)
   4491 DD 66 F4      [19]  344 	ld	h,-12 (ix)
   4494 01 04 00      [10]  345 	ld	bc, #0x0004
   4497 09            [11]  346 	add	hl, bc
   4498 4E            [ 7]  347 	ld	c,(hl)
                            348 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   4499 DD 7E F3      [19]  349 	ld	a,-13 (ix)
   449C C6 09         [ 7]  350 	add	a, #0x09
   449E DD 77 EF      [19]  351 	ld	-17 (ix),a
   44A1 DD 7E F4      [19]  352 	ld	a,-12 (ix)
   44A4 CE 00         [ 7]  353 	adc	a, #0x00
   44A6 DD 77 F0      [19]  354 	ld	-16 (ix),a
   44A9 DD 7E F3      [19]  355 	ld	a,-13 (ix)
   44AC C6 05         [ 7]  356 	add	a, #0x05
   44AE DD 77 ED      [19]  357 	ld	-19 (ix),a
   44B1 DD 7E F4      [19]  358 	ld	a,-12 (ix)
   44B4 CE 00         [ 7]  359 	adc	a, #0x00
   44B6 DD 77 EE      [19]  360 	ld	-18 (ix),a
   44B9 DD 7E 06      [19]  361 	ld	a,6 (ix)
   44BC DD 77 F1      [19]  362 	ld	-15 (ix),a
   44BF DD 36 F2 00   [19]  363 	ld	-14 (ix),#0x00
                            364 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   44C3 DD 7E F3      [19]  365 	ld	a,-13 (ix)
   44C6 C6 07         [ 7]  366 	add	a, #0x07
   44C8 DD 77 F3      [19]  367 	ld	-13 (ix),a
   44CB DD 7E F4      [19]  368 	ld	a,-12 (ix)
   44CE CE 00         [ 7]  369 	adc	a, #0x00
   44D0 DD 77 F4      [19]  370 	ld	-12 (ix),a
                            371 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   44D3 E1            [10]  372 	pop	hl
   44D4 E5            [11]  373 	push	hl
   44D5 7E            [ 7]  374 	ld	a,(hl)
   44D6 DD 77 F5      [19]  375 	ld	-11 (ix),a
   44D9 23            [ 6]  376 	inc	hl
   44DA 7E            [ 7]  377 	ld	a,(hl)
   44DB DD 77 F6      [19]  378 	ld	-10 (ix),a
                            379 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   44DE DD 7E 06      [19]  380 	ld	a,6 (ix)
   44E1 DD 77 FA      [19]  381 	ld	-6 (ix),a
   44E4 DD 36 FB 00   [19]  382 	ld	-5 (ix),#0x00
                            383 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   44E8 DD 6E EF      [19]  384 	ld	l,-17 (ix)
   44EB DD 66 F0      [19]  385 	ld	h,-16 (ix)
   44EE 7E            [ 7]  386 	ld	a,(hl)
   44EF DD 77 FE      [19]  387 	ld	-2 (ix),a
   44F2 23            [ 6]  388 	inc	hl
   44F3 7E            [ 7]  389 	ld	a,(hl)
   44F4 DD 77 FF      [19]  390 	ld	-1 (ix),a
                            391 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            392 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   44F7 AF            [ 4]  393 	xor	a, a
   44F8 DD 96 FE      [19]  394 	sub	a, -2 (ix)
   44FB 6F            [ 4]  395 	ld	l,a
   44FC 3E 00         [ 7]  396 	ld	a, #0x00
   44FE DD 9E FF      [19]  397 	sbc	a, -1 (ix)
   4501 67            [ 4]  398 	ld	h,a
   4502 C5            [11]  399 	push	bc
   4503 D5            [11]  400 	push	de
   4504 E5            [11]  401 	push	hl
   4505 21 00 01      [10]  402 	ld	hl,#0x0100
   4508 E5            [11]  403 	push	hl
                            404 ;src/IA.c:162: if(c->tipo == 0){
   4509 CD 50 5D      [17]  405 	call	__divuint
   450C F1            [10]  406 	pop	af
   450D F1            [10]  407 	pop	af
   450E DD 74 F9      [19]  408 	ld	-7 (ix),h
   4511 DD 75 F8      [19]  409 	ld	-8 (ix),l
   4514 D1            [10]  410 	pop	de
   4515 C1            [10]  411 	pop	bc
   4516 79            [ 4]  412 	ld	a,c
   4517 B7            [ 4]  413 	or	a, a
   4518 C2 34 46      [10]  414 	jp	NZ,00138$
                            415 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   451B DD 7E F1      [19]  416 	ld	a,-15 (ix)
   451E DD 96 F5      [19]  417 	sub	a, -11 (ix)
   4521 20 0C         [12]  418 	jr	NZ,00214$
   4523 DD 7E F2      [19]  419 	ld	a,-14 (ix)
   4526 DD 96 F6      [19]  420 	sub	a, -10 (ix)
   4529 20 04         [12]  421 	jr	NZ,00214$
   452B 3E 01         [ 7]  422 	ld	a,#0x01
   452D 18 01         [12]  423 	jr	00215$
   452F                     424 00214$:
   452F AF            [ 4]  425 	xor	a,a
   4530                     426 00215$:
   4530 47            [ 4]  427 	ld	b,a
   4531 DD 7E FF      [19]  428 	ld	a,-1 (ix)
   4534 DD B6 FE      [19]  429 	or	a,-2 (ix)
   4537 20 04         [12]  430 	jr	NZ,00105$
   4539 78            [ 4]  431 	ld	a,b
   453A B7            [ 4]  432 	or	a, a
   453B 20 10         [12]  433 	jr	NZ,00101$
   453D                     434 00105$:
                            435 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   453D DD 6E F3      [19]  436 	ld	l,-13 (ix)
   4540 DD 66 F4      [19]  437 	ld	h,-12 (ix)
   4543 4E            [ 7]  438 	ld	c,(hl)
   4544 23            [ 6]  439 	inc	hl
   4545 66            [ 7]  440 	ld	h,(hl)
   4546 7C            [ 4]  441 	ld	a,h
   4547 B1            [ 4]  442 	or	a,c
   4548 20 0D         [12]  443 	jr	NZ,00102$
   454A B0            [ 4]  444 	or	a,b
   454B 28 0A         [12]  445 	jr	Z,00102$
   454D                     446 00101$:
                            447 ;src/IA.c:167: *grad = SCALA;
   454D 3E 00         [ 7]  448 	ld	a,#0x00
   454F 12            [ 7]  449 	ld	(de),a
   4550 13            [ 6]  450 	inc	de
   4551 3E 01         [ 7]  451 	ld	a,#0x01
   4553 12            [ 7]  452 	ld	(de),a
                            453 ;src/IA.c:168: return;
   4554 C3 7E 47      [10]  454 	jp	00140$
   4557                     455 00102$:
                            456 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   4557 DD 7E F5      [19]  457 	ld	a,-11 (ix)
   455A DD 96 F1      [19]  458 	sub	a, -15 (ix)
   455D DD 7E F6      [19]  459 	ld	a,-10 (ix)
   4560 DD 9E F2      [19]  460 	sbc	a, -14 (ix)
   4563 3E 00         [ 7]  461 	ld	a,#0x00
   4565 17            [ 4]  462 	rla
   4566 DD 77 F7      [19]  463 	ld	-9 (ix),a
   4569 DD CB F7 46   [20]  464 	bit	0,-9 (ix)
   456D 20 64         [12]  465 	jr	NZ,00111$
   456F DD 7E F5      [19]  466 	ld	a,-11 (ix)
   4572 91            [ 4]  467 	sub	a, c
   4573 47            [ 4]  468 	ld	b,a
   4574 DD 7E F6      [19]  469 	ld	a,-10 (ix)
   4577 9C            [ 4]  470 	sbc	a, h
   4578 6F            [ 4]  471 	ld	l,a
   4579 DD 7E F1      [19]  472 	ld	a,-15 (ix)
   457C 90            [ 4]  473 	sub	a, b
   457D DD 7E F2      [19]  474 	ld	a,-14 (ix)
   4580 9D            [ 4]  475 	sbc	a, l
   4581 38 50         [12]  476 	jr	C,00111$
                            477 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   4583 D5            [11]  478 	push	de
   4584 69            [ 4]  479 	ld	l, c
   4585 E5            [11]  480 	push	hl
   4586 21 00 01      [10]  481 	ld	hl,#0x0100
   4589 E5            [11]  482 	push	hl
   458A CD 50 5D      [17]  483 	call	__divuint
   458D F1            [10]  484 	pop	af
   458E F1            [10]  485 	pop	af
   458F 4D            [ 4]  486 	ld	c,l
   4590 44            [ 4]  487 	ld	b,h
   4591 D1            [10]  488 	pop	de
   4592 6B            [ 4]  489 	ld	l, e
   4593 62            [ 4]  490 	ld	h, d
   4594 71            [ 7]  491 	ld	(hl),c
   4595 23            [ 6]  492 	inc	hl
   4596 70            [ 7]  493 	ld	(hl),b
                            494 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   4597 E1            [10]  495 	pop	hl
   4598 E5            [11]  496 	push	hl
   4599 7E            [ 7]  497 	ld	a,(hl)
   459A DD 77 FC      [19]  498 	ld	-4 (ix),a
   459D 23            [ 6]  499 	inc	hl
   459E 7E            [ 7]  500 	ld	a,(hl)
   459F DD 77 FD      [19]  501 	ld	-3 (ix),a
   45A2 DD 6E F3      [19]  502 	ld	l,-13 (ix)
   45A5 DD 66 F4      [19]  503 	ld	h,-12 (ix)
   45A8 7E            [ 7]  504 	ld	a, (hl)
   45A9 23            [ 6]  505 	inc	hl
   45AA 66            [ 7]  506 	ld	h,(hl)
   45AB 6F            [ 4]  507 	ld	l,a
   45AC DD 7E FC      [19]  508 	ld	a,-4 (ix)
   45AF 95            [ 4]  509 	sub	a, l
   45B0 6F            [ 4]  510 	ld	l,a
   45B1 DD 7E FD      [19]  511 	ld	a,-3 (ix)
   45B4 9C            [ 4]  512 	sbc	a, h
   45B5 67            [ 4]  513 	ld	h,a
   45B6 DD 7E FA      [19]  514 	ld	a,-6 (ix)
   45B9 95            [ 4]  515 	sub	a, l
   45BA 6F            [ 4]  516 	ld	l,a
   45BB DD 7E FB      [19]  517 	ld	a,-5 (ix)
   45BE 9C            [ 4]  518 	sbc	a, h
   45BF 67            [ 4]  519 	ld	h,a
   45C0 D5            [11]  520 	push	de
   45C1 E5            [11]  521 	push	hl
   45C2 C5            [11]  522 	push	bc
   45C3 CD 99 67      [17]  523 	call	__mulint
   45C6 F1            [10]  524 	pop	af
   45C7 F1            [10]  525 	pop	af
   45C8 4D            [ 4]  526 	ld	c,l
   45C9 44            [ 4]  527 	ld	b,h
   45CA D1            [10]  528 	pop	de
   45CB 79            [ 4]  529 	ld	a,c
   45CC 12            [ 7]  530 	ld	(de),a
   45CD 13            [ 6]  531 	inc	de
   45CE 78            [ 4]  532 	ld	a,b
   45CF 12            [ 7]  533 	ld	(de),a
                            534 ;src/IA.c:175: return;
   45D0 C3 7E 47      [10]  535 	jp	00140$
   45D3                     536 00111$:
                            537 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   45D3 DD CB F7 46   [20]  538 	bit	0,-9 (ix)
   45D7 28 51         [12]  539 	jr	Z,00107$
   45D9 DD 7E F5      [19]  540 	ld	a,-11 (ix)
   45DC DD 86 FE      [19]  541 	add	a, -2 (ix)
   45DF 4F            [ 4]  542 	ld	c,a
   45E0 DD 7E F6      [19]  543 	ld	a,-10 (ix)
   45E3 DD 8E FF      [19]  544 	adc	a, -1 (ix)
   45E6 47            [ 4]  545 	ld	b,a
   45E7 DD 7E F1      [19]  546 	ld	a,-15 (ix)
   45EA 91            [ 4]  547 	sub	a, c
   45EB DD 7E F2      [19]  548 	ld	a,-14 (ix)
   45EE 98            [ 4]  549 	sbc	a, b
   45EF 30 39         [12]  550 	jr	NC,00107$
                            551 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   45F1 6B            [ 4]  552 	ld	l, e
   45F2 62            [ 4]  553 	ld	h, d
   45F3 DD 7E F8      [19]  554 	ld	a,-8 (ix)
   45F6 77            [ 7]  555 	ld	(hl),a
   45F7 23            [ 6]  556 	inc	hl
   45F8 DD 7E F9      [19]  557 	ld	a,-7 (ix)
   45FB 77            [ 7]  558 	ld	(hl),a
                            559 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   45FC E1            [10]  560 	pop	hl
   45FD E5            [11]  561 	push	hl
   45FE 4E            [ 7]  562 	ld	c,(hl)
   45FF 23            [ 6]  563 	inc	hl
   4600 46            [ 7]  564 	ld	b,(hl)
   4601 DD 7E FA      [19]  565 	ld	a,-6 (ix)
   4604 91            [ 4]  566 	sub	a, c
   4605 4F            [ 4]  567 	ld	c,a
   4606 DD 7E FB      [19]  568 	ld	a,-5 (ix)
   4609 98            [ 4]  569 	sbc	a, b
   460A 47            [ 4]  570 	ld	b,a
   460B D5            [11]  571 	push	de
   460C C5            [11]  572 	push	bc
   460D DD 6E F8      [19]  573 	ld	l,-8 (ix)
   4610 DD 66 F9      [19]  574 	ld	h,-7 (ix)
   4613 E5            [11]  575 	push	hl
   4614 CD 99 67      [17]  576 	call	__mulint
   4617 F1            [10]  577 	pop	af
   4618 F1            [10]  578 	pop	af
   4619 4D            [ 4]  579 	ld	c,l
   461A 44            [ 4]  580 	ld	b,h
   461B D1            [10]  581 	pop	de
   461C 21 00 01      [10]  582 	ld	hl,#0x0100
   461F 09            [11]  583 	add	hl,bc
   4620 4D            [ 4]  584 	ld	c,l
   4621 44            [ 4]  585 	ld	b,h
   4622 79            [ 4]  586 	ld	a,c
   4623 12            [ 7]  587 	ld	(de),a
   4624 13            [ 6]  588 	inc	de
   4625 78            [ 4]  589 	ld	a,b
   4626 12            [ 7]  590 	ld	(de),a
                            591 ;src/IA.c:180: return;
   4627 C3 7E 47      [10]  592 	jp	00140$
   462A                     593 00107$:
                            594 ;src/IA.c:183: *grad = 0;
   462A 3E 00         [ 7]  595 	ld	a,#0x00
   462C 12            [ 7]  596 	ld	(de),a
   462D 13            [ 6]  597 	inc	de
   462E 3E 00         [ 7]  598 	ld	a,#0x00
   4630 12            [ 7]  599 	ld	(de),a
                            600 ;src/IA.c:184: return;
   4631 C3 7E 47      [10]  601 	jp	00140$
   4634                     602 00138$:
                            603 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4634 DD 6E F5      [19]  604 	ld	l,-11 (ix)
   4637 DD 7E FE      [19]  605 	ld	a,-2 (ix)
   463A DD 77 FC      [19]  606 	ld	-4 (ix),a
   463D 7D            [ 4]  607 	ld	a,l
   463E DD 86 FC      [19]  608 	add	a, -4 (ix)
   4641 DD 96 FC      [19]  609 	sub	a, -4 (ix)
   4644 47            [ 4]  610 	ld	b,a
                            611 ;src/IA.c:187: }else if(c->tipo == 1)
   4645 0D            [ 4]  612 	dec	c
   4646 C2 D6 46      [10]  613 	jp	NZ,00135$
                            614 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4649 48            [ 4]  615 	ld	c,b
                            616 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   464A DD 7E FF      [19]  617 	ld	a,-1 (ix)
   464D DD B6 FE      [19]  618 	or	a,-2 (ix)
   4650 20 0E         [12]  619 	jr	NZ,00115$
   4652 DD 7E 06      [19]  620 	ld	a,6 (ix)
                            621 ;src/IA.c:193: *grad = SCALA;
   4655 91            [ 4]  622 	sub	a,c
   4656 20 08         [12]  623 	jr	NZ,00115$
   4658 12            [ 7]  624 	ld	(de),a
   4659 13            [ 6]  625 	inc	de
   465A 3E 01         [ 7]  626 	ld	a,#0x01
   465C 12            [ 7]  627 	ld	(de),a
                            628 ;src/IA.c:194: return;
   465D C3 7E 47      [10]  629 	jp	00140$
   4660                     630 00115$:
                            631 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   4660 DD 7E 06      [19]  632 	ld	a,6 (ix)
   4663 91            [ 4]  633 	sub	a, c
   4664 3E 00         [ 7]  634 	ld	a,#0x00
   4666 17            [ 4]  635 	rla
   4667 DD 77 FC      [19]  636 	ld	-4 (ix),a
   466A DD CB FC 46   [20]  637 	bit	0,-4 (ix)
   466E 20 4C         [12]  638 	jr	NZ,00121$
   4670 06 00         [ 7]  639 	ld	b,#0x00
   4672 DD 6E FE      [19]  640 	ld	l,-2 (ix)
   4675 DD 66 FF      [19]  641 	ld	h,-1 (ix)
   4678 09            [11]  642 	add	hl,bc
   4679 DD 7E F1      [19]  643 	ld	a,-15 (ix)
   467C 95            [ 4]  644 	sub	a, l
   467D DD 7E F2      [19]  645 	ld	a,-14 (ix)
   4680 9C            [ 4]  646 	sbc	a, h
   4681 30 39         [12]  647 	jr	NC,00121$
                            648 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   4683 6B            [ 4]  649 	ld	l, e
   4684 62            [ 4]  650 	ld	h, d
   4685 DD 7E F8      [19]  651 	ld	a,-8 (ix)
   4688 77            [ 7]  652 	ld	(hl),a
   4689 23            [ 6]  653 	inc	hl
   468A DD 7E F9      [19]  654 	ld	a,-7 (ix)
   468D 77            [ 7]  655 	ld	(hl),a
                            656 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   468E DD 6E EF      [19]  657 	ld	l,-17 (ix)
   4691 DD 66 F0      [19]  658 	ld	h,-16 (ix)
   4694 7E            [ 7]  659 	ld	a, (hl)
   4695 23            [ 6]  660 	inc	hl
   4696 66            [ 7]  661 	ld	h,(hl)
   4697 6F            [ 4]  662 	ld	l,a
   4698 09            [11]  663 	add	hl,bc
   4699 DD 7E FA      [19]  664 	ld	a,-6 (ix)
   469C 95            [ 4]  665 	sub	a, l
   469D 4F            [ 4]  666 	ld	c,a
   469E DD 7E FB      [19]  667 	ld	a,-5 (ix)
   46A1 9C            [ 4]  668 	sbc	a, h
   46A2 47            [ 4]  669 	ld	b,a
   46A3 D5            [11]  670 	push	de
   46A4 C5            [11]  671 	push	bc
   46A5 DD 6E F8      [19]  672 	ld	l,-8 (ix)
   46A8 DD 66 F9      [19]  673 	ld	h,-7 (ix)
   46AB E5            [11]  674 	push	hl
   46AC CD 99 67      [17]  675 	call	__mulint
   46AF F1            [10]  676 	pop	af
   46B0 F1            [10]  677 	pop	af
   46B1 4D            [ 4]  678 	ld	c,l
   46B2 44            [ 4]  679 	ld	b,h
   46B3 D1            [10]  680 	pop	de
   46B4 79            [ 4]  681 	ld	a,c
   46B5 12            [ 7]  682 	ld	(de),a
   46B6 13            [ 6]  683 	inc	de
   46B7 78            [ 4]  684 	ld	a,b
   46B8 12            [ 7]  685 	ld	(de),a
                            686 ;src/IA.c:201: return;
   46B9 C3 7E 47      [10]  687 	jp	00140$
   46BC                     688 00121$:
                            689 ;src/IA.c:202: }else if(val < midPoint)
   46BC DD CB FC 46   [20]  690 	bit	0,-4 (ix)
   46C0 28 0A         [12]  691 	jr	Z,00118$
                            692 ;src/IA.c:204: *grad = SCALA;
   46C2 3E 00         [ 7]  693 	ld	a,#0x00
   46C4 12            [ 7]  694 	ld	(de),a
   46C5 13            [ 6]  695 	inc	de
   46C6 3E 01         [ 7]  696 	ld	a,#0x01
   46C8 12            [ 7]  697 	ld	(de),a
                            698 ;src/IA.c:205: return;
   46C9 C3 7E 47      [10]  699 	jp	00140$
   46CC                     700 00118$:
                            701 ;src/IA.c:207: *grad = 0;
   46CC 3E 00         [ 7]  702 	ld	a,#0x00
   46CE 12            [ 7]  703 	ld	(de),a
   46CF 13            [ 6]  704 	inc	de
   46D0 3E 00         [ 7]  705 	ld	a,#0x00
   46D2 12            [ 7]  706 	ld	(de),a
                            707 ;src/IA.c:208: return;
   46D3 C3 7E 47      [10]  708 	jp	00140$
   46D6                     709 00135$:
                            710 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            711 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   46D6 DD 6E F3      [19]  712 	ld	l,-13 (ix)
   46D9 DD 66 F4      [19]  713 	ld	h,-12 (ix)
   46DC 4E            [ 7]  714 	ld	c,(hl)
   46DD 23            [ 6]  715 	inc	hl
   46DE 7E            [ 7]  716 	ld	a, (hl)
   46DF B1            [ 4]  717 	or	a,c
   46E0 20 0D         [12]  718 	jr	NZ,00125$
   46E2 DD 7E 06      [19]  719 	ld	a,6 (ix)
   46E5 90            [ 4]  720 	sub	a, b
   46E6 20 07         [12]  721 	jr	NZ,00125$
                            722 ;src/IA.c:215: *grad = SCALA;
   46E8 6B            [ 4]  723 	ld	l, e
   46E9 62            [ 4]  724 	ld	h, d
   46EA 36 00         [10]  725 	ld	(hl),#0x00
   46EC 23            [ 6]  726 	inc	hl
   46ED 36 01         [10]  727 	ld	(hl),#0x01
   46EF                     728 00125$:
                            729 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   46EF 78            [ 4]  730 	ld	a,b
   46F0 DD 96 06      [19]  731 	sub	a, 6 (ix)
   46F3 3E 00         [ 7]  732 	ld	a,#0x00
   46F5 17            [ 4]  733 	rla
   46F6 DD 77 FC      [19]  734 	ld	-4 (ix),a
   46F9 DD CB FC 46   [20]  735 	bit	0,-4 (ix)
   46FD 20 69         [12]  736 	jr	NZ,00131$
   46FF 0E 00         [ 7]  737 	ld	c,#0x00
   4701 DD 6E F3      [19]  738 	ld	l,-13 (ix)
   4704 DD 66 F4      [19]  739 	ld	h,-12 (ix)
   4707 7E            [ 7]  740 	ld	a, (hl)
   4708 23            [ 6]  741 	inc	hl
   4709 66            [ 7]  742 	ld	h,(hl)
   470A 6F            [ 4]  743 	ld	l,a
   470B DD 70 F8      [19]  744 	ld	-8 (ix),b
   470E DD 71 F9      [19]  745 	ld	-7 (ix),c
   4711 DD 7E F8      [19]  746 	ld	a,-8 (ix)
   4714 95            [ 4]  747 	sub	a, l
   4715 4F            [ 4]  748 	ld	c,a
   4716 DD 7E F9      [19]  749 	ld	a,-7 (ix)
   4719 9C            [ 4]  750 	sbc	a, h
   471A 47            [ 4]  751 	ld	b,a
   471B 79            [ 4]  752 	ld	a,c
   471C DD 96 F1      [19]  753 	sub	a, -15 (ix)
   471F 78            [ 4]  754 	ld	a,b
   4720 DD 9E F2      [19]  755 	sbc	a, -14 (ix)
   4723 30 43         [12]  756 	jr	NC,00131$
                            757 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   4725 D5            [11]  758 	push	de
   4726 E5            [11]  759 	push	hl
   4727 21 00 01      [10]  760 	ld	hl,#0x0100
   472A E5            [11]  761 	push	hl
   472B CD 50 5D      [17]  762 	call	__divuint
   472E F1            [10]  763 	pop	af
   472F F1            [10]  764 	pop	af
   4730 4D            [ 4]  765 	ld	c,l
   4731 44            [ 4]  766 	ld	b,h
   4732 D1            [10]  767 	pop	de
   4733 6B            [ 4]  768 	ld	l, e
   4734 62            [ 4]  769 	ld	h, d
   4735 71            [ 7]  770 	ld	(hl),c
   4736 23            [ 6]  771 	inc	hl
   4737 70            [ 7]  772 	ld	(hl),b
                            773 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   4738 DD 6E F3      [19]  774 	ld	l,-13 (ix)
   473B DD 66 F4      [19]  775 	ld	h,-12 (ix)
   473E 7E            [ 7]  776 	ld	a, (hl)
   473F 23            [ 6]  777 	inc	hl
   4740 66            [ 7]  778 	ld	h,(hl)
   4741 6F            [ 4]  779 	ld	l,a
   4742 DD 7E F8      [19]  780 	ld	a,-8 (ix)
   4745 95            [ 4]  781 	sub	a, l
   4746 6F            [ 4]  782 	ld	l,a
   4747 DD 7E F9      [19]  783 	ld	a,-7 (ix)
   474A 9C            [ 4]  784 	sbc	a, h
   474B 67            [ 4]  785 	ld	h,a
   474C DD 7E FA      [19]  786 	ld	a,-6 (ix)
   474F 95            [ 4]  787 	sub	a, l
   4750 6F            [ 4]  788 	ld	l,a
   4751 DD 7E FB      [19]  789 	ld	a,-5 (ix)
   4754 9C            [ 4]  790 	sbc	a, h
   4755 67            [ 4]  791 	ld	h,a
   4756 D5            [11]  792 	push	de
   4757 E5            [11]  793 	push	hl
   4758 C5            [11]  794 	push	bc
   4759 CD 99 67      [17]  795 	call	__mulint
   475C F1            [10]  796 	pop	af
   475D F1            [10]  797 	pop	af
   475E 4D            [ 4]  798 	ld	c,l
   475F 44            [ 4]  799 	ld	b,h
   4760 D1            [10]  800 	pop	de
   4761 79            [ 4]  801 	ld	a,c
   4762 12            [ 7]  802 	ld	(de),a
   4763 13            [ 6]  803 	inc	de
   4764 78            [ 4]  804 	ld	a,b
   4765 12            [ 7]  805 	ld	(de),a
   4766 18 16         [12]  806 	jr	00140$
   4768                     807 00131$:
                            808 ;src/IA.c:220: }else if(val > midPoint)
   4768 DD CB FC 46   [20]  809 	bit	0,-4 (ix)
   476C 28 09         [12]  810 	jr	Z,00128$
                            811 ;src/IA.c:223: *grad = SCALA;
   476E 3E 00         [ 7]  812 	ld	a,#0x00
   4770 12            [ 7]  813 	ld	(de),a
   4771 13            [ 6]  814 	inc	de
   4772 3E 01         [ 7]  815 	ld	a,#0x01
   4774 12            [ 7]  816 	ld	(de),a
   4775 18 07         [12]  817 	jr	00140$
   4777                     818 00128$:
                            819 ;src/IA.c:225: *grad = 0;
   4777 3E 00         [ 7]  820 	ld	a,#0x00
   4779 12            [ 7]  821 	ld	(de),a
   477A 13            [ 6]  822 	inc	de
   477B 3E 00         [ 7]  823 	ld	a,#0x00
   477D 12            [ 7]  824 	ld	(de),a
   477E                     825 00140$:
   477E DD F9         [10]  826 	ld	sp, ix
   4780 DD E1         [14]  827 	pop	ix
   4782 C9            [10]  828 	ret
                            829 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            830 ;	---------------------------------
                            831 ; Function defuzzi
                            832 ; ---------------------------------
   4783                     833 _defuzzi::
   4783 DD E5         [15]  834 	push	ix
   4785 DD 21 00 00   [14]  835 	ld	ix,#0
   4789 DD 39         [15]  836 	add	ix,sp
   478B 21 EF FF      [10]  837 	ld	hl,#-17
   478E 39            [11]  838 	add	hl,sp
   478F F9            [ 6]  839 	ld	sp,hl
                            840 ;src/IA.c:239: *re = 0;
   4790 DD 7E 08      [19]  841 	ld	a,8 (ix)
   4793 DD 77 FE      [19]  842 	ld	-2 (ix),a
   4796 DD 7E 09      [19]  843 	ld	a,9 (ix)
   4799 DD 77 FF      [19]  844 	ld	-1 (ix),a
   479C DD 6E FE      [19]  845 	ld	l,-2 (ix)
   479F DD 66 FF      [19]  846 	ld	h,-1 (ix)
   47A2 AF            [ 4]  847 	xor	a, a
   47A3 77            [ 7]  848 	ld	(hl), a
   47A4 23            [ 6]  849 	inc	hl
   47A5 77            [ 7]  850 	ld	(hl), a
                            851 ;src/IA.c:241: while(i < 3)
   47A6 21 00 00      [10]  852 	ld	hl,#0x0000
   47A9 39            [11]  853 	add	hl,sp
   47AA DD 75 FC      [19]  854 	ld	-4 (ix),l
   47AD DD 74 FD      [19]  855 	ld	-3 (ix),h
   47B0 0E 00         [ 7]  856 	ld	c,#0x00
   47B2                     857 00101$:
   47B2 79            [ 4]  858 	ld	a,c
   47B3 D6 03         [ 7]  859 	sub	a, #0x03
   47B5 30 53         [12]  860 	jr	NC,00103$
                            861 ;src/IA.c:243: dom = 0;
   47B7 DD 36 F6 00   [19]  862 	ld	-10 (ix),#0x00
   47BB DD 36 F7 00   [19]  863 	ld	-9 (ix),#0x00
                            864 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   47BF 21 07 00      [10]  865 	ld	hl,#0x0007
   47C2 39            [11]  866 	add	hl,sp
   47C3 DD 75 FA      [19]  867 	ld	-6 (ix),l
   47C6 DD 74 FB      [19]  868 	ld	-5 (ix),h
   47C9 DD 46 04      [19]  869 	ld	b,4 (ix)
   47CC 69            [ 4]  870 	ld	l,c
   47CD 26 00         [ 7]  871 	ld	h,#0x00
   47CF 29            [11]  872 	add	hl, hl
   47D0 EB            [ 4]  873 	ex	de,hl
   47D1 21 F6 68      [10]  874 	ld	hl,#_fmems
   47D4 19            [11]  875 	add	hl,de
   47D5 7E            [ 7]  876 	ld	a,(hl)
   47D6 DD 77 F8      [19]  877 	ld	-8 (ix),a
   47D9 23            [ 6]  878 	inc	hl
   47DA 7E            [ 7]  879 	ld	a,(hl)
   47DB DD 77 F9      [19]  880 	ld	-7 (ix),a
   47DE C5            [11]  881 	push	bc
   47DF D5            [11]  882 	push	de
   47E0 DD 6E FA      [19]  883 	ld	l,-6 (ix)
   47E3 DD 66 FB      [19]  884 	ld	h,-5 (ix)
   47E6 E5            [11]  885 	push	hl
   47E7 C5            [11]  886 	push	bc
   47E8 33            [ 6]  887 	inc	sp
   47E9 DD 6E F8      [19]  888 	ld	l,-8 (ix)
   47EC DD 66 F9      [19]  889 	ld	h,-7 (ix)
   47EF E5            [11]  890 	push	hl
   47F0 CD 69 44      [17]  891 	call	_calculateDom
   47F3 F1            [10]  892 	pop	af
   47F4 F1            [10]  893 	pop	af
   47F5 33            [ 6]  894 	inc	sp
   47F6 D1            [10]  895 	pop	de
   47F7 C1            [10]  896 	pop	bc
                            897 ;src/IA.c:245: vDom[i] = dom/SCALA;
   47F8 DD 6E FC      [19]  898 	ld	l,-4 (ix)
   47FB DD 66 FD      [19]  899 	ld	h,-3 (ix)
   47FE 19            [11]  900 	add	hl,de
   47FF DD 5E F7      [19]  901 	ld	e,-9 (ix)
   4802 16 00         [ 7]  902 	ld	d,#0x00
   4804 73            [ 7]  903 	ld	(hl),e
   4805 23            [ 6]  904 	inc	hl
   4806 72            [ 7]  905 	ld	(hl),d
                            906 ;src/IA.c:246: i++;
   4807 0C            [ 4]  907 	inc	c
   4808 18 A8         [12]  908 	jr	00101$
   480A                     909 00103$:
                            910 ;src/IA.c:250: for(i = 0; i<3; i++)
   480A DD 36 F5 00   [19]  911 	ld	-11 (ix),#0x00
   480E                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   480E DD 6E F5      [19]  914 	ld	l,-11 (ix)
   4811 26 00         [ 7]  915 	ld	h,#0x00
   4813 29            [11]  916 	add	hl, hl
   4814 4D            [ 4]  917 	ld	c, l
   4815 44            [ 4]  918 	ld	b, h
   4816 DD 6E FC      [19]  919 	ld	l,-4 (ix)
   4819 DD 66 FD      [19]  920 	ld	h,-3 (ix)
   481C 09            [11]  921 	add	hl,bc
   481D 5E            [ 7]  922 	ld	e,(hl)
   481E 23            [ 6]  923 	inc	hl
   481F 56            [ 7]  924 	ld	d,(hl)
   4820 21 E4 68      [10]  925 	ld	hl,#_aceleracion
   4823 09            [11]  926 	add	hl,bc
   4824 4E            [ 7]  927 	ld	c,(hl)
   4825 23            [ 6]  928 	inc	hl
   4826 46            [ 7]  929 	ld	b,(hl)
   4827 C5            [11]  930 	push	bc
   4828 D5            [11]  931 	push	de
   4829 CD 99 67      [17]  932 	call	__mulint
   482C F1            [10]  933 	pop	af
   482D F1            [10]  934 	pop	af
   482E 4D            [ 4]  935 	ld	c,l
   482F 44            [ 4]  936 	ld	b,h
   4830 DD 6E FE      [19]  937 	ld	l,-2 (ix)
   4833 DD 66 FF      [19]  938 	ld	h,-1 (ix)
   4836 5E            [ 7]  939 	ld	e,(hl)
   4837 23            [ 6]  940 	inc	hl
   4838 66            [ 7]  941 	ld	h,(hl)
   4839 6B            [ 4]  942 	ld	l, e
   483A 09            [11]  943 	add	hl,bc
   483B 4D            [ 4]  944 	ld	c,l
   483C 44            [ 4]  945 	ld	b,h
   483D DD 6E FE      [19]  946 	ld	l,-2 (ix)
   4840 DD 66 FF      [19]  947 	ld	h,-1 (ix)
   4843 71            [ 7]  948 	ld	(hl),c
   4844 23            [ 6]  949 	inc	hl
   4845 70            [ 7]  950 	ld	(hl),b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   4846 DD 34 F5      [23]  952 	inc	-11 (ix)
   4849 DD 7E F5      [19]  953 	ld	a,-11 (ix)
   484C D6 03         [ 7]  954 	sub	a, #0x03
   484E 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   4850 DD 6E 06      [19]  957 	ld	l,6 (ix)
   4853 DD 66 07      [19]  958 	ld	h,7 (ix)
   4856 23            [ 6]  959 	inc	hl
   4857 7E            [ 7]  960 	ld	a,(hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   4858 DD 6E FE      [19]  962 	ld	l,-2 (ix)
   485B DD 66 FF      [19]  963 	ld	h,-1 (ix)
   485E 5E            [ 7]  964 	ld	e,(hl)
   485F 23            [ 6]  965 	inc	hl
   4860 56            [ 7]  966 	ld	d,(hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   4861 B7            [ 4]  968 	or	a, a
   4862 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   4864 DD 6E FE      [19]  971 	ld	l,-2 (ix)
   4867 DD 66 FF      [19]  972 	ld	h,-1 (ix)
   486A 73            [ 7]  973 	ld	(hl),e
   486B 23            [ 6]  974 	inc	hl
   486C 72            [ 7]  975 	ld	(hl),d
   486D 18 10         [12]  976 	jr	00110$
   486F                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   486F AF            [ 4]  979 	xor	a, a
   4870 93            [ 4]  980 	sub	a, e
   4871 5F            [ 4]  981 	ld	e,a
   4872 3E 00         [ 7]  982 	ld	a, #0x00
   4874 9A            [ 4]  983 	sbc	a, d
   4875 4F            [ 4]  984 	ld	c,a
   4876 DD 6E FE      [19]  985 	ld	l,-2 (ix)
   4879 DD 66 FF      [19]  986 	ld	h,-1 (ix)
   487C 73            [ 7]  987 	ld	(hl),e
   487D 23            [ 6]  988 	inc	hl
   487E 71            [ 7]  989 	ld	(hl),c
   487F                     990 00110$:
   487F DD F9         [10]  991 	ld	sp, ix
   4881 DD E1         [14]  992 	pop	ix
   4883 C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   4884                     998 _calcule::
   4884 DD E5         [15]  999 	push	ix
   4886 DD 21 00 00   [14] 1000 	ld	ix,#0
   488A DD 39         [15] 1001 	add	ix,sp
   488C F5            [11] 1002 	push	af
   488D 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   488E DD 36 FE 00   [19] 1005 	ld	-2 (ix),#0x00
   4892 DD 36 FF 00   [19] 1006 	ld	-1 (ix),#0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   4896 DD 36 FD 00   [19] 1008 	ld	-3 (ix),#0x00
   489A                    1009 00103$:
   489A DD 7E FD      [19] 1010 	ld	a,-3 (ix)
   489D DD 96 04      [19] 1011 	sub	a, 4 (ix)
   48A0 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   48A2 FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   48A6 FD 39         [15] 1015 	add	iy,sp
   48A8 DD 6E FD      [19] 1016 	ld	l,-3 (ix)
   48AB 26 00         [ 7] 1017 	ld	h,#0x00
   48AD 29            [11] 1018 	add	hl, hl
   48AE 01 EA 68      [10] 1019 	ld	bc,#_vRulesx
   48B1 09            [11] 1020 	add	hl,bc
   48B2 4D            [ 4] 1021 	ld	c,l
   48B3 44            [ 4] 1022 	ld	b,h
   48B4 7E            [ 7] 1023 	ld	a, (hl)
   48B5 23            [ 6] 1024 	inc	hl
   48B6 66            [ 7] 1025 	ld	h,(hl)
   48B7 6F            [ 4] 1026 	ld	l,a
   48B8 5E            [ 7] 1027 	ld	e,(hl)
   48B9 23            [ 6] 1028 	inc	hl
   48BA 56            [ 7] 1029 	ld	d,(hl)
   48BB C5            [11] 1030 	push	bc
   48BC FD E5         [15] 1031 	push	iy
   48BE DD 7E 05      [19] 1032 	ld	a,5 (ix)
   48C1 F5            [11] 1033 	push	af
   48C2 33            [ 6] 1034 	inc	sp
   48C3 D5            [11] 1035 	push	de
   48C4 CD 69 44      [17] 1036 	call	_calculateDom
   48C7 F1            [10] 1037 	pop	af
   48C8 F1            [10] 1038 	pop	af
   48C9 33            [ 6] 1039 	inc	sp
   48CA C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   48CB DD 5E 06      [19] 1042 	ld	e,6 (ix)
   48CE DD 56 07      [19] 1043 	ld	d,7 (ix)
   48D1 69            [ 4] 1044 	ld	l, c
   48D2 60            [ 4] 1045 	ld	h, b
   48D3 7E            [ 7] 1046 	ld	a, (hl)
   48D4 23            [ 6] 1047 	inc	hl
   48D5 66            [ 7] 1048 	ld	h,(hl)
   48D6 6F            [ 4] 1049 	ld	l,a
   48D7 23            [ 6] 1050 	inc	hl
   48D8 23            [ 6] 1051 	inc	hl
   48D9 7E            [ 7] 1052 	ld	a, (hl)
   48DA 23            [ 6] 1053 	inc	hl
   48DB 66            [ 7] 1054 	ld	h,(hl)
   48DC 6F            [ 4] 1055 	ld	l,a
   48DD 23            [ 6] 1056 	inc	hl
   48DE 23            [ 6] 1057 	inc	hl
   48DF 4E            [ 7] 1058 	ld	c,(hl)
   48E0 23            [ 6] 1059 	inc	hl
   48E1 46            [ 7] 1060 	ld	b,(hl)
   48E2 D5            [11] 1061 	push	de
   48E3 DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   48E6 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   48E9 E5            [11] 1064 	push	hl
   48EA C5            [11] 1065 	push	bc
   48EB CD 99 67      [17] 1066 	call	__mulint
   48EE F1            [10] 1067 	pop	af
   48EF F1            [10] 1068 	pop	af
   48F0 4D            [ 4] 1069 	ld	c,l
   48F1 44            [ 4] 1070 	ld	b,h
   48F2 D1            [10] 1071 	pop	de
   48F3 6B            [ 4] 1072 	ld	l, e
   48F4 62            [ 4] 1073 	ld	h, d
   48F5 7E            [ 7] 1074 	ld	a, (hl)
   48F6 23            [ 6] 1075 	inc	hl
   48F7 66            [ 7] 1076 	ld	h,(hl)
   48F8 6F            [ 4] 1077 	ld	l,a
   48F9 09            [11] 1078 	add	hl,bc
   48FA 4C            [ 4] 1079 	ld	c,h
   48FB 06 00         [ 7] 1080 	ld	b,#0x00
   48FD 79            [ 4] 1081 	ld	a,c
   48FE 12            [ 7] 1082 	ld	(de),a
   48FF 13            [ 6] 1083 	inc	de
   4900 78            [ 4] 1084 	ld	a,b
   4901 12            [ 7] 1085 	ld	(de),a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   4902 DD 34 FD      [23] 1087 	inc	-3 (ix)
   4905 18 93         [12] 1088 	jr	00103$
   4907                    1089 00105$:
   4907 DD F9         [10] 1090 	ld	sp, ix
   4909 DD E1         [14] 1091 	pop	ix
   490B C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   490C                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   490C 21 04 00      [10] 1099 	ld	hl, #4
   490F 39            [11] 1100 	add	hl, sp
   4910 4E            [ 7] 1101 	ld	c, (hl)
   4911 23            [ 6] 1102 	inc	hl
   4912 46            [ 7] 1103 	ld	b, (hl)
   4913 59            [ 4] 1104 	ld	e, c
   4914 50            [ 4] 1105 	ld	d, b
   4915 13            [ 6] 1106 	inc	de
   4916 AF            [ 4] 1107 	xor	a, a
   4917 12            [ 7] 1108 	ld	(de),a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   4918 AF            [ 4] 1110 	xor	a, a
   4919 02            [ 7] 1111 	ld	(bc),a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   491A 21 03 00      [10] 1113 	ld	hl, #2+1
   491D 39            [11] 1114 	add	hl, sp
   491E CB 7E         [12] 1115 	bit	7,(hl)
   4920 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   4922 3E 01         [ 7] 1118 	ld	a,#0x01
   4924 02            [ 7] 1119 	ld	(bc),a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   4925 AF            [ 4] 1121 	xor	a, a
   4926 12            [ 7] 1122 	ld	(de),a
   4927 C9            [10] 1123 	ret
   4928                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   4928 AF            [ 4] 1126 	xor	a, a
   4929 FD 21 02 00   [14] 1127 	ld	iy,#2
   492D FD 39         [15] 1128 	add	iy,sp
   492F FD BE 00      [19] 1129 	cp	a, 0 (iy)
   4932 FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   4935 E2 3A 49      [10] 1131 	jp	PO, 00116$
   4938 EE 80         [ 7] 1132 	xor	a, #0x80
   493A                    1133 00116$:
   493A F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   493B 3E 01         [ 7] 1136 	ld	a,#0x01
   493D 12            [ 7] 1137 	ld	(de),a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   493E AF            [ 4] 1139 	xor	a, a
   493F 02            [ 7] 1140 	ld	(bc),a
   4940 C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   4941                    1146 _fuzzificacion::
   4941 DD E5         [15] 1147 	push	ix
   4943 DD 21 00 00   [14] 1148 	ld	ix,#0
   4947 DD 39         [15] 1149 	add	ix,sp
   4949 21 EE FF      [10] 1150 	ld	hl,#-18
   494C 39            [11] 1151 	add	hl,sp
   494D F9            [ 6] 1152 	ld	sp,hl
                           1153 ;src/IA.c:299: ball = &ballX;
   494E 21 06 00      [10] 1154 	ld	hl,#0x0006
   4951 39            [11] 1155 	add	hl,sp
   4952 DD 75 FA      [19] 1156 	ld	-6 (ix),l
   4955 DD 74 FB      [19] 1157 	ld	-5 (ix),h
   4958 4D            [ 4] 1158 	ld	c,l
   4959 44            [ 4] 1159 	ld	b,h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   495A DD 5E 08      [19] 1161 	ld	e,8 (ix)
   495D 16 00         [ 7] 1162 	ld	d,#0x00
   495F DD 6E 0A      [19] 1163 	ld	l,10 (ix)
   4962 26 00         [ 7] 1164 	ld	h,#0x00
   4964 7B            [ 4] 1165 	ld	a,e
   4965 95            [ 4] 1166 	sub	a, l
   4966 DD 77 FE      [19] 1167 	ld	-2 (ix),a
   4969 7A            [ 4] 1168 	ld	a,d
   496A 9C            [ 4] 1169 	sbc	a, h
   496B DD 77 FF      [19] 1170 	ld	-1 (ix),a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   496E DD 6E 09      [19] 1172 	ld	l,9 (ix)
   4971 26 00         [ 7] 1173 	ld	h,#0x00
   4973 DD 5E 0B      [19] 1174 	ld	e,11 (ix)
   4976 16 00         [ 7] 1175 	ld	d,#0x00
   4978 7D            [ 4] 1176 	ld	a,l
   4979 93            [ 4] 1177 	sub	a, e
   497A DD 77 FC      [19] 1178 	ld	-4 (ix),a
   497D 7C            [ 4] 1179 	ld	a,h
   497E 9A            [ 4] 1180 	sbc	a, d
   497F DD 77 FD      [19] 1181 	ld	-3 (ix),a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   4982 3E 6F         [ 7] 1183 	ld	a,#0x6F
   4984 93            [ 4] 1184 	sub	a, e
   4985 DD 77 F8      [19] 1185 	ld	-8 (ix),a
   4988 3E 00         [ 7] 1186 	ld	a,#0x00
   498A 9A            [ 4] 1187 	sbc	a, d
   498B DD 77 F9      [19] 1188 	ld	-7 (ix),a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   498E 59            [ 4] 1190 	ld	e, c
   498F 50            [ 4] 1191 	ld	d, b
   4990 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   4991 3E FE         [ 7] 1194 	ld	a,#0xFE
   4993 DD BE FE      [19] 1195 	cp	a, -2 (ix)
   4996 3E FF         [ 7] 1196 	ld	a,#0xFF
   4998 DD 9E FF      [19] 1197 	sbc	a, -1 (ix)
   499B E2 A0 49      [10] 1198 	jp	PO, 00148$
   499E EE 80         [ 7] 1199 	xor	a, #0x80
   49A0                    1200 00148$:
   49A0 FA AA 49      [10] 1201 	jp	M,00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   49A3 3E 01         [ 7] 1203 	ld	a,#0x01
   49A5 02            [ 7] 1204 	ld	(bc),a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   49A6 AF            [ 4] 1206 	xor	a, a
   49A7 12            [ 7] 1207 	ld	(de),a
   49A8 18 05         [12] 1208 	jr	00103$
   49AA                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   49AA 3E 01         [ 7] 1211 	ld	a,#0x01
   49AC 12            [ 7] 1212 	ld	(de),a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   49AD AF            [ 4] 1214 	xor	a, a
   49AE 02            [ 7] 1215 	ld	(bc),a
   49AF                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   49AF AF            [ 4] 1218 	xor	a, a
   49B0 DD BE FE      [19] 1219 	cp	a, -2 (ix)
   49B3 DD 9E FF      [19] 1220 	sbc	a, -1 (ix)
   49B6 E2 BB 49      [10] 1221 	jp	PO, 00149$
   49B9 EE 80         [ 7] 1222 	xor	a, #0x80
   49BB                    1223 00149$:
   49BB 07            [ 4] 1224 	rlca
   49BC E6 01         [ 7] 1225 	and	a,#0x01
   49BE 4F            [ 4] 1226 	ld	c,a
   49BF DD 7E F8      [19] 1227 	ld	a,-8 (ix)
   49C2 DD 96 FC      [19] 1228 	sub	a, -4 (ix)
   49C5 DD 7E F9      [19] 1229 	ld	a,-7 (ix)
   49C8 DD 9E FD      [19] 1230 	sbc	a, -3 (ix)
   49CB E2 D0 49      [10] 1231 	jp	PO, 00150$
   49CE EE 80         [ 7] 1232 	xor	a, #0x80
   49D0                    1233 00150$:
   49D0 F2 EA 49      [10] 1234 	jp	P,00109$
   49D3 79            [ 4] 1235 	ld	a,c
   49D4 B7            [ 4] 1236 	or	a, a
   49D5 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   49D7 21 04 00      [10] 1239 	ld	hl,#0x0004
   49DA 39            [11] 1240 	add	hl,sp
   49DB E5            [11] 1241 	push	hl
   49DC DD 6E F8      [19] 1242 	ld	l,-8 (ix)
   49DF DD 66 F9      [19] 1243 	ld	h,-7 (ix)
   49E2 E5            [11] 1244 	push	hl
   49E3 CD 0C 49      [17] 1245 	call	_calcularb_direc
   49E6 F1            [10] 1246 	pop	af
   49E7 F1            [10] 1247 	pop	af
   49E8 18 3C         [12] 1248 	jr	00110$
   49EA                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   49EA DD 7E FC      [19] 1251 	ld	a,-4 (ix)
   49ED DD 96 F8      [19] 1252 	sub	a, -8 (ix)
   49F0 DD 7E FD      [19] 1253 	ld	a,-3 (ix)
   49F3 DD 9E F9      [19] 1254 	sbc	a, -7 (ix)
   49F6 E2 FB 49      [10] 1255 	jp	PO, 00151$
   49F9 EE 80         [ 7] 1256 	xor	a, #0x80
   49FB                    1257 00151$:
   49FB F2 15 4A      [10] 1258 	jp	P,00105$
   49FE 79            [ 4] 1259 	ld	a,c
   49FF B7            [ 4] 1260 	or	a, a
   4A00 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   4A02 21 04 00      [10] 1263 	ld	hl,#0x0004
   4A05 39            [11] 1264 	add	hl,sp
   4A06 E5            [11] 1265 	push	hl
   4A07 DD 6E F8      [19] 1266 	ld	l,-8 (ix)
   4A0A DD 66 F9      [19] 1267 	ld	h,-7 (ix)
   4A0D E5            [11] 1268 	push	hl
   4A0E CD 0C 49      [17] 1269 	call	_calcularb_direc
   4A11 F1            [10] 1270 	pop	af
   4A12 F1            [10] 1271 	pop	af
   4A13 18 11         [12] 1272 	jr	00110$
   4A15                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   4A15 21 04 00      [10] 1275 	ld	hl,#0x0004
   4A18 39            [11] 1276 	add	hl,sp
   4A19 E5            [11] 1277 	push	hl
   4A1A DD 6E FC      [19] 1278 	ld	l,-4 (ix)
   4A1D DD 66 FD      [19] 1279 	ld	h,-3 (ix)
   4A20 E5            [11] 1280 	push	hl
   4A21 CD 0C 49      [17] 1281 	call	_calcularb_direc
   4A24 F1            [10] 1282 	pop	af
   4A25 F1            [10] 1283 	pop	af
   4A26                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   4A26 DD 4E FE      [19] 1286 	ld	c,-2 (ix)
   4A29 DD 71 F1      [19] 1287 	ld	-15 (ix),c
   4A2C DD 36 F0 00   [19] 1288 	ld	-16 (ix),#0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   4A30 DD 46 FC      [19] 1290 	ld	b,-4 (ix)
   4A33 0E 00         [ 7] 1291 	ld	c,#0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   4A35 21 08 00      [10] 1293 	ld	hl,#0x0008
   4A38 39            [11] 1294 	add	hl,sp
   4A39 DD 56 F0      [19] 1295 	ld	d,-16 (ix)
   4A3C C5            [11] 1296 	push	bc
   4A3D E5            [11] 1297 	push	hl
   4A3E 1E 03         [ 7] 1298 	ld	e, #0x03
   4A40 D5            [11] 1299 	push	de
   4A41 CD 84 48      [17] 1300 	call	_calcule
   4A44 F1            [10] 1301 	pop	af
   4A45 F1            [10] 1302 	pop	af
   4A46 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   4A47 21 00 00      [10] 1305 	ld	hl,#0x0000
   4A4A 39            [11] 1306 	add	hl,sp
   4A4B 51            [ 4] 1307 	ld	d,c
   4A4C C5            [11] 1308 	push	bc
   4A4D E5            [11] 1309 	push	hl
   4A4E 1E 03         [ 7] 1310 	ld	e, #0x03
   4A50 D5            [11] 1311 	push	de
   4A51 CD 84 48      [17] 1312 	call	_calcule
   4A54 F1            [10] 1313 	pop	af
   4A55 F1            [10] 1314 	pop	af
   4A56 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   4A57 78            [ 4] 1317 	ld	a,b
   4A58 B1            [ 4] 1318 	or	a,c
   4A59 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   4A5B DD 4E FA      [19] 1321 	ld	c,-6 (ix)
   4A5E DD 46 FB      [19] 1322 	ld	b,-5 (ix)
   4A61 DD 6E 04      [19] 1323 	ld	l,4 (ix)
   4A64 DD 66 05      [19] 1324 	ld	h,5 (ix)
   4A67 E5            [11] 1325 	push	hl
   4A68 C5            [11] 1326 	push	bc
   4A69 DD 6E F6      [19] 1327 	ld	l,-10 (ix)
   4A6C DD 66 F7      [19] 1328 	ld	h,-9 (ix)
   4A6F E5            [11] 1329 	push	hl
   4A70 CD 83 47      [17] 1330 	call	_defuzzi
   4A73 21 06 00      [10] 1331 	ld	hl,#6
   4A76 39            [11] 1332 	add	hl,sp
   4A77 F9            [ 6] 1333 	ld	sp,hl
                           1334 ;src/IA.c:336: ax = 0;
   4A78                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   4A78 DD 7E F1      [19] 1337 	ld	a,-15 (ix)
   4A7B DD B6 F0      [19] 1338 	or	a,-16 (ix)
   4A7E 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   4A80 21 04 00      [10] 1341 	ld	hl,#0x0004
   4A83 39            [11] 1342 	add	hl,sp
   4A84 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   4A87 DD 46 07      [19] 1344 	ld	b,7 (ix)
   4A8A C5            [11] 1345 	push	bc
   4A8B E5            [11] 1346 	push	hl
   4A8C DD 6E EE      [19] 1347 	ld	l,-18 (ix)
   4A8F DD 66 EF      [19] 1348 	ld	h,-17 (ix)
   4A92 E5            [11] 1349 	push	hl
   4A93 CD 83 47      [17] 1350 	call	_defuzzi
   4A96 21 06 00      [10] 1351 	ld	hl,#6
   4A99 39            [11] 1352 	add	hl,sp
   4A9A F9            [ 6] 1353 	ld	sp,hl
                           1354 ;src/IA.c:341: ay = 0;
   4A9B                    1355 00118$:
   4A9B DD F9         [10] 1356 	ld	sp, ix
   4A9D DD E1         [14] 1357 	pop	ix
   4A9F C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   4AA0                    1363 _moveIA::
   4AA0 DD E5         [15] 1364 	push	ix
   4AA2 DD 21 00 00   [14] 1365 	ld	ix,#0
   4AA6 DD 39         [15] 1366 	add	ix,sp
   4AA8 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4AA9 DD 7E 04      [19] 1369 	ld	a,4 (ix)
   4AAC DD 77 FE      [19] 1370 	ld	-2 (ix),a
   4AAF DD 7E 05      [19] 1371 	ld	a,5 (ix)
   4AB2 DD 77 FF      [19] 1372 	ld	-1 (ix),a
   4AB5 E1            [10] 1373 	pop	hl
   4AB6 E5            [11] 1374 	push	hl
   4AB7 23            [ 6] 1375 	inc	hl
   4AB8 23            [ 6] 1376 	inc	hl
   4AB9 4E            [ 7] 1377 	ld	c,(hl)
   4ABA 23            [ 6] 1378 	inc	hl
   4ABB 46            [ 7] 1379 	ld	b,(hl)
   4ABC DD 6E 08      [19] 1380 	ld	l,8 (ix)
   4ABF DD 66 09      [19] 1381 	ld	h,9 (ix)
   4AC2 23            [ 6] 1382 	inc	hl
   4AC3 23            [ 6] 1383 	inc	hl
   4AC4 5E            [ 7] 1384 	ld	e,(hl)
   4AC5 23            [ 6] 1385 	inc	hl
   4AC6 56            [ 7] 1386 	ld	d,(hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   4AC7 DD 7E FE      [19] 1388 	ld	a,-2 (ix)
   4ACA C6 0C         [ 7] 1389 	add	a, #0x0C
   4ACC 6F            [ 4] 1390 	ld	l,a
   4ACD DD 7E FF      [19] 1391 	ld	a,-1 (ix)
   4AD0 CE 00         [ 7] 1392 	adc	a, #0x00
   4AD2 67            [ 4] 1393 	ld	h,a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4AD3 7B            [ 4] 1395 	ld	a,e
   4AD4 91            [ 4] 1396 	sub	a, c
   4AD5 7A            [ 4] 1397 	ld	a,d
   4AD6 98            [ 4] 1398 	sbc	a, b
   4AD7 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   4AD9 36 E0         [10] 1401 	ld	(hl),#0xE0
   4ADB 23            [ 6] 1402 	inc	hl
   4ADC 36 FF         [10] 1403 	ld	(hl),#0xFF
   4ADE 18 0B         [12] 1404 	jr	00106$
   4AE0                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   4AE0 79            [ 4] 1407 	ld	a,c
   4AE1 93            [ 4] 1408 	sub	a, e
   4AE2 78            [ 4] 1409 	ld	a,b
   4AE3 9A            [ 4] 1410 	sbc	a, d
   4AE4 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   4AE6 36 20         [10] 1413 	ld	(hl),#0x20
   4AE8 23            [ 6] 1414 	inc	hl
   4AE9 36 00         [10] 1415 	ld	(hl),#0x00
   4AEB                    1416 00106$:
   4AEB DD F9         [10] 1417 	ld	sp, ix
   4AED DD E1         [14] 1418 	pop	ix
   4AEF C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   68FC                    1422 __xinit__vRulesx:
   68FC 51 44              1423 	.dw _rulex
   68FE 55 44              1424 	.dw _rulex1
   6900 59 44              1425 	.dw _rulex2
   6902                    1426 __xinit__vRulesy:
   6902 5D 44              1427 	.dw _ruley
   6904 61 44              1428 	.dw _ruley1
   6906 65 44              1429 	.dw _ruley2
   6908                    1430 __xinit__fmems:
   6908 3B 44              1431 	.dw _acelPo
   690A 46 44              1432 	.dw _acelMed
   690C 30 44              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
