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
//  LevelUpWindow.m
//  project-a-ios
//
//  Created by Mike Bell on 6/6/13.

#import "LevelUpWindow.h"
#import "GameConfig.h"

@implementation LevelUpWindow

@synthesize message, label0, label1, label2, label3, label4, label5;
@synthesize menuLabel0, menuLabel1, menuLabel2, menuLabel3, menuLabel4, menuLabel5;
@synthesize menu;

#define LEVELUPWINDOW_WIDTH  300
#define LEVELUPWINDOW_HEIGHT 250

-(id) init {
    if ((self=[super initWithColor:black width:LEVELUPWINDOW_WIDTH height:LEVELUPWINDOW_HEIGHT])) {
        message = [CCLabelTTF labelWithString:@"Level Up! Increase which stat?" fontName:@"Courier" fontSize:16];
        message.position = ccp( message.contentSize.width / 2 , LEVELUPWINDOW_HEIGHT - message.contentSize.height/2);
        [self addChild:message];
        
        label0 = [CCLabelTTF labelWithString:@"Strength: " fontName:@"Courier New" fontSize:18];
        label1 = [CCLabelTTF labelWithString:@"Dexterity: " fontName:@"Courier New" fontSize:18];
        label2 = [CCLabelTTF labelWithString:@"Constitution: " fontName:@"Courier New" fontSize:18];
        label3 = [CCLabelTTF labelWithString:@"Intelligence: " fontName:@"Courier New" fontSize:18];
        label4 = [CCLabelTTF labelWithString:@"Wisdom: " fontName:@"Courier New" fontSize:18];
        label5 = [CCLabelTTF labelWithString:@"Charisma: " fontName:@"Courier New" fontSize:18];
        
        CGFloat x, y, pad;
        pad = 5;
        x = message.position.x;
        y = message.position.y - message.contentSize.height/2 - 2*pad;
        y -= pad*2;
        
        menuLabel0 = [[CCMenuItemLabel alloc] initWithLabel:label0 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpStrengthNotification" object:nil];
        }];
        //x = menuLabel0.contentSize.width/2;
        menuLabel0.position = ccp(x, y);
        y -= menuLabel0.contentSize.height ;
        y -= pad*2;
        
        menuLabel1 = [[CCMenuItemLabel alloc] initWithLabel:label1 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpDexterityNotification" object:nil];
        }];
        //x = menuLabel1.contentSize.width/2;
        menuLabel1.position = ccp(x, y);
        y -= menuLabel1.contentSize.height ;
        y -= pad*2;
        
        menuLabel2 = [[CCMenuItemLabel alloc] initWithLabel:label2 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpConstitutionNotification" object:nil];
        }];
        //x = menuLabel2.contentSize.width/2;
        menuLabel2.position = ccp(x, y);
        y -= menuLabel2.contentSize.height ;
        y -= pad*2;
        
        menuLabel3 = [[CCMenuItemLabel alloc] initWithLabel:label3 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpIntelligenceNotification" object:nil];
        }];
        //x = menuLabel3.contentSize.width/2;
        menuLabel3.position = ccp(x, y);
        y -= menuLabel3.contentSize.height ;
        y -= pad*2;
        
        menuLabel4 = [[CCMenuItemLabel alloc] initWithLabel:label4 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpWisdomNotification" object:nil];
        }];
        //x = menuLabel4.contentSize.width/2;
        menuLabel4.position = ccp(x, y);
        y -= menuLabel4.contentSize.height ;
        y -= pad*2;
        
        menuLabel5 = [[CCMenuItemLabel alloc] initWithLabel:label5 block:^(id sender) {
            MLOG(@"%@", sender);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerStatUpCharismaNotification" object:nil];
        }];
        //x = menuLabel5.contentSize.width/2;
        menuLabel5.position = ccp(x, y);
        y -= menuLabel5.contentSize.height ;
        y -= pad*2;
        
        
        menu = [CCMenu menuWithItems:
                menuLabel0,
                menuLabel1,
                menuLabel2,
                menuLabel3,
                menuLabel4,
                menuLabel5,
                nil];
        
        menu.position = CGPointZero;
        
        [self addChild:menu];
        
    }
    return self;
}

@end
