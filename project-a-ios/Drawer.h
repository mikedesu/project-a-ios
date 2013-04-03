//  Drawer.h
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@class Entity;

@interface Drawer : NSObject {}

+(CCMutableTexture2D *) chicken;
+(CCMutableTexture2D *) smallBlob: (Color_t) blobColor ;
+(CCMutableTexture2D *) guy: (Color_t) head body: (Color_t) body pants: (Color_t) pants ;

+(CCMutableTexture2D *) heartWithColors: (Color_t) c0 c1: (Color_t) c1 c2: (Color_t) c2;

+(CCMutableTexture2D *) basicPotionWithColor: (Color_t) liquidColor;
+(CCMutableTexture2D *) basicSwordWithColor:  (Color_t) bladeColor    withHandleColor: (Color_t) handleColor;
+(CCMutableTexture2D *) basicShieldWithColor: (Color_t) baseColor     withEmblemColor: (Color_t) emblemColor;

+(CCMutableTexture2D *) stoneTile;
+(CCMutableTexture2D *) voidTile;
+(CCMutableTexture2D *) upstairsTile;
+(CCMutableTexture2D *) downstairsTile;

+(CCMutableTexture2D *) bookOfAllKnowing;

//+(CCMutableTexture2D *) mario;
+(CCMutableTexture2D *) marioWithSuitColor: (Color_t) suitColor     skinColor: (Color_t) skinColor;

//+(CCMutableTexture2D *) hero;

+(CCMutableTexture2D *) heroForPC: (Entity *) pc ;

+(CCMutableTexture2D *) monster;
+(CCMutableTexture2D *) ghoulWithBody: (Color_t) body;

+(CCMutableTexture2D *) statusIcon;
+(CCMutableTexture2D *) itemIcon;

+(NSString *) codeForPos: (CGPoint) p color: (Color_t) c;
+(NSArray *) codeForTexture: (CCMutableTexture2D *) t;

@end
