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
} GameState_t;

@class DungeonFloor;
@class EditorHUD;
@class PlayerHUD;
@class PlayerMenu;
@class Tile;

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    
    GameState_t gameState;
    
    CGPoint selectedTilePoint;
    
    Entity *pcEntity;
    DungeonFloor *floor;
    
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
    
    
    BOOL playerHUDIsVisible;
    PlayerHUD *playerHUD;
    
    BOOL playerMenuIsVisible;
    PlayerMenu *playerMenu;
    
    CGPoint cameraAnchorPoint;
    
    double touchBeganTime;    
}

+(CCScene *) scene;

-( id ) init;
-( void ) dealloc;

-( void ) receiveNotification: ( NSNotification * ) notification;

-( void ) initPlayerMenu;
-( void ) addPlayerMenu: ( PlayerMenu * ) menu;
-( void ) removePlayerMenu: ( PlayerMenu * ) menu;

-( void ) initEditorHUD;
-( void ) addEditorHUD: ( EditorHUD * ) hud;
-( void ) removeEditorHUD: ( EditorHUD * ) hud;
-( void ) updateEditorHUDLabel;

-( void ) initMonitor;
-( void ) addMonitor: ( EditorHUD * ) monitor;
-( void ) removeMonitor: ( EditorHUD * ) monitor;
-( void ) updateMonitorLabel;

-( void ) drawDungeonFloor;



-( void ) initPlayerHUD;
-( void ) addPlayerHUD: ( PlayerHUD * ) hud;
-( void ) removePlayerHUD: ( PlayerHUD * ) hud;
-( void ) updatePlayerHUDLabel;

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
-( void ) initializeNotifications;
-( void ) initializeHUDs;
-( void ) initializePCEntity;

@end
