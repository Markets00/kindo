                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
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
   6FBD                      41 _aceleracion::
   6FBD                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   6FC3                      47 _vRulesx::
   6FC3                      48 	.ds 6
   6FC9                      49 _vRulesy::
   6FC9                      50 	.ds 6
   6FCF                      51 _fmems::
   6FCF                      52 	.ds 6
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
   4319                      77 _initAcel::
   4319 DD E5         [15]   78 	push	ix
   431B DD 21 00 00   [14]   79 	ld	ix,#0
   431F DD 39         [15]   80 	add	ix,sp
   4321 21 F8 FF      [10]   81 	ld	hl, #-8
   4324 39            [11]   82 	add	hl, sp
   4325 F9            [ 6]   83 	ld	sp, hl
                             84 ;src/IA.c:129: u8 i = 0;
   4326 1E 00         [ 7]   85 	ld	e, #0x00
                             86 ;src/IA.c:130: switch(nivel){
   4328 DD 7E 04      [19]   87 	ld	a, 4 (ix)
   432B B7            [ 4]   88 	or	a, a
   432C 28 09         [12]   89 	jr	Z,00101$
   432E DD 7E 04      [19]   90 	ld	a, 4 (ix)
   4331 3D            [ 4]   91 	dec	a
   4332 28 59         [12]   92 	jr	Z,00105$
   4334 C3 E1 43      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   4337                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   4337 21 00 00      [10]   97 	ld	hl, #0x0000
   433A 39            [11]   98 	add	hl, sp
   433B DD 75 FE      [19]   99 	ld	-2 (ix), l
   433E DD 74 FF      [19]  100 	ld	-1 (ix), h
   4341 36 0F         [10]  101 	ld	(hl), #0x0f
   4343 23            [ 6]  102 	inc	hl
   4344 36 00         [10]  103 	ld	(hl), #0x00
   4346 DD 6E FE      [19]  104 	ld	l,-2 (ix)
   4349 DD 66 FF      [19]  105 	ld	h,-1 (ix)
   434C 23            [ 6]  106 	inc	hl
   434D 23            [ 6]  107 	inc	hl
   434E 36 14         [10]  108 	ld	(hl), #0x14
   4350 23            [ 6]  109 	inc	hl
   4351 36 00         [10]  110 	ld	(hl), #0x00
   4353 DD 7E FE      [19]  111 	ld	a, -2 (ix)
   4356 C6 04         [ 7]  112 	add	a, #0x04
   4358 6F            [ 4]  113 	ld	l, a
   4359 DD 7E FF      [19]  114 	ld	a, -1 (ix)
   435C CE 00         [ 7]  115 	adc	a, #0x00
   435E 67            [ 4]  116 	ld	h, a
   435F 36 17         [10]  117 	ld	(hl), #0x17
   4361 23            [ 6]  118 	inc	hl
   4362 36 00         [10]  119 	ld	(hl), #0x00
                            120 ;src/IA.c:133: while(i<3)
   4364 01 BD 6F      [10]  121 	ld	bc, #_aceleracion+0
   4367 1E 00         [ 7]  122 	ld	e, #0x00
   4369                     123 00102$:
   4369 7B            [ 4]  124 	ld	a, e
   436A D6 03         [ 7]  125 	sub	a, #0x03
   436C 30 1F         [12]  126 	jr	NC,00124$
                            127 ;src/IA.c:135: aceleracion[i] = aux[i];
   436E 6B            [ 4]  128 	ld	l, e
   436F 26 00         [ 7]  129 	ld	h, #0x00
   4371 29            [11]  130 	add	hl, hl
   4372 E5            [11]  131 	push	hl
   4373 FD E1         [14]  132 	pop	iy
   4375 FD 09         [15]  133 	add	iy, bc
   4377 DD 7E FE      [19]  134 	ld	a, -2 (ix)
   437A 85            [ 4]  135 	add	a, l
   437B 6F            [ 4]  136 	ld	l, a
   437C DD 7E FF      [19]  137 	ld	a, -1 (ix)
   437F 8C            [ 4]  138 	adc	a, h
   4380 67            [ 4]  139 	ld	h, a
   4381 7E            [ 7]  140 	ld	a, (hl)
   4382 23            [ 6]  141 	inc	hl
   4383 56            [ 7]  142 	ld	d, (hl)
   4384 FD 77 00      [19]  143 	ld	0 (iy), a
   4387 FD 72 01      [19]  144 	ld	1 (iy), d
                            145 ;src/IA.c:136: i++;
   438A 1C            [ 4]  146 	inc	e
   438B 18 DC         [12]  147 	jr	00102$
                            148 ;src/IA.c:139: case 1:{
   438D                     149 00124$:
   438D                     150 00105$:
                            151 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   438D 21 00 00      [10]  152 	ld	hl, #0x0000
   4390 39            [11]  153 	add	hl, sp
   4391 DD 75 FE      [19]  154 	ld	-2 (ix), l
   4394 DD 74 FF      [19]  155 	ld	-1 (ix), h
   4397 36 17         [10]  156 	ld	(hl), #0x17
   4399 23            [ 6]  157 	inc	hl
   439A 36 00         [10]  158 	ld	(hl), #0x00
   439C DD 6E FE      [19]  159 	ld	l,-2 (ix)
   439F DD 66 FF      [19]  160 	ld	h,-1 (ix)
   43A2 23            [ 6]  161 	inc	hl
   43A3 23            [ 6]  162 	inc	hl
   43A4 36 19         [10]  163 	ld	(hl), #0x19
   43A6 23            [ 6]  164 	inc	hl
   43A7 36 00         [10]  165 	ld	(hl), #0x00
   43A9 DD 7E FE      [19]  166 	ld	a, -2 (ix)
   43AC C6 04         [ 7]  167 	add	a, #0x04
   43AE 6F            [ 4]  168 	ld	l, a
   43AF DD 7E FF      [19]  169 	ld	a, -1 (ix)
   43B2 CE 00         [ 7]  170 	adc	a, #0x00
   43B4 67            [ 4]  171 	ld	h, a
   43B5 36 33         [10]  172 	ld	(hl), #0x33
   43B7 23            [ 6]  173 	inc	hl
   43B8 36 00         [10]  174 	ld	(hl), #0x00
                            175 ;src/IA.c:141: while(i<3)
   43BA 01 BD 6F      [10]  176 	ld	bc, #_aceleracion+0
   43BD                     177 00106$:
   43BD 7B            [ 4]  178 	ld	a, e
   43BE D6 03         [ 7]  179 	sub	a, #0x03
   43C0 30 1F         [12]  180 	jr	NC,00125$
                            181 ;src/IA.c:143: aceleracion[i] = aux[i];
   43C2 6B            [ 4]  182 	ld	l, e
   43C3 26 00         [ 7]  183 	ld	h, #0x00
   43C5 29            [11]  184 	add	hl, hl
   43C6 E5            [11]  185 	push	hl
   43C7 FD E1         [14]  186 	pop	iy
   43C9 FD 09         [15]  187 	add	iy, bc
   43CB DD 7E FE      [19]  188 	ld	a, -2 (ix)
   43CE 85            [ 4]  189 	add	a, l
   43CF 6F            [ 4]  190 	ld	l, a
   43D0 DD 7E FF      [19]  191 	ld	a, -1 (ix)
   43D3 8C            [ 4]  192 	adc	a, h
   43D4 67            [ 4]  193 	ld	h, a
   43D5 7E            [ 7]  194 	ld	a, (hl)
   43D6 23            [ 6]  195 	inc	hl
   43D7 56            [ 7]  196 	ld	d, (hl)
   43D8 FD 77 00      [19]  197 	ld	0 (iy), a
   43DB FD 72 01      [19]  198 	ld	1 (iy), d
                            199 ;src/IA.c:144: i++;
   43DE 1C            [ 4]  200 	inc	e
   43DF 18 DC         [12]  201 	jr	00106$
                            202 ;src/IA.c:147: default:{
   43E1                     203 00125$:
   43E1                     204 00109$:
                            205 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   43E1 21 00 00      [10]  206 	ld	hl, #0x0000
   43E4 39            [11]  207 	add	hl, sp
   43E5 4D            [ 4]  208 	ld	c,l
   43E6 44            [ 4]  209 	ld	b,h
   43E7 36 19         [10]  210 	ld	(hl), #0x19
   43E9 23            [ 6]  211 	inc	hl
   43EA 36 00         [10]  212 	ld	(hl), #0x00
   43EC 69            [ 4]  213 	ld	l, c
   43ED 60            [ 4]  214 	ld	h, b
   43EE 23            [ 6]  215 	inc	hl
   43EF 23            [ 6]  216 	inc	hl
   43F0 36 33         [10]  217 	ld	(hl), #0x33
   43F2 23            [ 6]  218 	inc	hl
   43F3 36 00         [10]  219 	ld	(hl), #0x00
   43F5 21 04 00      [10]  220 	ld	hl, #0x0004
   43F8 09            [11]  221 	add	hl, bc
   43F9 36 4C         [10]  222 	ld	(hl), #0x4c
   43FB 23            [ 6]  223 	inc	hl
   43FC 36 00         [10]  224 	ld	(hl), #0x00
                            225 ;src/IA.c:149: while(i<3)
   43FE                     226 00110$:
   43FE 7B            [ 4]  227 	ld	a, e
   43FF D6 03         [ 7]  228 	sub	a, #0x03
   4401 30 1B         [12]  229 	jr	NC,00114$
                            230 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   4403 6B            [ 4]  231 	ld	l, e
   4404 26 00         [ 7]  232 	ld	h, #0x00
   4406 29            [11]  233 	add	hl, hl
   4407 FD 21 BD 6F   [14]  234 	ld	iy, #_aceleracion
   440B C5            [11]  235 	push	bc
   440C 4D            [ 4]  236 	ld	c, l
   440D 44            [ 4]  237 	ld	b, h
   440E FD 09         [15]  238 	add	iy, bc
   4410 C1            [10]  239 	pop	bc
   4411 09            [11]  240 	add	hl, bc
   4412 7E            [ 7]  241 	ld	a, (hl)
   4413 23            [ 6]  242 	inc	hl
   4414 66            [ 7]  243 	ld	h, (hl)
   4415 FD 77 00      [19]  244 	ld	0 (iy), a
   4418 FD 74 01      [19]  245 	ld	1 (iy), h
                            246 ;src/IA.c:152: i++;
   441B 1C            [ 4]  247 	inc	e
   441C 18 E0         [12]  248 	jr	00110$
                            249 ;src/IA.c:155: }
   441E                     250 00114$:
   441E DD F9         [10]  251 	ld	sp, ix
   4420 DD E1         [14]  252 	pop	ix
   4422 C9            [10]  253 	ret
   4423                     254 _cerca:
   4423 00 00               255 	.dw #0x0000
   4425 00 05               256 	.dw #0x0500
   4427 01                  257 	.db #0x01	; 1
   4428 00 0A               258 	.dw #0x0a00
   442A 00 0A               259 	.dw #0x0a00
   442C 00 0A               260 	.dw #0x0a00
   442E                     261 _medio:
   442E 00 00               262 	.dw #0x0000
   4430 00 14               263 	.dw #0x1400
   4432 00                  264 	.db #0x00	; 0
   4433 00 14               265 	.dw #0x1400
   4435 00 0A               266 	.dw #0x0a00
   4437 00 0F               267 	.dw #0x0f00
   4439                     268 _lejos:
   4439 00 00               269 	.dw #0x0000
   443B 00 6E               270 	.dw #0x6e00
   443D 02                  271 	.db #0x02	; 2
   443E 00 3C               272 	.dw #0x3c00
   4440 00 19               273 	.dw #0x1900
   4442 00 64               274 	.dw #0x6400
   4444                     275 _acelMu:
   4444 00 00               276 	.dw #0x0000
   4446 80 57               277 	.dw #0x5780
   4448 02                  278 	.db #0x02	; 2
   4449 00 4B               279 	.dw #0x4b00
   444B 00 19               280 	.dw #0x1900
   444D 00 19               281 	.dw #0x1900
   444F                     282 _acelPo:
   444F 00 00               283 	.dw #0x0000
   4451 80 0C               284 	.dw #0x0c80
   4453 01                  285 	.db #0x01	; 1
   4454 00 19               286 	.dw #0x1900
   4456 00 19               287 	.dw #0x1900
   4458 00 19               288 	.dw #0x1900
   445A                     289 _acelMed:
   445A 00 00               290 	.dw #0x0000
   445C 00 32               291 	.dw #0x3200
   445E 00                  292 	.db #0x00	; 0
   445F 00 32               293 	.dw #0x3200
   4461 00 19               294 	.dw #0x1900
   4463 00 19               295 	.dw #0x1900
   4465                     296 _rulex:
   4465 23 44               297 	.dw _cerca
   4467 44 44               298 	.dw _acelMu
   4469                     299 _rulex1:
   4469 2E 44               300 	.dw _medio
   446B 5A 44               301 	.dw _acelMed
   446D                     302 _rulex2:
   446D 39 44               303 	.dw _lejos
   446F 4F 44               304 	.dw _acelPo
   4471                     305 _ruley:
   4471 23 44               306 	.dw _cerca
   4473 44 44               307 	.dw _acelMu
   4475                     308 _ruley1:
   4475 2E 44               309 	.dw _medio
   4477 5A 44               310 	.dw _acelMed
   4479                     311 _ruley2:
   4479 39 44               312 	.dw _lejos
   447B 4F 44               313 	.dw _acelPo
                            314 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            315 ;	---------------------------------
                            316 ; Function calculateDom
                            317 ; ---------------------------------
   447D                     318 _calculateDom::
   447D DD E5         [15]  319 	push	ix
   447F DD 21 00 00   [14]  320 	ld	ix,#0
   4483 DD 39         [15]  321 	add	ix,sp
   4485 21 ED FF      [10]  322 	ld	hl, #-19
   4488 39            [11]  323 	add	hl, sp
   4489 F9            [ 6]  324 	ld	sp, hl
                            325 ;src/IA.c:161: *grad = 0.0;
   448A DD 5E 07      [19]  326 	ld	e,7 (ix)
   448D DD 56 08      [19]  327 	ld	d,8 (ix)
   4490 6B            [ 4]  328 	ld	l, e
   4491 62            [ 4]  329 	ld	h, d
   4492 AF            [ 4]  330 	xor	a, a
   4493 77            [ 7]  331 	ld	(hl), a
   4494 23            [ 6]  332 	inc	hl
   4495 77            [ 7]  333 	ld	(hl), a
                            334 ;src/IA.c:162: if(c->tipo == 0){
   4496 DD 7E 04      [19]  335 	ld	a, 4 (ix)
   4499 DD 77 FC      [19]  336 	ld	-4 (ix), a
   449C DD 7E 05      [19]  337 	ld	a, 5 (ix)
   449F DD 77 FD      [19]  338 	ld	-3 (ix), a
   44A2 DD 6E FC      [19]  339 	ld	l,-4 (ix)
   44A5 DD 66 FD      [19]  340 	ld	h,-3 (ix)
   44A8 01 04 00      [10]  341 	ld	bc, #0x0004
   44AB 09            [11]  342 	add	hl, bc
   44AC 4E            [ 7]  343 	ld	c, (hl)
                            344 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   44AD DD 7E FC      [19]  345 	ld	a, -4 (ix)
   44B0 C6 09         [ 7]  346 	add	a, #0x09
   44B2 DD 77 FE      [19]  347 	ld	-2 (ix), a
   44B5 DD 7E FD      [19]  348 	ld	a, -3 (ix)
   44B8 CE 00         [ 7]  349 	adc	a, #0x00
   44BA DD 77 FF      [19]  350 	ld	-1 (ix), a
   44BD DD 7E FC      [19]  351 	ld	a, -4 (ix)
   44C0 C6 05         [ 7]  352 	add	a, #0x05
   44C2 DD 77 EF      [19]  353 	ld	-17 (ix), a
   44C5 DD 7E FD      [19]  354 	ld	a, -3 (ix)
   44C8 CE 00         [ 7]  355 	adc	a, #0x00
   44CA DD 77 F0      [19]  356 	ld	-16 (ix), a
   44CD DD 7E 06      [19]  357 	ld	a, 6 (ix)
   44D0 DD 77 FA      [19]  358 	ld	-6 (ix), a
   44D3 DD 36 FB 00   [19]  359 	ld	-5 (ix), #0x00
                            360 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   44D7 DD 7E FC      [19]  361 	ld	a, -4 (ix)
   44DA C6 07         [ 7]  362 	add	a, #0x07
   44DC DD 77 FC      [19]  363 	ld	-4 (ix), a
   44DF DD 7E FD      [19]  364 	ld	a, -3 (ix)
   44E2 CE 00         [ 7]  365 	adc	a, #0x00
   44E4 DD 77 FD      [19]  366 	ld	-3 (ix), a
                            367 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   44E7 DD 6E EF      [19]  368 	ld	l,-17 (ix)
   44EA DD 66 F0      [19]  369 	ld	h,-16 (ix)
   44ED 7E            [ 7]  370 	ld	a, (hl)
   44EE DD 77 F8      [19]  371 	ld	-8 (ix), a
   44F1 23            [ 6]  372 	inc	hl
   44F2 7E            [ 7]  373 	ld	a, (hl)
   44F3 DD 77 F9      [19]  374 	ld	-7 (ix), a
                            375 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   44F6 DD 7E 06      [19]  376 	ld	a, 6 (ix)
   44F9 DD 77 ED      [19]  377 	ld	-19 (ix), a
   44FC DD 36 EE 00   [19]  378 	ld	-18 (ix), #0x00
                            379 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4500 DD 6E FE      [19]  380 	ld	l,-2 (ix)
   4503 DD 66 FF      [19]  381 	ld	h,-1 (ix)
   4506 7E            [ 7]  382 	ld	a, (hl)
   4507 DD 77 F6      [19]  383 	ld	-10 (ix), a
   450A 23            [ 6]  384 	inc	hl
   450B 7E            [ 7]  385 	ld	a, (hl)
   450C DD 77 F7      [19]  386 	ld	-9 (ix), a
                            387 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            388 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   450F AF            [ 4]  389 	xor	a, a
   4510 DD 96 F6      [19]  390 	sub	a, -10 (ix)
   4513 6F            [ 4]  391 	ld	l, a
   4514 3E 00         [ 7]  392 	ld	a, #0x00
   4516 DD 9E F7      [19]  393 	sbc	a, -9 (ix)
   4519 67            [ 4]  394 	ld	h, a
   451A C5            [11]  395 	push	bc
   451B D5            [11]  396 	push	de
   451C E5            [11]  397 	push	hl
   451D 21 00 01      [10]  398 	ld	hl, #0x0100
   4520 E5            [11]  399 	push	hl
                            400 ;src/IA.c:162: if(c->tipo == 0){
   4521 CD 59 63      [17]  401 	call	__divuint
   4524 F1            [10]  402 	pop	af
   4525 F1            [10]  403 	pop	af
   4526 DD 74 F3      [19]  404 	ld	-13 (ix), h
   4529 DD 75 F2      [19]  405 	ld	-14 (ix), l
   452C D1            [10]  406 	pop	de
   452D C1            [10]  407 	pop	bc
   452E 79            [ 4]  408 	ld	a, c
   452F B7            [ 4]  409 	or	a, a
   4530 C2 54 46      [10]  410 	jp	NZ, 00138$
                            411 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   4533 DD 7E FA      [19]  412 	ld	a, -6 (ix)
   4536 DD 96 F8      [19]  413 	sub	a, -8 (ix)
   4539 20 0C         [12]  414 	jr	NZ,00214$
   453B DD 7E FB      [19]  415 	ld	a, -5 (ix)
   453E DD 96 F9      [19]  416 	sub	a, -7 (ix)
   4541 20 04         [12]  417 	jr	NZ,00214$
   4543 3E 01         [ 7]  418 	ld	a,#0x01
   4545 18 01         [12]  419 	jr	00215$
   4547                     420 00214$:
   4547 AF            [ 4]  421 	xor	a,a
   4548                     422 00215$:
   4548 47            [ 4]  423 	ld	b, a
   4549 DD 7E F7      [19]  424 	ld	a, -9 (ix)
   454C DD B6 F6      [19]  425 	or	a,-10 (ix)
   454F 20 04         [12]  426 	jr	NZ,00105$
   4551 78            [ 4]  427 	ld	a, b
   4552 B7            [ 4]  428 	or	a, a
   4553 20 10         [12]  429 	jr	NZ,00101$
   4555                     430 00105$:
                            431 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   4555 DD 6E FC      [19]  432 	ld	l,-4 (ix)
   4558 DD 66 FD      [19]  433 	ld	h,-3 (ix)
   455B 4E            [ 7]  434 	ld	c, (hl)
   455C 23            [ 6]  435 	inc	hl
   455D 66            [ 7]  436 	ld	h, (hl)
   455E 7C            [ 4]  437 	ld	a, h
   455F B1            [ 4]  438 	or	a,c
   4560 20 0D         [12]  439 	jr	NZ,00102$
   4562 B0            [ 4]  440 	or	a,b
   4563 28 0A         [12]  441 	jr	Z,00102$
   4565                     442 00101$:
                            443 ;src/IA.c:167: *grad = SCALA;
   4565 3E 00         [ 7]  444 	ld	a, #0x00
   4567 12            [ 7]  445 	ld	(de), a
   4568 13            [ 6]  446 	inc	de
   4569 3E 01         [ 7]  447 	ld	a, #0x01
   456B 12            [ 7]  448 	ld	(de), a
                            449 ;src/IA.c:168: return;
   456C C3 9E 47      [10]  450 	jp	00140$
   456F                     451 00102$:
                            452 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   456F DD 7E F8      [19]  453 	ld	a, -8 (ix)
   4572 DD 96 FA      [19]  454 	sub	a, -6 (ix)
   4575 DD 7E F9      [19]  455 	ld	a, -7 (ix)
   4578 DD 9E FB      [19]  456 	sbc	a, -5 (ix)
   457B 3E 00         [ 7]  457 	ld	a, #0x00
   457D 17            [ 4]  458 	rla
   457E DD 77 F1      [19]  459 	ld	-15 (ix), a
   4581 DD CB F1 46   [20]  460 	bit	0, -15 (ix)
   4585 20 68         [12]  461 	jr	NZ,00111$
   4587 DD 7E F8      [19]  462 	ld	a, -8 (ix)
   458A 91            [ 4]  463 	sub	a, c
   458B 47            [ 4]  464 	ld	b, a
   458C DD 7E F9      [19]  465 	ld	a, -7 (ix)
   458F 9C            [ 4]  466 	sbc	a, h
   4590 6F            [ 4]  467 	ld	l, a
   4591 DD 7E FA      [19]  468 	ld	a, -6 (ix)
   4594 90            [ 4]  469 	sub	a, b
   4595 DD 7E FB      [19]  470 	ld	a, -5 (ix)
   4598 9D            [ 4]  471 	sbc	a, l
   4599 38 54         [12]  472 	jr	C,00111$
                            473 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   459B D5            [11]  474 	push	de
   459C 69            [ 4]  475 	ld	l, c
   459D E5            [11]  476 	push	hl
   459E 21 00 01      [10]  477 	ld	hl, #0x0100
   45A1 E5            [11]  478 	push	hl
   45A2 CD 59 63      [17]  479 	call	__divuint
   45A5 F1            [10]  480 	pop	af
   45A6 F1            [10]  481 	pop	af
   45A7 4D            [ 4]  482 	ld	c, l
   45A8 44            [ 4]  483 	ld	b, h
   45A9 D1            [10]  484 	pop	de
   45AA 6B            [ 4]  485 	ld	l, e
   45AB 62            [ 4]  486 	ld	h, d
   45AC 71            [ 7]  487 	ld	(hl), c
   45AD 23            [ 6]  488 	inc	hl
   45AE 70            [ 7]  489 	ld	(hl), b
                            490 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   45AF DD 6E EF      [19]  491 	ld	l,-17 (ix)
   45B2 DD 66 F0      [19]  492 	ld	h,-16 (ix)
   45B5 7E            [ 7]  493 	ld	a, (hl)
   45B6 DD 77 F4      [19]  494 	ld	-12 (ix), a
   45B9 23            [ 6]  495 	inc	hl
   45BA 7E            [ 7]  496 	ld	a, (hl)
   45BB DD 77 F5      [19]  497 	ld	-11 (ix), a
   45BE DD 6E FC      [19]  498 	ld	l,-4 (ix)
   45C1 DD 66 FD      [19]  499 	ld	h,-3 (ix)
   45C4 7E            [ 7]  500 	ld	a, (hl)
   45C5 23            [ 6]  501 	inc	hl
   45C6 66            [ 7]  502 	ld	h, (hl)
   45C7 6F            [ 4]  503 	ld	l, a
   45C8 DD 7E F4      [19]  504 	ld	a, -12 (ix)
   45CB 95            [ 4]  505 	sub	a, l
   45CC 6F            [ 4]  506 	ld	l, a
   45CD DD 7E F5      [19]  507 	ld	a, -11 (ix)
   45D0 9C            [ 4]  508 	sbc	a, h
   45D1 67            [ 4]  509 	ld	h, a
   45D2 DD 7E ED      [19]  510 	ld	a, -19 (ix)
   45D5 95            [ 4]  511 	sub	a, l
   45D6 6F            [ 4]  512 	ld	l, a
   45D7 DD 7E EE      [19]  513 	ld	a, -18 (ix)
   45DA 9C            [ 4]  514 	sbc	a, h
   45DB 67            [ 4]  515 	ld	h, a
   45DC D5            [11]  516 	push	de
   45DD E5            [11]  517 	push	hl
   45DE C5            [11]  518 	push	bc
   45DF CD 1B 6D      [17]  519 	call	__mulint
   45E2 F1            [10]  520 	pop	af
   45E3 F1            [10]  521 	pop	af
   45E4 4D            [ 4]  522 	ld	c, l
   45E5 44            [ 4]  523 	ld	b, h
   45E6 D1            [10]  524 	pop	de
   45E7 79            [ 4]  525 	ld	a, c
   45E8 12            [ 7]  526 	ld	(de), a
   45E9 13            [ 6]  527 	inc	de
   45EA 78            [ 4]  528 	ld	a, b
   45EB 12            [ 7]  529 	ld	(de), a
                            530 ;src/IA.c:175: return;
   45EC C3 9E 47      [10]  531 	jp	00140$
   45EF                     532 00111$:
                            533 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   45EF DD CB F1 46   [20]  534 	bit	0, -15 (ix)
   45F3 28 55         [12]  535 	jr	Z,00107$
   45F5 DD 7E F8      [19]  536 	ld	a, -8 (ix)
   45F8 DD 86 F6      [19]  537 	add	a, -10 (ix)
   45FB 4F            [ 4]  538 	ld	c, a
   45FC DD 7E F9      [19]  539 	ld	a, -7 (ix)
   45FF DD 8E F7      [19]  540 	adc	a, -9 (ix)
   4602 47            [ 4]  541 	ld	b, a
   4603 DD 7E FA      [19]  542 	ld	a, -6 (ix)
   4606 91            [ 4]  543 	sub	a, c
   4607 DD 7E FB      [19]  544 	ld	a, -5 (ix)
   460A 98            [ 4]  545 	sbc	a, b
   460B 30 3D         [12]  546 	jr	NC,00107$
                            547 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   460D 6B            [ 4]  548 	ld	l, e
   460E 62            [ 4]  549 	ld	h, d
   460F DD 7E F2      [19]  550 	ld	a, -14 (ix)
   4612 77            [ 7]  551 	ld	(hl), a
   4613 23            [ 6]  552 	inc	hl
   4614 DD 7E F3      [19]  553 	ld	a, -13 (ix)
   4617 77            [ 7]  554 	ld	(hl), a
                            555 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   4618 DD 6E EF      [19]  556 	ld	l,-17 (ix)
   461B DD 66 F0      [19]  557 	ld	h,-16 (ix)
   461E 4E            [ 7]  558 	ld	c, (hl)
   461F 23            [ 6]  559 	inc	hl
   4620 46            [ 7]  560 	ld	b, (hl)
   4621 DD 7E ED      [19]  561 	ld	a, -19 (ix)
   4624 91            [ 4]  562 	sub	a, c
   4625 4F            [ 4]  563 	ld	c, a
   4626 DD 7E EE      [19]  564 	ld	a, -18 (ix)
   4629 98            [ 4]  565 	sbc	a, b
   462A 47            [ 4]  566 	ld	b, a
   462B D5            [11]  567 	push	de
   462C C5            [11]  568 	push	bc
   462D DD 6E F2      [19]  569 	ld	l,-14 (ix)
   4630 DD 66 F3      [19]  570 	ld	h,-13 (ix)
   4633 E5            [11]  571 	push	hl
   4634 CD 1B 6D      [17]  572 	call	__mulint
   4637 F1            [10]  573 	pop	af
   4638 F1            [10]  574 	pop	af
   4639 4D            [ 4]  575 	ld	c, l
   463A 44            [ 4]  576 	ld	b, h
   463B D1            [10]  577 	pop	de
   463C 21 00 01      [10]  578 	ld	hl, #0x0100
   463F 09            [11]  579 	add	hl,bc
   4640 4D            [ 4]  580 	ld	c, l
   4641 44            [ 4]  581 	ld	b, h
   4642 79            [ 4]  582 	ld	a, c
   4643 12            [ 7]  583 	ld	(de), a
   4644 13            [ 6]  584 	inc	de
   4645 78            [ 4]  585 	ld	a, b
   4646 12            [ 7]  586 	ld	(de), a
                            587 ;src/IA.c:180: return;
   4647 C3 9E 47      [10]  588 	jp	00140$
   464A                     589 00107$:
                            590 ;src/IA.c:183: *grad = 0;
   464A 3E 00         [ 7]  591 	ld	a, #0x00
   464C 12            [ 7]  592 	ld	(de), a
   464D 13            [ 6]  593 	inc	de
   464E 3E 00         [ 7]  594 	ld	a, #0x00
   4650 12            [ 7]  595 	ld	(de), a
                            596 ;src/IA.c:184: return;
   4651 C3 9E 47      [10]  597 	jp	00140$
   4654                     598 00138$:
                            599 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4654 DD 6E F8      [19]  600 	ld	l, -8 (ix)
   4657 DD 7E F6      [19]  601 	ld	a, -10 (ix)
   465A DD 77 F4      [19]  602 	ld	-12 (ix), a
   465D 7D            [ 4]  603 	ld	a, l
   465E DD 86 F4      [19]  604 	add	a, -12 (ix)
   4661 DD 96 F4      [19]  605 	sub	a, -12 (ix)
   4664 47            [ 4]  606 	ld	b, a
                            607 ;src/IA.c:187: }else if(c->tipo == 1)
   4665 0D            [ 4]  608 	dec	c
   4666 C2 F6 46      [10]  609 	jp	NZ,00135$
                            610 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4669 48            [ 4]  611 	ld	c, b
                            612 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   466A DD 7E F7      [19]  613 	ld	a, -9 (ix)
   466D DD B6 F6      [19]  614 	or	a,-10 (ix)
   4670 20 0E         [12]  615 	jr	NZ,00115$
   4672 DD 7E 06      [19]  616 	ld	a, 6 (ix)
                            617 ;src/IA.c:193: *grad = SCALA;
   4675 91            [ 4]  618 	sub	a,c
   4676 20 08         [12]  619 	jr	NZ,00115$
   4678 12            [ 7]  620 	ld	(de), a
   4679 13            [ 6]  621 	inc	de
   467A 3E 01         [ 7]  622 	ld	a, #0x01
   467C 12            [ 7]  623 	ld	(de), a
                            624 ;src/IA.c:194: return;
   467D C3 9E 47      [10]  625 	jp	00140$
   4680                     626 00115$:
                            627 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   4680 DD 7E 06      [19]  628 	ld	a, 6 (ix)
   4683 91            [ 4]  629 	sub	a, c
   4684 3E 00         [ 7]  630 	ld	a, #0x00
   4686 17            [ 4]  631 	rla
   4687 DD 77 F4      [19]  632 	ld	-12 (ix), a
   468A DD CB F4 46   [20]  633 	bit	0, -12 (ix)
   468E 20 4C         [12]  634 	jr	NZ,00121$
   4690 06 00         [ 7]  635 	ld	b, #0x00
   4692 DD 6E F6      [19]  636 	ld	l,-10 (ix)
   4695 DD 66 F7      [19]  637 	ld	h,-9 (ix)
   4698 09            [11]  638 	add	hl, bc
   4699 DD 7E FA      [19]  639 	ld	a, -6 (ix)
   469C 95            [ 4]  640 	sub	a, l
   469D DD 7E FB      [19]  641 	ld	a, -5 (ix)
   46A0 9C            [ 4]  642 	sbc	a, h
   46A1 30 39         [12]  643 	jr	NC,00121$
                            644 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   46A3 6B            [ 4]  645 	ld	l, e
   46A4 62            [ 4]  646 	ld	h, d
   46A5 DD 7E F2      [19]  647 	ld	a, -14 (ix)
   46A8 77            [ 7]  648 	ld	(hl), a
   46A9 23            [ 6]  649 	inc	hl
   46AA DD 7E F3      [19]  650 	ld	a, -13 (ix)
   46AD 77            [ 7]  651 	ld	(hl), a
                            652 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   46AE DD 6E FE      [19]  653 	ld	l,-2 (ix)
   46B1 DD 66 FF      [19]  654 	ld	h,-1 (ix)
   46B4 7E            [ 7]  655 	ld	a, (hl)
   46B5 23            [ 6]  656 	inc	hl
   46B6 66            [ 7]  657 	ld	h, (hl)
   46B7 6F            [ 4]  658 	ld	l, a
   46B8 09            [11]  659 	add	hl, bc
   46B9 DD 7E ED      [19]  660 	ld	a, -19 (ix)
   46BC 95            [ 4]  661 	sub	a, l
   46BD 4F            [ 4]  662 	ld	c, a
   46BE DD 7E EE      [19]  663 	ld	a, -18 (ix)
   46C1 9C            [ 4]  664 	sbc	a, h
   46C2 47            [ 4]  665 	ld	b, a
   46C3 D5            [11]  666 	push	de
   46C4 C5            [11]  667 	push	bc
   46C5 DD 6E F2      [19]  668 	ld	l,-14 (ix)
   46C8 DD 66 F3      [19]  669 	ld	h,-13 (ix)
   46CB E5            [11]  670 	push	hl
   46CC CD 1B 6D      [17]  671 	call	__mulint
   46CF F1            [10]  672 	pop	af
   46D0 F1            [10]  673 	pop	af
   46D1 4D            [ 4]  674 	ld	c, l
   46D2 44            [ 4]  675 	ld	b, h
   46D3 D1            [10]  676 	pop	de
   46D4 79            [ 4]  677 	ld	a, c
   46D5 12            [ 7]  678 	ld	(de), a
   46D6 13            [ 6]  679 	inc	de
   46D7 78            [ 4]  680 	ld	a, b
   46D8 12            [ 7]  681 	ld	(de), a
                            682 ;src/IA.c:201: return;
   46D9 C3 9E 47      [10]  683 	jp	00140$
   46DC                     684 00121$:
                            685 ;src/IA.c:202: }else if(val < midPoint)
   46DC DD CB F4 46   [20]  686 	bit	0, -12 (ix)
   46E0 28 0A         [12]  687 	jr	Z,00118$
                            688 ;src/IA.c:204: *grad = SCALA;
   46E2 3E 00         [ 7]  689 	ld	a, #0x00
   46E4 12            [ 7]  690 	ld	(de), a
   46E5 13            [ 6]  691 	inc	de
   46E6 3E 01         [ 7]  692 	ld	a, #0x01
   46E8 12            [ 7]  693 	ld	(de), a
                            694 ;src/IA.c:205: return;
   46E9 C3 9E 47      [10]  695 	jp	00140$
   46EC                     696 00118$:
                            697 ;src/IA.c:207: *grad = 0;
   46EC 3E 00         [ 7]  698 	ld	a, #0x00
   46EE 12            [ 7]  699 	ld	(de), a
   46EF 13            [ 6]  700 	inc	de
   46F0 3E 00         [ 7]  701 	ld	a, #0x00
   46F2 12            [ 7]  702 	ld	(de), a
                            703 ;src/IA.c:208: return;
   46F3 C3 9E 47      [10]  704 	jp	00140$
   46F6                     705 00135$:
                            706 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            707 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   46F6 DD 6E FC      [19]  708 	ld	l,-4 (ix)
   46F9 DD 66 FD      [19]  709 	ld	h,-3 (ix)
   46FC 4E            [ 7]  710 	ld	c, (hl)
   46FD 23            [ 6]  711 	inc	hl
   46FE 7E            [ 7]  712 	ld	a, (hl)
   46FF B1            [ 4]  713 	or	a,c
   4700 20 0D         [12]  714 	jr	NZ,00125$
   4702 DD 7E 06      [19]  715 	ld	a, 6 (ix)
   4705 90            [ 4]  716 	sub	a, b
   4706 20 07         [12]  717 	jr	NZ,00125$
                            718 ;src/IA.c:215: *grad = SCALA;
   4708 6B            [ 4]  719 	ld	l, e
   4709 62            [ 4]  720 	ld	h, d
   470A 36 00         [10]  721 	ld	(hl), #0x00
   470C 23            [ 6]  722 	inc	hl
   470D 36 01         [10]  723 	ld	(hl), #0x01
   470F                     724 00125$:
                            725 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   470F 78            [ 4]  726 	ld	a, b
   4710 DD 96 06      [19]  727 	sub	a, 6 (ix)
   4713 3E 00         [ 7]  728 	ld	a, #0x00
   4715 17            [ 4]  729 	rla
   4716 DD 77 F4      [19]  730 	ld	-12 (ix), a
   4719 DD CB F4 46   [20]  731 	bit	0, -12 (ix)
   471D 20 69         [12]  732 	jr	NZ,00131$
   471F 0E 00         [ 7]  733 	ld	c, #0x00
   4721 DD 6E FC      [19]  734 	ld	l,-4 (ix)
   4724 DD 66 FD      [19]  735 	ld	h,-3 (ix)
   4727 7E            [ 7]  736 	ld	a, (hl)
   4728 23            [ 6]  737 	inc	hl
   4729 66            [ 7]  738 	ld	h, (hl)
   472A 6F            [ 4]  739 	ld	l, a
   472B DD 70 F2      [19]  740 	ld	-14 (ix), b
   472E DD 71 F3      [19]  741 	ld	-13 (ix), c
   4731 DD 7E F2      [19]  742 	ld	a, -14 (ix)
   4734 95            [ 4]  743 	sub	a, l
   4735 4F            [ 4]  744 	ld	c, a
   4736 DD 7E F3      [19]  745 	ld	a, -13 (ix)
   4739 9C            [ 4]  746 	sbc	a, h
   473A 47            [ 4]  747 	ld	b, a
   473B 79            [ 4]  748 	ld	a, c
   473C DD 96 FA      [19]  749 	sub	a, -6 (ix)
   473F 78            [ 4]  750 	ld	a, b
   4740 DD 9E FB      [19]  751 	sbc	a, -5 (ix)
   4743 30 43         [12]  752 	jr	NC,00131$
                            753 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   4745 D5            [11]  754 	push	de
   4746 E5            [11]  755 	push	hl
   4747 21 00 01      [10]  756 	ld	hl, #0x0100
   474A E5            [11]  757 	push	hl
   474B CD 59 63      [17]  758 	call	__divuint
   474E F1            [10]  759 	pop	af
   474F F1            [10]  760 	pop	af
   4750 4D            [ 4]  761 	ld	c, l
   4751 44            [ 4]  762 	ld	b, h
   4752 D1            [10]  763 	pop	de
   4753 6B            [ 4]  764 	ld	l, e
   4754 62            [ 4]  765 	ld	h, d
   4755 71            [ 7]  766 	ld	(hl), c
   4756 23            [ 6]  767 	inc	hl
   4757 70            [ 7]  768 	ld	(hl), b
                            769 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   4758 DD 6E FC      [19]  770 	ld	l,-4 (ix)
   475B DD 66 FD      [19]  771 	ld	h,-3 (ix)
   475E 7E            [ 7]  772 	ld	a, (hl)
   475F 23            [ 6]  773 	inc	hl
   4760 66            [ 7]  774 	ld	h, (hl)
   4761 6F            [ 4]  775 	ld	l, a
   4762 DD 7E F2      [19]  776 	ld	a, -14 (ix)
   4765 95            [ 4]  777 	sub	a, l
   4766 6F            [ 4]  778 	ld	l, a
   4767 DD 7E F3      [19]  779 	ld	a, -13 (ix)
   476A 9C            [ 4]  780 	sbc	a, h
   476B 67            [ 4]  781 	ld	h, a
   476C DD 7E ED      [19]  782 	ld	a, -19 (ix)
   476F 95            [ 4]  783 	sub	a, l
   4770 6F            [ 4]  784 	ld	l, a
   4771 DD 7E EE      [19]  785 	ld	a, -18 (ix)
   4774 9C            [ 4]  786 	sbc	a, h
   4775 67            [ 4]  787 	ld	h, a
   4776 D5            [11]  788 	push	de
   4777 E5            [11]  789 	push	hl
   4778 C5            [11]  790 	push	bc
   4779 CD 1B 6D      [17]  791 	call	__mulint
   477C F1            [10]  792 	pop	af
   477D F1            [10]  793 	pop	af
   477E 4D            [ 4]  794 	ld	c, l
   477F 44            [ 4]  795 	ld	b, h
   4780 D1            [10]  796 	pop	de
   4781 79            [ 4]  797 	ld	a, c
   4782 12            [ 7]  798 	ld	(de), a
   4783 13            [ 6]  799 	inc	de
   4784 78            [ 4]  800 	ld	a, b
   4785 12            [ 7]  801 	ld	(de), a
   4786 18 16         [12]  802 	jr	00140$
   4788                     803 00131$:
                            804 ;src/IA.c:220: }else if(val > midPoint)
   4788 DD CB F4 46   [20]  805 	bit	0, -12 (ix)
   478C 28 09         [12]  806 	jr	Z,00128$
                            807 ;src/IA.c:223: *grad = SCALA;
   478E 3E 00         [ 7]  808 	ld	a, #0x00
   4790 12            [ 7]  809 	ld	(de), a
   4791 13            [ 6]  810 	inc	de
   4792 3E 01         [ 7]  811 	ld	a, #0x01
   4794 12            [ 7]  812 	ld	(de), a
   4795 18 07         [12]  813 	jr	00140$
   4797                     814 00128$:
                            815 ;src/IA.c:225: *grad = 0;
   4797 3E 00         [ 7]  816 	ld	a, #0x00
   4799 12            [ 7]  817 	ld	(de), a
   479A 13            [ 6]  818 	inc	de
   479B 3E 00         [ 7]  819 	ld	a, #0x00
   479D 12            [ 7]  820 	ld	(de), a
   479E                     821 00140$:
   479E DD F9         [10]  822 	ld	sp, ix
   47A0 DD E1         [14]  823 	pop	ix
   47A2 C9            [10]  824 	ret
                            825 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            826 ;	---------------------------------
                            827 ; Function defuzzi
                            828 ; ---------------------------------
   47A3                     829 _defuzzi::
   47A3 DD E5         [15]  830 	push	ix
   47A5 DD 21 00 00   [14]  831 	ld	ix,#0
   47A9 DD 39         [15]  832 	add	ix,sp
   47AB 21 EF FF      [10]  833 	ld	hl, #-17
   47AE 39            [11]  834 	add	hl, sp
   47AF F9            [ 6]  835 	ld	sp, hl
                            836 ;src/IA.c:239: *re = 0;
   47B0 DD 7E 08      [19]  837 	ld	a, 8 (ix)
   47B3 DD 77 FC      [19]  838 	ld	-4 (ix), a
   47B6 DD 7E 09      [19]  839 	ld	a, 9 (ix)
   47B9 DD 77 FD      [19]  840 	ld	-3 (ix), a
   47BC DD 6E FC      [19]  841 	ld	l,-4 (ix)
   47BF DD 66 FD      [19]  842 	ld	h,-3 (ix)
   47C2 AF            [ 4]  843 	xor	a, a
   47C3 77            [ 7]  844 	ld	(hl), a
   47C4 23            [ 6]  845 	inc	hl
   47C5 77            [ 7]  846 	ld	(hl), a
                            847 ;src/IA.c:241: while(i < 3)
   47C6 21 01 00      [10]  848 	ld	hl, #0x0001
   47C9 39            [11]  849 	add	hl, sp
   47CA DD 75 FE      [19]  850 	ld	-2 (ix), l
   47CD DD 74 FF      [19]  851 	ld	-1 (ix), h
   47D0 0E 00         [ 7]  852 	ld	c, #0x00
   47D2                     853 00101$:
   47D2 79            [ 4]  854 	ld	a, c
   47D3 D6 03         [ 7]  855 	sub	a, #0x03
   47D5 30 53         [12]  856 	jr	NC,00103$
                            857 ;src/IA.c:243: dom = 0;
   47D7 DD 36 F6 00   [19]  858 	ld	-10 (ix), #0x00
   47DB DD 36 F7 00   [19]  859 	ld	-9 (ix), #0x00
                            860 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   47DF 21 07 00      [10]  861 	ld	hl, #0x0007
   47E2 39            [11]  862 	add	hl, sp
   47E3 DD 75 FA      [19]  863 	ld	-6 (ix), l
   47E6 DD 74 FB      [19]  864 	ld	-5 (ix), h
   47E9 DD 46 04      [19]  865 	ld	b, 4 (ix)
   47EC 69            [ 4]  866 	ld	l, c
   47ED 26 00         [ 7]  867 	ld	h, #0x00
   47EF 29            [11]  868 	add	hl, hl
   47F0 EB            [ 4]  869 	ex	de,hl
   47F1 21 CF 6F      [10]  870 	ld	hl, #_fmems
   47F4 19            [11]  871 	add	hl, de
   47F5 7E            [ 7]  872 	ld	a, (hl)
   47F6 DD 77 F8      [19]  873 	ld	-8 (ix), a
   47F9 23            [ 6]  874 	inc	hl
   47FA 7E            [ 7]  875 	ld	a, (hl)
   47FB DD 77 F9      [19]  876 	ld	-7 (ix), a
   47FE C5            [11]  877 	push	bc
   47FF D5            [11]  878 	push	de
   4800 DD 6E FA      [19]  879 	ld	l,-6 (ix)
   4803 DD 66 FB      [19]  880 	ld	h,-5 (ix)
   4806 E5            [11]  881 	push	hl
   4807 C5            [11]  882 	push	bc
   4808 33            [ 6]  883 	inc	sp
   4809 DD 6E F8      [19]  884 	ld	l,-8 (ix)
   480C DD 66 F9      [19]  885 	ld	h,-7 (ix)
   480F E5            [11]  886 	push	hl
   4810 CD 7D 44      [17]  887 	call	_calculateDom
   4813 F1            [10]  888 	pop	af
   4814 F1            [10]  889 	pop	af
   4815 33            [ 6]  890 	inc	sp
   4816 D1            [10]  891 	pop	de
   4817 C1            [10]  892 	pop	bc
                            893 ;src/IA.c:245: vDom[i] = dom/SCALA;
   4818 DD 6E FE      [19]  894 	ld	l,-2 (ix)
   481B DD 66 FF      [19]  895 	ld	h,-1 (ix)
   481E 19            [11]  896 	add	hl, de
   481F DD 5E F7      [19]  897 	ld	e, -9 (ix)
   4822 06 00         [ 7]  898 	ld	b, #0x00
   4824 73            [ 7]  899 	ld	(hl), e
   4825 23            [ 6]  900 	inc	hl
   4826 70            [ 7]  901 	ld	(hl), b
                            902 ;src/IA.c:246: i++;
   4827 0C            [ 4]  903 	inc	c
   4828 18 A8         [12]  904 	jr	00101$
   482A                     905 00103$:
                            906 ;src/IA.c:250: for(i = 0; i<3; i++)
   482A DD 7E FE      [19]  907 	ld	a, -2 (ix)
   482D DD 77 F8      [19]  908 	ld	-8 (ix), a
   4830 DD 7E FF      [19]  909 	ld	a, -1 (ix)
   4833 DD 77 F9      [19]  910 	ld	-7 (ix), a
   4836 DD 36 EF 00   [19]  911 	ld	-17 (ix), #0x00
   483A                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   483A DD 6E EF      [19]  914 	ld	l, -17 (ix)
   483D 26 00         [ 7]  915 	ld	h, #0x00
   483F 29            [11]  916 	add	hl, hl
   4840 4D            [ 4]  917 	ld	c, l
   4841 44            [ 4]  918 	ld	b, h
   4842 DD 6E F8      [19]  919 	ld	l,-8 (ix)
   4845 DD 66 F9      [19]  920 	ld	h,-7 (ix)
   4848 09            [11]  921 	add	hl, bc
   4849 5E            [ 7]  922 	ld	e, (hl)
   484A 23            [ 6]  923 	inc	hl
   484B 56            [ 7]  924 	ld	d, (hl)
   484C 21 BD 6F      [10]  925 	ld	hl, #_aceleracion
   484F 09            [11]  926 	add	hl, bc
   4850 4E            [ 7]  927 	ld	c, (hl)
   4851 23            [ 6]  928 	inc	hl
   4852 46            [ 7]  929 	ld	b, (hl)
   4853 C5            [11]  930 	push	bc
   4854 D5            [11]  931 	push	de
   4855 CD 1B 6D      [17]  932 	call	__mulint
   4858 F1            [10]  933 	pop	af
   4859 F1            [10]  934 	pop	af
   485A 4D            [ 4]  935 	ld	c, l
   485B 44            [ 4]  936 	ld	b, h
   485C DD 6E FC      [19]  937 	ld	l,-4 (ix)
   485F DD 66 FD      [19]  938 	ld	h,-3 (ix)
   4862 5E            [ 7]  939 	ld	e, (hl)
   4863 23            [ 6]  940 	inc	hl
   4864 66            [ 7]  941 	ld	h, (hl)
   4865 6B            [ 4]  942 	ld	l, e
   4866 09            [11]  943 	add	hl,bc
   4867 4D            [ 4]  944 	ld	c, l
   4868 44            [ 4]  945 	ld	b, h
   4869 DD 6E FC      [19]  946 	ld	l,-4 (ix)
   486C DD 66 FD      [19]  947 	ld	h,-3 (ix)
   486F 71            [ 7]  948 	ld	(hl), c
   4870 23            [ 6]  949 	inc	hl
   4871 70            [ 7]  950 	ld	(hl), b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   4872 DD 34 EF      [23]  952 	inc	-17 (ix)
   4875 DD 7E EF      [19]  953 	ld	a, -17 (ix)
   4878 D6 03         [ 7]  954 	sub	a, #0x03
   487A 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   487C DD 6E 06      [19]  957 	ld	l,6 (ix)
   487F DD 66 07      [19]  958 	ld	h,7 (ix)
   4882 23            [ 6]  959 	inc	hl
   4883 7E            [ 7]  960 	ld	a, (hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   4884 DD 6E FC      [19]  962 	ld	l,-4 (ix)
   4887 DD 66 FD      [19]  963 	ld	h,-3 (ix)
   488A 5E            [ 7]  964 	ld	e, (hl)
   488B 23            [ 6]  965 	inc	hl
   488C 56            [ 7]  966 	ld	d, (hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   488D B7            [ 4]  968 	or	a, a
   488E 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   4890 DD 6E FC      [19]  971 	ld	l,-4 (ix)
   4893 DD 66 FD      [19]  972 	ld	h,-3 (ix)
   4896 73            [ 7]  973 	ld	(hl), e
   4897 23            [ 6]  974 	inc	hl
   4898 72            [ 7]  975 	ld	(hl), d
   4899 18 10         [12]  976 	jr	00110$
   489B                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   489B AF            [ 4]  979 	xor	a, a
   489C 93            [ 4]  980 	sub	a, e
   489D 5F            [ 4]  981 	ld	e, a
   489E 3E 00         [ 7]  982 	ld	a, #0x00
   48A0 9A            [ 4]  983 	sbc	a, d
   48A1 4F            [ 4]  984 	ld	c, a
   48A2 DD 6E FC      [19]  985 	ld	l,-4 (ix)
   48A5 DD 66 FD      [19]  986 	ld	h,-3 (ix)
   48A8 73            [ 7]  987 	ld	(hl), e
   48A9 23            [ 6]  988 	inc	hl
   48AA 71            [ 7]  989 	ld	(hl), c
   48AB                     990 00110$:
   48AB DD F9         [10]  991 	ld	sp, ix
   48AD DD E1         [14]  992 	pop	ix
   48AF C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   48B0                     998 _calcule::
   48B0 DD E5         [15]  999 	push	ix
   48B2 DD 21 00 00   [14] 1000 	ld	ix,#0
   48B6 DD 39         [15] 1001 	add	ix,sp
   48B8 F5            [11] 1002 	push	af
   48B9 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   48BA DD 36 FE 00   [19] 1005 	ld	-2 (ix), #0x00
   48BE DD 36 FF 00   [19] 1006 	ld	-1 (ix), #0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   48C2 DD 36 FD 00   [19] 1008 	ld	-3 (ix), #0x00
   48C6                    1009 00103$:
   48C6 DD 7E FD      [19] 1010 	ld	a, -3 (ix)
   48C9 DD 96 04      [19] 1011 	sub	a, 4 (ix)
   48CC 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   48CE FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   48D2 FD 39         [15] 1015 	add	iy,sp
   48D4 DD 6E FD      [19] 1016 	ld	l, -3 (ix)
   48D7 26 00         [ 7] 1017 	ld	h, #0x00
   48D9 29            [11] 1018 	add	hl, hl
   48DA 01 C3 6F      [10] 1019 	ld	bc,#_vRulesx
   48DD 09            [11] 1020 	add	hl,bc
   48DE 4D            [ 4] 1021 	ld	c,l
   48DF 44            [ 4] 1022 	ld	b,h
   48E0 7E            [ 7] 1023 	ld	a, (hl)
   48E1 23            [ 6] 1024 	inc	hl
   48E2 66            [ 7] 1025 	ld	h, (hl)
   48E3 6F            [ 4] 1026 	ld	l, a
   48E4 5E            [ 7] 1027 	ld	e, (hl)
   48E5 23            [ 6] 1028 	inc	hl
   48E6 56            [ 7] 1029 	ld	d, (hl)
   48E7 C5            [11] 1030 	push	bc
   48E8 FD E5         [15] 1031 	push	iy
   48EA DD 7E 05      [19] 1032 	ld	a, 5 (ix)
   48ED F5            [11] 1033 	push	af
   48EE 33            [ 6] 1034 	inc	sp
   48EF D5            [11] 1035 	push	de
   48F0 CD 7D 44      [17] 1036 	call	_calculateDom
   48F3 F1            [10] 1037 	pop	af
   48F4 F1            [10] 1038 	pop	af
   48F5 33            [ 6] 1039 	inc	sp
   48F6 C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   48F7 DD 5E 06      [19] 1042 	ld	e,6 (ix)
   48FA DD 56 07      [19] 1043 	ld	d,7 (ix)
   48FD 69            [ 4] 1044 	ld	l, c
   48FE 60            [ 4] 1045 	ld	h, b
   48FF 7E            [ 7] 1046 	ld	a, (hl)
   4900 23            [ 6] 1047 	inc	hl
   4901 66            [ 7] 1048 	ld	h, (hl)
   4902 6F            [ 4] 1049 	ld	l, a
   4903 23            [ 6] 1050 	inc	hl
   4904 23            [ 6] 1051 	inc	hl
   4905 7E            [ 7] 1052 	ld	a, (hl)
   4906 23            [ 6] 1053 	inc	hl
   4907 66            [ 7] 1054 	ld	h, (hl)
   4908 6F            [ 4] 1055 	ld	l, a
   4909 23            [ 6] 1056 	inc	hl
   490A 23            [ 6] 1057 	inc	hl
   490B 4E            [ 7] 1058 	ld	c, (hl)
   490C 23            [ 6] 1059 	inc	hl
   490D 46            [ 7] 1060 	ld	b, (hl)
   490E D5            [11] 1061 	push	de
   490F DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   4912 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   4915 E5            [11] 1064 	push	hl
   4916 C5            [11] 1065 	push	bc
   4917 CD 1B 6D      [17] 1066 	call	__mulint
   491A F1            [10] 1067 	pop	af
   491B F1            [10] 1068 	pop	af
   491C 4D            [ 4] 1069 	ld	c, l
   491D 44            [ 4] 1070 	ld	b, h
   491E D1            [10] 1071 	pop	de
   491F 6B            [ 4] 1072 	ld	l, e
   4920 62            [ 4] 1073 	ld	h, d
   4921 7E            [ 7] 1074 	ld	a, (hl)
   4922 23            [ 6] 1075 	inc	hl
   4923 66            [ 7] 1076 	ld	h, (hl)
   4924 6F            [ 4] 1077 	ld	l, a
   4925 09            [11] 1078 	add	hl, bc
   4926 4C            [ 4] 1079 	ld	c, h
   4927 06 00         [ 7] 1080 	ld	b, #0x00
   4929 79            [ 4] 1081 	ld	a, c
   492A 12            [ 7] 1082 	ld	(de), a
   492B 13            [ 6] 1083 	inc	de
   492C 78            [ 4] 1084 	ld	a, b
   492D 12            [ 7] 1085 	ld	(de), a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   492E DD 34 FD      [23] 1087 	inc	-3 (ix)
   4931 18 93         [12] 1088 	jr	00103$
   4933                    1089 00105$:
   4933 DD F9         [10] 1090 	ld	sp, ix
   4935 DD E1         [14] 1091 	pop	ix
   4937 C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   4938                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   4938 21 04 00      [10] 1099 	ld	hl, #4
   493B 39            [11] 1100 	add	hl, sp
   493C 4E            [ 7] 1101 	ld	c, (hl)
   493D 23            [ 6] 1102 	inc	hl
   493E 46            [ 7] 1103 	ld	b, (hl)
   493F 59            [ 4] 1104 	ld	e, c
   4940 50            [ 4] 1105 	ld	d, b
   4941 13            [ 6] 1106 	inc	de
   4942 AF            [ 4] 1107 	xor	a, a
   4943 12            [ 7] 1108 	ld	(de), a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   4944 AF            [ 4] 1110 	xor	a, a
   4945 02            [ 7] 1111 	ld	(bc), a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   4946 21 03 00      [10] 1113 	ld	hl, #2+1
   4949 39            [11] 1114 	add	hl, sp
   494A CB 7E         [12] 1115 	bit	7, (hl)
   494C 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   494E 3E 01         [ 7] 1118 	ld	a, #0x01
   4950 02            [ 7] 1119 	ld	(bc), a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   4951 AF            [ 4] 1121 	xor	a, a
   4952 12            [ 7] 1122 	ld	(de), a
   4953 C9            [10] 1123 	ret
   4954                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   4954 AF            [ 4] 1126 	xor	a, a
   4955 FD 21 02 00   [14] 1127 	ld	iy, #2
   4959 FD 39         [15] 1128 	add	iy, sp
   495B FD BE 00      [19] 1129 	cp	a, 0 (iy)
   495E FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   4961 E2 66 49      [10] 1131 	jp	PO, 00116$
   4964 EE 80         [ 7] 1132 	xor	a, #0x80
   4966                    1133 00116$:
   4966 F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   4967 3E 01         [ 7] 1136 	ld	a, #0x01
   4969 12            [ 7] 1137 	ld	(de), a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   496A AF            [ 4] 1139 	xor	a, a
   496B 02            [ 7] 1140 	ld	(bc), a
   496C C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   496D                    1146 _fuzzificacion::
   496D DD E5         [15] 1147 	push	ix
   496F DD 21 00 00   [14] 1148 	ld	ix,#0
   4973 DD 39         [15] 1149 	add	ix,sp
   4975 21 EE FF      [10] 1150 	ld	hl, #-18
   4978 39            [11] 1151 	add	hl, sp
   4979 F9            [ 6] 1152 	ld	sp, hl
                           1153 ;src/IA.c:299: ball = &ballX;
   497A 21 06 00      [10] 1154 	ld	hl, #0x0006
   497D 39            [11] 1155 	add	hl, sp
   497E DD 75 FA      [19] 1156 	ld	-6 (ix), l
   4981 DD 74 FB      [19] 1157 	ld	-5 (ix), h
   4984 4D            [ 4] 1158 	ld	c, l
   4985 44            [ 4] 1159 	ld	b, h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   4986 DD 5E 08      [19] 1161 	ld	e, 8 (ix)
   4989 16 00         [ 7] 1162 	ld	d, #0x00
   498B DD 6E 0A      [19] 1163 	ld	l, 10 (ix)
   498E 26 00         [ 7] 1164 	ld	h, #0x00
   4990 7B            [ 4] 1165 	ld	a, e
   4991 95            [ 4] 1166 	sub	a, l
   4992 DD 77 FC      [19] 1167 	ld	-4 (ix), a
   4995 7A            [ 4] 1168 	ld	a, d
   4996 9C            [ 4] 1169 	sbc	a, h
   4997 DD 77 FD      [19] 1170 	ld	-3 (ix), a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   499A DD 6E 09      [19] 1172 	ld	l, 9 (ix)
   499D 26 00         [ 7] 1173 	ld	h, #0x00
   499F DD 5E 0B      [19] 1174 	ld	e, 11 (ix)
   49A2 16 00         [ 7] 1175 	ld	d, #0x00
   49A4 7D            [ 4] 1176 	ld	a, l
   49A5 93            [ 4] 1177 	sub	a, e
   49A6 DD 77 FE      [19] 1178 	ld	-2 (ix), a
   49A9 7C            [ 4] 1179 	ld	a, h
   49AA 9A            [ 4] 1180 	sbc	a, d
   49AB DD 77 FF      [19] 1181 	ld	-1 (ix), a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   49AE 3E 6F         [ 7] 1183 	ld	a, #0x6f
   49B0 93            [ 4] 1184 	sub	a, e
   49B1 DD 77 F6      [19] 1185 	ld	-10 (ix), a
   49B4 3E 00         [ 7] 1186 	ld	a, #0x00
   49B6 9A            [ 4] 1187 	sbc	a, d
   49B7 DD 77 F7      [19] 1188 	ld	-9 (ix), a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   49BA 59            [ 4] 1190 	ld	e, c
   49BB 50            [ 4] 1191 	ld	d, b
   49BC 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   49BD 3E FE         [ 7] 1194 	ld	a, #0xfe
   49BF DD BE FC      [19] 1195 	cp	a, -4 (ix)
   49C2 3E FF         [ 7] 1196 	ld	a, #0xff
   49C4 DD 9E FD      [19] 1197 	sbc	a, -3 (ix)
   49C7 E2 CC 49      [10] 1198 	jp	PO, 00148$
   49CA EE 80         [ 7] 1199 	xor	a, #0x80
   49CC                    1200 00148$:
   49CC FA D6 49      [10] 1201 	jp	M, 00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   49CF 3E 01         [ 7] 1203 	ld	a, #0x01
   49D1 02            [ 7] 1204 	ld	(bc), a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   49D2 AF            [ 4] 1206 	xor	a, a
   49D3 12            [ 7] 1207 	ld	(de), a
   49D4 18 05         [12] 1208 	jr	00103$
   49D6                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   49D6 3E 01         [ 7] 1211 	ld	a, #0x01
   49D8 12            [ 7] 1212 	ld	(de), a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   49D9 AF            [ 4] 1214 	xor	a, a
   49DA 02            [ 7] 1215 	ld	(bc), a
   49DB                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   49DB AF            [ 4] 1218 	xor	a, a
   49DC DD BE FC      [19] 1219 	cp	a, -4 (ix)
   49DF DD 9E FD      [19] 1220 	sbc	a, -3 (ix)
   49E2 E2 E7 49      [10] 1221 	jp	PO, 00149$
   49E5 EE 80         [ 7] 1222 	xor	a, #0x80
   49E7                    1223 00149$:
   49E7 07            [ 4] 1224 	rlca
   49E8 E6 01         [ 7] 1225 	and	a,#0x01
   49EA 4F            [ 4] 1226 	ld	c, a
   49EB DD 7E F6      [19] 1227 	ld	a, -10 (ix)
   49EE DD 96 FE      [19] 1228 	sub	a, -2 (ix)
   49F1 DD 7E F7      [19] 1229 	ld	a, -9 (ix)
   49F4 DD 9E FF      [19] 1230 	sbc	a, -1 (ix)
   49F7 E2 FC 49      [10] 1231 	jp	PO, 00150$
   49FA EE 80         [ 7] 1232 	xor	a, #0x80
   49FC                    1233 00150$:
   49FC F2 16 4A      [10] 1234 	jp	P, 00109$
   49FF 79            [ 4] 1235 	ld	a, c
   4A00 B7            [ 4] 1236 	or	a, a
   4A01 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   4A03 21 04 00      [10] 1239 	ld	hl, #0x0004
   4A06 39            [11] 1240 	add	hl, sp
   4A07 E5            [11] 1241 	push	hl
   4A08 DD 6E F6      [19] 1242 	ld	l,-10 (ix)
   4A0B DD 66 F7      [19] 1243 	ld	h,-9 (ix)
   4A0E E5            [11] 1244 	push	hl
   4A0F CD 38 49      [17] 1245 	call	_calcularb_direc
   4A12 F1            [10] 1246 	pop	af
   4A13 F1            [10] 1247 	pop	af
   4A14 18 3C         [12] 1248 	jr	00110$
   4A16                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   4A16 DD 7E FE      [19] 1251 	ld	a, -2 (ix)
   4A19 DD 96 F6      [19] 1252 	sub	a, -10 (ix)
   4A1C DD 7E FF      [19] 1253 	ld	a, -1 (ix)
   4A1F DD 9E F7      [19] 1254 	sbc	a, -9 (ix)
   4A22 E2 27 4A      [10] 1255 	jp	PO, 00151$
   4A25 EE 80         [ 7] 1256 	xor	a, #0x80
   4A27                    1257 00151$:
   4A27 F2 41 4A      [10] 1258 	jp	P, 00105$
   4A2A 79            [ 4] 1259 	ld	a, c
   4A2B B7            [ 4] 1260 	or	a, a
   4A2C 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   4A2E 21 04 00      [10] 1263 	ld	hl, #0x0004
   4A31 39            [11] 1264 	add	hl, sp
   4A32 E5            [11] 1265 	push	hl
   4A33 DD 6E F6      [19] 1266 	ld	l,-10 (ix)
   4A36 DD 66 F7      [19] 1267 	ld	h,-9 (ix)
   4A39 E5            [11] 1268 	push	hl
   4A3A CD 38 49      [17] 1269 	call	_calcularb_direc
   4A3D F1            [10] 1270 	pop	af
   4A3E F1            [10] 1271 	pop	af
   4A3F 18 11         [12] 1272 	jr	00110$
   4A41                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   4A41 21 04 00      [10] 1275 	ld	hl, #0x0004
   4A44 39            [11] 1276 	add	hl, sp
   4A45 E5            [11] 1277 	push	hl
   4A46 DD 6E FE      [19] 1278 	ld	l,-2 (ix)
   4A49 DD 66 FF      [19] 1279 	ld	h,-1 (ix)
   4A4C E5            [11] 1280 	push	hl
   4A4D CD 38 49      [17] 1281 	call	_calcularb_direc
   4A50 F1            [10] 1282 	pop	af
   4A51 F1            [10] 1283 	pop	af
   4A52                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   4A52 DD 4E FC      [19] 1286 	ld	c, -4 (ix)
   4A55 DD 71 F9      [19] 1287 	ld	-7 (ix), c
   4A58 DD 36 F8 00   [19] 1288 	ld	-8 (ix), #0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   4A5C DD 46 FE      [19] 1290 	ld	b, -2 (ix)
   4A5F 0E 00         [ 7] 1291 	ld	c, #0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   4A61 21 02 00      [10] 1293 	ld	hl, #0x0002
   4A64 39            [11] 1294 	add	hl, sp
   4A65 DD 56 F8      [19] 1295 	ld	d, -8 (ix)
   4A68 C5            [11] 1296 	push	bc
   4A69 E5            [11] 1297 	push	hl
   4A6A 1E 03         [ 7] 1298 	ld	e, #0x03
   4A6C D5            [11] 1299 	push	de
   4A6D CD B0 48      [17] 1300 	call	_calcule
   4A70 F1            [10] 1301 	pop	af
   4A71 F1            [10] 1302 	pop	af
   4A72 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   4A73 21 00 00      [10] 1305 	ld	hl, #0x0000
   4A76 39            [11] 1306 	add	hl, sp
   4A77 51            [ 4] 1307 	ld	d, c
   4A78 C5            [11] 1308 	push	bc
   4A79 E5            [11] 1309 	push	hl
   4A7A 1E 03         [ 7] 1310 	ld	e, #0x03
   4A7C D5            [11] 1311 	push	de
   4A7D CD B0 48      [17] 1312 	call	_calcule
   4A80 F1            [10] 1313 	pop	af
   4A81 F1            [10] 1314 	pop	af
   4A82 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   4A83 78            [ 4] 1317 	ld	a, b
   4A84 B1            [ 4] 1318 	or	a,c
   4A85 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   4A87 DD 4E FA      [19] 1321 	ld	c,-6 (ix)
   4A8A DD 46 FB      [19] 1322 	ld	b,-5 (ix)
   4A8D DD 6E 04      [19] 1323 	ld	l,4 (ix)
   4A90 DD 66 05      [19] 1324 	ld	h,5 (ix)
   4A93 E5            [11] 1325 	push	hl
   4A94 C5            [11] 1326 	push	bc
   4A95 DD 6E F0      [19] 1327 	ld	l,-16 (ix)
   4A98 DD 66 F1      [19] 1328 	ld	h,-15 (ix)
   4A9B E5            [11] 1329 	push	hl
   4A9C CD A3 47      [17] 1330 	call	_defuzzi
   4A9F 21 06 00      [10] 1331 	ld	hl, #6
   4AA2 39            [11] 1332 	add	hl, sp
   4AA3 F9            [ 6] 1333 	ld	sp, hl
                           1334 ;src/IA.c:336: ax = 0;
   4AA4                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   4AA4 DD 7E F9      [19] 1337 	ld	a, -7 (ix)
   4AA7 DD B6 F8      [19] 1338 	or	a,-8 (ix)
   4AAA 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   4AAC 21 04 00      [10] 1341 	ld	hl, #0x0004
   4AAF 39            [11] 1342 	add	hl, sp
   4AB0 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   4AB3 DD 46 07      [19] 1344 	ld	b,7 (ix)
   4AB6 C5            [11] 1345 	push	bc
   4AB7 E5            [11] 1346 	push	hl
   4AB8 DD 6E EE      [19] 1347 	ld	l,-18 (ix)
   4ABB DD 66 EF      [19] 1348 	ld	h,-17 (ix)
   4ABE E5            [11] 1349 	push	hl
   4ABF CD A3 47      [17] 1350 	call	_defuzzi
   4AC2 21 06 00      [10] 1351 	ld	hl, #6
   4AC5 39            [11] 1352 	add	hl, sp
   4AC6 F9            [ 6] 1353 	ld	sp, hl
                           1354 ;src/IA.c:341: ay = 0;
   4AC7                    1355 00118$:
   4AC7 DD F9         [10] 1356 	ld	sp, ix
   4AC9 DD E1         [14] 1357 	pop	ix
   4ACB C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   4ACC                    1363 _moveIA::
   4ACC DD E5         [15] 1364 	push	ix
   4ACE DD 21 00 00   [14] 1365 	ld	ix,#0
   4AD2 DD 39         [15] 1366 	add	ix,sp
   4AD4 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4AD5 DD 7E 04      [19] 1369 	ld	a, 4 (ix)
   4AD8 DD 77 FE      [19] 1370 	ld	-2 (ix), a
   4ADB DD 7E 05      [19] 1371 	ld	a, 5 (ix)
   4ADE DD 77 FF      [19] 1372 	ld	-1 (ix), a
   4AE1 E1            [10] 1373 	pop	hl
   4AE2 E5            [11] 1374 	push	hl
   4AE3 23            [ 6] 1375 	inc	hl
   4AE4 23            [ 6] 1376 	inc	hl
   4AE5 4E            [ 7] 1377 	ld	c, (hl)
   4AE6 23            [ 6] 1378 	inc	hl
   4AE7 46            [ 7] 1379 	ld	b, (hl)
   4AE8 DD 6E 08      [19] 1380 	ld	l,8 (ix)
   4AEB DD 66 09      [19] 1381 	ld	h,9 (ix)
   4AEE 23            [ 6] 1382 	inc	hl
   4AEF 23            [ 6] 1383 	inc	hl
   4AF0 5E            [ 7] 1384 	ld	e, (hl)
   4AF1 23            [ 6] 1385 	inc	hl
   4AF2 56            [ 7] 1386 	ld	d, (hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   4AF3 DD 7E FE      [19] 1388 	ld	a, -2 (ix)
   4AF6 C6 0C         [ 7] 1389 	add	a, #0x0c
   4AF8 6F            [ 4] 1390 	ld	l, a
   4AF9 DD 7E FF      [19] 1391 	ld	a, -1 (ix)
   4AFC CE 00         [ 7] 1392 	adc	a, #0x00
   4AFE 67            [ 4] 1393 	ld	h, a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4AFF 7B            [ 4] 1395 	ld	a, e
   4B00 91            [ 4] 1396 	sub	a, c
   4B01 7A            [ 4] 1397 	ld	a, d
   4B02 98            [ 4] 1398 	sbc	a, b
   4B03 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   4B05 36 E0         [10] 1401 	ld	(hl), #0xe0
   4B07 23            [ 6] 1402 	inc	hl
   4B08 36 FF         [10] 1403 	ld	(hl), #0xff
   4B0A 18 0B         [12] 1404 	jr	00106$
   4B0C                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   4B0C 79            [ 4] 1407 	ld	a, c
   4B0D 93            [ 4] 1408 	sub	a, e
   4B0E 78            [ 4] 1409 	ld	a, b
   4B0F 9A            [ 4] 1410 	sbc	a, d
   4B10 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   4B12 36 20         [10] 1413 	ld	(hl), #0x20
   4B14 23            [ 6] 1414 	inc	hl
   4B15 36 00         [10] 1415 	ld	(hl), #0x00
   4B17                    1416 00106$:
   4B17 DD F9         [10] 1417 	ld	sp, ix
   4B19 DD E1         [14] 1418 	pop	ix
   4B1B C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   6FD5                    1422 __xinit__vRulesx:
   6FD5 65 44              1423 	.dw _rulex
   6FD7 69 44              1424 	.dw _rulex1
   6FD9 6D 44              1425 	.dw _rulex2
   6FDB                    1426 __xinit__vRulesy:
   6FDB 71 44              1427 	.dw _ruley
   6FDD 75 44              1428 	.dw _ruley1
   6FDF 79 44              1429 	.dw _ruley2
   6FE1                    1430 __xinit__fmems:
   6FE1 4F 44              1431 	.dw _acelPo
   6FE3 5A 44              1432 	.dw _acelMed
   6FE5 44 44              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
