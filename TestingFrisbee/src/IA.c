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
	u16		x, y;		// X e Y de la entidad
	u8 		h, w;		// alto y ancho
	i16		vx, vy;		// velocidad en el eje x e y
	i16		ax, ay;		// aceleración en el eje x e y
	u8		state;		// estado
	u8		clr;		// patrón de color
	u8		id;			// ID numérico
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
	
//	if(myself->y_I > frisbee->y_I) {
//		myself->ay_I = 255;
//		myself->ay_F = -4;
//	} else if (myself->y_I < frisbee->y_I) {
//		myself->ay_I = 0;
//		myself->ay_F = 4;
//	}
}