//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

#import "AppDelegate.h"
#import "GameLayer.h"
#import "MLog.h"
#import "CCMutableTexture2D.h"

#define GROUND_SCALE 2
#define DRAW_WIDTH 6.5f
#define MINERS_COUNT 20
#define SHOW_DRAWN_GROUND_STRIPES

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
        [ self colorTest ];
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
    [ self colorScrambleAllTiles ];
}


/*
 ====================
 ccTouchesBegan: touches withEvent: event
 ====================
 */
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MLOG( @"touches began" );
	UITouch *touch=[touches anyObject];
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
    MLOG( @"touches moved" );
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
    MLOG( @"touches ended" );
}


/*
 ====================
 ccTouchesCancelled: touches withEvent: event
 ====================
 */
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    MLOG( @"touches cancelled" );
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
    
    CCMutableTexture2D *tileMutableTexture = [ [ CCMutableTexture2D alloc ] initWithSize: CGSizeMake( 16, 16 ) pixelFormat: kCCTexture2DPixelFormat_Default ];
    [ tileMutableTexture setAliasTexParameters ];
    
    srand( time( NULL ) );
    ccColor4B randomColor = ccc4( random() % 255, random() % 255, random() % 255, 255 );
    
    [ tileMutableTexture fill: randomColor ];
    [ tileMutableTexture apply ];
    
    CCSprite *tileSprite = [ CCSprite spriteWithTexture: tileMutableTexture ];
    tileSprite.scale = GROUND_SCALE;
    
    if ( gfxTiles.count != 0 ) {
        
        if ( gfxTiles.count % 10 == 0 ) {
            x = tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
            y = ( ( CCSprite * )( [ gfxTiles lastObject ] ) ).position.y - tileSprite.contentSize.height * tileSprite.scaleY;
        } else {
            x = ( ( CCSprite * )[ gfxTiles lastObject ] ).position.x + tileSprite.contentSize.width * tileSprite.scaleX;
            y = ( ( CCSprite * )( [ gfxTiles lastObject ] ) ).position.y;
        }
        
    } else {
        
        x += tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
        y -= tileSprite.contentSize.height * tileSprite.scaleY*0.5f;
        
    }
    
    tileSprite.position = ccp( x, y );
    [ self addChild: tileSprite ];
    [ gfxTiles addObject: tileSprite ];
    
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
    
    CCMutableTexture2D *tileMutableTexture = [ [ CCMutableTexture2D alloc ] initWithSize: CGSizeMake( 16, 16 ) pixelFormat: kCCTexture2DPixelFormat_Default ];
    [ tileMutableTexture setAliasTexParameters ];
    
    srand( time( NULL ) );
    
    
    for ( int i = 0; i < 16; i++ ) {
        for ( int j = 0; j < 16; j++ ) {
            ccColor4B randomColor = ccc4( random() % 255, random() % 255, random() % 255, 255 );
            [ tileMutableTexture setPixelAt: ccp( i, j ) rgba: randomColor ];
        }
    }
    
    [ tileMutableTexture apply ];
    
    CCSprite *tileSprite = [ CCSprite spriteWithTexture: tileMutableTexture ];
    tileSprite.scale = GROUND_SCALE;
    
    if ( gfxTiles.count != 0 ) {
        
        if ( gfxTiles.count % 10 == 0 ) {
            x = tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
            y = ( ( CCSprite * )( [ gfxTiles lastObject ] ) ).position.y - tileSprite.contentSize.height * tileSprite.scaleY;
        } else {
            x = ( ( CCSprite * )[ gfxTiles lastObject ] ).position.x + tileSprite.contentSize.width * tileSprite.scaleX;
            y = ( ( CCSprite * )( [ gfxTiles lastObject ] ) ).position.y;
        }
        
    } else {
        
        x += tileSprite.contentSize.width * tileSprite.scaleX * 0.5f;
        y -= tileSprite.contentSize.height * tileSprite.scaleY*0.5f;
        
    }
    
    tileSprite.position = ccp( x, y );
    [ self addChild: tileSprite ];
    [ gfxTiles addObject: tileSprite ];
    
}


/*
 ====================
 colorScrambleTile
 ====================
 */
-( void ) colorScrambleTile: ( CCSprite * ) tileSprite {
    CCMutableTexture2D *tileTex = ( CCMutableTexture2D * ) tileSprite.texture;
    srand( time( NULL ) );
    for ( int i = 0; i < 16; i++ ) {
        for ( int j = 0; j < 16; j++ ) {
            ccColor4B randomColor = ccc4( random() % 255, random() % 255, random() % 255, 255 );
            [ tileTex setPixelAt: ccp( i, j ) rgba: randomColor ];
        }
    }
    [ tileTex apply ];
}


/*
 ====================
 colorScrambleAllTiles
 ====================
 */
-( void ) colorScrambleAllTiles {
    for ( int i = 0; i < [ gfxTiles count ]; i++ ) {
        CCSprite *tileSprite = [ gfxTiles objectAtIndex: i ];
        [ self colorScrambleTile: tileSprite ];
    }
}


/*
 ====================
 colorTest
 ====================
 */
-( void ) colorTest {
    int tilemax = 150;
    //grounds = [ NSMutableArray arrayWithCapacity: tilemax ];
    gfxTiles = [ NSMutableArray arrayWithCapacity: tilemax ];
    
    for ( int i = 0 ; i < tilemax ; i++ ) {
        [ self appendNewColorTestTile ];
    }
}

@end