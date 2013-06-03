//  MasterLayer.m
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "MasterLayer.h"

#import "TitleScreen.h"
#import "CharacterCreationScreen.h"
#import "GameConfig.h"

@implementation MasterLayer

@synthesize titleScreen;
@synthesize characterCreationScreen;
@synthesize gameLayer;

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
        
        //CharacterCreationScreen *characterCreationScreen = [[CharacterCreationScreen alloc] init];
        //[self addChild:characterCreationScreen];
        
        titleScreen = nil;
        characterCreationScreen = nil;
        gameLayer = nil;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"LoadTitle" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"UnloadTitle" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"LoadCC" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"UnloadCC" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"LoadGame" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"UnloadGame" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadTitle" object:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"LoadCC" object:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"LoadGame" object:nil];
    }
    return self;
}



/*
 How to use the MasterLayer notifications:
 
 1. Do not follow up a load with another load. ALWAYS UNLOAD THE CURRENT SCREEN FIRST
 
    BAD!    LoadTitle   LoadCC
    Good!   LoadTitle   UnloadTitle LoadCC
 */
-(void) handleNotification: (NSNotification *) notification {
    MLOG(@"%@", notification.name);
    
    if ([notification.name isEqualToString:@"LoadTitle"]) {
 
        if ( titleScreen == nil ) {
            titleScreen = [[TitleScreen alloc] init];
        }
        [self addChild:titleScreen];

    } else if ([notification.name isEqualToString:@"UnloadTitle"]) {
        
        [self removeChild:titleScreen cleanup:YES];
        titleScreen = nil;
        
    } else if ([notification.name isEqualToString:@"LoadCC"]) {
        
        if ( characterCreationScreen == nil ) {
            characterCreationScreen = [[CharacterCreationScreen alloc] init];
        }
        [self addChild:characterCreationScreen];
        
    } else if ([notification.name isEqualToString:@"UnloadCC"]) {
        
        [self removeChild:characterCreationScreen cleanup:YES];
        characterCreationScreen = nil;
        
    } else if ([notification.name isEqualToString:@"LoadGame"]) {
        
        if ( gameLayer == nil ) {
            gameLayer = [[GameLayer alloc] init];
        }
        [self addChild:gameLayer];
        
    } else if ([notification.name isEqualToString:@"UnloadGame"]) {
        
        [self removeChild:gameLayer cleanup:YES];
        gameLayer = nil;
    }
}

@end
