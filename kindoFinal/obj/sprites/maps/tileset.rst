                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module tileset
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _map_tileset_241
                             12 	.globl _map_tileset_240
                             13 	.globl _map_tileset_239
                             14 	.globl _map_tileset_238
                             15 	.globl _map_tileset_237
                             16 	.globl _map_tileset_236
                             17 	.globl _map_tileset_235
                             18 	.globl _map_tileset_234
                             19 	.globl _map_tileset_233
                             20 	.globl _map_tileset_232
                             21 	.globl _map_tileset_231
                             22 	.globl _map_tileset_230
                             23 	.globl _map_tileset_229
                             24 	.globl _map_tileset_228
                             25 	.globl _map_tileset_227
                             26 	.globl _map_tileset_226
                             27 	.globl _map_tileset_225
                             28 	.globl _map_tileset_224
                             29 	.globl _map_tileset_223
                             30 	.globl _map_tileset_222
                             31 	.globl _map_tileset_221
                             32 	.globl _map_tileset_220
                             33 	.globl _map_tileset_219
                             34 	.globl _map_tileset_218
                             35 	.globl _map_tileset_217
                             36 	.globl _map_tileset_216
                             37 	.globl _map_tileset_215
                             38 	.globl _map_tileset_214
                             39 	.globl _map_tileset_213
                             40 	.globl _map_tileset_212
                             41 	.globl _map_tileset_211
                             42 	.globl _map_tileset_210
                             43 	.globl _map_tileset_209
                             44 	.globl _map_tileset_208
                             45 	.globl _map_tileset_207
                             46 	.globl _map_tileset_206
                             47 	.globl _map_tileset_205
                             48 	.globl _map_tileset_204
                             49 	.globl _map_tileset_203
                             50 	.globl _map_tileset_202
                             51 	.globl _map_tileset_201
                             52 	.globl _map_tileset_200
                             53 	.globl _map_tileset_199
                             54 	.globl _map_tileset_198
                             55 	.globl _map_tileset_197
                             56 	.globl _map_tileset_196
                             57 	.globl _map_tileset_195
                             58 	.globl _map_tileset_194
                             59 	.globl _map_tileset_193
                             60 	.globl _map_tileset_192
                             61 	.globl _map_tileset_191
                             62 	.globl _map_tileset_190
                             63 	.globl _map_tileset_189
                             64 	.globl _map_tileset_188
                             65 	.globl _map_tileset_187
                             66 	.globl _map_tileset_186
                             67 	.globl _map_tileset_185
                             68 	.globl _map_tileset_184
                             69 	.globl _map_tileset_183
                             70 	.globl _map_tileset_182
                             71 	.globl _map_tileset_181
                             72 	.globl _map_tileset_180
                             73 	.globl _map_tileset_179
                             74 	.globl _map_tileset_178
                             75 	.globl _map_tileset_177
                             76 	.globl _map_tileset_176
                             77 	.globl _map_tileset_175
                             78 	.globl _map_tileset_174
                             79 	.globl _map_tileset_173
                             80 	.globl _map_tileset_172
                             81 	.globl _map_tileset_171
                             82 	.globl _map_tileset_170
                             83 	.globl _map_tileset_169
                             84 	.globl _map_tileset_168
                             85 	.globl _map_tileset_167
                             86 	.globl _map_tileset_166
                             87 	.globl _map_tileset_165
                             88 	.globl _map_tileset_164
                             89 	.globl _map_tileset_163
                             90 	.globl _map_tileset_162
                             91 	.globl _map_tileset_161
                             92 	.globl _map_tileset_160
                             93 	.globl _map_tileset_159
                             94 	.globl _map_tileset_158
                             95 	.globl _map_tileset_157
                             96 	.globl _map_tileset_156
                             97 	.globl _map_tileset_155
                             98 	.globl _map_tileset_154
                             99 	.globl _map_tileset_153
                            100 	.globl _map_tileset_152
                            101 	.globl _map_tileset_151
                            102 	.globl _map_tileset_150
                            103 	.globl _map_tileset_149
                            104 	.globl _map_tileset_148
                            105 	.globl _map_tileset_147
                            106 	.globl _map_tileset_146
                            107 	.globl _map_tileset_145
                            108 	.globl _map_tileset_144
                            109 	.globl _map_tileset_143
                            110 	.globl _map_tileset_142
                            111 	.globl _map_tileset_141
                            112 	.globl _map_tileset_140
                            113 	.globl _map_tileset_139
                            114 	.globl _map_tileset_138
                            115 	.globl _map_tileset_137
                            116 	.globl _map_tileset_136
                            117 	.globl _map_tileset_135
                            118 	.globl _map_tileset_134
                            119 	.globl _map_tileset_133
                            120 	.globl _map_tileset_132
                            121 	.globl _map_tileset_131
                            122 	.globl _map_tileset_130
                            123 	.globl _map_tileset_129
                            124 	.globl _map_tileset_128
                            125 	.globl _map_tileset_127
                            126 	.globl _map_tileset_126
                            127 	.globl _map_tileset_125
                            128 	.globl _map_tileset_124
                            129 	.globl _map_tileset_123
                            130 	.globl _map_tileset_122
                            131 	.globl _map_tileset_121
                            132 	.globl _map_tileset_120
                            133 	.globl _map_tileset_119
                            134 	.globl _map_tileset_118
                            135 	.globl _map_tileset_117
                            136 	.globl _map_tileset_116
                            137 	.globl _map_tileset_115
                            138 	.globl _map_tileset_114
                            139 	.globl _map_tileset_113
                            140 	.globl _map_tileset_112
                            141 	.globl _map_tileset_111
                            142 	.globl _map_tileset_110
                            143 	.globl _map_tileset_109
                            144 	.globl _map_tileset_108
                            145 	.globl _map_tileset_107
                            146 	.globl _map_tileset_106
                            147 	.globl _map_tileset_105
                            148 	.globl _map_tileset_104
                            149 	.globl _map_tileset_103
                            150 	.globl _map_tileset_102
                            151 	.globl _map_tileset_101
                            152 	.globl _map_tileset_100
                            153 	.globl _map_tileset_099
                            154 	.globl _map_tileset_098
                            155 	.globl _map_tileset_097
                            156 	.globl _map_tileset_096
                            157 	.globl _map_tileset_095
                            158 	.globl _map_tileset_094
                            159 	.globl _map_tileset_093
                            160 	.globl _map_tileset_092
                            161 	.globl _map_tileset_091
                            162 	.globl _map_tileset_090
                            163 	.globl _map_tileset_089
                            164 	.globl _map_tileset_088
                            165 	.globl _map_tileset_087
                            166 	.globl _map_tileset_086
                            167 	.globl _map_tileset_085
                            168 	.globl _map_tileset_084
                            169 	.globl _map_tileset_083
                            170 	.globl _map_tileset_082
                            171 	.globl _map_tileset_081
                            172 	.globl _map_tileset_080
                            173 	.globl _map_tileset_079
                            174 	.globl _map_tileset_078
                            175 	.globl _map_tileset_077
                            176 	.globl _map_tileset_076
                            177 	.globl _map_tileset_075
                            178 	.globl _map_tileset_074
                            179 	.globl _map_tileset_073
                            180 	.globl _map_tileset_072
                            181 	.globl _map_tileset_071
                            182 	.globl _map_tileset_070
                            183 	.globl _map_tileset_069
                            184 	.globl _map_tileset_068
                            185 	.globl _map_tileset_067
                            186 	.globl _map_tileset_066
                            187 	.globl _map_tileset_065
                            188 	.globl _map_tileset_064
                            189 	.globl _map_tileset_063
                            190 	.globl _map_tileset_062
                            191 	.globl _map_tileset_061
                            192 	.globl _map_tileset_060
                            193 	.globl _map_tileset_059
                            194 	.globl _map_tileset_058
                            195 	.globl _map_tileset_057
                            196 	.globl _map_tileset_056
                            197 	.globl _map_tileset_055
                            198 	.globl _map_tileset_054
                            199 	.globl _map_tileset_053
                            200 	.globl _map_tileset_052
                            201 	.globl _map_tileset_051
                            202 	.globl _map_tileset_050
                            203 	.globl _map_tileset_049
                            204 	.globl _map_tileset_048
                            205 	.globl _map_tileset_047
                            206 	.globl _map_tileset_046
                            207 	.globl _map_tileset_045
                            208 	.globl _map_tileset_044
                            209 	.globl _map_tileset_043
                            210 	.globl _map_tileset_042
                            211 	.globl _map_tileset_041
                            212 	.globl _map_tileset_040
                            213 	.globl _map_tileset_039
                            214 	.globl _map_tileset_038
                            215 	.globl _map_tileset_037
                            216 	.globl _map_tileset_036
                            217 	.globl _map_tileset_035
                            218 	.globl _map_tileset_034
                            219 	.globl _map_tileset_033
                            220 	.globl _map_tileset_032
                            221 	.globl _map_tileset_031
                            222 	.globl _map_tileset_030
                            223 	.globl _map_tileset_029
                            224 	.globl _map_tileset_028
                            225 	.globl _map_tileset_027
                            226 	.globl _map_tileset_026
                            227 	.globl _map_tileset_025
                            228 	.globl _map_tileset_024
                            229 	.globl _map_tileset_023
                            230 	.globl _map_tileset_022
                            231 	.globl _map_tileset_021
                            232 	.globl _map_tileset_020
                            233 	.globl _map_tileset_019
                            234 	.globl _map_tileset_018
                            235 	.globl _map_tileset_017
                            236 	.globl _map_tileset_016
                            237 	.globl _map_tileset_015
                            238 	.globl _map_tileset_014
                            239 	.globl _map_tileset_013
                            240 	.globl _map_tileset_012
                            241 	.globl _map_tileset_011
                            242 	.globl _map_tileset_010
                            243 	.globl _map_tileset_009
                            244 	.globl _map_tileset_008
                            245 	.globl _map_tileset_007
                            246 	.globl _map_tileset_006
                            247 	.globl _map_tileset_005
                            248 	.globl _map_tileset_004
                            249 	.globl _map_tileset_003
                            250 	.globl _map_tileset_002
                            251 	.globl _map_tileset_001
                            252 	.globl _map_tileset_000
                            253 	.globl _map_tileset
                            254 ;--------------------------------------------------------
                            255 ; special function registers
                            256 ;--------------------------------------------------------
                            257 ;--------------------------------------------------------
                            258 ; ram data
                            259 ;--------------------------------------------------------
                            260 	.area _DATA
                            261 ;--------------------------------------------------------
                            262 ; ram data
                            263 ;--------------------------------------------------------
                            264 	.area _INITIALIZED
                            265 ;--------------------------------------------------------
                            266 ; absolute external ram data
                            267 ;--------------------------------------------------------
                            268 	.area _DABS (ABS)
                            269 ;--------------------------------------------------------
                            270 ; global & static initialisations
                            271 ;--------------------------------------------------------
                            272 	.area _HOME
                            273 	.area _GSINIT
                            274 	.area _GSFINAL
                            275 	.area _GSINIT
                            276 ;--------------------------------------------------------
                            277 ; Home
                            278 ;--------------------------------------------------------
                            279 	.area _HOME
                            280 	.area _HOME
                            281 ;--------------------------------------------------------
                            282 ; code
                            283 ;--------------------------------------------------------
                            284 	.area _CODE
                            285 	.area _CODE
   2690                     286 _map_tileset:
   2690 74 28               287 	.dw _map_tileset_000
   2692 7C 28               288 	.dw _map_tileset_001
   2694 84 28               289 	.dw _map_tileset_002
   2696 8C 28               290 	.dw _map_tileset_003
   2698 94 28               291 	.dw _map_tileset_004
   269A 9C 28               292 	.dw _map_tileset_005
   269C A4 28               293 	.dw _map_tileset_006
   269E AC 28               294 	.dw _map_tileset_007
   26A0 B4 28               295 	.dw _map_tileset_008
   26A2 BC 28               296 	.dw _map_tileset_009
   26A4 C4 28               297 	.dw _map_tileset_010
   26A6 CC 28               298 	.dw _map_tileset_011
   26A8 D4 28               299 	.dw _map_tileset_012
   26AA DC 28               300 	.dw _map_tileset_013
   26AC E4 28               301 	.dw _map_tileset_014
   26AE EC 28               302 	.dw _map_tileset_015
   26B0 F4 28               303 	.dw _map_tileset_016
   26B2 FC 28               304 	.dw _map_tileset_017
   26B4 04 29               305 	.dw _map_tileset_018
   26B6 0C 29               306 	.dw _map_tileset_019
   26B8 14 29               307 	.dw _map_tileset_020
   26BA 1C 29               308 	.dw _map_tileset_021
   26BC 24 29               309 	.dw _map_tileset_022
   26BE 2C 29               310 	.dw _map_tileset_023
   26C0 34 29               311 	.dw _map_tileset_024
   26C2 3C 29               312 	.dw _map_tileset_025
   26C4 44 29               313 	.dw _map_tileset_026
   26C6 4C 29               314 	.dw _map_tileset_027
   26C8 54 29               315 	.dw _map_tileset_028
   26CA 5C 29               316 	.dw _map_tileset_029
   26CC 64 29               317 	.dw _map_tileset_030
   26CE 6C 29               318 	.dw _map_tileset_031
   26D0 74 29               319 	.dw _map_tileset_032
   26D2 7C 29               320 	.dw _map_tileset_033
   26D4 84 29               321 	.dw _map_tileset_034
   26D6 8C 29               322 	.dw _map_tileset_035
   26D8 94 29               323 	.dw _map_tileset_036
   26DA 9C 29               324 	.dw _map_tileset_037
   26DC A4 29               325 	.dw _map_tileset_038
   26DE AC 29               326 	.dw _map_tileset_039
   26E0 B4 29               327 	.dw _map_tileset_040
   26E2 BC 29               328 	.dw _map_tileset_041
   26E4 C4 29               329 	.dw _map_tileset_042
   26E6 CC 29               330 	.dw _map_tileset_043
   26E8 D4 29               331 	.dw _map_tileset_044
   26EA DC 29               332 	.dw _map_tileset_045
   26EC E4 29               333 	.dw _map_tileset_046
   26EE EC 29               334 	.dw _map_tileset_047
   26F0 F4 29               335 	.dw _map_tileset_048
   26F2 FC 29               336 	.dw _map_tileset_049
   26F4 04 2A               337 	.dw _map_tileset_050
   26F6 0C 2A               338 	.dw _map_tileset_051
   26F8 14 2A               339 	.dw _map_tileset_052
   26FA 1C 2A               340 	.dw _map_tileset_053
   26FC 24 2A               341 	.dw _map_tileset_054
   26FE 2C 2A               342 	.dw _map_tileset_055
   2700 34 2A               343 	.dw _map_tileset_056
   2702 3C 2A               344 	.dw _map_tileset_057
   2704 44 2A               345 	.dw _map_tileset_058
   2706 4C 2A               346 	.dw _map_tileset_059
   2708 54 2A               347 	.dw _map_tileset_060
   270A 5C 2A               348 	.dw _map_tileset_061
   270C 64 2A               349 	.dw _map_tileset_062
   270E 6C 2A               350 	.dw _map_tileset_063
   2710 74 2A               351 	.dw _map_tileset_064
   2712 7C 2A               352 	.dw _map_tileset_065
   2714 84 2A               353 	.dw _map_tileset_066
   2716 8C 2A               354 	.dw _map_tileset_067
   2718 94 2A               355 	.dw _map_tileset_068
   271A 9C 2A               356 	.dw _map_tileset_069
   271C A4 2A               357 	.dw _map_tileset_070
   271E AC 2A               358 	.dw _map_tileset_071
   2720 B4 2A               359 	.dw _map_tileset_072
   2722 BC 2A               360 	.dw _map_tileset_073
   2724 C4 2A               361 	.dw _map_tileset_074
   2726 CC 2A               362 	.dw _map_tileset_075
   2728 D4 2A               363 	.dw _map_tileset_076
   272A DC 2A               364 	.dw _map_tileset_077
   272C E4 2A               365 	.dw _map_tileset_078
   272E EC 2A               366 	.dw _map_tileset_079
   2730 F4 2A               367 	.dw _map_tileset_080
   2732 FC 2A               368 	.dw _map_tileset_081
   2734 04 2B               369 	.dw _map_tileset_082
   2736 0C 2B               370 	.dw _map_tileset_083
   2738 14 2B               371 	.dw _map_tileset_084
   273A 1C 2B               372 	.dw _map_tileset_085
   273C 24 2B               373 	.dw _map_tileset_086
   273E 2C 2B               374 	.dw _map_tileset_087
   2740 34 2B               375 	.dw _map_tileset_088
   2742 3C 2B               376 	.dw _map_tileset_089
   2744 44 2B               377 	.dw _map_tileset_090
   2746 4C 2B               378 	.dw _map_tileset_091
   2748 54 2B               379 	.dw _map_tileset_092
   274A 5C 2B               380 	.dw _map_tileset_093
   274C 64 2B               381 	.dw _map_tileset_094
   274E 6C 2B               382 	.dw _map_tileset_095
   2750 74 2B               383 	.dw _map_tileset_096
   2752 7C 2B               384 	.dw _map_tileset_097
   2754 84 2B               385 	.dw _map_tileset_098
   2756 8C 2B               386 	.dw _map_tileset_099
   2758 94 2B               387 	.dw _map_tileset_100
   275A 9C 2B               388 	.dw _map_tileset_101
   275C A4 2B               389 	.dw _map_tileset_102
   275E AC 2B               390 	.dw _map_tileset_103
   2760 B4 2B               391 	.dw _map_tileset_104
   2762 BC 2B               392 	.dw _map_tileset_105
   2764 C4 2B               393 	.dw _map_tileset_106
   2766 CC 2B               394 	.dw _map_tileset_107
   2768 D4 2B               395 	.dw _map_tileset_108
   276A DC 2B               396 	.dw _map_tileset_109
   276C E4 2B               397 	.dw _map_tileset_110
   276E EC 2B               398 	.dw _map_tileset_111
   2770 F4 2B               399 	.dw _map_tileset_112
   2772 FC 2B               400 	.dw _map_tileset_113
   2774 04 2C               401 	.dw _map_tileset_114
   2776 0C 2C               402 	.dw _map_tileset_115
   2778 14 2C               403 	.dw _map_tileset_116
   277A 1C 2C               404 	.dw _map_tileset_117
   277C 24 2C               405 	.dw _map_tileset_118
   277E 2C 2C               406 	.dw _map_tileset_119
   2780 34 2C               407 	.dw _map_tileset_120
   2782 3C 2C               408 	.dw _map_tileset_121
   2784 44 2C               409 	.dw _map_tileset_122
   2786 4C 2C               410 	.dw _map_tileset_123
   2788 54 2C               411 	.dw _map_tileset_124
   278A 5C 2C               412 	.dw _map_tileset_125
   278C 64 2C               413 	.dw _map_tileset_126
   278E 6C 2C               414 	.dw _map_tileset_127
   2790 74 2C               415 	.dw _map_tileset_128
   2792 7C 2C               416 	.dw _map_tileset_129
   2794 84 2C               417 	.dw _map_tileset_130
   2796 8C 2C               418 	.dw _map_tileset_131
   2798 94 2C               419 	.dw _map_tileset_132
   279A 9C 2C               420 	.dw _map_tileset_133
   279C A4 2C               421 	.dw _map_tileset_134
   279E AC 2C               422 	.dw _map_tileset_135
   27A0 B4 2C               423 	.dw _map_tileset_136
   27A2 BC 2C               424 	.dw _map_tileset_137
   27A4 C4 2C               425 	.dw _map_tileset_138
   27A6 CC 2C               426 	.dw _map_tileset_139
   27A8 D4 2C               427 	.dw _map_tileset_140
   27AA DC 2C               428 	.dw _map_tileset_141
   27AC E4 2C               429 	.dw _map_tileset_142
   27AE EC 2C               430 	.dw _map_tileset_143
   27B0 F4 2C               431 	.dw _map_tileset_144
   27B2 FC 2C               432 	.dw _map_tileset_145
   27B4 04 2D               433 	.dw _map_tileset_146
   27B6 0C 2D               434 	.dw _map_tileset_147
   27B8 14 2D               435 	.dw _map_tileset_148
   27BA 1C 2D               436 	.dw _map_tileset_149
   27BC 24 2D               437 	.dw _map_tileset_150
   27BE 2C 2D               438 	.dw _map_tileset_151
   27C0 34 2D               439 	.dw _map_tileset_152
   27C2 3C 2D               440 	.dw _map_tileset_153
   27C4 44 2D               441 	.dw _map_tileset_154
   27C6 4C 2D               442 	.dw _map_tileset_155
   27C8 54 2D               443 	.dw _map_tileset_156
   27CA 5C 2D               444 	.dw _map_tileset_157
   27CC 64 2D               445 	.dw _map_tileset_158
   27CE 6C 2D               446 	.dw _map_tileset_159
   27D0 74 2D               447 	.dw _map_tileset_160
   27D2 7C 2D               448 	.dw _map_tileset_161
   27D4 84 2D               449 	.dw _map_tileset_162
   27D6 8C 2D               450 	.dw _map_tileset_163
   27D8 94 2D               451 	.dw _map_tileset_164
   27DA 9C 2D               452 	.dw _map_tileset_165
   27DC A4 2D               453 	.dw _map_tileset_166
   27DE AC 2D               454 	.dw _map_tileset_167
   27E0 B4 2D               455 	.dw _map_tileset_168
   27E2 BC 2D               456 	.dw _map_tileset_169
   27E4 C4 2D               457 	.dw _map_tileset_170
   27E6 CC 2D               458 	.dw _map_tileset_171
   27E8 D4 2D               459 	.dw _map_tileset_172
   27EA DC 2D               460 	.dw _map_tileset_173
   27EC E4 2D               461 	.dw _map_tileset_174
   27EE EC 2D               462 	.dw _map_tileset_175
   27F0 F4 2D               463 	.dw _map_tileset_176
   27F2 FC 2D               464 	.dw _map_tileset_177
   27F4 04 2E               465 	.dw _map_tileset_178
   27F6 0C 2E               466 	.dw _map_tileset_179
   27F8 14 2E               467 	.dw _map_tileset_180
   27FA 1C 2E               468 	.dw _map_tileset_181
   27FC 24 2E               469 	.dw _map_tileset_182
   27FE 2C 2E               470 	.dw _map_tileset_183
   2800 34 2E               471 	.dw _map_tileset_184
   2802 3C 2E               472 	.dw _map_tileset_185
   2804 44 2E               473 	.dw _map_tileset_186
   2806 4C 2E               474 	.dw _map_tileset_187
   2808 54 2E               475 	.dw _map_tileset_188
   280A 5C 2E               476 	.dw _map_tileset_189
   280C 64 2E               477 	.dw _map_tileset_190
   280E 6C 2E               478 	.dw _map_tileset_191
   2810 74 2E               479 	.dw _map_tileset_192
   2812 7C 2E               480 	.dw _map_tileset_193
   2814 84 2E               481 	.dw _map_tileset_194
   2816 8C 2E               482 	.dw _map_tileset_195
   2818 94 2E               483 	.dw _map_tileset_196
   281A 9C 2E               484 	.dw _map_tileset_197
   281C A4 2E               485 	.dw _map_tileset_198
   281E AC 2E               486 	.dw _map_tileset_199
   2820 B4 2E               487 	.dw _map_tileset_200
   2822 BC 2E               488 	.dw _map_tileset_201
   2824 C4 2E               489 	.dw _map_tileset_202
   2826 CC 2E               490 	.dw _map_tileset_203
   2828 D4 2E               491 	.dw _map_tileset_204
   282A DC 2E               492 	.dw _map_tileset_205
   282C E4 2E               493 	.dw _map_tileset_206
   282E EC 2E               494 	.dw _map_tileset_207
   2830 F4 2E               495 	.dw _map_tileset_208
   2832 FC 2E               496 	.dw _map_tileset_209
   2834 04 2F               497 	.dw _map_tileset_210
   2836 0C 2F               498 	.dw _map_tileset_211
   2838 14 2F               499 	.dw _map_tileset_212
   283A 1C 2F               500 	.dw _map_tileset_213
   283C 24 2F               501 	.dw _map_tileset_214
   283E 2C 2F               502 	.dw _map_tileset_215
   2840 34 2F               503 	.dw _map_tileset_216
   2842 3C 2F               504 	.dw _map_tileset_217
   2844 44 2F               505 	.dw _map_tileset_218
   2846 4C 2F               506 	.dw _map_tileset_219
   2848 54 2F               507 	.dw _map_tileset_220
   284A 5C 2F               508 	.dw _map_tileset_221
   284C 64 2F               509 	.dw _map_tileset_222
   284E 6C 2F               510 	.dw _map_tileset_223
   2850 74 2F               511 	.dw _map_tileset_224
   2852 7C 2F               512 	.dw _map_tileset_225
   2854 84 2F               513 	.dw _map_tileset_226
   2856 8C 2F               514 	.dw _map_tileset_227
   2858 94 2F               515 	.dw _map_tileset_228
   285A 9C 2F               516 	.dw _map_tileset_229
   285C A4 2F               517 	.dw _map_tileset_230
   285E AC 2F               518 	.dw _map_tileset_231
   2860 B4 2F               519 	.dw _map_tileset_232
   2862 BC 2F               520 	.dw _map_tileset_233
   2864 C4 2F               521 	.dw _map_tileset_234
   2866 CC 2F               522 	.dw _map_tileset_235
   2868 D4 2F               523 	.dw _map_tileset_236
   286A DC 2F               524 	.dw _map_tileset_237
   286C E4 2F               525 	.dw _map_tileset_238
   286E EC 2F               526 	.dw _map_tileset_239
   2870 F4 2F               527 	.dw _map_tileset_240
   2872 FC 2F               528 	.dw _map_tileset_241
   2874                     529 _map_tileset_000:
   2874 F0                  530 	.db #0xF0	; 240
   2875 FF                  531 	.db #0xFF	; 255
   2876 F0                  532 	.db #0xF0	; 240
   2877 FF                  533 	.db #0xFF	; 255
   2878 F0                  534 	.db #0xF0	; 240
   2879 FA                  535 	.db #0xFA	; 250
   287A F0                  536 	.db #0xF0	; 240
   287B FF                  537 	.db #0xFF	; 255
   287C                     538 _map_tileset_001:
   287C F5                  539 	.db #0xF5	; 245
   287D F0                  540 	.db #0xF0	; 240
   287E F5                  541 	.db #0xF5	; 245
   287F F0                  542 	.db #0xF0	; 240
   2880 FF                  543 	.db #0xFF	; 255
   2881 F0                  544 	.db #0xF0	; 240
   2882 F5                  545 	.db #0xF5	; 245
   2883 F0                  546 	.db #0xF0	; 240
   2884                     547 _map_tileset_002:
   2884 FF                  548 	.db #0xFF	; 255
   2885 FF                  549 	.db #0xFF	; 255
   2886 FF                  550 	.db #0xFF	; 255
   2887 FF                  551 	.db #0xFF	; 255
   2888 EA                  552 	.db #0xEA	; 234
   2889 FF                  553 	.db #0xFF	; 255
   288A EA                  554 	.db #0xEA	; 234
   288B FF                  555 	.db #0xFF	; 255
   288C                     556 _map_tileset_003:
   288C C0                  557 	.db #0xC0	; 192
   288D C0                  558 	.db #0xC0	; 192
   288E 95                  559 	.db #0x95	; 149
   288F C0                  560 	.db #0xC0	; 192
   2890 C0                  561 	.db #0xC0	; 192
   2891 C0                  562 	.db #0xC0	; 192
   2892 C0                  563 	.db #0xC0	; 192
   2893 C0                  564 	.db #0xC0	; 192
   2894                     565 _map_tileset_004:
   2894 C0                  566 	.db #0xC0	; 192
   2895 C0                  567 	.db #0xC0	; 192
   2896 95                  568 	.db #0x95	; 149
   2897 C0                  569 	.db #0xC0	; 192
   2898 95                  570 	.db #0x95	; 149
   2899 C0                  571 	.db #0xC0	; 192
   289A C0                  572 	.db #0xC0	; 192
   289B C0                  573 	.db #0xC0	; 192
   289C                     574 _map_tileset_005:
   289C FF                  575 	.db #0xFF	; 255
   289D FB                  576 	.db #0xFB	; 251
   289E FF                  577 	.db #0xFF	; 255
   289F FB                  578 	.db #0xFB	; 251
   28A0 FF                  579 	.db #0xFF	; 255
   28A1 FB                  580 	.db #0xFB	; 251
   28A2 FF                  581 	.db #0xFF	; 255
   28A3 FB                  582 	.db #0xFB	; 251
   28A4                     583 _map_tileset_006:
   28A4 F7                  584 	.db #0xF7	; 247
   28A5 FF                  585 	.db #0xFF	; 255
   28A6 F7                  586 	.db #0xF7	; 247
   28A7 FF                  587 	.db #0xFF	; 255
   28A8 F7                  588 	.db #0xF7	; 247
   28A9 FF                  589 	.db #0xFF	; 255
   28AA FF                  590 	.db #0xFF	; 255
   28AB FF                  591 	.db #0xFF	; 255
   28AC                     592 _map_tileset_007:
   28AC EA                  593 	.db #0xEA	; 234
   28AD C0                  594 	.db #0xC0	; 192
   28AE EA                  595 	.db #0xEA	; 234
   28AF C0                  596 	.db #0xC0	; 192
   28B0 EA                  597 	.db #0xEA	; 234
   28B1 C0                  598 	.db #0xC0	; 192
   28B2 EA                  599 	.db #0xEA	; 234
   28B3 C0                  600 	.db #0xC0	; 192
   28B4                     601 _map_tileset_008:
   28B4 EA                  602 	.db #0xEA	; 234
   28B5 D0                  603 	.db #0xD0	; 208
   28B6 EA                  604 	.db #0xEA	; 234
   28B7 D0                  605 	.db #0xD0	; 208
   28B8 EA                  606 	.db #0xEA	; 234
   28B9 F0                  607 	.db #0xF0	; 240
   28BA EA                  608 	.db #0xEA	; 234
   28BB F0                  609 	.db #0xF0	; 240
   28BC                     610 _map_tileset_009:
   28BC C0                  611 	.db #0xC0	; 192
   28BD C0                  612 	.db #0xC0	; 192
   28BE C0                  613 	.db #0xC0	; 192
   28BF C0                  614 	.db #0xC0	; 192
   28C0 C0                  615 	.db #0xC0	; 192
   28C1 C0                  616 	.db #0xC0	; 192
   28C2 F0                  617 	.db #0xF0	; 240
   28C3 F0                  618 	.db #0xF0	; 240
   28C4                     619 _map_tileset_010:
   28C4 FF                  620 	.db #0xFF	; 255
   28C5 FF                  621 	.db #0xFF	; 255
   28C6 D5                  622 	.db #0xD5	; 213
   28C7 FF                  623 	.db #0xFF	; 255
   28C8 D5                  624 	.db #0xD5	; 213
   28C9 FF                  625 	.db #0xFF	; 255
   28CA C0                  626 	.db #0xC0	; 192
   28CB FF                  627 	.db #0xFF	; 255
   28CC                     628 _map_tileset_011:
   28CC C0                  629 	.db #0xC0	; 192
   28CD C0                  630 	.db #0xC0	; 192
   28CE E8                  631 	.db #0xE8	; 232
   28CF C0                  632 	.db #0xC0	; 192
   28D0 C0                  633 	.db #0xC0	; 192
   28D1 C0                  634 	.db #0xC0	; 192
   28D2 C0                  635 	.db #0xC0	; 192
   28D3 C0                  636 	.db #0xC0	; 192
   28D4                     637 _map_tileset_012:
   28D4 FF                  638 	.db #0xFF	; 255
   28D5 EB                  639 	.db #0xEB	; 235
   28D6 FF                  640 	.db #0xFF	; 255
   28D7 C3                  641 	.db #0xC3	; 195
   28D8 FF                  642 	.db #0xFF	; 255
   28D9 C3                  643 	.db #0xC3	; 195
   28DA EB                  644 	.db #0xEB	; 235
   28DB C3                  645 	.db #0xC3	; 195
   28DC                     646 _map_tileset_013:
   28DC FF                  647 	.db #0xFF	; 255
   28DD FF                  648 	.db #0xFF	; 255
   28DE D7                  649 	.db #0xD7	; 215
   28DF FF                  650 	.db #0xFF	; 255
   28E0 D7                  651 	.db #0xD7	; 215
   28E1 FF                  652 	.db #0xFF	; 255
   28E2 C3                  653 	.db #0xC3	; 195
   28E3 FF                  654 	.db #0xFF	; 255
   28E4                     655 _map_tileset_014:
   28E4 86                  656 	.db #0x86	; 134
   28E5 0C                  657 	.db #0x0C	; 12
   28E6 C3                  658 	.db #0xC3	; 195
   28E7 C3                  659 	.db #0xC3	; 195
   28E8 C3                  660 	.db #0xC3	; 195
   28E9 C3                  661 	.db #0xC3	; 195
   28EA C3                  662 	.db #0xC3	; 195
   28EB C3                  663 	.db #0xC3	; 195
   28EC                     664 _map_tileset_015:
   28EC 0C                  665 	.db #0x0C	; 12
   28ED 0C                  666 	.db #0x0C	; 12
   28EE C3                  667 	.db #0xC3	; 195
   28EF C3                  668 	.db #0xC3	; 195
   28F0 C3                  669 	.db #0xC3	; 195
   28F1 C3                  670 	.db #0xC3	; 195
   28F2 C3                  671 	.db #0xC3	; 195
   28F3 C3                  672 	.db #0xC3	; 195
   28F4                     673 _map_tileset_016:
   28F4 FF                  674 	.db #0xFF	; 255
   28F5 AE                  675 	.db #0xAE	; 174
   28F6 FF                  676 	.db #0xFF	; 255
   28F7 0C                  677 	.db #0x0C	; 12
   28F8 FF                  678 	.db #0xFF	; 255
   28F9 0C                  679 	.db #0x0C	; 12
   28FA AE                  680 	.db #0xAE	; 174
   28FB 0C                  681 	.db #0x0C	; 12
   28FC                     682 _map_tileset_017:
   28FC FF                  683 	.db #0xFF	; 255
   28FD FF                  684 	.db #0xFF	; 255
   28FE 5D                  685 	.db #0x5D	; 93
   28FF FF                  686 	.db #0xFF	; 255
   2900 5D                  687 	.db #0x5D	; 93
   2901 FF                  688 	.db #0xFF	; 255
   2902 0C                  689 	.db #0x0C	; 12
   2903 FF                  690 	.db #0xFF	; 255
   2904                     691 _map_tileset_018:
   2904 FF                  692 	.db #0xFF	; 255
   2905 AE                  693 	.db #0xAE	; 174
   2906 FF                  694 	.db #0xFF	; 255
   2907 0C                  695 	.db #0x0C	; 12
   2908 FF                  696 	.db #0xFF	; 255
   2909 0C                  697 	.db #0x0C	; 12
   290A AE                  698 	.db #0xAE	; 174
   290B 0C                  699 	.db #0x0C	; 12
   290C                     700 _map_tileset_019:
   290C FF                  701 	.db #0xFF	; 255
   290D FF                  702 	.db #0xFF	; 255
   290E 5D                  703 	.db #0x5D	; 93
   290F FF                  704 	.db #0xFF	; 255
   2910 5D                  705 	.db #0x5D	; 93
   2911 FF                  706 	.db #0xFF	; 255
   2912 0C                  707 	.db #0x0C	; 12
   2913 FF                  708 	.db #0xFF	; 255
   2914                     709 _map_tileset_020:
   2914 0C                  710 	.db #0x0C	; 12
   2915 0C                  711 	.db #0x0C	; 12
   2916 0C                  712 	.db #0x0C	; 12
   2917 0C                  713 	.db #0x0C	; 12
   2918 0C                  714 	.db #0x0C	; 12
   2919 49                  715 	.db #0x49	; 73	'I'
   291A 0C                  716 	.db #0x0C	; 12
   291B C3                  717 	.db #0xC3	; 195
   291C                     718 _map_tileset_021:
   291C FF                  719 	.db #0xFF	; 255
   291D FF                  720 	.db #0xFF	; 255
   291E FF                  721 	.db #0xFF	; 255
   291F 5D                  722 	.db #0x5D	; 93
   2920 FF                  723 	.db #0xFF	; 255
   2921 5D                  724 	.db #0x5D	; 93
   2922 AE                  725 	.db #0xAE	; 174
   2923 5D                  726 	.db #0x5D	; 93
   2924                     727 _map_tileset_022:
   2924 F0                  728 	.db #0xF0	; 240
   2925 EF                  729 	.db #0xEF	; 239
   2926 F0                  730 	.db #0xF0	; 240
   2927 FA                  731 	.db #0xFA	; 250
   2928 F0                  732 	.db #0xF0	; 240
   2929 FF                  733 	.db #0xFF	; 255
   292A F0                  734 	.db #0xF0	; 240
   292B FF                  735 	.db #0xFF	; 255
   292C                     736 _map_tileset_023:
   292C F5                  737 	.db #0xF5	; 245
   292D F0                  738 	.db #0xF0	; 240
   292E FF                  739 	.db #0xFF	; 255
   292F F0                  740 	.db #0xF0	; 240
   2930 F5                  741 	.db #0xF5	; 245
   2931 F0                  742 	.db #0xF0	; 240
   2932 F5                  743 	.db #0xF5	; 245
   2933 F0                  744 	.db #0xF0	; 240
   2934                     745 _map_tileset_024:
   2934 EA                  746 	.db #0xEA	; 234
   2935 D5                  747 	.db #0xD5	; 213
   2936 EA                  748 	.db #0xEA	; 234
   2937 C0                  749 	.db #0xC0	; 192
   2938 EA                  750 	.db #0xEA	; 234
   2939 C0                  751 	.db #0xC0	; 192
   293A EA                  752 	.db #0xEA	; 234
   293B C0                  753 	.db #0xC0	; 192
   293C                     754 _map_tileset_025:
   293C FF                  755 	.db #0xFF	; 255
   293D FF                  756 	.db #0xFF	; 255
   293E C0                  757 	.db #0xC0	; 192
   293F C0                  758 	.db #0xC0	; 192
   2940 C0                  759 	.db #0xC0	; 192
   2941 C0                  760 	.db #0xC0	; 192
   2942 C0                  761 	.db #0xC0	; 192
   2943 C0                  762 	.db #0xC0	; 192
   2944                     763 _map_tileset_026:
   2944 FF                  764 	.db #0xFF	; 255
   2945 FF                  765 	.db #0xFF	; 255
   2946 D1                  766 	.db #0xD1	; 209
   2947 F3                  767 	.db #0xF3	; 243
   2948 D1                  768 	.db #0xD1	; 209
   2949 F3                  769 	.db #0xF3	; 243
   294A D1                  770 	.db #0xD1	; 209
   294B F3                  771 	.db #0xF3	; 243
   294C                     772 _map_tileset_027:
   294C FB                  773 	.db #0xFB	; 251
   294D FF                  774 	.db #0xFF	; 255
   294E F3                  775 	.db #0xF3	; 243
   294F FB                  776 	.db #0xFB	; 251
   2950 F3                  777 	.db #0xF3	; 243
   2951 FF                  778 	.db #0xFF	; 255
   2952 F3                  779 	.db #0xF3	; 243
   2953 FF                  780 	.db #0xFF	; 255
   2954                     781 _map_tileset_028:
   2954 F7                  782 	.db #0xF7	; 247
   2955 F7                  783 	.db #0xF7	; 247
   2956 FF                  784 	.db #0xFF	; 255
   2957 F3                  785 	.db #0xF3	; 243
   2958 F7                  786 	.db #0xF7	; 247
   2959 F3                  787 	.db #0xF3	; 243
   295A F7                  788 	.db #0xF7	; 247
   295B F3                  789 	.db #0xF3	; 243
   295C                     790 _map_tileset_029:
   295C FF                  791 	.db #0xFF	; 255
   295D FF                  792 	.db #0xFF	; 255
   295E F3                  793 	.db #0xF3	; 243
   295F F3                  794 	.db #0xF3	; 243
   2960 F3                  795 	.db #0xF3	; 243
   2961 F3                  796 	.db #0xF3	; 243
   2962 F3                  797 	.db #0xF3	; 243
   2963 F3                  798 	.db #0xF3	; 243
   2964                     799 _map_tileset_030:
   2964 FF                  800 	.db #0xFF	; 255
   2965 FF                  801 	.db #0xFF	; 255
   2966 F3                  802 	.db #0xF3	; 243
   2967 E3                  803 	.db #0xE3	; 227
   2968 F3                  804 	.db #0xF3	; 243
   2969 E3                  805 	.db #0xE3	; 227
   296A F3                  806 	.db #0xF3	; 243
   296B E3                  807 	.db #0xE3	; 227
   296C                     808 _map_tileset_031:
   296C F0                  809 	.db #0xF0	; 240
   296D F0                  810 	.db #0xF0	; 240
   296E F0                  811 	.db #0xF0	; 240
   296F B0                  812 	.db #0xB0	; 176
   2970 F0                  813 	.db #0xF0	; 240
   2971 30                  814 	.db #0x30	; 48	'0'
   2972 B0                  815 	.db #0xB0	; 176
   2973 30                  816 	.db #0x30	; 48	'0'
   2974                     817 _map_tileset_032:
   2974 C0                  818 	.db #0xC0	; 192
   2975 FF                  819 	.db #0xFF	; 255
   2976 C0                  820 	.db #0xC0	; 192
   2977 C0                  821 	.db #0xC0	; 192
   2978 C0                  822 	.db #0xC0	; 192
   2979 C0                  823 	.db #0xC0	; 192
   297A C0                  824 	.db #0xC0	; 192
   297B C0                  825 	.db #0xC0	; 192
   297C                     826 _map_tileset_033:
   297C EA                  827 	.db #0xEA	; 234
   297D C0                  828 	.db #0xC0	; 192
   297E C3                  829 	.db #0xC3	; 195
   297F C0                  830 	.db #0xC0	; 192
   2980 C2                  831 	.db #0xC2	; 194
   2981 C0                  832 	.db #0xC0	; 192
   2982 C0                  833 	.db #0xC0	; 192
   2983 C0                  834 	.db #0xC0	; 192
   2984                     835 _map_tileset_034:
   2984 EB                  836 	.db #0xEB	; 235
   2985 C3                  837 	.db #0xC3	; 195
   2986 C3                  838 	.db #0xC3	; 195
   2987 C3                  839 	.db #0xC3	; 195
   2988 C3                  840 	.db #0xC3	; 195
   2989 C3                  841 	.db #0xC3	; 195
   298A C3                  842 	.db #0xC3	; 195
   298B C3                  843 	.db #0xC3	; 195
   298C                     844 _map_tileset_035:
   298C C3                  845 	.db #0xC3	; 195
   298D FF                  846 	.db #0xFF	; 255
   298E C3                  847 	.db #0xC3	; 195
   298F C3                  848 	.db #0xC3	; 195
   2990 C3                  849 	.db #0xC3	; 195
   2991 C3                  850 	.db #0xC3	; 195
   2992 C3                  851 	.db #0xC3	; 195
   2993 C3                  852 	.db #0xC3	; 195
   2994                     853 _map_tileset_036:
   2994 FF                  854 	.db #0xFF	; 255
   2995 FF                  855 	.db #0xFF	; 255
   2996 C3                  856 	.db #0xC3	; 195
   2997 C3                  857 	.db #0xC3	; 195
   2998 C3                  858 	.db #0xC3	; 195
   2999 C3                  859 	.db #0xC3	; 195
   299A C3                  860 	.db #0xC3	; 195
   299B C3                  861 	.db #0xC3	; 195
   299C                     862 _map_tileset_037:
   299C AE                  863 	.db #0xAE	; 174
   299D 0C                  864 	.db #0x0C	; 12
   299E C3                  865 	.db #0xC3	; 195
   299F C3                  866 	.db #0xC3	; 195
   29A0 C3                  867 	.db #0xC3	; 195
   29A1 C3                  868 	.db #0xC3	; 195
   29A2 C3                  869 	.db #0xC3	; 195
   29A3 C3                  870 	.db #0xC3	; 195
   29A4                     871 _map_tileset_038:
   29A4 0C                  872 	.db #0x0C	; 12
   29A5 FF                  873 	.db #0xFF	; 255
   29A6 C3                  874 	.db #0xC3	; 195
   29A7 C3                  875 	.db #0xC3	; 195
   29A8 C3                  876 	.db #0xC3	; 195
   29A9 C3                  877 	.db #0xC3	; 195
   29AA C3                  878 	.db #0xC3	; 195
   29AB C3                  879 	.db #0xC3	; 195
   29AC                     880 _map_tileset_039:
   29AC FF                  881 	.db #0xFF	; 255
   29AD FF                  882 	.db #0xFF	; 255
   29AE 0C                  883 	.db #0x0C	; 12
   29AF 0C                  884 	.db #0x0C	; 12
   29B0 86                  885 	.db #0x86	; 134
   29B1 0C                  886 	.db #0x0C	; 12
   29B2 86                  887 	.db #0x86	; 134
   29B3 0C                  888 	.db #0x0C	; 12
   29B4                     889 _map_tileset_040:
   29B4 AE                  890 	.db #0xAE	; 174
   29B5 0C                  891 	.db #0x0C	; 12
   29B6 0C                  892 	.db #0x0C	; 12
   29B7 0C                  893 	.db #0x0C	; 12
   29B8 0C                  894 	.db #0x0C	; 12
   29B9 0C                  895 	.db #0x0C	; 12
   29BA 0C                  896 	.db #0x0C	; 12
   29BB 0C                  897 	.db #0x0C	; 12
   29BC                     898 _map_tileset_041:
   29BC 0C                  899 	.db #0x0C	; 12
   29BD FF                  900 	.db #0xFF	; 255
   29BE 0C                  901 	.db #0x0C	; 12
   29BF 0C                  902 	.db #0x0C	; 12
   29C0 0C                  903 	.db #0x0C	; 12
   29C1 0C                  904 	.db #0x0C	; 12
   29C2 0C                  905 	.db #0x0C	; 12
   29C3 0C                  906 	.db #0x0C	; 12
   29C4                     907 _map_tileset_042:
   29C4 FF                  908 	.db #0xFF	; 255
   29C5 FF                  909 	.db #0xFF	; 255
   29C6 0C                  910 	.db #0x0C	; 12
   29C7 0C                  911 	.db #0x0C	; 12
   29C8 0C                  912 	.db #0x0C	; 12
   29C9 0C                  913 	.db #0x0C	; 12
   29CA 0C                  914 	.db #0x0C	; 12
   29CB 0C                  915 	.db #0x0C	; 12
   29CC                     916 _map_tileset_043:
   29CC AE                  917 	.db #0xAE	; 174
   29CD 5D                  918 	.db #0x5D	; 93
   29CE 0C                  919 	.db #0x0C	; 12
   29CF 5D                  920 	.db #0x5D	; 93
   29D0 0C                  921 	.db #0x0C	; 12
   29D1 5D                  922 	.db #0x5D	; 93
   29D2 0C                  923 	.db #0x0C	; 12
   29D3 5D                  924 	.db #0x5D	; 93
   29D4                     925 _map_tileset_044:
   29D4 F0                  926 	.db #0xF0	; 240
   29D5 FA                  927 	.db #0xFA	; 250
   29D6 F0                  928 	.db #0xF0	; 240
   29D7 FF                  929 	.db #0xFF	; 255
   29D8 F0                  930 	.db #0xF0	; 240
   29D9 EF                  931 	.db #0xEF	; 239
   29DA F0                  932 	.db #0xF0	; 240
   29DB FA                  933 	.db #0xFA	; 250
   29DC                     934 _map_tileset_045:
   29DC FF                  935 	.db #0xFF	; 255
   29DD F0                  936 	.db #0xF0	; 240
   29DE F5                  937 	.db #0xF5	; 245
   29DF F0                  938 	.db #0xF0	; 240
   29E0 F5                  939 	.db #0xF5	; 245
   29E1 F0                  940 	.db #0xF0	; 240
   29E2 FF                  941 	.db #0xFF	; 255
   29E3 F0                  942 	.db #0xF0	; 240
   29E4                     943 _map_tileset_046:
   29E4 F0                  944 	.db #0xF0	; 240
   29E5 30                  945 	.db #0x30	; 48	'0'
   29E6 B0                  946 	.db #0xB0	; 176
   29E7 30                  947 	.db #0x30	; 48	'0'
   29E8 30                  948 	.db #0x30	; 48	'0'
   29E9 30                  949 	.db #0x30	; 48	'0'
   29EA 30                  950 	.db #0x30	; 48	'0'
   29EB 30                  951 	.db #0x30	; 48	'0'
   29EC                     952 _map_tileset_047:
   29EC FA                  953 	.db #0xFA	; 250
   29ED 30                  954 	.db #0x30	; 48	'0'
   29EE FA                  955 	.db #0xFA	; 250
   29EF 30                  956 	.db #0x30	; 48	'0'
   29F0 BA                  957 	.db #0xBA	; 186
   29F1 30                  958 	.db #0x30	; 48	'0'
   29F2 BA                  959 	.db #0xBA	; 186
   29F3 30                  960 	.db #0x30	; 48	'0'
   29F4                     961 _map_tileset_048:
   29F4 BA                  962 	.db #0xBA	; 186
   29F5 30                  963 	.db #0x30	; 48	'0'
   29F6 BA                  964 	.db #0xBA	; 186
   29F7 30                  965 	.db #0x30	; 48	'0'
   29F8 BA                  966 	.db #0xBA	; 186
   29F9 30                  967 	.db #0x30	; 48	'0'
   29FA BA                  968 	.db #0xBA	; 186
   29FB 30                  969 	.db #0x30	; 48	'0'
   29FC                     970 _map_tileset_049:
   29FC F3                  971 	.db #0xF3	; 243
   29FD FB                  972 	.db #0xFB	; 251
   29FE F3                  973 	.db #0xF3	; 243
   29FF FF                  974 	.db #0xFF	; 255
   2A00 F3                  975 	.db #0xF3	; 243
   2A01 EF                  976 	.db #0xEF	; 239
   2A02 F3                  977 	.db #0xF3	; 243
   2A03 FB                  978 	.db #0xFB	; 251
   2A04                     979 _map_tileset_050:
   2A04 F0                  980 	.db #0xF0	; 240
   2A05 F0                  981 	.db #0xF0	; 240
   2A06 70                  982 	.db #0x70	; 112	'p'
   2A07 F0                  983 	.db #0xF0	; 240
   2A08 30                  984 	.db #0x30	; 48	'0'
   2A09 F0                  985 	.db #0xF0	; 240
   2A0A 30                  986 	.db #0x30	; 48	'0'
   2A0B F0                  987 	.db #0xF0	; 240
   2A0C                     988 _map_tileset_051:
   2A0C C3                  989 	.db #0xC3	; 195
   2A0D C3                  990 	.db #0xC3	; 195
   2A0E E3                  991 	.db #0xE3	; 227
   2A0F C3                  992 	.db #0xC3	; 195
   2A10 F3                  993 	.db #0xF3	; 243
   2A11 E3                  994 	.db #0xE3	; 227
   2A12 F3                  995 	.db #0xF3	; 243
   2A13 F3                  996 	.db #0xF3	; 243
   2A14                     997 _map_tileset_052:
   2A14 C3                  998 	.db #0xC3	; 195
   2A15 C3                  999 	.db #0xC3	; 195
   2A16 C3                 1000 	.db #0xC3	; 195
   2A17 C3                 1001 	.db #0xC3	; 195
   2A18 C3                 1002 	.db #0xC3	; 195
   2A19 F3                 1003 	.db #0xF3	; 243
   2A1A F3                 1004 	.db #0xF3	; 243
   2A1B F3                 1005 	.db #0xF3	; 243
   2A1C                    1006 _map_tileset_053:
   2A1C C3                 1007 	.db #0xC3	; 195
   2A1D C3                 1008 	.db #0xC3	; 195
   2A1E C3                 1009 	.db #0xC3	; 195
   2A1F F3                 1010 	.db #0xF3	; 243
   2A20 F3                 1011 	.db #0xF3	; 243
   2A21 F3                 1012 	.db #0xF3	; 243
   2A22 F3                 1013 	.db #0xF3	; 243
   2A23 F3                 1014 	.db #0xF3	; 243
   2A24                    1015 _map_tileset_054:
   2A24 C3                 1016 	.db #0xC3	; 195
   2A25 C3                 1017 	.db #0xC3	; 195
   2A26 F3                 1018 	.db #0xF3	; 243
   2A27 F3                 1019 	.db #0xF3	; 243
   2A28 F3                 1020 	.db #0xF3	; 243
   2A29 F3                 1021 	.db #0xF3	; 243
   2A2A F3                 1022 	.db #0xF3	; 243
   2A2B F3                 1023 	.db #0xF3	; 243
   2A2C                    1024 _map_tileset_055:
   2A2C D3                 1025 	.db #0xD3	; 211
   2A2D F3                 1026 	.db #0xF3	; 243
   2A2E F3                 1027 	.db #0xF3	; 243
   2A2F F3                 1028 	.db #0xF3	; 243
   2A30 F3                 1029 	.db #0xF3	; 243
   2A31 F3                 1030 	.db #0xF3	; 243
   2A32 F3                 1031 	.db #0xF3	; 243
   2A33 F3                 1032 	.db #0xF3	; 243
   2A34                    1033 _map_tileset_056:
   2A34 E3                 1034 	.db #0xE3	; 227
   2A35 C3                 1035 	.db #0xC3	; 195
   2A36 F3                 1036 	.db #0xF3	; 243
   2A37 F3                 1037 	.db #0xF3	; 243
   2A38 F3                 1038 	.db #0xF3	; 243
   2A39 F3                 1039 	.db #0xF3	; 243
   2A3A F3                 1040 	.db #0xF3	; 243
   2A3B F3                 1041 	.db #0xF3	; 243
   2A3C                    1042 _map_tileset_057:
   2A3C C3                 1043 	.db #0xC3	; 195
   2A3D C3                 1044 	.db #0xC3	; 195
   2A3E E3                 1045 	.db #0xE3	; 227
   2A3F C3                 1046 	.db #0xC3	; 195
   2A40 F3                 1047 	.db #0xF3	; 243
   2A41 E3                 1048 	.db #0xE3	; 227
   2A42 F3                 1049 	.db #0xF3	; 243
   2A43 F3                 1050 	.db #0xF3	; 243
   2A44                    1051 _map_tileset_058:
   2A44 C3                 1052 	.db #0xC3	; 195
   2A45 C3                 1053 	.db #0xC3	; 195
   2A46 C3                 1054 	.db #0xC3	; 195
   2A47 C3                 1055 	.db #0xC3	; 195
   2A48 C3                 1056 	.db #0xC3	; 195
   2A49 C3                 1057 	.db #0xC3	; 195
   2A4A E3                 1058 	.db #0xE3	; 227
   2A4B C3                 1059 	.db #0xC3	; 195
   2A4C                    1060 _map_tileset_059:
   2A4C C0                 1061 	.db #0xC0	; 192
   2A4D C0                 1062 	.db #0xC0	; 192
   2A4E C0                 1063 	.db #0xC0	; 192
   2A4F C0                 1064 	.db #0xC0	; 192
   2A50 C0                 1065 	.db #0xC0	; 192
   2A51 D0                 1066 	.db #0xD0	; 208
   2A52 F0                 1067 	.db #0xF0	; 240
   2A53 F0                 1068 	.db #0xF0	; 240
   2A54                    1069 _map_tileset_060:
   2A54 86                 1070 	.db #0x86	; 134
   2A55 0C                 1071 	.db #0x0C	; 12
   2A56 C3                 1072 	.db #0xC3	; 195
   2A57 0C                 1073 	.db #0x0C	; 12
   2A58 C3                 1074 	.db #0xC3	; 195
   2A59 0C                 1075 	.db #0x0C	; 12
   2A5A C3                 1076 	.db #0xC3	; 195
   2A5B 86                 1077 	.db #0x86	; 134
   2A5C                    1078 _map_tileset_061:
   2A5C F3                 1079 	.db #0xF3	; 243
   2A5D F3                 1080 	.db #0xF3	; 243
   2A5E F3                 1081 	.db #0xF3	; 243
   2A5F F3                 1082 	.db #0xF3	; 243
   2A60 F3                 1083 	.db #0xF3	; 243
   2A61 E2                 1084 	.db #0xE2	; 226
   2A62 C0                 1085 	.db #0xC0	; 192
   2A63 C0                 1086 	.db #0xC0	; 192
   2A64                    1087 _map_tileset_062:
   2A64 F3                 1088 	.db #0xF3	; 243
   2A65 F3                 1089 	.db #0xF3	; 243
   2A66 F3                 1090 	.db #0xF3	; 243
   2A67 E2                 1091 	.db #0xE2	; 226
   2A68 C0                 1092 	.db #0xC0	; 192
   2A69 C0                 1093 	.db #0xC0	; 192
   2A6A C0                 1094 	.db #0xC0	; 192
   2A6B C0                 1095 	.db #0xC0	; 192
   2A6C                    1096 _map_tileset_063:
   2A6C F3                 1097 	.db #0xF3	; 243
   2A6D F3                 1098 	.db #0xF3	; 243
   2A6E F3                 1099 	.db #0xF3	; 243
   2A6F F3                 1100 	.db #0xF3	; 243
   2A70 C0                 1101 	.db #0xC0	; 192
   2A71 D1                 1102 	.db #0xD1	; 209
   2A72 C0                 1103 	.db #0xC0	; 192
   2A73 C0                 1104 	.db #0xC0	; 192
   2A74                    1105 _map_tileset_064:
   2A74 F3                 1106 	.db #0xF3	; 243
   2A75 F3                 1107 	.db #0xF3	; 243
   2A76 F3                 1108 	.db #0xF3	; 243
   2A77 F3                 1109 	.db #0xF3	; 243
   2A78 F3                 1110 	.db #0xF3	; 243
   2A79 F3                 1111 	.db #0xF3	; 243
   2A7A D1                 1112 	.db #0xD1	; 209
   2A7B F3                 1113 	.db #0xF3	; 243
   2A7C                    1114 _map_tileset_065:
   2A7C F3                 1115 	.db #0xF3	; 243
   2A7D F3                 1116 	.db #0xF3	; 243
   2A7E F3                 1117 	.db #0xF3	; 243
   2A7F F3                 1118 	.db #0xF3	; 243
   2A80 D1                 1119 	.db #0xD1	; 209
   2A81 F3                 1120 	.db #0xF3	; 243
   2A82 D1                 1121 	.db #0xD1	; 209
   2A83 F3                 1122 	.db #0xF3	; 243
   2A84                    1123 _map_tileset_066:
   2A84 F0                 1124 	.db #0xF0	; 240
   2A85 FF                 1125 	.db #0xFF	; 255
   2A86 B0                 1126 	.db #0xB0	; 176
   2A87 FF                 1127 	.db #0xFF	; 255
   2A88 30                 1128 	.db #0x30	; 48	'0'
   2A89 BA                 1129 	.db #0xBA	; 186
   2A8A 30                 1130 	.db #0x30	; 48	'0'
   2A8B FF                 1131 	.db #0xFF	; 255
   2A8C                    1132 _map_tileset_067:
   2A8C F5                 1133 	.db #0xF5	; 245
   2A8D F0                 1134 	.db #0xF0	; 240
   2A8E 75                 1135 	.db #0x75	; 117	'u'
   2A8F 30                 1136 	.db #0x30	; 48	'0'
   2A90 FF                 1137 	.db #0xFF	; 255
   2A91 30                 1138 	.db #0x30	; 48	'0'
   2A92 75                 1139 	.db #0x75	; 117	'u'
   2A93 30                 1140 	.db #0x30	; 48	'0'
   2A94                    1141 _map_tileset_068:
   2A94 F0                 1142 	.db #0xF0	; 240
   2A95 F0                 1143 	.db #0xF0	; 240
   2A96 F0                 1144 	.db #0xF0	; 240
   2A97 F0                 1145 	.db #0xF0	; 240
   2A98 70                 1146 	.db #0x70	; 112	'p'
   2A99 F0                 1147 	.db #0xF0	; 240
   2A9A 30                 1148 	.db #0x30	; 48	'0'
   2A9B F0                 1149 	.db #0xF0	; 240
   2A9C                    1150 _map_tileset_069:
   2A9C E3                 1151 	.db #0xE3	; 227
   2A9D C3                 1152 	.db #0xC3	; 195
   2A9E F3                 1153 	.db #0xF3	; 243
   2A9F C3                 1154 	.db #0xC3	; 195
   2AA0 F3                 1155 	.db #0xF3	; 243
   2AA1 C3                 1156 	.db #0xC3	; 195
   2AA2 F3                 1157 	.db #0xF3	; 243
   2AA3 C3                 1158 	.db #0xC3	; 195
   2AA4                    1159 _map_tileset_070:
   2AA4 C0                 1160 	.db #0xC0	; 192
   2AA5 C0                 1161 	.db #0xC0	; 192
   2AA6 C0                 1162 	.db #0xC0	; 192
   2AA7 C0                 1163 	.db #0xC0	; 192
   2AA8 95                 1164 	.db #0x95	; 149
   2AA9 C0                 1165 	.db #0xC0	; 192
   2AAA 95                 1166 	.db #0x95	; 149
   2AAB C0                 1167 	.db #0xC0	; 192
   2AAC                    1168 _map_tileset_071:
   2AAC F3                 1169 	.db #0xF3	; 243
   2AAD FF                 1170 	.db #0xFF	; 255
   2AAE F3                 1171 	.db #0xF3	; 243
   2AAF FF                 1172 	.db #0xFF	; 255
   2AB0 F3                 1173 	.db #0xF3	; 243
   2AB1 FB                 1174 	.db #0xFB	; 251
   2AB2 F3                 1175 	.db #0xF3	; 243
   2AB3 FF                 1176 	.db #0xFF	; 255
   2AB4                    1177 _map_tileset_072:
   2AB4 F7                 1178 	.db #0xF7	; 247
   2AB5 F3                 1179 	.db #0xF3	; 243
   2AB6 F7                 1180 	.db #0xF7	; 247
   2AB7 F3                 1181 	.db #0xF3	; 243
   2AB8 FF                 1182 	.db #0xFF	; 255
   2AB9 F3                 1183 	.db #0xF3	; 243
   2ABA F7                 1184 	.db #0xF7	; 247
   2ABB F3                 1185 	.db #0xF3	; 243
   2ABC                    1186 _map_tileset_073:
   2ABC E3                 1187 	.db #0xE3	; 227
   2ABD C3                 1188 	.db #0xC3	; 195
   2ABE E3                 1189 	.db #0xE3	; 227
   2ABF C3                 1190 	.db #0xC3	; 195
   2AC0 E3                 1191 	.db #0xE3	; 227
   2AC1 C3                 1192 	.db #0xC3	; 195
   2AC2 F3                 1193 	.db #0xF3	; 243
   2AC3 C3                 1194 	.db #0xC3	; 195
   2AC4                    1195 _map_tileset_074:
   2AC4 C3                 1196 	.db #0xC3	; 195
   2AC5 C3                 1197 	.db #0xC3	; 195
   2AC6 E3                 1198 	.db #0xE3	; 227
   2AC7 C3                 1199 	.db #0xC3	; 195
   2AC8 E3                 1200 	.db #0xE3	; 227
   2AC9 C3                 1201 	.db #0xC3	; 195
   2ACA F3                 1202 	.db #0xF3	; 243
   2ACB C3                 1203 	.db #0xC3	; 195
   2ACC                    1204 _map_tileset_075:
   2ACC EB                 1205 	.db #0xEB	; 235
   2ACD C3                 1206 	.db #0xC3	; 195
   2ACE EB                 1207 	.db #0xEB	; 235
   2ACF C3                 1208 	.db #0xC3	; 195
   2AD0 EB                 1209 	.db #0xEB	; 235
   2AD1 C3                 1210 	.db #0xC3	; 195
   2AD2 EB                 1211 	.db #0xEB	; 235
   2AD3 C3                 1212 	.db #0xC3	; 195
   2AD4                    1213 _map_tileset_076:
   2AD4 FA                 1214 	.db #0xFA	; 250
   2AD5 F0                 1215 	.db #0xF0	; 240
   2AD6 FA                 1216 	.db #0xFA	; 250
   2AD7 F0                 1217 	.db #0xF0	; 240
   2AD8 FA                 1218 	.db #0xFA	; 250
   2AD9 F0                 1219 	.db #0xF0	; 240
   2ADA FA                 1220 	.db #0xFA	; 250
   2ADB F0                 1221 	.db #0xF0	; 240
   2ADC                    1222 _map_tileset_077:
   2ADC C3                 1223 	.db #0xC3	; 195
   2ADD C3                 1224 	.db #0xC3	; 195
   2ADE C3                 1225 	.db #0xC3	; 195
   2ADF C3                 1226 	.db #0xC3	; 195
   2AE0 C3                 1227 	.db #0xC3	; 195
   2AE1 C3                 1228 	.db #0xC3	; 195
   2AE2 E3                 1229 	.db #0xE3	; 227
   2AE3 C3                 1230 	.db #0xC3	; 195
   2AE4                    1231 _map_tileset_078:
   2AE4 C3                 1232 	.db #0xC3	; 195
   2AE5 0C                 1233 	.db #0x0C	; 12
   2AE6 C3                 1234 	.db #0xC3	; 195
   2AE7 0C                 1235 	.db #0x0C	; 12
   2AE8 C3                 1236 	.db #0xC3	; 195
   2AE9 0C                 1237 	.db #0x0C	; 12
   2AEA C3                 1238 	.db #0xC3	; 195
   2AEB 86                 1239 	.db #0x86	; 134
   2AEC                    1240 _map_tileset_079:
   2AEC 0C                 1241 	.db #0x0C	; 12
   2AED 5D                 1242 	.db #0x5D	; 93
   2AEE 0C                 1243 	.db #0x0C	; 12
   2AEF 5D                 1244 	.db #0x5D	; 93
   2AF0 0C                 1245 	.db #0x0C	; 12
   2AF1 D7                 1246 	.db #0xD7	; 215
   2AF2 0C                 1247 	.db #0x0C	; 12
   2AF3 D7                 1248 	.db #0xD7	; 215
   2AF4                    1249 _map_tileset_080:
   2AF4 F0                 1250 	.db #0xF0	; 240
   2AF5 F0                 1251 	.db #0xF0	; 240
   2AF6 70                 1252 	.db #0x70	; 112	'p'
   2AF7 F0                 1253 	.db #0xF0	; 240
   2AF8 30                 1254 	.db #0x30	; 48	'0'
   2AF9 F0                 1255 	.db #0xF0	; 240
   2AFA 30                 1256 	.db #0x30	; 48	'0'
   2AFB 70                 1257 	.db #0x70	; 112	'p'
   2AFC                    1258 _map_tileset_081:
   2AFC F3                 1259 	.db #0xF3	; 243
   2AFD F3                 1260 	.db #0xF3	; 243
   2AFE F3                 1261 	.db #0xF3	; 243
   2AFF F3                 1262 	.db #0xF3	; 243
   2B00 F3                 1263 	.db #0xF3	; 243
   2B01 F3                 1264 	.db #0xF3	; 243
   2B02 F3                 1265 	.db #0xF3	; 243
   2B03 E2                 1266 	.db #0xE2	; 226
   2B04                    1267 _map_tileset_082:
   2B04 F3                 1268 	.db #0xF3	; 243
   2B05 F3                 1269 	.db #0xF3	; 243
   2B06 F3                 1270 	.db #0xF3	; 243
   2B07 F3                 1271 	.db #0xF3	; 243
   2B08 F3                 1272 	.db #0xF3	; 243
   2B09 C0                 1273 	.db #0xC0	; 192
   2B0A C0                 1274 	.db #0xC0	; 192
   2B0B C0                 1275 	.db #0xC0	; 192
   2B0C                    1276 _map_tileset_083:
   2B0C F3                 1277 	.db #0xF3	; 243
   2B0D C0                 1278 	.db #0xC0	; 192
   2B0E C0                 1279 	.db #0xC0	; 192
   2B0F C0                 1280 	.db #0xC0	; 192
   2B10 C0                 1281 	.db #0xC0	; 192
   2B11 C0                 1282 	.db #0xC0	; 192
   2B12 C0                 1283 	.db #0xC0	; 192
   2B13 C0                 1284 	.db #0xC0	; 192
   2B14                    1285 _map_tileset_084:
   2B14 0C                 1286 	.db #0x0C	; 12
   2B15 5D                 1287 	.db #0x5D	; 93
   2B16 0C                 1288 	.db #0x0C	; 12
   2B17 5D                 1289 	.db #0x5D	; 93
   2B18 0C                 1290 	.db #0x0C	; 12
   2B19 5D                 1291 	.db #0x5D	; 93
   2B1A 0C                 1292 	.db #0x0C	; 12
   2B1B 5D                 1293 	.db #0x5D	; 93
   2B1C                    1294 _map_tileset_085:
   2B1C C0                 1295 	.db #0xC0	; 192
   2B1D F3                 1296 	.db #0xF3	; 243
   2B1E C0                 1297 	.db #0xC0	; 192
   2B1F F3                 1298 	.db #0xF3	; 243
   2B20 C0                 1299 	.db #0xC0	; 192
   2B21 F3                 1300 	.db #0xF3	; 243
   2B22 C0                 1301 	.db #0xC0	; 192
   2B23 F3                 1302 	.db #0xF3	; 243
   2B24                    1303 _map_tileset_086:
   2B24 C0                 1304 	.db #0xC0	; 192
   2B25 F3                 1305 	.db #0xF3	; 243
   2B26 C0                 1306 	.db #0xC0	; 192
   2B27 F3                 1307 	.db #0xF3	; 243
   2B28 C0                 1308 	.db #0xC0	; 192
   2B29 D1                 1309 	.db #0xD1	; 209
   2B2A C0                 1310 	.db #0xC0	; 192
   2B2B C0                 1311 	.db #0xC0	; 192
   2B2C                    1312 _map_tileset_087:
   2B2C D1                 1313 	.db #0xD1	; 209
   2B2D F3                 1314 	.db #0xF3	; 243
   2B2E D1                 1315 	.db #0xD1	; 209
   2B2F F3                 1316 	.db #0xF3	; 243
   2B30 D1                 1317 	.db #0xD1	; 209
   2B31 F3                 1318 	.db #0xF3	; 243
   2B32 C0                 1319 	.db #0xC0	; 192
   2B33 F3                 1320 	.db #0xF3	; 243
   2B34                    1321 _map_tileset_088:
   2B34 30                 1322 	.db #0x30	; 48	'0'
   2B35 EF                 1323 	.db #0xEF	; 239
   2B36 30                 1324 	.db #0x30	; 48	'0'
   2B37 BA                 1325 	.db #0xBA	; 186
   2B38 30                 1326 	.db #0x30	; 48	'0'
   2B39 FF                 1327 	.db #0xFF	; 255
   2B3A 30                 1328 	.db #0x30	; 48	'0'
   2B3B FF                 1329 	.db #0xFF	; 255
   2B3C                    1330 _map_tileset_089:
   2B3C 75                 1331 	.db #0x75	; 117	'u'
   2B3D 30                 1332 	.db #0x30	; 48	'0'
   2B3E FF                 1333 	.db #0xFF	; 255
   2B3F 30                 1334 	.db #0x30	; 48	'0'
   2B40 75                 1335 	.db #0x75	; 117	'u'
   2B41 30                 1336 	.db #0x30	; 48	'0'
   2B42 75                 1337 	.db #0x75	; 117	'u'
   2B43 30                 1338 	.db #0x30	; 48	'0'
   2B44                    1339 _map_tileset_090:
   2B44 86                 1340 	.db #0x86	; 134
   2B45 0C                 1341 	.db #0x0C	; 12
   2B46 86                 1342 	.db #0x86	; 134
   2B47 0C                 1343 	.db #0x0C	; 12
   2B48 86                 1344 	.db #0x86	; 134
   2B49 0C                 1345 	.db #0x0C	; 12
   2B4A 86                 1346 	.db #0x86	; 134
   2B4B 0C                 1347 	.db #0x0C	; 12
   2B4C                    1348 _map_tileset_091:
   2B4C F3                 1349 	.db #0xF3	; 243
   2B4D C3                 1350 	.db #0xC3	; 195
   2B4E F3                 1351 	.db #0xF3	; 243
   2B4F C3                 1352 	.db #0xC3	; 195
   2B50 F3                 1353 	.db #0xF3	; 243
   2B51 C3                 1354 	.db #0xC3	; 195
   2B52 F3                 1355 	.db #0xF3	; 243
   2B53 C3                 1356 	.db #0xC3	; 195
   2B54                    1357 _map_tileset_092:
   2B54 3F                 1358 	.db #0x3F	; 63
   2B55 6A                 1359 	.db #0x6A	; 106	'j'
   2B56 3F                 1360 	.db #0x3F	; 63
   2B57 6A                 1361 	.db #0x6A	; 106	'j'
   2B58 95                 1362 	.db #0x95	; 149
   2B59 C0                 1363 	.db #0xC0	; 192
   2B5A 95                 1364 	.db #0x95	; 149
   2B5B C0                 1365 	.db #0xC0	; 192
   2B5C                    1366 _map_tileset_093:
   2B5C F3                 1367 	.db #0xF3	; 243
   2B5D EF                 1368 	.db #0xEF	; 239
   2B5E F3                 1369 	.db #0xF3	; 243
   2B5F FB                 1370 	.db #0xFB	; 251
   2B60 F3                 1371 	.db #0xF3	; 243
   2B61 FF                 1372 	.db #0xFF	; 255
   2B62 F3                 1373 	.db #0xF3	; 243
   2B63 FF                 1374 	.db #0xFF	; 255
   2B64                    1375 _map_tileset_094:
   2B64 F7                 1376 	.db #0xF7	; 247
   2B65 F3                 1377 	.db #0xF3	; 243
   2B66 FF                 1378 	.db #0xFF	; 255
   2B67 F3                 1379 	.db #0xF3	; 243
   2B68 F7                 1380 	.db #0xF7	; 247
   2B69 F3                 1381 	.db #0xF3	; 243
   2B6A F7                 1382 	.db #0xF7	; 247
   2B6B F3                 1383 	.db #0xF3	; 243
   2B6C                    1384 _map_tileset_095:
   2B6C F3                 1385 	.db #0xF3	; 243
   2B6D C3                 1386 	.db #0xC3	; 195
   2B6E F3                 1387 	.db #0xF3	; 243
   2B6F E3                 1388 	.db #0xE3	; 227
   2B70 F3                 1389 	.db #0xF3	; 243
   2B71 E3                 1390 	.db #0xE3	; 227
   2B72 F3                 1391 	.db #0xF3	; 243
   2B73 F3                 1392 	.db #0xF3	; 243
   2B74                    1393 _map_tileset_096:
   2B74 F3                 1394 	.db #0xF3	; 243
   2B75 E3                 1395 	.db #0xE3	; 227
   2B76 F3                 1396 	.db #0xF3	; 243
   2B77 F3                 1397 	.db #0xF3	; 243
   2B78 F3                 1398 	.db #0xF3	; 243
   2B79 F3                 1399 	.db #0xF3	; 243
   2B7A F3                 1400 	.db #0xF3	; 243
   2B7B F3                 1401 	.db #0xF3	; 243
   2B7C                    1402 _map_tileset_097:
   2B7C C3                 1403 	.db #0xC3	; 195
   2B7D C3                 1404 	.db #0xC3	; 195
   2B7E E3                 1405 	.db #0xE3	; 227
   2B7F C3                 1406 	.db #0xC3	; 195
   2B80 F3                 1407 	.db #0xF3	; 243
   2B81 F3                 1408 	.db #0xF3	; 243
   2B82 F3                 1409 	.db #0xF3	; 243
   2B83 F3                 1410 	.db #0xF3	; 243
   2B84                    1411 _map_tileset_098:
   2B84 C3                 1412 	.db #0xC3	; 195
   2B85 C3                 1413 	.db #0xC3	; 195
   2B86 C3                 1414 	.db #0xC3	; 195
   2B87 F3                 1415 	.db #0xF3	; 243
   2B88 F3                 1416 	.db #0xF3	; 243
   2B89 F3                 1417 	.db #0xF3	; 243
   2B8A F3                 1418 	.db #0xF3	; 243
   2B8B F3                 1419 	.db #0xF3	; 243
   2B8C                    1420 _map_tileset_099:
   2B8C F3                 1421 	.db #0xF3	; 243
   2B8D C3                 1422 	.db #0xC3	; 195
   2B8E F3                 1423 	.db #0xF3	; 243
   2B8F C3                 1424 	.db #0xC3	; 195
   2B90 F3                 1425 	.db #0xF3	; 243
   2B91 E3                 1426 	.db #0xE3	; 227
   2B92 F3                 1427 	.db #0xF3	; 243
   2B93 E3                 1428 	.db #0xE3	; 227
   2B94                    1429 _map_tileset_100:
   2B94 C3                 1430 	.db #0xC3	; 195
   2B95 86                 1431 	.db #0x86	; 134
   2B96 C3                 1432 	.db #0xC3	; 195
   2B97 86                 1433 	.db #0x86	; 134
   2B98 C3                 1434 	.db #0xC3	; 195
   2B99 86                 1435 	.db #0x86	; 134
   2B9A C3                 1436 	.db #0xC3	; 195
   2B9B C3                 1437 	.db #0xC3	; 195
   2B9C                    1438 _map_tileset_101:
   2B9C 49                 1439 	.db #0x49	; 73	'I'
   2B9D D7                 1440 	.db #0xD7	; 215
   2B9E C3                 1441 	.db #0xC3	; 195
   2B9F D7                 1442 	.db #0xD7	; 215
   2BA0 C3                 1443 	.db #0xC3	; 195
   2BA1 D7                 1444 	.db #0xD7	; 215
   2BA2 C3                 1445 	.db #0xC3	; 195
   2BA3 D7                 1446 	.db #0xD7	; 215
   2BA4                    1447 _map_tileset_102:
   2BA4 30                 1448 	.db #0x30	; 48	'0'
   2BA5 70                 1449 	.db #0x70	; 112	'p'
   2BA6 30                 1450 	.db #0x30	; 48	'0'
   2BA7 30                 1451 	.db #0x30	; 48	'0'
   2BA8 30                 1452 	.db #0x30	; 48	'0'
   2BA9 30                 1453 	.db #0x30	; 48	'0'
   2BAA 30                 1454 	.db #0x30	; 48	'0'
   2BAB 30                 1455 	.db #0x30	; 48	'0'
   2BAC                    1456 _map_tileset_103:
   2BAC F0                 1457 	.db #0xF0	; 240
   2BAD F0                 1458 	.db #0xF0	; 240
   2BAE F0                 1459 	.db #0xF0	; 240
   2BAF F0                 1460 	.db #0xF0	; 240
   2BB0 F0                 1461 	.db #0xF0	; 240
   2BB1 F0                 1462 	.db #0xF0	; 240
   2BB2 70                 1463 	.db #0x70	; 112	'p'
   2BB3 F0                 1464 	.db #0xF0	; 240
   2BB4                    1465 _map_tileset_104:
   2BB4 F0                 1466 	.db #0xF0	; 240
   2BB5 C0                 1467 	.db #0xC0	; 192
   2BB6 F0                 1468 	.db #0xF0	; 240
   2BB7 C0                 1469 	.db #0xC0	; 192
   2BB8 F0                 1470 	.db #0xF0	; 240
   2BB9 C0                 1471 	.db #0xC0	; 192
   2BBA F0                 1472 	.db #0xF0	; 240
   2BBB C0                 1473 	.db #0xC0	; 192
   2BBC                    1474 _map_tileset_105:
   2BBC F3                 1475 	.db #0xF3	; 243
   2BBD F3                 1476 	.db #0xF3	; 243
   2BBE F3                 1477 	.db #0xF3	; 243
   2BBF F3                 1478 	.db #0xF3	; 243
   2BC0 D1                 1479 	.db #0xD1	; 209
   2BC1 F3                 1480 	.db #0xF3	; 243
   2BC2 C0                 1481 	.db #0xC0	; 192
   2BC3 D1                 1482 	.db #0xD1	; 209
   2BC4                    1483 _map_tileset_106:
   2BC4 F3                 1484 	.db #0xF3	; 243
   2BC5 F3                 1485 	.db #0xF3	; 243
   2BC6 C0                 1486 	.db #0xC0	; 192
   2BC7 C0                 1487 	.db #0xC0	; 192
   2BC8 C0                 1488 	.db #0xC0	; 192
   2BC9 C0                 1489 	.db #0xC0	; 192
   2BCA C0                 1490 	.db #0xC0	; 192
   2BCB C0                 1491 	.db #0xC0	; 192
   2BCC                    1492 _map_tileset_107:
   2BCC C0                 1493 	.db #0xC0	; 192
   2BCD D1                 1494 	.db #0xD1	; 209
   2BCE C0                 1495 	.db #0xC0	; 192
   2BCF D1                 1496 	.db #0xD1	; 209
   2BD0 C0                 1497 	.db #0xC0	; 192
   2BD1 C0                 1498 	.db #0xC0	; 192
   2BD2 C0                 1499 	.db #0xC0	; 192
   2BD3 C0                 1500 	.db #0xC0	; 192
   2BD4                    1501 _map_tileset_108:
   2BD4 D1                 1502 	.db #0xD1	; 209
   2BD5 F3                 1503 	.db #0xF3	; 243
   2BD6 C0                 1504 	.db #0xC0	; 192
   2BD7 F3                 1505 	.db #0xF3	; 243
   2BD8 C0                 1506 	.db #0xC0	; 192
   2BD9 F3                 1507 	.db #0xF3	; 243
   2BDA C0                 1508 	.db #0xC0	; 192
   2BDB D1                 1509 	.db #0xD1	; 209
   2BDC                    1510 _map_tileset_109:
   2BDC F3                 1511 	.db #0xF3	; 243
   2BDD F3                 1512 	.db #0xF3	; 243
   2BDE D1                 1513 	.db #0xD1	; 209
   2BDF F3                 1514 	.db #0xF3	; 243
   2BE0 C0                 1515 	.db #0xC0	; 192
   2BE1 F3                 1516 	.db #0xF3	; 243
   2BE2 C0                 1517 	.db #0xC0	; 192
   2BE3 D1                 1518 	.db #0xD1	; 209
   2BE4                    1519 _map_tileset_110:
   2BE4 30                 1520 	.db #0x30	; 48	'0'
   2BE5 BA                 1521 	.db #0xBA	; 186
   2BE6 30                 1522 	.db #0x30	; 48	'0'
   2BE7 FF                 1523 	.db #0xFF	; 255
   2BE8 30                 1524 	.db #0x30	; 48	'0'
   2BE9 EF                 1525 	.db #0xEF	; 239
   2BEA 30                 1526 	.db #0x30	; 48	'0'
   2BEB BA                 1527 	.db #0xBA	; 186
   2BEC                    1528 _map_tileset_111:
   2BEC FF                 1529 	.db #0xFF	; 255
   2BED 30                 1530 	.db #0x30	; 48	'0'
   2BEE 75                 1531 	.db #0x75	; 117	'u'
   2BEF 30                 1532 	.db #0x30	; 48	'0'
   2BF0 75                 1533 	.db #0x75	; 117	'u'
   2BF1 30                 1534 	.db #0x30	; 48	'0'
   2BF2 FF                 1535 	.db #0xFF	; 255
   2BF3 30                 1536 	.db #0x30	; 48	'0'
   2BF4                    1537 _map_tileset_112:
   2BF4 C3                 1538 	.db #0xC3	; 195
   2BF5 0C                 1539 	.db #0x0C	; 12
   2BF6 C3                 1540 	.db #0xC3	; 195
   2BF7 0C                 1541 	.db #0x0C	; 12
   2BF8 C3                 1542 	.db #0xC3	; 195
   2BF9 0C                 1543 	.db #0x0C	; 12
   2BFA C3                 1544 	.db #0xC3	; 195
   2BFB 0C                 1545 	.db #0x0C	; 12
   2BFC                    1546 _map_tileset_113:
   2BFC F3                 1547 	.db #0xF3	; 243
   2BFD C3                 1548 	.db #0xC3	; 195
   2BFE F3                 1549 	.db #0xF3	; 243
   2BFF E3                 1550 	.db #0xE3	; 227
   2C00 F3                 1551 	.db #0xF3	; 243
   2C01 E3                 1552 	.db #0xE3	; 227
   2C02 F3                 1553 	.db #0xF3	; 243
   2C03 E3                 1554 	.db #0xE3	; 227
   2C04                    1555 _map_tileset_114:
   2C04 C3                 1556 	.db #0xC3	; 195
   2C05 D7                 1557 	.db #0xD7	; 215
   2C06 C3                 1558 	.db #0xC3	; 195
   2C07 D7                 1559 	.db #0xD7	; 215
   2C08 C3                 1560 	.db #0xC3	; 195
   2C09 D7                 1561 	.db #0xD7	; 215
   2C0A C3                 1562 	.db #0xC3	; 195
   2C0B D7                 1563 	.db #0xD7	; 215
   2C0C                    1564 _map_tileset_115:
   2C0C F3                 1565 	.db #0xF3	; 243
   2C0D FB                 1566 	.db #0xFB	; 251
   2C0E D1                 1567 	.db #0xD1	; 209
   2C0F FF                 1568 	.db #0xFF	; 255
   2C10 D1                 1569 	.db #0xD1	; 209
   2C11 EF                 1570 	.db #0xEF	; 239
   2C12 C0                 1571 	.db #0xC0	; 192
   2C13 FB                 1572 	.db #0xFB	; 251
   2C14                    1573 _map_tileset_116:
   2C14 FF                 1574 	.db #0xFF	; 255
   2C15 F3                 1575 	.db #0xF3	; 243
   2C16 F7                 1576 	.db #0xF7	; 247
   2C17 F3                 1577 	.db #0xF3	; 243
   2C18 F7                 1578 	.db #0xF7	; 247
   2C19 F3                 1579 	.db #0xF3	; 243
   2C1A FF                 1580 	.db #0xFF	; 255
   2C1B F3                 1581 	.db #0xF3	; 243
   2C1C                    1582 _map_tileset_117:
   2C1C C0                 1583 	.db #0xC0	; 192
   2C1D EA                 1584 	.db #0xEA	; 234
   2C1E C0                 1585 	.db #0xC0	; 192
   2C1F FF                 1586 	.db #0xFF	; 255
   2C20 C0                 1587 	.db #0xC0	; 192
   2C21 EF                 1588 	.db #0xEF	; 239
   2C22 C0                 1589 	.db #0xC0	; 192
   2C23 EA                 1590 	.db #0xEA	; 234
   2C24                    1591 _map_tileset_118:
   2C24 FF                 1592 	.db #0xFF	; 255
   2C25 C0                 1593 	.db #0xC0	; 192
   2C26 D5                 1594 	.db #0xD5	; 213
   2C27 C0                 1595 	.db #0xC0	; 192
   2C28 D5                 1596 	.db #0xD5	; 213
   2C29 C0                 1597 	.db #0xC0	; 192
   2C2A FF                 1598 	.db #0xFF	; 255
   2C2B C0                 1599 	.db #0xC0	; 192
   2C2C                    1600 _map_tileset_119:
   2C2C F3                 1601 	.db #0xF3	; 243
   2C2D C3                 1602 	.db #0xC3	; 195
   2C2E F3                 1603 	.db #0xF3	; 243
   2C2F E3                 1604 	.db #0xE3	; 227
   2C30 F3                 1605 	.db #0xF3	; 243
   2C31 F3                 1606 	.db #0xF3	; 243
   2C32 F3                 1607 	.db #0xF3	; 243
   2C33 F3                 1608 	.db #0xF3	; 243
   2C34                    1609 _map_tileset_120:
   2C34 F0                 1610 	.db #0xF0	; 240
   2C35 F0                 1611 	.db #0xF0	; 240
   2C36 30                 1612 	.db #0x30	; 48	'0'
   2C37 70                 1613 	.db #0x70	; 112	'p'
   2C38 30                 1614 	.db #0x30	; 48	'0'
   2C39 30                 1615 	.db #0x30	; 48	'0'
   2C3A 30                 1616 	.db #0x30	; 48	'0'
   2C3B 30                 1617 	.db #0x30	; 48	'0'
   2C3C                    1618 _map_tileset_121:
   2C3C F0                 1619 	.db #0xF0	; 240
   2C3D F0                 1620 	.db #0xF0	; 240
   2C3E F0                 1621 	.db #0xF0	; 240
   2C3F F0                 1622 	.db #0xF0	; 240
   2C40 70                 1623 	.db #0x70	; 112	'p'
   2C41 F0                 1624 	.db #0xF0	; 240
   2C42 30                 1625 	.db #0x30	; 48	'0'
   2C43 70                 1626 	.db #0x70	; 112	'p'
   2C44                    1627 _map_tileset_122:
   2C44 92                 1628 	.db #0x92	; 146
   2C45 30                 1629 	.db #0x30	; 48	'0'
   2C46 92                 1630 	.db #0x92	; 146
   2C47 30                 1631 	.db #0x30	; 48	'0'
   2C48 92                 1632 	.db #0x92	; 146
   2C49 30                 1633 	.db #0x30	; 48	'0'
   2C4A 92                 1634 	.db #0x92	; 146
   2C4B 30                 1635 	.db #0x30	; 48	'0'
   2C4C                    1636 _map_tileset_123:
   2C4C F0                 1637 	.db #0xF0	; 240
   2C4D F0                 1638 	.db #0xF0	; 240
   2C4E 30                 1639 	.db #0x30	; 48	'0'
   2C4F 30                 1640 	.db #0x30	; 48	'0'
   2C50 30                 1641 	.db #0x30	; 48	'0'
   2C51 30                 1642 	.db #0x30	; 48	'0'
   2C52 30                 1643 	.db #0x30	; 48	'0'
   2C53 30                 1644 	.db #0x30	; 48	'0'
   2C54                    1645 _map_tileset_124:
   2C54 30                 1646 	.db #0x30	; 48	'0'
   2C55 F0                 1647 	.db #0xF0	; 240
   2C56 30                 1648 	.db #0x30	; 48	'0'
   2C57 70                 1649 	.db #0x70	; 112	'p'
   2C58 30                 1650 	.db #0x30	; 48	'0'
   2C59 70                 1651 	.db #0x70	; 112	'p'
   2C5A 30                 1652 	.db #0x30	; 48	'0'
   2C5B 70                 1653 	.db #0x70	; 112	'p'
   2C5C                    1654 _map_tileset_125:
   2C5C 70                 1655 	.db #0x70	; 112	'p'
   2C5D F0                 1656 	.db #0xF0	; 240
   2C5E 30                 1657 	.db #0x30	; 48	'0'
   2C5F F0                 1658 	.db #0xF0	; 240
   2C60 30                 1659 	.db #0x30	; 48	'0'
   2C61 F0                 1660 	.db #0xF0	; 240
   2C62 30                 1661 	.db #0x30	; 48	'0'
   2C63 70                 1662 	.db #0x70	; 112	'p'
   2C64                    1663 _map_tileset_126:
   2C64 F0                 1664 	.db #0xF0	; 240
   2C65 C0                 1665 	.db #0xC0	; 192
   2C66 F0                 1666 	.db #0xF0	; 240
   2C67 C0                 1667 	.db #0xC0	; 192
   2C68 F0                 1668 	.db #0xF0	; 240
   2C69 C0                 1669 	.db #0xC0	; 192
   2C6A F0                 1670 	.db #0xF0	; 240
   2C6B E0                 1671 	.db #0xE0	; 224
   2C6C                    1672 _map_tileset_127:
   2C6C C0                 1673 	.db #0xC0	; 192
   2C6D C0                 1674 	.db #0xC0	; 192
   2C6E E0                 1675 	.db #0xE0	; 224
   2C6F C0                 1676 	.db #0xC0	; 192
   2C70 F0                 1677 	.db #0xF0	; 240
   2C71 E0                 1678 	.db #0xE0	; 224
   2C72 F0                 1679 	.db #0xF0	; 240
   2C73 F0                 1680 	.db #0xF0	; 240
   2C74                    1681 _map_tileset_128:
   2C74 E0                 1682 	.db #0xE0	; 224
   2C75 C0                 1683 	.db #0xC0	; 192
   2C76 F0                 1684 	.db #0xF0	; 240
   2C77 C0                 1685 	.db #0xC0	; 192
   2C78 F0                 1686 	.db #0xF0	; 240
   2C79 E0                 1687 	.db #0xE0	; 224
   2C7A F0                 1688 	.db #0xF0	; 240
   2C7B F0                 1689 	.db #0xF0	; 240
   2C7C                    1690 _map_tileset_129:
   2C7C D1                 1691 	.db #0xD1	; 209
   2C7D F3                 1692 	.db #0xF3	; 243
   2C7E C0                 1693 	.db #0xC0	; 192
   2C7F C0                 1694 	.db #0xC0	; 192
   2C80 C0                 1695 	.db #0xC0	; 192
   2C81 C0                 1696 	.db #0xC0	; 192
   2C82 C0                 1697 	.db #0xC0	; 192
   2C83 C0                 1698 	.db #0xC0	; 192
   2C84                    1699 _map_tileset_130:
   2C84 F3                 1700 	.db #0xF3	; 243
   2C85 F3                 1701 	.db #0xF3	; 243
   2C86 F3                 1702 	.db #0xF3	; 243
   2C87 F3                 1703 	.db #0xF3	; 243
   2C88 F3                 1704 	.db #0xF3	; 243
   2C89 F3                 1705 	.db #0xF3	; 243
   2C8A F3                 1706 	.db #0xF3	; 243
   2C8B F3                 1707 	.db #0xF3	; 243
   2C8C                    1708 _map_tileset_131:
   2C8C F3                 1709 	.db #0xF3	; 243
   2C8D F7                 1710 	.db #0xF7	; 247
   2C8E F3                 1711 	.db #0xF3	; 243
   2C8F D5                 1712 	.db #0xD5	; 213
   2C90 E2                 1713 	.db #0xE2	; 226
   2C91 D5                 1714 	.db #0xD5	; 213
   2C92 C0                 1715 	.db #0xC0	; 192
   2C93 D5                 1716 	.db #0xD5	; 213
   2C94                    1717 _map_tileset_132:
   2C94 30                 1718 	.db #0x30	; 48	'0'
   2C95 FF                 1719 	.db #0xFF	; 255
   2C96 30                 1720 	.db #0x30	; 48	'0'
   2C97 FF                 1721 	.db #0xFF	; 255
   2C98 30                 1722 	.db #0x30	; 48	'0'
   2C99 BA                 1723 	.db #0xBA	; 186
   2C9A 30                 1724 	.db #0x30	; 48	'0'
   2C9B FF                 1725 	.db #0xFF	; 255
   2C9C                    1726 _map_tileset_133:
   2C9C 75                 1727 	.db #0x75	; 117	'u'
   2C9D 30                 1728 	.db #0x30	; 48	'0'
   2C9E 75                 1729 	.db #0x75	; 117	'u'
   2C9F 30                 1730 	.db #0x30	; 48	'0'
   2CA0 FF                 1731 	.db #0xFF	; 255
   2CA1 30                 1732 	.db #0x30	; 48	'0'
   2CA2 75                 1733 	.db #0x75	; 117	'u'
   2CA3 30                 1734 	.db #0x30	; 48	'0'
   2CA4                    1735 _map_tileset_134:
   2CA4 C3                 1736 	.db #0xC3	; 195
   2CA5 86                 1737 	.db #0x86	; 134
   2CA6 C3                 1738 	.db #0xC3	; 195
   2CA7 86                 1739 	.db #0x86	; 134
   2CA8 C3                 1740 	.db #0xC3	; 195
   2CA9 C3                 1741 	.db #0xC3	; 195
   2CAA C3                 1742 	.db #0xC3	; 195
   2CAB C3                 1743 	.db #0xC3	; 195
   2CAC                    1744 _map_tileset_135:
   2CAC F3                 1745 	.db #0xF3	; 243
   2CAD E3                 1746 	.db #0xE3	; 227
   2CAE F3                 1747 	.db #0xF3	; 243
   2CAF E3                 1748 	.db #0xE3	; 227
   2CB0 F3                 1749 	.db #0xF3	; 243
   2CB1 E3                 1750 	.db #0xE3	; 227
   2CB2 F3                 1751 	.db #0xF3	; 243
   2CB3 E3                 1752 	.db #0xE3	; 227
   2CB4                    1753 _map_tileset_136:
   2CB4 C3                 1754 	.db #0xC3	; 195
   2CB5 D7                 1755 	.db #0xD7	; 215
   2CB6 C3                 1756 	.db #0xC3	; 195
   2CB7 D7                 1757 	.db #0xD7	; 215
   2CB8 C3                 1758 	.db #0xC3	; 195
   2CB9 D7                 1759 	.db #0xD7	; 215
   2CBA C3                 1760 	.db #0xC3	; 195
   2CBB F7                 1761 	.db #0xF7	; 247
   2CBC                    1762 _map_tileset_137:
   2CBC C0                 1763 	.db #0xC0	; 192
   2CBD FF                 1764 	.db #0xFF	; 255
   2CBE C0                 1765 	.db #0xC0	; 192
   2CBF FF                 1766 	.db #0xFF	; 255
   2CC0 C0                 1767 	.db #0xC0	; 192
   2CC1 EA                 1768 	.db #0xEA	; 234
   2CC2 C0                 1769 	.db #0xC0	; 192
   2CC3 FF                 1770 	.db #0xFF	; 255
   2CC4                    1771 _map_tileset_138:
   2CC4 F7                 1772 	.db #0xF7	; 247
   2CC5 F3                 1773 	.db #0xF3	; 243
   2CC6 F7                 1774 	.db #0xF7	; 247
   2CC7 F3                 1775 	.db #0xF3	; 243
   2CC8 FF                 1776 	.db #0xFF	; 255
   2CC9 F3                 1777 	.db #0xF3	; 243
   2CCA D5                 1778 	.db #0xD5	; 213
   2CCB F3                 1779 	.db #0xF3	; 243
   2CCC                    1780 _map_tileset_139:
   2CCC C0                 1781 	.db #0xC0	; 192
   2CCD FF                 1782 	.db #0xFF	; 255
   2CCE C0                 1783 	.db #0xC0	; 192
   2CCF FF                 1784 	.db #0xFF	; 255
   2CD0 C0                 1785 	.db #0xC0	; 192
   2CD1 EA                 1786 	.db #0xEA	; 234
   2CD2 C0                 1787 	.db #0xC0	; 192
   2CD3 FF                 1788 	.db #0xFF	; 255
   2CD4                    1789 _map_tileset_140:
   2CD4 D5                 1790 	.db #0xD5	; 213
   2CD5 C0                 1791 	.db #0xC0	; 192
   2CD6 D5                 1792 	.db #0xD5	; 213
   2CD7 C0                 1793 	.db #0xC0	; 192
   2CD8 FF                 1794 	.db #0xFF	; 255
   2CD9 C0                 1795 	.db #0xC0	; 192
   2CDA D5                 1796 	.db #0xD5	; 213
   2CDB C0                 1797 	.db #0xC0	; 192
   2CDC                    1798 _map_tileset_141:
   2CDC C3                 1799 	.db #0xC3	; 195
   2CDD C3                 1800 	.db #0xC3	; 195
   2CDE C3                 1801 	.db #0xC3	; 195
   2CDF D3                 1802 	.db #0xD3	; 211
   2CE0 C3                 1803 	.db #0xC3	; 195
   2CE1 F3                 1804 	.db #0xF3	; 243
   2CE2 D3                 1805 	.db #0xD3	; 211
   2CE3 F3                 1806 	.db #0xF3	; 243
   2CE4                    1807 _map_tileset_142:
   2CE4 C3                 1808 	.db #0xC3	; 195
   2CE5 EF                 1809 	.db #0xEF	; 239
   2CE6 C3                 1810 	.db #0xC3	; 195
   2CE7 EB                 1811 	.db #0xEB	; 235
   2CE8 C3                 1812 	.db #0xC3	; 195
   2CE9 FF                 1813 	.db #0xFF	; 255
   2CEA C3                 1814 	.db #0xC3	; 195
   2CEB FF                 1815 	.db #0xFF	; 255
   2CEC                    1816 _map_tileset_143:
   2CEC D7                 1817 	.db #0xD7	; 215
   2CED C3                 1818 	.db #0xC3	; 195
   2CEE FF                 1819 	.db #0xFF	; 255
   2CEF C3                 1820 	.db #0xC3	; 195
   2CF0 D7                 1821 	.db #0xD7	; 215
   2CF1 C3                 1822 	.db #0xC3	; 195
   2CF2 D7                 1823 	.db #0xD7	; 215
   2CF3 C3                 1824 	.db #0xC3	; 195
   2CF4                    1825 _map_tileset_144:
   2CF4 C3                 1826 	.db #0xC3	; 195
   2CF5 30                 1827 	.db #0x30	; 48	'0'
   2CF6 C3                 1828 	.db #0xC3	; 195
   2CF7 30                 1829 	.db #0x30	; 48	'0'
   2CF8 C3                 1830 	.db #0xC3	; 195
   2CF9 30                 1831 	.db #0x30	; 48	'0'
   2CFA C3                 1832 	.db #0xC3	; 195
   2CFB 30                 1833 	.db #0x30	; 48	'0'
   2CFC                    1834 _map_tileset_145:
   2CFC 92                 1835 	.db #0x92	; 146
   2CFD 30                 1836 	.db #0x30	; 48	'0'
   2CFE C3                 1837 	.db #0xC3	; 195
   2CFF 30                 1838 	.db #0x30	; 48	'0'
   2D00 C3                 1839 	.db #0xC3	; 195
   2D01 92                 1840 	.db #0x92	; 146
   2D02 C3                 1841 	.db #0xC3	; 195
   2D03 C3                 1842 	.db #0xC3	; 195
   2D04                    1843 _map_tileset_146:
   2D04 30                 1844 	.db #0x30	; 48	'0'
   2D05 70                 1845 	.db #0x70	; 112	'p'
   2D06 30                 1846 	.db #0x30	; 48	'0'
   2D07 70                 1847 	.db #0x70	; 112	'p'
   2D08 30                 1848 	.db #0x30	; 48	'0'
   2D09 70                 1849 	.db #0x70	; 112	'p'
   2D0A 30                 1850 	.db #0x30	; 48	'0'
   2D0B 70                 1851 	.db #0x70	; 112	'p'
   2D0C                    1852 _map_tileset_147:
   2D0C 30                 1853 	.db #0x30	; 48	'0'
   2D0D 70                 1854 	.db #0x70	; 112	'p'
   2D0E 30                 1855 	.db #0x30	; 48	'0'
   2D0F 70                 1856 	.db #0x70	; 112	'p'
   2D10 30                 1857 	.db #0x30	; 48	'0'
   2D11 30                 1858 	.db #0x30	; 48	'0'
   2D12 30                 1859 	.db #0x30	; 48	'0'
   2D13 30                 1860 	.db #0x30	; 48	'0'
   2D14                    1861 _map_tileset_148:
   2D14 F0                 1862 	.db #0xF0	; 240
   2D15 E0                 1863 	.db #0xE0	; 224
   2D16 F0                 1864 	.db #0xF0	; 240
   2D17 E0                 1865 	.db #0xE0	; 224
   2D18 F0                 1866 	.db #0xF0	; 240
   2D19 E0                 1867 	.db #0xE0	; 224
   2D1A F0                 1868 	.db #0xF0	; 240
   2D1B E0                 1869 	.db #0xE0	; 224
   2D1C                    1870 _map_tileset_149:
   2D1C C0                 1871 	.db #0xC0	; 192
   2D1D C0                 1872 	.db #0xC0	; 192
   2D1E E0                 1873 	.db #0xE0	; 224
   2D1F C0                 1874 	.db #0xC0	; 192
   2D20 E0                 1875 	.db #0xE0	; 224
   2D21 C0                 1876 	.db #0xC0	; 192
   2D22 E0                 1877 	.db #0xE0	; 224
   2D23 C0                 1878 	.db #0xC0	; 192
   2D24                    1879 _map_tileset_150:
   2D24 C0                 1880 	.db #0xC0	; 192
   2D25 C0                 1881 	.db #0xC0	; 192
   2D26 E0                 1882 	.db #0xE0	; 224
   2D27 C0                 1883 	.db #0xC0	; 192
   2D28 E0                 1884 	.db #0xE0	; 224
   2D29 C0                 1885 	.db #0xC0	; 192
   2D2A F0                 1886 	.db #0xF0	; 240
   2D2B C0                 1887 	.db #0xC0	; 192
   2D2C                    1888 _map_tileset_151:
   2D2C F3                 1889 	.db #0xF3	; 243
   2D2D F3                 1890 	.db #0xF3	; 243
   2D2E F3                 1891 	.db #0xF3	; 243
   2D2F F3                 1892 	.db #0xF3	; 243
   2D30 C0                 1893 	.db #0xC0	; 192
   2D31 C0                 1894 	.db #0xC0	; 192
   2D32 C0                 1895 	.db #0xC0	; 192
   2D33 C0                 1896 	.db #0xC0	; 192
   2D34                    1897 _map_tileset_152:
   2D34 F3                 1898 	.db #0xF3	; 243
   2D35 E2                 1899 	.db #0xE2	; 226
   2D36 E2                 1900 	.db #0xE2	; 226
   2D37 C0                 1901 	.db #0xC0	; 192
   2D38 C0                 1902 	.db #0xC0	; 192
   2D39 C0                 1903 	.db #0xC0	; 192
   2D3A C0                 1904 	.db #0xC0	; 192
   2D3B C0                 1905 	.db #0xC0	; 192
   2D3C                    1906 _map_tileset_153:
   2D3C F3                 1907 	.db #0xF3	; 243
   2D3D F7                 1908 	.db #0xF7	; 247
   2D3E F3                 1909 	.db #0xF3	; 243
   2D3F F7                 1910 	.db #0xF7	; 247
   2D40 F3                 1911 	.db #0xF3	; 243
   2D41 F7                 1912 	.db #0xF7	; 247
   2D42 F3                 1913 	.db #0xF3	; 243
   2D43 F7                 1914 	.db #0xF7	; 247
   2D44                    1915 _map_tileset_154:
   2D44 30                 1916 	.db #0x30	; 48	'0'
   2D45 EF                 1917 	.db #0xEF	; 239
   2D46 30                 1918 	.db #0x30	; 48	'0'
   2D47 BA                 1919 	.db #0xBA	; 186
   2D48 30                 1920 	.db #0x30	; 48	'0'
   2D49 FF                 1921 	.db #0xFF	; 255
   2D4A C3                 1922 	.db #0xC3	; 195
   2D4B FF                 1923 	.db #0xFF	; 255
   2D4C                    1924 _map_tileset_155:
   2D4C 75                 1925 	.db #0x75	; 117	'u'
   2D4D 30                 1926 	.db #0x30	; 48	'0'
   2D4E FF                 1927 	.db #0xFF	; 255
   2D4F 30                 1928 	.db #0x30	; 48	'0'
   2D50 75                 1929 	.db #0x75	; 117	'u'
   2D51 30                 1930 	.db #0x30	; 48	'0'
   2D52 D7                 1931 	.db #0xD7	; 215
   2D53 92                 1932 	.db #0x92	; 146
   2D54                    1933 _map_tileset_156:
   2D54 FF                 1934 	.db #0xFF	; 255
   2D55 EA                 1935 	.db #0xEA	; 234
   2D56 FF                 1936 	.db #0xFF	; 255
   2D57 C0                 1937 	.db #0xC0	; 192
   2D58 FF                 1938 	.db #0xFF	; 255
   2D59 C0                 1939 	.db #0xC0	; 192
   2D5A EA                 1940 	.db #0xEA	; 234
   2D5B C0                 1941 	.db #0xC0	; 192
   2D5C                    1942 _map_tileset_157:
   2D5C 0C                 1943 	.db #0x0C	; 12
   2D5D C3                 1944 	.db #0xC3	; 195
   2D5E 0C                 1945 	.db #0x0C	; 12
   2D5F 49                 1946 	.db #0x49	; 73	'I'
   2D60 0C                 1947 	.db #0x0C	; 12
   2D61 49                 1948 	.db #0x49	; 73	'I'
   2D62 0C                 1949 	.db #0x0C	; 12
   2D63 0C                 1950 	.db #0x0C	; 12
   2D64                    1951 _map_tileset_158:
   2D64 C3                 1952 	.db #0xC3	; 195
   2D65 F7                 1953 	.db #0xF7	; 247
   2D66 D3                 1954 	.db #0xD3	; 211
   2D67 F7                 1955 	.db #0xF7	; 247
   2D68 D3                 1956 	.db #0xD3	; 211
   2D69 F7                 1957 	.db #0xF7	; 247
   2D6A F3                 1958 	.db #0xF3	; 243
   2D6B F7                 1959 	.db #0xF7	; 247
   2D6C                    1960 _map_tileset_159:
   2D6C C0                 1961 	.db #0xC0	; 192
   2D6D EF                 1962 	.db #0xEF	; 239
   2D6E C0                 1963 	.db #0xC0	; 192
   2D6F EA                 1964 	.db #0xEA	; 234
   2D70 C0                 1965 	.db #0xC0	; 192
   2D71 FF                 1966 	.db #0xFF	; 255
   2D72 C0                 1967 	.db #0xC0	; 192
   2D73 FF                 1968 	.db #0xFF	; 255
   2D74                    1969 _map_tileset_160:
   2D74 D5                 1970 	.db #0xD5	; 213
   2D75 F3                 1971 	.db #0xF3	; 243
   2D76 FF                 1972 	.db #0xFF	; 255
   2D77 D1                 1973 	.db #0xD1	; 209
   2D78 D5                 1974 	.db #0xD5	; 213
   2D79 C0                 1975 	.db #0xC0	; 192
   2D7A D5                 1976 	.db #0xD5	; 213
   2D7B C0                 1977 	.db #0xC0	; 192
   2D7C                    1978 _map_tileset_161:
   2D7C C0                 1979 	.db #0xC0	; 192
   2D7D EF                 1980 	.db #0xEF	; 239
   2D7E C0                 1981 	.db #0xC0	; 192
   2D7F EA                 1982 	.db #0xEA	; 234
   2D80 C0                 1983 	.db #0xC0	; 192
   2D81 FF                 1984 	.db #0xFF	; 255
   2D82 C0                 1985 	.db #0xC0	; 192
   2D83 FF                 1986 	.db #0xFF	; 255
   2D84                    1987 _map_tileset_162:
   2D84 D5                 1988 	.db #0xD5	; 213
   2D85 C0                 1989 	.db #0xC0	; 192
   2D86 FF                 1990 	.db #0xFF	; 255
   2D87 C0                 1991 	.db #0xC0	; 192
   2D88 D5                 1992 	.db #0xD5	; 213
   2D89 C0                 1993 	.db #0xC0	; 192
   2D8A D5                 1994 	.db #0xD5	; 213
   2D8B C0                 1995 	.db #0xC0	; 192
   2D8C                    1996 _map_tileset_163:
   2D8C C3                 1997 	.db #0xC3	; 195
   2D8D C3                 1998 	.db #0xC3	; 195
   2D8E 49                 1999 	.db #0x49	; 73	'I'
   2D8F C3                 2000 	.db #0xC3	; 195
   2D90 49                 2001 	.db #0x49	; 73	'I'
   2D91 C3                 2002 	.db #0xC3	; 195
   2D92 0C                 2003 	.db #0x0C	; 12
   2D93 C3                 2004 	.db #0xC3	; 195
   2D94                    2005 _map_tileset_164:
   2D94 C3                 2006 	.db #0xC3	; 195
   2D95 EB                 2007 	.db #0xEB	; 235
   2D96 C3                 2008 	.db #0xC3	; 195
   2D97 FF                 2009 	.db #0xFF	; 255
   2D98 C3                 2010 	.db #0xC3	; 195
   2D99 EF                 2011 	.db #0xEF	; 239
   2D9A C3                 2012 	.db #0xC3	; 195
   2D9B EB                 2013 	.db #0xEB	; 235
   2D9C                    2014 _map_tileset_165:
   2D9C FF                 2015 	.db #0xFF	; 255
   2D9D C3                 2016 	.db #0xC3	; 195
   2D9E D7                 2017 	.db #0xD7	; 215
   2D9F C3                 2018 	.db #0xC3	; 195
   2DA0 D7                 2019 	.db #0xD7	; 215
   2DA1 C3                 2020 	.db #0xC3	; 195
   2DA2 FF                 2021 	.db #0xFF	; 255
   2DA3 C3                 2022 	.db #0xC3	; 195
   2DA4                    2023 _map_tileset_166:
   2DA4 C3                 2024 	.db #0xC3	; 195
   2DA5 30                 2025 	.db #0x30	; 48	'0'
   2DA6 C3                 2026 	.db #0xC3	; 195
   2DA7 30                 2027 	.db #0x30	; 48	'0'
   2DA8 C3                 2028 	.db #0xC3	; 195
   2DA9 30                 2029 	.db #0x30	; 48	'0'
   2DAA C3                 2030 	.db #0xC3	; 195
   2DAB 92                 2031 	.db #0x92	; 146
   2DAC                    2032 _map_tileset_167:
   2DAC 92                 2033 	.db #0x92	; 146
   2DAD 30                 2034 	.db #0x30	; 48	'0'
   2DAE C3                 2035 	.db #0xC3	; 195
   2DAF 30                 2036 	.db #0x30	; 48	'0'
   2DB0 C3                 2037 	.db #0xC3	; 195
   2DB1 30                 2038 	.db #0x30	; 48	'0'
   2DB2 C3                 2039 	.db #0xC3	; 195
   2DB3 92                 2040 	.db #0x92	; 146
   2DB4                    2041 _map_tileset_168:
   2DB4 30                 2042 	.db #0x30	; 48	'0'
   2DB5 70                 2043 	.db #0x70	; 112	'p'
   2DB6 30                 2044 	.db #0x30	; 48	'0'
   2DB7 70                 2045 	.db #0x70	; 112	'p'
   2DB8 30                 2046 	.db #0x30	; 48	'0'
   2DB9 F0                 2047 	.db #0xF0	; 240
   2DBA 30                 2048 	.db #0x30	; 48	'0'
   2DBB F0                 2049 	.db #0xF0	; 240
   2DBC                    2050 _map_tileset_169:
   2DBC F0                 2051 	.db #0xF0	; 240
   2DBD F0                 2052 	.db #0xF0	; 240
   2DBE 70                 2053 	.db #0x70	; 112	'p'
   2DBF F0                 2054 	.db #0xF0	; 240
   2DC0 70                 2055 	.db #0x70	; 112	'p'
   2DC1 F0                 2056 	.db #0xF0	; 240
   2DC2 70                 2057 	.db #0x70	; 112	'p'
   2DC3 F0                 2058 	.db #0xF0	; 240
   2DC4                    2059 _map_tileset_170:
   2DC4 F0                 2060 	.db #0xF0	; 240
   2DC5 E0                 2061 	.db #0xE0	; 224
   2DC6 F0                 2062 	.db #0xF0	; 240
   2DC7 E0                 2063 	.db #0xE0	; 224
   2DC8 F0                 2064 	.db #0xF0	; 240
   2DC9 F0                 2065 	.db #0xF0	; 240
   2DCA F0                 2066 	.db #0xF0	; 240
   2DCB F0                 2067 	.db #0xF0	; 240
   2DCC                    2068 _map_tileset_171:
   2DCC E0                 2069 	.db #0xE0	; 224
   2DCD C0                 2070 	.db #0xC0	; 192
   2DCE E0                 2071 	.db #0xE0	; 224
   2DCF C0                 2072 	.db #0xC0	; 192
   2DD0 E0                 2073 	.db #0xE0	; 224
   2DD1 C0                 2074 	.db #0xC0	; 192
   2DD2 E0                 2075 	.db #0xE0	; 224
   2DD3 C0                 2076 	.db #0xC0	; 192
   2DD4                    2077 _map_tileset_172:
   2DD4 F0                 2078 	.db #0xF0	; 240
   2DD5 C0                 2079 	.db #0xC0	; 192
   2DD6 F0                 2080 	.db #0xF0	; 240
   2DD7 E0                 2081 	.db #0xE0	; 224
   2DD8 F0                 2082 	.db #0xF0	; 240
   2DD9 E0                 2083 	.db #0xE0	; 224
   2DDA F0                 2084 	.db #0xF0	; 240
   2DDB E0                 2085 	.db #0xE0	; 224
   2DDC                    2086 _map_tileset_173:
   2DDC C0                 2087 	.db #0xC0	; 192
   2DDD C0                 2088 	.db #0xC0	; 192
   2DDE C0                 2089 	.db #0xC0	; 192
   2DDF C0                 2090 	.db #0xC0	; 192
   2DE0 C0                 2091 	.db #0xC0	; 192
   2DE1 C0                 2092 	.db #0xC0	; 192
   2DE2 C0                 2093 	.db #0xC0	; 192
   2DE3 F0                 2094 	.db #0xF0	; 240
   2DE4                    2095 _map_tileset_174:
   2DE4 C0                 2096 	.db #0xC0	; 192
   2DE5 C0                 2097 	.db #0xC0	; 192
   2DE6 C0                 2098 	.db #0xC0	; 192
   2DE7 D0                 2099 	.db #0xD0	; 208
   2DE8 F0                 2100 	.db #0xF0	; 240
   2DE9 F0                 2101 	.db #0xF0	; 240
   2DEA F0                 2102 	.db #0xF0	; 240
   2DEB F0                 2103 	.db #0xF0	; 240
   2DEC                    2104 _map_tileset_175:
   2DEC C0                 2105 	.db #0xC0	; 192
   2DED F0                 2106 	.db #0xF0	; 240
   2DEE F0                 2107 	.db #0xF0	; 240
   2DEF F0                 2108 	.db #0xF0	; 240
   2DF0 F0                 2109 	.db #0xF0	; 240
   2DF1 F0                 2110 	.db #0xF0	; 240
   2DF2 F0                 2111 	.db #0xF0	; 240
   2DF3 F0                 2112 	.db #0xF0	; 240
   2DF4                    2113 _map_tileset_176:
   2DF4 AE                 2114 	.db #0xAE	; 174
   2DF5 0C                 2115 	.db #0x0C	; 12
   2DF6 AE                 2116 	.db #0xAE	; 174
   2DF7 0C                 2117 	.db #0x0C	; 12
   2DF8 AE                 2118 	.db #0xAE	; 174
   2DF9 0C                 2119 	.db #0x0C	; 12
   2DFA AE                 2120 	.db #0xAE	; 174
   2DFB 0C                 2121 	.db #0x0C	; 12
   2DFC                    2122 _map_tileset_177:
   2DFC 0C                 2123 	.db #0x0C	; 12
   2DFD 0C                 2124 	.db #0x0C	; 12
   2DFE 0C                 2125 	.db #0x0C	; 12
   2DFF 0C                 2126 	.db #0x0C	; 12
   2E00 0C                 2127 	.db #0x0C	; 12
   2E01 0C                 2128 	.db #0x0C	; 12
   2E02 0C                 2129 	.db #0x0C	; 12
   2E03 0C                 2130 	.db #0x0C	; 12
   2E04                    2131 _map_tileset_178:
   2E04 EA                 2132 	.db #0xEA	; 234
   2E05 C0                 2133 	.db #0xC0	; 192
   2E06 C0                 2134 	.db #0xC0	; 192
   2E07 C0                 2135 	.db #0xC0	; 192
   2E08 C0                 2136 	.db #0xC0	; 192
   2E09 C0                 2137 	.db #0xC0	; 192
   2E0A C0                 2138 	.db #0xC0	; 192
   2E0B C0                 2139 	.db #0xC0	; 192
   2E0C                    2140 _map_tileset_179:
   2E0C C3                 2141 	.db #0xC3	; 195
   2E0D C3                 2142 	.db #0xC3	; 195
   2E0E C3                 2143 	.db #0xC3	; 195
   2E0F C3                 2144 	.db #0xC3	; 195
   2E10 C3                 2145 	.db #0xC3	; 195
   2E11 C3                 2146 	.db #0xC3	; 195
   2E12 C3                 2147 	.db #0xC3	; 195
   2E13 C3                 2148 	.db #0xC3	; 195
   2E14                    2149 _map_tileset_180:
   2E14 30                 2150 	.db #0x30	; 48	'0'
   2E15 30                 2151 	.db #0x30	; 48	'0'
   2E16 30                 2152 	.db #0x30	; 48	'0'
   2E17 30                 2153 	.db #0x30	; 48	'0'
   2E18 92                 2154 	.db #0x92	; 146
   2E19 30                 2155 	.db #0x30	; 48	'0'
   2E1A C3                 2156 	.db #0xC3	; 195
   2E1B 30                 2157 	.db #0x30	; 48	'0'
   2E1C                    2158 _map_tileset_181:
   2E1C C3                 2159 	.db #0xC3	; 195
   2E1D 86                 2160 	.db #0x86	; 134
   2E1E C3                 2161 	.db #0xC3	; 195
   2E1F 0C                 2162 	.db #0x0C	; 12
   2E20 86                 2163 	.db #0x86	; 134
   2E21 0C                 2164 	.db #0x0C	; 12
   2E22 0C                 2165 	.db #0x0C	; 12
   2E23 0C                 2166 	.db #0x0C	; 12
   2E24                    2167 _map_tileset_182:
   2E24 C3                 2168 	.db #0xC3	; 195
   2E25 C3                 2169 	.db #0xC3	; 195
   2E26 C3                 2170 	.db #0xC3	; 195
   2E27 C3                 2171 	.db #0xC3	; 195
   2E28 C3                 2172 	.db #0xC3	; 195
   2E29 C3                 2173 	.db #0xC3	; 195
   2E2A 86                 2174 	.db #0x86	; 134
   2E2B 0C                 2175 	.db #0x0C	; 12
   2E2C                    2176 _map_tileset_183:
   2E2C C3                 2177 	.db #0xC3	; 195
   2E2D C3                 2178 	.db #0xC3	; 195
   2E2E C3                 2179 	.db #0xC3	; 195
   2E2F C3                 2180 	.db #0xC3	; 195
   2E30 0C                 2181 	.db #0x0C	; 12
   2E31 0C                 2182 	.db #0x0C	; 12
   2E32 0C                 2183 	.db #0x0C	; 12
   2E33 0C                 2184 	.db #0x0C	; 12
   2E34                    2185 _map_tileset_184:
   2E34 C3                 2186 	.db #0xC3	; 195
   2E35 C3                 2187 	.db #0xC3	; 195
   2E36 C3                 2188 	.db #0xC3	; 195
   2E37 C3                 2189 	.db #0xC3	; 195
   2E38 C3                 2190 	.db #0xC3	; 195
   2E39 C3                 2191 	.db #0xC3	; 195
   2E3A 0C                 2192 	.db #0x0C	; 12
   2E3B 49                 2193 	.db #0x49	; 73	'I'
   2E3C                    2194 _map_tileset_185:
   2E3C 0C                 2195 	.db #0x0C	; 12
   2E3D C3                 2196 	.db #0xC3	; 195
   2E3E 0C                 2197 	.db #0x0C	; 12
   2E3F 49                 2198 	.db #0x49	; 73	'I'
   2E40 0C                 2199 	.db #0x0C	; 12
   2E41 49                 2200 	.db #0x49	; 73	'I'
   2E42 0C                 2201 	.db #0x0C	; 12
   2E43 49                 2202 	.db #0x49	; 73	'I'
   2E44                    2203 _map_tileset_186:
   2E44 C3                 2204 	.db #0xC3	; 195
   2E45 FF                 2205 	.db #0xFF	; 255
   2E46 C3                 2206 	.db #0xC3	; 195
   2E47 FF                 2207 	.db #0xFF	; 255
   2E48 C3                 2208 	.db #0xC3	; 195
   2E49 EB                 2209 	.db #0xEB	; 235
   2E4A C3                 2210 	.db #0xC3	; 195
   2E4B FF                 2211 	.db #0xFF	; 255
   2E4C                    2212 _map_tileset_187:
   2E4C D7                 2213 	.db #0xD7	; 215
   2E4D C3                 2214 	.db #0xC3	; 195
   2E4E D7                 2215 	.db #0xD7	; 215
   2E4F C3                 2216 	.db #0xC3	; 195
   2E50 FF                 2217 	.db #0xFF	; 255
   2E51 C3                 2218 	.db #0xC3	; 195
   2E52 D7                 2219 	.db #0xD7	; 215
   2E53 C3                 2220 	.db #0xC3	; 195
   2E54                    2221 _map_tileset_188:
   2E54 C3                 2222 	.db #0xC3	; 195
   2E55 92                 2223 	.db #0x92	; 146
   2E56 C3                 2224 	.db #0xC3	; 195
   2E57 92                 2225 	.db #0x92	; 146
   2E58 C3                 2226 	.db #0xC3	; 195
   2E59 92                 2227 	.db #0x92	; 146
   2E5A C3                 2228 	.db #0xC3	; 195
   2E5B 92                 2229 	.db #0x92	; 146
   2E5C                    2230 _map_tileset_189:
   2E5C C3                 2231 	.db #0xC3	; 195
   2E5D 92                 2232 	.db #0x92	; 146
   2E5E C3                 2233 	.db #0xC3	; 195
   2E5F C3                 2234 	.db #0xC3	; 195
   2E60 C3                 2235 	.db #0xC3	; 195
   2E61 C3                 2236 	.db #0xC3	; 195
   2E62 C3                 2237 	.db #0xC3	; 195
   2E63 C3                 2238 	.db #0xC3	; 195
   2E64                    2239 _map_tileset_190:
   2E64 30                 2240 	.db #0x30	; 48	'0'
   2E65 F0                 2241 	.db #0xF0	; 240
   2E66 30                 2242 	.db #0x30	; 48	'0'
   2E67 F0                 2243 	.db #0xF0	; 240
   2E68 30                 2244 	.db #0x30	; 48	'0'
   2E69 F0                 2245 	.db #0xF0	; 240
   2E6A 30                 2246 	.db #0x30	; 48	'0'
   2E6B F0                 2247 	.db #0xF0	; 240
   2E6C                    2248 _map_tileset_191:
   2E6C 70                 2249 	.db #0x70	; 112	'p'
   2E6D F0                 2250 	.db #0xF0	; 240
   2E6E 70                 2251 	.db #0x70	; 112	'p'
   2E6F F0                 2252 	.db #0xF0	; 240
   2E70 30                 2253 	.db #0x30	; 48	'0'
   2E71 F0                 2254 	.db #0xF0	; 240
   2E72 30                 2255 	.db #0x30	; 48	'0'
   2E73 F0                 2256 	.db #0xF0	; 240
   2E74                    2257 _map_tileset_192:
   2E74 30                 2258 	.db #0x30	; 48	'0'
   2E75 61                 2259 	.db #0x61	; 97	'a'
   2E76 30                 2260 	.db #0x30	; 48	'0'
   2E77 C3                 2261 	.db #0xC3	; 195
   2E78 61                 2262 	.db #0x61	; 97	'a'
   2E79 C3                 2263 	.db #0xC3	; 195
   2E7A C3                 2264 	.db #0xC3	; 195
   2E7B C3                 2265 	.db #0xC3	; 195
   2E7C                    2266 _map_tileset_193:
   2E7C E0                 2267 	.db #0xE0	; 224
   2E7D C0                 2268 	.db #0xC0	; 192
   2E7E F0                 2269 	.db #0xF0	; 240
   2E7F C0                 2270 	.db #0xC0	; 192
   2E80 F0                 2271 	.db #0xF0	; 240
   2E81 C0                 2272 	.db #0xC0	; 192
   2E82 F0                 2273 	.db #0xF0	; 240
   2E83 C0                 2274 	.db #0xC0	; 192
   2E84                    2275 _map_tileset_194:
   2E84 F0                 2276 	.db #0xF0	; 240
   2E85 E0                 2277 	.db #0xE0	; 224
   2E86 F0                 2278 	.db #0xF0	; 240
   2E87 F0                 2279 	.db #0xF0	; 240
   2E88 F0                 2280 	.db #0xF0	; 240
   2E89 F0                 2281 	.db #0xF0	; 240
   2E8A F0                 2282 	.db #0xF0	; 240
   2E8B F0                 2283 	.db #0xF0	; 240
   2E8C                    2284 _map_tileset_195:
   2E8C C0                 2285 	.db #0xC0	; 192
   2E8D C0                 2286 	.db #0xC0	; 192
   2E8E C0                 2287 	.db #0xC0	; 192
   2E8F D0                 2288 	.db #0xD0	; 208
   2E90 C0                 2289 	.db #0xC0	; 192
   2E91 F0                 2290 	.db #0xF0	; 240
   2E92 F0                 2291 	.db #0xF0	; 240
   2E93 F0                 2292 	.db #0xF0	; 240
   2E94                    2293 _map_tileset_196:
   2E94 C0                 2294 	.db #0xC0	; 192
   2E95 D5                 2295 	.db #0xD5	; 213
   2E96 C0                 2296 	.db #0xC0	; 192
   2E97 D5                 2297 	.db #0xD5	; 213
   2E98 C0                 2298 	.db #0xC0	; 192
   2E99 C0                 2299 	.db #0xC0	; 192
   2E9A C0                 2300 	.db #0xC0	; 192
   2E9B C0                 2301 	.db #0xC0	; 192
   2E9C                    2302 _map_tileset_197:
   2E9C C0                 2303 	.db #0xC0	; 192
   2E9D D5                 2304 	.db #0xD5	; 213
   2E9E C0                 2305 	.db #0xC0	; 192
   2E9F D5                 2306 	.db #0xD5	; 213
   2EA0 C0                 2307 	.db #0xC0	; 192
   2EA1 D5                 2308 	.db #0xD5	; 213
   2EA2 C0                 2309 	.db #0xC0	; 192
   2EA3 D5                 2310 	.db #0xD5	; 213
   2EA4                    2311 _map_tileset_198:
   2EA4 AE                 2312 	.db #0xAE	; 174
   2EA5 0C                 2313 	.db #0x0C	; 12
   2EA6 AE                 2314 	.db #0xAE	; 174
   2EA7 0C                 2315 	.db #0x0C	; 12
   2EA8 AE                 2316 	.db #0xAE	; 174
   2EA9 0C                 2317 	.db #0x0C	; 12
   2EAA AE                 2318 	.db #0xAE	; 174
   2EAB 5D                 2319 	.db #0x5D	; 93
   2EAC                    2320 _map_tileset_199:
   2EAC 0C                 2321 	.db #0x0C	; 12
   2EAD 0C                 2322 	.db #0x0C	; 12
   2EAE 0C                 2323 	.db #0x0C	; 12
   2EAF 0C                 2324 	.db #0x0C	; 12
   2EB0 0C                 2325 	.db #0x0C	; 12
   2EB1 0C                 2326 	.db #0x0C	; 12
   2EB2 FF                 2327 	.db #0xFF	; 255
   2EB3 FF                 2328 	.db #0xFF	; 255
   2EB4                    2329 _map_tileset_200:
   2EB4 0C                 2330 	.db #0x0C	; 12
   2EB5 0C                 2331 	.db #0x0C	; 12
   2EB6 0C                 2332 	.db #0x0C	; 12
   2EB7 0C                 2333 	.db #0x0C	; 12
   2EB8 0C                 2334 	.db #0x0C	; 12
   2EB9 0C                 2335 	.db #0x0C	; 12
   2EBA FF                 2336 	.db #0xFF	; 255
   2EBB 0C                 2337 	.db #0x0C	; 12
   2EBC                    2338 _map_tileset_201:
   2EBC 0C                 2339 	.db #0x0C	; 12
   2EBD 0C                 2340 	.db #0x0C	; 12
   2EBE 0C                 2341 	.db #0x0C	; 12
   2EBF 0C                 2342 	.db #0x0C	; 12
   2EC0 0C                 2343 	.db #0x0C	; 12
   2EC1 0C                 2344 	.db #0x0C	; 12
   2EC2 0C                 2345 	.db #0x0C	; 12
   2EC3 5D                 2346 	.db #0x5D	; 93
   2EC4                    2347 _map_tileset_202:
   2EC4 C3                 2348 	.db #0xC3	; 195
   2EC5 C3                 2349 	.db #0xC3	; 195
   2EC6 49                 2350 	.db #0x49	; 73	'I'
   2EC7 C3                 2351 	.db #0xC3	; 195
   2EC8 0C                 2352 	.db #0x0C	; 12
   2EC9 49                 2353 	.db #0x49	; 73	'I'
   2ECA FF                 2354 	.db #0xFF	; 255
   2ECB 0C                 2355 	.db #0x0C	; 12
   2ECC                    2356 _map_tileset_203:
   2ECC C3                 2357 	.db #0xC3	; 195
   2ECD C3                 2358 	.db #0xC3	; 195
   2ECE C3                 2359 	.db #0xC3	; 195
   2ECF C3                 2360 	.db #0xC3	; 195
   2ED0 C3                 2361 	.db #0xC3	; 195
   2ED1 86                 2362 	.db #0x86	; 134
   2ED2 0C                 2363 	.db #0x0C	; 12
   2ED3 5D                 2364 	.db #0x5D	; 93
   2ED4                    2365 _map_tileset_204:
   2ED4 C3                 2366 	.db #0xC3	; 195
   2ED5 86                 2367 	.db #0x86	; 134
   2ED6 86                 2368 	.db #0x86	; 134
   2ED7 0C                 2369 	.db #0x0C	; 12
   2ED8 0C                 2370 	.db #0x0C	; 12
   2ED9 0C                 2371 	.db #0x0C	; 12
   2EDA FF                 2372 	.db #0xFF	; 255
   2EDB FF                 2373 	.db #0xFF	; 255
   2EDC                    2374 _map_tileset_205:
   2EDC C3                 2375 	.db #0xC3	; 195
   2EDD C3                 2376 	.db #0xC3	; 195
   2EDE C3                 2377 	.db #0xC3	; 195
   2EDF C3                 2378 	.db #0xC3	; 195
   2EE0 C3                 2379 	.db #0xC3	; 195
   2EE1 C3                 2380 	.db #0xC3	; 195
   2EE2 C3                 2381 	.db #0xC3	; 195
   2EE3 D7                 2382 	.db #0xD7	; 215
   2EE4                    2383 _map_tileset_206:
   2EE4 C3                 2384 	.db #0xC3	; 195
   2EE5 C3                 2385 	.db #0xC3	; 195
   2EE6 C3                 2386 	.db #0xC3	; 195
   2EE7 C3                 2387 	.db #0xC3	; 195
   2EE8 C3                 2388 	.db #0xC3	; 195
   2EE9 C3                 2389 	.db #0xC3	; 195
   2EEA FF                 2390 	.db #0xFF	; 255
   2EEB FF                 2391 	.db #0xFF	; 255
   2EEC                    2392 _map_tileset_207:
   2EEC C3                 2393 	.db #0xC3	; 195
   2EED EF                 2394 	.db #0xEF	; 239
   2EEE C3                 2395 	.db #0xC3	; 195
   2EEF EB                 2396 	.db #0xEB	; 235
   2EF0 C3                 2397 	.db #0xC3	; 195
   2EF1 FF                 2398 	.db #0xFF	; 255
   2EF2 FF                 2399 	.db #0xFF	; 255
   2EF3 FF                 2400 	.db #0xFF	; 255
   2EF4                    2401 _map_tileset_208:
   2EF4 D7                 2402 	.db #0xD7	; 215
   2EF5 C3                 2403 	.db #0xC3	; 195
   2EF6 FF                 2404 	.db #0xFF	; 255
   2EF7 C3                 2405 	.db #0xC3	; 195
   2EF8 D7                 2406 	.db #0xD7	; 215
   2EF9 C3                 2407 	.db #0xC3	; 195
   2EFA D7                 2408 	.db #0xD7	; 215
   2EFB C3                 2409 	.db #0xC3	; 195
   2EFC                    2410 _map_tileset_209:
   2EFC C3                 2411 	.db #0xC3	; 195
   2EFD 92                 2412 	.db #0x92	; 146
   2EFE C3                 2413 	.db #0xC3	; 195
   2EFF 92                 2414 	.db #0x92	; 146
   2F00 C3                 2415 	.db #0xC3	; 195
   2F01 92                 2416 	.db #0x92	; 146
   2F02 FF                 2417 	.db #0xFF	; 255
   2F03 BA                 2418 	.db #0xBA	; 186
   2F04                    2419 _map_tileset_210:
   2F04 30                 2420 	.db #0x30	; 48	'0'
   2F05 30                 2421 	.db #0x30	; 48	'0'
   2F06 30                 2422 	.db #0x30	; 48	'0'
   2F07 30                 2423 	.db #0x30	; 48	'0'
   2F08 30                 2424 	.db #0x30	; 48	'0'
   2F09 30                 2425 	.db #0x30	; 48	'0'
   2F0A 30                 2426 	.db #0x30	; 48	'0'
   2F0B 30                 2427 	.db #0x30	; 48	'0'
   2F0C                    2428 _map_tileset_211:
   2F0C 30                 2429 	.db #0x30	; 48	'0'
   2F0D 30                 2430 	.db #0x30	; 48	'0'
   2F0E 30                 2431 	.db #0x30	; 48	'0'
   2F0F 30                 2432 	.db #0x30	; 48	'0'
   2F10 30                 2433 	.db #0x30	; 48	'0'
   2F11 30                 2434 	.db #0x30	; 48	'0'
   2F12 FF                 2435 	.db #0xFF	; 255
   2F13 FF                 2436 	.db #0xFF	; 255
   2F14                    2437 _map_tileset_212:
   2F14 30                 2438 	.db #0x30	; 48	'0'
   2F15 F0                 2439 	.db #0xF0	; 240
   2F16 30                 2440 	.db #0x30	; 48	'0'
   2F17 F0                 2441 	.db #0xF0	; 240
   2F18 30                 2442 	.db #0x30	; 48	'0'
   2F19 F0                 2443 	.db #0xF0	; 240
   2F1A FF                 2444 	.db #0xFF	; 255
   2F1B FF                 2445 	.db #0xFF	; 255
   2F1C                    2446 _map_tileset_213:
   2F1C F0                 2447 	.db #0xF0	; 240
   2F1D F0                 2448 	.db #0xF0	; 240
   2F1E F0                 2449 	.db #0xF0	; 240
   2F1F F0                 2450 	.db #0xF0	; 240
   2F20 F0                 2451 	.db #0xF0	; 240
   2F21 F0                 2452 	.db #0xF0	; 240
   2F22 FF                 2453 	.db #0xFF	; 255
   2F23 FA                 2454 	.db #0xFA	; 250
   2F24                    2455 _map_tileset_214:
   2F24 F0                 2456 	.db #0xF0	; 240
   2F25 F0                 2457 	.db #0xF0	; 240
   2F26 F0                 2458 	.db #0xF0	; 240
   2F27 F0                 2459 	.db #0xF0	; 240
   2F28 F0                 2460 	.db #0xF0	; 240
   2F29 F0                 2461 	.db #0xF0	; 240
   2F2A F0                 2462 	.db #0xF0	; 240
   2F2B F0                 2463 	.db #0xF0	; 240
   2F2C                    2464 _map_tileset_215:
   2F2C F0                 2465 	.db #0xF0	; 240
   2F2D F0                 2466 	.db #0xF0	; 240
   2F2E F0                 2467 	.db #0xF0	; 240
   2F2F F0                 2468 	.db #0xF0	; 240
   2F30 F0                 2469 	.db #0xF0	; 240
   2F31 F0                 2470 	.db #0xF0	; 240
   2F32 FF                 2471 	.db #0xFF	; 255
   2F33 FF                 2472 	.db #0xFF	; 255
   2F34                    2473 _map_tileset_216:
   2F34 C0                 2474 	.db #0xC0	; 192
   2F35 C0                 2475 	.db #0xC0	; 192
   2F36 C0                 2476 	.db #0xC0	; 192
   2F37 C0                 2477 	.db #0xC0	; 192
   2F38 C0                 2478 	.db #0xC0	; 192
   2F39 C0                 2479 	.db #0xC0	; 192
   2F3A FF                 2480 	.db #0xFF	; 255
   2F3B FF                 2481 	.db #0xFF	; 255
   2F3C                    2482 _map_tileset_217:
   2F3C C0                 2483 	.db #0xC0	; 192
   2F3D C0                 2484 	.db #0xC0	; 192
   2F3E C0                 2485 	.db #0xC0	; 192
   2F3F C0                 2486 	.db #0xC0	; 192
   2F40 C0                 2487 	.db #0xC0	; 192
   2F41 C0                 2488 	.db #0xC0	; 192
   2F42 FF                 2489 	.db #0xFF	; 255
   2F43 EA                 2490 	.db #0xEA	; 234
   2F44                    2491 _map_tileset_218:
   2F44 C0                 2492 	.db #0xC0	; 192
   2F45 C0                 2493 	.db #0xC0	; 192
   2F46 C0                 2494 	.db #0xC0	; 192
   2F47 C0                 2495 	.db #0xC0	; 192
   2F48 C0                 2496 	.db #0xC0	; 192
   2F49 C0                 2497 	.db #0xC0	; 192
   2F4A C0                 2498 	.db #0xC0	; 192
   2F4B C0                 2499 	.db #0xC0	; 192
   2F4C                    2500 _map_tileset_219:
   2F4C C0                 2501 	.db #0xC0	; 192
   2F4D D5                 2502 	.db #0xD5	; 213
   2F4E C0                 2503 	.db #0xC0	; 192
   2F4F D5                 2504 	.db #0xD5	; 213
   2F50 C0                 2505 	.db #0xC0	; 192
   2F51 D5                 2506 	.db #0xD5	; 213
   2F52 EA                 2507 	.db #0xEA	; 234
   2F53 D5                 2508 	.db #0xD5	; 213
   2F54                    2509 _map_tileset_220:
   2F54 AE                 2510 	.db #0xAE	; 174
   2F55 5D                 2511 	.db #0x5D	; 93
   2F56 AE                 2512 	.db #0xAE	; 174
   2F57 FF                 2513 	.db #0xFF	; 255
   2F58 AE                 2514 	.db #0xAE	; 174
   2F59 FF                 2515 	.db #0xFF	; 255
   2F5A FF                 2516 	.db #0xFF	; 255
   2F5B FF                 2517 	.db #0xFF	; 255
   2F5C                    2518 _map_tileset_221:
   2F5C FF                 2519 	.db #0xFF	; 255
   2F5D FF                 2520 	.db #0xFF	; 255
   2F5E FF                 2521 	.db #0xFF	; 255
   2F5F FF                 2522 	.db #0xFF	; 255
   2F60 FF                 2523 	.db #0xFF	; 255
   2F61 FF                 2524 	.db #0xFF	; 255
   2F62 FF                 2525 	.db #0xFF	; 255
   2F63 FF                 2526 	.db #0xFF	; 255
   2F64                    2527 _map_tileset_222:
   2F64 FF                 2528 	.db #0xFF	; 255
   2F65 0C                 2529 	.db #0x0C	; 12
   2F66 FF                 2530 	.db #0xFF	; 255
   2F67 AE                 2531 	.db #0xAE	; 174
   2F68 FF                 2532 	.db #0xFF	; 255
   2F69 AE                 2533 	.db #0xAE	; 174
   2F6A FF                 2534 	.db #0xFF	; 255
   2F6B FF                 2535 	.db #0xFF	; 255
   2F6C                    2536 _map_tileset_223:
   2F6C 0C                 2537 	.db #0x0C	; 12
   2F6D 5D                 2538 	.db #0x5D	; 93
   2F6E 0C                 2539 	.db #0x0C	; 12
   2F6F FF                 2540 	.db #0xFF	; 255
   2F70 0C                 2541 	.db #0x0C	; 12
   2F71 FF                 2542 	.db #0xFF	; 255
   2F72 5D                 2543 	.db #0x5D	; 93
   2F73 FF                 2544 	.db #0xFF	; 255
   2F74                    2545 _map_tileset_224:
   2F74 FF                 2546 	.db #0xFF	; 255
   2F75 0C                 2547 	.db #0x0C	; 12
   2F76 FF                 2548 	.db #0xFF	; 255
   2F77 AE                 2549 	.db #0xAE	; 174
   2F78 FF                 2550 	.db #0xFF	; 255
   2F79 AE                 2551 	.db #0xAE	; 174
   2F7A FF                 2552 	.db #0xFF	; 255
   2F7B FF                 2553 	.db #0xFF	; 255
   2F7C                    2554 _map_tileset_225:
   2F7C 0C                 2555 	.db #0x0C	; 12
   2F7D 5D                 2556 	.db #0x5D	; 93
   2F7E 0C                 2557 	.db #0x0C	; 12
   2F7F FF                 2558 	.db #0xFF	; 255
   2F80 0C                 2559 	.db #0x0C	; 12
   2F81 FF                 2560 	.db #0xFF	; 255
   2F82 5D                 2561 	.db #0x5D	; 93
   2F83 FF                 2562 	.db #0xFF	; 255
   2F84                    2563 _map_tileset_226:
   2F84 30                 2564 	.db #0x30	; 48	'0'
   2F85 30                 2565 	.db #0x30	; 48	'0'
   2F86 30                 2566 	.db #0x30	; 48	'0'
   2F87 75                 2567 	.db #0x75	; 117	'u'
   2F88 30                 2568 	.db #0x30	; 48	'0'
   2F89 30                 2569 	.db #0x30	; 48	'0'
   2F8A 30                 2570 	.db #0x30	; 48	'0'
   2F8B 30                 2571 	.db #0x30	; 48	'0'
   2F8C                    2572 _map_tileset_227:
   2F8C C3                 2573 	.db #0xC3	; 195
   2F8D D7                 2574 	.db #0xD7	; 215
   2F8E C3                 2575 	.db #0xC3	; 195
   2F8F FF                 2576 	.db #0xFF	; 255
   2F90 49                 2577 	.db #0x49	; 73	'I'
   2F91 FF                 2578 	.db #0xFF	; 255
   2F92 5D                 2579 	.db #0x5D	; 93
   2F93 FF                 2580 	.db #0xFF	; 255
   2F94                    2581 _map_tileset_228:
   2F94 EB                 2582 	.db #0xEB	; 235
   2F95 C3                 2583 	.db #0xC3	; 195
   2F96 EB                 2584 	.db #0xEB	; 235
   2F97 C3                 2585 	.db #0xC3	; 195
   2F98 AE                 2586 	.db #0xAE	; 174
   2F99 0C                 2587 	.db #0x0C	; 12
   2F9A AE                 2588 	.db #0xAE	; 174
   2F9B 0C                 2589 	.db #0x0C	; 12
   2F9C                    2590 _map_tileset_229:
   2F9C FF                 2591 	.db #0xFF	; 255
   2F9D EB                 2592 	.db #0xEB	; 235
   2F9E FF                 2593 	.db #0xFF	; 255
   2F9F FF                 2594 	.db #0xFF	; 255
   2FA0 FF                 2595 	.db #0xFF	; 255
   2FA1 EF                 2596 	.db #0xEF	; 239
   2FA2 FF                 2597 	.db #0xFF	; 255
   2FA3 FF                 2598 	.db #0xFF	; 255
   2FA4                    2599 _map_tileset_230:
   2FA4 FF                 2600 	.db #0xFF	; 255
   2FA5 C3                 2601 	.db #0xC3	; 195
   2FA6 D7                 2602 	.db #0xD7	; 215
   2FA7 D7                 2603 	.db #0xD7	; 215
   2FA8 D7                 2604 	.db #0xD7	; 215
   2FA9 D7                 2605 	.db #0xD7	; 215
   2FAA FF                 2606 	.db #0xFF	; 255
   2FAB FF                 2607 	.db #0xFF	; 255
   2FAC                    2608 _map_tileset_231:
   2FAC FF                 2609 	.db #0xFF	; 255
   2FAD BA                 2610 	.db #0xBA	; 186
   2FAE FF                 2611 	.db #0xFF	; 255
   2FAF FF                 2612 	.db #0xFF	; 255
   2FB0 FF                 2613 	.db #0xFF	; 255
   2FB1 FF                 2614 	.db #0xFF	; 255
   2FB2 FF                 2615 	.db #0xFF	; 255
   2FB3 FF                 2616 	.db #0xFF	; 255
   2FB4                    2617 _map_tileset_232:
   2FB4 30                 2618 	.db #0x30	; 48	'0'
   2FB5 30                 2619 	.db #0x30	; 48	'0'
   2FB6 30                 2620 	.db #0x30	; 48	'0'
   2FB7 75                 2621 	.db #0x75	; 117	'u'
   2FB8 30                 2622 	.db #0x30	; 48	'0'
   2FB9 75                 2623 	.db #0x75	; 117	'u'
   2FBA BA                 2624 	.db #0xBA	; 186
   2FBB FF                 2625 	.db #0xFF	; 255
   2FBC                    2626 _map_tileset_233:
   2FBC 30                 2627 	.db #0x30	; 48	'0'
   2FBD 30                 2628 	.db #0x30	; 48	'0'
   2FBE C3                 2629 	.db #0xC3	; 195
   2FBF 30                 2630 	.db #0x30	; 48	'0'
   2FC0 C3                 2631 	.db #0xC3	; 195
   2FC1 C3                 2632 	.db #0xC3	; 195
   2FC2 C3                 2633 	.db #0xC3	; 195
   2FC3 C3                 2634 	.db #0xC3	; 195
   2FC4                    2635 _map_tileset_234:
   2FC4 30                 2636 	.db #0x30	; 48	'0'
   2FC5 30                 2637 	.db #0x30	; 48	'0'
   2FC6 30                 2638 	.db #0x30	; 48	'0'
   2FC7 30                 2639 	.db #0x30	; 48	'0'
   2FC8 C3                 2640 	.db #0xC3	; 195
   2FC9 C3                 2641 	.db #0xC3	; 195
   2FCA C3                 2642 	.db #0xC3	; 195
   2FCB C3                 2643 	.db #0xC3	; 195
   2FCC                    2644 _map_tileset_235:
   2FCC FF                 2645 	.db #0xFF	; 255
   2FCD FA                 2646 	.db #0xFA	; 250
   2FCE FF                 2647 	.db #0xFF	; 255
   2FCF FF                 2648 	.db #0xFF	; 255
   2FD0 FF                 2649 	.db #0xFF	; 255
   2FD1 FF                 2650 	.db #0xFF	; 255
   2FD2 FF                 2651 	.db #0xFF	; 255
   2FD3 FF                 2652 	.db #0xFF	; 255
   2FD4                    2653 _map_tileset_236:
   2FD4 F0                 2654 	.db #0xF0	; 240
   2FD5 F0                 2655 	.db #0xF0	; 240
   2FD6 F0                 2656 	.db #0xF0	; 240
   2FD7 F5                 2657 	.db #0xF5	; 245
   2FD8 F0                 2658 	.db #0xF0	; 240
   2FD9 F5                 2659 	.db #0xF5	; 245
   2FDA FA                 2660 	.db #0xFA	; 250
   2FDB FF                 2661 	.db #0xFF	; 255
   2FDC                    2662 _map_tileset_237:
   2FDC 30                 2663 	.db #0x30	; 48	'0'
   2FDD C3                 2664 	.db #0xC3	; 195
   2FDE C3                 2665 	.db #0xC3	; 195
   2FDF C3                 2666 	.db #0xC3	; 195
   2FE0 C3                 2667 	.db #0xC3	; 195
   2FE1 C3                 2668 	.db #0xC3	; 195
   2FE2 C3                 2669 	.db #0xC3	; 195
   2FE3 C3                 2670 	.db #0xC3	; 195
   2FE4                    2671 _map_tileset_238:
   2FE4 F0                 2672 	.db #0xF0	; 240
   2FE5 F0                 2673 	.db #0xF0	; 240
   2FE6 F0                 2674 	.db #0xF0	; 240
   2FE7 B0                 2675 	.db #0xB0	; 176
   2FE8 B0                 2676 	.db #0xB0	; 176
   2FE9 30                 2677 	.db #0x30	; 48	'0'
   2FEA 30                 2678 	.db #0x30	; 48	'0'
   2FEB 30                 2679 	.db #0x30	; 48	'0'
   2FEC                    2680 _map_tileset_239:
   2FEC FF                 2681 	.db #0xFF	; 255
   2FED EA                 2682 	.db #0xEA	; 234
   2FEE FF                 2683 	.db #0xFF	; 255
   2FEF FF                 2684 	.db #0xFF	; 255
   2FF0 FF                 2685 	.db #0xFF	; 255
   2FF1 FF                 2686 	.db #0xFF	; 255
   2FF2 FF                 2687 	.db #0xFF	; 255
   2FF3 FF                 2688 	.db #0xFF	; 255
   2FF4                    2689 _map_tileset_240:
   2FF4 C0                 2690 	.db #0xC0	; 192
   2FF5 C0                 2691 	.db #0xC0	; 192
   2FF6 C0                 2692 	.db #0xC0	; 192
   2FF7 D5                 2693 	.db #0xD5	; 213
   2FF8 C0                 2694 	.db #0xC0	; 192
   2FF9 D5                 2695 	.db #0xD5	; 213
   2FFA EA                 2696 	.db #0xEA	; 234
   2FFB FF                 2697 	.db #0xFF	; 255
   2FFC                    2698 _map_tileset_241:
   2FFC EA                 2699 	.db #0xEA	; 234
   2FFD D5                 2700 	.db #0xD5	; 213
   2FFE FF                 2701 	.db #0xFF	; 255
   2FFF D5                 2702 	.db #0xD5	; 213
   3000 FF                 2703 	.db #0xFF	; 255
   3001 D5                 2704 	.db #0xD5	; 213
   3002 FF                 2705 	.db #0xFF	; 255
   3003 FF                 2706 	.db #0xFF	; 255
                           2707 	.area _INITIALIZER
                           2708 	.area _CABS (ABS)
