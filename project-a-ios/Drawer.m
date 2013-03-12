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
    
    Color_t c0 = gray;
    Color_t c1 = darkgray;
    
    [t fill:c0];
    for (int j=0; j<16; j+=2) {
        for (int i=0; i<16; i++) {
            [t setPixelAt:ccp(i,j) rgba:c1];
        }
    }
    for (int i=0; i<16; i+=2) {
        for (int j=0; j<16; j++) {
            [t setPixelAt:ccp(i,j) rgba:c1];
        }
    }
    
    
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) voidTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    [t fill:black];
    /*
    for (int i=0; i<16; i+=2) {
        for (int j=1; j<16; j+=2) {
            [t setPixelAt:ccp(i,j) rgba:darkgray];
        }
    }
    */
    
    NSInteger x = [Dice roll:16]-1;
    NSInteger y = [Dice roll:16]-1;
    
    [t setPixelAt:ccp(x,y) rgba:white];
    
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) upstairsTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    Color_t c0 = gray;
    Color_t c1 = black;
    
    for (int i=4; i<16; i++)
        for (int j=14; j<16; j++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    for (int i=8; i<16; i++)
        for (int j=10; j<16; j++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    for (int i=12; i<16; i++)
        for (int j=6; j<16; j++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    for (int i=0; i<16; i++) {
        [t setPixelAt:ccp(i, 9) rgba:c1];
        [t setPixelAt:ccp(i, 13) rgba:c1];
    }
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) downstairsTile {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    Color_t c0 = gray;
    
    for (int i=0; i<16; i++) {
        int j;
        for (j=i<4?2:i<8?6:i<12?10:14; j<16; j++) {
            [t setPixelAt:ccp(i,j) rgba:c0];
        }
    }
    
    for (int i=0; i<16; i++) {
        [t setPixelAt:ccp(3,i) rgba:black];
        [t setPixelAt:ccp(7,i) rgba:black];
        [t setPixelAt:ccp(11,i) rgba:black];
    }
    
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) bookOfAllKnowing {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    for (int i=2; i<14; i++)
        for (int j=2; j<14; j++)
            [t setPixelAt:ccp(i,j) rgba:brown];
    
    for (int i=4; i<14; i++)
        for (int j=11; j<13; j++)
            [t setPixelAt:ccp(i,j) rgba:white];
    
    [ t apply ];
    return t;
}


+(CCMutableTexture2D *) marioWithSuitColor: (Color_t) suitColor skinColor: (Color_t) skinColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    int v = 0; // pixel offset
    
    // mario's hat
    //Color_t hatColor = red;
    Color_t hatColor = suitColor;
    v = 3;
    for ( int i=0; i < 5; i++)
        [t setPixelAt:ccp(i+v,0) rgba:hatColor];
    v = 2;
    for ( int i=0; i < 9; i++)
        [t setPixelAt:ccp(i+v,1) rgba:hatColor];
    
    
    // mario's head
    // hair
    Color_t hairColor = black;
    v = 2;
    for ( int i = 0; i < 3; i++ )
        [ t setPixelAt:ccp(0+v+i,2) rgba:hairColor];
    [ t setPixelAt:ccp(5+v,2) rgba:hairColor];
    v = 1;
    [ t setPixelAt:ccp(0+v,3) rgba:hairColor];
    [ t setPixelAt:ccp(2+v,3) rgba:hairColor];
    [ t setPixelAt:ccp(6+v,3) rgba:hairColor];
    [ t setPixelAt:ccp(0+v,4) rgba:hairColor];
    [ t setPixelAt:ccp(2+v,4) rgba:hairColor];
    [ t setPixelAt:ccp(3+v,4) rgba:hairColor];
    [ t setPixelAt:ccp(7+v,4) rgba:hairColor];
    [ t setPixelAt:ccp(0+v,5) rgba:hairColor];
    [ t setPixelAt:ccp(1+v,5) rgba:hairColor];
    for (int i=0; i<4; i++)
        [ t setPixelAt:ccp(6+v+i,5) rgba:hairColor];
 
    
    // face
    //Color_t skinColor = skincolor0;
    
    v = 5;
    [ t setPixelAt:ccp(0+v,2) rgba:skinColor];
    [ t setPixelAt:ccp(1+v,2) rgba:skinColor];
    [ t setPixelAt:ccp(3+v,2) rgba:skinColor];
    v = 2;
    [ t setPixelAt:ccp(0+v,3) rgba:skinColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(2+v+i,3) rgba:skinColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(6+v+i,3) rgba:skinColor];
    [ t setPixelAt:ccp(0+v,4) rgba:skinColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(3+v+i,4) rgba:skinColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(7+v+i,4) rgba:skinColor];
    v = 3;
    for (int i=0; i<4; i++)
        [ t setPixelAt:ccp(0+v+i,5) rgba:skinColor];
    for (int i=0; i<7; i++)
        [ t setPixelAt:ccp(0+v+i,6) rgba:skinColor];
    
    
    // shirt
    Color_t shirtColor = red;
    v = 2;
    [ t setPixelAt:ccp(0+v,7) rgba:shirtColor];
    [ t setPixelAt:ccp(1+v,7) rgba:shirtColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(3+v+i,7) rgba:shirtColor];
    v = 1;
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(0+v+i,8) rgba:shirtColor];
    [ t setPixelAt:ccp(4+v,8) rgba:shirtColor];
    [ t setPixelAt:ccp(5+v,8) rgba:shirtColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(7+v+i,8) rgba:shirtColor];
    v = 0;
    for (int i=0; i<4; i++)
        [ t setPixelAt:ccp(0+v+i,9) rgba:shirtColor];
    for (int i=0; i<4; i++)
        [ t setPixelAt:ccp(8+v+i,9) rgba:shirtColor];
    v = 2;
    [ t setPixelAt:ccp(0+v,10) rgba:shirtColor];
    [ t setPixelAt:ccp(7+v,10) rgba:shirtColor];
 
    
    // overalls
    Color_t overallsColor = suitColor;
    v = 4;
    [ t setPixelAt:ccp(0+v,7) rgba:overallsColor];
    [ t setPixelAt:ccp(0+v,8) rgba:overallsColor];
    [ t setPixelAt:ccp(3+v,8) rgba:overallsColor];
    for (int i=0; i<4; i++)
        [ t setPixelAt:ccp(0+v+i,9) rgba:overallsColor];
    v = 3;
    [ t setPixelAt:ccp(0+v,10) rgba:overallsColor];
    [ t setPixelAt:ccp(2+v,10) rgba:overallsColor];
    [ t setPixelAt:ccp(3+v,10) rgba:overallsColor];
    [ t setPixelAt:ccp(5+v,10) rgba:overallsColor];
    for (int i=0; i<6; i++)
        [ t setPixelAt:ccp(0+v+i,11) rgba:overallsColor];
    v = 2;
    for (int i=0; i<8; i++)
        [ t setPixelAt:ccp(0+v+i,12) rgba:overallsColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(0+v+i,13) rgba:overallsColor];
    for (int i=0; i<3; i++)
        [ t setPixelAt:ccp(5+v+i,13) rgba:overallsColor];
    
    
    // buttons
    Color_t buttonsColor = yellow;
    v = 4;
    [ t setPixelAt:ccp(0+v,10) rgba:buttonsColor];
    [ t setPixelAt:ccp(3+v,10) rgba:buttonsColor];
 
    
    // gloves
    Color_t glovesColor = white;
    v = 0;
    for ( int i = 0; i < 2; i++ ) {
        [ t setPixelAt:ccp( 0+v+i,10) rgba:glovesColor];
        [ t setPixelAt:ccp(10+v+i,10) rgba:glovesColor];
    }
    for (int i=0; i<2; i++) {
        [ t setPixelAt:ccp( 0+v+i,11) rgba:glovesColor];
        [ t setPixelAt:ccp( 10+v+i,11) rgba:glovesColor];
    }
    for ( int i = 0; i < 2; i++ ) {
        [ t setPixelAt:ccp( 0+v+i,12) rgba:glovesColor];
        [ t setPixelAt:ccp(10+v+i,12) rgba:glovesColor];
    }
    
    
    // shoes
    Color_t shoesColor = black;
    v = 1;
    for ( int i = 0; i < 3; i++ ) {
        [ t setPixelAt:ccp(0+v+i,14) rgba:shoesColor];
        [ t setPixelAt:ccp(7+v+i,14) rgba:shoesColor];
    }
    v = 0;
    for ( int i = 0; i < 4; i++) {
        [ t setPixelAt:ccp( 0+v+i,15) rgba:shoesColor];
        [ t setPixelAt:ccp( 8+v+i,15) rgba:shoesColor];
    }
    [ t apply ];
    return t;
}





+(CCMutableTexture2D *) hero {
    return [Drawer marioWithSuitColor:blue skinColor:skincolor0];
}



+(CCMutableTexture2D *) monster {
    //CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    //[t fill:black_alpha(0)];
    //[t fill:red];
    //[ t apply ];
    //return t;
    return [Drawer marioWithSuitColor:green skinColor:skincolor3];
}


+(CCMutableTexture2D *) ghoul {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    // ghoul body
    Color_t c0 = green;
    for (int i=2; i<14; i++)
        for (int j=2; j<8; j++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    for (int i=8; i<12; i++)
        for (int j=0; j<12; j++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    
    //left eye
    Color_t c1 = black;
    [t setPixelAt:ccp(4,4) rgba:c1];
    [t setPixelAt:ccp(5,4) rgba:c1];
 
    //right eye
    [t setPixelAt:ccp(8,4) rgba:c1];
    [t setPixelAt:ccp(9,4) rgba:c1];
    [ t apply ];
    return t;
}



+(CCMutableTexture2D *) statusIcon {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    // fill black bg
    Color_t bg = black;
    [t fill:bg];
    
    // draw a white 'S'
    Color_t fontColor = white;
    for (int i=4; i<12; i++)
        for (int j=2; j<15; j+=6)
            [t setPixelAt:ccp(i,j) rgba:fontColor];
    for (int j=2; j<9; j++)
        [t setPixelAt:ccp(4,j) rgba:fontColor];
    for (int j=8; j<15; j++)
        [t setPixelAt:ccp(11,j) rgba:fontColor];
    [t apply];
    
    return t;
}


+(CCMutableTexture2D *) itemIcon {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    // fill black bg
    Color_t bg = black;
    [t fill:bg];
    
    // draw a white 'I'
    Color_t fontColor = white;
    for (int i=8; i<9; i++)
        for (int j=2; j<14; j++)
            [t setPixelAt:ccp(i,j) rgba:fontColor];
    for (int i=4; i<12; i++) {
        [t setPixelAt:ccp(i,2) rgba:fontColor];
        [t setPixelAt:ccp(i,13) rgba:fontColor];
    }
    
    [t apply];
    return t;
}






@end