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

@synthesize hitDie;
@synthesize hp;
@synthesize maxhp;
@synthesize ac;

@synthesize money;

@synthesize itemType;
@synthesize damageBonus;
@synthesize damageRollBase;
@synthesize weight;
@synthesize durability;
@synthesize totalDurability;

@synthesize totalKills;

@synthesize inventoryArray;
@synthesize equippedArmsLeft;
@synthesize equippedArmsRight;
@synthesize equippedArmorChest;

@synthesize pathFindingAlgorithm;
@synthesize itemPickupAlgorithm;

@synthesize pathTaken;

@synthesize entityType;

/*
 ====================
 init
 
 initializes and returns the object
 ====================
 */
-( id ) init {
    if ( ( self = [super init] ) ) {
        //MLOG(@"init");
        isPC = NO;
        isAlive = YES;
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture = nil;
        
        name = [ [ NSMutableString alloc ] init ];
        level = 1;
        entityType = ENTITY_T_VOID;
        
        totalKills = 0;
        
        itemType = E_ITEM_T_NONE;
        damageRollBase = 4;
        damageBonus = 0;
        weight = 0;
        durability = 0;
        totalDurability = 0;
        
        /*
         stats.strength = 8;
         stats.dexterity = 8;
         stats.constitution = 8;
         stats.intelligence = 8;
         stats.wisdom = 8;
         stats.charisma = 8;
         */
    
        /*
        strength = rollDice(6, 3);
        dexterity = rollDice(6, 3);
        constitution = rollDice(6, 3);
        intelligence = rollDice(6, 3);
        wisdom = rollDice(6, 3);
        charisma = rollDice(6, 3);
        
        */
        
        strength = [Dice roll:6 nTimes:3];
        dexterity = [Dice roll:6 nTimes:3];
        constitution = [Dice roll:6 nTimes:3];
        intelligence = [Dice roll:6 nTimes:3];
        wisdom = [Dice roll:6 nTimes:3];
        charisma = [Dice roll:6 nTimes:3];
        
        alignment = ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL;
        
        xp = 0;
        totalxp = 0;
        
#define DEFAULT_LVL1_NEXT_LEVEL_XP      10
        nextLevelXP = DEFAULT_LVL1_NEXT_LEVEL_XP;
        
        maxhp = 0;
        
        hitDie = 12;
        
        while ( maxhp == 0 ) {
            NSInteger conMod = [ GameRenderer modifierForNumber: constitution ];
            maxhp = [Dice roll:hitDie] + conMod;
            hp = maxhp;
            //MLOG(@"conMod = %d,  maxhp = %d", conMod, maxhp);
        }
        
        ac = 10; // the higher the better
        
        money = 0;
        
        inventoryArray = [ [ NSMutableArray alloc ] init ];
        equippedArmsLeft = nil;
        equippedArmsRight = nil;
        equippedArmorChest = nil;
        
        pathTaken = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
        itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
        
        //MLOG(@"end init");
    }
    return self;
}



-(Entity *) initWithHitDie: (NSInteger) hd {
    Entity *e = [[Entity alloc] init];
    maxhp = 0;
    hitDie = hd;
    while ( maxhp == 0 ) {
        NSInteger conMod = [ GameRenderer modifierForNumber: e.constitution ];
        maxhp = [Dice roll:hitDie] + conMod;
        hp = maxhp;
    }
    return e;
}





-(Entity *) initWithLevel:(NSInteger)_level withHitDie: (NSInteger) hd {
    Entity *e = [[ Entity alloc ] initWithHitDie: hd];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
        [ e handleLevelUp ];
    }
    return e;
}






-(Entity *) initWithLevel: (NSInteger) _level {
    Entity *e = [[ Entity alloc ] init];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
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
    
    NSInteger strengthBonus = [ GameRenderer modifierForNumber: strength ];
    
    // [ GameRenderer getModifierForStat: self.strength ] ;
    
    // any items / equipped gear would be counted here
    
    NSInteger gearBonus = 0;
    
    if ( self.equippedArmsLeft != nil )
        gearBonus += self.equippedArmsLeft.damageBonus;
    
    return strengthBonus + gearBonus;
}


/*
 ====================
 attackRoll
 
 returns the total attack roll for this entity
 ====================
 */
-( NSInteger ) attackRoll {
    //return rollDiceOnceWithModifier(20, self.attackBonus );
    return [Dice roll: 20] + self.attackBonus;
}


/*
 ====================
 damageRoll
 
 returns the total damage roll for this entity
 ====================
 */
-( NSInteger ) damageRoll {
    //return rollDiceOnce(6) + self.attackBonus;
    NSInteger roll = 0;
    if ( equippedArmsLeft == nil && equippedArmsRight == nil ) {
        roll = [Dice roll: damageRollBase] + self.attackBonus;
    }
    else {
        // weapon in left for now
        if ( equippedArmsLeft != nil )
            roll = [ Dice roll: equippedArmsLeft.damageRollBase ] + self.attackBonus;
    }
    return roll;
}


/*
 ====================
 ac
 
 returns the total ac 
 ====================
 */
-( NSInteger ) totalac {
    NSInteger dexterityBonus = [ GameRenderer modifierForNumber: dexterity ];
    NSInteger armorBonus = 0;
    if ( equippedArmorChest != nil )
        armorBonus = equippedArmorChest.ac;
    NSInteger total = ac + dexterityBonus + armorBonus;
    return total ;
}



/*
 ====================
 movement
 
 returns the total allowed move speed per turn
 ====================
 */
-( NSInteger ) movement {
    return 1;
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
    NSInteger conMod = [ GameRenderer modifierForNumber: constitution ];
    
    //maxhp = maxhp + rollDiceOnce(12) + conMod;
    maxhp = maxhp + [Dice roll:12] + conMod;
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
