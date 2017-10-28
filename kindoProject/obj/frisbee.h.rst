ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; =========================
                              2 ;; =========================
                              3 ;; FRISBEE PUBLIC FUNCTIONS
                              4 ;; =========================
                              5 ;; =========================
                              6 .globl frisbee_erase
                              7 .globl frisbee_update
                              8 .globl frisbee_draw
                              9 .globl frisbee_data
                             10 .globl frisbee_setOff
                             11 .globl frisbee_setEffect
                             12 .globl frisbee_setVelocities
                             13 .globl frisbee_checkGoal
                             14 
                             15 .globl _sprite_frisbee_1_0
                             16 .globl _sprite_frisbee_1_1
                             17 	
                     0018    18 .equ Frisbee_effect_I, 24
                     0019    19 .equ Frisbee_effect_F, 25
                     0008    20 .equ std_eff, 0x0008
                     FFF8    21 .equ std_N_eff, 0xFFF8
