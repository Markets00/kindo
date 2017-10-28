.area _DATA
.area _CODE

.include "entity.h.s"
.include "utility.h.s"
.include "game.h.s"


frisbee_size = 25		;; Size of frisbee structure
pos_min_vel = 0x00D0
neg_min_vel = 0xFF30
;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

.equ Frisbee_effect_I, 23
.equ Frisbee_effect_F, 24
.equ std_eff, 0x0008
.equ std_N_eff, 0xFFF8


;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id

defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #1, #0x0F, #0
	frisbee_effect: .dw #0xF8FF									;; effect

defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
	init_effect: .dw #0xF8FF									;; effect



;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================


;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================

;; =========================================
;; Desactiva el frisbee
;; Modifica A
;; =========================================
frisbee_setOff::
	ld 	a, #0
	ld 	(frisbee_state), a
	ret

;; ================================================
;; Reinicia los datos de la entidad recibida en ix
;; Recibe:
;; 	IX <= pointer to entity data
;; Modifica: HL, IX
;; ================================================
frisbee_restart::
	ld	h, Ent_last_x(ix)	;; H <= last_x
	ld	l, Ent_erase_x(ix)	;; L <= erase_x
	push	hl			;; push last_x and erase_x

	ld	h, Ent_last_y(ix)	;; H <= last_y
	ld	l, Ent_erase_y(ix)	;; L <= erase_y
	push	hl			;; push last_y and erase_y

	.dw	0x54DD			;; ld	d, ixh	undocumented opcodes
	.dw	0x5DDD			;; ld	e, ixl	undocumented opcodes
	ld	hl, #init_data
	ld	bc, #frisbee_size
	call cpct_memcpy_asm		;; Ititialize Frisbee

	pop	hl
	ld	Ent_last_y(ix), h	;; last_y <= H
	ld	Ent_erase_y(ix), l	;; erase_y <= L

	pop	hl
	ld	Ent_last_x(ix), h	;; last_x <= H
	ld	Ent_erase_x(ix), l	;; erase_x <= L

frisbee_erase::
	ld 	ix, #frisbee_data
	call entityErase		;; Pintar cuadrado azul fondo

	ret


;; ================================================
;; Modifica el valor de la velocidad del frisbee
;; 	en el eje X e Y, al recibido en HL y DE
;;	Si la velocidad en el eje X es menor que 1
;; 	la modifica a mínimo 1 (positivo y neg)
;; Recibe:
;;	 A <= entity ID
;; 	HL <= X axis velocity
;; 	DE <= Y axis velocity
;; Modifica: A, HL, IX
;; ================================================
frisbee_setVelocities::
	ld 	ix, #frisbee_data

	cp 	#1
	jr	z, player_1				;; Ent_id == 1?
		;; player 2
		ld	a, h
		cp 	#0
		jp	p, less_than_minus_one		;; Is VX positive? 

		ld	a, #1
		cp	h
		jr	nc, less_than_minus_one
			;; vx greater than minus one
			jr set_vels
		less_than_minus_one:
			ld	hl, #neg_min_vel
			jr set_vels
	negative_vx:

	player_1:
		ld	a, h
		cp 	#0
		jp	m, less_than_one		;; Is VX negative? 

		ld	a, h
		cp	#1
		jr	c, less_than_one
			;; vx greater than one
			jr set_vels
		less_than_one:
			ld	hl, #pos_min_vel


	set_vels:
	ld 	Ent_vx_I(ix), h
	ld 	Ent_vx_F(ix), l
	ld 	Ent_vy_I(ix), d
	ld 	Ent_vy_F(ix), e
	ret




;; ===========================================
;; Modifica el valor del efecto del frisbee
;; 	al recibido en HL
;; Recibe:
;; 	HL <= Effect value
;; ===========================================
frisbee_setEffect::
	ld 	ix, #frisbee_data
	ld 	Frisbee_effect_I(ix), h
	ld 	Frisbee_effect_F(ix), l
	ret

;; =========================================
;; Actualiza el estado del frisbee
;; Modifica A
;; =========================================
frisbee_update::

	ld 	a, (frisbee_state)	;; A <= frisbee_state
	cp 	#1
	jr 	nz, not_active		;; A != 1?
	
		;; Active
		ld 	ix, #frisbee_data
		call frisbee_applyEffect 	
		call entityUpdatePhysics
		call entityUpdatePosition
		ret

	not_active:
		ld 	a, #1
		ld 	(frisbee_state), a
	ret

frisbee_draw::

	ld 	ix, #frisbee_data
	call entityDraw 		;; Pintar cuadrado azul cian

	ret
	
;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================


;; ===========================================
;; Mueve el frisbee a la izquierda un píxel
;; Recibe:
;; 	IX <= Pointer to entity data
;; Modifica A
;; ===========================================
frisbee_applyEffect:

	;; vy' = vy + ay
	ld 	h, Ent_vy_I(ix)
	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
	ld 	d, Frisbee_effect_I(ix)
	ld 	e, Frisbee_effect_F(ix)	;; DE <= frisbee_effect

	add 	hl, de 			;; HL <= HL + DE (ent_vy + frisbee_effect)

	ld 	Ent_vy_I(ix), h
	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL

	ret


;; ===========================================
;; Comprueba si el frisbee está en posición
;;	de gol
;; Recibe:
;; 	IX <= Pointer to entity data
;; Modifica A
;; ===========================================
frisbee_checkGoal::
	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
	cp	#LEFT_LIMIT
	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
		;; left goal
		push ix
		call incTeam2Points
		pop ix
		jr	goal

	no_left_goal:
		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
		cp	#RIGHT_LIMIT
		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
			;; right goal
			push ix
			call incTeam1Points
			pop ix
	goal:
		call frisbee_restart

	no_right_goal:
	ret