//  EditorHUD.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EditorHUD.h"

@implementation EditorHUD

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor:color width:w height:h ] ) ) {
        //CGSize size = [[ CCDirector sharedDirector ] winSize];
#define EDITORHUD_LABEL_FONTSIZE    12
#define EDITORHUD_LABEL_FONTNAME    @"Courier New"
        label = [[CCLabelTTF alloc ] initWithString:@"####" dimensions:CGSizeMake(w, h) hAlignment:kCCTextAlignmentLeft fontName:EDITORHUD_LABEL_FONTNAME fontSize: EDITORHUD_LABEL_FONTSIZE ];
        label.position = ccp( 0 + w/2, h - (label.contentSize.height/2) );
        label.color = white3;
        [self addChild: label];
    }
    return self;
}

@end