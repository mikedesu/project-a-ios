//  MessageWindow.m
//  project-a-ios
//
//  Created by Mike Bell on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "MessageWindow.h"

@implementation MessageWindow

@synthesize label;

-(id) init {
    if ((self=[super initWithColor:black width:250 height:150])) {
        label = [[CCLabelTTF alloc] initWithString:@"" dimensions:CGSizeMake(250, 150) hAlignment:kCCTextAlignmentCenter fontName:@"Courier" fontSize:14];;
        label.position = ccp(250/2,150/2);
        //label.color = white3;
        [self addChild:label];
    }
    return self;
}


@end
