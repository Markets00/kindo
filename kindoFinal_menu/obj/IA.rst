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
   6BBD                      41 _aceleracion::
   6BBD                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   6BC3                      47 _vRulesx::
   6BC3                      48 	.ds 6
   6BC9                      49 _vRulesy::
   6BC9                      50 	.ds 6
   6BCF                      51 _fmems::
   6BCF                      52 	.ds 6
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
   4301 21 F8 FF      [10]   81 	ld	hl, #-8
   4304 39            [11]   82 	add	hl, sp
   4305 F9            [ 6]   83 	ld	sp, hl
                             84 ;src/IA.c:129: u8 i = 0;
   4306 1E 00         [ 7]   85 	ld	e, #0x00
                             86 ;src/IA.c:130: switch(nivel){
   4308 DD 7E 04      [19]   87 	ld	a, 4 (ix)
   430B B7            [ 4]   88 	or	a, a
   430C 28 09         [12]   89 	jr	Z,00101$
   430E DD 7E 04      [19]   90 	ld	a, 4 (ix)
   4311 3D            [ 4]   91 	dec	a
   4312 28 59         [12]   92 	jr	Z,00105$
   4314 C3 C1 43      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   4317                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   4317 21 00 00      [10]   97 	ld	hl, #0x0000
   431A 39            [11]   98 	add	hl, sp
   431B DD 75 FE      [19]   99 	ld	-2 (ix), l
   431E DD 74 FF      [19]  100 	ld	-1 (ix), h
   4321 36 0F         [10]  101 	ld	(hl), #0x0f
   4323 23            [ 6]  102 	inc	hl
   4324 36 00         [10]  103 	ld	(hl), #0x00
   4326 DD 6E FE      [19]  104 	ld	l,-2 (ix)
   4329 DD 66 FF      [19]  105 	ld	h,-1 (ix)
   432C 23            [ 6]  106 	inc	hl
   432D 23            [ 6]  107 	inc	hl
   432E 36 14         [10]  108 	ld	(hl), #0x14
   4330 23            [ 6]  109 	inc	hl
   4331 36 00         [10]  110 	ld	(hl), #0x00
   4333 DD 7E FE      [19]  111 	ld	a, -2 (ix)
   4336 C6 04         [ 7]  112 	add	a, #0x04
   4338 6F            [ 4]  113 	ld	l, a
   4339 DD 7E FF      [19]  114 	ld	a, -1 (ix)
   433C CE 00         [ 7]  115 	adc	a, #0x00
   433E 67            [ 4]  116 	ld	h, a
   433F 36 17         [10]  117 	ld	(hl), #0x17
   4341 23            [ 6]  118 	inc	hl
   4342 36 00         [10]  119 	ld	(hl), #0x00
                            120 ;src/IA.c:133: while(i<3)
   4344 01 BD 6B      [10]  121 	ld	bc, #_aceleracion+0
   4347 1E 00         [ 7]  122 	ld	e, #0x00
   4349                     123 00102$:
   4349 7B            [ 4]  124 	ld	a, e
   434A D6 03         [ 7]  125 	sub	a, #0x03
   434C 30 1F         [12]  126 	jr	NC,00124$
                            127 ;src/IA.c:135: aceleracion[i] = aux[i];
   434E 6B            [ 4]  128 	ld	l, e
   434F 26 00         [ 7]  129 	ld	h, #0x00
   4351 29            [11]  130 	add	hl, hl
   4352 E5            [11]  131 	push	hl
   4353 FD E1         [14]  132 	pop	iy
   4355 FD 09         [15]  133 	add	iy, bc
   4357 DD 7E FE      [19]  134 	ld	a, -2 (ix)
   435A 85            [ 4]  135 	add	a, l
   435B 6F            [ 4]  136 	ld	l, a
   435C DD 7E FF      [19]  137 	ld	a, -1 (ix)
   435F 8C            [ 4]  138 	adc	a, h
   4360 67            [ 4]  139 	ld	h, a
   4361 7E            [ 7]  140 	ld	a, (hl)
   4362 23            [ 6]  141 	inc	hl
   4363 56            [ 7]  142 	ld	d, (hl)
   4364 FD 77 00      [19]  143 	ld	0 (iy), a
   4367 FD 72 01      [19]  144 	ld	1 (iy), d
                            145 ;src/IA.c:136: i++;
   436A 1C            [ 4]  146 	inc	e
   436B 18 DC         [12]  147 	jr	00102$
                            148 ;src/IA.c:139: case 1:{
   436D                     149 00124$:
   436D                     150 00105$:
                            151 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   436D 21 00 00      [10]  152 	ld	hl, #0x0000
   4370 39            [11]  153 	add	hl, sp
   4371 DD 75 FE      [19]  154 	ld	-2 (ix), l
   4374 DD 74 FF      [19]  155 	ld	-1 (ix), h
   4377 36 17         [10]  156 	ld	(hl), #0x17
   4379 23            [ 6]  157 	inc	hl
   437A 36 00         [10]  158 	ld	(hl), #0x00
   437C DD 6E FE      [19]  159 	ld	l,-2 (ix)
   437F DD 66 FF      [19]  160 	ld	h,-1 (ix)
   4382 23            [ 6]  161 	inc	hl
   4383 23            [ 6]  162 	inc	hl
   4384 36 19         [10]  163 	ld	(hl), #0x19
   4386 23            [ 6]  164 	inc	hl
   4387 36 00         [10]  165 	ld	(hl), #0x00
   4389 DD 7E FE      [19]  166 	ld	a, -2 (ix)
   438C C6 04         [ 7]  167 	add	a, #0x04
   438E 6F            [ 4]  168 	ld	l, a
   438F DD 7E FF      [19]  169 	ld	a, -1 (ix)
   4392 CE 00         [ 7]  170 	adc	a, #0x00
   4394 67            [ 4]  171 	ld	h, a
   4395 36 33         [10]  172 	ld	(hl), #0x33
   4397 23            [ 6]  173 	inc	hl
   4398 36 00         [10]  174 	ld	(hl), #0x00
                            175 ;src/IA.c:141: while(i<3)
   439A 01 BD 6B      [10]  176 	ld	bc, #_aceleracion+0
   439D                     177 00106$:
   439D 7B            [ 4]  178 	ld	a, e
   439E D6 03         [ 7]  179 	sub	a, #0x03
   43A0 30 1F         [12]  180 	jr	NC,00125$
                            181 ;src/IA.c:143: aceleracion[i] = aux[i];
   43A2 6B            [ 4]  182 	ld	l, e
   43A3 26 00         [ 7]  183 	ld	h, #0x00
   43A5 29            [11]  184 	add	hl, hl
   43A6 E5            [11]  185 	push	hl
   43A7 FD E1         [14]  186 	pop	iy
   43A9 FD 09         [15]  187 	add	iy, bc
   43AB DD 7E FE      [19]  188 	ld	a, -2 (ix)
   43AE 85            [ 4]  189 	add	a, l
   43AF 6F            [ 4]  190 	ld	l, a
   43B0 DD 7E FF      [19]  191 	ld	a, -1 (ix)
   43B3 8C            [ 4]  192 	adc	a, h
   43B4 67            [ 4]  193 	ld	h, a
   43B5 7E            [ 7]  194 	ld	a, (hl)
   43B6 23            [ 6]  195 	inc	hl
   43B7 56            [ 7]  196 	ld	d, (hl)
   43B8 FD 77 00      [19]  197 	ld	0 (iy), a
   43BB FD 72 01      [19]  198 	ld	1 (iy), d
                            199 ;src/IA.c:144: i++;
   43BE 1C            [ 4]  200 	inc	e
   43BF 18 DC         [12]  201 	jr	00106$
                            202 ;src/IA.c:147: default:{
   43C1                     203 00125$:
   43C1                     204 00109$:
                            205 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   43C1 21 00 00      [10]  206 	ld	hl, #0x0000
   43C4 39            [11]  207 	add	hl, sp
   43C5 4D            [ 4]  208 	ld	c,l
   43C6 44            [ 4]  209 	ld	b,h
   43C7 36 19         [10]  210 	ld	(hl), #0x19
   43C9 23            [ 6]  211 	inc	hl
   43CA 36 00         [10]  212 	ld	(hl), #0x00
   43CC 69            [ 4]  213 	ld	l, c
   43CD 60            [ 4]  214 	ld	h, b
   43CE 23            [ 6]  215 	inc	hl
   43CF 23            [ 6]  216 	inc	hl
   43D0 36 33         [10]  217 	ld	(hl), #0x33
   43D2 23            [ 6]  218 	inc	hl
   43D3 36 00         [10]  219 	ld	(hl), #0x00
   43D5 21 04 00      [10]  220 	ld	hl, #0x0004
   43D8 09            [11]  221 	add	hl, bc
   43D9 36 4C         [10]  222 	ld	(hl), #0x4c
   43DB 23            [ 6]  223 	inc	hl
   43DC 36 00         [10]  224 	ld	(hl), #0x00
                            225 ;src/IA.c:149: while(i<3)
   43DE                     226 00110$:
   43DE 7B            [ 4]  227 	ld	a, e
   43DF D6 03         [ 7]  228 	sub	a, #0x03
   43E1 30 1B         [12]  229 	jr	NC,00114$
                            230 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   43E3 6B            [ 4]  231 	ld	l, e
   43E4 26 00         [ 7]  232 	ld	h, #0x00
   43E6 29            [11]  233 	add	hl, hl
   43E7 FD 21 BD 6B   [14]  234 	ld	iy, #_aceleracion
   43EB C5            [11]  235 	push	bc
   43EC 4D            [ 4]  236 	ld	c, l
   43ED 44            [ 4]  237 	ld	b, h
   43EE FD 09         [15]  238 	add	iy, bc
   43F0 C1            [10]  239 	pop	bc
   43F1 09            [11]  240 	add	hl, bc
   43F2 7E            [ 7]  241 	ld	a, (hl)
   43F3 23            [ 6]  242 	inc	hl
   43F4 66            [ 7]  243 	ld	h, (hl)
   43F5 FD 77 00      [19]  244 	ld	0 (iy), a
   43F8 FD 74 01      [19]  245 	ld	1 (iy), h
                            246 ;src/IA.c:152: i++;
   43FB 1C            [ 4]  247 	inc	e
   43FC 18 E0         [12]  248 	jr	00110$
                            249 ;src/IA.c:155: }
   43FE                     250 00114$:
   43FE DD F9         [10]  251 	ld	sp, ix
   4400 DD E1         [14]  252 	pop	ix
   4402 C9            [10]  253 	ret
   4403                     254 _cerca:
   4403 00 00               255 	.dw #0x0000
   4405 00 05               256 	.dw #0x0500
   4407 01                  257 	.db #0x01	; 1
   4408 00 0A               258 	.dw #0x0a00
   440A 00 0A               259 	.dw #0x0a00
   440C 00 0A               260 	.dw #0x0a00
   440E                     261 _medio:
   440E 00 00               262 	.dw #0x0000
   4410 00 14               263 	.dw #0x1400
   4412 00                  264 	.db #0x00	; 0
   4413 00 14               265 	.dw #0x1400
   4415 00 0A               266 	.dw #0x0a00
   4417 00 0F               267 	.dw #0x0f00
   4419                     268 _lejos:
   4419 00 00               269 	.dw #0x0000
   441B 00 6E               270 	.dw #0x6e00
   441D 02                  271 	.db #0x02	; 2
   441E 00 3C               272 	.dw #0x3c00
   4420 00 19               273 	.dw #0x1900
   4422 00 64               274 	.dw #0x6400
   4424                     275 _acelMu:
   4424 00 00               276 	.dw #0x0000
   4426 80 57               277 	.dw #0x5780
   4428 02                  278 	.db #0x02	; 2
   4429 00 4B               279 	.dw #0x4b00
   442B 00 19               280 	.dw #0x1900
   442D 00 19               281 	.dw #0x1900
   442F                     282 _acelPo:
   442F 00 00               283 	.dw #0x0000
   4431 80 0C               284 	.dw #0x0c80
   4433 01                  285 	.db #0x01	; 1
   4434 00 19               286 	.dw #0x1900
   4436 00 19               287 	.dw #0x1900
   4438 00 19               288 	.dw #0x1900
   443A                     289 _acelMed:
   443A 00 00               290 	.dw #0x0000
   443C 00 32               291 	.dw #0x3200
   443E 00                  292 	.db #0x00	; 0
   443F 00 32               293 	.dw #0x3200
   4441 00 19               294 	.dw #0x1900
   4443 00 19               295 	.dw #0x1900
   4445                     296 _rulex:
   4445 03 44               297 	.dw _cerca
   4447 24 44               298 	.dw _acelMu
   4449                     299 _rulex1:
   4449 0E 44               300 	.dw _medio
   444B 3A 44               301 	.dw _acelMed
   444D                     302 _rulex2:
   444D 19 44               303 	.dw _lejos
   444F 2F 44               304 	.dw _acelPo
   4451                     305 _ruley:
   4451 03 44               306 	.dw _cerca
   4453 24 44               307 	.dw _acelMu
   4455                     308 _ruley1:
   4455 0E 44               309 	.dw _medio
   4457 3A 44               310 	.dw _acelMed
   4459                     311 _ruley2:
   4459 19 44               312 	.dw _lejos
   445B 2F 44               313 	.dw _acelPo
                            314 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            315 ;	---------------------------------
                            316 ; Function calculateDom
                            317 ; ---------------------------------
   445D                     318 _calculateDom::
   445D DD E5         [15]  319 	push	ix
   445F DD 21 00 00   [14]  320 	ld	ix,#0
   4463 DD 39         [15]  321 	add	ix,sp
   4465 21 ED FF      [10]  322 	ld	hl, #-19
   4468 39            [11]  323 	add	hl, sp
   4469 F9            [ 6]  324 	ld	sp, hl
                            325 ;src/IA.c:161: *grad = 0.0;
   446A DD 5E 07      [19]  326 	ld	e,7 (ix)
   446D DD 56 08      [19]  327 	ld	d,8 (ix)
   4470 6B            [ 4]  328 	ld	l, e
   4471 62            [ 4]  329 	ld	h, d
   4472 AF            [ 4]  330 	xor	a, a
   4473 77            [ 7]  331 	ld	(hl), a
   4474 23            [ 6]  332 	inc	hl
   4475 77            [ 7]  333 	ld	(hl), a
                            334 ;src/IA.c:162: if(c->tipo == 0){
   4476 DD 7E 04      [19]  335 	ld	a, 4 (ix)
   4479 DD 77 FC      [19]  336 	ld	-4 (ix), a
   447C DD 7E 05      [19]  337 	ld	a, 5 (ix)
   447F DD 77 FD      [19]  338 	ld	-3 (ix), a
   4482 DD 6E FC      [19]  339 	ld	l,-4 (ix)
   4485 DD 66 FD      [19]  340 	ld	h,-3 (ix)
   4488 01 04 00      [10]  341 	ld	bc, #0x0004
   448B 09            [11]  342 	add	hl, bc
   448C 4E            [ 7]  343 	ld	c, (hl)
                            344 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   448D DD 7E FC      [19]  345 	ld	a, -4 (ix)
   4490 C6 09         [ 7]  346 	add	a, #0x09
   4492 DD 77 FE      [19]  347 	ld	-2 (ix), a
   4495 DD 7E FD      [19]  348 	ld	a, -3 (ix)
   4498 CE 00         [ 7]  349 	adc	a, #0x00
   449A DD 77 FF      [19]  350 	ld	-1 (ix), a
   449D DD 7E FC      [19]  351 	ld	a, -4 (ix)
   44A0 C6 05         [ 7]  352 	add	a, #0x05
   44A2 DD 77 EF      [19]  353 	ld	-17 (ix), a
   44A5 DD 7E FD      [19]  354 	ld	a, -3 (ix)
   44A8 CE 00         [ 7]  355 	adc	a, #0x00
   44AA DD 77 F0      [19]  356 	ld	-16 (ix), a
   44AD DD 7E 06      [19]  357 	ld	a, 6 (ix)
   44B0 DD 77 FA      [19]  358 	ld	-6 (ix), a
   44B3 DD 36 FB 00   [19]  359 	ld	-5 (ix), #0x00
                            360 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   44B7 DD 7E FC      [19]  361 	ld	a, -4 (ix)
   44BA C6 07         [ 7]  362 	add	a, #0x07
   44BC DD 77 FC      [19]  363 	ld	-4 (ix), a
   44BF DD 7E FD      [19]  364 	ld	a, -3 (ix)
   44C2 CE 00         [ 7]  365 	adc	a, #0x00
   44C4 DD 77 FD      [19]  366 	ld	-3 (ix), a
                            367 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   44C7 DD 6E EF      [19]  368 	ld	l,-17 (ix)
   44CA DD 66 F0      [19]  369 	ld	h,-16 (ix)
   44CD 7E            [ 7]  370 	ld	a, (hl)
   44CE DD 77 F8      [19]  371 	ld	-8 (ix), a
   44D1 23            [ 6]  372 	inc	hl
   44D2 7E            [ 7]  373 	ld	a, (hl)
   44D3 DD 77 F9      [19]  374 	ld	-7 (ix), a
                            375 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   44D6 DD 7E 06      [19]  376 	ld	a, 6 (ix)
   44D9 DD 77 ED      [19]  377 	ld	-19 (ix), a
   44DC DD 36 EE 00   [19]  378 	ld	-18 (ix), #0x00
                            379 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   44E0 DD 6E FE      [19]  380 	ld	l,-2 (ix)
   44E3 DD 66 FF      [19]  381 	ld	h,-1 (ix)
   44E6 7E            [ 7]  382 	ld	a, (hl)
   44E7 DD 77 F6      [19]  383 	ld	-10 (ix), a
   44EA 23            [ 6]  384 	inc	hl
   44EB 7E            [ 7]  385 	ld	a, (hl)
   44EC DD 77 F7      [19]  386 	ld	-9 (ix), a
                            387 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            388 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   44EF AF            [ 4]  389 	xor	a, a
   44F0 DD 96 F6      [19]  390 	sub	a, -10 (ix)
   44F3 6F            [ 4]  391 	ld	l, a
   44F4 3E 00         [ 7]  392 	ld	a, #0x00
   44F6 DD 9E F7      [19]  393 	sbc	a, -9 (ix)
   44F9 67            [ 4]  394 	ld	h, a
   44FA C5            [11]  395 	push	bc
   44FB D5            [11]  396 	push	de
   44FC E5            [11]  397 	push	hl
   44FD 21 00 01      [10]  398 	ld	hl, #0x0100
   4500 E5            [11]  399 	push	hl
                            400 ;src/IA.c:162: if(c->tipo == 0){
   4501 CD 59 5F      [17]  401 	call	__divuint
   4504 F1            [10]  402 	pop	af
   4505 F1            [10]  403 	pop	af
   4506 DD 74 F3      [19]  404 	ld	-13 (ix), h
   4509 DD 75 F2      [19]  405 	ld	-14 (ix), l
   450C D1            [10]  406 	pop	de
   450D C1            [10]  407 	pop	bc
   450E 79            [ 4]  408 	ld	a, c
   450F B7            [ 4]  409 	or	a, a
   4510 C2 34 46      [10]  410 	jp	NZ, 00138$
                            411 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   4513 DD 7E FA      [19]  412 	ld	a, -6 (ix)
   4516 DD 96 F8      [19]  413 	sub	a, -8 (ix)
   4519 20 0C         [12]  414 	jr	NZ,00214$
   451B DD 7E FB      [19]  415 	ld	a, -5 (ix)
   451E DD 96 F9      [19]  416 	sub	a, -7 (ix)
   4521 20 04         [12]  417 	jr	NZ,00214$
   4523 3E 01         [ 7]  418 	ld	a,#0x01
   4525 18 01         [12]  419 	jr	00215$
   4527                     420 00214$:
   4527 AF            [ 4]  421 	xor	a,a
   4528                     422 00215$:
   4528 47            [ 4]  423 	ld	b, a
   4529 DD 7E F7      [19]  424 	ld	a, -9 (ix)
   452C DD B6 F6      [19]  425 	or	a,-10 (ix)
   452F 20 04         [12]  426 	jr	NZ,00105$
   4531 78            [ 4]  427 	ld	a, b
   4532 B7            [ 4]  428 	or	a, a
   4533 20 10         [12]  429 	jr	NZ,00101$
   4535                     430 00105$:
                            431 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   4535 DD 6E FC      [19]  432 	ld	l,-4 (ix)
   4538 DD 66 FD      [19]  433 	ld	h,-3 (ix)
   453B 4E            [ 7]  434 	ld	c, (hl)
   453C 23            [ 6]  435 	inc	hl
   453D 66            [ 7]  436 	ld	h, (hl)
   453E 7C            [ 4]  437 	ld	a, h
   453F B1            [ 4]  438 	or	a,c
   4540 20 0D         [12]  439 	jr	NZ,00102$
   4542 B0            [ 4]  440 	or	a,b
   4543 28 0A         [12]  441 	jr	Z,00102$
   4545                     442 00101$:
                            443 ;src/IA.c:167: *grad = SCALA;
   4545 3E 00         [ 7]  444 	ld	a, #0x00
   4547 12            [ 7]  445 	ld	(de), a
   4548 13            [ 6]  446 	inc	de
   4549 3E 01         [ 7]  447 	ld	a, #0x01
   454B 12            [ 7]  448 	ld	(de), a
                            449 ;src/IA.c:168: return;
   454C C3 7E 47      [10]  450 	jp	00140$
   454F                     451 00102$:
                            452 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   454F DD 7E F8      [19]  453 	ld	a, -8 (ix)
   4552 DD 96 FA      [19]  454 	sub	a, -6 (ix)
   4555 DD 7E F9      [19]  455 	ld	a, -7 (ix)
   4558 DD 9E FB      [19]  456 	sbc	a, -5 (ix)
   455B 3E 00         [ 7]  457 	ld	a, #0x00
   455D 17            [ 4]  458 	rla
   455E DD 77 F1      [19]  459 	ld	-15 (ix), a
   4561 DD CB F1 46   [20]  460 	bit	0, -15 (ix)
   4565 20 68         [12]  461 	jr	NZ,00111$
   4567 DD 7E F8      [19]  462 	ld	a, -8 (ix)
   456A 91            [ 4]  463 	sub	a, c
   456B 47            [ 4]  464 	ld	b, a
   456C DD 7E F9      [19]  465 	ld	a, -7 (ix)
   456F 9C            [ 4]  466 	sbc	a, h
   4570 6F            [ 4]  467 	ld	l, a
   4571 DD 7E FA      [19]  468 	ld	a, -6 (ix)
   4574 90            [ 4]  469 	sub	a, b
   4575 DD 7E FB      [19]  470 	ld	a, -5 (ix)
   4578 9D            [ 4]  471 	sbc	a, l
   4579 38 54         [12]  472 	jr	C,00111$
                            473 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   457B D5            [11]  474 	push	de
   457C 69            [ 4]  475 	ld	l, c
   457D E5            [11]  476 	push	hl
   457E 21 00 01      [10]  477 	ld	hl, #0x0100
   4581 E5            [11]  478 	push	hl
   4582 CD 59 5F      [17]  479 	call	__divuint
   4585 F1            [10]  480 	pop	af
   4586 F1            [10]  481 	pop	af
   4587 4D            [ 4]  482 	ld	c, l
   4588 44            [ 4]  483 	ld	b, h
   4589 D1            [10]  484 	pop	de
   458A 6B            [ 4]  485 	ld	l, e
   458B 62            [ 4]  486 	ld	h, d
   458C 71            [ 7]  487 	ld	(hl), c
   458D 23            [ 6]  488 	inc	hl
   458E 70            [ 7]  489 	ld	(hl), b
                            490 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   458F DD 6E EF      [19]  491 	ld	l,-17 (ix)
   4592 DD 66 F0      [19]  492 	ld	h,-16 (ix)
   4595 7E            [ 7]  493 	ld	a, (hl)
   4596 DD 77 F4      [19]  494 	ld	-12 (ix), a
   4599 23            [ 6]  495 	inc	hl
   459A 7E            [ 7]  496 	ld	a, (hl)
   459B DD 77 F5      [19]  497 	ld	-11 (ix), a
   459E DD 6E FC      [19]  498 	ld	l,-4 (ix)
   45A1 DD 66 FD      [19]  499 	ld	h,-3 (ix)
   45A4 7E            [ 7]  500 	ld	a, (hl)
   45A5 23            [ 6]  501 	inc	hl
   45A6 66            [ 7]  502 	ld	h, (hl)
   45A7 6F            [ 4]  503 	ld	l, a
   45A8 DD 7E F4      [19]  504 	ld	a, -12 (ix)
   45AB 95            [ 4]  505 	sub	a, l
   45AC 6F            [ 4]  506 	ld	l, a
   45AD DD 7E F5      [19]  507 	ld	a, -11 (ix)
   45B0 9C            [ 4]  508 	sbc	a, h
   45B1 67            [ 4]  509 	ld	h, a
   45B2 DD 7E ED      [19]  510 	ld	a, -19 (ix)
   45B5 95            [ 4]  511 	sub	a, l
   45B6 6F            [ 4]  512 	ld	l, a
   45B7 DD 7E EE      [19]  513 	ld	a, -18 (ix)
   45BA 9C            [ 4]  514 	sbc	a, h
   45BB 67            [ 4]  515 	ld	h, a
   45BC D5            [11]  516 	push	de
   45BD E5            [11]  517 	push	hl
   45BE C5            [11]  518 	push	bc
   45BF CD 1B 69      [17]  519 	call	__mulint
   45C2 F1            [10]  520 	pop	af
   45C3 F1            [10]  521 	pop	af
   45C4 4D            [ 4]  522 	ld	c, l
   45C5 44            [ 4]  523 	ld	b, h
   45C6 D1            [10]  524 	pop	de
   45C7 79            [ 4]  525 	ld	a, c
   45C8 12            [ 7]  526 	ld	(de), a
   45C9 13            [ 6]  527 	inc	de
   45CA 78            [ 4]  528 	ld	a, b
   45CB 12            [ 7]  529 	ld	(de), a
                            530 ;src/IA.c:175: return;
   45CC C3 7E 47      [10]  531 	jp	00140$
   45CF                     532 00111$:
                            533 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   45CF DD CB F1 46   [20]  534 	bit	0, -15 (ix)
   45D3 28 55         [12]  535 	jr	Z,00107$
   45D5 DD 7E F8      [19]  536 	ld	a, -8 (ix)
   45D8 DD 86 F6      [19]  537 	add	a, -10 (ix)
   45DB 4F            [ 4]  538 	ld	c, a
   45DC DD 7E F9      [19]  539 	ld	a, -7 (ix)
   45DF DD 8E F7      [19]  540 	adc	a, -9 (ix)
   45E2 47            [ 4]  541 	ld	b, a
   45E3 DD 7E FA      [19]  542 	ld	a, -6 (ix)
   45E6 91            [ 4]  543 	sub	a, c
   45E7 DD 7E FB      [19]  544 	ld	a, -5 (ix)
   45EA 98            [ 4]  545 	sbc	a, b
   45EB 30 3D         [12]  546 	jr	NC,00107$
                            547 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   45ED 6B            [ 4]  548 	ld	l, e
   45EE 62            [ 4]  549 	ld	h, d
   45EF DD 7E F2      [19]  550 	ld	a, -14 (ix)
   45F2 77            [ 7]  551 	ld	(hl), a
   45F3 23            [ 6]  552 	inc	hl
   45F4 DD 7E F3      [19]  553 	ld	a, -13 (ix)
   45F7 77            [ 7]  554 	ld	(hl), a
                            555 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   45F8 DD 6E EF      [19]  556 	ld	l,-17 (ix)
   45FB DD 66 F0      [19]  557 	ld	h,-16 (ix)
   45FE 4E            [ 7]  558 	ld	c, (hl)
   45FF 23            [ 6]  559 	inc	hl
   4600 46            [ 7]  560 	ld	b, (hl)
   4601 DD 7E ED      [19]  561 	ld	a, -19 (ix)
   4604 91            [ 4]  562 	sub	a, c
   4605 4F            [ 4]  563 	ld	c, a
   4606 DD 7E EE      [19]  564 	ld	a, -18 (ix)
   4609 98            [ 4]  565 	sbc	a, b
   460A 47            [ 4]  566 	ld	b, a
   460B D5            [11]  567 	push	de
   460C C5            [11]  568 	push	bc
   460D DD 6E F2      [19]  569 	ld	l,-14 (ix)
   4610 DD 66 F3      [19]  570 	ld	h,-13 (ix)
   4613 E5            [11]  571 	push	hl
   4614 CD 1B 69      [17]  572 	call	__mulint
   4617 F1            [10]  573 	pop	af
   4618 F1            [10]  574 	pop	af
   4619 4D            [ 4]  575 	ld	c, l
   461A 44            [ 4]  576 	ld	b, h
   461B D1            [10]  577 	pop	de
   461C 21 00 01      [10]  578 	ld	hl, #0x0100
   461F 09            [11]  579 	add	hl,bc
   4620 4D            [ 4]  580 	ld	c, l
   4621 44            [ 4]  581 	ld	b, h
   4622 79            [ 4]  582 	ld	a, c
   4623 12            [ 7]  583 	ld	(de), a
   4624 13            [ 6]  584 	inc	de
   4625 78            [ 4]  585 	ld	a, b
   4626 12            [ 7]  586 	ld	(de), a
                            587 ;src/IA.c:180: return;
   4627 C3 7E 47      [10]  588 	jp	00140$
   462A                     589 00107$:
                            590 ;src/IA.c:183: *grad = 0;
   462A 3E 00         [ 7]  591 	ld	a, #0x00
   462C 12            [ 7]  592 	ld	(de), a
   462D 13            [ 6]  593 	inc	de
   462E 3E 00         [ 7]  594 	ld	a, #0x00
   4630 12            [ 7]  595 	ld	(de), a
                            596 ;src/IA.c:184: return;
   4631 C3 7E 47      [10]  597 	jp	00140$
   4634                     598 00138$:
                            599 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4634 DD 6E F8      [19]  600 	ld	l, -8 (ix)
   4637 DD 7E F6      [19]  601 	ld	a, -10 (ix)
   463A DD 77 F4      [19]  602 	ld	-12 (ix), a
   463D 7D            [ 4]  603 	ld	a, l
   463E DD 86 F4      [19]  604 	add	a, -12 (ix)
   4641 DD 96 F4      [19]  605 	sub	a, -12 (ix)
   4644 47            [ 4]  606 	ld	b, a
                            607 ;src/IA.c:187: }else if(c->tipo == 1)
   4645 0D            [ 4]  608 	dec	c
   4646 C2 D6 46      [10]  609 	jp	NZ,00135$
                            610 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   4649 48            [ 4]  611 	ld	c, b
                            612 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   464A DD 7E F7      [19]  613 	ld	a, -9 (ix)
   464D DD B6 F6      [19]  614 	or	a,-10 (ix)
   4650 20 0E         [12]  615 	jr	NZ,00115$
   4652 DD 7E 06      [19]  616 	ld	a, 6 (ix)
                            617 ;src/IA.c:193: *grad = SCALA;
   4655 91            [ 4]  618 	sub	a,c
   4656 20 08         [12]  619 	jr	NZ,00115$
   4658 12            [ 7]  620 	ld	(de), a
   4659 13            [ 6]  621 	inc	de
   465A 3E 01         [ 7]  622 	ld	a, #0x01
   465C 12            [ 7]  623 	ld	(de), a
                            624 ;src/IA.c:194: return;
   465D C3 7E 47      [10]  625 	jp	00140$
   4660                     626 00115$:
                            627 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   4660 DD 7E 06      [19]  628 	ld	a, 6 (ix)
   4663 91            [ 4]  629 	sub	a, c
   4664 3E 00         [ 7]  630 	ld	a, #0x00
   4666 17            [ 4]  631 	rla
   4667 DD 77 F4      [19]  632 	ld	-12 (ix), a
   466A DD CB F4 46   [20]  633 	bit	0, -12 (ix)
   466E 20 4C         [12]  634 	jr	NZ,00121$
   4670 06 00         [ 7]  635 	ld	b, #0x00
   4672 DD 6E F6      [19]  636 	ld	l,-10 (ix)
   4675 DD 66 F7      [19]  637 	ld	h,-9 (ix)
   4678 09            [11]  638 	add	hl, bc
   4679 DD 7E FA      [19]  639 	ld	a, -6 (ix)
   467C 95            [ 4]  640 	sub	a, l
   467D DD 7E FB      [19]  641 	ld	a, -5 (ix)
   4680 9C            [ 4]  642 	sbc	a, h
   4681 30 39         [12]  643 	jr	NC,00121$
                            644 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   4683 6B            [ 4]  645 	ld	l, e
   4684 62            [ 4]  646 	ld	h, d
   4685 DD 7E F2      [19]  647 	ld	a, -14 (ix)
   4688 77            [ 7]  648 	ld	(hl), a
   4689 23            [ 6]  649 	inc	hl
   468A DD 7E F3      [19]  650 	ld	a, -13 (ix)
   468D 77            [ 7]  651 	ld	(hl), a
                            652 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   468E DD 6E FE      [19]  653 	ld	l,-2 (ix)
   4691 DD 66 FF      [19]  654 	ld	h,-1 (ix)
   4694 7E            [ 7]  655 	ld	a, (hl)
   4695 23            [ 6]  656 	inc	hl
   4696 66            [ 7]  657 	ld	h, (hl)
   4697 6F            [ 4]  658 	ld	l, a
   4698 09            [11]  659 	add	hl, bc
   4699 DD 7E ED      [19]  660 	ld	a, -19 (ix)
   469C 95            [ 4]  661 	sub	a, l
   469D 4F            [ 4]  662 	ld	c, a
   469E DD 7E EE      [19]  663 	ld	a, -18 (ix)
   46A1 9C            [ 4]  664 	sbc	a, h
   46A2 47            [ 4]  665 	ld	b, a
   46A3 D5            [11]  666 	push	de
   46A4 C5            [11]  667 	push	bc
   46A5 DD 6E F2      [19]  668 	ld	l,-14 (ix)
   46A8 DD 66 F3      [19]  669 	ld	h,-13 (ix)
   46AB E5            [11]  670 	push	hl
   46AC CD 1B 69      [17]  671 	call	__mulint
   46AF F1            [10]  672 	pop	af
   46B0 F1            [10]  673 	pop	af
   46B1 4D            [ 4]  674 	ld	c, l
   46B2 44            [ 4]  675 	ld	b, h
   46B3 D1            [10]  676 	pop	de
   46B4 79            [ 4]  677 	ld	a, c
   46B5 12            [ 7]  678 	ld	(de), a
   46B6 13            [ 6]  679 	inc	de
   46B7 78            [ 4]  680 	ld	a, b
   46B8 12            [ 7]  681 	ld	(de), a
                            682 ;src/IA.c:201: return;
   46B9 C3 7E 47      [10]  683 	jp	00140$
   46BC                     684 00121$:
                            685 ;src/IA.c:202: }else if(val < midPoint)
   46BC DD CB F4 46   [20]  686 	bit	0, -12 (ix)
   46C0 28 0A         [12]  687 	jr	Z,00118$
                            688 ;src/IA.c:204: *grad = SCALA;
   46C2 3E 00         [ 7]  689 	ld	a, #0x00
   46C4 12            [ 7]  690 	ld	(de), a
   46C5 13            [ 6]  691 	inc	de
   46C6 3E 01         [ 7]  692 	ld	a, #0x01
   46C8 12            [ 7]  693 	ld	(de), a
                            694 ;src/IA.c:205: return;
   46C9 C3 7E 47      [10]  695 	jp	00140$
   46CC                     696 00118$:
                            697 ;src/IA.c:207: *grad = 0;
   46CC 3E 00         [ 7]  698 	ld	a, #0x00
   46CE 12            [ 7]  699 	ld	(de), a
   46CF 13            [ 6]  700 	inc	de
   46D0 3E 00         [ 7]  701 	ld	a, #0x00
   46D2 12            [ 7]  702 	ld	(de), a
                            703 ;src/IA.c:208: return;
   46D3 C3 7E 47      [10]  704 	jp	00140$
   46D6                     705 00135$:
                            706 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            707 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   46D6 DD 6E FC      [19]  708 	ld	l,-4 (ix)
   46D9 DD 66 FD      [19]  709 	ld	h,-3 (ix)
   46DC 4E            [ 7]  710 	ld	c, (hl)
   46DD 23            [ 6]  711 	inc	hl
   46DE 7E            [ 7]  712 	ld	a, (hl)
   46DF B1            [ 4]  713 	or	a,c
   46E0 20 0D         [12]  714 	jr	NZ,00125$
   46E2 DD 7E 06      [19]  715 	ld	a, 6 (ix)
   46E5 90            [ 4]  716 	sub	a, b
   46E6 20 07         [12]  717 	jr	NZ,00125$
                            718 ;src/IA.c:215: *grad = SCALA;
   46E8 6B            [ 4]  719 	ld	l, e
   46E9 62            [ 4]  720 	ld	h, d
   46EA 36 00         [10]  721 	ld	(hl), #0x00
   46EC 23            [ 6]  722 	inc	hl
   46ED 36 01         [10]  723 	ld	(hl), #0x01
   46EF                     724 00125$:
                            725 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   46EF 78            [ 4]  726 	ld	a, b
   46F0 DD 96 06      [19]  727 	sub	a, 6 (ix)
   46F3 3E 00         [ 7]  728 	ld	a, #0x00
   46F5 17            [ 4]  729 	rla
   46F6 DD 77 F4      [19]  730 	ld	-12 (ix), a
   46F9 DD CB F4 46   [20]  731 	bit	0, -12 (ix)
   46FD 20 69         [12]  732 	jr	NZ,00131$
   46FF 0E 00         [ 7]  733 	ld	c, #0x00
   4701 DD 6E FC      [19]  734 	ld	l,-4 (ix)
   4704 DD 66 FD      [19]  735 	ld	h,-3 (ix)
   4707 7E            [ 7]  736 	ld	a, (hl)
   4708 23            [ 6]  737 	inc	hl
   4709 66            [ 7]  738 	ld	h, (hl)
   470A 6F            [ 4]  739 	ld	l, a
   470B DD 70 F2      [19]  740 	ld	-14 (ix), b
   470E DD 71 F3      [19]  741 	ld	-13 (ix), c
   4711 DD 7E F2      [19]  742 	ld	a, -14 (ix)
   4714 95            [ 4]  743 	sub	a, l
   4715 4F            [ 4]  744 	ld	c, a
   4716 DD 7E F3      [19]  745 	ld	a, -13 (ix)
   4719 9C            [ 4]  746 	sbc	a, h
   471A 47            [ 4]  747 	ld	b, a
   471B 79            [ 4]  748 	ld	a, c
   471C DD 96 FA      [19]  749 	sub	a, -6 (ix)
   471F 78            [ 4]  750 	ld	a, b
   4720 DD 9E FB      [19]  751 	sbc	a, -5 (ix)
   4723 30 43         [12]  752 	jr	NC,00131$
                            753 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   4725 D5            [11]  754 	push	de
   4726 E5            [11]  755 	push	hl
   4727 21 00 01      [10]  756 	ld	hl, #0x0100
   472A E5            [11]  757 	push	hl
   472B CD 59 5F      [17]  758 	call	__divuint
   472E F1            [10]  759 	pop	af
   472F F1            [10]  760 	pop	af
   4730 4D            [ 4]  761 	ld	c, l
   4731 44            [ 4]  762 	ld	b, h
   4732 D1            [10]  763 	pop	de
   4733 6B            [ 4]  764 	ld	l, e
   4734 62            [ 4]  765 	ld	h, d
   4735 71            [ 7]  766 	ld	(hl), c
   4736 23            [ 6]  767 	inc	hl
   4737 70            [ 7]  768 	ld	(hl), b
                            769 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   4738 DD 6E FC      [19]  770 	ld	l,-4 (ix)
   473B DD 66 FD      [19]  771 	ld	h,-3 (ix)
   473E 7E            [ 7]  772 	ld	a, (hl)
   473F 23            [ 6]  773 	inc	hl
   4740 66            [ 7]  774 	ld	h, (hl)
   4741 6F            [ 4]  775 	ld	l, a
   4742 DD 7E F2      [19]  776 	ld	a, -14 (ix)
   4745 95            [ 4]  777 	sub	a, l
   4746 6F            [ 4]  778 	ld	l, a
   4747 DD 7E F3      [19]  779 	ld	a, -13 (ix)
   474A 9C            [ 4]  780 	sbc	a, h
   474B 67            [ 4]  781 	ld	h, a
   474C DD 7E ED      [19]  782 	ld	a, -19 (ix)
   474F 95            [ 4]  783 	sub	a, l
   4750 6F            [ 4]  784 	ld	l, a
   4751 DD 7E EE      [19]  785 	ld	a, -18 (ix)
   4754 9C            [ 4]  786 	sbc	a, h
   4755 67            [ 4]  787 	ld	h, a
   4756 D5            [11]  788 	push	de
   4757 E5            [11]  789 	push	hl
   4758 C5            [11]  790 	push	bc
   4759 CD 1B 69      [17]  791 	call	__mulint
   475C F1            [10]  792 	pop	af
   475D F1            [10]  793 	pop	af
   475E 4D            [ 4]  794 	ld	c, l
   475F 44            [ 4]  795 	ld	b, h
   4760 D1            [10]  796 	pop	de
   4761 79            [ 4]  797 	ld	a, c
   4762 12            [ 7]  798 	ld	(de), a
   4763 13            [ 6]  799 	inc	de
   4764 78            [ 4]  800 	ld	a, b
   4765 12            [ 7]  801 	ld	(de), a
   4766 18 16         [12]  802 	jr	00140$
   4768                     803 00131$:
                            804 ;src/IA.c:220: }else if(val > midPoint)
   4768 DD CB F4 46   [20]  805 	bit	0, -12 (ix)
   476C 28 09         [12]  806 	jr	Z,00128$
                            807 ;src/IA.c:223: *grad = SCALA;
   476E 3E 00         [ 7]  808 	ld	a, #0x00
   4770 12            [ 7]  809 	ld	(de), a
   4771 13            [ 6]  810 	inc	de
   4772 3E 01         [ 7]  811 	ld	a, #0x01
   4774 12            [ 7]  812 	ld	(de), a
   4775 18 07         [12]  813 	jr	00140$
   4777                     814 00128$:
                            815 ;src/IA.c:225: *grad = 0;
   4777 3E 00         [ 7]  816 	ld	a, #0x00
   4779 12            [ 7]  817 	ld	(de), a
   477A 13            [ 6]  818 	inc	de
   477B 3E 00         [ 7]  819 	ld	a, #0x00
   477D 12            [ 7]  820 	ld	(de), a
   477E                     821 00140$:
   477E DD F9         [10]  822 	ld	sp, ix
   4780 DD E1         [14]  823 	pop	ix
   4782 C9            [10]  824 	ret
                            825 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            826 ;	---------------------------------
                            827 ; Function defuzzi
                            828 ; ---------------------------------
   4783                     829 _defuzzi::
   4783 DD E5         [15]  830 	push	ix
   4785 DD 21 00 00   [14]  831 	ld	ix,#0
   4789 DD 39         [15]  832 	add	ix,sp
   478B 21 EF FF      [10]  833 	ld	hl, #-17
   478E 39            [11]  834 	add	hl, sp
   478F F9            [ 6]  835 	ld	sp, hl
                            836 ;src/IA.c:239: *re = 0;
   4790 DD 7E 08      [19]  837 	ld	a, 8 (ix)
   4793 DD 77 FC      [19]  838 	ld	-4 (ix), a
   4796 DD 7E 09      [19]  839 	ld	a, 9 (ix)
   4799 DD 77 FD      [19]  840 	ld	-3 (ix), a
   479C DD 6E FC      [19]  841 	ld	l,-4 (ix)
   479F DD 66 FD      [19]  842 	ld	h,-3 (ix)
   47A2 AF            [ 4]  843 	xor	a, a
   47A3 77            [ 7]  844 	ld	(hl), a
   47A4 23            [ 6]  845 	inc	hl
   47A5 77            [ 7]  846 	ld	(hl), a
                            847 ;src/IA.c:241: while(i < 3)
   47A6 21 01 00      [10]  848 	ld	hl, #0x0001
   47A9 39            [11]  849 	add	hl, sp
   47AA DD 75 FE      [19]  850 	ld	-2 (ix), l
   47AD DD 74 FF      [19]  851 	ld	-1 (ix), h
   47B0 0E 00         [ 7]  852 	ld	c, #0x00
   47B2                     853 00101$:
   47B2 79            [ 4]  854 	ld	a, c
   47B3 D6 03         [ 7]  855 	sub	a, #0x03
   47B5 30 53         [12]  856 	jr	NC,00103$
                            857 ;src/IA.c:243: dom = 0;
   47B7 DD 36 F6 00   [19]  858 	ld	-10 (ix), #0x00
   47BB DD 36 F7 00   [19]  859 	ld	-9 (ix), #0x00
                            860 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   47BF 21 07 00      [10]  861 	ld	hl, #0x0007
   47C2 39            [11]  862 	add	hl, sp
   47C3 DD 75 FA      [19]  863 	ld	-6 (ix), l
   47C6 DD 74 FB      [19]  864 	ld	-5 (ix), h
   47C9 DD 46 04      [19]  865 	ld	b, 4 (ix)
   47CC 69            [ 4]  866 	ld	l, c
   47CD 26 00         [ 7]  867 	ld	h, #0x00
   47CF 29            [11]  868 	add	hl, hl
   47D0 EB            [ 4]  869 	ex	de,hl
   47D1 21 CF 6B      [10]  870 	ld	hl, #_fmems
   47D4 19            [11]  871 	add	hl, de
   47D5 7E            [ 7]  872 	ld	a, (hl)
   47D6 DD 77 F8      [19]  873 	ld	-8 (ix), a
   47D9 23            [ 6]  874 	inc	hl
   47DA 7E            [ 7]  875 	ld	a, (hl)
   47DB DD 77 F9      [19]  876 	ld	-7 (ix), a
   47DE C5            [11]  877 	push	bc
   47DF D5            [11]  878 	push	de
   47E0 DD 6E FA      [19]  879 	ld	l,-6 (ix)
   47E3 DD 66 FB      [19]  880 	ld	h,-5 (ix)
   47E6 E5            [11]  881 	push	hl
   47E7 C5            [11]  882 	push	bc
   47E8 33            [ 6]  883 	inc	sp
   47E9 DD 6E F8      [19]  884 	ld	l,-8 (ix)
   47EC DD 66 F9      [19]  885 	ld	h,-7 (ix)
   47EF E5            [11]  886 	push	hl
   47F0 CD 5D 44      [17]  887 	call	_calculateDom
   47F3 F1            [10]  888 	pop	af
   47F4 F1            [10]  889 	pop	af
   47F5 33            [ 6]  890 	inc	sp
   47F6 D1            [10]  891 	pop	de
   47F7 C1            [10]  892 	pop	bc
                            893 ;src/IA.c:245: vDom[i] = dom/SCALA;
   47F8 DD 6E FE      [19]  894 	ld	l,-2 (ix)
   47FB DD 66 FF      [19]  895 	ld	h,-1 (ix)
   47FE 19            [11]  896 	add	hl, de
   47FF DD 5E F7      [19]  897 	ld	e, -9 (ix)
   4802 06 00         [ 7]  898 	ld	b, #0x00
   4804 73            [ 7]  899 	ld	(hl), e
   4805 23            [ 6]  900 	inc	hl
   4806 70            [ 7]  901 	ld	(hl), b
                            902 ;src/IA.c:246: i++;
   4807 0C            [ 4]  903 	inc	c
   4808 18 A8         [12]  904 	jr	00101$
   480A                     905 00103$:
                            906 ;src/IA.c:250: for(i = 0; i<3; i++)
   480A DD 7E FE      [19]  907 	ld	a, -2 (ix)
   480D DD 77 F8      [19]  908 	ld	-8 (ix), a
   4810 DD 7E FF      [19]  909 	ld	a, -1 (ix)
   4813 DD 77 F9      [19]  910 	ld	-7 (ix), a
   4816 DD 36 EF 00   [19]  911 	ld	-17 (ix), #0x00
   481A                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   481A DD 6E EF      [19]  914 	ld	l, -17 (ix)
   481D 26 00         [ 7]  915 	ld	h, #0x00
   481F 29            [11]  916 	add	hl, hl
   4820 4D            [ 4]  917 	ld	c, l
   4821 44            [ 4]  918 	ld	b, h
   4822 DD 6E F8      [19]  919 	ld	l,-8 (ix)
   4825 DD 66 F9      [19]  920 	ld	h,-7 (ix)
   4828 09            [11]  921 	add	hl, bc
   4829 5E            [ 7]  922 	ld	e, (hl)
   482A 23            [ 6]  923 	inc	hl
   482B 56            [ 7]  924 	ld	d, (hl)
   482C 21 BD 6B      [10]  925 	ld	hl, #_aceleracion
   482F 09            [11]  926 	add	hl, bc
   4830 4E            [ 7]  927 	ld	c, (hl)
   4831 23            [ 6]  928 	inc	hl
   4832 46            [ 7]  929 	ld	b, (hl)
   4833 C5            [11]  930 	push	bc
   4834 D5            [11]  931 	push	de
   4835 CD 1B 69      [17]  932 	call	__mulint
   4838 F1            [10]  933 	pop	af
   4839 F1            [10]  934 	pop	af
   483A 4D            [ 4]  935 	ld	c, l
   483B 44            [ 4]  936 	ld	b, h
   483C DD 6E FC      [19]  937 	ld	l,-4 (ix)
   483F DD 66 FD      [19]  938 	ld	h,-3 (ix)
   4842 5E            [ 7]  939 	ld	e, (hl)
   4843 23            [ 6]  940 	inc	hl
   4844 66            [ 7]  941 	ld	h, (hl)
   4845 6B            [ 4]  942 	ld	l, e
   4846 09            [11]  943 	add	hl,bc
   4847 4D            [ 4]  944 	ld	c, l
   4848 44            [ 4]  945 	ld	b, h
   4849 DD 6E FC      [19]  946 	ld	l,-4 (ix)
   484C DD 66 FD      [19]  947 	ld	h,-3 (ix)
   484F 71            [ 7]  948 	ld	(hl), c
   4850 23            [ 6]  949 	inc	hl
   4851 70            [ 7]  950 	ld	(hl), b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   4852 DD 34 EF      [23]  952 	inc	-17 (ix)
   4855 DD 7E EF      [19]  953 	ld	a, -17 (ix)
   4858 D6 03         [ 7]  954 	sub	a, #0x03
   485A 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   485C DD 6E 06      [19]  957 	ld	l,6 (ix)
   485F DD 66 07      [19]  958 	ld	h,7 (ix)
   4862 23            [ 6]  959 	inc	hl
   4863 7E            [ 7]  960 	ld	a, (hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   4864 DD 6E FC      [19]  962 	ld	l,-4 (ix)
   4867 DD 66 FD      [19]  963 	ld	h,-3 (ix)
   486A 5E            [ 7]  964 	ld	e, (hl)
   486B 23            [ 6]  965 	inc	hl
   486C 56            [ 7]  966 	ld	d, (hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   486D B7            [ 4]  968 	or	a, a
   486E 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   4870 DD 6E FC      [19]  971 	ld	l,-4 (ix)
   4873 DD 66 FD      [19]  972 	ld	h,-3 (ix)
   4876 73            [ 7]  973 	ld	(hl), e
   4877 23            [ 6]  974 	inc	hl
   4878 72            [ 7]  975 	ld	(hl), d
   4879 18 10         [12]  976 	jr	00110$
   487B                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   487B AF            [ 4]  979 	xor	a, a
   487C 93            [ 4]  980 	sub	a, e
   487D 5F            [ 4]  981 	ld	e, a
   487E 3E 00         [ 7]  982 	ld	a, #0x00
   4880 9A            [ 4]  983 	sbc	a, d
   4881 4F            [ 4]  984 	ld	c, a
   4882 DD 6E FC      [19]  985 	ld	l,-4 (ix)
   4885 DD 66 FD      [19]  986 	ld	h,-3 (ix)
   4888 73            [ 7]  987 	ld	(hl), e
   4889 23            [ 6]  988 	inc	hl
   488A 71            [ 7]  989 	ld	(hl), c
   488B                     990 00110$:
   488B DD F9         [10]  991 	ld	sp, ix
   488D DD E1         [14]  992 	pop	ix
   488F C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   4890                     998 _calcule::
   4890 DD E5         [15]  999 	push	ix
   4892 DD 21 00 00   [14] 1000 	ld	ix,#0
   4896 DD 39         [15] 1001 	add	ix,sp
   4898 F5            [11] 1002 	push	af
   4899 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   489A DD 36 FE 00   [19] 1005 	ld	-2 (ix), #0x00
   489E DD 36 FF 00   [19] 1006 	ld	-1 (ix), #0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   48A2 DD 36 FD 00   [19] 1008 	ld	-3 (ix), #0x00
   48A6                    1009 00103$:
   48A6 DD 7E FD      [19] 1010 	ld	a, -3 (ix)
   48A9 DD 96 04      [19] 1011 	sub	a, 4 (ix)
   48AC 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   48AE FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   48B2 FD 39         [15] 1015 	add	iy,sp
   48B4 DD 6E FD      [19] 1016 	ld	l, -3 (ix)
   48B7 26 00         [ 7] 1017 	ld	h, #0x00
   48B9 29            [11] 1018 	add	hl, hl
   48BA 01 C3 6B      [10] 1019 	ld	bc,#_vRulesx
   48BD 09            [11] 1020 	add	hl,bc
   48BE 4D            [ 4] 1021 	ld	c,l
   48BF 44            [ 4] 1022 	ld	b,h
   48C0 7E            [ 7] 1023 	ld	a, (hl)
   48C1 23            [ 6] 1024 	inc	hl
   48C2 66            [ 7] 1025 	ld	h, (hl)
   48C3 6F            [ 4] 1026 	ld	l, a
   48C4 5E            [ 7] 1027 	ld	e, (hl)
   48C5 23            [ 6] 1028 	inc	hl
   48C6 56            [ 7] 1029 	ld	d, (hl)
   48C7 C5            [11] 1030 	push	bc
   48C8 FD E5         [15] 1031 	push	iy
   48CA DD 7E 05      [19] 1032 	ld	a, 5 (ix)
   48CD F5            [11] 1033 	push	af
   48CE 33            [ 6] 1034 	inc	sp
   48CF D5            [11] 1035 	push	de
   48D0 CD 5D 44      [17] 1036 	call	_calculateDom
   48D3 F1            [10] 1037 	pop	af
   48D4 F1            [10] 1038 	pop	af
   48D5 33            [ 6] 1039 	inc	sp
   48D6 C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   48D7 DD 5E 06      [19] 1042 	ld	e,6 (ix)
   48DA DD 56 07      [19] 1043 	ld	d,7 (ix)
   48DD 69            [ 4] 1044 	ld	l, c
   48DE 60            [ 4] 1045 	ld	h, b
   48DF 7E            [ 7] 1046 	ld	a, (hl)
   48E0 23            [ 6] 1047 	inc	hl
   48E1 66            [ 7] 1048 	ld	h, (hl)
   48E2 6F            [ 4] 1049 	ld	l, a
   48E3 23            [ 6] 1050 	inc	hl
   48E4 23            [ 6] 1051 	inc	hl
   48E5 7E            [ 7] 1052 	ld	a, (hl)
   48E6 23            [ 6] 1053 	inc	hl
   48E7 66            [ 7] 1054 	ld	h, (hl)
   48E8 6F            [ 4] 1055 	ld	l, a
   48E9 23            [ 6] 1056 	inc	hl
   48EA 23            [ 6] 1057 	inc	hl
   48EB 4E            [ 7] 1058 	ld	c, (hl)
   48EC 23            [ 6] 1059 	inc	hl
   48ED 46            [ 7] 1060 	ld	b, (hl)
   48EE D5            [11] 1061 	push	de
   48EF DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   48F2 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   48F5 E5            [11] 1064 	push	hl
   48F6 C5            [11] 1065 	push	bc
   48F7 CD 1B 69      [17] 1066 	call	__mulint
   48FA F1            [10] 1067 	pop	af
   48FB F1            [10] 1068 	pop	af
   48FC 4D            [ 4] 1069 	ld	c, l
   48FD 44            [ 4] 1070 	ld	b, h
   48FE D1            [10] 1071 	pop	de
   48FF 6B            [ 4] 1072 	ld	l, e
   4900 62            [ 4] 1073 	ld	h, d
   4901 7E            [ 7] 1074 	ld	a, (hl)
   4902 23            [ 6] 1075 	inc	hl
   4903 66            [ 7] 1076 	ld	h, (hl)
   4904 6F            [ 4] 1077 	ld	l, a
   4905 09            [11] 1078 	add	hl, bc
   4906 4C            [ 4] 1079 	ld	c, h
   4907 06 00         [ 7] 1080 	ld	b, #0x00
   4909 79            [ 4] 1081 	ld	a, c
   490A 12            [ 7] 1082 	ld	(de), a
   490B 13            [ 6] 1083 	inc	de
   490C 78            [ 4] 1084 	ld	a, b
   490D 12            [ 7] 1085 	ld	(de), a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   490E DD 34 FD      [23] 1087 	inc	-3 (ix)
   4911 18 93         [12] 1088 	jr	00103$
   4913                    1089 00105$:
   4913 DD F9         [10] 1090 	ld	sp, ix
   4915 DD E1         [14] 1091 	pop	ix
   4917 C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   4918                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   4918 21 04 00      [10] 1099 	ld	hl, #4
   491B 39            [11] 1100 	add	hl, sp
   491C 4E            [ 7] 1101 	ld	c, (hl)
   491D 23            [ 6] 1102 	inc	hl
   491E 46            [ 7] 1103 	ld	b, (hl)
   491F 59            [ 4] 1104 	ld	e, c
   4920 50            [ 4] 1105 	ld	d, b
   4921 13            [ 6] 1106 	inc	de
   4922 AF            [ 4] 1107 	xor	a, a
   4923 12            [ 7] 1108 	ld	(de), a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   4924 AF            [ 4] 1110 	xor	a, a
   4925 02            [ 7] 1111 	ld	(bc), a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   4926 21 03 00      [10] 1113 	ld	hl, #2+1
   4929 39            [11] 1114 	add	hl, sp
   492A CB 7E         [12] 1115 	bit	7, (hl)
   492C 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   492E 3E 01         [ 7] 1118 	ld	a, #0x01
   4930 02            [ 7] 1119 	ld	(bc), a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   4931 AF            [ 4] 1121 	xor	a, a
   4932 12            [ 7] 1122 	ld	(de), a
   4933 C9            [10] 1123 	ret
   4934                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   4934 AF            [ 4] 1126 	xor	a, a
   4935 FD 21 02 00   [14] 1127 	ld	iy, #2
   4939 FD 39         [15] 1128 	add	iy, sp
   493B FD BE 00      [19] 1129 	cp	a, 0 (iy)
   493E FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   4941 E2 46 49      [10] 1131 	jp	PO, 00116$
   4944 EE 80         [ 7] 1132 	xor	a, #0x80
   4946                    1133 00116$:
   4946 F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   4947 3E 01         [ 7] 1136 	ld	a, #0x01
   4949 12            [ 7] 1137 	ld	(de), a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   494A AF            [ 4] 1139 	xor	a, a
   494B 02            [ 7] 1140 	ld	(bc), a
   494C C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   494D                    1146 _fuzzificacion::
   494D DD E5         [15] 1147 	push	ix
   494F DD 21 00 00   [14] 1148 	ld	ix,#0
   4953 DD 39         [15] 1149 	add	ix,sp
   4955 21 EE FF      [10] 1150 	ld	hl, #-18
   4958 39            [11] 1151 	add	hl, sp
   4959 F9            [ 6] 1152 	ld	sp, hl
                           1153 ;src/IA.c:299: ball = &ballX;
   495A 21 06 00      [10] 1154 	ld	hl, #0x0006
   495D 39            [11] 1155 	add	hl, sp
   495E DD 75 FA      [19] 1156 	ld	-6 (ix), l
   4961 DD 74 FB      [19] 1157 	ld	-5 (ix), h
   4964 4D            [ 4] 1158 	ld	c, l
   4965 44            [ 4] 1159 	ld	b, h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   4966 DD 5E 08      [19] 1161 	ld	e, 8 (ix)
   4969 16 00         [ 7] 1162 	ld	d, #0x00
   496B DD 6E 0A      [19] 1163 	ld	l, 10 (ix)
   496E 26 00         [ 7] 1164 	ld	h, #0x00
   4970 7B            [ 4] 1165 	ld	a, e
   4971 95            [ 4] 1166 	sub	a, l
   4972 DD 77 FC      [19] 1167 	ld	-4 (ix), a
   4975 7A            [ 4] 1168 	ld	a, d
   4976 9C            [ 4] 1169 	sbc	a, h
   4977 DD 77 FD      [19] 1170 	ld	-3 (ix), a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   497A DD 6E 09      [19] 1172 	ld	l, 9 (ix)
   497D 26 00         [ 7] 1173 	ld	h, #0x00
   497F DD 5E 0B      [19] 1174 	ld	e, 11 (ix)
   4982 16 00         [ 7] 1175 	ld	d, #0x00
   4984 7D            [ 4] 1176 	ld	a, l
   4985 93            [ 4] 1177 	sub	a, e
   4986 DD 77 FE      [19] 1178 	ld	-2 (ix), a
   4989 7C            [ 4] 1179 	ld	a, h
   498A 9A            [ 4] 1180 	sbc	a, d
   498B DD 77 FF      [19] 1181 	ld	-1 (ix), a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   498E 3E 6F         [ 7] 1183 	ld	a, #0x6f
   4990 93            [ 4] 1184 	sub	a, e
   4991 DD 77 F6      [19] 1185 	ld	-10 (ix), a
   4994 3E 00         [ 7] 1186 	ld	a, #0x00
   4996 9A            [ 4] 1187 	sbc	a, d
   4997 DD 77 F7      [19] 1188 	ld	-9 (ix), a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   499A 59            [ 4] 1190 	ld	e, c
   499B 50            [ 4] 1191 	ld	d, b
   499C 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   499D 3E FE         [ 7] 1194 	ld	a, #0xfe
   499F DD BE FC      [19] 1195 	cp	a, -4 (ix)
   49A2 3E FF         [ 7] 1196 	ld	a, #0xff
   49A4 DD 9E FD      [19] 1197 	sbc	a, -3 (ix)
   49A7 E2 AC 49      [10] 1198 	jp	PO, 00148$
   49AA EE 80         [ 7] 1199 	xor	a, #0x80
   49AC                    1200 00148$:
   49AC FA B6 49      [10] 1201 	jp	M, 00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   49AF 3E 01         [ 7] 1203 	ld	a, #0x01
   49B1 02            [ 7] 1204 	ld	(bc), a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   49B2 AF            [ 4] 1206 	xor	a, a
   49B3 12            [ 7] 1207 	ld	(de), a
   49B4 18 05         [12] 1208 	jr	00103$
   49B6                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   49B6 3E 01         [ 7] 1211 	ld	a, #0x01
   49B8 12            [ 7] 1212 	ld	(de), a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   49B9 AF            [ 4] 1214 	xor	a, a
   49BA 02            [ 7] 1215 	ld	(bc), a
   49BB                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   49BB AF            [ 4] 1218 	xor	a, a
   49BC DD BE FC      [19] 1219 	cp	a, -4 (ix)
   49BF DD 9E FD      [19] 1220 	sbc	a, -3 (ix)
   49C2 E2 C7 49      [10] 1221 	jp	PO, 00149$
   49C5 EE 80         [ 7] 1222 	xor	a, #0x80
   49C7                    1223 00149$:
   49C7 07            [ 4] 1224 	rlca
   49C8 E6 01         [ 7] 1225 	and	a,#0x01
   49CA 4F            [ 4] 1226 	ld	c, a
   49CB DD 7E F6      [19] 1227 	ld	a, -10 (ix)
   49CE DD 96 FE      [19] 1228 	sub	a, -2 (ix)
   49D1 DD 7E F7      [19] 1229 	ld	a, -9 (ix)
   49D4 DD 9E FF      [19] 1230 	sbc	a, -1 (ix)
   49D7 E2 DC 49      [10] 1231 	jp	PO, 00150$
   49DA EE 80         [ 7] 1232 	xor	a, #0x80
   49DC                    1233 00150$:
   49DC F2 F6 49      [10] 1234 	jp	P, 00109$
   49DF 79            [ 4] 1235 	ld	a, c
   49E0 B7            [ 4] 1236 	or	a, a
   49E1 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   49E3 21 04 00      [10] 1239 	ld	hl, #0x0004
   49E6 39            [11] 1240 	add	hl, sp
   49E7 E5            [11] 1241 	push	hl
   49E8 DD 6E F6      [19] 1242 	ld	l,-10 (ix)
   49EB DD 66 F7      [19] 1243 	ld	h,-9 (ix)
   49EE E5            [11] 1244 	push	hl
   49EF CD 18 49      [17] 1245 	call	_calcularb_direc
   49F2 F1            [10] 1246 	pop	af
   49F3 F1            [10] 1247 	pop	af
   49F4 18 3C         [12] 1248 	jr	00110$
   49F6                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   49F6 DD 7E FE      [19] 1251 	ld	a, -2 (ix)
   49F9 DD 96 F6      [19] 1252 	sub	a, -10 (ix)
   49FC DD 7E FF      [19] 1253 	ld	a, -1 (ix)
   49FF DD 9E F7      [19] 1254 	sbc	a, -9 (ix)
   4A02 E2 07 4A      [10] 1255 	jp	PO, 00151$
   4A05 EE 80         [ 7] 1256 	xor	a, #0x80
   4A07                    1257 00151$:
   4A07 F2 21 4A      [10] 1258 	jp	P, 00105$
   4A0A 79            [ 4] 1259 	ld	a, c
   4A0B B7            [ 4] 1260 	or	a, a
   4A0C 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   4A0E 21 04 00      [10] 1263 	ld	hl, #0x0004
   4A11 39            [11] 1264 	add	hl, sp
   4A12 E5            [11] 1265 	push	hl
   4A13 DD 6E F6      [19] 1266 	ld	l,-10 (ix)
   4A16 DD 66 F7      [19] 1267 	ld	h,-9 (ix)
   4A19 E5            [11] 1268 	push	hl
   4A1A CD 18 49      [17] 1269 	call	_calcularb_direc
   4A1D F1            [10] 1270 	pop	af
   4A1E F1            [10] 1271 	pop	af
   4A1F 18 11         [12] 1272 	jr	00110$
   4A21                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   4A21 21 04 00      [10] 1275 	ld	hl, #0x0004
   4A24 39            [11] 1276 	add	hl, sp
   4A25 E5            [11] 1277 	push	hl
   4A26 DD 6E FE      [19] 1278 	ld	l,-2 (ix)
   4A29 DD 66 FF      [19] 1279 	ld	h,-1 (ix)
   4A2C E5            [11] 1280 	push	hl
   4A2D CD 18 49      [17] 1281 	call	_calcularb_direc
   4A30 F1            [10] 1282 	pop	af
   4A31 F1            [10] 1283 	pop	af
   4A32                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   4A32 DD 4E FC      [19] 1286 	ld	c, -4 (ix)
   4A35 DD 71 F9      [19] 1287 	ld	-7 (ix), c
   4A38 DD 36 F8 00   [19] 1288 	ld	-8 (ix), #0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   4A3C DD 46 FE      [19] 1290 	ld	b, -2 (ix)
   4A3F 0E 00         [ 7] 1291 	ld	c, #0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   4A41 21 02 00      [10] 1293 	ld	hl, #0x0002
   4A44 39            [11] 1294 	add	hl, sp
   4A45 DD 56 F8      [19] 1295 	ld	d, -8 (ix)
   4A48 C5            [11] 1296 	push	bc
   4A49 E5            [11] 1297 	push	hl
   4A4A 1E 03         [ 7] 1298 	ld	e, #0x03
   4A4C D5            [11] 1299 	push	de
   4A4D CD 90 48      [17] 1300 	call	_calcule
   4A50 F1            [10] 1301 	pop	af
   4A51 F1            [10] 1302 	pop	af
   4A52 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   4A53 21 00 00      [10] 1305 	ld	hl, #0x0000
   4A56 39            [11] 1306 	add	hl, sp
   4A57 51            [ 4] 1307 	ld	d, c
   4A58 C5            [11] 1308 	push	bc
   4A59 E5            [11] 1309 	push	hl
   4A5A 1E 03         [ 7] 1310 	ld	e, #0x03
   4A5C D5            [11] 1311 	push	de
   4A5D CD 90 48      [17] 1312 	call	_calcule
   4A60 F1            [10] 1313 	pop	af
   4A61 F1            [10] 1314 	pop	af
   4A62 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   4A63 78            [ 4] 1317 	ld	a, b
   4A64 B1            [ 4] 1318 	or	a,c
   4A65 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   4A67 DD 4E FA      [19] 1321 	ld	c,-6 (ix)
   4A6A DD 46 FB      [19] 1322 	ld	b,-5 (ix)
   4A6D DD 6E 04      [19] 1323 	ld	l,4 (ix)
   4A70 DD 66 05      [19] 1324 	ld	h,5 (ix)
   4A73 E5            [11] 1325 	push	hl
   4A74 C5            [11] 1326 	push	bc
   4A75 DD 6E F0      [19] 1327 	ld	l,-16 (ix)
   4A78 DD 66 F1      [19] 1328 	ld	h,-15 (ix)
   4A7B E5            [11] 1329 	push	hl
   4A7C CD 83 47      [17] 1330 	call	_defuzzi
   4A7F 21 06 00      [10] 1331 	ld	hl, #6
   4A82 39            [11] 1332 	add	hl, sp
   4A83 F9            [ 6] 1333 	ld	sp, hl
                           1334 ;src/IA.c:336: ax = 0;
   4A84                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   4A84 DD 7E F9      [19] 1337 	ld	a, -7 (ix)
   4A87 DD B6 F8      [19] 1338 	or	a,-8 (ix)
   4A8A 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   4A8C 21 04 00      [10] 1341 	ld	hl, #0x0004
   4A8F 39            [11] 1342 	add	hl, sp
   4A90 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   4A93 DD 46 07      [19] 1344 	ld	b,7 (ix)
   4A96 C5            [11] 1345 	push	bc
   4A97 E5            [11] 1346 	push	hl
   4A98 DD 6E EE      [19] 1347 	ld	l,-18 (ix)
   4A9B DD 66 EF      [19] 1348 	ld	h,-17 (ix)
   4A9E E5            [11] 1349 	push	hl
   4A9F CD 83 47      [17] 1350 	call	_defuzzi
   4AA2 21 06 00      [10] 1351 	ld	hl, #6
   4AA5 39            [11] 1352 	add	hl, sp
   4AA6 F9            [ 6] 1353 	ld	sp, hl
                           1354 ;src/IA.c:341: ay = 0;
   4AA7                    1355 00118$:
   4AA7 DD F9         [10] 1356 	ld	sp, ix
   4AA9 DD E1         [14] 1357 	pop	ix
   4AAB C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   4AAC                    1363 _moveIA::
   4AAC DD E5         [15] 1364 	push	ix
   4AAE DD 21 00 00   [14] 1365 	ld	ix,#0
   4AB2 DD 39         [15] 1366 	add	ix,sp
   4AB4 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4AB5 DD 7E 04      [19] 1369 	ld	a, 4 (ix)
   4AB8 DD 77 FE      [19] 1370 	ld	-2 (ix), a
   4ABB DD 7E 05      [19] 1371 	ld	a, 5 (ix)
   4ABE DD 77 FF      [19] 1372 	ld	-1 (ix), a
   4AC1 E1            [10] 1373 	pop	hl
   4AC2 E5            [11] 1374 	push	hl
   4AC3 23            [ 6] 1375 	inc	hl
   4AC4 23            [ 6] 1376 	inc	hl
   4AC5 4E            [ 7] 1377 	ld	c, (hl)
   4AC6 23            [ 6] 1378 	inc	hl
   4AC7 46            [ 7] 1379 	ld	b, (hl)
   4AC8 DD 6E 08      [19] 1380 	ld	l,8 (ix)
   4ACB DD 66 09      [19] 1381 	ld	h,9 (ix)
   4ACE 23            [ 6] 1382 	inc	hl
   4ACF 23            [ 6] 1383 	inc	hl
   4AD0 5E            [ 7] 1384 	ld	e, (hl)
   4AD1 23            [ 6] 1385 	inc	hl
   4AD2 56            [ 7] 1386 	ld	d, (hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   4AD3 DD 7E FE      [19] 1388 	ld	a, -2 (ix)
   4AD6 C6 0C         [ 7] 1389 	add	a, #0x0c
   4AD8 6F            [ 4] 1390 	ld	l, a
   4AD9 DD 7E FF      [19] 1391 	ld	a, -1 (ix)
   4ADC CE 00         [ 7] 1392 	adc	a, #0x00
   4ADE 67            [ 4] 1393 	ld	h, a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   4ADF 7B            [ 4] 1395 	ld	a, e
   4AE0 91            [ 4] 1396 	sub	a, c
   4AE1 7A            [ 4] 1397 	ld	a, d
   4AE2 98            [ 4] 1398 	sbc	a, b
   4AE3 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   4AE5 36 E0         [10] 1401 	ld	(hl), #0xe0
   4AE7 23            [ 6] 1402 	inc	hl
   4AE8 36 FF         [10] 1403 	ld	(hl), #0xff
   4AEA 18 0B         [12] 1404 	jr	00106$
   4AEC                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   4AEC 79            [ 4] 1407 	ld	a, c
   4AED 93            [ 4] 1408 	sub	a, e
   4AEE 78            [ 4] 1409 	ld	a, b
   4AEF 9A            [ 4] 1410 	sbc	a, d
   4AF0 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   4AF2 36 20         [10] 1413 	ld	(hl), #0x20
   4AF4 23            [ 6] 1414 	inc	hl
   4AF5 36 00         [10] 1415 	ld	(hl), #0x00
   4AF7                    1416 00106$:
   4AF7 DD F9         [10] 1417 	ld	sp, ix
   4AF9 DD E1         [14] 1418 	pop	ix
   4AFB C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   6BD5                    1422 __xinit__vRulesx:
   6BD5 45 44              1423 	.dw _rulex
   6BD7 49 44              1424 	.dw _rulex1
   6BD9 4D 44              1425 	.dw _rulex2
   6BDB                    1426 __xinit__vRulesy:
   6BDB 51 44              1427 	.dw _ruley
   6BDD 55 44              1428 	.dw _ruley1
   6BDF 59 44              1429 	.dw _ruley2
   6BE1                    1430 __xinit__fmems:
   6BE1 2F 44              1431 	.dw _acelPo
   6BE3 3A 44              1432 	.dw _acelMed
   6BE5 24 44              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
