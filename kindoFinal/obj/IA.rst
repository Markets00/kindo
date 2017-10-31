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
   5D60                      41 _aceleracion::
   5D60                      42 	.ds 6
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
   5D66                      47 _vRulesx::
   5D66                      48 	.ds 6
   5D6C                      49 _vRulesy::
   5D6C                      50 	.ds 6
   5D72                      51 _fmems::
   5D72                      52 	.ds 6
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
   35E6                      77 _initAcel::
   35E6 DD E5         [15]   78 	push	ix
   35E8 DD 21 00 00   [14]   79 	ld	ix,#0
   35EC DD 39         [15]   80 	add	ix,sp
   35EE 21 F8 FF      [10]   81 	ld	hl,#-8
   35F1 39            [11]   82 	add	hl,sp
   35F2 F9            [ 6]   83 	ld	sp,hl
                             84 ;src/IA.c:129: u8 i = 0;
   35F3 1E 00         [ 7]   85 	ld	e,#0x00
                             86 ;src/IA.c:130: switch(nivel){
   35F5 DD 7E 04      [19]   87 	ld	a,4 (ix)
   35F8 B7            [ 4]   88 	or	a, a
   35F9 28 09         [12]   89 	jr	Z,00101$
   35FB DD 7E 04      [19]   90 	ld	a,4 (ix)
   35FE 3D            [ 4]   91 	dec	a
   35FF 28 5F         [12]   92 	jr	Z,00105$
   3601 C3 BA 36      [10]   93 	jp	00109$
                             94 ;src/IA.c:131: case 0:{ 
   3604                      95 00101$:
                             96 ;src/IA.c:132: u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
   3604 21 00 00      [10]   97 	ld	hl,#0x0000
   3607 39            [11]   98 	add	hl,sp
   3608 DD 75 FE      [19]   99 	ld	-2 (ix),l
   360B DD 74 FF      [19]  100 	ld	-1 (ix),h
   360E DD 6E FE      [19]  101 	ld	l,-2 (ix)
   3611 DD 66 FF      [19]  102 	ld	h,-1 (ix)
   3614 36 0F         [10]  103 	ld	(hl),#0x0F
   3616 23            [ 6]  104 	inc	hl
   3617 36 00         [10]  105 	ld	(hl),#0x00
   3619 DD 6E FE      [19]  106 	ld	l,-2 (ix)
   361C DD 66 FF      [19]  107 	ld	h,-1 (ix)
   361F 23            [ 6]  108 	inc	hl
   3620 23            [ 6]  109 	inc	hl
   3621 36 14         [10]  110 	ld	(hl),#0x14
   3623 23            [ 6]  111 	inc	hl
   3624 36 00         [10]  112 	ld	(hl),#0x00
   3626 DD 7E FE      [19]  113 	ld	a,-2 (ix)
   3629 C6 04         [ 7]  114 	add	a, #0x04
   362B 6F            [ 4]  115 	ld	l,a
   362C DD 7E FF      [19]  116 	ld	a,-1 (ix)
   362F CE 00         [ 7]  117 	adc	a, #0x00
   3631 67            [ 4]  118 	ld	h,a
   3632 36 17         [10]  119 	ld	(hl),#0x17
   3634 23            [ 6]  120 	inc	hl
   3635 36 00         [10]  121 	ld	(hl),#0x00
                            122 ;src/IA.c:133: while(i<3)
   3637 01 60 5D      [10]  123 	ld	bc,#_aceleracion+0
   363A 1E 00         [ 7]  124 	ld	e,#0x00
   363C                     125 00102$:
   363C 7B            [ 4]  126 	ld	a,e
   363D D6 03         [ 7]  127 	sub	a, #0x03
   363F 30 1F         [12]  128 	jr	NC,00124$
                            129 ;src/IA.c:135: aceleracion[i] = aux[i];
   3641 6B            [ 4]  130 	ld	l,e
   3642 26 00         [ 7]  131 	ld	h,#0x00
   3644 29            [11]  132 	add	hl, hl
   3645 E5            [11]  133 	push	hl
   3646 FD E1         [14]  134 	pop	iy
   3648 FD 09         [15]  135 	add	iy, bc
   364A DD 7E FE      [19]  136 	ld	a,-2 (ix)
   364D 85            [ 4]  137 	add	a, l
   364E 6F            [ 4]  138 	ld	l,a
   364F DD 7E FF      [19]  139 	ld	a,-1 (ix)
   3652 8C            [ 4]  140 	adc	a, h
   3653 67            [ 4]  141 	ld	h,a
   3654 7E            [ 7]  142 	ld	a, (hl)
   3655 23            [ 6]  143 	inc	hl
   3656 56            [ 7]  144 	ld	d,(hl)
   3657 FD 77 00      [19]  145 	ld	0 (iy), a
   365A FD 72 01      [19]  146 	ld	1 (iy),d
                            147 ;src/IA.c:136: i++;
   365D 1C            [ 4]  148 	inc	e
   365E 18 DC         [12]  149 	jr	00102$
                            150 ;src/IA.c:139: case 1:{
   3660                     151 00124$:
   3660                     152 00105$:
                            153 ;src/IA.c:140: u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
   3660 21 00 00      [10]  154 	ld	hl,#0x0000
   3663 39            [11]  155 	add	hl,sp
   3664 DD 75 FE      [19]  156 	ld	-2 (ix),l
   3667 DD 74 FF      [19]  157 	ld	-1 (ix),h
   366A DD 6E FE      [19]  158 	ld	l,-2 (ix)
   366D DD 66 FF      [19]  159 	ld	h,-1 (ix)
   3670 36 17         [10]  160 	ld	(hl),#0x17
   3672 23            [ 6]  161 	inc	hl
   3673 36 00         [10]  162 	ld	(hl),#0x00
   3675 DD 6E FE      [19]  163 	ld	l,-2 (ix)
   3678 DD 66 FF      [19]  164 	ld	h,-1 (ix)
   367B 23            [ 6]  165 	inc	hl
   367C 23            [ 6]  166 	inc	hl
   367D 36 19         [10]  167 	ld	(hl),#0x19
   367F 23            [ 6]  168 	inc	hl
   3680 36 00         [10]  169 	ld	(hl),#0x00
   3682 DD 7E FE      [19]  170 	ld	a,-2 (ix)
   3685 C6 04         [ 7]  171 	add	a, #0x04
   3687 6F            [ 4]  172 	ld	l,a
   3688 DD 7E FF      [19]  173 	ld	a,-1 (ix)
   368B CE 00         [ 7]  174 	adc	a, #0x00
   368D 67            [ 4]  175 	ld	h,a
   368E 36 33         [10]  176 	ld	(hl),#0x33
   3690 23            [ 6]  177 	inc	hl
   3691 36 00         [10]  178 	ld	(hl),#0x00
                            179 ;src/IA.c:141: while(i<3)
   3693 01 60 5D      [10]  180 	ld	bc,#_aceleracion+0
   3696                     181 00106$:
   3696 7B            [ 4]  182 	ld	a,e
   3697 D6 03         [ 7]  183 	sub	a, #0x03
   3699 30 1F         [12]  184 	jr	NC,00125$
                            185 ;src/IA.c:143: aceleracion[i] = aux[i];
   369B 6B            [ 4]  186 	ld	l,e
   369C 26 00         [ 7]  187 	ld	h,#0x00
   369E 29            [11]  188 	add	hl, hl
   369F E5            [11]  189 	push	hl
   36A0 FD E1         [14]  190 	pop	iy
   36A2 FD 09         [15]  191 	add	iy, bc
   36A4 DD 7E FE      [19]  192 	ld	a,-2 (ix)
   36A7 85            [ 4]  193 	add	a, l
   36A8 6F            [ 4]  194 	ld	l,a
   36A9 DD 7E FF      [19]  195 	ld	a,-1 (ix)
   36AC 8C            [ 4]  196 	adc	a, h
   36AD 67            [ 4]  197 	ld	h,a
   36AE 7E            [ 7]  198 	ld	a, (hl)
   36AF 23            [ 6]  199 	inc	hl
   36B0 56            [ 7]  200 	ld	d,(hl)
   36B1 FD 77 00      [19]  201 	ld	0 (iy), a
   36B4 FD 72 01      [19]  202 	ld	1 (iy),d
                            203 ;src/IA.c:144: i++;
   36B7 1C            [ 4]  204 	inc	e
   36B8 18 DC         [12]  205 	jr	00106$
                            206 ;src/IA.c:147: default:{
   36BA                     207 00125$:
   36BA                     208 00109$:
                            209 ;src/IA.c:148: u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
   36BA 21 00 00      [10]  210 	ld	hl,#0x0000
   36BD 39            [11]  211 	add	hl,sp
   36BE 4D            [ 4]  212 	ld	c,l
   36BF 44            [ 4]  213 	ld	b,h
   36C0 36 19         [10]  214 	ld	(hl),#0x19
   36C2 23            [ 6]  215 	inc	hl
   36C3 36 00         [10]  216 	ld	(hl),#0x00
   36C5 69            [ 4]  217 	ld	l, c
   36C6 60            [ 4]  218 	ld	h, b
   36C7 23            [ 6]  219 	inc	hl
   36C8 23            [ 6]  220 	inc	hl
   36C9 36 33         [10]  221 	ld	(hl),#0x33
   36CB 23            [ 6]  222 	inc	hl
   36CC 36 00         [10]  223 	ld	(hl),#0x00
   36CE 21 04 00      [10]  224 	ld	hl,#0x0004
   36D1 09            [11]  225 	add	hl,bc
   36D2 36 4C         [10]  226 	ld	(hl),#0x4C
   36D4 23            [ 6]  227 	inc	hl
   36D5 36 00         [10]  228 	ld	(hl),#0x00
                            229 ;src/IA.c:149: while(i<3)
   36D7                     230 00110$:
   36D7 7B            [ 4]  231 	ld	a,e
   36D8 D6 03         [ 7]  232 	sub	a, #0x03
   36DA 30 1B         [12]  233 	jr	NC,00114$
                            234 ;src/IA.c:151: aceleracion[i] = aux[i]; 
   36DC 6B            [ 4]  235 	ld	l,e
   36DD 26 00         [ 7]  236 	ld	h,#0x00
   36DF 29            [11]  237 	add	hl, hl
   36E0 FD 21 60 5D   [14]  238 	ld	iy,#_aceleracion
   36E4 C5            [11]  239 	push	bc
   36E5 4D            [ 4]  240 	ld	c, l
   36E6 44            [ 4]  241 	ld	b, h
   36E7 FD 09         [15]  242 	add	iy, bc
   36E9 C1            [10]  243 	pop	bc
   36EA 09            [11]  244 	add	hl,bc
   36EB 7E            [ 7]  245 	ld	a, (hl)
   36EC 23            [ 6]  246 	inc	hl
   36ED 66            [ 7]  247 	ld	h,(hl)
   36EE FD 77 00      [19]  248 	ld	0 (iy), a
   36F1 FD 74 01      [19]  249 	ld	1 (iy),h
                            250 ;src/IA.c:152: i++;
   36F4 1C            [ 4]  251 	inc	e
   36F5 18 E0         [12]  252 	jr	00110$
                            253 ;src/IA.c:155: }
   36F7                     254 00114$:
   36F7 DD F9         [10]  255 	ld	sp, ix
   36F9 DD E1         [14]  256 	pop	ix
   36FB C9            [10]  257 	ret
   36FC                     258 _cerca:
   36FC 00 00               259 	.dw #0x0000
   36FE 00 05               260 	.dw #0x0500
   3700 01                  261 	.db #0x01	; 1
   3701 00 0A               262 	.dw #0x0A00
   3703 00 0A               263 	.dw #0x0A00
   3705 00 0A               264 	.dw #0x0A00
   3707                     265 _medio:
   3707 00 00               266 	.dw #0x0000
   3709 00 14               267 	.dw #0x1400
   370B 00                  268 	.db #0x00	; 0
   370C 00 14               269 	.dw #0x1400
   370E 00 0A               270 	.dw #0x0A00
   3710 00 0F               271 	.dw #0x0F00
   3712                     272 _lejos:
   3712 00 00               273 	.dw #0x0000
   3714 00 6E               274 	.dw #0x6E00
   3716 02                  275 	.db #0x02	; 2
   3717 00 3C               276 	.dw #0x3C00
   3719 00 19               277 	.dw #0x1900
   371B 00 64               278 	.dw #0x6400
   371D                     279 _acelMu:
   371D 00 00               280 	.dw #0x0000
   371F 80 57               281 	.dw #0x5780
   3721 02                  282 	.db #0x02	; 2
   3722 00 4B               283 	.dw #0x4B00
   3724 00 19               284 	.dw #0x1900
   3726 00 19               285 	.dw #0x1900
   3728                     286 _acelPo:
   3728 00 00               287 	.dw #0x0000
   372A 80 0C               288 	.dw #0x0C80
   372C 01                  289 	.db #0x01	; 1
   372D 00 19               290 	.dw #0x1900
   372F 00 19               291 	.dw #0x1900
   3731 00 19               292 	.dw #0x1900
   3733                     293 _acelMed:
   3733 00 00               294 	.dw #0x0000
   3735 00 32               295 	.dw #0x3200
   3737 00                  296 	.db #0x00	; 0
   3738 00 32               297 	.dw #0x3200
   373A 00 19               298 	.dw #0x1900
   373C 00 19               299 	.dw #0x1900
   373E                     300 _rulex:
   373E FC 36               301 	.dw _cerca
   3740 1D 37               302 	.dw _acelMu
   3742                     303 _rulex1:
   3742 07 37               304 	.dw _medio
   3744 33 37               305 	.dw _acelMed
   3746                     306 _rulex2:
   3746 12 37               307 	.dw _lejos
   3748 28 37               308 	.dw _acelPo
   374A                     309 _ruley:
   374A FC 36               310 	.dw _cerca
   374C 1D 37               311 	.dw _acelMu
   374E                     312 _ruley1:
   374E 07 37               313 	.dw _medio
   3750 33 37               314 	.dw _acelMed
   3752                     315 _ruley2:
   3752 12 37               316 	.dw _lejos
   3754 28 37               317 	.dw _acelPo
                            318 ;src/IA.c:159: void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
                            319 ;	---------------------------------
                            320 ; Function calculateDom
                            321 ; ---------------------------------
   3756                     322 _calculateDom::
   3756 DD E5         [15]  323 	push	ix
   3758 DD 21 00 00   [14]  324 	ld	ix,#0
   375C DD 39         [15]  325 	add	ix,sp
   375E 21 ED FF      [10]  326 	ld	hl,#-19
   3761 39            [11]  327 	add	hl,sp
   3762 F9            [ 6]  328 	ld	sp,hl
                            329 ;src/IA.c:161: *grad = 0.0;
   3763 DD 5E 07      [19]  330 	ld	e,7 (ix)
   3766 DD 56 08      [19]  331 	ld	d,8 (ix)
   3769 6B            [ 4]  332 	ld	l, e
   376A 62            [ 4]  333 	ld	h, d
   376B AF            [ 4]  334 	xor	a, a
   376C 77            [ 7]  335 	ld	(hl), a
   376D 23            [ 6]  336 	inc	hl
   376E 77            [ 7]  337 	ld	(hl), a
                            338 ;src/IA.c:162: if(c->tipo == 0){
   376F DD 7E 04      [19]  339 	ld	a,4 (ix)
   3772 DD 77 F3      [19]  340 	ld	-13 (ix),a
   3775 DD 7E 05      [19]  341 	ld	a,5 (ix)
   3778 DD 77 F4      [19]  342 	ld	-12 (ix),a
   377B DD 6E F3      [19]  343 	ld	l,-13 (ix)
   377E DD 66 F4      [19]  344 	ld	h,-12 (ix)
   3781 01 04 00      [10]  345 	ld	bc, #0x0004
   3784 09            [11]  346 	add	hl, bc
   3785 4E            [ 7]  347 	ld	c,(hl)
                            348 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   3786 DD 7E F3      [19]  349 	ld	a,-13 (ix)
   3789 C6 09         [ 7]  350 	add	a, #0x09
   378B DD 77 EF      [19]  351 	ld	-17 (ix),a
   378E DD 7E F4      [19]  352 	ld	a,-12 (ix)
   3791 CE 00         [ 7]  353 	adc	a, #0x00
   3793 DD 77 F0      [19]  354 	ld	-16 (ix),a
   3796 DD 7E F3      [19]  355 	ld	a,-13 (ix)
   3799 C6 05         [ 7]  356 	add	a, #0x05
   379B DD 77 ED      [19]  357 	ld	-19 (ix),a
   379E DD 7E F4      [19]  358 	ld	a,-12 (ix)
   37A1 CE 00         [ 7]  359 	adc	a, #0x00
   37A3 DD 77 EE      [19]  360 	ld	-18 (ix),a
   37A6 DD 7E 06      [19]  361 	ld	a,6 (ix)
   37A9 DD 77 F1      [19]  362 	ld	-15 (ix),a
   37AC DD 36 F2 00   [19]  363 	ld	-14 (ix),#0x00
                            364 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   37B0 DD 7E F3      [19]  365 	ld	a,-13 (ix)
   37B3 C6 07         [ 7]  366 	add	a, #0x07
   37B5 DD 77 F3      [19]  367 	ld	-13 (ix),a
   37B8 DD 7E F4      [19]  368 	ld	a,-12 (ix)
   37BB CE 00         [ 7]  369 	adc	a, #0x00
   37BD DD 77 F4      [19]  370 	ld	-12 (ix),a
                            371 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   37C0 E1            [10]  372 	pop	hl
   37C1 E5            [11]  373 	push	hl
   37C2 7E            [ 7]  374 	ld	a,(hl)
   37C3 DD 77 F5      [19]  375 	ld	-11 (ix),a
   37C6 23            [ 6]  376 	inc	hl
   37C7 7E            [ 7]  377 	ld	a,(hl)
   37C8 DD 77 F6      [19]  378 	ld	-10 (ix),a
                            379 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   37CB DD 7E 06      [19]  380 	ld	a,6 (ix)
   37CE DD 77 FA      [19]  381 	ld	-6 (ix),a
   37D1 DD 36 FB 00   [19]  382 	ld	-5 (ix),#0x00
                            383 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   37D5 DD 6E EF      [19]  384 	ld	l,-17 (ix)
   37D8 DD 66 F0      [19]  385 	ld	h,-16 (ix)
   37DB 7E            [ 7]  386 	ld	a,(hl)
   37DC DD 77 FE      [19]  387 	ld	-2 (ix),a
   37DF 23            [ 6]  388 	inc	hl
   37E0 7E            [ 7]  389 	ld	a,(hl)
   37E1 DD 77 FF      [19]  390 	ld	-1 (ix),a
                            391 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
                            392 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   37E4 AF            [ 4]  393 	xor	a, a
   37E5 DD 96 FE      [19]  394 	sub	a, -2 (ix)
   37E8 6F            [ 4]  395 	ld	l,a
   37E9 3E 00         [ 7]  396 	ld	a, #0x00
   37EB DD 9E FF      [19]  397 	sbc	a, -1 (ix)
   37EE 67            [ 4]  398 	ld	h,a
   37EF C5            [11]  399 	push	bc
   37F0 D5            [11]  400 	push	de
   37F1 E5            [11]  401 	push	hl
   37F2 21 00 01      [10]  402 	ld	hl,#0x0100
   37F5 E5            [11]  403 	push	hl
                            404 ;src/IA.c:162: if(c->tipo == 0){
   37F6 CD 7E 50      [17]  405 	call	__divuint
   37F9 F1            [10]  406 	pop	af
   37FA F1            [10]  407 	pop	af
   37FB DD 74 F9      [19]  408 	ld	-7 (ix),h
   37FE DD 75 F8      [19]  409 	ld	-8 (ix),l
   3801 D1            [10]  410 	pop	de
   3802 C1            [10]  411 	pop	bc
   3803 79            [ 4]  412 	ld	a,c
   3804 B7            [ 4]  413 	or	a, a
   3805 C2 21 39      [10]  414 	jp	NZ,00138$
                            415 ;src/IA.c:164: if(c->rightOffSet == 0 && c->peakPoint == val 
   3808 DD 7E F1      [19]  416 	ld	a,-15 (ix)
   380B DD 96 F5      [19]  417 	sub	a, -11 (ix)
   380E 20 0C         [12]  418 	jr	NZ,00214$
   3810 DD 7E F2      [19]  419 	ld	a,-14 (ix)
   3813 DD 96 F6      [19]  420 	sub	a, -10 (ix)
   3816 20 04         [12]  421 	jr	NZ,00214$
   3818 3E 01         [ 7]  422 	ld	a,#0x01
   381A 18 01         [12]  423 	jr	00215$
   381C                     424 00214$:
   381C AF            [ 4]  425 	xor	a,a
   381D                     426 00215$:
   381D 47            [ 4]  427 	ld	b,a
   381E DD 7E FF      [19]  428 	ld	a,-1 (ix)
   3821 DD B6 FE      [19]  429 	or	a,-2 (ix)
   3824 20 04         [12]  430 	jr	NZ,00105$
   3826 78            [ 4]  431 	ld	a,b
   3827 B7            [ 4]  432 	or	a, a
   3828 20 10         [12]  433 	jr	NZ,00101$
   382A                     434 00105$:
                            435 ;src/IA.c:165: || c->leftOffSet == 0 && c->peakPoint == val)
   382A DD 6E F3      [19]  436 	ld	l,-13 (ix)
   382D DD 66 F4      [19]  437 	ld	h,-12 (ix)
   3830 4E            [ 7]  438 	ld	c,(hl)
   3831 23            [ 6]  439 	inc	hl
   3832 66            [ 7]  440 	ld	h,(hl)
   3833 7C            [ 4]  441 	ld	a,h
   3834 B1            [ 4]  442 	or	a,c
   3835 20 0D         [12]  443 	jr	NZ,00102$
   3837 B0            [ 4]  444 	or	a,b
   3838 28 0A         [12]  445 	jr	Z,00102$
   383A                     446 00101$:
                            447 ;src/IA.c:167: *grad = SCALA;
   383A 3E 00         [ 7]  448 	ld	a,#0x00
   383C 12            [ 7]  449 	ld	(de),a
   383D 13            [ 6]  450 	inc	de
   383E 3E 01         [ 7]  451 	ld	a,#0x01
   3840 12            [ 7]  452 	ld	(de),a
                            453 ;src/IA.c:168: return;
   3841 C3 6B 3A      [10]  454 	jp	00140$
   3844                     455 00102$:
                            456 ;src/IA.c:171: if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
   3844 DD 7E F5      [19]  457 	ld	a,-11 (ix)
   3847 DD 96 F1      [19]  458 	sub	a, -15 (ix)
   384A DD 7E F6      [19]  459 	ld	a,-10 (ix)
   384D DD 9E F2      [19]  460 	sbc	a, -14 (ix)
   3850 3E 00         [ 7]  461 	ld	a,#0x00
   3852 17            [ 4]  462 	rla
   3853 DD 77 F7      [19]  463 	ld	-9 (ix),a
   3856 DD CB F7 46   [20]  464 	bit	0,-9 (ix)
   385A 20 64         [12]  465 	jr	NZ,00111$
   385C DD 7E F5      [19]  466 	ld	a,-11 (ix)
   385F 91            [ 4]  467 	sub	a, c
   3860 47            [ 4]  468 	ld	b,a
   3861 DD 7E F6      [19]  469 	ld	a,-10 (ix)
   3864 9C            [ 4]  470 	sbc	a, h
   3865 6F            [ 4]  471 	ld	l,a
   3866 DD 7E F1      [19]  472 	ld	a,-15 (ix)
   3869 90            [ 4]  473 	sub	a, b
   386A DD 7E F2      [19]  474 	ld	a,-14 (ix)
   386D 9D            [ 4]  475 	sbc	a, l
   386E 38 50         [12]  476 	jr	C,00111$
                            477 ;src/IA.c:173: *grad = SCALA / c->leftOffSet;
   3870 D5            [11]  478 	push	de
   3871 69            [ 4]  479 	ld	l, c
   3872 E5            [11]  480 	push	hl
   3873 21 00 01      [10]  481 	ld	hl,#0x0100
   3876 E5            [11]  482 	push	hl
   3877 CD 7E 50      [17]  483 	call	__divuint
   387A F1            [10]  484 	pop	af
   387B F1            [10]  485 	pop	af
   387C 4D            [ 4]  486 	ld	c,l
   387D 44            [ 4]  487 	ld	b,h
   387E D1            [10]  488 	pop	de
   387F 6B            [ 4]  489 	ld	l, e
   3880 62            [ 4]  490 	ld	h, d
   3881 71            [ 7]  491 	ld	(hl),c
   3882 23            [ 6]  492 	inc	hl
   3883 70            [ 7]  493 	ld	(hl),b
                            494 ;src/IA.c:174: *grad = *grad * (val - (c->peakPoint - c->leftOffSet));
   3884 E1            [10]  495 	pop	hl
   3885 E5            [11]  496 	push	hl
   3886 7E            [ 7]  497 	ld	a,(hl)
   3887 DD 77 FC      [19]  498 	ld	-4 (ix),a
   388A 23            [ 6]  499 	inc	hl
   388B 7E            [ 7]  500 	ld	a,(hl)
   388C DD 77 FD      [19]  501 	ld	-3 (ix),a
   388F DD 6E F3      [19]  502 	ld	l,-13 (ix)
   3892 DD 66 F4      [19]  503 	ld	h,-12 (ix)
   3895 7E            [ 7]  504 	ld	a, (hl)
   3896 23            [ 6]  505 	inc	hl
   3897 66            [ 7]  506 	ld	h,(hl)
   3898 6F            [ 4]  507 	ld	l,a
   3899 DD 7E FC      [19]  508 	ld	a,-4 (ix)
   389C 95            [ 4]  509 	sub	a, l
   389D 6F            [ 4]  510 	ld	l,a
   389E DD 7E FD      [19]  511 	ld	a,-3 (ix)
   38A1 9C            [ 4]  512 	sbc	a, h
   38A2 67            [ 4]  513 	ld	h,a
   38A3 DD 7E FA      [19]  514 	ld	a,-6 (ix)
   38A6 95            [ 4]  515 	sub	a, l
   38A7 6F            [ 4]  516 	ld	l,a
   38A8 DD 7E FB      [19]  517 	ld	a,-5 (ix)
   38AB 9C            [ 4]  518 	sbc	a, h
   38AC 67            [ 4]  519 	ld	h,a
   38AD D5            [11]  520 	push	de
   38AE E5            [11]  521 	push	hl
   38AF C5            [11]  522 	push	bc
   38B0 CD 56 5B      [17]  523 	call	__mulint
   38B3 F1            [10]  524 	pop	af
   38B4 F1            [10]  525 	pop	af
   38B5 4D            [ 4]  526 	ld	c,l
   38B6 44            [ 4]  527 	ld	b,h
   38B7 D1            [10]  528 	pop	de
   38B8 79            [ 4]  529 	ld	a,c
   38B9 12            [ 7]  530 	ld	(de),a
   38BA 13            [ 6]  531 	inc	de
   38BB 78            [ 4]  532 	ld	a,b
   38BC 12            [ 7]  533 	ld	(de),a
                            534 ;src/IA.c:175: return;
   38BD C3 6B 3A      [10]  535 	jp	00140$
   38C0                     536 00111$:
                            537 ;src/IA.c:176: }else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
   38C0 DD CB F7 46   [20]  538 	bit	0,-9 (ix)
   38C4 28 51         [12]  539 	jr	Z,00107$
   38C6 DD 7E F5      [19]  540 	ld	a,-11 (ix)
   38C9 DD 86 FE      [19]  541 	add	a, -2 (ix)
   38CC 4F            [ 4]  542 	ld	c,a
   38CD DD 7E F6      [19]  543 	ld	a,-10 (ix)
   38D0 DD 8E FF      [19]  544 	adc	a, -1 (ix)
   38D3 47            [ 4]  545 	ld	b,a
   38D4 DD 7E F1      [19]  546 	ld	a,-15 (ix)
   38D7 91            [ 4]  547 	sub	a, c
   38D8 DD 7E F2      [19]  548 	ld	a,-14 (ix)
   38DB 98            [ 4]  549 	sbc	a, b
   38DC 30 39         [12]  550 	jr	NC,00107$
                            551 ;src/IA.c:178: *grad = SCALA/-c->rightOffSet;
   38DE 6B            [ 4]  552 	ld	l, e
   38DF 62            [ 4]  553 	ld	h, d
   38E0 DD 7E F8      [19]  554 	ld	a,-8 (ix)
   38E3 77            [ 7]  555 	ld	(hl),a
   38E4 23            [ 6]  556 	inc	hl
   38E5 DD 7E F9      [19]  557 	ld	a,-7 (ix)
   38E8 77            [ 7]  558 	ld	(hl),a
                            559 ;src/IA.c:179: *grad = *grad * (val- c->peakPoint) + SCALA;
   38E9 E1            [10]  560 	pop	hl
   38EA E5            [11]  561 	push	hl
   38EB 4E            [ 7]  562 	ld	c,(hl)
   38EC 23            [ 6]  563 	inc	hl
   38ED 46            [ 7]  564 	ld	b,(hl)
   38EE DD 7E FA      [19]  565 	ld	a,-6 (ix)
   38F1 91            [ 4]  566 	sub	a, c
   38F2 4F            [ 4]  567 	ld	c,a
   38F3 DD 7E FB      [19]  568 	ld	a,-5 (ix)
   38F6 98            [ 4]  569 	sbc	a, b
   38F7 47            [ 4]  570 	ld	b,a
   38F8 D5            [11]  571 	push	de
   38F9 C5            [11]  572 	push	bc
   38FA DD 6E F8      [19]  573 	ld	l,-8 (ix)
   38FD DD 66 F9      [19]  574 	ld	h,-7 (ix)
   3900 E5            [11]  575 	push	hl
   3901 CD 56 5B      [17]  576 	call	__mulint
   3904 F1            [10]  577 	pop	af
   3905 F1            [10]  578 	pop	af
   3906 4D            [ 4]  579 	ld	c,l
   3907 44            [ 4]  580 	ld	b,h
   3908 D1            [10]  581 	pop	de
   3909 21 00 01      [10]  582 	ld	hl,#0x0100
   390C 09            [11]  583 	add	hl,bc
   390D 4D            [ 4]  584 	ld	c,l
   390E 44            [ 4]  585 	ld	b,h
   390F 79            [ 4]  586 	ld	a,c
   3910 12            [ 7]  587 	ld	(de),a
   3911 13            [ 6]  588 	inc	de
   3912 78            [ 4]  589 	ld	a,b
   3913 12            [ 7]  590 	ld	(de),a
                            591 ;src/IA.c:180: return;
   3914 C3 6B 3A      [10]  592 	jp	00140$
   3917                     593 00107$:
                            594 ;src/IA.c:183: *grad = 0;
   3917 3E 00         [ 7]  595 	ld	a,#0x00
   3919 12            [ 7]  596 	ld	(de),a
   391A 13            [ 6]  597 	inc	de
   391B 3E 00         [ 7]  598 	ld	a,#0x00
   391D 12            [ 7]  599 	ld	(de),a
                            600 ;src/IA.c:184: return;
   391E C3 6B 3A      [10]  601 	jp	00140$
   3921                     602 00138$:
                            603 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   3921 DD 6E F5      [19]  604 	ld	l,-11 (ix)
   3924 DD 7E FE      [19]  605 	ld	a,-2 (ix)
   3927 DD 77 FC      [19]  606 	ld	-4 (ix),a
   392A 7D            [ 4]  607 	ld	a,l
   392B DD 86 FC      [19]  608 	add	a, -4 (ix)
   392E DD 96 FC      [19]  609 	sub	a, -4 (ix)
   3931 47            [ 4]  610 	ld	b,a
                            611 ;src/IA.c:187: }else if(c->tipo == 1)
   3932 0D            [ 4]  612 	dec	c
   3933 C2 C3 39      [10]  613 	jp	NZ,00135$
                            614 ;src/IA.c:189: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
   3936 48            [ 4]  615 	ld	c,b
                            616 ;src/IA.c:192: if(c->rightOffSet == 0 && val == midPoint){
   3937 DD 7E FF      [19]  617 	ld	a,-1 (ix)
   393A DD B6 FE      [19]  618 	or	a,-2 (ix)
   393D 20 0E         [12]  619 	jr	NZ,00115$
   393F DD 7E 06      [19]  620 	ld	a,6 (ix)
                            621 ;src/IA.c:193: *grad = SCALA;
   3942 91            [ 4]  622 	sub	a,c
   3943 20 08         [12]  623 	jr	NZ,00115$
   3945 12            [ 7]  624 	ld	(de),a
   3946 13            [ 6]  625 	inc	de
   3947 3E 01         [ 7]  626 	ld	a,#0x01
   3949 12            [ 7]  627 	ld	(de),a
                            628 ;src/IA.c:194: return;
   394A C3 6B 3A      [10]  629 	jp	00140$
   394D                     630 00115$:
                            631 ;src/IA.c:197: if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
   394D DD 7E 06      [19]  632 	ld	a,6 (ix)
   3950 91            [ 4]  633 	sub	a, c
   3951 3E 00         [ 7]  634 	ld	a,#0x00
   3953 17            [ 4]  635 	rla
   3954 DD 77 FC      [19]  636 	ld	-4 (ix),a
   3957 DD CB FC 46   [20]  637 	bit	0,-4 (ix)
   395B 20 4C         [12]  638 	jr	NZ,00121$
   395D 06 00         [ 7]  639 	ld	b,#0x00
   395F DD 6E FE      [19]  640 	ld	l,-2 (ix)
   3962 DD 66 FF      [19]  641 	ld	h,-1 (ix)
   3965 09            [11]  642 	add	hl,bc
   3966 DD 7E F1      [19]  643 	ld	a,-15 (ix)
   3969 95            [ 4]  644 	sub	a, l
   396A DD 7E F2      [19]  645 	ld	a,-14 (ix)
   396D 9C            [ 4]  646 	sbc	a, h
   396E 30 39         [12]  647 	jr	NC,00121$
                            648 ;src/IA.c:199: *grad = SCALA/-c->rightOffSet;
   3970 6B            [ 4]  649 	ld	l, e
   3971 62            [ 4]  650 	ld	h, d
   3972 DD 7E F8      [19]  651 	ld	a,-8 (ix)
   3975 77            [ 7]  652 	ld	(hl),a
   3976 23            [ 6]  653 	inc	hl
   3977 DD 7E F9      [19]  654 	ld	a,-7 (ix)
   397A 77            [ 7]  655 	ld	(hl),a
                            656 ;src/IA.c:200: *grad = *grad*(val-(midPoint + c->rightOffSet));
   397B DD 6E EF      [19]  657 	ld	l,-17 (ix)
   397E DD 66 F0      [19]  658 	ld	h,-16 (ix)
   3981 7E            [ 7]  659 	ld	a, (hl)
   3982 23            [ 6]  660 	inc	hl
   3983 66            [ 7]  661 	ld	h,(hl)
   3984 6F            [ 4]  662 	ld	l,a
   3985 09            [11]  663 	add	hl,bc
   3986 DD 7E FA      [19]  664 	ld	a,-6 (ix)
   3989 95            [ 4]  665 	sub	a, l
   398A 4F            [ 4]  666 	ld	c,a
   398B DD 7E FB      [19]  667 	ld	a,-5 (ix)
   398E 9C            [ 4]  668 	sbc	a, h
   398F 47            [ 4]  669 	ld	b,a
   3990 D5            [11]  670 	push	de
   3991 C5            [11]  671 	push	bc
   3992 DD 6E F8      [19]  672 	ld	l,-8 (ix)
   3995 DD 66 F9      [19]  673 	ld	h,-7 (ix)
   3998 E5            [11]  674 	push	hl
   3999 CD 56 5B      [17]  675 	call	__mulint
   399C F1            [10]  676 	pop	af
   399D F1            [10]  677 	pop	af
   399E 4D            [ 4]  678 	ld	c,l
   399F 44            [ 4]  679 	ld	b,h
   39A0 D1            [10]  680 	pop	de
   39A1 79            [ 4]  681 	ld	a,c
   39A2 12            [ 7]  682 	ld	(de),a
   39A3 13            [ 6]  683 	inc	de
   39A4 78            [ 4]  684 	ld	a,b
   39A5 12            [ 7]  685 	ld	(de),a
                            686 ;src/IA.c:201: return;
   39A6 C3 6B 3A      [10]  687 	jp	00140$
   39A9                     688 00121$:
                            689 ;src/IA.c:202: }else if(val < midPoint)
   39A9 DD CB FC 46   [20]  690 	bit	0,-4 (ix)
   39AD 28 0A         [12]  691 	jr	Z,00118$
                            692 ;src/IA.c:204: *grad = SCALA;
   39AF 3E 00         [ 7]  693 	ld	a,#0x00
   39B1 12            [ 7]  694 	ld	(de),a
   39B2 13            [ 6]  695 	inc	de
   39B3 3E 01         [ 7]  696 	ld	a,#0x01
   39B5 12            [ 7]  697 	ld	(de),a
                            698 ;src/IA.c:205: return;
   39B6 C3 6B 3A      [10]  699 	jp	00140$
   39B9                     700 00118$:
                            701 ;src/IA.c:207: *grad = 0;
   39B9 3E 00         [ 7]  702 	ld	a,#0x00
   39BB 12            [ 7]  703 	ld	(de),a
   39BC 13            [ 6]  704 	inc	de
   39BD 3E 00         [ 7]  705 	ld	a,#0x00
   39BF 12            [ 7]  706 	ld	(de),a
                            707 ;src/IA.c:208: return;
   39C0 C3 6B 3A      [10]  708 	jp	00140$
   39C3                     709 00135$:
                            710 ;src/IA.c:212: u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
                            711 ;src/IA.c:214: if(c->leftOffSet == 0 && val == midPoint)
   39C3 DD 6E F3      [19]  712 	ld	l,-13 (ix)
   39C6 DD 66 F4      [19]  713 	ld	h,-12 (ix)
   39C9 4E            [ 7]  714 	ld	c,(hl)
   39CA 23            [ 6]  715 	inc	hl
   39CB 7E            [ 7]  716 	ld	a, (hl)
   39CC B1            [ 4]  717 	or	a,c
   39CD 20 0D         [12]  718 	jr	NZ,00125$
   39CF DD 7E 06      [19]  719 	ld	a,6 (ix)
   39D2 90            [ 4]  720 	sub	a, b
   39D3 20 07         [12]  721 	jr	NZ,00125$
                            722 ;src/IA.c:215: *grad = SCALA;
   39D5 6B            [ 4]  723 	ld	l, e
   39D6 62            [ 4]  724 	ld	h, d
   39D7 36 00         [10]  725 	ld	(hl),#0x00
   39D9 23            [ 6]  726 	inc	hl
   39DA 36 01         [10]  727 	ld	(hl),#0x01
   39DC                     728 00125$:
                            729 ;src/IA.c:216: if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
   39DC 78            [ 4]  730 	ld	a,b
   39DD DD 96 06      [19]  731 	sub	a, 6 (ix)
   39E0 3E 00         [ 7]  732 	ld	a,#0x00
   39E2 17            [ 4]  733 	rla
   39E3 DD 77 FC      [19]  734 	ld	-4 (ix),a
   39E6 DD CB FC 46   [20]  735 	bit	0,-4 (ix)
   39EA 20 69         [12]  736 	jr	NZ,00131$
   39EC 0E 00         [ 7]  737 	ld	c,#0x00
   39EE DD 6E F3      [19]  738 	ld	l,-13 (ix)
   39F1 DD 66 F4      [19]  739 	ld	h,-12 (ix)
   39F4 7E            [ 7]  740 	ld	a, (hl)
   39F5 23            [ 6]  741 	inc	hl
   39F6 66            [ 7]  742 	ld	h,(hl)
   39F7 6F            [ 4]  743 	ld	l,a
   39F8 DD 70 F8      [19]  744 	ld	-8 (ix),b
   39FB DD 71 F9      [19]  745 	ld	-7 (ix),c
   39FE DD 7E F8      [19]  746 	ld	a,-8 (ix)
   3A01 95            [ 4]  747 	sub	a, l
   3A02 4F            [ 4]  748 	ld	c,a
   3A03 DD 7E F9      [19]  749 	ld	a,-7 (ix)
   3A06 9C            [ 4]  750 	sbc	a, h
   3A07 47            [ 4]  751 	ld	b,a
   3A08 79            [ 4]  752 	ld	a,c
   3A09 DD 96 F1      [19]  753 	sub	a, -15 (ix)
   3A0C 78            [ 4]  754 	ld	a,b
   3A0D DD 9E F2      [19]  755 	sbc	a, -14 (ix)
   3A10 30 43         [12]  756 	jr	NC,00131$
                            757 ;src/IA.c:218: *grad = SCALA/c->leftOffSet;
   3A12 D5            [11]  758 	push	de
   3A13 E5            [11]  759 	push	hl
   3A14 21 00 01      [10]  760 	ld	hl,#0x0100
   3A17 E5            [11]  761 	push	hl
   3A18 CD 7E 50      [17]  762 	call	__divuint
   3A1B F1            [10]  763 	pop	af
   3A1C F1            [10]  764 	pop	af
   3A1D 4D            [ 4]  765 	ld	c,l
   3A1E 44            [ 4]  766 	ld	b,h
   3A1F D1            [10]  767 	pop	de
   3A20 6B            [ 4]  768 	ld	l, e
   3A21 62            [ 4]  769 	ld	h, d
   3A22 71            [ 7]  770 	ld	(hl),c
   3A23 23            [ 6]  771 	inc	hl
   3A24 70            [ 7]  772 	ld	(hl),b
                            773 ;src/IA.c:219: *grad = *grad*(val-(midPoint - c->leftOffSet));
   3A25 DD 6E F3      [19]  774 	ld	l,-13 (ix)
   3A28 DD 66 F4      [19]  775 	ld	h,-12 (ix)
   3A2B 7E            [ 7]  776 	ld	a, (hl)
   3A2C 23            [ 6]  777 	inc	hl
   3A2D 66            [ 7]  778 	ld	h,(hl)
   3A2E 6F            [ 4]  779 	ld	l,a
   3A2F DD 7E F8      [19]  780 	ld	a,-8 (ix)
   3A32 95            [ 4]  781 	sub	a, l
   3A33 6F            [ 4]  782 	ld	l,a
   3A34 DD 7E F9      [19]  783 	ld	a,-7 (ix)
   3A37 9C            [ 4]  784 	sbc	a, h
   3A38 67            [ 4]  785 	ld	h,a
   3A39 DD 7E FA      [19]  786 	ld	a,-6 (ix)
   3A3C 95            [ 4]  787 	sub	a, l
   3A3D 6F            [ 4]  788 	ld	l,a
   3A3E DD 7E FB      [19]  789 	ld	a,-5 (ix)
   3A41 9C            [ 4]  790 	sbc	a, h
   3A42 67            [ 4]  791 	ld	h,a
   3A43 D5            [11]  792 	push	de
   3A44 E5            [11]  793 	push	hl
   3A45 C5            [11]  794 	push	bc
   3A46 CD 56 5B      [17]  795 	call	__mulint
   3A49 F1            [10]  796 	pop	af
   3A4A F1            [10]  797 	pop	af
   3A4B 4D            [ 4]  798 	ld	c,l
   3A4C 44            [ 4]  799 	ld	b,h
   3A4D D1            [10]  800 	pop	de
   3A4E 79            [ 4]  801 	ld	a,c
   3A4F 12            [ 7]  802 	ld	(de),a
   3A50 13            [ 6]  803 	inc	de
   3A51 78            [ 4]  804 	ld	a,b
   3A52 12            [ 7]  805 	ld	(de),a
   3A53 18 16         [12]  806 	jr	00140$
   3A55                     807 00131$:
                            808 ;src/IA.c:220: }else if(val > midPoint)
   3A55 DD CB FC 46   [20]  809 	bit	0,-4 (ix)
   3A59 28 09         [12]  810 	jr	Z,00128$
                            811 ;src/IA.c:223: *grad = SCALA;
   3A5B 3E 00         [ 7]  812 	ld	a,#0x00
   3A5D 12            [ 7]  813 	ld	(de),a
   3A5E 13            [ 6]  814 	inc	de
   3A5F 3E 01         [ 7]  815 	ld	a,#0x01
   3A61 12            [ 7]  816 	ld	(de),a
   3A62 18 07         [12]  817 	jr	00140$
   3A64                     818 00128$:
                            819 ;src/IA.c:225: *grad = 0;
   3A64 3E 00         [ 7]  820 	ld	a,#0x00
   3A66 12            [ 7]  821 	ld	(de),a
   3A67 13            [ 6]  822 	inc	de
   3A68 3E 00         [ 7]  823 	ld	a,#0x00
   3A6A 12            [ 7]  824 	ld	(de),a
   3A6B                     825 00140$:
   3A6B DD F9         [10]  826 	ld	sp, ix
   3A6D DD E1         [14]  827 	pop	ix
   3A6F C9            [10]  828 	ret
                            829 ;src/IA.c:232: void defuzzi(u16 val, b_direccion* direccion, i16* re)
                            830 ;	---------------------------------
                            831 ; Function defuzzi
                            832 ; ---------------------------------
   3A70                     833 _defuzzi::
   3A70 DD E5         [15]  834 	push	ix
   3A72 DD 21 00 00   [14]  835 	ld	ix,#0
   3A76 DD 39         [15]  836 	add	ix,sp
   3A78 21 EF FF      [10]  837 	ld	hl,#-17
   3A7B 39            [11]  838 	add	hl,sp
   3A7C F9            [ 6]  839 	ld	sp,hl
                            840 ;src/IA.c:239: *re = 0;
   3A7D DD 7E 08      [19]  841 	ld	a,8 (ix)
   3A80 DD 77 FE      [19]  842 	ld	-2 (ix),a
   3A83 DD 7E 09      [19]  843 	ld	a,9 (ix)
   3A86 DD 77 FF      [19]  844 	ld	-1 (ix),a
   3A89 DD 6E FE      [19]  845 	ld	l,-2 (ix)
   3A8C DD 66 FF      [19]  846 	ld	h,-1 (ix)
   3A8F AF            [ 4]  847 	xor	a, a
   3A90 77            [ 7]  848 	ld	(hl), a
   3A91 23            [ 6]  849 	inc	hl
   3A92 77            [ 7]  850 	ld	(hl), a
                            851 ;src/IA.c:241: while(i < 3)
   3A93 21 00 00      [10]  852 	ld	hl,#0x0000
   3A96 39            [11]  853 	add	hl,sp
   3A97 DD 75 FC      [19]  854 	ld	-4 (ix),l
   3A9A DD 74 FD      [19]  855 	ld	-3 (ix),h
   3A9D 0E 00         [ 7]  856 	ld	c,#0x00
   3A9F                     857 00101$:
   3A9F 79            [ 4]  858 	ld	a,c
   3AA0 D6 03         [ 7]  859 	sub	a, #0x03
   3AA2 30 53         [12]  860 	jr	NC,00103$
                            861 ;src/IA.c:243: dom = 0;
   3AA4 DD 36 F6 00   [19]  862 	ld	-10 (ix),#0x00
   3AA8 DD 36 F7 00   [19]  863 	ld	-9 (ix),#0x00
                            864 ;src/IA.c:244: calculateDom(fmems[i], val, &dom);
   3AAC 21 07 00      [10]  865 	ld	hl,#0x0007
   3AAF 39            [11]  866 	add	hl,sp
   3AB0 DD 75 FA      [19]  867 	ld	-6 (ix),l
   3AB3 DD 74 FB      [19]  868 	ld	-5 (ix),h
   3AB6 DD 46 04      [19]  869 	ld	b,4 (ix)
   3AB9 69            [ 4]  870 	ld	l,c
   3ABA 26 00         [ 7]  871 	ld	h,#0x00
   3ABC 29            [11]  872 	add	hl, hl
   3ABD EB            [ 4]  873 	ex	de,hl
   3ABE 21 72 5D      [10]  874 	ld	hl,#_fmems
   3AC1 19            [11]  875 	add	hl,de
   3AC2 7E            [ 7]  876 	ld	a,(hl)
   3AC3 DD 77 F8      [19]  877 	ld	-8 (ix),a
   3AC6 23            [ 6]  878 	inc	hl
   3AC7 7E            [ 7]  879 	ld	a,(hl)
   3AC8 DD 77 F9      [19]  880 	ld	-7 (ix),a
   3ACB C5            [11]  881 	push	bc
   3ACC D5            [11]  882 	push	de
   3ACD DD 6E FA      [19]  883 	ld	l,-6 (ix)
   3AD0 DD 66 FB      [19]  884 	ld	h,-5 (ix)
   3AD3 E5            [11]  885 	push	hl
   3AD4 C5            [11]  886 	push	bc
   3AD5 33            [ 6]  887 	inc	sp
   3AD6 DD 6E F8      [19]  888 	ld	l,-8 (ix)
   3AD9 DD 66 F9      [19]  889 	ld	h,-7 (ix)
   3ADC E5            [11]  890 	push	hl
   3ADD CD 56 37      [17]  891 	call	_calculateDom
   3AE0 F1            [10]  892 	pop	af
   3AE1 F1            [10]  893 	pop	af
   3AE2 33            [ 6]  894 	inc	sp
   3AE3 D1            [10]  895 	pop	de
   3AE4 C1            [10]  896 	pop	bc
                            897 ;src/IA.c:245: vDom[i] = dom/SCALA;
   3AE5 DD 6E FC      [19]  898 	ld	l,-4 (ix)
   3AE8 DD 66 FD      [19]  899 	ld	h,-3 (ix)
   3AEB 19            [11]  900 	add	hl,de
   3AEC DD 5E F7      [19]  901 	ld	e,-9 (ix)
   3AEF 16 00         [ 7]  902 	ld	d,#0x00
   3AF1 73            [ 7]  903 	ld	(hl),e
   3AF2 23            [ 6]  904 	inc	hl
   3AF3 72            [ 7]  905 	ld	(hl),d
                            906 ;src/IA.c:246: i++;
   3AF4 0C            [ 4]  907 	inc	c
   3AF5 18 A8         [12]  908 	jr	00101$
   3AF7                     909 00103$:
                            910 ;src/IA.c:250: for(i = 0; i<3; i++)
   3AF7 DD 36 F5 00   [19]  911 	ld	-11 (ix),#0x00
   3AFB                     912 00108$:
                            913 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   3AFB DD 6E F5      [19]  914 	ld	l,-11 (ix)
   3AFE 26 00         [ 7]  915 	ld	h,#0x00
   3B00 29            [11]  916 	add	hl, hl
   3B01 4D            [ 4]  917 	ld	c, l
   3B02 44            [ 4]  918 	ld	b, h
   3B03 DD 6E FC      [19]  919 	ld	l,-4 (ix)
   3B06 DD 66 FD      [19]  920 	ld	h,-3 (ix)
   3B09 09            [11]  921 	add	hl,bc
   3B0A 5E            [ 7]  922 	ld	e,(hl)
   3B0B 23            [ 6]  923 	inc	hl
   3B0C 56            [ 7]  924 	ld	d,(hl)
   3B0D 21 60 5D      [10]  925 	ld	hl,#_aceleracion
   3B10 09            [11]  926 	add	hl,bc
   3B11 4E            [ 7]  927 	ld	c,(hl)
   3B12 23            [ 6]  928 	inc	hl
   3B13 46            [ 7]  929 	ld	b,(hl)
   3B14 C5            [11]  930 	push	bc
   3B15 D5            [11]  931 	push	de
   3B16 CD 56 5B      [17]  932 	call	__mulint
   3B19 F1            [10]  933 	pop	af
   3B1A F1            [10]  934 	pop	af
   3B1B 4D            [ 4]  935 	ld	c,l
   3B1C 44            [ 4]  936 	ld	b,h
   3B1D DD 6E FE      [19]  937 	ld	l,-2 (ix)
   3B20 DD 66 FF      [19]  938 	ld	h,-1 (ix)
   3B23 5E            [ 7]  939 	ld	e,(hl)
   3B24 23            [ 6]  940 	inc	hl
   3B25 66            [ 7]  941 	ld	h,(hl)
   3B26 6B            [ 4]  942 	ld	l, e
   3B27 09            [11]  943 	add	hl,bc
   3B28 4D            [ 4]  944 	ld	c,l
   3B29 44            [ 4]  945 	ld	b,h
   3B2A DD 6E FE      [19]  946 	ld	l,-2 (ix)
   3B2D DD 66 FF      [19]  947 	ld	h,-1 (ix)
   3B30 71            [ 7]  948 	ld	(hl),c
   3B31 23            [ 6]  949 	inc	hl
   3B32 70            [ 7]  950 	ld	(hl),b
                            951 ;src/IA.c:250: for(i = 0; i<3; i++)
   3B33 DD 34 F5      [23]  952 	inc	-11 (ix)
   3B36 DD 7E F5      [19]  953 	ld	a,-11 (ix)
   3B39 D6 03         [ 7]  954 	sub	a, #0x03
   3B3B 38 BE         [12]  955 	jr	C,00108$
                            956 ;src/IA.c:255: if(direccion->b_izq)
   3B3D DD 6E 06      [19]  957 	ld	l,6 (ix)
   3B40 DD 66 07      [19]  958 	ld	h,7 (ix)
   3B43 23            [ 6]  959 	inc	hl
   3B44 7E            [ 7]  960 	ld	a,(hl)
                            961 ;src/IA.c:252: *re = ((vDom[i] * aceleracion[i]) + *re);
   3B45 DD 6E FE      [19]  962 	ld	l,-2 (ix)
   3B48 DD 66 FF      [19]  963 	ld	h,-1 (ix)
   3B4B 5E            [ 7]  964 	ld	e,(hl)
   3B4C 23            [ 6]  965 	inc	hl
   3B4D 56            [ 7]  966 	ld	d,(hl)
                            967 ;src/IA.c:255: if(direccion->b_izq)
   3B4E B7            [ 4]  968 	or	a, a
   3B4F 28 0B         [12]  969 	jr	Z,00106$
                            970 ;src/IA.c:256: *re = *re;
   3B51 DD 6E FE      [19]  971 	ld	l,-2 (ix)
   3B54 DD 66 FF      [19]  972 	ld	h,-1 (ix)
   3B57 73            [ 7]  973 	ld	(hl),e
   3B58 23            [ 6]  974 	inc	hl
   3B59 72            [ 7]  975 	ld	(hl),d
   3B5A 18 10         [12]  976 	jr	00110$
   3B5C                     977 00106$:
                            978 ;src/IA.c:259: *re = -*re;
   3B5C AF            [ 4]  979 	xor	a, a
   3B5D 93            [ 4]  980 	sub	a, e
   3B5E 5F            [ 4]  981 	ld	e,a
   3B5F 3E 00         [ 7]  982 	ld	a, #0x00
   3B61 9A            [ 4]  983 	sbc	a, d
   3B62 4F            [ 4]  984 	ld	c,a
   3B63 DD 6E FE      [19]  985 	ld	l,-2 (ix)
   3B66 DD 66 FF      [19]  986 	ld	h,-1 (ix)
   3B69 73            [ 7]  987 	ld	(hl),e
   3B6A 23            [ 6]  988 	inc	hl
   3B6B 71            [ 7]  989 	ld	(hl),c
   3B6C                     990 00110$:
   3B6C DD F9         [10]  991 	ld	sp, ix
   3B6E DD E1         [14]  992 	pop	ix
   3B70 C9            [10]  993 	ret
                            994 ;src/IA.c:264: void calcule(u8 tam, u8 dis, u16 *re)
                            995 ;	---------------------------------
                            996 ; Function calcule
                            997 ; ---------------------------------
   3B71                     998 _calcule::
   3B71 DD E5         [15]  999 	push	ix
   3B73 DD 21 00 00   [14] 1000 	ld	ix,#0
   3B77 DD 39         [15] 1001 	add	ix,sp
   3B79 F5            [11] 1002 	push	af
   3B7A 3B            [ 6] 1003 	dec	sp
                           1004 ;src/IA.c:268: resultadoDistoball = 0;
   3B7B DD 36 FE 00   [19] 1005 	ld	-2 (ix),#0x00
   3B7F DD 36 FF 00   [19] 1006 	ld	-1 (ix),#0x00
                           1007 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   3B83 DD 36 FD 00   [19] 1008 	ld	-3 (ix),#0x00
   3B87                    1009 00103$:
   3B87 DD 7E FD      [19] 1010 	ld	a,-3 (ix)
   3B8A DD 96 04      [19] 1011 	sub	a, 4 (ix)
   3B8D 30 65         [12] 1012 	jr	NC,00105$
                           1013 ;src/IA.c:270: calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
   3B8F FD 21 01 00   [14] 1014 	ld	iy,#0x0001
   3B93 FD 39         [15] 1015 	add	iy,sp
   3B95 DD 6E FD      [19] 1016 	ld	l,-3 (ix)
   3B98 26 00         [ 7] 1017 	ld	h,#0x00
   3B9A 29            [11] 1018 	add	hl, hl
   3B9B 01 66 5D      [10] 1019 	ld	bc,#_vRulesx
   3B9E 09            [11] 1020 	add	hl,bc
   3B9F 4D            [ 4] 1021 	ld	c,l
   3BA0 44            [ 4] 1022 	ld	b,h
   3BA1 7E            [ 7] 1023 	ld	a, (hl)
   3BA2 23            [ 6] 1024 	inc	hl
   3BA3 66            [ 7] 1025 	ld	h,(hl)
   3BA4 6F            [ 4] 1026 	ld	l,a
   3BA5 5E            [ 7] 1027 	ld	e,(hl)
   3BA6 23            [ 6] 1028 	inc	hl
   3BA7 56            [ 7] 1029 	ld	d,(hl)
   3BA8 C5            [11] 1030 	push	bc
   3BA9 FD E5         [15] 1031 	push	iy
   3BAB DD 7E 05      [19] 1032 	ld	a,5 (ix)
   3BAE F5            [11] 1033 	push	af
   3BAF 33            [ 6] 1034 	inc	sp
   3BB0 D5            [11] 1035 	push	de
   3BB1 CD 56 37      [17] 1036 	call	_calculateDom
   3BB4 F1            [10] 1037 	pop	af
   3BB5 F1            [10] 1038 	pop	af
   3BB6 33            [ 6] 1039 	inc	sp
   3BB7 C1            [10] 1040 	pop	bc
                           1041 ;src/IA.c:271: *re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
   3BB8 DD 5E 06      [19] 1042 	ld	e,6 (ix)
   3BBB DD 56 07      [19] 1043 	ld	d,7 (ix)
   3BBE 69            [ 4] 1044 	ld	l, c
   3BBF 60            [ 4] 1045 	ld	h, b
   3BC0 7E            [ 7] 1046 	ld	a, (hl)
   3BC1 23            [ 6] 1047 	inc	hl
   3BC2 66            [ 7] 1048 	ld	h,(hl)
   3BC3 6F            [ 4] 1049 	ld	l,a
   3BC4 23            [ 6] 1050 	inc	hl
   3BC5 23            [ 6] 1051 	inc	hl
   3BC6 7E            [ 7] 1052 	ld	a, (hl)
   3BC7 23            [ 6] 1053 	inc	hl
   3BC8 66            [ 7] 1054 	ld	h,(hl)
   3BC9 6F            [ 4] 1055 	ld	l,a
   3BCA 23            [ 6] 1056 	inc	hl
   3BCB 23            [ 6] 1057 	inc	hl
   3BCC 4E            [ 7] 1058 	ld	c,(hl)
   3BCD 23            [ 6] 1059 	inc	hl
   3BCE 46            [ 7] 1060 	ld	b,(hl)
   3BCF D5            [11] 1061 	push	de
   3BD0 DD 6E FE      [19] 1062 	ld	l,-2 (ix)
   3BD3 DD 66 FF      [19] 1063 	ld	h,-1 (ix)
   3BD6 E5            [11] 1064 	push	hl
   3BD7 C5            [11] 1065 	push	bc
   3BD8 CD 56 5B      [17] 1066 	call	__mulint
   3BDB F1            [10] 1067 	pop	af
   3BDC F1            [10] 1068 	pop	af
   3BDD 4D            [ 4] 1069 	ld	c,l
   3BDE 44            [ 4] 1070 	ld	b,h
   3BDF D1            [10] 1071 	pop	de
   3BE0 6B            [ 4] 1072 	ld	l, e
   3BE1 62            [ 4] 1073 	ld	h, d
   3BE2 7E            [ 7] 1074 	ld	a, (hl)
   3BE3 23            [ 6] 1075 	inc	hl
   3BE4 66            [ 7] 1076 	ld	h,(hl)
   3BE5 6F            [ 4] 1077 	ld	l,a
   3BE6 09            [11] 1078 	add	hl,bc
   3BE7 4C            [ 4] 1079 	ld	c,h
   3BE8 06 00         [ 7] 1080 	ld	b,#0x00
   3BEA 79            [ 4] 1081 	ld	a,c
   3BEB 12            [ 7] 1082 	ld	(de),a
   3BEC 13            [ 6] 1083 	inc	de
   3BED 78            [ 4] 1084 	ld	a,b
   3BEE 12            [ 7] 1085 	ld	(de),a
                           1086 ;src/IA.c:269: for(i = 0 ; i<tam; i++){
   3BEF DD 34 FD      [23] 1087 	inc	-3 (ix)
   3BF2 18 93         [12] 1088 	jr	00103$
   3BF4                    1089 00105$:
   3BF4 DD F9         [10] 1090 	ld	sp, ix
   3BF6 DD E1         [14] 1091 	pop	ix
   3BF8 C9            [10] 1092 	ret
                           1093 ;src/IA.c:275: void calcularb_direc(i16 totalxb, b_direccion* ball)
                           1094 ;	---------------------------------
                           1095 ; Function calcularb_direc
                           1096 ; ---------------------------------
   3BF9                    1097 _calcularb_direc::
                           1098 ;src/IA.c:277: ball->b_izq = 0;
   3BF9 21 04 00      [10] 1099 	ld	hl, #4
   3BFC 39            [11] 1100 	add	hl, sp
   3BFD 4E            [ 7] 1101 	ld	c, (hl)
   3BFE 23            [ 6] 1102 	inc	hl
   3BFF 46            [ 7] 1103 	ld	b, (hl)
   3C00 59            [ 4] 1104 	ld	e, c
   3C01 50            [ 4] 1105 	ld	d, b
   3C02 13            [ 6] 1106 	inc	de
   3C03 AF            [ 4] 1107 	xor	a, a
   3C04 12            [ 7] 1108 	ld	(de),a
                           1109 ;src/IA.c:278: ball->b_der = 0;
   3C05 AF            [ 4] 1110 	xor	a, a
   3C06 02            [ 7] 1111 	ld	(bc),a
                           1112 ;src/IA.c:280: if(totalxb < 0){
   3C07 21 03 00      [10] 1113 	ld	hl, #2+1
   3C0A 39            [11] 1114 	add	hl, sp
   3C0B CB 7E         [12] 1115 	bit	7,(hl)
   3C0D 28 06         [12] 1116 	jr	Z,00104$
                           1117 ;src/IA.c:281: ball->b_der = 1;
   3C0F 3E 01         [ 7] 1118 	ld	a,#0x01
   3C11 02            [ 7] 1119 	ld	(bc),a
                           1120 ;src/IA.c:282: ball->b_izq = 0;
   3C12 AF            [ 4] 1121 	xor	a, a
   3C13 12            [ 7] 1122 	ld	(de),a
   3C14 C9            [10] 1123 	ret
   3C15                    1124 00104$:
                           1125 ;src/IA.c:283: }else if(totalxb > 0)
   3C15 AF            [ 4] 1126 	xor	a, a
   3C16 FD 21 02 00   [14] 1127 	ld	iy,#2
   3C1A FD 39         [15] 1128 	add	iy,sp
   3C1C FD BE 00      [19] 1129 	cp	a, 0 (iy)
   3C1F FD 9E 01      [19] 1130 	sbc	a, 1 (iy)
   3C22 E2 27 3C      [10] 1131 	jp	PO, 00116$
   3C25 EE 80         [ 7] 1132 	xor	a, #0x80
   3C27                    1133 00116$:
   3C27 F0            [11] 1134 	ret	P
                           1135 ;src/IA.c:285: ball->b_izq = 1;
   3C28 3E 01         [ 7] 1136 	ld	a,#0x01
   3C2A 12            [ 7] 1137 	ld	(de),a
                           1138 ;src/IA.c:286: ball->b_der = 0;
   3C2B AF            [ 4] 1139 	xor	a, a
   3C2C 02            [ 7] 1140 	ld	(bc),a
   3C2D C9            [10] 1141 	ret
                           1142 ;src/IA.c:291: void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){
                           1143 ;	---------------------------------
                           1144 ; Function fuzzificacion
                           1145 ; ---------------------------------
   3C2E                    1146 _fuzzificacion::
   3C2E DD E5         [15] 1147 	push	ix
   3C30 DD 21 00 00   [14] 1148 	ld	ix,#0
   3C34 DD 39         [15] 1149 	add	ix,sp
   3C36 21 EE FF      [10] 1150 	ld	hl,#-18
   3C39 39            [11] 1151 	add	hl,sp
   3C3A F9            [ 6] 1152 	ld	sp,hl
                           1153 ;src/IA.c:299: ball = &ballX;
   3C3B 21 06 00      [10] 1154 	ld	hl,#0x0006
   3C3E 39            [11] 1155 	add	hl,sp
   3C3F DD 75 FA      [19] 1156 	ld	-6 (ix),l
   3C42 DD 74 FB      [19] 1157 	ld	-5 (ix),h
   3C45 4D            [ 4] 1158 	ld	c,l
   3C46 44            [ 4] 1159 	ld	b,h
                           1160 ;src/IA.c:300: x = ballx - pingu_enemyx;
   3C47 DD 5E 08      [19] 1161 	ld	e,8 (ix)
   3C4A 16 00         [ 7] 1162 	ld	d,#0x00
   3C4C DD 6E 0A      [19] 1163 	ld	l,10 (ix)
   3C4F 26 00         [ 7] 1164 	ld	h,#0x00
   3C51 7B            [ 4] 1165 	ld	a,e
   3C52 95            [ 4] 1166 	sub	a, l
   3C53 DD 77 FE      [19] 1167 	ld	-2 (ix),a
   3C56 7A            [ 4] 1168 	ld	a,d
   3C57 9C            [ 4] 1169 	sbc	a, h
   3C58 DD 77 FF      [19] 1170 	ld	-1 (ix),a
                           1171 ;src/IA.c:301: y = bally - pingu_enemyy;
   3C5B DD 6E 09      [19] 1172 	ld	l,9 (ix)
   3C5E 26 00         [ 7] 1173 	ld	h,#0x00
   3C60 DD 5E 0B      [19] 1174 	ld	e,11 (ix)
   3C63 16 00         [ 7] 1175 	ld	d,#0x00
   3C65 7D            [ 4] 1176 	ld	a,l
   3C66 93            [ 4] 1177 	sub	a, e
   3C67 DD 77 FC      [19] 1178 	ld	-4 (ix),a
   3C6A 7C            [ 4] 1179 	ld	a,h
   3C6B 9A            [ 4] 1180 	sbc	a, d
   3C6C DD 77 FD      [19] 1181 	ld	-3 (ix),a
                           1182 ;src/IA.c:303: y1 = LIMITPORTY - pingu_enemyy;
   3C6F 3E 6F         [ 7] 1183 	ld	a,#0x6F
   3C71 93            [ 4] 1184 	sub	a, e
   3C72 DD 77 F8      [19] 1185 	ld	-8 (ix),a
   3C75 3E 00         [ 7] 1186 	ld	a,#0x00
   3C77 9A            [ 4] 1187 	sbc	a, d
   3C78 DD 77 F9      [19] 1188 	ld	-7 (ix),a
                           1189 ;src/IA.c:307: ball->b_izq = 0;
   3C7B 59            [ 4] 1190 	ld	e, c
   3C7C 50            [ 4] 1191 	ld	d, b
   3C7D 13            [ 6] 1192 	inc	de
                           1193 ;src/IA.c:304: if(x <= -2){ //ATACAR 
   3C7E 3E FE         [ 7] 1194 	ld	a,#0xFE
   3C80 DD BE FE      [19] 1195 	cp	a, -2 (ix)
   3C83 3E FF         [ 7] 1196 	ld	a,#0xFF
   3C85 DD 9E FF      [19] 1197 	sbc	a, -1 (ix)
   3C88 E2 8D 3C      [10] 1198 	jp	PO, 00148$
   3C8B EE 80         [ 7] 1199 	xor	a, #0x80
   3C8D                    1200 00148$:
   3C8D FA 97 3C      [10] 1201 	jp	M,00102$
                           1202 ;src/IA.c:306: ball->b_der = 1;
   3C90 3E 01         [ 7] 1203 	ld	a,#0x01
   3C92 02            [ 7] 1204 	ld	(bc),a
                           1205 ;src/IA.c:307: ball->b_izq = 0;
   3C93 AF            [ 4] 1206 	xor	a, a
   3C94 12            [ 7] 1207 	ld	(de),a
   3C95 18 05         [12] 1208 	jr	00103$
   3C97                    1209 00102$:
                           1210 ;src/IA.c:312: ball->b_izq = 1;
   3C97 3E 01         [ 7] 1211 	ld	a,#0x01
   3C99 12            [ 7] 1212 	ld	(de),a
                           1213 ;src/IA.c:313: ball->b_der = 0;
   3C9A AF            [ 4] 1214 	xor	a, a
   3C9B 02            [ 7] 1215 	ld	(bc),a
   3C9C                    1216 00103$:
                           1217 ;src/IA.c:316: if(y1 < y && x > 0){
   3C9C AF            [ 4] 1218 	xor	a, a
   3C9D DD BE FE      [19] 1219 	cp	a, -2 (ix)
   3CA0 DD 9E FF      [19] 1220 	sbc	a, -1 (ix)
   3CA3 E2 A8 3C      [10] 1221 	jp	PO, 00149$
   3CA6 EE 80         [ 7] 1222 	xor	a, #0x80
   3CA8                    1223 00149$:
   3CA8 07            [ 4] 1224 	rlca
   3CA9 E6 01         [ 7] 1225 	and	a,#0x01
   3CAB 4F            [ 4] 1226 	ld	c,a
   3CAC DD 7E F8      [19] 1227 	ld	a,-8 (ix)
   3CAF DD 96 FC      [19] 1228 	sub	a, -4 (ix)
   3CB2 DD 7E F9      [19] 1229 	ld	a,-7 (ix)
   3CB5 DD 9E FD      [19] 1230 	sbc	a, -3 (ix)
   3CB8 E2 BD 3C      [10] 1231 	jp	PO, 00150$
   3CBB EE 80         [ 7] 1232 	xor	a, #0x80
   3CBD                    1233 00150$:
   3CBD F2 D7 3C      [10] 1234 	jp	P,00109$
   3CC0 79            [ 4] 1235 	ld	a,c
   3CC1 B7            [ 4] 1236 	or	a, a
   3CC2 28 13         [12] 1237 	jr	Z,00109$
                           1238 ;src/IA.c:317: calcularb_direc(y1, &ballY);
   3CC4 21 04 00      [10] 1239 	ld	hl,#0x0004
   3CC7 39            [11] 1240 	add	hl,sp
   3CC8 E5            [11] 1241 	push	hl
   3CC9 DD 6E F8      [19] 1242 	ld	l,-8 (ix)
   3CCC DD 66 F9      [19] 1243 	ld	h,-7 (ix)
   3CCF E5            [11] 1244 	push	hl
   3CD0 CD F9 3B      [17] 1245 	call	_calcularb_direc
   3CD3 F1            [10] 1246 	pop	af
   3CD4 F1            [10] 1247 	pop	af
   3CD5 18 3C         [12] 1248 	jr	00110$
   3CD7                    1249 00109$:
                           1250 ;src/IA.c:319: else if(y1> y && x>0){
   3CD7 DD 7E FC      [19] 1251 	ld	a,-4 (ix)
   3CDA DD 96 F8      [19] 1252 	sub	a, -8 (ix)
   3CDD DD 7E FD      [19] 1253 	ld	a,-3 (ix)
   3CE0 DD 9E F9      [19] 1254 	sbc	a, -7 (ix)
   3CE3 E2 E8 3C      [10] 1255 	jp	PO, 00151$
   3CE6 EE 80         [ 7] 1256 	xor	a, #0x80
   3CE8                    1257 00151$:
   3CE8 F2 02 3D      [10] 1258 	jp	P,00105$
   3CEB 79            [ 4] 1259 	ld	a,c
   3CEC B7            [ 4] 1260 	or	a, a
   3CED 28 13         [12] 1261 	jr	Z,00105$
                           1262 ;src/IA.c:320: calcularb_direc(y1, &ballY);
   3CEF 21 04 00      [10] 1263 	ld	hl,#0x0004
   3CF2 39            [11] 1264 	add	hl,sp
   3CF3 E5            [11] 1265 	push	hl
   3CF4 DD 6E F8      [19] 1266 	ld	l,-8 (ix)
   3CF7 DD 66 F9      [19] 1267 	ld	h,-7 (ix)
   3CFA E5            [11] 1268 	push	hl
   3CFB CD F9 3B      [17] 1269 	call	_calcularb_direc
   3CFE F1            [10] 1270 	pop	af
   3CFF F1            [10] 1271 	pop	af
   3D00 18 11         [12] 1272 	jr	00110$
   3D02                    1273 00105$:
                           1274 ;src/IA.c:323: calcularb_direc(y, &ballY);
   3D02 21 04 00      [10] 1275 	ld	hl,#0x0004
   3D05 39            [11] 1276 	add	hl,sp
   3D06 E5            [11] 1277 	push	hl
   3D07 DD 6E FC      [19] 1278 	ld	l,-4 (ix)
   3D0A DD 66 FD      [19] 1279 	ld	h,-3 (ix)
   3D0D E5            [11] 1280 	push	hl
   3D0E CD F9 3B      [17] 1281 	call	_calcularb_direc
   3D11 F1            [10] 1282 	pop	af
   3D12 F1            [10] 1283 	pop	af
   3D13                    1284 00110$:
                           1285 ;src/IA.c:327: x = (u8)x*SCALA;
   3D13 DD 4E FE      [19] 1286 	ld	c,-2 (ix)
   3D16 DD 71 F1      [19] 1287 	ld	-15 (ix),c
   3D19 DD 36 F0 00   [19] 1288 	ld	-16 (ix),#0x00
                           1289 ;src/IA.c:328: y = (u8)y*SCALA;
   3D1D DD 46 FC      [19] 1290 	ld	b,-4 (ix)
   3D20 0E 00         [ 7] 1291 	ld	c,#0x00
                           1292 ;src/IA.c:329: calcule(3,x,&accerationX);
   3D22 21 08 00      [10] 1293 	ld	hl,#0x0008
   3D25 39            [11] 1294 	add	hl,sp
   3D26 DD 56 F0      [19] 1295 	ld	d,-16 (ix)
   3D29 C5            [11] 1296 	push	bc
   3D2A E5            [11] 1297 	push	hl
   3D2B 1E 03         [ 7] 1298 	ld	e, #0x03
   3D2D D5            [11] 1299 	push	de
   3D2E CD 71 3B      [17] 1300 	call	_calcule
   3D31 F1            [10] 1301 	pop	af
   3D32 F1            [10] 1302 	pop	af
   3D33 C1            [10] 1303 	pop	bc
                           1304 ;src/IA.c:330: calcule(3,y,&accerationY);
   3D34 21 00 00      [10] 1305 	ld	hl,#0x0000
   3D37 39            [11] 1306 	add	hl,sp
   3D38 51            [ 4] 1307 	ld	d,c
   3D39 C5            [11] 1308 	push	bc
   3D3A E5            [11] 1309 	push	hl
   3D3B 1E 03         [ 7] 1310 	ld	e, #0x03
   3D3D D5            [11] 1311 	push	de
   3D3E CD 71 3B      [17] 1312 	call	_calcule
   3D41 F1            [10] 1313 	pop	af
   3D42 F1            [10] 1314 	pop	af
   3D43 C1            [10] 1315 	pop	bc
                           1316 ;src/IA.c:333: if(y!=0)
   3D44 78            [ 4] 1317 	ld	a,b
   3D45 B1            [ 4] 1318 	or	a,c
   3D46 28 1D         [12] 1319 	jr	Z,00114$
                           1320 ;src/IA.c:334: defuzzi(accerationX,&ballX, ax);
   3D48 DD 4E FA      [19] 1321 	ld	c,-6 (ix)
   3D4B DD 46 FB      [19] 1322 	ld	b,-5 (ix)
   3D4E DD 6E 04      [19] 1323 	ld	l,4 (ix)
   3D51 DD 66 05      [19] 1324 	ld	h,5 (ix)
   3D54 E5            [11] 1325 	push	hl
   3D55 C5            [11] 1326 	push	bc
   3D56 DD 6E F6      [19] 1327 	ld	l,-10 (ix)
   3D59 DD 66 F7      [19] 1328 	ld	h,-9 (ix)
   3D5C E5            [11] 1329 	push	hl
   3D5D CD 70 3A      [17] 1330 	call	_defuzzi
   3D60 21 06 00      [10] 1331 	ld	hl,#6
   3D63 39            [11] 1332 	add	hl,sp
   3D64 F9            [ 6] 1333 	ld	sp,hl
                           1334 ;src/IA.c:336: ax = 0;
   3D65                    1335 00114$:
                           1336 ;src/IA.c:338: if(x!=0)
   3D65 DD 7E F1      [19] 1337 	ld	a,-15 (ix)
   3D68 DD B6 F0      [19] 1338 	or	a,-16 (ix)
   3D6B 28 1B         [12] 1339 	jr	Z,00118$
                           1340 ;src/IA.c:339: defuzzi(accerationY,&ballY, ay);
   3D6D 21 04 00      [10] 1341 	ld	hl,#0x0004
   3D70 39            [11] 1342 	add	hl,sp
   3D71 DD 4E 06      [19] 1343 	ld	c,6 (ix)
   3D74 DD 46 07      [19] 1344 	ld	b,7 (ix)
   3D77 C5            [11] 1345 	push	bc
   3D78 E5            [11] 1346 	push	hl
   3D79 DD 6E EE      [19] 1347 	ld	l,-18 (ix)
   3D7C DD 66 EF      [19] 1348 	ld	h,-17 (ix)
   3D7F E5            [11] 1349 	push	hl
   3D80 CD 70 3A      [17] 1350 	call	_defuzzi
   3D83 21 06 00      [10] 1351 	ld	hl,#6
   3D86 39            [11] 1352 	add	hl,sp
   3D87 F9            [ 6] 1353 	ld	sp,hl
                           1354 ;src/IA.c:341: ay = 0;
   3D88                    1355 00118$:
   3D88 DD F9         [10] 1356 	ld	sp, ix
   3D8A DD E1         [14] 1357 	pop	ix
   3D8C C9            [10] 1358 	ret
                           1359 ;src/IA.c:356: void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
                           1360 ;	---------------------------------
                           1361 ; Function moveIA
                           1362 ; ---------------------------------
   3D8D                    1363 _moveIA::
   3D8D DD E5         [15] 1364 	push	ix
   3D8F DD 21 00 00   [14] 1365 	ld	ix,#0
   3D93 DD 39         [15] 1366 	add	ix,sp
   3D95 F5            [11] 1367 	push	af
                           1368 ;src/IA.c:368: if(myself->y > frisbee->y) {
   3D96 DD 7E 04      [19] 1369 	ld	a,4 (ix)
   3D99 DD 77 FE      [19] 1370 	ld	-2 (ix),a
   3D9C DD 7E 05      [19] 1371 	ld	a,5 (ix)
   3D9F DD 77 FF      [19] 1372 	ld	-1 (ix),a
   3DA2 E1            [10] 1373 	pop	hl
   3DA3 E5            [11] 1374 	push	hl
   3DA4 23            [ 6] 1375 	inc	hl
   3DA5 23            [ 6] 1376 	inc	hl
   3DA6 4E            [ 7] 1377 	ld	c,(hl)
   3DA7 23            [ 6] 1378 	inc	hl
   3DA8 46            [ 7] 1379 	ld	b,(hl)
   3DA9 DD 6E 08      [19] 1380 	ld	l,8 (ix)
   3DAC DD 66 09      [19] 1381 	ld	h,9 (ix)
   3DAF 23            [ 6] 1382 	inc	hl
   3DB0 23            [ 6] 1383 	inc	hl
   3DB1 5E            [ 7] 1384 	ld	e,(hl)
   3DB2 23            [ 6] 1385 	inc	hl
   3DB3 56            [ 7] 1386 	ld	d,(hl)
                           1387 ;src/IA.c:369: myself->ay = -SCALA/8;
   3DB4 DD 7E FE      [19] 1388 	ld	a,-2 (ix)
   3DB7 C6 0C         [ 7] 1389 	add	a, #0x0C
   3DB9 6F            [ 4] 1390 	ld	l,a
   3DBA DD 7E FF      [19] 1391 	ld	a,-1 (ix)
   3DBD CE 00         [ 7] 1392 	adc	a, #0x00
   3DBF 67            [ 4] 1393 	ld	h,a
                           1394 ;src/IA.c:368: if(myself->y > frisbee->y) {
   3DC0 7B            [ 4] 1395 	ld	a,e
   3DC1 91            [ 4] 1396 	sub	a, c
   3DC2 7A            [ 4] 1397 	ld	a,d
   3DC3 98            [ 4] 1398 	sbc	a, b
   3DC4 30 07         [12] 1399 	jr	NC,00104$
                           1400 ;src/IA.c:369: myself->ay = -SCALA/8;
   3DC6 36 E0         [10] 1401 	ld	(hl),#0xE0
   3DC8 23            [ 6] 1402 	inc	hl
   3DC9 36 FF         [10] 1403 	ld	(hl),#0xFF
   3DCB 18 0B         [12] 1404 	jr	00106$
   3DCD                    1405 00104$:
                           1406 ;src/IA.c:370: } else if (myself->y < frisbee->y) {
   3DCD 79            [ 4] 1407 	ld	a,c
   3DCE 93            [ 4] 1408 	sub	a, e
   3DCF 78            [ 4] 1409 	ld	a,b
   3DD0 9A            [ 4] 1410 	sbc	a, d
   3DD1 30 05         [12] 1411 	jr	NC,00106$
                           1412 ;src/IA.c:371: myself->ay = SCALA/8;
   3DD3 36 20         [10] 1413 	ld	(hl),#0x20
   3DD5 23            [ 6] 1414 	inc	hl
   3DD6 36 00         [10] 1415 	ld	(hl),#0x00
   3DD8                    1416 00106$:
   3DD8 DD F9         [10] 1417 	ld	sp, ix
   3DDA DD E1         [14] 1418 	pop	ix
   3DDC C9            [10] 1419 	ret
                           1420 	.area _CODE
                           1421 	.area _INITIALIZER
   5D78                    1422 __xinit__vRulesx:
   5D78 3E 37              1423 	.dw _rulex
   5D7A 42 37              1424 	.dw _rulex1
   5D7C 46 37              1425 	.dw _rulex2
   5D7E                    1426 __xinit__vRulesy:
   5D7E 4A 37              1427 	.dw _ruley
   5D80 4E 37              1428 	.dw _ruley1
   5D82 52 37              1429 	.dw _ruley2
   5D84                    1430 __xinit__fmems:
   5D84 28 37              1431 	.dw _acelPo
   5D86 33 37              1432 	.dw _acelMed
   5D88 1D 37              1433 	.dw _acelMu
                           1434 	.area _CABS (ABS)
