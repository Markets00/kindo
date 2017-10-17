.area _DATA
.area _CODE
.include "utility.h.s"
.include "game.h.s"

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


;; ===================================
;; Pinta una entidad en pantalla
;; Entrada:
;; 	IX => Pointer to entity data 
;; Modifica AF, BC, DE, HL
;; ===================================
entityDraw::
	ld 	de, #0xC000 		;; Video memory pointer
	ld 	c, Ent_x(ix) 		;; C = ent_x
	ld 	b, Ent_y(ix) 		;; B = ent_y
	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer

	ex 	de, hl 			;; DE = ent screen pointer
	ld 	b, Ent_h(ix) 		;; B = ent height
	ld 	c, Ent_w(ix) 		;; C = ent width
	ld 	a, Ent_clr(ix)		;; A = ent colour
	call cpct_drawSolidBox_asm

	ret

;; ===================================
;; Borra una entidad de la pantalla
;; Entrada:
;; 	IX => Pointer to entity data 
;; Modifica AF, BC, DE, HL
;; ===================================
entityErase::
	ld 	de, #0xC000 		;; Video memory  pointer
	ld 	c, 0(ix) 		;; C = ent_x
	ld 	b, 1(ix) 		;; B = ent_y
	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer

	ex 	de, hl 			;; DE = ent screen pointer
	ld 	a, #0x00 		;; A = background color
	ld 	b, Ent_h(ix) 		;; B = ent height
	ld 	c, Ent_w(ix) 		;; C = ent width
	call cpct_drawSolidBox_asm

	ret

;; =========================================
;; Actualiza la posición de la entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica AF, B, DE, HL, IX
;; =========================================
entityUpdatePosition:

	;; x = x + vx_I
	ld 	d, Ent_vx_I(ix) 	;; D <= ent_vx_I
	ld 	e, #0			;; E <= 0 (discard fractional part)

	ld 	h, Ent_x(ix) 		;; H <= Ent_x
	ld 	l, #0			;; L <= 0 (discard fractional part)

	add 	hl, de 			;; H <= H + D (x + vx_I)

	ld 	b, h 			;; B <= H (x + vx_I)
	ld 	a, #RIGHT_LIMIT
	sub 	Ent_w(IX) 		;; A <= RIGHT_LIMIT - Ent_width

	cp 	b			;; F <= A - B
	jp 	m, cant_move_x		;; RIGHT_LIMIT - Ent_width < x + vx_I? can't move

		ld 	a, #LEFT_LIMIT		;; A <= LEFT_LIMIT
		cp 	b 			;; F <= A - B
		jp 	p, cant_move_x		;; LIMIT_LEFT > x + vx_I? can't move

			;; can move
			ld 	Ent_x(ix), h 		;; Ent_x <= H

	cant_move_x:


	;; y = y + vy_I*2
	ld 	h, Ent_vy_I(ix) 	;; H <= ent_vy_I
	ld 	l, Ent_vy_F(ix)		;; L <= ent_vy_F

	ld 	d, Ent_y(ix) 		;; D <= Ent_y
	ld 	e, #0			;; E <= 0 (discard fractional part)

	;;add 	hl, hl 			;; H <= H(ent_vy_I)*2
					;; D <= ent_vy_I*2
	ex 	de, hl 			;; H <= Ent_y

	add 	hl, de 			;; H <= H (y) + D (y + ent_vy_I*2)

	ld 	b, h 			;; B <= H (y + ent_vy_I*2)
	ld 	a, #BOTTOM_LIMIT
	sub 	Ent_h(IX) 		;; A <= BOTTOM_LIMIT - Ent_height

	cp 	b			;; F <= A - B
	jp 	m, cant_move_y		;; BOTTOM_LIMIT - Ent_height < y + ent_vy_I*2? can't move

		ld 	a, #TOP_LIMIT		;; A <= TOP_LIMIT
		cp 	b 			;; F <= A - B
		jp 	p, cant_move_y		;; TOP_LIMIT > y + ent_vy_I*2? can't move

			;; can move
			ld 	Ent_y(ix), h 		;; Ent_y <= H

	cant_move_y:

		ret

;; =========================================
;; Actualiza el estado de las físicas
;; 	de una entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica F, DE, HL, IX
;; =========================================
entityUpdatePhysics::
	;; vx = vx + ax
	ld 	h, Ent_vx_I(ix)
	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
	ld 	d, Ent_ax_I(ix)
	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax

	add 	hl, de 			;; HL <= HL + DE
	ld 	Ent_vx_I(ix), h
	ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL


	;; vy = vy + ay
	ld 	h, Ent_vy_I(ix)
	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
	ld 	d, Ent_ay_I(ix)
	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay

	add 	hl, de 			;; HL <= HL + DE
	ld 	Ent_vy_I(ix), h
	ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL


	ld 	Ent_ax_I(ix), #0	;; 
	ld 	Ent_ax_F(ix), #0	;; ax = 0
	ld 	Ent_ay_I(ix), #0	;; 
	ld 	Ent_ay_F(ix), #0	;; ay = 0

	call entityUpdatePosition

	;; ld 	Ent_vx_I(ix), #0	;; 
	;; ld 	Ent_vx_F(ix), #0	;; vx = 0
	;; ld 	Ent_vy_I(ix), #0	;; 
	;; ld 	Ent_vy_F(ix), #0	;; vy = 0

	ret

;; =========================================
;; Comprueba si existe colision entre
;; dos entidades.
;; Entrada:
;; 	IX => Pointer to entity 1 data
;; 	HL => Pointer to entity 2 data
;; Modifica AF, B, HL, IX
;; Devuelve:
;; 	A <==== 0 si no hay colisión, y la
;; 		diferencia absoluta entre
;;		las x, en caso de colisión
;; =========================================
ent1_ptr: .dw #0000
ent2_ptr: .dw #0000
entityCheckCollision::
	;;
	;; If (ent1_x + ent1_w <= ent2_x) no collision
	;; ent1_x + ent1_w - ent2_x <= 0  no collision
	;;
	ld 	(ent1_ptr), ix 		;; ent1_ptr <= IX
	ld 	(ent2_ptr), hl 		;; ent2_ptr <= HL

	ld 	a, Ent_x(ix)		;; A <= ent1_x
	add 	Ent_w(ix)		;; A <= A + ent1_w
	ld 	ix, (ent2_ptr)		;; IX <= ent 2
	sub 	Ent_x(ix)		;; A <= A - ent2_x
	jp 	p, collision_XR		;; A > 0? lo contrario a A <= 0

	jr 	no_collision

	;; Puede haber colisión en el eje X, ent2 está por la izda de ent1
	collision_XR:
		;; Guardar en b el resultado de la anterior operación (ent1_x + ent1_w - ent2_x)
		ld 	b, a 		;; B <= A
		;;
		;; If (ent2_x + ent2_w <= ent1_x) no collision
		;; ent2_x + ent2_w - ent1_x <= 0
		;; 
		ld 	a, Ent_x(ix)		;; A <= ent2_x
		add 	Ent_w(ix) 		;; A <= A + ent2_w
		ld 	ix, (ent1_ptr)		;; IX <= ent 1
		sub 	Ent_x(ix)		;; A <= A - ent1_x
		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0

		jr 	no_collision
	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
	collision_XL:
		;;
		;; If (ent1_y + ent1_h <= ent2_y) no collision
		;; ent1_y + ent1_h - ent2_y <= 0
		;;
		ld 	a, Ent_y(ix)		;; A <= ent1_x
		add 	Ent_h(ix)		;; A <= A + ent1_w
		ld 	ix, (ent2_ptr)		;; IX <= ent 2
		sub 	Ent_y(ix)		;; A <= A - ent2_x
		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0

		jr 	no_collision

	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
	collision_YB:
		;;
		;; If (ent2_y + ent2_h <= ent1_y) no collision
		;; ent2_y + ent2_h - ent1_y <= 0
		;; 
		ld 	a, Ent_y(ix)		;; A <= ent2_y
		add 	Ent_h(ix) 		;; A <= A + ent2_h
		ld 	ix, (ent1_ptr)		;; IX <= ent 1
		sub 	Ent_y(ix)		;; A <= A - ent1_y
		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0

		jr 	no_collision

	;; Hay colisión en el eje Y, , ent2 está entre arriba y abajo de ent1
	collision_YT:

	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
	ld 	a, b

	ret

	no_collision:
	ld 	a, #0 	;; A == 0 si no hay colisión
	ret