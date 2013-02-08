//  GameLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.

// Import the interfaces
#import "GameLayer.h"

#import "AppDelegate.h"

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
		
	}
	return self;
}

- (void) dealloc {
	//[super dealloc];
}

@end
