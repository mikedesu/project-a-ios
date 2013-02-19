//  GameRenderer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "Tile.h"

@class CCSprite;

@interface GameRenderer : NSObject {

}

+( void ) colorScrambleTile: ( CCSprite * ) tileSprite;
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray;
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data;
+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data;

//+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor;
+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor withCamera: ( CGPoint ) camera ;
+( void ) setAllTiles: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType;
//+( void ) setTileArrayBoundary: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level;
+( void ) setTileArrayBoundary: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level;
+(void) setDefaultTileArrayBoundary: (DungeonFloor *) floor;
+( void ) setAllTilesInFloor: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType;
+(void) setTileAtPosition: (CGPoint) position onFloor: (DungeonFloor *) floor toType: (Tile_t) tileType;
+(void) setTile: (Tile *) tile toType: (Tile_t) tileType;

+( void ) generateDungeonFloor: ( DungeonFloor * ) floor;
    
@end