//  Drawer.h
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@class Entity;

@interface Drawer : NSObject {}

+(CCMutableTexture2D *) chicken;
+(CCMutableTexture2D *) tree;
+(CCMutableTexture2D *) smallBlob: (Color_t) blobColor ;
+(CCMutableTexture2D *) guy: (Color_t) head body: (Color_t) body pants: (Color_t) pants blindfolded: (BOOL) isBlindfolded;

+(CCMutableTexture2D *) cat: (Color_t) body eyes: (Color_t) eyes;

+(CCMutableTexture2D *) heartWithColors: (Color_t) c0 c1: (Color_t) c1 c2: (Color_t) c2;

+(CCMutableTexture2D *) basicPotionWithColor: (Color_t) liquidColor;
+(CCMutableTexture2D *) basicSwordWithColor:  (Color_t) bladeColor    withHandleColor: (Color_t) handleColor;
+(CCMutableTexture2D *) basicShieldWithColor: (Color_t) baseColor     withEmblemColor: (Color_t) emblemColor;


+(CCMutableTexture2D *) stoneTileColor0: (Color_t) color0 Color1: (Color_t) color1 Pattern: (int) patternID;
    +(CCMutableTexture2D *) stoneTileTrap;
+(CCMutableTexture2D *) flatTile: (Color_t) tileColor;

+(CCMutableTexture2D *) grassTile: (int) style c0:(Color_t) c0 c1:(Color_t) c1;

    +(CCMutableTexture2D *) voidTile;
+(CCMutableTexture2D *) upstairsTile;
+(CCMutableTexture2D *) downstairsTile;

+(CCMutableTexture2D *) bookOfAllKnowing;

+(CCMutableTexture2D *) marioWithSuitColor: (Color_t) suitColor     skinColor: (Color_t) skinColor;

+(CCMutableTexture2D *) heroForPC: (Entity *) pc ;

+(CCMutableTexture2D *) monster;
+(CCMutableTexture2D *) ghoulWithBody: (Color_t) body;

+(CCMutableTexture2D *) statusIcon;
+(CCMutableTexture2D *) itemIcon;

+(CCMutableTexture2D *) smallFish: (Color_t) body eyeColor: (Color_t) eyeColor;
+(CCMutableTexture2D *) fishingRod: (Color_t) rod;
+(CCMutableTexture2D *) torch;
    
+(CCMutableTexture2D *) boulder: (Color_t) body;

+(CCMutableTexture2D *) totoro: (Color_t) body eyes: (Color_t) eyes;

+(CCMutableTexture2D *) wyvern: (Color_t) body eyes: (Color_t) eyes;
+(CCMutableTexture2D *) gelatinousCube: (Color_t) body;
+(CCMutableTexture2D *) triangle: (Color_t) body;

+(CCMutableTexture2D *) door: (Color_t) body knob: (Color_t) knob;
+(CCMutableTexture2D *) opendoor: (Color_t) body knob: (Color_t) knob;

+(CCMutableTexture2D *) key: (Color_t) body;

+(CCMutableTexture2D *) scroll: (Color_t) body;
+(CCMutableTexture2D *) scroll2: (Color_t) body;
+(CCMutableTexture2D *) blindfold: (Color_t) body;


+(CCMutableTexture2D *) wand: (Color_t) body marking: (Color_t) marking;
+(CCMutableTexture2D *) ring: (Color_t) body;

+(CCMutableTexture2D *) coin: (Color_t) body;

+(CCMutableTexture2D *) vest: (Color_t) body;

+(NSString *) codeForPos: (CGPoint) p color: (Color_t) c;
+(NSArray *) codeForTexture: (CCMutableTexture2D *) t;

@end
