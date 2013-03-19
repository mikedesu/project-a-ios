//  InventoryMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "InventoryMenu.h"

@implementation InventoryMenu

@synthesize inventory;
@synthesize menu;
@synthesize pc;
@synthesize floor;
@synthesize gameLayer;
@synthesize menuControlBlock;


/*
 ====================
 defineMenuControlBlock
 
 define the menu control block
 ====================
 */
-(void) defineMenuControlBlock {
    menuControlBlock = ^(CCMenuItemLabel *sender) {
        
        BOOL handled = YES;
        Entity *eItem = [inventory objectAtIndex:sender.tag];
        
        if ( eItem.itemType == E_ITEM_T_POTION ) {
            if ( eItem.potionType == POTION_T_HEALING ) {
                NSInteger total = [Dice roll: eItem.healingRollBase] + eItem.healingBonus;
                pc.hp += total;
                if ( pc.hp > pc.maxhp ) pc.hp = pc.maxhp;
                [gameLayer addMessage:[NSString stringWithFormat:@"%@ recovered %d hp", pc.name, total]];
            }
        }
        else if ( eItem.itemType == E_ITEM_T_FOOD ) {
            pc.hunger -= eItem.foodBase;
            [gameLayer addMessage:[NSString stringWithFormat:@"%@ ate a %@", pc.name, eItem.name]];
        }
        else {
            MLOG(@"Not handled!");
            [gameLayer addMessage:[NSString stringWithFormat:@"%@-use not handled yet!", eItem.name]];
            handled = NO;
        }
        
        [gameLayer removeInventoryMenu];
        
        if (handled) {
            [gameLayer stepGameLogic];
            [inventory      removeObjectAtIndex: sender.tag];
            [sender.parent  removeChild:sender   cleanup:YES];
        }
    };
}


/*
 ====================
 initWithPC: _pc withFloor: _floor withGameLayer: _gameLayer
 
 initialize the inventory menu
 ====================
 */
-(id) initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer {
    CGSize s = [[ CCDirector sharedDirector ] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        CGSize s        = [[CCDirector sharedDirector] winSize];
        pc              = _pc;
        inventory       = _pc.inventoryArray;
        floor           = _floor;
        gameLayer       = _gameLayer;
        
        NSMutableArray *menuItems = [NSMutableArray array];
        CGFloat x = 0;
        CGFloat y = s.height;
        
        [self defineMenuControlBlock];
        
        for (int i = 0; i < inventory.count; i++) {
            CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Item" fontName:@"Courier New" fontSize:16]
                                                             block: menuControlBlock];
            item.color = white3;
            
            x = 0 + item.contentSize.width/2;
            y = y - item.contentSize.height/2;
            item.position = ccp( x , y );
            [item setTag: i];
            [menuItems addObject:item];
        }
        
        // return button
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
        
        [menuItems addObject:l0];
        
        menu = [CCMenu menuWithArray:menuItems];
        menu.position = CGPointZero;
        [self addChild:menu];
    }
    return self;
}


/*
 ====================
 update
 
 update the inventory menu
 ====================
*/
-(void) update {
    [menu removeAllChildrenWithCleanup:YES];
    
    CGSize s                    = [[CCDirector sharedDirector] winSize];
    NSMutableArray *menuItems   = [NSMutableArray array];
    
    CGFloat x   = 0;
    CGFloat y   = s.height;
    CGFloat pad = 10;
    
    for (int i = 0; i < inventory.count; i++) {
        Entity *e = [inventory objectAtIndex:i];
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:e.name fontName:@"Courier New" fontSize:14]
                                                         block:menuControlBlock];
        item.color = white3;
        
        x = 0 + item.contentSize.width /2 ;
        y = y - item.contentSize.height/2 - pad;
        [item setTag: i];
        item.position = ccp( x , y );
        [menuItems addObject:item];
    }
    
    // return button
    CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
    l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
    l0.color = white3;
    
    [menuItems addObject:l0];

    for ( CCMenuItem *item in menuItems ) [menu addChild: item];
    
}


/*
 ====================
 returnPressed
 
 handle the return button
 ====================
 */
-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InventoryMenuReturnNotification" object:self];
}

@end