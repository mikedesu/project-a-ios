/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
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
@synthesize equipSlot;

#define UNEQUIP_TAG 7770

-(void) defineMenuControlBlock {
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        
        // do unequip
        if ( sender.tag == UNEQUIP_TAG ) {
            [self.pc unequipItemForEquipSlot: equipSlot ];
            NSString *str = [NSString stringWithFormat:@"You unequip that item"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationUpdateReturn" object:str];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationUpdateReturn" object:self];
        }
        
        else {
        
            Entity *item = [pc.inventoryArray objectAtIndex: sender.tag];
            MLOG(@"Item pressed: %@", item.name);
        
            // do equipping
            // ...
            [self.pc equipItem:item forEquipSlot: equipSlot];
        
            // return to equipMenu
            NSString *str = [NSString stringWithFormat:@"You equip a %@", item.name];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationUpdateReturn" object:str];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationUpdateReturn" object:self];
        }
    };
}


-(id) initWithPC: (Entity *) _pc {
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        [self defineMenuControlBlock];
        
        pc = _pc;
        
        title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
        title.position = ccp( screenwidth/2, screenheight - title.contentSize.height );
        [self addChild: title];
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        CGFloat x = 0;
        CGFloat y = screenheight;
        
        for (int i=0; i < pc.inventoryArray.count; i++ ) {
            
            Entity *e = [pc.inventoryArray objectAtIndex:i];

            if ( e.entityType == ENTITY_T_ITEM ) {
                // list all items for now
                CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:e.name fontName:@"Courier New" fontSize:16] block:menuControlBlock];
                
                x = 0 + item.contentSize.width/2;
                y = y - item.contentSize.height;
                
                item.position = ccp(x,y);
                [item setTag: i];
                
                [menuItems addObject: item];
            }
        }
        
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Unequip" fontName:@"Courier New" fontSize:16] block:menuControlBlock];
        x = 0 + item.contentSize.width/2;
        y = y - item.contentSize.height;
        item.position = ccp(x,y);
        [item setTag: UNEQUIP_TAG];
        [menuItems addObject: item];
        
        
        
        
        
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
    
    NSMutableArray *menuItems = [NSMutableArray array];
    
    CGFloat x = 0;
    CGFloat y = title.position.y - title.contentSize.height;
    
    for (int i=0; i < pc.inventoryArray.count; i++ ) {
        
        Entity *e = [pc.inventoryArray objectAtIndex:i];
        
        if ( e.entityType == ENTITY_T_ITEM ) {
            
            // check for each type of equipslot,
            // and handle listing the relevant item type
            
            CCMenuItemLabel *item;
            BOOL itemIsSet =
            ((self.equipSlot == EQUIPSLOT_T_LARMTOOL || self.equipSlot == EQUIPSLOT_T_RARMTOOL) && (e.itemType == E_ITEM_T_WEAPON || e.armorType == ARMOR_T_SHIELD)) ||
            //(self.equipSlot == EQUIPSLOT_T_CHEST                                               && e.itemType == E_ITEM_T_ARMOR)   ||
            (self.equipSlot == EQUIPSLOT_T_HEAD                                                && e.armorType == ARMOR_T_HELMET) || 
            (self.equipSlot == EQUIPSLOT_T_CHEST                                               && (e.armorType == ARMOR_T_VEST || e.armorType == ARMOR_T_ROBE))   ||
            ((self.equipSlot == EQUIPSLOT_T_FEET )     && e.armorType == ARMOR_T_SHOE)   ||
            
            ((self.equipSlot == EQUIPSLOT_T_LRING || self.equipSlot == EQUIPSLOT_T_RRING) && e.itemType == E_ITEM_T_RING);
            
            
            for (int j=0; j < pc.equipment.count; j++ ) {
                Entity *equipment = [pc.equipment objectAtIndex:j];
                BOOL equipmentIsEntity = NO;
                if ( [[Maybe something:equipment] hasSomething] ) {
                    equipmentIsEntity = [equipment isKindOfClass:NSClassFromString(@"Entity")];
                }
                if ( equipmentIsEntity ) {
                    BOOL isSameName = [e.name isEqualToString: equipment.name];
                    itemIsSet = itemIsSet && !(isSameName);
                }
            }
            
            // fix a bug where if leftarmtool equipped with X, X wont show up in rightarmtool's list
            // same for viceversa
            // will probably affect anything with dual sides
            Entity *larmTool = [pc.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL];
            Entity *rarmTool = [pc.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL];
            
            BOOL larmToolIsEntity = NO;
            BOOL rarmToolIsEntity = NO;
            
            if ( [[Maybe something:larmTool] hasSomething] ) {
                larmToolIsEntity = [larmTool isKindOfClass:NSClassFromString(@"Entity")];
            }
            if ( [[Maybe something:rarmTool] hasSomething] ) {
                rarmToolIsEntity = [rarmTool isKindOfClass:NSClassFromString(@"Entity")];
            }
            
            
            
            if ( self.equipSlot == EQUIPSLOT_T_LARMTOOL && rarmToolIsEntity && ([[rarmTool name] isEqualToString:e.name]) ) {
                itemIsSet = YES;
            }
            else if (  self.equipSlot == EQUIPSLOT_T_RARMTOOL && larmToolIsEntity && ([[larmTool name] isEqualToString:e.name]) ) {
                itemIsSet = YES;
            }
            
            
            if ( itemIsSet ) {
                item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:e.name fontName:@"Courier New" fontSize:16] block: menuControlBlock];
                x = 0 + item.contentSize.width/2;
                y = y - item.contentSize.height;
                item.position = ccp(x,y);
                [item setTag: i];
                [menuItems addObject: item];
            }
        }
    }
    CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Unequip" fontName:@"Courier New" fontSize:16] block:menuControlBlock];
    x = 0 + item.contentSize.width/2;
    y = y - item.contentSize.height;
    item.position = ccp(x,y);
    [item setTag: UNEQUIP_TAG];
    [menuItems addObject: item];
    
    
    
    
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationReturn" object:self];
}
@end