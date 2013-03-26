//  EquipSubmenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

typedef void (^EquipSubmenuControlBlock)(CCMenuItemLabel *);

@interface EquipSubmenu : CCLayerColor {
    Entity *pc;
    CCMenu *menu;
    EquipSubmenuControlBlock menuControlBlock;
}

@property (atomic) Entity *pc;
@property (atomic) CCMenu *menu;
@property (readwrite, copy) EquipSubmenuControlBlock menuControlBlock;

-(id) initWithPC: (Entity *) pc;

@end
