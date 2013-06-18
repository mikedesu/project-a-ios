//  DropMenu.h
//  project-a-ios
//
//  Created by Mike Bell on 6/18/13.

#import "cocos2d.h"
#import "GameConfig.h"

typedef void (^DropMenuControlBlock)(CCMenuItemLabel *);

@class GameLayer;

@interface DropMenu : CCLayerColor {
    NSMutableArray *inventory;
    CCMenu *menu;
    Entity *pc;
    DungeonFloor *floor;
    GameLayer *gameLayer;
    
    DropMenuControlBlock menuControlBlock;
}

@property (atomic) NSMutableArray *inventory;
@property (atomic) CCMenu *menu;
@property (atomic) Entity *pc;
@property (atomic) DungeonFloor *floor;
@property (atomic) GameLayer *gameLayer;

@property (readwrite, copy) DropMenuControlBlock menuControlBlock;

-(void) defineMenuControlBlock;
-(id)   initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer;
-(void) update;
@end
