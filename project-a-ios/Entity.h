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
    
    NSInteger hp;
    NSInteger maxhp;
    
    NSInteger ac; //armor class
    
    NSUInteger money;
    
    NSInteger totalKills;
    
    EntityPathFindingAlgorithm_t pathFindingAlgorithm;
    
    EntityItemPickupAlgorithm_t itemPickupAlgorithm;
    
    NSMutableArray *inventoryArray;
    
    NSMutableArray *pathTaken;
    
    
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

@property (atomic, assign) NSInteger hp;
@property (atomic, assign) NSInteger maxhp;
@property (atomic, assign) NSInteger ac;

@property (atomic, assign) EntityPathFindingAlgorithm_t pathFindingAlgorithm;
@property (atomic, assign) EntityItemPickupAlgorithm_t itemPickupAlgorithm;

@property (atomic, assign) NSUInteger money;
@property (atomic) NSMutableArray *inventoryArray;

@property (atomic) NSMutableArray *pathTaken;

-(Entity *) init;
-(Entity *) initWithLevel: (NSInteger) level;

-( NSInteger ) attackBonus;
-( NSInteger ) attackRoll;
-( NSInteger ) totalac;
-( NSInteger ) damageRoll;

-( NSInteger ) movement;

-( void ) gainXP: (NSInteger) exp;
-( void ) handleLevelUp;
-( void ) handleLevelDown;

    
-( void ) step;

@end