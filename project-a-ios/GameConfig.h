//
//  GameConfig.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.

#ifndef project_a_ios_GameConfig_h
#define project_a_ios_GameConfig_h

#import "CCMutableTexture2D.h"

#import "cocos2d.h"
#import "Colors.h"
#import "MLog.h"

#import "Dungeon.h"
#import "DungeonFloor.h"
#import "Entity.h"
#import "Tile.h"



// Defines the width x length of tiles in pixels
#define TILE_SIZE                   8

// Defines how much to scale tiles up by
//#define TILE_SCALE                  1
//#define TILE_SCALE                  2
//#define TILE_SCALE                  4
#define TILE_SCALE                  4


//#define NUMBER_OF_TILES_ONSCREEN_X  40
//#define NUMBER_OF_TILES_ONSCREEN_X  20
//#define NUMBER_OF_TILES_ONSCREEN_X  10
#define NUMBER_OF_TILES_ONSCREEN_X  10


//#define NUMBER_OF_TILES_ONSCREEN_Y  60
//#define NUMBER_OF_TILES_ONSCREEN_Y  30
//#define NUMBER_OF_TILES_ONSCREEN_Y  15
#define NUMBER_OF_TILES_ONSCREEN_Y  15



#define NUMBER_OF_TILES_ONSCREEN    ( NUMBER_OF_TILES_ONSCREEN_X * NUMBER_OF_TILES_ONSCREEN_Y )


#endif