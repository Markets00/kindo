#include <cpctelera.h>
////////////////////////////////////////////////////////////////////////////////
////			ESTRUCTURA DE LA MACRO ENTITY EN ENSAMBLADOR				////
////////////////////////////////////////////////////////////////////////////////
// .macro defineEntity name, x,y, h, w, vx, vy, ax, ay, normal, state, clr, id
// 	name'_data::
// 		name'_x:		.dw x		;; X coordinate				(16 bits)
// 		name'_y:		.dw y		;; Y coordinate				(16 bits)
// 		name'_h:		.db h		;; Height					(8 bits)
// 		name'_w:		.db w		;; Width					(8 bits)
// 		name'_vx:		.dw vx		;; Velocity at X axis 		(16 bits)
// 		name'_vy:		.dw vy		;; Velocity at Y axis		(16 bits)
// 		name'_ax:		.dw ax		;; Acceleration at X axis	(16 bits)
// 		name'_ay:		.dw ay		;; Acceleration at Y axis	(16 bits)
// 		name'_normal:	.dw normal	;; Normal force				(16 bits)
// 		name'_last_x:	.db x		;; Last x rendered			(8 bits)
// 		name'_erase_x:	.db x		;; x rendered at same buffer(8 bits)
// 		name'_last_y:	.db y		;; Last y rendered			(8 bits)
// 		name'_erase_y:	.db y		;; y rendered at same buffer(8 bits)
// 		name'_state:	.db state	;; Entity enabled/disabled	(8 bits)
// 		name'_clr:		.db clr		;; Entity color pattern		(8 bits)
// 		name'_id:		.db id		;; Numeric ID				(8 bits)
// .endm

typedef struct {
	u16		x, y;			// X e Y de la entidad
	u8 		h, w;			// alto y ancho
	i16		vx, vy;			// velocidad en el eje x e y
	i16		ax, ay;			// aceleración en el eje x e y
	i16		normal;			// fuerza normal (deceleración)
	u8		last_x,erase_x;	// última x dibujada y la que se debe borrar en el buffer
	u8		last_y,erase_y;	// última y dibujada y la que se debe borrar en el buffer
	u8		state;			// estado
	u8		clr;			// patrón de color
	u8		id;				// ID numérico
} TEntity;


enum TipoFuzzySet{
	triangulo = 0
	, leftShoulder = 1
	, rightShoulder = 2
};
typedef struct{
	u16 dom;
	u16 valorRepresent;
	enum TipoFuzzySet tipo;
	u16 peakPoint;
	u16 leftOffSet;
	u16 rightOffSet;
}FuzzSetConcreto;
typedef struct 
{
	FuzzSetConcreto* antecedent;
	FuzzSetConcreto* consequent;
}FuzzRule;
typedef struct {
	u8 b_der;
	u8 b_izq;
}b_direccion;


#define SCALA 256
#define LIMITPORTX 60
#define LIMITPORTY 111
//--------Var de Entrada-------------------------
const FuzzSetConcreto cerca = {
	 0*SCALA, 5*SCALA, 1, 10*SCALA ,10*SCALA ,10*SCALA
};

const FuzzSetConcreto medio = {
	0*SCALA, 20*SCALA, 0, 20*SCALA, 10*SCALA, 15*SCALA
};
const FuzzSetConcreto lejos = {
	0*SCALA, 110*SCALA, 2, 60*SCALA, 25*SCALA, 100*SCALA
};
//--------Var de Salida-------------------------
const FuzzSetConcreto acelMu = {
	0*SCALA, 87.5*SCALA, 2, 75*SCALA ,25*SCALA ,25*SCALA
};
const FuzzSetConcreto acelPo = {
	0*SCALA, 12.5*SCALA, 1, 25*SCALA ,25*SCALA ,25*SCALA
};
const FuzzSetConcreto acelMed= {
	0*SCALA, 50*SCALA, 0, 50*SCALA ,25*SCALA ,25*SCALA
};
//--------Rules para X e Y-------------------------
const FuzzRule rulex = {
	&cerca, &acelMu
};
const FuzzRule rulex1 = {
	&medio, &acelMed
};
const FuzzRule rulex2 = {
	&lejos, &acelPo
};
const FuzzRule ruley = {
	&cerca, &acelMu
};
const FuzzRule ruley1 = {
	&medio, &acelMed
};
const FuzzRule ruley2 = {
	&lejos, &acelPo
};
//-----Vector de reglas para cuando hayan mas de una---------
const FuzzRule* vRulesx[3] = {
	{&rulex},
	{&rulex1},
	{&rulex2}
	
};
const FuzzRule* vRulesy[3] = {
	{&ruley},
	 {&ruley1},
	  {&ruley2}
};
//---------Lo que antes era memSets-----------------------
const FuzzSetConcreto* fmems[3] = {
	{&acelPo},
	{&acelMed},
	{&acelMu}
};
//------------------aceelracion pa la salida------------
u16 aceleracion[3];// = {0.1*SCALA, 0.5*SCALA, 1*SCALA};

void initAcel(u8 nivel)
{
	u8 i = 0;
	switch(nivel){
		case 0:{ 
			u16 aux[3] = {0.06*SCALA, 0.08*SCALA, 0.09*SCALA};
			while(i<3)
			{	
				aceleracion[i] = aux[i];
				i++;
			}
		}
		case 1:{
			u16 aux[3] = {0.09*SCALA, 0.1*SCALA, 0.2*SCALA};
			while(i<3)
			{	
				aceleracion[i] = aux[i];
				i++;
			}
		}
		default:{
			u16 aux[3] = {0.1*SCALA, 0.2*SCALA, 0.3*SCALA};
						while(i<3)
			{	
				aceleracion[i] = aux[i]; 
				i++;
			}
		}
	}
	//aceleracion = aux;
}
//Calcula el dominio para un Set concreto
void calculateDom(const FuzzSetConcreto* c, u8 val, u16* grad)
{
	*grad = 0.0;
	if(c->tipo == 0){
		//FUZZY SET TRIANGULAR
		if(c->rightOffSet == 0 && c->peakPoint == val 
				|| c->leftOffSet == 0 && c->peakPoint == val)
		{
			*grad = SCALA;
			return;
		}

		if(val <= c->peakPoint && (val >= (c->peakPoint - c->leftOffSet)))
		{
			 *grad = SCALA / c->leftOffSet;
			*grad = *grad * (val - (c->peakPoint - c->leftOffSet));
			return;
		}else if(val > c->peakPoint && val < (c->peakPoint + c->rightOffSet))
		{
			 *grad = SCALA/-c->rightOffSet;
			*grad = *grad * (val- c->peakPoint) + SCALA;
			return;
		}else
		{
			*grad = 0;
			return;
		}

	}else if(c->tipo == 1)
	{
		u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);

		//LEFTSHOULDER
		if(c->rightOffSet == 0 && val == midPoint){
			*grad = SCALA;
			return;
		}
		
		if(val >= midPoint && (val < (midPoint + c->rightOffSet)))
		{
			 *grad = SCALA/-c->rightOffSet;
			*grad = *grad*(val-(midPoint + c->rightOffSet));
			return;
		}else if(val < midPoint)
		{
			*grad = SCALA;
			return;
		}else{
			*grad = 0;
			return;
		}
	}else
	{
		u8 midPoint = ((c->peakPoint + c->rightOffSet)- c->rightOffSet);
		//RIGHTSHOULDER
		if(c->leftOffSet == 0 && val == midPoint)
			*grad = SCALA;
		if(val <= midPoint && (val > (midPoint - c->leftOffSet)))
		{
			 *grad = SCALA/c->leftOffSet;
			*grad = *grad*(val-(midPoint - c->leftOffSet));
		}else if(val > midPoint)
		{

			*grad = SCALA;
		}else{
			*grad = 0;
		}
	}
}

//calculamos los dominios para cada sset de la aceleracion, y lo guardamos
//en un vector de dominios, que despues devolvemos * con su valor
void defuzzi(u16 val, b_direccion* direccion, i16* re)
{
	u16 dom;
	u8 i;
	u16 vDom[3];


	*re = 0;
	i = 0;
	while(i < 3)
	{
		dom = 0;
		calculateDom(fmems[i], val, &dom);
		vDom[i] = dom/SCALA;
		i++;
	}
	i = 0;

	for(i = 0; i<3; i++)
	{
		*re = ((vDom[i] * aceleracion[i]) + *re);
	}
	//*re = *re/SCALA;
	if(direccion->b_izq)
		*re = *re;
	else

		*re = -*re;

}

//Calcula el valor del dominio para  cada regla, devolviendo un valor.
void calcule(u8 tam, u8 dis, u16 *re)
{	
	u16 resultadoDistoball;
	u8 i;
	resultadoDistoball = 0;
	for(i = 0 ; i<tam; i++){
		calculateDom(vRulesx[i]->antecedent, dis, &resultadoDistoball);
		*re = ((vRulesx[i]->consequent->valorRepresent * resultadoDistoball ) + *re)/SCALA;
	}
}
//Aqui establecemos la direccion de la aceleracion
void calcularb_direc(i16 totalxb, b_direccion* ball)
{
	ball->b_izq = 0;
	ball->b_der = 0;

	if(totalxb < 0){
		ball->b_der = 1;
		ball->b_izq = 0;
	}else if(totalxb > 0)
	{
		ball->b_izq = 1;
		ball->b_der = 0;
	}
}

//metodo
void fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy){

	i16 x, y, x1,y1;
	b_direccion ballX, ballY;
	b_direccion* ball;

	u16 accerationX;
	u16 accerationY;
	ball = &ballX;
	x = ballx - pingu_enemyx;
	y = bally - pingu_enemyy;
	x1 = LIMITPORTX - pingu_enemyx;
	y1 = LIMITPORTY - pingu_enemyy;
	if(x <= -2){ //ATACAR 
		//calcularb_direc(x, &ballX);
		ball->b_der = 1;
		ball->b_izq = 0;
	}
	else {//DFENDER
		//if(y ==0 ) 
		//direc(x1, &ballX);
		ball->b_izq = 1;
		ball->b_der = 0;
	}
	
	if(y1 < y && x > 0){
		calcularb_direc(y1, &ballY);
	}
	else if(y1> y && x>0){
		calcularb_direc(y1, &ballY);
	}else
	{
		calcularb_direc(y, &ballY);
	}


	x = (u8)x*SCALA;
	y = (u8)y*SCALA;
	calcule(3,x,&accerationX);
	calcule(3,y,&accerationY);
	//f32 accerationY = calcule(vRulesy,tamVrulesy, totalyb);
	
	if(y!=0)
		defuzzi(accerationX,&ballX, ax);
	else
		ax = 0;

	if(x!=0)
		defuzzi(accerationY,&ballY, ay);
	else
		ay = 0;
	//calculaDominios(&acelerationY, accerationY);

	//f32 resultadoy = defuzzificacion(&acelerationY, ballY);
}

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
	i16 acc = SCALA/8;

//	myself->ax = -acc;
//	myself->ay = acc;



//fuzzificacion(&myself->ax, &myself->ay, frisbee->x, frisbee->y, enemy->x, enemy->y);
//fuzzificacion(i16 *ax, i16 *ay, u8 ballx, u8 bally, u8 pingu_enemyx, u8 pingu_enemyy

	// IA retrasada que sigue el frisbee
	if(myself->y > frisbee->y) {
		myself->ay = -SCALA/8;
	} else if (myself->y < frisbee->y) {
		myself->ay = SCALA/8;
	}
}