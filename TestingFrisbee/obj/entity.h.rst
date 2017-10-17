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
                             11 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr
                             12 	name'_data::
                             13 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             14 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             15 		name'_h:	.db h		;; Height			(8 bits)
                             16 		name'_w:	.db w		;; Width			(8 bits)
                             17 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             18 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             19 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             20 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             21 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             22 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             23 .endm
                             24 
                             25 
                             26 ;; ====================================
                             27 ;; ====================================
                             28 ;; ENTITY PUBLIC DATA
                             29 ;; ====================================
                             30 ;; ====================================
                     0000    31 .equ Ent_x_F, 	0	;; X coordinate, low part
                     0001    32 .equ Ent_x_I, 	1	;; X coordinate, high part
                     0002    33 .equ Ent_y_F, 	2	;; Y coordinate, low part
                     0003    34 .equ Ent_y_I, 	3	;; Y coordinate, high part
                     0004    35 .equ Ent_h, 	4	;; Height
                     0005    36 .equ Ent_w, 	5	;; Width
                     0006    37 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    38 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    39 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    40 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    41 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    42 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    43 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    44 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    45 .equ Ent_state,	14	;; Entity enabled/disabled
                     000F    46 .equ Ent_clr, 	15	;; Entity color pattern
