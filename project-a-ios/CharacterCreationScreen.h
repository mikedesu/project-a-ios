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
//  CharacterCreationScreen.h
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "cocos2d.h"

@interface CharacterCreationScreen : CCLayerColor {
    NSInteger strength,
    constitution,
    dexterity,
    intelligence,
    wisdom,
    charisma;
    
    CCLabelTTF *stat0;
    CCLabelTTF *stat1;
    CCLabelTTF *stat2;
    CCLabelTTF *stat3;
    CCLabelTTF *stat4;
    CCLabelTTF *stat5;

}

//+(CCScene *) scene;
-(void) rollStats;

@end
