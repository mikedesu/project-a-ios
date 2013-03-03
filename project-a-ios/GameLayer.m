//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "Dice.h"
#import "GameLayer.h"


#import <mach/mach.h> // for reporting memory info

// used for reporting memory used in-game
unsigned get_memory_bytes(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t) &info, &size );
    
    unsigned retval = 0;
    
    if ( kerr == KERN_SUCCESS ) {
        //MLOG( @"Memory in use (in bytes): %u", info.resident_size );
        retval = info.resident_size;
    } else {
        //MLOG( @"Error with task_info(): %s", mach_error_string(kerr) );
    }
    
    return retval;
}

unsigned get_memory_kb(void) {
    //return get_memory_bytes() / 1024;
    return get_memory_bytes() >> 10;
}

unsigned get_memory_mb(void) {
    return get_memory_kb() >> 10;
}




@implementation GameLayer

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


/*
 ====================
 init
 
 initializes and returns the layer
 ====================
 */
-(id) init {
	if ( ( self = [ super init ] ) ) {
        
        // setting up some basic variables
        self.isTouchEnabled = YES;
        selectedTile = -1;
        //prevSelectedTile = -1;
        touchedTileIndex = -1;
        isTouched = NO;
        
        // Dungeon initialization
        [ self initializeDungeon ];
        //[ self doTimer:@selector(initializeDungeon)];
        
        
        CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: [dungeon objectAtIndex:floorNumber]];
        
        
        // set up our 'hero'
        [ self initializePCEntity ];
        
        
        // set the camera anchor point
        cameraAnchorPoint = ccp( 7, 5 );
        
        
        // our list of entities
        //entityArray = [ [ NSMutableArray alloc ] init ];
        //[ entityArray addObject: pcEntity ];
        [[[ dungeon objectAtIndex:floorNumber ] entityArray] addObject: pcEntity];
        
 
        // set the starting tile
        Tile *startTile = nil;
        for ( Tile *t in [ [dungeon objectAtIndex:floorNumber] tileDataArray ] ) {
            if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
                startTile = t;
                break;
            }
        }
        
        CGPoint enemyStartPos = startTile.position;
        enemyStartPos.x += 1;
        Tile *enemyStartTile = [ self getTileForCGPoint: enemyStartPos ];        
        
        
        // set the hero on the startTile and center the camera
        //[ self setEntity:pcEntity onTile: startTile ];
        [ GameRenderer setEntity:pcEntity onTile:startTile ];
        [ self resetCameraPosition ];
        
        
        // set up some enemy entities
        /*
        Entity *enemy0;
        enemy0 = [[ Entity alloc ] init ];
        enemy0.entityType = ENTITY_T_NPC;
        [enemy0.name setString:@"Enemy0"];
        enemy0.isPC = NO;
        enemy0.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
        enemy0.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
        
        
        // place enemy0 on tile
        [ GameRenderer setEntity: enemy0 onTile: enemyStartTile ];
        [[[ dungeon objectAtIndex:floorNumber ] entityArray] addObject: enemy0 ];
        
        
        // create an item and set it down
        Entity *item = [[ Entity alloc] init];
        item.entityType = ENTITY_T_ITEM;
        [item.name setString:@"Item"];
        item.isPC = NO;
        item.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
        item.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
        
        
        CGPoint itemStartPos = enemyStartPos;
        itemStartPos.x += 1;
        Tile *itemStartTile = [ self getTileForCGPoint: itemStartPos ];
        
 
        [ GameRenderer setEntity: item onTile:itemStartTile ];
        [[[dungeon objectAtIndex:floorNumber] entityArray] addObject: item];
        */
        
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
#define STEP_SPEED              0.01
        
        // turn on gameLogic & autostepping
        gameLogicIsOn = YES;
        autostepGameLogic = YES;
        //autostepGameLogic = NO;
        
        // only allow autostepping if both gameLogicIsOn and autosteppingGameLogic
        autostepGameLogic = autostepGameLogic && gameLogicIsOn;
        if ( gameLogicIsOn && autostepGameLogic ) {
            [ self scheduleStepAction ];
        }
 
        needsRedraw = YES;
        
        // draw the screen (kind of)
        //[ GameRenderer setAllVisibleTiles: tileArray withDungeonFloor: [dungeon objectAtIndex:floorNumber] withCamera:cameraAnchorPoint ];
        
        [ GameRenderer spawnRandomItemAtRandomLocationOnFloor: [dungeon objectAtIndex:[dungeon count]-1] ];
        
	}
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


/*
 ====================
 receiveNotification: notification
 ====================
 */
-( void ) receiveNotification: ( NSNotification * ) notification {
    //MLOG( @"received notification: %@", notification );
    
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
        
    } else if ( [[ notification name ] isEqualToString: @"MoveNotification" ] ) {
        //MLOG( @"MoveNotification" );
        
        [ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME_PC_SELECTMOVE;
        
    } else if ( [[ notification name ] isEqualToString: @"AttackNotification" ] ) {
        //MLOG( @"AttackNotification" );
        
        [ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME;
    }
    else if ( [[ notification name ] isEqualToString: @"StepNotification" ] ) {
        //MLOG( @"StepNotification" );
        
        //[ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME_PC_STEP;
        
        
        //[ self addMessage: @"Stepping..." ];
        // move pcEntity towards downstairsTile based on movement algorithm
        
        if ( pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_RANDOM )
        {
            NSUInteger roll = [Dice roll:9];
            CGFloat x = -1;
            CGFloat y = -1;
            
            //MLOG( @"rolled %d", roll );
            
            // UDLR UL, UR, DL, DR
            if ( roll == 1 ) {
                x = 0;
                y = -1;
            }
            else if ( roll == 2 ) {
                x = 0;
                y = 1;
            }
            else if ( roll == 3) {
                x = -1;
                y = 0;
            }
            else if ( roll == 4) {
                x = 1;
                y = 0;
            }
            else if ( roll == 5) {
                x = -1;
                y = -1;
            }
            else if ( roll == 6) {
                x = 1;
                y = -1;
            }
            else if ( roll == 7) {
                x = -1;
                y = 1;
            }
            else if ( roll == 8) {
                x = 1;
                y = 1;
            }
            else if ( roll == 9 ) {
                x = 0;
                y = 0;
            }
            
            CGPoint newPosition;
            newPosition.x = pcEntity.positionOnMap.x + x;
            newPosition.y = pcEntity.positionOnMap.y + y;
            
            //MLOG( @"(%.0f,%.0f)", pcEntity.positionOnMap.x, pcEntity.positionOnMap.y );
            //MLOG( @"(%.0f,%.0f)", newPosition.x, newPosition.y );
            
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
        
        else if (pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM )
        {
            
            //BOOL rollIsUnacceptable = NO;
            BOOL rollIsUnacceptable = YES;
            CGPoint newPosition;
            
            NSUInteger roll = [Dice roll:9];
            while ( rollIsUnacceptable ) {
                roll = [Dice roll:9];
                CGFloat x = -1;
                CGFloat y = -1;
            
                //MLOG( @"rolled %d", roll );
            
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
                }
            }
 
            // step game logic
            if ( gameLogicIsOn ) {
                [ self stepGameLogic ];
            }
            [ self resetCameraPosition ];
        }
        
        else if (pcEntity.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SIMPLE )
        {
 
            // get all 8 tiles around the pcEntity
            CGPoint ulpt = ccp( pcEntity.positionOnMap.x - 1 , pcEntity.positionOnMap.y - 1 );
            CGPoint upt =  ccp( pcEntity.positionOnMap.x ,     pcEntity.positionOnMap.y - 1);
            CGPoint urpt = ccp( pcEntity.positionOnMap.x + 1 , pcEntity.positionOnMap.y - 1 );
            CGPoint lpt =  ccp( pcEntity.positionOnMap.x - 1 , pcEntity.positionOnMap.y );
            CGPoint rpt =  ccp( pcEntity.positionOnMap.x + 1 , pcEntity.positionOnMap.y );
            CGPoint dlpt = ccp( pcEntity.positionOnMap.x - 1,  pcEntity.positionOnMap.y + 1 );
            CGPoint dpt =  ccp( pcEntity.positionOnMap.x ,     pcEntity.positionOnMap.y + 1 );
            CGPoint drpt = ccp( pcEntity.positionOnMap.x + 1 , pcEntity.positionOnMap.y + 1 );
 
            Tile *ult = [ self getTileForCGPoint: ulpt ];
            Tile *ut =  [ self getTileForCGPoint: upt ];
            Tile *urt = [ self getTileForCGPoint: urpt ];
            
            Tile *lt =  [ self getTileForCGPoint: lpt ];
            Tile *rt =  [ self getTileForCGPoint: rpt ];
            
            Tile *dlt = [ self getTileForCGPoint: dlpt ];
            Tile *dt =  [ self getTileForCGPoint: dpt ];
            Tile *drt = [ self getTileForCGPoint: drpt ];
            
            
            BOOL hasTheItem = pcEntity.inventoryArray.count > 0;
            BOOL isBottomFloor = floorNumber == dungeon.count - 1;
            
            // calculate distances to downstairs/upstairs tile
            Tile *downstairsTile = nil;
            Tile *upstairsTile = nil;
            Tile *itemTile = nil;
            
            for ( Tile *tile in [[dungeon objectAtIndex:floorNumber] tileDataArray] ) {
                if ( ! hasTheItem && ! isBottomFloor ) {
                    if ( tile.tileType == TILE_FLOOR_DOWNSTAIRS ) {
                        downstairsTile = tile;
                        break;
                    }
                }
                
                else if ( ! hasTheItem && isBottomFloor ) {
                    // check if the tile has an item
                    if ( tile.contents.count > 0 ) {
                        itemTile = tile;
                        break;
                    }
                }
                
                else {
                    if ( tile.tileType == TILE_FLOOR_UPSTAIRS ) {
                        upstairsTile = tile;
                        break;
                    }
                }
            }
            
            Tile *bestTile = nil;
            NSMutableArray *tiles = [ NSMutableArray arrayWithObjects:
                              ult,
                              ut,
                              urt,
                              lt,
                              rt,
                              dlt,
                              dt,
                              drt,
                              nil];
            NSInteger minDist = 999;
            NSInteger dist;
            
            // prune out previously-traveled tiles if we don't have the item
            
            if ( ! hasTheItem ) {
                for ( int i = 0; i < [tiles count]; i++ ) {
                    Tile *t = [tiles objectAtIndex:i];
                    for ( Tile * t2 in pcEntity.pathTaken ) {
                        if ( t == t2 ) {
                            // taken tile before, don't use
                            [ tiles removeObject: t ];
                        }
                    }
                }
            }
            
            if ( tiles.count > 0 ) {
                // from remaining tiles, select best tile
                for ( Tile *t in tiles ) {
                    if ( t.tileType != TILE_FLOOR_VOID ) {
                        if ( !hasTheItem && !isBottomFloor )     { dist = [ self distanceFromTile:downstairsTile toTile: t ]; }
                        else if ( !hasTheItem && isBottomFloor ) { dist = [ self distanceFromTile:itemTile       toTile: t ]; }
                        else                                     { dist = [ self distanceFromTile:upstairsTile   toTile: t ]; }
                        
                        if ( dist <= minDist ) {
                            minDist = dist;
                            bestTile = t;
                        }
                    }
                }
                
                // presumably we've found the best tile to move to
                [pcEntity.pathTaken addObject:bestTile];
                [ self moveEntity:pcEntity toPosition: bestTile.position ];
            }
            
            else
            {
                // pop the last tile taken
                Tile *lastTileTaken = [pcEntity.pathTaken lastObject];
                //[pcEntity.pathTaken removeLastObject];
                [ self moveEntity:pcEntity toPosition:lastTileTaken.position ];
            }
            
           
            
            // step game logic
            if ( gameLogicIsOn ) {
                [ self stepGameLogic ];
            }
            [ self resetCameraPosition ];
 
        }
        
            
        [ self resetCameraPosition ];
        //turnCounter++;
        gameState = GAMESTATE_T_GAME;
    }
    
    else if ( [notification.name isEqualToString: @"PlayerMenuCloseNotification" ]) {
        [ self removePlayerMenu: playerMenu ];
    }
    else {
        //MLOG( @"Notification not handled: %@", notification.name );
    }
}

#pragma mark - Menus and HUD code


/*
 ====================
 initPlayerMenu
 
 initializes the Player menu
 ====================
 */
-( void ) initPlayerMenu {
    CGSize size = [[CCDirector sharedDirector] winSize];
    playerMenu = [[ PlayerMenu alloc ] initWithColor: black_alpha(200) width:150 height:100 ];
    playerMenu.position = ccp(  size.width - (playerMenu.contentSize.width) , size.height - (playerMenu.contentSize.height) );
}


/*
 ====================
 addPlayerMenu: menu
 
 adds the Player menu to the visible screen
 ====================
 */
-( void ) addPlayerMenu: ( PlayerMenu * ) menu {
    if ( ! playerMenuIsVisible ) {
        [ self addChild: menu ];
        playerMenuIsVisible = YES;
        //[ self addMessage: @"Opened Player Menu" ];
    }
}


/*
 ====================
 removePlayerMenu: menu
 
 removes the Player menu from the visible screen
 ====================
 */
-( void ) removePlayerMenu: ( PlayerMenu * ) menu {
    if ( playerMenuIsVisible ) {
        [ self removeChild: menu cleanup: NO ];
        playerMenuIsVisible = NO;
        //[ self addMessage: @"Closed Player Menu" ];
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
    entityInfoHUD = [[ EntityInfoHUD alloc ] initWithColor:black_alpha(150) width:250 height:100 ];
    entityInfoHUD.position = ccp(  0 , size.height - (editorHUD.contentSize.height) - (entityInfoHUD.contentSize.height) );
    [ self updateEntityInfoHUDLabel ];
}


/*
 ====================
 initEntityInfoHUD
 
 initializes the Entity Info HUD
 ====================
 */

-( void ) addEntityInfoHUD: (EntityInfoHUD *) entityInfoHUD {
    if ( ! self->entityInfoHUDIsVisible ) {
        [ self addChild: entityInfoHUD ];
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
            if ( [[t contents] count] > 0 ) {
                Entity *e = [[ t contents ] objectAtIndex: 0];
            
                [entityInfoHUD.label setString:[ NSString stringWithFormat: @"Lv: %d  Name: %@\nKills: %d\nLine3\nLine4\n",
                                                e.level,
                                                e.name,
                                                e.totalKills
                                                ] ];
            }
        }
        else {
            [entityInfoHUD.label setString:@"..." ];
        }
    }
    @catch (NSException *exception) {
        [entityInfoHUD.label setString:@"..." ];
        MLOG(@"exception caught: %@", exception);
    }
    @finally {
        
    }
}


/*
 ====================
 removeEntityInfoHUD: entityInfoHUD
 
 removes the entity info hud
 ====================
 */

-( void ) removeEntityInfoHUD: (EntityInfoHUD *) entityInfoHUD {
    if ( self->entityInfoHUDIsVisible ) {
        [ self removeChild: monitor cleanup: NO ];
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
    monitor = [[ EditorHUD alloc ] initWithColor:black_alpha(150) width:250 height:100 ];
    //monitor.position = ccp(  0 , size.height - (monitor.contentSize.height) - (editorHUD.contentSize.height) - 10 );
    monitor.position = ccp(  0 , 0 + playerHUD.contentSize.height + monitor.contentSize.height );
    [ self updateMonitorLabel ];
}


/*
 ====================
 addMonitor: monitor
 ====================
 */
-(void) addMonitor: (EditorHUD *) monitor {
    if ( ! self->monitorIsVisible ) {
        [ self addChild: monitor ];
        monitorIsVisible = YES;
    }
}


/*
 ====================
 removeMonitor: monitor
 ====================
 */
-(void) removeMonitor: (EditorHUD *) monitor {
    if ( self->monitorIsVisible ) {
        [ self removeChild: monitor cleanup: NO ];
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
     //[NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nDistance: %d\nEntities: %d\nMemory used: %u kb\n",
     [NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nEntities: %d\nInventory: %d\nMemory used: %u kb\n",
      
      [self getGameStateString: gameState],
      selectedTilePoint.x,
      selectedTilePoint.y,
      pcEntity.positionOnMap.x,
      pcEntity.positionOnMap.y,
      cameraAnchorPoint.x,
      cameraAnchorPoint.y,
      //floorNumber,
      [[[dungeon objectAtIndex:floorNumber] entityArray] count],
      [[pcEntity inventoryArray] count],
      //entityArray.count,
      get_memory_kb()
      ]
     ];
        
    } @catch ( NSException *e ) {
        //MLOG( @"Exception caught: %@", e );
        [monitor.label setString:
         //[NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nDistance: %d\nEntities: %d\nMemory used: %u kb\n",
         [NSString stringWithFormat: @"GameState: %@\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nEntities: %d\nInventory: %d\nMemory used: %u kb\n",
          
          [self getGameStateString:gameState],
          selectedTilePoint.x,
          selectedTilePoint.y,
          pcEntity.positionOnMap.x,
          pcEntity.positionOnMap.y,
          cameraAnchorPoint.x,
          cameraAnchorPoint.y,
          //floorNumber,
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
    editorHUD = [[ EditorHUD alloc ] initWithColor:black_alpha(150) width:250 height:80 ];
    
    //if ( monitorIsVisible ) {
    //  editorHUD.position = ccp(  0 , size.height - (editorHUD.contentSize.height) - (monitor.contentSize.height) - 10 );
    //}
    //else {
    editorHUD.position = ccp(  0 , size.height - (editorHUD.contentSize.height) - 5 );
    //}
    [ self updateEditorHUDLabel ];
}


/*
 ====================
 updateEditorHUDLabel
 
 updates the Editor HUD Label
 ====================
 */
-( void ) updateEditorHUDLabel {
    /*
    [[editorHUD label] setString: [ NSString stringWithFormat: @"%@%@%@%@%@%@%@",
                                  [dLog objectAtIndex: dLogIndex+0 ],
                                  [dLog objectAtIndex: dLogIndex+1 ],
                                  [dLog objectAtIndex: dLogIndex+2 ],
                                  [dLog objectAtIndex: dLogIndex+3 ],
                                  [dLog objectAtIndex: dLogIndex+4 ],
                                  [dLog objectAtIndex: dLogIndex+5 ],
                                  [dLog objectAtIndex: dLogIndex+6 ]
                                  ]];
    */
    
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
-( void ) addEditorHUD: ( EditorHUD * ) hud {
    if ( ! editorHUDIsVisible ) {
        [ self addChild: hud ];
        editorHUDIsVisible = YES;
    }
}


/*
 ====================
 removeEditorHUD: hud
 
 removes the Editor HUD from the visible screen
 ====================
 */
-( void ) removeEditorHUD: ( EditorHUD * ) hud {
    if ( editorHUDIsVisible ) {
        [ self removeChild: hud cleanup: NO ];
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
    playerHUD = [[ PlayerHUD alloc ] initWithColor:black_alpha(150) width: size.width height:100 ];
    playerHUD.position = ccp(  0 , 0 );
    [ self updatePlayerHUDLabel ];
}


/*
 ====================
 addPlayerHUD: hud
 
 adds the Player HUD to the visible screen
 ====================
 */
-( void ) addPlayerHUD: ( PlayerHUD * ) hud {
    if ( ! playerHUDIsVisible ) {
        [ self addChild: hud ];
        playerHUDIsVisible = YES;
    }
}


/*
 ====================
 removePlayerHUD: hud
 
 removes the Player HUD from the visible screen
 ====================
 */
-( void ) removePlayerHUD: ( PlayerHUD * ) hud {
    if ( playerHUDIsVisible ) {
        [ self removeChild: hud cleanup: NO ];
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
    
    static BOOL gotItem = FALSE;
    if ( [[pcEntity inventoryArray] count] > 0 && !gotItem ) {
        [ pcEntity setName: [NSString stringWithFormat:@"%@ the Great", pcEntity.name]];
        gotItem = TRUE;
    }
    [ [playerHUD label] setString: [ NSString stringWithFormat: @"%@\n%@\n%@\n",
                                   [ NSString stringWithFormat: @"%@ - %@  T:%d", pcEntity.name,
                                    
                                    pcEntity.alignment == ENTITYALIGNMENT_T_LAWFUL_GOOD ?       @"Lawful Good" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_LAWFUL_NEUTRAL ?    @"Lawful Neutral" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_LAWFUL_EVIL ?       @"Lawful Evil" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_NEUTRAL_GOOD ?      @"Neutral Good" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL ?   @"Neutral Neutral" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_NEUTRAL_EVIL ?      @"Neutral Evil" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_CHAOTIC_EVIL ?      @"Chaotic Evil" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_CHAOTIC_GOOD ?      @"Chaotic Good" :
                                    pcEntity.alignment == ENTITYALIGNMENT_T_CHAOTIC_NEUTRAL ?   @"Chaotic Neutral" : @"Unknown"
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
                                    pcEntity.ac,
                                    pcEntity.level,
                                    pcEntity.xp]
                                   ]];
}


#pragma mark - Update code

/*
 ====================
 tick: dt
 
 represents a single frame tick
 ====================
 */
-(void)tick:(ccTime)dt {
    //MLOG( @"tick" );
    //double before = [NSDate timeIntervalSinceReferenceDate];

    // only if we need redraw, really...
    if ( needsRedraw )
    {
        [ GameRenderer setAllVisibleTiles: tileArray withDungeonFloor: [dungeon objectAtIndex:floorNumber] withCamera:cameraAnchorPoint ];
        if ( editorHUDIsVisible ) {
            [ self updateEditorHUDLabel ];
        }
        if ( monitorIsVisible ) {
            [self updateMonitorLabel];
        }
        
        if ( playerHUDIsVisible ) {
            [ self updatePlayerHUDLabel ];
        }
        
        if ( entityInfoHUDIsVisible ) {
            [ self updateEntityInfoHUDLabel ];
        }
        
        [ self resetCameraPosition ];
        
        needsRedraw = NO;
    }
    
    //double after = [NSDate timeIntervalSinceReferenceDate] - before;
    //MLOG( @"tick time: %f", after );
    
}


#pragma mark - Touch code


/*
 ====================
 ccTouchesBegan: touches withEvent: event
 ====================
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"ccTouchesBegan" );
    
    //if ( gameState == GAMESTATE_T_GAME_PC_DEAD ) { return; }
    
    
	UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = YES;
    
    CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    // valid selected point
    BOOL validSelectedPoint = selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0;
    
    if ( validSelectedPoint ) {
        
        //[ self addMessage: @"Tile was previously selected" ];
        //[ self selectTileAtPosition: mapPoint ];
        
    }
    
    else {
        //MLOG( @"Nothing previously selected" );
        //[ self selectTileAtPosition: mapPoint ];
    }
    
    /*
     if ( pcEntity.positionOnMap.x == mapPoint.x && pcEntity.positionOnMap.y == mapPoint.y ) {
            //[ self addMessage: @"Selected Player" ];
            heroTouches++;
            if ( heroTouches == 2) {
                // double-touched hero
                [ self addPlayerMenu: playerMenu ];
                heroTouches = 0;
            } else if ( heroTouches == 1 && playerMenuIsVisible ) {
                // touched hero while playerMenu is visible
                // close the playerMenu
                [ self removePlayerMenu: playerMenu ];
                heroTouches = 0;
            }
            
        } else {
            if ( heroTouches > 0 ) {
                heroTouches = 0;
            }
        }
        
    }
    
    // invalid selected point / nothing selected
    else {
        //[ self addMessage: @"Nothing previously selected" ];
        [ self selectTileAtPosition: mapPoint ];
        
        if ( pcEntity.positionOnMap.x  == mapPoint.x && pcEntity.positionOnMap.y == mapPoint.y ) {
            heroTouches++;
            
            if ( heroTouches == 2) {
                [ self addPlayerMenu: playerMenu ];
                heroTouches = 0;
            } else if ( heroTouches == 1 && playerMenuIsVisible ) {
                [ self removePlayerMenu: playerMenu ];
                heroTouches = 0;
            } 
        }
        
        else if ( gameState == GAMESTATE_T_GAME_PC_SELECTMOVE ) {
            
            
            NSInteger distance = [GameRenderer distanceFromTile:[GameRenderer getTileForFloor:[dungeon objectAtIndex:floorNumber] forCGPoint:mapPoint] toTile:[GameRenderer getTileForFloor:[dungeon objectAtIndex:floorNumber] forCGPoint:pcEntity.positionOnMap]];
            
            [ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
            
            //BOOL checkPlayerMoveDistance = distance > 1;
            BOOL checkPlayerMoveDistance = distance > pcEntity.movement;
            if ( checkPlayerMoveDistance ) {
                [ self addMessage: @"Cannot move that far in one turn!" ];
                gameState = GAMESTATE_T_GAME;
            }
            
            else {
            
                // if we're moving onto the downstairs tile...
                if ( [self getTileForCGPoint:mapPoint].tileType == TILE_FLOOR_DOWNSTAIRS ) {
                    
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    [ self resetCameraPosition ];
                    //[ self addMessage: @"Going downstairs" ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                    
                }
                
                // if we're moving onto the upstairs tile...
                else if ( [self getTileForCGPoint:mapPoint].tileType == TILE_FLOOR_UPSTAIRS ) {
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    [ self resetCameraPosition ];
                    //[ self addMessage: @"Going upstairs" ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                }
                
                // just a normal tile...
                else {
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    
                    // handle entity step
                    [ self stepGameLogic ];
                    
                    [ self resetCameraPosition ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                }
            }
        }
        
        else {
            if ( heroTouches > 0 ) {
                heroTouches = 0;
            }
        }
    }
     */
    [ self updateMonitorLabel ];
}


/*
 ====================
 ccTouchesMoved: touches withEvent: event
 ====================
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches moved" );
//    if ( gameState == GAMESTATE_T_GAME_PC_DEAD ) { return; }
    
    
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
            [ self selectTileAtPosition: mapPoint ];
        }
        
    }
    
    else {
        // shouldnt be possible
    }
    
    [ self updateMonitorLabel ];
    
}


/*
 ====================
 ccTouchesEnded: touches withEvent: event
 ====================
 */
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches ended" );
    //UITouch *touch = [ touches anyObject ];
    //double now = [ NSDate timeIntervalSinceReferenceDate ];
    //double timeElapsedSinceTouchBegan = now - touchBeganTime;
    
    
//    if ( gameState == GAMESTATE_T_GAME_PC_DEAD ) { return; }
    
    UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = NO;
    
    CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    // valid selected point
    BOOL validSelectedPoint = selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0;
    
    
    // something was previously selected
    if ( validSelectedPoint ) {
        
        // check if we hit the same tile again
        
        Tile *a = [ self getTileForCGPoint: mapPoint ];
        Tile *b = [ self getTileForCGPoint: selectedTilePoint ];
        
        if ( a==b ) {
            
            // check distance from pcEntity
            Tile *pcTile = [ self getTileForCGPoint: pcEntity.positionOnMap ];
            
            NSInteger distance = [ self distanceFromTile:a toTile: pcTile ];
            
            if ( distance <= pcEntity.movement ) {
                // valid quick-move
                MLOG(@"valid quick-move");
                
                // deselect the tile
                [ self selectTileAtPosition: mapPoint ];
                
                // move the pcEntity to the tile
                [ self moveEntity:pcEntity toPosition:mapPoint ];
                
                // step game logic
                if ( gameLogicIsOn ) {
                    [ self stepGameLogic ];
                }
                
                [ self resetCameraPosition ];
                
            }
            else {
                // invalid quick-move
                // possibly other quick-action
                MLOG(@"invalid quick-move");
                
                // deselect the tile
                [ self selectTileAtPosition: mapPoint ];
            }
        }
        
        else {
            [ self selectTileAtPosition: mapPoint ];
        }
        
        
    }
    
    // something was not prev. selected
    else {
  
        [ self selectTileAtPosition: mapPoint ];
        
    }
    
    
    [ self updateMonitorLabel ];
    
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
    //MLOG( @"appendNewTile" );
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
    //MLOG(@"addBlankTiles");
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

/*
-( void ) initializeTileData {
    //MLOG(@"initializeTileData");
    tileDataArray = [ [ NSMutableArray alloc ] init ];
    for ( int j = 0 ; j < NUMBER_OF_TILES_ONSCREEN_Y ; j++ ) {
        for ( int i = 0 ; i < NUMBER_OF_TILES_ONSCREEN_X; i++ ) {
            Tile *tile = [ [ Tile alloc ] init ];
            tile->tileType = TILE_DEFAULT;
            tile->position = ccp( i, j );
            [ tileDataArray addObject: tile ];
        }
    }
    [ GameRenderer setAllTiles: tileArray toTileType: TILE_DEFAULT ];
    [ GameRenderer setTileArrayBoundary: tileDataArray toTileType: TILE_FLOOR_STONE withLevel: 2 ];
    [ GameRenderer setTileArrayBoundary: tileDataArray toTileType: TILE_VOID withLevel: 1 ];
    MLOG(@"End initializeTileData");
}
 */



//-( void ) drawDungeonFloor: ( DungeonFloor * ) dungeonFloor toTileArray: ( NSArray * ) tileArray {

/*
-( void ) drawDungeonFloor {
    CGPoint c = cameraAnchorPoint;
    for ( int j = 0; j < NUMBER_OF_TILES_ONSCREEN_Y; j++ ) {
    //for ( int j = 0; j < floor.height; j++ ) {
        for ( int i = 0; i < NUMBER_OF_TILES_ONSCREEN_X; i++ ) {
        //for ( int i = 0; i < floor.width; i++ ) {
            // grab the tile at ( i+c.x, j+c.y )
            Tile *tile = [ self getTileForCGPoint: ccp(i+c.x, j+c.y) ];
            [ Tile renderTextureForTile: tile ];
            
            CCSprite *sprite = [ self getTileSpriteForCGPoint: ccp(i, j) ];
            sprite.texture = tile.texture;
        }
    }
}
 */


-( Tile * ) getTileForCGPoint: ( CGPoint ) p  {
    Tile *tile = nil;
    tile = [[[dungeon objectAtIndex:floorNumber] tileDataArray] objectAtIndex: p.x + ( p.y * [ (DungeonFloor *)[dungeon objectAtIndex:floorNumber] width ] ) ];
    return tile;
}


-( Tile * ) getTileForCGPoint: ( CGPoint ) p forFloor: (DungeonFloor *) floor {
    Tile *tile = nil;
    tile = [[floor tileDataArray] objectAtIndex: p.x + ( p.y * floor.width ) ];
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
    //MLOG( @"initializeMagicXArray()" );
    for ( int i = 0; i < 10; i++ ) {
        for ( int j = 0; j < 32; j++ ) {
            magicXArray[ j + (i * 32) ] = i;
        }
    }
}

void initializeMagicYArray() {
    //MLOG( @"initializeMagicYArray()" );
    NSUInteger counter = 14;
    for ( int i = 0; i < 14; i++ ) {
        for ( int j = 0; j < 32; j++ ) {
            magicYArray[ j + (i * 32) ] = counter;
        }
        counter--;
    }
}



NSUInteger getMagicX( NSUInteger x ) {
    //MLOG( @"getMagicX()" );
    if ( ! isMagicXArrayInitialized ) {
        initializeMagicXArray();
        isMagicXArrayInitialized = YES;
    }
    return magicXArray[ x ];
    
    /*
    return
        ( x < 32 ) ? 0 :        // 32 =     0x020 = 0b0 0010 0000
        ( x < 64 ) ? 1 :        // 64 =     0x040 = 0b0 0100 0000
        ( x < 96 ) ? 2 :        // 96 =     0x060 = 0b0 0110 0000
        ( x < 128 ) ? 3 :       // 128 =    0x080 = 0b0 1000 0000
        ( x < 150 ) ? 4 :       // 150 =    0x0a0 = 0b0 1010 0000
        ( x < 192 ) ? 5 :       // 192 =    0x0c0 = 0b0 1100 0000
        ( x < 224 ) ? 6 :       // 224 =    0x0e0 = 0b0 1110 0000
        ( x < 256 ) ? 7 :       // 256 =    0x100 = 0b1 0000 0000
        ( x < 288 ) ? 8 :       // 288 =    0x120 = 0b1 0010 0000
        ( x < 320 ) ? 9 :       // 320 =    0x140 = 0b1 0100 0000
        ( x < 352 ) ? 10 : -1 ; // 352 =    0x160 = 0b1 0110 0000
     */
}


// magic numbers below are for 16x16 tiles w/ 150 tiles on-screen
NSUInteger getMagicY( NSUInteger y ) {
    //MLOG( @"getMagicY()" );
    if ( ! isMagicYArrayInitialized ) {
        initializeMagicYArray();
        isMagicYArrayInitialized = YES;
    }
    return magicYArray[ y ];
    
    /*
    return
        ( y < 32 ) ? 14 :
        ( y < 64 ) ? 13 :
        ( y < 96 ) ? 12 :
        ( y < 128 ) ? 11 :
        ( y < 150 ) ? 10 :
        ( y < 192 ) ? 9 :
        ( y < 224 ) ? 8 :
        ( y < 256 ) ? 7 :
        ( y < 288 ) ? 6 :
        ( y < 320 ) ? 5 :
        ( y < 352 ) ? 4 :
        ( y < 384 ) ? 3 :
        ( y < 416 ) ? 2 :
        ( y < 448 ) ? 1 :
        ( y < 480 ) ? 0 : -1;
     */
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
    //[ tile.contents addObject: entity ];
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
    //MLOG( @"Returning tile " );
    return tile;
}



-( Tile * ) getMapTileFromPoint: (CGPoint) p forFloor: (DungeonFloor *) floor {
    Tile *tile = nil;
    for ( Tile *t in [floor tileDataArray ] ) {
        if ( t.position.x == p.x && t.position.y == p.y ) {
            tile = t;
            break;
        }
    }
    //MLOG( @"Returning tile " );
    return tile;
}






#pragma mark - EntityHUD Message code


/*
 ====================
 addMessage: message
 ====================
 */
//#define MAX_DISPLAYED_MESSAGES      7
#define MAX_DISPLAYED_MESSAGES      1
-( void ) addMessage: (NSString * ) message {
    NSString *str = [ NSString stringWithFormat: @"%@\n", message ];
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
 moveEntity: entity toPosition: position
 
 moves the entity on the map to position
 ====================
 */

-( void ) moveEntity:(Entity *)entity toPosition:(CGPoint)position {
    [ self moveEntity: entity toPosition:position onFloor:[dungeon objectAtIndex:floorNumber ] ];
}


/*
 ====================
 moveEntity: entity toPosition: position onFloor: floor
 
 moves the entity on the map to position on given dungeon floor
 ====================
 */

-( void ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position onFloor: (DungeonFloor *) floor {
//-( void ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position {
    //MLOG( @"moveEntity: %@ toPosition: (%f, %f)", entity.name, position.x, position.y );
    
    Tile *tile = [ self getMapTileFromPoint: position forFloor: floor ];
    if ( tile.tileType != TILE_FLOOR_VOID ) {
        
        BOOL isMoveValid = YES;
        BOOL npcExists = NO;
        BOOL pcExists = NO;
        BOOL itemExists = NO;
        // check if there is an NPC...
        
        for ( Entity *e in [tile contents] ) {
            if ( e.entityType == ENTITY_T_NPC ) {
                isMoveValid = NO;
                npcExists = YES;
                pcExists = NO;
                break;
            }
            else if ( e.entityType == ENTITY_T_PC ) {
                isMoveValid = NO;
                npcExists = NO;
                pcExists = YES;
                break;
            }
            else if ( e.entityType == ENTITY_T_ITEM ) {
                isMoveValid = YES;
                itemExists = YES;
            }
            
        }
        
        if ( isMoveValid ) {
            Tile *prevTile = [ self getTileForCGPoint: entity.positionOnMap ];
            [prevTile removeObjectFromContents:entity];
            
            [ GameRenderer setEntity: entity onTile:tile ];
            
            if ( entity == pcEntity ) {
                if ( tile.tileType == TILE_FLOOR_DOWNSTAIRS ) {
                    [ self addMessage: @"Going downstairs..." ];
                    //MLOG(@"Going downstairs...");
                    [ self goingDownstairs ];
                }
                else if ( tile.tileType == TILE_FLOOR_UPSTAIRS ) {
                    if ( floorNumber != 0 ) {
                        [ self addMessage: @"Going upstairs..." ];
                        //MLOG(@"Going upstairs...");
                    }
                    [ self goingUpstairs ];
                }
                
                else if ( itemExists ) {
                    // list all items on the tile
                    Entity *item = nil;
                    for ( Entity *e in [tile contents] ) {
                        if ( e.entityType == ENTITY_T_ITEM ) {
                            MLOG( @"There is a %@ here", e.name );
                            [ self addMessage: [NSString stringWithFormat:@"There is a %@ here", e.name]];
                            
                            if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_NONE ) {
                            
                            }
                            
                            else if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE ) {
                                //[ self addMessage: [NSString stringWithFormat:@"You pick up the %@", e.name]];
                                item = e;
                                break;
                            }
                        }
                    }
                    
                    if ( item != nil ) {
                        // add the item to your inventory
                        [ self handleItemPickup: item forEntity: entity ];
                    }
                }
            }
            
            else if ( entity.entityType == ENTITY_T_NPC ) {
                
                if ( tile.tileType == TILE_FLOOR_DOWNSTAIRS ) {
                    //[ self addMessage: @"Entity Going downstairs..." ];
                    //[ self goingDownstairs ];
                    [ self entityGoingDownstairs: entity ];
                    
                }
                else if ( tile.tileType == TILE_FLOOR_UPSTAIRS ) {
                    //[ self goingUpstairs ];
                    [ self entityGoingUpstairs: entity ];
                }
            }
        }
        
        else if ( npcExists ) {
            // moving into npc
            
            [ self handleAttackForEntity:entity toPosition:position];
        }
        
        else if ( pcExists ) {
            // moving into pc
            [ self handleAttackForEntity:entity toPosition:position];
        }
        
        else {
            //MLOG( @"Attempting to move into NPC." );
            //[ self addMessage: @"Can't move there!" ];
        }
    }
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
    //MLOG( @"distanceFromTile: a toTile: b" );
    NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
    
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}


#pragma mark - Initialization helper code

/*
 ====================
 initializeDungeon
 ====================
 */
-( void ) initializeDungeon {
    /*
     random-walk of 10-floor dungeon w/ 10-100 tiles each
     
     ipad test runs
     28680
     35594
     56391
     
     macbook test runs
     29739
     42096
     52222
     78244
     */
    
    [ self initializeTiles ];
    
    NSUInteger numberOfFloors = 10;
    
    dungeon = [[ NSMutableArray alloc ] init ];
    for ( int i = 0; i < numberOfFloors; i++ ) {
        DungeonFloor *newFloor = [ DungeonFloor newFloorWidth:40 andHeight:40 andFloorNumber: i ];
        if ( i != numberOfFloors - 1 ) {
            [ GameRenderer generateDungeonFloor:newFloor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
        }
        else {
            [ GameRenderer generateDungeonFloor:newFloor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR ];
        }
        [ dungeon addObject: newFloor ];
    }
    floorNumber = 0;
    [ self loadDungeonFloor: floorNumber ];
    
}


/*
 ====================
 loadDungeonFloor: floorNumber
 ====================
 */
-( void ) loadDungeonFloor: ( NSUInteger ) floorNumber {
    //MLOG( @"loadDungeonFloor" );
    //floor = [ dungeon objectAtIndex: floorNumber ];
    //[ GameRenderer setAllVisibleTiles:tileArray withDungeonFloor:floor withCamera:cameraAnchorPoint ];
    
    
    needsRedraw = YES;
 //   [ GameRenderer setAllVisibleTiles:tileArray withDungeonFloor:[dungeon objectAtIndex: floorNumber] withCamera:cameraAnchorPoint ];
   // [ self resetCameraPosition ];
    //MLOG( @"end loadDungeonFloor" );
}


/*
 ====================
 goingUpstairs
 ====================
 */
-( void ) goingUpstairs {
    //MLOG(@"goingUpstairs...");
    if ( floorNumber == 0 ) {
        // top floor
    }
    else {
        floorNumber--;
        [ self loadDungeonFloor: floorNumber ];
        [[[ dungeon objectAtIndex:floorNumber+1 ] entityArray ] removeObject: pcEntity ];
        
        // TODO: move setEntityOnDownstairs to GameRenderer (DungeonMaster)
        [ self setEntityOnDownstairs: pcEntity ];
        
        [[[ dungeon objectAtIndex:floorNumber ] entityArray ] addObject: pcEntity ];
        
        needsRedraw = YES;
        //[ self resetCameraPosition ];
        //[ GameRenderer setAllVisibleTiles:tileArray withDungeonFloor:[dungeon objectAtIndex:floorNumber] withCamera:cameraAnchorPoint ];
    }
    //MLOG(@"end goingUpstairs...");
}


/*
 ====================
 goingDownstairs
 ====================
 */
-( void ) goingDownstairs {
    //MLOG(@"goingDownstairs...");
    if ( floorNumber < [ dungeon count ] - 1 ) {
        floorNumber++;
        [ self loadDungeonFloor: floorNumber ];
        
        // TODO: move setEntityOnUpstairs to GameRenderer (DungeonMaster)
        
        [[[ dungeon objectAtIndex:floorNumber-1 ] entityArray ] removeObject: pcEntity ];
        
        [ self setEntityOnUpstairs: pcEntity ];
        
        [[[ dungeon objectAtIndex:floorNumber ] entityArray ] addObject: pcEntity ];
        
        needsRedraw = YES;
        //[ self resetCameraPosition ];
        //[ GameRenderer setAllVisibleTiles:tileArray withDungeonFloor:[ dungeon objectAtIndex:floorNumber] withCamera:cameraAnchorPoint ];
    }
    else {
        // bottom floor        
    }
    //MLOG(@"end goingDownstairs...");
}


/*
 ====================
 entityGoingUpstairs
 ====================
 */
-( void ) entityGoingUpstairs: (Entity *) entity {
   // MLOG(@"entityGoingUpstairs not yet implemented!");
    /*
     autostepGameLogic = NO;
    gameLogicIsOn = NO;
    [ self unscheduleStepAction ];
     */
}


/*
 ====================
 entityGoingDownstairs
 ====================
 */
-( void ) entityGoingDownstairs: (Entity *) entity {
   // MLOG(@"entityGoingDownstairs not yet implemented!");
    /*
     autostepGameLogic = NO;
    gameLogicIsOn = NO;
    [ self unscheduleStepAction ];
     */
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
-( void ) setEntityOnUpstairs:(Entity *)entity forFloor: (DungeonFloor *) floor {
    // find the upstairs tile
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: floor ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ floor tileDataArray ] ) {
        if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
            tile = t;
            break;
        }
    }
    [ GameRenderer setEntity:entity onTile:tile];
}


/*
 ====================
 setEntityOnDownstairs: entity forFloor: floor
 ====================
 */
-( void ) setEntityOnDownstairs:(Entity *)entity forFloor: (DungeonFloor *) floor {
    // find the upstairs tile
    CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: floor ];
    
    // set the starting tile
    Tile *tile = nil;
    for ( Tile *t in [ floor tileDataArray ] ) {
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
 initializeNotifications
 
 initializes the various notifications used by the game's engine
 ====================
 */
-( void ) initializeNotifications {
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification1" object:nil];
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification2" object:nil];
    
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"MonitorNotification" object:nil];
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"MoveNotification" object:nil];
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"StepNotification" object:nil];
    
    [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"PlayerMenuCloseNotification" object:nil];
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
    [ self addEditorHUD: editorHUD ];
    
    
    monitorIsVisible = NO;
    [ self initMonitor ];
    [ self addMonitor: monitor ];
    
   
    playerHUDIsVisible = NO;
    [ self initPlayerHUD ];
    [ self addPlayerHUD: playerHUD ];
    
    playerMenuIsVisible = NO;
    [ self initPlayerMenu ];
    //[ self addPlayerMenu: playerMenu ];
    
    entityInfoHUDIsVisible = NO;
    [ self initEntityInfoHUD ];
    [ self addEntityInfoHUD: entityInfoHUD ];
    
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
    hero.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    //hero.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SIMPLE;
    hero.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE;
    
    hero.level = 1;
    
    hero.strength = [Dice roll:6 nTimes:3];
    hero.dexterity = [Dice roll:6 nTimes:3];
    hero.constitution = [Dice roll:6 nTimes:3];
    hero.intelligence = [Dice roll:6 nTimes:3];
    hero.wisdom = [Dice roll:6 nTimes:3];
    hero.charisma = [Dice roll:6 nTimes:3];
    
    
    NSInteger conMod =
    hero.constitution <= 3 ? -4 :
    hero.constitution <= 5 ? -3 :
    hero.constitution <= 7 ? -2 :
    hero.constitution <= 9 ? -1 :
    hero.constitution <= 11 ? 0 :
    hero.constitution <= 13 ? 1 :
    hero.constitution <= 15 ? 2 :
    hero.constitution <= 17 ? 3 : 4;
    
    hero.maxhp = [Dice roll:12] + conMod;
    hero.hp = hero.maxhp;
    
    hero.ac = 20;
    
    pcEntity = hero;
    //[ Entity drawTextureForEntity: hero ];
}

/*
 ====================
 getGameStateString: state
 
 returns a string for the given state
 ====================
 */
-( NSString * ) getGameStateString: ( GameState_t ) state {
    NSString *retval = nil;
    if ( state == GAMESTATE_T_GAME ) {
        retval = @"GAMESTATE_T_GAME";
    } else if ( state == GAMESTATE_T_GAME_PC_SELECTMOVE ) {
       retval = @"GAMESTATE_T_GAME_PC_SELECTMOVE";
    }
    else if ( state == GAMESTATE_T_GAME_PC_STEP ) {
       retval = @"GAMESTATE_T_GAME_PC_STEP";
    }
    else if ( state == GAMESTATE_T_MAINMENU ) {
       retval = @"GAMESTATE_T_MAINMENU";
    }
    
    else if ( state == GAMESTATE_T_GAME_PC_DEAD ) {
        retval =@"GAMESTATE_T_GAME_PC_DEAD";
    }
    
    else {
        retval = [NSString stringWithFormat:@"%d", state];
    }
    
    return retval;
}


#pragma mark - Game Logic code

-( void ) haveAllEntitiesActOnThisFloor {
    [self haveAllEntitiesActOnFloor:[dungeon objectAtIndex:floorNumber]];
}


-( void ) haveAllEntitiesActOnFloor:(DungeonFloor *) floor {
    for ( int i = 0; i < [[floor entityArray] count]; i++ ) {
        Entity *e = [[floor entityArray] objectAtIndex: i];
        if ( e.entityType != ENTITY_T_PC ){
            [ e step ];
            [ self handleEntityStep: e ];
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
        
        //if ( floorNumber == 0 ) {
        
        /*
        for ( int i = 0; i < [dungeon count]; i++ ) {
            DungeonFloor *f = [dungeon objectAtIndex:i];
            for ( int j = 0; j < [[f entityArray] count]; j++ ) {
                Entity *e = [[ f entityArray ] objectAtIndex: j];
                if ( e.entityType != ENTITY_T_PC ){
                    if ( e.isAlive ) {
                        [ e step ];
                        [ self handleEntityStep: e ];
                    }
                }
            }
        }
        */
        
        
        // have all entities on this floor act
 
        [ self haveAllEntitiesActOnThisFloor ];
        
        /*
        for ( int i = 0; i < [[[dungeon objectAtIndex:floorNumber] entityArray] count]; i++ ) {
            Entity *e = [[[dungeon objectAtIndex:floorNumber] entityArray] objectAtIndex: i];
            if ( e.entityType != ENTITY_T_PC ){
                [ e step ];
                [ self handleEntityStep: e ];
            }
        }
         */
        
        // cleanup entityArray
        for ( int i = 0; i < [[[dungeon objectAtIndex:floorNumber] entityArray] count]; i++ ) {
            Entity *e = [[[dungeon objectAtIndex:floorNumber] entityArray] objectAtIndex: i];
            if ( e.isAlive == NO ) {
                [[[dungeon objectAtIndex:floorNumber] entityArray] removeObject: e ];
                i = 0;
            }
        }
 
        // spawn a new monster on the current floor
       /*
        NSUInteger spawnChancePercent = 1;
        NSUInteger diceroll = [Dice roll:100];
        if ( diceroll <= spawnChancePercent ) {
        */
//        [ GameRenderer spawnRandomMonsterAtRandomLocationOnFloor:[ dungeon objectAtIndex:floorNumber] withPC: pcEntity];
        [ GameRenderer spawnRandomMonsterAtRandomLocationOnFloor:[ dungeon objectAtIndex:floorNumber] withPC:pcEntity withChanceDie: 100 ];
        //}
 
        
        Tile *tile = [ self getTileForCGPoint: pcEntity.positionOnMap ];
        if ( floorNumber == 0 &&
            tile.tileType == TILE_FLOOR_UPSTAIRS &&
            [[pcEntity inventoryArray] count] > 0 ) {
         
            [ self addMessage:[NSString stringWithFormat: @"You win!\nYou killed %d monsters\n", pcEntity.totalKills ] ];
            gameLogicIsOn = NO;
            autostepGameLogic = NO;
            [ self unscheduleStepAction ];
            
        }
        
        // increase turn counter
        turnCounter++;
        
        needsRedraw = YES;
    }
}


/*
 ====================
 handleEntityStep: e
 
 handle the step for entity e
 ====================
 */
-( void ) handleEntityStep: ( Entity * ) e {
    if (e.pathFindingAlgorithm == ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM )
    {
        
        BOOL rollIsUnacceptable = YES;
        CGPoint newPosition;
        
        while ( rollIsUnacceptable )
        {
            NSUInteger roll = [Dice roll:8];
            CGFloat x = -1;
            CGFloat y = -1;
            
            //MLOG( @"rolled %d", roll );
            
            // UDLR UL, UR, DL, DR
            if ( roll == 1 ) {
                x = 0;
                y = -1;
            }
            else if ( roll == 2 ) {
                x = 0;
                y = 1;
            }
            else if ( roll == 3) {
                x = -1;
                y = 0;
            }
            else if ( roll == 4) {
                x = 1;
                y = 0;
            }
            else if ( roll == 5) {
                x = -1;
                y = -1;
            }
            else if ( roll == 6) {
                x = 1;
                y = -1;
            }
            else if ( roll == 7) {
                x = -1;
                y = 1;
            }
            else if ( roll == 8) {
                x = 1;
                y = 1;
            }
            
            newPosition.x = e.positionOnMap.x + x;
            newPosition.y = e.positionOnMap.y + y;
            
            Tile *tile = [ self getTileForCGPoint: newPosition ];
            if ( tile.tileType == TILE_FLOOR_VOID ) {
                rollIsUnacceptable = TRUE;
            } else {
                rollIsUnacceptable = FALSE;
            }
        }
        
        
        //MLOG( @"(%.0f,%.0f)", e.positionOnMap.x, e.positionOnMap.y );
        //MLOG( @"(%.0f,%.0f)", newPosition.x, newPosition.y );
        
        // try to move the entity to the new position
        // TODO: move movEntity to GameRenderer
        [ self moveEntity:e toPosition: newPosition ];
    }
}



/*
 ====================
 npcEntityAtPosition: pos
 
 returns the NPC entity at position pos
 ====================
 */
-( Entity * ) npcEntityAtPosition: (CGPoint) pos {
    //MLOG( @"npcEntityAtPosition: (%.0f,%.0f)", pos.x, pos.y );
    
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
    //MLOG( @"handleAttackForEntity: %@ toPosition: (%.0f,%.0f)", e, pos.x, pos.y );
    
    // get the tile we are attacking
    
    Tile *t = [ self getTileForCGPoint: pos ];
    
    if ( t.tileType == TILE_FLOOR_VOID ) {
        // can't attack a void tile
        MLOG( @"can't attack a void tile!" );
        [ self addMessage: @"Can't attack that!" ];
    }
    
    else {
        // check if tile has entities
        
        BOOL tileHasEntities = ([t contents].count > 0);
 
        if ( tileHasEntities ) {
            // attacking an entity
            
            Entity *target = [ self npcEntityAtPosition: pos ];
            
            if ( target == nil ) {
                return;
            }
            
            // e v.s. target setup section
            // modifiers would go here
            
            NSInteger roll = [Dice roll:20];
            NSInteger totalroll = roll + e.attackBonus;
            
            
            // attack condition section
            // probably comparing attack roll vs armor class
            
            BOOL victory = NO;
            
            if ( totalroll >= target.totalac ) {
                victory = YES;
            }
            
            
            //if ( roll > 10 && target != pcEntity ) {
            //    victory = TRUE;
            //}
            // attack exchange
            // cleanup
            /*
            if ( [target.name isEqualToString:@"Mike" ] ) {
                MLOG( @"%@ attacks %@", e.name, target.name );
                [ self addMessage: [NSString stringWithFormat: @"%@ attacks %@", e.name, target.name ]];
            }
             */
            
            if ( victory && e.isPC ) {
                //if ( roll == 20 ) { // critical roll!
                //    target.hp -= e.damageRoll + e.damageRoll;
                //    MLOG(@"Critical!");
                //}
                
                //else {
                    // deal damage to NPC
                NSInteger totaldamage = e.damageRoll;
                totaldamage = (totaldamage > 0) ? totaldamage : 0;
                target.hp -= totaldamage;
                
                [ self addMessage: [ NSString stringWithFormat:@"%@ dealt %d damage to Lv%d %@", e.name, totaldamage, target.level, target.name ]];
                //}
                
                if (target.hp <= 0 ) {
                    // increase entity xp
                    [ e gainXP: target.level ];
                    
                    pcEntity.totalKills++;
                    // remove target from t.contents
                    [ self addMessage: [ NSString stringWithFormat:@"%@ slayed Lv%d %@", e.name, target.level, target.name ] ];
                    [t removeObjectFromContents: target];
                    target.isAlive = NO;
                }
            }
            
            else if ( !victory && e.isPC ) {
                [ self addMessage: [ NSString stringWithFormat:@"%@ missed Lv%d %@", e.name, target.level, target.name ]];
            }
            
            else if ( victory && e.entityType == ENTITY_T_NPC && target.entityType == ENTITY_T_NPC ) {
                //if ( roll == 20 ) { // critical
                  //  target.hp -= e.damageRoll + e.damageRoll;
                  //  MLOG(@"Critical!");
                //}
                
                //else {
                    // deal damage to NPC
                NSInteger totaldamage = e.damageRoll;
                totaldamage = (totaldamage > 0) ? totaldamage : 0;
                target.hp -= totaldamage;
                
                //}
                
                if (target.hp <= 0 ) {
                    // increase entity xp
                    [ e gainXP: target.level ];
                    e.totalKills++;
                    
                    // remove target from t.contents
                  //  [ self addMessage: [ NSString stringWithFormat:@"%@ slayed %@", e.name, target.name ] ];
                    [t removeObjectFromContents: target];
                    target.isAlive = NO;
                }
                
            }
            
            
            else if ( victory && e.entityType == ENTITY_T_NPC && target.entityType == ENTITY_T_PC ) {
                // deal damage to PC
                //pcEntity.hp--;
                //if ( roll == 20 ) {// critical
                //    pcEntity.hp -= e.damageRoll + e.damageRoll;
                 //   MLOG(@"Critical!");
                //}
                //else {
                
                NSInteger totaldamage = e.damageRoll;
                totaldamage = (totaldamage > 0) ? totaldamage : 0;
                target.hp -= totaldamage;
                
                [ self addMessage: [ NSString stringWithFormat:@"%@ took %d damage from Lv%d %@", pcEntity.name, totaldamage, e.level, e.name ] ];
                //}
                
                if ( pcEntity.hp <= 0 ) {
                    MLOG(@"You died...");
                    [ self addMessage: [NSString stringWithFormat:@"You died.\nYou killed %d monsters.\nYou %@ the Book of All-Knowing.\n",
                                        pcEntity.totalKills,
                                        pcEntity.inventoryArray.count > 0 ? @"got" : @"did not get" ] ];
                    pcEntity.isAlive = NO;
                    gameLogicIsOn = NO;
                    autostepGameLogic = NO;
                    gameState = GAMESTATE_T_GAME_PC_DEAD;
                    [ self unscheduleStepAction ];
                }
                
            }
            
            
            else {
                // target not killed
                //MLOG( @"%@ remains", target.name );
                //[ self addMessage: [NSString stringWithFormat: @"%@ remains", target.name] ];
            }
            
        
        } else {
            // attacking thin air
            //MLOG( @"%@ attacks thin air...", e.name );
        }
    }
    
}




/*
 ====================
 handleItemPickup: item forEntity: entity
 ====================
 */
-( void ) handleItemPickup: (Entity *) item forEntity: (Entity *) entity {
    
    if ( item != nil && entity == pcEntity ) {
        if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_NONE ) {
        } else if ( entity.itemPickupAlgorithm == ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE ) {
            // add the item to the entity's inventory
            Tile *itemTile = [ self getTileForCGPoint:item.positionOnMap ];
            if ( itemTile != nil ) {
                
                //MLOG( @"%@ picks up a %@", entity.name, item.name );
                [ self addMessage: [NSString stringWithFormat:@"%@ picks up a %@", entity.name, item.name]];
                
                [[ entity inventoryArray ] addObject: item ];
                // remove the item from our entityArray and from it's tile's contents
                [[[ dungeon objectAtIndex:floorNumber ] entityArray ] removeObject: item];
                [[ itemTile contents ] removeObject: item];
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
            //MLOG( @"%@ drops a %@", entity.name, item.name );
            [ self addMessage: [NSString stringWithFormat:@"%@ drops a %@", entity.name, item.name]];
            
            //[ self setEntity:item onTile:entityTile ];
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
        [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"StepNotification" object: self ];
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
 floor
 ====================
-( DungeonFloor * ) floor {
    return floor;
}
 */

/*
 ====================
 setFloor: f
 ====================
-( void ) setFloor: (DungeonFloor *) f {
    floor = f;
}
 */


@end