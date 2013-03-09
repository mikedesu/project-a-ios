//  Drawer.m
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Drawer.h"

@implementation Drawer

+(CCMutableTexture2D *) basicSwordWithColor: (Color_t) bladeColor withHandleColor: (Color_t) handleColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    for (int i = 0; i < 13; i++)
        for ( int j = 6; j < 10; j++ )
            [ t setPixelAt:ccp(j,i) rgba:bladeColor];
    for ( int i = 10; i < 12; i++) {
        [ t setPixelAt:ccp(4,i) rgba:bladeColor];
        [ t setPixelAt:ccp(5,i) rgba:bladeColor];
        [ t setPixelAt:ccp(10,i) rgba:bladeColor];
        [ t setPixelAt:ccp(11,i) rgba:bladeColor];
    }
    for ( int i = 12; i < 16; i++ )
        for ( int j = 6; j < 10; j++ )
            [ t setPixelAt:ccp(j,i) rgba:handleColor];
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) basicShieldWithColor: (Color_t) baseColor withEmblemColor: (Color_t) emblemColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    for (int i=2; i < 14; i++)
        for (int j=2; j < 9; j++)
            [t setPixelAt:ccp(i,j) rgba:baseColor];
    for (int i=4; i < 12; i++)
        for (int j=9; j < 11; j++)
            [t setPixelAt:ccp(i,j) rgba:baseColor];
    for (int i=6; i < 10; i++)
        for (int j=11; j < 13; j++)
            [t setPixelAt:ccp(i,j) rgba:baseColor];
    
    // emblem
    for (int i=6; i < 10; i++)
        for (int j=3; j < 10; j++)
            [t setPixelAt:ccp(i,j) rgba:emblemColor];
    for (int i=3; i < 13; i++)
        [t setPixelAt:ccp(i,7) rgba:emblemColor];
    
    
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) stoneTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    [t fill:gray];
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) voidTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    [t fill:black];
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) upstairsTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    [t fill:cyan];
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) downstairsTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    [t fill:purple];
    [ t apply ];
    return t;
}








@end