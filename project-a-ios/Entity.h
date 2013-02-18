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
    NSUInteger money;
    
    NSMutableArray *inventoryArray;
}

@property (atomic, assign) BOOL isPC;
@property (atomic, assign) CGPoint positionOnMap;
@property (atomic) CCMutableTexture2D *texture;

@property (atomic) NSMutableString *name;
@property (atomic, assign) EntityTypes_t entityType;
@property (atomic, assign) NSUInteger level;
@property (atomic, assign) EntityStats_t stats;
@property (atomic, assign) NSUInteger money;
@property (atomic) NSMutableArray *inventoryArray;

+( void ) drawTextureForEntity: ( Entity * ) entity;

@end