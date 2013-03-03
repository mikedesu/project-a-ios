//
//  EntityInfoHUD.h
//  project-a-ios
//
//  Created by Mike Bell on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface EntityInfoHUD : CCLayerColor {
    CCLabelTTF *label;
}

@property (atomic) CCLabelTTF *label;

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;

@end

