//  Monsters.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Monsters.h"

@implementation Monsters

+(Entity *) ghoul {
    NSInteger level = 1;
    NSInteger hd = 4;
    
    Entity *e = [[Entity alloc] initWithLevel: level withHitDie:hd ];
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    e.damageRollBase = 6;
 
    NSMutableString *name = [ NSMutableString stringWithString:@"Ghoul" ];
    [e.name setString: name ];
    
    return e;
}

@end
