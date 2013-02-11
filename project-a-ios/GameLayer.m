//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "AppDelegate.h"
#import "CCMutableTexture2D.h"
#import "EditorHUD.h"
#import "Entity.h"
#import "GameConfig.h"
#import "GameLayer.h"
#import "GameRenderer.h"
#import "Tile.h"



@implementation GameLayer

/*
 ====================
 scene
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
 ====================
 */
-(id) init {
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        selectedTile = -1;
        prevSelectedTile = -1;
        touchedTileIndex = -1;
        isTouched = NO;
        
        [ self initializeTiles ];
        [ self initializeTileData ];
        
        Entity *hero = [ [ Entity alloc ] init ];
        [ hero->name setString: @"Hero" ];
        hero->positionOnMap = ccp( 5, 7 );
        
        /*
        Entity *test1 = [ [ Entity alloc ] init ];
        [ test1->name setString: @"Test1" ];
        test1->positionOnMap = ccp( 2, 3 );
        */
        
        entityArray = [ [ NSMutableArray alloc ] init ];
        [ entityArray addObject: hero ];
        //[ entityArray addObject: test1 ];
        
        // link the entityArray up with the tileArray
        for ( Entity *entity in entityArray ) {
            Tile *entityTile = [ tileDataArray objectAtIndex: entity->positionOnMap.x + entity->positionOnMap.y * NUMBER_OF_TILES_ONSCREEN_X ];
            [ entityTile->contents addObject: entity ];
        }
        
        dLog = [ [ NSMutableArray alloc ] init ];
        dLogIndex = 0;
        
        [ self addMessage: @"Testing" ];
        [ self addMessage: @"Editor" ];
        [ self addMessage: @"HUD" ];
        [ self addMessage: @"Output" ];
        [ self addMessage: @"Nice :)" ];
        [ self addMessage: @"Let's roll" ];
        
        
        editorHUDIsVisible = NO;
        [ self initEditorHUD ];
        //[ self addEditorHUD: editorHUD ];
        
        
        playerHUDIsVisible = NO;
        [ self initPlayerHUD ];
        [ self addPlayerHUD: playerHUD ];
        
        playerMenuIsVisible = NO;
        [ self initPlayerMenu ];
        //[ self addPlayerMenu: playerMenu ];
        
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification1" object:nil];
        [[ NSNotificationCenter defaultCenter ] addObserver: self selector:@selector(receiveNotification:) name:@"TestNotification2" object:nil];
        
        
        [ self schedule:@selector(tick:)];
	}
	return self;
}


/*
 ====================
 receiveNotification: notification
 ====================
 */
-( void ) receiveNotification: ( NSNotification * ) notification {
    
    if ( [[ notification name ] isEqualToString: @"TestNotification1" ] ) {
        [ self addMessage: @"TestNotification1" ];
        MLOG( @"TestNotification1" );
    } else if ( [[ notification name ] isEqualToString: @"TestNotification2" ] ) {
        [ self addMessage: @"TestNotification2" ];
        MLOG( @"TestNotification2" );
    }
    
}




/*
 ====================
 initPlayerMenu
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
 ====================
 */
-( void ) addPlayerMenu: ( PlayerMenu * ) menu {
    if ( ! playerMenuIsVisible ) {
        [ self addChild: menu ];
        playerMenuIsVisible = YES;
    }
}


/*
 ====================
 removePlayerMenu: menu
 ====================
 */
-( void ) removePlayerMenu: ( PlayerMenu * ) menu {
    if ( playerMenuIsVisible ) {
        [ self removeChild: menu cleanup: NO ];
        playerMenuIsVisible = NO;
    }
}





/*
 ====================
 initEditorHUD
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
 updateEditorHUDLabel
 ====================
 */
-( void ) updateEditorHUDLabel {
    [editorHUD->label setString: [ NSString stringWithFormat: @"%@%@%@%@%@",
                                  [dLog objectAtIndex: dLogIndex+0 ],
                                  [dLog objectAtIndex: dLogIndex+1 ],
                                  [dLog objectAtIndex: dLogIndex+2 ],
                                  [dLog objectAtIndex: dLogIndex+3 ],
                                  [dLog objectAtIndex: dLogIndex+4 ]
                                  ]];
}


/*
 ====================
 addEditorHUD: hud
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
 updateEditorHUDLabel
 ====================
 */
-( void ) updatePlayerHUDLabel {
    [ playerHUD->label setString: @"Player HUD" ];
}



/*
 ====================
 dealloc
 ====================
 */
- (void) dealloc {
	//[super dealloc];
}


/*
 ====================
 tick: dt
 ====================
 */
-(void)tick:(ccTime)dt {
    //MLOG( @"tick" );
    //[ self colorScrambleAllTiles ];
    //[ GameRenderer colorScrambleAllTiles: tileArray ];
    // [ self renderGameState ];
    
    
    [GameRenderer setAllTiles:tileArray withData: tileDataArray ];
    
    if ( editorHUDIsVisible ) {
        [ self updateEditorHUDLabel ];
    }
    if ( playerHUDIsVisible ) {
        [ self updatePlayerHUDLabel ];
    }
    
}


/*
 ====================
 ccTouchesBegan: touches withEvent: event
 ====================
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches began" );
    //[ self addMessage:  @"ccTouchesBegan\n" ];
	UITouch *touch=[touches anyObject];
    touchBeganTime = [NSDate timeIntervalSinceReferenceDate];
    
    isTouched = YES;
    touchedTileIndex = [ self getTileIndexForTouch: touch ];
    
    Tile *touchedTile = [ tileDataArray objectAtIndex: touchedTileIndex ];
    touchedTile->isSelected = YES;
    
    
    //currentColor=ccc4(0,0,0,0); //Transparent >> Draw holes (dig)
	//CGPoint touchLocation = [touch locationInView:nil];
	//touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
	//activeLocation=touchLocation;
    //touchActiveLocationOK=YES;
}


/*
 ====================
 ccTouchesMoved: touches withEvent: event
 ====================
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches moved" );
    //[ self addMessage: @"ccTouchesMoved\n" ];
	UITouch *touch = [ touches anyObject ];
	NSArray *allTouches = [[event allTouches] allObjects];
    
	double now=[NSDate timeIntervalSinceReferenceDate];
	
    isTouched = YES;
    NSInteger prevTouchedTileIndex = touchedTileIndex;
    Tile *prevTouchedTile = [ tileDataArray objectAtIndex: prevTouchedTileIndex ];
    prevTouchedTile->isSelected = NO;
    
    touchedTileIndex = [ self getTileIndexForTouch: touch ];
    
    Tile *touchedTile = [ tileDataArray objectAtIndex: touchedTileIndex ];
    touchedTile->isSelected = YES;
    
    //prevSelectedTile = selectedTile;
    //selectedTile = touchedTileIndex;
    
    /*
    if (now-lastDigTime>0.05f) {
		touch=[touches anyObject];
        
		CGPoint touchLocation = [touch locationInView:nil];
		touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        
        if (touchActiveLocationOK) {
            [self fingerAction:activeLocation :touchLocation];
            lastDigTime=now;
		}
		activeLocation=touchLocation;
        touchActiveLocationOK=YES;
	}
     */
}


/*
 ====================
 ccTouchesEnded: touches withEvent: event
 ====================
 */
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches ended" );
    UITouch *touch = [ touches anyObject ];
        
    isTouched = NO;
    //NSInteger prevTouchedTileIndex = touchedTileIndex;
    //Tile *prevTouchedTile = [ tileDataArray objectAtIndex: prevTouchedTileIndex ];
    //prevTouchedTile->isSelected = NO;
    
    double now = [ NSDate timeIntervalSinceReferenceDate ];
    double timeElapsedSinceTouchBegan = now - touchBeganTime;
    
    
    if ( timeElapsedSinceTouchBegan >= 3.0f ) {
 
        /*
        if ( editorHUDIsVisible ) {
            [ self removeEditorHUD: editorHUD ];
        } else {
            [ self addEditorHUD: editorHUD ];
        }
         */
        
    } else {
    
        [ self shortPress: touch ];
        Tile *touchedTile = [ tileDataArray objectAtIndex: touchedTileIndex ];
        
        BOOL containsHero = NO;
        for ( Entity *e in touchedTile->contents ) {
            if ( [e->name isEqualToString: @"Hero" ] ) {
                containsHero = YES;
                break;
            }
        }
        
        if ( touchedTile->isSelected ) {
            
            if ( containsHero ) {
                
                [self addMessage: @"Touched Hero" ];
                
                if ( playerMenuIsVisible ) {
                    
                    //[ self removeEditorHUD: editorHUD ];
                    [ self removePlayerMenu: playerMenu ];
                    
                } else {
                    
                    //[ self addEditorHUD: editorHUD ];
                    [ self addPlayerMenu: playerMenu ];
                    
                }
                
            } else {
                touchedTile->isSelected = NO;
                touchedTileIndex = -1;
                NSString *tileTypeStr =
                ( touchedTile->tileType == TILE_FLOOR_GRASS ) ? @"Grass" :
                ( touchedTile->tileType == TILE_FLOOR_ICE ) ? @"Ice" :
                ( touchedTile->tileType == TILE_FLOOR_STONE ) ? @"Stone" :
                @"Void";
                [ self addMessage: [NSString stringWithFormat:@"Tile type: %@", tileTypeStr] ];
            }
        } else {
            touchedTile->isSelected = YES;
        }
    }
    
}


/*
 ====================
 shortPress: touch
 ====================
 */
-( void ) shortPress: (UITouch *) touch {
    //[ self addMessage:  @"shortPress\n" ];
}


/*
 ====================
 longPress
 ====================
 */
-( void ) longPress {
    //UIAlertView *alert = [[ UIAlertView alloc ] initWithTitle:@"" message:[NSString stringWithFormat:@"Long press"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    //[ self addMessage:  @"longPress\n" ];
    
    /*
    if ( editorHUDIsVisible ) {
        [ self removeEditorHUD: editorHUD ];
    } else {
        [ self addEditorHUD: editorHUD ];
    }
     */
}


/*
 ====================
 ccTouchesCancelled: touches withEvent: event
 ====================
 */
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches cancelled" );
    //[ messages addObject: @"ccTouchesCancelled\n" ];
	[self ccTouchesEnded:touches withEvent:event];
}

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
    tileSprite.scale = GROUND_SCALE;
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
    tileSprite.scale = GROUND_SCALE;
    
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
 addBlankTiles
 ====================
 */
-( void ) addBlankTiles {
    tileArray = [ NSMutableArray arrayWithCapacity: NUMBER_OF_TILES_ONSCREEN ];
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
    [ self addBlankTiles ];
}


/*
 ====================
 initializeTileData
 ====================
 */
-( void ) initializeTileData {
    tileDataArray = [ [ NSMutableArray alloc ] initWithCapacity: NUMBER_OF_TILES_ONSCREEN ];
    for ( int i = 0; i < NUMBER_OF_TILES_ONSCREEN; i++ ) {
        Tile *tile = [ [ Tile alloc ] init ];
        tile->tileType = TILE_DEFAULT;
        tile->tileSprite = [ tileArray objectAtIndex: i ];
        [ tileDataArray addObject: tile ];
    }
    [ GameRenderer setAllTiles: tileArray toTileType: TILE_DEFAULT ];
    //[ GameRenderer setTileArrayBoundary: tileDataArray toTileType: TILE_FLOOR_STONE withLevel: 2 ];
    //[ GameRenderer setTileArrayBoundary: tileDataArray toTileType: TILE_VOID withLevel: 1 ];
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
 getTileIndexForTouch
 ====================
 */
-( NSInteger ) getTileIndexForTouch: ( UITouch * ) touch {
    CGPoint touchLocation = [ touch locationInView: nil ];
    touchLocation = [ [ CCDirector sharedDirector ] convertToGL: touchLocation ];
    
    NSUInteger x = ( NSUInteger ) touchLocation.x;
    NSUInteger y = ( NSUInteger ) touchLocation.y;
    
    // magic numbers below are for 16x16 tiles w/ 150 tiles on-screen
    NSUInteger tx =
    ( x < 32 ) ? 0 :
    ( x < 64 ) ? 1 :
    ( x < 96 ) ? 2 :
    ( x < 128 ) ? 3 :
    ( x < 150 ) ? 4 :
    ( x < 192 ) ? 5 :
    ( x < 224 ) ? 6 :
    ( x < 256 ) ? 7 :
    ( x < 288 ) ? 8 :
    ( x < 320 ) ? 9 :
    ( x < 352 ) ? 10 : -1 ;
    
    NSUInteger ty =
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
    
    // calculate tile position based on (x,y)
    NSInteger index = tx + ty * 10;
    return index;
}


/*
 ====================
 addMessage: message
 ====================
 */
#define MAX_DISPLAYED_MESSAGES      5
-( void ) addMessage: (NSString * ) message {
    NSString *str = [ NSString stringWithFormat: @"%@\n", message ];
    [ dLog addObject: str ];
    if ( [ dLog count ] > MAX_DISPLAYED_MESSAGES ) {
        dLogIndex++;
    }
}

@end