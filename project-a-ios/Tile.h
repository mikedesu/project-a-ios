//  Tile.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.


/*
 
 ideas for tilePalette generation via tileTypes...
 
 base tileTypes:
 
 void 0
 upstairs 1
 downstairs 2
 
 stone 3
 water 4
 grass 5
 acid 6  <-- may become 'swamp'
 lava 7
 ice 8
 sand 9
 
 
 From each type, every tile will also have:
 
 temperature
 wetness
 salinity
 drainage
 vegetation
 savagery
 goodevil
 
 */


typedef enum {
    TILE_FLOOR_VOID=0,
    TILE_FLOOR_UPSTAIRS,
    TILE_FLOOR_DOWNSTAIRS,
    
    TILE_FLOOR_STONE_0, //gray
    TILE_FLOOR_STONE_1, //red
    TILE_FLOOR_STONE_2, //gold
    TILE_FLOOR_STONE_3, //blue
    TILE_FLOOR_STONE_4, //green
    
    TILE_FLOOR_GRASS_0,
    TILE_FLOOR_GRASS_1,
 
    TILE_FLOOR_SAND_0, //
    TILE_FLOOR_SAND_1, //
    TILE_FLOOR_SAND_2, //
    TILE_FLOOR_SAND_3, //
    TILE_FLOOR_SAND_4, //
    TILE_FLOOR_SAND_5, //
    TILE_FLOOR_SAND_6, //
    TILE_FLOOR_SAND_7, //
    
    
    TILE_FLOOR_WATER_0,
    
    
    TILE_FLOOR_ACID,    // instant-death tile - might be renamed to swamp tiles
    TILE_FLOOR_LAVA,    // greater fire damage every step
    TILE_FLOOR_ICE,  //undefined
    
    // Trapped Tile-types
    //TILE_FLOOR_STONE_TRAP_SPIKES_D6,
    //TILE_FLOOR_STONE_TRAP_POISON_D6,
    
} Tile_t;

#define TILE_FLOOR_DEFAULT    TILE_FLOOR_STONE_0


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

+( NSString * ) stringForTileType: (Tile_t) _tileType;

@end
