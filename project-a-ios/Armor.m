//
//  Armor.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Armor.h"


@implementation Armor


+( Entity * ) leatherArmor: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    if ( bonus == 0 )
        [e.name setString: @"Leather Armor" ];
    else
        [e.name setString: [NSString stringWithFormat:@"Leather Armor +%d", bonus ]];
    
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_ARMOR;
    e.isPC = NO;
    
    e.ac              =  2 + bonus;
    e.weight          =  5;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}



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


@end
