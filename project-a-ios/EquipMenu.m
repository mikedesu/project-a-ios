//  EquipMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EquipMenu.h"

@implementation EquipMenu

@synthesize inventory;
@synthesize menu;
@synthesize pc;
@synthesize floor;
@synthesize gameLayer;
@synthesize menuControlBlock;
@synthesize equipSubmenu;
@synthesize equipSubmenuIsVisible;


/*
 ====================
 defineMenuControlBlock
 
 define the menu control block
 ====================
 */
-(void) defineMenuControlBlock {
    __block typeof(self) weakSelf = self;
    weakSelf.menuControlBlock = ^(CCMenuItemLabel *sender) {
        MLOG(@"Testing: %@ tag %d", sender, sender.tag);
        
        [equipSubmenu.title setString:
         [NSString stringWithFormat:@"%@", sender]
         ];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotification" object:self];
        
        //[self addChild: equipSubmenu];
        
        /*
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
         */
    };
}



/*
 ====================
 initWithPC: _pc withFloor: _floor withGameLayer: _gameLayer
 ====================
 */
-(id) initWithPC:(Entity *)_pc withFloor:(DungeonFloor *)_floor withGameLayer:(GameLayer *)_gameLayer {
    if ((self=[super initWithColor:black width:screenwidth height:screenheight])) {
        
        pc = _pc;
        inventory = _pc.inventoryArray;
        floor = _floor;
        gameLayer = _gameLayer;
        
        [self defineMenuControlBlock];
        
        
        CCLabelTTF *title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
        
        title.position = ccp( screenwidth/2, screenheight - title.contentSize.height );
        //title.position = ccp( screenwidth/2, screenheight/2 );
        
        [self addChild:title];
        
        
        
        NSMutableArray *menuItems = [NSMutableArray array];
        
        
        /*
         head
         neck
         chest
         l. shoulder
         r. shoulder
         back
         l. arm
         r. arm
         l. hand
         r. hand
         l. ring
         r. ring
         waist
         l. leg
         r. leg
         l. foot
         r. foot
         
         l. arm tool  <-- could be weapon, shield, torch, wand, book, bow, fishing rod, etc
         r. arm tool
         */
        
#ifndef MenuItem
#define MenuItem CCMenuItemLabel
        
        MenuItem *head = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *neck = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *chest = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *lshoulder = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rshoulder = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *back = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *larm = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rarm = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *lhand = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rhand = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *lring = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rring = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *waist = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *lleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *lfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *larmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rarmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        
        head.label.string       = [NSString stringWithFormat:@"Head: %@", nil];
        neck.label.string       = [NSString stringWithFormat:@"Neck: %@", nil];
        chest.label.string      = [NSString stringWithFormat:@"Chest: %@", nil];
        lshoulder.label.string  = [NSString stringWithFormat:@"L. Shoulder: %@", nil];
        rshoulder.label.string  = [NSString stringWithFormat:@"R. Shoulder: %@", nil];
        back.label.string       = [NSString stringWithFormat:@"Back: %@", nil];
        larm.label.string       = [NSString stringWithFormat:@"L. Arm: %@", nil];
        rarm.label.string       = [NSString stringWithFormat:@"R. Arm: %@", nil];
        lhand.label.string      = [NSString stringWithFormat:@"L. Hand: %@", nil];
        rhand.label.string      = [NSString stringWithFormat:@"R. Hand: %@", nil];
        lring.label.string      = [NSString stringWithFormat:@"L. Ring: %@", nil];
        rring.label.string      = [NSString stringWithFormat:@"R. Ring: %@", nil];
        waist.label.string      = [NSString stringWithFormat:@"Waist: %@", nil];
        lleg.label.string       = [NSString stringWithFormat:@"L. Leg: %@", nil];
        rleg.label.string       = [NSString stringWithFormat:@"R. Leg: %@", nil];
        lfoot.label.string      = [NSString stringWithFormat:@"L. Foot: %@", nil];
        rfoot.label.string      = [NSString stringWithFormat:@"R. Foot: %@", nil];
        larmtool.label.string   = [NSString stringWithFormat:@"L. Tool: %@", nil];
        rarmtool.label.string   = [NSString stringWithFormat:@"R. Tool: %@", nil];
        
        
        head.tag        = EQUIPSLOT_T_HEAD;
        neck.tag        = EQUIPSLOT_T_NECK;
        chest.tag       = EQUIPSLOT_T_CHEST;
        lshoulder.tag   = EQUIPSLOT_T_LSHOULDER;
        rshoulder.tag   = EQUIPSLOT_T_RSHOULDER;
        back.tag        = EQUIPSLOT_T_BACK;
        larm.tag        = EQUIPSLOT_T_LARM;
        rarm.tag        = EQUIPSLOT_T_RARM;
        lhand.tag       = EQUIPSLOT_T_LHAND;
        rhand.tag       = EQUIPSLOT_T_RHAND;
        lring.tag       = EQUIPSLOT_T_LRING;
        rring.tag       = EQUIPSLOT_T_RRING;
        waist.tag       = EQUIPSLOT_T_WAIST;
        lleg.tag        = EQUIPSLOT_T_LLEG;
        rleg.tag        = EQUIPSLOT_T_RLEG;
        lfoot.tag       = EQUIPSLOT_T_LFOOT;
        rfoot.tag       = EQUIPSLOT_T_RFOOT;
        larmtool.tag    = EQUIPSLOT_T_LARMTOOL;
        rarmtool.tag    = EQUIPSLOT_T_RARMTOOL;
        
        
        CGFloat
        x = title.contentSize.width / 2,
        y = screenheight - title.contentSize.height;
        
        y = y - head.label.contentSize.height;
        head.position = ccp(x,y);
        
        y = y - neck.label.contentSize.height;
        neck.position = ccp(x,y);
        
        y = y - chest.label.contentSize.height;
        chest.position = ccp(x,y);
        
        y = y - lshoulder.label.contentSize.height;
        lshoulder.position = ccp(x,y);
        
        y = y - rshoulder.label.contentSize.height;
        rshoulder.position = ccp(x,y);
        
        y = y - back.label.contentSize.height;
        back.position = ccp(x,y);
        
        y = y - larm.label.contentSize.height;
        larm.position = ccp(x,y);
        
        y = y - rarm.label.contentSize.height;
        rarm.position = ccp(x,y);
        
        y = y - lhand.label.contentSize.height;
        lhand.position = ccp(x,y);
        
        y = y - rhand.label.contentSize.height;
        rhand.position = ccp(x,y);
        
        y = y - lring.label.contentSize.height;
        lring.position = ccp(x,y);
        
        y = y - rring.label.contentSize.height;
        rring.position = ccp(x,y);
        
        y = y - waist.label.contentSize.height;
        waist.position = ccp(x,y);
        
        y = y - lleg.label.contentSize.height;
        lleg.position = ccp(x,y);
        
        y = y - rleg.label.contentSize.height;
        rleg.position = ccp(x,y);
        
        y = y - lfoot.label.contentSize.height;
        lfoot.position = ccp(x,y);
        
        y = y - rfoot.label.contentSize.height;
        rfoot.position = ccp(x,y);
        
        y = y - larmtool.label.contentSize.height;
        larmtool.position = ccp(x,y);
        
        y = y - rarmtool.label.contentSize.height;
        rarmtool.position = ccp(x,y);
        
        
        
        
        
#undef MenuItem
#endif
        
        //return button
        CCMenuItemLabel *returnButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        returnButton.position = ccp( returnButton.contentSize.width/2, returnButton.contentSize.height/2 );
        
        
        [menuItems addObject: head];
        [menuItems addObject: neck];
        [menuItems addObject: chest];
        [menuItems addObject: lshoulder];
        [menuItems addObject: rshoulder];
        [menuItems addObject: back];
        [menuItems addObject: larm];
        [menuItems addObject: rarm];
        [menuItems addObject: lhand];
        [menuItems addObject: rhand];
        [menuItems addObject: lring];
        [menuItems addObject: rring];
        [menuItems addObject: waist];
        [menuItems addObject: lleg];
        [menuItems addObject: rleg];
        [menuItems addObject: lfoot];
        [menuItems addObject: rfoot];
        [menuItems addObject: larmtool];
        [menuItems addObject: rarmtool];
        
        
        [menuItems addObject:returnButton];
        
        
        menu = [CCMenu menuWithArray:menuItems];
        menu.position = ccp(0,0);
        [self addChild:menu];
        
        
        equipSubmenu = [[EquipSubmenu alloc] initWithPC: pc];
        
        equipSubmenuIsVisible = NO;
        
        
        [self registerNotifications];

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
 
    MLOG(@"Updating");
    [menu removeAllChildrenWithCleanup:YES];
 
    
    CCLabelTTF *title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
    
    
    NSMutableArray *menuItems = [NSMutableArray array];
    
    
    /*
     head
     neck
     chest
     l. shoulder
     r. shoulder
     back
     l. arm
     r. arm
     l. hand
     r. hand
     l. ring
     r. ring
     waist
     l. leg
     r. leg
     l. foot
     r. foot
     
     l. arm tool  <-- could be weapon, shield, torch, wand, book, bow, fishing rod, etc
     r. arm tool
     */
    
#ifndef MenuItem
#define MenuItem CCMenuItemLabel
    
    MenuItem *head = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *neck = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *chest = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *lshoulder = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rshoulder = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *back = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *larm = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rarm = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *lhand = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rhand = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *lring = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rring = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *waist = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *lleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *lfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *larmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rarmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    
    head.label.string       = [NSString stringWithFormat:@"Head: %@", nil];
    neck.label.string       = [NSString stringWithFormat:@"Neck: %@", nil];
    chest.label.string      = [NSString stringWithFormat:@"Chest: %@", nil];
    lshoulder.label.string  = [NSString stringWithFormat:@"L. Shoulder: %@", nil];
    rshoulder.label.string  = [NSString stringWithFormat:@"R. Shoulder: %@", nil];
    back.label.string       = [NSString stringWithFormat:@"Back: %@", nil];
    larm.label.string       = [NSString stringWithFormat:@"L. Arm: %@", nil];
    rarm.label.string       = [NSString stringWithFormat:@"R. Arm: %@", nil];
    lhand.label.string      = [NSString stringWithFormat:@"L. Hand: %@", nil];
    rhand.label.string      = [NSString stringWithFormat:@"R. Hand: %@", nil];
    lring.label.string      = [NSString stringWithFormat:@"L. Ring: %@", nil];
    rring.label.string      = [NSString stringWithFormat:@"R. Ring: %@", nil];
    waist.label.string      = [NSString stringWithFormat:@"Waist: %@", nil];
    lleg.label.string       = [NSString stringWithFormat:@"L. Leg: %@", nil];
    rleg.label.string       = [NSString stringWithFormat:@"R. Leg: %@", nil];
    lfoot.label.string      = [NSString stringWithFormat:@"L. Foot: %@", nil];
    rfoot.label.string      = [NSString stringWithFormat:@"R. Foot: %@", nil];
    larmtool.label.string   = [NSString stringWithFormat:@"L. Tool: %@", nil];
    rarmtool.label.string   = [NSString stringWithFormat:@"R. Tool: %@", nil];
    
    
    head.tag        = EQUIPSLOT_T_HEAD;
    neck.tag        = EQUIPSLOT_T_NECK;
    chest.tag       = EQUIPSLOT_T_CHEST;
    lshoulder.tag   = EQUIPSLOT_T_LSHOULDER;
    rshoulder.tag   = EQUIPSLOT_T_RSHOULDER;
    back.tag        = EQUIPSLOT_T_BACK;
    larm.tag        = EQUIPSLOT_T_LARM;
    rarm.tag        = EQUIPSLOT_T_RARM;
    lhand.tag       = EQUIPSLOT_T_LHAND;
    rhand.tag       = EQUIPSLOT_T_RHAND;
    lring.tag       = EQUIPSLOT_T_LRING;
    rring.tag       = EQUIPSLOT_T_RRING;
    waist.tag       = EQUIPSLOT_T_WAIST;
    lleg.tag        = EQUIPSLOT_T_LLEG;
    rleg.tag        = EQUIPSLOT_T_RLEG;
    lfoot.tag       = EQUIPSLOT_T_LFOOT;
    rfoot.tag       = EQUIPSLOT_T_RFOOT;
    larmtool.tag    = EQUIPSLOT_T_LARMTOOL;
    rarmtool.tag    = EQUIPSLOT_T_RARMTOOL;
    
    
    CGFloat
    x = title.contentSize.width / 2,
    y = screenheight - title.contentSize.height;
    
    y = y - head.label.contentSize.height;
    head.position = ccp(x,y);
    
    y = y - neck.label.contentSize.height;
    neck.position = ccp(x,y);
    
    y = y - chest.label.contentSize.height;
    chest.position = ccp(x,y);
    
    y = y - lshoulder.label.contentSize.height;
    lshoulder.position = ccp(x,y);
    
    y = y - rshoulder.label.contentSize.height;
    rshoulder.position = ccp(x,y);
    
    y = y - back.label.contentSize.height;
    back.position = ccp(x,y);
    
    y = y - larm.label.contentSize.height;
    larm.position = ccp(x,y);
    
    y = y - rarm.label.contentSize.height;
    rarm.position = ccp(x,y);
    
    y = y - lhand.label.contentSize.height;
    lhand.position = ccp(x,y);
    
    y = y - rhand.label.contentSize.height;
    rhand.position = ccp(x,y);
    
    y = y - lring.label.contentSize.height;
    lring.position = ccp(x,y);
    
    y = y - rring.label.contentSize.height;
    rring.position = ccp(x,y);
    
    y = y - waist.label.contentSize.height;
    waist.position = ccp(x,y);
    
    y = y - lleg.label.contentSize.height;
    lleg.position = ccp(x,y);
    
    y = y - rleg.label.contentSize.height;
    rleg.position = ccp(x,y);
    
    y = y - lfoot.label.contentSize.height;
    lfoot.position = ccp(x,y);
    
    y = y - rfoot.label.contentSize.height;
    rfoot.position = ccp(x,y);
    
    y = y - larmtool.label.contentSize.height;
    larmtool.position = ccp(x,y);
    
    y = y - rarmtool.label.contentSize.height;
    rarmtool.position = ccp(x,y);
    
    
    
    
    
#undef MenuItem
#endif
    
    //return button
    CCMenuItemLabel *returnButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
    returnButton.position = ccp( returnButton.contentSize.width/2, returnButton.contentSize.height/2 );
    
    
    [menuItems addObject: head];
    [menuItems addObject: neck];
    [menuItems addObject: chest];
    [menuItems addObject: lshoulder];
    [menuItems addObject: rshoulder];
    [menuItems addObject: back];
    [menuItems addObject: larm];
    [menuItems addObject: rarm];
    [menuItems addObject: lhand];
    [menuItems addObject: rhand];
    [menuItems addObject: lring];
    [menuItems addObject: rring];
    [menuItems addObject: waist];
    [menuItems addObject: lleg];
    [menuItems addObject: rleg];
    [menuItems addObject: lfoot];
    [menuItems addObject: rfoot];
    [menuItems addObject: larmtool];
    [menuItems addObject: rarmtool];
    
    
    [menuItems addObject:returnButton];
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipMenuReturnNotification" object:self];
}



-( void ) registerNotifications {
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuNotification" object:nil];
    //[[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuReturnNotification" object:nil];
}



-( void ) receiveNotification: ( NSNotification * ) notification {
    MLOG(@"Notification received: %@", notification);
    
    if ( [notification.name isEqualToString:@"EquipSubmenuNotification"] ) {
        
        if ( ! equipSubmenuIsVisible ) {
            [self addChild: equipSubmenu];
            equipSubmenuIsVisible = YES;
        } else {
            [self removeChild:equipSubmenu cleanup:NO];
            equipSubmenuIsVisible = NO;
        }
        
    }
    
}


@end
