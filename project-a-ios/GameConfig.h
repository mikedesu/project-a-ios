//
//  GameConfig.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.

#import "cocos2d.h"

#import "AppDelegate.h"
#import "CCMutableTexture2D.h"

#import "Maybe.h"

#import "Attack_t.h"
#import "AttackElement_t.h"
#import "AttackStatus_t.h"
#import "Armor.h"
#import "Colors.h"
#import "Dice.h"
#import "Drawer.h"
#import "Dungeon.h"
#import "DungeonFloor.h"
#import "EditorHUD.h"
#import "Effect_t.h"
#import "Entity.h"
#import "EntityInfoHUD.h"
#import "EntitySubtypeDefines.h"
#import "EquipDefines.h"
#import "EquipMenu.h"
#import "EquipSubmenu.h"
#import "GameLayer.h"
#import "GameRenderer.h"
#import "HelpMenu.h"
#import "Items.h"
#import "InventoryMenu.h"
#import "KarmaEngine.h"
#import "MessageWindow.h"
#import "MLog.h"
#import "Monsters.h"
#import "NameEngine.h"
#import "PlayerHUD.h"
#import "PlayerMenu.h"
#import "Prefix_t.h"
#import "Spell.h"
#import "Status.h"
#import "StatusMenu.h"
#import "Threat_t.h"
#import "Tile.h"
#import "Weapons.h"

#import "MasterLayer.h"
#import "CharacterCreationScreen.h"
#import "TitleScreen.h"
#import "LevelUpWindow.h"
#import "GameTools.h"

#import "DropMenu.h"

#import "Cloth_t.h"
#import "Metal_t.h"
#import "Stone_t.h"
#import "Wood_t.h"
#import "Zodiac.h"

#import "HintGenerator.h"

/*
typedef struct {
    CGFloat x, y;
    NSInteger weight;
} WeightedPoint;
*/

// Defines the width x length of tiles in pixels
#define TILE_SIZE                   16

// Defines how much to scale tiles up by
#define TILE_SCALE                  2

// Defines how many tiles onscreen on each axis
#define NUMBER_OF_TILES_ONSCREEN_X  10
#define NUMBER_OF_TILES_ONSCREEN_Y  15

#define NUMBER_OF_TILES_ONSCREEN    ( NUMBER_OF_TILES_ONSCREEN_X * NUMBER_OF_TILES_ONSCREEN_Y )


#define screenwidth     ([[CCDirector sharedDirector] winSize].width)
#define screenheight    ([[CCDirector sharedDirector] winSize].height)


#define KEY_FOR_TILETYPE(n) ( \
n==TILE_FLOOR_VOID ? @"VoidTile" : \
\
n==TILE_FLOOR_UPSTAIRS ? @"UpstairsTile" : \
n==TILE_FLOOR_DOWNSTAIRS ? @"DownstairsTile" : \
\
n==TILE_FLOOR_STONE_0 ? @"StoneTile0" : \
n==TILE_FLOOR_STONE_1 ? @"StoneTile1" : \
n==TILE_FLOOR_STONE_2 ? @"StoneTile2" : \
n==TILE_FLOOR_STONE_3 ? @"StoneTile3" : \
n==TILE_FLOOR_STONE_4 ? @"StoneTile4" : \
\
n==TILE_FLOOR_GRASS_0 ? @"GrassTile0" : \
n==TILE_FLOOR_GRASS_1 ? @"GrassTile1" : \
\
n==TILE_FLOOR_SAND_0 ? @"SandTile0" : \
n==TILE_FLOOR_SAND_1 ? @"SandTile1" : \
n==TILE_FLOOR_SAND_2 ? @"SandTile2" : \
n==TILE_FLOOR_SAND_3 ? @"SandTile3" : \
n==TILE_FLOOR_SAND_4 ? @"SandTile4" : \
n==TILE_FLOOR_SAND_5 ? @"SandTile5" : \
n==TILE_FLOOR_SAND_6 ? @"SandTile6" : \
n==TILE_FLOOR_SAND_7 ? @"SandTile7" : \
\
n==TILE_FLOOR_WATER_0 ? @"WaterTile0" : \
@"")

