//  StatusMenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"

@interface StatusMenu : CCLayerColor {
    NSString *contentStr;
    CCLabelTTF *content;
}
@property (atomic) CCLabelTTF *content;
@property (atomic) NSString *contentStr;
//-(id) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;

@end
