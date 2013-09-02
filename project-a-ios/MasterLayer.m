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
        
        titleScreen             = nil;
        characterCreationScreen = nil;
        gameLayer               = nil;
        
        strength        = 3;
        dexterity       = 3;
        constitution    = 3;
        intelligence    = 3;
        wisdom          = 3;
        charisma        = 3;
        
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
        
        [self rollStats];
        
        AppController *controller = [MasterLayer sharedController];
        controller.strength     = strength;
        controller.dexterity    = dexterity;
        controller.constitution = constitution;
        controller.intelligence = intelligence;
        controller.wisdom       = wisdom;
        controller.charisma     = charisma;
        
        if ( gameLayer == nil ) {
            gameLayer = [[GameLayer alloc] init];
        }
        [self addChild:gameLayer];
        
    } else if ([notification.name isEqualToString:@"UnloadGame"]) {
        
        // unregister lower-level notifications
        [gameLayer.equipMenu unregisterNotifications];
        [gameLayer removeNotifications];
        
        [gameLayer cleanupGame];
        
        
        [self removeChild:gameLayer cleanup:YES];
        gameLayer = nil;
        
        [self rollStats];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadTitle" object:nil];
    }
}


-(void) rollStats {
    
    int tolerance = 10;
    
    while ( strength < tolerance ) strength = [Dice roll:6 nTimes:3];
    while ( dexterity < tolerance ) dexterity = [Dice roll:6 nTimes:3];
    while ( constitution < tolerance ) constitution = [Dice roll:6 nTimes:3];
    while ( intelligence < tolerance ) intelligence = [Dice roll:6 nTimes:3];
    while ( wisdom < tolerance ) wisdom = [Dice roll:6 nTimes:3];
    while ( charisma < tolerance ) charisma = [Dice roll:6 nTimes:3];
    
    /*
    strength        = [Dice roll:6 nTimes:3];
    dexterity       = [Dice roll:6 nTimes:3];
    constitution    = [Dice roll:6 nTimes:3];
    intelligence    = [Dice roll:6 nTimes:3];
    wisdom          = [Dice roll:6 nTimes:3];
    charisma        = [Dice roll:6 nTimes:3];
    */
    
}



static BOOL sharedControllerIsInitialized = NO;
static AppController *_sharedController;

+(AppController *) sharedController {
    if ( ! sharedControllerIsInitialized ) {
        _sharedController = [[AppController alloc] init];
        sharedControllerIsInitialized = YES;
    }
    return _sharedController;
}

@end
