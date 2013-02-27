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
} Tile_t;

#define TILE_FLOOR_DEFAULT    TILE_FLOOR_GRASS
//#define TILE_DEFAULT    TILE_ICE

//@class CCMutableTexture2D;

@interface Tile : NSObject {
    Tile_t tileType;
    BOOL isSelected;
    BOOL needsRedraw; // not used yet ( i think )
    //CCMutableTexture2D *texture;
    CGPoint position;
    NSMutableArray *contents;
}

@property (atomic) Tile_t tileType;
@property (atomic) BOOL isSelected;
@property (atomic) BOOL needsRedraw;
//@property (atomic) CCMutableTexture2D *texture;
@property (atomic) CGPoint position;
//@property (atomic) NSMutableArray *contents;

-( id ) init;
-( id ) initWithTileType: ( Tile_t ) tileType;
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position;

-( NSMutableArray * ) contents;
-( void ) setContents: ( NSMutableArray * ) c;
//+( void ) renderTextureForTile: ( Tile * ) tile;

-( void ) addObjectToContents: ( NSObject * ) obj;
-( void ) removeObjectFromContents: (NSObject *) obj;
    
@end