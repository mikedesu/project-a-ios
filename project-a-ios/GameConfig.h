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
n==TILE_FLOOR_STONE_5 ? @"StoneTile5" : \
n==TILE_FLOOR_STONE_6 ? @"StoneTile6" : \
n==TILE_FLOOR_STONE_7 ? @"StoneTile7" : \
n==TILE_FLOOR_STONE_8 ? @"StoneTile8" : \
n==TILE_FLOOR_STONE_9 ? @"StoneTile9" : \
n==TILE_FLOOR_STONE_10 ? @"StoneTile10" : \
n==TILE_FLOOR_STONE_11 ? @"StoneTile11" : \
n==TILE_FLOOR_STONE_12 ? @"StoneTile12" : \
n==TILE_FLOOR_STONE_13 ? @"StoneTile13" : \
n==TILE_FLOOR_STONE_14 ? @"StoneTile14" : \
n==TILE_FLOOR_STONE_15 ? @"StoneTile15" : \
n==TILE_FLOOR_STONE_16 ? @"StoneTile16" : \
n==TILE_FLOOR_STONE_17 ? @"StoneTile17" : \
n==TILE_FLOOR_STONE_18 ? @"StoneTile18" : \
n==TILE_FLOOR_STONE_19 ? @"StoneTile19" : \
n==TILE_FLOOR_STONE_20 ? @"StoneTile20" : \
n==TILE_FLOOR_STONE_21 ? @"StoneTile21" : \
n==TILE_FLOOR_STONE_22 ? @"StoneTile22" : \
n==TILE_FLOOR_STONE_23 ? @"StoneTile23" : \
n==TILE_FLOOR_STONE_24 ? @"StoneTile24" : \
\
n==TILE_FLOOR_GRASS_0 ? @"GrassTile0" : \
n==TILE_FLOOR_GRASS_1 ? @"GrassTile1" : \
n==TILE_FLOOR_GRASS_2 ? @"GrassTile2" : \
n==TILE_FLOOR_GRASS_3 ? @"GrassTile3" : \
n==TILE_FLOOR_GRASS_4 ? @"GrassTile4" : \
n==TILE_FLOOR_GRASS_5 ? @"GrassTile5" : \
n==TILE_FLOOR_GRASS_6 ? @"GrassTile6" : \
n==TILE_FLOOR_GRASS_7 ? @"GrassTile7" : \
n==TILE_FLOOR_GRASS_8 ? @"GrassTile8" : \
n==TILE_FLOOR_GRASS_9 ? @"GrassTile9" : \
n==TILE_FLOOR_GRASS_10 ? @"GrassTile10" : \
n==TILE_FLOOR_GRASS_11 ? @"GrassTile11" : \
n==TILE_FLOOR_GRASS_12 ? @"GrassTile12" : \
n==TILE_FLOOR_GRASS_13 ? @"GrassTile13" : \
n==TILE_FLOOR_GRASS_14 ? @"GrassTile14" : \
n==TILE_FLOOR_GRASS_15 ? @"GrassTile15" : \
n==TILE_FLOOR_GRASS_16 ? @"GrassTile16" : \
n==TILE_FLOOR_GRASS_17 ? @"GrassTile17" : \
n==TILE_FLOOR_GRASS_18 ? @"GrassTile18" : \
n==TILE_FLOOR_GRASS_19 ? @"GrassTile19" : \
n==TILE_FLOOR_GRASS_20 ? @"GrassTile20" : \
n==TILE_FLOOR_GRASS_21 ? @"GrassTile21" : \
n==TILE_FLOOR_GRASS_22 ? @"GrassTile22" : \
n==TILE_FLOOR_GRASS_23 ? @"GrassTile23" : \
n==TILE_FLOOR_GRASS_24 ? @"GrassTile24" : \
n==TILE_FLOOR_GRASS_25 ? @"GrassTile25" : \
n==TILE_FLOOR_GRASS_26 ? @"GrassTile26" : \
n==TILE_FLOOR_GRASS_27 ? @"GrassTile27" : \
n==TILE_FLOOR_GRASS_28 ? @"GrassTile28" : \
n==TILE_FLOOR_GRASS_29 ? @"GrassTile29" : \
n==TILE_FLOOR_GRASS_30 ? @"GrassTile30" : \
n==TILE_FLOOR_GRASS_31 ? @"GrassTile31" : \
n==TILE_FLOOR_GRASS_32 ? @"GrassTile32" : \
n==TILE_FLOOR_GRASS_33 ? @"GrassTile33" : \
n==TILE_FLOOR_GRASS_34 ? @"GrassTile34" : \
n==TILE_FLOOR_GRASS_35 ? @"GrassTile35" : \
n==TILE_FLOOR_GRASS_36 ? @"GrassTile36" : \
n==TILE_FLOOR_GRASS_37 ? @"GrassTile37" : \
n==TILE_FLOOR_GRASS_38 ? @"GrassTile38" : \
n==TILE_FLOOR_GRASS_39 ? @"GrassTile39" : \
n==TILE_FLOOR_GRASS_40 ? @"GrassTile40" : \
n==TILE_FLOOR_GRASS_41 ? @"GrassTile41" : \
n==TILE_FLOOR_GRASS_42 ? @"GrassTile42" : \
n==TILE_FLOOR_GRASS_43 ? @"GrassTile43" : \
n==TILE_FLOOR_GRASS_44 ? @"GrassTile44" : \
n==TILE_FLOOR_GRASS_45 ? @"GrassTile45" : \
n==TILE_FLOOR_GRASS_46 ? @"GrassTile46" : \
n==TILE_FLOOR_GRASS_47 ? @"GrassTile47" : \
n==TILE_FLOOR_GRASS_48 ? @"GrassTile48" : \
n==TILE_FLOOR_GRASS_49 ? @"GrassTile49" : \
n==TILE_FLOOR_GRASS_50 ? @"GrassTile50" : \
n==TILE_FLOOR_GRASS_51 ? @"GrassTile51" : \
n==TILE_FLOOR_GRASS_52 ? @"GrassTile52" : \
n==TILE_FLOOR_GRASS_53 ? @"GrassTile53" : \
n==TILE_FLOOR_GRASS_54 ? @"GrassTile54" : \
n==TILE_FLOOR_GRASS_55 ? @"GrassTile55" : \
n==TILE_FLOOR_GRASS_56 ? @"GrassTile56" : \
n==TILE_FLOOR_GRASS_57 ? @"GrassTile57" : \
n==TILE_FLOOR_GRASS_58 ? @"GrassTile58" : \
n==TILE_FLOOR_GRASS_59 ? @"GrassTile59" : \
n==TILE_FLOOR_GRASS_60 ? @"GrassTile60" : \
n==TILE_FLOOR_GRASS_61 ? @"GrassTile61" : \
n==TILE_FLOOR_GRASS_62 ? @"GrassTile62" : \
n==TILE_FLOOR_GRASS_63 ? @"GrassTile63" : \
\
n==TILE_FLOOR_DIRT_0 ? @"DirtTile0" : \
n==TILE_FLOOR_DIRT_1 ? @"DirtTile1" : \
n==TILE_FLOOR_DIRT_2 ? @"DirtTile2" : \
n==TILE_FLOOR_DIRT_3 ? @"DirtTile3" : \
n==TILE_FLOOR_DIRT_4 ? @"DirtTile4" : \
n==TILE_FLOOR_DIRT_5 ? @"DirtTile5" : \
n==TILE_FLOOR_DIRT_6 ? @"DirtTile6" : \
n==TILE_FLOOR_DIRT_7 ? @"DirtTile7" : \
n==TILE_FLOOR_DIRT_8 ? @"DirtTile8" : \
n==TILE_FLOOR_DIRT_9 ? @"DirtTile9" : \
n==TILE_FLOOR_DIRT_10 ? @"DirtTile10" : \
n==TILE_FLOOR_DIRT_11 ? @"DirtTile11" : \
n==TILE_FLOOR_DIRT_12 ? @"DirtTile12" : \
n==TILE_FLOOR_DIRT_13 ? @"DirtTile13" : \
n==TILE_FLOOR_DIRT_14 ? @"DirtTile14" : \
n==TILE_FLOOR_DIRT_15 ? @"DirtTile15" : \
n==TILE_FLOOR_DIRT_16 ? @"DirtTile16" : \
n==TILE_FLOOR_DIRT_17 ? @"DirtTile17" : \
n==TILE_FLOOR_DIRT_18 ? @"DirtTile18" : \
n==TILE_FLOOR_DIRT_19 ? @"DirtTile19" : \
n==TILE_FLOOR_DIRT_20 ? @"DirtTile20" : \
n==TILE_FLOOR_DIRT_21 ? @"DirtTile21" : \
n==TILE_FLOOR_DIRT_22 ? @"DirtTile22" : \
n==TILE_FLOOR_DIRT_23 ? @"DirtTile23" : \
n==TILE_FLOOR_DIRT_24 ? @"DirtTile24" : \
n==TILE_FLOOR_DIRT_25 ? @"DirtTile25" : \
n==TILE_FLOOR_DIRT_26 ? @"DirtTile26" : \
n==TILE_FLOOR_DIRT_27 ? @"DirtTile27" : \
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
n==TILE_FLOOR_METAL_0 ? @"MetalTile0" : \
n==TILE_FLOOR_METAL_1 ? @"MetalTile1" : \
n==TILE_FLOOR_METAL_2 ? @"MetalTile2" : \
n==TILE_FLOOR_METAL_3 ? @"MetalTile3" : \
\
n==TILE_FLOOR_MUD_0 ? @"MudTile0" : \
n==TILE_FLOOR_QUICKSAND_0 ? @"QuicksandTile0" : \
n==TILE_FLOOR_SNOW_0 ? @"SnowTile0" : \
n==TILE_FLOOR_ICE_0 ? @"IceTile0" : \
n==TILE_FLOOR_CLOUD_0 ? @"CloudTile0" : \
n==TILE_FLOOR_WOOD_0 ? @"WoodTile0" : \
n==TILE_FLOOR_LAVA_0 ? @"LavaTile0" : \
n==TILE_FLOOR_SWAMP_0 ? @"SwampTile0" : \
\
n==TILE_FLOOR_SPACE_0 ? @"SpaceTile0" : \
n==TILE_FLOOR_SPACE_1 ? @"SpaceTile1" : \
n==TILE_FLOOR_SPACE_2 ? @"SpaceTile2" : \
n==TILE_FLOOR_SPACE_3 ? @"SpaceTile3" : \
\
n==TILE_FLOOR_WATER_0 ? @"WaterTile0" : \
@"")

