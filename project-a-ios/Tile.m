/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
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





+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position {
    Tile *tile = [[ Tile alloc ] initWithTileType: tileType ];
    tile->position.x = position.x;
    tile->position.y = position.y;
    return tile;
}


-( NSMutableArray * ) contents {
    if ( contents == nil ) {
        contents = [[ NSMutableArray alloc ] init ];
    }
    return contents;
}


-( void ) setContents: ( NSMutableArray * ) c {
    contents = c;
}


-( void ) addObjectToContents: ( NSObject * ) obj {
    [[ self contents] addObject: obj ];
}


-( void ) removeObjectFromContents: (NSObject *) obj {
    [[self contents] removeObject:obj];
}




+( NSString * ) stringForTileType: (Tile_t) _tileType {
    return nil;
}

-( BOOL ) isEmpty {
    return [[self contents] count] == 0;
}

@end
