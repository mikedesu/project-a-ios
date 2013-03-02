//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"
#import "GameConfig.h"

@implementation Entity

@synthesize isPC;
@synthesize isAlive;
@synthesize positionOnMap;
@synthesize texture;

@synthesize name;
@synthesize level;
//@synthesize stats;
@synthesize strength;
@synthesize dexterity;
@synthesize constitution;
@synthesize intelligence;
@synthesize wisdom;
@synthesize charisma;

@synthesize alignment;

@synthesize xp;

@synthesize hp;
@synthesize maxhp;

@synthesize money;
@synthesize inventoryArray;

@synthesize pathFindingAlgorithm;
@synthesize itemPickupAlgorithm;

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
        isAlive = YES;
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture = nil;
        
        name = [ [ NSMutableString alloc ] init ];
        level = 1;
        entityType = ENTITY_T_VOID;
        
        /*
         stats.strength = 8;
         stats.dexterity = 8;
         stats.constitution = 8;
         stats.intelligence = 8;
         stats.wisdom = 8;
         stats.charisma = 8;
         */
        
        strength = 8;
        dexterity = 8;
        constitution = 8;
        intelligence = 8;
        wisdom = 8;
        charisma = 8;
        
        alignment = ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL;
        
        xp = 0;
        
        hp = 1;
        maxhp = 1;
        
        money = 0;
        inventoryArray = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
        itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
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
