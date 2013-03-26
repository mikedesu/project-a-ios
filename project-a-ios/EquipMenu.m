//  EquipMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EquipMenu.h"

@implementation EquipMenu

-(id) init {
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        
        
        CCLabelTTF *title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, screenheight) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
        
        title.position = ccp( screenwidth/2, screenheight/2 );
        
        [self addChild:title];
        
        
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
        
        [menuItems addObject:l0];
        
        menu = [CCMenu menuWithArray:menuItems];
        menu.position = ccp(0,0);
        [self addChild:menu];

    }
    return self;
}



/*
 ====================
 returnPressed
 
 handle the return button
 ====================
 */
-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipMenuReturnNotification" object:self];
}


@end
