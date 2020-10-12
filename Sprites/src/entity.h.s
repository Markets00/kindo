;; ====================================
;; ====================================
;; ENTITY PUBLIC FUNCTIONS
;; ====================================
;; ====================================
.globl entityDraw
.globl entityErase
.globl entityCheckCollision
.globl entityUpdatePhysics
.globl entityUpdatePosition

.macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, sprite, id
	name'_data::
		name'_x:	.dw x		;; X coordinate			(16 bits)
		name'_y:	.dw y		;; Y coordinate			(16 bits)
		name'_h:	.db h		;; Height			(8 bits)
		name'_w:	.db w		;; Width			(8 bits)
		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
		name'_normal:	.dw normal	;; Normal force			(16 bits)
		name'_last_x:	.db x		;; Last x rendered		(8 bits)
		name'_erase_x:	.db x		;; x rendered at same buffer	(8 bits)
		name'_last_y:	.db y		;; Last y rendered		(8 bits)
		name'_erase_y:	.db y		;; y rendered at same buffer	(8 bits)
		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
		name'_sp:	.dw sprite		;; Entity sprite pointer		(16 bits)
		name'_id:	.db id		;; Numeric ID			(8 bits)
.endm


;; ====================================
;; ====================================
;; ENTITY PUBLIC DATA
;; ====================================
;; ====================================
.equ Ent_x_I, 		0	;; X coordinate, integer part
.equ Ent_x_F, 		1	;; X coordinate, fractional part
.equ Ent_y_I, 		2	;; Y coordinate, integer part
.equ Ent_y_F, 		3	;; Y coordinate, fractional part
.equ Ent_h, 		4	;; Height
.equ Ent_w, 		5	;; Width
.equ Ent_vx_I,		6	;; Velocity at X axis, integer part
.equ Ent_vx_F,		7	;; Velocity at X axis, fractional part
.equ Ent_vy_I,		8	;; Velocity at Y axis, integer part
.equ Ent_vy_F,		9	;; Velocity at Y axis, fractional part
.equ Ent_ax_I,		10	;; Acceleration at X axis, integer part
.equ Ent_ax_F,		11	;; Acceleration at X axis, fractional part
.equ Ent_ay_I,		12	;; Acceleration at Y axis, integer part
.equ Ent_ay_F,		13	;; Acceleration at Y axis, fractional part
.equ Ent_N_I,		14	;; Normal force, integer part
.equ Ent_N_F,		15	;; Normal force, fractional part
.equ Ent_last_x,	16	;; Last x rendered
.equ Ent_erase_x,	17	;; x rendered at same buffer
.equ Ent_last_y,	18	;; Last y rendered
.equ Ent_erase_y,	19	;; y rendered at same buffer
.equ Ent_state,		20	;; Entity enabled/disabled
.equ Ent_sp_l, 		21	;; Entity sprite pointer
.equ Ent_sp_h, 		22	;; Entity sprite pointer
.equ Ent_id, 		23	;; Numeric ID
				;; Frisbee 	0
				;; Player1 	1
				;; Enemy1	2

.equ MAX_VEL_X, 3 
.equ MIN_VEL_X, -3
.equ MAX_VEL_Y, 3
.equ MIN_VEL_Y, -3