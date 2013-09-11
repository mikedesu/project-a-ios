//  Drawer.m
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Drawer.h"

@implementation Drawer


+(CCMutableTexture2D *) greenBlob {
    CCMutableTexture2D *t = [self smallBlob: green];
    return t;
}


+(CCMutableTexture2D *) smallBlob: (Color_t) blobColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:clear];
    Color_t c = blobColor;
    for (int j=7; j<10; j++)
        for (int i=7; i<10; i++)
            [t setPixelAt:ccp(i,j) rgba:c];
    [t setPixelAt:ccp(8,6) rgba:c];
    [t setPixelAt:ccp(8,10) rgba:c];
    [t apply];
    return t;
}



+(CCMutableTexture2D *) guy: (Color_t) head body: (Color_t) body pants: (Color_t) pants blindfolded: (BOOL) isBlindfolded {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    
    // pad everything over
    int pad = 3;
    
    // need head
    int x0 = 2+pad, y0 = 0;
    int x1 = 7+pad, y1 = 5;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:head];
    
    // need eyes
    x0 = 3+pad, y0 = 2;
    x1 = 5+pad, y1 = 2;
    [t setPixelAt:ccp(x0,y0) rgba:black];
    [t setPixelAt:ccp(x1,y1) rgba:black];
    
    // if is blindfolded...
    if ( isBlindfolded ) {
        x0 = 2+pad, y0 = 1;
        x1 = 7+pad, y1 = 4;
        for (int j=y0; j<y1; j++)  for (int i=x0; i<x1; i++)  [t setPixelAt:ccp(i,j) rgba:gray];
    }
    
    
    // need body
    x0 = 1+pad, y0 = 5;
    x1 = 8+pad, y1 = 12;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:body];
    
    // need legs
    x0 = 1+pad, y0 = 12;
    x1 = 8+pad, y1 = 16;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:pants];
    
    // need split in legs
    x0 = 4+pad, y0 = 14;
    x1 = 5+pad, y1 = 16;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:clear];
    
    return t;
}



+(CCMutableTexture2D *) cat: (Color_t) body eyes: (Color_t) eyes {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
 
    int x0, y0;
    x0 = 1, y0 = 0;    [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 8, y0 = 0;    [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 0, y0 = 1;    for (int i=0; i<3;  i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 7, y0 = 1;    for (int i=0; i<3;  i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 2;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 3;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 4;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 5;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 6;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 0, y0 = 7;    for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 13, y0 = 4;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 12, y0 = 5;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 12, y0 = 6;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 13, y0 = 5;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 13, y0 = 6;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 13, y0 = 7;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 14, y0 = 5;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 14, y0 = 6;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 14, y0 = 7;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 14, y0 = 8;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 1, y0 = 8;    for (int i=0; i<13; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 3, y0 = 9;    for (int i=0; i<11; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 3, y0 = 10;   for (int i=0; i<11; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 4, y0 = 11;   for (int i=0; i<10; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 4, y0 = 12;   for (int i=0; i<7; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 12, y0 = 12;  [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 4, y0 = 13;   for (int i=0; i<7; i++) [t setPixelAt:ccp(x0+i, y0) rgba:body];
    x0 = 4, y0 = 14;   [t setPixelAt:ccp(x0,y0) rgba:body];
    x0 = 10, y0 = 14;  [t setPixelAt:ccp(x0,y0) rgba:body];
    
    // eyes
    x0 = 2, y0 = 5;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    x0 = 2, y0 = 6;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    x0 = 4, y0 = 7;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    x0 = 5, y0 = 7;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    x0 = 7, y0 = 5;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    x0 = 7, y0 = 6;   [t setPixelAt:ccp(x0,y0) rgba:eyes];
    
    return t;
}





+(CCMutableTexture2D *) basicPotionWithColor: (Color_t) liquidColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    
    Color_t bg = clear;
    Color_t outer = white;
    
    [t fill: bg];
    
    for (int i=0; i<4; i++) {
        [t setPixelAt:ccp(i+2,0) rgba:liquidColor];
        [t setPixelAt:ccp(i+2,2) rgba:outer];
        [t setPixelAt:ccp(i+2,9) rgba:liquidColor];
    }
    for (int i=0; i<2; i++) {
        [t setPixelAt:ccp(i+3,1) rgba:liquidColor];
        [t setPixelAt:ccp(i+3,3) rgba:liquidColor];
    }
    for (int i=0; i<6; i++) {
        [t setPixelAt:ccp(i+1,6) rgba:liquidColor];
        [t setPixelAt:ccp(i+1,7) rgba:liquidColor];
        [t setPixelAt:ccp(i+1,8) rgba:liquidColor];
    }
 
    [t setPixelAt:ccp(2,3) rgba:outer];
    [t setPixelAt:ccp(5,3) rgba:outer];
    [t setPixelAt:ccp(1,4) rgba:outer];
    [t setPixelAt:ccp(2,4) rgba:outer];
    [t setPixelAt:ccp(5,4) rgba:outer];
    [t setPixelAt:ccp(6,4) rgba:outer];
    for (int j=5; j<10; j++) {
        [t setPixelAt:ccp(0,j) rgba:outer];
        [t setPixelAt:ccp(7,j) rgba:outer];
    }
    [t setPixelAt:ccp(1,9) rgba:outer];
    [t setPixelAt:ccp(6,9) rgba:outer];
    for (int i=1; i<7; i++) [t setPixelAt:ccp(i, 10) rgba:outer];
    
    [t apply];
    return t;
}
                                            


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


+(CCMutableTexture2D *) flatTile: (Color_t) tileColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: tileColor];
    [t apply];
    return t;
}



+(CCMutableTexture2D *) grassTile: (int) style c0:(Color_t) c0 c1:(Color_t) c1 c2:(Color_t) c2 {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: c0];
    
    if ( style == 0 ) {
        // filled, flat-tile
    }
    
    // checkerboard c1
    else if ( style == 1 ) {
        // checkerboard pattern
        for (int i=0; i<16; i+=2)
            for (int j=0; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
        for (int i=1; i<16; i+=2)
            for (int j=1; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
    }
    
    // checkerboard c1
    else if ( style == 2 ) {
        // checkerboard pattern
        for (int i=0; i<8; i+=2)
            for (int j=0; j<8; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
        for (int i=1; i<8; i+=2)
            for (int j=1; j<8; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
    }
    
    // checkerboard c1
    else if ( style == 3 ) {
        // checkerboard pattern
        for (int i=8; i<16; i+=2)
            for (int j=0; j<8; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
        for (int i=9; i<16; i+=2)
            for (int j=1; j<8; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
    }
    
    // checkerboard c1
    else if ( style == 4 ) {
        // checkerboard pattern
        for (int i=0; i<8; i+=2)
            for (int j=8; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
        for (int i=1; i<8; i+=2)
            for (int j=9; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
    }
    
    // checkerboard c1
    else if ( style == 5 ) {
        // checkerboard pattern
        for (int i=8; i<16; i+=2)
            for (int j=8; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
        for (int i=9; i<16; i+=2)
            for (int j=9; j<16; j+=2)
                [t setPixelAt:ccp(i,j) rgba:c1];
    }
    
    
    // random scatter c1
    else if ( style == 9999 ) {
        int pixels = style == 2 ? 16 : style == 3 ? 32 : style == 4 ? 64 : 16;
        while ( pixels > 0 ) {
            int rx = [Dice roll:16];
            int ry = [Dice roll:16];
            [t setPixelAt:ccp(rx,ry) rgba:c1];
            pixels--;
        }
    }
    
    
    
    [t apply];
    return t;
}




+(CCMutableTexture2D *) stoneTileColor0: (Color_t) color0 Color1: (Color_t) color1 Pattern: (int) patternID {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    int offset = 2;
    //Color_t c0 = color0;
    //Color_t c1 = color1;
    
    [t fill:color0];
    
    if ( patternID == 0 ) {
        for (int i=1; i<t.contentSizeInPixels.width; i+=offset) 
            for (int j=1; j<t.contentSizeInPixels.height; j+=offset) 
                [t setPixelAt:ccp(i,j) rgba:color1];
    }
    else if ( patternID == 1 ) {
        /*
          0123456789abcdef
         0........x.......
         1.......x.x......
         2......x.x.x.....
         3.....x.x.x.x....
         4....x.x.x.x.x...
         5...x.x.x.x.x.x..
         6..x.x.x.x.x.x.x.
         7.x.x.x.x.x.x.x.x
         8x.x.x.x.x.x.x.x.
         9.x.x.x.x.x.x.x..
         a..x.x.x.x.x.x...
         b...x.x.x.x.x....
         c....x.x.x.x.....
         d.....x.x.x......
         e......x.x.......
         f.......x........
         */
        
        int i = 8,
            j = 0,
            start_i = 0,
            start_j = 0,
            end_i = 0,
            end_j = 0;
        [t setPixelAt:ccp(i,j) rgba:color1];
        
        j++;    start_i = 7;    end_i = 9;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        
        j++;    start_i = 6;    end_i = 10;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 5;    end_i = 11;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 4;    end_i = 12;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 3;    end_i = 13;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 2;    end_i = 14;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 1;    end_i = 15;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        
        j++;    start_i = 0;    end_i = 14;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 1;    end_i = 13;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 2;    end_i = 12;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 3;    end_i = 11;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 4;    end_i = 10;    for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 5;    end_i = 9;     for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        j++;    start_i = 6;    end_i = 8;     for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        
        j++;    start_i = 7;    end_i = 7;     for (i = start_i; i <= end_i; i+=offset) [t setPixelAt:ccp(i,j) rgba:color1];
        
        
        
        
    }
    
    else if ( patternID == 2 ) {
        int i = 0, j = 0;
        for (i=6; i<=12; i+=offset)
            for (j=0; j<=t.contentSizeInPixels.height; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
        
        for (i=0; i<=t.contentSizeInPixels.width; i+=offset)
            for (j=6; j<=12; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
    }
    
    else if ( patternID == 3 ) {
        int i = 0, j = 0;
        for (i=8; i<=10; i+=offset)
            for (j=0; j<=t.contentSizeInPixels.height; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
        
        for (i=0; i<=t.contentSizeInPixels.width; i+=offset)
            for (j=8; j<=10; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
    }
    
    else if ( patternID == 4 ) {
        int i = 0, j = 0;
        for (i=2; i<=14; i+=offset)
            for (j=0; j<=t.contentSizeInPixels.height; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
        
        for (i=0; i<=t.contentSizeInPixels.width; i+=offset)
            for (j=2; j<=14; j+=offset)
                [t setPixelAt:ccp(i,j) rgba:color1];
    }
    
    
    
    
    
    
    
    
    [ t apply ];
    
    return t;
}



+(CCMutableTexture2D *) heartWithColors: (Color_t) c0 c1: (Color_t) c1 c2: (Color_t) c2 {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    Color_t bg = c0, outer = c1, inner = c2;
    [t fill:bg];
    for ( int i = 0; i < 9; i++) {
        [t setPixelAt:ccp(i,0) rgba: i == 0 ? bg : i <= 3 ? outer : i == 4 ? bg : i <= 7 ? outer : i == 8 ? bg : clear ];
        [t setPixelAt:ccp(i,1) rgba: i == 0 ? outer : i <= 3 ? inner   : i == 4 ? outer : i <= 7 ? inner   : i == 8 ? outer : clear ];
        [t setPixelAt:ccp(i,2) rgba: i == 0 ? outer : i <= 7 ? inner   : i == 8 ? outer : clear];
        [t setPixelAt:ccp(i,3) rgba: i == 0 ? outer : i <= 7 ? inner   : i == 8 ? outer : clear];
        i >= 1 && i < 8 ? [t setPixelAt:ccp(i,4) rgba: i == 1 ? outer : i <= 6 ? inner : i == 7 ? outer : clear] : 0;
        i >= 2 && i < 7 ? [t setPixelAt:ccp(i,5) rgba: i == 2 ? outer : i <= 5 ? inner : i == 6 ? outer : clear] : 0;
        i >= 3 && i < 6 ? [t setPixelAt:ccp(i,6) rgba: i == 3 ? outer : i == 4 ? inner : i == 5 ? outer : clear] : 0;
    }
    [t setPixelAt:ccp(4,7) rgba:outer];
    [ t apply ];
    return t;
}



+(CCMutableTexture2D *) voidTile {
    //CCMutableTexture2D *t = [self heartWithColors:white c1:black c2:red];
    //CCMutableTexture2D *t = [self heartWithColors:black c1:red c2:red];
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
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





+(CCMutableTexture2D *) heroForPC: (Entity *) pc {
    
    BOOL hasChestArmor   = [[pc.equipment objectAtIndex: EQUIPSLOT_T_CHEST] isKindOfClass:NSClassFromString(@"Entity")],
    hasLeftArmTool       = [[pc.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity")],
    hasRightArmTool      = [[pc.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL] isKindOfClass:NSClassFromString(@"Entity")],
    hasHelmet            = [[pc.equipment objectAtIndex: EQUIPSLOT_T_HEAD] isKindOfClass:NSClassFromString(@"Entity")];
    
    int pad = 2;
 
    Color_t armorColor = hasChestArmor ? brown : skincolor0;
    Color_t pantsColor = gray;
    
    CCMutableTexture2D *hero = [Drawer guy:skincolor0 body:armorColor pants: pantsColor blindfolded: NO];
    
    if ( hasChestArmor ) {
        Entity *armor = [pc.equipment objectAtIndex: EQUIPSLOT_T_CHEST];
        if ( [armor.name isEqualToString:@"Cloth Robe"] ) {
            armorColor = gray;
            pantsColor = gray;
        }
        else {
            armorColor = brown;
            pantsColor = gray;
        }
        hero = [Drawer guy:skincolor0 body:armorColor pants:pantsColor blindfolded:NO];
        
    }
    
    if ( hasHelmet ) {
        Entity *helmet = [pc.equipment objectAtIndex: EQUIPSLOT_T_HEAD];
        if ( [helmet.name isEqualToString:@"Blindfold"] ) {
            hero = [Drawer guy:skincolor0 body:armorColor pants: pantsColor blindfolded: YES];
        }
    }
    
    if ( hasLeftArmTool ) {
        Entity *leftArmTool  = [pc.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL];
        if ( leftArmTool.itemType == E_ITEM_T_WEAPON ) {
        // draw a tiny sword since thats all we have right now
        Color_t swordColor = white;
            swordColor = [leftArmTool.name isEqualToString:@"Asura"] ? red :
            leftArmTool.wood > 0 ? brown :
            
            leftArmTool.metal > 0 ?
                (leftArmTool.metal == METAL_T_IRON ? gray :
                 leftArmTool.metal == METAL_T_STEEL ? darkgray :
                 gray) :
        
            leftArmTool.stone > 0 ? gray :
            white;
            
            
        Color_t armColor = armorColor;
        for (int i=9+pad; i<11+pad; i++) [hero setPixelAt:ccp(i,7) rgba:armColor];
        for (int j=0; j<10; j++) [hero setPixelAt:ccp(11+pad,j) rgba:swordColor];
        for (int i=10+pad; i<13+pad; i++) [hero setPixelAt:ccp(i,6) rgba:swordColor];
        //[hero apply];
        }
        
        else if ( leftArmTool.itemType == E_ITEM_T_ARMOR ) {
            if ( leftArmTool.armorType == ARMOR_T_SHIELD ) {
                Color_t shieldColor = brown;
                Color_t emblemColor = yellow;
                
                int pad_x = 7;
                int start_x = 3+pad_x,  start_y = 4;
                int end_x   = 7+pad_x,  end_y   = 12;
                
                // shield body
                for (int i=start_x; i<end_x; i++) {
                    for (int j=start_y; j<end_y; j++) {
                        [hero setPixelAt:ccp(i,j) rgba:shieldColor];
                    }
                }
                
                // emblem
                for (int j=start_y; j<end_y; j++)
                    [hero setPixelAt:ccp((start_x+end_x)/2,j) rgba:emblemColor];
                for (int i=start_x; i<end_x; i++)
                    [hero setPixelAt:ccp(i,(start_y+end_y)/2) rgba:emblemColor];
                
                //[hero apply];
            }
        }
    }
    
    if ( hasRightArmTool ) {
        
        Entity *rightArmTool  = [pc.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL];
        // draw a tiny sword since thats all we have right now
        
        if ( rightArmTool.itemType == E_ITEM_T_WEAPON ) {
            
            Color_t swordColor = white;
                swordColor = [rightArmTool.name isEqualToString:@"Asura"] ? red :
                rightArmTool.wood > 0 ? brown :
            
                rightArmTool.metal > 0 ?
                (rightArmTool.metal == METAL_T_IRON ? gray :
                 rightArmTool.metal == METAL_T_STEEL ? darkgray :
                 gray) :
            
                rightArmTool.stone > 0 ? gray :
                white;
            
            
            Color_t armColor = armorColor;
            for (int i=0+pad; i<2+pad; i++) [hero setPixelAt:ccp(i,7) rgba:armColor];
            for (int j=0; j<10; j++) [hero setPixelAt:ccp(0+pad,j) rgba:swordColor];
            for (int i=1; i<4; i++) [hero setPixelAt:ccp(i,6) rgba:swordColor];
          //  [hero apply];
            
        }
        
        else if ( rightArmTool.itemType == E_ITEM_T_ARMOR ) {
            
            if ( rightArmTool.armorType == ARMOR_T_SHIELD ) {
                
                Color_t shieldColor = brown;
                Color_t emblemColor = yellow;
                
                int start_x = 3,  start_y = 4;
                int end_x   = 7,  end_y   = 12;
                
                // shield body
                for (int i=start_x; i<end_x; i++) {
                    for (int j=start_y; j<end_y; j++) {
                        [hero setPixelAt:ccp(i,j) rgba:shieldColor];
                    }
                }
                
                // emblem
                for (int j=start_y; j<end_y; j++)
                    [hero setPixelAt:ccp((start_x+end_x)/2,j) rgba:emblemColor];
                for (int i=start_x; i<end_x; i++)
                    [hero setPixelAt:ccp(i,(start_y+end_y)/2) rgba:emblemColor];
                
                //[hero apply];
            }
        }
        
    }
    [hero apply];
    return hero;
}



+(CCMutableTexture2D *) monster {
    //CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    //[t fill:black_alpha(0)];
    //[t fill:red];
    //[ t apply ];
    //return t;
    return [Drawer marioWithSuitColor:green skinColor:skincolor3];
}


+(CCMutableTexture2D *) ghoulWithBody: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    // ghoul body
    Color_t c0 = body;
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



+(CCMutableTexture2D *) smallFish: (Color_t) body eyeColor:(Color_t)eyeColor {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    /*
     ................
     ................
     ................
     ................
     ................
     ................
     ...       ..  ..
     ..   #      ....
     ..          ....
     ...       ..  ..
     ................
     ................
     ................
     ................
     ................
     ................
     */
    int x = 2, y = 6;
    for (x=3;  x<10; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=13; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];  y = 7;
    for (x=2;  x<13; x++) [t setPixelAt:ccp(x,y) rgba:body];  y = 8;
    for (x=2;  x<13; x++) [t setPixelAt:ccp(x,y) rgba:body];  y = 9;
    for (x=3;  x<10; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=13; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];
    
    // eye color
    x = 5, y = 7;
    [t setPixelAt:ccp(5,7) rgba:eyeColor];
    return t;
}


+(CCMutableTexture2D *) fishingRod: (Color_t) rod {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    /*
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     ................
     */
    for (int y=0; y<15; y++)
        for (int x=8; x<10; x++)
            [t setPixelAt:ccp(x,y) rgba:rod];
    
    return t;
}



+(CCMutableTexture2D *) torch {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    /*
     ................
     ................
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     .......  .......
     ................
     */
    Color_t flame = yellow;
    Color_t handle = brown;
    
    for (int y=2; y<6; y++)
        for (int x=8; x<10; x++)
            [t setPixelAt:ccp(x,y) rgba:flame];
    
    for (int y=6; y<15; y++)
        for (int x=8; x<10; x++)
            [t setPixelAt:ccp(x,y) rgba:handle];
    return t;
}




+(CCMutableTexture2D *) tree {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    /*
     ................0
     ................1
     ...          ...2 start
     ...          ...3
     ...          ...4
     ...          ...5 end
     ..            ..6 start
     ..            ..7
     ..            ..8
     ..            ..9 end
     ...          ...A start/end
     .......  .......B
     .......  .......C
     ......    ......D
     ....        ....E
     ................F
     */
    Color_t leaves = darkgreen;
    Color_t bark   = brown;
    
    // leaves
    for (int y=2; y<6; y++)
        for (int x=3; x<12; x++)
            [t setPixelAt:ccp(x,y) rgba:leaves];
    for (int y=6; y<10; y++)
        for (int x=2; x<13; x++)
            [t setPixelAt:ccp(x,y) rgba:leaves];
    for (int y=10; y<11; y++)
        for (int x=3; x<12; x++)
            [t setPixelAt:ccp(x,y) rgba:leaves];
    
    // bark
    for (int y=11; y<13; y++)
        for (int x=7; x<9; x++)
            [t setPixelAt:ccp(x,y) rgba:bark];
    for (int y=13; y<14; y++)
        for (int x=6; x<10; x++)
            [t setPixelAt:ccp(x,y) rgba:bark];
    for (int y=14; y<15; y++)
        for (int x=4; x<12; x++)
            [t setPixelAt:ccp(x,y) rgba:bark];
    return t;
}















+(CCMutableTexture2D *) boulder: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     ................
     ..            ..
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     .              .
     ..            ..
     ................
     */
    for (int y=1; y<14; y++)
        for (int x=2; x<13; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    for (int y=2; y<13; y++)
        for (int x=1; x<14; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}



+(CCMutableTexture2D *) totoro: (Color_t) body eyes: (Color_t) eyes {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     ................
     .... ...... ....
     ...   ....   ...
     ..     ..     ..
     ..            ..
     ..            ..
     ..   .    .   ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ..            ..
     ................
     ................
     
     */
    [t setPixelAt:ccp(4,1) rgba:body];
    [t setPixelAt:ccp(11,1) rgba:body];
    for (int x=3; x<6; x++) {
        [t setPixelAt:ccp(x,2) rgba:body];
        [t setPixelAt:ccp(x+7,2) rgba:body];
    }
    for (int x=2; x<7; x++) {
        [t setPixelAt:ccp(x,3) rgba:body];
        [t setPixelAt:ccp(x+7,3) rgba:body];
    }
    for (int y=4; y<14; y++)
        for (int x=2; x<14; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    [t setPixelAt:ccp(5,6) rgba:eyes];
    [t setPixelAt:ccp(10,6) rgba:eyes];
    return t;
}



+(CCMutableTexture2D *) wyvern: (Color_t) body eyes: (Color_t) eyes {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     .........   .... 1
     ..        ..  .. 2
     .    .  ..... .. 3
     ..      ........ 4
     ..  .   ........ 5
     .....   ........ 6
     ....   ......... 7
     ...   ...    ... 8
     ..   ...      .. 9
     ...       .    . A
     ...      ..    . B
     ...      .    .. C
     ..           ... D
     ................ E
     ................ F
     
     */
    
    
    Color_t horns = white;
    int x=0, y=1;
    
    x=2; y=3; [t setPixelAt:ccp(x,y) rgba:eyes];
    x=3; y=3; [t setPixelAt:ccp(x,y) rgba:eyes];
    
    x=5; y=3; [t setPixelAt:ccp(x,y) rgba:eyes];
    x=6; y=3; [t setPixelAt:ccp(x,y) rgba:eyes];
    y=1;
    for (x=9; x<0xD; x++) [t setPixelAt:ccp(x,y) rgba:horns];
    y=2;
    for (x=2; x<0x8; x++) [t setPixelAt:ccp(x,y) rgba:body];
    x=8;   [t setPixelAt:ccp(x,y) rgba:horns];
    x=9;   [t setPixelAt:ccp(x,y) rgba:horns];
    x=0xC; [t setPixelAt:ccp(x,y) rgba:horns];
    x=0xD; [t setPixelAt:ccp(x,y) rgba:horns];
    y=3;
    for (x=1; x<8; x++) [t setPixelAt:ccp(x,y) rgba:body];
    x=0xD;
    [t setPixelAt:ccp(x,y) rgba:horns];
    y=4;
    for (x=2; x<8; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=5;
    for (x=2; x<8; x++) if (x!=4) [t setPixelAt:ccp(x,y) rgba:body];
    y=6;
    for (x=5; x<8; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=7;
    for (x=4; x<7; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=8;
    for (x=3; x<6; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=9; x<13; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=9;
    for (x=2; x<5; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=8; x<14; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=10;
    for (x=3; x<10; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=11; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=11;
    for (x=3; x<9; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=11; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=12;
    for (x=3; x<9; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=10; x<14; x++) [t setPixelAt:ccp(x,y) rgba:body];
    y=13;
    for (x=2; x<13; x++) [t setPixelAt:ccp(x,y) rgba:body];
    
    return t;
}



+(CCMutableTexture2D *) gelatinousCube: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ..            .. 2
     ..            .. 3
     ..            .. 4
     ..            .. 5
     ..            .. 6
     ..            .. 7
     ..            .. 8
     ..            .. 9
     ..            .. A
     ..            .. B
     ..            .. C
     ..            .. D
     ................ E
     ................ F
     */
    int x=0, y=0, x0=2, y0=2, x1=0xE, y1=0xE;
    for (y=y0; y<y1; y++)
        for (x=x0; x<x1; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}




+(CCMutableTexture2D *) triangle: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ....... ........ 3
     ......   ....... 4
     .....     ...... 5
     ....       ..... 6
     ...         .... 7
     ..           ... 8
     .             .. 9
     . A
     ................ B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    int x = 0, y = 0, x0 = 7, y0 = 3, x1 = 7, y1 = 0xB;
    
    for (y = y0; y <= y1; y++) {
        for (x = x0; x <= x1; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
        x0--;
        x1++;
    }
    
    return t;
}



+(CCMutableTexture2D *) door: (Color_t) body knob: (Color_t) knob {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     ................ 4
     ................ 5
     ................ 6
     ................ 7
     ................ 8
     ................ 9
     ................ A
     ................ B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    [t fill:body];
    for (int y=6; y<8; y++ )
        for (int x=12; x<14; x++)
            [t setPixelAt:ccp(x,y) rgba:knob];
    return t;
}




+(CCMutableTexture2D *) opendoor: (Color_t) body knob: (Color_t) knob {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     ................ 4
     ................ 5
     ................ 6
     ................ 7
     ................ 8
     ................ 9
     ................ A
     ................ B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    for (int y=0; y<16; y++)
        for (int x=0; x<6; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    
    for (int y=6; y<8; y++ )
        for (int x=4; x<6; x++)
            [t setPixelAt:ccp(x,y) rgba:knob];
    return t;
}




+(CCMutableTexture2D *) key: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     ............ ... 4
     ...........   .. 5
     .           .  . 6
     .           .  . 7
     . ... .....   .. 8
     . ... .......... 9
     . ... .......... A
     . ... .......... B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    
    int x=0, y=0;
    
    x=12, y=4;  [t setPixelAt:ccp(x,y) rgba:body];
    
    x=11, y=5;  [t setPixelAt:ccp(x,y) rgba:body];
    x=12, y=5;  [t setPixelAt:ccp(x,y) rgba:body];
    x=13, y=5;  [t setPixelAt:ccp(x,y) rgba:body];
    
    x=1, y=6;
    for (x=1;  x<12; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=13; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];
    
    x=1, y=7;
    for (x=1;  x<12; x++) [t setPixelAt:ccp(x,y) rgba:body];
    for (x=13; x<15; x++) [t setPixelAt:ccp(x,y) rgba:body];
    
    x=1, y=8;  [t setPixelAt:ccp(x,y) rgba:body];
    x=5, y=8;  [t setPixelAt:ccp(x,y) rgba:body];
    
    x=11, y=8;  [t setPixelAt:ccp(x,y) rgba:body];
    x=12, y=8;  [t setPixelAt:ccp(x,y) rgba:body];
    x=13, y=8;  [t setPixelAt:ccp(x,y) rgba:body];
    
    x=12, y=9;  [t setPixelAt:ccp(x,y) rgba:body];
    
    x=1, y=9;  [t setPixelAt:ccp(x,y) rgba:body];
    x=5, y=9;  [t setPixelAt:ccp(x,y) rgba:body];
    x=1, y=10;  [t setPixelAt:ccp(x,y) rgba:body];
    x=5, y=10;  [t setPixelAt:ccp(x,y) rgba:body];
    x=1, y=11;  [t setPixelAt:ccp(x,y) rgba:body];
    x=5, y=11;  [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}



+(CCMutableTexture2D *) stoneTileTrap {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    
    Color_t c0 = gray;
    Color_t c1 = darkgray;
    
    [t fill:c0];
    for (int j=0; j<16; j+=2)
        for (int i=0; i<16; i++)
            [t setPixelAt:ccp(i,j) rgba:c1];
    for (int i=0; i<16; i+=2)
        for (int j=0; j<16; j++)
            [t setPixelAt:ccp(i,j) rgba:c1];
    
    for (int j=7; j<11; j++)
        for (int i=7; i<11; i++)
            [t setPixelAt:ccp(i,j) rgba:c0];
    
    [ t apply ];
    
    return t;
}





+(CCMutableTexture2D *) scroll: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     ................ 4
     ................ 5
     ................ 6
     ..            .. 7
     ..            .. 8
     ................ 9
     ................ A
     ................ B
     ................ B
     ................ B
     ................ B
     ................ B
     */
    int x=0, y=0, x0=2, y0=7, x1=0xE, y1=9;
    for (y=y0; y<y1; y++)
        for (x=x0; x<x1; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}


+(CCMutableTexture2D *) blindfold: (Color_t) body {
    return [Drawer scroll: body];
}





+(CCMutableTexture2D *) scroll2: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     ................ 4
     ................ 5
     ..            .. 6
     ..            .. 7
     ..            .. 8
     ..            .. 9
     ................ A
     ................ B
     ................ B
     ................ B
     ................ B
     ................ B
     */
    int x=0, y=0, x0=2, y0=6, x1=0xE, y1=0xA;
    for (y=y0; y<y1; y++)
        for (x=x0; x<x1; x++)
            [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}









+(CCMutableTexture2D *) wand: (Color_t) body marking: (Color_t) marking {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ...  ........... 3
     ...  ........... 4
     .....  ......... 5
     .....  ......... 6
     ......  ........ 7
     ......  ........ 8
     ........  ...... 9
     ........  ...... 10
     .........  ..... 11
     .........  ..... 12
     ................ 13
     ................ 14
     ................ 15
     */
    int x = 3;
    for (int y=3; y<5; y++) {
        [t setPixelAt:ccp(x,y) rgba:body];
        [t setPixelAt:ccp(x+1,y) rgba:body];
    }
    x=5;
    for (int y=5; y<7; y++) {
        [t setPixelAt:ccp(x,y) rgba:body];
        [t setPixelAt:ccp(x+1,y) rgba:body];
    }
    x=7;
    for (int y=7; y<9; y++) {
        [t setPixelAt:ccp(x,y) rgba:body];
        [t setPixelAt:ccp(x+1,y) rgba:body];
    }
    x=9;
    for (int y=9; y<11; y++) {
        [t setPixelAt:ccp(x,y) rgba:body];
        [t setPixelAt:ccp(x+1,y) rgba:body];
    }
    x=11;
    for (int y=11; y<13; y++) {
        [t setPixelAt:ccp(x,y) rgba:body];
        [t setPixelAt:ccp(x+1,y) rgba:body];
    }
    return t;
}




+(CCMutableTexture2D *) ring: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     .....      ..... 4
     ....  ....  .... 5
     ...  ......  ... 6
     ...  ......  ... 7
     ....  ....  .... 8
     .....      ..... 9
     ................ A
     ................ B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    
    int x = 0, y = 0;
    
    y=4;    for (x=5;  x<11; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    y=5;    for (x=4;  x<6;  x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=5;    for (x=10; x<12; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    y=6;    for (x=3;  x<5;  x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=6;    for (x=11; x<13; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    y=7;    for (x=3;  x<5;  x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=7;    for (x=11; x<13; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    y=8;    for (x=4;  x<6;  x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=8;    for (x=10; x<12; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    y=9;    for (x=5;  x<11; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    
    return t;
}



+(CCMutableTexture2D *) coin: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill: black_alpha(0)];
    /*
     0123456789ABCDEF
     ................ 0
     ................ 1
     ................ 2
     ................ 3
     .....      ..... 4
     ....        .... 5
     ...          ... 6
     ...          ... 7
     ....        .... 8
     .....      ..... 9
     ................ A
     ................ B
     ................ C
     ................ D
     ................ E
     ................ F
     */
    int x = 0, y = 0;
    y=4;    for (x=5;  x<11; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=5;    for (x=4;  x<12; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=6;    for (x=3;  x<13; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=7;    for (x=3;  x<13; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=8;    for (x=4;  x<12; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    y=9;    for (x=5;  x<11; x++)    [t setPixelAt:ccp(x,y) rgba:body];
    return t;
}


+(CCMutableTexture2D *) vest: (Color_t) body {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    [t fill:black_alpha(0)];
    for (int i=2; i<14; i++)
        for (int j=2; j<14; j++)
            [t setPixelAt:ccp(i,j) rgba:body];
    [ t apply ];
    return t;
}






#pragma mark - Experimental code/drawing stuff

+(NSString *) codeForPos: (CGPoint) p color: (Color_t) c {
    return [NSString stringWithFormat:@"setPixel %.0f %.0f %d %d %d %d", p.x, p.y, c.r, c.g, c.b, c.a];
}

+(NSArray *) codeForTexture: (CCMutableTexture2D *) t {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<16; i++) {
        for (int j=0; j<16; j++) {
            NSString *code = [self codeForPos:ccp(i,j) color:[t pixelAt:ccp(i,j)]];
            [array addObject: code];
        }
    }
    
    return array;
}

+(void) executeCodeForTexture: (CCMutableTexture2D *) t code: (NSString *) code {
    // setPixel
    if ( [code hasPrefix:@"setPixel"] ) {
        NSString *paramsStr = [code substringFromIndex:8];
        
        NSArray *params = [paramsStr componentsSeparatedByString:@" "];
        CGFloat x = [[params objectAtIndex:0] intValue];
        CGFloat y = [[params objectAtIndex:1] intValue];
        GLubyte r = [[params objectAtIndex:2] intValue];
        GLubyte g = [[params objectAtIndex:3] intValue];
        GLubyte b = [[params objectAtIndex:4] intValue];
        GLubyte a = [[params objectAtIndex:5] intValue];
    
        // assuming all's well...
        [t setPixelAt:ccp(x,y) rgba:ccc4(r, g , b , a)];
    }
}

+(void) executeCodesForTexture: (CCMutableTexture2D *) t codes: (NSArray *) codes {
    for (NSString *code in codes) {
        [self executeCodeForTexture:t code:code];
    }
}

@end