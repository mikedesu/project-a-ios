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
        /*
        label = [[ CCLabelTTF alloc ] initWithString:@"PlayerMenu" dimensions:CGSizeMake(w, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:12];
        label.position = ccp( 0 + w/2 + 10, h - (label.contentSize.height/2) );
        label.color = white3;
        [self addChild: label];
        */
        
        CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"X" fontName:@"Courier New" fontSize:30 ];
        menuItemLabelClose.color = white3;
        
        CCLabelTTF *menuItemLabelMove = [[CCLabelTTF alloc] initWithString: @"M" fontName:@"Courier New" fontSize:30 ];
        menuItemLabelClose.color = white3;
        
        CCLabelTTF *menuItemLabelAttack = [[CCLabelTTF alloc] initWithString: @"A" fontName:@"Courier New" fontSize:30 ];
        menuItemLabelClose.color = white3;
        
        
        
        
        
        CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose target:self selector:@selector(menuItemClosePressed) ];
        menuItemClose.position = ccp( 0 + menuItemLabelClose.contentSize.width/2, h - (menuItemLabelClose.contentSize.height/2) );
        
        CCMenuItem *menuItemMove = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMove target:self selector:@selector(menuItemMovePressed) ];
        menuItemMove.position = ccp( 0 + menuItemLabelMove.contentSize.width/2, h - menuItemLabelClose.contentSize.height - (menuItemLabelMove.contentSize.height/2) );
        
        CCMenuItem *menuItemAttack = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelAttack target:self selector:@selector(menuItemAttackPressed) ];
        menuItemAttack.position = ccp( 0 + menuItemLabelAttack.contentSize.width/2, h - menuItemLabelClose.contentSize.height - menuItemLabelMove.contentSize.height - (menuItemLabelAttack.contentSize.height/2) );
        
        
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemClose,
                                                         menuItemMove,
                                                         menuItemAttack,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
        
        
    }
    return self;
}


#define MENUITEMCLOSE_NOTIFICATIONNAME @"PlayerMenuCloseNotification"
-( void ) menuItemClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEMCLOSE_NOTIFICATIONNAME  object:self];
}

-( void ) menuItemMovePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuMoveNotification"  object:self];
}

-( void ) menuItemAttackPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuAttackNotification"  object:self];
}



@end