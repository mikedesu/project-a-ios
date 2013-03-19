//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"

@interface PlayerMenu : CCLayerColor {
    CCLabelTTF *label;
}

@property (atomic) CCLabelTTF *label;

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;
-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h isMinimized: (BOOL) isMin;

-( void ) menuItemClosePressed ;
-( void ) menuItemStatusPressed ;
-( void ) menuItemInventoryPressed ;
-( void ) menuItemRestPressed ;
-( void ) menuItemStepPressed ;
-( void ) menuItemAutostepPressed ;
-( void ) menuItemMonitorPressed ;
-( void ) menuItemTogglePositionPressed ;
-( void ) menuItemToggleHUDsPressed ;
-( void ) menuItemResetPressed ;

@end