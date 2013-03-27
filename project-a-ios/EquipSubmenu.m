//  EquipSubmenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EquipSubmenu.h"


@implementation EquipSubmenu

@synthesize title;
@synthesize pc;
@synthesize menu;
@synthesize menuControlBlock;


-(void) defineMenuControlBlock {
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        MLOG(@"Testing...");
    };
}

-(id) initWithPC: (Entity *) _pc {
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        
        pc = _pc;
        
        title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
        title.position = ccp( screenwidth/2, screenheight - title.contentSize.height );
        [self addChild: title];
        
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        //return button
        CCMenuItemLabel *returnButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        returnButton.position = ccp( returnButton.contentSize.width/2, returnButton.contentSize.height/2 );
        
        [menuItems addObject: returnButton];
        
        menu = [CCMenu menuWithArray:menuItems];
        menu.position = ccp(0,0);
        [self addChild:menu];

        
    }
    return self;
}



-(void) update {
    MLOG(@"Updating");
    [menu removeAllChildrenWithCleanup:YES];
    
    //CCLabelTTF *title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
    //title.position = ccp( screenwidth/2, screenheight - title.contentSize.height );
    //[self addChild: title];
    
    
    NSMutableArray *menuItems = [NSMutableArray array];
    
    //return button
    CCMenuItemLabel *returnButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
    returnButton.position = ccp( returnButton.contentSize.width/2, returnButton.contentSize.height/2 );
    
    [menuItems addObject: returnButton];
    
    for ( CCMenuItem *item in menuItems ) {
        [menu addChild: item];
    }
    
}


-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotification" object:self];
}


@end
