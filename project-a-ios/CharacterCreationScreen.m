//  CharacterCreationScreen.m
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "CharacterCreationScreen.h"

#import "GameConfig.h"

@implementation CharacterCreationScreen

-(id) init {
    if ((self=[super initWithColor:black])) {
 
        CCLabelTTF *ccTitleLabel0 = [CCLabelTTF labelWithString:@"Character Creation" fontName:@"Courier New" fontSize:24];
        
        CCLabelTTF *stat0 = [CCLabelTTF labelWithString:@"Strength: " fontName:@"Courier New" fontSize:18];
        CCLabelTTF *stat1 = [CCLabelTTF labelWithString:@"Dexterity: " fontName:@"Courier New" fontSize:18];
        CCLabelTTF *stat2 = [CCLabelTTF labelWithString:@"Constitution: " fontName:@"Courier New" fontSize:18];
        CCLabelTTF *stat3 = [CCLabelTTF labelWithString:@"Intelligence: " fontName:@"Courier New" fontSize:18];
        CCLabelTTF *stat4 = [CCLabelTTF labelWithString:@"Wisdom: " fontName:@"Courier New" fontSize:18];
        CCLabelTTF *stat5 = [CCLabelTTF labelWithString:@"Charisma: " fontName:@"Courier New" fontSize:18];
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:@"Is this character acceptable?" fontName:@"Courier New" fontSize:18];
        
        CCLabelTTF *reroll = [CCLabelTTF labelWithString:@"Reroll" fontName:@"Courier New" fontSize:18];
        CCLabelTTF *enter = [CCLabelTTF labelWithString:@"Enter Dungeon" fontName:@"Courier New" fontSize:18];
        
        CCMenuItemLabel *rerollButton = [[CCMenuItemLabel alloc] initWithLabel:reroll block:^(id sender) {
            MLOG(@"Reroll");
        }];
        
        CCMenuItemLabel *enterButton = [[CCMenuItemLabel alloc] initWithLabel:enter block:^(id sender) {
            MLOG(@"Entering...");
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:rerollButton, enterButton, nil];
        
        NSInteger pad = 10;
        ccTitleLabel0.position  = ccp( screenwidth/2, screenheight - ccTitleLabel0.contentSize.height - pad);
        stat0.position          = ccp( screenwidth/4, screenheight - (10*pad) );
        stat1.position          = ccp( screenwidth/4, screenheight - (11*pad) - stat0.contentSize.height);
        stat2.position          = ccp( screenwidth/4, screenheight - (12*pad) - stat0.contentSize.height*2);
        stat3.position          = ccp( screenwidth/4, screenheight - (13*pad) - stat0.contentSize.height*3);
        stat4.position          = ccp( screenwidth/4, screenheight - (14*pad) - stat0.contentSize.height*4);
        stat5.position          = ccp( screenwidth/4, screenheight - (15*pad) - stat0.contentSize.height*5);
        message.position        = ccp( screenwidth/2, screenheight/4);
        
        menu.position           = ccp( screenwidth/2, 75 );
        rerollButton.position   = ccp( -100, 0 );
        enterButton.position    = ccp( 50, 0 );
        
        
        [self addChild:ccTitleLabel0];
        [self addChild:stat0];
        [self addChild:stat1];
        [self addChild:stat2];
        [self addChild:stat3];
        [self addChild:stat4];
        [self addChild:stat5];
        [self addChild:message];
        [self addChild:menu];
        
        
        
        
    
        
    }
    return self;
}
@end
