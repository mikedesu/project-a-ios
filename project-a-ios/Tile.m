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
@synthesize trapIsSet;
@synthesize position;
@synthesize tripDamageBase;
@synthesize tripDamageMod;
@synthesize savagery;

/*
 ====================
 init
 ====================
 */
-( id ) init {
    if ( ( self = [ super init ] ) ) {
        tileType    = TILE_FLOOR_DEFAULT;
        isSelected  = NO;
        needsRedraw = YES;
        trapIsSet   = NO;
        position    = ccp( 0, 0 );
        contents    = nil;
        
        savagery    = 0;
    }
    return self;
}


/*
 ====================
 initWithTileType: tileType
 ====================
 */
-( id ) initWithTileType: ( Tile_t ) _tileType {
    if ( ( self = [ super init ] ) ) {
        tileType    = _tileType;
        isSelected  = NO;
        needsRedraw = YES;
        
        [self handleTileType:_tileType];
        
        position    = ccp( 0, 0 );
        contents    = nil;
    }
    return self;
}

/*
 ====================
 handleTiletype: _tileType
 
 for use at initialization of tile 
 sets the trap vars
 ====================
 */
-( void ) handleTileType: (Tile_t) _tileType {
    // handle trapIsSet based on tile type
    /*
    if ( _tileType == TILE_FLOOR_STONE_TRAP_SPIKES_D6 ) {
        trapIsSet = YES;
        tripDamageBase = 6;
        tripDamageMod = 0;
    }
    else if ( _tileType == TILE_FLOOR_STONE_TRAP_POISON_D6 ) {
        trapIsSet = YES;
        tripDamageBase = 0;
        tripDamageMod = 0;
    }
    else {
     */
        trapIsSet = NO;
        tripDamageBase = 0;
        tripDamageMod = 0;
    //}
}





/*
 ====================
 newTileWithType: tileType withPosition: position
 ====================
 */
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position {
    Tile *tile = [[ Tile alloc ] initWithTileType: tileType ];
    tile->position.x = position.x;
    tile->position.y = position.y;
    return tile;
}


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