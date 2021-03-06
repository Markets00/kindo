#include "tileset.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
// Palette uses hardware values.
const u8 g_palette[16] = { 0x54, 0x44, 0x5c, 0x58, 0x45, 0x56, 0x46, 0x5e, 0x40, 0x47, 0x42, 0x53, 0x5a, 0x4a, 0x43, 0x4b };

u8* const g_tileset[2] = { 
	g_tileset_0, g_tileset_1
};
// Tile g_tileset_0: 4x4 pixels, 2x4 bytes.
const u8 g_tileset_0[2 * 4] = {
	0x44, 0x74,
	0xc4, 0xa1,
	0x84, 0x29,
	0x18, 0x7c
};

// Tile g_tileset_1: 4x4 pixels, 2x4 bytes.
const u8 g_tileset_1[2 * 4] = {
	0xc7, 0xf7,
	0x93, 0x7f,
	0xa1, 0xff,
	0x5f, 0xff
};

