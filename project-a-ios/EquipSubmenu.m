//  EquipSubmenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EquipSubmenu.h"


@implementation EquipSubmenu

@synthesize pc;
@synthesize menu;
@synthesize menuControlBlock;


-(void) defineMenuControlBlock {
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        MLOG(@"Testing...");
    };
}

-(id) initWithPC: (Entity *) pc {
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        
    }
    return self;
}


@end
