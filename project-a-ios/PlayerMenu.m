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
        
     //   CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"X" fontName:@"Courier New" fontSize:30 ];
    //    menuItemLabelClose.color = white3;
        
       // CCLabelTTF *menuItemLabelMove = [[CCLabelTTF alloc] initWithString: @"M" fontName:@"Courier New" fontSize:30 ];
      //  menuItemLabelClose.color = white3;
        
      //  CCLabelTTF *menuItemLabelAttack = [[CCLabelTTF alloc] initWithString: @"A" fontName:@"Courier New" fontSize:30 ];
     //   menuItemLabelClose.color = white3;
        
     //   CCLabelTTF *menuItemLabelStep = [[CCLabelTTF alloc] initWithString: @"S" fontName:@"Courier New" fontSize:30 ];
     //   menuItemLabelClose.color = white3;
        
 
        // close button
        CCMutableTexture2D *texture0 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture0 fill: white ];
        [ texture0 apply ];
        
        // move button
        CCMutableTexture2D *texture1 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture1 fill: black_alpha(128) ];
        
        Color_t shoeColor = blue;
        
        for ( int j = 2; j < 14; j++ ) {
            for ( int i = 0; i < 8; i++ ) {
                [ texture1 setPixelAt:ccp(2 + i, j) rgba:shoeColor ];
            }
        }
        
        for ( int j = 9; j < 14; j++ ) {
            for ( int i = 4; i < 12; i++ ) {
                [ texture1 setPixelAt:ccp(2 + i, j) rgba:shoeColor ];
            }
        }
        
        
        
        
        [ texture1 apply ];
        
        // attack button
        //CCMutableTexture2D *texture2 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        CCTexture2D *texture2 = [Drawer basicSwordWithColor:white withHandleColor:darkgray];
        /*
        [ texture2 fill: black_alpha(128) ];
        
        Color_t bladeColor = gray;
        Color_t handleColor = blue;
        
        [ texture2 setPixelAt:ccp(6,0) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,0) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,0) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,0) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,1) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,1) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,1) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,1) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,2) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,2) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,2) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,2) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,3) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,3) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,3) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,3) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,4) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,4) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,4) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,4) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,5) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,5) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,5) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,5) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,6) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,6) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,6) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,6) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,7) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,7) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,7) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,7) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,8) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,8) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,8) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,8) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,9) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,9) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,9) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,9) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,10) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(6,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(7,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(8,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(9,11) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(4,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(5,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(10,10) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(11,10) rgba:bladeColor];
        
        [ texture2 setPixelAt:ccp(4,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(5,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(10,11) rgba:bladeColor];
        [ texture2 setPixelAt:ccp(11,11) rgba:bladeColor];
        
        // handleColor below
        [ texture2 setPixelAt:ccp(6,12) rgba:handleColor];
        [ texture2 setPixelAt:ccp(7,12) rgba:handleColor];
        [ texture2 setPixelAt:ccp(8,12) rgba:handleColor];
        [ texture2 setPixelAt:ccp(9,12) rgba:handleColor];
        
        [ texture2 setPixelAt:ccp(6,13) rgba:handleColor];
        [ texture2 setPixelAt:ccp(7,13) rgba:handleColor];
        [ texture2 setPixelAt:ccp(8,13) rgba:handleColor];
        [ texture2 setPixelAt:ccp(9,13) rgba:handleColor];
        
        [ texture2 setPixelAt:ccp(6,14) rgba:handleColor];
        [ texture2 setPixelAt:ccp(7,14) rgba:handleColor];
        [ texture2 setPixelAt:ccp(8,14) rgba:handleColor];
        [ texture2 setPixelAt:ccp(9,14) rgba:handleColor];
        
        [ texture2 setPixelAt:ccp(6,15) rgba:handleColor];
        [ texture2 setPixelAt:ccp(7,15) rgba:handleColor];
        [ texture2 setPixelAt:ccp(8,15) rgba:handleColor];
        [ texture2 setPixelAt:ccp(9,15) rgba:handleColor];
        
        [ texture2 apply ];
        */
         
        // step button
        CCMutableTexture2D *texture3 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture3 fill: black_alpha(128) ];
        
        for ( int i = 4; i < 12; i++ ) {
            for ( int j = 4; j < 12; j++ ) {
                [texture3 setPixelAt:ccp( j, i ) rgba:white ];
            }
        }
        
        [ texture3 apply ];
        
        
        
        // toggle menu position button
        CCMutableTexture2D *texture4 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture4 fill: green ];
        [ texture4 apply ];
        
        
        
        // toggle HUDs button
        CCMutableTexture2D *texture5 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        //[ texture5 fill: green ];
        [ texture5 fill: black_alpha(128) ];
        
        for ( int i = 4; i < 12; i++ ) {
            for ( int j = 4; j < 12; j++ ) {
                [texture5 setPixelAt:ccp( j, i ) rgba:white ];
            }
        }
        [ texture5 apply ];
        
        
        
        
        //CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose target:self selector:@selector(menuItemClosePressed) ];
        CCMenuItem *menuItemClose = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture0] selectedSprite:[CCSprite spriteWithTexture:texture0] disabledSprite:[CCSprite spriteWithTexture:texture0] target:self selector:@selector(menuItemClosePressed)];
        menuItemClose.scale = 2;
        menuItemClose.position = ccp( 0 + menuItemClose.contentSize.width, h - 32 - 5 );
        
        //CCMenuItem *menuItemMove = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMove target:self selector:@selector(menuItemMovePressed) ];
        CCMenuItem *menuItemMove = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture1] selectedSprite:[CCSprite spriteWithTexture:texture1] disabledSprite:[CCSprite spriteWithTexture:texture1] target:self selector:@selector(menuItemMovePressed)];
        menuItemMove.scale = 2;
        menuItemMove.position = ccp( 0 + menuItemMove.contentSize.width, h - 32-32 - 5*2);
        
        //CCMenuItem *menuItemAttack = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelAttack target:self selector:@selector(menuItemAttackPressed) ];
        CCMenuItem *menuItemAttack = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture2] selectedSprite:[CCSprite spriteWithTexture:texture2] disabledSprite:[CCSprite spriteWithTexture:texture2] target:self selector:@selector(menuItemAttackPressed)];
        menuItemAttack.scale = 2;
        menuItemAttack.position = ccp( 0 + menuItemAttack.contentSize.width, h - 32-32-32 - 5*3 );
        
        //CCMenuItem *menuItemStep = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStep target:self selector:@selector(menuItemStepPressed) ];
        CCMenuItem *menuItemStep = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture3] selectedSprite:[CCSprite spriteWithTexture:texture3] disabledSprite:[CCSprite spriteWithTexture:texture3] target:self selector:@selector(menuItemStepPressed)];
        menuItemStep.scale = 2;
        menuItemStep.position = ccp( 0 + menuItemStep.contentSize.width, h - 32*4 - 5*4 );
        
        //CCMenuItem *menuItemStep = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStep target:self selector:@selector(menuItemStepPressed) ];
        CCMenuItem *menuItemTogglePosition = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture4] selectedSprite:[CCSprite spriteWithTexture:texture4] disabledSprite:[CCSprite spriteWithTexture:texture4] target:self selector:@selector(menuItemTogglePositionPressed)];
        menuItemTogglePosition.scale = 2;
        menuItemTogglePosition.position = ccp( 0 + menuItemStep.contentSize.width, h - 32*5 - 5*5 );
        
        
        CCMenuItem *menuItemToggleHUDs = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture5] selectedSprite:[CCSprite spriteWithTexture:texture5] disabledSprite:[CCSprite spriteWithTexture:texture5] target:self selector:@selector(menuItemToggleHUDsPressed)];
        menuItemToggleHUDs.scale = 2;
        menuItemToggleHUDs.position = ccp( 0 + menuItemStep.contentSize.width, h - 32*6 - 5*6 );
        
        
        
        
        
        
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemClose,
                                                         menuItemMove,
                                                         menuItemAttack,
                                                         menuItemStep,
                                                         menuItemTogglePosition,
                                                         menuItemToggleHUDs,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
        
        
    }
    return self;
}

-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h isMinimized:(BOOL)isMin {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        /*
         label = [[ CCLabelTTF alloc ] initWithString:@"PlayerMenu" dimensions:CGSizeMake(w, 20) hAlignment:kCCTextAlignmentLeft fontName:@"Courier New" fontSize:12];
         label.position = ccp( 0 + w/2 + 10, h - (label.contentSize.height/2) );
         label.color = white3;
         [self addChild: label];
         */
        
        if ( isMin ) {
            
            // close button
            CCMutableTexture2D *texture = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
            [ texture fill: ccc4(0x77, 0x77, 0x77, 0xff) ];
            [ texture apply ];
            
        
            CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"X" fontName:@"Courier New" fontSize:30 ];
            menuItemLabelClose.color = white3;
 
        //    CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose target:self selector:@selector(menuItemClosePressed) ];
        CCMenuItem *menuItemClose = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture] selectedSprite:[CCSprite spriteWithTexture:texture] disabledSprite:[CCSprite spriteWithTexture:texture] target:self selector:@selector(menuItemClosePressed)];
            menuItemClose.scale = 2;
            menuItemClose.position = ccp( 0 + menuItemLabelClose.contentSize.width/2, h - (menuItemLabelClose.contentSize.height/2) );
            
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

-( void ) menuItemMovePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuMoveNotification"  object:self];
}

-( void ) menuItemAttackPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuAttackNotification"  object:self];
}

-( void ) menuItemStepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"StepNotification"  object:self];
}

-( void ) menuItemTogglePositionPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuTogglePositionNotification"  object:self];
}

-( void ) menuItemToggleHUDsPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuToggleHUDsNotification"  object:self];
}






@end