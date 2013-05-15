//  Items.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Items.h"

@implementation Items

+( Entity * ) randomItem {
    Entity *e = nil;
    
    NSUInteger numItems = 7;
    NSUInteger roll = [Dice roll:numItems];
    if (roll==1)
        e = [Items potionOfLightHealing:1];
    else if (roll==2)
        e = [Items greenBlob];
    else if (roll==3)
        e = [Items woodenFishingRod];
    else if (roll==4)
        e = [Items catfish];
    else if (roll==5)
        e = [Items simpleDoor];
    else if (roll==6)
        e = [Items simpleKey];
    else
        e = [Items basicBoulder];
    
    //e = [Items simpleKey];
    
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
    
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_POTION;
    e.potionType    = POTION_T_HEALING;
    e.isPC          = NO;
    [e.name setString:@"Potion of Light Healing"];
    
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    // now to define the effects of the potion when used
    
    e.healingRollBase   = 6;
    e.healingBonus      = bonus;
    e.weight            = 0.1;
    e.durability        = 1;
    e.totalDurability   = 1;
    
    return e;
}




+(Entity *) greenBlob {
    Entity *e = [[Entity alloc] init];
    
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FOOD;
    [e.name setString:@"Green Blob"];
    
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    // now to define the effects of the food when used
    e.foodBase          = 10;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    return e;
}




+(Entity *) catfish {
    Entity *e = [[Entity alloc] init];
    
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FISH;
    [e.name setString:@"Catfish"];
    
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    // now to define the effects of the food when used
    e.foodBase          = 25;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    return e;

}


+(Entity *) woodenFishingRod {
    Entity *e = [[Entity alloc] init];
    
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FISHING_ROD;
    [e.name setString:@"Wooden Fishing Rod"];
    
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    return e;

}


+(Entity *) basicBoulder {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_BASICBOULDER;
    [e.name setString:@"Basic Boulder"];
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) simpleDoor {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_DOOR_SIMPLE;
    [e.name setString:@"Door, Simple"];
    e.doorOpen              = NO;
    e.doorLocked            = YES;
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) simpleKey {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_KEY_SIMPLE;
    [e.name setString:@"Key, Simple"];
    e.isPC                  = NO;
    e.pathFindingAlgorithm  = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm   = ENTITYITEMPICKUPALGORITHM_T_NONE;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}







@end