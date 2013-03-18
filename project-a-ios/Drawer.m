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



+(CCMutableTexture2D *) guy: (Color_t) head body: (Color_t) body pants: (Color_t) pants {
    CCMutableTexture2D *t = [CCMutableTexture2D textureWithSize:CGSizeMake(16, 16)];
    
    // need head
    int x0 = 2, y0 = 0;
    int x1 = 7, y1 = 5;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:head];
    
    // need eyes
    x0 = 3, y0 = 2;
    x1 = 5, y1 = 2;
    [t setPixelAt:ccp(x0,y0) rgba:black];
    [t setPixelAt:ccp(x1,y1) rgba:black];
    
    
    // need body
    x0 = 1, y0 = 5;
    x1 = 8, y1 = 12;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:body];
    
    // need legs
    x0 = 1, y0 = 12;
    x1 = 8, y1 = 16;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:pants];
    
    // need split in legs
    x0 = 4, y0 = 14;
    x1 = 5, y1 = 16;
    
    for (int i=x0; i<x1; i++)
        for (int j=y0; j<y1; j++)
            [t setPixelAt:ccp(i,j) rgba:clear];
    
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


+(CCMutableTexture2D *) stoneTile {
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
    BOOL hasArmor   = pc.equippedArmorChest != nil,
    hasWeapon       = pc.equippedArmsLeft   != nil;
 
    Color_t pants = gray;
    
    CCMutableTexture2D *hero = [Drawer guy:skincolor0 body:skincolor0 pants: pants];
    
    if ( hasArmor )
        hero = [Drawer guy:skincolor0 body:brown pants: pants];
    if ( hasWeapon ) {
        // draw a tiny sword since thats all we have right now
        Color_t sword = white;
        Color_t arm = hasArmor ? brown : skincolor0;
        for (int i=8; i<11; i++) [hero setPixelAt:ccp(i,7) rgba:arm];
        
        for (int j=0; j<10; j++) [hero setPixelAt:ccp(11,j) rgba:sword];
        for (int i=10; i<13; i++) [hero setPixelAt:ccp(i,6) rgba:sword];
        [hero apply];
    }
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