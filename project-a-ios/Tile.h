//  Tile.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum {
    TILE_VOID=0,
    TILE_FLOOR_GRASS,
    TILE_FLOOR_STONE,
    TILE_FLOOR_ICE,
} Tile_t;

#define TILE_DEFAULT    TILE_FLOOR_GRASS
//#define TILE_DEFAULT    TILE_ICE


@class CCSprite;

@interface Tile : NSObject {
@public
    Tile_t tileType;
    BOOL isSelected;
    CCSprite *tileSprite;
    NSMutableArray *contents;
}
-( id ) init;
-( id ) initWithTileType: ( Tile_t ) tileType;

    
@end