//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"

@interface GameLayer : CCLayer {
    //NSMutableArray *grounds;
    NSMutableArray *gfxTiles;
}

+(CCScene *) scene;

-(void) appendNewTile;
-(void) appendNewColorTestTile;
-(void) colorTest;
-(void) colorScrambleTile;
-(void) colorScrambleAllTiles;

@end
