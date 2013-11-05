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
//  InventoryMenu.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"

typedef void (^InventoryMenuControlBlock)(CCMenuItemLabel *);

@class GameLayer;

@interface InventoryMenu : CCLayerColor {
    NSMutableArray *inventory;
    CCMenu *menu;
    Entity *pc;
    DungeonFloor *floor;
    GameLayer *gameLayer;
    
    InventoryMenuControlBlock menuControlBlock;
}

@property (atomic) NSMutableArray *inventory;
@property (atomic) CCMenu *menu;
@property (atomic) Entity *pc;
@property (atomic) DungeonFloor *floor;
@property (atomic) GameLayer *gameLayer;

@property (readwrite, copy) InventoryMenuControlBlock menuControlBlock;

-(void) defineMenuControlBlock;
-(id)   initWithPC: (Entity *) _pc withFloor: (DungeonFloor *) _floor withGameLayer: (GameLayer *) _gameLayer;
-(void) update;
@end

