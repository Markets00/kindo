;; ====================================
;; ====================================
;; ENTITY PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl entityDraw
.globl entityErase
.globl entityCheckCollision
.globl entityUpdatePhysics

.macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr
	name'_data::
		name'_x:	.dw x		;; X coordinate			(16 bits)
		name'_y:	.dw y		;; Y coordinate			(16 bits)
		name'_h:	.db h		;; Height			(8 bits)
		name'_w:	.db w		;; Width			(8 bits)
		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
.endm


;; ====================================
;; ====================================
;; ENTITY PUBLIC DATA
;; ====================================
;; ====================================
.equ Ent_x_F, 	0	;; X coordinate, low part
.equ Ent_x_I, 	1	;; X coordinate, high part
.equ Ent_y_F, 	2	;; Y coordinate, low part
.equ Ent_y_I, 	3	;; Y coordinate, high part
.equ Ent_h, 	4	;; Height
.equ Ent_w, 	5	;; Width
.equ Ent_vx_I,	6	;; Velocity at X axis, integer part
.equ Ent_vx_F,	7	;; Velocity at X axis, fractional part
.equ Ent_vy_I,	8	;; Velocity at Y axis, integer part
.equ Ent_vy_F,	9	;; Velocity at Y axis, fractional part
.equ Ent_ax_I,	10	;; Acceleration at X axis, integer part
.equ Ent_ax_F,	11	;; Acceleration at X axis, fractional part
.equ Ent_ay_I,	12	;; Acceleration at Y axis, integer part
.equ Ent_ay_F,	13	;; Acceleration at Y axis, fractional part
.equ Ent_state,	14	;; Entity enabled/disabled
.equ Ent_clr, 	15	;; Entity color pattern
