ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; ====================================
                              2 ;; ====================================
                              3 ;; ENTITY PUBLIC FUNCTIONS
                              4 ;; ====================================
                              5 ;; ====================================
                              6 .globl entityDraw
                              7 .globl entityErase
                              8 .globl entityCheckCollision
                              9 .globl entityUpdatePhysics
                             10 
                             11 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, onOff, clr
                             12 	name'_data::
                             13 		name'_x:	.db x		;; X coordinate			(8 bits)
                             14 		name'_y:	.db y		;; Y coordinate			(8 bits)
                             15 		name'_h:	.db h		;; Height			(8 bits)
                             16 		name'_w:	.db w		;; Width			(8 bits)
                             17 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             18 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             19 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             20 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             21 		name'_onOff:	.db onOff	;; Entity enabled/disabled	(8 bits)
                             22 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             23 .endm
                             24 
                     0000    25 .equ Ent_x, 	0	;; X coordinate
                     0001    26 .equ Ent_y, 	1	;; Y coordinate
                     0002    27 .equ Ent_h, 	2	;; Height
                     0003    28 .equ Ent_w, 	3	;; Width
                     0004    29 .equ Ent_vx_I,	4	;; Velocity at X axis, integer part
                     0005    30 .equ Ent_vx_F,	5	;; Velocity at X axis, fractional part
                     0006    31 .equ Ent_vy_I,	6	;; Velocity at Y axis, integer part
                     0007    32 .equ Ent_vy_F,	7	;; Velocity at Y axis, fractional part
                     0008    33 .equ Ent_ax_I,	8	;; Acceleration at X axis, integer part
                     0009    34 .equ Ent_ax_F,	9	;; Acceleration at X axis, fractional part
                     000A    35 .equ Ent_ay_I,	10	;; Acceleration at Y axis, integer part
                     000B    36 .equ Ent_ay_F,	11	;; Acceleration at Y axis, fractional part
                     000C    37 .equ Ent_onOff,	12	;; Entity enabled/disabled
                     000D    38 .equ Ent_clr, 	13	;; Entity color pattern	
