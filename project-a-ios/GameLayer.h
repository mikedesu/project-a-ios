//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"
#import "EditorHUD.h"
#import "GameConfig.h"
#import "Tile.h"

typedef enum {
    GAMESTATE_T_MAINMENU=0,
    GAMESTATE_T_GAME,
} GameState_t;

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    NSMutableArray *tileArray;
    NSMutableArray *tileDataArray;
    NSMutableArray *entityArray;
    
    NSMutableArray *messages;
    NSInteger messagesIndex;
    
    BOOL isTouched;
    NSInteger touchedTileIndex;
    NSInteger selectedTile;
    NSInteger prevSelectedTile;
    
    BOOL editorHUDIsVisible;
    EditorHUD *editorHUD;
    
    double touchBeganTime;    
}

+(CCScene *) scene;

-( id ) init;
-( void ) dealloc;
-( void ) initEditorHUD;
-( void ) addEditorHUD: ( EditorHUD * ) hud;
-( void ) removeEditorHUD: ( EditorHUD * ) hud;
-( void ) appendNewTile;
-( void ) appendNewColorTestTile;
-( void ) colorTest;
-( void ) colorScrambleTile;
-( void ) colorScrambleAllTiles;
-( void ) addBlankTiles;
-( void ) addColorTiles;
-( void ) initializeTiles;

-( void ) updateEditorHUDLabel;

-( CCSprite * ) getTileForTouch: (UITouch *) touch;
-( NSInteger ) getTileIndexForTouch: (UITouch *) touch;

-( void ) addMessage: (NSString * ) message;

@end