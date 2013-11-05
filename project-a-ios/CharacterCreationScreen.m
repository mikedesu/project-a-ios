/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
//  CharacterCreationScreen.m
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "CharacterCreationScreen.h"

#import "GameConfig.h"

#import "AppDelegate.h"

@implementation CharacterCreationScreen

-(id) init {
    if ((self=[super initWithColor:black])) {
 
        
        CCLabelTTF *ccTitleLabel0 = [CCLabelTTF labelWithString:@"Character Creation" fontName:@"Courier New" fontSize:24];
        
        stat0 = [CCLabelTTF labelWithString:@"Strength: " fontName:@"Courier New" fontSize:18];
        stat1 = [CCLabelTTF labelWithString:@"Dexterity: " fontName:@"Courier New" fontSize:18];
        stat2 = [CCLabelTTF labelWithString:@"Constitution: " fontName:@"Courier New" fontSize:18];
        stat3 = [CCLabelTTF labelWithString:@"Intelligence: " fontName:@"Courier New" fontSize:18];
        stat4 = [CCLabelTTF labelWithString:@"Wisdom: " fontName:@"Courier New" fontSize:18];
        stat5 = [CCLabelTTF labelWithString:@"Charisma: " fontName:@"Courier New" fontSize:18];
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:@"Is this character acceptable?" fontName:@"Courier New" fontSize:18];
        
        CCLabelTTF *reroll = [CCLabelTTF labelWithString:@"Reroll" fontName:@"Courier New" fontSize:18];
        CCLabelTTF *enter = [CCLabelTTF labelWithString:@"Enter Dungeon" fontName:@"Courier New" fontSize:18];
        
        CCMenuItemLabel *rerollButton = [[CCMenuItemLabel alloc] initWithLabel:reroll block:^(id sender) {
            MLOG(@"Reroll");
            
            [self rollStats];
        }];
        
        CCMenuItemLabel *enterButton = [[CCMenuItemLabel alloc] initWithLabel:enter block:^(id sender) {
            MLOG(@"Entering...");
            
            // stash stats in AppController (formerly AppDelegate)
            //AppController *controller = [[AppController alloc] init];
            AppController *controller = [MasterLayer sharedController];
            
            controller.strength     = strength;
            controller.dexterity    = dexterity;
            controller.constitution = constitution;
            controller.intelligence = intelligence;
            controller.wisdom       = wisdom;
            controller.charisma     = charisma;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UnloadCC" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadGame" object:nil];
            
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
        
        
        CCMutableTexture2D *texture0 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        CCMutableTexture2D *heroTexture = [Drawer guy:skincolor0 body:skincolor0 pants:gray blindfolded:NO];
        
        for (int i=0; i<16; i++) {
            for (int j=0; j<16; j++) {
                [texture0 setPixelAt:ccp(i,j) rgba:[heroTexture pixelAt:ccp(i,j)]];
            }
        }
        
        
        [texture0 apply];
        
        CCSprite *sprite0 = [CCSprite spriteWithTexture:texture0];
        [sprite0 setScale:8];
        sprite0.position = ccp( screenwidth/2 + 100, screenheight/2 + 75 );
 
        [self addChild:sprite0];
        
        MLOG(@"%@", sprite0);
        
        
        // stats
        
        strength        = -1;
        dexterity       = -1;
        constitution    = -1;
        intelligence    = -1;
        wisdom          = -1;
        charisma        = -1;
        
        [self rollStats];
        
    }
    return self;
}


-(void) rollStats {

    strength        = [Dice roll:6 nTimes:3];
    dexterity       = [Dice roll:6 nTimes:3];
    constitution    = [Dice roll:6 nTimes:3];
    intelligence    = [Dice roll:6 nTimes:3];
    wisdom          = [Dice roll:6 nTimes:3];
    charisma        = [Dice roll:6 nTimes:3];
    
    stat0.string    = [NSString stringWithFormat:@"Strength: %d", strength];
    stat1.string    = [NSString stringWithFormat:@"Dexterity: %d", dexterity];
    stat2.string    = [NSString stringWithFormat:@"Constitution: %d", constitution];
    stat3.string    = [NSString stringWithFormat:@"Intelligence: %d", intelligence];
    stat4.string    = [NSString stringWithFormat:@"Wisdom: %d", wisdom];
    stat5.string    = [NSString stringWithFormat:@"Charisma: %d", charisma];
    
}


@end
