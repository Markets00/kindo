std_acc = 32 	;; standard acceleration per frame

.area _DATA
.area _CODE
.include "utility.h.s"
.include "entity.h.s"
.include "frisbee.h.s"
.include "game.h.s"
.include "keyboard/keyboard.h.s"
.globl _moveIA

;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================

;; .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id

defineEntity player, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xF0, #1

defineEntity enemy, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x1800, #1, #0xFF, #2


defineEntity player_2, #0x0010, #0x0050, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xF0, #1


defineEntity enemy_2, #0x0050-0x0004, #0x0064, #20, #5, #0000, #0000, #0000, #0000, #0x0400, #1, #0xFF, #2
	
;; ====================================
;; ====================================
;; PUBLIC FUNCTIONS
;; ====================================
;; ====================================
player_erase::
	ld 	ix, #player_data
	call 	entityErase		;; Erase player
	ld 	ix, #enemy_data
	call 	entityErase		;; Erase enemy

	ret

;; =========================================
;; Actualiza el estado de los entities tipo
;;	player
;; Modifica: AF, IX
;; =========================================
player_update::
	ld 	ix, #player_data
	call checkUserInput

;;	ld 	ix, #enemy_data
;;	call checkUserInput

	call move_IA

	ld 	ix, #player_data
	call entityUpdatePhysics
	ld 	ix, #enemy_data
	call entityUpdatePhysics

	ld 	ix, #player_data
	call entityUpdatePosition
	ld 	ix, #enemy_data
	call entityUpdatePosition


	ld 	ix, #player_data
	call checkCenterCrossing
	ld 	ix, #enemy_data
	call checkCenterCrossing
	ret

player_draw::
	ld 	ix, #player_data
	call 	entityDraw		;; Draw player
	ld 	ix, #enemy_data
	call 	entityDraw		;; Draw enemy

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
;; =========================================
delta:


update:

;; =========================================
;; Invierte los datos para poder operarlos
;;	en C
;; Entrada:
;;	IX <= Pointer to entity data
;;	Modifica: BC
;; =========================================
invert_variables:
	;; Inverts X
	ld	b,	Ent_x_I(ix)
	ld	c,	Ent_x_F(ix)
	ld	Ent_x_I(ix), c
	ld	Ent_x_F(ix), b

	;; Inverts Y
	ld	b,	Ent_y_I(ix)
	ld	c,	Ent_y_F(ix)
	ld	Ent_y_I(ix), c
	ld	Ent_y_F(ix), b

	;; Inverts AX
	ld	b, Ent_ax_I(ix)		 
	ld	c, Ent_ax_F(ix)		 
	ld	Ent_ax_I(ix), c		 
	ld	Ent_ax_F(ix), b		

	;; Inverts AY
	ld	b, Ent_ay_I(ix)		 
	ld	c, Ent_ay_F(ix)		 
	ld	Ent_ay_I(ix), c		 
	ld	Ent_ay_F(ix), b		

	;; FALTARIA EFECTO, CUIDAO

	ret

move_IA:

	ld	ix, #frisbee_data
	push 	ix
	call 	invert_variables
	ld	ix, #player_data
	push 	ix
	call 	invert_variables
	ld	ix, #enemy_data
	push 	ix
	call 	invert_variables
	call _moveIA			;; moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee)
	
	pop 	ix
	pop 	ix
	pop 	ix

	ld	ix, #frisbee_data
	call 	invert_variables
	ld	ix, #player_data
	call 	invert_variables
	ld	ix, #enemy_data
	call 	invert_variables


	ret
	
;; =========================================
;; Comprueba si la entidad colisiona con 
;; 	el frisbee
;; Entrada:
;; 	IX <= puntero al player a comparar
;; 		con el frisbee
;; Modifica: AF, B, HL, IX
;; Devuelve:
;; 	A <= 	0 si no hay colisión
;; 		>1 si hay colisión
;; =========================================
checkFrisbeeCollision:
	ld 	hl, #frisbee_data	;; HL <= frisbee_data
	call 	entityCheckCollision 	;; A <= collison/no_collision

	ret


;; ===============================================
;; Acelera la entidad hacia la derecha, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveRight:
	;; push 	ix
	;; call 	checkFrisbeeCollision 	;; A == collision/no_collision
	;; pop 	ix
	;; cp 	#0			;; A == 0?
	;; jr	nz, collision_right 	;; checkFrisbeeCollision != 0?

		;; no_collision
		ld 	Ent_ax_I(ix), #0
		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)


		ret

	;;collision_right:
	;;	call 	frisbee_setOff
	;;
	;;	ret

;; ===============================================
;; Acelera la entidad hacia abajo, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveDown:
	ld 	Ent_ay_I(ix), #0
	ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)

	ret

;; ===============================================
;; Acelera la entidad hacia la izquierda, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveLeft:
	ld 	Ent_ax_I(ix), #-1
	ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)

	ret

;; ===============================================
;; Acelera la entidad hacia arriba, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveUp:
	ld 	Ent_ay_I(ix), #-1
	ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)

	ret


;; ===========================================
;; Chequea si un jugador pasa del centro del
;; 	campo y lo corrige en caso necesario
;; Entrada:
;; 	IX <= pointer to entity data
;; Modifica AF, BC, DE, HL
;; ===========================================
checkCenterCrossing:
	ld 	a, Ent_id(ix)
	cp 	#1
	jr	z, player_1
		cp	#2
		jr	nz, invalid_id
			;; player 2
			ld	a, #CENTER_LIMIT				;; A <= Ent_x, integer part
			cp	Ent_x_I(ix)
			jr	c, not_crossed				;; Ent_x <= CENTER_LIMIT? center crossed
				;; center limit crossed
				ld	Ent_x_I(ix), #CENTER_LIMIT
				jr not_crossed

	player_1:
			ld	a, Ent_x_I(ix)				;; A <= Ent_x, integer part
			add	a, Ent_w(ix)				;; A <= Ent_x + Ent_w
			cp	#CENTER_LIMIT
			jr	c, not_crossed				;; Ent_x + Ent_w > CENTER_LIMIT? center crossed
				;; center limit crossed
				ld	a, #CENTER_LIMIT
				sub	Ent_w(ix)			;; A <= CENTER_LIMIT - Ent_w
				ld	Ent_x_I(ix), a			;; Ent_x = CENTER_LIMIT - Ent_w

	invalid_id:
	not_crossed:
	ret


;; ====================================
;; Lee la entrada del teclado
;; Entrada:
;; 	IX <= pointer to entity data
;; Modifica AF, BC, DE, HL, IX
;; ====================================
checkUserInput:
	call cpct_scanKeyboard_asm						;;;;; TO DO DESACOPLAR ESTE CÓDIGO PARA QUE JUEGUEN 2 JUGADORES ;;;;;;;;;;

	ld 	a, Ent_id(ix)
	cp	#1
	jp	nz, player_2
		;; Player 1
		ld 	hl, #Key_D			;; HL = D Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, d_not_pressed
			;; D is pressed
			call 	moveRight	
		d_not_pressed:

		ld 	hl, #Key_A			;; HL = A Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, a_not_pressed
			;; A is pressed	
			call 	moveLeft
		a_not_pressed:

		ld 	hl, #Key_W			;; HL = W Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, w_not_pressed
			;; W is pressed
			call 	moveUp	
		w_not_pressed:

		ld 	hl, #Key_S			;; HL = S Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, s_not_pressed
			;; S is pressed	
			call 	moveDown
		s_not_pressed:
		jr five_not_pressed

	player_2:
		ld 	hl, #Key_F6			;; HL = F6 Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, six_not_pressed
			;; D is pressed
			call 	moveRight	
		six_not_pressed:

		ld 	hl, #Key_F4			;; HL = F4 Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, four_not_pressed
			;; A is pressed	
			call 	moveLeft
		four_not_pressed:

		ld 	hl, #Key_F8			;; HL = F8 Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, eight_not_pressed
			;; W is pressed
			call 	moveUp	
		eight_not_pressed:

		ld 	hl, #Key_F5			;; HL = F5 Keycode
		call 	cpct_isKeyPressed_asm 		;; A = True/False
		cp 	#0 				;; A == 0?
		jr 	z, five_not_pressed
			;; S is pressed	
			call 	moveDown
		five_not_pressed:



	call checkVandB
	ret


;; ====================================
;; Funcion auxiliar para leer V y B
;;	de la entrada por teclado
;; Entrada:
;; 	IX <= pointer to entity data
;; Modifica AF, BC, DE, HL
;; ====================================
checkVandB:
	push 	ix
	call 	checkFrisbeeCollision 	;; A == collision/no_collision
	pop 	ix
	cp 	#0			;; A == 0?
	jp	z, no_collision 	;; checkFrisbeeCollision == 0?
		;; There is collision

		ld 	a, Ent_id(ix)
		cp	#1
		jr	nz, player_2_vorb
			;; Player 1

			ld 	hl, #Key_V			;; HL = V Keycode
			call 	cpct_isKeyPressed_asm 		;; A = True/False
			cp 	#0 				;; A == 0?
			jr 	z, v_not_pressed
				;; V is pressed	
				ld 	hl, #Key_B			;; HL = B Keycode
				call 	cpct_isKeyPressed_asm 		;; A = True/False
				cp 	#0 				;; A == 0?
				jr 	z, just_v_pressed
					;; V and B are pressed
					ld 	hl, #0			;; HL <= standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia abajo
					pop 	ix
					jr vorb_pressed
				just_v_pressed:
					ld 	hl, #std_N_eff		;; HL <= -standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia arriba
					pop 	ix
					jr 	vorb_pressed
			v_not_pressed:

				ld 	hl, #Key_B			;; HL = B Keycode
				call 	cpct_isKeyPressed_asm 		;; A = True/False
				cp 	#0 				;; A == 0?
				jr 	z, b_not_pressed
					;; B is pressed
					ld 	hl, #std_eff		;; HL <= standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia abajo
					pop 	ix

					vorb_pressed:
					ld	a, Ent_id(ix)		;;
					ld	h, Ent_vx_I(ix)		;;
					ld	l, Ent_vx_F(ix)		;;
					ld	d, Ent_vy_I(ix)		;;
					ld	e, Ent_vy_F(ix)		;;
					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee

					jr o_not_pressed
	player_2_vorb:

			ld 	hl, #Key_I			;; HL = I Keycode
			call 	cpct_isKeyPressed_asm 		;; A = True/False
			cp 	#0 				;; A == 0?
			jr 	z, i_not_pressed
				;; I is pressed	
				ld 	hl, #Key_O			;; HL = O Keycode
				call 	cpct_isKeyPressed_asm 		;; A = True/False
				cp 	#0 				;; A == 0?
				jr 	z, just_i_pressed
					;; I and O are pressed
					ld 	hl, #0			;; HL <= standard effect
					call frisbee_setEffect		;; efecto hacia abajo
					jr ioro_pressed
				just_i_pressed:
					ld 	hl, #std_N_eff		;; HL <= -standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia arriba
					pop 	ix
					jr 	ioro_pressed
			i_not_pressed:

				ld 	hl, #Key_O			;; HL = O Keycode
				call 	cpct_isKeyPressed_asm 		;; A = True/False
				cp 	#0 				;; A == 0?
				jr 	z, o_not_pressed
					;; O is pressed
					ld 	hl, #std_eff		;; HL <= standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia abajo
					pop 	ix

					ioro_pressed:
					ld	a, Ent_id(ix)		;;
					ld	h, Ent_vx_I(ix)		;;
					ld	l, Ent_vx_F(ix)		;;
					ld	d, Ent_vy_I(ix)		;;
					ld	e, Ent_vy_F(ix)		;;
					call frisbee_setVelocities	;; transferimos las velocidades de la entidad al frisbee


	no_collision:
	b_not_pressed:
	o_not_pressed:
	ret