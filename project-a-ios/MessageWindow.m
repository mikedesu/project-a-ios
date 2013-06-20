//  MessageWindow.m
//  project-a-ios
//
//  Created by Mike Bell on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "MessageWindow.h"

@implementation MessageWindow

@synthesize label;

#define MW_HEIGHT 120

-(id) init {
    if ((self=[super initWithColor:black_alpha(200) width:250 height: MW_HEIGHT ])) {
        label = [[CCLabelTTF alloc] initWithString:@"" dimensions:CGSizeMake(250, MW_HEIGHT ) hAlignment:kCCTextAlignmentCenter fontName:@"Courier" fontSize:14];;
        //label = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Courier" fontSize:14];
        label.position = ccp(250/2, MW_HEIGHT/2);
        //label.color = white3;
        [self addChild:label];
    }
    return self;
}


@end
