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

@class CCMutableTexture2D;

@interface Entity : NSObject {
@public
    BOOL isPC;
    NSMutableString *name;
    CGPoint positionOnMap;
    CCMutableTexture2D *texture;
}

+( void ) drawTextureForEntity: ( Entity * ) entity;

@end