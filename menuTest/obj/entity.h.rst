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
                             12 	
                             13 .globl _sprite_palette
                             14 
                             15 .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, sprite, id
                             16 	name'_data::
                             17 		name'_x:	.dw x		;; X coordinate			(16 bits)
                             18 		name'_y:	.dw y		;; Y coordinate			(16 bits)
                             19 		name'_h:	.db h		;; Height			(8 bits)
                             20 		name'_w:	.db w		;; Width			(8 bits)
                             21 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
                             22 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
                             23 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
                             24 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
                             25 		name'_normal:	.dw normal	;; Normal force			(16 bits)
                             26 		name'_last_x:	.db x		;; Last x rendered		(8 bits)
                             27 		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
                             28 		name'_last_y:	.db y		;; Last y rendered		(8 bits)
                             29 		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
                             30 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
                             31 		name'_sprite:	.dw sprite	;; Entity sprite		(16 bits)
                             32 		name'_id:	.db id		;; Numeric ID			(8 bits)
                             33 .endm
                             34 
                             35 
                             36 ;; ====================================
                             37 ;; ====================================
                             38 ;; ENTITY PUBLIC DATA
                             39 ;; ====================================
                             40 ;; ====================================
                     0000    41 .equ Ent_x_I, 		0	;; X coordinate, integer part
                     0001    42 .equ Ent_x_F, 		1	;; X coordinate, fractional part
                     0002    43 .equ Ent_y_I, 		2	;; Y coordinate, integer part
                     0003    44 .equ Ent_y_F, 		3	;; Y coordinate, fractional part
                     0004    45 .equ Ent_h, 		4	;; Height
                     0005    46 .equ Ent_w, 		5	;; Width
                     0006    47 .equ Ent_vx_I,		6	;; Velocity at X axis, integer part
                     0007    48 .equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
                     0008    49 .equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
                     0009    50 .equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
                     000A    51 .equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
                     000B    52 .equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
                     000C    53 .equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
                     000D    54 .equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
                     000E    55 .equ Ent_N_I,		14	;; Normal force, integer part
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     000F    56 .equ Ent_N_F,		15	;; Normal force, fractional part
                     0010    57 .equ Ent_last_x,	16	;; Last x rendered
                     0011    58 .equ Ent_erase_x,	17	;; x rendered at same buffer
                     0012    59 .equ Ent_last_y,	18	;; Last y rendered
                     0013    60 .equ Ent_erase_y,	19	;; y rendered at same buffer
                     0014    61 .equ Ent_state,		20	;; Entity enabled/disabled
                     0015    62 .equ Ent_sprite_H, 	21	;; Pointer to sprite, high part
                     0016    63 .equ Ent_sprite_L, 	22	;; Pointer to sprite, low part
                     0017    64 .equ Ent_id, 		23	;; Numeric ID
                             65 				;; Frisbee 	0
                             66 				;; Player1 	1
                             67 				;; Enemy1	2
                             68 
                     0003    69 .equ MAX_VEL_X, 3 
                     FFFFFFFD    70 .equ MIN_VEL_X, -3
                     0003    71 .equ MAX_VEL_Y, 3
                     FFFFFFFD    72 .equ MIN_VEL_Y, -3
