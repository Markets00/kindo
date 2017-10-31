;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module tileset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _map_tileset_241
	.globl _map_tileset_240
	.globl _map_tileset_239
	.globl _map_tileset_238
	.globl _map_tileset_237
	.globl _map_tileset_236
	.globl _map_tileset_235
	.globl _map_tileset_234
	.globl _map_tileset_233
	.globl _map_tileset_232
	.globl _map_tileset_231
	.globl _map_tileset_230
	.globl _map_tileset_229
	.globl _map_tileset_228
	.globl _map_tileset_227
	.globl _map_tileset_226
	.globl _map_tileset_225
	.globl _map_tileset_224
	.globl _map_tileset_223
	.globl _map_tileset_222
	.globl _map_tileset_221
	.globl _map_tileset_220
	.globl _map_tileset_219
	.globl _map_tileset_218
	.globl _map_tileset_217
	.globl _map_tileset_216
	.globl _map_tileset_215
	.globl _map_tileset_214
	.globl _map_tileset_213
	.globl _map_tileset_212
	.globl _map_tileset_211
	.globl _map_tileset_210
	.globl _map_tileset_209
	.globl _map_tileset_208
	.globl _map_tileset_207
	.globl _map_tileset_206
	.globl _map_tileset_205
	.globl _map_tileset_204
	.globl _map_tileset_203
	.globl _map_tileset_202
	.globl _map_tileset_201
	.globl _map_tileset_200
	.globl _map_tileset_199
	.globl _map_tileset_198
	.globl _map_tileset_197
	.globl _map_tileset_196
	.globl _map_tileset_195
	.globl _map_tileset_194
	.globl _map_tileset_193
	.globl _map_tileset_192
	.globl _map_tileset_191
	.globl _map_tileset_190
	.globl _map_tileset_189
	.globl _map_tileset_188
	.globl _map_tileset_187
	.globl _map_tileset_186
	.globl _map_tileset_185
	.globl _map_tileset_184
	.globl _map_tileset_183
	.globl _map_tileset_182
	.globl _map_tileset_181
	.globl _map_tileset_180
	.globl _map_tileset_179
	.globl _map_tileset_178
	.globl _map_tileset_177
	.globl _map_tileset_176
	.globl _map_tileset_175
	.globl _map_tileset_174
	.globl _map_tileset_173
	.globl _map_tileset_172
	.globl _map_tileset_171
	.globl _map_tileset_170
	.globl _map_tileset_169
	.globl _map_tileset_168
	.globl _map_tileset_167
	.globl _map_tileset_166
	.globl _map_tileset_165
	.globl _map_tileset_164
	.globl _map_tileset_163
	.globl _map_tileset_162
	.globl _map_tileset_161
	.globl _map_tileset_160
	.globl _map_tileset_159
	.globl _map_tileset_158
	.globl _map_tileset_157
	.globl _map_tileset_156
	.globl _map_tileset_155
	.globl _map_tileset_154
	.globl _map_tileset_153
	.globl _map_tileset_152
	.globl _map_tileset_151
	.globl _map_tileset_150
	.globl _map_tileset_149
	.globl _map_tileset_148
	.globl _map_tileset_147
	.globl _map_tileset_146
	.globl _map_tileset_145
	.globl _map_tileset_144
	.globl _map_tileset_143
	.globl _map_tileset_142
	.globl _map_tileset_141
	.globl _map_tileset_140
	.globl _map_tileset_139
	.globl _map_tileset_138
	.globl _map_tileset_137
	.globl _map_tileset_136
	.globl _map_tileset_135
	.globl _map_tileset_134
	.globl _map_tileset_133
	.globl _map_tileset_132
	.globl _map_tileset_131
	.globl _map_tileset_130
	.globl _map_tileset_129
	.globl _map_tileset_128
	.globl _map_tileset_127
	.globl _map_tileset_126
	.globl _map_tileset_125
	.globl _map_tileset_124
	.globl _map_tileset_123
	.globl _map_tileset_122
	.globl _map_tileset_121
	.globl _map_tileset_120
	.globl _map_tileset_119
	.globl _map_tileset_118
	.globl _map_tileset_117
	.globl _map_tileset_116
	.globl _map_tileset_115
	.globl _map_tileset_114
	.globl _map_tileset_113
	.globl _map_tileset_112
	.globl _map_tileset_111
	.globl _map_tileset_110
	.globl _map_tileset_109
	.globl _map_tileset_108
	.globl _map_tileset_107
	.globl _map_tileset_106
	.globl _map_tileset_105
	.globl _map_tileset_104
	.globl _map_tileset_103
	.globl _map_tileset_102
	.globl _map_tileset_101
	.globl _map_tileset_100
	.globl _map_tileset_099
	.globl _map_tileset_098
	.globl _map_tileset_097
	.globl _map_tileset_096
	.globl _map_tileset_095
	.globl _map_tileset_094
	.globl _map_tileset_093
	.globl _map_tileset_092
	.globl _map_tileset_091
	.globl _map_tileset_090
	.globl _map_tileset_089
	.globl _map_tileset_088
	.globl _map_tileset_087
	.globl _map_tileset_086
	.globl _map_tileset_085
	.globl _map_tileset_084
	.globl _map_tileset_083
	.globl _map_tileset_082
	.globl _map_tileset_081
	.globl _map_tileset_080
	.globl _map_tileset_079
	.globl _map_tileset_078
	.globl _map_tileset_077
	.globl _map_tileset_076
	.globl _map_tileset_075
	.globl _map_tileset_074
	.globl _map_tileset_073
	.globl _map_tileset_072
	.globl _map_tileset_071
	.globl _map_tileset_070
	.globl _map_tileset_069
	.globl _map_tileset_068
	.globl _map_tileset_067
	.globl _map_tileset_066
	.globl _map_tileset_065
	.globl _map_tileset_064
	.globl _map_tileset_063
	.globl _map_tileset_062
	.globl _map_tileset_061
	.globl _map_tileset_060
	.globl _map_tileset_059
	.globl _map_tileset_058
	.globl _map_tileset_057
	.globl _map_tileset_056
	.globl _map_tileset_055
	.globl _map_tileset_054
	.globl _map_tileset_053
	.globl _map_tileset_052
	.globl _map_tileset_051
	.globl _map_tileset_050
	.globl _map_tileset_049
	.globl _map_tileset_048
	.globl _map_tileset_047
	.globl _map_tileset_046
	.globl _map_tileset_045
	.globl _map_tileset_044
	.globl _map_tileset_043
	.globl _map_tileset_042
	.globl _map_tileset_041
	.globl _map_tileset_040
	.globl _map_tileset_039
	.globl _map_tileset_038
	.globl _map_tileset_037
	.globl _map_tileset_036
	.globl _map_tileset_035
	.globl _map_tileset_034
	.globl _map_tileset_033
	.globl _map_tileset_032
	.globl _map_tileset_031
	.globl _map_tileset_030
	.globl _map_tileset_029
	.globl _map_tileset_028
	.globl _map_tileset_027
	.globl _map_tileset_026
	.globl _map_tileset_025
	.globl _map_tileset_024
	.globl _map_tileset_023
	.globl _map_tileset_022
	.globl _map_tileset_021
	.globl _map_tileset_020
	.globl _map_tileset_019
	.globl _map_tileset_018
	.globl _map_tileset_017
	.globl _map_tileset_016
	.globl _map_tileset_015
	.globl _map_tileset_014
	.globl _map_tileset_013
	.globl _map_tileset_012
	.globl _map_tileset_011
	.globl _map_tileset_010
	.globl _map_tileset_009
	.globl _map_tileset_008
	.globl _map_tileset_007
	.globl _map_tileset_006
	.globl _map_tileset_005
	.globl _map_tileset_004
	.globl _map_tileset_003
	.globl _map_tileset_002
	.globl _map_tileset_001
	.globl _map_tileset_000
	.globl _map_tileset
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
	.area _CODE
_map_tileset:
	.dw _map_tileset_000
	.dw _map_tileset_001
	.dw _map_tileset_002
	.dw _map_tileset_003
	.dw _map_tileset_004
	.dw _map_tileset_005
	.dw _map_tileset_006
	.dw _map_tileset_007
	.dw _map_tileset_008
	.dw _map_tileset_009
	.dw _map_tileset_010
	.dw _map_tileset_011
	.dw _map_tileset_012
	.dw _map_tileset_013
	.dw _map_tileset_014
	.dw _map_tileset_015
	.dw _map_tileset_016
	.dw _map_tileset_017
	.dw _map_tileset_018
	.dw _map_tileset_019
	.dw _map_tileset_020
	.dw _map_tileset_021
	.dw _map_tileset_022
	.dw _map_tileset_023
	.dw _map_tileset_024
	.dw _map_tileset_025
	.dw _map_tileset_026
	.dw _map_tileset_027
	.dw _map_tileset_028
	.dw _map_tileset_029
	.dw _map_tileset_030
	.dw _map_tileset_031
	.dw _map_tileset_032
	.dw _map_tileset_033
	.dw _map_tileset_034
	.dw _map_tileset_035
	.dw _map_tileset_036
	.dw _map_tileset_037
	.dw _map_tileset_038
	.dw _map_tileset_039
	.dw _map_tileset_040
	.dw _map_tileset_041
	.dw _map_tileset_042
	.dw _map_tileset_043
	.dw _map_tileset_044
	.dw _map_tileset_045
	.dw _map_tileset_046
	.dw _map_tileset_047
	.dw _map_tileset_048
	.dw _map_tileset_049
	.dw _map_tileset_050
	.dw _map_tileset_051
	.dw _map_tileset_052
	.dw _map_tileset_053
	.dw _map_tileset_054
	.dw _map_tileset_055
	.dw _map_tileset_056
	.dw _map_tileset_057
	.dw _map_tileset_058
	.dw _map_tileset_059
	.dw _map_tileset_060
	.dw _map_tileset_061
	.dw _map_tileset_062
	.dw _map_tileset_063
	.dw _map_tileset_064
	.dw _map_tileset_065
	.dw _map_tileset_066
	.dw _map_tileset_067
	.dw _map_tileset_068
	.dw _map_tileset_069
	.dw _map_tileset_070
	.dw _map_tileset_071
	.dw _map_tileset_072
	.dw _map_tileset_073
	.dw _map_tileset_074
	.dw _map_tileset_075
	.dw _map_tileset_076
	.dw _map_tileset_077
	.dw _map_tileset_078
	.dw _map_tileset_079
	.dw _map_tileset_080
	.dw _map_tileset_081
	.dw _map_tileset_082
	.dw _map_tileset_083
	.dw _map_tileset_084
	.dw _map_tileset_085
	.dw _map_tileset_086
	.dw _map_tileset_087
	.dw _map_tileset_088
	.dw _map_tileset_089
	.dw _map_tileset_090
	.dw _map_tileset_091
	.dw _map_tileset_092
	.dw _map_tileset_093
	.dw _map_tileset_094
	.dw _map_tileset_095
	.dw _map_tileset_096
	.dw _map_tileset_097
	.dw _map_tileset_098
	.dw _map_tileset_099
	.dw _map_tileset_100
	.dw _map_tileset_101
	.dw _map_tileset_102
	.dw _map_tileset_103
	.dw _map_tileset_104
	.dw _map_tileset_105
	.dw _map_tileset_106
	.dw _map_tileset_107
	.dw _map_tileset_108
	.dw _map_tileset_109
	.dw _map_tileset_110
	.dw _map_tileset_111
	.dw _map_tileset_112
	.dw _map_tileset_113
	.dw _map_tileset_114
	.dw _map_tileset_115
	.dw _map_tileset_116
	.dw _map_tileset_117
	.dw _map_tileset_118
	.dw _map_tileset_119
	.dw _map_tileset_120
	.dw _map_tileset_121
	.dw _map_tileset_122
	.dw _map_tileset_123
	.dw _map_tileset_124
	.dw _map_tileset_125
	.dw _map_tileset_126
	.dw _map_tileset_127
	.dw _map_tileset_128
	.dw _map_tileset_129
	.dw _map_tileset_130
	.dw _map_tileset_131
	.dw _map_tileset_132
	.dw _map_tileset_133
	.dw _map_tileset_134
	.dw _map_tileset_135
	.dw _map_tileset_136
	.dw _map_tileset_137
	.dw _map_tileset_138
	.dw _map_tileset_139
	.dw _map_tileset_140
	.dw _map_tileset_141
	.dw _map_tileset_142
	.dw _map_tileset_143
	.dw _map_tileset_144
	.dw _map_tileset_145
	.dw _map_tileset_146
	.dw _map_tileset_147
	.dw _map_tileset_148
	.dw _map_tileset_149
	.dw _map_tileset_150
	.dw _map_tileset_151
	.dw _map_tileset_152
	.dw _map_tileset_153
	.dw _map_tileset_154
	.dw _map_tileset_155
	.dw _map_tileset_156
	.dw _map_tileset_157
	.dw _map_tileset_158
	.dw _map_tileset_159
	.dw _map_tileset_160
	.dw _map_tileset_161
	.dw _map_tileset_162
	.dw _map_tileset_163
	.dw _map_tileset_164
	.dw _map_tileset_165
	.dw _map_tileset_166
	.dw _map_tileset_167
	.dw _map_tileset_168
	.dw _map_tileset_169
	.dw _map_tileset_170
	.dw _map_tileset_171
	.dw _map_tileset_172
	.dw _map_tileset_173
	.dw _map_tileset_174
	.dw _map_tileset_175
	.dw _map_tileset_176
	.dw _map_tileset_177
	.dw _map_tileset_178
	.dw _map_tileset_179
	.dw _map_tileset_180
	.dw _map_tileset_181
	.dw _map_tileset_182
	.dw _map_tileset_183
	.dw _map_tileset_184
	.dw _map_tileset_185
	.dw _map_tileset_186
	.dw _map_tileset_187
	.dw _map_tileset_188
	.dw _map_tileset_189
	.dw _map_tileset_190
	.dw _map_tileset_191
	.dw _map_tileset_192
	.dw _map_tileset_193
	.dw _map_tileset_194
	.dw _map_tileset_195
	.dw _map_tileset_196
	.dw _map_tileset_197
	.dw _map_tileset_198
	.dw _map_tileset_199
	.dw _map_tileset_200
	.dw _map_tileset_201
	.dw _map_tileset_202
	.dw _map_tileset_203
	.dw _map_tileset_204
	.dw _map_tileset_205
	.dw _map_tileset_206
	.dw _map_tileset_207
	.dw _map_tileset_208
	.dw _map_tileset_209
	.dw _map_tileset_210
	.dw _map_tileset_211
	.dw _map_tileset_212
	.dw _map_tileset_213
	.dw _map_tileset_214
	.dw _map_tileset_215
	.dw _map_tileset_216
	.dw _map_tileset_217
	.dw _map_tileset_218
	.dw _map_tileset_219
	.dw _map_tileset_220
	.dw _map_tileset_221
	.dw _map_tileset_222
	.dw _map_tileset_223
	.dw _map_tileset_224
	.dw _map_tileset_225
	.dw _map_tileset_226
	.dw _map_tileset_227
	.dw _map_tileset_228
	.dw _map_tileset_229
	.dw _map_tileset_230
	.dw _map_tileset_231
	.dw _map_tileset_232
	.dw _map_tileset_233
	.dw _map_tileset_234
	.dw _map_tileset_235
	.dw _map_tileset_236
	.dw _map_tileset_237
	.dw _map_tileset_238
	.dw _map_tileset_239
	.dw _map_tileset_240
	.dw _map_tileset_241
_map_tileset_000:
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFF	; 255
_map_tileset_001:
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
_map_tileset_002:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xEA	; 234
	.db #0xFF	; 255
	.db #0xEA	; 234
	.db #0xFF	; 255
_map_tileset_003:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_004:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_005:
	.db #0xFF	; 255
	.db #0xFB	; 251
	.db #0xFF	; 255
	.db #0xFB	; 251
	.db #0xFF	; 255
	.db #0xFB	; 251
	.db #0xFF	; 255
	.db #0xFB	; 251
_map_tileset_006:
	.db #0xF7	; 247
	.db #0xFF	; 255
	.db #0xF7	; 247
	.db #0xFF	; 255
	.db #0xF7	; 247
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_007:
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
_map_tileset_008:
	.db #0xEA	; 234
	.db #0xD0	; 208
	.db #0xEA	; 234
	.db #0xD0	; 208
	.db #0xEA	; 234
	.db #0xF0	; 240
	.db #0xEA	; 234
	.db #0xF0	; 240
_map_tileset_009:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_010:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xD5	; 213
	.db #0xFF	; 255
	.db #0xD5	; 213
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
_map_tileset_011:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xE8	; 232
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_012:
	.db #0xFF	; 255
	.db #0xEB	; 235
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
_map_tileset_013:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xD7	; 215
	.db #0xFF	; 255
	.db #0xD7	; 215
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xFF	; 255
_map_tileset_014:
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_015:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_016:
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
_map_tileset_017:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
_map_tileset_018:
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
_map_tileset_019:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
_map_tileset_020:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0x0C	; 12
	.db #0xC3	; 195
_map_tileset_021:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xAE	; 174
	.db #0x5D	; 93
_map_tileset_022:
	.db #0xF0	; 240
	.db #0xEF	; 239
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xFF	; 255
_map_tileset_023:
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
_map_tileset_024:
	.db #0xEA	; 234
	.db #0xD5	; 213
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
_map_tileset_025:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_026:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
_map_tileset_027:
	.db #0xFB	; 251
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xFB	; 251
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xFF	; 255
_map_tileset_028:
	.db #0xF7	; 247
	.db #0xF7	; 247
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
_map_tileset_029:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_030:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
_map_tileset_031:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xB0	; 176
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xB0	; 176
	.db #0x30	; 48	'0'
_map_tileset_032:
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_033:
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xC3	; 195
	.db #0xC0	; 192
	.db #0xC2	; 194
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_034:
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_035:
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_036:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_037:
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_038:
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_039:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
_map_tileset_040:
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_041:
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_042:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_043:
	.db #0xAE	; 174
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
_map_tileset_044:
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xEF	; 239
	.db #0xF0	; 240
	.db #0xFA	; 250
_map_tileset_045:
	.db #0xFF	; 255
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xF0	; 240
_map_tileset_046:
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xB0	; 176
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_047:
	.db #0xFA	; 250
	.db #0x30	; 48	'0'
	.db #0xFA	; 250
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
_map_tileset_048:
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
_map_tileset_049:
	.db #0xF3	; 243
	.db #0xFB	; 251
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xEF	; 239
	.db #0xF3	; 243
	.db #0xFB	; 251
_map_tileset_050:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
_map_tileset_051:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_052:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_053:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_054:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_055:
	.db #0xD3	; 211
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_056:
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_057:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_058:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
_map_tileset_059:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xD0	; 208
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_060:
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x86	; 134
_map_tileset_061:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xE2	; 226
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_062:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xE2	; 226
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_063:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xD1	; 209
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_064:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
_map_tileset_065:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
_map_tileset_066:
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xB0	; 176
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
_map_tileset_067:
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
_map_tileset_068:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
_map_tileset_069:
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
_map_tileset_070:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
_map_tileset_071:
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xFB	; 251
	.db #0xF3	; 243
	.db #0xFF	; 255
_map_tileset_072:
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
_map_tileset_073:
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
_map_tileset_074:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
_map_tileset_075:
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
_map_tileset_076:
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
	.db #0xFA	; 250
	.db #0xF0	; 240
_map_tileset_077:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
_map_tileset_078:
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x86	; 134
_map_tileset_079:
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0xD7	; 215
	.db #0x0C	; 12
	.db #0xD7	; 215
_map_tileset_080:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
_map_tileset_081:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xE2	; 226
_map_tileset_082:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_083:
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_084:
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0x5D	; 93
_map_tileset_085:
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
_map_tileset_086:
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xD1	; 209
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_087:
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
_map_tileset_088:
	.db #0x30	; 48	'0'
	.db #0xEF	; 239
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
_map_tileset_089:
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
_map_tileset_090:
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
_map_tileset_091:
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
_map_tileset_092:
	.db #0x3F	; 63
	.db #0x6A	; 106	'j'
	.db #0x3F	; 63
	.db #0x6A	; 106	'j'
	.db #0x95	; 149
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0xC0	; 192
_map_tileset_093:
	.db #0xF3	; 243
	.db #0xEF	; 239
	.db #0xF3	; 243
	.db #0xFB	; 251
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xFF	; 255
_map_tileset_094:
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
_map_tileset_095:
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_096:
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_097:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xE3	; 227
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_098:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_099:
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
_map_tileset_100:
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_101:
	.db #0x49	; 73	'I'
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
_map_tileset_102:
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_103:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
_map_tileset_104:
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
_map_tileset_105:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xD1	; 209
_map_tileset_106:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_107:
	.db #0xC0	; 192
	.db #0xD1	; 209
	.db #0xC0	; 192
	.db #0xD1	; 209
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_108:
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xD1	; 209
_map_tileset_109:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xD1	; 209
_map_tileset_110:
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xEF	; 239
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
_map_tileset_111:
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
_map_tileset_112:
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
_map_tileset_113:
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
_map_tileset_114:
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
_map_tileset_115:
	.db #0xF3	; 243
	.db #0xFB	; 251
	.db #0xD1	; 209
	.db #0xFF	; 255
	.db #0xD1	; 209
	.db #0xEF	; 239
	.db #0xC0	; 192
	.db #0xFB	; 251
_map_tileset_116:
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
_map_tileset_117:
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xEF	; 239
	.db #0xC0	; 192
	.db #0xEA	; 234
_map_tileset_118:
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
_map_tileset_119:
	.db #0xF3	; 243
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_120:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_121:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
_map_tileset_122:
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0x92	; 146
	.db #0x30	; 48	'0'
_map_tileset_123:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_124:
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
_map_tileset_125:
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
_map_tileset_126:
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xE0	; 224
_map_tileset_127:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_128:
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_129:
	.db #0xD1	; 209
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_130:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
_map_tileset_131:
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xD5	; 213
	.db #0xE2	; 226
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
_map_tileset_132:
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
_map_tileset_133:
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
_map_tileset_134:
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_135:
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
	.db #0xF3	; 243
	.db #0xE3	; 227
_map_tileset_136:
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xF7	; 247
_map_tileset_137:
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xFF	; 255
_map_tileset_138:
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xF3	; 243
	.db #0xD5	; 213
	.db #0xF3	; 243
_map_tileset_139:
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xFF	; 255
_map_tileset_140:
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
_map_tileset_141:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xD3	; 211
	.db #0xC3	; 195
	.db #0xF3	; 243
	.db #0xD3	; 211
	.db #0xF3	; 243
_map_tileset_142:
	.db #0xC3	; 195
	.db #0xEF	; 239
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xFF	; 255
_map_tileset_143:
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
_map_tileset_144:
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
_map_tileset_145:
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_146:
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
_map_tileset_147:
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_148:
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
_map_tileset_149:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
_map_tileset_150:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
_map_tileset_151:
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xF3	; 243
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_152:
	.db #0xF3	; 243
	.db #0xE2	; 226
	.db #0xE2	; 226
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_153:
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
_map_tileset_154:
	.db #0x30	; 48	'0'
	.db #0xEF	; 239
	.db #0x30	; 48	'0'
	.db #0xBA	; 186
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xFF	; 255
_map_tileset_155:
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xD7	; 215
	.db #0x92	; 146
_map_tileset_156:
	.db #0xFF	; 255
	.db #0xEA	; 234
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
_map_tileset_157:
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_158:
	.db #0xC3	; 195
	.db #0xF7	; 247
	.db #0xD3	; 211
	.db #0xF7	; 247
	.db #0xD3	; 211
	.db #0xF7	; 247
	.db #0xF3	; 243
	.db #0xF7	; 247
_map_tileset_159:
	.db #0xC0	; 192
	.db #0xEF	; 239
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
_map_tileset_160:
	.db #0xD5	; 213
	.db #0xF3	; 243
	.db #0xFF	; 255
	.db #0xD1	; 209
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
_map_tileset_161:
	.db #0xC0	; 192
	.db #0xEF	; 239
	.db #0xC0	; 192
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xFF	; 255
_map_tileset_162:
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
_map_tileset_163:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x49	; 73	'I'
	.db #0xC3	; 195
	.db #0x49	; 73	'I'
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0xC3	; 195
_map_tileset_164:
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xEF	; 239
	.db #0xC3	; 195
	.db #0xEB	; 235
_map_tileset_165:
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
_map_tileset_166:
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x92	; 146
_map_tileset_167:
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x92	; 146
_map_tileset_168:
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
_map_tileset_169:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
_map_tileset_170:
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_171:
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xE0	; 224
	.db #0xC0	; 192
_map_tileset_172:
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xE0	; 224
_map_tileset_173:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xF0	; 240
_map_tileset_174:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xD0	; 208
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_175:
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_176:
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
_map_tileset_177:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_178:
	.db #0xEA	; 234
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_179:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_180:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
_map_tileset_181:
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_182:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0x0C	; 12
_map_tileset_183:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
_map_tileset_184:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
_map_tileset_185:
	.db #0x0C	; 12
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
_map_tileset_186:
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xFF	; 255
_map_tileset_187:
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
_map_tileset_188:
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0x92	; 146
_map_tileset_189:
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_190:
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
_map_tileset_191:
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
_map_tileset_192:
	.db #0x30	; 48	'0'
	.db #0x61	; 97	'a'
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x61	; 97	'a'
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_193:
	.db #0xE0	; 224
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xC0	; 192
_map_tileset_194:
	.db #0xF0	; 240
	.db #0xE0	; 224
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_195:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xD0	; 208
	.db #0xC0	; 192
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_196:
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_197:
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
_map_tileset_198:
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x5D	; 93
_map_tileset_199:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_200:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
_map_tileset_201:
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x5D	; 93
_map_tileset_202:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x49	; 73	'I'
	.db #0xC3	; 195
	.db #0x0C	; 12
	.db #0x49	; 73	'I'
	.db #0xFF	; 255
	.db #0x0C	; 12
_map_tileset_203:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x5D	; 93
_map_tileset_204:
	.db #0xC3	; 195
	.db #0x86	; 134
	.db #0x86	; 134
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_205:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xD7	; 215
_map_tileset_206:
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_207:
	.db #0xC3	; 195
	.db #0xEF	; 239
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_208:
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
_map_tileset_209:
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xC3	; 195
	.db #0x92	; 146
	.db #0xFF	; 255
	.db #0xBA	; 186
_map_tileset_210:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_211:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_212:
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_213:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xFA	; 250
_map_tileset_214:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
_map_tileset_215:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_216:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_217:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xFF	; 255
	.db #0xEA	; 234
_map_tileset_218:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
_map_tileset_219:
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xEA	; 234
	.db #0xD5	; 213
_map_tileset_220:
	.db #0xAE	; 174
	.db #0x5D	; 93
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_221:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_222:
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_223:
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
_map_tileset_224:
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xAE	; 174
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_225:
	.db #0x0C	; 12
	.db #0x5D	; 93
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x0C	; 12
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
_map_tileset_226:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_227:
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xC3	; 195
	.db #0xFF	; 255
	.db #0x49	; 73	'I'
	.db #0xFF	; 255
	.db #0x5D	; 93
	.db #0xFF	; 255
_map_tileset_228:
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xEB	; 235
	.db #0xC3	; 195
	.db #0xAE	; 174
	.db #0x0C	; 12
	.db #0xAE	; 174
	.db #0x0C	; 12
_map_tileset_229:
	.db #0xFF	; 255
	.db #0xEB	; 235
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xEF	; 239
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_230:
	.db #0xFF	; 255
	.db #0xC3	; 195
	.db #0xD7	; 215
	.db #0xD7	; 215
	.db #0xD7	; 215
	.db #0xD7	; 215
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_231:
	.db #0xFF	; 255
	.db #0xBA	; 186
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_232:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0x75	; 117	'u'
	.db #0xBA	; 186
	.db #0xFF	; 255
_map_tileset_233:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_234:
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_235:
	.db #0xFF	; 255
	.db #0xFA	; 250
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_236:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xF0	; 240
	.db #0xF5	; 245
	.db #0xFA	; 250
	.db #0xFF	; 255
_map_tileset_237:
	.db #0x30	; 48	'0'
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
	.db #0xC3	; 195
_map_tileset_238:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xB0	; 176
	.db #0xB0	; 176
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
_map_tileset_239:
	.db #0xFF	; 255
	.db #0xEA	; 234
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
_map_tileset_240:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xC0	; 192
	.db #0xD5	; 213
	.db #0xEA	; 234
	.db #0xFF	; 255
_map_tileset_241:
	.db #0xEA	; 234
	.db #0xD5	; 213
	.db #0xFF	; 255
	.db #0xD5	; 213
	.db #0xFF	; 255
	.db #0xD5	; 213
	.db #0xFF	; 255
	.db #0xFF	; 255
	.area _INITIALIZER
	.area _CABS (ABS)
