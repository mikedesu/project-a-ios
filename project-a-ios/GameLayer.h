//  GameLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.

#import "cocos2d.h"

@interface GameLayer : CCLayer {
    NSMutableArray *grounds;
}

+(CCScene *) scene;
-(void) appendNewGround;

@end
