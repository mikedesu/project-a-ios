//
//  Armor.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Armor.h"


@implementation Armor

+(Entity *) smallShield: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    if ( bonus == 0 )
        [e.name setString: @"Small Shield" ];
    else
        [e.name setString: [NSString stringWithFormat:@"Small Shield +%d", bonus ]];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType   = E_ITEM_T_ARMOR;
    e.armorType  = ARMOR_T_SHIELD;
    
    e.isPC = NO;
    
    e.ac              =  1 + bonus;
    e.weight          =  2;
    e.durability      = -1;
    e.totalDurability = -1;
    return e;
}

+( Entity * ) leatherArmor: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    if ( bonus == 0 )
        [e.name setString: @"Leather Armor" ];
    else
        [e.name setString: [NSString stringWithFormat:@"Leather Armor +%d", bonus ]];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType   = E_ITEM_T_ARMOR;
    e.armorType  = ARMOR_T_VEST;
    
    e.isPC = NO;
    
    e.ac              =  2 + bonus;
    e.weight          =  5;
    e.durability      = -1;
    e.totalDurability = -1;
    return e;
}

+(Entity *) blindfold {
    Entity *e = [[Entity alloc] init];
    e.entityType        = ENTITY_T_ITEM;
    e.itemType          = E_ITEM_T_ARMOR;
    e.armorType         = ARMOR_T_HELMET;
    e.isPC              = NO;
    e.weight            = 1;
    e.durability        = 5;
    e.totalDurability   = 5;
    [e.name setString: [NSString stringWithFormat:@"Blindfold"]];
    return e;
}


+(Entity *) bootsOfAntiacid {
    Entity *e = [[Entity alloc] init];
    e.entityType        = ENTITY_T_ITEM;
    e.itemType          = E_ITEM_T_ARMOR;
    e.armorType         = ARMOR_T_SHOE;
    e.isPC              = NO;
    e.weight            = 1;
    e.durability        = 5;
    e.totalDurability   = 5;
    [e.name setString: [NSString stringWithFormat:@"Boots of Anti-acid"]];
    return e;
}






/*
+(Entity *) plateArmor: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Leather Armor" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_ARMOR;
    e.isPC = NO;
    
    e.ac              = 10 + bonus;
    e.weight          = 30;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}
*/

/*
+(Entity *) GodArmor: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Leather Armor" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_ARMOR;
    e.isPC = NO;
    
    e.ac              = 20 + bonus;
    e.weight          =  1;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}
*/

@end
