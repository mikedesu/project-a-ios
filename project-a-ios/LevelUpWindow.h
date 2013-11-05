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
//  LevelUpWindow.h
//  project-a-ios
//
//  Created by Mike Bell on 6/6/13.

#import "cocos2d.h"

@interface LevelUpWindow : CCLayerColor {
    CCLabelTTF      *message, *label0, *label1, *label2, *label3, *label4, *label5;
    CCMenuItemLabel *menuLabel0, *menuLabel1, *menuLabel2, *menuLabel3, *menuLabel4, *menuLabel5;
    CCMenu          *menu;
}

@property (atomic) CCLabelTTF *message;
@property (atomic) CCLabelTTF *label0;
@property (atomic) CCLabelTTF *label1;
@property (atomic) CCLabelTTF *label2;
@property (atomic) CCLabelTTF *label3;
@property (atomic) CCLabelTTF *label4;
@property (atomic) CCLabelTTF *label5;

@property (atomic) CCMenuItemLabel *menuLabel0;
@property (atomic) CCMenuItemLabel *menuLabel1;
@property (atomic) CCMenuItemLabel *menuLabel2;
@property (atomic) CCMenuItemLabel *menuLabel3;
@property (atomic) CCMenuItemLabel *menuLabel4;
@property (atomic) CCMenuItemLabel *menuLabel5;

@property (atomic) CCMenu *menu;

@end
