//  GameRenderer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameRenderer.h"

@implementation GameRenderer

/*
 ====================
 colorScrambleTile
 ====================
 */
+( void ) colorScrambleTile: ( CCSprite * ) tileSprite {
    CCMutableTexture2D *tileTex = ( CCMutableTexture2D * ) tileSprite.texture;
    srand( time( NULL ) );
    for ( int i = 0; i < TILE_SIZE; i++ ) {
        for ( int j = 0; j < TILE_SIZE; j++ ) {
            //Color_t randomColor = random_color;
            //[ tileTex setPixelAt: ccp( i, j ) rgba: randomColor ];
        }
        [ tileTex fill: random_color ];
    }
    [ tileTex apply ];
}


/*
 ====================
 colorScrambleAllTiles
 ====================
 */
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray {
    for ( int i = 0; i < [ tileArray count ]; i++ ) {
        CCSprite *tileSprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer colorScrambleTile: tileSprite ];
    }
}


/*
 ====================
 setTile
 ====================
 */
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data {
    Tile_t tileType = data.tileType;
    
    // Select our primary working color based on tileType
    Color_t color =
    (tileType==TILE_FLOOR_VOID) ?  black :
    (tileType==TILE_FLOOR_UPSTAIRS) ? cyan :
    (tileType==TILE_FLOOR_DOWNSTAIRS) ? purple :
    (tileType==TILE_FLOOR_GRASS) ? green :
    (tileType==TILE_FLOOR_STONE) ? gray :
    blue ;
    
    if (  data.isSelected ) {
        Color_t tmpColor = newColor( color.r + 0xAA , color.g + 0xAA , color.b + 0x00, color.a );
        color = tmpColor;
    }
 
    // in most cases, we will fill our texture
    CCMutableTexture2D *texture = ( CCMutableTexture2D * ) tileSprite.texture;
    [ texture fill: color ];
    [ texture apply ];
    
    for (Entity *entity in data.contents) {
        if ( [[entity name] isEqualToString: @"Mike" ] ) {
            // draw on the texture
            if ( data.isSelected ) {
                [ texture fill: blue_alpha( 255 ) ];
                [ texture apply ];
            } else {
                [ texture fill: white ];
                [ texture apply ];
                
                /*
                for ( int i = 0; i < 8; i++ ) {
                    for ( int j = 0; j < 8; j++ ) {
                        [ texture setPixelAt: ccp(i, j) rgba: random_color ];
                        
                    }
                }
                 */
                
                //[texture apply ];
                
            }
        } else if ( [ [entity name] isEqualToString: @"Test1" ] ) {
            // Test1 will get rendered as colorFuzz
            for ( int i = 0; i < 16; i++ ) {
                for ( int j = 0; j < 16; j++ ) {
                    [ texture setPixelAt: ccp(i, j) rgba: random_color ];
                }
            }
            [ texture apply ];
        }
    }
}


/*
 ====================
 setAllTiles: withData
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data {
    for ( int i = 0; i < [tileArray count]; i++ ) {
        CCSprite *sprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer setTile: sprite withData: [ data objectAtIndex: i ] ];
    }
}


/*
 ====================
 setAllVisibleTiles: tileArray withDungeonFloor: floor withCamera: camera
 ====================
 */
+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor withCamera: ( CGPoint ) camera {
    //MLOG( @"setAllVisibleTiles: withDungeonFloor:" );
    CGPoint c = camera;
    for ( int j = 0; j < NUMBER_OF_TILES_ONSCREEN_Y; j++ ) {
        for ( int i = 0; i < NUMBER_OF_TILES_ONSCREEN_X; i++ ) {
            CCSprite *sprite = [ tileArray objectAtIndex: i+j*NUMBER_OF_TILES_ONSCREEN_X ];
            [ GameRenderer setTile: sprite withData: [ [floor tileDataArray] objectAtIndex: (i+c.x)+((j+c.y)*[floor width]) ] ];
        }
    }
}


/*
 ====================
 setAllTiles: withEntityData
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray withEntityData: ( NSArray * ) data {
    for ( int i = 0; i < [tileArray count]; i++ ) {
        CCSprite *sprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer setTile: sprite withData: [ data objectAtIndex: i ] ];
    }
}


/*
 ====================
 setTileArrayBoundary: floor toTileType: tileType withLevel: level
 ====================
 */
+( void ) setTileArrayBoundary: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level {

    Tile *tile = nil;
    // can set up to 5 levels
    //NSAssert( level >= 0 && level <= 5 , @"Level should be >=0 || <= 5" );
    //int level = 6;
    for ( int j = level-1; j < [floor height ]-(level-1); j++ ) {
        for ( int i = level-1; i < [floor width ]-(level-1); i++ ) {
            if ( (i == level-1 || i == [floor width]-level) ) {
                tile = [ [floor tileDataArray ] objectAtIndex: i + (j * [floor width]) ];
                tile.tileType = tileType;
            }
            if ( j == level-1 || j == [floor height ]-level ) {
                tile = [ [floor tileDataArray ] objectAtIndex: i + (j * [floor width ]) ];
                tile.tileType = tileType;
            }
        }
    }
}

/*
 ====================
 setDefaultTileArrayBoundary
 ====================
 */
+(void) setDefaultTileArrayBoundary: (DungeonFloor *) floor {
    [ GameRenderer setAllTilesInFloor: floor toTileType: TILE_FLOOR_VOID ];
}


/*
 ====================
 setTileAtPosition: position onFloor: floor toType: tileType
 ====================
 */
+(void) setTileAtPosition: (CGPoint) position onFloor: (DungeonFloor *) floor toType: (Tile_t) tileType {
    [((Tile *)[floor.tileDataArray objectAtIndex: position.x + ( position.y * floor.width) ]) setTileType: tileType ];
}


/*
 ====================
 setTile: tile toType: tileType
 ====================
 */
+(void) setTile: (Tile *) tile toType: (Tile_t) tileType {
    tile.tileType = tileType;
}


/*
 ====================
 setAllTiles: tileArray toTileType: tileType
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType {
    for ( Tile * tile in tileArray ) {
        tile.tileType = tileType;
    }
}

/*
 ====================
 setAllTilesInDungeon: dungeon toTileType: tileType
 ====================
 */
+( void ) setAllTilesInFloor: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType {
    [ GameRenderer setAllTiles: [floor tileDataArray] toTileType: tileType ];
}


/*
 ====================
 generateDungeonFloor: floor
 ====================
 */
+( void ) generateDungeonFloor: ( DungeonFloor * ) floor {
    [ GameRenderer generateDungeonFloor: floor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
}


/*
 ====================
 generateDungeonFloor: floor withAlgorithm: algorithm
 ====================
*/
+( void ) generateDungeonFloor:(DungeonFloor *)floor withAlgorithm: ( DungeonFloorAlgorithm_t ) algorithm {
    
    [ self setAllTilesInFloor: floor toTileType:TILE_FLOOR_VOID ];
    
    if ( algorithm == DF_ALGORITHM_T_LARGEROOM ) {
        
        [ self setAllTilesInFloor:floor toTileType:TILE_FLOOR_GRASS ];
    }
    
    else if ( algorithm == DF_ALGORITHM_T_ALGORITHM0 ) {
        
        // calc the top-left editable tile
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
        
        NSUInteger w = floor.width - floor.border;
        NSUInteger h = floor.height - floor.border;
        
        NSUInteger numTilesPlaced = 0;
        NSUInteger numTiles = 40;
        
        NSUInteger xo = 0;
        NSUInteger yo = 0;
        
        NSUInteger roll;
        NSUInteger totalRolls = 0;
        
        NSUInteger rerolls = 0;
        NSUInteger totalRerolls = 0;
        NSUInteger rerollTolerance = 100;
        NSUInteger toleranceBreaks = 0;
        
        const NSUInteger MAX_REROLLS = 4;
        NSUInteger prevroll[ MAX_REROLLS ];
        for ( int i = 0; i < MAX_REROLLS; i++ ) { prevroll[ i ] = -1; }
        
        NSMutableArray *placedTilesArray = [[ NSMutableArray alloc ] init ];
        NSMutableArray *triedTilesArray = [[ NSMutableArray alloc ] init ];
        
        // determine a tile-type as the base tile type to use
        Tile_t baseTileType;
        
        // roll a d4
        roll = rollDiceOnce(4);
        
        // determine tiletype based on roll
        if ( roll == 1 ) {
            baseTileType = TILE_FLOOR_GRASS;
        } else if ( roll == 2) {
            baseTileType = TILE_FLOOR_ICE;
        } else if ( roll == 3) {
            baseTileType = TILE_FLOOR_STONE;
        } else if ( roll == 4) {
            baseTileType = TILE_FLOOR_STONE;
        }
        
        
        CGPoint point = ccp( x, y );
        [ self setTileAtPosition:point onFloor:floor toType:baseTileType ];
        [ placedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
        numTilesPlaced++;
        
        
        for ( int i = numTilesPlaced; i < numTiles; i++ ) {
            
            BOOL willReroll = NO;
            
            // roll a d4
            roll = rollDiceOnce(4);
            totalRolls++;
            
            // handle the roll
            if ( roll == 1) {
                xo += 0;
                yo += -1;
            } else if ( roll == 2) {
                xo += 0;
                yo += 1;
            } else if ( roll == 3) {
                xo += -1;
                yo += 0;
            } else if ( roll == 4) {
                xo += 1;
                yo += 0;
            }
            
            CGPoint point = ccp( x+xo, y+yo );
            //MLOG( @"trying (%d, %d)...", x+xo, y+yo );
            // roll-checking
            // check if this value exists in our placedTilesArray
            NSValue *v = [ NSValue valueWithCGPoint: point ];
            
            for ( NSValue *p in triedTilesArray ) {
                if ( [p isEqualToValue: v ] ) {
                    willReroll = YES;
                    break;
                }
            }
            
            if ( !willReroll ) {
                for ( NSValue *p in placedTilesArray ) {
                    if ( [p isEqualToValue:v ] ) {
                        willReroll = YES;
                        break;
                    }
                }
            }
            
            // check to see if we are going out-of-bounds
            if ( !willReroll ) {
                willReroll = willReroll || (x+xo < x || y+yo < y) || (x+xo >= w+x || y+yo >= h+y );
            }
                
            if ( ! willReroll ) {
                
                Tile_t tileType = baseTileType;
                NSUInteger roll2 = rollDiceOnce(100);
                    
                if ( roll2 <= 5 ) {
                    // change the tileType
                    roll2 = rollDiceOnce(4);
                        
                    if ( roll2 == 1 ) {
                        tileType = TILE_FLOOR_GRASS;
                    } else if ( roll2 == 2 ) {
                        tileType = TILE_FLOOR_ICE;
                    } else if ( roll2 == 3 ) {
                        tileType = TILE_FLOOR_STONE;
                    } else if ( roll2 == 4 ) {
                        tileType = TILE_FLOOR_STONE;
                    }
                }
                    
                [ self setTileAtPosition:point onFloor:floor toType:tileType ];
                [ placedTilesArray addObject: v ];
                [ triedTilesArray removeAllObjects ];
                MLOG( @"tile placed at (%d,%d)", x+xo, y+yo );
                numTilesPlaced++;
            }
        
            else if ( willReroll ) {
                
                [ triedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
                
                // undo the roll
                if ( roll == 1) { yo++; }
                else if ( roll == 2) { yo--; }
                else if ( roll == 3) { xo++; }
                else if ( roll == 4) { xo--; }
                
                rerolls++;
                totalRerolls++;
                //MLOG( @"Reroll # %d", totalRerolls );
                i--;
                
                // check reroll tolerance
                if ( totalRerolls >= rerollTolerance ) {
                    xo = 0;
                    yo = 0;
                    i = 0;
                    [ placedTilesArray removeAllObjects ];
                    [ triedTilesArray removeAllObjects ];
                    totalRerolls = 0;
                    toleranceBreaks++;
                }
            }
        }
        
        MLOG( @"total tiles placed: %d" , numTilesPlaced );
        MLOG( @"total rolls: %d", totalRolls );
        MLOG( @"total rerolls: %d", totalRerolls );
        MLOG( @"total tolerance breaks: %d", toleranceBreaks );
        
        // place the upstairs/downstairs tiles
        BOOL isDownstairsPlaced = NO;
        BOOL isUpstairsPlaced = NO;
        
        while ( !isUpstairsPlaced ) {
            for ( NSValue *p in placedTilesArray ) {
                // roll dice
                roll = rollDiceOnce(100);
                NSUInteger percentage = 5;
                if ( roll <= percentage ) {
                    [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_UPSTAIRS ];
                    MLOG( @"Upstairs placed" );
                    isUpstairsPlaced = YES;
                    break;
                }
            }
        }
        
        CGPoint upstairsPoint = [ self getUpstairsTileForFloor: floor ];
        while ( !isDownstairsPlaced ) {
            for ( NSValue *p in placedTilesArray ) {
                roll = rollDiceOnce(100);
                NSUInteger percentage = 5;
                if ( roll <= percentage ) {
                    if ( ! CGPointEqualToPoint(upstairsPoint, p.CGPointValue) ) {
                        [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS];
                        MLOG( @"Downstairs placed" );
                        isDownstairsPlaced = YES;
                        break;
                    }
                }
            }
        }
    }
}


/*
 ====================
 getUpstairsTileForFloor: floor
 ====================
 */
+( CGPoint ) getUpstairsTileForFloor: ( DungeonFloor * ) floor {
    CGPoint p = { -1, -1 };
    for ( Tile *t in floor.tileDataArray ) {
        if ( t.tileType == TILE_FLOOR_UPSTAIRS ) {
            p = t.position;
            break;
        }
    }
    return p;
}


/*
 ====================
 getTileForFloor: floor forCGPoint: p
 ====================
 */
+( Tile * ) getTileForFloor: (DungeonFloor *) floor forCGPoint: (CGPoint) p {
    Tile *tile = nil;
    tile = [ floor.tileDataArray objectAtIndex: p.x + ( p.y * floor.width ) ];
    return tile;
}


/*
 ====================
 distanceFromTile: toTile:
 
 returns distance from a tile to another
 ====================
 */
+( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b {
    //MLOG( @"distanceFromTile: a toTile: b" );
    NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
    
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}

@end