//  Entity.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum {
    ENTITY_T_VOID=0,
    ENTITY_T_PC,
    ENTITY_T_NPC,
    ENTITY_T_ITEM
} EntityTypes_t;


// Items
typedef enum {
    E_ITEM_T_NONE,
    E_ITEM_T_WEAPON,
    E_ITEM_T_ARMOR,
    E_ITEM_T_POTION,
    E_ITEM_T_FOOD,
    E_ITEM_T_BOOK,
} EntityItemTypes_t;


typedef enum {
    POTION_T_NONE,
    POTION_T_HEALING,
} PotionTypes_t;



typedef struct {
    NSUInteger strength;
    NSUInteger dexterity;
    NSUInteger constitution;
    NSUInteger intelligence;
    NSUInteger wisdom;
    NSUInteger charisma;
} EntityStats_t;


typedef enum {
    ENTITYPATHFINDINGALGORITHM_T_NONE=0,
    ENTITYPATHFINDINGALGORITHM_T_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_TEMP_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_SIMPLE,
    ENTITYPATHFINDINGALGORITHM_T_SIMPLE_LEFT,
} EntityPathFindingAlgorithm_t;


typedef enum {
    ENTITYITEMPICKUPALGORITHM_T_NONE=0,
    ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE
} EntityItemPickupAlgorithm_t;


typedef enum {
    ENTITYALIGNMENT_T_LAWFUL_GOOD = 0,
    ENTITYALIGNMENT_T_LAWFUL_NEUTRAL,
    ENTITYALIGNMENT_T_LAWFUL_EVIL,
    
    ENTITYALIGNMENT_T_NEUTRAL_GOOD,
    ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL,
    ENTITYALIGNMENT_T_NEUTRAL_EVIL,
    
    ENTITYALIGNMENT_T_CHAOTIC_GOOD,
    ENTITYALIGNMENT_T_CHAOTIC_NEUTRAL,
    ENTITYALIGNMENT_T_CHAOTIC_EVIL,
    
} EntityAlignment_t;



@class CCMutableTexture2D;

@interface Entity : NSObject {
//@public
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
    
    
    NSMutableArray *pathTaken;
    
    NSInteger hunger;
    
    
    // for potions/wands/healing items/etc 
    NSInteger healingRollBase;
    NSInteger healingBonus;
    
    // for food
    NSInteger foodBase;
    
    
    // Feats sieve:
    // 0000 0000 0001 0011
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


@property (atomic) NSMutableArray *pathTaken;

@property (atomic, assign) NSInteger foodBase;
@property (atomic, assign) NSInteger healingRollBase;
@property (atomic, assign) NSInteger healingBonus;

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

@end