//  InventoryMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "InventoryMenu.h"

@implementation InventoryMenu

-(id) init {
    CGSize s = [[ CCDirector sharedDirector ] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InventoryMenuReturnNotification" object:self];
}

@end