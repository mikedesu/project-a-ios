/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
//  StatusMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "StatusMenu.h"

@implementation StatusMenu

@synthesize content;
@synthesize contentStr;

-(id) init {
    CGSize s = [[CCDirector sharedDirector] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        
        contentStr = [NSString stringWithFormat: @"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
                                @"1",
                                @"2",
                                @"3",
                                @"4",
                                @"5",
                                @"6",
                                @"7",
                                @"8",
                                @"9",
                                @"10",
                                @"11",
                                @"12",
                                @"13",
                                @"14",
                                @"15",
                                @"16",
                                @"17",
                                @"18",
                                @"19",
                                @"20",
                                @"21",
                                @"22",
                                @"23",
                                @"24",
                                @"25",
                                nil
                                ];
        
        content = [[CCLabelTTF alloc] initWithString:contentStr dimensions:CGSizeMake(s.width-20, s.height-20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:14];
        content.position = ccp(0 + content.contentSize.width / 2, 0 + content.contentSize.height / 2);
        [self addChild:content];
        
        
        // return button
        CCMenuItemLabel *l0 = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Return" fontName:@"Courier New" fontSize:18] target:self selector:@selector(returnPressed)];
        l0.position = ccp(0 + l0.contentSize.width/2, 0 + l0.contentSize.height/2);
        
        NSArray *items = [NSArray arrayWithObjects:
                          l0,
                          nil];
        
        CCMenu *menu = [CCMenu menuWithArray:items];
        menu.position = ccp(0,0);
        [self addChild:menu];
        
    }
    return self;
}


-(void) returnPressed {
    MLOG(@"Return pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StatusMenuReturnNotification" object:self];
}


@end