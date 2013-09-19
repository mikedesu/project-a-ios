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
    
    TILE_FLOOR_DIRT_0,
    TILE_FLOOR_DIRT_1,
    TILE_FLOOR_DIRT_2,
    TILE_FLOOR_DIRT_3,
    TILE_FLOOR_DIRT_4,
    TILE_FLOOR_DIRT_5,
    TILE_FLOOR_DIRT_6,
    TILE_FLOOR_DIRT_7,
    TILE_FLOOR_DIRT_8,
    TILE_FLOOR_DIRT_9,
    TILE_FLOOR_DIRT_10,
    TILE_FLOOR_DIRT_11,
    TILE_FLOOR_DIRT_12,
    TILE_FLOOR_DIRT_13,
    TILE_FLOOR_DIRT_14,
    TILE_FLOOR_DIRT_15,
    TILE_FLOOR_DIRT_16,
    TILE_FLOOR_DIRT_17,
    TILE_FLOOR_DIRT_18,
    TILE_FLOOR_DIRT_19,
    TILE_FLOOR_DIRT_20,
    TILE_FLOOR_DIRT_21,
    TILE_FLOOR_DIRT_22,
    TILE_FLOOR_DIRT_23,
    TILE_FLOOR_DIRT_24,
    TILE_FLOOR_DIRT_25,
    TILE_FLOOR_DIRT_26,
    TILE_FLOOR_DIRT_27,
    
    TILE_FLOOR_SNOW_0,
    TILE_FLOOR_SNOW_1,
    TILE_FLOOR_SNOW_2,
    TILE_FLOOR_SNOW_3,
    TILE_FLOOR_SNOW_4,
    TILE_FLOOR_SNOW_5,
    TILE_FLOOR_SNOW_6,
    TILE_FLOOR_SNOW_7,
    TILE_FLOOR_SNOW_8,
    TILE_FLOOR_SNOW_9,
    TILE_FLOOR_SNOW_10,
    TILE_FLOOR_SNOW_11,
    TILE_FLOOR_SNOW_12,
    TILE_FLOOR_SNOW_13,
    TILE_FLOOR_SNOW_14,
    TILE_FLOOR_SNOW_15,
    TILE_FLOOR_SNOW_16,
    TILE_FLOOR_SNOW_17,
    TILE_FLOOR_SNOW_18,
    TILE_FLOOR_SNOW_19,
    TILE_FLOOR_SNOW_20,
    TILE_FLOOR_SNOW_21,
    TILE_FLOOR_SNOW_22,
    TILE_FLOOR_SNOW_23,
    TILE_FLOOR_SNOW_24,
    TILE_FLOOR_SNOW_25,
    TILE_FLOOR_SNOW_26,
    TILE_FLOOR_SNOW_27,
    TILE_FLOOR_SNOW_28,
    TILE_FLOOR_SNOW_29,
    TILE_FLOOR_SNOW_30,
    TILE_FLOOR_SNOW_31,
    TILE_FLOOR_SNOW_32,
    
    TILE_FLOOR_MUD_0,
    TILE_FLOOR_QUICKSAND_0,
    TILE_FLOOR_ICE_0,
    TILE_FLOOR_CLOUD_0,
    TILE_FLOOR_WOOD_0,
    TILE_FLOOR_LAVA_0,
    
    TILE_FLOOR_SWAMP_0,
    TILE_FLOOR_SWAMP_1,
    TILE_FLOOR_SWAMP_2,
    TILE_FLOOR_SWAMP_3,
    TILE_FLOOR_SWAMP_4,
    TILE_FLOOR_SWAMP_5,
    TILE_FLOOR_SWAMP_6,
    TILE_FLOOR_SWAMP_7,
    TILE_FLOOR_SWAMP_8,
    TILE_FLOOR_SWAMP_9,
    TILE_FLOOR_SWAMP_10,
    TILE_FLOOR_SWAMP_11,
    TILE_FLOOR_SWAMP_12,
    TILE_FLOOR_SWAMP_13,
    TILE_FLOOR_SWAMP_14,
    TILE_FLOOR_SWAMP_15,
    TILE_FLOOR_SWAMP_16,
    TILE_FLOOR_SWAMP_17,
    TILE_FLOOR_SWAMP_18,
    TILE_FLOOR_SWAMP_19,
    TILE_FLOOR_SWAMP_20,
    TILE_FLOOR_SWAMP_21,
    TILE_FLOOR_SWAMP_22,
    TILE_FLOOR_SWAMP_23,
    TILE_FLOOR_SWAMP_24,
    TILE_FLOOR_SWAMP_25,
    TILE_FLOOR_SWAMP_26,
    TILE_FLOOR_SWAMP_27,
    TILE_FLOOR_SWAMP_28,
    TILE_FLOOR_SWAMP_29,
    TILE_FLOOR_SWAMP_30,
    TILE_FLOOR_SWAMP_31,
    TILE_FLOOR_SWAMP_32,
    
    
 
    TILE_FLOOR_SAND_0,
    TILE_FLOOR_SAND_1,
    TILE_FLOOR_SAND_2,
    TILE_FLOOR_SAND_3,
    TILE_FLOOR_SAND_4,
    TILE_FLOOR_SAND_5,
    TILE_FLOOR_SAND_6,
    TILE_FLOOR_SAND_7,
    TILE_FLOOR_SAND_8,
    TILE_FLOOR_SAND_9,
    TILE_FLOOR_SAND_10,
    TILE_FLOOR_SAND_11,
    TILE_FLOOR_SAND_12,
    TILE_FLOOR_SAND_13,
    TILE_FLOOR_SAND_14,
    TILE_FLOOR_SAND_15,
    
    
    TILE_FLOOR_METAL_0,
    TILE_FLOOR_METAL_1,
    TILE_FLOOR_METAL_2,
    TILE_FLOOR_METAL_3,
    TILE_FLOOR_METAL_4,
    TILE_FLOOR_METAL_5,
    TILE_FLOOR_METAL_6,
    TILE_FLOOR_METAL_7,
    TILE_FLOOR_METAL_8,
    TILE_FLOOR_METAL_9,
    TILE_FLOOR_METAL_10,
    TILE_FLOOR_METAL_11,
    TILE_FLOOR_METAL_12,
    TILE_FLOOR_METAL_13,
    TILE_FLOOR_METAL_14,
    TILE_FLOOR_METAL_15,
    TILE_FLOOR_METAL_16,
    TILE_FLOOR_METAL_17,
    TILE_FLOOR_METAL_18,
    TILE_FLOOR_METAL_19,
    TILE_FLOOR_METAL_20,
    TILE_FLOOR_METAL_21,
    TILE_FLOOR_METAL_22,
    TILE_FLOOR_METAL_23,
    TILE_FLOOR_METAL_24,
    TILE_FLOOR_METAL_25,
    TILE_FLOOR_METAL_26,
    TILE_FLOOR_METAL_27,
    TILE_FLOOR_METAL_28,
    TILE_FLOOR_METAL_29,
    
    
    TILE_FLOOR_SPACE_0,
    TILE_FLOOR_SPACE_1,
    TILE_FLOOR_SPACE_2,
    TILE_FLOOR_SPACE_3,
    
    TILE_FLOOR_QUANTUMFOAM_0,
    
    
    
    
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
