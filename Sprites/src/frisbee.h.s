;; =========================
;; =========================
;; FRISBEE PUBLIC FUNCTIONS
;; =========================
;; =========================
.globl frisbee_erase
.globl frisbee_update
.globl frisbee_draw
.globl frisbee_data
.globl frisbee_setOff
.globl frisbee_setEffect
.globl frisbee_setVelocities
.globl frisbee_checkGoal
	
.equ Frisbee_effect_I, 23
.equ Frisbee_effect_F, 24
.equ std_eff, 0x0008
.equ std_N_eff, 0xFFF8