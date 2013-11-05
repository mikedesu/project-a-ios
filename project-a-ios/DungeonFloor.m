/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
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
@synthesize entityArray;

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
        entityArray = [[ NSMutableArray alloc ] init ];
    }
    MLOG(@"end of init");
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
    MLOG( @"newFloor" );
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
    //MLOG(@"entering newFloor loop...");
    for ( int j = 0 ; j < dungeonHeight ; j++ ) {
        //MLOG(@"j = %d", j);
        for ( int i = 0; i < dungeonWidth; i++ ) {
            //MLOG(@"i = %d", i);
            Tile *newTile = [ Tile newTileWithType: TILE_FLOOR_DEFAULT withPosition: ccp(i, j)];
            [ floor.tileDataArray addObject: newTile ];
        }
    }
    //MLOG( @"end newFloor" );
    return floor;
}





@end