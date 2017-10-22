#include<cpctelera.h>
////////////////////////////////////////////////////////////////////////////
////			ESTRUCTURA DE LA MACRO ENTITY EN ENSAMBLADOR			////
////////////////////////////////////////////////////////////////////////////
// .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, state, clr, id
// 	name'_data::
// 		name'_x:	.dw x		;; X coordinate				(16 bits)
// 		name'_y:	.dw y		;; Y coordinate				(16 bits)
// 		name'_h:	.db h		;; Height					(8 bits)
// 		name'_w:	.db w		;; Width					(8 bits)
// 		name'_vx:	.dw vx		;; Velocity at X axis 		(16 bits)
// 		name'_vy:	.dw vy		;; Velocity at Y axis		(16 bits)
// 		name'_ax:	.dw ax		;; Acceleration at X axis	(16 bits)
// 		name'_ay:	.dw ay		;; Acceleration at Y axis	(16 bits)
// 		name'_state:.db state	;; Entity enabled/disabled	(8 bits)
// 		name'_clr:	.db clr		;; Entity color pattern		(8 bits)
// 		name'_id:	.db id		;; Numeric ID				(8 bits)
// .endm
typedef struct {
	u8		x_I, x_F;
	u8		y_I, y_F;
	u8 		h, w;
	u8		vx_I,vx_F;
	u8		vy_I,vy_F;
	u8		ax_I,ax_F;
	u8		ay_I,ay_F;
	u8		state;
	u8		clr;
	u8		id;
} TEntity;


// ============================================
// Actualiza la aceleración de la primera
//		entidad recibida en el primer parámetro
// Entrada:
// 	myself <= pointer to IA data
// 	enemy <= pointer to my oponent data
// 	frisbee <= pointer to frisbee data
// Modifica 
// ============================================
void moveIA(TEntity* myself, TEntity* enemy, TEntity* frisbee) {
	
	if(myself->y_I > frisbee->y_I) {
		myself->ay_I = 255;
		myself->ay_F = -4;
	} else if (myself->y_I < frisbee->y_I) {
		myself->ay_I = 0;
		myself->ay_F = 4;
	}
}