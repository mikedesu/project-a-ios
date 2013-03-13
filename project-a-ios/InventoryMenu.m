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

-(id) initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer {
    CGSize s = [[ CCDirector sharedDirector ] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        pc = _pc;
        inventory = _pc.inventoryArray;
        floor = _floor;
        gameLayer = _gameLayer;
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        CGFloat x = 0;
        CGFloat y = s.height;
    
        for (int i = 0; i < inventory.count; i++) {
            
            //Entity *e = [pcInventory objectAtIndex:i];
            CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Item" fontName:@"Courier New" fontSize:16] block:^(CCMenuItemLabel * sender) {
                MLOG(@"%@ : %d", sender.label.string, sender.tag );
                Entity *eItem = [inventory objectAtIndex:sender.tag];
                
                if ( eItem.itemType == E_ITEM_T_POTION ) {
                    MLOG(@"is potion");
                    
                    // handle potion use
                    if ( eItem.potionType == POTION_T_HEALING ) {
                        NSInteger total = [Dice roll: eItem.healingRollBase] + eItem.healingBonus;
                        pc.hp += total;
                        if ( pc.hp > pc.maxhp ) pc.hp = pc.maxhp;
                        MLOG(@"healed %d", total);
                    }
                }
 
                //NSUInteger tc = gameLayer.turnCounter + 1;
                //[gameLayer setTurnCounter: tc];
                //[gameLayer incrementTurn];
                
                [gameLayer removeInventoryMenu];
                
                [gameLayer stepGameLogic];
                
                [inventory      removeObjectAtIndex: sender.tag];
                [sender.parent  removeChild:sender   cleanup:YES];
            }];
            
            x = 0 + item.contentSize.width/2;
            y = y - item.contentSize.height/2;
            
            item.position = ccp( x , y );
            [item setTag: i];
            
            [menuItems addObject:item];
        }
        
        
        
        
        
        
        
        
        MLOG(@"menuItems: %@", menuItems);
        
       
        // return button
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
        
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
    
    for (int i = 0; i < inventory.count; i++) {
        Entity *e = [inventory objectAtIndex:i];
        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:e.name fontName:@"Courier New" fontSize:14] block:^(CCMenuItemLabel *sender) {

            // handle item use
            Entity *eItem = [inventory objectAtIndex:sender.tag];
            
            //MLOG(@"%@ : %d", sender.label.string, sender.tag );
            MLOG(@"%@ ", eItem.name );
            
            if ( eItem.itemType == E_ITEM_T_POTION ) {
                MLOG(@"is potion");
                
                // handle potion use
                if ( eItem.potionType == POTION_T_HEALING ) {
                    NSInteger total = [Dice roll: eItem.healingRollBase] + eItem.healingBonus;
                    pc.hp += total;
                    if ( pc.hp > pc.maxhp ) pc.hp = pc.maxhp;
                    MLOG(@"healed %d", total);
                    
                }
            }
            
            //NSUInteger tc = gameLayer.turnCounter + 1;
            //[gameLayer setTurnCounter: tc];
            
            [gameLayer removeInventoryMenu];
            
            [gameLayer stepGameLogic];
            
            //[gameLayer incrementTurn];
            
            [inventory      removeObjectAtIndex: sender.tag];
            InventoryMenu *inventoryMenu = (InventoryMenu *) sender.parent.parent;
            [sender.parent  removeChild:sender   cleanup:YES]; // removes this item from the inventory on use
            
            [inventoryMenu update];
        }];
        
        x = 0 + item.contentSize.width /2 ;
        y = y - item.contentSize.height/2 - pad;
        
        
        if ( y >= 0 ) {
            [item setTag: i];
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