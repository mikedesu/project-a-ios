//  StatusMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "StatusMenu.h"

@implementation StatusMenu

@synthesize content;

-(id) init {
    CGSize s = [[CCDirector sharedDirector] winSize];
    if ((self=[super initWithColor:black width:s.width height:s.height])) {
        
        NSString *contentStr = [NSString stringWithFormat: @"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
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