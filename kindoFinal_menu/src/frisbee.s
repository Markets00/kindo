.area _DATA
.area _CODE

.include "entity.h.s"
.include "utility.h.s"
.include "game.h.s"
.include "sprites.h.s"

.globl _sprite_frisbee_1_0
.globl _sprite_frisbee_1_1

pos_min_vel = 0x00D0
neg_min_vel = 0xFF30
;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

frisbee_size = 29		;; Size of frisbee structure

.equ Frisbee_effect_I, 27
.equ Frisbee_effect_F, 28
.equ std_eff, 0x0008
.equ std_N_eff, 0xFFF8


;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, sprites_ptr, id

defineEntity frisbee, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0100, #0x0100, #frisbee_sprites, #0
	frisbee_effect: .dw #0xF8FF									;; effect

defineEntity init, #0x0027, #0x0054, #16, #4, #0x10FF, #0000, #0000, #0000, #0x0100, #frisbee_sprites, #0
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
	call update_frisbee_animation	;; A <= update / not update
	cp 	#0
	jr 	z, not_active		;; A == 0? not active
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
	
;; =========================================
;; Desactiva el frisbee
;; Modifica A
;; Entrada:
;; 	A <= State number to set
;; =========================================
frisbee_setState::
	ld 	(frisbee_state), a
	ret

;; =============================================
;; Actualiza el sprite que se tiene que
;; 	dibujar en este frame
;; Entrada:
;;	IX <= Pointer to player data
;; Modifica: 
;; Devuelve:
;; 	A => 1 that state have to update physics
;;	  => 0 that state not update physics
;; =============================================
update_frisbee_animation::
	call 	animation_delta
	ld 	Ent_signal(ix), #-1
	ret

;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================

;; =========================================
;; Determina el siguiente estado de
;;	la entidad
;; Entrada:
;;	IX <= Pointer to player data
;; =========================================
animation_delta:
	ld	a, Ent_state(ix)

	cp	#-1
	jr	z, anim_disabled
		;; Firsbee active
		cp	#0
		jr	nz, not_zero
			;; STATE 0 - frisbee step 1 state ;;
			call frisbee0_state
			ret
		not_zero:
		cp	#1
		jr	nz, not_one
			;; STATE 1 - frisbee step 2 state ;;
			call frisbee1_state
			ret
		not_one:

		ret
	anim_disabled:

	ld a, #0	;; A <= Not update physics
	ret


;; ======================================
;; 	Frisbee 1 State #1
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
frisbee0_state:
	ld Ent_sprite(ix), #0	;; Next sprite <= 30
	;; ld a, Ent_state(ix)	;;
	;; ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #1	;; Next state <= 0

	ld a, #1		;; A <= Update physics
	ret

;; ======================================
;; 	Frisbee 1 State #1
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
frisbee1_state:
	ld Ent_sprite(ix), #1	;; Next sprite <= 30
	;; ld a, Ent_state(ix)	;;
	;; ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0

	ld a, #1		;; A <= Update physics
	ret

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