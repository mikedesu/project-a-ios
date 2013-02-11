//  PlayerMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "PlayerMenu.h"

@implementation PlayerMenu

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        label = [[ CCLabelTTF alloc ] initWithString:@"PlayerMenu" dimensions:CGSizeMake(w, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:12];
        label.position = ccp( 0 + w/2, h - (label.contentSize.height/2) );
        label.color = white3;
        [self addChild: label];
        
#define MENUITEM_LABEL_FONTNAME     @"Courier New"
#define MENUITEM_LABEL_FONTSIZE     16
#define MENUITEM_LABEL_FONTCOLOR    white3
        
#define MENUITEM0_LABEL_TEXT    @"EditorHUD"
#define MENUITEM1_LABEL_TEXT    @"MenuItemLabel1"
        
        
        CCLabelTTF *menuItemLabel0 = [[ CCLabelTTF alloc ] initWithString: MENUITEM0_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel0.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel1 = [[ CCLabelTTF alloc ] initWithString: MENUITEM1_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel1.color = MENUITEM_LABEL_FONTCOLOR;
        
        
        int pad = 10;
        
        CCMenuItem *menuItem0 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel0 target:self selector:@selector(menuItem0Pressed) ];
        menuItem0.position = ccp( 0 + menuItemLabel0.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad );
        
        CCMenuItem *menuItem1 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel1 target:self selector:@selector(menuItem1Pressed) ];
        menuItem1.position = ccp( 0 + menuItemLabel1.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad );
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItem0,
                                                         menuItem1,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
        
    }
    return self;
}


#define MENUITEM0_NOTIFICATIONNAME      @"ShowHideEditorHUD"
-( void ) menuItem0Pressed {
    MLOG( @"menuItem0Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM0_NOTIFICATIONNAME object: self ];
}


#define MENUITEM1_NOTIFICATIONNAME      @"TestNotification1"
-( void ) menuItem1Pressed {
    MLOG( @"menuItem1Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM1_NOTIFICATIONNAME object: self ];
}




@end