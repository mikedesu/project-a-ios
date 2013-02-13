//  GameRenderer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Tile.h"

@interface GameRenderer : NSObject {
    
}
+( void ) colorScrambleTile: ( CCSprite * ) tileSprite;
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray;
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data;
+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data;

+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor;

+( void ) setAllTiles: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType;
+( void ) setTileArrayBoundary: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level;

@end