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

@class CCMutableTexture2D;

@interface Tile : NSObject {
@public
    Tile_t tileType;
    BOOL isSelected;
    BOOL needsRedraw; // not used yet ( i think )
    CCMutableTexture2D *texture;
    CGPoint position;
    NSMutableArray *contents;
}
-( id ) init;
-( id ) initWithTileType: ( Tile_t ) tileType;
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position;
+( void ) renderTextureForTile: ( Tile * ) tile;
@end