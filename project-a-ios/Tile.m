//  Tile.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Tile.h"

@implementation Tile

/*
 ====================
 init
 ====================
 */
-( id ) init {
    if ( ( self = [ super init ] ) ) {
        self->tileType = TILE_DEFAULT;
        self->tileSprite = nil;
        self->contents = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 initWithTileType: tileType
 ====================
 */
-( id ) initWithTileType: ( Tile_t ) tileType {
    if ( ( self = [ super init ] ) ) {
        self->tileType = tileType;
        self->tileSprite = nil;
        self->contents = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}
@end