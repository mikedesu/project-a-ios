//  PlayerHUD.h
//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"

@interface PlayerHUD : CCLayerColor {
@public
    CCLabelTTF *label;
}

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;

@end
