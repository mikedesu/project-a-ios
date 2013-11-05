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
