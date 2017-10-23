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
                             10 .globl entityUpdatePosition
                             11 
                             12 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
                             13 	name'_data::
                             14 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             15 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             16 		name'_h:	.db h		;; Height			(8 bits)
                             17 		name'_w:	.db w		;; Width			(8 bits)
                             18 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             19 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             20 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             21 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             22 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             23 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             24 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
                             25 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             26 .endm
                             27 
                             28 
                             29 ;; ====================================
                             30 ;; ====================================
                             31 ;; ENTITY PUBLIC DATA
                             32 ;; ====================================
                             33 ;; ====================================
                     0000    34 .equ Ent_x_I, 	0	;; X coordinate, integer part
                     0001    35 .equ Ent_x_F, 	1	;; X coordinate, fractional part
                     0002    36 .equ Ent_y_I, 	2	;; Y coordinate, integer part
                     0003    37 .equ Ent_y_F, 	3	;; Y coordinate, fractional part
                     0004    38 .equ Ent_h, 	4	;; Height
                     0005    39 .equ Ent_w, 	5	;; Width
                     0006    40 .equ Ent_vx_I,	6	;; Velocity at X axis, integer part
                     0007    41 .equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
                     0008    42 .equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
                     0009    43 .equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
                     000A    44 .equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
                     000B    45 .equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
                     000C    46 .equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
                     000D    47 .equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
                     000E    48 .equ Ent_N_I,	14	;; Normal force, integer part
                     000F    49 .equ Ent_N_F,	15	;; Normal force, fractional part
                     0010    50 .equ Ent_state,	16	;; Entity enabled/disabled
                     0011    51 .equ Ent_clr, 	17	;; Entity color pattern
                     0012    52 .equ Ent_id, 	18	;; Numeric ID
                             53 			;; Frisbee 	0
                             54 			;; Player1 	1
                             55 			;; Enemy1	2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
                     0002    57 .equ MAX_VEL_X, 2 
                     FFFFFFFE    58 .equ MIN_VEL_X, -2
                     0004    59 .equ MAX_VEL_Y, 4
                     FFFFFFFC    60 .equ MIN_VEL_Y, -4
