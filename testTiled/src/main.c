//-----------------------------LICENSE NOTICE------------------------------------
//  This file is part of CPCtelera: An Amstrad CPC Game Engine
//  Copyright (C) 2015 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

#include <cpctelera.h>
#include "shit.h"
#include "tileset.h"

#define ORIGIN_X 0
#define ORIGIN_Y 0
#define ORIGIN_MAP cpctm_screenPtr(CPCT_VMEM_START, ORIGIN_X, ORIGIN_Y)

//u8* map;

void main(void) {

	cpct_disableFirmware();
	cpct_setVideoMode(0);
	cpct_setBorder(HW_BLACK);
	cpct_setPalette(g_palette, 16);

	cpct_etm_setTileset2x4(g_tileset);

	//map = cpct_getScreenPtr(CPCT_VMEM_START, ORIGIN_X, ORIGIN_Y);
	cpct_etm_drawTileBox2x4(0, 0, g_shit_W, g_shit_H, g_shit_H, ORIGIN_MAP, g_shit);
   // Loop forever
   while (1);
}