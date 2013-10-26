//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "GameConfig.h"
#import "Spell.h"
#import "Zodiac.h"

typedef enum {
    GAMESTATE_T_MAINMENU=0,
    GAMESTATE_T_GAME,
    GAMESTATE_T_GAME_PC_SELECTMOVE,
    GAMESTATE_T_GAME_PC_STEP,
    GAMESTATE_T_GAME_PC_DEAD,
    GAMESTATE_T_GAME_PC_FISHING_PRECAST,
    GAMESTATE_T_GAME_PC_KEY_PREUSE,
    GAMESTATE_T_GAME_PC_LEVELED_UP,
    //GAMESTATE_T_GAME_PC_SAFEROOM,
} GameState_t;

@class Maybe;

@class DungeonFloor;
@class EditorHUD;
@class EntityInfoHUD;
@class EquipMenu;
@class HelpMenu;
@class LevelUpWindow;
@class InventoryMenu;
@class DropMenu;
@class MessageWindow;
@class PlayerHUD;
@class PlayerMenu;
@class Status;
@class StatusMenu;
@class Tile;

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    
    GameState_t gameState;
    
    NSUInteger turnCounter;
    Zodiac_t zodiacEra;
    
    CGPoint selectedTilePoint;
    
    Entity *pcEntity;
    NSMutableArray *killList;
    
    NSUInteger floorNumber;
    DungeonFloor *currentFloor;
    DungeonFloor *nextFloor;
    
   // DungeonFloor *safeRoom;
    //NSMutableArray *dungeon;
    NSMutableArray *tileArray;
    NSMutableArray *tileDataArray;
    NSMutableArray *entityArray;
    
    NSMutableDictionary *sprites;
    
    NSMutableArray *dLog;
    NSInteger dLogIndex;
    
    BOOL isTouched;
    NSInteger touchedTileIndex;
    NSInteger selectedTile;
    //NSInteger prevSelectedTile;
    
    NSInteger heroTouches;
    
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
    
    //BOOL hudMenuIsVisible;
    //HUDMenu *hudMenu;
    
    BOOL statusMenuIsVisible;
    StatusMenu *statusMenu;
    
    BOOL inventoryMenuIsVisible;
    InventoryMenu *inventoryMenu;
    
    BOOL dropMenuIsVisible;
    DropMenu *dropMenu;
    
    BOOL helpMenuIsVisible;
    HelpMenu *helpMenu;
    
    BOOL equipMenuIsVisible;
    EquipMenu *equipMenu;
    
    BOOL levelUpWindowIsVisible;
    LevelUpWindow *levelUpWindow;
    
    BOOL messageWindowIsVisible;
    MessageWindow *messageWindow;
    NSMutableArray *messageQueue;
    
    CGPoint cameraAnchorPoint;
    
    double touchBeganTime;
    double touchEndedTime;
    
    BOOL gameLogicIsOn;
    BOOL autostepGameLogic;
    
    BOOL needsRedraw;
    
    
    BOOL gotKarmaThisTurn;
    NSInteger totalKarmaThisTurn;
    
    
    Spell_t currentSpellBeingCast;
}

@property (nonatomic, assign) GameState_t gameState;
@property (nonatomic, assign) NSUInteger turnCounter;
@property (nonatomic, assign) Zodiac_t zodiacEra;
@property (nonatomic, assign) Spell_t currentSpellBeingCast;
//@property (nonatomic) DungeonFloor *safeRoom;

// allow access to MasterLayer
@property (atomic) EquipMenu *equipMenu;


+(CCScene *) scene;

-( id ) init;
-( void ) dealloc;

-( void ) cleanupGame;

-( void ) receiveNotification: ( NSNotification * ) notification;

-( void ) removeNotifications;

-(void) initMessageWindow;
-(void) addMessageWindowString: (NSString *) string;
-(void) displayMessageWindow;
-(void) removeMessageWindow;

-(void) initEquipMenu;
-(void) addEquipMenu;
-(void) removeEquipMenu;


-(void) initHelpMenu;
-(void) addHelpMenu;
-(void) removeHelpMenu;

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

//-( void ) drawDungeonFloor;

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

-(void) initDropMenu;
-(void) addDropMenu;
-(void) removeDropMenu;


-(void) initLevelUpWindow;
-(void) addLevelUpWindow;
-(void) removeLevelUpWindow;



-( void ) appendNewTile;
-( void ) appendNewColorTestTile;

//-( void ) colorTest;
//-( void ) colorScrambleTile;
//-( void ) colorScrambleAllTiles;

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

-( BOOL ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position;
-( BOOL ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position onFloor: (DungeonFloor *) _floor;
    

-( void ) selectTileAtPosition: ( CGPoint ) position;
-( void ) resetCameraPosition;

//-( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b;

-( void ) initializeDungeon;
//-( void ) loadDungeonFloor: ( NSUInteger ) floorNumber;

-( void ) goingUpstairs;
-( void ) goingDownstairs;
//-( void ) goToSafeRoom;

-( void ) setEntityOnUpstairs:(Entity *)entity;
-( void ) setEntityOnDownstairs:(Entity *)entity;

-( void ) setEntityOnUpstairs:(Entity *)entity forFloor: (DungeonFloor *) _floor;
-( void ) setEntityOnDownstairs:(Entity *)entity forFloor: (DungeonFloor *) _floor;

-( void ) setEntity: (Entity *) entity onRandomTileForFloor: (DungeonFloor *) _floor;


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

-( Entity * ) getEntityForPosition: (CGPoint) p;


-( void ) scheduledStepAction;
-( void ) scheduleStepAction;
-( void ) unscheduleStepAction;

-( void ) doTimer: (SEL) selector;


-( void ) incrementTurn;

-( void ) swapAutostep;


-( BOOL ) didPCDieJustNow;
-( void ) handleTrapSetOffPC;

-(Entity *) itemDropForEntity: (Entity *) entity;
-(void) handleItemDropForEntity: (Entity *) entity;

-(void) setEntityStatus: (Entity *) entity status: (Status *) status;


-(void) preloadSoundEffects;
-(void) playSound: (NSString *) soundfilepath;

@end
