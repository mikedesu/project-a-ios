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
//  EditorHUD.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EditorHUD.h"

@implementation EditorHUD

@synthesize label;

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor:color width:w height:h ] ) ) {
        //CGSize size = [[ CCDirector sharedDirector ] winSize];
#define EDITORHUD_LABEL_FONTSIZE    12
#define EDITORHUD_LABEL_FONTNAME    @"Courier New"
        label = [[CCLabelTTF alloc ] initWithString:@"####" dimensions:CGSizeMake(w, h) hAlignment:kCCTextAlignmentLeft fontName:EDITORHUD_LABEL_FONTNAME fontSize: EDITORHUD_LABEL_FONTSIZE ];
        label.position = ccp( 0 + w/2, h - (label.contentSize.height/2) );
        //label.color = black3;
        label.color = white3;
        [self addChild: label];
    }
    return self;
}

@end