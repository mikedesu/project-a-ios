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
+(Entity *) shortSword: (NSInteger) bonus;
+( Entity * ) shortSword: (Wood_t) wood metal: (Metal_t) metal stone: (Stone_t) stone withBonus: (NSInteger) bonus;
+(Entity *) longSword: (NSInteger) bonus;
+(Entity *) bastardSword: (NSInteger) bonus;
// legendary-weapons
+(Entity *) Asura;
@end
