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
                               @"For now, you will auto-equip the      ",
                               @"most powerful gear that you find.     ",
                               @"This is an alpha and so this is       ",
                               @"all subject to change!                ",
                               @"                                      ",
                               @"                                      ",
                               @"                                      ",
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
