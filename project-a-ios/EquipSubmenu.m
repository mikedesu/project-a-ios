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

-(void) defineMenuControlBlock {
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        Entity *item = [pc.inventoryArray objectAtIndex: sender.tag];
        MLOG(@"Item pressed: %@", item.name);
        
        // do equipping
        // ...
        [self.pc equipItem:item forEquipSlot: equipSlot];
        
        // return to equipMenu
        [self returnPressed];
        
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
                y = y - item.contentSize.height/2;
                
                item.position = ccp(x,y);
                [item setTag: i];
                
                [menuItems addObject: item];
            }
            
            
        }
        
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
            ((self.equipSlot == EQUIPSLOT_T_LARMTOOL || self.equipSlot == EQUIPSLOT_T_RARMTOOL) && e.itemType == E_ITEM_T_WEAPON) ||
            (self.equipSlot == EQUIPSLOT_T_CHEST                                               && e.itemType == E_ITEM_T_ARMOR)   ||
            ((self.equipSlot == EQUIPSLOT_T_LRING || self.equipSlot == EQUIPSLOT_T_RRING) && e.itemType == E_ITEM_T_RING);
            
            for (int j=0; j < pc.equipment.count; j++ ) {
                Entity *equipment = [pc.equipment objectAtIndex:j];
                if ( [equipment isKindOfClass:NSClassFromString(@"Entity")] ) {
                    BOOL isSameName = [e.name isEqualToString: equipment.name];
                    itemIsSet = itemIsSet && !(isSameName);
                }
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