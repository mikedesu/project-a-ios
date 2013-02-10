//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"
#import "Tile.h"

@interface GameLayer : CCLayer <UIAlertViewDelegate> {
    //NSMutableArray *tileSpriteArray;
    
    NSMutableArray *tileArray;
    NSMutableArray *tileDataArray;
    
    
    //NSInteger visibleTiles[ NUMBER_OF_TILES_ONSCREEN ];
    //Tile *visibleTiles[ NUMBER_OF_TILES_ONSCREEN ];
    
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
