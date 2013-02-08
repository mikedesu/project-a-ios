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

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}


-(id) init {
	if( (self=[super init]) ) {
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
        
        self.isTouchEnabled = YES;
        
        grounds = [ NSMutableArray arrayWithCapacity: 4];
        
        [ self appendNewGround ];
        [ self appendNewGround ];
        [ self appendNewGround ];
        [ self appendNewGround ];
        
        
        
        CCSprite *sprite=[grounds objectAtIndex:0];
        
        CGPoint local=ccp( 0, 0 );

        CGPoint activeLocal1=ccp( 0, 0 );
        CGPoint activeLocal2=ccp( 1, 0 );
        CGPoint activeLocal3=ccp( 2, 0 );
        CGPoint activeLocal4=ccp( 3, 0 );
        
        CGPoint activeLocal5=ccp( 4, 0 );
        CGPoint activeLocal6=ccp( 5, 0 );
        CGPoint activeLocal7=ccp( 6, 0 );
        CGPoint activeLocal8=ccp( 7, 0 );
        
        CGPoint activeLocal9=ccp( 8,  0);
        CGPoint activeLocal10=ccp( 9,  0);
        CGPoint activeLocal11=ccp( 10, 0 );
        CGPoint activeLocal12=ccp( 11, 0 );
        
        CGPoint activeLocal13=ccp( 12, 0 );
        CGPoint activeLocal14=ccp( 13, 0 );
        CGPoint activeLocal15=ccp( 14, 0 );
        CGPoint activeLocal16=ccp( 15, 0 );
        
         
        CCMutableTexture2D* groundMutableTexture=(CCMutableTexture2D*)(sprite.texture);
        
        //[groundMutableTexture drawLineFrom:activeLocal to:local withLineWidth:DRAW_WIDTH andColor:currentColor];
        ccColor4B color = ccc4( 0, 0, 0, 255 );
        
        [groundMutableTexture setPixelAt: activeLocal1 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal2 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal3 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal4 rgba: color ];
        
        [groundMutableTexture setPixelAt: activeLocal5 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal6 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal7 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal8 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal9 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal10 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal11 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal12 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal13 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal14 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal15 rgba: color ];
        [groundMutableTexture setPixelAt: activeLocal16 rgba: color ];
        
        
        [groundMutableTexture apply]; //Redraw texture

        
		
	}
	return self;
}

- (void) dealloc {
	//[super dealloc];
}

//////////////////////////////////////////////////////////////////////

-(void)tick:(ccTime)dt {
    MLOG( @"tick" );
}

//////////////////////////////////////////////////////////////////////



- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MLOG( @"touches began" );
	UITouch *touch=[touches anyObject];
    //currentColor=ccc4(0,0,0,0); //Transparent >> Draw holes (dig)
	//CGPoint touchLocation = [touch locationInView:nil];
	//touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
	//activeLocation=touchLocation;
    //touchActiveLocationOK=YES;
}


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


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    MLOG( @"touches ended" );
}


- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    MLOG( @"touches cancelled" );
	[self ccTouchesEnded:touches withEvent:event];
}

///////////////////////////////////////////////////////////////////////

-(void)appendNewGround {
    CGSize size = [[CCDirector sharedDirector] winSize];
    float y=size.height;
    
    UIImage *image = [UIImage imageNamed:@"ground_vertical.png"];
    CCMutableTexture2D *groundMutableTexture = [[CCMutableTexture2D alloc] initWithImage:image];
    [groundMutableTexture setAliasTexParameters];
    CCSprite *groundSprite = [CCSprite spriteWithTexture:groundMutableTexture];
    groundSprite.scale=GROUND_SCALE;
    if (grounds.count!=0) {
        y=((CCSprite*)([grounds lastObject])).position.y-groundSprite.contentSize.height*groundSprite.scaleY;
    } else {
        y-=groundSprite.contentSize.height*groundSprite.scaleY*0.5f;
    }
    groundSprite.position=ccp(size.width*0.5f,y);
    [self addChild:groundSprite];
    [grounds addObject:groundSprite];
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"grounds [ %d ]",grounds.count-1] fontName:@"Marker Felt" fontSize:13];
    label.rotation=90;
    label.position =  ccp( label.contentSize.height*0.5f +2, groundSprite.position.y);
    [self addChild: label];
}






@end
