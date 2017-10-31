;; =========================
;; =========================
;; FRISBEE PUBLIC FUNCTIONS
;; =========================
;; =========================
.globl frisbee_erase
.globl frisbee_update
.globl frisbee_draw
.globl frisbee_data
.globl frisbee_setEffect
.globl frisbee_setVelocities
.globl frisbee_checkGoal
.globl frisbee_setState
.globl update_frisbee_animation
	
.equ Frisbee_effect_I, 27
.equ Frisbee_effect_F, 28
.equ std_eff, 0x0008
.equ std_N_eff, 0xFFF8