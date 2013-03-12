//  StatusMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "StatusMenu.h"

@implementation StatusMenu


-(id) init {
    CGSize s = [[CCDirector sharedDirector] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp(s.width/2,s.height/2);
        
        NSArray *items = [NSArray arrayWithObjects:
                          l0,
                          nil];
        
        CCMenu *menu = [CCMenu menuWithArray:items];
        menu.position = ccp(0,0);
        [self addChild:menu];
        
    }
    return self;
}


-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StatusMenuReturnNotification" object:self];
}


@end