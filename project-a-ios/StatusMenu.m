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