//  DungeonFloor.m
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "DungeonFloor.h"

@implementation DungeonFloor

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
        tileDataArray = [[ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 newFloor
 ====================
 */
+( DungeonFloor * ) newFloor {
    MLOG( @"newFloor" );
    NSUInteger dungeonWidth = 40;
    NSUInteger dungeonHeight = 60;
    DungeonFloor *floor = [[ DungeonFloor alloc ] init ];
    floor->width = dungeonWidth;
    floor->height = dungeonHeight;
    for ( int i = 0 ; i < dungeonHeight ; i++ ) {
        for ( int j = 0; j < dungeonWidth; j++ ) {
            Tile *newTile = [ Tile newTileWithType: TILE_DEFAULT withPosition: ccp(j, i)];
            [ floor->tileDataArray addObject: newTile ];
        }
    }
    MLOG( @"end newFloor" );
    return floor;
}

@end