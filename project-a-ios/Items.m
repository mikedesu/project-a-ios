//
//  Items.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Items.h"


@implementation Items


+( Entity * ) randomItem {
    Entity *e = nil;
    
    NSUInteger roll = [Dice roll:2];
    if (roll==1)
        e = [Items potionOfLightHealing:1];
    else
        e = [Items chicken];
    
    NSAssert( e!=nil, @"Random Item: roll failed to set entity" );
    
    return e;
}



+( Entity * ) bookOfAllKnowing {
    Entity *e = [[Entity alloc] init];
    e.entityType = ENTITY_T_ITEM;
    e.isPC = NO;
    [e.name setString: @"Book of All-Knowing" ];
    e.itemType = E_ITEM_T_BOOK;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}


+( Entity * ) potionOfLightHealing: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_POTION;
    e.isPC = NO;
    [e.name setString:@"Potion of Light Healing"];
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    // now to define the effects of the potion when used
    
    e.healingRollBase   = 6;
    e.healingBonus      = bonus;
    e.weight            = 0.1;
    e.durability        = 1;
    e.totalDurability   = 1;
    
    return e;
}




+(Entity *) chicken {
    Entity *e = [[Entity alloc] init];
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_FOOD;
    [e.name setString:@"Chicken"];
    
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    // now to define the effects of the food when used
    e.foodBase          = 6;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    return e;
}

















@end
