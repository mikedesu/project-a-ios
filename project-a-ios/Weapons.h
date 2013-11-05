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
//  Weapons.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"



typedef enum {
    WEAPON_T_SWORD,
    WEAPON_T_SPEAR,
    WEAPON_T_BLUDGEON,
    WEAPON_T_AXE,
    WEAPON_T_STAFF,
    WEAPON_T_WAND,
    WEAPON_T_BOW,
    WEAPON_T_CROSSBOW,
    WEAPON_T_GUN,
    
    WEAPON_T_NUMTYPES
} Weapon_t;




@interface Weapons : NSObject {}
// bladed-weapons
//+(Entity *) shortSword: (NSInteger) bonus;
+( Entity * ) shortSword: (Wood_t) wood metal: (Metal_t) metal stone: (Stone_t) stone withBonus: (NSInteger) bonus;
+(Entity *) longSword: (NSInteger) bonus;
+(Entity *) bastardSword: (NSInteger) bonus;
// legendary-weapons
+(Entity *) Asura;
@end
