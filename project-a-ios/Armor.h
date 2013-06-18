//
//  Armor.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"

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

//+(Entity *) plateArmor: (NSInteger) bonus;

//+(Entity *) GodArmor: (NSInteger) bonus;
@end
