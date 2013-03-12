//  InventoryMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "InventoryMenu.h"

@implementation InventoryMenu

@synthesize inventory;
@synthesize menu;

-(id) initWithInventory: (NSMutableArray *) pcInventory {
    CGSize s = [[ CCDirector sharedDirector ] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        
        //assuming pcInventory != nil
        NSAssert(pcInventory!=nil, @"pcInventory was nil");
        
        inventory = pcInventory;
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        CGFloat x = 0;
        CGFloat y = s.height;
        
        
        for (Entity *e in pcInventory) {
            CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Item" fontName:@"Courier New" fontSize:16] block:^(id sender) {
                MLOG(@"Not yet implemented");
            }];
            
            x = 0 + item.contentSize.width/2;
            y = y - item.contentSize.height/2;
            
            item.position = ccp( x , y );
            
            [menuItems addObject:item];
        }
        
        MLOG(@"menuItems: %@", menuItems);
        
       
        // return button
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
        
        /*
        NSArray *items = [NSArray arrayWithObjects:
                          l0,
                          nil];
        */
        [menuItems addObject:l0];
        
        menu = [CCMenu menuWithArray:menuItems];
        menu.position = ccp(0,0);
        [self addChild:menu];
        
    }
    return self;
}


-(void) update {
    [menu removeAllChildrenWithCleanup:YES];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    NSMutableArray *menuItems = [NSMutableArray array];
    //NSMutableArray *itemsNotOnPage = [NSMutableArray array];
    
    CGFloat x = 0;
    CGFloat y = s.height;
    CGFloat pad = 10;
    
    for (Entity *e in inventory) {
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:e.name fontName:@"Courier New" fontSize:14] block:^(id sender) {
            MLOG(@"Not yet implemented");
        }];
        
        x = 0 + item.contentSize.width /2 ;
        y = y - item.contentSize.height/2 - pad;
        
        if ( y >= 0 ) {
            item.position = ccp( x , y );
            [menuItems addObject:item];
        }
        else {
      //      [itemsNotOnPage addObject:item];
            MLOG(@"TOO MANY ITEMS - NEEDS PAGING");
        }
        
    }
    
    MLOG(@"menuItems: %@", menuItems);
    
    
    // return button
    CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
    l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
    
    [menuItems addObject:l0];

    for ( CCMenuItem *item in menuItems ) {
        [menu addChild: item];
    }
}



-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InventoryMenuReturnNotification" object:self];
}

@end