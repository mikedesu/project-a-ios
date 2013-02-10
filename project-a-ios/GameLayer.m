//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "AppDelegate.h"
#import "CCMutableTexture2D.h"
#import "Colors.h"
#import "GameConfig.h"
#import "GameLayer.h"
#import "GameRenderer.h"
#import "MLog.h"
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
        
        [ self initializeTiles ];
        [ self initializeTileData ];
        
        [ self schedule:@selector(tick:)];
	}
	return self;
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
    MLOG( @"tick" );
    
    //[ self colorScrambleAllTiles ];
    //[ GameRenderer colorScrambleAllTiles: tileArray ];
    [GameRenderer setAllTiles:tileArray withData: tileDataArray ];
    
    
    // [ self renderGameState ];
}


/*
 ====================
 ccTouchesBegan: touches withEvent: event
 ====================
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches began" );
	UITouch *touch=[touches anyObject];
    double now=[NSDate timeIntervalSinceReferenceDate];
    
    prevSelectedTile = selectedTile;
    selectedTile = [ self getTileIndexForTouch: touch ];
    
    //CCSprite *tmp = [ gfxTiles objectAtIndex: selectedTile ];
    //CCMutableTexture2D *tmptx = (CCMutableTexture2D *)[ tmp texture ];
    //[tmptx fill: random_color ];
    
    //[tmptx apply];
    //[ self colorScrambleTile: tmp ];
    
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
	UITouch *touch;
	NSArray *allTouches = [[event allTouches] allObjects];
    
	double now=[NSDate timeIntervalSinceReferenceDate];
	
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
}


/*
 ====================
 ccTouchesCancelled: touches withEvent: event
 ====================
 */
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //MLOG( @"touches cancelled" );
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
    @finally {
        
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



@end