//  EquipMenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

typedef void (^EquipMenuControlBlock)(CCMenuItemLabel *);

@class EquipSubmenu;
@class GameLayer;

@interface EquipMenu : CCLayerColor {
    CCLabelTTF *title;
    
    NSMutableArray *inventory;
    CCMenu *menu;
    Entity *pc;
    DungeonFloor *floor;
    GameLayer *gameLayer;
    EquipMenuControlBlock menuControlBlock;
    
    EquipSubmenu *equipSubmenu;
    BOOL equipSubmenuIsVisible;
}

@property (atomic) CCLabelTTF *title;
@property (atomic) NSMutableArray *inventory;
@property (atomic) CCMenu *menu;
@property (atomic) Entity *pc;
@property (atomic) DungeonFloor *floor;
@property (atomic) GameLayer *gameLayer;

@property (atomic) EquipSubmenu *equipSubmenu;
@property (atomic) BOOL equipSubmenuIsVisible;

@property (readwrite, copy) EquipMenuControlBlock menuControlBlock;

-(void) defineMenuControlBlock;
-(id)   initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer;
-(void) update;

-(void) registerNotifications;
-(void) receiveNotification: (NSNotification *) notification;
@end
