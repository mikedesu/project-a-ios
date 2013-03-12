//  InventoryMenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"

@interface InventoryMenu : CCLayerColor {
    NSMutableArray *inventory;
    CCMenu *menu;
}
@property (atomic) NSMutableArray *inventory;
@property (atomic) CCMenu *menu;
//-(id) init;
-(id) initWithInventory: (NSMutableArray *) pcInventory ;
-(void) update;
@end