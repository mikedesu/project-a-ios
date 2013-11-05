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
//  HelpMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "HelpMenu.h"
#import "GameConfig.h"


@implementation HelpMenu

@synthesize label;

-(id) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( (self=[super initWithColor:color width:w height:h] ) ) {
        NSString *str       = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
                               
                               // each line: max of 33 chars
                               @"Welcome to the Help Menu! ^_^         ",
                               @"--------------------------------------",
                               @"Abbreviations used:                   ",
                               @"T: Current Turn                       ",
                               @"St: Strength      Dx: Dexterity       ",
                               @"Co: Constitution  In: Intelligence    ",
                               @"Wi: Wisdom        Ch: Charisma        ",
                               @"                                      ",
                               @"Dlvl: Current Dungeon Floor Level     ",
                               @"$: Current money  HP: Hitpoints       ",
                               @"AC: Armor Class   Lv: Level           ",
                               @"XP: Experience points                 ",
                               @"--------------------------------------",
                               @"Quick Controls:                       ",
                               @"To move, double-tap a nearby tile     ",
                               @"To attack, move into an enemy         ",
                               @"To pick up an item, move over it      ",
                               @"   and press the 'pickup' button      ",
                               @"To use an item, open the inventory    ",
                               @"   and select the item you wish to use",
                               @"To equip something, press equip, then ",
                               @"   select the bodypart, then the gear ",
                               @"This game is still in alpha and is    ",
                               @"   still subject to change!! Thank You",
                               @"--------------------------------------"
                               ];
        
        // help menu
        CGSize s            = [[CCDirector sharedDirector] winSize];
        label               = [[CCLabelTTF alloc] initWithString:@"" dimensions:CGSizeMake(s.width,s.height) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New"fontSize:14];
        label.color         = white3;
        
        [label setString: str];
        CGFloat x = s.width - label.contentSize.width/2,
                y = s.height - label.contentSize.height/2;
        label.position      = ccp( x, y );
        [self addChild:label];
        
        
        CCMenuItemLabel *back = [[CCMenuItemLabel alloc] initWithLabel:[CCLabelTTF labelWithString:@"Back" fontName:@"Courier New" fontSize:16] block:^(id sender) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HelpMenuBackNotification" object:nil];
        }];
        
        NSArray *menuArray = [NSArray arrayWithObjects:back, nil];
        CCMenu *menu = [[CCMenu alloc] initWithArray: menuArray];
        menu.position = ccp( back.contentSize.width, back.contentSize.height );
        [self addChild:menu];
        
    }
    return self;
}

@end
