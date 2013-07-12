//  EquipMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EquipMenu.h"

@implementation EquipMenu

@synthesize title;
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
        //MLOG(@"Testing: %@ tag %d", sender, sender.tag);
        // set which equip-slot this will load a submenu for
        equipSubmenu.equipSlot = sender.tag;
        [equipSubmenu.title setString: [NSString stringWithFormat:@"Equipment - %@", EquipSlotToStr(sender.tag)]];
        [equipSubmenu update];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipSubmenuNotificationShow" object:self];
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
        
        title = [[CCLabelTTF alloc] initWithString:@"Equipment" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:16];
        title.position = ccp( screenwidth/2, screenheight - title.contentSize.height );
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
         legs
         feet
         
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
        
        MenuItem *legs = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *feet = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        
        
        //MenuItem *lleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        //MenuItem *rleg = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        //MenuItem *lfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        //MenuItem *rfoot = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        
        MenuItem *larmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        MenuItem *rarmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
        
        NSString *equipmentNames[EQUIPSLOT_T_NUMSLOTS];
        for (int i=0; i<EQUIPSLOT_T_NUMSLOTS; i++) {
            Entity *e = [pc.equipment objectAtIndex:i];
            equipmentNames[i] = (e == nil) ? nil : [e isKindOfClass:NSClassFromString(@"NSNull")] ? nil : [NSString stringWithFormat:@"%@", e.name];
        }
        
        head.label.string       = [NSString stringWithFormat:@"Head: %@",           equipmentNames[EQUIPSLOT_T_HEAD]];
        neck.label.string       = [NSString stringWithFormat:@"Neck: %@",           equipmentNames[EQUIPSLOT_T_BACK]];
        chest.label.string      = [NSString stringWithFormat:@"Chest: %@",          equipmentNames[EQUIPSLOT_T_CHEST]];
        lshoulder.label.string  = [NSString stringWithFormat:@"L. Shoulder: %@",    equipmentNames[EQUIPSLOT_T_LSHOULDER]];
        rshoulder.label.string  = [NSString stringWithFormat:@"R. Shoulder: %@",    equipmentNames[EQUIPSLOT_T_RSHOULDER]];
        back.label.string       = [NSString stringWithFormat:@"Back: %@",           equipmentNames[EQUIPSLOT_T_BACK]];
        larm.label.string       = [NSString stringWithFormat:@"L. Arm: %@",         equipmentNames[EQUIPSLOT_T_LARM]];
        rarm.label.string       = [NSString stringWithFormat:@"R. Arm: %@",         equipmentNames[EQUIPSLOT_T_RARM]];
        lhand.label.string      = [NSString stringWithFormat:@"L. Hand: %@",        equipmentNames[EQUIPSLOT_T_LHAND]];
        rhand.label.string      = [NSString stringWithFormat:@"R. Hand: %@",        equipmentNames[EQUIPSLOT_T_RHAND]];
        lring.label.string      = [NSString stringWithFormat:@"L. Ring: %@",        equipmentNames[EQUIPSLOT_T_LRING]];
        rring.label.string      = [NSString stringWithFormat:@"R. Ring: %@",        equipmentNames[EQUIPSLOT_T_RRING]];
        waist.label.string      = [NSString stringWithFormat:@"Waist: %@",          equipmentNames[EQUIPSLOT_T_WAIST]];
        legs.label.string       = [NSString stringWithFormat:@"Legs: %@",           equipmentNames[EQUIPSLOT_T_LEGS]];
        //rleg.label.string       = [NSString stringWithFormat:@"R. Leg: %@",         equipmentNames[EQUIPSLOT_T_RLEG]];
        //lfoot.label.string      = [NSString stringWithFormat:@"L. Foot: %@",        equipmentNames[EQUIPSLOT_T_LFOOT]];
        feet.label.string       = [NSString stringWithFormat:@"Feet: %@",           equipmentNames[EQUIPSLOT_T_FEET]];
        larmtool.label.string   = [NSString stringWithFormat:@"L. Tool: %@",        equipmentNames[EQUIPSLOT_T_LARMTOOL]];
        rarmtool.label.string   = [NSString stringWithFormat:@"R. Tool: %@",        equipmentNames[EQUIPSLOT_T_RARMTOOL]];
        
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
        legs.tag        = EQUIPSLOT_T_LEGS;
        //lleg.tag        = EQUIPSLOT_T_LLEG;
        //rleg.tag        = EQUIPSLOT_T_RLEG;
        //lfoot.tag       = EQUIPSLOT_T_LFOOT;
        //rfoot.tag       = EQUIPSLOT_T_RFOOT;
        feet.tag        = EQUIPSLOT_T_FEET;
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
        
        y = y - legs.label.contentSize.height;
        legs.position = ccp(x,y);
        
        y = y - feet.label.contentSize.height;
        feet.position = ccp(x,y);
        
        //y = y - rleg.label.contentSize.height;
        //rleg.position = ccp(x,y);
        
        
        //y = y - rfoot.label.contentSize.height;
        //rfoot.position = ccp(x,y);
        
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
        [menuItems addObject: legs];
        //[menuItems addObject: rleg];
        //[menuItems addObject: lfoot];
        [menuItems addObject: feet];
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
    
    NSMutableArray *menuItems = [NSMutableArray array];
    
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
    
    MenuItem *legs = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *feet = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    
    MenuItem *larmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    MenuItem *rarmtool = [[MenuItem alloc] initWithLabel:[CCLabelTTF labelWithString:@"_" dimensions:CGSizeMake(screenwidth, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:18] block: menuControlBlock];
    
    
    
    NSString *equipmentNames[EQUIPSLOT_T_NUMSLOTS];
    for (int i=0; i<EQUIPSLOT_T_NUMSLOTS; i++) {
        Entity *e = [pc.equipment objectAtIndex:i];
        equipmentNames[i] = (e == nil) ? nil : [e isKindOfClass:NSClassFromString(@"NSNull")] ? nil : [NSString stringWithFormat:@"%@", e.name];
    }
    
    head.label.string       = [NSString stringWithFormat:@"Head: %@",           equipmentNames[EQUIPSLOT_T_HEAD]];
    neck.label.string       = [NSString stringWithFormat:@"Neck: %@",           equipmentNames[EQUIPSLOT_T_BACK]];
    chest.label.string      = [NSString stringWithFormat:@"Chest: %@",          equipmentNames[EQUIPSLOT_T_CHEST]];
    lshoulder.label.string  = [NSString stringWithFormat:@"L. Shoulder: %@",    equipmentNames[EQUIPSLOT_T_LSHOULDER]];
    rshoulder.label.string  = [NSString stringWithFormat:@"R. Shoulder: %@",    equipmentNames[EQUIPSLOT_T_RSHOULDER]];
    back.label.string       = [NSString stringWithFormat:@"Back: %@",           equipmentNames[EQUIPSLOT_T_BACK]];
    larm.label.string       = [NSString stringWithFormat:@"L. Arm: %@",         equipmentNames[EQUIPSLOT_T_LARM]];
    rarm.label.string       = [NSString stringWithFormat:@"R. Arm: %@",         equipmentNames[EQUIPSLOT_T_RARM]];
    lhand.label.string      = [NSString stringWithFormat:@"L. Hand: %@",        equipmentNames[EQUIPSLOT_T_LHAND]];
    rhand.label.string      = [NSString stringWithFormat:@"R. Hand: %@",        equipmentNames[EQUIPSLOT_T_RHAND]];
    lring.label.string      = [NSString stringWithFormat:@"L. Ring: %@",        equipmentNames[EQUIPSLOT_T_LRING]];
    rring.label.string      = [NSString stringWithFormat:@"R. Ring: %@",        equipmentNames[EQUIPSLOT_T_RRING]];
    waist.label.string      = [NSString stringWithFormat:@"Waist: %@",          equipmentNames[EQUIPSLOT_T_WAIST]];
    legs.label.string       = [NSString stringWithFormat:@"Legs: %@",           equipmentNames[EQUIPSLOT_T_LEGS]];
    //rleg.label.string       = [NSString stringWithFormat:@"R. Leg: %@",         equipmentNames[EQUIPSLOT_T_RLEG]];
    //lfoot.label.string      = [NSString stringWithFormat:@"L. Foot: %@",        equipmentNames[EQUIPSLOT_T_LFOOT]];
    feet.label.string       = [NSString stringWithFormat:@"Feet: %@",           equipmentNames[EQUIPSLOT_T_FEET]];
    larmtool.label.string   = [NSString stringWithFormat:@"L. Tool: %@",        equipmentNames[EQUIPSLOT_T_LARMTOOL]];
    rarmtool.label.string   = [NSString stringWithFormat:@"R. Tool: %@",        equipmentNames[EQUIPSLOT_T_RARMTOOL]];
    
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
    legs.tag        = EQUIPSLOT_T_LEGS;
    //lleg.tag        = EQUIPSLOT_T_LLEG;
    //rleg.tag        = EQUIPSLOT_T_RLEG;
    //lfoot.tag       = EQUIPSLOT_T_LFOOT;
    //rfoot.tag       = EQUIPSLOT_T_RFOOT;
    feet.tag        = EQUIPSLOT_T_FEET;
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
    
    y = y - legs.label.contentSize.height;
    legs.position = ccp(x,y);
    
    y = y - feet.label.contentSize.height;
    feet.position = ccp(x,y);
    
    //y = y - rleg.label.contentSize.height;
    //rleg.position = ccp(x,y);
    
    
    //y = y - rfoot.label.contentSize.height;
    //rfoot.position = ccp(x,y);
    
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
    //[menuItems addObject: lleg];
    [menuItems addObject: legs];
    [menuItems addObject: feet];
    //[menuItems addObject: rfoot];
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
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuNotificationReturn" object:nil];
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuNotificationUpdateReturn" object:nil];
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuNotificationShow" object:nil];
    //[[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"EquipSubmenuReturnNotification" object:nil];
}


-( void ) receiveNotification: ( NSNotification * ) notification {
    MLOG(@"Notification received: %@", notification);
    
    if ( [notification.name isEqualToString:@"EquipSubmenuNotificationShow"] ) {
        
        if ( ! equipSubmenuIsVisible ) {
            [self addChild: equipSubmenu];
            equipSubmenuIsVisible = YES;
        }
        
    }
    else if ( [notification.name isEqualToString:@"EquipSubmenuNotificationReturn"] ) {
        if ( equipSubmenuIsVisible ) {
            [self removeChild:equipSubmenu cleanup:NO];
            equipSubmenuIsVisible = NO;
        }
        //[self update];
        //[self returnPressed];
    }
    
    else if ( [notification.name isEqualToString:@"EquipSubmenuNotificationUpdateReturn"] ) {
        if ( equipSubmenuIsVisible ) {
            [self removeChild:equipSubmenu cleanup:NO];
            equipSubmenuIsVisible = NO;
            [self update];
            //[self returnPressed];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipMenuReturnNotification" object: notification.object];
        }
    }
    
}
@end