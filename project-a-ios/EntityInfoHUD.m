//
//  EntityInfoHUD.m
//  project-a-ios
//
//  Created by Mike Bell on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EntityInfoHUD.h"
#import "GameConfig.h"

@implementation EntityInfoHUD

@synthesize label;

/*
 ====================
 initWithColor: color width: w height: h
 ====================
 */
-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor:color width:w height:h ] ) ) {
        //CGSize size = [[ CCDirector sharedDirector ] winSize];
        
        label = [[ CCLabelTTF alloc ] initWithString:@"####" dimensions:CGSizeMake(w, h) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:14];
        label.position = ccp( 0 + w/2, h - (label.contentSize.height/2) );
        //label.color = black3;
        label.color = white3;
        [self addChild: label];
        
    }
    return self;
}
@end