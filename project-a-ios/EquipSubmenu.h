//  EquipSubmenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

typedef void (^EquipSubmenuControlBlock)(CCMenuItemLabel *);

@interface EquipSubmenu : CCLayerColor {
    CCLabelTTF *title;
    Entity *pc;
    CCMenu *menu;
    EquipSubmenuControlBlock menuControlBlock;
}

@property (atomic) CCLabelTTF *title;
@property (atomic) Entity *pc;
@property (atomic) CCMenu *menu;
@property (readwrite, copy) EquipSubmenuControlBlock menuControlBlock;

-(void) defineMenuControlBlock;
-(id) initWithPC: (Entity *) _pc;
-(void) update;
-(void) returnPressed;

@end
