//  Tile.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum {
    TILE_FLOOR_VOID=0,
    TILE_FLOOR_UPSTAIRS,
    TILE_FLOOR_DOWNSTAIRS,
    TILE_FLOOR_GRASS,
    TILE_FLOOR_STONE,
    TILE_FLOOR_ICE,
    TILE_FLOOR_WATER,
} Tile_t;

#define TILE_FLOOR_DEFAULT    TILE_FLOOR_GRASS


@interface Tile : NSObject {
    Tile_t tileType;
    BOOL isSelected;
    BOOL needsRedraw; // not used yet ( i think )
    CGPoint position;
    NSMutableArray *contents;
}

@property (atomic) Tile_t tileType;
@property (atomic) BOOL isSelected;
@property (atomic) BOOL needsRedraw;
@property (atomic) CGPoint position;

-( id ) init;
-( id ) initWithTileType: ( Tile_t ) _tileType;
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position;

-( NSMutableArray * ) contents;
-( void ) setContents: ( NSMutableArray * ) c;
-( void ) addObjectToContents: ( NSObject * ) obj;
-( void ) removeObjectFromContents: (NSObject *) obj;
    
@end