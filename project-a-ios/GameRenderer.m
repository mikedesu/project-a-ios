//  GameRenderer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameRenderer.h"

@implementation GameRenderer


static BOOL modTableInitialized = NO;

static const NSInteger modTableSize = 50;
static NSInteger modTable[ modTableSize ];

void initModTable() {
    if ( ! modTableInitialized ) {
        NSInteger mod = -5;
        modTable[ 0 ] = mod;
        for (int i=1; i < modTableSize; i++) {
            if ( i % 2 == 0 ) {
                mod++;
            }
            modTable[ i ] = mod;
        }
        modTableInitialized = YES;
    }
}


NSInteger getMod( NSInteger n ) {
    if ( ! modTableInitialized ) {
        initModTable();
    }
    return modTable[ n ];
}



+( NSInteger ) modifierForNumber: (NSInteger) n {
    /*
    NSInteger mod =
    n <= 1 ? -5 :
    n <= 3 ? -4 :
    n <= 5 ? -3 :
    n <= 7 ? -2 :
    n <= 9 ? -1 :
    n <= 11 ? 0 :
    n <= 13 ? 1 :
    n <= 15 ? 2 :
    n <= 17 ? 3 :
    n <= 19 ? 4 :
    n <= 21 ? 5 :
    n <= 23 ? 6 :
    n <= 25 ? 7 :
    n <= 27 ? 8 :
    n <= 29 ? 9 :
    n <= 31 ? 10 :
    n <= 33 ? 11 :
    n <= 35 ? 12 :
    n <= 37 ? 13 :
    n <= 39 ? 14 :
    n <= 41 ? 15 :
    16
    ;
     */
    
    //return mod;
    
    return getMod( n );
}


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
    
    
    /*
    if ( [[data contents] count] > 0 ) {
        MLOG(@"Tile is not empty");
        MLOG(@"Tile contents: %@", [data contents]);
    }
    else {
    //    MLOG(@"Empty tile!");
    }
     */
    
    
    for (Entity *entity in [data contents]) {
        
        
        // Below, we define the draw routines for each entity-type
        // We are starting with solid colors
        // Next, we will upgrade to single-layer drawings
        // Last, we will upgrade to multi-layer drawings
        
        if ( entity.entityType == ENTITY_T_PC ) {
            // draw on the texture
            if ( data.isSelected ) {
                [ texture fill: blue_alpha( 255 ) ];
                [ texture apply ];
            } else {
                [ texture fill: white ];
                [ texture apply ];
                
                //MLOG(@"PC Entity drawn");
                
                
                //[texture apply ];
                
            }
        }
        
        else if ( [ [entity name] isEqualToString: @"Test1" ] ) {
            // Test1 will get rendered as colorFuzz
            for ( int i = 0; i < 16; i++ ) {
                for ( int j = 0; j < 16; j++ ) {
                    [ texture setPixelAt: ccp(i, j) rgba: random_color ];
                }
            }
            [ texture apply ];
        }
        
        else if ( entity.entityType == ENTITY_T_NPC ) {
            color = red;
            if ( data.isSelected ) {
                color = newColor(color.r, color.g, color.b + 0xff, color.a);
                [ texture fill: color ];
                
            } else {
                [ texture fill: color ];
            }
            
            [ texture apply ];
        }
        
        
        else if ( entity.entityType == ENTITY_T_ITEM ) {
             color = yellow;
            if ( data.isSelected ) {
                color = newColor(color.r, color.g, color.b + 0xff, color.a);
                [ texture fill: color ];
                
            } else {
                [ texture fill: color ];
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
        //MLOG(@"j = %d", j);
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
    MLOG(@"generateDungeonFloor");
    
    [ self setAllTilesInFloor: floor toTileType:TILE_FLOOR_VOID ];
    
    if ( algorithm == DF_ALGORITHM_T_LARGEROOM ) {
        
        [ self setAllTilesInFloor:floor toTileType:TILE_FLOOR_GRASS ];
    }
    
    else if ( algorithm == DF_ALGORITHM_T_ALGORITHM0 ||
              algorithm == DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR
             ) {
        
        // profiling
        //CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
        
        
        // calc the top-left editable tile
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
        
        NSUInteger w = floor.width - floor.border;
        NSUInteger h = floor.height - floor.border;
        
        NSUInteger numTilesPlaced = 0;
        NSUInteger maxTilesPlaced = 0;
        //NSUInteger numTiles = rollDice(10, 10) + 10;
        NSUInteger numTiles = [Dice roll:10 nTimes:10] + 10;
        
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
        
        BOOL doPrintMaxTiles = NO;
        
        // determine a tile-type as the base tile type to use
        Tile_t baseTileType;
        
        // roll a d4
        //roll = rollDiceOnce(4);
        roll = [Dice roll:4];
        
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
            //roll = rollDiceOnce(4);
            roll = [Dice roll:4];
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
                //NSUInteger roll2 = rollDiceOnce(100);
                NSUInteger roll2 = [Dice roll:100];
                
                if ( roll2 <= 5 ) {
                    // change the tileType
                    //roll2 = rollDiceOnce(4);
                    roll2 = [Dice roll:4];
                    
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
                //MLOG( @"tile placed at (%d,%d)", x+xo, y+yo );
                numTilesPlaced++;
                //maxTilesPlaced = ( maxTilesPlaced > numTilesPlaced ) ? maxTilesPlaced : numTilesPlaced;
                if ( maxTilesPlaced > numTilesPlaced ) {
                    maxTilesPlaced = maxTilesPlaced;
                }
                else {
                    maxTilesPlaced = numTilesPlaced;
                    doPrintMaxTiles = YES;
                }
                
                //if ( maxTilesPlaced % 10 == 0 )
                //if ( doPrintMaxTiles ) {
                    //MLOG( @"maxTilesPlaced: %d", maxTilesPlaced );
                //    doPrintMaxTiles = NO;
                //}
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
                      //  MLOG( @"tolerance break %d", toleranceBreaks );
                    xo = 0;
                    yo = 0;
                    
                    [ placedTilesArray removeAllObjects ];
                    [ triedTilesArray removeAllObjects ];
                    
                    numTilesPlaced = 0;
                    
                    CGPoint point = ccp( x, y );
                    [ self setTileAtPosition:point onFloor:floor toType:baseTileType ];
                    [ placedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
                    numTilesPlaced++;
                    
                    i = numTilesPlaced;
                    
                    totalRerolls = 0;
                    toleranceBreaks++;
                }
            }
        }
        
        MLOG( @"total tiles placed: %d" , numTilesPlaced );
        MLOG( @"total rolls: %d", totalRolls );
        MLOG( @"total rerolls: %d", totalRerolls );
        MLOG( @"total tolerance breaks: %d", toleranceBreaks );
        
        //CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        //CFAbsoluteTime totalTimeSpent = (end - start) * 1000;
        //MLOG( @"method took %f ms", totalTimeSpent );
        
        // place the upstairs/downstairs tiles
        BOOL isDownstairsPlaced = NO;
        BOOL isUpstairsPlaced = NO;
        
        while ( !isUpstairsPlaced ) {
            for ( NSValue *p in placedTilesArray ) {
                // roll dice
                //roll = rollDiceOnce(100);
                roll = [Dice roll:100];
                NSUInteger percentage = 5;
                if ( roll <= percentage ) {
                    [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_UPSTAIRS ];
                    //MLOG( @"Upstairs placed" );
                    isUpstairsPlaced = YES;
                    break;
                }
            }
        }
        
        CGPoint upstairsPoint = [ self getUpstairsTileForFloor: floor ];
        
        if ( algorithm != DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR ) {
            while ( !isDownstairsPlaced ) {
                for ( NSValue *p in placedTilesArray ) {
                    //roll = rollDiceOnce(100);
                    roll = [Dice roll:100];
                    NSUInteger percentage = 5;
                    if ( roll <= percentage ) {
                        if ( ! CGPointEqualToPoint(upstairsPoint, p.CGPointValue) ) {
                            [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS];
                            //MLOG( @"Downstairs placed" );
                            isDownstairsPlaced = YES;
                            break;
                        }
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
    for ( Tile *t in [floor tileDataArray] ) {
        if ( t.tileType == TILE_FLOOR_UPSTAIRS ) {
            p = t.position;
            break;
        }
    }
    return p;
}


/*
 ====================
 getDownstairsTileForFloor: floor
 ====================
 */
+( CGPoint ) getDownstairsTileForFloor: ( DungeonFloor * ) floor {
    CGPoint p = { -1, -1 };
    for ( Tile *t in [floor tileDataArray] ) {
        if ( t.tileType == TILE_FLOOR_DOWNSTAIRS ) {
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




#pragma mark - Entity-spawning code

/*
 ====================
 
 ====================
 */
+( Entity * ) randomEntity {
    Entity *e = [[Entity alloc] init];
    
    [e.name setString:@"EntityName"];
    e.entityType = ENTITY_T_VOID;
    e.isPC = NO;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
     
    //e.maxhp = rollDiceOnce(10);
    e.maxhp = [Dice roll:10];
    e.hp = e.maxhp;
 
    e.alignment = ENTITYALIGNMENT_T_CHAOTIC_EVIL;
    
    return e;
}


/*
 ====================
 
 ====================
 */
+( Entity * ) randomItem {
    Entity *e = [[Entity alloc] init];
    
    e.entityType = ENTITY_T_ITEM;
    e.isPC = NO;
    [e.name setString: [self generateNameForEntityType: e.entityType ] ];
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    return e;
}





/*
 ====================
 
 ====================
 */
+( Entity * ) randomMonster {
    Entity *e = [[Entity alloc] init];
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
    [e.name setString: [self generateNameForEntityType:e.entityType]];
 //   [e.name setString: randomString ];
    
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    return e;
}

/*
 ====================
 
 ====================
 */
+( Entity * ) randomMonsterForFloor: (DungeonFloor *) floor {
    
    // calc a level in range of floorNumber
    //NSUInteger randomLevel = rollDiceOnce( floor.floorNumber );
    NSUInteger randomLevel = [Dice roll: floor.floorNumber];
    NSUInteger mod =
    floor.floorNumber <= 4 ?  0 :
    floor.floorNumber <= 8 ?  1 :
    floor.floorNumber <= 12 ? 2 :
    floor.floorNumber <= 16 ? 3 :
    floor.floorNumber <= 20 ? 4 :
    5;
 
    NSUInteger calculatedLevel = randomLevel + mod;
    
    Entity *e = [[Entity alloc] initWithLevel: calculatedLevel ];
    
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
    //NSUInteger roll = rollDiceOnce(4);
    NSUInteger roll = [Dice roll:4];
    if ( roll == 1 ) {
        [randomString setString:@"Goblin"];
    } else if ( roll == 2 ) {
        [randomString setString:@"Dwarf"];
    } else if ( roll == 3 ) {
        [randomString setString:@"Kobold"];
    } else if ( roll == 4 ) {
        [randomString setString:@"Imp"];
    }
    //[e.name setString: [self generateNameForEntityType: e.entityType ] ];
    [e.name setString: randomString ];
    
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    MLOG(@"spawned %@ with level %u", e.name, calculatedLevel );
    return e;
}












/*
 ====================
 
 ====================
 */
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor {
    
    BOOL locationIsAcceptable = NO;
    Tile *spawnTile = nil;
    
    while ( ! locationIsAcceptable ) {
        
        //NSUInteger diceroll = rollDiceOnce( [[floor tileDataArray] count] ) - 1;
        NSUInteger diceroll = [Dice roll: [[floor tileDataArray] count]] - 1;
        
        
        
        Tile *tile = [[ floor tileDataArray ] objectAtIndex: diceroll ];
        if ( tile.tileType != TILE_FLOOR_VOID &&
                 tile.tileType != TILE_FLOOR_UPSTAIRS &&
                 tile.tileType != TILE_FLOOR_DOWNSTAIRS
                ) {
                
                
                BOOL tileIsFree = YES;
                
                // check if a pc/npc occupies the tile contents
                for ( Entity *e in tile.contents ) {
                    
                    if ( e.entityType == ENTITY_T_PC ||
                        e.entityType == ENTITY_T_NPC ) {
                        
                        tileIsFree = NO;
                        break;
                    }
                    
                }
                
                
                if ( tileIsFree ) {
                    spawnTile = tile;
                    locationIsAcceptable = YES;
                    break;
                }
        }
        
    }
    
    if ( spawnTile != nil ) {
        [ GameRenderer setEntity: entity onTile: spawnTile ];
        [[ floor entityArray ] addObject: entity];
    }
}


/*
 ====================
 
 ====================
 */
+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc {
    
    [ self spawnRandomMonsterAtRandomLocationOnFloor:floor withPC:pc withChanceDie: 100 ];
    
    /*
    NSUInteger spawnChancePercent = 1;
    NSUInteger diceroll = [Dice roll:100];
    
    if ( diceroll <= spawnChancePercent ) {
        
        //Entity *e = [ GameRenderer randomMonsterForPC: pc ];
        Entity *e = [ GameRenderer randomMonsterForFloor:floor ];
        [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
        
    }
     */
}

+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc withChanceDie: (NSInteger) chanceDie {
    
    NSUInteger spawnChancePercent = 1;
    NSUInteger diceroll = [Dice roll:chanceDie];
    
    if ( diceroll <= spawnChancePercent ) {
        
        //Entity *e = [ GameRenderer randomMonsterForPC: pc ];
        Entity *e = [ GameRenderer randomMonsterForFloor:floor ];
        [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
        
    }
}






/*
 ====================
 
 ====================
 */
+( void ) spawnRandomItemAtRandomLocationOnFloor: (DungeonFloor *) floor {
    Entity *e = [ GameRenderer randomItem ];
    [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
}







#pragma mark - Entity code

/*
 ====================
 setEntity: entity onTile: tile
 ====================
 */
+( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile {
    entity.positionOnMap = tile.position;
    //[ tile.contents addObject: entity ];
    [ tile addObjectToContents: entity ];
}




/*
 ====================
 generateName
 
 returns a name
 ====================
 */
+( NSString * ) generateNameForEntityType: (EntityTypes_t) type {
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
    if (type == ENTITY_T_NPC) {
        
        NSInteger nameLen = 8;
        NSString *alphanumeric = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for ( int i = 0; i < nameLen ; i++ ) {
            //[ randomString appendString: [alphanumeric substringWithRange:NSMakeRange(rollDiceOnce([alphanumeric length])-1, 1)] ];
            [ randomString appendString: [alphanumeric substringWithRange:NSMakeRange([Dice roll:[alphanumeric length]]-1, 1)] ];
        }
    }
    else if ( type == ENTITY_T_ITEM ) {
        [randomString setString:@"Book of All-Knowing" ];
    }
    
    return [ NSString stringWithString: randomString ];
}


@end