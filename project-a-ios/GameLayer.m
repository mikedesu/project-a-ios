//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "Dice.h"
#import "GameLayer.h"

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
        self.isTouchEnabled = YES;
        selectedTile = -1;
        //prevSelectedTile = -1;
        touchedTileIndex = -1;
        isTouched = NO;
        
        // Dungeon Floor initialization
        
        //floor = [ DungeonFloor newFloor ];
        floor = [ DungeonFloor newFloorWidth:10 andHeight:10 ];
        [ self initializeTiles ];
        [ self drawDungeonFloor: floor toTileArray: tileArray ];
        
        [ GameRenderer generateDungeonFloor: floor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
 
        
        CGPoint startPoint = [ GameRenderer getUpstairsTileForFloor: floor ];
        
        [ GameRenderer setAllVisibleTiles: tileArray withDungeonFloor: floor withCamera:cameraAnchorPoint ];
        
        //////////////////////
        
        Entity *hero = [ [ Entity alloc ] init ];
        [ hero.name setString: @"Mike" ];
        hero.entityType = ENTITY_T_PC;
        hero.isPC = YES;
        
        pcEntity = hero;
        
        //[ Entity drawTextureForEntity: hero ];
        
        cameraAnchorPoint = ccp( 7, 5 );
        
        entityArray = [ [ NSMutableArray alloc ] init ];
        [ entityArray addObject: hero ];
 
        Tile *startTile = nil;
        for ( Tile *t in [ floor tileDataArray ] ) {
            if ( t.position.x == startPoint.x && t.position.y == startPoint.y ) {
                startTile = t;
                break;
            }
        }
        [ self setEntity:hero onTile: startTile ];
        [ self resetCameraPosition ];
        
//        selectedTilePoint = hero->positionOnMap;
        //[ self selectTileAtPosition: [hero positionOnMap] ];
        //selectedTilePoint = [hero positionOnMap ];
        selectedTilePoint.x = -1;
        selectedTilePoint.y = -1;
        
        
        dLog = [ [ NSMutableArray alloc ] init ];
        dLogIndex = 0;
        
        [ self addMessage: @"Testing" ];
        [ self addMessage: @"Editor" ];
        [ self addMessage: @"HUD" ];
        [ self addMessage: @"Output" ];
        [ self addMessage: @"Nice :)" ];
        [ self addMessage: @"Let's roll" ];
        [ self addMessage: @"" ];
        
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
        
        heroTouches = 0;
        
        turnCounter = 1;
        
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification1" object:nil];
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification2" object:nil];
        
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"ShowHideEditorHUD" object:nil];
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"MoveNotification" object:nil];
        /*
         */
        
        [ self schedule:@selector(tick:)];
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
    if ( [[ notification name ] isEqualToString: @"TestNotification1" ] ) {
        MLOG( @"TestNotification1" );
    } else if ( [[ notification name ] isEqualToString: @"TestNotification2" ] ) {
        MLOG( @"TestNotification2" );
    } else if ( [[ notification name ] isEqualToString: @"ShowHideEditorHUD" ] ) {
        MLOG( @"ShowHideEditorHUD" );
        if ( ! editorHUDIsVisible ) {
            [ self addEditorHUD: editorHUD ];
        } else {
            [ self removeEditorHUD: editorHUD ];
        }
    } else if ( [[ notification name ] isEqualToString: @"MoveNotification" ] ) {
        MLOG( @"MoveNotification" );
        
        [ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME_PC_SELECTMOVE;
        
    } else if ( [[ notification name ] isEqualToString: @"AttackNotification" ] ) {
        MLOG( @"AttackNotification" );
        
        [ self removePlayerMenu: playerMenu ];
        gameState = GAMESTATE_T_GAME;
    } else {
        MLOG( @"Notification not handled: %@", notification.name );
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
    playerMenu = [[ PlayerMenu alloc ] initWithColor: black_alpha(200) width:150 height:250 ];
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
 initEditorHUD
 
 initializes the Editor HUD
 ====================
 */
-( void ) initEditorHUD {
    CGSize size = [[CCDirector sharedDirector] winSize];
    editorHUD = [[ EditorHUD alloc ] initWithColor:black_alpha(150) width:250 height:100 ];
    editorHUD.position = ccp(  0 , size.height - (editorHUD.contentSize.height) );
    [ self updateEditorHUDLabel ];
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
    monitor.position = ccp(  0 , size.height - (monitor.contentSize.height) - (editorHUD.contentSize.height) - 10 );
    [ self updateMonitorLabel ];
}


-(void) addMonitor: (EditorHUD *) monitor {
    if ( ! self->monitorIsVisible ) {
        [ self addChild: monitor ];
        monitorIsVisible = YES;
    }
}


-(void) removeMonitor: (EditorHUD *) monitor {
    if ( self->monitorIsVisible ) {
        [ self removeChild: monitor cleanup: NO ];
    }
}


-(void) updateMonitorLabel {
    @try {
    [monitor.label setString:
     [NSString stringWithFormat: @"GameState: %d\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nDistance: %d\n",
      
      gameState,
      selectedTilePoint.x,
      selectedTilePoint.y,
      pcEntity.positionOnMap.x,
      pcEntity.positionOnMap.y,
      cameraAnchorPoint.x,
      cameraAnchorPoint.y,
      [GameRenderer distanceFromTile:[GameRenderer getTileForFloor:floor forCGPoint:selectedTilePoint] toTile:[GameRenderer getTileForFloor:floor forCGPoint:pcEntity.positionOnMap
        ]] ]
     ];
        
    } @catch ( NSException *e ) {
        //MLOG( @"Exception caught: %@", e );
        [monitor.label setString:
         [NSString stringWithFormat: @"GameState: %d\nSelected tile: (%.0f,%.0f)\nPC.pos: (%.0f,%.0f)\nCamera.pos: (%.0f,%.0f)\nDistance: %d\n",
          
          gameState,
          selectedTilePoint.x,
          selectedTilePoint.y,
          pcEntity.positionOnMap.x,
          pcEntity.positionOnMap.y,
          cameraAnchorPoint.x,
          cameraAnchorPoint.y,
          0
          ]
         ];
        
    }
}






/*
 ====================
 updateEditorHUDLabel
 
 updates the Editor HUD Label
 ====================
 */
-( void ) updateEditorHUDLabel {
    [[editorHUD label] setString: [ NSString stringWithFormat: @"%@%@%@%@%@%@%@",
                                  [dLog objectAtIndex: dLogIndex+0 ],
                                  [dLog objectAtIndex: dLogIndex+1 ],
                                  [dLog objectAtIndex: dLogIndex+2 ],
                                  [dLog objectAtIndex: dLogIndex+3 ],
                                  [dLog objectAtIndex: dLogIndex+4 ],
                                  [dLog objectAtIndex: dLogIndex+5 ],
                                  [dLog objectAtIndex: dLogIndex+6 ]
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
    [ [playerHUD label] setString: [ NSString stringWithFormat: @"%@\n%@\n%@\n",
                                   [ NSString stringWithFormat: @"%@     T:%d", pcEntity.name, turnCounter ],
                                   [ NSString stringWithFormat: @"St:0 Dx:0 Co:0 In:0 Wi:0 Ch:0 Align" ],
                                   [ NSString stringWithFormat: @"Dlvl:1 $:0 HP:1/1 Pw: 0/0 AC:0 Xp:0/100"]
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
    [ GameRenderer setAllVisibleTiles: tileArray withDungeonFloor: floor withCamera:cameraAnchorPoint ];
    
    if ( editorHUDIsVisible ) {
        [ self updateEditorHUDLabel ];
    }
    if ( monitorIsVisible ) {
        [self updateMonitorLabel];
    }
    
    if ( playerHUDIsVisible ) {
        [ self updatePlayerHUDLabel ];
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
    MLOG( @"ccTouchesBegan" );
	UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    isTouched = YES;
    
    CGPoint touchedTilePoint = [ self getTileCGPointForTouch: touch ];
    CGPoint mapPoint = [ self translateTouchPointToMapPoint: touchedTilePoint ];
    
    //[ self addMessage: [NSString stringWithFormat: @"touched tile (%.0f,%.0f)", mapPoint.x, mapPoint.y ]];
    //[ self addMessage: [NSString stringWithFormat: @"selectedTilePoint (%.0f,%.0f)", selectedTilePoint.x, selectedTilePoint.y ]];
    
    //MLOG( @"selectedTilePoint: (%f, %f)", selectedTilePoint.x, selectedTilePoint.y );
    
    // valid selected point
    if ( selectedTilePoint.x >= 0 && selectedTilePoint.y >= 0 ) {
        
        //[ self addMessage: @"Tile was previously selected" ];
    
        
        [ self selectTileAtPosition: mapPoint ];
        
        if ( pcEntity.positionOnMap.x == mapPoint.x && pcEntity.positionOnMap.y == mapPoint.y ) {
            [ self addMessage: @"Selected Player" ];
            heroTouches++;
            
            if ( heroTouches == 2) {
                [ self addPlayerMenu: playerMenu ];
                heroTouches = 0;
            } else if ( heroTouches == 1 && playerMenuIsVisible ) {
                [ self removePlayerMenu: playerMenu ];
                heroTouches = 0;
            }
            
        } else {
            if ( heroTouches > 0 ) {
                heroTouches = 0;
            }
        }
        
        
        
        /*
        Tile *prevSelectedTile = [ self getTileForCGPoint: selectedTilePoint ];
        if ( prevSelectedTile.position.x == mapPoint.x && prevSelectedTile.position.y == mapPoint.y ) {
            
            [ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
            selectedTilePoint = mapPoint;   // sets this tile to be remembered
            [ self selectTileAtPosition: mapPoint ];
            
            //Tile *selectedTile = [ self getTileForCGPoint: mapPoint ];
            
            if ( [pcEntity positionOnMap].x  == mapPoint.x && [pcEntity positionOnMap].y == mapPoint.y ) {
                
                heroTouches++;
                [ self addMessage: [NSString stringWithFormat: @"heroTouches=%d", heroTouches ]];
                
                if ( heroTouches == 2 ) {
                    if ( ! playerMenuIsVisible ) {
                        [ self addPlayerMenu: playerMenu ];
                    } else {
                        [ self removePlayerMenu: playerMenu ];
                    }
                    heroTouches = 0;
                } else if ( heroTouches == 1 && playerMenuIsVisible ) {
                    [ self removePlayerMenu: playerMenu ];
                    heroTouches = 0;
                } else if ( heroTouches == 1 && !playerMenuIsVisible) {
                    [ self selectTileAtPosition: mapPoint ];
                }
            } else {
                
                //[ self moveEntity:pcEntity toPosition:mapPoint ];
                //[ self resetCameraPosition ];
                //turnCounter++;
                
            }
        
        }
    
        else {
            
        
            
            if ( gameState == GAMESTATE_T_GAME_PC_SELECTMOVE ) {
                
                [ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
                [ self moveEntity:pcEntity toPosition:mapPoint ];
                [ self resetCameraPosition ];
                //[ self selectTileAtPosition: mapPoint ];
                turnCounter++;
                
                gameState = GAMESTATE_T_GAME;
                
            } else {
                
                [ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
                selectedTilePoint = mapPoint;   // sets this tile to be remembered
                [ self selectTileAtPosition: mapPoint ];
                
                //gameState = GAMESTATE_T_GAME_PC_SELECTMOVE;
                
            }
         
        }
        
          */
    }
    
    // invalid selected point / nothing selected
    else {
        //[ self addMessage: @"Nothing previously selected" ];
        
        
        [ self selectTileAtPosition: mapPoint ];
        
        
        if ( [pcEntity positionOnMap].x  == mapPoint.x && [pcEntity positionOnMap].y == mapPoint.y ) {
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
            
            
            NSInteger distance = [GameRenderer distanceFromTile:[GameRenderer getTileForFloor:floor forCGPoint:mapPoint] toTile:[GameRenderer getTileForFloor:floor forCGPoint:pcEntity.positionOnMap]];
            
            [ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
            
            if ( distance > 1 ) {
                [ self addMessage: @"Cannot move that far in one turn!" ];
                gameState = GAMESTATE_T_GAME;
            }
            
            else {
            
                if ( [self getTileForCGPoint:mapPoint].tileType == TILE_FLOOR_DOWNSTAIRS ) {
                    
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    [ self resetCameraPosition ];
                    [ self addMessage: @"Going downstairs" ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                    
                }
                
                else if ( [self getTileForCGPoint:mapPoint].tileType == TILE_FLOOR_UPSTAIRS ) {
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    [ self resetCameraPosition ];
                    [ self addMessage: @"Going upstairs" ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                }
                
                else {
                    [ self moveEntity:pcEntity toPosition:mapPoint ];
                    [ self resetCameraPosition ];
                    turnCounter++;
                    gameState = GAMESTATE_T_GAME;
                }
            }
            
            
            
            
            
        } else {
            
            //[ self selectTileAtPosition: selectedTilePoint ]; // de-selected the previously selected tile
            //selectedTilePoint = mapPoint;   // sets this tile to be remembered
            //[ self selectTileAtPosition: mapPoint ];
            
            //gameState = GAMESTATE_T_GAME_PC_SELECTMOVE;
            
            if ( heroTouches > 0 ) {
                heroTouches = 0;
            }
        }

        
    }
    
    
    [ self updateMonitorLabel ];
    
    
}


/*
 ====================
 ccTouchesMoved: touches withEvent: event
 ====================
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches moved" );
}


/*
 ====================
 ccTouchesEnded: touches withEvent: event
 ====================
 */
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches ended" );
    //UITouch *touch = [ touches anyObject ];
        
    isTouched = NO;
    
    //double now = [ NSDate timeIntervalSinceReferenceDate ];
    //double timeElapsedSinceTouchBegan = now - touchBeganTime;
    
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



-( void ) drawDungeonFloor: ( DungeonFloor * ) dungeonFloor toTileArray: ( NSArray * ) tileArray {
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


-( Tile * ) getTileForCGPoint: ( CGPoint ) p  {
    Tile *tile = nil;
    tile = [ [ floor tileDataArray ] objectAtIndex: p.x + ( p.y * [ floor width ] ) ];
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
    [ tile.contents addObject: entity ];
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
    for ( Tile *t in [ floor tileDataArray ] ) {
        if ( t.position.x == p.x && t.position.y == p.y ) {
            tile = t;
            break;
        }
    }
    MLOG( @"Returning tile " );
    return tile;
}


/*
 ====================
 addMessage: message
 ====================
 */
#define MAX_DISPLAYED_MESSAGES      7
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
    for ( Entity *e in entityArray ) {
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
-( void ) moveEntity: ( Entity * ) entity toPosition: ( CGPoint ) position {
    MLOG( @"moveEntity: %@ toPosition: (%f, %f)", entity.name, position.x, position.y );
    [ self addMessage: [NSString stringWithFormat: @"%@ -> (%.0f,%.0f)", entity.name, position.x, position.y]];
    Tile *tile = [ self getMapTileFromPoint: position ];
    if ( tile.tileType != TILE_FLOOR_VOID ) {
        Tile *prevTile = [ self getTileForCGPoint: entity.positionOnMap ];
        [prevTile.contents removeObject: entity];
        [ self setEntity: entity onTile: tile ];
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
            MLOG( @"Invalid point: (%.0f,%.0f)", position.x, position.y );
        }
    } else {
        if ( position.x >= 0 && position.y >= 0 ) {
            
            Tile *tile = [ self getMapTileFromPoint: position ];
            tile.isSelected = YES;
            selectedTilePoint = position;
        
        } else {
            
            // invalid point fed into selection
            MLOG( @"Invalid point: (%.0f,%.0f)", position.x, position.y );
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
    MLOG( @"distanceFromTile: a toTile: b" );
    NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
    
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}

@end