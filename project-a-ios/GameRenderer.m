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


+(void) setDefaultTileArrayBoundary: (DungeonFloor *) floor {
    [ GameRenderer setAllTilesInFloor: floor toTileType: TILE_FLOOR_VOID ];
    /*
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 1 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 2 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 3 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 4 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 5 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 6 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 7 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 8 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 9 ];
    [ GameRenderer setTileArrayBoundary: floor toTileType: TILE_FLOOR_VOID withLevel: 10 ];
     */
}


+(void) setTileAtPosition: (CGPoint) position onFloor: (DungeonFloor *) floor toType: (Tile_t) tileType {
    [((Tile *)[floor.tileDataArray objectAtIndex: position.x + ( position.y * floor.width) ]) setTileType: tileType ];
}

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
    //[ GameRenderer generateDungeonFloor: floor withAlgorithm: DF_ALGORITHM_T_SMALLROOM ];
    [ GameRenderer generateDungeonFloor: floor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
    
    /*
    [ GameRenderer setTileAtPosition:ccp(10,10) onFloor:floor toType:TILE_FLOOR_GRASS];
    [ GameRenderer setTileAtPosition:ccp(10,11) onFloor:floor toType:TILE_FLOOR_GRASS];
    [ GameRenderer setTileAtPosition:ccp(10,12) onFloor:floor toType:TILE_FLOOR_GRASS];
    [ GameRenderer setTileAtPosition:ccp(10,13) onFloor:floor toType:TILE_FLOOR_GRASS];
    [ GameRenderer setTileAtPosition:ccp(10,14) onFloor:floor toType:TILE_FLOOR_GRASS];
    
    [ GameRenderer setTileAtPosition:ccp(10,10) onFloor:floor toType:TILE_FLOOR_UPSTAIRS];
    [ GameRenderer setTileAtPosition:ccp(10,14) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS];
     */
}



+( void ) generateDungeonFloor:(DungeonFloor *)floor withAlgorithm: ( DungeonFloorAlgorithm_t ) algorithm {
    
    [ self setAllTilesInFloor: floor toTileType:TILE_FLOOR_VOID ];
    
    //[ GameRenderer setDefaultTileArrayBoundary: floor ];
    
    if ( algorithm == DF_ALGORITHM_T_SMALLROOM ) {
        
        // calc the top-left editable tile
        // border + 0, border + 0
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
 
        //NSUInteger localWidth = floor.width - floor.border;
        NSUInteger localWidth = 3;
        //NSUInteger localHeight = floor.height - floor.border;
        NSUInteger localHeight = 3;
        
        for ( int i = 0; i < localWidth; i++ ) {
            for ( int j = 0; j < localHeight; j++ ) {
                [ self setTileAtPosition:ccp(x+i, y+j) onFloor:floor toType:TILE_FLOOR_GRASS];
            }
        }
        
    }
    
    else if ( algorithm == DF_ALGORITHM_T_LARGEROOM ) {
        
        // calc the top-left editable tile
        // border + 0, border + 0
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
        
        //NSUInteger localWidth = floor.width - floor.border;
        NSUInteger localWidth = 10;
        //NSUInteger localHeight = floor.height - floor.border;
        NSUInteger localHeight = 10;
        
        for ( int i = 0; i < localWidth; i++ ) {
            for ( int j = 0; j < localHeight; j++ ) {
                [ self setTileAtPosition:ccp(x+i, y+j) onFloor:floor toType:TILE_FLOOR_GRASS];
            }
        }
        
    }
    
    else if ( algorithm == DF_ALGORITHM_T_ALGORITHM0 ) {
        
        // calc the top-left editable tile
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
        
        NSUInteger w = floor.width - floor.border;
        NSUInteger h = floor.height - floor.border;
        
        NSUInteger numTiles = 100;
        
        NSUInteger xo = 0;
        NSUInteger yo = 0;
        
        for ( int i = 0; i < numTiles; i++ ) {
            
            // roll a d4
            NSUInteger roll;
            //do {
                roll = rollDiceOnce(4);
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
           // }
            //while ( (x+xo < x || y+yo < y) || (x+xo > x+w || y+yo > y+h) );
                //MLOG(@"(%d,%d)", x+xo, y+yo);
            
            
            if ( x+xo < x || y+yo < y ) {
                MLOG(@"upper collision");
                
                // undo the roll
                if ( roll == 1) { yo++; }
                else if ( roll == 2) { yo--; }
                else if ( roll == 3) { xo++; }
                else if ( roll == 4) { xo--; }
                
                i--;
            }
            
            else if ( x+xo > x+w || y+yo > y+h ) {
                MLOG(@"lower collision");
                // undo the roll
                if ( roll == 1) { yo++; }
                else if ( roll == 2) { yo--; }
                else if ( roll == 3) { xo++; }
                else if ( roll == 4) { xo--; }
                i--;
            }
             
            
            else {
                [ self setTileAtPosition:ccp(x + xo, y + yo) onFloor:floor toType:TILE_FLOOR_GRASS];
            }
        }
    }
}

@end