/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
//  DropMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.

#import "DropMenu.h"

@implementation DropMenu

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
        
        // handle the item drop
        Entity *eItem = [inventory objectAtIndex:sender.tag];
        [ gameLayer handleDropItem:eItem forEntity:pc ];
        
        // remove DropMenu
        [ gameLayer removeDropMenu ];
        
        // step forward
        [gameLayer stepGameLogic];
        
        // remove the item from the menu
        [sender.parent  removeChild:sender   cleanup:YES];
    };
}


/*
 ====================
 initWithPC: _pc withFloor: _floor withGameLayer: _gameLayer
 
 initialize the drop menu
 ====================
 */
-(id) initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer {
//    CGSize s = [[ CCDirector sharedDirector ] winSize];
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        pc = _pc;
        inventory = _pc.inventoryArray;
        floor = _floor;
        gameLayer = _gameLayer;
        
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        CGFloat x = 0;
        CGFloat y = s.height;
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerMenuDropReturnNotification" object:nil];
}

@end