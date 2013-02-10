//  Tile.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.



typedef enum {
    TILE_GRASS=0,
} Tile_t;

#define TILE_DEFAULT    TILE_GRASS

@interface Tile : NSObject {
    Tile_t tileType;
    NSMutableArray *contents;
}
-( id ) init;
-( id ) initWithTileType: ( Tile_t ) tileType;

@end