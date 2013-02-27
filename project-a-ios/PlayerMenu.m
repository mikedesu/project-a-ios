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
        
#define MENUITEM_LABEL_FONTNAME     @"Courier New"
#define MENUITEM_LABEL_FONTSIZE     16
#define MENUITEM_LABEL_FONTCOLOR    white3
        
#define MENUITEM0_LABEL_TEXT    @"Monitor"
#define MENUITEM1_LABEL_TEXT    @"Move"
#define MENUITEM2_LABEL_TEXT    @"Attack"

#define MENUITEM3_LABEL_TEXT    @"Step"
        
#define MENUITEM4_LABEL_TEXT    @"Label4"
#define MENUITEM5_LABEL_TEXT    @"Label5"
#define MENUITEM6_LABEL_TEXT    @"Label6"
#define MENUITEM7_LABEL_TEXT    @"Label7"
#define MENUITEM8_LABEL_TEXT    @"Label8"
#define MENUITEM9_LABEL_TEXT    @"Label9"
#define MENUITEM10_LABEL_TEXT   @"Label10"
        

#define MENUITEMCLOSE_LABEL_TEXT  @"X"
        CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: MENUITEMCLOSE_LABEL_TEXT fontName:MENUITEM_LABEL_FONTNAME fontSize:MENUITEM_LABEL_FONTSIZE ];
        menuItemLabelClose.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel0 = [[ CCLabelTTF alloc ] initWithString: MENUITEM0_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel0.color = MENUITEM_LABEL_FONTCOLOR;
        
         CCLabelTTF *menuItemLabel1 = [[ CCLabelTTF alloc ] initWithString: MENUITEM1_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel1.color = MENUITEM_LABEL_FONTCOLOR;
        
         CCLabelTTF *menuItemLabel2 = [[ CCLabelTTF alloc ] initWithString: MENUITEM2_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
 
        CCLabelTTF *menuItemLabel3 = [[ CCLabelTTF alloc ] initWithString: MENUITEM3_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        /*
         CCLabelTTF *menuItemLabel4 = [[ CCLabelTTF alloc ] initWithString: MENUITEM4_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel5 = [[ CCLabelTTF alloc ] initWithString: MENUITEM5_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel6 = [[ CCLabelTTF alloc ] initWithString: MENUITEM6_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel7 = [[ CCLabelTTF alloc ] initWithString: MENUITEM7_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel8 = [[ CCLabelTTF alloc ] initWithString: MENUITEM8_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel9 = [[ CCLabelTTF alloc ] initWithString: MENUITEM9_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        
        CCLabelTTF *menuItemLabel10 = [[ CCLabelTTF alloc ] initWithString: MENUITEM10_LABEL_TEXT fontName: MENUITEM_LABEL_FONTNAME fontSize: MENUITEM_LABEL_FONTSIZE ];
        menuItemLabel2.color = MENUITEM_LABEL_FONTCOLOR;
        */
        
        
        
        
        
        int pad = 10;
        
        CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose target:self selector:@selector(menuItemClosePressed) ];
        menuItemClose.position = ccp( 0 + menuItemLabelClose.contentSize.width/2, label.position.y );
        
        CCMenuItem *menuItem0 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel0 target:self selector:@selector(menuItem0Pressed) ];
        menuItem0.position = ccp( 0 + menuItemLabel0.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad );
        
         CCMenuItem *menuItem1 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel1 target:self selector:@selector(menuItem1Pressed) ];
        menuItem1.position = ccp( 0 + menuItemLabel1.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad );
        
         CCMenuItem *menuItem2 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel2 target:self selector:@selector(menuItem2Pressed) ];
        menuItem2.position = ccp( 0 + menuItemLabel2.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad );
        
        CCMenuItem *menuItem3 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel3 target:self selector:@selector(menuItem3Pressed) ];
        menuItem3.position = ccp( 0 + menuItemLabel3.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad );
        
        /*
         CCMenuItem *menuItem4 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel4 target:self selector:@selector(menuItem4Pressed) ];
        menuItem4.position = ccp( 0 + menuItemLabel4.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad
                                 );
        
        CCMenuItem *menuItem5 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel5 target:self selector:@selector(menuItem5Pressed) ];
        menuItem5.position = ccp( 0 + menuItemLabel5.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad -
                                 (menuItemLabel5.contentSize.height/2) - pad
                                 );
        
        CCMenuItem *menuItem6 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel6 target:self selector:@selector(menuItem6Pressed) ];
        menuItem6.position = ccp( 0 + menuItemLabel6.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad -
                                 (menuItemLabel5.contentSize.height/2) - pad -
                                 (menuItemLabel6.contentSize.height/2) - pad 
                                 );
        
        CCMenuItem *menuItem7 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel7 target:self selector:@selector(menuItem7Pressed) ];
        menuItem7.position = ccp( 0 + menuItemLabel7.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad -
                                 (menuItemLabel5.contentSize.height/2) - pad -
                                 (menuItemLabel6.contentSize.height/2) - pad -
                                 (menuItemLabel7.contentSize.height/2) - pad 
                                 );
        
        CCMenuItem *menuItem8 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel8 target:self selector:@selector(menuItem8Pressed) ];
        menuItem8.position = ccp( 0 + menuItemLabel8.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad -
                                 (menuItemLabel5.contentSize.height/2) - pad -
                                 (menuItemLabel6.contentSize.height/2) - pad -
                                 (menuItemLabel7.contentSize.height/2) - pad -
                                 (menuItemLabel8.contentSize.height/2) - pad
                                 );
        
        CCMenuItem *menuItem9 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel9 target:self selector:@selector(menuItem9Pressed) ];
        menuItem9.position = ccp( 0 + menuItemLabel9.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                 (menuItemLabel3.contentSize.height/2) - pad -
                                 (menuItemLabel4.contentSize.height/2) - pad -
                                 (menuItemLabel5.contentSize.height/2) - pad -
                                 (menuItemLabel6.contentSize.height/2) - pad -
                                 (menuItemLabel7.contentSize.height/2) - pad -
                                 (menuItemLabel8.contentSize.height/2) - pad -
                                 (menuItemLabel9.contentSize.height/2) - pad 
                                 );
        
        CCMenuItem *menuItem10 = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabel10 target:self selector:@selector(menuItem10Pressed) ];
        menuItem10.position = ccp( 0 + menuItemLabel10.contentSize.width/2 , label.position.y - (menuItemLabel0.contentSize.height/2) - pad - (menuItemLabel1.contentSize.height/2) - pad - (menuItemLabel2.contentSize.height/2) - pad -
                                  (menuItemLabel3.contentSize.height/2) - pad -
                                  (menuItemLabel4.contentSize.height/2) - pad -
                                  (menuItemLabel5.contentSize.height/2) - pad -
                                  (menuItemLabel6.contentSize.height/2) - pad -
                                  (menuItemLabel7.contentSize.height/2) - pad -
                                  (menuItemLabel8.contentSize.height/2) - pad -
                                  (menuItemLabel9.contentSize.height/2) - pad -
                                  (menuItemLabel10.contentSize.height/2) - pad
                                 );
        */
        
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemClose,
                                                         menuItem0 ,
                                                         menuItem1,
                                                         menuItem2,
                                                         menuItem3,/*
                                                         menuItem4,
                                                         menuItem5,
                                                         menuItem6,
                                                         menuItem7,
                                                         menuItem8,
                                                         menuItem9,
                                                         menuItem10,*/
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


#define MENUITEM0_NOTIFICATIONNAME      @"MonitorNotification"
-( void ) menuItem0Pressed {
   // MLOG( @"menuItem0Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM0_NOTIFICATIONNAME object: self ];
}


#define MENUITEM1_NOTIFICATIONNAME      @"MoveNotification"
-( void ) menuItem1Pressed {
  //  MLOG( @"menuItem1Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM1_NOTIFICATIONNAME object: self ];
}


#define MENUITEM2_NOTIFICATIONNAME      @"AttackNotification"
-( void ) menuItem2Pressed {
 //   MLOG( @"menuItem2Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM2_NOTIFICATIONNAME object: self ];
}


#define MENUITEM3_NOTIFICATIONNAME      @"StepNotification"
-( void ) menuItem3Pressed {
  //  MLOG( @"menuItem3Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM3_NOTIFICATIONNAME object: self ];
}


#define MENUITEM4_NOTIFICATIONNAME      @"MENUITEM4_NOTIFICATIONNAME"
-( void ) menuItem4Pressed {
   // MLOG( @"menuItem4Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM4_NOTIFICATIONNAME object: self ];
}


#define MENUITEM5_NOTIFICATIONNAME      @"MENUITEM5_NOTIFICATIONNAME"
-( void ) menuItem5Pressed {
   // MLOG( @"menuItem5Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM5_NOTIFICATIONNAME object: self ];
}


#define MENUITEM6_NOTIFICATIONNAME      @"MENUITEM6_NOTIFICATIONNAME"
-( void ) menuItem6Pressed {
  //  MLOG( @"menuItem6Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM6_NOTIFICATIONNAME object: self ];
}


#define MENUITEM7_NOTIFICATIONNAME      @"MENUITEM7_NOTIFICATIONNAME"
-( void ) menuItem7Pressed {
  //  MLOG( @"menuItem7Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM7_NOTIFICATIONNAME object: self ];
}


#define MENUITEM8_NOTIFICATIONNAME      @"MENUITEM8_NOTIFICATIONNAME"
-( void ) menuItem8Pressed {
  //  MLOG( @"menuItem8Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM8_NOTIFICATIONNAME object: self ];
}


#define MENUITEM9_NOTIFICATIONNAME      @"MENUITEM9_NOTIFICATIONNAME"
-( void ) menuItem9Pressed {
  //  MLOG( @"menuItem9Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM9_NOTIFICATIONNAME object: self ];
}


#define MENUITEM10_NOTIFICATIONNAME      @"MENUITEM10_NOTIFICATIONNAME"
-( void ) menuItem10Pressed {
 //   MLOG( @"menuItem10Pressed" );
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEM10_NOTIFICATIONNAME object: self ];
}






@end