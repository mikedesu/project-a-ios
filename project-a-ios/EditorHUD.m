//  EditorHUD.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "EditorHUD.h"

@implementation EditorHUD

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor:color width:w height:h ] ) ) {
        CGSize size = [[ CCDirector sharedDirector ] winSize];
        
        label = [[ CCLabelTTF alloc ] initWithString:@"####" dimensions:CGSizeMake(w, h) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:14];
        label.position = ccp( 0 + w/2, h - (label.contentSize.height/2) );
        label.color = ccc3( 255,255,255 );
        [self addChild: label];
        
    }
    return self;
}

@end
