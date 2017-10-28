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
   19B0                      41 _aceleracion::
   19B0                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   19B6                      47 _vRulesx::
   19B6                      48 	.ds 6
   19BC                      49 _vRulesy::
   19BC                      50 	.ds 6
   19C2                      51 _fmems::
   19C2                      52 	.ds 6
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
   0108 21 F8 FF      [10]   81 	ld	hl, #-8
   010B 39            [11]   82 	add	hl, sp
   010C F9            [ 6]   83 	ld	sp, hl
                             84 ;src/IA.c:129: u8 i = 0;
   010D 1E 00         [ 7]   85 	ld	e, #0x00
                             86 ;src/IA.c:130: switch(nivel){
   010F DD 7E 04      [19]   87 	ld	a, 4 (ix)
   0112 B7            [ 4]   88 	or	a, a
   0113 28 09         [12]   89 	jr	Z,00101$
   0115 DD 7E 04      [19]   90 	ld	a, 4 (ix)
   0118 3D            [ 4]   91 	dec	a
   0119 28 59         [12]   92 	jr	Z,00105$
   011B C3 C8 01      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   011E                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   011E 21 00 00      [10]   97 	ld	hl, #0x0000
   0121 39            [11]   98 	add	hl, sp
   0122 DD 75 FE      [19]   99 	ld	-2 (ix), l
   0125 DD 74 FF      [19]  100 	ld	-1 (ix), h
   0128 36 0F         [10]  101 	ld	(hl), #0x0f
   012A 23            [ 6]  102 	inc	hl
   012B 36 00         [10]  103 	ld	(hl), #0x00
   012D DD 6E FE      [19]  104 	ld	l,-2 (ix)
   0130 DD 66 FF      [19]  105 	ld	h,-1 (ix)
   0133 23            [ 6]  106 	inc	hl
   0134 23            [ 6]  107 	inc	hl
   0135 36 14         [10]  108 	ld	(hl), #0x14
   0137 23            [ 6]  109 	inc	hl
   0138 36 00         [10]  110 	ld	(hl), #0x00
   013A DD 7E FE      [19]  111 	ld	a, -2 (ix)
   013D C6 04         [ 7]  112 	add	a, #0x04
   013F 6F            [ 4]  113 	ld	l, a
   0140 DD 7E FF      [19]  114 	ld	a, -1 (ix)
   0143 CE 00         [ 7]  115 	adc	a, #0x00
   0145 67            [ 4]  116 	ld	h, a
   0146 36 17         [10]  117 	ld	(hl), #0x17
   0148 23            [ 6]  118 	inc	hl
   0149 36 00         [10]  119 	ld	(hl), #0x00
                            120 ;src/IA.c:133: while(i<3)
   014B 01 B0 19      [10]  121 	ld	bc, #_aceleracion+0
   014E 1E 00         [ 7]  122 	ld	e, #0x00
   0150                     123 00102$:
   0150 7B            [ 4]  124 	ld	a, e
   0151 D6 03         [ 7]  125 	sub	a, #0x03
   0153 30 1F         [12]  126 	jr	NC,00124$
                            127 ;src/IA.c:135: aceleracion[i] = aux[i];
   0155 6B            [ 4]  128 	ld	l, e
   0156 26 00         [ 7]  129 	ld	h, #0x00
   0158 29            [11]  130 	add	hl, hl
   0159 E5            [11]  131 	push	hl
   015A FD E1         [14]  132 	pop	iy
   015C FD 09         [15]  133 	add	iy, bc
   015E DD 7E FE      [19]  134 	ld	a, -2 (ix)
   0161 85            [ 4]  135 	add	a, l
   0162 6F            [ 4]  136 	ld	l, a
   0163 DD 7E FF      [19]  137 	ld	a, -1 (ix)
   0166 8C            [ 4]  138 	adc	a, h
   0167 67            [ 4]  139 	ld	h, a
   0168 7E            [ 7]  140 	ld	a, (hl)
   0169 23            [ 6]  141 	inc	hl
   016A 56            [ 7]  142 	ld	d, (hl)
   016B FD 77 00      [19]  143 	ld	0 (iy), a
   016E FD 72 01      [19]  144 	ld	1 (iy), d
                            145 ;src/IA.c:136: i++;
   0171 1C            [ 4]  146 	inc	e
   0172 18 DC         [12]  147 	jr	00102$
                            148 ;src/IA.c:139: case 1:{
   0174                     149 00124$:
   0174                     150 00105$:
                            151 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   0174 21 00 00      [10]  152 	ld	hl, #0x0000
   0177 39            [11]  153 	add	hl, sp
   0178 DD 75 FE      [19]  154 	ld	-2 (ix), l
   017B DD 74 FF      [19]  155 	ld	-1 (ix), h
   017E 36 17         [10]  156 	ld	(hl), #0x17
   0180 23            [ 6]  157 	inc	hl
   0181 36 00         [10]  158 	ld	(hl), #0x00
   0183 DD 6E FE      [19]  159 	ld	l,-2 (ix)
   0186 DD 66 FF      [19]  160 	ld	h,-1 (ix)
   0189 23            [ 6]  161 	inc	hl
   018A 23            [ 6]  162 	inc	hl
   018B 36 19         [10]  163 	ld	(hl), #0x19
   018D 23            [ 6]  164 	inc	hl
   018E 36 00         [10]  165 	ld	(hl), #0x00
   0190 DD 7E FE      [19]  166 	ld	a, -2 (ix)
   0193 C6 04         [ 7]  167 	add	a, #0x04
   0195 6F            [ 4]  168 	ld	l, a
   0196 DD 7E FF      [19]  169 	ld	a, -1 (ix)
   0199 CE 00         [ 7]  170 	adc	a, #0x00
   019B 67            [ 4]  171 	ld	h, a
   019C 36 33         [10]  172 	ld	(hl), #0x33
   019E 23            [ 6]  173 	inc	hl
   019F 36 00         [10]  174 	ld	(hl), #0x00
                            175 ;src/IA.c:141: while(i<3)
   01A1 01 B0 19      [10]  176 	ld	bc, #_aceleracion+0
   01A4                     177 00106$:
   01A4 7B            [ 4]  178 	ld	a, e
   01A5 D6 03         [ 7]  179 	sub	a, #0x03
   01A7 30 1F         [12]  180 	jr	NC,00125$
                            181 ;src/IA.c:143: aceleracion[i] = aux[i];
   01A9 6B            [ 4]  182 	ld	l, e
   01AA 26 00         [ 7]  183 	ld	h, #0x00
   01AC 29            [11]  184 	add	hl, hl
   01AD E5            [11]  185 	push	hl
   01AE FD E1         [14]  186 	pop	iy
   01B0 FD 09         [15]  187 	add	iy, bc
   01B2 DD 7E FE      [19]  188 	ld	a, -2 (ix)
   01B5 85            [ 4]  189 	add	a, l
   01B6 6F            [ 4]  190 	ld	l, a
   01B7 DD 7E FF      [19]  191 	ld	a, -1 (ix)
   01BA 8C            [ 4]  192 	adc	a, h
   01BB 67            [ 4]  193 	ld	h, a
   01BC 7E            [ 7]  194 	ld	a, (hl)
   01BD 23            [ 6]  195 	inc	hl
   01BE 56            [ 7]  196 	ld	d, (hl)
   01BF FD 77 00      [19]  197 	ld	0 (iy), a
   01C2 FD 72 01      [19]  198 	ld	1 (iy), d
                            199 ;src/IA.c:144: i++;
   01C5 1C            [ 4]  200 	inc	e
   01C6 18 DC         [12]  201 	jr	00106$
                            202 ;src/IA.c:147: default:{
   01C8                     203 00125$:
   01C8                     204 00109$:
                            205 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   01C8 21 00 00      [10]  206 	ld	hl, #0x0000
   01CB 39            [11]  207 	add	hl, sp
   01CC 4D            [ 4]  208 	ld	c,l
   01CD 44            [ 4]  209 	ld	b,h
   01CE 36 19         [10]  210 	ld	(hl), #0x19
   01D0 23            [ 6]  211 	inc	hl
   01D1 36 00         [10]  212 	ld	(hl), #0x00
   01D3 69            [ 4]  213 	ld	l, c
   01D4 60            [ 4]  214 	ld	h, b
   01D5 23            [ 6]  215 	inc	hl
   01D6 23            [ 6]  216 	inc	hl
   01D7 36 33         [10]  217 	ld	(hl), #0x33
   01D9 23            [ 6]  218 	inc	hl
   01DA 36 00         [10]  219 	ld	(hl), #0x00
   01DC 21 04 00      [10]  220 	ld	hl, #0x0004
   01DF 09            [11]  221 	add	hl, bc
   01E0 36 4C         [10]  222 	ld	(hl), #0x4c
   01E2 23            [ 6]  223 	inc	hl
   01E3 36 00         [10]  224 	ld	(hl), #0x00
                            225 ;src/IA.c:149: while(i<3)
   01E5                     226 00110$:
   01E5 7B            [ 4]  227 	ld	a, e
   01E6 D6 03         [ 7]  228 	sub	a, #0x03
   01E8 30 1B         [12]  229 	jr	NC,00114$
                            230 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   01EA 6B            [ 4]  231 	ld	l, e
   01EB 26 00         [ 7]  232 	ld	h, #0x00
   01ED 29            [11]  233 	add	hl, hl
   01EE FD 21 B0 19   [14]  234 	ld	iy, #_aceleracion
   01F2 C5            [11]  235 	push	bc
   01F3 4D            [ 4]  236 	ld	c, l
   01F4 44            [ 4]  237 	ld	b, h
   01F5 FD 09         [15]  238 	add	iy, bc
   01F7 C1            [10]  239 	pop	bc
   01F8 09            [11]  240 	add	hl, bc
   01F9 7E            [ 7]  241 	ld	a, (hl)
   01FA 23            [ 6]  242 	inc	hl
   01FB 66            [ 7]  243 	ld	h, (hl)
   01FC FD 77 00      [19]  244 	ld	0 (iy), a
   01FF FD 74 01      [19]  245 	ld	1 (iy), h
                            246 ;src/IA.c:152: i++;
   0202 1C            [ 4]  247 	inc	e
   0203 18 E0         [12]  248 	jr	00110$
                            249 ;src/IA.c:155: }
   0205                     250 00114$:
   0205 DD F9         [10]  251 	ld	sp, ix
   0207 DD E1         [14]  252 	pop	ix
   0209 C9            [10]  253 	ret
   020A                     254 _cerca:
   020A 00 00               255 	.dw #0x0000
   020C 00 05               256 	.dw #0x0500
   020E 01                  257 	.db #0x01	; 1
   020F 00 0A               258 	.dw #0x0a00
   0211 00 0A               259 	.dw #0x0a00
   0213 00 0A               260 	.dw #0x0a00
   0215                     261 _medio:
   0215 00 00               262 	.dw #0x0000
   0217 00 14               263 	.dw #0x1400
   0219 00                  264 	.db #0x00	; 0
   021A 00 14               265 	.dw #0x1400
   021C 00 0A               266 	.dw #0x0a00
   021E 00 0F               267 	.dw #0x0f00
   0220                     268 _lejos:
   0220 00 00               269 	.dw #0x0000
   0222 00 6E               270 	.dw #0x6e00
   0224 02                  271 	.db #0x02	; 2
   0225 00 3C               272 	.dw #0x3c00
   0227 00 19               273 	.dw #0x1900
   0229 00 64               274 	.dw #0x6400
   022B                     275 _acelMu:
   022B 00 00               276 	.dw #0x0000
   022D 80 57               277 	.dw #0x5780
   022F 02                  278 	.db #0x02	; 2
   0230 00 4B               279 	.dw #0x4b00
   0232 00 19               280 	.dw #0x1900
   0234 00 19               281 	.dw #0x1900
   0236                     282 _acelPo:
   0236 00 00               283 	.dw #0x0000
   0238 80 0C               284 	.dw #0x0c80
   023A 01                  285 	.db #0x01	; 1
   023B 00 19               286 	.dw #0x1900
   023D 00 19               287 	.dw #0x1900
   023F 00 19               288 	.dw #0x1900
   0241                     289 _acelMed:
   0241 00 00               290 	.dw #0x0000
   0243 00 32               291 	.dw #0x3200
   0245 00                  292 	.db #0x00	; 0
   0246 00 32               293 	.dw #0x3200
   0248 00 19               294 	.dw #0x1900
   024A 00 19               295 	.dw #0x1900
   024C                     296 _rulex:
   024C 0A 02               297 	.dw _cerca
   024E 2B 02               298 	.dw _acelMu
   0250                     299 _rulex1:
   0250 15 02               300 	.dw _medio
   0252 41 02               301 	.dw _acelMed
   0254                     302 _rulex2:
   0254 20 02               303 	.dw _lejos
   0256 36 02               304 	.dw _acelPo
   0258                     305 _ruley:
   0258 0A 02               306 	.dw _cerca
   025A 2B 02               307 	.dw _acelMu
   025C                     308 _ruley1:
   025C 15 02               309 	.dw _medio
   025E 41 02               310 	.dw _acelMed
   0260                     311 _ruley2:
   0260 20 02               312 	.dw _lejos
   0262 36 02               313 	.dw _acelPo
                            314 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            315 ;	---------------------------------
                            316 ; Function calculateDom
                            317 ; ---------------------------------
   0264                     318 _calculateDom::
   0264 DD E5         [15]  319 	push	ix
   0266 DD 21 00 00   [14]  320 	ld	ix,#0
   026A DD 39         [15]  321 	add	ix,sp
   026C 21 ED FF      [10]  322 	ld	hl, #-19
   026F 39            [11]  323 	add	hl, sp
   0270 F9            [ 6]  324 	ld	sp, hl
                            325 ;src/IA.c:161: *grad = 0.0;
   0271 DD 5E 07      [19]  326 	ld	e,7 (ix)
   0274 DD 56 08      [19]  327 	ld	d,8 (ix)
   0277 6B            [ 4]  328 	ld	l, e
   0278 62            [ 4]  329 	ld	h, d
   0279 AF            [ 4]  330 	xor	a, a
   027A 77            [ 7]  331 	ld	(hl), a
   027B 23            [ 6]  332 	inc	hl
   027C 77            [ 7]  333 	ld	(hl), a
                            334 ;src/IA.c:162: if(c->tipo == 0){
   027D DD 7E 04      [19]  335 	ld	a, 4 (ix)
   0280 DD 77 F0      [19]  336 	ld	-16 (ix), a
   0283 DD 7E 05      [19]  337 	ld	a, 5 (ix)
   0286 DD 77 F1      [19]  338 	ld	-15 (ix), a
   0289 DD 6E F0      [19]  339 	ld	l,-16 (ix)
   028C DD 66 F1      [19]  340 	ld	h,-15 (ix)
   028F 01 04 00      [10]  341 	ld	bc, #0x0004
   0292 09            [11]  342 	add	hl, bc
   0293 4E            [ 7]  343 	ld	c, (hl)
                            344 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   0294 DD 7E F0      [19]  345 	ld	a, -16 (ix)
   0297 C6 09         [ 7]  346 	add	a, #0x09
   0299 DD 77 FC      [19]  347 	ld	-4 (ix), a
   029C DD 7E F1      [19]  348 	ld	a, -15 (ix)
   029F CE 00         [ 7]  349 	adc	a, #0x00
   02A1 DD 77 FD      [19]  350 	ld	-3 (ix), a
   02A4 DD 7E F0      [19]  351 	ld	a, -16 (ix)
   02A7 C6 05         [ 7]  352 	add	a, #0x05
   02A9 DD 77 FE      [19]  353 	ld	-2 (ix), a
   02AC DD 7E F1      [19]  354 	ld	a, -15 (ix)
   02AF CE 00         [ 7]  355 	adc	a, #0x00
   02B1 DD 77 FF      [19]  356 	ld	-1 (ix), a
   02B4 DD 7E 06      [19]  357 	ld	a, 6 (ix)
   02B7 DD 77 F4      [19]  358 	ld	-12 (ix), a
   02BA DD 36 F5 00   [19]  359 	ld	-11 (ix), #0x00
                            360 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   02BE DD 7E F0      [19]  361 	ld	a, -16 (ix)
   02C1 C6 07         [ 7]  362 	add	a, #0x07
   02C3 DD 77 F0      [19]  363 	ld	-16 (ix), a
   02C6 DD 7E F1      [19]  364 	ld	a, -15 (ix)
   02C9 CE 00         [ 7]  365 	adc	a, #0x00
   02CB DD 77 F1      [19]  366 	ld	-15 (ix), a
                            367 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   02CE DD 6E FE      [19]  368 	ld	l,-2 (ix)
   02D1 DD 66 FF      [19]  369 	ld	h,-1 (ix)
   02D4 7E            [ 7]  370 	ld	a, (hl)
   02D5 DD 77 F2      [19]  371 	ld	-14 (ix), a
   02D8 23            [ 6]  372 	inc	hl
   02D9 7E            [ 7]  373 	ld	a, (hl)
   02DA DD 77 F3      [19]  374 	ld	-13 (ix), a
                            375 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   02DD DD 7E 06      [19]  376 	ld	a, 6 (ix)
   02E0 DD 77 F8      [19]  377 	ld	-8 (ix), a
   02E3 DD 36 F9 00   [19]  378 	ld	-7 (ix), #0x00
                            379 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   02E7 DD 6E FC      [19]  380 	ld	l,-4 (ix)
   02EA DD 66 FD      [19]  381 	ld	h,-3 (ix)
   02ED 7E            [ 7]  382 	ld	a, (hl)
   02EE DD 77 FA      [19]  383 	ld	-6 (ix), a
   02F1 23            [ 6]  384 	inc	hl
   02F2 7E            [ 7]  385 	ld	a, (hl)
   02F3 DD 77 FB      [19]  386 	ld	-5 (ix), a
                            387 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            388 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   02F6 AF            [ 4]  389 	xor	a, a
   02F7 DD 96 FA      [19]  390 	sub	a, -6 (ix)
   02FA 6F            [ 4]  391 	ld	l, a
   02FB 3E 00         [ 7]  392 	ld	a, #0x00
   02FD DD 9E FB      [19]  393 	sbc	a, -5 (ix)
   0300 67            [ 4]  394 	ld	h, a
   0301 C5            [11]  395 	push	bc
   0302 D5            [11]  396 	push	de
   0303 E5            [11]  397 	push	hl
   0304 21 00 01      [10]  398 	ld	hl, #0x0100
   0307 E5            [11]  399 	push	hl
                            400 ;src/IA.c:162: if(c->tipo == 0){
   0308 CD E2 0F      [17]  401 	call	__divuint
   030B F1            [10]  402 	pop	af
   030C F1            [10]  403 	pop	af
   030D DD 74 F7      [19]  404 	ld	-9 (ix), h
   0310 DD 75 F6      [19]  405 	ld	-10 (ix), l
   0313 D1            [10]  406 	pop	de
   0314 C1            [10]  407 	pop	bc
   0315 79            [ 4]  408 	ld	a, c
   0316 B7            [ 4]  409 	or	a, a
   0317 C2 3B 04      [10]  410 	jp	NZ, 00138$
                            411 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   031A DD 7E F4      [19]  412 	ld	a, -12 (ix)
   031D DD 96 F2      [19]  413 	sub	a, -14 (ix)
   0320 20 0C         [12]  414 	jr	NZ,00214$
   0322 DD 7E F5      [19]  415 	ld	a, -11 (ix)
   0325 DD 96 F3      [19]  416 	sub	a, -13 (ix)
   0328 20 04         [12]  417 	jr	NZ,00214$
   032A 3E 01         [ 7]  418 	ld	a,#0x01
   032C 18 01         [12]  419 	jr	00215$
   032E                     420 00214$:
   032E AF            [ 4]  421 	xor	a,a
   032F                     422 00215$:
   032F 47            [ 4]  423 	ld	b, a
   0330 DD 7E FB      [19]  424 	ld	a, -5 (ix)
   0333 DD B6 FA      [19]  425 	or	a,-6 (ix)
   0336 20 04         [12]  426 	jr	NZ,00105$
   0338 78            [ 4]  427 	ld	a, b
   0339 B7            [ 4]  428 	or	a, a
   033A 20 10         [12]  429 	jr	NZ,00101$
   033C                     430 00105$:
                            431 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   033C DD 6E F0      [19]  432 	ld	l,-16 (ix)
   033F DD 66 F1      [19]  433 	ld	h,-15 (ix)
   0342 4E            [ 7]  434 	ld	c, (hl)
   0343 23            [ 6]  435 	inc	hl
   0344 66            [ 7]  436 	ld	h, (hl)
   0345 7C            [ 4]  437 	ld	a, h
   0346 B1            [ 4]  438 	or	a,c
   0347 20 0D         [12]  439 	jr	NZ,00102$
   0349 B0            [ 4]  440 	or	a,b
   034A 28 0A         [12]  441 	jr	Z,00102$
   034C                     442 00101$:
                            443 ;src/IA.c:167: *grad = SCALA;
   034C 3E 00         [ 7]  444 	ld	a, #0x00
   034E 12            [ 7]  445 	ld	(de), a
   034F 13            [ 6]  446 	inc	de
   0350 3E 01         [ 7]  447 	ld	a, #0x01
   0352 12            [ 7]  448 	ld	(de), a
                            449 ;src/IA.c:168: return;
   0353 C3 85 05      [10]  450 	jp	00140$
   0356                     451 00102$:
                            452 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   0356 DD 7E F2      [19]  453 	ld	a, -14 (ix)
   0359 DD 96 F4      [19]  454 	sub	a, -12 (ix)
   035C DD 7E F3      [19]  455 	ld	a, -13 (ix)
   035F DD 9E F5      [19]  456 	sbc	a, -11 (ix)
   0362 3E 00         [ 7]  457 	ld	a, #0x00
   0364 17            [ 4]  458 	rla
   0365 DD 77 EF      [19]  459 	ld	-17 (ix), a
   0368 DD CB EF 46   [20]  460 	bit	0, -17 (ix)
   036C 20 68         [12]  461 	jr	NZ,00111$
   036E DD 7E F2      [19]  462 	ld	a, -14 (ix)
   0371 91            [ 4]  463 	sub	a, c
   0372 47            [ 4]  464 	ld	b, a
   0373 DD 7E F3      [19]  465 	ld	a, -13 (ix)
   0376 9C            [ 4]  466 	sbc	a, h
   0377 6F            [ 4]  467 	ld	l, a
   0378 DD 7E F4      [19]  468 	ld	a, -12 (ix)
   037B 90            [ 4]  469 	sub	a, b
   037C DD 7E F5      [19]  470 	ld	a, -11 (ix)
   037F 9D            [ 4]  471 	sbc	a, l
   0380 38 54         [12]  472 	jr	C,00111$
                            473 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   0382 D5            [11]  474 	push	de
   0383 69            [ 4]  475 	ld	l, c
   0384 E5            [11]  476 	push	hl
   0385 21 00 01      [10]  477 	ld	hl, #0x0100
   0388 E5            [11]  478 	push	hl
   0389 CD E2 0F      [17]  479 	call	__divuint
   038C F1            [10]  480 	pop	af
   038D F1            [10]  481 	pop	af
   038E 4D            [ 4]  482 	ld	c, l
   038F 44            [ 4]  483 	ld	b, h
   0390 D1            [10]  484 	pop	de
   0391 6B            [ 4]  485 	ld	l, e
   0392 62            [ 4]  486 	ld	h, d
   0393 71            [ 7]  487 	ld	(hl), c
   0394 23            [ 6]  488 	inc	hl
   0395 70            [ 7]  489 	ld	(hl), b
                            490 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   0396 DD 6E FE      [19]  491 	ld	l,-2 (ix)
   0399 DD 66 FF      [19]  492 	ld	h,-1 (ix)
   039C 7E            [ 7]  493 	ld	a, (hl)
   039D DD 77 ED      [19]  494 	ld	-19 (ix), a
   03A0 23            [ 6]  495 	inc	hl
   03A1 7E            [ 7]  496 	ld	a, (hl)
   03A2 DD 77 EE      [19]  497 	ld	-18 (ix), a
   03A5 DD 6E F0      [19]  498 	ld	l,-16 (ix)
   03A8 DD 66 F1      [19]  499 	ld	h,-15 (ix)
   03AB 7E            [ 7]  500 	ld	a, (hl)
   03AC 23            [ 6]  501 	inc	hl
   03AD 66            [ 7]  502 	ld	h, (hl)
   03AE 6F            [ 4]  503 	ld	l, a
   03AF DD 7E ED      [19]  504 	ld	a, -19 (ix)
   03B2 95            [ 4]  505 	sub	a, l
   03B3 6F            [ 4]  506 	ld	l, a
   03B4 DD 7E EE      [19]  507 	ld	a, -18 (ix)
   03B7 9C            [ 4]  508 	sbc	a, h
   03B8 67            [ 4]  509 	ld	h, a
   03B9 DD 7E F8      [19]  510 	ld	a, -8 (ix)
   03BC 95            [ 4]  511 	sub	a, l
   03BD 6F            [ 4]  512 	ld	l, a
   03BE DD 7E F9      [19]  513 	ld	a, -7 (ix)
   03C1 9C            [ 4]  514 	sbc	a, h
   03C2 67            [ 4]  515 	ld	h, a
   03C3 D5            [11]  516 	push	de
   03C4 E5            [11]  517 	push	hl
   03C5 C5            [11]  518 	push	bc
   03C6 CD 6B 18      [17]  519 	call	__mulint
   03C9 F1            [10]  520 	pop	af
   03CA F1            [10]  521 	pop	af
   03CB 4D            [ 4]  522 	ld	c, l
   03CC 44            [ 4]  523 	ld	b, h
   03CD D1            [10]  524 	pop	de
   03CE 79            [ 4]  525 	ld	a, c
   03CF 12            [ 7]  526 	ld	(de), a
   03D0 13            [ 6]  527 	inc	de
   03D1 78            [ 4]  528 	ld	a, b
   03D2 12            [ 7]  529 	ld	(de), a
                            530 ;src/IA.c:175: return;
   03D3 C3 85 05      [10]  531 	jp	00140$
   03D6                     532 00111$:
                            533 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   03D6 DD CB EF 46   [20]  534 	bit	0, -17 (ix)
   03DA 28 55         [12]  535 	jr	Z,00107$
   03DC DD 7E F2      [19]  536 	ld	a, -14 (ix)
   03DF DD 86 FA      [19]  537 	add	a, -6 (ix)
   03E2 4F            [ 4]  538 	ld	c, a
   03E3 DD 7E F3      [19]  539 	ld	a, -13 (ix)
   03E6 DD 8E FB      [19]  540 	adc	a, -5 (ix)
   03E9 47            [ 4]  541 	ld	b, a
   03EA DD 7E F4      [19]  542 	ld	a, -12 (ix)
   03ED 91            [ 4]  543 	sub	a, c
   03EE DD 7E F5      [19]  544 	ld	a, -11 (ix)
   03F1 98            [ 4]  545 	sbc	a, b
   03F2 30 3D         [12]  546 	jr	NC,00107$
                            547 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   03F4 6B            [ 4]  548 	ld	l, e
   03F5 62            [ 4]  549 	ld	h, d
   03F6 DD 7E F6      [19]  550 	ld	a, -10 (ix)
   03F9 77            [ 7]  551 	ld	(hl), a
   03FA 23            [ 6]  552 	inc	hl
   03FB DD 7E F7      [19]  553 	ld	a, -9 (ix)
   03FE 77            [ 7]  554 	ld	(hl), a
                            555 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   03FF DD 6E FE      [19]  556 	ld	l,-2 (ix)
   0402 DD 66 FF      [19]  557 	ld	h,-1 (ix)
   0405 4E            [ 7]  558 	ld	c, (hl)
   0406 23            [ 6]  559 	inc	hl
   0407 46            [ 7]  560 	ld	b, (hl)
   0408 DD 7E F8      [19]  561 	ld	a, -8 (ix)
   040B 91            [ 4]  562 	sub	a, c
   040C 4F            [ 4]  563 	ld	c, a
   040D DD 7E F9      [19]  564 	ld	a, -7 (ix)
   0410 98            [ 4]  565 	sbc	a, b
   0411 47            [ 4]  566 	ld	b, a
   0412 D5            [11]  567 	push	de
   0413 C5            [11]  568 	push	bc
   0414 DD 6E F6      [19]  569 	ld	l,-10 (ix)
   0417 DD 66 F7      [19]  570 	ld	h,-9 (ix)
   041A E5            [11]  571 	push	hl
   041B CD 6B 18      [17]  572 	call	__mulint
   041E F1            [10]  573 	pop	af
   041F F1            [10]  574 	pop	af
   0420 4D            [ 4]  575 	ld	c, l
   0421 44            [ 4]  576 	ld	b, h
   0422 D1            [10]  577 	pop	de
   0423 21 00 01      [10]  578 	ld	hl, #0x0100
   0426 09            [11]  579 	add	hl,bc
   0427 4D            [ 4]  580 	ld	c, l
   0428 44            [ 4]  581 	ld	b, h
   0429 79            [ 4]  582 	ld	a, c
   042A 12            [ 7]  583 	ld	(de), a
   042B 13            [ 6]  584 	inc	de
   042C 78            [ 4]  585 	ld	a, b
   042D 12            [ 7]  586 	ld	(de), a
                            587 ;src/IA.c:180: return;
   042E C3 85 05      [10]  588 	jp	00140$
   0431                     589 00107$:
                            590 ;src/IA.c:183: *grad = 0;
   0431 3E 00         [ 7]  591 	ld	a, #0x00
   0433 12            [ 7]  592 	ld	(de), a
   0434 13            [ 6]  593 	inc	de
   0435 3E 00         [ 7]  594 	ld	a, #0x00
   0437 12            [ 7]  595 	ld	(de), a
                            596 ;src/IA.c:184: return;
   0438 C3 85 05      [10]  597 	jp	00140$
   043B                     598 00138$:
                            599 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   043B DD 6E F2      [19]  600 	ld	l, -14 (ix)
   043E DD 7E FA      [19]  601 	ld	a, -6 (ix)
   0441 DD 77 ED      [19]  602 	ld	-19 (ix), a
   0444 7D            [ 4]  603 	ld	a, l
   0445 DD 86 ED      [19]  604 	add	a, -19 (ix)
   0448 DD 96 ED      [19]  605 	sub	a, -19 (ix)
   044B 47            [ 4]  606 	ld	b, a
                            607 ;src/IA.c:187: }else if(c->tipo == 1)
   044C 0D            [ 4]  608 	dec	c
   044D C2 DD 04      [10]  609 	jp	NZ,00135$
                            610 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   0450 48            [ 4]  611 	ld	c, b
                            612 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   0451 DD 7E FB      [19]  613 	ld	a, -5 (ix)
   0454 DD B6 FA      [19]  614 	or	a,-6 (ix)
   0457 20 0E         [12]  615 	jr	NZ,00115$
   0459 DD 7E 06      [19]  616 	ld	a, 6 (ix)
                            617 ;src/IA.c:193: *grad = SCALA;
   045C 91            [ 4]  618 	sub	a,c
   045D 20 08         [12]  619 	jr	NZ,00115$
   045F 12            [ 7]  620 	ld	(de), a
   0460 13            [ 6]  621 	inc	de
   0461 3E 01         [ 7]  622 	ld	a, #0x01
   0463 12            [ 7]  623 	ld	(de), a
                            624 ;src/IA.c:194: return;
   0464 C3 85 05      [10]  625 	jp	00140$
   0467                     626 00115$:
                            627 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   0467 DD 7E 06      [19]  628 	ld	a, 6 (ix)
   046A 91            [ 4]  629 	sub	a, c
   046B 3E 00         [ 7]  630 	ld	a, #0x00
   046D 17            [ 4]  631 	rla
   046E DD 77 ED      [19]  632 	ld	-19 (ix), a
   0471 DD CB ED 46   [20]  633 	bit	0, -19 (ix)
   0475 20 4C         [12]  634 	jr	NZ,00121$
   0477 06 00         [ 7]  635 	ld	b, #0x00
   0479 DD 6E FA      [19]  636 	ld	l,-6 (ix)
   047C DD 66 FB      [19]  637 	ld	h,-5 (ix)
   047F 09            [11]  638 	add	hl, bc
   0480 DD 7E F4      [19]  639 	ld	a, -12 (ix)
   0483 95            [ 4]  640 	sub	a, l
   0484 DD 7E F5      [19]  641 	ld	a, -11 (ix)
   0487 9C            [ 4]  642 	sbc	a, h
   0488 30 39         [12]  643 	jr	NC,00121$
                            644 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   048A 6B            [ 4]  645 	ld	l, e
   048B 62            [ 4]  646 	ld	h, d
   048C DD 7E F6      [19]  647 	ld	a, -10 (ix)
   048F 77            [ 7]  648 	ld	(hl), a
   0490 23            [ 6]  649 	inc	hl
   0491 DD 7E F7      [19]  650 	ld	a, -9 (ix)
   0494 77            [ 7]  651 	ld	(hl), a
                            652 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   0495 DD 6E FC      [19]  653 	ld	l,-4 (ix)
   0498 DD 66 FD      [19]  654 	ld	h,-3 (ix)
   049B 7E            [ 7]  655 	ld	a, (hl)
   049C 23            [ 6]  656 	inc	hl
   049D 66            [ 7]  657 	ld	h, (hl)
   049E 6F            [ 4]  658 	ld	l, a
   049F 09            [11]  659 	add	hl, bc
   04A0 DD 7E F8      [19]  660 	ld	a, -8 (ix)
   04A3 95            [ 4]  661 	sub	a, l
   04A4 4F            [ 4]  662 	ld	c, a
   04A5 DD 7E F9      [19]  663 	ld	a, -7 (ix)
   04A8 9C            [ 4]  664 	sbc	a, h
   04A9 47            [ 4]  665 	ld	b, a
   04AA D5            [11]  666 	push	de
   04AB C5            [11]  667 	push	bc
   04AC DD 6E F6      [19]  668 	ld	l,-10 (ix)
   04AF DD 66 F7      [19]  669 	ld	h,-9 (ix)
   04B2 E5            [11]  670 	push	hl
   04B3 CD 6B 18      [17]  671 	call	__mulint
   04B6 F1            [10]  672 	pop	af
   04B7 F1            [10]  673 	pop	af
   04B8 4D            [ 4]  674 	ld	c, l
   04B9 44            [ 4]  675 	ld	b, h
   04BA D1            [10]  676 	pop	de
   04BB 79            [ 4]  677 	ld	a, c
   04BC 12            [ 7]  678 	ld	(de), a
   04BD 13            [ 6]  679 	inc	de
   04BE 78            [ 4]  680 	ld	a, b
   04BF 12            [ 7]  681 	ld	(de), a
                            682 ;src/IA.c:201: return;
   04C0 C3 85 05      [10]  683 	jp	00140$
   04C3                     684 00121$:
                            685 ;src/IA.c:202: }else if(val < midPoint)
   04C3 DD CB ED 46   [20]  686 	bit	0, -19 (ix)
   04C7 28 0A         [12]  687 	jr	Z,00118$
                            688 ;src/IA.c:204: *grad = SCALA;
   04C9 3E 00         [ 7]  689 	ld	a, #0x00
   04CB 12            [ 7]  690 	ld	(de), a
   04CC 13            [ 6]  691 	inc	de
   04CD 3E 01         [ 7]  692 	ld	a, #0x01
   04CF 12            [ 7]  693 	ld	(de), a
                            694 ;src/IA.c:205: return;
   04D0 C3 85 05      [10]  695 	jp	00140$
   04D3                     696 00118$:
                            697 ;src/IA.c:207: *grad = 0;
   04D3 3E 00         [ 7]  698 	ld	a, #0x00
   04D5 12            [ 7]  699 	ld	(de), a
   04D6 13            [ 6]  700 	inc	de
   04D7 3E 00         [ 7]  701 	ld	a, #0x00
   04D9 12            [ 7]  702 	ld	(de), a
                            703 ;src/IA.c:208: return;
   04DA C3 85 05      [10]  704 	jp	00140$
   04DD                     705 00135$:
                            706 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            707 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   04DD DD 6E F0      [19]  708 	ld	l,-16 (ix)
   04E0 DD 66 F1      [19]  709 	ld	h,-15 (ix)
   04E3 4E            [ 7]  710 	ld	c, (hl)
   04E4 23            [ 6]  711 	inc	hl
   04E5 7E            [ 7]  712 	ld	a, (hl)
   04E6 B1            [ 4]  713 	or	a,c
   04E7 20 0D         [12]  714 	jr	NZ,00125$
   04E9 DD 7E 06      [19]  715 	ld	a, 6 (ix)
   04EC 90            [ 4]  716 	sub	a, b
   04ED 20 07         [12]  717 	jr	NZ,00125$
                            718 ;src/IA.c:215: *grad = SCALA;
   04EF 6B            [ 4]  719 	ld	l, e
   04F0 62            [ 4]  720 	ld	h, d
   04F1 36 00         [10]  721 	ld	(hl), #0x00
   04F3 23            [ 6]  722 	inc	hl
   04F4 36 01         [10]  723 	ld	(hl), #0x01
   04F6                     724 00125$:
                            725 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   04F6 78            [ 4]  726 	ld	a, b
   04F7 DD 96 06      [19]  727 	sub	a, 6 (ix)
   04FA 3E 00         [ 7]  728 	ld	a, #0x00
   04FC 17            [ 4]  729 	rla
   04FD DD 77 ED      [19]  730 	ld	-19 (ix), a
   0500 DD CB ED 46   [20]  731 	bit	0, -19 (ix)
   0504 20 69         [12]  732 	jr	NZ,00131$
   0506 0E 00         [ 7]  733 	ld	c, #0x00
   0508 DD 6E F0      [19]  734 	ld	l,-16 (ix)
   050B DD 66 F1      [19]  735 	ld	h,-15 (ix)
   050E 7E            [ 7]  736 	ld	a, (hl)
   050F 23            [ 6]  737 	inc	hl
   0510 66            [ 7]  738 	ld	h, (hl)
   0511 6F            [ 4]  739 	ld	l, a
   0512 DD 70 F6      [19]  740 	ld	-10 (ix), b
   0515 DD 71 F7      [19]  741 	ld	-9 (ix), c
   0518 DD 7E F6      [19]  742 	ld	a, -10 (ix)
   051B 95            [ 4]  743 	sub	a, l
   051C 4F            [ 4]  744 	ld	c, a
   051D DD 7E F7      [19]  745 	ld	a, -9 (ix)
   0520 9C            [ 4]  746 	sbc	a, h
   0521 47            [ 4]  747 	ld	b, a
   0522 79            [ 4]  748 	ld	a, c
   0523 DD 96 F4      [19]  749 	sub	a, -12 (ix)
   0526 78            [ 4]  750 	ld	a, b
   0527 DD 9E F5      [19]  751 	sbc	a, -11 (ix)
   052A 30 43         [12]  752 	jr	NC,00131$
                            753 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   052C D5            [11]  754 	push	de
   052D E5            [11]  755 	push	hl
   052E 21 00 01      [10]  756 	ld	hl, #0x0100
   0531 E5            [11]  757 	push	hl
   0532 CD E2 0F      [17]  758 	call	__divuint
   0535 F1            [10]  759 	pop	af
   0536 F1            [10]  760 	pop	af
   0537 4D            [ 4]  761 	ld	c, l
   0538 44            [ 4]  762 	ld	b, h
   0539 D1            [10]  763 	pop	de
   053A 6B            [ 4]  764 	ld	l, e
   053B 62            [ 4]  765 	ld	h, d
   053C 71            [ 7]  766 	ld	(hl), c
   053D 23            [ 6]  767 	inc	hl
   053E 70            [ 7]  768 	ld	(hl), b
                            769 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   053F DD 6E F0      [19]  770 	ld	l,-16 (ix)
   0542 DD 66 F1      [19]  771 	ld	h,-15 (ix)
   0545 7E            [ 7]  772 	ld	a, (hl)
   0546 23            [ 6]  773 	inc	hl
   0547 66            [ 7]  774 	ld	h, (hl)
   0548 6F            [ 4]  775 	ld	l, a
   0549 DD 7E F6      [19]  776 	ld	a, -10 (ix)
   054C 95            [ 4]  777 	sub	a, l
   054D 6F            [ 4]  778 	ld	l, a
   054E DD 7E F7      [19]  779 	ld	a, -9 (ix)
   0551 9C            [ 4]  780 	sbc	a, h
   0552 67            [ 4]  781 	ld	h, a
   0553 DD 7E F8      [19]  782 	ld	a, -8 (ix)
   0556 95            [ 4]  783 	sub	a, l
   0557 6F            [ 4]  784 	ld	l, a
   0558 DD 7E F9      [19]  785 	ld	a, -7 (ix)
   055B 9C            [ 4]  786 	sbc	a, h
   055C 67            [ 4]  787 	ld	h, a
   055D D5            [11]  788 	push	de
   055E E5            [11]  789 	push	hl
   055F C5            [11]  790 	push	bc
   0560 CD 6B 18      [17]  791 	call	__mulint
   0563 F1            [10]  792 	pop	af
   0564 F1            [10]  793 	pop	af
   0565 4D            [ 4]  794 	ld	c, l
   0566 44            [ 4]  795 	ld	b, h
   0567 D1            [10]  796 	pop	de
   0568 79            [ 4]  797 	ld	a, c
   0569 12            [ 7]  798 	ld	(de), a
   056A 13            [ 6]  799 	inc	de
   056B 78            [ 4]  800 	ld	a, b
   056C 12            [ 7]  801 	ld	(de), a
   056D 18 16         [12]  802 	jr	00140$
   056F                     803 00131$:
                            804 ;src/IA.c:220: }else if(val > midPoint)
   056F DD CB ED 46   [20]  805 	bit	0, -19 (ix)
   0573 28 09         [12]  806 	jr	Z,00128$
                            807 ;src/IA.c:223: *grad = SCALA;
   0575 3E 00         [ 7]  808 	ld	a, #0x00
   0577 12            [ 7]  809 	ld	(de), a
   0578 13            [ 6]  810 	inc	de
   0579 3E 01         [ 7]  811 	ld	a, #0x01
   057B 12            [ 7]  812 	ld	(de), a
   057C 18 07         [12]  813 	jr	00140$
   057E                     814 00128$:
                            815 ;src/IA.c:225: *grad = 0;
   057E 3E 00         [ 7]  816 	ld	a, #0x00
   0580 12            [ 7]  817 	ld	(de), a
   0581 13            [ 6]  818 	inc	de
   0582 3E 00         [ 7]  819 	ld	a, #0x00
   0584 12            [ 7]  820 	ld	(de), a
   0585                     821 00140$:
   0585 DD F9         [10]  822 	ld	sp, ix
   0587 DD E1         [14]  823 	pop	ix
   0589 C9            [10]  824 	ret
                            825 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            826 ;	---------------------------------
                            827 ; Function defuzzi
                            828 ; ---------------------------------
   058A                     829 _defuzzi::
   058A DD E5         [15]  830 	push	ix
   058C DD 21 00 00   [14]  831 	ld	ix,#0
   0590 DD 39         [15]  832 	add	ix,sp
   0592 21 EF FF      [10]  833 	ld	hl, #-17
   0595 39            [11]  834 	add	hl, sp
   0596 F9            [ 6]  835 	ld	sp, hl
                            836 ;src/IA.c:239: *re = 0;
   0597 DD 7E 08      [19]  837 	ld	a, 8 (ix)
   059A DD 77 FE      [19]  838 	ld	-2 (ix), a
   059D DD 7E 09      [19]  839 	ld	a, 9 (ix)
   05A0 DD 77 FF      [19]  840 	ld	-1 (ix), a
   05A3 DD 6E FE      [19]  841 	ld	l,-2 (ix)
   05A6 DD 66 FF      [19]  842 	ld	h,-1 (ix)
   05A9 AF            [ 4]  843 	xor	a, a
   05AA 77            [ 7]  844 	ld	(hl), a
   05AB 23            [ 6]  845 	inc	hl
   05AC 77            [ 7]  846 	ld	(hl), a
                            847 ;src/IA.c:241: while(i < 3)
   05AD 21 00 00      [10]  848 	ld	hl, #0x0000
   05B0 39            [11]  849 	add	hl, sp
   05B1 DD 75 FC      [19]  850 	ld	-4 (ix), l
   05B4 DD 74 FD      [19]  851 	ld	-3 (ix), h
   05B7 0E 00         [ 7]  852 	ld	c, #0x00
   05B9                     853 00101$:
   05B9 79            [ 4]  854 	ld	a, c
   05BA D6 03         [ 7]  855 	sub	a, #0x03
   05BC 30 53         [12]  856 	jr	NC,00103$
                            857 ;src/IA.c:243: dom = 0;
   05BE DD 36 F6 00   [19]  858 	ld	-10 (ix), #0x00
   05C2 DD 36 F7 00   [19]  859 	ld	-9 (ix), #0x00
                            860 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   05C6 21 07 00      [10]  861 	ld	hl, #0x0007
   05C9 39            [11]  862 	add	hl, sp
   05CA DD 75 FA      [19]  863 	ld	-6 (ix), l
   05CD DD 74 FB      [19]  864 	ld	-5 (ix), h
   05D0 DD 46 04      [19]  865 	ld	b, 4 (ix)
   05D3 69            [ 4]  866 	ld	l, c
   05D4 26 00         [ 7]  867 	ld	h, #0x00
   05D6 29            [11]  868 	add	hl, hl
   05D7 EB            [ 4]  869 	ex	de,hl
   05D8 21 C2 19      [10]  870 	ld	hl, #_fmems
   05DB 19            [11]  871 	add	hl, de
   05DC 7E            [ 7]  872 	ld	a, (hl)
   05DD DD 77 F8      [19]  873 	ld	-8 (ix), a
   05E0 23            [ 6]  874 	inc	hl
   05E1 7E            [ 7]  875 	ld	a, (hl)
   05E2 DD 77 F9      [19]  876 	ld	-7 (ix), a
   05E5 C5            [11]  877 	push	bc
   05E6 D5            [11]  878 	push	de
   05E7 DD 6E FA      [19]  879 	ld	l,-6 (ix)
   05EA DD 66 FB      [19]  880 	ld	h,-5 (ix)
   05ED E5            [11]  881 	push	hl
   05EE C5            [11]  882 	push	bc
   05EF 33            [ 6]  883 	inc	sp
   05F0 DD 6E F8      [19]  884 	ld	l,-8 (ix)
   05F3 DD 66 F9      [19]  885 	ld	h,-7 (ix)
   05F6 E5            [11]  886 	push	hl
   05F7 CD 64 02      [17]  887 	call	_calculateDom
   05FA F1            [10]  888 	pop	af
   05FB F1            [10]  889 	pop	af
   05FC 33            [ 6]  890 	inc	sp
   05FD D1            [10]  891 	pop	de
   05FE C1            [10]  892 	pop	bc
                            893 ;src/IA.c:245: vDom[i] = dom/SCALA;
   05FF DD 6E FC      [19]  894 	ld	l,-4 (ix)
   0602 DD 66 FD      [19]  895 	ld	h,-3 (ix)
   0605 19            [11]  896 	add	hl, de
   0606 DD 5E F7      [19]  897 	ld	e, -9 (ix)
   0609 06 00         [ 7]  898 	ld	b, #0x00
   060B 73            [ 7]  899 	ld	(hl), e
   060C 23            [ 6]  900 	inc	hl
   060D 70            [ 7]  901 	ld	(hl), b
                            902 ;src/IA.c:246: i++;
   060E 0C            [ 4]  903 	inc	c
   060F 18 A8         [12]  904 	jr	00101$
   0611                     905 00103$:
                            906 ;src/IA.c:250: for(i = 0; i<3; i++)
   0611 DD 7E FC      [19]  907 	ld	a, -4 (ix)
   0614 DD 77 F8      [19]  908 	ld	-8 (ix), a
   0617 DD 7E FD      [19]  909 	ld	a, -3 (ix)
   061A DD 77 F9      [19]  910 	ld	-7 (ix), a
   061D DD 36 F5 00   [19]  911 	ld	-11 (ix), #0x00
   0621                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   0621 DD 6E F5      [19]  914 	ld	l, -11 (ix)
   0624 26 00         [ 7]  915 	ld	h, #0x00
   0626 29            [11]  916 	add	hl, hl
   0627 4D            [ 4]  917 	ld	c, l
   0628 44            [ 4]  918 	ld	b, h
   0629 DD 6E F8      [19]  919 	ld	l,-8 (ix)
   062C DD 66 F9      [19]  920 	ld	h,-7 (ix)
   062F 09            [11]  921 	add	hl, bc
   0630 5E            [ 7]  922 	ld	e, (hl)
   0631 23            [ 6]  923 	inc	hl
   0632 56            [ 7]  924 	ld	d, (hl)
   0633 21 B0 19      [10]  925 	ld	hl, #_aceleracion
   0636 09            [11]  926 	add	hl, bc
   0637 4E            [ 7]  927 	ld	c, (hl)
   0638 23            [ 6]  928 	inc	hl
   0639 46            [ 7]  929 	ld	b, (hl)
   063A C5            [11]  930 	push	bc
   063B D5            [11]  931 	push	de
   063C CD 6B 18      [17]  932 	call	__mulint
   063F F1            [10]  933 	pop	af
   0640 F1            [10]  934 	pop	af
   0641 4D            [ 4]  935 	ld	c, l
   0642 44            [ 4]  936 	ld	b, h
   0643 DD 6E FE      [19]  937 	ld	l,-2 (ix)
   0646 DD 66 FF      [19]  938 	ld	h,-1 (ix)
   0649 5E            [ 7]  939 	ld	e, (hl)
   064A 23            [ 6]  940 	inc	hl
   064B 66            [ 7]  941 	ld	h, (hl)
   064C 6B            [ 4]  942 	ld	l, e
   064D 09            [11]  943 	add	hl,bc
   064E 4D            [ 4]  944 	ld	c, l
   064F 44            [ 4]  945 	ld	b, h
   0650 DD 6E FE      [19]  946 	ld	l,-2 (ix)
   0653 DD 66 FF      [19]  947 	ld	h,-1 (ix)
   0656 71            [ 7]  948 	ld	(hl), c
   0657 23            [ 6]  949 	inc	hl
   0658 70            [ 7]  950 	ld	(hl), b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   0659 DD 34 F5      [23]  952 	inc	-11 (ix)
   065C DD 7E F5      [19]  953 	ld	a, -11 (ix)
   065F D6 03         [ 7]  954 	sub	a, #0x03
   0661 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   0663 DD 6E 06      [19]  957 	ld	l,6 (ix)
   0666 DD 66 07      [19]  958 	ld	h,7 (ix)
   0669 23            [ 6]  959 	inc	hl
   066A 7E            [ 7]  960 	ld	a, (hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   066B DD 6E FE      [19]  962 	ld	l,-2 (ix)
   066E DD 66 FF      [19]  963 	ld	h,-1 (ix)
   0671 5E            [ 7]  964 	ld	e, (hl)
   0672 23            [ 6]  965 	inc	hl
   0673 56            [ 7]  966 	ld	d, (hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   0674 B7            [ 4]  968 	or	a, a
   0675 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   0677 DD 6E FE      [19]  971 	ld	l,-2 (ix)
   067A DD 66 FF      [19]  972 	ld	h,-1 (ix)
   067D 73            [ 7]  973 	ld	(hl), e
   067E 23            [ 6]  974 	inc	hl
   067F 72            [ 7]  975 	ld	(hl), d
   0680 18 10         [12]  976 	jr	00110$
   0682                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   0682 AF            [ 4]  979 	xor	a, a
   0683 93            [ 4]  980 	sub	a, e
   0684 5F            [ 4]  981 	ld	e, a
   0685 3E 00         [ 7]  982 	ld	a, #0x00
   0687 9A            [ 4]  983 	sbc	a, d
   0688 4F            [ 4]  984 	ld	c, a
   0689 DD 6E FE      [19]  985 	ld	l,-2 (ix)
   068C DD 66 FF      [19]  986 	ld	h,-1 (ix)
   068F 73            [ 7]  987 	ld	(hl), e
   0690 23            [ 6]  988 	inc	hl
   0691 71            [ 7]  989 	ld	(hl), c
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
   06A1 DD 36 FE 00   [19] 1005 	ld	-2 (ix), #0x00
   06A5 DD 36 FF 00   [19] 1006 	ld	-1 (ix), #0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   06A9 DD 36 FD 00   [19] 1008 	ld	-3 (ix), #0x00
   06AD                    1009 00103$:
   06AD DD 7E FD      [19] 1010 	ld	a, -3 (ix)
   06B0 DD 96 04      [19] 1011 	sub	a, 4 (ix)
   06B3 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   06B5 FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   06B9 FD 39         [15] 1015 	add	iy,sp
   06BB DD 6E FD      [19] 1016 	ld	l, -3 (ix)
   06BE 26 00         [ 7] 1017 	ld	h, #0x00
   06C0 29            [11] 1018 	add	hl, hl
   06C1 01 B6 19      [10] 1019 	ld	bc,#_vRulesx
   06C4 09            [11] 1020 	add	hl,bc
   06C5 4D            [ 4] 1021 	ld	c,l
   06C6 44            [ 4] 1022 	ld	b,h
   06C7 7E            [ 7] 1023 	ld	a, (hl)
   06C8 23            [ 6] 1024 	inc	hl
   06C9 66            [ 7] 1025 	ld	h, (hl)
   06CA 6F            [ 4] 1026 	ld	l, a
   06CB 5E            [ 7] 1027 	ld	e, (hl)
   06CC 23            [ 6] 1028 	inc	hl
   06CD 56            [ 7] 1029 	ld	d, (hl)
   06CE C5            [11] 1030 	push	bc
   06CF FD E5         [15] 1031 	push	iy
   06D1 DD 7E 05      [19] 1032 	ld	a, 5 (ix)
   06D4 F5            [11] 1033 	push	af
   06D5 33            [ 6] 1034 	inc	sp
   06D6 D5            [11] 1035 	push	de
   06D7 CD 64 02      [17] 1036 	call	_calculateDom
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
   06E8 66            [ 7] 1048 	ld	h, (hl)
   06E9 6F            [ 4] 1049 	ld	l, a
   06EA 23            [ 6] 1050 	inc	hl
   06EB 23            [ 6] 1051 	inc	hl
   06EC 7E            [ 7] 1052 	ld	a, (hl)
   06ED 23            [ 6] 1053 	inc	hl
   06EE 66            [ 7] 1054 	ld	h, (hl)
   06EF 6F            [ 4] 1055 	ld	l, a
   06F0 23            [ 6] 1056 	inc	hl
   06F1 23            [ 6] 1057 	inc	hl
   06F2 4E            [ 7] 1058 	ld	c, (hl)
   06F3 23            [ 6] 1059 	inc	hl
   06F4 46            [ 7] 1060 	ld	b, (hl)
   06F5 D5            [11] 1061 	push	de
   06F6 DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   06F9 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   06FC E5            [11] 1064 	push	hl
   06FD C5            [11] 1065 	push	bc
   06FE CD 6B 18      [17] 1066 	call	__mulint
   0701 F1            [10] 1067 	pop	af
   0702 F1            [10] 1068 	pop	af
   0703 4D            [ 4] 1069 	ld	c, l
   0704 44            [ 4] 1070 	ld	b, h
   0705 D1            [10] 1071 	pop	de
   0706 6B            [ 4] 1072 	ld	l, e
   0707 62            [ 4] 1073 	ld	h, d
   0708 7E            [ 7] 1074 	ld	a, (hl)
   0709 23            [ 6] 1075 	inc	hl
   070A 66            [ 7] 1076 	ld	h, (hl)
   070B 6F            [ 4] 1077 	ld	l, a
   070C 09            [11] 1078 	add	hl, bc
   070D 4C            [ 4] 1079 	ld	c, h
   070E 06 00         [ 7] 1080 	ld	b, #0x00
   0710 79            [ 4] 1081 	ld	a, c
   0711 12            [ 7] 1082 	ld	(de), a
   0712 13            [ 6] 1083 	inc	de
   0713 78            [ 4] 1084 	ld	a, b
   0714 12            [ 7] 1085 	ld	(de), a
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
   072A 12            [ 7] 1108 	ld	(de), a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   072B AF            [ 4] 1110 	xor	a, a
   072C 02            [ 7] 1111 	ld	(bc), a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   072D 21 03 00      [10] 1113 	ld	hl, #2+1
   0730 39            [11] 1114 	add	hl, sp
   0731 CB 7E         [12] 1115 	bit	7, (hl)
   0733 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   0735 3E 01         [ 7] 1118 	ld	a, #0x01
   0737 02            [ 7] 1119 	ld	(bc), a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   0738 AF            [ 4] 1121 	xor	a, a
   0739 12            [ 7] 1122 	ld	(de), a
   073A C9            [10] 1123 	ret
   073B                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   073B AF            [ 4] 1126 	xor	a, a
   073C FD 21 02 00   [14] 1127 	ld	iy, #2
   0740 FD 39         [15] 1128 	add	iy, sp
   0742 FD BE 00      [19] 1129 	cp	a, 0 (iy)
   0745 FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   0748 E2 4D 07      [10] 1131 	jp	PO, 00116$
   074B EE 80         [ 7] 1132 	xor	a, #0x80
   074D                    1133 00116$:
   074D F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   074E 3E 01         [ 7] 1136 	ld	a, #0x01
   0750 12            [ 7] 1137 	ld	(de), a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   0751 AF            [ 4] 1139 	xor	a, a
   0752 02            [ 7] 1140 	ld	(bc), a
   0753 C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   0754                    1146 _fuzzificacion::
   0754 DD E5         [15] 1147 	push	ix
   0756 DD 21 00 00   [14] 1148 	ld	ix,#0
   075A DD 39         [15] 1149 	add	ix,sp
   075C 21 EE FF      [10] 1150 	ld	hl, #-18
   075F 39            [11] 1151 	add	hl, sp
   0760 F9            [ 6] 1152 	ld	sp, hl
                           1153 ;src/IA.c:299: ball = &ballX;
   0761 21 04 00      [10] 1154 	ld	hl, #0x0004
   0764 39            [11] 1155 	add	hl, sp
   0765 DD 75 FC      [19] 1156 	ld	-4 (ix), l
   0768 DD 74 FD      [19] 1157 	ld	-3 (ix), h
   076B 4D            [ 4] 1158 	ld	c, l
   076C 44            [ 4] 1159 	ld	b, h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   076D DD 5E 08      [19] 1161 	ld	e, 8 (ix)
   0770 16 00         [ 7] 1162 	ld	d, #0x00
   0772 DD 6E 0A      [19] 1163 	ld	l, 10 (ix)
   0775 26 00         [ 7] 1164 	ld	h, #0x00
   0777 7B            [ 4] 1165 	ld	a, e
   0778 95            [ 4] 1166 	sub	a, l
   0779 DD 77 FE      [19] 1167 	ld	-2 (ix), a
   077C 7A            [ 4] 1168 	ld	a, d
   077D 9C            [ 4] 1169 	sbc	a, h
   077E DD 77 FF      [19] 1170 	ld	-1 (ix), a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   0781 DD 6E 09      [19] 1172 	ld	l, 9 (ix)
   0784 26 00         [ 7] 1173 	ld	h, #0x00
   0786 DD 5E 0B      [19] 1174 	ld	e, 11 (ix)
   0789 16 00         [ 7] 1175 	ld	d, #0x00
   078B 7D            [ 4] 1176 	ld	a, l
   078C 93            [ 4] 1177 	sub	a, e
   078D DD 77 FA      [19] 1178 	ld	-6 (ix), a
   0790 7C            [ 4] 1179 	ld	a, h
   0791 9A            [ 4] 1180 	sbc	a, d
   0792 DD 77 FB      [19] 1181 	ld	-5 (ix), a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   0795 3E 6F         [ 7] 1183 	ld	a, #0x6f
   0797 93            [ 4] 1184 	sub	a, e
   0798 DD 77 F6      [19] 1185 	ld	-10 (ix), a
   079B 3E 00         [ 7] 1186 	ld	a, #0x00
   079D 9A            [ 4] 1187 	sbc	a, d
   079E DD 77 F7      [19] 1188 	ld	-9 (ix), a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   07A1 59            [ 4] 1190 	ld	e, c
   07A2 50            [ 4] 1191 	ld	d, b
   07A3 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   07A4 3E FE         [ 7] 1194 	ld	a, #0xfe
   07A6 DD BE FE      [19] 1195 	cp	a, -2 (ix)
   07A9 3E FF         [ 7] 1196 	ld	a, #0xff
   07AB DD 9E FF      [19] 1197 	sbc	a, -1 (ix)
   07AE E2 B3 07      [10] 1198 	jp	PO, 00148$
   07B1 EE 80         [ 7] 1199 	xor	a, #0x80
   07B3                    1200 00148$:
   07B3 FA BD 07      [10] 1201 	jp	M, 00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   07B6 3E 01         [ 7] 1203 	ld	a, #0x01
   07B8 02            [ 7] 1204 	ld	(bc), a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   07B9 AF            [ 4] 1206 	xor	a, a
   07BA 12            [ 7] 1207 	ld	(de), a
   07BB 18 05         [12] 1208 	jr	00103$
   07BD                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   07BD 3E 01         [ 7] 1211 	ld	a, #0x01
   07BF 12            [ 7] 1212 	ld	(de), a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   07C0 AF            [ 4] 1214 	xor	a, a
   07C1 02            [ 7] 1215 	ld	(bc), a
   07C2                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   07C2 AF            [ 4] 1218 	xor	a, a
   07C3 DD BE FE      [19] 1219 	cp	a, -2 (ix)
   07C6 DD 9E FF      [19] 1220 	sbc	a, -1 (ix)
   07C9 E2 CE 07      [10] 1221 	jp	PO, 00149$
   07CC EE 80         [ 7] 1222 	xor	a, #0x80
   07CE                    1223 00149$:
   07CE 07            [ 4] 1224 	rlca
   07CF E6 01         [ 7] 1225 	and	a,#0x01
   07D1 4F            [ 4] 1226 	ld	c, a
   07D2 DD 7E F6      [19] 1227 	ld	a, -10 (ix)
   07D5 DD 96 FA      [19] 1228 	sub	a, -6 (ix)
   07D8 DD 7E F7      [19] 1229 	ld	a, -9 (ix)
   07DB DD 9E FB      [19] 1230 	sbc	a, -5 (ix)
   07DE E2 E3 07      [10] 1231 	jp	PO, 00150$
   07E1 EE 80         [ 7] 1232 	xor	a, #0x80
   07E3                    1233 00150$:
   07E3 F2 FD 07      [10] 1234 	jp	P, 00109$
   07E6 79            [ 4] 1235 	ld	a, c
   07E7 B7            [ 4] 1236 	or	a, a
   07E8 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   07EA 21 02 00      [10] 1239 	ld	hl, #0x0002
   07ED 39            [11] 1240 	add	hl, sp
   07EE E5            [11] 1241 	push	hl
   07EF DD 6E F6      [19] 1242 	ld	l,-10 (ix)
   07F2 DD 66 F7      [19] 1243 	ld	h,-9 (ix)
   07F5 E5            [11] 1244 	push	hl
   07F6 CD 1F 07      [17] 1245 	call	_calcularb_direc
   07F9 F1            [10] 1246 	pop	af
   07FA F1            [10] 1247 	pop	af
   07FB 18 3C         [12] 1248 	jr	00110$
   07FD                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   07FD DD 7E FA      [19] 1251 	ld	a, -6 (ix)
   0800 DD 96 F6      [19] 1252 	sub	a, -10 (ix)
   0803 DD 7E FB      [19] 1253 	ld	a, -5 (ix)
   0806 DD 9E F7      [19] 1254 	sbc	a, -9 (ix)
   0809 E2 0E 08      [10] 1255 	jp	PO, 00151$
   080C EE 80         [ 7] 1256 	xor	a, #0x80
   080E                    1257 00151$:
   080E F2 28 08      [10] 1258 	jp	P, 00105$
   0811 79            [ 4] 1259 	ld	a, c
   0812 B7            [ 4] 1260 	or	a, a
   0813 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   0815 21 02 00      [10] 1263 	ld	hl, #0x0002
   0818 39            [11] 1264 	add	hl, sp
   0819 E5            [11] 1265 	push	hl
   081A DD 6E F6      [19] 1266 	ld	l,-10 (ix)
   081D DD 66 F7      [19] 1267 	ld	h,-9 (ix)
   0820 E5            [11] 1268 	push	hl
   0821 CD 1F 07      [17] 1269 	call	_calcularb_direc
   0824 F1            [10] 1270 	pop	af
   0825 F1            [10] 1271 	pop	af
   0826 18 11         [12] 1272 	jr	00110$
   0828                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   0828 21 02 00      [10] 1275 	ld	hl, #0x0002
   082B 39            [11] 1276 	add	hl, sp
   082C E5            [11] 1277 	push	hl
   082D DD 6E FA      [19] 1278 	ld	l,-6 (ix)
   0830 DD 66 FB      [19] 1279 	ld	h,-5 (ix)
   0833 E5            [11] 1280 	push	hl
   0834 CD 1F 07      [17] 1281 	call	_calcularb_direc
   0837 F1            [10] 1282 	pop	af
   0838 F1            [10] 1283 	pop	af
   0839                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   0839 DD 4E FE      [19] 1286 	ld	c, -2 (ix)
   083C DD 71 F9      [19] 1287 	ld	-7 (ix), c
   083F DD 36 F8 00   [19] 1288 	ld	-8 (ix), #0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   0843 DD 46 FA      [19] 1290 	ld	b, -6 (ix)
   0846 0E 00         [ 7] 1291 	ld	c, #0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   0848 21 00 00      [10] 1293 	ld	hl, #0x0000
   084B 39            [11] 1294 	add	hl, sp
   084C DD 56 F8      [19] 1295 	ld	d, -8 (ix)
   084F C5            [11] 1296 	push	bc
   0850 E5            [11] 1297 	push	hl
   0851 1E 03         [ 7] 1298 	ld	e, #0x03
   0853 D5            [11] 1299 	push	de
   0854 CD 97 06      [17] 1300 	call	_calcule
   0857 F1            [10] 1301 	pop	af
   0858 F1            [10] 1302 	pop	af
   0859 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   085A 21 06 00      [10] 1305 	ld	hl, #0x0006
   085D 39            [11] 1306 	add	hl, sp
   085E 51            [ 4] 1307 	ld	d, c
   085F C5            [11] 1308 	push	bc
   0860 E5            [11] 1309 	push	hl
   0861 1E 03         [ 7] 1310 	ld	e, #0x03
   0863 D5            [11] 1311 	push	de
   0864 CD 97 06      [17] 1312 	call	_calcule
   0867 F1            [10] 1313 	pop	af
   0868 F1            [10] 1314 	pop	af
   0869 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   086A 78            [ 4] 1317 	ld	a, b
   086B B1            [ 4] 1318 	or	a,c
   086C 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   086E DD 4E FC      [19] 1321 	ld	c,-4 (ix)
   0871 DD 46 FD      [19] 1322 	ld	b,-3 (ix)
   0874 DD 6E 04      [19] 1323 	ld	l,4 (ix)
   0877 DD 66 05      [19] 1324 	ld	h,5 (ix)
   087A E5            [11] 1325 	push	hl
   087B C5            [11] 1326 	push	bc
   087C DD 6E EE      [19] 1327 	ld	l,-18 (ix)
   087F DD 66 EF      [19] 1328 	ld	h,-17 (ix)
   0882 E5            [11] 1329 	push	hl
   0883 CD 8A 05      [17] 1330 	call	_defuzzi
   0886 21 06 00      [10] 1331 	ld	hl, #6
   0889 39            [11] 1332 	add	hl, sp
   088A F9            [ 6] 1333 	ld	sp, hl
                           1334 ;src/IA.c:336: ax = 0;
   088B                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   088B DD 7E F9      [19] 1337 	ld	a, -7 (ix)
   088E DD B6 F8      [19] 1338 	or	a,-8 (ix)
   0891 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   0893 21 02 00      [10] 1341 	ld	hl, #0x0002
   0896 39            [11] 1342 	add	hl, sp
   0897 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   089A DD 46 07      [19] 1344 	ld	b,7 (ix)
   089D C5            [11] 1345 	push	bc
   089E E5            [11] 1346 	push	hl
   089F DD 6E F4      [19] 1347 	ld	l,-12 (ix)
   08A2 DD 66 F5      [19] 1348 	ld	h,-11 (ix)
   08A5 E5            [11] 1349 	push	hl
   08A6 CD 8A 05      [17] 1350 	call	_defuzzi
   08A9 21 06 00      [10] 1351 	ld	hl, #6
   08AC 39            [11] 1352 	add	hl, sp
   08AD F9            [ 6] 1353 	ld	sp, hl
                           1354 ;src/IA.c:341: ay = 0;
   08AE                    1355 00118$:
   08AE DD F9         [10] 1356 	ld	sp, ix
   08B0 DD E1         [14] 1357 	pop	ix
   08B2 C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   08B3                    1363 _moveIA::
   08B3 DD E5         [15] 1364 	push	ix
   08B5 DD 21 00 00   [14] 1365 	ld	ix,#0
   08B9 DD 39         [15] 1366 	add	ix,sp
   08BB F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   08BC DD 7E 04      [19] 1369 	ld	a, 4 (ix)
   08BF DD 77 FE      [19] 1370 	ld	-2 (ix), a
   08C2 DD 7E 05      [19] 1371 	ld	a, 5 (ix)
   08C5 DD 77 FF      [19] 1372 	ld	-1 (ix), a
   08C8 E1            [10] 1373 	pop	hl
   08C9 E5            [11] 1374 	push	hl
   08CA 23            [ 6] 1375 	inc	hl
   08CB 23            [ 6] 1376 	inc	hl
   08CC 4E            [ 7] 1377 	ld	c, (hl)
   08CD 23            [ 6] 1378 	inc	hl
   08CE 46            [ 7] 1379 	ld	b, (hl)
   08CF DD 6E 08      [19] 1380 	ld	l,8 (ix)
   08D2 DD 66 09      [19] 1381 	ld	h,9 (ix)
   08D5 23            [ 6] 1382 	inc	hl
   08D6 23            [ 6] 1383 	inc	hl
   08D7 5E            [ 7] 1384 	ld	e, (hl)
   08D8 23            [ 6] 1385 	inc	hl
   08D9 56            [ 7] 1386 	ld	d, (hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   08DA DD 7E FE      [19] 1388 	ld	a, -2 (ix)
   08DD C6 0C         [ 7] 1389 	add	a, #0x0c
   08DF 6F            [ 4] 1390 	ld	l, a
   08E0 DD 7E FF      [19] 1391 	ld	a, -1 (ix)
   08E3 CE 00         [ 7] 1392 	adc	a, #0x00
   08E5 67            [ 4] 1393 	ld	h, a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   08E6 7B            [ 4] 1395 	ld	a, e
   08E7 91            [ 4] 1396 	sub	a, c
   08E8 7A            [ 4] 1397 	ld	a, d
   08E9 98            [ 4] 1398 	sbc	a, b
   08EA 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   08EC 36 E0         [10] 1401 	ld	(hl), #0xe0
   08EE 23            [ 6] 1402 	inc	hl
   08EF 36 FF         [10] 1403 	ld	(hl), #0xff
   08F1 18 0B         [12] 1404 	jr	00106$
   08F3                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   08F3 79            [ 4] 1407 	ld	a, c
   08F4 93            [ 4] 1408 	sub	a, e
   08F5 78            [ 4] 1409 	ld	a, b
   08F6 9A            [ 4] 1410 	sbc	a, d
   08F7 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   08F9 36 20         [10] 1413 	ld	(hl), #0x20
   08FB 23            [ 6] 1414 	inc	hl
   08FC 36 00         [10] 1415 	ld	(hl), #0x00
   08FE                    1416 00106$:
   08FE DD F9         [10] 1417 	ld	sp, ix
   0900 DD E1         [14] 1418 	pop	ix
   0902 C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   19C8                    1422 __xinit__vRulesx:
   19C8 4C 02              1423 	.dw _rulex
   19CA 50 02              1424 	.dw _rulex1
   19CC 54 02              1425 	.dw _rulex2
   19CE                    1426 __xinit__vRulesy:
   19CE 58 02              1427 	.dw _ruley
   19D0 5C 02              1428 	.dw _ruley1
   19D2 60 02              1429 	.dw _ruley2
   19D4                    1430 __xinit__fmems:
   19D4 36 02              1431 	.dw _acelPo
   19D6 41 02              1432 	.dw _acelMed
   19D8 2B 02              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
