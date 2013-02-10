//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    NSMutableArray *tileArray;
    
    NSInteger visibleTiles[ NUMBER_OF_TILES_ONSCREEN ];
    
    NSInteger selectedTile;
    NSInteger prevSelectedTile;
}

+(CCScene *) scene;

-( id ) init;
-( void ) appendNewTile;
-( void ) appendNewColorTestTile;
-( void ) colorTest;
-( void ) colorScrambleTile;
-( void ) colorScrambleAllTiles;
-( void ) addBlankTiles;
-( void ) addColorTiles;
-( void ) initializeTiles;

-( CCSprite * ) getTileForTouch: (UITouch *) touch;
-( NSInteger ) getTileIndexForTouch: (UITouch *) touch;

@end
