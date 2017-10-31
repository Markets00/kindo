std_acc = 32 	;; standard acceleration per frame

.area _DATA
.area _CODE
.include "utility.h.s"
.include "entity.h.s"
.include "frisbee.h.s"
.include "game.h.s"
.include "keyboard/keyboard.s"
.include "sprites.h.s"
.globl _moveIA

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
player_erase::
	ld 	ix, #player_data
	call 	entityErase		;; Erase player
	ld 	ix, #enemy_data
	call 	entityErase		;; Erase enemy

	ret

;; =========================================
;; Actualiza el estado del player recibido
;; 	en IX
;; Entrada:
;;	IX => Pointer to player data
;; Modifica: AF, BC, DE, HL, IX
;; =========================================
player_update::

	ld	a, Ent_id(ix)
	cp	#2
	jr	z, check_IA		;; Ent_id == 2? check IA
	cp	#4
	jr	z, check_IA		;; Ent_id == 4? check IA
		;; check input
		push ix
		call checkUserInput
		pop ix
		call checkSignal
		jr continue_updating

	check_IA:
		call move_IA

	continue_updating:

	call update_player_animation
	call entityUpdatePhysics
	call entityUpdatePosition
	call checkCenterCrossing
	
	ret

;; ====================================
;; ====================================
;; PRIVATE FUNCTIONS
;; ====================================
;; ====================================

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
update_player_animation::
	call 	animation_delta
	ld 	Ent_signal(ix), #-1
	ret

;; =========================================
;; Determina el siguiente estado de
;;	la entidad
;; Entrada:
;;	IX <= Pointer to player data
;; =========================================
animation_delta:
	ld	a, Ent_state(ix)

	cp	#0
	jr	nz, not_zero
		;; STATE 0  ;;
		call origin_state
		ret
	not_zero:
	cp	#1
	jr	nz, not_one
		;; STATE 1 - Step up first state ;;
		call stepUp1_state
		ret
	not_one:
	cp	#2
	jr	nz, not_two
		;; STATE 2 - Step down first state ;;
		call stepDown1_state
		ret
	not_two:
	cp	#3
	jr	nz, not_three
		;; STATE 3 - Step right first state ;;
		call stepRight1_state
		ret
	not_three:
	cp	#4
	jr	nz, not_four
		;; STATE 4 - Step left first state ;;
		call stepLeft1_state
		ret
	not_four:
	cp	#5
	jr	nz, not_five
		;; STATE 5 - Step up-right first state ;;
		call stepUpRight1_state
		ret
	not_five:
	cp	#6
	jr	nz, not_six
		;; STATE 6 - Step up-left first state ;;
		call stepUpLeft1_state
		ret
	not_six:
	cp	#7
	jr	nz, not_seven
		;; STATE 7 - Step down-right first state ;;
		call stepDownRight1_state
		ret
	not_seven:
	cp	#8
	jr	nz, not_eight
		;; STATE 8 - Step down-left first state ;;
		call stepDownLeft1_state
		ret
	not_eight:
	cp	#9
	jr	nz, not_nine
		;; STATE 9 - Throwing up - first ;;
		call throwUp1_state
		ret
	not_nine:
	cp	#10
	jr	nz, not_ten
		;; STATE 10 - Throwing up ;;
		call throwUp2_state
		ret
	not_ten:
	cp	#11
	jr	nz, not_eleven
		;; STATE 11 - Throwing up ;;
		call throwUp3_state
		ret
	not_eleven:
	cp	#12
	jr	nz, not_twelve
		;; STATE 12 - Throwing up ;;
		call throwUp4_state
		ret
	not_twelve:
	cp	#13
	jr	nz, not_thirteen
		;; STATE 13 - Throwing up ;;
		call throwUp5_state
		ret
	not_thirteen:
	cp	#14
	jr	nz, not_fourteen
		;; STATE 14 - Throwing up ;;
		call throwUp6_state
		ret
	not_fourteen:
	cp	#15
	jr	nz, not_fiveteen
		;; STATE 15 - Throwing up - last ;;
		call throwUp7_state
		ret
	not_fiveteen:
	cp	#16
	jr	nz, not_sixteen
		;; STATE 16 - Throwing Down - first ;;
		call throwDown1_state
		ret
	not_sixteen:
	cp	#17
	jr	nz, not_seventeen
		;; STATE 17 - Throwing Down ;;
		call throwDown2_state
		ret
	not_seventeen:
	cp	#18
	jr	nz, not_eighteen
		;; STATE 18 - Throwing Down ;;
		call throwDown3_state
		ret
	not_eighteen:
	cp	#19
	jr	nz, not_nineteen
		;; STATE 19 - Throwing Down ;;
		call throwDown4_state
		ret
	not_nineteen:
	cp	#20
	jr	nz, not_twenty
		;; STATE 20 - Throwing Down ;;
		call throwDown5_state
		ret
	not_twenty:
	cp	#21
	jr	nz, not_twenty_one
		;; STATE 21 - Throwing Down ;;
		call throwDown6_state
		ret
	not_twenty_one:
	cp	#22
	jr	nz, not_twenty_two
		;; STATE 22 - Throwing Down - last ;;
		call throwDown7_state
		ret
	not_twenty_two:
	cp	#23
	jr	nz, not_twenty_three
		;; STATE 23 - Throwing straight - first ;;
		call throwStraight1_state
		ret
	not_twenty_three:
	cp	#24
	jr	nz, not_twenty_four
		;; STATE 24 - Throwing straight ;;
		call throwStraight2_state
		ret
	not_twenty_four:
	cp	#25
	jr	nz, not_twenty_five
		;; STATE 25 - Throwing straight ;;
		call throwStraight3_state
		ret
	not_twenty_five:
	cp	#26
	jr	nz, not_twenty_six
		;; STATE 26 - Throwing straight ;;
		call throwStraight4_state
		ret
	not_twenty_six:
	cp	#27
	jr	nz, not_twenty_seven
		;; STATE 27 - Throwing straight ;;
		call throwStraight5_state
		ret
	not_twenty_seven:
	cp	#28
	jr	nz, not_twenty_eight
		;; STATE 28 - Throwing straight ;;
		call throwStraight6_state
		ret
	not_twenty_eight:
	cp	#29
	jr	nz, not_twenty_nine
		;; STATE 29 - Throwing straight - last ;;
		call throwStraight7_state
		ret
	not_twenty_nine:
	cp	#30
	jr	nz, not_thirty
		;; STATE 30 - Step up second state ;;
		call stepUp2_state
		ret
	not_thirty:
	cp	#31
	jr	nz, not_thirty_one
		;; STATE 31 - Step up third state ;;
		call stepUp3_state
		ret
	not_thirty_one:
	cp	#32
	jr	nz, not_thirty_two
		;; STATE 31 - Step down second state ;;
		call stepDown2_state
		ret
	not_thirty_two:
	cp	#33
	jr	nz, not_thirty_three
		;; STATE 33 - Step down third state ;;
		call stepDown3_state
		ret
	not_thirty_three:
	cp	#34
	jr	nz, not_thirty_four
		;; STATE 34 - Step right second state ;;
		call stepRight2_state
		ret
	not_thirty_four:
	cp	#35
	jr	nz, not_thirty_five
		;; STATE 35 - Step right third state ;;
		call stepRight3_state
		ret
	not_thirty_five:
	cp	#36
	jr	nz, not_thirty_six
		;; STATE 36 - Step left second state ;;
		call stepLeft2_state
		ret
	not_thirty_six:
	cp	#37
	jr	nz, not_thirty_seven
		;; STATE 37 - Step left third state ;;
		call stepLeft3_state
		ret
	not_thirty_seven:
	cp	#38
	jr	nz, not_thirty_eight
		;; STATE 38 - Step up-right second state ;;
		call stepUpRight2_state
		ret
	not_thirty_eight:
	cp	#39
	jr	nz, not_thirty_nine
		;; STATE 39 - Step up-right third state ;;
		call stepUpRight3_state
		ret
	not_thirty_nine:
	cp	#40
	jr	nz, not_fourty
		;; STATE 40 - Step up-left second state ;;
		call stepUpLeft2_state
		ret
	not_fourty:
	cp	#41
	jr	nz, not_fourty_one
		;; STATE 41 - Step up-left third state ;;
		call stepUpLeft3_state
		ret
	not_fourty_one:
	cp	#42
	jr	nz, not_fourty_two
		;; STATE 42 - Step down-right second state ;;
		call stepDownRight2_state
		ret
	not_fourty_two:
	cp	#43
	jr	nz, not_fourty_three
		;; STATE 43 - Step down-right third state ;;
		call stepDownRight3_state
		ret
	not_fourty_three:
	cp	#44
	jr	nz, not_fourty_four
		;; STATE 44 - Step down-left second state ;;
		call stepDownLeft2_state
		ret
	not_fourty_four:
	cp	#45
	jr	nz, not_fourty_five
		;; STATE 45 - Step down-left third state ;;
		call stepDownLeft3_state
		ret
	not_fourty_five:

	ret

;; ======================================
;; 		Origin State #0
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
origin_state:
	ld	a, Ent_signal(ix)
	cp	#1
	jr	nz, origin_not_one
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #1
		jp origin_exit
	origin_not_one:
	cp	#2
	jr	nz, origin_not_two
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #2
		jp origin_exit
	origin_not_two:
	cp	#3
	jr	nz, origin_not_three
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #3
		jp origin_exit
	origin_not_three:
	cp	#4
	jr	nz, origin_not_four
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #4
		jp origin_exit
	origin_not_four:
	cp	#5
	jr	nz, origin_not_five
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #5
		jp origin_exit
	origin_not_five:
	cp	#6
	jr	nz, origin_not_six
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #6
		jp origin_exit
	origin_not_six:
	cp	#7
	jr	nz, origin_not_seven
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #7
		jp origin_exit
	origin_not_seven:
	cp	#8
	jr	nz, origin_not_eight
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #8
		jp origin_exit
	origin_not_eight:
	cp	#9
	jr	nz, origin_not_nine
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #16
		jp origin_exit
	origin_not_nine:
	cp	#10
	jr	nz, origin_not_ten
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #9
		jp origin_exit
	origin_not_ten:
	cp	#11
	jr	nz, origin_not_eleven
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #23
		jp origin_exit
	origin_not_eleven:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0

	origin_exit:
	ld 	a, #1

	ret

;; =======================================
;; =======================================
;; == 		MOVE UP STATES		==
;; =======================================
;; =======================================

;; ======================================
;; 		Step up 1 State #1
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUp1_state:
	ld Ent_sprite(ix), #0	;; Next sprite <= 0
	ld	a, Ent_signal(ix)
	cp	#1
	jr 	nz, stepUp1_else
		;; Move up
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #30	;; Next state <= 30

		ld a, #1		;; A <= Update physics
		ret
	stepUp1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics

	ret


;; ======================================
;; 		Step up 2 State #30
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUp2_state:
	ld Ent_sprite(ix), #1		;; Next sprite <= 1
	ld	a, Ent_signal(ix)
	cp	#1
	jr 	nz, stepUp2_else
		;; Move up
		ld a, Ent_lastState(ix)
		cp #1
		jr z, goto_state_31
			;; GO TO 1
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #1	;; Next state <= 1
		goto_state_31:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #31	;; Next state <= 30

		ld a, #1		;; A <= Update physics
		ret
	stepUp2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 		Step up 3 State #31
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUp3_state:
	ld Ent_sprite(ix), #2		;; Next sprite <= 2
	ld	a, Ent_signal(ix)
	cp	#1
	jr 	nz, stepUp3_else
		;; Move up
		ld Ent_sprite(ix), #0	;; Next sprite <= 1
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #30	;; Next state <= 30

		ld a, #1		;; A <= Update physics
		ret
	stepUp3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret

;; =======================================
;; =======================================
;; == 		MOVE DOWN STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 		Step down 1 State #2
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDown1_state:
	ld Ent_sprite(ix), #3		;; Next sprite <= 3
	ld	a, Ent_signal(ix)
	cp	#2
	jr 	nz, stepDown1_else
		;; Move Down
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #32	;; Next state <= 32

		ld a, #1		;; A <= Update physics
		ret
	stepDown1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics

	ret


;; ======================================
;; 	Step down 2 State #32
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDown2_state:
	ld Ent_sprite(ix), #4	;; Next sprite <= 4
	ld	a, Ent_signal(ix)
	cp	#2
	jr 	nz, stepDown2_else
		;; Move down
		ld a, Ent_lastState(ix)
		cp #2
		jr z, goto_state_33
			;; GO TO 2
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #2	;; Next state <= 2
		goto_state_33:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #33	;; Next state <= 33

		ld a, #1		;; A <= Update physics
		ret
	stepDown2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step down 3 State #33
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDown3_state:
	ld Ent_sprite(ix), #5	;; Next sprite <= 5
	ld	a, Ent_signal(ix)
	cp	#2
	jr 	nz, stepDown3_else
		;; Move down
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #32	;; Next state <= 32

		ld a, #1		;; A <= Update physics
		ret
	stepDown3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; =======================================
;; =======================================
;; == 		MOVE RIGHT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step Right 1 State #3
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepRight1_state:
	ld Ent_sprite(ix), #6		;; Next sprite <= 6
	ld	a, Ent_signal(ix)
	cp	#3
	jr 	nz, stepRight1_else
		;; Move Right
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #34	;; Next state <= 34

		ld a, #1		;; A <= Update physics
		ret
	stepRight1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step Right 2 State #34
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepRight2_state:
	ld Ent_sprite(ix), #7			;; Next sprite <= 7
	ld	a, Ent_signal(ix)
	cp	#3
	jr 	nz, stepRight2_else
		;; Move Right
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_35
			;; GO TO 3
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #3	;; Next state <= 3
		goto_state_35:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #35	;; Next state <= 35

		ld a, #1		;; A <= Update physics
		ret
	stepRight2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step Right 3 State #35
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepRight3_state:
	ld Ent_sprite(ix), #8		;; Next sprite <= 8
	ld	a, Ent_signal(ix)
	cp	#3
	jr 	nz, stepRight3_else
		;; Move Right
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #34	;; Next state <= 34

		ld a, #1		;; A <= Update physics
		ret
	stepRight3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; =======================================
;; =======================================
;; == 		MOVE LEFT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step Left 1 State #4
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepLeft1_state:
	ld Ent_sprite(ix), #9		;; Next sprite <= 9
	ld	a, Ent_signal(ix)
	cp	#4
	jr 	nz, stepLeft1_else
		;; Move Left
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #36	;; Next state <= 36

		ld a, #1		;; A <= Update physics
		ret
	stepLeft1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step Left 2 State #36
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepLeft2_state:
	ld Ent_sprite(ix), #10			;; Next sprite <= 10
	ld	a, Ent_signal(ix)
	cp	#4
	jr 	nz, stepLeft2_else
		;; Move Left
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_37
			;; GO TO 4
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #4	;; Next state <= 4
		goto_state_37:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #37	;; Next state <= 37

		ld a, #1		;; A <= Update physics
		ret
	stepLeft2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step Left 3 State #37
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepLeft3_state:
	ld Ent_sprite(ix), #11		;; Next sprite <= 11
	ld	a, Ent_signal(ix)
	cp	#4
	jr 	nz, stepLeft3_else
		;; Move Left
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #36	;; Next state <= 36

		ld a, #1		;; A <= Update physics
		ret
	stepLeft3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; =======================================
;; =======================================
;; == 	    MOVE UP RIGHT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step UpRight 1 State #5
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpRight1_state:
	ld Ent_sprite(ix), #12		;; Next sprite <= 12
	ld	a, Ent_signal(ix)
	cp	#5
	jr 	nz, stepUpRight1_else
		;; Move UpRight
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #38	;; Next state <= 38

		ld a, #1		;; A <= Update physics
		ret
	stepUpRight1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step UpRight 2 State #38
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpRight2_state:
	ld Ent_sprite(ix), #13			;; Next sprite <= 13
	ld	a, Ent_signal(ix)
	cp	#5
	jr 	nz, stepUpRight2_else
		;; Move UpRight
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_39
			;; GO TO 5
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #5	;; Next state <= 5
		goto_state_39:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #39	;; Next state <= 39

		ld a, #1		;; A <= Update physics
		ret
	stepUpRight2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step UpRight 3 State #39
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpRight3_state:
	ld Ent_sprite(ix), #14		;; Next sprite <= 14
	ld	a, Ent_signal(ix)
	cp	#5
	jr 	nz, stepUpRight3_else
		;; Move UpRight
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #38	;; Next state <= 38

		ld a, #1		;; A <= Update physics
		ret
	stepUpRight3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret



;; =======================================
;; =======================================
;; == 	    MOVE UP LEFT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step UpLeft 1 State #6
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpLeft1_state:
	ld Ent_sprite(ix), #15		;; Next sprite <= 15
	ld	a, Ent_signal(ix)
	cp	#6
	jr 	nz, stepUpLeft1_else
		;; Move UpLeft
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #40	;; Next state <= 40

		ld a, #1		;; A <= Update physics
		ret
	stepUpLeft1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step UpLeft 2 State #40
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpLeft2_state:
	ld Ent_sprite(ix), #16			;; Next sprite <= 16
	ld	a, Ent_signal(ix)
	cp	#6
	jr 	nz, stepUpLeft2_else
		;; Move UpLeft
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_41
			;; GO TO 6
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #6	;; Next state <= 6
		goto_state_41:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #41	;; Next state <= 41

		ld a, #1		;; A <= Update physics
		ret
	stepUpLeft2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step UpLeft 3 State #41
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepUpLeft3_state:
	ld Ent_sprite(ix), #17		;; Next sprite <= 17
	ld	a, Ent_signal(ix)
	cp	#6
	jr 	nz, stepUpLeft3_else
		;; Move UpLeft
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #40	;; Next state <= 40

		ld a, #1		;; A <= Update physics
		ret
	stepUpLeft3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret



;; =======================================
;; =======================================
;; == 	    MOVE DOWN RIGHT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step DownRight 1 State #7
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownRight1_state:
	ld Ent_sprite(ix), #18		;; Next sprite <= 18
	ld	a, Ent_signal(ix)
	cp	#7
	jr 	nz, stepDownRight1_else
		;; Move DownRight
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #42	;; Next state <= 42

		ld a, #1		;; A <= Update physics
		ret
	stepDownRight1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step DownRight 2 State #42
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownRight2_state:
	ld Ent_sprite(ix), #19			;; Next sprite <= 19
	ld	a, Ent_signal(ix)
	cp	#7
	jr 	nz, stepDownRight2_else
		;; Move DownRight
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_43
			;; GO TO 7
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #7	;; Next state <= 7
		goto_state_43:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #43	;; Next state <= 43

		ld a, #1		;; A <= Update physics
		ret
	stepDownRight2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step DownRight 3 State #43
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownRight3_state:
	ld Ent_sprite(ix), #20		;; Next sprite <= 20
	ld	a, Ent_signal(ix)
	cp	#7
	jr 	nz, stepDownRight3_else
		;; Move DownRight
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #42	;; Next state <= 42

		ld a, #1		;; A <= Update physics
		ret
	stepDownRight3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret




;; =======================================
;; =======================================
;; == 	    MOVE DOWN LEFT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Step DownLeft 1 State #8
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownLeft1_state:
	ld Ent_sprite(ix), #21		;; Next sprite <= 21
	ld	a, Ent_signal(ix)
	cp	#8
	jr 	nz, stepDownLeft1_else
		;; Move DownLeft
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #44	;; Next state <= 44

		ld a, #1		;; A <= Update physics
		ret
	stepDownLeft1_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step DownLeft 2 State #44
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownLeft2_state:
	ld Ent_sprite(ix), #22			;; Next sprite <= 22
	ld	a, Ent_signal(ix)
	cp	#8
	jr 	nz, stepDownLeft2_else
		;; Move DownLeft
		ld a, Ent_lastState(ix)
		cp #3
		jr z, goto_state_45
			;; GO TO 8
			ld a, Ent_state(ix)	;;
			ld Ent_lastState(ix), a	;; LastState <= current state
			ld Ent_state(ix), #8	;; Next state <= 8
		goto_state_45:
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #45	;; Next state <= 45

		ld a, #1		;; A <= Update physics
		ret
	stepDownLeft2_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret


;; ======================================
;; 	Step DownLeft 3 State #45
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
stepDownLeft3_state:
	ld Ent_sprite(ix), #23		;; Next sprite <= 23
	ld	a, Ent_signal(ix)
	cp	#8
	jr 	nz, stepDownLeft3_else
		;; Move DownLeft
		ld a, Ent_state(ix)	;;
		ld Ent_lastState(ix), a	;; LastState <= current state
		ld Ent_state(ix), #44	;; Next state <= 44

		ld a, #1		;; A <= Update physics
		ret
	stepDownLeft3_else:
	;; else
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0
	ld a, #1		;; A <= Update physics
	ret



;; =======================================
;; =======================================
;; == 	    THROW DOWN STATES		==
;; =======================================
;; =======================================

;; ======================================
;; 	Throw Down 1 State #9
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown1_state:
	ld Ent_sprite(ix), #24	;; Next sprite <= 24
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #10	;; Next state <= 10

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 2 State #10
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown2_state:
	ld Ent_sprite(ix), #25	;; Next sprite <= 25
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #11	;; Next state <= 11

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 3 State #11
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown3_state:
	ld Ent_sprite(ix), #26	;; Next sprite <= 26
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #12	;; Next state <= 12

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 4 State #12
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown4_state:
	ld Ent_sprite(ix), #27	;; Next sprite <= 27
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #13	;; Next state <= 13

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 5 State #13
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown5_state:
	ld Ent_sprite(ix), #28	;; Next sprite <= 28
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #14	;; Next state <= 14

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 6 State #14
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown6_state:
	ld Ent_sprite(ix), #29	;; Next sprite <= 29
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #15	;; Next state <= 15

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Down 7 State #15
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwDown7_state:
	ld Ent_sprite(ix), #30	;; Next sprite <= 30
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0

	ld a, #0		;; A <= Not update physics
	ret



;; =======================================
;; =======================================
;; == 	    THROW UP STATES		==
;; =======================================
;; =======================================

;; ======================================
;; 	Throw Up 1 State #16
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp1_state:
	ld Ent_sprite(ix), #24	;; Next sprite <= 24
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #17	;; Next state <= 17

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 2 State #17
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp2_state:
	ld Ent_sprite(ix), #31	;; Next sprite <= 31
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #18	;; Next state <= 18

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 3 State #18
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp3_state:
	ld Ent_sprite(ix), #30	;; Next sprite <= 30
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #19	;; Next state <= 19

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 4 State #19
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp4_state:
	ld Ent_sprite(ix), #29	;; Next sprite <= 29
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #20	;; Next state <= 20

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 5 State #20
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp5_state:
	ld Ent_sprite(ix), #28	;; Next sprite <= 28
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #21	;; Next state <= 21

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 6 State #21
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp6_state:
	ld Ent_sprite(ix), #27	;; Next sprite <= 27
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #15	;; Next state <= 15

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Up 7 State #22
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwUp7_state:
	ld Ent_sprite(ix), #26	;; Next sprite <= 26
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0

	ld a, #0		;; A <= Not update physics
	ret



;; =======================================
;; =======================================
;; == 	    THROW STRAIGHT STATES	==
;; =======================================
;; =======================================

;; ======================================
;; 	Throw Straight 1 State #23
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight1_state:
	ld Ent_sprite(ix), #24	;; Next sprite <= 24
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #24	;; Next state <= 24

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 2 State #24
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight2_state:
	ld Ent_sprite(ix), #31	;; Next sprite <= 31
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #25	;; Next state <= 25

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 3 State #25
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight3_state:
	ld Ent_sprite(ix), #30	;; Next sprite <= 30
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #26	;; Next state <= 26

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 4 State #26
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight4_state:
	ld Ent_sprite(ix), #29	;; Next sprite <= 29
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #27	;; Next state <= 27

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 5 State #27
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight5_state:
	ld Ent_sprite(ix), #28	;; Next sprite <= 28
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #28	;; Next state <= 28

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 6 State #28
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight6_state:
	ld Ent_sprite(ix), #29	;; Next sprite <= 29
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #29	;; Next state <= 29

	ld a, #0		;; A <= Not update physics
	ret

;; ======================================
;; 	Throw Straight 7 State #29
;; Entrada:  IX <= Pointer to player data
;; Devuelve: A <= Not Update/Update
;; ======================================
throwStraight7_state:
	ld Ent_sprite(ix), #30	;; Next sprite <= 30
	ld a, Ent_state(ix)	;;
	ld Ent_lastState(ix), a	;; LastState <= current state
	ld Ent_state(ix), #0	;; Next state <= 0

	ld a, #0		;; A <= Not update physics
	ret


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
	ld 	Ent_ax_I(ix), #0
	ld 	Ent_ax_F(ix), #std_acc	;; Ent_ay <= 00(0)E2(30) (30)
	ret

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

;; ===========================================
;; Chequea el estado del jugador y comprueba
;; 	y corrige su señal
;; Entrada:
;; 	IX <= pointer to entity data
;; Modifica AF, BC, DE, HL
;; ===========================================
checkSignal:
	ld 	a, Ent_signal(ix)
	cp	#-1
	jr	nz, signal_already_set
		;; Signal is not set
		ld 	a, Ent_ax_I(ix)
		cp	#0
		jr	nz, ax_is_negative
			;; AX is zero or positive
			ld 	a, Ent_ax_F(ix)
			cp	#0
			jr	nz, ax_is_positive
				;; AX is zero
				jr check_signal_ay
			ax_is_positive:
			ld Ent_signal(ix), #3
			jr check_signal_ay

		ax_is_negative:
		ld Ent_signal(ix), #4

	check_signal_ay:
		ld 	a, Ent_signal(ix)
		cp	#-1
		jr	nz, diagonal_movement	;; Is signal set at AX checking?
			;; Vertical movement
			ld 	a, Ent_ay_I(ix)
			cp	#0
			jr	nz, move_up
				;; AX is zero or positive
				ld 	a, Ent_ay_F(ix)
				cp	#0
				jr	nz, move_down
					;; AX is zero
					jr signal_already_set
				move_down:
					ld Ent_signal(ix), #2
					jr signal_already_set
			move_up:
			ld Ent_signal(ix), #1
			jr signal_already_set

		diagonal_movement:
			ld 	a, Ent_ay_I(ix)
			cp	#0
			jr	nz, ay_is_negative
				;; AY is zero or positive
				ld 	a, Ent_ay_F(ix)
				cp	#0
				jr	nz, ay_is_positive
					;; AY is zero
					jr signal_already_set
				ay_is_positive:
					ld	a, Ent_signal(ix)
					cp 	#3
					jr	nz, move_downLeft
						;; move down right
						ld Ent_signal(ix), #7
						jr signal_already_set
					move_downLeft:
						ld Ent_signal(ix), #8
						jr signal_already_set
			ay_is_negative:
				ld	a, Ent_signal(ix)
				cp 	#3
				jr	nz, move_upLeft
					;; move up right
					ld Ent_signal(ix), #5
					jr signal_already_set
				move_upLeft:
					ld Ent_signal(ix), #6
					jr signal_already_set

	signal_already_set:
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
					ld	Ent_signal(ix), #11
					jr vorb_pressed
				just_v_pressed:
					ld 	hl, #std_N_eff		;; HL <= -standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia arriba
					pop 	ix
					ld	Ent_signal(ix), #9
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
					ld	Ent_signal(ix), #10

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
					ld	Ent_signal(ix), #11
					jr ioro_pressed
				just_i_pressed:
					ld 	hl, #std_N_eff		;; HL <= -standard effect
					push 	ix
					call frisbee_setEffect		;; efecto hacia arriba
					pop 	ix
					ld	Ent_signal(ix), #9
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
					ld	Ent_signal(ix), #10

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