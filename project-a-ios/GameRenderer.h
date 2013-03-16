//  GameRenderer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "Tile.h"

@class CCSprite;

@interface GameRenderer : NSObject {}

+( NSInteger ) modifierForNumber: (NSInteger) n;

+( void ) colorScrambleTile: ( CCSprite * ) tileSprite;
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray;
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data;
+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data;

+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor withCamera: ( CGPoint ) camera withSprites: (NSDictionary *) sprites;
+( void ) setAllTiles: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType;
+( void ) setTileArrayBoundary: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level;
+( void ) setDefaultTileArrayBoundary: (DungeonFloor *) floor;
+( void ) setAllTilesInFloor: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType;
+( void ) setTileAtPosition: (CGPoint) position onFloor: (DungeonFloor *) floor toType: (Tile_t) tileType;
+( void ) setTile: (Tile *) tile toType: (Tile_t) tileType;

+( void ) generateDungeonFloor: ( DungeonFloor * ) floor;
+( void ) generateDungeonFloor: ( DungeonFloor * ) floor withAlgorithm: (DungeonFloorAlgorithm_t) algorithm;

+( void ) largeRoomAlgorithm: (DungeonFloor *) floor;
+( void ) algorithm0: (DungeonFloorAlgorithm_t) algorithm withFloor: (DungeonFloor *) floor;

+( CGPoint ) getUpstairsTileForFloor: ( DungeonFloor * ) floor;
+( CGPoint ) getDownstairsTileForFloor: ( DungeonFloor * ) floor;
+( Tile * ) getTileForFloor: (DungeonFloor *) floor forCGPoint: (CGPoint) p;

+( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b;


+( Entity * ) randomEntity;
+( Entity * ) randomItem;
+( Entity * ) randomMonsterForFloor: (DungeonFloor *) floor;


+( void ) spawnEntity: (Entity *) entity onFloor: (DungeonFloor *) floor atLocation: (CGPoint) location;
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor;

+( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile;

+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc;
+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc withChanceDie: (NSInteger) chanceDie ;
+( void ) spawnRandomItemAtRandomLocationOnFloor: (DungeonFloor *) floor;
+( void ) spawnBookOfAllKnowingAtRandomLocationOnFloor: (DungeonFloor *) floor;
    

@end