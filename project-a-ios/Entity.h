//  Entity.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EntitySubtypeDefines.h"
#import "EquipDefines.h"

@class CCMutableTexture2D;

@interface Entity : NSObject {
    BOOL isPC;
    BOOL isAlive;
 
    CGPoint positionOnMap;
    
    CCMutableTexture2D *texture;
    
    NSMutableString *name;
    EntityTypes_t entityType;
    
    NSInteger level;
    //EntityStats_t *stats;
    
    NSUInteger strength;
    NSUInteger dexterity;
    NSUInteger constitution;
    NSUInteger intelligence;
    NSUInteger wisdom;
    NSUInteger charisma;
    
    EntityAlignment_t alignment;
    
    NSUInteger xp;
    NSUInteger totalxp;
    NSUInteger nextLevelXP;
    
    NSInteger hitDie;
    
    NSInteger hp;
    NSInteger maxhp;
    
    NSInteger ac; //armor class
    
    NSUInteger money;
    
    EntityItemTypes_t itemType;
    
    
    PotionTypes_t potionType;
    
    
    NSInteger damageRollBase; // x, where 1dx = damage roll
    NSInteger damageBonus; // weapon roll bonus, if any
    
    NSInteger weight;
    NSInteger durability; // mainly for items
    NSInteger totalDurability; // mainly for items
    
    NSInteger totalKills;
    
    EntityPathFindingAlgorithm_t pathFindingAlgorithm;
    
    EntityItemPickupAlgorithm_t itemPickupAlgorithm;
    
    
    // PC/NPC inventory/equipment
    NSMutableArray *inventoryArray;
    Entity *equippedArmsLeft;
    Entity *equippedArmsRight;
    Entity *equippedArmorChest;
    
    //Entity *equipment[19];
    NSMutableArray *equipment;
    
    
    NSMutableArray *pathTaken;
    
    NSInteger hunger;
    
    
    // for potions/wands/healing items/etc 
    NSInteger healingRollBase;
    NSInteger healingBonus;
    
    // for food
    NSInteger foodBase;
 
    RaceTypes_t raceType;
}

@property (atomic, assign) BOOL isPC;
@property (atomic, assign) BOOL isAlive;
@property (atomic, assign) CGPoint positionOnMap;
@property (atomic) CCMutableTexture2D *texture;

@property (atomic) NSMutableString *name;
@property (atomic, assign) EntityTypes_t entityType;

@property (atomic, assign) NSInteger level;
@property (atomic, assign) NSInteger totalKills;
//@property (atomic, assign) EntityStats_t *stats;
@property (atomic, assign) NSUInteger strength;
@property (atomic, assign) NSUInteger constitution;
@property (atomic, assign) NSUInteger dexterity;
@property (atomic, assign) NSUInteger intelligence;
@property (atomic, assign) NSUInteger wisdom;
@property (atomic, assign) NSUInteger charisma;
@property (atomic, assign) EntityAlignment_t alignment;

@property (atomic, assign) NSUInteger xp;
@property (atomic, assign) NSUInteger totalxp;
@property (atomic, assign) NSUInteger nextLevelXP;

@property (atomic, assign) NSInteger hitDie;
@property (atomic, assign) NSInteger hp;
@property (atomic, assign) NSInteger maxhp;
@property (atomic, assign) NSInteger ac;

@property (atomic, assign) EntityItemTypes_t itemType;
@property (atomic, assign) PotionTypes_t potionType;

@property (atomic, assign) NSInteger damageRollBase;
@property (atomic, assign) NSInteger damageBonus;
@property (atomic, assign) NSInteger weight;
@property (atomic, assign) NSInteger durability;
@property (atomic, assign) NSInteger totalDurability;

@property (atomic, assign) EntityPathFindingAlgorithm_t pathFindingAlgorithm;
@property (atomic, assign) EntityItemPickupAlgorithm_t itemPickupAlgorithm;

@property (atomic, assign) NSUInteger money;
@property (atomic, assign) NSInteger hunger;
@property (atomic) NSMutableArray *inventoryArray;

@property (atomic) Entity *equippedArmsLeft;
@property (atomic) Entity *equippedArmsRight;
@property (atomic) Entity *equippedArmorChest;


@property (nonatomic) NSMutableArray *equipment;
@property (atomic) NSMutableArray *pathTaken;


@property (atomic, assign) NSInteger foodBase;
@property (atomic, assign) NSInteger healingRollBase;
@property (atomic, assign) NSInteger healingBonus;

@property (atomic, assign) RaceTypes_t raceType;

-(Entity *) init;
-(Entity *) initWithLevel: (NSInteger) _level;
-(Entity *) initWithHitDie: (NSInteger) hd ;
-(Entity *) initWithLevel:(NSInteger)_level withHitDie: (NSInteger) hd ;

-( NSInteger ) attackBonus;
-( NSInteger ) attackRoll;
-( NSInteger ) totalac;
-( NSInteger ) damageRoll;

-( NSInteger ) movement;

-( void ) gainXP: (NSInteger) exp;
-( void ) handleLevelUp;
-( void ) handleLevelDown;

-( void ) step;
-( void ) getHungry;

-( NSInteger ) damageRollBase ;
-( void ) setDamageRollBase: (NSInteger) _damageRollBase;

-(void) equipItem: (Entity *) item forEquipSlot: (EquipSlot_t) equipSlot;

@end