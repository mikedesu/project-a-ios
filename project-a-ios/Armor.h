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
//
//  Armor.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"
#import "Cloth_t.h"

/*
 // moved to EntitySubtypeDefines.h
typedef enum {
    ARMOR_T_NONE,
    ARMOR_T_HELMET,
    ARMOR_T_NECKLACE,
    ARMOR_T_SHOULDERGUARD,
    ARMOR_T_CAPE,
    ARMOR_T_ARMGUARD,
    ARMOR_T_GLOVE,
    ARMOR_T_RING,
    ARMOR_T_BELT,
    ARMOR_T_LEGGUARD,
    ARMOR_T_SHOE,
    ARMOR_T_SHIELD,
    ARMOR_T_MAIL,
    ARMOR_T_VEST,
    ARMOR_T_ROBE,
    
    ARMOR_T_NUMTYPES
} Armor_t;
*/

@class Entity;
@interface Armor : NSObject {}
+(Entity *) smallShield: (NSInteger) bonus;

+(Entity *) leatherArmor: (NSInteger) bonus;
+(Entity *) robe: (Cloth_t) cloth bonus: (NSInteger) bonus;

+(Entity *) blindfold;
+(Entity *) bootsOfAntiacid;

//+(Entity *) plateArmor: (NSInteger) bonus;

//+(Entity *) GodArmor: (NSInteger) bonus;
@end
