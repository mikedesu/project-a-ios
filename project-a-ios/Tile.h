//  Tile.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum {
    TILE_FLOOR_VOID=0,
    TILE_FLOOR_UPSTAIRS,
    TILE_FLOOR_DOWNSTAIRS,
    
    
    TILE_FLOOR_STONE,
    TILE_FLOOR_STONE_GRAY,
    TILE_FLOOR_STONE_RED,
    TILE_FLOOR_STONE_GOLD,
    //TILE_FLOOR_STONE_ONYX,
    //TILE_FLOOR_STONE_DIAMOND

    
    TILE_FLOOR_WATER,
    //TILE_FLOOR_WATER_DEEP
    
    TILE_FLOOR_GRASS,
    //TILE_FLOOR_GRASS_LIVELY,
    //TILE_FLOOR_GRASS_DEAD,
    
    TILE_FLOOR_ACID,    // instant-death tile
    
    TILE_FLOOR_LAVA,    // greater fire damage every step
    
    // un-implemented
    
    TILE_FLOOR_ICE,  //undefined
    //TILE_FLOOR_ICE_WEAK,
    //TILE_FLOOR_ICE_STRONG
    
    //TILE_FLOOR_SAND,
    //TILE_FLOOR_GLASS,
    
    //TILE_FLOOR_EARTH_LUSH,
    //TILE_FLOOR_EARTH_CRACKED,
    
    //TILE_FLOOR_
    
    
    
    // Trapped Tile-types
    TILE_FLOOR_STONE_TRAP_SPIKES_D6,
    TILE_FLOOR_STONE_TRAP_POISON_D6,
    
} Tile_t;

#define TILE_FLOOR_DEFAULT    TILE_FLOOR_GRASS


@interface Tile : NSObject {
    Tile_t tileType;
    BOOL isSelected;
    BOOL needsRedraw; // not used yet ( i think )
    
    // trap-specific tile variables
    BOOL trapIsSet;
    NSInteger tripDamageBase;
    NSInteger tripDamageMod;
    
    //int temperature;
    //int water;
    //int elevation;
    //int drainage;
    //int vegetation;
    int savagery;
    //int goodevil;
    //int salinity;
    
    CGPoint position;
    NSMutableArray *contents;
}

@property (atomic, assign) int savagery;

@property (atomic) Tile_t tileType;
@property (atomic) BOOL isSelected;
@property (atomic) BOOL needsRedraw;

@property (atomic, assign) BOOL trapIsSet;
@property (atomic, assign) NSInteger tripDamageBase;
@property (atomic, assign) NSInteger tripDamageMod;


@property (atomic) CGPoint position;

-( id ) init;
-( id ) initWithTileType: ( Tile_t ) _tileType;
-( void ) handleTileType: (Tile_t) _tileType;
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position;

-( NSMutableArray * ) contents;
-( void ) setContents: ( NSMutableArray * ) c;
-( void ) addObjectToContents: ( NSObject * ) obj;
-( void ) removeObjectFromContents: (NSObject *) obj;
    
@end