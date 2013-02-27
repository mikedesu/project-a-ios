//  Tile.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@implementation Tile

@synthesize tileType;
@synthesize isSelected;
@synthesize needsRedraw;
//@synthesize texture;
@synthesize position;
//@synthesize contents;

/*
 ====================
 init
 ====================
 */
-( id ) init {
    if ( ( self = [ super init ] ) ) {
        self->tileType = TILE_FLOOR_DEFAULT;
        self->isSelected = NO;
        self->needsRedraw = YES;
        //self->tileSprite = nil;
  //      self->texture = [[ CCMutableTexture2D alloc ] initWithSize:CGSizeMake(TILE_SIZE, TILE_SIZE) pixelFormat:kCCTexture2DPixelFormat_Default ];
        self->position = ccp( 0, 0 );
        self->contents = nil;
        //self->contents = [ [ NSMutableArray alloc ] init ];
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
        self->isSelected = NO;
        self->needsRedraw = YES;
        //self->tileSprite = nil;
    //    self->texture = [[ CCMutableTexture2D alloc ] initWithSize:CGSizeMake(TILE_SIZE, TILE_SIZE) pixelFormat:kCCTexture2DPixelFormat_Default ];
        self->position = ccp( 0, 0 );
        self->contents = nil;
        //self->contents = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 newTileWithType: tileType withPosition: position
 ====================
 */
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position {
    //MLOG( @"newTileWithType: withPosition: (%f,%f)", position.x, position.y );
    Tile *tile = [[ Tile alloc ] initWithTileType: tileType ];
    tile->position.x = position.x;
    tile->position.y = position.y;
    //MLOG( @"end newTileWithType" );
    return tile;
}


//////////////////


/*
 ====================
 contents
 
 returns content array, initializes if nil
 ====================
 */
-( NSMutableArray * ) contents {
    if ( contents == nil ) {
        contents = [[ NSMutableArray alloc ] init ];
    }
    return contents;
}


/*
 ====================
 setContents
 
 sets the contents pointer to c
 ====================
 */
-( void ) setContents: ( NSMutableArray * ) c {
    contents = c;
}


/*
 ====================
 addObjectToContents: obj
 
 adds the object obj to contents
 ====================
 */
-( void ) addObjectToContents: ( NSObject * ) obj {
    [[ self contents] addObject: obj ];
}


/*
 ====================
 removeObjectFromContents: obj
 
 removes the object obj from contents
 ====================
 */
-( void ) removeObjectFromContents: (NSObject *) obj {
    [[self contents] removeObject:obj];
}

@end