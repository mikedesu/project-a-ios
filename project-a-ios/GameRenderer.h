/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
//  GameRenderer.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Metal_t.h"
#import "Wood_t.h"
#import "Stone_t.h"
#import "Cloth_t.h"
#import "GameConfig.h"
#import "Tile.h"

@class CCSprite;

@interface GameRenderer : NSObject {}

+( NSInteger ) modifierForNumber: (NSInteger) n;
+( NSInteger ) maxWeightForStrength: (NSInteger) str;

+( NSString * ) getMetalName: (Metal_t) metal;
+( NSString * ) getWoodName: (Wood_t) wood;
+( NSString * ) getStoneName: (Stone_t) stone;
+( NSString * ) getClothName: (Cloth_t) cloth;


+( void ) colorScrambleTile: ( CCSprite * ) tileSprite;
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray;
//+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data;

+(BOOL) voidTileExistsBetweenEntity: (Entity *) e andTile: (Tile *) tile onFloor: (DungeonFloor *) floor;

+( void ) setLightTile:(CCSprite *) sprite withData:(Tile *) tile withFloor: (DungeonFloor *) floor;
+( void ) setTile: (CCSprite *) sprite toAlpha: (GLubyte) alpha ;
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data withSprites: (NSDictionary *) sprites withFloor: (DungeonFloor *) floor;
    
//+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data;

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

+( void ) spawnMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor;
+( void ) spawnDoors: (int) doorCount forFloor: (DungeonFloor *) floor;
    
+( void ) spawnEntity: (Entity *) entity onFloor: (DungeonFloor *) floor atLocation: (CGPoint) location;
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor;
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor onTileType: (Tile_t) tileType;
    
+( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile;

+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc;
+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc withChanceDie: (NSInteger) chanceDie ;
+( void ) spawnRandomItemAtRandomLocationOnFloor: (DungeonFloor *) floor;
+( void ) spawnBookOfAllKnowingAtRandomLocationOnFloor: (DungeonFloor *) floor;

+(void) copyTexture: (CCMutableTexture2D *) texture0 ontoTexture: (CCMutableTexture2D *) texture1 ;

+( Tile * ) getMapTileFromPoint: (CGPoint) p forFloor: (DungeonFloor *) _floor;
+( Tile * ) getMapTileFromPointX: (CGFloat) _x Y: (CGFloat) _y forFloor: (DungeonFloor *) _floor;

+( void ) spawnTreasureForFloor: (DungeonFloor *) floor ;

@end
