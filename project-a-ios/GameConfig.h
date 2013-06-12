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


