//  HUDMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "HUDMenu.h"

@implementation HUDMenu

-( id ) init {
    if ( (self=[super initWithColor:black_alpha(0) width:20 height:50])) {
        
        
        // editorHUD button
        CCMutableTexture2D *texture0 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture0 fill: black_alpha(128) ];
        
        for ( int i = 4; i < 12; i++ ) {
            for ( int j = 4; j < 12; j++ ) {
                [texture0 setPixelAt:ccp( j, i ) rgba:white ];
            }
        }
        [ texture0 apply ];
        
        // monitor button
        CCMutableTexture2D *texture1 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
        [ texture1 fill: black_alpha(128) ];
        
        for ( int i = 4; i < 12; i++ ) {
            for ( int j = 4; j < 12; j++ ) {
                [texture1 setPixelAt:ccp( j, i ) rgba:white ];
            }
        }
        [ texture1 apply ];
        
        
        
        
        
        
        CCMenuItem *miEditorHUDClose = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture0] selectedSprite:[CCSprite spriteWithTexture:texture0] disabledSprite:[CCSprite spriteWithTexture:texture0] target:self selector:@selector(miEditorHUDClosePressed)];
        miEditorHUDClose.scale = 2;
        miEditorHUDClose.position = ccp( 0 + miEditorHUDClose.contentSize.width, 50 - 32 );
        
        CCMenuItem *miMonitorClose = [ [ CCMenuItemSprite alloc ] initWithNormalSprite:[CCSprite spriteWithTexture:texture1] selectedSprite:[CCSprite spriteWithTexture:texture1] disabledSprite:[CCSprite spriteWithTexture:texture1] target:self selector:@selector(miMonitorClosePressed)];
        miMonitorClose.scale = 2;
        miMonitorClose.position = ccp( 0 + miMonitorClose.contentSize.width, 50 - 32 - 32 - 5 );
        
        
        
        
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         miEditorHUDClose,
                                                         miMonitorClose,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
        
    }
    return self;
}

-( void ) miEditorHUDClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"HUDMenuEditorHUDCloseNotification"  object:self];
}

-( void ) miMonitorClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"HUDMonitorCloseNotification"  object:self];
}



@end
