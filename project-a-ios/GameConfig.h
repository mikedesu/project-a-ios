//
//  GameConfig.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.

#import "cocos2d.h"

#import "AppDelegate.h"
#import "CCMutableTexture2D.h"
#import "Colors.h"
#import "Dungeon.h"
#import "DungeonFloor.h"
#import "EditorHUD.h"
#import "Entity.h"
#import "GameLayer.h"
#import "GameRenderer.h"
#import "MLog.h"
#import "PlayerHUD.h"
#import "PlayerMenu.h"
#import "Tile.h"

// Defines the width x length of tiles in pixels
#define TILE_SIZE                   8

// Defines how much to scale tiles up by
#define TILE_SCALE                  4

// Defines how many tiles onscreen on each axis
#define NUMBER_OF_TILES_ONSCREEN_X  10
#define NUMBER_OF_TILES_ONSCREEN_Y  15

#define NUMBER_OF_TILES_ONSCREEN    ( NUMBER_OF_TILES_ONSCREEN_X * NUMBER_OF_TILES_ONSCREEN_Y )

