//  Drawer.m
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Drawer.h"

@implementation Drawer

+(CCTexture2D *) basicSwordWithColor: (Color_t) bladeColor withHandleColor: (Color_t) handleColor {
    // attack button
    CCMutableTexture2D *texture2 = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    //[ texture2 fill: black_alpha(0) ];
    
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
    for ( int i = 12; i < 16; i++ )
        for ( int j = 6; j < 10; j++ )
            [ texture2 setPixelAt:ccp(j,i) rgba:handleColor];
    
    /*
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
    */
    
    [ texture2 apply ];
    
    return texture2;

}

@end