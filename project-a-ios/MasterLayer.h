//  MasterLayer.h
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "cocos2d.h"

@class TitleScreen;
@class CharacterCreationScreen;
@class GameLayer;
@class AppController;

@interface MasterLayer : CCLayer {
    TitleScreen *titleScreen;
    CharacterCreationScreen *characterCreationScreen;
    GameLayer *gameLayer;
}

@property (nonatomic) TitleScreen *titleScreen;
@property (nonatomic) CharacterCreationScreen *characterCreationScreen;
@property (nonatomic) GameLayer *gameLayer;

+(AppController *) sharedController;

+(CCScene *) scene;
-(void) handleNotification: (NSNotification *) notification;

@end