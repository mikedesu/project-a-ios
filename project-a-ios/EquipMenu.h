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
-(void) unregisterNotifications;
-(void) receiveNotification: (NSNotification *) notification;
@end