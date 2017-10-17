std_acc = 30 	;; standard acceleration per frame

.area _DATA
.area _CODE
.include "utility.h.s"
.include "entity.h.s"
.include "frisbee.h.s"
.include "keyboard/keyboard.s"

;; ====================================
;; ====================================
;; PRIVATE DATA
;; ====================================
;; ====================================

;; .macro defineEntity name, x, y, h, w, vx, vy, ax, ay, onOff, clr

defineEntity player, #39, #80, #16, #4, #0000, #0000, #0000, #0000, #1, #0xF0

defineEntity enemy, #80-4, #100, #16, #4, #0000, #0000, #0000, #0000, #1, #0xFF

	
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

player_update::
	call checkUserInput

	ld 	ix, #player_data
	call entityUpdatePhysics
	ld 	ix, #enemy_data
	call entityUpdatePhysics
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
	push 	ix
	call 	checkFrisbeeCollision 	;; A == collision/no_collision
	pop 	ix
	cp 	#0			;; A == 0?
	jr	nz, collision_right 	;; checkFrisbeeCollision != 0?

		;; no_collision
		ld 	Ent_ax_I(ix), #0
		ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)


		ret

	collision_right:
		call 	frisbee_setOff

		ret

;; ===============================================
;; Acelera la entidad hacia abajo, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveDown:
	push 	ix
	call 	checkFrisbeeCollision 	;; A == collision/no_collision
	pop 	ix
	cp 	#0			;; A == 0?
	jr	nz, collision_down 	;; checkFrisbeeCollision != 0?

		;; no_collision
		ld 	Ent_ay_I(ix), #0
		ld 	Ent_ay_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)

		ret

	collision_down:
		call 	frisbee_setOff

		ret

;; ===============================================
;; Acelera la entidad hacia la izquierda, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveLeft:
	push 	ix
	call 	checkFrisbeeCollision 	;; A == collision/no_collision
	pop 	ix
	cp 	#0			;; A == 0?
	jr	nz, collision_left 	;; checkFrisbeeCollision != 0?

		;; no_collision
		ld 	Ent_ax_I(ix), #-1
		ld 	Ent_ax_F(ix), #-std_acc	;; Ent_ax <= FF(-1)E2(-30) (-30)

		ret

	collision_left:
		call 	frisbee_setOff
	cant_move_left:
	ret

;; ===============================================
;; Acelera la entidad hacia arriba, si puede
;; Entrada:
;; 	IX <= puntero a los datos de la entidad
;; Modifica A, IX
;; ===============================================
moveUp:
	push 	ix
	call 	checkFrisbeeCollision 	;; A == collision/no_collision
	pop 	ix
	cp 	#0			;; A == 0?
	jr	nz, collision_up 	;; checkFrisbeeCollision != 0?

		;; no_collision
		ld 	Ent_ay_I(ix), #-1
		ld 	Ent_ay_F(ix), #-std_acc	;; Ent_ay <= FF(-1)E2(-30) (-30)

		ret

	collision_up:
		call 	frisbee_setOff
	cant_move_up:
	ret



;; ============================
;; Lee la entrada del teclado
;; Modifica AF, BC, DE, HL
;; ============================
checkUserInput:
	call cpct_scanKeyboard_asm

	ld 	ix, #player_data
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

	ret
