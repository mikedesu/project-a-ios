//  Drawer.h
//  project-a-ios
//
//  Created by Mike Bell on 3/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@interface Drawer : NSObject {}

+(CCMutableTexture2D *) basicSwordWithColor: (Color_t) bladeColor withHandleColor: (Color_t) handleColor;
+(CCMutableTexture2D *) basicShieldWithColor: (Color_t) baseColor withEmblemColor: (Color_t) emblemColor;

+(CCMutableTexture2D *) stoneTile;
+(CCMutableTexture2D *) voidTile;
+(CCMutableTexture2D *) upstairsTile;
+(CCMutableTexture2D *) downstairsTile;

+(CCMutableTexture2D *) bookOfAllKnowing;

//+(CCMutableTexture2D *) mario;
+(CCMutableTexture2D *) marioWithSuitColor: (Color_t) suitColor skinColor: (Color_t) skinColor;

+(CCMutableTexture2D *) hero;
+(CCMutableTexture2D *) monster;


@end
