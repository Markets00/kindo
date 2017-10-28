                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module roboz2
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_roboz2_1
                             12 	.globl _g_roboz2_0
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
   4E10                      45 _g_roboz2_0:
   4E10 FC                   46 	.db #0xfc	; 252
   4E11 FC                   47 	.db #0xfc	; 252
   4E12 FC                   48 	.db #0xfc	; 252
   4E13 FC                   49 	.db #0xfc	; 252
   4E14 FC                   50 	.db #0xfc	; 252
   4E15 FC                   51 	.db #0xfc	; 252
   4E16 FC                   52 	.db #0xfc	; 252
   4E17 FC                   53 	.db #0xfc	; 252
   4E18 56                   54 	.db #0x56	; 86	'V'
   4E19 FC                   55 	.db #0xfc	; 252
   4E1A FC                   56 	.db #0xfc	; 252
   4E1B FC                   57 	.db #0xfc	; 252
   4E1C A9                   58 	.db #0xa9	; 169
   4E1D FC                   59 	.db #0xfc	; 252
   4E1E FC                   60 	.db #0xfc	; 252
   4E1F FC                   61 	.db #0xfc	; 252
   4E20 FC                   62 	.db #0xfc	; 252
   4E21 A9                   63 	.db #0xa9	; 169
   4E22 FC                   64 	.db #0xfc	; 252
   4E23 FC                   65 	.db #0xfc	; 252
   4E24 FC                   66 	.db #0xfc	; 252
   4E25 A8                   67 	.db #0xa8	; 168
   4E26 00                   68 	.db #0x00	; 0
   4E27 54                   69 	.db #0x54	; 84	'T'
   4E28 FC                   70 	.db #0xfc	; 252
   4E29 FC                   71 	.db #0xfc	; 252
   4E2A A8                   72 	.db #0xa8	; 168
   4E2B 03                   73 	.db #0x03	; 3
   4E2C 02                   74 	.db #0x02	; 2
   4E2D FC                   75 	.db #0xfc	; 252
   4E2E FC                   76 	.db #0xfc	; 252
   4E2F 01                   77 	.db #0x01	; 1
   4E30 A1                   78 	.db #0xa1	; 161
   4E31 02                   79 	.db #0x02	; 2
   4E32 FC                   80 	.db #0xfc	; 252
   4E33 FC                   81 	.db #0xfc	; 252
   4E34 03                   82 	.db #0x03	; 3
   4E35 29                   83 	.db #0x29	; 41
   4E36 02                   84 	.db #0x02	; 2
   4E37 FC                   85 	.db #0xfc	; 252
   4E38 A9                   86 	.db #0xa9	; 169
   4E39 03                   87 	.db #0x03	; 3
   4E3A 01                   88 	.db #0x01	; 1
   4E3B 03                   89 	.db #0x03	; 3
   4E3C FC                   90 	.db #0xfc	; 252
   4E3D A9                   91 	.db #0xa9	; 169
   4E3E 03                   92 	.db #0x03	; 3
   4E3F 01                   93 	.db #0x01	; 1
   4E40 57                   94 	.db #0x57	; 87	'W'
   4E41 FC                   95 	.db #0xfc	; 252
   4E42 A9                   96 	.db #0xa9	; 169
   4E43 03                   97 	.db #0x03	; 3
   4E44 03                   98 	.db #0x03	; 3
   4E45 06                   99 	.db #0x06	; 6
   4E46 FC                  100 	.db #0xfc	; 252
   4E47 A9                  101 	.db #0xa9	; 169
   4E48 29                  102 	.db #0x29	; 41
   4E49 03                  103 	.db #0x03	; 3
   4E4A 03                  104 	.db #0x03	; 3
   4E4B FC                  105 	.db #0xfc	; 252
   4E4C BC                  106 	.db #0xbc	; 188
   4E4D 3C                  107 	.db #0x3c	; 60
   4E4E 03                  108 	.db #0x03	; 3
   4E4F 02                  109 	.db #0x02	; 2
   4E50 FC                  110 	.db #0xfc	; 252
   4E51 BC                  111 	.db #0xbc	; 188
   4E52 3C                  112 	.db #0x3c	; 60
   4E53 03                  113 	.db #0x03	; 3
   4E54 02                  114 	.db #0x02	; 2
   4E55 FC                  115 	.db #0xfc	; 252
   4E56 BC                  116 	.db #0xbc	; 188
   4E57 28                  117 	.db #0x28	; 40
   4E58 29                  118 	.db #0x29	; 41
   4E59 02                  119 	.db #0x02	; 2
   4E5A FC                  120 	.db #0xfc	; 252
   4E5B FC                  121 	.db #0xfc	; 252
   4E5C 28                  122 	.db #0x28	; 40
   4E5D 00                  123 	.db #0x00	; 0
   4E5E 54                  124 	.db #0x54	; 84	'T'
   4E5F FC                  125 	.db #0xfc	; 252
   4E60 FC                  126 	.db #0xfc	; 252
   4E61 00                  127 	.db #0x00	; 0
   4E62 01                  128 	.db #0x01	; 1
   4E63 FC                  129 	.db #0xfc	; 252
   4E64 FC                  130 	.db #0xfc	; 252
   4E65 FC                  131 	.db #0xfc	; 252
   4E66 FC                  132 	.db #0xfc	; 252
   4E67 A9                  133 	.db #0xa9	; 169
   4E68 FC                  134 	.db #0xfc	; 252
   4E69 FC                  135 	.db #0xfc	; 252
   4E6A FC                  136 	.db #0xfc	; 252
   4E6B FC                  137 	.db #0xfc	; 252
   4E6C 56                  138 	.db #0x56	; 86	'V'
   4E6D FC                  139 	.db #0xfc	; 252
   4E6E FC                  140 	.db #0xfc	; 252
   4E6F FC                  141 	.db #0xfc	; 252
   4E70 FC                  142 	.db #0xfc	; 252
   4E71 FC                  143 	.db #0xfc	; 252
   4E72 FC                  144 	.db #0xfc	; 252
   4E73 FC                  145 	.db #0xfc	; 252
   4E74                     146 _g_roboz2_1:
   4E74 FC                  147 	.db #0xfc	; 252
   4E75 FC                  148 	.db #0xfc	; 252
   4E76 FC                  149 	.db #0xfc	; 252
   4E77 FC                  150 	.db #0xfc	; 252
   4E78 FC                  151 	.db #0xfc	; 252
   4E79 FC                  152 	.db #0xfc	; 252
   4E7A FC                  153 	.db #0xfc	; 252
   4E7B A9                  154 	.db #0xa9	; 169
   4E7C FC                  155 	.db #0xfc	; 252
   4E7D FC                  156 	.db #0xfc	; 252
   4E7E FC                  157 	.db #0xfc	; 252
   4E7F FC                  158 	.db #0xfc	; 252
   4E80 FC                  159 	.db #0xfc	; 252
   4E81 56                  160 	.db #0x56	; 86	'V'
   4E82 FC                  161 	.db #0xfc	; 252
   4E83 FC                  162 	.db #0xfc	; 252
   4E84 FC                  163 	.db #0xfc	; 252
   4E85 FC                  164 	.db #0xfc	; 252
   4E86 56                  165 	.db #0x56	; 86	'V'
   4E87 FC                  166 	.db #0xfc	; 252
   4E88 FC                  167 	.db #0xfc	; 252
   4E89 FC                  168 	.db #0xfc	; 252
   4E8A 00                  169 	.db #0x00	; 0
   4E8B 00                  170 	.db #0x00	; 0
   4E8C FC                  171 	.db #0xfc	; 252
   4E8D FC                  172 	.db #0xfc	; 252
   4E8E FC                  173 	.db #0xfc	; 252
   4E8F 01                  174 	.db #0x01	; 1
   4E90 03                  175 	.db #0x03	; 3
   4E91 54                  176 	.db #0x54	; 84	'T'
   4E92 FC                  177 	.db #0xfc	; 252
   4E93 A8                  178 	.db #0xa8	; 168
   4E94 52                  179 	.db #0x52	; 82	'R'
   4E95 03                  180 	.db #0x03	; 3
   4E96 54                  181 	.db #0x54	; 84	'T'
   4E97 FC                  182 	.db #0xfc	; 252
   4E98 03                  183 	.db #0x03	; 3
   4E99 16                  184 	.db #0x16	; 22
   4E9A 03                  185 	.db #0x03	; 3
   4E9B 54                  186 	.db #0x54	; 84	'T'
   4E9C FC                  187 	.db #0xfc	; 252
   4E9D 03                  188 	.db #0x03	; 3
   4E9E 02                  189 	.db #0x02	; 2
   4E9F 03                  190 	.db #0x03	; 3
   4EA0 56                  191 	.db #0x56	; 86	'V'
   4EA1 FC                  192 	.db #0xfc	; 252
   4EA2 03                  193 	.db #0x03	; 3
   4EA3 02                  194 	.db #0x02	; 2
   4EA4 03                  195 	.db #0x03	; 3
   4EA5 FE                  196 	.db #0xfe	; 254
   4EA6 FC                  197 	.db #0xfc	; 252
   4EA7 03                  198 	.db #0x03	; 3
   4EA8 03                  199 	.db #0x03	; 3
   4EA9 03                  200 	.db #0x03	; 3
   4EAA 5C                  201 	.db #0x5c	; 92
   4EAB FC                  202 	.db #0xfc	; 252
   4EAC 3C                  203 	.db #0x3c	; 60
   4EAD 03                  204 	.db #0x03	; 3
   4EAE 03                  205 	.db #0x03	; 3
   4EAF 56                  206 	.db #0x56	; 86	'V'
   4EB0 FC                  207 	.db #0xfc	; 252
   4EB1 3C                  208 	.db #0x3c	; 60
   4EB2 29                  209 	.db #0x29	; 41
   4EB3 03                  210 	.db #0x03	; 3
   4EB4 54                  211 	.db #0x54	; 84	'T'
   4EB5 FC                  212 	.db #0xfc	; 252
   4EB6 3C                  213 	.db #0x3c	; 60
   4EB7 29                  214 	.db #0x29	; 41
   4EB8 03                  215 	.db #0x03	; 3
   4EB9 54                  216 	.db #0x54	; 84	'T'
   4EBA FC                  217 	.db #0xfc	; 252
   4EBB 3C                  218 	.db #0x3c	; 60
   4EBC 14                  219 	.db #0x14	; 20
   4EBD 03                  220 	.db #0x03	; 3
   4EBE 54                  221 	.db #0x54	; 84	'T'
   4EBF FC                  222 	.db #0xfc	; 252
   4EC0 BC                  223 	.db #0xbc	; 188
   4EC1 00                  224 	.db #0x00	; 0
   4EC2 00                  225 	.db #0x00	; 0
   4EC3 FC                  226 	.db #0xfc	; 252
   4EC4 FC                  227 	.db #0xfc	; 252
   4EC5 A8                  228 	.db #0xa8	; 168
   4EC6 00                  229 	.db #0x00	; 0
   4EC7 56                  230 	.db #0x56	; 86	'V'
   4EC8 FC                  231 	.db #0xfc	; 252
   4EC9 FC                  232 	.db #0xfc	; 252
   4ECA FC                  233 	.db #0xfc	; 252
   4ECB FC                  234 	.db #0xfc	; 252
   4ECC 56                  235 	.db #0x56	; 86	'V'
   4ECD FC                  236 	.db #0xfc	; 252
   4ECE FC                  237 	.db #0xfc	; 252
   4ECF FC                  238 	.db #0xfc	; 252
   4ED0 FC                  239 	.db #0xfc	; 252
   4ED1 A9                  240 	.db #0xa9	; 169
   4ED2 FC                  241 	.db #0xfc	; 252
   4ED3 FC                  242 	.db #0xfc	; 252
   4ED4 FC                  243 	.db #0xfc	; 252
   4ED5 FC                  244 	.db #0xfc	; 252
   4ED6 FC                  245 	.db #0xfc	; 252
   4ED7 FC                  246 	.db #0xfc	; 252
                            247 	.area _INITIALIZER
                            248 	.area _CABS (ABS)
