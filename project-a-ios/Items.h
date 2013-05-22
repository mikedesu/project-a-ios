//  Items.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@interface Items : NSObject { }
+(Entity *) randomItem;
+(Entity *) bookOfAllKnowing;
+(Entity *) potionOfLightHealing:(NSInteger) bonus;
+(Entity *) poisonAntidote;
+(Entity *) greenBlob;

// Fishing
+(Entity *) catfish;
+(Entity *) woodenFishingRod;

// Doors
+(Entity *) simpleDoor;
+(Entity *) simpleKey;
+(Entity *) basicBoulder;

+(Entity *) scrollOfCureLightWounds;
@end