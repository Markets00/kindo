                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _dibujaCosa
                             13 	.globl _cpct_etm_setTileset2x4
                             14 	.globl _cpct_etm_drawTileBox2x4
                             15 	.globl _cpct_getScreenPtr
                             16 	.globl _cpct_setPALColour
                             17 	.globl _cpct_setPalette
                             18 	.globl _cpct_waitVSYNC
                             19 	.globl _cpct_setVideoMode
                             20 	.globl _cpct_drawSprite
                             21 	.globl _cpct_disableFirmware
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/main.c:31: void dibujaCosa(const u8 * sprite) {
                             54 ;	---------------------------------
                             55 ; Function dibujaCosa
                             56 ; ---------------------------------
   4F7C                      57 _dibujaCosa::
                             58 ;src/main.c:32: u8* pvmem = cpct_getScreenPtr(CPCT_VMEM_START, 0, 0); 
   4F7C 21 00 00      [10]   59 	ld	hl, #0x0000
   4F7F E5            [11]   60 	push	hl
   4F80 26 C0         [ 7]   61 	ld	h, #0xc0
   4F82 E5            [11]   62 	push	hl
   4F83 CD 0C 53      [17]   63 	call	_cpct_getScreenPtr
                             64 ;src/main.c:33: cpct_drawSprite (sprite, CPCT_VMEM_START, G_ROBOZ2_0_W, G_ROBOZ2_0_H );
   4F86 D1            [10]   65 	pop	de
   4F87 C1            [10]   66 	pop	bc
   4F88 C5            [11]   67 	push	bc
   4F89 D5            [11]   68 	push	de
   4F8A 21 05 14      [10]   69 	ld	hl, #0x1405
   4F8D E5            [11]   70 	push	hl
   4F8E 21 00 C0      [10]   71 	ld	hl, #0xc000
   4F91 E5            [11]   72 	push	hl
   4F92 C5            [11]   73 	push	bc
   4F93 CD 6B 51      [17]   74 	call	_cpct_drawSprite
   4F96 C9            [10]   75 	ret
                             76 ;src/main.c:36: void main(void) {
                             77 ;	---------------------------------
                             78 ; Function main
                             79 ; ---------------------------------
   4F97                      80 _main::
                             81 ;src/main.c:38: cpct_disableFirmware();
   4F97 CD DA 52      [17]   82 	call	_cpct_disableFirmware
                             83 ;src/main.c:39: cpct_setVideoMode(0);
   4F9A 2E 00         [ 7]   84 	ld	l, #0x00
   4F9C CD CC 52      [17]   85 	call	_cpct_setVideoMode
                             86 ;src/main.c:40: cpct_setBorder(HW_BLACK);
   4F9F 21 10 14      [10]   87 	ld	hl, #0x1410
   4FA2 E5            [11]   88 	push	hl
   4FA3 CD 5F 51      [17]   89 	call	_cpct_setPALColour
                             90 ;src/main.c:41: cpct_setPalette(g_palette, 16);
   4FA6 21 10 00      [10]   91 	ld	hl, #0x0010
   4FA9 E5            [11]   92 	push	hl
   4FAA 21 D8 4E      [10]   93 	ld	hl, #_g_palette
   4FAD E5            [11]   94 	push	hl
   4FAE CD 48 51      [17]   95 	call	_cpct_setPalette
                             96 ;src/main.c:43: cpct_etm_setTileset2x4(g_tileset);
   4FB1 21 E8 4E      [10]   97 	ld	hl, #_g_tileset
   4FB4 CD 9F 52      [17]   98 	call	_cpct_etm_setTileset2x4
                             99 ;src/main.c:46: cpct_etm_drawTileBox2x4(0, 0, g_shit_W, g_shit_H, g_shit_H, ORIGIN_MAP, g_shit);
   4FB7 21 00 40      [10]  100 	ld	hl, #_g_shit
   4FBA E5            [11]  101 	push	hl
   4FBB 21 00 C0      [10]  102 	ld	hl, #0xc000
   4FBE E5            [11]  103 	push	hl
   4FBF 21 2D 2D      [10]  104 	ld	hl, #0x2d2d
   4FC2 E5            [11]  105 	push	hl
   4FC3 21 00 50      [10]  106 	ld	hl, #0x5000
   4FC6 E5            [11]  107 	push	hl
   4FC7 AF            [ 4]  108 	xor	a, a
   4FC8 F5            [11]  109 	push	af
   4FC9 33            [ 6]  110 	inc	sp
   4FCA CD 10 52      [17]  111 	call	_cpct_etm_drawTileBox2x4
                            112 ;src/main.c:49: while (1) {
   4FCD                     113 00102$:
                            114 ;src/main.c:50: dibujaCosa(g_roboz2_0);
   4FCD 21 10 4E      [10]  115 	ld	hl, #_g_roboz2_0
   4FD0 E5            [11]  116 	push	hl
   4FD1 CD 7C 4F      [17]  117 	call	_dibujaCosa
   4FD4 F1            [10]  118 	pop	af
                            119 ;src/main.c:51: cpct_waitVSYNC();
   4FD5 CD C4 52      [17]  120 	call	_cpct_waitVSYNC
                            121 ;src/main.c:52: cpct_waitVSYNC();
   4FD8 CD C4 52      [17]  122 	call	_cpct_waitVSYNC
                            123 ;src/main.c:53: cpct_waitVSYNC();
   4FDB CD C4 52      [17]  124 	call	_cpct_waitVSYNC
                            125 ;src/main.c:54: cpct_waitVSYNC();
   4FDE CD C4 52      [17]  126 	call	_cpct_waitVSYNC
                            127 ;src/main.c:55: cpct_waitVSYNC();
   4FE1 CD C4 52      [17]  128 	call	_cpct_waitVSYNC
                            129 ;src/main.c:56: cpct_waitVSYNC();
   4FE4 CD C4 52      [17]  130 	call	_cpct_waitVSYNC
                            131 ;src/main.c:57: cpct_waitVSYNC();
   4FE7 CD C4 52      [17]  132 	call	_cpct_waitVSYNC
                            133 ;src/main.c:58: cpct_waitVSYNC();
   4FEA CD C4 52      [17]  134 	call	_cpct_waitVSYNC
                            135 ;src/main.c:59: cpct_waitVSYNC();
   4FED CD C4 52      [17]  136 	call	_cpct_waitVSYNC
                            137 ;src/main.c:60: cpct_waitVSYNC();
   4FF0 CD C4 52      [17]  138 	call	_cpct_waitVSYNC
                            139 ;src/main.c:61: cpct_waitVSYNC();
   4FF3 CD C4 52      [17]  140 	call	_cpct_waitVSYNC
                            141 ;src/main.c:62: cpct_waitVSYNC();cpct_waitVSYNC();
   4FF6 CD C4 52      [17]  142 	call	_cpct_waitVSYNC
   4FF9 CD C4 52      [17]  143 	call	_cpct_waitVSYNC
                            144 ;src/main.c:63: cpct_waitVSYNC();
   4FFC CD C4 52      [17]  145 	call	_cpct_waitVSYNC
                            146 ;src/main.c:64: cpct_waitVSYNC();
   4FFF CD C4 52      [17]  147 	call	_cpct_waitVSYNC
                            148 ;src/main.c:65: cpct_waitVSYNC();
   5002 CD C4 52      [17]  149 	call	_cpct_waitVSYNC
                            150 ;src/main.c:66: cpct_waitVSYNC();
   5005 CD C4 52      [17]  151 	call	_cpct_waitVSYNC
                            152 ;src/main.c:67: cpct_waitVSYNC();
   5008 CD C4 52      [17]  153 	call	_cpct_waitVSYNC
                            154 ;src/main.c:68: cpct_waitVSYNC();
   500B CD C4 52      [17]  155 	call	_cpct_waitVSYNC
                            156 ;src/main.c:69: cpct_waitVSYNC();
   500E CD C4 52      [17]  157 	call	_cpct_waitVSYNC
                            158 ;src/main.c:70: cpct_waitVSYNC();
   5011 CD C4 52      [17]  159 	call	_cpct_waitVSYNC
                            160 ;src/main.c:71: cpct_waitVSYNC();
   5014 CD C4 52      [17]  161 	call	_cpct_waitVSYNC
                            162 ;src/main.c:72: cpct_waitVSYNC();
   5017 CD C4 52      [17]  163 	call	_cpct_waitVSYNC
                            164 ;src/main.c:73: cpct_waitVSYNC();cpct_waitVSYNC();
   501A CD C4 52      [17]  165 	call	_cpct_waitVSYNC
   501D CD C4 52      [17]  166 	call	_cpct_waitVSYNC
                            167 ;src/main.c:74: cpct_waitVSYNC();
   5020 CD C4 52      [17]  168 	call	_cpct_waitVSYNC
                            169 ;src/main.c:75: cpct_waitVSYNC();
   5023 CD C4 52      [17]  170 	call	_cpct_waitVSYNC
                            171 ;src/main.c:76: cpct_waitVSYNC();
   5026 CD C4 52      [17]  172 	call	_cpct_waitVSYNC
                            173 ;src/main.c:77: cpct_waitVSYNC();
   5029 CD C4 52      [17]  174 	call	_cpct_waitVSYNC
                            175 ;src/main.c:78: cpct_waitVSYNC();
   502C CD C4 52      [17]  176 	call	_cpct_waitVSYNC
                            177 ;src/main.c:79: cpct_waitVSYNC();
   502F CD C4 52      [17]  178 	call	_cpct_waitVSYNC
                            179 ;src/main.c:80: cpct_waitVSYNC();
   5032 CD C4 52      [17]  180 	call	_cpct_waitVSYNC
                            181 ;src/main.c:81: cpct_waitVSYNC();
   5035 CD C4 52      [17]  182 	call	_cpct_waitVSYNC
                            183 ;src/main.c:82: cpct_waitVSYNC();
   5038 CD C4 52      [17]  184 	call	_cpct_waitVSYNC
                            185 ;src/main.c:83: cpct_waitVSYNC();
   503B CD C4 52      [17]  186 	call	_cpct_waitVSYNC
                            187 ;src/main.c:84: cpct_waitVSYNC();cpct_waitVSYNC();
   503E CD C4 52      [17]  188 	call	_cpct_waitVSYNC
   5041 CD C4 52      [17]  189 	call	_cpct_waitVSYNC
                            190 ;src/main.c:85: cpct_waitVSYNC();
   5044 CD C4 52      [17]  191 	call	_cpct_waitVSYNC
                            192 ;src/main.c:86: cpct_waitVSYNC();
   5047 CD C4 52      [17]  193 	call	_cpct_waitVSYNC
                            194 ;src/main.c:87: cpct_waitVSYNC();
   504A CD C4 52      [17]  195 	call	_cpct_waitVSYNC
                            196 ;src/main.c:88: cpct_waitVSYNC();
   504D CD C4 52      [17]  197 	call	_cpct_waitVSYNC
                            198 ;src/main.c:89: cpct_waitVSYNC();
   5050 CD C4 52      [17]  199 	call	_cpct_waitVSYNC
                            200 ;src/main.c:90: cpct_waitVSYNC();
   5053 CD C4 52      [17]  201 	call	_cpct_waitVSYNC
                            202 ;src/main.c:91: cpct_waitVSYNC();
   5056 CD C4 52      [17]  203 	call	_cpct_waitVSYNC
                            204 ;src/main.c:92: cpct_waitVSYNC();
   5059 CD C4 52      [17]  205 	call	_cpct_waitVSYNC
                            206 ;src/main.c:93: cpct_waitVSYNC();
   505C CD C4 52      [17]  207 	call	_cpct_waitVSYNC
                            208 ;src/main.c:94: cpct_waitVSYNC();
   505F CD C4 52      [17]  209 	call	_cpct_waitVSYNC
                            210 ;src/main.c:95: cpct_waitVSYNC();cpct_waitVSYNC();
   5062 CD C4 52      [17]  211 	call	_cpct_waitVSYNC
   5065 CD C4 52      [17]  212 	call	_cpct_waitVSYNC
                            213 ;src/main.c:96: cpct_waitVSYNC();
   5068 CD C4 52      [17]  214 	call	_cpct_waitVSYNC
                            215 ;src/main.c:97: cpct_waitVSYNC();
   506B CD C4 52      [17]  216 	call	_cpct_waitVSYNC
                            217 ;src/main.c:98: cpct_waitVSYNC();
   506E CD C4 52      [17]  218 	call	_cpct_waitVSYNC
                            219 ;src/main.c:99: cpct_waitVSYNC();
   5071 CD C4 52      [17]  220 	call	_cpct_waitVSYNC
                            221 ;src/main.c:100: cpct_waitVSYNC();
   5074 CD C4 52      [17]  222 	call	_cpct_waitVSYNC
                            223 ;src/main.c:101: cpct_waitVSYNC();
   5077 CD C4 52      [17]  224 	call	_cpct_waitVSYNC
                            225 ;src/main.c:102: cpct_waitVSYNC();
   507A CD C4 52      [17]  226 	call	_cpct_waitVSYNC
                            227 ;src/main.c:103: cpct_waitVSYNC();
   507D CD C4 52      [17]  228 	call	_cpct_waitVSYNC
                            229 ;src/main.c:104: cpct_waitVSYNC();
   5080 CD C4 52      [17]  230 	call	_cpct_waitVSYNC
                            231 ;src/main.c:105: cpct_waitVSYNC();
   5083 CD C4 52      [17]  232 	call	_cpct_waitVSYNC
                            233 ;src/main.c:106: cpct_waitVSYNC();cpct_waitVSYNC();
   5086 CD C4 52      [17]  234 	call	_cpct_waitVSYNC
   5089 CD C4 52      [17]  235 	call	_cpct_waitVSYNC
                            236 ;src/main.c:107: cpct_waitVSYNC();
   508C CD C4 52      [17]  237 	call	_cpct_waitVSYNC
                            238 ;src/main.c:108: cpct_waitVSYNC();
   508F CD C4 52      [17]  239 	call	_cpct_waitVSYNC
                            240 ;src/main.c:109: cpct_waitVSYNC();
   5092 CD C4 52      [17]  241 	call	_cpct_waitVSYNC
                            242 ;src/main.c:110: cpct_waitVSYNC();
   5095 CD C4 52      [17]  243 	call	_cpct_waitVSYNC
                            244 ;src/main.c:111: cpct_waitVSYNC();
   5098 CD C4 52      [17]  245 	call	_cpct_waitVSYNC
                            246 ;src/main.c:112: cpct_waitVSYNC();
   509B CD C4 52      [17]  247 	call	_cpct_waitVSYNC
                            248 ;src/main.c:113: cpct_waitVSYNC();
   509E CD C4 52      [17]  249 	call	_cpct_waitVSYNC
                            250 ;src/main.c:114: cpct_waitVSYNC();
   50A1 CD C4 52      [17]  251 	call	_cpct_waitVSYNC
                            252 ;src/main.c:115: cpct_waitVSYNC();
   50A4 CD C4 52      [17]  253 	call	_cpct_waitVSYNC
                            254 ;src/main.c:116: cpct_waitVSYNC();
   50A7 CD C4 52      [17]  255 	call	_cpct_waitVSYNC
                            256 ;src/main.c:117: cpct_waitVSYNC();cpct_waitVSYNC();
   50AA CD C4 52      [17]  257 	call	_cpct_waitVSYNC
   50AD CD C4 52      [17]  258 	call	_cpct_waitVSYNC
                            259 ;src/main.c:118: cpct_waitVSYNC();
   50B0 CD C4 52      [17]  260 	call	_cpct_waitVSYNC
                            261 ;src/main.c:119: cpct_waitVSYNC();
   50B3 CD C4 52      [17]  262 	call	_cpct_waitVSYNC
                            263 ;src/main.c:120: cpct_waitVSYNC();
   50B6 CD C4 52      [17]  264 	call	_cpct_waitVSYNC
                            265 ;src/main.c:121: cpct_waitVSYNC();
   50B9 CD C4 52      [17]  266 	call	_cpct_waitVSYNC
                            267 ;src/main.c:122: cpct_waitVSYNC();
   50BC CD C4 52      [17]  268 	call	_cpct_waitVSYNC
                            269 ;src/main.c:123: cpct_waitVSYNC();
   50BF CD C4 52      [17]  270 	call	_cpct_waitVSYNC
                            271 ;src/main.c:124: cpct_waitVSYNC();
   50C2 CD C4 52      [17]  272 	call	_cpct_waitVSYNC
                            273 ;src/main.c:125: cpct_waitVSYNC();
   50C5 CD C4 52      [17]  274 	call	_cpct_waitVSYNC
                            275 ;src/main.c:126: cpct_waitVSYNC();
   50C8 CD C4 52      [17]  276 	call	_cpct_waitVSYNC
                            277 ;src/main.c:127: cpct_waitVSYNC();
   50CB CD C4 52      [17]  278 	call	_cpct_waitVSYNC
                            279 ;src/main.c:128: cpct_waitVSYNC();cpct_waitVSYNC();
   50CE CD C4 52      [17]  280 	call	_cpct_waitVSYNC
   50D1 CD C4 52      [17]  281 	call	_cpct_waitVSYNC
                            282 ;src/main.c:129: cpct_waitVSYNC();
   50D4 CD C4 52      [17]  283 	call	_cpct_waitVSYNC
                            284 ;src/main.c:130: cpct_waitVSYNC();
   50D7 CD C4 52      [17]  285 	call	_cpct_waitVSYNC
                            286 ;src/main.c:131: cpct_waitVSYNC();
   50DA CD C4 52      [17]  287 	call	_cpct_waitVSYNC
                            288 ;src/main.c:132: cpct_waitVSYNC();
   50DD CD C4 52      [17]  289 	call	_cpct_waitVSYNC
                            290 ;src/main.c:133: cpct_waitVSYNC();
   50E0 CD C4 52      [17]  291 	call	_cpct_waitVSYNC
                            292 ;src/main.c:134: cpct_waitVSYNC();
   50E3 CD C4 52      [17]  293 	call	_cpct_waitVSYNC
                            294 ;src/main.c:135: cpct_waitVSYNC();
   50E6 CD C4 52      [17]  295 	call	_cpct_waitVSYNC
                            296 ;src/main.c:136: cpct_waitVSYNC();
   50E9 CD C4 52      [17]  297 	call	_cpct_waitVSYNC
                            298 ;src/main.c:137: cpct_waitVSYNC();
   50EC CD C4 52      [17]  299 	call	_cpct_waitVSYNC
                            300 ;src/main.c:138: cpct_waitVSYNC();
   50EF CD C4 52      [17]  301 	call	_cpct_waitVSYNC
                            302 ;src/main.c:139: cpct_waitVSYNC();cpct_waitVSYNC();
   50F2 CD C4 52      [17]  303 	call	_cpct_waitVSYNC
   50F5 CD C4 52      [17]  304 	call	_cpct_waitVSYNC
                            305 ;src/main.c:140: cpct_waitVSYNC();
   50F8 CD C4 52      [17]  306 	call	_cpct_waitVSYNC
                            307 ;src/main.c:141: cpct_waitVSYNC();
   50FB CD C4 52      [17]  308 	call	_cpct_waitVSYNC
                            309 ;src/main.c:142: cpct_waitVSYNC();
   50FE CD C4 52      [17]  310 	call	_cpct_waitVSYNC
                            311 ;src/main.c:143: cpct_waitVSYNC();
   5101 CD C4 52      [17]  312 	call	_cpct_waitVSYNC
                            313 ;src/main.c:144: cpct_waitVSYNC();
   5104 CD C4 52      [17]  314 	call	_cpct_waitVSYNC
                            315 ;src/main.c:145: cpct_waitVSYNC();
   5107 CD C4 52      [17]  316 	call	_cpct_waitVSYNC
                            317 ;src/main.c:146: cpct_waitVSYNC();
   510A CD C4 52      [17]  318 	call	_cpct_waitVSYNC
                            319 ;src/main.c:147: cpct_waitVSYNC();
   510D CD C4 52      [17]  320 	call	_cpct_waitVSYNC
                            321 ;src/main.c:148: cpct_waitVSYNC();
   5110 CD C4 52      [17]  322 	call	_cpct_waitVSYNC
                            323 ;src/main.c:149: cpct_waitVSYNC();
   5113 CD C4 52      [17]  324 	call	_cpct_waitVSYNC
                            325 ;src/main.c:150: cpct_waitVSYNC();
   5116 CD C4 52      [17]  326 	call	_cpct_waitVSYNC
                            327 ;src/main.c:151: dibujaCosa(g_roboz2_1);
   5119 21 74 4E      [10]  328 	ld	hl, #_g_roboz2_1
   511C E5            [11]  329 	push	hl
   511D CD 7C 4F      [17]  330 	call	_dibujaCosa
   5120 F1            [10]  331 	pop	af
                            332 ;src/main.c:152: cpct_waitVSYNC();
   5121 CD C4 52      [17]  333 	call	_cpct_waitVSYNC
                            334 ;src/main.c:153: cpct_waitVSYNC();
   5124 CD C4 52      [17]  335 	call	_cpct_waitVSYNC
                            336 ;src/main.c:154: cpct_waitVSYNC();
   5127 CD C4 52      [17]  337 	call	_cpct_waitVSYNC
                            338 ;src/main.c:155: cpct_waitVSYNC();
   512A CD C4 52      [17]  339 	call	_cpct_waitVSYNC
                            340 ;src/main.c:156: cpct_waitVSYNC();
   512D CD C4 52      [17]  341 	call	_cpct_waitVSYNC
                            342 ;src/main.c:157: cpct_waitVSYNC();
   5130 CD C4 52      [17]  343 	call	_cpct_waitVSYNC
                            344 ;src/main.c:158: cpct_waitVSYNC();
   5133 CD C4 52      [17]  345 	call	_cpct_waitVSYNC
                            346 ;src/main.c:159: cpct_waitVSYNC();
   5136 CD C4 52      [17]  347 	call	_cpct_waitVSYNC
                            348 ;src/main.c:160: cpct_waitVSYNC();
   5139 CD C4 52      [17]  349 	call	_cpct_waitVSYNC
                            350 ;src/main.c:161: cpct_waitVSYNC();
   513C CD C4 52      [17]  351 	call	_cpct_waitVSYNC
                            352 ;src/main.c:162: cpct_waitVSYNC();
   513F CD C4 52      [17]  353 	call	_cpct_waitVSYNC
                            354 ;src/main.c:163: cpct_waitVSYNC();
   5142 CD C4 52      [17]  355 	call	_cpct_waitVSYNC
   5145 C3 CD 4F      [10]  356 	jp	00102$
                            357 	.area _CODE
                            358 	.area _INITIALIZER
                            359 	.area _CABS (ABS)
