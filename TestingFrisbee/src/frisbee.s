.area _DATA
.area _CODE

.include "entity.h.s"
.include "utility.h.s"
.include "game.h.s"

.equ Frisbee_effect_I, 19
.equ Frisbee_effect_F, 20
.equ std_eff, 0x0800

frisbee_size = 21		;; Size of frisbee structure

;; ====================================
;; ====================================
;; PUBLIC DATA
;; ====================================
;; ====================================

;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id

defineEntity frisbee, #0x0027, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
	frisbee_effect: .dw #0xF8FF									;; effect

defineEntity init, #0x0027, #0x0054, #8, #2, #0x10FF, #0000, #0000, #0000, #0x0100, #1, #0x0F, #0
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

frisbee_restart::
	;; Input Parameters (6 Bytes)
	;; (2B DE) to	Pointer to the destination (first byte where bytes will be written)
	;; (2B HL) from	Pointer to the source (first byte from which bytes will be read)
	;; (2B BC) size	Number of bytes to be set (>= 1)
	ld	de, #frisbee_data
	ld	hl, #init_data
	ld	bc, #frisbee_size
	call cpct_memcpy_asm		;; Ititialize Frisbee

frisbee_erase::
	ld 	ix, #frisbee_data
	call entityErase		;; Pintar cuadrado azul fondo

	ret


;; ================================================
;; Modifica el valor de la velocidad del frisbee
;; 	en el eje X e Y, al recibido en HL y DE
;; Recibe:
;; 	HL <= X axis velocity
;; 	DE <= Y axis velocity
;; Modifica: HL, IX
;; ================================================
frisbee_setVelocities::
	ld 	ix, #frisbee_data
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
		call frisbee_checkGoal
		;; call moveLeft
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
frisbee_checkGoal:
	ld 	a, Ent_x_I(ix)		;; A <= Ent_x_I
	cp	#LEFT_LIMIT
	jr	nz, no_left_goal	;; Ent_x != LEFT_LIMIT? no goal
		;; left goal
		ld	a, (Game_t2points)
		inc	a
		ld	(Game_t2points), a	;; Inc team 2 points
		jr	goal

	no_left_goal:
		add 	a, Ent_w(ix)		;; A <= Ent_x + Ent_w
		cp	#RIGHT_LIMIT
		jr	nz, no_right_goal	;; Ent_x + Ent_w != RIGHT_LIMIT? no goal
			;; right goal
			ld	a, (Game_t1points)
			inc	a
			ld	(Game_t1points), a 	;; Inc team 1 points

	goal:
		call frisbee_restart

	no_right_goal:
	ret


;; =========================================
;; Mueve el frisbee a la derecha un píxel
;; Modifica A
;; =========================================
moveRight:
	ld 	a, (frisbee_x) 		;; A = frisbee_x
	cp 	#80-3 			;; A == right_limit - frisbee_width?
	jr 	z, cant_move_right 		
		inc 	a 		;; move right one pixel
		ld 	(frisbee_x), a
	cant_move_right:
	ret

;; =========================================
;; Mueve el frisbee abajo un píxel
;; Modifica A
;; =========================================
moveDown:
	ld 	a, (frisbee_y) 		;; A = frisbee_x
	cp 	#200-12 		;; A == bottom_limit - frisbee_height?
	jr 	z, cant_move_down 		
		inc 	a 		;; move down one pixel
		ld 	(frisbee_y), a
	cant_move_down:
	ret

;; ===========================================
;; Mueve el frisbee a la izquierda un píxel
;; Recibe:
;; 	IX <= Pointer to entity data
;; Modifica A
;; ===========================================
moveLeft:
	ld 	a, Ent_x_I(IX) 		;; A = frisbee_x
	cp 	#0 			;; A == left_limit?
	jr 	nz, can_move_left 
		ld 	a, #80-2 	;; restore initial position
		ld 	Ent_x_I(IX), a
		;; ld 	a, #80
		;; ld 	(frisbee_y), a	
		jr 	cant_move_left
	can_move_left:	
		ld	ix, #frisbee_data
		ld 	Ent_ax_I(ix), #-1
		ld 	Ent_ax_F(ix), #-128	;; Ent_ax <= FF(-1)80(-128) (-128)

	cant_move_left:
	ret

;; =========================================
;; Mueve el frisbee arriba un píxel
;; Modifica A
;; =========================================
moveUp:
	ld 	a, (frisbee_y) 		;; A = frisbee_y
	cp 	#0 			;; A == top_limit?
	jr 	z, cant_move_up 		
		dec 	a 		;; move up one pixel
		ld 	(frisbee_y), a
	cant_move_up:
	ret

;; ================================================
;; Pinta un cuadrado en pantalla del color elegido
;; Entrada:
;; 	A => Colour Pattern
;; Modifica AF, BC, DE, HL
;; ================================================
drawFrisbee:
	push 	af 
	ld 	de, #0xC000 		;; Video memory  pointer
	ld 	a, (frisbee_x) 
	ld 	c, a			;; C = frisbee_x
	ld 	a, (frisbee_y) 
	ld 	b, a 			;; B = frisbee_y
	call cpct_getScreenPtr_asm 	;; HL = frisbee screen pointer

	ex 	de, hl 			;; DE = frisbee screen pointer
	pop 	af 			;; A = User selected colour
	ld 	bc, #0x0802		;; 8x8 píxeles
	call cpct_drawSolidBox_asm

	ret