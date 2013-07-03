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

+( Entity * ) shortSword: (Wood_t) wood metal: (Metal_t) metal withBonus: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    
    // Wood-type weapon
    if ( wood > WOOD_T_NONE ) {
        
        bonus == 0 ?
        [e.name setString: [NSString stringWithFormat:@"%@ Short Sword", [GameRenderer getWoodName:wood]]]
        :
        [e.name setString: [NSString stringWithFormat:@"%@ Short Sword +%d", [GameRenderer getWoodName:wood], bonus ]];
        
    }
    
    // Metal-type weapon
    else if ( metal > METAL_T_NONE ) {
    
        bonus == 0 ?
        [e.name setString: [NSString stringWithFormat:@"%@ Short Sword", [GameRenderer getMetalName:metal]]]
        :
        [e.name setString: [NSString stringWithFormat:@"%@ Short Sword +%d", [GameRenderer getMetalName:metal], bonus ]];
        
    }
    
    e.entityType = ENTITY_T_ITEM;
    e.itemType = E_ITEM_T_WEAPON;
    e.isPC = NO;
    
    int metalBonus = metal == METAL_T_NONE ? 0 : metal;
    int woodBonus  = wood  == WOOD_T_NONE  ? 0 : wood - 1;
    
    e.damageRollBase  =  6;
    e.damageBonus     =  metalBonus + woodBonus + bonus;
    e.weight          =  2;
    e.durability      = -1;
    e.totalDurability = -1;
    
    e.wood            = wood;
    e.metal           = metal;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}


+( Entity * ) longSword: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    
    if ( bonus == 0 )
        [e.name setString: @"Long Sword" ];
    else
        [e.name setString: [NSString stringWithFormat:@"Long Sword +%d", bonus ]];
    
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
