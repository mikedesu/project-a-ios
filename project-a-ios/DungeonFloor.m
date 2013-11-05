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