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
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        
        BOOL handled = YES;
        Entity *eItem = [inventory objectAtIndex:sender.tag];
        
        if ( eItem.itemType == E_ITEM_T_POTION ) {
            if ( eItem.potionType == POTION_T_HEALING ) {
                NSInteger total = [Dice roll: eItem.healingRollBase] + eItem.healingBonus;
                pc.hp += total;
                if ( pc.hp > pc.maxhp ) pc.hp = pc.maxhp;
                [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@ recovered %d hp", pc.name, total]];
            }
            
            else if ( eItem.potionType == POTION_T_POISON_ANTIDOTE ) {
                
                // for now - instant-cure
                pc.status = [Status normal];
                [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@ is cured of poison!", pc.name]];
                
            }
        }
        
        else if ( eItem.itemType == E_ITEM_T_FOOD ) {
            pc.hunger -= eItem.foodBase;
            [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@ ate a %@", pc.name, eItem.name]];
        }
        
        else if ( eItem.itemType == E_ITEM_T_FISH ) {
            pc.hunger -= eItem.foodBase;
            [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@ ate a %@", pc.name, eItem.name]];
        }
        
        // fishing
        else if ( eItem.itemType == E_ITEM_T_FISHING_ROD ) {
            [gameLayer addMessageWindowString: [NSString stringWithFormat:@"Cast your %@ where?", eItem.name]];
            [gameLayer setGameState: GAMESTATE_T_GAME_PC_FISHING_PRECAST];
            // do not remove fishing rod from inventory
            //handled = NO;
        }
        
        else if ( eItem.itemType == E_ITEM_T_KEY_SIMPLE ) {
            [gameLayer addMessageWindowString: @"Unlock which door?"];
            [gameLayer setGameState: GAMESTATE_T_GAME_PC_KEY_PREUSE];
            // do not remove simple key from inventory
            //handled = NO;
        }
        
        else if ( eItem.itemType == E_ITEM_T_SCROLL ) {
            
            gameLayer.currentSpellBeingCast = eItem.spell;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerMenuCastNotification" object:nil];
            
        }
        
        else if ( eItem.itemType == E_ITEM_T_WAND ) {
            
            if ( eItem.charges > 0 ) {
                gameLayer.currentSpellBeingCast = eItem.spell;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerMenuCastNotification" object:nil];
            }
            else {
                [gameLayer addMessageWindowString:@"No charges remain in wand!"];
            }
        }
        
        else if ( eItem.itemType == E_ITEM_T_NOTE ) {
            [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@ read the note...", pc.name]];
            [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@", eItem.notetext]];
            [gameLayer addMessageWindowString:@"The note crumbles..."];
            //handled = NO; //don't ditch it from our inventory
        }
        
        
        
        
        else {
            MLOG(@"Not handled!");
            [gameLayer addMessageWindowString:[NSString stringWithFormat:@"%@-use not handled yet!", eItem.name]];
            handled = NO;
        }
        
        [gameLayer removeInventoryMenu];
        
        if (handled) {
            [gameLayer stepGameLogic];
            ( eItem.itemType != E_ITEM_T_FISHING_ROD )
             //&& eItem.itemType != E_ITEM_T_KEY_SIMPLE )
            ? [gameLayer stepGameLogic] : 0 ;
            
            // dont remove fishing rods (or other things...)
            ( eItem.itemType != E_ITEM_T_FISHING_ROD && 
              //eItem.itemType != E_ITEM_T_KEY_SIMPLE  &&
              eItem.itemType != E_ITEM_T_WAND )
            ? [inventory removeObjectAtIndex: sender.tag] : 0 ;
            
            
            if ( eItem.itemType == E_ITEM_T_WAND ) {
                // decrease charges
                if ( eItem.charges > 0 )
                    eItem.charges--;
            }
            
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
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        pc = _pc;
        inventory = _pc.inventoryArray;
        floor = _floor;
        gameLayer = _gameLayer;
        
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        CGFloat pad = 20;
        CGFloat x = 0;
        CGFloat y = s.height - pad;
        
        [self defineMenuControlBlock];
        
        for (int i = 0; i < inventory.count; i++) {
            
            CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Item" fontName:@"Courier New" fontSize:16]
                                                             block: menuControlBlock];
            
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
        menu.position = ccp(0,0);
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
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    NSMutableArray *menuItems = [NSMutableArray array];
    
    CGFloat x = 0;
    CGFloat y = s.height;
    CGFloat pad = 10;
    
    for (int i = 0; i < inventory.count; i++) {
        Entity *e = [inventory objectAtIndex:i];
        
        NSString *nameToDisplay;
        
        if ( e.itemType == E_ITEM_T_WAND ) {
            nameToDisplay = [NSString stringWithFormat:@"%@ %d:%d", e.name, e.charges, e.maxCharges];
        } else {
            nameToDisplay = e.name;
        }
        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:nameToDisplay fontName:@"Courier New" fontSize:14]
                                                         block:menuControlBlock];
        
        x = 0 + item.contentSize.width /2 ;
        y = y - item.contentSize.height/2 - pad;
        
        [item setTag: i];
        item.position = ccp( x , y );
        [menuItems addObject:item];
        
    }
    
    // return button
    CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
    l0.position = ccp( 0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2 );
    
    [menuItems addObject:l0];
    
    for ( CCMenuItem *item in menuItems ) {
        [menu addChild: item];
    }
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