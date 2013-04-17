//  MessageWindow.h
//  project-a-ios
//
//  Created by Mike Bell on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@interface MessageWindow : CCLayerColor {
    CCLabelTTF *label;
}

@property (atomic) CCLabelTTF *label;

@end
