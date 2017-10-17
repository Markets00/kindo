;; ====================================
;; ====================================
;; ENTITY PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl entityDraw
.globl entityErase
.globl entityCheckCollision
.globl entityUpdatePhysics

.macro defineEntity name, x,y, h, w, vx, vy, ax, ay, onOff, clr
	name'_data::
		name'_x:	.db x		;; X coordinate			(8 bits)
		name'_y:	.db y		;; Y coordinate			(8 bits)
		name'_h:	.db h		;; Height			(8 bits)
		name'_w:	.db w		;; Width			(8 bits)
		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
		name'_onOff:	.db onOff	;; Entity enabled/disabled	(8 bits)
		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
.endm


;; ====================================
;; ====================================
;; ENTITY PUBLIC DATA
;; ====================================
;; ====================================
.equ Ent_x, 	0	;; X coordinate
.equ Ent_y, 	1	;; Y coordinate
.equ Ent_h, 	2	;; Height
.equ Ent_w, 	3	;; Width
.equ Ent_vx_I,	4	;; Velocity at X axis, integer part
.equ Ent_vx_F,	5	;; Velocity at X axis, fractional part
.equ Ent_vy_I,	6	;; Velocity at Y axis, integer part
.equ Ent_vy_F,	7	;; Velocity at Y axis, fractional part
.equ Ent_ax_I,	8	;; Acceleration at X axis, integer part
.equ Ent_ax_F,	9	;; Acceleration at X axis, fractional part
.equ Ent_ay_I,	10	;; Acceleration at Y axis, integer part
.equ Ent_ay_F,	11	;; Acceleration at Y axis, fractional part
.equ Ent_onOff,	12	;; Entity enabled/disabled
.equ Ent_clr, 	13	;; Entity color pattern	
