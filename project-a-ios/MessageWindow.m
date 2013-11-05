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
