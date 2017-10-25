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
   197D                      41 _aceleracion::
   197D                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   1983                      47 _vRulesx::
   1983                      48 	.ds 6
   1989                      49 _vRulesy::
   1989                      50 	.ds 6
   198F                      51 _fmems::
   198F                      52 	.ds 6
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
   0100                      77 _initAcel::
   0100 DD E5         [15]   78 	push	ix
   0102 DD 21 00 00   [14]   79 	ld	ix,#0
   0106 DD 39         [15]   80 	add	ix,sp
   0108 21 F8 FF      [10]   81 	ld	hl,#-8
   010B 39            [11]   82 	add	hl,sp
   010C F9            [ 6]   83 	ld	sp,hl
                             84 ;src/IA.c:129: u8 i = 0;
   010D 1E 00         [ 7]   85 	ld	e,#0x00
                             86 ;src/IA.c:130: switch(nivel){
   010F DD 7E 04      [19]   87 	ld	a,4 (ix)
   0112 B7            [ 4]   88 	or	a, a
   0113 28 09         [12]   89 	jr	Z,00101$
   0115 DD 7E 04      [19]   90 	ld	a,4 (ix)
   0118 3D            [ 4]   91 	dec	a
   0119 28 5F         [12]   92 	jr	Z,00105$
   011B C3 D4 01      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   011E                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   011E 21 00 00      [10]   97 	ld	hl,#0x0000
   0121 39            [11]   98 	add	hl,sp
   0122 DD 75 FE      [19]   99 	ld	-2 (ix),l
   0125 DD 74 FF      [19]  100 	ld	-1 (ix),h
   0128 DD 6E FE      [19]  101 	ld	l,-2 (ix)
   012B DD 66 FF      [19]  102 	ld	h,-1 (ix)
   012E 36 0F         [10]  103 	ld	(hl),#0x0F
   0130 23            [ 6]  104 	inc	hl
   0131 36 00         [10]  105 	ld	(hl),#0x00
   0133 DD 6E FE      [19]  106 	ld	l,-2 (ix)
   0136 DD 66 FF      [19]  107 	ld	h,-1 (ix)
   0139 23            [ 6]  108 	inc	hl
   013A 23            [ 6]  109 	inc	hl
   013B 36 14         [10]  110 	ld	(hl),#0x14
   013D 23            [ 6]  111 	inc	hl
   013E 36 00         [10]  112 	ld	(hl),#0x00
   0140 DD 7E FE      [19]  113 	ld	a,-2 (ix)
   0143 C6 04         [ 7]  114 	add	a, #0x04
   0145 6F            [ 4]  115 	ld	l,a
   0146 DD 7E FF      [19]  116 	ld	a,-1 (ix)
   0149 CE 00         [ 7]  117 	adc	a, #0x00
   014B 67            [ 4]  118 	ld	h,a
   014C 36 17         [10]  119 	ld	(hl),#0x17
   014E 23            [ 6]  120 	inc	hl
   014F 36 00         [10]  121 	ld	(hl),#0x00
                            122 ;src/IA.c:133: while(i<3)
   0151 01 7D 19      [10]  123 	ld	bc,#_aceleracion+0
   0154 1E 00         [ 7]  124 	ld	e,#0x00
   0156                     125 00102$:
   0156 7B            [ 4]  126 	ld	a,e
   0157 D6 03         [ 7]  127 	sub	a, #0x03
   0159 30 1F         [12]  128 	jr	NC,00124$
                            129 ;src/IA.c:135: aceleracion[i] = aux[i];
   015B 6B            [ 4]  130 	ld	l,e
   015C 26 00         [ 7]  131 	ld	h,#0x00
   015E 29            [11]  132 	add	hl, hl
   015F E5            [11]  133 	push	hl
   0160 FD E1         [14]  134 	pop	iy
   0162 FD 09         [15]  135 	add	iy, bc
   0164 DD 7E FE      [19]  136 	ld	a,-2 (ix)
   0167 85            [ 4]  137 	add	a, l
   0168 6F            [ 4]  138 	ld	l,a
   0169 DD 7E FF      [19]  139 	ld	a,-1 (ix)
   016C 8C            [ 4]  140 	adc	a, h
   016D 67            [ 4]  141 	ld	h,a
   016E 7E            [ 7]  142 	ld	a, (hl)
   016F 23            [ 6]  143 	inc	hl
   0170 56            [ 7]  144 	ld	d,(hl)
   0171 FD 77 00      [19]  145 	ld	0 (iy), a
   0174 FD 72 01      [19]  146 	ld	1 (iy),d
                            147 ;src/IA.c:136: i++;
   0177 1C            [ 4]  148 	inc	e
   0178 18 DC         [12]  149 	jr	00102$
                            150 ;src/IA.c:139: case 1:{
   017A                     151 00124$:
   017A                     152 00105$:
                            153 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   017A 21 00 00      [10]  154 	ld	hl,#0x0000
   017D 39            [11]  155 	add	hl,sp
   017E DD 75 FE      [19]  156 	ld	-2 (ix),l
   0181 DD 74 FF      [19]  157 	ld	-1 (ix),h
   0184 DD 6E FE      [19]  158 	ld	l,-2 (ix)
   0187 DD 66 FF      [19]  159 	ld	h,-1 (ix)
   018A 36 17         [10]  160 	ld	(hl),#0x17
   018C 23            [ 6]  161 	inc	hl
   018D 36 00         [10]  162 	ld	(hl),#0x00
   018F DD 6E FE      [19]  163 	ld	l,-2 (ix)
   0192 DD 66 FF      [19]  164 	ld	h,-1 (ix)
   0195 23            [ 6]  165 	inc	hl
   0196 23            [ 6]  166 	inc	hl
   0197 36 19         [10]  167 	ld	(hl),#0x19
   0199 23            [ 6]  168 	inc	hl
   019A 36 00         [10]  169 	ld	(hl),#0x00
   019C DD 7E FE      [19]  170 	ld	a,-2 (ix)
   019F C6 04         [ 7]  171 	add	a, #0x04
   01A1 6F            [ 4]  172 	ld	l,a
   01A2 DD 7E FF      [19]  173 	ld	a,-1 (ix)
   01A5 CE 00         [ 7]  174 	adc	a, #0x00
   01A7 67            [ 4]  175 	ld	h,a
   01A8 36 33         [10]  176 	ld	(hl),#0x33
   01AA 23            [ 6]  177 	inc	hl
   01AB 36 00         [10]  178 	ld	(hl),#0x00
                            179 ;src/IA.c:141: while(i<3)
   01AD 01 7D 19      [10]  180 	ld	bc,#_aceleracion+0
   01B0                     181 00106$:
   01B0 7B            [ 4]  182 	ld	a,e
   01B1 D6 03         [ 7]  183 	sub	a, #0x03
   01B3 30 1F         [12]  184 	jr	NC,00125$
                            185 ;src/IA.c:143: aceleracion[i] = aux[i];
   01B5 6B            [ 4]  186 	ld	l,e
   01B6 26 00         [ 7]  187 	ld	h,#0x00
   01B8 29            [11]  188 	add	hl, hl
   01B9 E5            [11]  189 	push	hl
   01BA FD E1         [14]  190 	pop	iy
   01BC FD 09         [15]  191 	add	iy, bc
   01BE DD 7E FE      [19]  192 	ld	a,-2 (ix)
   01C1 85            [ 4]  193 	add	a, l
   01C2 6F            [ 4]  194 	ld	l,a
   01C3 DD 7E FF      [19]  195 	ld	a,-1 (ix)
   01C6 8C            [ 4]  196 	adc	a, h
   01C7 67            [ 4]  197 	ld	h,a
   01C8 7E            [ 7]  198 	ld	a, (hl)
   01C9 23            [ 6]  199 	inc	hl
   01CA 56            [ 7]  200 	ld	d,(hl)
   01CB FD 77 00      [19]  201 	ld	0 (iy), a
   01CE FD 72 01      [19]  202 	ld	1 (iy),d
                            203 ;src/IA.c:144: i++;
   01D1 1C            [ 4]  204 	inc	e
   01D2 18 DC         [12]  205 	jr	00106$
                            206 ;src/IA.c:147: default:{
   01D4                     207 00125$:
   01D4                     208 00109$:
                            209 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   01D4 21 00 00      [10]  210 	ld	hl,#0x0000
   01D7 39            [11]  211 	add	hl,sp
   01D8 4D            [ 4]  212 	ld	c,l
   01D9 44            [ 4]  213 	ld	b,h
   01DA 36 19         [10]  214 	ld	(hl),#0x19
   01DC 23            [ 6]  215 	inc	hl
   01DD 36 00         [10]  216 	ld	(hl),#0x00
   01DF 69            [ 4]  217 	ld	l, c
   01E0 60            [ 4]  218 	ld	h, b
   01E1 23            [ 6]  219 	inc	hl
   01E2 23            [ 6]  220 	inc	hl
   01E3 36 33         [10]  221 	ld	(hl),#0x33
   01E5 23            [ 6]  222 	inc	hl
   01E6 36 00         [10]  223 	ld	(hl),#0x00
   01E8 21 04 00      [10]  224 	ld	hl,#0x0004
   01EB 09            [11]  225 	add	hl,bc
   01EC 36 4C         [10]  226 	ld	(hl),#0x4C
   01EE 23            [ 6]  227 	inc	hl
   01EF 36 00         [10]  228 	ld	(hl),#0x00
                            229 ;src/IA.c:149: while(i<3)
   01F1                     230 00110$:
   01F1 7B            [ 4]  231 	ld	a,e
   01F2 D6 03         [ 7]  232 	sub	a, #0x03
   01F4 30 1B         [12]  233 	jr	NC,00114$
                            234 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   01F6 6B            [ 4]  235 	ld	l,e
   01F7 26 00         [ 7]  236 	ld	h,#0x00
   01F9 29            [11]  237 	add	hl, hl
   01FA FD 21 7D 19   [14]  238 	ld	iy,#_aceleracion
   01FE C5            [11]  239 	push	bc
   01FF 4D            [ 4]  240 	ld	c, l
   0200 44            [ 4]  241 	ld	b, h
   0201 FD 09         [15]  242 	add	iy, bc
   0203 C1            [10]  243 	pop	bc
   0204 09            [11]  244 	add	hl,bc
   0205 7E            [ 7]  245 	ld	a, (hl)
   0206 23            [ 6]  246 	inc	hl
   0207 66            [ 7]  247 	ld	h,(hl)
   0208 FD 77 00      [19]  248 	ld	0 (iy), a
   020B FD 74 01      [19]  249 	ld	1 (iy),h
                            250 ;src/IA.c:152: i++;
   020E 1C            [ 4]  251 	inc	e
   020F 18 E0         [12]  252 	jr	00110$
                            253 ;src/IA.c:155: }
   0211                     254 00114$:
   0211 DD F9         [10]  255 	ld	sp, ix
   0213 DD E1         [14]  256 	pop	ix
   0215 C9            [10]  257 	ret
   0216                     258 _cerca:
   0216 00 00               259 	.dw #0x0000
   0218 00 05               260 	.dw #0x0500
   021A 01                  261 	.db #0x01	; 1
   021B 00 0A               262 	.dw #0x0A00
   021D 00 0A               263 	.dw #0x0A00
   021F 00 0A               264 	.dw #0x0A00
   0221                     265 _medio:
   0221 00 00               266 	.dw #0x0000
   0223 00 14               267 	.dw #0x1400
   0225 00                  268 	.db #0x00	; 0
   0226 00 14               269 	.dw #0x1400
   0228 00 0A               270 	.dw #0x0A00
   022A 00 0F               271 	.dw #0x0F00
   022C                     272 _lejos:
   022C 00 00               273 	.dw #0x0000
   022E 00 6E               274 	.dw #0x6E00
   0230 02                  275 	.db #0x02	; 2
   0231 00 3C               276 	.dw #0x3C00
   0233 00 19               277 	.dw #0x1900
   0235 00 64               278 	.dw #0x6400
   0237                     279 _acelMu:
   0237 00 00               280 	.dw #0x0000
   0239 80 57               281 	.dw #0x5780
   023B 02                  282 	.db #0x02	; 2
   023C 00 4B               283 	.dw #0x4B00
   023E 00 19               284 	.dw #0x1900
   0240 00 19               285 	.dw #0x1900
   0242                     286 _acelPo:
   0242 00 00               287 	.dw #0x0000
   0244 80 0C               288 	.dw #0x0C80
   0246 01                  289 	.db #0x01	; 1
   0247 00 19               290 	.dw #0x1900
   0249 00 19               291 	.dw #0x1900
   024B 00 19               292 	.dw #0x1900
   024D                     293 _acelMed:
   024D 00 00               294 	.dw #0x0000
   024F 00 32               295 	.dw #0x3200
   0251 00                  296 	.db #0x00	; 0
   0252 00 32               297 	.dw #0x3200
   0254 00 19               298 	.dw #0x1900
   0256 00 19               299 	.dw #0x1900
   0258                     300 _rulex:
   0258 16 02               301 	.dw _cerca
   025A 37 02               302 	.dw _acelMu
   025C                     303 _rulex1:
   025C 21 02               304 	.dw _medio
   025E 4D 02               305 	.dw _acelMed
   0260                     306 _rulex2:
   0260 2C 02               307 	.dw _lejos
   0262 42 02               308 	.dw _acelPo
   0264                     309 _ruley:
   0264 16 02               310 	.dw _cerca
   0266 37 02               311 	.dw _acelMu
   0268                     312 _ruley1:
   0268 21 02               313 	.dw _medio
   026A 4D 02               314 	.dw _acelMed
   026C                     315 _ruley2:
   026C 2C 02               316 	.dw _lejos
   026E 42 02               317 	.dw _acelPo
                            318 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            319 ;	---------------------------------
                            320 ; Function calculateDom
                            321 ; ---------------------------------
   0270                     322 _calculateDom::
   0270 DD E5         [15]  323 	push	ix
   0272 DD 21 00 00   [14]  324 	ld	ix,#0
   0276 DD 39         [15]  325 	add	ix,sp
   0278 21 ED FF      [10]  326 	ld	hl,#-19
   027B 39            [11]  327 	add	hl,sp
   027C F9            [ 6]  328 	ld	sp,hl
                            329 ;src/IA.c:161: *grad = 0.0;
   027D DD 5E 07      [19]  330 	ld	e,7 (ix)
   0280 DD 56 08      [19]  331 	ld	d,8 (ix)
   0283 6B            [ 4]  332 	ld	l, e
   0284 62            [ 4]  333 	ld	h, d
   0285 AF            [ 4]  334 	xor	a, a
   0286 77            [ 7]  335 	ld	(hl), a
   0287 23            [ 6]  336 	inc	hl
   0288 77            [ 7]  337 	ld	(hl), a
                            338 ;src/IA.c:162: if(c->tipo == 0){
   0289 DD 7E 04      [19]  339 	ld	a,4 (ix)
   028C DD 77 FE      [19]  340 	ld	-2 (ix),a
   028F DD 7E 05      [19]  341 	ld	a,5 (ix)
   0292 DD 77 FF      [19]  342 	ld	-1 (ix),a
   0295 DD 6E FE      [19]  343 	ld	l,-2 (ix)
   0298 DD 66 FF      [19]  344 	ld	h,-1 (ix)
   029B 01 04 00      [10]  345 	ld	bc, #0x0004
   029E 09            [11]  346 	add	hl, bc
   029F 4E            [ 7]  347 	ld	c,(hl)
                            348 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   02A0 DD 7E FE      [19]  349 	ld	a,-2 (ix)
   02A3 C6 09         [ 7]  350 	add	a, #0x09
   02A5 DD 77 FA      [19]  351 	ld	-6 (ix),a
   02A8 DD 7E FF      [19]  352 	ld	a,-1 (ix)
   02AB CE 00         [ 7]  353 	adc	a, #0x00
   02AD DD 77 FB      [19]  354 	ld	-5 (ix),a
   02B0 DD 7E FE      [19]  355 	ld	a,-2 (ix)
   02B3 C6 05         [ 7]  356 	add	a, #0x05
   02B5 DD 77 F2      [19]  357 	ld	-14 (ix),a
   02B8 DD 7E FF      [19]  358 	ld	a,-1 (ix)
   02BB CE 00         [ 7]  359 	adc	a, #0x00
   02BD DD 77 F3      [19]  360 	ld	-13 (ix),a
   02C0 DD 7E 06      [19]  361 	ld	a,6 (ix)
   02C3 DD 77 ED      [19]  362 	ld	-19 (ix),a
   02C6 DD 36 EE 00   [19]  363 	ld	-18 (ix),#0x00
                            364 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   02CA DD 7E FE      [19]  365 	ld	a,-2 (ix)
   02CD C6 07         [ 7]  366 	add	a, #0x07
   02CF DD 77 FE      [19]  367 	ld	-2 (ix),a
   02D2 DD 7E FF      [19]  368 	ld	a,-1 (ix)
   02D5 CE 00         [ 7]  369 	adc	a, #0x00
   02D7 DD 77 FF      [19]  370 	ld	-1 (ix),a
                            371 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   02DA DD 6E F2      [19]  372 	ld	l,-14 (ix)
   02DD DD 66 F3      [19]  373 	ld	h,-13 (ix)
   02E0 7E            [ 7]  374 	ld	a,(hl)
   02E1 DD 77 F6      [19]  375 	ld	-10 (ix),a
   02E4 23            [ 6]  376 	inc	hl
   02E5 7E            [ 7]  377 	ld	a,(hl)
   02E6 DD 77 F7      [19]  378 	ld	-9 (ix),a
                            379 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   02E9 DD 7E 06      [19]  380 	ld	a,6 (ix)
   02EC DD 77 F8      [19]  381 	ld	-8 (ix),a
   02EF DD 36 F9 00   [19]  382 	ld	-7 (ix),#0x00
                            383 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   02F3 DD 6E FA      [19]  384 	ld	l,-6 (ix)
   02F6 DD 66 FB      [19]  385 	ld	h,-5 (ix)
   02F9 7E            [ 7]  386 	ld	a,(hl)
   02FA DD 77 F4      [19]  387 	ld	-12 (ix),a
   02FD 23            [ 6]  388 	inc	hl
   02FE 7E            [ 7]  389 	ld	a,(hl)
   02FF DD 77 F5      [19]  390 	ld	-11 (ix),a
                            391 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            392 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   0302 AF            [ 4]  393 	xor	a, a
   0303 DD 96 F4      [19]  394 	sub	a, -12 (ix)
   0306 6F            [ 4]  395 	ld	l,a
   0307 3E 00         [ 7]  396 	ld	a, #0x00
   0309 DD 9E F5      [19]  397 	sbc	a, -11 (ix)
   030C 67            [ 4]  398 	ld	h,a
   030D C5            [11]  399 	push	bc
   030E D5            [11]  400 	push	de
   030F E5            [11]  401 	push	hl
   0310 21 00 01      [10]  402 	ld	hl,#0x0100
   0313 E5            [11]  403 	push	hl
                            404 ;src/IA.c:162: if(c->tipo == 0){
   0314 CD AD 0F      [17]  405 	call	__divuint
   0317 F1            [10]  406 	pop	af
   0318 F1            [10]  407 	pop	af
   0319 DD 74 F1      [19]  408 	ld	-15 (ix),h
   031C DD 75 F0      [19]  409 	ld	-16 (ix),l
   031F D1            [10]  410 	pop	de
   0320 C1            [10]  411 	pop	bc
   0321 79            [ 4]  412 	ld	a,c
   0322 B7            [ 4]  413 	or	a, a
   0323 C2 47 04      [10]  414 	jp	NZ,00138$
                            415 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   0326 DD 7E ED      [19]  416 	ld	a,-19 (ix)
   0329 DD 96 F6      [19]  417 	sub	a, -10 (ix)
   032C 20 0C         [12]  418 	jr	NZ,00214$
   032E DD 7E EE      [19]  419 	ld	a,-18 (ix)
   0331 DD 96 F7      [19]  420 	sub	a, -9 (ix)
   0334 20 04         [12]  421 	jr	NZ,00214$
   0336 3E 01         [ 7]  422 	ld	a,#0x01
   0338 18 01         [12]  423 	jr	00215$
   033A                     424 00214$:
   033A AF            [ 4]  425 	xor	a,a
   033B                     426 00215$:
   033B 47            [ 4]  427 	ld	b,a
   033C DD 7E F5      [19]  428 	ld	a,-11 (ix)
   033F DD B6 F4      [19]  429 	or	a,-12 (ix)
   0342 20 04         [12]  430 	jr	NZ,00105$
   0344 78            [ 4]  431 	ld	a,b
   0345 B7            [ 4]  432 	or	a, a
   0346 20 10         [12]  433 	jr	NZ,00101$
   0348                     434 00105$:
                            435 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   0348 DD 6E FE      [19]  436 	ld	l,-2 (ix)
   034B DD 66 FF      [19]  437 	ld	h,-1 (ix)
   034E 4E            [ 7]  438 	ld	c,(hl)
   034F 23            [ 6]  439 	inc	hl
   0350 66            [ 7]  440 	ld	h,(hl)
   0351 7C            [ 4]  441 	ld	a,h
   0352 B1            [ 4]  442 	or	a,c
   0353 20 0D         [12]  443 	jr	NZ,00102$
   0355 B0            [ 4]  444 	or	a,b
   0356 28 0A         [12]  445 	jr	Z,00102$
   0358                     446 00101$:
                            447 ;src/IA.c:167: *grad = SCALA;
   0358 3E 00         [ 7]  448 	ld	a,#0x00
   035A 12            [ 7]  449 	ld	(de),a
   035B 13            [ 6]  450 	inc	de
   035C 3E 01         [ 7]  451 	ld	a,#0x01
   035E 12            [ 7]  452 	ld	(de),a
                            453 ;src/IA.c:168: return;
   035F C3 91 05      [10]  454 	jp	00140$
   0362                     455 00102$:
                            456 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   0362 DD 7E F6      [19]  457 	ld	a,-10 (ix)
   0365 DD 96 ED      [19]  458 	sub	a, -19 (ix)
   0368 DD 7E F7      [19]  459 	ld	a,-9 (ix)
   036B DD 9E EE      [19]  460 	sbc	a, -18 (ix)
   036E 3E 00         [ 7]  461 	ld	a,#0x00
   0370 17            [ 4]  462 	rla
   0371 DD 77 EF      [19]  463 	ld	-17 (ix),a
   0374 DD CB EF 46   [20]  464 	bit	0,-17 (ix)
   0378 20 68         [12]  465 	jr	NZ,00111$
   037A DD 7E F6      [19]  466 	ld	a,-10 (ix)
   037D 91            [ 4]  467 	sub	a, c
   037E 47            [ 4]  468 	ld	b,a
   037F DD 7E F7      [19]  469 	ld	a,-9 (ix)
   0382 9C            [ 4]  470 	sbc	a, h
   0383 6F            [ 4]  471 	ld	l,a
   0384 DD 7E ED      [19]  472 	ld	a,-19 (ix)
   0387 90            [ 4]  473 	sub	a, b
   0388 DD 7E EE      [19]  474 	ld	a,-18 (ix)
   038B 9D            [ 4]  475 	sbc	a, l
   038C 38 54         [12]  476 	jr	C,00111$
                            477 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   038E D5            [11]  478 	push	de
   038F 69            [ 4]  479 	ld	l, c
   0390 E5            [11]  480 	push	hl
   0391 21 00 01      [10]  481 	ld	hl,#0x0100
   0394 E5            [11]  482 	push	hl
   0395 CD AD 0F      [17]  483 	call	__divuint
   0398 F1            [10]  484 	pop	af
   0399 F1            [10]  485 	pop	af
   039A 4D            [ 4]  486 	ld	c,l
   039B 44            [ 4]  487 	ld	b,h
   039C D1            [10]  488 	pop	de
   039D 6B            [ 4]  489 	ld	l, e
   039E 62            [ 4]  490 	ld	h, d
   039F 71            [ 7]  491 	ld	(hl),c
   03A0 23            [ 6]  492 	inc	hl
   03A1 70            [ 7]  493 	ld	(hl),b
                            494 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   03A2 DD 6E F2      [19]  495 	ld	l,-14 (ix)
   03A5 DD 66 F3      [19]  496 	ld	h,-13 (ix)
   03A8 7E            [ 7]  497 	ld	a,(hl)
   03A9 DD 77 FC      [19]  498 	ld	-4 (ix),a
   03AC 23            [ 6]  499 	inc	hl
   03AD 7E            [ 7]  500 	ld	a,(hl)
   03AE DD 77 FD      [19]  501 	ld	-3 (ix),a
   03B1 DD 6E FE      [19]  502 	ld	l,-2 (ix)
   03B4 DD 66 FF      [19]  503 	ld	h,-1 (ix)
   03B7 7E            [ 7]  504 	ld	a, (hl)
   03B8 23            [ 6]  505 	inc	hl
   03B9 66            [ 7]  506 	ld	h,(hl)
   03BA 6F            [ 4]  507 	ld	l,a
   03BB DD 7E FC      [19]  508 	ld	a,-4 (ix)
   03BE 95            [ 4]  509 	sub	a, l
   03BF 6F            [ 4]  510 	ld	l,a
   03C0 DD 7E FD      [19]  511 	ld	a,-3 (ix)
   03C3 9C            [ 4]  512 	sbc	a, h
   03C4 67            [ 4]  513 	ld	h,a
   03C5 DD 7E F8      [19]  514 	ld	a,-8 (ix)
   03C8 95            [ 4]  515 	sub	a, l
   03C9 6F            [ 4]  516 	ld	l,a
   03CA DD 7E F9      [19]  517 	ld	a,-7 (ix)
   03CD 9C            [ 4]  518 	sbc	a, h
   03CE 67            [ 4]  519 	ld	h,a
   03CF D5            [11]  520 	push	de
   03D0 E5            [11]  521 	push	hl
   03D1 C5            [11]  522 	push	bc
   03D2 CD 36 18      [17]  523 	call	__mulint
   03D5 F1            [10]  524 	pop	af
   03D6 F1            [10]  525 	pop	af
   03D7 4D            [ 4]  526 	ld	c,l
   03D8 44            [ 4]  527 	ld	b,h
   03D9 D1            [10]  528 	pop	de
   03DA 79            [ 4]  529 	ld	a,c
   03DB 12            [ 7]  530 	ld	(de),a
   03DC 13            [ 6]  531 	inc	de
   03DD 78            [ 4]  532 	ld	a,b
   03DE 12            [ 7]  533 	ld	(de),a
                            534 ;src/IA.c:175: return;
   03DF C3 91 05      [10]  535 	jp	00140$
   03E2                     536 00111$:
                            537 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   03E2 DD CB EF 46   [20]  538 	bit	0,-17 (ix)
   03E6 28 55         [12]  539 	jr	Z,00107$
   03E8 DD 7E F6      [19]  540 	ld	a,-10 (ix)
   03EB DD 86 F4      [19]  541 	add	a, -12 (ix)
   03EE 4F            [ 4]  542 	ld	c,a
   03EF DD 7E F7      [19]  543 	ld	a,-9 (ix)
   03F2 DD 8E F5      [19]  544 	adc	a, -11 (ix)
   03F5 47            [ 4]  545 	ld	b,a
   03F6 DD 7E ED      [19]  546 	ld	a,-19 (ix)
   03F9 91            [ 4]  547 	sub	a, c
   03FA DD 7E EE      [19]  548 	ld	a,-18 (ix)
   03FD 98            [ 4]  549 	sbc	a, b
   03FE 30 3D         [12]  550 	jr	NC,00107$
                            551 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   0400 6B            [ 4]  552 	ld	l, e
   0401 62            [ 4]  553 	ld	h, d
   0402 DD 7E F0      [19]  554 	ld	a,-16 (ix)
   0405 77            [ 7]  555 	ld	(hl),a
   0406 23            [ 6]  556 	inc	hl
   0407 DD 7E F1      [19]  557 	ld	a,-15 (ix)
   040A 77            [ 7]  558 	ld	(hl),a
                            559 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   040B DD 6E F2      [19]  560 	ld	l,-14 (ix)
   040E DD 66 F3      [19]  561 	ld	h,-13 (ix)
   0411 4E            [ 7]  562 	ld	c,(hl)
   0412 23            [ 6]  563 	inc	hl
   0413 46            [ 7]  564 	ld	b,(hl)
   0414 DD 7E F8      [19]  565 	ld	a,-8 (ix)
   0417 91            [ 4]  566 	sub	a, c
   0418 4F            [ 4]  567 	ld	c,a
   0419 DD 7E F9      [19]  568 	ld	a,-7 (ix)
   041C 98            [ 4]  569 	sbc	a, b
   041D 47            [ 4]  570 	ld	b,a
   041E D5            [11]  571 	push	de
   041F C5            [11]  572 	push	bc
   0420 DD 6E F0      [19]  573 	ld	l,-16 (ix)
   0423 DD 66 F1      [19]  574 	ld	h,-15 (ix)
   0426 E5            [11]  575 	push	hl
   0427 CD 36 18      [17]  576 	call	__mulint
   042A F1            [10]  577 	pop	af
   042B F1            [10]  578 	pop	af
   042C 4D            [ 4]  579 	ld	c,l
   042D 44            [ 4]  580 	ld	b,h
   042E D1            [10]  581 	pop	de
   042F 21 00 01      [10]  582 	ld	hl,#0x0100
   0432 09            [11]  583 	add	hl,bc
   0433 4D            [ 4]  584 	ld	c,l
   0434 44            [ 4]  585 	ld	b,h
   0435 79            [ 4]  586 	ld	a,c
   0436 12            [ 7]  587 	ld	(de),a
   0437 13            [ 6]  588 	inc	de
   0438 78            [ 4]  589 	ld	a,b
   0439 12            [ 7]  590 	ld	(de),a
                            591 ;src/IA.c:180: return;
   043A C3 91 05      [10]  592 	jp	00140$
   043D                     593 00107$:
                            594 ;src/IA.c:183: *grad = 0;
   043D 3E 00         [ 7]  595 	ld	a,#0x00
   043F 12            [ 7]  596 	ld	(de),a
   0440 13            [ 6]  597 	inc	de
   0441 3E 00         [ 7]  598 	ld	a,#0x00
   0443 12            [ 7]  599 	ld	(de),a
                            600 ;src/IA.c:184: return;
   0444 C3 91 05      [10]  601 	jp	00140$
   0447                     602 00138$:
                            603 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   0447 DD 6E F6      [19]  604 	ld	l,-10 (ix)
   044A DD 7E F4      [19]  605 	ld	a,-12 (ix)
   044D DD 77 FC      [19]  606 	ld	-4 (ix),a
   0450 7D            [ 4]  607 	ld	a,l
   0451 DD 86 FC      [19]  608 	add	a, -4 (ix)
   0454 DD 96 FC      [19]  609 	sub	a, -4 (ix)
   0457 47            [ 4]  610 	ld	b,a
                            611 ;src/IA.c:187: }else if(c->tipo == 1)
   0458 0D            [ 4]  612 	dec	c
   0459 C2 E9 04      [10]  613 	jp	NZ,00135$
                            614 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   045C 48            [ 4]  615 	ld	c,b
                            616 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   045D DD 7E F5      [19]  617 	ld	a,-11 (ix)
   0460 DD B6 F4      [19]  618 	or	a,-12 (ix)
   0463 20 0E         [12]  619 	jr	NZ,00115$
   0465 DD 7E 06      [19]  620 	ld	a,6 (ix)
                            621 ;src/IA.c:193: *grad = SCALA;
   0468 91            [ 4]  622 	sub	a,c
   0469 20 08         [12]  623 	jr	NZ,00115$
   046B 12            [ 7]  624 	ld	(de),a
   046C 13            [ 6]  625 	inc	de
   046D 3E 01         [ 7]  626 	ld	a,#0x01
   046F 12            [ 7]  627 	ld	(de),a
                            628 ;src/IA.c:194: return;
   0470 C3 91 05      [10]  629 	jp	00140$
   0473                     630 00115$:
                            631 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   0473 DD 7E 06      [19]  632 	ld	a,6 (ix)
   0476 91            [ 4]  633 	sub	a, c
   0477 3E 00         [ 7]  634 	ld	a,#0x00
   0479 17            [ 4]  635 	rla
   047A DD 77 FC      [19]  636 	ld	-4 (ix),a
   047D DD CB FC 46   [20]  637 	bit	0,-4 (ix)
   0481 20 4C         [12]  638 	jr	NZ,00121$
   0483 06 00         [ 7]  639 	ld	b,#0x00
   0485 DD 6E F4      [19]  640 	ld	l,-12 (ix)
   0488 DD 66 F5      [19]  641 	ld	h,-11 (ix)
   048B 09            [11]  642 	add	hl,bc
   048C DD 7E ED      [19]  643 	ld	a,-19 (ix)
   048F 95            [ 4]  644 	sub	a, l
   0490 DD 7E EE      [19]  645 	ld	a,-18 (ix)
   0493 9C            [ 4]  646 	sbc	a, h
   0494 30 39         [12]  647 	jr	NC,00121$
                            648 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   0496 6B            [ 4]  649 	ld	l, e
   0497 62            [ 4]  650 	ld	h, d
   0498 DD 7E F0      [19]  651 	ld	a,-16 (ix)
   049B 77            [ 7]  652 	ld	(hl),a
   049C 23            [ 6]  653 	inc	hl
   049D DD 7E F1      [19]  654 	ld	a,-15 (ix)
   04A0 77            [ 7]  655 	ld	(hl),a
                            656 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   04A1 DD 6E FA      [19]  657 	ld	l,-6 (ix)
   04A4 DD 66 FB      [19]  658 	ld	h,-5 (ix)
   04A7 7E            [ 7]  659 	ld	a, (hl)
   04A8 23            [ 6]  660 	inc	hl
   04A9 66            [ 7]  661 	ld	h,(hl)
   04AA 6F            [ 4]  662 	ld	l,a
   04AB 09            [11]  663 	add	hl,bc
   04AC DD 7E F8      [19]  664 	ld	a,-8 (ix)
   04AF 95            [ 4]  665 	sub	a, l
   04B0 4F            [ 4]  666 	ld	c,a
   04B1 DD 7E F9      [19]  667 	ld	a,-7 (ix)
   04B4 9C            [ 4]  668 	sbc	a, h
   04B5 47            [ 4]  669 	ld	b,a
   04B6 D5            [11]  670 	push	de
   04B7 C5            [11]  671 	push	bc
   04B8 DD 6E F0      [19]  672 	ld	l,-16 (ix)
   04BB DD 66 F1      [19]  673 	ld	h,-15 (ix)
   04BE E5            [11]  674 	push	hl
   04BF CD 36 18      [17]  675 	call	__mulint
   04C2 F1            [10]  676 	pop	af
   04C3 F1            [10]  677 	pop	af
   04C4 4D            [ 4]  678 	ld	c,l
   04C5 44            [ 4]  679 	ld	b,h
   04C6 D1            [10]  680 	pop	de
   04C7 79            [ 4]  681 	ld	a,c
   04C8 12            [ 7]  682 	ld	(de),a
   04C9 13            [ 6]  683 	inc	de
   04CA 78            [ 4]  684 	ld	a,b
   04CB 12            [ 7]  685 	ld	(de),a
                            686 ;src/IA.c:201: return;
   04CC C3 91 05      [10]  687 	jp	00140$
   04CF                     688 00121$:
                            689 ;src/IA.c:202: }else if(val < midPoint)
   04CF DD CB FC 46   [20]  690 	bit	0,-4 (ix)
   04D3 28 0A         [12]  691 	jr	Z,00118$
                            692 ;src/IA.c:204: *grad = SCALA;
   04D5 3E 00         [ 7]  693 	ld	a,#0x00
   04D7 12            [ 7]  694 	ld	(de),a
   04D8 13            [ 6]  695 	inc	de
   04D9 3E 01         [ 7]  696 	ld	a,#0x01
   04DB 12            [ 7]  697 	ld	(de),a
                            698 ;src/IA.c:205: return;
   04DC C3 91 05      [10]  699 	jp	00140$
   04DF                     700 00118$:
                            701 ;src/IA.c:207: *grad = 0;
   04DF 3E 00         [ 7]  702 	ld	a,#0x00
   04E1 12            [ 7]  703 	ld	(de),a
   04E2 13            [ 6]  704 	inc	de
   04E3 3E 00         [ 7]  705 	ld	a,#0x00
   04E5 12            [ 7]  706 	ld	(de),a
                            707 ;src/IA.c:208: return;
   04E6 C3 91 05      [10]  708 	jp	00140$
   04E9                     709 00135$:
                            710 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            711 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   04E9 DD 6E FE      [19]  712 	ld	l,-2 (ix)
   04EC DD 66 FF      [19]  713 	ld	h,-1 (ix)
   04EF 4E            [ 7]  714 	ld	c,(hl)
   04F0 23            [ 6]  715 	inc	hl
   04F1 7E            [ 7]  716 	ld	a, (hl)
   04F2 B1            [ 4]  717 	or	a,c
   04F3 20 0D         [12]  718 	jr	NZ,00125$
   04F5 DD 7E 06      [19]  719 	ld	a,6 (ix)
   04F8 90            [ 4]  720 	sub	a, b
   04F9 20 07         [12]  721 	jr	NZ,00125$
                            722 ;src/IA.c:215: *grad = SCALA;
   04FB 6B            [ 4]  723 	ld	l, e
   04FC 62            [ 4]  724 	ld	h, d
   04FD 36 00         [10]  725 	ld	(hl),#0x00
   04FF 23            [ 6]  726 	inc	hl
   0500 36 01         [10]  727 	ld	(hl),#0x01
   0502                     728 00125$:
                            729 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   0502 78            [ 4]  730 	ld	a,b
   0503 DD 96 06      [19]  731 	sub	a, 6 (ix)
   0506 3E 00         [ 7]  732 	ld	a,#0x00
   0508 17            [ 4]  733 	rla
   0509 DD 77 FC      [19]  734 	ld	-4 (ix),a
   050C DD CB FC 46   [20]  735 	bit	0,-4 (ix)
   0510 20 69         [12]  736 	jr	NZ,00131$
   0512 0E 00         [ 7]  737 	ld	c,#0x00
   0514 DD 6E FE      [19]  738 	ld	l,-2 (ix)
   0517 DD 66 FF      [19]  739 	ld	h,-1 (ix)
   051A 7E            [ 7]  740 	ld	a, (hl)
   051B 23            [ 6]  741 	inc	hl
   051C 66            [ 7]  742 	ld	h,(hl)
   051D 6F            [ 4]  743 	ld	l,a
   051E DD 70 F0      [19]  744 	ld	-16 (ix),b
   0521 DD 71 F1      [19]  745 	ld	-15 (ix),c
   0524 DD 7E F0      [19]  746 	ld	a,-16 (ix)
   0527 95            [ 4]  747 	sub	a, l
   0528 4F            [ 4]  748 	ld	c,a
   0529 DD 7E F1      [19]  749 	ld	a,-15 (ix)
   052C 9C            [ 4]  750 	sbc	a, h
   052D 47            [ 4]  751 	ld	b,a
   052E 79            [ 4]  752 	ld	a,c
   052F DD 96 ED      [19]  753 	sub	a, -19 (ix)
   0532 78            [ 4]  754 	ld	a,b
   0533 DD 9E EE      [19]  755 	sbc	a, -18 (ix)
   0536 30 43         [12]  756 	jr	NC,00131$
                            757 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   0538 D5            [11]  758 	push	de
   0539 E5            [11]  759 	push	hl
   053A 21 00 01      [10]  760 	ld	hl,#0x0100
   053D E5            [11]  761 	push	hl
   053E CD AD 0F      [17]  762 	call	__divuint
   0541 F1            [10]  763 	pop	af
   0542 F1            [10]  764 	pop	af
   0543 4D            [ 4]  765 	ld	c,l
   0544 44            [ 4]  766 	ld	b,h
   0545 D1            [10]  767 	pop	de
   0546 6B            [ 4]  768 	ld	l, e
   0547 62            [ 4]  769 	ld	h, d
   0548 71            [ 7]  770 	ld	(hl),c
   0549 23            [ 6]  771 	inc	hl
   054A 70            [ 7]  772 	ld	(hl),b
                            773 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   054B DD 6E FE      [19]  774 	ld	l,-2 (ix)
   054E DD 66 FF      [19]  775 	ld	h,-1 (ix)
   0551 7E            [ 7]  776 	ld	a, (hl)
   0552 23            [ 6]  777 	inc	hl
   0553 66            [ 7]  778 	ld	h,(hl)
   0554 6F            [ 4]  779 	ld	l,a
   0555 DD 7E F0      [19]  780 	ld	a,-16 (ix)
   0558 95            [ 4]  781 	sub	a, l
   0559 6F            [ 4]  782 	ld	l,a
   055A DD 7E F1      [19]  783 	ld	a,-15 (ix)
   055D 9C            [ 4]  784 	sbc	a, h
   055E 67            [ 4]  785 	ld	h,a
   055F DD 7E F8      [19]  786 	ld	a,-8 (ix)
   0562 95            [ 4]  787 	sub	a, l
   0563 6F            [ 4]  788 	ld	l,a
   0564 DD 7E F9      [19]  789 	ld	a,-7 (ix)
   0567 9C            [ 4]  790 	sbc	a, h
   0568 67            [ 4]  791 	ld	h,a
   0569 D5            [11]  792 	push	de
   056A E5            [11]  793 	push	hl
   056B C5            [11]  794 	push	bc
   056C CD 36 18      [17]  795 	call	__mulint
   056F F1            [10]  796 	pop	af
   0570 F1            [10]  797 	pop	af
   0571 4D            [ 4]  798 	ld	c,l
   0572 44            [ 4]  799 	ld	b,h
   0573 D1            [10]  800 	pop	de
   0574 79            [ 4]  801 	ld	a,c
   0575 12            [ 7]  802 	ld	(de),a
   0576 13            [ 6]  803 	inc	de
   0577 78            [ 4]  804 	ld	a,b
   0578 12            [ 7]  805 	ld	(de),a
   0579 18 16         [12]  806 	jr	00140$
   057B                     807 00131$:
                            808 ;src/IA.c:220: }else if(val > midPoint)
   057B DD CB FC 46   [20]  809 	bit	0,-4 (ix)
   057F 28 09         [12]  810 	jr	Z,00128$
                            811 ;src/IA.c:223: *grad = SCALA;
   0581 3E 00         [ 7]  812 	ld	a,#0x00
   0583 12            [ 7]  813 	ld	(de),a
   0584 13            [ 6]  814 	inc	de
   0585 3E 01         [ 7]  815 	ld	a,#0x01
   0587 12            [ 7]  816 	ld	(de),a
   0588 18 07         [12]  817 	jr	00140$
   058A                     818 00128$:
                            819 ;src/IA.c:225: *grad = 0;
   058A 3E 00         [ 7]  820 	ld	a,#0x00
   058C 12            [ 7]  821 	ld	(de),a
   058D 13            [ 6]  822 	inc	de
   058E 3E 00         [ 7]  823 	ld	a,#0x00
   0590 12            [ 7]  824 	ld	(de),a
   0591                     825 00140$:
   0591 DD F9         [10]  826 	ld	sp, ix
   0593 DD E1         [14]  827 	pop	ix
   0595 C9            [10]  828 	ret
                            829 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            830 ;	---------------------------------
                            831 ; Function defuzzi
                            832 ; ---------------------------------
   0596                     833 _defuzzi::
   0596 DD E5         [15]  834 	push	ix
   0598 DD 21 00 00   [14]  835 	ld	ix,#0
   059C DD 39         [15]  836 	add	ix,sp
   059E 21 EF FF      [10]  837 	ld	hl,#-17
   05A1 39            [11]  838 	add	hl,sp
   05A2 F9            [ 6]  839 	ld	sp,hl
                            840 ;src/IA.c:239: *re = 0;
   05A3 DD 7E 08      [19]  841 	ld	a,8 (ix)
   05A6 DD 77 FC      [19]  842 	ld	-4 (ix),a
   05A9 DD 7E 09      [19]  843 	ld	a,9 (ix)
   05AC DD 77 FD      [19]  844 	ld	-3 (ix),a
   05AF DD 6E FC      [19]  845 	ld	l,-4 (ix)
   05B2 DD 66 FD      [19]  846 	ld	h,-3 (ix)
   05B5 AF            [ 4]  847 	xor	a, a
   05B6 77            [ 7]  848 	ld	(hl), a
   05B7 23            [ 6]  849 	inc	hl
   05B8 77            [ 7]  850 	ld	(hl), a
                            851 ;src/IA.c:241: while(i < 3)
   05B9 21 01 00      [10]  852 	ld	hl,#0x0001
   05BC 39            [11]  853 	add	hl,sp
   05BD DD 75 F8      [19]  854 	ld	-8 (ix),l
   05C0 DD 74 F9      [19]  855 	ld	-7 (ix),h
   05C3 0E 00         [ 7]  856 	ld	c,#0x00
   05C5                     857 00101$:
   05C5 79            [ 4]  858 	ld	a,c
   05C6 D6 03         [ 7]  859 	sub	a, #0x03
   05C8 30 53         [12]  860 	jr	NC,00103$
                            861 ;src/IA.c:243: dom = 0;
   05CA DD 36 F6 00   [19]  862 	ld	-10 (ix),#0x00
   05CE DD 36 F7 00   [19]  863 	ld	-9 (ix),#0x00
                            864 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   05D2 21 07 00      [10]  865 	ld	hl,#0x0007
   05D5 39            [11]  866 	add	hl,sp
   05D6 DD 75 FA      [19]  867 	ld	-6 (ix),l
   05D9 DD 74 FB      [19]  868 	ld	-5 (ix),h
   05DC DD 46 04      [19]  869 	ld	b,4 (ix)
   05DF 69            [ 4]  870 	ld	l,c
   05E0 26 00         [ 7]  871 	ld	h,#0x00
   05E2 29            [11]  872 	add	hl, hl
   05E3 EB            [ 4]  873 	ex	de,hl
   05E4 21 8F 19      [10]  874 	ld	hl,#_fmems
   05E7 19            [11]  875 	add	hl,de
   05E8 7E            [ 7]  876 	ld	a,(hl)
   05E9 DD 77 FE      [19]  877 	ld	-2 (ix),a
   05EC 23            [ 6]  878 	inc	hl
   05ED 7E            [ 7]  879 	ld	a,(hl)
   05EE DD 77 FF      [19]  880 	ld	-1 (ix),a
   05F1 C5            [11]  881 	push	bc
   05F2 D5            [11]  882 	push	de
   05F3 DD 6E FA      [19]  883 	ld	l,-6 (ix)
   05F6 DD 66 FB      [19]  884 	ld	h,-5 (ix)
   05F9 E5            [11]  885 	push	hl
   05FA C5            [11]  886 	push	bc
   05FB 33            [ 6]  887 	inc	sp
   05FC DD 6E FE      [19]  888 	ld	l,-2 (ix)
   05FF DD 66 FF      [19]  889 	ld	h,-1 (ix)
   0602 E5            [11]  890 	push	hl
   0603 CD 70 02      [17]  891 	call	_calculateDom
   0606 F1            [10]  892 	pop	af
   0607 F1            [10]  893 	pop	af
   0608 33            [ 6]  894 	inc	sp
   0609 D1            [10]  895 	pop	de
   060A C1            [10]  896 	pop	bc
                            897 ;src/IA.c:245: vDom[i] = dom/SCALA;
   060B DD 6E F8      [19]  898 	ld	l,-8 (ix)
   060E DD 66 F9      [19]  899 	ld	h,-7 (ix)
   0611 19            [11]  900 	add	hl,de
   0612 DD 5E F7      [19]  901 	ld	e,-9 (ix)
   0615 16 00         [ 7]  902 	ld	d,#0x00
   0617 73            [ 7]  903 	ld	(hl),e
   0618 23            [ 6]  904 	inc	hl
   0619 72            [ 7]  905 	ld	(hl),d
                            906 ;src/IA.c:246: i++;
   061A 0C            [ 4]  907 	inc	c
   061B 18 A8         [12]  908 	jr	00101$
   061D                     909 00103$:
                            910 ;src/IA.c:250: for(i = 0; i<3; i++)
   061D DD 36 EF 00   [19]  911 	ld	-17 (ix),#0x00
   0621                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   0621 DD 6E EF      [19]  914 	ld	l,-17 (ix)
   0624 26 00         [ 7]  915 	ld	h,#0x00
   0626 29            [11]  916 	add	hl, hl
   0627 4D            [ 4]  917 	ld	c, l
   0628 44            [ 4]  918 	ld	b, h
   0629 DD 6E F8      [19]  919 	ld	l,-8 (ix)
   062C DD 66 F9      [19]  920 	ld	h,-7 (ix)
   062F 09            [11]  921 	add	hl,bc
   0630 5E            [ 7]  922 	ld	e,(hl)
   0631 23            [ 6]  923 	inc	hl
   0632 56            [ 7]  924 	ld	d,(hl)
   0633 21 7D 19      [10]  925 	ld	hl,#_aceleracion
   0636 09            [11]  926 	add	hl,bc
   0637 4E            [ 7]  927 	ld	c,(hl)
   0638 23            [ 6]  928 	inc	hl
   0639 46            [ 7]  929 	ld	b,(hl)
   063A C5            [11]  930 	push	bc
   063B D5            [11]  931 	push	de
   063C CD 36 18      [17]  932 	call	__mulint
   063F F1            [10]  933 	pop	af
   0640 F1            [10]  934 	pop	af
   0641 4D            [ 4]  935 	ld	c,l
   0642 44            [ 4]  936 	ld	b,h
   0643 DD 6E FC      [19]  937 	ld	l,-4 (ix)
   0646 DD 66 FD      [19]  938 	ld	h,-3 (ix)
   0649 5E            [ 7]  939 	ld	e,(hl)
   064A 23            [ 6]  940 	inc	hl
   064B 66            [ 7]  941 	ld	h,(hl)
   064C 6B            [ 4]  942 	ld	l, e
   064D 09            [11]  943 	add	hl,bc
   064E 4D            [ 4]  944 	ld	c,l
   064F 44            [ 4]  945 	ld	b,h
   0650 DD 6E FC      [19]  946 	ld	l,-4 (ix)
   0653 DD 66 FD      [19]  947 	ld	h,-3 (ix)
   0656 71            [ 7]  948 	ld	(hl),c
   0657 23            [ 6]  949 	inc	hl
   0658 70            [ 7]  950 	ld	(hl),b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   0659 DD 34 EF      [23]  952 	inc	-17 (ix)
   065C DD 7E EF      [19]  953 	ld	a,-17 (ix)
   065F D6 03         [ 7]  954 	sub	a, #0x03
   0661 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   0663 DD 6E 06      [19]  957 	ld	l,6 (ix)
   0666 DD 66 07      [19]  958 	ld	h,7 (ix)
   0669 23            [ 6]  959 	inc	hl
   066A 7E            [ 7]  960 	ld	a,(hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   066B DD 6E FC      [19]  962 	ld	l,-4 (ix)
   066E DD 66 FD      [19]  963 	ld	h,-3 (ix)
   0671 5E            [ 7]  964 	ld	e,(hl)
   0672 23            [ 6]  965 	inc	hl
   0673 56            [ 7]  966 	ld	d,(hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   0674 B7            [ 4]  968 	or	a, a
   0675 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   0677 DD 6E FC      [19]  971 	ld	l,-4 (ix)
   067A DD 66 FD      [19]  972 	ld	h,-3 (ix)
   067D 73            [ 7]  973 	ld	(hl),e
   067E 23            [ 6]  974 	inc	hl
   067F 72            [ 7]  975 	ld	(hl),d
   0680 18 10         [12]  976 	jr	00110$
   0682                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   0682 AF            [ 4]  979 	xor	a, a
   0683 93            [ 4]  980 	sub	a, e
   0684 5F            [ 4]  981 	ld	e,a
   0685 3E 00         [ 7]  982 	ld	a, #0x00
   0687 9A            [ 4]  983 	sbc	a, d
   0688 4F            [ 4]  984 	ld	c,a
   0689 DD 6E FC      [19]  985 	ld	l,-4 (ix)
   068C DD 66 FD      [19]  986 	ld	h,-3 (ix)
   068F 73            [ 7]  987 	ld	(hl),e
   0690 23            [ 6]  988 	inc	hl
   0691 71            [ 7]  989 	ld	(hl),c
   0692                     990 00110$:
   0692 DD F9         [10]  991 	ld	sp, ix
   0694 DD E1         [14]  992 	pop	ix
   0696 C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   0697                     998 _calcule::
   0697 DD E5         [15]  999 	push	ix
   0699 DD 21 00 00   [14] 1000 	ld	ix,#0
   069D DD 39         [15] 1001 	add	ix,sp
   069F F5            [11] 1002 	push	af
   06A0 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   06A1 DD 36 FE 00   [19] 1005 	ld	-2 (ix),#0x00
   06A5 DD 36 FF 00   [19] 1006 	ld	-1 (ix),#0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   06A9 DD 36 FD 00   [19] 1008 	ld	-3 (ix),#0x00
   06AD                    1009 00103$:
   06AD DD 7E FD      [19] 1010 	ld	a,-3 (ix)
   06B0 DD 96 04      [19] 1011 	sub	a, 4 (ix)
   06B3 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   06B5 FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   06B9 FD 39         [15] 1015 	add	iy,sp
   06BB DD 6E FD      [19] 1016 	ld	l,-3 (ix)
   06BE 26 00         [ 7] 1017 	ld	h,#0x00
   06C0 29            [11] 1018 	add	hl, hl
   06C1 01 83 19      [10] 1019 	ld	bc,#_vRulesx
   06C4 09            [11] 1020 	add	hl,bc
   06C5 4D            [ 4] 1021 	ld	c,l
   06C6 44            [ 4] 1022 	ld	b,h
   06C7 7E            [ 7] 1023 	ld	a, (hl)
   06C8 23            [ 6] 1024 	inc	hl
   06C9 66            [ 7] 1025 	ld	h,(hl)
   06CA 6F            [ 4] 1026 	ld	l,a
   06CB 5E            [ 7] 1027 	ld	e,(hl)
   06CC 23            [ 6] 1028 	inc	hl
   06CD 56            [ 7] 1029 	ld	d,(hl)
   06CE C5            [11] 1030 	push	bc
   06CF FD E5         [15] 1031 	push	iy
   06D1 DD 7E 05      [19] 1032 	ld	a,5 (ix)
   06D4 F5            [11] 1033 	push	af
   06D5 33            [ 6] 1034 	inc	sp
   06D6 D5            [11] 1035 	push	de
   06D7 CD 70 02      [17] 1036 	call	_calculateDom
   06DA F1            [10] 1037 	pop	af
   06DB F1            [10] 1038 	pop	af
   06DC 33            [ 6] 1039 	inc	sp
   06DD C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   06DE DD 5E 06      [19] 1042 	ld	e,6 (ix)
   06E1 DD 56 07      [19] 1043 	ld	d,7 (ix)
   06E4 69            [ 4] 1044 	ld	l, c
   06E5 60            [ 4] 1045 	ld	h, b
   06E6 7E            [ 7] 1046 	ld	a, (hl)
   06E7 23            [ 6] 1047 	inc	hl
   06E8 66            [ 7] 1048 	ld	h,(hl)
   06E9 6F            [ 4] 1049 	ld	l,a
   06EA 23            [ 6] 1050 	inc	hl
   06EB 23            [ 6] 1051 	inc	hl
   06EC 7E            [ 7] 1052 	ld	a, (hl)
   06ED 23            [ 6] 1053 	inc	hl
   06EE 66            [ 7] 1054 	ld	h,(hl)
   06EF 6F            [ 4] 1055 	ld	l,a
   06F0 23            [ 6] 1056 	inc	hl
   06F1 23            [ 6] 1057 	inc	hl
   06F2 4E            [ 7] 1058 	ld	c,(hl)
   06F3 23            [ 6] 1059 	inc	hl
   06F4 46            [ 7] 1060 	ld	b,(hl)
   06F5 D5            [11] 1061 	push	de
   06F6 DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   06F9 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   06FC E5            [11] 1064 	push	hl
   06FD C5            [11] 1065 	push	bc
   06FE CD 36 18      [17] 1066 	call	__mulint
   0701 F1            [10] 1067 	pop	af
   0702 F1            [10] 1068 	pop	af
   0703 4D            [ 4] 1069 	ld	c,l
   0704 44            [ 4] 1070 	ld	b,h
   0705 D1            [10] 1071 	pop	de
   0706 6B            [ 4] 1072 	ld	l, e
   0707 62            [ 4] 1073 	ld	h, d
   0708 7E            [ 7] 1074 	ld	a, (hl)
   0709 23            [ 6] 1075 	inc	hl
   070A 66            [ 7] 1076 	ld	h,(hl)
   070B 6F            [ 4] 1077 	ld	l,a
   070C 09            [11] 1078 	add	hl,bc
   070D 4C            [ 4] 1079 	ld	c,h
   070E 06 00         [ 7] 1080 	ld	b,#0x00
   0710 79            [ 4] 1081 	ld	a,c
   0711 12            [ 7] 1082 	ld	(de),a
   0712 13            [ 6] 1083 	inc	de
   0713 78            [ 4] 1084 	ld	a,b
   0714 12            [ 7] 1085 	ld	(de),a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   0715 DD 34 FD      [23] 1087 	inc	-3 (ix)
   0718 18 93         [12] 1088 	jr	00103$
   071A                    1089 00105$:
   071A DD F9         [10] 1090 	ld	sp, ix
   071C DD E1         [14] 1091 	pop	ix
   071E C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   071F                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   071F 21 04 00      [10] 1099 	ld	hl, #4
   0722 39            [11] 1100 	add	hl, sp
   0723 4E            [ 7] 1101 	ld	c, (hl)
   0724 23            [ 6] 1102 	inc	hl
   0725 46            [ 7] 1103 	ld	b, (hl)
   0726 59            [ 4] 1104 	ld	e, c
   0727 50            [ 4] 1105 	ld	d, b
   0728 13            [ 6] 1106 	inc	de
   0729 AF            [ 4] 1107 	xor	a, a
   072A 12            [ 7] 1108 	ld	(de),a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   072B AF            [ 4] 1110 	xor	a, a
   072C 02            [ 7] 1111 	ld	(bc),a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   072D 21 03 00      [10] 1113 	ld	hl, #2+1
   0730 39            [11] 1114 	add	hl, sp
   0731 CB 7E         [12] 1115 	bit	7,(hl)
   0733 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   0735 3E 01         [ 7] 1118 	ld	a,#0x01
   0737 02            [ 7] 1119 	ld	(bc),a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   0738 AF            [ 4] 1121 	xor	a, a
   0739 12            [ 7] 1122 	ld	(de),a
   073A C9            [10] 1123 	ret
   073B                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   073B AF            [ 4] 1126 	xor	a, a
   073C FD 21 02 00   [14] 1127 	ld	iy,#2
   0740 FD 39         [15] 1128 	add	iy,sp
   0742 FD BE 00      [19] 1129 	cp	a, 0 (iy)
   0745 FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   0748 E2 4D 07      [10] 1131 	jp	PO, 00116$
   074B EE 80         [ 7] 1132 	xor	a, #0x80
   074D                    1133 00116$:
   074D F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   074E 3E 01         [ 7] 1136 	ld	a,#0x01
   0750 12            [ 7] 1137 	ld	(de),a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   0751 AF            [ 4] 1139 	xor	a, a
   0752 02            [ 7] 1140 	ld	(bc),a
   0753 C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   0754                    1146 _fuzzificacion::
   0754 DD E5         [15] 1147 	push	ix
   0756 DD 21 00 00   [14] 1148 	ld	ix,#0
   075A DD 39         [15] 1149 	add	ix,sp
   075C 21 EE FF      [10] 1150 	ld	hl,#-18
   075F 39            [11] 1151 	add	hl,sp
                           1152 ;src/IA.c:299: ball = &ballX;
   0760 F9            [ 6] 1153 	ld	sp, hl
   0761 23            [ 6] 1154 	inc	hl
   0762 23            [ 6] 1155 	inc	hl
   0763 DD 75 FC      [19] 1156 	ld	-4 (ix),l
   0766 DD 74 FD      [19] 1157 	ld	-3 (ix),h
   0769 4D            [ 4] 1158 	ld	c,l
   076A 44            [ 4] 1159 	ld	b,h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   076B DD 5E 08      [19] 1161 	ld	e,8 (ix)
   076E 16 00         [ 7] 1162 	ld	d,#0x00
   0770 DD 6E 0A      [19] 1163 	ld	l,10 (ix)
   0773 26 00         [ 7] 1164 	ld	h,#0x00
   0775 7B            [ 4] 1165 	ld	a,e
   0776 95            [ 4] 1166 	sub	a, l
   0777 DD 77 FA      [19] 1167 	ld	-6 (ix),a
   077A 7A            [ 4] 1168 	ld	a,d
   077B 9C            [ 4] 1169 	sbc	a, h
   077C DD 77 FB      [19] 1170 	ld	-5 (ix),a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   077F DD 6E 09      [19] 1172 	ld	l,9 (ix)
   0782 26 00         [ 7] 1173 	ld	h,#0x00
   0784 DD 5E 0B      [19] 1174 	ld	e,11 (ix)
   0787 16 00         [ 7] 1175 	ld	d,#0x00
   0789 7D            [ 4] 1176 	ld	a,l
   078A 93            [ 4] 1177 	sub	a, e
   078B DD 77 FE      [19] 1178 	ld	-2 (ix),a
   078E 7C            [ 4] 1179 	ld	a,h
   078F 9A            [ 4] 1180 	sbc	a, d
   0790 DD 77 FF      [19] 1181 	ld	-1 (ix),a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   0793 3E 6F         [ 7] 1183 	ld	a,#0x6F
   0795 93            [ 4] 1184 	sub	a, e
   0796 DD 77 F2      [19] 1185 	ld	-14 (ix),a
   0799 3E 00         [ 7] 1186 	ld	a,#0x00
   079B 9A            [ 4] 1187 	sbc	a, d
   079C DD 77 F3      [19] 1188 	ld	-13 (ix),a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   079F 59            [ 4] 1190 	ld	e, c
   07A0 50            [ 4] 1191 	ld	d, b
   07A1 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   07A2 3E FE         [ 7] 1194 	ld	a,#0xFE
   07A4 DD BE FA      [19] 1195 	cp	a, -6 (ix)
   07A7 3E FF         [ 7] 1196 	ld	a,#0xFF
   07A9 DD 9E FB      [19] 1197 	sbc	a, -5 (ix)
   07AC E2 B1 07      [10] 1198 	jp	PO, 00148$
   07AF EE 80         [ 7] 1199 	xor	a, #0x80
   07B1                    1200 00148$:
   07B1 FA BB 07      [10] 1201 	jp	M,00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   07B4 3E 01         [ 7] 1203 	ld	a,#0x01
   07B6 02            [ 7] 1204 	ld	(bc),a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   07B7 AF            [ 4] 1206 	xor	a, a
   07B8 12            [ 7] 1207 	ld	(de),a
   07B9 18 05         [12] 1208 	jr	00103$
   07BB                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   07BB 3E 01         [ 7] 1211 	ld	a,#0x01
   07BD 12            [ 7] 1212 	ld	(de),a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   07BE AF            [ 4] 1214 	xor	a, a
   07BF 02            [ 7] 1215 	ld	(bc),a
   07C0                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   07C0 AF            [ 4] 1218 	xor	a, a
   07C1 DD BE FA      [19] 1219 	cp	a, -6 (ix)
   07C4 DD 9E FB      [19] 1220 	sbc	a, -5 (ix)
   07C7 E2 CC 07      [10] 1221 	jp	PO, 00149$
   07CA EE 80         [ 7] 1222 	xor	a, #0x80
   07CC                    1223 00149$:
   07CC 07            [ 4] 1224 	rlca
   07CD E6 01         [ 7] 1225 	and	a,#0x01
   07CF 4F            [ 4] 1226 	ld	c,a
   07D0 DD 7E F2      [19] 1227 	ld	a,-14 (ix)
   07D3 DD 96 FE      [19] 1228 	sub	a, -2 (ix)
   07D6 DD 7E F3      [19] 1229 	ld	a,-13 (ix)
   07D9 DD 9E FF      [19] 1230 	sbc	a, -1 (ix)
   07DC E2 E1 07      [10] 1231 	jp	PO, 00150$
   07DF EE 80         [ 7] 1232 	xor	a, #0x80
   07E1                    1233 00150$:
   07E1 F2 FB 07      [10] 1234 	jp	P,00109$
   07E4 79            [ 4] 1235 	ld	a,c
   07E5 B7            [ 4] 1236 	or	a, a
   07E6 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   07E8 21 00 00      [10] 1239 	ld	hl,#0x0000
   07EB 39            [11] 1240 	add	hl,sp
   07EC E5            [11] 1241 	push	hl
   07ED DD 6E F2      [19] 1242 	ld	l,-14 (ix)
   07F0 DD 66 F3      [19] 1243 	ld	h,-13 (ix)
   07F3 E5            [11] 1244 	push	hl
   07F4 CD 1F 07      [17] 1245 	call	_calcularb_direc
   07F7 F1            [10] 1246 	pop	af
   07F8 F1            [10] 1247 	pop	af
   07F9 18 3C         [12] 1248 	jr	00110$
   07FB                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   07FB DD 7E FE      [19] 1251 	ld	a,-2 (ix)
   07FE DD 96 F2      [19] 1252 	sub	a, -14 (ix)
   0801 DD 7E FF      [19] 1253 	ld	a,-1 (ix)
   0804 DD 9E F3      [19] 1254 	sbc	a, -13 (ix)
   0807 E2 0C 08      [10] 1255 	jp	PO, 00151$
   080A EE 80         [ 7] 1256 	xor	a, #0x80
   080C                    1257 00151$:
   080C F2 26 08      [10] 1258 	jp	P,00105$
   080F 79            [ 4] 1259 	ld	a,c
   0810 B7            [ 4] 1260 	or	a, a
   0811 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   0813 21 00 00      [10] 1263 	ld	hl,#0x0000
   0816 39            [11] 1264 	add	hl,sp
   0817 E5            [11] 1265 	push	hl
   0818 DD 6E F2      [19] 1266 	ld	l,-14 (ix)
   081B DD 66 F3      [19] 1267 	ld	h,-13 (ix)
   081E E5            [11] 1268 	push	hl
   081F CD 1F 07      [17] 1269 	call	_calcularb_direc
   0822 F1            [10] 1270 	pop	af
   0823 F1            [10] 1271 	pop	af
   0824 18 11         [12] 1272 	jr	00110$
   0826                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   0826 21 00 00      [10] 1275 	ld	hl,#0x0000
   0829 39            [11] 1276 	add	hl,sp
   082A E5            [11] 1277 	push	hl
   082B DD 6E FE      [19] 1278 	ld	l,-2 (ix)
   082E DD 66 FF      [19] 1279 	ld	h,-1 (ix)
   0831 E5            [11] 1280 	push	hl
   0832 CD 1F 07      [17] 1281 	call	_calcularb_direc
   0835 F1            [10] 1282 	pop	af
   0836 F1            [10] 1283 	pop	af
   0837                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   0837 DD 4E FA      [19] 1286 	ld	c,-6 (ix)
   083A DD 71 F5      [19] 1287 	ld	-11 (ix),c
   083D DD 36 F4 00   [19] 1288 	ld	-12 (ix),#0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   0841 DD 46 FE      [19] 1290 	ld	b,-2 (ix)
   0844 0E 00         [ 7] 1291 	ld	c,#0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   0846 21 08 00      [10] 1293 	ld	hl,#0x0008
   0849 39            [11] 1294 	add	hl,sp
   084A DD 56 F4      [19] 1295 	ld	d,-12 (ix)
   084D C5            [11] 1296 	push	bc
   084E E5            [11] 1297 	push	hl
   084F 1E 03         [ 7] 1298 	ld	e, #0x03
   0851 D5            [11] 1299 	push	de
   0852 CD 97 06      [17] 1300 	call	_calcule
   0855 F1            [10] 1301 	pop	af
   0856 F1            [10] 1302 	pop	af
   0857 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   0858 21 0A 00      [10] 1305 	ld	hl,#0x000A
   085B 39            [11] 1306 	add	hl,sp
   085C 51            [ 4] 1307 	ld	d,c
   085D C5            [11] 1308 	push	bc
   085E E5            [11] 1309 	push	hl
   085F 1E 03         [ 7] 1310 	ld	e, #0x03
   0861 D5            [11] 1311 	push	de
   0862 CD 97 06      [17] 1312 	call	_calcule
   0865 F1            [10] 1313 	pop	af
   0866 F1            [10] 1314 	pop	af
   0867 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   0868 78            [ 4] 1317 	ld	a,b
   0869 B1            [ 4] 1318 	or	a,c
   086A 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   086C DD 4E FC      [19] 1321 	ld	c,-4 (ix)
   086F DD 46 FD      [19] 1322 	ld	b,-3 (ix)
   0872 DD 6E 04      [19] 1323 	ld	l,4 (ix)
   0875 DD 66 05      [19] 1324 	ld	h,5 (ix)
   0878 E5            [11] 1325 	push	hl
   0879 C5            [11] 1326 	push	bc
   087A DD 6E F6      [19] 1327 	ld	l,-10 (ix)
   087D DD 66 F7      [19] 1328 	ld	h,-9 (ix)
   0880 E5            [11] 1329 	push	hl
   0881 CD 96 05      [17] 1330 	call	_defuzzi
   0884 21 06 00      [10] 1331 	ld	hl,#6
   0887 39            [11] 1332 	add	hl,sp
   0888 F9            [ 6] 1333 	ld	sp,hl
                           1334 ;src/IA.c:336: ax = 0;
   0889                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   0889 DD 7E F5      [19] 1337 	ld	a,-11 (ix)
   088C DD B6 F4      [19] 1338 	or	a,-12 (ix)
   088F 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   0891 21 00 00      [10] 1341 	ld	hl,#0x0000
   0894 39            [11] 1342 	add	hl,sp
   0895 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   0898 DD 46 07      [19] 1344 	ld	b,7 (ix)
   089B C5            [11] 1345 	push	bc
   089C E5            [11] 1346 	push	hl
   089D DD 6E F8      [19] 1347 	ld	l,-8 (ix)
   08A0 DD 66 F9      [19] 1348 	ld	h,-7 (ix)
   08A3 E5            [11] 1349 	push	hl
   08A4 CD 96 05      [17] 1350 	call	_defuzzi
   08A7 21 06 00      [10] 1351 	ld	hl,#6
   08AA 39            [11] 1352 	add	hl,sp
   08AB F9            [ 6] 1353 	ld	sp,hl
                           1354 ;src/IA.c:341: ay = 0;
   08AC                    1355 00118$:
   08AC DD F9         [10] 1356 	ld	sp, ix
   08AE DD E1         [14] 1357 	pop	ix
   08B0 C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   08B1                    1363 _moveIA::
   08B1 DD E5         [15] 1364 	push	ix
   08B3 DD 21 00 00   [14] 1365 	ld	ix,#0
   08B7 DD 39         [15] 1366 	add	ix,sp
   08B9 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   08BA DD 7E 04      [19] 1369 	ld	a,4 (ix)
   08BD DD 77 FE      [19] 1370 	ld	-2 (ix),a
   08C0 DD 7E 05      [19] 1371 	ld	a,5 (ix)
   08C3 DD 77 FF      [19] 1372 	ld	-1 (ix),a
   08C6 E1            [10] 1373 	pop	hl
   08C7 E5            [11] 1374 	push	hl
   08C8 23            [ 6] 1375 	inc	hl
   08C9 23            [ 6] 1376 	inc	hl
   08CA 4E            [ 7] 1377 	ld	c,(hl)
   08CB 23            [ 6] 1378 	inc	hl
   08CC 46            [ 7] 1379 	ld	b,(hl)
   08CD DD 6E 08      [19] 1380 	ld	l,8 (ix)
   08D0 DD 66 09      [19] 1381 	ld	h,9 (ix)
   08D3 23            [ 6] 1382 	inc	hl
   08D4 23            [ 6] 1383 	inc	hl
   08D5 5E            [ 7] 1384 	ld	e,(hl)
   08D6 23            [ 6] 1385 	inc	hl
   08D7 56            [ 7] 1386 	ld	d,(hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   08D8 DD 7E FE      [19] 1388 	ld	a,-2 (ix)
   08DB C6 0C         [ 7] 1389 	add	a, #0x0C
   08DD 6F            [ 4] 1390 	ld	l,a
   08DE DD 7E FF      [19] 1391 	ld	a,-1 (ix)
   08E1 CE 00         [ 7] 1392 	adc	a, #0x00
   08E3 67            [ 4] 1393 	ld	h,a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   08E4 7B            [ 4] 1395 	ld	a,e
   08E5 91            [ 4] 1396 	sub	a, c
   08E6 7A            [ 4] 1397 	ld	a,d
   08E7 98            [ 4] 1398 	sbc	a, b
   08E8 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   08EA 36 E0         [10] 1401 	ld	(hl),#0xE0
   08EC 23            [ 6] 1402 	inc	hl
   08ED 36 FF         [10] 1403 	ld	(hl),#0xFF
   08EF 18 0B         [12] 1404 	jr	00106$
   08F1                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   08F1 79            [ 4] 1407 	ld	a,c
   08F2 93            [ 4] 1408 	sub	a, e
   08F3 78            [ 4] 1409 	ld	a,b
   08F4 9A            [ 4] 1410 	sbc	a, d
   08F5 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   08F7 36 20         [10] 1413 	ld	(hl),#0x20
   08F9 23            [ 6] 1414 	inc	hl
   08FA 36 00         [10] 1415 	ld	(hl),#0x00
   08FC                    1416 00106$:
   08FC DD F9         [10] 1417 	ld	sp, ix
   08FE DD E1         [14] 1418 	pop	ix
   0900 C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   1995                    1422 __xinit__vRulesx:
   1995 58 02              1423 	.dw _rulex
   1997 5C 02              1424 	.dw _rulex1
   1999 60 02              1425 	.dw _rulex2
   199B                    1426 __xinit__vRulesy:
   199B 64 02              1427 	.dw _ruley
   199D 68 02              1428 	.dw _ruley1
   199F 6C 02              1429 	.dw _ruley2
   19A1                    1430 __xinit__fmems:
   19A1 42 02              1431 	.dw _acelPo
   19A3 4D 02              1432 	.dw _acelMed
   19A5 37 02              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
