//  MasterLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "MasterLayer.h"

#import "TitleScreen.h"
#import "CharacterCreationScreen.h"

@implementation MasterLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	MasterLayer *layer = [MasterLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init {
    if ((self=[super init])) {
        //TitleScreen *titleScreen = [[TitleScreen alloc] init];
        //[self addChild:titleScreen];
        
        CharacterCreationScreen *characterCreationScreen = [[CharacterCreationScreen alloc] init];
        [self addChild:characterCreationScreen];
    }
    return self;
}

@end
