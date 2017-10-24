.area _DATA
.area _CODE
.include "utility.h.s"
.include "game.h.s"



;; ====================================
;; ====================================
;; PUBLIC DATA
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
.equ Ent_clr, 		21	;; Entity color pattern
.equ Ent_id, 		22	;; Numeric ID
				;; Frisbee 	0
				;; Player1 	1
				;; Enemy1	2

.equ MAX_VEL_X, 3 
.equ MIN_VEL_X, -3
.equ MAX_VEL_Y, 3
.equ MIN_VEL_Y, -3


;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================

;; ===================================
;; Pinta una entidad en pantalla
;; Entrada:
;; 	IX => Pointer to entity data 
;; Modifica AF, BC, DE, HL
;; ===================================
entityDraw::
	call 	getVideoPtr		;; HL <= Video memory pointer
	ex 	de, hl			;; DE <= HL (Video memory pointer)
	ld 	c, Ent_x_I(ix) 		;; C = ent_x_I
	ld 	b, Ent_y_I(ix) 		;; B = ent_y_I
	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer

	ex 	de, hl 			;; DE = ent screen pointer
	ld 	b, Ent_h(ix) 		;; B = ent height
	ld 	c, Ent_w(ix) 		;; C = ent width
	ld 	a, Ent_clr(ix)		;; A = ent colour
	call cpct_drawSolidBox_asm

	call updateX
	call updateY
	ret

;; ===================================
;; Borra una entidad de la pantalla
;; Entrada:
;; 	IX => Pointer to entity data 
;; Modifica AF, BC, DE, HL
;; ===================================
entityErase::
	call 	getVideoPtr		;; HL <= Video memory pointer
	ex 	de, hl			;; DE <= HL (Video memory pointer)
	ld 	c, Ent_erase_x(ix)	;; C = ent_erase_x
	ld 	b, Ent_erase_y(ix)	;; B = ent_erase_y
	call cpct_getScreenPtr_asm 	;; HL = ent screen pointer

	ex 	de, hl 			;; DE = ent screen pointer
	ld 	a, #0x00 		;; A = background color
	ld 	b, Ent_h(ix) 		;; B = ent height
	ld 	c, Ent_w(ix) 		;; C = ent width
	call cpct_drawSolidBox_asm

	ret

;; =========================================
;; Actualiza el estado de las físicas
;; 	de una entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica F, DE, HL
;; =========================================
entityUpdatePhysics::
	;; vx' = vx + ax
	ld 	h, Ent_vx_I(ix)
	ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
	ld 	d, Ent_ax_I(ix)
	ld 	e, Ent_ax_F(ix)		;; DE <= ent_ax

	add 	hl, de 			;; HL <= HL + DE (ent_vx + ent_ax)

	ld 	a, h
	cp 	#MAX_VEL_X
	jp 	p, cant_accelerate_x
		;; vx' < MAX_VEL_X
		cp 	#MIN_VEL_X
		jp 	m, cant_accelerate_x
			;; vx' > MIN_VEL_X
			;; Can accelerate at X axis
			ld 	Ent_vx_I(ix), h
			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL

	cant_accelerate_x:
	;; vx' > MAX_VEL_X || vx' < MIN_VEL_X


	;; vy = vy + ay
	ld 	h, Ent_vy_I(ix)
	ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
	ld 	d, Ent_ay_I(ix)
	ld 	e, Ent_ay_F(ix)		;; DE <= ent_ay

	add 	hl, de 			;; HL <= HL + DE (ent_vy + ent_ay)
	ld 	a, h
	cp 	#MAX_VEL_Y
	jp 	p, cant_accelerate_y
		;; vy' < MIN_VEL_Y
		cp 	#MIN_VEL_Y
		jp 	m, cant_accelerate_y
			;; vy' > MIN_VEL_Y
			;; Can accelerate at Y axis
			ld 	Ent_vy_I(ix), h
			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL

	cant_accelerate_y:

	;; Apply deceleration X axis
	ld 	a, Ent_vx_I(ix)		;; A <= vx_I
	cp 	#0
	;;jr 	z, cant_decelerate_x	;; vx_I == 0?
		;; vx_I != 0
	jp	m, vx_negative
		;; vx positive

		ld 	h, Ent_N_I(ix)
		ld 	l, Ent_N_F(ix)		;; HL <= ent_N

		call 	negateHL		;; HL <= -ent_N

		ld 	d, h
		ld 	e, l			;; DE <= -ent_N

		ld 	h, Ent_vx_I(ix)
		ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx

		add 	hl, de
		jr	c, can_decelerate_x

		jr can_decelerate_x

	vx_negative:
		jr 	z, cant_decelerate_x	;; vx_I == 0?

		ld 	h, Ent_vx_I(ix)
		ld 	l, Ent_vx_F(ix)		;; HL <= ent_vx
		ld 	d, Ent_N_I(ix)
		ld 	e, Ent_N_F(ix)		;; DE <= ent_N

		add 	hl, de
		jr	c, can_decelerate_x

		can_decelerate_x:
			ld 	Ent_vx_I(ix), h
			ld 	Ent_vx_F(ix), l		;; Ent_vx <= HL

	cant_decelerate_x:

	;; Apply deceleration Y axis
	ld 	a, Ent_vy_I(ix)		;; A <= vy_I
	cp 	#0
	;;jr 	z, cant_decelerate_y	;; vy_I == 0?
		;; vy_I != 0
		jp	m, vy_negative

			;; vy positive
			ld 	h, Ent_N_I(ix)
			ld 	l, Ent_N_F(ix)		;; HL <= ent_N

			call 	negateHL		;; HL <= -ent_N

			ld 	d, h
			ld 	e, l			;; DE <= -ent_N

			ld 	h, Ent_vy_I(ix)
			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy

			add 	hl, de
			jr	c, can_decelerate_y

			jr can_decelerate_y

		vy_negative:
			ld 	h, Ent_vy_I(ix)
			ld 	l, Ent_vy_F(ix)		;; HL <= ent_vy
			ld 	d, Ent_N_I(ix)
			ld 	e, Ent_N_F(ix)		;; DE <= ent_N

			add 	hl, de
			jr	c, can_decelerate_y

			can_decelerate_y:
				ld 	Ent_vy_I(ix), h
				ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL

	cant_decelerate_y:

	ld 	Ent_ax_I(ix), #0	;; 
	ld 	Ent_ax_F(ix), #0	;; ax = 0
	ld 	Ent_ay_I(ix), #0	;; 
	ld 	Ent_ay_F(ix), #0	;; ay = 0

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

	ld 	a, Ent_x_I(ix)		;; A <= ent1_x
	add 	Ent_w(ix)		;; A <= A + ent1_w
	ld 	ix, (ent2_ptr)		;; IX <= ent 2
	sub 	Ent_x_I(ix)		;; A <= A - ent2_x
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
		ld 	a, Ent_x_I(ix)		;; A <= ent2_x
		add 	Ent_w(ix) 		;; A <= A + ent2_w
		ld 	ix, (ent1_ptr)		;; IX <= ent 1
		sub 	Ent_x_I(ix)		;; A <= A - ent1_x
		jp 	p, collision_XL		;; A > 0? lo contrario a A <= 0

		jr 	no_collision
	;; Hay colisión en el eje X e Y, ent2 está entre la izda y la dcha de ent1
	collision_XL:
		;;
		;; If (ent1_y + ent1_h <= ent2_y) no collision
		;; ent1_y + ent1_h - ent2_y <= 0
		;;
		ld 	a, Ent_y_I(ix)		;; A <= ent1_x
		add 	Ent_h(ix)		;; A <= A + ent1_w
		ld 	ix, (ent2_ptr)		;; IX <= ent 2
		sub 	Ent_y_I(ix)		;; A <= A - ent2_x
		jp 	p, collision_YB		;; A > 0? lo contrario a A <= 0

		jr 	no_collision

	;; Puede haber colisión en el eje Y, ent2 está por arriba de ent1
	collision_YB:
		;;
		;; If (ent2_y + ent2_h <= ent1_y) no collision
		;; ent2_y + ent2_h - ent1_y <= 0
		;; 
		ld 	a, Ent_y_I(ix)		;; A <= ent2_y
		add 	Ent_h(ix) 		;; A <= A + ent2_h
		ld 	ix, (ent1_ptr)		;; IX <= ent 1
		sub 	Ent_y_I(ix)		;; A <= A - ent1_y
		jp 	p, collision_YT		;; A > 0? lo contrario a A <= 0

		jr 	no_collision

	;; Hay colisión en el eje Y, ent2 está entre arriba y abajo de ent1
	collision_YT:

	;; A == ent1_x + ent1_w - ent2_x, A es mínimo 1
	ld 	a, b

	ret

	no_collision:
	ld 	a, #0 	;; A == 0 si no hay colisión
	ret


;; =========================================
;; Actualiza la posición de la entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica AF, B, DE, HL, IX
;; =========================================
entityUpdatePosition::

	;; x' = x + vx_I
	ld 	d, Ent_vx_I(ix) 	
	ld 	e, Ent_vx_F(ix)		;; DE <= ent_vx

	ld 	h, Ent_x_I(ix) 		;; 
	ld 	l, Ent_x_F(ix)		;; HL <= Ent_x

	add 	hl, de 			;; HL <= HL + DE (x + vx)

	ld 	a, h 			;; B <= H (x_I + vx_I) integer part
	cp 	#LEFT_LIMIT
	jp 	m, check_left		;; LIMIT_LEFT > x_I + vx_I? can't move
		;; can move left
		add 	Ent_w(ix) 		;; A <= w + x_I + vx_I
		ld	b, a
		ld 	a, #RIGHT_LIMIT
		cp	b
		jr 	c, check_right	;; RIGHT_LIMIT < w + x_I + vx_I? can't move
			;; can move
			call setX 		;; Ent_x <= HL (x + vx)

			jr check_y

	check_left:
		ld 	h, #LEFT_LIMIT
		ld 	l, #0
		call	setX 			;; Ent_x <= LEFT_LIMIT
			jr check_y

	check_right:
		ld 	a, #RIGHT_LIMIT
		sub	a, Ent_w(ix)
		ld 	h, a
		ld 	l, #0
		call	setX 			;; Ent_x <= RIGHT_LIMIT

	check_y:
	;; y' = y + vy_I*2
	ld 	d, Ent_vy_I(ix) 	
	ld 	e, Ent_vy_F(ix)		;; DE <= ent_vy

	ld 	h, Ent_y_I(ix) 		;; 
	ld 	l, Ent_y_F(ix)		;; HL <= Ent_y

	add 	hl, de 			;; HL <= HL + DE (y + vy)
	add 	hl, de 			;; HL <= HL + DE (y + vy)

	ld 	a,h	 		;; A <= H (y_I + vy_I) integer part
	cp 	#TOP_LIMIT
	jp 	c, check_top		;; TOP_LIMIT > y_I + vy_I? can't move
		;; can move up
		ld 	a, h
		add 	Ent_h(ix) 		;; A <= h + y_I + vy_I
		ld	b, a
		ld 	a, #BOTTOM_LIMIT
		cp	b
		jp 	c, check_bot		;; BOTTOM_LIMIT < h + y_I + vy_I? can't move
			;; can move
			call 	setY			;; Ent_y <= HL (y + vy)

			ret

	;; CONTROL STRUCTURES: http://tutorials.eeems.ca/ASMin28Days/lesson/day07.html

	check_top:
		ld 	h, #TOP_LIMIT
		ld 	l, #0
		call 	setY				;; Ent_y <= TOP_LIMIT
		jr bounce

	check_bot:
		ld 	a, #BOTTOM_LIMIT
		sub	a, Ent_h(ix)
		ld 	h, a
		ld 	l, #0
		call 	setY				;; Ent_y <= BOTTOM_LIMIT

	bounce:
			ld 	h, Ent_vy_I(ix)
			ld 	l, Ent_vy_F(ix)		;; HL <= Ent_vy

			call 	negateHL

			ld 	Ent_vy_I(ix), h
			ld 	Ent_vy_F(ix), l		;; Ent_vy <= HL negated

		ret

;; =========================================
;; Inverts HL value
;; Entrada:
;; 	HL => value we are going to negate
;; Modifica AF, HL
;; Devuelve:
;; 	HL <= HL value negated
;; =========================================
negateHL::
	ld 	a, #0			;;
	xor	a			;;
	sub	l			;;
	ld	l,a			;;
	sbc	a,a			;;
	sub	h			;;
	ld	h,a			;; negate HL

	ret

;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================



;; =========================================
;; Modifica la x de la entidad a la pasada
;; 	por parámetro
;; Entrada:
;; 	IX => Pointer to entity data
;; 	HL => value we are going to set
;; Modifica AF
;; =========================================
setX:
	ld	Ent_x_I(ix), h
	ld	Ent_x_F(ix), l		;; Ent_x_I <= HL

	ret


;; =========================================
;; Modifica las de últimas posiciones X
;	de la entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica AF
;; =========================================
updateX:
	ld	a, Ent_last_x(ix)
	ld 	Ent_erase_x(ix), a	;; Ent_erase_x <= Ent_last_x

	ld	a, Ent_x_I(ix)
	ld 	Ent_last_x(ix), a	;; Ent_last_x <= Ent_x_I
	ret


;; =========================================
;; Modifica la y de la entidad a la pasada
;; 	por parámetro
;; Entrada:
;; 	IX => Pointer to entity data
;; 	HL => value we are going to set
;; Modifica AF
;; =========================================
setY:

	ld	Ent_y_I(ix), h
	ld	Ent_y_F(ix), l		;; Ent_y_I <= HL

	ret


;; =========================================
;; Modifica las de últimas posiciones Y
;	de la entidad
;; Entrada:
;; 	IX => Pointer to entity data
;; Modifica AF
;; =========================================
updateY:
	ld	a, Ent_last_y(ix)
	ld 	Ent_erase_y(ix), a	;; Ent_erase_y <= Ent_last_y

	ld	a, Ent_y_I(ix)
	ld 	Ent_last_y(ix), a	;; Ent_last_y <= Ent_y_I
	ret