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
@synthesize totalxp;
@synthesize nextLevelXP;

@synthesize hp;
@synthesize maxhp;
@synthesize ac;

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
        
        strength = rollDice(6, 3);
        dexterity = rollDice(6, 3);
        constitution = rollDice(6, 3);
        intelligence = rollDice(6, 3);
        wisdom = rollDice(6, 3);
        charisma = rollDice(6, 3);
        
        alignment = ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL;
        
        xp = 0;
        totalxp = 0;
        
#define DEFAULT_LVL1_NEXT_LEVEL_XP      10
        nextLevelXP = DEFAULT_LVL1_NEXT_LEVEL_XP;
        
        maxhp = rollDice(12, 1);
        hp = maxhp;
        
        ac = 10; // the higher the better
        
        money = 0;
        inventoryArray = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
        itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    }
    return self;
}






-(Entity *) initWithLevel: (NSInteger) level {
    Entity *e = [[ Entity alloc ] init];
    
    e.level = level;
    e.entityType = ENTITY_T_NPC;
    
    e.strength = rollDice(6, 3);
    e.dexterity = rollDice(6, 3);
    e.constitution = rollDice(6, 3);
    e.intelligence = rollDice(6, 3);
    e.wisdom = rollDice(6, 3);
    e.charisma = rollDice(6, 3);
    
    for ( int i = 0; i < level; i++ ) {
        [ e handleLevelUp ];
    }
    
    return e;
}







/*
 ====================
 attackBonus
 
 returns the entity's total attack bonus
 ====================
 */
-(NSInteger) attackBonus {
    
    /*
     in old dnd it was like
     
     1
     2-3   : -4
     4-5   : -3
     6-7   : -2
     8-9   : -1
     10-11 : 0
     12-13 : 1
     14-15 : 2
     16-17 : 3
     18-19 : 4
     20+   : 5
     */
    
    NSInteger strengthBonus =
    strength <= 3 ? -4 :
    strength <= 5 ? -3 :
    strength <= 7 ? -2 :
    strength <= 9 ? -1 :
    strength <= 11 ? 0 :
    strength <= 13 ? 1 :
    strength <= 15 ? 2 :
    strength <= 17 ? 3 : 4;
    
    
    // [ GameRenderer getModifierForStat: self.strength ] ;
    
    // any items / equipped gear would be counted here
    
    return strengthBonus;
}


/*
 ====================
 attackRoll
 
 returns the total attack roll for this entity
 ====================
 */
-( NSInteger ) attackRoll {
    return rollDiceOnceWithModifier(20, self.attackBonus );
}


/*
 ====================
 damageRoll
 
 returns the total damage roll for this entity
 ====================
 */
-( NSInteger ) damageRoll {
    return rollDiceOnce(6) + self.attackBonus;
}


/*
 ====================
 ac
 
 returns the total ac 
 ====================
 */
-( NSInteger ) totalac {
    NSInteger dexterityBonus =
    dexterity <= 3 ? -4 :
    dexterity <= 5 ? -3 :
    dexterity <= 7 ? -2 :
    dexterity <= 9 ? -1 :
    dexterity <= 11 ? 0 :
    dexterity <= 13 ? 1 :
    dexterity <= 15 ? 2 :
    dexterity <= 17 ? 3 : 4;
    
    return ac + dexterityBonus;
}





/*
 ====================
 gainXP: exp
 
 adds exp to your xp and handles level ups
 ====================
 */
-( void ) gainXP: (NSInteger) exp {
    xp += exp;
    totalxp += exp;
    
    if ( xp >= nextLevelXP ) {
        [ self handleLevelUp ];
    }
}


/*
 ====================
 handleLevelUp
 
 manages level up events
 ====================
 */
-( void ) handleLevelUp {
    level++;
    xp = 0;
    nextLevelXP *= 2;
    

    // lets up our hp
    NSInteger conMod =
    constitution <= 3 ? -4 :
    constitution <= 5 ? -3 :
    constitution <= 7 ? -2 :
    constitution <= 9 ? -1 :
    constitution <= 11 ? 0 :
    constitution <= 13 ? 1 :
    constitution <= 15 ? 2 :
    constitution <= 17 ? 3 : 4;
    
    maxhp = maxhp + rollDiceOnce(12) + conMod;
    hp = maxhp;
    
    // lets up our strength/ac
    strength++;
    ac++;
}


/*
 ====================
 handleLevelDown
 
 handles the level down event (unfortunate!)
 ====================
 */
-( void ) handleLevelDown {
    level--;
    nextLevelXP /= 2;
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
