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
        
        CCLabelTTF *menuItemLabelMinimize       = [[CCLabelTTF alloc] initWithString:   @"Minimize"     fontName:@"Courier New" fontSize:16 ];
        menuItemLabelMinimize.color             = white3;
        
        CCLabelTTF *menuItemLabelStatus         = [[CCLabelTTF alloc] initWithString:   @"Status"       fontName:@"Courier New" fontSize:16 ];
        menuItemLabelStatus.color               = white3;
        
        CCLabelTTF *menuItemLabelInventory      = [[CCLabelTTF alloc] initWithString:   @"Inventory"    fontName:@"Courier New" fontSize:16 ];
        menuItemLabelInventory.color            = white3;
        
        CCLabelTTF *menuItemLabelStep           = [[CCLabelTTF alloc] initWithString:   @"Step"         fontName:@"Courier New" fontSize:16 ];
        menuItemLabelInventory.color            = white3;
        
        CCLabelTTF *menuItemLabelAutostep       = [[CCLabelTTF alloc] initWithString:   @"Autostep"     fontName:@"Courier New" fontSize:16 ];
        menuItemLabelInventory.color            = white3;
        
        CCLabelTTF *menuItemLabelReset          = [[CCLabelTTF alloc] initWithString:   @"Reset"     fontName:@"Courier New" fontSize:16 ];
        menuItemLabelInventory.color            = white3;
        
        
        
        CCMenuItem *menuItemMinimize    = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMinimize target:self selector:@selector(menuItemClosePressed) ];
        menuItemMinimize.position       = ccp( 0 + menuItemMinimize.contentSize.width/2, h - 32 - 5 );
        
        CCMenuItem *menuItemStatus      = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStatus target:self selector:@selector(menuItemStatusPressed) ];
        menuItemStatus.position         = ccp( 0 + menuItemStatus.contentSize.width/2, h - 32*2 - 5*2);
        
        CCMenuItem *menuItemInventory   = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelInventory target:self selector:@selector(menuItemInventoryPressed) ];
        menuItemInventory.position      = ccp( 0 + menuItemInventory.contentSize.width/2, h - 32*3 - 5*3 );
        
        CCMenuItem *menuItemStep        = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStep target:self selector:@selector(menuItemStepPressed) ];
        menuItemStep.position           = ccp( 0 + menuItemStep.contentSize.width/2, h - 32*4 - 5*4 );
        
        CCMenuItem *menuItemAutostep    = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelAutostep target:self selector:@selector(menuItemAutostepPressed) ];
        menuItemAutostep.position       = ccp( 0 + menuItemAutostep.contentSize.width/2, h -32*5 - 5*5 );
        
        CCMenuItem *menuItemReset       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelReset target:self selector:@selector(menuItemResetPressed) ];
        menuItemReset.position          = ccp( 0 + menuItemReset.contentSize.width/2, h -32*6 - 5*6 );
        
        
        
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemMinimize,
                                                         menuItemStatus,
                                                         menuItemInventory,
                                                         menuItemStep,
                                                         menuItemAutostep,
                                                         menuItemReset,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
    }
    return self;
}


-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h isMinimized:(BOOL)isMin {
    if ( ( self = [ super initWithColor: black_alpha(255) width: w height: h ] ) ) {
        
        if ( isMin ) {
            // close button
            CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"Maximize" fontName:@"Courier New" fontSize:16 ];
            menuItemLabelClose.color = white3;
 
            CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose  target:self selector:@selector(menuItemClosePressed)];
            menuItemClose.position = ccp( 0 + menuItemClose.contentSize.width/2, h - 32 - 5 );
            
            CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                             menuItemClose,
                                                             nil] ];
            menu.position = ccp( 0, 0 );
            [ self addChild: menu ];
            
        } else {
            self = [ self initWithColor:color width:w height:h];
        }
    }
    return self;
}



#define MENUITEMCLOSE_NOTIFICATIONNAME @"PlayerMenuCloseNotification"
-( void ) menuItemClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEMCLOSE_NOTIFICATIONNAME  object:self];
}

-( void ) menuItemStatusPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStatusNotification"  object:self];
}

-( void ) menuItemInventoryPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuInventoryNotification"  object:self];
}

-( void ) menuItemStepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStepNotification"  object:self];
}

-( void ) menuItemAutostepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuAutostepNotification"  object:self];
}



-( void ) menuItemTogglePositionPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuTogglePositionNotification"  object:self];
}

-( void ) menuItemToggleHUDsPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuToggleHUDsNotification"  object:self];
}

-( void ) menuItemResetPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuResetNotification"  object:self];
}



@end