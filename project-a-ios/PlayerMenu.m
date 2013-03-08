//  PlayerMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "PlayerMenu.h"

@implementation PlayerMenu

@synthesize label;


/*
 ====================
 initWithColor: color width: w height: h
 
 initializes a new PlayerMenu with a set color, width, and height
 ====================
 */
-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        label = [[ CCLabelTTF alloc ] initWithString:@"PlayerMenu" dimensions:CGSizeMake(w, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:12];
        label.position = ccp( 0 + w/2 + 10, h - (label.contentSize.height/2) );
        label.color = white3;
        [self addChild: label];
        
        CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"X" fontName:@"Courier New" fontSize:16 ];
        menuItemLabelClose.color = white3;
        
        CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose target:self selector:@selector(menuItemClosePressed) ];
        menuItemClose.position = ccp( 0 + menuItemLabelClose.contentSize.width/2, label.position.y );
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemClose,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
        
        
    }
    return self;
}


#define MENUITEMCLOSE_NOTIFICATIONNAME @"PlayerMenuCloseNotification"
-( void ) menuItemClosePressed {
   // MLOG( @"menuItemClosePressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEMCLOSE_NOTIFICATIONNAME  object:self];
}

@end