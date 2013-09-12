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
    TILE_FLOOR_STONE_5,
    TILE_FLOOR_STONE_6,
    TILE_FLOOR_STONE_7,
    TILE_FLOOR_STONE_8,
    TILE_FLOOR_STONE_9,
    TILE_FLOOR_STONE_10,
    TILE_FLOOR_STONE_11,
    TILE_FLOOR_STONE_12,
    TILE_FLOOR_STONE_13,
    TILE_FLOOR_STONE_14,
    TILE_FLOOR_STONE_15,
    TILE_FLOOR_STONE_16,
    TILE_FLOOR_STONE_17,
    TILE_FLOOR_STONE_18,
    TILE_FLOOR_STONE_19,
    TILE_FLOOR_STONE_20,
    TILE_FLOOR_STONE_21,
    TILE_FLOOR_STONE_22,
    TILE_FLOOR_STONE_23,
    TILE_FLOOR_STONE_24,
    
    
    //TILE_FLOOR_STONE_5, //sand
    
    //DIRT
    //MUD
    //QUICKSAND
    //SPACE (warp tiles, meteors, black holes, etc)
    //SNOW
    //ICE (can fall through)
    //CLOUD
    //METAL
    //WOOD
    //LAVA
    
    
    TILE_FLOOR_GRASS_0,
    TILE_FLOOR_GRASS_1,
    TILE_FLOOR_GRASS_2,
    TILE_FLOOR_GRASS_3,
    TILE_FLOOR_GRASS_4,
    TILE_FLOOR_GRASS_5,
    TILE_FLOOR_GRASS_6,
    TILE_FLOOR_GRASS_7,
    TILE_FLOOR_GRASS_8,
    TILE_FLOOR_GRASS_9,
    TILE_FLOOR_GRASS_10,
    TILE_FLOOR_GRASS_11,
    TILE_FLOOR_GRASS_12,
    TILE_FLOOR_GRASS_13,
    TILE_FLOOR_GRASS_14,
    TILE_FLOOR_GRASS_15,
    TILE_FLOOR_GRASS_16,
    TILE_FLOOR_GRASS_17,
    TILE_FLOOR_GRASS_18,
    TILE_FLOOR_GRASS_19,
    TILE_FLOOR_GRASS_20,
    TILE_FLOOR_GRASS_21,
    TILE_FLOOR_GRASS_22,
    TILE_FLOOR_GRASS_23,
    TILE_FLOOR_GRASS_24,
    TILE_FLOOR_GRASS_25,
    TILE_FLOOR_GRASS_26,
    TILE_FLOOR_GRASS_27,
    TILE_FLOOR_GRASS_28,
    TILE_FLOOR_GRASS_29,
    TILE_FLOOR_GRASS_30,
    TILE_FLOOR_GRASS_31,
    
    TILE_FLOOR_GRASS_32,
    TILE_FLOOR_GRASS_33,
    TILE_FLOOR_GRASS_34,
    TILE_FLOOR_GRASS_35,
    TILE_FLOOR_GRASS_36,
    TILE_FLOOR_GRASS_37,
    TILE_FLOOR_GRASS_38,
    TILE_FLOOR_GRASS_39,
    TILE_FLOOR_GRASS_40,
    TILE_FLOOR_GRASS_41,
    TILE_FLOOR_GRASS_42,
    TILE_FLOOR_GRASS_43,
    TILE_FLOOR_GRASS_44,
    TILE_FLOOR_GRASS_45,
    TILE_FLOOR_GRASS_46,
    TILE_FLOOR_GRASS_47,
    TILE_FLOOR_GRASS_48,
    TILE_FLOOR_GRASS_49,
    TILE_FLOOR_GRASS_50,
    TILE_FLOOR_GRASS_51,
    TILE_FLOOR_GRASS_52,
    TILE_FLOOR_GRASS_53,
    TILE_FLOOR_GRASS_54,
    TILE_FLOOR_GRASS_55,
    TILE_FLOOR_GRASS_56,
    TILE_FLOOR_GRASS_57,
    TILE_FLOOR_GRASS_58,
    TILE_FLOOR_GRASS_59,
    TILE_FLOOR_GRASS_60,
    TILE_FLOOR_GRASS_61,
    TILE_FLOOR_GRASS_62,
    TILE_FLOOR_GRASS_63,
    
    
    
 
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
