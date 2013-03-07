//
//  Weapons.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Weapons.h"


@implementation Weapons

#pragma mark - Blades

+( Entity * ) shortSword: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Short Sword" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_WEAPON;
    e.isPC = NO;
    
    e.damageRollBase  =  6;
    e.damageBonus     =  bonus;
    e.weight          =  2;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}


+( Entity * ) longSword: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Long Sword" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_WEAPON;
    e.isPC = NO;
    
    e.damageRollBase  =  8;
    e.damageBonus     =  bonus;
    e.weight          =  3;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}


+( Entity * ) bastardSword: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Bastard Sword" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_WEAPON;
    e.isPC = NO;
    
    e.damageRollBase  = 12;
    e.damageBonus     =  bonus;
    e.weight          =  5;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}


#pragma mark - Legendary Blades

+( Entity * ) Asura {
    Entity *e = [[Entity alloc] init];
    [e.name setString: @"Asura" ];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_WEAPON;
    e.isPC = NO;
    
    e.damageRollBase  = 20;
    e.damageBonus     = 20;
    e.weight          =  1;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}






@end
