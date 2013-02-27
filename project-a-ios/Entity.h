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
    ENTITYPATHFINDINGALGORITHM_T_SIMPLE
} EntityPathFindingAlgorithm_t;


@class CCMutableTexture2D;

@interface Entity : NSObject {
//@public
    BOOL isPC;
    CGPoint positionOnMap;
    
    CCMutableTexture2D *texture;
    
    NSMutableString *name;
    EntityTypes_t entityType;
    
    NSUInteger level;
    EntityStats_t stats;
    
    NSInteger hp;
    NSInteger maxhp;
    
    NSUInteger money;
    
    EntityPathFindingAlgorithm_t pathFindingAlgorithm;
    
    NSMutableArray *inventoryArray;
}

@property (atomic, assign) BOOL isPC;
@property (atomic, assign) CGPoint positionOnMap;
@property (atomic) CCMutableTexture2D *texture;

@property (atomic) NSMutableString *name;
@property (atomic, assign) EntityTypes_t entityType;

@property (atomic, assign) NSUInteger level;
@property (atomic, assign) EntityStats_t stats;

@property (atomic, assign) NSInteger hp;
@property (atomic, assign) NSInteger maxhp;

@property (atomic, assign) EntityPathFindingAlgorithm_t pathFindingAlgorithm;

@property (atomic, assign) NSUInteger money;
@property (atomic) NSMutableArray *inventoryArray;


-( void ) step;

@end