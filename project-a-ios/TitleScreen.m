//  TitleScreen.m
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "TitleScreen.h"
#import "GameConfig.h"

@implementation TitleScreen

-(id) init {
    if ((self=[super initWithColor:black])) {
        CCLabelTTF *titleLabel0 = [CCLabelTTF labelWithString:@"Project A" fontName:@"Courier New" fontSize:32];
        CCLabelTTF *titleLabel1 = [CCLabelTTF labelWithString:@"An Evil Dojo Production" fontName:@"Courier New" fontSize:18];
        CCLabelTTF *titleLabel2 = [CCLabelTTF labelWithString:@"By Mike Bell" fontName:@"Courier New" fontSize:18];
        
        titleLabel0.color = white3;
        titleLabel1.color = white3;
        titleLabel2.color = white3;
        
        NSInteger heightPad = 50;
        
        CGPoint titleLabel0Pos = ccp(screenwidth/2,screenheight/2 + heightPad);
        CGPoint titleLabel1Pos = ccp(screenwidth/2,screenheight/2 - titleLabel0.contentSize.height + heightPad);
        CGPoint titleLabel2Pos = ccp(screenwidth/2,screenheight/2 - titleLabel0.contentSize.height - titleLabel1.contentSize.height + heightPad);
        
        titleLabel0.position = titleLabel0Pos;
        titleLabel1.position = titleLabel1Pos;
        titleLabel2.position = titleLabel2Pos;
        
        [self addChild:titleLabel0];
        [self addChild:titleLabel1];
        [self addChild:titleLabel2];
        
        
        CCLabelTTF *startButtonLabel = [CCLabelTTF labelWithString:@"Start New Game" fontName:@"Courier New" fontSize:24];
        //startButtonLabel.position = ccp(screenwidth/2, screenheight/2 - 100);
        
        CCMenuItemLabel *startButton = [[CCMenuItemLabel alloc] initWithLabel:startButtonLabel block:^(id sender) {
            MLOG(@"Testing...");
        }];
        //startButton.position = startButtonLabel.position;
        
        CCMenu *menu = [CCMenu menuWithItems:startButton, nil];
        menu.position = ccp(screenwidth/2, screenheight/2 - 100);
        
        [self addChild:menu];
    }
    return self;
}

@end
