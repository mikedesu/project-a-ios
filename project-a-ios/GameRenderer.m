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
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data withSprites: (NSDictionary *) sprites {
//+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data {
    Tile_t tileType = data.tileType;
 
    CCMutableTexture2D *tileTexture =
    tileType == TILE_FLOOR_STONE          ? [sprites objectForKey:@"StoneTile"]      :
    tileType == TILE_FLOOR_VOID           ? [sprites objectForKey:@"VoidTile"]       :
    tileType == TILE_FLOOR_UPSTAIRS       ? [sprites objectForKey:@"UpstairsTile"]   :
    tileType == TILE_FLOOR_DOWNSTAIRS     ? [sprites objectForKey:@"DownstairsTile"] :
    tileType == TILE_FLOOR_WATER          ? [sprites objectForKey:@"WaterTile"]      :
                                             nil;
    
    // in most cases, we will fill our texture
    CCMutableTexture2D *texture = ( CCMutableTexture2D * ) tileSprite.texture;
    for ( int i = 0; i < 16; i++ ) {
        for ( int j = 0; j < 16; j++ ) {
            tileTexture != nil ? [texture setPixelAt:ccp(i,j) rgba:[tileTexture pixelAt:ccp(i,j)]] : 0;
        }
    }
    [ texture apply ];
    
    CCMutableTexture2D *t = nil;
    
    for (Entity *entity in [data contents]) {
        // Below, we define the draw routines for each entity-type
        // We are starting with solid colors
        // Next, we will upgrade to single-layer drawings
        // Last, we will upgrade to multi-layer drawings
        
        if ( entity.entityType == ENTITY_T_PC ) {
            t = [sprites objectForKey: @"Hero"];
        } else if ( [ [entity name] isEqualToString: @"Test1" ] ) {
            // Test1 will get rendered as colorFuzz
            for ( int i = 0; i < 16; i++ )
                for ( int j = 0; j < 16; j++ )
                    [ texture setPixelAt: ccp(i, j) rgba: random_color ];
            [ texture apply ];
        } else if ( entity.entityType == ENTITY_T_NPC ) {
            
            if (entity.monsterType == MONSTER_T_GHOUL) {
                t = [sprites objectForKey: @"Ghoul"];
            
                if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@""] ||
                 [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Weak"]
                ) {
                    t = [sprites objectForKey: @"Ghoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Fire"] ) {
                    t = [sprites objectForKey: @"FireGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Ice"] ) {
                    t = [sprites objectForKey: @"IceGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Water"] ) {
                    t = [sprites objectForKey: @"WaterGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Earth"] ) {
                    t = [sprites objectForKey: @"EarthGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Lightning"] ) {
                    t = [sprites objectForKey: @"LightningGhoul"];
                }
            } else if ( entity.monsterType == MONSTER_T_CAT ) {
                t = [sprites objectForKey:@"Cat"];
            } else if ( entity.monsterType == MONSTER_T_TOTORO ) {
                t = [sprites objectForKey:@"Totoro"];
            }
            
            for ( int i = 0; i < 16; i++ )
                for ( int j = 0; j < 16; j++ )
                    if ( [t pixelAt:ccp(i,j)].a != 0 )
                        [texture setPixelAt:ccp(i,j) rgba:[t pixelAt:ccp(i,j)]];
            [texture apply];
        } else if ( entity.entityType == ENTITY_T_ITEM ) {
            
            if ( entity.itemType == E_ITEM_T_WEAPON ) {
                t = [sprites objectForKey:@"ShortSword"];
            } else if ( entity.itemType == E_ITEM_T_ARMOR ) {
                t = [sprites objectForKey:@"LeatherArmor"];
            }
            
            // only one book so far...
            else if ( entity.itemType == E_ITEM_T_BOOK ) {
                t = [sprites objectForKey:@"BookOfAllKnowing"];
            }
            
            // potions
            else if ( entity.itemType == E_ITEM_T_POTION ) {
                t = [sprites objectForKey:@"PotionOfLightHealing"];
            }
            
            // food
            else if ( entity.itemType == E_ITEM_T_FOOD ) {
                t = [sprites objectForKey:@"SmallBlob"];
            }
            
            // fish
            else if ( entity.itemType == E_ITEM_T_FISH ) {
                if ( [entity.name isEqualToString:@"Catfish"] ) {
                    t = [sprites objectForKey:@"Catfish"];
                }
            }
            
            else if ( entity.itemType == E_ITEM_T_FISHING_ROD ) {
                if ( [entity.name isEqualToString:@"Wooden Fishing Rod"] ) {
                    t = [sprites objectForKey:@"WoodenFishingRod"];
                }
            }
            
            else if ( entity.itemType == E_ITEM_T_BASICBOULDER ) {
                t = [sprites objectForKey:@"BasicBoulder"];
            }
            
            else if ( entity.itemType == E_ITEM_T_DOOR_SIMPLE ) {
                t = (! entity.doorOpen) ? [sprites objectForKey:@"SimpleDoorClosed"] : [sprites objectForKey:@"SimpleDoorOpen"];
            }
        }
    }
 
    if ( t != nil ) {
        for ( int i = 0; i < 16; i++ )
            for ( int j = 0; j < 16; j++ )
                ( [t pixelAt:ccp(i,j)].a != 0 ) ? [texture setPixelAt:ccp(i,j) rgba:[t pixelAt:ccp(i,j)]] : 0;
        [texture apply];
    }
    
    // handle selected tiles
    if ( data.isSelected && tileTexture != nil ) {
        for ( int i = 0; i < 16; i++ )
            for ( int j = 0; j < 16; j++ ) {
                Color_t px = [texture pixelAt:ccp(i,j)];
                px.a = 128;
                [texture setPixelAt:ccp(i,j) rgba:px];
            }
    }
    [texture apply];
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
+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor withCamera: ( CGPoint ) camera withSprites:(NSDictionary *)sprites {
    CGPoint c = camera;
    for ( int j = 0; j < NUMBER_OF_TILES_ONSCREEN_Y; j++ ) {
        for ( int i = 0; i < NUMBER_OF_TILES_ONSCREEN_X; i++ ) {
            CCSprite *sprite = [ tileArray objectAtIndex: i+j*NUMBER_OF_TILES_ONSCREEN_X ];
            [ GameRenderer setTile: sprite withData: [ [floor tileDataArray] objectAtIndex: (i+c.x)+((j+c.y)*[floor width]) ] withSprites: sprites ];
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
        [self largeRoomAlgorithm:floor];
    } else if ( algorithm == DF_ALGORITHM_T_ALGORITHM0 ||
              algorithm == DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR
             ) {
        [ self algorithm0:algorithm withFloor:floor ];
    }
}

+(void) largeRoomAlgorithm: (DungeonFloor *) floor {
    [ self setAllTilesInFloor:floor toTileType:TILE_FLOOR_STONE ];
}

+(void) algorithm0: (DungeonFloorAlgorithm_t) algorithm withFloor: (DungeonFloor *) floor {
        // calc the top-left editable tile
        NSUInteger x = floor.border/2;
        NSUInteger y = floor.border/2;
        NSUInteger w = floor.width - floor.border;
        NSUInteger h = floor.height - floor.border;
        
        NSUInteger numTilesPlaced = 0;
        NSUInteger maxTilesPlaced = 0;
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
        
        baseTileType = TILE_FLOOR_STONE;
        
        CGPoint point = ccp( x, y );
        [ self setTileAtPosition:point onFloor:floor toType:baseTileType ];
        [ placedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
        numTilesPlaced++;
        
        for ( int i = numTilesPlaced; i < numTiles; i++ ) {
            BOOL willReroll = NO;
            
            
            //roll = [Dice roll:4];
            //roll = [Dice roll:8];
            
            // handle the roll
            /*
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
            } else if ( roll == 5 ) {
                xo += -1;
                yo += -1;
            } else if ( roll == 6 ) {
                xo += 1;
                yo += -1;
            } else if ( roll == 7 ) {
                xo += -1;
                yo += 1;
            } else if ( roll == 8 ) {
                xo += 1;
                yo += 1;
            }
             */
            
            // direction type
            // 0 = standard : ULDR
            // 1 = cross    : UL UR DL DR
            // 2 = mix      : 0 + 1
            NSInteger dirType = 1;
            //NSInteger dirType = [Dice roll:3];
            if ( dirType == 1 ) {
                roll = [Dice roll:4];
                xo +=
                roll == 1 || roll == 2  ?  0  :
                roll == 3               ? -1  :
                roll == 4               ?  1  :
                0;
                
                yo +=
                roll == 1              ? -1  :
                roll == 2              ?  1  :
                roll == 3 || roll == 4 ?  0  :
                0;
                
            } else if ( dirType == 2 ) {
                roll = [Dice roll:4];
                xo +=
                roll == 1 || roll == 3 ? -1  :
                roll == 2 || roll == 4 ?  1  :
                0;
                
                yo +=
                roll == 1 || roll == 2 ? -1  :
                roll == 3 || roll == 4 ?  1  :
                0;
                
            } else if ( dirType == 3 ) {
                roll = [Dice roll:8];
                xo +=
                roll == 1 || roll == 2              ?  0  :
                roll == 3 || roll == 5 || roll == 7 ? -1  :
                roll == 4 || roll == 6 || roll == 8 ?  1  :
                0;
                
                yo +=
                roll == 1 || roll == 5 || roll == 6 ? -1  :
                roll == 2 || roll == 7 || roll == 8 ?  1  :
                roll == 3 || roll == 4              ?  0  :
                0;
            }
            totalRolls++;
            
            CGPoint point = ccp( x+xo, y+yo );
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
                
                NSInteger tileRoll = [Dice roll:100];
                NSInteger waterChance = 5;
                tileType = (tileRoll <= waterChance) ? TILE_FLOOR_WATER : tileType;
                
                
                [ self setTileAtPosition:point onFloor:floor toType:tileType ];
                [ placedTilesArray addObject: v ];
                [ triedTilesArray removeAllObjects ];
                numTilesPlaced++;
                if ( maxTilesPlaced > numTilesPlaced ) {
                    maxTilesPlaced = maxTilesPlaced;
                }
                else {
                    maxTilesPlaced = numTilesPlaced;
                    doPrintMaxTiles = YES;
                }
            } else if ( willReroll ) {
                [ triedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
                
                // undo the roll
                roll == 1 ? yo++ :
                roll == 2 ? yo-- :
                roll == 3 ? xo++ :
                roll == 4 ? xo-- : 0;
                
                rerolls++;
                totalRerolls++;
                i--;
                
                // check reroll tolerance
                if ( totalRerolls >= rerollTolerance ) {
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
    
    /*
        MLOG( @"total tiles placed: %d" , numTilesPlaced );
        MLOG( @"total rolls: %d", totalRolls );
        MLOG( @"total rerolls: %d", totalRerolls );
        MLOG( @"total tolerance breaks: %d", toleranceBreaks );
      */
    
        // place the upstairs/downstairs tiles
        BOOL isDownstairsPlaced = NO;
        BOOL isUpstairsPlaced = NO;
        
        while ( !isUpstairsPlaced ) {
            for ( NSValue *p in placedTilesArray ) {
                // roll dice
                roll = [Dice roll:100];
                NSUInteger percentage = 5;
                if ( roll <= percentage ) {
                    [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_UPSTAIRS ];
                    isUpstairsPlaced = YES;
                    break;
                }
            }
        }
        
        CGPoint upstairsPoint = [ self getUpstairsTileForFloor: floor ];
        
        if ( algorithm != DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR ) {
            while ( !isDownstairsPlaced ) {
                for ( NSValue *p in placedTilesArray ) {
                    roll = [Dice roll:100];
                    NSUInteger percentage = 5;
                    if ( roll <= percentage ) {
                        if ( ! CGPointEqualToPoint(upstairsPoint, p.CGPointValue) ) {
                            [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS];
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
 randomEntity
 ====================
 */
+( Entity * ) randomEntity {
    Entity *e = [[Entity alloc] init];
    
    [e.name setString:@"EntityName"];
    e.entityType = ENTITY_T_VOID;
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
     
    e.maxhp = [Dice roll:10];
    e.hp = e.maxhp;
    e.alignment = ENTITYALIGNMENT_T_CHAOTIC_EVIL;
    return e;
}


/*
 ====================
 randomItem
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
 randomMonster
 ====================
 */
+( Entity * ) randomMonster {
    //MLOG(@"randomMonster");
    Entity *e = [[Entity alloc] init];
    [e.name setString: [self generateNameForEntityType:e.entityType]];
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}

/*
 ====================
 randomMonsterForFloor: floor
 ====================
 */
+( Entity * ) randomMonsterForFloor: (DungeonFloor *) floor {
    // calc a level in range of floorNumber
    NSUInteger randomLevel = [Dice roll: floor.floorNumber];
    NSUInteger mod =
    floor.floorNumber <= 4  ?  0 :
    floor.floorNumber <= 8  ?  1 :
    floor.floorNumber <= 12 ?  2 :
    floor.floorNumber <= 16 ?  3 :
    floor.floorNumber <= 20 ?  4 :
    5;
 
    NSUInteger calculatedLevel = randomLevel + mod;
    NSInteger randomHitDie = [Dice roll:12] + mod;
    
    Entity *e = [[Entity alloc] initWithLevel: calculatedLevel withHitDie:randomHitDie ];
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
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
    
    [e.name setString: randomString ];
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}

/*
 ====================
 spawnEntityAtRandomLocation: entity onFloor: floor
 ====================
 */
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor {
    BOOL locationIsAcceptable = NO;
    Tile *spawnTile = nil;
    
    while ( ! locationIsAcceptable ) {
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

+( void ) spawnEntity: (Entity *) entity onFloor: (DungeonFloor *) floor atLocation: (CGPoint) location {
    Tile *tile = nil;
    for (Tile *t in [floor tileDataArray]) {
        if ( location.x == t.position.x && location.y == t.position.y ) {
            tile = t;
            break;
        }
    }
    BOOL g =    tile != nil &&
                tile.tileType != TILE_FLOOR_VOID &&
                tile.tileType != TILE_FLOOR_UPSTAIRS &&
                tile.tileType != TILE_FLOOR_DOWNSTAIRS;
    if ( ! g ) return;
    
    // check if a pc/npc occupies the tile contents
    BOOL tileIsFree = YES;
    for ( Entity *e in tile.contents ) {
        tileIsFree = ! ( e.entityType == ENTITY_T_PC || e.entityType == ENTITY_T_NPC );
        if ( ! tileIsFree ) break;
    }
    if ( tileIsFree ) {
        [GameRenderer setEntity:entity onTile:tile];
        [[floor entityArray] addObject: entity];
    }
}

/*
 ====================
 spawnRandomMonsterAtRandomLocationOnFloor: floor withPC: pc
 ====================
 */
+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc {
    [ self spawnRandomMonsterAtRandomLocationOnFloor:floor withPC:pc withChanceDie: 1 ];
}

+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc withChanceDie: (NSInteger) chanceDie {
    NSUInteger spawnChancePercent = 1;
    NSUInteger diceroll = chanceDie == 1 ? 1 : [Dice roll:chanceDie];
    
    if ( diceroll <= spawnChancePercent ) {
        Entity *e;
        
        // set number of monsterTypes
        NSUInteger numMonsterTypes = 3;
        NSUInteger m0 = [Dice roll: numMonsterTypes];
        
        // define monsters to spawn below
        e =
        ( m0 == 1 ) ? Cat :
        ( m0 == 2 ) ? Ghoul :
        ( m0 == 3 ) ? Totoro :
        Cat;
        
        //MLOG(@"Spawned %@", e.name);
        // level up monster appropriately
        NSInteger levelRoll = [Dice roll: floor.floorNumber + 1];
        for (int i=e.level; i<levelRoll; i++)
            [e handleLevelUp];
        
        [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
    }
}

/*
 ====================
 spawnRandomItemAtRandomLocationOnFloor: floor
 ====================
 */
+( void ) spawnRandomItemAtRandomLocationOnFloor: (DungeonFloor *) floor {
    Entity *e = [ Items randomItem ];
    [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
}

/*
 ====================
 spawnBookOfAllKnowingAtRandomLocationOnFloor: floor
 ====================
 */
+( void ) spawnBookOfAllKnowingAtRandomLocationOnFloor: (DungeonFloor *) floor {
    Entity *e = [ Items bookOfAllKnowing ];
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