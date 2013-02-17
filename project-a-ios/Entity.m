//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"
#import "GameConfig.h"

@implementation Entity

@synthesize isPC;
@synthesize name;
@synthesize positionOnMap;
@synthesize texture;

/*
 ====================
 init
 
 initializes and returns the object
 ====================
 */
-( id ) init {
    if ( ( self = [super init] ) ) {
        isPC = NO;
        name = [ [ NSMutableString alloc ] init ];
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture = nil;
    }
    return self;
}


+( void ) drawTextureForEntity: ( Entity * ) entity {
    [entity->texture fill: ccc4(0,0,0,0)];
    
    [entity->texture setPixelAt:ccp(0,0) rgba:black];
    [entity->texture setPixelAt:ccp(1,0) rgba:black];
    [entity->texture setPixelAt:ccp(2,0) rgba:black];
    [entity->texture setPixelAt:ccp(3,0) rgba:black];
    
    [entity->texture setPixelAt:ccp(0,1) rgba:black];
    [entity->texture setPixelAt:ccp(1,1) rgba:black];
    [entity->texture setPixelAt:ccp(2,1) rgba:black];
    [entity->texture setPixelAt:ccp(3,1) rgba:black];
    
    [entity->texture setPixelAt:ccp(0,2) rgba:black];
    [entity->texture setPixelAt:ccp(1,2) rgba:black];
    [entity->texture setPixelAt:ccp(2,2) rgba:black];
    [entity->texture setPixelAt:ccp(3,2) rgba:black];
    
    [entity->texture setPixelAt:ccp(0,3) rgba:black];
    [entity->texture setPixelAt:ccp(1,3) rgba:black];
    [entity->texture setPixelAt:ccp(2,3) rgba:black];
    [entity->texture setPixelAt:ccp(3,3) rgba:black];
    
    [entity->texture apply];
}


@end
