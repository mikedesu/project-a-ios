//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "Dice.h"
#import "GameLayer.h"
#import "Version.h"
#import <mach/mach.h> // for reporting memory info


// used for reporting memory used in-game
unsigned get_memory_bytes(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t) &info, &size );
    return kerr == KERN_SUCCESS ? info.resident_size : 0;
}

unsigned get_memory_kb(void) {
    return get_memory_bytes() >> 10;
}

unsigned get_memory_mb(void) {
    return get_memory_kb() >> 10;
}


@implementation GameLayer

@synthesize gameState;
@synthesize turnCounter;

/*
 ====================
 scene
 
 returns a CCScene for this layer
 ====================
 */
+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}


-(void) loadSprites {
    
    sprites = [NSMutableDictionary dictionary];
    NSMutableDictionary *s = sprites;
    
    [s setObject:[Drawer heroForPC:pcEntity]                                forKey: @"Hero"];
    
    [s setObject:[Drawer door:brown knob:yellow]                               forKey: @"SimpleDoorClosed"];
    [s setObject:[Drawer opendoor:brown knob:yellow]                               forKey: @"SimpleDoorOpen"];
    
    [s setObject:[Drawer key: yellow]                               forKey: @"SimpleKey"];
    
    // Tiles
    
    [s setObject:[Drawer voidTile]                                          forKey: @"VoidTile"];
    [s setObject:[Drawer stoneTile]                                         forKey: @"StoneTile"];
    [s setObject:[Drawer stoneTileTrap]                                         forKey: @"StoneTileTrap"];
    [s setObject:[Drawer upstairsTile]                                      forKey: @"UpstairsTile"];
    [s setObject:[Drawer downstairsTile]                                    forKey: @"DownstairsTile"];
    [s setObject:[Drawer flatTile: blue]                                    forKey: @"WaterTile"];
    
    // Monsters
    
    // unused...yet...
    //[s setObject:[Drawer wyvern:orange eyes:black]                               forKey: @"Cat"];
    //[s setObject:[Drawer gelatinousCube:orange]                               forKey: @"Cat"];
    //[s setObject:[Drawer triangle:orange]                               forKey: @"Cat"];
    
    [s setObject:[Drawer cat:black eyes:yellow]                               forKey: @"Cat"];
    
    [s setObject:[Drawer ghoulWithBody: green]                              forKey: @"Ghoul"];
    [s setObject:[Drawer ghoulWithBody: red]                                forKey: @"FireGhoul"];
    [s setObject:[Drawer ghoulWithBody: blue]                               forKey: @"IceGhoul"];
    [s setObject:[Drawer ghoulWithBody: yellow]                             forKey: @"LightningGhoul"];
    [s setObject:[Drawer ghoulWithBody: lightblue]                          forKey: @"WaterGhoul"];
    [s setObject:[Drawer ghoulWithBody: brown]                              forKey: @"EarthGhoul"];
 
    
    [s setObject:[Drawer totoro:green eyes:black]                              forKey: @"Totoro"];
 
    
    // Items
    
    [s setObject:[Drawer basicSwordWithColor:gray withHandleColor:blue]     forKey: @"ShortSword"];
    [s setObject:[Drawer basicShieldWithColor:brown withEmblemColor:yellow] forKey: @"LeatherArmor"];
    
    [s setObject:[Drawer basicPotionWithColor:red]                          forKey: @"PotionOfLightHealing"];
    
    [s setObject:[Drawer bookOfAllKnowing]                                  forKey: @"BookOfAllKnowing"];
    [s setObject:[Drawer smallBlob:green]                                   forKey: @"SmallBlob"];
    
    [s setObject:[Drawer smallFish:brown eyeColor:black]                    forKey:@"Catfish"];
    
    [s setObject:[Drawer fishingRod:brown]                                  forKey:@"WoodenFishingRod"];
    
    [s setObject:[Drawer boulder:darkgray]                                  forKey:@"BasicBoulder"];
}



-(void) bootGame {
    [self cleanupGame];
    
    // setting up some basic variables
    self.isTouchEnabled = YES;
    selectedTile = -1;
    touchedTileIndex = -1;
    isTouched = NO;
    
    totalKarmaThisTurn = 0;
    gotKarmaThisTurn = NO;
    
    // Dungeon initialization
    [ self initializeDungeon ];
    
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: [dungeon objectAtIndex:floorNumber]];
    
    // set up our 'hero'
    [ self initializePCEntity ];
    
    killList = [NSMutableArray array];
    
    [self loadSprites];
    
    // set the camera anchor point
    cameraAnchorPoint = ccp( 7, 5 );
    
    // our list of entities
    [[[ dungeon objectAtIndex:floorNumber ] entityArray] addObject: pcEntity];
    
    // set the starting tile
    Tile *startTile = nil;
    for ( Tile *t in [ [dungeon objectAtIndex:floorNumber] tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            startTile = t;
            break;
        }
    }
    
    
    [ GameRenderer setEntity:pcEntity onTile:startTile ];
    [ self resetCameraPosition ];
    
    // set the selectedTilePoint to (-1,-1) (none)
    selectedTilePoint = ccp( -1, -1 );
    
    // initialize our debug Log
    dLog = [ [ NSMutableArray alloc ] init ];
    dLogIndex = 0;
    
    // add some test messages
    [ self addMessage: @"Testing" ];
    [ self addMessage: @"Editor" ];
    [ self addMessage: @"HUD" ];
    [ self addMessage: @"Output" ];
    [ self addMessage: @"Nice :)" ];
    [ self addMessage: @"Let's roll" ];
    [ self addMessage: @"" ];
    
    
    // initialize our various HUDs
    [ self initializeHUDs ];
    
    // haven't touched the hero yet
    heroTouches = 0;
    
    // first turn
    turnCounter = 1;
    
    // initialize our notifications
    [ self initializeNotifications ];
    
    // schedule our update method, tick
    [ self schedule:@selector(tick:)];
    
#define MAX_SAFE_STEP_SPEED     0.0001
#define STEP_SPEED              0.1
    
    // turn on gameLogic & autostepping
    gameLogicIsOn = YES;
    //autostepGameLogic = YES;
    autostepGameLogic = NO;
    
    // only allow autostepping if both gameLogicIsOn and autosteppingGameLogic
    autostepGameLogic = autostepGameLogic && gameLogicIsOn;
    if ( gameLogicIsOn && autostepGameLogic ) {
        MLOG(@"bootGame schedule step action...");
        [ self scheduleStepAction ];
    }
    
    needsRedraw = YES;
    
    // populate treasure
    // generate and scatter some treasure
    for ( int i = 0; i < [dungeon count]; i++ ) {
        NSInteger treasureCount = [Dice roll:6] + 1;
        for ( int j = 0; j < treasureCount; j++ ) {
            NSInteger roll = [Dice roll:3];
            
            roll == 1 ? [ GameRenderer spawnEntityAtRandomLocation:[Weapons shortSword: i] onFloor:[dungeon objectAtIndex:i]] :
            roll == 2 ? [ GameRenderer spawnEntityAtRandomLocation:[Armor leatherArmor: i] onFloor:[dungeon objectAtIndex:i]] :
            roll == 3 ? [ GameRenderer spawnRandomItemAtRandomLocationOnFloor:[dungeon objectAtIndex:i]] :
            0;
        }
    }
    
    //[ GameRenderer spawnBookOfAllKnowingAtRandomLocationOnFloor: [dungeon objectAtIndex:0 ] ];
    [ GameRenderer spawnBookOfAllKnowingAtRandomLocationOnFloor: [dungeon objectAtIndex:[dungeon count]-1 ] ];
 
    /*
    MLOG(@"INSTRUCTIONS");
    for ( NSString *s in [Drawer codeForTexture:[sprites objectForKey:@"BookOfAllKnowing"]]) MLOG(@"%@", s);
    MLOG(@"END INSTRUCTIONS");
     */
}


-(void) cleanupGame {
    
    [[KarmaEngine sharedEngine] zeroOutKarma];
    
    gameState = 0;
    turnCounter = 0;
    selectedTilePoint = ccp(0,0);
    pcEntity = nil;
    
    killList != nil ? [killList removeAllObjects] : 0;
    killList = nil;
    
    floorNumber = 0;
    floor = nil;
    
    dungeon!=nil ? [dungeon removeAllObjects] : 0;
    dungeon = nil;
    
    tileArray != nil ? [tileArray removeAllObjects] : 0;
    tileArray = nil;
    
    tileDataArray != nil ? [tileDataArray removeAllObjects] : 0;
    tileDataArray = nil;
    
    entityArray!=nil ? [entityArray removeAllObjects] : 0;
    entityArray = nil;
    
    dLog!=nil ? [dLog removeAllObjects] : 0;
    dLog = nil;
    dLogIndex = 0;
    
    isTouched = NO;
    touchedTileIndex = 0;
    selectedTile = 0;
    
    heroTouches = 0;
    
    editorHUDIsVisible = NO;
    monitorIsVisible = NO;
    editorHUD = nil;
    monitor = nil;
    
    entityInfoHUDIsVisible = NO;
    entityInfoHUD = nil;
    
    playerHUDIsVisible = NO;
    playerHUD = nil;
    
    gearHUDIsVisible = NO;
    gearHUD = nil;
    
    playerMenuIsVisible = NO;
    playerMenu = nil;
    
    playerMenuIsMin = NO;
    playerMenuMin = nil;
    
    statusMenuIsVisible = NO;
    statusMenu = nil;
    
    inventoryMenuIsVisible = NO;
    inventoryMenu = nil;
    
    cameraAnchorPoint = ccp(0,0);
    
    touchBeganTime = 0;
    
    gameLogicIsOn = NO;
    autostepGameLogic = NO;
    
    needsRedraw = NO;
    
    sprites != nil ? [sprites removeAllObjects] : 0;
    sprites = nil;
    
    [self unschedule:@selector(tick:)];
    [self removeNotifications];
    [self removeAllChildrenWithCleanup:YES];
}



/*
 ====================
 init
 
 initializes and returns the layer
 ====================
 */
-(id) init {
    ((self=[super init])) ? [self bootGame] : 0;
	return self;
}


/*
 ====================
 dealloc
 
 deallocates this object
 ====================
 */
- (void) dealloc {
	//[super dealloc];
}


#pragma mark - Notification code

static const NSUInteger notificationsCount = 22;
static NSString  * const notifications[] = {
    /*0*/ @"TestNotification1",
    /*1*/ @"TestNotification2",
    /*2*/ @"MonitorNotification",
    /*3*/ @"PlayerMenuCloseNotification",
    /*4*/ @"PlayerMenuStatusNotification",
    /*5*/ @"PlayerMenuInventoryNotification",
    /*6*/ @"PlayerMenuStepNotification",
    /*7*/ @"PlayerMenuAutostepNotification",
    /*8*/ @"PlayerMenuTogglePositionNotification",
    /*9*/ @"PlayerMenuToggleHUDsNotification",
    /*10*/ @"PlayerMenuResetNotification",
    /*11*/ @"PlayerMenuMonitorNotification",
    /*12*/ @"HUDMenuEditorHUDCloseNotification",
    /*13*/ @"HUDMenuGearHUDCloseNotification",
    /*14*/ @"StatusMenuReturnNotification",
    /*15*/ @"InventoryMenuReturnNotification",
    /*16*/ @"PlayerMenuHelpNotification",
    /*17*/ @"HelpMenuBackNotification",
    /*18*/ @"PlayerMenuEntityInfoNotification",
    /*19*/ @"PlayerMenuPickupNotification",
    /*20*/ @"PlayerMenuEquipNotification",
    /*21*/ @"EquipMenuReturnNotification"
};


/*
 ====================
 initializeNotifications
 
 initializes the various notifications used by the game's engine
 ====================
 */
-( void ) initializeNotifications {
    for (int i=0; i<notificationsCount; i++)
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:notifications[i] object:nil];
}

/*
 ====================
 removeNotifications
 
 initializes the various notifications used by the game's engine
 ====================
 */
-( void ) removeNotifications {
    for (int i=0; i<notificationsCount; i++)
        [[ NSNotificationCenter defaultCenter ] removeObserver:self name:notifications[i] object:nil];
}


/*
 ====================
 receiveNotification: notification
 ====================
 */
-( void ) receiveNotification: ( NSNotification * ) notification {
    if ( [[ notification name ] isEqualToString: @"TestNotification1" ] ) {
        //MLOG( @"TestNotification1" );
    } else if ( [[ notification name ] isEqualToString: @"TestNotification2" ] ) {
        //MLOG( @"TestNotification2" );
    } else if ( [[ notification name ] isEqualToString: @"MonitorNotification" ] ) {
        //MLOG( @"MonitorNotification" );
        if ( ! monitorIsVisible ) {
            [ self addMonitor: monitor ];
            monitorIsVisible = TRUE;
        } else {
            [self removeMonitor: monitor];
            monitorIsVisible = FALSE;
        }
    } else if ( [[ notification name ] isEqualToString: @"PlayerMenuMoveNotification" ] ) {
        MLOG( @"MoveNotification" );
        //[ self removePlayerMenu: playerMenu ];
        //gameState = GAMESTATE_T_GAME_PC_SELECTMOVE;
        
    } else if ( [[ notification name ] isEqualToString: @"PlayerMenuAttackNotification" ] ) {
        //MLOG( @"AttackNotification" );
        //[ self removePlayerMenu: playerMenu ];
        //gameState = GAMESTATE_T_GAME;
    }
    else if ( [[ notification name ] isEqualToString: @"PlayerMenuStepNotification" ] ) {
        //MLOG( @"StepNotification" );
        //[ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME_PC_STEP;
        
        //[ self addMessage: @"Stepping..." ];
        // move pcEntity towards downstairsTile based on movement algorithm
#pragma mark - Entity PathFinding Algorithm - Random
        
        if ( pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_RANDOM ) {
            NSUInteger roll = [Dice roll:9];
            CGFloat x = -1;
            CGFloat y = -1;
            
            //MLOG( @"rolled %d", roll );
            
            // UDLR UL, UR, DL, DR
            if ( roll == 1 ) { x = 0; y = -1; }
            else if ( roll == 2 ) { x = 0; y = 1; }
            else if ( roll == 3)  { x = -1; y = 0; }
            else if ( roll == 4) { x = 1; y = 0; }
            else if ( roll == 5) { x = -1; y = -1; }
            else if ( roll == 6) { x = 1; y = -1; }
            else if ( roll == 7) { x = -1; y = 1; }
            else if ( roll == 8) { x = 1; y = 1; }
            else if ( roll == 9 ) { x = 0; y = 0; }
            
            CGPoint newPosition;
            newPosition.x = pcEntity.positionOnMap.x + x;
            newPosition.y = pcEntity.positionOnMap.y + y;
            
            // try to move the entity to the new position
            if ( roll != 9 ) {
                [ self moveEntity:pcEntity toPosition: newPosition ];
            } else {
                // heal the pcEntity a bit
                pcEntity.hp++;
                if (pcEntity.hp > pcEntity.maxhp ) {
                    pcEntity.hp = pcEntity.maxhp;
                }
            }
        }
        
#pragma mark - Entity PathFinding Algorithm - Smart Random
        
        else if (pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM ) {
            BOOL rollIsUnacceptable = YES;
            CGPoint newPosition;
            NSUInteger roll = [Dice roll:9];
            while ( rollIsUnacceptable ) {
                roll = [Dice roll:9];
                CGFloat x = -1;
                CGFloat y = -1;
            
                // UDLR UL, UR, DL, DR
                if      ( roll == 1 ) { x =  0;      y = -1;  }
                else if ( roll == 2 ) { x =  0;      y =  1;  }
                else if ( roll == 3 ) { x = -1;      y =  0;  }
                else if ( roll == 4 ) { x =  1;      y =  0;  }
                else if ( roll == 5 ) { x = -1;      y = -1;  }
                else if ( roll == 6 ) { x =  1;      y = -1;  }
                else if ( roll == 7 ) { x = -1;      y =  1;  }
                else if ( roll == 8 ) { x =  1;      y =  1;  }
                else if ( roll == 9 ) { x =  0;      y =  0;  }
                
                newPosition.x = pcEntity.positionOnMap.x + x;
                newPosition.y = pcEntity.positionOnMap.y + y;
             
                Tile *tile = [ self getTileForCGPoint: newPosition ];
                if ( tile.tileType == TILE_FLOOR_VOID ) {
                    rollIsUnacceptable = TRUE;
                } else {
                    rollIsUnacceptable = FALSE;
                }
            }
            
            if ( roll != 9 ) {
                [ self moveEntity:pcEntity toPosition: newPosition ];
            } else {
                // heal the pcEntity a bit
                if ( pcEntity.hp < pcEntity.maxhp ) {
                    pcEntity.hp++;
                    [ self addMessage:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                    [ self addMessageWindowString:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                }
            }
 
            // step game logic
            gameLogicIsOn ? [self stepGameLogic] : 0;
            [ self resetCameraPosition ];
        }
        
#pragma mark - Entity PathFinding Algorithm - Temp Random
        
        else if (pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_TEMP_RANDOM ) {
            
            static NSInteger randomMoves = 0;
            const NSInteger movesBeforeSwitch = 50;
            
            if ( randomMoves > movesBeforeSwitch ) {
                randomMoves = 0;
                pcEntity.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SIMPLE;
            }
            
            randomMoves++;
            
            BOOL rollIsUnacceptable = YES;
            CGPoint newPosition;
            NSUInteger roll = [Dice roll:8];
            while ( rollIsUnacceptable ) {
                roll = [Dice roll:8];
                CGFloat x = -1;
                CGFloat y = -1;
                
                // UDLR UL, UR, DL, DR
                if      ( roll == 1 ) { x =  0;      y = -1;  }
                else if ( roll == 2 ) { x =  0;      y =  1;  }
                else if ( roll == 3 ) { x = -1;      y =  0;  }
                else if ( roll == 4 ) { x =  1;      y =  0;  }
                else if ( roll == 5 ) { x = -1;      y = -1;  }
                else if ( roll == 6 ) { x =  1;      y = -1;  }
                else if ( roll == 7 ) { x = -1;      y =  1;  }
                else if ( roll == 8 ) { x =  1;      y =  1;  }
                else if ( roll == 9 ) { x =  0;      y =  0;  }
                
                newPosition.x = pcEntity.positionOnMap.x + x;
                newPosition.y = pcEntity.positionOnMap.y + y;
                
                Tile *tile = [ self getTileForCGPoint: newPosition ];
                rollIsUnacceptable = tile.tileType == TILE_FLOOR_VOID;
            }
            
            // check if monsters are around you
            BOOL monsterNear = NO;
            CGPoint nearest;
            CGPoint ul, u, ur, l, r, dl, d, dr;
            CGPoint a = pcEntity.positionOnMap;
            ul = ccp( a.x-1, a.y-1 );
            u  = ccp( a.x+0, a.y-1 );
            ur = ccp( a.x+1, a.y-1 );
            l  = ccp( a.x-1, a.y+0 );
            r  = ccp( a.x+1, a.y+0 );
            dl = ccp( a.x-1, a.y+1 );
            d  = ccp( a.x+0, a.y+1 );
            dr = ccp( a.x+1, a.y+1 );
            CGPoint surroundingPoints[ 8 ] = { ul, u, ur, l, r, dl, d, dr };
            for ( int i = 0; i < 8; i++ ) {
                Tile *t = [self getTileForCGPoint:surroundingPoints[i] forFloor:[dungeon objectAtIndex:floorNumber]];
                if ( [[t contents] count] > 0 ) {
                    Entity *e = [t.contents objectAtIndex:0];
                    if ( e.entityType == ENTITY_T_NPC ||
                         e.entityType == ENTITY_T_ITEM  // also grab items, why not?
                        ) {
                        nearest = surroundingPoints[i];
                        monsterNear = YES;
                        break;
                    }
                }
            }
            
            // prioritize offense
            if ( monsterNear ) {
                [ self moveEntity:pcEntity toPosition:nearest ];
                pcEntity.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SIMPLE;
            }
            
            // prioritize healing
            else if ( pcEntity.hp < pcEntity.maxhp ) {
                pcEntity.hp++;
                [ self addMessage:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                [ self addMessageWindowString:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
            }
 
            // prioritize the roll
            else {
                if ( roll != 9 ) {
                    [ self moveEntity:pcEntity toPosition: newPosition ];
                } else {
                    // heal the pcEntity a bit
                    if ( pcEntity.hp < pcEntity.maxhp ) {
                        pcEntity.hp++;
                        [ self addMessage:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                        [ self addMessageWindowString:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                    }
                }
            }
            
            // step game logic
            gameLogicIsOn ? [self stepGameLogic] : 0;
            [ self resetCameraPosition ];
        }
        
        
#pragma mark - Entity PathFinding Algorithm - Simple
        
        else if (pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SIMPLE ) {
            BOOL hasItem = NO;
            BOOL isBottomFloor = floorNumber == dungeon.count - 1;
            
            for ( Entity *e in pcEntity.inventoryArray ) {
                if ( e.itemType == E_ITEM_T_BOOK ) {
                    hasItem = YES;
                    break;
                }
            }
            
            CGPoint nearest;
            
            if ( ! isBottomFloor && ! hasItem ) {
                nearest = [ self nearestNonVoidCGPointFromCGPoint:pcEntity.positionOnMap toCGPoint: [GameRenderer getDownstairsTileForFloor:[dungeon objectAtIndex:floorNumber]] ];
            } else if ( isBottomFloor && ! hasItem ) {
                CGPoint itemPoint;
                for ( Tile *t in [[dungeon objectAtIndex:floorNumber] tileDataArray] ) {
                    if ( t.contents.count > 0 ) {
                        for ( Entity *e in t.contents ) {
                            // just for the book of all knowing
                            if ( e.itemType == E_ITEM_T_BOOK ) {
                                itemPoint = t.position;
                                break;
                            }
                        }
                    }
                }
                nearest = itemPoint;
            } else if ( hasItem ) {
                nearest = [ self nearestNonVoidCGPointFromCGPoint:pcEntity.positionOnMap toCGPoint: [GameRenderer getUpstairsTileForFloor:[dungeon objectAtIndex:floorNumber]] ];
            }
            
            // check if monsters are around you
            // regardless of floor
            BOOL monsterNear = NO;
            CGPoint ul, u, ur, l, r, dl, d, dr;
            CGPoint a = pcEntity.positionOnMap;
            ul = ccp( a.x-1, a.y-1 );
            u  = ccp( a.x+0, a.y-1 );
            ur = ccp( a.x+1, a.y-1 );
            l  = ccp( a.x-1, a.y+0 );
            r  = ccp( a.x+1, a.y+0 );
            dl = ccp( a.x-1, a.y+1 );
            d  = ccp( a.x+0, a.y+1 );
            dr = ccp( a.x+1, a.y+1 );
            CGPoint surroundingPoints[ 8 ] = { ul, u, ur, l, r, dl, d, dr };
            for ( int i = 0; i < 8; i++ ) {
                Tile *t = [self getTileForCGPoint:surroundingPoints[i] forFloor:[dungeon objectAtIndex:floorNumber]];
                if ( [[t contents] count] > 0 ) {
                    nearest = surroundingPoints[i];
                    monsterNear = YES;
                    break;
                }
            }
            
            static CGPoint lastPosition;
            static NSInteger moveTolerance = 0;
            
            ccpFuzzyEqual(nearest, lastPosition, 0) ? moveTolerance++ : 0;
            
            if ( moveTolerance > 10 ) {
               // MLOG(@"switching to TEMP_RANDOM");
                pcEntity.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_TEMP_RANDOM;
                moveTolerance = 0;
            }
            
            lastPosition.x = pcEntity.positionOnMap.x;
            lastPosition.y = pcEntity.positionOnMap.y;
            
            //MLOG(@"nearest: (%.0f,%.0f)", nearest.x, nearest.y);
            if ( ccpFuzzyEqual(nearest, pcEntity.positionOnMap, 0) ) {
                pcEntity.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_TEMP_RANDOM;
                moveTolerance = 0;
            } else {
                if ( monsterNear ) {
                    [ self moveEntity:pcEntity toPosition:nearest ];
                } else if ( pcEntity.hp < pcEntity.maxhp ) {
                    pcEntity.hp++;
                    [ self addMessage:[ NSString stringWithFormat:@"%@ rested", pcEntity.name ] ];
                } else {
                    [ self moveEntity: pcEntity toPosition: nearest ];
                }
            }
            
            // step game logic
            gameLogicIsOn ? [self stepGameLogic] : 0;
            [ self resetCameraPosition ];
        }
        [ self resetCameraPosition ];
        gameState = GAMESTATE_T_GAME;
    } else if ( [notification.name isEqualToString: @"PlayerMenuCloseNotification" ]) {
        static BOOL isMinimized = NO;
        if ( ! isMinimized ) {
            isMinimized = YES;
            [ self removePlayerMenu: playerMenu ];
            [ self addPlayerMenuMin: playerMenuMin ];
        } else {
            isMinimized = NO;
            [ self removePlayerMenuMin: playerMenuMin ];
            [ self addPlayerMenu: playerMenu ];
        }
    } else if ( [notification.name isEqualToString: @"PlayerMenuTogglePositionNotification" ]) {
        
        static BOOL left = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        if ( left ) {
            playerMenu.position = ccp( size.width - playerMenu.contentSize.width , size.height - (playerMenu.contentSize.height) );
            left = NO;
        } else {
            playerMenu.position = ccp( 0 , size.height - (playerMenu.contentSize.height) );
            left = YES;
        }
    } else if ( [notification.name isEqualToString: @"HUDMenuEditorHUDCloseNotification" ]) {
        if (! editorHUDIsVisible ) {
            [self addEditorHUD:editorHUD];
            editorHUDIsVisible = YES;
        } else {
            [self removeEditorHUD:editorHUD];
            editorHUDIsVisible = NO;
        }
    } else if ( [notification.name isEqualToString: @"PlayerMenuMonitorNotification" ]) {
        if (! monitorIsVisible ) {
            [self addMonitor:monitor];
            monitorIsVisible = YES;
        } else {
            [self removeMonitor:monitor];
            monitorIsVisible = NO;
        }
    } else if ( [notification.name isEqualToString: @"HUDMenuGearHUDCloseNotification" ]) {
        if (! gearHUDIsVisible ) {
            [self addGearHUD:gearHUD];
            gearHUDIsVisible = YES;
        } else {
            [self removeGearHUD:gearHUD];
            gearHUDIsVisible = NO;
        }
    } else if ( [notification.name isEqualToString: @"PlayerMenuStatusNotification" ]) {
        MLOG(@"Status menu");
        [self addStatusMenu];
    } else if ( [notification.name isEqualToString: @"PlayerMenuAutostepNotification" ]) {
        MLOG(@"Autostep toggle");
        autostepGameLogic = !autostepGameLogic;
        //if (autostepGameLogic) MLOG(@"autoStepGameLogic = YES");
        //else MLOG(@"autoStepGameLogic = NO");
        
        if ( gameLogicIsOn && autostepGameLogic ) {
            MLOG(@"Scheduling step action...");
            [ self scheduleStepAction ];
        } else {
            MLOG(@"Unscheduling step action...");
            [ self unscheduleStepAction ];
        }
    } else if ( [notification.name isEqualToString: @"PlayerMenuInventoryNotification" ]) {
        MLOG(@"Inventory menu");
        autostepGameLogic = NO;
        [self unscheduleStepAction];
        [self addInventoryMenu];
    } else if ( [notification.name isEqualToString: @"StatusMenuReturnNotification" ]) {
        MLOG(@"Status menu");
        [self removeStatusMenu];
    } else if ( [notification.name isEqualToString: @"InventoryMenuReturnNotification" ]) {
        MLOG(@"Inventory menu");
        [self removeInventoryMenu];
    } else if ( [notification.name isEqualToString: @"PlayerMenuResetNotification" ]) {
        MLOG(@"Reset...");
        [ self bootGame ];
    } else if ( [notification.name isEqualToString: @"PlayerMenuHelpNotification" ]) {
        MLOG(@"Help pressed");
        ( ! helpMenuIsVisible ) ? [ self addHelpMenu] : [self removeHelpMenu];
    } else if ( [notification.name isEqualToString: @"HelpMenuBackNotification" ]) {
        helpMenuIsVisible ? [self removeHelpMenu] : 0;
    } else if ( [notification.name isEqualToString: @"PlayerMenuEntityInfoNotification" ]) {
        if ( ! entityInfoHUDIsVisible ) {
            [self addEntityInfoHUD:entityInfoHUD];
            entityInfoHUDIsVisible = YES;
        } else {
            [self removeEntityInfoHUD:entityInfoHUD];
            entityInfoHUDIsVisible = NO;
        }
    }
    
#pragma mark - Handle PlayerMenu Notification - Pickup
    else if ( [notification.name isEqualToString: @"PlayerMenuPickupNotification" ]) {
        // handle item pickup
        MLOG(@"Handling item pickup...");
        
        // simple for now - grab the item on top of the tile
        Tile *t = [self getTileForCGPoint: pcEntity.positionOnMap];
        Entity *item = nil;
        for (Entity *e in t.contents) {
            if (e.entityType == ENTITY_T_ITEM) {
                item = e;
                break;
            }
        }
        
        item != nil     ? [self handleItemPickup:item forEntity:pcEntity] : 0;
        gameLogicIsOn   ? [self stepGameLogic] : 0;
    }
    
#pragma mark - Handle PlayerMenu Notification - Equip
    else if ( [notification.name isEqualToString: @"PlayerMenuEquipNotification" ]) {
        // handle equipping items
        //MLOG(@"Equip Notification: %@", equipMenuIsVisible ? @"1" : @"0");
        // we'll show an 'equip' menu
        ! equipMenuIsVisible ? [self addEquipMenu] : [self removeEquipMenu];
    }
    
#pragma mark - Handle EquipMenu Notification - Return
    else if ( [notification.name isEqualToString: @"EquipMenuReturnNotification" ]) {
        [self removeEquipMenu];
        
        // update our hero sprite
        [sprites setObject:[Drawer heroForPC:pcEntity] forKey:@"Hero"];
    } else {
        MLOG( @"Notification not handled: %@", notification.name );
    }
    
    needsRedraw = YES;
}

#pragma mark - Menus and HUD code

#pragma mark - Message Window

-(void) initMessageWindow {
    messageQueue = [[NSMutableArray alloc] init];
    messageWindow = [[MessageWindow alloc] init];
    messageWindow.position = ccp( screenwidth/2 - messageWindow.contentSize.width/2, screenheight/2 - messageWindow.contentSize.height/2 );
}

-(void) addMessageWindowString: (NSString *)string {
    if ( ![string isEqualToString:@""]) {
        [messageQueue addObject: string];
    }
}

-(void) displayMessageWindow {
    if ( ! messageWindowIsVisible ) {
        if ( [messageQueue count] > 0 ) {
            [self addChild: messageWindow];
            messageWindow.label.string = [messageQueue objectAtIndex:0];
            messageWindowIsVisible = YES;
        }
    }
}

-(void) removeMessageWindow {
    if ( messageWindowIsVisible ) {
        [self removeChild:messageWindow cleanup:YES];
        messageWindowIsVisible = NO;
        if ( [messageQueue count] > 0 ) {
            [messageQueue removeObjectAtIndex:0];
            [messageQueue count] > 0 ? [self displayMessageWindow] : 0;
        }
    }
}


#pragma mark - Equip Menu

/*
 ====================
 equip menu methods
 ====================
 */

-(void) initEquipMenu {
    equipMenu = [[EquipMenu alloc] initWithPC:pcEntity withFloor:[dungeon objectAtIndex:floorNumber] withGameLayer:self];
    equipMenu.position = ccp(0,0);
}

-(void) addEquipMenu {
    if ( ! equipMenuIsVisible ) {
        [self addChild:equipMenu];
        equipMenuIsVisible = YES;
    }
}

-(void) removeEquipMenu {
    if ( equipMenuIsVisible ) {
        [self removeChild:equipMenu cleanup:NO];
        equipMenuIsVisible = NO;
    }
}

-(void) updateEquipMenu {
    
}


#pragma mark - Help Menu
/*
 ====================
 help menu methods
 ====================
 */
-(void) initHelpMenu {
    CGSize size = [[CCDirector sharedDirector] winSize];
    helpMenu = [[HelpMenu alloc] initWithColor:black width:size.width height:size.height];
    helpMenu.position = ccp( 0, 0 );
}

-(void) addHelpMenu {
    if ( ! helpMenuIsVisible ) {
        [self addChild: helpMenu];
        helpMenuIsVisible = YES;
    }
}

-(void) removeHelpMenu {
    if ( helpMenuIsVisible ) {
        [self removeChild:helpMenu cleanup:NO];
        helpMenuIsVisible = NO;
    }
}


#pragma mark - Player Menu

/*
 ====================
 initPlayerMenu
 
 initializes the Player menu
 ====================
 */
-( void ) initPlayerMenu {
    CGSize size = [[CCDirector sharedDirector] winSize];
    playerMenu = [[ PlayerMenu alloc ] initWithColor: black width:100 height:300 ];
    playerMenu.position = ccp( 0 , size.height - (playerMenu.contentSize.height) );
}


/*
 ====================
 addPlayerMenu: menu
 
 adds the Player menu to the visible screen
 ====================
 */
-( void ) addPlayerMenu: ( PlayerMenu * ) _menu {
    if ( ! playerMenuIsVisible ) {
        [ self addChild: _menu ];
        playerMenuIsVisible = YES;
    }
}

/*
 ====================
 removePlayerMenu: menu
 
 removes the Player menu from the visible screen
 ====================
 */
-( void ) removePlayerMenu: ( PlayerMenu * ) _menu {
    if ( playerMenuIsVisible ) {
        [ self removeChild: _menu cleanup: NO ];
        playerMenuIsVisible = NO;
    }
}

/*
 ====================
 initPlayerMenuMin
 
 initializes the Player menu minimized
 ====================
 */
-( void ) initPlayerMenuMin {
    CGSize size = [[CCDirector sharedDirector] winSize];
    playerMenuMin = [[ PlayerMenu alloc ] initWithColor: black width:100 height:30 isMinimized:YES];
    playerMenuMin.position = ccp( 0 , size.height - (playerMenuMin.contentSize.height) );
}


/*
 ====================
 addPlayerMenuMin: menu
 
 adds the Player menu to the visible screen minimized
 ====================
 */
-( void ) addPlayerMenuMin: ( PlayerMenu * ) _menu {
    if ( ! playerMenuIsMin ) {
        [ self addChild: _menu ];
        playerMenuIsMin = YES;
    }
}

/*
 ====================
 removePlayerMenuMin: menu
 
 removes the Player menu from the visible screen minimized
 ====================
 */
-( void ) removePlayerMenuMin: ( PlayerMenu * ) _menu {
    if ( playerMenuIsMin ) {
        [ self removeChild: _menu cleanup: NO ];
        playerMenuIsMin = NO;
    }
}

/*
 ====================
 initEntityInfoHUD
 
 initializes the Entity Info HUD
 ====================
 */
-( void ) initEntityInfoHUD {
    CGSize size = [[CCDirector sharedDirector] winSize];
    entityInfoHUD = [[ EntityInfoHUD alloc ] initWithColor:black_alpha(150) width:200 height:100 ];
    entityInfoHUD.position = ccp(  size.width - entityInfoHUD.contentSize.width, size.height - entityInfoHUD.contentSize.height );
    entityInfoHUD.label.fontSize = 12;
    [ self updateEntityInfoHUDLabel ];
}

/*
 ====================
 initEntityInfoHUD
 
 initializes the Entity Info HUD
 ====================
 */

-( void ) addEntityInfoHUD: (EntityInfoHUD *) _entityInfoHUD {
    if ( ! self->entityInfoHUDIsVisible ) {
        [ self addChild: _entityInfoHUD ];
        entityInfoHUDIsVisible = YES;
    }
}

/*
 ====================
 updateEntityInfoHUDLabel
 
 updates the entity info hud label
 ====================
 */
-( void ) updateEntityInfoHUDLabel {
    @try {
        BOOL selectedPointIsValid = (selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0 );
        if ( selectedPointIsValid ) {
            Tile *t = [ self getTileForCGPoint: selectedTilePoint ];
            if ( [[ t contents] count] > 0 ) {
                // display entity info
                Entity *e = [[ t contents ] objectAtIndex: 0];
                NSString *str = @"";
                if ( e.entityType == ENTITY_T_NPC || e.entityType == ENTITY_T_PC ) {
                    str = [ NSString stringWithFormat: @"Lv: %d  Name: %@\nHP: %d/%d  AC: %d\nHunger: %d  Kills: %d\nSt:%d Dx:%d Cn:%d In:%d Wi:%d Ch:%d\n",
                           e.level,
                           e.name,
                           e.hp,
                           e.maxhp,
                           e.totalac,
                           e.hunger,
                           e.totalKills,
                           e.strength,
                           e.dexterity,
                           e.constitution,
                           e.intelligence,
                           e.wisdom,
                           e.charisma
                           ];
                } else if ( e.entityType == ENTITY_T_ITEM ) {
                    if ( e.itemType == E_ITEM_T_WEAPON ) {
                        str = [ NSString stringWithFormat: @"Item Name: %@\nType: %@\nDamage: 1d%d+%d\nDurability: %d/%d\n",
                               e.name,
                               @"Weapon",
                               e.damageRollBase, e.damageBonus,
                               e.durability,
                               e.totalDurability
                               ];
                    } else if ( e.itemType == E_ITEM_T_ARMOR ) {
                        str = [ NSString stringWithFormat: @"Item Name: %@\nType: %@\nAC: %d\nDurability: %d/%d\n",
                               e.name,
                               @"Armor",
                               e.ac,
                               e.durability,
                               e.totalDurability
                               ];
                    }
                    // generic item
                    else {
                        str = [ NSString stringWithFormat: @"Item Name: %@\nType: %d\nAC: %d\nDurability: %d/%d\n",
                               e.name,
                               e.itemType,
                               e.totalac,
                               e.durability,
                               e.totalDurability
                               ];
                    }
                }
                [entityInfoHUD.label setString: str ];
            } else {
                // empty tile contents
                // display tile info
                [entityInfoHUD.label setString:[ NSString stringWithFormat: @"Tile Type: %@\n@\n@\n@\n",
                                                t.tileType == TILE_FLOOR_DOWNSTAIRS     ? @"Downstairs" :
                                                t.tileType == TILE_FLOOR_UPSTAIRS       ? @"Upstairs"   :
                                                t.tileType == TILE_FLOOR_GRASS          ? @"Grass"      :
                                                t.tileType == TILE_FLOOR_STONE          ? @"Stone"      :
                                                t.tileType == TILE_FLOOR_VOID           ? @"Void"       :
                                                t.tileType == TILE_FLOOR_ICE            ? @"Ice"        :
                                                t.tileType == TILE_FLOOR_WATER          ? @"Water"      :
                                                                                        @"Unknown"
                                                ]];
            }
        } else {
            [entityInfoHUD.label setString:@"..." ];
        }
    } @catch (NSException *exception) {
        [entityInfoHUD.label setString:@"..." ];
        MLOG(@"exception caught: %@", exception);
    } @finally {
    }
}

/*
 ====================
 removeEntityInfoHUD: entityInfoHUD
 
 removes the entity info hud
 ====================
 */

-( void ) removeEntityInfoHUD: (EntityInfoHUD *) _entityInfoHUD {
    if ( self->entityInfoHUDIsVisible ) {
        [ self removeChild: _entityInfoHUD cleanup: NO ];
        entityInfoHUDIsVisible = NO;
    }
}


/*
 ====================
 initMonitor
 
 initializes the Editor HUD 'Monitor'
 ====================
 */
-( void ) initMonitor {
    CGSize size = [[CCDirector sharedDirector] winSize];
    monitor = [[ EditorHUD alloc ] initWithColor:black width:250 height:100 ];
    monitor.label.fontSize = 12;
    monitor.position = ccp(  size.width - monitor.contentSize.width , 0 + playerHUD.contentSize.height );
    [ self updateMonitorLabel ];
}

/*
 ====================
 addMonitor: monitor
 ====================
 */
-(void) addMonitor: (EditorHUD *) _monitor {
    if ( ! self->monitorIsVisible ) {
        [ self addChild: _monitor ];
        monitorIsVisible = YES;
    }
}

/*
 ====================
 removeMonitor: monitor
 ====================
 */
-(void) removeMonitor: (EditorHUD *) _monitor {
    if ( self->monitorIsVisible ) {
        [ self removeChild: _monitor cleanup: NO ];
        monitorIsVisible = NO;
    }
}

/*
 ====================
 updateMonitorLabel
 ====================
 */
-(void) updateMonitorLabel {
    @try {
    [monitor.label setString:
     [NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nEntities: %d\nInventory: %d\nMemory used: %u kb\n",
      
      [self getGameStateString: gameState],
      selectedTilePoint.x,
      selectedTilePoint.y,
      pcEntity.positionOnMap.x,
      pcEntity.positionOnMap.y,
      cameraAnchorPoint.x,
      cameraAnchorPoint.y,
      [[[dungeon objectAtIndex:floorNumber] entityArray] count],
      [[pcEntity inventoryArray] count],
      get_memory_kb()
      ]
     ];
        
    } @catch ( NSException *e ) {
        [monitor.label setString:
         [NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nEntities: %d\nInventory: %d\nMemory used: %u kb\n",
          
          [self getGameStateString:gameState],
          selectedTilePoint.x,
          selectedTilePoint.y,
          pcEntity.positionOnMap.x,
          pcEntity.positionOnMap.y,
          cameraAnchorPoint.x,
          cameraAnchorPoint.y,
          entityArray.count,
          [[ pcEntity inventoryArray ] count],
          get_memory_kb()
          ]
         ];
    }
}


/*
 ====================
 initEditorHUD
 
 initializes the Editor HUD
 ====================
 */
-( void ) initEditorHUD {
    CGSize size = [[CCDirector sharedDirector] winSize];
    editorHUD = [[ EditorHUD alloc ] initWithColor:black width:200 height:60 ];
    CGFloat x = size.width - editorHUD.contentSize.width;
    CGFloat y = size.height - editorHUD.contentSize.height;
    editorHUD.position = ccp(x,y);
    editorHUD.label.fontSize = 12;
    [ self updateEditorHUDLabel ];
}

/*
 ====================
 updateEditorHUDLabel
 
 updates the Editor HUD Label
 ====================
 */
-( void ) updateEditorHUDLabel {
    [[editorHUD label] setString: [ NSString stringWithFormat: @"%@",
                                   [dLog objectAtIndex: dLogIndex ]
                                   ]];
}

/*
 ====================
 addEditorHUD: hud
 
 adds the Editor HUD to the visible screen
 ====================
 */
-( void ) addEditorHUD: ( EditorHUD * ) _hud {
    if ( ! editorHUDIsVisible ) {
        [ self addChild: _hud ];
        editorHUDIsVisible = YES;
    }
}

/*
 ====================
 removeEditorHUD: hud
 
 removes the Editor HUD from the visible screen
 ====================
 */
-( void ) removeEditorHUD: ( EditorHUD * ) _hud {
    if ( editorHUDIsVisible ) {
        [ self removeChild: _hud cleanup: NO ];
        editorHUDIsVisible = NO;
    }
}

/*
 ====================
 initPlayerHUD
 
 initializes the Player HUD
 ====================
 */
-( void ) initPlayerHUD {
    CGSize size = [[CCDirector sharedDirector] winSize];
    playerHUD = [[ PlayerHUD alloc ] initWithColor:black width: size.width height:50 ];
    playerHUD.position = ccp(  0 , 0 );
    [ self updatePlayerHUDLabel ];
}

/*
 ====================
 addPlayerHUD: hud
 
 adds the Player HUD to the visible screen
 ====================
 */
-( void ) addPlayerHUD: ( PlayerHUD * ) _hud {
    if ( ! playerHUDIsVisible ) {
        [ self addChild: _hud ];
        playerHUDIsVisible = YES;
    }
}

/*
 ====================
 removePlayerHUD: hud
 
 removes the Player HUD from the visible screen
 ====================
 */
-( void ) removePlayerHUD: ( PlayerHUD * ) _hud {
    if ( playerHUDIsVisible ) {
        [ self removeChild: _hud cleanup: NO ];
        playerHUDIsVisible = NO;
    }
}

/*
 ====================
 updatePlayerHUDLabel
 
 updates the Player HUD Label
 ====================
 */
-( void ) updatePlayerHUDLabel {
    playerHUD.label.fontSize = 12;
    [ [playerHUD label] setString: [ NSString stringWithFormat: @"%@\n%@\n%@\n",
                                   [ NSString stringWithFormat: @"%@ - Hunger:%@ T:%d", pcEntity.name,
                                        pcEntity.hunger < 50  ? @"Satiated" :
                                        pcEntity.hunger < 100 ? @"Mild Hunger" :
                                        pcEntity.hunger < 150 ? @"Hungry" :
                                        pcEntity.hunger < 200 ? @"Very Hungry" :
                                        pcEntity.hunger < 250 ? @"Starving" :
                                        @"Dead"
                                    ,
                                    turnCounter ],
                                   [ NSString stringWithFormat: @"St:%d Dx:%d Co:%d In:%d Wi:%d Ch:%d",
                                    pcEntity.strength,
                                    pcEntity.dexterity,
                                    pcEntity.constitution,
                                    pcEntity.intelligence,
                                    pcEntity.wisdom,
                                    pcEntity.charisma
                                    ],
                                   [ NSString stringWithFormat: @"Dlvl:%d $:0 HP:%d/%d AC:%d Lv:%d Xp:%u",
                                    floorNumber,
                                    pcEntity.hp,
                                    pcEntity.maxhp,
                                    pcEntity.totalac,
                                    pcEntity.level,
                                    pcEntity.xp]
                                   ]];
}

/*
 ====================
 initGearHUD
 
 initializes the Gear HUD
 ====================
 */
-( void ) initGearHUD {
    CGSize size = [[CCDirector sharedDirector] winSize];
    gearHUD = [[ PlayerHUD alloc ] initWithColor:black_alpha(150) width: 100 height:100 ];
    gearHUD.position = ccp(  size.width - gearHUD.contentSize.width , playerHUD.contentSize.height + monitor.contentSize.height );
    [ self updateGearHUDLabel ];
}

/*
 ====================
 addGearHUD: hud
 
 adds the Gear HUD to the visible screen
 ====================
 */
-( void ) addGearHUD: ( PlayerHUD * ) _hud {
    if ( ! gearHUDIsVisible ) {
        [ self addChild: _hud ];
        gearHUDIsVisible = YES;
    }
}

/*
 ====================
 removeGearHUD: hud
 
 removes the Gear HUD from the visible screen
 ====================
 */
-( void ) removeGearHUD: ( PlayerHUD * ) _hud {
    if ( gearHUDIsVisible ) {
        [ self removeChild: _hud cleanup: NO ];
        gearHUDIsVisible = NO;
    }
}

/*
 ====================
 updateGearHUDLabel
 
 updates the Gear HUD Label
 ====================
 */
-( void ) updateGearHUDLabel {
    gearHUD.label.fontSize = 10;
    NSString *str = [NSString stringWithFormat:@"Equipment:\n%@\n%@\n%@\n" ,
                         pcEntity.equippedArmsLeft.name,
                         pcEntity.equippedArmorChest.name,
                         @"none"
                         ];
    [ [gearHUD label] setString: str ];
}

#pragma mark - Status Menu

-(void) initStatusMenu {
    statusMenu = [[ StatusMenu alloc ] init];
    statusMenu.position = ccp( 0, 0);
}

-(void) addStatusMenu {
    if ( ! statusMenuIsVisible ) {
        [self addChild:statusMenu];
        statusMenuIsVisible = YES;
    }
}

-(void) removeStatusMenu {
    if ( statusMenuIsVisible ) {
        [self removeChild:statusMenu cleanup:NO];
        statusMenuIsVisible = NO;
    }
}

-(void) updateStatusMenu {
    NSObject *equipmentObjects[19];
    Entity *equipmentEntities[19];
    for (int i=0; i<19; i++) {
        equipmentObjects[i] = [pcEntity.equipment objectAtIndex: i];
        equipmentEntities[i] = [ equipmentObjects[i] isKindOfClass:NSClassFromString(@"Entity")] ? (Entity *) equipmentObjects[i] : nil;
    }
    
    [statusMenu.content setString:
     [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
      
      [NSString stringWithFormat:@"Name: %@", pcEntity.name],
      [NSString stringWithFormat:@"Level: %d  -  XP: %d", pcEntity.level, pcEntity.totalxp],
      [NSString stringWithFormat:@"HP: %d/%d  -  Base AC: %d\nTotal AC: %d\nHunger: %d\n", pcEntity.hp, pcEntity.maxhp, pcEntity.ac, pcEntity.totalac, pcEntity.hunger],
      
      [NSString stringWithFormat:@"Strength: %d (%d)\nDexterity: %d (%d)\nConstitution: %d (%d)\nIntelligence: %d (%d)\nWisdom: %d (%d)\nCharisma:  %d (%d)\n",
       pcEntity.strength,       [GameRenderer modifierForNumber:pcEntity.strength],
       pcEntity.dexterity,      [GameRenderer modifierForNumber:pcEntity.dexterity],
       pcEntity.constitution,   [GameRenderer modifierForNumber:pcEntity.constitution],
       pcEntity.intelligence,   [GameRenderer modifierForNumber:pcEntity.intelligence],
       pcEntity.wisdom,         [GameRenderer modifierForNumber:pcEntity.wisdom],
       pcEntity.charisma,       [GameRenderer modifierForNumber:pcEntity.charisma],
       nil],
      
      [NSString stringWithFormat:@"Attack Bonus: %d\nDamage Base: %d\n", pcEntity.attackBonus, pcEntity.damageRollBase ],
      [NSString stringWithFormat:@"Money: %d\n", pcEntity.money],
      [NSString stringWithFormat:@"Karma: %d\n", [[KarmaEngine sharedEngine] getKarma]],
      nil]
     ];
}

#pragma mark - Inventory Menu

-(void) initInventoryMenu {
    inventoryMenu = [[InventoryMenu alloc] initWithPC: pcEntity withFloor: [dungeon objectAtIndex:floorNumber] withGameLayer:self];
    inventoryMenu.position = ccp(0,0);
}

-(void) addInventoryMenu {
    if ( ! inventoryMenuIsVisible ) {
        [self addChild:inventoryMenu];
        inventoryMenuIsVisible = YES;
    }
}

-(void) removeInventoryMenu {
    if ( inventoryMenuIsVisible ) {
        [self removeChild:inventoryMenu cleanup:NO];
        inventoryMenuIsVisible = NO;
    }
}

-(void) updateInventoryMenu {
    [inventoryMenu update];
}

#pragma mark - Update code

/*
 ====================
 tick: dt
 
 represents a single frame tick
 ====================
 */
-(void)tick:(ccTime)dt {
    //double before = [NSDate timeIntervalSinceReferenceDate];

    // only if we need redraw, really...
    if ( needsRedraw ) {
        [ GameRenderer setAllVisibleTiles: tileArray withDungeonFloor: [dungeon objectAtIndex:floorNumber] withCamera:cameraAnchorPoint withSprites: sprites ];
        
        editorHUDIsVisible ? [ self updateEditorHUDLabel ] : 0;
        monitorIsVisible ? [self updateMonitorLabel] : 0;
        playerHUDIsVisible ? [ self updatePlayerHUDLabel ] : 0;
        entityInfoHUDIsVisible ? [ self updateEntityInfoHUDLabel ] : 0;
        gearHUDIsVisible ? [ self updateGearHUDLabel ] : 0;
        statusMenuIsVisible ? [ self updateStatusMenu ] : 0;
        inventoryMenuIsVisible ? [ self updateInventoryMenu ] : 0;
        equipMenuIsVisible ? [self updateEquipMenu] : 0;
        
        [ self resetCameraPosition ];
        needsRedraw = NO;
    }
    
    //double after = [NSDate timeIntervalSinceReferenceDate] - before;
}

#pragma mark - Touch code

/*
 ====================
 ccTouchesBegan: touches withEvent: event
 ====================
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = YES;
    
    //CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    //CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    // valid selected point
    BOOL validSelectedPoint = selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0;
    
    if ( validSelectedPoint ) {
        //[ self addMessage: @"Tile was previously selected" ];
        //[ self selectTileAtPosition: mapPoint ];
       // MLOG( @"ccTouchBegan: valid point selected" );
    } else {
       // MLOG( @"ccTouchBegan: Nothing previously selected" );
       // [ self selectTileAtPosition: mapPoint ];
    }
    needsRedraw = YES;
}

/*
 ====================
 ccTouchesMoved: touches withEvent: event
 ====================
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = YES;
    
    CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    // valid selected point
    BOOL validSelectedPoint = selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0;
    
    if ( validSelectedPoint ) {
        Tile *prevTouchedTile = [ self getTileForCGPoint: selectedTilePoint ];
        Tile *touchedTile = [ self getTileForCGPoint: mapPoint ];
        BOOL touchingNewTile = ( prevTouchedTile != touchedTile );
        if ( touchingNewTile ) {
            //[ self selectTileAtPosition: mapPoint ];
        }
    } else {
        // shouldnt be possible
    }
    needsRedraw = YES;
}

/*
 ====================
 ccTouchesEnded: touches withEvent: event
 ====================
 */
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = NO;
    
    CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    // valid selected point
    BOOL validSelectedPoint = selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0;
    BOOL validMapPoint      = mapPoint.x >= 0          && mapPoint.y >= 0;
    
    if ( messageWindowIsVisible ) {
        // make window go away, we acknowledge message
        [ self removeMessageWindow ];
    } else {
        if ( gameState == GAMESTATE_T_GAME_PC_FISHING_PRECAST ) {
            // check tile cast on
            if ( validMapPoint ) {
                Tile *a = [ self getTileForCGPoint: mapPoint ];
                
                // check tiletype...
                if ( a.tileType != TILE_FLOOR_WATER ) {
                    [ self addMessageWindowString: @"That is not a water tile..." ];
                } else {
                    [ self addMessageWindowString: @"You catch a fish!" ];
                    [self handleItemPickup:[Items catfish] forEntity:pcEntity];
                }
            }
            gameState = GAMESTATE_T_MAINMENU;
            gameLogicIsOn ? [self stepGameLogic] : 0;
        }
        
        else if ( gameState == GAMESTATE_T_GAME_PC_KEY_PREUSE ) {
            // check tile for locked door
            
            if ( validMapPoint ) {
                Tile *a = [self getTileForCGPoint: mapPoint];
                
                Entity *door = nil;
                for (Entity *e in a.contents) {
                    if (e.itemType == E_ITEM_T_DOOR_SIMPLE) {
                        door = e;
                        break;
                    }
                }
                
                if ( door != nil ) {
                    door.doorLocked = NO;
                    [self addMessageWindowString: @"Door unlocked"];
                }
                else {
                    [self addMessageWindowString: @"No door here"];
                }
            }
            
            gameState = GAMESTATE_T_MAINMENU;
            gameLogicIsOn ? [self stepGameLogic] : 0;
        }
        
        // not fishing, going for quick-move
        else {
            // something was previously selected
            if ( validSelectedPoint ) {
            
                MLOG( @"ccTouchEnded: valid point selected" );
                // check if we hit the same tile again
            
                Tile *a = [ self getTileForCGPoint: mapPoint ];
                Tile *b = [ self getTileForCGPoint: selectedTilePoint ];
            
                if ( a==b ) {
                    // check distance from pcEntity
                    Tile *pcTile = [ self getTileForCGPoint: pcEntity.positionOnMap ];
                    NSInteger distance = [ self distanceFromTile:a toTile: pcTile ];
                    if ( distance <= pcEntity.movement ) {
                        // valid quick-move
                        // deselect the tile
                        [ self selectTileAtPosition: mapPoint ];
                    
                        // move the pcEntity to the tile
                        if ( pcEntity.positionOnMap.x != mapPoint.x || pcEntity.positionOnMap.y != mapPoint.y ) {
                            [ self moveEntity:pcEntity toPosition:mapPoint ];
                        } else {
                            // rest
                            [self addMessage:@"You rest..."];
                            [self addMessageWindowString:@"You rest..."];
                            pcEntity.hp++;
                            if (pcEntity.hp >= pcEntity.maxhp) pcEntity.hp = pcEntity.maxhp;
                            [pcEntity getHungry];
                        }
                        gameLogicIsOn ? [self stepGameLogic] : 0;
                        [ self resetCameraPosition ];
                    } else {
                        // invalid quick-move
                        // possibly other quick-action
                        // deselect the tile
                        [ self selectTileAtPosition: mapPoint ];
                    }
                } else {
                    [ self selectTileAtPosition: mapPoint ];
                }
            }
            // something was not prev. selected
            else {
                [ self selectTileAtPosition: mapPoint ];
            }
        }
        needsRedraw = YES;
    }
}

/*
 ====================
 ccTouchesCancelled: touches withEvent: event
 ====================
 */
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self ccTouchesEnded:touches withEvent:event];
}

/*
 ====================
 shortPress: touch
 ====================
 */
-( void ) shortPress: (UITouch *) touch {
    //MLOG( @"short press" );
}

/*
 ====================
 longPress
 ====================
 */
-( void ) longPress {
    //MLOG( @"long press" );
}

#pragma mark - Tile code

/*
 ====================
 appendNewTile
 ====================
 */
-( void ) appendNewTile {
    CGSize size = [ [ CCDirector sharedDirector ] winSize ];
    float x = 0;
    float y = size.height;
    
    CCMutableTexture2D *tileMutableTexture = [ [ CCMutableTexture2D alloc ] initWithSize: CGSizeMake( TILE_SIZE, TILE_SIZE ) pixelFormat: kCCTexture2DPixelFormat_Default ];
    [ tileMutableTexture setAliasTexParameters ];
    
    srand( time( NULL ) );
    [ tileMutableTexture fill: black ];
    [ tileMutableTexture apply ];
    
    CCSprite *tileSprite = [ CCSprite spriteWithTexture: tileMutableTexture ];
    tileSprite.scale = TILE_SCALE;
    if ( tileArray.count != 0 ) {
        if ( tileArray.count % NUMBER_OF_TILES_ONSCREEN_X == 0 ) {
            x = tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
            y = ( ( CCSprite * )( [ tileArray lastObject ] ) ).position.y - tileSprite.contentSize.height * tileSprite.scaleY;
        } else {
            x = ( ( CCSprite * )[ tileArray lastObject ] ).position.x + tileSprite.contentSize.width * tileSprite.scaleX;
            y = ( ( CCSprite * )( [ tileArray lastObject ] ) ).position.y;
        }
    } else {
        x += tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
        y -= tileSprite.contentSize.height * tileSprite.scaleY*0.5f;
    }
    tileSprite.position = ccp( x, y );
    [ self addChild: tileSprite ];
    [ tileArray addObject: tileSprite ];
}

/*
 ====================
 appendNewColorTestTile
 ====================
 */
-( void ) appendNewColorTestTile {
    CGSize size = [ [ CCDirector sharedDirector ] winSize ];
    float x = 0;
    float y = size.height;
    
    CCMutableTexture2D *tileMutableTexture = [ [ CCMutableTexture2D alloc ] initWithSize: CGSizeMake( TILE_SIZE, TILE_SIZE ) pixelFormat: kCCTexture2DPixelFormat_Default ];
    [ tileMutableTexture setAliasTexParameters ];
    [ tileMutableTexture fill: random_color ];
    [ tileMutableTexture apply ];
    
    CCSprite *tileSprite = [ CCSprite spriteWithTexture: tileMutableTexture ];
    tileSprite.scale = TILE_SCALE;
    
    if ( tileArray.count != 0 ) {
        if ( tileArray.count % 10 == 0 ) {
            x = tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
            y = ( ( CCSprite * )( [ tileArray lastObject ] ) ).position.y - tileSprite.contentSize.height * tileSprite.scaleY;
        } else {
            x = ( ( CCSprite * )[ tileArray lastObject ] ).position.x + tileSprite.contentSize.width * tileSprite.scaleX;
            y = ( ( CCSprite * )( [ tileArray lastObject ] ) ).position.y;
        }
    } else {
        x += tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
        y -= tileSprite.contentSize.height * tileSprite.scaleY*0.5f;
    }
    tileSprite.position = ccp( x, y );
    [ self addChild: tileSprite ];
    [ tileArray addObject: tileSprite ];
}

/*
 ====================
 initializeTileArray
 ====================
 */
-( void ) initializeTileArray {
    tileArray = [[ NSMutableArray alloc ] init ];
}

/*
 ====================
 addBlankTiles
 ====================
 */
-( void ) addBlankTiles {
    for ( int i = 0 ; i < NUMBER_OF_TILES_ONSCREEN ; i++ ) {
       [ self appendNewTile ];
    }
}

/*
 ====================
 addColorTiles
 ====================
 */
-( void ) addColorTiles {
    tileArray = [ NSMutableArray arrayWithCapacity: NUMBER_OF_TILES_ONSCREEN ];
    for ( int i = 0 ; i < NUMBER_OF_TILES_ONSCREEN ; i++ ) {
        [ self appendNewColorTestTile ];
    }
}

/*
 ====================
 initializeTiles
 ====================
 */
-( void ) initializeTiles {
    [ self initializeTileArray ];
    [ self addBlankTiles ];
}

/*
 ====================
 initializeTileData
 ====================
 */
-( Tile * ) getTileForCGPoint: ( CGPoint ) p  {
    Tile *tile = nil;
    tile = [[[dungeon objectAtIndex:floorNumber] tileDataArray] objectAtIndex: p.x + ( p.y * [ (DungeonFloor *)[dungeon objectAtIndex:floorNumber] width ] ) ];
    return tile;
}

-( Tile * ) getTileForCGPoint: ( CGPoint ) p forFloor: (DungeonFloor *) _floor {
    Tile *tile = nil;
    tile = [[_floor tileDataArray] objectAtIndex: p.x + ( p.y * _floor.width ) ];
    return tile;
}

-( CCSprite * ) getTileSpriteForCGPoint: ( CGPoint ) p {
    CCSprite *sprite = nil;
    sprite = [ tileArray objectAtIndex: p.x + p.y * NUMBER_OF_TILES_ONSCREEN_X ];
    return sprite;
}

/*
 ====================
 getTileForTouch
 ====================
 */
-( CCSprite * ) getTileForTouch: ( UITouch * ) touch {
    // calculate tile position based on (x,y)
    NSInteger index = [ self getTileIndexForTouch: touch ];
    CCSprite *sprite = [ tileArray objectAtIndex: index ];
    @try {
        sprite = [ tileArray objectAtIndex: index ];
    }
    @catch (NSException *exception) {
        MLOG( @"%@", exception );
    }
    return sprite;
}

/*
 ====================
 getTileForIndex
 ====================
 */
-( Tile * ) getTileForIndex: ( NSInteger ) index {
    Tile *t = nil;
    @try {
        t = [ tileDataArray objectAtIndex: index ];
    } @catch ( NSException *exception ) {
        [ self addEditorHUD: editorHUD ];
        [ self addMessage: [NSString stringWithFormat:@"%@", exception] ];
        [ self addMessage: [NSString stringWithFormat:@"index: %d", index] ];
    }
    return t;
}

/*
 ====================
 getTileIndexForTouch
 ====================
 */
// magic numbers below are for 16x16 tiles w/ 150 tiles on-screen
static BOOL isMagicXArrayInitialized = NO;
static BOOL isMagicYArrayInitialized = NO;

static NSUInteger magicXArray[ 352 ];
static NSUInteger magicYArray[ 480 ];

void initializeMagicXArray() {
    for ( int i = 0; i < 10; i++ ) {
        for ( int j = 0; j < 32; j++ ) {
            magicXArray[ j + (i * 32) ] = i;
        }
    }
}

void initializeMagicYArray() {
    NSUInteger counter = 14;
    for ( int i = 0; i < 14; i++ ) {
        for ( int j = 0; j < 32; j++ ) {
            magicYArray[ j + (i * 32) ] = counter;
        }
        counter--;
    }
}

NSUInteger getMagicX( NSUInteger x ) {
    if ( ! isMagicXArrayInitialized ) {
        initializeMagicXArray();
        isMagicXArrayInitialized = YES;
    }
    return magicXArray[ x ];
    /*
    return
        ( x < 32 ) ? 0 :        // 32 =     0x020 = 0b0 0010 0000    1 << 5
        ( x < 64 ) ? 1 :        // 64 =     0x040 = 0b0 0100 0000    2 << 5
        ( x < 96 ) ? 2 :        // 96 =     0x060 = 0b0 0110 0000    3 << 5
        ( x < 128 ) ? 3 :       // 128 =    0x080 = 0b0 1000 0000    4 << 5
        ( x < 150 ) ? 4 :       // 150 =    0x0a0 = 0b0 1010 0000    5 << 5
        ( x < 192 ) ? 5 :       // 192 =    0x0c0 = 0b0 1100 0000    6 << 5
        ( x < 224 ) ? 6 :       // 224 =    0x0e0 = 0b0 1110 0000    7 << 5
        ( x < 256 ) ? 7 :       // 256 =    0x100 = 0b1 0000 0000    8 << 5
        ( x < 288 ) ? 8 :       // 288 =    0x120 = 0b1 0010 0000    9 << 5
        ( x < 320 ) ? 9 :       // 320 =    0x140 = 0b1 0100 0000   10 << 5
        ( x < 352 ) ? 10 : -1 ; // 352 =    0x160 = 0b1 0110 0000   11 << 5
     */
}


// magic numbers below are for 16x16 tiles w/ 150 tiles on-screen
NSUInteger getMagicY( NSUInteger y ) {
    if ( ! isMagicYArrayInitialized ) {
        initializeMagicYArray();
        isMagicYArrayInitialized = YES;
    }
    return magicYArray[ y ];
}


-( NSInteger ) getTileIndexForTouch: ( UITouch * ) touch {
    CGPoint touchLocation = [ touch locationInView: nil ];
    touchLocation = [ [ CCDirector sharedDirector ] convertToGL: touchLocation ];
    
    NSUInteger x = ( NSUInteger ) touchLocation.x;
    NSUInteger y = ( NSUInteger ) touchLocation.y;
    NSUInteger tx = getMagicX( x );
    NSUInteger ty = getMagicY( y );

    // calculate tile position based on (x,y)
    NSInteger index = tx + ty * 10;
    return index;
}

/*
 ====================
 getTileCGPointForTouch
 ====================
 */
-( CGPoint ) getTileCGPointForTouch: ( UITouch * ) touch {
    CGPoint touchLocation = [ touch locationInView: nil ];
    touchLocation = [ [ CCDirector sharedDirector ] convertToGL: touchLocation ];
    
    NSUInteger x = ( NSUInteger ) touchLocation.x;
    NSUInteger y = ( NSUInteger ) touchLocation.y;
    NSUInteger tx = getMagicX( x );
    NSUInteger ty = getMagicY( y );
    
    // calculate tile position based on (x,y)
    CGPoint returnPoint = ccp( tx, ty );
    return returnPoint;
}

/*
 ====================
 setEntity: entity onTile: tile
 ====================
 */
-( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile {
    entity.positionOnMap = tile.position;
    [ tile addObjectToContents: entity ];
}

/*
 ====================
 translateTouchPointToMapPoint: (CGPoint) touchPoint
 ====================
 */
-( CGPoint ) translateTouchPointToMapPoint: (CGPoint) touchPoint {
    CGPoint c = cameraAnchorPoint;
    CGPoint mapPoint = ccp( touchPoint.x + c.x, touchPoint.y + c.y );
    return mapPoint;
}

/*
 ====================
 getMapTileFromPoint: p
 ====================
 */
-( Tile * ) getMapTileFromPoint: (CGPoint) p {
    Tile *tile = nil;
    for ( Tile *t in [ [dungeon objectAtIndex:floorNumber] tileDataArray ] ) {
        if ( t.position.x == p.x && t.position.y == p.y ) {
            tile = t;
            break;
        }
    }
    return tile;
}

-( Tile * ) getMapTileFromPoint: (CGPoint) p forFloor: (DungeonFloor *) _floor {
    Tile *tile = nil;
    for ( Tile *t in [_floor tileDataArray ] ) {
        if ( t.position.x == p.x && t.position.y == p.y ) {
            tile = t;
            break;
        }
    }
    return tile;
}

#pragma mark - EntityHUD Message code

/*
 ====================
 addMessage: message
 ====================
 */
#define MAX_DISPLAYED_MESSAGES      1
-( void ) addMessage: (NSString * ) message {
    NSString *str = [ NSString stringWithFormat: @"%@\n",
                     message ];
    [ dLog addObject: str ];
    if ( [ dLog count ] > MAX_DISPLAYED_MESSAGES ) {
        dLogIndex++;
    }
}

#pragma mark - Entity code

/*
 ====================
 getEntityForName: name
 
 returns the entity for the given name
 ====================
 */
-( Entity * ) getEntityForName: ( NSString * ) name {
    Entity *entity = nil;
    for ( Entity *e in [[dungeon objectAtIndex:floorNumber] entityArray] ) {
        if ( [e.name isEqualToString: name ] ) {
            entity = e;
            break;
        }
    }
    return entity;
}

/*
 ====================
 getEntityForPosition: p
 
 returns the entity for the given position on the current floor
 ====================
 */
-( Entity * ) getEntityForPosition: (CGPoint) p {
    Entity *entity = nil;
    for ( Entity *e in [[dungeon objectAtIndex:floorNumber] entityArray] ) {
        if ( e.positionOnMap.x == p.x && e.positionOnMap.y == p.y ) {
            entity = e;
            break;
        }
    }
    return entity;
}

/*
 ====================
 moveEntity: entity toPosition: position
 
 moves the entity on the map to position
 ====================
 */

-( BOOL ) moveEntity:(Entity *)entity toPosition:(CGPoint)position {
    return [ self moveEntity: entity toPosition:position onFloor:[dungeon objectAtIndex:floorNumber ] ];
}

/*
 ====================
 moveEntity: entity toPosition: position onFloor: floor
 
 moves the entity on the map to position on given dungeon floor
 ====================
 */
-( BOOL ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position onFloor: (DungeonFloor *) _floor {
    MLOG( @"moveEntity: %@ toPosition: (%f, %f)", entity.name, position.x, position.y );
    BOOL retVal = FALSE;
    
    Tile *tile = [ self getMapTileFromPoint: position forFloor: _floor ];
    if ( tile.tileType != TILE_FLOOR_VOID ) {
        
        BOOL isMoveValid    = YES;
        BOOL npcExists      = NO;
        BOOL pcExists       = NO;
        BOOL itemExists     = NO;
        BOOL boulderExists  = NO;
        BOOL doorExists     = NO;
        BOOL boulderMoved = NO;
        // check if there is an NPC...
        
        for ( Entity *e in [tile contents] ) {
            if ( e.entityType == ENTITY_T_NPC ) {
                isMoveValid = NO;
                npcExists   = YES;
                pcExists    = NO;
                boulderExists = NO;
                doorExists  = NO;
                retVal      = FALSE;
                break;
            }
            else if ( e.entityType == ENTITY_T_PC ) {
                isMoveValid = NO;
                npcExists   = NO;
                pcExists    = YES;
                boulderExists = NO;
                doorExists  = NO;
                retVal      = FALSE;
                break;
            }
            else if ( e.entityType == ENTITY_T_ITEM ) {
                
                isMoveValid = YES;
                itemExists  = YES;
                doorExists  = NO;
                retVal      = TRUE;
                
                // moving into boulder
                if ( e.itemType == E_ITEM_T_BASICBOULDER ) {
                    itemExists = NO;
                    boulderExists = YES;
                }
                // boulder moving into door
                else if ( entity.itemType == E_ITEM_T_BASICBOULDER && e.itemType == E_ITEM_T_DOOR_SIMPLE ) {
                    isMoveValid = NO;
                    itemExists = NO;
                    doorExists = YES;
                }
                // moving into door
                else if ( e.itemType == E_ITEM_T_DOOR_SIMPLE ) {
                    isMoveValid = e.doorOpen;
                    itemExists = NO;
                    doorExists = YES;
                }
            }
        }
        if ( isMoveValid ) {
            retVal = TRUE;
            
            if ( boulderExists ) {
                // check if there is boulder we are moving to
                Entity *boulder = [self getEntityForPosition:position];
                
                /*
                 to handle boulders,
                 
                 i need to know which direction the player is coming from
                 this will simply require comparing player position to boulder position
                 
                 1.     2.    3. o   4.o  5.o    6.    7.    8.
                 p     po    p      p     p     op    p      p
                 o                                  o       o
                 
                 o.x=p.x+1,  p.x+1,  p.x+1,    p.x,    p.x-1,  p.x-1,  p.x-1,  p.x,
                 o.y=p.y+1   p.y,    p.y-1,    p.y-1,  p.y-1,  p.y,    p.y+1,  p.y+1
                 */
                
                CGPoint p = entity.positionOnMap;
                CGPoint o = boulder.positionOnMap; // should be == position
                
                if ( o.x == p.x + 1 && o.y == p.y + 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x+1, o.y+1) ];
                } else if ( o.x == p.x + 1 && o.y == p.y ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x+1, o.y) ];
                } else if ( o.x == p.x + 1 && o.y == p.y - 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x+1, o.y-1) ];
                } else if ( o.x == p.x && o.y == p.y - 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x, o.y-1) ];
                } else if ( o.x == p.x - 1 && o.y == p.y - 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x-1, o.y-1) ];
                } else if ( o.x == p.x - 1 && o.y == p.y ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x-1, o.y) ];
                } else if ( o.x == p.x - 1 && o.y == p.y + 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x-1, o.y+1) ];
                } else if ( o.x == p.x && o.y == p.y + 1 ) {
                    boulderMoved = [ self moveEntity:boulder toPosition:ccp(o.x, o.y+1) ];
                }
                
                //retVal = boulderExists ? [self moveEntity:entity toPosition:position] : FALSE;
                retVal = boulderMoved ? [self moveEntity:entity toPosition:position] : FALSE;
                
            } else {
                
                // perform the entity placement-swap
                Tile *prevTile = [ self getTileForCGPoint: entity.positionOnMap ];
                [prevTile removeObjectFromContents:entity];
                [ GameRenderer setEntity: entity onTile:tile ];
                    
                if ( entity == pcEntity ) {
                    if ( tile.tileType == TILE_FLOOR_DOWNSTAIRS ) {
                        [ self addMessage: @"Going downstairs..." ];
                        [ self addMessageWindowString: @"Going downstairs..." ];
                        //MLOG(@"Going downstairs...");
                        [ self goingDownstairs ];
                    } else if ( tile.tileType == TILE_FLOOR_UPSTAIRS ) {
                        if ( floorNumber != 0 ) {
                            [ self addMessage: @"Going upstairs..." ];
                            [ self addMessageWindowString: @"Going upstairs..." ];
                            //MLOG(@"Going upstairs...");
                        }
                        [ self goingUpstairs ];
                    }
                    
                    else if ( tile.tileType == TILE_FLOOR_STONE_TRAP_SPIKES_D6 ) {
                        
                        if ( tile.trapIsSet ) {
                            
                            [self addMessageWindowString:@"You walk onto a trap!"];
                            tile.trapIsSet = NO;
                            [self handleTrapSetOffPC];
                            
                        } else {
                            
                            [self addMessageWindowString:@"There is a disarmed trap here"];
                            
                        }
                        
                    }
                    
                    
                    
                    else if ( itemExists ) {
                        // list all items on the tile
                        if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_NONE ) {
                            for ( Entity *e in [tile contents] ) {
                                if ( e.entityType == ENTITY_T_ITEM ) {
                                    MLOG( @"There is a %@ here", e.name );
                                    [ self addMessage: [NSString stringWithFormat:@"There is a %@ here", e.name]];
                                    [ self addMessageWindowString: [NSString stringWithFormat:@"There is a %@ here", e.name]];
                                }
                            }
                        } else if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE ) {
                            Entity *item = nil;
                            for ( Entity *e in [tile contents] ) {
                                if ( e.entityType == ENTITY_T_ITEM ) {
                                    MLOG( @"There is a %@ here", e.name );
                                    [ self addMessage: [NSString stringWithFormat:@"There is a %@ here", e.name]];
                                    [ self addMessageWindowString: [NSString stringWithFormat:@"There is a %@ here", e.name]];
                                    item = e;
                                    break;
                                }
                            }
                            if ( item != nil ) {
                                // add the item to your inventory
                                if ( item.itemType != E_ITEM_T_DOOR_SIMPLE ) {
                                    [ self handleItemPickup: item forEntity: entity ];
                                }
                            }
                        }
                    } else if ( doorExists ) {
                        //[self addMessageWindowString: @"There is an open door here"];
                    }
                } else if ( entity.entityType == ENTITY_T_NPC ) {
                    // not handling NPCs going up/downstairs yet...
                }
            }
        }
        else if ( npcExists ) {
            // moving into npc
            // check npc hostility
            
            // without this check, boulders can 'attack' when moved into an enemy
            // this might be cool...
            entity.itemType != E_ITEM_T_BASICBOULDER ? [ self handleAttackForEntity:entity toPosition:position] : 0;
        } else if ( pcExists ) {
            // moving into pc
            // without this check, boulders can 'attack' when moved into an enemy
            // this might be cool...
            entity.itemType != E_ITEM_T_BASICBOULDER ? [ self handleAttackForEntity:entity toPosition:position] : 0;
            
        } else if ( doorExists ) {
            
            //MLOG(@"%@: door exists", entity.name);
            // to fix crashing when moving boulders into doors
            if ( entity.itemType != E_ITEM_T_BASICBOULDER ) {
                Entity *door = [self getEntityForPosition:position];
                if ( door!=nil && door.itemType == E_ITEM_T_DOOR_SIMPLE) {
                    if ( door.doorLocked )
                        [self addMessageWindowString: @"The door is locked" ];
                    else {
                        if ( ! door.doorOpen ) {
                            door.doorOpen = YES;
                            [self addMessageWindowString:@"The door is now open"];
                        }
                    }
                }
            }
            else {
                //[self addMessageWindowString:@"Boulder cannot move into door!"];
                retVal = FALSE;
            }
            
            
        } else {
            //MLOG( @"Attempting to move into NPC." );
        }
    } else {
        retVal = FALSE;
    }
    
    if ( entity.isPC || entity.entityType == ENTITY_T_NPC) {
        [entity getHungry];
    }
    return retVal;
}


/*
 ====================
 handleTrapSetOffPC
 
 handles when a tile trap is set off by the pc
 ====================
 */
-( void ) handleTrapSetOffPC {
    CGPoint pcPos = pcEntity.positionOnMap;
    
    Tile *t = [self getMapTileFromPoint:pcPos];
    
    if ( t.tileType == TILE_FLOOR_STONE_TRAP_SPIKES_D6 ) {
        
        // chance to set trap off
        NSInteger chanceToSetOffTrap = 10;
        NSInteger roll = [Dice roll:100];
 
        [self addMessageWindowString: [NSString stringWithFormat:@"Trap! Saving throw...%d!", roll]];
        
        // set off trap
        if (roll < chanceToSetOffTrap) {
            // deal damage to pc
            NSInteger totaldamage = [Dice roll:6];
            totaldamage = (totaldamage > 0) ? totaldamage : 0;
            pcEntity.hp -= totaldamage;
            
            [ self addMessageWindowString: [ NSString stringWithFormat:@"%@ took %d damage", pcEntity.name, totaldamage ]];
            
            [self didPCDieJustNow];
        }
        else {
            [ self addMessageWindowString: [ NSString stringWithFormat:@"Success!" ]];
        }
    }
}


/*
 ====================
 didPCDieJustNow
 
 checks to see if the PC is alive / has hp
 ====================
 */
-( BOOL ) didPCDieJustNow {
    BOOL retVal = NO;
    if ( pcEntity.hp <= 0 ) {
        retVal = YES;
        // check if they got the book of all-knowing
        BOOL hasBook = NO;
        for ( Entity *e in pcEntity.inventoryArray ) {
            if ( e.itemType == E_ITEM_T_BOOK ) {
                hasBook = YES;
                break;
            }
        }
        [ self addMessage: [NSString stringWithFormat:@"You died.\nYou killed %d monsters.\nYou %@ the Book of All-Knowing.\n",
                            pcEntity.totalKills,
                            hasBook ? @"got" : @"did not get" ] ];
        [ self addMessageWindowString: [NSString stringWithFormat:@"You died.\nYou killed %d monsters.\nYou %@ the Book of All-Knowing.\n",
                                        pcEntity.totalKills,
                                        hasBook ? @"got" : @"did not get" ] ];
        
        for ( NSString *_name in killList )
            [ self addMessageWindowString: [NSString stringWithFormat:@"You killed a %@", _name]];
        
        pcEntity.isAlive = NO;
        gameLogicIsOn = YES;
        autostepGameLogic = NO;
        gameState = GAMESTATE_T_GAME_PC_DEAD;
        [ self unscheduleStepAction ];
    }
    
    return retVal;
}



/*
 ====================
 selectTileAtPosition: position
 
 selects/deselects the tile at given position
 ====================
 */
-( void ) selectTileAtPosition: ( CGPoint ) position {
    if ( selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0 ) {
        Tile *prevTile = [ self getMapTileFromPoint: selectedTilePoint ];
        prevTile.isSelected = NO;
        selectedTilePoint.x = -1;
        selectedTilePoint.y = -1;
        
        if ( position.x >= 0 && position.y >= 0 ) {
            Tile *tile = [ self getMapTileFromPoint: position ];
            if ( prevTile.position.x == position.x && prevTile.position.y == position.y ) {
                tile.isSelected = NO;
                selectedTilePoint.x = -1;
                selectedTilePoint.y = -1;
            } else {
                tile.isSelected = ! tile.isSelected;
                if ( tile.isSelected ) {
                    selectedTilePoint.x = position.x;
                    selectedTilePoint.y = position.y;
                } else {
                    selectedTilePoint.x = -1;
                    selectedTilePoint.y = -1;
                }
            }
        } else {
            // invalid point fed into selection
            //MLOG( @"Invalid point: (%.0f,%.0f)", position.x, position.y );
        }
    } else {
        if ( position.x >= 0 && position.y >= 0 ) {
            Tile *tile = [ self getMapTileFromPoint: position ];
            tile.isSelected = YES;
            selectedTilePoint = position;
        } else {
            // invalid point fed into selection
            //MLOG( @"Invalid point: (%.0f,%.0f)", position.x, position.y );
        }
    }
}

/*
 ====================
 resetCameraPosition
 
 resets the camera position relative to the pcEntity
 ====================
 */
-( void ) resetCameraPosition {
    // reset the camera position
    cameraAnchorPoint.x = pcEntity.positionOnMap.x - 5;
    cameraAnchorPoint.y = pcEntity.positionOnMap.y - 7;
}

/*
 ====================
 distanceFromTile: toTile:
 
 returns distance from a tile to another
 ====================
 */
-( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b {
    NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}

/*
 ====================
 distanceFromCGPoint: toCGPoint:
 
 returns distance from a cgpoint to another
 ====================
 */
-( NSInteger ) distanceFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    //MLOG( @"distanceFromTile: a toTile: b" );
    NSInteger ax = (NSInteger)a.x;
    NSInteger bx = (NSInteger)b.x;
    NSInteger ay = (NSInteger)a.y;
    NSInteger by = (NSInteger)b.y;
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}

/*
 ====================
 nearestCGPointFromCGPoint: a toCGPoint: b
 
 returns the nearest cgpoint surrounding a to b
 ====================
 */
-( CGPoint ) nearestCGPointFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    CGPoint nearest = { 0, 0 };
    
    // check that a!=b
    if ( a.x == b.x && a.y == b.y ) {
        nearest.x = a.x;
        nearest.y = a.y;
    } else {
        CGPoint ul, u, ur, l, r, dl, d, dr;
        ul = ccp( a.x-1, a.y-1 );
        u  = ccp( a.x+0, a.y-1 );
        ur = ccp( a.x+1, a.y-1 );
        l  = ccp( a.x-1, a.y+0 );
        r  = ccp( a.x+1, a.y+0 );
        dl = ccp( a.x-1, a.y+1 );
        d  = ccp( a.x+0, a.y+1 );
        dr = ccp( a.x+1, a.y+1 );
        
        NSInteger uld = [ self distanceFromCGPoint:ul toCGPoint:b ];
        NSInteger ud  = [ self distanceFromCGPoint:u  toCGPoint:b ];
        NSInteger urd = [ self distanceFromCGPoint:ur toCGPoint:b ];
        NSInteger ld  = [ self distanceFromCGPoint:l  toCGPoint:b ];
        NSInteger rd  = [ self distanceFromCGPoint:r  toCGPoint:b ];
        NSInteger dld = [ self distanceFromCGPoint:dl toCGPoint:b ];
        NSInteger dd  = [ self distanceFromCGPoint:d  toCGPoint:b ];
        NSInteger drd = [ self distanceFromCGPoint:dr toCGPoint:b ];
        
        NSInteger min = NSIntegerMax;
        if ( uld <= min ) { min = uld; nearest = ul; }
        if ( ud  <= min ) { min = ud;  nearest = u;  }
        if ( urd <= min ) { min = urd; nearest = ur; }
        if ( ld  <= min ) { min = ld;  nearest = l;  }
        if ( rd  <= min ) { min = rd;  nearest = r;  }
        if ( dld <= min ) { min = dld; nearest = dl; }
        if ( dd  <= min ) { min = dd;  nearest = d;  }
        if ( drd <= min ) { min = drd; nearest = dr; }
    }
    return nearest;
}

/*
 ====================
 nearestNonVoidCGPointFromCGPoint: a toCGPoint: b
 
 returns nearest non-void cgpoint surrounding a to b
 ====================
 */
-( CGPoint ) nearestNonVoidCGPointFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    CGPoint nearest = { 0, 0 };
    if ( a.x == b.x && a.y == b.y ) {
        nearest.x = a.x;
        nearest.y = a.y;
    } else {
        CGPoint ul, u, ur, l, r, dl, d, dr;
        ul = ccp( a.x-1, a.y-1 );
        u  = ccp( a.x+0, a.y-1 );
        ur = ccp( a.x+1, a.y-1 );
        l  = ccp( a.x-1, a.y+0 );
        r  = ccp( a.x+1, a.y+0 );
        dl = ccp( a.x-1, a.y+1 );
        d  = ccp( a.x+0, a.y+1 );
        dr = ccp( a.x+1, a.y+1 );
        
        NSInteger uld = [ self distanceFromCGPoint:ul toCGPoint:b ];
        NSInteger ud  = [ self distanceFromCGPoint:u  toCGPoint:b ];
        NSInteger urd = [ self distanceFromCGPoint:ur toCGPoint:b ];
        NSInteger ld  = [ self distanceFromCGPoint:l  toCGPoint:b ];
        NSInteger rd  = [ self distanceFromCGPoint:r  toCGPoint:b ];
        NSInteger dld = [ self distanceFromCGPoint:dl toCGPoint:b ];
        NSInteger dd  = [ self distanceFromCGPoint:d  toCGPoint:b ];
        NSInteger drd = [ self distanceFromCGPoint:dr toCGPoint:b ];
        
        NSInteger min = NSIntegerMax;
        CGPoint points[ 8 ] = { ul, u, ur, l, r, dl, d, dr };
        NSInteger distances[ 8 ] = { uld, ud, urd, ld, rd, dld, dd, drd };
        for ( int i = 0; i < 8; i++ ) {
            if ( distances[i] <= min && ((Tile *)[self getTileForCGPoint:points[i] forFloor:[dungeon objectAtIndex:floorNumber]]).tileType != TILE_FLOOR_VOID ) {
                min = distances[i];
                nearest = points[i];
            }
        }
    }
    return nearest;
}

-( NSArray * ) nearestNonVoidCGPointsForCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    CGPoint ul, u, ur, l, r, dl, d, dr;
    ul = ccp( a.x-1, a.y-1 );
    u  = ccp( a.x+0, a.y-1 );
    ur = ccp( a.x+1, a.y-1 );
    l  = ccp( a.x-1, a.y+0 );
    r  = ccp( a.x+1, a.y+0 );
    dl = ccp( a.x-1, a.y+1 );
    d  = ccp( a.x+0, a.y+1 );
    dr = ccp( a.x+1, a.y+1 );
    
    NSMutableArray *array = [ NSMutableArray array ];
    [array addObject: [NSValue valueWithCGPoint:ul]];
    [array addObject: [NSValue valueWithCGPoint:u ]];
    [array addObject: [NSValue valueWithCGPoint:ur]];
    [array addObject: [NSValue valueWithCGPoint:l ]];
    [array addObject: [NSValue valueWithCGPoint:r ]];
    [array addObject: [NSValue valueWithCGPoint:dl]];
    [array addObject: [NSValue valueWithCGPoint:d ]];
    [array addObject: [NSValue valueWithCGPoint:dr]];
    
    for ( int i = 0; i < array.count; i++ ) {
        CGPoint p = ((NSValue *)[ array objectAtIndex: i ]).CGPointValue;
        if ( ((Tile *)[self getTileForCGPoint:p forFloor:[dungeon objectAtIndex:floorNumber]]).tileType == TILE_FLOOR_VOID ) {
            [ array removeObjectAtIndex: i ];
            i = 0;
        }
    }
    return array;
}

#pragma mark - Initialization helper code
/*
 ====================
 initializeDungeon
 ====================
 */
-( void ) initializeDungeon {
    [ self initializeTiles ];
    NSUInteger numberOfFloors = 20;
    dungeon = [[ NSMutableArray alloc ] init ];
    for ( int i = 0; i < numberOfFloors; i++ ) {
        DungeonFloor *newFloor = [ DungeonFloor newFloorWidth:40 andHeight:40 andFloorNumber: i ];
        if ( i != numberOfFloors - 1 ) {
            [ GameRenderer generateDungeonFloor:newFloor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
        } else {
            [ GameRenderer generateDungeonFloor:newFloor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR ];
        }
        [ dungeon addObject: newFloor ];
    }
    floorNumber = 0;
}

/*
 ====================
 goingUpstairs
 ====================
 */
-( void ) goingUpstairs {
    if ( floorNumber == 0 ) {
        // top floor
    }
    else {
        floorNumber--;
        [[[ dungeon objectAtIndex:floorNumber+1 ] entityArray ] removeObject: pcEntity ];
        
        // TODO: move setEntityOnDownstairs to GameRenderer (DungeonMaster)
        [ self setEntityOnDownstairs: pcEntity ];
        [[[ dungeon objectAtIndex:floorNumber ] entityArray ] addObject: pcEntity ];
        needsRedraw = YES;
    }
}

/*
 ====================
 goingDownstairs
 ====================
 */
-( void ) goingDownstairs {
    if ( floorNumber < [ dungeon count ] - 1 ) {
        floorNumber++;
        
        // TODO: move setEntityOnUpstairs to GameRenderer (DungeonMaster)
        [[[ dungeon objectAtIndex:floorNumber-1 ] entityArray ] removeObject: pcEntity ];
        [ self setEntityOnUpstairs: pcEntity ];
        [[[ dungeon objectAtIndex:floorNumber ] entityArray ] addObject: pcEntity ];
        needsRedraw = YES;
    } else {
        // bottom floor        
    }
}

/*
 ====================
 setEntityOnUpstairs: entity
 ====================
 */
-( void ) setEntityOnUpstairs:(Entity *)entity {
    // find the upstairs tile
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: [dungeon objectAtIndex:floorNumber] ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ [dungeon objectAtIndex:floorNumber] tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [ GameRenderer setEntity:entity onTile:tile];
}

/*
 ====================
 setEntityOnUpstairs: entity forFloor: floor
 ====================
 */
-( void ) setEntityOnUpstairs:(Entity *)entity forFloor: (DungeonFloor *) _floor {
    // find the upstairs tile
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: _floor ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ _floor tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [ GameRenderer setEntity:entity onTile:tile];
}

/*
 ====================
 setEntity: entity onRandomTileForFloor: floor
 ====================
 */
-( void ) setEntity: (Entity *) entity onRandomTileForFloor: (DungeonFloor *) _floor {
    CGPoint startPoint = ccp( 10, 10 );
    Tile *tile = nil;
    for ( Tile *t in [ _floor tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [GameRenderer setEntity:entity onTile:tile];
}

/*
 ====================
 setEntityOnDownstairs: entity forFloor: floor
 ====================
 */
-( void ) setEntityOnDownstairs:(Entity *)entity forFloor: (DungeonFloor *) _floor {
    // find the upstairs tile
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: floor ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ _floor tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [ GameRenderer setEntity:entity onTile:tile];
}

/*
 ====================
 setEntityOnDownstairs: entity
 ====================
 */
-( void ) setEntityOnDownstairs:(Entity *)entity {
    // find the downstairs tile
    CGPoint startPoint = [ GameRenderer getDownstairsTileForFloor:[dungeon objectAtIndex:floorNumber] ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ [dungeon objectAtIndex:floorNumber] tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [ GameRenderer setEntity:entity onTile:tile];
}

/*
 ====================
 initializeHUDs
 
 initializes the various HUDs used by the game
 ====================
 */
-( void ) initializeHUDs {
    editorHUDIsVisible = NO;
    [ self initEditorHUD ];
    //[ self addEditorHUD: editorHUD ];
   
    playerHUDIsVisible = NO;
    [ self initPlayerHUD ];
    [ self addPlayerHUD: playerHUD ];
    
    monitorIsVisible = NO;
    [ self initMonitor ];
    [ self addMonitor: monitor ];    
    
    playerMenuIsVisible = NO;
    [ self initPlayerMenu ];
    [ self addPlayerMenu: playerMenu ];
    
    playerMenuMin = NO;
    [ self initPlayerMenuMin ];
    // [ self addPlayerMenuMin: playerMenuMin ];
    
    entityInfoHUDIsVisible = NO;
    [ self initEntityInfoHUD ];
    //[ self addEntityInfoHUD: entityInfoHUD ];
    
    gearHUDIsVisible = NO;
    [ self initGearHUD ];
   // [ self addGearHUD: gearHUD ];
    
    //hudMenuIsVisible = NO;
    //[ self initHUDMenu ];
    // [ self addHUDMenu: hudMenu ];
    
    statusMenuIsVisible = NO;
    [self initStatusMenu];
    // [self addStatusMenu];
    
    inventoryMenuIsVisible = NO;
    [self initInventoryMenu];
    //[self addInventoryMenu];
    
    helpMenuIsVisible = NO;
    [self initHelpMenu];
    //[self addHelpMenu];
    
    equipMenuIsVisible = NO;
    [self initEquipMenu];
    //[self addEquipMenu];
    
    messageWindowIsVisible = NO;
    [self initMessageWindow];
    
    [self addMessageWindowString: [NSString stringWithFormat: @"Welcome to Project-A %@", GAME_VERSION]];
    [self displayMessageWindow];
}

/*
 ====================
 initializePCEntity
 
 initializes the PC Entity
 ====================
 */
-( void ) initializePCEntity {
    Entity *hero = [ [ Entity alloc ] init ];
    [ hero.name setString: @"Mike" ];
    hero.entityType = ENTITY_T_PC;
    hero.isPC = YES;
    //hero.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    hero.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SIMPLE;
    //hero.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE;
    hero.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    
    hero.level = 1;
    hero.strength       = [Dice roll:6 nTimes:3];
    hero.dexterity      = [Dice roll:6 nTimes:3];
    hero.constitution   = [Dice roll:6 nTimes:3];
    hero.intelligence   = [Dice roll:6 nTimes:3];
    hero.wisdom         = [Dice roll:6 nTimes:3];
    hero.charisma       = [Dice roll:6 nTimes:3];
    
    // stat tolerance
    NSUInteger _tolerance = 12;
    while (hero.strength < _tolerance)      hero.strength       = [Dice roll:6 nTimes:3];
    while (hero.dexterity < _tolerance)     hero.dexterity      = [Dice roll:6 nTimes:3];
    while (hero.constitution < _tolerance)  hero.constitution   = [Dice roll:6 nTimes:3];
    while (hero.intelligence < _tolerance)  hero.intelligence   = [Dice roll:6 nTimes:3];
    while (hero.wisdom < _tolerance)        hero.wisdom         = [Dice roll:6 nTimes:3];
    while (hero.charisma < _tolerance)      hero.charisma       = [Dice roll:6 nTimes:3];
    
    NSInteger conMod = [GameRenderer modifierForNumber:hero.constitution];
    NSUInteger pcHD = 12;
    hero.maxhp = [Dice roll:pcHD] + conMod;
    hero.hp = hero.maxhp;
    hero.ac = 10;
    
    //using fists...
    hero.damageRollBase = 6;
    pcEntity = hero;
}

/*
 ====================
 getGameStateString: state
 
 returns a string for the given state
 ====================
 */
-( NSString * ) getGameStateString: ( GameState_t ) state {
    NSString *retval = nil;
    retval =
    state == GAMESTATE_T_GAME               ? @"GAMESTATE_T_GAME" :
    state == GAMESTATE_T_GAME_PC_SELECTMOVE ? @"GAMESTATE_T_GAME_PC_SELECTMOVE" :
    state == GAMESTATE_T_GAME_PC_STEP       ? @"GAMESTATE_T_GAME_PC_STEP" :
    state == GAMESTATE_T_MAINMENU           ? @"GAMESTATE_T_MAINMENU" :
    state == GAMESTATE_T_GAME_PC_DEAD       ? @"GAMESTATE_T_GAME_PC_DEAD" :
    state == GAMESTATE_T_GAME_PC_FISHING_PRECAST ? @"GAMESTATE_T_GAME_PC_FISHING_PRECAST" :
    [NSString stringWithFormat:@"STATE: %d", state];
    
    return retval;
}

#pragma mark - Game Logic code

-( void ) haveAllEntitiesActOnThisFloor {
    [self haveAllEntitiesActOnFloor:[dungeon objectAtIndex:floorNumber]];
}

-( void ) haveAllEntitiesActOnFloor:(DungeonFloor *) _floor {
    for ( int i = 0; i < [[_floor entityArray] count]; i++ ) {
        @try {
            Entity *e = [[_floor entityArray] objectAtIndex: i];
            if ( e.entityType != ENTITY_T_PC && e.isAlive
                && e.entityType != ENTITY_T_ITEM ) {
                [ e step ];
                [ self handleEntityStep: e ];
            }
        }
        @catch (NSException *exception) {
            MLOG(@"Exception caught!  %@", exception);
        }
    }
}

/*
 ====================
 stepGameLogic
 
 steps the game's logic forward
 ====================
 */
-( void ) stepGameLogic {
    if ( gameLogicIsOn ) {
          // check if we've obtained the Book of All-Knowing
        BOOL hasTheBook = NO;
        for(Entity*e in pcEntity.inventoryArray){if(e.itemType==E_ITEM_T_BOOK&&[e.name isEqualToString:@"Book of All-Knowing"]){hasTheBook=YES;break;}}
        
        // check player's hunger
        if ( pcEntity.isAlive ) {
            if ( pcEntity.hunger >= 250 ) {
                MLOG(@"You starved to death...");
                [ self addMessage: [NSString stringWithFormat:@"You starved to death.\nYou killed %d monsters.\n",
                                    pcEntity.totalKills ]];
                [ self addMessageWindowString: [NSString stringWithFormat:@"You starved to death.\nYou killed %d monsters.\n",
                                                pcEntity.totalKills ] ];
                gameLogicIsOn       = NO;
                autostepGameLogic   = NO;
                gameState           = GAMESTATE_T_GAME_PC_DEAD;
                [ self unscheduleStepAction ];
            }
        }
        
        [ self cleanupEntityArray ];
        
        // have all entities on this floor act
        [ self haveAllEntitiesActOnThisFloor ];
        [ self cleanupEntityArray ];
 
        @try {
            // spawn a new monster on the current floor
            [ GameRenderer spawnRandomMonsterAtRandomLocationOnFloor:[ dungeon objectAtIndex:floorNumber] withPC:pcEntity withChanceDie: 10 ];
            
            Tile *tile = [ self getTileForCGPoint: pcEntity.positionOnMap ];
            
            // check if we've won
            if ( floorNumber == 0 &&    tile.tileType == TILE_FLOOR_UPSTAIRS &&     hasTheBook ) {
                [ self addMessage:[NSString stringWithFormat: @"You win!\nYou killed %d monsters\n", pcEntity.totalKills ] ];
                [ self addMessageWindowString:[NSString stringWithFormat: @"You win!\nYou killed %d monsters\n", pcEntity.totalKills ] ];
                gameLogicIsOn       = NO;
                autostepGameLogic   = NO;
                [ self unscheduleStepAction ];
                for ( int i = 0; i < dLog.count; i++ ) {
                    MLOG(@"%d. %@", i, [dLog objectAtIndex:i]);
                }
            }
        }
        @catch (NSException *exception) {
            MLOG(@"Exception caught: %@", exception);
        }
        
        // increase turn counter
        [self incrementTurn];
        needsRedraw = YES;
        // show accumulated messages and lock screen
        [ self displayMessageWindow ];
    }
}

/*
 ====================
 handleEntityStep: e
 
 handle the step for entity e
 ====================
 */
-( void ) handleEntityStep: ( Entity * ) e {
    MLOG(@"Handling Entity Step...");
    if (e.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM ) {
        
        BOOL rollIsUnacceptable = YES;
        CGPoint newPosition;
        while ( rollIsUnacceptable ) {
            NSUInteger roll = [Dice roll:8];
            CGFloat x = -1;
            CGFloat y = -1;
            
            // UDLR UL, UR, DL, DR
            if ( roll == 1 ) {
                x = 0;
                y = -1;
            } else if ( roll == 2 ) {
                x = 0;
                y = 1;
            } else if ( roll == 3) {
                x = -1;
                y = 0;
            } else if ( roll == 4) {
                x = 1;
                y = 0;
            } else if ( roll == 5) {
                x = -1;
                y = -1;
            } else if ( roll == 6) {
                x = 1;
                y = -1;
            } else if ( roll == 7) {
                x = -1;
                y = 1;
            } else if ( roll == 8) {
                x = 1;
                y = 1;
            }
            
            newPosition.x = e.positionOnMap.x + x;
            newPosition.y = e.positionOnMap.y + y;
            
            Tile *tile = [ self getTileForCGPoint: newPosition ];
            rollIsUnacceptable = tile.tileType == TILE_FLOOR_VOID;
        }
        
        // try to move the entity to the new position
        // TODO: move movEntity to GameRenderer
        MLOG(@"Moving entity to newPosition (%.0f,%.0f)", newPosition.x, newPosition.y);
        
        [ self moveEntity:e toPosition: newPosition ];
    }
    else if (e.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_SMART_RANDOM ) {
        // calculate newPosition
        // friendly smart_random does nothing for now
        //CGPoint newPosition = e.positionOnMap;
        //[ self moveEntity:e toPosition:newPosition ];
    } else if (e.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_FOLLOW_PC_STRICT ) {
        if ( e.monsterType == MONSTER_T_CAT ) {
            if ( ! e.wasBumped ) {
        
                // calculate move for turn
                // check if next to the PC
                CGPoint basePos = e.positionOnMap;
                CGPoint pcPos = pcEntity.positionOnMap;
                CGPoint newPosition;
                
                CGPoint p1, p2, p3, p4, p5, p6, p7, p8;
                p1 = ccp( basePos.x - 1, basePos.y - 1);
                p2 = ccp( basePos.x, basePos.y - 1);
                p3 = ccp( basePos.x + 1, basePos.y - 1);
                p4 = ccp( basePos.x - 1, basePos.y );
                p5 = ccp( basePos.x + 1, basePos.y );
                p6 = ccp( basePos.x - 1, basePos.y + 1 );
                p7 = ccp( basePos.x, basePos.y + 1 );
                p8 = ccp( basePos.x + 1, basePos.y + 1 );
                
                BOOL isNextToPC = NO;
                
                isNextToPC =    ccpFuzzyEqual(pcPos, p1, 0) ||
                ccpFuzzyEqual(pcPos, p2, 0) ||
                ccpFuzzyEqual(pcPos, p3, 0) ||
                ccpFuzzyEqual(pcPos, p4, 0) ||
                ccpFuzzyEqual(pcPos, p5, 0) ||
                ccpFuzzyEqual(pcPos, p6, 0) ||
                ccpFuzzyEqual(pcPos, p7, 0) ||
                ccpFuzzyEqual(pcPos, p8, 0);
                
                if ( isNextToPC ) {
                    // do nothing
                } else {
                    CGPoint nearest;
                    nearest = [ self nearestNonVoidCGPointFromCGPoint:basePos toCGPoint:pcPos ];
                    newPosition = nearest;
                    
                    Tile *oldTile = [ self getTileForCGPoint:basePos        forFloor:[dungeon objectAtIndex:floorNumber ] ];
                    Tile *newTile = [ self getTileForCGPoint:newPosition    forFloor:[dungeon objectAtIndex:floorNumber ] ];
                    
                    if ( newTile.tileType != TILE_FLOOR_WATER ) {
                        // if currently on a water tile
                        // panic and do nothing until bumped
                        if ( oldTile.tileType != TILE_FLOOR_WATER ) {
                            [ self moveEntity:e toPosition:newPosition ];
                        } else {
                            // is water tile
                            // cats hate water!
                        }
                    } else {
                        // is water tile
                        // cats hate water!
                    }
                }
            } else {
                // e was bumped
                // perform a step as if smart-random
                
                BOOL rollIsUnacceptable = YES;
                CGPoint newPosition;
                while ( rollIsUnacceptable ) {
                    NSUInteger roll = [Dice roll:8];
                    CGFloat x = -1;
                    CGFloat y = -1;
                    
                    // UDLR UL, UR, DL, DR
                    if ( roll == 1 ) {
                        x = 0;
                        y = -1;
                    } else if ( roll == 2 ) {
                        x = 0;
                        y = 1;
                    } else if ( roll == 3) {
                        x = -1;
                        y = 0;
                    } else if ( roll == 4) {
                        x = 1;
                        y = 0;
                    } else if ( roll == 5) {
                        x = -1;
                        y = -1;
                    } else if ( roll == 6) {
                        x = 1;
                        y = -1;
                    } else if ( roll == 7) {
                        x = -1;
                        y = 1;
                    } else if ( roll == 8) {
                        x = 1;
                        y = 1;
                    }
                    
                    newPosition.x = e.positionOnMap.x + x;
                    newPosition.y = e.positionOnMap.y + y;
                    
                    Tile *tile = [ self getTileForCGPoint: newPosition ];
                    rollIsUnacceptable = tile.tileType == TILE_FLOOR_VOID;
                }
                // try to move the entity to the new position
                // reset wasBumped
                [ self moveEntity:e toPosition: newPosition ];
                e.wasBumped = NO;
            }
        }
    }
}

/*
 ====================
 npcEntityAtPosition: pos
 
 returns the NPC entity at position pos
 ====================
 */
-( Entity * ) npcEntityAtPosition: (CGPoint) pos {
    Entity *e = nil;
    Tile *t = [ self getTileForCGPoint:pos ];
    for ( Entity *e0 in [t contents ] ) {
        if ( e0.entityType == ENTITY_T_NPC || e0.isPC ) {
            e = e0;
            break;
        }
    }
    return e;
}

/*
 ====================
 handleAttackForEntity: e toPosition: pos
 
 handles attack logic between entities and positions
 ====================
 */
-( void ) handleAttackForEntity: ( Entity * ) e toPosition: (CGPoint) pos {
    // get the tile we are attacking
    Tile *t = [ self getTileForCGPoint: pos ];
    if ( t.tileType == TILE_FLOOR_VOID ) {
        // can't attack a void tile
        [ self addMessage: @"Can't attack that!" ];
        [ self addMessageWindowString: @"Can't attack that!" ];
    } else {
        // check if tile has entities
        BOOL tileHasEntities = ([t contents].count > 0);
        if ( tileHasEntities ) {
            // attacking an entity
            Entity *target = [ self npcEntityAtPosition: pos ];
            
            if ( target == nil ) {
                return;
            }
            
            // check target hostility
            // if target is friendly, return
            if ( target.threatLevel == THREAT_T_FRIENDLY  && e.isPC ) {
                [self addMessageWindowString: [NSString stringWithFormat:@"You bump into a friendly %@", target.name] ];
                
                target.wasBumped = YES;
                gotKarmaThisTurn = YES;
                totalKarmaThisTurn += 1;
                return;
            } else if ( target.threatLevel == THREAT_T_NEUTRAL && e.isPC ) {
                [self addMessageWindowString: [NSString stringWithFormat:@"You bump into a neutral %@", target.name] ];
                return;
            }
            // friendly NPCs will only bump into each other
            else if ( target.threatLevel == THREAT_T_FRIENDLY && !e.isPC && e.threatLevel == THREAT_T_FRIENDLY ) {
                target.wasBumped = YES;
                return;
            } else if ( target.threatLevel == THREAT_T_FRIENDLY && !e.isPC && e.threatLevel == THREAT_T_NEUTRAL ) {
                target.wasBumped = YES;
                return;
            } else if ( target.threatLevel == THREAT_T_NEUTRAL && !e.isPC && e.threatLevel == THREAT_T_NEUTRAL ) {
                return;
            } else if ( target.threatLevel == THREAT_T_NEUTRAL && !e.isPC && e.threatLevel == THREAT_T_FRIENDLY ) {
                return;
            } else if ( e.threatLevel == THREAT_T_FRIENDLY && target.isPC ) {
                return;
            }
            // e v.s. target setup section
            // modifiers would go here
            NSInteger roll                  = [Dice roll:20];
            NSInteger confirmCritical       = [Dice roll:20];
            NSInteger confirmInstantKill    = [Dice roll:20];
            NSInteger totalroll             = roll + e.attackBonus;
            
            // attack condition section
            // probably comparing attack roll vs armor class
            BOOL victory        = totalroll >= target.totalac;
            BOOL isCritical     = roll == 20    && confirmCritical     == 20;
            BOOL isInstantKill  = isCritical    && confirmInstantKill  == 20;
            
            if ( victory && e.isPC ) {
                gotKarmaThisTurn = YES;
                totalKarmaThisTurn -= 1;
 
                NSInteger totaldamage = e.damageRoll;
                totaldamage += isCritical       ? e.damageRoll  : 0;
                totaldamage =  isInstantKill    ? target.hp     : totaldamage;
                totaldamage = (totaldamage > 0) ? totaldamage   : 0;
                
                target.hp -= totaldamage;
                
                [ self addMessage: [ NSString stringWithFormat:@"%@%@ dealt %d damage to Lv%d %@",
                                    isCritical ? @"Critical! " : @"",
                                    e.name, totaldamage, target.level, target.name ]];
                
                [ self addMessageWindowString: [ NSString stringWithFormat:@"%@%@ dealt %d damage to Lv%d %@",
                                                isCritical ? @"Critical! " : @"",
                                                e.name, totaldamage, target.level, target.name ]];
                
                if (target.hp <= 0 ) {
                    // increase entity xp
                    [ e gainXP: target.level*4 + e.level ];
                    
                    pcEntity.totalKills++;
                    [t removeObjectFromContents: target];
                    // remove target from t.contents
                    [ self addMessage: [ NSString stringWithFormat:@"%@ slayed Lv%d %@", e.name, target.level, target.name ] ];
                    [ self addMessageWindowString: [ NSString stringWithFormat:@"%@ slayed Lv%d %@", e.name, target.level, target.name ] ];
                    target.isAlive = NO;
                }
            } else if ( !victory && e.isPC ) {
                [ self addMessage: [ NSString stringWithFormat:@"%@ missed Lv%d %@", e.name, target.level, target.name ]];
                [ self addMessageWindowString: [ NSString stringWithFormat:@"%@ missed Lv%d %@", e.name, target.level, target.name ]];
            } else if ( !victory && !e.isPC ) {
                [ self addMessageWindowString: [ NSString stringWithFormat:@"%@ missed %@", e.name, target.name ]];
            } else if ( victory && e.entityType == ENTITY_T_NPC && target.entityType == ENTITY_T_NPC ) {
                // deal damage to NPC
                NSInteger totaldamage = e.damageRoll;
                totaldamage += isCritical       ? e.damageRoll  : 0;
                totaldamage =  isInstantKill    ? target.hp     : totaldamage;
                totaldamage = (totaldamage > 0) ? totaldamage : 0;
                target.hp -= totaldamage;
                
                [ self addMessageWindowString: [ NSString stringWithFormat:@"%@%@ dealt %d damage to Lv%d %@",
                                                isCritical ? @"Critical! " : @"",
                                                e.name, totaldamage, target.level, target.name ]];
                
                if (target.hp <= 0 ) {
                    // increase entity xp
                    [ e gainXP: target.level*4 + e.level ];
                    e.totalKills++;
                    [ killList addObject: target.name];
                    
                    // we lose karma for killing
                    gotKarmaThisTurn = YES;
                    totalKarmaThisTurn -= 5;
                    
                    // remove target from t.contents
                    [t removeObjectFromContents: target];
                    [ self addMessageWindowString: [ NSString stringWithFormat:@"%@ slayed Lv%d %@", e.name, target.level, target.name ] ];
                    target.isAlive = NO;
                }
            }
            
            else if ( victory && e.entityType == ENTITY_T_NPC && target.entityType == ENTITY_T_PC ) {
                // deal damage to PC
                
                NSInteger totaldamage = e.damageRoll;
                totaldamage += isCritical       ? e.damageRoll  : 0;
                totaldamage =  isInstantKill    ? target.hp     : totaldamage;
                totaldamage = (totaldamage > 0) ? totaldamage : 0;
                
                target.hp -= totaldamage;
                
                [ self addMessage: [ NSString stringWithFormat:@"%@%@ took %d damage from Lv%d %@",
                                    isCritical ? @"Critical! " : @"",
                                    pcEntity.name, totaldamage, e.level, e.name ] ];
                
                [ self addMessageWindowString: [ NSString stringWithFormat:@"%@%@ took %d damage from Lv%d %@",
                                    isCritical ? @"Critical! " : @"",
                                    pcEntity.name, totaldamage, e.level, e.name ] ];
                
                if ( pcEntity.hp <= 0 ) {
                    // check if they got the book of all-knowing
                    BOOL hasBook = NO;
                    for ( Entity *e in pcEntity.inventoryArray ) {
                        if ( e.itemType == E_ITEM_T_BOOK ) {
                            hasBook = YES;
                            break;
                        }
                    }
                    [ self addMessage: [NSString stringWithFormat:@"You died.\nYou killed %d monsters.\nYou %@ the Book of All-Knowing.\n",
                                        pcEntity.totalKills,
                                        hasBook ? @"got" : @"did not get" ] ];
                    [ self addMessageWindowString: [NSString stringWithFormat:@"You died.\nYou killed %d monsters.\nYou %@ the Book of All-Knowing.\n",
                                        pcEntity.totalKills,
                                        hasBook ? @"got" : @"did not get" ] ];
                    
                    for ( NSString *_name in killList )
                        [ self addMessageWindowString: [NSString stringWithFormat:@"You killed a %@", _name]];
                    
                    pcEntity.isAlive = NO;
                    gameLogicIsOn = NO;
                    autostepGameLogic = NO;
                    gameState = GAMESTATE_T_GAME_PC_DEAD;
                    [ self unscheduleStepAction ];
                }
            } else {
                // target not killed
            }
        } else {
            // attacking thin air
        }
    }
}

/*
 ====================
 handleItemPickup: item forEntity: entity
 ====================
 */
-( void ) handleItemPickup: (Entity *) item forEntity: (Entity *) entity {
    BOOL wasPickedUp = NO;
    if ( item != nil && entity == pcEntity ) {
        if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_NONE ) {
            // player-controlled
            
            Tile *itemTile = [ self getTileForCGPoint:item.positionOnMap ];
            if ( itemTile != nil ) {
                if ( entity == pcEntity ) {
                    gotKarmaThisTurn = YES;
                    totalKarmaThisTurn += 1;
                }
                
                [[ entity inventoryArray ] addObject: item ];
                [ self addMessage: [NSString stringWithFormat:@"%@ picks up a %@", entity.name, item.name]];
                [ self addMessageWindowString: [NSString stringWithFormat:@"%@ picks up a %@", entity.name, item.name]];
                
                [[[ dungeon objectAtIndex:floorNumber ] entityArray ] removeObject: item];
                [[ itemTile contents ] removeObject: item];
                [sprites setObject:[Drawer heroForPC:pcEntity] forKey:@"Hero"];
            }
        } else if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE ) {
            // add the item to the entity's inventory
            Tile *itemTile = [ self getTileForCGPoint:item.positionOnMap ];
            if ( itemTile != nil ) {
                if ( item.itemType == E_ITEM_T_WEAPON ) {
                    // equip the weapon
                    if ( entity.equippedArmsLeft == nil ) {
                        entity.equippedArmsLeft = item;
                        [ self addMessage: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                        [ self addMessageWindowString: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                        wasPickedUp = YES;
                    } else {
                        if ( entity.equippedArmsLeft.damageRollBase < item.damageRollBase ||
                             entity.equippedArmsLeft.damageBonus < item.damageBonus ) {
                            // entity puts his weapon into his inventory
                            entity.equippedArmsLeft = item;
                            [ self addMessage: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                            [ self addMessageWindowString: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                            wasPickedUp = YES;
                        }
                        // else - we don't equip the new item, just store it
                        else {
                            //disabling weapon pickup if weaker than equipped
                            [ self addMessage: [NSString stringWithFormat:@"There is a %@ here", item.name]];
                        }
                    }
                } else if ( item.itemType == E_ITEM_T_ARMOR ) {
                    // equip the weapon
                    if ( entity.equippedArmorChest == nil ) {
                        entity.equippedArmorChest = item;
                        [ self addMessage: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                        [ self addMessageWindowString: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                        wasPickedUp = YES;
                    } else {
                        if ( entity.equippedArmorChest.ac < item.ac ) {
                            entity.equippedArmorChest = item;
                            [ self addMessage: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                            [ self addMessageWindowString: [NSString stringWithFormat:@"%@ equips a %@", entity.name, item.name]];
                            wasPickedUp = YES;
                        }
                        // else - we don't equip the new item, just store it
                        else {
                            [ self addMessage: [NSString stringWithFormat:@"There is a %@ here", item.name]];
                            [ self addMessageWindowString: [NSString stringWithFormat:@"There is a %@ here", item.name]];
                        }
                    }
                } else {
                    wasPickedUp = YES;
                    [[ entity inventoryArray ] addObject: item ];
                    [ self addMessage: [NSString stringWithFormat:@"%@ picks up a %@", entity.name, item.name]];
                    [ self addMessageWindowString: [NSString stringWithFormat:@"%@ picks up a %@", entity.name, item.name]];
                }
                // remove the item from our entityArray and from it's tile's contents
                if ( wasPickedUp ) {
                    [[[ dungeon objectAtIndex:floorNumber ] entityArray ] removeObject: item];
                    [[ itemTile contents ] removeObject: item];
                    // update our hero sprite
                    [sprites setObject:[Drawer heroForPC:pcEntity] forKey:@"Hero"];
                }
            }
        }
    }
}

/*
 ================
 handleDropItem: item forEntity: entity
 ================
 */
-( void ) handleDropItem: (Entity *) item forEntity: (Entity *) entity {
    if ( item != nil && entity != nil ) {
        // get the entity's tile
        Tile *entityTile = [ self getTileForCGPoint: entity.positionOnMap ];
        if ( entityTile != nil ) {
            [ self addMessage: [NSString stringWithFormat:@"%@ drops a %@", entity.name, item.name]];
            [ self addMessageWindowString: [NSString stringWithFormat:@"%@ drops a %@", entity.name, item.name]];
            [ GameRenderer setEntity:item onTile:entityTile ];
            // remove the item from the entity's inventory
            [[entity inventoryArray] removeObject: item];
        }
    }
}

/*
 ====================
 scheduledStepAction
 
 this method is scheduled in the init for gameLogic autostepping
 ====================
 */
-( void ) scheduledStepAction {
    if ( autostepGameLogic ) {
        [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStepNotification" object: self ];
    }
}

/*
 ====================
 scheduleStepAction
 
 schedules the scheduledStepAction
 ====================
 */
-( void ) scheduleStepAction {
    [ self schedule:@selector(scheduledStepAction) interval: STEP_SPEED ];
}

/*
 ====================
 unscheduleStepAction
 
 unschedules the scheduleStepAction
 ====================
 */
-( void ) unscheduleStepAction {
    [ self unschedule:@selector(scheduledStepAction)];
}

/*
 ====================
 doTimer
 
 times the method selector
 ====================
 */
-( void ) doTimer: (SEL) selector {
    if ( selector != nil ) {
        CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
        [ self performSelector:selector ];
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        CFAbsoluteTime total = ( end - start );
        MLOG( @"method ran in %f s", total );
    }
}

/*
 ====================
 incrementTurn
 
 increments the turnCounter
 ====================
 */
-( void ) incrementTurn {
    // post available karma
    gotKarmaThisTurn ? [[KarmaEngine sharedEngine] addKarma: totalKarmaThisTurn] : 0;
    turnCounter++;
    
    // reset the karma for turn
    gotKarmaThisTurn = NO;
    totalKarmaThisTurn = 0;
}

-( void ) swapAutostep {
    autostepGameLogic = ! autostepGameLogic;
}

-(void) cleanupEntityArray {
    // cleanup entityArray
    for ( int i = 0; i < [[[dungeon objectAtIndex:floorNumber] entityArray] count]; i++ ) {
        Entity *e = [[[dungeon objectAtIndex:floorNumber] entityArray] objectAtIndex: i];
        if ( e.isAlive == NO ) {
            CGPoint entityPos = e.positionOnMap;
            
            // drop a green blob if they die
            Entity *food = [Items greenBlob];
            [GameRenderer spawnEntity:food onFloor:[dungeon objectAtIndex:floorNumber] atLocation:entityPos];
            [[[dungeon objectAtIndex:floorNumber] entityArray] removeObject: e ];
            i = 0;
        }
    }
}

@end