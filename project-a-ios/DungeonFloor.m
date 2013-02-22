//  DungeonFloor.m
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "DungeonFloor.h"

@implementation DungeonFloor

@synthesize height;
@synthesize width;
@synthesize border;
@synthesize tileDataArray;
@synthesize floorNumber;

/*
 ====================
 init
 ====================
 */
-( id ) init {
    MLOG( @"init" );
    if ( ( self = [ super init ] ) ) {
        width = 0;
        height = 0;
        border = 0;
        tileDataArray = [[ NSMutableArray alloc ] init ];
        floorNumber = 0;
    }
    return self;
}


/*
 ====================
 newFloor
 ====================
 */
+( DungeonFloor * ) newFloor {
    //MLOG( @"newFloor" );
    NSUInteger dw = 5; // true dungeon width
    //NSUInteger dh = 5; // true dungeon height
    NSUInteger border = 20;
    NSUInteger dungeonWidth = border + dw;  // x-20
    NSUInteger dungeonHeight = border + dw; // x-20
    DungeonFloor *floor = [[ DungeonFloor alloc ] init ];
    floor.width = dungeonWidth;
    floor.height = dungeonHeight;
    floor.border = border;
    floor.floorNumber = 0;
    for ( int j = 0 ; j < dungeonHeight ; j++ ) {
        for ( int i = 0; i < dungeonWidth; i++ ) {
            Tile *newTile = [ Tile newTileWithType: TILE_FLOOR_DEFAULT withPosition: ccp(i, j)];
            [ floor.tileDataArray addObject: newTile ];
        }
    }
    //MLOG( @"end newFloor" );
    return floor;
}


/*
 ====================
 newFloorWidth: w andHeight: h
 ====================
 */
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h {
    //MLOG( @"newFloor" );
    NSAssert(w > 0 && h > 0, @"DungeonFloor Width and Height must be > 1" );
    NSUInteger dw = w; // true dungeon width
    NSUInteger dh = h; // true dungeon height
    NSUInteger border = 20;
    NSUInteger dungeonWidth = border + dw;  // x-20
    NSUInteger dungeonHeight = border + dh; // x-20
    DungeonFloor *floor = [[ DungeonFloor alloc ] init ];
    floor.width = dungeonWidth;
    floor.height = dungeonHeight;
    floor.border = border;
    floor.floorNumber = 0;
    for ( int j = 0 ; j < dungeonHeight ; j++ ) {
        for ( int i = 0; i < dungeonWidth; i++ ) {
            Tile *newTile = [ Tile newTileWithType: TILE_FLOOR_DEFAULT withPosition: ccp(i, j)];
            [ floor.tileDataArray addObject: newTile ];
        }
    }
    //MLOG( @"end newFloor" );
    return floor;
}


/*
 ====================
 newFloorWidth: w andHeight: h andFloorNumber: floorNumber
 ====================
 */
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h andFloorNumber:(NSUInteger)floorNumber {
    //MLOG( @"newFloor" );
    NSAssert(w > 0 && h > 0, @"DungeonFloor Width and Height must be > 1" );
    NSUInteger dw = w; // true dungeon width
    NSUInteger dh = h; // true dungeon height
    NSUInteger border = 20;
    NSUInteger dungeonWidth = border + dw;  // x-20
    NSUInteger dungeonHeight = border + dh; // x-20
    DungeonFloor *floor = [[ DungeonFloor alloc ] init ];
    floor.width = dungeonWidth;
    floor.height = dungeonHeight;
    floor.border = border;
    floor.floorNumber = floorNumber;
    for ( int j = 0 ; j < dungeonHeight ; j++ ) {
        for ( int i = 0; i < dungeonWidth; i++ ) {
            Tile *newTile = [ Tile newTileWithType: TILE_FLOOR_DEFAULT withPosition: ccp(i, j)];
            [ floor.tileDataArray addObject: newTile ];
        }
    }
    //MLOG( @"end newFloor" );
    return floor;
}





@end