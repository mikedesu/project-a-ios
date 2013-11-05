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
//  MasterLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "cocos2d.h"

@class TitleScreen;
@class CharacterCreationScreen;
@class GameLayer;
@class AppController;

@interface MasterLayer : CCLayer {
    TitleScreen *titleScreen;
    CharacterCreationScreen *characterCreationScreen;
    GameLayer *gameLayer;
    
    NSInteger strength;
    NSInteger dexterity;
    NSInteger constitution;
    NSInteger intelligence;
    NSInteger wisdom;
    NSInteger charisma;
}

@property (nonatomic) TitleScreen *titleScreen;
@property (nonatomic) CharacterCreationScreen *characterCreationScreen;
@property (nonatomic) GameLayer *gameLayer;

+(AppController *) sharedController;

+(CCScene *) scene;
-(void) rollStats;
-(void) handleNotification: (NSNotification *) notification;

@end