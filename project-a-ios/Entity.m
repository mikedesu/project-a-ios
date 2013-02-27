//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"
#import "GameConfig.h"

@implementation Entity

@synthesize isPC;
@synthesize positionOnMap;
@synthesize texture;

@synthesize name;
@synthesize level;
@synthesize stats;

@synthesize hp;
@synthesize maxhp;

@synthesize money;
@synthesize inventoryArray;

@synthesize pathFindingAlgorithm;

@synthesize entityType;

/*
 ====================
 init
 
 initializes and returns the object
 ====================
 */
-( id ) init {
    if ( ( self = [super init] ) ) {
        isPC = NO;
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture = nil;
        
        name = [ [ NSMutableString alloc ] init ];
        level = 1;
        entityType = ENTITY_T_VOID;
        
        stats.strength = 1;
        stats.dexterity = 1;
        stats.constitution = 1;
        stats.intelligence = 1;
        stats.wisdom = 1;
        stats.charisma = 1;
        
        hp = 1;
        maxhp = 1;
        
        money = 0;
        inventoryArray = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
    }
    return self;
}


/*
 ====================
 step
 
 steps the entity's logic one turn
 ====================
 */
-( void ) step {
    //MLOG( @"Entity step" );
}


@end
