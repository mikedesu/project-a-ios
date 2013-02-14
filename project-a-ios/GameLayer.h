//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"
#import "EditorHUD.h"
#import "GameConfig.h"
#import "PlayerHUD.h"
#import "PlayerMenu.h"

typedef enum {
    GAMESTATE_T_MAINMENU=0,
    GAMESTATE_T_GAME,
} GameState_t;

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    
    DungeonFloor *floor;
    
    NSMutableArray *tileArray;
    
    NSMutableArray *tileDataArray;
    
    NSMutableArray *entityArray;
    
    NSMutableArray *dLog;
    NSInteger dLogIndex;
    
    BOOL isTouched;
    NSInteger touchedTileIndex;
    NSInteger selectedTile;
    NSInteger prevSelectedTile;
    
    NSInteger heroTouches;
    
    BOOL editorHUDIsVisible;
    EditorHUD *editorHUD;
    
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


-( CCSprite * ) getTileForTouch: (UITouch *) touch;
-( NSInteger ) getTileIndexForTouch: (UITouch *) touch;
-( CGPoint ) getTileCGPointForTouch: ( UITouch * ) touch;
-( Tile * ) getTileForIndex: ( NSInteger ) index;
    
-( void ) addMessage: (NSString * ) message;

-( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile;

@end