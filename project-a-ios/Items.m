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
    Entity *e = [[Entity alloc] init];
    e.entityType = ENTITY_T_ITEM;
    e.isPC = NO;
    [e.name setString: @"Book of All-Knowing" ];
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
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

@end
