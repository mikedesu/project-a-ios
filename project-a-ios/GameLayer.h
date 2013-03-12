//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "GameConfig.h"

typedef enum {
    GAMESTATE_T_MAINMENU=0,
    GAMESTATE_T_GAME,
    GAMESTATE_T_GAME_PC_SELECTMOVE,
    GAMESTATE_T_GAME_PC_STEP,
    GAMESTATE_T_GAME_PC_DEAD,
} GameState_t;

@class DungeonFloor;
@class EditorHUD;
@class EntityInfoHUD;
@class HUDMenu;
@class InventoryMenu;
@class PlayerHUD;
@class PlayerMenu;
@class StatusMenu;
@class Tile;

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    
    GameState_t gameState;
    
    CGPoint selectedTilePoint;
    
    Entity *pcEntity;
    
    NSUInteger floorNumber;
    DungeonFloor *floor;
    
    NSMutableArray *dungeon;
    NSMutableArray *tileArray;
    NSMutableArray *tileDataArray;
    NSMutableArray *entityArray;
    
    NSMutableArray *dLog;
    NSInteger dLogIndex;
    
    BOOL isTouched;
    NSInteger touchedTileIndex;
    NSInteger selectedTile;
    //NSInteger prevSelectedTile;
    
    NSInteger heroTouches;
    NSUInteger turnCounter;
    
    BOOL editorHUDIsVisible;
    BOOL monitorIsVisible;
    EditorHUD *editorHUD;
    EditorHUD *monitor;
    
    BOOL entityInfoHUDIsVisible;
    EntityInfoHUD *entityInfoHUD;
    
    
    BOOL playerHUDIsVisible;
    PlayerHUD *playerHUD;
    
    BOOL gearHUDIsVisible;
    PlayerHUD *gearHUD;
    
    BOOL playerMenuIsVisible;
    PlayerMenu *playerMenu;
    
    BOOL playerMenuIsMin;
    PlayerMenu *playerMenuMin;
    
    BOOL hudMenuIsVisible;
    HUDMenu *hudMenu;
    
    BOOL statusMenuIsVisible;
    StatusMenu *statusMenu;
    
    BOOL inventoryMenuIsVisible;
    InventoryMenu *inventoryMenu;
    
    
    
    CGPoint cameraAnchorPoint;
    
    double touchBeganTime;
    
    BOOL gameLogicIsOn;
    BOOL autostepGameLogic;
    
    BOOL needsRedraw;
}

+(CCScene *) scene;

-( id ) init;
-( void ) dealloc;

-( void ) receiveNotification: ( NSNotification * ) notification;

-( void ) initPlayerMenu;
-( void ) addPlayerMenu: ( PlayerMenu * ) _menu;
-( void ) removePlayerMenu: ( PlayerMenu * ) _menu;

-( void ) initPlayerMenuMin;
-( void ) addPlayerMenuMin: ( PlayerMenu * ) _menu;
-( void ) removePlayerMenuMin: ( PlayerMenu * ) _menu;


-( void ) initEditorHUD;
-( void ) addEditorHUD: ( EditorHUD * ) _hud;
-( void ) removeEditorHUD: ( EditorHUD * ) _hud;
-( void ) updateEditorHUDLabel;

-( void ) initMonitor;
-( void ) addMonitor: ( EditorHUD * ) _monitor;
-( void ) removeMonitor: ( EditorHUD * ) _monitor;
-( void ) updateMonitorLabel;

-( void ) drawDungeonFloor;

-( void ) initEntityInfoHUD;
-( void ) addEntityInfoHUD: (EntityInfoHUD *) _entityInfoHUD ;
-( void ) updateEntityInfoHUDLabel ;
-( void ) removeEntityInfoHUD: (EntityInfoHUD *) _entityInfoHUD ;
    

-( void ) initPlayerHUD;
-( void ) addPlayerHUD: ( PlayerHUD * ) _hud;
-( void ) removePlayerHUD: ( PlayerHUD * ) _hud;
-( void ) updatePlayerHUDLabel;


-( void ) initGearHUD;
-( void ) addGearHUD: ( PlayerHUD * ) _hud;
-( void ) removeGearHUD: ( PlayerHUD * ) _hud;
-( void ) updateGearHUDLabel;

-(void) initStatusMenu;
-(void) addStatusMenu;
-(void) removeStatusMenu;
-(void) updateStatusMenu;

-(void) initInventoryMenu;
-(void) addInventoryMenu;
-(void) removeInventoryMenu;
-(void) updateInventoryMenu;






-( void ) appendNewTile;
-( void ) appendNewColorTestTile;

-( void ) colorTest;
-( void ) colorScrambleTile;
-( void ) colorScrambleAllTiles;

-( void ) addBlankTiles;
-( void ) addColorTiles;

-( void ) initializeTiles;
-( void ) initializeTileArray;

-( Tile * ) getTileForCGPoint: ( CGPoint ) p  ;
-( CCSprite * ) getTileSpriteForCGPoint: ( CGPoint ) p;
-( CCSprite * ) getTileForTouch: (UITouch *) touch;

-( NSInteger ) getTileIndexForTouch: (UITouch *) touch;
-( CGPoint ) getTileCGPointForTouch: ( UITouch * ) touch;
-( Tile * ) getTileForIndex: ( NSInteger ) index;
    
-( void ) addMessage: (NSString * ) message;

-( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile;

-( CGPoint ) translateTouchPointToMapPoint: (CGPoint) touchPoint;

-( Entity * ) getEntityForName: ( NSString * ) name;

-( void ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position;
-( void ) selectTileAtPosition: ( CGPoint ) position;
-( void ) resetCameraPosition;

-( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b;

-( void ) initializeDungeon;
-( void ) loadDungeonFloor: ( NSUInteger ) floorNumber;

-( void ) goingUpstairs;
-( void ) goingDownstairs;

-( void ) setEntityOnUpstairs:(Entity *)entity;
-( void ) setEntityOnDownstairs:(Entity *)entity;

-( void ) setEntityOnUpstairs:(Entity *)entity forFloor: (DungeonFloor *) floor;
-( void ) setEntityOnDownstairs:(Entity *)entity forFloor: (DungeonFloor *) floor;



    -( void ) initializeNotifications;
-( void ) initializeHUDs;
-( void ) initializePCEntity;

-( Entity * ) npcEntityAtPosition: (CGPoint) pos;
-( void ) handleAttackForEntity: ( Entity * ) e toPosition: (CGPoint) pos;
-( void ) handleItemPickup: (Entity *) item forEntity: (Entity *) entity;
-( void ) handleDropItem: (Entity *) item forEntity: (Entity *) entity;
    
-( NSString * ) getGameStateString: ( GameState_t ) state;
-( void ) stepGameLogic;
-( void ) handleEntityStep: ( Entity * ) e;

-( void ) scheduledStepAction;
-( void ) scheduleStepAction;
-( void ) unscheduleStepAction;

-( void ) doTimer: (SEL) selector;

@end
