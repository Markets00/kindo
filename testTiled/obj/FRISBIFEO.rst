                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module FRISBIFEO
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_FRISBIFEO_1
                             12 	.globl _g_FRISBIFEO_0
                             13 ;--------------------------------------------------------
                             14 ; special function registers
                             15 ;--------------------------------------------------------
                             16 ;--------------------------------------------------------
                             17 ; ram data
                             18 ;--------------------------------------------------------
                             19 	.area _DATA
                             20 ;--------------------------------------------------------
                             21 ; ram data
                             22 ;--------------------------------------------------------
                             23 	.area _INITIALIZED
                             24 ;--------------------------------------------------------
                             25 ; absolute external ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DABS (ABS)
                             28 ;--------------------------------------------------------
                             29 ; global & static initialisations
                             30 ;--------------------------------------------------------
                             31 	.area _HOME
                             32 	.area _GSINIT
                             33 	.area _GSFINAL
                             34 	.area _GSINIT
                             35 ;--------------------------------------------------------
                             36 ; Home
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _HOME
                             40 ;--------------------------------------------------------
                             41 ; code
                             42 ;--------------------------------------------------------
                             43 	.area _CODE
                             44 	.area _CODE
   4EFC                      45 _g_FRISBIFEO_0:
   4EFC FC                   46 	.db #0xfc	; 252
   4EFD FC                   47 	.db #0xfc	; 252
   4EFE FC                   48 	.db #0xfc	; 252
   4EFF FC                   49 	.db #0xfc	; 252
   4F00 FC                   50 	.db #0xfc	; 252
   4F01 FC                   51 	.db #0xfc	; 252
   4F02 FC                   52 	.db #0xfc	; 252
   4F03 FC                   53 	.db #0xfc	; 252
   4F04 FC                   54 	.db #0xfc	; 252
   4F05 FC                   55 	.db #0xfc	; 252
   4F06 FC                   56 	.db #0xfc	; 252
   4F07 FC                   57 	.db #0xfc	; 252
   4F08 FC                   58 	.db #0xfc	; 252
   4F09 A9                   59 	.db #0xa9	; 169
   4F0A 03                   60 	.db #0x03	; 3
   4F0B FC                   61 	.db #0xfc	; 252
   4F0C FC                   62 	.db #0xfc	; 252
   4F0D 16                   63 	.db #0x16	; 22
   4F0E 3C                   64 	.db #0x3c	; 60
   4F0F 56                   65 	.db #0x56	; 86	'V'
   4F10 FC                   66 	.db #0xfc	; 252
   4F11 16                   67 	.db #0x16	; 22
   4F12 16                   68 	.db #0x16	; 22
   4F13 56                   69 	.db #0x56	; 86	'V'
   4F14 FC                   70 	.db #0xfc	; 252
   4F15 29                   71 	.db #0x29	; 41
   4F16 A9                   72 	.db #0xa9	; 169
   4F17 7C                   73 	.db #0x7c	; 124
   4F18 FC                   74 	.db #0xfc	; 252
   4F19 29                   75 	.db #0x29	; 41
   4F1A A9                   76 	.db #0xa9	; 169
   4F1B 7C                   77 	.db #0x7c	; 124
   4F1C A9                   78 	.db #0xa9	; 169
   4F1D 7C                   79 	.db #0x7c	; 124
   4F1E FC                   80 	.db #0xfc	; 252
   4F1F 29                   81 	.db #0x29	; 41
   4F20 FC                   82 	.db #0xfc	; 252
   4F21 29                   83 	.db #0x29	; 41
   4F22 A9                   84 	.db #0xa9	; 169
   4F23 7C                   85 	.db #0x7c	; 124
   4F24 FC                   86 	.db #0xfc	; 252
   4F25 29                   87 	.db #0x29	; 41
   4F26 A9                   88 	.db #0xa9	; 169
   4F27 7C                   89 	.db #0x7c	; 124
   4F28 FC                   90 	.db #0xfc	; 252
   4F29 16                   91 	.db #0x16	; 22
   4F2A 16                   92 	.db #0x16	; 22
   4F2B 56                   93 	.db #0x56	; 86	'V'
   4F2C FC                   94 	.db #0xfc	; 252
   4F2D 16                   95 	.db #0x16	; 22
   4F2E 3C                   96 	.db #0x3c	; 60
   4F2F 56                   97 	.db #0x56	; 86	'V'
   4F30 FC                   98 	.db #0xfc	; 252
   4F31 A9                   99 	.db #0xa9	; 169
   4F32 03                  100 	.db #0x03	; 3
   4F33 FC                  101 	.db #0xfc	; 252
   4F34 FC                  102 	.db #0xfc	; 252
   4F35 FC                  103 	.db #0xfc	; 252
   4F36 FC                  104 	.db #0xfc	; 252
   4F37 FC                  105 	.db #0xfc	; 252
   4F38 FC                  106 	.db #0xfc	; 252
   4F39 FC                  107 	.db #0xfc	; 252
   4F3A FC                  108 	.db #0xfc	; 252
   4F3B FC                  109 	.db #0xfc	; 252
   4F3C                     110 _g_FRISBIFEO_1:
   4F3C FC                  111 	.db #0xfc	; 252
   4F3D FC                  112 	.db #0xfc	; 252
   4F3E FC                  113 	.db #0xfc	; 252
   4F3F FC                  114 	.db #0xfc	; 252
   4F40 FC                  115 	.db #0xfc	; 252
   4F41 FC                  116 	.db #0xfc	; 252
   4F42 FC                  117 	.db #0xfc	; 252
   4F43 FC                  118 	.db #0xfc	; 252
   4F44 FC                  119 	.db #0xfc	; 252
   4F45 FC                  120 	.db #0xfc	; 252
   4F46 FC                  121 	.db #0xfc	; 252
   4F47 FC                  122 	.db #0xfc	; 252
   4F48 FC                  123 	.db #0xfc	; 252
   4F49 A9                  124 	.db #0xa9	; 169
   4F4A 56                  125 	.db #0x56	; 86	'V'
   4F4B FC                  126 	.db #0xfc	; 252
   4F4C FC                  127 	.db #0xfc	; 252
   4F4D 16                  128 	.db #0x16	; 22
   4F4E 29                  129 	.db #0x29	; 41
   4F4F FC                  130 	.db #0xfc	; 252
   4F50 A9                  131 	.db #0xa9	; 169
   4F51 3C                  132 	.db #0x3c	; 60
   4F52 3C                  133 	.db #0x3c	; 60
   4F53 56                  134 	.db #0x56	; 86	'V'
   4F54 A9                  135 	.db #0xa9	; 169
   4F55 29                  136 	.db #0x29	; 41
   4F56 16                  137 	.db #0x16	; 22
   4F57 56                  138 	.db #0x56	; 86	'V'
   4F58 A9                  139 	.db #0xa9	; 169
   4F59 7C                  140 	.db #0x7c	; 124
   4F5A BC                  141 	.db #0xbc	; 188
   4F5B 56                  142 	.db #0x56	; 86	'V'
   4F5C A9                  143 	.db #0xa9	; 169
   4F5D 56                  144 	.db #0x56	; 86	'V'
   4F5E A9                  145 	.db #0xa9	; 169
   4F5F 56                  146 	.db #0x56	; 86	'V'
   4F60 A9                  147 	.db #0xa9	; 169
   4F61 7C                  148 	.db #0x7c	; 124
   4F62 BC                  149 	.db #0xbc	; 188
   4F63 56                  150 	.db #0x56	; 86	'V'
   4F64 A9                  151 	.db #0xa9	; 169
   4F65 29                  152 	.db #0x29	; 41
   4F66 16                  153 	.db #0x16	; 22
   4F67 56                  154 	.db #0x56	; 86	'V'
   4F68 A9                  155 	.db #0xa9	; 169
   4F69 3C                  156 	.db #0x3c	; 60
   4F6A 3C                  157 	.db #0x3c	; 60
   4F6B 56                  158 	.db #0x56	; 86	'V'
   4F6C FC                  159 	.db #0xfc	; 252
   4F6D 16                  160 	.db #0x16	; 22
   4F6E 29                  161 	.db #0x29	; 41
   4F6F FC                  162 	.db #0xfc	; 252
   4F70 FC                  163 	.db #0xfc	; 252
   4F71 A9                  164 	.db #0xa9	; 169
   4F72 56                  165 	.db #0x56	; 86	'V'
   4F73 FC                  166 	.db #0xfc	; 252
   4F74 FC                  167 	.db #0xfc	; 252
   4F75 FC                  168 	.db #0xfc	; 252
   4F76 FC                  169 	.db #0xfc	; 252
   4F77 FC                  170 	.db #0xfc	; 252
   4F78 FC                  171 	.db #0xfc	; 252
   4F79 FC                  172 	.db #0xfc	; 252
   4F7A FC                  173 	.db #0xfc	; 252
   4F7B FC                  174 	.db #0xfc	; 252
                            175 	.area _INITIALIZER
                            176 	.area _CABS (ABS)
